#!/usr/bin/env node
/**
 * **検査 O（定義の登場順序）が実際に検出できることの実証。**
 *
 * 「本番で違反 0 件だった」は検査が効いていることの根拠にならない（cycle 22 の教訓）。
 * 再現データは**ユーザーが指摘した当の形**（第 1 章の見出しが $\Lambda$ と
 * 整数スペクトル曲線を定義前に使っていた）である。
 *
 * **ファイルは 1 バイトも書き換えない。** メモリ上の並びに対して判定を回す。
 */

import { type OrderedBlock, type TermDeclaration, violationsIn } from "./definition-order-model.ts";

let failures = 0;
let checks = 0;
const report = (name: string, ok: boolean, detail: string): void => {
  checks += 1;
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**失敗**"}: ${name}`);
  console.log(`      ${detail}`);
};

const block = (
  index: number,
  id: string,
  kind: string,
  title: string,
  body = "",
  labels: string[] = [],
): OrderedBlock => ({ index, id, kind, labels, title, text: `${title} ${body}` });

console.log("");
console.log("定義の登場順序の検査（検査 O）の検出テスト");
console.log("  再現データ: ユーザーが指摘した当の形（第 1 章の見出しが Λ を定義前に使っていた）。");

/** 直す前の並び。見出しが Λ と整数スペクトル曲線を、定義より前に使っていた。 */
const BEFORE: OrderedBlock[] = [
  block(0, "heading_intro", "heading", "序論 — 整数スペクトル曲線の二素点と、Λ 側の決定可能性"),
  block(1, "remark_positioning", "remark", "本論文の位置づけ", "同一の整数スペクトル曲線 P について \\Lambda 側の量を並置する"),
  block(2, "def_ladder", "definition", "決定可能性の梯子", "\\Lambda は対数順序群である", ["paper_def_ladder"]),
  block(3, "def_curve", "definition", "整数スペクトル曲線と周期点数", "整数スペクトル曲線を定める", ["paper_def_curve"]),
];

/** 直したあとの並び。見出しから語を落とし、位置づけが語を使わない書き方になっている。 */
const AFTER: OrderedBlock[] = [
  block(0, "heading_intro", "heading", "序論"),
  block(1, "remark_positioning", "remark", "本論文の位置づけ", "同一の整数係数多項式 P について 2 つの側の量を並置する"),
  block(2, "def_ladder", "definition", "決定可能性の梯子", "\\Lambda は対数順序群である", ["paper_def_ladder"]),
  block(3, "def_curve", "definition", "整数スペクトル曲線と周期点数", "整数スペクトル曲線を定める", ["paper_def_curve"]),
];

const TERMS: TermDeclaration[] = [
  { token: "\\Lambda", aliases: ["対数順序群"], definedIn: "paper_def_ladder", dependsOn: [] },
  { token: "整数スペクトル曲線", definedIn: "paper_def_curve", dependsOn: [] },
];

{
  const found = violationsIn(TERMS, BEFORE);
  const inTitle = found.filter(
    (v) => v.kind === "定義より前に使われている" && v.usedIn === "title",
  );
  report(
    "見出しが定義前の語を使っている（ユーザーが指摘した当の形）",
    inTitle.length >= 1,
    `違反 ${found.length} 件（うち見出し ${inTitle.length} 件。期待 1 件以上）`,
  );
  report(
    "本文が定義前の語を使っている",
    found.some((v) => v.kind === "定義より前に使われている"),
    `Λ と整数スペクトル曲線がどちらも定義より前に現れる並びで挙がる`,
  );
}

report(
  "直したあとの並びでは挙がらない（偽陽性でない）",
  violationsIn(TERMS, AFTER).length === 0,
  `違反 ${violationsIn(TERMS, AFTER).length} 件（期待 0）`,
);

{
  // 依存関係のトポロジカル順序: A の定義が B を使うなら B の定義が先でなければならない。
  const swapped: OrderedBlock[] = [
    block(0, "def_massieu", "definition", "Massieu 自由エントロピー", "", ["paper_def_massieu"]),
    block(1, "def_curve", "definition", "周期点数", "", ["paper_def_curve"]),
  ];
  const terms: TermDeclaration[] = [
    { token: "Massieu 自由エントロピー", definedIn: "paper_def_massieu", dependsOn: ["周期点数"] },
    { token: "周期点数", definedIn: "paper_def_curve", dependsOn: [] },
  ];
  report(
    "依存する語より前に定義されている並びが挙がる",
    violationsIn(terms, swapped).some((v) => v.kind === "依存する語より前に定義されている"),
    "Massieu 自由エントロピーの定義が、依存する周期点数の定義より前にある並びで挙がる",
  );
  const ordered: OrderedBlock[] = [
    block(0, "def_curve", "definition", "周期点数", "", ["paper_def_curve"]),
    block(1, "def_massieu", "definition", "Massieu 自由エントロピー", "", ["paper_def_massieu"]),
  ];
  report(
    "順序が正しければ挙がらない（偽陽性でない）",
    violationsIn(terms, ordered).length === 0,
    `違反 ${violationsIn(terms, ordered).length} 件（期待 0）`,
  );
}

{
  // 同じブロックが複数の語をまとめて定義する場合は、ブロックの中の順序を論じない。
  const one: OrderedBlock[] = [
    block(0, "def_curve", "definition", "整数スペクトル曲線と周期点数", "", ["paper_def_curve"]),
  ];
  const terms: TermDeclaration[] = [
    { token: "整数スペクトル曲線", definedIn: "paper_def_curve", dependsOn: [] },
    { token: "周期点数", definedIn: "paper_def_curve", dependsOn: ["整数スペクトル曲線"] },
  ];
  report(
    "同じブロックがまとめて定義する場合は挙がらない（偽陽性でない）",
    violationsIn(terms, one).length === 0,
    `違反 ${violationsIn(terms, one).length} 件（期待 0）`,
  );
}

{
  // 台帳が腐ったら落ちる。
  const terms: TermDeclaration[] = [
    { token: "\\Lambda", definedIn: "paper_def_does_not_exist", dependsOn: [] },
  ];
  report(
    "台帳が指す定義ブロックが本文に無ければ挙がる",
    violationsIn(terms, AFTER).some((v) => v.kind === "台帳が指す定義ブロックが本文に無い"),
    "改名・削除で定義ブロックが消えたら赤くなる",
  );
  const dangling: TermDeclaration[] = [
    { token: "\\Lambda", definedIn: "paper_def_ladder", dependsOn: ["台帳に無い語"] },
  ];
  report(
    "台帳が指す依存語が台帳に無ければ挙がる",
    violationsIn(dangling, AFTER).some((v) => v.kind === "台帳が指す依存語が台帳に無い"),
    "依存関係の書き間違いが赤くなる",
  );
}

console.log("");
if (failures > 0) {
  console.log(`**${failures} / ${checks} 件で検出できなかった。**`);
  process.exit(1);
}
console.log(`${checks} / ${checks} 件で検出を実証した。`);
