#!/usr/bin/env node
/**
 * SageMath 掃引ツール自身の単体テストを、検証手順から必ず走らせるための検査。
 *
 * 掃引 sweep_all_checks.py の収集・集計は fail-closed に作ってあるが、その性質を守っているのは
 * test_sweep_all_checks.py だけである。この単体テストはどの検証入口からも呼ばれていなかったため、
 * 収集や集計が「検算が一本も走らなくても終了コード 0 で成功する」状態へ戻っても、
 * 手順上の検証はすべて通ってしまう。ここを塞ぐ。
 *
 * 走らせ方自体も fail-closed にする。テストの根が symlink であること、ディレクトリとして
 * 存在しないこと、走査の失敗、symlink または通常ファイルでない test_*.py、テストファイル 0 本、
 * 実行結果の解析不能、実行件数 0 件、テストファイル数より少ない実行件数、skip・expected failure の
 * 混入をすべて失敗とする。「0 件を走らせて成功した」は成功として扱わない。
 */

import { spawnSync } from "node:child_process";
import { readdirSync, lstatSync } from "node:fs";
import { basename, dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const toolsRoot = resolve(here);

const problems: string[] = [];

function fail(message: string): never {
  console.error(`NG ${message}`);
  process.exit(1);
}

let rootStat;
try {
  rootStat = lstatSync(toolsRoot);
} catch (error) {
  fail(`ツールの根 ${toolsRoot} を検査できない: ${String(error)}`);
}
if (rootStat.isSymbolicLink()) fail(`ツールの根 ${toolsRoot} が symlink である`);
if (!rootStat.isDirectory()) fail(`ツールの根 ${toolsRoot} がディレクトリとして存在しない`);

let entries;
try {
  entries = readdirSync(toolsRoot, { withFileTypes: true });
} catch (error) {
  fail(`ツールの走査が ${toolsRoot} で失敗した: ${String(error)}`);
}

const testFiles: string[] = [];
for (const entry of entries.sort((a, b) => a.name.localeCompare(b.name))) {
  if (!(entry.name.startsWith("test_") && entry.name.endsWith(".py"))) continue;
  const path = join(toolsRoot, entry.name);
  if (entry.isSymbolicLink()) {
    problems.push(`${entry.name} は symlink の単体テストである`);
    continue;
  }
  if (!entry.isFile()) {
    problems.push(`${entry.name} は通常の単体テストファイルではない`);
    continue;
  }
  testFiles.push(path);
}
if (testFiles.length === 0) {
  problems.push("単体テストファイルが一本も無い（検証が空振りしている）");
}
if (problems.length > 0) {
  for (const problem of problems) console.error(`NG ${problem}`);
  process.exit(1);
}

const run = spawnSync(
  "python3",
  ["-m", "unittest", "discover", "-s", toolsRoot, "-p", "test_*.py", "-v"],
  { cwd: toolsRoot, encoding: "utf8" },
);
if (run.error) fail(`単体テストを起動できない: ${String(run.error)}`);
const output = `${run.stdout ?? ""}${run.stderr ?? ""}`;
if (run.status !== 0) {
  console.error(output.trimEnd());
  fail(`単体テストが終了コード ${run.status} で失敗した`);
}

const ran = output.match(/^Ran (\d+) tests? in /m);
if (ran === null) {
  console.error(output.trimEnd());
  fail("単体テストの実行件数を読み取れない");
}
const ranCount = Number.parseInt(ran[1], 10);
if (!Number.isInteger(ranCount) || ranCount <= 0) {
  fail(`単体テストの実行件数が ${ran[1]} 件である（1 件以上でなければならない）`);
}
if (ranCount < testFiles.length) {
  fail(`単体テスト ${testFiles.length} ファイルに対し実行件数が ${ranCount} 件しかない`);
}
// 総実行件数だけでは、あるファイルが 0 件でも別ファイルの複数テストで穴埋めできる。
// unittest の verbose 出力に各ファイル由来のモジュール名が現れることを一つずつ確かめる。
for (const testFile of testFiles) {
  const moduleName = basename(testFile, ".py");
  const escapedModuleName = moduleName.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  if (!new RegExp(`\\(${escapedModuleName}\\.`).test(output)) {
    fail(`${basename(testFile)} から実行された単体テストが 1 件も無い`);
  }
}
// skip・expected failure が混ざった回は「走らせたが確かめていない」状態なので成功にしない。
if (!/^OK$/m.test(output)) {
  console.error(output.trimEnd());
  fail("単体テストの結果が OK 単独ではない（skip または expected failure が混ざっている）");
}

console.log(`OK 掃引ツールの単体テスト ${testFiles.length} ファイル・${ranCount} 件が全て通った`);
