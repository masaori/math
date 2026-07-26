#!/usr/bin/env node
/**
 * SageMath 数値検証 ↔ 証明本体(structured-latex) の対応を検証する。
 *
 * 各 sagemath/check/<dir>/overview.md は
 *   **対象ラベル**: `<label>`
 * の行で、検証対象の claim を structured-latex 側の**ラベル**で宣言する。
 * ラベルは Typst(parts) と structured-latex の双方で使われる安定識別子なので、
 * Typst 廃止後もこの対応は生き残る。
 *
 * このスクリプトは
 *   1. 各 check が対象ラベルを宣言していること
 *   2. そのラベルが structured-latex/content に実在すること
 * を検査し、破れていれば exit 1 で落とす。
 *
 * ラベルの実在判定には `structured-latex/labels.generated.ts`（content から生成される
 * ユニオン型の元データ）を使う。生成物と content の一致は
 * `structured-latex/tools/validate-content.ts` が担保している。
 *
 * 使い方: node sagemath/tools/verify-check-linkage.ts
 */

import { existsSync } from "node:fs";
import { readdir, readFile } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { ALL_LABELS } from "../../structured-latex/labels.generated.ts";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "..", "..");
const checkRoot = join(projectRoot, "sagemath", "check");

const LABEL_RE = /^\*\*対象ラベル\*\*:\s*`([^`]+)`/m;

async function main(): Promise<void> {
  if (!existsSync(checkRoot)) {
    console.error(`check ディレクトリが無い: ${checkRoot}`);
    process.exit(1);
  }

  const contentLabels = new Set<string>(ALL_LABELS);
  const dirs = (await readdir(checkRoot, { withFileTypes: true }))
    .filter((entry) => entry.isDirectory())
    .map((entry) => entry.name)
    .sort();

  const problems: string[] = [];
  let ok = 0;

  for (const dir of dirs) {
    const overview = join(checkRoot, dir, "overview.md");
    if (!existsSync(overview)) {
      problems.push(`${dir}: overview.md が無い`);
      continue;
    }
    const text = await readFile(overview, "utf8");
    const match = text.match(LABEL_RE);
    const label = match?.[1];
    if (label === undefined) {
      problems.push(`${dir}: overview.md に「**対象ラベル**: \`<label>\`」の宣言が無い`);
      continue;
    }
    if (!contentLabels.has(label)) {
      problems.push(`${dir}: 対象ラベル \`${label}\` が structured-latex/content に存在しない`);
      continue;
    }
    ok += 1;
  }

  if (problems.length > 0) {
    console.error("検証 ↔ 証明 の対応が壊れている:");
    for (const problem of problems) console.error(`  - ${problem}`);
    process.exit(1);
  }

  console.log(
    `verified ${ok} check(s) linked to structured-latex labels ` +
      `(${contentLabels.size} labels available)`,
  );
}

await main();
