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
 * 使い方: node sagemath/tools/verify-check-linkage.mjs
 */

import { readdir, readFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "..", "..");
const checkRoot = join(projectRoot, "sagemath", "check");
const contentRoot = join(projectRoot, "structured-latex", "content");

const LABEL_RE = /^\*\*対象ラベル\*\*:\s*`([^`]+)`/m;

/** structured-latex/content の全ブロックが定義するラベル集合を集める。 */
async function collectContentLabels() {
  const labels = new Set();
  const files = (await readdir(contentRoot)).filter((f) => f.endsWith(".mjs"));
  for (const file of files) {
    const mod = await import(pathToFileURL(join(contentRoot, file)).href);
    for (const exported of Object.values(mod)) {
      const blocks = Array.isArray(exported) ? exported : [exported];
      for (const block of blocks) {
        if (!block || typeof block !== "object") continue;
        for (const label of block.labels ?? []) labels.add(label);
      }
    }
  }
  return labels;
}

async function main() {
  if (!existsSync(checkRoot)) {
    console.error(`check ディレクトリが無い: ${checkRoot}`);
    process.exit(1);
  }

  const contentLabels = await collectContentLabels();
  const dirs = (await readdir(checkRoot, { withFileTypes: true }))
    .filter((d) => d.isDirectory())
    .map((d) => d.name)
    .sort();

  const problems = [];
  let ok = 0;

  for (const dir of dirs) {
    const overview = join(checkRoot, dir, "overview.md");
    if (!existsSync(overview)) {
      problems.push(`${dir}: overview.md が無い`);
      continue;
    }
    const text = await readFile(overview, "utf8");
    const match = text.match(LABEL_RE);
    if (!match) {
      problems.push(
        `${dir}: overview.md に「**対象ラベル**: \`<label>\`」の宣言が無い`,
      );
      continue;
    }
    const label = match[1];
    if (!contentLabels.has(label)) {
      problems.push(
        `${dir}: 対象ラベル \`${label}\` が structured-latex/content に存在しない`,
      );
      continue;
    }
    ok += 1;
  }

  if (problems.length > 0) {
    console.error("検証 ↔ 証明 の対応が壊れている:");
    for (const p of problems) console.error(`  - ${p}`);
    process.exit(1);
  }

  console.log(
    `verified ${ok} check(s) linked to structured-latex labels ` +
      `(${contentLabels.size} labels available)`,
  );
}

await main();
