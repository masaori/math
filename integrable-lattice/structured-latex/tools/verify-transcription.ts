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
 *   検査 A′（免除の健全性）: 検査 A の免除 1 件ごとに、**根拠が生きているか**を見る。
 *     免除は「report のこの文について、本文はこう書いているから落としてよい」という判定なので、
 *     **その report の文が書き換わったら／本文のその記述が消えたら、判定はやり直しになる**。
 *     根拠が動いた免除は違反として赤にする。→ cycle 23 の限界（免除 91 件が機械検証されていない）への答え。
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
  checkExemptionGrounds,
  readPassage,
  viewOf,
  type BareFamilyFinding,
  type CoverageResult,
  type GroundsFinding,
} from "./transcription-model.ts";

const files = await loadContentFiles();
const views = files.flatMap(({ file, blocks }) => blocks.map((block) => viewOf(block, file)));
const byId = new Map(views.map((view) => [view.id, view]));

// --- 検査 A / A′ ---------------------------------------------------------------
const coverage: CoverageResult[] = [];
const groundsFindings: GroundsFinding[] = [];
for (const link of SOURCE_LINKS) {
  const view = byId.get(link.block);
  if (view === undefined) {
    console.error(`台帳が指すブロックが本文に無い: ${link.block}（source-links.ts を直すこと）`);
    process.exit(1);
  }
  const passages = [];
  for (const passage of link.passages) passages.push({ passage, lines: (await readPassage(passage)).lines });
  coverage.push(checkCoverage(link, view, passages));
  groundsFindings.push(...(await checkExemptionGrounds(link, view, passages, byId)));
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

// 台帳に載っていても、range の中に条件文が 1 文も無ければ照合は 0 件で走る。
// それは「緑」ではなく「何も見ていない」なので、件数を必ず出す（黙って落とさない）。
const noCheck = coverage.filter((r) => r.checkedAtoms + r.checkedTerms === 0);
console.log(
  `\n  照合の内訳: 照合したアトム ${coverage.reduce((n, r) => n + r.checkedAtoms, 0)} 件・` +
    `語 ${coverage.reduce((n, r) => n + r.checkedTerms, 0)} 件 / ` +
    `免除 ${coverage.reduce((n, r) => n + r.acknowledgedUsed, 0)} 件 / ` +
    `**照合対象が 0 件だったブロック ${noCheck.length} 件**` +
    (noCheck.length === 0 ? "" : `（${noCheck.map((r) => r.block).join(", ")}）`),
);
if (noCheck.length > 0) {
  console.log(
    "    ↑ これらは台帳の目印が生きていることしか検査していない（range に条件文が無い）。" +
      "限界として記録すること。",
  );
}

// --- 検査 A′ の報告（免除の健全性） ---------------------------------------------
// 免除は検査 A の強さを直接左右する（免除が多いほど検査は弱い）。件数だけでなく
// **腐っていないこと**を毎回出す。cycle 23 の「照合力 0 のブロック 5 件」と同じ思想。
console.log("\n[検査 A′] 免除の根拠が生きているか — 内訳");
const allGrounds = SOURCE_LINKS.flatMap((link) => link.acknowledged.map((a) => a.grounds));
const byType = new Map<string, number>();
for (const g of allGrounds) byType.set(g.type, (byType.get(g.type) ?? 0) + 1);
const TYPE_LABEL: Record<string, string> = {
  notation: "記法の選択",
  weaker: "本文のほうが弱い主張",
  division: "ブロック間の分担",
  positioning: "report の位置づけの言葉",
  example: "例示の省略",
  paraphrase: "言い換え",
  reportStale: "report のほうが古い",
  bodyDefect: "本文の不備（記録済み）",
};
console.log(
  `  免除 ${allGrounds.length} 件 / 型別: ` +
    [...byType].map(([t, n]) => `${TYPE_LABEL[t] ?? t} ${n}`).join("・"),
);
const unverifiable = byType.get("positioning") ?? 0;
console.log(
  `  根拠未指定 0 件（型で強制。根拠なしの免除は書けない）/ ` +
    `**失効した免除 ${groundsFindings.length} 件** / ` +
    `**型として機械検証できないもの ${unverifiable} 件**（${TYPE_LABEL["positioning"]}）`,
);
if (unverifiable > 0) {
  console.log(
    "    ↑ この型は「report が書き換わったら落ちる」ことしか検査できない。" +
      "「これは主張ではない」という判定そのものは機械で確かめられない。限界として記録すること。",
  );
}
for (const finding of groundsFindings) {
  console.log(`      - ${finding.block} / ${finding.item}: [${finding.kind}]`);
  console.log(`        ${finding.detail}`);
}

console.log("\n[検査 B] 添字族の裸使用 — 内訳");
console.log(`  走査した数式: ${views.reduce((n, v) => n + v.formulas.length, 0)} 件 / 検出 ${bare.length} 件`);
for (const finding of bare) {
  console.log(`      - ${finding.block}: ${finding.symbol} が ${finding.binder} の被和で裸`);
  console.log(`        同じブロックの添字つきの用例: ${finding.indexedExample}`);
  console.log(`        数式: ${truncate(finding.formula, 140)}`);
}

const violations =
  coverage.reduce((n, r) => n + r.findings.length + r.acknowledgedUnused.length, 0) +
  groundsFindings.length +
  bare.length;
if (violations === 0) {
  console.log("\n違反 0 件。");
  process.exit(0);
}
console.error(`\n違反 ${violations} 件。`);
process.exit(1);

function truncate(s: string, n: number): string {
  return s.length <= n ? s : s.slice(0, n) + " …";
}
