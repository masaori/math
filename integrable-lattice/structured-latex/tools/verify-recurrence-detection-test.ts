#!/usr/bin/env node
/**
 * **検査 E（ノードをまたぐ強調）と検査 T（`field_simp` の直後の `ring`）が
 * 実際に検出できることの実証。**
 *
 * 「本番で違反 0 件だった」は検査が効いていることの根拠にならない（cycle 22 の教訓）。
 * この 2 検査はどちらも **3 サイクル連続で再発した誤り**を対象にしているので、
 * **実際に再発した形そのもの**を再現データとして持ち、それが挙がることを確かめる。
 *
 * **ファイルは 1 バイトも書き換えない。** 読み込んだ後のメモリ上の値に差分を当てる。
 *
 * 各件について 2 つを確かめる:
 *   1. 壊すと期待どおりの違反が出る。
 *   2. 壊さなければ出ない（偽陽性でない）。
 */

import { readFileSync, readdirSync } from "node:fs";
import { join } from "node:path";

import { structuredLatexDir } from "./content-modules.ts";
import { type ProseSite, unclosedEmphasis, violationsIn } from "./emphasis-model.ts";
import { LEAN_TACTIC_ALLOWANCES } from "./lean-tactic-allowances.ts";
import { keyOf, scanFile, type TacticPairAllowance } from "./lean-tactic-model.ts";

let failures = 0;
let checks = 0;
const report = (name: string, ok: boolean, detail: string): void => {
  checks += 1;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**失敗**"}: ${name}`);
  console.log(`      ${detail}`);
};

const site = (value: string): ProseSite => ({
  locale: "en",
  blockId: "fixture_block",
  file: "locales/en/content/fixture.ts",
  field: "text",
  value,
});

// =============================================================================
// 検査 E — ノードをまたぐ強調
// =============================================================================
console.log("");
console.log("検査 E（ノードをまたぐ強調）の検出テスト");
console.log("  再現データ: cycle 24 step 4 / 25 step 4a / 25 step 4b が実際に書いた形。");
console.log("  形は同じ——強調を数式ノードの手前で開き、数式のあとの地の文で閉じる。");

// 実際に書かれた形。paragraph の children は
//   text("**the coefficient "), math("c"), text(" is determined**")
// のように並ぶので、地の文ノード単位では `**` が 1 個ずつになる。
const CROSSING_OPEN = "**the coefficient ";
const CROSSING_CLOSE = " is determined by the twisted stage data**";
const CLOSED_IN_ONE_NODE = "**the coefficient is determined by the twisted stage data**";

report(
  "強調を開いたまま数式ノードへ渡す地の文（開き側）",
  violationsIn([site(CROSSING_OPEN)]).length === 1,
  `"${CROSSING_OPEN}" → 違反 ${violationsIn([site(CROSSING_OPEN)]).length} 件（期待 1）`,
);
report(
  "数式ノードのあとで閉じる地の文（閉じ側）",
  violationsIn([site(CROSSING_CLOSE)]).length === 1,
  `"${CROSSING_CLOSE}" → 違反 ${violationsIn([site(CROSSING_CLOSE)]).length} 件（期待 1）`,
);
report(
  "1 ノードの中で閉じている強調では挙がらない（偽陽性でない）",
  violationsIn([site(CLOSED_IN_ONE_NODE)]).length === 0,
  `"${CLOSED_IN_ONE_NODE}" → 違反 0 件`,
);

// 生成器 applyBold と同じ消し方をしているかの、境界の確認。
const BOUNDARY: { value: string; unclosed: boolean; why: string }[] = [
  { value: "強調なし", unclosed: false, why: "`**` が 0 個" },
  { value: "**閉じている**", unclosed: false, why: "対応が取れている" },
  { value: "**a**b**", unclosed: true, why: "3 個。1 組取ると 1 個残る" },
  { value: "**a** **b**", unclosed: false, why: "4 個。2 組とも取れる" },
  { value: "**", unclosed: true, why: "1 個だけ" },
  { value: "**改行を\nまたぐ強調**", unclosed: false, why: "`s` フラグがあるので改行をまたいでも取れる" },
];
for (const entry of BOUNDARY) {
  report(
    `境界: ${JSON.stringify(entry.value)} は${entry.unclosed ? "挙がる" : "挙がらない"}`,
    unclosedEmphasis(entry.value) === entry.unclosed,
    entry.why,
  );
}

// =============================================================================
// 検査 T — `field_simp` の直後の `ring`
// =============================================================================
console.log("");
console.log("検査 T（`field_simp` の直後の `ring`）の検出テスト");
console.log("  再現データ: cycle 25 step 3 が実際に書いた形（`Q1_b_zero_matches_layer_count` 等）。");

const NEW_PAIR = [
  "theorem Q1_b_zero_matches_layer_count (x : ℚ) (h : x ≠ 0) : x / x = 1 := by",
  "  field_simp",
  "  ring",
].join("\n");

const scannedNew = scanFile("IntegrableLattice/Fixture.lean", NEW_PAIR);
report(
  "新しく書かれた `field_simp` + `ring` の対を拾う",
  scannedNew.length === 1 && scannedNew[0]?.declaration === "Q1_b_zero_matches_layer_count",
  `対 ${scannedNew.length} 件 / 宣言名 ${scannedNew[0]?.declaration ?? "(なし)"}`,
);
report(
  "拾った対は台帳に無いので未宣言になる（＝赤くなる）",
  scannedNew.every((entry) => !new Set(LEAN_TACTIC_ALLOWANCES.map(keyOf)).has(keyOf(entry))),
  "既存の台帳 10 件のどれとも一致しない",
);

const NO_RING = ["theorem fixture_no_ring : True := by", "  field_simp", "  trivial"].join("\n");
report(
  "`field_simp` のあとが `ring` でなければ挙がらない（偽陽性でない）",
  scanFile("IntegrableLattice/Fixture.lean", NO_RING).length === 0,
  "`field_simp` → `trivial` は対象外",
);

const SEPARATED = [
  "theorem fixture_separated : True := by",
  "  field_simp",
  "  simp",
  "  ring",
].join("\n");
report(
  "`field_simp` と `ring` の間に別のタクティクがあれば挙がらない",
  scanFile("IntegrableLattice/Fixture.lean", SEPARATED).length === 0,
  "直後だけを見る（限界として model の doc に明記してある）",
);

const TWO_IN_ONE = [
  "theorem fixture_two : True := by",
  "  field_simp",
  "  ring",
  "  field_simp",
  "  ring",
].join("\n");
const scannedTwo = scanFile("IntegrableLattice/Fixture.lean", TWO_IN_ONE);
report(
  "同じ宣言の中の 2 つ目の対を別物として数える",
  scannedTwo.length === 2 && scannedTwo[1]?.index === 1,
  `対 ${scannedTwo.length} 件 / 2 つ目の index = ${scannedTwo[1]?.index ?? "(なし)"}`,
);

// 台帳が腐ったら赤くなること（宣言が余る側）。
const libRoot = join(structuredLatexDir, "..", "lean", "IntegrableLattice");
const realSites = readdirSync(libRoot)
  .filter((name) => name.endsWith(".lean"))
  .sort()
  .flatMap((name) => scanFile(`IntegrableLattice/${name}`, readFileSync(join(libRoot, name), "utf8")));
const realKeys = new Set(realSites.map(keyOf));

const GHOST: TacticPairAllowance = {
  file: "IntegrableLattice/GeneralTowerClosedForm.lean",
  declaration: "S0_closed",
  index: 7,
  reason: "（テスト用。実在しない index）",
};
report(
  "対がもう無い宣言は「余っている宣言」で挙がる",
  !realKeys.has(keyOf(GHOST)),
  `${keyOf(GHOST)} は実在の対 ${realSites.length} 件のどれとも一致しない`,
);
report(
  "現在の台帳は 1 件も余っていない（偽陽性でない）",
  LEAN_TACTIC_ALLOWANCES.every((allowance) => realKeys.has(keyOf(allowance))),
  `宣言 ${LEAN_TACTIC_ALLOWANCES.length} 件がすべて実在の対に当たる`,
);

console.log("");
if (failures > 0) {
  console.log(`**${failures} / ${checks} 件で検出できなかった。**`);
  process.exit(1);
}
console.log(`${checks} / ${checks} 件で検出を実証した（検査 E ${9} 件 + 検査 T ${7} 件）。`);
