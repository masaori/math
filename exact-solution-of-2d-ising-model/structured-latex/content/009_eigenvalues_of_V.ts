import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/009_eigenvalues_of_V.ts";

export default defineBlocks([
  {
    id: "heading_eigenvalues_of_V",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`\text{定数 } c \text{ の決定と } V \text{ の固有値}` },
    labels: [],
  },

  {
    id: "eigenvalues_of_V_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的" },
    labels: [],
    statement: [
      paragraph([
        ref("V_eq_Vprime"),
        " により、ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " が存在して ",
        math(String.raw`V = c V'`),
        " が成り立つ。しかし ",
        math(String.raw`c`),
        " の値そのものは決まっていない。この章では ",
        math(String.raw`c`),
        " を決定し、あわせて ",
        math(String.raw`V`),
        " の固有値をすべて求める。結論は",
      ]),
      displayMath(
        String.raw`c = (2\sinh 2K_2)^{M/2}, \qquad
V = (2\sinh 2K_2)^{M/2}\,V'`,
      ),
      paragraph([
        "であり、",
        math(String.raw`V`),
        " の固有値は ",
        math(String.raw`\epsilon = (\epsilon_\mu)`),
        "（各 ",
        math(String.raw`\epsilon_\mu \in \{0,1\}`),
        "）でパラメトライズされた",
      ]),
      displayMath(
        String.raw`\Lambda_\epsilon = (2\sinh 2K_2)^{M/2}
\exp\!\left(\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\left(\epsilon_\mu - \tfrac{1}{2}\right)\right)`,
      ),
      paragraph([
        "である。ここで ",
        math(String.raw`\mathcal{I}`),
        " は ",
        ref("def_Vprime"),
        " の和に現れる添字の集合である。",
      ]),
      paragraph([
        "この章で用いる道具は、複素数を成分とする行列の積・和・スカラー倍、行列の指数関数（",
        ref("def_exp"),
        "）、および実数の ",
        math(String.raw`\cosh, \sinh, \mathrm{arccosh}`),
        " だけである。行列式は使わない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "c の決定に行列式（Leibniz 定義と乗法性 det(AB)=det A det B）を使う経路も存在するが、その経路は置換と符号の一般論を新たに本文へ持ち込むことになるため採らなかった。代わりに tr(V)/tr(V^{-1}) = c^2 と符号反転共役を使う経路を採った。採らなかった経路の記録は docs/tasks/free-energy-roadmap/task-dependency-graph.md にある。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_001_definition_trace",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\text{トレース } \mathrm{tr}` },
    labels: ["def_trace"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`A = (A_{k l})_{1 \leq k, l \leq n} \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対して",
      ]),
      displayMath(String.raw`\mathrm{tr}(A) := \sum_{k=1}^{n} A_{k k} \in \mathbb{C}`),
      paragraph([
        "と定める（対角成分の有限和なので、収束の議論を要しない）。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_002_claim_trace_properties",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { text: "トレースの基本性質" },
    labels: ["trace_basic_properties"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        " について、",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \mathrm{tr}(\alpha A + \beta B) = \alpha\,\mathrm{tr}(A) + \beta\,\mathrm{tr}(B)`), "（線型性）"],
        [math(String.raw`\text{(2)}\quad \mathrm{tr}(AB) = \mathrm{tr}(BA)`), "（巡回性）"],
        [math(String.raw`\text{(3)}\quad \mathrm{tr}(I_n) = n`)],
        [
          math(String.raw`\text{(4)}\quad P \in \mathrm{Mat}(n,\mathbb{C}) \text{ が可逆なら } \mathrm{tr}(P A P^{-1}) = \mathrm{tr}(A)`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) 行列の和とスカラー倍は成分ごとに定義されるので ",
        math(String.raw`(\alpha A + \beta B)_{kk} = \alpha A_{kk} + \beta B_{kk}`),
        " であり、有限和の線型性から従う。",
      ]),
      paragraph([
        "(2) 行列の積の定義 ",
        math(String.raw`(AB)_{kl} = \sum_{j=1}^{n} A_{kj}B_{jl}`),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(AB)
&= \sum_{k=1}^{n} (AB)_{kk} \quad (\because \text{トレースの定義}) \\
&= \sum_{k=1}^{n}\sum_{j=1}^{n} A_{kj}B_{jk} \quad (\because \text{積の定義}) \\
&= \sum_{j=1}^{n}\sum_{k=1}^{n} B_{jk}A_{kj}
   \quad (\because \text{有限和の順序交換と } \mathbb{C} \text{ の積の可換性}) \\
&= \sum_{j=1}^{n} (BA)_{jj} \quad (\because \text{積の定義}) \\
&= \mathrm{tr}(BA) \quad (\because \text{トレースの定義})
\end{aligned}`,
      ),
      paragraph([
        "有限個の項の和なので、順序交換は ",
        math(String.raw`\mathbb{C}`),
        " の加法の結合法則・交換法則からの有限帰納法で正当化される（収束の議論を要しない）。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`(I_n)_{kk} = 1`),
        " が ",
        math(String.raw`n`),
        " 個あるので ",
        math(String.raw`\mathrm{tr}(I_n) = n`),
        "。",
      ]),
      paragraph([
        "(4) (2) を ",
        math(String.raw`A \to PA`),
        "、",
        math(String.raw`B \to P^{-1}`),
        " に適用して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(PAP^{-1})
&= \mathrm{tr}\bigl((PA)P^{-1}\bigr) \quad (\because \text{行列の積の結合法則}) \\
&= \mathrm{tr}\bigl(P^{-1}(PA)\bigr) \quad (\because \text{(2) 巡回性}) \\
&= \mathrm{tr}\bigl((P^{-1}P)A\bigr) \quad (\because \text{行列の積の結合法則}) \\
&= \mathrm{tr}(I_n A) \quad (\because \text{逆行列の定義 } P^{-1}P = I_n) \\
&= \mathrm{tr}(A) \quad (\because \text{単位行列との積})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "本文はこれまでトレースを定義せずに使っていなかった（008 章までに tr は現れない）。本章で初めて必要になるため、定義と必要な性質だけをここで書き下した。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_003_claim_trace_of_idempotent",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { text: "冪等行列のトレースは像の次元" },
    labels: ["trace_of_idempotent"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`Q \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`Q^2 = Q`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`\mathbb{C}^n = \mathrm{im}\,Q \oplus \ker Q, \qquad
\mathrm{tr}(Q) = \dim_{\mathbb{C}} \mathrm{im}\,Q`),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`\mathrm{im}\,Q := \{Qx \mid x \in \mathbb{C}^n\}`),
        "、",
        math(String.raw`\ker Q := \{x \in \mathbb{C}^n \mid Qx = 0\}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（直和分解）。任意の ",
        math(String.raw`x \in \mathbb{C}^n`),
        " について ",
        math(String.raw`x = Qx + (x - Qx)`),
        " と書ける。",
        math(String.raw`Qx \in \mathrm{im}\,Q`),
        " であり、",
        math(String.raw`Q(x - Qx) = Qx - Q^2x = Qx - Qx = 0`),
        " より ",
        math(String.raw`x - Qx \in \ker Q`),
        "。よって ",
        math(String.raw`\mathbb{C}^n = \mathrm{im}\,Q + \ker Q`),
        "。",
      ]),
      paragraph([
        "また ",
        math(String.raw`y \in \mathrm{im}\,Q \cap \ker Q`),
        " とすると、",
        math(String.raw`y = Qx`),
        " なる ",
        math(String.raw`x`),
        " が取れて ",
        math(String.raw`y = Qx = Q^2 x = Q(Qx) = Qy = 0`),
        "。よって交わりは ",
        math(String.raw`\{0\}`),
        " であり、和は直和である。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`Q`),
        " の適合基底での形）。",
        math(String.raw`r := \dim_{\mathbb{C}}\mathrm{im}\,Q`),
        " とおき、",
        math(String.raw`\mathrm{im}\,Q`),
        " の基底 ",
        math(String.raw`v_1,\dots,v_r`),
        " と ",
        math(String.raw`\ker Q`),
        " の基底 ",
        math(String.raw`v_{r+1},\dots,v_n`),
        " を取る（Step 1 の直和分解より ",
        math(String.raw`v_1,\dots,v_n`),
        " は ",
        math(String.raw`\mathbb{C}^n`),
        " の基底）。",
        math(String.raw`j \leq r`),
        " のとき ",
        math(String.raw`v_j = Qx_j`),
        " と書けて ",
        math(String.raw`Qv_j = Q^2x_j = Qx_j = v_j`),
        "、",
        math(String.raw`j > r`),
        " のとき ",
        math(String.raw`Qv_j = 0`),
        "。よってこの基底に関する ",
        math(String.raw`Q`),
        " の表現行列 ",
        math(String.raw`D`),
        " は対角行列で、対角成分は ",
        math(String.raw`1`),
        " が ",
        math(String.raw`r`),
        " 個、",
        math(String.raw`0`),
        " が ",
        math(String.raw`n - r`),
        " 個である。",
      ]),
      paragraph([
        "Step 3。基底変換行列を ",
        math(String.raw`P`),
        "（可逆）とすると ",
        math(String.raw`D = P^{-1} Q P`),
        " であり、",
        ref("trace_basic_properties"),
        " (4) より",
      ]),
      displayMath(String.raw`\mathrm{tr}(Q) = \mathrm{tr}(P^{-1}QP) = \mathrm{tr}(D) = r`),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_004_definition_number_operator",
    kind: "definition",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`\text{フェルミオン数演算子 } n_\mu` },
    labels: ["def_number_operator"],
    statement: [
      paragraph([
        ref("def_fermi")," および ",
        ref("def_Vprime"),
        " と同じく",
      ]),
      displayMath(
        String.raw`\mathcal{M} := \{-M,\dots,-1,1,\dots,M\}, \qquad
\mathcal{I} := \{\mu \in \{1,\dots,M\} \mid \gamma_2(\theta_\mu) \neq 0\},
\qquad m := |\mathcal{I}|`,
      ),
      paragraph([
        "とおく（",
        math(String.raw`\mathcal{M}`),
        " は ",
        ref("def_fermi"),
        " で ",
        math(String.raw`\psi_\mu, \psi_\mu^\dagger`),
        " の添字が走る集合、",
        math(String.raw`\mathcal{I}`),
        " は ",
        ref("def_Vprime"),
        " の和に現れる添字の集合である）。定義から ",
        math(String.raw`\mathcal{I} \subseteq \{1,\dots,M\} \subset \mathcal{M}`),
        " であり、",
        math(String.raw`\mu \in \mathcal{I}`),
        " なら ",
        math(String.raw`-\mu \in \{-M,\dots,-1\} \subset \mathcal{M}`),
        " でもある。",
      ]),
      paragraph([
        math(String.raw`\mu \in \mathcal{I}`),
        " について、",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(-\theta_\mu) \neq 0`),
        " すなわち ",
        math(String.raw`\gamma_2(\theta_{-\mu}) \neq 0`),
        " でもあるから、",
        ref("def_fermi"),
        " により ",
        math(String.raw`\psi_\mu^\dagger`),
        " と ",
        math(String.raw`\psi_{-\mu}`),
        " がともに定義される。そこで",
      ]),
      displayMath(
        String.raw`n_\mu := \psi_\mu^\dagger \psi_{-\mu} \in \mathrm{Mat}(2^M,\mathbb{C})
\qquad (\mu \in \mathcal{I})`,
      ),
      paragraph([
        "と定める。",
        ref("gamma_2_theta_is_0"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " となる ",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " は臨界条件下の ",
        math(String.raw`\mu = M`),
        " に限られるので、臨界点でなければ ",
        math(String.raw`\mathcal{I} = \{1,\dots,M\}`),
        "（",
        math(String.raw`m = M`),
        "）、臨界点では ",
        math(String.raw`\mathcal{I} = \{1,\dots,M-1\}`),
        "（",
        math(String.raw`m = M-1`),
        "）である。",
      ]),
      paragraph([
        "なお ",
        ref("def_fermi"),
        " の ",
        math(String.raw`\psi_\mu, \psi_\mu^\dagger`),
        " の係数に現れる平方根 ",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " は ",
        ref("def_sqrt_cc"),
        " で定めた**単一値の写像** ",
        math(String.raw`\sqrt{\cdot}:\mathbb{C}\to\mathbb{C}`),
        " の値であり、添字 ",
        math(String.raw`\mu`),
        " ごとに ",
        math(String.raw`\pm`),
        " を選ぶ自由度は無い。この一意性は ",
        ref("anticommutator_of_psi"),
        " の反交換関係の成立そのものに効いており（同 Claim の Step 0）、以下で ",
        ref("anticommutator_of_psi"),
        " を添字対 ",
        math(String.raw`(\mu,\mu)`),
        "、",
        math(String.raw`(\mu,-\mu)`),
        "、",
        math(String.raw`(\mu,-\nu)`),
        "、",
        math(String.raw`(-\mu,\nu)`),
        " へ適用するときも、この単一の値をそのまま使う。",
      ]),
      paragraph([
        "この記号のもとで ",
        ref("def_Vprime"),
        " の ",
        math(String.raw`V'`),
        " は",
      ]),
      displayMath(
        String.raw`V' = \exp(X), \qquad
X := \sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\left(n_\mu - \tfrac{1}{2}
I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)`,
      ),
      paragraph(["と書ける。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_005_claim_number_operator_idempotent",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { tex: String.raw`n_\mu^2 = n_\mu` },
    labels: ["number_operator_idempotent"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{I}`), " について、"]),
      list([
        [math(String.raw`\text{(1)}\quad (\psi_\mu^\dagger)^2 = 0, \qquad (\psi_{-\mu})^2 = 0`)],
        [
          math(String.raw`\text{(2)}\quad \psi_{-\mu}\psi_\mu^\dagger = I_{\mathrm{Mat}(2^M,\mathbb{C})} - n_\mu`),
        ],
        [math(String.raw`\text{(3)}\quad n_\mu^2 = n_\mu`)],
      ]),
      paragraph([
        "以下、",
        math(String.raw`2^M`),
        " 次の単位行列 ",
        math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " を単に ",
        math(String.raw`I`),
        " と書く。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("anticommutator_of_psi"),
        " の第 1 式 ",
        math(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+ = 0`),
        " において ",
        math(String.raw`\nu = \mu`),
        " と取ると、反交換子の定義 ",
        math(String.raw`[X,Y]_+ = XY + YX`),
        " より",
      ]),
      displayMath(
        String.raw`0 = [\psi_\mu^\dagger, \psi_\mu^\dagger]_+
= \psi_\mu^\dagger\psi_\mu^\dagger + \psi_\mu^\dagger\psi_\mu^\dagger
= 2(\psi_\mu^\dagger)^2`,
      ),
      paragraph([
        math(String.raw`2 \neq 0`),
        " なので ",
        math(String.raw`(\psi_\mu^\dagger)^2 = 0`),
        "。同じく第 3 式 ",
        math(String.raw`[\psi_\mu, \psi_\nu]_+ = 0`),
        " を ",
        math(String.raw`\mu = \nu = -\mu`),
        " すなわち添字 ",
        math(String.raw`-\mu`),
        " について適用して ",
        math(String.raw`(\psi_{-\mu})^2 = 0`),
        "（",
        ref("def_number_operator"),
        " より ",
        math(String.raw`\mu \in \mathcal{I}`),
        " なので ",
        math(String.raw`-\mu \in \mathcal{M} = \{-M,\dots,-1,1,\dots,M\}`),
        " かつ ",
        math(String.raw`\gamma_2(\theta_{-\mu}) \neq 0`),
        " であり、",
        ref("anticommutator_of_psi"),
        " の仮定「",
        math(String.raw`\gamma_2(\theta_\mu)\neq 0`),
        " かつ ",
        math(String.raw`\gamma_2(\theta_\nu)\neq 0`),
        " なる ",
        math(String.raw`\mu,\nu \in \mathcal{M}`),
        "」を満たす）。",
      ]),
      paragraph([
        "(2) ",
        ref("anticommutator_of_psi"),
        " の第 2 式 ",
        math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I`),
        " において ",
        math(String.raw`\nu = -\mu`),
        " と取る。",
        math(String.raw`\mu + (-\mu) = 0 \equiv 0 \pmod M`),
        " なので ",
        ref("def_delta_M"),
        " より ",
        math(String.raw`\delta^M_{\mu+(-\mu),0} = 1`),
        " であり、",
      ]),
      displayMath(
        String.raw`\psi_\mu^\dagger\psi_{-\mu} + \psi_{-\mu}\psi_\mu^\dagger = I`,
      ),
      paragraph([
        "左辺第 1 項は ",
        ref("def_number_operator"),
        " より ",
        math(String.raw`n_\mu`),
        " だから、移項して ",
        math(String.raw`\psi_{-\mu}\psi_\mu^\dagger = I - n_\mu`),
        "。",
      ]),
      paragraph(["(3) (1)(2) を使って"]),
      displayMath(
        String.raw`\begin{aligned}
n_\mu^2
&= (\psi_\mu^\dagger\psi_{-\mu})(\psi_\mu^\dagger\psi_{-\mu}) \\
&= \psi_\mu^\dagger\left(\psi_{-\mu}\psi_\mu^\dagger\right)\psi_{-\mu}
   \quad (\because \text{行列の積の結合法則}) \\
&= \psi_\mu^\dagger\left(I - n_\mu\right)\psi_{-\mu}
   \quad (\because \text{(2)}) \\
&= \psi_\mu^\dagger\psi_{-\mu} - \psi_\mu^\dagger n_\mu \psi_{-\mu}
   \quad (\because \text{行列の積の分配法則}) \\
&= n_\mu - \psi_\mu^\dagger\left(\psi_\mu^\dagger\psi_{-\mu}\right)\psi_{-\mu}
   \quad (\because n_\mu = \psi_\mu^\dagger\psi_{-\mu}) \\
&= n_\mu - (\psi_\mu^\dagger)^2\,(\psi_{-\mu})^2
   \quad (\because \text{結合法則}) \\
&= n_\mu - 0 \cdot 0
   \quad (\because \text{(1)}) \\
&= n_\mu
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_006_claim_number_operators_commute",
    kind: "claim",
    origin: { path: SRC, ordinal: 8 },
    title: { tex: String.raw`n_\mu n_\nu = n_\nu n_\mu` },
    labels: ["number_operators_commute"],
    statement: [
      paragraph([
        math(String.raw`\mu, \nu \in \mathcal{I}`),
        " が ",
        math(String.raw`\mu \neq \nu`),
        " を満たすとき、",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \psi_\mu^\dagger n_\nu = n_\nu \psi_\mu^\dagger, \qquad
\psi_{-\mu} n_\nu = n_\nu \psi_{-\mu}`),
        ],
        [math(String.raw`\text{(2)}\quad n_\mu n_\nu = n_\nu n_\mu`)],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（4 つの反交換関係）。",
        math(String.raw`\mu, \nu \in \mathcal{I} \subseteq \{1,\dots,M\}`),
        " かつ ",
        math(String.raw`\mu \neq \nu`),
        " なので ",
        math(String.raw`1 \leq |\mu - \nu| \leq M-1`),
        " であり、とくに ",
        math(String.raw`\mu - \nu \not\equiv 0 \pmod M`),
        "。よって ",
        ref("def_delta_M"),
        " より ",
        math(String.raw`\delta^M_{\mu-\nu,0} = \delta^M_{-\mu+\nu,0} = 0`),
        " である。",
        ref("anticommutator_of_psi"),
        " を ",
        math(String.raw`(\mu,\nu)`),
        "、",
        math(String.raw`(\mu,-\nu)`),
        "、",
        math(String.raw`(-\mu,\nu)`),
        "、",
        math(String.raw`(-\mu,-\nu)`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
{[\psi_\mu^\dagger, \psi_\nu^\dagger]_+} &= 0, &
{[\psi_\mu^\dagger, \psi_{-\nu}]_+} &= \delta^M_{\mu-\nu,0}\,I = 0, \\
{[\psi_{-\mu}, \psi_\nu^\dagger]_+} &= \delta^M_{-\mu+\nu,0}\,I = 0, &
{[\psi_{-\mu}, \psi_{-\nu}]_+} &= 0
\end{aligned}`,
      ),
      paragraph([
        "（第 3 式は ",
        ref("anticommutator_of_psi"),
        " の第 2 式を添字 ",
        math(String.raw`(\nu, -\mu)`),
        " に適用し、反交換子が引数の順序に依らないこと ",
        math(String.raw`[X,Y]_+ = XY + YX = [Y,X]_+`),
        " を使った。）すなわち、",
        math(String.raw`A \in \{\psi_\mu^\dagger, \psi_{-\mu}\}`),
        " と ",
        math(String.raw`B \in \{\psi_\nu^\dagger, \psi_{-\nu}\}`),
        " のどの組み合わせでも ",
        math(String.raw`AB = -BA`),
        " が成り立つ。",
      ]),
      paragraph([
        "Step 2（(1) の証明）。",
        math(String.raw`A \in \{\psi_\mu^\dagger, \psi_{-\mu}\}`),
        " を取ると、Step 1 を 2 回使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A\,n_\nu
&= A\,\psi_\nu^\dagger \psi_{-\nu} \\
&= (-\psi_\nu^\dagger A)\,\psi_{-\nu}
   \quad (\because A\psi_\nu^\dagger = -\psi_\nu^\dagger A) \\
&= -\psi_\nu^\dagger\,(A \psi_{-\nu})
   \quad (\because \text{結合法則}) \\
&= -\psi_\nu^\dagger\,(-\psi_{-\nu} A)
   \quad (\because A\psi_{-\nu} = -\psi_{-\nu}A) \\
&= \psi_\nu^\dagger \psi_{-\nu} A \\
&= n_\nu A
\end{aligned}`,
      ),
      paragraph([
        "符号は ",
        math(String.raw`(-1)^2 = 1`),
        " となって消える。",
        math(String.raw`A = \psi_\mu^\dagger`),
        " と ",
        math(String.raw`A = \psi_{-\mu}`),
        " の両方でこれが成り立つ。",
      ]),
      paragraph(["Step 3（(2) の証明）。(1) を 2 回使って"]),
      displayMath(
        String.raw`n_\mu n_\nu
= \psi_\mu^\dagger\left(\psi_{-\mu} n_\nu\right)
= \psi_\mu^\dagger\left(n_\nu \psi_{-\mu}\right)
= \left(\psi_\mu^\dagger n_\nu\right)\psi_{-\mu}
= \left(n_\nu \psi_\mu^\dagger\right)\psi_{-\mu}
= n_\nu\,\psi_\mu^\dagger\psi_{-\mu}
= n_\nu n_\mu`,
      ),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_007_claim_trace_of_number_operator_product",
    kind: "claim",
    origin: { path: SRC, ordinal: 9 },
    title: { tex: String.raw`\mathrm{tr}\bigl(R_{\mu_1}^{(e_1)}\cdots R_{\mu_k}^{(e_k)}\bigr) = 2^{M-k}` },
    labels: ["trace_of_number_operator_product"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathcal{I}`),
        " と ",
        math(String.raw`e \in \{0,1\}`),
        " に対して",
      ]),
      displayMath(
        String.raw`R_\mu^{(1)} := n_\mu, \qquad R_\mu^{(0)} := I - n_\mu
\qquad \left(I = I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)`,
      ),
      paragraph([
        "と書く。",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        "、相異なる ",
        math(String.raw`\mu_1, \dots, \mu_k \in \mathcal{I}`),
        "、および ",
        math(String.raw`e_1,\dots,e_k \in \{0,1\}`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(R_{\mu_1}^{(e_1)} R_{\mu_2}^{(e_2)}\cdots R_{\mu_k}^{(e_k)}\right)
= 2^{M-k}`,
      ),
      paragraph([
        "（",
        math(String.raw`k = 0`),
        " のときは空の積を ",
        math(String.raw`I`),
        " と読み、",
        math(String.raw`\mathrm{tr}(I) = 2^M`),
        " である。）とくに ",
        math(String.raw`\mathrm{tr}(n_\mu) = \mathrm{tr}(I - n_\mu) = 2^{M-1}`),
        " であり、値は指数 ",
        math(String.raw`e_1,\dots,e_k`),
        " の選び方に依らず、因子の個数 ",
        math(String.raw`k`),
        " だけで決まる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n_\mu \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " であり ",
        math(String.raw`I = I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " は ",
        math(String.raw`2^M`),
        " 次の単位行列なので、",
        ref("trace_basic_properties"),
        " (3) より ",
        math(String.raw`\mathrm{tr}(I) = 2^M`),
        " である。",
        math(String.raw`k`),
        " に関する帰納法で示す。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`k = 0`),
        "）：",
        math(String.raw`\mathrm{tr}(I) = 2^M = 2^{M-0}`),
        " で成立。",
      ]),
      paragraph([
        "帰納段階：",
        math(String.raw`k \geq 1`),
        " とし、相異なる ",
        math(String.raw`k-1`),
        " 個の添字については主張が成り立つと仮定する。相異なる ",
        math(String.raw`\mu_1,\dots,\mu_k \in \mathcal{I}`),
        " を取り、",
      ]),
      displayMath(String.raw`P := n_{\mu_2} n_{\mu_3}\cdots n_{\mu_k}`),
      paragraph([
        "とおく。",
        math(String.raw`\mu_1 \neq \mu_j`),
        "（",
        math(String.raw`j = 2,\dots,k`),
        "）なので ",
        ref("number_operators_commute"),
        " (1) より ",
        math(String.raw`\psi_{\mu_1}^\dagger`),
        " と ",
        math(String.raw`\psi_{-\mu_1}`),
        " はどの ",
        math(String.raw`n_{\mu_j}`),
        " とも可換であり、したがって積 ",
        math(String.raw`P`),
        " とも可換である。同じく ",
        ref("number_operators_commute"),
        " (2) より ",
        math(String.raw`n_{\mu_1}`),
        " と ",
        math(String.raw`P`),
        " は可換である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(n_{\mu_1} P\right)
&= \mathrm{tr}\!\left(\psi_{\mu_1}^\dagger \psi_{-\mu_1} P\right)
   \quad (\because \text{定義}) \\
&= \mathrm{tr}\!\left(\psi_{-\mu_1} P\, \psi_{\mu_1}^\dagger\right)
   \quad (\because \text{巡回性を } A = \psi_{\mu_1}^\dagger,\ B = \psi_{-\mu_1}P \text{ に適用}) \\
&= \mathrm{tr}\!\left(P\, \psi_{-\mu_1}\psi_{\mu_1}^\dagger\right)
   \quad (\because \psi_{-\mu_1} \text{ と } P \text{ が可換}) \\
&= \mathrm{tr}\!\left(P\,(I - n_{\mu_1})\right)
   \quad (\because \text{数演算子の冪等性 (2)}) \\
&= \mathrm{tr}(P) - \mathrm{tr}(P\,n_{\mu_1})
   \quad (\because \text{トレースの線型性}) \\
&= \mathrm{tr}(P) - \mathrm{tr}(n_{\mu_1} P)
   \quad (\because n_{\mu_1} \text{ と } P \text{ が可換})
\end{aligned}`,
      ),
      paragraph([
        "移項して ",
        math(String.raw`2\,\mathrm{tr}(n_{\mu_1}P) = \mathrm{tr}(P)`),
        "。帰納法の仮定から ",
        math(String.raw`\mathrm{tr}(P) = 2^{M-(k-1)}`),
        " なので",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(n_{\mu_1}\cdots n_{\mu_k}\right)
= \frac{1}{2}\,\mathrm{tr}(P) = \frac{1}{2}\cdot 2^{M-k+1} = 2^{M-k}`,
      ),
      paragraph([
        "（トレースが積の順序に依らないこと ",
        ref("number_operators_commute"),
        " (2) より、添字の並べ替えで値は変わらないので、一般の相異なる添字列についても同じ結論を得る。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_008_claim_joint_eigenspace_decomposition",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { text: "数演算子の同時固有空間分解" },
    labels: ["joint_eigenspace_decomposition"],
    statement: [
      paragraph([
        math(String.raw`\epsilon = (\epsilon_\mu)_{\mu \in \mathcal{I}} \in \{0,1\}^{\mathcal{I}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`Q_\epsilon := \prod_{\mu \in \mathcal{I}}
\Bigl(\epsilon_\mu\, n_\mu + (1 - \epsilon_\mu)\,(I - n_\mu)\Bigr)
\in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "と定める（因子は ",
        ref("number_operators_commute"),
        " により互いに可換なので、積の順序は問わない）。このとき、",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad Q_\epsilon Q_{\epsilon'} = 0 \quad (\epsilon \neq \epsilon'), \qquad Q_\epsilon^2 = Q_\epsilon`)],
        [math(String.raw`\text{(2)}\quad \sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} Q_\epsilon = I`)],
        [math(String.raw`\text{(3)}\quad n_\nu Q_\epsilon = \epsilon_\nu Q_\epsilon \quad (\nu \in \mathcal{I})`)],
        [math(String.raw`\text{(4)}\quad \mathrm{tr}(Q_\epsilon) = 2^{M-m}, \qquad \dim_{\mathbb{C}} \mathrm{im}\,Q_\epsilon = 2^{M-m}`)],
        [
          math(String.raw`\text{(5)}\quad \mathbb{C}^{2^M} = \bigoplus_{\epsilon \in \{0,1\}^{\mathcal{I}}} \mathrm{im}\,Q_\epsilon`),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`m = M`),
        "（臨界点でない場合）には各 ",
        math(String.raw`\mathrm{im}\,Q_\epsilon`),
        " は 1 次元である。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\mu \in \mathcal{I}`),
        " と ",
        math(String.raw`e \in \{0,1\}`),
        " に対して ",
        math(String.raw`R_\mu^{(1)} := n_\mu`),
        "、",
        math(String.raw`R_\mu^{(0)} := I - n_\mu`),
        " と書く。",
        math(String.raw`Q_\epsilon = \prod_{\mu \in \mathcal{I}} R_\mu^{(\epsilon_\mu)}`),
        " である。",
      ]),
      paragraph([
        "Step 0（1 つの添字についての関係）。",
        ref("number_operator_idempotent"),
        " (3) の ",
        math(String.raw`n_\mu^2 = n_\mu`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(1)}R_\mu^{(1)} &= n_\mu^2 = n_\mu = R_\mu^{(1)}, \\
R_\mu^{(0)}R_\mu^{(0)} &= (I-n_\mu)^2 = I - 2n_\mu + n_\mu^2 = I - n_\mu = R_\mu^{(0)}, \\
R_\mu^{(1)}R_\mu^{(0)} &= n_\mu(I - n_\mu) = n_\mu - n_\mu^2 = 0
= R_\mu^{(0)}R_\mu^{(1)}, \\
R_\mu^{(1)} + R_\mu^{(0)} &= n_\mu + (I - n_\mu) = I
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\mu \neq \nu`),
        " のとき ",
        ref("number_operators_commute"),
        " (2) より ",
        math(String.raw`n_\mu n_\nu = n_\nu n_\mu`),
        " であり、",
        math(String.raw`I`),
        " は任意の行列と可換だから、",
        math(String.raw`R_\mu^{(e)}`),
        " と ",
        math(String.raw`R_\nu^{(e')}`),
        " も可換である。",
      ]),
      paragraph([
        "Step 1（(1) の証明）。",
        math(String.raw`\epsilon \neq \epsilon'`),
        " なら、ある ",
        math(String.raw`\nu \in \mathcal{I}`),
        " で ",
        math(String.raw`\epsilon_\nu \neq \epsilon'_\nu`),
        "。因子はすべて可換なので、",
        math(String.raw`Q_\epsilon Q_{\epsilon'}`),
        " の中で添字 ",
        math(String.raw`\nu`),
        " の 2 因子を隣接させられて",
      ]),
      displayMath(
        String.raw`Q_\epsilon Q_{\epsilon'}
= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon'_\mu)}\right)
  R_\nu^{(\epsilon_\nu)}R_\nu^{(\epsilon'_\nu)}
= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon'_\mu)}\right)\cdot 0
= 0`,
      ),
      paragraph([
        math(String.raw`\epsilon = \epsilon'`),
        " のときは各因子が Step 0 より冪等なので ",
        math(String.raw`Q_\epsilon^2 = Q_\epsilon`),
        "。",
      ]),
      paragraph([
        "Step 2（(2) の証明）。Step 0 の ",
        math(String.raw`R_\mu^{(1)} + R_\mu^{(0)} = I`),
        " を各因子に代入し、可換な有限個の因子の積を分配法則で展開すると",
      ]),
      displayMath(
        String.raw`I = \prod_{\mu \in \mathcal{I}}\left(R_\mu^{(1)} + R_\mu^{(0)}\right)
= \sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} \prod_{\mu \in \mathcal{I}} R_\mu^{(\epsilon_\mu)}
= \sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} Q_\epsilon`,
      ),
      paragraph([
        "（展開して現れる項は、各 ",
        math(String.raw`\mu`),
        " について ",
        math(String.raw`R_\mu^{(1)}`),
        " と ",
        math(String.raw`R_\mu^{(0)}`),
        " のどちらを選ぶかの全ての選び方に 1 対 1 に対応し、その選び方の全体が ",
        math(String.raw`\{0,1\}^{\mathcal{I}}`),
        " である。）",
      ]),
      paragraph([
        "Step 3（(3) の証明）。",
        math(String.raw`\nu \in \mathcal{I}`),
        " を固定する。因子はすべて可換なので",
      ]),
      displayMath(
        String.raw`n_\nu Q_\epsilon
= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}\right) n_\nu R_\nu^{(\epsilon_\nu)}`,
      ),
      paragraph([
        math(String.raw`\epsilon_\nu = 1`),
        " なら ",
        math(String.raw`n_\nu R_\nu^{(1)} = n_\nu n_\nu = n_\nu = R_\nu^{(1)} = \epsilon_\nu R_\nu^{(\epsilon_\nu)}`),
        "、",
        math(String.raw`\epsilon_\nu = 0`),
        " なら ",
        math(String.raw`n_\nu R_\nu^{(0)} = n_\nu(I - n_\nu) = 0 = \epsilon_\nu R_\nu^{(\epsilon_\nu)}`),
        "。いずれの場合も ",
        math(String.raw`n_\nu Q_\epsilon = \epsilon_\nu Q_\epsilon`),
        "。",
      ]),
      paragraph([
        "Step 4（(4) の証明）。",
        math(String.raw`T := \{\mu \in \mathcal{I} \mid \epsilon_\mu = 1\}`),
        " とおくと ",
        math(String.raw`Q_\epsilon = \left(\prod_{\mu \in T} n_\mu\right)\prod_{\mu \in \mathcal{I}\setminus T}(I - n_\mu)`),
        "。第 2 の積を分配法則で展開すると",
      ]),
      displayMath(
        String.raw`\prod_{\mu \in \mathcal{I}\setminus T}(I - n_\mu)
= \sum_{S \subseteq \mathcal{I}\setminus T} (-1)^{|S|} \prod_{\mu \in S} n_\mu`,
      ),
      paragraph([
        "であるから、トレースの線型性（",
        ref("trace_basic_properties"),
        " (1)）と ",
        ref("trace_of_number_operator_product"),
        "（",
        math(String.raw`T`),
        " と ",
        math(String.raw`S`),
        " は交わらないので ",
        math(String.raw`T \cup S`),
        " の元は相異なる ",
        math(String.raw`|T| + |S|`),
        " 個）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(Q_\epsilon)
&= \sum_{S \subseteq \mathcal{I}\setminus T} (-1)^{|S|}\,
   \mathrm{tr}\!\left(\prod_{\mu \in T \cup S} n_\mu\right) \\
&= \sum_{S \subseteq \mathcal{I}\setminus T} (-1)^{|S|}\, 2^{M - |T| - |S|} \\
&= 2^{M-|T|}\sum_{j=0}^{m-|T|}\binom{m-|T|}{j}(-1)^{j}\,2^{-j}
   \quad (\because |\mathcal{I}\setminus T| = m - |T| \text{ で、大きさ } j \text{ の部分集合は } \tbinom{m-|T|}{j} \text{ 個}) \\
&= 2^{M-|T|}\left(1 - \tfrac{1}{2}\right)^{m-|T|}
   \quad (\because \text{二項定理}) \\
&= 2^{M-|T|}\cdot 2^{-(m-|T|)} \\
&= 2^{M-m}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Q_\epsilon`),
        " は Step 1 より冪等なので、",
        ref("trace_of_idempotent"),
        " より ",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{im}\,Q_\epsilon = \mathrm{tr}(Q_\epsilon) = 2^{M-m}`),
        "。",
      ]),
      paragraph([
        "Step 5（(5) の証明）。(2) より任意の ",
        math(String.raw`x \in \mathbb{C}^{2^M}`),
        " は ",
        math(String.raw`x = \sum_\epsilon Q_\epsilon x`),
        " と書け、各項は ",
        math(String.raw`\mathrm{im}\,Q_\epsilon`),
        " に属するから和は全体を張る。直和であることを見るために ",
        math(String.raw`\sum_\epsilon y_\epsilon = 0`),
        "（",
        math(String.raw`y_\epsilon \in \mathrm{im}\,Q_\epsilon`),
        "）とする。",
        math(String.raw`y_\epsilon = Q_\epsilon x_\epsilon`),
        " と書くと (1) より ",
        math(String.raw`Q_{\epsilon'} y_\epsilon = Q_{\epsilon'}Q_\epsilon x_\epsilon`),
        " は ",
        math(String.raw`\epsilon \neq \epsilon'`),
        " のとき ",
        math(String.raw`0`),
        "、",
        math(String.raw`\epsilon = \epsilon'`),
        " のとき ",
        math(String.raw`Q_\epsilon x_\epsilon = y_\epsilon`),
        " である。よって ",
        math(String.raw`0 = Q_{\epsilon'}\left(\sum_\epsilon y_\epsilon\right) = y_{\epsilon'}`),
        " が各 ",
        math(String.raw`\epsilon'`),
        " について成り立ち、直和である。",
      ]),
      paragraph([
        "（次元の整合：",
        math(String.raw`\left|\{0,1\}^{\mathcal{I}}\right| = 2^m`),
        " 個の空間がそれぞれ ",
        math(String.raw`2^{M-m}`),
        " 次元で、合計 ",
        math(String.raw`2^m \cdot 2^{M-m} = 2^M`),
        " となり ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の次元に一致する。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_009_claim_eigenvalues_of_Vprime",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`V' \text{ の固有値}` },
    labels: ["eigenvalues_of_Vprime"],
    statement: [
      paragraph([
        math(String.raw`\epsilon \in \{0,1\}^{\mathcal{I}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`g(\epsilon) := \sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right) \in \mathbb{R}`,
      ),
      paragraph(["とおく。このとき"]),
      displayMath(String.raw`V' Q_\epsilon = e^{g(\epsilon)} Q_\epsilon`),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`\mathrm{im}\,Q_\epsilon`),
        " の各元は ",
        math(String.raw`V'`),
        " の固有値 ",
        math(String.raw`e^{g(\epsilon)}`),
        " の固有ベクトルであり、",
        ref("joint_eigenspace_decomposition"),
        " (5) より ",
        math(String.raw`V'`),
        " は対角化可能で、その固有値は重複度を込めて",
      ]),
      displayMath(
        String.raw`\left\{\,e^{g(\epsilon)} \ \text{（重複度 } 2^{M-m}\text{）} \ \middle|\ \epsilon \in \{0,1\}^{\mathcal{I}}\,\right\}`,
      ),
      paragraph([
        "で尽くされる（個数は重複度を込めて ",
        math(String.raw`2^m\cdot 2^{M-m} = 2^M`),
        "）。とくに ",
        math(String.raw`V'`),
        " の固有値はすべて正の実数である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`X Q_\epsilon = g(\epsilon) Q_\epsilon`),
        "）。",
        ref("def_number_operator"),
        " の ",
        math(String.raw`X = \sum_{\mu\in\mathcal{I}}\gamma(\theta_\mu)(n_\mu - \tfrac12 I)`),
        " に ",
        ref("joint_eigenspace_decomposition"),
        " (3) を代入して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
X Q_\epsilon
&= \sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)
   \left(n_\mu Q_\epsilon - \tfrac{1}{2} Q_\epsilon\right)
   \quad (\because \text{行列の積の分配法則}) \\
&= \sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)
   \left(\epsilon_\mu Q_\epsilon - \tfrac{1}{2} Q_\epsilon\right)
   \quad (\because \text{同時固有空間分解 (3)}) \\
&= \left(\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\left(\epsilon_\mu - \tfrac{1}{2}\right)\right) Q_\epsilon
= g(\epsilon)\,Q_\epsilon
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`X^k Q_\epsilon = g(\epsilon)^k Q_\epsilon`),
        "）。",
        math(String.raw`k`),
        " に関する帰納法。",
        math(String.raw`k=0`),
        " は自明。",
        math(String.raw`X^k Q_\epsilon = g(\epsilon)^k Q_\epsilon`),
        " を仮定すると、Step 1 より",
      ]),
      displayMath(
        String.raw`X^{k+1}Q_\epsilon = X\left(X^k Q_\epsilon\right)
= X\left(g(\epsilon)^k Q_\epsilon\right)
= g(\epsilon)^k\left(X Q_\epsilon\right)
= g(\epsilon)^{k+1} Q_\epsilon`,
      ),
      paragraph([
        "Step 3（指数関数へ）。",
        ref("def_exp"),
        " より ",
        math(String.raw`V' = \exp(X) = \sum_{k=0}^{\infty}\frac{1}{k!}X^k`),
        " であり、この級数は ",
        ref("exp_converges"),
        " により ",
        ref("def_matrix_norm"),
        " のノルムについて収束する。部分和を ",
        math(String.raw`E_K := \sum_{k=0}^{K}\frac{1}{k!}X^k`),
        " と書くと、Step 2 と有限和の線型性から",
      ]),
      displayMath(
        String.raw`E_K Q_\epsilon = \sum_{k=0}^{K}\frac{1}{k!}X^k Q_\epsilon
= \left(\sum_{k=0}^{K}\frac{g(\epsilon)^k}{k!}\right) Q_\epsilon`,
      ),
      paragraph([
        math(String.raw`K \to \infty`),
        " とすると、左辺は ",
        ref("matrix_multiplication_continuity"),
        " より ",
        math(String.raw`\exp(X) Q_\epsilon = V' Q_\epsilon`),
        " に収束し、右辺は ",
        ref("real_exp_series_converges"),
        " より ",
        math(String.raw`e^{g(\epsilon)}Q_\epsilon`),
        " に収束する。極限の一意性より",
      ]),
      displayMath(String.raw`V' Q_\epsilon = e^{g(\epsilon)} Q_\epsilon`),
      paragraph([
        "Step 4（固有値の言い換え）。",
        math(String.raw`y \in \mathrm{im}\,Q_\epsilon`),
        " なら ",
        math(String.raw`y = Q_\epsilon x`),
        " と書けて、",
        ref("joint_eigenspace_decomposition"),
        " (1) より ",
        math(String.raw`Q_\epsilon y = Q_\epsilon^2 x = Q_\epsilon x = y`),
        " だから",
      ]),
      displayMath(String.raw`V' y = V' Q_\epsilon y = e^{g(\epsilon)} Q_\epsilon y = e^{g(\epsilon)} y`),
      paragraph([
        ref("joint_eigenspace_decomposition"),
        " (5) より ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " は ",
        math(String.raw`\mathrm{im}\,Q_\epsilon`),
        " たちの直和だから、各 ",
        math(String.raw`\mathrm{im}\,Q_\epsilon`),
        " の基底を合わせると ",
        math(String.raw`V'`),
        " の固有ベクトルからなる ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の基底が得られる。したがって ",
        math(String.raw`V'`),
        " は対角化可能で、固有値は ",
        math(String.raw`e^{g(\epsilon)}`),
        " が重複度 ",
        math(String.raw`\dim \mathrm{im}\,Q_\epsilon = 2^{M-m}`),
        " で現れるもので尽くされる。",
      ]),
      paragraph([
        math(String.raw`g(\epsilon) \in \mathbb{R}`),
        "（",
        ref("def_gamma_theta_mu"),
        " より ",
        math(String.raw`\gamma(\theta_\mu) \in \mathbb{R}_{\geq 0}`),
        "）なので ",
        math(String.raw`e^{g(\epsilon)} > 0`),
        " である。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_010_claim_trace_of_Vprime",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`\mathrm{tr}(V') = \mathrm{tr}(V'^{-1}) > 0` },
    labels: ["trace_of_Vprime"],
    statement: [
      paragraph([
        math(String.raw`V'`),
        " は可逆で ",
        math(String.raw`V'^{-1} = \exp(-X)`),
        " であり、",
      ]),
      displayMath(
        String.raw`\mathrm{tr}(V') = \mathrm{tr}(V'^{-1})
= 2^{M-m}\prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
\ \in \mathbb{R}_{>0}`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1（可逆性）。",
        math(String.raw`X`),
        " と ",
        math(String.raw`-X`),
        " は可換なので ",
        ref("theorem_exp_product"),
        " より ",
        math(String.raw`\exp(X)\exp(-X) = \exp(X + (-X)) = \exp(0)`),
        " であり、",
        ref("theorem_exp_zero"),
        " より ",
        math(String.raw`\exp(0) = I`),
        "。同様に ",
        math(String.raw`\exp(-X)\exp(X) = I`),
        " だから ",
        math(String.raw`V' = \exp(X)`),
        " は可逆で ",
        math(String.raw`V'^{-1} = \exp(-X)`),
        "。",
      ]),
      paragraph([
        "Step 2（トレースの計算）。",
        ref("joint_eigenspace_decomposition"),
        " (2) と ",
        ref("eigenvalues_of_Vprime"),
        "、および ",
        ref("trace_basic_properties"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(V')
&= \mathrm{tr}\!\left(V' \sum_{\epsilon} Q_\epsilon\right)
   \quad (\because \textstyle\sum_\epsilon Q_\epsilon = I) \\
&= \sum_{\epsilon} \mathrm{tr}\!\left(V' Q_\epsilon\right)
   \quad (\because \text{トレースの線型性}) \\
&= \sum_{\epsilon} e^{g(\epsilon)}\,\mathrm{tr}(Q_\epsilon)
   \quad (\because V'Q_\epsilon = e^{g(\epsilon)}Q_\epsilon) \\
&= 2^{M-m}\sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} e^{g(\epsilon)}
   \quad (\because \mathrm{tr}(Q_\epsilon) = 2^{M-m})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（積への分解）。",
        math(String.raw`g(\epsilon) = \sum_{\mu}\gamma(\theta_\mu)(\epsilon_\mu - \tfrac12)`),
        " なので、実数の指数法則より",
      ]),
      displayMath(
        String.raw`e^{g(\epsilon)} = \prod_{\mu \in \mathcal{I}}
\exp\!\left(\gamma(\theta_\mu)\left(\epsilon_\mu - \tfrac{1}{2}\right)\right)`,
      ),
      paragraph([
        math(String.raw`\epsilon`),
        " は各成分を独立に ",
        math(String.raw`0`),
        " か ",
        math(String.raw`1`),
        " から選ぶので、有限個の因子の積の展開（Step 2 の ",
        math(String.raw`\sum_\epsilon`),
        " と同じ 1 対 1 対応）により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} e^{g(\epsilon)}
&= \prod_{\mu \in \mathcal{I}}
   \left(\exp\!\left(-\tfrac{\gamma(\theta_\mu)}{2}\right)
   + \exp\!\left(+\tfrac{\gamma(\theta_\mu)}{2}\right)\right) \\
&= \prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
   \quad \left(\because \cosh x = \frac{e^x + e^{-x}}{2}\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`V'^{-1}`),
        " についても同じ値）。",
        math(String.raw`V'^{-1} = \exp(-X)`),
        " であり、",
        math(String.raw`-X = \sum_\mu(-\gamma(\theta_\mu))(n_\mu - \tfrac12 I)`),
        " だから、Step 1〜3 をそのまま ",
        math(String.raw`\gamma(\theta_\mu) \to -\gamma(\theta_\mu)`),
        " として適用でき",
      ]),
      displayMath(
        String.raw`\mathrm{tr}(V'^{-1})
= 2^{M-m}\prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{-\gamma(\theta_\mu)}{2}\right)
= 2^{M-m}\prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
= \mathrm{tr}(V')`,
      ),
      paragraph([
        "最後から 2 番目の等号は ",
        math(String.raw`\cosh`),
        " が偶関数であること（",
        ref("cosh_sinh_basic_properties"),
        "）による。",
      ]),
      paragraph([
        "Step 5（正値性）。",
        ref("def_gamma_theta_mu"),
        " より ",
        math(String.raw`\gamma(\theta_\mu) \in \mathbb{R}_{\geq 0}`),
        " であり、",
        ref("cosh_sinh_basic_properties"),
        " より ",
        math(String.raw`\cosh x \geq 1`),
        "。よって各因子は ",
        math(String.raw`2\cosh(\gamma(\theta_\mu)/2) \geq 2 > 0`),
        " であり、",
        math(String.raw`2^{M-m} > 0`),
        " と合わせて ",
        math(String.raw`\mathrm{tr}(V') > 0`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    kind: "definition",
    origin: { path: SRC, ordinal: 13 },
    title: { text: "共役転置・エルミート行列・正定値行列" },
    labels: ["def_hermitian_positive_definite"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A = (A_{kl}) \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対し、共役転置を",
      ]),
      displayMath(String.raw`(A^*)_{kl} := \overline{A_{lk}}`),
      paragraph([
        "で定める（",
        math(String.raw`\overline{\phantom{z}}`),
        " は ",
        ref("definition_of_cc"),
        " の複素共役）。",
        math(String.raw`x = (x_1,\dots,x_n) \in \mathbb{C}^n`),
        " を ",
        math(String.raw`n\times 1`),
        " 行列とみなすと ",
        math(String.raw`x^* A x \in \mathbb{C}`),
        "（",
        math(String.raw`1\times 1`),
        " 行列を ",
        math(String.raw`\mathbb{C}`),
        " と同一視する）である。",
      ]),
      paragraph([
        math(String.raw`A`),
        " が ",
        math(String.raw`A^* = A`),
        " を満たすとき ",
        math(String.raw`A`),
        " は**エルミート**であるという。エルミートな ",
        math(String.raw`A`),
        " が さらに",
      ]),
      displayMath(
        String.raw`\forall x \in \mathbb{C}^n \setminus \{0\} : \quad x^* A x \in \mathbb{R}_{>0}`,
      ),
      paragraph([
        "を満たすとき ",
        math(String.raw`A`),
        " は**正定値**であるという。",
      ]),
      paragraph([
        "成分がすべて実数で ",
        math(String.raw`A^{\top} = A`),
        "（転置に関して対称）な行列は ",
        math(String.raw`\overline{A_{lk}} = A_{lk} = A_{kl}`),
        " よりエルミートである。以下ではこれを**実対称**と呼ぶ。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_012_claim_star_is_norm_preserving",
    kind: "claim",
    origin: { path: SRC, ordinal: 14 },
    title: { tex: String.raw`\|A^*\| = \|A\| \text{ と極限の共役転置}` },
    labels: ["star_preserves_norm_and_limits"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n,\mathbb{C})`),
        " について、",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad (AB)^* = B^* A^*, \qquad (\alpha A + \beta B)^* = \overline{\alpha}A^* + \overline{\beta}B^*`)],
        [
          math(String.raw`\text{(2)}\quad \|A^*\| = \|A\|`),
          "（ノルムは ",
          ref("def_matrix_norm"),
          " のもの）",
        ],
        [
          math(String.raw`\text{(3)}\quad A_N \to A \ \Longrightarrow\ A_N^* \to A^*`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) 成分計算による。",
        math(String.raw`((AB)^*)_{kl} = \overline{(AB)_{lk}} = \overline{\sum_j A_{lj}B_{jk}} = \sum_j \overline{B_{jk}}\,\overline{A_{lj}} = \sum_j (B^*)_{kj}(A^*)_{jl} = (B^*A^*)_{kl}`),
        "（複素共役が和と積を保つことは ",
        ref("conjugation_is_ring_homomorphism"),
        " による）。第 2 式も同様。",
      ]),
      paragraph([
        "(2) ",
        ref("def_matrix_norm"),
        " のノルムは ",
        math(String.raw`\|A\| = \sqrt{\sum_{k,l}|A_{kl}|^2}`),
        " であり、",
        math(String.raw`|(A^*)_{kl}| = |\overline{A_{lk}}| = |A_{lk}|`),
        "（",
        ref("abs_basic_properties"),
        "）なので、",
        math(String.raw`(k,l) \mapsto (l,k)`),
        " は添字集合の全単射だから和の値は変わらない。",
      ]),
      paragraph([
        "(3) (1) の第 2 式より ",
        math(String.raw`A_N^* - A^* = (A_N - A)^*`),
        " なので、(2) より ",
        math(String.raw`\|A_N^* - A^*\| = \|A_N - A\| \to 0`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
    kind: "claim",
    origin: { path: SRC, ordinal: 15 },
    title: { tex: String.raw`\text{エルミート行列の } \exp \text{ は正定値}` },
    labels: ["exp_hermitian_is_positive_definite"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad S \in \mathrm{Mat}(n,\mathbb{C}) \text{ がエルミートなら } \exp(S) \text{ はエルミートかつ正定値}`),
        ],
        [
          math(String.raw`\text{(2)}\quad A \text{ が正定値、} B \text{ が可逆なら } B^* A B \text{ は正定値}`),
        ],
        [
          math(String.raw`\text{(3)}\quad A \text{ が正定値、} \alpha \in \mathbb{R}_{>0} \text{ なら } \alpha A \text{ は正定値}`),
        ],
        [math(String.raw`\text{(4)}\quad A \text{ が正定値なら } \mathrm{tr}(A) \in \mathbb{R}_{>0}`)],
      ]),
    ],
    proof: [
      paragraph([
        "(1) まずエルミート性。",
        ref("star_preserves_norm_and_limits"),
        " (1) を繰り返し使うと ",
        math(String.raw`(S^k)^* = (S^*)^k = S^k`),
        " であり、",
        math(String.raw`1/k! \in \mathbb{R}`),
        " なので部分和 ",
        math(String.raw`E_K := \sum_{k=0}^{K}\frac{1}{k!}S^k`),
        " はエルミートである（",
        math(String.raw`E_K^* = \sum_k \overline{1/k!}\,(S^k)^* = E_K`),
        "）。",
        ref("exp_converges"),
        " より ",
        math(String.raw`E_K \to \exp(S)`),
        " であり、",
        ref("star_preserves_norm_and_limits"),
        " (3) より ",
        math(String.raw`E_K^* \to \exp(S)^*`),
        "。左辺は ",
        math(String.raw`E_K^* = E_K \to \exp(S)`),
        " なので、極限の一意性から ",
        math(String.raw`\exp(S)^* = \exp(S)`),
        "。",
      ]),
      paragraph([
        "次に正定値性。",
        math(String.raw`S/2`),
        " もエルミートなので、いま示したことから ",
        math(String.raw`\exp(S/2)^* = \exp(S/2)`),
        "。また ",
        math(String.raw`S/2`),
        " は自分自身と可換なので ",
        ref("theorem_exp_product"),
        " より",
      ]),
      displayMath(
        String.raw`\exp(S/2)\exp(S/2) = \exp(S/2 + S/2) = \exp(S)`,
      ),
      paragraph([
        "さらに ",
        math(String.raw`\exp(S/2)\exp(-S/2) = \exp(0) = I`),
        "（",
        ref("theorem_exp_product"),
        "、",
        ref("theorem_exp_zero"),
        "）より ",
        math(String.raw`\exp(S/2)`),
        " は可逆である。よって ",
        math(String.raw`x \in \mathbb{C}^n\setminus\{0\}`),
        " に対し ",
        math(String.raw`w := \exp(S/2)x \neq 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`x^*\exp(S)x
= x^*\exp(S/2)^*\exp(S/2)x
= \left(\exp(S/2)x\right)^*\left(\exp(S/2)x\right)
= w^* w
= \sum_{k=1}^{n}|w_k|^2
= \|w\|^2 > 0`,
      ),
      paragraph([
        "（",
        math(String.raw`w \neq 0`),
        " なのでどれかの ",
        math(String.raw`w_k \neq 0`),
        " であり、平方和は正）。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`(B^*AB)^* = B^* A^* B^{**} = B^* A B`),
        "（",
        ref("star_preserves_norm_and_limits"),
        " (1) と ",
        math(String.raw`B^{**} = B`),
        "、および ",
        math(String.raw`A^* = A`),
        "）よりエルミート。",
        math(String.raw`x \neq 0`),
        " なら ",
        math(String.raw`B`),
        " が可逆なので ",
        math(String.raw`Bx \neq 0`),
        " であり、",
      ]),
      displayMath(String.raw`x^*(B^*AB)x = (Bx)^* A (Bx) > 0`),
      paragraph([
        "(3) ",
        math(String.raw`(\alpha A)^* = \overline{\alpha}A^* = \alpha A`),
        "（",
        math(String.raw`\alpha`),
        " は実数）よりエルミートで、",
        math(String.raw`x^*(\alpha A)x = \alpha (x^*Ax) > 0`),
        "。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`e_k \in \mathbb{C}^n`),
        " を第 ",
        math(String.raw`k`),
        " 標準基底ベクトルとすると ",
        math(String.raw`e_k^* A e_k = A_{kk}`),
        " であり、",
        math(String.raw`e_k \neq 0`),
        " なので ",
        math(String.raw`A_{kk} \in \mathbb{R}_{>0}`),
        "。したがって ",
        math(String.raw`\mathrm{tr}(A) = \sum_{k=1}^{n} A_{kk} \in \mathbb{R}_{>0}`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
    kind: "claim",
    origin: { path: SRC, ordinal: 16 },
    title: { tex: String.raw`i K_1 H_1^{(\pm)} \text{ と } i K_2^* H_2 \text{ は実対称}` },
    labels: ["iH_is_real_symmetric"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもとで、",
      ]),
      displayMath(
        String.raw`S_1^{(\pm)} := i K_1 H_1^{(\pm)}, \qquad S_2 := i K_2^* H_2`,
      ),
      paragraph(["とおくと、"]),
      displayMath(
        String.raw`\begin{aligned}
S_1^{(\pm)} &= K_1\left(\sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z\right)
  \mp K_1\, G, \qquad
G := \sigma_1^y\,\sigma_2^x \sigma_3^x \cdots \sigma_{M-1}^x\, \sigma_M^y \\
S_2 &= K_2^*\left(\sigma_1^x + \sigma_2^x + \cdots + \sigma_M^x\right)
\end{aligned}`,
      ),
      paragraph([
        "であり（",
        math(String.raw`M = 2`),
        " のとき ",
        math(String.raw`G = \sigma_1^y\sigma_2^y`),
        " と読む）、",
        math(String.raw`S_1^{(\pm)}`),
        " と ",
        math(String.raw`S_2`),
        " はいずれも成分がすべて実数で、転置について対称である。とくに ",
        ref("def_hermitian_positive_definite"),
        " の意味でエルミートである。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（用いる ",
        math(String.raw`2\times 2`),
        " の積）。",
        ref("pauli_matrix_products"),
        " の行列表示から直接成分計算して",
      ]),
      displayMath(
        String.raw`\sigma^z\sigma^y
= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
= \begin{pmatrix}0&-i\\-i&0\end{pmatrix} = -i\,\sigma^x, \qquad
\sigma^y\sigma^x
= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
= \begin{pmatrix}-i&0\\0&i\end{pmatrix} = -i\,\sigma^z`,
      ),
      displayMath(
        String.raw`\sigma^x\sigma^z
= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
= \begin{pmatrix}0&-1\\1&0\end{pmatrix} = -i\,\sigma^y`,
      ),
      paragraph([
        "また ",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、相異なるサイトに置かれた ",
        math(String.raw`\sigma_j^a`),
        " と ",
        math(String.raw`\sigma_k^b`),
        "（",
        math(String.raw`j \neq k`),
        "）は可換である（",
        ref("kronecker_product_rule"),
        " (1) より、クロネッカー積どうしの積は各サイトごとの ",
        math(String.raw`2`),
        " 次の行列の積になり、各サイトでは一方が ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " だから）。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`S_2`),
        " の形）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_m Y_m
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^z\right)
   \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y\right) \\
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\right)\left(\sigma_1^x\cdots\sigma_{m-1}^x\right)
   \sigma_m^z\sigma_m^y
   \quad (\because \sigma_m^z \text{ は } \sigma_j^x\ (j<m) \text{ と可換}) \\
&= \sigma_m^z\sigma_m^y
   \quad (\because \sigma_j^x\sigma_j^x = I) \\
&= -i\,\sigma_m^x
   \quad (\because \text{Step 0})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`H_2 = \sum_{m=1}^{M} Z_mY_m = -i\sum_{m=1}^{M}\sigma_m^x`),
        " であり、",
        math(String.raw`S_2 = iK_2^*H_2 = i(-i)K_2^*\sum_m \sigma_m^x = K_2^*\sum_{m=1}^{M}\sigma_m^x`),
        "。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`S_1^{(\pm)}`),
        " の形）。",
        math(String.raw`1 \leq m \leq M-1`),
        " に対して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_m Z_{m+1}
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y\right)
   \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^x\,\sigma_{m+1}^z\right) \\
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\right)^2\,
   \sigma_m^y\sigma_m^x\,\sigma_{m+1}^z
   \quad (\because \text{相異なる因子どうしは可換}) \\
&= \sigma_m^y\sigma_m^x\,\sigma_{m+1}^z
   \quad (\because \sigma_j^x\sigma_j^x = I) \\
&= -i\,\sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{Step 0})
\end{aligned}`,
      ),
      paragraph(["また境界項について"]),
      displayMath(
        String.raw`\begin{aligned}
Y_M Z_1
&= \left(\sigma_1^x\sigma_2^x\cdots\sigma_{M-1}^x\,\sigma_M^y\right)\sigma_1^z \\
&= \left(\sigma_1^x\sigma_1^z\right)\sigma_2^x\cdots\sigma_{M-1}^x\,\sigma_M^y
   \quad (\because \sigma_1^z \text{ は他の因子と可換}) \\
&= -i\,\sigma_1^y\,\sigma_2^x\cdots\sigma_{M-1}^x\,\sigma_M^y
   \quad (\because \text{Step 0}) \\
&= -i\,G
\end{aligned}`,
      ),
      paragraph([
        ref("def_V1_pm"),
        " の ",
        math(String.raw`H_1^{(\pm)} = Y_1Z_2 + \cdots + Y_{M-1}Z_M \mp Y_MZ_1`),
        " に代入し ",
        math(String.raw`i \cdot (-i) = 1`),
        " を使うと",
      ]),
      displayMath(
        String.raw`S_1^{(\pm)} = iK_1H_1^{(\pm)}
= K_1\sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z \mp K_1\,G`,
      ),
      paragraph([
        "Step 3（実対称性）。",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        " と ",
        math(String.raw`\sigma^z = \begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " は成分が実で対称、",
        math(String.raw`\sigma^y = \begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        " は成分が純虚数で交代（",
        math(String.raw`(\sigma^y)^\top = -\sigma^y`),
        "）である。クロネッカー積（",
        ref("def_kronecker"),
        "）の成分は各因子の成分の積であり、転置は因子ごとの転置になる（",
        ref("kronecker_transpose"),
        "）：",
      ]),
      displayMath(
        String.raw`\left(A_1\boxtimes\cdots\boxtimes A_M\right)^\top
= A_1^\top\boxtimes\cdots\boxtimes A_M^\top
\quad (\because \text{クロネッカー積の転置})`,
      ),
      paragraph([
        "したがって、",
      ]),
      list([
        [
          math(String.raw`\sigma_m^x`),
          "：",
          math(String.raw`\sigma^x`),
          " が 1 個、他は ",
          math(String.raw`I`),
          "。成分は実、転置で不変。",
        ],
        [
          math(String.raw`\sigma_m^z\sigma_{m+1}^z`),
          "：",
          math(String.raw`\sigma^z`),
          " が 2 個、他は ",
          math(String.raw`I`),
          "。成分は実、転置で不変。",
        ],
        [
          math(String.raw`G`),
          "：",
          math(String.raw`\sigma^y`),
          " が **2 個**（第 1 因子と第 ",
          math(String.raw`M`),
          " 因子）、残りは ",
          math(String.raw`\sigma^x`),
          "。純虚数成分の因子がちょうど 2 個なので、成分の積に現れる虚数単位は ",
          math(String.raw`i^2 = -1`),
          " の形でまとまり、成分はすべて実数。転置は ",
          math(String.raw`(-1)^2 = 1`),
          " 倍なので ",
          math(String.raw`G^\top = G`),
          "。",
        ],
      ]),
      paragraph([
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " なので、これらの実係数の有限和である ",
        math(String.raw`S_1^{(\pm)}`),
        "、",
        math(String.raw`S_2`),
        " は成分がすべて実数で転置について対称、すなわち実対称である。",
        ref("def_hermitian_positive_definite"),
        " の最後の注意より、実対称行列はエルミートである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "iK_1H_1^{(±)} と iK_2^*H_2 が厳密に実対称（成分が実かつ転置不変）であることは、M=2,3,4,5 と両符号について数値的にも残差 0 で確認した（sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/check_01_real_symmetric.sage）。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_015_claim_V_is_positive_definite",
    kind: "claim",
    origin: { path: SRC, ordinal: 17 },
    title: { tex: String.raw`V \text{ は正定値、とくに } \mathrm{tr}(V) > 0` },
    labels: ["V_is_positive_definite"],
    statement: [
      paragraph([
        ref("V_eq_Vprime"),
        " の ",
        math(String.raw`V := (V_1^{(\pm)})^{1/2}\,V_2\,(V_1^{(\pm)})^{1/2}`),
        " について（",
        math(String.raw`(V_1^{(\pm)})^{1/2} := \exp\!\left(\tfrac{1}{2}iK_1H_1^{(\pm)}\right) = \exp\!\left(\tfrac{1}{2}S_1^{(\pm)}\right)`),
        " は ",
        ref("ホロノミック量子場_p142下段_1"),
        " の proof で用いられている規約）、",
      ]),
      displayMath(
        String.raw`V = (2s_2)^{M/2}\,\exp\!\left(\tfrac{1}{2}S_1^{(\pm)}\right)
\exp\!\left(S_2\right)\exp\!\left(\tfrac{1}{2}S_1^{(\pm)}\right)`,
      ),
      paragraph([
        "であり、",
        math(String.raw`V`),
        " は可逆で正定値、",
        math(String.raw`V^{-1}`),
        " も正定値である。とくに",
      ]),
      displayMath(String.raw`\mathrm{tr}(V) \in \mathbb{R}_{>0}, \qquad \mathrm{tr}(V^{-1}) \in \mathbb{R}_{>0}`),
    ],
    proof: [
      paragraph([
        "Step 1（表示）。",
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`V_2 = (2\sinh 2K_2)^{M/2}\exp\!\left(K_2^*\sum_{m}\sigma_m^x\right)`),
        " であり、",
        ref("iH_is_real_symmetric"),
        " の Step 1 より指数の中身は ",
        math(String.raw`S_2`),
        " に等しい。よって ",
        math(String.raw`V_2 = (2s_2)^{M/2}\exp(S_2)`),
        " であり、",
        math(String.raw`(2s_2)^{M/2}`),
        " はスカラーなので ",
        ref("scalar_identity_commutes"),
        " により前へ出せて statement の表示を得る。",
      ]),
      paragraph([
        "Step 2（各因子の性質）。",
        ref("iH_is_real_symmetric"),
        " より ",
        math(String.raw`\tfrac12 S_1^{(\pm)}`),
        " と ",
        math(String.raw`S_2`),
        " はエルミートである。",
        ref("exp_hermitian_is_positive_definite"),
        " (1) より",
      ]),
      list([
        [math(String.raw`B := \exp\!\left(\tfrac12 S_1^{(\pm)}\right)`), " はエルミートかつ正定値、とくに可逆"],
        [math(String.raw`A := \exp(S_2)`), " は正定値"],
      ]),
      paragraph([
        "Step 3（正定値性）。",
        math(String.raw`B`),
        " がエルミートなので ",
        math(String.raw`B^* = B`),
        " であり、",
      ]),
      displayMath(String.raw`\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right) = B A B = B^* A B`),
      paragraph([
        ref("exp_hermitian_is_positive_definite"),
        " (2) より ",
        math(String.raw`B^*AB`),
        " は正定値。",
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`s_2 = \sinh 2K_2 > 0`),
        " なので ",
        math(String.raw`(2s_2)^{M/2} \in \mathbb{R}_{>0}`),
        " であり、同 (3) より ",
        math(String.raw`V = (2s_2)^{M/2}B^*AB`),
        " も正定値である。",
      ]),
      paragraph([
        "Step 4（可逆性と ",
        math(String.raw`V^{-1}`),
        "）。",
        math(String.raw`\exp(\pm\tfrac12 S_1^{(\pm)})`),
        " と ",
        math(String.raw`\exp(\pm S_2)`),
        " は互いに逆行列（",
        ref("theorem_exp_product"),
        "、",
        ref("theorem_exp_zero"),
        "）なので、",
      ]),
      displayMath(
        String.raw`V^{-1} = (2s_2)^{-M/2}\,\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)
\exp\!\left(-S_2\right)\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)`,
      ),
      paragraph([
        "実際、右辺と ",
        math(String.raw`V`),
        " の積は内側から順に打ち消し合って ",
        math(String.raw`I`),
        " になる。",
        math(String.raw`-\tfrac12 S_1^{(\pm)}`),
        " と ",
        math(String.raw`-S_2`),
        " もエルミートなので、Step 2〜3 をそのまま適用して ",
        math(String.raw`V^{-1}`),
        " も正定値である。",
      ]),
      paragraph([
        "Step 5（トレース）。",
        ref("exp_hermitian_is_positive_definite"),
        " (4) より ",
        math(String.raw`\mathrm{tr}(V) > 0`),
        "、",
        math(String.raw`\mathrm{tr}(V^{-1}) > 0`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_016_claim_sign_flip_conjugation",
    kind: "claim",
    origin: { path: SRC, ordinal: 18 },
    title: { tex: String.raw`\text{符号反転共役 } U` },
    labels: ["sign_flip_conjugation"],
    statement: [
      paragraph([math(String.raw`M \in \mathbb{Z}_{\geq 2}`), " とし、"]),
      displayMath(
        String.raw`E := \prod_{\substack{1 \leq m \leq M \\ m\ \text{奇数}}} \sigma_m^x, \qquad
F := \prod_{m=1}^{M} \sigma_m^z, \qquad
U := E F \in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "とおく（積の因子は相異なるサイトに置かれた ",
        math(String.raw`2`),
        " 次の行列のクロネッカー積なので、",
        ref("kronecker_product_rule"),
        " (1) より互いに可換であり、順序は問わない）。このとき ",
        math(String.raw`U`),
        " は可逆で、複号同順に",
      ]),
      displayMath(
        String.raw`U\,S_1^{(\pm)}\,U^{-1} = -\,S_1^{(\pm)}, \qquad
U\,S_2\,U^{-1} = -\,S_2`,
      ),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`U H_1^{(\pm)} U^{-1} = -H_1^{(\pm)}`),
        "、",
        math(String.raw`U H_2 U^{-1} = -H_2`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（可逆性）。",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = \sigma^z\sigma^z = I`),
        " なので ",
        math(String.raw`\sigma_m^x`),
        "、",
        math(String.raw`\sigma_m^z`),
        " はいずれも自分自身を逆行列にもつ可逆行列であり、可逆行列の有限積である ",
        math(String.raw`E, F, U`),
        " も可逆である。",
      ]),
      paragraph([
        "Step 1（1 因子ごとの共役）。",
        math(String.raw`j \neq k`),
        " なら ",
        math(String.raw`\sigma_j^a`),
        " と ",
        math(String.raw`\sigma_k^b`),
        " は可換なので、共役 ",
        math(String.raw`X \mapsto FXF^{-1}`),
        " において ",
        math(String.raw`F`),
        " のうち第 ",
        math(String.raw`k`),
        " 因子の ",
        math(String.raw`\sigma_k^z`),
        " だけが効く。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z\sigma^x = -\sigma^x\sigma^z`),
        "、",
        math(String.raw`\sigma^y\sigma^z = -\sigma^z\sigma^y`),
        "、および ",
        math(String.raw`(\sigma^z)^{-1} = \sigma^z`),
        " より",
      ]),
      displayMath(
        String.raw`F\sigma_k^x F^{-1} = \sigma_k^z\sigma_k^x\sigma_k^z = -\sigma_k^x, \quad
F\sigma_k^y F^{-1} = -\sigma_k^y, \quad
F\sigma_k^z F^{-1} = \sigma_k^z`,
      ),
      paragraph([
        "同様に ",
        math(String.raw`E`),
        " は奇数番目の因子にだけ ",
        math(String.raw`\sigma^x`),
        " をもつので",
      ]),
      displayMath(
        String.raw`E\sigma_k^a E^{-1} =
\begin{cases}
\sigma_k^a & (k \text{ 偶数、どの } a \text{ でも}) \\
\sigma_k^x & (k \text{ 奇数},\ a = x) \\
-\sigma_k^y & (k \text{ 奇数},\ a = y) \\
-\sigma_k^z & (k \text{ 奇数},\ a = z)
\end{cases}`,
      ),
      paragraph([
        "この 2 つを合成して（",
        math(String.raw`U X U^{-1} = E(FXF^{-1})E^{-1}`),
        "）、",
      ]),
      displayMath(
        String.raw`U\sigma_k^x U^{-1} = -\sigma_k^x, \qquad
U\sigma_k^y U^{-1} = \begin{cases}+\sigma_k^y & (k\ \text{奇数}) \\ -\sigma_k^y & (k\ \text{偶数})\end{cases}, \qquad
U\sigma_k^z U^{-1} = \begin{cases}-\sigma_k^z & (k\ \text{奇数}) \\ +\sigma_k^z & (k\ \text{偶数})\end{cases}`,
      ),
      paragraph([
        "以下、共役 ",
        math(String.raw`X \mapsto UXU^{-1}`),
        " が ",
        math(String.raw`\mathbb{C}`),
        " 線型で積を保つこと（",
        math(String.raw`U(XY)U^{-1} = (UXU^{-1})(UYU^{-1})`),
        "、",
        math(String.raw`U^{-1}U = I`),
        " より）を繰り返し使う。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`Z_m`),
        " と ",
        math(String.raw`Y_m`),
        " への作用）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y`),
        " の各因子に Step 1 を適用すると、符号は因子ごとの符号の積になる。先頭の ",
        math(String.raw`\sigma^x`),
        " の因子は ",
        math(String.raw`m-1`),
        " 個あり、Step 1 の第 1 式より各々 ",
        math(String.raw`-1`),
        " なので寄与は ",
        math(String.raw`(-1)^{m-1}`),
        "。第 ",
        math(String.raw`m`),
        " 因子の寄与は Step 1 の第 2・第 3 式より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U Z_m U^{-1}
&= (-1)^{m-1}\cdot\begin{cases}-1 & (m\ \text{奇数}) \\ +1 & (m\ \text{偶数})\end{cases}\ Z_m
= -\,Z_m, \\
U Y_m U^{-1}
&= (-1)^{m-1}\cdot\begin{cases}+1 & (m\ \text{奇数}) \\ -1 & (m\ \text{偶数})\end{cases}\ Y_m
= +\,Y_m
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`m`),
        " 奇数なら ",
        math(String.raw`(-1)^{m-1} = +1`),
        "、",
        math(String.raw`m`),
        " 偶数なら ",
        math(String.raw`(-1)^{m-1} = -1`),
        " なので、いずれの場合も積は ",
        math(String.raw`Z_m`),
        " について ",
        math(String.raw`-1`),
        "、",
        math(String.raw`Y_m`),
        " について ",
        math(String.raw`+1`),
        " になる。",
        math(String.raw`m = 1`),
        " のときは先頭の ",
        math(String.raw`\sigma^x`),
        " の因子が無く ",
        math(String.raw`Z_1 = \sigma_1^z`),
        "、",
        math(String.raw`Y_1 = \sigma_1^y`),
        " だが、",
        math(String.raw`1`),
        " は奇数なので符号は同じく ",
        math(String.raw`-1`),
        "、",
        math(String.raw`+1`),
        " である。**",
        math(String.raw`m`),
        " の偶奇によらない**ことが要点である。）",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`H_1^{(\pm)}`),
        " と ",
        math(String.raw`H_2`),
        " への作用）。",
        ref("def_V1_pm"),
        " の ",
        math(String.raw`H_1^{(\pm)} = Y_1Z_2 + \cdots + Y_{M-1}Z_M \mp Y_MZ_1`),
        " と ",
        ref("iH_is_real_symmetric"),
        " の Step 1 の ",
        math(String.raw`H_2 = Z_1Y_1 + \cdots + Z_MY_M`),
        " は、どちらも ",
        math(String.raw`Y`),
        " と ",
        math(String.raw`Z`),
        " を 1 個ずつ掛けた項の係数 ",
        math(String.raw`\pm 1`),
        " の有限和である。Step 2 より各項について",
      ]),
      displayMath(
        String.raw`U\left(Y_j Z_k\right)U^{-1}
= \left(U Y_j U^{-1}\right)\left(U Z_k U^{-1}\right)
= (+Y_j)(-Z_k) = -\,Y_j Z_k, \qquad
U\left(Z_j Y_j\right)U^{-1} = (-Z_j)(+Y_j) = -\,Z_j Y_j`,
      ),
      paragraph([
        "なので、共役の ",
        math(String.raw`\mathbb{C}`),
        " 線型性より複号同順に",
      ]),
      displayMath(
        String.raw`U H_1^{(\pm)} U^{-1} = -\,H_1^{(\pm)}, \qquad
U H_2 U^{-1} = -\,H_2`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`S_1^{(\pm)}, S_2`),
        " への言い換え）。",
        math(String.raw`S_1^{(\pm)} = iK_1H_1^{(\pm)}`),
        "、",
        math(String.raw`S_2 = iK_2^*H_2`),
        " であり、スカラー倍は共役と可換なので Step 3 から",
      ]),
      displayMath(
        String.raw`U S_1^{(\pm)} U^{-1} = iK_1\,U H_1^{(\pm)} U^{-1} = -\,S_1^{(\pm)}, \qquad
U S_2 U^{-1} = iK_2^*\,U H_2 U^{-1} = -\,S_2`,
      ),
      paragraph([
        math(String.raw`K_1, K_2^* > 0`),
        " より ",
        math(String.raw`iK_1, iK_2^* \neq 0`),
        " なので、逆に ",
        math(String.raw`S`),
        " についての等式から ",
        math(String.raw`H`),
        " についての等式も従い、両者は同値である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "この U は M の偶奇によらず両方の符号 (±) について働く。M=2,3,4,5,6 と両符号で残差 0 を数値確認した（sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/check_02_sign_flip_conjugation.sage）。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_017_claim_constant_c_value",
    kind: "claim",
    origin: { path: SRC, ordinal: 19 },
    title: { tex: String.raw`c = (2\sinh 2K_2)^{M/2}` },
    labels: ["constant_c_value"],
    statement: [
      paragraph([
        ref("V_eq_Vprime"),
        " の定数 ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " は",
      ]),
      displayMath(
        String.raw`c = (2\sinh 2K_2)^{M/2} = (2s_2)^{M/2} \in \mathbb{R}_{>0}`,
      ),
      paragraph(["である。すなわち"]),
      displayMath(String.raw`V = (2\sinh 2K_2)^{M/2}\,V'`),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`S_1 := S_1^{(\pm)}`),
        "（符号の選択は固定する）、",
        math(String.raw`S_2`),
        " は ",
        ref("iH_is_real_symmetric"),
        " のもの、",
        math(String.raw`\tau := \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)`),
        " と書く。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\mathrm{tr}(V)`),
        " と ",
        math(String.raw`\mathrm{tr}(V^{-1})`),
        " を ",
        math(String.raw`\tau`),
        " で表す）。",
        ref("V_is_positive_definite"),
        " Step 1 の表示と ",
        ref("trace_basic_properties"),
        " (1)(2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(V)
&= (2s_2)^{M/2}\,
   \mathrm{tr}\!\left(\exp\!\left(\tfrac12 S_1\right)\exp(S_2)\exp\!\left(\tfrac12 S_1\right)\right)
   \quad (\because \text{トレースの線型性}) \\
&= (2s_2)^{M/2}\,
   \mathrm{tr}\!\left(\exp\!\left(\tfrac12 S_1\right)\exp\!\left(\tfrac12 S_1\right)\exp(S_2)\right)
   \quad \left(\because \text{巡回性を } A = \exp\!\left(\tfrac12 S_1\right)\exp(S_2),\ B = \exp\!\left(\tfrac12 S_1\right) \text{ に適用}\right) \\
&= (2s_2)^{M/2}\,\mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)
   \quad \left(\because \text{可換なので } \exp\!\left(\tfrac12 S_1\right)^2 = \exp(S_1)\right) \\
&= (2s_2)^{M/2}\,\tau
\end{aligned}`,
      ),
      paragraph([
        "同じ計算を ",
        ref("V_is_positive_definite"),
        " Step 4 の ",
        math(String.raw`V^{-1}`),
        " の表示に適用して",
      ]),
      displayMath(
        String.raw`\mathrm{tr}(V^{-1}) = (2s_2)^{-M/2}\,
\mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right)`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\mathrm{tr}(\exp(-S_1)\exp(-S_2)) = \tau`),
        "）。",
        ref("sign_flip_conjugation"),
        " の ",
        math(String.raw`U`),
        " について、共役は行列の積とスカラー倍を保ち、有限部分和の極限とも交換する（",
        math(String.raw`\|UXU^{-1} - UYU^{-1}\| = \|U(X-Y)U^{-1}\| \leq \|U\|\,\|U^{-1}\|\,\|X - Y\|`),
        "：",
        ref("matrix_norm_submultiplicativity"),
        "）から、",
        math(String.raw`U(S)^k U^{-1} = (USU^{-1})^k`),
        " と ",
        ref("def_exp"),
        " より",
      ]),
      displayMath(
        String.raw`U\exp(S)U^{-1} = \exp\!\left(U S U^{-1}\right)
\qquad (S \in \mathrm{Mat}(2^M,\mathbb{C}))`,
      ),
      paragraph([
        "これを ",
        math(String.raw`S = S_1, S_2`),
        " に適用し、",
        ref("sign_flip_conjugation"),
        " と ",
        ref("trace_basic_properties"),
        " (4) を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tau
&= \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right) \\
&= \mathrm{tr}\!\left(U\exp(S_1)\exp(S_2)U^{-1}\right)
   \quad (\because \text{トレースは共役で不変}) \\
&= \mathrm{tr}\!\left(\left(U\exp(S_1)U^{-1}\right)\left(U\exp(S_2)U^{-1}\right)\right)
   \quad (\because U^{-1}U = I) \\
&= \mathrm{tr}\!\left(\exp\!\left(US_1U^{-1}\right)\exp\!\left(US_2U^{-1}\right)\right) \\
&= \mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right)
   \quad (\because \text{符号反転共役})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`c^2`),
        " の決定）。まず ",
        math(String.raw`V^{-1} = c^{-1}V'^{-1}`),
        " を確かめる。",
        ref("V_is_positive_definite"),
        " Step 4 より ",
        math(String.raw`V`),
        " は可逆で逆行列 ",
        math(String.raw`V^{-1}`),
        " をもち、",
        ref("trace_of_Vprime"),
        " Step 1 より ",
        math(String.raw`V'`),
        " も可逆で逆行列 ",
        math(String.raw`V'^{-1} = \exp(-X)`),
        " をもつ。",
        math(String.raw`c \in \mathbb{C}^\times`),
        " すなわち ",
        math(String.raw`c \neq 0`),
        " なので ",
        math(String.raw`c^{-1} \in \mathbb{C}`),
        " が取れて、",
        ref("V_eq_Vprime"),
        " の ",
        math(String.raw`V = cV'`),
        " から",
      ]),
      displayMath(
        String.raw`\left(c^{-1}V'^{-1}\right)V = \left(c^{-1}V'^{-1}\right)\left(cV'\right)
= c^{-1}c\,\left(V'^{-1}V'\right) = I, \qquad
V\left(c^{-1}V'^{-1}\right) = c\,c^{-1}\left(V'V'^{-1}\right) = I`,
      ),
      paragraph([
        "（スカラー倍は行列の積と可換に前へ出せる：",
        ref("scalar_identity_commutes"),
        "。）よって ",
        math(String.raw`c^{-1}V'^{-1}`),
        " は ",
        math(String.raw`V`),
        " の左逆行列でも右逆行列でもある。逆行列は存在すれば一意である（",
        math(String.raw`AB = BA = I`),
        " かつ ",
        math(String.raw`AC = CA = I`),
        " なら ",
        math(String.raw`B = BI = B(AC) = (BA)C = IC = C`),
        "）ので",
      ]),
      displayMath(String.raw`V^{-1} = c^{-1}V'^{-1}`),
      paragraph([
        "が従う。したがって ",
        ref("trace_basic_properties"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\mathrm{tr}(V) = c\,\mathrm{tr}(V'), \qquad
\mathrm{tr}(V^{-1}) = c^{-1}\,\mathrm{tr}(V'^{-1})`,
      ),
      paragraph([
        ref("trace_of_Vprime"),
        " より ",
        math(String.raw`\mathrm{tr}(V') = \mathrm{tr}(V'^{-1}) > 0`),
        " なので、これらは ",
        math(String.raw`0`),
        " でなく、辺々割ることができて",
      ]),
      displayMath(
        String.raw`\frac{\mathrm{tr}(V)}{\mathrm{tr}(V^{-1})}
= \frac{c\,\mathrm{tr}(V')}{c^{-1}\,\mathrm{tr}(V'^{-1})}
= c^2\,\frac{\mathrm{tr}(V')}{\mathrm{tr}(V'^{-1})}
= c^2`,
      ),
      paragraph([
        "一方 Step 1・Step 2 より（",
        ref("V_is_positive_definite"),
        " より ",
        math(String.raw`\mathrm{tr}(V) > 0`),
        " なので ",
        math(String.raw`\tau = (2s_2)^{-M/2}\mathrm{tr}(V) \neq 0`),
        "）",
      ]),
      displayMath(
        String.raw`\frac{\mathrm{tr}(V)}{\mathrm{tr}(V^{-1})}
= \frac{(2s_2)^{M/2}\,\tau}{(2s_2)^{-M/2}\,\tau}
= (2s_2)^{M}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`c^2 = (2s_2)^{M}`),
        "。",
      ]),
      paragraph([
        "Step 4（符号の確定）。",
        math(String.raw`c = \mathrm{tr}(V)/\mathrm{tr}(V')`),
        " であり、",
        ref("V_is_positive_definite"),
        " より ",
        math(String.raw`\mathrm{tr}(V) \in \mathbb{R}_{>0}`),
        "、",
        ref("trace_of_Vprime"),
        " より ",
        math(String.raw`\mathrm{tr}(V') \in \mathbb{R}_{>0}`),
        " なので ",
        math(String.raw`c \in \mathbb{R}_{>0}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`s_2 = \sinh 2K_2 > 0`),
        " なので ",
        math(String.raw`(2s_2)^{M/2} \in \mathbb{R}_{>0}`),
        " であり、Step 3 の ",
        math(String.raw`c^2 = (2s_2)^M = \left((2s_2)^{M/2}\right)^2`),
        " と合わせると",
      ]),
      displayMath(
        String.raw`\left(c - (2s_2)^{M/2}\right)\left(c + (2s_2)^{M/2}\right) = 0`,
      ),
      paragraph([
        math(String.raw`c > 0`),
        " かつ ",
        math(String.raw`(2s_2)^{M/2} > 0`),
        " より第 2 因子は正で ",
        math(String.raw`0`),
        " でない。よって第 1 因子が ",
        math(String.raw`0`),
        " であり ",
        math(String.raw`c = (2s_2)^{M/2}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "M=2,3,4,5 と複数の (K1,K2) について V'^{-1}V = c I が成り立ち、その c が (2 sinh 2K2)^{M/2} に一致することを数値確認した（sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/check_04_constant_c.sage）。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_018_claim_eigenvalues_of_V",
    kind: "claim",
    origin: { path: SRC, ordinal: 20 },
    title: { tex: String.raw`V \text{ の固有値}` },
    labels: ["eigenvalues_of_V"],
    statement: [
      paragraph([
        math(String.raw`\epsilon \in \{0,1\}^{\mathcal{I}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\Lambda_\epsilon := (2\sinh 2K_2)^{M/2}
\exp\!\left(\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right)\right) \in \mathbb{R}_{>0}`,
      ),
      paragraph(["とおく。このとき"]),
      list([
        [
          math(String.raw`\text{(1)}\quad V Q_\epsilon = \Lambda_\epsilon Q_\epsilon`),
          "。とくに ",
          math(String.raw`V`),
          " は対角化可能で、その固有値は重複度を込めて ",
          math(String.raw`\{\Lambda_\epsilon\ (\text{重複度 } 2^{M-m})\}_{\epsilon}`),
          " で尽くされる（総個数 ",
          math(String.raw`2^M`),
          "）。",
        ],
        [
          math(String.raw`\text{(2)}`),
          " 固有値はすべて正の実数であり、最大のものは全ての ",
          math(String.raw`\epsilon_\mu = 1`),
          " を取ったとき、最小のものは全ての ",
          math(String.raw`\epsilon_\mu = 0`),
          " を取ったときである：",
        ],
      ]),
      displayMath(
        String.raw`\Lambda_{\max} = (2\sinh 2K_2)^{M/2}
\exp\!\left(\frac{1}{2}\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\right), \qquad
\Lambda_{\min} = (2\sinh 2K_2)^{M/2}
\exp\!\left(-\frac{1}{2}\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\right)`,
      ),
      paragraph([
        "（したがって ",
        math(String.raw`\Lambda_{\max}\Lambda_{\min} = (2\sinh 2K_2)^{M} = c^2`),
        "。）",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("constant_c_value"),
        " より ",
        math(String.raw`V = (2s_2)^{M/2}V'`),
        " であり、",
        ref("eigenvalues_of_Vprime"),
        " より ",
        math(String.raw`V'Q_\epsilon = e^{g(\epsilon)}Q_\epsilon`),
        " だから",
      ]),
      displayMath(
        String.raw`V Q_\epsilon = (2s_2)^{M/2}V'Q_\epsilon
= (2s_2)^{M/2}e^{g(\epsilon)}Q_\epsilon = \Lambda_\epsilon Q_\epsilon`,
      ),
      paragraph([
        "対角化可能性・重複度・総個数は ",
        ref("eigenvalues_of_Vprime"),
        " の Step 4 と同じ議論（",
        ref("joint_eigenspace_decomposition"),
        " (5) による直和分解）で得られる。スカラー倍は固有ベクトルを変えない。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`(2s_2)^{M/2} > 0`),
        " と ",
        math(String.raw`e^{g(\epsilon)} > 0`),
        " より ",
        math(String.raw`\Lambda_\epsilon > 0`),
        "。",
      ]),
      paragraph([
        "大小の比較。",
        math(String.raw`\Lambda_\epsilon = (2s_2)^{M/2}e^{g(\epsilon)}`),
        " で ",
        math(String.raw`(2s_2)^{M/2}`),
        " は ",
        math(String.raw`\epsilon`),
        " に依らない正の定数、",
        math(String.raw`t \mapsto e^t`),
        " は実数上の狭義単調増加関数なので、",
        math(String.raw`\Lambda_\epsilon`),
        " の大小は ",
        math(String.raw`g(\epsilon) = \sum_{\mu}\gamma(\theta_\mu)(\epsilon_\mu - \tfrac12)`),
        " の大小と一致する。",
        ref("def_gamma_theta_mu"),
        " より ",
        math(String.raw`\gamma(\theta_\mu) \geq 0`),
        " なので、各項 ",
        math(String.raw`\gamma(\theta_\mu)(\epsilon_\mu - \tfrac12)`),
        " は ",
        math(String.raw`\epsilon_\mu = 1`),
        " のとき ",
        math(String.raw`+\tfrac12\gamma(\theta_\mu)`),
        "、",
        math(String.raw`\epsilon_\mu = 0`),
        " のとき ",
        math(String.raw`-\tfrac12\gamma(\theta_\mu)`),
        " であり、前者が後者以上である。各項は独立に選べるので、和が最大になるのは全ての ",
        math(String.raw`\epsilon_\mu = 1`),
        "、最小になるのは全ての ",
        math(String.raw`\epsilon_\mu = 0`),
        " のときである。それぞれ",
      ]),
      displayMath(
        String.raw`g(1,\dots,1) = \frac{1}{2}\sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu), \qquad
g(0,\dots,0) = -\frac{1}{2}\sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)`,
      ),
      paragraph([
        "を代入して statement の ",
        math(String.raw`\Lambda_{\max}, \Lambda_{\min}`),
        " を得る。積は指数部分が打ち消し合って ",
        math(String.raw`\Lambda_{\max}\Lambda_{\min} = (2s_2)^{M}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この主張は docs/tasks/free-energy-roadmap の章 C（最大固有値）の入口になる。Λ_max の表式はそのまま自由エネルギーの主要項へ渡る。",
      ],
    },
  },
]);
