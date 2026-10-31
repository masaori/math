import { defineNotes, paragraph, math, displayMath, ref } from "../schema.ts";

// W P^{(+)} の H_1^{(+)}, H_2 による指数表示の主張（本文不採用）。文書本体ではない。
//
// 2026-10-31 の章立ての組み直しまで、ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示の章の最後の主張
// （ラベル symmetrized_transfer_matrix_on_sector_exponential_form）だった。内容はそのまま運んだ。
//
// **本文には採用しなかった。** 理由: 承認された章立て案のこの章のゴールの式は、W P^{(+)} = V^{(+)} P^{(+)} と
// V^{(+)} そのものの指数表示を別々に主張する。本文はその二つを symmetrized_transfer_matrix_on_sectors と
// V_plus_exponential_form として持ち、章末の主張 W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form が
// それらを挙げる。二つを代入して合わせたこの主張は、本文のどこからも使われない。

export default defineNotes([
  {
    id: "note_projection_and_jordan_wigner_claim_V_plus_exponential_form_W_P_plus_exponential_form_not_adopted",
    targets: ["V_plus_exponential_form", "symmetrized_transfer_matrix_on_sectors"],
    title: { tex: String.raw`W P^{(+)} \text{ の } H_1^{(+)},\ H_2 \text{ による指数表示}` },
    body: [
      paragraph([
        "【本文不採用。理由: 章のゴールの主張は W P^{(+)} = V^{(+)} P^{(+)} と V^{(+)} の指数表示を別々に挙げるので、二つを合わせたこの主張は本文のどこからも使われないため。】",
      ]),
      paragraph([
        "（もと content/partition_function_projection_and_jordan_wigner.ts の主張ブロック projection_and_jordan_wigner_claim_symmetrized_transfer_matrix_on_sector_exponential_form。labels: symmetrized_transfer_matrix_on_sector_exponential_form。以下は本文にあったときの内容のまま。）",
      ]),
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とし、虚数単位 ",
        math(String.raw`i\in\mathbb{C}`),
        " を用いる。",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        "、",
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(+)}`),
        "、",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}`),
        "、",
        ref("def_H2"),
        " の ",
        math(String.raw`H_2`),
        "（いずれも ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元）と ",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^*\in\mathbb{R}_{>0}`),
        " について、",
      ]),
      displayMath(
        String.raw`W P^{(+)}
= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
  (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(i K_2^* H_2\right)
  \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) P^{(+)}`,
      ),
      paragraph([
        "が成り立つ。ここに現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_exp"),
        " で成分級数として定めた行列の指数関数である。",
      ]),
      paragraph(["証明."]),
      paragraph([
        ref("def_indexed_hyperbolic_abbreviations"),
        " の略記 ",
        math(String.raw`s_2 := \sinh 2K_2`),
        " を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W P^{(+)}
&= V^{(+)} P^{(+)}
&&(\because\ \blkref{symmetrized_transfer_matrix_on_sectors}) \\
&= \left(V_1^{(+)}\right)^{1/2} V_2 \left(V_1^{(+)}\right)^{1/2} P^{(+)}
&&(\because\ \blkref{def_V_plus}) \\
&= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) V_2 \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) P^{(+)}
&&(\because\ \blkref{def_V1_plus_square_root}) \\
&= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
  (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(i K_2^* H_2\right)
  \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) P^{(+)}
&&(\because\ \blkref{V2_exponential_representation}) \\
&= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
  (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(i K_2^* H_2\right)
  \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) P^{(+)}
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})
\end{aligned}`,
      ),
    ],
  },
]);
