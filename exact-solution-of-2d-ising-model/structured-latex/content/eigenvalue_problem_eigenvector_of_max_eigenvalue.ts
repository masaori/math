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
= \eta_{(1,\dots,1)}\,\varkappa_{\mathbb{C}}`),
          "（",
          math(String.raw`\varkappa := (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\prod_{\mu=1}^{M_{\mathrm{col}}}2\sinh\!\left(\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)`),
          "）であり、",
          math(String.raw`\varkappa`),
          " は**正の実数**である（",
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
        " (1) の ",
        math(String.raw`\eta_{(1,\dots,1)} \in \{+1,-1\}`),
        "（",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`1_{\mathbb{C}}`),
        " と ",
        math(String.raw`-1_{\mathbb{C}}`),
        "）、",
        ref("def_second_transfer_matrix_prefactor"),
        " の ",
        math(String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2} \in \mathbb{R}_{>0}`),
        "、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "）について",
      ]),
      displayMath(
        String.raw`\varkappa := (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\prod_{\mu=1}^{M_{\mathrm{col}}}2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right) \in \mathbb{R}`,
      ),
      paragraph([
        "とおく。積は ",
        ref("def_finite_product_of_real_numbers"),
        "（",
        math(String.raw`m \to M_{\mathrm{col}}`),
        "）の実数の有限積、",
        math(String.raw`(\cdot)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の包含である。",
        math(String.raw`z \in \mathbb{C}`),
        " について ",
        math(String.raw`z > 0`),
        " は「",
        math(String.raw`z = r_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r \in \mathbb{R}_{>0}`),
        " が存在する」ことを表す。このとき次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \mathrm{tr}\!\left(\varepsilon\,V^{(+)}\right)
= \eta_{(1,\dots,1)}\,\varkappa_{\mathbb{C}}`),
        ],
        [math(String.raw`\text{(2)}\quad \varkappa > 0`)],
        [
          math(String.raw`\text{(3)}\quad \eta_{(1,\dots,1)} = +1 \iff \mathrm{tr}\!\left(\varepsilon V^{(+)}\right) > 0`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\{0,1\}^{\check{\mathcal{M}}}`),
        " の上の行列の和は ",
        ref("def_sum_over_binary_words"),
        "（",
        math(String.raw`m, n \to 2^{M_{\mathrm{col}}},\ r \to M_{\mathrm{col}}`),
        "）、複素数の和は ",
        ref("def_sum_over_binary_words_of_complex_numbers"),
        "、実数の和は ",
        ref("def_sum_over_binary_words_of_real_numbers"),
        "（どちらも ",
        math(String.raw`r \to M_{\mathrm{col}}`),
        "）による（",
        ref("def_check_index_set"),
        " により ",
        math(String.raw`\{0,1\}^{\check{\mathcal{M}}} = \{0,1\}^{M_{\mathrm{col}}}`),
        "）。",
        ref("eigenvalues_of_V_plus"),
        " の ",
        math(String.raw`\check\Lambda_\epsilon \in \mathbb{R}`),
        " による行列のスカラー倍 ",
        math(String.raw`\check\Lambda_\epsilon\check{Q}_\epsilon`),
        " は、",
        ref("inclusion_rr_to_cc"),
        " の像による ",
        math(String.raw`\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\check{Q}_\epsilon`),
        "（",
        ref("def_matrix_scalar_multiple"),
        "）と読む。",
        math(String.raw`\pm 1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記 ",
        math(String.raw`r_{\mathbb{C}}`),
        " の ",
        math(String.raw`r \to \pm 1`),
        " である。",
        math(String.raw`\eta_{(1,\dots,1)} \in \{1_{\mathbb{C}}, -1_{\mathbb{C}}\}`),
        " なので、",
        math(String.raw`\check{h} \in \{1,-1\} \subset \mathbb{R}`),
        " を ",
        math(String.raw`\check{h}_{\mathbb{C}} = \eta_{(1,\dots,1)}`),
        " となるように取る。",
        math(String.raw`e \in \{0,1\}`),
        " について ",
        math(String.raw`\check{u}^{(1)} := 1,\ \check{u}^{(0)} := -1 \in \mathbb{R}`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " と ",
        math(String.raw`k \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`|\epsilon|_k := \#\{\mu \in \{1,\dots,k\} \mid \epsilon_\mu = 1\}`),
        " とおく。",
        math(String.raw`|\epsilon|_{M_{\mathrm{col}}} = |\epsilon|`),
        "、",
        math(String.raw`|\epsilon|_1 = \epsilon_1`),
        "、",
        math(String.raw`|\epsilon|_{k+1} = |\epsilon|_k + \epsilon_{k+1}`),
        "、",
        math(String.raw`0 \le |\epsilon|_k \le k`),
        " である（数え上げの定義）。",
      ]),
      paragraph([
        "Step 1（トレースの分解）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&= \mathrm{tr}\!\left(\left(\varepsilon V^{(+)}\right)I\right)
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (m, n \to 2^{M_{\mathrm{col}}},\ A \to \varepsilon V^{(+)})\ \text{を右辺から左辺へ}\bigr)\\
&= \mathrm{tr}\!\left(\left(\varepsilon V^{(+)}\right)\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}}\check{Q}_\epsilon\right)
&&\bigl(\because\ \blkref{check_joint_eigenspace_decomposition}\ \text{(2) を右辺から左辺へ}\bigr)\\
&= \mathrm{tr}\!\left(\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}}\left(\varepsilon V^{(+)}\right)\check{Q}_\epsilon\right)
&&\bigl(\because\ \blkref{sum_over_binary_words_distributes_in_right_factor}\ (m, n, p \to 2^{M_{\mathrm{col}}},\ r \to M_{\mathrm{col}},\ C \to \varepsilon V^{(+)},\ X_\epsilon \to \check{Q}_\epsilon)\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \mathrm{tr}\!\left(\left(\varepsilon V^{(+)}\right)\check{Q}_\epsilon\right)
&&\bigl(\because\ \blkref{trace_of_sum_over_binary_words}\ (n \to 2^{M_{\mathrm{col}}},\ r \to M_{\mathrm{col}},\ B_\epsilon \to (\varepsilon V^{(+)})\check{Q}_\epsilon)\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \mathrm{tr}\!\left(\varepsilon\left(V^{(+)}\check{Q}_\epsilon\right)\right)
&&\bigl(\because\ \blkref{mat_mult_associative}\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \mathrm{tr}\!\left(\varepsilon\left(\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\check{Q}_\epsilon\right)\right)
&&\bigl(\because\ \blkref{eigenvalues_of_V_plus}\ \text{(1) の}\ V^{(+)}\check{Q}_\epsilon = \check\Lambda_\epsilon\check{Q}_\epsilon\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \mathrm{tr}\!\left(\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\left(\varepsilon\check{Q}_\epsilon\right)\right)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\ (a \to (\check\Lambda_\epsilon)_{\mathbb{C}},\ A \to \varepsilon,\ B \to \check{Q}_\epsilon)\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \mathrm{tr}\!\left(\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\left(\eta_\epsilon\check{Q}_\epsilon\right)\right)
&&\bigl(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\ \text{(1) の}\ \varepsilon\check{Q}_\epsilon = \eta_\epsilon\check{Q}_\epsilon\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \mathrm{tr}\!\left(\left(\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\eta_\epsilon\right)\check{Q}_\epsilon\right)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\ (a \to (\check\Lambda_\epsilon)_{\mathbb{C}},\ b \to \eta_\epsilon,\ A \to \check{Q}_\epsilon)\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \left(\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\eta_\epsilon\right)\mathrm{tr}\!\left(\check{Q}_\epsilon\right)
&&\bigl(\because\ \blkref{trace_of_scalar_multiple}\ (n \to 2^{M_{\mathrm{col}}},\ \alpha \to (\check\Lambda_\epsilon)_{\mathbb{C}}\eta_\epsilon,\ A \to \check{Q}_\epsilon)\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \left(\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\eta_\epsilon\right)1_{\mathbb{C}}
&&\bigl(\because\ \blkref{check_joint_eigenspace_decomposition}\ \text{(4) の}\ \mathrm{tr}(\check{Q}_\epsilon) = 1\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\eta_\epsilon
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field}\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \eta_\epsilon\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\ \text{の乗法の交換則を各項へ同時に}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "Step 2（符号の冪を実数の積の包含で表す）。",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " を固定し、",
        math(String.raw`k \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\Bigl(\prod_{\mu=1}^{k}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}} = \left(-1_{\mathbb{C}}\right)^{k-|\epsilon|_k}`),
        "（冪は ",
        ref("def_power_of_complex_number"),
        "）を ",
        math(String.raw`k`),
        " についての帰納法で示す。",
        math(String.raw`k = 1`),
        " で ",
        math(String.raw`\epsilon_1 = 1`),
        " なら ",
        math(String.raw`|\epsilon|_1 = 1`),
        " であり",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\prod_{\mu=1}^{1}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}
&= \left(\check{u}^{(\epsilon_1)}\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\bigr)\\
&= \left(\check{u}^{(1)}\right)_{\mathbb{C}}
&&\bigl(\because\ \epsilon_1 = 1\bigr)\\
&= 1_{\mathbb{C}}
&&\bigl(\because\ \check{u}^{(1)} := 1\ \text{と}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{0}
&&\bigl(\because\ \blkref{def_power_of_complex_number}\ \text{の}\ z^0 := 1_{\mathbb{C}}\ \text{を右辺から左辺へ}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{1-|\epsilon|_1}
&&\bigl(\because\ |\epsilon|_1 = 1\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon_1 = 0`),
        " なら ",
        math(String.raw`|\epsilon|_1 = 0`),
        " であり",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\prod_{\mu=1}^{1}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}
&= \left(\check{u}^{(\epsilon_1)}\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\bigr)\\
&= \left(\check{u}^{(0)}\right)_{\mathbb{C}}
&&\bigl(\because\ \epsilon_1 = 0\bigr)\\
&= -1_{\mathbb{C}}
&&\bigl(\because\ \check{u}^{(0)} := -1\ \text{と}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\bigr)\\
&= 1_{\mathbb{C}}\left(-1_{\mathbb{C}}\right)
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{0}\left(-1_{\mathbb{C}}\right)
&&\bigl(\because\ \blkref{def_power_of_complex_number}\ \text{の}\ z^0 := 1_{\mathbb{C}}\ \text{を右辺から左辺へ}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{1}
&&\bigl(\because\ \blkref{def_power_of_complex_number}\ \text{の}\ z^{m+1} := z^m z\ (m \to 0)\ \text{を右辺から左辺へ}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{1-|\epsilon|_1}
&&\bigl(\because\ |\epsilon|_1 = 0\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k < M_{\mathrm{col}}`),
        " で成り立つとする。",
        math(String.raw`\epsilon_{k+1} = 1`),
        " なら ",
        math(String.raw`(k+1) - |\epsilon|_{k+1} = k - |\epsilon|_k`),
        " であり",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\prod_{\mu=1}^{k+1}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}
&= \Bigl(\Bigl(\prod_{\mu=1}^{k}\check{u}^{(\epsilon_\mu)}\Bigr)\check{u}^{(\epsilon_{k+1})}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{k}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}\left(\check{u}^{(\epsilon_{k+1})}\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ \text{を右辺から左辺へ}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{k-|\epsilon|_k}\left(\check{u}^{(\epsilon_{k+1})}\right)_{\mathbb{C}}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{k-|\epsilon|_k}1_{\mathbb{C}}
&&\bigl(\because\ \epsilon_{k+1} = 1,\ \check{u}^{(1)} := 1\ \text{と}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{k-|\epsilon|_k}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{(k+1)-|\epsilon|_{k+1}}
&&\bigl(\because\ (k+1) - |\epsilon|_{k+1} = k - |\epsilon|_k\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon_{k+1} = 0`),
        " なら ",
        math(String.raw`(k+1) - |\epsilon|_{k+1} = (k - |\epsilon|_k) + 1`),
        " であり",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\prod_{\mu=1}^{k+1}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}
&= \Bigl(\Bigl(\prod_{\mu=1}^{k}\check{u}^{(\epsilon_\mu)}\Bigr)\check{u}^{(\epsilon_{k+1})}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{k}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}\left(\check{u}^{(\epsilon_{k+1})}\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ \text{を右辺から左辺へ}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{k-|\epsilon|_k}\left(\check{u}^{(\epsilon_{k+1})}\right)_{\mathbb{C}}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{k-|\epsilon|_k}\left(-1_{\mathbb{C}}\right)
&&\bigl(\because\ \epsilon_{k+1} = 0,\ \check{u}^{(0)} := -1\ \text{と}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{(k-|\epsilon|_k)+1}
&&\bigl(\because\ \blkref{def_power_of_complex_number}\ \text{の}\ z^{m+1} := z^m z\ (m \to k - |\epsilon|_k)\ \text{を右辺から左辺へ}\bigr)\\
&= \left(-1_{\mathbb{C}}\right)^{(k+1)-|\epsilon|_{k+1}}
&&\bigl(\because\ (k+1) - |\epsilon|_{k+1} = (k - |\epsilon|_k) + 1\bigr)
\end{aligned}`,
      ),
      paragraph([
        "で、",
        math(String.raw`k+1`),
        " でも成り立つ。",
        math(String.raw`k = M_{\mathrm{col}}`),
        " と ",
        math(String.raw`|\epsilon|_{M_{\mathrm{col}}} = |\epsilon|`),
        " より ",
        math(String.raw`\Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}} = \left(-1_{\mathbb{C}}\right)^{M_{\mathrm{col}}-|\epsilon|}`),
        " である。",
      ]),
      paragraph([
        "Step 3（各項を実数の包含で表す）。",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " について ",
        math(String.raw`\check{t}_\epsilon := \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)\check\Lambda_\epsilon \in \mathbb{R}`),
        " とおく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\eta_\epsilon\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}
&= \left(\eta_{(1,\dots,1)}\left(-1_{\mathbb{C}}\right)^{M_{\mathrm{col}}-|\epsilon|}\right)\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\ \text{(3)}\bigr)\\
&= \Bigl(\eta_{(1,\dots,1)}\Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}\Bigr)\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}
&&\bigl(\because\ \text{Step 2 の}\ k = M_{\mathrm{col}}\ \text{の式を右辺から左辺へ}\bigr)\\
&= \Bigl(\check{h}_{\mathbb{C}}\Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}\Bigr)\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}
&&\bigl(\because\ \check{h}\ \text{の取り方}\ \check{h}_{\mathbb{C}} = \eta_{(1,\dots,1)}\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\check{h}\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)_{\mathbb{C}}\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ \bigl(a \to \check{h},\ b \to \textstyle\prod_{\mu}\check{u}^{(\epsilon_\mu)}\bigr)\bigr)\\
&= \Bigl(\Bigl(\check{h}\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)\check\Lambda_\epsilon\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ \bigl(a \to \check{h}\textstyle\prod_{\mu}\check{u}^{(\epsilon_\mu)},\ b \to \check\Lambda_\epsilon\bigr)\bigr)\\
&= \Bigl(\Bigl(\Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)\check\Lambda_\epsilon\Bigr)\check{h}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (ab)c = (bc)a\ \text{（乗法の交換則と結合則）}\bigr)\\
&= \left(\check{t}_\epsilon\check{h}\right)_{\mathbb{C}}
&&\bigl(\because\ \check{t}_\epsilon\ \text{の置き方}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "Step 4（実数の和を積へ分解する）。",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " と ",
        math(String.raw`e \in \{0,1\}`),
        " について ",
        math(String.raw`\check{w}_\mu^{(e)} := \check{u}^{(e)}\exp\!\left(\gamma(\tilde\theta_\mu)\left(e - \tfrac12\right)\right) \in \mathbb{R}`),
        " とおく。",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の実数の exp で、",
        math(String.raw`\mathbb{R}`),
        " を使うのはその値が部分和の極限だからである（指数評価による脱出）。",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{t}_\epsilon
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)\check\Lambda_\epsilon
&&\bigl(\because\ \check{t}_\epsilon\ \text{の置き方}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)
   \Bigl((2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\Bigl(\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\left(\epsilon_\mu - \tfrac12\right)\Bigr)\Bigr)
&&\bigl(\because\ \blkref{eigenvalues_of_V_plus}\ \text{の}\ \check\Lambda_\epsilon\ \text{の定義}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)
   \Bigl((2\sinh 2K_2)^{M_{\mathrm{col}}/2}\prod_{\mu=1}^{M_{\mathrm{col}}}\exp\!\left(\gamma(\tilde\theta_\mu)\left(\epsilon_\mu - \tfrac12\right)\right)\Bigr)
&&\bigl(\because\ \blkref{real_exp_of_finite_sum}\ (m \to M_{\mathrm{col}},\ j \to \mu,\ x_j \to \gamma(\tilde\theta_\mu)(\epsilon_\mu - \tfrac12))\bigr)\\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
   \Bigl(\Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\check{u}^{(\epsilon_\mu)}\Bigr)\prod_{\mu=1}^{M_{\mathrm{col}}}\exp\!\left(\gamma(\tilde\theta_\mu)\left(\epsilon_\mu - \tfrac12\right)\right)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a(bc) = b(ac)\ \text{（乗法の交換則と結合則）}\bigr)\\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
   \prod_{\mu=1}^{M_{\mathrm{col}}}\left(\check{u}^{(\epsilon_\mu)}\exp\!\left(\gamma(\tilde\theta_\mu)\left(\epsilon_\mu - \tfrac12\right)\right)\right)
&&\bigl(\because\ \blkref{finite_product_of_real_products}\ (m \to M_{\mathrm{col}},\ j \to \mu,\ x_j \to \check{u}^{(\epsilon_\mu)},\ y_j \to \exp(\gamma(\tilde\theta_\mu)(\epsilon_\mu - \tfrac12)))\ \text{を右辺から左辺へ}\bigr)\\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\prod_{\mu=1}^{M_{\mathrm{col}}} \check{w}_\mu^{(\epsilon_\mu)}
&&\bigl(\because\ \check{w}_\mu^{(e)}\ \text{の置き方}\ (e \to \epsilon_\mu)\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}} \check{w}_\mu^{(\epsilon_\mu)}\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "これを和の各項へ入れる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}}\check{t}_\epsilon
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}}\Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}} \check{w}_\mu^{(\epsilon_\mu)}\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \text{直前の鎖を各項へ同時に}\bigr)\\
&= \Bigl(\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}}\prod_{\mu=1}^{M_{\mathrm{col}}} \check{w}_\mu^{(\epsilon_\mu)}\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \blkref{real_sum_over_binary_words_distributes_in_left_factor}\ \bigl(r \to M_{\mathrm{col}},\ x_\epsilon \to \textstyle\prod_{\mu} \check{w}_\mu^{(\epsilon_\mu)},\ c \to (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\bigr)\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(\check{w}_\mu^{(1)} + \check{w}_\mu^{(0)}\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \blkref{expansion_of_finite_product_of_two_term_sums_of_real_numbers}\ (r \to M_{\mathrm{col}},\ j \to \mu,\ a_j^{(e)} \to \check{w}_\mu^{(e)})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(\check{u}^{(1)}\exp\!\left(\gamma(\tilde\theta_\mu)\left(1 - \tfrac12\right)\right) + \check{u}^{(0)}\exp\!\left(\gamma(\tilde\theta_\mu)\left(0 - \tfrac12\right)\right)\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \check{w}_\mu^{(e)}\ \text{の置き方}\ (e \to 1,\ e \to 0)\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(1\cdot\exp\!\left(\gamma(\tilde\theta_\mu)\left(1 - \tfrac12\right)\right) + (-1)\exp\!\left(\gamma(\tilde\theta_\mu)\left(0 - \tfrac12\right)\right)\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \check{u}^{(1)} := 1,\ \check{u}^{(0)} := -1\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(\exp\!\left(\gamma(\tilde\theta_\mu)\left(1 - \tfrac12\right)\right) + (-1)\exp\!\left(\gamma(\tilde\theta_\mu)\left(0 - \tfrac12\right)\right)\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 1\cdot b = b\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(\exp\!\left(\gamma(\tilde\theta_\mu)\left(1 - \tfrac12\right)\right) - \exp\!\left(\gamma(\tilde\theta_\mu)\left(0 - \tfrac12\right)\right)\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a + (-1)b = a - b\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(\exp\!\left(\gamma(\tilde\theta_\mu)\cdot\tfrac12\right) - \exp\!\left(\gamma(\tilde\theta_\mu)\left(0 - \tfrac12\right)\right)\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 1 - \tfrac12 = \tfrac12\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(\exp\!\left(\gamma(\tilde\theta_\mu)\cdot\tfrac12\right) - \exp\!\left(\gamma(\tilde\theta_\mu)\left(-\tfrac12\right)\right)\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0 - a = -a\ (a \to \tfrac12)\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(\exp\!\left(\gamma(\tilde\theta_\mu)\cdot\tfrac12\right) - \exp\!\left(-\left(\gamma(\tilde\theta_\mu)\cdot\tfrac12\right)\right)\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a(-b) = -(ab)\ (a \to \gamma(\tilde\theta_\mu),\ b \to \tfrac12)\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(\exp\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right) - \exp\!\left(-\frac{\gamma(\tilde\theta_\mu)}{2}\right)\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a\cdot\tfrac12 = \tfrac{a}{2}\ (a \to \gamma(\tilde\theta_\mu))\ \text{を各因子の 2 箇所へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}2\cdot\frac{\exp\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right) - \exp\!\left(-\frac{\gamma(\tilde\theta_\mu)}{2}\right)}{2}\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 2 \ne 0\ \text{なので}\ b = 2\cdot\tfrac{b}{2}\ \text{を各因子へ同時に}\bigr)\\
&= \Bigl(\prod_{\mu=1}^{M_{\mathrm{col}}}2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)\Bigr)(2\sinh 2K_2)^{M_{\mathrm{col}}/2}
&&\bigl(\because\ \blkref{def_cosh_sinh}\ \text{の}\ \sinh\ (x \to \tfrac{\gamma(\tilde\theta_\mu)}{2})\ \text{を各因子へ同時に、右辺から左辺へ}\bigr)\\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\prod_{\mu=1}^{M_{\mathrm{col}}}2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則}\bigr)\\
&= \varkappa
&&\bigl(\because\ \varkappa\ \text{の置き方}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "Step 5（(1) の等式）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \eta_\epsilon\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}
&&\bigl(\because\ \text{Step 1 の鎖}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \left(\check{t}_\epsilon\check{h}\right)_{\mathbb{C}}
&&\bigl(\because\ \text{Step 3 の鎖を各項へ同時に}\bigr)\\
&= \Bigl(\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \check{t}_\epsilon\check{h}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum_over_binary_words}\ (r \to M_{\mathrm{col}},\ x_\epsilon \to \check{t}_\epsilon\check{h})\bigr)\\
&= \Bigl(\Bigl(\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \check{t}_\epsilon\Bigr)\check{h}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_sum_over_binary_words_distributes_in_left_factor}\ (r \to M_{\mathrm{col}},\ x_\epsilon \to \check{t}_\epsilon,\ c \to \check{h})\ \text{を右辺から左辺へ}\bigr)\\
&= \left(\varkappa\check{h}\right)_{\mathbb{C}}
&&\bigl(\because\ \text{Step 4 の鎖}\bigr)\\
&= \left(\check{h}\varkappa\right)_{\mathbb{C}}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則}\bigr)\\
&= \check{h}_{\mathbb{C}}\varkappa_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a \to \check{h},\ b \to \varkappa)\ \text{を右辺から左辺へ}\bigr)\\
&= \eta_{(1,\dots,1)}\varkappa_{\mathbb{C}}
&&\bigl(\because\ \check{h}\ \text{の取り方}\ \check{h}_{\mathbb{C}} = \eta_{(1,\dots,1)}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "Step 6（(2) の不等号）。",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " について ",
        ref("gamma_theta_tilde_mu_positive"),
        " より ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " であり、次の 2 つの鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\gamma(\tilde\theta_\mu)}{2}
&= \gamma(\tilde\theta_\mu)\cdot\tfrac12
&&\bigl(\because\ \mathbb{R}\ \text{で}\ \tfrac{a}{2} = a\cdot\tfrac12\bigr)\\
&> 0\cdot\tfrac12
&&\bigl(\because\ \gamma(\tilde\theta_\mu) > 0\ \text{の両辺に}\ \tfrac12 > 0\ \text{を掛ける}\bigr)\\
&= 0
&&(\because\ 0\cdot\tfrac12 = 0)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
&> 2\cdot 0
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\ \text{(3) の}\ \sinh x > 0\ (x \to \tfrac{\gamma(\tilde\theta_\mu)}{2})\ \text{に上の鎖を当て、両辺に}\ 2 > 0\ \text{を掛ける}\bigr)\\
&= 0
&&(\because\ 2\cdot 0 = 0)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\prod_{\mu=1}^{M_{\mathrm{col}}}2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
&> 0
&&\bigl(\because\ \blkref{finite_product_of_positive_reals_is_positive}\ \bigl(m \to M_{\mathrm{col}},\ j \to \mu,\ r_\mu \to 2\sinh(\tfrac{\gamma(\tilde\theta_\mu)}{2})\bigr)\ \text{に、上の各}\ \mu\ \text{の鎖}\ r_\mu > 0\ \text{を当てる}\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\varkappa
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\prod_{\mu=1}^{M_{\mathrm{col}}}2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
&&\bigl(\because\ \varkappa\ \text{の置き方}\bigr)\\
&> 0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a > 0,\ b > 0\ \text{なら}\ ab > 0\ \bigl(a \to (2\sinh 2K_2)^{M_{\mathrm{col}}/2},\ b \to \textstyle\prod_{\mu}2\sinh(\tfrac{\gamma(\tilde\theta_\mu)}{2})\bigr)\ \text{に、}\blkref{def_second_transfer_matrix_prefactor}\ \text{の}\ (2\sinh 2K_2)^{M_{\mathrm{col}}/2} \in \mathbb{R}_{>0}\ \text{と直前の不等号を当てる}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "Step 7（(3) の同値）。",
        math(String.raw`\eta_{(1,\dots,1)} = +1`),
        " なら",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&= 1_{\mathbb{C}}\varkappa_{\mathbb{C}}
&&\bigl(\because\ \text{(1) と}\ \eta_{(1,\dots,1)} = 1_{\mathbb{C}}\bigr)\\
&= \varkappa_{\mathbb{C}}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "であり、(2) の ",
        math(String.raw`\varkappa \in \mathbb{R}_{>0}`),
        " を ",
        math(String.raw`r`),
        " に取れば ",
        math(String.raw`\mathrm{tr}(\varepsilon V^{(+)}) > 0`),
        " である。逆に ",
        math(String.raw`\mathrm{tr}(\varepsilon V^{(+)}) > 0`),
        " とし、",
        math(String.raw`\mathrm{tr}(\varepsilon V^{(+)}) = r_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r \in \mathbb{R}_{>0}`),
        " を取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(r, 0)
&= r_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\ \text{の定義を右辺から左辺へ}\bigr)\\
&= \mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&&\bigl(\because\ r\ \text{の取り方}\bigr)\\
&= \left(\check{h}\varkappa\right)_{\mathbb{C}}
&&\bigl(\because\ \text{Step 5 の鎖の 1 行目から 6 行目}\bigr)\\
&= \left(\check{h}\varkappa, 0\right)
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\ \text{の定義}\bigr)
\end{aligned}`,
      ),
      paragraph([
        ref("definition_of_cc"),
        " の ",
        math(String.raw`\mathbb{C} = \mathbb{R}\times\mathbb{R}`),
        " の元の等号は成分ごとなので ",
        math(String.raw`r = \check{h}\varkappa`),
        " である。",
        math(String.raw`\check{h} = -1`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
r
&= \check{h}\varkappa
&&\bigl(\because\ \text{直前の成分の比較}\bigr)\\
&= (-1)\varkappa
&&\bigl(\because\ \text{仮定}\ \check{h} = -1\bigr)\\
&= -\varkappa
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (-1)a = -a\ (a \to \varkappa)\bigr)\\
&< 0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a > 0\ \text{なら}\ -a < 0\ (a \to \varkappa)\ \text{に (2) の}\ \varkappa > 0\ \text{を当てる}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "となり ",
        math(String.raw`r > 0`),
        " に反する。",
        math(String.raw`\check{h} \in \{1,-1\}`),
        " なので ",
        math(String.raw`\check{h} = 1`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\eta_{(1,\dots,1)}
&= \check{h}_{\mathbb{C}}
&&\bigl(\because\ \check{h}\ \text{の取り方}\bigr)\\
&= 1_{\mathbb{C}}
&&\bigl(\because\ \check{h} = 1\ \text{と}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\bigr)
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "trace_of_check_Vprime が Σ_ε Λ̌_ε = Π 2cosh(γ/2) を与えるのと対をなす計算で、符号 η_ε が入ることで cosh が sinh に変わる。γ(θ~_μ) > 0（半整数運動量に固有）なので sinh の積が 0 にならないのが要点である。整数運動量では臨界点で γ(θ_M) = 0 になりうるため、この論法はそのままでは使えない。",
        "数値検証: sagemath/check/trace_of_epsilon_V_plus_via_check_eigenvalues/（旧い記録は sagemath/check/053_claim_even_sector_closing/check_03）。",
        "2026-11-04: SageMath の検算を付けるときに、名前だけの根拠と散文の推論を (∵) 付きの鎖にした。Step 1 は「トレースの線型性」と名前だけで和・スカラー倍・ε の積の段を省いていたので、trace_of_check_Vprime の Step 1 と同じ根拠の 13 行にした（ε を V^{(+)}Q̌_ε の前から作用させる mat_mult_associative・scalar_multiple_factors_out_of_right_factor・scalar_multiple_is_associative の行を足した）。Step 2 の「(−1)^{M−|ϵ|} = Π_μ(−1)^{1−ϵ_μ}」「theorem_exp_product（n=1）」「有限個の因子の積の展開」は、実数の符号 ǔ^{(e)} の有限積の包含が (−1_ℂ)^{M−|ϵ|} に等しいことの帰納法（Step 2）、各項を実数の包含 (ť_ϵȟ)_ℂ で表す鎖（Step 3）、real_exp_of_finite_sum・新しく足した finite_product_of_real_products・real_sum_over_binary_words_distributes_in_left_factor・expansion_of_finite_product_of_two_term_sums_of_real_numbers・def_cosh_sinh の sinh を引く鎖（Step 4）にした。theorem_exp_product は二つの行列の主張で M_col 個の和には届かない。Step 3 の sinh の正値性に引いていた cosh_sinh_basic_properties は (3) を明示し、正数の有限積は finite_product_of_positive_reals_is_positive を引いた。主張文は ℂ の値 tr(εV^{(+)}) と実数の因子を包含を書かずに等号で結び、ℂ の値に > 0 を書いていたので、実数の因子を ϰ ∈ ℝ と置いて (1) tr(εV^{(+)}) = η_{(1,…,1)}ϰ_ℂ、(2) ϰ > 0、(3) 同値に分け、ℂ の元の > 0 を「正の実数の包含に等しい」と定めた（下流の max_eigenvector_in_even_sector・max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus が引く同値の形は変わらない）。値は変えていない。Lean（ClaimTraceEpsilonVPlusViaCheckEigenvalues.lean）は旧い Step の分け方のままで、新しい鎖との 1 対 1 と finite_product_of_real_products の Lean は Lean の連続実行が受け持つ。",
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
        "以下 ",
        math(String.raw`M := M_{\mathrm{col}}`),
        "、",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " と書き、",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z`),
        " は ",
        ref("pauli_matrix_products"),
        " の Pauli 行列、",
        math(String.raw`\boxtimes`),
        " は ",
        ref("def_kronecker"),
        " のクロネッカー積とする。",
        math(String.raw`\overbrace{A\boxtimes\cdots\boxtimes A}^{k}`),
        " は ",
        math(String.raw`A`),
        " を ",
        math(String.raw`k`),
        " 個並べたもので、",
        math(String.raw`k = 0`),
        " のときは何も並べない。積 ",
        math(String.raw`\sigma_1^{a_1}\cdots\sigma_r^{a_r}`),
        " は左から順に掛けたものとする（",
        ref("site_pauli_prefix_product_kronecker_form"),
        " の約束）。",
      ]),
      paragraph([
        "準備 1（内部の辺の因子のクロネッカー積表示）。",
        math(String.raw`m \in \{1,\dots,M-1\}`),
        " とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_m
&= \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y
&&(\because \blkref{def_jordan_wigner_Y_matrices}) \\
&= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m}
&&(\because \blkref{site_pauli_prefix_product_kronecker_form}\ (r \to m,\ a_1=\cdots=a_{m-1}=x,\ a_m=y))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Z_{m+1}
&= \sigma_1^x\cdots\sigma_{m}^x\sigma_{m+1}^z
&&(\because \blkref{def_jordan_wigner_Z_matrices}) \\
&= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m}\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}
&&(\because \blkref{site_pauli_prefix_product_kronecker_form}\ (r \to m+1,\ a_1=\cdots=a_{m}=x,\ a_{m+1}=z))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^z\sigma_{m+1}^z
&= \left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m}\right)
   \left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m}\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}\right)
&&(\because \blkref{def_site_pauli_matrices}\ \text{を 2 箇所へ同時適用}) \\
&= \overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{m-1}\boxtimes(\sigma^zI)\boxtimes(I\sigma^z)\boxtimes\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M-m-1}
&&(\because \blkref{kronecker_product_rule}\ (1)) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\sigma^z\boxtimes(I\sigma^z)\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}
&&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ \text{を}\ AI\ \text{の形の因子へ同時適用}) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\sigma^z\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}
&&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`,
      ),
      paragraph([
        "準備 2（境界の因子のクロネッカー積表示）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_{M}
&= \sigma_1^x\cdots\sigma_{M-1}^x\sigma_{M}^y
&&(\because \blkref{def_jordan_wigner_Y_matrices}) \\
&= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-1}\boxtimes\sigma^y
&&(\because \blkref{site_pauli_prefix_product_kronecker_form}\ (r \to M,\ a_1=\cdots=a_{M-1}=x,\ a_M=y))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Z_1
&= \sigma_1^z
&&(\because \blkref{def_jordan_wigner_Z_matrices}\ (m = 1)) \\
&= \sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-1}
&&(\because \blkref{def_site_pauli_matrices})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\varepsilon = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M}
\qquad (\because \blkref{global_spin_flip_kronecker_form})`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma_{M}^z\sigma_1^z
&= \left(\overbrace{I\boxtimes\cdots\boxtimes I}^{M-1}\boxtimes\sigma^z\right)
   \left(\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-1}\right)
&&(\because \blkref{def_site_pauli_matrices}\ \text{を 2 箇所へ同時適用}) \\
&= (I\sigma^z)\boxtimes\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M-2}\boxtimes(\sigma^zI)
&&(\because \blkref{kronecker_product_rule}\ (1)\text{。}M \geq 2\ \text{より第}\ 1\ \text{因子と第}\ M\ \text{因子は異なる}) \\
&= (I\sigma^z)\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-2}\boxtimes\sigma^z
&&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ \text{を}\ AI\ \text{の形の因子へ同時適用}) \\
&= \sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-2}\boxtimes\sigma^z
&&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`,
      ),
      paragraph([
        "準備 3（内部の辺）。",
        math(String.raw`m \in \{1,\dots,M-1\}`),
        " とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
i\,(Y_mZ_{m+1})
&= i\left(\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m}\right)Z_{m+1}\right)
&&(\because \text{準備 1 の } Y_m \text{ の鎖}) \\
&= i\left(\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m}\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m}\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}\right)\right)
&&(\because \text{準備 1 の } Z_{m+1} \text{ の鎖}) \\
&= i\left(\overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}\boxtimes(\sigma^y\sigma^x)\boxtimes(I\sigma^z)\boxtimes\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M-m-1}\right)
&&(\because \blkref{kronecker_product_rule}\ (1)) \\
&= i\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes(\sigma^y\sigma^x)\boxtimes(I\sigma^z)\boxtimes\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M-m-1}\right)
&&(\because \blkref{pauli_matrix_products}\ \text{の}\ \sigma^x\sigma^x = I\ \text{を}\ m-1\ \text{箇所へ同時適用}) \\
&= i\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes(\sigma^y\sigma^x)\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}\right)
&&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を}\ IA\ \text{の形の因子へ同時適用}) \\
&= i\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\bigl((-i)\,\sigma^z\bigr)\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}\right)
&&(\because \blkref{pauli_y_times_pauli_x}) \\
&= i\left((-i)\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\sigma^z\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}\right)\right)
&&(\because \blkref{kronecker_multilinear}\ \text{の}\ r=1\ \text{の式}\ (j \to m)) \\
&= \bigl(i\cdot(-i)\bigr)\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\sigma^z\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}\right)
&&(\because \blkref{scalar_multiple_is_associative}) \\
&= 1_{\mathbb{C}}\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\sigma^z\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}\right)
&&(\because \mathbb{C}\ \text{で}\ i\cdot(-i)=1_{\mathbb{C}}\text{。}\blkref{definition_of_cc}\ \text{の積}) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\sigma^z\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-m-1}
&&(\because \blkref{scalar_multiple_by_one}) \\
&= \sigma_m^z\sigma_{m+1}^z
&&(\because \text{準備 1 の}\ \sigma_m^z\sigma_{m+1}^z\ \text{の鎖を右辺から左辺へ})
\end{aligned}`,
      ),
      paragraph(["準備 4（境界の辺）。"]),
      displayMath(
        String.raw`\begin{aligned}
-\bigl(i\,(Y_{M}Z_1)\bigr)
&= (-1_{\mathbb{C}})\bigl(i\,(Y_{M}Z_1)\bigr)
&&(\because \blkref{negation_is_scalar_multiple_by_minus_one}) \\
&= \bigl((-1_{\mathbb{C}})\cdot i\bigr)(Y_{M}Z_1)
&&(\because \blkref{scalar_multiple_is_associative}) \\
&= (-i)\,(Y_{M}Z_1)
&&(\because \blkref{multiply_by_minus_one}) \\
&= (-i)\left(\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-1}\boxtimes\sigma^y\right)Z_1\right)
&&(\because \text{準備 2 の } Y_M \text{ の鎖}) \\
&= (-i)\left(\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-1}\boxtimes\sigma^y\right)
   \left(\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-1}\right)\right)
&&(\because \text{準備 2 の } Z_1 \text{ の鎖}) \\
&= (-i)\left((\sigma^x\sigma^z)\boxtimes\overbrace{(\sigma^xI)\boxtimes\cdots\boxtimes(\sigma^xI)}^{M-2}\boxtimes(\sigma^yI)\right)
&&(\because \blkref{kronecker_product_rule}\ (1)) \\
&= (-i)\left((\sigma^x\sigma^z)\boxtimes\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-2}\boxtimes\sigma^y\right)
&&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ \text{を}\ AI\ \text{の形の因子へ同時適用}) \\
&= (-i)\left(\bigl((-i)\,\sigma^y\bigr)\boxtimes\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-2}\boxtimes\sigma^y\right)
&&(\because \blkref{pauli_x_times_pauli_z}) \\
&= (-i)\left((-i)\left(\sigma^y\boxtimes\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-2}\boxtimes\sigma^y\right)\right)
&&(\because \blkref{kronecker_multilinear}\ \text{の}\ r=1\ \text{の式}\ (j \to 1)) \\
&= (-i)\left(\sigma^y\boxtimes\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-2}\boxtimes\bigl((-i)\,\sigma^y\bigr)\right)
&&(\because \blkref{kronecker_multilinear}\ \text{の}\ r=1\ \text{の式}\ (j \to M)\ \text{を右辺から左辺へ}) \\
&= \bigl((-i)\,\sigma^y\bigr)\boxtimes\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-2}\boxtimes\bigl((-i)\,\sigma^y\bigr)
&&(\because \blkref{kronecker_multilinear}\ \text{の}\ r=1\ \text{の式}\ (j \to 1)\ \text{を右辺から左辺へ}) \\
&= (\sigma^x\sigma^z)\boxtimes\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M-2}\boxtimes(\sigma^x\sigma^z)
&&(\because \blkref{pauli_x_times_pauli_z}\ \text{を 2 箇所へ右辺から左辺へ同時適用}) \\
&= (\sigma^x\sigma^z)\boxtimes\overbrace{(\sigma^xI)\boxtimes\cdots\boxtimes(\sigma^xI)}^{M-2}\boxtimes(\sigma^x\sigma^z)
&&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ \text{を右辺から左辺へ同時適用}) \\
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M}\right)
   \left(\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-2}\boxtimes\sigma^z\right)
&&(\because \blkref{kronecker_product_rule}\ (1)\ \text{を右辺から左辺へ}) \\
&= \varepsilon\left(\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M-2}\boxtimes\sigma^z\right)
&&(\because \text{準備 2 の}\ \varepsilon\ \text{の式を右辺から左辺へ}) \\
&= \varepsilon\left(\sigma_{M}^z\sigma_1^z\right)
&&(\because \text{準備 2 の}\ \sigma_M^z\sigma_1^z\ \text{の鎖を右辺から左辺へ}) \\
&= \varepsilon\,G
&&(\because \blkref{def_G_boundary_operator})
\end{aligned}`,
      ),
      paragraph(["主張の左辺から計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
i\,H_1^{(+)}
&= i\left(\sum_{m=1}^{M-1}Y_mZ_{m+1} - Y_{M}Z_1\right)
&&(\because \blkref{def_H1_plus}) \\
&= i\left(\sum_{m=1}^{M-1}Y_mZ_{m+1}\right) - \bigl(i\,(Y_{M}Z_1)\bigr)
&&(\because \blkref{scalar_multiple_distributes_over_matrix_difference}) \\
&= \sum_{m=1}^{M-1}\bigl(i\,(Y_mZ_{m+1})\bigr) - \bigl(i\,(Y_{M}Z_1)\bigr)
&&(\because \blkref{finite_sum_of_scalar_multiples}\ \text{を右辺から左辺へ}) \\
&= \sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z - \bigl(i\,(Y_{M}Z_1)\bigr)
&&(\because \text{準備 3 を各項へ同時適用}) \\
&= D_0 - \bigl(i\,(Y_{M}Z_1)\bigr)
&&(\because \blkref{def_D0_open_chain_operator}) \\
&= D_0 + \Bigl(-\bigl(i\,(Y_{M}Z_1)\bigr)\Bigr)
&&(\because \blkref{matrix_difference_is_sum_with_negation}) \\
&= D_0 + \varepsilon G
&&(\because \text{準備 4})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "V1_in_Z_Y_epsilon は V_1 = exp(iK_1(Y_1Z_2+⋯+Y_{M-1}Z_M − εY_MZ_1)) を主張しており、この表示はその指数の中身を σ^z の言葉へ戻したものにあたる。右辺は F^{(+)} 上（ε = +1）で K_1 D の 1/K_1 倍に一致し、F^{(-)} 上では最後の項の符号が反転する。これが V^{(+)} が「周期境界」、V^{(-)} が「反周期境界」に対応する具体的な形である。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,3,4,5 で残差 0.0）。",
        "2026-11-04（全証明の SageMath 検算）: 証明をクロネッカー積表示の鎖に書き直した。以前の証明は「V1_in_Z_Y_epsilon の Step 0」という他のブロックの証明の途中と、相異なるサイトの因子の並べ替え・同じサイトの因子の積を一度に行う段（ラベルの無い「相異なるサイトの因子は可換」）を根拠にしていた。1 サイトの積 σ^yσ^x = (−i)σ^z・σ^xσ^z = (−i)σ^y を新しい主張 pauli_y_times_pauli_x・pauli_x_times_pauli_z にし、Y_m・Z_{m+1}・Y_M・Z_1・ε・σ_m^zσ_{m+1}^z・σ_M^zσ_1^z の表示を準備 1・2 に、内部の辺と境界の辺の等式を準備 3・4 の (∵) 付きの鎖に、最後の鎖を主張の左辺から始まる一続きにした（主張は不変）。数値検証: sagemath/check/H1_plus_in_sigma_z_form/。",
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
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_config_basis_iso"),
        " の基底 ",
        math(String.raw`f_{\iota(s)} \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
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
=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}s(m)s(m+1)\right)_{\mathbb{C}}f_{\iota(s)},
\qquad
G f_{\iota(s)}=\bigl(s(M_{\mathrm{col}})s(1)\bigr)_{\mathbb{C}}f_{\iota(s)}`),
      paragraph([
        "ここで ",
        math(String.raw`s(m)\in\{-1,1\}\subset\mathbb{R}`),
        "、括弧の中の積は ",
        math(String.raw`\mathbb{R}`),
        " の積、和は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和、",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、右辺は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍、左辺の積は ",
        ref("mat_mult"),
        " の数ベクトルへの作用である。スピン配置を ",
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
        "準備。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}-1\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(\sigma_m^z\sigma_{m+1}^z)f_{\iota(s)}
&=\sigma_m^z\bigl(\sigma_{m+1}^zf_{\iota(s)}\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_m^z\bigl(s(m+1)_{\mathbb{C}}f_{\iota(s)}\bigr)
&&\bigl(\because\ \blkref{sigma_z_diagonal_action}\ (\mu\to s,\ m\to m+1)\bigr)\\
&=s(m+1)_{\mathbb{C}}\bigl(\sigma_m^zf_{\iota(s)}\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&=s(m+1)_{\mathbb{C}}\bigl(s(m)_{\mathbb{C}}f_{\iota(s)}\bigr)
&&\bigl(\because\ \blkref{sigma_z_diagonal_action}\ (\mu\to s,\ m\to m)\bigr)\\
&=\bigl(s(m+1)_{\mathbb{C}}\,s(m)_{\mathbb{C}}\bigr)f_{\iota(s)}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&=\bigl(s(m+1)s(m)\bigr)_{\mathbb{C}}f_{\iota(s)}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\bigr)\\
&=\bigl(s(m)s(m+1)\bigr)_{\mathbb{C}}f_{\iota(s)}
&&\bigl(\because\ \mathbb{R}\text{ の積の交換律}\bigr).
\end{aligned}`),
      paragraph(["開鎖項について。"]),
      displayMath(String.raw`\begin{aligned}
D_0f_{\iota(s)}
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)f_{\iota(s)}
&&\bigl(\because\ \blkref{def_D0_open_chain_operator}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}\Bigl((\sigma_m^z\sigma_{m+1}^z)f_{\iota(s)}\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_left_factor}\ (r\to M_{\mathrm{col}}-1)\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}\Bigl(\bigl(s(m)s(m+1)\bigr)_{\mathbb{C}}f_{\iota(s)}\Bigr)
&&\bigl(\because\ \text{準備の等式を各 }m\text{ へ同時に適用}\bigr)\\
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\bigl(s(m)s(m+1)\bigr)_{\mathbb{C}}\right)f_{\iota(s)}
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\ (r\to M_{\mathrm{col}}-1,\ c_j\to(s(j)s(j+1))_{\mathbb{C}})\bigr)\\
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}s(m)s(m+1)\right)_{\mathbb{C}}f_{\iota(s)}
&&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\ (m\to M_{\mathrm{col}}-1,\ r_j\to s(j)s(j+1))\bigr).
\end{aligned}`),
      paragraph(["周期境界項について。"]),
      displayMath(String.raw`\begin{aligned}
Gf_{\iota(s)}
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)f_{\iota(s)}
&&\bigl(\because\ \blkref{def_G_boundary_operator}\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl(\sigma_1^zf_{\iota(s)}\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl(s(1)_{\mathbb{C}}f_{\iota(s)}\bigr)
&&\bigl(\because\ \blkref{sigma_z_diagonal_action}\ (\mu\to s,\ m\to 1)\bigr)\\
&=s(1)_{\mathbb{C}}\bigl(\sigma_{M_{\mathrm{col}}}^zf_{\iota(s)}\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&=s(1)_{\mathbb{C}}\bigl(s(M_{\mathrm{col}})_{\mathbb{C}}f_{\iota(s)}\bigr)
&&\bigl(\because\ \blkref{sigma_z_diagonal_action}\ (\mu\to s,\ m\to M_{\mathrm{col}})\bigr)\\
&=\bigl(s(1)_{\mathbb{C}}\,s(M_{\mathrm{col}})_{\mathbb{C}}\bigr)f_{\iota(s)}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&=\bigl(s(1)s(M_{\mathrm{col}})\bigr)_{\mathbb{C}}f_{\iota(s)}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\bigr)\\
&=\bigl(s(M_{\mathrm{col}})s(1)\bigr)_{\mathbb{C}}f_{\iota(s)}
&&\bigl(\because\ \mathbb{R}\text{ の積の交換律}\bigr).
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/D0_G_diagonal_action/。",
        "2026-11-04: SageMath の検算を付けるときに、証明の名前だけの根拠をラベル参照にした。旧い証明は (σ_m^zσ_{m+1}^z)f = σ_m^z(s(m+1)f) の一行で積の結合律と sigma_z_diagonal_action の二つを使っていたので、mat_mult_associative の行を分けた。「行列作用の複素線型性」を scalar_multiple_factors_out_of_right_factor、「スカラー倍の結合律」を scalar_multiple_is_associative、「行列作用の有限和への分配法則」を finite_sum_of_matrices_distributes_in_left_factor、「ベクトルの有限和の分配法則」を finite_sum_of_scalar_multiples_of_one_matrix で引いた。sigma_z_diagonal_action の係数は実数の包含 μ(m)_ℂ なので、主張と証明の係数に ℝ→ℂ の包含を書き、包含と積・有限和の入れ替えを real_inclusion_preserves_product・real_inclusion_preserves_finite_sum で引いた。主張文に M_col ∈ ℤ_{≥2}（有限和の項数 M_col − 1 ≥ 1）を書いた。値は変えていない。",
      ],
    },
  },
  {
    id: "closing_claim_epsilon_D0_G_pairwise_commute",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 6 },
    title: { tex: String.raw`\varepsilon, D_0, G \text{ の二つずつの可換性}` },
    labels: ["epsilon_D0_G_pairwise_commute"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_D0_open_chain_operator"),
        " の ",
        math(String.raw`D_0`),
        " と ",
        ref("def_G_boundary_operator"),
        " の ",
        math(String.raw`G`),
        " と ",
        ref("def_global_spin_flip_matrix"),
        " の ",
        math(String.raw`\varepsilon`),
        " は、",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の中で二つずつ可換である。すなわち",
      ]),
      displayMath(String.raw`\varepsilon D_0 = D_0\varepsilon, \qquad
\varepsilon G = G\varepsilon, \qquad D_0G = GD_0`),
    ],
    proof: [
      paragraph([
        "準備（", math(String.raw`\varepsilon`), " と ", math(String.raw`\sigma^z`), " の対の可換）。各 ",
        math(String.raw`k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\varepsilon\sigma_k^z=-(\sigma_k^z\varepsilon)`),
        "（",
        ref("epsilon_anticommutes_with_site_sigma_z"),
        "）である。各 ",
        math(String.raw`j,k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon(\sigma_j^z\sigma_k^z)
&=(\varepsilon\sigma_j^z)\sigma_k^z
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\bigl(-(\sigma_j^z\varepsilon)\bigr)\sigma_k^z
&&\bigl(\because\ \blkref{epsilon_anticommutes_with_site_sigma_z}\ (k\to j)\bigr)\\
&=-\bigl((\sigma_j^z\varepsilon)\sigma_k^z\bigr)
&&\bigl(\because\ \blkref{negation_factors_out_of_left_factor}\bigr)\\
&=-\bigl(\sigma_j^z(\varepsilon\sigma_k^z)\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=-\Bigl(\sigma_j^z\bigl(-(\sigma_k^z\varepsilon)\bigr)\Bigr)
&&\bigl(\because\ \blkref{epsilon_anticommutes_with_site_sigma_z}\ (k\to k)\bigr)\\
&=-\Bigl(-\bigl(\sigma_j^z(\sigma_k^z\varepsilon)\bigr)\Bigr)
&&\bigl(\because\ \blkref{negation_factors_out_of_right_factor}\bigr)\\
&=\sigma_j^z(\sigma_k^z\varepsilon)
&&\bigl(\because\ \blkref{matrix_double_negation}\bigr)\\
&=(\sigma_j^z\sigma_k^z)\varepsilon
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr).
\end{aligned}`),
      paragraph([
        "準備（", math(String.raw`\sigma^z`), " どうしの可換）。各 ",
        math(String.raw`j,k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\sigma_j^z\sigma_k^z=\sigma_k^z\sigma_j^z`),
        " である。",
        math(String.raw`j\neq k`),
        " なら ",
        ref("distinct_site_pauli_matrices_commute"),
        "（",
        math(String.raw`a=b=z`),
        "）により、",
        math(String.raw`j=k`),
        " なら両辺は同じ行列である。",
      ]),
      paragraph([
        "準備（", math(String.raw`\sigma^z`), " の対と ", math(String.raw`G`), " の可換）。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}-1\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(\sigma_m^z\sigma_{m+1}^z)G
&=(\sigma_m^z\sigma_{m+1}^z)(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)
&&\bigl(\because\ \blkref{def_G_boundary_operator}\bigr)\\
&=\sigma_m^z\bigl(\sigma_{m+1}^z(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_m^z\bigl((\sigma_{m+1}^z\sigma_{M_{\mathrm{col}}}^z)\sigma_1^z\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_m^z\bigl((\sigma_{M_{\mathrm{col}}}^z\sigma_{m+1}^z)\sigma_1^z\bigr)
&&\bigl(\because\ \text{準備（}\sigma^z\text{ どうしの可換）}\ (j\to m+1,\ k\to M_{\mathrm{col}})\bigr)\\
&=\sigma_m^z\bigl(\sigma_{M_{\mathrm{col}}}^z(\sigma_{m+1}^z\sigma_1^z)\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_m^z\bigl(\sigma_{M_{\mathrm{col}}}^z(\sigma_1^z\sigma_{m+1}^z)\bigr)
&&\bigl(\because\ \text{準備（}\sigma^z\text{ どうしの可換）}\ (j\to m+1,\ k\to 1)\bigr)\\
&=(\sigma_m^z\sigma_{M_{\mathrm{col}}}^z)(\sigma_1^z\sigma_{m+1}^z)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_m^z)(\sigma_1^z\sigma_{m+1}^z)
&&\bigl(\because\ \text{準備（}\sigma^z\text{ どうしの可換）}\ (j\to m,\ k\to M_{\mathrm{col}})\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl(\sigma_m^z(\sigma_1^z\sigma_{m+1}^z)\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl((\sigma_m^z\sigma_1^z)\sigma_{m+1}^z\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl((\sigma_1^z\sigma_m^z)\sigma_{m+1}^z\bigr)
&&\bigl(\because\ \text{準備（}\sigma^z\text{ どうしの可換）}\ (j\to m,\ k\to 1)\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl(\sigma_1^z(\sigma_m^z\sigma_{m+1}^z)\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)(\sigma_m^z\sigma_{m+1}^z)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=G(\sigma_m^z\sigma_{m+1}^z)
&&\bigl(\because\ \blkref{def_G_boundary_operator}\bigr).
\end{aligned}`),
      paragraph([math(String.raw`\varepsilon D_0 = D_0\varepsilon`), " について。"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon D_0
&=\varepsilon\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)
&&\bigl(\because\ \blkref{def_D0_open_chain_operator}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}\varepsilon(\sigma_m^z\sigma_{m+1}^z)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_right_factor}\ (r\to M_{\mathrm{col}}-1)\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}(\sigma_m^z\sigma_{m+1}^z)\varepsilon
&&\bigl(\because\ \text{準備（}\varepsilon\text{ と }\sigma^z\text{ の対の可換）}\ (j\to m,\ k\to m+1)\bigr)\\
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)\varepsilon
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_left_factor}\ (r\to M_{\mathrm{col}}-1)\bigr)\\
&=D_0\varepsilon
&&\bigl(\because\ \blkref{def_D0_open_chain_operator}\bigr).
\end{aligned}`),
      paragraph([math(String.raw`\varepsilon G = G\varepsilon`), " について。"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon G
&=\varepsilon(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)
&&\bigl(\because\ \blkref{def_G_boundary_operator}\bigr)\\
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)\varepsilon
&&\bigl(\because\ \text{準備（}\varepsilon\text{ と }\sigma^z\text{ の対の可換）}\ (j\to M_{\mathrm{col}},\ k\to 1)\bigr)\\
&=G\varepsilon
&&\bigl(\because\ \blkref{def_G_boundary_operator}\bigr).
\end{aligned}`),
      paragraph([math(String.raw`D_0G = GD_0`), " について。"]),
      displayMath(String.raw`\begin{aligned}
D_0G
&=\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)G
&&\bigl(\because\ \blkref{def_D0_open_chain_operator}\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}(\sigma_m^z\sigma_{m+1}^z)G
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_left_factor}\ (r\to M_{\mathrm{col}}-1)\bigr)\\
&=\sum_{m=1}^{M_{\mathrm{col}}-1}G(\sigma_m^z\sigma_{m+1}^z)
&&\bigl(\because\ \text{準備（}\sigma^z\text{ の対と }G\text{ の可換）}\bigr)\\
&=G\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_right_factor}\ (r\to M_{\mathrm{col}}-1)\bigr)\\
&=GD_0
&&\bigl(\because\ \blkref{def_D0_open_chain_operator}\bigr).
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/epsilon_D0_G_pairwise_commute/。",
        "2026-11-04: SageMath の検算を付けるときに、名前だけの根拠をラベル参照にした。旧い証明は「(−σ_m^zε)σ_{m+1}^z = −σ_m^z(εσ_{m+1}^z)」で符号の括り出しと結合律を一行にまとめ、「(−1)(−1) = 1」で符号の括り出しと二重の符号反転をまとめ、D_0G の段で「kronecker_product_rule (1) を各サイトへ適用」して四つの因子を一度に並べ替えていた。符号の行を negation_factors_out_of_left_factor・negation_factors_out_of_right_factor・matrix_double_negation の行に分け、ε と二つの σ^z の積の可換を準備（ε と σ^z の対の可換）として一度だけ示して ε D_0・εG の両方で引き、並べ替えを distinct_site_pauli_matrices_commute（準備「σ^z どうしの可換」）と mat_mult_associative の行の鎖（準備「σ^z の対と G の可換」）にした。主張文に M_col ∈ ℤ_{≥2} と ε の定義を書いた。主張は変えていない。",
      ],
    },
  },
  {
    id: "closing_claim_epsilon_G_is_involution",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 6 },
    title: { tex: String.raw`\varepsilon G \text{ の二乗}` },
    labels: ["epsilon_G_is_involution"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_global_spin_flip_matrix"),
        " の ",
        math(String.raw`\varepsilon`),
        " と ",
        ref("def_G_boundary_operator"),
        " の ",
        math(String.raw`G`),
        " について",
      ]),
      displayMath(String.raw`(\varepsilon G)^2=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
      paragraph([
        "ここで ",
        math(String.raw`X\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " に対して ",
        math(String.raw`X^2:=XX`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`I:=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " とおく。各 ",
        math(String.raw`k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\sigma_k^z\sigma_k^z
&=\bigl(I\boxtimes\cdots\boxtimes\overbrace{\sigma^z}^{k\text{th}}\boxtimes\cdots\boxtimes I\bigr)
  \bigl(I\boxtimes\cdots\boxtimes\overbrace{\sigma^z}^{k\text{th}}\boxtimes\cdots\boxtimes I\bigr)
&&\bigl(\because\ \blkref{def_site_pauli_matrices}\bigr)\\
&=(II)\boxtimes\cdots\boxtimes\overbrace{(\sigma^z\sigma^z)}^{k\text{th}}\boxtimes\cdots\boxtimes(II)
&&\bigl(\because\ \blkref{kronecker_product_rule}\ (1)\bigr)\\
&=I\boxtimes\cdots\boxtimes\overbrace{(\sigma^z\sigma^z)}^{k\text{th}}\boxtimes\cdots\boxtimes I
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{を }k\text{ 以外の各サイトで}\bigr)\\
&=I\boxtimes\cdots\boxtimes\overbrace{I}^{k\text{th}}\boxtimes\cdots\boxtimes I
&&\bigl(\because\ \blkref{pauli_matrix_products}\ \text{の }\sigma^z\sigma^z=I\bigr)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\bigl(\because\ \blkref{kronecker_product_rule}\ (2)\bigr).
\end{aligned}`),
      paragraph([
        "主張について。",
        math(String.raw`M_{\mathrm{col}}\geq 2`),
        " より ",
        math(String.raw`M_{\mathrm{col}}\neq 1`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\varepsilon G)^2
&=(\varepsilon G)(\varepsilon G)
&&\bigl(\because\ X^2:=XX\bigr)\\
&=\bigl((\varepsilon G)\varepsilon\bigr)G
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\bigl(\varepsilon(G\varepsilon)\bigr)G
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\bigl(\varepsilon(\varepsilon G)\bigr)G
&&\bigl(\because\ \blkref{epsilon_D0_G_pairwise_commute}\ \text{の }\varepsilon G=G\varepsilon\bigr)\\
&=\bigl((\varepsilon\varepsilon)G\bigr)G
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\bigl(I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}G\bigr)G
&&\bigl(\because\ \blkref{epsilon_square_and_eigenvalues}\ \text{の }\varepsilon^2=\varepsilon\varepsilon=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\bigr)\\
&=GG
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)
&&\bigl(\because\ \blkref{def_G_boundary_operator}\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl(\sigma_1^z(\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl((\sigma_1^z\sigma_{M_{\mathrm{col}}}^z)\sigma_1^z\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl((\sigma_{M_{\mathrm{col}}}^z\sigma_1^z)\sigma_1^z\bigr)
&&\bigl(\because\ \blkref{distinct_site_pauli_matrices_commute}\ (j\to 1,\ k\to M_{\mathrm{col}},\ a=b=z)\bigr)\\
&=\sigma_{M_{\mathrm{col}}}^z\bigl(\sigma_{M_{\mathrm{col}}}^z(\sigma_1^z\sigma_1^z)\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=(\sigma_{M_{\mathrm{col}}}^z\sigma_{M_{\mathrm{col}}}^z)(\sigma_1^z\sigma_1^z)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\,I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\bigl(\because\ \text{準備を }k=M_{\mathrm{col}}\text{ と }k=1\text{ で}\bigr)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr).
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "数値検証: sagemath/check/epsilon_G_is_involution/。",
        "2026-11-04: SageMath の検算を付けるときに、旧い証明の「(εG)(εG) = ε^2G^2」（可換と結合律を一行にまとめた段）と「G^2 = (σ_{M_col}^z)^2(σ_1^z)^2」（相異なるサイトの因子の並べ替えを名前だけで行った段）を mat_mult_associative・epsilon_D0_G_pairwise_commute・distinct_site_pauli_matrices_commute の行の鎖に分け、(σ_k^z)^2 = I を準備の鎖にした。ε^2 = I の根拠が epsilon_projector_properties (1)（(P^{(+)})^2 = P^{(+)}）を指していた誤りを epsilon_square_and_eigenvalues に直した。主張文に M_col ∈ ℤ_{≥2}、ε の定義、右辺の単位行列の次数、X^2 := XX を書いた。主張は変えていない。",
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
        " の記号（",
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq 2}`),
        "、",
        math(String.raw`\mathfrak M`),
        "、",
        math(String.raw`E`),
        "）を用い、",
        math(String.raw`K\in\mathbb R`),
        " とする。",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の実数の exp、",
        math(String.raw`\cosh`),
        " は ",
        ref("def_cosh_sinh"),
        "、",
        math(String.raw`x^{n}`),
        "（",
        math(String.raw`x\in\mathbb R`),
        "、",
        math(String.raw`n\in\mathbb Z_{\geq1}`),
        "）は ",
        ref("def_finite_product_of_real_numbers"),
        " の ",
        math(String.raw`\prod_{j=1}^{n}x`),
        " である。このとき",
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
\Phi(s) := \left(s(1);\ t_1(s),\dots,t_{M_{\mathrm{col}}-1}(s)\right), \quad t_m(s) := s(m)s(m+1)\in\{-1,1\}`,
      ),
      paragraph([
        "は全単射である。実際、",
        math(String.raw`(u; \tau_1,\dots,\tau_{M_{\mathrm{col}}-1})\in\{-1,1\}\times\{-1,1\}^{M_{\mathrm{col}}-1}`),
        " が与えられれば ",
        math(String.raw`s(1) := u`),
        "、",
        math(String.raw`s(m+1) := s(m)\tau_m`),
        " により ",
        math(String.raw`s(2),\dots,s(M_{\mathrm{col}})`),
        " が順に一意に定まり（",
        math(String.raw`s(m)s(m) = 1`),
        " なので ",
        math(String.raw`s(m+1) = s(m)\tau_m`),
        " は ",
        math(String.raw`\tau_m = s(m)s(m+1)`),
        " と同値）、逆にこの手続きで作った ",
        math(String.raw`s`),
        " は ",
        math(String.raw`\Phi(s)`),
        " として元の組を与えるからである。両側の集合はともに ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 個の元をもつ。",
      ]),
      paragraph([
        "さらに写像 ",
        math(String.raw`\varsigma : \{0,1\} \to \{-1,1\}`),
        " を ",
        math(String.raw`\varsigma(e) := 2e - 1`),
        "（",
        math(String.raw`\varsigma(1) = 1`),
        "、",
        math(String.raw`\varsigma(0) = -1`),
        "）で定める。",
        math(String.raw`\varsigma`),
        " は全単射なので、",
        ref("def_sum_over_binary_words"),
        " の ",
        math(String.raw`\{0,1\}^{M_{\mathrm{col}}-1}`),
        " から ",
        math(String.raw`\{-1,1\}^{M_{\mathrm{col}}-1}`),
        " への写像 ",
        math(String.raw`\epsilon \mapsto (\varsigma(\epsilon_1),\dots,\varsigma(\epsilon_{M_{\mathrm{col}}-1}))`),
        " も全単射である（成分ごとに ",
        math(String.raw`\varsigma`),
        " の逆写像 ",
        math(String.raw`\tau \mapsto (\tau+1)/2`),
        " を当てたものが逆写像）。",
      ]),
      paragraph([
        "Step 2（スピン和の計算）。準備として、各 ",
        math(String.raw`s\in\mathfrak M`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(KE(s))
&= \exp\Bigl(K\sum_{m=1}^{M_{\mathrm{col}}-1}t_m(s)\Bigr)
   \quad (\because \blkref{def_open_chain_spin_energy}\text{ と Step 1 の } t_m(s) := s(m)s(m+1)) \\
&= \exp\Bigl(\sum_{m=1}^{M_{\mathrm{col}}-1}Kt_m(s)\Bigr)
   \quad (\because \mathbb R\text{ の分配則を有限和の各項へ}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}-1}\exp(Kt_m(s))
   \quad (\because \blkref{real_exp_of_finite_sum}\ (m \to M_{\mathrm{col}}-1,\ j \to m,\ x_j \to Kt_m(s)))
\end{aligned}`,
      ),
      paragraph(["である。これを使うと"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak{M}}\exp(KE(s))
&= \sum_{s\in\mathfrak{M}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\exp(Kt_m(s))
   \quad (\because \text{準備の等式を各項へ}) \\
&= \sum_{u\in\{-1,1\}}\ \sum_{\tau_1,\dots,\tau_{M_{\mathrm{col}}-1}\in\{-1,1\}}
   \prod_{m=1}^{M_{\mathrm{col}}-1}\exp(K\tau_m)
   \quad (\because \text{Step 1 の全単射 }\Phi\text{ で和の添字を }s\text{ から }(u;\tau_1,\dots,\tau_{M_{\mathrm{col}}-1})=\Phi(s)\text{ へ付け替える}) \\
&= \sum_{u\in\{-1,1\}}\ \sum_{\epsilon\in\{0,1\}^{M_{\mathrm{col}}-1}}
   \prod_{m=1}^{M_{\mathrm{col}}-1}\exp(K\varsigma(\epsilon_m))
   \quad (\because \text{Step 1 の全単射 }\epsilon \mapsto (\varsigma(\epsilon_1),\dots,\varsigma(\epsilon_{M_{\mathrm{col}}-1}))\text{ で内側の和の添字を付け替える}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K\varsigma(1))+\exp(K\varsigma(0))\right)
   \quad (\because \blkref{expansion_of_finite_product_of_two_term_sums_of_real_numbers}\ (r \to M_{\mathrm{col}}-1,\ j \to m,\ a_j^{(e)} \to \exp(K\varsigma(e)))\text{ を右辺から左辺へ、各 }u\text{ の項へ}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K\cdot 1)+\exp(K\cdot(-1))\right)
   \quad (\because \varsigma(1)=1,\ \varsigma(0)=-1\text{ を各因子へ}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)+\exp(K\cdot(-1))\right)
   \quad (\because \mathbb R\text{ で }a\cdot 1 = a\text{ を各因子へ}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)+\exp(-K)\right)
   \quad (\because \mathbb R\text{ で }a\cdot(-1) = -a\text{ を各因子へ}) \\
&= 2\prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)+\exp(-K)\right)
   \quad (\because u\text{ に依らない実数 }c\text{ の二元集合 }\{-1,1\}\text{ 上の和は }c + c = 2c) \\
&= 2\prod_{m=1}^{M_{\mathrm{col}}-1}\left(2\cosh K\right)
   \quad \left(\because \blkref{def_cosh_sinh}\ (x \to K)\text{ を各因子へ}\right) \\
&= 2\left(2\cosh K\right)^{M_{\mathrm{col}}-1}
   \quad (\because \text{主張の } x^{n} := \textstyle\prod_{j=1}^{n}x\ (x \to 2\cosh K,\ n \to M_{\mathrm{col}}-1))
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/open_chain_partition_sum/（旧: sagemath/check/053_claim_even_sector_closing/check_03 の M=2,…,8 の全配置の直接列挙）。",
        "2026-11-04: SageMath の検算を付けるときに、exp(KE(s)) = Π_m exp(Kt_m) の根拠が theorem_exp_product（二つの行列の主張）の n = 1 を指していた誤りを real_exp_of_finite_sum に直し、E(s) の書き替え・分配則・指数法則を準備の鎖に分けた。和の付け替えの行が準備の等式の適用も兼ねていたので二行に分けた。付け替えた後の和の添字を s(1)・t_m と同じ記号で書いていたのを u・τ_m にし、Step 1 の t_m を s の関数 t_m(s) と書いた。名前だけだった「有限個の因子の積の展開」は、写像 ς(e) := 2e − 1 で {0,1}^{M_col−1} の和へ付け替えて expansion_of_finite_product_of_two_term_sums_of_real_numbers を引く行にし、「二元集合上の二つの有限和」を ς の値・a·1 = a・a(−1) = −a・c + c = 2c の行に分けた。cosh の定義の行の前に置いていた文を行末のラベル参照にし、主張文に M_col ∈ ℤ_{≥2}・exp・cosh・冪の定義を書いた。主張は変えていない。",
      ],
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
        " の記号（",
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq 2}`),
        "、",
        math(String.raw`\mathfrak M`),
        "、",
        math(String.raw`E`),
        "）を用い、",
        math(String.raw`K\in\mathbb R`),
        " とする。",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の実数の exp、",
        math(String.raw`\sinh`),
        " は ",
        ref("def_cosh_sinh"),
        "、",
        math(String.raw`x^{n}`),
        "（",
        math(String.raw`x\in\mathbb R`),
        "、",
        math(String.raw`n\in\mathbb Z_{\geq1}`),
        "）は ",
        ref("def_finite_product_of_real_numbers"),
        " の ",
        math(String.raw`\prod_{j=1}^{n}x`),
        "、",
        math(String.raw`s(M_{\mathrm{col}})s(1)\in\{-1,1\}\subset\mathbb R`),
        " である。このとき",
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
        "Step 1（変数変換）。",
        ref("open_chain_partition_sum"),
        " の証明の Step 1 の全単射",
      ]),
      displayMath(
        String.raw`\Phi : \mathfrak{M} \longrightarrow \{-1,1\}\times\{-1,1\}^{M_{\mathrm{col}}-1},
\qquad
\Phi(s) := \left(s(1);\ t_1(s),\dots,t_{M_{\mathrm{col}}-1}(s)\right), \quad t_m(s) := s(m)s(m+1)\in\{-1,1\}`,
      ),
      paragraph([
        "を使う。",
        math(String.raw`(u;\tau_1,\dots,\tau_{M_{\mathrm{col}}-1})`),
        " から ",
        math(String.raw`s(1):=u`),
        "、漸化式 ",
        math(String.raw`s(m+1):=s(m)\tau_m`),
        " によって ",
        math(String.raw`s(2),\dots,s(M_{\mathrm{col}})`),
        " が一意に復元され、この復元は ",
        math(String.raw`\Phi`),
        " の逆写像になる。同じ証明の Step 1 の ",
        math(String.raw`\varsigma(e) := 2e-1`),
        " と全単射 ",
        math(String.raw`\epsilon \mapsto (\varsigma(\epsilon_1),\dots,\varsigma(\epsilon_{M_{\mathrm{col}}-1}))`),
        "（",
        math(String.raw`\{0,1\}^{M_{\mathrm{col}}-1}\to\{-1,1\}^{M_{\mathrm{col}}-1}`),
        "）も使う。",
      ]),
      paragraph([
        "Step 2（端点因子の書き替え）。各 ",
        math(String.raw`s\in\mathfrak M`),
        " について、",
        math(String.raw`M_{\mathrm{col}} = 2`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\prod_{m=1}^{1}t_m(s)
&= t_1(s)
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (m \to 1)\bigr)\\
&= s(1)s(2)
&&\bigl(\because\ t_1(s):=s(1)s(2)\bigr)\\
&= s(1)s(M_{\mathrm{col}})
&&\bigl(\because\ M_{\mathrm{col}} = 2\bigr)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`M_{\mathrm{col}} \geq 3`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\prod_{m=1}^{M_{\mathrm{col}}-1}t_m(s)
&= \prod_{m=1}^{M_{\mathrm{col}}-1}s(m)s(m+1)
&&\bigl(\because\ t_m(s):=s(m)s(m+1)\bigr)\\
&= s(1)\left(\prod_{m=2}^{M_{\mathrm{col}}-1}s(m)s(m)\right)s(M_{\mathrm{col}})
&&\bigl(\because\ \mathbb R\text{ の乗法の可換性と結合性}\bigr)\\
&= s(1)\left(\prod_{m=2}^{M_{\mathrm{col}}-1}1\right)s(M_{\mathrm{col}})
&&\bigl(\because\ s(m)s(m)=1\text{ を各 }m\text{ へ同時適用}\bigr)\\
&= s(1)s(M_{\mathrm{col}})
&&\bigl(\because\ 1\text{ の有限積は }1\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である（隣接する因子が対になって ",
        math(String.raw`1`),
        " になる。",
        math(String.raw`\prod_{m=2}^{M_{\mathrm{col}}-1}`),
        " は ",
        math(String.raw`M_{\mathrm{col}}-2\geq1`),
        " 個の因子の ",
        ref("def_finite_product_of_real_numbers"),
        " の積）。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(KE(s))
&= \exp\Bigl(K\sum_{m=1}^{M_{\mathrm{col}}-1}t_m(s)\Bigr)
   \quad (\because \blkref{def_open_chain_spin_energy}\text{ と Step 1 の } t_m(s) := s(m)s(m+1)) \\
&= \exp\Bigl(\sum_{m=1}^{M_{\mathrm{col}}-1}Kt_m(s)\Bigr)
   \quad (\because \mathbb R\text{ の分配則を有限和の各項へ}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}-1}\exp(Kt_m(s))
   \quad (\because \blkref{real_exp_of_finite_sum}\ (m \to M_{\mathrm{col}}-1,\ j \to m,\ x_j \to Kt_m(s)))
\end{aligned}`,
      ),
      paragraph(["である。これらから"]),
      displayMath(
        String.raw`\begin{aligned}
s(M_{\mathrm{col}})s(1)\exp(KE(s))
&= s(1)s(M_{\mathrm{col}})\exp(KE(s))
&&\bigl(\because\ \mathbb R\text{ の乗法の可換性}\bigr)\\
&= \left(\prod_{m=1}^{M_{\mathrm{col}}-1}t_m(s)\right)\exp(KE(s))
&&\bigl(\because\ \text{上の等式を右辺から左辺へ}\bigr)\\
&= \left(\prod_{m=1}^{M_{\mathrm{col}}-1}t_m(s)\right)\prod_{m=1}^{M_{\mathrm{col}}-1}\exp(Kt_m(s))
&&\bigl(\because\ \text{上の }\exp(KE(s))\text{ の鎖}\bigr)\\
&= \prod_{m=1}^{M_{\mathrm{col}}-1}\bigl(t_m(s)\exp(Kt_m(s))\bigr)
&&\bigl(\because\ \blkref{finite_product_of_real_products}\ (m \to M_{\mathrm{col}}-1,\ j \to m,\ x_j \to t_m(s),\ y_j \to \exp(Kt_m(s)))\text{ を右辺から左辺へ}\bigr)
\end{aligned}`,
      ),
      paragraph(["である。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak{M}}s(M_{\mathrm{col}})s(1)\exp(KE(s))
&= \sum_{s\in\mathfrak{M}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\bigl(t_m(s)\exp(Kt_m(s))\bigr)
   \quad (\because \text{直前の等式を各項へ}) \\
&= \sum_{u\in\{-1,1\}}\ \sum_{\tau_1,\dots,\tau_{M_{\mathrm{col}}-1}\in\{-1,1\}}
   \prod_{m=1}^{M_{\mathrm{col}}-1}\bigl(\tau_m\exp(K\tau_m)\bigr)
   \quad (\because \text{Step 1 の全単射 }\Phi\text{ で和の添字を }s\text{ から }(u;\tau_1,\dots,\tau_{M_{\mathrm{col}}-1})=\Phi(s)\text{ へ付け替える}) \\
&= \sum_{u\in\{-1,1\}}\ \sum_{\epsilon\in\{0,1\}^{M_{\mathrm{col}}-1}}
   \prod_{m=1}^{M_{\mathrm{col}}-1}\bigl(\varsigma(\epsilon_m)\exp(K\varsigma(\epsilon_m))\bigr)
   \quad (\because \text{Step 1 の全単射 }\epsilon \mapsto (\varsigma(\epsilon_1),\dots,\varsigma(\epsilon_{M_{\mathrm{col}}-1}))\text{ で内側の和の添字を付け替える}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\varsigma(1)\exp(K\varsigma(1))+\varsigma(0)\exp(K\varsigma(0))\right)
   \quad (\because \blkref{expansion_of_finite_product_of_two_term_sums_of_real_numbers}\ (r \to M_{\mathrm{col}}-1,\ j \to m,\ a_j^{(e)} \to \varsigma(e)\exp(K\varsigma(e)))\text{ を右辺から左辺へ、各 }u\text{ の項へ}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(1\cdot\exp(K\cdot 1)+(-1)\exp(K\cdot(-1))\right)
   \quad (\because \varsigma(1)=1,\ \varsigma(0)=-1\text{ を各因子へ}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K\cdot 1)+(-1)\exp(K\cdot(-1))\right)
   \quad (\because \mathbb R\text{ で }1\cdot b = b\text{ を各因子へ}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)+(-1)\exp(K\cdot(-1))\right)
   \quad (\because \mathbb R\text{ で }a\cdot 1 = a\text{ を各因子へ}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)+(-1)\exp(-K)\right)
   \quad (\because \mathbb R\text{ で }a\cdot(-1) = -a\text{ を各因子へ}) \\
&= \sum_{u\in\{-1,1\}}\ \prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)-\exp(-K)\right)
   \quad (\because \mathbb R\text{ で }a + (-1)b = a - b\text{ を各因子へ}) \\
&= 2\prod_{m=1}^{M_{\mathrm{col}}-1}\left(\exp(K)-\exp(-K)\right)
   \quad (\because u\text{ に依らない実数 }c\text{ の二元集合 }\{-1,1\}\text{ 上の和は }c + c = 2c) \\
&= 2\prod_{m=1}^{M_{\mathrm{col}}-1}\left(2\sinh K\right)
   \quad \left(\because \blkref{def_cosh_sinh}\ (x \to K)\text{ を各因子へ}\right) \\
&= 2\left(2\sinh K\right)^{M_{\mathrm{col}}-1}
   \quad (\because \text{主張の } x^{n} := \textstyle\prod_{j=1}^{n}x\ (x \to 2\sinh K,\ n \to M_{\mathrm{col}}-1))
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/open_chain_endpoint_product_sum/（旧: sagemath/check/053_claim_even_sector_closing/check_03 の M=2,…,8 の全配置の直接列挙）。",
        "2026-11-04: SageMath の検算を付けるときに、exp(KE(s)) = Π_m exp(Kt_m) の根拠が theorem_exp_product（二つの行列の主張）の n = 1 を指していた誤りを、open_chain_partition_sum の準備の等式（real_exp_of_finite_sum）に直した。Step 2 の Π_{m=2}^{M_col−1} は M_col = 2 で因子が無く def_finite_product_of_real_numbers が定めない積だったので、M_col = 2 を別の鎖にした。主張の左辺の因子 s(M_col)s(1) を Step 2 の s(1)s(M_col) へ移す可換性の行と、二つの有限積の因子を対にする行（finite_product_of_real_products）を、名前だけの「Step 1 の全単射と直前の等式」から分けた。別のブロックの証明の途中の等式を引かないよう、exp(KE(s)) の鎖をこの証明にも置いた。付け替えた後の和の添字を u・τ_m にし、積の展開を open_chain_partition_sum と同じく ς で expansion_of_finite_product_of_two_term_sums_of_real_numbers を引く行にした。主張文に M_col ∈ ℤ_{≥2}・exp・sinh・冪の定義を書いた。主張は変えていない。",
      ],
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
      paragraph(["準備として"]),
      displayMath(
        String.raw`\begin{aligned}
\cosh K &> 0
   \quad (\because \blkref{cosh_sinh_basic_properties}\ (1)\ (x \to K)) \\
2\cosh K &> 0
   \quad (\because 2>0\text{ と直前の行、正の実数どうしの積は正}) \\
\sinh K &> 0
   \quad (\because \blkref{cosh_sinh_basic_properties}\ (3)\ (x \to K>0)) \\
2\sinh K &> 0
   \quad (\because 2>0\text{ と直前の行、正の実数どうしの積は正}) \\
\prod_{j=1}^{M_{\mathrm{col}}-1}(2\cosh K) &> 0
   \quad (\because \blkref{finite_product_of_positive_reals_is_positive}\ (m \to M_{\mathrm{col}}-1\in\mathbb Z_{\geq1},\ r_j \to 2\cosh K)) \\
\prod_{j=1}^{M_{\mathrm{col}}-1}(2\sinh K) &> 0
   \quad (\because \blkref{finite_product_of_positive_reals_is_positive}\ (m \to M_{\mathrm{col}}-1\in\mathbb Z_{\geq1},\ r_j \to 2\sinh K))
\end{aligned}`,
      ),
      paragraph(["である。これらから"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak M}\exp(K E(s))
&=2\left(2\cosh K\right)^{M_{\mathrm{col}}-1}
   \quad (\because \blkref{open_chain_partition_sum}) \\
&=2\prod_{j=1}^{M_{\mathrm{col}}-1}\left(2\cosh K\right)
   \quad (\because \blkref{open_chain_partition_sum}\text{ の主張の冪の定義}) \\
&>0
   \quad (\because \text{上の準備の }\textstyle\prod_{j=1}^{M_{\mathrm{col}}-1}(2\cosh K)>0\text{ と }2>0\text{、正の実数どうしの積は正})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak M}s(M_{\mathrm{col}})s(1)\exp(K E(s))
&=2\left(2\sinh K\right)^{M_{\mathrm{col}}-1}
   \quad (\because \blkref{open_chain_endpoint_product_sum}) \\
&=2\prod_{j=1}^{M_{\mathrm{col}}-1}\left(2\sinh K\right)
   \quad (\because \blkref{open_chain_endpoint_product_sum}\text{ の主張の冪の定義}) \\
&>0
   \quad (\because \text{上の準備の }\textstyle\prod_{j=1}^{M_{\mathrm{col}}-1}(2\sinh K)>0\text{ と }2>0\text{、正の実数どうしの積は正})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "1次元 Ising 開鎖の分配関数と両端相関を挿入した和の正値性であり、trace_of_epsilon_V_plus の符号を決める。",
        "数値検証: sagemath/check/open_chain_spin_sums_positive/（旧: sagemath/check/053_claim_even_sector_closing/check_03）。",
        "式変形の書き方の統一（2026-09-04）。二つの正値性を、それぞれ主張の左辺から既証明の公式を経て正値へ至る一続きの式変形にし、使用した公式と双曲線関数の正値性を各行末から参照した。内容と根拠は変えていない。",
        "2026-11-04: SageMath の検算を付けるときに、名前だけで引いていた cosh_sinh_basic_properties の項を (1)（cosh K > 0）と (3)（K > 0 で sinh K > 0）と書き、冪を有限積に開く行を足し、「> 0」の根拠を一行ずつの準備の鎖（cosh K > 0・2cosh K > 0・sinh K > 0・2sinh K > 0・finite_product_of_positive_reals_is_positive の二行）に分けた。主張は変えていない。",
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
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とする。",
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
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`A\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " に対して ",
        math(String.raw`A^2:=AA`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\kappa := (K_1)_{\mathbb{C}} \in \mathbb{C}`),
        "（",
        ref("inclusion_rr_to_cc"),
        " の略記）、",
        math(String.raw`c := \tfrac{i}{2}\kappa = \bigl(i\,2_{\mathbb{C}}^{-1}\bigr)\kappa \in \mathbb{C}`),
        "（",
        math(String.raw`\tfrac{i}{2} = i\,2_{\mathbb{C}}^{-1}`),
        " は ",
        ref("def_complex_quotient"),
        " の商（",
        math(String.raw`z\to i,\ w\to2_{\mathbb{C}}`),
        "）。",
        math(String.raw`2_{\mathbb{C}}\in\mathbb{C}^{\times}`),
        " は ",
        ref("def_V1_plus_square_root"),
        " の読みに書いてある）、",
        math(String.raw`X := cH_1^{(+)} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " とおく（",
        ref("def_V1_plus_square_root"),
        " の ",
        math(String.raw`\tfrac{i}{2}K_1H_1^{(+)}`),
        " の読み方）。",
        math(String.raw`X`),
        " は自分自身と可換である。",
      ]),
      displayMath(String.raw`XX=XX\qquad\left(\because\ \text{等号の反射律}\right)`),
      paragraph([
        math(String.raw`c`),
        " を二つ足すと ",
        math(String.raw`i\kappa`),
        " になる（以下の結合律・可換律・分配律・単位元は ",
        ref("complex_numbers_form_a_field"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の体の公理、逆元は ",
        ref("multiplicative_group_of_cc"),
        " の逆元である）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c+c
&=\bigl(i\,2_{\mathbb{C}}^{-1}\bigr)\kappa+\bigl(i\,2_{\mathbb{C}}^{-1}\bigr)\kappa 
&&\left(\because\ c\ \text{の定義を 2 箇所へ}\right)\\
&=\bigl(i\,2_{\mathbb{C}}^{-1}\bigr)(\kappa+\kappa)
&&\left(\because\ \text{分配律}\right)\\
&=\bigl(i\,2_{\mathbb{C}}^{-1}\bigr)\bigl(\kappa 1_{\mathbb{C}}+\kappa 1_{\mathbb{C}}\bigr)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は積の単位元。2 箇所へ}\right)\\
&=\bigl(i\,2_{\mathbb{C}}^{-1}\bigr)\bigl(\kappa (1_{\mathbb{C}}+1_{\mathbb{C}})\bigr)
&&\left(\because\ \text{分配律}\right)\\
&=\bigl(i\,2_{\mathbb{C}}^{-1}\bigr)\bigl(\kappa 2_{\mathbb{C}}\bigr)
&&\left(\because\ \blkref{one_plus_one_is_two_in_cc}\ \text{（}2_{\mathbb{C}}\ \text{は}\ \blkref{def_V1_plus_square_root}\ \text{の}\ (2_{\mathbb{R}})_{\mathbb{C}}\text{）}\right)\\
&=\bigl(i\,2_{\mathbb{C}}^{-1}\bigr)\bigl(2_{\mathbb{C}}\kappa\bigr)
&&\left(\because\ \text{積の可換律}\right)\\
&=i\bigl(2_{\mathbb{C}}^{-1}\bigl(2_{\mathbb{C}}\kappa\bigr)\bigr)
&&\left(\because\ \text{積の結合律}\right)\\
&=i\bigl(\bigl(2_{\mathbb{C}}^{-1}2_{\mathbb{C}}\bigr)\kappa\bigr)
&&\left(\because\ \text{積の結合律}\right)\\
&=i\bigl(1_{\mathbb{C}}\kappa\bigr)
&&\left(\because\ 2_{\mathbb{C}}^{-1}\ \text{は}\ 2_{\mathbb{C}}\in\mathbb{C}^{\times}\ \text{の逆元。}\blkref{multiplicative_group_of_cc}\right)\\
&=i\kappa
&&\left(\because\ 1_{\mathbb{C}}\ \text{は積の単位元}\right).
\end{aligned}`,
      ),
      paragraph([
        "主張について。",
        math(String.raw`c_1 := c`),
        "、",
        math(String.raw`c_2 := c`),
        " とおく。",
        ref("V1_plus_exponential_representation"),
        " の右辺の ",
        math(String.raw`iK_1H_1^{(+)}`),
        " は ",
        math(String.raw`(i\kappa)H_1^{(+)}`),
        " と読む。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(V_1^{(+)}\right)^{1/2}\right)^2
&=\left(V_1^{(+)}\right)^{1/2}\left(V_1^{(+)}\right)^{1/2}
&&\left(\because\ A^2:=AA\right)\\
&=\exp\!\left(X\right)\exp\!\left(X\right)
&&\left(\because\ \blkref{def_V1_plus_square_root}\ \text{と}\ X\ \text{の定義を 2 箇所へ}\right)\\
&=\exp\!\left(X+X\right)
&&\left(\because\ \blkref{theorem_exp_product}\ (n\to 2^{M_{\mathrm{col}}},\ K\to\mathbb{C},\ A,B\to X)\ \text{と準備の}\ XX=XX\right)\\
&=\exp\!\left(cH_1^{(+)}+cH_1^{(+)}\right)
&&\left(\because\ X\ \text{の定義を 2 箇所へ}\right)\\
&=\exp\!\left(\sum_{j=1}^{2}\left(c_jH_1^{(+)}\right)\right)
&&\left(\because\ c_1=c_2=c\ \text{と}\ \blkref{def_finite_sum_of_matrices}\ (r\to 1,\ X_j\to c_jH_1^{(+)})\ \text{の}\ r=1\ \text{と}\ r+1=2\ \text{の段}\right)\\
&=\exp\!\left(\left(\sum_{j=1}^{2}c_j\right)H_1^{(+)}\right)
&&\left(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\ (m,n\to 2^{M_{\mathrm{col}}},\ r\to 2,\ A\to H_1^{(+)})\right)\\
&=\exp\!\left((c+c)H_1^{(+)}\right)
&&\left(\because\ \blkref{def_finite_sum_of_complex_numbers}\ (m\to 1,\ z_j\to c_j)\ \text{の}\ m=1\ \text{と}\ m+1=2\ \text{の段と}\ c_1=c_2=c\right)\\
&=\exp\!\left((i\kappa)H_1^{(+)}\right)
&&\left(\because\ \text{準備の}\ c+c=i\kappa\right)\\
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
        "2026-11-04（全証明の SageMath 検算）: 主張文に M_col ∈ ℤ_{≥2} と A^2 := AA を書いた。証明の「X の定義と同類項の加法」の一行を、c := (i 2_ℂ^{-1})(K_1)_ℂ を二つ足すと i(K_1)_ℂ になる準備の鎖（1_ℂ + 1_ℂ = 2_ℂ を含む）と、def_finite_sum_of_matrices・finite_sum_of_scalar_multiples_of_one_matrix（r = 2）・def_finite_sum_of_complex_numbers の行に分け、冪の定義の行を足した（主張は不変）。数値検証: sagemath/check/V1_plus_square_root_property/。",
        "2026-11-11（Lean の通しの証明のゴールラインの確認）: 準備の c の i/2 = i·2_C^{-1} を def_complex_quotient（z→i, w→2_C）の参照にし、2_C^{-1}2_C = 1_C の行の逆元と、鎖の前の段落の逆元の出典を multiplicative_group_of_cc の参照にした。鎖の式は変えていない。",
        "2026-11-10（Lean の通しの証明）: 準備の 1_ℂ+1_ℂ = 2_ℂ の 4 行の鎖を、同じ鎖を置いていたほかの証明と合わせて主張 one_plus_one_is_two_in_cc にし、ここではその参照にした。",
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
        "が成り立つ。ここで左辺は ",
        math(String.raw`\mathbb{C}`),
        " の元、右辺は ",
        math(String.raw`\mathbb{R}`),
        " の元であり、等号は左辺が右辺の像 ",
        math(String.raw`(\cdot)_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）に等しいことを、",
        math(String.raw`\in \mathbb{R}_{>0}`),
        " は右辺の実数が正であることを表す。右辺の ",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の実数の exp、",
        math(String.raw`\cosh, \sinh`),
        " は ",
        ref("def_cosh_sinh"),
        "、",
        math(String.raw`x^{n}`),
        " は ",
        ref("def_finite_product_of_real_numbers"),
        " の ",
        math(String.raw`\prod_{j=1}^{n}x`),
        " である。",
      ]),
      paragraph([
        "**この計算には ",
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
        "準備。記号を置く。",
        math(String.raw`\kappa := (K_1)_{\mathbb{C}} \in \mathbb{C}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）、",
        math(String.raw`B := \left(V_1^{(+)}\right)^{1/2}`),
        "（",
        ref("def_V1_plus_square_root"),
        "）、",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " とし、",
        ref("def_D0_open_chain_operator"),
        " の ",
        math(String.raw`D_0`),
        " と ",
        ref("def_G_boundary_operator"),
        " の ",
        math(String.raw`G`),
        " を用いる。",
        math(String.raw`s \in \mathfrak{M}`),
        " に対し ",
        math(String.raw`-s \in \mathfrak{M}`),
        " を ",
        math(String.raw`(-s)(m) := -s(m)`),
        " で定める。",
        ref("row_configuration_numbering_bijective"),
        " より ",
        math(String.raw`\mathrm{ord} : \mathfrak{M} \to \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " は全単射なので、",
        math(String.raw`a : \mathfrak{M} \to \mathbb{C}`),
        " について ",
        math(String.raw`\sum_{s\in\mathfrak{M}} a(s) := \sum_{k=1}^{2^{M_{\mathrm{col}}}} a\bigl(\mathrm{ord}^{-1}(k)\bigr)`),
        "（",
        ref("def_finite_sum_of_complex_numbers"),
        "）と定め、",
        math(String.raw`a : \mathfrak{M} \to \mathbb{R}`),
        " についても同じ式で ",
        ref("def_finite_sum_of_real_numbers"),
        " の和を定める（",
        ref("open_chain_partition_sum"),
        "・",
        ref("open_chain_endpoint_product_sum"),
        " の左辺の和もこの和である）。",
        ref("V1_plus_exponential_representation"),
        " の右辺の ",
        math(String.raw`iK_1H_1^{(+)}`),
        " は ",
        math(String.raw`(i\kappa)H_1^{(+)}`),
        " と読む。",
      ]),
      paragraph(["(P1) exp の中身の分解。"]),
      displayMath(
        String.raw`\begin{aligned}
(i\kappa)H_1^{(+)}
&= (\kappa i)H_1^{(+)}
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の可換律}) \\
&= \kappa\bigl(iH_1^{(+)}\bigr)
&&(\because \blkref{scalar_multiple_is_associative}) \\
&= \kappa\bigl(D_0 + \varepsilon G\bigr)
&&(\because \blkref{H1_plus_in_sigma_z_form}) \\
&= \kappa D_0 + \kappa(\varepsilon G)
&&(\because \blkref{scalar_multiple_distributes_over_matrix_sum})
\end{aligned}`,
      ),
      paragraph(["(P2) 二つの可換性。"]),
      displayMath(
        String.raw`\begin{aligned}
D_0(\varepsilon G)
&= (D_0\varepsilon)G
&&(\because \blkref{mat_mult_associative}) \\
&= (\varepsilon D_0)G
&&(\because \blkref{epsilon_D0_G_pairwise_commute}\ \text{の}\ \varepsilon D_0 = D_0\varepsilon) \\
&= \varepsilon(D_0G)
&&(\because \blkref{mat_mult_associative}) \\
&= \varepsilon(GD_0)
&&(\because \blkref{epsilon_D0_G_pairwise_commute}\ \text{の}\ D_0G = GD_0) \\
&= (\varepsilon G)D_0
&&(\because \blkref{mat_mult_associative})
\end{aligned}`,
      ),
      paragraph([
        "これに ",
        ref("commuting_with_scalar_multiple"),
        " を ",
        math(String.raw`(G, X, c) = (D_0, \varepsilon G, \kappa)`),
        " で当てて ",
        math(String.raw`D_0\bigl(\kappa(\varepsilon G)\bigr) = \bigl(\kappa(\varepsilon G)\bigr)D_0`),
        "、さらに ",
        math(String.raw`(G, X, c) = (\kappa(\varepsilon G), D_0, \kappa)`),
        " で当てて ",
        math(String.raw`\bigl(\kappa(\varepsilon G)\bigr)(\kappa D_0) = (\kappa D_0)\bigl(\kappa(\varepsilon G)\bigr)`),
        " を得る。また ",
        ref("epsilon_D0_G_pairwise_commute"),
        " の ",
        math(String.raw`\varepsilon D_0 = D_0\varepsilon`),
        " に ",
        ref("commuting_with_scalar_multiple"),
        " を ",
        math(String.raw`(G, X, c) = (\varepsilon, D_0, \kappa)`),
        " で当てて ",
        math(String.raw`\varepsilon(\kappa D_0) = (\kappa D_0)\varepsilon`),
        " を得る。",
      ]),
      paragraph([
        "(P3) ",
        math(String.raw`\varepsilon G`),
        " の冪。",
        ref("def_exp"),
        " の冪 ",
        math(String.raw`A^0 := I`),
        "、",
        math(String.raw`A^{n+1} := A^nA`),
        " について、",
        math(String.raw`j \in \mathbb{Z}_{\geq 0}`),
        " に関する帰納法で ",
        math(String.raw`(\varepsilon G)^{2j} = I`),
        " かつ ",
        math(String.raw`(\varepsilon G)^{2j+1} = \varepsilon G`),
        " を示す。",
        math(String.raw`j = 0`),
        " では ",
        math(String.raw`(\varepsilon G)^{0} = I`),
        "（冪の定義）であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\varepsilon G)^{2j+1}
&= (\varepsilon G)^{2j}(\varepsilon G)
&&(\because \text{冪の定義}) \\
&= I(\varepsilon G)
&&(\because \text{帰納法の仮定}\ (\varepsilon G)^{2j} = I) \\
&= \varepsilon G
&&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult}) \\[4pt]
(\varepsilon G)^{2j+2}
&= (\varepsilon G)^{2j+1}(\varepsilon G)
&&(\because \text{冪の定義}) \\
&= (\varepsilon G)(\varepsilon G)
&&(\because \text{直前の}\ (\varepsilon G)^{2j+1} = \varepsilon G) \\
&= (\varepsilon G)^2
&&(\because \blkref{epsilon_G_is_involution}\ \text{の}\ X^2 := XX) \\
&= I
&&(\because \blkref{epsilon_G_is_involution})
\end{aligned}`,
      ),
      paragraph([
        "(P4) スカラー倍の冪。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " に関する帰納法で ",
        math(String.raw`\bigl(\kappa(\varepsilon G)\bigr)^{n} = \kappa^{n}(\varepsilon G)^{n}`),
        "（",
        math(String.raw`\kappa^n`),
        " は ",
        ref("def_power_of_complex_number"),
        "）を示す。",
        math(String.raw`n = 0`),
        " では両辺とも ",
        math(String.raw`I`),
        " である（",
        math(String.raw`\kappa^0 = 1_{\mathbb{C}}`),
        "、",
        ref("scalar_multiple_by_one"),
        "）。",
        math(String.raw`X := \varepsilon G`),
        " と書くと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\kappa X)^{n+1}
&= (\kappa X)^{n}(\kappa X)
&&(\because \text{冪の定義}) \\
&= \bigl(\kappa^{n}X^{n}\bigr)(\kappa X)
&&(\because \text{帰納法の仮定}) \\
&= \kappa^{n}\bigl(X^{n}(\kappa X)\bigr)
&&(\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= \kappa^{n}\bigl(\kappa(X^{n}X)\bigr)
&&(\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= (\kappa^{n}\kappa)(X^{n}X)
&&(\because \blkref{scalar_multiple_is_associative}) \\
&= \kappa^{n+1}X^{n+1}
&&(\because \blkref{def_power_of_complex_number}\ \text{と冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "(P5) 基底ベクトルの成分。",
        math(String.raw`s, s' \in \mathfrak{M}`),
        " について、",
        math(String.raw`\delta_{s=s'} \in \{0_{\mathbb{C}},1_{\mathbb{C}}\}`),
        " を ",
        math(String.raw`s = s'`),
        " のとき ",
        math(String.raw`1_{\mathbb{C}}`),
        "、そうでないとき ",
        math(String.raw`0_{\mathbb{C}}`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl(f_{\iota(s)}\bigr)_{\mathrm{ord}(s')}
&= \bigl(f_{\iota(s)}\bigr)_{\nu(\iota(s'))}
&&(\because \blkref{config_numbering_equals_kronecker_numbering}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}}\bigl(e_{\iota(s)_m}\bigr)_{\iota(s')_m}
&&(\because \blkref{def_end_iso}\ \text{の}\ f_I \text{ と } \blkref{def_kronecker}\ \text{(1) の成分の式}) \\
&= \delta_{s=s'}
&&(\because \text{下の場合分け})
\end{aligned}`,
      ),
      paragraph([
        "最後の行の場合分け: ",
        math(String.raw`s = s'`),
        " なら全ての因子が ",
        math(String.raw`(e_i)_i = 1_{\mathbb{C}}`),
        "（",
        math(String.raw`e_1 = (1,0),\ e_2 = (0,1)`),
        "）なので、積は ",
        ref("finite_product_of_complex_ones"),
        " より ",
        math(String.raw`1_{\mathbb{C}}`),
        "。",
        math(String.raw`s \neq s'`),
        " なら ",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " は単射（",
        math(String.raw`i_m`),
        " から ",
        math(String.raw`s(m)`),
        " が読み戻せる）なので、ある ",
        math(String.raw`m`),
        " で ",
        math(String.raw`\iota(s)_m \neq \iota(s')_m`),
        " となり、その因子は ",
        math(String.raw`0_{\mathbb{C}}`),
        "。積は ",
        ref("finite_product_with_zero_factor_is_zero"),
        " より ",
        math(String.raw`0_{\mathbb{C}}`),
        "。",
      ]),
      paragraph([
        "列の読み取り: ",
        math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、",
        ref("row_configuration_numbering_bijective"),
        " より ",
        math(String.raw`l \neq \mathrm{ord}(s)`),
        " の番号は ",
        math(String.raw`t \neq s`),
        " なる ",
        math(String.raw`l = \mathrm{ord}(t)`),
        " と書けるので、上の式から ",
        math(String.raw`(f_{\iota(s)})_l = 0_{\mathbb{C}}`),
        "、",
        ref("complex_times_zero_is_zero"),
        " より ",
        math(String.raw`X_{\mathrm{ord}(s'),l}(f_{\iota(s)})_l = 0_{\mathbb{C}}`),
        " である。ゆえに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl(Xf_{\iota(s)}\bigr)_{\mathrm{ord}(s')}
&= \sum_{l=1}^{2^{M_{\mathrm{col}}}} X_{\mathrm{ord}(s'),l}\bigl(f_{\iota(s)}\bigr)_{l}
&&(\because \blkref{mat_mult}) \\
&= X_{\mathrm{ord}(s'),\mathrm{ord}(s)}\bigl(f_{\iota(s)}\bigr)_{\mathrm{ord}(s)}
&&(\because \blkref{finite_sum_with_single_nonzero_term}) \\
&= X_{\mathrm{ord}(s'),\mathrm{ord}(s)}\,1_{\mathbb{C}}
&&(\because \text{(P5) の}\ s' = s) \\
&= X_{\mathrm{ord}(s'),\mathrm{ord}(s)}
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`,
      ),
      paragraph([
        "Step 1（",
        math(String.raw`\varepsilon`),
        " を ",
        math(String.raw`V_1^{(+)}V_2`),
        " の前へ移す）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&= \mathrm{tr}\!\left(\varepsilon\,B\,V_2\,B\right)
&&(\because \blkref{def_V_plus}) \\
&= \mathrm{tr}\!\left(B\,\varepsilon\,V_2\,B\right)
&&(\because \blkref{epsilon_commutes_with_V1_plus_square_root}\ \text{の}\ \varepsilon B = B\varepsilon) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_2\,B\,B\right)
&&(\because \blkref{trace_basic_properties}\ \text{(2) を}\ A = B,\ B' = \varepsilon V_2B \text{ に}) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_2\,V_1^{(+)}\right)
&&\left(\because \blkref{V1_plus_square_root_property}\ \text{の}\ BB = V_1^{(+)}\right) \\
&= \mathrm{tr}\!\left(V_1^{(+)}\,\varepsilon\,V_2\right)
&&(\because \blkref{trace_basic_properties}\ \text{(2) を}\ A = \varepsilon V_2,\ B' = V_1^{(+)} \text{ に}) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_1^{(+)}\,V_2\right)
&&(\because \blkref{epsilon_commutes_with_V1_plus}\ \text{の}\ V_1^{(+)}\varepsilon=\varepsilon V_1^{(+)})
\end{aligned}`,
      ),
      paragraph([
        "（積の括弧は ",
        ref("mat_mult_associative"),
        " により省いている。）",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\varepsilon V_1^{(+)}`),
        " を対角行列と ",
        math(String.raw`\varepsilon`),
        "・",
        math(String.raw`G`),
        " で書く）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V_1^{(+)}
&= \exp\!\left((i\kappa)H_1^{(+)}\right)
&&(\because \blkref{V1_plus_exponential_representation}) \\
&= \exp\!\left(\kappa D_0 + \kappa(\varepsilon G)\right)
&&(\because \text{(P1)}) \\
&= \exp\!\left(\kappa D_0\right)\exp\!\left(\kappa(\varepsilon G)\right)
&&(\because \blkref{theorem_exp_product}\ \text{を}\ A = \kappa D_0,\ B = \kappa(\varepsilon G) \text{ に。可換性は (P2)})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_n := \bigl(\kappa(\varepsilon G)\bigr)^{n}`),
        "（",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        "）は、(P4)・(P3) より ",
        math(String.raw`n`),
        " が偶数のとき ",
        math(String.raw`\kappa^{n}I`),
        "、奇数のとき ",
        math(String.raw`\kappa^{n}(\varepsilon G) = (1_{\mathbb{C}}\kappa^{n})(\varepsilon G)`),
        "（",
        ref("complex_numbers_form_a_field"),
        " の積の単位元）である。ゆえに ",
        ref("exponential_series_of_even_odd_power_terms"),
        " の仮定を ",
        math(String.raw`d = 2^{M_{\mathrm{col}}}`),
        "、",
        math(String.raw`x = K_1`),
        "、",
        math(String.raw`A = I`),
        "、",
        math(String.raw`B = \varepsilon G`),
        "、",
        math(String.raw`c = 1_{\mathbb{C}}`),
        " で満たし、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(\kappa(\varepsilon G)\right)
&= \sum_{n=0}^{\infty}\Bigl(\frac{1}{n!}\Bigr)_{\mathbb{C}}\bigl(\kappa(\varepsilon G)\bigr)^{n}
&&(\because \blkref{def_exp}\ \text{(1)}) \\
&= (\cosh K_1)_{\mathbb{C}}\,I + \bigl(1_{\mathbb{C}}(\sinh K_1)_{\mathbb{C}}\bigr)(\varepsilon G)
&&(\because \blkref{exponential_series_of_even_odd_power_terms}) \\
&= (\cosh K_1)_{\mathbb{C}}\,I + (\sinh K_1)_{\mathbb{C}}(\varepsilon G)
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`,
      ),
      paragraph(["である。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon V_1^{(+)}
&= \varepsilon\Bigl(\exp(\kappa D_0)\exp\!\bigl(\kappa(\varepsilon G)\bigr)\Bigr)
&&(\because \text{この Step の最初の鎖}) \\
&= \bigl(\varepsilon\exp(\kappa D_0)\bigr)\exp\!\bigl(\kappa(\varepsilon G)\bigr)
&&(\because \blkref{mat_mult_associative}) \\
&= \bigl(\exp(\kappa D_0)\varepsilon\bigr)\exp\!\bigl(\kappa(\varepsilon G)\bigr)
&&(\because \blkref{commuting_matrix_commutes_with_exp}\ \text{を}\ A = \varepsilon,\ B = \kappa D_0 \text{ に。可換性は (P2)}) \\
&= \exp(\kappa D_0)\Bigl(\varepsilon\exp\!\bigl(\kappa(\varepsilon G)\bigr)\Bigr)
&&(\because \blkref{mat_mult_associative}) \\
&= \exp(\kappa D_0)\Bigl(\varepsilon\bigl((\cosh K_1)_{\mathbb{C}}I + (\sinh K_1)_{\mathbb{C}}(\varepsilon G)\bigr)\Bigr)
&&(\because \text{直前の}\ \exp(\kappa(\varepsilon G)) \text{ の鎖}) \\
&= \exp(\kappa D_0)\Bigl(\varepsilon\bigl((\cosh K_1)_{\mathbb{C}}I\bigr) + \varepsilon\bigl((\sinh K_1)_{\mathbb{C}}(\varepsilon G)\bigr)\Bigr)
&&(\because \blkref{mat_mult_distributes_over_sum_in_right_factor}) \\
&= \exp(\kappa D_0)\Bigl((\cosh K_1)_{\mathbb{C}}(\varepsilon I) + (\sinh K_1)_{\mathbb{C}}\bigl(\varepsilon(\varepsilon G)\bigr)\Bigr)
&&(\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= \exp(\kappa D_0)\Bigl((\cosh K_1)_{\mathbb{C}}\,\varepsilon + (\sinh K_1)_{\mathbb{C}}\bigl(\varepsilon(\varepsilon G)\bigr)\Bigr)
&&(\because \blkref{identity_matrix_is_right_unit_of_mat_mult}) \\
&= \exp(\kappa D_0)\Bigl((\cosh K_1)_{\mathbb{C}}\,\varepsilon + (\sinh K_1)_{\mathbb{C}}\bigl((\varepsilon\varepsilon)G\bigr)\Bigr)
&&(\because \blkref{mat_mult_associative}) \\
&= \exp(\kappa D_0)\Bigl((\cosh K_1)_{\mathbb{C}}\,\varepsilon + (\sinh K_1)_{\mathbb{C}}(IG)\Bigr)
&&(\because \blkref{epsilon_square_and_eigenvalues}\ \text{の}\ \varepsilon^2 = I) \\
&= \exp(\kappa D_0)\Bigl((\cosh K_1)_{\mathbb{C}}\,\varepsilon + (\sinh K_1)_{\mathbb{C}}\,G\Bigr)
&&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（成分の読み取り）。",
        math(String.raw`s, s' \in \mathfrak{M}`),
        " とする。",
      ]),
      paragraph([
        "(a) ",
        math(String.raw`D_0`),
        " と ",
        math(String.raw`G`),
        " の成分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(D_0)_{\mathrm{ord}(s'),\mathrm{ord}(s)}
&= \bigl(D_0f_{\iota(s)}\bigr)_{\mathrm{ord}(s')}
&&(\because \text{(P5) の列の読み取り}) \\
&= \Bigl(\bigl(E(s)\bigr)_{\mathbb{C}}f_{\iota(s)}\Bigr)_{\mathrm{ord}(s')}
&&(\because \blkref{D0_G_diagonal_action}\ \text{と}\ \blkref{def_open_chain_spin_energy}) \\
&= \bigl(E(s)\bigr)_{\mathbb{C}}\bigl(f_{\iota(s)}\bigr)_{\mathrm{ord}(s')}
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \bigl(E(s)\bigr)_{\mathbb{C}}\,\delta_{s=s'}
&&(\because \text{(P5)})
\end{aligned}`,
      ),
      paragraph([
        "であり、同じ 4 行で ",
        math(String.raw`G_{\mathrm{ord}(s'),\mathrm{ord}(s)} = \bigl(s(M_{\mathrm{col}})s(1)\bigr)_{\mathbb{C}}\,\delta_{s=s'}`),
        "（",
        ref("D0_G_diagonal_action"),
        " の ",
        math(String.raw`G`),
        " の式）である。",
        ref("row_configuration_numbering_bijective"),
        " より全ての番号は ",
        math(String.raw`\mathrm{ord}(s)`),
        " の形なので、",
        math(String.raw`D_0`),
        " も ",
        math(String.raw`G`),
        " も対角行列（",
        ref("def_diagonal_matrix"),
        "）であり、",
        math(String.raw`\kappa D_0`),
        " も対角行列で（",
        ref("def_matrix_scalar_multiple"),
        "・",
        ref("complex_times_zero_is_zero"),
        "）、その対角成分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\kappa D_0)_{\mathrm{ord}(s),\mathrm{ord}(s)}
&= \kappa\,\bigl(E(s)\bigr)_{\mathbb{C}}
&&(\because \blkref{def_matrix_scalar_multiple}\ \text{と (a)}) \\
&= \bigl(K_1E(s)\bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product})
\end{aligned}`,
      ),
      paragraph([
        "である。ゆえに ",
        ref("exp_of_diagonal_matrix"),
        " より ",
        math(String.raw`\exp(\kappa D_0)`),
        " は対角行列で、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl(\exp(\kappa D_0)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}
&= \exp\!\Bigl(\bigl(K_1E(s)\bigr)_{\mathbb{C}}\Bigr)
&&(\because \blkref{exp_of_diagonal_matrix}) \\
&= \Bigl(\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}
&&(\because \blkref{complex_exp_of_real_argument})
\end{aligned}`,
      ),
      paragraph([
        "(b) ",
        math(String.raw`\varepsilon f_{\iota(s)} = f_{\iota(-s)}`),
        "。理由：",
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
        "（",
        ref("def_global_spin_flip_matrix"),
        "）はすべての成分を入れ替えるので、",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        "（",
        math(String.raw`+1\mapsto1`),
        "、",
        math(String.raw`-1\mapsto2`),
        "）のもとで ",
        math(String.raw`\varepsilon f_{\iota(s)} = f_{\iota(-s)}`),
        " である。これと (P5) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon_{\mathrm{ord}(s'),\mathrm{ord}(s)}
&= \bigl(\varepsilon f_{\iota(s)}\bigr)_{\mathrm{ord}(s')}
&&(\because \text{(P5) の列の読み取り}) \\
&= \bigl(f_{\iota(-s)}\bigr)_{\mathrm{ord}(s')}
&&(\because \text{(b)}) \\
&= \delta_{-s=s'}
&&(\because \text{(P5)})
\end{aligned}`,
      ),
      paragraph([
        "(c) ",
        ref("def_transfer_matrix"),
        " より ",
        math(String.raw`(V_2)_{\mathrm{ord}(s),\mathrm{ord}(s')} = \Bigl(\exp\!\Bigl(K_2\sum_{m=1}^{M_{\mathrm{col}}}s(m)s'(m)\Bigr)\Bigr)_{\mathbb{C}}`),
        "（右辺の内側は ",
        ref("def_scalar_exp"),
        " の実数の exp）。",
        math(String.raw`s(m)s(m) = 1`),
        "、",
        math(String.raw`(-s(m))s(m) = -1`),
        " を ",
        math(String.raw`m = 1,\dots,M_{\mathrm{col}}`),
        " について足すと ",
        math(String.raw`(V_2)_{\mathrm{ord}(s),\mathrm{ord}(s)} = \bigl(\exp(K_2M_{\mathrm{col}})\bigr)_{\mathbb{C}}`),
        "、",
        math(String.raw`(V_2)_{\mathrm{ord}(-s),\mathrm{ord}(s)} = \bigl(\exp(-K_2M_{\mathrm{col}})\bigr)_{\mathbb{C}}`),
        " である。",
      ]),
      paragraph([
        "Step 4（対角成分）。",
        math(String.raw`s \in \mathfrak{M}`),
        " とする。",
        ref("mat_mult"),
        " の和 ",
        math(String.raw`\sum_{k=1}^{2^{M_{\mathrm{col}}}}`),
        " で、(a) の対角性・(b) の ",
        math(String.raw`\varepsilon_{\mathrm{ord}(s),k}`),
        " が ",
        math(String.raw`k \neq \mathrm{ord}(-s)`),
        " で ",
        math(String.raw`0_{\mathbb{C}}`),
        " であることから、",
        math(String.raw`0_{\mathbb{C}}`),
        " を掛けた項は ",
        ref("complex_zero_times_is_zero"),
        " で ",
        math(String.raw`0_{\mathbb{C}}`),
        " になり、",
        ref("finite_sum_with_single_nonzero_term"),
        " により一つの項だけが残る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl(\exp(\kappa D_0)(\varepsilon V_2)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}
&= \bigl(\exp(\kappa D_0)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}\,(\varepsilon V_2)_{\mathrm{ord}(s),\mathrm{ord}(s)}
&&(\because \blkref{mat_mult}\ \text{と (a) の}\ \exp(\kappa D_0) \text{ の対角性、} \blkref{finite_sum_with_single_nonzero_term}) \\
&= \bigl(\exp(\kappa D_0)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}\,\bigl(\varepsilon_{\mathrm{ord}(s),\mathrm{ord}(-s)}(V_2)_{\mathrm{ord}(-s),\mathrm{ord}(s)}\bigr)
&&(\because \blkref{mat_mult}\ \text{と (b)、} \blkref{finite_sum_with_single_nonzero_term}) \\
&= \bigl(\exp(\kappa D_0)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}\,\bigl(1_{\mathbb{C}}(V_2)_{\mathrm{ord}(-s),\mathrm{ord}(s)}\bigr)
&&(\because \text{(b) の}\ \delta_{-(-s)=s} = 1_{\mathbb{C}}) \\
&= \bigl(\exp(\kappa D_0)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}\,(V_2)_{\mathrm{ord}(-s),\mathrm{ord}(s)}
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の積の単位元}) \\
&= \Bigl(\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}\,(V_2)_{\mathrm{ord}(-s),\mathrm{ord}(s)}
&&(\because \text{(a)}) \\
&= \Bigl(\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}\,\bigl(\exp(-K_2M_{\mathrm{col}})\bigr)_{\mathbb{C}}
&&(\because \text{(c)}) \\
&= \Bigl(\exp(-K_2M_{\mathrm{col}})\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product}\ \text{と}\ \mathbb{R}\ \text{の積の可換律})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\bigl(\exp(\kappa D_0)(GV_2)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}
&= \bigl(\exp(\kappa D_0)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}\,(GV_2)_{\mathrm{ord}(s),\mathrm{ord}(s)}
&&(\because \blkref{mat_mult}\ \text{と (a) の}\ \exp(\kappa D_0) \text{ の対角性、} \blkref{finite_sum_with_single_nonzero_term}) \\
&= \bigl(\exp(\kappa D_0)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}\,\bigl(G_{\mathrm{ord}(s),\mathrm{ord}(s)}(V_2)_{\mathrm{ord}(s),\mathrm{ord}(s)}\bigr)
&&(\because \blkref{mat_mult}\ \text{と (a) の}\ G \text{ の対角性、} \blkref{finite_sum_with_single_nonzero_term}) \\
&= \Bigl(\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}\Bigl(\bigl(s(M_{\mathrm{col}})s(1)\bigr)_{\mathbb{C}}(V_2)_{\mathrm{ord}(s),\mathrm{ord}(s)}\Bigr)
&&(\because \text{(a)}) \\
&= \Bigl(\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}\Bigl(\bigl(s(M_{\mathrm{col}})s(1)\bigr)_{\mathbb{C}}\bigl(\exp(K_2M_{\mathrm{col}})\bigr)_{\mathbb{C}}\Bigr)
&&(\because \text{(c)}) \\
&= \Bigl(\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}\Bigl(s(M_{\mathrm{col}})s(1)\exp(K_2M_{\mathrm{col}})\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= \Bigl(\exp\bigl(K_1E(s)\bigr)\,s(M_{\mathrm{col}})s(1)\exp(K_2M_{\mathrm{col}})\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= \Bigl(\exp(K_2M_{\mathrm{col}})\bigl(s(M_{\mathrm{col}})s(1)\exp(K_1E(s))\bigr)\Bigr)_{\mathbb{C}}
&&(\because \mathbb{R}\ \text{の積の可換律・結合律})
\end{aligned}`,
      ),
      paragraph([
        "Step 5（トレースの計算）。",
        math(String.raw`S_{\cosh} := \sum_{s\in\mathfrak{M}}\exp\bigl(K_1E(s)\bigr) \in \mathbb{R}`),
        "、",
        math(String.raw`S_{\sinh} := \sum_{s\in\mathfrak{M}}s(M_{\mathrm{col}})s(1)\exp\bigl(K_1E(s)\bigr) \in \mathbb{R}`),
        " とおく。",
        ref("def_trace"),
        " と準備の和の定め方より ",
        math(String.raw`\mathrm{tr}(X) = \sum_{s\in\mathfrak{M}}X_{\mathrm{ord}(s),\mathrm{ord}(s)}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\exp(\kappa D_0)(\varepsilon V_2)\right)
&= \sum_{s\in\mathfrak{M}}\bigl(\exp(\kappa D_0)(\varepsilon V_2)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}
&&(\because \blkref{def_trace}\ \text{と準備の和の定め方}) \\
&= \sum_{s\in\mathfrak{M}}\Bigl(\exp(-K_2M_{\mathrm{col}})\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}
&&(\because \text{Step 4}) \\
&= \Bigl(\sum_{s\in\mathfrak{M}}\exp(-K_2M_{\mathrm{col}})\exp\bigl(K_1E(s)\bigr)\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_finite_sum}) \\
&= \bigl(\exp(-K_2M_{\mathrm{col}})\,S_{\cosh}\bigr)_{\mathbb{C}}
&&(\because \blkref{finite_sum_of_real_scalar_multiples}) \\[4pt]
\mathrm{tr}\!\left(\exp(\kappa D_0)(GV_2)\right)
&= \sum_{s\in\mathfrak{M}}\bigl(\exp(\kappa D_0)(GV_2)\bigr)_{\mathrm{ord}(s),\mathrm{ord}(s)}
&&(\because \blkref{def_trace}\ \text{と準備の和の定め方}) \\
&= \sum_{s\in\mathfrak{M}}\Bigl(\exp(K_2M_{\mathrm{col}})\bigl(s(M_{\mathrm{col}})s(1)\exp(K_1E(s))\bigr)\Bigr)_{\mathbb{C}}
&&(\because \text{Step 4}) \\
&= \Bigl(\sum_{s\in\mathfrak{M}}\exp(K_2M_{\mathrm{col}})\bigl(s(M_{\mathrm{col}})s(1)\exp(K_1E(s))\bigr)\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_finite_sum}) \\
&= \bigl(\exp(K_2M_{\mathrm{col}})\,S_{\sinh}\bigr)_{\mathbb{C}}
&&(\because \blkref{finite_sum_of_real_scalar_multiples})
\end{aligned}`,
      ),
      paragraph(["これらを使って"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
&= \mathrm{tr}\!\left(\varepsilon V_1^{(+)}V_2\right)
&&(\because \text{Step 1}) \\
&= \mathrm{tr}\!\Bigl(\Bigl(\exp(\kappa D_0)\bigl((\cosh K_1)_{\mathbb{C}}\,\varepsilon + (\sinh K_1)_{\mathbb{C}}\,G\bigr)\Bigr)V_2\Bigr)
&&(\because \text{Step 2}) \\
&= \mathrm{tr}\!\Bigl(\exp(\kappa D_0)\Bigl(\bigl((\cosh K_1)_{\mathbb{C}}\,\varepsilon + (\sinh K_1)_{\mathbb{C}}\,G\bigr)V_2\Bigr)\Bigr)
&&(\because \blkref{mat_mult_associative}) \\
&= \mathrm{tr}\!\Bigl(\exp(\kappa D_0)\Bigl(\bigl((\cosh K_1)_{\mathbb{C}}\,\varepsilon\bigr)V_2 + \bigl((\sinh K_1)_{\mathbb{C}}\,G\bigr)V_2\Bigr)\Bigr)
&&(\because \blkref{mat_mult_distributes_over_sum_in_left_factor}) \\
&= \mathrm{tr}\!\Bigl(\exp(\kappa D_0)\Bigl((\cosh K_1)_{\mathbb{C}}(\varepsilon V_2) + (\sinh K_1)_{\mathbb{C}}(GV_2)\Bigr)\Bigr)
&&(\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= \mathrm{tr}\!\Bigl(\exp(\kappa D_0)\bigl((\cosh K_1)_{\mathbb{C}}(\varepsilon V_2)\bigr) + \exp(\kappa D_0)\bigl((\sinh K_1)_{\mathbb{C}}(GV_2)\bigr)\Bigr)
&&(\because \blkref{mat_mult_distributes_over_sum_in_right_factor}) \\
&= \mathrm{tr}\!\Bigl((\cosh K_1)_{\mathbb{C}}\bigl(\exp(\kappa D_0)(\varepsilon V_2)\bigr) + (\sinh K_1)_{\mathbb{C}}\bigl(\exp(\kappa D_0)(GV_2)\bigr)\Bigr)
&&(\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= (\cosh K_1)_{\mathbb{C}}\,\mathrm{tr}\!\bigl(\exp(\kappa D_0)(\varepsilon V_2)\bigr) + (\sinh K_1)_{\mathbb{C}}\,\mathrm{tr}\!\bigl(\exp(\kappa D_0)(GV_2)\bigr)
&&(\because \blkref{trace_basic_properties}\ \text{(1)}) \\
&= (\cosh K_1)_{\mathbb{C}}\bigl(\exp(-K_2M_{\mathrm{col}})\,S_{\cosh}\bigr)_{\mathbb{C}} + (\sinh K_1)_{\mathbb{C}}\bigl(\exp(K_2M_{\mathrm{col}})\,S_{\sinh}\bigr)_{\mathbb{C}}
&&(\because \text{直前の二つの鎖}) \\
&= \bigl(\cosh K_1\,(\exp(-K_2M_{\mathrm{col}})\,S_{\cosh})\bigr)_{\mathbb{C}} + \bigl(\sinh K_1\,(\exp(K_2M_{\mathrm{col}})\,S_{\sinh})\bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= \bigl(\cosh K_1\,(\exp(-K_2M_{\mathrm{col}})\,S_{\cosh}) + \sinh K_1\,(\exp(K_2M_{\mathrm{col}})\,S_{\sinh})\bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_sum})
\end{aligned}`,
      ),
      paragraph([
        "であり、括弧の中の実数は、",
        math(String.raw`x^{n} := \prod_{j=1}^{n}x`),
        "（",
        ref("def_finite_product_of_real_numbers"),
        "。",
        math(String.raw`M_{\mathrm{col}}-1 \geq 1`),
        "）と ",
        math(String.raw`\sum_{j=1}^{M_{\mathrm{col}}}(\mp K_2) = \mp K_2M_{\mathrm{col}}`),
        " を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\cosh K_1\,(\exp(-K_2M_{\mathrm{col}})\,S_{\cosh}) + \sinh K_1\,(\exp(K_2M_{\mathrm{col}})\,S_{\sinh}) \\
&= \cosh K_1\,\Bigl(\exp(-K_2M_{\mathrm{col}})\cdot 2\left(2\cosh K_1\right)^{M_{\mathrm{col}}-1}\Bigr)
 + \sinh K_1\,\Bigl(\exp(K_2M_{\mathrm{col}})\cdot 2\left(2\sinh K_1\right)^{M_{\mathrm{col}}-1}\Bigr)
&&(\because \blkref{open_chain_partition_sum}\ \text{と}\ \blkref{open_chain_endpoint_product_sum}\ \text{を}\ K = K_1 \text{ に}) \\
&= \exp(-K_2M_{\mathrm{col}})\Bigl(\left(2\cosh K_1\right)^{M_{\mathrm{col}}-1}\left(2\cosh K_1\right)\Bigr)
 + \exp(K_2M_{\mathrm{col}})\Bigl(\left(2\sinh K_1\right)^{M_{\mathrm{col}}-1}\left(2\sinh K_1\right)\Bigr)
&&(\because \mathbb{R}\ \text{の積の可換律・結合律}) \\
&= \exp(-K_2M_{\mathrm{col}})\left(2\cosh K_1\right)^{M_{\mathrm{col}}}
 + \exp(K_2M_{\mathrm{col}})\left(2\sinh K_1\right)^{M_{\mathrm{col}}}
&&(\because \blkref{def_finite_product_of_real_numbers}\ \text{の帰納的定義}) \\
&= \exp\Bigl(\sum_{j=1}^{M_{\mathrm{col}}}(-K_2)\Bigr)\left(2\cosh K_1\right)^{M_{\mathrm{col}}}
 + \exp\Bigl(\sum_{j=1}^{M_{\mathrm{col}}}K_2\Bigr)\left(2\sinh K_1\right)^{M_{\mathrm{col}}}
&&(\because \mathbb{R}\ \text{の有限和: 同じ実数}\ \mp K_2 \text{ を}\ M_{\mathrm{col}} \text{ 個足すと}\ \mp K_2M_{\mathrm{col}}) \\
&= \Bigl(\prod_{j=1}^{M_{\mathrm{col}}}\exp(-K_2)\Bigr)\left(2\cosh K_1\right)^{M_{\mathrm{col}}}
 + \Bigl(\prod_{j=1}^{M_{\mathrm{col}}}\exp(K_2)\Bigr)\left(2\sinh K_1\right)^{M_{\mathrm{col}}}
&&(\because \blkref{real_exp_of_finite_sum}) \\
&= \Bigl(\prod_{j=1}^{M_{\mathrm{col}}}\exp(-K_2)\Bigr)\Bigl(\prod_{j=1}^{M_{\mathrm{col}}}2\cosh K_1\Bigr)
 + \Bigl(\prod_{j=1}^{M_{\mathrm{col}}}\exp(K_2)\Bigr)\Bigl(\prod_{j=1}^{M_{\mathrm{col}}}2\sinh K_1\Bigr)
&&(\because \text{冪の定義}\ x^{n} := \textstyle\prod_{j=1}^{n}x) \\
&= \prod_{j=1}^{M_{\mathrm{col}}}\bigl(\exp(-K_2)\cdot 2\cosh K_1\bigr)
 + \prod_{j=1}^{M_{\mathrm{col}}}\bigl(\exp(K_2)\cdot 2\sinh K_1\bigr)
&&(\because \blkref{finite_product_of_real_products}) \\
&= \left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}} + \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}}
&&(\because \mathbb{R}\ \text{の積の可換律・結合律と冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "に等しい。ゆえに主張の等号が成り立つ。",
      ]),
      paragraph([
        "Step 6（正値性）。",
        ref("open_chain_spin_sums_positive"),
        " を ",
        math(String.raw`K = K_1`),
        " として ",
        math(String.raw`S_{\cosh} > 0`),
        "、",
        math(String.raw`S_{\sinh} > 0`),
        "。",
        ref("cosh_sinh_basic_properties"),
        " (3) と ",
        math(String.raw`K_1 > 0`),
        " から ",
        math(String.raw`\cosh K_1 > 0`),
        "、",
        math(String.raw`\sinh K_1 > 0`),
        "。",
        ref("real_exp_positive"),
        " から ",
        math(String.raw`\exp(\mp K_2M_{\mathrm{col}}) > 0`),
        "。正の実数の積は正なので、Step 5 の最後の鎖の左辺の二項はともに正であり、正の実数の和は正なので、左辺は正である。それが右辺に等しいので ",
        math(String.raw`\left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}} + \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}} \in \mathbb{R}_{>0}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04（全証明の SageMath 検算。sagemath/check/trace_of_epsilon_V_plus/）: 名前だけの根拠と散文の推論を (∵) 付きの鎖にした。準備に κ := (K_1)_ℂ・-s・𝔐 の上の和（ord による）を置き、(P1) (iκ)H_1^{(+)} = κD_0 + κ(εG)、(P2) 可換性、(P3) (εG)^{2j} = I・(εG)^{2j+1} = εG の帰納法、(P4) (κ(εG))^n = κ^n(εG)^n、(P5) f_{ι(s)} の成分を足した。exp(K_1εG) の偶奇の分割は exponential_series_of_even_odd_power_terms（A = I、B = εG、c = 1_ℂ）に、εV_1^{(+)} の分配則の一行を分配・スカラーの括り出し・単位元・結合律の行に分けた。Step 3 の成分は行列の番号を ord(s)（= ν(ι(s))）で書き、G_{ord(s),ord(s)} = (s(M_col)s(1))_ℂ・exp(κD_0) の対角成分 = (exp(K_1E(s)))_ℂ と包含を書いた（complex_exp_of_real_argument）。Step 4・5 は対角成分と和を包含の形で書き、2·2^{M−1} = 2^M の一行を (2cosh K_1)^{M−1}(2cosh K_1) = (2cosh K_1)^M・real_exp_of_finite_sum・finite_product_of_real_products の行に分けた。主張文に、左辺 ∈ ℂ と右辺 ∈ ℝ の等号を包含で読むことを書いた。値は変えていない。Lean（ClaimTraceEpsilonVPlusReduction.lean・ClaimTraceEpsilonVPlusClosedForm.lean）は旧い Step の分け方のままで、新しい鎖との 1 対 1 は Lean の連続実行が受け持つ。",
        "2026-11-04（Lean の通しの証明のゴールラインの確認）: 証明の冒頭の B の右辺 exp((1/2)iK_1H_1^{(+)}) を、def_V1_plus_square_root の式どおり exp((i/2)K_1H_1^{(+)}) に書いた（i/2 := i·2_C^{-1} の読みと食い違わないように。値は不変）。",
        "この主張が章 C′ の最後の欠けていた入力である。ε の固有値 η がどちらになるかは固有値 Λ̌_ε の値からは読めないが、tr(εV^{(+)}) は転送行列の側で完全に初等的に計算でき、しかも正であることが分かる。",
        "数値検証: sagemath/check/trace_of_epsilon_V_plus/（旧い記録は sagemath/check/053_claim_even_sector_closing/check_03）。",
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
        "準備。",
        math(String.raw`\eta_\epsilon \in \{+1,-1\}`),
        " の ",
        math(String.raw`+1, -1`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`1_{\mathbb{C}}`),
        " と ",
        math(String.raw`-1_{\mathbb{C}}`),
        "（",
        ref("epsilon_eigenvalue_on_check_Q"),
        " (1) の ",
        math(String.raw`\eta_\epsilon`),
        " は行列のスカラー倍の係数なので ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
        ref("trace_of_epsilon_V_plus_via_check_eigenvalues"),
        " も ",
        math(String.raw`\eta_{(1,\dots,1)}`),
        " をこう読む）であり、",
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`(-1)_{\mathbb{C}}`),
        " の略記（",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-z`),
        " とは別の記号）、",
        math(String.raw`(-1)^{k}`),
        "（",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        "）は ",
        ref("def_power_of_complex_number"),
        " の ",
        math(String.raw`(-1_{\mathbb{C}})^{k}`),
        " である。(P1) ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-1)^{k}(-1)^{k}
&= \left((-1_{\mathbb{C}})(-1_{\mathbb{C}})\right)^{k}
&&(\because\ \text{可換な二数の冪の積 } z^{k}w^{k} = (zw)^{k}\text{（}\blkref{def_power_of_complex_number}\text{ から } k \text{ の帰納法と、}\blkref{complex_numbers_form_a_field}\text{ の乗法の結合則・交換則）}) \\
&= \left(\left((-1)(-1)\right)_{\mathbb{C}}\right)^{k}
&&(\because\ \blkref{real_inclusion_preserves_product}) \\
&= 1_{\mathbb{C}}^{\,k}
&&(\because\ \mathbb{R}\ \text{の四則}\ (-1)(-1) = 1) \\
&= 1_{\mathbb{C}}
&&(\because\ 1_{\mathbb{C}}^{\,k+1} = 1_{\mathbb{C}}^{\,k}1_{\mathbb{C}}\text{（}\blkref{def_power_of_complex_number}\text{）と } 1_{\mathbb{C}}\text{ が乗法の単位元であること（}\blkref{complex_numbers_form_a_field}\text{）から } k \text{ の帰納法})
\end{aligned}`,
      ),
      paragraph([
        "(P2) ",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " について ",
        math(String.raw`\{\mu \in \check{\mathcal{M}} \mid \epsilon_\mu = 1\} \subseteq \check{\mathcal{M}}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|\epsilon|
&= \#\{\mu \in \check{\mathcal{M}} \mid \epsilon_\mu = 1\}
&&(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\text{ の } |\epsilon| \text{ の置き方}) \\
&\leq \#\check{\mathcal{M}}
&&(\because\ \text{有限集合の部分集合の元の個数は全体の元の個数以下}) \\
&= M_{\mathrm{col}}
&&(\because\ \blkref{def_check_index_set}\text{ の } \check{\mathcal{M}} = \{1,\dots,M_{\mathrm{col}}\})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`M_{\mathrm{col}} - |\epsilon| \in \mathbb{Z}_{\geq 0}`),
        " である。",
      ]),
      paragraph([
        "(1) ",
        math(String.raw`r := \left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}} + \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}} \in \mathbb{R}`),
        " とおく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
& \mathrm{tr}\!\left(\varepsilon V^{(+)}\right) = r_{\mathbb{C}}\ \text{かつ}\ r \in \mathbb{R}_{>0}
&&(\because\ \blkref{trace_of_epsilon_V_plus}\text{ とその等号と } \in \mathbb{R}_{>0} \text{ の読み方}) \\
\Longrightarrow\ & \mathrm{tr}\!\left(\varepsilon V^{(+)}\right) > 0
&&(\because\ \blkref{trace_of_epsilon_V_plus_via_check_eigenvalues}\text{ の } \mathbb{C} \text{ の元の } z > 0 \text{ の定め方}\ (z \to \mathrm{tr}(\varepsilon V^{(+)})\text{、存在する実数として } r \text{ を取る})) \\
\Longrightarrow\ & \eta_{(1,\dots,1)} = +1
&&(\because\ \blkref{trace_of_epsilon_V_plus_via_check_eigenvalues}\ \text{(3) の同値の}\ \Longleftarrow)
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " を取る。指数はすべて (P2) により ",
        math(String.raw`\mathbb{Z}_{\geq 0}`),
        " の元である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\eta_\epsilon
&= \eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|}
&&(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\ \text{(3)}) \\
&= 1_{\mathbb{C}}(-1)^{M_{\mathrm{col}}-|\epsilon|}
&&(\because\ \text{(1)}) \\
&= (-1)^{M_{\mathrm{col}}-|\epsilon|}
&&(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field}) \\
&= (-1)^{M_{\mathrm{col}}-|\epsilon|}\,1_{\mathbb{C}}
&&(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field}) \\
&= (-1)^{M_{\mathrm{col}}-|\epsilon|}\left((-1)^{|\epsilon|}(-1)^{|\epsilon|}\right)
&&(\because\ \text{(P1)}\ (k \to |\epsilon|)\ \text{を右辺から左辺へ}) \\
&= \left((-1)^{M_{\mathrm{col}}-|\epsilon|}(-1)^{|\epsilon|}\right)(-1)^{|\epsilon|}
&&(\because\ \blkref{complex_numbers_form_a_field}\text{ の乗法の結合則}) \\
&= (-1)^{M_{\mathrm{col}}}(-1)^{|\epsilon|}
&&(\because\ \text{非負の指数の指数法則 } z^{a}z^{b} = z^{a+b}\text{（}\blkref{def_power_of_complex_number}\text{ から } b \text{ の帰納法）}\ (a \to M_{\mathrm{col}}-|\epsilon|,\ b \to |\epsilon|)) \\
&= (-1)^{M_{\mathrm{col}}+|\epsilon|}
&&(\because\ \text{同じ指数法則}\ (a \to M_{\mathrm{col}},\ b \to |\epsilon|))
\end{aligned}`,
      ),
      paragraph([
        "これで ",
        math(String.raw`\eta_\epsilon = (-1)^{M_{\mathrm{col}}-|\epsilon|} = (-1)^{M_{\mathrm{col}}+|\epsilon|}`),
        " を得た（三行目と最後の行）。行列の式は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\check{Q}_\epsilon
&= \eta_\epsilon\check{Q}_\epsilon
&&(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\ \text{(1)}) \\
&= (-1)^{M_{\mathrm{col}}+|\epsilon|}\check{Q}_\epsilon
&&(\because\ \text{上の鎖の } \eta_\epsilon = (-1)^{M_{\mathrm{col}}+|\epsilon|})
\end{aligned}`,
      ),
      paragraph(["(3)"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon
&= \left(\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}}\right)\prod_{\mu=1}^{M_{\mathrm{col}}}\left(I - 2\check{n}_\mu\right)
&&(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\ \text{(4)}) \\
&= \left(1_{\mathbb{C}}(-1)^{M_{\mathrm{col}}}\right)\prod_{\mu=1}^{M_{\mathrm{col}}}\left(I - 2\check{n}_\mu\right)
&&(\because\ \text{(1)}) \\
&= (-1)^{M_{\mathrm{col}}}\prod_{\mu=1}^{M_{\mathrm{col}}}\left(I - 2\check{n}_\mu\right)
&&(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field})
\end{aligned}`,
      ),
      paragraph([
        "(4) まず ",
        math(String.raw`\varepsilon\check{Q}_{(1,\dots,1)} = \check{Q}_{(1,\dots,1)}`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\check{Q}_{(1,\dots,1)}
&= \eta_{(1,\dots,1)}\check{Q}_{(1,\dots,1)}
&&(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\ \text{(1)}\ (\epsilon \to (1,\dots,1))) \\
&= 1_{\mathbb{C}}\check{Q}_{(1,\dots,1)}
&&(\because\ \text{(1)}) \\
&= \check{Q}_{(1,\dots,1)}
&&(\because\ \blkref{scalar_multiple_by_one})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`y \in \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " を取ると、",
        math(String.raw`y = \check{Q}_{(1,\dots,1)}x`),
        " なる ",
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " が取れる（数ベクトルは ",
        ref("mat_mult"),
        " の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 行 1 列の行列）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_{(1,\dots,1)}y
&= \check{Q}_{(1,\dots,1)}\left(\check{Q}_{(1,\dots,1)}x\right)
&&(\because\ y = \check{Q}_{(1,\dots,1)}x \text{ の取り方}) \\
&= \left(\check{Q}_{(1,\dots,1)}\check{Q}_{(1,\dots,1)}\right)x
&&(\because\ \blkref{mat_mult_associative}) \\
&= \check{Q}_{(1,\dots,1)}x
&&(\because\ \blkref{check_joint_eigenspace_decomposition}\ \text{(1) の}\ \check{Q}_\epsilon^2 = \check{Q}_\epsilon\ (\epsilon \to (1,\dots,1))) \\
&= y
&&(\because\ y = \check{Q}_{(1,\dots,1)}x \text{ の取り方})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon y
&= \varepsilon\left(\check{Q}_{(1,\dots,1)}y\right)
&&(\because\ \text{直前の鎖の } \check{Q}_{(1,\dots,1)}y = y) \\
&= \left(\varepsilon\check{Q}_{(1,\dots,1)}\right)y
&&(\because\ \blkref{mat_mult_associative}) \\
&= \check{Q}_{(1,\dots,1)}y
&&(\because\ \text{上の鎖の } \varepsilon\check{Q}_{(1,\dots,1)} = \check{Q}_{(1,\dots,1)}) \\
&= y
&&(\because\ \text{直前の鎖の } \check{Q}_{(1,\dots,1)}y = y)
\end{aligned}`,
      ),
      paragraph([
        "なので、",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`y \in \mathcal{F}^{(+)}`),
        "。",
        math(String.raw`y`),
        " は ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " の任意の元なので ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)} \subseteq \mathcal{F}^{(+)}`),
        " である。言い換えの部分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\{x \in \mathbb{C}^{2^{M_{\mathrm{col}}}} \;\middle|\; V^{(+)}x = \check\Lambda_{\max}x\right\}
&= \mathrm{im}\,\check{Q}_{(1,\dots,1)}
&&(\because\ \blkref{max_eigenvalue_of_V_plus_simple}\ \text{(3)}) \\
&\subseteq \mathcal{F}^{(+)}
&&(\because\ \text{上で示した包含})
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "(3) は 004 章の ε = i^M (Z_1Y_1)⋯(Z_MY_M) の半整数運動量フェルミオンによる言い換えであり、「ε は数演算子のパリティである」という物理でよく知られた事実にあたる。本文ではこれを Λ̌_max の固有ベクトルが偶セクターに属することを示すためだけに使う。",
        "符号 (−1)^M が付くのは ň_μ = ψ̌_μ^† ψ̌_{M+1−μ} が「同じモードの ψ^†ψ」ではなく共役なモードの対で定義されているためで、真空 ε = (0,…,0) の側のパリティが (−1)^M になる。M の偶奇によらず最大固有ベクトル（ε = (1,…,1)）のパリティが +1 になる点が重要である。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_02（η_ε = (−1)^{M+|ε|} と ε = (−1)^M Π(I − 2ň_μ) を M=2,3,4,5・6 組の (K_1,K_2) で確認。残差 ≤ 2e-14）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-11-04（全証明の SageMath 検算）: 散文の推論を (∵) 付きの鎖にした。主張は変えていない。(1) は trace_of_epsilon_V_plus の読み方（左辺が右辺の像 r_ℂ、r ∈ ℝ_{>0}）と trace_of_epsilon_V_plus_via_check_eigenvalues の z > 0 の定め方をつなぐ行を足した 3 行の含意の鎖に、(2) の「(1) を代入して」と定義の無い負の冪 (−1)^{−|ϵ|} を、準備 (P1) (−1)^k(−1)^k = 1_ℂ・(P2) |ϵ| ≤ M_col と非負の冪だけの 8 行の鎖に、(3) を 3 行の鎖に、(4) の εQ̌_{(1,…,1)} = Q̌_{(1,…,1)} を、Lean の具体版の epsilon_mul_Qproj_univ と同じ η_{(1,…,1)} = +1 を代入する 3 行の鎖に、「冪等性より y = Q̌y」を y = Q̌x からの 4 行の鎖に、言い換えを max_eigenvalue_of_V_plus_simple (3) を引く 2 行の鎖にした。計算の誤りは無かった。",
        "数値検証: sagemath/check/max_eigenvector_in_even_sector/（厳密計算。本文の ψ̌ と実際の V^{(+)} で M_col = 2, 3、結合定数 3 組）。旧い浮動小数点の検算 sagemath/check/053_claim_even_sector_closing/check_02 も残っている。",
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
        " (1) の符号（",
        math(String.raw`+1, -1`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`1_{\mathbb{C}}`),
        " と ",
        math(String.raw`-1_{\mathbb{C}}`),
        "。",
        ref("max_eigenvector_in_even_sector"),
        " の証明の準備と同じ読み方）とし、",
        math(String.raw`r := \left(2\exp(-K_2)\cosh K_1\right)^{M_{\mathrm{col}}} + \left(2\exp(K_2)\sinh K_1\right)^{M_{\mathrm{col}}} \in \mathbb{R}`),
        " とおく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
& \mathrm{tr}\!\left(\varepsilon V^{(+)}\right) = r_{\mathbb{C}}\ \text{かつ}\ r \in \mathbb{R}_{>0}
&&(\because\ \text{(1)（}\blkref{trace_of_epsilon_V_plus}\text{）とその等号と } \in \mathbb{R}_{>0} \text{ の読み方}) \\
\Longrightarrow\ & \mathrm{tr}\!\left(\varepsilon V^{(+)}\right) > 0
&&(\because\ \blkref{trace_of_epsilon_V_plus_via_check_eigenvalues}\text{ の } \mathbb{C} \text{ の元の } z > 0 \text{ の定め方}\ (z \to \mathrm{tr}(\varepsilon V^{(+)})\text{、存在する実数として } r \text{ を取る})) \\
\Longrightarrow\ & \eta_{(1,\dots,1)} = +1
&&(\because\ \blkref{trace_of_epsilon_V_plus_via_check_eigenvalues}\ \text{(3) の同値の}\ \Longleftarrow)
\end{aligned}`,
      ),
      paragraph([
        "次に ",
        math(String.raw`\varepsilon\check{Q}_{(1,\dots,1)} = \check{Q}_{(1,\dots,1)}`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\check{Q}_{(1,\dots,1)}
&= \eta_{(1,\dots,1)}\check{Q}_{(1,\dots,1)}
&&(\because\ \blkref{epsilon_eigenvalue_on_check_Q}\ \text{(1)}\ (\epsilon \to (1,\dots,1))) \\
&= 1_{\mathbb{C}}\check{Q}_{(1,\dots,1)}
&&(\because\ \text{上の含意の鎖の } \eta_{(1,\dots,1)} = +1) \\
&= \check{Q}_{(1,\dots,1)}
&&(\because\ \blkref{scalar_multiple_by_one})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`y \in \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " を取ると、",
        math(String.raw`y = \check{Q}_{(1,\dots,1)}x`),
        " なる ",
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " が取れる（数ベクトルは ",
        ref("mat_mult"),
        " の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 行 1 列の行列）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_{(1,\dots,1)}y
&= \check{Q}_{(1,\dots,1)}\left(\check{Q}_{(1,\dots,1)}x\right)
&&(\because\ y = \check{Q}_{(1,\dots,1)}x \text{ の取り方}) \\
&= \left(\check{Q}_{(1,\dots,1)}\check{Q}_{(1,\dots,1)}\right)x
&&(\because\ \blkref{mat_mult_associative}) \\
&= \check{Q}_{(1,\dots,1)}x
&&(\because\ \blkref{check_joint_eigenspace_decomposition}\ \text{(1) の}\ \check{Q}_\epsilon^2 = \check{Q}_\epsilon\ (\epsilon \to (1,\dots,1))) \\
&= y
&&(\because\ y = \check{Q}_{(1,\dots,1)}x \text{ の取り方})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon y
&= \varepsilon\left(\check{Q}_{(1,\dots,1)}y\right)
&&(\because\ \text{直前の鎖の } \check{Q}_{(1,\dots,1)}y = y) \\
&= \left(\varepsilon\check{Q}_{(1,\dots,1)}\right)y
&&(\because\ \blkref{mat_mult_associative}) \\
&= \check{Q}_{(1,\dots,1)}y
&&(\because\ \text{上の鎖の } \varepsilon\check{Q}_{(1,\dots,1)} = \check{Q}_{(1,\dots,1)}) \\
&= y
&&(\because\ \text{直前の鎖の } \check{Q}_{(1,\dots,1)}y = y)
\end{aligned}`,
      ),
      paragraph([
        "なので、",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`y \in \mathcal{F}^{(+)}`),
        "。",
        math(String.raw`y`),
        " は ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " の任意の元なので ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)} \subseteq \mathcal{F}^{(+)}`),
        " である。これは ",
        ref("max_eigenvector_in_even_sector"),
        " (4) と同じ結論である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、V^{(+)} の最大固有値に属する固有ベクトルの章のゴールの式（tr(εV^{(+)}) = … > 0 ⟹ im Q̌_{(1,…,1)} ⊆ F^{(+)}）を一つの主張として立てた。既存の主張 trace_of_epsilon_V_plus・trace_of_epsilon_V_plus_via_check_eigenvalues・epsilon_eigenvalue_on_check_Q と、max_eigenvector_in_even_sector (4) の証明の計算を並べるだけで、新しい証明は無い。",
        "2026-11-05: (2) を一ステップ一定理に揃えた。含意の鎖の 1 行目を、(1) の右辺 r の置き方と trace_of_epsilon_V_plus_via_check_eigenvalues の z > 0 の定め方を分けた 2 行にし（max_eigenvector_in_even_sector (1) と同じ）、εQ̌_{(1,…,1)} = Q̌_{(1,…,1)} を epsilon_eigenvalue_on_check_Q (1)・η の代入・scalar_multiple_by_one の 3 行の鎖に、「冪等性より y = Q̌y」を y = Q̌x からの 4 行の鎖に、εy = y を mat_mult_associative の行を入れた 4 行の鎖にした（max_eigenvector_in_even_sector (4) と同じ行）。η の ±1 を ℂ の元 ±1_ℂ と読むことを冒頭に書いた。主張は変えていない。",
      ],
    },
  },
]);
