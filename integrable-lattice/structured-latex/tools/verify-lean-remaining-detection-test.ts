/**
 * **残り一覧の照合の検出テスト**。
 *
 * 検査は「入れたつもり」になりやすいので、**落ちるべき形で実際に落ちること**を確かめる。
 * 再現データの中心は **cycle 32 に現に起きた形**——
 * `DropAssumptionBStar.lean` が 3 件挙げているのに台帳が 1 件しか写していなかった、という形である。
 */

import {
  auditLeanRemaining,
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
  heading: "形式化しなかったもの（mathlib の欠落か配線か）",
  items: [
    { leanFragment: "補題 Q0", kind: "未形式化", ledgerFragment: "補題 Q0" },
    { leanFragment: "補題 Q4a", kind: "未形式化", ledgerFragment: "補題 Q4a" },
    { leanFragment: "補題 Q1′", kind: "未形式化", ledgerFragment: "補題 Q1′" },
  ],
});

const cases: Case[] = [
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
          heading: "形式化しなかったもの（mathlib の欠落か配線か）",
          items: [{ leanFragment: "補題 Q0", kind: "未形式化", ledgerFragment: "補題 Q0" }],
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
            { leanFragment: "補題 Q0", kind: "未形式化", ledgerFragment: "補題 Q0" },
            { leanFragment: "補題 Q9z", kind: "未形式化", ledgerFragment: "補題 Q4a" },
            { leanFragment: "補題 Q1′", kind: "未形式化", ledgerFragment: "補題 Q1′" },
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
          heading: "形式化しなかったもの（mathlib の欠落か配線か）",
          items: [
            { leanFragment: "補題 Q0", kind: "形式化済み" },
            { leanFragment: "補題 Q4a", kind: "形式化済み" },
            { leanFragment: "補題 Q1′", kind: "形式化済み" },
          ],
        },
        section: sectionThree,
        linked: [{ block: "b", text: "命題 Q は完了である。", state: "完了" }],
      }).violations,
  },
  {
    name: "本文の主張へ紐づかない場合は違反にせず件数で出す",
    shouldFail: false,
    run: () => {
      const result = auditLeanRemaining({
        entry: threeItemEntry(),
        section: sectionThree,
        linked: [],
      });
      return result.violations.length === 0 && result.unlinked === 3
        ? []
        : ["紐づかない場合の扱いが設計と違う"];
    },
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
console.log(`${cases.length} / ${cases.length} 件で検出を実証した。`);
