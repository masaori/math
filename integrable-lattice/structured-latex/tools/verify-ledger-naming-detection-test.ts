/**
 * **散文の名指しと残りの勘定の突き合わせの検出テスト**（cycle 45 step 1）。
 *
 * 検査が黙っていないことを、**壊した状態を作って挙がることで**実証する。
 * 緑であることに意味を持たせるには、赤くなる条件を示さなければならない
 * （cycle 37 step 5 の「空振りする検査は、緑であることが何も意味しない」と同じ規律）。
 *
 * **判定は本体と同じ関数を呼ぶ**（写しを置くと、本体を直したときにテストだけ古くなる）。
 */
import { auditNamingCoverage, type NamingDisposition } from "./ledger-naming-model.ts";

let failures = 0;
const expect = (label: string, actual: number, expected: number, detail: string) => {
  const ok = actual === expected;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**取りこぼし**"}: ${label}`);
  console.log(`      ${detail} → ${actual} 件（期待 ${expected}）`);
};

console.log("");
console.log("散文の名指しと残りの勘定の突き合わせの検出テスト（cycle 45 step 1）");

/** 名指しが残り項目に当たっている、健全な形。 */
const healthy = {
  block: "b",
  prose: "降下の段は未形式化である。判別式の段は書いた。",
  remainingItems: ["降下の段"],
  openParts: [] as string[],
};

expect(
  "名指しが残り項目に当たっていれば挙がらない（偽陽性でない）",
  auditNamingCoverage({ entries: [healthy], dispositions: [] }).violations.length,
  0,
  "残り項目「降下の段」を含む文",
);

expect(
  "名指しが残り項目にも部にも当たらず、処分も無ければ挙がる（cycle 44 で実際に起きた形）",
  auditNamingCoverage({
    entries: [{ ...healthy, remainingItems: ["別の段"], prose: "降下の段は未形式化である。別の段。" }],
    dispositions: [],
  }).violations.filter((v) => v.startsWith("[名指しの処分が無い]")).length,
  1,
  "散文が名指ししているのに残り項目に入っていない事柄",
);

expect(
  "処分を宣言すれば挙がらない",
  auditNamingCoverage({
    entries: [{ ...healthy, remainingItems: ["別の段"], prose: "降下の段は未形式化である。別の段。" }],
    dispositions: [
      { block: "b", sentence: "降下の段は未形式化である。", kind: "済み", why: "cycle 99 で書いた" },
    ] satisfies NamingDisposition[],
  }).violations.length,
  0,
  "処分つきの名指し",
);

expect(
  "処分に理由が無ければ挙がる",
  auditNamingCoverage({
    entries: [{ ...healthy, remainingItems: ["別の段"], prose: "降下の段は未形式化である。別の段。" }],
    dispositions: [{ block: "b", sentence: "降下の段は未形式化である。", kind: "済み", why: "  " }],
  }).violations.filter((v) => v.startsWith("[処分に理由が無い]")).length,
  1,
  "理由が空の処分",
);

expect(
  "改稿で浮いた処分は腐りとして挙がる",
  auditNamingCoverage({
    entries: [healthy],
    dispositions: [
      { block: "b", sentence: "もう散文に無い文である。", kind: "済み", why: "cycle 99" },
    ],
  }).violations.filter((v) => v.startsWith("[処分が腐っている]")).length,
  1,
  "散文から消えた文についての処分",
);

expect(
  "台帳に無い欄を指す処分は挙がる",
  auditNamingCoverage({
    entries: [healthy],
    dispositions: [{ block: "存在しない", sentence: "x", kind: "対象外", why: "y" }],
  }).violations.filter((v) => v.startsWith("[台帳に無い欄]")).length,
  1,
  "改名・削除で浮いた宣言",
);

expect(
  "残り項目が散文に無ければ挙がる（部を持つ欄でも当てる）",
  auditNamingCoverage({
    entries: [{ block: "c", prose: "(K1) は未形式化である。", remainingItems: ["散文に無い項目"], openParts: ["K1"] }],
    dispositions: [],
  }).violations.filter((v) => v.startsWith("[残り項目が散文に無い]")).length,
  1,
  "散文と食い違う残り項目",
);

expect(
  "残っている部の記号を含む名指しは数に入っているので挙がらない",
  auditNamingCoverage({
    entries: [{ block: "c", prose: "(K1) は未形式化である。", openParts: ["K1"] }],
    dispositions: [],
  }).violations.length,
  0,
  "部の記号を含む名指し",
);

console.log("");
if (failures > 0) {
  console.error(`取りこぼし ${failures} 件。`);
  process.exit(1);
}
console.log("取りこぼし 0 件。");
