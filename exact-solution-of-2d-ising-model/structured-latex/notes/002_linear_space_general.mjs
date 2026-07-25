import { defineNotes, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

// 章「線型空間の一般論」に紐づく参照用ノート。文書本体ではない。

export default defineNotes([
  {
    id: "note_linear_space_general_001_reading_and_usage",
    targets: ["tensor_basis"],
    title: { text: "ステートメントの読み方と本論文での用途" },
    sourcePath: "_old/typst/parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ",
    body: [
      paragraph([
        "基底であるのは族全体であって、個々のテンソル積 ",
        math(String.raw`e_{i_1} \otimes \cdots \otimes e_{i_m}`),
        " ではない（単一の元は 1 次元しか張らないので、",
        math(String.raw`n^m \geq 2`),
        " のとき基底になり得ない）。また ",
        math(String.raw`V`),
        " の次元 ",
        math(String.raw`n`),
        " とテンソル冪の階数 ",
        math(String.raw`m`),
        " は独立な量である。本論文での主な用途は ",
        math(String.raw`V = \mathrm{Mat}(2,\mathbb{C})`),
        "（",
        math(String.raw`n = 4`),
        "）、",
        math(String.raw`m = M`),
        " の場合であり、",
        ref("Z_Y_generate_algebra"),
        " や ",
        ref("centralizer_is_scalar"),
        " で ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の基底を得るために使う。",
      ]),
    ],
  },
]);
