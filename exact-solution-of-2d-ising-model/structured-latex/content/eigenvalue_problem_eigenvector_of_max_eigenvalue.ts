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
        ref("epsilon_commutes_with_transfer_matrices"),
        " の Step 1 で",
      ]),
      displayMath(
        String.raw`\varepsilon\,\sigma_k^x = \sigma_k^x\,\varepsilon, \qquad
\varepsilon\,\sigma_k^z = -\,\sigma_k^z\,\varepsilon, \qquad
\varepsilon\,\sigma_k^y = -\,\sigma_k^y\,\varepsilon
\qquad (k \in \{1,\dots,M_{\mathrm{col}}\})`,
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
        ref("def_half_integer_checkZ"),
        " の ",
        math(String.raw`\check{Z}_\mu = \sum_{j=1}^{M_{\mathrm{col}}}Z_j\exp(-ij\tilde\theta_\mu)`),
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
&= \varepsilon\sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)Z_j
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)\left(\varepsilon\,Z_j\right)
   \quad (\because \text{積の } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)\left(-Z_j\,\varepsilon\right)
   \quad (\because \text{(1) を } M_{\mathrm{col}} \text{ 個の項へ同時適用}) \\
&= -\left(\sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)Z_j\right)\varepsilon
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
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " なので (3) を ",
        math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        " にも適用できる。",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu = \check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\check{n}_\mu
&= \varepsilon\,\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{def\_check\_number\_operator}) \\
&= \left(-\check\psi_\mu^\dagger\,\varepsilon\right)\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{(3)}) \\
&= -\check\psi_\mu^\dagger\left(\varepsilon\,\check\psi_{M_{\mathrm{col}}+1-\mu}\right)
   \quad (\because \text{結合法則}) \\
&= -\check\psi_\mu^\dagger\left(-\check\psi_{M_{\mathrm{col}}+1-\mu}\,\varepsilon\right)
   \quad (\because \text{(3) を添字 } M_{\mathrm{col}}+1-\mu \text{ へ適用}) \\
&= \check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\,\varepsilon
   \quad (\because (-1)^2 = 1) \\
&= \check{n}_\mu\,\varepsilon
   \quad (\because \text{def\_check\_number\_operator})
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M_{\mathrm{col}}}
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
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\text{ の }\varepsilon^2=I) \\
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
        ref("epsilon_square_and_eigenvalues"),
        " の ",
        math(String.raw`\varepsilon^2=I`),
        " と上の式変形、および ",
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
        math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_\mu^\dagger = I - \check{n}_\mu`),
        " を ",
        math(String.raw`q`),
        " に施すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_{M_{\mathrm{col}}+1-\mu}\left(\check\psi_\mu^\dagger q\right)
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
&= \check\psi_\mu^\dagger\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_\mu^\dagger\right)
   \quad (\because \text{def\_check\_number\_operator と結合法則}) \\
&= \check\psi_\mu^\dagger\left(I - \check{n}_\mu\right)
   \quad (\because \text{check\_number\_operator\_idempotent (2)}) \\
&= \check\psi_\mu^\dagger
   - \check\psi_\mu^\dagger\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}
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
   \quad (\because \text{check\_number\_operators\_commute (1) を } M_{\mathrm{col}}-1 \text{ 箇所へ同時適用}) \\
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
        math(String.raw`M_{\mathrm{col}} - |\epsilon|`),
        " 個の添字 ",
        math(String.raw`\mu`),
        " を 1 つずつ ",
        math(String.raw`1`),
        " に取り替えていくと ",
        math(String.raw`(1,\dots,1)`),
        " に至る。(2) を各段で使うと符号が 1 回ずつ反転するので",
      ]),
      displayMath(
        String.raw`\eta_{(1,\dots,1)} = (-1)^{M_{\mathrm{col}}-|\epsilon|}\,\eta_\epsilon`,
      ),
      paragraph([
        "両辺に ",
        math(String.raw`(-1)^{M_{\mathrm{col}}-|\epsilon|}`),
        " を掛け、",
        math(String.raw`\left((-1)^{M_{\mathrm{col}}-|\epsilon|}\right)^2 = 1`),
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
\left(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(I - 2\check{n}_\mu\right)\right)\check{Q}_\epsilon
&= \left(\prod_{\mu=1}^{M_{\mathrm{col}}}\left(1 - 2\epsilon_\mu\right)\right)\check{Q}_\epsilon
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
&= \eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}-|\epsilon|}\check{Q}_\epsilon
   \quad (\because \text{(1) と (3)}) \\
&= \eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}}(-1)^{|\epsilon|}\check{Q}_\epsilon
   \quad (\because (-1)^{-|\epsilon|}=(-1)^{|\epsilon|})
\end{aligned}`,
      ),
      paragraph([
        "したがって 2 つの行列 ",
        math(String.raw`\varepsilon`),
        " と ",
        math(String.raw`\eta_{(1,\dots,1)}(-1)^{M_{\mathrm{col}}}\prod_\mu(I-2\check{n}_\mu)`),
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
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
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
        ref("def_gamma_theta_tilde_mu"),
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
        ref("epsilon_commutes_with_transfer_matrices"),
        " の Step 1 より、各 ",
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
        math(String.raw`B := \left(V_1^{(+)}\right)^{1/2} = \exp\!\left(\tfrac12 iK_1H_1^{(+)}\right)`),
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
   \quad (\because \text{def\_V\_plus}) \\
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
