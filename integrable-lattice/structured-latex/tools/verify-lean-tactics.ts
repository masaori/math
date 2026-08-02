/**
 * **検査 T（`field_simp` の直後の `ring`）**。
 *
 * 何をなぜ見るかは `lean-tactic-model.ts` の doc を正本とする。要点だけ:
 * この誤りは 3 サイクル連続で再発しており、cycle 25 step 3 が
 * 「読んだ記憶は出力の途中に介在しない。機械で落ちる形にするしかない」と記録した。
 * 一律禁止は既存 10 件の偽陽性を出すので**宣言制**にする。
 * 新しい対は宣言が無いので即座に赤くなる。それがこの検査の目的である。
 */

import { existsSync, readFileSync, readdirSync } from "node:fs";
import { join } from "node:path";

import { LEAN_TACTIC_ALLOWANCES } from "./lean-tactic-allowances.ts";
import { keyOf, scanFile, type TacticPairSite } from "./lean-tactic-model.ts";
import { structuredLatexDir } from "./content-modules.ts";

const leanRoot = join(structuredLatexDir, "..", "lean");
const libRoot = join(leanRoot, "IntegrableLattice");

console.log("");
console.log("`field_simp` の直後の `ring` の検査（検査 T）");

if (!existsSync(libRoot)) {
  // `lean/` は任意（README がそう宣言している）。無いことを黙って緑にしない。
  console.log(`  ${libRoot} が無いので走査対象 0 件。`);
  console.log("");
  console.log("違反 0 件。");
  process.exit(0);
}

const files = readdirSync(libRoot)
  .filter((name) => name.endsWith(".lean"))
  .sort();

const sites: TacticPairSite[] = [];
for (const name of files) {
  sites.push(
    ...scanFile(`IntegrableLattice/${name}`, readFileSync(join(libRoot, name), "utf8")),
  );
}

const siteKeys = new Set(sites.map(keyOf));
const allowanceKeys = new Set(LEAN_TACTIC_ALLOWANCES.map(keyOf));

const undeclared = sites.filter((site) => !allowanceKeys.has(keyOf(site)));
const stale = LEAN_TACTIC_ALLOWANCES.filter((allowance) => !siteKeys.has(keyOf(allowance)));

console.log(`  走査: ${files.length} ファイル（lean/IntegrableLattice/）`);
console.log(
  `  field_simp の次行が ring である対: ${sites.length} 件 / 宣言 ${LEAN_TACTIC_ALLOWANCES.length} 件`,
);
console.log(`  **未宣言の対 ${undeclared.length} 件** / **余っている宣言 ${stale.length} 件**`);

if (undeclared.length > 0) {
  console.log("");
  console.log("  未宣言の対:");
  for (const site of undeclared) {
    console.log(`    ${site.file}: ${site.declaration}（${site.index} 番目・${site.line} 行）`);
  }
  console.log("");
  console.log("  この対を書く前に、**`ring` 無しでビルドして落ちること**を確かめること。");
  console.log("  落ちなければ `ring` は不要である（登録ではなく削除が正しい）。");
  console.log("  必要だと確かめたら tools/lean-tactic-allowances.ts へ根拠つきで登録する。");
}

if (stale.length > 0) {
  console.log("");
  console.log("  余っている宣言（対がもう無い。宣言を消すこと）:");
  for (const allowance of stale) {
    console.log(`    ${allowance.file}: ${allowance.declaration}（${allowance.index} 番目）`);
  }
}

if (undeclared.length + stale.length > 0) {
  console.log("");
  console.log(`違反 ${undeclared.length + stale.length} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: この検査は `ring` が必要かどうかを自分で確かめない（確かめるのは `lake build`）。" +
    "保証するのは「新しい対が黙って入らないこと」だけ。" +
    "同じ行に `;` で並ぶ形・`<;>`・`ring_nf` は対象外（実測 0 件）。",
);
console.log("");
console.log("違反 0 件。");
