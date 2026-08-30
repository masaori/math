import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

const SRC = "structured-latex/content/015_A_theta_tilde_diagonalization.ts";

export default defineBlocks([
  {
    id: "heading_A_theta_tilde_diagonalization",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`\text{半整数運動量における } A(\tilde\theta) \text{ の対角化}` },
    labels: [],
  },

  {
    id: "Athetatilde_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
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
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
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
    origin: { path: SRC, ordinal: 3 },
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
        String.raw`\begin{aligned}
\gamma_2(-\theta)
&= i\,e^{i(-\theta)}s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
   \quad (\because \text{本ブロックの } \gamma_2 \text{ の定義式を } \theta \to -\theta \text{ として適用}) \\
&= i\,e^{-i\theta}s_2^*\bigl(c_1\cos\theta - i\sin(-\theta) - s_1c_2\bigr)
   \quad (\because \cos(-\theta) = \cos\theta) \\
&= i\,e^{-i\theta}s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
   \quad (\because \sin(-\theta) = -\sin\theta)
\end{aligned}`,
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
    origin: { path: SRC, ordinal: 4 },
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
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " と、すべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " を含む）について**",
      ]),
      displayMath(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0_{\mathbb{C}}`),
      paragraph(["が成り立つ。負の運動量側の非零性は、後で共役関係から導く。"]),
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
        String.raw`\begin{aligned}
\gamma_2(\theta) = 0_{\mathbb{C}}
&\iff \left(i\,e^{i\theta}s_2^*\right)w(\theta) = 0_{\mathbb{C}}
   \quad (\because \gamma_1,\gamma_2 \text{ の定義}) \\
&\iff w(\theta) = 0_{\mathbb{C}}
   \quad (\because i\,e^{i\theta}s_2^* \neq 0 \text{ と、体 } \mathbb{C} \text{ が零因子を持たないこと}) \\
&\iff \begin{cases} \sin\theta = 0 \\ c_1\cos\theta = s_1c_2 \end{cases}
   \quad (\because \text{複素数の定義の成分表示（実部と虚部が共に } 0\text{）})
\end{aligned}`,
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
        " と ",
        ref("def_half_integer_modes"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M}`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sin\tilde\theta_\mu = 0
&\iff \exists k \in \mathbb{Z}:\ \tilde\theta_\mu = k\pi
   \quad (\because \sin t = 0 \iff \exists k \in \mathbb{Z}:\ t = k\pi) \\
&\iff \exists k \in \mathbb{Z}:\ \frac{2\pi\left(\mu-\frac12\right)}{M} = k\pi
   \quad (\because \tilde\theta_\mu \text{ の定義}) \\
&\iff \exists k \in \mathbb{Z}:\ \frac{2\left(\mu-\frac12\right)}{M} = k
   \quad (\because \text{両辺を } \pi > 0 \text{ で割る}) \\
&\iff \exists k \in \mathbb{Z}:\ 2\left(\mu - \tfrac12\right) = kM
   \quad (\because \text{両辺を } M \neq 0 \text{ 倍する}) \\
&\iff \exists k \in \mathbb{Z}:\ 2\mu - 1 = kM
   \quad (\because \text{分配則 } 2\left(\mu-\tfrac12\right) = 2\mu - 1)
\end{aligned}`,
      ),
      paragraph([
        "ここが整数運動量との分かれ目である：**左辺 ",
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
        String.raw`\begin{aligned}
\cos\tilde\theta_\mu
&= \cos(k\pi)
   \quad (\because \text{Step 2 の } \tilde\theta_\mu = k\pi) \\
&= (-1)^{k}
   \quad (\because k \in \mathbb{Z} \text{ に対し } \cos(k\pi) = (-1)^k) \\
&= -1
   \quad (\because \text{Step 2 より } k \text{ は奇数})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（矛盾）。Step 1 の第 2 式に Step 3 を代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_1c_2
&= c_1\cos\tilde\theta_\mu
   \quad (\because \text{Step 1 の連立条件の第 2 式}) \\
&= c_1\cdot(-1)
   \quad (\because \text{Step 3 の } \cos\tilde\theta_\mu = -1) \\
&= -c_1
   \quad (\because \mathbb{R} \text{ の積の符号規則 } a\cdot(-1) = -a)
\end{aligned}`,
      ),
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
        "2026-08-19 の式変形統一で、Step 1・Step 2 の鎖の行末根拠をラベル識別子の生文字列から人間可読な名前へ直し、" +
          "Step 2 の「両辺を π で割って M 倍する」を一操作ずつの二行に分け、最終行（2(μ−1/2) = 2μ−1）に" +
          "行末根拠を補って鎖の後の重複した散文根拠を外した。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "Athetatilde_003_claim_relation_of_gamma2",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
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
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
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
        math(String.raw`\theta := \tilde\theta_\mu \in \mathbb{R}`),
        " と略記する（",
        ref("def_half_integer_modes"),
        " より ",
        math(String.raw`\tilde\theta_\mu`),
        " は**実数**であり、以下の共役の計算はこの実数性を使う）。",
        ref("def_gamma1_gamma2_of_theta"),
        " の証明中で確かめたとおり",
      ]),
      displayMath(
        String.raw`\gamma_2(-\theta)
= i\,e^{-i\theta}s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
\quad (\because \text{def\_gamma1\_gamma2\_of\_theta})`,
      ),
      paragraph([
        "である。一方 ",
        math(String.raw`\overline{\gamma_2(\theta)}`),
        " を 1 段ずつ計算する。用いるのは、複素共役が積を保つこと ",
        math(String.raw`\overline{zw} = \bar z\,\bar w`),
        "、和を保つこと ",
        math(String.raw`\overline{z+w} = \bar z + \bar w`),
        "、実数が共役で不変であること、および ",
        math(String.raw`\bar i = -i`),
        " である（",
        ref("definition_of_cc"),
        " の成分表示から従う）。",
        math(String.raw`c_1, c_2, s_1, s_2^*`),
        " が実数であることは ",
        ref("def_transfer_matrix_symbols"),
        "、",
        math(String.raw`\cos\theta, \sin\theta`),
        " が実数であることは ",
        math(String.raw`\theta \in \mathbb{R}`),
        " による。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\overline{\gamma_2(\theta)}
&= \overline{i\,e^{i\theta}s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
   \quad (\because \text{def\_gamma1\_gamma2\_of\_theta}) \\
&= \bar i\;\overline{e^{i\theta}}\;\overline{s_2^*}\;
   \overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
   \quad (\because \text{複素共役が積を保つこと}) \\
&= (-i)\;\overline{e^{i\theta}}\;\overline{s_2^*}\;
   \overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
   \quad (\because \bar i = -i) \\
&= (-i)\,e^{-i\theta}\;\overline{s_2^*}\;
   \overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
   \quad (\because \theta \in \mathbb{R} \text{ と euler\_formula\_cos\_sin より } \overline{e^{i\theta}} = e^{-i\theta}) \\
&= (-i)\,e^{-i\theta}\,s_2^*\;
   \overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
   \quad (\because s_2^* \in \mathbb{R}) \\
&= (-i)\,e^{-i\theta}\,s_2^*
   \left(\overline{c_1\cos\theta} - \overline{i\sin\theta} - \overline{s_1c_2}\right)
   \quad (\because \text{複素共役が和・差を保つこと}) \\
&= (-i)\,e^{-i\theta}\,s_2^*
   \bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
   \quad (\because c_1\cos\theta,\ \sin\theta,\ s_1c_2 \in \mathbb{R} \text{ と } \bar i = -i) \\
&= -\Bigl(i\,e^{-i\theta}\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)\Bigr)
   \quad (\because \text{複素数の四則}) \\
&= -\gamma_2(-\theta)
   \quad (\because \text{上の } \gamma_2(-\theta) \text{ の表示})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\overline{e^{i\theta}} = e^{-i\theta}`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の ",
        math(String.raw`e^{i\theta} = \cos\theta + i\sin\theta`),
        " と ",
        math(String.raw`\theta \in \mathbb{R}`),
        "、すなわち ",
        math(String.raw`\cos\theta, \sin\theta`),
        " が実数であることから従う。**",
        math(String.raw`\theta`),
        " が実数であるという前提をここで使っている。**）上の補助的な等式から、主張 (1) の左辺より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(-\theta)
&= -\overline{\gamma_2(\theta)}
   \quad (\because \overline{\gamma_2(\theta)}=-\gamma_2(-\theta)\text{ と複素数の四則})
\end{aligned}`,
      ),
      paragraph([
        "を得る。これは ",
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
        String.raw`\begin{aligned}
\gamma_2(\theta)\gamma_2(-\theta)
&= \gamma_2(\theta)\left(-\overline{\gamma_2(\theta)}\right)
   \quad (\because (1)) \\
&= -\gamma_2(\theta)\overline{\gamma_2(\theta)} \\
&= -\left|\gamma_2(\theta)\right|^2
   \quad (\because \text{abs\_basic\_properties}\ (z\bar z = |z|^2))
\end{aligned}`,
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
        String.raw`\begin{aligned}
\sqrt{-\gamma_2(\theta)\gamma_2(-\theta)}
&= \sqrt{\left|\gamma_2(\theta)\right|^2}\;e^{i\cdot 0/2}
   \quad (\because \text{def\_sqrt\_cc を絶対値 } |\gamma_2(\theta)|^2,\ \text{偏角 } 0 \text{ に適用}) \\
&= \sqrt{\left|\gamma_2(\theta)\right|^2}
   \quad (\because e^{i\cdot 0} = 1) \\
&= \left|\gamma_2(\theta)\right|
   \quad (\because \text{sqrt\_nonnegative\_existence\_uniqueness と } |\gamma_2(\theta)| \geq 0) \\
&> 0
   \quad (\because \text{gamma\_2\_theta\_tilde\_nonzero})
\end{aligned}`,
      ),
      paragraph([
        "（絶対値の非負平方根は ",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "、正値性は ",
        ref("gamma_2_theta_tilde_nonzero"),
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
        String.raw`\begin{aligned}
\sqrt{\gamma_2(\theta)\gamma_2(-\theta)}
&= \sqrt{\left|\gamma_2(\theta)\right|^2}\;e^{i\pi/2}
   \quad (\because \text{def\_sqrt\_cc を絶対値 } |\gamma_2(\theta)|^2,\ \text{偏角 } \pi \text{ に適用}) \\
&= \left|\gamma_2(\theta)\right|\,e^{i\pi/2}
   \quad (\because \text{sqrt\_nonnegative\_existence\_uniqueness}) \\
&= \left|\gamma_2(\theta)\right|\left(\cos\tfrac{\pi}{2} + i\sin\tfrac{\pi}{2}\right)
   \quad (\because \text{euler\_formula\_cos\_sin}) \\
&= i\left|\gamma_2(\theta)\right|
   \quad (\because \cos\tfrac{\pi}{2}=0,\ \sin\tfrac{\pi}{2}=1\text{ と複素数の四則})
\end{aligned}`,
      ),
      paragraph([
        "（非負平方根は ",
        ref("sqrt_nonnegative_existence_uniqueness"),
        " による。）",
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
        "2026-08-19 の式変形統一で、補助的な共役計算の末尾に複素数の四則という行末根拠を補い、散文で行っていた両辺の符号反転を主張 (1) の左辺から始まる一段の鎖へ移した。(5) の終端にも三角関数の特殊値と複素数の四則を行末根拠として明記した。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "Athetatilde_004_claim_eigenvector",
    kind: "claim",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ の固有値と固有ベクトル}` },
    labels: ["eigenvector_of_A_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
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
      paragraph([
        "準備として、因数分解の恒等式を確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\lambda - (g_1+r))(\lambda - (g_1-r))
&= \lambda^2 - (g_1-r)\lambda - (g_1+r)\lambda + (g_1+r)(g_1-r)
   \quad (\because \text{分配則}) \\
&= \lambda^2 - 2g_1\lambda + (g_1+r)(g_1-r)
   \quad (\because \text{同類項の統合}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2-g_1r+rg_1-r^2\right)
   \quad (\because \text{分配則}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 - r^2\right)
   \quad (\because \mathbb{C}\text{ の乗法の可換則と加法逆元})
\end{aligned}`,
      ),
      paragraph(["そこで"]),
      displayMath(
        String.raw`\begin{aligned}
\det\left(A(\theta) - \lambda I\right)
&= \det\begin{pmatrix} g_1-\lambda & a \\ -b & g_1-\lambda\end{pmatrix}
   \quad (\because \text{def\_gamma1\_gamma2\_of\_theta}) \\
&= (g_1-\lambda)(g_1-\lambda) - a\cdot(-b)
   \quad (\because 2\times 2 \text{ 行列の行列式の定義}) \\
&= (g_1-\lambda)(g_1-\lambda) + ab
   \quad (\because \mathbb{C} \text{ の四則}\ (-a\cdot(-b) = ab)) \\
&= g_1^2-g_1\lambda-\lambda g_1+\lambda^2+ab
   \quad (\because \text{分配則}) \\
&= g_1^2-g_1\lambda-g_1\lambda+\lambda^2+ab
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= g_1^2-2g_1\lambda+\lambda^2+ab
   \quad (\because \text{同類項の統合}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 + ab\right)
   \quad (\because \mathbb{C}\text{ の加法の交換則と結合則}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 - r^2\right)
   \quad (\because \text{準備の略記}\ ab = -r^2) \\
&= (\lambda - (g_1+r))(\lambda - (g_1-r))
   \quad (\because \text{準備の因数分解の恒等式})
\end{aligned}`,
      ),
      paragraph([
        "である。",
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
   \quad (\because \text{def\_gamma1\_gamma2\_of\_theta と行列とベクトルの積の定義}) \\
&= \mp g_1 r + a\left(-\bar a\right)
   \quad (\because \text{relation\_of\_gamma\_2\_theta\_tilde (1)}\ (b = -\bar a)) \\
&= \mp g_1 r - r^2
   \quad (\because \text{abs\_basic\_properties}\ (a\bar a = |a|^2 = r^2)) \\
&= \left(g_1 \pm r\right)\left(\mp r\right)
   \quad (\because \text{分配則}\ (\left(g_1 \pm r\right)\left(\mp r\right) = \mp g_1 r - r^2)) \\
&= \lambda_{\pm,\mu}\,\left(v_\pm\right)_1
   \quad (\because \lambda_{\pm,\mu} = g_1 \pm r,\ \left(v_\pm\right)_1 = \mp r)
\end{aligned}`,
      ),
      paragraph([
        "第 2 成分は ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の ",
        math(String.raw`b = -\bar a`),
        "、すなわち ",
        math(String.raw`-b = \bar a`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A(\theta)v_\pm\right)_2
&= (-b)(\mp r) + g_1 b
   \quad (\because \text{def\_gamma1\_gamma2\_of\_theta と行列とベクトルの積の定義}) \\
&= \bar a\left(\mp r\right) + g_1\left(-\bar a\right)
   \quad (\because \text{relation\_of\_gamma\_2\_theta\_tilde (1)}\ (-b = \bar a) \text{ を 2 箇所へ同時適用}) \\
&= \left(\mp r - g_1\right)\bar a
   \quad (\because \text{分配則で } \bar a \text{ を括り出す}) \\
&= \left(g_1 \pm r\right)\left(-\bar a\right)
   \quad (\because \mp r - g_1 = -(g_1 \pm r)) \\
&= \lambda_{\pm,\mu}\,\left(v_\pm\right)_2
   \quad (\because \lambda_{\pm,\mu} = g_1 \pm r,\ \left(v_\pm\right)_2 = b = -\bar a)
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`A(\theta)v_\pm = \lambda_{\pm,\mu}v_\pm`),
        "。",
        math(String.raw`b \neq 0`),
        "（",
        ref("relation_of_gamma_2_theta_tilde"),
        "）より ",
        math(String.raw`v_\pm \neq 0`),
        " であり、これは固有ベクトルである。",
        math(String.raw`c \in \mathbb{C}^\times`),
        " 倍しても固有ベクトルであることは次による。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\theta)(cv)
&= c\,A(\theta)v
   \quad (\because \text{行列とベクトルの積の各成分の分配則（スカラー倍は積の外へ出る）}) \\
&= c(\lambda v)
   \quad (\because \text{上で示した } A(\theta)v = \lambda v \text{ の代入}) \\
&= \lambda(cv)
   \quad (\because \text{複素数の積の可換性と、ベクトルのスカラー倍の結合})
\end{aligned}`,
      ),
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
        "2026-08-19 の式変形統一で、Step 1 の「右辺を展開すれば左辺に一致する」と散文に畳まれていた因数分解を、" +
          "準備の恒等式と行列式の一続きの鎖へ開き、固有ベクトル成分の二本の鎖の根拠なしの行に行末根拠を補った。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "Athetatilde_005_claim_diagonalization",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ の対角化 } (\check{P}_\mu,\, \check{D}_\mu)` },
    labels: ["diagonalization_check_P_D"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
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
        " を代入すると、第 2 成分は次の鎖で定まる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
cb
&= \frac{1}{2\sqrt{M}\,b}\,b
   \quad (\because c\text{ の定義}) \\
&= \frac{1}{2\sqrt{M}}
   \quad (\because b\ne0\text{ と }\mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`v_{+,\mu}, v_{-,\mu}`),
        " はそれぞれ ",
        math(String.raw`\check{P}_\mu`),
        " の第 1 列・第 2 列に一致する。行列の積を列ごとに見れば",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\tilde\theta_\mu)\,\check{P}_\mu
&= \left(A(\tilde\theta_\mu)v_{+,\mu}\ \ A(\tilde\theta_\mu)v_{-,\mu}\right)
   \quad (\because \text{行列の積を列ごとに見た}) \\
&= \left(\lambda_{+,\mu}v_{+,\mu}\ \ \lambda_{-,\mu}v_{-,\mu}\right)
   \quad (\because \text{eigenvector\_of\_A\_theta\_tilde を 2 列へ同時適用}) \\
&= \check{P}_\mu\,\check{D}_\mu
   \quad (\because \check{D}_\mu = \mathrm{diag}(\lambda_{+,\mu}, \lambda_{-,\mu}) \text{ の右乗が列ごとのスカラー倍})
\end{aligned}`,
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
   \quad (\because 2\times 2 \text{ 行列の行列式の定義}) \\
&= \frac{-r}{4M\,b} - \frac{+r}{4M\,b}
   \quad \left(\because \left(2\sqrt{M}\right)^2 = 4M\right) \\
&= \frac{-r}{4M\,b} + \frac{-r}{4M\,b}
   \quad (\because -\tfrac{+r}{4M\,b}=\tfrac{-r}{4M\,b}\text{。}\mathbb{C}\text{ の四則}) \\
&= 2\cdot\frac{-r}{4M\,b}
   \quad (\because \text{同類項の統合}) \\
&= \frac{-r}{2M\,b}
   \quad (\because 2M\ne0\text{ と }\mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
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
        "次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\tilde\theta_\mu)
&= A(\tilde\theta_\mu)\left(\check{P}_\mu\check{P}_\mu^{-1}\right)
   \quad (\because \check{P}_\mu\check{P}_\mu^{-1}=I\text{ と積の単位元}) \\
&= \left(A(\tilde\theta_\mu)\check{P}_\mu\right)\check{P}_\mu^{-1}
   \quad (\because \text{行列の積の結合則}) \\
&= \left(\check{P}_\mu\check{D}_\mu\right)\check{P}_\mu^{-1}
   \quad (\because \text{Step 2}) \\
&= \check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}
   \quad (\because \text{行列の積の結合則})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "正規化 c = 1/(2√M γ_2(−θ~_μ)) は 008 章の diagonalization_P_D と同じに揃えた（後段の半整数運動量フェルミオンで" +
          "同じ規格化を使うため）。008 章の P_μ の (1,1) 成分 +i√(γ_2(θ)γ_2(−θ))/(2√M γ_2(−θ)) は、" +
          "relation_of_gamma_2_theta_tilde (5) により半整数運動量では −|γ_2|/(2√M γ_2(−θ~)) に等しい。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_03（det の明示式との一致、|det| ≥ 6.25e-2、" +
          "A − P̌ Ď P̌^{-1} の残差 ≤ 3e-14）。",
        "2026-08-19 の式変形統一で、固有ベクトルの第 2 成分の約分、行列式の同類項の統合、対角化の右乗を、" +
          "それぞれ主張の左辺から始まる一続きの鎖と行末根拠へ開いた。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "Athetatilde_006_claim_det_A",
    kind: "claim",
    origin: { path: SRC, ordinal: 8 },
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
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
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
        String.raw`\begin{aligned}
\det A(\theta)
&= \det\begin{pmatrix}
   \gamma_1(\theta) & \gamma_2(\theta) \\
   -\gamma_2(-\theta) & \gamma_1(\theta)
   \end{pmatrix}
   \quad (\because \text{def\_gamma1\_gamma2\_of\_theta}) \\
&= \gamma_1(\theta)\gamma_1(\theta) - \gamma_2(\theta)\bigl(-\gamma_2(-\theta)\bigr)
   \quad (\because 2\times 2 \text{ 行列の行列式の定義}) \\
&= \gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
   \quad (\because \mathbb{C} \text{ の積と加法逆元})
\end{aligned}`,
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
        " である。また、",
        ref("theorem_exp_product"),
        "（",
        math(String.raw`n=1`),
        " に適用する）と ",
        ref("theorem_exp_zero"),
        " により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{i\theta}e^{-i\theta}
&= e^{i\theta + (-i\theta)}
   \quad (\because \text{可換な指数の積公式を } n=1 \text{ に適用}) \\
&= e^{0}
   \quad (\because \mathbb{C} \text{ の加法 } i\theta + (-i\theta) = 0) \\
&= 1
   \quad (\because e^0 = 1)
\end{aligned}`,
      ),
      paragraph([
        "である。さらに ",
        math(String.raw`(a_0 - iv)(a_0 + iv) = a_0^2 + v^2`),
        "（",
        math(String.raw`a_0 := c_1u - s_1c_2 \in \mathbb{R}`),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta)\gamma_2(-\theta)
&= \left(i\cdot i\right)\left(e^{i\theta}e^{-i\theta}\right)(s_2^*)^2
   \bigl(a_0 - iv\bigr)\bigl(a_0 + iv\bigr)
   \quad (\because \text{直前の 2 式と } \mathbb{C} \text{ の積の可換性}) \\
&= (-1)\cdot 1\cdot (s_2^*)^2\bigl(a_0 - iv\bigr)\bigl(a_0 + iv\bigr)
   \quad (\because i\cdot i = -1 \text{ と直前の式変形 } e^{i\theta}e^{-i\theta} = 1) \\
&= -(s_2^*)^2\Bigl(a_0^2 + v^2\Bigr)
   \quad (\because (a_0-iv)(a_0+iv) = a_0^2 + v^2) \\
&= -(s_2^*)^2\Bigl((c_1u - s_1c_2)^2 + v^2\Bigr)
   \quad (\because a_0 := c_1u - s_1c_2) \\
&= -(s_2^*)^2\Bigl((c_1u - s_1c_2)^2 + 1 - u^2\Bigr)
   \quad (\because u^2 + v^2 = 1)
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 展開。",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*u`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)^2
&= \left(c_1c_2^* - s_1s_2^*u\right)^2
   \quad (\because \text{直前の表示の代入}) \\
&= c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2
   \quad (\because \mathbb{R} \text{ の分配則による展開})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta)\gamma_2(-\theta)
&= -(s_2^*)^2\Bigl(c_1^2u^2 - 2c_1s_1c_2u + s_1^2c_2^2 + 1 - u^2\Bigr)
   \quad (\because \text{Step 2 の最終式で } (c_1u - s_1c_2)^2 \text{ を分配則で展開}) \\
&= -c_1^2(s_2^*)^2u^2 + 2c_1s_1c_2(s_2^*)^2u - s_1^2c_2^2(s_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
   \quad (\because \mathbb{R} \text{ の分配則})
\end{aligned}`,
      ),
      paragraph(["Step 4: (iii) による ", math(String.raw`c_2`), " の消去。"]),
      displayMath(
        String.raw`\begin{aligned}
2c_1s_1c_2(s_2^*)^2u
&= 2c_1s_1\left(c_2s_2^*\right)s_2^*u
   \quad (\because \mathbb{R} \text{ の積の結合律と可換律}) \\
&= 2c_1s_1c_2^*s_2^*u
   \quad (\because \text{(iii)}\ (c_2s_2^* = c_2^*)) \\
s_1^2c_2^2(s_2^*)^2
&= s_1^2\left(c_2s_2^*\right)^2
   \quad (\because \mathbb{R} \text{ の積の結合律と可換律}) \\
&= s_1^2(c_2^*)^2
   \quad (\because \text{(iii)}\ (c_2s_2^* = c_2^*))
\end{aligned}`,
      ),
      paragraph(["これを代入して Step 3 の 2 式を足すと"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&= \bigl(c_1^2(c_2^*)^2 - 2c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2\bigr) \\
&\quad + \bigl(-c_1^2(s_2^*)^2u^2 + 2c_1s_1c_2^*s_2^*u - s_1^2(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2\bigr)
   \quad (\because \text{Step 3 の 2 式と Step 4 の代入}) \\
&= \bigl(c_1^2 - s_1^2\bigr)(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2\bigl(s_1^2 - c_1^2 + 1\bigr)
   \quad (\because u \text{ の 1 次の項の相殺と同類項の整理})
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
        String.raw`\begin{aligned}
\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&= \bigl(c_1^2 - s_1^2\bigr)(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2\cdot 0
   \quad (\because \text{(i)}\ (s_1^2 - c_1^2 + 1 = 0)) \\
&= 1\cdot(c_2^*)^2 - (s_2^*)^2
   \quad (\because \text{(i)}\ (c_1^2 - s_1^2 = 1)) \\
&= 1
   \quad (\because \text{(ii)}\ ((c_2^*)^2 - (s_2^*)^2 = 1))
\end{aligned}`,
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
        String.raw`\begin{aligned}
\lambda_{+,\mu}\lambda_{-,\mu}
&= \left(\gamma_1(\theta) + r\right)\left(\gamma_1(\theta) - r\right)
   \quad (\because \text{eigenvector\_of\_A\_theta\_tilde}) \\
&= \gamma_1(\theta)^2 - r^2
   \quad (\because \mathbb{R} \text{ の分配則による平方差}) \\
&= \gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
   \quad (\because \text{relation\_of\_gamma\_2\_theta\_tilde (2)}) \\
&= 1
   \quad (\because \text{Step 5})
\end{aligned}`,
      ),
      paragraph([
        "最後に、",
        math(String.raw`\gamma_1(\theta)^2 = 1 + r^2`),
        " を示す。主張の左辺より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)^2
&= \gamma_1(\theta)^2 + \bigl(\gamma_2(\theta)\gamma_2(-\theta) + r^2\bigr)
   \quad (\because \text{上で引いた } \gamma_2(-\tilde\theta_\mu)=-\overline{\gamma_2(\tilde\theta_\mu)} \text{ とその帰結 (2) より } \gamma_2(\theta)\gamma_2(-\theta) + r^2 = 0_{\mathbb{C}}) \\
&= \bigl(\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)\bigr) + r^2
   \quad (\because \mathbb{C} \text{ の加法の結合律}) \\
&= 1 + r^2
   \quad (\because \text{Step 5})
\end{aligned}`,
      ),
      paragraph([
        "を得る。",
        math(String.raw`r = \left|\gamma_2(\theta)\right|`),
        "（Step 6）なので、これが主張の最後の等式である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "det_A_theta（008 章）の Step 0〜Step 6 と同じ計算である。θ_μ 固有の性質は使われておらず、" +
          "θ ∈ R の恒等式として成立することを本文で明示した。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_04（残差 ≤ 1.4e-12）。",
        "2026-08-19 の式変形統一で、Step 3 の展開 2 式と Step 4 の鎖の先頭行に行末根拠を補い、" +
          "散文で畳まれていた γ_1(θ)^2 = 1 + r^2 の導出を主張の左辺から始まる三段の鎖へ開いた。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "Athetatilde_007_claim_gamma1_gt_1",
    kind: "claim",
    origin: { path: SRC, ordinal: 9 },
    title: { tex: String.raw`\gamma_1(\tilde\theta_\mu) > 1` },
    labels: ["gamma1_gt_1_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
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
        " である。",
        ref("def_gamma1_gamma2_of_theta"),
        " の定義から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\tilde\theta_\mu)
&= c_1c_2^* - s_1s_2^*\cos\tilde\theta_\mu
   \quad (\because \gamma_1 \text{ の定義}) \\
&\geq c_1c_2^* - s_1s_2^*
   \quad (\because \cos\tilde\theta_\mu \leq 1 \text{ かつ } s_1s_2^* > 0) \\
&> s_1s_2^* - s_1s_2^*
   \quad (\because c_1 > s_1 > 0,\ c_2^* > s_2^* > 0 \text{ より } c_1c_2^* > s_1s_2^*) \\
&= 0
   \quad (\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\gamma_1(\tilde\theta_\mu)^2 > 1`),
        "）。主張の左辺から",
        ref("det_A_theta_tilde"),
        " と ",
        ref("gamma_2_theta_tilde_nonzero"),
        " を順に引くと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\tilde\theta_\mu)^2
&= 1 + \left|\gamma_2(\tilde\theta_\mu)\right|^2
   \quad (\because \det A(\tilde\theta_\mu)=1 \text{ と固有値の積}) \\
&> 1 + 0
   \quad (\because \gamma_2(\tilde\theta_\mu)\ne0 \text{ より } \left|\gamma_2(\tilde\theta_\mu)\right|^2>0) \\
&= 1
   \quad (\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（結論）。",
        math(String.raw`t := \gamma_1(\tilde\theta_\mu) > 0`),
        " と置く。Step 2 より ",
        math(String.raw`t^2>1`),
        " である。一方、",
        math(String.raw`t \leq 1`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
t^2
&= t\cdot t
   \quad (\because \text{平方の定義}) \\
&\leq 1\cdot t
   \quad (\because t\leq1 \text{ の両辺に }0<t\text{ を掛ける}) \\
&\leq 1\cdot1
   \quad (\because t\leq1 \text{ の両辺に }0<1\text{ を掛ける}) \\
&= 1
   \quad (\because \mathbb{R} \text{ の乗法単位元})
\end{aligned}`,
      ),
      paragraph([
        "となり Step 2 の ",
        math(String.raw`t^2>1`),
        " と矛盾する。したがって ",
        math(String.raw`t>1`),
        "、すなわち ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)>1`),
        " である。さらに ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) \geq 1`),
        " は狭義不等式から従う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_04（16 組の (K_1,K_2)、M = 2..8 の全 μ で " +
          "min(γ_1(θ~_μ) − 1) ≥ 1.3e-2 > 0。臨界点ちょうどでも狭義に正）。同じ K で整数運動量 θ = 2π では " +
          "臨界点で γ_1 = 1 になる（check_05 の対比表）。",
        "2026-08-19 の式変形統一で、Step 1 の正値性を一操作ずつの鎖へ分け、Step 2 の平方評価と Step 3 の背理法を主張の左辺から始まる鎖へ開いた。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "Athetatilde_008_definition_gamma_theta_tilde",
    kind: "definition",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`\gamma(\tilde\theta_\mu) \text{ の定義}` },
    labels: ["def_gamma_theta_tilde_mu"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
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
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`\lambda_{\pm,\mu} = e^{\pm\gamma(\tilde\theta_\mu)}` },
    labels: ["lambda_eq_exp_gamma_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
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
      displayMath(
        String.raw`\begin{aligned}
\left(\sinh\gamma\right)^2
&= \left(\cosh\gamma\right)^2 - 1
   \quad (\because \text{cosh\_sinh\_basic\_properties}\ (\cosh^2 - \sinh^2 = 1)) \\
&= g_1^2 - 1
   \quad (\because \text{def\_gamma\_theta\_tilde\_mu}\ (\cosh\gamma = g_1)) \\
&= \left(1 + r^2\right) - 1
   \quad (\because \text{det\_A\_theta\_tilde}\ (g_1^2 = 1 + r^2)) \\
&= r^2
\end{aligned}`,
      ),
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
        String.raw`\begin{aligned}
e^{+\gamma}
&= \cosh\gamma + \sinh\gamma
   \quad (\because \text{cosh\_sinh\_basic\_properties}) \\
&= g_1 + \sinh\gamma
   \quad (\because \text{def\_gamma\_theta\_tilde\_mu}\ (\cosh\gamma = g_1)) \\
&= g_1 + r
   \quad (\because \text{Step 1}) \\
&= \lambda_{+,\mu}
   \quad (\because \text{eigenvector\_of\_A\_theta\_tilde}) \\
e^{-\gamma}
&= \cosh\gamma - \sinh\gamma
   \quad (\because \text{cosh\_sinh\_basic\_properties}) \\
&= g_1 - \sinh\gamma
   \quad (\because \text{def\_gamma\_theta\_tilde\_mu}\ (\cosh\gamma = g_1)) \\
&= g_1 - r
   \quad (\because \text{Step 1}) \\
&= \lambda_{-,\mu}
   \quad (\because \text{eigenvector\_of\_A\_theta\_tilde})
\end{aligned}`,
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
