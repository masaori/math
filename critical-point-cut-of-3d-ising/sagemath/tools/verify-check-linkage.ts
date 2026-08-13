#!/usr/bin/env node

import { existsSync } from "node:fs";
import { readdir, readFile } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { ALL_LABELS } from "../../structured-latex/labels.generated.ts";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "..", "..");
const checkRoot = join(projectRoot, "sagemath", "check");
const labelPattern = /^\*\*対象ラベル\*\*:\s*`([^`]+)`/m;

const contentLabels = new Set<string>(ALL_LABELS);
const directories = (await readdir(checkRoot, { withFileTypes: true }))
  .filter((entry) => entry.isDirectory())
  .map((entry) => entry.name)
  .sort();
const problems: string[] = [];
let verified = 0;

for (const directory of directories) {
  const overview = join(checkRoot, directory, "overview.md");
  if (!existsSync(overview)) {
    problems.push(`${directory}: overview.md が無い`);
    continue;
  }
  const match = (await readFile(overview, "utf8")).match(labelPattern);
  const label = match?.[1];
  if (label === undefined) {
    problems.push(`${directory}: 対象ラベルの宣言が無い`);
  } else if (!contentLabels.has(label)) {
    problems.push(`${directory}: 対象ラベル ${label} が本文に存在しない`);
  } else {
    verified += 1;
  }
}

if (problems.length > 0) {
  for (const problem of problems) console.error(problem);
  process.exit(1);
}

console.log(`verified ${verified} SageMath check linkage(s)`);
