/**
 * 検査 L の検出テスト。再現データは、cycle 28 step 3 が実際に直した当の形である
 * （cycle 27 で強調を落としたときに区切りを失った、箇条書きの直前の断片）。
 *
 * 直した 8 件の字面をそのまま流し、全件が違反として出ることを確かめる。
 * cycle 29 step 5 で、同じ断片を箇条書き以外の位置（段落の直前・ブロックの末尾）へ
 * 置いた場合も検出されることを加えた。
 *
 * cycle 30 step 4 で、別行立て数式の直前を体言だけの断片の形に限って見るようにしたので、
 * その形の再現データと、そこで拾ってはいけない言い回しを加えた。
 *
 * あわせて、通ってほしい形が違反にならないことも確かめる。
 * 検出できるだけの検査は、誤検出で使えなくなるからである。
 * 通ってほしい形は本文の実データから採っている——広げた先である段落の直前・
 * ブロックの末尾については、実際に本文にある一番短い段落を置いた。
 * 数式の直前については、本文にある実際の言い回しと、
 * `exact-solution-of-2d-ising-model` から採った「数式をまたいで続く文」を置いた。
 */

import { END_OF_BLOCK, isRunInLabel, type RunInLabelSite } from "./runin-label-model.ts";

/** 再現データ 1 件ぶんの指定。字面と直後の種別のほかは、数式の直前のときだけ効く。 */
type Fixture = {
  readonly text: string;
  readonly nextType: string;
  readonly locale?: string;
  readonly containsMath?: boolean;
  readonly containsReference?: boolean;
  /** 数式の次の段落の字面。文が数式をまたいで続いているかを見るために置く。 */
  readonly textAfterDisplay?: string;
};

const site = (fixture: Fixture): RunInLabelSite => ({
  locale: fixture.locale ?? "ja",
  blockId: "fixture",
  file: "fixture.ts",
  where: "statement",
  text: fixture.text,
  nextType: fixture.nextType,
  // 字面に数式の印（◻）があれば数式を含むとみなす。実データの字面をそのまま置くため。
  containsMath: fixture.containsMath ?? fixture.text.includes("◻"),
  containsReference: fixture.containsReference ?? false,
  textAfterDisplay: fixture.textAfterDisplay,
});

/** cycle 27 の強調除去で区切りを失った、実際の字面。 */
const SHOULD_BE_CAUGHT: readonly Fixture[] = [
  { text: "限界", nextType: "list" },
  { text: "可算と非可算の分別", nextType: "list" },
  { text: "Limitations", nextType: "list", locale: "en" },
  { text: "Countable versus uncountable", nextType: "list", locale: "en" },
  // 同型（強調が唯一の区切りだった見出し）
  { text: "各量の帰属", nextType: "list" },
  { text: "既出性", nextType: "list" },
  { text: "残る限界", nextType: "list" },
  { text: "方法論上の注記", nextType: "list" },
  // 箇条書き以外の位置（cycle 29 step 5 で広げた分）。同じ断片を置き場所だけ変えたもの。
  { text: "限界", nextType: "paragraph" },
  { text: "可算と非可算の分別", nextType: "paragraph" },
  { text: "Limitations", nextType: "paragraph", locale: "en" },
  { text: "各量の帰属", nextType: END_OF_BLOCK },
  { text: "残る限界", nextType: END_OF_BLOCK },
  { text: "Countable versus uncountable", nextType: END_OF_BLOCK, locale: "en" },
  // 別行立て数式の直前（cycle 30 step 4 で限定して見るようにした分）。
  // 同じ断片を数式の直前へ置いたもので、数式の向こう側で文が続いていない場合。
  { text: "限界", nextType: "displayMath", textAfterDisplay: "本命題では以上を仮定する。" },
  { text: "各量の帰属", nextType: "displayMath" },
  { text: "残る限界", nextType: "displayMath", textAfterDisplay: "以下では ◻ を固定する。" },
  {
    text: "Limitations",
    nextType: "displayMath",
    locale: "en",
    textAfterDisplay: "We fix ◻ throughout.",
  },
  { text: "Countable versus uncountable", nextType: "displayMath", locale: "en" },
  // 実データからの真陽性。`exact-solution-of-2d-ising-model` の本文にある、
  // 直後の数式が積の定義そのものである断片（cycle 30 step 4 の走査で見つけた唯一の発火）。
  {
    text: "積",
    nextType: "displayMath",
    textAfterDisplay: "本論文で ◻ に必要な構造はこの2つの演算だけである。",
  },
];

/** 違反にしてはいけない形。 */
const SHOULD_PASS: readonly Fixture[] = [
  // 直った後の形
  { text: "本命題に残る限界は次のとおりである。", nextType: "list" },
  { text: "本命題に現れる量の、可算と非可算の分別は次のとおりである。", nextType: "list" },
  {
    text: "The limitations that remain in this proposition are the following.",
    nextType: "list",
    locale: "en",
  },
  // 箇条書きの直前でも、文になっていれば通る
  { text: "次の 4 点だけである。用語と記号は第 1--3 章で順に定める。", nextType: "list" },
  // コロンで終わる導入も通る
  { text: "各量の帰属:", nextType: "list" },
  // 広げた先の実データ。本文にある段落のうち、直後が段落・末尾で最も短いもの。
  { text: "の設定で次が成り立つ。", nextType: "paragraph" },
  { text: "holds, by ◻.", nextType: "paragraph", locale: "en" },
  { text: "すなわち ◻ 項は現れない。", nextType: "paragraph" },
  { text: "偶数 ◻ では成立しない（◻ で ◻）。", nextType: END_OF_BLOCK },
  { text: "一般の ◻ でも終結式を ◻ 回入れ子にすればよい。", nextType: END_OF_BLOCK },
  // 数式の直前にある本文の実際の言い回し。「体言止めなら見出し」「ラテン文字で終われば見出し」
  // 「数式を含まなければ見出し」「閉じ括弧で終われば見出し」のいずれの単独規則にも
  // 反例として効く（模型の doc を参照）。
  { text: "したがって ◻ が atoral ならば", nextType: "displayMath" },
  { text: "すなわち", nextType: "displayMath" },
  { text: "が成り立つ。ここで", nextType: "displayMath" },
  { text: "の (K4) の一意分解", nextType: "displayMath", containsReference: true },
  { text: "が成り立ち、したがって命題 V", nextType: "displayMath" },
  { text: "(U1 付値側と位置側の分業)", nextType: "displayMath" },
  { text: "and therefore", nextType: "displayMath", locale: "en" },
  { text: "where", nextType: "displayMath", locale: "en" },
  {
    text: "(0) 出発点。  の証明の (0) と同じ総和公式",
    nextType: "displayMath",
    containsReference: true,
  },
  { text: "指標による対角化と Kirchhoff の matrix-tree 定理から", nextType: "displayMath" },
  // 数式をまたいで文が続く形。`exact-solution-of-2d-ising-model` の本文とノートから採った。
  // 条件 5 を落とすとこの 2 件が違反になる。
  { text: "集合", nextType: "displayMath", textAfterDisplay: "を考える。◻ が ◻ の部分集合として" },
  {
    text: "群の列と群準同型の列",
    nextType: "displayMath",
    textAfterDisplay: "が完全列であるとは、各中間の添字 ◻ について",
  },
];

let failed = 0;

console.log("");
console.log("見出し代わりの断片の検査の検出テスト");
console.log("  再現データ: cycle 28 step 3 が実際に直した 8 件と、その同型・置き場所違い");

let caught = 0;
for (const fixture of SHOULD_BE_CAUGHT) {
  if (isRunInLabel(site(fixture))) {
    caught += 1;
  } else {
    console.log(`  NG: 検出されなかった 「${fixture.text}」（直後 ${fixture.nextType}）`);
    failed += 1;
  }
}
console.log(`  検出: ${caught} / ${SHOULD_BE_CAUGHT.length} 件`);

let passed = 0;
for (const fixture of SHOULD_PASS) {
  if (!isRunInLabel(site(fixture))) {
    passed += 1;
  } else {
    console.log(`  NG: 誤検出した 「${fixture.text}」（直後 ${fixture.nextType}）`);
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
