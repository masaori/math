import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "TV1_hatZ_hatY_021_claim_arg_gamma1_gamma2",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/020_claim_gamma1_gamma2の偏角.typ",
    sourceOrdinal: 21,
    title: { tex: String.raw`\arg(\gamma_1(\theta_\mu))` },
    labels: [],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\arg(\gamma_1(\theta_\mu))
= \begin{cases}
0 & \quad (\cos\theta_\mu \leq c_1 c_2^* / (s_1 s_2^*)) \\
\pi & \quad (\text{otherwise})
\end{cases}`,
      ),
    ],
    proof: [paragraph([todo("TODO")])],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_022_claim_gamma2_theta_is_0",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/021_claim_gamma2_thetaが0になる条件.typ",
    sourceOrdinal: 22,
    title: { tex: String.raw`\gamma_2(\theta_\mu) = 0 \text{ になる条件}` },
    labels: ["gamma_2_theta_is_0"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\gamma_2(\theta_\mu) = 0
\iff \begin{cases} \sin\theta_\mu = 0 \\ c_2 s_1 - c_1\cos\theta_\mu = 0 \end{cases}
\iff \begin{cases} \mu = \pm M \\ c_2 s_1 = c_1\cos\theta_\mu \end{cases}`,
      ),
    ],
    proof: [paragraph([todo("TODO")])],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_023_claim_relation_of_gamma2",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/022_claim_gamma2_thetaとgamma2_minus_thetaの関係.typ",
    sourceOrdinal: 23,
    title: { tex: String.raw`\gamma_2(\theta_\mu) \text{ と } \gamma_2(-\theta_\mu) \text{ の関係}` },
    labels: ["relation_of_gamma_2"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`),
      paragraph(["ゆえに、"]),
      displayMath(
        String.raw`\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = -|\gamma_2(\theta_\mu)|^2`,
      ),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(-\theta_\mu)
&= i\,e^{-i\theta_\mu} s_2^*\bigl(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2\bigr) \\
\overline{\gamma_2(\theta_\mu)}
&= \overline{i\,e^{i\theta_\mu} s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)} \\
&= (-i)\,e^{-i\theta_\mu}\,s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
= -\gamma_2(-\theta_\mu)
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_024_claim_arg_of_gamma2_mu",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/023_claim_gamma2_theta_muの積のarg.typ",
    sourceOrdinal: 24,
    title: {
      tex: String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)) = \pi`,
    },
    labels: ["arg_of_gamma_2_mu"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\bigl(\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)\bigr) = \pi`,
      ),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&= (i\,e^{i\theta_\mu})(i\,e^{-i\theta_\mu})(s_2^*)^2
  (c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2) \\
&= -(s_2^*)^2\bigl((c_1\cos\theta_\mu - s_1 c_2)^2 + \sin^2\theta_\mu\bigr) < 0
\end{aligned}`,
      ),
      paragraph(["積は負の実数であるから ", math(String.raw`\arg^{[0,2\pi)}(\cdot) = \pi`)]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の長大な展開を要点のみに圧縮。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_025_claim_arg_gamma2_sum",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/024_claim_gamma2_theta_mu_gamma2_minus_theta_muのarg.typ",
    sourceOrdinal: 25,
    title: {
      tex: String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)) + \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu))`,
    },
    labels: [],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)) + \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu))
= \begin{cases}
\pi & (\exists m \in \mathbb{Z}:\; 0 \leq \theta_+ + \theta_- - 2m\pi < 2\pi) \\
\pi + 2\pi & (\exists m \in \mathbb{Z}:\; 2\pi \leq \theta_+ + \theta_- - 2m\pi < 4\pi)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        ref("arg_of_gamma_2_mu"),
        " と ",
        ref("range_of_args_of_multiple_of_complex_numbers"),
        " より。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_026_claim_arg_gamma2_quotient",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/025_claim_gamma2の商のarg.typ",
    sourceOrdinal: 26,
    title: {
      tex: String.raw`\arg^{[0,2\pi)}\!\bigl(\gamma_2(\theta_\mu)/\gamma_2(-\theta_\mu)\bigr)`,
    },
    labels: [],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\Bigl(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\Bigr) = \text{???}`,
      ),
      paragraph([todo("TODO: 原文未完成。")]),
    ],
    proof: [],
    conversion: {
      status: "partially_simplified",
      notes: ["原文にプレースホルダー(???)があり未完成。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_027_claim_eigenvector_A_theta",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/026_claim_A_thetaの対角化_固有値と固有ベクトル.typ",
    sourceOrdinal: 27,
    title: { tex: String.raw`A(\theta_\mu) \text{ の固有値と固有ベクトル}` },
    labels: ["eigenvector_of_A_theta"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、", math(String.raw`A(\theta_\mu)`), " の固有値は"]),
      displayMath(
        String.raw`\lambda_{\pm,\mu}
:= \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}`,
      ),
      paragraph(["対応する固有ベクトルは："]),
      paragraph(["1) ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " のとき: 任意の ", math(String.raw`v \in \mathbb{C}^2 \setminus \{0\}`)]),
      paragraph(["2) ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " のとき: ", math(String.raw`c \in \mathbb{C}^\times`), " として"]),
      displayMath(
        String.raw`v_{\pm,\mu} = c \begin{pmatrix} \pm i\,\sqrt{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)} \\ \gamma_2(-\theta_\mu) \end{pmatrix}`,
      ),
    ],
    proof: [
      paragraph(["固有方程式："]),
      displayMath(
        String.raw`\lambda^2 - 2\gamma_1(\theta_\mu)\lambda + \gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 0`,
      ),
      paragraph([
        "より固有値を得る。固有ベクトルは ",
        math(String.raw`(A(\theta_\mu) - \lambda I)v = 0`),
        " の連立方程式を行基本変形で解くと得られる（詳細省略）。",
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の長大な行基本変形による固有ベクトル計算を省略。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_028_claim_P_mu_D_mu",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/027_claim_A_thetaの対角化_P_muとD_mu.typ",
    sourceOrdinal: 28,
    title: { tex: String.raw`A(\theta_\mu) \text{ の対角化 } (P_\mu,\, D_\mu)` },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathcal{M}`),
        "、",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " のとき、",
        ref("eigenvector_of_A_theta"),
        " の任意定数を ",
        math(String.raw`c = \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}`),
        " と選んで、",
      ]),
      displayMath(
        String.raw`P_\mu
:= \begin{pmatrix}
\dfrac{+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}
& \dfrac{-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2\sqrt{M}\,\gamma_2(-\theta_\mu)} \\[8pt]
\dfrac{1}{2\sqrt{M}} & \dfrac{1}{2\sqrt{M}}
\end{pmatrix},
\quad
D_\mu := \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix}`,
      ),
      paragraph(["とおけば ", math(String.raw`A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}`), "。"]),
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " のとき ",
        math(String.raw`A(\theta_\mu) = I`),
        "（単位行列）。",
      ]),
    ],
    proof: [
      paragraph([ref("eigenvector_of_A_theta"), " の固有ベクトルに任意定数を代入することで得られる。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_029_claim_a_theta_mu",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/028_claim_a_theta_mu.typ",
    sourceOrdinal: 29,
    title: { tex: String.raw`a(\theta_\mu)` },
    labels: ["equation_of_a_theta_mu"],
    statement: [
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " のとき、"]),
      displayMath(
        String.raw`\alpha_1 := \tanh K_1 \tanh K_2^*, \quad
\alpha_2 := (\tanh K_1)^{-1} \tanh K_2^*`,
      ),
      displayMath(
        String.raw`a(\theta_\mu)
:= \sqrt{\frac{(1 - \alpha_1 e^{i\theta_\mu})(1 - \alpha_2^{-1} e^{i\theta_\mu})}{(1 - \alpha_1 e^{-i\theta_\mu})(1 - \alpha_2^{-1} e^{-i\theta_\mu})}}`,
      ),
      paragraph(["と定めるとき、"]),
      displayMath(
        String.raw`a(\theta_\mu) = \sqrt{\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}
= \begin{cases}
\dfrac{\sqrt{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
& \bigl(0 \leq \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu)) \leq \tfrac{\pi}{2}
  \text{ or } \tfrac{3\pi}{2} < \cdots < 2\pi\bigr) \\[6pt]
-\dfrac{\sqrt{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
& \bigl(\tfrac{\pi}{2} < \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu)) \leq \tfrac{3\pi}{2}\bigr)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "Part A: ",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}/\gamma_2(-\theta_\mu)`),
        " と ",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)/\gamma_2(-\theta_\mu)}`),
        " の関係は ",
        ref("arg_of_gamma_2_mu"),
        " と複素数の引数計算（8ステップ）により求まる（詳細省略）。",
      ]),
      paragraph([
        "Part B: ",
        math(String.raw`x := e^{i\theta_\mu}`),
        " とおいて Euler 展開すると分子 ",
        math(String.raw`= (c_1+1)(1-\alpha_1 x)(1-\alpha_2^{-1}x)`),
        "、分母 ",
        math(String.raw`= (c_1+1)(1-\alpha_1 x^{-1})(1-\alpha_2^{-1}x^{-1})`),
        "。ここで ",
        math(String.raw`(c_1-1)/(c_1+1) = \alpha_1\alpha_2^{-1}`) ,
        "（",
        math(String.raw`= \tanh^2 K_1`),
        "）、",
        math(String.raw`(2s_1c_2)/(c_1+1) = \alpha_1 + \alpha_2^{-1}`),
        " を用いる。",
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の18ステップにわたる引数計算を大幅に圧縮。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_030_definition_fermi",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/029_definition_フェルミオン.typ",
    sourceOrdinal: 30,
    title: { text: "フェルミオン" },
    labels: ["def_fermi"],
    statement: [
      paragraph([
        math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`),
        " とする。",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
        math(String.raw`\psi_\mu^\dagger, \psi_\mu \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " を",
      ]),
      displayMath(
        String.raw`\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
:= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot P_\mu`,
      ),
      paragraph(["すなわち"]),
      displayMath(
        String.raw`\psi_\mu^\dagger
= \frac{+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}\hat{Z}_\mu^{(-)}
  + \frac{1}{2\sqrt{M}}\hat{Y}_\mu`,
      ),
      displayMath(
        String.raw`\psi_\mu
= \frac{-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}\hat{Z}_\mu^{(-)}
  + \frac{1}{2\sqrt{M}}\hat{Y}_\mu`,
      ),
      paragraph(["と定める。"]),
    ],
    proof: [],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の注（ホロノミック量子場との相違点）を省略。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_031_claim_V_psi_commutator",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/030_claim_Vとpsiの交換関係.typ",
    sourceOrdinal: 31,
    title: { tex: String.raw`V \text{ と } \psi \text{ の交換関係 (B.13)}` },
    labels: [],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`T_{(V)}(\psi_\mu^\dagger)
= \Bigl(\gamma_1(\theta_\mu) + \sqrt{-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}\Bigr)\psi_\mu^\dagger`,
      ),
      displayMath(
        String.raw`T_{(V)}(\psi_\mu)
= \Bigl(\gamma_1(\theta_\mu) - \sqrt{-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}\Bigr)\psi_\mu`,
      ),
    ],
    proof: [
      paragraph([ref("def_fermi"), " より "]),
      displayMath(
        String.raw`\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu`,
      ),
      paragraph([
        math(String.raw`T_{(V)}`),
        " の線形性（",
        ref("mat_conj"),
        "）と ",
        ref("T_V_hatZ_hatY"),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}\!\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) A(\theta_\mu) P_\mu \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu D_\mu
= \begin{pmatrix} \lambda_{+,\mu}\psi_\mu^\dagger & \lambda_{-,\mu}\psi_\mu \end{pmatrix}
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の詳細計算を要点に圧縮。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_032_claim_anticommutator_psi",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/031_claim_psiの反交換関係.typ",
    sourceOrdinal: 32,
    title: { tex: String.raw`\psi \text{ の反交換関係}` },
    labels: ["anticommutator_of_psi"],
    statement: [
      paragraph([math(String.raw`\mu, \nu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+ = 0, \quad
[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}, \quad
[\psi_\mu, \psi_\nu]_+ = 0`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_fermi"),
        " より ",
        math(String.raw`c_\mu := \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\psi_\mu^\dagger = c_\mu\bigl(+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\hat{Z}_\mu^{(-)} + \gamma_2(-\theta_\mu)\hat{Y}_\mu\bigr)`,
      ),
      paragraph([ref("anticommutator_of_hat_Z_and_hat_Y"), " を展開すると："]),
      displayMath(
        String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+
= c_\mu c_\nu\bigl(-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
+ \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr) \cdot 2M\,\delta^M_{\mu+\nu,0}\,I`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`),
        " のとき ",
        math(String.raw`\theta_\nu = -\theta_\mu`),
        " だから両項が相殺して ",
        math(String.raw`= 0`),
        "。",
        math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+`),
        " は符号が逆になり和になることで ",
        math(String.raw`= \delta^M_{\mu+\nu,0}\,I`),
        " を得る。",
        math(String.raw`[\psi_\mu, \psi_\nu]_+`),
        " は ",
        math(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+`),
        " と同様。",
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の三つの場合の計算を要点のみに圧縮。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_033_definition_Vprime",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/032_definition_Vprimeの定義.typ",
    sourceOrdinal: 33,
    title: { tex: String.raw`V' \text{ の定義}` },
    labels: ["def_Vprime"],
    statement: [
      displayMath(
        String.raw`V' := \exp\!\Biggl(+\sum_{\mu=1}^M \gamma(\theta_\mu)\Bigl(\psi_\mu^\dagger \psi_{-\mu} - \tfrac{1}{2}\Bigr)\Biggr)`,
      ),
    ],
    proof: [],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の注（ホロノミック量子場の定義との相違）を省略。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_034a_definition_gamma_theta_mu",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ",
    sourceOrdinal: 34,
    title: { tex: String.raw`\gamma(\theta_\mu) \text{ の定義}` },
    labels: [],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、", math(String.raw`\gamma_1(\theta_\mu) \geq 1`), " より well-defined であり、"]),
      displayMath(
        String.raw`\gamma(\theta_\mu) := \mathrm{arccosh}(\gamma_1(\theta_\mu)) \in \mathbb{R}_{\geq 0}`,
      ),
    ],
    proof: [],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_034b_claim_lambda_pm_exp_gamma",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ",
    sourceOrdinal: 34,
    title: { tex: String.raw`\lambda_{\pm,\mu} = e^{\pm\gamma(\theta_\mu)}` },
    labels: [],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\lambda_{+,\mu} = e^{\gamma(\theta_\mu)}, \quad \lambda_{-,\mu} = e^{-\gamma(\theta_\mu)}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`\det A(\theta_\mu) = 1`),
        " より ",
        math(String.raw`\lambda_{+,\mu}\cdot\lambda_{-,\mu} = 1`),
        "。",
        math(String.raw`\lambda_{+,\mu} + \lambda_{-,\mu} = 2\gamma_1(\theta_\mu) \geq 2 > 0`),
        " かつ積が正であるから両固有値は正。",
        math(String.raw`\gamma(\theta_\mu) \geq 0`),
        " を用いて ",
        math(String.raw`\lambda_{\pm,\mu} = e^{\pm\gamma(\theta_\mu)}`),
        " と書け、",
        math(String.raw`\cosh(\gamma(\theta_\mu)) = \gamma_1(\theta_\mu)`),
        " と定義が整合する。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_035_claim_det_A_theta",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/034_claim_det_A_theta_mu.typ",
    sourceOrdinal: 35,
    title: { tex: String.raw`\det A(\theta_\mu) = 1` },
    labels: [],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\det A(\theta_\mu) = 1, \quad
\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = 1, \quad
\lambda_{+,\mu} \cdot \lambda_{-,\mu} = 1`,
      ),
    ],
    proof: [
      paragraph([ref("factorization_of_A_theta"), " より ", math(String.raw`A(\theta_\mu) = B_1(\theta_\mu) \cdot B_2 \cdot B_1(\theta_\mu)`), " であり、"]),
      displayMath(
        String.raw`\det B_1(\theta_\mu) = \cosh^2 K_1 - \sinh^2 K_1 = 1, \quad
\det B_2 = \cosh^2(2K_2^*) - \sinh^2(2K_2^*) = 1`,
      ),
      paragraph([math(String.raw`\det A = (\det B_1)^2 \cdot \det B_2 = 1`)]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_036_claim_gamma1_geq_1",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/035_claim_gamma1_geq_1.typ",
    sourceOrdinal: 36,
    title: { tex: String.raw`\gamma_1(\theta_\mu) \geq 1` },
    labels: [],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\gamma_1(\theta_\mu) \geq 1`),
    ],
    proof: [
      displayMath(
        String.raw`\gamma_1(\theta_\mu)^2
= 1 - \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
\overset{\text{\ref{relation_of_gamma_2}}}{=} 1 + |\gamma_2(\theta_\mu)|^2 \geq 1`,
      ),
      paragraph([
        math(String.raw`\gamma_1(\theta_\mu) = c_1 c_2^* - s_1 s_2^*\cos\theta_\mu \geq c_1 c_2^* - s_1 s_2^* > 0`),
        "（",
        math(String.raw`\cosh > \sinh`),
        " より ",
        math(String.raw`c_1 c_2^* > s_1 s_2^*`),
        "）から正であるので ",
        math(String.raw`\gamma_1(\theta_\mu) \geq 1`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_037_claim_factorization_A_theta",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/036_claim_A_thetaの行列分解.typ",
    sourceOrdinal: 37,
    title: { tex: String.raw`A(\theta_\mu) \text{ の行列分解}` },
    labels: ["factorization_of_A_theta"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`B_1(\theta_\mu)
:= \begin{pmatrix}
\cosh K_1 & -ie^{i\theta_\mu}\sinh K_1 \\
ie^{-i\theta_\mu}\sinh K_1 & \cosh K_1
\end{pmatrix},
\quad
B_2 := \begin{pmatrix}
\cosh(2K_2^*) & i\sinh(2K_2^*) \\
-i\sinh(2K_2^*) & \cosh(2K_2^*)
\end{pmatrix}`,
      ),
      paragraph(["とおくと"]),
      displayMath(String.raw`A(\theta_\mu) = B_1(\theta_\mu) \cdot B_2 \cdot B_1(\theta_\mu)`),
    ],
    proof: [
      paragraph([
        ref("calc_of_TxT_hatZxhatY"),
        " より ",
        math(String.raw`T_{(V_1^{(\pm)})^{1/2}}`),
        " は ",
        math(String.raw`(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)`),
        " に右から ",
        math(String.raw`B_1(\theta_\mu)`),
        " を掛け、",
        math(String.raw`T_{(V_2)}`),
        " は右から ",
        math(String.raw`B_2`),
        " を掛ける。",
        math(String.raw`T_{(V)} = T_{(V_1^{(\pm)})^{1/2}} \circ T_{(V_2)} \circ T_{(V_1^{(\pm)})^{1/2}}`),
        " と ",
        ref("def_A_theta"),
        " の定義から ",
        math(String.raw`A(\theta_\mu) = B_1(\theta_\mu) B_2 B_1(\theta_\mu)`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_038_claim_action_T_Vprime_psi",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/037_claim_T_Vprimeのpsiへの作用.typ",
    sourceOrdinal: 38,
    title: { tex: String.raw`T_{(V')} \text{ の } \psi \text{ への作用}` },
    labels: ["action_of_T_Vprime_on_psi"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`T_{(V')}(\psi_\mu^\dagger) = e^{+\gamma(\theta_\mu)}\psi_\mu^\dagger,
\quad
T_{(V')}(\psi_\mu) = e^{-\gamma(\theta_\mu)}\psi_\mu`,
      ),
    ],
    proof: [
      paragraph([ref("def_Vprime"), " より ", math(String.raw`V' = e^X`), " ただし"]),
      displayMath(
        String.raw`X := +\sum_{\nu=1}^M \gamma(\theta_\nu)\Bigl(\psi_\nu^\dagger \psi_{-\nu} - \tfrac{1}{2}\Bigr)`,
      ),
      paragraph(["Step 1:", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger] = \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger`)]),
      displayMath(
        String.raw`\psi_\nu^\dagger \psi_{-\nu}\psi_\mu^\dagger
= \psi_\nu^\dagger(\delta^M_{\mu-\nu,0}\,I - \psi_\mu^\dagger\psi_{-\nu})
= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger + \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}`,
      ),
      paragraph([
        "（",
        ref("anticommutator_of_psi"),
        " の ",
        math(String.raw`[\psi_{-\nu}, \psi_\mu^\dagger]_+ = \delta^M_{\mu-\nu,0}I`),
        " と ",
        math(String.raw`[\psi_\nu^\dagger, \psi_\mu^\dagger]_+ = 0`),
        " を使用）",
      ]),
      paragraph(["Step 2:", math(String.raw`[X, \psi_\mu^\dagger] = +\gamma(\theta_\mu)\psi_\mu^\dagger`)]),
      displayMath(
        String.raw`[X, \psi_\mu^\dagger]
= +\sum_{\nu=1}^M \gamma(\theta_\nu)\,\delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
= +\gamma(\theta_\mu)\psi_\mu^\dagger`,
      ),
      paragraph([
        "（",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " は ",
        math(String.raw`\nu=\mu`),
        "、",
        math(String.raw`\mu = -k`),
        " は ",
        math(String.raw`\psi_{M-k}^\dagger = \psi_{-k}^\dagger`),
        "、",
        math(String.raw`\mu = -M`),
        " は ",
        ref("hatZ_hatY_M_periodicity"),
        " と ",
        ref("gamma2_theta_M_periodicity"),
        " を用いる）",
      ]),
      paragraph([
        "Step 3: 帰納法で ",
        math(String.raw`X^n \psi_\mu^\dagger = \psi_\mu^\dagger (X + \gamma(\theta_\mu)I)^n`),
        "。",
      ]),
      paragraph(["Step 4:", math(String.raw`e^X \psi_\mu^\dagger = \psi_\mu^\dagger e^{X+\gamma(\theta_\mu)I}`)]),
      paragraph(["Step 5: 結論"]),
      displayMath(
        String.raw`T_{(V')}(\psi_\mu^\dagger)
= e^X \psi_\mu^\dagger e^{-X}
= \psi_\mu^\dagger e^{X+\gamma(\theta_\mu)I} e^{-X}
= \psi_\mu^\dagger e^{+\gamma(\theta_\mu)I}
= e^{+\gamma(\theta_\mu)}\psi_\mu^\dagger`,
      ),
      paragraph([math(String.raw`T_{(V')}(\psi_\mu)`), " についても同様（符号反転）。"]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の詳細な周期性の場合分けを省略。Steps 3'–5' の対称的な計算を省略。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_039_claim_T_V_eq_T_Vprime",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/038_claim_T_V_eq_T_Vprime.typ",
    sourceOrdinal: 39,
    title: { tex: String.raw`T_{(V)} = T_{(V')}` },
    labels: [],
    statement: [
      displayMath(String.raw`T_{(V)} = T_{(V')}`),
      paragraph([
        "すなわち任意の ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " に対して ",
        math(String.raw`V x V^{-1} = V' x V'^{-1}`),
        "。",
      ]),
    ],
    proof: [paragraph([todo("TODO")])],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_040_claim_V_eq_cVprime",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/039_claim_V_eq_Vprime.typ",
    sourceOrdinal: 40,
    title: { tex: String.raw`V = c V' \text{（定数倍を除いて一致）}` },
    labels: [],
    statement: [
      paragraph(["ある ", math(String.raw`c \in \mathbb{C}^\times`), " が存在して "]),
      displayMath(String.raw`V = c \cdot V'`),
    ],
    proof: [paragraph([todo("TODO: T の単射性（クリフォード群の性質）を用いる")])],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_041_claim_gamma2_periodicity",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/040_claim_gamma2_thetaMの周期性.typ",
    sourceOrdinal: 41,
    title: {
      tex: String.raw`\gamma_2(\theta_M) = \gamma_2(\theta_{-M}),\;
\gamma_2(-\theta_M) = \gamma_2(-\theta_{-M})`,
    },
    labels: ["gamma2_theta_M_periodicity"],
    statement: [
      displayMath(
        String.raw`\gamma_2(\theta_M) = \gamma_2(\theta_{-M}), \quad
\gamma_2(-\theta_M) = \gamma_2(-\theta_{-M})`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta_M = 2\pi`),
        "、",
        math(String.raw`\theta_{-M} = -2\pi`),
        " より ",
        math(String.raw`e^{i\theta_M} = 1 = e^{i\theta_{-M}}`),
        "、",
        math(String.raw`\cos\theta_M = \cos\theta_{-M} = 1`),
        "、",
        math(String.raw`\sin\theta_M = \sin\theta_{-M} = 0`),
        "。",
        ref("def_A_theta"),
        " より",
      ]),
      displayMath(
        String.raw`\gamma_2(\theta_M)
= i \cdot 1 \cdot s_2^*(c_1 \cdot 1 - i \cdot 0 - s_1 c_2)
= i\,s_2^*(c_1 - s_1 c_2)
= \gamma_2(\theta_{-M})`,
      ),
      paragraph([math(String.raw`\gamma_2(-\theta_M) = \gamma_2(-\theta_{-M})`), " も同様。"]),
    ],
    conversion: { status: "converted" },
  },
]);
