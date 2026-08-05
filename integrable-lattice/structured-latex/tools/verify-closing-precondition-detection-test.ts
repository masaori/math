/**
 * **欄を閉じる前提の検査の検出テスト**（cycle 49 step 1）。
 *
 * 検査が黙っていないことを、**壊した状態を作って挙がることで**実証する。
 * 緑であることに意味を持たせるには、赤くなる条件を示さなければならない。
 *
 * **判定は本体と同じ関数を呼ぶ**（写しを置くと、本体を直したときにテストだけ古くなる）。
 */
import {
  auditClosingPrecondition,
  type ClosingDisposition,
  type ClosingEntry,
} from "./closing-precondition-model.ts";

let failures = 0;
const expect = (label: string, actual: number, expected: number, detail: string) => {
  const ok = actual === expected;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**取りこぼし**"}: ${label}`);
  console.log(`      ${detail} → ${actual} 件（期待 ${expected}）`);
};

console.log("");
console.log("欄を閉じる前提の検査の検出テスト（cycle 49 step 1）");

const openBlockExists = (block: string) => block === "other";

/** 名指しが残り項目にそのまま当たっている、健全な形。 */
const healthy: ClosingEntry = {
  block: "b",
  state: "部分的",
  remainingItems: ["降下の段"],
  parts: [],
  named: [{ file: "F.lean", phrase: "降下の段", fragment: "降下" }],
};

const run = (entries: ClosingEntry[], dispositions: ClosingDisposition[] = []) =>
  auditClosingPrecondition({ entries, dispositions, openBlockExists });

expect(
  "名指しが残り項目に当たっていれば挙がらない（偽陽性でない）",
  run([healthy]).violations.length,
  0,
  "残り項目「降下の段」に当たる名指し",
);

expect(
  "残り項目に当たらず処分も無ければ挙がる（cycle 48 が 完了 と書いた瞬間に受けた形）",
  run([{ ...healthy, remainingItems: ["別の段"] }]).violations.filter((v) =>
    v.startsWith("[閉じる前提が未宣言]"),
  ).length,
  1,
  "欄が 部分的 のままでも当てる",
);

expect(
  "部で数えていると宣言し、その部が残っていれば挙がらない",
  run(
    [{ ...healthy, remainingItems: [], parts: [{ part: "P1", state: "残り" }] }],
    [{ block: "b", file: "F.lean", phrase: "降下の段", kind: "数に当たる（部で数えている）", target: "P1", why: "" }],
  ).violations.length,
  0,
  "残っている部を名指した宣言",
);

expect(
  "部で数えていると宣言したのに、その部が済んでいれば挙がる",
  run(
    [{ ...healthy, remainingItems: [], parts: [{ part: "P1", state: "済み" }] }],
    [{ block: "b", file: "F.lean", phrase: "降下の段", kind: "数に当たる（部で数えている）", target: "P1", why: "" }],
  ).violations.filter((v) => v.startsWith("[部で数えているという宣言が当たらない]")).length,
  1,
  "済んだ部を名指した宣言",
);

expect(
  "別の言い方の残り項目と宣言したのに、その残り項目が欄に無ければ挙がる",
  run(
    [{ ...healthy, remainingItems: ["別の段"] }],
    [
      {
        block: "b",
        file: "F.lean",
        phrase: "降下の段",
        kind: "数に当たる（別の言い方の残り項目）",
        target: "在りもしない段",
        why: "",
      },
    ],
  ).violations.filter((v) => v.startsWith("[別の言い方という宣言が当たらない]")).length,
  1,
  "実在しない残り項目を名指した宣言",
);

expect(
  "別の欄で数えていると宣言したのに、その欄が完了しているか実在しなければ挙がる",
  run(
    [{ ...healthy, remainingItems: ["別の段"] }],
    [
      {
        block: "b",
        file: "F.lean",
        phrase: "降下の段",
        kind: "対象外（別の欄で数えている）",
        target: "closed",
        why: "",
      },
    ],
  ).violations.filter((v) => v.startsWith("[別の欄という宣言が当たらない]")).length,
  1,
  "完了した欄を名指した宣言",
);

expect(
  "道具の一般性として対象外にしたものは、違反にはならず件数に出る（塞げないものを見える形にする）",
  run(
    [{ ...healthy, remainingItems: ["別の段"] }],
    [{ block: "b", file: "F.lean", phrase: "降下の段", kind: "対象外（道具の一般性）", why: "" }],
  ).counts.byHumanReading,
  1,
  "人の読みでしか決まらない処分",
);

expect(
  "名指しが消えた宣言は腐りとして挙がる",
  run(
    [{ ...healthy, named: [] }],
    [{ block: "b", file: "F.lean", phrase: "降下の段", kind: "対象外（道具の一般性）", why: "" }],
  ).violations.filter((v) => v.startsWith("[宣言が余っている]")).length,
  1,
  "もう名指されていない事柄の宣言",
);

expect(
  "残り項目が残ったまま 完了 と書けば挙がる",
  run([{ ...healthy, state: "完了" }]).violations.filter((v) =>
    v.startsWith("[閉じる前提を満たさずに完了]"),
  ).length,
  2,
  "残り項目 1 件と lean の名指し 1 件（2 つとも挙がる）",
);

expect(
  "部が残ったまま 完了 と書けば挙がる",
  run([{ block: "b", state: "完了", remainingItems: [], parts: [{ part: "P1", state: "残り" }], named: [] }])
    .violations.filter((v) => v.startsWith("[閉じる前提を満たさずに完了]")).length,
  1,
  "残っている部を持つ完了",
);

expect(
  "前提を満たした 完了 は挙がらない（偽陽性でない）",
  run([{ block: "b", state: "完了", remainingItems: [], parts: [{ part: "P1", state: "済み" }], named: [] }])
    .violations.length,
  0,
  "残り項目も残った部も名指しも無い完了",
);

console.log("");
if (failures > 0) {
  console.log(`**取りこぼし ${failures} 件。**`);
  process.exit(1);
}
console.log("取りこぼし 0 件。");
