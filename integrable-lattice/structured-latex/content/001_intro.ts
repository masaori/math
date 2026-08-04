/**
 * 論文本体 第 1 章: 序論。
 *
 * 正本は `outputs/paper-plans/002_R_Lambda_duality.md`（企画）ではなく**このファイル群**である。
 * 企画は履歴として残してある。
 *
 * 本論文は T1 Reframe（既知結果の可算・厳密・形式検証可能な書き換え）であり、
 * **新しい定理を主張しない**。この位置づけを本文の各所で明示する。
 */

import { defineBlocks, displayMath, list, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "paper_010_heading_intro",
    kind: "heading",
    level: 1,
    origin: { path: "structured-latex/content/001_intro.ts", ordinal: 1 },
    title: { text: "序論" },
    labels: [],
  },
  {
    id: "paper_011_remark_positioning",
    kind: "remark",
    origin: { path: "structured-latex/content/001_intro.ts", ordinal: 2 },
    title: { text: "本論文の位置づけ" },
    labels: ["paper_positioning"],
    habitat: "mixed",
    realEscape:
      "本ブロックは位置づけの宣言であり、実数の側という言い方が寄与 (a) と (d) に現れるだけである。" +
      "ℝ の元を構成したり ℝ 上の議論をしたりはしていない。" +
      "本論文が実際に ℝ を使うのは第 3 章の L → ∞ の極限ただ一点である。",
    statement: [
      paragraph([
        "本論文は既知数学の再框（reframe）である。新しい定理・新しい厳密解・新しい深い数論を",
        "一切主張しない。扱う数学的内容はすべて既知であり、出典を第 3 章と第 5 章で文献名・",
        "命題番号つきに特定する。",
      ]),
      paragraph([
        "本論文が与えるのは次の 4 点だけである。用語と記号は第 1–3 章で順に定める。",
      ]),
      list([
        [
          "(a) 二つの素点の辞書: 同一の整数係数多項式 ",
          math(String.raw`P`),
          " について、実数の側で定まる量と、各素数 ",
          math(String.raw`p`),
          " での付値の側で定まる量を並置し、統計力学の量へ対応づける明示的な辞書。",
        ],
        [
          "(b) 可算化の精密化: 付値の側が非可算な体 ",
          math(String.raw`\mathbb{Q}_p`),
          " を必要としないことの精密化。",
        ],
        [
          "(c) 判定できる命題群の確定: 付値の側の有限・初等な顔を、",
          "有限回の計算で答えの出る手続きと、答えを裏づける具体的な証拠をもつ命題として確定する",
          "（第 4 章の命題 A・B・C・N・L と、第 6 章の命題 T・V・W）。",
        ],
        [
          "(d) 難しさの非対称の地図: 実数の側に固有の未解決問題（Lehmer 問題）があり、",
          "付値の側には対応する連続的なギャップが存在しないことの整理（第 7 章）。",
        ],
      ]),
      paragraph([
        "(a)–(d) はいずれも既知定理の配置・言い換え・可算化であって、数学的な新規性ではない。",
        "本論文の主張のうち一部は Lean 4 + mathlib4 で形式化し、",
        math(String.raw`\mathrm{sorry}`),
        " ゼロを機械確認した（第 8 章）。",
      ]),
    ],
  },
  {
    id: "paper_012_definition_ladder",
    kind: "definition",
    origin: { path: "structured-latex/content/001_intro.ts", ordinal: 3 },
    title: { text: "決定可能性の梯子" },
    labels: ["paper_def_ladder"],
    habitat: "mixed",
    realEscape:
      "本定義は梯子の最上段として ℝ/ℂ を含む。ℝ/ℂ は「決定不能な段」として名指すためだけに現れ、" +
      "本論文の主張が ℝ を実際に使うのは、第 3 章のアルキメデス側の極限（L → ∞）ただ一点である。",
    statement: [
      paragraph([
        "本論文で用いる集合の階層を次のように定める。",
      ]),
      displayMath(
        String.raw`\underbrace{\mathbb{N}\subset\mathbb{Z}\subset\mathbb{Q}\subset\Lambda\subset\overline{\mathbb{Q}}}_{\text{無条件に決定可能}}
\ \subset\ \underbrace{\overline{\mathbb{Q}}(\ell_p)\ \text{の非線形部}}_{\text{Schanuel 条件付き}}
\ \subset\ \underbrace{\mathbb{R}/\mathbb{C}}_{\text{決定不能}}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`\Lambda=\bigoplus_{p}\mathbb{Z}\,\ell_p`),
        " は素数を添字とする自由アーベル群（対数順序群）で、",
        math(String.raw`\ell_p`),
        " は形式的な記号である。正の有理数 ",
        math(String.raw`q=\prod_p p^{e_p}`),
        " に対し ",
        math(String.raw`\log q:=\sum_p e_p\,\ell_p\in\Lambda`),
        " と定める。",
      ]),
      paragraph([
        math(String.raw`\Lambda`),
        " での等号は素因数分解の一致、順序は指数ベクトルの整数比較であり、どちらも有限手続きで",
        "決定できる。",
        math(String.raw`\overline{\mathbb{Q}}`),
        " での等号・順序は最小多項式と根の分離で決定できる。",
        "いずれも ",
        math(String.raw`\mathbb{R}`),
        " を経由しない。",
      ]),
      paragraph([
        "本論文が ",
        math(String.raw`\mathbb{R}`),
        " を使うのは第 3 章の一点に限られる。それ以外の主張はすべて上の可算側で閉じる。",
      ]),
    ],
  },
  {
    id: "paper_013_remark_four_axes",
    kind: "remark",
    origin: { path: "structured-latex/content/001_intro.ts", ordinal: 4 },
    title: { text: "四軸（帰属・計算可能性・複雑性・可解性）と、混同してはならないこと" },
    labels: ["paper_four_axes"],
    habitat: "none",
    statement: [
      paragraph([
        ref("paper_def_ladder"),
        " の梯子は次の 4 つの軸のうち第 1 軸だけを扱う。混同を避けるため明示する。",
      ]),
      list([
        ["軸 1（帰属）: 対象量がどの集合に住むか。有限・離散なら可算側に住む。"],
        ["軸 2（計算可能性）: 有限・離散なら常に計算可能（数え上げで終わる）。模型を区別しない自明な軸。"],
        ["軸 3（複雑性）: 有限サイズで多項式時間か #P 困難か。"],
        ["軸 4（可解性）: 熱力学極限に閉形式があるか。軸 3 とは独立で、双対・Yang–Baxter・自由フェルミオンなど別の構造から来る。"],
      ]),
      paragraph([
        "軸 1・2 は軸 4 を何も含意しない。 有限サイズの量が可算側に住み決定可能であることは、",
        "極限が閉形式をもつことを一切示さない。本論文は軸 1（と軸 2 の一部）についての論文であり、",
        "可解性については何も主張しない。",
      ]),
    ],
  },
]);
