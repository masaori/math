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
&= \sum_{k=1}^{n} (AB)_{kk}
&&(\because \text{トレースの定義}) \\
&= \sum_{k=1}^{n}\sum_{j=1}^{n} A_{kj}B_{jk}
&&(\because \text{積の定義}) \\
&= \sum_{j=1}^{n}\sum_{k=1}^{n} B_{jk}A_{kj}
&&(\because \text{有限和の順序交換と } \mathbb{C} \text{ の積の可換性}) \\
&= \sum_{j=1}^{n} (BA)_{jj}
&&(\because \text{積の定義}) \\
&= \mathrm{tr}(BA)
&&(\because \text{トレースの定義})
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
&= \mathrm{tr}\bigl((PA)P^{-1}\bigr)
&&(\because \text{行列の積の結合法則}) \\
&= \mathrm{tr}\bigl(P^{-1}(PA)\bigr)
&&(\because \text{(2) 巡回性}) \\
&= \mathrm{tr}\bigl((P^{-1}P)A\bigr)
&&(\because \text{行列の積の結合法則}) \\
&= \mathrm{tr}(I_n A)
&&(\because \text{逆行列の定義 } P^{-1}P = I_n) \\
&= \mathrm{tr}(A)
&&(\because \text{単位行列との積})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "本文はこれまでトレースを定義せずに使っていなかった（008 章までに tr は現れない）。本章で初めて必要になるため、定義と必要な性質だけをここで書き下した。",
        "2026-08-31 の式変形統一で、二本の鎖に行中の \\quad(\\because …) で置かれていた根拠 10 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・参照は変えていない。",
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
        " と書け、",
        math(String.raw`Qx \in \mathrm{im}\,Q`),
        " である。",
        math(String.raw`x - Qx \in \ker Q`),
        " は次の計算による。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q(x - Qx)
&= Qx - Q^2x
&&(\because\ \text{行列の積の分配則})\\
&= Qx - Qx
&&(\because\ Q^2 = Q)\\
&= 0
&&(\because\ \text{同じ項の差は零元（加法逆元）})
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`\mathbb{C}^n = \mathrm{im}\,Q + \ker Q`),
        "。また ",
        math(String.raw`y \in \mathrm{im}\,Q \cap \ker Q`),
        " とすると、",
        math(String.raw`y = Qx`),
        " なる ",
        math(String.raw`x \in \mathbb{C}^n`),
        " が取れて",
      ]),
      displayMath(String.raw`\begin{aligned}
y
&= Qx
&&(\because\ x\ \text{の取り方})\\
&= Q^2 x
&&(\because\ Q = Q^2)\\
&= Q(Qx)
&&(\because\ \text{行列の積の結合則})\\
&= Qy
&&(\because\ Qx = y)\\
&= 0
&&(\because\ y \in \ker Q)
\end{aligned}`),
      paragraph([
        "よって交わりは ",
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
        " なる ",
        math(String.raw`x_j \in \mathbb{C}^n`),
        " が取れて",
      ]),
      displayMath(String.raw`\begin{aligned}
Qv_j
&= Q(Qx_j)
&&(\because\ v_j = Qx_j)\\
&= Q^2x_j
&&(\because\ \text{行列の積の結合則})\\
&= Qx_j
&&(\because\ Q^2 = Q)\\
&= v_j
&&(\because\ v_j = Qx_j)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`j > r`),
        " のとき ",
        math(String.raw`Qv_j = 0`),
        "（",
        math(String.raw`v_j \in \ker Q`),
        "）。よってこの基底に関する ",
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
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(Q)
&= \mathrm{tr}(P^{-1}QP)
&&(\because\ \text{トレースの基本性質 (4)：相似変換でトレースは不変。}\blkref{trace_basic_properties})\\
&= \mathrm{tr}(D)
&&(\because\ D = P^{-1}QP)\\
&= r
&&(\because\ D\ \text{の対角成分は}\ 1\ \text{が}\ r\ \text{個、}\ 0\ \text{が}\ n-r\ \text{個})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-17 の式変形統一で、Step 1 の二つの計算（x−Qx∈ker Q、交わりが零）、Step 2 の Qv_j=v_j、Step 3 のトレースの計算を、一続きの等号と行末の根拠へ揃えた。内容は変えていない。",
        "2026-09-02: Step 3 の鎖の直後に置いていた参照一覧を削り、相似変換でトレースが不変であることを使う行末の blkref へ移した。内容・式変形・根拠・参照は不変である。",
      ],
    },
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
        String.raw`\begin{aligned}
0
&= [\psi_\mu^\dagger, \psi_\mu^\dagger]_+
&&\bigl(\because\ \text{反交換関係の第 1 式}\bigr)\\
&= \psi_\mu^\dagger\psi_\mu^\dagger + \psi_\mu^\dagger\psi_\mu^\dagger
&&\bigl(\because\ \text{反交換子の定義}\bigr)\\
&= 2(\psi_\mu^\dagger)^2
&&\bigl(\because\ \text{同じ項の和}\bigr)
\end{aligned}`,
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
      displayMath(String.raw`\begin{aligned}
\psi_{-\mu}\psi_\mu^\dagger
&= I-\psi_\mu^\dagger\psi_{-\mu}
&&\left(\because\ [\psi_\mu^\dagger,\psi_{-\mu}]_+=I\ \text{と行列の加法。}\blkref{anticommutator_of_psi}\right)\\
&= I-n_\mu
&&\left(\because\ \text{フェルミオン数演算子 }n_\mu\text{ の定義。}\blkref{def_number_operator}\right)
\end{aligned}`),
      paragraph(["(3) (1)(2) を使って"]),
      displayMath(
        String.raw`\begin{aligned}
n_\mu^2
&= (\psi_\mu^\dagger\psi_{-\mu})(\psi_\mu^\dagger\psi_{-\mu})
&&\bigl(\because\ \text{フェルミオン数演算子 } n_\mu \text{ の定義}\bigr)\\
&= \psi_\mu^\dagger\left(\psi_{-\mu}\psi_\mu^\dagger\right)\psi_{-\mu}
&&\bigl(\because\ \text{行列の積の結合法則}\bigr)\\
&= \psi_\mu^\dagger\left(I - n_\mu\right)\psi_{-\mu}
&&\bigl(\because\ \text{(2)}\bigr)\\
&= \psi_\mu^\dagger\psi_{-\mu} - \psi_\mu^\dagger n_\mu \psi_{-\mu}
&&\bigl(\because\ \text{行列の積の分配法則}\bigr)\\
&= n_\mu - \psi_\mu^\dagger\left(\psi_\mu^\dagger\psi_{-\mu}\right)\psi_{-\mu}
&&\bigl(\because\ n_\mu = \psi_\mu^\dagger\psi_{-\mu}\bigr)\\
&= n_\mu - (\psi_\mu^\dagger)^2\,(\psi_{-\mu})^2
&&\bigl(\because\ \text{結合法則}\bigr)\\
&= n_\mu - 0 \cdot 0
&&\bigl(\because\ \text{(1)}\bigr)\\
&= n_\mu
&&\bigl(\because\ \text{零行列との積と差}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-08-15 の式変形統一で、(3) の鎖の先頭行（フェルミオン数演算子の定義の適用）に欠けていた行末根拠を補った。内容は変えていない。",
        "2026-08-18 の式変形統一で、(2) の反交換関係からの移項を散文で済ませず、一続き二段の式変形と行末根拠へ揃えた。内容は変えていない。",
        "2026-09-02 の式変形統一で、(1)(3) の式変形の行末根拠を aligned の独立列へ揃えた。内容は変えていない。",
        "2026-09-02: (2) の鎖の直後に置いていた参照一覧（反交換関係とフェルミオン数演算子の定義）を削り、それらを実際に使う各行末の blkref へ移した。内容・式変形・根拠・参照は不変である。",
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
{[\psi_\mu^\dagger, \psi_\nu^\dagger]_+}
&= 0
   \quad (\because \text{反交換関係の第 1 式}) \\
{[\psi_\mu^\dagger, \psi_{-\nu}]_+}
&= \delta^M_{\mu-\nu,0}\,I
   \quad (\because \text{反交換関係の第 2 式}) \\
&= 0
   \quad (\because \delta^M_{\mu-\nu,0}=0) \\
{[\psi_{-\mu}, \psi_\nu^\dagger]_+}
&= \delta^M_{-\mu+\nu,0}\,I
   \quad (\because \text{反交換関係の第 2 式と反交換子の対称性}) \\
&= 0
   \quad (\because \delta^M_{-\mu+\nu,0}=0) \\
{[\psi_{-\mu}, \psi_{-\nu}]_+}
&= 0
   \quad (\because \text{反交換関係の第 3 式})
\end{aligned}`,
      ),
      paragraph([
        "（第 3 式は ",
        ref("anticommutator_of_psi"),
        " の第 2 式を添字 ",
        math(String.raw`(\nu, -\mu)`),
        " に適用し、次の反交換子の対称性を使った。）",
      ]),
      displayMath(String.raw`\begin{aligned}
[X,Y]_+
&=XY+YX
&& (\because\ \text{反交換子の定義})\\
&=YX+XY
&& (\because\ \text{行列の加法の交換法則})\\
&=[Y,X]_+
&& (\because\ \text{反交換子の定義})
\end{aligned}`),
      paragraph([
        "すなわち、",
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
&= A\,\psi_\nu^\dagger \psi_{-\nu}
   \quad (\because \text{フェルミオン数演算子 } n_\nu \text{ の定義}) \\
&= (-\psi_\nu^\dagger A)\,\psi_{-\nu}
   \quad (\because A\psi_\nu^\dagger = -\psi_\nu^\dagger A) \\
&= -\psi_\nu^\dagger\,(A \psi_{-\nu})
   \quad (\because \text{結合法則}) \\
&= -\psi_\nu^\dagger\,(-\psi_{-\nu} A)
   \quad (\because A\psi_{-\nu} = -\psi_{-\nu}A) \\
&= \psi_\nu^\dagger \psi_{-\nu} A
   \quad (\because \text{符号の積 } (-1)(-1) = 1 \text{ と結合法則}) \\
&= n_\nu A
   \quad (\because \text{フェルミオン数演算子 } n_\nu \text{ の定義})
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
        String.raw`\begin{aligned}
n_\mu n_\nu
&= \left(\psi_\mu^\dagger \psi_{-\mu}\right) n_\nu
   \quad (\because \text{フェルミオン数演算子 } n_\mu \text{ の定義}) \\
&= \psi_\mu^\dagger\left(\psi_{-\mu} n_\nu\right)
   \quad (\because \text{結合法則}) \\
&= \psi_\mu^\dagger\left(n_\nu \psi_{-\mu}\right)
   \quad (\because \text{(1) を } A = \psi_{-\mu} \text{ へ適用}) \\
&= \left(\psi_\mu^\dagger n_\nu\right)\psi_{-\mu}
   \quad (\because \text{結合法則}) \\
&= \left(n_\nu \psi_\mu^\dagger\right)\psi_{-\mu}
   \quad (\because \text{(1) を } A = \psi_\mu^\dagger \text{ へ適用}) \\
&= n_\nu\left(\psi_\mu^\dagger\psi_{-\mu}\right)
   \quad (\because \text{結合法則}) \\
&= n_\nu n_\mu
   \quad (\because \text{フェルミオン数演算子 } n_\mu \text{ の定義})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-15 の式変形統一で、Step 1 の四つの反交換関係を根拠なしの並記から、一行一関係・行末根拠へ開いた。内容は変えていない。",
        "2026-09-01 の式変形統一で、反交換子の対称性にあった一行三等号を、3 段の行末根拠つきの鎖へ開いた。内容・参照は変えていない。",
      ],
    },
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
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(I)
&= 2^M
   \quad (\because \text{トレースの基本性質 (3)}) \\
&= 2^{M-0}
   \quad (\because M-0=M)
\end{aligned}`,
      ),
      paragraph([
        "帰納段階：",
        math(String.raw`k \geq 1`),
        " とし、相異なる ",
        math(String.raw`k-1`),
        " 個の添字については主張が成り立つと仮定する。相異なる ",
        math(String.raw`\mu_1,\dots,\mu_k \in \mathcal{I}`),
        " を取り、",
      ]),
      displayMath(String.raw`P := R_{\mu_2}^{(e_2)} R_{\mu_3}^{(e_3)}\cdots R_{\mu_k}^{(e_k)}`),
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
        " とも可換である。ゆえに単位行列とも可換であることと分配法則から ",
        math(String.raw`I-n_{\mu_j}`),
        " とも可換であり、したがって各 ",
        math(String.raw`R_{\mu_j}^{(e_j)}`),
        " および積 ",
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
   \quad (\because \text{フェルミオン数演算子 } n_{\mu_1} \text{ の定義}) \\
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
        "したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2\,\mathrm{tr}(n_{\mu_1}P)
&= \mathrm{tr}(P)
   \quad (\because \text{直前の等式を移項}) \\
\mathrm{tr}(n_{\mu_1}P)
&= \frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{両辺を }2\text{ で割る}) \\
&= \frac{1}{2}\cdot 2^{M-(k-1)}
   \quad (\because \text{帰納法の仮定}) \\
&= 2^{M-k}
   \quad (\because M-(k-1)=M-k+1)
\end{aligned}`,
      ),
      paragraph([
        "まず ",
        math(String.raw`e_1=1`),
        " の場合は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(R_{\mu_1}^{(1)}P\right)
&= \mathrm{tr}\!\left(n_{\mu_1}P\right)
   \quad (\because R_{\mu_1}^{(1)}=n_{\mu_1}) \\
&= \frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{直前に得た }\mathrm{tr}(n_{\mu_1}P)=\tfrac12\,\mathrm{tr}(P)) \\
&= \frac{1}{2}\cdot 2^{M-(k-1)}
   \quad (\because \text{帰納法の仮定}) \\
&= 2^{M-k}
   \quad (\because M-(k-1)=M-k+1)
\end{aligned}`,
      ),
      paragraph([
        "である。次に ",
        math(String.raw`e_1=0`),
        " の場合は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(R_{\mu_1}^{(0)}P\right)
&= \mathrm{tr}\!\left((I-n_{\mu_1})P\right)
   \quad (\because R_{\mu_1}^{(0)}=I-n_{\mu_1}) \\
&= \mathrm{tr}(P)-\mathrm{tr}(n_{\mu_1}P)
   \quad (\because \text{分配法則とトレースの線型性}) \\
&= \mathrm{tr}(P)-\frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{直前に得た }\mathrm{tr}(n_{\mu_1}P)=\tfrac12\,\mathrm{tr}(P)) \\
&= \frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{複素数の四則演算}) \\
&= 2^{M-k}
   \quad (\because \text{帰納法の仮定と上の冪の計算})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`e_1\in\{0,1\}`),
        " なので二つの場合は尽くされ、帰納段階が示された。したがって任意の ",
        math(String.raw`e_1,\dots,e_k\in\{0,1\}`),
        " について主張が成り立つ。",
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
R_\mu^{(1)}R_\mu^{(1)}
&= n_\mu^2
   \quad (\because R_\mu^{(1)} = n_\mu \text{ の定義と冪の記法}) \\
&= n_\mu
   \quad (\because \text{上に引いた } n_\mu^2 = n_\mu) \\
&= R_\mu^{(1)}
   \quad (\because R_\mu^{(1)} = n_\mu \text{ の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(0)}R_\mu^{(0)}
&= (I-n_\mu)^2
   \quad (\because R_\mu^{(0)} = I - n_\mu \text{ の定義と冪の記法}) \\
&= I - 2n_\mu + n_\mu^2
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= I - 2n_\mu + n_\mu
   \quad (\because \text{上に引いた } n_\mu^2 = n_\mu) \\
&= I - n_\mu
   \quad (\because -2n_\mu + n_\mu = -n_\mu) \\
&= R_\mu^{(0)}
   \quad (\because R_\mu^{(0)} = I - n_\mu \text{ の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(1)}R_\mu^{(0)}
&= n_\mu(I - n_\mu)
   \quad (\because R_\mu^{(1)},\ R_\mu^{(0)} \text{ の定義}) \\
&= n_\mu - n_\mu^2
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= n_\mu - n_\mu
   \quad (\because \text{上に引いた } n_\mu^2 = n_\mu) \\
&= 0
   \quad (\because \text{加法の逆元})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(0)}R_\mu^{(1)}
&= (I - n_\mu)n_\mu
   \quad (\because R_\mu^{(0)},\ R_\mu^{(1)} \text{ の定義}) \\
&= n_\mu - n_\mu^2
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= n_\mu - n_\mu
   \quad (\because \text{上に引いた } n_\mu^2 = n_\mu) \\
&= 0
   \quad (\because \text{加法の逆元})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(1)} + R_\mu^{(0)}
&= n_\mu + (I - n_\mu)
   \quad (\because R_\mu^{(1)},\ R_\mu^{(0)} \text{ の定義}) \\
&= I
   \quad (\because n_\mu + (-n_\mu) = 0 \text{ と零元との和})
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
        String.raw`\begin{aligned}
Q_\epsilon Q_{\epsilon'}
&= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon'_\mu)}\right)
  R_\nu^{(\epsilon_\nu)}R_\nu^{(\epsilon'_\nu)}
   \quad (\because \text{因子の可換性により添字 }\nu\text{ の二因子を隣接させる}) \\
&= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon'_\mu)}\right)\cdot 0
   \quad (\because \epsilon_\nu\neq\epsilon'_\nu\text{ と Step 0 の直交性}) \\
&= 0
   \quad (\because \text{零行列との積})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon = \epsilon'`),
        " のときは各因子が Step 0 より冪等なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Q_\epsilon^2
&= \prod_{\mu\in\mathcal I}R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon_\mu)}
   \quad (\because \text{因子の可換性}) \\
&= \prod_{\mu\in\mathcal I}R_\mu^{(\epsilon_\mu)}
   \quad (\because \text{Step 0 の冪等性を各因子へ適用}) \\
&= Q_\epsilon
   \quad (\because Q_\epsilon\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（(2) の証明）。Step 0 の ",
        math(String.raw`R_\mu^{(1)} + R_\mu^{(0)} = I`),
        " を各因子に代入し、可換な有限個の因子の積を分配法則で展開すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
I
&= \prod_{\mu \in \mathcal{I}}\left(R_\mu^{(1)} + R_\mu^{(0)}\right)
   \quad (\because \text{Step 0 の }R_\mu^{(1)}+R_\mu^{(0)}=I) \\
&= \sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} \prod_{\mu \in \mathcal{I}} R_\mu^{(\epsilon_\mu)}
   \quad (\because \text{有限積を分配法則で展開}) \\
&= \sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} Q_\epsilon
   \quad (\because Q_\epsilon\text{ の定義})
\end{aligned}`,
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
= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}\right) n_\nu R_\nu^{(\epsilon_\nu)}
\quad (\because Q_\epsilon\text{ の定義と因子の可換性})`,
      ),
      paragraph([
        math(String.raw`\epsilon_\nu = 1`),
        " なら",
      ]),
      displayMath(
        String.raw`\begin{aligned}
n_\nu R_\nu^{(1)}
&= n_\nu n_\nu \quad (\because R_\nu^{(1)}\text{ の定義}) \\
&= n_\nu \quad (\because \text{Step 0 の冪等性}) \\
&= R_\nu^{(1)} \quad (\because R_\nu^{(1)}\text{ の定義}) \\
&= \epsilon_\nu R_\nu^{(\epsilon_\nu)} \quad (\because \epsilon_\nu=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon_\nu = 0`),
        " なら",
      ]),
      displayMath(
        String.raw`\begin{aligned}
n_\nu R_\nu^{(0)}
&= n_\nu(I-n_\nu) \quad (\because R_\nu^{(0)}\text{ の定義}) \\
&= 0 \quad (\because \text{Step 0 の直交性}) \\
&= \epsilon_\nu R_\nu^{(\epsilon_\nu)} \quad (\because \epsilon_\nu=0)
\end{aligned}`,
      ),
      paragraph(["いずれの場合も"]),
      displayMath(
        String.raw`\begin{aligned}
n_\nu Q_\epsilon
&= \left(\prod_{\mu\neq\nu}R_\mu^{(\epsilon_\mu)}\right)n_\nu R_\nu^{(\epsilon_\nu)}
   \quad (\because Q_\epsilon\text{ の定義と因子の可換性}) \\
&= \left(\prod_{\mu\neq\nu}R_\mu^{(\epsilon_\mu)}\right)\epsilon_\nu R_\nu^{(\epsilon_\nu)}
   \quad (\because \text{上の二つの場合}) \\
&= \epsilon_\nu Q_\epsilon
   \quad (\because Q_\epsilon\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（(4) の証明）。",
        math(String.raw`T := \{\mu \in \mathcal{I} \mid \epsilon_\mu = 1\}`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Q_\epsilon
&= \prod_{\mu \in \mathcal{I}} R_\mu^{(\epsilon_\mu)}
   \quad (\because Q_\epsilon\text{ の定義}) \\
&= \left(\prod_{\mu \in T} R_\mu^{(1)}\right)\prod_{\mu \in \mathcal{I}\setminus T} R_\mu^{(0)}
   \quad (\because T\text{ の定義と因子の可換性}) \\
&= \left(\prod_{\mu \in T} n_\mu\right)\prod_{\mu \in \mathcal{I}\setminus T}(I - n_\mu)
   \quad (\because R_\mu^{(1)},\,R_\mu^{(0)}\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。第 2 の積を分配法則で展開すると",
      ]),
      displayMath(
        String.raw`\prod_{\mu \in \mathcal{I}\setminus T}(I - n_\mu)
= \sum_{S \subseteq \mathcal{I}\setminus T} (-1)^{|S|} \prod_{\mu \in S} n_\mu
\quad (\because \text{有限積を分配法則で展開})`,
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
   \mathrm{tr}\!\left(\prod_{\mu \in T \cup S} n_\mu\right)
   \quad (\because \text{上の展開とトレースの線型性}) \\
&= \sum_{S \subseteq \mathcal{I}\setminus T} (-1)^{|S|}\, 2^{M - |T| - |S|}
   \quad (\because \text{数演算子の積のトレース}) \\
&= 2^{M-|T|}\sum_{j=0}^{m-|T|}\binom{m-|T|}{j}(-1)^{j}\,2^{-j}
   \quad (\because |\mathcal{I}\setminus T| = m - |T| \text{ で、大きさ } j \text{ の部分集合は } \tbinom{m-|T|}{j} \text{ 個}) \\
&= 2^{M-|T|}\left(1 - \tfrac{1}{2}\right)^{m-|T|}
   \quad (\because \text{二項定理}) \\
&= 2^{M-|T|}\cdot 2^{-(m-|T|)}
   \quad (\because 1-\tfrac12=\tfrac12=2^{-1}\text{ と冪の法則}) \\
&= 2^{M-m}
   \quad (\because \text{同じ底の冪の積})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Q_\epsilon`),
        " は Step 1 より冪等である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\dim_{\mathbb{C}}\mathrm{im}\,Q_\epsilon
&= \mathrm{tr}(Q_\epsilon)
   \quad (\because \text{冪等行列のトレースは像の次元。} Q_\epsilon \text{ は Step 1 より冪等}) \\
&= 2^{M-m}
   \quad (\because \text{上で計算した } \mathrm{tr}(Q_\epsilon))
\end{aligned}`,
      ),
      paragraph([ref("trace_of_idempotent"), " を引いた。"]),
      paragraph([
        "Step 5（(5) の証明）。(2) より任意の ",
        math(String.raw`x \in \mathbb{C}^{2^M}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x
&= Ix
   \quad (\because I\text{ は単位行列}) \\
&= \left(\sum_\epsilon Q_\epsilon\right)x
   \quad (\because \text{(2)}) \\
&= \sum_\epsilon Q_\epsilon x
   \quad (\because \text{行列作用の線型性})
\end{aligned}`,
      ),
      paragraph([
        "であり、各 ", math(String.raw`Q_\epsilon x`), " は ",
        math(String.raw`\mathrm{im}\,Q_\epsilon`),
        " に属するので、これらの像の和は全体を張る。直和であることを見るために ",
        math(String.raw`\sum_\epsilon y_\epsilon = 0`),
        "（",
        math(String.raw`y_\epsilon \in \mathrm{im}\,Q_\epsilon`),
        "）とする。各 ", math(String.raw`\epsilon`), " に対して ",
        math(String.raw`y_\epsilon = Q_\epsilon x_\epsilon`),
        " となる ", math(String.raw`x_\epsilon\in\mathbb C^{2^M}`),
        " を取る。(1) より、各 ",
        math(String.raw`\epsilon,\epsilon'`), " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Q_{\epsilon'}y_\epsilon
&= Q_{\epsilon'}Q_\epsilon x_\epsilon
   \quad (\because y_\epsilon=Q_\epsilon x_\epsilon) \\
&=
\begin{cases}
0, & \epsilon\ne\epsilon', \\
Q_\epsilon x_\epsilon, & \epsilon=\epsilon'
\end{cases}
   \quad (\because \text{(1) の直交性と冪等性}) \\
&=
\begin{cases}
0, & \epsilon\ne\epsilon', \\
y_\epsilon, & \epsilon=\epsilon'
\end{cases}
   \quad (\because y_\epsilon=Q_\epsilon x_\epsilon)
\end{aligned}`,
      ),
      paragraph([
        "である。したがって各 ",
        math(String.raw`\epsilon'`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&= Q_{\epsilon'}0
   \quad (\because \text{線型写像は零ベクトルを零ベクトルへ写す}) \\
&= Q_{\epsilon'}\left(\sum_\epsilon y_\epsilon\right)
   \quad (\because \sum_\epsilon y_\epsilon=0) \\
&= \sum_\epsilon Q_{\epsilon'}y_\epsilon
   \quad (\because \text{行列作用の線型性}) \\
&= y_{\epsilon'}
   \quad (\because \text{(1) の直交性と冪等性})
\end{aligned}`,
      ),
      paragraph(["が成り立つので、和は直和である。"]),
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
        "2026-08-17 の式変形統一で、Step 4 末尾の dim im Q_ε = tr(Q_ε) = 2^{M−m} を、一続きの等号と行末の根拠へ揃えた。内容は変えていない。",
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
   \quad (\because \text{有限和の線型性で } Q_\epsilon \text{ を右へくくり出す}) \\
&= g(\epsilon)\,Q_\epsilon
   \quad (\because g(\epsilon) \text{ の定義})
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
        String.raw`\begin{aligned}
X^{k+1}Q_\epsilon
&= X\left(X^k Q_\epsilon\right)
   \quad (\because \text{冪の定義 } X^{k+1} = X X^k \text{ と行列の積の結合法則}) \\
&= X\left(g(\epsilon)^k Q_\epsilon\right)
   \quad (\because \text{帰納法の仮定}) \\
&= g(\epsilon)^k\left(X Q_\epsilon\right)
   \quad (\because \text{スカラー倍と行列の積の交換}) \\
&= g(\epsilon)^{k+1} Q_\epsilon
   \quad (\because \text{Step 1 の } X Q_\epsilon = g(\epsilon) Q_\epsilon \text{ と冪の定義})
\end{aligned}`,
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
        String.raw`\begin{aligned}
E_K Q_\epsilon
&= \sum_{k=0}^{K}\frac{1}{k!}X^k Q_\epsilon
   \quad (\because E_K \text{ の定義と行列の積の分配法則}) \\
&= \sum_{k=0}^{K}\frac{1}{k!}\,g(\epsilon)^k Q_\epsilon
   \quad (\because \text{Step 2 を各項へ適用}) \\
&= \left(\sum_{k=0}^{K}\frac{g(\epsilon)^k}{k!}\right) Q_\epsilon
   \quad (\because \text{有限和の線型性で } Q_\epsilon \text{ を右へくくり出す})
\end{aligned}`,
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
        " (1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Q_\epsilon y
&= Q_\epsilon^2 x
   \quad (\because y = Q_\epsilon x) \\
&= Q_\epsilon x
   \quad (\because \text{(1) の冪等性}) \\
&= y
   \quad (\because y = Q_\epsilon x)
\end{aligned}`,
      ),
      paragraph(["だから"]),
      displayMath(
        String.raw`\begin{aligned}
V' y
&= V' Q_\epsilon y
   \quad (\because \text{上の } Q_\epsilon y = y) \\
&= e^{g(\epsilon)} Q_\epsilon y
   \quad (\because \text{Step 3 の } V' Q_\epsilon = e^{g(\epsilon)} Q_\epsilon) \\
&= e^{g(\epsilon)} y
   \quad (\because \text{上の } Q_\epsilon y = y)
\end{aligned}`,
      ),
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
        " は可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(X)\exp(-X)
&= \exp\bigl(X+(-X)\bigr)
   \quad (\because \text{指数行列の積の定理}) \\
&= \exp(0)
   \quad (\because \text{加法の逆元}) \\
&= I
   \quad (\because \exp(0)=I)
\end{aligned}`,
      ),
      paragraph([
        ref("theorem_exp_product"),
        "、",
        ref("theorem_exp_zero"),
        "。同様に",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-X)\exp(X)
&= \exp\bigl((-X)+X\bigr)
   \quad (\because \text{指数行列の積の定理}) \\
&= \exp(0)
   \quad (\because \text{加法の逆元}) \\
&= I
   \quad (\because \exp(0)=I)
\end{aligned}`,
      ),
      paragraph([
        "だから ",
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
\exp\!\left(\gamma(\theta_\mu)\left(\epsilon_\mu - \tfrac{1}{2}\right)\right)
\quad (\because \text{実数の指数法則})`,
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
   + \exp\!\left(+\tfrac{\gamma(\theta_\mu)}{2}\right)\right)
   \quad \left(\because \text{各 }\epsilon_\mu\in\{0,1\}\text{ の独立な選択による有限積の展開}\right) \\
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
        String.raw`\begin{aligned}
\mathrm{tr}(V'^{-1})
&= 2^{M-m}\prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{-\gamma(\theta_\mu)}{2}\right)
   \quad (\because \text{Steps 1--3 を }-X\text{ へ適用}) \\
&= 2^{M-m}\prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
   \quad (\because \cosh\text{ は偶関数}) \\
&= \mathrm{tr}(V')
   \quad (\because \text{Steps 2--3 の }\mathrm{tr}(V')\text{ の計算})
\end{aligned}`,
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
        "。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
&\geq 2
   \quad (\because \cosh x\geq1) \\
&>0
   \quad (\because 2>0)
\end{aligned}`,
      ),
      paragraph([
        "である。さらに ",
        math(String.raw`2^{M-m}>0`),
        " なので、正の因子の有限積である Step 2--3 の表示から ",
        math(String.raw`\mathrm{tr}(V')>0`),
        " を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-15 の式変形統一で、フェルミオン数演算子の積和を指数関数の有限積へ分解する鎖の先頭行に、各二値成分の独立な選択による有限積の展開という行末根拠を補った。内容は変えていない。",
      ],
    },
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
        ref("def_complex_conjugate"),
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
        "(1) 成分計算による。任意の成分 ",
        math(String.raw`(k,l)`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
((AB)^*)_{kl}
&= \overline{(AB)_{lk}}
   \quad (\because \text{共役転置の定義}) \\
&= \overline{\textstyle\sum_j A_{lj}B_{jk}}
   \quad (\because \text{行列積の定義}) \\
&= \textstyle\sum_j \overline{A_{lj}B_{jk}}
   \quad (\because \text{複素共役は和を保つ}) \\
&= \textstyle\sum_j \overline{A_{lj}}\,\overline{B_{jk}}
   \quad (\because \text{複素共役は積を保つ}) \\
&= \textstyle\sum_j \overline{B_{jk}}\,\overline{A_{lj}}
   \quad (\because \mathbb{C}\text{ の積の可換性}) \\
&= \textstyle\sum_j (B^*)_{kj}(A^*)_{jl}
   \quad (\because \text{共役転置の定義}) \\
&= (B^*A^*)_{kl}
   \quad (\because \text{行列積の定義})
\end{aligned}`,
      ),
      paragraph([
        "（複素共役が和と積を保つことは ",
        ref("conjugation_is_ring_homomorphism"),
        " による）。第 2 式も同様。",
      ]),
      paragraph([
        "(2) 任意の ",
        math(String.raw`A\in\mathrm{Mat}(n,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A^*\|
&= \sqrt{\textstyle\sum_{k,l}|(A^*)_{kl}|^2}
   \quad (\because \text{行列ノルムの定義}) \\
&= \sqrt{\textstyle\sum_{k,l}|\overline{A_{lk}}|^2}
   \quad (\because \text{共役転置の定義}) \\
&= \sqrt{\textstyle\sum_{k,l}|A_{lk}|^2}
   \quad (\because \text{複素共役は絶対値を保つ}) \\
&= \sqrt{\textstyle\sum_{k,l}|A_{kl}|^2}
   \quad (\because (k,l)\mapsto(l,k)\text{ は添字集合の全単射}) \\
&= \|A\|
   \quad (\because \text{行列ノルムの定義})
\end{aligned}`,
      ),
      paragraph([
        "ここで行列ノルムの定義は ",
        ref("def_matrix_norm"),
        "、複素共役が絶対値を保つことは ",
        ref("abs_basic_properties"),
        " による。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`A_N\to A`),
        " と仮定する。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A_N^*-A^*\|
&= \|(A_N-A)^*\|
   \quad (\because \text{(1) の共役転置の線型性}) \\
&= \|A_N-A\|
   \quad (\because \text{(2)}) \\
&\longrightarrow 0
   \quad (\because A_N\to A\ \text{の仮定})
\end{aligned}`,
      ),
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
        "(1) まずエルミート性。部分和を ",
        math(String.raw`E_K := \sum_{k=0}^{K}\frac{1}{k!}S^k`),
        " と置く。任意の ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(S^k)^*
&= (S^*)^k
   \quad (\because \text{積の共役転置 } (AB)^* = B^*A^* \text{ を } k \text{ 回繰り返す}) \\
&= S^k
   \quad (\because S \text{ はエルミート、すなわち } S^* = S)
\end{aligned}`,
      ),
      paragraph([
        "（積の共役転置は ",
        ref("star_preserves_norm_and_limits"),
        " (1) 第 1 式による）。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_K^*
&= \Bigl(\textstyle\sum_{k=0}^{K}\frac{1}{k!}S^k\Bigr)^*
   \quad (\because E_K \text{ の定義}) \\
&= \textstyle\sum_{k=0}^{K}\overline{\left(\frac{1}{k!}\right)}\,(S^k)^*
   \quad (\because \text{共役転置の線型性を和の各項へ適用}) \\
&= \textstyle\sum_{k=0}^{K}\frac{1}{k!}\,(S^k)^*
   \quad (\because 1/k! \in \mathbb{R} \text{ なので } \overline{1/k!} = 1/k!) \\
&= \textstyle\sum_{k=0}^{K}\frac{1}{k!}\,S^k
   \quad (\because \text{上で得た } (S^k)^* = S^k) \\
&= E_K
   \quad (\because E_K \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "（共役転置の線型性は ",
        ref("star_preserves_norm_and_limits"),
        " (1) 第 2 式による）。",
        ref("exp_converges"),
        " より ",
        math(String.raw`E_K \to \exp(S)`),
        " であり、",
        ref("star_preserves_norm_and_limits"),
        " (3) より ",
        math(String.raw`E_K^* \to \exp(S)^*`),
        "。上の等式 ",
        math(String.raw`E_K^* = E_K`),
        " より、同じ点列 ",
        math(String.raw`E_K`),
        " が ",
        math(String.raw`\exp(S)^*`),
        " と ",
        math(String.raw`\exp(S)`),
        " の両方へ収束するから、",
        ref("matrix_norm_triangle_inequality"),
        " (4)（極限の一意性）より ",
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
        " は自分自身と可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(S/2)\exp(S/2)
&= \exp(S/2 + S/2)
   \quad (\because \text{可換な行列の指数の積}) \\
&= \exp(S)
   \quad (\because S/2 + S/2 = S)
\end{aligned}`,
      ),
      paragraph([
        "（可換な行列の指数の積は ",
        ref("theorem_exp_product"),
        " による）。さらに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(S/2)\exp(-S/2)
&= \exp\bigl(S/2 + (-S/2)\bigr)
   \quad (\because \text{可換な行列の指数の積}) \\
&= \exp(0)
   \quad (\because S/2 + (-S/2) = 0) \\
&= I
   \quad (\because \text{零行列の指数})
\end{aligned}`,
      ),
      paragraph([
        "（零行列の指数は ",
        ref("theorem_exp_zero"),
        " による）ので ",
        math(String.raw`\exp(S/2)`),
        " は可逆である。よって ",
        math(String.raw`x \in \mathbb{C}^n\setminus\{0\}`),
        " に対し ",
        math(String.raw`w := \exp(S/2)x \neq 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*\exp(S)x
&= x^*\bigl(\exp(S/2)\exp(S/2)\bigr)x
   \quad (\because \text{上で得た } \exp(S/2)\exp(S/2) = \exp(S)) \\
&= x^*\exp(S/2)^*\exp(S/2)x
   \quad (\because \text{上で示した } \exp(S/2)^* = \exp(S/2)) \\
&= \left(\exp(S/2)x\right)^*\left(\exp(S/2)x\right)
   \quad (\because \text{積の共役転置を } n \times 1 \text{ 行列 } x \text{ へ適用}) \\
&= w^* w
   \quad (\because w \text{ の定義}) \\
&= \textstyle\sum_{k=1}^{n}\overline{w_k}\,w_k
   \quad (\because \text{行列積の定義（} 1 \times 1 \text{ 成分）}) \\
&= \textstyle\sum_{k=1}^{n}|w_k|^2
   \quad (\because \overline{z}\,z = |z|^2) \\
&= \|w\|^2
   \quad (\because \text{ベクトルノルムの定義})
\end{aligned}`,
      ),
      paragraph([
        "（積の共役転置は ",
        ref("star_preserves_norm_and_limits"),
        " (1) 第 1 式による）。",
        math(String.raw`w \neq 0`),
        " なのでどれかの ",
        math(String.raw`w_k \neq 0`),
        " であり、非負項の和が正の項を含むから ",
        math(String.raw`\|w\|^2 > 0`),
        "。よって ",
        math(String.raw`x^*\exp(S)x > 0`),
        " である。",
      ]),
      paragraph([
        "(2) 共役転置について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(B^*AB)^*
&= B^*A^*B^{**}
   \quad (\because \text{積の共役転置}) \\
&= B^*A^*B
   \quad (\because B^{**}=B) \\
&= B^*AB
   \quad (\because A^*=A)
\end{aligned}`,
      ),
      paragraph([
        "（積の共役転置は ",
        ref("star_preserves_norm_and_limits"),
        " (1) 第 1 式による）のでエルミートである。",
        math(String.raw`x \neq 0`),
        " なら ",
        math(String.raw`B`),
        " が可逆なので ",
        math(String.raw`Bx \neq 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*(B^*AB)x
&= (Bx)^*A(Bx)
   \quad (\because \text{積の共役転置}) \\
&>0
   \quad (\because A\ \text{は正定値かつ}\ Bx\ne0)
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        math(String.raw`\alpha\in\mathbb{R}_{>0}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\alpha A)^*
&= \overline{\alpha}A^*
   \quad (\because \text{共役転置の線型性}) \\
&= \alpha A^*
   \quad (\because \alpha\in\mathbb{R}) \\
&= \alpha A
   \quad (\because A^*=A)
\end{aligned}`,
      ),
      paragraph(["よりエルミートである。また ", math(String.raw`x\ne0`), " ならば"]),
      displayMath(
        String.raw`\begin{aligned}
x^*(\alpha A)x
&= \alpha(x^*Ax)
   \quad (\because \text{スカラー倍と行列積の結合則}) \\
&>0
   \quad (\because \alpha>0\ \text{かつ}\ x^*Ax>0)
\end{aligned}`,
      ),
      paragraph([
        "(4) ",
        math(String.raw`e_k \in \mathbb{C}^n`),
        " を第 ",
        math(String.raw`k`),
        " 標準基底ベクトルとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A_{kk}
&= e_k^*Ae_k
   \quad (\because \text{標準基底ベクトルによる対角成分の表示}) \\
&>0
   \quad (\because A\ \text{は正定値かつ}\ e_k\ne0)
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(A)
&= \sum_{k=1}^{n}A_{kk}
   \quad (\because \text{トレースの定義}) \\
&>0
   \quad (\because n\ge1\ \text{かつ各}\ A_{kk}>0)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`A`),
        " はエルミートなので各 ",
        math(String.raw`A_{kk}`),
        " は実数であり、よって ",
        math(String.raw`\mathrm{tr}(A)\in\mathbb{R}_{>0}`),
        " である。",
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
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^x
   \quad (\because \sigma^x \text{ の行列表示})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^z
   \quad (\because \sigma^z \text{ の行列表示})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^z
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示}) \\
&= \begin{pmatrix}0&-1\\1&0\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^y
   \quad (\because \sigma^y \text{ の行列表示})
\end{aligned}`,
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
   \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y\right)
   \quad (\because Z_m,\ Y_m \text{ の定義}) \\
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\right)\left(\sigma_1^x\cdots\sigma_{m-1}^x\right)
   \sigma_m^z\sigma_m^y
   \quad (\because \sigma_m^z \text{ は } \sigma_j^x\ (j<m) \text{ と可換}) \\
&= \sigma_m^z\sigma_m^y
   \quad (\because \sigma_j^x\sigma_j^x = I) \\
&= -i\,\sigma_m^x
   \quad (\because \text{Step 0})
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
H_2
&= \sum_{m=1}^{M} Z_mY_m
   \quad (\because H_2 \text{ の定義}) \\
&= \sum_{m=1}^{M} (-i\,\sigma_m^x)
   \quad (\because \text{上で得た } Z_mY_m = -i\,\sigma_m^x) \\
&= -i\sum_{m=1}^{M}\sigma_m^x
   \quad (\because \text{スカラー倍の和の分配})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
S_2
&= iK_2^*H_2
   \quad (\because S_2 \text{ の定義}) \\
&= iK_2^*\left(-i\sum_{m=1}^{M}\sigma_m^x\right)
   \quad (\because \text{上で得た } H_2 \text{ の表示}) \\
&= i(-i)\,K_2^*\sum_{m=1}^{M}\sigma_m^x
   \quad (\because \text{スカラー倍の交換}) \\
&= K_2^*\sum_{m=1}^{M}\sigma_m^x
   \quad (\because i\cdot(-i) = 1)
\end{aligned}`,
      ),
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
   \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^x\,\sigma_{m+1}^z\right)
   \quad (\because Y_m,\ Z_{m+1} \text{ の定義}) \\
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
&= \left(\sigma_1^x\sigma_2^x\cdots\sigma_{M-1}^x\,\sigma_M^y\right)\sigma_1^z
   \quad (\because Y_M,\ Z_1 \text{ の定義}) \\
&= \left(\sigma_1^x\sigma_1^z\right)\sigma_2^x\cdots\sigma_{M-1}^x\,\sigma_M^y
   \quad (\because \sigma_1^z \text{ は他の因子と可換}) \\
&= -i\,\sigma_1^y\,\sigma_2^x\cdots\sigma_{M-1}^x\,\sigma_M^y
   \quad (\because \text{Step 0}) \\
&= -i\,G
   \quad (\because G \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "これらと ",
        ref("def_V1_pm"),
        " の ",
        math(String.raw`H_1^{(\pm)}`),
        " の定義を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_1^{(\pm)}
&= iK_1H_1^{(\pm)}
   \quad (\because S_1^{(\pm)} \text{ の定義}) \\
&= iK_1\left(\sum_{m=1}^{M-1} Y_mZ_{m+1} \mp Y_MZ_1\right)
   \quad (\because H_1^{(\pm)} \text{ の定義}) \\
&= iK_1\left(\sum_{m=1}^{M-1}\left(-i\,\sigma_m^z\sigma_{m+1}^z\right) \mp (-i\,G)\right)
   \quad (\because \text{上で得た } Y_mZ_{m+1},\ Y_MZ_1 \text{ の表示}) \\
&= i(-i)\,K_1\left(\sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z \mp G\right)
   \quad (\because \text{スカラー倍の和の分配と交換}) \\
&= K_1\sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z \mp K_1\,G
   \quad (\because i\cdot(-i) = 1 \text{ と分配則})
\end{aligned}`,
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
        "2026-08-15 の式変形統一で、Step 1 の Z_mY_m の鎖と Step 2 の Y_mZ_{m+1} の鎖の先頭行（定義の適用）に欠けていた行末根拠を補った。内容は変えていない。",
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
      paragraph(["Step 1（表示）。"]),
      displayMath(String.raw`\begin{aligned}
V
&= (V_1^{(\pm)})^{1/2}\,V_2\,(V_1^{(\pm)})^{1/2}
   \quad (\because V \text{ の定義}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)V_2\,\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because (V_1^{(\pm)})^{1/2} \text{ の規約}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)(2\sinh 2K_2)^{M/2}
   \exp\!\left(K_2^*\textstyle\sum_{m}\sigma_m^x\right)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because V_2 \text{ の記号の定義}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)(2s_2)^{M/2}\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{実対称性の Step 1: 指数の中身は } S_2\text{。}s_2 := \sinh 2K_2) \\
&= (2s_2)^{M/2}\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{スカラー行列は全行列と可換})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
V\,W
&= (2s_2)^{M/2}\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   (2s_2)^{-M/2}\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{Step 1 の表示と } W \text{ の定義}) \\
&= (2s_2)^{M/2}(2s_2)^{-M/2}\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)
   \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{スカラー行列は全行列と可換}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)
   \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because (2s_2)^{M/2}(2s_2)^{-M/2} = 1) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)
   \exp\!\left(\tfrac12 S_1^{(\pm)}-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。}\tfrac12 S_1^{(\pm)} \text{ と }-\tfrac12 S_1^{(\pm)} \text{ は可換}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \exp(O) = I) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。}S_2 \text{ と }-S_2 \text{ は可換}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \exp(O) = I) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。}\tfrac12 S_1^{(\pm)} \text{ と }-\tfrac12 S_1^{(\pm)} \text{ は可換}) \\
&= I
   \quad (\because \exp(O) = I)
\end{aligned}`),
      paragraph([
        "これが statement の表示である（",
        math(String.raw`V_2`),
        " の記号の定義は ",
        ref("def_transfer_matrix_symbols"),
        "、指数の中身が ",
        math(String.raw`S_2`),
        " に等しいことは ",
        ref("iH_is_real_symmetric"),
        " の Step 1、スカラーを前へ出す操作は ",
        ref("scalar_identity_commutes"),
        "）。",
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
      paragraph(["Step 3（正定値性）。"]),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
&= B A B
   \quad (\because A,\ B \text{ の定義}) \\
&= B^* A B
   \quad (\because B \text{ はエルミート: } B^* = B)
\end{aligned}`),
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
        math(String.raw`W := (2s_2)^{-M/2}\,\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)
\exp\!\left(-S_2\right)\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
W\,V
&= (2s_2)^{-M/2}\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   (2s_2)^{M/2}\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because W \text{ の定義と Step 1 の表示}) \\
&= (2s_2)^{-M/2}(2s_2)^{M/2}\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)
   \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{スカラー行列は全行列と可換}) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)
   \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because (2s_2)^{-M/2}(2s_2)^{M/2} = 1) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)
   \exp\!\left(-\tfrac12 S_1^{(\pm)} + \tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。} -\tfrac12 S_1^{(\pm)} \text{ と } \tfrac12 S_1^{(\pm)} \text{ は可換}) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \exp(O) = I) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2 + S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。} -S_2 \text{ と } S_2 \text{ は可換}) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \exp(O) = I) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)} + \tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。} -\tfrac12 S_1^{(\pm)} \text{ と } \tfrac12 S_1^{(\pm)} \text{ は可換}) \\
&= I
   \quad (\because \exp(O) = I)
\end{aligned}`),
      paragraph([
        "（スカラーを前へ出す操作は ",
        ref("scalar_identity_commutes"),
        "、可換行列の exp 積公式は ",
        ref("theorem_exp_product"),
        "、",
        math(String.raw`\exp(O) = I`),
        " は ",
        ref("theorem_exp_zero"),
        "。）以上の二つの鎖から ",
        math(String.raw`V\,W = I`),
        " と ",
        math(String.raw`W\,V = I`),
        " がともに成り立つから ",
        math(String.raw`V`),
        " は可逆で、",
      ]),
      displayMath(
        String.raw`V^{-1} = W = (2s_2)^{-M/2}\,\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)
\exp\!\left(-S_2\right)\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)`,
      ),
      paragraph([
        "である。",
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
        " なので、各サイト ",
        math(String.raw`m`),
        " で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^x\sigma_m^x
&= I
   \quad (\because\ \text{パウリ行列の積}), \\
\sigma_m^z\sigma_m^z
&= I
   \quad (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。したがって ",
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
        String.raw`\begin{aligned}
F\sigma_k^x F^{-1}
&= \sigma_k^z\sigma_k^x\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^x\text{ と可換}) \\
&= -\sigma_k^x\sigma_k^z\sigma_k^z
   \quad (\because\ \text{パウリ行列の積}) \\
&= -\sigma_k^x
   \quad (\because\ \text{パウリ行列の積}), \\
F\sigma_k^y F^{-1}
&= \sigma_k^z\sigma_k^y\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^y\text{ と可換}) \\
&= -\sigma_k^y\sigma_k^z\sigma_k^z
   \quad (\because\ \text{パウリ行列の積}) \\
&= -\sigma_k^y
   \quad (\because\ \text{パウリ行列の積}), \\
F\sigma_k^z F^{-1}
&= \sigma_k^z\sigma_k^z\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^z\text{ と可換}) \\
&= \sigma_k^z
   \quad (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`E`),
        " は奇数番目の因子にだけ ",
        math(String.raw`\sigma^x`),
        " をもつ。したがって ", math(String.raw`k`),
        " が偶数なら全因子が ", math(String.raw`\sigma_k^a`),
        " と可換であり、", math(String.raw`k`),
        " が奇数なら第 ", math(String.raw`k`),
        " 因子だけを計算すればよい。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E\sigma_k^aE^{-1}
&= \sigma_k^a
&& (\because\ k\text{ が偶数なら }E\text{ の全因子と可換}),\\
E\sigma_k^xE^{-1}
&= \sigma_k^x\sigma_k^x\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= \sigma_k^x
&& (\because\ \text{パウリ行列の積}),\\
E\sigma_k^yE^{-1}
&= \sigma_k^x\sigma_k^y\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= -\sigma_k^y\sigma_k^x\sigma_k^x
&& (\because\ \text{パウリ行列の積})\\
&= -\sigma_k^y
&& (\because\ \text{パウリ行列の積}),\\
E\sigma_k^zE^{-1}
&= \sigma_k^x\sigma_k^z\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= -\sigma_k^z\sigma_k^x\sigma_k^x
&& (\because\ \text{パウリ行列の積})\\
&= -\sigma_k^z
&& (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        "この 2 つを合成して（",
        math(String.raw`U X U^{-1} = E(FXF^{-1})E^{-1}`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U\sigma_k^x U^{-1}
&= E\left(F\sigma_k^xF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= E(-\sigma_k^x)E^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= -\sigma_k^x
   \quad (\because\ E\sigma_k^xE^{-1}=\sigma_k^x), \\
U\sigma_k^y U^{-1}
&= E\left(F\sigma_k^yF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= -E\sigma_k^yE^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= \begin{cases}+\sigma_k^y & (k\ \text{奇数}) \\ -\sigma_k^y & (k\ \text{偶数})\end{cases}
   \quad (\because\ E\text{ による共役の場合分け}), \\
U\sigma_k^z U^{-1}
&= E\left(F\sigma_k^zF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= E\sigma_k^zE^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= \begin{cases}-\sigma_k^z & (k\ \text{奇数}) \\ +\sigma_k^z & (k\ \text{偶数})\end{cases}
   \quad (\because\ E\text{ による共役の場合分け})
\end{aligned}`,
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
   \quad (\because\ \text{Step 1 を }Z_m\text{ の各因子に適用}) \\
&= -\,Z_m
   \quad (\because\ m\ \text{の偶奇ごとに符号を計算}), \\
U Y_m U^{-1}
&= (-1)^{m-1}\cdot\begin{cases}+1 & (m\ \text{奇数}) \\ -1 & (m\ \text{偶数})\end{cases}\ Y_m
   \quad (\because\ \text{Step 1 を }Y_m\text{ の各因子に適用}) \\
&= +\,Y_m
   \quad (\because\ m\ \text{の偶奇ごとに符号を計算})
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
        String.raw`\begin{aligned}
U\left(Y_j Z_k\right)U^{-1}
&= \left(U Y_j U^{-1}\right)\left(U Z_k U^{-1}\right)
   \quad (\because\ \text{共役は積を保つ}) \\
&= (+Y_j)(-Z_k)
   \quad (\because\ \text{Step 2}) \\
&= -\,Y_j Z_k
   \quad (\because\ \text{スカラー倍と行列積の両立}), \\
U\left(Z_j Y_j\right)U^{-1}
&= \left(U Z_j U^{-1}\right)\left(U Y_j U^{-1}\right)
   \quad (\because\ \text{共役は積を保つ}) \\
&= (-Z_j)(+Y_j)
   \quad (\because\ \text{Step 2}) \\
&= -\,Z_j Y_j
   \quad (\because\ \text{スカラー倍と行列積の両立})
\end{aligned}`,
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
        String.raw`\begin{aligned}
U S_1^{(\pm)} U^{-1}
&= iK_1\,U H_1^{(\pm)} U^{-1}
   \quad (\because\ S_1^{(\pm)}=iK_1H_1^{(\pm)}\ \text{かつ共役はスカラー倍を保つ}) \\
&= -iK_1H_1^{(\pm)}
   \quad (\because\ \text{Step 3}) \\
&= -\,S_1^{(\pm)}
   \quad (\because\ S_1^{(\pm)}=iK_1H_1^{(\pm)}), \\
U S_2 U^{-1}
&= iK_2^*\,U H_2 U^{-1}
   \quad (\because\ S_2=iK_2^*H_2\ \text{かつ共役はスカラー倍を保つ}) \\
&= -iK_2^*H_2
   \quad (\because\ \text{Step 3}) \\
&= -\,S_2
   \quad (\because\ S_2=iK_2^*H_2)
\end{aligned}`,
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
   \quad (\because\ \tau \text{ の定義})
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
        String.raw`\begin{aligned}
\mathrm{tr}(V^{-1})
&= (2s_2)^{-M/2}\,
   \mathrm{tr}\!\left(\exp\!\left(-\tfrac12 S_1\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1\right)\right)
   \quad (\because \text{トレースの線型性}) \\
&= (2s_2)^{-M/2}\,
   \mathrm{tr}\!\left(\exp\!\left(-\tfrac12 S_1\right)\exp\!\left(-\tfrac12 S_1\right)\exp(-S_2)\right)
   \quad (\because \text{トレースの巡回性}) \\
&= (2s_2)^{-M/2}\,\mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right)
   \quad \left(\because \exp\!\left(-\tfrac12 S_1\right)^2=\exp(-S_1)\right)
\end{aligned}`,
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
&= \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)
   \quad (\because\ \tau \text{ の定義}) \\
&= \mathrm{tr}\!\left(U\exp(S_1)\exp(S_2)U^{-1}\right)
   \quad (\because \text{トレースは共役で不変}) \\
&= \mathrm{tr}\!\left(\left(U\exp(S_1)U^{-1}\right)\left(U\exp(S_2)U^{-1}\right)\right)
   \quad (\because U^{-1}U = I) \\
&= \mathrm{tr}\!\left(\exp\!\left(US_1U^{-1}\right)\exp\!\left(US_2U^{-1}\right)\right)
   \quad \left(\because \text{上の等式 } U\exp(S)U^{-1} = \exp\!\left(USU^{-1}\right)\right) \\
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
        String.raw`\begin{aligned}
\left(c^{-1}V'^{-1}\right)V
&= \left(c^{-1}V'^{-1}\right)\left(cV'\right)
   \quad (\because\ V = cV') \\
&= c^{-1}c\,\left(V'^{-1}V'\right)
   \quad (\because \text{スカラー倍は行列の積と可換に前へ出せる}) \\
&= 1\cdot\left(V'^{-1}V'\right)
   \quad (\because\ c^{-1}c = 1) \\
&= V'^{-1}V'
   \quad (\because \text{スカラー } 1 \text{ の積}) \\
&= I
   \quad (\because\ V'^{-1} \text{ は } V' \text{ の逆行列})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
V\left(c^{-1}V'^{-1}\right)
&= \left(cV'\right)\left(c^{-1}V'^{-1}\right)
   \quad (\because\ V = cV') \\
&= c\,c^{-1}\left(V'V'^{-1}\right)
   \quad (\because \text{スカラー倍は行列の積と可換に前へ出せる}) \\
&= 1\cdot\left(V'V'^{-1}\right)
   \quad (\because\ c\,c^{-1} = 1) \\
&= V'V'^{-1}
   \quad (\because \text{スカラー } 1 \text{ の積}) \\
&= I
   \quad (\because\ V'^{-1} \text{ は } V' \text{ の逆行列})
\end{aligned}`,
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
        " なら次の鎖で一意である）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
B
&=BI
   \quad (\because \text{単位行列}) \\
&=B(AC)
   \quad (\because AC=I) \\
&=(BA)C
   \quad (\because \text{結合則}) \\
&=IC
   \quad (\because BA=I) \\
&=C
   \quad (\because \text{単位行列})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(String.raw`V^{-1} = c^{-1}V'^{-1}`),
      paragraph([
        "が従う。したがって ",
        ref("trace_basic_properties"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(V)
&=c\,\mathrm{tr}(V')
   \quad (\because V=cV'\ \text{とトレースの線型性}), \\
\mathrm{tr}(V^{-1})
&=c^{-1}\,\mathrm{tr}(V'^{-1})
   \quad (\because V^{-1}=c^{-1}V'^{-1}\ \text{とトレースの線型性})
\end{aligned}`,
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
        String.raw`\begin{aligned}
\frac{\mathrm{tr}(V)}{\mathrm{tr}(V^{-1})}
&=\frac{c\,\mathrm{tr}(V')}{c^{-1}\,\mathrm{tr}(V'^{-1})}
   \quad (\because \text{直前の二つの表示}) \\
&=c^2\,\frac{\mathrm{tr}(V')}{\mathrm{tr}(V'^{-1})}
   \quad (\because c\ne0) \\
&=c^2
   \quad (\because \mathrm{tr}(V')=\mathrm{tr}(V'^{-1}))
\end{aligned}`,
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
        String.raw`\begin{aligned}
\frac{\mathrm{tr}(V)}{\mathrm{tr}(V^{-1})}
&=\frac{(2s_2)^{M/2}\,\tau}{(2s_2)^{-M/2}\,\tau}
   \quad (\because \text{Step 1 と Step 2}) \\
&=(2s_2)^M
   \quad (\because \tau\ne0\ \text{かつ指数法則})
\end{aligned}`,
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
        " である。次の一続きで",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(c - (2s_2)^{M/2}\right)\left(c + (2s_2)^{M/2}\right)
&=c^2-\left((2s_2)^{M/2}\right)^2
   \quad (\because \text{和と差の積}) \\
&=c^2-(2s_2)^{M}
   \quad (\because \text{指数法則}\ \left((2s_2)^{M/2}\right)^2=(2s_2)^{M}) \\
&=(2s_2)^{M}-(2s_2)^{M}
   \quad (\because \text{Step 3 の}\ c^2=(2s_2)^{M}) \\
&=0
\end{aligned}`,
      ),
      paragraph(["である。"]),
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
        String.raw`\begin{aligned}
V Q_\epsilon
&= (2s_2)^{M/2}V'Q_\epsilon
   \quad (\because V=(2s_2)^{M/2}V') \\
&= (2s_2)^{M/2}e^{g(\epsilon)}Q_\epsilon
   \quad (\because V'Q_\epsilon=e^{g(\epsilon)}Q_\epsilon) \\
&= \Lambda_\epsilon Q_\epsilon
   \quad (\because \Lambda_\epsilon\ \text{の定義})
\end{aligned}`,
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
        String.raw`\begin{aligned}
g(1,\dots,1)
&= \sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)\left(1 - \tfrac12\right)
   \quad (\because g\ \text{の定義に}\ \epsilon_\mu=1\ \text{を代入}) \\
&= \sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)\cdot\frac12
   \quad \left(\because 1-\tfrac12=\tfrac12\right) \\
&= \frac{1}{2}\sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)
   \quad \left(\because \text{和の線型性}\right)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
g(0,\dots,0)
&= \sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)\left(0 - \tfrac12\right)
   \quad (\because g\ \text{の定義に}\ \epsilon_\mu=0\ \text{を代入}) \\
&= \sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)\cdot\left(-\frac12\right)
   \quad \left(\because 0-\tfrac12=-\tfrac12\right) \\
&= -\frac{1}{2}\sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)
   \quad \left(\because \text{和の線型性}\right)
\end{aligned}`,
      ),
      paragraph([
        "を代入して statement の ",
        math(String.raw`\Lambda_{\max}, \Lambda_{\min}`),
        " を得る。積は次の鎖で求まる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Lambda_{\max}\Lambda_{\min}
&= (2s_2)^{M/2}e^{g(1,\dots,1)}\,(2s_2)^{M/2}e^{g(0,\dots,0)}
   \quad (\because \Lambda_{\max},\Lambda_{\min}\ \text{の表式}) \\
&= \left((2s_2)^{M/2}(2s_2)^{M/2}\right)
   \left(e^{g(1,\dots,1)}e^{g(0,\dots,0)}\right)
   \quad (\because \text{積の可換則と結合則}) \\
&= (2s_2)^{M}\left(e^{g(1,\dots,1)}e^{g(0,\dots,0)}\right)
   \quad (\because \text{冪の法則}) \\
&= (2s_2)^{M}e^{g(1,\dots,1)+g(0,\dots,0)}
   \quad (\because \text{指数法則}) \\
&= (2s_2)^{M}e^{0}
   \quad (\because g(1,\dots,1)+g(0,\dots,0)=0) \\
&= (2s_2)^{M}
   \quad (\because e^0=1)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "この主張は docs/tasks/free-energy-roadmap の章 C（最大固有値）の入口になる。Λ_max の表式はそのまま自由エネルギーの主要項へ渡る。",
      ],
    },
  },
]);
