/**
 * **検査 L の検出テスト**。再現データは、cycle 28 step 3 が実際に直した当の形である
 * （cycle 27 で強調を落としたときに区切りを失った、箇条書きの直前の断片）。
 *
 * 直した 8 件の字面をそのまま流し、**全件が違反として出ること**を確かめる。
 * あわせて、**通ってほしい形**（数式を導く言い回し、文になっている前置き）が
 * 違反にならないことも確かめる。検出できるだけの検査は、誤検出で使えなくなるからである。
 */

import { isRunInLabel, type RunInLabelSite } from "./runin-label-model.ts";

const site = (text: string, nextType: string): RunInLabelSite => ({
  locale: "ja",
  blockId: "fixture",
  file: "fixture.ts",
  where: "statement",
  text,
  nextType,
});

/** cycle 27 の強調除去で区切りを失った、実際の字面。 */
const SHOULD_BE_CAUGHT: readonly (readonly [string, string])[] = [
  ["限界", "list"],
  ["可算と非可算の分別", "list"],
  ["Limitations", "list"],
  ["Countable versus uncountable", "list"],
  // 同型（強調が唯一の区切りだった見出し）
  ["各量の帰属", "list"],
  ["既出性", "list"],
  ["残る限界", "list"],
  ["方法論上の注記", "list"],
];

/** 違反にしてはいけない形。 */
const SHOULD_PASS: readonly (readonly [string, string])[] = [
  // 直った後の形
  ["本命題に残る限界は次のとおりである。", "list"],
  ["本命題に現れる量の、可算と非可算の分別は次のとおりである。", "list"],
  ["The limitations that remain in this proposition are the following.", "list"],
  // 数式を導く言い回し（箇条書きではないので対象外）
  ["したがって ◻ が atoral ならば", "displayMath"],
  ["すなわち", "displayMath"],
  ["が成り立つ。ここで", "displayMath"],
  // 箇条書きの直前でも、文になっていれば通る
  ["次の 4 点だけである。用語と記号は第 1--3 章で順に定める。", "list"],
  // コロンで終わる導入も通る
  ["各量の帰属:", "list"],
];

let failed = 0;

console.log("");
console.log("見出し代わりの断片の検査の検出テスト");
console.log("  再現データ: cycle 28 step 3 が実際に直した 8 件と、その同型");

let caught = 0;
for (const [text, next] of SHOULD_BE_CAUGHT) {
  if (isRunInLabel(site(text, next))) {
    caught += 1;
  } else {
    console.log(`  NG: 検出されなかった 「${text}」`);
    failed += 1;
  }
}
console.log(`  検出: ${caught} / ${SHOULD_BE_CAUGHT.length} 件`);

let passed = 0;
for (const [text, next] of SHOULD_PASS) {
  if (!isRunInLabel(site(text, next))) {
    passed += 1;
  } else {
    console.log(`  NG: 誤検出した 「${text}」`);
    failed += 1;
  }
}
console.log(`  誤検出なし: ${passed} / ${SHOULD_PASS.length} 件`);

console.log("");
if (failed > 0) {
  console.log(`NG: ${failed} 件が期待どおりでない。`);
  process.exit(1);
}
console.log(
  `${SHOULD_BE_CAUGHT.length + SHOULD_PASS.length} / ${
    SHOULD_BE_CAUGHT.length + SHOULD_PASS.length
  } 件すべて期待どおり（検出 ${SHOULD_BE_CAUGHT.length} 件・素通り ${SHOULD_PASS.length} 件）。`,
);
