#!/usr/bin/env node
/**
 * **転記検査**: 本文ブロックが、根拠 report から内容を落とさずに書かれているかを機械検証する。
 *
 * 「report は正しいのに本文へ移す段で壊れる」型の事故が 3 回起きている（cycle 18・20・21）。
 * 3 件とも**対応は付いていた**ので、対応表の有無を見る検査では防げない。
 * そこで 2 つの検査を持つ。
 *
 *   検査 A（台帳あり）: `source-links.ts` が指す report の範囲に現れる**飾りつきの数式アトム**と
 *     **専門語**が、対応する本文ブロックにも現れること。免除は項目 1 つ単位でしか書けない。
 *     → cycle 18（「算術級数」が本文に無い）と cycle 20（$A_1$ が本文に無い）を捕まえる。
 *
 *   検査 B（台帳なし・全ブロック）: **添字族の裸使用**。同じブロックが
 *     「束縛変数 $v$ を含む添字つき」で使っている記号 $S$ を、$v$ を束縛する和の中で
 *     添字なしに書いていたら違反。→ cycle 21（$\mu_{c+\ell\gamma}$ が $\mu$ になっていた）を捕まえる。
 *
 * **この検査が捕まえられないもの**（限界を先に書く）:
 *   - 場合分けの条件の意味の誤り。cycle 21 の 命題 G″ で「$\lambda_1$ が定義されない場合を含む
 *     条件」になっていた件は、記号としては正しく現れているので A も B も挙げない
 *     （あれは Lean 化が見つけた）。
 *   - report が書いていない誤りは原理的に見つからない。report 自体の誤りも見つからない。
 *   - 台帳に載っていないブロックは検査 A の対象外である。件数は必ず出力する（黙って落とさない）。
 *
 * 使い方: node tools/verify-transcription.ts
 */

import { loadContentFiles } from "./content-modules.ts";
import { SOURCE_LINKS } from "./source-links.ts";
import {
  checkBareFamilyUse,
  checkCoverage,
  readPassage,
  viewOf,
  type BareFamilyFinding,
  type CoverageResult,
} from "./transcription-model.ts";

const files = await loadContentFiles();
const views = files.flatMap(({ file, blocks }) => blocks.map((block) => viewOf(block, file)));
const byId = new Map(views.map((view) => [view.id, view]));

// --- 検査 A -------------------------------------------------------------------
const coverage: CoverageResult[] = [];
for (const link of SOURCE_LINKS) {
  const view = byId.get(link.block);
  if (view === undefined) {
    console.error(`台帳が指すブロックが本文に無い: ${link.block}（source-links.ts を直すこと）`);
    process.exit(1);
  }
  const passages = [];
  for (const passage of link.passages) passages.push({ passage, lines: (await readPassage(passage)).lines });
  coverage.push(checkCoverage(link, view, passages));
}

// --- 検査 B -------------------------------------------------------------------
const bare: BareFamilyFinding[] = views.flatMap((view) => checkBareFamilyUse(view));

// --- 報告 ---------------------------------------------------------------------
const theoremLike = views.filter((view) => view.kind !== "heading" && view.kind !== "figure");
console.log("転記検査");
console.log(`  本文: ${views.length} ブロック（うち定理型 ${theoremLike.length}）/ ${files.length} ファイル`);
console.log(
  `  検査 A の台帳: ${SOURCE_LINKS.length} ブロック分` +
    `（定理型の ${((SOURCE_LINKS.length / theoremLike.length) * 100).toFixed(0)}%。` +
    `残り ${theoremLike.length - SOURCE_LINKS.length} ブロックは検査 A の対象外）`,
);

console.log("\n[検査 A] 根拠 report からの取りこぼし — 内訳");
for (const result of coverage) {
  console.log(
    `  ${result.block}: report ${result.passageLines} 行（条件文 ${result.conditionSentences} 文） / ` +
      `アトム ${result.checkedAtoms} 件・語 ${result.checkedTerms} 件を照合 / ` +
      `免除 ${result.acknowledgedUsed} 件 / **未確認 ${result.findings.length} 件**`,
  );
  for (const finding of result.findings) {
    console.log(`      - [${finding.kind}] ${finding.item}`);
    console.log(`        report: ${truncate(finding.where, 120)}`);
  }
  for (const unused of result.acknowledgedUnused) {
    console.log(`      - [免除が余っている] ${unused}（本文に現れるようになった。台帳から消すこと）`);
  }
}

console.log("\n[検査 B] 添字族の裸使用 — 内訳");
console.log(`  走査した数式: ${views.reduce((n, v) => n + v.formulas.length, 0)} 件 / 検出 ${bare.length} 件`);
for (const finding of bare) {
  console.log(`      - ${finding.block}: ${finding.symbol} が ${finding.binder} の被和で裸`);
  console.log(`        同じブロックの添字つきの用例: ${finding.indexedExample}`);
  console.log(`        数式: ${truncate(finding.formula, 140)}`);
}

const violations =
  coverage.reduce((n, r) => n + r.findings.length + r.acknowledgedUnused.length, 0) + bare.length;
if (violations === 0) {
  console.log("\n違反 0 件。");
  process.exit(0);
}
console.error(`\n違反 ${violations} 件。`);
process.exit(1);

function truncate(s: string, n: number): string {
  return s.length <= n ? s : s.slice(0, n) + " …";
}
