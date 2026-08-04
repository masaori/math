/**
 * **「エントリを数える主張」の検査が、現に起きた事故を捕まえることの実証**。
 *
 * 再現データの中心は **cycle 35 step 3 に現に起きた形そのもの**である——
 * 台帳が「3 件」と書いたあと、2 つの欄へ語が書き足され、3 という数だけが取り残された。
 *
 * 通ってしまう形（偽陽性でない側）も併せて実証する。
 */

import { auditEntryCountClaim, type EntryCountClaim } from "./entry-count-claims.ts";

const claim: EntryCountClaim = {
  terms: ["matrix-tree", "Matrix–Tree"],
  counts: "本文の台帳",
  holder: "テスト用の欄",
  phrase: "実測は ",
  unit: "件",
  why: "検出テスト用。",
};

type Case = {
  readonly name: string;
  readonly countedTexts: readonly string[];
  readonly holderText: string | null;
  readonly expectViolations: number;
  readonly expectCounted: number;
};

const cases: readonly Case[] = [
  {
    name: "cycle 35 step 3 に現に起きた形（3 件と書いたあと 2 つの欄へ書き足された）",
    countedTexts: [
      "matrix-tree 定理が要る",
      "matrix-tree 定理が要る",
      "matrix-tree 定理が要る",
      "Matrix–Tree 定理を挙げている",
      "matrix-tree 定理が要る",
    ],
    holderText: "この壁が塞いでいる本文の主張は 実測は 3 件である。",
    expectViolations: 1,
    expectCounted: 5,
  },
  {
    name: "直したあと（数え直しと要約が一致する）は挙がらない",
    countedTexts: [
      "matrix-tree 定理が要る",
      "matrix-tree 定理が要る",
      "matrix-tree 定理が要る",
      "Matrix–Tree 定理を挙げている",
      "matrix-tree 定理が要る",
    ],
    holderText: "この壁が塞いでいる本文の主張は 実測は 5 件である。",
    expectViolations: 0,
    expectCounted: 5,
  },
  {
    name: "語に触れる欄が減った場合も挙がる（書き足しの逆向き）",
    countedTexts: ["matrix-tree 定理が要る", "無関係"],
    holderText: "実測は 5 件である。",
    expectViolations: 1,
    expectCounted: 1,
  },
  {
    name: "数を書いている欄そのものが消えたら挙がる",
    countedTexts: ["matrix-tree 定理が要る"],
    holderText: null,
    expectViolations: 1,
    expectCounted: 1,
  },
  {
    name: "表記ゆれだけの欄も数える（Matrix–Tree も 1 件と数える）",
    countedTexts: ["Matrix–Tree 定理"],
    holderText: "実測は 1 件である。",
    expectViolations: 0,
    expectCounted: 1,
  },
  {
    name: "語に触れていない欄は数えない（境界）",
    countedTexts: ["Cauchy–Binet だけの欄", "全域木という語だけの欄"],
    holderText: "実測は 0 件である。",
    expectViolations: 0,
    expectCounted: 0,
  },
];

console.log("");
console.log("「エントリを数える主張」の検出テスト");

let ok = 0;
const failures: string[] = [];
for (const c of cases) {
  const result = auditEntryCountClaim({
    claim,
    countedTexts: c.countedTexts,
    holderText: c.holderText,
  });
  const good =
    result.violations.length === c.expectViolations && result.counted === c.expectCounted;
  console.log(
    `  検出: ${c.name}`,
  );
  console.log(
    `      数え直し ${result.counted} 件（期待 ${c.expectCounted}）` +
      ` / 違反 ${result.violations.length} 件（期待 ${c.expectViolations}）`,
  );
  if (good) ok += 1;
  else
    failures.push(
      `${c.name}: 数え直し ${result.counted}（期待 ${c.expectCounted}）` +
        ` / 違反 ${result.violations.length}（期待 ${c.expectViolations}）`,
    );
}

console.log("");
if (failures.length > 0) {
  for (const f of failures) console.log(`  NG ${f}`);
  console.log(`${ok} / ${cases.length} 件しか検出を実証できなかった。`);
  process.exit(1);
}
console.log(`${ok} / ${cases.length} 件で検出を実証した。`);
