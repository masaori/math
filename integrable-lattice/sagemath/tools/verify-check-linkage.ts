/**
 * 数値検証（SageMath）・Lean 形式検証と、論文の主張（構造化テキストのブロック）の
 * 対応が切れていないことを機械検証する。
 *
 * 使い方:
 *   cd integrable-lattice && node sagemath/tools/verify-check-linkage.ts
 *
 * 終了コード 0 = すべての対応が生きている。1 = 切れている対応がある。
 *
 * 検査する内容:
 *   (1) ブロックの `verification` が指す検証ディレクトリが実在すること
 *   (2) その検証ディレクトリが本プロジェクトの規約（README.md ＋ 実行ログ .out）を満たすこと
 *   (3) `sagemath/check/` の各ディレクトリが、少なくとも 1 つのブロックから参照されていること
 *       （＝孤立した検証が無いこと。参照されない検証は主張と結びついていない）
 *   (4) ブロックの `lean` が指す定理名が Lean のソースに実在すること
 *       （`lean/` が無い場合は「未導入」として (4) をスキップし、その旨を出力する）
 *
 * **本ツールは対応の生死だけを見る。数学的な正しさは見ない。**
 */

import { existsSync, readdirSync, readFileSync, statSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

import { loadContentFiles } from "../../structured-latex/tools/content-modules.ts";

const here = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(here, "../..");
const checkRoot = join(projectRoot, "sagemath", "check");
const leanRoot = join(projectRoot, "lean");

const contentFiles = await loadContentFiles();
const allBlocks = contentFiles.flatMap((f) => f.blocks);

const problems: string[] = [];
const notes: string[] = [];

/** 検証ディレクトリが規約（README.md ＋ .out）を満たすか。 */
function conformsToConvention(dir: string): { ok: boolean; reason?: string } {
  const entries = readdirSync(dir);
  if (!entries.includes("README.md")) {
    return { ok: false, reason: "README.md が無い（対象・手順・結論を書く規約）" };
  }
  if (!entries.some((e) => e.endsWith(".out"))) {
    return { ok: false, reason: "実行ログ（*.out）が無い" };
  }
  return { ok: true };
}

// ---- (1)(2) verification の実在と規約適合 -------------------------------------
const referenced = new Set<string>();

for (const block of allBlocks) {
  const paths = (block as { verification?: readonly string[] }).verification;
  if (paths === undefined) continue;
  for (const rel of paths) {
    const abs = join(projectRoot, rel);
    if (!existsSync(abs) || !statSync(abs).isDirectory()) {
      problems.push(`${block.id}.verification が指す ${rel} が存在しない（対応が切れている）`);
      continue;
    }
    referenced.add(rel.replace(/\/+$/, ""));
    const conv = conformsToConvention(abs);
    if (!conv.ok) {
      problems.push(`${rel} が規約を満たさない: ${conv.reason}（${block.id} から参照されている）`);
    }
  }
}

// ---- (3) 孤立した検証ディレクトリ ---------------------------------------------
const allCheckDirs = readdirSync(checkRoot)
  .filter((name) => statSync(join(checkRoot, name)).isDirectory())
  .map((name) => `sagemath/check/${name}`);

const orphans = allCheckDirs.filter((d) => !referenced.has(d));

// ---- (4) lean 定理名の実在 ----------------------------------------------------
let leanSource = "";
let leanAvailable = false;
if (existsSync(leanRoot)) {
  const stack = [leanRoot];
  const files: string[] = [];
  while (stack.length > 0) {
    const cur = stack.pop() as string;
    for (const e of readdirSync(cur)) {
      const p = join(cur, e);
      if (statSync(p).isDirectory()) {
        if (e !== ".lake" && e !== "logs") stack.push(p);
      } else if (e.endsWith(".lean")) {
        files.push(p);
      }
    }
  }
  if (files.length > 0) {
    leanAvailable = true;
    leanSource = files.map((f) => readFileSync(f, "utf8")).join("\n");
  }
}

const leanRefs: { blockId: string; name: string }[] = [];
for (const block of allBlocks) {
  const names = (block as { lean?: readonly string[] }).lean;
  if (names === undefined) continue;
  for (const name of names) leanRefs.push({ blockId: block.id, name });
}

if (!leanAvailable) {
  notes.push(
    `lean/ に .lean ソースが無いため (4) はスキップした。` +
      `未解決の lean 参照 ${leanRefs.length} 件は「Lean 未導入」として扱う。`,
  );
} else {
  for (const { blockId, name } of leanRefs) {
    // `theorem Foo.bar` / `lemma Foo.bar` / namespace 内の宣言を素朴に探す。
    const short = name.split(".").pop() as string;
    if (!leanSource.includes(name) && !new RegExp(`\\b(theorem|lemma|def)\\s+${short}\\b`).test(leanSource)) {
      problems.push(`${blockId}.lean が指す ${name} が Lean ソースに見つからない（対応が切れている）`);
    }
  }
}

// ---- 出力 ---------------------------------------------------------------------
console.log("=".repeat(78));
console.log("検証と論文の主張の対応（linkage）検査");
console.log("=".repeat(78));
console.log(`ブロック総数: ${allBlocks.length}`);
console.log(`verification を持つブロック: ${allBlocks.filter((b) => (b as { verification?: unknown }).verification !== undefined).length}`);
console.log(`参照されている検証ディレクトリ: ${referenced.size} / ${allCheckDirs.length}`);
console.log(`lean 参照: ${leanRefs.length} 件（Lean ソース ${leanAvailable ? "あり" : "無し"}）`);

if (orphans.length > 0) {
  console.log();
  console.log(`孤立（どのブロックからも参照されていない）検証ディレクトリ ${orphans.length} 件:`);
  for (const o of orphans) console.log(`  - ${o}`);
  console.log("  → これらは論文の主張と結びついていない。参照を張るか、結びつかない理由を記録すること。");
}

for (const n of notes) {
  console.log();
  console.log(`注記: ${n}`);
}

if (problems.length > 0) {
  console.log();
  console.log(`**切れている対応 ${problems.length} 件**:`);
  for (const p of problems) console.log(`  NG: ${p}`);
  process.exit(1);
}

console.log();
console.log("OK: 参照されている対応はすべて生きている（実在・規約適合）。");
console.log("注意: 本ツールは対応の生死だけを見る。数学的な正しさは見ない。");
