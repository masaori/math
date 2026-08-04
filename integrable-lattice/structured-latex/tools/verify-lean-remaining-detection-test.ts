/**
 * **残り一覧の照合の検出テスト**。
 *
 * 検査は「入れたつもり」になりやすいので、**落ちるべき形で実際に落ちること**を確かめる。
 * 再現データの中心は **cycle 32 に現に起きた形**——
 * `DropAssumptionBStar.lean` が 3 件挙げているのに台帳が 1 件しか写していなかった、という形である。
 */

import {
  auditLeanRemaining,
  auditDeclarationCount,
  auditCrossFilePhrase,
  parseRemainingSection,
  type LeanRemainingFile,
} from "./lean-remaining-model.ts";

type Case = {
  readonly name: string;
  readonly shouldFail: boolean;
  readonly run: () => string[];
};

/** cycle 32 に現に起きた形の Lean ファイル（3 件挙げている）。 */
const leanSourceThreeItems = `/-
# 何かの定理

## 形式化しなかったもの（mathlib の欠落か配線か）

* **補題 Q0**（アルキメデス粗上界）: まだ書いていない。
* **補題 Q4a**（円分体の付値）: まだ書いていない。
* **補題 Q1′**（Laurent 環の持ち上げ）: まだ書いていない。
-/
import Mathlib
`;

const sectionThree = parseRemainingSection(leanSourceThreeItems)!;

const ledgerOnlyOne = "命題 Q は組合せ・数え上げまで。残るのは 補題 Q0 の粗上界。";
const ledgerAllThree =
  "命題 Q は組合せ・数え上げまで。残るのは 補題 Q0・補題 Q4a・補題 Q1′ の 3 件である。";

const threeItemEntry = (): LeanRemainingFile => ({
  file: "Fixture.lean",
          declarationsAtReview: 0,
  heading: "形式化しなかったもの（mathlib の欠落か配線か）",
  items: [
    { leanFragment: "補題 Q0", kind: "未形式化", ledgerFragment: "補題 Q0", crossFilePhrase: "補題 Q0" },
    { leanFragment: "補題 Q4a", kind: "未形式化", ledgerFragment: "補題 Q4a", crossFilePhrase: "補題 Q4a" },
    { leanFragment: "補題 Q1′", kind: "未形式化", ledgerFragment: "補題 Q1′", crossFilePhrase: "補題 Q1′" },
  ],
});

const cases: Case[] = [
  {
    name: "形式化済みの証拠が消えたら赤くなる（cycle 35 step 5。両方が同じだけ古い穴の塞げる側）",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: {
          file: "Fixture.lean",
          declarationsAtReview: 0,
          heading: "形式化しなかったもの（mathlib の欠落か配線か）",
          items: [
            { leanFragment: "補題 Q0", kind: "形式化済み", witness: "lemma_Q0" },
            { leanFragment: "補題 Q4a", kind: "形式化済み", witness: "lemma_Q4a" },
            { leanFragment: "補題 Q1′", kind: "形式化済み", witness: "lemma_Q1_gone" },
          ],
        },
        section: sectionThree,
        linked: [{ block: "b", text: ledgerAllThree, state: "部分的" }],
        declarationExists: (name) => name === "lemma_Q0" || name === "lemma_Q4a",
      }).violations,
  },
  {
    name: "形式化済みの証拠が実在すれば通る（偽陽性でない）",
    shouldFail: false,
    run: () =>
      auditLeanRemaining({
        entry: {
          file: "Fixture.lean",
          declarationsAtReview: 0,
          heading: "形式化しなかったもの（mathlib の欠落か配線か）",
          items: [
            { leanFragment: "補題 Q0", kind: "形式化済み", witness: "lemma_Q0" },
            { leanFragment: "補題 Q4a", kind: "形式化済み", witness: "lemma_Q4a" },
            { leanFragment: "補題 Q1′", kind: "形式化済み", witness: "lemma_Q1" },
          ],
        },
        section: sectionThree,
        linked: [{ block: "b", text: ledgerAllThree, state: "部分的" }],
        declarationExists: () => true,
      }).violations,
  },
  {
    name: "節と箇条書きを取り出せる（3 件）",
    shouldFail: false,
    run: () => (sectionThree.bullets.length === 3 ? [] : ["箇条書きの数が 3 でない"]),
  },
  {
    name: "節を持たないファイルは対象外",
    shouldFail: false,
    run: () =>
      parseRemainingSection("/-\n# 何か\n## 形式化した主張\n* あれ\n-/\n") === null
        ? []
        : ["節が無いのに拾った"],
  },
  {
    name: "cycle 32 の事故そのもの: Lean 側 3 件・台帳の項目 1 件",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: {
          file: "Fixture.lean",
          declarationsAtReview: 0,
          heading: "形式化しなかったもの（mathlib の欠落か配線か）",
          items: [{ leanFragment: "補題 Q0", kind: "未形式化", ledgerFragment: "補題 Q0", crossFilePhrase: "補題 Q0" }],
        },
        section: sectionThree,
        linked: [{ block: "b", text: ledgerOnlyOne, state: "部分的" }],
      }).violations,
  },
  {
    name: "台帳（検査 F）が lean/ より少なく書いている",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: threeItemEntry(),
        section: sectionThree,
        linked: [{ block: "b", text: ledgerOnlyOne, state: "部分的" }],
      }).violations,
  },
  {
    name: "台帳が 3 件とも書いていれば通る",
    shouldFail: false,
    run: () =>
      auditLeanRemaining({
        entry: threeItemEntry(),
        section: sectionThree,
        linked: [{ block: "b", text: ledgerAllThree, state: "部分的" }],
      }).violations,
  },
  {
    name: "見出しを書き換えて逃げる道が塞がっている",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: { ...threeItemEntry(), heading: "形式化しなかったもの" },
        section: sectionThree,
        linked: [{ block: "b", text: ledgerAllThree, state: "部分的" }],
      }).violations,
  },
  {
    name: "宣言した文字列が Lean 側に実在しない（文言が腐った）",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: {
          ...threeItemEntry(),
          items: [
            { leanFragment: "補題 Q0", kind: "未形式化", ledgerFragment: "補題 Q0", crossFilePhrase: "補題 Q0" },
            { leanFragment: "補題 Q9z", kind: "未形式化", ledgerFragment: "補題 Q4a", crossFilePhrase: "補題 Q4a" },
            { leanFragment: "補題 Q1′", kind: "未形式化", ledgerFragment: "補題 Q1′", crossFilePhrase: "補題 Q1′" },
          ],
        },
        section: sectionThree,
        linked: [{ block: "b", text: ledgerAllThree, state: "部分的" }],
      }).violations,
  },
  {
    name: "残りがあるのに台帳が完了と書いている",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: threeItemEntry(),
        section: sectionThree,
        linked: [{ block: "b", text: ledgerAllThree, state: "完了" }],
      }).violations,
  },
  {
    name: "形式化済みと分類したものは台帳への反映を要求しない",
    shouldFail: false,
    run: () =>
      auditLeanRemaining({
        entry: {
          file: "Fixture.lean",
          declarationsAtReview: 0,
          heading: "形式化しなかったもの（mathlib の欠落か配線か）",
          items: [
            { leanFragment: "補題 Q0", kind: "形式化済み", witness: "lemma_Q0" },
            { leanFragment: "補題 Q4a", kind: "形式化済み", witness: "lemma_Q4a" },
            { leanFragment: "補題 Q1′", kind: "形式化済み", witness: "lemma_Q1" },
          ],
        },
        section: sectionThree,
        linked: [{ block: "b", text: "命題 Q は完了である。", state: "完了" }],
      }).violations,
  },
  {
    name: "本文の主張へ紐づかないうえ externalEntry の宣言も無ければ違反にする（cycle 34 step 3）",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: threeItemEntry(),
        section: sectionThree,
        linked: [],
      }).violations,
  },
  {
    name: "紐づかなくても externalEntry の欄が同じことを書いていれば通る（cycle 34 step 3）",
    shouldFail: false,
    run: () => {
      const result = auditLeanRemaining({
        entry: { ...threeItemEntry(), externalEntry: "外部定理 X" },
        section: sectionThree,
        linked: [],
        externalText: ledgerAllThree,
      });
      return result.violations.length === 0 && result.unlinked === 3
        ? []
        : ["紐づかない場合の扱いが設計と違う"];
    },
  },
  {
    name: "externalEntry の欄が lean/ より少なく書いていれば違反にする（cycle 34 step 3）",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: { ...threeItemEntry(), externalEntry: "外部定理 X" },
        section: sectionThree,
        linked: [],
        externalText: ledgerOnlyOne,
      }).violations,
  },
  {
    name: "「参照だけ」の指し先が実在しなければ違反にする（cycle 34 step 3）",
    shouldFail: true,
    run: () =>
      auditLeanRemaining({
        entry: {
          file: "F.lean",
          declarationsAtReview: 0,
          heading: "形式化しなかったもの",
          items: [
            {
              leanFragment: "甲",
              kind: "参照だけ",
              referent: { kind: "lean ファイル", target: "NoSuchFile.lean" },
            },
          ],
        },
        section: { heading: "形式化しなかったもの", bullets: ["甲 は別ファイル"] },
        linked: [],
        referentExists: () => false,
      }).violations,
  },
  {
    name: "「参照だけ」の指し先が実在すれば通る（cycle 34 step 3）",
    shouldFail: false,
    run: () =>
      auditLeanRemaining({
        entry: {
          file: "F.lean",
          declarationsAtReview: 0,
          heading: "形式化しなかったもの",
          items: [
            {
              leanFragment: "甲",
              kind: "参照だけ",
              referent: { kind: "lean ファイル", target: "RealFile.lean" },
            },
          ],
        },
        section: { heading: "形式化しなかったもの", bullets: ["甲 は別ファイル"] },
        linked: [],
        referentExists: () => true,
      }).violations,
  },
];

let failed = 0;
console.log("");
console.log("残り一覧の照合の検出テスト");
for (const testCase of cases) {
  const violations = testCase.run();
  const detected = violations.length > 0;
  const ok = detected === testCase.shouldFail;
  if (!ok) failed += 1;
  console.log(
    `  ${ok ? "OK" : "NG"} [${testCase.shouldFail ? "落ちるべき" : "通るべき"}] ${testCase.name}`,
  );
  if (!ok && violations.length > 0) {
    for (const violation of violations) console.log(`      ${violation}`);
  }
}
console.log("");
if (failed > 0) {
  console.error(`検出テスト ${failed} 件が期待どおりでない。`);
  process.exit(1);
}
// --- 宣言の数の再確認（cycle 36 step 4） ---------------------------------------
{
  const entry: LeanRemainingFile = {
    file: "Fixture.lean",
    heading: "形式化しなかったもの",
    declarationsAtReview: 3,
    items: [],
  };
  const grew = auditDeclarationCount(entry, 5);
  const same = auditDeclarationCount(entry, 3);
  const shrank = auditDeclarationCount(entry, 1);
  console.log("  検出: 宣言が増えたのに残り一覧を読み直していない");
  console.log(`      ${grew === null ? "挙がらなかった（NG）" : "挙げた"}`);
  console.log("  検出: 宣言の数が変わっていなければ挙がらない（偽陽性でない側）");
  console.log(`      ${same === null ? "挙がらなかった" : "挙げた（NG）"}`);
  console.log("  検出: 宣言が減った場合も挙がる（削除で残り一覧が浮く側）");
  console.log(`      ${shrank === null ? "挙がらなかった（NG）" : "挙げた"}`);
  if (grew === null || same !== null || shrank === null) {
    console.log("NG: 宣言の数の再確認が期待どおりに動いていない");
    process.exit(1);
  }
}

// --- 別のファイルが同じ事柄を書いている（cycle 37 step 4） ------------------------
// 再現データは **cycle 37 に現に起きた形**——`EulerDualBasisCommRing.lean` が
// 未形式化と書いていた「当てはめ」が `WStarPowerBasisInstance.lean` という別のファイルに書かれ、
// 元のファイルの宣言は 1 つも増えなかったので cycle 36 step 4 の鈴が鳴らなかった、という形である。
{
  const wrote = auditCrossFilePhrase(
    "EulerDualBasisCommRing.lean",
    "を満たすことの当てはめ",
    "WStarPowerBasisInstance.lean",
    false,
  );
  const agreed = auditCrossFilePhrase(
    "KirchhoffCounting.lean",
    "指標分解",
    "SpanningConnectivity.lean",
    true,
  );
  console.log("");
  console.log("「別のファイルが同じ事柄を書いている」の検出テスト");
  console.log("  検出: cycle 37 に現に起きた形（別ファイルに書かれ、元のファイルの宣言は増えない）");
  console.log(`      ${wrote === null ? "挙がらなかった（NG）" : "挙げた"}`);
  console.log("  検出: 両方が未形式化で一致していれば挙がらない（唯一の逃げ道。偽陽性でない側）");
  console.log(`      ${agreed === null ? "挙がらなかった" : "挙げた（NG）"}`);
  if (wrote === null || agreed !== null) {
    console.log("NG: 別ファイルの走査が期待どおりに動いていない");
    process.exit(1);
  }
}

console.log(`${cases.length + 5} / ${cases.length + 5} 件で検出を実証した。`);
