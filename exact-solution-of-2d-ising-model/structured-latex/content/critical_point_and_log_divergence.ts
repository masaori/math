import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「臨界点」の章「臨界点 K_c と d²f/dK² の対数発散」。章立て（`tools/chapter-plan.ts`）で
 * この章に割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_part_critical_point",
    kind: "heading",
    level: 1,
    title: { text: "臨界点" },
    labels: [],
  },
  {
    id: "heading_chapter_critical_point_and_log_divergence",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`\text{臨界点 }K_c\text{ と }\frac{d^2f}{dK^2}\text{ の対数発散}` },
    labels: [],
  },
  {
    id: "critical_000_remark_escape_to_real_analysis_chapter_E",
    kind: "remark",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 2 },
    title: { text: "この章で新たに持ち込む実数解析の事実（(R5)・(R6)・数値の評価）" },
    labels: ["remark_real_analysis_escape_chapter_E"],
    statement: [
      paragraph([
        ref("remark_real_analysis_escape_point"),
        " は、自由エネルギーの表式 ",
        ref("onsager_exact_solution"),
        " を得るまでに実数解析へ移行する箇所が ",
        ref("riemann_sum_to_integral"),
        " 1 つだけであり、外部から持ち込む事実が (R1) Heine–Cantor と ",
        "(R2) 連続関数の Riemann 可積分性の 2 つだけであることを述べた。",
      ]),
      paragraph([
        "**この章は、その表式を出発点として積分の微分を扱うので、外部事実を追加で持ち込む。**",
        "積分の線型性と単調性 (R3) と微分積分学の基本定理 (R4) は、",
        ref("remark_real_analysis_facts_R3_R4"),
        " で持ち込んだものをそのまま使う。この章で新たに追加するのは次の 2 つと、この注記の末尾に挙げる数値の評価だけであり、他では使わない。",
      ]),
      list([
        [
          "(R5) **積分記号下の微分（Leibniz の規則）**：",
          math(String.raw`g(t,x)`),
          " と ",
          math(String.raw`\dfrac{\partial g}{\partial x}(t,x)`),
          " が ",
          math(String.raw`[a,b]\times[x_1,x_2]`),
          " 上で（2 変数の関数として）連続なら、",
          math(String.raw`x \mapsto \int_a^b g(t,x)\,dt`),
          " は ",
          math(String.raw`[x_1,x_2]`),
          " 上微分可能で ",
          math(String.raw`\dfrac{d}{dx}\int_a^b g(t,x)\,dt = \int_a^b \dfrac{\partial g}{\partial x}(t,x)\,dt`),
          "。",
        ],
        [
          "(R6) **置換積分**：",
          math(String.raw`u : [a,b] \to \mathbb{R}`),
          " が微分可能で ",
          math(String.raw`u'`),
          " が連続、",
          math(String.raw`g`),
          " が ",
          math(String.raw`u([a,b])`),
          " を含む区間上で連続なら ",
          math(String.raw`\int_a^b g(u(t))u'(t)\,dt = \int_{u(a)}^{u(b)} g(s)\,ds`),
          "。",
        ],
      ]),
      paragraph(["どの段でどれを使うかは次のとおりである。"]),
      list([
        [
          "(R3) は ",
          ref("kappa_of_K_basic"),
          "（増分の評価）と ",
          ref("second_derivative_log_divergence"),
          " の各不等式（被積分関数の各点評価を積分へ持ち上げる段）で使う。",
        ],
        [
          "(R4) は ",
          ref("kappa_of_K_basic"),
          "（増分の評価）と ",
          ref("second_derivative_log_divergence"),
          "（定数関数の積分と、",
          math(String.raw`F(s) = -s^2\log s`),
          " の増分の評価）で使う。",
        ],
        [
          "(R5) は ",
          ref("second_derivative_log_divergence"),
          " で ",
          math(String.raw`\dfrac{d^2}{d\kappa^2}\int_0^{2\pi}\gamma\,d\theta = \int_0^{2\pi}\dfrac{\partial^2\gamma}{\partial\kappa^2}\,d\theta`),
          " とする段でだけ使う（2 回適用する）。",
        ],
        [
          "(R6) は ",
          ref("second_derivative_log_divergence"),
          " の証明で ",
          math(String.raw`\int_0^{2\pi} = 2\int_0^{\pi}`),
          "（",
          math(String.raw`\theta \mapsto 2\pi-\theta`),
          " による折り返し）とする段でだけ使う。",
        ],
        [
          ref("remark_real_analysis_facts_R3_R4"),
          " の微分の公式は、",
          ref("kappa_of_K_basic"),
          " でも、",
          math(String.raw`\tanh`),
          "・",
          math(String.raw`K^*`),
          "・",
          math(String.raw`\kappa`),
          "・",
          math(String.raw`\kappa'`),
          "・",
          math(String.raw`\cosh t/\sinh^2 t`),
          " の導関数を求める段と、",
          math(String.raw`\kappa'`),
          " などの連続性を言う段で使う。",
          ref("second_derivative_log_divergence"),
          " でも、",
          math(String.raw`G'`),
          "・",
          math(String.raw`G''`),
          " の偶奇を合成関数の微分で言う段と、",
          math(String.raw`F(s) = -s^2\log s`),
          " の導関数とその連続性を言う段で使う。",
        ],
      ]),
      paragraph([
        "**これ以外の解析的道具（広義積分、一様収束、優収束、実解析性、平均値の定理）は使わない。**",
        "とくに本章に現れる積分はすべて有界閉区間上の連続関数の積分であり、広義積分は現れない",
        "（被積分関数が発散するのは ",
        math(String.raw`\kappa = 0`),
        " のときだけで、本章の評価はすべて ",
        math(String.raw`\kappa \neq 0`),
        " のもとで行う）。",
      ]),
      paragraph([
        "また ",
        ref("kappa_of_K_basic"),
        " は、初等関数の値の次の数値の評価を、本文では証明せずに持ち込む: ",
        math(String.raw`1.02006 \leq \cosh\tfrac15 \leq 1.020067`),
        "、",
        math(String.raw`0.201336 \leq \sinh\tfrac15 \leq 0.2013361`),
        "。示した桁までの不等式としてだけ使う（数値検証は ",
        "sagemath/check/kappa_of_K_basic/ に置いた）。",
      ]),
      paragraph([
        ref("second_derivative_log_divergence"),
        " も、次の数値の評価を本文では証明せずに持ち込む: ",
        math(String.raw`\sinh\tfrac14 \leq 0.2527`),
        "、",
        math(String.raw`\cosh\tfrac14 \leq 1.0315`),
        "、",
        math(String.raw`\log\cosh\tfrac14 \leq 0.0310`),
        "、",
        math(String.raw`\cosh\tfrac12 \leq 1.1277`),
        "、",
        math(String.raw`0.6931 \leq \log 2 \leq 0.6932`),
        "、",
        math(String.raw`\log(2\pi) \leq 1.8380`),
        "。示した桁までの不等式としてだけ使う（数値検証は ",
        "sagemath/check/second_derivative_log_divergence/ に置いた）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、臨界点の章の冒頭へ移した。(R3)(R4) は数学的道具立ての章に残った積分の評価（cosh_addition_and_half_angle・elementary_sine_bounds・closed_form_log_integral・sine_integral_two_sided）も使うので、その宣言を数学的道具立ての章の注記 remark_real_analysis_facts_R3_R4 へ移し、ここはそれを引いて (R5)(R6) を足す形にした。使い道の一覧から数学的道具立ての項を外し、kappa_of_K_basic・second_derivative_log_divergence が (R3)(R4) を使う箇所を補った。数学の中身は変えていない。",
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
&& (\because\ 2K_1>0\ \text{における}\ \cosh x>\sinh x,\ \blkref{cosh_sinh_basic_properties})\\
&= s_1
&& (\because\ \text{記号の定義})\\
&> 0
&& (\because\ 2K_1>0\ \text{における}\ \sinh x>0,\ \blkref{cosh_sinh_basic_properties})\\[3pt]
c_2
&= \cosh 2K_2
&& (\because\ \text{記号の定義})\\
&> \sinh 2K_2
&& (\because\ 2K_2>0\ \text{における}\ \cosh x>\sinh x,\ \blkref{cosh_sinh_basic_properties})\\
&= s_2
&& (\because\ \text{記号の定義})\\
&> 0
&& (\because\ 2K_2>0\ \text{における}\ \sinh x>0,\ \blkref{cosh_sinh_basic_properties})
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
&& (\because\ \cosh^2 x-\sinh^2 x=1\ \text{を}\ x=2K_1\ \text{へ適用},\ \blkref{cosh_sinh_basic_properties})\\
c_2^2
&= 1+s_2^2
&& (\because\ \cosh^2 x-\sinh^2 x=1\ \text{を}\ x=2K_2\ \text{へ適用},\ \blkref{cosh_sinh_basic_properties})
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
      displayMath(
        String.raw`\begin{aligned}
s_1s_2>0\ \land\ 1>0\ \land\ (s_1s_2)^2=1^2
&\Longrightarrow s_1s_2=1
&& (\because\ \text{正の実数の二乗の一意性、}\blkref{cosh_sinh_basic_properties}\text{ (4)})
\end{aligned}`,
      ),
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
      displayMath(
        String.raw`\begin{aligned}
s_1c_2>0\ \land\ c_1>0\ \land\ (s_1c_2)^2=c_1^2
&\Longrightarrow s_1c_2=c_1
&& (\because\ \text{正の実数の二乗の一意性、}\blkref{cosh_sinh_basic_properties}\text{ (4)})
\end{aligned}`,
      ),
      paragraph([
        "以上で ",
        math(String.raw`c_1 = s_1 c_2 \iff s_1 s_2 = 1`),
        " が示された。",
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
        "2026-09-05 の式変形統一で、Step 1 と Step 2 の正の実数の二乗の一意性の適用を散文から含意式へ移し、適用行の末尾から根拠を参照する形へ揃えた。内容は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、statement 後半（γ2(θ_μ) の零点と臨界点の対応）と proof の Step 3 を参照用ノート（本文不採用の整数運動量の経路）へ移した。",
      ],
    },
  },
  {
    id: "critical_002_definition_kappa",
    kind: "definition",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 4 },
    title: { tex: String.raw`\kappa := 2K_1 - 2K_2^*` },
    labels: ["def_kappa"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもとで、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " に対して",
      ]),
      displayMath(String.raw`\kappa := 2K_1 - 2K_2^* \in \mathbb{R}`),
      paragraph(["と定める。"]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "critical_002a_definition_critical_sinh_product_A",
    kind: "definition",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 4 },
    title: { tex: String.raw`A := \sinh 2K_1\sinh 2K_2^*` },
    labels: ["def_critical_sinh_product_A"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもとで、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " に対して",
      ]),
      displayMath(String.raw`A := s_1 s_2^*`),
      paragraph([
        "と定める。記号の定義を代入すれば一続きである。",
      ]),
      displayMath(String.raw`\begin{aligned}
A &= s_1 s_2^*
&&(\because\ A \text{ の定義}) \\
  &= \sinh 2K_1\,\sinh 2K_2^*
&&(\because\ \text{def\_transfer\_matrix\_symbols の } s_1 = \sinh 2K_1,\ s_2^* = \sinh 2K_2^*)
\end{aligned}`),
      paragraph([
        "さらに ",
        math(String.raw`A \in \mathbb{R}_{>0}`),
        " である。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_1, K_2^* > 0`),
        " と ",
        ref("cosh_sinh_basic_properties"),
        " (3) から ",
        math(String.raw`s_1 > 0`),
        " かつ ",
        math(String.raw`s_2^* > 0`),
        " であり、正の実数の積は正だからである。",
      ]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "critical_003_claim_gamma_kappa_identity",
    kind: "claim",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 5 },
    title: { tex: String.raw`\sinh^2\!\left(\tfrac{\gamma(\theta)}{2}\right) = \sinh^2\!\left(\tfrac{\kappa}{2}\right) + A\sin^2\!\left(\tfrac{\theta}{2}\right)` },
    labels: ["gamma_kappa_identity"],
    statement: [
      paragraph([
        ref("def_kappa"),
        " の ",
        math(String.raw`\kappa`),
        "、",
        ref("def_critical_sinh_product_A"),
        " の ",
        math(String.raw`A`),
        "、",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1`),
        " と ",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma`),
        " について、**すべての実数** ",
        math(String.raw`\theta`),
        " で次の 3 つが成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta) &= \cosh\gamma(\theta) = \cosh\kappa + 2A\sin^2\!\left(\frac{\theta}{2}\right) \\
\sinh^2\!\left(\frac{\gamma(\theta)}{2}\right)
&= \sinh^2\!\left(\frac{\kappa}{2}\right) + A\sin^2\!\left(\frac{\theta}{2}\right) \\
\gamma(\theta)
&= 2\,\mathrm{arcsinh}\!\left(
     \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right) + A\sin^2\!\left(\frac{\theta}{2}\right)}^{(\mathbb{R}_{\ge 0})}
   \right)
\end{aligned}`,
      ),
      paragraph([
        "とくに ",
        math(String.raw`\gamma(\theta)`),
        " は ",
        math(String.raw`\kappa`),
        " と ",
        math(String.raw`A`),
        " だけで決まり、",
        math(String.raw`\kappa`),
        " については偶関数である（",
        math(String.raw`\kappa`),
        " を ",
        math(String.raw`-\kappa`),
        " に置き換えても値が変わらない）。",
      ]),
    ],
    proof: [
      paragraph([
        "記号の帰属。",
        math(String.raw`K_1, K_2, K_2^*, \kappa, A, \theta \in \mathbb{R}`),
        "、",
        math(String.raw`c_1, s_1, c_2^*, s_2^* \in \mathbb{R}`),
        "（",
        ref("def_indexed_hyperbolic_abbreviations"),
        "）、",
        math(String.raw`\gamma_1(\theta), \gamma(\theta) \in \mathbb{R}`),
        " である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、cosh・sinh・cos・sin・arccosh・arcsinh の値が部分和の極限・平方根・実対数として定まる実数だからである。",
        "以下 ",
        math(String.raw`\sinh^2(a) := (\sinh a)^2`),
        "（",
        ref("cosh_half_angle_formula"),
        "）、",
        math(String.raw`\sin^2(a) := (\sin a)^2`),
        " と書く。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\gamma_1`),
        " の書き換えと 1 番目の式）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)
&= c_1c_2^* - s_1s_2^*\cos\theta
   &&(\because \blkref{def_gamma1_gamma2_of_theta}) \\
&= \left(c_1c_2^* - s_1s_2^*\right) + s_1s_2^*\left(1 - \cos\theta\right)
   &&(\because \mathbb R\text{ の分配則}) \\
&= \left(\cosh 2K_1\cosh 2K_2^* - \sinh 2K_1\sinh 2K_2^*\right) + s_1s_2^*\left(1 - \cos\theta\right)
   &&(\because \blkref{def_indexed_hyperbolic_abbreviations}) \\
&= \cosh\left(2K_1 - 2K_2^*\right) + s_1s_2^*\left(1-\cos\theta\right)
   &&(\because \blkref{cosh_addition_formula}\text{ の複号 }-\text{ を } x = 2K_1,\ y = 2K_2^* \text{ に適用}) \\
&= \cosh\kappa + s_1s_2^*\left(1-\cos\theta\right)
   &&(\because \blkref{def_kappa}) \\
&= \cosh\kappa + A\left(1-\cos\theta\right)
   &&(\because \blkref{def_critical_sinh_product_A}) \\
&= \cosh\kappa + 2A\sin^2\!\left(\frac{\theta}{2}\right)
   &&(\because \text{倍角公式 } \cos 2t = 1 - 2\sin^2 t \text{ を } t = \tfrac{\theta}{2} \text{ に適用})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)
&= \cosh\left(\mathrm{arccosh}\left(\gamma_1(\theta)\right)\right)
   &&(\because \blkref{arccosh_properties}\text{ (2) を }y = \gamma_1(\theta)\text{ に適用。}\gamma_1(\theta) \ge 1\text{ は }\blkref{gamma1_lower_bound_all_theta}) \\
&= \cosh\gamma(\theta)
   &&(\because \blkref{def_gamma_theta})
\end{aligned}`,
      ),
      paragraph([
        "二つの鎖の左辺はどちらも ",
        math(String.raw`\gamma_1(\theta)`),
        " であり、二つを合わせたものが 1 番目の式である。",
      ]),
      paragraph([
        "Step 2（2 番目の式）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh^2\!\left(\frac{\gamma(\theta)}{2}\right)
&= \frac{\left(1 + 2\sinh^2\!\left(\frac{\gamma(\theta)}{2}\right)\right) - 1}{2}
   &&(\because \mathbb R\text{ の四則}) \\
&= \frac{\cosh\gamma(\theta) - 1}{2}
   &&(\because \blkref{cosh_half_angle_formula}\text{ を }x = \gamma(\theta)\text{ に適用}) \\
&= \frac{\left(\cosh\kappa + 2A\sin^2\!\left(\frac{\theta}{2}\right)\right) - 1}{2}
   &&(\because \text{Step 1 の 1 番目の式}) \\
&= \frac{\left(1 + 2\sinh^2\!\left(\frac{\kappa}{2}\right) + 2A\sin^2\!\left(\frac{\theta}{2}\right)\right) - 1}{2}
   &&(\because \blkref{cosh_half_angle_formula}\text{ を }x = \kappa\text{ に適用}) \\
&= \sinh^2\!\left(\frac{\kappa}{2}\right) + A\sin^2\!\left(\frac{\theta}{2}\right)
   &&(\because \mathbb R\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（3 番目の式）。準備として ",
        math(String.raw`S := \sinh^2(\tfrac{\kappa}{2}) + A\sin^2(\tfrac{\theta}{2}) \in \mathbb{R}`),
        " とおき、",
        math(String.raw`S \ge 0`),
        " と ",
        math(String.raw`\sinh(\tfrac{\gamma(\theta)}{2}) \ge 0`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S
&= \sinh^2\!\left(\frac{\gamma(\theta)}{2}\right)
   &&(\because \text{Step 2}) \\
&= \left(\sinh\frac{\gamma(\theta)}{2}\right)^2
   &&(\because \sinh^2 \text{ の記法}) \\
&\ge 0
   &&(\because \text{実数の 2 乗は非負})
\end{aligned}`,
      ),
      paragraph([
        ref("arccosh_properties"),
        " (1) より ",
        math(String.raw`\gamma(\theta) = \mathrm{arccosh}(\gamma_1(\theta)) \ge 0`),
        "（",
        ref("def_gamma_theta"),
        "。",
        math(String.raw`\gamma_1(\theta) \ge 1`),
        " は ",
        ref("gamma1_lower_bound_all_theta"),
        "）",
        "、ゆえに ",
        math(String.raw`\tfrac{\gamma(\theta)}{2} \ge 0`),
        " である。",
        math(String.raw`\tfrac{\gamma(\theta)}{2} > 0`),
        " なら ",
        ref("cosh_sinh_basic_properties"),
        " (3) より ",
        math(String.raw`\sinh(\tfrac{\gamma(\theta)}{2}) > 0`),
        "、",
        math(String.raw`\tfrac{\gamma(\theta)}{2} = 0`),
        " なら ",
        ref("sinh_zero"),
        " より ",
        math(String.raw`\sinh(\tfrac{\gamma(\theta)}{2}) = 0`),
        " であり、どちらでも ",
        math(String.raw`\sinh(\tfrac{\gamma(\theta)}{2}) \ge 0`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma(\theta)
&= 2\cdot\frac{\gamma(\theta)}{2}
   &&(\because \mathbb R\text{ の四則}) \\
&= 2\,\mathrm{arcsinh}\!\left(\sinh\frac{\gamma(\theta)}{2}\right)
   &&(\because \blkref{sinh_equation_solved_by_arcsinh}\text{ を }u = \tfrac{\gamma(\theta)}{2},\ y = \sinh\tfrac{\gamma(\theta)}{2}\text{ に適用}) \\
&= 2\,\mathrm{arcsinh}\!\left(\sqrt{S}^{(\mathbb{R}_{\ge 0})}\right)
   &&(\because \blkref{sqrt_nonnegative_existence_uniqueness}\text{ の一意性。}\sinh\tfrac{\gamma(\theta)}{2} \ge 0\text{ と上の鎖の }\left(\sinh\tfrac{\gamma(\theta)}{2}\right)^2 = S) \\
&= 2\,\mathrm{arcsinh}\!\left(
     \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right) + A\sin^2\!\left(\frac{\theta}{2}\right)}^{(\mathbb{R}_{\ge 0})}
   \right)
   &&(\because S \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "偶関数性。3 番目の式の右辺は ",
        math(String.raw`\kappa`),
        " を ",
        math(String.raw`\sinh^2(\tfrac{\kappa}{2})`),
        " を通してだけ含み、",
        math(String.raw`\kappa`),
        " を ",
        math(String.raw`-\kappa`),
        " に置き換えても次の鎖により値が変わらない。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh^2\!\left(\frac{-\kappa}{2}\right)
&= \left(\sinh\frac{-\kappa}{2}\right)^2
   &&(\because \sinh^2 \text{ の記法}) \\
&= \left(\sinh\left(-\frac{\kappa}{2}\right)\right)^2
   &&(\because \mathbb R\text{ の四則 }\tfrac{-\kappa}{2} = -\tfrac{\kappa}{2}) \\
&= \left(-\sinh\frac{\kappa}{2}\right)^2
   &&(\because \blkref{sinh_is_odd}\text{ を }x = \tfrac{\kappa}{2}\text{ に適用}) \\
&= \left(\sinh\frac{\kappa}{2}\right)^2
   &&(\because \mathbb R\text{ の四則 }(-a)^2 = a^2) \\
&= \sinh^2\!\left(\frac{\kappa}{2}\right)
   &&(\because \sinh^2 \text{ の記法})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: Step 2 の「両辺から 1 を引いて 2 で割る」を、主張の左辺 sinh^2(γ/2) から始まる一続きの鎖にした。Step 1 の記号の代入・加法定理・κ と A の定義を一行ずつに分け、cosh γ = γ_1 を def_gamma_theta と arccosh_properties (2) の鎖にした。γ_1 ≥ 1 の根拠に gamma1_lower_bound_all_theta を引いた。Step 3 で S ≥ 0 を Step 2 から導き、sinh(γ/2) ≥ 0 の根拠に sinh_zero を引き、散文の平方根の一意性と arcsinh の適用を γ(θ) から始まる鎖の行にし、平方根を本文の実数の平方根の記法 √·^(ℝ≥0) にした。偶関数性に sinh_is_odd を引いた。主張の中身は不変。倍角公式 cos 2t = 1 − 2 sin^2 t は全実数上の cos・sin とともに本文に未整備のまま引いている。検算は sagemath/check/gamma_kappa_identity/。",
      ],
    },
  },
  {
    id: "critical_004_claim_critical_point_iff_kappa_zero",
    kind: "claim",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 6 },
    title: { tex: String.raw`\sinh 2K_1\sinh 2K_2 = 1 \iff K_1 = K_2^* \iff \kappa = 0` },
    labels: ["critical_point_iff_kappa_zero"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " について、次の 3 条件は同値である。",
      ]),
      list([
        ["(1) ", math(String.raw`s_1 s_2 = \sinh 2K_1\,\sinh 2K_2 = 1`), "（Ising 模型の臨界条件）"],
        ["(2) ", math(String.raw`K_1 = K_2^*`)],
        ["(3) ", ref("def_kappa"), " の ", math(String.raw`\kappa = 2K_1 - 2K_2^*`), " が ", math(String.raw`0`), " に等しい"],
      ]),
      paragraph([
        ref("critical_condition_c1_eq_s1_c2"),
        " は同じ条件 (1) が ",
        math(String.raw`c_1 = s_1c_2`),
        " と同値であることを示している。したがって本主張と合わせて、",
        math(String.raw`\kappa = 0`),
        " と ",
        math(String.raw`c_1 = s_1c_2`),
        " も同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "記号の帰属。",
        math(String.raw`K_1, K_2, K_2^*, \kappa \in \mathbb{R}`),
        "（",
        math(String.raw`K_2^* \in \mathbb{R}_{>0}`),
        " は ",
        ref("def_second_dual_coupling_constant"),
        "）、",
        math(String.raw`c_1, s_1, c_2, s_2, s_2^* \in \mathbb{R}`),
        "（",
        ref("def_indexed_hyperbolic_abbreviations"),
        "）である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、cosh・sinh の値が実数の exp の値、すなわち部分和の極限であり、",
        math(String.raw`K_2^*`),
        " が実対数の値だからである。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`s_2 \ne 0`),
        " と ",
        math(String.raw`s_2^* = \dfrac{1}{s_2}`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
s_2 &> 0
&&\bigl(\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i = 2\text{ に適用。}K_2 > 0\text{ は仮定、}K_2^* > 0\text{ は }\blkref{def_second_dual_coupling_constant}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
s_2 &\ne 0
&&\bigl(\because\ s_2 > 0\text{ と }\mathbb{R}\text{ の順序}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
s_2^*
&= \frac{s_2\,s_2^*}{s_2}
&&\bigl(\because\ s_2 \ne 0\text{ なので }\mathbb{R}\text{ の四則}\bigr) \\
&= \frac{\sinh(2K_2)\sinh(2K_2^*)}{s_2}
&&\bigl(\because\ \blkref{def_indexed_hyperbolic_abbreviations}\bigr) \\
&= \frac{1}{s_2}
&&\bigl(\because\ \blkref{second_dual_coupling_relation}\bigr)
\end{aligned}`),
      paragraph([
        "(1) ",
        math(String.raw`\iff`),
        " (2) の証明。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_1 s_2 = 1
&\iff s_1 = \frac{1}{s_2}
&&\bigl(\because\ s_2 \ne 0\text{ なので、}\Rightarrow\text{ は両辺を }s_2\text{ で割り、}\Leftarrow\text{ は両辺に }s_2\text{ を掛ける}\bigr) \\
&\iff s_1 = s_2^*
&&\bigl(\because\ \text{準備の }s_2^* = \tfrac{1}{s_2}\bigr) \\
&\iff \sinh 2K_1 = \sinh 2K_2^*
&&\bigl(\because\ \blkref{def_indexed_hyperbolic_abbreviations}\bigr) \\
&\iff 2K_1 = 2K_2^*
&&\bigl(\because\ \Rightarrow\text{ は }\blkref{sinh_is_injective}\text{ を }u = 2K_1,\ v = 2K_2^*\text{ に適用。}\Leftarrow\text{ は両辺に }\sinh\text{ を施す}\bigr) \\
&\iff K_1 = K_2^*
&&\bigl(\because\ 2 \ne 0\text{ なので、}\Rightarrow\text{ は両辺を }2\text{ で割り、}\Leftarrow\text{ は両辺に }2\text{ を掛ける}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`\iff`),
        " (3) の証明。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\kappa = 0
&\iff 2K_1 - 2K_2^* = 0
&&\bigl(\because\ \blkref{def_kappa}\bigr) \\
&\iff 2\left(K_1 - K_2^*\right) = 0
&&\bigl(\because\ \mathbb{R}\text{ の分配則}\bigr) \\
&\iff K_1 - K_2^* = 0
&&\bigl(\because\ 2 \ne 0\text{ なので、}\Rightarrow\text{ は両辺を }2\text{ で割り、}\Leftarrow\text{ は両辺に }2\text{ を掛ける}\bigr) \\
&\iff K_1 = K_2^*
&&\bigl(\because\ \mathbb{R}\text{ の移項}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\kappa = 0`),
        " と ",
        math(String.raw`c_1 = s_1c_2`),
        " の同値の証明。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_1 = s_1c_2
&\iff s_1s_2 = 1
&&\bigl(\because\ \blkref{critical_condition_c1_eq_s1_c2}\bigr) \\
&\iff K_1 = K_2^*
&&\bigl(\because\ \text{上の (1) }\iff\text{ (2)}\bigr) \\
&\iff \kappa = 0
&&\bigl(\because\ \text{上の (2) }\iff\text{ (3)}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: 根拠を引き直した。sinh(2K_2)sinh(2K_2^*) = 1 は def_transfer_matrix_symbols ではなく second_dual_coupling_relation、s_2 > 0 は cosh_sinh_basic_properties (3) ではなく indexed_hyperbolic_abbreviations_positive から引く。準備の s_2^* = 1/s_2 を一続きの鎖にし、(1)⟺(2) の鎖の各行に ⇒ と ⇐ の根拠を書いた。(2)⟺(3) の「明らか」と、主張の文にある κ = 0 ⟺ c_1 = s_1c_2 を同値の鎖にした。記号の帰属と ℝ を使う理由を書いた。主張の中身は不変。検算は sagemath/check/critical_point_iff_kappa_zero/。",
      ],
    },
  },
  {
    id: "critical_point_definition_isotropic_dual_coupling",
    kind: "definition",
    title: { tex: String.raw`\text{等方な場合の双対結合定数 } K^*` },
    labels: ["def_isotropic_dual_coupling"],
    statement: [
      paragraph([
        math(String.raw`K \in \mathbb{R}_{>0}`),
        " に対して（等方な場合 ",
        math(String.raw`K_1 = K_2 = K`),
        " に使う）、",
        ref("def_positive_coupling_tanh"),
        " の双曲線正接と ",
        ref("def_real_logarithm_positive"),
        " の実対数を用いて",
      ]),
      displayMath(String.raw`K^* := -\frac{1}{2}\log(\tanh K) \in \mathbb{R}_{>0}`),
      paragraph([
        "と定める。右辺は ",
        ref("def_second_dual_coupling_constant"),
        " の右辺の ",
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " を ",
        math(String.raw`K \in \mathbb{R}_{>0}`),
        " に置いたものなので、同じブロックの確認により定まり、",
        math(String.raw`\mathbb{R}_{>0}`),
        " に属する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: isotropic_A_equals_one の主張の文に置かれていた K^* を独立の定義にした（1 ブロック 1 主張）。旧い本文は K^* を def_transfer_matrix_symbols から引いていたが、そこには K^* の定義が無い。",
      ],
    },
  },
  {
    id: "critical_point_definition_isotropic_kappa_of_K",
    kind: "definition",
    title: { tex: String.raw`\kappa(K) := 2K - 2K^*` },
    labels: ["def_isotropic_kappa_of_K"],
    statement: [
      paragraph([
        math(String.raw`K \in \mathbb{R}_{>0}`),
        " と ",
        ref("def_isotropic_dual_coupling"),
        " の ",
        math(String.raw`K^* \in \mathbb{R}_{>0}`),
        " に対して",
      ]),
      displayMath(String.raw`\kappa(K) := 2K - 2K^* \in \mathbb{R}`),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: isotropic_A_equals_one の主張の文に置かれていた κ(K) を独立の定義にした（1 ブロック 1 主張）。",
      ],
    },
  },
  {
    id: "critical_005_claim_isotropic_setting",
    kind: "claim",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 7 },
    title: { tex: String.raw`\text{等方な場合 } K_1 = K_2 = K \text{ では } A = 1` },
    labels: ["isotropic_A_equals_one"],
    statement: [
      paragraph([
        "**等方な場合** ",
        math(String.raw`K_1 = K_2 = K \in \mathbb{R}_{>0}`),
        " では、",
        ref("def_critical_sinh_product_A"),
        " の ",
        math(String.raw`A`),
        " について",
      ]),
      displayMath(String.raw`A = 1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "記号の帰属。",
        math(String.raw`K, K_1, K_2, K_2^*, A \in \mathbb{R}`),
        "、",
        math(String.raw`s_1, s_2^* \in \mathbb{R}`),
        "（",
        ref("def_indexed_hyperbolic_abbreviations"),
        "）である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`K_2^*`),
        " が実対数の値であり、sinh の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
      displayMath(String.raw`\begin{aligned}
A
&= s_1s_2^*
&&\bigl(\because\ \blkref{def_critical_sinh_product_A}\bigr)\\
&= \sinh 2K_1\,\sinh 2K_2^*
&&\bigl(\because\ \blkref{def_indexed_hyperbolic_abbreviations}\text{ の }s_1 = \sinh 2K_1,\ s_2^* = \sinh 2K_2^*\bigr)\\
&= \sinh 2K_2\,\sinh 2K_2^*
&&\bigl(\because\ K_1 = K = K_2\text{（仮定）}\bigr)\\
&= 1
&&\bigl(\because\ \blkref{second_dual_coupling_relation}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: 根拠を引き直した。旧い証明は「def_transfer_matrix_symbols の K^* の定義そのものが sinh(2K)sinh(2K^*) = 1」と書いていたが、def_transfer_matrix_symbols は K^* を定めておらず、sinh(2K_2)sinh(2K_2^*) = 1 は second_dual_coupling_relation が示す。s_1・s_2^* の展開は def_indexed_hyperbolic_abbreviations から引く。旧い主張の文が持っていた K^* と κ(K) の定義、γ の式を、def_isotropic_dual_coupling・def_isotropic_kappa_of_K・isotropic_kappa_equals_kappa_of_K・isotropic_gamma_in_kappa へ分けた（1 ブロック 1 主張）。A = 1 の中身は不変。検算は sagemath/check/isotropic_A_equals_one/。",
      ],
    },
  },
  {
    id: "critical_point_claim_isotropic_kappa_equals_kappa_of_K",
    kind: "claim",
    title: { tex: String.raw`\text{等方な場合 } \kappa = \kappa(K)` },
    labels: ["isotropic_kappa_equals_kappa_of_K"],
    statement: [
      paragraph([
        "**等方な場合** ",
        math(String.raw`K_1 = K_2 = K \in \mathbb{R}_{>0}`),
        " では、",
        ref("def_kappa"),
        " の ",
        math(String.raw`\kappa`),
        " と ",
        ref("def_isotropic_kappa_of_K"),
        " の ",
        math(String.raw`\kappa(K)`),
        " について",
      ]),
      displayMath(String.raw`\kappa = \kappa(K)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "記号の帰属。",
        math(String.raw`K, K_1, K_2, K_2^*, K^*, \kappa, \kappa(K) \in \mathbb{R}`),
        " である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`K_2^*`),
        " と ",
        math(String.raw`K^*`),
        " が実対数の値だからである。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`K_2^* = K^*`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_2^*
&= -\frac{1}{2}\log(\tanh K_2)
&&\bigl(\because\ \blkref{def_second_dual_coupling_constant}\bigr)\\
&= -\frac{1}{2}\log(\tanh K)
&&\bigl(\because\ K_2 = K\text{（仮定）}\bigr)\\
&= K^*
&&\bigl(\because\ \blkref{def_isotropic_dual_coupling}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\kappa
&= 2K_1 - 2K_2^*
&&\bigl(\because\ \blkref{def_kappa}\bigr)\\
&= 2K - 2K_2^*
&&\bigl(\because\ K_1 = K\text{（仮定）}\bigr)\\
&= 2K - 2K^*
&&\bigl(\because\ \text{準備の }K_2^* = K^*\bigr)\\
&= \kappa(K)
&&\bigl(\because\ \blkref{def_isotropic_kappa_of_K}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: 旧い isotropic_A_equals_one の主張の文が κ = κ(K) := 2K − 2K^* と書くだけで示していなかった等式を、独立の主張にして鎖で示した。検算は sagemath/check/isotropic_kappa_equals_kappa_of_K/。",
      ],
    },
  },
  {
    id: "critical_point_claim_isotropic_gamma_in_kappa",
    kind: "claim",
    title: { tex: String.raw`\text{等方な場合 } \gamma(\theta) = 2\,\mathrm{arcsinh}\sqrt{\sinh^2(\kappa(K)/2) + \sin^2(\theta/2)}` },
    labels: ["isotropic_gamma_in_kappa"],
    statement: [
      paragraph([
        "**等方な場合** ",
        math(String.raw`K_1 = K_2 = K \in \mathbb{R}_{>0}`),
        " では、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma`),
        " と ",
        ref("def_isotropic_kappa_of_K"),
        " の ",
        math(String.raw`\kappa(K)`),
        " について、すべての実数 ",
        math(String.raw`\theta`),
        " で",
      ]),
      displayMath(
        String.raw`\gamma(\theta) = 2\,\mathrm{arcsinh}\!\left(
  \sqrt{\sinh^2\!\left(\frac{\kappa(K)}{2}\right) + \sin^2\!\left(\frac{\theta}{2}\right)}^{(\mathbb{R}_{\ge 0})}
\right)`),
      paragraph([
        "が成り立つ。すなわち **等方な場合、",
        math(String.raw`\gamma`),
        " は ",
        math(String.raw`\kappa(K)`),
        " 1 つだけを通じて ",
        math(String.raw`K`),
        " に依存する。**",
      ]),
    ],
    proof: [
      paragraph([
        "記号の帰属。",
        math(String.raw`K, \kappa, \kappa(K), A, \theta, \gamma(\theta) \in \mathbb{R}`),
        " である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、sinh・sin・arcsinh の値が部分和の極限・平方根・実対数として定まる実数だからである。",
        math(String.raw`\theta \in \mathbb{R}`),
        " を任意にとる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma(\theta)
&= 2\,\mathrm{arcsinh}\!\left(
  \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right)+A\sin^2\!\left(\frac{\theta}{2}\right)}^{(\mathbb{R}_{\ge 0})}
\right)
&&\bigl(\because\ \blkref{gamma_kappa_identity}\text{ の第 3 式}\bigr)\\
&= 2\,\mathrm{arcsinh}\!\left(
  \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right)+1\cdot\sin^2\!\left(\frac{\theta}{2}\right)}^{(\mathbb{R}_{\ge 0})}
\right)
&&\bigl(\because\ \blkref{isotropic_A_equals_one}\bigr)\\
&= 2\,\mathrm{arcsinh}\!\left(
  \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right)+\sin^2\!\left(\frac{\theta}{2}\right)}^{(\mathbb{R}_{\ge 0})}
\right)
&&\bigl(\because\ \mathbb{R}\text{ の乗法の単位元 }1\cdot x = x\bigr)\\
&= 2\,\mathrm{arcsinh}\!\left(
  \sqrt{\sinh^2\!\left(\frac{\kappa(K)}{2}\right)+\sin^2\!\left(\frac{\theta}{2}\right)}^{(\mathbb{R}_{\ge 0})}
\right)
&&\bigl(\because\ \blkref{isotropic_kappa_equals_kappa_of_K}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: 旧い isotropic_A_equals_one の主張の後半（γ の式）を独立の主張にした（1 ブロック 1 主張）。平方根を gamma_kappa_identity と同じ √·^(ℝ≥0) の記法にし、κ = κ(K) を isotropic_kappa_equals_kappa_of_K から引いて κ(K) の形で述べた。検算は sagemath/check/isotropic_gamma_in_kappa/。",
      ],
    },
  },
  {
    id: "critical_006_claim_kappa_of_K_basic",
    kind: "claim",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 8 },
    title: { tex: String.raw`\kappa(K) \text{ の基本性質と臨界点 } K_c` },
    labels: ["kappa_of_K_basic"],
    statement: [
      paragraph([
        ref("def_isotropic_kappa_of_K"),
        " の ",
        math(String.raw`\kappa(K) = 2K - 2K^*`),
        "（",
        math(String.raw`K \in \mathbb{R}_{>0}`),
        "）について次が成り立つ。ここで **臨界点** ",
        math(String.raw`K_c \in \mathbb{R}`),
        " を ",
        math(String.raw`\sinh 2K_c = 1`),
        " で定める（",
        ref("sinh_equation_solved_by_arcsinh"),
        " と ",
        ref("def_arcsinh"),
        " より ",
        math(String.raw`2K_c = \mathrm{arcsinh}(1) = \log\left(1+\sqrt{2}^{(\mathbb{R}_{\ge 0})}\right)`),
        " と一意に定まる）。",
        math(String.raw`K_c \in \mathbb{R}_{>0}`),
        " である。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\kappa`),
          " は ",
          math(String.raw`\mathbb{R}_{>0}`),
          " 上微分可能で ",
          math(String.raw`\kappa'(K) = 2 + \dfrac{2}{\sinh 2K} > 0`),
          "、",
          math(String.raw`\kappa'`),
          " は連続であり、",
          math(String.raw`\kappa`),
          " は狭義単調増加。",
        ],
        [
          "(2) ",
          math(String.raw`\kappa(K_c) = 0`),
          " であり、",
          math(String.raw`K \in \mathbb{R}_{>0}`),
          " について ",
          math(String.raw`\kappa(K) = 0 \iff K = K_c \iff \sinh^2 2K = 1`),
          "（等方な場合の臨界条件）。",
        ],
        [
          "(3) ",
          math(String.raw`\kappa'`),
          " は ",
          math(String.raw`\mathbb{R}_{>0}`),
          " 上微分可能で ",
          math(String.raw`\kappa''(K) = -\dfrac{4\cosh 2K}{\sinh^2 2K}`),
          "。",
        ],
        [
          "(4) ",
          math(String.raw`K \in \mathbb{R}`),
          " が ",
          math(String.raw`|K - K_c| \leq \tfrac{1}{10}`),
          " を満たすなら ",
          math(String.raw`K \in \mathbb{R}_{>0}`),
          " であり、",
          math(String.raw`\ 0.7353 \leq \sinh 2K \leq 1.3048`),
          "、",
          math(String.raw`\ 3.53 \leq \kappa'(K) \leq 4.72`),
          "、",
          math(String.raw`\ |\kappa''(K)| \leq 9.19`),
          "、",
          math(String.raw`\ \left|\left(\kappa'^2\right)'(K)\right| \leq 87`),
          "。",
        ],
        [
          "(5) ",
          math(String.raw`K \in \mathbb{R}`),
          " が ",
          math(String.raw`|K - K_c| \leq \tfrac{1}{10}`),
          " を満たすなら ",
          math(String.raw`3.53\,|K-K_c| \leq |\kappa(K)| \leq 4.72\,|K-K_c| \leq 0.472`),
          "、および ",
          math(String.raw`\left|\kappa'(K)^2 - 16\right| \leq 24.7\,|\kappa(K)|`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "記号の帰属。",
        math(String.raw`K, K^*, \kappa(K), \kappa'(K), \kappa''(K), K_c \in \mathbb{R}`),
        "、小数で書いた数は ",
        math(String.raw`\mathbb{Q}`),
        " の元である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\sinh`),
        "・",
        math(String.raw`\cosh`),
        " の値が実数の exp の値（部分和の極限）、",
        math(String.raw`K^*`),
        " と ",
        math(String.raw`K_c`),
        " が実対数の値であり、微分と積分が実数の極限で定まるからである。微分は ",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式、積分は同じ注記の (R3)・(R4) で扱う（",
        ref("remark_real_analysis_escape_chapter_E"),
        "）。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`K_c \in \mathbb{R}_{>0}`),
        " であること。",
        math(String.raw`2K_c \leq 0`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
1
&= \sinh 2K_c
&&\bigl(\because\ K_c\text{ の定義}\bigr)\\
&\leq \sinh 0
&&\bigl(\because\ 2K_c \leq 0\text{ と }\blkref{sinh_strictly_increasing}\text{（等号のときは等しい）}\bigr)\\
&= 0
&&\bigl(\because\ \blkref{sinh_zero}\bigr)
\end{aligned}`),
      paragraph([
        "となり矛盾する。よって ",
        math(String.raw`2K_c > 0`),
        "、すなわち ",
        math(String.raw`K_c \in \mathbb{R}_{>0}`),
        "。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`\cosh 2K_c = \sqrt{2}^{(\mathbb{R}_{\ge 0})}`),
        " であること。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\cosh 2K_c)^2
&= 1 + (\sinh 2K_c)^2
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\text{ (2)}\bigr)\\
&= 1 + 1^2
&&\bigl(\because\ K_c\text{ の定義}\bigr)\\
&= 2
&&\bigl(\because\ \mathbb{Q}\text{ の四則}\bigr)\\
&= \left(\sqrt{2}^{(\mathbb{R}_{\ge 0})}\right)^2
&&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\cosh 2K_c > 0`),
        "（",
        ref("cosh_sinh_basic_properties"),
        " (1)）と ",
        math(String.raw`\sqrt{2}^{(\mathbb{R}_{\ge 0})} > 0`),
        "（",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\sqrt{2}^{(\mathbb{R}_{\ge 0})} \geq 0`),
        " で、その 2 乗は ",
        math(String.raw`2 \neq 0`),
        "）に ",
        ref("cosh_sinh_basic_properties"),
        " (4) を当てて ",
        math(String.raw`\cosh 2K_c = \sqrt{2}^{(\mathbb{R}_{\ge 0})}`),
        "。",
      ]),
      paragraph([
        "準備。",
        math(String.raw`1.414213 \leq \sqrt{2}^{(\mathbb{R}_{\ge 0})} \leq 1.414214`),
        " であること。",
        math(String.raw`1.414213, 1.414214, \sqrt{2}^{(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
1.414213^2
&= 1.999998409369
&&\bigl(\because\ \mathbb{Q}\text{ の四則}\bigr)\\
&\leq 2
&&\bigl(\because\ \mathbb{Q}\text{ の大小}\bigr)\\
&= \left(\sqrt{2}^{(\mathbb{R}_{\ge 0})}\right)^2
&&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\bigr)\\
&\leq 2.000001237796
&&\bigl(\because\ \mathbb{Q}\text{ の大小}\bigr)\\
&= 1.414214^2
&&\bigl(\because\ \mathbb{Q}\text{ の四則}\bigr)
\end{aligned}`),
      paragraph([
        "の二つの不等号に ",
        ref("nonnegative_real_order_from_squares"),
        " を当てる。",
      ]),
      paragraph([
        "準備。数値の評価 ",
        math(String.raw`1.02006 \leq \cosh\tfrac15 \leq 1.020067`),
        "、",
        math(String.raw`0.201336 \leq \sinh\tfrac15 \leq 0.2013361`),
        " は、",
        ref("remark_real_analysis_escape_chapter_E"),
        " が持ち込む数値の評価である。",
      ]),
      paragraph(["(1) の証明。", math(String.raw`K \in \mathbb{R}_{>0}`), " とする。まず ", ref("def_positive_coupling_tanh"), " の ", math(String.raw`\tanh = \sinh/\cosh`), " の導関数を求める（",
        math(String.raw`\cosh K > 0`), " は ", ref("cosh_sinh_basic_properties"), " (1)）。"]),
      displayMath(
        String.raw`\begin{aligned}
(\tanh)'(K)
&= \left(\frac{\sinh}{\cosh}\right)'(K)
&&\bigl(\because\ \blkref{def_positive_coupling_tanh}\bigr) \\
&= \frac{\sinh'(K)\cosh K - \sinh K\cosh'(K)}{\cosh^2 K}
&&\bigl(\because\ \text{微分の公式の商。}\cosh K \neq 0\bigr) \\
&= \frac{\cosh K\cosh K - \sinh K\sinh K}{\cosh^2 K}
&&\bigl(\because\ \blkref{sinh_derivative}\text{ と }\blkref{cosh_derivative}\bigr) \\
&= \frac{1}{\cosh^2 K}
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\text{ (2)}\bigr)
\end{aligned}`,
      ),
      paragraph([
        ref("def_isotropic_dual_coupling"),
        " より ",
        math(String.raw`K^* = -\tfrac12\log(\tanh K)`),
        " で、",
        math(String.raw`\tanh K \in \mathbb{R}_{>0}`),
        "（",
        ref("def_positive_coupling_tanh"),
        "）なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{dK^*}{dK}
&= \left(-\frac{1}{2}\,\log\circ\tanh\right)'(K)
&&\bigl(\because\ \blkref{def_isotropic_dual_coupling}\bigr) \\
&= -\frac{1}{2}\left(\log\circ\tanh\right)'(K)
&&\bigl(\because\ \text{微分の公式の定数倍}\bigr) \\
&= -\frac{1}{2}\cdot\log'(\tanh K)\cdot(\tanh)'(K)
&&\bigl(\because\ \text{微分の公式の合成}\bigr) \\
&= -\frac{1}{2}\cdot\frac{1}{\tanh K}\cdot(\tanh)'(K)
&&\bigl(\because\ \text{微分の公式の }\log'(w) = \tfrac1w\bigr) \\
&= -\frac{1}{2}\cdot\frac{\cosh K}{\sinh K}\cdot\frac{1}{\cosh^2 K}
&&\bigl(\because\ \blkref{def_positive_coupling_tanh}\text{ と上の }(\tanh)'(K)\bigr) \\
&= -\frac{1}{2\sinh K\cosh K}
&&\bigl(\because\ \mathbb R\text{ の四則}\bigr) \\
&= -\frac{1}{\sinh 2K}
&&\bigl(\because\ \blkref{sinh_double_angle_formula}\text{ を }x = 2K\text{ で}\bigr)
\end{aligned}`,
      ),
      displayMath(String.raw`\begin{aligned}
\kappa'(K)
&=\left(2\,\mathrm{id} - 2K^*\right)'(K)
&&\bigl(\because\ \blkref{def_isotropic_kappa_of_K}\text{。}K^*\text{ を }K\text{ の関数と読む}\bigr) \\
&=(2\,\mathrm{id})'(K) - (2K^*)'(K)
&&\bigl(\because\ \text{微分の公式の和（差は }-1\text{ 倍との和）}\bigr) \\
&=2\,\mathrm{id}'(K) - 2\frac{dK^*}{dK}
&&\bigl(\because\ \text{微分の公式の定数倍を 2 箇所へ}\bigr) \\
&=2-2\frac{dK^*}{dK}
&&\bigl(\because\ \text{恒等関数の導関数 }1\bigr) \\
&=2+\frac{2}{\sinh 2K}
&&\bigl(\because\ \text{上の }dK^*/dK\text{ の表示}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\kappa'(K)
&= 2+\frac{2}{\sinh 2K}
&&\bigl(\because\ \text{上の }\kappa'(K)\text{ の表示}\bigr) \\
&> 2
&&\bigl(\because\ \sinh 2K > 0\text{。}\blkref{cosh_sinh_basic_properties}\text{ (3) を }x = 2K > 0\text{ で}\bigr) \\
&> 0
&&\bigl(\because\ \mathbb{Q}\text{ の大小}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\kappa' = 2 + 2/(\sinh\circ(2\,\mathrm{id}))`),
        " は ",
        math(String.raw`\mathbb{R}_{>0}`),
        " 上で微分可能（",
        ref("sinh_derivative"),
        " と微分の公式の和・定数倍・商・合成。分母 ",
        math(String.raw`\sinh 2K > 0`),
        "）なので、微分の公式の「微分可能な関数は連続」より連続である。",
        math(String.raw`0 < a < b`),
        " なら、(R4) を ",
        math(String.raw`F = \kappa`),
        " と ",
        math(String.raw`F(t) = 2t`),
        " に当てて",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa(b) - \kappa(a)
&= \int_a^b \kappa'(t)\,dt
&&\bigl(\because\ \text{(R4)}\bigr)\\
&\geq \int_a^b 2\,dt
&&\bigl(\because\ \text{(R3) の単調性と上の }\kappa'(t) > 2\bigr)\\
&= 2b - 2a
&&\bigl(\because\ \text{(R4) を }F(t) = 2t\text{ で}\bigr)\\
&> 0
&&\bigl(\because\ a < b\bigr)
\end{aligned}`),
      paragraph(["なので ", math(String.raw`\kappa`), " は狭義単調増加である。"]),
      paragraph([
        "(2) の証明。",
        math(String.raw`K \in \mathbb{R}_{>0}`),
        " とし、",
        math(String.raw`K_1 = K_2 = K`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa(K) = 0
&\iff \kappa = 0
&&\bigl(\because\ \blkref{isotropic_kappa_equals_kappa_of_K}\text{。左の }\kappa\text{ は }\blkref{def_kappa}\text{ のもの}\bigr)\\
&\iff s_1s_2 = 1
&&\bigl(\because\ \blkref{critical_point_iff_kappa_zero}\text{ の (1)}\iff\text{(3)}\bigr)\\
&\iff \sinh^2 2K = 1
&&\bigl(\because\ \blkref{def_indexed_hyperbolic_abbreviations}\text{ の }s_i = \sinh 2K_i\text{ と }K_1 = K_2 = K\bigr)\\
&\iff \sinh 2K = 1
&&\bigl(\because\ \sinh 2K > 0\text{（}\blkref{cosh_sinh_basic_properties}\text{ (3)）}\text{、}1 > 0\text{ と }\blkref{cosh_sinh_basic_properties}\text{ (4)}\bigr)\\
&\iff \sinh 2K = \sinh 2K_c
&&\bigl(\because\ K_c\text{ の定義}\bigr)\\
&\iff 2K = 2K_c
&&\bigl(\because\ \Rightarrow\text{ は }\blkref{sinh_is_injective}\text{、}\Leftarrow\text{ は等しい実数の }\sinh\text{ は等しい}\bigr)\\
&\iff K = K_c
&&\bigl(\because\ \mathbb{R}\text{ の四則}\bigr)
\end{aligned}`),
      paragraph([
        "準備の ",
        math(String.raw`K_c \in \mathbb{R}_{>0}`),
        " より、この同値の鎖を ",
        math(String.raw`K = K_c`),
        " に当てると最後の条件が成り立つので ",
        math(String.raw`\kappa(K_c) = 0`),
        "。鎖の条件 ",
        math(String.raw`\kappa(K) = 0`),
        "・",
        math(String.raw`\sinh^2 2K = 1`),
        "・",
        math(String.raw`K = K_c`),
        " が互いに同値なので ",
        math(String.raw`\kappa(K) = 0 \iff K = K_c \iff \sinh^2 2K = 1`),
        "。",
      ]),
      paragraph([
        "(3) の証明。",
        math(String.raw`K \in \mathbb{R}_{>0}`),
        " とする。(1) の ",
        math(String.raw`\kappa' = 2 + 2/(\sinh\circ(2\,\mathrm{id}))`),
        " は微分可能で（(1) の証明）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\kappa''(K)
&= \left(2 + \frac{2}{\sinh\circ(2\,\mathrm{id})}\right)'(K)
&&\bigl(\because\ \text{(1) の }\kappa'\text{ の表示}\bigr) \\
&= 2'(K) + \left(\frac{2}{\sinh\circ(2\,\mathrm{id})}\right)'(K)
&&\bigl(\because\ \text{微分の公式の和}\bigr) \\
&= 0 + \left(\frac{2}{\sinh\circ(2\,\mathrm{id})}\right)'(K)
&&\bigl(\because\ \text{定数関数の導関数 }0\bigr) \\
&= -\frac{2\,(\sinh\circ(2\,\mathrm{id}))'(K)}{\sinh^2 2K}
&&\bigl(\because\ \text{微分の公式の商（分子は定数で導関数 }0\text{）と }\mathbb{R}\text{ の四則}\bigr) \\
&= -\frac{2\cdot\sinh'(2K)\cdot(2\,\mathrm{id})'(K)}{\sinh^2 2K}
&&\bigl(\because\ \text{微分の公式の合成}\bigr) \\
&= -\frac{2\cdot\sinh'(2K)\cdot 2\,\mathrm{id}'(K)}{\sinh^2 2K}
&&\bigl(\because\ \text{微分の公式の定数倍}\bigr) \\
&= -\frac{2\cdot\sinh'(2K)\cdot 2}{\sinh^2 2K}
&&\bigl(\because\ \text{恒等関数の導関数 }1\bigr) \\
&= -\frac{2\cdot\cosh 2K\cdot 2}{\sinh^2 2K}
&&\bigl(\because\ \blkref{sinh_derivative}\bigr) \\
&= -\frac{4\cosh 2K}{\sinh^2 2K}
&&\bigl(\because\ \mathbb R\text{ の四則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(4) の証明。",
        math(String.raw`K \in \mathbb{R}`),
        "、",
        math(String.raw`|K-K_c| \leq \tfrac1{10}`),
        " とすると、絶対値の定義より ",
        math(String.raw`2K_c - \tfrac15 \leq 2K \leq 2K_c + \tfrac15`),
        "。",
        ref("sinh_addition_formula"),
        " を ",
        math(String.raw`x = 2K_c`),
        "、",
        math(String.raw`y = \tfrac15`),
        " に当てると（複号同順）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh\left(2K_c \pm \tfrac15\right)
&= \sinh 2K_c\cosh\tfrac15 \pm \cosh 2K_c\sinh\tfrac15
&&(\because\ \blkref{sinh_addition_formula}) \\
&= \cosh\tfrac15 \pm \sqrt{2}^{(\mathbb{R}_{\ge 0})}\,\sinh\tfrac15
&&(\because\ K_c\text{ の定義と準備の }\cosh 2K_c = \sqrt{2}^{(\mathbb{R}_{\ge 0})})
\end{aligned}`,
      ),
      paragraph([
        "準備の数値の評価から ",
        math(String.raw`\sinh\tfrac15 > 0`),
        "、",
        math(String.raw`\cosh\tfrac15 > 0`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh 2K
&\geq \sinh\left(2K_c-\tfrac15\right)
&&(\because\ 2K_c-\tfrac15 \leq 2K\text{ と }\blkref{sinh_strictly_increasing}\text{（等号のときは等しい）}) \\
&= \cosh\tfrac15-\sqrt{2}^{(\mathbb{R}_{\ge 0})}\,\sinh\tfrac15
&&(\because\ \text{上の端点の式の複号 }-) \\
&\geq 1.02006-\sqrt{2}^{(\mathbb{R}_{\ge 0})}\,\sinh\tfrac15
&&(\because\ \cosh\tfrac15 \geq 1.02006) \\
&\geq 1.02006-1.414214\,\sinh\tfrac15
&&(\because\ \sqrt{2}^{(\mathbb{R}_{\ge 0})} \leq 1.414214\text{ と }\sinh\tfrac15 > 0) \\
&\geq 1.02006-1.414214\cdot0.2013361
&&(\because\ \sinh\tfrac15 \leq 0.2013361) \\
&\geq 0.7353
&&(\because\ \mathbb Q\text{ の四則と大小}).
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh 2K
&\leq \sinh\left(2K_c+\tfrac15\right)
&&(\because\ 2K \leq 2K_c+\tfrac15\text{ と }\blkref{sinh_strictly_increasing}\text{（等号のときは等しい）}) \\
&= \cosh\tfrac15+\sqrt{2}^{(\mathbb{R}_{\ge 0})}\,\sinh\tfrac15
&&(\because\ \text{上の端点の式の複号 }+) \\
&\leq 1.020067+\sqrt{2}^{(\mathbb{R}_{\ge 0})}\,\sinh\tfrac15
&&(\because\ \cosh\tfrac15 \leq 1.020067) \\
&\leq 1.020067+1.414214\,\sinh\tfrac15
&&(\because\ \sqrt{2}^{(\mathbb{R}_{\ge 0})} \leq 1.414214\text{ と }\sinh\tfrac15 > 0) \\
&\leq 1.020067+1.414214\cdot0.2013361
&&(\because\ \sinh\tfrac15 \leq 0.2013361) \\
&\leq 1.3048
&&(\because\ \mathbb Q\text{ の四則と大小}).
\end{aligned}`,
      ),
      paragraph([
        "一つ目の鎖の 2 行目以降は ",
        math(String.raw`K`),
        " に依らないので ",
        math(String.raw`\sinh(2K_c - \tfrac15) \geq 0.7353`),
        " でもある。",
        math(String.raw`2K \leq 0`),
        " なら ",
        ref("sinh_strictly_increasing"),
        "（等号のときは等しい）と ",
        ref("sinh_zero"),
        " より ",
        math(String.raw`\sinh 2K \leq 0 < 0.7353`),
        " となり一つ目の鎖に反するので ",
        math(String.raw`2K > 0`),
        "、すなわち ",
        math(String.raw`K \in \mathbb{R}_{>0}`),
        "。同じ理由で ",
        math(String.raw`2K_c - \tfrac15 > 0`),
        "。したがって (1)・(3) を ",
        math(String.raw`K`),
        " で使える。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\kappa'(K)
&= 2 + \frac{2}{\sinh 2K}
&&(\because\ \text{(1)}) \\
&\geq 2 + \frac{2}{1.3048}
&&(\because\ 0 < \sinh 2K \leq 1.3048) \\
&\geq 3.53
&&(\because\ \mathbb Q\text{ の四則と大小}). \\
\kappa'(K)
&= 2 + \frac{2}{\sinh 2K}
&&(\because\ \text{(1)}) \\
&\leq 2 + \frac{2}{0.7353}
&&(\because\ \sinh 2K \geq 0.7353 > 0) \\
&\leq 4.72
&&(\because\ \mathbb Q\text{ の四則と大小}).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\kappa''`),
        " を評価するために ",
        math(String.raw`h : \mathbb{R}_{>0} \to \mathbb{R},\ h(t) := \dfrac{\cosh t}{\sinh^2 t}`),
        " と置く（",
        math(String.raw`t > 0`),
        " で ",
        math(String.raw`\sinh t > 0`),
        "。",
        ref("cosh_sinh_basic_properties"),
        " (3)）。",
        math(String.raw`h`),
        " は微分可能で、",
        math(String.raw`t \in \mathbb{R}_{>0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
h'(t)
&= \frac{\cosh'(t)\sinh^2 t - \cosh t\,(\sinh\cdot\sinh)'(t)}{\sinh^4 t}
&&(\because\ \text{微分の公式の商}) \\
&= \frac{\cosh'(t)\sinh^2 t - \cosh t\cdot 2\sinh t\,\sinh'(t)}{\sinh^4 t}
&&(\because\ \text{微分の公式の積と }\mathbb{R}\text{ の乗法の交換律}) \\
&= \frac{\sinh t\cdot\sinh^2 t - \cosh t\cdot 2\sinh t\cosh t}{\sinh^4 t}
&&(\because\ \blkref{cosh_derivative}\text{ と }\blkref{sinh_derivative}) \\
&= \frac{\sinh^2 t - 2\cosh^2 t}{\sinh^3 t}
&&(\because\ \mathbb R\text{ の四則。}\sinh t \neq 0) \\
&= \frac{-1 - \cosh^2 t}{\sinh^3 t}
&&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (2) の }\sinh^2 t = \cosh^2 t - 1) \\
&< 0
&&(\because\ -1-\cosh^2 t \leq -1 < 0,\ \sinh^3 t > 0).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`h'`),
        " は微分可能な関数の商として微分可能なので連続であり、",
        math(String.raw`0 < a < b`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
h(b) - h(a)
&= \int_a^b h'(t)\,dt
&&(\because\ \text{(R4) を }F = h\text{ で})\\
&\leq \int_a^b 0\,dt
&&(\because\ \text{(R3) の単調性と上の }h'(t) < 0)\\
&= 0
&&(\because\ \text{(R4) を定数関数 }F = 0\text{ で})
\end{aligned}`),
      paragraph([
        "である。よって ",
        math(String.raw`0 < a \leq b`),
        " なら ",
        math(String.raw`h(b) \leq h(a)`),
        "。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cosh\left(2K_c-\tfrac15\right)
&= \cosh 2K_c\cosh\tfrac15 - \sinh 2K_c\sinh\tfrac15
&&(\because\ \blkref{cosh_addition_formula}\text{ の複号 }-) \\
&= \sqrt{2}^{(\mathbb{R}_{\ge 0})}\cosh\tfrac15 - \sinh\tfrac15
&&(\because\ \text{準備の }\cosh 2K_c = \sqrt{2}^{(\mathbb{R}_{\ge 0})}\text{ と }K_c\text{ の定義}) \\
&\leq 1.414214\cosh\tfrac15 - \sinh\tfrac15
&&(\because\ \sqrt{2}^{(\mathbb{R}_{\ge 0})} \leq 1.414214\text{ と }\cosh\tfrac15 > 0) \\
&\leq 1.414214\cdot1.020067 - \sinh\tfrac15
&&(\because\ \cosh\tfrac15 \leq 1.020067) \\
&\leq 1.414214\cdot1.020067 - 0.201336
&&(\because\ \sinh\tfrac15 \geq 0.201336) \\
&\leq 1.2413
&&(\because\ \mathbb Q\text{ の四則と大小}).
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\left|\kappa''(K)\right|
&=\left|-\frac{4\cosh 2K}{\sinh^2 2K}\right|
&&(\because\ \text{(3)}) \\
&=\frac{4\cosh 2K}{\sinh^2 2K}
&&(\because\ \cosh 2K > 0\text{（}\blkref{cosh_sinh_basic_properties}\text{ (1)）、}\sinh^2 2K > 0) \\
&=4h(2K)
&&(\because\ h\text{ の定義}) \\
&\leq4h\left(2K_c-\tfrac15\right)
&&(\because\ 0 < 2K_c-\tfrac15 \leq 2K\text{ と上の }h\text{ の単調減少}) \\
&=\frac{4\cosh(2K_c-\frac15)}{\sinh^2(2K_c-\frac15)}
&&(\because\ h\text{ の定義}) \\
&\leq\frac{4\cdot1.2413}{\sinh^2(2K_c-\frac15)}
&&(\because\ \text{上の }\cosh(2K_c-\tfrac15) \leq 1.2413) \\
&\leq\frac{4\cdot1.2413}{0.7353^2}
&&(\because\ \sinh(2K_c-\tfrac15) \geq 0.7353 > 0) \\
&\leq9.19
&&(\because\ \mathbb Q\text{ の四則と大小}).
\end{aligned}`,
      ),
      displayMath(String.raw`\begin{aligned}
\left|\left(\kappa'^2\right)'(K)\right|
&=\left|2\kappa'(K)\kappa''(K)\right|
&&(\because\ \text{微分の公式の積（(1)・(3) より }\kappa'\text{ は微分可能）}) \\
&=2\,\kappa'(K)\left|\kappa''(K)\right|
&&(\because\ \text{積の絶対値と }\kappa'(K) > 0) \\
&\leq2\cdot4.72\cdot9.19
&&(\because\ \text{上の }\kappa'(K)\text{ と }|\kappa''(K)|\text{ の上界}) \\
&\leq87
&&(\because\ \mathbb Q\text{ の四則と大小}).
\end{aligned}`),
      paragraph([
        "(5) の証明。",
        math(String.raw`K \in \mathbb{R}`),
        "、",
        math(String.raw`|K-K_c| \leq \tfrac1{10}`),
        " とし、",
        math(String.raw`a := \min\{K, K_c\}`),
        "、",
        math(String.raw`b := \max\{K, K_c\}`),
        " と置く。",
        math(String.raw`\{a, b\} = \{K, K_c\}`),
        "、",
        math(String.raw`b - a = |K - K_c|`),
        " であり、",
        math(String.raw`t \in [a, b]`),
        " は ",
        math(String.raw`|t - K_c| \leq |K - K_c| \leq \tfrac1{10}`),
        " を満たすので (4) を ",
        math(String.raw`t`),
        " で使える（とくに ",
        math(String.raw`a > 0`),
        "）。(1) より ",
        math(String.raw`\kappa`),
        " は単調増加なので ",
        math(String.raw`\kappa(b) - \kappa(a) = |\kappa(K) - \kappa(K_c)|`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
3.53\,|K-K_c|
&= 3.53\,(b-a)
&&(\because\ b - a = |K-K_c|) \\
&= \int_a^b 3.53\,dt
&&(\because\ \text{(R4) を }F(t) = 3.53\,t\text{ で}) \\
&\leq \int_a^b \kappa'(t)\,dt
&&(\because\ \text{(R3) の単調性と (4) の }\kappa'(t)\geq3.53) \\
&= \kappa(b) - \kappa(a)
&&(\because\ \text{(R4) を }F = \kappa\text{ で。(1) より }\kappa'\text{ は連続}) \\
&= |\kappa(K) - \kappa(K_c)|
&&(\because\ \text{上の }\kappa(b) - \kappa(a)\text{ の表示}) \\
&= |\kappa(K)|
&&(\because\ \text{(2) の }\kappa(K_c) = 0) \\
&= \kappa(b) - \kappa(a)
&&(\because\ \text{(2) の }\kappa(K_c) = 0\text{ と上の }\kappa(b) - \kappa(a)\text{ の表示}) \\
&= \int_a^b \kappa'(t)\,dt
&&(\because\ \text{(R4) を }F = \kappa\text{ で}) \\
&\leq \int_a^b 4.72\,dt
&&(\because\ \text{(R3) の単調性と (4) の }\kappa'(t)\leq4.72) \\
&= 4.72\,(b-a)
&&(\because\ \text{(R4) を }F(t) = 4.72\,t\text{ で}) \\
&= 4.72\,|K-K_c|
&&(\because\ b - a = |K-K_c|) \\
&\leq 4.72\cdot\frac{1}{10}
&&(\because\ |K-K_c|\leq\tfrac{1}{10}) \\
&=0.472
&&(\because\ \mathbb Q\text{ の四則}).
\end{aligned}`,
      ),
      paragraph([
        "次に ",
        math(String.raw`G := \kappa'^2 : \mathbb{R}_{>0} \to \mathbb{R}`),
        " と置く。(1)・(3) と微分の公式の積より ",
        math(String.raw`G`),
        " は微分可能で ",
        math(String.raw`G' = 2\kappa'\kappa''`),
        "、",
        math(String.raw`\kappa'' = -4\cosh(2\,\cdot)/\sinh^2(2\,\cdot)`),
        " は微分可能な関数の商なので連続、よって ",
        math(String.raw`G'`),
        " は連続である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\kappa'(K_c)
&= 2 + \frac{2}{\sinh 2K_c}
&&(\because \text{(1) の } \kappa' \text{ の表示を } K = K_c \in \mathbb{R}_{>0} \text{ で読む}) \\
&= 2 + \frac{2}{1}
&&(\because K_c \text{ の定義}) \\
&= 4
&&(\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "(4) より ",
        math(String.raw`t \in [a, b]`),
        " で ",
        math(String.raw`-87 \leq G'(t) \leq 87`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
-87\,(b-a)
&= \int_a^b (-87)\,dt
&&(\because\ \text{(R4) を }F(t) = -87\,t\text{ で})\\
&\leq \int_a^b G'(t)\,dt
&&(\because\ \text{(R3) の単調性と }-87 \leq G'(t))\\
&\leq \int_a^b 87\,dt
&&(\because\ \text{(R3) の単調性と }G'(t) \leq 87)\\
&= 87\,(b-a)
&&(\because\ \text{(R4) を }F(t) = 87\,t\text{ で})
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
\left|\kappa'(K)^2-16\right|
&=\left|G(K) - G(K_c)\right|
&&(\because\ G\text{ の定義と }\kappa'(K_c)=4) \\
&=\left|G(b) - G(a)\right|
&&(\because\ \{a,b\} = \{K, K_c\}\text{ と }|{-x}| = |x|) \\
&=\left|\int_a^b G'(t)\,dt\right|
&&(\because\ \text{(R4) を }F = G\text{ で}) \\
&\leq 87\,(b-a)
&&(\because\ \text{上の }\textstyle\int_a^b G'\text{ の挟み込みと絶対値の定義}) \\
&= 87\,|K-K_c|
&&(\because\ b - a = |K-K_c|) \\
&\leq 87\cdot\frac{|\kappa(K)|}{3.53}
&&(\because\ \text{上の }3.53|K-K_c|\leq|\kappa(K)|) \\
&\leq 24.7\,|\kappa(K)|
&&(\because\ \mathbb Q\text{ の四則と大小}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-02 の式変形統一で、(4)(5) の三本の鎖に行中の \\quad (\\because …) で置かれていた根拠 7 行を、" +
          "行末の根拠列（aligned の &&）へ揃えた。式変形・根拠・段数・参照は変えていない。",
        "2026-11-05（全証明の SageMath 検算）: K_c ∈ ℝ_{>0} を示していなかった（(2) で critical_point_iff_kappa_zero と isotropic_kappa_equals_kappa_of_K を K_c に使うのに要る）ので、sinh_strictly_increasing と sinh_zero による準備を足し、主張に書いた。cosh 2K_c = √2 と √2 の小数の評価を根拠付きの準備にし、cosh(1/5)・sinh(1/5) の数値の評価を remark_real_analysis_escape_chapter_E が持ち込むものとして引いた。(tanh)' = 1/cosh^2 を商の微分と新しい主張 cosh_derivative で示した。κ の狭義単調増加と h(t) = cosh t/sinh^2 t の単調減少を、平均値の定理を使わず (R3)・(R4) で示した。(2) を同値の鎖にした。(4) の端点の式は加法定理の複号を直接使い（偶奇性を経ない）、K ∈ ℝ_{>0} と 2K_c − 1/5 > 0 を示した。(5) は K < K_c の場合に向きの逆の積分を使っていたので、a = min{K, K_c}、b = max{K, K_c} で書き、|∫G'| の評価を (R3) の定数による挟み込みにした。主張の数値は不変。検算は sagemath/check/kappa_of_K_basic/。",
      ],
    },
  },
  {
    id: "critical_007_claim_gamma_derivatives_in_kappa",
    kind: "claim",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 9 },
    title: { tex: String.raw`\frac{\partial\gamma}{\partial\kappa} = \frac{\sinh\kappa}{\sinh\gamma},\quad \left|\frac{\partial\gamma}{\partial\kappa}\right| \leq 1` },
    labels: ["gamma_derivatives_in_kappa"],
    statement: [
      paragraph([
        ref("isotropic_gamma_in_kappa"),
        " の等方な場合について、",
        math(String.raw`(\theta,\kappa) \in \mathbb{R}\times\mathbb{R}`),
        " の関数",
      ]),
      displayMath(
        String.raw`S(\theta,\kappa) := \sinh^2\!\left(\frac{\kappa}{2}\right) + \sin^2\!\left(\frac{\theta}{2}\right),
\qquad
\gamma(\theta,\kappa) := 2\,\mathrm{arcsinh}\!\left(\sqrt{S(\theta,\kappa)}^{(\mathbb{R}_{\ge 0})}\right)`,
      ),
      paragraph([
        "を考える。",
        math(String.raw`S(\theta,\kappa)`),
        " は実数の 2 乗の和なので ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        " に属し、",
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        ref("definition_of_sqrt_r_positive"),
        " の平方根である。以下、",
        math(String.raw`\theta`),
        " を固定したときは ",
        math(String.raw`S := S(\theta,\kappa)`),
        "、",
        math(String.raw`\gamma := \gamma(\theta,\kappa)`),
        " と書く。このとき次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\sinh\!\left(\tfrac{\gamma}{2}\right) = \sqrt{S}^{(\mathbb{R}_{\ge 0})}`),
          "、",
          math(String.raw`\cosh\!\left(\tfrac{\gamma}{2}\right) = \sqrt{1+S}^{(\mathbb{R}_{\ge 0})}`),
          "、",
          math(String.raw`\sinh\gamma = 2\sqrt{S(1+S)}^{(\mathbb{R}_{\ge 0})}`),
          "、",
          math(String.raw`\cosh\gamma = 1+2S`),
          "。",
        ],
        [
          "(2) ",
          math(String.raw`\kappa \neq 0`),
          " のとき ",
          math(String.raw`S > 0`),
          "、",
          math(String.raw`\sinh\gamma > 0`),
          " であり、",
          math(String.raw`\gamma`),
          " は ",
          math(String.raw`\kappa`),
          " について 2 回微分可能で",
          math(String.raw`\quad \dfrac{\partial\gamma}{\partial\kappa} = \dfrac{\sinh\kappa}{\sinh\gamma}`),
          "、",
          math(String.raw`\quad \dfrac{\partial^2\gamma}{\partial\kappa^2}
             = \dfrac{\cosh\kappa}{\sinh\gamma} - \dfrac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}`),
          "。",
        ],
        [
          "(3) ",
          math(String.raw`\kappa \neq 0`),
          " のとき ",
          math(String.raw`\left|\dfrac{\partial\gamma}{\partial\kappa}\right| \leq 1`),
          "。",
        ],
        [
          "(4) ",
          math(String.raw`0 < \kappa_1 \leq \kappa_2`),
          " のとき、",
          math(String.raw`\gamma`),
          "、",
          math(String.raw`\dfrac{\partial\gamma}{\partial\kappa}`),
          "、",
          math(String.raw`\dfrac{\partial^2\gamma}{\partial\kappa^2}`),
          " はいずれも ",
          math(String.raw`[0,2\pi]\times[\kappa_1,\kappa_2]`),
          " 上の連続関数である。",
        ],
      ]),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、sinh・cosh・arcsinh の値が部分和の極限・平方根・実対数として、sin の値が弧の長さで定めた arcsin の逆関数の値として定まる実数であり、微分が実数の極限で定まるからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式）。",
      ]),
    ],
    proof: [
      paragraph([
        "記号の帰属。",
        math(String.raw`\theta, \kappa, S, \gamma \in \mathbb{R}`),
        "。",
        math(String.raw`\theta`),
        " を固定する。",
        math(String.raw`r := \sqrt{S}^{(\mathbb{R}_{\ge 0})}`),
        "、",
        math(String.raw`t := \sqrt{1+S}^{(\mathbb{R}_{\ge 0})}`),
        " と置く（",
        math(String.raw`1+S \geq 1 > 0`),
        "）。",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`r, t \in \mathbb{R}_{\ge 0}`),
        "、",
        math(String.raw`r^2 = S`),
        "、",
        math(String.raw`t^2 = 1+S`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
t < 1
&\Longrightarrow t^2 < 1
   &&(\because\ t \geq 0\text{ より }t\cdot t \leq t\cdot 1 = t < 1) \\
&\Longrightarrow 1+S < 1
   &&(\because\ t^2 = 1+S) \\
&\Longrightarrow S < 0
   &&(\because\ \text{両辺から }1\text{ を引く})
\end{aligned}`,
      ),
      paragraph([
        "これは ",
        math(String.raw`S \geq 0`),
        " に反するので ",
        math(String.raw`t \geq 1`),
        " である。",
      ]),
      paragraph(["(1) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\sinh\!\left(\frac{\gamma}{2}\right)
&= \sinh\!\left(\frac{2\,\mathrm{arcsinh}(r)}{2}\right)
   &&(\because\ \gamma\text{ と }r\text{ の定義}) \\
&= \sinh\bigl(\mathrm{arcsinh}(r)\bigr)
   &&(\because\ \mathbb R\text{ の四則}) \\
&= r
   &&(\because\ \blkref{sinh_of_arcsinh})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh\!\left(\frac{\gamma}{2}\right)
&= \sqrt{\left(\cosh\tfrac{\gamma}{2}\right)^2}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ \cosh\tfrac{\gamma}{2} > 0\ (\blkref{cosh_sinh_basic_properties}\text{ (1)}),\ \blkref{sqrt_nonnegative_existence_uniqueness}\text{ の一意性}) \\
&= \sqrt{1+\left(\sinh\tfrac{\gamma}{2}\right)^2}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (2) を }\tfrac{\gamma}{2}\text{ で移項}) \\
&= \sqrt{1+r^2}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ \sinh\tfrac{\gamma}{2} = r) \\
&= \sqrt{1+S}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ r^2 = S) \\
&= t
   &&(\because\ t\text{ の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh\gamma
&= 2\sinh\!\left(\frac{\gamma}{2}\right)\cosh\!\left(\frac{\gamma}{2}\right)
   &&(\because\ \blkref{sinh_double_angle_formula}) \\
&= 2rt &&(\because\ \sinh\tfrac{\gamma}{2} = r,\ \cosh\tfrac{\gamma}{2} = t) \\
&= 2\sqrt{(rt)^2}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ rt \geq 0,\ \blkref{sqrt_nonnegative_existence_uniqueness}\text{ の一意性}) \\
&= 2\sqrt{r^2t^2}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ \mathbb R\text{ の乗法の交換律と結合律}) \\
&= 2\sqrt{S\,t^2}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ r^2 = S) \\
&= 2\sqrt{S(1+S)}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ t^2 = 1+S)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh\gamma
&= 1 + 2\sinh^2\!\left(\frac{\gamma}{2}\right)
   &&(\because\ \blkref{cosh_half_angle_formula}) \\
&= 1 + 2r^2
   &&(\because\ \sinh\tfrac{\gamma}{2} = r) \\
&= 1 + 2S
   &&(\because\ r^2 = S)
\end{aligned}`,
      ),
      paragraph([
        "(2) の証明。",
        math(String.raw`\kappa \neq 0`),
        " とする。まず ",
        math(String.raw`S > 0`),
        " と ",
        math(String.raw`\sinh\gamma > 0`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\kappa \neq 0
&\Longrightarrow \frac{\kappa}{2} \neq 0
   &&(\because\ \mathbb R\text{ の四則}) \\
&\Longrightarrow \sinh\frac{\kappa}{2} \neq \sinh 0
   &&(\because\ \blkref{sinh_is_injective}\text{ の対偶}) \\
&\Longrightarrow \sinh\frac{\kappa}{2} \neq 0
   &&(\because\ \blkref{sinh_zero}) \\
&\Longrightarrow \sinh^2\frac{\kappa}{2} > 0
   &&(\because\ 0\text{ でない実数の 2 乗は正})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
S
&= \sinh^2\!\left(\frac{\kappa}{2}\right) + \sin^2\!\left(\frac{\theta}{2}\right)
   &&(\because\ S\text{ の定義}) \\
&\geq \sinh^2\!\left(\frac{\kappa}{2}\right)
   &&(\because\ \text{実数の 2 乗は非負}) \\
&> 0
   &&(\because\ \text{直前の含意})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
S > 0
&\Longrightarrow r \neq 0
   &&(\because\ r^2 = S) \\
&\Longrightarrow r > 0
   &&(\because\ r \geq 0) \\
&\Longrightarrow 2rt > 0
   &&(\because\ t \geq 1 > 0\ (\text{記号の帰属の段})) \\
&\Longrightarrow \sinh\gamma > 0
   &&(\because\ \text{本主張 (1) の証明の }\sinh\gamma = 2rt)
\end{aligned}`,
      ),
      paragraph([
        "微分可能性。",
        math(String.raw`\kappa \mapsto S`),
        " は、",
        ref("sinh_derivative"),
        " の ",
        math(String.raw`\sinh`),
        "、定数倍、恒等関数、積と定数関数の和なので微分可能であり、",
        math(String.raw`\kappa \neq 0`),
        " では値が ",
        math(String.raw`\mathbb{R}_{>0}`),
        " に入る。平方根は ",
        math(String.raw`\mathbb{R}_{>0}`),
        " 上微分可能、",
        math(String.raw`\mathrm{arcsinh}`),
        " は微分可能（",
        ref("arcsinh_derivative"),
        "）なので、合成の微分の公式（",
        ref("remark_real_analysis_facts_R3_R4"),
        "）より ",
        math(String.raw`\gamma`),
        " は ",
        math(String.raw`\kappa \neq 0`),
        " で ",
        math(String.raw`\kappa`),
        " について微分可能である。",
        math(String.raw`\theta`),
        " を固定して ",
        math(String.raw`\kappa`),
        " で微分する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\partial S}{\partial\kappa}
&= \frac{d}{d\kappa}\left(\sinh^2\!\left(\frac{\kappa}{2}\right) + \sin^2\!\left(\frac{\theta}{2}\right)\right)
   &&(\because\ S\text{ の定義}) \\
&= \frac{d}{d\kappa}\sinh^2\!\left(\frac{\kappa}{2}\right) + \frac{d}{d\kappa}\sin^2\!\left(\frac{\theta}{2}\right)
   &&(\because\ \text{微分の公式の和}) \\
&= \frac{d}{d\kappa}\sinh^2\!\left(\frac{\kappa}{2}\right) + 0
   &&(\because\ \theta\text{ は固定。定数関数の導関数は }0) \\
&= \frac{d}{d\kappa}\sinh\!\left(\frac{\kappa}{2}\right)\cdot\sinh\!\left(\frac{\kappa}{2}\right)
 + \sinh\!\left(\frac{\kappa}{2}\right)\cdot\frac{d}{d\kappa}\sinh\!\left(\frac{\kappa}{2}\right)
   &&(\because\ \text{微分の公式の積}) \\
&= 2\sinh\!\left(\frac{\kappa}{2}\right)\cdot\frac{d}{d\kappa}\sinh\!\left(\frac{\kappa}{2}\right)
   &&(\because\ \mathbb R\text{ の乗法の交換律と同類項}) \\
&= 2\sinh\!\left(\frac{\kappa}{2}\right)\cdot\sinh'\!\left(\frac{\kappa}{2}\right)\cdot\frac{d}{d\kappa}\frac{\kappa}{2}
   &&(\because\ \text{微分の公式の合成}) \\
&= 2\sinh\!\left(\frac{\kappa}{2}\right)\cdot\sinh'\!\left(\frac{\kappa}{2}\right)\cdot\frac{1}{2}
   &&(\because\ \text{微分の公式の定数倍と恒等関数の導関数 }1) \\
&= 2\sinh\!\left(\frac{\kappa}{2}\right)\cosh\!\left(\frac{\kappa}{2}\right)\cdot\frac{1}{2}
   &&(\because\ \blkref{sinh_derivative}) \\
&= \frac{1}{2}\cdot 2\sinh\!\left(\frac{\kappa}{2}\right)\cosh\!\left(\frac{\kappa}{2}\right)
   &&(\because\ \mathbb R\text{ の乗法の交換律}) \\
&= \frac{1}{2}\sinh\kappa
   &&(\because\ \blkref{sinh_double_angle_formula})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\frac{\partial\gamma}{\partial\kappa}
&= \frac{d}{d\kappa}\Bigl(2\,\mathrm{arcsinh}\bigl(r\bigr)\Bigr)
   &&(\because\ \gamma\text{ と }r\text{ の定義}) \\
&= 2\cdot\frac{d}{d\kappa}\mathrm{arcsinh}\bigl(r\bigr)
   &&(\because\ \text{微分の公式の定数倍}) \\
&= 2\cdot\mathrm{arcsinh}'(r)\cdot\frac{d}{d\kappa}\sqrt{S}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ \text{微分の公式の合成}) \\
&= 2\cdot\mathrm{arcsinh}'(r)\cdot\left(\sqrt{\ }\right)'(S)\cdot\frac{\partial S}{\partial\kappa}
   &&(\because\ \text{微分の公式の合成}) \\
&= 2\cdot\mathrm{arcsinh}'(r)\cdot\frac{1}{2r}\cdot\frac{\partial S}{\partial\kappa}
   &&(\because\ \text{微分の公式の }(\sqrt{\ })'(w) = \tfrac{1}{2\sqrt w},\ S > 0) \\
&= 2\cdot\frac{1}{\sqrt{r^2+1}^{(\mathbb{R}_{\ge 0})}}\cdot\frac{1}{2r}\cdot\frac{\partial S}{\partial\kappa}
   &&(\because\ \blkref{arcsinh_derivative}) \\
&= 2\cdot\frac{1}{\sqrt{S+1}^{(\mathbb{R}_{\ge 0})}}\cdot\frac{1}{2r}\cdot\frac{\partial S}{\partial\kappa}
   &&(\because\ r^2 = S) \\
&= 2\cdot\frac{1}{\sqrt{1+S}^{(\mathbb{R}_{\ge 0})}}\cdot\frac{1}{2r}\cdot\frac{\partial S}{\partial\kappa}
   &&(\because\ \mathbb R\text{ の加法の交換律}) \\
&= 2\cdot\frac{1}{t}\cdot\frac{1}{2r}\cdot\frac{\partial S}{\partial\kappa}
   &&(\because\ t\text{ の定義}) \\
&= 2\cdot\frac{1}{t}\cdot\frac{1}{2r}\cdot\frac{1}{2}\sinh\kappa
   &&(\because\ \text{上の }\tfrac{\partial S}{\partial\kappa}) \\
&= \frac{\sinh\kappa}{2rt}
   &&(\because\ \mathbb R\text{ の四則}) \\
&= \frac{\sinh\kappa}{\sinh\gamma}
   &&(\because\ \text{本主張 (1) の証明の }\sinh\gamma = 2rt)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\kappa \mapsto \sinh\gamma`),
        " は ",
        math(String.raw`\sinh`),
        " と微分可能な ",
        math(String.raw`\gamma`),
        " の合成なので微分可能で、",
        math(String.raw`\sinh\gamma > 0`),
        " だから ",
        math(String.raw`\dfrac{\partial\gamma}{\partial\kappa} = \dfrac{\sinh\kappa}{\sinh\gamma}`),
        " は商の微分の公式より ",
        math(String.raw`\kappa`),
        " について微分可能である。すなわち ",
        math(String.raw`\gamma`),
        " は 2 回微分可能で、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\partial^2\gamma}{\partial\kappa^2}
&= \frac{d}{d\kappa}\left(\frac{\sinh\kappa}{\sinh\gamma}\right)
   &&(\because\ \text{上の }\tfrac{\partial\gamma}{\partial\kappa}) \\
&= \frac{\dfrac{d}{d\kappa}\sinh\kappa\cdot\sinh\gamma - \sinh\kappa\cdot\dfrac{d}{d\kappa}\sinh\gamma}{\sinh^2\gamma}
   &&(\because\ \text{微分の公式の商},\ \sinh\gamma > 0) \\
&= \frac{\cosh\kappa\cdot\sinh\gamma - \sinh\kappa\cdot\dfrac{d}{d\kappa}\sinh\gamma}{\sinh^2\gamma}
   &&(\because\ \blkref{sinh_derivative}) \\
&= \frac{\cosh\kappa\cdot\sinh\gamma - \sinh\kappa\cdot\sinh'(\gamma)\cdot\dfrac{\partial\gamma}{\partial\kappa}}{\sinh^2\gamma}
   &&(\because\ \text{微分の公式の合成}) \\
&= \frac{\cosh\kappa\cdot\sinh\gamma - \sinh\kappa\cdot\cosh\gamma\cdot\dfrac{\partial\gamma}{\partial\kappa}}{\sinh^2\gamma}
   &&(\because\ \blkref{sinh_derivative}) \\
&= \frac{\cosh\kappa\cdot\sinh\gamma - \sinh\kappa\cdot\cosh\gamma\cdot\dfrac{\sinh\kappa}{\sinh\gamma}}{\sinh^2\gamma}
   &&(\because\ \text{上の }\tfrac{\partial\gamma}{\partial\kappa}) \\
&= \frac{\cosh\kappa\cdot\sinh\gamma}{\sinh^2\gamma}
 - \frac{\sinh\kappa\cdot\cosh\gamma\cdot\dfrac{\sinh\kappa}{\sinh\gamma}}{\sinh^2\gamma}
   &&(\because\ \text{分母の等しい分数の差}) \\
&= \frac{\cosh\kappa\cdot\sinh\gamma}{\sinh^2\gamma}
 - \frac{\sinh\kappa\cdot\cosh\gamma\cdot\sinh\kappa}{\sinh\gamma\cdot\sinh^2\gamma}
   &&(\because\ \text{分数の積}) \\
&= \frac{\cosh\kappa}{\sinh\gamma}
 - \frac{\sinh\kappa\cdot\cosh\gamma\cdot\sinh\kappa}{\sinh\gamma\cdot\sinh^2\gamma}
   &&(\because\ \text{約分}) \\
&= \frac{\cosh\kappa}{\sinh\gamma} - \frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}
   &&(\because\ \mathbb R\text{ の乗法の交換律と冪の記法})
\end{aligned}`,
      ),
      paragraph([
        "(3) の証明。",
        math(String.raw`\kappa \neq 0`),
        " とする。まず ",
        math(String.raw`\sinh^2\gamma - \sinh^2\kappa \geq 0`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh^2\gamma - \sinh^2\kappa
&= \left(2\sinh\tfrac{\gamma}{2}\cosh\tfrac{\gamma}{2}\right)^2 - \left(2\sinh\tfrac{\kappa}{2}\cosh\tfrac{\kappa}{2}\right)^2
   &&(\because\ \blkref{sinh_double_angle_formula}\text{ を }\gamma\text{ と }\kappa\text{ に}) \\
&= 4\sinh^2\tfrac{\gamma}{2}\cosh^2\tfrac{\gamma}{2} - 4\sinh^2\tfrac{\kappa}{2}\cosh^2\tfrac{\kappa}{2}
   &&(\because\ \text{積の 2 乗}) \\
&= 4\sinh^2\tfrac{\gamma}{2}\left(1+\sinh^2\tfrac{\gamma}{2}\right) - 4\sinh^2\tfrac{\kappa}{2}\left(1+\sinh^2\tfrac{\kappa}{2}\right)
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (2) を }\tfrac{\gamma}{2}\text{ と }\tfrac{\kappa}{2}\text{ で移項}) \\
&= 4r^2(1+r^2) - 4\sinh^2\tfrac{\kappa}{2}\left(1+\sinh^2\tfrac{\kappa}{2}\right)
   &&(\because\ \sinh\tfrac{\gamma}{2} = r) \\
&= 4S(1+S) - 4\sinh^2\tfrac{\kappa}{2}\left(1+\sinh^2\tfrac{\kappa}{2}\right)
   &&(\because\ r^2 = S) \\
&= 4\left(S - \sinh^2\tfrac{\kappa}{2}\right)\left(1 + S + \sinh^2\tfrac{\kappa}{2}\right)
   &&(\because\ \text{因数分解 }S(1+S) - a(1+a) = (S-a)(1+S+a)) \\
&= 4\sin^2\tfrac{\theta}{2}\left(1 + S + \sinh^2\tfrac{\kappa}{2}\right)
   &&(\because\ S\text{ の定義}) \\
&\geq 0
   &&(\because\ \text{実数の 2 乗は非負},\ S \geq 0)
\end{aligned}`,
      ),
      paragraph([
        "これで ",
        math(String.raw`\sinh^2\kappa \leq \sinh^2\gamma`),
        " が示せた。次に ",
        math(String.raw`|\sinh\kappa| \leq \sinh\gamma`),
        " を背理法で示す。",
        math(String.raw`|\sinh\kappa| > \sinh\gamma`),
        " と仮定すると、(2) の ",
        math(String.raw`\sinh\gamma > 0`),
        " より ",
        math(String.raw`|\sinh\kappa| > 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh^2\kappa
&= |\sinh\kappa|^2
   &&(\because\ \text{実数の絶対値の 2 乗は 2 乗に等しい}) \\
&= |\sinh\kappa|\cdot|\sinh\kappa|
   &&(\because\ \text{冪の記法}) \\
&> |\sinh\kappa|\cdot\sinh\gamma
   &&(\because\ |\sinh\kappa| > \sinh\gamma\text{ の両辺に正の }|\sinh\kappa|\text{ を掛ける}) \\
&> \sinh\gamma\cdot\sinh\gamma
   &&(\because\ |\sinh\kappa| > \sinh\gamma\text{ の両辺に正の }\sinh\gamma\text{ を掛ける}) \\
&= \sinh^2\gamma
   &&(\because\ \text{冪の記法})
\end{aligned}`,
      ),
      paragraph([
        "となって ",
        math(String.raw`\sinh^2\kappa \leq \sinh^2\gamma`),
        " に反する。よって ",
        math(String.raw`|\sinh\kappa| \leq \sinh\gamma`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\frac{\partial\gamma}{\partial\kappa}\right|
&= \left|\frac{\sinh\kappa}{\sinh\gamma}\right|
   &&(\because\ \text{本主張 (2)}) \\
&= \frac{|\sinh\kappa|}{\sinh\gamma}
   &&(\because\ |a/b| = |a|/|b|,\ \sinh\gamma > 0) \\
&\leq \frac{\sinh\gamma}{\sinh\gamma}
   &&(\because\ |\sinh\kappa| \leq \sinh\gamma,\ \sinh\gamma > 0) \\
&= 1
   &&(\because\ \mathbb R\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "(4) の証明。",
        math(String.raw`(\theta,\kappa) \in [0,2\pi]\times[\kappa_1,\kappa_2]`),
        " では、",
        math(String.raw`\tfrac{\kappa}{2} \geq \tfrac{\kappa_1}{2} > 0`),
        " と ",
        ref("sinh_strictly_increasing"),
        "・",
        ref("cosh_sinh_basic_properties"),
        " (3) より ",
        math(String.raw`\sinh\tfrac{\kappa}{2} \geq \sinh\tfrac{\kappa_1}{2} > 0`),
        " なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S
&\geq \sinh^2\!\left(\frac{\kappa}{2}\right)
   &&(\because\ S\text{ の定義と実数の 2 乗は非負}) \\
&\geq \sinh^2\!\left(\frac{\kappa_1}{2}\right)
   &&(\because\ \sinh\tfrac{\kappa}{2} \geq \sinh\tfrac{\kappa_1}{2} > 0) \\
&> 0
   &&(\because\ \sinh\tfrac{\kappa_1}{2} > 0)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`S`),
        " は ",
        math(String.raw`\sinh, \sin`),
        " の連続関数の和・積として連続、",
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        math(String.raw`[\sinh^2(\tfrac{\kappa_1}{2}),\infty)`),
        " 上連続、",
        math(String.raw`\mathrm{arcsinh}`),
        " は連続なので ",
        math(String.raw`\gamma`),
        " は連続。(2) の 2 つの式は、",
        math(String.raw`\sinh\gamma = 2rt \geq 2r > 0`),
        "（",
        math(String.raw`t \geq 1`),
        "）を分母にもつ連続関数の四則で書けているので連続である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: 平方根を isotropic_gamma_in_kappa と同じ √·^(ℝ≥0) の記法にし、S ≥ 0（√S が定まること）を主張に書いた。(1) の sinh(γ/2) = √S を gamma_kappa_identity の Step 3 の流用から sinh_of_arcsinh の 3 行の鎖に、cosh(γ/2) = √(1+S) を平方根の一意性の鎖にした（r := √S、t := √(1+S) と置いた）。(2) の S > 0 を、κ > 0 にしか使えない cosh_sinh_basic_properties (3) から sinh_is_injective・sinh_zero の含意の鎖にし、sinh γ > 0 を主張に足した。∂S/∂κ・∂γ/∂κ・∂²γ/∂κ² の鎖を微分の公式 1 行 1 つにし、∂γ/∂κ の最後は平方根の積を経ず sinh γ = 2rt で結んだ。(3) を平方根の単調性を使わず sinh²γ − sinh²κ = 4 sin²(θ/2)(1 + S + sinh²(κ/2)) ≥ 0 の鎖にした。(4) の S ≥ sinh²(κ_1/2) に sinh_strictly_increasing を引いた。主張の式は不変。検算は sagemath/check/gamma_derivatives_in_kappa/。",
      ],
    },
  },
  {
    id: "critical_011_theorem_second_derivative_log_divergence",
    kind: "theorem",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 13 },
    title: { tex: String.raw`\left|G''(\kappa) - \frac{1}{2\pi}\log\frac{1}{|\kappa|}\right| \leq \frac{6}{5} \quad \left(0 < |\kappa| \leq \tfrac12\right)` },
    labels: ["second_derivative_log_divergence"],
    statement: [
      paragraph([
        ref("gamma_derivatives_in_kappa"),
        " の ",
        math(String.raw`\gamma(\theta,\kappa)`),
        " に対して",
      ]),
      displayMath(
        String.raw`G(\kappa) := \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta,\kappa)\,d\theta`,
      ),
      paragraph([
        "とおく（",
        ref("onsager_exact_solution"),
        " の自由エネルギーの積分項そのものであり、等方な場合 ",
        ref("isotropic_gamma_in_kappa"),
        " により ",
        math(String.raw`\kappa`),
        " だけの関数になる）。このとき ",
        math(String.raw`0 < |\kappa| \leq \tfrac12`),
        " なる ",
        math(String.raw`\kappa`),
        " について ",
        math(String.raw`G`),
        " は 2 回微分可能で",
      ]),
      displayMath(
        String.raw`\left|G'(\kappa)\right| \leq \frac12,
\qquad
\left|G''(\kappa) - \frac{1}{2\pi}\log\frac{1}{|\kappa|}\right| \ \leq\ \frac{6}{5}`,
      ),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`G''(\kappa) \to +\infty`),
        "（",
        math(String.raw`\kappa \to 0`),
        "）であり、その発散は ",
        math(String.raw`\dfrac{1}{2\pi}\log\dfrac{1}{|\kappa|}`),
        " と有界な差しかもたない**対数発散**である。",
      ]),
    ],
    proof: [
      paragraph([
        "数値の評価。この証明は、初等関数の値の次の数値の評価を ",
        ref("remark_real_analysis_escape_chapter_E"),
        " から持ち込み、示した桁までの不等式としてだけ使う: ",
        math(String.raw`\sinh\tfrac14 \leq 0.2527`),
        "、",
        math(String.raw`\cosh\tfrac14 \leq 1.0315`),
        "、",
        math(String.raw`\log\cosh\tfrac14 \leq 0.0310`),
        "、",
        math(String.raw`\cosh\tfrac12 \leq 1.1277`),
        "、",
        math(String.raw`0.6931 \leq \log 2 \leq 0.6932`),
        "、",
        math(String.raw`\log(2\pi) \leq 1.8380`),
        "。円周率は ",
        ref("remark_real_analysis_facts_R3_R4"),
        " の ",
        math(String.raw`3.141592 \leq \pi \leq 3.141593`),
        " を使い、有理数の大小比較から ",
        math(String.raw`\pi \leq 3.1416`),
        "、",
        math(String.raw`2\pi \geq 6.283184 \geq 6.2831`),
        " である。",
        ref("pi_is_positive"),
        " の ",
        math(String.raw`0 < \pi`),
        " と ",
        math(String.raw`0 < 2`),
        " から、",
        math(String.raw`\mathbb{R}`),
        " で正の数どうしの積は正（",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）なので ",
        math(String.raw`0 < 2\pi`),
        " である。",
        math(String.raw`9.8696 \leq \pi^2`),
        " は ",
        ref("pi_squared_numerical_bounds"),
        " のものである。",
        ref("real_log_of_product"),
        " を ",
        math(String.raw`1\cdot1 = 1`),
        " に当てて ",
        math(String.raw`\log 1 = \log 1 + \log 1`),
        "、すなわち ",
        math(String.raw`\log 1 = 0`),
        " であり、",
        math(String.raw`2\pi > 1`),
        " と ",
        ref("real_log_strictly_increasing"),
        " より ",
        math(String.raw`\log(2\pi) > \log 1 = 0`),
        " である。",
      ]),
      paragraph([
        "Step 0（",
        math(String.raw`\kappa > 0`),
        " としてよいこと）。",
        "すべての実数 ",
        math(String.raw`\kappa`),
        " について、",
        ref("gamma_kappa_identity"),
        " から次の式を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
G(-\kappa)
&=\frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta,-\kappa)\,d\theta
&& (\because\ G\text{ の定義})\\
&=\frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta,\kappa)\,d\theta
&& (\because\ \blkref{gamma_kappa_identity})\\
&=G(\kappa)
&& (\because\ G\text{ の定義}).
\end{aligned}`),
      paragraph([
        "ここから ",
        math(String.raw`\kappa < 0`),
        " の場合を ",
        math(String.raw`\kappa > 0`),
        " の場合に帰着できることを、合成関数の微分で明示しておく。",
        math(String.raw`\kappa < 0`),
        " のとき ",
        math(String.raw`-\kappa > 0`),
        " なので、後述の Step 1 により ",
        math(String.raw`G`),
        " は ",
        math(String.raw`-\kappa`),
        " で 2 回微分可能である。",
        math(String.raw`G(\kappa) = G(-\kappa)`),
        " の右辺は ",
        math(String.raw`\kappa \mapsto -\kappa`),
        " と ",
        math(String.raw`G`),
        " の合成なので、合成関数の微分より ",
        math(String.raw`G`),
        " は ",
        math(String.raw`\kappa`),
        " でも微分可能で ",
        math(String.raw`G'(\kappa) = -G'(-\kappa)`),
        "。この等式の右辺をもう一度 ",
        math(String.raw`\kappa`),
        " で微分すると、同じく合成関数の微分より ",
        math(String.raw`-(-1)G''(-\kappa) = G''(-\kappa)`),
        " なので ",
        math(String.raw`G''(\kappa) = G''(-\kappa)`),
        "。したがって ",
        math(String.raw`G''(-\kappa) = G''(\kappa)`),
        " かつ ",
        math(String.raw`|G'(-\kappa)| = |G'(\kappa)|`),
        "。",
        math(String.raw`\log\frac{1}{|\kappa|}`),
        " も偶関数なので、以下 ",
        math(String.raw`0 < \kappa \leq \tfrac12`),
        " とする。",
        math(String.raw`\delta := \sinh\!\left(\tfrac{\kappa}{2}\right) > 0`),
        " とおくと ",
        ref("cosh_sinh_basic_properties"),
        " (3) と ", ref("sinh_strictly_increasing"), " より ",
        math(String.raw`0 < \delta \leq \sinh\tfrac14 \leq 0.2527`),
        "。",
      ]),
      paragraph([
        "Step 1（微分と積分の交換）。",
        ref("gamma_derivatives_in_kappa"),
        " (4) より ",
        math(String.raw`\gamma`),
        " と ",
        math(String.raw`\partial_\kappa\gamma`),
        " と ",
        math(String.raw`\partial_\kappa^2\gamma`),
        " は ",
        math(String.raw`[0,2\pi]\times[\kappa_1,\kappa_2]`),
        "（",
        math(String.raw`0<\kappa_1\leq\kappa\leq\kappa_2`),
        "）上連続なので、(R5) を 2 回適用して",
      ]),
      displayMath(
        String.raw`G'(\kappa) = \frac{1}{4\pi}\int_0^{2\pi}\frac{\partial\gamma}{\partial\kappa}\,d\theta,
\qquad
G''(\kappa) = \frac{1}{4\pi}\int_0^{2\pi}\frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta`,
      ),
      paragraph([
        ref("gamma_derivatives_in_kappa"),
        " (3) の ",
        math(String.raw`|\partial_\kappa\gamma| \leq 1`),
        " と (R3) より、次の式鎖を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
|G'(\kappa)|
&=\left|\frac{1}{4\pi}\int_0^{2\pi}\frac{\partial\gamma}{\partial\kappa}\,d\theta\right|
&& (\because\ \blkref{gamma_derivatives_in_kappa}\text{ と微分積分交換 (R5)})\\
&\leq\frac{1}{4\pi}\int_0^{2\pi}\left|\frac{\partial\gamma}{\partial\kappa}\right|\,d\theta
&& (\because\ \text{積分の三角不等式 (R3)})\\
&\leq\frac{1}{4\pi}\int_0^{2\pi}1\,d\theta
&& (\because\ \blkref{gamma_derivatives_in_kappa})\\
&=\frac{1}{4\pi}\cdot 2\pi
&& (\because\ \text{定数関数の積分 (R4)})\\
&=\frac12
&& (\because\ \mathbb R\text{ の四則}).
\end{aligned}`),
      paragraph([
        "Step 2（半区間への折り返し）。",
        math(String.raw`\sin\!\left(\tfrac{2\pi-\theta}{2}\right) = \sin\!\left(\pi - \tfrac\theta2\right) = \sin\tfrac\theta2`),
        " なので、",
        math(String.raw`\partial_\kappa^2\gamma`),
        " は ",
        math(String.raw`\theta \mapsto 2\pi-\theta`),
        " で不変である。(R6) を ",
        math(String.raw`u(s) = 2\pi - s`),
        " に適用すると ",
        math(String.raw`\int_\pi^{2\pi} = \int_0^{\pi}`),
        " となるので",
      ]),
      displayMath(String.raw`\begin{aligned}
G''(\kappa)
&=\frac{1}{4\pi}\int_0^{2\pi}\frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta
&& (\because\ \blkref{gamma_derivatives_in_kappa}\text{ と微分積分交換 (R5)})\\
&=\frac{1}{4\pi}\left(\int_0^{\pi}+\int_{\pi}^{2\pi}\right)
  \frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta
&& (\because\ \text{積分区間の分割 (R3)})\\
&=\frac{1}{4\pi}\left(\int_0^{\pi}+\int_0^{\pi}\right)
  \frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta
&& (\because\ \theta\mapsto2\pi-\theta\text{ の置換積分 (R6)})\\
&=\frac{1}{2\pi}\int_0^{\pi}\frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta
&& (\because\ \mathbb R\text{ の四則と積分の線型性 (R3)}).
\end{aligned}`),
      paragraph([
        "Step 3（2 つの項に分ける）。",
        "以下この証明の平方根はすべて ",
        ref("definition_of_sqrt_r_positive"),
        " の ",
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}`),
        " である。",
        ref("gamma_derivatives_in_kappa"),
        " (1)(2) より ",
        math(String.raw`\sinh\gamma = 2\sqrt{S(1+S)}^{(\mathbb{R}_{\ge 0})}`),
        "、",
        math(String.raw`\cosh\gamma = 1+2S`),
        "、",
        math(String.raw`S > 0`),
        " であり、",
        math(String.raw`S = \delta^2 + \sin^2\!\left(\tfrac\theta2\right)`),
        " である（",
        math(String.raw`S`),
        " の定義と ",
        math(String.raw`\delta`),
        " の定義）。",
        math(String.raw`r := \sqrt{S}^{(\mathbb{R}_{\ge 0})}`),
        "、",
        math(String.raw`t := \sqrt{1+S}^{(\mathbb{R}_{\ge 0})}`),
        " と置くと、",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`r, t \geq 0`),
        "、",
        math(String.raw`r^2 = S`),
        "、",
        math(String.raw`t^2 = 1+S`),
        " である。",
        math(String.raw`r = 0`),
        " なら ",
        math(String.raw`S = r^2 = 0`),
        " となり ",
        math(String.raw`S > 0`),
        " に反するので ",
        math(String.raw`r > 0`),
        "。",
        math(String.raw`t < 1`),
        " なら ",
        math(String.raw`1 + S = t^2 < 1`),
        " となり ",
        math(String.raw`S > 0`),
        " に反するので ",
        math(String.raw`t \geq 1`),
        "。",
        ref("sinh_double_angle_formula"),
        " と ",
        ref("gamma_derivatives_in_kappa"),
        " (1) の ",
        math(String.raw`\sinh(\tfrac\gamma2) = r`),
        "、",
        math(String.raw`\cosh(\tfrac\gamma2) = t`),
        " より ",
        math(String.raw`\sinh\gamma = 2\sinh(\tfrac\gamma2)\cosh(\tfrac\gamma2) = 2rt`),
        " である。さらに ",
        math(String.raw`J := \int_0^{\pi}\frac{d\theta}{rt}`),
        "、",
        math(String.raw`T := \int_0^{\pi}\frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\,d\theta`),
        " とおく（",
        math(String.raw`r, t`),
        " は ",
        math(String.raw`\theta`),
        " の関数である）。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta
&= \int_0^{\pi}\left(\frac{\cosh\kappa}{\sinh\gamma}
   - \frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\right)d\theta
&& (\because\ \blkref{gamma_derivatives_in_kappa}) \\
&= \int_0^{\pi}\left(\frac{\cosh\kappa}{2rt}
   - \frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\right)d\theta
&& (\because\ \sinh\gamma = 2rt) \\
&= \frac{\cosh\kappa}{2}\int_0^{\pi}\frac{d\theta}{rt}
   - \int_0^{\pi}\frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\,d\theta
&& (\because\ \text{積分の線型性 (R3)}) \\
&= \frac{\cosh\kappa}{2}\,J - T
&& (\because\ J,T\text{ の定義}).
\end{aligned}`),
      paragraph([
        "Step 4（",
        math(String.raw`J`),
        " の評価）。準備として、",
        math(String.raw`\theta \in [0,\pi]`),
        " なら ",
        math(String.raw`\tfrac\theta2 \in [0,\tfrac\pi2]`),
        " なので ",
        ref("def_sin"),
        " と ",
        ref("arcsin_is_bijection"),
        " より ",
        math(String.raw`0 \leq \sin\tfrac\theta2 \leq 1`),
        "、したがって ",
        math(String.raw`\sin^2\tfrac\theta2 \leq 1`),
        " である。これと ",
        ref("cosh_sinh_basic_properties"),
        " を使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
r^2
&= \delta^2 + \sin^2\!\left(\tfrac\theta2\right)
&& (\because\ r^2 = S\text{ と }S\text{ の表示})\\
&\leq \delta^2 + 1
&& (\because\ \sin^2\tfrac\theta2 \leq 1)\\
&= \cosh^2\!\left(\tfrac\kappa2\right)
&& (\because\ \blkref{cosh_sinh_basic_properties}\ \text{(2)}).
\end{aligned}`),
      paragraph([
        math(String.raw`r > \cosh(\tfrac\kappa2)`),
        " なら、",
        ref("cosh_sinh_basic_properties"),
        " (1) の ",
        math(String.raw`\cosh(\tfrac\kappa2) > 0`),
        " より両辺が正なので ",
        math(String.raw`r^2 > \cosh^2(\tfrac\kappa2)`),
        " となり直前の評価に反する。よって ",
        math(String.raw`r \leq \cosh(\tfrac\kappa2)`),
        " である。また ",
        math(String.raw`t+1 \geq 2 > 0`),
        "、",
        math(String.raw`t(t+1) \geq 1\cdot 2 = 2`),
        "（",
        math(String.raw`t \geq 1`),
        "）である。各点で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{r} - \frac{1}{rt}
&= \frac{1}{r}\left(1 - \frac{1}{t}\right)
&& (\because \mathbb R\text{ の分配則}) \\
&= \frac{1}{r}\cdot\frac{t-1}{t}
&& (\because \mathbb R\text{ の四則}) \\
&= \frac{1}{r}\cdot\frac{(t-1)(t+1)}{t(t+1)}
&& (\because t+1 \geq 2 > 0) \\
&= \frac{1}{r}\cdot\frac{t^2-1}{t(t+1)}
&& (\because \mathbb R\text{ の分配則}) \\
&= \frac{1}{r}\cdot\frac{S}{t(t+1)}
&& (\because t^2 = 1+S) \\
&\leq \frac{1}{r}\cdot\frac{S}{2}
&& (\because t(t+1)\geq2,\ \tfrac{S}{r} > 0) \\
&= \frac{r^2}{2r}
&& (\because S = r^2) \\
&= \frac{r}{2}
&& (\because r>0) \\
&\leq \frac{\cosh\!\left(\frac{\kappa}{2}\right)}{2}
&& (\because r \leq \cosh(\tfrac\kappa2)).
\end{aligned}`,
      ),
      paragraph([
        "鎖の中の ",
        math(String.raw`\frac{1}{r}\cdot\frac{S}{t(t+1)}`),
        " は ",
        math(String.raw`r > 0`),
        "、",
        math(String.raw`S > 0`),
        "、",
        math(String.raw`t(t+1) > 0`),
        " より正なので、",
        math(String.raw`0 \leq \frac1r - \frac1{rt}`),
        " でもある。この各点評価は **符号のついた片側の評価** である。(R3) の単調性を ",
        math(String.raw`[0,\pi]`),
        " 上で使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&\leq \int_0^{\pi}\left(\frac{1}{r}-\frac{1}{rt}\right)d\theta
&& (\because\ \text{直前の各点評価と積分の単調性 (R3)})\\
&=\int_0^{\pi}\frac{d\theta}{r}-J
&& (\because\ J\text{ の定義と積分の線型性 (R3)})\\
&\leq\int_0^{\pi}\frac{\cosh(\kappa/2)}{2}\,d\theta
&& (\because\ \text{直前の各点評価と積分の単調性 (R3)})\\
&=\frac{\pi}{2}\cosh\!\left(\frac{\kappa}{2}\right)
&& (\because\ \text{定数関数の積分 (R4)}).
\end{aligned}`),
      paragraph([
        ref("sine_integral_two_sided"),
        " を ",
        math(String.raw`\delta = \sinh(\tfrac\kappa2)`),
        " に適用し、",
        math(String.raw`R_0 := \displaystyle\int_0^{\pi}\frac{d\theta}{r}-2\log\frac{\pi}{\delta}`),
        " とおく。このとき ",
        math(String.raw`0 \leq R_0 \leq \frac{2\delta^2}{\pi^2} + B`),
        " である（",
        math(String.raw`B`),
        " は ",
        ref("def_sine_integral_constant"),
        " のもの）。",
        math(String.raw`R := J - 2\log\frac{\pi}{\delta}`),
        " とおく。先に得た差の評価を使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
R
&=J-2\log\frac{\pi}{\delta}
&& (\because\ R\text{ の定義})\\
&=R_0-\left(\int_0^{\pi}\frac{d\theta}{r}-J\right)
&& (\because\ R_0\text{ の定義と }\mathbb R\text{ の四則}).
\end{aligned}`),
      paragraph(["直前の差の評価から下界を、", ref("sine_integral_two_sided"), " から上界をそれぞれ得る。"]),
      displayMath(String.raw`\begin{aligned}
R
&\geq-\left(\int_0^{\pi}\frac{d\theta}{r}-J\right)
&& (\because\ R_0\geq0)\\
&\geq-\frac{\pi}{2}\cosh\!\left(\frac{\kappa}{2}\right)
&& (\because\ \text{直前の差の評価}),\\[2pt]
R
&\leq R_0
&& (\because\ \int_0^{\pi}\frac{d\theta}{r}-J\geq0)\\
&\leq\frac{2\delta^2}{\pi^2}+B
&& (\because\ \blkref{sine_integral_two_sided}).
\end{aligned}`),
      displayMath(String.raw`J=2\log\frac{\pi}{\delta}+R\qquad(\because\ R\text{ の定義}).`),
      paragraph([
        "したがって ",
        math(String.raw`|R| \leq \max\left\{\frac{2\delta^2}{\pi^2} + B,\ \frac{\pi}{2}\cosh\!\left(\frac{\kappa}{2}\right)\right\}`),
        " である。",
        math(String.raw`\kappa \leq \tfrac12`),
        " のとき ",
        math(String.raw`\cosh(\tfrac\kappa2) \leq \cosh\tfrac14 \leq 1.0315`),
        "（",
        ref("cosh_monotone_on_nonnegative"),
        "）、",
        math(String.raw`\delta \leq 0.2527`),
        "、",
        math(String.raw`9.8696 \leq \pi^2`),
        "、",
        math(String.raw`\pi \leq 3.1416`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
|R|
&\leq\max\left\{\frac{2\cdot 0.2527^2}{9.8696}+0.88,\ \frac{3.1416}{2}\cdot1.0315\right\}
&&\bigl(\because\ \text{直前の }|R|\text{ の評価と数値上下界。}B \leq 0.88\ \text{は}\ \blkref{sine_integral_constant_numerical_bound}\bigr)\\
&\leq\max\left\{0.0130+0.88,\ 1.6203\right\}
&&\bigl(\because\ \text{有理数の四則}\bigr)\\
&\leq1.621
&&\bigl(\because\ \text{有理数の大小比較}\bigr).
\end{aligned}`),
      paragraph([
        "Step 5（",
        math(String.raw`T`),
        " の評価）。3/2 乗は ",
        ref("def_three_halves_power"),
        " のものである。Step 3 の ",
        math(String.raw`r, t`),
        " を使う。",
        math(String.raw`S^{3/2} = S\,r = r^3`),
        "（",
        ref("def_three_halves_power"),
        " と ",
        math(String.raw`r^2 = S`),
        "）である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\cosh\gamma}{\sinh^3\gamma}
&= \frac{1+2S}{(2rt)^3}
&& (\because\ \blkref{gamma_derivatives_in_kappa}\text{ と }\sinh\gamma = 2rt) \\
&= \frac{1+2S}{8\,r^3t^3}
&& (\because\ \text{積の冪}) \\
&\leq \frac{2(1+S)}{8\,r^3t^3}
&& (\because\ 1+2S\leq2+2S,\ 8r^3t^3>0) \\
&= \frac{2t^2}{8\,r^3t^3}
&& (\because\ t^2 = 1+S) \\
&= \frac{1}{4\,r^3t}
&& (\because\ \mathbb R\text{ の四則}) \\
&\leq \frac{1}{4\,r^3}
&& (\because\ t\geq1,\ r>0) \\
&= \frac{1}{4\,S^{3/2}}
&& (\because\ S^{3/2} = r^3).
\end{aligned}`,
      ),
      paragraph([
        "また 2 行目の値は ",
        math(String.raw`1+2S > 0`),
        "、",
        math(String.raw`8r^3t^3 > 0`),
        " なので正であり、",
        math(String.raw`\sinh^2\kappa \geq 0`),
        " と合わせて、",
      ]),
      displayMath(String.raw`\begin{aligned}
T
&=\int_0^{\pi}\frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\,d\theta
&& (\because\ T\text{ の定義})\\
&\geq\int_0^{\pi}0\,d\theta
&& (\because\ \text{被積分関数}\geq0\text{ と積分の単調性 (R3)})\\
&=0
&& (\because\ \text{定数関数の積分 (R4)}).
\end{aligned}`),
      paragraph([
        ref("sine_half_angle_linear_bounds"),
        " より ",
        math(String.raw`\sin\!\left(\tfrac\theta2\right) \geq c_0\tfrac\theta2 \geq 0`),
        " なので、両辺を 2 乗して ",
        math(String.raw`S \geq w := \delta^2 + \dfrac{c_0^2\theta^2}{4} \geq \delta^2 > 0`),
        "。",
        math(String.raw`\sqrt{w}^{(\mathbb{R}_{\ge 0})} \leq r`),
        "（逆なら両辺が 0 以上なので ",
        math(String.raw`w > r^2 = S`),
        " となり矛盾）から ",
        math(String.raw`w^{3/2} = w\sqrt{w}^{(\mathbb{R}_{\ge 0})} \leq S\,r = S^{3/2}`),
        "、したがって ",
        math(String.raw`\dfrac{1}{S^{3/2}} \leq \dfrac{1}{w^{3/2}}`),
        " である。(R3) と ",
        ref("three_halves_power_integral_bound"),
        "（",
        math(String.raw`a = c_0`),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T
&= \int_0^{\pi}\sinh^2\kappa\cdot\frac{\cosh\gamma}{\sinh^3\gamma}\,d\theta
&& (\because T\text{ の定義}) \\
&\leq \int_0^{\pi}\sinh^2\kappa\cdot\frac{1}{4S^{3/2}}\,d\theta
&& (\because \text{直前の各点評価に }\sinh^2\kappa\geq0\text{ を掛け、(R3) の単調性}) \\
&= \frac{\sinh^2\kappa}{4}\int_0^{\pi}\frac{d\theta}{S^{3/2}}
&& (\because \text{(R3) の線型性}) \\
&\leq \frac{\sinh^2\kappa}{4}\int_0^{\pi}\frac{d\theta}{\left(\delta^2+\frac{c_0^2\theta^2}{4}\right)^{3/2}}
&& (\because \tfrac{1}{S^{3/2}}\leq\tfrac{1}{w^{3/2}}\text{ と (R3) の単調性}) \\
&\leq \frac{\sinh^2\kappa}{4}\cdot\frac{2}{c_0\delta^2}
&& (\because \blkref{three_halves_power_integral_bound}) \\
&= \frac{4\delta^2\cosh^2\!\left(\frac{\kappa}{2}\right)}{4}\cdot\frac{2}{c_0\delta^2}
&& (\because \blkref{sinh_double_angle_formula}:\ \sinh\kappa=2\delta\cosh(\tfrac\kappa2)) \\
&= \frac{2\cosh^2\!\left(\frac{\kappa}{2}\right)}{c_0}
&& (\because \delta>0\text{ と }\mathbb R\text{ の四則}) \\
&\leq \frac{2\cdot 1.0315^2}{0.5887}
&& (\because \kappa \leq \tfrac12,\ \cosh(\tfrac\kappa2)\leq\cosh\tfrac14\leq1.0315\ (\blkref{cosh_monotone_on_nonnegative}),\ \blkref{sine_bound_constant_numerical_bounds}:c_0\geq0.5887) \\
&\leq 3.615
&& (\because \text{有理数の大小比較})
\end{aligned}`,
      ),
      paragraph([
        "Step 6（",
        math(String.raw`\log\frac{\pi}{\delta}`),
        " を ",
        math(String.raw`\log\frac1\kappa`),
        " に直す）。",
        ref("sinh_at_least_argument"),
        " と ", ref("sinh_at_most_argument_times_cosh"), " を ",
        math(String.raw`\tfrac\kappa2 \in \mathbb{R}_{\geq 0}`),
        " に適用すると ",
        math(String.raw`\tfrac\kappa2 \leq \delta \leq \tfrac\kappa2\cosh\tfrac\kappa2`),
        " となる。正の数の逆数の順序と対数の単調性を順に使う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{2}{\cosh\!\left(\frac{\kappa}{2}\right)}
&\leq\frac{\kappa}{\delta}
&& (\because\ \delta\leq\frac\kappa2\cosh\!\left(\frac\kappa2\right),\ \kappa,\delta>0)\\
&\leq 2
&& (\because\ \frac\kappa2\leq\delta),\\[2pt]
-\log\cosh\!\left(\frac{\kappa}{2}\right)
&=\log\frac{2}{\cosh\!\left(\frac{\kappa}{2}\right)}-\log 2
&& (\because\ \blkref{real_log_of_product})\\
&\leq\log\frac{\kappa}{\delta}-\log 2
&& (\because\ \text{直前の左辺の評価と }\blkref{real_log_strictly_increasing})\\
&\leq\log 2-\log 2
&& (\because\ \text{直前の右辺の評価と }\blkref{real_log_strictly_increasing})\\
&=0
&& (\because\ \mathbb R\text{ の四則}).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\rho := \log\frac{\kappa}{\delta} - \log 2`),
        " とおく。直前の評価と ", ref("cosh_monotone_on_nonnegative"),
        " を用いると、",
      ]),
      displayMath(String.raw`\cosh\!\left(\frac\kappa2\right)\leq\cosh\tfrac14
\quad(\because\ 0<\kappa\leq\tfrac12\text{ と }\blkref{cosh_monotone_on_nonnegative}).`),
      displayMath(String.raw`\begin{aligned}
\log\frac{\pi}{\delta}
&=\log\frac1\kappa+\log\pi+\log\frac\kappa\delta
&& (\because\ \blkref{real_log_of_product})\\
&=\log\frac1\kappa+\log(2\pi)+\left(\log\frac\kappa\delta-\log2\right)
&& (\because\ \blkref{real_log_of_product})\\
&=\log\frac1\kappa+\log(2\pi)+\rho
&& (\because\ \rho\text{ の定義}),\\[2pt]
|\rho|
&\leq\log\cosh\!\left(\frac\kappa2\right)
&& (\because\ -\log\cosh\!\left(\frac\kappa2\right)\leq\rho\leq0)\\
&\leq\log\cosh\tfrac14
&& (\because\ \text{直前の評価と }\blkref{real_log_strictly_increasing})\\
&\leq0.0310
&& (\because\ \text{数値の評価 }\log\cosh\tfrac14\leq0.0310).
\end{aligned}`),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
\cosh\kappa\,\log\frac{\pi}{\delta} - \log\frac{1}{\kappa}
&= \cosh\kappa\left(\log\frac1\kappa+\log(2\pi)+\rho\right) - \log\frac{1}{\kappa}
&& (\because\ \text{直前の }\log\tfrac\pi\delta\text{ の表示})\\
&= \left(\cosh\kappa - 1\right)\log\frac{1}{\kappa}
 + \cosh\kappa\left(\log(2\pi) + \rho\right)
&& (\because\ \mathbb R\text{ の分配則}).
\end{aligned}`,
      ),
      paragraph(["右辺第 1 項は、", ref("cosh_half_angle_formula"), " と ", ref("sinh_at_most_argument_times_cosh"), " より"]),
      displayMath(String.raw`\begin{aligned}
\cosh\kappa-1
&=2\sinh^2\!\left(\frac\kappa2\right)
&&\bigl(\because\ \blkref{cosh_half_angle_formula}\bigr)\\
&\leq2\left(\frac\kappa2\cosh\frac\kappa2\right)^2
&&\bigl(\because\ \blkref{sinh_at_most_argument_times_cosh}\text{ を }\tfrac\kappa2\text{ に。両辺は }0\text{ 以上なので 2 乗しても向きは保たれる}\bigr)\\
&\leq2\left(\frac\kappa2\cosh\frac14\right)^2
&&\bigl(\because\ \blkref{cosh_monotone_on_nonnegative}\text{ と }0<\kappa\leq\tfrac12\bigr)\\
&\leq0.532\,\kappa^2
&&\bigl(\because\ \cosh\tfrac14\text{ の数値上界}\bigr).
\end{aligned}`),
      paragraph([
        "次に ",
        math(String.raw`F(s) := -s^2\log s`),
        "（",
        math(String.raw`s \in [\kappa, \tfrac12]`),
        "）と置く。",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式（積・恒等関数・",
        math(String.raw`\log'(x) = 1/x`),
        "）より ",
        math(String.raw`F`),
        " は微分可能で ",
        math(String.raw`F'(s) = -2s\log s - s^2\cdot\tfrac1s = s\left(-2\log s - 1\right)`),
        " である。",
        math(String.raw`F'`),
        " も同じ公式から微分可能なので、「微分可能な関数は連続である」より連続である。",
        math(String.raw`0 < s \leq \tfrac12`),
        " なら ",
        ref("real_log_strictly_increasing"),
        " と ",
        ref("real_log_of_product"),
        "（",
        math(String.raw`\log\tfrac12 + \log 2 = \log 1 = 0`),
        "）より ",
        math(String.raw`\log s \leq \log\tfrac12 = -\log 2 \leq -0.6931`),
        "、したがって ",
        math(String.raw`-2\log s - 1 \geq 0.3862 > 0`),
        " で ",
        math(String.raw`F'(s) > 0`),
        " である。また ",
        math(String.raw`\log\tfrac1\kappa = -\log\kappa`),
        "（",
        ref("real_log_of_product"),
        " を ",
        math(String.raw`\kappa\cdot\tfrac1\kappa = 1`),
        " に）なので ",
        math(String.raw`\kappa^2\log\tfrac1\kappa = F(\kappa)`),
        " である。",
        math(String.raw`\tfrac1\kappa \geq 2 > 1`),
        " と ",
        ref("real_log_strictly_increasing"),
        " より ",
        math(String.raw`\log\tfrac1\kappa > \log 1 = 0`),
        "（",
        math(String.raw`\log 1 = 0`),
        " は数値の評価の段）、",
        ref("cosh_at_least_one"),
        " より ",
        math(String.raw`\cosh\kappa - 1 \geq 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa^2\log\frac1\kappa
&=F(\kappa)
&&\bigl(\because\ \text{直前の式}\bigr)\\
&=F\!\left(\tfrac12\right)-\int_\kappa^{1/2}F'(s)\,ds
&&\bigl(\because\ \text{(R4) を }F\text{ で}\bigr)\\
&\leq F\!\left(\tfrac12\right)-\int_\kappa^{1/2}0\,ds
&&\bigl(\because\ F'\geq0\text{ と積分の単調性 (R3)}\bigr)\\
&=F\!\left(\tfrac12\right)
&&\bigl(\because\ \text{(R4) を定数関数 }0\text{ で}\bigr)\\
&=\tfrac14\log2
&&\bigl(\because\ F\text{ の定義と }-\log\tfrac12=\log2\bigr)\\
&\leq0.1733
&&\bigl(\because\ \log2\leq0.6932\bigr).
\end{aligned}`),
      paragraph(["これを使うと"]),
      displayMath(String.raw`\begin{aligned}
0&\leq(\cosh\kappa-1)\log\frac1\kappa
&&\bigl(\because\ \cosh\kappa-1\geq0,\ \log\tfrac1\kappa>0\bigr)\\
&\leq0.532\,\kappa^2\log\frac1\kappa
&&\bigl(\because\ \text{直前の }\cosh\kappa-1\text{ の上界と }\log\tfrac1\kappa>0\bigr)\\
&\leq0.532\cdot0.1733
&&\bigl(\because\ \kappa^2\log(1/\kappa)\leq0.1733\bigr)\\
&\leq0.093
&&\bigl(\because\ \text{有理数の大小比較}\bigr).
\end{aligned}`),
      paragraph([
        "第 2 項は ",
        math(String.raw`\cosh\kappa \leq \cosh\tfrac12 \leq 1.1277`),
        "（",
        ref("cosh_monotone_on_nonnegative"),
        "）、",
        math(String.raw`\log(2\pi) \leq 1.8380`),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\cosh\kappa\left(\log(2\pi)+\rho\right)\right|
&\leq\cosh\kappa\left(\left|\log(2\pi)\right|+|\rho|\right)
&&\bigl(\because\ \cosh\kappa>0\text{ と三角不等式}\bigr)\\
&\leq1.1277\left(1.8380+0.0310\right)
&&\bigl(\because\ 0<\log(2\pi)\leq1.8380,\ \cosh\kappa\leq1.1277,\ |\rho|\leq0.0310\bigr)\\
&\leq2.108
&&\bigl(\because\ \text{有理数の大小比較}\bigr).
\end{aligned}`),
      paragraph(["以上を合わせると"]),
      displayMath(
        String.raw`\begin{aligned}
\left|\cosh\kappa\,\log\frac{\pi}{\delta} - \log\frac{1}{\kappa}\right|
&\leq 0.093+2.108
&&\bigl(\because\ \text{直前の二項の上界と三角不等式}\bigr)\\
&=2.201
&&\bigl(\because\ \text{有理数の加法}\bigr).
\end{aligned}`,
      ),
      paragraph(["Step 7（総合）。Step 2〜6 より"]),
      displayMath(
        String.raw`\begin{aligned}
2\pi\,G''(\kappa)
&= \frac{\cosh\kappa}{2}J - T
&&\bigl(\because\ \text{Step 2 と Step 3}\bigr) \\
&= \frac{\cosh\kappa}{2}\left(2\log\frac{\pi}{\delta} + R\right) - T
&&\bigl(\because\ \text{Step 4 の }J\text{ の表示}\bigr) \\
&= \cosh\kappa\,\log\frac{\pi}{\delta} + \frac{\cosh\kappa}{2}R - T
&&\bigl(\because\ \mathbb R\text{ の分配則}\bigr)
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\left|2\pi\,G''(\kappa) - \log\frac{1}{\kappa}\right|
&\leq \left|\cosh\kappa\,\log\frac{\pi}{\delta} - \log\frac{1}{\kappa}\right|
 + \frac{\cosh\kappa}{2}|R| + |T|
&&\bigl(\because\ \text{直前の }G''\text{ の表示と三角不等式}\bigr) \\
&\leq 2.201 + \frac{1.1277}{2}\cdot 1.621 + 3.615
&&\bigl(\because\ \text{Step 4、Step 5（}T\geq0\text{ より }|T|=T\text{）、Step 6 の上界}\bigr) \\
&\leq 2.201 + 0.915 + 3.615
&&\bigl(\because\ \tfrac{1.1277}{2}\cdot1.621\leq0.915\bigr) \\
&= 6.731
&&\bigl(\because\ \text{有理数の加法}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`2\pi \geq 6.2831`),
        " で割ると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|G''(\kappa)-\frac{1}{2\pi}\log\frac{1}{\kappa}\right|
&=\frac{1}{2\pi}\left|2\pi G''(\kappa)-\log\frac{1}{\kappa}\right|
&&\bigl(\because\ \text{準備の}\ 0<2\pi\bigr)\\
&\leq\frac{6.731}{2\pi}
&&\bigl(\because\ \text{直前の総合評価}\bigr)\\
&\leq\frac{6.731}{6.2831}
&&\bigl(\because\ 2\pi\geq6.2831\bigr)\\
&\leq1.08
&&\bigl(\because\ \text{有理数の大小比較}\bigr)\\
&\leq\frac65
&&\bigl(\because\ \text{有理数の大小比較}\bigr).
\end{aligned}`,
      ),
      paragraph(["上の評価と ", math(String.raw`\log(1/|\kappa|)\to+\infty`), "（", math(String.raw`\kappa\to0`), "）から" ]),
      displayMath(String.raw`\begin{aligned}
G''(\kappa)
&\geq\frac{1}{2\pi}\log\frac{1}{|\kappa|}-\frac65
&&\bigl(\because\ \text{直前の絶対値評価}\bigr),\\
\frac{1}{2\pi}\log\frac{1}{|\kappa|}-\frac65
&\longrightarrow+\infty
&&\bigl(\because\ \log(1/|\kappa|)\to+\infty,\ \text{準備の}\ 0<2\pi\bigr).
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 準備に pi_is_positive の 0 < π と 0 < 2（ℝ は順序体で、正の数どうしの積は正）から 0 < 2π を出す文を置き、根拠「2π > 0」の 2 か所をその参照にした。値と主張は不変。",
        "定数 6/5 は最適化していない（証明中の各段の評価をそのまま足した結果 1.08 以下）。数値では実際の |G'' - (1/2π)log(1/|κ|)| の上限は 0.13 程度である（sagemath/check/055_claim_critical_point/check_04）。",
        "2026-11-05（全証明の SageMath 検算）: 平方根を √·^(ℝ≥0) の記法にそろえ、Step 3 で r := √S、t := √(1+S) と置いて r > 0・t ≥ 1 を示し、sinh γ = 2rt（sinh_double_angle_formula と gamma_derivatives_in_kappa (1)）で書き直した（以前の Step 4 は 1/√(S(1+S)) = (1/√S)(1/√(1+S)) を「ℝ の四則」としていた）。Step 4 の各点評価を r, t の鎖に、Step 5 の (S(1+S))^{3/2} = S^{3/2}(1+S)^{3/2}（本文に無い冪法則）を r³t³ の鎖にし、w^{3/2} ≤ S^{3/2} の理由を書いた。T ≥ 0 を示していなかった（Step 7 で |T| ≤ 3.615 に使う）ので足した。Step 6 の κ² log(1/κ) の単調増加は導関数の正から言っており平均値の定理（remark_real_analysis_escape_chapter_E が使わないとした道具）に当たるので、F(s) := −s² log s に (R4)・(R3) を当てる鎖にした。初等関数の値の数値の評価（sinh(1/4)・cosh(1/4)・log cosh(1/4)・cosh(1/2)・log 2・log(2π) の上界）を remark_real_analysis_escape_chapter_E が持ち込むものとして明記し（π ≤ 3.1416・2π ≥ 6.2831 は remark_real_analysis_facts_R3_R4 の π の評価から、log(2π) > 0 は対数の単調性から導いた）、Step 4 の r ≤ cosh(κ/2) と sin²(θ/2) ≤ 1 を根拠付きの準備にし、Step 5・6 の複数の根拠を 1 行で使っていた行を割り、F' の連続性・log(1/κ) > 0・cosh κ ≥ 1 の根拠を書き、cosh の単調性・対数の積の法則・対数の単調性をラベルで引いた。主張と定数は不変。検算は sagemath/check/second_derivative_log_divergence/。",
      ],
    },
  },
  {
    id: "critical_012_theorem_specific_heat_log_divergence",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 14 },
    title: { tex: String.raw`\left|\frac{d^2f}{dK^2} - \frac{8}{\pi}\log\frac{1}{|\kappa(K)|}\right| \leq 45` },
    labels: ["specific_heat_log_divergence"],
    statement: [
      paragraph([
        ref("onsager_exact_solution"),
        " の自由エネルギーを、等方な場合 ",
        math(String.raw`K_1 = K_2 = K \in \mathbb{R}_{>0}`),
        " について",
      ]),
      displayMath(
        String.raw`f(K) := \frac{1}{2}\log\left(2\sinh 2K\right) + G\!\left(\kappa(K)\right)`,
      ),
      paragraph([
        "と書く（",
        ref("second_derivative_log_divergence"),
        " の ",
        math(String.raw`G`),
        " と ",
        ref("kappa_of_K_basic"),
        " の ",
        math(String.raw`\kappa(K)`),
        "）。このとき ",
        math(String.raw`0 < |K-K_c| \leq \tfrac{1}{10}`),
        " なる ",
        math(String.raw`K`),
        " について ",
        math(String.raw`f`),
        " は 2 回微分可能で",
      ]),
      displayMath(
        String.raw`\left|\frac{d^2f}{dK^2}(K) - \frac{8}{\pi}\log\frac{1}{\left|\kappa(K)\right|}\right| \ \leq\ 45`,
      ),
      paragraph([
        "が成り立つ。さらに ",
        ref("kappa_of_K_basic"),
        " (5) より ",
        math(String.raw`3.53|K-K_c| \leq |\kappa(K)| \leq 4.72|K-K_c|`),
        " なので",
      ]),
      displayMath(
        String.raw`\left|\frac{d^2f}{dK^2}(K) - \frac{8}{\pi}\log\frac{1}{\left|K-K_c\right|}\right| \ \leq\ 49`,
      ),
      paragraph([
        "も成り立つ。とくに",
      ]),
      displayMath(
        String.raw`\frac{8}{\pi}\log\frac{1}{\left|K-K_c\right|} - 49
\ \leq\ \frac{d^2f}{dK^2}(K)
\ \leq\ \frac{8}{\pi}\log\frac{1}{\left|K-K_c\right|} + 49`,
      ),
      paragraph([
        "であり、**臨界点 ",
        math(String.raw`K \to K_c`),
        "（",
        math(String.raw`\sinh 2K_1\sinh 2K_2 = 1`),
        "、",
        ref("critical_point_iff_kappa_zero"),
        "）で ",
        math(String.raw`\dfrac{d^2f}{dK^2} \to +\infty`),
        " が係数 ",
        math(String.raw`\dfrac{8}{\pi}`),
        " の対数発散として起こる**：",
      ]),
      displayMath(
        String.raw`\lim_{K\to K_c}\ \frac{\dfrac{d^2f}{dK^2}(K)}{\log\dfrac{1}{\left|K-K_c\right|}} = \frac{8}{\pi}`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`f`),
        " が主張の形に書けること）。",
        ref("onsager_exact_solution"),
        " の自由エネルギーは ",
        math(String.raw`\frac12\log(2\sinh 2K_2) + \frac1{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`),
        " であり、",
        math(String.raw`K_1=K_2=K`),
        " のとき ",
        ref("isotropic_gamma_in_kappa"),
        " より ",
        math(String.raw`\gamma(\theta) = \gamma(\theta,\kappa(K))`),
        "（",
        ref("gamma_derivatives_in_kappa"),
        " の記法）なので、積分項は ",
        math(String.raw`G(\kappa(K))`),
        " に一致する。",
      ]),
      paragraph([
        "Step 2（第 1 項の 2 階微分）。",
        math(String.raw`\sinh 2K > 0`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{d}{dK}\left(\frac12\log\left(2\sinh 2K\right)\right)
&= \frac12\cdot\frac{2\cosh 2K}{\sinh 2K}
   \quad (\because \log \text{ の微分と } (\sinh)'=\cosh) \\
&= \frac{\cosh 2K}{\sinh 2K}
   \quad (\because \mathbb R\text{ の四則}) \\
\frac{d^2}{dK^2}\left(\frac12\log\left(2\sinh 2K\right)\right)
&= \frac{2\sinh 2K\cdot\sinh 2K - \cosh 2K\cdot 2\cosh 2K}{\sinh^2 2K}
   \quad (\because \text{商の微分}) \\
&= \frac{2\left(\sinh^2 2K - \cosh^2 2K\right)}{\sinh^2 2K}
   \quad (\because \mathbb R\text{ の分配律}) \\
&= -\frac{2}{\sinh^2 2K}
   \quad (\because \text{cosh\_sinh\_basic\_properties (2)})
\end{aligned}`,
      ),
      paragraph([
        ref("kappa_of_K_basic"),
        " (4) の ",
        math(String.raw`\sinh 2K \geq 0.7353`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\frac{d^2}{dK^2}\left(\frac12\log\left(2\sinh 2K\right)\right)\right|
&=\left|-\frac{2}{\sinh^2 2K}\right|
   \quad (\because \text{直前の二階微分の等式}) \\
&=\frac{2}{\sinh^2 2K}
   \quad (\because \sinh 2K>0) \\
&\leq\frac{2}{0.7353^2}
   \quad (\because \sinh 2K\geq 0.7353\text{ と正数の逆数の単調性}) \\
&\leq 3.70
   \quad (\because \mathbb R\text{ の有理数計算})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（第 2 項の 2 階微分）。",
        math(String.raw`0<|K-K_c|\leq\tfrac1{10}`),
        " のとき ",
        ref("kappa_of_K_basic"),
        " (2)(5) より ",
        math(String.raw`0 < |\kappa(K)| \leq 0.472 \leq \tfrac12`),
        " なので、",
        ref("second_derivative_log_divergence"),
        " が適用できる。合成関数の微分より",
      ]),
      displayMath(
        String.raw`\frac{d^2}{dK^2}G\!\left(\kappa(K)\right)
= G''\!\left(\kappa(K)\right)\kappa'(K)^2 + G'\!\left(\kappa(K)\right)\kappa''(K)
\qquad(\because\ \text{合成関数の微分を二度適用})`,
      ),
      paragraph([
        "第 2 項は ",
        ref("second_derivative_log_divergence"),
        " の ",
        math(String.raw`|G'| \leq \tfrac12`),
        " と ",
        ref("kappa_of_K_basic"),
        " (4) の ",
        math(String.raw`|\kappa''| \leq 9.19`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|G'\!\left(\kappa(K)\right)\kappa''(K)\right|
&=\left|G'\!\left(\kappa(K)\right)\right|\left|\kappa''(K)\right|
   \qquad(\because\ \text{絶対値の積の性質})\\
&\leq\frac12\cdot9.19
   \qquad(\because\ \text{second\_derivative\_log\_divergence と kappa\_of\_K\_basic (4)})\\
&\leq4.60
   \qquad(\because\ \mathbb R\text{ の有理数計算}).
\end{aligned}`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`\kappa'^2`),
        " を ",
        math(String.raw`16`),
        " に置き換える誤差）。",
        ref("kappa_of_K_basic"),
        " (5) の ",
        math(String.raw`\left|\kappa'(K)^2-16\right| \leq 24.7|\kappa|`),
        " と ",
        ref("second_derivative_log_divergence"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\left(\kappa'(K)^2 - 16\right)G''\!\left(\kappa\right)\right|
&\leq 24.7\,|\kappa|\left(\frac{1}{2\pi}\log\frac{1}{|\kappa|} + \frac65\right)
   \quad (\because \blkref{kappa_of_K_basic}\text{ (5) と }\blkref{second_derivative_log_divergence}) \\
&= 24.7\left(\frac{1}{2\pi}\,|\kappa|\log\frac{1}{|\kappa|} + \frac65|\kappa|\right)
   \quad (\because \mathbb R\text{ の分配律}) \\
&\leq 24.7\left(\frac{1}{2\pi}\cdot\frac1e + \frac65\cdot 0.472\right)
   \quad (\because |\kappa| \leq 0.472\text{ と下記の } |\kappa|\log\tfrac1{|\kappa|}\leq \tfrac1e) \\
&\leq 24.7\left(0.0586 + 0.5664\right)
   \quad (\because \mathbb R\text{ の有理数評価}) \\
&\leq 15.44
   \quad (\because \mathbb R\text{ の有理数計算})
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`x\log\frac1x`),
        " は ",
        math(String.raw`(0,1]`),
        " 上 ",
        math(String.raw`x = \tfrac1e`),
        " で最大値 ",
        math(String.raw`\tfrac1e`),
        " をとる（導関数 ",
        math(String.raw`\log\frac1x - 1`),
        " の符号）。",
      ]),
      paragraph([
        "Step 5（主要項）。",
        ref("second_derivative_log_divergence"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|16\,G''(\kappa) - \frac{8}{\pi}\log\frac{1}{|\kappa|}\right|
&=16\left|G''(\kappa) - \frac{1}{2\pi}\log\frac{1}{|\kappa|}\right|
&&\bigl(\because\ \mathbb R\text{ の分配律と絶対値の積の性質}\bigr)\\
&\leq16\cdot\frac65
&&\bigl(\because\ \blkref{second_derivative_log_divergence}\bigr)\\
&=19.2
&&\bigl(\because\ \mathbb R\text{ の有理数計算}\bigr).
\end{aligned}`,
      ),
      paragraph(["Step 6（総合）。Step 2〜5 と三角不等式より"]),
      displayMath(
        String.raw`\begin{aligned}
\left|\frac{d^2f}{dK^2} - \frac{8}{\pi}\log\frac{1}{|\kappa|}\right|
&=\left|\frac{d^2}{dK^2}\left(\tfrac12\log(2\sinh 2K)\right)
 +G'\kappa''+(\kappa'^2-16)G''+16G''-\frac{8}{\pi}\log\frac{1}{|\kappa|}\right|
&&\bigl(\because\ \text{Step 1 の表式、Step 3 の合成関数の微分と分配律}\bigr)\\
&\leq \left|\frac{d^2}{dK^2}\left(\tfrac12\log(2\sinh 2K)\right)\right|
 + \left|G'\kappa''\right|
 + \left|\left(\kappa'^2-16\right)G''\right|
 + \left|16G'' - \frac{8}{\pi}\log\frac{1}{|\kappa|}\right|
&&\bigl(\because\ \mathbb R\text{ の三角不等式}\bigr)\\
&\leq 3.70 + 4.60 + 15.44 + 19.2
&&\bigl(\because\ \text{Step 2、Step 3、Step 4、Step 5 の評価}\bigr)\\
&= 42.94
&&\bigl(\because\ \mathbb R\text{ の有理数計算}\bigr)\\
&\leq 45
&&\bigl(\because\ \mathbb R\text{ の有理数の順序}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "Step 7（",
        math(String.raw`|K-K_c|`),
        " による表示）。",
        ref("kappa_of_K_basic"),
        " (5) より ",
        math(String.raw`3.53 \leq \dfrac{|\kappa|}{|K-K_c|} \leq 4.72`),
        " なので、",
        math(String.raw`\log`),
        " の単調性より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\log\frac{1}{|\kappa|} - \log\frac{1}{|K-K_c|}\right|
&= \left|\log\frac{|K-K_c|}{|\kappa|}\right|
&&\bigl(\because\ \log A-\log B=\log(A/B)\bigr)\\
&= \left|\log\frac{|\kappa|}{|K-K_c|}\right|
&&\bigl(\because\ \log(1/r)=-\log r\bigr)\\
&= \log\frac{|\kappa|}{|K-K_c|}
&&\bigl(\because\ 3.53\leq |\kappa|/|K-K_c|\bigr)\\
&\leq \log 4.72
&&\bigl(\because\ \blkref{kappa_of_K_basic}\text{ (5) と対数の単調性}\bigr)\\
&\leq 1.5519
&&\bigl(\because\ \log 4.72\leq1.5519\bigr).
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\left|\frac{d^2f}{dK^2} - \frac{8}{\pi}\log\frac{1}{|K-K_c|}\right|
&\leq \left|\frac{d^2f}{dK^2} - \frac{8}{\pi}\log\frac{1}{|\kappa|}\right|
+\frac{8}{\pi}\left|\log\frac{1}{|\kappa|}-\log\frac{1}{|K-K_c|}\right|
&&\bigl(\because\ \mathbb R\text{ の三角不等式}\bigr)\\
&\leq 45+\frac{8}{\pi}\cdot1.5519
&&\bigl(\because\ \text{Step 6 と直前の評価}\bigr)\\
&\leq 45+3.96
&&\bigl(\because\ 8\cdot1.5519/\pi\leq3.96\bigr)\\
&\leq49
&&\bigl(\because\ \mathbb R\text{ の有理数の順序}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "Step 8（極限）。",
        math(String.raw`K \to K_c`),
        " のとき ",
        math(String.raw`\log\frac{1}{|K-K_c|} \to +\infty`),
        " なので、Step 7 の評価の各辺を ",
        math(String.raw`\log\frac{1}{|K-K_c|} > 0`),
        " で割ると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\leq\left|\frac{\dfrac{d^2f}{dK^2}}{\log\dfrac{1}{|K-K_c|}} - \frac{8}{\pi}\right|
&&\bigl(\because\ \text{絶対値の非負性}\bigr)\\
&\leq\frac{49}{\log\dfrac{1}{|K-K_c|}}
&&\bigl(\because\ \text{Step 7 の評価を正の分母で割る}\bigr),\\
\frac{49}{\log\dfrac{1}{|K-K_c|}}
&\xrightarrow[K\to K_c]{}0
&&\bigl(\because\ \log(1/|K-K_c|)\to+\infty\bigr).
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`|K-K_c| < \exp(-1)`),
        " なら分母は正である。）これが主張の極限であり、同時に ",
        math(String.raw`\dfrac{d^2f}{dK^2} \to +\infty`),
        " を与える。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "定数 45 / 49 は最適化していない（証明の各段の評価をそのまま足した結果 42.94 以下）。数値では実際の |f'' − (8/π)log(1/|κ|)| の上限は 1.6 程度である（sagemath/check/055_claim_critical_point/check_05）。",
      ],
    },
  },
  {
    id: "critical_point_claim_sinh_K_c_and_second_derivative_log_divergence",
    kind: "claim",
    standing: "mainTheorem",
    title: {
      tex: String.raw`\sinh 2K_c = 1\text{ と }\left|\frac{d^2f}{dK^2}(K) - \frac{8}{\pi}\log\frac{1}{|K-K_c|}\right| \leq 49`,
    },
    labels: ["critical_point_sinh_K_c_and_second_derivative_log_divergence"],
    statement: [
      paragraph([
        math(String.raw`K \in \mathbb{R}_{>0}`),
        "（",
        ref("def_partition_function_2d_ising"),
        " の定義域が ",
        math(String.raw`\mathbb{R}_{>0}\times\mathbb{R}_{>0}`),
        " であるため）について、",
        ref("c_plus_value_c_sandwich_and_double_limit_of_log_Z"),
        " (3) の右辺を ",
        math(String.raw`K_1 = K_2 = K`),
        " で取ったものを",
      ]),
      displayMath(
        String.raw`f(K) := \frac{1}{2}\log\left(2\sinh 2K\right) + \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "と書く（",
        math(String.raw`\gamma(\theta)`),
        " は ",
        ref("def_gamma_theta"),
        " のもの。",
        math(String.raw`\log`),
        " は正の実数上の実対数で、",
        math(String.raw`f(K)`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " に住む。実対数と Riemann 積分による脱出）。このとき次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          ref("kappa_of_K_basic"),
          " の臨界点 ",
          math(String.raw`K_c`),
          "（",
          math(String.raw`\sinh 2K_c = 1`),
          " で定めたもの）は ",
          math(String.raw`K_c = \tfrac{1}{2}\log\left(1+\sqrt{2}\right) \in \mathbb{R}_{>0}`),
          "（",
          math(String.raw`\mathbb{R}`),
          " に住むのは実対数の値であるため。実対数による脱出）を満たし、",
          math(String.raw`\sinh 2K = 1`),
          " を満たす ",
          math(String.raw`K \in \mathbb{R}_{>0}`),
          " は ",
          math(String.raw`K_c`),
          " だけである。",
        ],
        [
          "(2) ",
          math(String.raw`0 < |K-K_c| \leq \tfrac{1}{10}`),
          " なる ",
          math(String.raw`K \in \mathbb{R}_{>0}`),
          " について、",
          math(String.raw`f`),
          " は ",
          math(String.raw`K`),
          " で 2 回微分可能で ",
          math(String.raw`\displaystyle\left|\frac{d^2f}{dK^2}(K) - \frac{8}{\pi}\log\frac{1}{\left|K-K_c\right|}\right| \leq 49`),
          " である。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        math(String.raw`u \in \mathbb{R}`),
        " とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh u = 1
&\iff u = \mathrm{arcsinh}(1)
&&\bigl(\because\ \blkref{sinh_equation_solved_by_arcsinh}\bigr)\\
&\iff u = \log\left(1+\sqrt{1^2+1}\right)
&&\bigl(\because\ \blkref{def_arcsinh}\bigr)\\
&\iff u = \log\left(1+\sqrt{2}\right)
&&\bigl(\because\ \mathbb R\text{ の四則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        ref("kappa_of_K_basic"),
        " の ",
        math(String.raw`K_c`),
        " は ",
        math(String.raw`\sinh 2K_c = 1`),
        " を満たすので、",
        math(String.raw`u = 2K_c`),
        " と ",
        math(String.raw`u = 2K`),
        " に当てはめると次を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
K_c
&= \frac{1}{2}\log\left(1+\sqrt{2}\right)
&&\bigl(\because\ \sinh 2K_c = 1\text{ と直前の同値}\bigr)\\
&> \frac{1}{2}\log 1
&&\bigl(\because\ 1+\sqrt2 > 1\text{ と実対数の狭義単調性}\bigr)\\
&= 0
&&\bigl(\because\ \log 1 = 0\bigr),\\
\sinh 2K = 1
&\iff 2K = \log\left(1+\sqrt{2}\right)
&&\bigl(\because\ \text{直前の同値}\bigr)\\
&\iff K = K_c
&&\bigl(\because\ K_c = \tfrac12\log(1+\sqrt2)\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`\kappa(K)`),
        " を ",
        ref("def_isotropic_kappa_of_K"),
        " のもの、",
        math(String.raw`G`),
        " を ",
        ref("second_derivative_log_divergence"),
        " のものとする。",
        math(String.raw`f`),
        " は ",
        ref("specific_heat_log_divergence"),
        " の ",
        math(String.raw`f`),
        " と一致する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
f(K)
&= \frac{1}{2}\log\left(2\sinh 2K\right) + \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta
&&\bigl(\because\ f\text{ の定義}\bigr)\\
&= \frac{1}{2}\log\left(2\sinh 2K\right) + \frac{1}{4\pi}\int_0^{2\pi}\gamma\!\left(\theta,\kappa(K)\right)d\theta
&&\bigl(\because\ \blkref{isotropic_gamma_in_kappa}\text{ と }\blkref{gamma_derivatives_in_kappa}\text{ の記法}\bigr)\\
&= \frac{1}{2}\log\left(2\sinh 2K\right) + G\!\left(\kappa(K)\right)
&&\bigl(\because\ \blkref{second_derivative_log_divergence}\text{ の }G\text{ の定義}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "右辺は ",
        ref("specific_heat_log_divergence"),
        " の ",
        math(String.raw`f(K)`),
        " の定義そのものである。したがって ",
        ref("specific_heat_log_divergence"),
        " の二つ目の不等式が主張の不等式である（2 回微分可能であることも同じ定理が述べている）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、臨界点の章のゴールの式（sinh 2K_c = 1 と |f''(K) − (8/π)log(1/|K−K_c|)| ≤ 49）を一つの主張として立てた。既存の主張 kappa_of_K_basic・specific_heat_log_divergence を並べ、f を M→∞ の極限と閉形式の章のゴールの主張の右辺で書き直しただけで、新しい評価は無い。",
      ],
    },
  },
]);
