import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

// 章「T_{V_1}(hat Z) と hat Z, hat Y の関係」の後半（文書順）。
// 収録範囲は parts/008 の 020〜031, 034, 035, 033, 032, 037, 044, 041, 042, 038, 039,
// 040, 043（文書順はソースのファイル名連番と一致しない）。並びが文書順の正準表現。
export default defineBlocks([
  {
    id: "TV1_hatZ_hatY_021_claim_arg_gamma1_gamma2",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/020_claim_gamma1_gamma2の偏角.typ",
      ordinal: 21,
    },
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
\gamma_1(\theta_\mu)>0
&\iff c_1c_2^*-s_1s_2^*\cos\theta_\mu>0
&&(\because\ \gamma_1\ \text{の定義})\\
&\iff c_1c_2^*>s_1s_2^*\cos\theta_\mu
&&(\because\ \text{実数の不等式の両辺へ同じ数を足した})\\
&\iff \cos\theta_\mu<\frac{c_1c_2^*}{s_1s_2^*}
&&(\because\ s_1s_2^*>0\ \text{で両辺を割った})\\[3pt]
\gamma_1(\theta_\mu)=0
&\iff c_1c_2^*-s_1s_2^*\cos\theta_\mu=0
&&(\because\ \gamma_1\ \text{の定義})\\
&\iff c_1c_2^*=s_1s_2^*\cos\theta_\mu
&&(\because\ \text{実数の等式の両辺へ同じ数を足した})\\
&\iff \cos\theta_\mu=\frac{c_1c_2^*}{s_1s_2^*}
&&(\because\ s_1s_2^*>0\ \text{で両辺を割った})\\[3pt]
\gamma_1(\theta_\mu)<0
&\iff c_1c_2^*-s_1s_2^*\cos\theta_\mu<0
&&(\because\ \gamma_1\ \text{の定義})\\
&\iff c_1c_2^*<s_1s_2^*\cos\theta_\mu
&&(\because\ \text{実数の不等式の両辺へ同じ数を足した})\\
&\iff \cos\theta_\mu>\frac{c_1c_2^*}{s_1s_2^*}
&&(\because\ s_1s_2^*>0\ \text{で両辺を割った})
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
        String.raw`\begin{aligned}
t>0:\qquad
\phi_{\mathrm{polar}}(t,0)
&=[(\sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})},\ \arctan(0/t))]_{\sim}
&& (\because\ \text{極座標表示の定義の}\ x>0\ \text{の場合})\\
&=[(t,\ 0)]_{\sim}
&& (\because\ \sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})}=t,\ \arctan 0=0)\\[3pt]
t<0:\qquad
\phi_{\mathrm{polar}}(t,0)
&=[(\sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})},\ \arctan(0/t)+\pi)]_{\sim}
&& (\because\ \text{極座標表示の定義の}\ x<0,\ y\geq0\ \text{の場合})\\
&=[(-t,\ \pi)]_{\sim}
&& (\because\ \sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})}=-t,\ \arctan 0=0)\\[3pt]
t=0:\qquad
\phi_{\mathrm{polar}}(t,0)
&=[(0,\ 0)]_{\sim}
&& (\because\ \text{極座標表示の定義の}\ (x,y)=(0,0)\ \text{の場合})
\end{aligned}`,
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
        String.raw`\begin{aligned}
t>0:\qquad
\arg^{[0,2\pi)}(t)
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(t,0))\right)
&&(\because\ \arg^{[0,2\pi)}\ \text{の定義})\\
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(t,\ 0)]_{\sim})\right)
&&(\because\ \text{上の}\ t>0\ \text{の場合の}\ \phi_{\mathrm{polar}}(t,0)=[(t,\ 0)]_{\sim})\\
&=s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}})
&&(\because\ \mathrm{pr}_2\ \text{の定義の}\ r=t>0\ \text{の場合})\\
&=0
&&(\because\ 0\in[0,2\pi)\ \text{なので代表を返す写像}\ s_{[0,2\pi)}\ \text{はそのまま}\ 0\ \text{を返す})\\[3pt]
t<0:\qquad
\arg^{[0,2\pi)}(t)
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(t,0))\right)
&&(\because\ \arg^{[0,2\pi)}\ \text{の定義})\\
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(-t,\ \pi)]_{\sim})\right)
&&(\because\ \text{上の}\ t<0\ \text{の場合の}\ \phi_{\mathrm{polar}}(t,0)=[(-t,\ \pi)]_{\sim})\\
&=s_{[0,2\pi)}([\pi]_{\sim_{\mathrm{angle}}})
&&(\because\ \mathrm{pr}_2\ \text{の定義の}\ r=-t>0\ \text{の場合})\\
&=\pi
&&(\because\ \pi\in[0,2\pi)\ \text{なので}\ s_{[0,2\pi)}\ \text{はそのまま}\ \pi\ \text{を返す})\\[3pt]
t=0:\qquad
\arg^{[0,2\pi)}(t)
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(t,0))\right)
&&(\because\ \arg^{[0,2\pi)}\ \text{の定義})\\
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(0,\ 0)]_{\sim})\right)
&&(\because\ \text{上の}\ t=0\ \text{の場合の}\ \phi_{\mathrm{polar}}(t,0)=[(0,\ 0)]_{\sim})\\
&=s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}})
&&(\because\ \mathrm{pr}_2\ \text{の定義は}\ r=0\ \text{のとき}\ [0]_{\sim_{\mathrm{angle}}}\ \text{を返す})\\
&=0
&&(\because\ 0\in[0,2\pi)\ \text{なので}\ s_{[0,2\pi)}\ \text{はそのまま}\ 0\ \text{を返す})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\arg^{[0,2\pi)}`),
        " と ",
        math(String.raw`s_{[0,2\pi)}`),
        " は ",
        ref("def_abs_arg"),
        "、",
        math(String.raw`\mathrm{pr}_2`),
        " は ",
        ref("first_and_second_projections"),
        "。",
        math(String.raw`t = 0`),
        " の場合が示すとおり、本リポジトリの規約では ",
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
        String.raw`\begin{aligned}
c_1 c_2^*
&>s_1 c_2^*
&&(\because\ c_1>s_1\ \text{の両辺に正数}\ c_2^*\ \text{を掛けた})\\
s_1 c_2^*
&>s_1 s_2^*
&&(\because\ c_2^*>s_2^*\ \text{の両辺に正数}\ s_1\ \text{を掛けた})\\
s_1 s_2^*
&>0
&&(\because\ s_1>0\ \text{かつ}\ s_2^*>0)
\end{aligned}`,
      ),
      paragraph([
        "よって ",
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
        "2026-08-11 の式変形統一で、Step 5 の正値性の鎖を 1 行 1 不等号へ分け、後置の散文にあった根拠を各行末へ移した。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_022_claim_gamma2_theta_is_0",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/021_claim_gamma2_thetaが0になる条件.typ",
      ordinal: 22,
    },
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
        " とする。この前提から ",
        math(String.raw`c_1, s_1, c_2, s_2^* > 0`),
        "、特に ",
        math(String.raw`s_2^* \neq 0`),
        " が従う（証明の Step 0。",
        math(String.raw`s_2^* \neq 0`),
        " は以下の同値のすべてに不可欠である）。",
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
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " である。ここで ",
        math(String.raw`K_2^* > 0`),
        " を確認しておく：",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_2^* := -\tfrac{1}{2}\log(\tanh K_2)`),
        " において、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&<\tanh K_2
&& (\because\ K_2>0\ \text{における}\ \tanh\ \text{の正値性})\\
\tanh K_2
&<1
&& (\because\ K_2>0\ \text{における}\ \tanh\ \text{の上界})\\
\log(\tanh K_2)
&<0
&& (\because\ 0<\tanh K_2<1\ \text{における実対数の符号})\\
K_2^*=-\frac12\log(\tanh K_2)
&>0
&& (\because\ \text{負数に負数}\ -\tfrac12\ \text{を掛けた})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`K_1, K_2, K_2^* \in \mathbb{R}_{>0}`),
        " であり、",
        math(String.raw`x > 0`),
        " で ",
        math(String.raw`\cosh x > 0`),
        "、",
        math(String.raw`\sinh x > 0`),
        " であることから",
      ]),
      displayMath(
        String.raw`c_1 = \cosh 2K_1 > 0, \quad s_1 = \sinh 2K_1 > 0, \quad c_2 = \cosh 2K_2 > 0, \quad
s_2^* = \sinh 2K_2^* > 0`,
      ),
      paragraph([
        "特に ",
        math(String.raw`s_2^* \neq 0`),
        " である。この ",
        math(String.raw`s_2^* \neq 0`),
        " は Step 1（",
        math(String.raw`\gamma_2(\theta_\mu)`),
        " の第 1 因子が ",
        math(String.raw`0`),
        " でないこと）に不可欠であり、これが無いと第 1 の同値そのものが成り立たない（",
        math(String.raw`s_2^* = 0`),
        " ならすべての ",
        math(String.raw`\mu`),
        " について ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " になってしまう）。また ",
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
        " に属すること。準備として 3 つの因子の絶対値を確かめる。",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`e^{i\theta_\mu} = \cos\theta_\mu + i\sin\theta_\mu`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|e^{i\theta_\mu}\right|^2
&= (\cos\theta_\mu)^2 + (\sin\theta_\mu)^2
&& (\because\ \text{絶対値の基本性質 (2)})\\
&= 1
&& (\because\ \cos^2 t + \sin^2 t = 1)
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`|e^{i\theta_\mu}| = 1`),
        "（絶対値は非負なので平方が 1 なら値も 1）。同様に ",
        math(String.raw`|i| = 1`),
        " であり、",
        math(String.raw`s_2^* > 0`),
        " より ",
        math(String.raw`|s_2^*| = s_2^*`),
        "（",
        ref("abs_basic_properties"),
        " (6)）。この準備のもとで、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|i\,e^{i\theta_\mu} s_2^*\right|
&= |i|\,\left|e^{i\theta_\mu}\right|\,\left|s_2^*\right|
&& (\because\ \text{絶対値の乗法性。絶対値の基本性質 (4)})\\
&= 1\cdot\left|e^{i\theta_\mu}\right|\,\left|s_2^*\right|
&& (\because\ |i| = 1)\\
&= 1\cdot 1\cdot\left|s_2^*\right|
&& (\because\ \left|e^{i\theta_\mu}\right| = 1)\\
&= 1\cdot 1\cdot s_2^*
&& (\because\ |s_2^*| = s_2^*)\\
&= s_2^*
&& (\because\ 1\ \text{との積})\\
&> 0
&& (\because\ \text{Step 0 の}\ s_2^* > 0)
\end{aligned}`,
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
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu)=0_{\mathbb{C}}
&\iff \bigl(i\,e^{i\theta_\mu}s_2^*\bigr)w_\mu=0_{\mathbb{C}}
&& (\because\ \gamma_2(\theta_\mu)=\bigl(i\,e^{i\theta_\mu}s_2^*\bigr)w_\mu)\\
&\iff w_\mu=0_{\mathbb{C}}
&& (\because\ \mathbb{C}\ \text{は整域であり、Step 1 より第 1 因子は零元でない})
\end{aligned}`),
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
        String.raw`w_\mu
= \bigl(c_1\cos\theta_\mu-s_1c_2,\;-\sin\theta_\mu\bigr)\in\mathbb{R}^2=\mathbb{C}
\quad (\because\ \text{複素数の成分表示の定義})`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\mathbb{C}`),
        " の零元は ",
        math(String.raw`(0,0)`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
w_\mu=0_{\mathbb{C}}
&\iff \bigl(c_1\cos\theta_\mu-s_1c_2,\;-\sin\theta_\mu\bigr)=(0,0)
&& (\because\ w_\mu\ \text{の成分表示と}\ 0_{\mathbb{C}}=(0,0))\\
&\iff \begin{cases}
c_1\cos\theta_\mu-s_1c_2=0\\
-\sin\theta_\mu=0
\end{cases}
&& (\because\ \text{順序対の相等は各成分の相等と同値})\\
&\iff \begin{cases}
\sin\theta_\mu=0\\
c_2s_1-c_1\cos\theta_\mu=0
\end{cases}
&& (\because\ \text{各式を}\ -1\ \text{倍し、実数の積を交換した})
\end{aligned}`,
      ),
      paragraph(["これで第 1 の同値を得た。"]),
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
        "Step 3': 第 1 式だけを ",
        math(String.raw`\mu`),
        " の言葉に翻訳しておく（第 3 の同値を正しく述べるために必要）。",
        math(String.raw`\theta_\mu = 2\pi\mu/M`),
        " であるから、",
        math(String.raw`k \in \mathbb{Z}`),
        " を用いて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\theta_\mu \in \pi\mathbb{Z}
&\iff \exists k \in \mathbb{Z}:\ \frac{2\pi\mu}{M} = k\pi
&& (\because\ \theta_\mu = 2\pi\mu/M\ \text{を代入し、}\pi\mathbb{Z}\ \text{の元であることを}\ k\ \text{の存在で書いた})\\
&\iff \exists k \in \mathbb{Z}:\ 2\mu = kM
&& (\because\ \text{両辺に}\ M/\pi\ \text{を掛けた。}\pi\ne0\ \text{かつ}\ M\ge1\ \text{なので同値})\\
&\iff M \mid 2\mu
&& (\because\ \text{整除}\ M\mid2\mu\ \text{の定義そのもの})
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`M \mid 2\mu`),
        " を ",
        math(String.raw`M`),
        " の偶奇で言い換える。",
        math(String.raw`M`),
        " が奇数の場合。",
      ]),
      displayMath(
        String.raw`M \mid 2\mu \iff M \mid \mu
\qquad (\because\ \gcd(M,2)=1\ \text{なので}\ M\ \text{が}\ 2\mu\ \text{を割れば}\ \mu\ \text{を割る。逆は倍を取るだけ})`,
      ),
      paragraph([
        math(String.raw`M`),
        " が偶数の場合。",
        math(String.raw`M = 2M'`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
M \mid 2\mu
&\iff 2M' \mid 2\mu
&& (\because\ M=2M'\ \text{を代入した})\\
&\iff M' \mid \mu
&& (\because\ \text{両辺の商の等式を}\ 2\ \text{で約した。}2\ne0\ \text{なので同値})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`M' = M/2`),
        " だから、これは ",
        math(String.raw`\mu \equiv 0 \pmod{M}`),
        " または ",
        math(String.raw`\mu \equiv M/2 \pmod{M}`),
        " と同値である。まとめると",
      ]),
      displayMath(
        String.raw`\sin\theta_\mu = 0
\iff \begin{cases}
\mu \equiv 0 \pmod{M} & (M \text{ が奇数}) \\
\mu \equiv 0 \pmod{M} \ \text{または}\ \mu \equiv M/2 \pmod{M} & (M \text{ が偶数})
\end{cases}`,
      ),
      paragraph([
        "特に、",
        math(String.raw`M`),
        " が偶数のときは ",
        math(String.raw`\mu = \pm M/2 \in \mathcal{M}`),
        " も第 1 式を満たすので、",
        math(String.raw`\sin\theta_\mu = 0 \iff \mu = \pm M`),
        " は偽である。第 3 の同値が成り立つのは、あくまで第 2 式との連立の下だけである。",
      ]),
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
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1
&\leq |\mu|
&& (\because\ \mu\in\mathcal{M})\\
|\mu|
&\leq M
&& (\because\ \mu\in\mathcal{M})\\
2
&\leq 2|\mu|
&& (\because\ 1\leq|\mu|\ \text{の両辺を正数}\ 2\ \text{倍した})\\
2|\mu|
&\leq 2M
&& (\because\ |\mu|\leq M\ \text{の両辺を正数}\ 2\ \text{倍した})\\
M
&\mid 2|\mu|
&& (\because\ M\mid2\mu\ \text{ならば}\ M\mid|2\mu|=2|\mu|)
\end{aligned}`,
      ),
      paragraph([
        "である。この範囲で ",
        math(String.raw`M`),
        " の倍数は ",
        math(String.raw`M`),
        " と ",
        math(String.raw`2M`),
        " のみであるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2|\mu|
&\in\{M,2M\}
&& (\because\ 2\leq2|\mu|\leq2M\ \text{かつ}\ M\mid2|\mu|)\\
|\mu|
&\in\{M/2,M\}
&& (\because\ \text{各候補を}\ 2\ \text{で割った})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`|\mu| = M/2`),
        "（このとき ",
        math(String.raw`M`),
        " は偶数）または ",
        math(String.raw`|\mu| = M`),
        " である。",
      ]),
      paragraph([
        math(String.raw`|\mu| = M/2`),
        " の場合は ",
        math(String.raw`\mu=\pm M/2`),
        " なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\theta_\mu
&=\frac{2\pi(\pm M/2)}{M}
&& (\because\ \theta_\mu=2\pi\mu/M\ \text{へ}\ \mu=\pm M/2\ \text{を代入した})\\
&=\pm\pi
&& (\because\ M\geq1\ \text{なので}\ M\ne0\ \text{として約した})\\
\cos\theta_\mu
&=\cos(\pm\pi)
&& (\because\ \theta_\mu=\pm\pi)\\
&=-1
&& (\because\ \cos(\pm\pi)=-1)\\
c_2s_1
&=c_1\cos\theta_\mu
&& (\because\ \text{第 2 式})\\
&=-c_1
&& (\because\ \cos\theta_\mu=-1)
\end{aligned}`,
      ),
      paragraph(["一方、Step 0 の正値性から"]),
      displayMath(
        String.raw`\begin{aligned}
0
&<c_2s_1
&& (\because\ c_2>0\ \text{かつ}\ s_1>0)\\
c_2s_1
&=-c_1
&& (\because\ \text{上の第 2 式の計算})\\
-c_1
&<0
&& (\because\ c_1>0)
\end{aligned}`,
      ),
      paragraph([
        "となり矛盾する。よってこの場合は起こらず、",
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
        " とすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\theta_\mu
&=\frac{2\pi(\pm M)}{M}
&& (\because\ \theta_\mu=2\pi\mu/M\ \text{へ}\ \mu=\pm M\ \text{を代入した})\\
&=\pm2\pi
&& (\because\ M\geq1\ \text{なので}\ M\ne0\ \text{として約した})\\
&\in\pi\mathbb{Z}
&& (\because\ \pm2\in\mathbb{Z})
\end{aligned}`,
      ),
      paragraph([
        "ゆえに第 1 式が成り立つ。第 2 式は連立条件の両側に同じ形で置かれているので、そのまま保たれる。",
      ]),
      paragraph([
        "Step 5: 第 4 の同値。",
        math(String.raw`\mu = \pm M`),
        " とする。第 2 式について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_2 s_1 = c_1\cos\theta_\mu
&\iff c_2 s_1 = c_1\cos(\pm 2\pi)
&& (\because\ \theta_\mu = 2\pi\mu/M\ \text{に}\ \mu=\pm M\ \text{を代入すると}\ \theta_\mu=\pm2\pi)\\
&\iff c_2 s_1 = c_1 \cdot 1
&& (\because\ \cos(\pm 2\pi)=1)\\
&\iff c_2 s_1 = c_1
&& (\because\ 1\ \text{は実数の積の単位元})\\
&\iff c_1 = s_1 c_2
&& (\because\ \text{相等の対称性と、実数の積の交換})
\end{aligned}`,
      ),
      paragraph(["以上で主張のすべての同値が示された。"]),
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
        "Lean 形式化での指摘を受けて 2 点を明示化した。(a) Step 0 で K_2 > 0 ⟹ 0 < tanh K_2 < 1 ⟹ K_2^* > 0 ⟹ s_2^* > 0 " +
          "を 1 段ずつ書き、s_2^* ≠ 0（Step 1 の第 1 因子が非零であることに不可欠。s_2^* = 0 なら γ_2 は恒等的に 0）を " +
        "statement 側にも明記した。(b) 第 1 式 sin θ_μ = 0 だけを μ の言葉に翻訳した中間段を Step 3' として独立させ、" +
          "sin θ_μ = 0 ⟺ M | 2μ ⟺（M が偶数なら）μ ≡ 0 または μ ≡ M/2 (mod M) という正しい形で書いた。" +
          "μ = ±M/2 の排除は Step 4 の（⇒）で c_2 s_1 = -c_1 < 0 と正値性の矛盾として行う。",
        "2026-08-11 の式変形統一で、Step 0 の K_2^*>0 の導出を地の文から 4 段の鎖へ移し、各不等号の根拠を行末へ付けた。内容は変えていない。",
        "2026-08-11 の式変形統一（続き）で、Step 1 を直した。|e^{iθ_μ}|² の計算（1 行に等号 2 つ・根拠なし）を 2 段の鎖へ、" +
          "絶対値の積の計算（1 行に等号 2 つと不等号・根拠が前置の散文）を 6 段の鎖へ開き、各行末に (∵ …) を置いた。" +
          "この生成器は blkref を定義していないので、(∵ …) には引いたブロックの題を書き、ラベル参照は式の前後の散文に残した。内容は変えていない。",
        "2026-08-11 の式変形統一（続き）で、Step 2 の零積からの同値と複素数の成分表示を、2 段・1 段・3 段の鎖へ開き、各行末に根拠を置いた。内容は変えていない。",
        "2026-08-11 の式変形統一（さらに続き）で、Step 3' の μ への翻訳（1 行に同値 3 つ・根拠なし）を 3 段の鎖へ、M の偶奇の言い換え（散文中の同値）を奇数 1 段・偶数 2 段の鎖へ開き、各行末に根拠を置いた。内容は変えていない。",
        "2026-08-11 の式変形統一（さらに続き）で、Step 4 の両向きに散文で埋め込まれていた範囲評価・倍数の候補・M/2 の場合の矛盾・μ=±M の逆向きを、それぞれ一続きの関係式へ開き、各行末に根拠を置いた。内容は変えていない。",
        "2026-08-11 の式変形統一（さらに続き）で、Step 5 の散文に埋まっていた同値（μ=±M のとき第 2 式が c_1 = s_1 c_2 と同値であること）を 4 段の鎖へ開き、各行末に根拠を置いた。内容は変えていない。これでこの証明ブロックの式変形統一は完了した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_023_claim_relation_of_gamma2",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/022_claim_gamma2_thetaとgamma2_minus_thetaの関係.typ",
      ordinal: 23,
    },
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
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta_\mu)
&=i\,e^{-i\theta_\mu}s_2^*\bigl(c_1\cos\theta_\mu+i\sin\theta_\mu-s_1c_2\bigr)
&&(\because\ \gamma_2\ \text{の定義と}\ \cos(-\theta)=\cos\theta,\ \sin(-\theta)=-\sin\theta)\\
&=-\Bigl((-i)e^{-i\theta_\mu}s_2^*\bigl(c_1\cos\theta_\mu+i\sin\theta_\mu-s_1c_2\bigr)\Bigr)
&&(\because\ -(-i)=i)\\
&=-\overline{i\,e^{i\theta_\mu}s_2^*\bigl(c_1\cos\theta_\mu-i\sin\theta_\mu-s_1c_2\bigr)}
&&(\because\ \text{複素共役は積を保ち、実数を固定し、}\ \overline{i}=-i,\ \overline{e^{i\theta_\mu}}=e^{-i\theta_\mu})\\
&=-\overline{\gamma_2(\theta_\mu)}
&&(\because\ \gamma_2\ \text{の定義})
\end{aligned}`),
      paragraph([ref("def_A_theta"), " の ", math(String.raw`\gamma_2`), " の定義を引いた。"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&=\gamma_2(\theta_\mu)\Bigl(-\overline{\gamma_2(\theta_\mu)}\Bigr)
&&(\because\ \gamma_2(-\theta_\mu)=-\overline{\gamma_2(\theta_\mu)})\\
&=-\Bigl(\gamma_2(\theta_\mu)\overline{\gamma_2(\theta_\mu)}\Bigr)
&&(\because\ \mathbb{C}\ \text{の分配則})\\
&=-\lvert\gamma_2(\theta_\mu)\rvert^2
&&(\because\ \lvert z\rvert^2=z\overline z)
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-11 の式変形統一で、複素共役の計算を gamma_2(-theta_mu) から -overline{gamma_2(theta_mu)} までの 4 段へつなぎ、各行末に根拠を置いた。statement の第 2 式も 3 段の鎖として明示した。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_024_claim_arg_of_gamma2_mu",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/023_claim_gamma2_theta_muの積のarg.typ",
      ordinal: 24,
    },
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
&= \left(i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\right)\left(i\,e^{-i\theta_\mu}s_2^*(c_1\cos(-\theta_\mu) - i\sin(-\theta_\mu) - s_1 c_2)\right)
&&(\because\ \gamma_2\ \text{の定義})\\
&= \left(i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\right)\left(i\,e^{-i\theta_\mu}s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)\right)
&&(\because\ \cos\ \text{は偶関数、}\sin\ \text{は奇関数})\\
&= (i\cdot i)\left(e^{i\theta_\mu}e^{-i\theta_\mu}\right)(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
&&(\because\ \mathbb{C}\ \text{の積の可換性と結合則で因子を並べ替えた})\\
&= (-1)\left(e^{i\theta_\mu + i(-\theta_\mu)}\right)(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
&&(\because\ i\cdot i=-1\ \text{と指数法則})\\
&= (-1)(e^0)(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
&&(\because\ i\theta_\mu + i(-\theta_\mu)=0)\\
&= -(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
&&(\because\ e^0=1)\\
&= -(s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right)
&&(\because\ (a-ib)(a+ib)=a^2+b^2\ \text{を}\ a=c_1\cos\theta_\mu - s_1 c_2,\ b=\sin\theta_\mu\ \text{へ当てた})\\
&= -(s_2^*)^2\left((c_1\cos\tfrac{2\pi\mu}{M} - s_1 c_2)^2 + (\sin\tfrac{2\pi\mu}{M})^2\right)
&&(\because\ \theta_\mu = \tfrac{2\pi\mu}{M})
\end{aligned}`,
      ),
      paragraph([
        ref("def_A_theta"),
        " の ",
        math(String.raw`\gamma_2`),
        " の定義を引いた。ここで ",
        math(String.raw`s_2^* > 0`),
        "（",
        ref("def_transfer_matrix_symbols"),
        "）より ",
        math(String.raw`(s_2^*)^2 > 0`),
        " である。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|\gamma_2(\theta_\mu)|^2
&= \left|i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\right|^2
&&(\because\ \gamma_2\ \text{の定義})\\
&= (s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right)
&&(\because\ |i| = |e^{i\theta_\mu}| = 1\ \text{と、絶対値は積を保つこと})
\end{aligned}`,
      ),
      paragraph([
        "である。この 2 つから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2
&= \dfrac{|\gamma_2(\theta_\mu)|^2}{(s_2^*)^2}
&&(\because\ \text{直前の等式の両辺を}\ (s_2^*)^2 > 0\ \text{で割った})\\
&> 0
&&(\because\ \gamma_2(\theta_\mu) \neq 0\ \text{より}\ |\gamma_2(\theta_\mu)|^2 > 0)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&= -(s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right)
&&(\because\ \text{最初の式変形})\\
&< 0
&&(\because\ (s_2^*)^2 > 0\ \text{と直前の不等式の積は正であり、その}\ (-1)\ \text{倍は負})
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)`),
        " は負の実数であり、負の実数の偏角は ",
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
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/024_claim_gamma2_theta_mu_gamma2_minus_theta_muのarg.typ",
      ordinal: 25,
    },
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
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/025_claim_gamma2の商のarg.typ",
      ordinal: 26,
    },
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
        String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&= \frac{\gamma_2(\theta_\mu)\,\gamma_2(\theta_\mu)}{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}
&&(\because\ \text{分子と分母に同じ } \gamma_2(\theta_\mu) = z \neq 0 \text{ を掛けても商は変わらない}) \\
&= \frac{z^2}{-r^2}
&&(\because\ \text{分子は } z \text{ の定義、分母は上の積の等式 } \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = -r^2) \\
&= z^2 \cdot \left(-\frac{1}{r^2}\right)
&&(\because\ -r^2 \neq 0 \text{ による商から積への書き換え})
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 各因子の極座標表現。Step 0 と Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{polar}}(z^2)
&= \phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z)
&& (\because\ \phi_{\mathrm{polar}}\ \text{の乗法性}) \\
&= [(r,\varphi_\mu)]_{\sim}\cdot[(r,\varphi_\mu)]_{\sim}
&& (\because\ \text{Step 1}) \\
&= [(r^2,\ 2\varphi_\mu)]_{\sim}
&& (\because\ \text{極座標表現の積の定義})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`-\dfrac{1}{r^2} \in \mathbb{R}_{<0}`),
        " については、",
        ref("def_phi_cartesian"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}\!\left(\left[\left(\tfrac{1}{r^2},\ \pi\right)\right]_{\sim}\right)
&= \left(\tfrac{1}{r^2}\cos\pi,\ \tfrac{1}{r^2}\sin\pi\right)
&& (\because\ \phi_{\mathrm{cartesian}}\ \text{の定義}) \\
&= \left(-\tfrac{1}{r^2},\ 0\right)
&& (\because\ \cos\pi=-1,\ \sin\pi=0) \\
&= -\frac{1}{r^2}
&& (\because\ \mathbb{R}\ \text{を}\ \mathbb{C}\ \text{の実軸と同一視する})
\end{aligned}`,
      ),
      paragraph([
        "であるから、Step 0 より ",
        math(String.raw`\phi_{\mathrm{polar}}\!\left(-\dfrac{1}{r^2}\right) = \left[\left(\dfrac{1}{r^2},\ \pi\right)\right]_{\sim}`),
        "。",
      ]),
      paragraph(["Step 4: 商の極座標表現。"]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{polar}}\!\left(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right)
&= \phi_{\mathrm{polar}}\!\left(z^2\cdot\left(-\tfrac{1}{r^2}\right)\right)
&&(\because\ \text{Step 2 の商から積への書き換え}) \\
&= \phi_{\mathrm{polar}}(z^2)\cdot\phi_{\mathrm{polar}}\!\left(-\tfrac{1}{r^2}\right)
&&(\because\ \text{Step 0 の }\phi_{\mathrm{polar}}\text{ の乗法性}) \\
&= [(r^2,\ 2\varphi_\mu)]_{\sim}\cdot\left[\left(\tfrac{1}{r^2},\ \pi\right)\right]_{\sim}
&&(\because\ \text{Step 3 の各因子の極座標表現}) \\
&= \left[\left(r^2\cdot\tfrac{1}{r^2},\ 2\varphi_\mu + \pi\right)\right]_{\sim}
&&(\because\ \text{極座標表現の積の定義}) \\
&= [(1,\ 2\varphi_\mu + \pi)]_{\sim}
&&(\because\ r^2\cdot\tfrac{1}{r^2} = 1)
\end{aligned}`,
      ),
      paragraph([
        "よって、絶対値は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right|
&= \mathrm{pr}_1\!\left([(1,\ 2\varphi_\mu+\pi)]_{\sim}\right)
&&(\because\ \text{絶対値の定義}) \\
&= 1
&&(\because\ \text{第 1 射影は代表の第 1 成分を返す})
\end{aligned}`,
      ),
      paragraph([
        "（", ref("def_abs_arg"), "、", ref("first_and_second_projections"),
        "）。第 1 成分 ",
        math(String.raw`1 \neq 0`),
        " なので ",
        math(String.raw`\mathrm{pr}_2`),
        " は ",
        math(String.raw`[2\varphi_\mu+\pi]_{\sim_{\mathrm{angle}}}`),
        " を返し、偏角は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}\!\left(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2\!\left([(1,\ 2\varphi_\mu+\pi)]_{\sim}\right)\right)
&&(\because\ \text{偏角の定義}) \\
&= s_{[0,2\pi)}\!\left([\,2\varphi_\mu + \pi\,]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第 2 射影は第 1 成分が零でないとき角の類を返す})
\end{aligned}`,
      ),
      paragraph([
        "（", ref("def_abs_arg"), "、", ref("first_and_second_projections"), "）。",
      ]),
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
&&(\because\ \text{不等式の各辺を 2 倍して }\pi\text{ を足す}) \\
&\Rightarrow 0 \leq (2\varphi_\mu+\pi)-2\cdot0\cdot\pi < 2\pi
&&(\because\ \pi\geq0) \\
&\Rightarrow n=0
&&(\because\ \text{条件を満たす }n\in\mathbb{Z}\text{ の一意性}) \\
&\Rightarrow \arg^{[0,2\pi)}=2\varphi_\mu+\pi
&&(\because\ \text{区間 }[0,2\pi)\text{ への代表を返す写像の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\tfrac{\pi}{2} \leq \varphi_\mu < \tfrac{3\pi}{2}
&\Rightarrow 2\pi \leq 2\varphi_\mu+\pi < 4\pi
&&(\because\ \text{不等式の各辺を 2 倍して }\pi\text{ を足す}) \\
&\Rightarrow 0 \leq (2\varphi_\mu+\pi)-2\cdot1\cdot\pi < 2\pi
&&(\because\ \text{各辺から }2\pi\text{ を引く}) \\
&\Rightarrow n=1
&&(\because\ \text{条件を満たす }n\in\mathbb{Z}\text{ の一意性}) \\
&\Rightarrow \arg^{[0,2\pi)}=2\varphi_\mu-\pi
&&(\because\ (2\varphi_\mu+\pi)-2\pi=2\varphi_\mu-\pi)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\tfrac{3\pi}{2} \leq \varphi_\mu < 2\pi
&\Rightarrow 4\pi \leq 2\varphi_\mu+\pi < 5\pi
&&(\because\ \text{不等式の各辺を 2 倍して }\pi\text{ を足す}) \\
&\Rightarrow 0 \leq (2\varphi_\mu+\pi)-2\cdot2\cdot\pi < \pi
&&(\because\ \text{各辺から }4\pi\text{ を引く}) \\
&\Rightarrow 0 \leq (2\varphi_\mu+\pi)-2\cdot2\cdot\pi < 2\pi
&&(\because\ \pi<2\pi) \\
&\Rightarrow n=2
&&(\because\ \text{条件を満たす }n\in\mathbb{Z}\text{ の一意性}) \\
&\Rightarrow \arg^{[0,2\pi)}=2\varphi_\mu-3\pi
&&(\because\ (2\varphi_\mu+\pi)-4\pi=2\varphi_\mu-3\pi)
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
        "この 3 つの等式は、", ref("def_phi_cartesian"),
        " をそれぞれの類へ当てた次の 3 本の鎖で確かめられる",
        "（2 本目の鎖の Euler の公式は ", ref("euler_formula_cos_sin"), "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}\!\left(\left[\left(1,\ \tfrac{\pi}{2}\right)\right]_{\sim}\right)
&= \left(\cos\tfrac{\pi}{2},\ \sin\tfrac{\pi}{2}\right)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義}) \\
&= (0,\ 1)
&&(\because\ \cos\tfrac{\pi}{2}=0,\ \sin\tfrac{\pi}{2}=1) \\
&= i
&&(\because\ \mathbb{R}^2=\mathbb{C}\ \text{の同一視で}\ (0,1)\ \text{は}\ i)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}([(1,\ \theta_\mu)]_{\sim})
&= (\cos\theta_\mu,\ \sin\theta_\mu)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義}) \\
&= e^{i\theta_\mu}
&&(\because\ \text{Euler の公式})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}([(s_2^*,\ 0)]_{\sim})
&= (s_2^*\cos 0,\ s_2^*\sin 0)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義}) \\
&= (s_2^*,\ 0)
&&(\because\ \cos 0=1,\ \sin 0=0) \\
&= s_2^*
&&(\because\ \mathbb{R}^2=\mathbb{C}\ \text{の同一視。}s_2^*>0\ \text{なので実軸上の点})
\end{aligned}`,
      ),
      paragraph([
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
        "原文の note（逆数と積の arg の参考事実）は notes/008_TV1_hatZ_hatY.ts にそのまま残してある。",
        "2026-08-12 の式変形統一で、Step 3 の 2 本の根拠の無い等号列を一続きの鎖へ直し、" +
          "各行末に乗法性・Step 1・極座標表現の積・直交座標表示・三角関数値・実軸との同一視という根拠を付けた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_027_claim_eigenvector_A_theta",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/026_claim_A_thetaの対角化_固有値と固有ベクトル.typ",
      ordinal: 27,
    },
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
&= \begin{vmatrix} \gamma_1(\theta_\mu) - \lambda & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) - \lambda \end{vmatrix}
&& (\because\ A(\theta_\mu)\ \text{の成分表示}) \\
&= (\gamma_1(\theta_\mu) - \lambda)(\gamma_1(\theta_\mu) - \lambda) - \gamma_2(\theta_\mu)(-\gamma_2(-\theta_\mu))
&& (\because\ 2\times2\ \text{行列の行列式の定義}) \\
&= (\gamma_1(\theta_\mu) - \lambda)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{同じ元の積は 2 乗であり、負元を引くことは元を足すこと}) \\
&= \gamma_1(\theta_\mu)^2 - 2\lambda\gamma_1(\theta_\mu) + \lambda^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{平方の展開と複素数の積の可換則})
\end{aligned}`,
      ),
      paragraph(["より"]),
      displayMath(
        String.raw`\lambda^2 - 2\lambda\gamma_1(\theta_\mu) + \gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 0`,
      ),
      paragraph([
        "である。以下の鎖の第 4 の等号では、根号の中の ",
        math(String.raw`4`),
        " が正の実数で偏角が ",
        math(String.raw`0`),
        " であることから ",
        ref("condition_of_commutativity_of_sqrt_and_product"),
        " を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lambda
&= \frac{2\gamma_1(\theta_\mu) \pm \sqrt{(-2\gamma_1(\theta_\mu))^2 - 4(\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2}
&& (\because\ \text{2 次方程式の解の公式。係数は}\ a=1,\ b=-2\gamma_1(\theta_\mu),\ c=\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)) \\
&= \frac{2\gamma_1(\theta_\mu) \pm \sqrt{4\gamma_1(\theta_\mu)^2 - 4(\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2}
&& (\because\ (-2\gamma_1(\theta_\mu))^2 = 4\gamma_1(\theta_\mu)^2\ \text{（負元の 2 乗は 2 乗、積の 2 乗）}) \\
&= \frac{2\gamma_1(\theta_\mu) \pm \sqrt{4\bigl(\gamma_1(\theta_\mu)^2 - (\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))\bigr)}}{2}
&& (\because\ \text{分配則で}\ 4\ \text{をくくる}) \\
&= \frac{2\gamma_1(\theta_\mu) \pm 2\sqrt{\gamma_1(\theta_\mu)^2 - (\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2}
&& (\because\ \text{「sqrt と積が可換になる条件」より}\ \sqrt{4z}=\sqrt{4}\,\sqrt{z}=2\sqrt{z}) \\
&= \gamma_1(\theta_\mu) \pm \sqrt{\gamma_1(\theta_\mu)^2 - (\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}
&& (\because\ \text{分子の各項と分母を}\ 2\ \text{で約分}) \\
&= \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
&& (\because\ \text{同じ元}\ \gamma_1(\theta_\mu)^2\ \text{を引いて消す})
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
&& (\because\ \text{第 1 行を零でない複素数で定数倍する行基本変形}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}{\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \text{第 1 行の第 1 成分を約分し、第 2 成分の分子をまとめた}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\mp\sqrt{-1_{\mathbb{C}}\cdot\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-1_{\mathbb{C}}\cdot\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \sqrt{z}\,\sqrt{z}=z\ \text{と}\ -z=(-1_{\mathbb{C}})z)
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
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \text{根号と積が可換になる条件を分母と第 2 行へ代入した}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \mp(-x)=\pm x\ \text{として符号を整理した}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\pm\sqrt{-1_{\mathbb{C}}}} \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\ne0\ \text{なので約分した})
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
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ 1/(\pm x)=\pm(1/x)\ \text{として逆数を積へ書き直した}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \mp\left(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot\sqrt{-1_{\mathbb{C}}}\right) \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \text{複素平方根の逆数の公式を代入し、符号を整理した}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \mp i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\
-\gamma_2(-\theta_\mu) & \pm i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \sqrt{-1_{\mathbb{C}}}=i\ \text{と複素数の積の可換則})
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
      notes: [
        "原文の固有方程式・行列式展開・固有ベクトルの行基本変形を全ステップ復元。虚数単位は i、中間の複素平方根は \\sqrt{-1_C} 表記で保持。",
        "2026-08-12 の式変形統一で、固有方程式の左辺の 3 段を 4 段へ開き、行列の成分表示・2×2 行列式・負号の整理・平方の展開を各行の根拠として明示した。内容は変えていない。",
        "2026-08-12 の式変形統一で、固有ベクトルを求める行基本変形以降の 9 段すべてへ、行の定数倍・約分・平方根の積・符号整理・逆数公式・虚数単位という根拠を行末に付けた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_028_claim_P_mu_D_mu",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/027_claim_A_thetaの対角化_P_muとD_mu.typ",
      ordinal: 28,
    },
    title: { tex: String.raw`A(\theta_\mu) \text{ の対角化 } (P_\mu,\, D_\mu)` },
    labels: ["diagonalization_P_D"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        "、",
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
      paragraph([
        "とおく。このとき ",
        math(String.raw`\det P_\mu \neq 0`),
        " であり（したがって ",
        math(String.raw`P_\mu^{-1}`),
        " が存在し）、",
      ]),
      displayMath(
        String.raw`\det P_\mu = \frac{i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2M\,\gamma_2(-\theta_\mu)} \neq 0_{\mathbb{C}},
\qquad A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}`,
      ),
      paragraph([
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " のとき ",
        math(String.raw`A(\theta_\mu) = I`),
        "（単位行列）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`P_\mu`),
        " の各成分が定義される（分母が ",
        math(String.raw`0`),
        " でない）こと。仮定 ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " と ",
        ref("relation_of_gamma_2"),
        " の ",
        math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`),
        " より ",
        math(String.raw`\gamma_2(-\theta_\mu) \neq 0`),
        "（複素共役は ",
        math(String.raw`0`),
        " を ",
        math(String.raw`0`),
        " にしか写さない）。また ",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " より ",
        math(String.raw`\sqrt{M} > 0`),
        "。よって ",
        math(String.raw`2\sqrt{M}\,\gamma_2(-\theta_\mu) \neq 0`),
        " であり、",
        math(String.raw`P_\mu`),
        " の 4 成分はすべて定まる。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`P_\mu`),
        " の 2 つの列が ",
        ref("eigenvector_of_A_theta"),
        " の固有ベクトルであること。",
        ref("eigenvector_of_A_theta"),
        " の固有ベクトルは任意定数 ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " を用いて ",
        math(String.raw`v_{\pm,\mu} = c\bigl(\pm i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)},\ \gamma_2(-\theta_\mu)\bigr)^{\mathsf{T}}`),
        " であった。Step 1 より ",
        math(String.raw`c := \dfrac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)} \in \mathbb{C}^\times`),
        " と選べて、このとき第 2 成分は ",
        math(String.raw`c\,\gamma_2(-\theta_\mu) = \dfrac{1}{2\sqrt{M}}`),
        " となり、",
        math(String.raw`v_{+,\mu}, v_{-,\mu}`),
        " はそれぞれ上に書いた ",
        math(String.raw`P_\mu`),
        " の第 1 列・第 2 列に一致する。すなわち",
      ]),
      displayMath(
        String.raw`A(\theta_\mu)\,v_{\pm,\mu} = \lambda_{\pm,\mu}\,v_{\pm,\mu}
\quad\Longrightarrow\quad
A(\theta_\mu)\,P_\mu = P_\mu D_\mu`,
      ),
      paragraph([
        "（右の等式は、行列の積を列ごとに見れば左辺の第 1 列が ",
        math(String.raw`A(\theta_\mu)v_{+,\mu} = \lambda_{+,\mu}v_{+,\mu}`),
        "、右辺の第 1 列が ",
        math(String.raw`v_{+,\mu}\lambda_{+,\mu}`),
        " で一致すること、第 2 列も同様であることによる。）",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\det P_\mu`),
        " の計算。以下 ",
        math(String.raw`t := \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \in \mathbb{C}`),
        " と略記する。",
        math(String.raw`2 \times 2`),
        " 行列の行列式の定義より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\det P_\mu
&= \frac{+i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}\cdot\frac{1}{2\sqrt{M}}
 - \frac{-i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}\cdot\frac{1}{2\sqrt{M}}
&& (\because\ 2\times2\ \text{行列式の定義}) \\[4pt]
&= \frac{i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
 - \frac{-i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
&& (\because\ \text{分数の積は、分子の積を分母の積で割ったもの}) \\[4pt]
&= \frac{i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
 + \frac{i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
&& (\because\ \text{分子の負号を分数の外へ出し、負元を引くことは加えること}) \\[4pt]
&= 2\cdot\frac{i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
&& (\because\ \text{同じ項を 2 つ加えることは 2 倍すること}) \\[4pt]
&= 2\cdot\frac{i\,t}{4M\,\gamma_2(-\theta_\mu)}
&& (\because\ \text{積の可換性と}\ (2\sqrt{M})\cdot(2\sqrt{M})=4M\text{（}\sqrt{M}\ \text{の 2 乗は}\ M\text{）}) \\[4pt]
&= \frac{i\,t}{2M\,\gamma_2(-\theta_\mu)}
&& (\because\ \text{分子と分母を 2 で約分})
\end{aligned}`,
      ),
      paragraph([
        "Step 4: ",
        math(String.raw`\det P_\mu \neq 0`),
        "。",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = -|\gamma_2(\theta_\mu)|^2`),
        " であり、仮定 ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " より ",
        math(String.raw`|\gamma_2(\theta_\mu)|^2 > 0`),
        " であるから ",
        math(String.raw`t^2 = -|\gamma_2(\theta_\mu)|^2 \neq 0_{\mathbb{C}}`),
        "、ゆえに ",
        math(String.raw`t \neq 0_{\mathbb{C}}`),
        "。さらに ",
        math(String.raw`i \neq 0`),
        "、",
        math(String.raw`2M \neq 0`),
        "（",
        math(String.raw`M \geq 1`),
        "）、Step 1 より ",
        math(String.raw`\gamma_2(-\theta_\mu) \neq 0`),
        "。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ零因子を持たないから",
      ]),
      displayMath(
        String.raw`\det P_\mu = \frac{i\,t}{2M\,\gamma_2(-\theta_\mu)} \neq 0_{\mathbb{C}}`,
      ),
      paragraph([
        "Step 5: 対角化。",
        math(String.raw`\det P_\mu \neq 0`),
        " より ",
        math(String.raw`P_\mu`),
        " は可逆であり ",
        math(String.raw`P_\mu^{-1}`),
        " が存在する。Step 2 の ",
        math(String.raw`A(\theta_\mu)P_\mu = P_\mu D_\mu`),
        " の両辺に右から ",
        math(String.raw`P_\mu^{-1}`),
        " を掛けて",
      ]),
      displayMath(String.raw`A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}`),
      paragraph([
        "Step 6: ",
        math(String.raw`\gamma_2(\theta_\mu) = 0`),
        " の場合。この場合は ",
        math(String.raw`P_\mu`),
        " が定義されない（Step 1 の分母が ",
        math(String.raw`0`),
        " になる）が、",
        ref("A_theta_is_identity_when_gamma2_zero"),
        " より ",
        math(String.raw`A(\theta_\mu) = I`),
        " であって対角化は不要である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（027_claim_A_thetaの対角化_P_muとD_mu.typ）は A(θ_μ) = P_μ D_μ P_μ^{-1} と書きながら P_μ^{-1} の存在" +
          "（det P_μ ≠ 0）を述べていなかった。Lean 形式化（Part008/Claim027_EigenATheta.lean の det_Pmat / " +
          "det_Pmat_ne_zero）と同じ計算を人手で行い、det P_μ = i√(γ_2(θ_μ)γ_2(-θ_μ))/(2M γ_2(-θ_μ)) を求め、" +
          "γ_2(θ_μ) ≠ 0（ゆえに根号の中身 -|γ_2(θ_μ)|^2 ≠ 0）と M ≥ 1 の下で非零であることを示すステップを追加した。" +
          "あわせて、原文が 1 行で済ませていた『固有ベクトルに任意定数を代入する』段も、任意定数 c の選択が可能である" +
          "こと（γ_2(-θ_μ) ≠ 0）と AP = PD から A = PDP^{-1} への移行に分けて書いた。",
        "2026-08-12 の式変形統一で、Step 3 の det P_μ の計算（1 行に等号 2 つ・根拠は後置きの括弧書き）を、" +
          "行列式の定義・分数の積・負号の整理・同じ項の和・√M の 2 乗・約分を各行末の根拠にした 6 段の鎖へ開いた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_029_claim_a_theta_mu",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/028_claim_a_theta_mu.typ",
      ordinal: 29,
    },
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
&& (\because\ \text{Step 2 と Step 3}) \\
&= \begin{cases}
\pi & (\varphi = 0) \\
3\pi - 2\varphi & (0 < \varphi < \pi) \\
\pi & (\varphi = \pi) \\
5\pi - 2\varphi & (\pi < \varphi < 2\pi)
\end{cases}
&& (\because\ \text{各場合で}\ \pi\ \text{を足す})
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
\varphi = 0 &\Rightarrow \text{sum} = \pi \in [0,2\pi)
&& (\because\ \text{Step 4 の第 1 の場合と}\ 0 \leq \pi < 2\pi) \\
0 < \varphi < \tfrac{\pi}{2} &\Rightarrow 2\pi < 3\pi - 2\varphi < 3\pi \Rightarrow \text{sum} \in [2\pi,4\pi)
&& (\because\ \text{Step 4 の第 2 の場合。各辺を}\ {-2}\ \text{倍して}\ 3\pi\ \text{を足すと不等号の向きが反転し、}(2\pi,3\pi) \subset [2\pi,4\pi)) \\
\varphi = \tfrac{\pi}{2} &\Rightarrow \text{sum} = 2\pi \in [2\pi,4\pi)
&& (\because\ \text{Step 4 の第 2 の場合へ}\ \varphi=\tfrac{\pi}{2}\ \text{を代入すると}\ 3\pi-\pi=2\pi) \\
\tfrac{\pi}{2} < \varphi < \pi &\Rightarrow \pi < 3\pi - 2\varphi < 2\pi \Rightarrow \text{sum} \in [0,2\pi)
&& (\because\ \text{Step 4 の第 2 の場合。各辺を}\ {-2}\ \text{倍して}\ 3\pi\ \text{を足すと不等号の向きが反転し、}(\pi,2\pi) \subset [0,2\pi)) \\
\varphi = \pi &\Rightarrow \text{sum} = \pi \in [0,2\pi)
&& (\because\ \text{Step 4 の第 3 の場合と}\ 0 \leq \pi < 2\pi) \\
\pi < \varphi < \tfrac{3\pi}{2} &\Rightarrow 2\pi < 5\pi - 2\varphi < 3\pi \Rightarrow \text{sum} \in [2\pi,4\pi)
&& (\because\ \text{Step 4 の第 4 の場合。各辺を}\ {-2}\ \text{倍して}\ 5\pi\ \text{を足すと不等号の向きが反転し、}(2\pi,3\pi) \subset [2\pi,4\pi)) \\
\varphi = \tfrac{3\pi}{2} &\Rightarrow \text{sum} = 2\pi \in [2\pi,4\pi)
&& (\because\ \text{Step 4 の第 4 の場合へ}\ \varphi=\tfrac{3\pi}{2}\ \text{を代入すると}\ 5\pi-3\pi=2\pi) \\
\tfrac{3\pi}{2} < \varphi < 2\pi &\Rightarrow \pi < 5\pi - 2\varphi < 2\pi \Rightarrow \text{sum} \in [0,2\pi)
&& (\because\ \text{Step 4 の第 4 の場合。各辺を}\ {-2}\ \text{倍して}\ 5\pi\ \text{を足すと不等号の向きが反転し、}(\pi,2\pi) \subset [0,2\pi))
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
\end{cases}
&& (\because\ \text{根号と積の交換条件}) \\
&= \begin{cases}
\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot\dfrac{1}{(\gamma_2(-\theta_\mu))^2}} & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot\dfrac{1}{(\gamma_2(-\theta_\mu))^2}} & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
&& (\because\ \text{Step 5 の 2 つの場合の記述}) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
&& (\because\ \gamma_2(-\theta_\mu)\ne0\ \text{なので、分子と分母の共通因子}\ \gamma_2(-\theta_\mu)\ \text{を各場合で約分})
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
      paragraph([
        "Step 8: Step 6 と Step 7 を組み合わせる。準備として、Step 7 の等式の両辺へ ",
        math(String.raw`\gamma_2(-\theta_\mu)`),
        " を掛けた等式を作る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)
&= \begin{cases}
\dfrac{1}{\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu) & (\varphi = 0 \text{ or } \pi < \varphi < 2\pi) \\
-\dfrac{1}{\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu) & (0 < \varphi \leq \pi)
\end{cases}
&& (\because\ \text{Step 7 の 2 つの場合の記述}) \\
&= \begin{cases}
1 & (\varphi = 0 \text{ or } \pi < \varphi < 2\pi) \\
-1 & (0 < \varphi \leq \pi)
\end{cases}
&& (\because\ \gamma_2(-\theta_\mu)\ne0\ \text{と逆数との積})
\end{aligned}`,
      ),
      paragraph([
        "準備の等式の左辺は各場合で ",
        math(String.raw`\pm1`),
        " であり零でない。そこで、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
&= \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\left(\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)\right)^{-1}
&& \left(\because\ \sqrt{\tfrac{1}{(\gamma_2(-\theta_\mu))^2}}\ne0\ \text{と}\ \mathbb{C}\ \text{の積の可換性から}\ \sqrt{\tfrac{1}{(\gamma_2(-\theta_\mu))^2}}\,\bigl(\sqrt{\tfrac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)\bigr)^{-1}=\tfrac{1}{\gamma_2(-\theta_\mu)}\right) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
\cdot\left(\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)\right)^{-1}
&& (\because\ \text{Step 6}) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1^{-1} & (\varphi = 0) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1)^{-1} & (0 < \varphi \leq \tfrac{\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1)^{-1} & (\tfrac{\pi}{2} < \varphi \leq \pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1^{-1} & (\pi < \varphi \leq \tfrac{3\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1^{-1} & (\tfrac{3\pi}{2} < \varphi < 2\pi)
\end{cases}
&& (\because\ \text{準備の等式。2 つの場合分けを}\ \varphi\ \text{の区間の共通細分（5 区間）で重ねた}) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\varphi = 0) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1) & (0 < \varphi \leq \tfrac{\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1) & (\tfrac{\pi}{2} < \varphi \leq \pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\pi < \varphi \leq \tfrac{3\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\tfrac{3\pi}{2} < \varphi < 2\pi)
\end{cases}
&& (\because\ 1^{-1}=1\ \text{と}\ (-1)^{-1}=-1) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (0 \leq \varphi \leq \tfrac{\pi}{2} \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (\tfrac{\pi}{2} < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
&& (\because\ \text{各場合の符号の積の計算と、同符号の区間の合併})
\end{aligned}`,
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
      paragraph(["Steps 9–11: ", math(String.raw`\gamma_2`), " の定義を代入し、偶奇性を使って共通因子を約分する。"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&= \frac{i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{i\,e^{-i\theta_\mu}s_2^*(c_1\cos(-\theta_\mu) - i\sin(-\theta_\mu) - s_1 c_2)}
&& (\because\ \gamma_2\ \text{の定義を分子と分母へ代入}) \\
&= \frac{i\,e^{i\theta_\mu}s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{i\,e^{-i\theta_\mu}s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)}
&& (\because\ \cos(-\theta_\mu)=\cos\theta_\mu\ \text{かつ}\ \sin(-\theta_\mu)=-\sin\theta_\mu) \\
&= \frac{e^{i\theta_\mu}(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{e^{-i\theta_\mu}(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)}
&& (\because\ i\,s_2^*\ne0\ \text{なので分子と分母の共通因子を約分})
\end{aligned}`,
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
&= c_1\frac{e^{i\theta_\mu} + e^{-i\theta_\mu}}{2} - i\cdot\frac{e^{i\theta_\mu} - e^{-i\theta_\mu}}{2i}
&& (\because\ \text{「$\cos,\sin$ の Euler 表示」の }\cos\theta_\mu\text{ と }\sin\theta_\mu\text{ の表式を代入}) \\
&= c_1\frac{e^{i\theta_\mu} + e^{-i\theta_\mu}}{2} - \frac{e^{i\theta_\mu} - e^{-i\theta_\mu}}{2}
&& (\because\ i\cdot\tfrac{1}{2i}=\tfrac{1}{2}\text{。共通因子}\ i\ne0\ \text{の約分}) \\
&= \frac{(c_1 - 1)e^{i\theta_\mu} + (c_1 + 1)e^{-i\theta_\mu}}{2}
&& (\because\ \text{分配則で}\ e^{i\theta_\mu},\ e^{-i\theta_\mu}\ \text{の係数をまとめる})
\end{aligned}`,
      ),
      paragraph(["もう 1 本も同じ 3 段で計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
c_1\cos\theta_\mu + i\sin\theta_\mu
&= c_1\frac{e^{i\theta_\mu} + e^{-i\theta_\mu}}{2} + i\cdot\frac{e^{i\theta_\mu} - e^{-i\theta_\mu}}{2i}
&& (\because\ \text{「$\cos,\sin$ の Euler 表示」の }\cos\theta_\mu\text{ と }\sin\theta_\mu\text{ の表式を代入}) \\
&= c_1\frac{e^{i\theta_\mu} + e^{-i\theta_\mu}}{2} + \frac{e^{i\theta_\mu} - e^{-i\theta_\mu}}{2}
&& (\because\ i\cdot\tfrac{1}{2i}=\tfrac{1}{2}\text{。共通因子}\ i\ne0\ \text{の約分}) \\
&= \frac{(c_1 + 1)e^{i\theta_\mu} + (c_1 - 1)e^{-i\theta_\mu}}{2}
&& (\because\ \text{分配則で}\ e^{i\theta_\mu},\ e^{-i\theta_\mu}\ \text{の係数をまとめる})
\end{aligned}`,
      ),
      paragraph(["Step 13: 分子分母へ代入し整理すると、"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&= \frac{e^{i\theta_\mu}\left(\dfrac{(c_1 - 1)e^{i\theta_\mu} + (c_1 + 1)e^{-i\theta_\mu}}{2} - s_1 c_2\right)}{e^{-i\theta_\mu}\left(\dfrac{(c_1 + 1)e^{i\theta_\mu} + (c_1 - 1)e^{-i\theta_\mu}}{2} - s_1 c_2\right)}
&& (\because\ \text{Steps 9--11 の比へ Step 12 の 2 つの計算結果を代入}) \\
&= \frac{e^{i\theta_\mu}\left((c_1 - 1)e^{i\theta_\mu} + (c_1 + 1)e^{-i\theta_\mu} - 2 s_1 c_2\right)}{e^{-i\theta_\mu}\left((c_1 + 1)e^{i\theta_\mu} + (c_1 - 1)e^{-i\theta_\mu} - 2 s_1 c_2\right)}
&& (\because\ \text{分子と分母の括弧内を共通分母 }2\text{ へ通分し、共通因子 }\tfrac12\text{ を約分}) \\
&= \frac{(c_1 - 1)e^{2i\theta_\mu} + (c_1 + 1) - 2 s_1 c_2\, e^{i\theta_\mu}}{(c_1 + 1) + (c_1 - 1)e^{-2i\theta_\mu} - 2 s_1 c_2\, e^{-i\theta_\mu}}
&& (\because\ \text{分配則と }e^{i\theta_\mu}e^{-i\theta_\mu}=e^{-i\theta_\mu}e^{i\theta_\mu}=1)
\end{aligned}`,
      ),
      paragraph([
        "Step 14: ",
        math(String.raw`x := e^{i\theta_\mu}`),
        " とおく（",
        math(String.raw`x\,e^{-i\theta_\mu} = e^{i\theta_\mu}e^{-i\theta_\mu} = 1`),
        " より ",
        math(String.raw`x \neq 0`),
        " であり、",
        math(String.raw`x^{-1} = e^{-i\theta_\mu}`),
        "）。Step 13 の分子を書き直す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(c_1 - 1)e^{2i\theta_\mu} + (c_1 + 1) - 2 s_1 c_2\, e^{i\theta_\mu}
&= (c_1 - 1)x^2 - 2 s_1 c_2\, x + (c_1 + 1)
&& (\because\ x\ \text{の定義と指数法則}\ e^{2i\theta_\mu}=(e^{i\theta_\mu})^2\text{。項を}\ x\ \text{の降冪に並べ替え}) \\
&= (c_1 + 1)\left(\frac{c_1 - 1}{c_1 + 1}x^2 - \frac{2 s_1 c_2}{c_1 + 1}x + 1\right)
&& (\because\ c_1 > 0\ \text{より}\ c_1 + 1 \neq 0\text{。各項を}\ (c_1+1)\cdot\tfrac{\text{係数}}{c_1+1}\ \text{と書き、分配則でくくる})
\end{aligned}`,
      ),
      paragraph(["分母も同じ 2 段で書き直す。"]),
      displayMath(
        String.raw`\begin{aligned}
(c_1 + 1) + (c_1 - 1)e^{-2i\theta_\mu} - 2 s_1 c_2\, e^{-i\theta_\mu}
&= (c_1 - 1)x^{-2} - 2 s_1 c_2\, x^{-1} + (c_1 + 1)
&& (\because\ x^{-1} = e^{-i\theta_\mu}\ \text{と指数法則}\ e^{-2i\theta_\mu}=(e^{-i\theta_\mu})^2\text{。項を}\ x^{-1}\ \text{の降冪に並べ替え}) \\
&= (c_1 + 1)\left(\frac{c_1 - 1}{c_1 + 1}x^{-2} - \frac{2 s_1 c_2}{c_1 + 1}x^{-1} + 1\right)
&& (\because\ c_1 > 0\ \text{より}\ c_1 + 1 \neq 0\text{。各項を}\ (c_1+1)\cdot\tfrac{\text{係数}}{c_1+1}\ \text{と書き、分配則でくくる})
\end{aligned}`,
      ),
      paragraph(["Step 15: ", math(String.raw`\dfrac{c_1 - 1}{c_1 + 1} = \alpha_1\alpha_2^{-1}`), " の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\alpha_1\alpha_2^{-1}
&= (\tanh K_1\tanh K_2^*)\cdot((\tanh K_1)^{-1}\tanh K_2^*)^{-1}
&& (\because\ \alpha_1,\alpha_2\ \text{の定義}) \\
&= (\tanh K_1\tanh K_2^*)\cdot(\tanh K_1(\tanh K_2^*)^{-1})
&& (\because\ \text{非零な積の逆数と逆数の逆数}) \\
&= (\tanh K_1)^2\cdot\bigl(\tanh K_2^*(\tanh K_2^*)^{-1}\bigr)
&& (\because\ \text{複素数の積の可換則と結合則}) \\
&= (\tanh K_1)^2\cdot 1
&& (\because\ \tanh K_2^*\neq0\ \text{と逆数の定義}) \\
&= (\tanh K_1)^2
&& (\because\ \text{積の単位元})
\end{aligned}`,
      ),
      paragraph(["一方、"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{c_1 - 1}{c_1 + 1}
&= \frac{\cosh 2K_1 - 1}{\cosh 2K_1 + 1}
&& (\because\ c_1=\cosh 2K_1) \\
&= \frac{2\sinh^2 K_1}{2\cosh^2 K_1}
&& (\because\ \cosh 2x-1=2\sinh^2x\ \text{と}\ \cosh 2x+1=2\cosh^2x) \\
&= \frac{\sinh^2 K_1}{\cosh^2 K_1}
&& (\because\ 2\neq0\ \text{より分子と分母の共通因子}\ 2\ \text{を約分}) \\
&= \left(\frac{\sinh K_1}{\cosh K_1}\right)^2
&& (\because\ \text{分数の積}) \\
&= (\tanh K_1)^2
&& (\because\ \tanh\ \text{の定義})
\end{aligned}`,
      ),
      paragraph(["よって、"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{c_1 - 1}{c_1 + 1}
&= (\tanh K_1)^2
&& (\because\ \text{上の第 2 の計算}) \\
&= \alpha_1\alpha_2^{-1}
&& (\because\ \text{上の第 1 の計算を逆向きに使う})
\end{aligned}\quad \cdots (\star)`,
      ),
      paragraph(["Step 16: ", math(String.raw`\dfrac{2 s_1 c_2}{c_1 + 1} = \alpha_1 + \alpha_2^{-1}`), " の証明。まず"]),
      displayMath(
        String.raw`\begin{aligned}
\alpha_1 + \alpha_2^{-1}
&= \tanh K_1\tanh K_2^* + \left((\tanh K_1)^{-1}\tanh K_2^*\right)^{-1}
&& (\because\ \alpha_1,\alpha_2\ \text{の定義}) \\
&= \tanh K_1\tanh K_2^* + \tanh K_1(\tanh K_2^*)^{-1}
&& (\because\ \text{積の逆元は逆元の積であり、}((\tanh K_1)^{-1})^{-1} = \tanh K_1) \\
&= \tanh K_1\left(\tanh K_2^* + (\tanh K_2^*)^{-1}\right)
&& (\because\ \text{分配則で}\ \tanh K_1\ \text{をくくり出す})
\end{aligned}`,
      ),
      paragraph(["ここで、"]),
      displayMath(
        String.raw`\begin{aligned}
\tanh K_2^* + (\tanh K_2^*)^{-1}
&= \frac{\sinh K_2^*}{\cosh K_2^*} + \frac{\cosh K_2^*}{\sinh K_2^*}
&& (\because\ \tanh\ \text{の定義と、分数の逆数}) \\
&= \frac{\sinh^2 K_2^* + \cosh^2 K_2^*}{\sinh K_2^*\cosh K_2^*}
&& (\because\ \text{通分}) \\
&= \frac{\cosh 2K_2^*}{\sinh K_2^*\cosh K_2^*}
&& (\because\ \cosh^2 x + \sinh^2 x = \cosh 2x) \\
&= \frac{2\cosh 2K_2^*}{2\sinh K_2^*\cosh K_2^*}
&& (\because\ \text{分子と分母に 2 を掛ける}) \\
&= \frac{2\cosh 2K_2^*}{\sinh 2K_2^*}
&& (\because\ 2\sinh x\cosh x = \sinh 2x)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`K_2^* = -\tfrac{1}{2}\log(\tanh K_2)`),
        " すなわち ",
        math(String.raw`e^{-2K_2^*} = \tanh K_2`),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh 2K_2^*
&= \frac{e^{2K_2^*} - e^{-2K_2^*}}{2}
&& (\because\ \sinh\ \text{の定義}) \\
&= \frac{(\tanh K_2)^{-1} - \tanh K_2}{2}
&& (\because\ e^{-2K_2^*} = \tanh K_2\ \text{と、その逆数}\ e^{2K_2^*} = (\tanh K_2)^{-1}) \\
&= \frac{\dfrac{\cosh K_2}{\sinh K_2} - \dfrac{\sinh K_2}{\cosh K_2}}{2}
&& (\because\ \tanh\ \text{の定義と、分数の逆数}) \\
&= \frac{\cosh^2 K_2 - \sinh^2 K_2}{2\sinh K_2\cosh K_2}
&& (\because\ \text{通分}) \\
&= \frac{1}{2\sinh K_2\cosh K_2}
&& (\because\ \cosh^2 x - \sinh^2 x = 1) \\
&= \frac{1}{\sinh 2K_2}
&& (\because\ 2\sinh x\cosh x = \sinh 2x)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh 2K_2^*
&= \frac{e^{2K_2^*} + e^{-2K_2^*}}{2}
&& (\because\ \cosh\ \text{の定義}) \\
&= \frac{(\tanh K_2)^{-1} + \tanh K_2}{2}
&& (\because\ e^{-2K_2^*} = \tanh K_2\ \text{と、その逆数}\ e^{2K_2^*} = (\tanh K_2)^{-1}) \\
&= \frac{\dfrac{\cosh K_2}{\sinh K_2} + \dfrac{\sinh K_2}{\cosh K_2}}{2}
&& (\because\ \tanh\ \text{の定義と、分数の逆数}) \\
&= \frac{\cosh^2 K_2 + \sinh^2 K_2}{2\sinh K_2\cosh K_2}
&& (\because\ \text{通分}) \\
&= \frac{\cosh 2K_2}{2\sinh K_2\cosh K_2}
&& (\because\ \cosh^2 x + \sinh^2 x = \cosh 2x) \\
&= \frac{\cosh 2K_2}{\sinh 2K_2}
&& (\because\ 2\sinh x\cosh x = \sinh 2x)
\end{aligned}`,
      ),
      paragraph(["よって、"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{2\cosh 2K_2^*}{\sinh 2K_2^*}
&= 2\cdot\frac{\cosh 2K_2/\sinh 2K_2}{1/\sinh 2K_2}
&& (\because\ \text{上の 2 本の計算を代入}) \\
&= 2\cosh 2K_2
&& (\because\ \text{分子と分母に}\ \sinh 2K_2\ \text{を掛ける})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\alpha_1 + \alpha_2^{-1}
&= \tanh K_1\cdot\frac{2\cosh 2K_2^*}{\sinh 2K_2^*}
&& (\because\ \text{この Step の最初の鎖と、その次の鎖}) \\
&= \tanh K_1\cdot 2\cosh 2K_2
&& (\because\ \text{直前の計算}) \\
&= 2\tanh K_1\cosh 2K_2
&& (\because\ \text{積の可換性})
\end{aligned}`,
      ),
      paragraph(["一方、"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{2 s_1 c_2}{c_1 + 1}
&= \frac{2\sinh 2K_1\cosh 2K_2}{\cosh 2K_1 + 1}
&& (\because\ s_1, c_1, c_2\ \text{の定義}) \\
&= \frac{2\cdot 2\sinh K_1\cosh K_1\cdot\cosh 2K_2}{\cosh 2K_1 + 1}
&& (\because\ \sinh 2x = 2\sinh x\cosh x) \\
&= \frac{2\cdot 2\sinh K_1\cosh K_1\cdot\cosh 2K_2}{2\cosh^2 K_1}
&& (\because\ \cosh 2x + 1 = 2\cosh^2 x) \\
&= \frac{2\sinh K_1\cosh 2K_2}{\cosh K_1}
&& (\because\ \text{分子と分母を}\ 2\cosh K_1\ \text{で割る}) \\
&= 2\tanh K_1\cosh 2K_2
&& (\because\ \tanh\ \text{の定義})
\end{aligned}`,
      ),
      paragraph(["よって、"]),
      displayMath(
        String.raw`\frac{2 s_1 c_2}{c_1 + 1} = \alpha_1 + \alpha_2^{-1} \quad (\because\ \text{両者とも}\ 2\tanh K_1\cosh 2K_2\ \text{に等しい}) \quad \cdots (\star\star)`,
      ),
      paragraph(["Step 17: 因数分解の検証。", math(String.raw`(1 - \alpha_1 x)(1 - \alpha_2^{-1}x)`), " を展開すると、"]),
      displayMath(
        String.raw`\begin{aligned}
(1 - \alpha_1 x)(1 - \alpha_2^{-1}x)
&= 1-\alpha_2^{-1}x-\alpha_1x+\alpha_1\alpha_2^{-1}x^2
&& (\because\ \text{分配則}) \\
&= 1-(\alpha_1+\alpha_2^{-1})x+\alpha_1\alpha_2^{-1}x^2
&& (\because\ \text{分配則}) \\
&= 1-\frac{2s_1c_2}{c_1+1}x+\frac{c_1-1}{c_1+1}x^2
&& (\because\ (\star),(\star\star))
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
(c_1+1)(1-\alpha_1x)(1-\alpha_2^{-1}x)
&=(c_1+1)\left(1-\frac{2s_1c_2}{c_1+1}x+\frac{c_1-1}{c_1+1}x^2\right)
&& (\because\ \text{上の計算}) \\
&=(c_1+1)-2s_1c_2x+(c_1-1)x^2
&& (\because\ c_1+1\ne0\ \text{と分配則})
\end{aligned}`,
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
        String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&=\frac{(c_1+1)(1-\alpha_1e^{i\theta_\mu})(1-\alpha_2^{-1}e^{i\theta_\mu})}{(c_1+1)(1-\alpha_1e^{-i\theta_\mu})(1-\alpha_2^{-1}e^{-i\theta_\mu})}
&& (\because\ \text{Step 14 と Step 17}) \\
&=\frac{(1-\alpha_1e^{i\theta_\mu})(1-\alpha_2^{-1}e^{i\theta_\mu})}{(1-\alpha_1e^{-i\theta_\mu})(1-\alpha_2^{-1}e^{-i\theta_\mu})}
&& (\because\ c_1+1\ne0\ \text{による約分})
\end{aligned}`,
      ),
      paragraph(["したがって ", math(String.raw`a(\theta_\mu)`), " の定義より、"]),
      displayMath(
        String.raw`\begin{aligned}
a(\theta_\mu)
&=\sqrt{\frac{(1-\alpha_1e^{i\theta_\mu})(1-\alpha_2^{-1}e^{i\theta_\mu})}{(1-\alpha_1e^{-i\theta_\mu})(1-\alpha_2^{-1}e^{-i\theta_\mu})}}
&& (\because\ a(\theta_\mu)\ \text{の定義}) \\
&=\sqrt{\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}
&& (\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["Part A の Step 8 の結果と合わせて、Claim のステートメントが示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の Part A（Steps 1-8 の偏角場合分け）と Part B（Steps 9-18 の α1,α2 因数分解）を全ステップ復元。arg^[0,2π)(γ2(-θμ)) を φ と略記。",
        "2026-08-12 の式変形統一で、Part A の Step 4 に同じ行で連結されていた 2 つの等号を、Step 2・Step 3 の代入と各場合で π を足す計算に分け、各行末に根拠を付けた。内容は変えていない。",
        "2026-08-12 の式変形統一（続き）で、Part A の Step 5 の 8 つの場合の含意鎖（根拠なし）へ、Step 4 のどの場合を使ったか・各辺を −2 倍して 3π（5π）を足す不等式の変形・区間の包含という根拠を各行末に付けた。内容は変えていない。",
        "2026-08-12 の式変形統一（続き）で、Part B の Step 16 の 7 本の計算をすべて一続きの鎖＋行末の根拠へ開いた。あわせて、最初の鎖の中間式 (tanh K_1)^{-1}(tanh K_2^*)^{-1}（これは α_2^{-1} ではなく α_1^{-1} に等しい）が誤っていたのを ((tanh K_1)^{-1} tanh K_2^*)^{-1} へ直した（結論と以降の行は正しかった）。",
        "2026-08-12 の式変形統一（続き）で、Part B の Step 17–18 を一続きの鎖へ開いた。因数分解は分配則を 1 段ずつ適用し、c_1+1 の乗法と約分を分け、最後の 2 本の等式にも Step 14・Step 17、a(θ_μ) の定義という根拠を各行末へ付けた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_030_definition_fermi",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/029_definition_フェルミオン.typ",
      ordinal: 30,
    },
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
        math(String.raw`\psi_\mu, \psi_\mu^\dagger \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
&:= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot P_\mu
&&\left(\because\ \text{定義「フェルミオン」}\right)\\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}
\begin{pmatrix}
+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} & -i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\
\gamma_2(-\theta_\mu) & \gamma_2(-\theta_\mu)
\end{pmatrix}
&&\left(\because\ \text{主張「}A(\theta_\mu)\text{ の対角化 }(P_\mu,D_\mu)\text{」の }P_\mu\text{ の表示}\right)
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
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "現行ソースに再同期：ψ_μ の定義域を γ2(θμ)≠0 なる μ に限定し、γ2=0（臨界点の ψ_M）では ψ が存在しない旨の注、および a(θμ) の逆数・符号 ε_μ に関する注を反映。",
        "定義が意味をもつ条件（γ2≠0）とその帰結は定義の妥当性そのものなので statement へ格上げした。" +
          "符号 ε_μ による書き換えとホロノミック量子場との比較は notes/008_TV1_hatZ_hatY.ts へ移設。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_031_claim_V_psi_commutator",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/030_claim_Vとpsiの交換関係.typ",
      ordinal: 31,
    },
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
&= T_{(V)}\!\bigl(\bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)\cdot P_\mu\bigr)
\quad (\because\ \text{フェルミオンの定義}) \\
&= \begin{pmatrix} T_{(V)}(\hat{Z}_\mu^{(-)}) & T_{(V)}(\hat{Y}_\mu) \end{pmatrix}\cdot P_\mu
\quad (\because\ T_{(V)} \text{ の線形性}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) A(\theta_\mu)\cdot P_\mu
\quad (\because\ T_{(V)}\ \text{の}\ \hat{Z}_\mu^{(-)}, \hat{Y}_\mu\ \text{への作用}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)(P_\mu D_\mu P_\mu^{-1})\cdot P_\mu
\quad (\because\ A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu D_\mu
\quad (\because\ \text{行列の積の結合則と}\ P_\mu^{-1}P_\mu = I) \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix} D_\mu
\quad (\because\ \text{フェルミオンの定義}) \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}\begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix}
\quad (\because\ D_\mu\ \text{の成分}) \\
&= \begin{pmatrix} \lambda_{+,\mu}\psi_\mu^\dagger & \lambda_{-,\mu}\psi_\mu \end{pmatrix}
\quad (\because\ \text{行ベクトルと対角行列の積の成分計算}) \\
&= \begin{pmatrix} \bigl(\gamma_1(\theta_\mu) + \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)\psi_\mu^\dagger & \bigl(\gamma_1(\theta_\mu) - \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)\psi_\mu \end{pmatrix}
\quad (\because\ \lambda_{\pm,\mu}\ \text{の値})
\end{aligned}`,
      ),
      paragraph([
        "ここで、第 3 の等号の作用は ",
        ref("T_V_hatZ_hatY"),
        "、第 4 の等号の対角化 ",
        math(String.raw`A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}`),
        " と第 7・第 9 の等号の ",
        math(String.raw`D_\mu`),
        " の成分・固有値 ",
        math(String.raw`\lambda_{\pm,\mu} = \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " は ",
        ref("eigenvector_of_A_theta"),
        " および ",
        ref("diagonalization_P_D"),
        "、第 1・第 6 の等号は ",
        ref("def_fermi"),
        " による。両成分を比較して主張を得る。",
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
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/031_claim_psiの反交換関係.typ",
      ordinal: 32,
    },
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
[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}, \quad
[\psi_\mu, \psi_\nu]_+ = 0`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`\sqrt{\cdot}`),
        "（",
        ref("def_fermi"),
        " を通じて ",
        math(String.raw`\psi_\mu^\dagger, \psi_\mu`),
        " の係数に現れる）は ",
        ref("def_sqrt_cc"),
        " で定めた単一値の写像 ",
        math(String.raw`\sqrt{\cdot} : \mathbb{C} \to \mathbb{C}`),
        " である。すなわち、平方根は根号の中身だけで一意に定まる複素数であって、",
        math(String.raw`\mu`),
        " ごとに ",
        math(String.raw`\pm`),
        " を選ぶ自由度は無い。この一意性は主張の成立に不可欠であり、証明の Step 0 で明示的に使う。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0: 平方根の値が ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\nu`),
        " で一致すること（分枝の一致）。以下 ",
        math(String.raw`t_\mu := \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \in \mathbb{C}`),
        "、",
        math(String.raw`t_\nu := \sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} \in \mathbb{C}`),
        " と略記する。",
      ]),
      paragraph([
        "Step 0-1: ",
        math(String.raw`\gamma_2`),
        " は ",
        math(String.raw`2\pi`),
        " 周期である。実際 ",
        math(String.raw`k \in \mathbb{Z}`),
        " と ",
        math(String.raw`\theta \in \mathbb{R}`),
        " について ",
        math(String.raw`\cos(\theta + 2k\pi) = \cos\theta`),
        "、",
        math(String.raw`\sin(\theta + 2k\pi) = \sin\theta`),
        " であり、",
        ref("euler_formula_cos_sin"),
        " の Euler の公式 ",
        math(String.raw`e^{i\theta} = \cos\theta + i\sin\theta`),
        " より ",
        math(String.raw`e^{i(\theta + 2k\pi)} = e^{i\theta}`),
        "。",
        math(String.raw`\gamma_2(\theta) = i e^{i\theta} s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2)`),
        " は ",
        math(String.raw`e^{i\theta}, \cos\theta, \sin\theta`),
        " のみを通じて ",
        math(String.raw`\theta`),
        " に依存するから、",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta+2k\pi)
&=i e^{i(\theta+2k\pi)}s_2^*\bigl(c_1\cos(\theta+2k\pi)-i\sin(\theta+2k\pi)-s_1c_2\bigr)
&& (\because\ \gamma_2\ \text{の定義})\\
&=i e^{i\theta}s_2^*\bigl(c_1\cos\theta-i\sin\theta-s_1c_2\bigr)
&& (\because\ e^{i\theta},\cos\theta,\sin\theta\ \text{の}\ 2\pi\ \text{周期性})\\
&=\gamma_2(\theta)
&& (\because\ \gamma_2\ \text{の定義})
\end{aligned}`),
      paragraph([
        "Step 0-2: ",
        math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`),
        " のとき ",
        math(String.raw`\mu + \nu \equiv 0 \pmod{M}`),
        " すなわち ",
        math(String.raw`\nu = -\mu + kM`),
        " なる ",
        math(String.raw`k \in \mathbb{Z}`),
        " が存在する。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\theta_\nu
&=\dfrac{2\pi\nu}{M}
&& (\because\ \theta_\nu\ \text{の定義})\\
&=\dfrac{2\pi(-\mu+kM)}{M}
&& (\because\ \nu=-\mu+kM)\\
&=-\dfrac{2\pi\mu}{M}+2k\pi
&& (\because\ \mathbb{R}\ \text{の分配則と約分})\\
&=-\theta_\mu+2k\pi
&& (\because\ \theta_\mu\ \text{の定義})
\end{aligned}`),
      paragraph([
        "であるから、Step 0-1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\nu)
&=\gamma_2(-\theta_\mu+2k\pi)
&& (\because\ \theta_\nu=-\theta_\mu+2k\pi)\\
&=\gamma_2(-\theta_\mu)
&& (\because\ \gamma_2\ \text{の}\ 2\pi\ \text{周期性}),\\[3pt]
\gamma_2(-\theta_\nu)
&=\gamma_2(\theta_\mu-2k\pi)
&& (\because\ \theta_\nu=-\theta_\mu+2k\pi)\\
&=\gamma_2(\theta_\mu)
&& (\because\ \gamma_2\ \text{の}\ 2\pi\ \text{周期性})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\theta_\nu = -\theta_\mu + 2k\pi`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " における等式であって ",
        math(String.raw`\theta_\nu = -\theta_\mu`),
        " とは限らない。両者が ",
        math(String.raw`\gamma_2`),
        " の値として一致するのは、Step 0-1 の周期性による。）したがって根号の中身は ",
        math(String.raw`\mathbb{C}`),
        " の元として一致する：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)
&=\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)
&& (\because\ \text{上の二つの等式})\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \mathbb{C}\ \text{の積の可換則})
\end{aligned}`,
      ),
      paragraph([
        "Step 0-3: ",
        ref("def_sqrt_cc"),
        " の ",
        math(String.raw`\sqrt{\cdot}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " から ",
        math(String.raw`\mathbb{C}`),
        " への写像である。写像は等しい入力に等しい値を返すから、Step 0-2 の等式より",
      ]),
      displayMath(String.raw`\begin{aligned}
t_\nu
&=\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
&& (\because\ t_\nu\ \text{の定義})\\
&=\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
&& (\because\ \text{根号の中身について上で得た等式})\\
&=t_\mu
&& (\because\ t_\mu\ \text{の定義})
\end{aligned}`),
      paragraph([
        "すなわち ",
        math(String.raw`t_\nu`),
        " と ",
        math(String.raw`t_\mu`),
        " は同一の複素数である（",
        math(String.raw`t_\nu = -t_\mu`),
        " という可能性は残らない）。",
      ]),
      paragraph([
        "Step 0-4: この一致は結論に不可欠である。",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = -|\gamma_2(\theta_\mu)|^2`),
        " であり、仮定 ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " より ",
        math(String.raw`|\gamma_2(\theta_\mu)|^2 > 0`),
        " であるから",
      ]),
      displayMath(String.raw`\begin{aligned}
t_\mu^2
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ t_\mu\ \text{の定義と}\ (\sqrt{z})^2=z)\\
&=-|\gamma_2(\theta_\mu)|^2
&& (\because\ \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)=-|\gamma_2(\theta_\mu)|^2)\\
&\neq0_{\mathbb{C}}
&& (\because\ \gamma_2(\theta_\mu)\neq0\ \text{より}\ |\gamma_2(\theta_\mu)|^2>0),\\
t_\mu&\neq0_{\mathbb{C}}
&& (\because\ t_\mu=0_{\mathbb{C}}\ \text{ならば}\ t_\mu^2=0_{\mathbb{C}})
\end{aligned}`),
      paragraph([
        "後述の a) の係数の括弧は ",
        "次の一続きの式変形により因数分解できる。",
      ]),
      displayMath(String.raw`\begin{aligned}
-t_\mu t_\nu+\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)
&=-t_\mu t_\nu+\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)
&& (\because\ \text{Step 0-2})\\
&=t_\mu^2-t_\mu t_\nu
&& (\because\ t_\mu^2=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))\\
&=t_\mu(t_\mu-t_\nu)
&& (\because\ \mathbb{C}\ \text{の分配則})
\end{aligned}`),
      paragraph([
        "Step 0-3 の ",
        math(String.raw`t_\nu = t_\mu`),
        " によってのみ ",
        math(String.raw`0`),
        " になる。仮に ",
        math(String.raw`t_\nu = -t_\mu`),
        " であれば括弧は ",
        math(String.raw`2t_\mu^2 \neq 0`),
        " となり第 1 の等式は偽になる（同様に b) の括弧は ",
        math(String.raw`t_\mu t_\nu + t_\mu^2`),
        " で、",
        math(String.raw`t_\nu = -t_\mu`),
        " なら ",
        math(String.raw`0`),
        " となって第 2 の等式も偽になる）。",
      ]),
      paragraph([
        ref("def_fermi"),
        " より、",
        math(String.raw`c_\mu := \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\psi_\mu^\dagger &= c_\mu\bigl(+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\hat{Z}_\mu^{(-)} + \gamma_2(-\theta_\mu)\hat{Y}_\mu\bigr)
&&\left(\because\ \text{定義「フェルミオン」の}\ \psi_\mu^\dagger\ \text{の表示式で}\ c_\mu\ \text{を括り出した}\right)\\
\psi_\mu &= c_\mu\bigl(-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\hat{Z}_\mu^{(-)} + \gamma_2(-\theta_\mu)\hat{Y}_\mu\bigr)
&&\left(\because\ \text{定義「フェルミオン」の}\ \psi_\mu\ \text{の表示式で}\ c_\mu\ \text{を括り出した}\right)
\end{aligned}`,
      ),
      paragraph(["である。また、", ref("anticommutator_of_hat_Z_and_hat_Y"), " より、"]),
      displayMath(
        String.raw`[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ = 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}, \quad
[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ = 0, \quad
[\hat{Y}_\mu, \hat{Y}_\nu]_+ = 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}`,
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
\Bigr)
&& (\because\ \text{反交換子の双線型性と}\ \psi_\mu^\dagger,\psi_\nu^\dagger\ \text{の定義})\\
&= c_\mu c_\nu\bigl(-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{二つの交差項の反交換子は零であり、}\ i^2=-1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`),
        " のとき、Step 0-3 の ",
        math(String.raw`t_\nu = t_\mu`),
        "（平方根が単一値であることから従う分枝の一致）を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
&=t_\mu t_\nu
&& (\because\ t_\mu,t_\nu\ \text{の定義})\\
&=t_\mu^2
&& (\because\ \text{Step 0-3 の}\ t_\nu=t_\mu)\\
&=\bigl(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)^2
&& (\because\ t_\mu\ \text{の定義})\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ (\sqrt{z})^2=z)
\end{aligned}`,
      ),
      paragraph([
        "（第 2 の等号が Step 0-3 の ",
        math(String.raw`t_\nu = t_\mu`),
        " である。ここを ",
        math(String.raw`t_\nu = \pm t_\mu`),
        " までしか言えないと結論は得られない。）また Step 0-2 の ",
        math(String.raw`\gamma_2(-\theta_\nu) = \gamma_2(\theta_\mu)`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)
&=\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)
&& (\because\ \text{Step 0-2 の}\ \gamma_2(-\theta_\nu)=\gamma_2(\theta_\mu))\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \mathbb{C}\ \text{の積の可換則})
\end{aligned}`,
      ),
      paragraph(["したがって係数の和は"]),
      displayMath(
        String.raw`\begin{aligned}
&-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
+\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\\
&=-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
+\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{上の二つの式変形})\\
&=0
&& (\because\ \mathbb{C}\ \text{の加法逆元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} = 0`),
        " のときは、先に得た反交換子の式の因子が零なので、同じ結論を得る。以上から ",
        math(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+ = 0`), "。",
      ]),
      paragraph(["b) ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+`), " について、反交換子の双線型性より"]),
      displayMath(
        String.raw`\begin{aligned}
[\psi_\mu^\dagger, \psi_\nu]_+
&= c_\mu c_\nu\Bigl(
(i)(-i)\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\nu)[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ \\
&\quad + \gamma_2(-\theta_\mu)\,(-i)\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Y}_\mu, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)[\hat{Y}_\mu, \hat{Y}_\nu]_+
\Bigr)
&& (\because\ \text{反交換子の双線型性と}\ \psi_\mu^\dagger,\psi_\nu\ \text{の定義})\\
&= c_\mu c_\nu\bigl(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{二つの交差項の反交換子は零であり、}\ (i)(-i)=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`),
        " のとき、a) で示した平方根の積の式変形と ",
        math(String.raw`\gamma_2`),
        " の積の式変形を使うと、係数の括弧は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)
&& (\because\ \text{a) の平方根の積の式変形})\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{a) の}\ \gamma_2\ \text{の積の式変形})\\
&=2\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{同じ項の和})
\end{aligned}`,
      ),
      paragraph(["である。また係数の積は"]),
      displayMath(
        String.raw`\begin{aligned}
c_\mu c_\nu
&=\frac{1}{4M\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)}
&& (\because\ c_\mu,c_\nu\ \text{の定義と分数の積})\\
&=\frac{1}{4M\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)}
&& (\because\ \text{Step 0-2 の}\ \gamma_2(-\theta_\nu)=\gamma_2(\theta_\mu))\\
&=\frac{1}{4M\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
&& (\because\ \mathbb{C}\ \text{の積の可換則})
\end{aligned}`,
      ),
      paragraph(["であるから、"]),
      displayMath(
        String.raw`\begin{aligned}
[\psi_\mu^\dagger, \psi_\nu]_+
&= \frac{1}{4M\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot 2\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot 2M\cdot\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{上の三つの式変形})\\
&= \delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{約分})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} = 0`),
        " のときは、先に得た反交換子の式の因子が零なので、全体が ",
        math(String.raw`0`),
        " となり、同じ結論を得る。以上から ",
        math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "。",
      ]),
      paragraph([
        "c) ",
        math(String.raw`[\psi_\mu, \psi_\nu]_+`),
        " について、反交換子の双線型性より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\psi_\mu, \psi_\nu]_+
&= c_\mu c_\nu\Bigl(
(-i)(-i)\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + (-i)\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\nu)[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ \\
&\quad + \gamma_2(-\theta_\mu)\,(-i)\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Y}_\mu, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)[\hat{Y}_\mu, \hat{Y}_\nu]_+
\Bigr)
&& (\because\ \text{反交換子の双線型性と}\ \psi_\mu,\psi_\nu\ \text{の定義})\\
&= c_\mu c_\nu\bigl(-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{二つの交差項の反交換子は零であり、}\ (-i)(-i)=-1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`),
        " のとき、a) で示した二つの式変形を当てると、係数の括弧は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
+\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\\
&=-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
+\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{a) の平方根の積と}\ \gamma_2\ \text{の積の式変形})\\
&=0
&& (\because\ \mathbb{C}\ \text{の加法逆元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta^M_{\mu+\nu,0} = 0`),
        " のときは、先に得た反交換子の式の因子が零なので、全体が ",
        math(String.raw`0`),
        " となる。以上から ", math(String.raw`[\psi_\mu, \psi_\nu]_+ = 0`), "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(C^2)^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "現行ソースに再同期（定義域を γ2(θμ),γ2(θν)≠0 に限定）し、三つの反交換子の計算を全展開。",
        "2026-09-01 の式変形統一で、Step 0-2 の θ_ν の書き換え（1 行に等号 3 つ・根拠なし）を 4 段の行末根拠つきの鎖へ開いた。内容・参照は変えていない。",
        "原文（および本ブロックの旧版）は δ^M_{μ+ν,0} ≠ 0 のとき『θ_ν = -θ_μ』と書いて根号の中身を置き換えていたが、" +
          "μ+ν ≡ 0 (mod M) から従うのは θ_ν = -θ_μ + 2kπ（k ∈ Z）までであり、また根号の中身が等しいことだけからは " +
          "t_ν = ±t_μ しか従わない。Lean 側の形式化（Part008/Claim032_AnticommutatorPsiAbstract.lean）で、" +
          "t_ν = -t_μ（逆分枝）を取ると第 1 式・第 2 式がいずれも偽になることが定理として確認されている。" +
          "本リポジトリの √ は def_sqrt_cc で単一値の写像 C → C として定義されているので逆分枝は起こらないが、" +
          "その一意性を使っていることが statement にも proof にも書かれていなかった。" +
        "そこで (a) statement に『√ は def_sqrt_cc の単一値写像である』ことを明記し、" +
          "(b) proof に Step 0（γ_2 の 2π 周期性 → 根号の中身の一致 → 写像の一価性から t_ν = t_μ → " +
          "t_μ ≠ 0 ゆえ分枝の一致が不可欠であること）を追加した。主張そのものは変えていない。",
        "2026-08-12 の式変形統一で、a) の反交換子の双線型展開・平方根の積・γ₂ の積・係数の消去を一続きの鎖へ開き、各等号へ根拠を付けた。内容は変えていない。",
        "2026-08-12 の式変形統一で、b) の反交換子の双線型展開・係数の括弧・係数の積・最後の約分を一続きの鎖へ開き、各等号へ根拠を付けた。内容は変えていない。",
        "2026-08-12 の式変形統一で、c) の反交換子の双線型展開・交差項の消去・係数の括弧の消去を一続きの鎖へ開き、各等号へ根拠を付けた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_035_claim_det_A_theta",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/034_claim_det_A_theta_mu.typ",
      ordinal: 35,
    },
    title: { tex: String.raw`\det A(\theta_\mu) = 1` },
    labels: ["det_A_theta"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とする。",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\det A(\theta_\mu) = 1, \quad
\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = 1, \quad
\lambda_{+,\mu} \cdot \lambda_{-,\mu} = 1`,
      ),
    ],
    proof: [
      paragraph([
        "Step 0: 使う 3 つの関係式。",
        ref("def_transfer_matrix_symbols"),
        " の記号のもと、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とする。次の 3 つを使う。",
      ]),
      displayMath(
        String.raw`\text{(i)}\ c_1^2 - s_1^2 = 1, \qquad
\text{(ii)}\ (c_2^*)^2 - (s_2^*)^2 = 1, \qquad
\text{(iii)}\ c_2\, s_2^* = c_2^*`,
      ),
      paragraph([
        "(i) は ",
        math(String.raw`c_1 = \cosh 2K_1`),
        "、",
        math(String.raw`s_1 = \sinh 2K_1`),
        " と恒等式 ",
        math(String.raw`\cosh^2 x - \sinh^2 x = 1`),
        "（",
        math(String.raw`x = 2K_1`),
        "）による。(ii) は同じ恒等式を ",
        math(String.raw`x = 2K_2^*`),
        " に適用したものである。(iii) は ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " そのもの、すなわち ",
        math(String.raw`K_2`),
        " と ",
        math(String.raw`K_2^*`),
        " の双対関係 ",
        math(String.raw`\sinh(2K_2)\sinh(2K_2^*) = 1`),
        "（",
        ref("def_transfer_matrix_symbols"),
        "）の帰結 ",
        math(String.raw`c_2^* = s_2^*\,c_2`),
        " である。",
      ]),
      paragraph([
        "（(iii) は ",
        math(String.raw`A(\theta)`),
        " の定義に現れる ",
        math(String.raw`c_2`),
        " と ",
        math(String.raw`B_2`),
        " に現れる ",
        math(String.raw`c_2^*`),
        " を結ぶ関係であり、これを落とすと以下の計算は成立しない。",
        ref("factorization_of_A_theta"),
        " の分解 ",
        math(String.raw`A(\theta_\mu) = B_1(\theta_\mu)B_2B_1(\theta_\mu)`),
        " 自体がこの関係を経由して成り立っているので、ここでは分解を経由せず ",
        ref("def_A_theta"),
        " の定義から直接計算する。）",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\det A(\theta_\mu)`),
        " の定義からの計算。",
        ref("def_A_theta"),
        " より",
      ]),
      displayMath(
        String.raw`A(\theta_\mu) = \begin{pmatrix}
\gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\
-\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu)
\end{pmatrix}`,
      ),
      paragraph([math(String.raw`2 \times 2`), " 行列の行列式の定義より"]),
      displayMath(
        String.raw`\begin{aligned}
\det A(\theta_\mu)
&= \gamma_1(\theta_\mu)\cdot\gamma_1(\theta_\mu)
  - \gamma_2(\theta_\mu)\cdot\bigl(-\gamma_2(-\theta_\mu)\bigr)
&&\left(\because\ 2\times2\ \text{行列の行列式の定義と直前の行列表示}\right)\\
&= \gamma_1(\theta_\mu)^2
  - \bigl(-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)\bigr)
&&\left(\because\ \text{冪の定義と積の結合則}\right)\\
&= \gamma_1(\theta_\mu)^2
  + \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&&\left(\because\ a-(-b)=a+b\right)
\end{aligned}`,
      ),
      paragraph([
        "これで statement の第 1 の量と第 2 の量が等しいことが言えた。残りは、この値が ",
        math(String.raw`1`),
        " であることである。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)`),
        " の実部表示。以下 ",
        math(String.raw`u := \cos\theta_\mu \in \mathbb{R}`),
        "、",
        math(String.raw`v := \sin\theta_\mu \in \mathbb{R}`),
        " と略記する（",
        math(String.raw`u^2 + v^2 = 1`),
        "）。",
        ref("def_A_theta"),
        " の ",
        math(String.raw`\gamma_2`),
        " の定義より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\mu) &= i\,e^{i\theta_\mu}\,s_2^*\bigl((c_1 u - s_1 c_2) - i v\bigr)
&&\left(\because\ \text{\(\gamma_2\) の定義と \(u,v\) の略記}\right)\\
\gamma_2(-\theta_\mu) &= i\,e^{-i\theta_\mu}\,s_2^*\bigl((c_1 u - s_1 c_2) + i v\bigr)
&&\left(\because\ \cos(-\theta_\mu)=u,\ \sin(-\theta_\mu)=-v\right)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\cos(-\theta_\mu) = u`),
        "、",
        math(String.raw`\sin(-\theta_\mu) = -v`),
        " を代入した。）",
        math(String.raw`i \cdot i = -1`),
        " と ",
        math(String.raw`e^{i\theta_\mu}e^{-i\theta_\mu} = e^{0} = 1`),
        "、および ",
        math(String.raw`(a - iv)(a + iv) = a^2 + v^2`),
        "（",
        math(String.raw`a := c_1 u - s_1 c_2 \in \mathbb{R}`),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&=i^2e^{i\theta_\mu}e^{-i\theta_\mu}(s_2^*)^2
  \bigl((c_1u-s_1c_2)-iv\bigr)\bigl((c_1u-s_1c_2)+iv\bigr)
&&\left(\because\ \text{直前の 2 式の代入と積の結合則}\right)\\
&=-e^0(s_2^*)^2
  \bigl((c_1u-s_1c_2)-iv\bigr)\bigl((c_1u-s_1c_2)+iv\bigr)
&&\left(\because\ i^2=-1,\ e^{i\theta_\mu}e^{-i\theta_\mu}=e^0\right)\\
&=-(s_2^*)^2\Bigl((c_1u-s_1c_2)^2-(iv)^2\Bigr)
&&\left(\because\ e^0=1,\ (a-b)(a+b)=a^2-b^2\right)\\
&=-(s_2^*)^2\Bigl((c_1u-s_1c_2)^2+v^2\Bigr)
&&\left(\because\ (iv)^2=-v^2\right)\\
&=-(s_2^*)^2\Bigl((c_1u-s_1c_2)^2+1-u^2\Bigr)
&&\left(\because\ u^2+v^2=1\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 展開。",
        math(String.raw`\gamma_1(\theta_\mu) = c_1 c_2^* - s_1 s_2^* u`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2
&=\bigl(c_1c_2^*-s_1s_2^*u\bigr)^2
&&\left(\because\ \gamma_1(\theta_\mu)=c_1c_2^*-s_1s_2^*u\right)\\
&=c_1^2(c_2^*)^2-2c_1c_2^*s_1s_2^*u+s_1^2(s_2^*)^2u^2
&&\left(\because\ (a-b)^2=a^2-2ab+b^2\right)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&=-(s_2^*)^2\Bigl((c_1u-s_1c_2)^2+1-u^2\Bigr)
&&\left(\because\ \text{Step 2 の終点}\right)\\
&=-(s_2^*)^2\Bigl(c_1^2u^2-2c_1s_1c_2u+s_1^2c_2^2+1-u^2\Bigr)
&&\left(\because\ (a-b)^2=a^2-2ab+b^2\right)\\
&=-c_1^2(s_2^*)^2u^2+2c_1s_1c_2(s_2^*)^2u-s_1^2c_2^2(s_2^*)^2-(s_2^*)^2+(s_2^*)^2u^2
&&\left(\because\ \text{分配則}\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 4: (iii) による ",
        math(String.raw`c_2`),
        " の消去。(iii) ",
        math(String.raw`c_2 s_2^* = c_2^*`),
        " を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2 c_1 s_1 c_2 (s_2^*)^2 u
&=2 c_1 s_1 (c_2 s_2^*) s_2^* u
&&\left(\because\ (s_2^*)^2=s_2^*s_2^*\ \text{と積の結合則}\right)\\
&=2 c_1 s_1 c_2^* s_2^* u
&&\left(\because\ \text{(iii)}\ c_2s_2^*=c_2^*\right),\\[4pt]
s_1^2 c_2^2 (s_2^*)^2
&=s_1^2 (c_2 s_2^*)^2
&&\left(\because\ c_2^2(s_2^*)^2=(c_2s_2^*)^2\right)\\
&=s_1^2 (c_2^*)^2
&&\left(\because\ \text{(iii)}\ c_2s_2^*=c_2^*\right)
\end{aligned}`,
      ),
      paragraph(["これを代入して Step 3 の 2 式を足すと"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&= \bigl(c_1^2 (c_2^*)^2 - 2 c_1 c_2^* s_1 s_2^* u + s_1^2 (s_2^*)^2 u^2\bigr) \\
&\quad + \bigl(-c_1^2 (s_2^*)^2 u^2 + 2 c_1 s_1 c_2^* s_2^* u - s_1^2 (c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2 u^2\bigr)
&&\left(\because\ \text{Step 3 の 2 式と直前の}\ c_2\ \text{の消去}\right)\\
&= \bigl(c_1^2 - s_1^2\bigr)(c_2^*)^2 - (s_2^*)^2
 + (s_2^*)^2 u^2\bigl(s_1^2 - c_1^2 + 1\bigr)
&&\left(\because\ u\ \text{の 1 次の項を相殺し、残る項を分配則でまとめる}\right)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`u`),
        " の 1 次の項 ",
        math(String.raw`-2 c_1 c_2^* s_1 s_2^* u`),
        " と ",
        math(String.raw`+2 c_1 s_1 c_2^* s_2^* u`),
        " は相殺した。これが (iii) を使った箇所である。）",
      ]),
      paragraph([
        "Step 5: (i)(ii) による結論。(i) ",
        math(String.raw`c_1^2 - s_1^2 = 1`),
        " より ",
        math(String.raw`s_1^2 - c_1^2 + 1 = 0`),
        " であるから ",
        math(String.raw`u^2`),
        " の項は消え、同じく (i) より第 1 項は ",
        math(String.raw`(c_2^*)^2`),
        " になる。よって (ii) ",
        math(String.raw`(c_2^*)^2 - (s_2^*)^2 = 1`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&= (c_1^2-s_1^2)(c_2^*)^2-(s_2^*)^2
 +(s_2^*)^2u^2(s_1^2-c_1^2+1)
&&\left(\because\ \text{Step 4 の終点}\right)\\
&=(c_2^*)^2-(s_2^*)^2+(s_2^*)^2u^2(-1+1)
&&\left(\because\ \text{(i)}\ c_1^2-s_1^2=1\ \text{を 2 箇所へ適用}\right)\\
&=(c_2^*)^2-(s_2^*)^2+(s_2^*)^2u^2\cdot0
&&\left(\because\ -1+1=0\right)\\
&=(c_2^*)^2-(s_2^*)^2
&&\left(\because\ a\cdot0=0,\ b+0=b\right)\\
&=1
&&\left(\because\ \text{(ii)}\ (c_2^*)^2-(s_2^*)^2=1\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 1 と合わせて ",
        math(String.raw`\det A(\theta_\mu) = \gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 1`),
        "。",
      ]),
      paragraph([
        "Step 6: 固有値の積。",
        ref("eigenvector_of_A_theta"),
        " より ",
        math(String.raw`\lambda_{\pm,\mu} = \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`),
        " であり、",
        math(String.raw`(\sqrt{z})^2 = z`),
        "（",
        ref("def_sqrt_cc"),
        "）を ",
        math(String.raw`z = -\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)`),
        " に適用して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lambda_{+,\mu}\,\lambda_{-,\mu}
&=\left(\gamma_1(\theta_\mu)+\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\right)
  \left(\gamma_1(\theta_\mu)-\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\right)
&&\left(\because\ \lambda_{\pm,\mu}\ \text{の式を代入}\right)\\
&=\gamma_1(\theta_\mu)^2-\left(\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\right)^2
&&\left(\because\ (a+b)(a-b)=a^2-b^2\right)\\
&=\gamma_1(\theta_\mu)^2+\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&&\left(\because\ (\sqrt{z})^2=z,\ z=-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\right)\\
&=1
&&\left(\because\ \text{Step 5 の終点}\right)
\end{aligned}`,
      ),
      paragraph(["以上で statement の 3 つの等式がすべて示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（034_claim_det_A_theta_mu.typ）の証明は factorization_of_A_theta の分解 A = B_1 B_2 B_1 から " +
          "det A = (det B_1)^2 det B_2 = 1 を出すだけで、(a) det A を A(θ) の定義から計算した値 " +
          "γ_1^2 + γ_2(θ)γ_2(-θ) と結びつける段が無く、(b) その値が 1 になるのに必要な双対関係 c_2 s_2^* = c_2^* が " +
          "明示されていなかった（分解 A = B_1B_2B_1 の成立そのものにこの関係が埋め込まれている）。" +
          "実際 c_2 s_2^* = c_2^* を落とすと det A(θ_μ) は θ_μ に依存し 1 にならない（Lean 側 det_AMat / det_AMat_eq_one で確認済み）。" +
          "そこで証明を、def_A_theta の定義から直接 det を計算し、(i) c_1^2 - s_1^2 = 1、(ii) (c_2^*)^2 - (s_2^*)^2 = 1、" +
          "(iii) c_2 s_2^* = c_2^*（duality_c2_star_eq_s2_star_c2）の 3 関係を明示的に使う形へ書き直した。" +
          "2026-08-12 の式変形統一で、Step 5 の結論を Step 4 の終点から始まる 5 段の鎖へ開き、" +
          "(i) の同時適用・零元の計算・(ii) の適用を各行末の根拠として明示した。内容は変えていない。" +
          "続いて Step 6 の固有値の積を、固有値の式の代入・平方差・複素平方根の定義・Step 5 の終点という 4 段の鎖へ開き、各等号へ根拠を付けた。内容は変えていない。" +
        "また statement の残り 2 式（γ_1^2 + γ_2γ_2(-θ) = 1 と λ_+λ_- = 1）の証明も原文には無かったので補った。",
        "2026-08-12 の式変形統一で、Step 1 の行列式の計算を 3 段の一続きの鎖へ開き、各等号へ根拠を付けた。内容は変えていない。",
        "2026-08-12 の式変形統一で、Step 4 の c_2 の消去を二つの鎖へ分け、Step 3 の 2 式を足して整理する鎖にも各行の根拠を付けた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_036_claim_gamma1_geq_1",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/035_claim_gamma1_geq_1.typ",
      ordinal: 36,
    },
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
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2
&= 1 - \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&& (\because\ \blkref{det_A_theta})\\
&= 1 + |\gamma_2(\theta_\mu)|^2
&& (\because\ \blkref{relation_of_gamma_2})\\
&\geq 1
&& (\because\ |\gamma_2(\theta_\mu)|^2\geq 0)
\end{aligned}`),
      paragraph(["また、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)
&= c_1 c_2^* - s_1 s_2^*\cos\theta_\mu
&& (\because\ \gamma_1\ \text{の定義})\\
&\geq c_1 c_2^* - s_1 s_2^*
&& (\because\ \cos\theta_\mu\leq 1)\\
&> 0
&& (\because\ \cosh>\sinh\ \text{より}\ c_1c_2^*>s_1s_2^*)
\end{aligned}`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)
&\geq1
&& (\because\ \gamma_1(\theta_\mu)^2\geq1\ \text{かつ}\ \gamma_1(\theta_\mu)>0)
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-12 の式変形統一で、二乗の下界と正値性をそれぞれ一続きの鎖へ開き、全行へ根拠を付けた。内容は変えていない。",
        "2026-08-31 の式変形統一で、二つの既証明への参照を各等号の行末へ移し、結論の根拠も同じ行末の列へ揃えた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_034a_definition_gamma_theta_mu",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ",
      ordinal: 34,
    },
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
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ",
      ordinal: 34,
    },
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
        ref("det_A_theta"),
        " と ",
        ref("eigenvector_of_A_theta"),
        " より、",
        math(String.raw`\det A(\theta_\mu) = 1`),
        " と固有値の和・積から、",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda_{+,\mu}\lambda_{-,\mu}
&=\det A(\theta_\mu)
&&\bigl(\because\ \lambda_{+,\mu},\lambda_{-,\mu}\ \text{は}\ A(\theta_\mu)\ \text{の固有値}\bigr)\\
&=1
&&\bigl(\because\ \det A(\theta_\mu)=1\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\lambda_{+,\mu}+\lambda_{-,\mu}
&=2\gamma_1(\theta_\mu)
&&\bigl(\because\ \lambda_{\pm,\mu}=\gamma_1(\theta_\mu)\pm\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)\\
&\geq2
&&\bigl(\because\ \gamma_1(\theta_\mu)\geq1\bigr)\\
&>0
&&\bigl(\because\ 2>0\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\lambda_{+,\mu}&>0,\qquad \lambda_{-,\mu}>0
&&\bigl(\because\ \lambda_{+,\mu}\lambda_{-,\mu}>0\ \text{かつ}\ \lambda_{+,\mu}+\lambda_{-,\mu}>0\bigr)\\
\gamma(\theta_\mu)&\geq0
&&\bigl(\because\ \gamma(\theta_\mu)=\operatorname{arccosh}(\gamma_1(\theta_\mu))\in\mathbb{R}_{\geq0}\bigr)\\
\lambda_{\pm,\mu}&=e^{\pm\gamma(\theta_\mu)}
&&\bigl(\because\ \text{正の二固有値を相反する指数として書く}\bigr)\\
\cosh(\gamma(\theta_\mu))&=\gamma_1(\theta_\mu)
&&\bigl(\because\ \gamma(\theta_\mu)\ \text{の定義}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-12 の式変形統一で、固有値の積・和から指数表示と arccosh の整合性へ至る既存の内容を一続きの式へまとめ、全行へ根拠を付けた。内容は変えていない。",
        "2026-08-31 の式変形統一で、三本の式変形にある根拠 9 行を他の証明と同じ行末の根拠列へ揃えた。内容・式変形・参照は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_033_definition_Vprime",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/032_definition_Vprimeの定義.typ",
      ordinal: 33,
    },
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
    ],
    proof: [],
    conversion: {
      status: "converted",
      notes: [
        "現行ソースに再同期：V' の和を γ2(θμ)≠0 なる μ∈{1,...,M} に限定し、限定理由（臨界点 μ=M の除外と γ(θμ)=0）およびホロノミック量子場との相違の注を反映。",
        "和の範囲を限定してよい理由（除外される μ では γ(θμ)=0 で寄与しない）は定義の妥当性そのものなので statement へ格上げした。" +
          "ホロノミック量子場の定義との比較は notes/008_TV1_hatZ_hatY.ts へ移設。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_038_claim_action_T_Vprime_psi",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/037_claim_T_Vprimeのpsiへの作用.typ",
      ordinal: 38,
    },
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
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
X(-X)
&=-X^2
&&(\because\ \text{スカラー }-1\text{ を積の外へ出す})\\
&=(-X)X
&&(\because\ \text{同じ }X\text{ どうしの積})
\end{aligned}`,
      ),
      paragraph([
        "なので可換である。したがって ",
        ref("theorem_exp_product"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(X)\exp(-X)
&=\exp(X+(-X))
&&(\because\ \text{指数行列の積の定理})\\
&=\exp(O)
&&(\because\ X+(-X)=O)\\
&=I
&&(\because\ \text{零行列の指数行列})
\end{aligned}`,
      ),
      paragraph([
        "故に ",
        math(String.raw`V'^{-1} = \exp(-X)`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V')}(\psi_\mu^\dagger)
&=V'\psi_\mu^\dagger V'^{-1}
&&(\because\ T_{(V')}\ \text{の定義})\\
&=\exp(X)\psi_\mu^\dagger\exp(-X)
&&(\because\ V'=\exp(X),\ V'^{-1}=\exp(-X))
\end{aligned}`,
      ),
      paragraph(["Step 1: ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger] = \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
\psi_\nu^\dagger \psi_{-\nu}\psi_\mu^\dagger
&= \psi_\nu^\dagger(\delta^M_{\mu-\nu,0}\,I - \psi_\mu^\dagger\psi_{-\nu})
&& (\because [\psi_{-\nu}, \psi_\mu^\dagger]_+ = \delta^M_{\mu-\nu,0}\,I) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger I
   - \psi_\nu^\dagger\psi_\mu^\dagger\psi_{-\nu}
&& (\because \text{分配則}) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
   - \psi_\nu^\dagger\psi_\mu^\dagger\psi_{-\nu}
&& (\because \psi_\nu^\dagger I=\psi_\nu^\dagger) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
   - (-\psi_\mu^\dagger\psi_\nu^\dagger)\psi_{-\nu}
&& (\because [\psi_\nu^\dagger, \psi_\mu^\dagger]_+ = 0) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
   + \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}
&& (\because \text{加法逆元の符号則})
\end{aligned}`,
      ),
      paragraph(["（反交換関係は ", ref("anticommutator_of_psi"), " による）。ゆえに"]),
      displayMath(
        String.raw`\begin{aligned}
[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger]
&= \psi_\nu^\dagger \psi_{-\nu}\psi_\mu^\dagger
   - \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}
&& (\because \text{交換子の定義}) \\
&= (\delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
   + \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu})
   - \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}
&& (\because \text{直前の式変形}) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
&& (\because \text{加法逆元による相殺})
\end{aligned}`,
      ),
      paragraph(["Step 2: ", math(String.raw`[X, \psi_\mu^\dagger] = +\gamma(\theta_\mu)\psi_\mu^\dagger`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
[X, \psi_\mu^\dagger]
&= +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\,[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger]
&&(\because\ \text{scalar\_identity\_commutes})\\
&= +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\,\delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
&&(\because\ \text{Step 1})
\end{aligned}`,
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
&= i\,e^{i\theta_{M-k}}s_2^*(c_1\cos\theta_{M-k} - i\sin\theta_{M-k} - s_1 c_2)
&&(\because\ \gamma_2\ \text{の定義})\\
&= i\,e^{-i\theta_k}s_2^*(c_1\cos\theta_k + i\sin\theta_k - s_1 c_2)
&&(\because\ e^{i\theta_{M-k}} = e^{-i\theta_k},\ \cos\theta_{M-k} = \cos\theta_k,\ \sin\theta_{M-k} = -\sin\theta_k)\\
&= \gamma_2(-\theta_k)
&&(\because\ \gamma_2\ \text{の定義に}\ -\theta_k\ \text{を代入した形})\\
&= \gamma_2(\theta_{-k})
&&(\because\ \theta_{-k} = -\theta_k)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(-\theta_{M-k})
&= i\,e^{-i\theta_{M-k}}s_2^*(c_1\cos\theta_{M-k} + i\sin\theta_{M-k} - s_1 c_2)
&&(\because\ \gamma_2\ \text{の定義に}\ -\theta_{M-k}\ \text{を代入した形})\\
&= i\,e^{i\theta_k}s_2^*(c_1\cos\theta_k - i\sin\theta_k - s_1 c_2)
&&(\because\ e^{-i\theta_{M-k}} = e^{i\theta_k},\ \cos\theta_{M-k} = \cos\theta_k,\ \sin\theta_{M-k} = -\sin\theta_k)\\
&= \gamma_2(\theta_k)
&&(\because\ \gamma_2\ \text{の定義})\\
&= \gamma_2(-\theta_{-k})
&&(\because\ -\theta_{-k} = \theta_k)
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
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
X\psi_\mu^\dagger
&=\psi_\mu^\dagger X+\gamma(\theta_\mu)\psi_\mu^\dagger
&&(\because\ [X,\psi_\mu^\dagger]=\gamma(\theta_\mu)\psi_\mu^\dagger\ \text{と交換子の定義})\\
&=\psi_\mu^\dagger X+\psi_\mu^\dagger\gamma(\theta_\mu)I
&&(\because\ \gamma(\theta_\mu)\ \text{はスカラー})\\
&=\psi_\mu^\dagger\bigl(X+\gamma(\theta_\mu)I\bigr)
&&(\because\ \text{分配則})
\end{aligned}`,
      ),
      paragraph(["Step 3: 帰納法で ", math(String.raw`X^n \psi_\mu^\dagger = \psi_\mu^\dagger (X + \gamma(\theta_\mu)I)^n`), " を示す。", math(String.raw`n = 0`), " のときは"]),
      displayMath(
        String.raw`\begin{aligned}
X^0\psi_\mu^\dagger
&= I\psi_\mu^\dagger
&&(\because\ \text{冪の定義}\ X^0 = I)\\
&= \psi_\mu^\dagger
&&(\because\ \text{単位行列との積})\\
&= \psi_\mu^\dagger I
&&(\because\ \text{単位行列との積})\\
&= \psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^0
&&(\because\ \text{冪の定義}\ (X + \gamma(\theta_\mu)I)^0 = I)
\end{aligned}`,
      ),
      paragraph(["で成立する。", math(String.raw`n`), " で成立すると仮定すると"]),
      displayMath(
        String.raw`\begin{aligned}
X^{n+1}\psi_\mu^\dagger
&= (X\cdot X^n)\psi_\mu^\dagger
&&(\because\ \text{冪の定義})\\
&= X\cdot(X^n\psi_\mu^\dagger)
&&(\because\ \text{積の結合則})\\
&= X\cdot\bigl(\psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^n\bigr)
&&(\because\ \text{帰納法の仮定})\\
&= (X\psi_\mu^\dagger)\cdot(X + \gamma(\theta_\mu)I)^n
&&(\because\ \text{積の結合則})\\
&= \bigl(\psi_\mu^\dagger(X + \gamma(\theta_\mu)I)\bigr)\cdot(X + \gamma(\theta_\mu)I)^n
&&(\because\ \text{Step 2 のまとめ})\\
&= \psi_\mu^\dagger\bigl((X + \gamma(\theta_\mu)I)\cdot(X + \gamma(\theta_\mu)I)^n\bigr)
&&(\because\ \text{積の結合則})\\
&= \psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^{n+1}
&&(\because\ \text{冪の定義})
\end{aligned}`,
      ),
      paragraph(["となるから、全 ", math(String.raw`n \geq 0`), " で成立する。"]),
      paragraph(["Step 4: ", math(String.raw`\exp(X)\psi_\mu^\dagger = \psi_\mu^\dagger \exp(X + \gamma(\theta_\mu)I)`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{n=0}^N \frac{X^n}{n!}\,\psi_\mu^\dagger
&= \sum_{n=0}^N \frac{X^n\psi_\mu^\dagger}{n!}
&& (\because\ \text{有限和の各項へ右から }\psi_\mu^\dagger\text{ を掛ける})\\
&= \sum_{n=0}^N \frac{\psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^n}{n!}
&& (\because\ \text{Step 3})\\
&= \psi_\mu^\dagger \sum_{n=0}^N \frac{(X + \gamma(\theta_\mu)I)^n}{n!}
&& (\because\ \text{有限和に対する分配則})
\end{aligned}`,
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
&= \exp(X)\psi_\mu^\dagger\exp(-X)
&&(\because\ \text{証明冒頭の鎖})\\
&= \psi_\mu^\dagger\exp(X + \gamma(\theta_\mu)I)\exp(-X)
&&(\because\ \text{Step 4})\\
&= \psi_\mu^\dagger\exp((X + \gamma(\theta_\mu)I) + (-X))
&&(\because\ \text{指数行列の積の定理})\\
&= \psi_\mu^\dagger\exp(\gamma(\theta_\mu)I)
&&(\because\ (X + \gamma(\theta_\mu)I) + (-X) = \gamma(\theta_\mu)I)\\
&= \psi_\mu^\dagger\cdot e^{\gamma(\theta_\mu)}I
&&(\because\ (\gamma(\theta_\mu)I)^n = (\gamma(\theta_\mu))^n I)\\
&= e^{+\gamma(\theta_\mu)}\psi_\mu^\dagger
&&(\because\ \text{単位行列とのスカラー倍の積})
\end{aligned}`,
      ),
      paragraph([math(String.raw`T_{(V')}(\psi_\mu) = e^{-\gamma(\theta_\mu)}\psi_\mu`), " について。"]),
      paragraph(["Step 1': ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu] = -\delta^M_{\nu+\mu,0}\,\psi_{-\nu}`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
\psi_\nu^\dagger \psi_{-\nu}\psi_\mu
&= \psi_\nu^\dagger(-\psi_\mu\psi_{-\nu})
&&(\because\ [\psi_{-\nu},\psi_\mu]_+=0)\\
&= -\psi_\nu^\dagger\psi_\mu\psi_{-\nu}
&&(\because\ \text{スカラー倍と行列の積の結合則})\\
&= -(\delta^M_{\nu+\mu,0}\,I-\psi_\mu\psi_\nu^\dagger)\psi_{-\nu}
&&(\because\ [\psi_\nu^\dagger,\psi_\mu]_+=\delta^M_{\nu+\mu,0}\,I)\\
&= -\delta^M_{\nu+\mu,0}\,I\psi_{-\nu}+\psi_\mu\psi_\nu^\dagger\psi_{-\nu}
&&(\because\ \text{分配則})\\
&= -\delta^M_{\nu+\mu,0}\,\psi_{-\nu}+\psi_\mu\psi_\nu^\dagger\psi_{-\nu}
&&(\because\ I\psi_{-\nu}=\psi_{-\nu})
\end{aligned}`,
      ),
      paragraph(["（反交換関係は ", ref("anticommutator_of_psi"), " による）。ゆえに ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu] = -\delta^M_{\nu+\mu,0}\,\psi_{-\nu}`), "。"]),
      paragraph(["Step 2': ", math(String.raw`[X, \psi_\mu] = -\gamma(\theta_\mu)\psi_\mu`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
[X,\psi_\mu]
&=\left[\sum_{\substack{\nu\in\{1,\dots,M\}\\\gamma_2(\theta_\nu)\neq0}}
\gamma(\theta_\nu)\psi_\nu^\dagger\psi_{-\nu},\,\psi_\mu\right]
&&(\because\ X\ \text{の定義})\\
&=\sum_{\substack{\nu\in\{1,\dots,M\}\\\gamma_2(\theta_\nu)\neq0}}
\gamma(\theta_\nu)[\psi_\nu^\dagger\psi_{-\nu},\psi_\mu]
&&(\because\ \text{交換子の有限和とスカラー倍への分配則})\\
&=-\sum_{\substack{\nu\in\{1,\dots,M\}\\\gamma_2(\theta_\nu)\neq0}}
\gamma(\theta_\nu)\delta^M_{\nu+\mu,0}\psi_{-\nu}
&&(\because\ \text{Step 1'})
\end{aligned}`,
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
&= \exp(X)\psi_\mu\exp(-X)
&&(\because\ \text{証明冒頭の鎖})\\
&= \psi_\mu\exp(X-\gamma(\theta_\mu)I)\exp(-X)
&&(\because\ \text{Steps 3'--4'})\\
&= \psi_\mu\exp((X-\gamma(\theta_\mu)I)+(-X))
&&(\because\ \text{指数行列の積の定理})\\
&= \psi_\mu\exp(-\gamma(\theta_\mu)I)
&&(\because\ (X-\gamma(\theta_\mu)I)+(-X)=-\gamma(\theta_\mu)I)\\
&= \psi_\mu\cdot e^{-\gamma(\theta_\mu)}I
&&(\because\ (-\gamma(\theta_\mu)I)^n=(-\gamma(\theta_\mu))^nI)\\
&= e^{-\gamma(\theta_\mu)}\psi_\mu
&&(\because\ \text{単位行列とのスカラー倍の積})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "現行ソースに再同期（X の和を γ2(θν)≠0 に限定）し、Step 1-5（ψ^†）と Step 1'-2'（ψ）の場合分け・周期性・帰納法・exp 極限を全展開。Steps 3'-5' は符号反転で同様として簡潔化（ソースも同様）。",
        "2026-08-12 の式変形統一で、証明冒頭の X と -X の可換性、指数行列の積、共役作用の定義を 2 段・3 段・2 段の鎖へ開き、全行へ根拠を付けた。内容は変えていない。次は Step 1 から続ける。",
        "2026-08-12 の式変形統一で Step 1 の二つの計算を一行一等号へ分け、分配・単位行列・反交換・交換子定義・相殺の根拠を各行へ付けた。内容は変えていない。次は Step 2 から続ける。",
        "2026-08-13 の式変形統一で、Step 2 の冒頭の交換子の和（1 表示に等号 2 つ）を一行一等号の二段へ、場合 b) の γ₂ の周期性の二本（1 行に等号 3 つ・根拠なし）を代入を明示した四段の鎖二本へ開き、各行末へ根拠を付けた。内容は変えていない。次は Step 2 の残り（場合分け a〜c の散文中の等式）か Step 3 から続ける。",
        "2026-08-13 の式変形統一で、Step 2 の X と生成演算子の積を反対側へ移す結論を一行一等号の三段へ開き、交換子の定義・スカラーの交換・分配則を各行に明示した。内容は変えていない。次は同じ証明の Step 3 から続ける。",
        "2026-08-13 の式変形統一で、Step 3 の帰納法を直した。出発点（1 行に等号 2 つ・根拠なし）を四段の鎖へ、帰納法の一歩（根拠のない 2 行と、結合則と Step 2 を一段にまとめた 1 行）を七段の鎖へ開き、各行末へ根拠を付けた。内容は変えていない。次は Step 4 から続ける。",
        "2026-08-13 の式変形統一で、Step 4 の有限和の等式三つを一行一等号の鎖へ開き、各項への右作用・Step 3・有限和への分配則を各行末に明示した。内容は変えていない。次は Step 5 から続ける。",
        "2026-08-13 の式変形統一で、Step 5 の結論の鎖（根拠のない行が三つ、根拠の書式も不揃い）を一行一等号の六段へ整え、証明冒頭の鎖・Step 4・指数行列の積の定理・行列の和の相殺・スカラー行列の指数・単位行列とのスカラー倍の積を各行末に明示した。内容は変えていない。次は Step 1' 以降の ψ 側から続ける。",
        "2026-08-13 の式変形統一で、Step 1' の反交換計算を五段、Step 2' の交換子の有限和を三段、Steps 3'--5' の結論を六段の一行一等号へ整え、各行末に根拠を明示した。内容は変えていない。これでこの証明ブロックの式変形統一は完了した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_045_claim_A_theta_is_identity",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/044_claim_gamma2_0のときA_thetaは単位行列.typ",
      ordinal: 45,
    },
    title: { tex: String.raw`\gamma_2(\theta_\mu) = 0 \text{ のとき } A(\theta_\mu) = I` },
    labels: ["A_theta_is_identity_when_gamma2_zero"],
    statement: [
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。", math(String.raw`\mu \in \mathcal{M}`), " が ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " を満たすとき、"]),
      displayMath(String.raw`A(\theta_\mu) = I \quad (2 \times 2 \text{ 単位行列})`),
    ],
    proof: [
      paragraph([math(String.raw`\gamma_2(\theta_\mu) = 0`), " を満たす ", math(String.raw`\mu \in \mathcal{M}`), " を固定する。以下で引く関係式は ", ref("relation_of_gamma_2"), "、", ref("det_A_theta"), "、", ref("gamma1_geq_1"), "、", ref("def_A_theta"), " である。"]),
      paragraph(["Step 1: ", math(String.raw`\gamma_2(-\theta_\mu) = 0`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(-\theta_\mu)
&= -\overline{\gamma_2(\theta_\mu)}
&&(\because\ \gamma_2 \text{ の対称性 } \gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}) \\
&= -\overline{0}
&&(\because\ \gamma_2(\theta_\mu) = 0) \\
&= 0
&&(\because\ \overline{0} = 0,\ -0 = 0)
\end{aligned}`,
      ),
      paragraph(["Step 2: ", math(String.raw`\gamma_1(\theta_\mu) = 1`), "。"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2
&= 1 - \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&&(\because\ \det A(\theta_\mu) = 1 \text{ の等式 } \gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 1 \text{ を移項}) \\
&= 1 - 0 \cdot 0
&&(\because\ \gamma_2(\theta_\mu) = 0,\ \text{Step 1}) \\
&= 1
&&(\because\ 0 \cdot 0 = 0,\ 1 - 0 = 1)
\end{aligned}`,
      ),
      paragraph([ref("gamma1_geq_1"), " より ", math(String.raw`\gamma_1(\theta_\mu) \geq 1 > 0`), " であるから、", math(String.raw`\gamma_1(\theta_\mu)^2 = 1`), " と合わせて ", math(String.raw`\gamma_1(\theta_\mu) = 1`), " を得る。"]),
      paragraph([
        "Step 3: ",
        math(String.raw`A(\theta_\mu) = I`),
        "。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\theta_\mu)
&= \begin{pmatrix} \gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) \end{pmatrix}
&&(\because\ \det A(\theta_\mu) = 1 \text{ の証明中の成分表示。} A(\theta_\mu) \text{ の各成分の } \gamma_1, \gamma_2 \text{ による書き換え}) \\
&= \begin{pmatrix} 1 & 0 \\ -0 & 1 \end{pmatrix}
&&(\because\ \gamma_2(\theta_\mu) = 0,\ \text{Step 1, Step 2}) \\
&= \begin{pmatrix} 1 & 0 \\ 0 & 1 \end{pmatrix}
&&(\because\ -0 = 0) \\
&= I
&&(\because\ 2 \times 2 \text{ 単位行列の定義})
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_042_claim_T_Vprime_fixes_hatZ_hatY_gamma2_zero",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/041_claim_T_VprimeのhatZ_hatYへの作用_gamma2が0の場合.typ",
      ordinal: 42,
    },
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
        math(String.raw`W \in \mathrm{Mat}(2^M,\mathbb{C})`),
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
        String.raw`\begin{aligned}
\gamma_1(\theta_\nu)^2
&= 1 - \gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)
&& (\because\ \det A(\theta_\nu)=1) \\
&= 1 - 0\cdot\gamma_2(-\theta_\nu)
&& (\because\ \gamma_2(\theta_\nu)=0) \\
&= 1
&& (\because\ 0\cdot\gamma_2(-\theta_\nu)=0)
\end{aligned}`,
      ),
      paragraph([
        ref("gamma1_geq_1"),
        " より ",
        math(String.raw`\gamma_1(\theta_\nu) \geq 1 > 0`),
        " であるから ",
        math(String.raw`\gamma_1(\theta_\nu) = 1`),
        "。ここで ",
        math(String.raw`\gamma(\theta_\nu)`),
        " の定義は ",
        ref("def_gamma_theta_mu"),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma(\theta_\nu)
&= \mathrm{arccosh}(\gamma_1(\theta_\nu))
&& (\because\ \gamma(\theta_\nu)\text{ の定義}) \\
&= \mathrm{arccosh}(1)
&& (\because\ \gamma_1(\theta_\nu)=1) \\
&= 0
&& (\because\ \mathrm{arccosh}(1)=0)
\end{aligned}`,
      ),
      paragraph(["である。"]),
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
\psi_\nu^\dagger
&= c_\nu\bigl(+i\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}\,\hat{Z}_\nu^{(-)} + \gamma_2(-\theta_\nu)\hat{Y}_\nu\bigr)
&& (\because\ \text{フェルミオンの定義と }c_\nu\text{ の定義}) \\
\psi_{-\nu}
&= c_{-\nu}\bigl(-i\sqrt{\gamma_2(\theta_{-\nu})\gamma_2(-\theta_{-\nu})}\,\hat{Z}_{-\nu}^{(-)} + \gamma_2(-\theta_{-\nu})\hat{Y}_{-\nu}\bigr)
&& (\because\ \text{フェルミオンの定義と }c_{-\nu}\text{ の定義})
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
[\psi_\nu^\dagger, \hat{Z}_\mu^{(-)}]_+
&= c_\nu\bigl(+i\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I
&& (\because\ \text{フェルミオンの表示、反交換子の双線型性、}\ [\hat Z_\nu^{(-)},\hat Y_\mu]_+=0) \\
[\psi_{-\nu}, \hat{Z}_\mu^{(-)}]_+
&= c_{-\nu}\bigl(-i\sqrt{\gamma_2(\theta_{-\nu})\gamma_2(-\theta_{-\nu})}\bigr)\cdot 2M\delta^M_{\mu-\nu,0}\,I
&& (\because\ \text{フェルミオンの表示、反交換子の双線型性、}\ [\hat Z_{-\nu}^{(-)},\hat Y_\mu]_+=0) \\
[\psi_\nu^\dagger, \hat{Y}_\mu]_+
&= c_\nu\,\gamma_2(-\theta_\nu)\cdot 2M\delta^M_{\mu+\nu,0}\,I
&& (\because\ \text{フェルミオンの表示、反交換子の双線型性、}\ [\hat Z_\nu^{(-)},\hat Y_\mu]_+=0) \\
[\psi_{-\nu}, \hat{Y}_\mu]_+
&= c_{-\nu}\,\gamma_2(-\theta_{-\nu})\cdot 2M\delta^M_{\mu-\nu,0}\,I
&& (\because\ \text{フェルミオンの表示、反交換子の双線型性、}\ [\hat Z_{-\nu}^{(-)},\hat Y_\mu]_+=0)
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
        String.raw`\begin{aligned}
[\psi_\nu^\dagger \psi_{-\nu}, W]
&= \psi_\nu^\dagger[\psi_{-\nu}, W]_+ - [\psi_\nu^\dagger, W]_+\psi_{-\nu}
&& (\because\ \text{積の交換子を反交換子で表す恒等式}) \\
&= \psi_\nu^\dagger O - O\psi_{-\nu}
&& (\because\ [\psi_{-\nu},W]_+=O,\ [\psi_\nu^\dagger,W]_+=O) \\
&= O
&& (\because\ AO=OA=O)
\end{aligned}`,
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
        String.raw`\begin{aligned}
X^{n+1}W
&= X\cdot X^n W
&& (\because\ X^{n+1}=X\cdot X^n) \\
&= X\cdot W X^n
&& (\because\ X^nW=WX^n) \\
&= (XW)X^n
&& (\because\ \text{行列積の結合則}) \\
&= (WX)X^n
&& (\because\ XW=WX) \\
&= W X^{n+1}
&& (\because\ \text{行列積の結合則と }X^{n+1}=X\cdot X^n)
\end{aligned}`,
      ),
      paragraph([math(String.raw`n = 0`), " で ", math(String.raw`X^0 W = W = W X^0`), " だから全 ", math(String.raw`n \geq 0`), " で成立する。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{n=0}^N \frac{X^n}{n!}\right)W
&= \sum_{n=0}^N \frac{X^n W}{n!}
&& (\because\ \text{行列積の有限和に関する分配則}) \\
&= \sum_{n=0}^N \frac{W X^n}{n!}
&& (\because\ X^nW=WX^n) \\
&= W\left(\sum_{n=0}^N \frac{X^n}{n!}\right)
&& (\because\ \text{行列積の有限和に関する分配則})
\end{aligned}`,
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
        String.raw`\begin{aligned}
T_{(V')}(W)
&= \exp(X)W\exp(-X)
&& (\because\ T_{(V')}\text{ の定義}) \\
&= W\exp(X)\exp(-X)
&& (\because\ \exp(X)W=W\exp(X)) \\
&= WI
&& (\because\ \exp(X)\exp(-X)=I) \\
&= W
&& (\because\ I\text{ は単位行列})
\end{aligned}`,
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
      notes: [
        "現行ソース（Phase-1 で規約撤去・場合分け簡約済み）を Step 1-4 まで忠実に翻訳。",
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(C^2)^{⊗M}} を 2^M 次の" +
          "単位行列 I_{Mat(2^M,C)} へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-08-13 の式変形統一で、Step 3 の準備に残っていたフェルミオンの表示二式と、そこから得る反交換子四式へ行末根拠を付けた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_043_claim_T_V_eq_T_Vprime_on_hatZ_hatY",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/042_claim_T_VとT_VprimeはhatZ_hatY上で一致.typ",
      ordinal: 43,
    },
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
      paragraph([
        "である。まず ",
        math(String.raw`P_\mu`),
        " が可逆であることを示す。準備として、",
        ref("relation_of_gamma_2"),
        " より ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0 \iff \gamma_2(-\theta_\mu) \neq 0`),
        "、ゆえ ",
        math(String.raw`\gamma_2(-\theta_\mu) \neq 0`),
        " かつ ",
        math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) \neq 0`),
        " かつ ",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \neq 0`),
        "（",
        ref("square_of_sqrt"),
        " より ",
        math(String.raw`(\sqrt{z})^2 = z \neq 0`),
        " ゆえ ",
        math(String.raw`\sqrt{z} \neq 0`),
        "）である。行列式は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\det P_\mu
&= \frac{1}{(2\sqrt{M}\,\gamma_2(-\theta_\mu))^2}\Bigl((+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})\gamma_2(-\theta_\mu) - (-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})\gamma_2(-\theta_\mu)\Bigr)
\quad (\because P_\mu \text{ \u306e\u5b9a\u7fa9\u3068 }2\times2\text{ \u884c\u5217\u306e\u884c\u5217\u5f0f}) \\
&= \frac{1}{(2\sqrt{M}\,\gamma_2(-\theta_\mu))^2}\cdot 2i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu)
\quad (\because \text{\u5206\u914d\u5f8b\u3068\u7b26\u53f7\u306e\u8a08\u7b97}) \\
&= \frac{2i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu)}{4M\,\gamma_2(-\theta_\mu)^2}
\quad (\because (2\sqrt{M}\,\gamma_2(-\theta_\mu))^2 = 4M\,\gamma_2(-\theta_\mu)^2\text{。}(\sqrt{M})^2 = M\text{ は }\text{square\_of\_sqrt}) \\
&= \frac{i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2M\,\gamma_2(-\theta_\mu)}
\quad (\because \gamma_2(-\theta_\mu)\neq0\text{ による共通因子 }2\gamma_2(-\theta_\mu)\text{ の約分})
\end{aligned}`,
      ),
      paragraph([
        "である。分子は ",
        math(String.raw`i \neq 0`),
        " と ",
        math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \neq 0`),
        "（準備）の積なので零でなく、分母 ",
        math(String.raw`2M\,\gamma_2(-\theta_\mu)`),
        " も零でない。よって ",
        math(String.raw`\det P_\mu \neq 0`),
        " であり ",
        math(String.raw`P_\mu`),
        " は可逆である。",
      ]),
      paragraph([math(String.raw`P_\mu^{-1} = \begin{pmatrix} q_{11} & q_{12} \\ q_{21} & q_{22} \end{pmatrix}`), "（各 ", math(String.raw`q_{ij} \in \mathbb{C}`), "）とおくと、"]),
      displayMath(
        String.raw`\begin{aligned}
\bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) I
\quad (\because \text{単位行列との積}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) (P_\mu P_\mu^{-1})
\quad (\because P_\mu P_\mu^{-1}=I) \\
&= \left(\bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu\right) P_\mu^{-1}
\quad (\because \text{行列の積の結合則}) \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix} P_\mu^{-1}
\quad (\because \text{def\_fermi}) \\
&= \begin{pmatrix} q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu & q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu \end{pmatrix}
\quad (\because 1\times2\text{ 行列と }2\times2\text{ 行列の積の定義})
\end{aligned}`,
      ),
      paragraph(["すなわち ", math(String.raw`\hat{Z}_\mu^{(-)} = q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu`), "、", math(String.raw`\hat{Y}_\mu = q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu`), " である。一方、", ref("commutation_V_psi"), " と ", ref("lambda_eq_exp_gamma"), " より"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(\psi_\mu^\dagger)
&= \lambda_{+,\mu}\psi_\mu^\dagger
\quad (\because \text{フェルミオン生成演算子への作用}) \\
&= e^{\gamma(\theta_\mu)}\psi_\mu^\dagger
\quad (\because \lambda_{+,\mu}=e^{\gamma(\theta_\mu)}), \\
T_{(V)}(\psi_\mu)
&= \lambda_{-,\mu}\psi_\mu
\quad (\because \text{フェルミオン消滅演算子への作用}) \\
&= e^{-\gamma(\theta_\mu)}\psi_\mu
\quad (\because \lambda_{-,\mu}=e^{-\gamma(\theta_\mu)}).
\end{aligned}`,
      ),
      paragraph(["であり、", ref("action_of_T_Vprime_on_psi"), " より"]),
      displayMath(
        String.raw`T_{(V')}(\psi_\mu^\dagger) = e^{\gamma(\theta_\mu)}\psi_\mu^\dagger, \quad T_{(V')}(\psi_\mu) = e^{-\gamma(\theta_\mu)}\psi_\mu`,
      ),
      paragraph(["である。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(\psi_\mu^\dagger)
&= e^{\gamma(\theta_\mu)}\psi_\mu^\dagger
\quad (\because \text{直前の }T_{(V)}\text{ の作用}) \\
&= T_{(V')}(\psi_\mu^\dagger)
\quad (\because \text{直前の }T_{(V')}\text{ の作用}), \\
T_{(V)}(\psi_\mu)
&= e^{-\gamma(\theta_\mu)}\psi_\mu
\quad (\because \text{直前の }T_{(V)}\text{ の作用}) \\
&= T_{(V')}(\psi_\mu)
\quad (\because \text{直前の }T_{(V')}\text{ の作用}).
\end{aligned}`,
      ),
      paragraph(["が成り立つ。これより、"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(\hat{Z}_\mu^{(-)})
&= T_{(V)}(q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu)
\quad (\because \hat{Z}_\mu^{(-)}=q_{11}\psi_\mu^\dagger+q_{21}\psi_\mu) \\
&= q_{11}T_{(V)}(\psi_\mu^\dagger) + q_{21}T_{(V)}(\psi_\mu) \quad (\because T_{(V)} \text{ の線型性}) \\
&= q_{11}T_{(V')}(\psi_\mu^\dagger) + q_{21}T_{(V')}(\psi_\mu) \quad (\because \text{直前の二つの作用の一致}) \\
&= T_{(V')}(q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu) \quad (\because T_{(V')} \text{ の線型性}) \\
&= T_{(V')}(\hat{Z}_\mu^{(-)})
\quad (\because q_{11}\psi_\mu^\dagger+q_{21}\psi_\mu=\hat{Z}_\mu^{(-)})
\end{aligned}`,
      ),
      paragraph(["が成り立つ。また、"]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(\hat{Y}_\mu)
&= T_{(V)}(q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu)
\quad (\because \hat{Y}_\mu=q_{12}\psi_\mu^\dagger+q_{22}\psi_\mu) \\
&= q_{12}T_{(V)}(\psi_\mu^\dagger) + q_{22}T_{(V)}(\psi_\mu)
\quad (\because T_{(V)} \text{ の線型性}) \\
&= q_{12}T_{(V')}(\psi_\mu^\dagger) + q_{22}T_{(V')}(\psi_\mu)
\quad (\because \text{直前の二つの作用の一致}) \\
&= T_{(V')}(q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu)
\quad (\because T_{(V')} \text{ の線型性}) \\
&= T_{(V')}(\hat{Y}_\mu)
\quad (\because q_{12}\psi_\mu^\dagger+q_{22}\psi_\mu=\hat{Y}_\mu).
\end{aligned}`,
      ),
      paragraph(["場合 2: ", math(String.raw`\gamma_2(\theta_\mu) = 0`), "。", math(String.raw`T_{(V)}`), " について、", ref("T_V_hatZ_hatY"), " と ", ref("A_theta_is_identity_when_gamma2_zero"), " より"]),
      displayMath(
        String.raw`\begin{aligned}
(T_{(V)}(\hat{Z}_\mu^{(-)}),\, T_{(V)}(\hat{Y}_\mu))
&= (\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu)A(\theta_\mu)
\quad (\because \text{T\_V\_hatZ\_hatY}) \\
&= (\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu)I
\quad (\because \gamma_2(\theta_\mu)=0\text{ のとき }A(\theta_\mu)=I\text{：A\_theta\_is\_identity\_when\_gamma2\_zero}) \\
&= (\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu)
\quad (\because \text{単位行列との積})
\end{aligned}`,
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
      notes: [
        "ソースを忠実に翻訳（場合 1: フェルミオン経由、場合 2: A(θμ)=I 経由）。",
        "2026-08-12 の式変形統一で、復元後の T_(V) の二つの作用を固有値の作用と指数表示の代入へ分け、T_(V') との一致を生成演算子・消滅演算子ごとの鎖へ開いた。hat Z の作用の鎖には始点と終点で使う復元式の根拠を補った。内容は変えていない。",
        "2026-08-12 の式変形統一で、hat Y の作用を復元式・二つの線型性・生成消滅演算子上の作用の一致を一行ずつ使う五段の鎖へ開いた。内容は変えていない。",
        "2026-08-12 の式変形統一で、場合 2（γ_2(θ_μ)=0）の二つの等号を一行一等号の三段の鎖へ開き、各行末へ根拠を付けた。内容は変えていない。",
        "2026-08-13 の式変形統一で、det P_μ の計算を最終形（i√(γ_2(θ_μ)γ_2(−θ_μ))/(2Mγ_2(−θ_μ))）まで一行一等号で完成させ、約分が使う非零性の準備を鎖の前へ移した。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_039_claim_T_V_eq_T_Vprime",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/038_claim_T_V_eq_T_Vprime.typ",
      ordinal: 39,
    },
    title: { tex: String.raw`T_{(V)} = T_{(V')}` },
    labels: ["T_V_eq_T_Vprime"],
    statement: [
      displayMath(String.raw`T_{(V)} = T_{(V')}`),
      paragraph([
        "すなわち、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
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
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(X)
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(X)\right)\right)
&&\bigl(\because\ \text{\cref{lab:def_T_V}}\bigr)
\end{aligned}`,
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
   \quad (\because V=(V_1^{(\pm)})^{1/2}V_2(V_1^{(\pm)})^{1/2})
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
        String.raw`\begin{aligned}
Z_m
&= \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)}\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)
&&\bigl(\because\ \text{\cref{lab:recover_Z_Y_from_hatZ_hatY}}\bigr) \\
Y_m
&= \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)
&&\bigl(\because\ \text{\cref{lab:recover_Z_Y_from_hatZ_hatY}}\bigr)
\end{aligned}`,
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
        String.raw`\begin{aligned}
T_{(V)}(Z_m)
&= T_{(V')}(Z_m)
   \quad (\because \text{直前の }Z_m\text{ に対する式変形}) \\
T_{(V)}(Y_m)
&= T_{(V')}(Y_m)
   \quad (\because \text{直前の }Y_m\text{ に対する式変形})
\end{aligned}`,
      ),
      paragraph(["である。"]),
      paragraph(["Step 3: 一致する元の集合は、和・スカラー倍・積で閉じ、単位元を含む。"]),
      paragraph(["集合"]),
      displayMath(
        String.raw`\mathcal{E} := \left\{\, x \in \mathrm{Mat}(2^M,\mathbb{C}) \;:\; T_{(V)}(x) = T_{(V')}(x) \,\right\}`,
      ),
      paragraph([
        "を考える。",
        math(String.raw`\mathcal{E}`),
        " が ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
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
      displayMath(
        String.raw`\alpha x + \beta y \in \mathcal{E}
\quad (\because\ \mathcal{E}\ \text{の定義と直前の等式})`,
      ),
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
      displayMath(
        String.raw`x y \in \mathcal{E}
\quad (\because\ \mathcal{E}\ \text{の定義と直前の等式})`,
      ),
      paragraph([
        "（単位元を含む）Step 1 の単位性より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V)}(I)
&= I
\quad (\because T_{(V)}\text{ の単位性}) \\
&= T_{(V')}(I)
\quad (\because T_{(V')}\text{ の単位性})
\end{aligned}`,
      ),
      displayMath(
        String.raw`I \in \mathcal{E}
\quad (\because\ \mathcal{E}\ \text{の定義と直前の等式})`,
      ),
      paragraph([
        "以上より ",
        math(String.raw`\mathcal{E}`),
        " は単位元を含み、和・スカラー倍・積について閉じる ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
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
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^M,\mathbb{C})`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{Mat}(2^M,\mathbb{C})
&= \mathcal{A}
&& (\because \text{Z\_Y\_generate\_algebra}) \\
&\subseteq \mathcal{E}
&& (\because \mathcal{E}\ \text{は生成元を含み、和・スカラー倍・積について閉じ、単位元を含む}) \\
&\subseteq \mathrm{Mat}(2^M,\mathbb{C})
&& (\because \mathcal{E}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "したがって",
      ]),
      displayMath(
        String.raw`\mathcal{E} = \mathrm{Mat}(2^M,\mathbb{C})
\quad (\because\ \text{二つの包含による集合の相等})`,
      ),
      paragraph([
        "である。任意の ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`T_{(V)}(x) = T_{(V')}(x)
\quad (\because\ x\in\mathcal{E}\ \text{と}\ \mathcal{E}\ \text{の定義})`,
      ),
      paragraph(["なので"]),
      displayMath(
        String.raw`T_{(V)} = T_{(V')}
\quad (\because\ \text{写像の相等は全ての入力での値の相等})`,
      ),
      paragraph(["が成り立つことを意味する。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "移行漏れだった証明を _old/typst の原本（038_claim_T_V_eq_T_Vprime.typ）から復旧。Step 1〜4 を圧縮せず全ステップ再現した。",
        "原文の statement は「任意の x に対して T_((V))(x) = T_((V'))(x)」であり、構造化側にあった「V x V^{-1} = V' x V'^{-1}」という別表記を原文どおりに戻した（V x V^{-1} = T_V(x) であることは Step 1 の T_((V)) = T_V を経由して初めて言えるため、statement 段階では原文の形が正しい）。",
        "原文の T_((V_2)) は、構造化側の def_T_V が用いる T_{V_2} の表記に統一した。",
        "2026-08-12 の式変形統一で、Step 4 の包含鎖を一行一関係へ分け、生成部分代数の最小性・集合の相等・各点での写像の相等・写像の外延性をそれぞれ独立した行と行末根拠へ開いた。内容は変えていない。",
        "2026-08-13 の式変形統一で、Step 1 の T_(V) の定義による作用と T_(V)=T_V の終点、および Step 2 の Z_m・Y_m の復元式に行末根拠を補い、二つの復元式を一行一等号へ分けた。内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_040_claim_V_eq_cVprime",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/039_claim_V_eq_Vprime.typ",
      ordinal: 40,
    },
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
&= I_{\mathrm{Mat}(2^M,\mathbb{C})}\, V
   \quad (\because V' V'^{-1} = I_{\mathrm{Mat}(2^M,\mathbb{C})}) \\
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
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
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
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
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
   \quad (\because V'^{-1}V' = V'V'^{-1} = I_{\mathrm{Mat}(2^M,\mathbb{C})}) \\
&= V'^{-1}\left(V' x V'^{-1}\right)V'
   \quad (\because V'(W x W^{-1})V'^{-1} = V' x V'^{-1}) \\
&= x
   \quad (\because V'^{-1}V' = V'V'^{-1} = I_{\mathrm{Mat}(2^M,\mathbb{C})})
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`W x W^{-1} = x`),
        " である。両辺に右から ",
        math(String.raw`W`),
        " を掛けると、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W x
&= (W x W^{-1}) W
   \quad (\because W^{-1}W = I_{\mathrm{Mat}(2^M,\mathbb{C})}) \\
&= x W
   \quad (\because W x W^{-1} = x)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。したがって ",
        math(String.raw`W`),
        " はすべての ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " と可換である。",
      ]),
      paragraph(["Step 3: ", math(String.raw`W`), " はスカラーである。"]),
      paragraph([
        "Step 2 より ",
        math(String.raw`W`),
        " はすべての ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " と可換であるから、",
        ref("centralizer_is_scalar"),
        " より、ある ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在して",
      ]),
      displayMath(
        String.raw`W = c \cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}
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
        math(String.raw`W = 0\cdot I_{\mathrm{Mat}(2^M,\mathbb{C})} = O`),
        "（零行列）となるが、零行列は可逆でない（任意の ",
        math(String.raw`A`),
        " について ",
        math(String.raw`O A = O \neq I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
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
        math(String.raw`W = c \cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " を代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V
&= V' W
   \quad (\because \text{Step 1}) \\
&= V'\left(c \cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
   \quad (\because \text{Step 3}) \\
&= c \cdot \left(V' I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
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
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "移行漏れだった証明を _old/typst の原本（039_claim_V_eq_Vprime.typ）から復旧。Step 1〜5 を圧縮せず全ステップ再現した。",
        "構造化側にあった旧 TODO『T の単射性（クリフォード群の性質）を用いる』は原本の証明方針と異なる（原本は centralizer_is_scalar を用い、クリフォード群には依存しない）。原本の方針に従って復旧し、その旨は原文 note として notes/008_TV1_hatZ_hatY.ts に収めた。",
        "原文 statement にあった V の定義（def_T_V で導入し T_V_eq_T_Vprime の Step 1 で T_((V)) = T_V を示した行列）は、主張の意味の確定に必要なため statement に復旧した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_041_claim_gamma2_periodicity",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/040_claim_gamma2_thetaMの周期性.typ",
      ordinal: 41,
    },
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
        " である。したがって ",
        math(String.raw`\theta_M`),
        " と ",
        math(String.raw`\theta_{-M}`),
        " の指数関数・余弦・正弦の値はそれぞれ一致する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{i\theta_M}
&= e^{2\pi i}
&& (\because\ \theta_M=2\pi) \\
&= 1
&& (\because\ e^{2\pi i}=1) \\
&= e^{-2\pi i}
&& (\because\ e^{-2\pi i}=1) \\
&= e^{i\theta_{-M}}
&& (\because\ \theta_{-M}=-2\pi), \\
\cos\theta_M
&= \cos 2\pi
&& (\because\ \theta_M=2\pi) \\
&= 1
&& (\because\ \cos 2\pi=1) \\
&= \cos(-2\pi)
&& (\because\ \cos(-2\pi)=1) \\
&= \cos\theta_{-M}
&& (\because\ \theta_{-M}=-2\pi), \\
\sin\theta_M
&= \sin 2\pi
&& (\because\ \theta_M=2\pi) \\
&= 0
&& (\because\ \sin 2\pi=0) \\
&= \sin(-2\pi)
&& (\because\ \sin(-2\pi)=0) \\
&= \sin\theta_{-M}
&& (\because\ \theta_{-M}=-2\pi).
\end{aligned}`,
      ),
      paragraph([
        ref("def_A_theta"),
        " にこれらの値を代入すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta_M)
&= i \cdot 1 \cdot s_2^*(c_1 \cdot 1 - i \cdot 0 - s_1 c_2)
&& (\because\ \text{def\_A\_theta と上の指数関数・余弦・正弦の値}) \\
&= i\,s_2^*(c_1-s_1c_2)
&& (\because\ \text{複素数の四則演算}) \\
&= \gamma_2(\theta_{-M})
&& (\because\ \text{def\_A\_theta と上の指数関数・余弦・正弦の値}), \\
\gamma_2(-\theta_M)
&= i \cdot 1 \cdot s_2^*(c_1 \cdot 1 - i \cdot 0 - s_1 c_2)
&& (\because\ -\theta_M=-2\pi\ \text{と def\_A\_theta}) \\
&= i\,s_2^*(c_1-s_1c_2)
&& (\because\ \text{複素数の四則演算}) \\
&= \gamma_2(-\theta_{-M})
&& (\because\ -\theta_{-M}=2\pi\ \text{と def\_A\_theta}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-13 の式変形統一で、二つの周期性等式をそれぞれ始点から結論まで連続した等号列にし、各行へ根拠を明記した。主張と使用する定義は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_044_claim_critical_condition",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/043_claim_臨界条件_c1_eq_s1c2.typ",
      ordinal: 44,
    },
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
      displayMath(
        String.raw`\begin{aligned}
c_1
&= \cosh 2K_1
&& (\because\ \text{記号の定義})\\
&> \sinh 2K_1
&& (\because\ 2K_1>0\ \text{における}\ \cosh x>\sinh x)\\
&= s_1
&& (\because\ \text{記号の定義})\\
&> 0
&& (\because\ 2K_1>0\ \text{における}\ \sinh x>0)\\[3pt]
c_2
&= \cosh 2K_2
&& (\because\ \text{記号の定義})\\
&> \sinh 2K_2
&& (\because\ 2K_2>0\ \text{における}\ \cosh x>\sinh x)\\
&= s_2
&& (\because\ \text{記号の定義})\\
&> 0
&& (\because\ 2K_2>0\ \text{における}\ \sinh x>0)
\end{aligned}`,
      ),
      paragraph([
        "特に ",
        math(String.raw`c_1, s_1, c_2, s_2 \in \mathbb{R}_{>0}`),
        "。また同 (2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_1^2
&= 1+s_1^2
&& (\because\ \cosh^2 x-\sinh^2 x=1\ \text{を}\ x=2K_1\ \text{へ適用})\\
c_2^2
&= 1+s_2^2
&& (\because\ \cosh^2 x-\sinh^2 x=1\ \text{を}\ x=2K_2\ \text{へ適用})
\end{aligned}`,
      ),
      paragraph([
        "Step 1: ",
        math(String.raw`(\Rightarrow)`),
        " の証明。",
        math(String.raw`c_1 = s_1 c_2`),
        " と仮定する。両辺は正の実数（",
        math(String.raw`s_1 c_2 > 0`),
        "）である。まず両辺を 2 乗して Step 0 の 2 式を代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_1^2
&= (s_1 c_2)^2
   \quad (\because\ c_1 = s_1 c_2\ \text{（仮定）}) \\
&= s_1^2 c_2^2
   \quad (\because\ \text{積の 2 乗は 2 乗の積}) \\
&= s_1^2 (1 + s_2^2)
   \quad (\because\ \text{Step 0 の } c_2^2 = 1 + s_2^2) \\
&= s_1^2 + s_1^2 s_2^2
   \quad (\because\ \text{分配則})
\end{aligned}`,
      ),
      paragraph(["が成り立つ。この両辺から ", math(String.raw`s_1^2`), " を引くと"]),
      displayMath(
        String.raw`\begin{aligned}
(s_1 s_2)^2
&= s_1^2 s_2^2
   \quad (\because\ \text{積の 2 乗は 2 乗の積}) \\
&= c_1^2 - s_1^2
   \quad (\because\ \text{上の等式の両辺から } s_1^2 \text{ を引く}) \\
&= (1 + s_1^2) - s_1^2
   \quad (\because\ \text{Step 0 の } c_1^2 = 1 + s_1^2) \\
&= 1
   \quad (\because\ \text{加法逆元の相殺})
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
&= s_1^2 c_2^2
   \quad (\because\ \text{積の 2 乗は 2 乗の積}) \\
&= s_1^2 (1 + s_2^2)
   \quad (\because\ \text{Step 0 の } c_2^2 = 1 + s_2^2) \\
&= s_1^2 + s_1^2 s_2^2
   \quad (\because\ \text{分配則}) \\
&= s_1^2 + (s_1 s_2)^2
   \quad (\because\ \text{積の 2 乗は 2 乗の積}) \\
&= s_1^2 + 1
   \quad (\because\ s_1 s_2 = 1\ \text{（仮定）と } 1^2 = 1) \\
&= c_1^2
   \quad (\because\ \text{Step 0 の } c_1^2 = 1 + s_1^2)
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
        String.raw`\begin{aligned}
\gamma_2(\theta_M)=0
&\iff c_1=s_1c_2
&& (\because\ \mu=M\ \text{では第 1 条件}\ \mu=\pm M\ \text{が成り立つ})\\
&\iff s_1s_2=1
&& (\because\ \text{Step 1 と Step 2})\\
&\iff \sinh 2K_1\sinh 2K_2=1
&& (\because\ s_1=\sinh 2K_1,\ s_2=\sinh 2K_2)
\end{aligned}`,
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
        "2026-08-13 の式変形統一で、Step 1 の積み重ねた等式列（根拠なし・最終行に等号 2 つ）を、" +
          "2 乗の代入の鎖と s_1^2 を引く鎖の二本の一行一等号の鎖へ分け、Step 2 の鎖の各行へ行末根拠を付けた。" +
          "内容は変えていない。",
        "2026-08-15 の式変形統一で、Step 0 の正値性と双曲線恒等式、および Step 3 の臨界条件への同値鎖を、一行一関係と行末根拠を持つ整列式へ開いた。内容は変えていない。",
      ],
    },
  },
]);
