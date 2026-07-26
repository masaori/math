import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

const SRC = "structured-latex/content/015_A_theta_tilde_diagonalization.ts";

export default defineBlocks([
  {
    id: "heading_A_theta_tilde_diagonalization",
    kind: "heading",
    level: 2,
    sourcePath: SRC,
    sourceOrdinal: 1,
    title: { tex: String.raw`\text{半整数運動量における } A(\tilde\theta) \text{ の対角化}` },
    labels: [],
    conversion: { status: "added" },
  },

  {
    id: "Athetatilde_000_remark_overview",
    kind: "remark",
    sourcePath: SRC,
    sourceOrdinal: 2,
    title: { text: "この章の目的と、整数運動量との違い" },
    labels: [],
    statement: [
      paragraph([
        ref("def_half_integer_modes"),
        " の半整数運動量 ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M}`),
        " における ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\tilde\theta_\mu)`),
        " を対角化する。",
      ]),
      paragraph([
        "008 章は同じことを整数運動量 ",
        math(String.raw`\theta_\mu = \dfrac{2\pi\mu}{M}`),
        " について行っているが、そこでは ",
        ref("gamma_2_theta_is_0"),
        " の示すとおり ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " になる場合（",
        math(String.raw`\mu = \pm M`),
        " かつ ",
        math(String.raw`c_1 = s_1c_2`),
        "、すなわち臨界点）があり、そこでは ",
        ref("A_theta_is_identity_when_gamma2_zero"),
        " の ",
        math(String.raw`A(\theta_\mu) = I`),
        " として別扱いが要る。",
        "**半整数運動量では、この例外が起こらない**（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）。したがってこの章の主張はすべて ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について**場合分けなし**で述べられる。",
      ]),
      paragraph([
        "この違いは後段で効く。整数運動量では臨界点で ",
        math(String.raw`\gamma(\theta_M) = 0`),
        " となり最大固有値が縮退しうるのに対し、半整数運動量では ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " が常に成り立つ（",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        "）。",
      ]),
      paragraph([
        "**この章で扱うのは ",
        math(String.raw`A(\tilde\theta_\mu)`),
        " の対角化までである。** フェルミオン ",
        math(String.raw`\check\psi`),
        " の導入から先へは進まない。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "Athetatilde_001_definition_gamma1_gamma2",
    kind: "definition",
    sourcePath: SRC,
    sourceOrdinal: 3,
    title: { tex: String.raw`\gamma_1(\theta), \gamma_2(\theta)\ (\theta \in \mathbb{R})` },
    labels: ["def_gamma1_gamma2_of_theta"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        math(String.raw`\theta \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta) := c_1 c_2^* - s_1 s_2^*\cos\theta \in \mathbb{R},
\qquad
\gamma_2(\theta) := i\,e^{i\theta} s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1 c_2\bigr) \in \mathbb{C}`,
      ),
      paragraph([
        "と定める。このとき ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " は",
      ]),
      displayMath(
        String.raw`A(\theta) = \begin{pmatrix}
\gamma_1(\theta) & \gamma_2(\theta) \\
-\gamma_2(-\theta) & \gamma_1(\theta)
\end{pmatrix}`,
      ),
      paragraph([
        "と書ける。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_A_theta"),
        " の ",
        math(String.raw`(1,1)`),
        " 成分と ",
        math(String.raw`(2,2)`),
        " 成分は ",
        math(String.raw`c_1c_2^* - s_1s_2^*\cos\theta = \gamma_1(\theta)`),
        "、",
        math(String.raw`(1,2)`),
        " 成分は ",
        math(String.raw`ie^{i\theta}s_2^*(c_1\cos\theta - i\sin\theta - s_1c_2) = \gamma_2(\theta)`),
        " であり、定義そのものである。",
      ]),
      paragraph([
        math(String.raw`(2,1)`),
        " 成分については、",
        math(String.raw`\cos(-\theta) = \cos\theta`),
        "、",
        math(String.raw`\sin(-\theta) = -\sin\theta`),
        " より",
      ]),
      displayMath(
        String.raw`\gamma_2(-\theta)
= i\,e^{-i\theta}s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`-\gamma_2(-\theta) = -i\,e^{-i\theta}s_2^*(c_1\cos\theta + i\sin\theta - s_1c_2)`),
        " となり、",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(2,1)`),
        " 成分に一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の TV1_hatZ_hatY_020_definition_gamma1_gamma2 が同じ 2 つの量を θ_μ（整数運動量）に限って導入しているが、" +
          "そのブロックにはラベルが無く参照できない。半整数運動量 θ~_μ でも同じ式を使うので、ここで θ ∈ R の関数として" +
          "ラベル付きで定義し直した（式は 008 章のものと文字どおり同一。A(θ) 自体は def_A_theta を再定義していない）。",
      ],
    },
  },

  {
    id: "Athetatilde_002_claim_gamma2_nonzero",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 4,
    title: { tex: String.raw`\gamma_2(\tilde\theta_\mu) \neq 0 \text{（例外なし）}` },
    labels: ["gamma_2_theta_tilde_nonzero"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_half_integer_modes"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M}`),
        " について、**すべての ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " と、すべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " を含む）について**",
      ]),
      displayMath(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。したがって ",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`\gamma_2(-\tilde\theta_\mu) \neq 0`),
        " でもある。",
      ]),
      paragraph([
        "これは整数運動量との決定的な違いである。",
        ref("gamma_2_theta_is_0"),
        " では ",
        math(String.raw`\mu = \pm M`),
        " かつ ",
        math(String.raw`c_1 = s_1c_2`),
        " のとき ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " となり、008 章・009 章はそこを例外として別扱いしなければならなかった。**半整数運動量では、その例外処理が不要になる。**",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（正値性）。",
        ref("gamma_2_theta_is_0"),
        " の Step 0 と同じ議論により、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " から ",
        math(String.raw`K_2^* = -\tfrac12\log(\tanh K_2) > 0`),
        " が従い、",
      ]),
      displayMath(
        String.raw`c_1 = \cosh 2K_1 > 0,\quad s_1 = \sinh 2K_1 > 0,\quad
c_2 = \cosh 2K_2 > 0,\quad s_2^* = \sinh 2K_2^* > 0`,
      ),
      paragraph([
        "が成り立つ。",
      ]),
      paragraph([
        "Step 1（零点の必要条件）。",
        ref("def_gamma1_gamma2_of_theta"),
        " より ",
        math(String.raw`\gamma_2(\theta) = \left(i\,e^{i\theta}s_2^*\right)w(\theta)`),
        "、",
        math(String.raw`w(\theta) := c_1\cos\theta - i\sin\theta - s_1c_2`),
        " である。",
        math(String.raw`\left|i\,e^{i\theta}s_2^*\right| = s_2^* > 0`),
        "（",
        ref("abs_basic_properties"),
        " と ",
        ref("euler_formula_cos_sin"),
        "）なので第 1 因子は ",
        math(String.raw`0_{\mathbb{C}}`),
        " でなく、",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ零因子を持たないから",
      ]),
      displayMath(
        String.raw`\gamma_2(\theta) = 0_{\mathbb{C}} \iff w(\theta) = 0_{\mathbb{C}}
\iff \begin{cases} \sin\theta = 0 \\ c_1\cos\theta = s_1c_2 \end{cases}`,
      ),
      paragraph([
        "（",
        ref("definition_of_cc"),
        " の成分表示で ",
        math(String.raw`w(\theta) = (c_1\cos\theta - s_1c_2,\ -\sin\theta) \in \mathbb{R}^2 = \mathbb{C}`),
        " であり、零元は ",
        math(String.raw`(0,0)`),
        " である。ここまでは ",
        ref("gamma_2_theta_is_0"),
        " の Step 1・Step 2 と同じ計算で、",
        math(String.raw`\theta`),
        " が整数運動量か半整数運動量かに依存していない。）",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\sin\tilde\theta_\mu = 0`),
        " が要求すること）。",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " とする。実数 ",
        math(String.raw`t`),
        " に対する ",
        math(String.raw`\sin t = 0 \iff \exists k\in\mathbb{Z}: t = k\pi`),
        " より",
      ]),
      displayMath(
        String.raw`\sin\tilde\theta_\mu = 0
\iff \exists k \in \mathbb{Z}:\ \frac{2\pi\left(\mu-\frac12\right)}{M} = k\pi
\iff \exists k \in \mathbb{Z}:\ 2\mu - 1 = kM`,
      ),
      paragraph([
        "（両辺を ",
        math(String.raw`\pi`),
        " で割って ",
        math(String.raw`M`),
        " 倍し、",
        math(String.raw`2(\mu-\frac12) = 2\mu-1`),
        " を使った）。ここが整数運動量との分かれ目である：**左辺 ",
        math(String.raw`2\mu-1`),
        " は奇数**なので、",
        math(String.raw`kM`),
        " も奇数でなければならず、したがって ",
        math(String.raw`k`),
        " は奇数である（",
        math(String.raw`k`),
        " が偶数なら ",
        math(String.raw`kM`),
        " は偶数）。",
      ]),
      paragraph([
        "Step 3（そのとき ",
        math(String.raw`\cos\tilde\theta_\mu = -1`),
        "）。Step 2 の ",
        math(String.raw`\tilde\theta_\mu = k\pi`),
        " と ",
        math(String.raw`k`),
        " が奇数であることから、",
      ]),
      displayMath(
        String.raw`\cos\tilde\theta_\mu = \cos(k\pi) = (-1)^{k} = -1`,
      ),
      paragraph([
        "Step 4（矛盾）。Step 1 の第 2 式に Step 3 を代入すると",
      ]),
      displayMath(String.raw`s_1c_2 = c_1\cos\tilde\theta_\mu = -c_1`),
      paragraph([
        "が要求される。しかし Step 0 より ",
        math(String.raw`s_1c_2 > 0`),
        " かつ ",
        math(String.raw`-c_1 < 0`),
        " であり、これは矛盾である。よって Step 1 の連立条件は成り立たず、",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0_{\mathbb{C}}`),
        "。",
      ]),
      paragraph([
        "（",
        ref("gamma_2_theta_is_0"),
        " では ",
        math(String.raw`\sin\theta_\mu = 0`),
        " から ",
        math(String.raw`\cos\theta_\mu = +1`),
        "（",
        math(String.raw`\mu = \pm M`),
        "）と ",
        math(String.raw`\cos\theta_\mu = -1`),
        "（",
        math(String.raw`\mu = \pm M/2`),
        "）の 2 つの場合が生じ、矛盾で消せるのは後者だけだった。半整数運動量では ",
        math(String.raw`2\mu-1`),
        " が奇数であることにより ",
        math(String.raw`\cos\tilde\theta_\mu = +1`),
        " の場合が最初から起こらない。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "M = 2..8 の全 μ、および厳密な臨界点 sinh 2K_1 sinh 2K_2 = 1 とその近傍を含む 16 組の (K_1,K_2) で数値確認済み。" +
          "半整数運動量側の |γ_2(θ~_μ)| の最小値は 1.6e-1 で 0 から離れている一方、同じ K で整数運動量 θ = 2π では " +
          "臨界点ちょうどのとき |γ_2| ~ 1e-16（＝0）になる（sagemath/check/048_claim_A_theta_tilde/check_01）。",
        "sin θ~_μ = 0 となる (M, μ) は M が奇数のときの (2μ−1)/M が奇数の場合に限られ（μ ∈ {1,…,M} では k = 1 のみ）、" +
          "そこでは常に cos θ~_μ = −1 であることも M ≤ 40 の全探索で確認した（同 check_01 の (c)）。",
      ],
    },
  },

  {
    id: "Athetatilde_003_claim_relation_of_gamma2",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 5,
    title: {
      tex: String.raw`\gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)} \text{ とその帰結}`,
    },
    labels: ["relation_of_gamma_2_theta_tilde"],
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
        String.raw`\text{(1)}\quad \gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)},
\qquad
\text{(2)}\quad \gamma_2(\tilde\theta_\mu)\,\gamma_2(-\tilde\theta_\mu)
= -\left|\gamma_2(\tilde\theta_\mu)\right|^2 < 0`,
      ),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)`),
        " は**負の実数**であり（",
        ref("gamma_2_theta_tilde_nonzero"),
        " より狭義に負）、",
      ]),
      displayMath(
        String.raw`\text{(3)}\quad \arg^{[0,2\pi)}\!\left(\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)\right) = \pi,
\qquad
\text{(4)}\quad \sqrt{-\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)}
= \left|\gamma_2(\tilde\theta_\mu)\right| > 0`,
      ),
      displayMath(
        String.raw`\text{(5)}\quad \sqrt{\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)}
= i\left|\gamma_2(\tilde\theta_\mu)\right|`,
      ),
      paragraph([
        "も成り立つ（",
        math(String.raw`\sqrt{\ }`),
        " は ",
        ref("def_sqrt_cc"),
        " の、偏角を ",
        math(String.raw`[0,2\pi)`),
        " で取る一価の写像）。また ",
        math(String.raw`\gamma_2(-\tilde\theta_\mu) \neq 0`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("def_gamma1_gamma2_of_theta"),
        " より（",
        math(String.raw`\theta := \tilde\theta_\mu \in \mathbb{R}`),
        " と略記する）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(-\theta)
&= i\,e^{-i\theta}s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr) \\
\overline{\gamma_2(\theta)}
&= \overline{i\,e^{i\theta}s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)} \\
&= (-i)\,e^{-i\theta}\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
= -\gamma_2(-\theta)
\end{aligned}`,
      ),
      paragraph([
        "（複素共役は積・和を保ち、",
        math(String.raw`\overline{i} = -i`),
        "、",
        math(String.raw`\overline{e^{i\theta}} = e^{-i\theta}`),
        "、実数 ",
        math(String.raw`s_2^*, c_1\cos\theta, s_1c_2, \sin\theta`),
        " は不変である。）両辺に ",
        math(String.raw`-1`),
        " を掛けて (1) を得る。これは ",
        ref("relation_of_gamma_2"),
        " と同じ計算であり、",
        math(String.raw`\theta`),
        " が実数でありさえすれば成り立つ（整数運動量であることを使っていない）。",
      ]),
      paragraph([
        "(2) (1) と ",
        math(String.raw`z\overline{z} = |z|^2`),
        "（",
        ref("abs_basic_properties"),
        "）より",
      ]),
      displayMath(
        String.raw`\gamma_2(\theta)\gamma_2(-\theta)
= \gamma_2(\theta)\left(-\overline{\gamma_2(\theta)}\right)
= -\left|\gamma_2(\theta)\right|^2`,
      ),
      paragraph([
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`\gamma_2(\theta) \neq 0`),
        " なので ",
        math(String.raw`|\gamma_2(\theta)|^2 > 0`),
        "、したがってこの値は狭義に負の実数である。また (1) より ",
        math(String.raw`\gamma_2(-\theta) = -\overline{\gamma_2(\theta)} \neq 0`),
        "（複素共役は ",
        math(String.raw`0`),
        " を ",
        math(String.raw`0`),
        " にしか写さない）。",
      ]),
      paragraph([
        "(3) 負の実数の偏角は ",
        math(String.raw`\pi`),
        " である。すなわち ",
        math(String.raw`r := |\gamma_2(\theta)|^2 > 0`),
        " として ",
        math(String.raw`\gamma_2(\theta)\gamma_2(-\theta) = -r = r\,e^{i\pi}`),
        " であり、",
        math(String.raw`\pi \in [0,2\pi)`),
        " だから ",
        math(String.raw`\arg^{[0,2\pi)}(-r) = \pi`),
        "（",
        ref("angle_section_existence_uniqueness"),
        " の一意性）。これは ",
        ref("arg_of_gamma_2_mu"),
        " の半整数運動量版である。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`-\gamma_2(\theta)\gamma_2(-\theta) = |\gamma_2(\theta)|^2`),
        " は**正**の実数なので ",
        math(String.raw`\arg^{[0,2\pi)} = 0`),
        " であり、",
        ref("def_sqrt_cc"),
        " より",
      ]),
      displayMath(
        String.raw`\sqrt{-\gamma_2(\theta)\gamma_2(-\theta)}
= \sqrt{\left|\gamma_2(\theta)\right|^2}\;e^{i\cdot 0/2}
= \left|\gamma_2(\theta)\right| > 0`,
      ),
      paragraph([
        "（絶対値の非負平方根は ",
        ref("sqrt_nonnegative_existence_uniqueness"),
        " による。）",
      ]),
      paragraph([
        "(5) (3) より ",
        math(String.raw`\gamma_2(\theta)\gamma_2(-\theta)`),
        " は絶対値 ",
        math(String.raw`|\gamma_2(\theta)|^2`),
        "、偏角 ",
        math(String.raw`\pi`),
        " なので、",
        ref("def_sqrt_cc"),
        " より",
      ]),
      displayMath(
        String.raw`\sqrt{\gamma_2(\theta)\gamma_2(-\theta)}
= \left|\gamma_2(\theta)\right|\,e^{i\pi/2}
= i\left|\gamma_2(\theta)\right|`,
      ),
      paragraph([
        "（",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`e^{i\pi/2} = \cos\frac{\pi}{2} + i\sin\frac{\pi}{2} = i`),
        "。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "(4)(5) は 008 章では独立の主張になっていないが、半整数運動量では γ_2 ≠ 0 が常に成り立つため、" +
          "根号の中身が正の実数（(4)）・負の実数（(5)）に確定する。これにより後続の固有値・固有ベクトルの計算から" +
          "複素平方根の分枝の議論（008 章 eigenvector_of_A_theta が condition_of_commutativity_of_sqrt_and_product を" +
          "経由して行っていた部分）を追い出せる。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_02（M = 2..8 の全 μ、16 組の (K_1,K_2)、残差 ≤ 4e-15）。",
      ],
    },
  },

  {
    id: "Athetatilde_004_claim_eigenvector",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 6,
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ の固有値と固有ベクトル}` },
    labels: ["eigenvector_of_A_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について、",
        math(String.raw`A(\tilde\theta_\mu)`),
        " の固有値は",
      ]),
      displayMath(
        String.raw`\lambda_{\pm,\mu}
:= \gamma_1(\tilde\theta_\mu) \pm \sqrt{-\gamma_2(\tilde\theta_\mu)\,\gamma_2(-\tilde\theta_\mu)}
 = \gamma_1(\tilde\theta_\mu) \pm \left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}`,
      ),
      paragraph([
        "の 2 つであり（",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4) により根号は正の実数、したがって ",
        math(String.raw`\lambda_{+,\mu} \neq \lambda_{-,\mu}`),
        "）、対応する固有ベクトルは ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " として",
      ]),
      displayMath(
        String.raw`v_{\pm,\mu}
= c\begin{pmatrix} \pm i\,\sqrt{\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)} \\ \gamma_2(-\tilde\theta_\mu) \end{pmatrix}
= c\begin{pmatrix} \mp\left|\gamma_2(\tilde\theta_\mu)\right| \\ \gamma_2(-\tilde\theta_\mu) \end{pmatrix}`,
      ),
      paragraph([
        "である。",
        ref("eigenvector_of_A_theta"),
        " と違い、",
        math(String.raw`\gamma_2 = 0`),
        " の場合分けは**起こらない**（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`\theta := \tilde\theta_\mu`),
        "、",
        math(String.raw`g_1 := \gamma_1(\theta) \in \mathbb{R}`),
        "、",
        math(String.raw`a := \gamma_2(\theta) \in \mathbb{C}`),
        "、",
        math(String.raw`b := \gamma_2(-\theta) \in \mathbb{C}`),
        "、",
        math(String.raw`r := |a| \in \mathbb{R}_{>0}`),
        " と略記する（",
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`a \neq 0`),
        " なので ",
        math(String.raw`r > 0`),
        "）。",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`b = -\bar a`),
        "、",
        math(String.raw`ab = -r^2`),
        "、",
        math(String.raw`\sqrt{-ab} = r`),
        "、",
        math(String.raw`\sqrt{ab} = ir`),
        " である。",
      ]),
      paragraph([
        "Step 1（固有値がこの 2 つに限ること）。",
        ref("def_gamma1_gamma2_of_theta"),
        " より ",
        math(String.raw`A(\theta) = \begin{pmatrix} g_1 & a \\ -b & g_1\end{pmatrix}`),
        " なので、",
        math(String.raw`\lambda \in \mathbb{C}`),
        " が固有値であることは ",
        math(String.raw`\det(A(\theta) - \lambda I) = 0`),
        " と同値であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\det\left(A(\theta) - \lambda I\right)
&= (g_1-\lambda)(g_1-\lambda) - a\cdot(-b) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 + ab\right)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`ab = -r^2`),
        " を代入すると ",
        math(String.raw`\lambda^2 - 2g_1\lambda + (g_1^2 - r^2) = (\lambda - (g_1+r))(\lambda - (g_1-r))`),
        " と因数分解できる（右辺を展開すれば左辺に一致する）。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ零因子を持たないから、この積が ",
        math(String.raw`0`),
        " になるのは ",
        math(String.raw`\lambda = g_1 \pm r`),
        " のときに限る。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4) の ",
        math(String.raw`\sqrt{-ab} = r`),
        " より、これは statement の ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " に一致する。",
        math(String.raw`r > 0`),
        " なので ",
        math(String.raw`\lambda_{+,\mu} - \lambda_{-,\mu} = 2r \neq 0`),
        "。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`v_{\pm,\mu}`),
        " が固有ベクトルであること）。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (5) より ",
        math(String.raw`\pm i\sqrt{ab} = \pm i\cdot ir = \mp r`),
        " なので、statement の 2 つの表示は一致する。",
        math(String.raw`c = 1`),
        " として ",
        math(String.raw`v_\pm := (\mp r,\ b)^{\mathsf{T}}`),
        " を代入すると、",
        math(String.raw`b = -\bar a`),
        " と ",
        math(String.raw`a\bar a = r^2`),
        " より第 1 成分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A(\theta)v_\pm\right)_1
&= g_1(\mp r) + a\,b
 = \mp g_1 r + a\left(-\bar a\right)
 = \mp g_1 r - r^2 \\
&= \left(g_1 \pm r\right)\left(\mp r\right)
 = \lambda_{\pm,\mu}\,\left(v_\pm\right)_1
\end{aligned}`,
      ),
      paragraph(["第 2 成分は ", math(String.raw`-b = \bar a`), " より"]),
      displayMath(
        String.raw`\begin{aligned}
\left(A(\theta)v_\pm\right)_2
&= (-b)(\mp r) + g_1 b
 = \bar a\left(\mp r\right) + g_1\left(-\bar a\right)
 = \left(\mp r - g_1\right)\bar a \\
&= \left(g_1 \pm r\right)\left(-\bar a\right)
 = \lambda_{\pm,\mu}\,\left(v_\pm\right)_2
\end{aligned}`,
      ),
      paragraph([
        "（3 行目は ",
        math(String.raw`(\mp r - g_1) = -(g_1 \pm r)`),
        " による。）よって ",
        math(String.raw`A(\theta)v_\pm = \lambda_{\pm,\mu}v_\pm`),
        "。",
        math(String.raw`b \neq 0`),
        "（",
        ref("relation_of_gamma_2_theta_tilde"),
        "）より ",
        math(String.raw`v_\pm \neq 0`),
        " であり、これは固有ベクトルである。",
        math(String.raw`c \in \mathbb{C}^\times`),
        " 倍しても固有ベクトルであることは ",
        math(String.raw`A(\theta)(cv) = c\,A(\theta)v = c\lambda v = \lambda(cv)`),
        " による。",
      ]),
      paragraph([
        "Step 3（固有空間がこれで尽きること）。",
        math(String.raw`\lambda_{+,\mu} \neq \lambda_{-,\mu}`),
        " なので ",
        math(String.raw`A(\theta) - \lambda_{\pm,\mu}I \neq 0`),
        " であり（差を取ると ",
        math(String.raw`(\lambda_{-,\mu}-\lambda_{+,\mu})I \neq 0`),
        "）、その行列式は ",
        math(String.raw`0`),
        " なので階数は ",
        math(String.raw`1`),
        "、したがって各固有空間は ",
        math(String.raw`1`),
        " 次元である。ゆえに固有ベクトルは ",
        math(String.raw`v_{\pm,\mu}`),
        " の ",
        math(String.raw`\mathbb{C}^\times`),
        " 倍に限る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の eigenvector_of_A_theta は γ_2 = 0 の場合分けを持ち、γ_2 ≠ 0 の場合も複素平方根の分枝の扱い" +
          "（condition_of_commutativity_of_sqrt_and_product, inverse_of_sqrt_cc）を経由して固有ベクトルを導いていた。" +
          "半整数運動量では relation_of_gamma_2_theta_tilde (4)(5) で根号が |γ_2| と i|γ_2| に確定するので、" +
          "固有ベクトルは代入して確かめるだけで済む。得られる形は 008 章と同一である。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_03（特性方程式・固有ベクトル・Sage の固有値集合との一致、残差 ≤ 2e-12）。",
      ],
    },
  },

  {
    id: "Athetatilde_005_claim_diagonalization",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 7,
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ の対角化 } (\check{P}_\mu,\, \check{D}_\mu)` },
    labels: ["diagonalization_check_P_D"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について、",
        ref("eigenvector_of_A_theta_tilde"),
        " の任意定数を ",
        math(String.raw`c = \dfrac{1}{2\sqrt{M}\,\gamma_2(-\tilde\theta_\mu)}`),
        " と選んで",
      ]),
      displayMath(
        String.raw`\check{P}_\mu
:= \begin{pmatrix}
\dfrac{-\left|\gamma_2(\tilde\theta_\mu)\right|}{2\sqrt{M}\,\gamma_2(-\tilde\theta_\mu)}
& \dfrac{+\left|\gamma_2(\tilde\theta_\mu)\right|}{2\sqrt{M}\,\gamma_2(-\tilde\theta_\mu)} \\[8pt]
\dfrac{1}{2\sqrt{M}} & \dfrac{1}{2\sqrt{M}}
\end{pmatrix},
\qquad
\check{D}_\mu := \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu}\end{pmatrix}`,
      ),
      paragraph(["とおく。このとき"]),
      displayMath(
        String.raw`\det\check{P}_\mu
= \frac{-\left|\gamma_2(\tilde\theta_\mu)\right|}{2M\,\gamma_2(-\tilde\theta_\mu)} \neq 0_{\mathbb{C}},
\qquad
A(\tilde\theta_\mu) = \check{P}_\mu\,\check{D}_\mu\,\check{P}_\mu^{-1}`,
      ),
      paragraph([
        "が成り立つ。",
        ref("diagonalization_P_D"),
        " と違い ",
        math(String.raw`\gamma_2 = 0`),
        " の場合分けは不要である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("eigenvector_of_A_theta_tilde"),
        " の記号 ",
        math(String.raw`a := \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`b := \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`r := |a|`),
        " を使う。",
      ]),
      paragraph([
        "Step 1（各成分が定まること）。",
        ref("gamma_2_theta_tilde_nonzero"),
        " と ",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`a \neq 0`),
        " かつ ",
        math(String.raw`b \neq 0`),
        "。また ",
        math(String.raw`M \geq 2`),
        " より ",
        math(String.raw`\sqrt{M} > 0`),
        "（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。よって分母 ",
        math(String.raw`2\sqrt{M}\,b \neq 0`),
        " であり、",
        math(String.raw`c := \dfrac{1}{2\sqrt{M}\,b} \in \mathbb{C}^\times`),
        " が定まって ",
        math(String.raw`\check{P}_\mu`),
        " の 4 成分はすべて定まる。",
      ]),
      paragraph([
        "Step 2（2 つの列が固有ベクトルであること）。",
        ref("eigenvector_of_A_theta_tilde"),
        " の ",
        math(String.raw`v_{\pm,\mu} = c(\mp r,\ b)^{\mathsf{T}}`),
        " に上の ",
        math(String.raw`c`),
        " を代入すると、第 2 成分は ",
        math(String.raw`cb = \dfrac{1}{2\sqrt{M}}`),
        " となり、",
        math(String.raw`v_{+,\mu}, v_{-,\mu}`),
        " はそれぞれ ",
        math(String.raw`\check{P}_\mu`),
        " の第 1 列・第 2 列に一致する。行列の積を列ごとに見れば",
      ]),
      displayMath(
        String.raw`A(\tilde\theta_\mu)\,\check{P}_\mu
= \left(A(\tilde\theta_\mu)v_{+,\mu}\ \ A(\tilde\theta_\mu)v_{-,\mu}\right)
= \left(\lambda_{+,\mu}v_{+,\mu}\ \ \lambda_{-,\mu}v_{-,\mu}\right)
= \check{P}_\mu\,\check{D}_\mu`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`\det\check{P}_\mu`),
        "）。",
        math(String.raw`2\times 2`),
        " 行列の行列式の定義より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\det\check{P}_\mu
&= \frac{-r}{2\sqrt{M}\,b}\cdot\frac{1}{2\sqrt{M}}
 - \frac{+r}{2\sqrt{M}\,b}\cdot\frac{1}{2\sqrt{M}}
 = 2\cdot\frac{-r}{4M\,b}
 = \frac{-r}{2M\,b}
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\left(2\sqrt{M}\right)^2 = 4M`),
        " を使った。）",
        math(String.raw`r > 0`),
        "、",
        math(String.raw`2M \neq 0`),
        "、",
        math(String.raw`b \neq 0`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " が零因子を持たないこと（",
        ref("complex_numbers_form_a_field"),
        "）から ",
        math(String.raw`\det\check{P}_\mu \neq 0_{\mathbb{C}}`),
        "。",
      ]),
      paragraph([
        "Step 4（対角化）。",
        math(String.raw`\det\check{P}_\mu \neq 0`),
        " より ",
        math(String.raw`\check{P}_\mu^{-1}`),
        " が存在するので、Step 2 の両辺に右から掛けて ",
        math(String.raw`A(\tilde\theta_\mu) = \check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "正規化 c = 1/(2√M γ_2(−θ~_μ)) は 008 章の diagonalization_P_D と同じに揃えた（後段の半整数運動量フェルミオンで" +
          "同じ規格化を使うため）。008 章の P_μ の (1,1) 成分 +i√(γ_2(θ)γ_2(−θ))/(2√M γ_2(−θ)) は、" +
          "relation_of_gamma_2_theta_tilde (5) により半整数運動量では −|γ_2|/(2√M γ_2(−θ~)) に等しい。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_03（det の明示式との一致、|det| ≥ 6.25e-2、" +
          "A − P̌ Ď P̌^{-1} の残差 ≤ 3e-14）。",
      ],
    },
  },

  {
    id: "Athetatilde_006_claim_det_A",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 8,
    title: { tex: String.raw`\det A(\tilde\theta_\mu) = 1` },
    labels: ["det_A_theta_tilde"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(
        String.raw`\det A(\tilde\theta_\mu) = 1,
\qquad
\gamma_1(\tilde\theta_\mu)^2 + \gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu) = 1,
\qquad
\lambda_{+,\mu}\,\lambda_{-,\mu} = 1`,
      ),
      paragraph([
        "が成り立つ。とくに ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) と合わせて",
      ]),
      displayMath(
        String.raw`\gamma_1(\tilde\theta_\mu)^2 = 1 + \left|\gamma_2(\tilde\theta_\mu)\right|^2`,
      ),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`\theta := \tilde\theta_\mu`),
        "、",
        math(String.raw`u := \cos\theta \in \mathbb{R}`),
        "、",
        math(String.raw`v := \sin\theta \in \mathbb{R}`),
        "（",
        math(String.raw`u^2 + v^2 = 1`),
        "）と略記する。",
        ref("det_A_theta"),
        " の証明と同じ計算だが、そこで ",
        math(String.raw`\theta_\mu`),
        " について書かれていた各段は ",
        math(String.raw`\theta \in \mathbb{R}`),
        " についての恒等式であり、",
        math(String.raw`\theta`),
        " が整数運動量であることをどこにも使っていない。ここでは ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " としてそのまま辿る。",
      ]),
      paragraph(["Step 0: 使う 3 つの関係式。"]),
      displayMath(
        String.raw`\text{(i)}\ c_1^2 - s_1^2 = 1, \qquad
\text{(ii)}\ (c_2^*)^2 - (s_2^*)^2 = 1, \qquad
\text{(iii)}\ c_2\,s_2^* = c_2^*`,
      ),
      paragraph([
        "(i) は ",
        math(String.raw`\cosh^2 x - \sinh^2 x = 1`),
        "（",
        ref("cosh_sinh_basic_properties"),
        "）を ",
        math(String.raw`x = 2K_1`),
        " に、(ii) は ",
        math(String.raw`x = 2K_2^*`),
        " に適用したもの、(iii) は ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " である。",
      ]),
      paragraph([
        "Step 1: 行列式。",
        ref("def_gamma1_gamma2_of_theta"),
        " より",
      ]),
      displayMath(
        String.raw`\det A(\theta)
= \gamma_1(\theta)\gamma_1(\theta) - \gamma_2(\theta)\bigl(-\gamma_2(-\theta)\bigr)
= \gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)`,
      ),
      paragraph([
        "これで第 1 の量と第 2 の量が等しいことが言えた。残りはこの値が ",
        math(String.raw`1`),
        " であることである。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`\gamma_2(\theta)\gamma_2(-\theta)`),
        " の実部表示。",
        ref("def_gamma1_gamma2_of_theta"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta) &= i\,e^{i\theta}s_2^*\bigl((c_1u - s_1c_2) - iv\bigr), &
\gamma_2(-\theta) &= i\,e^{-i\theta}s_2^*\bigl((c_1u - s_1c_2) + iv\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`i\cdot i = -1`),
        "、",
        math(String.raw`e^{i\theta}e^{-i\theta} = e^0 = 1`),
        "、",
        math(String.raw`(a_0 - iv)(a_0 + iv) = a_0^2 + v^2`),
        "（",
        math(String.raw`a_0 := c_1u - s_1c_2 \in \mathbb{R}`),
        "）より",
      ]),
      displayMath(
        String.raw`\gamma_2(\theta)\gamma_2(-\theta)
= -(s_2^*)^2\Bigl((c_1u - s_1c_2)^2 + v^2\Bigr)
= -(s_2^*)^2\Bigl((c_1u - s_1c_2)^2 + 1 - u^2\Bigr)`,
      ),
      paragraph([
        "Step 3: 展開。",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*u`),
        " より",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta)^2 = c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta)\gamma_2(-\theta)
&= -(s_2^*)^2\Bigl(c_1^2u^2 - 2c_1s_1c_2u + s_1^2c_2^2 + 1 - u^2\Bigr) \\
&= -c_1^2(s_2^*)^2u^2 + 2c_1s_1c_2(s_2^*)^2u - s_1^2c_2^2(s_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
\end{aligned}`,
      ),
      paragraph(["Step 4: (iii) による ", math(String.raw`c_2`), " の消去。"]),
      displayMath(
        String.raw`2c_1s_1c_2(s_2^*)^2u = 2c_1s_1(c_2s_2^*)s_2^*u = 2c_1s_1c_2^*s_2^*u,
\qquad
s_1^2c_2^2(s_2^*)^2 = s_1^2(c_2s_2^*)^2 = s_1^2(c_2^*)^2`,
      ),
      paragraph(["これを代入して Step 3 の 2 式を足すと"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&= \bigl(c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2\bigr) \\
&\quad + \bigl(-c_1^2(s_2^*)^2u^2 + 2c_1s_1c_2^*s_2^*u - s_1^2(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2\bigr) \\
&= \bigl(c_1^2 - s_1^2\bigr)(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2\bigl(s_1^2 - c_1^2 + 1\bigr)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`u`),
        " の 1 次の項が相殺した。これが (iii) を使った箇所である。）",
      ]),
      paragraph([
        "Step 5: (i)(ii) による結論。(i) より ",
        math(String.raw`s_1^2 - c_1^2 + 1 = 0`),
        " なので ",
        math(String.raw`u^2`),
        " の項は消え、同じく (i) より第 1 項は ",
        math(String.raw`(c_2^*)^2`),
        "。よって (ii) より",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta) = (c_2^*)^2 - (s_2^*)^2 = 1`,
      ),
      paragraph([
        "Step 1 と合わせて ",
        math(String.raw`\det A(\tilde\theta_\mu) = 1`),
        "。",
      ]),
      paragraph([
        "Step 6: 固有値の積。",
        ref("eigenvector_of_A_theta_tilde"),
        " の ",
        math(String.raw`\lambda_{\pm,\mu} = \gamma_1(\theta) \pm r`),
        "（",
        math(String.raw`r = |\gamma_2(\theta)|`),
        "）と ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) の ",
        math(String.raw`\gamma_2(\theta)\gamma_2(-\theta) = -r^2`),
        " より",
      ]),
      displayMath(
        String.raw`\lambda_{+,\mu}\lambda_{-,\mu}
= \gamma_1(\theta)^2 - r^2
= \gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta) = 1`,
      ),
      paragraph([
        "最後に、Step 5 と ",
        math(String.raw`\gamma_2(\theta)\gamma_2(-\theta) = -r^2`),
        " から ",
        math(String.raw`\gamma_1(\theta)^2 = 1 + r^2`),
        " を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "det_A_theta（008 章）の Step 0〜Step 6 と同じ計算である。θ_μ 固有の性質は使われておらず、" +
          "θ ∈ R の恒等式として成立することを本文で明示した。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_04（残差 ≤ 1.4e-12）。",
      ],
    },
  },

  {
    id: "Athetatilde_007_claim_gamma1_gt_1",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 9,
    title: { tex: String.raw`\gamma_1(\tilde\theta_\mu) > 1` },
    labels: ["gamma1_gt_1_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(String.raw`\gamma_1(\tilde\theta_\mu) \geq 1, \qquad \text{さらに} \qquad \gamma_1(\tilde\theta_\mu) > 1`),
      paragraph([
        "が成り立つ。",
        ref("gamma1_geq_1"),
        " は整数運動量について ",
        math(String.raw`\geq 1`),
        " しか述べられない（臨界点の ",
        math(String.raw`\mu = \pm M`),
        " で等号が起こる）が、半整数運動量では ",
        ref("gamma_2_theta_tilde_nonzero"),
        " により**狭義の不等号**が成り立つ。これは後段で最大固有値の一意性に使う。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`\gamma_1(\tilde\theta_\mu) > 0`),
        "）。",
        math(String.raw`x \in \mathbb{R}`),
        " について ",
        math(String.raw`\cosh x - \sinh x = e^{-x} > 0`),
        "（",
        ref("cosh_sinh_basic_properties"),
        "）なので ",
        math(String.raw`c_1 > s_1 > 0`),
        "、",
        math(String.raw`c_2^* > s_2^* > 0`),
        "（",
        math(String.raw`K_1, K_2^* > 0`),
        " より ",
        math(String.raw`s_1, s_2^* > 0`),
        "）。また ",
        math(String.raw`\cos\tilde\theta_\mu \leq 1`),
        " なので",
      ]),
      displayMath(
        String.raw`\gamma_1(\tilde\theta_\mu) = c_1c_2^* - s_1s_2^*\cos\tilde\theta_\mu
\geq c_1c_2^* - s_1s_2^* > 0`,
      ),
      paragraph([
        "（最後の不等号は ",
        math(String.raw`c_1c_2^* > s_1s_2^* > 0`),
        " による。）",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\gamma_1(\tilde\theta_\mu)^2 > 1`),
        "）。",
        ref("det_A_theta_tilde"),
        " より ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)^2 = 1 + |\gamma_2(\tilde\theta_\mu)|^2`),
        " であり、",
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " すなわち ",
        math(String.raw`|\gamma_2(\tilde\theta_\mu)|^2 > 0`),
        "。よって ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)^2 > 1`),
        "（等号なし）。",
      ]),
      paragraph([
        "Step 3（結論）。",
        math(String.raw`t := \gamma_1(\tilde\theta_\mu) > 0`),
        " が ",
        math(String.raw`t^2 > 1`),
        " を満たすとき ",
        math(String.raw`t > 1`),
        " である。実際 ",
        math(String.raw`t \leq 1`),
        " なら ",
        math(String.raw`0 < t \leq 1`),
        " より ",
        math(String.raw`t^2 = t\cdot t \leq 1\cdot 1 = 1`),
        " となり矛盾する。",
        math(String.raw`\gamma_1(\tilde\theta_\mu) \geq 1`),
        " はその帰結である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_04（16 組の (K_1,K_2)、M = 2..8 の全 μ で " +
          "min(γ_1(θ~_μ) − 1) ≥ 1.3e-2 > 0。臨界点ちょうどでも狭義に正）。同じ K で整数運動量 θ = 2π では " +
          "臨界点で γ_1 = 1 になる（check_05 の対比表）。",
      ],
    },
  },

  {
    id: "Athetatilde_008_definition_gamma_theta_tilde",
    kind: "definition",
    sourcePath: SRC,
    sourceOrdinal: 10,
    title: { tex: String.raw`\gamma(\tilde\theta_\mu) \text{ の定義}` },
    labels: ["def_gamma_theta_tilde_mu"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について、",
        ref("gamma1_gt_1_theta_tilde"),
        " の ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) \geq 1`),
        " により well-defined であり、",
      ]),
      displayMath(
        String.raw`\gamma(\tilde\theta_\mu) := \mathrm{arccosh}\left(\gamma_1(\tilde\theta_\mu)\right) \in \mathbb{R}_{\geq 0}`,
      ),
      paragraph([
        "と定める。ここで ",
        math(String.raw`\mathrm{arccosh}(y)`),
        "（",
        math(String.raw`y \geq 1`),
        "）は ",
        math(String.raw`\cosh t = y`),
        " を満たす唯一の ",
        math(String.raw`t \in \mathbb{R}_{\geq 0}`),
        " である（",
        math(String.raw`\cosh`),
        " は ",
        math(String.raw`\mathbb{R}_{\geq 0}`),
        " 上で狭義単調増加なので一意）。",
      ]),
      paragraph([
        "さらに ",
        ref("gamma1_gt_1_theta_tilde"),
        " の ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) > 1`),
        " より",
      ]),
      displayMath(String.raw`\gamma(\tilde\theta_\mu) > 0`),
      paragraph([
        "である（",
        math(String.raw`\gamma(\tilde\theta_\mu) = 0`),
        " なら ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) = \cosh 0 = 1`),
        " となり矛盾する）。",
        ref("def_gamma_theta_mu"),
        " の整数運動量版では ",
        math(String.raw`\gamma(\theta_\mu) \geq 0`),
        " しか言えない。",
      ]),
    ],
    proof: [],
    conversion: {
      status: "added",
      notes: [
        "def_gamma_theta_mu（008 章）と同じ arccosh の使い方に揃えたうえで、半整数運動量に固有の帰結" +
          "「γ(θ~_μ) > 0（狭義）」を statement に含めた。C′-15（最大固有値の一意性）で使う。",
      ],
    },
  },

  {
    id: "Athetatilde_009_claim_lambda_eq_exp_gamma",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 11,
    title: { tex: String.raw`\lambda_{\pm,\mu} = e^{\pm\gamma(\tilde\theta_\mu)}` },
    labels: ["lambda_eq_exp_gamma_theta_tilde"],
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
        String.raw`\lambda_{+,\mu} = e^{+\gamma(\tilde\theta_\mu)}, \qquad
\lambda_{-,\mu} = e^{-\gamma(\tilde\theta_\mu)}`,
      ),
      paragraph(["が成り立つ。とくに ", math(String.raw`\gamma(\tilde\theta_\mu) > 0`), " なので"]),
      displayMath(String.raw`\lambda_{+,\mu} > 1 > \lambda_{-,\mu} > 0`),
      paragraph([
        "であり、2 つの固有値は**必ず分離している**（",
        ref("lambda_eq_exp_gamma"),
        " の整数運動量版では臨界点の ",
        math(String.raw`\mu = \pm M`),
        " で ",
        math(String.raw`\lambda_+ = \lambda_- = 1`),
        " が起こりうる）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`g_1 := \gamma_1(\tilde\theta_\mu)`),
        "、",
        math(String.raw`r := |\gamma_2(\tilde\theta_\mu)| > 0`),
        "、",
        math(String.raw`\gamma := \gamma(\tilde\theta_\mu) > 0`),
        " と略記する（",
        ref("def_gamma_theta_tilde_mu"),
        "）。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\sinh\gamma = r`),
        "）。",
        ref("def_gamma_theta_tilde_mu"),
        " より ",
        math(String.raw`\cosh\gamma = g_1`),
        " であり、",
        ref("cosh_sinh_basic_properties"),
        " の ",
        math(String.raw`\cosh^2 - \sinh^2 = 1`),
        " と ",
        ref("det_A_theta_tilde"),
        " の ",
        math(String.raw`g_1^2 = 1 + r^2`),
        " から",
      ]),
      displayMath(String.raw`\left(\sinh\gamma\right)^2 = \left(\cosh\gamma\right)^2 - 1 = g_1^2 - 1 = r^2`),
      paragraph([
        math(String.raw`\gamma > 0`),
        " より ",
        math(String.raw`\sinh\gamma = \frac{1}{2}(e^{\gamma} - e^{-\gamma}) > 0`),
        " であり、",
        math(String.raw`r > 0`),
        " でもあるから、非負の平方根の一意性（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）より ",
        math(String.raw`\sinh\gamma = r`),
        "。",
      ]),
      paragraph([
        "Step 2（結論）。",
        math(String.raw`e^{\pm\gamma} = \cosh\gamma \pm \sinh\gamma`),
        "（",
        ref("cosh_sinh_basic_properties"),
        "）と Step 1 より",
      ]),
      displayMath(
        String.raw`e^{+\gamma} = g_1 + r = \lambda_{+,\mu},
\qquad
e^{-\gamma} = g_1 - r = \lambda_{-,\mu}`,
      ),
      paragraph([
        "（",
        math(String.raw`\lambda_{\pm,\mu} = g_1 \pm r`),
        " は ",
        ref("eigenvector_of_A_theta_tilde"),
        "。）",
      ]),
      paragraph([
        "Step 3（分離）。",
        math(String.raw`\gamma > 0`),
        " と実指数関数の狭義単調増加性より ",
        math(String.raw`e^{\gamma} > e^{0} = 1 > e^{-\gamma} > 0`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の lambda_eq_exp_gamma は「λ_+λ_- = 1 かつ λ_+ + λ_- = 2γ_1 ≥ 2 > 0 なので両固有値は正」" +
          "という筋で書かれていたが、ここでは sinh γ = |γ_2| を経由して e^{±γ} = cosh γ ± sinh γ から直接出した" +
          "（半整数運動量では γ > 0 が確定しているので分離まで一気に言える）。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_05（cosh γ = γ_1、sinh γ = |γ_2|、λ_± = e^{±γ}、" +
          "min γ(θ~_μ) ≥ 3.0e-1 > 0、残差 ≤ 1e-12）。",
      ],
    },
  },
]);
