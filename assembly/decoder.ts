// Copyright 2020 The Khronos Group Inc.
//
// SPDX-License-Identifier: Apache-2.0

// @ts-ignore
const kIsRGBA16F = MODE == 0;
// @ts-ignore
const kIsRGB9E5 = MODE == 1;
// @ts-ignore
const kIsRoundRG11FB10F = MODE == 2;
// @ts-ignore
const kIsTruncRG11FB10F = MODE == 3;
// @ts-ignore
const kIsRoundNoClampRG11FB10F = MODE == 4;
// @ts-ignore
const kIsRGB32F = MODE == 5;

if (!kIsRGBA16F &&
    !kIsRGB9E5 &&
    !kIsTruncRG11FB10F &&
    !kIsRoundRG11FB10F &&
    !kIsRoundNoClampRG11FB10F &&
    !kIsRGB32F) {
  ERROR('Decode mode is unspecified');
}

const kPixelLength = kIsRGBA16F ? 8 : (kIsRGB32F ? 12 : 4);

let firstRun = true;

/**
 * Decode BC6H data as RGBA16F
 * @param width - Texture width in pixels
 * @param height - Texture height in pixels
 */
export function decode(width: i32, height: i32): i32 {
  // Fail on negative dimensions
  if ((width | height) < 0) return 1;

  const xBlocks = (width + 3) >> 2;
  const yBlocks = (height + 3) >> 2;

  // Fail on insufficient memory
  const compressedByteLength = xBlocks * yBlocks * 16;
  const decompressedByteLength = width * (4 * yBlocks) * kPixelLength;
  const totalMemoryLength = compressedByteLength + decompressedByteLength;
  if ((memory.size() - 1) * 65536 < totalMemoryLength) {
    return 1;
  }

  const kUserDataOffset = 65536;

  if (firstRun) {
    // 4-bit weights
    // [0, 4, 9, 13, 17, 21, 26, 30, 34, 38, 43, 47, 51, 55, 60, 64]
    store<u64>(0, 0x1E1A15110D090400);
    store<u64>(8, 0x403C37332F2B2622);

    // 3-bit weights
    // [0, 9, 18, 27, 37, 46, 55, 64]
    store<u64>(16, 0x40372E251B120900);

    // Partition patterns
    store<u64>(32, 0xECC8EEEE8888CCCC,  0);
    store<u64>(32, 0xEC80FEC8FEECC880,  8);
    store<u64>(32, 0xE800FE80FFECC800, 16);
    store<u64>(32, 0xF000FFF0FF00FFE8, 24);
    store<u64>(32, 0x08CE7100008EF710, 32);
    store<u64>(32, 0x8CCE31007310008C, 40);
    store<u64>(32, 0x366C66663110088C, 48);
    store<u64>(32, 0x399C718E0FF017E8, 56);

    // Bit-reverse 6 bits for Mode 15
    store<u64>(96, 0x3818280830102000, 0);
    store<u64>(96, 0x3C1C2C0C34142404, 8);
    store<u64>(96, 0x3A1A2A0A32122202, 16);
    store<u64>(96, 0x3E1E2E0E36162606, 24);
    store<u64>(96, 0x3919290931112101, 32);
    store<u64>(96, 0x3D1D2D0D35152505, 40);
    store<u64>(96, 0x3B1B2B0B33132303, 48);
    store<u64>(96, 0x3F1F2F0F37172707, 56);

    // Precompute unquantized endpoints
    for (let w: u32 = 6, offset = 160; w < 13; w++) {
      const n: u32 = 1 << w;
      const lo: u32 = 1 << (15 - w);
      const hi: u32 = (((1 << w) - 1) << (16 - w)) | lo;
      for (let i: u32 = 0; i < n; i++) {
        let value: u32 = i << (16 - w);
        value |= value ? lo : 0;
        value = (value == hi) ? 65535 : value;
        store<u16>(offset + i * 2, value);
      }
      offset += n * 2;
    }

    firstRun = false;
  }

  const completeXBlocks = width >> 2;
  const extraByteLength = (width & 3) * kPixelLength;
  const uncompressedLineByteStride = width * kPixelLength;
  const writeSkip = uncompressedLineByteStride * 3 + extraByteLength;

  const compressedBlockSkip = extraByteLength ? 16 : 0;

  let readOffset = kUserDataOffset;
  let writeOffset = readOffset + compressedByteLength;

  for (let y = 0; y < yBlocks; y++) {
    for (let x = 0; x < completeXBlocks; x++) {
      decodeBlock(readOffset, writeOffset, uncompressedLineByteStride);
      readOffset += 16;
      writeOffset += 4 * kPixelLength;
    }
    readOffset += compressedBlockSkip;
    writeOffset += writeSkip;
  }

  // Image width is not a multiple of 4.
  if (extraByteLength) {
    readOffset = kUserDataOffset + completeXBlocks * 16;
    writeOffset = kUserDataOffset + compressedByteLength +
                  completeXBlocks * 4 * kPixelLength;

    const compressedBlockLineByteStride = xBlocks * 16;
    const uncompressedBlockLineByteStride = uncompressedLineByteStride * 4;

    for (let y = 0; y < yBlocks; y++) {
      const kOffset = 32768;
      // Decode to a temporary memory location and copy only needed pixels.
      decodeBlock(readOffset, kOffset, kPixelLength * 4);
      for (let x = 0; x < extraByteLength; x += kPixelLength) {
        let s = writeOffset;
        if (kPixelLength == 8) {
          store<u64>(s + x, load<u64>(x, kOffset));
          s += uncompressedLineByteStride;
          store<u64>(s + x, load<u64>(x, kOffset + kPixelLength * 4));
          s += uncompressedLineByteStride;
          store<u64>(s + x, load<u64>(x, kOffset + kPixelLength * 8));
          s += uncompressedLineByteStride;
          store<u64>(s + x, load<u64>(x, kOffset + kPixelLength * 12));
        } else if (kPixelLength == 4) {
          store<u32>(s + x, load<u32>(x, kOffset));
          s += uncompressedLineByteStride;
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 4));
          s += uncompressedLineByteStride;
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 8));
          s += uncompressedLineByteStride;
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 12));
        } else if (kPixelLength == 12) {
          store<u32>(s + x, load<u32>(x, kOffset));
          store<u32>(s + x, load<u32>(x, kOffset + 4), 4);
          store<u32>(s + x, load<u32>(x, kOffset + 8), 8);
          s += uncompressedLineByteStride;
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 4));
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 4 + 4), 4);
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 4 + 8), 8);
          s += uncompressedLineByteStride;
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 8));
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 8 + 4), 4);
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 8 + 8), 8);
          s += uncompressedLineByteStride;
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 12));
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 12 + 4), 4);
          store<u32>(s + x, load<u32>(x, kOffset + kPixelLength * 12 + 8), 8);
        } else {
          ERROR('Invalid kPixelLength.');
        }
      }
      readOffset  += compressedBlockLineByteStride;
      writeOffset += uncompressedBlockLineByteStride;
    }
  }
  return 0;
}

function decodeBlock(readOffset: i32, offset: i32, stride: i32): void {
  const q0 = load<u64>(readOffset, 0);
  const q1 = load<u64>(readOffset, 8);

  if (3 == (q0 & 3)) {
    decodeOneSubsetBlock(q0, q1, offset, stride);
  } else {
    decodeTwoSubsetBlock(q0, q1, offset, stride);
  }
}

// @ts-ignore
@inline
function decodeOneSubsetBlock(q0: u64, q1: u64, offset: i32, stride: i32): void {
  // One-subset modes always use lower 5 bits
  const mode = <i32>q0 & 0x1F;

  // 32-bit views into 64-bit inputs
  const d0 = <u32>q0;
  const d1 = <u32>(q0 >> 32);
  const d2 = <u32>q1;

  let r0: u32 = 0;
  let g0: u32 = 0;
  let b0: u32 = 0;

  let r1: u32 = 0;
  let g1: u32 = 0;
  let b1: u32 = 0;

  switch (mode) {
    case 3:
      // rgb0 - 10 bits
      // rgb1 - 10 bits

      r0 = (d0 >>  5) & 0x3FF;
      g0 = (d0 >> 15) & 0x3FF;
      b0 = <u32>((q0 >> 25) & 0x3FF);

      r1 = (d1 >>  3) & 0x3FF;
      g1 = (d1 >> 13) & 0x3FF;
      b1 = ((d2 << 9) & 0x200) | (d1 >> 23);

      r0 = unq(10, r0);
      g0 = unq(10, g0);
      b0 = unq(10, b0);

      r1 = unq(10, r1);
      g1 = unq(10, g1);
      b1 = unq(10, b1);
      break;
    case 7:
      // rgb0 - 11 bits
      // rgb1 -  9 bits (delta)

      r0 = ((d1 >>  2) & 0x400) | ((d0 >>  5) & 0x3FF);
      g0 = ((d1 >> 12) & 0x400) | ((d0 >> 15) & 0x3FF);
      b0 = ((d2 << 10) & 0x400) | <u32>((q0 >> 25) & 0x3FF);

      r1 = (r0 + signExtend(9, d1 >>  3)) & 0x7FF;
      g1 = (g0 + signExtend(9, d1 >> 13)) & 0x7FF;
      b1 = (b0 + signExtend(9, d1 >> 23)) & 0x7FF;

      r0 = unq(11, r0);
      g0 = unq(11, g0);
      b0 = unq(11, b0);

      r1 = unq(11, r1);
      g1 = unq(11, g1);
      b1 = unq(11, b1);
      break;
    case 11:
      // rgb0 - 12 bits
      // rgb1 -  8 bits (delta)

      r0 = (
        ((d1)      & 0x800) |
        ((d1 >> 2) & 0x400) |
        ((d0 >> 5) & 0x3FF)
      );
      g0 = (
        ((d1 >> 10) & 0x800) |
        ((d1 >> 12) & 0x400) |
        ((d0 >> 15) & 0x3FF)
      );
      b0 = (
        ((d1 >> 20) & 0x800) |
        ((d2 << 10) & 0x400) |
        <u32>((q0 >> 25) & 0x3FF)
      );

      r1 = (r0 + signExtend(8, d1 >>  3)) & 0xFFF;
      g1 = (g0 + signExtend(8, d1 >> 13)) & 0xFFF;
      b1 = (b0 + signExtend(8, d1 >> 23)) & 0xFFF;

      r0 = unq(12, r0);
      g0 = unq(12, g0);
      b0 = unq(12, b0);

      r1 = unq(12, r1);
      g1 = unq(12, g1);
      b1 = unq(12, b1);
      break;
    case 15:
      // rgb0 - 16 bits
      // rgb1 -  4 bits (delta)

      r0 = (
        (reverse6((d1 >>  7) & 0x3F) << 10) |
        ((d0 >>  5) & 0x3FF)
      );
      g0 = (
        (reverse6((d1 >> 17) & 0x3F) << 10) |
        ((d0 >> 15) & 0x3FF)
      );
      b0 = (
        ((reverse6(d1 >> 27) | (d2 & 1)) << 10) |
        <u32>((q0 >> 25) & 0x3FF)
      );

      r1 = (r0 + signExtend(4, d1 >>  3)) & 0xFFFF;
      g1 = (g0 + signExtend(4, d1 >> 13)) & 0xFFFF;
      b1 = (b0 + signExtend(4, d1 >> 23)) & 0xFFFF;

      // No need to unquantize 16-bit endpoints
      break;
  }

  let weights = (q1 & 0xFFFFFFFFFFFFFFF0) | ((q1 >> 1) & 7);

  const rs0 = r0 * 64 + 32;
  const gs0 = g0 * 64 + 32;
  const bs0 = b0 * 64 + 32;
  const rd0 = r1 - r0;
  const gd0 = g1 - g0;
  const bd0 = b1 - b0;

  for (let i = 0; i < 4; i++) {
    if (kIsRGBA16F) {
      store<u64>(offset, lerp1<u64>(rs0, gs0, bs0, rd0, gd0, bd0,
                                    <u32>weights & 0xF));
    } else if (kIsRGB32F) {
      const w = weight4(<u32>weights & 0xF);
      store<u32>(offset, lerpF32(rs0, rd0, w));
      store<u32>(offset, lerpF32(gs0, gd0, w), 4);
      store<u32>(offset, lerpF32(bs0, bd0, w), 8);
    } else {
      store<u32>(offset, lerp1<u32>(rs0, gs0, bs0, rd0, gd0, bd0,
                                    <u32>weights & 0xF));
    }
    weights >>= 4;

    if (kIsRGBA16F) {
      store<u64>(offset, lerp1<u64>(rs0, gs0, bs0, rd0, gd0, bd0,
                                    <u32>weights & 0xF), kPixelLength);
    } else if (kIsRGB32F) {
      const w = weight4(<u32>weights & 0xF);
      store<u32>(offset, lerpF32(rs0, rd0, w), kPixelLength);
      store<u32>(offset, lerpF32(gs0, gd0, w), kPixelLength + 4);
      store<u32>(offset, lerpF32(bs0, bd0, w), kPixelLength + 8);
    } else {
      store<u32>(offset, lerp1<u32>(rs0, gs0, bs0, rd0, gd0, bd0,
                                    <u32>weights & 0xF), kPixelLength);
    }
    weights >>= 4;

    if (kIsRGBA16F) {
      store<u64>(offset, lerp1<u64>(rs0, gs0, bs0, rd0, gd0, bd0,
                                    <u32>weights & 0xF), kPixelLength * 2);
    } else if (kIsRGB32F) {
      const w = weight4(<u32>weights & 0xF);
      store<u32>(offset, lerpF32(rs0, rd0, w), kPixelLength * 2);
      store<u32>(offset, lerpF32(gs0, gd0, w), kPixelLength * 2 + 4);
      store<u32>(offset, lerpF32(bs0, bd0, w), kPixelLength * 2 + 8);
    } else {
      store<u32>(offset, lerp1<u32>(rs0, gs0, bs0, rd0, gd0, bd0,
                                    <u32>weights & 0xF), kPixelLength * 2);
    }
    weights >>= 4;

    if (kIsRGBA16F) {
      store<u64>(offset, lerp1<u64>(rs0, gs0, bs0, rd0, gd0, bd0,
                                    <u32>weights & 0xF), kPixelLength * 3);
    } else if (kIsRGB32F) {
      const w = weight4(<u32>weights & 0xF);
      store<u32>(offset, lerpF32(rs0, rd0, w), kPixelLength * 3);
      store<u32>(offset, lerpF32(gs0, gd0, w), kPixelLength * 3 + 4);
      store<u32>(offset, lerpF32(bs0, bd0, w), kPixelLength * 3 + 8);
    } else {
      store<u32>(offset, lerp1<u32>(rs0, gs0, bs0, rd0, gd0, bd0,
                                    <u32>weights & 0xF), kPixelLength * 3);
    }
    weights >>= 4;
    offset += stride;
  }
}

// @ts-ignore
@inline
function decodeTwoSubsetBlock(q0: u64, q1: u64, offset: i32, stride: i32): void {
  const mode = <i32>q0 & ((q0 & 2) ? 0x1F : 3);

  // 32-bit views into 64-bit inputs
  const d0 = <u32>q0;
  const d1 = <u32>(q0 >> 32);
  const d2 = <u32>q1;

  let r0: u32 = 0;
  let g0: u32 = 0;
  let b0: u32 = 0;

  let r1: u32 = 0;
  let g1: u32 = 0;
  let b1: u32 = 0;

  let r2: u32 = 0;
  let g2: u32 = 0;
  let b2: u32 = 0;

  let r3: u32 = 0;
  let g3: u32 = 0;
  let b3: u32 = 0;

  switch (mode) {
    case 0:
      // rgb0 - 10 bits
      // rgb1, rgb2, rgb3 - 5 bits (delta)

      r0 = (d0 >>  5) & 0x3FF;
      g0 = (d0 >> 15) & 0x3FF;
      b0 = <u32>((q0 >> 25) & 0x3FF);

      r1 = r0 + signExtend(5, d1 >>  3);
      g1 = g0 + signExtend(5, d1 >> 13);
      b1 = b0 + signExtend(5, d1 >> 23);

      r2 = r0 + signExtend(5, d2 >> 1);
      g2 = g0 + signExtend(5, ((d0 << 2) & 0x10) | ((d1 >> 9) & 0xF));
      b2 = b0 + signExtend(5, (
        ((d0 <<  1) & 0x10) |
        ((d2 <<  3) & 0x08) |
        ((d1 >> 29))
      ));

      r3 = r0 + signExtend(5, d2 >> 7);
      g3 = g0 + signExtend(5, ((d1 >> 4) & 0x10) | ((d1 >> 19) & 0xF));
      b3 = b0 + signExtend(5, (
        ((d0      ) & 0x10) |
        ((d2 >>  9) & 0x08) |
        ((d2 >>  4) & 0x04) |
        ((d1 >> 27) & 0x02) |
        ((d1 >> 18) & 0x01)
      ));

      r0 = unq(10, r0);
      g0 = unq(10, g0);
      b0 = unq(10, b0);

      r1 = unq(10, r1 & 0x3FF);
      g1 = unq(10, g1 & 0x3FF);
      b1 = unq(10, b1 & 0x3FF);

      r2 = unq(10, r2 & 0x3FF);
      g2 = unq(10, g2 & 0x3FF);
      b2 = unq(10, b2 & 0x3FF);

      r3 = unq(10, r3 & 0x3FF);
      g3 = unq(10, g3 & 0x3FF);
      b3 = unq(10, b3 & 0x3FF);
      break;
    case 1:
      // rgb0 - 7 bits
      // rgb1, rgb2, rgb3 - 6 bits (delta)

      r0 = (d0 >>  5) & 0x7F;
      g0 = (d0 >> 15) & 0x7F;
      b0 = (d0 >> 25);

      r1 = r0 + signExtend(6, d1 >>  3);
      g1 = g0 + signExtend(6, d1 >> 13);
      b1 = b0 + signExtend(6, d1 >> 23);

      r2 = r0 + signExtend(6, d2 >> 1);
      g2 = g0 + signExtend(6, (
        ((d0 <<  3) & 0x20) |
        ((d0 >> 20) & 0x10) |
        ((d1 >>  9) & 0x0F)
      ));
      b2 = b0 + signExtend(6, (
        ((d0 >> 17) & 0x20) |
        ((d0 >> 10) & 0x10) |
        ((d2 <<  3) & 0x08) |
        ((d1 >> 29))
      ));

      r3 = r0 + signExtend(6, d2 >> 7);
      g3 = g0 + signExtend(6, ((d0 << 1) & 0x30) | ((d1 >> 19) & 0xF));
      b3 = b0 + signExtend(6, (
        ((d1 <<  4) & 0x20) |
        ((d1 <<  2) & 0x10) |
        ((d1 <<  3) & 0x08) |
        ((d0 >> 21) & 0x04) |
        ((d0 >> 12) & 0x03)
      ));

      r0 = unq(7, r0);
      g0 = unq(7, g0);
      b0 = unq(7, b0);

      r1 = unq(7, r1 & 0x7F);
      g1 = unq(7, g1 & 0x7F);
      b1 = unq(7, b1 & 0x7F);

      r2 = unq(7, r2 & 0x7F);
      g2 = unq(7, g2 & 0x7F);
      b2 = unq(7, b2 & 0x7F);

      r3 = unq(7, r3 & 0x7F);
      g3 = unq(7, g3 & 0x7F);
      b3 = unq(7, b3 & 0x7F);
      break;
    case 2:
      // rgb0 - 11 bits
      // r1, r2, r3 - 5 bits (delta)
      // g1, g2, g3 - 4 bits (delta)
      // b1, b2, b3 - 4 bits (delta)

      r0 = ((d1 <<  2) & 0x400) | ((d0 >>  5) & 0x3FF);
      g0 = ((d1 >>  7) & 0x400) | ((d0 >> 15) & 0x3FF);
      b0 = ((d1 >> 17) & 0x400) | <u32>((q0 >> 25) & 0x3FF);

      r1 = r0 + signExtend(5, d1 >>  3);
      g1 = g0 + signExtend(4, d1 >> 13);
      b1 = b0 + signExtend(4, d1 >> 23);

      r2 = r0 + signExtend(5, d2 >> 1);
      g2 = g0 + signExtend(4, d1 >> 9);
      b2 = b0 + signExtend(4, ((d2 << 3) & 8) | (d1 >> 29));

      r3 = r0 + signExtend(5, d2 >>  7);
      g3 = g0 + signExtend(4, d1 >> 19);
      b3 = b0 + signExtend(4, (
        ((d2 >>  9) & 8) |
        ((d2 >>  4) & 4) |
        ((d1 >> 27) & 2) |
        ((d1 >> 18) & 1)
      ));

      r0 = unq(11, r0);
      g0 = unq(11, g0);
      b0 = unq(11, b0);

      r1 = unq(11, r1 & 0x7FF);
      g1 = unq(11, g1 & 0x7FF);
      b1 = unq(11, b1 & 0x7FF);

      r2 = unq(11, r2 & 0x7FF);
      g2 = unq(11, g2 & 0x7FF);
      b2 = unq(11, b2 & 0x7FF);

      r3 = unq(11, r3 & 0x7FF);
      g3 = unq(11, g3 & 0x7FF);
      b3 = unq(11, b3 & 0x7FF);
      break;
    case 6:
      // rgb0 - 11 bits
      // r1, r2, r3 - 4 bits (delta)
      // g1, g2, g3 - 5 bits (delta)
      // b1, b2, b3 - 4 bits (delta)

      r0 = <u32>(((q0 >> 29) & 0x400) | ((q0 >>  5) & 0x3FF));
      g0 = <u32>(((q0 >> 40) & 0x400) | ((q0 >> 15) & 0x3FF));
      b0 = <u32>(((q0 >> 49) & 0x400) | ((q0 >> 25) & 0x3FF));

      r1 = r0 + signExtend(4, d1 >>  3);
      g1 = g0 + signExtend(5, d1 >> 13);
      b1 = b0 + signExtend(4, d1 >> 23);

      r2 = r0 + signExtend(4, d2 >> 1);
      g2 = g0 + signExtend(5, ((d2 >> 7) & 0x10) | ((d1 >> 9) & 0x0F));
      b2 = b0 + signExtend(4, ((d2 << 3) & 0x08) | ((d1 >> 29)));

      r3 = r0 + signExtend(4, d2 >> 7);
      g3 = g0 + signExtend(5, ((d1 >> 4) & 0x10) | ((d1 >> 19) & 0x0F));
      b3 = b0 + signExtend(4, (
        ((d2 >>  9) & 8) |
        ((d2 >>  4) & 4) |
        ((d1 >> 27) & 2) |
        ((d2 >>  5) & 1)
      ));

      r0 = unq(11, r0);
      g0 = unq(11, g0);
      b0 = unq(11, b0);

      r1 = unq(11, r1 & 0x7FF);
      g1 = unq(11, g1 & 0x7FF);
      b1 = unq(11, b1 & 0x7FF);

      r2 = unq(11, r2 & 0x7FF);
      g2 = unq(11, g2 & 0x7FF);
      b2 = unq(11, b2 & 0x7FF);

      r3 = unq(11, r3 & 0x7FF);
      g3 = unq(11, g3 & 0x7FF);
      b3 = unq(11, b3 & 0x7FF);
      break;
    case 10:
      // rgb0 - 11 bits
      // r1, r2, r3 - 4 bits (delta)
      // g1, g2, g3 - 4 bits (delta)
      // b1, b2, b3 - 5 bits (delta)

      r0 = ((d1 <<  3) & 0x400) | ((d0 >>  5) & 0x3FF);
      g0 = ((d1 >>  7) & 0x400) | ((d0 >> 15) & 0x3FF);
      b0 = ((d1 >> 18) & 0x400) | <u32>((q0 >> 25) & 0x3FF);

      r1 = r0 + signExtend(4, d1 >>  3);
      g1 = g0 + signExtend(4, d1 >> 13);
      b1 = b0 + signExtend(5, d1 >> 23);

      r2 = r0 + signExtend(4, d2 >> 1);
      g2 = g0 + signExtend(4, d1 >> 9);
      b2 = b0 + signExtend(5, ((d1 >> 4) & 0x10) | ((d2 << 3) & 8) | (d1 >> 29));

      r3 = r0 + signExtend(4, d2 >>  7);
      g3 = g0 + signExtend(4, d1 >> 19);
      b3 = b0 + signExtend(5, (
        ((d2 >>  7) & 0x10) |
        ((d2 >>  9) & 0x08) |
        ((d2 >>  4) & 0x06) |
        ((d1 >> 18) & 0x01)
      ));

      r0 = unq(11, r0);
      g0 = unq(11, g0);
      b0 = unq(11, b0);

      r1 = unq(11, r1 & 0x7FF);
      g1 = unq(11, g1 & 0x7FF);
      b1 = unq(11, b1 & 0x7FF);

      r2 = unq(11, r2 & 0x7FF);
      g2 = unq(11, g2 & 0x7FF);
      b2 = unq(11, b2 & 0x7FF);

      r3 = unq(11, r3 & 0x7FF);
      g3 = unq(11, g3 & 0x7FF);
      b3 = unq(11, b3 & 0x7FF);
      break;
    case 14:
      // rgb0 - 9 bits
      // rgb1, rgb2, rgb3 - 5 bits (delta)

      r0 = (d0 >>  5) & 0x1FF;
      g0 = (d0 >> 15) & 0x1FF;
      b0 = <u32>((q0 >> 25) & 0x1FF);

      r1 = r0 + signExtend(5, d1 >>  3);
      g1 = g0 + signExtend(5, d1 >> 13);
      b1 = b0 + signExtend(5, d1 >> 23);

      r2 = r0 + signExtend(5, d2 >> 1);
      g2 = g0 + signExtend(5, ((d0 >> 20) & 0x10) | ((d1 >> 9) & 0xF));
      b2 = b0 + signExtend(5, ((d0 >> 10) & 0x10) | ((d2 << 3) & 8) | (d1 >> 29));

      r3 = r0 + signExtend(5, d2 >> 7);
      g3 = g0 + signExtend(5, ((d1 >> 4) & 0x10) | ((d1 >> 19) & 0xF));
      b3 = b0 + signExtend(5, (
        ((d1 <<  2) & 0x10) |
        ((d2 >>  9) & 0x08) |
        ((d2 >>  4) & 0x04) |
        ((d1 >> 27) & 0x02) |
        ((d1 >> 18) & 0x01)
      ));

      r0 = unq(9, r0);
      g0 = unq(9, g0);
      b0 = unq(9, b0);

      r1 = unq(9, r1 & 0x1FF);
      g1 = unq(9, g1 & 0x1FF);
      b1 = unq(9, b1 & 0x1FF);

      r2 = unq(9, r2 & 0x1FF);
      g2 = unq(9, g2 & 0x1FF);
      b2 = unq(9, b2 & 0x1FF);

      r3 = unq(9, r3 & 0x1FF);
      g3 = unq(9, g3 & 0x1FF);
      b3 = unq(9, b3 & 0x1FF);
      break;
    case 18:
      // rgb0 - 8 bits
      // r1, r2, r3 - 6 bits (delta)
      // g1, g2, g3 - 5 bits (delta)
      // b1, b2, b3 - 5 bits (delta)

      r0 = (d0 >>  5) & 0xFF;
      g0 = (d0 >> 15) & 0xFF;
      b0 = <u32>((q0 >> 25) & 0xFF);

      r1 = r0 + signExtend(6, d1 >>  3);
      g1 = g0 + signExtend(5, d1 >> 13);
      b1 = b0 + signExtend(5, d1 >> 23);

      r2 = r0 + signExtend(6, d2 >> 1);
      g2 = g0 + signExtend(5, ((d0 >> 20) & 0x10) | ((d1 >> 9) & 0xF));
      b2 = b0 + signExtend(5, ((d0 >> 10) & 0x10) | ((d2 << 3) & 8) | (d1 >> 29));

      r3 = r0 + signExtend(6, d2 >> 7);
      g3 = g0 + signExtend(5, ((d0 >> 9) & 0x10) | ((d1 >> 19) & 0xF));
      b3 = b0 + signExtend(5, (
        ((d1 <<  2) & 0x18) |
        ((d0 >> 21) & 0x04) |
        ((d1 >> 27) & 0x02) |
        ((d1 >> 18) & 0x01)
      ));

      r0 = unq(8, r0);
      g0 = unq(8, g0);
      b0 = unq(8, b0);

      r1 = unq(8, r1 & 0xFF);
      g1 = unq(8, g1 & 0xFF);
      b1 = unq(8, b1 & 0xFF);

      r2 = unq(8, r2 & 0xFF);
      g2 = unq(8, g2 & 0xFF);
      b2 = unq(8, b2 & 0xFF);

      r3 = unq(8, r3 & 0xFF);
      g3 = unq(8, g3 & 0xFF);
      b3 = unq(8, b3 & 0xFF);
      break;
    case 22:
      // rgb0 - 8 bits
      // r1, r2, r3 - 5 bits (delta)
      // g1, g2, g3 - 6 bits (delta)
      // b1, b2, b3 - 5 bits (delta)

      r0 = (d0 >>  5) & 0xFF;
      g0 = (d0 >> 15) & 0xFF;
      b0 = <u32>((q0 >> 25) & 0xFF);

      r1 = r0 + signExtend(5, d1 >>  3);
      g1 = g0 + signExtend(6, d1 >> 13);
      b1 = b0 + signExtend(5, d1 >> 23);

      r2 = r0 + signExtend(5, d2 >> 1);
      g2 = g0 + signExtend(6, (
        ((d0 >> 18) & 0x20) |
        ((d0 >> 20) & 0x10) |
        ((d1 >> 9) & 0xF)
      ));
      b2 = b0 + signExtend(5, (
        ((d0 >> 10) & 0x10) |
        ((d2 <<  3) & 0x08) |
        ((d1 >> 29))
      ));

      r3 = r0 + signExtend(5, d2 >> 7);
      g3 = g0 + signExtend(6, (
        ((d1 <<  4) & 0x20) |
        ((d1 >>  4) & 0x10) |
        ((d1 >> 19) & 0x0F)
      ));
      b3 = b0 + signExtend(5, (
        ((d1 <<  2) & 0x10) |
        ((d2 >>  9) & 0x08) |
        ((d2 >>  4) & 0x04) |
        ((d1 >> 27) & 0x02) |
        ((d0 >> 13) & 0x01)
      ));

      r0 = unq(8, r0);
      g0 = unq(8, g0);
      b0 = unq(8, b0);

      r1 = unq(8, r1 & 0xFF);
      g1 = unq(8, g1 & 0xFF);
      b1 = unq(8, b1 & 0xFF);

      r2 = unq(8, r2 & 0xFF);
      g2 = unq(8, g2 & 0xFF);
      b2 = unq(8, b2 & 0xFF);

      r3 = unq(8, r3 & 0xFF);
      g3 = unq(8, g3 & 0xFF);
      b3 = unq(8, b3 & 0xFF);
      break;
    case 26:
      // rgb0 - 8 bits
      // r1, r2, r3 - 5 bits (delta)
      // g1, g2, g3 - 5 bits (delta)
      // b1, b2, b3 - 6 bits (delta)

      r0 = (d0 >>  5) & 0xFF;
      g0 = (d0 >> 15) & 0xFF;
      b0 = <u32>((q0 >> 25) & 0xFF);

      r1 = r0 + signExtend(5, d1 >>  3);
      g1 = g0 + signExtend(5, d1 >> 13);
      b1 = b0 + signExtend(6, d1 >> 23);

      r2 = r0 + signExtend(5, d2 >> 1);
      g2 = g0 + signExtend(5, ((d0 >> 20) & 0x10) | ((d1 >> 9) & 0xF));
      b2 = b0 + signExtend(6, (
        ((d0 >> 18) & 0x20) |
        ((d0 >> 10) & 0x10) |
        ((d2 <<  3) & 0x08) |
        ((d1 >> 29))
      ));

      r3 = r0 + signExtend(5, d2 >> 7);
      g3 = g0 + signExtend(5, ((d1 >> 4) & 0x10) | ((d1 >> 19) & 0xF));
      b3 = b0 + signExtend(6, (
        ((d1 <<  4) & 0x20) |
        ((d1 <<  2) & 0x10) |
        ((d2 >>  9) & 0x08) |
        ((d2 >>  4) & 0x04) |
        ((d0 >> 12) & 0x02) |
        ((d1 >> 18) & 0x01)
      ));

      r0 = unq(8, r0);
      g0 = unq(8, g0);
      b0 = unq(8, b0);

      r1 = unq(8, r1 & 0xFF);
      g1 = unq(8, g1 & 0xFF);
      b1 = unq(8, b1 & 0xFF);

      r2 = unq(8, r2 & 0xFF);
      g2 = unq(8, g2 & 0xFF);
      b2 = unq(8, b2 & 0xFF);

      r3 = unq(8, r3 & 0xFF);
      g3 = unq(8, g3 & 0xFF);
      b3 = unq(8, b3 & 0xFF);
      break;
    case 30:
      // rgb0 - 6 bits
      // rgb1 - 6 bits
      // rgb2 - 6 bits
      // rgb3 - 6 bits

      r0 = (d0 >>  5) & 0x3F;
      g0 = (d0 >> 15) & 0x3F;
      b0 = (d0 >> 25) & 0x3F;

      r1 = (d1 >>  3) & 0x3F;
      g1 = (d1 >> 13) & 0x3F;
      b1 = (d1 >> 23) & 0x3F;

      r2 = (d2 >> 1) & 0x3F;
      g2 = ((d0 >> 16) & 0x20) | ((d0 >> 20) & 0x10) | ((d1 >> 9) & 0xF);
      b2 = (
        ((d0 >> 17) & 0x20) |
        ((d0 >> 10) & 0x10) |
        ((d2 <<  3) & 0x08) |
        ((d1 >> 29))
      );

      r3 = (d2 >> 7) & 0x3F;
      g3 = ((d0 >> 26) & 0x20) | ((d0 >> 7) & 0x10) | ((d1 >> 19) & 0xF);
      b3 = (
        ((d1 <<  4) & 0x20) |
        ((d1 <<  2) & 0x10) |
        ((d1 <<  3) & 0x08) |
        ((d0 >> 21) & 0x04) |
        ((d0 >> 12) & 0x03)
      );

      r0 = unq(6, r0);
      g0 = unq(6, g0);
      b0 = unq(6, b0);

      r1 = unq(6, r1);
      g1 = unq(6, g1);
      b1 = unq(6, b1);

      r2 = unq(6, r2);
      g2 = unq(6, g2);
      b2 = unq(6, b2);

      r3 = unq(6, r3);
      g3 = unq(6, g3);
      b3 = unq(6, b3);
      break;
  }

  const patternIndex = <u32>(q1 >> 13) & 0x1F;

  const anchor = getAnchor(patternIndex) * 3;
  const hiMask = <u64>0xFFFFFFFFFFFFFFFF << (anchor + 3);
  const loMask = (<u64>0xFFFFFFFFFFFFFFFF >> (65 - anchor)) << 3;
  let weights = ((q1 >> 16) & hiMask) | ((q1 >> 17) & loMask) | ((q1 >> 18) & 3);

  const rs0 = r0 * 64 + 32;
  const gs0 = g0 * 64 + 32;
  const bs0 = b0 * 64 + 32;
  const rs1 = r2 * 64 + 32;
  const gs1 = g2 * 64 + 32;
  const bs1 = b2 * 64 + 32;
  const rd0 = r1 - r0;
  const gd0 = g1 - g0;
  const bd0 = b1 - b0;
  const rd1 = r3 - r2;
  const gd1 = g3 - g2;
  const bd1 = b3 - b2;

  let pat = pattern(patternIndex);

  for (let i = 0; i < 4; i++) {
    if (kIsRGBA16F) {
      store<u64>(offset, lerp2<u64>(rs0, rs1, gs0, gs1, bs0, bs1,
                                    rd0, rd1, gd0, gd1, bd0, bd1,
                                    pat & 1, (<u32>weights & 7)));
    } else if (kIsRGB32F) {
      const w = weight3(<u32>weights & 7);
      if (pat & 1) {
        store<u32>(offset, lerpF32(rs1, rd1, w), 0);
        store<u32>(offset, lerpF32(gs1, gd1, w), 4);
        store<u32>(offset, lerpF32(bs1, bd1, w), 8);
      } else {
        store<u32>(offset, lerpF32(rs0, rd0, w), 0);
        store<u32>(offset, lerpF32(gs0, gd0, w), 4);
        store<u32>(offset, lerpF32(bs0, bd0, w), 8);
      }
    } else {
      store<u32>(offset, lerp2<u32>(rs0, rs1, gs0, gs1, bs0, bs1,
                                    rd0, rd1, gd0, gd1, bd0, bd1,
                                    pat & 1, (<u32>weights & 7)));
    }
    weights >>= 3;
    pat >>= 1;

    if (kIsRGBA16F) {
      store<u64>(offset, lerp2<u64>(rs0, rs1, gs0, gs1, bs0, bs1,
                                    rd0, rd1, gd0, gd1, bd0, bd1,
                                    pat & 1, (<u32>weights & 7)),
                                    kPixelLength);
    } else if (kIsRGB32F) {
      const w = weight3(<u32>weights & 7);
      if (pat & 1) {
        store<u32>(offset, lerpF32(rs1, rd1, w), kPixelLength + 0);
        store<u32>(offset, lerpF32(gs1, gd1, w), kPixelLength + 4);
        store<u32>(offset, lerpF32(bs1, bd1, w), kPixelLength + 8);
      } else {
        store<u32>(offset, lerpF32(rs0, rd0, w), kPixelLength + 0);
        store<u32>(offset, lerpF32(gs0, gd0, w), kPixelLength + 4);
        store<u32>(offset, lerpF32(bs0, bd0, w), kPixelLength + 8);
      }
    } else {
      store<u32>(offset, lerp2<u32>(rs0, rs1, gs0, gs1, bs0, bs1,
                                    rd0, rd1, gd0, gd1, bd0, bd1,
                                    pat & 1, (<u32>weights & 7)),
                                    kPixelLength);
    }
    weights >>= 3;
    pat >>= 1;

    if (kIsRGBA16F) {
      store<u64>(offset, lerp2<u64>(rs0, rs1, gs0, gs1, bs0, bs1,
                                    rd0, rd1, gd0, gd1, bd0, bd1,
                                    pat & 1, (<u32>weights & 7)),
                                    kPixelLength * 2);
    } else if (kIsRGB32F) {
      const w = weight3(<u32>weights & 7);
      if (pat & 1) {
        store<u32>(offset, lerpF32(rs1, rd1, w), kPixelLength * 2 + 0);
        store<u32>(offset, lerpF32(gs1, gd1, w), kPixelLength * 2 + 4);
        store<u32>(offset, lerpF32(bs1, bd1, w), kPixelLength * 2 + 8);
      } else {
        store<u32>(offset, lerpF32(rs0, rd0, w), kPixelLength * 2 + 0);
        store<u32>(offset, lerpF32(gs0, gd0, w), kPixelLength * 2 + 4);
        store<u32>(offset, lerpF32(bs0, bd0, w), kPixelLength * 2 + 8);
      }
    } else {
      store<u32>(offset, lerp2<u32>(rs0, rs1, gs0, gs1, bs0, bs1,
                                    rd0, rd1, gd0, gd1, bd0, bd1,
                                    pat & 1, (<u32>weights & 7)),
                                    kPixelLength * 2);
    }
    weights >>= 3;
    pat >>= 1;

    if (kIsRGBA16F) {
      store<u64>(offset, lerp2<u64>(rs0, rs1, gs0, gs1, bs0, bs1,
                                    rd0, rd1, gd0, gd1, bd0, bd1,
                                    pat & 1, (<u32>weights & 7)),
                                    kPixelLength * 3);
    } else if (kIsRGB32F) {
      const w = weight3(<u32>weights & 7);
      if (pat & 1) {
        store<u32>(offset, lerpF32(rs1, rd1, w), kPixelLength * 3 + 0);
        store<u32>(offset, lerpF32(gs1, gd1, w), kPixelLength * 3 + 4);
        store<u32>(offset, lerpF32(bs1, bd1, w), kPixelLength * 3 + 8);
      } else {
        store<u32>(offset, lerpF32(rs0, rd0, w), kPixelLength * 3 + 0);
        store<u32>(offset, lerpF32(gs0, gd0, w), kPixelLength * 3 + 4);
        store<u32>(offset, lerpF32(bs0, bd0, w), kPixelLength * 3 + 8);
      }
    } else {
      store<u32>(offset, lerp2<u32>(rs0, rs1, gs0, gs1, bs0, bs1,
                                    rd0, rd1, gd0, gd1, bd0, bd1,
                                    pat & 1, (<u32>weights & 7)),
                                    kPixelLength * 3);
    }
    weights >>= 3;
    pat >>= 1;

    offset += stride;
  }

}

/**
 * Linear interpolation and subsequent final unquantization.
 */
// @ts-ignore
@inline
function lerp1<T extends number>(
  rs0: u32, gs0: u32, bs0: u32,
  rd0: u32, gd0: u32, bd0: u32,
  w: u32
): T {
  w = weight4(w);
  const r = (rs0 + w * rd0) >> 6;
  const g = (gs0 + w * gd0) >> 6;
  const b = (bs0 + w * bd0) >> 6;
  if (kIsRGBA16F) {
    return unquantizeRGBA16F(r, g, b) as T;
  }
  if (kIsRGB9E5) {
    return unquantizeRGB9E5(r, g, b) as T;
  }
  if (kIsRoundRG11FB10F) {
    return unquantizeRoundRG11FB10F(r, g, b) as T;
  }
  if (kIsTruncRG11FB10F) {
    return unquantizeTruncRG11FB10F(r, g, b) as T;
  }
  if (kIsRoundNoClampRG11FB10F) {
    return unquantizeRoundUnsafeRG11FB10F(r, g, b) as T;
  }
  return unreachable();
}

/**
 * Partitioned linear interpolation and subsequent final unquantization.
 */
// @ts-ignore
@inline
function lerp2<T extends number>(
  rs0: u32, rs1: u32,
  gs0: u32, gs1: u32,
  bs0: u32, bs1: u32,
  rd0: u32, rd1: u32,
  gd0: u32, gd1: u32,
  bd0: u32, bd1: u32,
  p: u32, w: u32
): T {
  let r: u32 = 0;
  let g: u32 = 0;
  let b: u32 = 0;
  w = weight3(w);
  if (p) {
    r = (rs1 + w * rd1) >> 6;
    g = (gs1 + w * gd1) >> 6;
    b = (bs1 + w * bd1) >> 6;
  } else {
    r = (rs0 + w * rd0) >> 6;
    g = (gs0 + w * gd0) >> 6;
    b = (bs0 + w * bd0) >> 6;
  }
  if (kIsRGBA16F) {
    return unquantizeRGBA16F(r, g, b) as T;
  }
  if (kIsRGB9E5) {
    return unquantizeRGB9E5(r, g, b) as T;
  }
  if (kIsRoundRG11FB10F) {
    return unquantizeRoundRG11FB10F(r, g, b) as T;
  }
  if (kIsTruncRG11FB10F) {
    return unquantizeTruncRG11FB10F(r, g, b) as T;
  }
  if (kIsRoundNoClampRG11FB10F) {
    return unquantizeRoundUnsafeRG11FB10F(r, g, b) as T;
  }
  return unreachable();
}

/**
 * Load interpolation weight for a 4-bit index.
 */
// @ts-ignore
@inline
function weight4(i: u32): u32 {
  return load<u8>(i);
}

/**
 * Load interpolation weight for a 3-bit index.
 */
// @ts-ignore
@inline
function weight3(i: u32): u32 {
  return load<u8>(i, 16);
}

/**
 * Load 16-bit pattern for a 5-bit index.
 */
// @ts-ignore
@inline
function pattern(p: u32): u32 {
  return load<u16>(p << 1, 32);
}

/**
 * Load reversed 6-bit value.
 */
// @ts-ignore
@inline
function reverse6(n: u32): u32 {
  return load<u8>(n, 96);
}

/**
 * Load unquantized value.
 */
// @ts-ignore
@inline
function unq(width: i32, value: u32): u32 {
  const base = 160;
  switch (width) {
    case  6: return load<u16>(value * 2, base);
    case  7: return load<u16>(value * 2, base + 128 * ((1 << 1) - 1));
    case  8: return load<u16>(value * 2, base + 128 * ((1 << 2) - 1));
    case  9: return load<u16>(value * 2, base + 128 * ((1 << 3) - 1));
    case 10: return load<u16>(value * 2, base + 128 * ((1 << 4) - 1));
    case 11: return load<u16>(value * 2, base + 128 * ((1 << 5) - 1));
    case 12: return load<u16>(value * 2, base + 128 * ((1 << 6) - 1));
    default: return unreachable();
  }
}

/**
 * Sign-extend w-bit value.
 */
// @ts-ignore
@inline
function signExtend(w: u32, value: i32): i32 {
  const s = 32 - w;
  return (value << s) >> s;
}

/**
 * Get anchor index for a given pattern index.
 */
// @ts-ignore
@inline
function getAnchor(p: u32): u32 {
  if (p < 16) return 15;
  return <u32>(0x22882282F882282F >> ((p & 0xF) << 2)) & 0xF;
}

/**
 * Scale to 15 bits and pack to 64 bits.
 */
// @ts-ignore
@inline
function unquantizeRGBA16F(r: u32, g: u32, b: u32): u64 {
  const ru: u64 = (r * 31) >> 6;
  const gu: u64 = (g * 31) >> 6;
  const bu: u64 = (b * 31) >> 6;
  return 0x3C00000000000000 | (bu << 32) | (gu << 16) | ru;
}

/**
 * Downscale float16 values to 9 bits with a shared 5-bit exponent.
 */
// @ts-ignore
@inline
function unquantizeRGB9E5(r: u32, g: u32, b: u32): u32 {
  // Regular BC6H_U 16-to-15 unquantization. After it,
  // half-float reinterpretations are guaranteed to be in [0.0, 65504.0]
  // thus implicitly avoiding NaNs and Inf.
  r = (r * 31) >> 6;
  g = (g * 31) >> 6;
  b = (b * 31) >> 6;

  // Extract exponents from the higher 5 bits.
  const rExp = r >> 10;
  const gExp = g >> 10;
  const bExp = b >> 10;

  // Extract mantissas from the lower 10 bits.
  // As per the float16 spec, add 1024 when the exponent is not zero.
  const rM = (r & 0x3FF) | (rExp ? 0x400 : 0);
  const gM = (g & 0x3FF) | (gExp ? 0x400 : 0);
  const bM = (b & 0x3FF) | (bExp ? 0x400 : 0);

  if (rExp | gExp | bExp) {
    // When at least one of RGB exponents is not zero,
    // use the largest one +1 (to even the multiplier) for the packed value.
    const sharedExp = 1 + max(rExp, max(gExp, bExp));

    // Translate the exponent differences into
    // the number of bits to truncate the mantissas by.
    // TODO: Evaluate accuracy and speed with rounding semantics.
    const rShift = 1 + sharedExp - (rExp ? rExp : 1);
    const gShift = 1 + sharedExp - (gExp ? gExp : 1);
    const bShift = 1 + sharedExp - (bExp ? bExp : 1);
    return (sharedExp    << 27) |
           (bM >> bShift << 18) |
           (gM >> gShift <<  9) |
           (rM >> rShift);
  } else {
    // All three values are float16 denorms. If all mantissas belong
    // to 0..511 range, they could be copied directly with zero exponent.
    // Otherwise, truncate to 9 bits and set the shared exponent to 1.
    const msb = ((rM | gM | bM) >> 9) & 1;
    return (msb       << 27) |
           (bM >> msb << 18) |
           (gM >> msb <<  9) |
           (rM >> msb);
  }
}

/**
 * Clamp & scale to 10-11 bits with rounding and pack to 32 bits.
 */
// @ts-ignore
@inline
function unquantizeRoundRG11FB10F(r: u32, g: u32, b: u32): u32 {
  // Clamp inputs to avoid 10- or 11-bit infinity values
  r = min(r, 65519);
  g = min(g, 65519);
  b = min(b, 65502);

  // Rescale floating-point representations afterwards
  r = (r * 0x001F + 0x000200) >> 10;
  g = (g * 0x003E + 0x000400) & 0x003FF800;
  b = (b * 0xF800 + 0x200000) & 0xFFC00000;
  return b | g | r;
}

/**
 * Scale to 10-11 bits with truncation and pack to 32 bits.
 */
// @ts-ignore
@inline
function unquantizeTruncRG11FB10F(r: u32, g: u32, b: u32): u32 {
  // Copy exponents and trunc mantissas
  r = (r * 0x001F) >> 10;
  g = (g * 0x003E) & 0x003FF800;
  b = (b * 0xF800) & 0xFFC00000;
  return b | g | r;
}

/**
 * Scale to 10-11 bits with rounding and pack to 32 bits.
 * Values greater than finite maximums for 10- and 11-bit
 * floats will be set to Infinity.
 */
// @ts-ignore
@inline
function unquantizeRoundUnsafeRG11FB10F(r: u32, g: u32, b: u32): u32 {
  r = (r * 0x001F + 0x000200) >> 10;
  g = (g * 0x003E + 0x000400) & 0x003FF800;
  b = (b * 0xF800 + 0x200000) & 0xFFC00000;
  return b | g | r;
}

/**
 * Apply BC6H_U interpolation, final unquantization,
 * and convert the result to a single-precision float.
 */
// @ts-ignore
@inline
function lerpF32(cs0: u32, cd0: u32, w: u32): u32 {
  const c = (((cs0 + w * cd0) >> 6) * 31) >> 6;

  if (c == 0) return 0;

  // Normalized
  if (c > 1023) return (c << 13) + 0x38000000;

  // Half-float denorms
  const clzC = clz(c);
  return ((c << (clzC - 8)) ^ 0x800000) + 0x43000000 - (clzC << 23);
}
