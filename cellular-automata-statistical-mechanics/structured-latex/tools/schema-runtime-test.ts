#!/usr/bin/env node
/**
 * 実行時検証が、型を経由せずに入ってくる値（動的に組み立てたデータ、外部から渡された値）を
 * 確かに拒むかのテスト。
 *
 * 入力言語そのものの実行時検証（ノード種別、見出しに本文、`proof` の打ち間違い、
 * ノートの targets が空 ほか）はシステム側の単体テスト
 * （`structured-latex/domain-model/structured-text/validate.test.ts`）が持つ。
 * ここに残すのは、このプロジェクトが宣言したメタデータ（住処 `habitat` と脱出 `realEscape`）
 * に関する検査だけである。
 *
 * システムの実行時スキーマは throw せず Result を返すので、
 * 「例外が飛ぶか」ではなく「`success: false` と、その指摘の中身」を見る。
 * 住処と realEscape の対応（フィールド間の条件）は zod では見られないので `checkHabitation` が見る。
 *
 * 使い方: node tools/schema-runtime-test.ts
 */

import { checkHabitation, runtimeSchema } from "../schema.ts";

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

// --- スキーマ（キー単位）の検査 ----------------------------------------------

const schemaCases: Case[] = [
  {
    name: "habitat が想定外の値なら拒む",
    value: { ...base, habitat: "countably_infinite" },
    expect: /habitat/,
  },
  {
    name: "realEscape が空文字なら拒む",
    value: { ...base, habitat: "R", realEscape: "" },
    expect: /realEscape/,
  },
  {
    name: "verification が文字列の配列でないなら拒む",
    value: { ...base, habitat: "N", verification: "sagemath/check/foo" },
    expect: /verification/,
  },
  {
    name: "宣言していないメタデータのキーを拒む（他プロジェクトの語彙の混入）",
    value: { ...base, habitat: "N", conversion: { status: "added" } },
    expect: /conversion|Unrecognized key/,
  },
  {
    name: "見出しはメタデータを持てない（住処は定理型だけ）",
    value: {
      id: "runtime_test_heading",
      kind: "heading",
      level: 2,
      title: { text: "見出し" },
      labels: [],
      habitat: "N",
    },
    expect: /habitat|Unrecognized key/,
  },
];

let failed = 0;
for (const testCase of schemaCases) {
  const result = runtimeSchema.validateBlock(testCase.value, "tools/schema-runtime-test.ts");
  if (result.success) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 拒まれなかった`);
    continue;
  }
  const rendered = result.error.map((issue) => `${issue.path}: ${issue.message}`).join("\n");
  if (!testCase.expect.test(rendered)) {
    failed += 1;
    console.error(
      `✗ ${testCase.name}: 指摘の内容が想定外\n    ${rendered.split("\n").join("\n    ")}`,
    );
    continue;
  }
  console.log(`✓ ${testCase.name}`);
}

// --- フィールド間の条件（住処 ↔ realEscape）の検査 ---------------------------

const habitationCases: { name: string; value: Parameters<typeof checkHabitation>[0]; expect: RegExp }[] =
  [
    {
      name: "住処の宣言が無いブロックを拒む",
      value: { id: "no_habitat" },
      expect: /habitat が無い/,
    },
    {
      name: "非可算な住処なのに realEscape が無いブロックを拒む",
      value: { id: "escaping_without_reason", habitat: "R" },
      expect: /realEscape が無い/,
    },
    {
      name: "可算な住処なのに realEscape を書いたブロックを拒む",
      value: { id: "countable_with_reason", habitat: "N", realEscape: "連続極限" },
      expect: /realEscape は habitat/,
    },
  ];

for (const testCase of habitationCases) {
  const issues = checkHabitation(testCase.value);
  const rendered = issues.join("\n");
  if (issues.length === 0) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 拒まれなかった`);
    continue;
  }
  if (!testCase.expect.test(rendered)) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 指摘の内容が想定外\n    ${rendered}`);
    continue;
  }
  console.log(`✓ ${testCase.name}`);
}

// 正しい値は通ること（対照。常に落ちているだけの状態を正常と誤認しないため）。
const control = runtimeSchema.validateBlock(
  {
    ...base,
    habitat: "mixed",
    realEscape: "熱力学極限 L→∞ の存在を示すために単調有界収束を使う",
    verification: ["sagemath/check/partition-polynomial-coefficient-sum"],
    lean: ["CellularAutomata.dependency_support"],
  },
  "tools/schema-runtime-test.ts",
);
if (!control.success) {
  failed += 1;
  console.error(
    `✗ 正しいブロックが拒まれた（テストの設定不備）:\n    ${control.error
      .map((issue) => `${issue.path}: ${issue.message}`)
      .join("\n    ")}`,
  );
} else if (checkHabitation({ id: "control", habitat: "mixed", realEscape: "熱力学極限" }).length > 0) {
  failed += 1;
  console.error("✗ 正しい住処の宣言が checkHabitation に拒まれた（テストの設定不備）");
} else {
  console.log("✓ 正しいブロック（住処と脱出理由つき）は通る");
}

if (failed > 0) {
  console.error(`\n${failed} 件の実行時検証テストが期待どおりに動かなかった`);
  process.exit(1);
}
console.log(
  `\n実行時検証テスト ${schemaCases.length + habitationCases.length + 1} 件すべて期待どおり`,
);
