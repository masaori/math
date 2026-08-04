/**
 * **「根拠が主張を支えているか」の判定が実際に効くことの実証**。
 *
 * 見るのは 2 つ。**ログの読み取り**（3 段の件数と直読の節を正しく拾えるか）と、
 * **4 通りの振り分け**（数字が支えている／宣言の直読が支えている／
 * 数字は不在を示していない／ログを引いていない）である。
 *
 * 再現データは実在確認ログの実際の形を写したものである。
 *
 * 実行: `npm run test:absence-support`
 */

import {
  auditAbsenceEvidenceSupport,
  parseSurveyLog,
  showsAbsence,
  type SurveyLog,
} from "./absence-evidence-support.ts";

/** 実在確認ログの実際の形（`mathlib-gap-survey-cycle30-matrixtree.log` を写した）。 */
const LOG_SOURCE = `
=== 日付 ===
2026-08-04T00:00:00Z
=== mathlib commit ===
520045ab14e26149ee970e2e617ca04b09bde5d6
=== 走査対象 Mathlib/*.lean ファイル数 ===
8264

=== (a) 全域木を数える定理 ===
--- (1) 連結語の内容 grep: 'matrixTree'
files=0
--- (2) 語幹の case-insensitive 内容 grep: 'matrix tree'
files=0
--- (3) 語幹の case-insensitive ファイル名検索: 'matrix tree'
files=0

=== (c) グラフのラプラシアン ===
--- (1) 連結語の内容 grep: 'lapMatrix'
files=1
--- (2) 語幹の case-insensitive 内容 grep: 'lapmatrix'
files=1
--- (3) 語幹の case-insensitive ファイル名検索: 'lapmatrix'
files=1

=== 守備範囲を宣言行で直読する（在るが射程が足りないもの） ===
--- トレース双対は体を要求するか
Mathlib/RingTheory/Trace/Basic.lean:553:noncomputable def Module.Basis.traceDual :
`;

const log = parseSurveyLog("lean/logs/fixture.log", LOG_SOURCE);
/** 概念を 1 つも記録していないログ（引用が飾りになっている場合の再現）。 */
const emptyLog: SurveyLog = { path: "lean/logs/empty.log", concepts: [], hasDeclarationReading: false };

let failed = 0;
const check = (name: string, ok: boolean, actual: string) => {
  if (ok) {
    console.log(`OK  ${name}`);
    return;
  }
  failed += 1;
  console.log(`NG  ${name}`);
  console.log(`    実際: ${actual}`);
};

// --- ログの読み取り ---------------------------------------------------------
check(
  "ログから概念を 2 件拾う（日付・コミット・ファイル数の節は概念として数えない）",
  log.concepts.length === 2,
  `${log.concepts.length} 件: ${log.concepts.map((c) => c.label).join(" / ")}`,
);
check(
  "連結語と語幹を拾う",
  log.concepts[0]?.joined === "matrixTree" && log.concepts[0]?.stem === "matrix tree",
  `${log.concepts[0]?.joined} / ${log.concepts[0]?.stem}`,
);
check(
  "3 段の件数を拾う",
  JSON.stringify(log.concepts[0]?.counts) === "[0,0,0]",
  JSON.stringify(log.concepts[0]?.counts),
);
check("直読の節があることを拾う", log.hasDeclarationReading, String(log.hasDeclarationReading));
check(
  "(2)(3) がともに 0 のときだけ不在とみなす",
  showsAbsence(log.concepts[0]!) && !showsAbsence(log.concepts[1]!),
  `${showsAbsence(log.concepts[0]!)} / ${showsAbsence(log.concepts[1]!)}`,
);

// --- 4 通りの振り分け -------------------------------------------------------
const kindOf = (text: string, logPaths: readonly string[], logs: readonly SurveyLog[] = [log]) =>
  auditAbsenceEvidenceSupport({
    entries: [{ block: "fixture", text, logPaths }],
    logs,
  });

{
  const audit = kindOf("`matrixTree` は無い（lean/logs/fixture.log）", ["lean/logs/fixture.log"]);
  check(
    "語が 0 件の概念と一致すれば「数字が支えている」",
    audit.entries[0]?.kind === "数字が支えている" && audit.violations.length === 0,
    String(audit.entries[0]?.kind),
  );
}
{
  const audit = kindOf("`lapMatrix` は無い（lean/logs/fixture.log）", ["lean/logs/fixture.log"]);
  check(
    "語の件数が 0 にならなければ「数字は不在を示していない」",
    audit.entries[0]?.kind === "数字は不在を示していない（射程の主張）",
    String(audit.entries[0]?.kind),
  );
}
{
  const audit = kindOf(
    "`lapMatrix` は在るが体を要求する。宣言行を直読した（lean/logs/fixture.log）",
    ["lean/logs/fixture.log"],
  );
  check(
    "直読したと書いてあり、ログに直読の節があれば「宣言の直読が支えている」",
    audit.entries[0]?.kind === "宣言の直読が支えている",
    String(audit.entries[0]?.kind),
  );
}
{
  const audit = kindOf("2026-08-04 実測。`MahlerMeasure` は 3 件だが多変数が無い", []);
  check(
    "ログを引いていなければ「本文の実測値だけ」",
    audit.entries[0]?.kind === "ログを引いていない（本文の実測値だけ）" &&
      audit.violations.length === 0,
    String(audit.entries[0]?.kind),
  );
}
{
  const audit = kindOf("`whatever` は無い（lean/logs/empty.log）", ["lean/logs/empty.log"], [emptyLog]);
  check(
    "引いたログに中身が無ければ違反にする（引用が飾りになっている）",
    audit.violations.some((v) => v.includes("[引いているログに中身が無い]")),
    audit.violations.join(" / ") || "違反 0 件",
  );
}

const total = 10;
if (failed > 0) {
  console.log(`NG: ${failed} 件が期待どおりでない。`);
  process.exit(1);
}
console.log(`OK: ${total} 件すべて期待どおり。`);
