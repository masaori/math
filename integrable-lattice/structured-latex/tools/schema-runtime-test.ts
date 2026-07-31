#!/usr/bin/env node
/**
 * 具体化した実行時スキーマが、型で守れない／型を回避された入力を確かに拒むかのテスト。
 *
 * ブロック 1 件の形の検査そのものは**システム側の単体テストが持つ**ので、ここには複製しない。
 * ここで確認するのは、本プロジェクトの具体化に固有な次の 2 点である。
 *
 *   1. **宣言した固有メタデータのキーだけが許可される**こと。
 *      `habitat` / `realEscape` / `verification` / `lean` は通り、宣言していないキー
 *      （`sourcePath` のような移行前の残骸、綴り違い）は「未知のフィールド」として拒否される。
 *      見出し・図表には固有メタデータが織り込まれないので、見出しの `habitat` も拒否される。
 *   2. **住処と realEscape の対応**（フィールド間の条件）が実行時にも掛かること。
 *      zod のオブジェクトスキーマはキー単位でしか見ないので、これは `checkHabitation` が担う。
 *
 * システムの検証は throw せず Result を返すので、ここでも「落ちたか」ではなく
 * 「どの診断が出たか」で判定する。
 *
 * 使い方: node tools/schema-runtime-test.ts
 */

import { checkHabitation, runtimeSchema } from "../schema.ts";

type Case = {
  name: string;
  /** 検証で出た診断メッセージ（すべて連結したもの）。 */
  run: () => string;
  expect: RegExp;
};

/** ブロック 1 件を検証し、診断を 1 本の文字列にして返す（合格なら空文字）。 */
const validate = (value: unknown): string => {
  const result = runtimeSchema.validateBlock(value, "schema-runtime-test");
  return result.success ? "" : result.error.map((i) => `${i.path}: ${i.message}`).join("\n");
};

const validateNote = (value: unknown): string => {
  const result = runtimeSchema.validateNote(value, "schema-runtime-test");
  return result.success ? "" : result.error.map((i) => `${i.path}: ${i.message}`).join("\n");
};

const cases: Case[] = [
  // --- 1. 宣言した固有メタデータのキーだけが許可される -------------------------
  {
    name: "【固有】habitat / realEscape / verification / lean は許可キーとして通る",
    expect: /^$/,
    run: () =>
      validate({
        id: "runtime_test_meta_ok",
        kind: "claim",
        labels: [],
        habitat: "mixed",
        realEscape: "連続極限をとる一点だけ ℝ へ出る",
        verification: ["sagemath/check/cycle15_T3_tau_d3"],
        lean: ["IntegrableLattice.Scaffold.example"],
        statement: [],
      }),
  },
  {
    name: "【固有】habitat の綴り違い（Lamda）を拒む",
    expect: /habitat/,
    run: () =>
      validate({
        id: "runtime_test_habitat_unknown",
        kind: "claim",
        labels: [],
        habitat: "Lamda",
        statement: [],
      }),
  },
  {
    name: "【固有】宣言していないキー（移行前の sourcePath）を拒む",
    expect: /sourcePath|Unrecognized/,
    run: () =>
      validate({
        id: "runtime_test_legacy_key",
        kind: "claim",
        labels: [],
        sourcePath: "tools/schema-runtime-test.ts",
        habitat: "Lambda",
        statement: [],
      }),
  },
  {
    name: "【固有】固有メタデータの綴り違い（realEscapes）を拒む",
    expect: /realEscapes|Unrecognized/,
    run: () =>
      validate({
        id: "runtime_test_meta_typo",
        kind: "claim",
        labels: [],
        habitat: "R",
        realEscapes: "打ち間違い",
        statement: [],
      }),
  },
  {
    name: "【固有】見出しに habitat があれば拒む（見出しは量を扱わない）",
    expect: /habitat|Unrecognized/,
    run: () =>
      validate({
        id: "runtime_test_heading_habitat",
        kind: "heading",
        level: 1,
        title: { text: "見出し" },
        labels: [],
        habitat: "Lambda",
      }),
  },
  {
    name: "【固有】verification が配列でなければ拒む",
    expect: /verification/,
    run: () =>
      validate({
        id: "runtime_test_verification",
        kind: "claim",
        labels: [],
        habitat: "Qbar",
        verification: "sagemath/check/foo",
        statement: [],
      }),
  },
  {
    name: "【固有】lean の要素が文字列でなければ拒む",
    expect: /lean/,
    run: () =>
      validate({
        id: "runtime_test_lean",
        kind: "claim",
        labels: [],
        habitat: "Qbar",
        lean: [42],
        statement: [],
      }),
  },
  {
    name: "ノートの未知フィールドを拒む（具体化しても .strict() が効いていること）",
    expect: /target|Unrecognized/,
    run: () =>
      validateNote({
        id: "note_runtime_test_typo",
        target: ["paper_def_curve"],
        body: [],
      }),
  },

  // --- 2. 住処と realEscape の対応（フィールド間の条件）-------------------------
  {
    name: "【固有】本文ブロックに habitat が無ければ拒む",
    expect: /habitat が無い/,
    run: () => checkHabitation({ id: "runtime_test_habitat_missing" }).join("\n"),
  },
  {
    name: "【固有】可算な habitat に realEscape があれば拒む",
    expect: /realEscape は habitat "Z"（可算側）では書けない/,
    run: () =>
      checkHabitation({
        id: "runtime_test_escape_on_countable",
        habitat: "Z",
        realEscape: "ここで ℝ を使った",
      }).join("\n"),
  },
  {
    name: "【固有】非可算な habitat に realEscape が無ければ拒む",
    expect: /realEscape が無い/,
    run: () => checkHabitation({ id: "runtime_test_escape_missing", habitat: "R" }).join("\n"),
  },
  {
    name: "【固有】realEscape が空文字なら拒む（脱出箇所を具体的に書かせる）",
    expect: /realEscape が空/,
    run: () =>
      checkHabitation({
        id: "runtime_test_escape_blank",
        habitat: "mixed",
        realEscape: "   ",
      }).join("\n"),
  },
  {
    name: "【固有】可算な habitat で realEscape が無ければ通る（対照）",
    expect: /^$/,
    run: () => checkHabitation({ id: "runtime_test_countable_ok", habitat: "Lambda" }).join("\n"),
  },
];

let failed = 0;
for (const testCase of cases) {
  const message = testCase.run();
  if (!testCase.expect.test(message)) {
    failed += 1;
    console.error(`✗ ${testCase.name}: 診断が想定外\n    ${message || "(診断なし＝素通りした)"}`);
    continue;
  }
  console.log(`✓ ${testCase.name}`);
}

if (failed > 0) {
  console.error(`\n${failed} 件の実行時検証テストが期待どおりに動かなかった`);
  process.exit(1);
}
console.log(`\n実行時検証テスト ${cases.length} 件すべて期待どおり`);
