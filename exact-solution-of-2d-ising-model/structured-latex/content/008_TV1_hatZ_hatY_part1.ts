import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

// 章「T_{V_1}(hat Z) と hat Z, hat Y の関係」の前半（文書順）。
// 収録範囲は parts/008 の 000〜017, 036, 018, 019（文書順はソースのファイル名連番と
// 一致しないため、ファイル名に連番範囲は入れない）。並びが文書順の正準表現。
export default defineBlocks([
  {
    id: "heading_TV1_hatZ_hatY",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 10 },
    title: { tex: String.raw`\sinh,\cosh\text{ のテイラー展開、可逆行列と共役写像 } T_g` },
    labels: [],
  },
  {
    id: "TV1_hatZ_hatY_004_claim_sinh_cosh_taylor",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/003_claim_sinh_coshのテイラー展開.typ",
      ordinal: 4,
    },
    title: { tex: String.raw`\sinh, \cosh \text{ のテイラー展開}` },
    labels: ["sinh_cosh_taylor_series"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " とする。双曲線正弦と双曲線余弦は ",
        ref("def_cosh_sinh"),
        " の定義による。",
      ]),
      displayMath(
        String.raw`\sinh x = \sum_{\substack{n \geq 1 \\ n \text{ 奇数}}} \frac{x^n}{n!}, \qquad
\cosh x = \sum_{\substack{n \geq 0 \\ n \text{ 偶数}}} \frac{x^n}{n!}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_009_definition_invertible_elements",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/008_definition_環の乗法群.typ",
      ordinal: 9,
    },
    title: { tex: String.raw`\mathrm{Mat}(2^M,\mathbb{C}) \text{ の可逆元}` },
    labels: ["def_invertible_elements_of_R"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とする。行列の積は ",
        ref("mat_mult"),
        "、行列のスカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、複素係数の演算は ",
        ref("complex_numbers_form_a_field"),
        " による。",
      ]),
      paragraph([
        math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`),
        " と書き、",
        ref("def_identity_matrix"),
        " の単位行列を ",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " と書く。",
        math(String.raw`g \in R`),
        " が可逆であるとは、",
      ]),
      displayMath(String.raw`\exists h \in R,\quad g\,h = I \ \text{ かつ } \ h\,g = I`),
      paragraph([
        "が成り立つことをいう。可逆な元全体の集合を",
      ]),
      displayMath(
        String.raw`R^\times := \{\, g \in R \mid g \text{ は可逆} \,\}`,
      ),
      paragraph([
        "と書く。",
        math(String.raw`g \in R^\times`),
        " に対して上の ",
        math(String.raw`h`),
        " はただ 1 つに定まり、これを ",
        math(String.raw`g^{-1}`),
        " と書く。さらに次が成り立つ。",
      ]),
      list([
        ["(i) ", math(String.raw`I \in R^\times`), " であり ", math(String.raw`I^{-1} = I`), "。"],
        [
          "(ii) ",
          math(String.raw`g_1, g_2 \in R^\times`),
          " なら ",
          math(String.raw`g_1 g_2 \in R^\times`),
          " であり ",
          math(String.raw`(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}`),
          "。",
        ],
        [
          "(iii) ",
          math(String.raw`g \in R^\times`),
          " なら ",
          math(String.raw`g^{-1} \in R^\times`),
          " であり ",
          math(String.raw`(g^{-1})^{-1} = g`),
          "。",
        ],
        [
          "(iv) ",
          math(String.raw`c \in \mathbb{C}\setminus\{0\}`),
          " なら ",
          math(String.raw`c\,I \in R^\times`),
          " であり ",
          math(String.raw`(cI)^{-1} = c^{-1}I`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "（逆元の一意性）",
        math(String.raw`h_1, h_2 \in R`),
        " がともに ",
        math(String.raw`g h_1 = h_1 g = I`),
        "、",
        math(String.raw`g h_2 = h_2 g = I`),
        " を満たすとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
h_1
&= h_1 I
&&(\because\ \text{単位行列を右から掛けても変わらない }\blkref{identity_matrix_is_right_unit_of_mat_mult})\\
&= h_1 (g h_2)
&&(\because\ g h_2 = I\ \text{の代入})\\
&= (h_1 g) h_2
&&(\because\ \text{行列の積の結合律 }\blkref{mat_mult_associative})\\
&= I h_2
&&(\because\ h_1 g = I\ \text{の代入})\\
&= h_2
&&(\because\ \text{単位行列を左から掛けても変わらない }\blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`,
      ),
      paragraph(["であるから、逆元はただ 1 つである。"]),
      paragraph([
        "(i) ",
        math(String.raw`I\,I = I`),
        "（",
        ref("identity_matrix_is_left_unit_of_mat_mult"),
        " を ",
        math(String.raw`A = I`),
        " に適用）より、",
        math(String.raw`h = I`),
        " が ",
        math(String.raw`I`),
        " に対する逆元の条件 ",
        math(String.raw`I\,h = h\,I = I`),
        " を満たす。よって ",
        math(String.raw`I \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`I^{-1} = I`),
        "。",
      ]),
      paragraph([
        "(ii) ",
        math(String.raw`h := g_2^{-1}g_1^{-1}`),
        " とおくと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(g_1g_2)h
&= (g_1g_2)(g_2^{-1}g_1^{-1})
&&(\because\ h = g_2^{-1}g_1^{-1}\ \text{の代入})\\
&= \bigl((g_1g_2)g_2^{-1}\bigr)g_1^{-1}
&&(\because\ \text{行列の積の結合律 }\blkref{mat_mult_associative})\\
&= \bigl(g_1(g_2g_2^{-1})\bigr)g_1^{-1}
&&(\because\ \text{行列の積の結合律 }\blkref{mat_mult_associative})\\
&= (g_1 I) g_1^{-1}
&&(\because\ g_2 g_2^{-1} = I)\\
&= g_1g_1^{-1}
&&(\because\ \text{単位行列を右から掛けても変わらない }\blkref{identity_matrix_is_right_unit_of_mat_mult})\\
&= I
&&(\because\ g_1 g_1^{-1} = I)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
h(g_1g_2)
&= (g_2^{-1}g_1^{-1})(g_1g_2)
&&(\because\ h = g_2^{-1}g_1^{-1}\ \text{の代入})\\
&= \bigl((g_2^{-1}g_1^{-1})g_1\bigr)g_2
&&(\because\ \text{行列の積の結合律 }\blkref{mat_mult_associative})\\
&= \bigl(g_2^{-1}(g_1^{-1}g_1)\bigr)g_2
&&(\because\ \text{行列の積の結合律 }\blkref{mat_mult_associative})\\
&= (g_2^{-1} I) g_2
&&(\because\ g_1^{-1} g_1 = I)\\
&= g_2^{-1}g_2
&&(\because\ \text{単位行列を右から掛けても変わらない }\blkref{identity_matrix_is_right_unit_of_mat_mult})\\
&= I
&&(\because\ g_2^{-1} g_2 = I)
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`g_1g_2 \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}`),
        "。",
      ]),
      paragraph([
        "(iii) ",
        math(String.raw`g g^{-1} = g^{-1} g = I`),
        " は、",
        math(String.raw`g^{-1}`),
        " に対して ",
        math(String.raw`g`),
        " が逆元の条件を満たすことをそのまま述べている。よって ",
        math(String.raw`g^{-1} \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(g^{-1})^{-1} = g`),
        "。",
      ]),
      paragraph([
        "(iv) ",
        math(String.raw`c \neq 0`),
        " より、",
        ref("complex_numbers_form_a_field"),
        " の乗法の逆元 ",
        math(String.raw`c^{-1} \in \mathbb{C}`),
        " があり、",
        math(String.raw`c\,c^{-1} = c^{-1}c = 1`),
        " である。次の 2 つの一続きの変形による。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(cI)(c^{-1}I)
&= c\bigl(I(c^{-1}I)\bigr)
&&(\because\ (aA)B = a(AB)\ \blkref{scalar_multiple_factors_out_of_left_factor})\\
&= c\bigl(c^{-1}(I\,I)\bigr)
&&(\because\ A(aB) = a(AB)\ \blkref{scalar_multiple_factors_out_of_right_factor})\\
&= (c\,c^{-1})(I\,I)
&&(\because\ a(bA) = (ab)A\ \blkref{scalar_multiple_is_associative})\\
&= (c\,c^{-1})I
&&(\because\ \text{単位行列を左から掛けても変わらない }\blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ A = I\ \text{に適用})\\
&= 1\,I
&&(\because\ c\,c^{-1} = 1)\\
&= I
&&(\because\ 1A = A\ \blkref{scalar_multiple_by_one})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(c^{-1}I)(cI)
&= c^{-1}\bigl(I(cI)\bigr)
&&(\because\ (aA)B = a(AB)\ \blkref{scalar_multiple_factors_out_of_left_factor})\\
&= c^{-1}\bigl(c(I\,I)\bigr)
&&(\because\ A(aB) = a(AB)\ \blkref{scalar_multiple_factors_out_of_right_factor})\\
&= (c^{-1}c)(I\,I)
&&(\because\ a(bA) = (ab)A\ \blkref{scalar_multiple_is_associative})\\
&= (c^{-1}c)I
&&(\because\ \text{単位行列を左から掛けても変わらない }\blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ A = I\ \text{に適用})\\
&= 1\,I
&&(\because\ c^{-1}c = 1)\\
&= I
&&(\because\ 1A = A\ \blkref{scalar_multiple_by_one})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`cI \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(cI)^{-1} = c^{-1}I`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文（parts/008/008）は「環 R の乗法群 R^×」という一般の環についての定義だった。README 2 節「環・体などの一般論に持ち上げた証明は使わない」・3 節 2「脇道の一般論なら具体的な形に落として本文に書く」に従い、Mat(2,C)^{⊗M} の可逆元についての具体的な定義へ書き換え、以降の証明で実際に使う性質（逆元の一意性、単位元・積・逆元・スカラー倍についての可逆性）だけを主張として立てた。一般の環についての元の記述は notes/008_group_theory_general.ts へ移した。",
        "2026-11-01: SageMath の検算（sagemath/check/def_invertible_elements_of_R/）に合わせて根拠を直した。単位行列との積・行列の積の結合律・スカラー倍の性質を述べるブロックが本文に無かったので、" +
          "def_kronecker_delta・def_identity_matrix・def_matrix_scalar_multiple・mat_mult_associative・identity_matrix_is_left_unit_of_mat_mult・identity_matrix_is_right_unit_of_mat_mult・scalar_multiple_factors_out_of_left_factor・scalar_multiple_factors_out_of_right_factor・scalar_multiple_is_associative・scalar_multiple_by_one（と complex_zero_times_is_zero） を足し、各行から引いた。" +
          "(ii) の鎖は結合律を 2 回使うので 2 行に分けた。(i) の I I = I に根拠を付けた。(iv) は旧証明が scalar_identity_commutes（[cI, A] = 0）を引いていたが、鎖は交換子を使わないので、スカラー倍の性質を一つずつ引く 6 行の鎖に書き直した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_011_definition_T_g",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/010_definition_T_g.typ",
      ordinal: 11,
    },
    title: { tex: String.raw`T_g \text{ の定義}` },
    labels: ["def_T_g"],
    statement: [
      paragraph([
        ref("def_invertible_elements_of_R"),
        " の記号を使い、",
        math(String.raw`g \in (\mathrm{Mat}(2^M,\mathbb{C}))^\times`),
        " について、",
      ]),
      displayMath(
        String.raw`T_g : \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{Mat}(2^M,\mathbb{C}), \quad h \mapsto g \cdot h \cdot g^{-1}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_015_claim_linearity_of_T",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/014_claim_T_Vの線型性.typ",
      ordinal: 15,
    },
    title: { tex: String.raw`T_g \text{ の } \mathbb{C} \text{ 線型性}` },
    labels: ["linearity_of_T"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`M\in\mathbb{N}_{>0}`),
        " をとる。",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`R:=\mathrm{Mat}(2^M,\mathbb{C})`),
        " と ",
        math(String.raw`R^\times`),
        " を用いる。任意の ",
        math(String.raw`g\in R^\times`),
        "、",
        math(String.raw`a,b\in\mathbb{C}`),
        "、",
        math(String.raw`X,W\in R`),
        " について、",
      ]),
      displayMath(
        String.raw`T_g(aX+bW)=a\,T_g(X)+b\,T_g(W)`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_T_g"),
        " の定義を用い、行列積の左右の分配と、複素スカラー倍と行列積の両立を一回ずつ適用する。",
      ]),
      displayMath(String.raw`\begin{aligned}
T_g(aX+bW)
&=g(aX+bW)g^{-1}
&&\left(\because\ \blkref{def_T_g}\right)\\
&=\bigl(g(aX)+g(bW)\bigr)g^{-1}
&&\left(\because\ \text{左からの行列積の分配法則}\right)\\
&=g(aX)g^{-1}+g(bW)g^{-1}
&&\left(\because\ \text{右からの行列積の分配法則}\right)\\
&=a(gX)g^{-1}+b(gW)g^{-1}
&&\left(\because\ \text{左からの行列積と複素スカラー倍の両立}\right)\\
&=a(gXg^{-1})+b(gWg^{-1})
&&\left(\because\ \text{右からの行列積と複素スカラー倍の両立}\right)\\
&=a\,T_g(X)+b\,T_g(W)
&&\left(\because\ \blkref{def_T_g}\right).
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-09-02 の論文構成再編で、二つの転送行列に限った未証明の記述から、任意の可逆な有限複素行列による共役写像の線型性へ立て直した。イジング固有の特殊化は 014_even_sector_T_action.ts 側へ分離した。",
      ],
    },
  },
]);
