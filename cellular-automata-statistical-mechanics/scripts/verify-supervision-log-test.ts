/**
 * 監督の記録の受理規則 `supervision-log-rules.ts` の回帰検査。
 *
 * **規則を通る記録を 1 件だけ確かめても、規則が何も落とさない（恒真な）状態を検出できない。**
 * したがって、受理する 1 件に対して、契約のどの一点を崩したら落ちるかを一つずつ確かめる。
 * 対の作り方は、受理される記録から 1 か所だけを壊すこととし、複数箇所を同時に壊さない
 * （落ちた理由が、意図した規則によるものだと言えなくなるため）。
 */

import { violationsOfEntry, violationsOfLog, type TargetResolver } from "./supervision-log-rules.ts";

/** 検査用の解決子。実在するのはこの二つだけとする。 */
const resolver: TargetResolver = {
  labelExists: (label) => label === "claim_flip_test_equivalence",
  fileExists: (path) => path === "docs/tasks/auto-loop-state.md",
};

const acceptedEntry = () => ({
  実施時刻: "2026-09-05T14:52:00+09:00",
  監督対象の範囲: {
    確認した節: ["公開物の段取り照合が前置きと各段階の状態を見ていなかった穴を塞いだ"],
    確認した成果コミット: ["5c76e9542"],
  },
  最終ゴールとの照合: { 判定: "逸脱", 根拠: "手段の改善だけが積まれ、三つの問いへの前進が無い。" },
  段取りの妥当性: { 判定: "妥当", 根拠: "現在地の段階の完了条件は有限検査に落ちている。" },
  反復: [
    {
      対象: { 種別: "ラベル", 名前: "claim_flip_test_equivalence" },
      仮説: "本質的依存は一点反転検査で決まる。",
      反例: "",
      不変量: "本質的依存台。",
      採否: "採用",
      インサイト: "有限真理値表だけで決まり、舞台の構造を要さない。",
      次の探索への接続: "同じ形で局所表現可能性を有限検査へ落とせるかを見る。",
    },
  ],
  段取りの変更: { 変更した: false, 変更しない理由: "逸脱は段取りではなく実行の側にあるため。" },
  次の監督までの申し送り: "手段の改善が三回続いたら、次の監督で段取りの現在地を疑う。",
});

type Case = { readonly name: string; readonly build: () => unknown };

/** 契約の一点を崩した記録。いずれも落ちなければならない。 */
const rejectedCases: readonly Case[] = [
  {
    name: "実施時刻が日時の形をしていない",
    build: () => ({ ...acceptedEntry(), 実施時刻: "いつか" }),
  },
  {
    name: "実施時刻が存在しない日付である",
    build: () => ({ ...acceptedEntry(), 実施時刻: "2026-02-30T14:52:00+09:00" }),
  },
  {
    name: "対象範囲の成果コミットが空である",
    build: () => ({
      ...acceptedEntry(),
      監督対象の範囲: { 確認した節: ["ある節"], 確認した成果コミット: [] },
    }),
  },
  {
    name: "最終ゴールとの照合の判定が enum の外である",
    build: () => ({ ...acceptedEntry(), 最終ゴールとの照合: { 判定: "だいたい整合", 根拠: "ある根拠" } }),
  },
  {
    name: "最終ゴールとの照合に根拠が無い",
    build: () => ({ ...acceptedEntry(), 最終ゴールとの照合: { 判定: "整合", 根拠: "" } }),
  },
  {
    name: "段取りの妥当性の判定が欠けている",
    build: () => ({ ...acceptedEntry(), 段取りの妥当性: { 根拠: "ある根拠" } }),
  },
  {
    name: "反復が空である（監督が感想だけで通ろうとしている）",
    build: () => ({ ...acceptedEntry(), 反復: [] }),
  },
  {
    name: "反復の対象のラベルが本文に実在しない",
    build: () => {
      const entry = acceptedEntry();
      entry.反復[0].対象 = { 種別: "ラベル", 名前: "claim_does_not_exist" };
      return entry;
    },
  },
  {
    name: "反復の対象のパスがプロジェクト内に実在しない",
    build: () => {
      const entry = acceptedEntry();
      entry.反復[0].対象 = { 種別: "パス", 名前: "docs/tasks/存在しない.md" };
      return entry;
    },
  },
  {
    name: "反復の対象の種別がラベルでもパスでもない",
    build: () => {
      const entry = acceptedEntry();
      entry.反復[0].対象 = { 種別: "気持ち", 名前: "順調" };
      return entry;
    },
  },
  {
    name: "反復のインサイトが空である",
    build: () => {
      const entry = acceptedEntry();
      entry.反復[0].インサイト = "";
      return entry;
    },
  },
  {
    name: "反復の次の探索への接続が空である",
    build: () => {
      const entry = acceptedEntry();
      entry.反復[0].次の探索への接続 = "   ";
      return entry;
    },
  },
  {
    name: "採否が enum の外である",
    build: () => {
      const entry = acceptedEntry();
      entry.反復[0].採否 = "たぶん採用";
      return entry;
    },
  },
  {
    name: "棄却なのに反例が無い",
    build: () => {
      const entry = acceptedEntry();
      entry.反復[0].採否 = "棄却";
      entry.反復[0].反例 = "";
      return entry;
    },
  },
  {
    name: "段取りを変えたのに差分が無い",
    build: () => ({
      ...acceptedEntry(),
      段取りの変更: {
        変更した: true,
        差分: "",
        証拠: [{ 種別: "パス", 名前: "docs/tasks/auto-loop-state.md" }],
      },
    }),
  },
  {
    name: "段取りを変えたのに証拠が空である",
    build: () => ({
      ...acceptedEntry(),
      段取りの変更: { 変更した: true, 差分: "現在地を移した", 証拠: [] },
    }),
  },
  {
    name: "段取りを変えた証拠が実在しない",
    build: () => ({
      ...acceptedEntry(),
      段取りの変更: {
        変更した: true,
        差分: "現在地を移した",
        証拠: [{ 種別: "パス", 名前: "docs/tasks/存在しない.md" }],
      },
    }),
  },
  {
    name: "段取りを変えなかった理由が空である",
    build: () => ({ ...acceptedEntry(), 段取りの変更: { 変更した: false, 変更しない理由: "" } }),
  },
  {
    name: "次の監督までの申し送りが空である",
    build: () => ({ ...acceptedEntry(), 次の監督までの申し送り: "" }),
  },
];

let failures = 0;
const fail = (message: string) => {
  console.error(`  NG: ${message}`);
  failures += 1;
};

// 受理される 1 件。ここが落ちるなら、規則が契約より厳しくなっている。
const acceptedViolations = violationsOfEntry(acceptedEntry(), resolver);
if (acceptedViolations.length > 0) {
  fail(`契約を満たす記録が落ちた: ${acceptedViolations.map((v) => `${v.where}: ${v.why}`).join(" / ")}`);
}

// 段取りを実際に変えた形も受理されること（変更を記録できない規則は監督を無力にする）。
const changedEntry = {
  ...acceptedEntry(),
  段取りの妥当性: { 判定: "要変更", 根拠: "現在地の完了条件が有限検査に落ちていない。" },
  段取りの変更: {
    変更した: true,
    差分: "現在地の段階の完了条件から、有限検査に落ちない一項を有限検査の形へ書き直した。",
    証拠: [
      { 種別: "ラベル", 名前: "claim_flip_test_equivalence" },
      { 種別: "パス", 名前: "docs/tasks/auto-loop-state.md" },
    ],
  },
};
const changedViolations = violationsOfEntry(changedEntry, resolver);
if (changedViolations.length > 0) {
  fail(`段取りを変えた記録が落ちた: ${changedViolations.map((v) => `${v.where}: ${v.why}`).join(" / ")}`);
}

for (const testCase of rejectedCases) {
  if (violationsOfEntry(testCase.build(), resolver).length === 0) {
    fail(`落ちるべき記録が通った: ${testCase.name}`);
  }
}

// 記録全体の規則。
if (violationsOfLog([], resolver).length === 0) {
  fail("落ちるべき記録が通った: 記録が 1 行も無い");
}
if (violationsOfLog([acceptedEntry()], resolver).length > 0) {
  fail("契約を満たす 1 行の記録が落ちた");
}
const goingBackwards = [
  acceptedEntry(),
  { ...acceptedEntry(), 実施時刻: "2026-09-05T08:52:00+09:00" },
];
if (violationsOfLog(goingBackwards, resolver).length === 0) {
  fail("落ちるべき記録が通った: 実施時刻が前の行より前へ戻っている");
}

const total = rejectedCases.length + 5;
if (failures > 0) {
  console.error(`監督の記録の規則の回帰検査に失敗した（${failures} / ${total} 件）`);
  process.exit(1);
}
console.log(`監督の記録の規則の回帰検査は全て成功した（${total} 件）`);
