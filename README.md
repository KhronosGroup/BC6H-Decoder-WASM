<!-- Copyright 2020 The Khronos Group Inc. -->
<!-- -->
<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# WebAssembly BC6H Decoder

![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)
[![CI](https://github.com/KhronosGroup/BC6H-Decoder-WASM/workflows/CI/badge.svg?branch=main&event=push)](https://github.com/KhronosGroup/BC6H-Decoder-WASM/actions?query=workflow%3ACI)

A collection of optimized WebAssembly decoders for [BC6H unsigned](https://www.khronos.org/registry/DataFormat/specs/1.3/dataformat.1.3.html#bptc_bc6h) GPU compressed HDR texture format.

These decoders are intended to be used in environments where hardware decompression of BC6H data is not available, e.g. in CLI applications or when the [`EXT_texture_compression_bptc`](https://www.khronos.org/registry/webgl/extensions/EXT_texture_compression_bptc/) WebGL extension is unsupported.

These decoders accept only low-level compressed payloads. Containers such as `.dds` or `.ktx2` ([KTX](https://github.khronos.org/KTX-Specification/)) should first be parsed by other means, then decompressed with this library.

## Build

Pre-built WebAssembly binary modules (`*.wasm`) are maintained in the `build/` directory of this repository. To rebuild them from the source files, follow these steps.

1. Ensure that [Node.js](https://nodejs.org/) runtime is installed.

2. After cloning this repository, run
   ```
   $ npm install
   ```

3. After all the dependencies are fetched, run
   ```
   $ npm run asbuild
   ```

4. Built decoders will be available in the `build/` directory.

## Overview

Decoders accept only raw BC6H blocks. Zstandard or zlib/deflate compression (if present) must be decoded in advance.

Each 16-byte BC6H block is decoded to 64-192 bytes of uncompressed floating-point data, depending on a chosen target format. An application should choose the target format based on the runtime requirements and capabilities. Available targets include:

### Half-Precision Float (RGBA16F)

* 8 bytes per pixel uncompressed floating-point RGBA format.
* Alpha channel is set to `1.0` for all pixels.
* Decoded data could be used in WebGL 2.0 or in WebGL 1.0 with [`OES_texture_half_float`](https://www.khronos.org/registry/webgl/extensions/OES_texture_half_float/) extension.
* Decoding to this format fully preserves original BC6H precision and range (`[0.0 … 65504.0]`).
* Due to high memory usage, this target format should be used only when other decode targets are not available (i.e. on WebGL 1.0) or when lossless decoding is absolutely required.

### Packed Float (R11FG11FB10F)

* 4 bytes per pixel packed floating-point RGB format.
* Decoded data could be used only in WebGL 2.0 contexts.
* This format has slightly smaller ranges and reduced precision compared to the original BC6H data.
* Due to the asymmetry of color channels, grayscale pixels may yield visible discoloration (blue/yellow) starting around `0.5`.
* Three decoder modules are available with slightly different tradeoffs:
  - `bc6hu-r11fg11fb10f_trunc.wasm`
    - Fast processing at a cost of less accurate conversion.
    - Red and green values are clamped to `[0.0 … 65024.0]`; blue values are clamped to `[0.0 … 64512.0]`.
  - `bc6hu-r11fg11fb10f_round.wasm`
    - Accurate conversion at a cost of slower processing.
    - Red and green values are clamped to `[0.0 … 65024.0]`; blue values are clamped to `[0.0 … 64512.0]`.
  - `bc6hu-r11fg11fb10f_round_noclamp.wasm`
    - Faster conversion than the previous option at a cost of skipped clamping step.
    - Red and green values greater than `65024.0` or blue values greater than `64512.0` are mapped to positive infinity.
    - This is the best option when the compressed data stays within the aforementioned ranges or when the renderer is resilient to infinite values.

### Packed Shared Exponent Float (RGB9E5)

* 4 bytes per pixel packed floating-point RGB format.
* Decoded data could be used only in WebGL 2.0 contexts.
* Original BC6H values are clamped to `[0.0 … 65408.0]`.
* Due to shared exponent encoding, effective per-pixel precision depends on a channel having the maximum value.
* Although this target format takes more time to decode to, it may provide better quality than R11FG11FB10F.

### Single-Precision Float (RGB32F)

* 12 bytes per pixel uncompressed floating-point RGB format.
* Decoding to this format fully preserves original BC6H precision and range (`[0.0 … 65504.0]`).
* Although it's possible to use the decoded data in any WebGL context with [`OES_texture_float`](https://www.khronos.org/registry/webgl/extensions/OES_texture_float/) extension, this target format should only be used for CPU-side processing (e.g. via mapping the decompressed data with a [`Float32Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Float32Array)) as it provides no benefits over RGBA16F on the GPU side.

## Usage

1. For a single texture, the amount of the required memory should be calculated as:
    ```js
    const xBlocks = (width + 3) >> 2;
    const yBlocks = (height + 3) >> 2;
    const compressedByteLength = xBlocks * yBlocks * 16;

    // RGBA16F needs 8, RGB32F needs 12.
    const pixelByteLength = 4;

    // Uncompressed texture padded to multiple-of-4 height
    const uncompressedByteLength = width * yBlocks * 4 * pixelByteLength;
    const totalByteLength = compressedByteLength + uncompressedByteLength;
    ```

2. Create a [`WebAssembly.Memory`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory) object large enough to contain both the compressed and the uncompressed data. Its size is given in pages, each page is 65536 bytes. The zeroth page is reserved for the decoder's internal use, so the total amount of pages should be computed as:
    ```js
    const texMemoryPages = (totalByteLength + 65535) >> 16;
    const memory = new WebAssembly.Memory({ initial: texMemoryPages + 1 });
    ```

3. Create a view into the memory region that will be used for transferring compressed texture data. This step must be repeated after calling [`memory.grow`](
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory/grow), such as when allocating space for another, larger, texture.

    ```js
    let compressedTextureView = new Uint8Array(memory.buffer, 65536, compressedByteLength);
    ```

4. The memory could be populated with the BC6H data even before the decoder is ready.
    ```js
    compressedTextureView.set(compressedData /* Uint8Array */);
    ```

5. Create a view into the memory region that will be used for transferring the decoded texture data. This step must be repeated after calling [`memory.grow`](
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory/grow), such as when allocating space for another, larger, texture.

    ```js
    const textureByteLength = width * height * pixelByteLength;
    let decodedTextureView = new Uint8Array(memory.buffer, 65536 + compressedByteLength, textureByteLength);
    ```

6. Fetch and instantiate the decoder with the created memory. Note, that the example code uses [Fetch](https://fetch.spec.whatwg.org/) and [WebAssembly Web](https://webassembly.github.io/spec/web-api/index.html) APIs. Other JavaScript environments (such as Node.js) would need slightly different steps.
    ```js
    const decoder = (
        await WebAssembly.instantiateStreaming(
            fetch('bc6hu-rgb9e5.wasm'),
            { env: { memory } }
        )
    ).instance.exports;
    ```

7. For each new texture, call the exported `decode` function passing the texture dimensions. If they are negative or exceed the available memory, the function returns `1`. Otherwise, it performs the decoding and returns `0`. The decoded texture data will be available through the `decodedTextureView` memory view.
    ```js
    compressedTextureView.set(compressedData);
    if (decoder.decode(width, height) === 0) {
        // Use decodedTextureView data
    } else {
        // Wrong dimensions
    }
    ```

7. In a case when a new texture does not fit into the existing memory, the latter could be expanded by calling [`memory.grow`](
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory/grow). Note that the memory views would need to be recreated afterwards, by repeating step (3) and repeating step (5) in this case.
