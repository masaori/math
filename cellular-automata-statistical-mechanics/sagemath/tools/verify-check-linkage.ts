#!/usr/bin/env node
/** SageMath 検算の overview.md が宣言する対象ラベルの実在を検査する。 */

import { existsSync } from "node:fs";
import { readdir, readFile } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { ALL_LABELS } from "../../structured-latex/labels.generated.ts";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "../..");
const checkRoot = join(projectRoot, "sagemath", "check");
const labelPattern = /^\*\*対象ラベル\*\*:\s*`([^`]+)`/m;
const unpromotedPattern = /^\*\*対象ラベル\*\*:\s*未昇格/m;

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
  const text = await readFile(overview, "utf8");
  if (unpromotedPattern.test(text)) {
    unpromoted += 1;
    continue;
  }
  const match = text.match(labelPattern);
  const label = match?.[1];
  if (label === undefined) {
    problems.push(`${directory}: 対象ラベル宣言が無い`);
  } else if (!labels.has(label)) {
    problems.push(`${directory}: 対象ラベル ${label} が構造化記述に存在しない`);
  } else {
    linked += 1;
  }
}

if (problems.length > 0) {
  console.error("検算と構造化記述の対応が壊れている:");
  for (const problem of problems) console.error(`  - ${problem}`);
  process.exit(1);
}

console.log(`verified ${linked} check(s) linked to structured-latex labels`);
console.log(`recorded ${unpromoted} exploratory check(s) as not yet promoted`);
