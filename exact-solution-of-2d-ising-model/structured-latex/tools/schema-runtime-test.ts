#!/usr/bin/env node
/**
 * `schema.ts` の実行時検証が、型で守れない／型を回避された入力を確かに拒むかのテスト。
 *
 * 型（コンパイル時）と実行時検証は守備範囲が違う。ここで確認するのは
 * **型検査を通さずに値が入ってくる経路**（動的に組み立てたデータ、外部から渡された値、
 * 型を書けない `.mjs`）でも、同じ規則で弾けることである。
 *
 * 使い方: node tools/schema-runtime-test.ts
 */

import { defineBlocks, defineNotes, paragraph } from "../schema.ts";

type Case = { name: string; run: () => void; expect: RegExp };

const cases: Case[] = [
  {
    name: "ブロックの未知フィールド（proof の打ち間違い）を拒む",
    expect: /未知のフィールドがある: proofs（/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_typo",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 1,
          labels: [],
          statement: [],
          proofs: [paragraph(["証明のつもり"])],
        } as never,
      ]),
  },
  {
    name: "本文ブロックの notes を拒む（注記は notes/ へ）",
    expect: /notes は使えない/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_notes",
          kind: "remark",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 2,
          labels: [],
          statement: [],
          notes: [paragraph(["注記"])],
        } as never,
      ]),
  },
  {
    name: "見出しに本文があれば拒む",
    expect: /statement is not allowed/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_heading",
          kind: "heading",
          level: 1,
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 3,
          title: { text: "見出し" },
          labels: [],
          statement: [paragraph(["本文"])],
        } as never,
      ]),
  },
  {
    name: "ノートの未知フィールドを拒む",
    expect: /未知のフィールドがある: target（/,
    run: () =>
      defineNotes([
        {
          id: "note_runtime_test_typo",
          target: ["def_kronecker"],
          body: [],
        } as never,
      ]),
  },
  {
    name: "定理型ブロックに level があれば拒む（見出しとの取り違え）",
    expect: /level is not allowed/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_level",
          kind: "claim",
          level: 3,
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 5,
          labels: [],
          statement: [],
        } as never,
      ]),
  },
  {
    name: "ノートの targets が空なら拒む",
    expect: /at least one label/,
    run: () => defineNotes([{ id: "note_runtime_test_empty", targets: [], body: [] } as never]),
  },
  {
    name: "ノードの type が不正なら拒む",
    expect: /type is invalid/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_node",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 4,
          labels: [],
          statement: [{ type: "pargaraph", children: [] } as never],
        },
      ]),
  },
];

let failed = 0;
for (const testCase of cases) {
  let message: string | null = null;
  try {
    testCase.run();
  } catch (cause) {
    message = cause instanceof Error ? cause.message : String(cause);
  }
  if (message === null) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 例外が投げられなかった`);
    continue;
  }
  if (!testCase.expect.test(message)) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 例外の内容が想定外\n    ${message}`);
    continue;
  }
  console.log(`✓ ${testCase.name}`);
}

if (failed > 0) {
  console.error(`\n${failed} 件の実行時検証テストが期待どおりに動かなかった`);
  process.exit(1);
}
console.log(`\n実行時検証テスト ${cases.length} 件すべて期待どおり`);
