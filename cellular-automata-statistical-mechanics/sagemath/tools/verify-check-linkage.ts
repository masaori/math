#!/usr/bin/env node
/**
 * SageMath 検算の overview.md が宣言する対象ラベルの実在を検査する。
 *
 * 対象ラベルの宣言は fail-closed に扱う。overview.md ごとに宣言はちょうど一つとし、
 * 値は「構造化記述に実在するラベル」か「未昇格」のどちらかでなければならない。
 * 宣言の重複・欠落・未知の書式はすべて失敗とし、宣言が複数あるときに先頭だけを見て
 * 残りを検査しないこと、および未昇格の一行が混ざるだけで対応が黙って落ちることを防ぐ。
 *
 * 検算ディレクトリの走査も fail-closed に扱う。検算の木の形を「検算の根の直下は
 * README.md と検算ディレクトリだけ」「検算ディレクトリの中は通常ファイルだけ」と定め、
 * これに合わない要素をすべて失敗とする。ディレクトリでない要素を黙って読み飛ばすと、
 * 入れ子にした検算ディレクトリ、検算の根へ直接置いた overview.md や .sage、
 * ディレクトリへの symlink が一度も検査されないまま終了コード 0 で通ってしまう。
 */

import type { Dirent } from "node:fs";
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

/** 木の形の検査が扱う要素の種類。symlink は directory でも file でもない第三の種類へ落ちる。 */
type EntryKind = "file" | "directory" | "other";

type Entry = { readonly name: string; readonly kind: EntryKind };

const rootFileAllowList = new Set<string>(["README.md"]);

/** 検算の根の直下に置いてよいのは README.md と検算ディレクトリだけである。 */
function checkRootShape(entries: ReadonlyArray<Entry>): ReadonlyArray<string> {
  const problems: string[] = [];
  for (const entry of entries) {
    if (entry.kind === "directory") continue;
    if (entry.kind === "file" && rootFileAllowList.has(entry.name)) continue;
    problems.push(
      `${entry.name}: 検算の根の直下に置けるのは README.md と検算ディレクトリだけである` +
        `（この要素は ${entry.kind} で、検査されないまま読み飛ばされる）`,
    );
  }
  return problems;
}

/** 検算ディレクトリの中に置いてよいのは通常ファイルだけである（入れ子の検算を作らせない）。 */
function checkDirectoryShape(directory: string, entries: ReadonlyArray<Entry>): ReadonlyArray<string> {
  const problems: string[] = [];
  for (const entry of entries) {
    if (entry.kind === "file") continue;
    problems.push(
      `${directory}/${entry.name}: 検算ディレクトリの中に置けるのは通常ファイルだけである` +
        `（この要素は ${entry.kind} で、検査されないまま読み飛ばされる）`,
    );
  }
  return problems;
}

/** 木の形の検査が fail-closed であることを、常時実行される負例で固定する。 */
function runTreeShapeRegression(): void {
  const cases: ReadonlyArray<{
    readonly name: string;
    readonly problems: ReadonlyArray<string>;
    readonly expectProblem: boolean;
  }> = [
    {
      name: "正例: 根に README.md と検算ディレクトリだけ",
      problems: checkRootShape([
        { name: "README.md", kind: "file" },
        { name: "causal-structure-comparison", kind: "directory" },
      ]),
      expectProblem: false,
    },
    {
      name: "負例: 根へ直接置いた overview.md",
      problems: checkRootShape([{ name: "overview.md", kind: "file" }]),
      expectProblem: true,
    },
    {
      name: "負例: 根へ直接置いた .sage",
      problems: checkRootShape([{ name: "check.sage", kind: "file" }]),
      expectProblem: true,
    },
    {
      name: "負例: 検算ディレクトリへの symlink",
      problems: checkRootShape([{ name: "linked-check", kind: "other" }]),
      expectProblem: true,
    },
    {
      name: "正例: 検算ディレクトリの中が通常ファイルだけ",
      problems: checkDirectoryShape("example", [
        { name: "overview.md", kind: "file" },
        { name: "check.sage", kind: "file" },
      ]),
      expectProblem: false,
    },
    {
      name: "負例: 入れ子にした検算ディレクトリ",
      problems: checkDirectoryShape("example", [
        { name: "overview.md", kind: "file" },
        { name: "inner", kind: "directory" },
      ]),
      expectProblem: true,
    },
    {
      name: "負例: 検算ディレクトリの中の symlink",
      problems: checkDirectoryShape("example", [{ name: "linked.sage", kind: "other" }]),
      expectProblem: true,
    },
  ];
  const failures: string[] = [];
  for (const testCase of cases) {
    if (testCase.problems.length > 0 !== testCase.expectProblem) {
      failures.push(`${testCase.name}: 期待 ${testCase.expectProblem ? "失敗" : "成功"} に反した`);
    }
  }
  if (failures.length > 0) {
    console.error("検算の木の形の検査が回帰検査に反している:");
    for (const failure of failures) console.error(`  - ${failure}`);
    process.exit(1);
  }
  console.log(`verified ${cases.length} tree shape regression case(s)`);
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
runTreeShapeRegression();

/** readdir の結果を木の形の検査が扱う種類へ落とし、名前順に並べる。 */
function toEntries(dirents: ReadonlyArray<Dirent>): ReadonlyArray<Entry> {
  return dirents
    .map((dirent) => ({
      name: dirent.name,
      kind: dirent.isDirectory() ? "directory" : dirent.isFile() ? "file" : "other",
    }) as Entry)
    .sort((left, right) => (left.name < right.name ? -1 : left.name > right.name ? 1 : 0));
}

const labels = new Set<string>(ALL_LABELS);
const rootEntries = toEntries(await readdir(checkRoot, { withFileTypes: true }));
const rootShapeProblems = checkRootShape(rootEntries);
if (rootShapeProblems.length > 0) {
  console.error("検算と構造化記述の対応が壊れている:");
  for (const problem of rootShapeProblems) console.error(`  - ${problem}`);
  process.exit(1);
}
const problems: string[] = [];
const directories = rootEntries.filter((entry) => entry.kind === "directory").map((entry) => entry.name);
let linked = 0;
let unpromoted = 0;
/** 各検算ディレクトリが「対応済み・未昇格・問題あり」のどれか一つへ必ず落ちたことを記録する。 */
const accounted = new Set<string>();

for (const directory of directories) {
  const directoryEntries = toEntries(await readdir(join(checkRoot, directory), { withFileTypes: true }));
  const directoryShapeProblems = checkDirectoryShape(directory, directoryEntries);
  if (directoryShapeProblems.length > 0) {
    problems.push(...directoryShapeProblems);
    accounted.add(directory);
    continue;
  }
  const overview = join(checkRoot, directory, "overview.md");
  if (!existsSync(overview)) {
    problems.push(`${directory}: overview.md が無い`);
    accounted.add(directory);
    continue;
  }
  const declaration = readDeclaration(await readFile(overview, "utf8"));
  if ("error" in declaration) {
    problems.push(`${directory}: ${declaration.error}`);
    accounted.add(directory);
    continue;
  }
  if (declaration.kind === "unpromoted") {
    unpromoted += 1;
    accounted.add(directory);
    continue;
  }
  if (!labels.has(declaration.label)) {
    problems.push(`${directory}: 対象ラベル ${declaration.label} が構造化記述に存在しない`);
    accounted.add(directory);
    continue;
  }
  if (!directoryEntries.some((entry) => entry.name.endsWith(".sage"))) {
    problems.push(`${directory}: 昇格済みの対象を宣言しているのに .sage の検算が無い`);
    accounted.add(directory);
    continue;
  }
  linked += 1;
  accounted.add(directory);
}

/** 走査の網羅性: 検出した検算ディレクトリのうち、どの結末にも落ちなかったものは失敗とする。 */
const unaccounted = directories.filter((directory) => !accounted.has(directory));
for (const directory of unaccounted) {
  problems.push(`${directory}: 走査したがどの結末にも落ちていない（検査から漏れている）`);
}
if (directories.length === 0) {
  problems.push("検算ディレクトリが一つも無い（走査が空振りしている）");
}

if (problems.length > 0) {
  console.error("検算と構造化記述の対応が壊れている:");
  for (const problem of problems) console.error(`  - ${problem}`);
  process.exit(1);
}

console.log(
  `scanned ${directories.length} check director(ies) under sagemath/check ` +
    `(all accounted for: linked ${linked} + unpromoted ${unpromoted})`,
);
console.log(`verified ${linked} check(s) linked to structured-latex labels`);
console.log(`recorded ${unpromoted} exploratory check(s) as not yet promoted`);
