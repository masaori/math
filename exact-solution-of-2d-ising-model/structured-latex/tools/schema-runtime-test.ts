#!/usr/bin/env node
/**
 * 実行時検証が、**型を経由せずに入ってくる値**（動的に組み立てたデータ、外部から渡された値）を
 * 確かに拒むかのテスト。
 *
 * 入力言語そのものの実行時検証（ノード種別、見出しに本文、`proof` の打ち間違い、
 * ノートの targets が空 ほか）は**システム側の単体テスト**
 * （`structured-latex/domain-model/structured-text/validate.test.ts`）が持つ。
 * ここに残すのは、このプロジェクトが宣言したメタデータ `conversion` に関する検査だけである。
 * ——すなわち「`schema.ts` の `blockMeta` 宣言が、実行時にも意図どおり効いているか」の検査。
 *
 * システムの実行時スキーマは **throw せず Result を返す**（docs/error-handling-strategy.md）。
 * したがってここも「例外が飛ぶか」ではなく「`success: false` と、その指摘の中身」を見る。
 *
 * 使い方: node tools/schema-runtime-test.ts
 */

import { runtimeSchema } from "../schema.ts";

type Case = {
  name: string;
  value: unknown;
  /** 指摘のいずれかに現れるべき語。 */
  expect: RegExp;
};

/** 検査対象以外は正しい、最小の定理型ブロック。 */
const base = {
  id: "runtime_test",
  kind: "claim",
  labels: [],
  statement: [],
};

const cases: Case[] = [
  {
    name: "conversion.status が想定外の値なら拒む",
    value: { ...base, conversion: { status: "convertd" } },
    expect: /conversion\.status/,
  },
  {
    name: "conversion.notes が文字列の配列でないなら拒む",
    value: { ...base, conversion: { status: "added", notes: "一行だけのメモ" } },
    expect: /conversion\.notes/,
  },
  {
    name: "conversion の中の未知フィールド（notes の打ち間違い）を拒む",
    value: { ...base, conversion: { status: "added", note: ["メモ"] } },
    expect: /conversion\.note\b|Unrecognized key/,
  },
  {
    name: "宣言していないメタデータのキーを拒む（他プロジェクトの語彙の混入）",
    value: { ...base, habitat: "countable" },
    expect: /habitat|Unrecognized key/,
  },
  {
    name: "見出しはメタデータを持てない（conversion は定理型だけ）",
    value: {
      id: "runtime_test_heading",
      kind: "heading",
      level: 2,
      title: { text: "見出し" },
      labels: [],
      conversion: { status: "added" },
    },
    expect: /conversion|Unrecognized key/,
  },
  {
    name: "由来（origin）の通し番号が正の整数でないなら拒む",
    value: { ...base, origin: { path: "tools/schema-runtime-test.ts", ordinal: 2.5 } },
    expect: /ordinal|integer|整数/,
  },
];

let failed = 0;
for (const testCase of cases) {
  const result = runtimeSchema.validateBlock(testCase.value, "tools/schema-runtime-test.ts");
  if (result.success) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 拒まれなかった`);
    continue;
  }
  const rendered = result.error.map((issue) => `${issue.path}: ${issue.message}`).join("\n");
  if (!testCase.expect.test(rendered)) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 指摘の内容が想定外\n    ${rendered.split("\n").join("\n    ")}`);
    continue;
  }
  console.log(`✓ ${testCase.name}`);
}

// 正しい値は通ること（対照。常に落ちているだけの状態を正常と誤認しないため）。
const control = runtimeSchema.validateBlock(
  { ...base, origin: { path: "tools/schema-runtime-test.ts", ordinal: 1 }, conversion: { status: "added", notes: ["メモ"] } },
  "tools/schema-runtime-test.ts",
);
if (!control.success) {
  failed += 1;
  console.error(
    `✗ 正しいブロックが拒まれた（テストの設定不備）:\n    ${control.error
      .map((issue) => `${issue.path}: ${issue.message}`)
      .join("\n    ")}`,
  );
} else {
  console.log("✓ 正しいブロック（conversion 付き）は通る");
}

if (failed > 0) {
  console.error(`\n${failed} 件の実行時検証テストが期待どおりに動かなかった`);
  process.exit(1);
}
console.log(`\n実行時検証テスト ${cases.length + 1} 件すべて期待どおり`);
