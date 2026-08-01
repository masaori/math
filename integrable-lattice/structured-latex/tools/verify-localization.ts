#!/usr/bin/env node
/**
 * **原文と翻訳の対応を機械検証する。**
 *
 * この作業の絶対条件は「日本語版を失わない可逆な構成にすること」である。散文の約束にすると
 * 必ず腐るので、検査可能な形にしてある。日本語版 `content/` は正本であり、
 * **このツールは一切書き換えない**（読むだけ）。
 *
 * cycle 24 step 2 で、比較器そのものは自前実装（`structured-latex-en/tools/
 * verify-ja-en-correspondence.ts`、331 行）をやめ、**システムの構造照合**へ載せ替えた。
 * このスクリプトが自分で持つのは次の 2 つだけである。
 *
 *   1. ロケール集約を組み立ててシステムへ渡すこと（`tools/localization.ts`）。
 *   2. **免除の登録が腐っていないこと**の監査（使われない登録・理由の空文字）。
 *      これはシステムの責務ではない（何が「古い登録」かはプロジェクトの知識である）。
 *
 * 移行で検出が強くなったもの・弱くなったものは
 * `outputs/reports/cycle24_ops_localize_english_edition.md` の対応表に書いてある。
 *
 * 使い方: node tools/validate-content.ts の後に node tools/verify-localization.ts
 */

import { auditRegistrations, usageSummary } from "../locales/en/allowance.ts";
import { allowancesFromConfig, buildSnapshot, checkResolvable, checkStructure } from "./localization.ts";

const snapshot = await buildSnapshot();
const allowances = allowancesFromConfig();

const structure = checkStructure(snapshot, allowances);
const resolvable = structure.ok ? checkResolvable(snapshot, allowances) : { ok: false, issues: [] };
// 監査は照合を 1 度通したあとでしか意味を持たない（使用実績が要る）。
const stale = structure.ok ? auditRegistrations() : [];

const blockCounts = snapshot.localizations.map((localization) => ({
  locale: localization.locale,
  blocks: localization.revision.segments.reduce((total, s) => total + s.blocks.length, 0),
  segments: localization.revision.segments.length,
}));

console.log("ロケール対応検証（システムの構造照合）");
for (const count of blockCounts) {
  console.log(`  ${count.locale}: ${count.blocks} ブロック / ${count.segments} ファイル`);
}
const usage = usageSummary();
console.log(
  `  理由つきで認めた差: 翻訳限定ファイル ${usage.segments} 件 / 翻訳限定ブロック ${usage.blocks} 件 / ` +
    `骨格の規則 ${usage.rules} 件（**免除の単位は差分 1 つ**）`,
);

if (structure.ok && resolvable.ok && stale.length === 0) {
  console.log("\n違反 0 件: 翻訳は原文の内容を 1 件も失っていない。");
  process.exit(0);
}

if (!structure.ok) {
  console.error(`\n構造照合の違反 ${structure.issues.length} 件:`);
  for (const issue of structure.issues) console.error(`  - ${JSON.stringify(issue)}`);
}
if (!resolvable.ok) {
  console.error(`\n解決できないロケール ${resolvable.issues.length} 件:`);
  for (const issue of resolvable.issues) console.error(`  - ${JSON.stringify(issue)}`);
}
if (stale.length > 0) {
  console.error(`\n腐った免除の登録 ${stale.length} 件:`);
  for (const problem of stale) console.error(`  - ${problem}`);
}
process.exit(1);
