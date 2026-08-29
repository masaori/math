import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/016_even_sector_fermions.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_fermions",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`\text{半整数運動量のフェルミオンと } V^{(+)} = c\,\check{V}'` },
    labels: [],
  },

  {
    id: "evenfermi_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的と、008 章との違い" },
    labels: [],
    statement: [
      paragraph([
        ref("T_V_plus_check_Z_Y"),
        " で ",
        math(String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\ \check{Y}_\mu\right) A(\tilde\theta_\mu)`),
        " を、",
        ref("diagonalization_check_P_D"),
        " で ",
        math(String.raw`A(\tilde\theta_\mu) = \check{P}_\mu \check{D}_\mu \check{P}_\mu^{-1}`),
        " を得た。この章では、",
        math(String.raw`\check{P}_\mu`),
        " の列で ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " を組み替えた**半整数運動量のフェルミオン** ",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger`),
        " を導入し、",
      ]),
      displayMath(
        String.raw`\check{V}' := \exp\!\left(\sum_{\mu \in \check{\mathcal{M}}}
\gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\,\check\psi_{M+1-\mu}
- \tfrac12 I\right)\right)`,
      ),
      paragraph([
        "とおいたとき、ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " について ",
        math(String.raw`V^{(+)} = c\,\check{V}'`),
        " が成り立つこと（",
        ref("V_plus_eq_c_check_Vprime"),
        "）まで到達する。",
        math(String.raw`c`),
        " の値の決定は次章で扱う。",
      ]),
      paragraph([
        "**008 章との違いは、場合分けが一つも要らないことである。** 008 章では ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " となる ",
        math(String.raw`\mu`),
        "（臨界点の ",
        math(String.raw`\mu = \pm M`),
        "）でフェルミオン ",
        math(String.raw`\psi_\mu, \psi_\mu^\dagger`),
        " が定義できず、",
        ref("def_fermi"),
        " の定義域の限定、",
        ref("def_Vprime"),
        " の和の範囲の限定、",
        ref("A_theta_is_identity_when_gamma2_zero"),
        "・",
        ref("T_Vprime_fixes_hatZ_hatY_when_gamma2_zero"),
        " による例外処理、",
        ref("T_V_eq_T_Vprime_on_hatZ_hatY"),
        " の「場合 2」が必要だった。",
        "半整数運動量では ",
        ref("gamma_2_theta_tilde_nonzero"),
        " により ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " が**すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とすべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " について**成り立つので、これらはすべて不要になる。",
      ]),
      paragraph([
        "**平方根の分枝の議論も要らない。** 008 章の ",
        ref("anticommutator_of_psi"),
        " は、",
        math(String.raw`\psi`),
        " の係数に現れる ",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " が ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\nu`),
        " で同じ分枝を取ることを Step 0 で確かめる必要があった。半整数運動量では ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4)(5) により根号が ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`i\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " に確定しているので、",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " の成分は最初から実の絶対値だけで書かれており、分枝の問題が生じない。",
      ]),
      paragraph([
        "**対になる添字は ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`M+1-\mu`),
        " である。** ",
        ref("conjugate_index_of_check_Z_Y"),
        " の ",
        math(String.raw`\tilde\theta_{M+1-\mu} = 2\pi - \tilde\theta_\mu`),
        " と ",
        ref("anticommutator_of_check_Z_Y"),
        " の ",
        math(String.raw`\nu = M+1-\mu`),
        " に対応する。008 章の ",
        math(String.raw`-\mu`),
        " をそのまま写してはならない。",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`M+1-\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中にとどまるので、**この章では ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字が現れない。**",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evenfermi_001_definition_check_fermi",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\check\psi_\mu, \check\psi_\mu^\dagger \text{（半整数運動量のフェルミオン）}` },
    labels: ["def_check_fermi"],
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
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " を用いて ",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`\begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}
:= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu`,
      ),
      paragraph([
        "すなわち（",
        math(String.raw`a := \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`b := \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`r := |a| \in \mathbb{R}_{>0}`),
        " と略記して）",
      ]),
      displayMath(
        String.raw`\check\psi_\mu^\dagger := \frac{-r}{2\sqrt{M}\,b}\,\check{Z}_\mu + \frac{1}{2\sqrt{M}}\,\check{Y}_\mu,
\qquad
\check\psi_\mu := \frac{+r}{2\sqrt{M}\,b}\,\check{Z}_\mu + \frac{1}{2\sqrt{M}}\,\check{Y}_\mu`,
      ),
      paragraph([
        "と定める（行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("calc_of_TxT_check_Z_Y"),
        " の ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}p & q \\ r & s\end{pmatrix} = (pA + rB,\ qA + sB)`),
        "）。",
      ]),
      paragraph([
        "**この定義は ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " のすべてについて意味をもつ。** ",
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`a \neq 0`),
        " すなわち ",
        math(String.raw`r > 0`),
        "、",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`b \neq 0`),
        " であり、",
        math(String.raw`M \geq 2`),
        " より ",
        math(String.raw`\sqrt{M} > 0`),
        " なので分母 ",
        math(String.raw`2\sqrt{M}\,b`),
        " は ",
        math(String.raw`0`),
        " でない（",
        ref("diagonalization_check_P_D"),
        " の Step 1）。",
        ref("def_fermi"),
        " が ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu`),
        " にしか定義できなかったのと違い、**除外される ",
        math(String.raw`\mu`),
        " は無い**。",
      ]),
      paragraph([
        math(String.raw`\dagger`),
        " は転置共役を表す記号ではなく、2 つの元を区別する添え字の一部として使う（",
        ref("def_fermi"),
        " と同じ扱い）。",
      ]),
    ],
    proof: [],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_fermi の半整数運動量版。008 章の P_μ の (1,1) 成分 +i√(γ_2(θ_μ)γ_2(−θ_μ))/(2√M γ_2(−θ_μ)) は、" +
          "relation_of_gamma_2_theta_tilde (5)（√(γ_2 γ_2(−)) = i|γ_2|）により半整数運動量では −|γ_2|/(2√M γ_2(−θ~_μ)) に等しい。" +
          "したがって定義式の形は 008 章と同一であり、根号が実の絶対値に書き換わっているだけである。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_01（定義式と P̌_μ の列の一致、および ψ̌ の M 周期性）。",
      ],
    },
  },

  {
    id: "evenfermi_002_claim_periodicity",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { tex: String.raw`\gamma_1, \gamma_2 \text{ の周期性と共役添字 } M+1-\mu` },
    labels: ["periodicity_of_check_fermi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。次が成り立つ。",
      ]),
      list([
        [
          "(1) **",
          math(String.raw`\gamma_1, \gamma_2`),
          " の ",
          math(String.raw`2\pi`),
          " 周期性**（",
          math(String.raw`\theta \in \mathbb{R}`),
          "、",
          math(String.raw`k \in \mathbb{Z}`),
          "）：",
          math(String.raw`\gamma_1(\theta + 2k\pi) = \gamma_1(\theta)`),
          "、",
          math(String.raw`\gamma_2(\theta + 2k\pi) = \gamma_2(\theta)`),
          "。",
        ],
        [
          "(2) **添字の ",
          math(String.raw`M`),
          " 周期性**（",
          math(String.raw`\mu, k \in \mathbb{Z}`),
          "）：",
          math(String.raw`\tilde\theta_{\mu+kM} = \tilde\theta_\mu + 2k\pi`),
          "、したがって ",
          math(String.raw`\gamma_1(\tilde\theta_{\mu+kM}) = \gamma_1(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_2(\pm\tilde\theta_{\mu+kM}) = \gamma_2(\pm\tilde\theta_\mu)`),
          "。",
        ],
        [
          "(3) **共役添字**（",
          math(String.raw`\mu \in \check{\mathcal{M}}`),
          "）：",
          math(String.raw`\gamma_2(\tilde\theta_{M+1-\mu}) = \gamma_2(-\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_2(-\tilde\theta_{M+1-\mu}) = \gamma_2(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_1(\tilde\theta_{M+1-\mu}) = \gamma_1(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma(\tilde\theta_{M+1-\mu}) = \gamma(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\check{P}_{M+1-\mu}`),
          " は ",
          math(String.raw`\check{P}_\mu`),
          " の ",
          math(String.raw`\gamma_2(\pm\tilde\theta_\mu)`),
          " を入れ替えたもの。",
        ],
      ]),
      paragraph([
        "**この主張の (2) だけは ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " で量化する。** ",
        ref("def_check_index_set"),
        " が述べたとおり、013 章から 017 章で ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字を扱うのは、",
        ref("def_half_integer_modes"),
        " (2) とこの (2) の 2 箇所だけである。(2) は ",
        math(String.raw`\gamma_1, \gamma_2`),
        " が ",
        math(String.raw`\theta \in \mathbb{R}`),
        " の関数（",
        ref("def_gamma1_gamma2_of_theta"),
        "）であることによって意味をもつ主張であり、",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " や ",
        math(String.raw`\check\psi_\mu`),
        "（これらは ",
        math(String.raw`\check{\mathcal{M}}`),
        " 上でしか定義していない）には言及していない。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) 実数 ",
        math(String.raw`t`),
        " について ",
        math(String.raw`\cos(t+2k\pi) = \cos t`),
        "、",
        math(String.raw`\sin(t+2k\pi) = \sin t`),
        " であり、",
        ref("euler_formula_cos_sin"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{i(t+2k\pi)}
&= \cos(t+2k\pi) + i\sin(t+2k\pi)
   \quad (\because \text{Euler の公式}) \\
&= \cos t + i\sin t
   \quad (\because \cos, \sin \text{ の } 2\pi \text{ 周期性}) \\
&= e^{it}
   \quad (\because \text{Euler の公式})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " と ",
        math(String.raw`\gamma_2(\theta) = ie^{i\theta}s_2^*\left(c_1\cos\theta - i\sin\theta - s_1c_2\right)`),
        " は ",
        math(String.raw`\cos\theta, \sin\theta, e^{i\theta}`),
        " のみを通じて ",
        math(String.raw`\theta`),
        " に依存するから、(1) が従う。",
      ]),
      paragraph([
        "(2) ",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta`),
        " の定義より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{\mu+kM}
&= \frac{2\pi\left(\mu+kM-\frac12\right)}{M}
   \quad (\because \tilde\theta \text{ の定義}) \\
&= \frac{2\pi\left(\mu-\frac12\right) + 2\pi kM}{M}
   \quad (\because \mathbb{R}\text{ の分配則}) \\
&= \frac{2\pi\left(\mu-\frac12\right)}{M} + \frac{2\pi kM}{M}
   \quad (\because \text{分数の和（分母 }M\neq0\text{）}) \\
&= \tilde\theta_\mu + \frac{2\pi kM}{M}
   \quad (\because \tilde\theta \text{ の定義}) \\
&= \tilde\theta_\mu + 2k\pi
   \quad (\because M\neq0\text{ による約分})
\end{aligned}`,
      ),
      paragraph([
        "これを (1) に ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " として使えば ",
        math(String.raw`\gamma_1(\tilde\theta_{\mu+kM}) = \gamma_1(\tilde\theta_\mu)`),
        " と ",
        math(String.raw`\gamma_2(\tilde\theta_{\mu+kM}) = \gamma_2(\tilde\theta_\mu)`),
        "。また ",
        math(String.raw`-\tilde\theta_{\mu+kM} = -\tilde\theta_\mu + 2(-k)\pi`),
        " なので (1) を ",
        math(String.raw`\theta = -\tilde\theta_\mu`),
        "、",
        math(String.raw`k \to -k`),
        " として使えば ",
        math(String.raw`\gamma_2(-\tilde\theta_{\mu+kM}) = \gamma_2(-\tilde\theta_\mu)`),
        "。",
      ]),
      paragraph([
        "(3) ",
        ref("conjugate_index_of_check_Z_Y"),
        " (1) より ",
        math(String.raw`\tilde\theta_{M+1-\mu} = 2\pi - \tilde\theta_\mu = \left(-\tilde\theta_\mu\right) + 2\pi`),
        " である。よって (1) を ",
        math(String.raw`\theta = -\tilde\theta_\mu`),
        "、",
        math(String.raw`k = 1`),
        " として使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\tilde\theta_{M+1-\mu})
&= \gamma_2\!\left(\left(-\tilde\theta_\mu\right) + 2\pi\right)
   \quad (\because \text{共役添字の運動量}) \\
&= \gamma_2(-\tilde\theta_\mu)
   \quad (\because \text{本ブロックの (1)}\ (k=1))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
-\tilde\theta_{M+1-\mu}
&= -(2\pi-\tilde\theta_\mu)
   \quad (\because \text{共役添字の運動量}) \\
&= -2\pi+\tilde\theta_\mu
   \quad (\because \mathbb{R}\text{ の分配則}) \\
&= \tilde\theta_\mu+2(-1)\pi
   \quad (\because \mathbb{R}\text{ の加法の可換則と }-2\pi=2(-1)\pi),\\[4pt]
\gamma_2(-\tilde\theta_{M+1-\mu})
&= \gamma_2(\tilde\theta_\mu+2(-1)\pi)
   \quad (\because \text{上の等式}) \\
&= \gamma_2(\tilde\theta_\mu)
   \quad (\because \text{本ブロック }(1)),\\[4pt]
\gamma_1(\tilde\theta_{M+1-\mu})
&= \gamma_1((-\tilde\theta_\mu)+2\pi)
   \quad (\because \text{共役添字の運動量}) \\
&= \gamma_1(-\tilde\theta_\mu)
   \quad (\because \text{本ブロック }(1)) \\
&= \gamma_1(\tilde\theta_\mu)
   \quad (\because \cos(-t)=\cos t\text{ と }\gamma_1\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "上の鎖では ",
        ref("conjugate_index_of_check_Z_Y"),
        "、",
        ref("def_gamma1_gamma2_of_theta"),
        " を引いた。",
      ]),
      paragraph([
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M+1-\mu \in \check{\mathcal{M}}`),
        " なので ",
        ref("def_gamma_theta_tilde_mu"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_{M+1-\mu}) = \mathrm{arccosh}\!\left(\gamma_1(\tilde\theta_{M+1-\mu})\right)`),
        " が定義されており、これは ",
        math(String.raw`\gamma_1`),
        " の値だけで決まるので ",
        math(String.raw`\gamma(\tilde\theta_{M+1-\mu}) = \gamma(\tilde\theta_\mu)`),
        "。",
      ]),
      paragraph([
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " の成分は ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|`),
        "、",
        math(String.raw`\gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`M`),
        " だけで書かれているので、上の 2 式を代入すれば ",
        math(String.raw`\check{P}_{M+1-\mu}`),
        " の成分が ",
        math(String.raw`\left|\gamma_2(-\tilde\theta_\mu)\right|`),
        " と ",
        math(String.raw`\gamma_2(\tilde\theta_\mu)`),
        " で書けることが分かる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章では対応する事実が gamma2_theta_M_periodicity と hatZ_hatY_M_periodicity に分かれ、" +
          "action_of_T_Vprime_on_psi の proof の中で μ の符号ごとの場合分け（a)〜c)）として使われていた。" +
          "半整数運動量では添字を 𝓜̌ = {1,…,M} に絞り、共役添字を M+1−μ で取ることで場合分けが要らない。",
        "以前この主張は ψ̌_{μ+kM} = ψ̌_μ（μ ∈ Z）を含んでいたが、共役添字を 1−μ から M+1−μ へ書き換えたことで " +
          "ψ̌ を 𝓜̌ の外の添字で評価する箇所が本文から消えたため、その項目は不要になった。" +
          "γ_1, γ_2 は θ ∈ R の関数なので (2) だけは μ ∈ Z のまま残してある。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_01。",
        "2026-08-19 の式変形統一で、周期性の鎖の機械識別子を人間可読な根拠へ直し、根拠の無かった分配則の行を補った。" +
          "また、「同じ計算」に省略していた共役添字の二本の導出を、各結論の左辺から始まる鎖へ開いた。内容と参照は変えていない。",
      ],
    },
  },

  {
    id: "evenfermi_003_claim_anticommutator",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`\check\psi \text{ の反交換関係}` },
    labels: ["anticommutator_of_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+ = 0,
\qquad
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+ = \delta_{\nu,\,M+1-\mu}\,I,
\qquad
\left[\check\psi_\mu, \check\psi_\nu\right]_+ = 0`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "、",
        math(String.raw`\delta_{\nu,\,M+1-\mu}`),
        " は ",
        ref("anticommutator_of_check_Z_Y"),
        " と同じ通常のクロネッカーのデルタ）。",
        ref("anticommutator_of_psi"),
        " では対になる添字が ",
        math(String.raw`\nu = -\mu`),
        " だったのに対し、ここでは ",
        math(String.raw`\nu = M+1-\mu`),
        " である。",
        ref("def_check_index_set"),
        " (5) により、この対の条件は合同式なしで書ける。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`a_\mu := \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`b_\mu := \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`r_\mu := |a_\mu| \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`c_\mu := \dfrac{1}{2\sqrt{M}\,b_\mu} \in \mathbb{C}^\times`),
        " と略記する（",
        ref("gamma_2_theta_tilde_nonzero"),
        " と ",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`a_\mu \neq 0`),
        "、",
        math(String.raw`b_\mu \neq 0`),
        "）。",
        ref("def_check_fermi"),
        " は",
      ]),
      displayMath(
        String.raw`\check\psi_\mu^\dagger = c_\mu\left(-r_\mu\,\check{Z}_\mu + b_\mu\,\check{Y}_\mu\right),
\qquad
\check\psi_\mu = c_\mu\left(+r_\mu\,\check{Z}_\mu + b_\mu\,\check{Y}_\mu\right)`,
      ),
      paragraph([
        "と書ける。また ",
        ref("anticommutator_of_check_Z_Y"),
        " より",
      ]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+ = 2M\,\delta\,I,
\qquad
\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ = \left[\check{Y}_\mu, \check{Z}_\nu\right]_+ = 0,
\qquad
\left[\check{Y}_\mu, \check{Y}_\nu\right]_+ = 2M\,\delta\,I,
\qquad \delta := \delta_{\nu,\,M+1-\mu}`,
      ),
      paragraph([
        "である（",
        math(String.raw`[\check{Y}_\mu, \check{Z}_\nu]_+ = [\check{Z}_\nu, \check{Y}_\mu]_+ = 0`),
        " は反交換子の対称性による）。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\delta \neq 0`),
        " のときの係数の関係）。",
        math(String.raw`\delta = \delta_{\nu,\,M+1-\mu} = 1`),
        " とは ",
        math(String.raw`\nu = M+1-\mu`),
        " そのものである（",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " に絞ったので合同式を解く必要がない。",
        ref("def_check_index_set"),
        " (5)）。このとき ",
        ref("periodicity_of_check_fermi"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a_\nu
&= \gamma_2(\tilde\theta_{M+1-\mu})
   \quad (\because a_\nu := \gamma_2(\tilde\theta_\nu),\ \nu = M+1-\mu) \\
&= \gamma_2(-\tilde\theta_\mu)
   \quad (\because \gamma_1, \gamma_2 \text{ の周期性と共役添字 (3)}) \\
&= b_\mu
   \quad (\because b_\mu \text{ の略記}),\\[4pt]
b_\nu
&= \gamma_2(-\tilde\theta_{M+1-\mu})
   \quad (\because b_\nu := \gamma_2(-\tilde\theta_\nu),\ \nu = M+1-\mu) \\
&= \gamma_2(\tilde\theta_\mu)
   \quad (\because \gamma_1, \gamma_2 \text{ の周期性と共役添字 (3)}) \\
&= a_\mu
   \quad (\because a_\mu \text{ の略記})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の ",
        math(String.raw`b_\mu = -\overline{a_\mu}`),
        " と ",
        math(String.raw`|\overline{z}| = |z|`),
        "（",
        ref("abs_basic_properties"),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
r_\nu
&= |a_\nu|
   \quad (\because r_\nu := |a_\nu|) \\
&= |b_\mu|
   \quad (\because \text{上の } a_\nu = b_\mu) \\
&= \left|-\overline{a_\mu}\right|
   \quad (\because \gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)}\text{ とその帰結 (1)}\ (b_\mu = -\overline{a_\mu})) \\
&= \left|\overline{a_\mu}\right|
   \quad (\because \text{絶対値の基本性質}\ (|-z| = |z|)) \\
&= |a_\mu|
   \quad (\because \text{絶対値の基本性質}\ (|\bar z| = |z|)) \\
&= r_\mu
   \quad (\because r_\mu := |a_\mu|)
\end{aligned}`,
      ),
      paragraph([
        "である。以下この共通の値を ",
        math(String.raw`r := r_\mu = r_\nu > 0`),
        " と書く。さらに ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
b_\mu b_\nu
&= b_\mu a_\mu
   \quad (\because \text{上の } b_\nu = a_\mu) \\
&= a_\mu b_\mu
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= -r^2
   \quad (\because \gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)}\text{ とその帰結 (2)}),\\[4pt]
c_\mu c_\nu
&= \frac{1}{2\sqrt{M}\,b_\mu}\cdot\frac{1}{2\sqrt{M}\,b_\nu}
   \quad (\because c_\mu := \tfrac{1}{2\sqrt{M}\,b_\mu}) \\
&= \frac{1}{4M\,b_\mu b_\nu}
   \quad \left(\because \left(2\sqrt{M}\right)^2 = 4M\right) \\
&= \frac{1}{4M\left(-r^2\right)}
   \quad (\because \text{上の } b_\mu b_\nu = -r^2) \\
&= \frac{-1}{4Mr^2}
   \quad (\because \text{負号を分子へ移す（}\mathbb{C}\text{ の四則）})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`r > 0`),
        " なので分母は ",
        math(String.raw`0`),
        " でない）。",
        "**ここが 008 章との差である。** ",
        ref("anticommutator_of_psi"),
        " では係数に平方根 ",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " が入るため、",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\nu`),
        " で同じ分枝が選ばれることを別途示す必要があった。ここでの ",
        math(String.raw`r_\mu`),
        " は複素数の絶対値、すなわち非負の実数として一意に定まる量なので、",
        math(String.raw`r_\nu = r_\mu`),
        " は上の絶対値の計算だけで従い、分枝の議論は生じない。",
      ]),
      paragraph([
        "Step 2（第 1 式）。反交換子 ",
        math(String.raw`[X,W]_+ := XW + WX`),
        " は両引数について ",
        math(String.raw`\mathbb{C}`),
        " 双線型である。実際",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\alpha X, \beta W]_+
&= (\alpha X)(\beta W) + (\beta W)(\alpha X)
   \quad (\because \text{反交換子の定義}) \\
&= \alpha\beta\,XW + \beta\alpha\,WX
   \quad (\because \text{スカラー倍は行列の積と可換（2 箇所へ同時適用）}) \\
&= \alpha\beta\,XW + \alpha\beta\,WX
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= \alpha\beta\left(XW + WX\right)
   \quad (\because \text{分配則による括り出し})
\end{aligned}`,
      ),
      paragraph([
        "であり、スカラー倍が行列の積と可換であることは ",
        ref("scalar_identity_commutes"),
        " による。和についての加法性も行列の積の分配法則から従う。これを使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+
&= \left[c_\mu\left(-r_\mu\check{Z}_\mu + b_\mu\check{Y}_\mu\right),\
   c_\nu\left(-r_\nu\check{Z}_\nu + b_\nu\check{Y}_\nu\right)\right]_+
   \quad (\because \check\psi_\mu, \check\psi_\mu^\dagger \text{ の定義}) \\
&= c_\mu c_\nu\Bigl(
\left(-r_\mu\right)\left(-r_\nu\right)\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
+ \left(-r_\mu\right)b_\nu\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ \\
&\qquad\qquad
+ b_\mu\left(-r_\nu\right)\left[\check{Y}_\mu, \check{Z}_\nu\right]_+
+ b_\mu b_\nu\left[\check{Y}_\mu, \check{Y}_\nu\right]_+
\Bigr)
   \quad (\because \text{反交換子の } \mathbb{C} \text{ 双線型性}) \\
&= c_\mu c_\nu\Bigl(
\left(-r_\mu\right)\left(-r_\nu\right)\cdot 2M\,\delta\,I
+ \left(-r_\mu\right)b_\nu\cdot 0 \\
&\qquad\qquad
+ b_\mu\left(-r_\nu\right)\cdot 0
+ b_\mu b_\nu\cdot 2M\,\delta\,I
\Bigr)
   \quad (\because \check{Z}, \check{Y} \text{ の反交換関係を 4 箇所へ同時適用}) \\
&= c_\mu c_\nu\left(
\left(-r_\mu\right)\left(-r_\nu\right)\cdot 2M\,\delta\,I
+ b_\mu b_\nu\cdot 2M\,\delta\,I
\right)
   \quad (\because 0 \text{ 行列の項の消去（2 箇所へ同時適用）}) \\
&= c_\mu c_\nu\left(
r_\mu r_\nu\cdot 2M\,\delta\,I
+ b_\mu b_\nu\cdot 2M\,\delta\,I
\right)
   \quad (\because \left(-x\right)\left(-y\right) = xy\ (\mathbb{R}\text{ の四則})) \\
&= c_\mu c_\nu\left(r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M\,\delta\,I
   \quad (\because \text{分配則による } 2M\,\delta\,I \text{ の括り出し})
\end{aligned}`,
      ),
      paragraph([
        "上の鎖では ",
        ref("def_check_fermi"),
        " と ",
        ref("anticommutator_of_check_Z_Y"),
        " を引いた。",
        math(String.raw`\delta = 0`),
        " なら全体が ",
        math(String.raw`0`),
        "。",
        math(String.raw`\delta \neq 0`),
        " なら Step 1 より ",
        math(String.raw`r_\mu r_\nu = r^2`),
        "、",
        math(String.raw`b_\mu b_\nu = -r^2`),
        " なので括弧は ",
        math(String.raw`r^2 - r^2 = 0`),
        "。いずれの場合も ",
        math(String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+ = 0`),
        "。",
      ]),
      paragraph([
        "Step 3（第 3 式）。",
        "第 1 式と同じ定義・双線型性・反交換関係を各行で適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu, \check\psi_\nu\right]_+
&= \left[c_\mu\left(r_\mu\check{Z}_\mu + b_\mu\check{Y}_\mu\right),\
   c_\nu\left(r_\nu\check{Z}_\nu + b_\nu\check{Y}_\nu\right)\right]_+
   \quad (\because \check\psi_\mu, \check\psi_\nu \text{ の定義}) \\
&= c_\mu c_\nu\Bigl(
r_\mu r_\nu\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
+ r_\mu b_\nu\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ \\
&\qquad\qquad
+ b_\mu r_\nu\left[\check{Y}_\mu, \check{Z}_\nu\right]_+
+ b_\mu b_\nu\left[\check{Y}_\mu, \check{Y}_\nu\right]_+
\Bigr)
   \quad (\because \text{反交換子の } \mathbb{C} \text{ 双線型性}) \\
&= c_\mu c_\nu\Bigl(
r_\mu r_\nu\cdot 2M\,\delta\,I
+ r_\mu b_\nu\cdot 0
+ b_\mu r_\nu\cdot 0
+ b_\mu b_\nu\cdot 2M\,\delta\,I
\Bigr)
   \quad (\because \check{Z}, \check{Y} \text{ の反交換関係を 4 箇所へ同時適用}) \\
&= c_\mu c_\nu\left(
r_\mu r_\nu\cdot 2M\,\delta\,I
+ b_\mu b_\nu\cdot 2M\,\delta\,I
\right)
   \quad (\because 0 \text{ 行列の項の消去（2 箇所へ同時適用）}) \\
&= c_\mu c_\nu\left(r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M\,\delta\,I
   \quad (\because \text{分配則による } 2M\,\delta\,I \text{ の括り出し})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta = 0`),
        " なら全体が ",
        math(String.raw`0`),
        "。",
        math(String.raw`\delta \neq 0`),
        " なら Step 1 より括弧が ",
        math(String.raw`r^2-r^2=0`),
        "。したがって ",
        math(String.raw`\left[\check\psi_\mu, \check\psi_\nu\right]_+ = 0`),
        "。",
      ]),
      paragraph([
        "Step 4（第 2 式）。定義・双線型性・反交換関係を各行で適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+
&= \left[c_\mu\left(-r_\mu\check{Z}_\mu + b_\mu\check{Y}_\mu\right),\
   c_\nu\left(r_\nu\check{Z}_\nu + b_\nu\check{Y}_\nu\right)\right]_+
   \quad (\because \check\psi_\mu^\dagger, \check\psi_\nu \text{ の定義}) \\
&= c_\mu c_\nu\Bigl(
\left(-r_\mu\right)r_\nu\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
+ \left(-r_\mu\right)b_\nu\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ \\
&\qquad\qquad
+ b_\mu r_\nu\left[\check{Y}_\mu, \check{Z}_\nu\right]_+
+ b_\mu b_\nu\left[\check{Y}_\mu, \check{Y}_\nu\right]_+
\Bigr)
   \quad (\because \text{反交換子の } \mathbb{C} \text{ 双線型性}) \\
&= c_\mu c_\nu\Bigl(
\left(-r_\mu\right)r_\nu\cdot 2M\,\delta\,I
+ \left(-r_\mu\right)b_\nu\cdot 0
+ b_\mu r_\nu\cdot 0
+ b_\mu b_\nu\cdot 2M\,\delta\,I
\Bigr)
   \quad (\because \check{Z}, \check{Y} \text{ の反交換関係を 4 箇所へ同時適用}) \\
&= c_\mu c_\nu\left(
\left(-r_\mu\right)r_\nu\cdot 2M\,\delta\,I
+ b_\mu b_\nu\cdot 2M\,\delta\,I
\right)
   \quad (\because 0 \text{ 行列の項の消去（2 箇所へ同時適用）}) \\
&= c_\mu c_\nu\left(-r_\mu r_\nu\cdot 2M\,\delta\,I
+ b_\mu b_\nu\cdot 2M\,\delta\,I\right)
   \quad (\because \left(-x\right)y=-xy\ (\mathbb{R}\text{ の四則})) \\
&= c_\mu c_\nu\left(-r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M\,\delta\,I
   \quad (\because \text{分配則による } 2M\,\delta\,I \text{ の括り出し})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta = 0`),
        " なら全体が ",
        math(String.raw`0`),
        " であり、",
        math(String.raw`\delta_{\nu,\,M+1-\mu}I = 0`),
        " と一致する。",
        math(String.raw`\delta \neq 0`),
        "（すなわち ",
        math(String.raw`\delta = 1`),
        "）なら Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+
&= \frac{-1}{4Mr^2}\left(-r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M\,\delta\,I
   \quad (\because \text{Step 1}\ (c_\mu c_\nu = \tfrac{-1}{4Mr^2})) \\
&= \frac{-1}{4Mr^2}\left(-r^2 + \left(-r^2\right)\right)\cdot 2M\,I
   \quad (\because \text{Step 1}\ (r_\mu r_\nu = r^2,\ b_\mu b_\nu = -r^2),\ \delta = 1) \\
&= \frac{-1}{4Mr^2}\cdot\left(-2r^2\right)\cdot 2M\,I
   \quad (\because -r^2 + \left(-r^2\right) = -2r^2\text{（同類項の統合）}) \\
&= \frac{\left(-1\right)\cdot\left(-2r^2\right)\cdot 2M}{4Mr^2}\,I
   \quad (\because \text{分数の積（}\mathbb{R}\text{ の四則）}) \\
&= \frac{4Mr^2}{4Mr^2}\,I
   \quad (\because \left(-1\right)\left(-2r^2\right) = 2r^2 \text{ と乗法の可換則}) \\
&= I
   \quad (\because M \geq 2,\ r > 0 \text{ より } 4Mr^2 \neq 0 \text{ の約分})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\delta_{\nu,\,M+1-\mu}I = I`),
        " と一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の anticommutator_of_psi の半整数運動量版。008 章が Step 0（√ の分枝の一致）に費やしていた部分は、" +
          "係数が |γ_2|（非負実数）で書かれることにより絶対値の計算 1 行に置き換わった。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_02（M=2,3,4,5、μ,ν ∈ {1..M}（および負の μ）、5 組の (K1,K2)）。",
        "2026-08-19 の式変形統一で、行末根拠の機械識別子と「直前の displayMath」という指し方を人間可読な名前へ直し、" +
          "一行二等号（a_ν・b_ν の鎖と Step 4 の末尾）を一操作ずつに分け、根拠の無かった行（r_ν = r_μ、可換則、負号の移動、同類項の統合、約分）に行末根拠を補い、" +
          "散文に畳まれていた反交換子の双線型性の計算を鎖へ開いた。内容と参照は変えていない。",
      ],
    },
  },

  {
    id: "evenfermi_004_claim_commutation_V_plus_psi",
    kind: "claim",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`V^{(+)} \text{ と } \check\psi \text{ の交換関係}` },
    labels: ["commutation_V_plus_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) = e^{+\gamma(\tilde\theta_\mu)}\,\check\psi_\mu^\dagger,
\qquad
T_{(V^{(+)})}\!\left(\check\psi_\mu\right) = e^{-\gamma(\tilde\theta_\mu)}\,\check\psi_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T_{(V^{(+)})}`),
        " は ",
        ref("def_V_plus_and_T_V_plus"),
        "、",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " は ",
        ref("def_gamma_theta_tilde_mu"),
        "）。",
        ref("commutation_V_psi"),
        " と違い ",
        math(String.raw`\gamma_2 = 0`),
        " による定義域の限定は無い。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("calc_of_TxT_check_Z_Y"),
        " のものとする。まず、",
        math(String.raw`A_0, B_0 \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " と ",
        math(String.raw`G, H \in \mathrm{Mat}(2,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\begin{pmatrix}A_0, & B_0\end{pmatrix}G\right)H
&= \begin{pmatrix}A_0, & B_0\end{pmatrix}\left(GH\right)
   \quad (\because \text{行列の積の結合法則})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ（結合律）。実際 ",
        math(String.raw`G = \begin{pmatrix}g_{11} & g_{12} \\ g_{21} & g_{22}\end{pmatrix}`),
        "、",
        math(String.raw`H = \begin{pmatrix}h_{11} & h_{12} \\ h_{21} & h_{22}\end{pmatrix}`),
        " とすると、左辺の第 ",
        math(String.raw`l`),
        " 列は ",
        math(String.raw`\sum_{k=1}^{2} h_{kl}\left(g_{1k}A_0 + g_{2k}B_0\right)`),
        "、右辺の第 ",
        math(String.raw`l`),
        " 列は ",
        math(String.raw`\left(\sum_{k}g_{1k}h_{kl}\right)A_0 + \left(\sum_{k}g_{2k}h_{kl}\right)B_0`),
        " であり、",
        math(String.raw`\mathbb{C}`),
        " 上のスカラー倍の分配律により両者は一致する。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`T_{(V^{(+)})}`),
        " の線型性を行ベクトルへ持ち上げる）。",
        ref("def_V_plus_and_T_V_plus"),
        " (1)(3) より ",
        math(String.raw`V^{(+)} \in R^\times`),
        " かつ ",
        math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
        " なので、",
        ref("linearity_of_T_on_check_Z_Y"),
        " の一般形（",
        math(String.raw`g \in R^\times`),
        " について ",
        math(String.raw`T_g(aX+bW) = aT_g(X) + bT_g(W)`),
        "）が使える。よって ",
        math(String.raw`G \in \mathrm{Mat}(2,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\begin{pmatrix}A_0, & B_0\end{pmatrix}G\right)
&:= \left(T_{(V^{(+)})}\!\left(g_{11}A_0 + g_{21}B_0\right),\
T_{(V^{(+)})}\!\left(g_{12}A_0 + g_{22}B_0\right)\right)
   \quad (\because \text{行ベクトルへの作用の定め方}) \\
&= \left(g_{11}T_{(V^{(+)})}(A_0)+g_{21}T_{(V^{(+)})}(B_0),\
g_{12}T_{(V^{(+)})}(A_0)+g_{22}T_{(V^{(+)})}(B_0)\right)
   \quad (\because T_{(V^{(+)})}\text{ の線型性を 2 列へ同時適用}) \\
&= \begin{pmatrix}T_{(V^{(+)})}(A_0), & T_{(V^{(+)})}(B_0)\end{pmatrix}G
   \quad (\because \text{行ベクトルと }2\times2\text{ 行列の積の定義})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`G`),
        " の成分は ",
        math(String.raw`A_0, B_0`),
        " に依らない複素数なので、線型性の係数として使える）。",
      ]),
      paragraph([
        "Step 2（計算）。",
        ref("def_check_fermi"),
        "、Step 1、",
        ref("T_V_plus_check_Z_Y"),
        "、",
        ref("diagonalization_check_P_D"),
        " を順に使う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\begin{pmatrix}T_{(V^{(+)})}(\check\psi_\mu^\dagger), & T_{(V^{(+)})}(\check\psi_\mu)\end{pmatrix}
&= T_{(V^{(+)})}\!\left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)
   \quad (\because \check\psi_\mu,\check\psi_\mu^\dagger\text{ の定義}) \\
&= \begin{pmatrix}T_{(V^{(+)})}(\check{Z}_\mu), & T_{(V^{(+)})}(\check{Y}_\mu)\end{pmatrix}\check{P}_\mu
   \quad (\because \text{Step 1}) \\
&= \left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}A(\tilde\theta_\mu)\right)\check{P}_\mu
   \quad (\because T_{(V^{(+)})}\text{ の }\check Z,\check Y\text{ への作用}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\left(A(\tilde\theta_\mu)\check{P}_\mu\right)
   \quad (\because \text{行ベクトルと行列の積の結合法則}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \left(\check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}\check{P}_\mu\right)
   \quad (\because A(\tilde\theta_\mu) = \check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\left(\check{P}_\mu\check{D}_\mu\right)
   \quad (\because \check{P}_\mu^{-1}\check{P}_\mu = I_{\mathrm{Mat}(2,\mathbb{C})}) \\
&= \left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)\check{D}_\mu
   \quad (\because \text{行ベクトルと行列の積の結合法則}) \\
&= \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{D}_\mu
   \quad (\because \check\psi_\mu,\check\psi_\mu^\dagger\text{ の定義}) \\
&= \begin{pmatrix}\lambda_{+,\mu}\,\check\psi_\mu^\dagger, & \lambda_{-,\mu}\,\check\psi_\mu\end{pmatrix}
   \quad (\because \check D_\mu\text{ は対角成分 }\lambda_{+,\mu},\lambda_{-,\mu}\text{ の対角行列})
\end{aligned}`,
      ),
      paragraph([
        "両辺の第 1 列・第 2 列を比べ、",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        " を各列へ代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right)
&= \lambda_{+,\mu}\check\psi_\mu^\dagger
   \quad (\because \text{上の行ベクトルの等式の第 1 列}) \\
&= e^{+\gamma(\tilde\theta_\mu)}\check\psi_\mu^\dagger
   \quad (\because \lambda_{+,\mu}=e^{+\gamma(\tilde\theta_\mu)}),\\[4pt]
T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
&= \lambda_{-,\mu}\check\psi_\mu
   \quad (\because \text{上の行ベクトルの等式の第 2 列}) \\
&= e^{-\gamma(\tilde\theta_\mu)}\check\psi_\mu
   \quad (\because \lambda_{-,\mu}=e^{-\gamma(\tilde\theta_\mu)})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の commutation_V_psi の半整数運動量版。008 章は行ベクトル×行列の結合律を暗黙に使っていたが、" +
          "本章では行ベクトル×行列の積を calc_of_TxT_check_Z_Y の定義で入れているので、結合律を proof の冒頭で明示的に確かめた。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_03（V^{(+)} を行列指数関数から直接構成して共役を計算）。",
        "2026-08-19 の式変形統一で、行ベクトルへの線型作用の一行二等号を定義と線型性の三段へ分け、" +
          "転送行列作用の鎖の機械識別子を人間可読な根拠へ直し、末尾の二等号と固有値の指数表示への代入を各列の一続きの鎖へ開いた。内容と参照は変えていない。",
      ],
    },
  },

  {
    id: "evenfermi_005_definition_check_Vprime",
    kind: "definition",
    origin: { path: SRC, ordinal: 7 },
    title: { tex: String.raw`\check{V}' \text{ の定義}` },
    labels: ["def_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
      ]),
      displayMath(
        String.raw`\check{X} := \sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)
\left(\check\psi_\mu^\dagger\,\check\psi_{M+1-\mu} - \tfrac12 I\right)
\ \in\ \mathrm{Mat}(2^M,\mathbb{C}),
\qquad
\check{V}' := \exp\!\left(\check{X}\right)`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "）。次が成り立つ。",
      ]),
      list([
        [
          "(1) **和の範囲に例外は要らない。** ",
          ref("def_check_index_set"),
          " (2) より ",
          math(String.raw`\mu \in \check{\mathcal{M}} \implies M+1-\mu \in \check{\mathcal{M}}`),
          " なので、",
          ref("def_check_fermi"),
          " により ",
          math(String.raw`\check\psi_\mu^\dagger`),
          " と ",
          math(String.raw`\check\psi_{M+1-\mu}`),
          " はともに定義されており、",
          math(String.raw`\mu \in \check{\mathcal{M}}`),
          " のすべての項が意味をもつ。",
        ],
        [
          "(2) ",
          math(String.raw`\check{V}'`),
          " は可逆であり ",
          math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
          "。したがって ",
          ref("def_T_g"),
          " の ",
          math(String.raw`T_{(\check{V}')}(W) := \check{V}'\,W\,\left(\check{V}'\right)^{-1}`),
          " が定義される。",
        ],
      ]),
      paragraph([
        ref("def_Vprime"),
        " が和を ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " に限定し、除外した ",
        math(String.raw`\mu`),
        " を ",
        ref("T_Vprime_fixes_hatZ_hatY_when_gamma2_zero"),
        " で別扱いしていたのと違い、ここでは ",
        math(String.raw`\mu = 1,\dots,M`),
        " が例外なく走る。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("gamma_2_theta_tilde_nonzero"),
        " はすべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " と ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " について ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " を与えるので、",
        ref("def_check_fermi"),
        " の分母 ",
        math(String.raw`2\sqrt{M}\,\gamma_2(-\tilde\theta_\mu)`),
        " は ",
        math(String.raw`0`),
        " でない。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " に対して ",
        math(String.raw`M+1-\mu \in \check{\mathcal{M}}`),
        " なので、",
        math(String.raw`\check\psi_{M+1-\mu}`),
        " も同じ理由で定義されている。",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}`),
        " はスカラーなので各項は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の元であり、有限和 ",
        math(String.raw`\check{X}`),
        " も同様である。",
      ]),
      paragraph([
        "(2) ",
        ref("matrix_exp_conjugation"),
        " (3) より、任意の ",
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について ",
        math(String.raw`\exp(X)`),
        " は可逆で ",
        math(String.raw`\exp(X)^{-1} = \exp(-X)`),
        " である。",
        math(String.raw`X = \check{X}`),
        " とすればよい。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_Vprime の半整数運動量版。対になる添字は −μ ではなく M+1−μ である（conjugate_index_of_check_Z_Y、def_check_index_set (2)）。",
        "和の範囲が 𝓜̌ = {1,…,M} で尽きること（重複も数え落としも無いこと）は、anticommutator_of_check_psi の対 " +
          "ν = M+1−μ が 𝓜̌ 上の対合（involution）になることに対応する（def_check_index_set (2)(4)）。" +
          "数値では、この形の V̌' が T_{(V^{(+)})} と一致する（T_V_plus_eq_T_check_Vprime）ことで確認している" +
          "（sagemath/check/049_claim_even_sector_fermions/check_04, check_05）。",
      ],
    },
  },

  {
    id: "evenfermi_006_claim_action_T_check_Vprime",
    kind: "claim",
    origin: { path: SRC, ordinal: 8 },
    title: { tex: String.raw`T_{(\check{V}')} \text{ の } \check\psi \text{ への作用}` },
    labels: ["action_of_T_check_Vprime_on_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right) = e^{+\gamma(\tilde\theta_\mu)}\,\check\psi_\mu^\dagger,
\qquad
T_{(\check{V}')}\!\left(\check\psi_\mu\right) = e^{-\gamma(\tilde\theta_\mu)}\,\check\psi_\mu`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X}`),
        "、",
        math(String.raw`\check{V}' = \exp(\check{X})`),
        "、",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
        " を用いる。すなわち ",
        math(String.raw`T_{(\check{V}')}(W) = \exp(\check{X})\,W\,\exp(-\check{X})`),
        " である。",
      ]),
      paragraph([
        "Step 1（1 項ぶんの交換子、",
        math(String.raw`\check\psi_\mu^\dagger`),
        " 側）。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu},\ \check\psi_\mu^\dagger\right]
= \delta_{\mu,\,\nu}\,\check\psi_\nu^\dagger`,
      ),
      paragraph([
        "を示す。",
        ref("anticommutator_of_check_psi"),
        " を ",
        math(String.raw`(\mu, M+1-\nu)`),
        " の対に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_{M+1-\nu},\ \check\psi_\mu^\dagger\right]_+
&= \left[\check\psi_\mu^\dagger,\ \check\psi_{M+1-\nu}\right]_+
   \quad (\because \text{反交換子の対称性}) \\
&= \delta_{M+1-\nu,\,M+1-\mu}\,I
   \quad (\because \check\psi\text{ の反交換関係}) \\
&= \delta_{\mu,\,\nu}\,I
   \quad (\because M+1-\nu = M+1-\mu \iff \mu = \nu)
\end{aligned}`,
      ),
      paragraph([
        "である（",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M+1-\nu \in \check{\mathcal{M}}`),
        " なので ",
        ref("anticommutator_of_check_psi"),
        " が適用できる）。また ",
        ref("anticommutator_of_check_psi"),
        " より ",
        math(String.raw`\left[\check\psi_\nu^\dagger, \check\psi_\mu^\dagger\right]_+ = 0`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}\,\check\psi_\mu^\dagger
&= \check\psi_\nu^\dagger\left(\check\psi_{M+1-\nu}\,\check\psi_\mu^\dagger\right)
   \quad (\because \text{行列の積の結合法則}) \\
&= \check\psi_\nu^\dagger\left(\delta_{\mu,\nu}I - \check\psi_\mu^\dagger\,\check\psi_{M+1-\nu}\right)
   \quad (\because \text{直前の反交換子の等式}\ ([\check\psi_{M+1-\nu}, \check\psi_\mu^\dagger]_+ = \delta_{\mu,\nu}I)) \\
&= \delta_{\mu,\nu}\,\check\psi_\nu^\dagger - \check\psi_\nu^\dagger\,\check\psi_\mu^\dagger\,\check\psi_{M+1-\nu}
   \quad (\because \text{行列の積の分配法則と結合法則}) \\
&= \delta_{\mu,\nu}\,\check\psi_\nu^\dagger + \check\psi_\mu^\dagger\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}
   \quad (\because \check\psi\text{ の反交換関係}\ ([\check\psi_\nu^\dagger, \check\psi_\mu^\dagger]_+ = 0))
\end{aligned}`,
      ),
      paragraph(["となる。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu},\ \check\psi_\mu^\dagger\right]
&= \check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}\,\check\psi_\mu^\dagger
   - \check\psi_\mu^\dagger\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}
   \quad (\because \text{交換子の定義}) \\
&= \left(\delta_{\mu,\nu}\,\check\psi_\nu^\dagger + \check\psi_\mu^\dagger\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}\right)
   - \check\psi_\mu^\dagger\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}
   \quad (\because \text{直前の式変形}) \\
&= \delta_{\mu,\,\nu}\,\check\psi_\nu^\dagger
   \quad (\because \text{同類項の統合})
\end{aligned}`,
      ),
      paragraph([
        "となり、上の式を得る。**",
        math(String.raw`\check{\mathcal{M}}`),
        " へ絞ったことで、合同式 ",
        math(String.raw`(1-\nu)+\mu \equiv 1 \pmod M`),
        " を ",
        math(String.raw`\mu \equiv \nu`),
        " に書き換える段が要らなくなっている。**",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`[\check{X}, \check\psi_\mu^\dagger] = \gamma(\tilde\theta_\mu)\,\check\psi_\mu^\dagger`),
        "）。",
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X}`),
        " の定義を代入する。",
        math(String.raw`\tfrac12 I`),
        " は任意の元と可換（",
        ref("scalar_identity_commutes"),
        "）なので交換子に寄与せず、交換子は第 1 引数について ",
        math(String.raw`\mathbb{C}`),
        " 線型だから、Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{X},\ \check\psi_\mu^\dagger\right]
&= \left[\sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)
   \left(\check\psi_\nu^\dagger\check\psi_{M+1-\nu} - \tfrac12 I\right),\ \check\psi_\mu^\dagger\right]
   \quad (\because \check{X}\text{ の定義}) \\
&= \sum_{\nu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\nu)
   \left[\check\psi_\nu^\dagger\check\psi_{M+1-\nu} - \tfrac12 I,\ \check\psi_\mu^\dagger\right]
   \quad (\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{\nu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\nu)\left[\check\psi_\nu^\dagger\check\psi_{M+1-\nu},\ \check\psi_\mu^\dagger\right]
   \quad (\because \text{スカラー行列は任意の元と可換なので } \left[\tfrac12 I,\ \check\psi_\mu^\dagger\right] = 0) \\
&= \sum_{\nu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\nu)\,\delta_{\mu,\,\nu}\,\check\psi_\nu^\dagger
   \quad (\because \text{Step 1}) \\
&= \gamma(\tilde\theta_\mu)\,\check\psi_\mu^\dagger
   \quad (\because \mu \in \check{\mathcal{M}} \text{ なので } \nu = \mu \text{ の項だけが残る})
\end{aligned}`,
      ),
      paragraph(["である。移項すると"]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}\,\check\psi_\mu^\dagger
&= \check\psi_\mu^\dagger\,\check{X} + \left[\check{X},\ \check\psi_\mu^\dagger\right]
   \quad (\because \text{交換子の定義}) \\
&= \check\psi_\mu^\dagger\,\check{X} + \gamma(\tilde\theta_\mu)\,\check\psi_\mu^\dagger
   \quad (\because \text{直前の式変形}) \\
&= \check\psi_\mu^\dagger\,\check{X} + \check\psi_\mu^\dagger\left(\gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{単位行列は乗法の単位元、スカラー倍は行列の積と可換}) \\
&= \check\psi_\mu^\dagger\left(\check{X} + \gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{行列の積の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "（008 章の ",
        ref("action_of_T_Vprime_on_psi"),
        " が ",
        math(String.raw`\mu`),
        " の符号で 3 通りに場合分けしていたのは添字集合が ",
        math(String.raw`\mathcal{M} = \{-M,\dots,-1,1,\dots,M\}`),
        " だったためである。ここでは ",
        math(String.raw`\mu`),
        " も和の添字 ",
        math(String.raw`\nu`),
        " も同じ ",
        math(String.raw`\check{\mathcal{M}}`),
        " を走るので、残る項が ",
        math(String.raw`\nu = \mu`),
        " ただ 1 つであることが直ちに分かり、合同式を解く段も場合分けも要らない。",
        ref("def_check_index_set"),
        " へ範囲を絞ったことの効果である。）",
      ]),
      paragraph([
        "Step 3（帰納法）。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\check{X}^n\,\check\psi_\mu^\dagger = \check\psi_\mu^\dagger\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^n`),
        " が成り立つ。",
        math(String.raw`n=0`),
        " では両辺 ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " で一致し、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}^{n+1}\check\psi_\mu^\dagger
&= \check{X}\left(\check{X}^{n}\check\psi_\mu^\dagger\right)
   \quad (\because \text{冪の定義と行列の積の結合法則}) \\
&= \check{X}\,\check\psi_\mu^\dagger\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^{n}
   \quad (\because \text{帰納法の仮定}) \\
&= \check\psi_\mu^\dagger\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^{n}
   \quad (\because \text{Step 2}) \\
&= \check\psi_\mu^\dagger\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^{n+1}
   \quad (\because \text{冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（指数関数へ）。Step 3 より各 ",
        math(String.raw`N`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{n=0}^{N}\frac{\check{X}^n}{n!}\right)\check\psi_\mu^\dagger
&= \sum_{n=0}^{N}\frac{\check{X}^n\check\psi_\mu^\dagger}{n!}
   \quad (\because \text{行列の積の分配法則}) \\
&= \sum_{n=0}^{N}\frac{\check\psi_\mu^\dagger
   \left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^n}{n!}
   \quad (\because \text{Step 3 を各項へ同時適用}) \\
&= \check\psi_\mu^\dagger\sum_{n=0}^{N}
   \frac{\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)^n}{n!}
   \quad (\because \text{行列の積の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("exp_converges"),
        " より両辺の部分和は ",
        math(String.raw`N \to \infty`),
        " で収束する。行列の積は連続（",
        ref("matrix_multiplication_continuity"),
        "）だから極限をとって",
      ]),
      displayMath(
        String.raw`\exp(\check{X})\,\check\psi_\mu^\dagger
= \check\psi_\mu^\dagger\,\exp\!\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)`,
      ),
      paragraph([
        "Step 5（結論）。準備として、",
        math(String.raw`c \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\exp(cI) = e^{c}I
\quad (\because \left(cI\right)^n = c^n I\ (n\in\mathbb{Z}_{\geq 0})\text{ と }\exp\text{ の級数定義})`,
      ),
      paragraph([
        "である。",
        math(String.raw`\check{X}+\gamma(\tilde\theta_\mu)I`),
        " と ",
        math(String.raw`-\check{X}`),
        " は可換（",
        ref("scalar_identity_commutes"),
        " と ",
        math(String.raw`\check{X}(-\check{X}) = (-\check{X})\check{X}`),
        "）だから ",
        ref("theorem_exp_product"),
        " が使えて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right)
&= \exp(\check{X})\,\check\psi_\mu^\dagger\,\exp(-\check{X})
   \quad (\because \text{証明冒頭の } T_{(\check{V}')} \text{ の表示}) \\
&= \check\psi_\mu^\dagger\,\exp\!\left(\check{X}+\gamma(\tilde\theta_\mu)I\right)\exp(-\check{X})
   \quad (\because \text{Step 4}) \\
&= \check\psi_\mu^\dagger\,\exp\!\left(\gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{可換な指数の積の法則}) \\
&= \check\psi_\mu^\dagger\left(e^{\gamma(\tilde\theta_\mu)}I\right)
   \quad (\because \text{準備の等式 } \exp(cI)=e^{c}I) \\
&= e^{+\gamma(\tilde\theta_\mu)}\,\check\psi_\mu^\dagger
   \quad (\because \text{単位行列は乗法の単位元、スカラー倍は行列の積と可換})
\end{aligned}`,
      ),
      paragraph([
        "Step 1'（",
        math(String.raw`\check\psi_\mu`),
        " 側）。",
        ref("anticommutator_of_check_psi"),
        " の ",
        math(String.raw`\left[\check\psi_{M+1-\nu}, \check\psi_\mu\right]_+ = 0`),
        " と ",
        math(String.raw`\left[\check\psi_\nu^\dagger, \check\psi_\mu\right]_+ = \delta_{\mu,\,M+1-\nu}I`),
        " より（",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        "、",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M+1-\nu \in \check{\mathcal{M}}`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}\,\check\psi_\mu
&= \check\psi_\nu^\dagger\left(\check\psi_{M+1-\nu}\,\check\psi_\mu\right)
   \quad (\because \text{行列の積の結合法則}) \\
&= \check\psi_\nu^\dagger\left(-\check\psi_\mu\,\check\psi_{M+1-\nu}\right)
   \quad (\because \check\psi\text{ の反交換関係}\ ([\check\psi_{M+1-\nu}, \check\psi_\mu]_+ = 0)) \\
&= -\left(\check\psi_\nu^\dagger\,\check\psi_\mu\right)\check\psi_{M+1-\nu}
   \quad (\because \text{行列の積の結合法則とスカラー倍}) \\
&= -\left(\delta_{\mu,\,M+1-\nu}I - \check\psi_\mu\,\check\psi_\nu^\dagger\right)\check\psi_{M+1-\nu}
   \quad (\because \check\psi\text{ の反交換関係}\ ([\check\psi_\nu^\dagger, \check\psi_\mu]_+ = \delta_{\mu,\,M+1-\nu}I)) \\
&= -\delta_{\mu,\,M+1-\nu}\,\check\psi_{M+1-\nu} + \check\psi_\mu\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}
   \quad (\because \text{行列の積の分配法則と結合法則})
\end{aligned}`,
      ),
      paragraph(["となる。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\nu^\dagger\check\psi_{M+1-\nu},\ \check\psi_\mu\right]
&= \check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}\,\check\psi_\mu
   - \check\psi_\mu\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}
   \quad (\because \text{交換子の定義}) \\
&= \left(-\delta_{\mu,\,M+1-\nu}\,\check\psi_{M+1-\nu} + \check\psi_\mu\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}\right)
   - \check\psi_\mu\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}
   \quad (\because \text{直前の式変形}) \\
&= -\delta_{\mu,\,M+1-\nu}\,\check\psi_{M+1-\nu}
   \quad (\because \text{同類項の統合})
\end{aligned}`,
      ),
      paragraph([
        "Step 2'（",
        math(String.raw`[\check{X}, \check\psi_\mu] = -\gamma(\tilde\theta_\mu)\check\psi_\mu`),
        "）。Step 2 と同様に、",
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X}`),
        " を代入し、交換子の第 1 引数についての線型性と ",
        ref("scalar_identity_commutes"),
        "（",
        math(String.raw`\tfrac12 I`),
        " は交換子に寄与しない）を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{X},\ \check\psi_\mu\right]
&= \left[\sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)
   \left(\check\psi_\nu^\dagger\check\psi_{M+1-\nu} - \tfrac12 I\right),\ \check\psi_\mu\right]
   \quad (\because \check{X}\text{ の定義}) \\
&= \sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)
   \left[\check\psi_\nu^\dagger\check\psi_{M+1-\nu} - \tfrac12 I,\ \check\psi_\mu\right]
   \quad (\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)
   \left[\check\psi_\nu^\dagger\check\psi_{M+1-\nu},\ \check\psi_\mu\right]
   \quad (\because \text{スカラー行列は任意の元と可換なので } \left[\tfrac12 I,\ \check\psi_\mu\right] = 0) \\
&= -\sum_{\nu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\nu)\,\delta_{\mu,\,M+1-\nu}\,\check\psi_{M+1-\nu}
   \quad (\because \text{Step 1'})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " のうち ",
        math(String.raw`\delta_{\mu,\,M+1-\nu} = 1`),
        " すなわち ",
        math(String.raw`M+1-\nu = \mu`),
        " を満たすものは ",
        math(String.raw`\nu = M+1-\mu`),
        " ただ 1 つであり、",
        ref("def_check_index_set"),
        " (2) よりこれは ",
        math(String.raw`\check{\mathcal{M}}`),
        " に属する（**合同式を解く段が消えている**）。この ",
        math(String.raw`\nu`),
        " に対して ",
        math(String.raw`M+1-\nu = \mu`),
        " なので ",
        math(String.raw`\check\psi_{M+1-\nu} = \check\psi_\mu`),
        " である（",
        math(String.raw`\gamma`),
        " の共役添字での不変性は ",
        ref("periodicity_of_check_fermi"),
        " (3)）。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{X},\ \check\psi_\mu\right]
&= -\gamma(\tilde\theta_{M+1-\mu})\,\check\psi_\mu
   \quad (\because \nu = M+1-\mu \text{ の項だけが残り、}\check\psi_{M+1-\nu} = \check\psi_\mu) \\
&= -\gamma(\tilde\theta_\mu)\,\check\psi_\mu
   \quad (\because \gamma\text{ の共役添字での不変性 (3)})
\end{aligned}`,
      ),
      paragraph(["である。移項すると"]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}\,\check\psi_\mu
&= \check\psi_\mu\,\check{X} + \left[\check{X},\ \check\psi_\mu\right]
   \quad (\because \text{交換子の定義}) \\
&= \check\psi_\mu\,\check{X} - \gamma(\tilde\theta_\mu)\,\check\psi_\mu
   \quad (\because \text{直前の式変形}) \\
&= \check\psi_\mu\,\check{X} - \check\psi_\mu\left(\gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{単位行列は乗法の単位元、スカラー倍は行列の積と可換}) \\
&= \check\psi_\mu\left(\check{X} - \gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{行列の積の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3'（帰納法）。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\check{X}^n\,\check\psi_\mu = \check\psi_\mu\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^n`),
        " が成り立つ。",
        math(String.raw`n=0`),
        " では両辺 ",
        math(String.raw`\check\psi_\mu`),
        " で一致し、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}^{n+1}\check\psi_\mu
&= \check{X}\left(\check{X}^{n}\check\psi_\mu\right)
   \quad (\because \text{冪の定義と行列の積の結合法則}) \\
&= \check{X}\,\check\psi_\mu\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^{n}
   \quad (\because \text{帰納法の仮定}) \\
&= \check\psi_\mu\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^{n}
   \quad (\because \text{Step 2'}) \\
&= \check\psi_\mu\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^{n+1}
   \quad (\because \text{冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4'（指数関数へ）。Step 3' より各 ",
        math(String.raw`N`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{n=0}^{N}\frac{\check{X}^n}{n!}\right)\check\psi_\mu
&= \sum_{n=0}^{N}\frac{\check{X}^n\check\psi_\mu}{n!}
   \quad (\because \text{行列の積の分配法則}) \\
&= \sum_{n=0}^{N}\frac{\check\psi_\mu
   \left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^n}{n!}
   \quad (\because \text{Step 3' を各項へ同時適用}) \\
&= \check\psi_\mu\sum_{n=0}^{N}
   \frac{\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)^n}{n!}
   \quad (\because \text{行列の積の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("exp_converges"),
        " より両辺の部分和は ",
        math(String.raw`N \to \infty`),
        " で収束する。行列の積は連続（",
        ref("matrix_multiplication_continuity"),
        "）だから極限をとって",
      ]),
      displayMath(
        String.raw`\exp(\check{X})\,\check\psi_\mu
= \check\psi_\mu\,\exp\!\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)`,
      ),
      paragraph([
        "Step 5'（結論）。",
        math(String.raw`\check{X}-\gamma(\tilde\theta_\mu)I`),
        " と ",
        math(String.raw`-\check{X}`),
        " は可換（",
        ref("scalar_identity_commutes"),
        " と ",
        math(String.raw`\check{X}(-\check{X}) = (-\check{X})\check{X}`),
        "）だから ",
        ref("theorem_exp_product"),
        " が使えて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(\check{V}')}\!\left(\check\psi_\mu\right)
&= \exp(\check{X})\,\check\psi_\mu\,\exp(-\check{X})
   \quad (\because \text{証明冒頭の } T_{(\check{V}')} \text{ の表示}) \\
&= \check\psi_\mu\,\exp\!\left(\check{X}-\gamma(\tilde\theta_\mu)I\right)\exp(-\check{X})
   \quad (\because \text{Step 4'}) \\
&= \check\psi_\mu\,\exp\!\left(-\gamma(\tilde\theta_\mu)I\right)
   \quad (\because \text{可換な指数の積の法則}) \\
&= \check\psi_\mu\left(e^{-\gamma(\tilde\theta_\mu)}I\right)
   \quad (\because \text{準備の等式 } \exp(cI)=e^{c}I) \\
&= e^{-\gamma(\tilde\theta_\mu)}\,\check\psi_\mu
   \quad (\because \text{単位行列は乗法の単位元、スカラー倍は行列の積と可換})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の action_of_T_Vprime_on_psi の半整数運動量版。008 章にあった μ の符号による 3 通りの場合分け" +
          "（a) μ ∈ {1..M}、b) μ = -k、c) μ = -M）は、添字を μ ∈ Z で扱い periodicity_of_check_fermi を先に" +
          "用意したことで不要になった。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_04（V̌' を行列指数関数から直接構成して共役を計算）。",
        "2026-08-19 の式変形統一で、Step 1・1' の移項と交換子への回収の散文を鎖へ開き、Step 2 末尾に同居していた移項を独立の鎖へ分け、" +
          "Step 2' の一行三操作を Step 2 と同形の一操作ずつへ分け、Step 3 の一行二等号と根拠の無い行を直し、" +
          "Step 5 の exp(γI)=e^γ I の後置きの注記を準備の等式へ移し、Steps 3'〜5' の「置き換えるだけで同じ計算」を Step 3〜5 と同形の鎖へ開いた。" +
          "機械識別子の行末根拠は人間可読な名前へ直した。内容と参照は変えていない。",
      ],
    },
  },

  {
    id: "evenfermi_007_claim_T_eq_on_check_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 9 },
    title: {
      tex: String.raw`T_{(V^{(+)})} \text{ と } T_{(\check{V}')} \text{ は } \check{Z}, \check{Y} \text{ 上で一致する}`,
    },
    labels: ["T_V_plus_eq_T_check_Vprime_on_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check{Z}_\mu\right) = T_{(\check{V}')}\!\left(\check{Z}_\mu\right),
\qquad
T_{(V^{(+)})}\!\left(\check{Y}_\mu\right) = T_{(\check{V}')}\!\left(\check{Y}_\mu\right)`,
      ),
      paragraph([
        "が成り立つ。",
        ref("T_V_eq_T_Vprime_on_hatZ_hatY"),
        " と違い ",
        math(String.raw`\gamma_2 = 0`),
        " による場合分け（同ブロックの「場合 2」）は不要である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " を固定する。",
        ref("def_V_plus_and_T_V_plus"),
        " (1)(3) より ",
        math(String.raw`V^{(+)} \in R^\times`),
        "、",
        ref("def_check_Vprime"),
        " (2) より ",
        math(String.raw`\check{V}'`),
        " も可逆なので、",
        ref("mat_conj"),
        " より ",
        math(String.raw`T_{(V^{(+)})}`),
        " と ",
        math(String.raw`T_{(\check{V}')}`),
        " はともに ",
        math(String.raw`\mathbb{C}`),
        " 線型写像である。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " をフェルミオンで書く）。",
        ref("diagonalization_check_P_D"),
        " より ",
        math(String.raw`\det\check{P}_\mu \neq 0`),
        " なので ",
        math(String.raw`\check{P}_\mu^{-1}`),
        " が存在する。その成分を ",
        math(String.raw`\check{P}_\mu^{-1} = \begin{pmatrix}q_{11} & q_{12} \\ q_{21} & q_{22}\end{pmatrix}`),
        "（",
        math(String.raw`q_{ij} \in \mathbb{C}`),
        "）とおくと、",
        ref("commutation_V_plus_check_psi"),
        " の proof で確かめた結合律と ",
        ref("def_check_fermi"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \left(\check{P}_\mu\check{P}_\mu^{-1}\right)
   \quad (\because \check{P}_\mu\check{P}_\mu^{-1} = I_{\mathrm{Mat}(2,\mathbb{C})}) \\
&= \left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)\check{P}_\mu^{-1}
   \quad (\because \text{行ベクトルと }2\times2\text{ 行列の積の結合法則}) \\
&= \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{P}_\mu^{-1}
   \quad (\because \check\psi_\mu^\dagger,\check\psi_\mu\text{ の定義})
\end{aligned}`,
      ),
      paragraph(["すなわち"]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_\mu
&= q_{11}\,\check\psi_\mu^\dagger + q_{21}\,\check\psi_\mu
   \quad (\because \text{行ベクトルと }2\times2\text{ 行列の積の定義}), \\
\check{Y}_\mu
&= q_{12}\,\check\psi_\mu^\dagger + q_{22}\,\check\psi_\mu
   \quad (\because \text{行ベクトルと }2\times2\text{ 行列の積の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（フェルミオン上での一致）。",
        ref("commutation_V_plus_check_psi"),
        " と ",
        ref("action_of_T_check_Vprime_on_check_psi"),
        " より、いずれも ",
        math(String.raw`e^{\pm\gamma(\tilde\theta_\mu)}`),
        " 倍であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right)
&= e^{+\gamma(\tilde\theta_\mu)}\,\check\psi_\mu^\dagger
   \quad (\because V^{(+)}\text{ と }\check\psi\text{ の交換関係}) \\
&= T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right)
   \quad (\because T_{(\check V')}\text{ の }\check\psi\text{ への作用}), \\
T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
&= e^{-\gamma(\tilde\theta_\mu)}\,\check\psi_\mu
   \quad (\because V^{(+)}\text{ と }\check\psi\text{ の交換関係}) \\
&= T_{(\check{V}')}\!\left(\check\psi_\mu\right)
   \quad (\because T_{(\check V')}\text{ の }\check\psi\text{ への作用})
\end{aligned}`,
      ),
      paragraph(["Step 3（線型性で移す）。Step 1・Step 2 と線型性より"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check{Z}_\mu\right)
&= T_{(V^{(+)})}\!\left(q_{11}\check\psi_\mu^\dagger + q_{21}\check\psi_\mu\right)
   \quad (\because \text{Step 1}) \\
&= q_{11}T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) + q_{21}T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
   \quad (\because T_{(V^{(+)})} \text{ の線型性}) \\
&= q_{11}T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right) + q_{21}T_{(\check{V}')}\!\left(\check\psi_\mu\right)
   \quad (\because \text{Step 2}) \\
&= T_{(\check{V}')}\!\left(q_{11}\check\psi_\mu^\dagger + q_{21}\check\psi_\mu\right)
   \quad (\because T_{(\check{V}')} \text{ の線型性}) \\
&= T_{(\check{V}')}\!\left(\check{Z}_\mu\right)
   \quad (\because \text{Step 1})
\end{aligned}`,
      ),
      paragraph([math(String.raw`\check{Y}_\mu`), " については"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check{Y}_\mu\right)
&= T_{(V^{(+)})}\!\left(q_{12}\check\psi_\mu^\dagger + q_{22}\check\psi_\mu\right)
   \quad (\because \text{Step 1}) \\
&= q_{12}T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) + q_{22}T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
   \quad (\because T_{(V^{(+)})} \text{ の線型性}) \\
&= q_{12}T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right) + q_{22}T_{(\check{V}')}\!\left(\check\psi_\mu\right)
   \quad (\because \text{Step 2}) \\
&= T_{(\check{V}')}\!\left(q_{12}\check\psi_\mu^\dagger + q_{22}\check\psi_\mu\right)
   \quad (\because T_{(\check{V}')} \text{ の線型性}) \\
&= T_{(\check{V}')}\!\left(\check{Y}_\mu\right)
   \quad (\because \text{Step 1})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_eq_T_Vprime_on_hatZ_hatY の半整数運動量版。008 章は γ_2(θ_μ) = 0 のとき ψ が存在しないため" +
          "「場合 2」（A(θ_μ) = I と T_Vprime_fixes_hatZ_hatY_when_gamma2_zero を経由）を必要としたが、" +
          "gamma_2_theta_tilde_nonzero によりその場合は起こらないので、008 章の「場合 1」に相当する議論だけで尽きる。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_05。",
        "2026-08-19 の式変形統一で、Step 1 の行末根拠を人間可読な名前へ直し、成分表示に根拠を補い、" +
          "Step 2 の二つの一致を各作用の固有値表示を介する鎖へ開き、Step 3 の鎖の両端に根拠を補って、" +
          "Y 成分の「同じ計算」を Z 成分と同形の鎖へ開いた。内容と参照は変えていない。",
      ],
    },
  },

  {
    id: "evenfermi_008_claim_T_eq",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`T_{(V^{(+)})} = T_{(\check{V}')}` },
    labels: ["T_V_plus_eq_T_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。すべての ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`T_{(V^{(+)})}(x) = T_{(\check{V}')}(x)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "Step 1（両者は単位的環準同型かつ線型）。",
        ref("def_V_plus_and_T_V_plus"),
        " (1)(3) より ",
        math(String.raw`V^{(+)} \in R^\times`),
        " かつ ",
        math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
        "、",
        ref("def_check_Vprime"),
        " (2) より ",
        math(String.raw`\check{V}'`),
        " は可逆で ",
        math(String.raw`T_{(\check{V}')} = T_{\check{V}'}`),
        " である。可逆元による共役は ",
        ref("conjugation_is_ring_homomorphism"),
        " より乗法的かつ単位的（",
        math(String.raw`T_g(I) = I`),
        "）であり、",
        ref("mat_conj"),
        " より線型である。",
      ]),
      paragraph([
        "Step 2（各 ",
        math(String.raw`Z_m, Y_m`),
        " 上で一致）。",
        ref("recover_Z_Y_from_check_Z_Y"),
        " より ",
        math(String.raw`m \in \{1,\dots,M\}`),
        " について",
      ]),
      displayMath(
        String.raw`Z_m = \frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_\mu\,e^{im\tilde\theta_\mu},
\qquad
Y_m = \frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\,e^{im\tilde\theta_\mu}`,
      ),
      paragraph([
        "である。",
        math(String.raw`e^{im\tilde\theta_\mu}/M \in \mathbb{C}`),
        " はスカラーなので、この復元公式と、Step 1 の線型性と、",
        ref("T_V_plus_eq_T_check_Vprime_on_check_Z_Y"),
        "（以下「",
        math(String.raw`\check{Z},\check{Y}`),
        " 上の一致」と呼ぶ）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(Z_m)
&= T_{(V^{(+)})}\!\left(\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_\mu\,e^{im\tilde\theta_\mu}\right)
   \quad (\because \text{復元公式}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M} e^{im\tilde\theta_\mu}\,T_{(V^{(+)})}\!\left(\check{Z}_\mu\right)
   \quad (\because \text{Step 1 の線型性}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M} e^{im\tilde\theta_\mu}\,T_{(\check{V}')}\!\left(\check{Z}_\mu\right)
   \quad (\because \check{Z},\check{Y}\text{ 上の一致}) \\
&= T_{(\check{V}')}\!\left(\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_\mu\,e^{im\tilde\theta_\mu}\right)
   \quad (\because \text{Step 1 の線型性}) \\
&= T_{(\check{V}')}(Z_m)
   \quad (\because \text{復元公式})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_m`),
        " についても",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(Y_m)
&= T_{(V^{(+)})}\!\left(\frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\,e^{im\tilde\theta_\mu}\right)
   \quad (\because \text{復元公式}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M} e^{im\tilde\theta_\mu}\,T_{(V^{(+)})}\!\left(\check{Y}_\mu\right)
   \quad (\because \text{Step 1 の線型性}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M} e^{im\tilde\theta_\mu}\,T_{(\check{V}')}\!\left(\check{Y}_\mu\right)
   \quad (\because \check{Z},\check{Y}\text{ 上の一致}) \\
&= T_{(\check{V}')}\!\left(\frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\,e^{im\tilde\theta_\mu}\right)
   \quad (\because \text{Step 1 の線型性}) \\
&= T_{(\check{V}')}(Y_m)
   \quad (\because \text{復元公式})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`T_{(V^{(+)})}(Y_m) = T_{(\check{V}')}(Y_m)`),
        "。",
      ]),
      paragraph(["Step 3（一致する元の集合）。"]),
      displayMath(
        String.raw`\mathcal{E} := \left\{\,x \in \mathrm{Mat}(2^M,\mathbb{C})\ :\
T_{(V^{(+)})}(x) = T_{(\check{V}')}(x)\,\right\}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`x, y \in \mathcal{E}`),
        "、",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        " について、Step 1 の線型性から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(\alpha x + \beta y)
&= \alpha T_{(V^{(+)})}(x) + \beta T_{(V^{(+)})}(y)
   \quad (\because \text{Step 1 の線型性}) \\
&= \alpha T_{(\check{V}')}(x) + \beta T_{(\check{V}')}(y)
   \quad (\because x, y \in \mathcal{E}) \\
&= T_{(\check{V}')}(\alpha x + \beta y)
   \quad (\because \text{Step 1 の線型性})
\end{aligned}`,
      ),
      paragraph([
        "ゆえ ",
        math(String.raw`\alpha x + \beta y \in \mathcal{E}`),
        "。Step 1 の乗法性（",
        ref("conjugation_is_ring_homomorphism"),
        "）から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(xy)
&= T_{(V^{(+)})}(x)\,T_{(V^{(+)})}(y)
   \quad (\because \text{共役は環準同型（乗法的）}) \\
&= T_{(\check{V}')}(x)\,T_{(\check{V}')}(y)
   \quad (\because x, y \in \mathcal{E}) \\
&= T_{(\check{V}')}(xy)
   \quad (\because \text{共役は環準同型（乗法的）})
\end{aligned}`,
      ),
      paragraph([
        "ゆえ ",
        math(String.raw`xy \in \mathcal{E}`),
        "。また Step 1 の単位性より ",
        math(String.raw`T_{(V^{(+)})}(I) = I = T_{(\check{V}')}(I)`),
        " なので ",
        math(String.raw`I \in \mathcal{E}`),
        "。すなわち ",
        math(String.raw`\mathcal{E}`),
        " は単位元を含み、和・スカラー倍・積について閉じる。",
      ]),
      paragraph([
        "Step 4（結論）。Step 2 より ",
        math(String.raw`S := \{Z_1,\dots,Z_M,Y_1,\dots,Y_M\} \subseteq \mathcal{E}`),
        " である。",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`\mathcal{A}`),
        "（",
        math(String.raw`S`),
        " を含み和・スカラー倍・積で閉じ単位元を含む最小の部分集合）について Step 3 より ",
        math(String.raw`\mathcal{A} \subseteq \mathcal{E}`),
        " であり、",
        ref("Z_Y_generate_algebra"),
        " より ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^M,\mathbb{C})`),
        " であるから",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2^M,\mathbb{C}) = \mathcal{A} \subseteq \mathcal{E} \subseteq \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\mathcal{E} = \mathrm{Mat}(2^M,\mathbb{C})`),
        "。これが statement である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_eq_T_Vprime の半整数運動量版。復元公式が recover_Z_Y_from_hatZ_hatY から " +
          "recover_Z_Y_from_check_Z_Y（半整数運動量版）へ差し替わるほかは同じ議論である。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_05（Z_m, Y_m だけでなく、" +
          "行列単位 e_{ij} 全体（2^M × 2^M 個）についても両者の共役が一致することを直接確認）。",
      ],
    },
  },

  {
    id: "evenfermi_009_claim_V_plus_eq_c_Vprime",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`V^{(+)} = c\,\check{V}' \text{（定数倍を除いて一致）}` },
    labels: ["V_plus_eq_c_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " が存在して",
      ]),
      displayMath(String.raw`V^{(+)} = c\,\check{V}'`),
      paragraph([
        "が成り立つ（",
        math(String.raw`V^{(+)}`),
        " は ",
        ref("def_V_plus_and_T_V_plus"),
        "、",
        math(String.raw`\check{V}'`),
        " は ",
        ref("def_check_Vprime"),
        "）。**",
        math(String.raw`c`),
        " の値の決定はここでは行わない。**",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`W := \left(\check{V}'\right)^{-1}V^{(+)}`),
        " は可逆）。",
        ref("def_V_plus_and_T_V_plus"),
        " (1) より ",
        math(String.raw`V^{(+)}`),
        " は可逆、",
        ref("def_check_Vprime"),
        " (2) より ",
        math(String.raw`\check{V}'`),
        " は可逆であり、可逆行列の逆行列も可逆である（",
        ref("def_invertible_elements_of_R"),
        "）。可逆行列の積は可逆なので ",
        math(String.raw`W`),
        " は可逆であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{V}'\,W
&= \check{V}'\left(\left(\check{V}'\right)^{-1}V^{(+)}\right)
   \quad (\because W := \left(\check{V}'\right)^{-1}V^{(+)}) \\
&= \left(\check{V}'\left(\check{V}'\right)^{-1}\right)V^{(+)}
   \quad (\because \text{行列の積の結合律}) \\
&= I\,V^{(+)}
   \quad (\because \text{可逆元の定義}) \\
&= V^{(+)}
   \quad (\because \text{行列積の単位元})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`W`),
        " はすべての元と可換）。",
        ref("T_V_plus_eq_T_check_Vprime"),
        "、",
        ref("def_V_plus_and_T_V_plus"),
        " (3)、",
        ref("def_check_Vprime"),
        " (2)、",
        ref("def_T_g"),
        " より、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}\,x\,\left(V^{(+)}\right)^{-1}
&= T_{(V^{(+)})}(x)
   \quad (\because \text{転送行列が定める共役作用}) \\
&= T_{(\check{V}')}(x)
   \quad (\because \text{二つの共役作用の一致}) \\
&= \check{V}'\,x\,\left(\check{V}'\right)^{-1}
   \quad (\because \text{転送行列が定める共役作用})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("conjugation_is_ring_homomorphism"),
        " の ",
        math(String.raw`(AB)^{-1} = B^{-1}A^{-1}`),
        " より Step 1 の ",
        math(String.raw`V^{(+)} = \check{V}'W`),
        " から ",
        math(String.raw`\left(V^{(+)}\right)^{-1} = W^{-1}\left(\check{V}'\right)^{-1}`),
        " である。したがって、左辺は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}x\left(V^{(+)}\right)^{-1}
&= \left(\check{V}'W\right)x\left(W^{-1}\left(\check{V}'\right)^{-1}\right)
   \quad (\because \text{Step 1 と積の逆元の公式}) \\
&= \check{V}'\left(W x W^{-1}\right)\left(\check{V}'\right)^{-1}
   \quad (\because \text{行列の積の結合律})
\end{aligned}`,
      ),
      paragraph([
        "と書ける。したがって ",
        math(String.raw`\check{V}'\left(WxW^{-1}\right)\left(\check{V}'\right)^{-1} = \check{V}'x\left(\check{V}'\right)^{-1}`),
        " である。可逆な ",
        math(String.raw`\check V'`),
        " と ",
        math(String.raw`W`),
        " を順に消去すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{V}'\left(WxW^{-1}\right)\left(\check{V}'\right)^{-1}
&= \check{V}'x\left(\check{V}'\right)^{-1}
   \quad (\because \text{上の二つの共役作用の一致}) \\
WxW^{-1}
&= x
   \quad (\because \check V' \text{ の可逆性}) \\
Wx
&= xW
   \quad (\because W \text{ の可逆性})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（スカラーであること）。Step 2 と ",
        ref("centralizer_is_scalar"),
        " より、ある ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在して ",
        math(String.raw`W = c\,I`),
        "。",
      ]),
      paragraph([
        "Step 4（",
        math(String.raw`c \neq 0`),
        "）。仮に ",
        math(String.raw`c = 0`),
        " なら ",
        math(String.raw`W = O`),
        "（零行列）だが、任意の ",
        math(String.raw`A`),
        " について ",
        math(String.raw`OA = O \neq I`),
        " なので ",
        math(String.raw`O`),
        " は可逆でなく、Step 1 に矛盾する。よって ",
        math(String.raw`c \in \mathbb{C}^\times`),
        "。",
      ]),
      paragraph([
        "Step 5（結論）。Step 1 と Step 3 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}
&= \check{V}'W
   \quad (\because \text{Step 1}) \\
&= \check{V}'\left(c\,I\right)
   \quad (\because \text{Step 3}) \\
&= c\left(\check{V}'I\right)
   \quad (\because \text{scalar\_identity\_commutes}) \\
&= c\,\check{V}'
\end{aligned}`,
      ),
      paragraph([
        "（スカラー倍が行列の積と可換であること（",
        ref("scalar_identity_commutes"),
        "）と ",
        math(String.raw`\check{V}'I = \check{V}'`),
        " を使った。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の V_eq_Vprime の半整数運動量版。008 章と同じく centralizer_is_scalar を用いる筋であり、" +
          "クリフォード群（def_clifford_group / V2_not_in_clifford_group）には依存しない。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_06（W = (V̌')^{-1} V^{(+)} がスカラー行列に" +
          "なることを確認し、その c が (2 sinh 2K_2)^{M/2} に一致することも併せて確認した。" +
          "ただし c の値そのものの証明は本章では行わない）。",
      ],
    },
  },
]);
