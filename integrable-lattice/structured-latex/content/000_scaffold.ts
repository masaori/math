/**
 * 足場（scaffold）。**論文本体ではない。**
 *
 * 構造化テキストの基盤（型検査・実行時検証・生成物・負テスト）が動くことを示すための
 * 最小の content である。ここに数学的な主張の正本は無い。論文本体を書き始めるときは
 * `content/001_*.ts` 以降を追加し、このファイルは残したまま（あるいは最初の実ブロックに
 * 置き換えて）よい。ただし content が空になると `tools/generate-index.ts` が
 * 「ラベルを 1 件も抽出できない」で落ちるので、最低 1 ブロックは残す。
 */

import { defineBlocks, displayMath, math, paragraph, ref, todo } from "../schema.ts";

export default defineBlocks([
  {
    id: "scaffold_000_heading",
    kind: "heading",
    level: 1,
    sourcePath: "structured-latex/content/000_scaffold.ts",
    sourceOrdinal: 1,
    title: { text: "足場（構造化テキスト基盤の動作確認）" },
    labels: [],
    conversion: { status: "added" },
  },
  {
    id: "scaffold_001_definition_placeholder",
    kind: "definition",
    sourcePath: "structured-latex/content/000_scaffold.ts",
    sourceOrdinal: 2,
    title: { text: "足場の定義ブロック" },
    labels: ["scaffold_def_placeholder"],
    // 可算側（Λ）を宣言したブロックは realEscape を書けない（型で拒否される）。
    habitat: "Lambda",
    statement: [
      paragraph([
        "このブロックは基盤の動作確認のための足場であり、数学的な内容の正本ではない。",
        "可算側の住処（ここでは ",
        math(String.raw`\Lambda`),
        "）を宣言したブロックには ",
        math(String.raw`realEscape`),
        " を書けないことを示す例になっている。",
      ]),
      todo("Λ（対数順序群）の定義そのものは、論文本体の章を起こすときにここへ書く。"),
    ],
    conversion: { status: "added" },
  },
  {
    id: "scaffold_002_claim_placeholder",
    kind: "claim",
    sourcePath: "structured-latex/content/000_scaffold.ts",
    sourceOrdinal: 3,
    title: { text: "足場の主張ブロック（ℝ 脱出の宣言つき）" },
    labels: ["scaffold_claim_placeholder"],
    // 非可算側を宣言したブロックは realEscape が必須（型で強制される）。
    habitat: "mixed",
    realEscape:
      "足場としての例示のみ。可算な対象（Λ の元）を扱いながら、指数評価のために一度だけ " +
      "実数の順序完備性を使う、という形の脱出をここで宣言する。実際の脱出箇所は " +
      "論文本体のブロックで具体的に書く。",
    verification: ["sagemath/check/cycle15_T3_tau_d3"],
    statement: [
      paragraph([
        ref("scaffold_def_placeholder"),
        " の記法のもとで、次の形の評価を扱う（内容は足場であり、主張の正本ではない）。",
      ]),
      displayMath(String.raw`\lambda \in \Lambda \subset \mathbb{R}`),
      paragraph([
        "この数式に ",
        math(String.raw`\mathbb{R}`),
        " が現れているため、可算側の habitat を宣言していたら実行時検証が落ちる",
        "（`tools/validate-content.ts` の可算／非可算の分別検査）。",
      ]),
    ],
    proof: [todo("足場のため証明は無い。論文本体のブロックでは proof を必ず書く。")],
    conversion: { status: "added" },
  },
]);
