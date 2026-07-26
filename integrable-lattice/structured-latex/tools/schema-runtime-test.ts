#!/usr/bin/env node
/**
 * `schema.ts` の実行時検証が、型で守れない／型を回避された入力を確かに拒むかのテスト。
 *
 * 型（コンパイル時）と実行時検証は守備範囲が違う。ここで確認するのは
 * **型検査を通さずに値が入ってくる経路**（動的に組み立てたデータ、外部から渡された値）でも、
 * 同じ規則で弾けることである。
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
          habitat: "Lambda",
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
          habitat: "none",
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
    name: "見出しに habitat があれば拒む（見出しは量を扱わない）",
    expect: /habitat is not allowed/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_heading_habitat",
          kind: "heading",
          level: 1,
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 4,
          title: { text: "見出し" },
          labels: [],
          habitat: "Lambda",
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
          target: ["scaffold_def_placeholder"],
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
          habitat: "Lambda",
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
    name: "conversion.status が想定外の値なら拒む",
    expect: /conversion.status must be one of/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_status",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 6,
          labels: [],
          habitat: "Lambda",
          statement: [],
          conversion: { status: "convertd" },
        } as never,
      ]),
  },
  {
    name: "タイトルが text も tex も持たないなら拒む",
    expect: /must have text or tex/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_title",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 7,
          title: {},
          labels: [],
          habitat: "Lambda",
          statement: [],
        } as never,
      ]),
  },
  {
    name: "sourceOrdinal が整数でないなら拒む",
    expect: /sourceOrdinal must be an integer/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_ordinal",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 2.5,
          labels: [],
          habitat: "Lambda",
          statement: [],
        } as never,
      ]),
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
          habitat: "Lambda",
          statement: [{ type: "pargaraph", children: [] } as never],
        },
      ]),
  },

  // --- ここから本プロジェクト固有（可算／非可算の分別と ℝ 脱出の明示）-------------
  {
    name: "【固有】本文ブロックに habitat が無ければ拒む",
    expect: /habitat が無い/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_habitat_missing",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 8,
          labels: [],
          statement: [],
        } as never,
      ]),
  },
  {
    name: "【固有】habitat が未知の値なら拒む",
    expect: /habitat must be one of/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_habitat_unknown",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 9,
          labels: [],
          habitat: "Lamda",
          statement: [],
        } as never,
      ]),
  },
  {
    name: "【固有】可算な habitat に realEscape があれば拒む",
    expect: /realEscape は habitat "Z"（可算側）では書けない/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_escape_on_countable",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 10,
          labels: [],
          habitat: "Z",
          realEscape: "ここで ℝ を使った",
          statement: [],
        } as never,
      ]),
  },
  {
    name: "【固有】非可算な habitat に realEscape が無ければ拒む",
    expect: /realEscape が無い/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_escape_missing",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 11,
          labels: [],
          habitat: "R",
          statement: [],
        } as never,
      ]),
  },
  {
    name: "【固有】realEscape が空文字なら拒む（脱出箇所を具体的に書かせる）",
    expect: /realEscape が空/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_escape_blank",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 12,
          labels: [],
          habitat: "mixed",
          realEscape: "   ",
          statement: [],
        } as never,
      ]),
  },
  {
    name: "【固有】verification が配列でなければ拒む",
    expect: /verification must be an array of strings/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_verification",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 13,
          labels: [],
          habitat: "Qbar",
          verification: "sagemath/check/foo",
          statement: [],
        } as never,
      ]),
  },
  {
    name: "【固有】lean の要素が文字列でなければ拒む",
    expect: /lean\[\] must be a string/,
    run: () =>
      defineBlocks([
        {
          id: "runtime_test_lean",
          kind: "claim",
          sourcePath: "tools/schema-runtime-test.ts",
          sourceOrdinal: 14,
          labels: [],
          habitat: "Qbar",
          lean: [42],
          statement: [],
        } as never,
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
