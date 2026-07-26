import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/016_even_sector_fermions.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_fermions",
    kind: "heading",
    level: 2,
    sourcePath: SRC,
    sourceOrdinal: 1,
    title: { text: "偶セクターのフェルミオンと V^{(+)} = c V̌'" },
    labels: [],
    conversion: { status: "added" },
  },

  {
    id: "evenfermi_000_remark_overview",
    kind: "remark",
    sourcePath: SRC,
    sourceOrdinal: 2,
    title: { text: "この章の目的と、008 章との違い" },
    labels: [],
    statement: [
      paragraph([
        ref("T_V_plus_check_Z_Y"),
        " と ",
        ref("diagonalization_check_P_D"),
        " により、半整数運動量では",
      ]),
      displayMath(
        String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\ \check{Y}_\mu\right) A\!\left(\tilde\theta_\mu\right),
\qquad
A\!\left(\tilde\theta_\mu\right) = \check{P}_\mu \check{D}_\mu \check{P}_\mu^{-1}`,
      ),
      paragraph([
        "が確立している。この章では ",
        math(String.raw`\check{P}_\mu`),
        " で基底を取り替えて**半整数運動量のフェルミオン** ",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger`),
        " を導入し、",
      ]),
      displayMath(
        String.raw`\check{V}' := \exp\!\left(\sum_{\mu=1}^{M}\gamma\!\left(\tilde\theta_\mu\right)
\left(\check\psi_\mu^\dagger\,\check\psi_{1-\mu} - \tfrac12\right)\right)`,
      ),
      paragraph([
        "を定めて、ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " について ",
        math(String.raw`V^{(+)} = c\,\check{V}'`),
        " が成り立つことまで示す。",
        math(String.raw`c`),
        " の値そのもの（",
        math(String.raw`c = (2\sinh 2K_2)^{M/2}`),
        "）と ",
        math(String.raw`V^{(+)}`),
        " の固有値は次章で扱う。",
      ]),
      paragraph(["**008 章との違いは 2 点である。**"]),
      list([
        [
          "**共役添字が ",
          math(String.raw`-\mu`),
          " ではなく ",
          math(String.raw`1-\mu`),
          " になる。** ",
          ref("def_half_integer_modes"),
          " (3) の ",
          math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
          " と、",
          ref("anticommutator_of_check_Z_Y"),
          " で対になる添字が ",
          math(String.raw`\mu+\nu \equiv 1 \pmod M`),
          " であることに対応する。したがって ",
          math(String.raw`\check{V}'`),
          " の各項は ",
          math(String.raw`\check\psi_\mu^\dagger\check\psi_{1-\mu}`),
          " である（008 章の ",
          ref("def_Vprime"),
          " は ",
          math(String.raw`\psi_\mu^\dagger\psi_{-\mu}`),
          "）。",
        ],
        [
          "**臨界点の場合分けが消える。** 008 章では ",
          ref("gamma_2_theta_is_0"),
          " により臨界点で ",
          math(String.raw`\gamma_2(\theta_M) = 0`),
          " となり、",
          ref("def_fermi"),
          " が ",
          math(String.raw`\mu = \pm M`),
          " で定義されず、",
          ref("def_Vprime"),
          " の和からその ",
          math(String.raw`\mu`),
          " を除き、",
          ref("A_theta_is_identity_when_gamma2_zero"),
          " と ",
          ref("T_Vprime_fixes_hatZ_hatY_when_gamma2_zero"),
          " で別扱いする必要があった。半整数運動量では ",
          ref("gamma_2_theta_tilde_nonzero"),
          " により ",
          math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
          " が**すべての ",
          math(String.raw`\mu`),
          " と、臨界点を含むすべての ",
          math(String.raw`K_1, K_2 > 0`),
          " について**成り立つので、",
          math(String.raw`\check\psi_\mu`),
          " はすべての ",
          math(String.raw`\mu \in \mathbb{Z}`),
          " について定義され、",
          math(String.raw`\check{V}'`),
          " の和は ",
          math(String.raw`\mu \in \{1,\dots,M\}`),
          " の全体にわたる。**この章に場合分けは 1 つも現れない。**",
        ],
      ]),
      paragraph([
        "**平方根の分枝の議論も要らなくなる。** 008 章の ",
        ref("anticommutator_of_psi"),
        " は、",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " が ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\nu`),
        " で同じ値を取ること（分枝の一致）を ",
        ref("def_sqrt_cc"),
        " の一価性から導く Step 0 を必要としていた。半整数運動量では ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4) により根号の値が非負実数 ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " に確定しているので、",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " の成分にも本章の計算にも根号が現れない。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evenfermi_001_definition_check_fermi",
    kind: "definition",
    sourcePath: SRC,
    sourceOrdinal: 3,
    title: { tex: String.raw`\check\psi_\mu, \check\psi_\mu^\dagger \text{（半整数運動量のフェルミオン）}` },
    labels: ["def_check_fermi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " とする。",
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
        "すなわち ",
        math(String.raw`r_\mu := \left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`b_\mu := \gamma_2(-\tilde\theta_\mu) \in \mathbb{C}^\times`),
        " と書いて",
      ]),
      displayMath(
        String.raw`\check\psi_\mu^\dagger
:= \frac{-r_\mu}{2\sqrt{M}\,b_\mu}\,\check{Z}_\mu + \frac{1}{2\sqrt{M}}\,\check{Y}_\mu,
\qquad
\check\psi_\mu
:= \frac{+r_\mu}{2\sqrt{M}\,b_\mu}\,\check{Z}_\mu + \frac{1}{2\sqrt{M}}\,\check{Y}_\mu`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " は ",
        ref("def_half_integer_modes"),
        "、行ベクトルと ",
        math(String.raw`2\times2`),
        " 行列の積は ",
        ref("calc_of_TxT_check_Z_Y"),
        " の規約）。",
      ]),
      paragraph([
        "**この定義はすべての ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について意味をもつ。** 実際 ",
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " なので ",
        math(String.raw`r_\mu > 0`),
        " であり、",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`b_\mu \neq 0`),
        " だから分母 ",
        math(String.raw`2\sqrt{M}\,b_\mu`),
        " は ",
        math(String.raw`0`),
        " でない。",
        ref("def_fermi"),
        " が ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu`),
        " に限られていたのに対し、**半整数運動量では除外される ",
        math(String.raw`\mu`),
        " が無い**（臨界点でも無い）。",
      ]),
      paragraph(["さらに次の 3 つの性質が成り立つ。"]),
      list([
        [
          "(1) **添字の周期性**：",
          math(String.raw`\check\psi_{\mu+M}^\dagger = \check\psi_\mu^\dagger`),
          "、",
          math(String.raw`\check\psi_{\mu+M} = \check\psi_\mu`),
          "。",
        ],
        [
          "(2) **共役添字**：",
          math(String.raw`\gamma_2(\tilde\theta_{1-\mu}) = \gamma_2(-\tilde\theta_\mu) = b_\mu`),
          "、",
          math(String.raw`\gamma_2(-\tilde\theta_{1-\mu}) = \gamma_2(\tilde\theta_\mu)`),
          "、",
          math(String.raw`r_{1-\mu} = r_\mu`),
          "。",
        ],
        [
          "(3) **",
          math(String.raw`\gamma`),
          " の対称性**：",
          math(String.raw`\gamma\!\left(\tilde\theta_{\mu+M}\right) = \gamma\!\left(\tilde\theta_\mu\right)`),
          "、",
          math(String.raw`\gamma\!\left(\tilde\theta_{1-\mu}\right) = \gamma\!\left(\tilde\theta_\mu\right)`),
          "（",
          math(String.raw`\gamma`),
          " は ",
          ref("def_gamma_theta_tilde_mu"),
          "）。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1, \gamma_2`),
        " が ",
        math(String.raw`\theta`),
        " に依存するのは ",
        math(String.raw`\cos\theta, \sin\theta, e^{i\theta}`),
        " を通じてのみであることを繰り返し使う。",
        math(String.raw`k \in \mathbb{Z}`),
        " について ",
        math(String.raw`\cos(\theta+2k\pi) = \cos\theta`),
        "、",
        math(String.raw`\sin(\theta+2k\pi) = \sin\theta`),
        "、および ",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`e^{i(\theta+2k\pi)} = e^{i\theta}`),
        " なので",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta + 2k\pi) = \gamma_1(\theta),
\qquad
\gamma_2(\theta + 2k\pi) = \gamma_2(\theta)
\qquad (k \in \mathbb{Z},\ \theta \in \mathbb{R})`,
      ),
      paragraph(["である（**", math(String.raw`\gamma_1, \gamma_2`), " の ", math(String.raw`2\pi`), " 周期性**）。"]),
      paragraph([
        "(1) ",
        ref("def_half_integer_modes"),
        " の証明 (2) より ",
        math(String.raw`\tilde\theta_{\mu+M} = \tilde\theta_\mu + 2\pi`),
        " なので、上の周期性より ",
        math(String.raw`\gamma_2(\tilde\theta_{\mu+M}) = \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`\gamma_2(-\tilde\theta_{\mu+M}) = \gamma_2(-\tilde\theta_\mu - 2\pi) = \gamma_2(-\tilde\theta_\mu)`),
        "。ゆえに ",
        math(String.raw`r_{\mu+M} = r_\mu`),
        "、",
        math(String.raw`b_{\mu+M} = b_\mu`),
        " であり、係数がすべて一致する。また ",
        ref("def_half_integer_modes"),
        " (2) より ",
        math(String.raw`\check{Z}_{\mu+M} = \check{Z}_\mu`),
        "、",
        math(String.raw`\check{Y}_{\mu+M} = \check{Y}_\mu`),
        " なので、定義式の両項が一致して (1) を得る。",
      ]),
      paragraph([
        "(2) ",
        ref("def_half_integer_modes"),
        " (3) より ",
        math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        " である。これを ",
        math(String.raw`\gamma_2`),
        " に代入して",
      ]),
      displayMath(
        String.raw`\gamma_2\!\left(\tilde\theta_{1-\mu}\right) = \gamma_2\!\left(-\tilde\theta_\mu\right) = b_\mu,
\qquad
\gamma_2\!\left(-\tilde\theta_{1-\mu}\right) = \gamma_2\!\left(\tilde\theta_\mu\right)`,
      ),
      paragraph([
        "を得る。したがって ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の ",
        math(String.raw`b_\mu = -\overline{\gamma_2(\tilde\theta_\mu)}`),
        " と ",
        math(String.raw`\left|\overline{z}\right| = |z|`),
        "（",
        ref("abs_basic_properties"),
        "）より",
      ]),
      displayMath(
        String.raw`r_{1-\mu} = \left|\gamma_2\!\left(\tilde\theta_{1-\mu}\right)\right|
= \left|b_\mu\right|
= \left|-\overline{\gamma_2\!\left(\tilde\theta_\mu\right)}\right|
= \left|\gamma_2\!\left(\tilde\theta_\mu\right)\right| = r_\mu`,
      ),
      paragraph([
        "（",
        math(String.raw`|-z| = |z|`),
        " も ",
        ref("abs_basic_properties"),
        "。）",
      ]),
      paragraph([
        "(3) ",
        ref("def_gamma_theta_tilde_mu"),
        " より ",
        math(String.raw`\gamma(\tilde\theta_\mu) = \mathrm{arccosh}\left(\gamma_1(\tilde\theta_\mu)\right)`),
        " であり、",
        math(String.raw`\mathrm{arccosh}`),
        " は写像なので、",
        math(String.raw`\gamma_1`),
        " の値が一致すれば ",
        math(String.raw`\gamma`),
        " の値も一致する。",
        math(String.raw`\tilde\theta_{\mu+M} = \tilde\theta_\mu + 2\pi`),
        " と周期性より ",
        math(String.raw`\gamma_1(\tilde\theta_{\mu+M}) = \gamma_1(\tilde\theta_\mu)`),
        "。また ",
        math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        " と ",
        math(String.raw`\cos(-\theta) = \cos\theta`),
        " より",
      ]),
      displayMath(
        String.raw`\gamma_1\!\left(\tilde\theta_{1-\mu}\right)
= c_1c_2^* - s_1s_2^*\cos\!\left(-\tilde\theta_\mu\right)
= c_1c_2^* - s_1s_2^*\cos\tilde\theta_\mu
= \gamma_1\!\left(\tilde\theta_\mu\right)`,
      ),
      paragraph(["である。よって (3) が従う。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_fermi の半整数運動量版。008 章では ψ_μ の定義に +i√(γ_2(θ_μ)γ_2(−θ_μ)) が現れるが、" +
          "relation_of_gamma_2_theta_tilde (5) より半整数運動量では √(γ_2(θ~)γ_2(−θ~)) = i|γ_2(θ~)| なので " +
          "+i·i|γ_2| = −|γ_2| となり、本章の係数 −r_μ に一致する（形は 008 章と同じで、根号が実数に確定した形になっている）。",
        "008 章の def_fermi は γ_2(θ_μ) ≠ 0 なる μ ∈ calM に限定されていたが、gamma_2_theta_tilde_nonzero により " +
          "半整数運動量ではその限定が不要になる。この違いが def_check_Vprime の和の範囲、および " +
          "T_V_plus_eq_T_check_Vprime_on_check_Z_Y の場合分けの消滅に直結する。",
        "M=2,3,4,5、μ = 1−M..M、5 組の (K1,K2)（臨界点上・近傍を含む）で (1)(2)(3) を数値確認済み" +
          "（sagemath/check/049_claim_even_sector_fermions/check_01 の (d)(e)）。",
      ],
    },
  },

  {
    id: "evenfermi_002_claim_anticommutator_check_psi",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 4,
    title: { tex: String.raw`\check\psi \text{ の反交換関係（対は } \mu+\nu \equiv 1 \pmod M\text{）}` },
    labels: ["anticommutator_of_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu, \nu \in \mathbb{Z}`),
        " について（",
        ref("def_check_fermi"),
        " より ",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger, \check\psi_\nu, \check\psi_\nu^\dagger`),
        " はすべて定義される）、",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+ = 0,
\qquad
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+ = \delta^M_{(\mu+\nu,\,1)}\,I,
\qquad
\left[\check\psi_\mu, \check\psi_\nu\right]_+ = 0`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "、",
        math(String.raw`\delta^M`),
        " は ",
        ref("def_delta_M"),
        "）。",
      ]),
      paragraph([
        ref("anticommutator_of_psi"),
        " では対になる添字が ",
        math(String.raw`\mu+\nu \equiv 0`),
        " だったのに対し、ここでは ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        " である。これは ",
        ref("anticommutator_of_check_Z_Y"),
        " の対がそうなっていることの帰結である。",
      ]),
      paragraph([
        "また ",
        ref("anticommutator_of_psi"),
        " は係数に現れる複素平方根の**分枝の一致**（",
        ref("def_sqrt_cc"),
        " の一価性）を Step 0 で必要としていたが、本主張の証明には根号が現れない。",
        ref("def_check_fermi"),
        " の係数 ",
        math(String.raw`r_\mu = \left|\gamma_2(\tilde\theta_\mu)\right|`),
        " は非負実数として一意に定まっているからである。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`a_\kappa := \gamma_2(\tilde\theta_\kappa)`),
        "、",
        math(String.raw`b_\kappa := \gamma_2(-\tilde\theta_\kappa)`),
        "、",
        math(String.raw`r_\kappa := |a_\kappa|`),
        "、",
        math(String.raw`c_\kappa := \dfrac{1}{2\sqrt{M}\,b_\kappa}`),
        " と略記する（",
        ref("def_check_fermi"),
        " より ",
        math(String.raw`r_\kappa > 0`),
        "、",
        math(String.raw`b_\kappa \neq 0`),
        " なのでいずれも定まる）。",
        ref("def_check_fermi"),
        " は",
      ]),
      displayMath(
        String.raw`\check\psi_\kappa^\dagger = c_\kappa\left(-r_\kappa\,\check{Z}_\kappa + b_\kappa\,\check{Y}_\kappa\right),
\qquad
\check\psi_\kappa = c_\kappa\left(+r_\kappa\,\check{Z}_\kappa + b_\kappa\,\check{Y}_\kappa\right)`,
      ),
      paragraph([
        "と書ける（",
        math(String.raw`c_\kappa b_\kappa = \frac{1}{2\sqrt{M}}`),
        " により ",
        ref("def_check_fermi"),
        " の第 2 項の係数と一致する）。また ",
        ref("anticommutator_of_check_Z_Y"),
        " より",
      ]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+ = 2M\,\delta^M_{(\mu+\nu,\,1)}\,I,
\qquad
\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ = 0,
\qquad
\left[\check{Y}_\mu, \check{Y}_\nu\right]_+ = 2M\,\delta^M_{(\mu+\nu,\,1)}\,I`,
      ),
      paragraph(["である。"]),

      paragraph([
        "Step 0（",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        " のときの係数の関係）。この場合 ",
        math(String.raw`\nu = (1-\mu) + kM`),
        " なる ",
        math(String.raw`k \in \mathbb{Z}`),
        " が存在する。",
        ref("def_check_fermi"),
        " の proof の (1)(2) の計算（",
        math(String.raw`\gamma_2`),
        " の ",
        math(String.raw`2\pi`),
        " 周期性と ",
        math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        "）より",
      ]),
      displayMath(
        String.raw`a_\nu = a_{1-\mu} = b_\mu,
\qquad
b_\nu = b_{1-\mu} = a_\mu,
\qquad
r_\nu = r_{1-\mu} = r_\mu`,
      ),
      paragraph([
        "である。さらに ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) より ",
        math(String.raw`a_\mu b_\mu = -r_\mu^2`),
        " なので",
      ]),
      displayMath(
        String.raw`b_\mu b_\nu = b_\mu a_\mu = -r_\mu^2,
\qquad
r_\mu r_\nu = r_\mu^2,
\qquad
c_\mu c_\nu = \frac{1}{4M\,b_\mu b_\nu} = \frac{1}{-4M\,r_\mu^2}`,
      ),
      paragraph([
        "を得る（",
        math(String.raw`r_\mu > 0`),
        " なので分母は ",
        math(String.raw`0`),
        " でない）。**ここが 008 章で平方根の分枝の一致を要した箇所に対応する。** 本章では ",
        math(String.raw`r_\kappa`),
        " が非負実数として一意に定まっているので、",
        math(String.raw`r_\nu = r_\mu`),
        " は絶対値の等式として直ちに従う。",
      ]),

      paragraph([
        "Step 1（第 1 式）。反交換子は両引数について ",
        math(String.raw`\mathbb{C}`),
        " 双線型（",
        math(String.raw`[\alpha X, \beta W]_+ = \alpha\beta[X,W]_+`),
        "）なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+
&= c_\mu c_\nu\Bigl(
   (-r_\mu)(-r_\nu)\left[\check{Z}_\mu,\check{Z}_\nu\right]_+
   + (-r_\mu)b_\nu\left[\check{Z}_\mu,\check{Y}_\nu\right]_+ \\
&\qquad\qquad
   + b_\mu(-r_\nu)\left[\check{Y}_\mu,\check{Z}_\nu\right]_+
   + b_\mu b_\nu\left[\check{Y}_\mu,\check{Y}_\nu\right]_+\Bigr) \\
&= c_\mu c_\nu\left(r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M\,\delta^M_{(\mu+\nu,\,1)}\,I
\end{aligned}`,
      ),
      paragraph([
        "（中間 2 項は ",
        math(String.raw`\left[\check{Z}_\kappa,\check{Y}_\lambda\right]_+ = 0`),
        " により消える。",
        math(String.raw`\left[\check{Y}_\mu,\check{Z}_\nu\right]_+ = \left[\check{Z}_\nu,\check{Y}_\mu\right]_+ = 0`),
        " も同様）。",
        math(String.raw`\delta^M_{(\mu+\nu,1)} = 0`),
        " なら全体が ",
        math(String.raw`0`),
        "。",
        math(String.raw`\delta^M_{(\mu+\nu,1)} = 1`),
        " のときは Step 0 より",
      ]),
      displayMath(String.raw`r_\mu r_\nu + b_\mu b_\nu = r_\mu^2 + \left(-r_\mu^2\right) = 0`),
      paragraph([
        "なので、やはり全体が ",
        math(String.raw`0`),
        "。よって ",
        math(String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+ = 0`),
        "。",
      ]),

      paragraph([
        "Step 2（第 3 式）。",
        math(String.raw`\check\psi_\kappa`),
        " では ",
        math(String.raw`\check{Z}_\kappa`),
        " の係数の符号が ",
        math(String.raw`-r_\kappa`),
        " から ",
        math(String.raw`+r_\kappa`),
        " に変わるだけであり、",
        math(String.raw`(+r_\mu)(+r_\nu) = (-r_\mu)(-r_\nu)`),
        " なので Step 1 とまったく同じ式になる。よって ",
        math(String.raw`\left[\check\psi_\mu, \check\psi_\nu\right]_+ = 0`),
        "。",
      ]),

      paragraph(["Step 3（第 2 式）。同じ展開で ", math(String.raw`\check{Z}`), " 分の係数の積が ", math(String.raw`(-r_\mu)(+r_\nu) = -r_\mu r_\nu`), " になるので"]),
      displayMath(
        String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+
= c_\mu c_\nu\left(-r_\mu r_\nu + b_\mu b_\nu\right)\cdot 2M\,\delta^M_{(\mu+\nu,\,1)}\,I`,
      ),
      paragraph([
        math(String.raw`\delta^M_{(\mu+\nu,1)} = 0`),
        " なら全体が ",
        math(String.raw`0`),
        "。",
        math(String.raw`\delta^M_{(\mu+\nu,1)} = 1`),
        " のときは Step 0 より ",
        math(String.raw`-r_\mu r_\nu + b_\mu b_\nu = -r_\mu^2 - r_\mu^2 = -2r_\mu^2`),
        " かつ ",
        math(String.raw`c_\mu c_\nu = \dfrac{1}{-4Mr_\mu^2}`),
        " なので",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+
= \frac{1}{-4M\,r_\mu^2}\cdot\left(-2r_\mu^2\right)\cdot 2M\,I
= \frac{-4M\,r_\mu^2}{-4M\,r_\mu^2}\,I = I`,
      ),
      paragraph([
        "である。2 つの場合を合わせて ",
        math(String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+ = \delta^M_{(\mu+\nu,1)}I`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の anticommutator_of_psi の半整数運動量版。008 章の Step 0（γ_2 の 2π 周期性 → 根号の中身の一致 → " +
          "写像の一価性から t_ν = t_μ）は、本章では「r_ν = r_μ（絶対値の等式）」に置き換わり、複素平方根の分枝の議論が消える。" +
          "根号の中身が正の実数に確定しているのは relation_of_gamma_2_theta_tilde (4) による。",
        "M=2,3,4,5、μ,ν = 1−M..M の全組、5 組の (K1,K2) で 3 式すべてを数値確認済み" +
          "（sagemath/check/049_claim_even_sector_fermions/check_01 の (a)(b)(c)、残差 ≤ 2e-15）。",
      ],
    },
  },

  {
    id: "evenfermi_003_claim_commutation_V_plus_check_psi",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 5,
    title: { tex: String.raw`V^{(+)} \text{ と } \check\psi \text{ の交換関係}` },
    labels: ["commutation_V_plus_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right)
= e^{+\gamma\left(\tilde\theta_\mu\right)}\,\check\psi_\mu^\dagger,
\qquad
T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
= e^{-\gamma\left(\tilde\theta_\mu\right)}\,\check\psi_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T_{(V^{(+)})}`),
        " は ",
        ref("def_V_plus_and_T_V_plus"),
        "、",
        math(String.raw`\gamma`),
        " は ",
        ref("def_gamma_theta_tilde_mu"),
        "）。とくに ",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        " より ",
        math(String.raw`e^{+\gamma(\tilde\theta_\mu)} = \lambda_{+,\mu} > 1 > \lambda_{-,\mu} = e^{-\gamma(\tilde\theta_\mu)} > 0`),
        " であり、2 つの固有値は**すべての ",
        math(String.raw`\mu`),
        " で分離している**（",
        ref("commutation_V_psi"),
        " の整数運動量版では臨界点の ",
        math(String.raw`\mu = \pm M`),
        " で両方 ",
        math(String.raw`1`),
        " になりうる）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_check_fermi"),
        " より ",
        math(String.raw`\begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu`),
        " である。",
        ref("linearity_of_T_on_check_Z_Y"),
        " の一般形（",
        math(String.raw`g \in R^\times`),
        " について ",
        math(String.raw`T_g`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " 線型）を ",
        ref("def_V_plus_and_T_V_plus"),
        " (1) の ",
        math(String.raw`V^{(+)} \in R^\times`),
        " に適用すると、",
        ref("def_V_plus_and_T_V_plus"),
        " (3) の ",
        math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
        " により ",
        math(String.raw`T_{(V^{(+)})}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " 線型である。",
        math(String.raw`\check{P}_\mu`),
        " の 4 成分は ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " に依らない複素数だから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right),\ T_{(V^{(+)})}\!\left(\check\psi_\mu\right)\right)
&= \left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)\check{P}_\mu
   \quad (\because T_{(V^{(+)})}\ \text{の線型性}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} A\!\left(\tilde\theta_\mu\right)\check{P}_\mu
   \quad (\because \text{T\_V\_plus\_check\_Z\_Y}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \left(\check{P}_\mu \check{D}_\mu \check{P}_\mu^{-1}\right)\check{P}_\mu
   \quad (\because \text{diagonalization\_check\_P\_D}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\,\check{D}_\mu \\
&= \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{D}_\mu
   \quad (\because \text{def\_check\_fermi}) \\
&= \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}
   \begin{pmatrix}\lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu}\end{pmatrix}
= \left(\lambda_{+,\mu}\,\check\psi_\mu^\dagger,\ \lambda_{-,\mu}\,\check\psi_\mu\right)
\end{aligned}`,
      ),
      paragraph([
        "（行ベクトルと ",
        math(String.raw`2\times2`),
        " 行列の積は ",
        ref("calc_of_TxT_check_Z_Y"),
        " の規約であり、結合律 ",
        math(String.raw`\left(\left(\check{Z},\check{Y}\right)A\right)\check{P} = \left(\check{Z},\check{Y}\right)\left(A\check{P}\right)`),
        " は成分ごとの計算で確かめられる。）両成分を比較して",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) = \lambda_{+,\mu}\,\check\psi_\mu^\dagger,
\qquad
T_{(V^{(+)})}\!\left(\check\psi_\mu\right) = \lambda_{-,\mu}\,\check\psi_\mu`,
      ),
      paragraph([
        "を得る。最後に ",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        " の ",
        math(String.raw`\lambda_{\pm,\mu} = e^{\pm\gamma(\tilde\theta_\mu)}`),
        " を代入すれば statement になる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の commutation_V_psi の半整数運動量版。008 章の statement は固有値を " +
          "γ_1 ± √(−γ_2γ_2(−)) の形で書いていたが、半整数運動量では lambda_eq_exp_gamma_theta_tilde により " +
          "e^{±γ(θ~_μ)} に確定しているので最初からその形で述べた（次段の T_{(V̌')} の作用と直接見比べられる）。",
        "V^{(+)} を行列指数関数から直接構成し、M=2,3,4,5、μ = 1−M..M、5 組の (K1,K2) で数値確認済み" +
          "（sagemath/check/049_claim_even_sector_fermions/check_02、残差 ≤ 4e-11）。",
      ],
    },
  },

  {
    id: "evenfermi_004_definition_check_Vprime",
    kind: "definition",
    sourcePath: SRC,
    sourceOrdinal: 6,
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
        String.raw`\check{X} := \sum_{\mu=1}^{M}\gamma\!\left(\tilde\theta_\mu\right)
\left(\check\psi_\mu^\dagger\,\check\psi_{1-\mu} - \tfrac12 I\right)
\ \in\ \mathrm{Mat}(2^M,\mathbb{C}),
\qquad
\check{V}' := \exp\!\left(\check{X}\right)`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`\gamma`),
        " は ",
        ref("def_gamma_theta_tilde_mu"),
        "、",
        math(String.raw`\check\psi`),
        " は ",
        ref("def_check_fermi"),
        "、",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "）。",
      ]),
      paragraph([
        "**和は ",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " の全体にわたり、例外はいっさい無い。** 実際 ",
        ref("def_check_fermi"),
        " により ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " と ",
        math(String.raw`\check\psi_{1-\mu}`),
        " はすべての ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について定義されるので、各項は well-defined である。",
        ref("def_Vprime"),
        " が和を ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu`),
        " に制限していたのは ",
        ref("gamma_2_theta_is_0"),
        " の臨界点の零点を避けるためだったが、",
        ref("gamma_2_theta_tilde_nonzero"),
        " より半整数運動量にはその零点が存在しない。",
      ]),
      paragraph([
        "また ",
        math(String.raw`\check{V}'`),
        " は可逆であり ",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp\left(-\check{X}\right)`),
        " である。したがって ",
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g`),
        " を ",
        math(String.raw`g = \check{V}'`),
        " として使えて",
      ]),
      displayMath(
        String.raw`T_{(\check{V}')}(W) := \check{V}'\,W\,\left(\check{V}'\right)^{-1}
= \exp\!\left(\check{X}\right)W\exp\!\left(-\check{X}\right)
\qquad \left(W \in \mathrm{Mat}(2^M,\mathbb{C})\right)`,
      ),
      paragraph(["が定義される。"]),
      paragraph([
        "さらに、和の添字を ",
        math(String.raw`\{1,\dots,M\}`),
        " と取ったことに恣意性は無い。",
        ref("def_check_fermi"),
        " (1)(3) の周期性より各項は ",
        math(String.raw`\mu`),
        " について ",
        math(String.raw`M`),
        " 周期なので、連続する ",
        math(String.raw`M`),
        " 個の整数の集合をどう取っても ",
        math(String.raw`\check{X}`),
        " は同じ行列になる。",
      ]),
    ],
    proof: [
      paragraph([
        "可逆性を示す。",
        math(String.raw`\check{X}`),
        " と ",
        math(String.raw`-\check{X}`),
        " は可換（",
        math(String.raw`\check{X}\left(-\check{X}\right) = -\check{X}^2 = \left(-\check{X}\right)\check{X}`),
        "）だから ",
        ref("theorem_exp_product"),
        " と ",
        ref("theorem_exp_zero"),
        " より",
      ]),
      displayMath(
        String.raw`\exp\!\left(\check{X}\right)\exp\!\left(-\check{X}\right)
= \exp\!\left(\check{X} + \left(-\check{X}\right)\right) = \exp(O) = I`,
      ),
      paragraph([
        "であり、同じ計算で左からの積も ",
        math(String.raw`I`),
        " になる。よって ",
        math(String.raw`\check{V}'`),
        " は可逆で ",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp\left(-\check{X}\right)`),
        "。",
      ]),
      paragraph([
        "添字集合の取り替えについて。",
        math(String.raw`\mu \in \mathbb{Z}`),
        " に対し ",
        math(String.raw`t_\mu := \gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\check\psi_{1-\mu} - \tfrac12 I\right)`),
        " とおく。",
        ref("def_check_fermi"),
        " (1) より ",
        math(String.raw`\check\psi_{\mu+M}^\dagger = \check\psi_\mu^\dagger`),
        " かつ ",
        math(String.raw`\check\psi_{1-(\mu+M)} = \check\psi_{(1-\mu)-M} = \check\psi_{1-\mu}`),
        "、同 (3) より ",
        math(String.raw`\gamma(\tilde\theta_{\mu+M}) = \gamma(\tilde\theta_\mu)`),
        " なので ",
        math(String.raw`t_{\mu+M} = t_\mu`),
        " である。したがって ",
        math(String.raw`n \in \mathbb{Z}`),
        " について ",
        math(String.raw`\sum_{\mu=n+1}^{n+M} t_\mu = \sum_{\mu=1}^{M} t_\mu`),
        "（各項が ",
        math(String.raw`M`),
        " 周期なので、剰余類 ",
        math(String.raw`\mu \bmod M`),
        " ごとにちょうど 1 つの項が現れ、その値は代表元の取り方に依らない）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_Vprime の半整数運動量版。相違点は 2 つ: (i) 対になる添字が −μ から 1−μ へ変わる" +
          "（def_half_integer_modes (3) と anticommutator_of_check_Z_Y の対に対応）、" +
          "(ii) 和の範囲から例外が消える（gamma_2_theta_tilde_nonzero）。",
        "008 章では和の範囲を限定してよい理由として「除外される μ では γ(θ_μ) = 0 なので寄与しない」" +
          "を述べる必要があったが、本章では除外する μ がそもそも無い。かわりに、添字集合を {1,…,M} と" +
          "取ることに恣意性が無いこと（各項の M 周期性）を statement に含めた。",
        "μ = 1..M の全項が実際に寄与する（γ(θ~_μ) > 0）ことを数値確認済み" +
          "（sagemath/check/049_claim_even_sector_fermions/check_03 の (e)、min γ ≥ 2.9e-2）。",
      ],
    },
  },

  {
    id: "evenfermi_005_claim_action_T_check_Vprime",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 7,
    title: { tex: String.raw`T_{(\check{V}')} \text{ の } \check\psi \text{ への作用}` },
    labels: ["action_of_T_check_Vprime_on_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right)
= e^{+\gamma\left(\tilde\theta_\mu\right)}\,\check\psi_\mu^\dagger,
\qquad
T_{(\check{V}')}\!\left(\check\psi_\mu\right)
= e^{-\gamma\left(\tilde\theta_\mu\right)}\,\check\psi_\mu`,
      ),
      paragraph([
        "が成り立つ。すなわち ",
        ref("commutation_V_plus_check_psi"),
        " の ",
        math(String.raw`T_{(V^{(+)})}`),
        " とまったく同じ作用をする。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X}`),
        " と ",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp\left(-\check{X}\right)`),
        " を用いる。以下 ",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "、",
        math(String.raw`\gamma_\kappa := \gamma(\tilde\theta_\kappa)`),
        " と略記する。",
      ]),

      paragraph([
        "Step 1（1 項ごとの交換子、",
        math(String.raw`\check\psi^\dagger`),
        " 側）。",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\nu^\dagger\,\check\psi_{1-\nu},\ \check\psi_\mu^\dagger\right]
= \delta^M_{(\mu-\nu,\,0)}\,\check\psi_\nu^\dagger`,
      ),
      paragraph([
        "を示す。",
        ref("commutator_via_anticommutators"),
        " の ",
        math(String.raw`[AB, C] = A[B,C]_+ - [A,C]_+B`),
        " を ",
        math(String.raw`A = \check\psi_\nu^\dagger`),
        "、",
        math(String.raw`B = \check\psi_{1-\nu}`),
        "、",
        math(String.raw`C = \check\psi_\mu^\dagger`),
        " として使う。",
        ref("anticommutator_of_check_psi"),
        " より",
      ]),
      displayMath(
        String.raw`\left[\check\psi_{1-\nu},\ \check\psi_\mu^\dagger\right]_+
= \left[\check\psi_\mu^\dagger,\ \check\psi_{1-\nu}\right]_+
= \delta^M_{(\mu+(1-\nu),\,1)}\,I
= \delta^M_{(\mu-\nu,\,0)}\,I,
\qquad
\left[\check\psi_\nu^\dagger,\ \check\psi_\mu^\dagger\right]_+ = 0`,
      ),
      paragraph([
        "である（1 つ目の等号は反交換子の対称性 ",
        math(String.raw`[X,W]_+ = XW + WX = [W,X]_+`),
        "、3 つ目は ",
        ref("def_delta_M"),
        " より ",
        math(String.raw`\mu + 1 - \nu \equiv 1 \iff \mu - \nu \equiv 0 \pmod M`),
        "）。よって",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\nu^\dagger\,\check\psi_{1-\nu},\ \check\psi_\mu^\dagger\right]
= \check\psi_\nu^\dagger\cdot\delta^M_{(\mu-\nu,\,0)}I - 0\cdot\check\psi_{1-\nu}
= \delta^M_{(\mu-\nu,\,0)}\,\check\psi_\nu^\dagger`,
      ),

      paragraph([
        "Step 2（",
        math(String.raw`\left[\check{X}, \check\psi_\mu^\dagger\right] = +\gamma_\mu\,\check\psi_\mu^\dagger`),
        "）。",
        math(String.raw`\left[\tfrac12 I, \check\psi_\mu^\dagger\right] = O`),
        "（",
        ref("scalar_identity_commutes"),
        "）と交換子の第 1 引数についての加法性・",
        math(String.raw`\mathbb{C}`),
        " 線型性、および Step 1 より",
      ]),
      displayMath(
        String.raw`\left[\check{X},\ \check\psi_\mu^\dagger\right]
= \sum_{\nu=1}^{M}\gamma_\nu\left[\check\psi_\nu^\dagger\check\psi_{1-\nu},\ \check\psi_\mu^\dagger\right]
= \sum_{\nu=1}^{M}\gamma_\nu\,\delta^M_{(\mu-\nu,\,0)}\,\check\psi_\nu^\dagger`,
      ),
      paragraph([
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " は ",
        math(String.raw`M`),
        " で割った余りが互いに異なる ",
        math(String.raw`M`),
        " 個の整数なので、",
        math(String.raw`\nu \equiv \mu \pmod M`),
        " を満たす ",
        math(String.raw`\nu`),
        " はちょうど 1 つ存在する。それを ",
        math(String.raw`\nu_0`),
        " と書くと ",
        math(String.raw`\nu_0 = \mu + kM`),
        " なる ",
        math(String.raw`k \in \mathbb{Z}`),
        " があり、",
        ref("def_check_fermi"),
        " (1) を ",
        math(String.raw`|k|`),
        " 回使って ",
        math(String.raw`\check\psi_{\nu_0}^\dagger = \check\psi_\mu^\dagger`),
        "、同 (3) より ",
        math(String.raw`\gamma_{\nu_0} = \gamma_\mu`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\left[\check{X},\ \check\psi_\mu^\dagger\right] = \gamma_{\nu_0}\,\check\psi_{\nu_0}^\dagger
= \gamma_\mu\,\check\psi_\mu^\dagger,
\qquad\text{すなわち}\qquad
\check{X}\,\check\psi_\mu^\dagger = \check\psi_\mu^\dagger\left(\check{X} + \gamma_\mu I\right)`,
      ),
      paragraph([
        "（最後の変形は ",
        math(String.raw`\check{X}\check\psi_\mu^\dagger - \check\psi_\mu^\dagger\check{X} = \gamma_\mu\check\psi_\mu^\dagger`),
        " を移項したもの。）",
        "**008 章の ",
        ref("action_of_T_Vprime_on_psi"),
        " ではこの段が ",
        math(String.raw`\mu \in \mathcal{M} = \{-M,\dots,-1,1,\dots,M\}`),
        " の 3 通りの場合分け（",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " / ",
        math(String.raw`\mu = -k`),
        " / ",
        math(String.raw`\mu = -M`),
        "）を要した。** 本章では添字を ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " のまま扱い、",
        ref("def_check_fermi"),
        " (1)(3) の ",
        math(String.raw`M`),
        " 周期性で 1 行に済む。",
      ]),

      paragraph([
        "Step 3（冪への持ち上げ）。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\check{X}^n\check\psi_\mu^\dagger = \check\psi_\mu^\dagger\left(\check{X} + \gamma_\mu I\right)^n`),
        " を ",
        math(String.raw`n`),
        " に関する帰納法で示す。",
        math(String.raw`n = 0`),
        " のときは両辺とも ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}^{n+1}\check\psi_\mu^\dagger
&= \check{X}\left(\check{X}^{n}\check\psi_\mu^\dagger\right) \\
&= \check{X}\,\check\psi_\mu^\dagger\left(\check{X} + \gamma_\mu I\right)^{n}
   \quad (\because \text{帰納法の仮定}) \\
&= \check\psi_\mu^\dagger\left(\check{X} + \gamma_\mu I\right)\left(\check{X} + \gamma_\mu I\right)^{n}
   \quad (\because \text{Step 2}) \\
&= \check\psi_\mu^\dagger\left(\check{X} + \gamma_\mu I\right)^{n+1}
\end{aligned}`,
      ),

      paragraph(["Step 4（指数関数へ）。Step 3 と有限和の分配より、", math(String.raw`N \in \mathbb{Z}_{\geq 0}`), " について"]),
      displayMath(
        String.raw`\left(\sum_{n=0}^{N}\frac{\check{X}^{n}}{n!}\right)\check\psi_\mu^\dagger
= \sum_{n=0}^{N}\frac{\check{X}^{n}\check\psi_\mu^\dagger}{n!}
= \check\psi_\mu^\dagger\sum_{n=0}^{N}\frac{\left(\check{X}+\gamma_\mu I\right)^{n}}{n!}`,
      ),
      paragraph([
        math(String.raw`N \to \infty`),
        " とすると ",
        ref("exp_converges"),
        " より両辺の級数は収束し、",
        ref("matrix_multiplication_continuity"),
        " より",
      ]),
      displayMath(
        String.raw`\exp\!\left(\check{X}\right)\check\psi_\mu^\dagger
= \check\psi_\mu^\dagger\exp\!\left(\check{X} + \gamma_\mu I\right)`,
      ),

      paragraph([
        "Step 5（結論、",
        math(String.raw`\check\psi^\dagger`),
        " 側）。",
        math(String.raw`\check{X} + \gamma_\mu I`),
        " と ",
        math(String.raw`-\check{X}`),
        " は可換（",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`\gamma_\mu I`),
        " は任意の元と可換、",
        math(String.raw`\check{X}`),
        " は ",
        math(String.raw`-\check{X}`),
        " と可換）だから ",
        ref("theorem_exp_product"),
        " が使えて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right)
&= \exp\!\left(\check{X}\right)\check\psi_\mu^\dagger\exp\!\left(-\check{X}\right) \\
&= \check\psi_\mu^\dagger\exp\!\left(\check{X}+\gamma_\mu I\right)\exp\!\left(-\check{X}\right)
   \quad (\because \text{Step 4}) \\
&= \check\psi_\mu^\dagger\exp\!\left(\left(\check{X}+\gamma_\mu I\right) + \left(-\check{X}\right)\right)
   \quad (\because \text{theorem\_exp\_product}) \\
&= \check\psi_\mu^\dagger\exp\!\left(\gamma_\mu I\right)
 = \check\psi_\mu^\dagger\cdot e^{\gamma_\mu}I
   \quad \left(\because \left(\gamma_\mu I\right)^{n} = \gamma_\mu^{n}I\ \text{ゆえ級数が}\ e^{\gamma_\mu}I\right) \\
&= e^{+\gamma\left(\tilde\theta_\mu\right)}\,\check\psi_\mu^\dagger
\end{aligned}`,
      ),

      paragraph([
        "Step 1'（1 項ごとの交換子、",
        math(String.raw`\check\psi`),
        " 側）。同じく ",
        ref("commutator_via_anticommutators"),
        " と ",
        ref("anticommutator_of_check_psi"),
        " より ",
        math(String.raw`\left[\check\psi_{1-\nu}, \check\psi_\mu\right]_+ = 0`),
        "、",
        math(String.raw`\left[\check\psi_\nu^\dagger, \check\psi_\mu\right]_+ = \delta^M_{(\nu+\mu,\,1)}I`),
        " なので",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\nu^\dagger\,\check\psi_{1-\nu},\ \check\psi_\mu\right]
= \check\psi_\nu^\dagger\cdot 0 - \delta^M_{(\nu+\mu,\,1)}I\cdot\check\psi_{1-\nu}
= -\delta^M_{(\nu+\mu,\,1)}\,\check\psi_{1-\nu}`,
      ),

      paragraph([
        "Step 2'（",
        math(String.raw`\left[\check{X}, \check\psi_\mu\right] = -\gamma_\mu\,\check\psi_\mu`),
        "）。Step 2 と同様に",
      ]),
      displayMath(
        String.raw`\left[\check{X},\ \check\psi_\mu\right]
= -\sum_{\nu=1}^{M}\gamma_\nu\,\delta^M_{(\nu+\mu,\,1)}\,\check\psi_{1-\nu}`,
      ),
      paragraph([
        math(String.raw`\nu \equiv 1-\mu \pmod M`),
        " を満たす ",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " はちょうど 1 つで、それを ",
        math(String.raw`\nu_1 = (1-\mu) + kM`),
        "（",
        math(String.raw`k \in \mathbb{Z}`),
        "）と書くと ",
        math(String.raw`1-\nu_1 = \mu - kM`),
        " なので ",
        ref("def_check_fermi"),
        " (1) より ",
        math(String.raw`\check\psi_{1-\nu_1} = \check\psi_\mu`),
        "。また ",
        ref("def_check_fermi"),
        " (1)(3) より ",
        math(String.raw`\gamma_{\nu_1} = \gamma\!\left(\tilde\theta_{1-\mu}\right) = \gamma_\mu`),
        "（(3) の第 2 式）。よって",
      ]),
      displayMath(
        String.raw`\left[\check{X},\ \check\psi_\mu\right] = -\gamma_\mu\,\check\psi_\mu,
\qquad\text{すなわち}\qquad
\check{X}\,\check\psi_\mu = \check\psi_\mu\left(\check{X} - \gamma_\mu I\right)`,
      ),

      paragraph([
        "Steps 3'〜5'。Step 3〜5 の計算で ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " を ",
        math(String.raw`\check\psi_\mu`),
        " に、",
        math(String.raw`+\gamma_\mu`),
        " を ",
        math(String.raw`-\gamma_\mu`),
        " に置き換えれば、そのまま同じ論法が通る（使っているのは Step 2' の関係式と、",
        ref("exp_converges"),
        "・",
        ref("matrix_multiplication_continuity"),
        "・",
        ref("theorem_exp_product"),
        " だけである）。結果は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(\check{V}')}\!\left(\check\psi_\mu\right)
&= \exp\!\left(\check{X}\right)\check\psi_\mu\exp\!\left(-\check{X}\right)
 = \check\psi_\mu\exp\!\left(\check{X}-\gamma_\mu I\right)\exp\!\left(-\check{X}\right) \\
&= \check\psi_\mu\exp\!\left(-\gamma_\mu I\right)
 = e^{-\gamma\left(\tilde\theta_\mu\right)}\,\check\psi_\mu
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の action_of_T_Vprime_on_psi の半整数運動量版。008 章の Step 2 / Step 2' は " +
          "μ ∈ calM = {−M,…,−1,1,…,M} に対する 3〜4 通りの場合分け（μ ∈ {1,…,M} / μ = −k / μ = −M）と、" +
          "そこでの γ_2, hatZ, hatY の周期性の個別確認を必要としていた。本章は添字を μ ∈ Z のまま扱い、" +
          "def_check_fermi (1)(3) の M 周期性で一様に処理できるので場合分けが消える。",
        "1 項ごとの交換子（Step 1 / Step 1'）、[X, ψ̌] の値（Step 2 / Step 2'）、T_{(V̌')} の作用を" +
          "それぞれ独立に数値検証済み（sagemath/check/049_claim_even_sector_fermions/check_03 の (a)(b)(c)(d)）。",
      ],
    },
  },

  {
    id: "evenfermi_006_claim_T_eq_on_check_Z_Y",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 8,
    title: {
      tex: String.raw`T_{(V^{(+)})} \text{ と } T_{(\check{V}')} \text{ は } \check{Z}, \check{Y} \text{ 上で一致する}`,
    },
    labels: ["T_V_plus_eq_T_check_Vprime_on_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。**すべての ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について**",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check{Z}_\mu\right) = T_{(\check{V}')}\!\left(\check{Z}_\mu\right),
\qquad
T_{(V^{(+)})}\!\left(\check{Y}_\mu\right) = T_{(\check{V}')}\!\left(\check{Y}_\mu\right)`,
      ),
      paragraph([
        "が成り立つ。",
        ref("T_V_eq_T_Vprime_on_hatZ_hatY"),
        " は ",
        math(String.raw`\gamma_2(\theta_\mu)`),
        " が ",
        math(String.raw`0`),
        " か否かで 2 つの場合に分かれていたが、",
        ref("gamma_2_theta_tilde_nonzero"),
        " により**ここには場合分けが無い**（フェルミオンを経由する経路だけで全 ",
        math(String.raw`\mu`),
        " が尽きる）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mu \in \mathbb{Z}`),
        " を固定する。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " を ",
        math(String.raw`\check\psi`),
        " で書く）。",
        ref("diagonalization_check_P_D"),
        " より ",
        math(String.raw`\det\check{P}_\mu \neq 0`),
        " なので ",
        math(String.raw`\check{P}_\mu^{-1}`),
        " が存在する。",
        math(String.raw`\check{P}_\mu^{-1} = \begin{pmatrix}q_{11} & q_{12} \\ q_{21} & q_{22}\end{pmatrix}`),
        "（各 ",
        math(String.raw`q_{ij} \in \mathbb{C}`),
        "）とおくと、",
        ref("def_check_fermi"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\check{P}_\mu^{-1} \\
&= \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{P}_\mu^{-1}
   \quad (\because \text{def\_check\_fermi}) \\
&= \left(q_{11}\check\psi_\mu^\dagger + q_{21}\check\psi_\mu,\ \
   q_{12}\check\psi_\mu^\dagger + q_{22}\check\psi_\mu\right)
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\check{Z}_\mu = q_{11}\check\psi_\mu^\dagger + q_{21}\check\psi_\mu`),
        "、",
        math(String.raw`\check{Y}_\mu = q_{12}\check\psi_\mu^\dagger + q_{22}\check\psi_\mu`),
        " である。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\check\psi`),
        " 上で 2 つの写像が一致すること）。",
        ref("commutation_V_plus_check_psi"),
        " と ",
        ref("action_of_T_check_Vprime_on_check_psi"),
        " より、どちらの写像も ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " を ",
        math(String.raw`e^{+\gamma(\tilde\theta_\mu)}`),
        " 倍、",
        math(String.raw`\check\psi_\mu`),
        " を ",
        math(String.raw`e^{-\gamma(\tilde\theta_\mu)}`),
        " 倍するので",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) = T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right),
\qquad
T_{(V^{(+)})}\!\left(\check\psi_\mu\right) = T_{(\check{V}')}\!\left(\check\psi_\mu\right)
\qquad \cdots (\star)`,
      ),
      paragraph([
        "Step 3（線型性で移す）。",
        ref("def_V_plus_and_T_V_plus"),
        " (1)(3) より ",
        math(String.raw`V^{(+)} \in R^\times`),
        " かつ ",
        math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
        "、",
        ref("def_check_Vprime"),
        " より ",
        math(String.raw`\check{V}'`),
        " も可逆なので、",
        ref("linearity_of_T_on_check_Z_Y"),
        " の一般形により両写像は ",
        math(String.raw`\mathbb{C}`),
        " 線型である。よって Step 1 の表示と ",
        math(String.raw`(\star)`),
        " から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(\check{Z}_\mu\right)
&= T_{(V^{(+)})}\!\left(q_{11}\check\psi_\mu^\dagger + q_{21}\check\psi_\mu\right) \\
&= q_{11}T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) + q_{21}T_{(V^{(+)})}\!\left(\check\psi_\mu\right)
   \quad (\because T_{(V^{(+)})}\ \text{の線型性}) \\
&= q_{11}T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right) + q_{21}T_{(\check{V}')}\!\left(\check\psi_\mu\right)
   \quad (\because (\star)) \\
&= T_{(\check{V}')}\!\left(q_{11}\check\psi_\mu^\dagger + q_{21}\check\psi_\mu\right)
   \quad (\because T_{(\check{V}')}\ \text{の線型性}) \\
&= T_{(\check{V}')}\!\left(\check{Z}_\mu\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\check{Y}_\mu`),
        " についても ",
        math(String.raw`q_{12}, q_{22}`),
        " で同じ計算をすればよい。",
        math(String.raw`\mu \in \mathbb{Z}`),
        " は任意だったので statement を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_eq_T_Vprime_on_hatZ_hatY の半整数運動量版。008 章の「場合 2（γ_2(θ_μ) = 0）」は " +
          "A_theta_is_identity_when_gamma2_zero と T_Vprime_fixes_hatZ_hatY_when_gamma2_zero を経由して " +
          "フェルミオンを使わずに扱う必要があったが、gamma_2_theta_tilde_nonzero によりその場合が起こらないので、" +
          "本章はフェルミオン経由の 1 本道になる（対応する 2 つのブロックの半整数運動量版は不要）。",
        "008 章は P_μ の可逆性をこのブロックの proof の中で det を計算して示していたが、" +
          "本章では diagonalization_check_P_D が det P̌_μ ≠ 0 を statement に含めているのでそれを引く。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_04 の (a)（M=2,3,4,5、μ = 1−M..M、" +
          "5 組の (K1,K2)、残差 ≤ 5e-11）。",
      ],
    },
  },

  {
    id: "evenfermi_007_claim_T_eq_as_maps",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 9,
    title: { tex: String.raw`T_{(V^{(+)})} = T_{(\check{V}')}` },
    labels: ["T_V_plus_eq_T_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。写像として",
      ]),
      displayMath(String.raw`T_{(V^{(+)})} = T_{(\check{V}')}`),
      paragraph([
        "が成り立つ。すなわち任意の ",
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について ",
        math(String.raw`T_{(V^{(+)})}(X) = T_{(\check{V}')}(X)`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（両写像は線型かつ乗法的・単位的）。",
        ref("def_V_plus_and_T_V_plus"),
        " (1)(3) より ",
        math(String.raw`V^{(+)} \in R^\times`),
        " かつ ",
        math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
        "、",
        ref("def_check_Vprime"),
        " より ",
        math(String.raw`\check{V}'`),
        " は可逆で ",
        math(String.raw`T_{(\check{V}')} = T_{\check{V}'}`),
        " である。可逆元 ",
        math(String.raw`g`),
        " による共役 ",
        math(String.raw`T_g`),
        " は ",
        ref("conjugation_is_ring_homomorphism"),
        " より乗法的かつ単位的（",
        math(String.raw`T_g(I) = I`),
        "）であり、",
        ref("mat_conj"),
        " より ",
        math(String.raw`\mathbb{C}`),
        " 線型である。",
      ]),
      paragraph([
        "Step 2（各 ",
        math(String.raw`Z_j, Y_j`),
        " 上で一致）。",
        ref("recover_Z_Y_from_check_Z_Y"),
        " より ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " について",
      ]),
      displayMath(
        String.raw`Z_j = \frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_\mu\,e^{ij\tilde\theta_\mu},
\qquad
Y_j = \frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\,e^{ij\tilde\theta_\mu}`,
      ),
      paragraph([
        "である。Step 1 の線型性と ",
        ref("T_V_plus_eq_T_check_Vprime_on_check_Z_Y"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(Z_j)
&= \frac{1}{M}\sum_{\mu=1}^{M} e^{ij\tilde\theta_\mu}\,T_{(V^{(+)})}\!\left(\check{Z}_\mu\right)
   \quad (\because \text{線型性、recover\_Z\_Y\_from\_check\_Z\_Y}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M} e^{ij\tilde\theta_\mu}\,T_{(\check{V}')}\!\left(\check{Z}_\mu\right)
   \quad (\because \text{T\_V\_plus\_eq\_T\_check\_Vprime\_on\_check\_Z\_Y}) \\
&= T_{(\check{V}')}(Z_j)
   \quad (\because \text{線型性、recover\_Z\_Y\_from\_check\_Z\_Y})
\end{aligned}`,
      ),
      paragraph([
        "同様に ",
        math(String.raw`T_{(V^{(+)})}(Y_j) = T_{(\check{V}')}(Y_j)`),
        " である。",
      ]),
      paragraph([
        "Step 3（一致する元の集合は部分代数）。",
      ]),
      displayMath(
        String.raw`\mathcal{E} := \left\{X \in \mathrm{Mat}(2^M,\mathbb{C})
\ :\ T_{(V^{(+)})}(X) = T_{(\check{V}')}(X)\right\}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`X, W \in \mathcal{E}`),
        "、",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        " について、Step 1 の線型性より",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}(\alpha X + \beta W)
= \alpha T_{(\check{V}')}(X) + \beta T_{(\check{V}')}(W)
= T_{(\check{V}')}(\alpha X + \beta W)`,
      ),
      paragraph([
        "なので ",
        math(String.raw`\alpha X + \beta W \in \mathcal{E}`),
        "。また Step 1 の乗法性より",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}(XW) = T_{(V^{(+)})}(X)T_{(V^{(+)})}(W)
= T_{(\check{V}')}(X)T_{(\check{V}')}(W) = T_{(\check{V}')}(XW)`,
      ),
      paragraph([
        "なので ",
        math(String.raw`XW \in \mathcal{E}`),
        "。単位性より ",
        math(String.raw`T_{(V^{(+)})}(I) = I = T_{(\check{V}')}(I)`),
        " ゆえ ",
        math(String.raw`I \in \mathcal{E}`),
        "。よって ",
        math(String.raw`\mathcal{E}`),
        " は単位元を含み和・スカラー倍・積で閉じる。",
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
        " を含み単位元を含んで和・スカラー倍・積で閉じる最小の部分集合）について、Step 3 より ",
        math(String.raw`\mathcal{A} \subseteq \mathcal{E}`),
        "。",
        ref("Z_Y_generate_algebra"),
        " より ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^M,\mathbb{C})`),
        " なので",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2^M,\mathbb{C}) = \mathcal{A} \subseteq \mathcal{E}
\subseteq \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\mathcal{E} = \mathrm{Mat}(2^M,\mathbb{C})`),
        "、これは ",
        math(String.raw`T_{(V^{(+)})} = T_{(\check{V}')}`),
        " を意味する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_eq_T_Vprime の半整数運動量版。008 章は Step 1 で T_{(V)} = T_V（合成が積による共役に一致すること）" +
          "をここで示していたが、014 章では def_V_plus_and_T_V_plus (3) がそれを済ませてあるのでそれを引く。" +
          "復元公式は recover_Z_Y_from_hatZ_hatY ではなく半整数運動量版の recover_Z_Y_from_check_Z_Y を使う。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_04 の (b)（Z_j, Y_j 上での一致と復元公式そのもの）" +
          "および (c)（ランダムな X についての一致。写像としての一致を Z, Y に依らない形で確認）。",
      ],
    },
  },

  {
    id: "evenfermi_008_claim_V_plus_eq_c_check_Vprime",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 10,
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
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`W := \left(\check{V}'\right)^{-1}V^{(+)}`),
        " は可逆で ",
        math(String.raw`V^{(+)} = \check{V}'W`),
        "）。",
        ref("def_V_plus_and_T_V_plus"),
        " (1) より ",
        math(String.raw`V^{(+)}`),
        " は可逆、",
        ref("def_check_Vprime"),
        " より ",
        math(String.raw`\check{V}'`),
        " は可逆であり、",
        ref("def_invertible_elements_of_R"),
        " (ii)(iii) より ",
        math(String.raw`\left(\check{V}'\right)^{-1}`),
        " も可逆、可逆元の積 ",
        math(String.raw`W`),
        " も可逆である。行列の積の結合律と ",
        math(String.raw`\check{V}'\left(\check{V}'\right)^{-1} = I`),
        " より",
      ]),
      displayMath(
        String.raw`\check{V}'W = \check{V}'\left(\left(\check{V}'\right)^{-1}V^{(+)}\right)
= \left(\check{V}'\left(\check{V}'\right)^{-1}\right)V^{(+)} = I\,V^{(+)} = V^{(+)}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`W`),
        " は全ての元と可換）。",
        ref("T_V_plus_eq_T_check_Vprime"),
        " と ",
        ref("def_V_plus_and_T_V_plus"),
        " (3) より、任意の ",
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について ",
        ref("mat_conj"),
        " の共役写像の書き下しで",
      ]),
      displayMath(
        String.raw`V^{(+)}X\left(V^{(+)}\right)^{-1}
= T_{(V^{(+)})}(X) = T_{(\check{V}')}(X)
= \check{V}'X\left(\check{V}'\right)^{-1}`,
      ),
      paragraph([
        "が成り立つ。Step 1 の ",
        math(String.raw`V^{(+)} = \check{V}'W`),
        " と ",
        ref("def_invertible_elements_of_R"),
        " (ii) の ",
        math(String.raw`(AB)^{-1} = B^{-1}A^{-1}`),
        " より ",
        math(String.raw`\left(V^{(+)}\right)^{-1} = W^{-1}\left(\check{V}'\right)^{-1}`),
        " なので、左辺は",
      ]),
      displayMath(
        String.raw`V^{(+)}X\left(V^{(+)}\right)^{-1}
= \left(\check{V}'W\right)X\left(W^{-1}\left(\check{V}'\right)^{-1}\right)
= \check{V}'\left(WXW^{-1}\right)\left(\check{V}'\right)^{-1}`,
      ),
      paragraph([
        "と書ける（結合律）。したがって ",
        math(String.raw`\check{V}'\left(WXW^{-1}\right)\left(\check{V}'\right)^{-1} = \check{V}'X\left(\check{V}'\right)^{-1}`),
        " であり、両辺に左から ",
        math(String.raw`\left(\check{V}'\right)^{-1}`),
        "、右から ",
        math(String.raw`\check{V}'`),
        " を掛けると ",
        math(String.raw`WXW^{-1} = X`),
        "。さらに右から ",
        math(String.raw`W`),
        " を掛けて",
      ]),
      displayMath(String.raw`WX = \left(WXW^{-1}\right)W = XW`),
      paragraph([
        "を得る。",
        math(String.raw`X`),
        " は任意だったので ",
        math(String.raw`W`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " のすべての元と可換である。",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`W`),
        " はスカラー）。Step 2 と ",
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
        " となるが、任意の ",
        math(String.raw`A`),
        " について ",
        math(String.raw`OA = O \neq I`),
        " なので ",
        math(String.raw`O`),
        " は可逆でなく、Step 1 の ",
        math(String.raw`W`),
        " の可逆性に矛盾する。よって ",
        math(String.raw`c \in \mathbb{C}^\times`),
        "。",
      ]),
      paragraph([
        "Step 5（結論）。Step 1 に Step 3 を代入して、",
        ref("scalar_identity_commutes"),
        " より",
      ]),
      displayMath(
        String.raw`V^{(+)} = \check{V}'W = \check{V}'\left(c\,I\right) = c\left(\check{V}'I\right) = c\,\check{V}'`,
      ),
      paragraph([
        "を得る。Step 4 より ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の V_eq_Vprime の半整数運動量版。証明の骨格（W := V'^{-1}V が中心の元 → centralizer_is_scalar → " +
          "可逆性から c ≠ 0）は同一で、クリフォード群には依存しない。",
        "c の値の決定はこの章では行わない。次章で c = (2 sinh 2K_2)^{M/2} を確定させ、V^{(+)} の固有値を得る。" +
          "数値では c = (2 sinh 2K_2)^{M/2} と一致することを M=2,3,4,5、5 組の (K1,K2) で確認してある" +
          "（sagemath/check/049_claim_even_sector_fermions/check_04 の (d)(e)。W のスカラー性と c の値の両方）。",
      ],
    },
  },
]);
