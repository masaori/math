import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

// 章「T_{V_1}(hat Z) と hat Z, hat Y の関係」の後半（文書順）。
// 収録範囲は parts/008 の 020〜031, 034, 035, 033, 032, 037, 044, 041, 042, 038, 039,
// 040, 043（文書順はソースのファイル名連番と一致しない）。並びが文書順の正準表現。
export default defineBlocks([
  {
    id: "TV1_hatZ_hatY_021_claim_arg_gamma1_gamma2",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/020_claim_gamma1_gamma2の偏角.typ",
    sourceOrdinal: 21,
    title: { tex: String.raw`\arg(\gamma_1(\theta_\mu))` },
    labels: [],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（したがって ",
        math(String.raw`K_1^*, K_2^* \in \mathbb{R}_{>0}`),
        "）とし、",
        math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`),
        "、",
        math(String.raw`\theta_\mu := \dfrac{2\pi\mu}{M} \in \mathbb{R}`),
        " とする。",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
        math(String.raw`\gamma_1(\theta) := c_1 c_2^* - s_1 s_2^*\cos\theta`),
        "（",
        ref("def_A_theta"),
        " の対角成分）は ",
        math(String.raw`\gamma_1(\theta_\mu) \in \mathbb{R} \subset \mathbb{C}`),
        " を満たし、その偏角（",
        ref("def_abs_arg"),
        "）は",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(\gamma_1(\theta_\mu))
= \begin{cases}
0 & \quad (\cos\theta_\mu \leq c_1 c_2^* / (s_1 s_2^*)) \\
\pi & \quad (\text{otherwise})
\end{cases}`,
      ),
      paragraph([
        "さらに ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " のもとでは常に ",
        math(String.raw`\dfrac{c_1 c_2^*}{s_1 s_2^*} > 1 \geq \cos\theta_\mu`),
        " であるから、第 2 の場合（otherwise）は実際には起こらない。すなわちすべての ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について ",
        math(String.raw`\gamma_1(\theta_\mu) > 0`),
        " であり ",
        math(String.raw`\arg^{[0,2\pi)}(\gamma_1(\theta_\mu)) = 0`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: 正値性と所属集合。",
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`K_1, K_1^*, K_2, K_2^* \in \mathbb{R}_{>0}`),
        " のとき ",
        math(String.raw`c_1 = \cosh 2K_1`),
        "、",
        math(String.raw`s_1 = \sinh 2K_1`),
        "、",
        math(String.raw`c_2^* = \cosh 2K_2^*`),
        "、",
        math(String.raw`s_2^* = \sinh 2K_2^*`),
        " はいずれも正の実数である（",
        ref("cosh_sinh_basic_properties"),
        " (1)(3) を ",
        math(String.raw`x = 2K_1 > 0`),
        "、",
        math(String.raw`x = 2K_2^* > 0`),
        " に適用）。また ",
        math(String.raw`\mu \in \mathcal{M} \subset \mathbb{Z}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " より ",
        math(String.raw`\theta_\mu \in \mathbb{R}`),
        " であり ",
        math(String.raw`\cos\theta_\mu \in \mathbb{R}`),
        "。よって ",
        math(String.raw`\gamma_1(\theta_\mu) = c_1 c_2^* - s_1 s_2^*\cos\theta_\mu`),
        " は実数の四則演算で得られる実数であり、",
        math(String.raw`\gamma_1(\theta_\mu) \in \mathbb{R}`),
        "。特に ",
        math(String.raw`s_1 s_2^* > 0`),
        " なので、以下でこれによる除算ができる。",
      ]),
      paragraph(["Step 2: 符号の判定。", math(String.raw`s_1 s_2^* > 0`), " で割ると、実数の順序の性質より"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta_\mu) > 0 &\iff c_1 c_2^* > s_1 s_2^*\cos\theta_\mu \iff \cos\theta_\mu < \frac{c_1 c_2^*}{s_1 s_2^*} \\
\gamma_1(\theta_\mu) = 0 &\iff c_1 c_2^* = s_1 s_2^*\cos\theta_\mu \iff \cos\theta_\mu = \frac{c_1 c_2^*}{s_1 s_2^*} \\
\gamma_1(\theta_\mu) < 0 &\iff c_1 c_2^* < s_1 s_2^*\cos\theta_\mu \iff \cos\theta_\mu > \frac{c_1 c_2^*}{s_1 s_2^*}
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\cos\theta_\mu \leq c_1 c_2^*/(s_1 s_2^*) \iff \gamma_1(\theta_\mu) \geq 0`),
        "、",
        math(String.raw`\text{otherwise} \iff \gamma_1(\theta_\mu) < 0`),
        "。",
      ]),
      paragraph([
        "Step 3: 実数の偏角。",
        math(String.raw`t \in \mathbb{R}`),
        " を ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}(t) = (t, 0) \in \mathbb{C}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）と見る。",
        ref("def_phi_polar"),
        " の場合分けを ",
        math(String.raw`(x,y) = (t,0)`),
        " に適用すると、",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(t,0) =
\begin{cases}
[(\sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})},\ \arctan(0/t))]_{\sim} = [(t,\ 0)]_{\sim} & (t > 0) \\
[(\sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})},\ \arctan(0/t) + \pi)]_{\sim} = [(-t,\ \pi)]_{\sim} & (t < 0) \\
[(0,\ 0)]_{\sim} & (t = 0)
\end{cases}`,
      ),
      paragraph([
        "（",
        math(String.raw`t < 0`),
        " の行は ",
        math(String.raw`x = t < 0`),
        " かつ ",
        math(String.raw`y = 0 \geq 0`),
        " の場合であり、",
        math(String.raw`\arctan 0 = 0`),
        "、",
        math(String.raw`\sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})} = -t > 0`),
        "。）よって ",
        ref("first_and_second_projections"),
        " と ",
        ref("def_abs_arg"),
        " より",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(t) = s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(t,0))\right)
= \begin{cases}
s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}}) = 0 & (t > 0) \\
s_{[0,2\pi)}([\pi]_{\sim_{\mathrm{angle}}}) = \pi & (t < 0) \\
s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}}) = 0 & (t = 0)
\end{cases}`,
      ),
      paragraph([
        "（",
        math(String.raw`t = 0`),
        " の行では ",
        ref("first_and_second_projections"),
        " の ",
        math(String.raw`\mathrm{pr}_2`),
        " の定義が ",
        math(String.raw`r = 0`),
        " のとき ",
        math(String.raw`[0]_{\sim_{\mathrm{angle}}}`),
        " を返すことを用いた。すなわち本リポジトリの規約では ",
        math(String.raw`\arg^{[0,2\pi)}(0_{\mathbb{C}}) = 0`),
        " である。）まとめると ",
        math(String.raw`\arg^{[0,2\pi)}(t) = 0 \iff t \geq 0`),
        "、",
        math(String.raw`\arg^{[0,2\pi)}(t) = \pi \iff t < 0`),
        "。",
      ]),
      paragraph([
        "Step 4: 結論。Step 2 と Step 3 を合わせると、",
        math(String.raw`\cos\theta_\mu \leq c_1 c_2^*/(s_1 s_2^*)`),
        " のとき ",
        math(String.raw`\gamma_1(\theta_\mu) \geq 0`),
        " ゆえ ",
        math(String.raw`\arg^{[0,2\pi)}(\gamma_1(\theta_\mu)) = 0`),
        "、それ以外のとき ",
        math(String.raw`\gamma_1(\theta_\mu) < 0`),
        " ゆえ ",
        math(String.raw`\arg^{[0,2\pi)}(\gamma_1(\theta_\mu)) = \pi`),
        "。これで主張の場合分けが示された（境界 ",
        math(String.raw`\cos\theta_\mu = c_1 c_2^*/(s_1 s_2^*)`),
        " では ",
        math(String.raw`\gamma_1(\theta_\mu) = 0`),
        " となるが、上の規約により ",
        math(String.raw`\arg^{[0,2\pi)}(0_{\mathbb{C}}) = 0`),
        " なので、境界を ",
        math(String.raw`\arg = 0`),
        " 側に含める原文の場合分けは正しい）。",
      ]),
      paragraph([
        "Step 5: 第 2 の場合が空であること。",
        ref("cosh_sinh_basic_properties"),
        " (1)(3) より ",
        math(String.raw`2K_1 > 0`),
        " に対して ",
        math(String.raw`c_1 = \cosh 2K_1 > \sinh 2K_1 = s_1 > 0`),
        "、同様に ",
        math(String.raw`2K_2^* > 0`),
        " に対して ",
        math(String.raw`c_2^* > s_2^* > 0`),
        "。正数どうしの不等式の積より",
      ]),
      displayMath(
        String.raw`c_1 c_2^* > s_1 c_2^* > s_1 s_2^* > 0`,
      ),
      paragraph([
        "（第 1 の不等号は ",
        math(String.raw`c_1 > s_1`),
        " の両辺に ",
        math(String.raw`c_2^* > 0`),
        " を掛けたもの、第 2 の不等号は ",
        math(String.raw`c_2^* > s_2^*`),
        " の両辺に ",
        math(String.raw`s_1 > 0`),
        " を掛けたもの。）よって ",
        math(String.raw`s_1 s_2^* > 0`),
        " で割って ",
        math(String.raw`\dfrac{c_1 c_2^*}{s_1 s_2^*} > 1`),
        "。一方 ",
        math(String.raw`\theta_\mu \in \mathbb{R}`),
        " より ",
        math(String.raw`\cos\theta_\mu \leq 1 < \dfrac{c_1 c_2^*}{s_1 s_2^*}`),
        " であるから、Step 2 より常に ",
        math(String.raw`\gamma_1(\theta_\mu) > 0`),
        " であり、第 2 の場合（otherwise）を満たす ",
        math(String.raw`\mu \in \mathcal{M}`),
        " は存在しない。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（020_claim_gamma1_gamma2の偏角.typ）には証明が無く、本リポジトリで新規に構成した。",
        "原文は arg と書いていたが、本リポジトリで定義されている偏角は arg^{[0,2π)}（labels: def_abs_arg）のみなので、そちらに統一した。",
        "原文の statement には前提 K_1, K_2 ∈ R_{>0}（c_1, s_1, c_2^*, s_2^* > 0 に必要）と θ_μ の定義が書かれていなかったため補った。",
        "境界 cos θ_μ = c_1 c_2^*/(s_1 s_2^*) では γ_1(θ_μ) = 0 となる。本リポジトリの arg は" +
          "pr_2（labels: first_and_second_projections）が r = 0 のとき [0] を返す定義なので arg^{[0,2π)}(0_C) = 0 であり、" +
          "境界を arg = 0 側に含める原文の場合分けは正しい（statement の修正は不要）。",
        "さらに K_1, K_2 ∈ R_{>0} のもとでは c_1 c_2^* > s_1 s_2^* > 0 ゆえ c_1 c_2^*/(s_1 s_2^*) > 1 ≥ cos θ_μ となり、" +
          "第 2 の場合（arg = π）は空である。この事実を statement へ追記した（原文には無い）。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_022_claim_gamma2_theta_is_0",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/021_claim_gamma2_thetaが0になる条件.typ",
    sourceOrdinal: 22,
    title: { tex: String.raw`\gamma_2(\theta_\mu) = 0 \text{ になる条件}` },
    labels: ["gamma_2_theta_is_0"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（したがって ",
        math(String.raw`K_2^* \in \mathbb{R}_{>0}`),
        "）とし、",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`),
        "、",
        math(String.raw`\theta_\mu := \dfrac{2\pi\mu}{M} \in \mathbb{R}`),
        " とする。",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
        math(String.raw`\gamma_2(\theta) := i e^{i\theta} s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2)`),
        "（",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(1,2)`),
        " 成分）は次を満たす。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\mu) = 0
&\iff \begin{cases} \sin\theta_\mu = 0 \\ c_2 s_1 - c_1\cos\theta_\mu = 0 \end{cases} \\
&\iff \begin{cases} \theta_\mu = 0,\ \pm\pi,\ \pm 2\pi,\ \dots \\ c_2 s_1 = c_1\cos\theta_\mu \end{cases} \\
&\iff \begin{cases} \mu = \pm M \\ c_2 s_1 = c_1\cos\theta_\mu \end{cases}
\iff \begin{cases} \mu = \pm M \\ c_1 = s_1 c_2 \end{cases}
\end{aligned}`,
      ),
      paragraph([
        "上の同値はいずれも「連立条件全体としての同値」である。特に第 2 段から第 3 段への同値において、",
        math(String.raw`\sin\theta_\mu = 0`),
        " という条件だけでは ",
        math(String.raw`\mu = \pm M`),
        " は従わない。実際 ",
        math(String.raw`M`),
        " が偶数のときは ",
        math(String.raw`\mu = \pm M/2 \in \mathcal{M}`),
        " も ",
        math(String.raw`\theta_\mu = \pm\pi`),
        "、",
        math(String.raw`\sin\theta_\mu = 0`),
        " を満たす。この ",
        math(String.raw`\mu`),
        " が排除されるのは、もう一方の条件 ",
        math(String.raw`c_2 s_1 = c_1\cos\theta_\mu = -c_1 < 0`),
        " が ",
        math(String.raw`c_1, s_1, c_2 > 0`),
        " と矛盾するからである（証明の Step 4 を参照）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0: 記号と所属集合の確認。",
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`c_1 = \cosh 2K_1`),
        "、",
        math(String.raw`s_1 = \sinh 2K_1`),
        "、",
        math(String.raw`c_2 = \cosh 2K_2`),
        "、",
        math(String.raw`s_2^* = \sinh 2K_2^*`),
        " はいずれも実数であり、",
        math(String.raw`K_1, K_2, K_2^* \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`c_1, s_1, c_2, s_2^* > 0`),
        "。また ",
        math(String.raw`\mu \in \mathcal{M} \subset \mathbb{Z}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " より ",
        math(String.raw`\theta_\mu = 2\pi\mu/M \in \mathbb{R}`),
        " であり、",
        math(String.raw`\cos\theta_\mu, \sin\theta_\mu \in \mathbb{R}`),
        "。",
      ]),
      paragraph([
        "Step 1: 因子 ",
        math(String.raw`i\,e^{i\theta_\mu} s_2^*`),
        " が ",
        math(String.raw`\mathbb{C}^\times`),
        " に属すること。",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`e^{i\theta_\mu} = \cos\theta_\mu + i\sin\theta_\mu`),
        " であるから、",
        ref("abs_basic_properties"),
        " (2) より ",
        math(String.raw`|e^{i\theta_\mu}|^2 = (\cos\theta_\mu)^2 + (\sin\theta_\mu)^2 = 1`),
        "、すなわち ",
        math(String.raw`|e^{i\theta_\mu}| = 1`),
        "。同様に ",
        math(String.raw`|i| = 1`),
        " であり、",
        math(String.raw`s_2^* > 0`),
        " より ",
        math(String.raw`|s_2^*| = s_2^*`),
        "（",
        ref("abs_basic_properties"),
        " (6)）。よって乗法性（同 (4)）より",
      ]),
      displayMath(
        String.raw`\left|i\,e^{i\theta_\mu} s_2^*\right| = |i|\,\left|e^{i\theta_\mu}\right|\,|s_2^*| = s_2^* > 0`,
      ),
      paragraph([
        "であり、",
        ref("abs_basic_properties"),
        " (3) より ",
        math(String.raw`i\,e^{i\theta_\mu} s_2^* \neq 0_{\mathbb{C}}`),
        "。",
      ]),
      paragraph([
        "Step 2: 第 1 の同値。",
        math(String.raw`w_\mu := c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2 \in \mathbb{C}`),
        " とおくと ",
        math(String.raw`\gamma_2(\theta_\mu) = (i\,e^{i\theta_\mu} s_2^*)\,w_\mu`),
        "。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ整域であり、Step 1 より第 1 因子は ",
        math(String.raw`0_{\mathbb{C}}`),
        " でないから",
      ]),
      displayMath(String.raw`\gamma_2(\theta_\mu) = 0_{\mathbb{C}} \iff w_\mu = 0_{\mathbb{C}}`),
      paragraph([
        "ここで ",
        math(String.raw`c_1\cos\theta_\mu - s_1 c_2 \in \mathbb{R}`),
        "、",
        math(String.raw`-\sin\theta_\mu \in \mathbb{R}`),
        " であるから、",
        ref("definition_of_cc"),
        " の成分表示で",
      ]),
      displayMath(
        String.raw`w_\mu = \bigl(c_1\cos\theta_\mu - s_1 c_2,\; -\sin\theta_\mu\bigr) \in \mathbb{R}^2 = \mathbb{C}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\mathbb{C}`),
        " の零元は ",
        math(String.raw`(0,0)`),
        " であるから",
      ]),
      displayMath(
        String.raw`w_\mu = 0_{\mathbb{C}}
\iff \begin{cases} c_1\cos\theta_\mu - s_1 c_2 = 0 \\ -\sin\theta_\mu = 0 \end{cases}
\iff \begin{cases} \sin\theta_\mu = 0 \\ c_2 s_1 - c_1\cos\theta_\mu = 0 \end{cases}`,
      ),
      paragraph(["（2 番目の同値は各式を ", math(String.raw`-1`), " 倍しただけである。）これで第 1 の同値を得た。"]),
      paragraph([
        "Step 3: 第 2 の同値。第 2 式 ",
        math(String.raw`c_2 s_1 - c_1\cos\theta_\mu = 0`),
        " と ",
        math(String.raw`c_2 s_1 = c_1\cos\theta_\mu`),
        " は同じ式である。第 1 式については、実数 ",
        math(String.raw`t \in \mathbb{R}`),
        " に対する ",
        math(String.raw`\sin`),
        " の零点の特徴づけ ",
        math(String.raw`\sin t = 0 \iff \exists k \in \mathbb{Z}:\ t = k\pi`),
        " を用いると",
      ]),
      displayMath(
        String.raw`\sin\theta_\mu = 0 \iff \theta_\mu \in \pi\mathbb{Z} = \{0,\ \pm\pi,\ \pm 2\pi,\ \dots\}`,
      ),
      paragraph(["となり、第 2 の同値を得る。"]),
      paragraph([
        "Step 4: 第 3 の同値。ここは連立条件の下ではじめて成立するので、両向きを分けて示す。",
      ]),
      paragraph([
        "（",
        math(String.raw`\Rightarrow`),
        "）",
        math(String.raw`\theta_\mu \in \pi\mathbb{Z}`),
        " かつ ",
        math(String.raw`c_2 s_1 = c_1\cos\theta_\mu`),
        " とする。",
        math(String.raw`\theta_\mu = 2\pi\mu/M = k\pi`),
        "（",
        math(String.raw`k \in \mathbb{Z}`),
        "）は ",
        math(String.raw`2\mu = kM`),
        " と同値であり、これは ",
        math(String.raw`M \mid 2\mu`),
        " を意味する。",
        math(String.raw`\mu \in \mathcal{M}`),
        " より ",
        math(String.raw`1 \leq |\mu| \leq M`),
        " すなわち ",
        math(String.raw`2 \leq 2|\mu| \leq 2M`),
        " であり、この範囲で ",
        math(String.raw`M`),
        " の倍数は ",
        math(String.raw`M`),
        " と ",
        math(String.raw`2M`),
        " のみであるから ",
        math(String.raw`2|\mu| = M`),
        " または ",
        math(String.raw`2|\mu| = 2M`),
        "、すなわち ",
        math(String.raw`|\mu| = M/2`),
        "（このとき ",
        math(String.raw`M`),
        " は偶数）または ",
        math(String.raw`|\mu| = M`),
        " である。",
      ]),
      paragraph([
        math(String.raw`|\mu| = M/2`),
        " の場合、",
        math(String.raw`\theta_\mu = \pm\pi`),
        " ゆえ ",
        math(String.raw`\cos\theta_\mu = -1`),
        " であり、第 2 式は ",
        math(String.raw`c_2 s_1 = -c_1`),
        " を要求する。しかし Step 0 より ",
        math(String.raw`c_2 s_1 > 0`),
        " かつ ",
        math(String.raw`-c_1 < 0`),
        " であり矛盾する。よってこの場合は起こらず、",
        math(String.raw`|\mu| = M`),
        " すなわち ",
        math(String.raw`\mu = \pm M`),
        " である（第 2 式はそのまま保たれる）。",
      ]),
      paragraph([
        "（",
        math(String.raw`\Leftarrow`),
        "）",
        math(String.raw`\mu = \pm M`),
        " とすると ",
        math(String.raw`\theta_\mu = \pm 2\pi \in \pi\mathbb{Z}`),
        " であり、第 1 式が成り立つ。第 2 式はそのまま保たれる。",
      ]),
      paragraph([
        "Step 5: 第 4 の同値。",
        math(String.raw`\mu = \pm M`),
        " のとき ",
        math(String.raw`\theta_\mu = \pm 2\pi`),
        " ゆえ ",
        math(String.raw`\cos\theta_\mu = 1`),
        " であるから、第 2 式 ",
        math(String.raw`c_2 s_1 = c_1\cos\theta_\mu`),
        " は ",
        math(String.raw`c_1 = s_1 c_2`),
        " と同値である。以上で主張のすべての同値が示された。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（021_claim_gamma2_thetaが0になる条件.typ）の #proof は空であり、証明は原文にも存在しない。証明は本リポジトリで新規に構成した。",
        "移行時に落ちていた同値変形の中間段（sin θ_μ = 0 ⟺ θ_μ = 0, ±π, ±2π, …）を原文どおり復旧した。",
        "原文の statement には前提 K_1, K_2 ∈ R_{>0}（c_1, s_1, c_2 > 0 に必要）と M ∈ Z_{≥1}、θ_μ の定義が書かれていなかったため補った。" +
          "また第 3 段の同値は「sin θ_μ = 0 ⟺ μ = ±M」という第 1 式単独の同値と誤読されうるが、それは偽である" +
          "（M が偶数なら μ = ±M/2 でも sin θ_μ = 0）。連立条件全体としてのみ同値であることを statement に明記し、" +
          "排除の根拠（c_2 s_1 = -c_1 < 0 が正値性と矛盾）を証明 Step 4 に書いた。",
        "最終形 μ = ±M かつ c_1 = s_1 c_2 を第 4 の同値として追加した（後続ブロックが参照する形）。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_023_claim_relation_of_gamma2",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/022_claim_gamma2_thetaとgamma2_minus_thetaの関係.typ",
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/023_claim_gamma2_theta_muの積のarg.typ",
    sourceOrdinal: 24,
    title: {
      tex: String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)) = \pi`,
    },
    labels: ["arg_of_gamma_2_mu"],
    statement: [
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\bigl(\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)\bigr) = \pi`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&= \left(i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\right)\left(i\,e^{-i\theta_\mu}s_2^*(c_1\cos(-\theta_\mu) - i\sin(-\theta_\mu) - s_1 c_2)\right) \\
&= \underbrace{(i\cdot i)\left(e^{i\theta_\mu + i(-\theta_\mu)}\right)}_{-1}\,s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\,s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2) \\
&= \underbrace{(-1)(e^0)}_{-1}\,s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\,s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2) \quad (\because \cos \text{ は偶関数}, \sin \text{ は奇関数}) \\
&= -(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2) \\
&= -(s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right) \\
&= -(s_2^*)^2\left((c_1\cos\tfrac{2\pi\mu}{M} - s_1 c_2)^2 + (\sin\tfrac{2\pi\mu}{M})^2\right) \quad (\because \theta_\mu = \tfrac{2\pi\mu}{M})
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`s_2^* > 0`),
        "（",
        ref("def_transfer_matrix_symbols"),
        "）より ",
        math(String.raw`(s_2^*)^2 > 0`),
        " である。また ",
        math(String.raw`\gamma_2(\theta_\mu)`),
        " の定義より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|\gamma_2(\theta_\mu)|^2
&= \left|i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\right|^2 \\
&= (s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right) \quad (\because |i| = |e^{i\theta_\mu}| = 1)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " より ",
        math(String.raw`|\gamma_2(\theta_\mu)|^2 > 0`),
        " であるから ",
        math(String.raw`(c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2 = \dfrac{|\gamma_2(\theta_\mu)|^2}{(s_2^*)^2} > 0`),
        "。したがって ",
        math(String.raw`\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = -(s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right) < 0`),
        " すなわち負の実数であり、負の実数の偏角は ",
        math(String.raw`\pi`),
        " であるから ",
        math(String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)) = \pi`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_025_claim_arg_gamma2_sum",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/024_claim_gamma2_theta_mu_gamma2_minus_theta_muのarg.typ",
    sourceOrdinal: 25,
    title: {
      tex: String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)) + \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu))`,
    },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について（",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0 \iff \gamma_2(-\theta_\mu) \neq 0`),
        " であるから、",
        math(String.raw`\gamma_2(\theta_\mu), \gamma_2(-\theta_\mu)`),
        " はともに非零であり、その偏角 ",
        math(String.raw`\arg^{[0,2\pi)}`),
        " が定義される）、",
        math(String.raw`r_+, r_- \in \mathbb{R}_{\geq 0}`),
        "、",
        math(String.raw`\theta_+, \theta_- \in \mathbb{R}`),
        " として ",
        math(String.raw`\gamma_2(\theta_\mu) = [(r_+, \theta_+)]`),
        "、",
        math(String.raw`\gamma_2(-\theta_\mu) = [(r_-, \theta_-)]`),
        " とするとき、",
      ]),
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/025_claim_gamma2の商のarg.typ",
    sourceOrdinal: 26,
    title: {
      tex: String.raw`\arg^{[0,2\pi)}\!\bigl(\gamma_2(\theta_\mu)/\gamma_2(-\theta_\mu)\bigr)`,
    },
    labels: ["arg_of_gamma2_quotient"],
    statement: [
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について（",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)} \neq 0`),
        " でもあるから、商 ",
        math(String.raw`\gamma_2(\theta_\mu)/\gamma_2(-\theta_\mu) \in \mathbb{C}^\times`),
        " が定義される）、",
        math(String.raw`\varphi_\mu := \arg^{[0,2\pi)}(\gamma_2(\theta_\mu)) \in [0,2\pi)`),
        " とおくと、",
      ]),
      displayMath(
        String.raw`\left|\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right| = 1,
\qquad
\arg^{[0,2\pi)}\!\Bigl(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\Bigr)
= s_{[0,2\pi)}\!\left([\,2\varphi_\mu + \pi\,]_{\sim_{\mathrm{angle}}}\right)`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`2\varphi_\mu + \pi`),
        " を ",
        math(String.raw`\bmod 2\pi`),
        " で ",
        math(String.raw`[0,2\pi)`),
        " へ還元したものであり、具体的には",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\Bigl(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\Bigr)
= \begin{cases}
2\varphi_\mu + \pi & \left(0 \leq \varphi_\mu < \tfrac{\pi}{2}\right) \\
2\varphi_\mu - \pi & \left(\tfrac{\pi}{2} \leq \varphi_\mu < \tfrac{3\pi}{2}\right) \\
2\varphi_\mu - 3\pi & \left(\tfrac{3\pi}{2} \leq \varphi_\mu < 2\pi\right)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`z := \gamma_2(\theta_\mu) \in \mathbb{C}^\times`),
        "、",
        math(String.raw`r := |z| \in \mathbb{R}_{>0}`),
        "（",
        ref("abs_basic_properties"),
        " (3) より ",
        math(String.raw`z \neq 0 \Rightarrow r > 0`),
        "）、",
        math(String.raw`\varphi_\mu := \arg^{[0,2\pi)}(z) \in [0,2\pi)`),
        " と略記する。",
      ]),
      paragraph([
        "Step 0: ",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " が ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " の逆写像であること。",
        ref("isomorphism_of_phi_cartesian"),
        " より ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は全単射であり、その証明中で ",
        math(String.raw`\phi_{\mathrm{cartesian}} \circ \phi_{\mathrm{polar}} = \mathrm{id}_{\mathbb{C}}`),
        " が示されている。全単射に右逆写像が存在すればそれは逆写像に一致するから ",
        math(String.raw`\phi_{\mathrm{polar}} = \phi_{\mathrm{cartesian}}^{-1}`),
        "。したがって ",
        math(String.raw`\phi_{\mathrm{cartesian}}([(\rho,\vartheta)]_{\sim}) = w`),
        " を確かめれば ",
        math(String.raw`\phi_{\mathrm{polar}}(w) = [(\rho,\vartheta)]_{\sim}`),
        " が従う。また同 claim より ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " はモノイド準同型なので、その逆写像 ",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " もモノイド準同型である：",
        math(String.raw`\phi_{\mathrm{polar}}(w_1 w_2) = \phi_{\mathrm{polar}}(w_1)\cdot\phi_{\mathrm{polar}}(w_2)`),
        "（右辺の積は ",
        ref("operations_on_polar_representation"),
        "）。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\phi_{\mathrm{polar}}(z) = [(r, \varphi_\mu)]_{\sim}`),
        "。実際 ",
        math(String.raw`\phi_{\mathrm{polar}}(z) = [(\rho,\vartheta)]_{\sim}`),
        " とおくと、",
        ref("def_abs_arg"),
        " より ",
        math(String.raw`\rho = \mathrm{pr}_1(\phi_{\mathrm{polar}}(z)) = |z| = r > 0`),
        " であり、",
        math(String.raw`\rho \neq 0`),
        " ゆえ ",
        ref("first_and_second_projections"),
        " より ",
        math(String.raw`\mathrm{pr}_2(\phi_{\mathrm{polar}}(z)) = [\vartheta]_{\sim_{\mathrm{angle}}}`),
        "。よって ",
        math(String.raw`\varphi_\mu = s_{[0,2\pi)}([\vartheta]_{\sim_{\mathrm{angle}}}) = \vartheta - 2n\pi`),
        "（",
        ref("section_of_angle_representation"),
        " の ",
        math(String.raw`n \in \mathbb{Z}`),
        "）となり ",
        math(String.raw`[\vartheta]_{\sim_{\mathrm{angle}}} = [\varphi_\mu]_{\sim_{\mathrm{angle}}}`),
        "、",
        ref("polar_equivalence_class"),
        " より ",
        math(String.raw`[(\rho,\vartheta)]_{\sim} = [(r,\varphi_\mu)]_{\sim}`),
        "。",
      ]),
      paragraph([
        "Step 2: 商の書き換え。",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = -|\gamma_2(\theta_\mu)|^2 = -r^2`),
        " であり、",
        math(String.raw`r > 0`),
        " より ",
        math(String.raw`-r^2 \neq 0`),
        " ゆえ ",
        math(String.raw`\gamma_2(-\theta_\mu) \neq 0`),
        "。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）だから、分子・分母に ",
        math(String.raw`z \neq 0`),
        " を掛けて",
      ]),
      displayMath(
        String.raw`\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
= \frac{\gamma_2(\theta_\mu)\,\gamma_2(\theta_\mu)}{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}
= \frac{z^2}{-r^2}
= z^2 \cdot \left(-\frac{1}{r^2}\right)`,
      ),
      paragraph([
        "Step 3: 各因子の極座標表現。Step 0 と Step 1 より",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(z^2) = \phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z)
= [(r,\varphi_\mu)]_{\sim}\cdot[(r,\varphi_\mu)]_{\sim}
= [(r^2,\ 2\varphi_\mu)]_{\sim}`,
      ),
      paragraph([
        "また ",
        math(String.raw`-\dfrac{1}{r^2} \in \mathbb{R}_{<0}`),
        " については、",
        ref("def_phi_cartesian"),
        " より",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{cartesian}}\!\left(\left[\left(\tfrac{1}{r^2},\ \pi\right)\right]_{\sim}\right)
= \left(\tfrac{1}{r^2}\cos\pi,\ \tfrac{1}{r^2}\sin\pi\right)
= \left(-\tfrac{1}{r^2},\ 0\right)
= -\frac{1}{r^2}`,
      ),
      paragraph([
        "であるから、Step 0 より ",
        math(String.raw`\phi_{\mathrm{polar}}\!\left(-\dfrac{1}{r^2}\right) = \left[\left(\dfrac{1}{r^2},\ \pi\right)\right]_{\sim}`),
        "。",
      ]),
      paragraph(["Step 4: 商の極座標表現。Step 0 の準同型性と Step 2, Step 3 より、"]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}\!\left(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right)
= [(r^2,\ 2\varphi_\mu)]_{\sim}\cdot\left[\left(\tfrac{1}{r^2},\ \pi\right)\right]_{\sim}
= \left[\left(r^2\cdot\tfrac{1}{r^2},\ 2\varphi_\mu + \pi\right)\right]_{\sim}
= [(1,\ 2\varphi_\mu + \pi)]_{\sim}`,
      ),
      paragraph([
        "よって ",
        ref("def_abs_arg"),
        " と ",
        ref("first_and_second_projections"),
        " より ",
        math(String.raw`\left|\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right| = \mathrm{pr}_1([(1, 2\varphi_\mu+\pi)]_{\sim}) = 1`),
        " であり（特に第 1 成分 ",
        math(String.raw`1 \neq 0`),
        " なので ",
        math(String.raw`\mathrm{pr}_2`),
        " は ",
        math(String.raw`[2\varphi_\mu+\pi]_{\sim_{\mathrm{angle}}}`),
        " を返す）、",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right)
= s_{[0,2\pi)}\!\left([\,2\varphi_\mu + \pi\,]_{\sim_{\mathrm{angle}}}\right)`,
      ),
      paragraph([
        "Step 5: ",
        math(String.raw`\bmod 2\pi`),
        " の還元。",
        math(String.raw`0 \leq \varphi_\mu < 2\pi`),
        " より ",
        math(String.raw`\pi \leq 2\varphi_\mu + \pi < 5\pi`),
        " である。",
        ref("section_of_angle_representation"),
        " は ",
        math(String.raw`0 \leq (2\varphi_\mu+\pi) - 2n\pi < 2\pi`),
        " なる唯一の ",
        math(String.raw`n \in \mathbb{Z}`),
        " をとって ",
        math(String.raw`(2\varphi_\mu+\pi) - 2n\pi`),
        " を返すから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0 \leq \varphi_\mu < \tfrac{\pi}{2}
&\Rightarrow \pi \leq 2\varphi_\mu+\pi < 2\pi
&&\Rightarrow n = 0,\ \arg^{[0,2\pi)} = 2\varphi_\mu + \pi \\
\tfrac{\pi}{2} \leq \varphi_\mu < \tfrac{3\pi}{2}
&\Rightarrow 2\pi \leq 2\varphi_\mu+\pi < 4\pi
&&\Rightarrow n = 1,\ \arg^{[0,2\pi)} = 2\varphi_\mu - \pi \\
\tfrac{3\pi}{2} \leq \varphi_\mu < 2\pi
&\Rightarrow 4\pi \leq 2\varphi_\mu+\pi < 5\pi
&&\Rightarrow n = 2,\ \arg^{[0,2\pi)} = 2\varphi_\mu - 3\pi
\end{aligned}`,
      ),
      paragraph(["を得る。これで主張の場合分けが示された。"]),
      paragraph([
        "Step 6（補足）: ",
        math(String.raw`\varphi_\mu`),
        " 自身の書き下し。",
        math(String.raw`w_\mu := c_1\cos\theta_\mu - s_1 c_2 - i\sin\theta_\mu \in \mathbb{C}`),
        " とおくと ",
        math(String.raw`\gamma_2(\theta_\mu) = i\,e^{i\theta_\mu} s_2^*\,w_\mu`),
        " であり、",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " より ",
        math(String.raw`w_\mu \neq 0`),
        "。",
        ref("def_phi_cartesian"),
        " と Step 0 より",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(i) = \left[\left(1,\ \tfrac{\pi}{2}\right)\right]_{\sim},
\qquad
\phi_{\mathrm{polar}}\!\left(e^{i\theta_\mu}\right) = [(1,\ \theta_\mu)]_{\sim},
\qquad
\phi_{\mathrm{polar}}(s_2^*) = [(s_2^*,\ 0)]_{\sim}`,
      ),
      paragraph([
        "（それぞれ ",
        math(String.raw`\phi_{\mathrm{cartesian}}([(1,\pi/2)]_{\sim}) = (\cos\tfrac{\pi}{2}, \sin\tfrac{\pi}{2}) = (0,1) = i`),
        "、",
        math(String.raw`\phi_{\mathrm{cartesian}}([(1,\theta_\mu)]_{\sim}) = (\cos\theta_\mu, \sin\theta_\mu) = e^{i\theta_\mu}`),
        "（",
        ref("euler_formula_cos_sin"),
        " の Euler の公式）、",
        math(String.raw`\phi_{\mathrm{cartesian}}([(s_2^*,0)]_{\sim}) = (s_2^*, 0) = s_2^*`),
        "（",
        math(String.raw`s_2^* > 0`),
        "）による。）",
        math(String.raw`\psi_\mu := \arg^{[0,2\pi)}(w_\mu)`),
        " とおくと Step 1 と同様に ",
        math(String.raw`\phi_{\mathrm{polar}}(w_\mu) = [(|w_\mu|, \psi_\mu)]_{\sim}`),
        " であるから、準同型性より",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(\gamma_2(\theta_\mu))
= \left[\left(s_2^*\,|w_\mu|,\ \tfrac{\pi}{2} + \theta_\mu + \psi_\mu\right)\right]_{\sim},
\qquad
\varphi_\mu = s_{[0,2\pi)}\!\left(\left[\theta_\mu + \tfrac{\pi}{2} + \psi_\mu\right]_{\sim_{\mathrm{angle}}}\right)`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`w_\mu = (c_1\cos\theta_\mu - s_1 c_2,\ -\sin\theta_\mu) \in \mathbb{R}^2 = \mathbb{C}`),
        " であり、",
        math(String.raw`|w_\mu| = \sqrt{(c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2}^{\,(\mathbb{R}_{\geq 0})}`),
        "、",
        math(String.raw`\psi_\mu`),
        " は ",
        ref("def_phi_polar"),
        " の場合分け（",
        math(String.raw`\arctan`),
        " による）で定まる。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（025_claim_gamma2の商のarg.typ）は statement がプレースホルダー ??? のままで証明も空だった。" +
          "本リポジトリで値を確定させ、statement の ??? を確定した式へ置き換えた。",
        "確定の根拠: relation_of_gamma_2（γ_2(θ_μ)γ_2(-θ_μ) = -|γ_2(θ_μ)|^2）より" +
          "γ_2(θ_μ)/γ_2(-θ_μ) = γ_2(θ_μ)^2/(-|γ_2(θ_μ)|^2) となり、極座標表現で [(1, 2φ_μ + π)] に等しい" +
          "（φ_μ := arg^{[0,2π)}(γ_2(θ_μ))）。よって絶対値は 1、偏角は 2φ_μ + π を mod 2π で [0,2π) へ還元した値。",
        "商が定義されるための前提 γ_2(θ_μ) ≠ 0 を statement に明示した（原文には無い）。",
        "原文の note（逆数と積の arg の参考事実）は notes/008_TV1_hatZ_hatY.mjs にそのまま残してある。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_027_claim_eigenvector_A_theta",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/026_claim_A_thetaの対角化_固有値と固有ベクトル.typ",
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
      paragraph([
        math(String.raw`A(\theta_\mu)`),
        " の定義",
      ]),
      displayMath(
        String.raw`A(\theta_\mu) :=
\begin{pmatrix}
c_1 c_2^* - s_1 s_2^*\cos\theta_\mu & i e^{i\theta_\mu} s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2) \\
-i e^{-i\theta_\mu} s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2) & c_1 c_2^* - s_1 s_2^*\cos\theta_\mu
\end{pmatrix}`,
      ),
      paragraph([
        "において ",
        math(String.raw`\gamma_1(\theta_\mu) := c_1 c_2^* - s_1 s_2^*\cos\theta_\mu`),
        "、",
        math(String.raw`\gamma_2(\theta_\mu) := i e^{i\theta_\mu} s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)`),
        " とおくと、",
      ]),
      displayMath(
        String.raw`A(\theta_\mu) = \begin{pmatrix} \gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) \end{pmatrix}`,
      ),
      paragraph(["とかける。ゆえに固有方程式は ", math(String.raw`\lambda \in \mathbb{C}`), " として"]),
      displayMath(String.raw`|A(\theta_\mu) - \lambda I| = 0`),
      displayMath(
        String.raw`\begin{aligned}
\text{(左辺)}
&= \begin{vmatrix} \gamma_1(\theta_\mu) - \lambda & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) - \lambda \end{vmatrix} \\
&= (\gamma_1(\theta_\mu) - \lambda)(\gamma_1(\theta_\mu) - \lambda) - (\gamma_2(\theta_\mu))(-\gamma_2(-\theta_\mu)) \\
&= \gamma_1(\theta_\mu)^2 - 2\lambda\gamma_1(\theta_\mu) + \lambda^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
\end{aligned}`,
      ),
      paragraph(["より"]),
      displayMath(
        String.raw`\lambda^2 - 2\lambda\gamma_1(\theta_\mu) + \gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 0`,
      ),
      paragraph(["であり、2 次方程式の解の公式より"]),
      displayMath(
        String.raw`\begin{aligned}
\lambda
&= \frac{2\gamma_1(\theta_\mu) \pm \sqrt{(-2\gamma_1(\theta_\mu))^2 - 4(\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2} \\
&= \frac{2\gamma_1(\theta_\mu) \pm \sqrt{4\gamma_1(\theta_\mu)^2 - 4(\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2} \\
&= \frac{2\gamma_1(\theta_\mu) \pm 2\sqrt{\gamma_1(\theta_\mu)^2 - (\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2} \\
&= \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{aligned}`,
      ),
      paragraph([
        "を得る。対応する固有ベクトルは ",
        math(String.raw`v := \begin{pmatrix} v_1 \\ v_2 \end{pmatrix} \in \mathbb{C}^2`),
        " として ",
        math(String.raw`A(\theta_\mu) v = \lambda v`),
        " すなわち ",
        math(String.raw`(A(\theta_\mu) - \lambda I)v = 0`),
        " を解けばよい。",
        math(String.raw`\lambda = \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " を代入すると対角成分は ",
        math(String.raw`\gamma_1(\theta_\mu) - (\gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}) = \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " となり、",
      ]),
      displayMath(
        String.raw`\begin{pmatrix}
\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} & \gamma_2(\theta_\mu) \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0 \quad \cdots (*)`,
      ),
      paragraph(["1) ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " のとき："]),
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " より ",
        math(String.raw`\gamma_2(-\theta_\mu) = 0`),
        "（",
        ref("relation_of_gamma_2"),
        "）、かつ ",
        math(String.raw`\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} = 0`),
        " であるから ",
        math(String.raw`(*)`),
        " は",
      ]),
      displayMath(
        String.raw`\begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0`,
      ),
      paragraph([
        "となり、",
        math(String.raw`v`),
        " は ",
        math(String.raw`\mathbb{C}^2 \setminus \{0\}`),
        " の任意のベクトルをとる。この場合 ",
        math(String.raw`A(\theta_\mu) = I`),
        "（",
        math(String.raw`2 \times 2`),
        " 単位行列）となる（証明は ",
        ref("A_theta_is_identity_when_gamma2_zero"),
        " を参照）。",
      ]),
      paragraph(["2) ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " のとき："]),
      paragraph([
        math(String.raw`\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \neq 0`),
        " だから、",
        math(String.raw`(*)`),
        " の第 1 行に ",
        math(String.raw`\gamma_2(-\theta_\mu)/(\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})`),
        " を掛ける行基本変形を行うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\begin{pmatrix}
\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot\dfrac{\gamma_2(-\theta_\mu)}{\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}
& \gamma_2(\theta_\mu)\cdot\dfrac{\gamma_2(-\theta_\mu)}{\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
\quad (\because \text{行の基本変形}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}{\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0 \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\mp\sqrt{-1_{\mathbb{C}}\cdot\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-1_{\mathbb{C}}\cdot\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`\arg^{[0,2\pi)}(-1_{\mathbb{C}}) + \arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)) = 2\pi`),
        "（負の実数 ",
        math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)`),
        " の偏角は ",
        math(String.raw`\pi`),
        "、",
        ref("arg_of_gamma_2_mu"),
        "）であるから、",
        ref("condition_of_commutativity_of_sqrt_and_product"),
        " より ",
        math(String.raw`\sqrt{-1_{\mathbb{C}}\cdot\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} = -\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        "。これを代入して符号 ",
        math(String.raw`\mp(-\,\cdot\,) = \pm(\,\cdot\,)`),
        " を整理すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\mp(-\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})} \\
-\gamma_2(-\theta_\mu) & \mp(-\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0 \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0 \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\pm\sqrt{-1_{\mathbb{C}}}} \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
\quad (\because \text{約分})
\end{aligned}`,
      ),
      paragraph([
        "さらに ",
        math(String.raw`\dfrac{1}{\pm x} = \pm\dfrac{1}{x}`),
        " と、",
        ref("inverse_of_sqrt_cc"),
        " および ",
        math(String.raw`0 < \arg^{[0,2\pi)}(-1_{\mathbb{C}}) = \pi < 2\pi`),
        " による ",
        math(String.raw`\dfrac{1_{\mathbb{C}}}{\sqrt{-1_{\mathbb{C}}}} = -\sqrt{\dfrac{1_{\mathbb{C}}}{-1_{\mathbb{C}}}} = -\sqrt{-1_{\mathbb{C}}}`),
        " を用いると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \pm\left(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot\dfrac{1_{\mathbb{C}}}{\sqrt{-1_{\mathbb{C}}}}\right) \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0 \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \mp\left(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot\sqrt{-1_{\mathbb{C}}}\right) \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0 \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \mp i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\
-\gamma_2(-\theta_\mu) & \pm i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
\quad (\because \sqrt{-1_{\mathbb{C}}} = i)
\end{aligned}`,
      ),
      paragraph([
        "第 1 行 ",
        math(String.raw`\gamma_2(-\theta_\mu)\,v_1 \mp i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,v_2 = 0`),
        " より、",
        math(String.raw`c \in \mathbb{C}^\times`),
        " として",
      ]),
      displayMath(
        String.raw`v = c \begin{pmatrix} \pm i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\ \gamma_2(-\theta_\mu) \end{pmatrix}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: ["原文の固有方程式・行列式展開・固有ベクトルの行基本変形を全ステップ復元。虚数単位は i、中間の複素平方根は \\sqrt{-1_C} 表記で保持。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_028_claim_P_mu_D_mu",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/027_claim_A_thetaの対角化_P_muとD_mu.typ",
    sourceOrdinal: 28,
    title: { tex: String.raw`A(\theta_\mu) \text{ の対角化 } (P_\mu,\, D_\mu)` },
    labels: ["diagonalization_P_D"],
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/028_claim_a_theta_mu.typ",
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
        math(String.raw`\mu \in \mathcal{M}`),
        " について、以下 ",
        math(String.raw`\varphi := \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu))`),
        " と略記する。",
      ]),
      paragraph([
        "Part A: ",
        math(String.raw`\dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}`),
        " と ",
        math(String.raw`\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}`),
        " の関係。",
      ]),
      paragraph([
        "Step 1: ",
        ref("range_of_args_of_square_of_complex_numbers"),
        " より、",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2)
= \begin{cases}
2\varphi & (0 \leq \varphi < \pi) \\
2\varphi - 2\pi & (\pi \leq \varphi < 2\pi)
\end{cases}`,
      ),
      paragraph(["特に、"]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) = 0 \iff \varphi \in \{0, \pi\}`,
      ),
      paragraph(["Step 2: ", ref("arg_of_gamma_2_mu"), " より、"]),
      displayMath(String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)) = \pi`),
      paragraph(["Step 3: ", ref("range_of_args_of_reciprocal_of_complex_numbers"), " より、"]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{1}{(\gamma_2(-\theta_\mu))^2}\right)
= \begin{cases}
0 & (\arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) = 0) \\
2\pi - \arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) & (0 < \arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) < 2\pi)
\end{cases}`,
      ),
      paragraph(["Step 1 の結果を代入すると、"]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{1}{(\gamma_2(-\theta_\mu))^2}\right)
= \begin{cases}
0 & (\varphi = 0) \\
2\pi - 2\varphi & (0 < \varphi < \pi) \\
0 & (\varphi = \pi) \\
4\pi - 2\varphi & (\pi < \varphi < 2\pi)
\end{cases}`,
      ),
      paragraph(["Step 4: 偏角の和は"]),
      displayMath(
        String.raw`\begin{aligned}
&\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)) + \arg^{[0,2\pi)}\!\left(\frac{1}{(\gamma_2(-\theta_\mu))^2}\right) \\
&= \pi + \begin{cases}
0 & (\varphi = 0) \\
2\pi - 2\varphi & (0 < \varphi < \pi) \\
0 & (\varphi = \pi) \\
4\pi - 2\varphi & (\pi < \varphi < 2\pi)
\end{cases}
= \begin{cases}
\pi & (\varphi = 0) \\
3\pi - 2\varphi & (0 < \varphi < \pi) \\
\pi & (\varphi = \pi) \\
5\pi - 2\varphi & (\pi < \varphi < 2\pi)
\end{cases}
\end{aligned}`,
      ),
      paragraph([
        "Step 5: 和（以下 ",
        math(String.raw`\text{sum}`),
        " と書く）が ",
        math(String.raw`[0,2\pi)`),
        " と ",
        math(String.raw`[2\pi,4\pi)`),
        " のどちらに入るかを判定する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varphi = 0 &\Rightarrow \text{sum} = \pi \in [0,2\pi) \\
0 < \varphi < \tfrac{\pi}{2} &\Rightarrow 2\pi < 3\pi - 2\varphi < 3\pi \Rightarrow \text{sum} \in [2\pi,4\pi) \\
\varphi = \tfrac{\pi}{2} &\Rightarrow \text{sum} = 2\pi \in [2\pi,4\pi) \\
\tfrac{\pi}{2} < \varphi < \pi &\Rightarrow \pi < 3\pi - 2\varphi < 2\pi \Rightarrow \text{sum} \in [0,2\pi) \\
\varphi = \pi &\Rightarrow \text{sum} = \pi \in [0,2\pi) \\
\pi < \varphi < \tfrac{3\pi}{2} &\Rightarrow 2\pi < 5\pi - 2\varphi < 3\pi \Rightarrow \text{sum} \in [2\pi,4\pi) \\
\varphi = \tfrac{3\pi}{2} &\Rightarrow \text{sum} = 2\pi \in [2\pi,4\pi) \\
\tfrac{3\pi}{2} < \varphi < 2\pi &\Rightarrow \pi < 5\pi - 2\varphi < 2\pi \Rightarrow \text{sum} \in [0,2\pi)
\end{aligned}`,
      ),
      paragraph(["以上をまとめると、"]),
      displayMath(
        String.raw`\begin{cases}
0 \leq \text{sum} < 2\pi & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
2\pi \leq \text{sum} < 4\pi & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}`,
      ),
      paragraph(["Step 6: ", ref("condition_of_commutativity_of_sqrt_and_product"), " より、"]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}
&= \begin{cases}
\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot\dfrac{1}{(\gamma_2(-\theta_\mu))^2}} & (0 \leq \text{sum} < 2\pi) \\
-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot\dfrac{1}{(\gamma_2(-\theta_\mu))^2}} & (2\pi \leq \text{sum} < 4\pi)
\end{cases} \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
\end{aligned}`,
      ),
      paragraph([
        "Step 7: ",
        ref("square_of_sqrt"),
        " より ",
        math(String.raw`\sqrt{(\gamma_2(-\theta_\mu))^2} = \begin{cases}\gamma_2(-\theta_\mu) & (0 \leq \varphi < \pi) \\ -\gamma_2(-\theta_\mu) & (\pi \leq \varphi < 2\pi)\end{cases}`),
        "、また ",
        ref("inverse_of_sqrt_cc"),
        " より",
      ]),
      displayMath(
        String.raw`\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}
= \begin{cases}
\dfrac{1}{\sqrt{(\gamma_2(-\theta_\mu))^2}} & (\arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) = 0) \\
-\dfrac{1}{\sqrt{(\gamma_2(-\theta_\mu))^2}} & (0 < \arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) < 2\pi)
\end{cases}`,
      ),
      paragraph(["Step 1 の結果と合わせて場合分けすると、"]),
      displayMath(
        String.raw`\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}
= \begin{cases}
\dfrac{1}{\gamma_2(-\theta_\mu)} & (\varphi = 0) \\
-\dfrac{1}{\gamma_2(-\theta_\mu)} & (0 < \varphi < \pi) \\
-\dfrac{1}{-\gamma_2(-\theta_\mu)} & (\varphi = \pi) \\
-\left(-\dfrac{1}{-\gamma_2(-\theta_\mu)}\right) & (\pi < \varphi < 2\pi)
\end{cases}
= \begin{cases}
\dfrac{1}{\gamma_2(-\theta_\mu)} & (\varphi = 0 \text{ or } \pi < \varphi < 2\pi) \\
-\dfrac{1}{\gamma_2(-\theta_\mu)} & (0 < \varphi \leq \pi)
\end{cases}`,
      ),
      paragraph(["Step 8: Step 6 と Step 7 を組み合わせる。"]),
      displayMath(
        String.raw`\frac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
= \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\left(\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)\right)^{-1}`,
      ),
      paragraph(["ここで Step 7 より、"]),
      displayMath(
        String.raw`\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)
= \begin{cases}
1 & (\varphi = 0 \text{ or } \pi < \varphi < 2\pi) \\
-1 & (0 < \varphi \leq \pi)
\end{cases}`,
      ),
      paragraph(["よって Step 6 の結果と合わせて各場合を計算すると、"]),
      displayMath(
        String.raw`\frac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\varphi = 0) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1) & (0 < \varphi \leq \tfrac{\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1) & (\tfrac{\pi}{2} < \varphi \leq \pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\pi < \varphi \leq \tfrac{3\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\tfrac{3\pi}{2} < \varphi < 2\pi)
\end{cases}`,
      ),
      paragraph(["各場合の符号を計算すると、"]),
      displayMath(
        String.raw`\frac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (0 \leq \varphi \leq \tfrac{\pi}{2} \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (\tfrac{\pi}{2} < \varphi \leq \tfrac{3\pi}{2})
\end{cases}`,
      ),
      paragraph([
        "Part B: ",
        math(String.raw`\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}`),
        " の ",
        math(String.raw`\alpha_1, \alpha_2`),
        " 表式への変換。以下では ",
        math(String.raw`\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}`),
        " が ",
        math(String.raw`a(\theta_\mu)`),
        " の定義式の ",
        math(String.raw`\sqrt{\ }`),
        " の中身に等しいことを示す。",
      ]),
      paragraph(["Step 9: ", math(String.raw`\gamma_2`), " の定義の代入。"]),
      displayMath(
        String.raw`\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
= \frac{i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{i\,e^{-i\theta_\mu}s_2^*(c_1\cos(-\theta_\mu) - i\sin(-\theta_\mu) - s_1 c_2)}`,
      ),
      paragraph(["Step 10: ", math(String.raw`\cos(-\theta) = \cos\theta,\ \sin(-\theta) = -\sin\theta`), " を適用すると、"]),
      displayMath(
        String.raw`= \frac{i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{i\,e^{-i\theta_\mu}s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)}`,
      ),
      paragraph(["Step 11: ", math(String.raw`i\,s_2^*`), " を約分すると、"]),
      displayMath(
        String.raw`= \frac{e^{i\theta_\mu}(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{e^{-i\theta_\mu}(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)}`,
      ),
      paragraph([
        "Step 12: ",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`\cos\theta_\mu = \dfrac{e^{i\theta_\mu} + e^{-i\theta_\mu}}{2}`),
        "、",
        math(String.raw`\sin\theta_\mu = \dfrac{e^{i\theta_\mu} - e^{-i\theta_\mu}}{2i}`),
        " を用いると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_1\cos\theta_\mu - i\sin\theta_\mu
&= c_1\frac{e^{i\theta_\mu} + e^{-i\theta_\mu}}{2} - i\cdot\frac{e^{i\theta_\mu} - e^{-i\theta_\mu}}{2i} \\
&= c_1\frac{e^{i\theta_\mu} + e^{-i\theta_\mu}}{2} - \frac{e^{i\theta_\mu} - e^{-i\theta_\mu}}{2} \\
&= \frac{(c_1 - 1)e^{i\theta_\mu} + (c_1 + 1)e^{-i\theta_\mu}}{2}
\end{aligned}`,
      ),
      paragraph(["同様に、"]),
      displayMath(
        String.raw`c_1\cos\theta_\mu + i\sin\theta_\mu = \frac{(c_1 + 1)e^{i\theta_\mu} + (c_1 - 1)e^{-i\theta_\mu}}{2}`,
      ),
      paragraph(["Step 13: 分子分母へ代入し整理すると、"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&= \frac{e^{i\theta_\mu}\left(\dfrac{(c_1 - 1)e^{i\theta_\mu} + (c_1 + 1)e^{-i\theta_\mu}}{2} - s_1 c_2\right)}{e^{-i\theta_\mu}\left(\dfrac{(c_1 + 1)e^{i\theta_\mu} + (c_1 - 1)e^{-i\theta_\mu}}{2} - s_1 c_2\right)} \\
&= \frac{e^{i\theta_\mu}\left((c_1 - 1)e^{i\theta_\mu} + (c_1 + 1)e^{-i\theta_\mu} - 2 s_1 c_2\right)}{e^{-i\theta_\mu}\left((c_1 + 1)e^{i\theta_\mu} + (c_1 - 1)e^{-i\theta_\mu} - 2 s_1 c_2\right)} \\
&= \frac{(c_1 - 1)e^{2i\theta_\mu} + (c_1 + 1) - 2 s_1 c_2\, e^{i\theta_\mu}}{(c_1 + 1) + (c_1 - 1)e^{-2i\theta_\mu} - 2 s_1 c_2\, e^{-i\theta_\mu}}
\end{aligned}`,
      ),
      paragraph([
        "Step 14: ",
        math(String.raw`x := e^{i\theta_\mu}`),
        " とおくと、分子 ",
        math(String.raw`= (c_1 - 1)x^2 - 2 s_1 c_2 x + (c_1 + 1)`),
        "、分母 ",
        math(String.raw`= (c_1 - 1)x^{-2} - 2 s_1 c_2 x^{-1} + (c_1 + 1)`),
        "。",
        math(String.raw`(c_1 + 1)`),
        " でくくると、",
      ]),
      displayMath(
        String.raw`\text{分子} = (c_1 + 1)\left(\frac{c_1 - 1}{c_1 + 1}x^2 - \frac{2 s_1 c_2}{c_1 + 1}x + 1\right), \quad
\text{分母} = (c_1 + 1)\left(\frac{c_1 - 1}{c_1 + 1}x^{-2} - \frac{2 s_1 c_2}{c_1 + 1}x^{-1} + 1\right)`,
      ),
      paragraph(["Step 15: ", math(String.raw`\dfrac{c_1 - 1}{c_1 + 1} = \alpha_1\alpha_2^{-1}`), " の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\alpha_1\alpha_2^{-1}
&= (\tanh K_1\tanh K_2^*)\cdot((\tanh K_1)^{-1}\tanh K_2^*)^{-1} \\
&= (\tanh K_1\tanh K_2^*)\cdot(\tanh K_1(\tanh K_2^*)^{-1}) \\
&= (\tanh K_1)^2
\end{aligned}`,
      ),
      paragraph(["一方、"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{c_1 - 1}{c_1 + 1}
&= \frac{\cosh 2K_1 - 1}{\cosh 2K_1 + 1} \\
&= \frac{2\sinh^2 K_1}{2\cosh^2 K_1} \quad (\because \cosh 2x - 1 = 2\sinh^2 x,\ \cosh 2x + 1 = 2\cosh^2 x) \\
&= (\tanh K_1)^2
\end{aligned}`,
      ),
      paragraph(["よって、"]),
      displayMath(String.raw`\frac{c_1 - 1}{c_1 + 1} = \alpha_1\alpha_2^{-1} \quad \cdots (\star)`),
      paragraph(["Step 16: ", math(String.raw`\dfrac{2 s_1 c_2}{c_1 + 1} = \alpha_1 + \alpha_2^{-1}`), " の証明。まず"]),
      displayMath(
        String.raw`\begin{aligned}
\alpha_1 + \alpha_2^{-1}
&= \tanh K_1\tanh K_2^* + (\tanh K_1)^{-1}(\tanh K_2^*)^{-1} \\
&= \tanh K_1\tanh K_2^* + \frac{\tanh K_1}{\tanh K_2^*} \quad (\because \alpha_2^{-1} = ((\tanh K_1)^{-1}\tanh K_2^*)^{-1} = \tanh K_1(\tanh K_2^*)^{-1}) \\
&= \tanh K_1\left(\tanh K_2^* + (\tanh K_2^*)^{-1}\right)
\end{aligned}`,
      ),
      paragraph(["ここで、"]),
      displayMath(
        String.raw`\begin{aligned}
\tanh K_2^* + (\tanh K_2^*)^{-1}
&= \frac{\sinh K_2^*}{\cosh K_2^*} + \frac{\cosh K_2^*}{\sinh K_2^*} \\
&= \frac{\sinh^2 K_2^* + \cosh^2 K_2^*}{\sinh K_2^*\cosh K_2^*} \\
&= \frac{2\cosh 2K_2^*}{\sinh 2K_2^*} \quad (\because \cosh^2 x + \sinh^2 x = \cosh 2x,\ 2\sinh x\cosh x = \sinh 2x)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`K_2^* = -\tfrac{1}{2}\log(\tanh K_2)`),
        " すなわち ",
        math(String.raw`e^{-2K_2^*} = \tanh K_2`),
        " より、",
      ]),
      displayMath(
        String.raw`\sinh 2K_2^*
= \frac{e^{2K_2^*} - e^{-2K_2^*}}{2}
= \frac{(\tanh K_2)^{-1} - \tanh K_2}{2}
= \frac{\cosh^2 K_2 - \sinh^2 K_2}{2\sinh K_2\cosh K_2}
= \frac{1}{\sinh 2K_2}`,
      ),
      displayMath(
        String.raw`\cosh 2K_2^*
= \frac{e^{2K_2^*} + e^{-2K_2^*}}{2}
= \frac{(\tanh K_2)^{-1} + \tanh K_2}{2}
= \frac{\cosh^2 K_2 + \sinh^2 K_2}{2\sinh K_2\cosh K_2}
= \frac{\cosh 2K_2}{\sinh 2K_2}`,
      ),
      paragraph(["よって、"]),
      displayMath(
        String.raw`\frac{2\cosh 2K_2^*}{\sinh 2K_2^*}
= 2\cdot\frac{\cosh 2K_2/\sinh 2K_2}{1/\sinh 2K_2}
= 2\cosh 2K_2,
\qquad
\alpha_1 + \alpha_2^{-1} = \tanh K_1\cdot 2\cosh 2K_2 = 2\tanh K_1\cosh 2K_2`,
      ),
      paragraph(["一方、"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{2 s_1 c_2}{c_1 + 1}
&= \frac{2\sinh 2K_1\cosh 2K_2}{\cosh 2K_1 + 1} \\
&= \frac{2\cdot 2\sinh K_1\cosh K_1\cdot\cosh 2K_2}{2\cosh^2 K_1} \quad (\because \sinh 2x = 2\sinh x\cosh x,\ \cosh 2x + 1 = 2\cosh^2 x) \\
&= \frac{2\sinh K_1\cosh 2K_2}{\cosh K_1} = 2\tanh K_1\cosh 2K_2
\end{aligned}`,
      ),
      paragraph(["よって、"]),
      displayMath(String.raw`\frac{2 s_1 c_2}{c_1 + 1} = \alpha_1 + \alpha_2^{-1} \quad \cdots (\star\star)`),
      paragraph(["Step 17: 因数分解の検証。", math(String.raw`(1 - \alpha_1 x)(1 - \alpha_2^{-1}x)`), " を展開すると、"]),
      displayMath(
        String.raw`(1 - \alpha_1 x)(1 - \alpha_2^{-1}x)
= 1 - (\alpha_1 + \alpha_2^{-1})x + \alpha_1\alpha_2^{-1}x^2
\overset{(\star),(\star\star)}{=} 1 - \frac{2 s_1 c_2}{c_1 + 1}x + \frac{c_1 - 1}{c_1 + 1}x^2`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`(c_1 + 1)(1 - \alpha_1 x)(1 - \alpha_2^{-1}x) = (c_1 + 1) - 2 s_1 c_2 x + (c_1 - 1)x^2`,
      ),
      paragraph([
        "これは Step 14 の分子と一致する（",
        math(String.raw`x = e^{i\theta_\mu}`),
        "）。同様に ",
        math(String.raw`y := e^{-i\theta_\mu} = x^{-1}`),
        " とおくと ",
        math(String.raw`(c_1 + 1)(1 - \alpha_1 y)(1 - \alpha_2^{-1}y) = (c_1 + 1) - 2 s_1 c_2 y + (c_1 - 1)y^2`),
        " が Step 14 の分母と一致する。",
      ]),
      paragraph(["Step 18: 結論。Step 14 と Step 17 より、"]),
      displayMath(
        String.raw`\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
= \frac{(c_1 + 1)(1 - \alpha_1 e^{i\theta_\mu})(1 - \alpha_2^{-1}e^{i\theta_\mu})}{(c_1 + 1)(1 - \alpha_1 e^{-i\theta_\mu})(1 - \alpha_2^{-1}e^{-i\theta_\mu})}
= \frac{(1 - \alpha_1 e^{i\theta_\mu})(1 - \alpha_2^{-1}e^{i\theta_\mu})}{(1 - \alpha_1 e^{-i\theta_\mu})(1 - \alpha_2^{-1}e^{-i\theta_\mu})}`,
      ),
      paragraph(["したがって ", math(String.raw`a(\theta_\mu)`), " の定義より、"]),
      displayMath(
        String.raw`a(\theta_\mu)
= \sqrt{\frac{(1 - \alpha_1 e^{i\theta_\mu})(1 - \alpha_2^{-1}e^{i\theta_\mu})}{(1 - \alpha_1 e^{-i\theta_\mu})(1 - \alpha_2^{-1}e^{-i\theta_\mu})}}
= \sqrt{\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}`,
      ),
      paragraph(["Part A の Step 8 の結果と合わせて、Claim のステートメントが示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: ["原文の Part A（Steps 1-8 の偏角場合分け）と Part B（Steps 9-18 の α1,α2 因数分解）を全ステップ復元。arg^[0,2π)(γ2(-θμ)) を φ と略記。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_030_definition_fermi",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/029_definition_フェルミオン.typ",
    sourceOrdinal: 30,
    title: { text: "フェルミオン" },
    labels: ["def_fermi"],
    statement: [
      paragraph([
        math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`),
        " とする。",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \mathcal{M}`),
        " についてのみ、",
        math(String.raw`\psi_\mu, \psi_\mu^\dagger \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " を",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
&:= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot P_\mu \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}
\begin{pmatrix}
+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} & -i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\
\gamma_2(-\theta_\mu) & \gamma_2(-\theta_\mu)
\end{pmatrix}
\end{aligned}`,
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
      paragraph([
        "この定義は正規化因子 ",
        math(String.raw`\dfrac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}`),
        " を含むため、",
        math(String.raw`\gamma_2(-\theta_\mu) \neq 0`),
        " すなわち ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        "（",
        ref("relation_of_gamma_2"),
        " より両者は同値）のときにのみ意味をもつ。",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " となる ",
        math(String.raw`\mu \in \mathcal{M}`),
        " については ",
        math(String.raw`P_\mu`),
        "（",
        ref("diagonalization_P_D"),
        "）が定義されず、正規化因子 ",
        math(String.raw`\dfrac{1}{\gamma_2(-\theta_\mu)}`),
        " が ",
        math(String.raw`0`),
        " 除算となるため、",
        math(String.raw`\psi_\mu, \psi_\mu^\dagger`),
        " は定義されない（存在しない）。",
        ref("gamma_2_theta_is_0"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " となるのは ",
        math(String.raw`\mu = \pm M`),
        " かつ臨界条件 ",
        math(String.raw`c_1 = s_1 c_2`),
        "（",
        ref("critical_condition_c1_eq_s1_c2"),
        " より Ising 臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " に対応）を満たす場合に限られる。特に臨界点では ",
        math(String.raw`\psi_M, \psi_M^\dagger`),
        " が存在しない。この ",
        math(String.raw`\mu`),
        " に対する ",
        math(String.raw`T_{(V)}, T_{(V')}`),
        " の作用は ",
        ref("T_Vprime_fixes_hatZ_hatY_when_gamma2_zero"),
        " および ",
        ref("T_V_eq_T_Vprime_on_hatZ_hatY"),
        " の場合 2 で、フェルミオンを経由せず直接扱う。",
      ]),
    ],
    proof: [],
    conversion: {
      status: "converted",
      notes: [
        "現行ソースに再同期：ψ_μ の定義域を γ2(θμ)≠0 なる μ に限定し、γ2=0（臨界点の ψ_M）では ψ が存在しない旨の注、および a(θμ) の逆数・符号 ε_μ に関する注を反映。",
        "定義が意味をもつ条件（γ2≠0）とその帰結は定義の妥当性そのものなので statement へ格上げした。" +
          "符号 ε_μ による書き換えとホロノミック量子場との比較は notes/008_TV1_hatZ_hatY.mjs へ移設。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_031_claim_V_psi_commutator",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/030_claim_Vとpsiの交換関係.typ",
    sourceOrdinal: 31,
    title: { tex: String.raw`V \text{ と } \psi \text{ の交換関係 (B.13)}` },
    labels: ["commutation_V_psi"],
    statement: [
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について（このとき ",
        ref("def_fermi"),
        " より ",
        math(String.raw`\psi_\mu, \psi_\mu^\dagger`),
        " が定義される）、",
      ]),
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
      paragraph([ref("def_fermi"), " より、"]),
      displayMath(
        String.raw`\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot P_\mu`,
      ),
      paragraph([
        math(String.raw`T_{(V)}`),
        " は ",
        ref("mat_conj"),
        " より線型写像であり、",
        math(String.raw`P_\mu`),
        " の各成分は ",
        math(String.raw`\hat{Z}_\mu^{(-)}, \hat{Y}_\mu`),
        " に依らない複素数なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}\!\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
&= T_{(V)}\!\bigl(\bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)\cdot P_\mu\bigr) \\
&= \begin{pmatrix} T_{(V)}(\hat{Z}_\mu^{(-)}) & T_{(V)}(\hat{Y}_\mu) \end{pmatrix}\cdot P_\mu
\quad (\because T_{(V)} \text{ の線形性}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) A(\theta_\mu)\cdot P_\mu
\quad (\because \text{T\_V\_hatZ\_hatY}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)(P_\mu D_\mu P_\mu^{-1})\cdot P_\mu
\quad (\because A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu D_\mu \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix} D_\mu \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}\begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix} \\
&= \begin{pmatrix} \lambda_{+,\mu}\psi_\mu^\dagger & \lambda_{-,\mu}\psi_\mu \end{pmatrix} \\
&= \begin{pmatrix} \bigl(\gamma_1(\theta_\mu) + \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)\psi_\mu^\dagger & \bigl(\gamma_1(\theta_\mu) - \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)\psi_\mu \end{pmatrix}
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}`),
        " と固有値 ",
        math(String.raw`\lambda_{\pm,\mu} = \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " は ",
        ref("eigenvector_of_A_theta"),
        " による）。両成分を比較して主張を得る。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: ["現行ソースに再同期（定義域を γ2(θμ)≠0 に限定）し、行列共役の各ステップを全展開。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_032_claim_anticommutator_psi",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/031_claim_psiの反交換関係.typ",
    sourceOrdinal: 32,
    title: { tex: String.raw`\psi \text{ の反交換関係}` },
    labels: ["anticommutator_of_psi"],
    statement: [
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。"]),
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " かつ ",
        math(String.raw`\gamma_2(\theta_\nu) \neq 0`),
        " なる ",
        math(String.raw`\mu, \nu \in \mathcal{M}`),
        " について（このとき ",
        ref("def_fermi"),
        " より ",
        math(String.raw`\psi_\mu, \psi_\mu^\dagger, \psi_\nu, \psi_\nu^\dagger`),
        " が定義される）、",
      ]),
      displayMath(
        String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+ = 0, \quad
[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}, \quad
[\psi_\mu, \psi_\nu]_+ = 0`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_fermi"),
        " より、",
        math(String.raw`c_\mu := \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\psi_\mu^\dagger &= c_\mu\bigl(+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\hat{Z}_\mu^{(-)} + \gamma_2(-\theta_\mu)\hat{Y}_\mu\bigr) \\
\psi_\mu &= c_\mu\bigl(-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\hat{Z}_\mu^{(-)} + \gamma_2(-\theta_\mu)\hat{Y}_\mu\bigr)
\end{aligned}`,
      ),
      paragraph(["である。また、", ref("anticommutator_of_hat_Z_and_hat_Y"), " より、"]),
      displayMath(
        String.raw`[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ = 2M\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}, \quad
[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ = 0, \quad
[\hat{Y}_\mu, \hat{Y}_\nu]_+ = 2M\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}`,
      ),
      paragraph(["である。"]),
      paragraph(["a) ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+`), " について、反交換子の双線型性より"]),
      displayMath(
        String.raw`\begin{aligned}
[\psi_\mu^\dagger, \psi_\nu^\dagger]_+
&= c_\mu c_\nu\Bigl(
(i)(i)\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\nu)[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ \\
&\quad + \gamma_2(-\theta_\mu)\,i\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Y}_\mu, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)[\hat{Y}_\mu, \hat{Y}_\nu]_+
\Bigr) \\
&= c_\mu c_\nu\bigl(-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`),
        " のとき ",
        math(String.raw`\mu + \nu \equiv 0 \pmod{M}`),
        " すなわち ",
        math(String.raw`\theta_\nu = -\theta_\mu`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
= \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)}
= \bigl(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)^2
= \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) \quad (\because (\sqrt{z})^2 = z)`,
      ),
      displayMath(
        String.raw`\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu) = \gamma_2(-\theta_\mu)\gamma_2(\theta_\mu) = \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)`,
      ),
      paragraph(["したがって係数の和は"]),
      displayMath(
        String.raw`-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)
= -\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 0`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} = 0`),
        " のときは全体が ",
        math(String.raw`0`),
        "。以上から ",
        math(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+ = 0`),
        "。",
      ]),
      paragraph(["b) ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+`), " について、双線型性より"]),
      displayMath(
        String.raw`[\psi_\mu^\dagger, \psi_\nu]_+
= c_\mu c_\nu\bigl(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}`,
      ),
      paragraph([
        "（",
        math(String.raw`(i)(-i) = 1`),
        " より第 1 項の符号が正になり、",
        math(String.raw`[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ = 0`),
        " により中間 2 項は消える）。",
        math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`),
        " のとき a) と同じ計算により係数の和は",
      ]),
      displayMath(
        String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu) = 2\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)`,
      ),
      paragraph([
        "また ",
        math(String.raw`\gamma_2(-\theta_\nu) = \gamma_2(\theta_\mu)`),
        " より ",
        math(String.raw`c_\mu c_\nu = \dfrac{1}{4M\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)} = \dfrac{1}{4M\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " であるから、",
      ]),
      displayMath(
        String.raw`[\psi_\mu^\dagger, \psi_\nu]_+
= \frac{1}{4M\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot 2\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot 2M\cdot\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}
= \delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} = 0`),
        " のときは全体が ",
        math(String.raw`0`),
        "。以上から ",
        math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}`),
        "。",
      ]),
      paragraph([
        "c) ",
        math(String.raw`[\psi_\mu, \psi_\nu]_+`),
        " について、双線型性より ",
        math(String.raw`(-i)(-i) = -1`),
        " となり、a) と同じ",
      ]),
      displayMath(
        String.raw`[\psi_\mu, \psi_\nu]_+
= c_\mu c_\nu\bigl(-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}`,
      ),
      paragraph(["となる。a) と同じ議論により ", math(String.raw`[\psi_\mu, \psi_\nu]_+ = 0`), "。"]),
    ],
    conversion: {
      status: "converted",
      notes: ["現行ソースに再同期（定義域を γ2(θμ),γ2(θν)≠0 に限定）し、三つの反交換子の計算を全展開。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_035_claim_det_A_theta",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/034_claim_det_A_theta_mu.typ",
    sourceOrdinal: 35,
    title: { tex: String.raw`\det A(\theta_\mu) = 1` },
    labels: ["det_A_theta"],
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/035_claim_gamma1_geq_1.typ",
    sourceOrdinal: 36,
    title: { tex: String.raw`\gamma_1(\theta_\mu) \geq 1` },
    labels: ["gamma1_geq_1"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\gamma_1(\theta_\mu) \geq 1`),
    ],
    proof: [
      paragraph([
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`),
        " すなわち ",
        math(String.raw`-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = |\gamma_2(\theta_\mu)|^2`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta_\mu)^2
= 1 - \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
= 1 + |\gamma_2(\theta_\mu)|^2 \geq 1`,
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
    id: "TV1_hatZ_hatY_034a_definition_gamma_theta_mu",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ",
    sourceOrdinal: 34,
    title: { tex: String.raw`\gamma(\theta_\mu) \text{ の定義}` },
    labels: ["def_gamma_theta_mu"],
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
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ",
    sourceOrdinal: 34,
    title: { tex: String.raw`\lambda_{\pm,\mu} = e^{\pm\gamma(\theta_\mu)}` },
    labels: ["lambda_eq_exp_gamma"],
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
    id: "TV1_hatZ_hatY_033_definition_Vprime",
    kind: "definition",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/032_definition_Vprimeの定義.typ",
    sourceOrdinal: 33,
    title: { tex: String.raw`V' \text{ の定義}` },
    labels: ["def_Vprime"],
    statement: [
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。"]),
      displayMath(
        String.raw`V' := \exp\!\Biggl(+\sum_{\substack{\mu \in \{1,\dots,M\} \\ \gamma_2(\theta_\mu) \neq 0}} \gamma(\theta_\mu)\Bigl(\psi_\mu^\dagger \psi_{-\mu} - \tfrac{1}{2}\Bigr)\Biggr)`,
      ),
      paragraph([
        "ここで和は ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " を満たす ",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " にわたる。この ",
        math(String.raw`\mu`),
        " に対しては ",
        ref("def_fermi"),
        " と ",
        ref("relation_of_gamma_2"),
        "（",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0 \iff \gamma_2(-\theta_\mu) \neq 0`),
        "）より ",
        math(String.raw`\psi_\mu^\dagger, \psi_{-\mu}`),
        " がともに定義されるため、和の各項は well-defined である。",
      ]),
      paragraph([
        "この限定によって一般性は失われない。",
        ref("gamma_2_theta_is_0"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " となる ",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " は臨界条件下の ",
        math(String.raw`\mu = M`),
        " に限られ、除外されるこの ",
        math(String.raw`\mu`),
        " については ",
        ref("T_Vprime_fixes_hatZ_hatY_when_gamma2_zero"),
        " の Step 1 より ",
        math(String.raw`\gamma(\theta_\mu) = 0`),
        "（係数が ",
        math(String.raw`0`),
        "）であるから、仮に項が定義できたとしても ",
        math(String.raw`V'`),
        " には寄与しないためである。除外された ",
        math(String.raw`\mu`),
        " に対する ",
        math(String.raw`T_{(V')}`),
        " の作用は ",
        ref("T_Vprime_fixes_hatZ_hatY_when_gamma2_zero"),
        " で ",
        math(String.raw`\hat{Z}_\mu^{(-)}, \hat{Y}_\mu`),
        " を経由して直接扱う。",
      ]),
    ],
    proof: [],
    conversion: {
      status: "converted",
      notes: [
        "現行ソースに再同期：V' の和を γ2(θμ)≠0 なる μ∈{1,...,M} に限定し、限定理由（臨界点 μ=M の除外と γ(θμ)=0）およびホロノミック量子場との相違の注を反映。",
        "和の範囲を限定してよい理由（除外される μ では γ(θμ)=0 で寄与しない）は定義の妥当性そのものなので statement へ格上げした。" +
          "ホロノミック量子場の定義との比較は notes/008_TV1_hatZ_hatY.mjs へ移設。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_038_claim_action_T_Vprime_psi",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/037_claim_T_Vprimeのpsiへの作用.typ",
    sourceOrdinal: 38,
    title: { tex: String.raw`T_{(V')} \text{ の } \psi \text{ への作用}` },
    labels: ["action_of_T_Vprime_on_psi"],
    statement: [
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について（このとき ",
        ref("def_fermi"),
        " より ",
        math(String.raw`\psi_\mu, \psi_\mu^\dagger`),
        " が定義される）、",
      ]),
      displayMath(
        String.raw`T_{(V')}(\psi_\mu^\dagger) = e^{+\gamma(\theta_\mu)}\psi_\mu^\dagger,
\quad
T_{(V')}(\psi_\mu) = e^{-\gamma(\theta_\mu)}\psi_\mu`,
      ),
    ],
    proof: [
      paragraph([ref("def_Vprime"), " より ", math(String.raw`V' = \exp(X)`), " ただし"]),
      displayMath(
        String.raw`X := +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\Bigl(\psi_\nu^\dagger \psi_{-\nu} - \tfrac{1}{2}\Bigr)`,
      ),
      paragraph([
        "である（",
        ref("def_Vprime"),
        " の和と同じく ",
        math(String.raw`\gamma_2(\theta_\nu) \neq 0`),
        " なる ",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " にわたる。この ",
        math(String.raw`\nu`),
        " については ",
        ref("def_fermi"),
        " と ",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\psi_\nu^\dagger, \psi_{-\nu}`),
        " がともに定義される）。",
      ]),
      paragraph([
        math(String.raw`X`),
        " と ",
        math(String.raw`-X`),
        " は可換（",
        math(String.raw`X(-X) = -X^2 = (-X)X`),
        "）だから ",
        ref("theorem_exp_product"),
        " より",
      ]),
      displayMath(
        String.raw`\exp(X)\exp(-X) = \exp(X + (-X)) = \exp(O) = I \quad (\because \text{theorem\_exp\_zero})`,
      ),
      paragraph([
        "故に ",
        math(String.raw`V'^{-1} = \exp(-X)`),
        " であり、",
        math(String.raw`T_{(V')}(\psi_\mu^\dagger) = V'\psi_\mu^\dagger V'^{-1} = \exp(X)\psi_\mu^\dagger\exp(-X)`),
        "。",
      ]),
      paragraph(["Step 1: ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger] = \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
\psi_\nu^\dagger \psi_{-\nu}\psi_\mu^\dagger
&= \psi_\nu^\dagger(\delta^M_{\mu-\nu,0}\,I - \psi_\mu^\dagger\psi_{-\nu})
\quad (\because [\psi_{-\nu}, \psi_\mu^\dagger]_+ = \delta^M_{\mu-\nu,0}\,I) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger - \psi_\nu^\dagger\psi_\mu^\dagger\psi_{-\nu} \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger + \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}
\quad (\because [\psi_\nu^\dagger, \psi_\mu^\dagger]_+ = 0)
\end{aligned}`,
      ),
      paragraph(["（反交換関係は ", ref("anticommutator_of_psi"), " による）。ゆえに"]),
      displayMath(
        String.raw`\begin{aligned}
[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger]
&= \psi_\nu^\dagger \psi_{-\nu}\psi_\mu^\dagger - \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu} \\
&= (\delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger + \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}) - \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu} \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
\end{aligned}`,
      ),
      paragraph(["Step 2: ", math(String.raw`[X, \psi_\mu^\dagger] = +\gamma(\theta_\mu)\psi_\mu^\dagger`), "。"]),
      displayMath(
        String.raw`[X, \psi_\mu^\dagger]
= +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\,[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger]
\quad (\because \text{scalar\_identity\_commutes})
= +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\,\delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
\quad (\because \text{Step 1})`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu-\nu,0} \neq 0`),
        " となる ",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " を ",
        math(String.raw`\mu`),
        " の場合分けで特定する。特定される ",
        math(String.raw`\nu`),
        " はいずれも ",
        math(String.raw`\theta_\nu \equiv \pm\theta_\mu \pmod{2\pi}`),
        " を満たし、",
        math(String.raw`\gamma_2`),
        " は ",
        math(String.raw`\theta`),
        " の ",
        math(String.raw`\cos, \sin, e^{i\theta}`),
        " のみに依存するから ",
        math(String.raw`\gamma_2(\theta_\nu) = \gamma_2(\pm\theta_\mu)`),
        "。",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " と ",
        ref("relation_of_gamma_2"),
        "（",
        math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`),
        "）より ",
        math(String.raw`\gamma_2(\pm\theta_\mu) \neq 0`),
        " であるから、特定される ",
        math(String.raw`\nu`),
        " は和の添字集合に属する。",
      ]),
      paragraph([
        "a) ",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " のとき: ",
        math(String.raw`\mu \equiv \nu \pmod{M}`),
        " かつ ",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " を満たす ",
        math(String.raw`\nu`),
        " は ",
        math(String.raw`\nu = \mu`),
        " のみ。よって ",
        math(String.raw`[X, \psi_\mu^\dagger] = \gamma(\theta_\mu)\psi_\mu^\dagger`),
        "。",
      ]),
      paragraph([
        "b) ",
        math(String.raw`\mu = -k`),
        "（",
        math(String.raw`k \in \{1,\dots,M-1\}`),
        "）のとき: ",
        math(String.raw`-k \equiv \nu \pmod{M}`),
        " かつ ",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " を満たす ",
        math(String.raw`\nu`),
        " は ",
        math(String.raw`\nu = M - k`),
        " のみ。",
        math(String.raw`\theta_{M-k} = 2\pi - \theta_k`),
        " より ",
        math(String.raw`e^{i\theta_{M-k}} = e^{-i\theta_k}`),
        "、",
        math(String.raw`\cos\theta_{M-k} = \cos\theta_k`),
        "、",
        math(String.raw`\sin\theta_{M-k} = -\sin\theta_k`),
        "。また ",
        ref("def_hatZ_hatY"),
        " より ",
        math(String.raw`\hat{Z}_{M-k}^{(-)} = \hat{Z}_{-k}^{(-)}`),
        "、",
        math(String.raw`\hat{Y}_{M-k} = \hat{Y}_{-k}`),
        "。",
        ref("def_A_theta"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_{M-k})
&= i\,e^{i\theta_{M-k}}s_2^*(c_1\cos\theta_{M-k} - i\sin\theta_{M-k} - s_1 c_2) \\
&= i\,e^{-i\theta_k}s_2^*(c_1\cos\theta_k + i\sin\theta_k - s_1 c_2)
= \gamma_2(-\theta_k) = \gamma_2(\theta_{-k}) \\
\gamma_2(-\theta_{M-k})
&= i\,e^{i\theta_k}s_2^*(c_1\cos\theta_k - i\sin\theta_k - s_1 c_2)
= \gamma_2(\theta_k) = \gamma_2(-\theta_{-k})
\end{aligned}`,
      ),
      paragraph([
        "これらと ",
        ref("def_fermi"),
        " より ",
        math(String.raw`\psi_{M-k}^\dagger = \psi_{-k}^\dagger`),
        "、また ",
        math(String.raw`\cos\theta_{M-k} = \cos\theta_k = \cos\theta_{-k}`),
        " より ",
        math(String.raw`\gamma_1(\theta_{M-k}) = \gamma_1(\theta_{-k})`),
        " ゆえ ",
        math(String.raw`\gamma(\theta_{M-k}) = \gamma(\theta_{-k})`),
        "。よって ",
        math(String.raw`[X, \psi_{-k}^\dagger] = \gamma(\theta_{-k})\psi_{-k}^\dagger`),
        "。",
      ]),
      paragraph([
        "c) ",
        math(String.raw`\mu = -M`),
        " のとき: ",
        math(String.raw`\nu = M`),
        " のみ。",
        ref("hatZ_hatY_M_periodicity"),
        " より ",
        math(String.raw`\hat{Z}_M^{(-)} = \hat{Z}_{-M}^{(-)}`),
        "、",
        math(String.raw`\hat{Y}_M = \hat{Y}_{-M}`),
        "、",
        ref("gamma2_theta_M_periodicity"),
        " より ",
        math(String.raw`\gamma_2(\theta_M) = \gamma_2(\theta_{-M})`),
        "、",
        math(String.raw`\gamma_2(-\theta_M) = \gamma_2(-\theta_{-M})`),
        "。ゆえ ",
        ref("def_fermi"),
        " より ",
        math(String.raw`\psi_M^\dagger = \psi_{-M}^\dagger`),
        "、",
        math(String.raw`\gamma(\theta_M) = \gamma(\theta_{-M})`),
        " であり ",
        math(String.raw`[X, \psi_{-M}^\dagger] = \gamma(\theta_{-M})\psi_{-M}^\dagger`),
        "。",
      ]),
      paragraph([
        "a)〜c) より全 ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について ",
        math(String.raw`[X, \psi_\mu^\dagger] = \gamma(\theta_\mu)\psi_\mu^\dagger`),
        "、すなわち ",
        math(String.raw`X\psi_\mu^\dagger = \psi_\mu^\dagger X + \gamma(\theta_\mu)\psi_\mu^\dagger = \psi_\mu^\dagger(X + \gamma(\theta_\mu)I)`),
        "。",
      ]),
      paragraph(["Step 3: 帰納法で ", math(String.raw`X^n \psi_\mu^\dagger = \psi_\mu^\dagger (X + \gamma(\theta_\mu)I)^n`), " を示す。"]),
      displayMath(
        String.raw`\begin{aligned}
X^{n+1}\psi_\mu^\dagger
&= X\cdot X^n\psi_\mu^\dagger \\
&= X\cdot \psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^n \quad (\because \text{帰納法の仮定}) \\
&= (\psi_\mu^\dagger(X + \gamma(\theta_\mu)I))\cdot(X + \gamma(\theta_\mu)I)^n \quad (\because \text{Step 2 のまとめ}) \\
&= \psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^{n+1}
\end{aligned}`,
      ),
      paragraph([math(String.raw`n = 0`), " のときは ", math(String.raw`X^0\psi_\mu^\dagger = \psi_\mu^\dagger = \psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^0`), " で成立するから、全 ", math(String.raw`n \geq 0`), " で成立する。"]),
      paragraph(["Step 4: ", math(String.raw`\exp(X)\psi_\mu^\dagger = \psi_\mu^\dagger \exp(X + \gamma(\theta_\mu)I)`), "。"]),
      displayMath(
        String.raw`\sum_{n=0}^N \frac{X^n}{n!}\,\psi_\mu^\dagger
= \sum_{n=0}^N \frac{X^n\psi_\mu^\dagger}{n!}
= \sum_{n=0}^N \frac{\psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^n}{n!} \quad (\because \text{Step 3})
= \psi_\mu^\dagger \sum_{n=0}^N \frac{(X + \gamma(\theta_\mu)I)^n}{n!}`,
      ),
      paragraph([
        math(String.raw`N \to \infty`),
        " の極限で ",
        ref("exp_converges"),
        " より右辺は ",
        math(String.raw`\psi_\mu^\dagger\exp(X + \gamma(\theta_\mu)I)`),
        " に収束し（",
        ref("matrix_multiplication_continuity"),
        "）、",
        math(String.raw`\exp(X)\psi_\mu^\dagger = \psi_\mu^\dagger\exp(X + \gamma(\theta_\mu)I)`),
        "。",
      ]),
      paragraph([
        "Step 5: 結論。",
        math(String.raw`(X + \gamma(\theta_\mu)I)`),
        " と ",
        math(String.raw`(-X)`),
        " は可換だから ",
        ref("theorem_exp_product"),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V')}(\psi_\mu^\dagger)
&= \exp(X)\psi_\mu^\dagger\exp(-X) \\
&= \psi_\mu^\dagger\exp(X + \gamma(\theta_\mu)I)\exp(-X) \quad (\because \text{Step 4}) \\
&= \psi_\mu^\dagger\exp((X + \gamma(\theta_\mu)I) + (-X)) \quad (\because \text{theorem\_exp\_product}) \\
&= \psi_\mu^\dagger\exp(\gamma(\theta_\mu)I) \\
&= \psi_\mu^\dagger\cdot e^{\gamma(\theta_\mu)}I \quad (\because (\gamma(\theta_\mu)I)^n = (\gamma(\theta_\mu))^n I) \\
&= e^{+\gamma(\theta_\mu)}\psi_\mu^\dagger
\end{aligned}`,
      ),
      paragraph([math(String.raw`T_{(V')}(\psi_\mu) = e^{-\gamma(\theta_\mu)}\psi_\mu`), " について。"]),
      paragraph(["Step 1': ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu] = -\delta^M_{\nu+\mu,0}\,\psi_{-\nu}`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
\psi_\nu^\dagger \psi_{-\nu}\psi_\mu
&= \psi_\nu^\dagger(-\psi_\mu\psi_{-\nu}) \quad (\because [\psi_{-\nu}, \psi_\mu]_+ = 0) \\
&= -\psi_\nu^\dagger\psi_\mu\psi_{-\nu} \\
&= -(\delta^M_{\nu+\mu,0}\,I - \psi_\mu\psi_\nu^\dagger)\psi_{-\nu} \quad (\because [\psi_\nu^\dagger, \psi_\mu]_+ = \delta^M_{\nu+\mu,0}\,I) \\
&= -\delta^M_{\nu+\mu,0}\,\psi_{-\nu} + \psi_\mu\psi_\nu^\dagger\psi_{-\nu}
\end{aligned}`,
      ),
      paragraph(["（反交換関係は ", ref("anticommutator_of_psi"), " による）。ゆえに ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu] = -\delta^M_{\nu+\mu,0}\,\psi_{-\nu}`), "。"]),
      paragraph(["Step 2': ", math(String.raw`[X, \psi_\mu] = -\gamma(\theta_\mu)\psi_\mu`), "。"]),
      displayMath(
        String.raw`[X, \psi_\mu]
= +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\,[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu]
= -\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\,\delta^M_{\nu+\mu,0}\,\psi_{-\nu}
\quad (\because \text{Step 1'})`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\nu+\mu,0} \neq 0`),
        " となる ",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " を ",
        math(String.raw`\mu`),
        " の場合分けで特定し ",
        math(String.raw`\psi_{-\nu} = \psi_\mu`),
        " を確認する（周期性の計算は Step 2 と対称的で、特定される ",
        math(String.raw`\nu`),
        " が和の添字集合に属することも同様）：",
      ]),
      list([
        [math(String.raw`\mu \in \{1,\dots,M-1\}`), ": ", math(String.raw`\nu = M-\mu`), "、", math(String.raw`\psi_{-(M-\mu)} = \psi_{\mu-M} = \psi_\mu`), "、", math(String.raw`\gamma(\theta_{M-\mu}) = \gamma(\theta_\mu)`), "。"],
        [math(String.raw`\mu = M`), ": ", math(String.raw`\nu = M`), "、", math(String.raw`\psi_{-M} = \psi_M`), "。"],
        [math(String.raw`\mu = -k\ (k \in \{1,\dots,M-1\})`), ": ", math(String.raw`\nu = k`), "、", math(String.raw`\psi_{-k} = \psi_\mu`), "、", math(String.raw`\gamma(\theta_k) = \gamma(\theta_{-k})`), "。"],
        [math(String.raw`\mu = -M`), ": ", math(String.raw`\nu = M`), "、", math(String.raw`\psi_{-M} = \psi_{-M}`), "、", math(String.raw`\gamma(\theta_M) = \gamma(\theta_{-M})`), "。"],
      ]),
      paragraph([
        "以上より全 ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について ",
        math(String.raw`[X, \psi_\mu] = -\gamma(\theta_\mu)\psi_\mu`),
        "、すなわち ",
        math(String.raw`X\psi_\mu = \psi_\mu(X - \gamma(\theta_\mu)I)`),
        "。Steps 3'〜5' は ",
        math(String.raw`\psi_\mu^\dagger`),
        " の証明と ",
        math(String.raw`\gamma(\theta_\mu) \to -\gamma(\theta_\mu)`),
        "（符号反転）のみ異なり同様に成立し、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V')}(\psi_\mu)
&= \exp(X)\psi_\mu\exp(-X) \\
&= \psi_\mu\exp(X - \gamma(\theta_\mu)I)\exp(-X) \\
&= \psi_\mu\exp((X - \gamma(\theta_\mu)I) + (-X)) \quad (\because \text{theorem\_exp\_product}) \\
&= \psi_\mu\cdot e^{-\gamma(\theta_\mu)}I \quad (\because \text{Step 5 と同様}) \\
&= e^{-\gamma(\theta_\mu)}\psi_\mu
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: ["現行ソースに再同期（X の和を γ2(θν)≠0 に限定）し、Step 1-5（ψ^†）と Step 1'-2'（ψ）の場合分け・周期性・帰納法・exp 極限を全展開。Steps 3'-5' は符号反転で同様として簡潔化（ソースも同様）。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_045_claim_A_theta_is_identity",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/044_claim_gamma2_0のときA_thetaは単位行列.typ",
    sourceOrdinal: 45,
    title: { tex: String.raw`\gamma_2(\theta_\mu) = 0 \text{ のとき } A(\theta_\mu) = I` },
    labels: ["A_theta_is_identity_when_gamma2_zero"],
    statement: [
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。", math(String.raw`\mu \in \mathcal{M}`), " が ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " を満たすとき、"]),
      displayMath(String.raw`A(\theta_\mu) = I \quad (2 \times 2 \text{ 単位行列})`),
    ],
    proof: [
      paragraph([math(String.raw`\gamma_2(\theta_\mu) = 0`), " を満たす ", math(String.raw`\mu \in \mathcal{M}`), " を固定する。"]),
      paragraph(["Step 1: ", math(String.raw`\gamma_2(-\theta_\mu) = 0`), "。", ref("relation_of_gamma_2"), " より ", math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`), " であるから、"]),
      displayMath(
        String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)} = -\overline{0} = 0 \quad (\because \gamma_2(\theta_\mu) = 0)`,
      ),
      paragraph(["Step 2: ", math(String.raw`\gamma_1(\theta_\mu) = 1`), "。", ref("det_A_theta"), " より ", math(String.raw`\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 1`), " であるから、"]),
      displayMath(
        String.raw`\gamma_1(\theta_\mu)^2 = 1 - \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 1 - 0\cdot 0 = 1 \quad (\because \gamma_2(\theta_\mu) = 0,\ \text{Step 1})`,
      ),
      paragraph([ref("gamma1_geq_1"), " より ", math(String.raw`\gamma_1(\theta_\mu) \geq 1 > 0`), " であるから、", math(String.raw`\gamma_1(\theta_\mu)^2 = 1`), " と合わせて ", math(String.raw`\gamma_1(\theta_\mu) = 1`), " を得る。"]),
      paragraph([
        "Step 3: ",
        math(String.raw`A(\theta_\mu) = I`),
        "。",
        ref("det_A_theta"),
        " の証明中で確認したとおり、",
        math(String.raw`A(\theta_\mu) = \begin{pmatrix} \gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) \end{pmatrix}`),
        " と表される（",
        ref("def_A_theta"),
        " の各成分の ",
        math(String.raw`\gamma_1, \gamma_2`),
        " による書き換え）。Step 1, Step 2 の結果を代入すると、",
      ]),
      displayMath(
        String.raw`A(\theta_\mu)
= \begin{pmatrix} \gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) \end{pmatrix}
= \begin{pmatrix} 1 & 0 \\ -0 & 1 \end{pmatrix}
= \begin{pmatrix} 1 & 0 \\ 0 & 1 \end{pmatrix}
= I`,
      ),
      paragraph(["である。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_042_claim_T_Vprime_fixes_hatZ_hatY_gamma2_zero",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/041_claim_T_VprimeのhatZ_hatYへの作用_gamma2が0の場合.typ",
    sourceOrdinal: 42,
    title: { tex: String.raw`\gamma_2(\theta_\mu) = 0 \text{ のとき } T_{(V')} \text{ は } \hat{Z}_\mu^{(-)}, \hat{Y}_\mu \text{ を固定する}` },
    labels: ["T_Vprime_fixes_hatZ_hatY_when_gamma2_zero"],
    statement: [
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。"]),
      paragraph([
        math(String.raw`\mu \in \mathcal{M}`),
        " が ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " を満たすとき、",
      ]),
      displayMath(
        String.raw`T_{(V')}(\hat{Z}_\mu^{(-)}) = \hat{Z}_\mu^{(-)}, \quad T_{(V')}(\hat{Y}_\mu) = \hat{Y}_\mu`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " を満たす ",
        math(String.raw`\mu \in \mathcal{M}`),
        " を固定する。",
        ref("def_Vprime"),
        " より ",
        math(String.raw`V' = \exp(X)`),
        "、ただし",
      ]),
      displayMath(
        String.raw`X := \sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\Bigl(\psi_\nu^\dagger \psi_{-\nu} - \tfrac{1}{2}\Bigr)`,
      ),
      paragraph([
        "である。",
        ref("def_Vprime"),
        " の定義により、",
        math(String.raw`X`),
        " の和は最初から ",
        math(String.raw`\gamma_2(\theta_\nu) \neq 0`),
        " となる ",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " のみにわたる。この ",
        math(String.raw`\nu`),
        " については ",
        ref("def_fermi"),
        " と ",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\psi_\nu^\dagger, \psi_{-\nu}`),
        " がともに定義されるので、",
        math(String.raw`X`),
        " の各項は well-defined である（",
        math(String.raw`\gamma_2(\theta_\nu) = 0`),
        " となる ",
        math(String.raw`\nu`),
        " ははじめから和に含まれない）。",
      ]),
      paragraph([
        ref("action_of_T_Vprime_on_psi"),
        " の証明冒頭と同様に ",
        math(String.raw`V'^{-1} = \exp(-X)`),
        " であり、",
        math(String.raw`T_g`),
        " の定義（",
        ref("def_T_g"),
        "）より ",
        math(String.raw`T_{(V')}(W) = V'W V'^{-1} = \exp(X)W\exp(-X)`),
        "（",
        math(String.raw`W \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        "）である。",
      ]),
      paragraph(["Step 1: ", math(String.raw`\gamma_2(\theta_\nu) = 0 \Rightarrow \gamma(\theta_\nu) = 0`), "。"]),
      paragraph([
        math(String.raw`\gamma_2(\theta_\nu) = 0`),
        " とする。",
        ref("det_A_theta"),
        " より ",
        math(String.raw`\gamma_1(\theta_\nu)^2 + \gamma_2(\theta_\nu)\gamma_2(-\theta_\nu) = 1`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta_\nu)^2 = 1 - \gamma_2(\theta_\nu)\gamma_2(-\theta_\nu) = 1 - 0\cdot\gamma_2(-\theta_\nu) = 1 \quad (\because \gamma_2(\theta_\nu) = 0)`,
      ),
      paragraph([
        ref("gamma1_geq_1"),
        " より ",
        math(String.raw`\gamma_1(\theta_\nu) \geq 1 > 0`),
        " であるから ",
        math(String.raw`\gamma_1(\theta_\nu) = 1`),
        "。よって ",
        math(String.raw`\gamma(\theta_\nu) = \mathrm{arccosh}(\gamma_1(\theta_\nu)) = \mathrm{arccosh}(1) = 0`),
        "（",
        math(String.raw`\gamma(\theta_\nu)`),
        " の定義は ",
        ref("def_gamma_theta_mu"),
        "）。",
      ]),
      paragraph(["Step 2: ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " かつ ", math(String.raw`\delta^M_{\mu\pm\nu,0} \neq 0`), " ならば ", math(String.raw`\gamma_2(\theta_\nu) = 0`), "（ゆえに ", math(String.raw`\gamma(\theta_\nu) = 0`), "）。"]),
      paragraph([
        math(String.raw`\nu \in \{1,\dots,M\}`),
        " とし、",
        math(String.raw`\delta^M_{\mu-\nu,0} \neq 0`),
        " または ",
        math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`),
        " と仮定する。すなわち ",
        math(String.raw`\mu \equiv \nu \pmod{M}`),
        " または ",
        math(String.raw`\mu \equiv -\nu \pmod{M}`),
        "。",
        ref("gamma_2_theta_is_0"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " は ",
        math(String.raw`\sin\theta_\mu = 0`),
        " かつ ",
        math(String.raw`c_1\cos\theta_\mu = s_1 c_2`),
        " と同値である。",
        math(String.raw`\theta_\kappa = \tfrac{2\pi\kappa}{M}`),
        " であるから ",
        math(String.raw`\mu \equiv \nu \pmod{M}`),
        " のとき、ある ",
        math(String.raw`\ell \in \mathbb{Z}`),
        " で ",
        math(String.raw`\nu = \mu + \ell M`),
        " と書け ",
        math(String.raw`\theta_\nu = \theta_\mu + 2\pi\ell`),
        "、",
        math(String.raw`\mu \equiv -\nu \pmod{M}`),
        " のときは ",
        math(String.raw`\theta_\nu = -\theta_\mu + 2\pi\ell`),
        " である。",
      ]),
      paragraph([
        "いずれの場合も三角関数の周期性・偶奇性より ",
        math(String.raw`\cos\theta_\nu = \cos\theta_\mu`),
        "、",
        math(String.raw`\sin\theta_\nu = \pm\sin\theta_\mu = 0`),
        " であるから ",
        math(String.raw`\sin\theta_\nu = 0`),
        "、",
        math(String.raw`c_1\cos\theta_\nu = c_1\cos\theta_\mu = s_1 c_2`),
        "。",
        ref("gamma_2_theta_is_0"),
        " より ",
        math(String.raw`\gamma_2(\theta_\nu) = 0`),
        "、Step 1 より ",
        math(String.raw`\gamma(\theta_\nu) = 0`),
        "。",
      ]),
      paragraph(["Step 3: ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " のとき ", math(String.raw`[X, \hat{Z}_\mu^{(-)}] = O`), " かつ ", math(String.raw`[X, \hat{Y}_\mu] = O`), "。"]),
      paragraph([
        "各 ",
        math(String.raw`\nu \in \{1,\dots,M\}`),
        "（",
        math(String.raw`\gamma_2(\theta_\nu) \neq 0`),
        "）について ",
        math(String.raw`c_\nu := \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\nu)}`),
        " とおくと ",
        ref("def_fermi"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\psi_\nu^\dagger &= c_\nu\bigl(+i\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}\,\hat{Z}_\nu^{(-)} + \gamma_2(-\theta_\nu)\hat{Y}_\nu\bigr) \\
\psi_{-\nu} &= c_{-\nu}\bigl(-i\sqrt{\gamma_2(\theta_{-\nu})\gamma_2(-\theta_{-\nu})}\,\hat{Z}_{-\nu}^{(-)} + \gamma_2(-\theta_{-\nu})\hat{Y}_{-\nu}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " と反交換子の双線型性、",
        math(String.raw`[\hat{Z}_\kappa^{(-)}, \hat{Y}_\lambda]_+ = 0`),
        " より（",
        math(String.raw`\delta^M_{\nu+\mu,0} = \delta^M_{\mu+\nu,0}`),
        "、",
        math(String.raw`\delta^M_{-\nu+\mu,0} = \delta^M_{\mu-\nu,0}`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\psi_\nu^\dagger, \hat{Z}_\mu^{(-)}]_+ &= c_\nu\bigl(+i\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I \\
[\psi_{-\nu}, \hat{Z}_\mu^{(-)}]_+ &= c_{-\nu}\bigl(-i\sqrt{\gamma_2(\theta_{-\nu})\gamma_2(-\theta_{-\nu})}\bigr)\cdot 2M\delta^M_{\mu-\nu,0}\,I \\
[\psi_\nu^\dagger, \hat{Y}_\mu]_+ &= c_\nu\,\gamma_2(-\theta_\nu)\cdot 2M\delta^M_{\mu+\nu,0}\,I \\
[\psi_{-\nu}, \hat{Y}_\mu]_+ &= c_{-\nu}\,\gamma_2(-\theta_{-\nu})\cdot 2M\delta^M_{\mu-\nu,0}\,I
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`W \in \{\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\}`),
        " を固定する。いま ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " かつ ",
        math(String.raw`\gamma_2(\theta_\nu) \neq 0`),
        " であるから、Step 2 の対偶より ",
        math(String.raw`\delta^M_{\mu+\nu,0} = 0`),
        " かつ ",
        math(String.raw`\delta^M_{\mu-\nu,0} = 0`),
        "。よって上の反交換子はすべて ",
        math(String.raw`O`),
        " となる: ",
        math(String.raw`[\psi_\nu^\dagger, W]_+ = O`),
        "、",
        math(String.raw`[\psi_{-\nu}, W]_+ = O`),
        "。したがって ",
        ref("commutator_via_anticommutators"),
        " より",
      ]),
      displayMath(
        String.raw`[\psi_\nu^\dagger \psi_{-\nu}, W] = \psi_\nu^\dagger[\psi_{-\nu}, W]_+ - [\psi_\nu^\dagger, W]_+\psi_{-\nu} = \psi_\nu^\dagger O - O\psi_{-\nu} = O`,
      ),
      paragraph([
        "また ",
        math(String.raw`[\tfrac{1}{2}I, W] = O`),
        "（",
        ref("scalar_identity_commutes"),
        "）だから ",
        math(String.raw`[\psi_\nu^\dagger \psi_{-\nu} - \tfrac{1}{2}, W] = O`),
        "、ゆえ ",
        math(String.raw`[\gamma(\theta_\nu)(\psi_\nu^\dagger \psi_{-\nu} - \tfrac{1}{2}), W] = O`),
        "。和の各 ",
        math(String.raw`\nu`),
        " でこれが ",
        math(String.raw`O`),
        " だから交換子の加法性より ",
        math(String.raw`[X, W] = O`),
        "。",
        math(String.raw`W`),
        " は ",
        math(String.raw`\hat{Z}_\mu^{(-)}, \hat{Y}_\mu`),
        " いずれでもよいから ",
        math(String.raw`[X, \hat{Z}_\mu^{(-)}] = O`),
        "、",
        math(String.raw`[X, \hat{Y}_\mu] = O`),
        "。",
      ]),
      paragraph(["Step 4: ", math(String.raw`[X, W] = O \Rightarrow \exp(X)W\exp(-X) = W`), "。"]),
      paragraph([
        math(String.raw`[X, W] = O`),
        " すなわち ",
        math(String.raw`XW = WX`),
        " とする。帰納法で ",
        math(String.raw`X^n W = W X^n`),
        "（",
        math(String.raw`n \geq 0`),
        "）を示す。",
      ]),
      displayMath(
        String.raw`X^{n+1}W = X\cdot X^n W = X\cdot W X^n = (XW)X^n = (WX)X^n = W X^{n+1} \quad (\because XW = WX)`,
      ),
      paragraph([math(String.raw`n = 0`), " で ", math(String.raw`X^0 W = W = W X^0`), " だから全 ", math(String.raw`n \geq 0`), " で成立する。よって"]),
      displayMath(
        String.raw`\left(\sum_{n=0}^N \frac{X^n}{n!}\right)W = \sum_{n=0}^N \frac{X^n W}{n!} = \sum_{n=0}^N \frac{W X^n}{n!} = W\left(\sum_{n=0}^N \frac{X^n}{n!}\right)`,
      ),
      paragraph([
        math(String.raw`N \to \infty`),
        " の極限で ",
        ref("exp_converges"),
        "・",
        ref("matrix_multiplication_continuity"),
        " より ",
        math(String.raw`\exp(X)W = W\exp(X)`),
        "。",
        math(String.raw`X`),
        " と ",
        math(String.raw`-X`),
        " は可換だから ",
        ref("theorem_exp_product"),
        " より ",
        math(String.raw`\exp(X)\exp(-X) = \exp(O) = I`),
        "（",
        ref("theorem_exp_zero"),
        "）であり、",
      ]),
      displayMath(
        String.raw`T_{(V')}(W) = \exp(X)W\exp(-X) = W\exp(X)\exp(-X) = W`,
      ),
      paragraph([
        "Step 3 より ",
        math(String.raw`[X, \hat{Z}_\mu^{(-)}] = O`),
        " かつ ",
        math(String.raw`[X, \hat{Y}_\mu] = O`),
        " であるから ",
        math(String.raw`T_{(V')}(\hat{Z}_\mu^{(-)}) = \hat{Z}_\mu^{(-)}`),
        "、",
        math(String.raw`T_{(V')}(\hat{Y}_\mu) = \hat{Y}_\mu`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: ["現行ソース（Phase-1 で規約撤去・場合分け簡約済み）を Step 1-4 まで忠実に翻訳。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_043_claim_T_V_eq_T_Vprime_on_hatZ_hatY",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/042_claim_T_VとT_VprimeはhatZ_hatY上で一致.typ",
    sourceOrdinal: 43,
    title: { tex: String.raw`T_{(V)} \text{ と } T_{(V')} \text{ は } \hat{Z}^{(-)}, \hat{Y} \text{ 上で一致する}` },
    labels: ["T_V_eq_T_Vprime_on_hatZ_hatY"],
    statement: [
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。すべての ", math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`T_{(V)}(\hat{Z}_\mu^{(-)}) = T_{(V')}(\hat{Z}_\mu^{(-)}), \quad T_{(V)}(\hat{Y}_\mu) = T_{(V')}(\hat{Y}_\mu)`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`\mu \in \mathcal{M}`),
        " を固定する。",
        math(String.raw`T_{(V)}`),
        " はその定義（",
        ref("def_T_V"),
        "）より 3 つの写像 ",
        math(String.raw`T_{(V_1^{(\pm)})^{1/2}}, T_{(V_2)}, T_{(V_1^{(\pm)})^{1/2}}`),
        " の合成であり、各写像は ",
        math(String.raw`T_g`),
        "（",
        ref("def_T_g"),
        "）の形で ",
        ref("mat_conj"),
        " より線型写像であるから、合成として ",
        math(String.raw`T_{(V)}`),
        " も線型写像である。",
        math(String.raw`T_{(V')}`),
        " は ",
        math(String.raw`T_g`),
        " の ",
        math(String.raw`g = V'`),
        " の場合であり、",
        ref("def_Vprime"),
        " より ",
        math(String.raw`V'`),
        " は可逆であるから ",
        ref("mat_conj"),
        " より線型写像である。",
        math(String.raw`\gamma_2(\theta_\mu)`),
        " が ",
        math(String.raw`0`),
        " であるか否かで場合分けする。",
      ]),
      paragraph(["場合 1: ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), "。このとき ", ref("def_fermi"), " より ", math(String.raw`\psi_\mu^\dagger, \psi_\mu`), " が定義され、"]),
      displayMath(
        String.raw`\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix} = \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu`,
      ),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`P_\mu`),
        " は ",
        ref("diagonalization_P_D"),
        " で与えられる ",
        math(String.raw`2 \times 2`),
        " 複素行列",
      ]),
      displayMath(
        String.raw`P_\mu = \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}
\begin{pmatrix}
+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} & -i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\
\gamma_2(-\theta_\mu) & \gamma_2(-\theta_\mu)
\end{pmatrix}`,
      ),
      paragraph(["である。まず ", math(String.raw`P_\mu`), " が可逆であることを示す。行列式は"]),
      displayMath(
        String.raw`\begin{aligned}
\det P_\mu
&= \frac{1}{(2\sqrt{M}\,\gamma_2(-\theta_\mu))^2}\Bigl((+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})\gamma_2(-\theta_\mu) - (-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})\gamma_2(-\theta_\mu)\Bigr) \\
&= \frac{1}{(2\sqrt{M}\,\gamma_2(-\theta_\mu))^2}\cdot 2i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0 \iff \gamma_2(-\theta_\mu) \neq 0`),
        "、ゆえ ",
        math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) \neq 0`),
        " かつ ",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \neq 0`),
        "（",
        ref("square_of_sqrt"),
        " より ",
        math(String.raw`(\sqrt{z})^2 = z \neq 0`),
        " ゆえ ",
        math(String.raw`\sqrt{z} \neq 0`),
        "）である。よって ",
        math(String.raw`\det P_\mu \neq 0`),
        " であり ",
        math(String.raw`P_\mu`),
        " は可逆である。",
      ]),
      paragraph([math(String.raw`P_\mu^{-1} = \begin{pmatrix} q_{11} & q_{12} \\ q_{21} & q_{22} \end{pmatrix}`), "（各 ", math(String.raw`q_{ij} \in \mathbb{C}`), "）とおくと、"]),
      displayMath(
        String.raw`\begin{aligned}
\bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu P_\mu^{-1} \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix} P_\mu^{-1} \quad (\because \text{def\_fermi}) \\
&= \begin{pmatrix} q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu & q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu \end{pmatrix}
\end{aligned}`,
      ),
      paragraph(["すなわち ", math(String.raw`\hat{Z}_\mu^{(-)} = q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu`), "、", math(String.raw`\hat{Y}_\mu = q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu`), " である。一方、", ref("commutation_V_psi"), " と ", ref("lambda_eq_exp_gamma"), " より"]),
      displayMath(
        String.raw`T_{(V)}(\psi_\mu^\dagger) = e^{\gamma(\theta_\mu)}\psi_\mu^\dagger, \quad T_{(V)}(\psi_\mu) = e^{-\gamma(\theta_\mu)}\psi_\mu`,
      ),
      paragraph(["であり、", ref("action_of_T_Vprime_on_psi"), " より"]),
      displayMath(
        String.raw`T_{(V')}(\psi_\mu^\dagger) = e^{\gamma(\theta_\mu)}\psi_\mu^\dagger, \quad T_{(V')}(\psi_\mu) = e^{-\gamma(\theta_\mu)}\psi_\mu`,
      ),
      paragraph(["である。したがって"]),
      displayMath(
        String.raw`T_{(V)}(\psi_\mu^\dagger) = T_{(V')}(\psi_\mu^\dagger), \quad T_{(V)}(\psi_\mu) = T_{(V')}(\psi_\mu) \quad \cdots (\star)`,
      ),
      paragraph(["が成り立つ。これより、"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(\hat{Z}_\mu^{(-)})
&= T_{(V)}(q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu) \\
&= q_{11}T_{(V)}(\psi_\mu^\dagger) + q_{21}T_{(V)}(\psi_\mu) \quad (\because T_{(V)} \text{ の線型性}) \\
&= q_{11}T_{(V')}(\psi_\mu^\dagger) + q_{21}T_{(V')}(\psi_\mu) \quad (\because (\star)) \\
&= T_{(V')}(q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu) \quad (\because T_{(V')} \text{ の線型性}) \\
&= T_{(V')}(\hat{Z}_\mu^{(-)})
\end{aligned}`,
      ),
      paragraph(["が成り立つ。同様に ", math(String.raw`T_{(V)}(\hat{Y}_\mu) = T_{(V')}(\hat{Y}_\mu)`), " が成り立つ。"]),
      paragraph(["場合 2: ", math(String.raw`\gamma_2(\theta_\mu) = 0`), "。", math(String.raw`T_{(V)}`), " について ", ref("T_V_hatZ_hatY"), " より ", math(String.raw`(T_{(V)}(\hat{Z}_\mu^{(-)}), T_{(V)}(\hat{Y}_\mu)) = (\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)A(\theta_\mu)`), " であり、", ref("A_theta_is_identity_when_gamma2_zero"), " より ", math(String.raw`A(\theta_\mu) = I`), " であるから、"]),
      displayMath(
        String.raw`(T_{(V)}(\hat{Z}_\mu^{(-)}), T_{(V)}(\hat{Y}_\mu)) = (\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)I = (\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)}) = \hat{Z}_\mu^{(-)}`),
        "、",
        math(String.raw`T_{(V)}(\hat{Y}_\mu) = \hat{Y}_\mu`),
        "。",
        math(String.raw`T_{(V')}`),
        " について ",
        ref("T_Vprime_fixes_hatZ_hatY_when_gamma2_zero"),
        " より ",
        math(String.raw`T_{(V')}(\hat{Z}_\mu^{(-)}) = \hat{Z}_\mu^{(-)}`),
        "、",
        math(String.raw`T_{(V')}(\hat{Y}_\mu) = \hat{Y}_\mu`),
        "。したがって両者は一致する。",
      ]),
      paragraph([
        "結論: 場合 1, 2 いずれでも ",
        math(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)}) = T_{(V')}(\hat{Z}_\mu^{(-)})`),
        "、",
        math(String.raw`T_{(V)}(\hat{Y}_\mu) = T_{(V')}(\hat{Y}_\mu)`),
        " が成り立つ。",
        math(String.raw`\mu \in \mathcal{M}`),
        " は任意であったから、主張が示された。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: ["ソースを忠実に翻訳（場合 1: フェルミオン経由、場合 2: A(θμ)=I 経由）。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_039_claim_T_V_eq_T_Vprime",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/038_claim_T_V_eq_T_Vprime.typ",
    sourceOrdinal: 39,
    title: { tex: String.raw`T_{(V)} = T_{(V')}` },
    labels: ["T_V_eq_T_Vprime"],
    statement: [
      displayMath(String.raw`T_{(V)} = T_{(V')}`),
      paragraph([
        "すなわち、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " に対して ",
        math(String.raw`T_{(V)}(x) = T_{(V')}(x)`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`T_{(V)}`),
        " と ",
        math(String.raw`T_{(V')}`),
        " は単位的環準同型かつ線型である。",
      ]),
      paragraph([
        ref("def_T_V"),
        " より、任意の ",
        math(String.raw`X \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " について",
      ]),
      displayMath(
        String.raw`T_{(V)}(X)
= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(X)\right)\right)`,
      ),
      paragraph([
        "である。すなわち ",
        math(
          String.raw`T_{(V)} = T_{(V_1^{(\pm)})^{1/2}} \circ T_{V_2} \circ T_{(V_1^{(\pm)})^{1/2}}`,
        ),
        " である。各因子 ",
        math(String.raw`T_{(V_1^{(\pm)})^{1/2}},\ T_{V_2}`),
        " は ",
        math(String.raw`T_g`),
        "（",
        ref("def_T_g"),
        "）の形であり、",
        ref("def_T_V"),
        " で ",
        math(String.raw`T_g`),
        " が用いられている時点で ",
        math(String.raw`(V_1^{(\pm)})^{1/2},\ V_2`),
        " は可逆である。",
      ]),
      displayMath(String.raw`V := (V_1^{(\pm)})^{1/2}\, V_2\, (V_1^{(\pm)})^{1/2}`),
      paragraph([
        "とおく。可逆行列の積は可逆だから ",
        math(String.raw`V`),
        " は可逆である。",
        ref("conjugation_is_ring_homomorphism"),
        " の合成則を 2 回適用すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}
&= T_{(V_1^{(\pm)})^{1/2}} \circ T_{V_2} \circ T_{(V_1^{(\pm)})^{1/2}}
   \quad (\because \text{def\_T\_V}) \\
&= T_{(V_1^{(\pm)})^{1/2} V_2} \circ T_{(V_1^{(\pm)})^{1/2}}
   \quad (\because \text{conjugation\_is\_ring\_homomorphism}) \\
&= T_{(V_1^{(\pm)})^{1/2} V_2 (V_1^{(\pm)})^{1/2}}
   \quad (\because \text{conjugation\_is\_ring\_homomorphism}) \\
&= T_V
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。よって ",
        math(String.raw`T_{(V)} = T_V`),
        " であり、",
        math(String.raw`V`),
        " は可逆だから ",
        ref("conjugation_is_ring_homomorphism"),
        " より ",
        math(String.raw`T_{(V)}`),
        " は乗法的かつ単位的（",
        math(String.raw`T_{(V)}(I) = I`),
        "）であり、",
        ref("mat_conj"),
        " より線型である。",
      ]),
      paragraph([
        math(String.raw`T_{(V')}`),
        " は ",
        math(String.raw`T_g`),
        "（",
        ref("def_T_g"),
        "）の ",
        math(String.raw`g = V'`),
        " の場合であり、",
        ref("def_Vprime"),
        " より ",
        math(String.raw`V'`),
        " は可逆である。したがって ",
        ref("conjugation_is_ring_homomorphism"),
        " より ",
        math(String.raw`T_{(V')}`),
        " は乗法的かつ単位的であり、",
        ref("mat_conj"),
        " より線型である。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`T_{(V)}`),
        " と ",
        math(String.raw`T_{(V')}`),
        " は各 ",
        math(String.raw`Z_m, Y_m`),
        " 上で一致する。",
      ]),
      paragraph([
        "各 ",
        math(String.raw`m \in \{1,\dots,M\}`),
        " について、",
        ref("recover_Z_Y_from_hatZ_hatY"),
        " より",
      ]),
      displayMath(
        String.raw`Z_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)}\exp\!\left(i\,m\frac{2\pi\mu}{M}\right),
\quad
Y_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`T_{(V)}, T_{(V')}`),
        " は線型（Step 1）であり、",
        ref("T_V_eq_T_Vprime_on_hatZ_hatY"),
        " より各 ",
        math(String.raw`\mu \in \mathcal{M}`),
        " で ",
        math(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)}) = T_{(V')}(\hat{Z}_\mu^{(-)})`),
        " かつ ",
        math(String.raw`T_{(V)}(\hat{Y}_\mu) = T_{(V')}(\hat{Y}_\mu)`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(Z_m)
&= T_{(V)}\!\left(\frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)}\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)\right)
   \quad (\because \text{recover\_Z\_Y\_from\_hatZ\_hatY}) \\
&= \frac{1}{M}\sum_{\mu=1}^M \exp\!\left(i\,m\frac{2\pi\mu}{M}\right) T_{(V)}(\hat{Z}_\mu^{(-)})
   \quad (\because T_{(V)}\text{ の線型性}) \\
&= \frac{1}{M}\sum_{\mu=1}^M \exp\!\left(i\,m\frac{2\pi\mu}{M}\right) T_{(V')}(\hat{Z}_\mu^{(-)})
   \quad (\because \text{T\_V\_eq\_T\_Vprime\_on\_hatZ\_hatY}) \\
&= T_{(V')}\!\left(\frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)}\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)\right)
   \quad (\because T_{(V')}\text{ の線型性}) \\
&= T_{(V')}(Z_m)
   \quad (\because \text{recover\_Z\_Y\_from\_hatZ\_hatY})
\end{aligned}`,
      ),
      paragraph(["が成り立つ。同様に、"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(Y_m)
&= T_{(V)}\!\left(\frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)\right)
   \quad (\because \text{recover\_Z\_Y\_from\_hatZ\_hatY}) \\
&= \frac{1}{M}\sum_{\mu=1}^M \exp\!\left(i\,m\frac{2\pi\mu}{M}\right) T_{(V)}(\hat{Y}_\mu)
   \quad (\because T_{(V)}\text{ の線型性}) \\
&= \frac{1}{M}\sum_{\mu=1}^M \exp\!\left(i\,m\frac{2\pi\mu}{M}\right) T_{(V')}(\hat{Y}_\mu)
   \quad (\because \text{T\_V\_eq\_T\_Vprime\_on\_hatZ\_hatY}) \\
&= T_{(V')}\!\left(\frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)\right)
   \quad (\because T_{(V')}\text{ の線型性}) \\
&= T_{(V')}(Y_m)
   \quad (\because \text{recover\_Z\_Y\_from\_hatZ\_hatY})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。よってすべての ",
        math(String.raw`m \in \{1,\dots,M\}`),
        " について",
      ]),
      displayMath(
        String.raw`T_{(V)}(Z_m) = T_{(V')}(Z_m), \quad T_{(V)}(Y_m) = T_{(V')}(Y_m)`,
      ),
      paragraph(["である。"]),
      paragraph(["Step 3: 一致する元の集合は、和・スカラー倍・積で閉じ、単位元を含む。"]),
      paragraph(["集合"]),
      displayMath(
        String.raw`\mathcal{E} := \left\{\, x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M} \;:\; T_{(V)}(x) = T_{(V')}(x) \,\right\}`,
      ),
      paragraph([
        "を考える。",
        math(String.raw`\mathcal{E}`),
        " が ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の部分集合として、和・スカラー倍・積について閉じ、単位元を含むことを示す。",
      ]),
      paragraph([
        "（加法・スカラー倍について閉じる）",
        math(String.raw`x, y \in \mathcal{E}`),
        " と ",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        " について、",
        math(String.raw`T_{(V)}, T_{(V')}`),
        " は線型（Step 1）であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(\alpha x + \beta y)
&= \alpha T_{(V)}(x) + \beta T_{(V)}(y)
   \quad (\because T_{(V)}\text{ の線型性}) \\
&= \alpha T_{(V')}(x) + \beta T_{(V')}(y)
   \quad (\because x, y \in \mathcal{E}) \\
&= T_{(V')}(\alpha x + \beta y)
   \quad (\because T_{(V')}\text{ の線型性})
\end{aligned}`,
      ),
      paragraph([
        "ゆえ ",
        math(String.raw`\alpha x + \beta y \in \mathcal{E}`),
        " である。",
      ]),
      paragraph([
        "（積について閉じる）",
        math(String.raw`x, y \in \mathcal{E}`),
        " について、",
        math(String.raw`T_{(V)}, T_{(V')}`),
        " は乗法的（Step 1）であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(x y)
&= T_{(V)}(x)\, T_{(V)}(y)
   \quad (\because T_{(V)}\text{ の乗法性、conjugation\_is\_ring\_homomorphism}) \\
&= T_{(V')}(x)\, T_{(V')}(y)
   \quad (\because x, y \in \mathcal{E}) \\
&= T_{(V')}(x y)
   \quad (\because T_{(V')}\text{ の乗法性、conjugation\_is\_ring\_homomorphism})
\end{aligned}`,
      ),
      paragraph(["ゆえ ", math(String.raw`x y \in \mathcal{E}`), " である。"]),
      paragraph([
        "（単位元を含む）",
        math(String.raw`T_{(V)}(I) = I = T_{(V')}(I)`),
        "（Step 1 の単位性）より ",
        math(String.raw`I \in \mathcal{E}`),
        " である。",
      ]),
      paragraph([
        "以上より ",
        math(String.raw`\mathcal{E}`),
        " は単位元を含み、和・スカラー倍・積について閉じる ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の部分集合である。",
      ]),
      paragraph(["Step 4: 結論。"]),
      paragraph([
        "Step 2 より ",
        math(String.raw`Z_1,\dots,Z_M, Y_1,\dots,Y_M \in \mathcal{E}`),
        " である。",
        math(String.raw`\mathcal{E}`),
        " は ",
        math(String.raw`S := \{Z_1,\dots,Z_M, Y_1,\dots,Y_M\}`),
        " を含み、和・スカラー倍・積について閉じ、単位元を含む（Step 3）。したがって、",
        math(String.raw`S`),
        " を含み和・スカラー倍・積について閉じ単位元を含む最小の部分集合 ",
        math(String.raw`\mathcal{A}`),
        "（",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`\mathcal{A}`),
        "）について ",
        math(String.raw`\mathcal{A} \subseteq \mathcal{E}`),
        " である。",
        ref("Z_Y_generate_algebra"),
        " より ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}
= \mathcal{A}
\subseteq \mathcal{E}
\subseteq \mathrm{Mat}(2,\mathbb{C})^{\otimes M}
\quad (\because \text{Z\_Y\_generate\_algebra})`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\mathcal{E} = \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " である。これは、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " について ",
        math(String.raw`T_{(V)}(x) = T_{(V')}(x)`),
        "、すなわち",
      ]),
      displayMath(String.raw`T_{(V)} = T_{(V')}`),
      paragraph(["が成り立つことを意味する。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "移行漏れだった証明を _old/typst の原本（038_claim_T_V_eq_T_Vprime.typ）から復旧。Step 1〜4 を圧縮せず全ステップ再現した。",
        "原文の statement は「任意の x に対して T_((V))(x) = T_((V'))(x)」であり、構造化側にあった「V x V^{-1} = V' x V'^{-1}」という別表記を原文どおりに戻した（V x V^{-1} = T_V(x) であることは Step 1 の T_((V)) = T_V を経由して初めて言えるため、statement 段階では原文の形が正しい）。",
        "原文の T_((V_2)) は、構造化側の def_T_V が用いる T_{V_2} の表記に統一した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_040_claim_V_eq_cVprime",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/039_claim_V_eq_Vprime.typ",
    sourceOrdinal: 40,
    title: { tex: String.raw`V = c V' \text{（定数倍を除いて一致）}` },
    labels: ["V_eq_Vprime"],
    statement: [
      paragraph(["ある ", math(String.raw`c \in \mathbb{C}^\times`), " が存在して、"]),
      displayMath(String.raw`V = c \cdot V'`),
      paragraph([
        "ここで ",
        math(String.raw`V := (V_1^{(\pm)})^{1/2}\, V_2\, (V_1^{(\pm)})^{1/2}`),
        "（",
        ref("def_T_V"),
        " で導入され、",
        ref("T_V_eq_T_Vprime"),
        " の Step 1 で ",
        math(String.raw`T_{(V)} = T_V`),
        " が示された行列）とする。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`W := V'^{-1} V`),
        " は可逆である。",
      ]),
      paragraph([
        ref("T_V_eq_T_Vprime"),
        " の Step 1 より、",
        math(String.raw`V := (V_1^{(\pm)})^{1/2}\, V_2\, (V_1^{(\pm)})^{1/2}`),
        " は可逆である。また ",
        ref("def_Vprime"),
        " より ",
        math(String.raw`V'`),
        " は可逆であり、可逆行列の逆行列 ",
        math(String.raw`V'^{-1}`),
        " も可逆である。",
      ]),
      displayMath(String.raw`W := V'^{-1} V`),
      paragraph([
        "とおく。可逆行列の積は可逆であるから ",
        math(String.raw`W`),
        " は可逆である。特に ",
        math(String.raw`W`),
        " の逆行列 ",
        math(String.raw`W^{-1}`),
        " が存在する。",
      ]),
      paragraph(["左から ", math(String.raw`V'`), " を掛けると"]),
      displayMath(
        String.raw`\begin{aligned}
V' W
&= V'(V'^{-1} V)
   \quad (\because W = V'^{-1} V) \\
&= (V' V'^{-1}) V
   \quad (\because \text{行列の積の結合法則}) \\
&= I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}\, V
   \quad (\because V' V'^{-1} = I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}) \\
&= V
   \quad (\because \text{単位元の性質})
\end{aligned}`,
      ),
      paragraph(["すなわち"]),
      displayMath(String.raw`V = V' W`),
      paragraph(["を得る。"]),
      paragraph([
        "Step 2: ",
        math(String.raw`W`),
        " はすべての ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " と可換である。",
      ]),
      paragraph([
        ref("T_V_eq_T_Vprime"),
        " より ",
        math(String.raw`T_{(V)} = T_{(V')}`),
        " であり、",
        ref("T_V_eq_T_Vprime"),
        " の Step 1 で示された ",
        math(String.raw`T_{(V)} = T_V`),
        " と合わせると、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_V(x)
&= T_{(V)}(x)
   \quad (\because \text{T\_V\_eq\_T\_Vprime の Step 1: } T_{(V)} = T_V) \\
&= T_{(V')}(x)
   \quad (\because \text{T\_V\_eq\_T\_Vprime}: T_{(V)} = T_{(V')})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。両辺を ",
        ref("mat_conj"),
        " の共役写像の定義で書き下すと、任意の ",
        math(String.raw`x`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V x V^{-1}
&= T_V(x)
   \quad (\because \text{mat\_conj}) \\
&= T_{(V')}(x)
   \quad (\because \text{上の等式}) \\
&= V' x V'^{-1}
   \quad (\because \text{mat\_conj})
\end{aligned}`,
      ),
      paragraph(["すなわち"]),
      displayMath(String.raw`V x V^{-1} = V' x V'^{-1}`),
      paragraph(["である。"]),
      paragraph([
        "ここで Step 1 の ",
        math(String.raw`V = V' W`),
        " を代入する。まず逆行列について、",
        ref("conjugation_is_ring_homomorphism"),
        " の Step 3 で確認された積の逆元の公式 ",
        math(String.raw`(AB)^{-1} = B^{-1}A^{-1}`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{-1}
&= (V' W)^{-1}
   \quad (\because V = V' W) \\
&= W^{-1} V'^{-1}
   \quad (\because (AB)^{-1} = B^{-1}A^{-1})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。これらを上の等式 ",
        math(String.raw`V x V^{-1} = V' x V'^{-1}`),
        " の左辺に代入すると、任意の ",
        math(String.raw`x`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V'\left(W x W^{-1}\right)V'^{-1}
&= (V' W)\, x\, (W^{-1} V'^{-1})
   \quad (\because \text{行列の積の結合法則}) \\
&= V x V^{-1}
   \quad (\because V = V' W,\ V^{-1} = W^{-1}V'^{-1}) \\
&= V' x V'^{-1}
   \quad (\because V x V^{-1} = V' x V'^{-1})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。両辺に左から ",
        math(String.raw`V'^{-1}`),
        "、右から ",
        math(String.raw`V'`),
        " を掛けると、任意の ",
        math(String.raw`x`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W x W^{-1}
&= V'^{-1}\left(V'\left(W x W^{-1}\right)V'^{-1}\right)V'
   \quad (\because V'^{-1}V' = V'V'^{-1} = I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}) \\
&= V'^{-1}\left(V' x V'^{-1}\right)V'
   \quad (\because V'(W x W^{-1})V'^{-1} = V' x V'^{-1}) \\
&= x
   \quad (\because V'^{-1}V' = V'V'^{-1} = I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}})
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`W x W^{-1} = x`),
        " である。両辺に右から ",
        math(String.raw`W`),
        " を掛けると、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W x
&= (W x W^{-1}) W
   \quad (\because W^{-1}W = I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}) \\
&= x W
   \quad (\because W x W^{-1} = x)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。したがって ",
        math(String.raw`W`),
        " はすべての ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " と可換である。",
      ]),
      paragraph(["Step 3: ", math(String.raw`W`), " はスカラーである。"]),
      paragraph([
        "Step 2 より ",
        math(String.raw`W`),
        " はすべての ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " と可換であるから、",
        ref("centralizer_is_scalar"),
        " より、ある ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在して",
      ]),
      displayMath(
        String.raw`W = c \cdot I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}
\quad (\because \text{centralizer\_is\_scalar})`,
      ),
      paragraph(["が成り立つ。"]),
      paragraph(["Step 4: ", math(String.raw`c \neq 0`), " であること。"]),
      paragraph([
        "Step 1 より ",
        math(String.raw`W`),
        " は可逆である。仮に ",
        math(String.raw`c = 0`),
        " ならば ",
        math(String.raw`W = 0\cdot I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}} = O`),
        "（零行列）となるが、零行列は可逆でない（任意の ",
        math(String.raw`A`),
        " について ",
        math(String.raw`O A = O \neq I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}`),
        "）から、",
        math(String.raw`W`),
        " が可逆であることに矛盾する。よって ",
        math(String.raw`c \neq 0`),
        "、すなわち ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " である。",
      ]),
      paragraph(["Step 5: 結論。"]),
      paragraph([
        "Step 1 の ",
        math(String.raw`V = V' W`),
        " に Step 3 の ",
        math(String.raw`W = c \cdot I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}`),
        " を代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V
&= V' W
   \quad (\because \text{Step 1}) \\
&= V'\left(c \cdot I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}\right)
   \quad (\because \text{Step 3}) \\
&= c \cdot \left(V' I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}\right)
   \quad (\because \text{スカラー倍と行列積の可換性}) \\
&= c \cdot V'
   \quad (\because \text{単位元の性質})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。Step 4 より ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " であるから、求める ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " が存在して ",
        math(String.raw`V = c \cdot V'`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "移行漏れだった証明を _old/typst の原本（039_claim_V_eq_Vprime.typ）から復旧。Step 1〜5 を圧縮せず全ステップ再現した。",
        "構造化側にあった旧 TODO『T の単射性（クリフォード群の性質）を用いる』は原本の証明方針と異なる（原本は centralizer_is_scalar を用い、クリフォード群には依存しない）。原本の方針に従って復旧し、その旨は原文 note として notes/008_TV1_hatZ_hatY.mjs に収めた。",
        "原文 statement にあった V の定義（def_T_V で導入し T_V_eq_T_Vprime の Step 1 で T_((V)) = T_V を示した行列）は、主張の意味の確定に必要なため statement に復旧した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_041_claim_gamma2_periodicity",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/040_claim_gamma2_thetaMの周期性.typ",
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
  {
    id: "TV1_hatZ_hatY_044_claim_critical_condition",
    kind: "claim",
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/043_claim_臨界条件_c1_eq_s1c2.typ",
    sourceOrdinal: 44,
    title: { tex: String.raw`c_1 = s_1 c_2 \text{ は臨界条件 } s_1 s_2 = 1 \text{ と同値}` },
    labels: ["critical_condition_c1_eq_s1_c2"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号 ",
        math(String.raw`c_1 = \cosh 2K_1`),
        "、",
        math(String.raw`s_1 = \sinh 2K_1`),
        "、",
        math(String.raw`c_2 = \cosh 2K_2`),
        "、",
        math(String.raw`s_2 = \sinh 2K_2`),
        " について、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とする。このとき",
      ]),
      displayMath(String.raw`c_1 = s_1 c_2 \iff s_1 s_2 = 1`),
      paragraph([
        "すなわち ",
        math(String.raw`\cosh 2K_1 = \sinh 2K_1 \cosh 2K_2`),
        " であることと、Ising 模型の臨界条件 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " であることは同値である。",
      ]),
      paragraph([
        "この同値性から、",
        math(String.raw`\gamma_2`),
        " の零点と Ising 模型の臨界点が対応する。実際 ",
        ref("gamma_2_theta_is_0"),
        " より、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " となるのは ",
        math(String.raw`\mu = \pm M`),
        "（すなわち ",
        math(String.raw`\theta_\mu = \pm 2\pi`),
        "、",
        math(String.raw`\cos\theta_\mu = 1`),
        "）かつ ",
        math(String.raw`c_2 s_1 = c_1`),
        " のときに限るから、",
        math(String.raw`\gamma_2(\theta_M) = 0`),
        "（フェルミオン ",
        math(String.raw`\psi_M`),
        " が ",
        ref("def_fermi"),
        " で未定義になる特異点）であることと Ising 模型の臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " であることは同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0: 所属集合と正値性。",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`2K_1, 2K_2 \in \mathbb{R}_{>0}`),
        " であり、",
        ref("cosh_sinh_basic_properties"),
        " (3) を ",
        math(String.raw`x = 2K_1`),
        "、",
        math(String.raw`x = 2K_2`),
        " に適用して",
      ]),
      displayMath(String.raw`c_1 > s_1 > 0, \qquad c_2 > s_2 > 0`),
      paragraph([
        "特に ",
        math(String.raw`c_1, s_1, c_2, s_2 \in \mathbb{R}_{>0}`),
        "。また同 (2) より",
      ]),
      displayMath(String.raw`c_1^2 = 1 + s_1^2, \qquad c_2^2 = 1 + s_2^2`),
      paragraph([
        "Step 1: ",
        math(String.raw`(\Rightarrow)`),
        " の証明。",
        math(String.raw`c_1 = s_1 c_2`),
        " と仮定する。両辺は正の実数（",
        math(String.raw`s_1 c_2 > 0`),
        "）であり、両辺を 2 乗して Step 0 の 2 式を代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_1^2 &= s_1^2 c_2^2 \\
1 + s_1^2 &= s_1^2 (1 + s_2^2) \\
1 + s_1^2 &= s_1^2 + s_1^2 s_2^2 \\
1 &= s_1^2 s_2^2 = (s_1 s_2)^2
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`s_1 s_2 > 0`),
        " かつ ",
        math(String.raw`1 > 0`),
        " であり ",
        math(String.raw`(s_1 s_2)^2 = 1^2`),
        " であるから、",
        ref("cosh_sinh_basic_properties"),
        " (4)（正の実数について ",
        math(String.raw`a^2 = b^2 \iff a = b`),
        "）を ",
        math(String.raw`a = s_1 s_2`),
        "、",
        math(String.raw`b = 1`),
        " に適用して ",
        math(String.raw`s_1 s_2 = 1`),
        "。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`(\Leftarrow)`),
        " の証明。",
        math(String.raw`s_1 s_2 = 1`),
        " と仮定する。Step 0 の 2 式より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(s_1 c_2)^2
&= s_1^2 c_2^2 \\
&= s_1^2 (1 + s_2^2) \\
&= s_1^2 + s_1^2 s_2^2 \\
&= s_1^2 + (s_1 s_2)^2 \\
&= s_1^2 + 1 \\
&= c_1^2
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`s_1 c_2 > 0`),
        " かつ ",
        math(String.raw`c_1 > 0`),
        " であるから、",
        ref("cosh_sinh_basic_properties"),
        " (4) を ",
        math(String.raw`a = s_1 c_2`),
        "、",
        math(String.raw`b = c_1`),
        " に適用して ",
        math(String.raw`s_1 c_2 = c_1`),
        "。以上で ",
        math(String.raw`c_1 = s_1 c_2 \iff s_1 s_2 = 1`),
        " が示された。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\gamma_2`),
        " の零点と臨界点の対応（statement 後半）の導出。",
        ref("gamma_2_theta_is_0"),
        " より、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について",
      ]),
      displayMath(
        String.raw`\gamma_2(\theta_\mu) = 0
\iff \begin{cases} \mu = \pm M \\ c_1 = s_1 c_2 \end{cases}`,
      ),
      paragraph([
        "である。右辺の第 2 条件 ",
        math(String.raw`c_1 = s_1 c_2`),
        " は ",
        math(String.raw`\mu`),
        " に依存しない。特に ",
        math(String.raw`\mu = M \in \mathcal{M}`),
        " をとれば第 1 条件は自動的に満たされるから",
      ]),
      displayMath(
        String.raw`\gamma_2(\theta_M) = 0 \iff c_1 = s_1 c_2 \iff s_1 s_2 = 1
\iff \sinh 2K_1 \sinh 2K_2 = 1`,
      ),
      paragraph([
        "（2 番目の同値が Step 1, Step 2 で示したもの、3 番目は ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`s_1 = \sinh 2K_1`),
        "、",
        math(String.raw`s_2 = \sinh 2K_2`),
        " による。）",
        ref("def_fermi"),
        " において ",
        math(String.raw`\psi_M, \psi_M^\dagger`),
        " は正規化因子 ",
        math(String.raw`1/(2\sqrt{M}\,\gamma_2(-\theta_M))`),
        " を含むため ",
        math(String.raw`\gamma_2(\theta_M) = 0`),
        "（",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(-\theta_M) = 0`),
        " と同値）のとき定義されない。よって「",
        math(String.raw`\psi_M`),
        " が定義されない特異点であること」と「Ising 模型の臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " であること」は同値である。",
      ]),
      paragraph([
        "なお ",
        math(String.raw`c_1 \neq s_1 c_2`),
        " のとき（すなわち ",
        math(String.raw`s_1 s_2 \neq 1`),
        " のとき）は、上の同値より、すべての ",
        math(String.raw`\mu \in \mathcal{M}`),
        " について ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（043_claim_臨界条件_c1_eq_s1c2.typ）の proof は TODO（未完成）であり、証明は本リポジトリで新規に構成した。",
        "証明は cosh^2 - sinh^2 = 1 と正値性のみを使う初等的なもので、平方根を経由せずに" +
          "「正の実数について a^2 = b^2 ⟺ a = b」（labels: cosh_sinh_basic_properties (4)）で符号を確定させている。",
        "γ2 の零点と Ising 臨界点の対応（この claim の帰結）は数学的内容なので note ではなく statement に置いた。" +
          "その導出（gamma_2_theta_is_0 との接続）は proof の Step 3 に書いた。",
      ],
    },
  },
]);
