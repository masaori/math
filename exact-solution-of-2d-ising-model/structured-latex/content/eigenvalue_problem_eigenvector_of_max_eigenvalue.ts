import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「固有値問題」の章「V^{(+)} の最大固有値に属する固有ベクトル」。章立て（`tools/chapter-plan.ts`）で
 * この章に割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_chapter_eigenvector_of_max_eigenvalue",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`V^{(+)}\text{ の最大固有値に属する固有ベクトル}` },
    labels: [],
  },
  {
    id: "closing_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 2 },
    title: { tex: String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)} \subseteq \mathcal{F}^{(+)} \text{ を示す道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("max_eigenvalue_of_V_plus_simple"),
        " により ",
        math(String.raw`V^{(+)}`),
        " の最大固有値 ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " は**単純**であり、その固有空間は ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " である。以下では、",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " が ",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " に含まれること（",
        math(String.raw`\varepsilon`),
        " の固有値が ",
        math(String.raw`+1`),
        " であること）を示す。",
        math(String.raw`V^{(+)}`),
        " は ",
        math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " 全体の上の行列であり、その ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 個の固有値に対応する固有ベクトルのうち、",
        math(String.raw`\mathcal{F}^{(+)}`),
        " に属するのは半分だけである。最大固有値の固有ベクトルが ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " に属するかどうかは、",
        "固有値の値 ",
        math(String.raw`\check\Lambda_\epsilon`),
        " からは読み取れない。",
      ]),
      paragraph([
        "筋は次のとおりである（",
        math(String.raw`\varepsilon`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " は ",
        ref("check_joint_eigenspace_decomposition"),
        " の添字である。**字体が違うだけの別物なので注意する**）。",
      ]),
      list([
        [
          "(i) ",
          math(String.raw`\varepsilon`),
          " は ",
          math(String.raw`Z_j, Y_j`),
          " と反可換なので ",
          math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
          " とも反可換であり、したがって ",
          math(String.raw`\check{n}_\mu`),
          " とは**可換**である（",
          ref("epsilon_anticommutes_with_check_Z_Y"),
          "）。",
        ],
        [
          "(ii) ",
          math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
          " は 1 次元なので ",
          math(String.raw`\varepsilon\check{Q}_\epsilon = \eta_\epsilon\check{Q}_\epsilon`),
          "（",
          math(String.raw`\eta_\epsilon \in \{+1,-1\}`),
          "）。しかも ",
          math(String.raw`\check\psi_\mu^\dagger`),
          " が ",
          math(String.raw`\epsilon_\mu`),
          " を ",
          math(String.raw`0`),
          " から ",
          math(String.raw`1`),
          " へ移し、かつ ",
          math(String.raw`\varepsilon`),
          " と反可換なので、成分を 1 つ変えるたびに ",
          math(String.raw`\eta`),
          " の符号が反転する（",
          ref("epsilon_eigenvalue_on_check_Q"),
          "）。",
        ],
        [
          "(iii) したがって ",
          math(String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
= \eta_{(1,\dots,1)}\,(2\sinh 2K_2)^{M_{\mathrm{col}}/2}\prod_{\mu=1}^{M_{\mathrm{col}}}
2\sinh\!\left(\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)`),
          " であり、右辺の ",
          math(String.raw`\eta`),
          " 以外は**正**である（",
          ref("trace_of_epsilon_V_plus_via_check_eigenvalues"),
          "）。",
        ],
        [
          "(iv) 一方 ",
          math(String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)`),
          " は転送行列の側で**直接計算できる**：",
          math(String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
= \left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}} + \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}} > 0`),
          "（",
          ref("trace_of_epsilon_V_plus"),
          "）。使うのは 1 次元開鎖のスピン和だけである。",
        ],
        [
          "(v) 両者を比べて ",
          math(String.raw`\eta_{(1,\dots,1)} = +1`),
          "、すなわち最大固有ベクトルは ",
          math(String.raw`\mathcal{F}^{(+)}`),
          " に属する（",
          ref("max_eigenvector_in_even_sector"),
          "）。",
        ],
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "closing_001_claim_epsilon_anticommutes",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 3 },
    title: { tex: String.raw`\varepsilon \text{ は } \check{Z}, \check{Y}, \check\psi \text{ と反可換}` },
    labels: ["epsilon_anticommutes_with_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " について次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \varepsilon\,Z_j = -Z_j\,\varepsilon,
\qquad \varepsilon\,Y_j = -Y_j\,\varepsilon
\qquad (j \in \{1,\dots,M_{\mathrm{col}}\})`),
        ],
        [
          math(String.raw`\text{(2)}\quad \varepsilon\,\check{Z}_\mu = -\check{Z}_\mu\,\varepsilon,
\qquad \varepsilon\,\check{Y}_\mu = -\check{Y}_\mu\,\varepsilon`),
        ],
        [
          math(String.raw`\text{(3)}\quad \varepsilon\,\check\psi_\mu^\dagger = -\check\psi_\mu^\dagger\,\varepsilon,
\qquad \varepsilon\,\check\psi_\mu = -\check\psi_\mu\,\varepsilon`),
        ],
        [
          math(String.raw`\text{(4)}\quad \varepsilon\,\check{n}_\mu = \check{n}_\mu\,\varepsilon,
\qquad \varepsilon\,\check{Q}_\epsilon = \check{Q}_\epsilon\,\varepsilon
\qquad \left(\epsilon \in \{0,1\}^{\check{\mathcal{M}}}\right)`),
        ],
      ]),
      paragraph([
        "（",
        math(String.raw`\check{n}_\mu`),
        " は ",
        ref("def_check_number_operator"),
        "、",
        math(String.raw`\check{Q}_\epsilon`),
        " は ",
        ref("check_joint_eigenspace_decomposition"),
        "。）",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("epsilon_anticommutes_with_jordan_wigner_Z"),
        " と ",
        ref("epsilon_anticommutes_with_jordan_wigner_Y"),
        " を ",
        math(String.raw`m \to j`),
        " で引いたものである（",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2} \subset \mathbb{Z}_{\geq 1}`),
        "。主張 (1)(2)(3) の右辺の ",
        math(String.raw`-Z_j\,\varepsilon`),
        " などは ",
        math(String.raw`-\bigl(Z_j\,\varepsilon\bigr)`),
        " の意味である）。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`(\check{W}_\mu, W)`),
        " を ",
        math(String.raw`(\check{Z}_\mu, Z)`),
        " と ",
        math(String.raw`(\check{Y}_\mu, Y)`),
        " のどちらかとし、",
        math(String.raw`\check{Z}_\mu`),
        " の場合は ",
        ref("def_half_integer_checkZ"),
        "、",
        math(String.raw`\check{Y}_\mu`),
        " の場合は ",
        ref("def_half_integer_checkY"),
        " を「",
        math(String.raw`\check{W}_\mu`),
        " の定義」と呼ぶ。",
        math(String.raw`j \in \{1,\dots,(M_{\mathrm{col}})_{\mathbb N}\}`),
        " について ",
        math(String.raw`c_j := \exp(-i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}) \in \mathbb{C}`),
        " と書く（",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}`),
        "、",
        math(String.raw`j_{\mathbb Z}`),
        "、",
        math(String.raw`j_{\mathbb R}`),
        " は ",
        math(String.raw`\check{W}_\mu`),
        " の定義の記号）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\check{W}_\mu
&= \varepsilon\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\bigl(c_j W_{j_{\mathbb Z}}\bigr)
&&\bigl(\because\ \check{W}_\mu\text{ の定義}\bigr)\\
&= \sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\Bigl(\varepsilon\bigl(c_j W_{j_{\mathbb Z}}\bigr)\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_right_factor}\ (C \to \varepsilon)\bigr)\\
&= \sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\Bigl(c_j\bigl(\varepsilon\,W_{j_{\mathbb Z}}\bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\Bigl(c_j\Bigl(-\bigl(W_{j_{\mathbb Z}}\,\varepsilon\bigr)\Bigr)\Bigr)
&&\bigl(\because\ \text{(1) を }j \to j_{\mathbb Z}\text{ で各項へ同時適用}\bigr)\\
&= \sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\Bigl(-\Bigl(c_j\bigl(W_{j_{\mathbb Z}}\,\varepsilon\bigr)\Bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_of_negated_matrix}\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\Bigl(-\Bigl(\bigl(c_j W_{j_{\mathbb Z}}\bigr)\varepsilon\Bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ \text{を各項へ同時適用}\bigr)\\
&= -\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\Bigl(\bigl(c_j W_{j_{\mathbb Z}}\bigr)\varepsilon\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_negated_matrices}\bigr)\\
&= -\Biggl(\biggl(\sum_{j=1}^{(M_{\mathrm{col}})_{\mathbb N}}\bigl(c_j W_{j_{\mathbb Z}}\bigr)\biggr)\varepsilon\Biggr)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_left_factor}\ (C \to \varepsilon)\bigr)\\
&= -\bigl(\check{W}_\mu\,\varepsilon\bigr)
&&\bigl(\because\ \check{W}_\mu\text{ の定義}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        math(String.raw`(\Psi, p, q)`),
        " を ",
        ref("def_check_fermi"),
        " の第二の式の二つの組 ",
        math(String.raw`\bigl(\check\psi_\mu^\dagger,\ \tfrac{-r}{2\sqrt{M_{\mathrm{col}}}\,b},\ \tfrac{1}{2\sqrt{M_{\mathrm{col}}}}\bigr)`),
        " と ",
        math(String.raw`\bigl(\check\psi_\mu,\ \tfrac{+r}{2\sqrt{M_{\mathrm{col}}}\,b},\ \tfrac{1}{2\sqrt{M_{\mathrm{col}}}}\bigr)`),
        " のどちらかとする（",
        math(String.raw`p, q \in \mathbb{C}`),
        " はその式の係数で、",
        math(String.raw`\Psi = p\check{Z}_\mu + q\check{Y}_\mu`),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\Psi
&= \varepsilon\bigl(p\check{Z}_\mu + q\check{Y}_\mu\bigr)
&&\bigl(\because\ \blkref{def_check_fermi}\bigr)\\
&= \varepsilon\bigl(p\check{Z}_\mu\bigr) + \varepsilon\bigl(q\check{Y}_\mu\bigr)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\bigr)\\
&= p\bigl(\varepsilon\,\check{Z}_\mu\bigr) + q\bigl(\varepsilon\,\check{Y}_\mu\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\ \text{を 2 項へ同時適用}\bigr)\\
&= p\Bigl(-\bigl(\check{Z}_\mu\,\varepsilon\bigr)\Bigr) + q\Bigl(-\bigl(\check{Y}_\mu\,\varepsilon\bigr)\Bigr)
&&\bigl(\because\ \text{(2) を 2 項へ同時適用}\bigr)\\
&= \Bigl(-\Bigl(p\bigl(\check{Z}_\mu\,\varepsilon\bigr)\Bigr)\Bigr) + \Bigl(-\Bigl(q\bigl(\check{Y}_\mu\,\varepsilon\bigr)\Bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_of_negated_matrix}\ \text{を 2 項へ同時適用}\bigr)\\
&= \Bigl(-\Bigl(\bigl(p\check{Z}_\mu\bigr)\varepsilon\Bigr)\Bigr) + \Bigl(-\Bigl(\bigl(q\check{Y}_\mu\bigr)\varepsilon\Bigr)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ \text{を 2 項へ同時適用}\bigr)\\
&= -\Bigl(\bigl(p\check{Z}_\mu\bigr)\varepsilon + \bigl(q\check{Y}_\mu\bigr)\varepsilon\Bigr)
&&\bigl(\because\ \blkref{negation_distributes_over_matrix_sum}\ \text{を右辺から左辺へ}\bigr)\\
&= -\Bigl(\bigl(p\check{Z}_\mu + q\check{Y}_\mu\bigr)\varepsilon\Bigr)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor}\bigr)\\
&= -\bigl(\Psi\,\varepsilon\bigr)
&&\bigl(\because\ \blkref{def_check_fermi}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(4) ",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " なので、(3) は ",
        math(String.raw`\varepsilon\,\check\psi_\mu^\dagger = -\bigl(\check\psi_\mu^\dagger\,\varepsilon\bigr)`),
        " と ",
        math(String.raw`\varepsilon\,\check\psi_{M_{\mathrm{col}}+1-\mu} = -\bigl(\check\psi_{M_{\mathrm{col}}+1-\mu}\,\varepsilon\bigr)`),
        " を与える。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\check{n}_\mu
&= \varepsilon\bigl(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}\bigr)
&&\bigl(\because\ \blkref{def_check_number_operator}\bigr)\\
&= \bigl(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}\bigr)\varepsilon
&&\bigl(\because\ \blkref{product_of_anticommuting_matrices_commutes}\ (G \to \varepsilon,\ X \to \check\psi_\mu^\dagger,\ Y \to \check\psi_{M_{\mathrm{col}}+1-\mu})\text{。仮定は上の (3) の 2 式}\bigr)\\
&= \check{n}_\mu\,\varepsilon
&&\bigl(\because\ \blkref{def_check_number_operator}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " とし、",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " について ",
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_\epsilon`),
        " の定義の因子を ",
        math(String.raw`A_\nu := \epsilon_\nu\,\check{n}_\nu + (1-\epsilon_\nu)\left(I - \check{n}_\nu\right)`),
        " と書く（",
        math(String.raw`\epsilon_\nu`),
        "・",
        math(String.raw`1-\epsilon_\nu`),
        " はその定義のスカラー）。まず ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`I`),
        " と可換である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,I
&= \varepsilon
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\bigr)\\
&= I\,\varepsilon
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "これと上の ",
        math(String.raw`\varepsilon\,\check{n}_\nu = \check{n}_\nu\,\varepsilon`),
        "（",
        math(String.raw`\mu \to \nu`),
        "）から、次の 3 式が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\left(I - \check{n}_\nu\right) &= \left(I - \check{n}_\nu\right)\varepsilon
&&\bigl(\because\ \blkref{commuting_with_difference}\ (G \to \varepsilon,\ X \to I,\ W \to \check{n}_\nu)\text{。仮定は }\varepsilon I = I\varepsilon\text{ と }\varepsilon\check{n}_\nu = \check{n}_\nu\varepsilon\bigr)\\
\varepsilon\bigl(\epsilon_\nu\,\check{n}_\nu\bigr) &= \bigl(\epsilon_\nu\,\check{n}_\nu\bigr)\varepsilon
&&\bigl(\because\ \blkref{commuting_with_scalar_multiple}\ (G \to \varepsilon,\ c \to \epsilon_\nu,\ X \to \check{n}_\nu)\text{。仮定は }\varepsilon\check{n}_\nu = \check{n}_\nu\varepsilon\bigr)\\
\varepsilon\Bigl((1-\epsilon_\nu)\left(I - \check{n}_\nu\right)\Bigr) &= \Bigl((1-\epsilon_\nu)\left(I - \check{n}_\nu\right)\Bigr)\varepsilon
&&\bigl(\because\ \blkref{commuting_with_scalar_multiple}\ (G \to \varepsilon,\ c \to 1-\epsilon_\nu,\ X \to I - \check{n}_\nu)\text{。仮定は 1 行目}\bigr)
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,A_\nu
&= \varepsilon\Bigl(\epsilon_\nu\,\check{n}_\nu + (1-\epsilon_\nu)\left(I - \check{n}_\nu\right)\Bigr)
&&\bigl(\because\ A_\nu\text{ の置き方}\bigr)\\
&= \varepsilon\bigl(\epsilon_\nu\,\check{n}_\nu\bigr) + \varepsilon\Bigl((1-\epsilon_\nu)\left(I - \check{n}_\nu\right)\Bigr)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\bigr)\\
&= \bigl(\epsilon_\nu\,\check{n}_\nu\bigr)\varepsilon + \Bigl((1-\epsilon_\nu)\left(I - \check{n}_\nu\right)\Bigr)\varepsilon
&&\bigl(\because\ \text{上の 3 式の 2 行目と 3 行目を 2 項へ同時適用}\bigr)\\
&= \Bigl(\epsilon_\nu\,\check{n}_\nu + (1-\epsilon_\nu)\left(I - \check{n}_\nu\right)\Bigr)\varepsilon
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor}\bigr)\\
&= A_\nu\,\varepsilon
&&\bigl(\because\ A_\nu\text{ の置き方}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "がすべての ",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " で成り立ち、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\check{Q}_\epsilon
&= \varepsilon\prod_{\nu=1}^{M_{\mathrm{col}}}A_\nu
&&\bigl(\because\ \blkref{check_joint_eigenspace_decomposition}\text{ の }\check{Q}_\epsilon\text{ の定義と }A_\nu\text{ の置き方}\bigr)\\
&= \Bigl(\prod_{\nu=1}^{M_{\mathrm{col}}}A_\nu\Bigr)\varepsilon
&&\bigl(\because\ \blkref{matrix_commuting_with_each_factor_commutes_with_finite_product}\ (n \to 2^{M_{\mathrm{col}}},\ r \to M_{\mathrm{col}},\ X \to \varepsilon,\ A_j \to A_\nu)\bigr)\\
&= \check{Q}_\epsilon\,\varepsilon
&&\bigl(\because\ \blkref{check_joint_eigenspace_decomposition}\text{ の }\check{Q}_\epsilon\text{ の定義と }A_\nu\text{ の置き方}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "ε が Z_j, Y_j と反可換であることは epsilon_anticommutes_with_jordan_wigner_Z・epsilon_anticommutes_with_jordan_wigner_Y（σ_k^x とは可換、σ_k^y, σ_k^z とは反可換から従う）である。ε が V_1, V_2 と可換であることと、Z_j, Y_j と反可換であることは矛盾しない（V_1, V_2 の指数の中身は Z, Y の 2 次式である）。",
        "2026-11-04（全証明の SageMath 検算）: (1) の鎖が引いていた「epsilon_commutes_with_transfer_matrices の Step 1」は本文に無いブロックの段だった（その内容は 2026-11-02 に epsilon_anticommutes_with_jordan_wigner_Z・_Y へ切り出されている）。(1) をその二つの主張の引用にした。(2) の鎖が引いていた def_half_integer_modes は θ̃_{1−μ} = −θ̃_μ の主張で Ž の定義ではなかったので、def_half_integer_checkZ・def_half_integer_checkY に直し、項の順序を定義どおり exp(…)Z_{j_Z} にした。(2)(3) の「積の ℂ 線型性」の行を finite_sum_of_matrices_distributes_in_left/right_factor・scalar_multiple_factors_out_of_left/right_factor・scalar_multiple_of_negated_matrix・finite_sum_of_negated_matrices・negation_distributes_over_matrix_sum の一行ずつに分け、散文の「Y̌_μ も同じ計算」を (W̌_μ, W) ∈ {(Ž_μ, Z), (Y̌_μ, Y)} の一本の鎖に、(3) の ψ̌_μ を (Ψ, p, q) の一本の鎖に含めた。(4) の ň_μ の鎖を product_of_anticommuting_matrices_commutes の引用に、Q̌_ε の散文を εI = Iε の鎖、commuting_with_difference・commuting_with_scalar_multiple を引く 3 式、分配則の鎖と matrix_commuting_with_each_factor_commutes_with_finite_product の鎖にした。主張は変えていない。",
        "数値検証: sagemath/check/epsilon_anticommutes_with_check_Z_Y/（厳密計算）。旧い浮動小数点の検算 sagemath/check/053_claim_even_sector_closing/check_01 も残っている。",
      ],
    },
  },
  {
    id: "closing_002_claim_epsilon_eigenvalue_on_check_Q",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 4 },
    title: { tex: String.raw`\varepsilon\check{Q}_\epsilon = \eta_\epsilon\check{Q}_\epsilon
\text{ と符号の反転則}` },
    labels: ["epsilon_eigenvalue_on_check_Q"],
    statement: [
      paragraph([
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " に対し ",
        math(String.raw`|\epsilon| := \#\{\mu \in \check{\mathcal{M}} \mid \epsilon_\mu = 1\}`),
        " とおく。次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \exists!\,\eta_\epsilon \in \{+1,-1\}:\quad
\varepsilon\,\check{Q}_\epsilon = \eta_\epsilon\,\check{Q}_\epsilon`),
        ],
        [
          math(String.raw`\text{(2)}\quad \epsilon_\mu = 0 \ \Longrightarrow\
\eta_{\epsilon[\mu\to1]} = -\eta_\epsilon`),
          "。ここで ",
          math(String.raw`\epsilon[\mu\to1]`),
          " は ",
          math(String.raw`\epsilon`),
          " の第 ",
          math(String.raw`\mu`),
          " 成分だけを ",
          math(String.raw`1`),
          " に取り替えたもの。",
        ],
        [
          math(String.raw`\text{(3)}\quad \eta_\epsilon
= \eta_{(1,\dots,1)}\,(-1)^{M_{\mathrm{col}}-|\epsilon|}`),
        ],
        [
          math(String.raw`\text{(4)}\quad \varepsilon
= \eta_{(1,\dots,1)}\,(-1)^{M_{\mathrm{col}}}\prod_{\mu=1}^{M_{\mathrm{col}}}\left(I - 2\check{n}_\mu\right)`),
        ],
      ]),
      paragraph([
        "**この段階では ",
        math(String.raw`\eta_{(1,\dots,1)}`),
        " の値は決まっていない。** それを決めるのが ",
        ref("trace_of_epsilon_V_plus"),
        " と ",
        ref("max_eigenvector_in_even_sector"),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("check_joint_eigenspace_decomposition"),
        " (4) より ",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{im}\,\check{Q}_\epsilon = 1`),
        " なので、",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon = \mathbb{C}q`),
        " なる ",
        math(String.raw`q \neq 0`),
        " が取れる。",
        math(String.raw`q \in \mathrm{im}\,\check{Q}_\epsilon`),
        " なので ",
        math(String.raw`q = \check{Q}_\epsilon x`),
        " なる ",
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " が取れる。まず ",
        math(String.raw`\check{Q}_\epsilon q = q`),
        " を確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon q
&= \check{Q}_\epsilon\left(\check{Q}_\epsilon x\right)
   \quad (\because q = \check{Q}_\epsilon x \text{ の置き方}) \\
&= \left(\check{Q}_\epsilon\check{Q}_\epsilon\right)x
   \quad (\because \blkref{mat_mult_associative}) \\
&= \check{Q}_\epsilon x
   \quad (\because \blkref{check_joint_eigenspace_decomposition}\text{ (1) の }
   \check{Q}_\epsilon^2 = \check{Q}_\epsilon) \\
&= q
   \quad (\because q = \check{Q}_\epsilon x \text{ の置き方})
\end{aligned}`,
      ),
      paragraph([
        "次に ",
        ref("epsilon_anticommutes_with_check_Z_Y"),
        " (4) より ",
        math(String.raw`\varepsilon\check{Q}_\epsilon = \check{Q}_\epsilon\varepsilon`),
        " だから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon\left(\varepsilon q\right)
&= \left(\check{Q}_\epsilon\varepsilon\right)q
   \quad (\because \blkref{mat_mult_associative}) \\
&= \left(\varepsilon\check{Q}_\epsilon\right)q
   \quad (\because \blkref{epsilon_anticommutes_with_check_Z_Y}\text{ (4)}) \\
&= \varepsilon\left(\check{Q}_\epsilon q\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \varepsilon q
   \quad (\because \text{上で示した } \check{Q}_\epsilon q = q)
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\varepsilon q \in \mathrm{im}\,\check{Q}_\epsilon = \mathbb{C}q`),
        " であり、",
        math(String.raw`\varepsilon q = \eta q`),
        " なる ",
        math(String.raw`\eta \in \mathbb{C}`),
        " が一意に定まる（",
        math(String.raw`q \neq 0`),
        "）。次の式変形で ",
        math(String.raw`\eta^2 = 1`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
q
&= Iq
   \quad (\because \blkref{identity_matrix_is_left_unit_of_mat_mult}) \\
&= \left(\varepsilon\varepsilon\right)q
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\text{ の }\varepsilon^2=I) \\
&= \varepsilon\left(\varepsilon q\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \varepsilon\left(\eta q\right)
   \quad (\because \varepsilon q=\eta q\text{ の置き方}) \\
&= \eta\left(\varepsilon q\right)
   \quad (\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= \eta\left(\eta q\right)
   \quad (\because \varepsilon q=\eta q\text{ の置き方}) \\
&= \left(\eta\eta\right)q
   \quad (\because \blkref{scalar_multiple_is_associative})
\end{aligned}`,
      ),
      paragraph([
        "上の式変形の両端から ",
        math(String.raw`q = (\eta\eta)q`),
        " である。これを使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\eta\eta-1\right)q
&= (\eta\eta)q - 1q
   \quad (\because \blkref{difference_of_scalar_multiples_of_one_matrix}) \\
&= q - 1q
   \quad (\because \text{上の式変形の } q = (\eta\eta)q) \\
&= q - q
   \quad (\because \blkref{scalar_multiple_by_one}) \\
&= O
   \quad (\because \blkref{matrix_difference_zero_iff_equal})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`q \neq 0`),
        " なので ",
        math(String.raw`q_k \neq 0`),
        " となる ",
        math(String.raw`k \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " が取れ、上の式の第 ",
        math(String.raw`k`),
        " 成分は ",
        ref("def_matrix_scalar_multiple"),
        " より ",
        math(String.raw`(\eta\eta-1)\,q_k = 0`),
        " である。",
        ref("complex_numbers_form_a_field"),
        " より ",
        math(String.raw`\mathbb{C}`),
        " は体なので ",
        math(String.raw`\eta\eta-1 = 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\eta-1)(\eta+1)
&= (\eta-1)\eta + (\eta-1)\cdot 1
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の分配則}) \\
&= (\eta\eta - \eta) + (\eta - 1)
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の分配則と乗法の単位元}) \\
&= \eta\eta - 1
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の加法の結合則と逆元}) \\
&= 0
   \quad (\because \text{上で示した } \eta\eta-1=0)
\end{aligned}`,
      ),
      paragraph([
        "より、体 ",
        math(String.raw`\mathbb{C}`),
        " では ",
        math(String.raw`\eta-1=0`),
        " または ",
        math(String.raw`\eta+1=0`),
        "、すなわち ",
        math(String.raw`\eta \in \{+1,-1\}`),
        " である。",
      ]),
      paragraph([
        "次に行列の等式を示す。",
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " とする。",
        math(String.raw`\check{Q}_\epsilon x \in \mathrm{im}\,\check{Q}_\epsilon = \mathbb{C}q`),
        " なので ",
        math(String.raw`\check{Q}_\epsilon x = cq`),
        " なる ",
        math(String.raw`c \in \mathbb{C}`),
        " が取れ、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\varepsilon\check{Q}_\epsilon\right)x
&= \varepsilon\left(\check{Q}_\epsilon x\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \varepsilon\left(cq\right)
   \quad (\because \check{Q}_\epsilon x = cq\text{ の置き方}) \\
&= c\left(\varepsilon q\right)
   \quad (\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= c\left(\eta q\right)
   \quad (\because \varepsilon q=\eta q\text{ の置き方}) \\
&= (c\eta)q
   \quad (\because \blkref{scalar_multiple_is_associative}) \\
&= (\eta c)q
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の交換則}) \\
&= \eta\left(cq\right)
   \quad (\because \blkref{scalar_multiple_is_associative}) \\
&= \eta\left(\check{Q}_\epsilon x\right)
   \quad (\because \check{Q}_\epsilon x = cq\text{ の置き方}) \\
&= \left(\eta\check{Q}_\epsilon\right)x
   \quad (\because \blkref{scalar_multiple_factors_out_of_left_factor})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`N := 2^{M_{\mathrm{col}}}`),
        "、",
        math(String.raw`e_k`),
        " を ",
        math(String.raw`I`),
        " の第 ",
        math(String.raw`k`),
        " 列（",
        ref("def_identity_matrix"),
        "）とすると ",
        math(String.raw`I = \left[\,e_1\ \cdots\ e_N\,\right]`),
        " であり、上の等式を ",
        math(String.raw`x \to e_1,\dots,e_N`),
        " に使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\check{Q}_\epsilon
&= \left(\varepsilon\check{Q}_\epsilon\right)I
   \quad (\because \blkref{identity_matrix_is_right_unit_of_mat_mult}) \\
&= \left(\varepsilon\check{Q}_\epsilon\right)\left[\,e_1\ \cdots\ e_N\,\right]
   \quad (\because I = \left[\,e_1\ \cdots\ e_N\,\right]) \\
&= \left[\,\left(\varepsilon\check{Q}_\epsilon\right)e_1\ \cdots\ \left(\varepsilon\check{Q}_\epsilon\right)e_N\,\right]
   \quad (\because \blkref{mat_columnwise}) \\
&= \left[\,\left(\eta\check{Q}_\epsilon\right)e_1\ \cdots\ \left(\eta\check{Q}_\epsilon\right)e_N\,\right]
   \quad (\because \text{上の等式を } N \text{ 箇所へ同時適用}) \\
&= \left(\eta\check{Q}_\epsilon\right)\left[\,e_1\ \cdots\ e_N\,\right]
   \quad (\because \blkref{mat_columnwise}) \\
&= \left(\eta\check{Q}_\epsilon\right)I
   \quad (\because I = \left[\,e_1\ \cdots\ e_N\,\right]) \\
&= \eta\check{Q}_\epsilon
   \quad (\because \blkref{identity_matrix_is_right_unit_of_mat_mult})
\end{aligned}`,
      ),
      paragraph([
        "一意性を示す。",
        math(String.raw`\eta' \in \{+1,-1\}`),
        " が ",
        math(String.raw`\varepsilon\check{Q}_\epsilon = \eta'\check{Q}_\epsilon`),
        " を満たすとすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\eta' q
&= \eta'\left(\check{Q}_\epsilon q\right)
   \quad (\because \text{上で示した } \check{Q}_\epsilon q = q) \\
&= \left(\eta'\check{Q}_\epsilon\right)q
   \quad (\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= \left(\varepsilon\check{Q}_\epsilon\right)q
   \quad (\because \eta'\text{ の仮定}) \\
&= \varepsilon\left(\check{Q}_\epsilon q\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \varepsilon q
   \quad (\because \text{上で示した } \check{Q}_\epsilon q = q) \\
&= \eta q
   \quad (\because \varepsilon q=\eta q\text{ の置き方})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`q \neq 0`),
        " だから ",
        math(String.raw`\varepsilon q = \eta q`),
        " なる ",
        math(String.raw`\eta`),
        " の一意性より ",
        math(String.raw`\eta' = \eta`),
        "。この ",
        math(String.raw`\eta`),
        " を ",
        math(String.raw`\eta_\epsilon`),
        " と書く。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`\epsilon_\mu = 0`),
        " とし、",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " の ",
        math(String.raw`0`),
        " でない元を 1 つ取って ",
        math(String.raw`q`),
        " とする。",
        ref("check_joint_eigenspace_decomposition"),
        " (1) の冪等性より ",
        math(String.raw`\check{Q}_\epsilon q = q`),
        " である。(1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon q
&= \varepsilon\left(\check{Q}_\epsilon q\right)
   \quad (\because \check{Q}_\epsilon q=q) \\
&= \left(\varepsilon\check{Q}_\epsilon\right)q
   \quad (\because \blkref{mat_mult_associative}) \\
&= \left(\eta_\epsilon\check{Q}_\epsilon\right)q
   \quad (\because \text{(1)}) \\
&= \eta_\epsilon\left(\check{Q}_\epsilon q\right)
   \quad (\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= \eta_\epsilon q
   \quad (\because \check{Q}_\epsilon q=q)
\end{aligned}`,
      ),
      paragraph([
        "である。**以下で使うのは ",
        math(String.raw`q \neq 0`),
        " と ",
        math(String.raw`\check{Q}_\epsilon q = q`),
        " だけであり、",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " や ",
        math(String.raw`\mathrm{im}\,\check{Q}_{\epsilon[\mu\to1]}`),
        " が 1 次元であることは使わない**（1 次元性が要るのは (1) の ",
        math(String.raw`\eta_\epsilon`),
        " の存在を出すところだけである）。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\check\psi_\mu^\dagger q \neq 0`),
        "）。",
        math(String.raw`\epsilon_\mu = 0`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu q
&= \check{n}_\mu\left(\check{Q}_\epsilon q\right)
   \quad (\because \check{Q}_\epsilon q = q) \\
&= \left(\check{n}_\mu\check{Q}_\epsilon\right)q
   \quad (\because \blkref{mat_mult_associative}) \\
&= \left(\epsilon_\mu\check{Q}_\epsilon\right)q
   \quad (\because \blkref{check_joint_eigenspace_decomposition}\text{ (3)}) \\
&= \left(0_{\mathbb{C}}\check{Q}_\epsilon\right)q
   \quad (\because \epsilon_\mu = 0) \\
&= Oq
   \quad (\because \blkref{zero_scalar_multiple_is_zero_matrix}) \\
&= 0
   \quad (\because \blkref{zero_matrix_is_left_zero_of_mat_mult})
\end{aligned}`,
      ),
      paragraph([
        "である。これと ",
        ref("check_number_operator_idempotent"),
        " (2) の ",
        math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_\mu^\dagger = I - \check{n}_\mu`),
        " を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_{M_{\mathrm{col}}+1-\mu}\left(\check\psi_\mu^\dagger q\right)
&= \left(\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_\mu^\dagger\right)q
   \quad (\because \blkref{mat_mult_associative}) \\
&= \left(I - \check{n}_\mu\right)q
   \quad (\because \blkref{check_number_operator_idempotent}\text{ (2)}) \\
&= Iq - \check{n}_\mu q
   \quad (\because \blkref{matrix_difference_mul_vector}) \\
&= q - \check{n}_\mu q
   \quad (\because \blkref{identity_matrix_is_left_unit_of_mat_mult}) \\
&= q-0
   \quad (\because \text{上の } \check n_\mu q=0) \\
&= q
   \quad (\because \blkref{matrix_minus_zero_matrix})
\end{aligned}`,
      ),
      paragraph([
        "である。仮に ",
        math(String.raw`\check\psi_\mu^\dagger q = 0`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
q
&= \check\psi_{M_{\mathrm{col}}+1-\mu}\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \text{上の式変形}) \\
&= \check\psi_{M_{\mathrm{col}}+1-\mu}\,0
   \quad (\because \text{仮定 } \check\psi_\mu^\dagger q = 0) \\
&= 0
   \quad (\because \blkref{zero_matrix_is_right_zero_of_mat_mult})
\end{aligned}`,
      ),
      paragraph([
        "となって ",
        math(String.raw`q \neq 0`),
        " に反する。よって ",
        math(String.raw`\check\psi_\mu^\dagger q \neq 0`),
        "。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\check{Q}_{\epsilon'}\left(\check\psi_\mu^\dagger q\right) = \check\psi_\mu^\dagger q`),
        "、",
        math(String.raw`\epsilon' := \epsilon[\mu\to1]`),
        "）。まず ",
        math(String.raw`\check{n}_\mu\check\psi_\mu^\dagger = \check\psi_\mu^\dagger`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu\,\check\psi_\mu^\dagger
&= \left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\right)\check\psi_\mu^\dagger
   \quad (\because \blkref{def_check_number_operator}) \\
&= \check\psi_\mu^\dagger\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_\mu^\dagger\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \check\psi_\mu^\dagger\left(I - \check{n}_\mu\right)
   \quad (\because \blkref{check_number_operator_idempotent}\text{ (2)}) \\
&= \check\psi_\mu^\dagger\left(I + \left(-\check{n}_\mu\right)\right)
   \quad (\because \blkref{matrix_difference_is_sum_with_negation}) \\
&= \check\psi_\mu^\dagger I + \check\psi_\mu^\dagger\left(-\check{n}_\mu\right)
   \quad (\because \blkref{mat_mult_distributes_over_sum_in_right_factor}) \\
&= \check\psi_\mu^\dagger I + \left(-\left(\check\psi_\mu^\dagger\check{n}_\mu\right)\right)
   \quad (\because \blkref{negation_factors_out_of_right_factor}) \\
&= \check\psi_\mu^\dagger I - \check\psi_\mu^\dagger\check{n}_\mu
   \quad (\because \blkref{matrix_difference_is_sum_with_negation}) \\
&= \check\psi_\mu^\dagger - \check\psi_\mu^\dagger\check{n}_\mu
   \quad (\because \blkref{identity_matrix_is_right_unit_of_mat_mult}) \\
&= \check\psi_\mu^\dagger
   - \check\psi_\mu^\dagger\left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\right)
   \quad (\because \blkref{def_check_number_operator}) \\
&= \check\psi_\mu^\dagger
   - \left(\check\psi_\mu^\dagger\check\psi_\mu^\dagger\right)\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \blkref{mat_mult_associative}) \\
&= \check\psi_\mu^\dagger - O\,\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \blkref{check_number_operator_idempotent}\text{ (1) の }
   \left(\check\psi_\mu^\dagger\right)^2 = O) \\
&= \check\psi_\mu^\dagger - O
   \quad (\because \blkref{zero_matrix_is_left_zero_of_mat_mult}) \\
&= \check\psi_\mu^\dagger
   \quad (\because \blkref{matrix_minus_zero_matrix})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta \in \{\epsilon, \epsilon'\}`),
        " と ",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " について ",
        math(String.raw`A_\nu^{\delta} := \delta_\nu\,\check{n}_\nu + (1-\delta_\nu)\left(I - \check{n}_\nu\right)`),
        " とおく。",
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_\delta`),
        " の定義により ",
        math(String.raw`\check{Q}_\delta = \prod_{\nu=1}^{M_{\mathrm{col}}}A_\nu^{\delta}`),
        " である。",
        math(String.raw`\nu \neq \mu`),
        " では ",
        math(String.raw`\epsilon'_\nu = \epsilon_\nu`),
        " なので ",
        math(String.raw`A_\nu^{\epsilon'} = A_\nu^{\epsilon}`),
        " であり、以下これを ",
        math(String.raw`A_\nu`),
        " と書く。",
        math(String.raw`\mu`),
        " 番目の因子は、",
        math(String.raw`\epsilon_\mu = 0`),
        " から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A_\mu^{\epsilon}
&= 0_{\mathbb{C}}\,\check{n}_\mu + \left(1_{\mathbb{C}}-0_{\mathbb{C}}\right)\left(I - \check{n}_\mu\right)
  \quad (\because \epsilon_\mu=0) \\
&= 0_{\mathbb{C}}\,\check{n}_\mu + \left(1_{\mathbb{C}}+\left(-\left(0_{\mathbb{C}}\right)\right)\right)\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{def_complex_difference}) \\
&= 0_{\mathbb{C}}\,\check{n}_\mu + \left(1_{\mathbb{C}}+\left(-1_{\mathbb{C}}\right)\cdot 0_{\mathbb{C}}\right)\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{multiply_by_minus_one}) \\
&= 0_{\mathbb{C}}\,\check{n}_\mu + \left(1_{\mathbb{C}}+0_{\mathbb{C}}\right)\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{complex_times_zero_is_zero}) \\
&= 0_{\mathbb{C}}\,\check{n}_\mu + 1_{\mathbb{C}}\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{complex_numbers_form_a_field}\text{ の加法の単位元}) \\
&= O + 1_{\mathbb{C}}\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{zero_scalar_multiple_is_zero_matrix}) \\
&= O + \left(I - \check{n}_\mu\right)
  \quad (\because \blkref{scalar_multiple_by_one}) \\
&= I - \check{n}_\mu
  \quad (\because \blkref{zero_matrix_plus_matrix})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\epsilon'_\mu = 1`),
        " から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A_\mu^{\epsilon'}
&= 1_{\mathbb{C}}\,\check{n}_\mu + \left(1_{\mathbb{C}}-1_{\mathbb{C}}\right)\left(I - \check{n}_\mu\right)
  \quad (\because \epsilon'_\mu=1) \\
&= 1_{\mathbb{C}}\,\check{n}_\mu + \left(1_{\mathbb{C}}+\left(-\left(1_{\mathbb{C}}\right)\right)\right)\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{def_complex_difference}) \\
&= 1_{\mathbb{C}}\,\check{n}_\mu + \left(1_{\mathbb{C}}+\left(-1_{\mathbb{C}}\right)\cdot 1_{\mathbb{C}}\right)\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{multiply_by_minus_one}) \\
&= 1_{\mathbb{C}}\,\check{n}_\mu + \left(1_{\mathbb{C}}+\left(-1_{\mathbb{C}}\right)\right)\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の単位元}) \\
&= 1_{\mathbb{C}}\,\check{n}_\mu + 0_{\mathbb{C}}\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{complex_numbers_form_a_field}\text{ の加法の逆元}) \\
&= \check{n}_\mu + 0_{\mathbb{C}}\left(I - \check{n}_\mu\right)
  \quad (\because \blkref{scalar_multiple_by_one}) \\
&= \check{n}_\mu + O
  \quad (\because \blkref{zero_scalar_multiple_is_zero_matrix}) \\
&= \check{n}_\mu
  \quad (\because \blkref{matrix_plus_zero_matrix})
\end{aligned}`,
      ),
      paragraph([
        "である。次に可換性を示す。",
        math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        "、",
        math(String.raw`\delta \in \{\epsilon,\epsilon'\}`),
        " が ",
        math(String.raw`X\check{n}_\nu = \check{n}_\nu X`),
        " を満たすとする。",
        math(String.raw`XI = X = IX`),
        "（",
        ref("identity_matrix_is_right_unit_of_mat_mult"),
        "・",
        ref("identity_matrix_is_left_unit_of_mat_mult"),
        "）と ",
        ref("commuting_with_difference"),
        " より ",
        math(String.raw`X\left(I-\check{n}_\nu\right) = \left(I-\check{n}_\nu\right)X`),
        "、",
        ref("commuting_with_scalar_multiple"),
        " より ",
        math(String.raw`X\left(\delta_\nu\check{n}_\nu\right) = \left(\delta_\nu\check{n}_\nu\right)X`),
        " と ",
        math(String.raw`X\left((1-\delta_\nu)\left(I-\check{n}_\nu\right)\right) = \left((1-\delta_\nu)\left(I-\check{n}_\nu\right)\right)X`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
XA_\nu^{\delta}
&= X\left(\delta_\nu\check{n}_\nu + (1-\delta_\nu)\left(I-\check{n}_\nu\right)\right)
   \quad (\because A_\nu^{\delta}\text{ の置き方}) \\
&= X\left(\delta_\nu\check{n}_\nu\right) + X\left((1-\delta_\nu)\left(I-\check{n}_\nu\right)\right)
   \quad (\because \blkref{mat_mult_distributes_over_sum_in_right_factor}) \\
&= \left(\delta_\nu\check{n}_\nu\right)X + \left((1-\delta_\nu)\left(I-\check{n}_\nu\right)\right)X
   \quad (\because \text{上の 2 式}) \\
&= \left(\delta_\nu\check{n}_\nu + (1-\delta_\nu)\left(I-\check{n}_\nu\right)\right)X
   \quad (\because \blkref{mat_mult_distributes_over_sum_in_left_factor}) \\
&= A_\nu^{\delta}X
   \quad (\because A_\nu^{\delta}\text{ の置き方})
\end{aligned}`,
      ),
      paragraph([
        "である。これを ",
        math(String.raw`X \to \check{n}_\kappa`),
        "（",
        math(String.raw`\kappa \in \check{\mathcal{M}}`),
        "。",
        ref("check_number_operators_commute"),
        " (2)。",
        math(String.raw`\kappa = \nu`),
        " では両辺が同じ積 ",
        math(String.raw`\check{n}_\nu\check{n}_\nu`),
        " である）に使うと ",
        math(String.raw`\check{n}_\kappa A_\nu^{\delta} = A_\nu^{\delta}\check{n}_\kappa`),
        "、さらに ",
        math(String.raw`X \to A_\kappa^{\delta}`),
        " に使うと ",
        math(String.raw`A_\kappa^{\delta}A_\nu^{\delta} = A_\nu^{\delta}A_\kappa^{\delta}`),
        " である（因子の可換性）。また ",
        math(String.raw`\nu \neq \mu`),
        " では ",
        ref("check_number_operators_commute"),
        " (1) より ",
        math(String.raw`\check\psi_\mu^\dagger\check{n}_\nu = \check{n}_\nu\check\psi_\mu^\dagger`),
        " なので ",
        math(String.raw`X \to \check\psi_\mu^\dagger`),
        " に使うと ",
        math(String.raw`\check\psi_\mu^\dagger A_\nu = A_\nu\check\psi_\mu^\dagger`),
        " である。",
        math(String.raw`\Pi' := \prod_{\nu=1,\ \nu\neq\mu}^{M_{\mathrm{col}}}A_\nu`),
        "（",
        ref("def_finite_product_of_matrices_omitting_one_index"),
        "（",
        math(String.raw`r \to M_{\mathrm{col}},\ \nu \to \mu`),
        "）。",
        math(String.raw`\Pi' = \prod_{j=1}^{M_{\mathrm{col}}-1}A_{s(j)}`),
        " で ",
        math(String.raw`s(j) \neq \mu`),
        "）とおくと、",
        ref("matrix_commuting_with_each_factor_commutes_with_finite_product"),
        " より ",
        math(String.raw`\check\psi_\mu^\dagger\Pi' = \Pi'\check\psi_\mu^\dagger`),
        " である。以上を使って次の 3 式を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A_\mu^{\epsilon}q
&= \left(I - \check{n}_\mu\right)q
   \quad (\because \text{上の } A_\mu^{\epsilon} = I - \check{n}_\mu) \\
&= Iq - \check{n}_\mu q
   \quad (\because \blkref{matrix_difference_mul_vector}) \\
&= q - \check{n}_\mu q
   \quad (\because \blkref{identity_matrix_is_left_unit_of_mat_mult}) \\
&= q - 0
   \quad (\because \text{Step 1 の } \check{n}_\mu q = 0) \\
&= q
   \quad (\because \blkref{matrix_minus_zero_matrix})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\Pi' q
&= \Pi'\left(A_\mu^{\epsilon}q\right)
   \quad (\because \text{上の } A_\mu^{\epsilon}q = q) \\
&= \left(\Pi' A_\mu^{\epsilon}\right)q
   \quad (\because \blkref{mat_mult_associative}) \\
&= \left(\prod_{\nu=1}^{M_{\mathrm{col}}}A_\nu^{\epsilon}\right)q
   \quad (\because \blkref{moving_one_factor_of_finite_product_to_the_end}\text{ と因子の可換性}) \\
&= \check{Q}_\epsilon q
   \quad (\because \check{Q}_\epsilon\text{ の定義}) \\
&= q
   \quad (\because \check{Q}_\epsilon q = q)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_{\epsilon'}\left(\check\psi_\mu^\dagger q\right)
&= \left(\prod_{\nu=1}^{M_{\mathrm{col}}}A_\nu^{\epsilon'}\right)\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \check{Q}_{\epsilon'}\text{ の定義}) \\
&= \left(\Pi' A_\mu^{\epsilon'}\right)\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \blkref{moving_one_factor_of_finite_product_to_the_end}\text{ と因子の可換性、} \nu\neq\mu\text{ で } A_\nu^{\epsilon'} = A_\nu) \\
&= \left(\Pi'\check{n}_\mu\right)\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \text{上の } A_\mu^{\epsilon'} = \check{n}_\mu) \\
&= \Pi'\left(\check{n}_\mu\left(\check\psi_\mu^\dagger q\right)\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \Pi'\left(\left(\check{n}_\mu\check\psi_\mu^\dagger\right)q\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \Pi'\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \text{Step 2 冒頭の } \check{n}_\mu\check\psi_\mu^\dagger
   = \check\psi_\mu^\dagger) \\
&= \left(\Pi'\check\psi_\mu^\dagger\right)q
   \quad (\because \blkref{mat_mult_associative}) \\
&= \left(\check\psi_\mu^\dagger\Pi'\right)q
   \quad (\because \text{上の } \check\psi_\mu^\dagger\Pi' = \Pi'\check\psi_\mu^\dagger) \\
&= \check\psi_\mu^\dagger\left(\Pi' q\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \check\psi_\mu^\dagger q
   \quad (\because \text{上の } \Pi' q = q)
\end{aligned}`,
      ),
      paragraph([
        "Step 3（符号）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\left(\check\psi_\mu^\dagger q\right)
&= \left(\varepsilon\check\psi_\mu^\dagger\right)q
   \quad (\because \blkref{mat_mult_associative}) \\
&= \left(-\left(\check\psi_\mu^\dagger\varepsilon\right)\right)q
   \quad (\because \blkref{epsilon_anticommutes_with_check_Z_Y}\text{ (3)}) \\
&= -\left(\left(\check\psi_\mu^\dagger\varepsilon\right)q\right)
   \quad (\because \blkref{negation_factors_out_of_left_factor}) \\
&= -\left(\check\psi_\mu^\dagger\left(\varepsilon q\right)\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= -\left(\check\psi_\mu^\dagger\left(\eta_\epsilon q\right)\right)
   \quad (\because \text{(2) の冒頭の } \varepsilon q = \eta_\epsilon q) \\
&= -\left(\eta_\epsilon\left(\check\psi_\mu^\dagger q\right)\right)
   \quad (\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= \left(-1_{\mathbb{C}}\right)\left(\eta_\epsilon\left(\check\psi_\mu^\dagger q\right)\right)
   \quad (\because \blkref{negation_is_scalar_multiple_by_minus_one}) \\
&= \left(\left(-1_{\mathbb{C}}\right)\eta_\epsilon\right)\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \blkref{scalar_multiple_is_associative}) \\
&= \left(-\eta_\epsilon\right)\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \blkref{multiply_by_minus_one})
\end{aligned}`,
      ),
      paragraph([
        "一方 (1) を ",
        math(String.raw`\epsilon'`),
        " に使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\eta_{\epsilon'}\left(\check\psi_\mu^\dagger q\right)
&= \eta_{\epsilon'}\left(\check{Q}_{\epsilon'}\left(\check\psi_\mu^\dagger q\right)\right)
   \quad (\because \text{Step 2 の } \check{Q}_{\epsilon'}\left(\check\psi_\mu^\dagger q\right) = \check\psi_\mu^\dagger q) \\
&= \left(\eta_{\epsilon'}\check{Q}_{\epsilon'}\right)\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= \left(\varepsilon\check{Q}_{\epsilon'}\right)\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \text{(1) の } \varepsilon\check{Q}_{\epsilon'} = \eta_{\epsilon'}\check{Q}_{\epsilon'}) \\
&= \varepsilon\left(\check{Q}_{\epsilon'}\left(\check\psi_\mu^\dagger q\right)\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \varepsilon\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \text{Step 2 の } \check{Q}_{\epsilon'}\left(\check\psi_\mu^\dagger q\right) = \check\psi_\mu^\dagger q) \\
&= \left(-\eta_\epsilon\right)\left(\check\psi_\mu^\dagger q\right)
   \quad (\because \text{上の式変形})
\end{aligned}`,
      ),
      paragraph([
        "である。Step 1 より ",
        math(String.raw`\check\psi_\mu^\dagger q \neq 0`),
        " なので、(1) の ",
        math(String.raw`\eta\eta-1 = 0`),
        " の段と同じく 0 でない成分を比べて ",
        math(String.raw`\eta_{\epsilon'} = -\eta_\epsilon`),
        "。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`k := M_{\mathrm{col}} - |\epsilon| \in \{0,1,\dots,M_{\mathrm{col}}\}`),
        " についての帰納法で示す。",
        math(String.raw`k = 0`),
        " なら全ての ",
        math(String.raw`\mu`),
        " で ",
        math(String.raw`\epsilon_\mu = 1`),
        "、すなわち ",
        math(String.raw`\epsilon = (1,\dots,1)`),
        " であり、",
        math(String.raw`\eta_\epsilon = \eta_{(1,\dots,1)} = \eta_{(1,\dots,1)}(-1)^{0}`),
        " である。",
        math(String.raw`k \geq 1`),
        " とし、",
        math(String.raw`M_{\mathrm{col}} - |\epsilon| = k - 1`),
        " の全ての ",
        math(String.raw`\epsilon`),
        " で (3) が成り立つとする。",
        math(String.raw`k \geq 1`),
        " より ",
        math(String.raw`\epsilon_\mu = 0`),
        " なる ",
        math(String.raw`\mu`),
        " が取れ、",
        math(String.raw`\epsilon' := \epsilon[\mu\to1]`),
        " は ",
        math(String.raw`|\epsilon'| = |\epsilon| + 1`),
        "、すなわち ",
        math(String.raw`M_{\mathrm{col}} - |\epsilon'| = k - 1`),
        " を満たす。(2) の ",
        math(String.raw`\eta_{\epsilon'} = -\eta_\epsilon`),
        " の両辺に ",
        math(String.raw`-1`),
        " を掛けると ",
        math(String.raw`\eta_\epsilon = -\eta_{\epsilon'}`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\eta_\epsilon
&= -\eta_{\epsilon'}
   \quad (\because \text{(2)}) \\
&= -\left(\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon'|}\right)
   \quad (\because \text{帰納法の仮定}) \\
&= -\left(\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|-1}\right)
   \quad (\because |\epsilon'| = |\epsilon|+1) \\
&= (-1)\left(\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|-1}\right)
   \quad (\because \blkref{multiply_by_minus_one}) \\
&= \left(\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|-1}\right)(-1)
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の交換則}) \\
&= \eta_{(1,\dots,1)}\left((-1)^{M_{\mathrm{col}}-|\epsilon|-1}(-1)\right)
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の結合則}) \\
&= \eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|}
   \quad (\because \blkref{def_power_of_complex_number}\text{ の } z^{m+1} = z^m z)
\end{aligned}`,
      ),
      paragraph([
        "で、",
        math(String.raw`k`),
        " で (3) が成り立つ。",
      ]),
      paragraph([
        "(4) まず各 ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(I - 2\check{n}_\mu\right)\check{Q}_\epsilon
&= \left(I + \left(-\left(2\check{n}_\mu\right)\right)\right)\check{Q}_\epsilon
   \quad (\because \blkref{matrix_difference_is_sum_with_negation}) \\
&= I\check{Q}_\epsilon + \left(-\left(2\check{n}_\mu\right)\right)\check{Q}_\epsilon
   \quad (\because \blkref{mat_mult_distributes_over_sum_in_left_factor}) \\
&= I\check{Q}_\epsilon + \left(-\left(\left(2\check{n}_\mu\right)\check{Q}_\epsilon\right)\right)
   \quad (\because \blkref{negation_factors_out_of_left_factor}) \\
&= I\check{Q}_\epsilon - \left(2\check{n}_\mu\right)\check{Q}_\epsilon
   \quad (\because \blkref{matrix_difference_is_sum_with_negation}) \\
&= \check{Q}_\epsilon - \left(2\check{n}_\mu\right)\check{Q}_\epsilon
   \quad (\because \blkref{identity_matrix_is_left_unit_of_mat_mult}) \\
&= \check{Q}_\epsilon - 2\left(\check{n}_\mu\check{Q}_\epsilon\right)
   \quad (\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= \check{Q}_\epsilon - 2\left(\epsilon_\mu\check{Q}_\epsilon\right)
   \quad (\because \blkref{check_joint_eigenspace_decomposition}\text{ (3)}) \\
&= 1\check{Q}_\epsilon - 2\left(\epsilon_\mu\check{Q}_\epsilon\right)
   \quad (\because \blkref{scalar_multiple_by_one}) \\
&= 1\check{Q}_\epsilon - \left(2\epsilon_\mu\right)\check{Q}_\epsilon
   \quad (\because \blkref{scalar_multiple_is_associative}) \\
&= \left(1 - 2\epsilon_\mu\right)\check{Q}_\epsilon
   \quad (\because \blkref{difference_of_scalar_multiples_of_one_matrix})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`P_k := \prod_{\mu=1}^{k}\left(I - 2\check{n}_\mu\right)`),
        "、",
        math(String.raw`p_k := \prod_{\mu=1}^{k}\left(1 - 2\epsilon_\mu\right) \in \mathbb{C}`),
        "（",
        ref("def_finite_product_of_matrices"),
        "・",
        ref("def_finite_product_of_complex_numbers"),
        "、",
        math(String.raw`k \in \{1,\dots,M_{\mathrm{col}}\}`),
        "）とおき、",
        math(String.raw`P_k\check{Q}_\epsilon = p_k\check{Q}_\epsilon`),
        " を ",
        math(String.raw`k`),
        " についての帰納法で示す。",
        math(String.raw`k = 1`),
        " は上の式（",
        math(String.raw`\mu \to 1`),
        "）である。",
        math(String.raw`k < M_{\mathrm{col}}`),
        " で成り立つとすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{k+1}\check{Q}_\epsilon
&= \left(P_k\left(I - 2\check{n}_{k+1}\right)\right)\check{Q}_\epsilon
   \quad (\because \blkref{def_finite_product_of_matrices}) \\
&= P_k\left(\left(I - 2\check{n}_{k+1}\right)\check{Q}_\epsilon\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= P_k\left(\left(1 - 2\epsilon_{k+1}\right)\check{Q}_\epsilon\right)
   \quad (\because \text{上の式 } (\mu \to k+1)) \\
&= \left(1 - 2\epsilon_{k+1}\right)\left(P_k\check{Q}_\epsilon\right)
   \quad (\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= \left(1 - 2\epsilon_{k+1}\right)\left(p_k\check{Q}_\epsilon\right)
   \quad (\because \text{帰納法の仮定}) \\
&= \left(\left(1 - 2\epsilon_{k+1}\right)p_k\right)\check{Q}_\epsilon
   \quad (\because \blkref{scalar_multiple_is_associative}) \\
&= \left(p_k\left(1 - 2\epsilon_{k+1}\right)\right)\check{Q}_\epsilon
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の交換則}) \\
&= p_{k+1}\check{Q}_\epsilon
   \quad (\because \blkref{def_finite_product_of_complex_numbers})
\end{aligned}`,
      ),
      paragraph([
        "で、",
        math(String.raw`k+1`),
        " でも成り立つ。",
        math(String.raw`1 - 2\epsilon_\mu`),
        " は ",
        math(String.raw`\epsilon_\mu = 1`),
        " なら ",
        math(String.raw`-1`),
        "、",
        math(String.raw`\epsilon_\mu = 0`),
        " なら ",
        math(String.raw`+1`),
        " なので、",
        math(String.raw`p_{M_{\mathrm{col}}}`),
        " は ",
        math(String.raw`-1`),
        " を ",
        math(String.raw`|\epsilon|`),
        " 個、",
        math(String.raw`+1`),
        " を残りの個数だけ掛けたものであり ",
        math(String.raw`p_{M_{\mathrm{col}}} = (-1)^{|\epsilon|}`),
        " である。以下 ",
        math(String.raw`P := P_{M_{\mathrm{col}}}`),
        "、",
        math(String.raw`c := \eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}} \in \{+1,-1\}`),
        " とおく。(1)(3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\check{Q}_\epsilon
&= \eta_\epsilon\check{Q}_\epsilon
   \quad (\because \text{(1)}) \\
&= \left(\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|}\right)\check{Q}_\epsilon
   \quad (\because \text{(3)}) \\
&= \left(\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|}\left((-1)^{|\epsilon|}(-1)^{|\epsilon|}\right)\right)\check{Q}_\epsilon
   \quad (\because (-1)^{|\epsilon|}(-1)^{|\epsilon|} = \left((-1)(-1)\right)^{|\epsilon|} = 1^{|\epsilon|} = 1) \\
&= \left(\eta_{(1,\dots,1)}\left((-1)^{M_{\mathrm{col}}-|\epsilon|}(-1)^{|\epsilon|}\right)(-1)^{|\epsilon|}\right)\check{Q}_\epsilon
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の結合則}) \\
&= \left(\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}}(-1)^{|\epsilon|}\right)\check{Q}_\epsilon
   \quad (\because \text{非負の指数の指数法則 } z^{a}z^{b} = z^{a+b}\text{（}\blkref{def_power_of_complex_number}\text{ から } b \text{ の帰納法）}) \\
&= c\left((-1)^{|\epsilon|}\check{Q}_\epsilon\right)
   \quad (\because c\text{ の置き方と }\blkref{scalar_multiple_is_associative}) \\
&= c\left(P\check{Q}_\epsilon\right)
   \quad (\because \text{上の } P\check{Q}_\epsilon = p_{M_{\mathrm{col}}}\check{Q}_\epsilon = (-1)^{|\epsilon|}\check{Q}_\epsilon)
\end{aligned}`,
      ),
      paragraph([
        "である。和 ",
        math(String.raw`\sum_\epsilon`),
        " は ",
        ref("def_sum_over_binary_words"),
        " による。",
        ref("check_joint_eigenspace_decomposition"),
        " (2) の ",
        math(String.raw`\sum_\epsilon\check{Q}_\epsilon = I`),
        " を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon
&= \varepsilon I
   \quad (\because \blkref{identity_matrix_is_right_unit_of_mat_mult}) \\
&= \varepsilon\sum_{\epsilon}\check{Q}_\epsilon
   \quad (\because \blkref{check_joint_eigenspace_decomposition}\text{ (2)}) \\
&= \sum_{\epsilon}\varepsilon\check{Q}_\epsilon
   \quad (\because \blkref{sum_over_binary_words_distributes_in_right_factor}) \\
&= \sum_{\epsilon}c\left(P\check{Q}_\epsilon\right)
   \quad (\because \text{上の式を } 2^{M_{\mathrm{col}}} \text{ 箇所へ同時適用}) \\
&= \sum_{\epsilon}\left(cP\right)\check{Q}_\epsilon
   \quad (\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= \left(cP\right)\sum_{\epsilon}\check{Q}_\epsilon
   \quad (\because \blkref{sum_over_binary_words_distributes_in_right_factor}) \\
&= \left(cP\right)I
   \quad (\because \blkref{check_joint_eigenspace_decomposition}\text{ (2)}) \\
&= cP
   \quad (\because \blkref{identity_matrix_is_right_unit_of_mat_mult}) \\
&= \eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}}\prod_{\mu=1}^{M_{\mathrm{col}}}\left(I - 2\check{n}_\mu\right)
   \quad (\because c,\ P\text{ の置き方})
\end{aligned}`,
      ),
      paragraph([
        "で (4) を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "(4) は「ε は数演算子の言葉でパリティ Π(I − 2ň_μ) に一致する」ことを述べているが、全体の符号 η_{(1,…,1)} はこの段階では未定である。この 1 つの符号を決めるのがこの章の実質的な内容で、max_eigenvector_in_even_sector で η_{(1,…,1)} = +1 と確定し、ε = (−1)^M Π(I − 2ň_μ) となる。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-11-04（全証明の SageMath 検算）: 鎖の行の根拠の名前だけの引用（check_joint_eigenspace_decomposition (1)(3)・epsilon_anticommutes_with_check_Z_Y (3)(4)・check_number_operator_idempotent (1)(2)・check_number_operators_commute (1)(2)・「行列積の結合則」「恒等行列の定義」「零ベクトルの減法」「分配法則と差の定義」）を blkref に直し、結合則・分配（差は matrix_difference_is_sum_with_negation・matrix_difference_mul_vector 経由）・単位行列・スカラー倍の外出しを一行ずつに分けた。散文の推論を (∵) 付きの鎖にした: (1) の η² = 1 から η ∈ {±1}、「任意の x について … 行列としても」（(εQ̌_ϵ)x の鎖と mat_columnwise による列の鎖）、主張の ∃! の一意性の鎖（足した）。(2) の Step 1 の ň_μq = 0 と背理法を鎖に、Step 2 は他のブロックの証明の途中（check_joint_eigenspace_decomposition の証明の記号 R と Q̌_ϵ = ΠR）を引いていたのをやめ、Q̌_δ の定義の因子 A_ν^δ を直接使う形にした（A_μ^ϵ = I − ň_μ・A_μ^{ϵ'} = ň_μ の鎖、因子どうし・ψ̌_μ^† との可換性、Π_{ν≠μ} は def_finite_product_of_matrices_omitting_one_index と moving_one_factor_of_finite_product_to_the_end）。Step 3 の最初の行を 4 行に分け、「生成元なので (1) の一意性から」を η_{ϵ'}(ψ̌_μ^†q) の鎖と ψ̌_μ^†q ≠ 0 にした（1 次元性を使わないという証明中の注記と合わせた）。(3) の「1 つずつ取り替えていく」を k := M_col − |ϵ| の帰納法の鎖に、(4) の Π(I − 2ň_μ)Q̌_ϵ を P_k の帰納法の鎖に、定義の無い負の冪 (−1)^{−|ϵ|} を非負の冪の鎖に、「Σ_ϵ Q̌_ϵ = I を掛ければ」を ε = εI から始まる 10 行の鎖にした。主張は変えていない。計算の誤りは無かった。",
        "数値検証: sagemath/check/epsilon_eigenvalue_on_check_Q/（厳密計算。本文の ψ̌ で M_col = 2, 3、結合定数 3 組）。旧い浮動小数点の検算 sagemath/check/053_claim_even_sector_closing/check_02 も残っている。",
      ],
    },
  },
  {
    id: "closing_003_claim_trace_epsilon_V_plus_via_eigenvalues",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 5 },
    title: {
      tex: String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
\text{ を } \eta_{(1,\dots,1)} \text{ で表す}`,
    },
    labels: ["trace_of_epsilon_V_plus_via_check_eigenvalues"],
    statement: [
      paragraph([
        ref("epsilon_eigenvalue_on_check_Q"),
        " の ",
        math(String.raw`\eta_{(1,\dots,1)}`),
        " と ",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\varepsilon\,V^{(+)}\right)
= \eta_{(1,\dots,1)}\,(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\prod_{\mu=1}^{M_{\mathrm{col}}}2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)`,
      ),
      paragraph([
        "が成り立つ。",
        ref("gamma_theta_tilde_mu_positive"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " と ",
        math(String.raw`K_2 > 0`),
        " より右辺の ",
        math(String.raw`\eta_{(1,\dots,1)}`),
        " 以外の因子はすべて**正の実数**なので、",
      ]),
      displayMath(
        String.raw`\eta_{(1,\dots,1)} = +1 \iff \mathrm{tr}\!\left(\varepsilon V^{(+)}\right) > 0`,
      ),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "Step 1（トレースの分解）。",
        ref("check_joint_eigenspace_decomposition"),
        " (2) の ",
        math(String.raw`\sum_\epsilon\check{Q}_\epsilon = I`),
        "、",
        ref("eigenvalues_of_V_plus"),
        " (1) の ",
        math(String.raw`V^{(+)}\check{Q}_\epsilon = \check\Lambda_\epsilon\check{Q}_\epsilon`),
        "、",
        ref("epsilon_eigenvalue_on_check_Q"),
        " (1) の ",
        math(String.raw`\varepsilon\check{Q}_\epsilon = \eta_\epsilon\check{Q}_\epsilon`),
        "、および ",
        ref("check_joint_eigenspace_decomposition"),
        " (4) の ",
        math(String.raw`\mathrm{tr}(\check{Q}_\epsilon) = 1`),
        " を使う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&= \mathrm{tr}\!\left(\varepsilon V^{(+)}
   \sum_{\epsilon\in\{0,1\}^{\check{\mathcal{M}}}}\check{Q}_\epsilon\right)
   \quad (\because \text{check\_joint\_eigenspace\_decomposition (2)}) \\
&= \sum_{\epsilon}\mathrm{tr}\!\left(\varepsilon V^{(+)}\check{Q}_\epsilon\right)
   \quad (\because \text{trace\_basic\_properties (1) の線型性}) \\
&= \sum_{\epsilon}\check\Lambda_\epsilon\,
   \mathrm{tr}\!\left(\varepsilon\check{Q}_\epsilon\right)
   \quad (\because \text{eigenvalues\_of\_V\_plus (1)}) \\
&= \sum_{\epsilon}\check\Lambda_\epsilon\,\eta_\epsilon\,
   \mathrm{tr}\!\left(\check{Q}_\epsilon\right)
   \quad (\because \text{epsilon\_eigenvalue\_on\_check\_Q (1)}) \\
&= \sum_{\epsilon\in\{0,1\}^{\check{\mathcal{M}}}}\eta_\epsilon\,\check\Lambda_\epsilon
   \quad (\because \text{check\_joint\_eigenspace\_decomposition (4)})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（積への分解）。",
        ref("epsilon_eigenvalue_on_check_Q"),
        " (3) より ",
        math(String.raw`\eta_\epsilon = \eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|}`),
        " であり、",
        ref("eigenvalues_of_V_plus"),
        " の ",
        math(String.raw`\check\Lambda_\epsilon = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\!\left(\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\left(\epsilon_\mu-\tfrac12\right)\right)`),
        " である。",
        math(String.raw`(-1)^{M_{\mathrm{col}}-|\epsilon|} = \prod_{\mu=1}^{M_{\mathrm{col}}}(-1)^{1-\epsilon_\mu}`),
        "（",
        math(String.raw`\sum_\mu(1-\epsilon_\mu) = M_{\mathrm{col}} - |\epsilon|`),
        "）と ",
        ref("theorem_exp_product"),
        "（",
        math(String.raw`n=1`),
        "、すなわち実数の指数法則）を使うと",
      ]),
      displayMath(
        String.raw`\eta_\epsilon\,\check\Lambda_\epsilon
= \eta_{(1,\dots,1)}\,(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\prod_{\mu=1}^{M_{\mathrm{col}}}\left((-1)^{1-\epsilon_\mu}
\exp\!\left(\gamma(\tilde\theta_\mu)\left(\epsilon_\mu-\tfrac12\right)\right)\right)`,
      ),
      paragraph([
        math(String.raw`\epsilon`),
        " は各成分を独立に ",
        math(String.raw`0`),
        " か ",
        math(String.raw`1`),
        " から選ぶので、",
        ref("trace_of_check_Vprime"),
        " の Step 2 と同じ 1 対 1 対応（有限個の因子の積の展開）により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\epsilon}\eta_\epsilon\check\Lambda_\epsilon
&= \eta_{(1,\dots,1)}(2\sinh 2K_2)^{M_{\mathrm{col}}/2}\prod_{\mu=1}^{M_{\mathrm{col}}}
   \left(-\exp\!\left(-\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)
   + \exp\!\left(+\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)\right)
   \quad (\because \text{有限個の因子の積の展開}) \\
&= \eta_{(1,\dots,1)}(2\sinh 2K_2)^{M_{\mathrm{col}}/2}\prod_{\mu=1}^{M_{\mathrm{col}}}
   2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
   \quad \left(\because \sinh x = \frac{\exp(x)-\exp(-x)}{2}\right)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\epsilon_\mu = 0`),
        " の項が ",
        math(String.raw`(-1)^{1}\exp(-\gamma/2)`),
        "、",
        math(String.raw`\epsilon_\mu = 1`),
        " の項が ",
        math(String.raw`(-1)^{0}\exp(+\gamma/2)`),
        " である。）Step 1 と合わせて主張の等式を得る。",
      ]),
      paragraph([
        "Step 3（符号）。",
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`2\sinh 2K_2 > 0`),
        " なので ",
        math(String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2} > 0`),
        "。",
        ref("gamma_theta_tilde_mu_positive"),
        " より ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " であり ",
        math(String.raw`\sinh`),
        " は ",
        math(String.raw`\mathbb{R}_{>0}`),
        " 上で正の値を取る（",
        ref("cosh_sinh_basic_properties"),
        "）ので各因子 ",
        math(String.raw`2\sinh(\gamma(\tilde\theta_\mu)/2) > 0`),
        "。よって ",
        math(String.raw`\mathrm{tr}(\varepsilon V^{(+)})`),
        " の符号は ",
        math(String.raw`\eta_{(1,\dots,1)}`),
        " の符号に一致し、",
        math(String.raw`\eta_{(1,\dots,1)} \in \{+1,-1\}`),
        " なので主張の同値が従う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "trace_of_check_Vprime が Σ_ε Λ̌_ε = Π 2cosh(γ/2) を与えるのと対をなす計算で、符号 η_ε が入ることで cosh が sinh に変わる。γ(θ~_μ) > 0（半整数運動量に固有）なので sinh の積が 0 にならないのが要点である。整数運動量では臨界点で γ(θ_M) = 0 になりうるため、この論法はそのままでは使えない。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_03。",
      ],
    },
  },
  {
    id: "closing_definition_D0_open_chain_operator",
    kind: "definition",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 6 },
    title: { tex: String.raw`\text{開鎖項 } D_0` },
    labels: ["def_D0_open_chain_operator"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_transfer_matrix_symbols"),
        " のサイト作用素を用いて、開鎖項を",
      ]),
      displayMath(String.raw`D_0 := \sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z`),
      paragraph(["と定める。"]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "closing_definition_G_boundary_operator",
    kind: "definition",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 6 },
    title: { tex: String.raw`\text{周期境界項 } G` },
    labels: ["def_G_boundary_operator"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_transfer_matrix_symbols"),
        " のサイト作用素を用いて、周期境界項を",
      ]),
      displayMath(String.raw`G := \sigma_{M_{\mathrm{col}}}^z\sigma_1^z`),
      paragraph(["と定める。"]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "closing_004_claim_H1_plus_in_sigma_z_form",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 6 },
    title: {
      tex: String.raw`i H_1^{(+)} = \sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z
+ \varepsilon\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z`,
    },
    labels: ["H1_plus_in_sigma_z_form"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)} = Y_1Z_2 + Y_2Z_3 + \cdots + Y_{M_{\mathrm{col}}-1}Z_{M_{\mathrm{col}}} - Y_{M_{\mathrm{col}}}Z_1`),
        "、",
        ref("def_D0_open_chain_operator"),
        " の開鎖項 ",
        math(String.raw`D_0`),
        "、",
        ref("def_G_boundary_operator"),
        " の周期境界項 ",
        math(String.raw`G`),
        " について",
      ]),
      displayMath(String.raw`i\,H_1^{(+)} = D_0 + \varepsilon G`),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("pauli_matrix_products"),
        " と ",
        ref("V1_in_Z_Y_epsilon"),
        " の Step 0 で確かめられている 1 サイトの積",
      ]),
      displayMath(
        String.raw`\sigma^y\sigma^x = -i\,\sigma^z, \qquad
\sigma^x\sigma^z = -i\,\sigma^y, \qquad
\sigma^x\sigma^x = I_{\mathrm{Mat}(2,\mathbb{C})}`,
      ),
      paragraph([
        "を使う（",
        math(String.raw`\sigma^x\sigma^z = -i\sigma^y`),
        " は ",
        math(String.raw`\sigma^z\sigma^y = -i\sigma^x`),
        " と同じく 2 次の成分計算（",
        ref("mat_mult"),
        "）で確かめられる：",
        math(String.raw`\begin{pmatrix}0&1\\1&0\end{pmatrix}
\begin{pmatrix}1&0\\0&-1\end{pmatrix}
= \begin{pmatrix}0&-1\\1&0\end{pmatrix}
= -i\begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        "）。また ",
        ref("kronecker_product_rule"),
        " (1) より**相異なるサイトに置かれた因子どうしは可換**である。",
      ]),
      paragraph([
        "まず ",
        math(String.raw`1 \leq m \leq M_{\mathrm{col}}-1`),
        " とする。",
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        "、",
        math(String.raw`Z_{m+1} = \sigma_1^x\cdots\sigma_m^x\sigma_{m+1}^z`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_mZ_{m+1}
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y\right)
   \left(\sigma_1^x\cdots\sigma_{m}^x\sigma_{m+1}^z\right)
   \quad (\because \text{def\_transfer\_matrix\_symbols}) \\
&= \left(\sigma_1^x\sigma_1^x\right)\cdots
   \left(\sigma_{m-1}^x\sigma_{m-1}^x\right)
   \left(\sigma_m^y\sigma_m^x\right)\sigma_{m+1}^z
   \quad (\because \text{相異なるサイトの因子は可換, kronecker\_product\_rule (1)}) \\
&= \left(\sigma_m^y\sigma_m^x\right)\sigma_{m+1}^z
   \quad (\because \sigma^x\sigma^x = I \text{ を } m-1 \text{ 箇所へ同時適用}) \\
&= \left(-i\,\sigma_m^z\right)\sigma_{m+1}^z
   \quad (\because \sigma^y\sigma^x = -i\sigma^z) \\
&= -i\,\sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{スカラー倍と行列積の結合律})
\end{aligned}`,
      ),
      paragraph([
        "両辺に ",
        math(String.raw`i`),
        " を掛けて ",
        math(String.raw`i\,Y_mZ_{m+1} = \sigma_m^z\sigma_{m+1}^z`),
        "（",
        math(String.raw`i\cdot(-i) = 1`),
        "）。",
      ]),
      paragraph([
        "次に境界項を計算する。",
        math(String.raw`Y_{M_{\mathrm{col}}} = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\sigma_{M_{\mathrm{col}}}^y`),
        "、",
        math(String.raw`Z_1 = \sigma_1^z`),
        " である。まず左辺を計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_{M_{\mathrm{col}}}Z_1
&= \left(\sigma_1^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\sigma_{M_{\mathrm{col}}}^y\right)\sigma_1^z
   \quad (\because \text{def\_transfer\_matrix\_symbols}) \\
&= \left(\sigma_1^x\sigma_1^z\right)\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\,\sigma_{M_{\mathrm{col}}}^y
   \quad (\because \text{相異なるサイトの因子は可換}) \\
&= \left(-i\,\sigma_1^y\right)\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\,\sigma_{M_{\mathrm{col}}}^y
   \quad (\because \sigma^x\sigma^z = -i\sigma^y) \\
&= -i\,\sigma_1^y\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\sigma_{M_{\mathrm{col}}}^y
   \quad (\because \text{スカラー倍と行列積の結合律})
\end{aligned}`,
      ),
      paragraph(["次に右辺を計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&= \left(\sigma_1^x\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}}^x\right)\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
   \quad (\because \text{def\_transfer\_matrix\_symbols の } \varepsilon) \\
&= \left(\sigma_1^x\sigma_1^z\right)\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x
   \left(\sigma_{M_{\mathrm{col}}}^x\sigma_{M_{\mathrm{col}}}^z\right)
   \quad (\because \text{相異なるサイトの因子は可換}) \\
&= \left(-i\,\sigma_1^y\right)\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x
   \left(-i\,\sigma_{M_{\mathrm{col}}}^y\right)
   \quad (\because \sigma^x\sigma^z = -i\sigma^y \text{ を 2 箇所へ同時適用}) \\
&= -\,\sigma_1^y\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\sigma_{M_{\mathrm{col}}}^y
   \quad (\because (-i)^2 = -1)
\end{aligned}`,
      ),
      paragraph([
        "上の 2 つの計算結果を突き合わせる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
-i\,Y_{M_{\mathrm{col}}}Z_1
&= -i\left(-i\,\sigma_1^y\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\sigma_{M_{\mathrm{col}}}^y\right)
   \quad (\because \text{直前の } Y_{M_{\mathrm{col}}}Z_1 \text{ の計算}) \\
&= -\,\sigma_1^y\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\sigma_{M_{\mathrm{col}}}^y
   \quad \left(\because (-i)^2 = -1\right) \\
&= \varepsilon\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
   \quad (\because \text{直前の } \varepsilon\sigma_{M_{\mathrm{col}}}^z\sigma_1^z \text{ の計算})
\end{aligned}`,
      ),
      paragraph([
        "最後に ",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}`),
        " に直前の二つの計算を一つずつ適用する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
i\,H_1^{(+)}
&= i\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1\right)
   \quad (\because \text{def\_H1\_plus}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left(i\,Y_mZ_{m+1}\right) + \left(-i\,Y_{M_{\mathrm{col}}}Z_1\right)
   \quad (\because \text{スカラー倍の分配法則}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z + \left(-i\,Y_{M_{\mathrm{col}}}Z_1\right)
   \quad (\because \text{直前に示した内部辺の等式を有限和へ適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z + \varepsilon\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
   \quad (\because \text{直前に示した境界項の等式}) \\
&= D_0 + \varepsilon\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
   \quad (\because \text{def\_D0\_open\_chain\_operator}) \\
&= D_0 + \varepsilon G
   \quad (\because \text{def\_G\_boundary\_operator})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "V1_in_Z_Y_epsilon は V_1 = exp(iK_1(Y_1Z_2+⋯+Y_{M-1}Z_M − εY_MZ_1)) を主張しており、この表示はその指数の中身を σ^z の言葉へ戻したものにあたる。右辺は F^{(+)} 上（ε = +1）で K_1 D の 1/K_1 倍に一致し、F^{(-)} 上では最後の項の符号が反転する。これが V^{(+)} が「周期境界」、V^{(-)} が「反周期境界」に対応する具体的な形である。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,3,4,5 で残差 0.0）。",
      ],
    },
  },
  {
    id: "closing_claim_D0_G_diagonal_action",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 6 },
    title: { tex: String.raw`D_0, G \text{ の配置基底上の対角作用}` },
    labels: ["D0_G_diagonal_action"],
    statement: [
      paragraph([
        ref("def_config_basis_iso"),
        " の基底 ",
        math(String.raw`f_{\iota(s)}`),
        "（",
        math(String.raw`s\in\mathfrak M`),
        "）に対し、",
        ref("def_D0_open_chain_operator"),
        " の ",
        math(String.raw`D_0`),
        " と ",
        ref("def_G_boundary_operator"),
        " の ",
        math(String.raw`G`),
        " は次のように作用する。",
      ]),
      displayMath(String.raw`D_0 f_{\iota(s)}
=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}s(m)s(m+1)\right)f_{\iota(s)},
\qquad
G f_{\iota(s)}=s(M_{\mathrm{col}})s(1)f_{\iota(s)}`),
      paragraph([
        "ここでスピン配置を ",
        math(String.raw`s`),
        " と書くのは、",
        math(String.raw`\mu`),
        " を ",
        math(String.raw`\check{\mathcal{M}}`),
        " の元に使うためである。",
      ]),
    ],
    proof: [
      paragraph([
        ref("sigma_z_diagonal_action"),
        " より、各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}-1\}`),
        " について一サイトずつ作用させると",
      ]),
      displayMath(String.raw`\begin{aligned}
(\sigma_m^z\sigma_{m+1}^z)f_{\iota(s)}
&=\sigma_m^z\bigl(s(m+1)f_{\iota(s)}\bigr)
&&\bigl(\because\ \text{sigma\_z\_diagonal\_action を }m+1\text{ に適用}\bigr)\\
&=s(m+1)\sigma_m^zf_{\iota(s)}
&&\bigl(\because\ \text{行列作用の複素線型性}\bigr)\\
&=s(m+1)\bigl(s(m)f_{\iota(s)}\bigr)
&&\bigl(\because\ \text{sigma\_z\_diagonal\_action を }m\text{ に適用}\bigr)\\
&=\bigl(s(m+1)s(m)\bigr)f_{\iota(s)}
&&\bigl(\because\ \text{スカラー倍の結合律}\bigr)\\
&=s(m)s(m+1)f_{\iota(s)}
&&\bigl(\because\ \text{実数の積の交換律}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
D_0f_{\iota(s)}
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)f_{\iota(s)}
&&\bigl(\because\ \text{def\_D0\_open\_chain\_operator}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}(\sigma_m^z\sigma_{m+1}^z)f_{\iota(s)}
&&\bigl(\because\ \text{行列作用の有限和への分配法則}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}s(m)s(m+1)f_{\iota(s)}
&&\bigl(\because\ \text{直前の各 }m\text{ の等式}\bigr)\\
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}s(m)s(m+1)\right)f_{\iota(s)}
&&\bigl(\because\ \text{ベクトルの有限和の分配法則}\bigr).
\end{aligned}`),
      paragraph(["境界項にも同じ一サイト作用を二回適用する。"]),
      displayMath(String.raw`\begin{aligned}
Gf_{\iota(s)}
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)f_{\iota(s)}
&&\bigl(\because\ \text{def\_G\_boundary\_operator}\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl(s(1)f_{\iota(s)}\bigr)
&&\bigl(\because\ \text{sigma\_z\_diagonal\_action を }1\text{ に適用}\bigr)\\
&=s(1)\sigma_{M_{\mathrm{col}}}^zf_{\iota(s)}
&&\bigl(\because\ \text{行列作用の複素線型性}\bigr)\\
&=s(1)\bigl(s(M_{\mathrm{col}})f_{\iota(s)}\bigr)
&&\bigl(\because\ \text{sigma\_z\_diagonal\_action を }M_{\mathrm{col}}\text{ に適用}\bigr)\\
&=\bigl(s(1)s(M_{\mathrm{col}})\bigr)f_{\iota(s)}
&&\bigl(\because\ \text{スカラー倍の結合律}\bigr)\\
&=s(M_{\mathrm{col}})s(1)f_{\iota(s)}
&&\bigl(\because\ \text{実数の積の交換律}\bigr).
\end{aligned}`),
    ],
    conversion: { status: "added" },
  },
  {
    id: "closing_claim_epsilon_D0_G_pairwise_commute",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 6 },
    title: { tex: String.raw`\varepsilon, D_0, G \text{ の二つずつの可換性}` },
    labels: ["epsilon_D0_G_pairwise_commute"],
    statement: [
      paragraph([
        ref("def_D0_open_chain_operator"),
        " の ",
        math(String.raw`D_0`),
        " と ",
        ref("def_G_boundary_operator"),
        " の ",
        math(String.raw`G`),
        " は ",
        math(String.raw`\varepsilon`),
        " と二つずつ可換である。すなわち",
      ]),
      displayMath(String.raw`\varepsilon D_0 = D_0\varepsilon, \qquad
\varepsilon G = G\varepsilon, \qquad D_0G = GD_0`),
    ],
    proof: [
      paragraph([
        ref("epsilon_anticommutes_with_site_sigma_z"),
        " より、各 ",
        math(String.raw`k \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\varepsilon\sigma_k^z=-\sigma_k^z\varepsilon`),
        " である。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}-1\}`),
        " に対して二回の反可換移動を一回ずつ行うと",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon(\sigma_m^z\sigma_{m+1}^z)
&=(\varepsilon\sigma_m^z)\sigma_{m+1}^z
&&\bigl(\because\ \text{行列の積の結合律}\bigr)\\
&=(-\sigma_m^z\varepsilon)\sigma_{m+1}^z
&&\bigl(\because\ \varepsilon\sigma_m^z=-\sigma_m^z\varepsilon\bigr)\\
&=-\sigma_m^z(\varepsilon\sigma_{m+1}^z)
&&\bigl(\because\ \text{行列の積の結合律}\bigr)\\
&=-\sigma_m^z(-\sigma_{m+1}^z\varepsilon)
&&\bigl(\because\ \varepsilon\sigma_{m+1}^z=-\sigma_{m+1}^z\varepsilon\bigr)\\
&=\sigma_m^z(\sigma_{m+1}^z\varepsilon)
&&\bigl(\because\ (-1)(-1)=1\bigr)\\
&=(\sigma_m^z\sigma_{m+1}^z)\varepsilon
&&\bigl(\because\ \text{行列の積の結合律}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\varepsilon D_0
&=\varepsilon\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)
&&\bigl(\because\ \text{def\_D0\_open\_chain\_operator}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}\varepsilon(\sigma_m^z\sigma_{m+1}^z)
&&\bigl(\because\ \text{行列積の有限和への分配法則}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}(\sigma_m^z\sigma_{m+1}^z)\varepsilon
&&\bigl(\because\ \text{直前の各 }m\text{ の等式}\bigr)\\
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)\varepsilon
&&\bigl(\because\ \text{行列積の有限和への分配法則}\bigr)\\
&=D_0\varepsilon
&&\bigl(\because\ \text{def\_D0\_open\_chain\_operator}\bigr).
\end{aligned}`),
      paragraph(["境界の二サイトについても同じ二回の反可換移動を行う。"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon G
&=\varepsilon(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)
&&\bigl(\because\ \text{def\_G\_boundary\_operator}\bigr)\\
&=(\varepsilon\sigma_{M_{\mathrm{col}}}^z)\sigma_1^z
&&\bigl(\because\ \text{行列の積の結合律}\bigr)\\
&=(-\sigma_{M_{\mathrm{col}}}^z\varepsilon)\sigma_1^z
&&\bigl(\because\ \varepsilon\sigma_{M_{\mathrm{col}}}^z=-\sigma_{M_{\mathrm{col}}}^z\varepsilon\bigr)\\
&=-\sigma_{M_{\mathrm{col}}}^z(\varepsilon\sigma_1^z)
&&\bigl(\because\ \text{行列の積の結合律}\bigr)\\
&=-\sigma_{M_{\mathrm{col}}}^z(-\sigma_1^z\varepsilon)
&&\bigl(\because\ \varepsilon\sigma_1^z=-\sigma_1^z\varepsilon\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z(\sigma_1^z\varepsilon)
&&\bigl(\because\ (-1)(-1)=1\bigr)\\
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)\varepsilon
&&\bigl(\because\ \text{行列の積の結合律}\bigr)\\
&=G\varepsilon
&&\bigl(\because\ \text{def\_G\_boundary\_operator}\bigr).
\end{aligned}`),
      paragraph([
        ref("kronecker_product_rule"),
        " (1) より、相異なるサイトの因子は可換し、同じサイトに現れる因子はいずれも ",
        math(String.raw`\sigma^z`),
        " なので、各サイトの因子を並べ替えると、各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}-1\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(\sigma_m^z\sigma_{m+1}^z)G
&=(\sigma_m^z\sigma_{m+1}^z)(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)
&&\bigl(\because\ \text{def\_G\_boundary\_operator}\bigr)\\
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)(\sigma_m^z\sigma_{m+1}^z)
&&\bigl(\because\ \text{kronecker\_product\_rule (1) を各サイトへ適用}\bigr)\\
&=G(\sigma_m^z\sigma_{m+1}^z)
&&\bigl(\because\ \text{def\_G\_boundary\_operator}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
D_0G
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)G
&&\bigl(\because\ \text{def\_D0\_open\_chain\_operator}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}(\sigma_m^z\sigma_{m+1}^z)G
&&\bigl(\because\ \text{行列積の有限和への分配法則}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}G(\sigma_m^z\sigma_{m+1}^z)
&&\bigl(\because\ \text{直前の各 }m\text{ の等式}\bigr)\\
&=G\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)
&&\bigl(\because\ \text{行列積の有限和への分配法則}\bigr)\\
&=GD_0
&&\bigl(\because\ \text{def\_D0\_open\_chain\_operator}\bigr).
\end{aligned}`),
    ],
    conversion: { status: "added" },
  },
  {
    id: "closing_claim_epsilon_G_is_involution",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 6 },
    title: { tex: String.raw`\varepsilon G \text{ の二乗}` },
    labels: ["epsilon_G_is_involution"],
    statement: [
      paragraph([
        ref("def_G_boundary_operator"),
        " で定めた ",
        math(String.raw`G`),
        " について",
      ]),
      displayMath(String.raw`(\varepsilon G)^2=I`),
    ],
    proof: [
      paragraph([
        ref("epsilon_D0_G_pairwise_commute"),
        " の ",
        math(String.raw`\varepsilon G=G\varepsilon`),
        "、",
        ref("epsilon_square_and_eigenvalues"),
        " の ",
        math(String.raw`\varepsilon^2=I`),
        "、および ",
        ref("pauli_matrix_products"),
        " と ",
        ref("kronecker_product_rule"),
        " による ",
        math(String.raw`(\sigma_k^z)^2=I`),
        " を一行ずつ用いる。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\varepsilon G)^2
&= \varepsilon G\varepsilon G
&&\bigl(\because\ \text{二乗の定義}\bigr)\\
&= \varepsilon^2G^2
&&\bigl(\because\ \text{epsilon\_D0\_G\_pairwise\_commute の }\varepsilon G=G\varepsilon\bigr)\\
&= I\,G^2
&&\bigl(\because\ \text{epsilon\_projector\_properties (1) の }\varepsilon^2=I\bigr)\\
&= I(\sigma_{M_{\mathrm{col}}}^z)^2(\sigma_1^z)^2
&&\bigl(\because\ G=\sigma_{M_{\mathrm{col}}}^z\sigma_1^z\text{ と相異なるサイトの因子の可換性}\bigr)\\
&= I\cdot I\cdot I
&&\bigl(\because\ \text{pauli\_matrix\_products の }(\sigma^z)^2=I\bigr)\\
&= I
&&\bigl(\because\ \text{単位行列の積}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "closing_005_definition_open_chain_spin_energy",
    kind: "definition",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 7 },
    title: { text: "1 次元開鎖のスピン配置とエネルギー" },
    labels: ["def_open_chain_spin_energy"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_row_configurations"),
        " の ",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,M_{\mathrm{col}}\},\{-1,1\})`),
        " を用いる。各 ",
        math(String.raw`s\in\mathfrak M`),
        " に対して、1次元開鎖のエネルギーを",
      ]),
      displayMath(
        String.raw`E(s) := \sum_{m=1}^{M_{\mathrm{col}}-1}s(m)\,s(m+1) \in \mathbb{Z}
\qquad (s \in \mathfrak{M})`,
      ),
      paragraph(["と定める。"])],
    conversion: {
      status: "added",
      notes: [
        "転送行列の行長 N を M と読み替えることと、開鎖エネルギーの共通記法を独立した定義にした。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。読み替えの断り書きを除き、𝔐 の参照先を <def_row_configurations> にした。",
      ],
    },
  },
  {
    id: "closing_005_claim_open_chain_partition_sum",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 7 },
    title: { text: "端点因子のない1次元開鎖のスピン和" },
    labels: ["open_chain_partition_sum"],
    statement: [
      paragraph([
        ref("def_open_chain_spin_energy"),
        " の記号を用い、",
        math(String.raw`K\in\mathbb R`),
        " とする。このとき",
      ]),
      displayMath(String.raw`\sum_{s\in\mathfrak M}\exp(K E(s))
=2\left(2\cosh K\right)^{M_{\mathrm{col}}-1}`),
      paragraph([
        "が成り立つ。（指数評価による ",
        math(String.raw`\mathbb R`),
        " 脱出）ここでは実数値の指数関数を用いる。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（変数変換）。写像",
      ]),
      displayMath(
        String.raw`\Phi : \mathfrak{M} \longrightarrow \{-1,1\}\times\{-1,1\}^{M_{\mathrm{col}}-1},
\qquad
\Phi(s) := \left(s(1);\ t_1,\dots,t_{M_{\mathrm{col}}-1}\right), \quad t_m := s(m)s(m+1)`,
      ),
      paragraph([
        "は全単射である。実際、",
        math(String.raw`(s(1); t_1,\dots,t_{M_{\mathrm{col}}-1})`),
        " が与えられれば ",
        math(String.raw`s(m+1) = s(m)t_m`),
        " により ",
        math(String.raw`s(2),\dots,s(M_{\mathrm{col}})`),
        " が順に一意に定まり（",
        math(String.raw`s(m)s(m) = 1`),
        " なので ",
        math(String.raw`t_m = s(m)s(m+1)`),
        " と同値）、逆にこの手続きで作った ",
        math(String.raw`s`),
        " は ",
        math(String.raw`\Phi(s)`),
        " として元の組を与えるからである。両側の集合はともに ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 個の元をもつ。",
      ]),
      paragraph([
        "Step 2（スピン和の計算）。",
        math(String.raw`E(s) = \sum_{m=1}^{M_{\mathrm{col}}-1}t_m`),
        " なので、",
        ref("theorem_exp_product"),
        "（",
        math(String.raw`n=1`),
        "、実数の指数法則）より ",
        math(String.raw`\exp(KE(s)) = \prod_{m=1}^{M_{\mathrm{col}}-1}\exp(Kt_m)`),
        " である。Step 1 の全単射で和を書き換えると",
      ]),
      paragraph([ref("def_cosh_sinh"), " より、最後から二つ目の等号が成り立つ。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak{M}}\exp(KE(s))
&= \sum_{s(1)\in\{-1,1\}}\ \sum_{t_1,\dots,t_{M_{\mathrm{col}}-1}\in\{-1,1\}}
   \prod_{m=1}^{M_{\mathrm{col}}-1}\exp(Kt_m)
   \quad (\because \text{Step 1 の全単射}) \\
&= \left(\sum_{s(1)\in\{-1,1\}}1\right)
   \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\sum_{t_m\in\{-1,1\}}\exp(Kt_m)\right)
   \quad (\because \text{有限個の因子の積の展開（各 } t_m \text{ は独立に走る）}) \\
&= 2\prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)+\exp(-K)\right)
   \quad (\because \text{二元集合 }\{-1,1\}\text{ 上の二つの有限和を計算}) \\
&= 2\prod_{m=1}^{M_{\mathrm{col}}-1}\left(2\cosh K\right)
   \quad \left(\because \text{双曲線余弦の定義}\right) \\
&= 2\left(2\cosh K\right)^{M_{\mathrm{col}}-1}
   \quad (\because \text{同じ因子 }2\cosh K\text{ の }M_{\mathrm{col}}-1\text{ 個の積})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: ["数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,…,8 の全配置を直接列挙）。"],
    },
  },
  {
    id: "closing_005_claim_open_chain_endpoint_product_sum",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 7 },
    title: { text: "両端のスピンの積を掛けた1次元開鎖のスピン和" },
    labels: ["open_chain_endpoint_product_sum"],
    statement: [
      paragraph([
        ref("def_open_chain_spin_energy"),
        " の記号を用い、",
        math(String.raw`K\in\mathbb R`),
        " とする。このとき",
      ]),
      displayMath(String.raw`\sum_{s\in\mathfrak M}s(M_{\mathrm{col}})s(1)\exp(K E(s))
=2\left(2\sinh K\right)^{M_{\mathrm{col}}-1}`),
      paragraph([
        "が成り立つ。（指数評価による ",
        math(String.raw`\mathbb R`),
        " 脱出）ここでは実数値の指数関数を用いる。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（変数変換）。写像",
      ]),
      displayMath(
        String.raw`\Phi : \mathfrak{M} \longrightarrow \{-1,1\}\times\{-1,1\}^{M_{\mathrm{col}}-1},
\qquad
\Phi(s) := \left(s(1);\ t_1,\dots,t_{M_{\mathrm{col}}-1}\right), \quad t_m := s(m)s(m+1)`,
      ),
      paragraph([
        "は全単射である。実際、",
        math(String.raw`(s(1);t_1,\dots,t_{M_{\mathrm{col}}-1})`),
        " から漸化式 ",
        math(String.raw`s(m+1)=s(m)t_m`),
        " によって ",
        math(String.raw`s(2),\dots,s(M_{\mathrm{col}})`),
        " が一意に復元され、この復元は ",
        math(String.raw`t_m=s(m)s(m+1)`),
        " の逆写像になる。",
      ]),
      paragraph([
        "Step 2（端点因子の書き替え）。",
        math(String.raw`s(m)s(m) = 1`),
        " を繰り返し使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\prod_{m=1}^{M_{\mathrm{col}}-1}t_m
&= \prod_{m=1}^{M_{\mathrm{col}}-1}s(m)s(m+1)
&&\bigl(\because\ t_m:=s(m)s(m+1)\bigr)\\
&= s(1)\left(\prod_{m=2}^{M_{\mathrm{col}}-1}s(m)s(m)\right)s(M_{\mathrm{col}})
&&\bigl(\because\ \mathbb R\text{ の乗法の可換性と結合性}\bigr)\\
&= s(1)\left(\prod_{m=2}^{M_{\mathrm{col}}-1}1\right)s(M_{\mathrm{col}})
&&\bigl(\because\ s(m)s(m)=1\text{ を各 }m\text{ へ同時適用}\bigr)\\
&= s(1)s(M_{\mathrm{col}})
&&\bigl(\because\ \text{有限積の単位元}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である（隣接する因子が対になって ",
        math(String.raw`1`),
        " になる）。また ",
        ref("theorem_exp_product"),
        "（",
        math(String.raw`n=1`),
        "、実数の指数法則）より ",
        math(String.raw`\exp(KE(s))=\prod_{m=1}^{M_{\mathrm{col}}-1}\exp(Kt_m)`),
        " である。したがって",
      ]),
      paragraph([ref("def_cosh_sinh"), " より、最後から二つ目の等号が成り立つ。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak{M}}s(M_{\mathrm{col}})s(1)\exp(KE(s))
&= \sum_{s(1)\in\{-1,1\}}\ \sum_{t_1,\dots,t_{M_{\mathrm{col}}-1}\in\{-1,1\}}
   \left(\prod_{m=1}^{M_{\mathrm{col}}-1}t_m\right)\prod_{m=1}^{M_{\mathrm{col}}-1}\exp(Kt_m)
   \quad (\because \text{Step 1 の全単射と直前の等式}) \\
&= \left(\sum_{s(1)\in\{-1,1\}}1\right)
   \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\sum_{t_m\in\{-1,1\}}t_m\,\exp(Kt_m)\right)
   \quad (\because \text{有限個の因子の積の展開}) \\
&= 2\prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)-\exp(-K)\right)
   \quad (\because \text{二元集合 }\{-1,1\}\text{ 上の二つの有限和を計算}) \\
&= 2\prod_{m=1}^{M_{\mathrm{col}}-1}\left(2\sinh K\right)
   \quad \left(\because \text{双曲線正弦の定義}\right) \\
&= 2\left(2\sinh K\right)^{M_{\mathrm{col}}-1}
   \quad (\because \text{同じ因子 }2\sinh K\text{ の }M_{\mathrm{col}}-1\text{ 個の積})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: ["数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,…,8 の全配置を直接列挙）。"],
    },
  },
  {
    id: "closing_005_claim_open_chain_spin_sums_positive",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 7 },
    title: { text: "1次元開鎖の二つのスピン和の正値性" },
    labels: ["open_chain_spin_sums_positive"],
    statement: [
      paragraph([
        ref("def_open_chain_spin_energy"),
        " の ",
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        " を用い、",
        math(String.raw`K\in\mathbb R_{>0}`),
        " とする。このとき ",
        ref("open_chain_partition_sum"),
        " と ",
        ref("open_chain_endpoint_product_sum"),
        " の二つのスピン和は、ともに正の実数である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak M}\exp(K E(s))
&=2\left(2\cosh K\right)^{M_{\mathrm{col}}-1}
   \quad (\because \blkref{open_chain_partition_sum}) \\
&>0
   \quad (\because \blkref{cosh_sinh_basic_properties}\text{、}
   \cosh K>0\text{、}M_{\mathrm{col}}-1\in\mathbb Z_{>0})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak M}s(M_{\mathrm{col}})s(1)\exp(K E(s))
&=2\left(2\sinh K\right)^{M_{\mathrm{col}}-1}
   \quad (\because \blkref{open_chain_endpoint_product_sum}) \\
&>0
   \quad (\because \blkref{cosh_sinh_basic_properties}\text{、}
   \sinh K>0\text{、}M_{\mathrm{col}}-1\in\mathbb Z_{>0})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "1次元 Ising 開鎖の分配関数と両端相関を挿入した和の正値性であり、trace_of_epsilon_V_plus の符号を決める。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,…,8 の全配置を直接列挙）。",
        "式変形の書き方の統一（2026-09-04）。二つの正値性を、それぞれ主張の左辺から既証明の公式を経て正値へ至る一続きの式変形にし、使用した公式と双曲線関数の正値性を各行末から参照した。内容と根拠は変えていない。",
      ],
    },
  },
  {
    id: "bridge_claim_V1_pm_square_root_squares_to_V1_pm",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 12 },
    title: { tex: String.raw`\left(V_1^{(+)}\right)^{1/2} \text{ の平方根性}` },
    labels: ["V1_plus_square_root_property"],
    statement: [
      paragraph([
        ref("def_V1_plus_square_root"),
        " の ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " と ",
        ref("def_V1_plus"),
        " の ",
        math(String.raw`V_1^{(+)}`),
        " について、",
      ]),
      displayMath(String.raw`\left(\left(V_1^{(+)}\right)^{1/2}\right)^2=V_1^{(+)}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`X := \tfrac{i}{2}K_1H_1^{(+)} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " とおく。",
        math(String.raw`X`),
        " は自分自身と可換である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(V_1^{(+)}\right)^{1/2}\right)^2
&=\exp\!\left(X\right)\exp\!\left(X\right)
&&\left(\because\ \blkref{def_V1_plus_square_root}\ \text{と}\ X\ \text{の定義}\right)\\
&=\exp\!\left(X+X\right)
&&\left(\because\ \blkref{theorem_exp_product}\ \text{を可換な}\ X,\ X\ \text{に適用}\right)\\
&=\exp\!\left(iK_1H_1^{(+)}\right)
&&\left(\because\ X\ \text{の定義と同類項}\ \tfrac{i}{2}K_1H_1^{(+)}\ \text{の加法}\right)\\
&=V_1^{(+)}
&&\left(\because\ \blkref{V1_plus_exponential_representation}\right).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "平方根として用いる半指数行列の定義と、その二乗が V_1^{(\pm)} になる主張を 1 ブロック 1 主張に従って分離した。",
        "式変形の書き方の統一（2026-09-03）: 計算前の参照一覧を削り、既に各式変形行の行末にある \\blkref だけを残した。内容・式変形・根拠・参照は不変である。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。偶セクターの章にあった同じ主張の重複ブロック（旧ラベル <V1_plus_square_root_property>）と統合し、ラベルを <V1_plus_square_root_property> に一本化した（旧ラベル <V1_pm_square_root_squares_to_V1_pm> は廃止）。",
      ],
    },
  },
  {
    id: "closing_006_theorem_trace_of_epsilon_V_plus",
    kind: "theorem",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 8 },
    title: {
      tex: String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
= \left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}} + \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}} > 0`,
    },
    labels: ["trace_of_epsilon_V_plus"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)} = \left(V_1^{(+)}\right)^{1/2}V_2\left(V_1^{(+)}\right)^{1/2}`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\varepsilon\,V^{(+)}\right)
= \left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}}
+ \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}}
\ \in\ \mathbb{R}_{>0}`,
      ),
      paragraph([
        "が成り立つ。**この計算には ",
        math(String.raw`\check{Z},\check{Y},\check\psi`),
        " も ",
        math(String.raw`\tilde\theta_\mu`),
        " も現れない。** 転送行列を配置の基底（",
        ref("def_config_basis_iso"),
        "）で見て、1 次元開鎖のスピン和（",
        ref("open_chain_partition_sum"),
        "、",
        ref("open_chain_endpoint_product_sum"),
        "）を実行するだけである。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`B := \left(V_1^{(+)}\right)^{1/2} = \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)`),
        "（",
        ref("def_V1_plus_square_root"),
        "）と略記し、",
        ref("def_D0_open_chain_operator"),
        " の ",
        math(String.raw`D_0`),
        " と ",
        ref("def_G_boundary_operator"),
        " の ",
        math(String.raw`G`),
        " を用い、両者と ",
        ref("H1_plus_in_sigma_z_form"),
        " の等式で ",
        math(String.raw`iH_1^{(+)}=D_0+\varepsilon G`),
        " へ書き換える。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\varepsilon`),
        " を外へ出す）。",
        ref("epsilon_commutes_with_V1_plus_square_root"),
        "・",
        ref("epsilon_commutes_with_V1_plus"),
        "・",
        ref("epsilon_commutes_with_V2"),
        " より ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`B = (V_1^{(+)})^{1/2}`),
        " とも ",
        math(String.raw`V_1^{(+)}`),
        " とも ",
        math(String.raw`V_2`),
        " とも可換である。",
        ref("trace_basic_properties"),
        " (2) の巡回性と合わせて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&= \mathrm{tr}\!\left(\varepsilon\,B\,V_2\,B\right)
   \quad (\because \blkref{def_V_plus}) \\
&= \mathrm{tr}\!\left(B\,\varepsilon\,V_2\,B\right)
   \quad (\because \blkref{epsilon_commutes_with_V1_plus_square_root}\ \text{の}\ 
   \varepsilon B = B\varepsilon) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_2\,B\,B\right)
   \quad (\because \blkref{trace_basic_properties}\ \text{(2) の巡回性を }
   A = B,\ B' = \varepsilon V_2B \text{ に適用}) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_2\,V_1^{(+)}\right)
   \quad \left(\because \blkref{V1_plus_square_root_property}\ \text{の}\ BB = V_1^{(+)}\right) \\
&= \mathrm{tr}\!\left(V_1^{(+)}\,\varepsilon\,V_2\right)
   \quad (\because \blkref{trace_basic_properties}\ \text{(2) の巡回性}) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_1^{(+)}\,V_2\right)
   \quad (\because \blkref{epsilon_commutes_with_V1_plus}\ \text{より}\ 
   V_1^{(+)}\varepsilon=\varepsilon V_1^{(+)})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\varepsilon V_1^{(+)}`),
        " を対角行列と ",
        math(String.raw`\varepsilon`),
        " で書く）。",
        ref("V1_plus_exponential_representation"),
        " より ",
        math(String.raw`V_1^{(+)} = \exp\!\left(iK_1H_1^{(+)}\right)`),
        " であり、",
        ref("H1_plus_in_sigma_z_form"),
        " より ",
        math(String.raw`iK_1H_1^{(+)} = K_1D_0 + K_1\varepsilon G`),
        " である。",
        ref("epsilon_D0_G_pairwise_commute"),
        " より ",
        math(String.raw`K_1D_0`),
        " と ",
        math(String.raw`K_1\varepsilon G`),
        " は可換なので ",
        ref("theorem_exp_product"),
        " が使えて",
      ]),
      displayMath(
        String.raw`V_1^{(+)} = \exp\!\left(K_1D_0\right)\exp\!\left(K_1\varepsilon G\right)
\quad (\because \text{theorem\_exp\_product})`,
      ),
      paragraph([
        ref("epsilon_G_is_involution"),
        " の ",
        math(String.raw`(\varepsilon G)^2 = I`),
        " より、",
        ref("def_exp"),
        " の級数を偶数次と奇数次に分けると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(K_1\varepsilon G\right)
&= \sum_{k=0}^{\infty}\frac{K_1^{k}}{k!}\left(\varepsilon G\right)^{k}
   \quad (\because \text{def\_exp}) \\
&= \left(\sum_{k \text{ 偶}}\frac{K_1^{k}}{k!}\right)I
   + \left(\sum_{k \text{ 奇}}\frac{K_1^{k}}{k!}\right)\varepsilon G
   \quad \left(\because \left(\varepsilon G\right)^{2}=I \text{ より }
   \left(\varepsilon G\right)^{k} = I \text{ または } \varepsilon G\right) \\
&= \cosh(K_1)\,I + \sinh(K_1)\,\varepsilon G
   \quad \left(\because \cosh K_1 = \sum_{k\text{ 偶}}\frac{K_1^k}{k!},\
   \sinh K_1 = \sum_{k\text{ 奇}}\frac{K_1^k}{k!}\right)
\end{aligned}`,
      ),
      paragraph([
        "（級数を偶奇に分けて足し直せることは、実数の絶対収束級数の項の並べ替えによる。",
        ref("real_exp_series_converges"),
        " より ",
        math(String.raw`\sum K_1^k/k!`),
        " は絶対収束する。）左から ",
        math(String.raw`\varepsilon`),
        " を掛け、",
        math(String.raw`\varepsilon`),
        " が ",
        math(String.raw`\exp(K_1D_0)`),
        " と可換（",
        ref("epsilon_D0_G_pairwise_commute"),
        " より ",
        math(String.raw`\varepsilon D_0 = D_0\varepsilon`),
        "、よって級数の部分和とも可換、極限とも可換）であることを使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,V_1^{(+)}
&= \varepsilon\,\exp\!\left(K_1D_0\right)\exp\!\left(K_1\varepsilon G\right)
   \quad (\because \text{この Step の最初の式 }
   V_1^{(+)} = \exp(K_1D_0)\exp(K_1\varepsilon G)) \\
&= \exp\!\left(K_1D_0\right)\varepsilon\,\exp\!\left(K_1\varepsilon G\right)
   \quad (\because \text{直前の可換性 }
   \varepsilon\exp(K_1D_0) = \exp(K_1D_0)\varepsilon) \\
&= \exp\!\left(K_1D_0\right)\varepsilon
   \left(\cosh(K_1)\,I + \sinh(K_1)\,\varepsilon G\right)
   \quad (\because \text{直前の } \exp(K_1\varepsilon G) \text{ の表示}) \\
&= \exp\!\left(K_1D_0\right)
   \left(\cosh(K_1)\,\varepsilon + \sinh(K_1)\,\varepsilon^2 G\right)
   \quad (\because \text{行列の積の分配則}) \\
&= \exp\!\left(K_1D_0\right)
   \left(\cosh(K_1)\,\varepsilon + \sinh(K_1)\,G\right)
   \quad \left(\because \varepsilon^2 = I\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 3（成分の読み取り）。",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " による番号付け（",
        ref("config_numbering_equals_kronecker_numbering"),
        "）のもとで基底を ",
        math(String.raw`f_{\iota(s)}`),
        "（",
        math(String.raw`s \in \mathfrak{M}`),
        "）とする。次の 3 つを読み取る。",
      ]),
      list([
        [
          "(a) ",
          ref("D0_G_diagonal_action"),
          " と ",
          ref("exp_of_diagonal_matrix"),
          " より ",
          math(String.raw`\exp(K_1D_0)`),
          " は対角行列で ",
          math(String.raw`\left(\exp(K_1D_0)\right)_{\iota(s),\iota(s)} = \exp(K_1E(s))`),
          "（",
          math(String.raw`E(s) = \sum_{m=1}^{M_{\mathrm{col}}-1}s(m)s(m+1)`),
          " は ",
          ref("def_open_chain_spin_energy"),
          " のもの）。同じく ",
          math(String.raw`G`),
          " は対角行列で ",
          math(String.raw`G_{\iota(s),\iota(s)} = s(M_{\mathrm{col}})s(1)`),
          "。",
        ],
        [
          "(b) ",
          math(String.raw`\varepsilon f_{\iota(s)} = f_{\iota(-s)}`),
          "。ここで ",
          math(String.raw`(-s)(m) := -s(m)`),
          "。",
        ],
        [
          "(c) ",
          ref("def_transfer_matrix"),
          " と ",
          ref("config_numbering_equals_kronecker_numbering"),
          " より ",
          math(String.raw`(V_2)_{\iota(s),\iota(s')} = \exp\!\left(K_2\sum_{m=1}^{M_{\mathrm{col}}}s(m)s'(m)\right)`),
          "。とくに ",
          math(String.raw`(V_2)_{\iota(s),\iota(s)} = \exp(M_{\mathrm{col}}K_2)`),
          "、",
          math(String.raw`(V_2)_{\iota(-s),\iota(s)} = \exp(-M_{\mathrm{col}}K_2)`),
          "。",
        ],
      ]),
      paragraph([
        "(b) の理由：",
        ref("def_end_iso"),
        " の基底は ",
        math(String.raw`f_I = e_{i_1}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}`),
        " で、",
        ref("kronecker_product_rule"),
        " より ",
        math(String.raw`\sigma_m^x`),
        " は第 ",
        math(String.raw`m`),
        " 因子にだけ ",
        math(String.raw`\sigma^x`),
        " を作用させる。",
        math(String.raw`\sigma^xe_1 = e_2`),
        "、",
        math(String.raw`\sigma^xe_2 = e_1`),
        " なので ",
        math(String.raw`\sigma_m^xf_I`),
        " は第 ",
        math(String.raw`m`),
        " 成分だけを入れ替える。",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " はすべての成分を入れ替えるので、",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        "（",
        math(String.raw`+1\mapsto1`),
        "、",
        math(String.raw`-1\mapsto2`),
        "）のもとで ",
        math(String.raw`\varepsilon f_{\iota(s)} = f_{\iota(-s)}`),
        " である。(c) の 2 つの特別な場合は ",
        math(String.raw`\sum_m s(m)s(m) = M_{\mathrm{col}}`),
        " と ",
        math(String.raw`\sum_m(-s(m))s(m) = -M_{\mathrm{col}}`),
        " による。",
      ]),
      paragraph([
        "Step 4（トレースの計算）。",
        ref("def_trace"),
        " より ",
        math(String.raw`\mathrm{tr}(X) = \sum_{s\in\mathfrak{M}}X_{\iota(s),\iota(s)}`),
        " である。Step 2 の表示を Step 1 に代入し、",
        ref("trace_basic_properties"),
        " (1) の線型性で 2 項に分ける。",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
= \cosh(K_1)\,\mathrm{tr}\!\left(\exp(K_1D_0)\,\varepsilon\,V_2\right)
+ \sinh(K_1)\,\mathrm{tr}\!\left(\exp(K_1D_0)\,G\,V_2\right)`,
      ),
      paragraph([
        "第 1 項の対角成分は、(a) の対角性と (b)(c) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\exp(K_1D_0)\,\varepsilon\,V_2\right)_{\iota(s),\iota(s)}
&= \exp(K_1E(s))\left(\varepsilon V_2\right)_{\iota(s),\iota(s)}
   \quad (\because \text{(a) の対角性}) \\
&= \exp(K_1E(s))\left(V_2\right)_{\iota(-s),\iota(s)}
   \quad (\because \text{(b), } \varepsilon \text{ は行番号 } \iota(s)
   \text{ を } \iota(-s) \text{ に移す置換行列}) \\
&= \exp(K_1E(s))\,\exp(-M_{\mathrm{col}}K_2)
   \quad (\because \text{(c)})
\end{aligned}`,
      ),
      paragraph(["第 2 項の対角成分は同様に"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\exp(K_1D_0)\,G\,V_2\right)_{\iota(s),\iota(s)}
&= \exp(K_1E(s))\left(G\,V_2\right)_{\iota(s),\iota(s)}
   \quad (\because \text{(a) の } \exp(K_1D_0) \text{ の対角性}) \\
&= \exp(K_1E(s))\,s(M_{\mathrm{col}})s(1)\,\left(V_2\right)_{\iota(s),\iota(s)}
   \quad (\because \text{(a) の } G \text{ の対角性}) \\
&= \exp(K_1E(s))\,s(M_{\mathrm{col}})s(1)\,\exp(M_{\mathrm{col}}K_2)
   \quad (\because \text{(c)})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`s \in \mathfrak{M}`),
        " について足し、",
        ref("open_chain_partition_sum"),
        " と ",
        ref("open_chain_endpoint_product_sum"),
        " を ",
        math(String.raw`K = K_1`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&= \cosh(K_1)\,\exp(-M_{\mathrm{col}}K_2)\sum_{s\in\mathfrak{M}}\exp(K_1E(s))
 + \sinh(K_1)\,\exp(M_{\mathrm{col}}K_2)\sum_{s\in\mathfrak{M}}s(M_{\mathrm{col}})s(1)\exp(K_1E(s))
   \quad (\because \text{def\_trace と直前の 2 式}) \\
&= \cosh(K_1)\,\exp(-M_{\mathrm{col}}K_2)\cdot 2\left(2\cosh K_1\right)^{M_{\mathrm{col}}-1}
 + \sinh(K_1)\,\exp(M_{\mathrm{col}}K_2)\cdot 2\left(2\sinh K_1\right)^{M_{\mathrm{col}}-1}
   \quad (\because \text{二つの1次元開鎖のスピン和公式}) \\
&= 2^{M_{\mathrm{col}}}\exp(-M_{\mathrm{col}}K_2)\left(\cosh K_1\right)^{M_{\mathrm{col}}}
 + 2^{M_{\mathrm{col}}}\exp(M_{\mathrm{col}}K_2)\left(\sinh K_1\right)^{M_{\mathrm{col}}}
   \quad \left(\because 2\cdot 2^{M_{\mathrm{col}}-1} = 2^{M_{\mathrm{col}}}\right) \\
&= \left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}}
 + \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}}
\end{aligned}`,
      ),
      paragraph([
        "Step 5（正値性）。",
        ref("open_chain_spin_sums_positive"),
        " を ",
        math(String.raw`K=K_1`),
        " として適用すると、Step 4 の最初の等号に現れる二つのスピン和はともに正である。また ",
        ref("cosh_sinh_basic_properties"),
        " から ",
        math(String.raw`\cosh K_1 > 0`),
        "、",
        math(String.raw`\sinh K_1 > 0`),
        "。また ",
        math(String.raw`\exp(\pm K_2) > 0`),
        "。したがって、その等号の二項はともに正であり、和も正である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04（Lean の通しの証明のゴールラインの確認）: 証明の冒頭の B の右辺 exp((1/2)iK_1H_1^{(+)}) を、def_V1_plus_square_root の式どおり exp((i/2)K_1H_1^{(+)}) に書いた（i/2 := i·2_C^{-1} の読みと食い違わないように。値は不変）。",
        "この主張が章 C′ の最後の欠けていた入力である。ε の固有値 η がどちらになるかは固有値 Λ̌_ε の値からは読めないが、tr(εV^{(+)}) は転送行列の側で完全に初等的に計算でき、しかも正であることが分かる。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,3,4,5・6 組の (K_1,K_2) で、行列指数関数から直接構成した V^{(+)} のトレースと閉じた式の相対差 ≤ 6e-15）。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "closing_007_theorem_max_eigenvector_in_even_sector",
    kind: "theorem",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 9 },
    title: {
      tex: String.raw`\varepsilon \text{ の固有値は } +1, \ 
\mathrm{im}\,\check{Q}_{(1,\dots,1)} \subseteq \mathcal{F}^{(+)}`,
    },
    labels: ["max_eigenvector_in_even_sector"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("epsilon_eigenvalue_on_check_Q"),
        " の ",
        math(String.raw`\eta_\epsilon`),
        " について次が成り立つ。",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \eta_{(1,\dots,1)} = +1`)],
        [
          math(String.raw`\text{(2)}\quad \eta_\epsilon = (-1)^{M_{\mathrm{col}}-|\epsilon|}
= (-1)^{M_{\mathrm{col}}+|\epsilon|}`),
          "、すなわち ",
          math(String.raw`\varepsilon\check{Q}_\epsilon
= (-1)^{M_{\mathrm{col}}+|\epsilon|}\check{Q}_\epsilon`),
          "。",
        ],
        [
          math(String.raw`\text{(3)}\quad \varepsilon
= (-1)^{M_{\mathrm{col}}}\prod_{\mu=1}^{M_{\mathrm{col}}}\left(I - 2\check{n}_\mu\right)`),
        ],
        [
          math(String.raw`\text{(4)}\quad \mathrm{im}\,\check{Q}_{(1,\dots,1)}
\subseteq \mathcal{F}^{(+)}`),
          "（",
          ref("def_even_eigenvectors_of_epsilon"),
          " の ",
          math(String.raw`\mathcal{F}^{(+)}`),
          "）。すなわち **",
          math(String.raw`V^{(+)}`),
          " の最大固有値 ",
          math(String.raw`\check\Lambda_{\max}`),
          " の固有ベクトルは ",
          math(String.raw`\mathcal{F}^{(+)}`),
          " に属する**。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("trace_of_epsilon_V_plus"),
        " より ",
        math(String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right) > 0`),
        " である。",
        ref("trace_of_epsilon_V_plus_via_check_eigenvalues"),
        " の最後の同値",
      ]),
      displayMath(
        String.raw`\eta_{(1,\dots,1)} = +1 \iff \mathrm{tr}\!\left(\varepsilon V^{(+)}\right) > 0`,
      ),
      paragraph([
        "により ",
        math(String.raw`\eta_{(1,\dots,1)} = +1`),
        "。",
      ]),
      paragraph([
        "(2) ",
        ref("epsilon_eigenvalue_on_check_Q"),
        " (3) に (1) を代入して ",
        math(String.raw`\eta_\epsilon = (-1)^{M_{\mathrm{col}}-|\epsilon|}`),
        "。",
        math(String.raw`(-1)^{-|\epsilon|} = (-1)^{|\epsilon|}`),
        "（",
        math(String.raw`(-1)^{|\epsilon|}(-1)^{|\epsilon|} = 1`),
        " より）なので ",
        math(String.raw`(-1)^{M_{\mathrm{col}}-|\epsilon|} = (-1)^{M_{\mathrm{col}}+|\epsilon|}`),
        "。",
      ]),
      paragraph([
        "(3) ",
        ref("epsilon_eigenvalue_on_check_Q"),
        " (4) に (1) を代入する。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`|(1,\dots,1)| = M_{\mathrm{col}}`),
        " なので (2) を一段ずつ適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\check{Q}_{(1,\dots,1)}
&= (-1)^{M_{\mathrm{col}}+|(1,\dots,1)|}\check{Q}_{(1,\dots,1)}
   \quad (\because \text{(2)}) \\
&= (-1)^{2M_{\mathrm{col}}}\check{Q}_{(1,\dots,1)}
   \quad (\because |(1,\dots,1)|=M_{\mathrm{col}}) \\
&= \check{Q}_{(1,\dots,1)}
   \quad (\because (-1)^{2M_{\mathrm{col}}}=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`y \in \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " を取ると、",
        ref("check_joint_eigenspace_decomposition"),
        " (1) の冪等性より ",
        math(String.raw`y = \check{Q}_{(1,\dots,1)}y`),
        " であり",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon y
&= \varepsilon\check{Q}_{(1,\dots,1)}y
   \quad (\because y=\check{Q}_{(1,\dots,1)}y) \\
&= \check{Q}_{(1,\dots,1)}y
   \quad (\because \text{直前の }\varepsilon\check{Q}_{(1,\dots,1)}=\check{Q}_{(1,\dots,1)}) \\
&= y
   \quad (\because y=\check{Q}_{(1,\dots,1)}y)
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`y \in \mathcal{F}^{(+)}`),
        "。",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (3) より ",
        math(String.raw`\check\Lambda_{\max}`),
        " の固有空間はちょうど ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " なので、主張の言い換えが成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "(3) は 004 章の ε = i^M (Z_1Y_1)⋯(Z_MY_M) の半整数運動量フェルミオンによる言い換えであり、「ε は数演算子のパリティである」という物理でよく知られた事実にあたる。本文ではこれを Λ̌_max の固有ベクトルが偶セクターに属することを示すためだけに使う。",
        "符号 (−1)^M が付くのは ň_μ = ψ̌_μ^† ψ̌_{M+1−μ} が「同じモードの ψ^†ψ」ではなく共役なモードの対で定義されているためで、真空 ε = (0,…,0) の側のパリティが (−1)^M になる。M の偶奇によらず最大固有ベクトル（ε = (1,…,1)）のパリティが +1 になる点が重要である。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_02（η_ε = (−1)^{M+|ε|} と ε = (−1)^M Π(I − 2ň_μ) を M=2,3,4,5・6 組の (K_1,K_2) で確認。残差 ≤ 2e-14）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "eigenvector_of_max_eigenvalue_claim_trace_positive_implies_even_eigenvector",
    kind: "claim",
    standing: "mainTheorem",
    title: {
      tex: String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right) > 0 \text{ から } \mathrm{im}\,\check{Q}_{(1,\dots,1)} \subseteq \mathcal{F}^{(+)}`,
    },
    labels: ["max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_{(1,\dots,1)} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)} \subseteq \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " について、次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
= \left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}} + \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}}
\ \in\ \mathbb{R}_{>0}`),
          "（右辺が ",
          math(String.raw`\mathbb{R}`),
          " に住むのは、",
          ref("def_exp"),
          " の ",
          math(String.raw`\exp`),
          " と ",
          ref("def_cosh_sinh"),
          " の ",
          math(String.raw`\cosh, \sinh`),
          " の値が ",
          ref("real_exp_series_converges"),
          " の級数の極限で定まるため。指数評価による脱出）",
        ],
        [
          math(String.raw`\text{(2)}\quad \mathrm{im}\,\check{Q}_{(1,\dots,1)} \subseteq \mathcal{F}^{(+)}`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("trace_of_epsilon_V_plus"),
        " そのものである。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`\eta_{(1,\dots,1)} \in \{+1,-1\}`),
        " は ",
        ref("epsilon_eigenvalue_on_check_Q"),
        " (1) の符号とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
& \mathrm{tr}\!\left(\varepsilon V^{(+)}\right) > 0
&&(\because\ \text{(1)}) \\
\Longrightarrow\ & \eta_{(1,\dots,1)} = +1
&&(\because\ \blkref{trace_of_epsilon_V_plus_via_check_eigenvalues}\ \text{の同値}\ \eta_{(1,\dots,1)} = +1 \iff \mathrm{tr}(\varepsilon V^{(+)}) > 0) \\
\Longrightarrow\ & \varepsilon\check{Q}_{(1,\dots,1)} = \check{Q}_{(1,\dots,1)}
&&(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\ \text{(1) の}\ \varepsilon\check{Q}_{(1,\dots,1)} = \eta_{(1,\dots,1)}\check{Q}_{(1,\dots,1)})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`y \in \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " を取ると、",
        ref("check_joint_eigenspace_decomposition"),
        " (1) の冪等性より ",
        math(String.raw`y = \check{Q}_{(1,\dots,1)}y`),
        " であり",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon y
&= \varepsilon\check{Q}_{(1,\dots,1)}y
&&(\because\ y = \check{Q}_{(1,\dots,1)}y) \\
&= \check{Q}_{(1,\dots,1)}y
&&(\because\ \text{直前の}\ \varepsilon\check{Q}_{(1,\dots,1)} = \check{Q}_{(1,\dots,1)}) \\
&= y
&&(\because\ y = \check{Q}_{(1,\dots,1)}y)
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`y \in \mathcal{F}^{(+)}`),
        "。これは ",
        ref("max_eigenvector_in_even_sector"),
        " (4) と同じ結論である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、V^{(+)} の最大固有値に属する固有ベクトルの章のゴールの式（tr(εV^{(+)}) = … > 0 ⟹ im Q̌_{(1,…,1)} ⊆ F^{(+)}）を一つの主張として立てた。既存の主張 trace_of_epsilon_V_plus・trace_of_epsilon_V_plus_via_check_eigenvalues・epsilon_eigenvalue_on_check_Q と、max_eigenvector_in_even_sector (4) の証明の計算を並べるだけで、新しい証明は無い。",
      ],
    },
  },
]);
