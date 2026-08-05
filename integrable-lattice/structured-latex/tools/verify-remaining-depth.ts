/**
 * **主張ごとの残り段数の検査**（cycle 39 step 5 で新設。検査 D）。
 *
 * 台帳は `remaining-depth.ts`。機械が見るのは 3 つ。
 *
 * 1. **段数が数えられない欄が、1 つ残らず理由つきで宣言されていること。**
 *    黙って数から外れる道を塞ぐ（これが本検査の本体である）。
 * 2. 理由を宣言した欄が、実際に数えられない側にあること
 *    （`remainingItems` を足したのに理由が残っている＝腐りを検出する）。
 * 3. 宣言した欄が検査 F の台帳に実在すること。
 *
 * そのうえで**主張ごとの残り段数と、その合計を毎回印字する。**
 * 件数が動かない日でも、段が動いたかどうかがこの数に出る。
 */
import { FORMALIZATION_COVERAGE } from "./formalization-coverage.ts";
import { UNCOUNTABLE_REASONS } from "./remaining-depth.ts";

const violations: string[] = [];

const incomplete = FORMALIZATION_COVERAGE.filter((e) => e.state !== "完了");
const countable: { block: string; depth: number }[] = [];
const uncountable: string[] = [];

/** cycle 40 step 2: 部ごとの状態を持つ欄は、残っている部の数が段数になる。 */
const byParts: { block: string; depth: number; done: number; unwitnessed: number }[] = [];
for (const entry of incomplete) {
  if (entry.state === "部分的" && entry.remainingItems !== undefined) {
    countable.push({ block: entry.block, depth: entry.remainingItems.length });
  } else if (entry.state === "部分的" && entry.partStates !== undefined) {
    const done = entry.partStates.filter((p) => p.state === "済み").length;
    const unwitnessed = entry.partStates.filter((p) => p.state === "証拠なし").length;
    const depth = entry.partStates.length - done;
    countable.push({ block: entry.block, depth });
    byParts.push({ block: entry.block, depth, done, unwitnessed });
  } else {
    uncountable.push(entry.block);
  }
}

const declared = new Map(UNCOUNTABLE_REASONS.map((r) => [r.block, r.why]));
const knownBlocks = new Set(FORMALIZATION_COVERAGE.map((e) => e.block));

for (const block of uncountable) {
  if (!declared.has(block)) {
    violations.push(
      `[数えられない欄に理由が無い] ${block} — 段数が数えられないのに理由の宣言が無い` +
        "（黙って数から外れる道は塞いである。`remaining-depth.ts` に理由を書くこと）",
    );
  }
}
for (const reason of UNCOUNTABLE_REASONS) {
  if (!knownBlocks.has(reason.block)) {
    violations.push(`[台帳に無い欄] ${reason.block} — 検査 F の台帳に無い`);
  } else if (!uncountable.includes(reason.block)) {
    violations.push(
      `[理由が腐っている] ${reason.block} — 数えられる側になったのに「数えられない理由」が残っている` +
        "（`remainingItems` が足されたなら、この宣言は消すこと）",
    );
  }
}

const total = countable.reduce((s, c) => s + c.depth, 0);

console.log("");
console.log("主張ごとの残り段数（cycle 39 step 5 で追加）");
console.log(
  `  完了でない本文の主張 ${incomplete.length} 件 / ` +
    `**段数が数えられる ${countable.length} 件（合計 ${total} 段）** / 数えられない ${uncountable.length} 件`,
);
console.log(
  "  **なぜこれを測るか**: 本文側の件数は完了したかどうかの 2 値でしか見ていないので、" +
    "**段が動いても件数は動かず、進んだ日と何もしなかった日が同じに見える。** " +
    "段数を出せば、件数が動かない日でも動いたかどうかが見える。",
);
if (countable.length > 0) {
  console.log("  数えられる欄:");
  for (const c of countable) console.log(`    - ${c.block}: 残り ${c.depth} 段`);
}
if (byParts.length > 0) {
  console.log(
    `  部ごとの状態から数えた欄（cycle 40 step 2 で追加）: ${byParts.length} 件 / ` +
      `部 ${byParts.reduce((s, b) => s + b.depth + b.done, 0)} 件（済み ` +
      `${byParts.reduce((s, b) => s + b.done, 0)} / **証拠なし ` +
      `${byParts.reduce((s, b) => s + b.unwitnessed, 0)}** / 残り ` +
      `${byParts.reduce((s, b) => s + b.depth - b.unwitnessed, 0)}）`,
  );
  console.log(
    "  **cycle 39 の段階では、この 8 件は「本文が部で切られているが、どの部が済んでいるかを台帳が持っていない」" +
      "という理由で数から外れていた。** 部ごとの状態を持たせたので数に入る。" +
      "**測ってみて出た形が 1 つある**——散文が「形式化した」と書いている部のうち、" +
      "**その部を閉じた宣言を名指せないものがある。** `済み` と書けば根拠の保証を失い、" +
      "`残り` と書けば済んでいるかもしれないものを残りとして数えることになるので、" +
      "**`証拠なし` という別の状態にして、段数の勘定では残り側へ入れた**（この数が下界であることを崩さないため）。",
  );
}
if (uncountable.length > 0) {
  console.log("  数えられない欄（理由つきで宣言させている）:");
  for (const block of uncountable) console.log(`    - ${block}: ${declared.get(block) ?? "（未宣言）"}`);
}
console.log(
  "  限界: **段の数は段の切り方に依存する**ので、欄どうしでは比べられない。" +
    "比べられるのは同じ欄の時間変化だけである。" +
    "**また残りが尽きたら完了する、とは言えない**——cycle 35・36・38・39 で 4 回、" +
    "書いてみると外側に段が現れた（検査 E がその一部を塞いでいる）。" +
    "**この数は下界であって、完了までの距離ではない。** " +
    "数えられない理由の宣言は人の言葉であり、機械はそれが正しいかを見ない。",
);

if (violations.length > 0) {
  console.log("");
  console.log(`違反 ${violations.length} 件`);
  for (const violation of violations) console.log(`    ${violation}`);
  console.error(`違反 ${violations.length} 件。`);
  process.exit(1);
}
console.log("");
console.log("違反 0 件。");
