#!/usr/bin/env node
/**
 * 移行漏れ（Typst 原本には証明があるのに、構造化テキスト側が TODO のまま）を検出する。
 *
 * 経緯: Typst → 構造化テキストの移行で **6件の証明が失われていた**（主要定理2件を含む、
 * 合計約1372行）。Typst を `_old/typst/` に温存していたため復旧できたが、
 * 同じ事故を繰り返さないよう機械検証にする。
 *
 * 判定: 各ブロックについて
 *   - 構造化側の proof が todo を含む（＝未証明扱い）
 *   - かつ `sourcePath` の Typst 原本が存在し、そこに TODO でない `#proof[...]` がある
 * なら「移行漏れ」として報告し、exit 1 で落とす。
 *
 * 使い方: node structured-latex/tools/verify-no-lost-proofs.mjs
 *
 * 注意: Typst は更新されない参照用アーカイブなので、この検査は
 * 「原本にあった証明が構造化側へ確実に運ばれたか」の一方向チェックである。
 * 構造化側で新たに書いた証明は Typst に無くてよい（そちらは検査しない）。
 */

import { readdir, readFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "..", "..");
const contentRoot = join(projectRoot, "structured-latex", "content");

/** ブロックの proof に todo ノードが含まれるか。 */
function proofIsTodo(block) {
  if (!Array.isArray(block.proof)) return false;
  return JSON.stringify(block.proof).includes('"type":"todo"');
}

/** Typst 原本に「TODO でない実証明」があるか。 */
function typstHasRealProof(source) {
  if (!source.includes("#proof[")) return false;
  // `#proof[TODO]` / `#proof[TODO: …]` / `#proof[ TODO` のみなら実証明ではない
  const onlyTodo = /#proof\[\s*TODO/.test(source);
  return !onlyTodo;
}

async function main() {
  const files = (await readdir(contentRoot))
    .filter((f) => f.endsWith(".mjs"))
    .sort();

  const lost = [];
  let checked = 0;

  for (const file of files) {
    const mod = await import(pathToFileURL(join(contentRoot, file)).href);
    for (const block of mod.default ?? []) {
      if (block.kind === "heading") continue;
      if (!proofIsTodo(block)) continue;
      const sourcePath = block.sourcePath;
      if (!sourcePath) continue;
      const abs = join(projectRoot, sourcePath);
      if (!existsSync(abs)) continue;
      checked += 1;
      const source = await readFile(abs, "utf8");
      if (typstHasRealProof(source)) {
        lost.push({
          id: block.id,
          sourcePath,
          lines: source.split("\n").length,
        });
      }
    }
  }

  if (lost.length > 0) {
    console.error(
      "移行漏れを検出（Typst 原本に証明があるのに構造化側が TODO のまま）:",
    );
    for (const l of lost) {
      console.error(`  - ${l.id}`);
      console.error(`      原本: ${l.sourcePath}（${l.lines} 行）`);
    }
    console.error(
      "\n原本から証明を復旧すること（原本は更新しない・参照専用）。",
    );
    process.exit(1);
  }

  console.log(
    `no lost proofs: TODO ブロック ${checked} 件はいずれも原本側も未証明`,
  );
}

await main();
