import { defineNotes, paragraph, math, displayMath, list, ref } from "../schema.ts";
import type { Label } from "../schema.ts";

// どの章のゴールの主張からも使われない主張（本文不採用）。文書本体ではない。
//
// 2026-10-31 の章立ての組み直しで、各章のゴールの主張から依存を辿ってもどの章にも入らなかった項のうち、
// 本文のどこからも使われていない 5 項である。内容はそのまま運び、退避したラベルへの参照は
// 〔ラベル〕という文字列に置き換えてある。
//
// **本文には採用しなかった。** 理由: 本文の到達点（各章のゴールの主張）の証明は、どれもこれらを引かない。
// - F^{(+)} の複素部分線型空間性を言い直した主張（def_eigenspaces_of_epsilon）: 本文は言い直す前の
//   even_eigenspace_is_complex_subspace を直接引くので、言い直しを経る必要がない。
// - ε の固有値が ±1 に限ること: 本文が要るのは ε^2 = I（epsilon_square_identity）と、Q̌_ε についての
//   ε の固有値の計算で、その計算は ε^2 = I から直接行う。
// - H_1^{(+)}, H_2 を Ž, Y̌ で書く式: V^{(+)} の指数表示は共役写像の作用の比較で導き、
//   H_1^{(+)}, H_2 そのものを Ž, Y̌ で書き直す必要がない。
// - (V^{(+)})^{-1} の正定値性と tr((V^{(+)})^{-1}) の正値性: V^{(+)} の固有値と最大固有値の決定に使わない。

const NOT_ADOPTED = paragraph<Label>([
  "【本文不採用。理由: 本文のどの章のゴールの主張の証明もこの主張を引かず、本文のどこからも使われないため。】",
]);

export default defineNotes([
  {
    id: "note_transfer_matrix_004_definition_eigenspaces_of_epsilon_unused_by_chapter_goals",
    targets: ["def_even_eigenvectors_of_epsilon"],
    title: { tex: String.raw`\varepsilon\text{ の固有値 }+1\text{ の固有ベクトル集合は複素部分線型空間である}` },
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の主張ブロック transfer_matrix_004_definition_eigenspaces_of_epsilon。labels: def_eigenspaces_of_epsilon。以下は本文にあったときの内容のまま。）"]),
      paragraph([
        ref("def_even_eigenvectors_of_epsilon"),
        " で定めた ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " は ",
        math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-部分線型空間である（",
        math(String.raw`\because`),
        " ",
        ref("even_eigenspace_is_complex_subspace"),
        "）。",
      ]),
    ],
  },
  {
    id: "note_transfer_matrix_004c_claim_epsilon_action_eigenvalues_unused_by_chapter_goals",
    targets: ["epsilon_square_identity"],
    title: { tex: String.raw`\varepsilon\text{ の行列作用の固有値候補}` },
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の主張ブロック transfer_matrix_004c_claim_epsilon_action_eigenvalues。labels: epsilon_action_eigenvalues_are_signs。以下は本文にあったときの内容のまま。）"]),
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を考える。非零ベクトル ",
        math(String.raw`f\in\mathbb{C}^{2^{M_{\mathrm{col}}}}\setminus\{0\}`),
        " と複素数 ",
        math(String.raw`\lambda\in\mathbb{C}`),
        " が ",
        math(String.raw`\varepsilon f=\lambda f`),
        " を満たすなら、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`1`),
        " または ",
        math(String.raw`-1`),
        " に限る。",
      ]),
      paragraph(["証明."]),
      paragraph([
        ref("epsilon_square_identity"),
        "、行列と数ベクトルの積の結合則 ",
        ref("mat_mult"),
        "、および複素数の体の法則 ",
        ref("complex_numbers_form_a_field"),
        " を用いる。まず、この証明で使う行列作用の結合則を成分から確かめる。任意の ",
        math(String.raw`A,B\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        math(String.raw`g\in\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`i\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
((AB)g)_i
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}(AB)_{ik}g_k
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\left(\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}A_{i\ell}B_{\ell k}\right)g_k
&&(\because\ \blkref{mat_mult}\ \text{の行列積の成分の定義})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}(A_{i\ell}B_{\ell k})g_k
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を有限回適用})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}A_{i\ell}(B_{\ell k}g_k)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&=\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}\sum_{k=1}^{2^{M_{\mathrm{col}}}}A_{i\ell}(B_{\ell k}g_k)
&&(\because\ \text{有限二重和の順序交換})\\
&=\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}A_{i\ell}\left(\sum_{k=1}^{2^{M_{\mathrm{col}}}}B_{\ell k}g_k\right)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を有限回適用})\\
&=(A(Bg))_i
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義}).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`(AB)g=A(Bg)`),
        " である。同様に、任意の ",
        math(String.raw`\mu\in\mathbb{C}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(A(\mu g))_i
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}A_{ik}(\mu g_k)
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}(A_{ik}\mu)g_k
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}(\mu A_{ik})g_k
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の交換律})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\mu(A_{ik}g_k)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&=\mu\sum_{k=1}^{2^{M_{\mathrm{col}}}}A_{ik}g_k
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を有限回適用})\\
&=(\mu(Ag))_i
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義}).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`A(\mu g)=\mu(Ag)`),
        " である。また、単位行列の作用も成分から確かめると、任意の ",
        math(String.raw`i\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}f)_i
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}(I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})})_{ik}f_k
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義})\\
&=f_i
&&(\because\ \text{単位行列の成分と }\blkref{complex_numbers_form_a_field}\ \text{の }0,1\text{ の法則}).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}f=f`),
        " である。以上の三つの等式と仮定 ",
        math(String.raw`\varepsilon f=\lambda f`),
        " を二回適用すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
f
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}f
&&(\because\ \text{直前に成分ごとに示した単位行列の作用})\\
&=\varepsilon^2f
&&(\because\ \blkref{epsilon_square_identity})\\
&=\varepsilon(\varepsilon f)
&&(\because\ \blkref{mat_mult},\blkref{complex_numbers_form_a_field}\ \text{から直前に成分ごとに示した結合則})\\
&=\varepsilon(\lambda f)
&&(\because\ \varepsilon f=\lambda f)\\
&=\lambda(\varepsilon f)
&&(\because\ \blkref{mat_mult},\blkref{complex_numbers_form_a_field}\ \text{から直前に成分ごとに示した複素線型性})\\
&=\lambda(\lambda f)
&&(\because\ \varepsilon f=\lambda f)\\
&=(\lambda\lambda)f
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合則})\\
&=\lambda^2f
&&(\because\ \lambda^2=\lambda\lambda\ \text{という二乗の定義}).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`f\neq 0`),
        " だから、ある ",
        math(String.raw`j\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について ",
        math(String.raw`f_j\neq 0`),
        " である。等式 ",
        math(String.raw`f=\lambda^2f`),
        " の第 ",
        math(String.raw`j`),
        " 成分を比べると ",
        math(String.raw`f_j=\lambda^2f_j`),
        " だから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lambda^2f_j-f_j&=0
&&(\because\ f_j=\lambda^2f_j\ \text{の両辺から }f_j\text{ を引く})\\
(\lambda^2-1)f_j&=\lambda^2f_j-1f_j
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&=\lambda^2f_j-f_j
&&(\because\ 1f_j=f_j)\\
&=0
&&(\because\ \lambda^2f_j-f_j=0)\\
\lambda^2-1&=0
&&(\because\ f_j\neq0\ \text{と }\blkref{complex_numbers_form_a_field}\ \text{の零積則})\\
(\lambda-1)(\lambda+1)&=\lambda^2-1
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&=0
&&(\because\ \lambda^2-1=0)\\
\lambda-1=0\quad\text{または}\quad\lambda+1&=0
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零積則})\\
\lambda=1\quad\text{または}\quad\lambda&=-1
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法}).
\end{aligned}`,
      ),
    ],
  },
  {
    id: "note_evensector_007_claim_H1_H2_via_check_Z_Y_unused_by_chapter_goals",
    targets: ["def_H1_plus", "def_H2"],
    title: { tex: String.raw`H_1^{(+)}, H_2 \text{ を } \check{Z}, \check{Y} \text{ で表す}` },
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 1 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/013_even_sector_modes.ts の主張ブロック evensector_007_claim_H1_H2_via_check_Z_Y。labels: H1_H2_via_check_Z_Y。以下は本文にあったときの内容のまま。）"]),
      displayMath(
        String.raw`H_1^{(+)} = \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \check{Y}_\mu\,\check{Z}_{M_{\mathrm{col}}+1-\mu}\,\exp(-i\tilde\theta_\mu),
\qquad
H_2 = \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \check{Z}_{M_{\mathrm{col}}+1-\mu}\,\check{Y}_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`H_1^{(+)}`),
        " は ",
        ref("def_H1_plus"),
        " のもの、",
        math(String.raw`H_2`),
        " は ",
        ref("def_H2"),
        " のもの）。和の添字 ",
        math(String.raw`\mu`),
        " も共役添字 ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " も ",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中にとどまる。",
      ]),
      paragraph(["証明."]),
      paragraph([
        "まず ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("conjugate_index_of_check_Z_Y"),
        " (2) から ",
        math(String.raw`\check{Z}_{M_{\mathrm{col}}+1-\mu}`),
        " の表示を用意する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{M_{\mathrm{col}}+1-\mu}
&= \sum_{k=1}^{M_{\mathrm{col}}} Z_k\,\exp(-ik\tilde\theta_{M_{\mathrm{col}}+1-\mu})
&& (\because \blkref{def_half_integer_checkZ}) \\
&= \sum_{k=1}^{M_{\mathrm{col}}} Z_k\,\exp(ik\tilde\theta_\mu)
&& (\because \blkref{conjugate_index_of_check_Z_Y}\text{ (2)})
\end{aligned}`,
      ),
      paragraph([
        "次に ",
        math(String.raw`1 \leq j,k \leq M_{\mathrm{col}}`),
        " より ",
        math(String.raw`|k-j| < M_{\mathrm{col}}`),
        " なので、",
        ref("antiperiodic_exp_sum"),
        " より内側の和は ",
        math(String.raw`k = j`),
        " のとき ",
        math(String.raw`M_{\mathrm{col}}`),
        "、そうでないとき ",
        math(String.raw`0`),
        " である。これと ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("def_H2"),
        " を順に使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Z}_{M_{\mathrm{col}}+1-\mu}\check{Y}_\mu
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\left(\sum_{k=1}^{M_{\mathrm{col}}}Z_k \exp(ik\tilde\theta_\mu)\right)
   \left(\sum_{j=1}^{M_{\mathrm{col}}}Y_j \exp(-ij\tilde\theta_\mu)\right)
&& (\because \text{準備した }\check Z_{M_{\mathrm{col}}+1-\mu}\text{ の表示と }\blkref{def_half_integer_checkY}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}} Z_kY_j\,
   \exp(ik\tilde\theta_\mu)\exp(-ij\tilde\theta_\mu)
&& (\because \text{積を二重和へ分配}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}} Z_kY_j\,
   \exp(i(k-j)\tilde\theta_\mu)
&& (\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}} Z_kY_j
   \sum_{\mu=1}^{M_{\mathrm{col}}} \exp(i(k-j)\tilde\theta_\mu)
&& (\because \text{有限和の順序交換}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}} Z_jY_j\cdot M_{\mathrm{col}}
&& (\because \blkref{antiperiodic_exp_sum}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} Z_jY_j
&& (\because \text{スカラー } \tfrac{1}{M_{\mathrm{col}}} \text{ と } M_{\mathrm{col}} \text{ の相殺}) \\
&= H_2
&& (\because \blkref{def_H2})
\end{aligned}`,
      ),
      paragraph([
        "もう一方の式の準備として、",
        math(String.raw`1 \leq j,k \leq M_{\mathrm{col}}`),
        " より ",
        math(String.raw`j-k+1`),
        " は ",
        math(String.raw`2-M_{\mathrm{col}}`),
        " 以上 ",
        math(String.raw`M_{\mathrm{col}}`),
        " 以下である。",
        ref("antiperiodic_exp_sum"),
        " より、内側の和が ",
        math(String.raw`0`),
        " でないのは ",
        math(String.raw`j-k+1 = lM_{\mathrm{col}}`),
        " のときに限り、この範囲では ",
        math(String.raw`l = 0`),
        " と ",
        math(String.raw`l = 1`),
        " だけが可能である。",
      ]),
      list([
        [
          math(String.raw`l = 0`),
          "、すなわち ",
          math(String.raw`k = j+1`),
          "（",
          math(String.raw`k \leq M_{\mathrm{col}}`),
          " より ",
          math(String.raw`1 \leq j \leq M_{\mathrm{col}}-1`),
          "）。このとき内側の和は ",
          math(String.raw`M_{\mathrm{col}}(-1)^0 = M_{\mathrm{col}}`),
          "。",
        ],
        [
          math(String.raw`l = 1`),
          "、すなわち ",
          math(String.raw`j-k+1 = M_{\mathrm{col}}`),
          "。",
          math(String.raw`1\leq j,k\leq M_{\mathrm{col}}`),
          " でこれを満たすのは ",
          math(String.raw`j = M_{\mathrm{col}},\ k = 1`),
          " のみ。このとき内側の和は ",
          math(String.raw`M_{\mathrm{col}}(-1)^1 = -M_{\mathrm{col}}`),
          "。",
        ],
      ]),
      paragraph([
        "したがって、",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("def_H1_plus"),
        " を順に使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Y}_\mu\check{Z}_{M_{\mathrm{col}}+1-\mu}\exp(-i\tilde\theta_\mu)
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\left(\sum_{j=1}^{M_{\mathrm{col}}}Y_j \exp(-ij\tilde\theta_\mu)\right)
   \left(\sum_{k=1}^{M_{\mathrm{col}}}Z_k \exp(ik\tilde\theta_\mu)\right) \exp(-i\tilde\theta_\mu)
&& (\because \blkref{def_half_integer_checkY}\text{ と準備した } \check{Z}_{M_{\mathrm{col}}+1-\mu} \text{ の表示}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_jZ_k\,
   \exp(-ij\tilde\theta_\mu)\exp(ik\tilde\theta_\mu)\exp(-i\tilde\theta_\mu)
&& (\because \text{積を二重和へ分配}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_jZ_k\,
   \exp(-i(j-k+1)\tilde\theta_\mu)
&& (\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_jZ_k
   \sum_{\mu=1}^{M_{\mathrm{col}}} \exp(-i(j-k+1)\tilde\theta_\mu)
&& (\because \text{有限和の順序交換}) \\
&= \frac{1}{M_{\mathrm{col}}}\left(\sum_{j=1}^{M_{\mathrm{col}}-1} Y_jZ_{j+1}\cdot M_{\mathrm{col}} + Y_{M_{\mathrm{col}}}Z_1\cdot(-M_{\mathrm{col}})\right)
&& (\because \blkref{antiperiodic_exp_sum}\text{ と直上の 2 つの場合分け}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}-1} Y_jZ_{j+1} - Y_{M_{\mathrm{col}}}Z_1
&& (\because \text{スカラー } \tfrac{1}{M_{\mathrm{col}}} \text{ の分配と } \tfrac{1}{M_{\mathrm{col}}}\cdot M_{\mathrm{col}} = 1,\ \tfrac{1}{M_{\mathrm{col}}}\cdot(-M_{\mathrm{col}}) = -1 \text{ の相殺}) \\
&= H_1^{(+)}
&& (\because \blkref{def_H1_plus})
\end{aligned}`,
      ),
    ],
  },
  {
    id: "note_evenEigen_claim_V_plus_inverse_is_positive_definite_unused_by_chapter_goals",
    targets: ["def_V_plus"],
    title: {
      tex: String.raw`\left(V^{(+)}\right)^{-1}\text{ は正定値}`,
    },
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 1 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/017_even_sector_eigenvalues.ts の主張ブロック evenEigen_claim_V_plus_inverse_is_positive_definite。labels: V_plus_inverse_is_positive_definite。以下は本文にあったときの内容のまま。）"]),
      paragraph([
        ref("V_plus_is_invertible"),
        " で明示した ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        " は正定値（",
        ref("def_hermitian_positive_definite"),
        " の意味）である。",
      ]),
      paragraph(["証明."]),
      paragraph([
        ref("iH_is_real_symmetric"),
        " より ",
        math(String.raw`-\tfrac12S_1^{(+)}`),
        " と ",
        math(String.raw`-S_2`),
        " は実対称、したがってエルミートである。",
        ref("exp_hermitian_is_positive_definite"),
        " (1) より",
      ]),
      list([
        [
          math(String.raw`B_- := \exp(-\tfrac12S_1^{(+)})`),
          " はエルミートかつ正定値",
        ],
        [math(String.raw`A_- := \exp(-S_2)`), " は正定値"],
      ]),
      paragraph([
        math(String.raw`C_-:=\exp(\tfrac12S_1^{(+)})`),
        " と置く。二つの指数の中の行列は、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-\tfrac12S_1^{(+)})(\tfrac12S_1^{(+)})
&= -\tfrac14(S_1^{(+)})^2
   \quad (\because \text{スカラー倍と行列積の結合則}) \\
&= (\tfrac12S_1^{(+)})(-\tfrac12S_1^{(+)})
   \quad (\because \text{スカラーの積は可換})
\end{aligned}`,
      ),
      paragraph([
        "のように可換である。したがって ",
        ref("theorem_exp_product"),
        " と ",
        ref("theorem_exp_zero"),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
B_-C_-
&= \exp(-\tfrac12S_1^{(+)})\exp(\tfrac12S_1^{(+)})
   \quad (\because B_-,\ C_- \text{ の定義}) \\
&= \exp\!\left((-\tfrac12S_1^{(+)})+(\tfrac12S_1^{(+)})\right)
   \quad (\because \text{可換な行列の指数関数の積公式}) \\
&= \exp(0)
   \quad (\because (-\tfrac12+\tfrac12)S_1^{(+)}=0) \\
&= I
   \quad (\because \exp(0)=I), \\
C_-B_-
&= \exp(\tfrac12S_1^{(+)})\exp(-\tfrac12S_1^{(+)})
   \quad (\because C_-,\ B_- \text{ の定義}) \\
&= \exp\!\left((\tfrac12S_1^{(+)})+(-\tfrac12S_1^{(+)})\right)
   \quad (\because \text{可換な行列の指数関数の積公式}) \\
&= \exp(0)
   \quad (\because (\tfrac12-\tfrac12)S_1^{(+)}=0) \\
&= I
   \quad (\because \exp(0)=I).
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`B_-`),
        " は可逆であり、その逆行列は ",
        math(String.raw`C_-`),
        " である。",
      ]),
      paragraph([
        math(String.raw`B_-`),
        " がエルミートなので ",
        math(String.raw`B_-^*=B_-`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-\tfrac12S_1^{(+)})\exp(-S_2)\exp(-\tfrac12S_1^{(+)})
&= B_-A_-B_-
   \quad (\because B_-,\ A_- \text{ の定義}) \\
&= B_-^*A_-B_-
   \quad (\because B_-^*=B_-)
\end{aligned}`,
      ),
      paragraph([
        ref("exp_hermitian_is_positive_definite"),
        " (2) より ",
        math(String.raw`B_-^*A_-B_-`),
        " は正定値である。",
        math(String.raw`s_2>0`),
        " より ",
        math(String.raw`(2s_2)^{-M_{\mathrm{col}}/2}>0`),
        " であるから、同 (3) より ",
        math(String.raw`(2s_2)^{-M_{\mathrm{col}}/2}B_-^*A_-B_-`),
        " は正定値である。",
      ]),
      paragraph([
        ref("V_plus_is_invertible"),
        " の明示式と ",
        math(String.raw`B_-^*=B_-`),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(V^{(+)}\right)^{-1}
&= (2s_2)^{-M_{\mathrm{col}}/2}\exp(-\tfrac12S_1^{(+)})\exp(-S_2)\exp(-\tfrac12S_1^{(+)})
   \quad (\because \text{逆行列の明示式}) \\
&= (2s_2)^{-M_{\mathrm{col}}/2}B_-A_-B_-
   \quad (\because B_-,\ A_- \text{ の定義}) \\
&= (2s_2)^{-M_{\mathrm{col}}/2}B_-^*A_-B_-
   \quad (\because B_-^*=B_-).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        " も正定値である。",
      ]),
    ],
  },
  {
    id: "note_evenEigen_claim_V_plus_inverse_positive_and_traces_unused_by_chapter_goals",
    targets: ["def_V_plus"],
    title: {
      tex: String.raw`\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)\text{ は正}`,
    },
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 1 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/017_even_sector_eigenvalues.ts の主張ブロック evenEigen_claim_V_plus_inverse_positive_and_traces。labels: V_plus_inverse_positive_and_trace_positivity。以下は本文にあったときの内容のまま。）"]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right) \in \mathbb{R}_{>0}.`,
      ),
      paragraph(["証明."]),
      paragraph([
        "〔V_plus_inverse_is_positive_definite〕",
        " と ",
        ref("exp_hermitian_is_positive_definite"),
        " (4) より ",
        math(String.raw`\mathrm{tr}((V^{(+)})^{-1})>0`),
        " である。",
      ]),
    ],
  },
]);
