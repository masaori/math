#!/usr/bin/env node
/**
 * **検査 W（執筆指示の混入）が実際に検出できることの実証。**
 *
 * 「本番で違反 0 件だった」は検査が効いていることの根拠にならない（cycle 22 の教訓）。
 * 再現データは**ユーザーが実際に PDF を読んで指摘した形そのもの**と、
 * 本文全体を走査して見つかった同型の形である。
 *
 * **ファイルは 1 バイトも書き換えない。** メモリ上の値に対して判定を回す。
 */

import { type LeakSite, violationsIn } from "./authoring-leak-model.ts";

let failures = 0;
let checks = 0;
const report = (name: string, ok: boolean, detail: string): void => {
  checks += 1;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**失敗**"}: ${name}`);
  console.log(`      ${detail}`);
};

const site = (value: string, field: LeakSite["field"] = "text"): LeakSite => ({
  locale: "ja",
  blockId: "fixture_block",
  file: "content/fixture.ts",
  field,
  value,
});

console.log("");
console.log("検査 W（執筆指示の混入）の検出テスト");
console.log("  再現データ: ユーザーが PDF を読んで指摘した形と、走査で見つかった同型の形。");

/** 実際に本文へ混入していた形（2026-08-03 に除去した）。 */
const REAL_LEAKS: { name: string; value: string; field?: LeakSite["field"] }[] = [
  {
    name: "題に書き手への指示が入っている（ユーザーが指摘した当の形）",
    value: "本論文の位置づけ（最初に明示する）",
    field: "title",
  },
  {
    name: "題に書き手への指示が入っている（同型・命題 D の限界）",
    value: "命題 D に残る限界（命題の一部として明示する）",
    field: "title",
  },
  { name: "本文の見出し語に書き手への指示（本文全体に 7 箇所あった）", value: "限界（主張の一部として述べる）" },
  { name: "本文の見出し語に書き手への指示（可算と非可算の分別）", value: "可算と非可算の分別（本命題の主張の一部として明示する）" },
  { name: "作業ツリーのサイクル番号が本文に漏れている", value: "cycle 18 の Lean 形式化で発見した本文の誤り" },
  { name: "読者が開けないリポジトリ内部の資料を指している", value: "詳細は根拠レポート outputs/reports/... にある" },
  {
    name: "英語版の同型（書き手への指示の括弧）",
    value: "What this paper is (stated up front)",
    field: "title",
  },
];

for (const leak of REAL_LEAKS) {
  const found = violationsIn([site(leak.value, leak.field)]);
  report(
    leak.name,
    found.length >= 1,
    `${JSON.stringify(leak.value.slice(0, 46))} → ${found.length} 件（期待 1 件以上）` +
      (found[0] === undefined ? "" : ` / 型: ${found[0].kind}`),
  );
}

/** 読者への情報である括弧・語。ここで偽陽性を出すと本文が書けなくなる。 */
const BENIGN: { name: string; value: string }[] = [
  { name: "読者への情報である括弧（条件を添えている）", value: "消滅深度を θ で定める（θ(P) ≤ ℓ なら方向だけで定まる）。" },
  { name: "読者への情報である括弧（規約を書いている）", value: "そのような m が 1 つも無ければ θ := ∞ と読む（規約）。" },
  { name: "数学の文で「述べる」が動詞として出る", value: "本命題は 2 つの主張を述べているが、どちらも既知である。" },
  { name: "「限界」という語そのものは執筆指示ではない", value: "限界: この判定は ℓ ∤ N の段では使えない。" },
  { name: "循環群の位数のような普通の数字", value: "位数 18 の巡回群を取る。" },
];

for (const benign of BENIGN) {
  const found = violationsIn([site(benign.value)]);
  report(
    `偽陽性でない: ${benign.name}`,
    found.length === 0,
    `${JSON.stringify(benign.value.slice(0, 46))} → ${found.length} 件（期待 0）`,
  );
}

report(
  "見出し・題も対象である（本文より先に読まれるため）",
  violationsIn([site("序論（ここで述べる）", "title")]).length === 1,
  "題に書かれた執筆指示が挙がる",
);

console.log("");
if (failures > 0) {
  console.log(`**${failures} / ${checks} 件で検出できなかった。**`);
  process.exit(1);
}
console.log(`${checks} / ${checks} 件で検出を実証した。`);
