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
    title: { text: "この章で新たに持ち込む実数解析の事実（(R5)・(R6)）" },
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
        " で持ち込んだものをそのまま使う。この章で新たに追加するのは次の 2 つだけであり、他では使わない。",
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
          "（定数関数の積分）で使う。",
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
        "また本章には ",
        math(String.raw`\cosh 0.2`),
        " のような具体的な数値の評価が現れる。これらは初等関数の数値評価であり、",
        "示した桁までの不等式として使う（数値検証は ",
        "sagemath/check/055_claim_critical_point/ に置いた）。",
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
     \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right) + A\sin^2\!\left(\frac{\theta}{2}\right)}
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
        "Step 1（",
        math(String.raw`\gamma_1`),
        " の書き換え）。",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " から出発する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)
&= c_1c_2^* - s_1s_2^*\cos\theta
   &&(\because \blkref{def_gamma1_gamma2_of_theta}) \\
&= \left(c_1c_2^* - s_1s_2^*\right) + s_1s_2^*\left(1 - \cos\theta\right) \\
&= \cosh\left(2K_1 - 2K_2^*\right) + s_1s_2^*\left(1-\cos\theta\right)
   &&(\because \blkref{cosh_addition_and_half_angle}\text{ (1) を } x = 2K_1,\ y = 2K_2^* \text{ に適用}) \\
&= \cosh\kappa + A\left(1-\cos\theta\right)
   &&(\because \blkref{def_kappa}\text{ と }\blkref{def_critical_sinh_product_A}) \\
&= \cosh\kappa + 2A\sin^2\!\left(\frac{\theta}{2}\right)
   &&(\because \text{倍角公式 } \cos 2t = 1 - 2\sin^2 t \text{ を } t = \tfrac{\theta}{2} \text{ に適用})
\end{aligned}`,
      ),
      paragraph([
        ref("def_gamma_theta"),
        " より ",
        math(String.raw`\gamma(\theta) = \mathrm{arccosh}(\gamma_1(\theta)) \in \mathbb{R}_{\geq 0}`),
        " が定まり ",
        math(String.raw`\cosh\gamma(\theta) = \gamma_1(\theta)`),
        " であるから、1 番目の式が従う。",
      ]),
      paragraph([
        "Step 2（半角の形へ）。",
        ref("cosh_addition_and_half_angle"),
        " (2) を ",
        math(String.raw`x = \gamma(\theta)`),
        " と ",
        math(String.raw`x = \kappa`),
        " の両方に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1 + 2\sinh^2\!\left(\frac{\gamma(\theta)}{2}\right)
&= \cosh\gamma(\theta)
   &&(\because \text{cosh\_addition\_and\_half\_angle (2)}) \\
&= \cosh\kappa + 2A\sin^2\!\left(\frac{\theta}{2}\right)
   &&(\because \text{Step 1}) \\
&= 1 + 2\sinh^2\!\left(\frac{\kappa}{2}\right) + 2A\sin^2\!\left(\frac{\theta}{2}\right)
   &&(\because \text{cosh\_addition\_and\_half\_angle (2)})
\end{aligned}`,
      ),
      paragraph([
        "両辺から ",
        math(String.raw`1`),
        " を引いて ",
        math(String.raw`2`),
        " で割ると 2 番目の式を得る。",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`\mathrm{arcsinh}`),
        " の形へ）。",
        math(String.raw`S := \sinh^2(\tfrac{\kappa}{2}) + A\sin^2(\tfrac{\theta}{2}) \geq 0`),
        " とおく。",
        math(String.raw`\gamma(\theta) \geq 0`),
        " より ",
        math(String.raw`\tfrac{\gamma(\theta)}{2} \geq 0`),
        " であり、",
        ref("cosh_sinh_basic_properties"),
        " (3) と ",
        math(String.raw`\sinh 0 = 0`),
        " より ",
        math(String.raw`\sinh(\tfrac{\gamma(\theta)}{2}) \geq 0`),
        "。Step 2 より ",
        math(String.raw`\sinh^2(\tfrac{\gamma(\theta)}{2}) = S`),
        " なので、非負実数の平方根の一意性（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）から",
      ]),
      displayMath(String.raw`\sinh\!\left(\frac{\gamma(\theta)}{2}\right) = \sqrt{S}`),
      paragraph([
        ref("cosh_addition_and_half_angle"),
        " (4) を ",
        math(String.raw`u = \tfrac{\gamma(\theta)}{2}`),
        "、",
        math(String.raw`y = \sqrt{S}`),
        " に適用して ",
        math(String.raw`\tfrac{\gamma(\theta)}{2} = \mathrm{arcsinh}(\sqrt{S})`),
        "、すなわち 3 番目の式を得る。",
      ]),
      paragraph([
        "偶関数性は ",
        math(String.raw`\sinh^2(\tfrac{-\kappa}{2}) = \left(-\sinh(\tfrac{\kappa}{2})\right)^2 = \sinh^2(\tfrac{\kappa}{2})`),
        " から従う。",
      ]),
    ],
    conversion: { status: "added" },
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
        "(1) ",
        math(String.raw`\iff`),
        " (2) の証明。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_2^*`),
        " の定義より ",
        math(String.raw`\sinh(2K_2)\sinh(2K_2^*) = 1`),
        " であり、",
        ref("cosh_sinh_basic_properties"),
        " (3) より ",
        math(String.raw`s_2 = \sinh 2K_2 > 0`),
        " なので",
      ]),
      displayMath(String.raw`\sinh 2K_2^* = \frac{1}{s_2}`),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
s_1 s_2 = 1
&\iff \sinh 2K_1 = \frac{1}{s_2}
&&\bigl(\because\ s_2 > 0 \text{ で両辺を割る}\bigr) \\
&\iff \sinh 2K_1 = \sinh 2K_2^* \\
&\iff 2K_1 = 2K_2^*
&&\bigl(\because\ \text{cosh\_addition\_and\_half\_angle (3)：} \sinh \text{ は狭義単調増加ゆえ単射}\bigr) \\
&\iff K_1 = K_2^*
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`\iff`),
        " (3) は ",
        math(String.raw`\kappa = 2K_1 - 2K_2^* = 2(K_1 - K_2^*)`),
        " より明らかである。",
      ]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "critical_005_claim_isotropic_setting",
    kind: "claim",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 7 },
    title: { tex: String.raw`\text{等方な場合 } K_1 = K_2 = K \text{ では } A = 1` },
    labels: ["isotropic_A_equals_one"],
    statement: [
      paragraph([
        "以下、**等方な場合** ",
        math(String.raw`K_1 = K_2 = K \in \mathbb{R}_{>0}`),
        " を考える。このとき ",
        ref("def_critical_sinh_product_A"),
        " の ",
        math(String.raw`A`),
        " について",
      ]),
      displayMath(String.raw`A = 1`),
      paragraph([
        "が成り立ち、",
        ref("gamma_kappa_identity"),
        " は",
      ]),
      displayMath(
        String.raw`\gamma(\theta) = 2\,\mathrm{arcsinh}\!\left(
  \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right) + \sin^2\!\left(\frac{\theta}{2}\right)}
\right),
\qquad \kappa = \kappa(K) := 2K - 2K^*`),
      paragraph([
        "となる。すなわち **等方な場合、",
        math(String.raw`\gamma`),
        " は ",
        math(String.raw`\kappa`),
        " 1 つだけを通じて ",
        math(String.raw`K`),
        " に依存する。**",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`K_1 = K_2 = K`),
        " のとき ",
        math(String.raw`K_2^* = K^*`),
        " であり、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K^*`),
        " の定義そのものが ",
        math(String.raw`\sinh(2K)\sinh(2K^*) = 1`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
A
&=s_1s_2^*
&&\bigl(\because\ \blkref{def_critical_sinh_product_A}\bigr)\\
&=\sinh 2K_1\,\sinh 2K_2^*
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の記号の定義}\bigr)\\
&=\sinh 2K\,\sinh 2K^*
&&\bigl(\because\ K_1=K_2=K\text{、}K_2^*=K^*\bigr)\\
&=1
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }K^*\text{ の定義}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma(\theta)
&=2\,\mathrm{arcsinh}\!\left(
  \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right)+A\sin^2\!\left(\frac{\theta}{2}\right)}
\right)
&&(\because\ \blkref{gamma_kappa_identity}\text{ の第3式})\\
&=2\,\mathrm{arcsinh}\!\left(
  \sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right)+\sin^2\!\left(\frac{\theta}{2}\right)}
\right)
&&(\because\ A=1).
\end{aligned}`),
    ],
    conversion: { status: "added" },
  },
  {
    id: "critical_006_claim_kappa_of_K_basic",
    kind: "claim",
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 8 },
    title: { tex: String.raw`\kappa(K) \text{ の基本性質と臨界点 } K_c` },
    labels: ["kappa_of_K_basic"],
    statement: [
      paragraph([
        ref("isotropic_A_equals_one"),
        " の ",
        math(String.raw`\kappa(K) = 2K - 2K^*`),
        " について次が成り立つ。ここで **臨界点** ",
        math(String.raw`K_c`),
        " を ",
        math(String.raw`\sinh 2K_c = 1`),
        " で定める（",
        ref("cosh_addition_and_half_angle"),
        " (4) より ",
        math(String.raw`2K_c = \mathrm{arcsinh}(1) = \log(1+\sqrt2)`),
        " と一意に定まる）。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\kappa`),
          " は ",
          math(String.raw`\mathbb{R}_{>0}`),
          " 上微分可能で ",
          math(String.raw`\kappa'(K) = 2 + \dfrac{2}{\sinh 2K} > 0`),
          "、とくに狭義単調増加。",
        ],
        [
          "(2) ",
          math(String.raw`\kappa(K_c) = 0`),
          " であり、",
          math(String.raw`\kappa(K) = 0 \iff K = K_c \iff \sinh^2 2K = 1`),
          "（等方な場合の臨界条件）。",
        ],
        [
          "(3) ",
          math(String.raw`\kappa''(K) = -\dfrac{4\cosh 2K}{\sinh^2 2K}`),
          "。",
        ],
        [
          "(4) ",
          math(String.raw`|K - K_c| \leq \tfrac{1}{10}`),
          " なる ",
          math(String.raw`K`),
          " について",
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
          math(String.raw`|K - K_c| \leq \tfrac{1}{10}`),
          " なる ",
          math(String.raw`K`),
          " について ",
          math(String.raw`3.53\,|K-K_c| \leq |\kappa(K)| \leq 4.72\,|K-K_c| \leq 0.472`),
          "、および ",
          math(String.raw`\left|\kappa'(K)^2 - 16\right| \leq 24.7\,|\kappa(K)|`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) の証明。",
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`K^* = -\tfrac12\log(\tanh K)`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{dK^*}{dK}
&= -\frac{1}{2}\cdot\frac{1}{\tanh K}\cdot\frac{d}{dK}\tanh K
&&\bigl(\because\ \log \text{ の微分と合成関数の微分}\bigr) \\
&= -\frac{1}{2}\cdot\frac{\cosh K}{\sinh K}\cdot\frac{1}{\cosh^2 K}
&&\bigl(\because\ (\tanh)' = 1/\cosh^2\bigr) \\
&= -\frac{1}{2\sinh K\cosh K}
&&\bigl(\because\ \mathbb R\text{ の四則}\bigr) \\
&= -\frac{1}{\sinh 2K}
&&\bigl(\because\ \blkref{cosh_addition_and_half_angle}\text{ の倍角公式}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa'(K)
&=2-2\frac{dK^*}{dK}
&&\bigl(\because\ \blkref{isotropic_A_equals_one}\text{ の }\kappa(K)\text{ の定義}\bigr) \\
&=2+\frac{2}{\sinh 2K}
&&\bigl(\because\ \text{上の }dK^*/dK\text{ の表示}\bigr).
\end{aligned}`),
      paragraph([
        ref("cosh_sinh_basic_properties"),
        " (3) より ",
        math(String.raw`K > 0`),
        " で ",
        math(String.raw`\sinh 2K > 0`),
        " なので ",
        math(String.raw`\kappa'(K) > 2 > 0`),
        "。",
      ]),
      paragraph([
        "(2) の証明。",
        math(String.raw`\sinh 2K_c = 1`),
        " のとき ",
        math(String.raw`s_1 s_2 = \sinh^2 2K_c = 1`),
        " なので、",
        ref("critical_point_iff_kappa_zero"),
        " の (1) ",
        math(String.raw`\iff`),
        " (3) より ",
        math(String.raw`\kappa(K_c) = 0`),
        "。逆に ",
        math(String.raw`\kappa(K)=0`),
        " なら同じ同値から ",
        math(String.raw`\sinh^2 2K = 1`),
        "、",
        math(String.raw`\sinh 2K > 0`),
        " より ",
        math(String.raw`\sinh 2K = 1 = \sinh 2K_c`),
        "、",
        ref("cosh_addition_and_half_angle"),
        " (3) の単射性より ",
        math(String.raw`K = K_c`),
        "。",
      ]),
      paragraph([
        "(3) の証明。(1) の式を微分して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\kappa''(K)
&= \frac{d}{dK}\left(2 + \frac{2}{\sinh 2K}\right)
&&\bigl(\because\ \text{上の }\kappa'(K)\text{ の表示}\bigr) \\
&= -\frac{2}{\sinh^2 2K}\cdot 2\cosh 2K
&&\bigl(\because\ \text{逆数と合成関数の微分}\bigr) \\
&= -\frac{4\cosh 2K}{\sinh^2 2K}
&&\bigl(\because\ \mathbb R\text{ の四則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(4) の証明。",
        math(String.raw`\sinh 2K_c = 1`),
        " と ",
        ref("cosh_sinh_basic_properties"),
        " (2) より ",
        math(String.raw`\cosh 2K_c = \sqrt2`),
        "（",
        math(String.raw`\cosh > 0`),
        "）。",
        ref("cosh_addition_and_half_angle"),
        " (1) を ",
        math(String.raw`x = 2K_c`),
        "、",
        math(String.raw`y = 2(K-K_c) \in [-\tfrac15,\tfrac15]`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh 2K
&= \sinh\left(2K_c + 2(K-K_c)\right)
&&(\because\ \mathbb R\text{ の四則}) \\
&= \sinh 2K_c\cosh\left(2(K-K_c)\right) + \cosh 2K_c\sinh\left(2(K-K_c)\right)
&&(\because\ \blkref{cosh_addition_and_half_angle}\text{ の加法公式}) \\
&= \cosh\left(2(K-K_c)\right) + \sqrt2\,\sinh\left(2(K-K_c)\right)
&&(\because \sinh 2K_c = 1,\ \cosh 2K_c = \sqrt2)
\end{aligned}`,
      ),
      paragraph([
        ref("cosh_addition_and_half_angle"),
        " (3) より ",
        math(String.raw`\sinh`),
        " は狭義単調増加なので、",
        math(String.raw`2K_c - 0.2 \leq 2K \leq 2K_c + 0.2`),
        " のもとで ",
        math(String.raw`\sinh(2K_c-0.2) \leq \sinh 2K \leq \sinh(2K_c+0.2)`),
        " であり、上の加法定理の式（",
        math(String.raw`2(K-K_c) = \pm 0.2`),
        "）から",
      ]),
      displayMath(
        String.raw`\sinh\left(2K_c \pm 0.2\right) = \cosh 0.2 \pm \sqrt2\,\sinh 0.2`,
      ),
      paragraph([
        "数値評価 ",
        math(String.raw`1.02006 \leq \cosh 0.2 \leq 1.020067`),
        "、",
        math(String.raw`0.201336 \leq \sinh 0.2 \leq 0.2013361`),
        "、",
        math(String.raw`1.414213 \leq \sqrt2 \leq 1.414214`),
        " を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh 2K
&\geq \cosh 0.2-\sqrt2\sinh 0.2
&&(\because\ \blkref{cosh_addition_and_half_angle}\text{ の単調性と上の端点の式}) \\
&\geq 1.02006-1.414214\cdot0.2013361
&&(\because\ \text{上の数値評価}) \\
&\geq 0.7353
&&(\because\ \mathbb Q\text{ の四則}). \\
\sinh 2K
&\leq \cosh 0.2+\sqrt2\sinh 0.2
&&(\because\ \blkref{cosh_addition_and_half_angle}\text{ の単調性と上の端点の式}) \\
&\leq 1.020067+1.414214\cdot0.2013361
&&(\because\ \text{上の数値評価}) \\
&\leq 1.3048
&&(\because\ \mathbb Q\text{ の四則}).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\kappa'(K) = 2 + \dfrac{2}{\sinh 2K}`),
        " は",
      ]),
      displayMath(
        String.raw`2 + \frac{2}{1.3048} \leq \kappa'(K) \leq 2 + \frac{2}{0.7353},
\qquad \text{すなわち} \quad 3.53 \leq \kappa'(K) \leq 4.72`,
      ),
      paragraph([
        math(String.raw`\kappa''`),
        " については、",
        math(String.raw`t \mapsto \dfrac{4\cosh t}{\sinh^2 t}`),
        " が ",
        math(String.raw`t > 0`),
        " で狭義単調減少であること",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{d}{dt}\frac{\cosh t}{\sinh^2 t}
&= \frac{\sinh^2 t\cdot\sinh t - \cosh t\cdot 2\sinh t\cosh t}{\sinh^4 t}
&&(\because\ \text{商と合成関数の微分}) \\
&= \frac{\sinh^2 t - 2\cosh^2 t}{\sinh^3 t}
&&(\because\ \mathbb R\text{ の四則}) \\
&<0
&&(\because\ \sinh^2 t<\cosh^2 t<2\cosh^2 t,\ \sinh t>0).
\end{aligned}`,
      ),
      paragraph([
        "より、",
        math(String.raw`2K \geq 2K_c - 0.2`),
        " での最大値をとればよい。",
        math(String.raw`\sinh(2K_c-0.2) \geq 0.7353`),
        " と ",
        math(String.raw`\cosh(2K_c-0.2) = \sqrt2\cosh 0.2 - \sinh 0.2 \leq 1.414214\cdot 1.020067 - 0.201336 \leq 1.2413`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\kappa''(K)\right|
&=\frac{4\cosh 2K}{\sinh^2 2K}
&&(\because\ \text{上の }\kappa''(K)\text{ の表示と }\cosh 2K>0) \\
&\leq\frac{4\cosh(2K_c-0.2)}{\sinh^2(2K_c-0.2)}
&&(\because\ \cosh t/\sinh^2t\text{ の単調減少}) \\
&\leq\frac{4\cdot1.2413}{0.7353^2}
&&(\because\ \text{下端 }2K_c-0.2\text{ での数値評価}) \\
&\leq9.19
&&(\because\ \mathbb Q\text{ の四則}).
\end{aligned}`,
      ),
      paragraph([
        "最後に ",
        math(String.raw`\left(\kappa'^2\right)' = 2\kappa'\kappa''`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\left(\kappa'^2\right)'(K)\right|
&\leq2\cdot4.72\cdot9.19
&&(\because\ \text{上の }\kappa'(K)\text{ と }\kappa''(K)\text{ の上界}) \\
&\leq87
&&(\because\ \mathbb Q\text{ の四則}).
\end{aligned}`),
      paragraph([
        "(5) の証明。(R4) を ",
        math(String.raw`F = \kappa`),
        " に適用すると ",
        math(String.raw`\kappa(K) = \kappa(K)-\kappa(K_c) = \int_{K_c}^{K}\kappa'(t)\,dt`),
        " であり、(4) より積分区間上で ",
        math(String.raw`3.53 \leq \kappa'(t) \leq 4.72`),
        " なので、(R3) の単調性より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
3.53\,|K-K_c|
&\leq|\kappa(K)|
&&(\because\ \text{(R4)、(R3) と }\kappa'(t)\geq3.53) \\
&\leq4.72\,|K-K_c|
&&(\because\ \text{(R4)、(R3) と }\kappa'(t)\leq4.72) \\
&\leq4.72\cdot\frac{1}{10}
&&(\because\ |K-K_c|\leq\tfrac{1}{10}) \\
&=0.472
&&(\because\ \mathbb Q\text{ の四則}).
\end{aligned}`,
      ),
      paragraph([
        "同様に (R4) を ",
        math(String.raw`F = \kappa'^2`),
        " に適用する。ここで",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\kappa'(K_c)
&= 2 + \frac{2}{\sinh 2K_c}
&&(\because \text{(1) の } \kappa' \text{ の表示を } K = K_c \text{ で読む}) \\
&= 2 + \frac{2}{1}
&&(\because \sinh 2K_c = 1\text{。本主張の } K_c \text{ の定義}) \\
&= 4
&&(\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "に注意すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\kappa'(K)^2-16\right|
&=\left|\int_{K_c}^{K}\left(\kappa'^2\right)'(t)\,dt\right|
&&(\because\ \text{(R4) と }\kappa'(K_c)=4) \\
&\leq87\,|K-K_c|
&&(\because\ \text{(R3) と上の }\left|\left(\kappa'^2\right)'\right|\leq87) \\
&\leq87\cdot\frac{|\kappa(K)|}{3.53}
&&(\because\ \text{上の }3.53|K-K_c|\leq|\kappa(K)|) \\
&\leq24.7\,|\kappa(K)|
&&(\because\ \mathbb Q\text{ の四則}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-02 の式変形統一で、(4)(5) の三本の鎖に行中の \\quad (\\because …) で置かれていた根拠 7 行を、" +
          "行末の根拠列（aligned の &&）へ揃えた。式変形・根拠・段数・参照は変えていない。",
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
        ref("isotropic_A_equals_one"),
        " の等方な場合について、",
        math(String.raw`(\theta,\kappa) \in \mathbb{R}\times\mathbb{R}`),
        " の関数",
      ]),
      displayMath(
        String.raw`S(\theta,\kappa) := \sinh^2\!\left(\frac{\kappa}{2}\right) + \sin^2\!\left(\frac{\theta}{2}\right),
\qquad
\gamma(\theta,\kappa) := 2\,\mathrm{arcsinh}\!\left(\sqrt{S(\theta,\kappa)}\right)`,
      ),
      paragraph(["を考える。このとき次が成り立つ。"]),
      list([
        [
          "(1) ",
          math(String.raw`\sinh\!\left(\tfrac{\gamma}{2}\right) = \sqrt{S}`),
          "、",
          math(String.raw`\cosh\!\left(\tfrac{\gamma}{2}\right) = \sqrt{1+S}`),
          "、",
          math(String.raw`\sinh\gamma = 2\sqrt{S(1+S)}`),
          "、",
          math(String.raw`\cosh\gamma = 1+2S`),
          "。",
        ],
        [
          "(2) ",
          math(String.raw`\kappa \neq 0`),
          " のとき ",
          math(String.raw`S > 0`),
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
    ],
    proof: [
      paragraph([
        "(1) の証明。",
        ref("gamma_kappa_identity"),
        " の Step 3 と同じ議論（",
        math(String.raw`\gamma \geq 0`),
        " ゆえ ",
        math(String.raw`\sinh(\tfrac\gamma2) \geq 0`),
        "）で ",
        math(String.raw`\sinh(\tfrac\gamma2) = \sqrt S`),
        "。",
        ref("cosh_sinh_basic_properties"),
        " (2) と ",
        math(String.raw`\cosh > 0`),
        " より ",
        math(String.raw`\cosh(\tfrac\gamma2) = \sqrt{1+S}`),
        "。残りは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh\gamma
&= 2\sinh\!\left(\frac{\gamma}{2}\right)\cosh\!\left(\frac{\gamma}{2}\right)
   &&(\because\ \blkref{cosh_addition_and_half_angle}) \\
&= 2\sqrt{S}\sqrt{1+S} &&(\because\ \text{本主張 (1) の二つの半角等式}) \\
&= 2\sqrt{S(1+S)} &&(\because\ \mathbb R\text{ の平方根の積}) \\
\cosh\gamma
&= 1 + 2\sinh^2\!\left(\frac{\gamma}{2}\right)
   &&(\because\ \blkref{cosh_addition_and_half_angle}) \\
&= 1 + 2S
   &&(\because\ \text{本主張 (1) の } \sinh(\tfrac\gamma2) = \sqrt S)
\end{aligned}`,
      ),
      paragraph([
        "(2) の証明。",
        math(String.raw`\kappa \neq 0`),
        " なら ",
        ref("cosh_sinh_basic_properties"),
        " (3) より ",
        math(String.raw`\sinh^2(\tfrac\kappa2) > 0`),
        " なので ",
        math(String.raw`S \geq \sinh^2(\tfrac\kappa2) > 0`),
        "。",
        math(String.raw`\theta`),
        " を固定して ",
        math(String.raw`\kappa`),
        " で微分する。まず",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\partial S}{\partial\kappa}
&= 2\sinh\!\left(\frac{\kappa}{2}\right)\cdot\cosh\!\left(\frac{\kappa}{2}\right)\cdot\frac{1}{2}
   &&(\because (\sinh)' = \cosh \text{ と合成関数の微分}) \\
&= \sinh\!\left(\frac{\kappa}{2}\right)\cosh\!\left(\frac{\kappa}{2}\right) &&(\because\ \mathbb R\text{ の四則}) \\
&= \frac{1}{2}\sinh\kappa
   &&(\because\ \blkref{cosh_addition_and_half_angle})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\partial\gamma}{\partial\kappa}
&= 2\cdot\mathrm{arcsinh}'\!\left(\sqrt S\right)\cdot\frac{1}{2\sqrt S}\cdot\frac{\partial S}{\partial\kappa}
   &&(\because \text{合成関数の微分と } (\sqrt{\ })' = \tfrac{1}{2\sqrt{\ }}) \\
&= 2\cdot\frac{1}{\sqrt{S+1}}\cdot\frac{1}{2\sqrt S}\cdot\frac{1}{2}\sinh\kappa
   &&(\because\ \blkref{cosh_addition_and_half_angle}) \\
&= \frac{\sinh\kappa}{2\sqrt{S(1+S)}} &&(\because\ \mathbb R\text{ の四則と平方根の積}) \\
&= \frac{\sinh\kappa}{\sinh\gamma}
   &&(\because\ \text{本主張 (1)})
\end{aligned}`,
      ),
      paragraph(["もう一度微分すると"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\partial^2\gamma}{\partial\kappa^2}
&= \frac{\cosh\kappa\cdot\sinh\gamma - \sinh\kappa\cdot\cosh\gamma\cdot\dfrac{\partial\gamma}{\partial\kappa}}{\sinh^2\gamma}
   &&(\because \text{商の微分と } (\sinh)' = \cosh) \\
&= \frac{\cosh\kappa}{\sinh\gamma}
 - \frac{\sinh\kappa\cosh\gamma}{\sinh^2\gamma}\cdot\frac{\sinh\kappa}{\sinh\gamma}
   &&(\because \text{直前の式}) \\
&= \frac{\cosh\kappa}{\sinh\gamma} - \frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma} &&(\because\ \mathbb R\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "(3) の証明。",
        math(String.raw`S \geq \sinh^2(\tfrac\kappa2)`),
        " と ",
        math(String.raw`1+S \geq 1+\sinh^2(\tfrac\kappa2) = \cosh^2(\tfrac\kappa2)`),
        "（",
        ref("cosh_sinh_basic_properties"),
        " (2)）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh\gamma
&= 2\sqrt{S(1+S)}
   &&(\because\ \text{本主張 (1)}) \\
&\geq 2\sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right)\cosh^2\!\left(\frac{\kappa}{2}\right)}
   &&(\because S \geq \sinh^2(\tfrac\kappa2),\ 1+S \geq \cosh^2(\tfrac\kappa2)) \\
&= 2\left|\sinh\!\left(\frac{\kappa}{2}\right)\right|\cosh\!\left(\frac{\kappa}{2}\right)
   &&(\because \cosh > 0) \\
&= \left|\sinh\kappa\right|
   &&(\because\ \blkref{cosh_addition_and_half_angle})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\sinh\gamma > 0`),
        "（",
        math(String.raw`S>0`),
        " より）なので、(2) と直前の評価から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\frac{\partial\gamma}{\partial\kappa}\right|
&= \frac{|\sinh\kappa|}{\sinh\gamma}
   &&(\because\ \text{本主張 (2) と }\sinh\gamma>0) \\
&\leq 1
   &&(\because\ \text{直前の }\sinh\gamma\geq|\sinh\kappa|)
\end{aligned}`,
      ),
      paragraph([
        "(4) の証明。",
        math(String.raw`(\theta,\kappa) \in [0,2\pi]\times[\kappa_1,\kappa_2]`),
        " では ",
        math(String.raw`S(\theta,\kappa) \geq \sinh^2(\tfrac{\kappa_1}{2}) > 0`),
        " である。",
        math(String.raw`S`),
        " は ",
        math(String.raw`\sinh, \sin`),
        " の連続関数の和・積として連続、",
        math(String.raw`\sqrt{\ }`),
        " は ",
        math(String.raw`[\sinh^2(\tfrac{\kappa_1}{2}),\infty)`),
        " 上連続、",
        math(String.raw`\mathrm{arcsinh}`),
        " は連続なので ",
        math(String.raw`\gamma`),
        " は連続。(2) の 2 つの式はいずれも ",
        math(String.raw`\sinh\gamma \geq 2\sqrt{S} > 0`),
        " を分母にもつ連続関数の四則で書けているので連続である。",
      ]),
    ],
    conversion: { status: "added" },
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
        ref("isotropic_A_equals_one"),
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
        ref("cosh_addition_and_half_angle"),
        " (3)(5) より ",
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
&& (\because\ \text{定数関数の積分})\\
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
        math(String.raw`u(t) = 2\pi - t`),
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
        ref("gamma_derivatives_in_kappa"),
        " (1)(2) より ",
        math(String.raw`\sinh\gamma = 2\sqrt{S(1+S)}`),
        "、",
        math(String.raw`\cosh\gamma = 1+2S`),
        "、",
        math(String.raw`S = \delta^2 + \sin^2\!\left(\tfrac\theta2\right)`),
        " である。さらに ",
        math(String.raw`J := \int_0^{\pi}\frac{d\theta}{\sqrt{S(1+S)}}`),
        "、",
        math(String.raw`T := \int_0^{\pi}\frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\,d\theta`),
        " とおく。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta
&= \int_0^{\pi}\left(\frac{\cosh\kappa}{\sinh\gamma}
   - \frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\right)d\theta
&& (\because\ \blkref{gamma_derivatives_in_kappa}) \\
&= \int_0^{\pi}\left(\frac{\cosh\kappa}{2\sqrt{S(1+S)}}
   - \frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\right)d\theta
&& (\because\ \blkref{gamma_derivatives_in_kappa}) \\
&= \frac{\cosh\kappa}{2}\int_0^{\pi}\frac{d\theta}{\sqrt{S(1+S)}}
   - \int_0^{\pi}\frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\,d\theta
&& (\because\ \text{積分の線型性 (R3)}) \\
&= \frac{\cosh\kappa}{2}\,J - T
&& (\because\ J,T\text{ の定義}).
\end{aligned}`),
      paragraph([
        "Step 4（",
        math(String.raw`J`),
        " の評価）。まず各点で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0 &\leq \frac{1}{\sqrt S} - \frac{1}{\sqrt{S(1+S)}}
&& (\because S>0,\ 1+S\geq1) \\
&= \frac{1}{\sqrt S}\left(1 - \frac{1}{\sqrt{1+S}}\right)
&& (\because \mathbb R\text{ の四則}) \\
&= \frac{1}{\sqrt S}\cdot\frac{\sqrt{1+S}-1}{\sqrt{1+S}}
&& (\because \mathbb R\text{ の四則}) \\
&= \frac{1}{\sqrt S}\cdot\frac{S}{\sqrt{1+S}\left(\sqrt{1+S}+1\right)}
&& (\because (\sqrt{1+S}-1)(\sqrt{1+S}+1)=S) \\
&\leq \frac{1}{\sqrt S}\cdot\frac{S}{2}
&& (\because \sqrt{1+S}\geq1) \\
&= \frac{\sqrt S}{2}
&& (\because S>0) \\
&\leq \frac{\sqrt{\delta^2+1}}{2}
&& (\because \sin^2(\theta/2)\leq1) \\
&= \frac{\cosh\!\left(\frac{\kappa}{2}\right)}{2}
&& (\because \blkref{cosh_sinh_basic_properties}).
\end{aligned}`,
      ),
      paragraph([
        "この各点評価は **符号のついた片側の評価** である。(R3) の単調性を ",
        math(String.raw`[0,\pi]`),
        " 上で使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&\leq \int_0^{\pi}\left(\frac{1}{\sqrt S}-\frac{1}{\sqrt{S(1+S)}}\right)d\theta
&& (\because\ \text{直前の各点評価と積分の単調性 (R3)})\\
&=\int_0^{\pi}\frac{d\theta}{\sqrt S}-J
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
        math(String.raw`R_0 := \displaystyle\int_0^{\pi}\frac{d\theta}{\sqrt S}-2\log\frac{\pi}{\delta}`),
        " とおく。このとき ",
        math(String.raw`0 \leq R_0 \leq \frac{2\delta^2}{\pi^2} + B`),
        " である。",
        math(String.raw`R := J - 2\log\frac{\pi}{\delta}`),
        " とおく。先に得た差の評価を使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
R
&=J-2\log\frac{\pi}{\delta}
&& (\because\ R\text{ の定義})\\
&=R_0-\left(\int_0^{\pi}\frac{d\theta}{\sqrt S}-J\right)
&& (\because\ R_0\text{ の定義と }\mathbb R\text{ の四則}).
\end{aligned}`),
      paragraph(["直前の差の評価から下界を、", ref("sine_integral_two_sided"), " から上界をそれぞれ得る。"]),
      displayMath(String.raw`\begin{aligned}
R
&\geq-\left(\int_0^{\pi}\frac{d\theta}{\sqrt S}-J\right)
&& (\because\ R_0\geq0)\\
&\geq-\frac{\pi}{2}\cosh\!\left(\frac{\kappa}{2}\right)
&& (\because\ \text{直前の差の評価}),\\[2pt]
R
&\leq R_0
&& (\because\ \int_0^{\pi}\frac{d\theta}{\sqrt S}-J\geq0)\\
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
        "、",
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
&&\bigl(\because\ \text{直前の }|R|\text{ の評価と数値上下界}\bigr)\\
&\leq\max\left\{0.0130+0.88,\ 1.6203\right\}
&&\bigl(\because\ \text{有理数の四則}\bigr)\\
&\leq1.621
&&\bigl(\because\ \text{有理数の大小比較}\bigr).
\end{aligned}`),
      paragraph([
        "Step 5（",
        math(String.raw`T`),
        " の評価）。",
        ref("gamma_derivatives_in_kappa"),
        " (1) より ",
        math(String.raw`\dfrac{\cosh\gamma}{\sinh^3\gamma} = \dfrac{1+2S}{8\left(S(1+S)\right)^{3/2}}`),
        " であり、",
        math(String.raw`1+2S \leq 2(1+S)`),
        " と ",
        math(String.raw`(1+S)^{3/2} \geq 1+S`),
        " より",
      ]),
      displayMath(String.raw`0\leq\frac{\cosh\gamma}{\sinh^3\gamma}
\qquad(\because\ \blkref{gamma_derivatives_in_kappa},\ S>0).`),
      displayMath(
        String.raw`\begin{aligned}
\frac{\cosh\gamma}{\sinh^3\gamma}
&= \frac{1+2S}{8\left(S(1+S)\right)^{3/2}}
&& (\because\ \blkref{gamma_derivatives_in_kappa}) \\
&= \frac{1+2S}{8\,S^{3/2}(1+S)^{3/2}}
&& (\because\ \text{正の数の冪法則}) \\
&\leq \frac{2(1+S)}{8\,S^{3/2}(1+S)^{3/2}}
&& (\because\ 1+2S\leq2(1+S)) \\
&\leq \frac{2(1+S)}{8\,S^{3/2}(1+S)}
&& (\because\ (1+S)^{3/2}\geq1+S) \\
&= \frac{1}{4\,S^{3/2}}
&& (\because\ \mathbb R\text{ の四則}).
\end{aligned}`,
      ),
      paragraph([
        ref("elementary_sine_bounds"),
        " より ",
        math(String.raw`\sin\!\left(\tfrac\theta2\right) \geq c_0\tfrac\theta2`),
        " なので ",
        math(String.raw`S \geq \delta^2 + \dfrac{c_0^2\theta^2}{4}`),
        "、したがって (R3) と ",
        ref("closed_form_log_integral"),
        " (3)（",
        math(String.raw`a = c_0`),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T
&\leq \frac{\sinh^2\kappa}{4}\int_0^{\pi}\frac{d\theta}{S^{3/2}}
&& (\because \text{直前の各点評価と (R3) の単調性}) \\
&\leq \frac{\sinh^2\kappa}{4}\int_0^{\pi}\frac{d\theta}{\left(\delta^2+\frac{c_0^2\theta^2}{4}\right)^{3/2}}
&& (\because \blkref{elementary_sine_bounds}\text{ と (R3) の単調性}) \\
&\leq \frac{\sinh^2\kappa}{4}\cdot\frac{2}{c_0\delta^2}
&& (\because \blkref{closed_form_log_integral}\text{ (3)}) \\
&= \frac{4\delta^2\cosh^2\!\left(\frac{\kappa}{2}\right)}{4}\cdot\frac{2}{c_0\delta^2}
&& (\because \blkref{cosh_addition_and_half_angle}\text{ (2)}:\ \sinh\kappa=2\delta\cosh(\tfrac\kappa2)) \\
&= \frac{2\cosh^2\!\left(\frac{\kappa}{2}\right)}{c_0}
&& (\because \delta>0\text{ と }\mathbb R\text{ の四則}) \\
&\leq \frac{2\cdot 1.0315^2}{0.5887}
&& (\because \kappa \leq \tfrac12,\ \cosh(\tfrac\kappa2)\leq1.0315,\ \blkref{elementary_sine_bounds}:c_0\geq0.5887) \\
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
        ref("cosh_addition_and_half_angle"),
        " (5) を ",
        math(String.raw`t = \tfrac\kappa2`),
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
&\leq\log\frac{\kappa}{\delta}-\log 2
&& (\because\ \text{直前の左辺の評価と対数の単調性})\\
&\leq 0
&& (\because\ \text{直前の右辺の評価と対数の単調性}).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\rho := \log\frac{\kappa}{\delta} - \log 2`),
        " とおく。直前の評価と ", ref("cosh_addition_and_half_angle"),
        " (5) を用いると、",
      ]),
      displayMath(String.raw`\cosh\!\left(\frac\kappa2\right)\leq\cosh\tfrac14
\quad(\because\ 0<\kappa\leq\tfrac12\text{ と }\blkref{cosh_addition_and_half_angle}\text{ (2)(3)}).`),
      displayMath(String.raw`\begin{aligned}
\log\frac{\pi}{\delta}
&=\log\frac1\kappa+\log\pi+\log\frac\kappa\delta
&& (\because\ \text{対数の積の法則})\\
&=\log\frac1\kappa+\log(2\pi)+\left(\log\frac\kappa\delta-\log2\right)
&& (\because\ \text{対数の積の法則})\\
&=\log\frac1\kappa+\log(2\pi)+\rho
&& (\because\ \rho\text{ の定義}),\\[2pt]
|\rho|
&\leq\log\cosh\!\left(\frac\kappa2\right)
&& (\because\ -\log\cosh\!\left(\frac\kappa2\right)\leq\rho\leq0)\\
&\leq\log\cosh\tfrac14
&& (\because\ \text{直前の評価と対数の単調性})\\
&\leq0.0310
&& (\because\ \text{有理数による数値上界}).
\end{aligned}`),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
\cosh\kappa\,\log\frac{\pi}{\delta} - \log\frac{1}{\kappa}
&= \left(\cosh\kappa - 1\right)\log\frac{1}{\kappa}
 + \cosh\kappa\left(\log(2\pi) + \rho\right)
\end{aligned}`,
      ),
      paragraph(["右辺第 1 項は、", ref("cosh_addition_and_half_angle"), " (2)(5) より"]),
      displayMath(String.raw`\begin{aligned}
\cosh\kappa-1
&=2\sinh^2\!\left(\frac\kappa2\right)
&&\bigl(\because\ \blkref{cosh_addition_and_half_angle}\text{ (2)}\bigr)\\
&\leq2\left(\frac\kappa2\cosh\frac14\right)^2
&&\bigl(\because\ \blkref{cosh_addition_and_half_angle}\text{ (5) と }0<\kappa\leq\tfrac12\bigr)\\
&\leq0.532\,\kappa^2
&&\bigl(\because\ \cosh\tfrac14\text{ の数値上界}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\kappa^2\log\frac1\kappa`),
        " は ",
        math(String.raw`(0,\tfrac12]`),
        " 上単調増加（導関数 ",
        math(String.raw`\kappa\left(2\log\frac1\kappa - 1\right) > 0`),
        "）で最大値は ",
        math(String.raw`\tfrac14\log 2 \leq 0.1733`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
0&\leq(\cosh\kappa-1)\log\frac1\kappa
&&\bigl(\because\ \cosh\kappa\geq1,\ 0<\kappa\leq\tfrac12\bigr)\\
&\leq0.532\,\kappa^2\log\frac1\kappa
&&\bigl(\because\ \text{直前の }\cosh\kappa-1\text{ の上界}\bigr)\\
&\leq0.532\cdot0.1733
&&\bigl(\because\ \kappa^2\log(1/\kappa)\leq0.1733\bigr)\\
&\leq0.093
&&\bigl(\because\ \text{有理数の大小比較}\bigr).
\end{aligned}`),
      paragraph([
        "第 2 項は ",
        math(String.raw`\cosh\kappa \leq \cosh\tfrac12 \leq 1.1277`),
        "、",
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
&&\bigl(\because\ \text{Step 4、Step 5、Step 6 の上界}\bigr) \\
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
&&\bigl(\because\ 2\pi>0\bigr)\\
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
&&\bigl(\because\ \log(1/|\kappa|)\to+\infty,\ 2\pi>0\bigr).
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "定数 6/5 は最適化していない（証明中の各段の評価をそのまま足した結果 1.08 以下）。数値では実際の |G'' - (1/2π)log(1/|κ|)| の上限は 0.13 程度である（sagemath/check/055_claim_critical_point/check_04）。",
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
        ref("isotropic_A_equals_one"),
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
&&\bigl(\because\ \blkref{cosh_addition_and_half_angle}\text{ (3)(4)}\bigr)\\
&\iff u = \log\left(1+\sqrt{1^2+1}\right)
&&\bigl(\because\ \blkref{cosh_addition_and_half_angle}\text{ (4) の }\mathrm{arcsinh}\text{ の定義}\bigr)\\
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
        ref("isotropic_A_equals_one"),
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
&&\bigl(\because\ \blkref{isotropic_A_equals_one}\text{ と }\blkref{gamma_derivatives_in_kappa}\text{ の記法}\bigr)\\
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
