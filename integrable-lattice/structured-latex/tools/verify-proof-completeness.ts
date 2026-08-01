#!/usr/bin/env node
/**
 * **検査 C**: 証明を持つべき本文ブロックが、証明を持っているか。
 *
 * cycle 24 総括が「検査で守られていない負債」として名指しした穴を塞ぐ。
 * 主張だけを転記したブロックは転記検査（検査 A）を通ってしまい、
 * 証明を運んでいないことは**どの検査も見ていなかった**。
 *
 * 「証明を持つべき」の定義と根拠、既知の未了の宣言の仕組みは proof-debt.ts の doc にある。
 *
 * 使い方: node tools/verify-proof-completeness.ts
 */

import { loadContentFiles } from "./content-modules.ts";
import {
  PROOF_DEBTS,
  PROVABLE_KINDS,
  checkProofDebts,
  findMissingProofs,
  proofViewOf,
  type ProofView,
} from "./proof-debt.ts";

const files = await loadContentFiles();
const views: ProofView[] = files.flatMap(({ file, blocks }) =>
  blocks.map((block) => proofViewOf(block, file)),
);
const byId = new Map(views.map((view) => [view.id, view]));

const provable = views.filter((view) => (PROVABLE_KINDS as readonly string[]).includes(view.kind));
const withProof = provable.filter((view) => view.hasProof);
const missing = findMissingProofs(views, PROOF_DEBTS);
const debtFindings = await checkProofDebts(PROOF_DEBTS, byId);

console.log("証明の欠落の検査（検査 C）");
console.log(
  `  本文: ${views.length} ブロック / ${files.length} ファイル。` +
    `証明を持つべき種別（${PROVABLE_KINDS.join(" / ")}）は ${provable.length} 件`,
);
console.log(
  `  証明あり ${withProof.length} 件 / **証明なし ${provable.length - withProof.length} 件**` +
    `（うち宣言済みの既知の未了 ${PROOF_DEBTS.length} 件・**未宣言 ${missing.length} 件**）`,
);

console.log("\n[既知の未了] 宣言の内訳（黙って緑にしない）");
for (const debt of PROOF_DEBTS) {
  const view = byId.get(debt.block);
  console.log(
    `  - ${debt.block}${view === undefined ? "" : `（${view.title}）`}: ` +
      `原本 ${debt.grounds.origin.report} の「${debt.grounds.origin.proofMarker}」`,
  );
}
console.log(
  `  宣言 ${PROOF_DEBTS.length} 件 / **根拠が失効した宣言 ${debtFindings.length} 件**` +
    "（根拠未指定 0 件。型で強制するので根拠なしの宣言は書けない）",
);
for (const finding of debtFindings) {
  console.log(`      - ${finding.block}: [${finding.kind}]`);
  console.log(`        ${finding.detail}`);
}

if (missing.length > 0) {
  console.log("\n[違反] 証明を持つべきなのに持たず、宣言もされていないブロック");
  for (const finding of missing) {
    console.log(`      - ${finding.file}:${finding.block}（${finding.title}）: ${finding.reason}`);
  }
}

console.log(
  "\n  限界: この検査は「証明が空でないこと」しか見ない。証明の中身の正しさ・十分さは見ない" +
    "（そちらは転記検査と Lean 化の領分）。種別の付け方そのものも見ない" +
    "（remark に実質的な主張を書けば対象外になる）。",
);

const violations = missing.length + debtFindings.length;
if (violations === 0) {
  console.log("\n違反 0 件。");
  process.exit(0);
}
console.error(`\n違反 ${violations} 件。`);
process.exit(1);
