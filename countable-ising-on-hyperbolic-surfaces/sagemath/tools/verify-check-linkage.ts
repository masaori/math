#!/usr/bin/env node
import { existsSync } from "node:fs";
import { readdir, readFile } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { ALL_LABELS } from "../../structured-latex/labels.generated.ts";

const here = dirname(fileURLToPath(import.meta.url));
const checkRoot = resolve(here, "..", "check");
const labelPattern = /^\*\*対象ラベル\*\*:\s*`([^`]+)`/m;
const labels = new Set<string>(ALL_LABELS);
const problems: string[] = [];
let count = 0;

for (const entry of await readdir(checkRoot, { withFileTypes: true })) {
  if (!entry.isDirectory()) continue;
  const overview = join(checkRoot, entry.name, "overview.md");
  if (!existsSync(overview)) {
    problems.push(`${entry.name}: overview.md が無い`);
    continue;
  }
  const match = (await readFile(overview, "utf8")).match(labelPattern);
  const label = match?.[1];
  if (label === undefined || !labels.has(label)) {
    problems.push(`${entry.name}: 対象ラベルが無いか本文に存在しない`);
    continue;
  }
  count += 1;
}

if (problems.length > 0) {
  problems.forEach((problem) => console.error(problem));
  process.exit(1);
}
console.log(`verified ${count} SageMath check linkage(s)`);

