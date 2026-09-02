#!/usr/bin/env node
/**
 * SageMath 検算の overview.md が宣言する対象ラベルの実在を検査する。
 *
 * 対象ラベルの宣言は fail-closed に扱う。overview.md ごとに宣言はちょうど一つとし、
 * 値は「構造化記述に実在するラベル」か「未昇格」のどちらかでなければならない。
 * 宣言の重複・欠落・未知の書式はすべて失敗とし、宣言が複数あるときに先頭だけを見て
 * 残りを検査しないこと、および未昇格の一行が混ざるだけで対応が黙って落ちることを防ぐ。
 */

import { existsSync } from "node:fs";
import { readdir, readFile } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { ALL_LABELS } from "../../structured-latex/labels.generated.ts";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "../..");
const checkRoot = join(projectRoot, "sagemath", "check");

const declarationMarkerPattern = /^[ \t]*\*\*対象ラベル\*\*.*$/gm;
const declarationPattern = /^[ \t]*\*\*対象ラベル\*\*:[ \t]*(.*)$/;
const labelValuePattern = /^`([^`]+)`$/;
const unpromotedValuePattern = /^未昇格(?:（[^\r\n]*）)?$/;

type Declaration =
  | { readonly kind: "label"; readonly label: string }
  | { readonly kind: "unpromoted" };

/** overview.md の本文から対象ラベル宣言を一つだけ取り出す。取り出せない理由は文字列で返す。 */
function readDeclaration(text: string): Declaration | { readonly error: string } {
  const declarationLines = [...text.matchAll(declarationMarkerPattern)].map((match) => match[0]);
  if (declarationLines.length === 0) return { error: "対象ラベル宣言が無い" };
  if (declarationLines.length > 1) {
    return { error: `対象ラベル宣言が ${declarationLines.length} 個ある（ちょうど一つでなければならない）` };
  }
  const match = declarationLines[0].match(declarationPattern);
  if (match === null) {
    return { error: `対象ラベル宣言の行 "${declarationLines[0].trim()}" が正規の書式でない` };
  }
  const value = match[1].trim();
  if (unpromotedValuePattern.test(value)) return { kind: "unpromoted" };
  const label = value.match(labelValuePattern)?.[1];
  if (label === undefined) {
    return { error: `対象ラベル宣言の値 "${value}" が、バッククォート付きラベルでも未昇格でもない` };
  }
  return { kind: "label", label };
}

/** 宣言の読み取りが fail-closed であることを、常時実行される負例で固定する。 */
function runDeclarationRegression(): void {
  const promoted = "# 検算\n\n**対象ラベル**: `claim_example`\n\n本文\n";
  const cases: ReadonlyArray<{ readonly name: string; readonly text: string; readonly expectError: boolean }> = [
    { name: "正例: 昇格済みの単一宣言", text: promoted, expectError: false },
    { name: "正例: 未昇格の単一宣言", text: "**対象ラベル**: 未昇格（探索）\n", expectError: false },
    {
      name: "負例: 未昇格行が混ざり対応が黙って落ちる",
      text: `${promoted}\n**対象ラベル**: 未昇格（別の検算についての言及）\n`,
      expectError: true,
    },
    {
      name: "負例: 二つ目の宣言が検査されない",
      text: `${promoted}\n**対象ラベル**: \`claim_does_not_exist_at_all\`\n`,
      expectError: true,
    },
    { name: "負例: 宣言が無い", text: "# 検算\n\n本文\n", expectError: true },
    { name: "負例: 値が書式に合わない", text: "**対象ラベル**: claim_example\n", expectError: true },
    {
      name: "負例: ラベルの後ろに別の値が続く",
      text: "**対象ラベル**: `claim_example` と `claim_other`\n",
      expectError: true,
    },
    {
      name: "負例: 未昇格の後ろに正規でない注記が続く",
      text: "**対象ラベル**: 未昇格 arbitrary suffix\n",
      expectError: true,
    },
    {
      name: "負例: コロンを欠く宣言行",
      text: "**対象ラベル** `claim_example`\n",
      expectError: true,
    },
  ];
  const failures: string[] = [];
  for (const testCase of cases) {
    const result = readDeclaration(testCase.text);
    const isError = "error" in result;
    if (isError !== testCase.expectError) {
      failures.push(`${testCase.name}: 期待 ${testCase.expectError ? "失敗" : "成功"} に反した`);
    }
  }
  if (failures.length > 0) {
    console.error("対象ラベル宣言の読み取りが回帰検査に反している:");
    for (const failure of failures) console.error(`  - ${failure}`);
    process.exit(1);
  }
  console.log(`verified ${cases.length} declaration regression case(s)`);
}

runDeclarationRegression();

const labels = new Set<string>(ALL_LABELS);
const directories = (await readdir(checkRoot, { withFileTypes: true }))
  .filter((entry) => entry.isDirectory())
  .map((entry) => entry.name)
  .sort();
const problems: string[] = [];
let linked = 0;
let unpromoted = 0;

for (const directory of directories) {
  const overview = join(checkRoot, directory, "overview.md");
  if (!existsSync(overview)) {
    problems.push(`${directory}: overview.md が無い`);
    continue;
  }
  const declaration = readDeclaration(await readFile(overview, "utf8"));
  if ("error" in declaration) {
    problems.push(`${directory}: ${declaration.error}`);
    continue;
  }
  if (declaration.kind === "unpromoted") {
    unpromoted += 1;
    continue;
  }
  if (!labels.has(declaration.label)) {
    problems.push(`${directory}: 対象ラベル ${declaration.label} が構造化記述に存在しない`);
    continue;
  }
  const entries = await readdir(join(checkRoot, directory));
  if (!entries.some((entry) => entry.endsWith(".sage"))) {
    problems.push(`${directory}: 昇格済みの対象を宣言しているのに .sage の検算が無い`);
    continue;
  }
  linked += 1;
}

if (problems.length > 0) {
  console.error("検算と構造化記述の対応が壊れている:");
  for (const problem of problems) console.error(`  - ${problem}`);
  process.exit(1);
}

console.log(`verified ${linked} check(s) linked to structured-latex labels`);
console.log(`recorded ${unpromoted} exploratory check(s) as not yet promoted`);
