// Copyright 2020 The Khronos Group Inc.
//
// SPDX-License-Identifier: Apache-2.0

import * as fs from 'fs';
import * as test from 'tape';
import * as crypto from 'crypto';

const WIDTH = 8192;
const HEIGHT = 8192;

const modeChecksums = {
  "0": {
    bc6h: "63649c22a56e93a93fa2bbdb299e4410b7976054821bbd0e210a2ec2c59a329c",
    rgba16f: "a1d51f083201861f444e9b8507a1951ee9d9ba4c47d74692b38ee0c02f96a105"
  },
  "1": {
    bc6h: "29ab9bb7069402defd5a359460cee351405a8431bb4a692d0e7a7745b43f648c",
    rgba16f: "b58bc9cb50894e18f7b4704056d9fedb8e54acba209524142b648a5dd3486042"
  },
  "2": {
    bc6h: "b2cc06730141f23ff971ca958b16e46f9491a88a68a22278cb4b07e05065c1ee",
    rgba16f: "f81ac469bd5ab12354bbc22794468db7b4af394757080ba9a62e3760b48a06ce"
  },
  "6": {
    bc6h: "6ea51e7f8b6366b9b2cba9ecf3f00723871db4633051e45bc7be2cbafe7f58bb",
    rgba16f: "c63e908242825bae8cbe4af54b0a3d72ccd3317c4d09557b928cf99363d39cdd"
  },
  "10": {
    bc6h: "6abb7f59941cf7c291d8dbd4f673e57b8bd34e56fd3de949ea3af8eea5fda78d",
    rgba16f: "a25746a3a7af4387466afced1374f7d5e4602f4568a0de251f2159a9ce5846e9"
  },
  "14": {
    bc6h: "a52128e835c314207b01e3f36776997b8285119bd08a4e1ff6a7b5ed5b4dec6c",
    rgba16f: "288af432a33380d446d0a07696ef74ddccd940b817323eef8cc6df507a94578e"
  },
  "18": {
    bc6h: "854abcaadefb93a012cc448773ff2e5cb024ddcf6ee8024b6b8b6083ba4aed31",
    rgba16f: "7737f401427cc3f832023f8134776ee14080f0072945d9da5040ddd076fb4f30"
  },
  "22": {
    bc6h: "9e246c47b0d727ff68c8d64befbcb552f5b3c2ec75a95cdf40909802a839c36a",
    rgba16f: "b48ef3a8fe1115fbfd963da20f5e169434faca323952beee75235cfabead6871"
  },
  "26": {
    bc6h: "5ea960b0dcf4a30b11cb4cc077c31901a6794f00f9224814d638235f98bbdd86",
    rgba16f: "06611b8c45dcfa303a04c909ad8ee4094dfaf6916ed72b10ac2362290907e643"
  },
  "30": {
    bc6h: "b7380d85abed2c190b085a2753b68fbcbf934cceba9931f8e98ea392c077e4cf",
    rgba16f: "23bb81a1c2f6fb4383940d0ee02bcd63ad93abb45b5a8c9f1691f8ad7f71be60"
  },
  "3": {
    bc6h: "6f0eb1c28c0a0e27153a57e51072aa8c3ccb25c3d074dbc9fa45d10229455ecd",
    rgba16f: "97cb8255d41134e84941d9f7aadf32a62cbc7ad8514c67a88935a0eda671b3bb"
  },
  "7": {
    bc6h: "b59924b592ab4316270535723bba79402752403a3d32585c5d7be0c6da82ff28",
    rgba16f: "08c718e02ecba0fca19fb26c64700c394ecb28af5320414baba068af614949a8"
  },
  "11": {
    bc6h: "b025d88e5ea001a80c0b064e34db54870458bba6d0d5336414a1365dd7fe227d",
    rgba16f: "8768db1e1fe91eac80cecc468836f85c76aefee84916f08fe8dbe8abf7f4ef0a"
  },
  "15": {
    bc6h: "9d5ac6f01bde258e50bc148f9f9b78e67048b69d01941e19b28c09e23ee3869c",
    rgba16f: "0fe336c72371ccb581f63eeb6bda3d8cf47f81e24bd83b4453872290742bcde6"
  },
  "19": {
    bc6h: "c5cbb95e965585bea4f8d728f0be403f3ab3ac5bcc1ab5f9c22e940e7714a70c",
    rgba16f: "8c7671118d7035c6f82e6931252131eeea6eab91420a0dbae085a07583c1e9dc"
  },
  "23": {
    bc6h: "8a4a88a4c72bf2b36a1b189edb1967655be370e14c4769d646605b61e73c3b89",
    rgba16f: "8c7671118d7035c6f82e6931252131eeea6eab91420a0dbae085a07583c1e9dc"
  },
  "27": {
    bc6h: "486e4077750cd16a302b91766d41d736905e14c62881bf65548e347f6ba845a8",
    rgba16f: "8c7671118d7035c6f82e6931252131eeea6eab91420a0dbae085a07583c1e9dc"
  },
  "31": {
    bc6h: "3cef1e895be8b66113efb4118ce1883747a72dc171782496480f281843d8bdd5",
    rgba16f: "8c7671118d7035c6f82e6931252131eeea6eab91420a0dbae085a07583c1e9dc"
  }
};

const mixedChecksums = {
  full: {
    bc6h: "18009f7b34482248ef27b4d5174bfdd954a5ba870533256ffb833cd1eaa5634a",
    rgba16f: "622ab1e1310dc41b5bee667a0702339221836008309d6f545c74a0a91e1b5c0b",
    rgb9e5: "8a20f895bbb62b8a7f77395de12229dceaf1ee7925e540502c0eb9347a3379e3",
    r11fg11fb10f_round: "1dc0848c6402bbd3d02d4320c1ae2e28933b5fde86c5368ac892b6aa16603d26",
    r11fg11fb10f_trunc: "7bfe0f27fac13e4da4f743818f6bdb788e9270f5055805432aee6ee510c7b846",
    r11fg11fb10f_round_noclamp: "a8c5064bcd734997bc2fd939bc80a23ef471d4232134d888c0c9e0b76fe9cc6a",
    rgb32f: "1f2d03bdb24c9852d8b0dffabb6c96da97c7a8113ec895d2419d015dc6d0747f"
  },
  cropped: {
    bc6h: "18009f7b34482248ef27b4d5174bfdd954a5ba870533256ffb833cd1eaa5634a",
    rgba16f: "ab643e8bee38b859575f23a229631bf7f05f297831d50eaa8cd2c79edbd5b611",
    rgb9e5: "1f71648a5af72ef3a74014e41c0dd413612047cc7c1f264d684163cf81536c12",
    r11fg11fb10f_round: "86c58b5e24143e44d27cdbf7ff4da355c7e51451eaadc7b9dbd7eff70c3aae58",
    r11fg11fb10f_trunc: "f33b6cff8fe1591d343a00696d4fbc4a1aa028875d1db95cc42071df5b9ac91b",
    r11fg11fb10f_round_noclamp: "2b9776757999429027bdb28b6ca8797680d4415108464fa3cf1d5cecc2d7f7f6",
    rgb32f: "58a1d1a7fb0fa22e661fa4b9f0b5ca827dafdc11f27684f77738b1793444170f"
  }
};

let numBlocks: number;
let compressedView: Uint8Array;
let uncompressedView: Uint8Array;

let generator: IGenerator;

const kUserDataOffset = 65536;

async function setup(wasmPath: string, pixelSize: number, width = WIDTH, height = HEIGHT): Promise<IDecoder> {
  const yBlocks = ((height + 3) >> 2);
  numBlocks = ((width + 3) >> 2) * yBlocks;

  const compressedByteLength = numBlocks * 16;
  const uncompressedByteLength = width * height * pixelSize;
  const totalByteLength = compressedByteLength + width * (4 * yBlocks) * pixelSize;
  const memory = new WebAssembly.Memory({ initial: (kUserDataOffset + totalByteLength + 65535) >> 16 });

  compressedView = new Uint8Array(memory.buffer, kUserDataOffset, compressedByteLength);
  uncompressedView = new Uint8Array(memory.buffer, kUserDataOffset + compressedByteLength, uncompressedByteLength);

  // Generator
  const generatorModule = new WebAssembly.Module(fs.readFileSync('build/generator.wasm'));
  generator = new WebAssembly.Instance(generatorModule, { env: { memory: memory } }).exports as unknown as IGenerator;

  // Decoder
  const module = new WebAssembly.Module(fs.readFileSync(wasmPath));
  return new WebAssembly.Instance(module, { env: { memory: memory } }).exports as unknown as IDecoder;
}

test('Individual Modes, RGBA16F', async (t) => {
  const decoder = await setup('build/bc6hu-rgba16f.wasm', 8);

  for (let m = 0; m < 18; m++) {
    const mode = generator.generate(m, numBlocks);
    const hashes = modeChecksums[mode.toString()];

    const genHash = crypto.createHash('sha256').update(compressedView).digest('hex');
    t.equals(genHash, hashes.bc6h, `mode ${mode.toString().padStart(2, '0')}: generator`);

    decoder.decode(WIDTH, HEIGHT);
    const decHash = crypto.createHash('sha256').update(uncompressedView).digest('hex');
    t.equals(decHash, hashes.rgba16f, `mode ${mode.toString().padStart(2, '0')}: decoder`);
  }

  t.end();
});

test('Mixed Modes', async (t) => {
  const modules = {
    rgba16f: 8,
    rgb9e5: 4,
    r11fg11fb10f_round: 4,
    r11fg11fb10f_trunc: 4,
    r11fg11fb10f_round_noclamp: 4,
    rgb32f: 12
  };

  for (const module in modules) {
    const pixelSize = modules[module];
    const decoder = await setup(`build/bc6hu-${module}.wasm`, pixelSize);

    generator.generateAll(numBlocks);
    const hashes = mixedChecksums.full;

    const genHash = crypto.createHash('sha256').update(compressedView).digest('hex');
    t.equals(genHash, hashes.bc6h, `all modes: generator`);

    decoder.decode(WIDTH, HEIGHT);
    const decHash = crypto.createHash('sha256').update(uncompressedView).digest('hex');
    t.equals(decHash, hashes[module], `all modes: ${module} decoder`);
  }

  t.end();
});

test('Mixed Modes - odd dimensions', async (t) => {
  const modules = {
    rgba16f: 8,
    rgb9e5: 4,
    r11fg11fb10f_round: 4,
    r11fg11fb10f_trunc: 4,
    r11fg11fb10f_round_noclamp: 4,
    rgb32f: 12
  };

  for (const module in modules) {
    const pixelSize = modules[module];
    const decoder = await setup(`build/bc6hu-${module}.wasm`, pixelSize, WIDTH - 1, HEIGHT - 1);

    generator.generateAll(numBlocks);
    const hashes = mixedChecksums.cropped;

    const genHash = crypto.createHash('sha256').update(compressedView).digest('hex');
    t.equals(genHash, hashes.bc6h, `all modes: generator`);

    decoder.decode(WIDTH - 1, HEIGHT - 1);
    const decHash = crypto.createHash('sha256').update(uncompressedView).digest('hex');
    t.equals(decHash, hashes[module], `all modes: ${module} decoder`);
  }

  t.end();
});

interface IDecoder {
  decode(width: number, height: number): number;
}

interface IGenerator {
  generate(mode: number, nBlocks: number): number;
  generateAll(nBlocks: number): number;
}