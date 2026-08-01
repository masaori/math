#!/usr/bin/env node
/**
 * 「誤った入力を書くと型検査が落ちる」ことの実証テスト。
 *
 * `type-tests/label-typing.test-d.ts` は `@ts-expect-error` による回帰テストで、通常の
 * `tsc` に同乗して回る。こちらは**実際に tsc を落として、その診断メッセージを見せる**ためのテスト。
 * 「型検査は通っているが、実は何も検出していない」状態を否定する。
 *
 * **入力言語一般のケース**（ラベル解決・id/ラベルの重複・見出しと本文の混同・タイトル・
 * targets の空配列・フィールド名の打ち間違い等）は**システム側の負テストが持つ**ので、
 * ここには複製しない。ここに残すのは、本プロジェクトが具体化で足した意味
 * ——**住処（habitat）の必須性と、realEscape との対応（判別共用体）**——が
 * 確かに型で強制されていることの実証だけである。
 *
 * 各ケースは対で回す:
 *   1. 正しい版を書いて tsc → **成功すること**（設定不備で常に落ちているだけではないことの対照）
 *   2. 壊した版を書いて tsc → **失敗し**、診断に期待する語が現れること
 *
 * 使い方: node tools/negative-type-test.ts
 */

import { execFile } from "node:child_process";
import { mkdirSync, rmSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import { ALL_LABELS } from "../labels.generated.ts";
import { structuredLatexDir } from "./content-modules.ts";

const tmpDir = join(structuredLatexDir, "type-tests", ".tmp");
const tsc = join(structuredLatexDir, "node_modules", ".bin", "tsc");

const realLabel = ALL_LABELS[0];
if (realLabel === undefined) {
  throw new Error(
    "labels.generated.ts が空（先に node ../../structured-latex/codegen/structured-text-index/cli.ts --project . を回す）",
  );
}
const brokenLabel = `${realLabel}__does_not_exist`;

type Case = {
  name: string;
  /** `broken` が true のときだけ誤りを含むファイル群を返す。 */
  files: (broken: boolean) => Record<string, string>;
  /** 壊した版の診断に必ず現れるべき文字列。 */
  expect: string;
};

/** 1 ブロック分のリテラル（差し込み用）。`habitat` は本プロジェクトでは必須。 */
const block = (options: {
  id: string;
  labels?: readonly string[];
  statement?: string;
  habitat?: string;
  extra?: string;
}): string => `  {
    id: ${JSON.stringify(options.id)},
    kind: "claim",
    origin: { path: "type-tests/.tmp", ordinal: 1 },
    labels: [${(options.labels ?? []).map((label) => JSON.stringify(label)).join(", ")}],
    habitat: ${JSON.stringify(options.habitat ?? "Lambda")},
    statement: [${options.statement ?? ""}],${options.extra ?? ""}
  },`;

const blocksModule = (body: string, imports = "defineBlocks, paragraph, ref"): string =>
  `import { ${imports} } from "../../../schema.ts";

export default defineBlocks([
${body}
]);
`;

const translatedBlocksModule = (body: string): string =>
  `import { defineTranslatedBlocks, paragraph, refInTranslation as ref } from "../../../schema.ts";

export default defineTranslatedBlocks([
${body}
]);
`;

const cases: Case[] = [
  // --- 翻訳ロケールの束縛（cycle 24 step 2 で足した受け口）-----------------------
  {
    // 翻訳側は翻訳限定ラベルも指せる。それでも「実在しないラベル」は落ちなければならない
    // （広げた受け口が素通しになっていないことの実証）。
    name: "【翻訳】翻訳側の ref が存在しないラベルを指す",
    expect: brokenLabel,
    files: (broken) => ({
      "fixture.ts": translatedBlocksModule(
        block({
          id: "neg_translated_ref",
          statement: `paragraph([ref(${JSON.stringify(broken ? brokenLabel : realLabel)})])`,
        }),
      ),
    }),
  },
  {
    // 翻訳側でも住処の宣言は必須（原文と同じ制約が掛かっていることの実証）。
    name: "【翻訳】翻訳側の本文ブロックが habitat を宣言していない",
    expect: "habitat",
    files: (broken) => ({
      "fixture.ts": translatedBlocksModule(
        broken
          ? `  {
    id: "neg_translated_habitat",
    kind: "claim",
    origin: { path: "type-tests/.tmp", ordinal: 1 },
    labels: [],
    statement: [],
  },`
          : block({ id: "neg_translated_habitat" }),
      ),
    }),
  },

  // --- 具体化が効いていること（システムのファクトリが本当にラベルで束縛されているか）-----
  {
    name: "具体化: 本文中の ref が存在しないラベルを指す",
    expect: brokenLabel,
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_ref",
          statement: `paragraph(["参照: ", ref(${JSON.stringify(broken ? brokenLabel : realLabel)})])`,
        }),
      ),
    }),
  },

  // --- ここから本プロジェクト固有（可算／非可算の分別と ℝ 脱出の明示）-------------
  {
    name: "【固有】本文ブロックが habitat を宣言していない",
    expect: "habitat",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        broken
          ? block({ id: "neg_habitat_missing" }).replace('\n    habitat: "Lambda",', "")
          : block({ id: "neg_habitat_missing" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】habitat が未知の値（住処の綴り違い）",
    expect: "not assignable to type 'CountableHabitat | EscapingHabitat'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({ id: "neg_habitat_unknown", habitat: broken ? "Lamda" : "Lambda" }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】可算な habitat（Z）なのに realEscape を書いている",
    // 可算側の分岐は `realEscape?: never` なので、診断は「文字列を undefined へ入れられない」
    // という形で realEscape の行に出る（対照版は同じ位置で通る）。
    expect: "not assignable to type 'undefined'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_on_countable",
          habitat: "Z",
          extra: broken ? '\n    realEscape: "ここで ℝ を使った",' : "",
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】非可算な habitat（R）なのに realEscape が無い",
    expect: "realEscape",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_missing",
          habitat: "R",
          extra: broken ? "" : '\n    realEscape: "指数評価で実数の順序完備性を使う",',
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】mixed なのに realEscape が無い",
    expect: "realEscape",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_escape_missing_mixed",
          habitat: "mixed",
          extra: broken ? "" : '\n    realEscape: "連続極限をとる一点だけ ℝ へ出る",',
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】見出しブロックが habitat を持つ",
    // 見出しには固有メタデータを `never` で交差してあるので、こちらも undefined への代入で落ちる。
    expect: "not assignable to type 'undefined'",
    files: (broken) => ({
      "fixture.ts": `import { defineBlocks } from "../../../schema.ts";

export default defineBlocks([
  {
    id: "neg_heading_habitat",
    kind: "heading",
    level: 2,
    origin: { path: "type-tests/.tmp", ordinal: 1 },
    title: { text: "見出し" },
    labels: [],${broken ? '\n    habitat: "Lambda",' : ""}
  },
]);
`,
    }),
  },
  {
    name: "【固有】verification が文字列の配列でない",
    expect: "not assignable to type 'readonly string[]'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_verification_type",
          extra: `\n    verification: ${broken ? '"sagemath/check/foo"' : '["sagemath/check/foo"]'},`,
        }),
        "defineBlocks",
      ),
    }),
  },
  {
    name: "【固有】lean が文字列の配列でない",
    expect: "not assignable to type 'readonly string[]'",
    files: (broken) => ({
      "fixture.ts": blocksModule(
        block({
          id: "neg_lean_type",
          extra: `\n    lean: ${broken ? '"Foo.bar"' : '["Foo.bar"]'},`,
        }),
        "defineBlocks",
      ),
    }),
  },
];

// ケース数 × 2 回（対照・破壊）の tsc 起動になるので、並列に回す（逐次だと数分かかる）。
const CONCURRENCY = 6;
const results: string[] = [];
let failed = 0;
let nextIndex = 0;

async function worker(): Promise<void> {
  for (;;) {
    const index = nextIndex;
    nextIndex += 1;
    const testCase = cases[index];
    if (testCase === undefined) return;

    // 1. 正しい版はコンパイルが通る（対照）。
    const control = await runCase(testCase, index, false);
    if (control.status !== 0) {
      failed += 1;
      results[index] = `✗ ${testCase.name}: 正しい入力なのに型検査が落ちた（テストの設定不備）\n${indent(control.output)}`;
      continue;
    }

    // 2. 壊すと型検査が落ち、期待する語が診断に出る。
    const broken = await runCase(testCase, index, true);
    if (broken.status === 0) {
      failed += 1;
      results[index] = `✗ ${testCase.name}: 誤った入力なのに型検査が通ってしまった`;
      continue;
    }
    if (!broken.output.includes(testCase.expect)) {
      failed += 1;
      results[index] = `✗ ${testCase.name}: 型検査は落ちたが、診断が期待と違う\n${indent(broken.output)}`;
      continue;
    }
    results[index] = `✓ ${testCase.name}\n${indent(firstDiagnostic(broken.output))}`;
  }
}

await Promise.all(Array.from({ length: CONCURRENCY }, () => worker()));

for (const line of results) {
  if (line.startsWith("✗")) console.error(line);
  else console.log(line);
}

rmSync(tmpDir, { recursive: true, force: true });

if (failed > 0) {
  console.error(`\n${failed} 件の負テストが期待どおりに動かなかった`);
  process.exit(1);
}
console.log(`\nすべての負テストが期待どおり: 誤った入力は tsc が拒否する（${cases.length} 件）`);

async function runCase(
  testCase: Case,
  index: number,
  broken: boolean,
): Promise<{ status: number; output: string }> {
  // ケースごとに別ディレクトリを使う（並列実行のため）。
  const caseDir = join(tmpDir, `case${index}${broken ? "_broken" : "_ok"}`);
  rmSync(caseDir, { recursive: true, force: true });
  mkdirSync(caseDir, { recursive: true });
  const files = testCase.files(broken);
  for (const [fileName, source] of Object.entries(files)) {
    writeFileSync(join(caseDir, fileName), source, "utf8");
  }
  writeFileSync(
    join(caseDir, "tsconfig.json"),
    `${JSON.stringify(
      {
        extends: "../../../tsconfig.json",
        compilerOptions: { noEmit: true, noUnusedLocals: false },
        include: Object.keys(files),
        // 親の exclude（type-tests/.tmp）を打ち消す。ここでは fixture だけを検査する。
        exclude: [],
      },
      null,
      2,
    )}\n`,
    "utf8",
  );
  return await new Promise((resolve, reject) => {
    execFile(
      tsc,
      ["-p", join(caseDir, "tsconfig.json")],
      { cwd: structuredLatexDir, encoding: "utf8", maxBuffer: 8 * 1024 * 1024 },
      (error, stdout, stderr) => {
        const output = `${stdout}${stderr}`;
        if (error !== null && typeof error.code !== "number") {
          reject(
            new Error(
              `tsc を起動できなかった（${tsc}）: ${error.message}` +
                `\n  修正: (cd ${structuredLatexDir} && pnpm install)`,
            ),
          );
          return;
        }
        resolve({ status: error === null ? 0 : (error.code as number), output });
      },
    );
  });
}

function firstDiagnostic(output: string): string {
  const lines = output.split("\n").filter((line) => line.includes("error TS"));
  return lines[0] ?? output.trim();
}

function indent(text: string): string {
  return text
    .trimEnd()
    .split("\n")
    .map((line) => `    ${line}`)
    .join("\n");
}
