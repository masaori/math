#!/usr/bin/env node
/**
 * 移行漏れ（Typst 原本には証明があるのに、構造化テキスト側が TODO のまま）を検出する。
 *
 * 経緯: Typst → 構造化テキストの移行で **2件の証明が失われていた**
 * （主要定理 `T_(V)=T_(V')` と `V=cV'`、原本 296行 + 177行）。
 * Typst を `_old/typst/` に温存していたため復旧できたが、同じ事故を繰り返さないよう機械検証にする。
 *
 * 判定: 各ブロックについて
 *   - 構造化側の proof が **todo の印だけで中身が無い**
 *   - かつ `sourcePath` の Typst 原本に **完成した証明**（空でなく TODO も含まない）がある
 * なら「移行漏れ」として報告し、exit 1 で落とす。
 *
 * 判定を上記まで絞る理由（実測に基づく）:
 *   - 原本の proof が空、または途中で TODO で止まっている例が複数ある
 *     （598行あっても末尾が「一旦具体の計算は飛ばす」で終わる等）。行数では判定できない。
 *   - 構造化側が原本の証明を再現したうえで、原本に無い部分へ todo を付けている正常な例もある。
 *   いずれも移行漏れではないので、素朴な条件だと誤検出になる。
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

/**
 * 構造化側の proof が「印だけで中身が無い」か。
 *
 * todo が含まれるだけでは駄目で（原本の証明を再現したうえで、欠けている部分に
 * 印を付けている正常なケースがある）、**todo 以外の実質的な内容が無い**ときにだけ
 * 「証明が入っていない」と判定する。
 */
function proofIsEmptyExceptTodo(block) {
  if (!Array.isArray(block.proof)) return false;
  const json = JSON.stringify(block.proof);
  if (!json.includes('"type":"todo"')) return false;

  let substantive = 0;
  const walk = (node) => {
    if (!node || typeof node !== "object") return;
    if (node.type === "todo") return; // 印そのものは数えない
    if (node.type === "math" || node.type === "displayMath") {
      substantive += (node.tex ?? "").trim().length;
      return;
    }
    if (node.type === "text") {
      substantive += (node.value ?? "").trim().length;
      return;
    }
    for (const key of ["children", "items", "body"]) {
      const child = node[key];
      if (!Array.isArray(child)) continue;
      for (const c of child) {
        if (Array.isArray(c)) c.forEach(walk);
        else walk(c);
      }
    }
  };
  for (const node of block.proof) walk(node);

  // 「TODO」という語だけが残る程度なら中身なしとみなす
  return substantive < 40;
}

/**
 * `#proof[...]` の本体を括弧の対応をとって抜き出す（無ければ null）。
 */
function extractProofBody(source) {
  const start = source.indexOf("#proof[");
  if (start === -1) return null;
  let depth = 0;
  const from = start + "#proof".length;
  for (let i = from; i < source.length; i += 1) {
    const ch = source[i];
    if (ch === "[") depth += 1;
    else if (ch === "]") {
      depth -= 1;
      if (depth === 0) return source.slice(from + 1, i);
    }
  }
  return null;
}

/**
 * Typst 原本に「完成した実証明」があるか。
 *
 * 誤検出を避けるため、次のいずれかなら「完成した証明ではない」と判定する:
 *   - `#proof` が無い / 本体が空（空白のみ）
 *   - 本体のどこかに TODO・未完メモがある（原文が途中で止まっているケース。
 *     例:「TODO: 同様」「一旦具体の計算は飛ばす」）
 *
 * 実測に基づく注意: 行数は証明の有無の判定にならない。
 * 598行あっても末尾が「TODO: …一旦飛ばす」で終わっている例が実在した。
 */
function typstHasRealProof(source) {
  const body = extractProofBody(source);
  if (body === null) return false;
  if (body.trim().length === 0) return false;
  if (/TODO|証明略|飛ばす/.test(body)) return false;
  return true;
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
      if (!proofIsEmptyExceptTodo(block)) continue;
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
