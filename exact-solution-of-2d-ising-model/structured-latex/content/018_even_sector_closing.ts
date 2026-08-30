import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/018_even_sector_closing.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_closing",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`c_+(M) \text{ の決定と Onsager の自由エネルギー}` },
    labels: [],
  },

  {
    id: "closing_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的と、残っている 1 点" },
    labels: [],
    statement: [
      paragraph([
        ref("max_eigenvalue_of_V_plus_simple"),
        " により ",
        math(String.raw`V^{(+)}`),
        " の最大固有値 ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_M`),
        " は**単純**である。一方 ",
        ref("sector_decomposition_of_rayleigh_sup"),
        " の ",
        math(String.raw`c_+(M)`),
        " は ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
        " の単位ベクトルにわたる上限であり、同 (2) の ",
        math(String.raw`WP^{(+)} = V^{(+)}P^{(+)}`),
        " により ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上では ",
        math(String.raw`W`),
        " と ",
        math(String.raw`V^{(+)}`),
        " が一致する。したがって",
      ]),
      displayMath(
        String.raw`c_+(M) \leq \check\Lambda_{\max}`,
      ),
      paragraph([
        "は容易である。**難所は逆向きの不等号**、すなわち ",
        math(String.raw`\check\Lambda_{\max}`),
        " の固有ベクトルが ",
        math(String.raw`\mathcal{F}^{(-)}`),
        " 側に落ちていないこと（",
        math(String.raw`\varepsilon`),
        " の固有値が ",
        math(String.raw`+1`),
        " であること）である。",
        math(String.raw`V^{(+)}`),
        " は ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " 全体の上の行列であり、その ",
        math(String.raw`2^M`),
        " 個の固有値のうち半分は ",
        math(String.raw`\mathcal{F}^{(-)}`),
        " に属する固有ベクトルに対応する。最大固有値がどちらの側に落ちるかは、",
        "固有値の値 ",
        math(String.raw`\check\Lambda_\epsilon`),
        " からは読み取れない。",
      ]),
      paragraph([
        "この章の筋は次のとおりである（",
        math(String.raw`\varepsilon`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_1^x\cdots\sigma_M^x`),
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
= \eta_{(1,\dots,1)}\,(2\sinh 2K_2)^{M/2}\prod_{\mu=1}^{M}
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
= \left(2e^{-K_2}\cosh K_1\right)^{M} + \left(2e^{K_2}\sinh K_1\right)^{M} > 0`),
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
      paragraph([
        "そのうえで ",
        math(String.raw`c_+(M) = \Lambda^{(1/2)}_M`),
        "（",
        ref("c_plus_equals_Lambda_half_integer"),
        "）を示し、",
        ref("onsager_free_energy_expression"),
        " と合わせて ",
        ref("remark_remaining_input_even_sector"),
        " の「残っている入力」を解消する（",
        ref("onsager_exact_solution"),
        "）。",
      ]),
      paragraph([
        "この章で用いる道具は、複素数を成分とする行列の積・和・スカラー倍、行列の指数関数（",
        ref("def_exp"),
        "）、トレース（",
        ref("def_trace"),
        "）、有限個の実数の和と積、および ",
        math(String.raw`\cosh, \sinh, \log`),
        " だけである。積分が現れるのは ",
        ref("riemann_sum_to_integral"),
        " を引く最後の主張だけで、そこが ",
        ref("remark_real_analysis_escape_point"),
        " を使って有限和の極限を積分として計算する。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "closing_001_claim_epsilon_anticommutes",
    kind: "claim",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\varepsilon \text{ は } \check{Z}, \check{Y}, \check\psi \text{ と反可換}` },
    labels: ["epsilon_anticommutes_with_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x`),
        " について次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \varepsilon\,Z_j = -Z_j\,\varepsilon,
\qquad \varepsilon\,Y_j = -Y_j\,\varepsilon
\qquad (j \in \{1,\dots,M\})`),
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
        ref("epsilon_commutes_with_transfer_matrices"),
        " の Step 1 で",
      ]),
      displayMath(
        String.raw`\varepsilon\,\sigma_k^x = \sigma_k^x\,\varepsilon, \qquad
\varepsilon\,\sigma_k^z = -\,\sigma_k^z\,\varepsilon, \qquad
\varepsilon\,\sigma_k^y = -\,\sigma_k^y\,\varepsilon
\qquad (k \in \{1,\dots,M\})`,
      ),
      paragraph([
        "が示されている。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_j = \sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z`),
        " に、これを左から順に通す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,Z_j
&= \varepsilon\,\sigma_1^x\cdots\sigma_{j-1}^x\,\sigma_j^z
   \quad (\because \text{def\_transfer\_matrix\_symbols}) \\
&= \sigma_1^x\cdots\sigma_{j-1}^x\,\varepsilon\,\sigma_j^z
   \quad (\because \text{epsilon\_commutes\_with\_transfer\_matrices の Step 1 の }
   \varepsilon\sigma_k^x = \sigma_k^x\varepsilon \text{ を } j-1 \text{ 箇所へ同時適用}) \\
&= \sigma_1^x\cdots\sigma_{j-1}^x\left(-\sigma_j^z\,\varepsilon\right)
   \quad (\because \text{同 Step 1 の } \varepsilon\sigma_k^z = -\sigma_k^z\varepsilon) \\
&= -\left(\sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z\right)\varepsilon
   \quad (\because \text{結合法則とスカラー倍}) \\
&= -Z_j\,\varepsilon
   \quad (\because \text{def\_transfer\_matrix\_symbols})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_j = \sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^y`),
        " についても、最後から 2 番目の段で ",
        math(String.raw`\varepsilon\sigma_j^y = -\sigma_j^y\varepsilon`),
        " を使うだけで同じ計算が通る。",
      ]),
      paragraph([
        "(2) ",
        ref("def_half_integer_modes"),
        " の ",
        math(String.raw`\check{Z}_\mu = \sum_{j=1}^{M}Z_je^{-ij\tilde\theta_\mu}`),
        " は ",
        math(String.raw`Z_j`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 係数の有限和である。行列の積は各因子について ",
        math(String.raw`\mathbb{C}`),
        " 線型なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\check{Z}_\mu
&= \varepsilon\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}Z_j
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}\left(\varepsilon\,Z_j\right)
   \quad (\because \text{積の } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}\left(-Z_j\,\varepsilon\right)
   \quad (\because \text{(1) を } M \text{ 個の項へ同時適用}) \\
&= -\left(\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}Z_j\right)\varepsilon
   \quad (\because \text{積の } \mathbb{C} \text{ 線型性}) \\
&= -\check{Z}_\mu\,\varepsilon
   \quad (\because \text{def\_half\_integer\_modes})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\check{Y}_\mu`),
        " も同じ計算（(1) の ",
        math(String.raw`Y_j`),
        " の側を使う）である。",
      ]),
      paragraph([
        "(3) ",
        ref("def_check_fermi"),
        " より ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " と ",
        math(String.raw`\check\psi_\mu`),
        " はいずれも ",
        math(String.raw`\check{Z}_\mu`),
        " と ",
        math(String.raw`\check{Y}_\mu`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 係数の 1 次結合である。(2) を両方の項へ同時に適用すればよい：",
        math(String.raw`\check\psi_\mu^\dagger = p\check{Z}_\mu + q\check{Y}_\mu`),
        "（",
        math(String.raw`p, q \in \mathbb{C}`),
        "）と書くと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\check\psi_\mu^\dagger
&= p\left(\varepsilon\check{Z}_\mu\right) + q\left(\varepsilon\check{Y}_\mu\right)
   \quad (\because \text{def\_check\_fermi と積の }\mathbb C\text{ 線型性}) \\
&= -p\check{Z}_\mu\varepsilon - q\check{Y}_\mu\varepsilon
   \quad (\because \text{(2) を 2 箇所へ同時適用}) \\
&= -\check\psi_\mu^\dagger\,\varepsilon
   \quad (\because \text{def\_check\_fermi と積の }\mathbb C\text{ 線型性})
\end{aligned}`,
      ),
      paragraph([
        "(4) ",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M+1-\mu \in \check{\mathcal{M}}`),
        " なので (3) を ",
        math(String.raw`\check\psi_{M+1-\mu}`),
        " にも適用できる。",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu = \check\psi_\mu^\dagger\check\psi_{M+1-\mu}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\check{n}_\mu
&= \varepsilon\,\check\psi_\mu^\dagger\,\check\psi_{M+1-\mu}
   \quad (\because \text{def\_check\_number\_operator}) \\
&= \left(-\check\psi_\mu^\dagger\,\varepsilon\right)\check\psi_{M+1-\mu}
   \quad (\because \text{(3)}) \\
&= -\check\psi_\mu^\dagger\left(\varepsilon\,\check\psi_{M+1-\mu}\right)
   \quad (\because \text{結合法則}) \\
&= -\check\psi_\mu^\dagger\left(-\check\psi_{M+1-\mu}\,\varepsilon\right)
   \quad (\because \text{(3) を添字 } M+1-\mu \text{ へ適用}) \\
&= \check\psi_\mu^\dagger\check\psi_{M+1-\mu}\,\varepsilon
   \quad (\because (-1)^2 = 1) \\
&= \check{n}_\mu\,\varepsilon
   \quad (\because \text{def\_check\_number\_operator})
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M}
\left(\epsilon_\mu\check{n}_\mu + (1-\epsilon_\mu)\left(I - \check{n}_\mu\right)\right)`),
        " は ",
        math(String.raw`\check{n}_\mu`),
        " たちと ",
        math(String.raw`I`),
        " から積と ",
        math(String.raw`\mathbb{C}`),
        " 係数の和だけで作られている。",
        math(String.raw`\varepsilon`),
        " は各 ",
        math(String.raw`\check{n}_\mu`),
        " と可換、",
        math(String.raw`I`),
        " とも可換（",
        ref("scalar_identity_commutes"),
        "）なので、積・和をとっても可換性は保たれ ",
        math(String.raw`\varepsilon\check{Q}_\epsilon = \check{Q}_\epsilon\varepsilon`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "ε が Z_j, Y_j と反可換であることは 010 章の epsilon_commutes_with_transfer_matrices の Step 1（σ_k^x とは可換、σ_k^y, σ_k^z とは反可換）から直ちに従う。ε が V_1, V_2 と可換であることと、Z_j, Y_j と反可換であることは矛盾しない（V_1, V_2 の指数の中身は Z, Y の 2 次式である）。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_01（M=2,3,4,5・6 組の (K_1,K_2) で残差 ≤ 2e-14）。",
      ],
    },
  },

  {
    id: "closing_002_claim_epsilon_eigenvalue_on_check_Q",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
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
= \eta_{(1,\dots,1)}\,(-1)^{M-|\epsilon|}`),
        ],
        [
          math(String.raw`\text{(4)}\quad \varepsilon
= \eta_{(1,\dots,1)}\,(-1)^{M}\prod_{\mu=1}^{M}\left(I - 2\check{n}_\mu\right)`),
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
        math(String.raw`x`),
        " が取れる。まず ",
        math(String.raw`\check{Q}_\epsilon q = q`),
        " を確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon q
&= \check{Q}_\epsilon\left(\check{Q}_\epsilon x\right)
   \quad (\because q = \check{Q}_\epsilon x \text{ の置き方}) \\
&= \check{Q}_\epsilon^{2}\,x
   \quad (\because \text{行列積の結合則}) \\
&= \check{Q}_\epsilon x
   \quad (\because \text{check\_joint\_eigenspace\_decomposition (1) の冪等性 }
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
&= \varepsilon\left(\check{Q}_\epsilon q\right)
   \quad (\because \text{epsilon\_anticommutes\_with\_check\_Z\_Y (4) と行列積の結合則}) \\
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
   \quad (\because \text{恒等行列の定義}) \\
&= \varepsilon^2q
   \quad (\because \text{epsilon\_projector\_properties (1) の }\varepsilon^2=I) \\
&= \varepsilon\left(\varepsilon q\right)
   \quad (\because \text{行列積の結合則}) \\
&= \varepsilon\left(\eta q\right)
   \quad (\because \varepsilon q=\eta q\text{ の置き方}) \\
&= \eta\left(\varepsilon q\right)
   \quad (\because \eta\in\mathbb C\text{ と行列のスカラー倍の定義}) \\
&= \eta\left(\eta q\right)
   \quad (\because \varepsilon q=\eta q\text{ の置き方}) \\
&= \eta^2q
   \quad (\because \mathbb C\text{ の積と行列のスカラー倍の結合則})
\end{aligned}`,
      ),
      paragraph([
        ref("epsilon_projector_properties"),
        " (1) と上の式変形、および ",
        math(String.raw`q\neq0`),
        " より ",
        math(String.raw`\eta^2=1`),
        "。したがって ",
        math(String.raw`\eta \in \{+1,-1\}`),
        "（",
        math(String.raw`\mathbb{C}`),
        " は体なので ",
        math(String.raw`(\eta-1)(\eta+1) = 0`),
        " から）。",
      ]),
      paragraph([
        "任意の ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\check{Q}_\epsilon x \in \mathbb{C}q`),
        " だから ",
        math(String.raw`\varepsilon\check{Q}_\epsilon x = \eta\check{Q}_\epsilon x`),
        " であり、行列としても ",
        math(String.raw`\varepsilon\check{Q}_\epsilon = \eta\check{Q}_\epsilon`),
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
&= \varepsilon\check{Q}_\epsilon q
   \quad (\because \check{Q}_\epsilon q=q) \\
&= \eta_\epsilon\check{Q}_\epsilon q
   \quad (\because \text{(1)}) \\
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
        " なので ",
        ref("check_joint_eigenspace_decomposition"),
        " (3) より ",
        math(String.raw`\check{n}_\mu q = \check{n}_\mu\check{Q}_\epsilon q
= \epsilon_\mu\check{Q}_\epsilon q = 0`),
        " である。",
        ref("check_number_operator_idempotent"),
        " (2) の ",
        math(String.raw`\check\psi_{M+1-\mu}\check\psi_\mu^\dagger = I - \check{n}_\mu`),
        " を ",
        math(String.raw`q`),
        " に施すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_{M+1-\mu}\left(\check\psi_\mu^\dagger q\right)
&= \left(I - \check{n}_\mu\right)q
   \quad (\because \text{check\_number\_operator\_idempotent (2)}) \\
&= q-0
   \quad (\because \check n_\mu q=0) \\
&= q
   \quad (\because \text{零ベクトルの減法})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\check\psi_\mu^\dagger q = 0`),
        " なら左辺が ",
        math(String.raw`0`),
        " になり ",
        math(String.raw`q = 0`),
        " となって矛盾する。よって ",
        math(String.raw`\check\psi_\mu^\dagger q \neq 0`),
        "。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\check\psi_\mu^\dagger q \in \mathrm{im}\,\check{Q}_{\epsilon[\mu\to1]}`),
        "）。まず ",
        math(String.raw`\check{n}_\mu\check\psi_\mu^\dagger = \check\psi_\mu^\dagger`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu\,\check\psi_\mu^\dagger
&= \check\psi_\mu^\dagger\left(\check\psi_{M+1-\mu}\check\psi_\mu^\dagger\right)
   \quad (\because \text{def\_check\_number\_operator と結合法則}) \\
&= \check\psi_\mu^\dagger\left(I - \check{n}_\mu\right)
   \quad (\because \text{check\_number\_operator\_idempotent (2)}) \\
&= \check\psi_\mu^\dagger
   - \check\psi_\mu^\dagger\check\psi_\mu^\dagger\check\psi_{M+1-\mu}
   \quad (\because \text{分配法則と def\_check\_number\_operator}) \\
&= \check\psi_\mu^\dagger - 0
   \quad (\because \text{check\_number\_operator\_idempotent (1) の }
   \left(\check\psi_\mu^\dagger\right)^2 = 0)
\end{aligned}`,
      ),
      paragraph([
        "次に ",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        "、",
        math(String.raw`\nu \neq \mu`),
        " については ",
        ref("check_number_operators_commute"),
        " (1) より ",
        math(String.raw`\check\psi_\mu^\dagger\check{n}_\nu = \check{n}_\nu\check\psi_\mu^\dagger`),
        " である。",
        ref("check_joint_eigenspace_decomposition"),
        " の証明中の記号 ",
        math(String.raw`R_\nu^{(1)} = \check{n}_\nu`),
        "、",
        math(String.raw`R_\nu^{(0)} = I - \check{n}_\nu`),
        " を使うと、",
        math(String.raw`\epsilon' := \epsilon[\mu\to1]`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_{\epsilon'}\left(\check\psi_\mu^\dagger q\right)
&= \left(\prod_{\nu \neq \mu}R_\nu^{(\epsilon_\nu)}\right)
   \check{n}_\mu\,\check\psi_\mu^\dagger\,q
   \quad (\because \text{因子は可換, check\_number\_operators\_commute (2)}) \\
&= \left(\prod_{\nu \neq \mu}R_\nu^{(\epsilon_\nu)}\right)\check\psi_\mu^\dagger\,q
   \quad (\because \text{Step 2 冒頭の } \check{n}_\mu\check\psi_\mu^\dagger
   = \check\psi_\mu^\dagger) \\
&= \check\psi_\mu^\dagger\left(\prod_{\nu \neq \mu}R_\nu^{(\epsilon_\nu)}\right)q
   \quad (\because \text{check\_number\_operators\_commute (1) を } M-1 \text{ 箇所へ同時適用}) \\
&= \check\psi_\mu^\dagger\,q
   \quad \left(\because R_\mu^{(0)}q = \left(I - \check{n}_\mu\right)q = q
   \text{ より } \left(\prod_{\nu \neq \mu}R_\nu^{(\epsilon_\nu)}\right)q
   = \check{Q}_\epsilon q = q\right)
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\check\psi_\mu^\dagger q \in \mathrm{im}\,\check{Q}_{\epsilon'}`),
        " であり、Step 1 よりこれは ",
        math(String.raw`0`),
        " でないから、1 次元の ",
        math(String.raw`\mathrm{im}\,\check{Q}_{\epsilon'}`),
        " の生成元である。",
      ]),
      paragraph([
        "Step 3（符号）。",
        ref("epsilon_anticommutes_with_check_Z_Y"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\left(\check\psi_\mu^\dagger q\right)
&= -\check\psi_\mu^\dagger\left(\varepsilon q\right)
   \quad (\because \text{epsilon\_anticommutes\_with\_check\_Z\_Y (3)}) \\
&= -\check\psi_\mu^\dagger\left(\eta_\epsilon q\right)
   \quad (\because \text{(1)}) \\
&= \left(-\eta_\epsilon\right)\check\psi_\mu^\dagger q
\end{aligned}`,
      ),
      paragraph([
        "Step 2 より ",
        math(String.raw`\check\psi_\mu^\dagger q`),
        " は ",
        math(String.raw`\mathrm{im}\,\check{Q}_{\epsilon'}`),
        " の生成元なので、(1) の一意性から ",
        math(String.raw`\eta_{\epsilon'} = -\eta_\epsilon`),
        "。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`\epsilon`),
        " から出発して、",
        math(String.raw`\epsilon_\mu = 0`),
        " である ",
        math(String.raw`M - |\epsilon|`),
        " 個の添字 ",
        math(String.raw`\mu`),
        " を 1 つずつ ",
        math(String.raw`1`),
        " に取り替えていくと ",
        math(String.raw`(1,\dots,1)`),
        " に至る。(2) を各段で使うと符号が 1 回ずつ反転するので",
      ]),
      displayMath(
        String.raw`\eta_{(1,\dots,1)} = (-1)^{M-|\epsilon|}\,\eta_\epsilon`,
      ),
      paragraph([
        "両辺に ",
        math(String.raw`(-1)^{M-|\epsilon|}`),
        " を掛け、",
        math(String.raw`\left((-1)^{M-|\epsilon|}\right)^2 = 1`),
        " を使えば (3) を得る。",
      ]),
      paragraph([
        "(4) ",
        ref("check_joint_eigenspace_decomposition"),
        " (3) より ",
        math(String.raw`\check{n}_\mu\check{Q}_\epsilon = \epsilon_\mu\check{Q}_\epsilon`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\prod_{\mu=1}^{M}\left(I - 2\check{n}_\mu\right)\right)\check{Q}_\epsilon
&= \left(\prod_{\mu=1}^{M}\left(1 - 2\epsilon_\mu\right)\right)\check{Q}_\epsilon
   \quad (\because \text{check\_joint\_eigenspace\_decomposition (3)}) \\
&= (-1)^{|\epsilon|}\,\check{Q}_\epsilon
   \quad \left(\because 1 - 2\epsilon_\mu = \begin{cases}-1 & (\epsilon_\mu = 1) \\
+1 & (\epsilon_\mu = 0)\end{cases}\right)
\end{aligned}`,
      ),
      paragraph([
        "一方 (1)(3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\check{Q}_\epsilon
&= \eta_{(1,\dots,1)}(-1)^{M-|\epsilon|}\check{Q}_\epsilon
   \quad (\because \text{(1) と (3)}) \\
&= \eta_{(1,\dots,1)}(-1)^{M}(-1)^{|\epsilon|}\check{Q}_\epsilon
   \quad (\because (-1)^{-|\epsilon|}=(-1)^{|\epsilon|})
\end{aligned}`,
      ),
      paragraph([
        "したがって 2 つの行列 ",
        math(String.raw`\varepsilon`),
        " と ",
        math(String.raw`\eta_{(1,\dots,1)}(-1)^M\prod_\mu(I-2\check{n}_\mu)`),
        " は、すべての ",
        math(String.raw`\check{Q}_\epsilon`),
        " に右から掛けた結果が一致する。",
        ref("check_joint_eigenspace_decomposition"),
        " (2) の ",
        math(String.raw`\sum_\epsilon\check{Q}_\epsilon = I`),
        " を掛ければ (4) を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "(4) は「ε は数演算子の言葉でパリティ Π(I − 2ň_μ) に一致する」ことを述べているが、全体の符号 η_{(1,…,1)} はこの段階では未定である。この 1 つの符号を決めるのがこの章の実質的な内容で、max_eigenvector_in_even_sector で η_{(1,…,1)} = +1 と確定し、ε = (−1)^M Π(I − 2ň_μ) となる。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_02（{0,1}^M を全列挙して εQ̌_ε = η_ε Q̌_ε、η_ε ∈ {±1}、反転則、η_ε = (−1)^{M+|ε|}）。",
      ],
    },
  },

  {
    id: "closing_003_claim_trace_epsilon_V_plus_via_eigenvalues",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
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
        ref("def_gamma_theta_tilde_mu"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\varepsilon\,V^{(+)}\right)
= \eta_{(1,\dots,1)}\,(2\sinh 2K_2)^{M/2}
\prod_{\mu=1}^{M}2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)`,
      ),
      paragraph([
        "が成り立つ。",
        ref("def_gamma_theta_tilde_mu"),
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
        math(String.raw`\eta_\epsilon = \eta_{(1,\dots,1)}(-1)^{M-|\epsilon|}`),
        " であり、",
        ref("eigenvalues_of_V_plus"),
        " の ",
        math(String.raw`\check\Lambda_\epsilon = (2\sinh 2K_2)^{M/2}
\exp\!\left(\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)\left(\epsilon_\mu-\tfrac12\right)\right)`),
        " である。",
        math(String.raw`(-1)^{M-|\epsilon|} = \prod_{\mu=1}^{M}(-1)^{1-\epsilon_\mu}`),
        "（",
        math(String.raw`\sum_\mu(1-\epsilon_\mu) = M - |\epsilon|`),
        "）と ",
        ref("theorem_exp_product"),
        "（",
        math(String.raw`n=1`),
        "、すなわち実数の指数法則）を使うと",
      ]),
      displayMath(
        String.raw`\eta_\epsilon\,\check\Lambda_\epsilon
= \eta_{(1,\dots,1)}\,(2\sinh 2K_2)^{M/2}
\prod_{\mu=1}^{M}\left((-1)^{1-\epsilon_\mu}
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
&= \eta_{(1,\dots,1)}(2\sinh 2K_2)^{M/2}\prod_{\mu=1}^{M}
   \left(-\exp\!\left(-\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)
   + \exp\!\left(+\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)\right)
   \quad (\because \text{有限個の因子の積の展開}) \\
&= \eta_{(1,\dots,1)}(2\sinh 2K_2)^{M/2}\prod_{\mu=1}^{M}
   2\sinh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
   \quad \left(\because \sinh x = \frac{e^{x}-e^{-x}}{2}\right)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\epsilon_\mu = 0`),
        " の項が ",
        math(String.raw`(-1)^{1}e^{-\gamma/2}`),
        "、",
        math(String.raw`\epsilon_\mu = 1`),
        " の項が ",
        math(String.raw`(-1)^{0}e^{+\gamma/2}`),
        " である。）Step 1 と合わせて主張の等式を得る。",
      ]),
      paragraph([
        "Step 3（符号）。",
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`2\sinh 2K_2 > 0`),
        " なので ",
        math(String.raw`(2\sinh 2K_2)^{M/2} > 0`),
        "。",
        ref("def_gamma_theta_tilde_mu"),
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
    id: "closing_004_claim_H1_plus_in_sigma_z_form",
    kind: "claim",
    origin: { path: SRC, ordinal: 6 },
    title: {
      tex: String.raw`i H_1^{(+)} = \sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z
+ \varepsilon\,\sigma_M^z\sigma_1^z`,
    },
    labels: ["H1_plus_in_sigma_z_form"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_V_plus_and_T_V_plus"),
        " の ",
        math(String.raw`H_1^{(+)} = Y_1Z_2 + Y_2Z_3 + \cdots + Y_{M-1}Z_M - Y_MZ_1`),
        " を考える。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad i\,Y_mZ_{m+1} = \sigma_m^z\sigma_{m+1}^z
\qquad (m \in \{1,\dots,M-1\})`),
        ],
        [
          math(String.raw`\text{(2)}\quad -i\,Y_MZ_1 = \varepsilon\,\sigma_M^z\sigma_1^z`),
        ],
        [
          math(String.raw`\text{(3)}\quad i\,H_1^{(+)}
= D_0 + \varepsilon\,G, \qquad
D_0 := \sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z, \quad
G := \sigma_M^z\sigma_1^z`),
        ],
        [
          math(String.raw`\text{(4)}\quad \varepsilon D_0 = D_0\varepsilon, \qquad
\varepsilon G = G\varepsilon, \qquad D_0G = GD_0, \qquad
\left(\varepsilon G\right)^2 = I`),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`D_0`),
        " と ",
        math(String.raw`G`),
        " は ",
        ref("def_config_basis_iso"),
        " の基底 ",
        math(String.raw`f_{\iota(s)}`),
        "（",
        math(String.raw`s \in \mathfrak{M}`),
        "）について対角であり、",
        ref("sigma_z_diagonal_action"),
        " より",
      ]),
      displayMath(
        String.raw`D_0 f_{\iota(s)} = \left(\sum_{m=1}^{M-1}s(m)s(m+1)\right)f_{\iota(s)},
\qquad
G f_{\iota(s)} = s(M)s(1)\,f_{\iota(s)}`,
      ),
      paragraph([
        "である。",
        "（**スピン配置を ",
        math(String.raw`s`),
        " と書くのは、",
        math(String.raw`\mu`),
        " を 013 章以降モードの添字に使っているためである。**",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,M\},\{-1,1\})`),
        " の元を指す。）",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("pauli_matrix_products"),
        " と ",
        ref("V1_V2_in_Z_Y_epsilon"),
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
        "(1) ",
        math(String.raw`1 \leq m \leq M-1`),
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
        "(2) ",
        math(String.raw`Y_M = \sigma_1^x\cdots\sigma_{M-1}^x\sigma_M^y`),
        "、",
        math(String.raw`Z_1 = \sigma_1^z`),
        " である。まず左辺を計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_MZ_1
&= \left(\sigma_1^x\cdots\sigma_{M-1}^x\sigma_M^y\right)\sigma_1^z
   \quad (\because \text{def\_transfer\_matrix\_symbols}) \\
&= \left(\sigma_1^x\sigma_1^z\right)\sigma_2^x\cdots\sigma_{M-1}^x\,\sigma_M^y
   \quad (\because \text{相異なるサイトの因子は可換}) \\
&= \left(-i\,\sigma_1^y\right)\sigma_2^x\cdots\sigma_{M-1}^x\,\sigma_M^y
   \quad (\because \sigma^x\sigma^z = -i\sigma^y) \\
&= -i\,\sigma_1^y\sigma_2^x\cdots\sigma_{M-1}^x\sigma_M^y
\end{aligned}`,
      ),
      paragraph(["次に右辺を計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\sigma_M^z\sigma_1^z
&= \left(\sigma_1^x\sigma_2^x\cdots\sigma_M^x\right)\sigma_M^z\sigma_1^z
   \quad (\because \text{def\_transfer\_matrix\_symbols の } \varepsilon) \\
&= \left(\sigma_1^x\sigma_1^z\right)\sigma_2^x\cdots\sigma_{M-1}^x
   \left(\sigma_M^x\sigma_M^z\right)
   \quad (\because \text{相異なるサイトの因子は可換}) \\
&= \left(-i\,\sigma_1^y\right)\sigma_2^x\cdots\sigma_{M-1}^x
   \left(-i\,\sigma_M^y\right)
   \quad (\because \sigma^x\sigma^z = -i\sigma^y \text{ を 2 箇所へ同時適用}) \\
&= -\,\sigma_1^y\sigma_2^x\cdots\sigma_{M-1}^x\sigma_M^y
   \quad (\because (-i)^2 = -1)
\end{aligned}`,
      ),
      paragraph([
        "上の 2 つの計算結果を突き合わせる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
-i\,Y_MZ_1
&= -i\left(-i\,\sigma_1^y\sigma_2^x\cdots\sigma_{M-1}^x\sigma_M^y\right)
   \quad (\because \text{直前の } Y_MZ_1 \text{ の計算}) \\
&= -\,\sigma_1^y\sigma_2^x\cdots\sigma_{M-1}^x\sigma_M^y
   \quad \left(\because (-i)^2 = -1\right) \\
&= \varepsilon\,\sigma_M^z\sigma_1^z
   \quad (\because \text{直前の } \varepsilon\sigma_M^z\sigma_1^z \text{ の計算})
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        ref("def_V_plus_and_T_V_plus"),
        " の ",
        math(String.raw`H_1^{(+)}`),
        " に (1)(2) を適用する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
i\,H_1^{(+)}
&= i\left(\sum_{m=1}^{M-1}Y_mZ_{m+1} - Y_MZ_1\right)
   \quad (\because \text{def\_H1\_pm の上の符号}) \\
&= \sum_{m=1}^{M-1}\left(i\,Y_mZ_{m+1}\right) + \left(-i\,Y_MZ_1\right)
   \quad (\because \text{スカラー倍の分配法則}) \\
&= \sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z + \varepsilon\,\sigma_M^z\sigma_1^z
   \quad (\because \text{(1) を } M-1 \text{ 箇所へ同時適用し、(2)}) \\
&= D_0 + \varepsilon G
\end{aligned}`,
      ),
      paragraph([
        "(4) ",
        ref("epsilon_commutes_with_transfer_matrices"),
        " の Step 1 より ",
        math(String.raw`\varepsilon\sigma_k^z = -\sigma_k^z\varepsilon`),
        " なので、",
        math(String.raw`\sigma^z`),
        " を 2 個含む積 ",
        math(String.raw`\sigma_m^z\sigma_{m+1}^z`),
        " や ",
        math(String.raw`\sigma_M^z\sigma_1^z`),
        " については符号が 2 回反転して ",
        math(String.raw`(-1)^2 = 1`),
        " となり、",
        math(String.raw`\varepsilon`),
        " と可換である。したがって ",
        math(String.raw`\varepsilon D_0 = D_0\varepsilon`),
        "、",
        math(String.raw`\varepsilon G = G\varepsilon`),
        "。",
        math(String.raw`D_0`),
        " と ",
        math(String.raw`G`),
        " はどちらも ",
        math(String.raw`\sigma_k^z`),
        " たちの積の和であり、相異なるサイトの因子は可換、同一サイトでは ",
        math(String.raw`\sigma^z\sigma^z`),
        " どうしなので、",
        math(String.raw`D_0G = GD_0`),
        " である。最後に",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\varepsilon G\right)^2
&= \varepsilon G\varepsilon G
&&\bigl(\because\ \text{二乗の定義}\bigr)\\
&= \varepsilon^2G^2
&&\bigl(\because\ \varepsilon G = G\varepsilon\text{（上の (4)}\text{）}\bigr)\\
&= I\,G^2
&&\bigl(\because\ \text{epsilon\_projector\_properties (1) の }\varepsilon^2 = I\bigr)\\
&= I\left(\sigma_M^z\right)^2\left(\sigma_1^z\right)^2
&&\bigl(\because\ G:=\sigma_M^z\sigma_1^z\text{（上の (3)）と、相異なるサイトの因子の可換性}\bigr)\\
&= I\cdot I\cdot I
&&\bigl(\because\ (\sigma_k^z)^2 = I\text{（直後の段落）}\bigr)\\
&= I
&&\bigl(\because\ \text{単位行列の積}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`(\sigma_k^z)^2 = I`),
        " は ",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z\sigma^z = I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " と ",
        ref("kronecker_product_rule"),
        " (1)(2) による。）",
      ]),
      paragraph([
        "対角性は ",
        ref("sigma_z_diagonal_action"),
        " の ",
        math(String.raw`\sigma_m^z\sigma_{m'}^zf_{\iota(s)} = s(m)s(m')f_{\iota(s)}`),
        " をそのまま有限和に適用すればよい。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "V1_V2_in_Z_Y_epsilon は V_1 = exp(iK_1(Y_1Z_2+⋯+Y_{M-1}Z_M − εY_MZ_1)) を主張しており、この (3) はその指数の中身を σ^z の言葉へ戻したものにあたる。(3) の右辺は F^{(+)} 上（ε = +1）で K_1 D の 1/K_1 倍に一致し、F^{(-)} 上では最後の項の符号が反転する。これが V^{(+)} が「周期境界」、V^{(-)} が「反周期境界」に対応する具体的な形である。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,3,4,5 で残差 0.0）。",
      ],
    },
  },

  {
    id: "closing_005_definition_open_chain_spin_energy",
    kind: "definition",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "1 次元開鎖のスピン配置とエネルギー" },
    labels: ["def_open_chain_spin_energy"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_transfer_matrix"),
        " で行の長さに使った ",
        math(String.raw`N`),
        " をここでは ",
        math(String.raw`M`),
        " と書き替え、",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,M\},\{-1,1\})`),
        " とする。各 ",
        math(String.raw`s\in\mathfrak M`),
        " に対して、1次元開鎖のエネルギーを",
      ]),
      displayMath(
        String.raw`E(s) := \sum_{m=1}^{M-1}s(m)\,s(m+1) \in \mathbb{Z}
\qquad (s \in \mathfrak{M})`,
      ),
      paragraph(["と定める。"])],
    conversion: {
      status: "added",
      notes: ["転送行列の行長 N を M と読み替えることと、開鎖エネルギーの共通記法を独立した定義にした。"],
    },
  },

  {
    id: "closing_005_claim_open_chain_partition_sum",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "端点因子のない1次元開鎖のスピン和" },
    labels: ["open_chain_partition_sum"],
    statement: [
      paragraph([
        ref("def_open_chain_spin_energy"),
        " の記号を用い、",
        math(String.raw`K\in\mathbb R`),
        " とする。このとき",
      ]),
      displayMath(String.raw`\sum_{s\in\mathfrak M}e^{K E(s)}
=2\left(2\cosh K\right)^{M-1}`),
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
        String.raw`\Phi : \mathfrak{M} \longrightarrow \{-1,1\}\times\{-1,1\}^{M-1},
\qquad
\Phi(s) := \left(s(1);\ t_1,\dots,t_{M-1}\right), \quad t_m := s(m)s(m+1)`,
      ),
      paragraph([
        "は全単射である。実際、",
        math(String.raw`(s(1); t_1,\dots,t_{M-1})`),
        " が与えられれば ",
        math(String.raw`s(m+1) = s(m)t_m`),
        " により ",
        math(String.raw`s(2),\dots,s(M)`),
        " が順に一意に定まり（",
        math(String.raw`s(m)s(m) = 1`),
        " なので ",
        math(String.raw`t_m = s(m)s(m+1)`),
        " と同値）、逆にこの手続きで作った ",
        math(String.raw`s`),
        " は ",
        math(String.raw`\Phi(s)`),
        " として元の組を与えるからである。両側の集合はともに ",
        math(String.raw`2^M`),
        " 個の元をもつ。",
      ]),
      paragraph([
        "Step 2（スピン和の計算）。",
        math(String.raw`E(s) = \sum_{m=1}^{M-1}t_m`),
        " なので、",
        ref("theorem_exp_product"),
        "（",
        math(String.raw`n=1`),
        "、実数の指数法則）より ",
        math(String.raw`e^{KE(s)} = \prod_{m=1}^{M-1}e^{Kt_m}`),
        " である。Step 1 の全単射で和を書き換えると",
      ]),
      paragraph([ref("def_cosh_sinh"), " より、最後から二つ目の等号が成り立つ。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak{M}}e^{KE(s)}
&= \sum_{s(1)\in\{-1,1\}}\ \sum_{t_1,\dots,t_{M-1}\in\{-1,1\}}
   \prod_{m=1}^{M-1}e^{Kt_m}
   \quad (\because \text{Step 1 の全単射}) \\
&= \left(\sum_{s(1)\in\{-1,1\}}1\right)
   \prod_{m=1}^{M-1}\left(\sum_{t_m\in\{-1,1\}}e^{Kt_m}\right)
   \quad (\because \text{有限個の因子の積の展開（各 } t_m \text{ は独立に走る）}) \\
&= 2\prod_{m=1}^{M-1}\left(e^{K}+e^{-K}\right)
   \quad (\because \text{二元集合 }\{-1,1\}\text{ 上の二つの有限和を計算}) \\
&= 2\prod_{m=1}^{M-1}\left(2\cosh K\right)
   \quad \left(\because \text{双曲線余弦の定義}\right) \\
&= 2\left(2\cosh K\right)^{M-1}
   \quad (\because \text{同じ因子 }2\cosh K\text{ の }M-1\text{ 個の積})
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
    origin: { path: SRC, ordinal: 7 },
    title: { text: "両端のスピンの積を掛けた1次元開鎖のスピン和" },
    labels: ["open_chain_endpoint_product_sum"],
    statement: [
      paragraph([
        ref("def_open_chain_spin_energy"),
        " の記号を用い、",
        math(String.raw`K\in\mathbb R`),
        " とする。このとき",
      ]),
      displayMath(String.raw`\sum_{s\in\mathfrak M}s(M)s(1)e^{K E(s)}
=2\left(2\sinh K\right)^{M-1}`),
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
        String.raw`\Phi : \mathfrak{M} \longrightarrow \{-1,1\}\times\{-1,1\}^{M-1},
\qquad
\Phi(s) := \left(s(1);\ t_1,\dots,t_{M-1}\right), \quad t_m := s(m)s(m+1)`,
      ),
      paragraph([
        "は全単射である。実際、",
        math(String.raw`(s(1);t_1,\dots,t_{M-1})`),
        " から漸化式 ",
        math(String.raw`s(m+1)=s(m)t_m`),
        " によって ",
        math(String.raw`s(2),\dots,s(M)`),
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
\prod_{m=1}^{M-1}t_m
&= \prod_{m=1}^{M-1}s(m)s(m+1)
&&\bigl(\because\ t_m:=s(m)s(m+1)\bigr)\\
&= s(1)\left(\prod_{m=2}^{M-1}s(m)s(m)\right)s(M)
&&\bigl(\because\ \mathbb R\text{ の乗法の可換性と結合性}\bigr)\\
&= s(1)\left(\prod_{m=2}^{M-1}1\right)s(M)
&&\bigl(\because\ s(m)s(m)=1\text{ を各 }m\text{ へ同時適用}\bigr)\\
&= s(1)s(M)
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
        math(String.raw`e^{KE(s)}=\prod_{m=1}^{M-1}e^{Kt_m}`),
        " である。したがって",
      ]),
      paragraph([ref("def_cosh_sinh"), " より、最後から二つ目の等号が成り立つ。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{s\in\mathfrak{M}}s(M)s(1)e^{KE(s)}
&= \sum_{s(1)\in\{-1,1\}}\ \sum_{t_1,\dots,t_{M-1}\in\{-1,1\}}
   \left(\prod_{m=1}^{M-1}t_m\right)\prod_{m=1}^{M-1}e^{Kt_m}
   \quad (\because \text{Step 1 の全単射と直前の等式}) \\
&= \left(\sum_{s(1)\in\{-1,1\}}1\right)
   \prod_{m=1}^{M-1}\left(\sum_{t_m\in\{-1,1\}}t_m\,e^{Kt_m}\right)
   \quad (\because \text{有限個の因子の積の展開}) \\
&= 2\prod_{m=1}^{M-1}\left(e^{K}-e^{-K}\right)
   \quad (\because \text{二元集合 }\{-1,1\}\text{ 上の二つの有限和を計算}) \\
&= 2\prod_{m=1}^{M-1}\left(2\sinh K\right)
   \quad \left(\because \text{双曲線正弦の定義}\right) \\
&= 2\left(2\sinh K\right)^{M-1}
   \quad (\because \text{同じ因子 }2\sinh K\text{ の }M-1\text{ 個の積})
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
    origin: { path: SRC, ordinal: 7 },
    title: { text: "1次元開鎖の二つのスピン和の正値性" },
    labels: ["open_chain_spin_sums_positive"],
    statement: [
      paragraph([
        ref("def_open_chain_spin_energy"),
        " の ",
        math(String.raw`M\in\mathbb Z_{\geq2}`),
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
      paragraph([
        ref("cosh_sinh_basic_properties"),
        " より ",
        math(String.raw`\cosh K > 0`),
        " かつ ",
        math(String.raw`\sinh K > 0`),
        " である。また ",
        math(String.raw`M-1\in\mathbb Z_{>0}`),
        " だから、二つの公式の右辺はいずれも正の実数である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "1次元 Ising 開鎖の分配関数と両端相関を挿入した和の正値性であり、trace_of_epsilon_V_plus の符号を決める。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,…,8 の全配置を直接列挙）。",
      ],
    },
  },

  {
    id: "closing_006_theorem_trace_of_epsilon_V_plus",
    kind: "theorem",
    origin: { path: SRC, ordinal: 8 },
    title: {
      tex: String.raw`\mathrm{tr}\!\left(\varepsilon V^{(+)}\right)
= \left(2e^{-K_2}\cosh K_1\right)^{M} + \left(2e^{K_2}\sinh K_1\right)^{M} > 0`,
    },
    labels: ["trace_of_epsilon_V_plus"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_V_plus_and_T_V_plus"),
        " の ",
        math(String.raw`V^{(+)} = \left(V_1^{(+)}\right)^{1/2}V_2\left(V_1^{(+)}\right)^{1/2}`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\varepsilon\,V^{(+)}\right)
= \left(2e^{-K_2}\cosh K_1\right)^{M}
+ \left(2e^{K_2}\sinh K_1\right)^{M}
\ \in\ \mathbb{R}_{>0}`,
      ),
      paragraph([
        "が成り立つ。**この計算には ",
        math(String.raw`\check{Z},\check{Y},\check\psi`),
        " も半整数運動量も現れない。** 転送行列を配置の基底（",
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
        math(String.raw`B := \left(V_1^{(+)}\right)^{1/2} = \exp\!\left(\tfrac12 iK_1H_1^{(+)}\right)`),
        "（",
        ref("def_V_plus_and_T_V_plus"),
        "）と略記し、",
        ref("H1_plus_in_sigma_z_form"),
        " (3) の ",
        math(String.raw`D_0, G`),
        " を用いる。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\varepsilon`),
        " を外へ出す）。",
        ref("epsilon_commutes_with_transfer_matrices"),
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
   \quad (\because \text{def\_V\_plus\_and\_T\_V\_plus}) \\
&= \mathrm{tr}\!\left(B\,\varepsilon\,V_2\,B\right)
   \quad (\because \text{epsilon\_commutes\_with\_transfer\_matrices の }
   \varepsilon B = B\varepsilon) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_2\,B\,B\right)
   \quad (\because \text{trace\_basic\_properties (2) の巡回性を }
   A = B,\ B' = \varepsilon V_2B \text{ に適用}) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_2\,V_1^{(+)}\right)
   \quad \left(\because \text{theorem\_exp\_product より } BB = V_1^{(+)}\right) \\
&= \mathrm{tr}\!\left(V_1^{(+)}\,\varepsilon\,V_2\right)
   \quad (\because \text{trace\_basic\_properties (2) の巡回性}) \\
&= \mathrm{tr}\!\left(\varepsilon\,V_1^{(+)}\,V_2\right)
   \quad (\because \text{epsilon\_commutes\_with\_transfer\_matrices より }
   V_1^{(+)}\varepsilon=\varepsilon V_1^{(+)})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\varepsilon V_1^{(+)}`),
        " を対角行列と ",
        math(String.raw`\varepsilon`),
        " で書く）。",
        ref("def_V1_pm"),
        " より ",
        math(String.raw`V_1^{(+)} = \exp\!\left(iK_1H_1^{(+)}\right)`),
        " であり、",
        ref("H1_plus_in_sigma_z_form"),
        " (3) より ",
        math(String.raw`iK_1H_1^{(+)} = K_1D_0 + K_1\varepsilon G`),
        " である。同 (4) より ",
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
        ref("H1_plus_in_sigma_z_form"),
        " (4) の ",
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
        ref("H1_plus_in_sigma_z_form"),
        " (4) より ",
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
        " の同一視のもとで基底を ",
        math(String.raw`f_{\iota(s)}`),
        "（",
        math(String.raw`s \in \mathfrak{M}`),
        "）とする。次の 3 つを読み取る。",
      ]),
      list([
        [
          "(a) ",
          ref("H1_plus_in_sigma_z_form"),
          " と ",
          ref("exp_of_diagonal_matrix"),
          " より ",
          math(String.raw`\exp(K_1D_0)`),
          " は対角行列で ",
          math(String.raw`\left(\exp(K_1D_0)\right)_{\iota(s),\iota(s)} = e^{K_1E(s)}`),
          "（",
          math(String.raw`E(s) = \sum_{m=1}^{M-1}s(m)s(m+1)`),
          " は ",
          ref("def_open_chain_spin_energy"),
          " のもの）。同じく ",
          math(String.raw`G`),
          " は対角行列で ",
          math(String.raw`G_{\iota(s),\iota(s)} = s(M)s(1)`),
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
          ref("V2_component_equals_pauli"),
          " より ",
          math(String.raw`(V_2)_{\iota(s),\iota(s')} = \exp\!\left(K_2\sum_{m=1}^{M}s(m)s'(m)\right)`),
          "。とくに ",
          math(String.raw`(V_2)_{\iota(s),\iota(s)} = e^{MK_2}`),
          "、",
          math(String.raw`(V_2)_{\iota(-s),\iota(s)} = e^{-MK_2}`),
          "。",
        ],
      ]),
      paragraph([
        "(b) の理由：",
        ref("def_end_iso"),
        " の基底は ",
        math(String.raw`f_I = e_{i_1}\boxtimes\cdots\boxtimes e_{i_M}`),
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
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x`),
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
        math(String.raw`\sum_m s(m)s(m) = M`),
        " と ",
        math(String.raw`\sum_m(-s(m))s(m) = -M`),
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
&= e^{K_1E(s)}\left(\varepsilon V_2\right)_{\iota(s),\iota(s)}
   \quad (\because \text{(a) の対角性}) \\
&= e^{K_1E(s)}\left(V_2\right)_{\iota(-s),\iota(s)}
   \quad (\because \text{(b), } \varepsilon \text{ は行番号 } \iota(s)
   \text{ を } \iota(-s) \text{ に移す置換行列}) \\
&= e^{K_1E(s)}\,e^{-MK_2}
   \quad (\because \text{(c)})
\end{aligned}`,
      ),
      paragraph(["第 2 項の対角成分は同様に"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\exp(K_1D_0)\,G\,V_2\right)_{\iota(s),\iota(s)}
&= e^{K_1E(s)}\left(G\,V_2\right)_{\iota(s),\iota(s)}
   \quad (\because \text{(a) の } \exp(K_1D_0) \text{ の対角性}) \\
&= e^{K_1E(s)}\,s(M)s(1)\,\left(V_2\right)_{\iota(s),\iota(s)}
   \quad (\because \text{(a) の } G \text{ の対角性}) \\
&= e^{K_1E(s)}\,s(M)s(1)\,e^{MK_2}
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
&= \cosh(K_1)\,e^{-MK_2}\sum_{s\in\mathfrak{M}}e^{K_1E(s)}
 + \sinh(K_1)\,e^{MK_2}\sum_{s\in\mathfrak{M}}s(M)s(1)e^{K_1E(s)}
   \quad (\because \text{def\_trace と直前の 2 式}) \\
&= \cosh(K_1)\,e^{-MK_2}\cdot 2\left(2\cosh K_1\right)^{M-1}
 + \sinh(K_1)\,e^{MK_2}\cdot 2\left(2\sinh K_1\right)^{M-1}
   \quad (\because \text{二つの1次元開鎖のスピン和公式}) \\
&= 2^{M}e^{-MK_2}\left(\cosh K_1\right)^{M}
 + 2^{M}e^{MK_2}\left(\sinh K_1\right)^{M}
   \quad \left(\because 2\cdot 2^{M-1} = 2^{M}\right) \\
&= \left(2e^{-K_2}\cosh K_1\right)^{M}
 + \left(2e^{K_2}\sinh K_1\right)^{M}
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
        math(String.raw`e^{\pm K_2} > 0`),
        "。したがって、その等号の二項はともに正であり、和も正である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この主張が章 C′ の最後の欠けていた入力である。ε の固有値 η がどちらになるかは固有値 Λ̌_ε の値からは読めないが、tr(εV^{(+)}) は転送行列の側で完全に初等的に計算でき、しかも正であることが分かる。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_03（M=2,3,4,5・6 組の (K_1,K_2) で、行列指数関数から直接構成した V^{(+)} のトレースと閉じた式の相対差 ≤ 6e-15）。",
      ],
    },
  },

  {
    id: "closing_007_theorem_max_eigenvector_in_even_sector",
    kind: "theorem",
    origin: { path: SRC, ordinal: 9 },
    title: {
      tex: String.raw`\varepsilon \text{ の固有値は } +1, \ 
\mathrm{im}\,\check{Q}_{(1,\dots,1)} \subseteq \mathcal{F}^{(+)}`,
    },
    labels: ["max_eigenvector_in_even_sector"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("epsilon_eigenvalue_on_check_Q"),
        " の ",
        math(String.raw`\eta_\epsilon`),
        " について次が成り立つ。",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \eta_{(1,\dots,1)} = +1`)],
        [
          math(String.raw`\text{(2)}\quad \eta_\epsilon = (-1)^{M-|\epsilon|}
= (-1)^{M+|\epsilon|}`),
          "、すなわち ",
          math(String.raw`\varepsilon\check{Q}_\epsilon
= (-1)^{M+|\epsilon|}\check{Q}_\epsilon`),
          "。",
        ],
        [
          math(String.raw`\text{(3)}\quad \varepsilon
= (-1)^{M}\prod_{\mu=1}^{M}\left(I - 2\check{n}_\mu\right)`),
        ],
        [
          math(String.raw`\text{(4)}\quad \mathrm{im}\,\check{Q}_{(1,\dots,1)}
\subseteq \mathcal{F}^{(+)}`),
          "（",
          ref("def_eigenspaces_of_epsilon"),
          " の ",
          math(String.raw`\mathcal{F}^{(+)}`),
          "）。すなわち **",
          math(String.raw`V^{(+)}`),
          " の最大固有値 ",
          math(String.raw`\check\Lambda_{\max}`),
          " の固有ベクトルは偶セクターに属する**。",
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
        math(String.raw`\eta_\epsilon = (-1)^{M-|\epsilon|}`),
        "。",
        math(String.raw`(-1)^{-|\epsilon|} = (-1)^{|\epsilon|}`),
        "（",
        math(String.raw`(-1)^{|\epsilon|}(-1)^{|\epsilon|} = 1`),
        " より）なので ",
        math(String.raw`(-1)^{M-|\epsilon|} = (-1)^{M+|\epsilon|}`),
        "。",
      ]),
      paragraph([
        "(3) ",
        ref("epsilon_eigenvalue_on_check_Q"),
        " (4) に (1) を代入する。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`|(1,\dots,1)| = M`),
        " なので (2) を一段ずつ適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\check{Q}_{(1,\dots,1)}
&= (-1)^{M+|(1,\dots,1)|}\check{Q}_{(1,\dots,1)}
   \quad (\because \text{(2)}) \\
&= (-1)^{2M}\check{Q}_{(1,\dots,1)}
   \quad (\because |(1,\dots,1)|=M) \\
&= \check{Q}_{(1,\dots,1)}
   \quad (\because (-1)^{2M}=1)
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
      ],
    },
  },

  {
    id: "closing_008_claim_check_Q_is_hermitian",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`\check{n}_\mu, \check{Q}_\epsilon \text{ はエルミート}` },
    labels: ["check_number_operator_is_hermitian"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " とする。",
        math(String.raw`X^*`),
        " を ",
        ref("def_hermitian_positive_definite"),
        " の転置共役とすると、",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad Z_j^* = Z_j, \qquad Y_j^* = Y_j
\qquad (j \in \{1,\dots,M\})`),
        ],
        [
          math(String.raw`\text{(2)}\quad \check{Z}_\mu^* = \check{Z}_{M+1-\mu},
\qquad \check{Y}_\mu^* = \check{Y}_{M+1-\mu}`),
        ],
        [
          math(String.raw`\text{(3)}\quad \left(\check\psi_\mu^\dagger\right)^*
= \check\psi_{M+1-\mu}`),
        ],
        [
          math(String.raw`\text{(4)}\quad \check{n}_\mu^* = \check{n}_\mu,
\qquad \check{Q}_\epsilon^* = \check{Q}_\epsilon
\qquad \left(\epsilon \in \{0,1\}^{\check{\mathcal{M}}}\right)`),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\check{Q}_\epsilon`),
        " はエルミートな冪等行列なので、任意の ",
        math(String.raw`x \in \mathbb{C}^{2^M}`),
        " について",
      ]),
      displayMath(
        String.raw`x^*\check{Q}_\epsilon x
= x^*\check{Q}_\epsilon^*\check{Q}_\epsilon x
= \left\|\check{Q}_\epsilon x\right\|^2 \geq 0`,
      ),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("Z_Y_linearly_independent"),
        " の証明で用いた Pauli 行列の成分表示より ",
        math(String.raw`\left(\sigma^x\right)^* = \sigma^x`),
        "、",
        math(String.raw`\left(\sigma^y\right)^* = \sigma^y`),
        "、",
        math(String.raw`\left(\sigma^z\right)^* = \sigma^z`),
        " である（",
        math(String.raw`\sigma^y`),
        " は転置で ",
        math(String.raw`(1,2)`),
        " 成分 ",
        math(String.raw`-i`),
        " と ",
        math(String.raw`(2,1)`),
        " 成分 ",
        math(String.raw`i`),
        " が入れ替わり、複素共役でさらに符号が戻る）。",
        ref("kronecker_product_rule"),
        " (2) の成分の定義より ",
        math(String.raw`\left(A_1\boxtimes\cdots\boxtimes A_M\right)^*
= A_1^*\boxtimes\cdots\boxtimes A_M^*`),
        " なので ",
        math(String.raw`\left(\sigma_k^a\right)^* = \sigma_k^a`),
        "（",
        math(String.raw`a \in \{x,y,z\}`),
        "）。",
      ]),
      paragraph([
        math(String.raw`(XW)^* = W^*X^*`),
        " と、相異なるサイトの因子が可換であること（",
        ref("kronecker_product_rule"),
        " (1)）から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_j^*
&= \left(\sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z\right)^*
   \quad (\because \text{def\_transfer\_matrix\_symbols}) \\
&= \left(\sigma_j^z\right)^*\left(\sigma_{j-1}^x\right)^*\cdots\left(\sigma_1^x\right)^*
   \quad (\because (XW)^* = W^*X^*) \\
&= \sigma_j^z\,\sigma_{j-1}^x\cdots\sigma_1^x
   \quad (\because \text{直前の段落}) \\
&= \sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z
   \quad (\because \text{相異なるサイトの因子は可換}) \\
&= Z_j
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_j`),
        " も同じ計算である。",
      ]),
      paragraph([
        "(2) ",
        ref("conjugate_index_of_check_Z_Y"),
        " (2) より ",
        math(String.raw`e^{-ij\tilde\theta_{M+1-\mu}} = e^{ij\tilde\theta_\mu}`),
        " である。",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        " なので ",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`\overline{e^{-ij\tilde\theta_\mu}} = e^{ij\tilde\theta_\mu}`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_\mu^*
&= \left(\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}Z_j\right)^*
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M}\overline{e^{-ij\tilde\theta_\mu}}\;Z_j^*
   \quad (\because \text{転置共役は和を保ち、スカラー倍を複素共役つきで保つ}) \\
&= \sum_{j=1}^{M}e^{ij\tilde\theta_\mu}\,Z_j
   \quad (\because \text{(1) と } \tilde\theta_\mu \in \mathbb{R}) \\
&= \sum_{j=1}^{M}e^{-ij\tilde\theta_{M+1-\mu}}\,Z_j
   \quad (\because \text{conjugate\_index\_of\_check\_Z\_Y (2)}) \\
&= \check{Z}_{M+1-\mu}
   \quad (\because \text{def\_half\_integer\_modes})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\check{Y}_\mu`),
        " も同じ計算である（",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M+1-\mu \in \check{\mathcal{M}}`),
        " なので右辺は定義されている）。",
      ]),
      paragraph([
        "(3) ",
        ref("def_check_fermi"),
        " より、",
        math(String.raw`\nu := M+1-\mu`),
        "、",
        math(String.raw`\beta := \dfrac{1}{2\sqrt{M}} \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`\alpha_\mu := \dfrac{-\left|\gamma_2(\tilde\theta_\mu)\right|}
{2\sqrt{M}\,\gamma_2(-\tilde\theta_\mu)}`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\check\psi_\mu^\dagger = \alpha_\mu\check{Z}_\mu + \beta\check{Y}_\mu,
\qquad
\check\psi_\nu = -\alpha_\nu\check{Z}_\nu + \beta\check{Y}_\nu`,
      ),
      paragraph([
        "である。まず ",
        math(String.raw`\overline{\alpha_\mu} = -\alpha_\nu`),
        " を示す。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の ",
        math(String.raw`\gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)}`),
        " より ",
        math(String.raw`\left|\gamma_2(-\tilde\theta_\mu)\right|
= \left|\gamma_2(\tilde\theta_\mu)\right|`),
        " であり、",
        ref("periodicity_of_check_fermi"),
        " (3) より ",
        math(String.raw`\gamma_2(\tilde\theta_\nu) = \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`\gamma_2(-\tilde\theta_\nu) = \gamma_2(\tilde\theta_\mu)`),
        " である。よって ",
        math(String.raw`r := \left|\gamma_2(\tilde\theta_\mu)\right|
= \left|\gamma_2(\tilde\theta_\nu)\right| \in \mathbb{R}_{>0}`),
        "（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）と書けて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\overline{\alpha_\mu}
&= \overline{\left(\frac{-r}{2\sqrt{M}\,\gamma_2(-\tilde\theta_\mu)}\right)}
   \quad (\because \alpha_\mu \text{ の定義}) \\
&= \frac{-r}{2\sqrt{M}\,\overline{\gamma_2(-\tilde\theta_\mu)}}
   \quad \left(\because r, 2\sqrt{M} \in \mathbb{R} \text{ と }
   \overline{z^{-1}} = \left(\bar z\right)^{-1}\right) \\
&= \frac{-r}{2\sqrt{M}\left(-\gamma_2(\tilde\theta_\mu)\right)}
   \quad \left(\because \text{relation\_of\_gamma\_2\_theta\_tilde (1) を }
   \overline{\gamma_2(-\tilde\theta_\mu)} = -\gamma_2(\tilde\theta_\mu)
   \text{ の形で使う}\right) \\
&= \frac{r}{2\sqrt{M}\,\gamma_2(\tilde\theta_\mu)} \\
&= \frac{r}{2\sqrt{M}\,\gamma_2(-\tilde\theta_\nu)}
   \quad (\because \text{periodicity\_of\_check\_fermi (3)}) \\
&= -\alpha_\nu
   \quad (\because \alpha_\nu \text{ の定義と }
   \left|\gamma_2(\tilde\theta_\nu)\right| = r)
\end{aligned}`,
      ),
      paragraph([
        "（3 段目で使った ",
        math(String.raw`\overline{\gamma_2(-\tilde\theta_\mu)} = -\gamma_2(\tilde\theta_\mu)`),
        " は、",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の両辺の複素共役を取り ",
        math(String.raw`\overline{\overline{z}} = z`),
        " を使ったものである。）これを使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\check\psi_\mu^\dagger\right)^*
&= \left(\alpha_\mu\check{Z}_\mu + \beta\check{Y}_\mu\right)^*
   \quad (\because \text{def\_check\_fermi}) \\
&= \overline{\alpha_\mu}\,\check{Z}_\mu^* + \overline{\beta}\,\check{Y}_\mu^*
   \quad (\because \text{転置共役の線型性（複素共役つき）}) \\
&= \overline{\alpha_\mu}\,\check{Z}_\nu + \beta\,\check{Y}_\nu
   \quad (\because \text{(2) と } \beta \in \mathbb{R}) \\
&= -\alpha_\nu\check{Z}_\nu + \beta\check{Y}_\nu
   \quad \left(\because \overline{\alpha_\mu} = -\alpha_\nu\right) \\
&= \check\psi_\nu
   \quad (\because \text{def\_check\_fermi})
\end{aligned}`,
      ),
      paragraph([
        "(4) (3) の両辺の転置共役を取り ",
        math(String.raw`(X^*)^* = X`),
        " を使うと ",
        math(String.raw`\left(\check\psi_{M+1-\mu}\right)^* = \check\psi_\mu^\dagger`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu^*
&= \left(\check\psi_\mu^\dagger\check\psi_{M+1-\mu}\right)^*
&&\left(\because\ \text{def\_check\_fermi}\right)\\
&= \left(\check\psi_{M+1-\mu}\right)^*\left(\check\psi_\mu^\dagger\right)^*
&&\left(\because\ (XW)^*=W^*X^*\right)\\
&= \check\psi_\mu^\dagger\,\check\psi_{M+1-\mu}
&&\left(\because\ \text{(3) とその転置共役}\right)\\
&= \check{n}_\mu
&&\left(\because\ \text{def\_check\_fermi}\right)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M}R_\mu^{(\epsilon_\mu)}`),
        "（",
        math(String.raw`R_\mu^{(1)} = \check{n}_\mu`),
        "、",
        math(String.raw`R_\mu^{(0)} = I - \check{n}_\mu`),
        "）について、各因子はエルミートで（",
        math(String.raw`I^* = I`),
        "）、",
        ref("check_number_operators_commute"),
        " (2) より互いに可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon^*
&= \left(R_1^{(\epsilon_1)}\cdots R_M^{(\epsilon_M)}\right)^*
&&\left(\because\ \text{check\_joint\_eigenspace\_decomposition}\right)\\
&= \left(R_M^{(\epsilon_M)}\right)^*\cdots\left(R_1^{(\epsilon_1)}\right)^*
&&\left(\because\ (XW)^*=W^*X^*\text{ の反復適用}\right)\\
&= R_M^{(\epsilon_M)}\cdots R_1^{(\epsilon_1)}
&&\left(\because\ \check n_\mu^*=\check n_\mu\text{ と }I^*=I\right)\\
&= R_1^{(\epsilon_1)}\cdots R_M^{(\epsilon_M)}
&&\left(\because\ \text{因子の可換性。check\_number\_operators\_commute (2)}\right)\\
&= \check{Q}_\epsilon
&&\left(\because\ \text{check\_joint\_eigenspace\_decomposition}\right)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " (1) の ",
        math(String.raw`\check{Q}_\epsilon^2 = \check{Q}_\epsilon`),
        " と合わせると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*\check{Q}_\epsilon x
&=x^*\check{Q}_\epsilon^*\check{Q}_\epsilon x
&&\left(\because\ \check{Q}_\epsilon^*=\check{Q}_\epsilon\text{ と }\check{Q}_\epsilon^2=\check{Q}_\epsilon\right)\\
&=\left(\check{Q}_\epsilon x\right)^*\left(\check{Q}_\epsilon x\right)
&&\left(\because\ (XW)^*=W^*X^*\right)\\
&=\left\|\check{Q}_\epsilon x\right\|^2
&&\left(\because\ \text{複素ベクトルのノルムの定義}\right)\\
&\geq0
&&\left(\because\ \text{実数の平方和は非負}\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "c_+(M) ≤ Λ̌_max を示すのに必要なのは「Q̌_ε がエルミートな冪等行列であること」だけである。これがあれば x^*V^{(+)}x = Σ_ε Λ̌_ε ‖Q̌_ε x‖² と書けて、スペクトル定理（実対称行列の対角化可能性）を持ち出さずに Rayleigh 商の上限が押さえられる。011 章が「固有値の存在を使わない」方針を取っているのと整合する。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_04（(ψ̌_μ^†)^* = ψ̌_{M+1−μ}、ň_μ, Q̌_ε のエルミート性、残差 ≤ 1.2e-14）。",
      ],
    },
  },

  {
    id: "closing_009_theorem_c_plus_equals_Lambda_half",
    kind: "theorem",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`c_+(M) = \Lambda^{(1/2)}_M` },
    labels: ["c_plus_equals_Lambda_half_integer"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("sector_decomposition_of_rayleigh_sup"),
        " の",
      ]),
      displayMath(
        String.raw`c_+(M) = \sup\left\{\, x^\top W x \ \middle|\
x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M},\ \|x\| = 1 \,\right\}`,
      ),
      paragraph([
        "と ",
        ref("onsager_free_energy_expression"),
        " の ",
        math(String.raw`\Lambda^{(1/2)}_M`),
        " について",
      ]),
      displayMath(
        String.raw`c_+(M) = \check\Lambda_{\max} = \Lambda^{(1/2)}_M
= (2\sinh 2K_2)^{M/2}
\exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)\right)`,
      ),
      paragraph([
        "が成り立つ。**上限は達成される**（最大値である）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上で ",
        math(String.raw`W`),
        " と ",
        math(String.raw`V^{(+)}`),
        " が一致すること）。",
        math(String.raw`x \in \mathcal{F}^{(+)}`),
        " なら、",
        ref("epsilon_projector_properties"),
        " (4) と ",
        ref("def_epsilon_projectors"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)}x
&= \tfrac12(x + \varepsilon x)
   \quad (\because \text{def\_epsilon\_projectors の } P^{(+)} \text{ の定義}) \\
&= \tfrac12(x + x)
   \quad (\because x \in \mathcal{F}^{(+)} \text{ より } \varepsilon x = x
   \text{（def\_eigenspaces\_of\_epsilon の固有空間）}) \\
&= x
   \quad (\because \text{スカラー倍を整理する})
\end{aligned}`,
      ),
      paragraph([
        "である。したがって ",
        ref("sector_decomposition_of_rayleigh_sup"),
        " (2) の ",
        math(String.raw`WP^{(+)} = V^{(+)}P^{(+)}`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Wx
&= WP^{(+)}x
   \quad (\because \text{直前の } P^{(+)}x = x) \\
&= V^{(+)}P^{(+)}x
   \quad (\because \text{sector\_decomposition\_of\_rayleigh\_sup (2) の }
   WP^{(+)} = V^{(+)}P^{(+)}) \\
&= V^{(+)}x
   \quad (\because \text{直前の } P^{(+)}x = x)
\end{aligned}
\qquad \left(x \in \mathcal{F}^{(+)}\right)`,
      ),
      paragraph([
        "Step 1（",
        math(String.raw`c_+(M) \leq \check\Lambda_{\max}`),
        "）。",
        math(String.raw`x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " とする。",
        math(String.raw`x`),
        " は実ベクトルなので ",
        math(String.raw`x^\top = x^*`),
        " である。",
        ref("check_joint_eigenspace_decomposition"),
        " (2) と ",
        ref("eigenvalues_of_V_plus"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top W x
&= x^*V^{(+)}x
   \quad (\because \text{Step 0 と } x^\top = x^*) \\
&= x^*V^{(+)}\left(\sum_{\epsilon}\check{Q}_\epsilon\right)x
   \quad (\because \text{check\_joint\_eigenspace\_decomposition (2)}) \\
&= \sum_{\epsilon}\check\Lambda_\epsilon\,x^*\check{Q}_\epsilon x
   \quad (\because \text{eigenvalues\_of\_V\_plus (1)}) \\
&= \sum_{\epsilon}\check\Lambda_\epsilon
   \left\|\check{Q}_\epsilon x\right\|^2
   \quad (\because \text{check\_number\_operator\_is\_hermitian (4)})
\end{aligned}`,
      ),
      paragraph([
        ref("eigenvalues_of_V_plus"),
        " (2) より ",
        math(String.raw`0 < \check\Lambda_\epsilon \leq \check\Lambda_{\max}`),
        " であり、各 ",
        math(String.raw`\left\|\check{Q}_\epsilon x\right\|^2 \geq 0`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top Wx
&\leq \check\Lambda_{\max}
 \sum_{\epsilon}\left\|\check{Q}_\epsilon x\right\|^2
 &&\left(\because\ 0<\check\Lambda_\epsilon\leq\check\Lambda_{\max}
 \text{ と }\left\|\check{Q}_\epsilon x\right\|^2\geq0\right)\\
&= \check\Lambda_{\max}\sum_{\epsilon}x^*\check{Q}_\epsilon x
 &&\left(\because\ \check Q_\epsilon\text{ はエルミートな冪等行列}
 \text{（check\_number\_operator\_is\_hermitian (4)）}\right)\\
&= \check\Lambda_{\max}\,x^*\!\left(\sum_{\epsilon}\check{Q}_\epsilon\right)\!x
 &&\left(\because\ \text{有限和に対する行列積の分配則}\right)\\
&= \check\Lambda_{\max}\,x^*x
 &&\left(\because\ \sum_\epsilon\check Q_\epsilon=I
 \text{（check\_joint\_eigenspace\_decomposition (2)）}\right)\\
&= \check\Lambda_{\max}\,\|x\|^2
 &&\left(\because\ \text{複素ベクトルのノルムの定義}\right)\\
&= \check\Lambda_{\max}
 &&\left(\because\ \|x\|=1\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x`),
        " は任意だったので ",
        math(String.raw`c_+(M) \leq \check\Lambda_{\max}`),
        "。",
      ]),
      paragraph([
        "Step 2（実の最大固有ベクトルの存在）。",
        ref("check_joint_eigenspace_decomposition"),
        " (4) より ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " は 1 次元なので、生成元 ",
        math(String.raw`q \neq 0`),
        " を取る。",
        ref("eigenvalues_of_V_plus"),
        " (1) より ",
        math(String.raw`V^{(+)}q = \check\Lambda_{\max}q`),
        " である。",
      ]),
      paragraph([
        math(String.raw`V^{(+)}`),
        " の成分は実である。実際 ",
        ref("V_plus_is_positive_definite"),
        " の表示 ",
        math(String.raw`V^{(+)} = (2s_2)^{M/2}\exp\!\left(\tfrac12S_1^{(+)}\right)
\exp(S_2)\exp\!\left(\tfrac12S_1^{(+)}\right)`),
        " において、",
        ref("iH_is_real_symmetric"),
        " より ",
        math(String.raw`S_1^{(+)}, S_2`),
        " は実対称であり、",
        ref("W_is_real_symmetric_positive_definite"),
        " の Step 2 と同じ議論（実対称行列の冪は実対称、",
        ref("def_exp"),
        " の部分和も実対称、",
        ref("star_preserves_norm_and_limits"),
        " (3) と同様に転置もノルムを保つので極限も実対称）により ",
        math(String.raw`\exp\!\left(\tfrac12S_1^{(+)}\right)`),
        " と ",
        math(String.raw`\exp(S_2)`),
        " は実対称、",
        math(String.raw`(2s_2)^{M/2} \in \mathbb{R}_{>0}`),
        " なので ",
        math(String.raw`V^{(+)}`),
        " も実行列である。",
      ]),
      paragraph([
        "したがって ",
        math(String.raw`\overline{V^{(+)}q} = V^{(+)}\overline{q}`),
        " であり、",
        math(String.raw`\check\Lambda_{\max} \in \mathbb{R}`),
        "（",
        ref("eigenvalues_of_V_plus"),
        "）なので ",
        math(String.raw`V^{(+)}\overline{q} = \check\Lambda_{\max}\overline{q}`),
        "。",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (3) より固有空間は 1 次元の ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)} = \mathbb{C}q`),
        " なので、ある ",
        math(String.raw`z \in \mathbb{C}`),
        " で ",
        math(String.raw`\overline{q} = zq`),
        " と書ける。",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`p := q + \overline{q} = (1+z)q`),
        "、",
        math(String.raw`p' := i\left(q - \overline{q}\right) = i(1-z)q`),
        " とおくと、",
        math(String.raw`\overline{p} = p`),
        "、",
        math(String.raw`\overline{p'} = \overline{i}\left(\overline{q}-q\right)
= (-i)\left(\overline{q}-q\right) = p'`),
        " なので ",
        math(String.raw`p, p'`),
        " はいずれも実ベクトルである。",
        math(String.raw`1+z`),
        " と ",
        math(String.raw`i(1-z)`),
        " が同時に ",
        math(String.raw`0`),
        " になることはない（",
        math(String.raw`z = -1`),
        " かつ ",
        math(String.raw`z = 1`),
        " は不可能）ので、",
        math(String.raw`p`),
        " と ",
        math(String.raw`p'`),
        " の少なくとも一方は ",
        math(String.raw`0`),
        " でない。それを ",
        math(String.raw`v`),
        " とすると ",
        math(String.raw`v \in \mathbb{C}q\setminus\{0\}`),
        " かつ ",
        math(String.raw`v \in \mathbb{R}^{2^M}`),
        " である。",
        math(String.raw`x_0 := v/\|v\|`),
        " とおく。",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`c_+(M) \geq \check\Lambda_{\max}`),
        "）。",
        math(String.raw`x_0 \in \mathbb{C}q = \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " なので ",
        ref("max_eigenvector_in_even_sector"),
        " (4) より ",
        math(String.raw`x_0 \in \mathcal{F}^{(+)}`),
        " であり、",
        math(String.raw`x_0`),
        " は実で ",
        math(String.raw`\|x_0\| = 1`),
        " である。Step 0 と ",
        ref("eigenvalues_of_V_plus"),
        " (1) より",
      ]),
      displayMath(
        String.raw`x_0^\top Wx_0
= x_0^\top V^{(+)}x_0
= x_0^\top\left(\check\Lambda_{\max}x_0\right)
= \check\Lambda_{\max}\,x_0^\top x_0
= \check\Lambda_{\max}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`c_+(M)`),
        " を定める集合は ",
        math(String.raw`\check\Lambda_{\max}`),
        " を要素にもち、",
        math(String.raw`c_+(M) \geq \check\Lambda_{\max}`),
        "。Step 1 と合わせて ",
        math(String.raw`c_+(M) = \check\Lambda_{\max}`),
        " であり、上限は ",
        math(String.raw`x_0`),
        " で達成される。",
      ]),
      paragraph([
        "最後に ",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (1) の ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_M`),
        " を代入すれば主張の等式を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "011 章の sector_decomposition_of_rayleigh_sup の注記が「c_+(M) に対応する V^{(+)} の固有値は本文では未確立」としていた点が、ここで解消される。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_04（P^{(+)}WP^{(+)} を F^{(+)} の実基底へ制限して最大固有値を直接求め、Λ^{(1/2)}_M と比較。相対差 ≤ 2e-14）。",
      ],
    },
  },

  {
    id: "closing_010_theorem_onsager_exact_solution",
    kind: "theorem",
    origin: { path: SRC, ordinal: 12 },
    title: { text: "2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）" },
    labels: ["onsager_exact_solution"],
    statement: [
      paragraph([
        ref("partition_function_in_pauli_form"),
        " と同じ設定（",
        math(String.raw`K_1 = J' > 0`),
        "、",
        math(String.raw`K_2 = J > 0`),
        "）のもとで、",
      ]),
      displayMath(
        String.raw`\lim_{M\to\infty}\ \lim_{N_{\mathrm{row}}\to\infty}
\frac{1}{M\,N_{\mathrm{row}}}\log Z(J,J')
= \frac{1}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "が成り立つ。ここで",
      ]),
      displayMath(
        String.raw`\gamma(\theta)
= \mathrm{arccosh}\!\left(\cosh 2K_1\cosh 2K_2^*
- \sinh 2K_1\sinh 2K_2^*\cos\theta\right)`,
      ),
      paragraph([
        "であり（",
        ref("gamma1_lower_bound_all_theta"),
        "）、これが Onsager の自由エネルギーの表式である。",
      ]),
      paragraph([
        "とくに ",
        ref("remark_remaining_input_even_sector"),
        " が「残っている入力」として挙げていた ",
        math(String.raw`c_+(M) = \Lambda^{(1/2)}_M`),
        " は ",
        ref("c_plus_equals_Lambda_half_integer"),
        " で証明された。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`N_{\mathrm{row}}`),
        " の極限）。",
        ref("limit_of_log_Z_in_N_row"),
        " より、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " を固定すると",
      ]),
      displayMath(
        String.raw`\lim_{N_{\mathrm{row}}\to\infty}
\frac{1}{M\,N_{\mathrm{row}}}\log Z(J,J') = \frac{1}{M}\log c(M)`,
      ),
      paragraph([
        "である。以下 ",
        math(String.raw`c(M)`),
        " の ",
        math(String.raw`M \to \infty`),
        " の挙動を調べる。",
      ]),
      paragraph([
        "Step 2（下からの評価 ",
        math(String.raw`c(M) \geq \Lambda^{(1/2)}_M`),
        "）。",
        ref("sector_decomposition_of_rayleigh_sup"),
        " (3) の ",
        math(String.raw`c(M) = \max(c_+(M), c_-(M)) \geq c_+(M)`),
        " と ",
        ref("c_plus_equals_Lambda_half_integer"),
        " より",
      ]),
      displayMath(String.raw`c(M) \geq c_+(M) = \Lambda^{(1/2)}_M`),
      paragraph([
        "Step 3（上からの評価 ",
        math(String.raw`c(M) \leq 2\Lambda^{(1/2)}_M`),
        "）。",
        math(String.raw`x \in \mathbb{R}^{2^M}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を任意に取る。成分ごとの絶対値を取ったベクトルを ",
        math(String.raw`u`),
        "（",
        math(String.raw`u_k := |x_k|`),
        "）とし、",
        math(String.raw`v := u + \varepsilon u`),
        " とおく。",
      ]),
      paragraph([
        ref("W_has_positive_entries"),
        " より ",
        math(String.raw`W`),
        " の成分はすべて正なので、",
      ]),
      displayMath(
        String.raw`u^\top Wu = \sum_{k,l}|x_k|\,|x_l|\,W_{kl}
\ \geq\ \left|\sum_{k,l}x_kx_lW_{kl}\right|
\ \geq\ x^\top Wx
\quad (\because \text{三角不等式と } W_{kl} > 0)`,
      ),
      paragraph([
        "である。また ",
        math(String.raw`\varepsilon`),
        " は各基底ベクトルを別の基底ベクトルへ写す置換行列（",
        ref("trace_of_epsilon_V_plus"),
        " の証明 Step 3 の (b)）なので、",
        math(String.raw`u \geq 0`),
        " なら ",
        math(String.raw`\varepsilon u \geq 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|\varepsilon u\|
&= \|u\|
&&\left(\because\ \varepsilon\ \text{は置換行列であり、成分の並べ替えは二乗和を変えない}\right)\\
&= \|x\|
&&\left(\because\ u_k=|x_k|\ \text{であり、ノルムは成分の絶対値だけで決まる}\right)\\
&= 1
&&\left(\because\ \|x\|=1\ \text{（Step 3 の }x\text{ の取り方）}\right)
\end{aligned}`),
      paragraph([
        "である。さらに ",
        math(String.raw`\varepsilon^\top = \varepsilon`),
        "（",
        ref("sector_decomposition_of_rayleigh_sup"),
        " の証明 (3) で確かめられている）。",
      ]),
      list([
        [
          displayMath(String.raw`\begin{aligned}
\varepsilon v
&= \varepsilon\left(u+\varepsilon u\right)
&&\left(\because\ v=u+\varepsilon u\right)\\
&= \varepsilon u+\varepsilon^2u
&&\left(\because\ \text{行列の分配則}\right)\\
&= \varepsilon u+u
&&\left(\because\ \varepsilon^2=I\right)\\
&=v
&&\left(\because\ v=u+\varepsilon u\right)
\end{aligned}`),
          " より ",
          math(String.raw`v \in \mathcal{F}^{(+)}`),
          "（",
          ref("epsilon_projector_properties"),
          " (1)）。また ",
          math(String.raw`v`),
          " は実である。",
        ],
        [
          math(String.raw`v \geq u \geq 0`),
          " かつ ",
          math(String.raw`u \neq 0`),
          " より ",
          math(String.raw`v \neq 0`),
          "。",
        ],
        [
          displayMath(String.raw`\begin{aligned}
\|v\|^2
&= \|u\|^2 + 2u^\top\varepsilon u + \|\varepsilon u\|^2
&&\left(\because\ v=u+\varepsilon u\text{ の展開と }\varepsilon^\top=\varepsilon\right)\\
&= 2 + 2u^\top\varepsilon u
&&\left(\because\ \|u\| = \|\varepsilon u\| = 1\right)\\
&\leq 4
&&\left(\because\ \text{Cauchy–Schwarz より } u^\top\varepsilon u \leq \|u\|\|\varepsilon u\| = 1\right)
\end{aligned}`),
        ],
        [
          displayMath(String.raw`\begin{aligned}
v^\top Wv
&=u^\top Wu+2u^\top W\varepsilon u+(\varepsilon u)^\top W(\varepsilon u)
&&\left(\because\ v=u+\varepsilon u\text{ の展開と }W^\top=W\right)\\
&=u^\top Wu+2u^\top W\varepsilon u+u^\top\varepsilon W\varepsilon u
&&\left(\because\ \varepsilon^\top=\varepsilon\right)\\
&=u^\top Wu+2u^\top W\varepsilon u+u^\top W\varepsilon^2u
&&\left(\because\ \varepsilon W=W\varepsilon.\ \text{\cref{lab:sector_decomposition_of_rayleigh_sup}}\right)\\
&=2u^\top Wu+2u^\top W\varepsilon u
&&\left(\because\ \varepsilon^2=I\right)\\
&\geq2u^\top Wu
&&\left(\because\ u,\varepsilon u\geq0\text{ と }W_{kl}>0\text{ より }u^\top W\varepsilon u\geq0\right)
\end{aligned}`),
        ],
      ]),
      paragraph([
        math(String.raw`\hat{v} := v/\|v\|`),
        " は ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
        " の単位ベクトルなので ",
        ref("c_plus_equals_Lambda_half_integer"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
\Lambda^{(1/2)}_M
&= c_+(M)
&&\left(\because\ \text{\cref{lab:c_plus_equals_Lambda_half_integer}}\right)\\
&\geq \hat{v}^\top W\hat{v}
&&\left(\because\ c_+(M)\text{ は }\mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}\text{ の単位ベクトル上の上限. \cref{lab:sector_decomposition_of_rayleigh_sup}}\right)\\
&= \frac{v^\top Wv}{\|v\|^2}
&&\left(\because\ \hat{v}=v/\|v\|\text{ の代入と二次形式の斉次性}\right)\\
&\geq \frac{2\,u^\top Wu}{\|v\|^2}
&&\left(\because\ v^\top Wv\geq2u^\top Wu\text{（上の式変形）と }\|v\|^2>0\right)\\
&\geq \frac{2\,u^\top Wu}{4}
&&\left(\because\ \|v\|^2\leq4\text{（上の式変形）と }u^\top Wu\geq0\text{（}u\geq0,\ W_{kl}>0\text{）}\right)\\
&= \frac{u^\top Wu}{2}
&&\left(\because\ \mathbb{R}\text{ の約分}\right)\\
&\geq \frac{x^\top Wx}{2}
&&\left(\because\ u^\top Wu\geq x^\top Wx\text{（上の三角不等式）}\right)
\end{aligned}`),
      paragraph([
        math(String.raw`x`),
        " は任意だったので、上限を取って ",
        math(String.raw`c(M) \leq 2\Lambda^{(1/2)}_M`),
        "。",
      ]),
      paragraph([
        "Step 4（挟み撃ち）。Step 2・Step 3 より ",
        math(String.raw`\Lambda^{(1/2)}_M \leq c(M) \leq 2\Lambda^{(1/2)}_M`),
        " であり、すべて正の実数なので ",
        math(String.raw`\log`),
        " の単調性から",
      ]),
      displayMath(
        String.raw`\frac{1}{M}\log\Lambda^{(1/2)}_M
\ \leq\ \frac{1}{M}\log c(M)
\ \leq\ \frac{1}{M}\log\Lambda^{(1/2)}_M + \frac{\log 2}{M}`,
      ),
      paragraph([
        math(String.raw`(\log 2)/M \to 0`),
        " なので、",
        ref("onsager_free_energy_expression"),
        " を ",
        math(String.raw`\delta = \tfrac12`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\lim_{M\to\infty}\frac{1}{M}\log c(M)
= \lim_{M\to\infty}\frac{1}{M}\log\Lambda^{(1/2)}_M
= \frac{1}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "Step 1 と合わせて主張の 2 重極限の値が定まる。",
      ]),
      paragraph([
        "**実数解析（Riemann 積分）を使ったのは ",
        ref("riemann_sum_to_integral"),
        " を経由する最後の等号だけである**（",
        ref("remark_real_analysis_escape_point"),
        "）。それ以外の段はすべて有限サイズの複素行列の積・和・トレースと、",
        "有限個の実数の不等式で書かれている。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "Step 3 の係数 2 は最良ではない（数値では c(M) = c_+(M) が全パラメータで成り立つ。sagemath/check/053_claim_even_sector_closing/check_05 (3')）。しかし 1/M を掛けて M → ∞ とすると log 2 / M → 0 で消えるため、Onsager の表式を出すにはこの粗い評価で十分である。",
        "この粗い評価を採ったのは c_-(M) の値に依存しないためである。一次情報で確認したところ c_-(M) = Λ^{(0)}_M は一般には成り立たない: 高温側 (K_1,K_2) = (0.05,0.1)（sinh2K_1 sinh2K_2 ≈ 0.020）では c_-(M)/Λ^{(0)}_M = 0.1102 で、M = 2,3,4,5 のすべてで一致しない（同 check_05 の対照出力）。V^{(-)} の最大固有値の固有ベクトルが F^{(+)} 側に落ちる場合があるためで、偶セクターで解決したのと同じ問題が奇セクターでは別の答えになりうる。本文はこの点に触れずに済む形にしてある。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_05（M=2,3,4,5 で c(M) = max(c_+,c_-) と W の最大固有値の一致、Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M、および M を大きくしたときの (1/M) log Λ^{(1/2)}_M の Onsager 積分への収束）。",
      ],
    },
  },
]);
