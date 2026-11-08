import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/020_critical_point.ts";

export default defineBlocks([
  {
    id: "heading_critical_point",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`\cosh,\sinh \text{ の加法定理と、正弦およびそれを含む積分の評価}` },
    labels: [],
  },

  {
    id: "critical_remark_real_analysis_facts_R3_R4",
    kind: "remark",
    title: { text: "積分の評価で持ち込む実数解析の事実（(R3)・(R4)・微分の公式・円周率の数値）" },
    labels: ["remark_real_analysis_facts_R3_R4"],
    statement: [
      paragraph([
        "以下の双曲線関数の主張と、正弦・余弦の評価（",
        ref("argument_minus_sine_nonnegative"),
        "・",
        ref("cosine_quadratic_lower_bound"),
        "・",
        ref("sine_cubic_lower_bound"),
        "）と、",
        ref("log_one_plus_at_most_argument"),
        "・",
        ref("closed_form_log_integral"),
        "・",
        ref("log_integral_two_sided_bounds"),
        "・",
        ref("three_halves_power_integral_bound"),
        "・",
        ref("sine_integral_two_sided"),
        " は、実数の区間上の関数の微分と積分を扱うので、次の事実を外部から持ち込む。(R3)(R4) と微分の公式は実数解析の一般の事実であり、正弦・余弦の導関数と円周率の数値の評価は本文の正弦・余弦・円周率についての主張である。円周率の数値の評価は、",
        ref("pi_squared_numerical_bounds"),
        "・",
        ref("log_integral_two_sided_bounds"),
        "・",
        ref("three_halves_power_integral_bound"),
        "・",
        ref("sine_integral_two_sided"),
        " が使う。",
      ]),
      list([
        [
          "(R3) **積分の線型性と単調性**：",
          math(String.raw`[a,b]`),
          " 上の連続関数 ",
          math(String.raw`g,h`),
          " と ",
          math(String.raw`\lambda,\nu \in \mathbb{R}`),
          " について ",
          math(String.raw`\int_a^b(\lambda g + \nu h) = \lambda\int_a^b g + \nu\int_a^b h`),
          "、および ",
          math(String.raw`g \leq h`),
          "（各点で）ならば ",
          math(String.raw`\int_a^b g \leq \int_a^b h`),
          "。",
        ],
        [
          "(R4) **微分積分学の基本定理**：",
          math(String.raw`F`),
          " が ",
          math(String.raw`[a,b]`),
          " 上微分可能で ",
          math(String.raw`F' = g`),
          " が連続なら ",
          math(String.raw`\int_a^b g(t)\,dt = F(b)-F(a)`),
          "。",
        ],
        [
          "**微分の公式**：",
          ref("def_scalar_exp"),
          " の実数の exp は ",
          math(String.raw`\mathbb{R}`),
          " 上微分可能で ",
          math(String.raw`\exp' = \exp`),
          "。",
          ref("def_real_logarithm_positive"),
          " の ",
          math(String.raw`\log`),
          " は ",
          math(String.raw`\mathbb{R}_{>0}`),
          " 上微分可能で ",
          math(String.raw`\log'(w) = \tfrac1w`),
          "。",
          ref("definition_of_sqrt_r_positive"),
          " の平方根は ",
          math(String.raw`\mathbb{R}_{>0}`),
          " 上微分可能で ",
          math(String.raw`(\sqrt{\ })'(w) = \tfrac{1}{2\sqrt w}`),
          "。定数関数と恒等関数 ",
          math(String.raw`u \mapsto u`),
          " は微分可能で、導関数はそれぞれ ",
          math(String.raw`0`),
          " と ",
          math(String.raw`1`),
          "。微分可能な関数の和・定数倍・積・商（分母が 0 でないところ）・合成は微分可能で、導関数は和・定数倍・積・商・合成の微分の公式で与えられる。微分可能な関数は連続である。",
        ],
        [
          "**正弦・余弦の導関数**（本文の正弦・余弦についての主張で、本文では証明しない）：",
          ref("def_sin"),
          " の ",
          math(String.raw`\sin`),
          "（",
          ref("def_arcsin"),
          " の弧の長さで定めた ",
          math(String.raw`\arcsin`),
          " の逆関数）と ",
          ref("def_cos"),
          " の ",
          math(String.raw`\cos`),
          " は ",
          math(String.raw`[-\pi/2,\pi/2]`),
          " 上微分可能で（端点では片側の微分）、",
          math(String.raw`\sin' = \cos`),
          "、",
          math(String.raw`\cos' = -\sin`),
          "。これは、本文の ",
          math(String.raw`\sin`),
          "・",
          math(String.raw`\cos`),
          " が、弧の長さで定める正弦・余弦として齋藤微積分（",
          ref("def_arc_length"),
          "・",
          ref("arcsin_is_bijection"),
          " が引く文献）で扱われているものと一致することを前提にしている。",
        ],
        [
          "**円周率の数値の評価**（本文の ",
          math(String.raw`\pi`),
          " についての主張で、本文では証明しない）：",
          ref("arcsin_is_bijection"),
          " が齋藤微積分から持ち込んだ ",
          math(String.raw`\pi \in \mathbb{R}`),
          "（",
          math(String.raw`\arcsin(1) = \pi/2`),
          " となる実数、すなわち単位円の弧 ",
          math(String.raw`(1,0)`),
          " から ",
          math(String.raw`(0,1)`),
          " までの長さの 2 倍）について ",
          math(String.raw`3.141592 \leq \pi \leq 3.141593`),
          "。",
        ],
      ]),
      paragraph(["どの段でどれを使うかは次のとおりである。"]),
      list([
        [
          "(R3) は ",
          ref("sinh_at_least_argument"),
          "、",
          ref("sinh_at_most_argument_times_cosh"),
          "、",
          ref("argument_minus_sine_nonnegative"),
          "、",
          ref("cosine_quadratic_lower_bound"),
          "、",
          ref("sine_cubic_lower_bound"),
          "、",
          ref("log_one_plus_at_most_argument"),
          "、",
          ref("sine_integral_two_sided"),
          " で、被積分関数の各点評価を積分へ持ち上げる段と積分を足し合わせる段に使う。",
        ],
        [
          "(R4) は ",
          ref("sinh_at_least_argument"),
          "、",
          ref("sinh_at_most_argument_times_cosh"),
          "、",
          ref("argument_minus_sine_nonnegative"),
          "、",
          ref("cosine_quadratic_lower_bound"),
          "、",
          ref("sine_cubic_lower_bound"),
          "、",
          ref("log_one_plus_at_most_argument"),
          "、",
          ref("closed_form_log_integral"),
          "、",
          ref("three_halves_power_integral_bound"),
          "、",
          ref("sine_integral_two_sided"),
          " で、導関数が分かっている関数の積分値を求める段に使う。",
        ],
        [
          "微分の公式は ",
          ref("sinh_derivative"),
          "、",
          ref("cosh_derivative"),
          "、",
          ref("arcsinh_derivative"),
          "、",
          ref("sinh_at_least_argument"),
          "、",
          ref("sinh_at_most_argument_times_cosh"),
          "、",
          ref("argument_minus_sine_nonnegative"),
          "、",
          ref("cosine_quadratic_lower_bound"),
          "、",
          ref("sine_cubic_lower_bound"),
          "、",
          ref("log_one_plus_at_most_argument"),
          "、",
          ref("closed_form_log_integral"),
          "、",
          ref("three_halves_power_integral_bound"),
          "、",
          ref("sine_integral_two_sided"),
          " で、(R4) に渡す導関数を求める段と、被積分関数の連続性を言う段に使う。正弦・余弦の導関数は、そのうち ",
          ref("argument_minus_sine_nonnegative"),
          "、",
          ref("cosine_quadratic_lower_bound"),
          "、",
          ref("sine_cubic_lower_bound"),
          "、",
          ref("sine_integral_two_sided"),
          " で使う。",
        ],
      ]),
      paragraph([
        "**これ以外の解析的道具（広義積分、一様収束、優収束、実解析性、平均値の定理）は使わない。**",
        "とくに以下に現れる積分はすべて有界閉区間上の連続関数の積分であり、広義積分は現れない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、臨界点の章の注記 remark_real_analysis_escape_chapter_E から、数学的道具立ての章に残った 4 項が使う (R3)(R4) の宣言を、その文面のまま分けて置いた。",
        "2026-11-02: elementary_sine_bounds を分けるときに、証明が使っていた sin・cos の導関数と、根拠なしで使っていた π の数値を、外部から持ち込む事実として足した。",
      ],
    },
  },

  {
    id: "critical_claim_cosh_is_even",
    kind: "claim",
    title: { tex: String.raw`\cosh \text{ は偶関数}` },
    labels: ["cosh_is_even"],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の ", math(String.raw`x \in \mathbb{R}`), " について"]),
      displayMath(String.raw`\cosh(-x) = \cosh x`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\cosh(-x)
&= \frac{\exp(-x)+\exp(-(-x))}{2}
&&(\because\ \cosh\ \text{の定義。}\blkref{def_cosh_sinh})\\
&= \frac{\exp(-x)+\exp(x)}{2}
&&(\because\ -(-x) = x)\\
&= \frac{\exp(x)+\exp(-x)}{2}
&&(\because\ \mathbb{R}\ \text{の加法の交換律})\\
&= \cosh x
&&(\because\ \cosh\ \text{の定義。}\blkref{def_cosh_sinh})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (1) の証明が「cosh(-y) = cosh y は定義から直ちに従う」と書いて省いていた等式を、独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_is_odd",
    kind: "claim",
    title: { tex: String.raw`\sinh \text{ は奇関数}` },
    labels: ["sinh_is_odd"],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の ", math(String.raw`x \in \mathbb{R}`), " について"]),
      displayMath(String.raw`\sinh(-x) = -\sinh x`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\sinh(-x)
&= \frac{\exp(-x)-\exp(-(-x))}{2}
&&(\because\ \sinh\ \text{の定義。}\blkref{def_cosh_sinh})\\
&= \frac{\exp(-x)-\exp(x)}{2}
&&(\because\ -(-x) = x)\\
&= \frac{-\left(\exp(x)-\exp(-x)\right)}{2}
&&(\because\ a-b = -(b-a))\\
&= -\frac{\exp(x)-\exp(-x)}{2}
&&(\because\ \text{分子の符号を分数の外へ出す})\\
&= -\sinh x
&&(\because\ \sinh\ \text{の定義。}\blkref{def_cosh_sinh})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (1) の証明が「sinh(-y) = -sinh y は定義から直ちに従う」と書いて省いていた等式を、独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_claim_cosh_addition_formula",
    kind: "claim",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\cosh \text{ の加法定理}` },
    labels: ["cosh_addition_formula"],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の ", math(String.raw`x, y \in \mathbb{R}`), " について（複号同順）"]),
      displayMath(String.raw`\cosh(x \pm y) = \cosh x\cosh y \pm \sinh x\sinh y`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の exp はすべて ",
        ref("def_scalar_exp"),
        " の実数の exp である。記号 ",
        math(String.raw`E_{x} := \exp(x),\ E_{-x} := \exp(-x),\ E_{y} := \exp(y),\ E_{-y} := \exp(-y)`),
        " を置く（",
        math(String.raw`E_{x}, E_{-x}, E_{y}, E_{-y} \in \mathbb{R}`),
        "）。複号が ",
        math(String.raw`+`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cosh(x+y)
&= \frac{\exp(x+y)+\exp(-(x+y))}{2}
&&(\because\ \cosh\ \text{の定義。}\blkref{def_cosh_sinh})\\
&= \frac{\exp(x+y)+\exp((-x)+(-y))}{2}
&&(\because\ -(x+y) = (-x)+(-y))\\
&= \frac{E_{x}E_{y}+E_{-x}E_{-y}}{2}
&&(\because\ \exp(s+t) = \exp(s)\exp(t)\ \text{を 2 箇所へ。}\blkref{scalar_exp_product})\\
&= \frac{2E_{x}E_{y}+2E_{-x}E_{-y}}{4}
&&(\because\ \text{分母と分子に }2\text{ を掛ける})\\
&= \frac{\left(E_{x}E_{y}+E_{x}E_{-y}+E_{-x}E_{y}+E_{-x}E_{-y}\right)
        +\left(E_{x}E_{y}-E_{x}E_{-y}-E_{-x}E_{y}+E_{-x}E_{-y}\right)}{4}
&&(\because\ E_{x}E_{-y}\ \text{と}\ E_{-x}E_{y}\ \text{を足して引く})\\
&= \frac{\left(E_{x}+E_{-x}\right)\left(E_{y}+E_{-y}\right)
        +\left(E_{x}-E_{-x}\right)\left(E_{y}-E_{-y}\right)}{4}
&&(\because\ \text{分配則})\\
&= \frac{E_{x}+E_{-x}}{2}\cdot\frac{E_{y}+E_{-y}}{2}
 + \frac{E_{x}-E_{-x}}{2}\cdot\frac{E_{y}-E_{-y}}{2}
&&(\because\ \text{分数の和と積})\\
&= \cosh x\cosh y + \sinh x\sinh y
&&(\because\ \cosh,\ \sinh\ \text{の定義を 4 箇所へ。}\blkref{def_cosh_sinh})
\end{aligned}`),
      paragraph(["複号が ", math(String.raw`-`), " の場合。"]),
      displayMath(String.raw`\begin{aligned}
\cosh(x-y)
&= \cosh(x+(-y))
&&(\because\ x-y = x+(-y))\\
&= \cosh x\cosh(-y) + \sinh x\sinh(-y)
&&(\because\ \text{複号が }+\text{ の場合を }-y \in \mathbb{R}\text{ に当てはめる})\\
&= \cosh x\cosh y + \sinh x\left(-\sinh y\right)
&&(\because\ \blkref{cosh_is_even},\ \blkref{sinh_is_odd})\\
&= \cosh x\cosh y - \sinh x\sinh y
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-01 の式変形統一で、(1)(2)(4) の四本の鎖にあった根拠 7 行を行中の \\quad (\\because …) から" +
          "行末の根拠列（aligned の &&）へ揃えた。式変形・根拠・段数・参照は変えていない。",
        "2026-11-02: SageMath の検算を付けるにあたり、5 つの主張と arcsinh の定義を束ねていた cosh_addition_and_half_angle を 1 ブロック 1 主張に分け、" +
          "その cosh の加法定理をこのブロックにした。鎖を主張の左辺から始め、exp の積の法則・分配則・分数の和と積を一行ずつに分け、" +
          "複号が - の場合を cosh_is_even・sinh_is_odd を引く鎖で書いた。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_addition_formula",
    kind: "claim",
    title: { tex: String.raw`\sinh \text{ の加法定理}` },
    labels: ["sinh_addition_formula"],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の ", math(String.raw`x, y \in \mathbb{R}`), " について（複号同順）"]),
      displayMath(String.raw`\sinh(x \pm y) = \sinh x\cosh y \pm \cosh x\sinh y`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      paragraph([
        "記号 ",
        math(String.raw`E_{x}, E_{-x}, E_{y}, E_{-y} \in \mathbb{R}`),
        " は ",
        ref("cosh_addition_formula"),
        " の証明と同じく、",
        ref("def_scalar_exp"),
        " の実数の exp の値 ",
        math(String.raw`\exp(x), \exp(-x), \exp(y), \exp(-y)`),
        " とする。複号が ",
        math(String.raw`+`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sinh(x+y)
&= \frac{\exp(x+y)-\exp(-(x+y))}{2}
&&(\because\ \sinh\ \text{の定義。}\blkref{def_cosh_sinh})\\
&= \frac{\exp(x+y)-\exp((-x)+(-y))}{2}
&&(\because\ -(x+y) = (-x)+(-y))\\
&= \frac{E_{x}E_{y}-E_{-x}E_{-y}}{2}
&&(\because\ \exp(s+t) = \exp(s)\exp(t)\ \text{を 2 箇所へ。}\blkref{scalar_exp_product})\\
&= \frac{2E_{x}E_{y}-2E_{-x}E_{-y}}{4}
&&(\because\ \text{分母と分子に }2\text{ を掛ける})\\
&= \frac{\left(E_{x}E_{y}+E_{x}E_{-y}-E_{-x}E_{y}-E_{-x}E_{-y}\right)
        +\left(E_{x}E_{y}-E_{x}E_{-y}+E_{-x}E_{y}-E_{-x}E_{-y}\right)}{4}
&&(\because\ E_{x}E_{-y}\ \text{と}\ E_{-x}E_{y}\ \text{を足して引く})\\
&= \frac{\left(E_{x}-E_{-x}\right)\left(E_{y}+E_{-y}\right)
        +\left(E_{x}+E_{-x}\right)\left(E_{y}-E_{-y}\right)}{4}
&&(\because\ \text{分配則})\\
&= \frac{E_{x}-E_{-x}}{2}\cdot\frac{E_{y}+E_{-y}}{2}
 + \frac{E_{x}+E_{-x}}{2}\cdot\frac{E_{y}-E_{-y}}{2}
&&(\because\ \text{分数の和と積})\\
&= \sinh x\cosh y + \cosh x\sinh y
&&(\because\ \cosh,\ \sinh\ \text{の定義を 4 箇所へ。}\blkref{def_cosh_sinh})
\end{aligned}`),
      paragraph(["複号が ", math(String.raw`-`), " の場合。"]),
      displayMath(String.raw`\begin{aligned}
\sinh(x-y)
&= \sinh(x+(-y))
&&(\because\ x-y = x+(-y))\\
&= \sinh x\cosh(-y) + \cosh x\sinh(-y)
&&(\because\ \text{複号が }+\text{ の場合を }-y \in \mathbb{R}\text{ に当てはめる})\\
&= \sinh x\cosh y + \cosh x\left(-\sinh y\right)
&&(\because\ \blkref{cosh_is_even},\ \blkref{sinh_is_odd})\\
&= \sinh x\cosh y - \cosh x\sinh y
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (1) の sinh の加法定理を独立の主張にした。旧証明は「sinh についても同じ計算で従う」としか書いていなかったので、鎖を書いた。",
      ],
    },
  },

  {
    id: "critical_claim_cosh_half_angle_formula",
    kind: "claim",
    title: { tex: String.raw`\cosh \text{ の半角公式}` },
    labels: ["cosh_half_angle_formula"],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の ", math(String.raw`x \in \mathbb{R}`), " について"]),
      displayMath(String.raw`\cosh x = 1 + 2\sinh^2\!\left(\tfrac{x}{2}\right)`),
      paragraph(["ここで ", math(String.raw`\sinh^2(a) := (\sinh a)^2`), " である。"]),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\cosh x
&= \cosh\!\left(\tfrac{x}{2}+\tfrac{x}{2}\right)
&&(\because\ x = \tfrac{x}{2}+\tfrac{x}{2})\\
&= \cosh\!\left(\tfrac{x}{2}\right)\cosh\!\left(\tfrac{x}{2}\right)
 + \sinh\!\left(\tfrac{x}{2}\right)\sinh\!\left(\tfrac{x}{2}\right)
&&(\because\ \blkref{cosh_addition_formula}\ \text{の複号 }+\text{ を }x \to \tfrac{x}{2},\ y \to \tfrac{x}{2}\text{ で})\\
&= \left(\cosh\tfrac{x}{2}\right)^2 + \left(\sinh\tfrac{x}{2}\right)^2
&&(\because\ \text{二乗の記法})\\
&= \left(1 + \left(\sinh\tfrac{x}{2}\right)^2\right) + \left(\sinh\tfrac{x}{2}\right)^2
&&(\because\ \blkref{cosh_sinh_basic_properties}\ \text{(2) を }\tfrac{x}{2}\text{ で移項})\\
&= 1 + 2\sinh^2\!\left(\tfrac{x}{2}\right)
&&(\because\ \text{同類項をまとめる})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (2) の第 1 式を独立の主張にし、鎖を主張の左辺から始めて、x = x/2 + x/2 の段と二乗の記法の段を足した。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_double_angle_formula",
    kind: "claim",
    title: { tex: String.raw`\sinh \text{ の倍角公式}` },
    labels: ["sinh_double_angle_formula"],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の ", math(String.raw`x \in \mathbb{R}`), " について"]),
      displayMath(String.raw`\sinh x = 2\sinh\!\left(\tfrac{x}{2}\right)\cosh\!\left(\tfrac{x}{2}\right)`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\sinh x
&= \sinh\!\left(\tfrac{x}{2}+\tfrac{x}{2}\right)
&&(\because\ x = \tfrac{x}{2}+\tfrac{x}{2})\\
&= \sinh\!\left(\tfrac{x}{2}\right)\cosh\!\left(\tfrac{x}{2}\right)
 + \cosh\!\left(\tfrac{x}{2}\right)\sinh\!\left(\tfrac{x}{2}\right)
&&(\because\ \blkref{sinh_addition_formula}\ \text{の複号 }+\text{ を }x \to \tfrac{x}{2},\ y \to \tfrac{x}{2}\text{ で})\\
&= \sinh\!\left(\tfrac{x}{2}\right)\cosh\!\left(\tfrac{x}{2}\right)
 + \sinh\!\left(\tfrac{x}{2}\right)\cosh\!\left(\tfrac{x}{2}\right)
&&(\because\ \mathbb{R}\ \text{の乗法の交換律})\\
&= 2\sinh\!\left(\tfrac{x}{2}\right)\cosh\!\left(\tfrac{x}{2}\right)
&&(\because\ \text{同類項をまとめる})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (2) の第 2 式を独立の主張にした。旧証明は「sinh の加法定理で x = y = x/2 とすれば従う」としか書いていなかったので、鎖を書いた。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_zero",
    kind: "claim",
    title: { tex: String.raw`\sinh 0 = 0` },
    labels: ["sinh_zero"],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の ", math(String.raw`\sinh`), " について"]),
      displayMath(String.raw`\sinh 0 = 0`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\sinh 0
&= \frac{\exp(0)-\exp(-0)}{2}
&&(\because\ \sinh\ \text{の定義。}\blkref{def_cosh_sinh})\\
&= \frac{\exp(0)-\exp(0)}{2}
&&(\because\ -0 = 0)\\
&= \frac{1-1}{2}
&&(\because\ \blkref{scalar_exp_zero}\ \text{を 2 箇所へ})\\
&= 0
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (5) の証明が使っていた sinh 0 = 0 を、cosh の単調性と (5) の二つの不等式から引けるよう独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_strictly_increasing",
    kind: "claim",
    title: { tex: String.raw`\sinh \text{ は狭義単調増加}` },
    labels: ["sinh_strictly_increasing"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`x, y \in \mathbb{R}`),
        " が ",
        math(String.raw`x < y`),
        " を満たすなら ",
        math(String.raw`\sinh x < \sinh y`),
        "。",
      ]),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      paragraph(["準備として、二つの exp の大小を作る。"]),
      displayMath(String.raw`\begin{aligned}
x < y
&\Longrightarrow \exp(x) < \exp(y)
&&(\because\ \blkref{real_exp_strictly_increasing})\\
x < y
&\Longrightarrow -y < -x
&&(\because\ \text{両辺に }-1<0\text{ を掛けると不等号の向きが反転する})\\
&\Longrightarrow \exp(-y) < \exp(-x)
&&(\because\ \blkref{real_exp_strictly_increasing})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp(x) < \exp(y)
&\Longrightarrow \exp(y)-\exp(x) > 0
&&(\because\ \text{両辺に }-\exp(x)\text{ を加える})\\
\exp(-y) < \exp(-x)
&\Longrightarrow \exp(-x)-\exp(-y) > 0
&&(\because\ \text{両辺に }-\exp(-y)\text{ を加える})\\
\exp(y)-\exp(x) > 0\ \land\ \exp(-x)-\exp(-y) > 0
&\Longrightarrow \left(\exp(y)-\exp(x)\right)+\left(\exp(-x)-\exp(-y)\right) > 0
&&(\because\ \text{正の実数の和は正})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh y - \sinh x
&= \frac{\exp(y)-\exp(-y)}{2} - \frac{\exp(x)-\exp(-x)}{2}
&&(\because\ \sinh\ \text{の定義を 2 箇所へ。}\blkref{def_cosh_sinh})\\
&= \frac{\left(\exp(y)-\exp(-y)\right)-\left(\exp(x)-\exp(-x)\right)}{2}
&&(\because\ \text{分母の等しい分数の差})\\
&= \frac{\left(\exp(y)-\exp(x)\right)+\left(\exp(-x)-\exp(-y)\right)}{2}
&&(\because\ \text{分子の項の並べ替え})\\
&> 0
&&(\because\ \text{上の分子の正値性と、正の数を }2>0\text{ で割ると正})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh y - \sinh x > 0
&\Longrightarrow \sinh x < \sinh y
&&(\because\ \text{両辺に }\sinh x\text{ を加える})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (3) を独立の主張にした。旧証明は exp(-x) > exp(-y) を -x > -y を経ずに書き、二つの不等式を一つの < で合わせていたので、準備の鎖と差の鎖に分けた。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_is_injective",
    kind: "claim",
    title: { tex: String.raw`\sinh \text{ は単射}` },
    labels: ["sinh_is_injective"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`u, v \in \mathbb{R}`),
        " が ",
        math(String.raw`\sinh u = \sinh v`),
        " を満たすなら ",
        math(String.raw`u = v`),
        "。",
      ]),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      paragraph(["対偶を示す。"]),
      displayMath(String.raw`\begin{aligned}
u \neq v
&\Longrightarrow u < v\ \lor\ v < u
&&(\because\ \mathbb{R}\ \text{の順序は全順序})\\
&\Longrightarrow \sinh u < \sinh v\ \lor\ \sinh v < \sinh u
&&(\because\ \blkref{sinh_strictly_increasing}\ \text{をそれぞれの場合へ})\\
&\Longrightarrow \sinh u \neq \sinh v
&&(\because\ a < b\ \text{なら}\ a \neq b)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (4) の証明と下流（kappa_of_K_basic、臨界点の sinh 2K_c = 1 の解）が「(3) より sinh は単射」と書いて使っていた事実を、独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_derivative",
    kind: "claim",
    title: { tex: String.raw`\sinh' = \cosh` },
    labels: ["sinh_derivative"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`\sinh : \mathbb{R} \to \mathbb{R}`),
        " は微分可能で、",
        math(String.raw`x \in \mathbb{R}`),
        " について ",
        math(String.raw`\sinh'(x) = \cosh x`),
        "。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、微分が実数の極限で定まるからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n : \mathbb{R} \to \mathbb{R},\ n(x) := -x`),
        " と置くと、",
        math(String.raw`\sinh = \tfrac12\left(\exp - \exp\circ n\right)`),
        " である（",
        ref("def_cosh_sinh"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sinh'(x)
&= \left(\tfrac12\left(\exp - \exp\circ n\right)\right)'(x)
&&(\because\ \sinh = \tfrac12\left(\exp - \exp\circ n\right))\\
&= \tfrac12\left(\exp - \exp\circ n\right)'(x)
&&(\because\ \text{微分の公式の定数倍})\\
&= \tfrac12\left(\exp'(x) - (\exp\circ n)'(x)\right)
&&(\because\ \text{微分の公式の和（差は }-1\text{ 倍との和）})\\
&= \tfrac12\left(\exp'(x) - \exp'(n(x))\cdot n'(x)\right)
&&(\because\ \text{微分の公式の合成})\\
&= \tfrac12\left(\exp(x) - \exp(n(x))\cdot n'(x)\right)
&&(\because\ \text{微分の公式の }\exp' = \exp\text{ を 2 箇所へ})\\
&= \tfrac12\left(\exp(x) - \exp(-x)\cdot n'(x)\right)
&&(\because\ n(x) = -x)\\
&= \tfrac12\left(\exp(x) - \exp(-x)\cdot(-1)\right)
&&(\because\ n = (-1)\cdot\mathrm{id}\text{ に微分の公式の定数倍と恒等関数の導関数 }1)\\
&= \frac{\exp(x)+\exp(-x)}{2}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \cosh x
&&(\because\ \cosh\ \text{の定義。}\blkref{def_cosh_sinh})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (5) の証明が「sinh' = cosh は定義から直ちに従う」と書いて省いていた等式を、微分の公式から導く独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_claim_cosh_derivative",
    kind: "claim",
    title: { tex: String.raw`\cosh' = \sinh` },
    labels: ["cosh_derivative"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`\cosh : \mathbb{R} \to \mathbb{R}`),
        " は微分可能で、",
        math(String.raw`x \in \mathbb{R}`),
        " について ",
        math(String.raw`\cosh'(x) = \sinh x`),
        "。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、微分が実数の極限で定まるからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n : \mathbb{R} \to \mathbb{R},\ n(x) := -x`),
        " と置くと、",
        math(String.raw`\cosh = \tfrac12\left(\exp + \exp\circ n\right)`),
        " である（",
        ref("def_cosh_sinh"),
        "）。微分可能であることは、",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式（",
        math(String.raw`\exp`),
        " と恒等関数は微分可能で、和・定数倍・合成は微分可能）による。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cosh'(x)
&= \left(\tfrac12\left(\exp + \exp\circ n\right)\right)'(x)
&&(\because\ \cosh = \tfrac12\left(\exp + \exp\circ n\right))\\
&= \tfrac12\left(\exp + \exp\circ n\right)'(x)
&&(\because\ \text{微分の公式の定数倍})\\
&= \tfrac12\left(\exp'(x) + (\exp\circ n)'(x)\right)
&&(\because\ \text{微分の公式の和})\\
&= \tfrac12\left(\exp'(x) + \exp'(n(x))\cdot n'(x)\right)
&&(\because\ \text{微分の公式の合成})\\
&= \tfrac12\left(\exp(x) + \exp(n(x))\cdot n'(x)\right)
&&(\because\ \text{微分の公式の }\exp' = \exp\text{ を 2 箇所へ})\\
&= \tfrac12\left(\exp(x) + \exp(-x)\cdot n'(x)\right)
&&(\because\ n(x) = -x)\\
&= \tfrac12\left(\exp(x) + \exp(-x)\cdot(-1)\right)
&&(\because\ n = (-1)\cdot\mathrm{id}\text{ に微分の公式の定数倍と恒等関数の導関数 }1)\\
&= \frac{\exp(x)-\exp(-x)}{2}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \sinh x
&&(\because\ \sinh\ \text{の定義。}\blkref{def_cosh_sinh})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（全証明の SageMath 検算）: kappa_of_K_basic の証明が (tanh)' = 1/cosh^2 と cosh t/sinh^2 t の導関数で使う cosh' = sinh が本文に無かったので、sinh_derivative と同じ鎖で示す主張として足した。検算は sagemath/check/cosh_derivative/。",
      ],
    },
  },

  {
    id: "critical_claim_sqrt_of_square_plus_one_is_positive",
    kind: "claim",
    title: { tex: String.raw`\sqrt{y^2+1} > 0` },
    labels: ["sqrt_of_square_plus_one_is_positive"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        " について ",
        math(String.raw`y^2+1 \in \mathbb{R}_{\geq 0}`),
        " であり、",
        ref("definition_of_sqrt_r_positive"),
        " の平方根について ",
        math(String.raw`\sqrt{y^2+1} > 0`),
        "。",
      ]),
    ],
    proof: [
      paragraph(["実数の平方は非負なので ", math(String.raw`y^2 \geq 0`), " である。"]),
      displayMath(String.raw`\begin{aligned}
y^2+1
&\geq 0+1
&&(\because\ y^2 \geq 0\ \text{の両辺に }1\text{ を加える})\\
&= 1
&&(\because\ \mathbb{R}\ \text{の四則})\\
&> 0
&&(\because\ \mathbb{R}\ \text{の順序})
\end{aligned}`),
      paragraph([
        "とくに ",
        math(String.raw`y^2+1 \in \mathbb{R}_{\geq 0}`),
        " なので ",
        math(String.raw`s := \sqrt{y^2+1}`),
        " が定まり、",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`s \geq 0`),
        " かつ ",
        math(String.raw`s^2 = y^2+1`),
        " である。",
        math(String.raw`s = 0`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
s = 0
&\Longrightarrow s^2 = 0
&&(\because\ 0^2 = 0)\\
&\Longrightarrow y^2+1 = 0
&&(\because\ s^2 = y^2+1)
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`y^2+1 \geq 1`),
        " に反する。よって ",
        math(String.raw`s \neq 0`),
        " であり、",
        math(String.raw`s \geq 0`),
        " と合わせて ",
        math(String.raw`\sqrt{y^2+1} = s > 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: arcsinh の定義・微分の証明が使う √(y²+1) > 0 を、他のブロックの証明の中身を引かずに済むよう独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_claim_arcsinh_argument_times_conjugate_is_one",
    kind: "claim",
    title: { tex: String.raw`\left(y+\sqrt{y^2+1}\right)\left(\sqrt{y^2+1}-y\right) = 1` },
    labels: ["arcsinh_argument_times_conjugate_is_one"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        " について（平方根は ",
        ref("sqrt_of_square_plus_one_is_positive"),
        " により定まる）",
      ]),
      displayMath(String.raw`\left(y+\sqrt{y^2+1}\right)\left(\sqrt{y^2+1}-y\right) = 1`),
    ],
    proof: [
      paragraph([
        math(String.raw`s := \sqrt{y^2+1} \in \mathbb{R}_{\geq 0}`),
        " と置く。",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`s^2 = y^2+1`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(y+s\right)\left(s-y\right)
&= ys - y^2 + s^2 - sy
&&(\because\ \text{分配則})\\
&= s^2 - y^2
&&(\because\ ys = sy\ \text{と項の並べ替え})\\
&= (y^2+1) - y^2
&&(\because\ s^2 = y^2+1)\\
&= 1
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: arcsinh_argument_is_positive と sinh_of_arcsinh が使う (y+s)(s-y) = 1 を、証明の中身を引かずに済むよう独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_claim_arcsinh_argument_is_positive",
    kind: "claim",
    title: { tex: String.raw`y + \sqrt{y^2+1} > 0` },
    labels: ["arcsinh_argument_is_positive"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        " について（平方根は ",
        ref("sqrt_of_square_plus_one_is_positive"),
        " により定まる）",
      ]),
      displayMath(String.raw`y + \sqrt{y^2+1} > 0`),
    ],
    proof: [
      paragraph([
        math(String.raw`s := \sqrt{y^2+1}`),
        "、",
        math(String.raw`p := y + s,\ q := s - y \in \mathbb{R}`),
        " と置く。",
        ref("arcsinh_argument_times_conjugate_is_one"),
        " より ",
        math(String.raw`pq = 1`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
p + q
&= (y+s) + (s-y)
&&(\because\ p,\ q\ \text{の置き方})\\
&= 2s
&&(\because\ \mathbb{R}\ \text{の四則})\\
&> 2\cdot 0
&&(\because\ \blkref{sqrt_of_square_plus_one_is_positive}\text{ の }s > 0\text{ の両辺に }2>0\text{ を掛ける})\\
&= 0
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      paragraph(["背理法で ", math(String.raw`p > 0`), " を示す。", math(String.raw`p \leq 0`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
p \leq 0\ \land\ pq = 1
&\Longrightarrow p < 0
&&(\because\ p = 0\ \text{なら}\ pq = 0 \neq 1)\\
p < 0\ \land\ pq = 1
&\Longrightarrow q < 0
&&(\because\ q \geq 0\ \text{なら}\ pq \leq 0 < 1)\\
p < 0\ \land\ q < 0
&\Longrightarrow p + q < 0
&&(\because\ \text{負の実数の和は負})
\end{aligned}`),
      paragraph([
        "これは ",
        math(String.raw`p + q > 0`),
        " に反する。よって ",
        math(String.raw`y + \sqrt{y^2+1} = p > 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (4) の証明は y + √(y²+1) > 0 を √(y²+1) > √(y²) = |y| ≥ -y で示していたが、実数の絶対値と平方根の単調性を定めるブロックが本文に無い。" +
          "(y+s)(s-y) = 1 と (y+s)+(s-y) = 2s > 0 から示す形に改め、arcsinh の定義の前提として独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_definition_arcsinh",
    kind: "definition",
    title: { tex: String.raw`\mathrm{arcsinh}` },
    labels: ["def_arcsinh"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        " について、",
        ref("arcsinh_argument_is_positive"),
        " より ",
        math(String.raw`y + \sqrt{y^2+1} \in \mathbb{R}_{>0}`),
        " なので、",
        ref("def_real_logarithm_positive"),
        " の実対数を使い",
      ]),
      displayMath(String.raw`\mathrm{arcsinh}(y) := \log\left(y + \sqrt{y^2+1}\right) \in \mathbb{R}`),
      paragraph([
        "と定める。これにより写像 ",
        math(String.raw`\mathrm{arcsinh} : \mathbb{R} \to \mathbb{R}`),
        " が定まる。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、実対数と平方根の値が実数だからである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (4) の主張の中にあった arcsinh の定義を、定義のブロックとして分けた。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_of_arcsinh",
    kind: "claim",
    title: { tex: String.raw`\sinh(\mathrm{arcsinh}(y)) = y` },
    labels: ["sinh_of_arcsinh"],
    statement: [
      paragraph([
        ref("def_arcsinh"),
        " の ",
        math(String.raw`\mathrm{arcsinh}`),
        " と ",
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`\sinh`),
        " について、",
        math(String.raw`y \in \mathbb{R}`),
        " なら",
      ]),
      displayMath(String.raw`\sinh(\mathrm{arcsinh}(y)) = y`),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`s := \sqrt{y^2+1} \in \mathbb{R}_{\geq 0}`),
        "（",
        math(String.raw`s^2 = y^2+1`),
        "）、",
        math(String.raw`u := \mathrm{arcsinh}(y) = \log(y+s) \in \mathbb{R}`),
        " と置く。",
        ref("arcsinh_argument_times_conjugate_is_one"),
        " より ",
        math(String.raw`(y+s)(s-y) = 1`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\exp(u)
&= \exp(\log(y+s))
&&(\because\ u\ \text{の置き方})\\
&= y+s
&&(\because\ \blkref{def_real_logarithm_positive}\ \text{の }\exp(\log w) = w\text{。}y+s>0\ \text{は}\ \blkref{arcsinh_argument_is_positive})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp(-u)
&= \exp(-u)\cdot 1
&&(\because\ 1\ \text{は乗法の単位元})\\
&= \exp(-u)\left((y+s)(s-y)\right)
&&(\because\ \blkref{arcsinh_argument_times_conjugate_is_one})\\
&= \left(\exp(-u)\,(y+s)\right)(s-y)
&&(\because\ \mathbb{R}\ \text{の乗法の結合律})\\
&= \left(\exp(-u)\exp(u)\right)(s-y)
&&(\because\ \exp(u) = y+s)\\
&= \exp((-u)+u)\,(s-y)
&&(\because\ \blkref{scalar_exp_product})\\
&= \exp(0)\,(s-y)
&&(\because\ (-u)+u = 0)\\
&= s-y
&&(\because\ \blkref{scalar_exp_zero})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh(\mathrm{arcsinh}(y))
&= \sinh u
&&(\because\ u\ \text{の置き方})\\
&= \frac{\exp(u)-\exp(-u)}{2}
&&(\because\ \sinh\ \text{の定義。}\blkref{def_cosh_sinh})\\
&= \frac{(y+s)-(s-y)}{2}
&&(\because\ \text{上の二つの鎖})\\
&= \frac{2y}{2}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= y
&&(\because\ \text{約分})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (4) の sinh(arcsinh(y)) = y を独立の主張にした。旧証明の exp(-u) = 1/(y+√(y²+1)) は exp(u)exp(-u) = 1 を根拠に書いていなかったので、" +
          "(y+s)(s-y) = 1 と exp の積の法則で exp(-u) = s - y を出す鎖に改めた。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_equation_solved_by_arcsinh",
    kind: "claim",
    title: { tex: String.raw`\sinh u = y \iff u = \mathrm{arcsinh}(y)` },
    labels: ["sinh_equation_solved_by_arcsinh"],
    statement: [
      paragraph([
        ref("def_arcsinh"),
        " の ",
        math(String.raw`\mathrm{arcsinh}`),
        " と ",
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`\sinh`),
        " について、",
        math(String.raw`u, y \in \mathbb{R}`),
        " なら",
      ]),
      displayMath(String.raw`\sinh u = y \iff u = \mathrm{arcsinh}(y)`),
    ],
    proof: [
      paragraph(["両方向を別々に示すので、ここは一続きの式にしない。"]),
      displayMath(String.raw`\begin{aligned}
u = \mathrm{arcsinh}(y)
&\Longrightarrow \sinh u = \sinh(\mathrm{arcsinh}(y))
&&(\because\ \text{等しい実数の }\sinh\text{ は等しい})\\
&\Longrightarrow \sinh u = y
&&(\because\ \blkref{sinh_of_arcsinh})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh u = y
&\Longrightarrow \sinh u = \sinh(\mathrm{arcsinh}(y))
&&(\because\ \blkref{sinh_of_arcsinh})\\
&\Longrightarrow u = \mathrm{arcsinh}(y)
&&(\because\ \blkref{sinh_is_injective})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (4) の「(3) と合わせて sinh u = y ⟺ u = arcsinh(y)」を独立の主張にし、両方向を根拠付きの鎖で書いた。",
      ],
    },
  },

  {
    id: "critical_claim_arcsinh_derivative",
    kind: "claim",
    title: { tex: String.raw`\mathrm{arcsinh}'(y) = \tfrac{1}{\sqrt{y^2+1}}` },
    labels: ["arcsinh_derivative"],
    statement: [
      paragraph([
        ref("def_arcsinh"),
        " の ",
        math(String.raw`\mathrm{arcsinh} : \mathbb{R} \to \mathbb{R}`),
        " は微分可能で、",
        math(String.raw`y \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\mathrm{arcsinh}'(y) = \frac{1}{\sqrt{y^2+1}}`),
      paragraph([
        "右辺の分母は ",
        ref("sqrt_of_square_plus_one_is_positive"),
        " より正である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、微分が実数の極限で定まるからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`r : \mathbb{R} \to \mathbb{R}_{>0},\ r(y) := y^2+1`),
        "、",
        math(String.raw`s : \mathbb{R} \to \mathbb{R}_{>0},\ s(y) := \sqrt{r(y)}`),
        "、",
        math(String.raw`p : \mathbb{R} \to \mathbb{R}_{>0},\ p(y) := y + s(y)`),
        " と置く（値が正であることは ",
        ref("sqrt_of_square_plus_one_is_positive"),
        " と ",
        ref("arcsinh_argument_is_positive"),
        " による）。",
        ref("def_arcsinh"),
        " より ",
        math(String.raw`\mathrm{arcsinh} = \log\circ p`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
r'(y)
&= (\mathrm{id}\cdot\mathrm{id})'(y) + 0
&&(\because\ r = \mathrm{id}\cdot\mathrm{id} + 1\text{ に微分の公式の和と定数関数})\\
&= 1\cdot y + y\cdot 1
&&(\because\ \text{微分の公式の積と恒等関数の導関数 }1)\\
&= 2y
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
s'(y)
&= (\sqrt{\ })'(r(y))\cdot r'(y)
&&(\because\ \text{微分の公式の合成})\\
&= \frac{1}{2\sqrt{r(y)}}\cdot r'(y)
&&(\because\ \text{微分の公式の平方根。}r(y) > 0)\\
&= \frac{1}{2\sqrt{y^2+1}}\cdot 2y
&&(\because\ r\ \text{の置き方と、上の }r'\text{ の鎖})\\
&= \frac{y}{\sqrt{y^2+1}}
&&(\because\ \text{約分})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\mathrm{arcsinh}'(y)
&= \log'(p(y))\cdot p'(y)
&&(\because\ \text{微分の公式の合成。}p(y) > 0)\\
&= \frac{1}{y+\sqrt{y^2+1}}\cdot p'(y)
&&(\because\ \text{微分の公式の }\log'(w) = \tfrac1w)\\
&= \frac{1}{y+\sqrt{y^2+1}}\cdot\left(1 + s'(y)\right)
&&(\because\ p = \mathrm{id} + s\text{ に微分の公式の和と恒等関数の導関数 }1)\\
&= \frac{1}{y+\sqrt{y^2+1}}\cdot\left(1 + \frac{y}{\sqrt{y^2+1}}\right)
&&(\because\ \text{上の }s'(y))\\
&= \frac{1}{y+\sqrt{y^2+1}}\cdot\frac{\sqrt{y^2+1}+y}{\sqrt{y^2+1}}
&&(\because\ \text{通分。}\blkref{sqrt_of_square_plus_one_is_positive})\\
&= \frac{1}{\sqrt{y^2+1}}
&&(\because\ \text{約分。}\blkref{arcsinh_argument_is_positive})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (4) の arcsinh の微分を独立の主張にした。旧証明の「log と √ の微分・合成関数の微分」は本文で宣言されていない事実だったので、" +
          "remark_real_analysis_facts_R3_R4 に微分の公式を足して引き、√(y²+1) の微分を別の鎖に分けた。",
      ],
    },
  },

  {
    id: "critical_claim_cosh_at_least_one",
    kind: "claim",
    title: { tex: String.raw`\cosh x \geq 1` },
    labels: ["cosh_at_least_one"],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の ", math(String.raw`x \in \mathbb{R}`), " について ", math(String.raw`\cosh x \geq 1`), "。"]),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      paragraph(["実数の平方は非負なので ", math(String.raw`\sinh^2\!\left(\tfrac{x}{2}\right) \geq 0`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\sinh^2\!\left(\tfrac{x}{2}\right) \geq 0
&\Longrightarrow 2\sinh^2\!\left(\tfrac{x}{2}\right) \geq 2\cdot 0
&&(\because\ \text{両辺に }2>0\text{ を掛ける})\\
&\Longrightarrow 1 + 2\sinh^2\!\left(\tfrac{x}{2}\right) \geq 1 + 2\cdot 0
&&(\because\ \text{両辺に }1\text{ を加える})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh x
&= 1 + 2\sinh^2\!\left(\tfrac{x}{2}\right)
&&(\because\ \blkref{cosh_half_angle_formula})\\
&\geq 1 + 2\cdot 0
&&(\because\ \text{上の含意の鎖})\\
&= 1
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (5) の証明が積分の単調性から導いていた cosh u ≥ 1 を、半角公式から導く独立の主張にした。",
      ],
    },
  },

  {
    id: "critical_claim_cosh_monotone_on_nonnegative",
    kind: "claim",
    title: { tex: String.raw`\cosh \text{ は } \mathbb{R}_{\geq 0} \text{ 上で単調増加}` },
    labels: ["cosh_monotone_on_nonnegative"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`u, t \in \mathbb{R}`),
        " が ",
        math(String.raw`0 \leq u \leq t`),
        " を満たすなら ",
        math(String.raw`\cosh u \leq \cosh t`),
        "。",
      ]),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`a := \tfrac{t+u}{2},\ b := \tfrac{t-u}{2} \in \mathbb{R}`),
        " と置く。",
        math(String.raw`a + b = t`),
        "、",
        math(String.raw`a - b = u`),
        " であり、",
        math(String.raw`t + u \geq 0`),
        "・",
        math(String.raw`t - u \geq 0`),
        " より ",
        math(String.raw`a \geq 0`),
        "・",
        math(String.raw`b \geq 0`),
        " である。",
        math(String.raw`c \in \mathbb{R}_{\geq 0}`),
        " について ",
        math(String.raw`\sinh c \geq 0`),
        " である。実際 ",
        math(String.raw`c = 0`),
        " なら ",
        ref("sinh_zero"),
        " より ",
        math(String.raw`\sinh c = 0`),
        "、",
        math(String.raw`c > 0`),
        " なら ",
        ref("cosh_sinh_basic_properties"),
        " (3) より ",
        math(String.raw`\sinh c > 0`),
        "。",
      ]),
      displayMath(String.raw`\begin{aligned}
a \geq 0\ \land\ b \geq 0
&\Longrightarrow \sinh a \geq 0\ \land\ \sinh b \geq 0
&&(\because\ \text{準備})\\
&\Longrightarrow \sinh a\sinh b \geq 0
&&(\because\ \text{非負の実数の積は非負})\\
&\Longrightarrow 2\sinh a\sinh b \geq 0
&&(\because\ \text{両辺に }2>0\text{ を掛ける})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh t - \cosh u
&= \cosh(a+b) - \cosh(a-b)
&&(\because\ a+b = t,\ a-b = u)\\
&= \left(\cosh a\cosh b + \sinh a\sinh b\right) - \left(\cosh a\cosh b - \sinh a\sinh b\right)
&&(\because\ \blkref{cosh_addition_formula}\ \text{の複号 }\pm\text{ を 1 箇所ずつ})\\
&= 2\sinh a\sinh b
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\geq 0
&&(\because\ \text{上の含意の鎖})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh t - \cosh u \geq 0
&\Longrightarrow \cosh u \leq \cosh t
&&(\because\ \text{両辺に }\cosh u\text{ を加える})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (5) の証明が積分から導いていた cosh の [0,∞) 上の単調性を、加法定理から導く独立の主張にした。" +
          "下流（second_derivative_log_divergence の cosh(κ/2) ≤ cosh(1/4)）が旧 (2)(3) を引いて使っていた事実でもある。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_at_least_argument",
    kind: "claim",
    title: { tex: String.raw`t \leq \sinh t \quad (t \geq 0)` },
    labels: ["sinh_at_least_argument"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`t \in \mathbb{R}_{\geq 0}`),
        " について ",
        math(String.raw`t \leq \sinh t`),
        "。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、証明で区間 ",
        math(String.raw`[0,t]`),
        " 上の積分を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R3)(R4)）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`t = 0`),
        " なら ",
        ref("sinh_zero"),
        " より ",
        math(String.raw`\sinh t = 0 = t`),
        "。以下 ",
        math(String.raw`t > 0`),
        " とする。",
        ref("sinh_derivative"),
        " より ",
        math(String.raw`\sinh`),
        " は微分可能で ",
        math(String.raw`\sinh' = \cosh`),
        "、",
        math(String.raw`\cosh`),
        " は微分の公式（和・定数倍・合成と ",
        math(String.raw`\exp' = \exp`),
        "）より微分可能なので連続である。",
      ]),
      displayMath(String.raw`\begin{aligned}
t
&= t - 0
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \int_0^t 1\,du
&&(\because\ \text{(R4) を }F(u) = u\text{ に。微分の公式で }F' = 1)\\
&\leq \int_0^t \cosh u\,du
&&(\because\ \text{(R3) の単調性と、}u \in [0,t]\text{ で }1 \leq \cosh u\text{。}\blkref{cosh_at_least_one})\\
&= \sinh t - \sinh 0
&&(\because\ \text{(R4) を }F = \sinh\text{ に。}\blkref{sinh_derivative})\\
&= \sinh t - 0
&&(\because\ \blkref{sinh_zero})\\
&= \sinh t
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (5) の前半を独立の主張にし、主張の左辺から始まる一続きの鎖に改めた。",
      ],
    },
  },

  {
    id: "critical_claim_sinh_at_most_argument_times_cosh",
    kind: "claim",
    title: { tex: String.raw`\sinh t \leq t\cosh t \quad (t \geq 0)` },
    labels: ["sinh_at_most_argument_times_cosh"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`t \in \mathbb{R}_{\geq 0}`),
        " について ",
        math(String.raw`\sinh t \leq t\cosh t`),
        "。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、証明で区間 ",
        math(String.raw`[0,t]`),
        " 上の積分を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R3)(R4)）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`t = 0`),
        " なら ",
        ref("sinh_zero"),
        " より ",
        math(String.raw`\sinh t = 0 = t\cosh t`),
        "。以下 ",
        math(String.raw`t > 0`),
        " とする。",
        ref("sinh_at_least_argument"),
        " の証明と同じく ",
        math(String.raw`\cosh`),
        " は連続である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sinh t
&= \sinh t - 0
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \sinh t - \sinh 0
&&(\because\ \blkref{sinh_zero})\\
&= \int_0^t \cosh u\,du
&&(\because\ \text{(R4) を }F = \sinh\text{ に。}\blkref{sinh_derivative})\\
&\leq \int_0^t \cosh t\,du
&&(\because\ \text{(R3) の単調性と、}u \in [0,t]\text{ で }\cosh u \leq \cosh t\text{。}\blkref{cosh_monotone_on_nonnegative})\\
&= t\cosh t - 0\cdot\cosh t
&&(\because\ \text{(R4) を }F(u) = u\cosh t\text{ に。微分の公式で }F' = \cosh t)\\
&= t\cosh t
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 cosh_addition_and_half_angle (5) の後半を独立の主張にし、主張の左辺から始まる一続きの鎖に改めた。cosh の単調性は cosh_monotone_on_nonnegative から引く。",
      ],
    },
  },

  {
    id: "critical_claim_sine_zero",
    kind: "claim",
    title: { tex: String.raw`\sin 0 = 0` },
    labels: ["sine_zero"],
    statement: [
      paragraph([
        ref("def_sin"),
        " の ",
        math(String.raw`\sin`),
        " について ",
        math(String.raw`\sin 0 = 0`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y_0 := \sin 0 \in [-1,1]`),
        " とおく。",
        ref("def_sin"),
        " より ",
        math(String.raw`\arcsin(y_0) = 0`),
        " である。",
        math(String.raw`y_0 > 0`),
        " と仮定すると ",
        math(String.raw`-y_0 \in [-1,0)`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\arcsin(-y_0)
&= -\arcsin(-(-y_0))
&&(\because\ \blkref{def_arcsin}\ \text{の第二の式。}-1 \leq -y_0 < 0)\\
&= -\arcsin(y_0)
&&(\because\ -(-y_0) = y_0)\\
&= -0
&&(\because\ \arcsin(y_0) = 0)\\
&= 0
\end{aligned}`),
      paragraph([
        "となる。一方 ",
        math(String.raw`-y_0 < y_0`),
        " なので ",
        ref("arcsin_is_bijection"),
        " の狭義単調増加より ",
        math(String.raw`\arcsin(-y_0) < \arcsin(y_0) = 0`),
        " であり、矛盾する。",
        math(String.raw`y_0 < 0`),
        " と仮定すると ",
        math(String.raw`y_0 \in [-1,0)`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\arcsin(-y_0)
&= -(-\arcsin(-y_0))
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= -\arcsin(y_0)
&&(\because\ \blkref{def_arcsin}\ \text{の第二の式。}-1 \leq y_0 < 0)\\
&= -0
&&(\because\ \arcsin(y_0) = 0)\\
&= 0
\end{aligned}`),
      paragraph([
        "となる。一方 ",
        math(String.raw`y_0 < -y_0`),
        " なので ",
        ref("arcsin_is_bijection"),
        " の狭義単調増加より ",
        math(String.raw`0 = \arcsin(y_0) < \arcsin(-y_0)`),
        " であり、矛盾する。よって ",
        math(String.raw`y_0 = 0`),
        "、すなわち ",
        math(String.raw`\sin 0 = 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: elementary_sine_bounds を分けるときに、積分の端点 0 での値に要るので足した。",
      ],
    },
  },

  {
    id: "critical_claim_arctan_zero",
    kind: "claim",
    title: { tex: String.raw`\arctan 0 = 0` },
    labels: ["arctan_zero"],
    statement: [
      paragraph([
        ref("def_arctan"),
        " の ",
        math(String.raw`\arctan`),
        " について、",
        math(String.raw`0 \in \mathbb{R}`),
        " での値は ",
        math(String.raw`\arctan 0 = 0`),
        " である（",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\arctan`),
        " の定義域と値域が実数だからである）。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\arctan 0
&= \arcsin\!\left(\frac{0}{\sqrt{1+0^2}^{(\mathbb{R}_{\geq 0})}}\right)
&&(\because\ \blkref{def_arctan}\ \text{の}\ x \to 0)\\
&= \arcsin\!\left(\frac{0}{\sqrt{1+0\cdot 0}^{(\mathbb{R}_{\geq 0})}}\right)
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ \text{の}\ r \to 0\bigr)\\
&= \arcsin\!\left(\frac{0}{\sqrt{1+0}^{(\mathbb{R}_{\geq 0})}}\right)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）の}\ x \to 0\bigr)\\
&= \arcsin\!\left(\frac{0}{\sqrt{1}^{(\mathbb{R}_{\geq 0})}}\right)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a + 0 = a\ \text{の}\ a \to 1\bigr)\\
&= \arcsin\!\left(\frac{0}{1}\right)
&&\bigl(\because\ \blkref{sqrt_of_real_one_is_one}\bigr)\\
&= \arcsin(0)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0/x = 0\ (x \neq 0)\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）の}\ x \to 1\bigr)\\
&= \arcsin(\sin 0)
&&(\because\ \blkref{sine_zero})\\
&= 0
&&(\because\ \blkref{def_sin}\ \text{を}\ 0 \in [-\pi/2,\pi/2]\ \text{で})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08: relation_of_gamma_2_theta_tilde の準備の第五にあった arctan 0 の鎖を独立の主張にした。inverse_of_sqrt_cc の φ_polar(1_C) の鎖と relation_of_gamma_2_theta_tilde の (3)(4) の鎖が引く。",
      ],
    },
  },

  {
    id: "critical_claim_cosine_zero",
    kind: "claim",
    title: { tex: String.raw`\cos 0 = 1` },
    labels: ["cosine_zero"],
    statement: [
      paragraph([
        ref("def_cos"),
        " の ",
        math(String.raw`\cos`),
        " について ",
        math(String.raw`\cos 0 = 1`),
        "。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\cos 0
&= \sqrt{1-(\sin 0)^2}^{(\mathbb{R}_{\geq 0})}
&&(\because\ \blkref{def_cos})\\
&= \sqrt{1-0^2}^{(\mathbb{R}_{\geq 0})}
&&(\because\ \blkref{sine_zero})\\
&= \sqrt{1}^{(\mathbb{R}_{\geq 0})}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= 1
&&(\because\ \blkref{sqrt_of_real_one_is_one})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: elementary_sine_bounds を分けるときに、積分の端点 0 での値に要るので足した。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 鎖の最後の行 √1 = 1 が 1 ≥ 0・1^2 = 1・definition_of_sqrt_r_positive の一意性を 1 行で使っていたので、sqrt_of_real_one_is_one の参照にした。値と主張は不変。",
      ],
    },
  },

  {
    id: "critical_claim_cosine_at_most_one",
    kind: "claim",
    title: { tex: String.raw`\cos v \leq 1` },
    labels: ["cosine_at_most_one"],
    statement: [
      paragraph([
        ref("def_cos"),
        " の ",
        math(String.raw`\cos`),
        " について、",
        math(String.raw`v \in [-\pi/2,\pi/2]`),
        " ならば ",
        math(String.raw`\cos v \leq 1`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`c := \cos v \in \mathbb{R}`),
        " とおく。",
        ref("def_cos"),
        " と ",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`c \geq 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
c^2
&= \left(\sqrt{1-(\sin v)^2}^{(\mathbb{R}_{\geq 0})}\right)^2
&&(\because\ \blkref{def_cos})\\
&= 1-(\sin v)^2
&&(\because\ \blkref{definition_of_sqrt_r_positive})\\
&\leq 1
&&(\because\ (\sin v)^2 \geq 0)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`1 < c`),
        " と仮定すると ",
        math(String.raw`c > 1 > 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
c^2
&= c \cdot c\\
&> 1 \cdot c
&&(\because\ 1 < c\ \text{の両辺に}\ c > 0\ \text{を掛ける})\\
&> 1 \cdot 1
&&(\because\ 1 < c\ \text{の両辺に}\ 1 > 0\ \text{を掛ける})\\
&= 1
\end{aligned}`),
      paragraph([
        "となって ",
        math(String.raw`c^2 \leq 1`),
        " に反する。よって ",
        math(String.raw`c \leq 1`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: elementary_sine_bounds を分けるときに、被積分関数 1 - cos v の符号に要るので足した。",
      ],
    },
  },

  {
    id: "critical_claim_argument_minus_sine_nonnegative",
    kind: "claim",
    title: { tex: String.raw`t - \sin t \geq 0 \quad (0 \leq t \leq \pi/2)` },
    labels: ["argument_minus_sine_nonnegative"],
    statement: [
      paragraph([
        ref("def_sin"),
        " の ",
        math(String.raw`\sin`),
        " について、",
        math(String.raw`t \in [0,\pi/2]`),
        " ならば ",
        math(String.raw`t - \sin t \geq 0`),
        "。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、証明で区間 ",
        math(String.raw`[0,t]`),
        " 上の積分を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R3)(R4)）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`t = 0`),
        " なら ",
        ref("sine_zero"),
        " より ",
        math(String.raw`t - \sin t = 0 - 0 = 0`),
        "。以下 ",
        math(String.raw`t > 0`),
        " とする。",
        math(String.raw`[0,t] \subset [-\pi/2,\pi/2]`),
        " なので、",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式と正弦・余弦の導関数より ",
        math(String.raw`F(u) := u - \sin u`),
        " は ",
        math(String.raw`[0,t]`),
        " 上微分可能で ",
        math(String.raw`F'(u) = 1 - \cos u`),
        " であり、",
        math(String.raw`\cos`),
        " は微分可能なので ",
        math(String.raw`F'`),
        " は連続である。",
      ]),
      displayMath(String.raw`\begin{aligned}
t - \sin t
&= (t - \sin t) - (0 - \sin 0)
&&(\because\ \blkref{sine_zero}\ \text{より}\ 0 - \sin 0 = 0)\\
&= \int_0^t (1 - \cos u)\,du
&&(\because\ \text{(R4) を}\ F\ \text{に})\\
&\geq \int_0^t 0\,du
&&(\because\ \text{(R3) の単調性と、}u \in [0,t]\ \text{で}\ 1 - \cos u \geq 0\text{。}\blkref{cosine_at_most_one})\\
&= 0 - 0
&&(\because\ \text{(R4) を定数関数}\ 0\ \text{に。微分の公式で導関数は}\ 0)\\
&= 0
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 elementary_sine_bounds の Step 1 を独立の主張にした。sin の定義域が [-π/2, π/2] なので t の範囲を t ≥ 0 から [0, π/2] に改め、端点 0 での値と 1 - cos u ≥ 0 の根拠を足した。",
      ],
    },
  },

  {
    id: "critical_claim_cosine_quadratic_lower_bound",
    kind: "claim",
    title: { tex: String.raw`\cos t - 1 + \tfrac{t^2}{2} \geq 0 \quad (0 \leq t \leq \pi/2)` },
    labels: ["cosine_quadratic_lower_bound"],
    statement: [
      paragraph([
        ref("def_cos"),
        " の ",
        math(String.raw`\cos`),
        " について、",
        math(String.raw`t \in [0,\pi/2]`),
        " ならば ",
        math(String.raw`\cos t - 1 + \tfrac{t^2}{2} \geq 0`),
        "。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、証明で区間 ",
        math(String.raw`[0,t]`),
        " 上の積分を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R3)(R4)）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`t = 0`),
        " なら ",
        ref("cosine_zero"),
        " より ",
        math(String.raw`\cos t - 1 + \tfrac{t^2}{2} = 1 - 1 + 0 = 0`),
        "。以下 ",
        math(String.raw`t > 0`),
        " とする。",
        math(String.raw`[0,t] \subset [-\pi/2,\pi/2]`),
        " なので、",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式と正弦・余弦の導関数より ",
        math(String.raw`G(u) := \cos u - 1 + \tfrac{u^2}{2}`),
        " は ",
        math(String.raw`[0,t]`),
        " 上微分可能で ",
        math(String.raw`G'(u) = -\sin u + u = u - \sin u`),
        " であり、",
        math(String.raw`\sin`),
        " は微分可能なので ",
        math(String.raw`G'`),
        " は連続である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cos t - 1 + \frac{t^2}{2}
&= \left(\cos t - 1 + \frac{t^2}{2}\right) - \left(\cos 0 - 1 + \frac{0^2}{2}\right)
&&(\because\ \blkref{cosine_zero}\ \text{より}\ \cos 0 - 1 + \tfrac{0^2}{2} = 0)\\
&= \int_0^t (u - \sin u)\,du
&&(\because\ \text{(R4) を}\ G\ \text{に})\\
&\geq \int_0^t 0\,du
&&(\because\ \text{(R3) の単調性と、}u \in [0,t]\ \text{で}\ u - \sin u \geq 0\text{。}\blkref{argument_minus_sine_nonnegative})\\
&= 0 - 0
&&(\because\ \text{(R4) を定数関数}\ 0\ \text{に。微分の公式で導関数は}\ 0)\\
&= 0
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 elementary_sine_bounds の Step 2 の前半を独立の主張にした。t の範囲を [0, π/2] に改め、端点 0 での値と導関数の根拠を足した。",
      ],
    },
  },

  {
    id: "critical_claim_sine_cubic_lower_bound",
    kind: "claim",
    title: { tex: String.raw`\sin t - t + \tfrac{t^3}{6} \geq 0 \quad (0 \leq t \leq \pi/2)` },
    labels: ["sine_cubic_lower_bound"],
    statement: [
      paragraph([
        ref("def_sin"),
        " の ",
        math(String.raw`\sin`),
        " について、",
        math(String.raw`t \in [0,\pi/2]`),
        " ならば ",
        math(String.raw`\sin t - t + \tfrac{t^3}{6} \geq 0`),
        "。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、証明で区間 ",
        math(String.raw`[0,t]`),
        " 上の積分を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R3)(R4)）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`t = 0`),
        " なら ",
        ref("sine_zero"),
        " より ",
        math(String.raw`\sin t - t + \tfrac{t^3}{6} = 0 - 0 + 0 = 0`),
        "。以下 ",
        math(String.raw`t > 0`),
        " とする。",
        math(String.raw`[0,t] \subset [-\pi/2,\pi/2]`),
        " なので、",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式と正弦・余弦の導関数より ",
        math(String.raw`H(v) := \sin v - v + \tfrac{v^3}{6}`),
        " は ",
        math(String.raw`[0,t]`),
        " 上微分可能で ",
        math(String.raw`H'(v) = \cos v - 1 + \tfrac{v^2}{2}`),
        " であり、",
        math(String.raw`\cos`),
        " は微分可能なので ",
        math(String.raw`H'`),
        " は連続である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sin t - t + \frac{t^3}{6}
&= \left(\sin t - t + \frac{t^3}{6}\right) - \left(\sin 0 - 0 + \frac{0^3}{6}\right)
&&(\because\ \blkref{sine_zero}\ \text{より}\ \sin 0 - 0 + \tfrac{0^3}{6} = 0)\\
&= \int_0^t \left(\cos v - 1 + \frac{v^2}{2}\right)dv
&&(\because\ \text{(R4) を}\ H\ \text{に})\\
&\geq \int_0^t 0\,dv
&&(\because\ \text{(R3) の単調性と、}v \in [0,t]\ \text{で}\ \cos v - 1 + \tfrac{v^2}{2} \geq 0\text{。}\blkref{cosine_quadratic_lower_bound})\\
&= 0 - 0
&&(\because\ \text{(R4) を定数関数}\ 0\ \text{に。微分の公式で導関数は}\ 0)\\
&= 0
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 elementary_sine_bounds の Step 2 の後半を独立の主張にした。t の範囲を [0, π/2] に改め、端点 0 での値と導関数の根拠を足した。",
      ],
    },
  },

  {
    id: "critical_claim_pi_squared_numerical_bounds",
    kind: "claim",
    title: { tex: String.raw`9.8696 \leq \pi^2 \leq 9.8697` },
    labels: ["pi_squared_numerical_bounds"],
    statement: [
      paragraph([
        ref("remark_real_analysis_facts_R3_R4"),
        " の円周率の数値の評価の下で、",
        math(String.raw`9.8696 \leq \pi^2 \leq 9.8697`),
        "（",
        math(String.raw`\pi \in \mathbb{R}`),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "円周率の数値の評価より ",
        math(String.raw`0 < 3.141592 \leq \pi \leq 3.141593`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi^2
&= \pi \cdot \pi\\
&\geq 3.141592 \cdot \pi
&&(\because\ 3.141592 \leq \pi\ \text{の両辺に}\ \pi > 0\ \text{を掛ける})\\
&\geq 3.141592 \cdot 3.141592
&&(\because\ 3.141592 \leq \pi\ \text{の両辺に}\ 3.141592 > 0\ \text{を掛ける})\\
&= 9.869600294464
&&(\because\ \mathbb{Q}\ \text{の積})\\
&\geq 9.8696
&&(\because\ \mathbb{Q}\ \text{の大小比較})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\pi^2
&= \pi \cdot \pi\\
&\leq 3.141593 \cdot \pi
&&(\because\ \pi \leq 3.141593\ \text{の両辺に}\ \pi > 0\ \text{を掛ける})\\
&\leq 3.141593 \cdot 3.141593
&&(\because\ \pi \leq 3.141593\ \text{の両辺に}\ 3.141593 > 0\ \text{を掛ける})\\
&= 9.869606577649
&&(\because\ \mathbb{Q}\ \text{の積})\\
&\leq 9.8697
&&(\because\ \mathbb{Q}\ \text{の大小比較})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 elementary_sine_bounds が根拠なしで使っていた 9.8696 ≤ π² ≤ 9.8697 を、外部から持ち込む円周率の数値の評価から導く主張にした。",
      ],
    },
  },

  {
    id: "critical_definition_sine_bound_constant",
    kind: "definition",
    title: { tex: String.raw`c_0 := 1 - \tfrac{\pi^2}{24}` },
    labels: ["def_sine_bound_constant"],
    statement: [
      paragraph([
        math(String.raw`c_0 := 1 - \dfrac{\pi^2}{24} \in \mathbb{R}`),
        " と定める（",
        math(String.raw`\mathbb{R}`),
        " を使うのは ",
        math(String.raw`\pi`),
        " が実数だからである）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 elementary_sine_bounds の主張の中で置いていた c_0 を独立の定義にした。",
      ],
    },
  },

  {
    id: "critical_claim_sine_bound_constant_numerical_bounds",
    kind: "claim",
    title: { tex: String.raw`0.5887 \leq c_0 \leq 0.5888` },
    labels: ["sine_bound_constant_numerical_bounds"],
    statement: [
      paragraph([
        ref("def_sine_bound_constant"),
        " の ",
        math(String.raw`c_0`),
        " について ",
        math(String.raw`0.5887 \leq c_0 \leq 0.5888`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        ref("pi_squared_numerical_bounds"),
        " の ",
        math(String.raw`9.8696 \leq \pi^2 \leq 9.8697`),
        " から、次を得る。",
      ]),
      displayMath(String.raw`\frac{9.8696}{24} \leq \frac{\pi^2}{24} \leq \frac{9.8697}{24}
\qquad (\because\ \text{各辺を}\ 24 > 0\ \text{で割る})`),
      displayMath(String.raw`-\frac{9.8697}{24} \leq -\frac{\pi^2}{24} \leq -\frac{9.8696}{24}
\qquad (\because\ \text{各辺に}\ -1 < 0\ \text{を掛けると向きが反転する})`),
      displayMath(String.raw`1-\frac{9.8697}{24} \leq 1-\frac{\pi^2}{24} \leq 1-\frac{9.8696}{24}
\qquad (\because\ \text{各辺に}\ 1\ \text{を足す})`),
      displayMath(String.raw`\begin{aligned}
c_0
&= 1-\frac{\pi^2}{24}
&&(\because\ \blkref{def_sine_bound_constant})\\
&\geq 1-\frac{9.8697}{24}
&&(\because\ \text{上の三つ目の不等式の左側})\\
&= \frac{14.1303}{24}
&&(\because\ \mathbb{Q}\ \text{の四則})\\
&\geq \frac{14.1288}{24}
&&(\because\ 14.1288 \leq 14.1303\ \text{の両辺を}\ 24 > 0\ \text{で割る})\\
&= 0.5887
&&(\because\ \mathbb{Q}\ \text{の四則。}0.5887 \cdot 24 = 14.1288)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
c_0
&= 1-\frac{\pi^2}{24}
&&(\because\ \blkref{def_sine_bound_constant})\\
&\leq 1-\frac{9.8696}{24}
&&(\because\ \text{上の三つ目の不等式の右側})\\
&= \frac{14.1304}{24}
&&(\because\ \mathbb{Q}\ \text{の四則})\\
&\leq \frac{14.1312}{24}
&&(\because\ 14.1304 \leq 14.1312\ \text{の両辺を}\ 24 > 0\ \text{で割る})\\
&= 0.5888
&&(\because\ \mathbb{Q}\ \text{の四則。}0.5888 \cdot 24 = 14.1312)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 elementary_sine_bounds の c_0 の数値評価を独立の主張にし、有理数の四則と大小比較の行を分けた。",
      ],
    },
  },

  {
    id: "critical_008_claim_elementary_sine_bounds",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`\tfrac{\theta}{2} - \sin\tfrac{\theta}{2} \leq \tfrac{\theta^3}{48} \quad (0 \leq \theta \leq \pi)` },
    labels: ["elementary_sine_bounds"],
    statement: [
      paragraph([
        ref("def_sin"),
        " の ",
        math(String.raw`\sin`),
        " について、",
        math(String.raw`\theta \in [0,\pi]`),
        " ならば ",
        math(String.raw`\tfrac{\theta}{2} - \sin\tfrac{\theta}{2} \leq \tfrac{\theta^3}{48}`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`0 \leq \theta \leq \pi`),
        " の各辺を ",
        math(String.raw`2 > 0`),
        " で割って ",
        math(String.raw`\tfrac{\theta}{2} \in [0,\tfrac{\pi}{2}]`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{\theta}{2} - \sin\frac{\theta}{2}
&= \frac{1}{6}\left(\frac{\theta}{2}\right)^3 - \left(\sin\frac{\theta}{2} - \frac{\theta}{2} + \frac{1}{6}\left(\frac{\theta}{2}\right)^3\right)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\leq \frac{1}{6}\left(\frac{\theta}{2}\right)^3 - 0
&&(\because\ \blkref{sine_cubic_lower_bound}\ \text{を}\ t = \tfrac{\theta}{2}\ \text{に})\\
&= \frac{\theta^3}{48}
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 1 ブロック 1 主張にするため、一般の t の三つの評価（argument_minus_sine_nonnegative・cosine_quadratic_lower_bound・sine_cubic_lower_bound）、c_0 の定義と数値評価、c_0 θ/2 ≤ sin(θ/2) ≤ θ/2（sine_half_angle_linear_bounds）を別のブロックへ分け、このブロックには上側の θ³/48 の評価だけを残した（下側 0 ≤ θ/2 - sin(θ/2) は argument_minus_sine_nonnegative の当てはめなので主張から外した）。",
      ],
    },
  },

  {
    id: "critical_claim_sine_half_angle_linear_bounds",
    kind: "claim",
    title: { tex: String.raw`c_0\tfrac{\theta}{2} \leq \sin\tfrac{\theta}{2} \leq \tfrac{\theta}{2} \quad (0 \leq \theta \leq \pi)` },
    labels: ["sine_half_angle_linear_bounds"],
    statement: [
      paragraph([
        ref("def_sin"),
        " の ",
        math(String.raw`\sin`),
        " と ",
        ref("def_sine_bound_constant"),
        " の ",
        math(String.raw`c_0`),
        " について、",
        math(String.raw`\theta \in [0,\pi]`),
        " ならば ",
        math(String.raw`c_0\tfrac{\theta}{2} \leq \sin\tfrac{\theta}{2} \leq \tfrac{\theta}{2}`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`0 \leq \theta \leq \pi`),
        " の各辺を ",
        math(String.raw`2 > 0`),
        " で割って ",
        math(String.raw`0 \leq \tfrac{\theta}{2} \leq \tfrac{\pi}{2}`),
        " である。これから次を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\frac{\theta}{2}\right)^2
&= \frac{\theta}{2}\cdot\frac{\theta}{2}\\
&\leq \frac{\theta}{2}\cdot\frac{\pi}{2}
&&(\because\ \tfrac{\theta}{2} \leq \tfrac{\pi}{2}\ \text{の両辺に}\ \tfrac{\theta}{2} \geq 0\ \text{を掛ける})\\
&\leq \frac{\pi}{2}\cdot\frac{\pi}{2}
&&(\because\ \tfrac{\theta}{2} \leq \tfrac{\pi}{2}\ \text{の両辺に}\ \tfrac{\pi}{2} > 0\ \text{を掛ける})\\
&= \frac{\pi^2}{4}
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      paragraph(["これを使って次を得る。"]),
      displayMath(String.raw`-\frac{1}{6}\left(\frac{\theta}{2}\right)^2 \geq -\frac{1}{6}\cdot\frac{\pi^2}{4}
\qquad (\because\ (\tfrac{\theta}{2})^2 \leq \tfrac{\pi^2}{4}\ \text{の両辺に}\ -\tfrac{1}{6} < 0\ \text{を掛けると向きが反転する})`),
      displayMath(String.raw`1 - \frac{1}{6}\left(\frac{\theta}{2}\right)^2 \geq 1 - \frac{1}{6}\cdot\frac{\pi^2}{4}
\qquad (\because\ \text{直前の不等式の両辺に}\ 1\ \text{を足す})`),
      paragraph(["上からの評価は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\sin\frac{\theta}{2}
&= \frac{\theta}{2} - \left(\frac{\theta}{2} - \sin\frac{\theta}{2}\right)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\leq \frac{\theta}{2} - 0
&&(\because\ \blkref{argument_minus_sine_nonnegative}\ \text{を}\ t = \tfrac{\theta}{2}\ \text{に})\\
&= \frac{\theta}{2}
\end{aligned}`),
      paragraph(["下からの評価は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\sin\frac{\theta}{2}
&= \left(\frac{\theta}{2} - \frac{1}{6}\left(\frac{\theta}{2}\right)^3\right) + \left(\sin\frac{\theta}{2} - \frac{\theta}{2} + \frac{1}{6}\left(\frac{\theta}{2}\right)^3\right)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\geq \frac{\theta}{2} - \frac{1}{6}\left(\frac{\theta}{2}\right)^3 + 0
&&(\because\ \blkref{sine_cubic_lower_bound}\ \text{を}\ t = \tfrac{\theta}{2}\ \text{に})\\
&= \frac{\theta}{2}\left(1 - \frac{1}{6}\left(\frac{\theta}{2}\right)^2\right)
&&(\because\ \mathbb{R}\ \text{の分配則})\\
&\geq \frac{\theta}{2}\left(1 - \frac{1}{6}\cdot\frac{\pi^2}{4}\right)
&&(\because\ \text{上の}\ 1 - \tfrac{1}{6}(\tfrac{\theta}{2})^2 \geq 1 - \tfrac{1}{6}\cdot\tfrac{\pi^2}{4}\ \text{の両辺に}\ \tfrac{\theta}{2} \geq 0\ \text{を掛ける})\\
&= \frac{\theta}{2}\left(1 - \frac{\pi^2}{24}\right)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= c_0\,\frac{\theta}{2}
&&(\because\ \blkref{def_sine_bound_constant}\ \text{と}\ \mathbb{R}\ \text{の積の可換性})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 elementary_sine_bounds の主張の第二の行を独立の主張にした。(θ/2)² ≤ π²/4 を準備の鎖にした。",
      ],
    },
  },

  {
    id: "critical_claim_real_log_of_product",
    kind: "claim",
    title: { tex: String.raw`\log(ab) = \log a + \log b` },
    labels: ["real_log_of_product"],
    statement: [
      paragraph([
        ref("def_real_logarithm_positive"),
        " の ",
        math(String.raw`\log : \mathbb{R}_{>0} \to \mathbb{R}`),
        " について、",
        math(String.raw`a, b \in \mathbb{R}_{>0}`),
        " なら ",
        math(String.raw`ab \in \mathbb{R}_{>0}`),
        " であり",
      ]),
      displayMath(String.raw`\log(ab) = \log a + \log b`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、実対数の値が実数だからである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`a > 0`),
        " と ",
        math(String.raw`b > 0`),
        " より、正の数の積は正なので ",
        math(String.raw`ab > 0`),
        " である。",
        math(String.raw`\log a, \log b \in \mathbb{R}`),
        " である（",
        ref("def_real_logarithm_positive"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\exp(\log a + \log b)
&= \exp(\log a)\exp(\log b)
&&(\because\ \blkref{scalar_exp_product}\ \text{を右辺から左辺へ})\\
&= ab
&&(\because\ \blkref{def_real_logarithm_positive}\ \text{の }\exp(\log y) = y\ \text{を 2 箇所へ})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\log(ab)
&= \log\left(\exp(\log a + \log b)\right)
&&(\because\ \text{準備の鎖})\\
&= \log a + \log b
&&(\because\ \blkref{def_real_logarithm_positive}\ \text{の }\log(\exp x) = x)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 closed_form_log_integral (2) の証明が根拠「log(ab) = log a + log b」をラベルなしで使っていたので、exp の積の法則から示す主張にした。",
      ],
    },
  },

  {
    id: "critical_definition_power_of_real_number",
    kind: "definition",
    title: { text: "実数の冪" },
    labels: ["def_power_of_real_number"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}`),
        " と ",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " について、冪 ",
        math(String.raw`a^m \in \mathbb{R}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`a^0 := 1,
\qquad
a^{m+1} := a^m\, a`),
      paragraph([
        "と定める。積は ",
        math(String.raw`\mathbb{R}`),
        " の積、",
        math(String.raw`1`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の乗法の単位元である。",
        ref("def_power_of_complex_number"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の冪とは別の写像であり、両者を同じものとして使わない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05: limit_of_log_Z_in_N_row の証明の c^N・2^M（正の実数の冪）を定めるブロックが本文に無かったので足した。def_power_of_complex_number と同じ形（零乗から始める帰納法）にした。",
      ],
    },
  },

  {
    id: "critical_definition_power_of_integer",
    kind: "definition",
    title: { text: "整数の冪" },
    labels: ["def_power_of_integer"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{Z}`),
        " と ",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " について、冪 ",
        math(String.raw`a^m \in \mathbb{Z}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`a^0 := 1_{\mathbb{Z}},
\qquad
a^{m+1} := a^m \cdot_{\mathbb{Z}} a`),
      paragraph([
        "と定める。",
        ref("def_power_of_real_number"),
        " の ",
        math(String.raw`\mathbb{R}`),
        " の冪とは別の写像であり、両者を同じものとして使わない。",
        math(String.raw`2_{\mathbb{Z}} := 1_{\mathbb{Z}} +_{\mathbb{Z}} 1_{\mathbb{Z}}`),
        " と書く。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。行列の大きさ 2^{M_col} は整数の冪だが、本文に定義が無かった。inclusion_zz_to_rr_of_power_of_two と power_of_two_in_integers_is_at_least_one が引けるよう、def_power_of_real_number と同じ形で足した。",
      ],
    },
  },

  {
    id: "critical_claim_power_of_two_in_integers_is_at_least_one",
    kind: "claim",
    title: { tex: String.raw`2_{\mathbb{Z}}^{\,M} \geq 1_{\mathbb{Z}}` },
    labels: ["power_of_two_in_integers_is_at_least_one"],
    statement: [
      paragraph([
        ref("def_power_of_integer"),
        " の冪について、",
        math(String.raw`M \in \mathbb{Z}_{\geq 0}`),
        " なら ",
        math(String.raw`2_{\mathbb{Z}}^{\,M} \in \mathbb{Z}_{\geq 1}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`M`),
        " についての帰納法で示す。",
        math(String.raw`M = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
2_{\mathbb{Z}}^{\,0}
&= 1_{\mathbb{Z}}
  &&\bigl(\because\ \blkref{def_power_of_integer}\ \text{の}\ a^0 := 1_{\mathbb{Z}}\ (a \to 2_{\mathbb{Z}})\bigr)\\
&\geq 1_{\mathbb{Z}}
  &&\bigl(\because\ \leq_{\mathbb{Z}}\ \text{の反射律}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`M \in \mathbb{Z}_{\geq 0}`),
        " で ",
        math(String.raw`2_{\mathbb{Z}}^{\,M} \geq 1_{\mathbb{Z}}`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
2_{\mathbb{Z}}^{\,M+1}
&= 2_{\mathbb{Z}}^{\,M} \cdot_{\mathbb{Z}} 2_{\mathbb{Z}}
  &&\bigl(\because\ \blkref{def_power_of_integer}\ \text{の}\ a^{m+1} := a^m a\ (a \to 2_{\mathbb{Z}},\ m \to M)\bigr)\\
&= 2_{\mathbb{Z}}^{\,M} \cdot_{\mathbb{Z}} (1_{\mathbb{Z}} +_{\mathbb{Z}} 1_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{def_power_of_integer}\ \text{の}\ 2_{\mathbb{Z}} := 1_{\mathbb{Z}} +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)\\
&= 2_{\mathbb{Z}}^{\,M} \cdot_{\mathbb{Z}} 1_{\mathbb{Z}} +_{\mathbb{Z}} 2_{\mathbb{Z}}^{\,M} \cdot_{\mathbb{Z}} 1_{\mathbb{Z}}
  &&\bigl(\because\ \mathbb{Z}\ \text{の分配法則}\bigr)\\
&= 2_{\mathbb{Z}}^{\,M} +_{\mathbb{Z}} 2_{\mathbb{Z}}^{\,M}
  &&\bigl(\because\ 1_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の乗法の単位元を二か所へ同時に}\bigr)\\
&\geq 1_{\mathbb{Z}} +_{\mathbb{Z}} 2_{\mathbb{Z}}^{\,M}
  &&\bigl(\because\ \text{帰納法の仮定}\ 2_{\mathbb{Z}}^{\,M} \geq 1_{\mathbb{Z}}\ \text{の両辺に}\ 2_{\mathbb{Z}}^{\,M}\ \text{を足す}\bigr)\\
&\geq 1_{\mathbb{Z}} +_{\mathbb{Z}} 1_{\mathbb{Z}}
  &&\bigl(\because\ \text{帰納法の仮定}\ 2_{\mathbb{Z}}^{\,M} \geq 1_{\mathbb{Z}}\ \text{の両辺に}\ 1_{\mathbb{Z}}\ \text{を足す}\bigr)\\
&\geq 1_{\mathbb{Z}} +_{\mathbb{Z}} 0_{\mathbb{Z}}
  &&\bigl(\because\ 1_{\mathbb{Z}} \geq 0_{\mathbb{Z}}\ \text{の両辺に}\ 1_{\mathbb{Z}}\ \text{を足す}\bigr)\\
&= 1_{\mathbb{Z}}
  &&\bigl(\because\ 0_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の和の単位元}\bigr)
\end{aligned}`),
      paragraph(["であり、主張は ", math(String.raw`M+1`), " でも成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。行列の大きさ d := 2_ℤ^{M_col} が ℤ_{≥1} の元であること（finite_sum_of_constant_real_number の m ∈ ℤ_{≥1}）と、inclusion_zz_to_rr_of_power_of_two の帰納法の段の 2_ℤ^M ∈ ℤ_{≥0} を引けるよう足した。",
      ],
    },
  },

  {
    id: "critical_claim_inclusion_zz_to_rr_of_power_of_two",
    kind: "claim",
    title: { tex: String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(2_{\mathbb{Z}}^{\,M}) = 2_{\mathbb{R}}^{\,M}` },
    labels: ["inclusion_zz_to_rr_of_power_of_two"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M}\bigr) = 2_{\mathbb{R}}^{\,M}`),
      paragraph([
        "である。左辺の ",
        math(String.raw`2_{\mathbb{Z}}^{\,M} \in \mathbb{Z}_{\geq 1}`),
        " は ",
        ref("def_power_of_integer"),
        " の ",
        math(String.raw`2_{\mathbb{Z}}`),
        " の冪（",
        ref("power_of_two_in_integers_is_at_least_one"),
        "）、右辺の ",
        math(String.raw`2_{\mathbb{R}}^{\,M} \in \mathbb{R}`),
        " は ",
        math(String.raw`2_{\mathbb{R}} := 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}`),
        " の ",
        ref("def_power_of_real_number"),
        " の冪、",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " は ",
        ref("inclusion_zz_to_rr"),
        " の写像である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`M`),
        " についての帰納法で示す。",
        math(String.raw`M = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,0}\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}})
  &&\bigl(\because\ \blkref{def_power_of_integer}\ \text{の}\ a^0 := 1_{\mathbb{Z}}\ (a \to 2_{\mathbb{Z}})\bigr)\\
&= 1_{\mathbb{R}}
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_one}\bigr)\\
&= 2_{\mathbb{R}}^{\,0}
  &&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^0 := 1\ (a \to 2_{\mathbb{R}})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`M \in \mathbb{Z}_{\geq 0}`),
        " で主張が成り立つと仮定すると、",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`2_{\mathbb{Z}}^{\,M} \in \mathbb{Z}_{\geq 1} \subset \mathbb{Z}_{\geq 0}`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M+1}\bigr)
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M} \cdot_{\mathbb{Z}} 2_{\mathbb{Z}}\bigr)
  &&\bigl(\because\ \blkref{def_power_of_integer}\ \text{の}\ a^{m+1} := a^m a\ (a \to 2_{\mathbb{Z}},\ m \to M)\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M} \cdot_{\mathbb{Z}} (1_{\mathbb{Z}} +_{\mathbb{Z}} 1_{\mathbb{Z}})\bigr)
  &&\bigl(\because\ \blkref{def_power_of_integer}\ \text{の}\ 2_{\mathbb{Z}} := 1_{\mathbb{Z}} +_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M} \cdot_{\mathbb{Z}} 1_{\mathbb{Z}} +_{\mathbb{Z}} 2_{\mathbb{Z}}^{\,M} \cdot_{\mathbb{Z}} 1_{\mathbb{Z}}\bigr)
  &&\bigl(\because\ \mathbb{Z}\ \text{の分配法則}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M} +_{\mathbb{Z}} 2_{\mathbb{Z}}^{\,M}\bigr)
  &&\bigl(\because\ 1_{\mathbb{Z}}\ \text{は}\ \mathbb{Z}\ \text{の乗法の単位元を二か所へ同時に}\bigr)\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M}\bigr) +_{\mathbb{R}} \iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M}\bigr)
  &&\bigl(\because\ \blkref{inclusion_zz_to_rr_preserves_sum_of_nonnegatives}\ (a, b \to 2_{\mathbb{Z}}^{\,M})\bigr)\\
&= 2_{\mathbb{R}}^{\,M} +_{\mathbb{R}} 2_{\mathbb{R}}^{\,M}
  &&\bigl(\because\ \text{帰納法の仮定を二か所へ同時に}\bigr)\\
&= 2_{\mathbb{R}}^{\,M}\, 1_{\mathbb{R}} +_{\mathbb{R}} 2_{\mathbb{R}}^{\,M}\, 1_{\mathbb{R}}
  &&\bigl(\because\ 1_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元を二か所へ同時に}\bigr)\\
&= 2_{\mathbb{R}}^{\,M}\,(1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}})
  &&\bigl(\because\ \mathbb{R}\ \text{の分配法則}\bigr)\\
&= 2_{\mathbb{R}}^{\,M}\, 2_{\mathbb{R}}
  &&\bigl(\because\ 2_{\mathbb{R}} := 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}\bigr)\\
&= 2_{\mathbb{R}}^{\,M+1}
  &&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m\, a\ (a \to 2_{\mathbb{R}},\ m \to M)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["であり、主張は ", math(String.raw`M+1`), " でも成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。trace_power_upper_bound の最後の鎖で、行列の大きさ d = 2^{M_col} ∈ ℤ を ι_{ℤ→ℝ} で送った値が ℝ の冪 2^{M_col} であることを引けるよう足した。ℝ の冪の定義の隣に置く。ℤ の冪は def_power_of_integer。",
      ],
    },
  },

  {
    id: "critical_claim_real_log_of_power",
    kind: "claim",
    title: { tex: String.raw`\log(a^n) = \iota_{\mathbb{Z}\to\mathbb{R}}(n)\log a` },
    labels: ["real_log_of_power"],
    statement: [
      paragraph([
        ref("def_real_logarithm_positive"),
        " の ",
        math(String.raw`\log : \mathbb{R}_{>0} \to \mathbb{R}`),
        " と ",
        ref("def_power_of_real_number"),
        " の冪について、",
        math(String.raw`a \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " なら ",
        math(String.raw`a^n \in \mathbb{R}_{>0}`),
        " であり",
      ]),
      displayMath(String.raw`\log(a^n) = \iota_{\mathbb{Z}\to\mathbb{R}}(n)\,\log a`),
      paragraph([
        "である。",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " は ",
        ref("inclusion_zz_to_rr"),
        " の写像で、右辺は ",
        math(String.raw`n \in \mathbb{Z}`),
        " を ",
        math(String.raw`\mathbb{R}`),
        " の元へ送ってから ",
        math(String.raw`\log a \in \mathbb{R}`),
        " と掛けた積である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、実対数の値が実数だからである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n`),
        " についての帰納法で、",
        math(String.raw`a^n \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`\log(a^n) = \iota_{\mathbb{Z}\to\mathbb{R}}(n)\,\log a`),
        " を同時に示す。",
        math(String.raw`n = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
a^1
&= a^0\, a
&&(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m a\ \text{を}\ m = 0\ \text{で})\\
&= 1\cdot a
&&(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^0 := 1)\\
&= a
&&(\because\ \mathbb{R}\ \text{の乗法の単位元})
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`a^1 \in \mathbb{R}_{>0}`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\log(a^1)
&= \log a
&&(\because\ \text{上の}\ a^1 = a)\\
&= 1_{\mathbb{R}}\cdot\log a
&&(\because\ \mathbb{R}\ \text{の乗法の単位元})\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}})\,\log a
&&(\because\ \blkref{inclusion_zz_to_rr_of_one}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(1_{\mathbb{Z}}) = 1_{\mathbb{R}}\ \text{を右辺から左辺へ})
\end{aligned}`),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " で ",
        math(String.raw`a^n \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`\log(a^n) = \iota_{\mathbb{Z}\to\mathbb{R}}(n)\,\log a`),
        " を仮定する。",
        math(String.raw`a^{n+1} = a^n a`),
        "（",
        ref("def_power_of_real_number"),
        "）は正の数 ",
        math(String.raw`a^n`),
        " と ",
        math(String.raw`a`),
        " の積なので ",
        math(String.raw`a^{n+1} \in \mathbb{R}_{>0}`),
        " であり（",
        ref("real_log_of_product"),
        "）",
      ]),
      displayMath(String.raw`\begin{aligned}
\log(a^{n+1})
&= \log(a^n\, a)
&&(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{n+1} := a^n\, a)\\
&= \log(a^n) + \log a
&&(\because\ \blkref{real_log_of_product}\ \text{を}\ a^n, a \in \mathbb{R}_{>0}\ \text{に})\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(n)\,\log a + \log a
&&(\because\ \text{帰納法の仮定})\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(n)\,\log a + 1_{\mathbb{R}}\cdot\log a
&&(\because\ 1_{\mathbb{R}}\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元})\\
&= \bigl(\iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\bigr)\log a
&&(\because\ \mathbb{R}\ \text{の分配法則})\\
&= \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}})\,\log a
&&(\because\ \blkref{inclusion_zz_to_rr}\ \text{の}\ \iota_{\mathbb{Z}\to\mathbb{R}}(n +_{\mathbb{Z}} 1_{\mathbb{Z}}) := \iota_{\mathbb{Z}\to\mathbb{R}}(n) +_{\mathbb{R}} 1_{\mathbb{R}}\ \text{を右辺から左辺へ})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05: limit_of_log_Z_in_N_row の証明が根拠「log(c^N) = N log c」「log(2^M) = M log 2」をラベルなしで使っていたので、real_log_of_product から帰納法で示す主張にした。冪は def_power_of_real_number。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 右辺の n log a は n ∈ ℤ と log a ∈ ℝ の積で、ℤ の元を ℝ の積へ入れる写像が名指されていなかった（証明の書き方の「同一視をしない」）。inclusion_zz_to_rr の ι_{ℤ→ℝ} を通して ι(n) log a と書き、n = 1 の鎖に ι(1) = 1（inclusion_zz_to_rr_of_one）の行、帰納法の段に 1·log a と ι(n) + 1 = ι(n+1)（inclusion_zz_to_rr の定義）の行を足した。値は不変。",
      ],
    },
  },

  {
    id: "critical_claim_log_one_plus_at_most_argument",
    kind: "claim",
    title: { tex: String.raw`\log(1+x) \leq x \quad (x \geq 0)` },
    labels: ["log_one_plus_at_most_argument"],
    statement: [
      paragraph([
        ref("def_real_logarithm_positive"),
        " の ",
        math(String.raw`\log`),
        " について、",
        math(String.raw`x \in \mathbb{R}_{\geq 0}`),
        " なら ",
        math(String.raw`1 + x \in \mathbb{R}_{>0}`),
        " であり ",
        math(String.raw`\log(1+x) \leq x`),
        "。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、実対数の値が実数であり、証明で区間 ",
        math(String.raw`[0,x]`),
        " 上の積分を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R3)(R4) と微分の公式）。",
      ]),
    ],
    proof: [
      paragraph(["準備。"]),
      displayMath(String.raw`\begin{aligned}
\log(1+0)
&= \log 1
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \log(\exp 0)
&&(\because\ \blkref{scalar_exp_zero})\\
&= 0
&&(\because\ \blkref{def_real_logarithm_positive}\ \text{の }\log(\exp x) = x)
\end{aligned}`),
      paragraph([
        math(String.raw`x = 0`),
        " なら ",
        math(String.raw`\log(1+x) = \log(1+0) = 0 = x`),
        " である。以下 ",
        math(String.raw`x > 0`),
        " とする。",
        math(String.raw`v \in [0,x]`),
        " なら ",
        math(String.raw`1 + v \geq 1 > 0`),
        " なので、",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式（恒等関数・定数関数・和・差・",
        math(String.raw`\log' (w) = \tfrac1w`),
        "・合成）より ",
        math(String.raw`H(v) := v - \log(1+v)`),
        " は ",
        math(String.raw`[0,x]`),
        " 上微分可能で、",
      ]),
      displayMath(String.raw`\begin{aligned}
H'(v)
&= 1 - \log'(1+v)\cdot(0 + 1)
&&(\because\ \text{微分の公式の差・合成・和と、恒等関数の導関数}\ 1\text{、定数関数の導関数}\ 0)\\
&= 1 - \frac{1}{1+v}\cdot 1
&&(\because\ \text{微分の公式の }\log'(w) = \tfrac1w\text{。}1+v > 0)\\
&= 1 - \frac{1}{1+v}
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`H'`),
        " は微分可能な関数の差と商（分母 ",
        math(String.raw`1+v \neq 0`),
        "）なので微分可能、したがって連続である。さらに ",
        math(String.raw`v \in [0,x]`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
1 - \frac{1}{1+v}
&= \frac{(1+v) - 1}{1+v}
&&(\because\ \text{通分。}1+v \neq 0)\\
&= \frac{v}{1+v}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\geq 0
&&(\because\ v \geq 0\ \text{と}\ 1+v > 0)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
x - \log(1+x)
&= \left(x - \log(1+x)\right) - \left(0 - \log(1+0)\right)
&&(\because\ \text{準備の鎖より}\ 0 - \log(1+0) = 0)\\
&= \int_0^x\left(1 - \frac{1}{1+v}\right)dv
&&(\because\ \text{(R4) を}\ H\ \text{に})\\
&\geq \int_0^x 0\,dv
&&(\because\ \text{(R3) の単調性と、直前の鎖の各点の評価})\\
&= 0 - 0
&&(\because\ \text{(R4) を定数関数}\ 0\ \text{に。微分の公式で導関数は}\ 0)\\
&= 0
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\log(1+x)
&= x - \left(x - \log(1+x)\right)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\leq x - 0
&&(\because\ \text{直前の鎖})\\
&= x
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 closed_form_log_integral (2) の証明が括弧書きで示していた log(1+x) ≤ x を独立の主張にし、x = 0 の場合、H の微分可能性と導関数、被積分関数の符号を (∵) 付きの鎖にした。",
      ],
    },
  },

  {
    id: "critical_claim_arcsinh_argument_two_sided_bounds",
    kind: "claim",
    title: { tex: String.raw`2y \leq y + \sqrt{y^2+1} \leq 2y + \tfrac{1}{2y} \quad (y > 0)` },
    labels: ["arcsinh_argument_two_sided_bounds"],
    statement: [
      paragraph([
        "非負実数の平方根は ",
        ref("definition_of_sqrt_r_positive"),
        " を用いる。",
        math(String.raw`y \in \mathbb{R}_{>0}`),
        " なら",
      ]),
      displayMath(String.raw`2y \ \leq\ y + \sqrt{y^2+1} \ \leq\ 2y + \frac{1}{2y}`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、平方根の値が実数だからである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`s := \sqrt{y^2+1} \in \mathbb{R}_{\geq 0}`),
        " と置く。",
        ref("arcsinh_argument_is_positive"),
        " より ",
        math(String.raw`y + s > 0`),
        "、",
        ref("arcsinh_argument_times_conjugate_is_one"),
        " より ",
        math(String.raw`(y+s)(s-y) = 1`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
s - y
&= \frac{(y+s)(s-y)}{y+s}
&&(\because\ y + s \neq 0\ \text{で約分の逆})\\
&= \frac{1}{y+s}
&&(\because\ \blkref{arcsinh_argument_times_conjugate_is_one})
\end{aligned}`),
      paragraph(["下からの評価。"]),
      displayMath(String.raw`\begin{aligned}
y + s
&= 2y + (s - y)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= 2y + \frac{1}{y+s}
&&(\because\ \text{準備の鎖})\\
&\geq 2y
&&(\because\ y + s > 0\ \text{より}\ \tfrac{1}{y+s} > 0)
\end{aligned}`),
      paragraph([
        "上からの評価。下からの評価と ",
        math(String.raw`2y > 0`),
        " より ",
        math(String.raw`y + s \geq 2y > 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{y+s}
&= 2y\cdot\frac{1}{(y+s)\,2y}
&&(\because\ \mathbb{R}\ \text{の四則。}y+s \neq 0,\ 2y \neq 0)\\
&\leq (y+s)\cdot\frac{1}{(y+s)\,2y}
&&(\because\ 2y \leq y+s\ \text{の両辺に正の数}\ \tfrac{1}{(y+s)\,2y}\ \text{を掛ける})\\
&= \frac{1}{2y}
&&(\because\ \text{約分})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
y + s
&= 2y + (s - y)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= 2y + \frac{1}{y+s}
&&(\because\ \text{準備の鎖})\\
&\leq 2y + \frac{1}{2y}
&&(\because\ \tfrac{1}{y+s} \leq \tfrac{1}{2y})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 closed_form_log_integral (2) の証明の 2y ≤ y + √(y²+1) ≤ 2y + 1/(2y) を独立の主張にした。旧証明は √(y²+1) ≥ y と、(y + 1/(2y))² ≥ y²+1 から平方根の単調性で √(y²+1) ≤ y + 1/(2y) を出していたが、平方根の単調性を定めるブロックが本文に無い。" +
          "arcsinh_argument_times_conjugate_is_one の (y+s)(s-y) = 1 から s - y = 1/(y+s) を出し、両側をそこから示す形に改めた。",
      ],
    },
  },

  {
    id: "critical_claim_arcsinh_two_sided_log_bounds",
    kind: "claim",
    title: { tex: String.raw`\log(2y) \leq \mathrm{arcsinh}(y) \leq \log(2y) + \tfrac{1}{4y^2} \quad (y > 0)` },
    labels: ["arcsinh_two_sided_log_bounds"],
    statement: [
      paragraph([
        ref("def_arcsinh"),
        " の ",
        math(String.raw`\mathrm{arcsinh}`),
        " と ",
        ref("def_real_logarithm_positive"),
        " の ",
        math(String.raw`\log`),
        " について、",
        math(String.raw`y \in \mathbb{R}_{>0}`),
        " なら",
      ]),
      displayMath(String.raw`\log(2y) \ \leq\ \mathrm{arcsinh}(y) \ \leq\ \log(2y) + \frac{1}{4y^2}`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、実対数と平方根の値が実数だからである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`s := \sqrt{y^2+1} \in \mathbb{R}_{\geq 0}`),
        " と置く。",
        math(String.raw`2y > 0`),
        "、",
        math(String.raw`y + s > 0`),
        "（",
        ref("arcsinh_argument_is_positive"),
        "）、",
        math(String.raw`1 + \tfrac{1}{4y^2} > 0`),
        "、",
        math(String.raw`2y + \tfrac{1}{2y} > 0`),
        " なので、以下の ",
        math(String.raw`\log`),
        " の引数はどれも正である。",
      ]),
      paragraph(["下からの評価。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{arcsinh}(y)
&= \log(y + s)
&&(\because\ \blkref{def_arcsinh})\\
&\geq \log(2y)
&&(\because\ \blkref{arcsinh_argument_two_sided_bounds}\ \text{の}\ 2y \leq y+s\text{。}2y < y+s\ \text{なら}\ \blkref{real_log_strictly_increasing}\ \text{の}\ \log\ \text{の狭義単調増加、}2y = y+s\ \text{なら等号})
\end{aligned}`),
      paragraph(["上からの評価。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{arcsinh}(y)
&= \log(y + s)
&&(\because\ \blkref{def_arcsinh})\\
&\leq \log\left(2y + \frac{1}{2y}\right)
&&(\because\ \blkref{arcsinh_argument_two_sided_bounds}\ \text{の}\ y+s \leq 2y + \tfrac{1}{2y}\text{。狭義なら}\ \blkref{real_log_strictly_increasing}\ \text{の}\ \log\ \text{の狭義単調増加、等しければ等号})\\
&= \log\left(2y + 2y\cdot\frac{1}{4y^2}\right)
&&(\because\ \tfrac{1}{2y} = 2y\cdot\tfrac{1}{4y^2}\text{。}\mathbb{R}\ \text{の四則})\\
&= \log\left(2y\left(1 + \frac{1}{4y^2}\right)\right)
&&(\because\ \text{分配則})\\
&= \log(2y) + \log\left(1 + \frac{1}{4y^2}\right)
&&(\because\ \blkref{real_log_of_product})\\
&\leq \log(2y) + \frac{1}{4y^2}
&&(\because\ \blkref{log_one_plus_at_most_argument}\ \text{を}\ x = \tfrac{1}{4y^2} \geq 0\ \text{に})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 closed_form_log_integral (2) の前半を独立の主張にした。下からの評価が旧証明では書かれていなかったので鎖を足し、log の積の法則と log(1+x) ≤ x をラベル参照で引いた。",
      ],
    },
  },

  {
    id: "critical_009_claim_closed_form_log_integral",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}} = 2\,\mathrm{arcsinh}\!\left(\frac{\pi}{2\delta}\right)` },
    labels: ["closed_form_log_integral"],
    statement: [
      paragraph([
        "非負実数の平方根は ",
        ref("definition_of_sqrt_r_positive"),
        " を、",
        math(String.raw`\mathrm{arcsinh}`),
        " は ",
        ref("def_arcsinh"),
        " を用いる。",
        math(String.raw`\delta \in \mathbb{R}_{>0}`),
        " なら",
      ]),
      displayMath(String.raw`\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2 + \theta^2/4}}
   = 2\,\mathrm{arcsinh}\!\left(\frac{\pi}{2\delta}\right)`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、区間 ",
        math(String.raw`[0,\pi]`),
        " 上の積分と微分を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R4) と微分の公式）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\theta \in [0,\pi]`),
        " について ",
        math(String.raw`q(\theta) := \dfrac{\theta}{2\delta} \in \mathbb{R}`),
        "、",
        math(String.raw`F(\theta) := 2\,\mathrm{arcsinh}(q(\theta)) \in \mathbb{R}`),
        "、",
        math(String.raw`W(\theta) := \sqrt{\delta^2 + \theta^2/4} \in \mathbb{R}_{\geq 0}`),
        " と置く。",
        math(String.raw`\delta^2 + \theta^2/4 \geq \delta^2 > 0`),
        " と ",
        math(String.raw`W(\theta)^2 = \delta^2 + \theta^2/4`),
        " より ",
        math(String.raw`W(\theta) \neq 0`),
        "、したがって ",
        math(String.raw`W(\theta) > 0`),
        " である。",
        math(String.raw`\tfrac{W(\theta)}{\delta} \geq 0`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\frac{W(\theta)}{\delta}\right)^2
&= \frac{W(\theta)^2}{\delta^2}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \frac{\delta^2 + \theta^2/4}{\delta^2}
&&(\because\ \blkref{definition_of_sqrt_r_positive})\\
&= \left(\frac{\theta}{2\delta}\right)^2 + 1
&&(\because\ \mathbb{R}\ \text{の四則。}\delta \neq 0)\\
&= q(\theta)^2 + 1
&&(\because\ q\ \text{の置き方})
\end{aligned}`),
      paragraph([
        "なので、",
        ref("sqrt_nonnegative_existence_uniqueness"),
        " の一意性より ",
        math(String.raw`\sqrt{q(\theta)^2+1} = \tfrac{W(\theta)}{\delta}`),
        " である。",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式（定数倍と恒等関数）より ",
        math(String.raw`q`),
        " は微分可能で ",
        math(String.raw`q'(\theta) = \tfrac{1}{2\delta}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
F'(\theta)
&= 2\,\mathrm{arcsinh}'(q(\theta))\,q'(\theta)
&&(\because\ \text{微分の公式の定数倍と合成。}\blkref{arcsinh_derivative}\ \text{より}\ \mathrm{arcsinh}\ \text{は微分可能})\\
&= 2\cdot\frac{1}{\sqrt{q(\theta)^2+1}}\cdot q'(\theta)
&&(\because\ \blkref{arcsinh_derivative})\\
&= 2\cdot\frac{1}{\sqrt{q(\theta)^2+1}}\cdot\frac{1}{2\delta}
&&(\because\ q'(\theta) = \tfrac{1}{2\delta})\\
&= 2\cdot\frac{1}{W(\theta)/\delta}\cdot\frac{1}{2\delta}
&&(\because\ \sqrt{q(\theta)^2+1} = \tfrac{W(\theta)}{\delta})\\
&= 2\cdot\frac{\delta}{W(\theta)}\cdot\frac{1}{2\delta}
&&(\because\ \mathbb{R}\ \text{の四則。}W(\theta) \neq 0)\\
&= \frac{1}{W(\theta)}
&&(\because\ \text{約分})
\end{aligned}`),
      paragraph([
        math(String.raw`W`),
        " は平方根と ",
        math(String.raw`\mathbb{R}_{>0}`),
        " に値をとる微分可能な関数 ",
        math(String.raw`\theta \mapsto \delta^2 + \theta^2/4`),
        " の合成なので微分可能で、",
        math(String.raw`F' = \tfrac{1}{W}`),
        " は分母が 0 でない商なので微分可能、したがって連続である（微分の公式）。",
      ]),
      displayMath(String.raw`\begin{aligned}
F(0)
&= 2\,\mathrm{arcsinh}(0)
&&(\because\ q(0) = 0)\\
&= 2\log\left(0 + \sqrt{0^2+1}\right)
&&(\because\ \blkref{def_arcsinh})\\
&= 2\log\left(\sqrt{1}\right)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= 2\log 1
&&(\because\ \blkref{sqrt_of_real_one_is_one})\\
&= 2\log(\exp 0)
&&(\because\ \blkref{scalar_exp_zero})\\
&= 2\cdot 0
&&(\because\ \blkref{def_real_logarithm_positive}\ \text{の }\log(\exp x) = x)\\
&= 0
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}}
&= \int_0^{\pi}F'(\theta)\,d\theta
&&(\because\ W\ \text{の置き方と}\ F'(\theta) = \tfrac{1}{W(\theta)})\\
&= F(\pi) - F(0)
&&(\because\ \text{(R4) を}\ F\ \text{に})\\
&= 2\,\mathrm{arcsinh}\!\left(\frac{\pi}{2\delta}\right) - F(0)
&&(\because\ F\ \text{と}\ q\ \text{の置き方})\\
&= 2\,\mathrm{arcsinh}\!\left(\frac{\pi}{2\delta}\right) - 0
&&(\because\ F(0) = 0)\\
&= 2\,\mathrm{arcsinh}\!\left(\frac{\pi}{2\delta}\right)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 closed_form_log_integral は (1) の閉じた形、(2) の arcsinh と積分の log 評価、(3) の 3/2 乗の積分の評価を束ねていたので、1 ブロック 1 主張に分け、このブロックには (1) だけを残した。" +
          "旧証明の √((θ²+4δ²)/(4δ²)) = √(θ²+4δ²)/(2δ) は平方根の商の規則を定めるブロックが本文に無いので、平方根の一意性から √(q²+1) = W/δ を示す形に改め、F(0) = 0 と F' の連続性を書いた。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: F(0) の鎖の √1 = 1 の行の名前だけの根拠を sqrt_of_real_one_is_one の参照にし、準備の文の「同じ一意性と 1 ≥ 0、1^2 = 1 より √1 = 1」を消した（その主張が担う）。値と主張は不変。",
      ],
    },
  },

  {
    id: "critical_claim_log_integral_two_sided_bounds",
    kind: "claim",
    title: { tex: String.raw`2\log\frac{\pi}{\delta} \leq \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}} \leq 2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2}` },
    labels: ["log_integral_two_sided_bounds"],
    statement: [
      paragraph([
        "非負実数の平方根は ",
        ref("definition_of_sqrt_r_positive"),
        " を、",
        math(String.raw`\log`),
        " は ",
        ref("def_real_logarithm_positive"),
        " を用いる。",
        math(String.raw`\delta \in \mathbb{R}_{>0}`),
        " なら",
      ]),
      displayMath(String.raw`2\log\frac{\pi}{\delta} \ \leq\ \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}}
   \ \leq\ 2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2}`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、区間 ",
        math(String.raw`[0,\pi]`),
        " 上の積分と実対数を使うからである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("remark_real_analysis_facts_R3_R4"),
        " の円周率の数値の評価より ",
        math(String.raw`\pi \geq 3.141592 > 0`),
        " である。",
        math(String.raw`y := \dfrac{\pi}{2\delta} \in \mathbb{R}_{>0}`),
        " と置くと、",
        math(String.raw`\mathbb{R}`),
        " の四則より ",
        math(String.raw`2y = \dfrac{\pi}{\delta}`),
        "、",
        math(String.raw`\dfrac{1}{4y^2} = \dfrac{\delta^2}{\pi^2}`),
        " である。",
      ]),
      paragraph(["下からの評価。"]),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}}
&= 2\,\mathrm{arcsinh}(y)
&&(\because\ \blkref{closed_form_log_integral}\ \text{と}\ y\ \text{の置き方})\\
&\geq 2\log(2y)
&&(\because\ \blkref{arcsinh_two_sided_log_bounds}\ \text{の下からの評価に}\ 2 > 0\ \text{を掛ける})\\
&= 2\log\frac{\pi}{\delta}
&&(\because\ 2y = \tfrac{\pi}{\delta})
\end{aligned}`),
      paragraph(["上からの評価。"]),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}}
&= 2\,\mathrm{arcsinh}(y)
&&(\because\ \blkref{closed_form_log_integral}\ \text{と}\ y\ \text{の置き方})\\
&\leq 2\left(\log(2y) + \frac{1}{4y^2}\right)
&&(\because\ \blkref{arcsinh_two_sided_log_bounds}\ \text{の上からの評価に}\ 2 > 0\ \text{を掛ける})\\
&= 2\left(\log\frac{\pi}{\delta} + \frac{\delta^2}{\pi^2}\right)
&&(\because\ 2y = \tfrac{\pi}{\delta},\ \tfrac{1}{4y^2} = \tfrac{\delta^2}{\pi^2})\\
&= 2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2}
&&(\because\ \text{分配則})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 closed_form_log_integral (2) の後半（「とくに (1) と合わせて」の積分の評価）を独立の主張にし、代入と 2 倍を (∵) 付きの鎖にした。",
      ],
    },
  },

  {
    id: "critical_definition_three_halves_power",
    kind: "definition",
    title: { tex: String.raw`w^{3/2} := w\sqrt{w}` },
    labels: ["def_three_halves_power"],
    statement: [
      paragraph([
        math(String.raw`w \in \mathbb{R}_{>0}`),
        " について、",
        ref("definition_of_sqrt_r_positive"),
        " の平方根を使い",
      ]),
      displayMath(String.raw`w^{3/2} := w\sqrt{w} \in \mathbb{R}_{>0}`),
      paragraph([
        "と定める。値が正であるのは、",
        math(String.raw`\sqrt{w} \geq 0`),
        " と ",
        math(String.raw`(\sqrt{w})^2 = w > 0`),
        " より ",
        math(String.raw`\sqrt{w} > 0`),
        " であり、正の数の積は正だからである。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、平方根の値が実数だからである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 closed_form_log_integral (3) が定義なしで使っていた 3/2 乗を定義として置いた。second_derivative_log_divergence の Step 5 の 3/2 乗もこの定義を引く。",
      ],
    },
  },

  {
    id: "critical_claim_three_halves_power_integral_bound",
    kind: "claim",
    title: { tex: String.raw`\int_0^{\pi}\frac{d\theta}{\left(\delta^2 + a^2\theta^2/4\right)^{3/2}} \leq \frac{2}{a\,\delta^2}` },
    labels: ["three_halves_power_integral_bound"],
    statement: [
      paragraph([
        ref("def_three_halves_power"),
        " の 3/2 乗について、",
        math(String.raw`\delta, a \in \mathbb{R}_{>0}`),
        " なら",
      ]),
      displayMath(String.raw`\int_0^{\pi}\frac{d\theta}{\left(\delta^2 + a^2\theta^2/4\right)^{3/2}} \ \leq\ \frac{2}{a\,\delta^2}`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは、区間 ",
        math(String.raw`[0,\pi]`),
        " 上の積分と微分を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R4) と微分の公式）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\theta \in [0,\pi]`),
        " について ",
        math(String.raw`w(\theta) := \delta^2 + a^2\theta^2/4`),
        "、",
        math(String.raw`r(\theta) := \sqrt{w(\theta)}`),
        "、",
        math(String.raw`G(\theta) := \dfrac{\theta}{\delta^2\,r(\theta)}`),
        " と置く。",
        math(String.raw`w(\theta) \geq \delta^2 > 0`),
        " なので、",
        ref("def_three_halves_power"),
        " と同じ理由で ",
        math(String.raw`r(\theta) > 0`),
        " であり、",
        math(String.raw`r(\theta)^2 = w(\theta)`),
        "（",
        ref("definition_of_sqrt_r_positive"),
        "）である。",
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式（定数倍・積・和・平方根・合成・商）より ",
        math(String.raw`w, r, G`),
        " は微分可能で、",
      ]),
      displayMath(String.raw`\begin{aligned}
w'(\theta)
&= 0 + \frac{a^2}{4}\,(1\cdot\theta + \theta\cdot 1)
&&(\because\ \text{微分の公式の和・定数倍・積と、定数関数の導関数}\ 0\text{、恒等関数の導関数}\ 1)\\
&= \frac{a^2\theta}{2}
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
r'(\theta)
&= \frac{1}{2\sqrt{w(\theta)}}\,w'(\theta)
&&(\because\ \text{微分の公式の平方根と合成。}w(\theta) > 0)\\
&= \frac{1}{2\,r(\theta)}\cdot\frac{a^2\theta}{2}
&&(\because\ r\ \text{の置き方と}\ w'(\theta) = \tfrac{a^2\theta}{2})\\
&= \frac{a^2\theta}{4\,r(\theta)}
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
G'(\theta)
&= \frac{1\cdot\delta^2 r(\theta) - \theta\cdot\delta^2 r'(\theta)}{\left(\delta^2 r(\theta)\right)^2}
&&(\because\ \text{微分の公式の商と定数倍。}\delta^2 r(\theta) \neq 0)\\
&= \frac{\delta^2 r(\theta) - \theta\cdot\delta^2\,\dfrac{a^2\theta}{4\,r(\theta)}}{\left(\delta^2 r(\theta)\right)^2}
&&(\because\ r'(\theta) = \tfrac{a^2\theta}{4 r(\theta)})\\
&= \frac{\delta^2 r(\theta) - \delta^2\,\dfrac{a^2\theta^2}{4\,r(\theta)}}{\delta^4\,r(\theta)^2}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \frac{\delta^2 r(\theta)^2 - \delta^2\,\dfrac{a^2\theta^2}{4}}{\delta^4\,r(\theta)^3}
&&(\because\ \text{分子と分母に}\ r(\theta)\ \text{を掛ける})\\
&= \frac{\delta^2\left(r(\theta)^2 - \dfrac{a^2\theta^2}{4}\right)}{\delta^4\,r(\theta)^3}
&&(\because\ \text{分配則})\\
&= \frac{\delta^2\cdot\delta^2}{\delta^4\,r(\theta)^3}
&&(\because\ r(\theta)^2 = w(\theta) = \delta^2 + \tfrac{a^2\theta^2}{4})\\
&= \frac{1}{r(\theta)^2\,r(\theta)}
&&(\because\ \text{約分})\\
&= \frac{1}{w(\theta)\sqrt{w(\theta)}}
&&(\because\ r(\theta)^2 = w(\theta)\ \text{と}\ r\ \text{の置き方})\\
&= \frac{1}{w(\theta)^{3/2}}
&&(\because\ \blkref{def_three_halves_power})
\end{aligned}`),
      paragraph([
        math(String.raw`G'`),
        " は分母が 0 でない微分可能な関数の商なので微分可能、したがって連続である（微分の公式）。",
        ref("remark_real_analysis_facts_R3_R4"),
        " の円周率の数値の評価より ",
        math(String.raw`\pi > 0`),
        "、したがって ",
        math(String.raw`\tfrac{a\pi}{2} > 0`),
        " である。",
        math(String.raw`r(\pi) \leq \tfrac{a\pi}{2}`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
r(\pi)^2
&= r(\pi)\cdot r(\pi)\\
&\leq \frac{a\pi}{2}\cdot r(\pi)
&&(\because\ \text{仮定の両辺に}\ r(\pi) > 0\ \text{を掛ける})\\
&\leq \frac{a\pi}{2}\cdot\frac{a\pi}{2}
&&(\because\ \text{仮定の両辺に}\ \tfrac{a\pi}{2} > 0\ \text{を掛ける})\\
&= \frac{a^2\pi^2}{4}\\
&< \delta^2 + \frac{a^2\pi^2}{4}
&&(\because\ \delta^2 > 0)\\
&= r(\pi)^2
&&(\because\ r(\pi)^2 = w(\pi))
\end{aligned}`),
      paragraph([
        "となり矛盾する。よって ",
        math(String.raw`r(\pi) > \tfrac{a\pi}{2} > 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{r(\pi)}
&= \frac{a\pi}{2}\cdot\frac{2}{a\pi\,r(\pi)}
&&(\because\ \mathbb{R}\ \text{の四則。}a\pi \neq 0,\ r(\pi) \neq 0)\\
&\leq r(\pi)\cdot\frac{2}{a\pi\,r(\pi)}
&&(\because\ \tfrac{a\pi}{2} < r(\pi)\ \text{の両辺に正の数}\ \tfrac{2}{a\pi\,r(\pi)}\ \text{を掛ける})\\
&= \frac{2}{a\pi}
&&(\because\ \text{約分})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\frac{d\theta}{\left(\delta^2+a^2\theta^2/4\right)^{3/2}}
&= \int_0^{\pi}G'(\theta)\,d\theta
&&(\because\ w\ \text{の置き方と}\ G'(\theta) = \tfrac{1}{w(\theta)^{3/2}})\\
&= G(\pi) - G(0)
&&(\because\ \text{(R4) を}\ G\ \text{に})\\
&= \frac{\pi}{\delta^2\,r(\pi)} - \frac{0}{\delta^2\,r(0)}
&&(\because\ G\ \text{の置き方})\\
&= \frac{\pi}{\delta^2}\cdot\frac{1}{r(\pi)}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\leq \frac{\pi}{\delta^2}\cdot\frac{2}{a\pi}
&&(\because\ \tfrac{1}{r(\pi)} \leq \tfrac{2}{a\pi}\ \text{の両辺に}\ \tfrac{\pi}{\delta^2} > 0\ \text{を掛ける})\\
&= \frac{2}{a\,\delta^2}
&&(\because\ \text{約分})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 旧 closed_form_log_integral (3) を独立の主張にした。3/2 乗を def_three_halves_power で定め、G' の計算を w'・r' の鎖と 1 行 1 操作の鎖に分け、√(δ² + a²π²/4) ≥ aπ/2 を平方根の単調性ではなく背理法の鎖で示した。",
      ],
    },
  },

  {
    id: "critical_claim_nonnegative_real_order_from_squares",
    kind: "claim",
    title: { tex: String.raw`u^2 \leq v^2 \Longrightarrow u \leq v \quad (u, v \in \mathbb{R}_{\geq 0})` },
    labels: ["nonnegative_real_order_from_squares"],
    statement: [
      paragraph([
        math(String.raw`u, v \in \mathbb{R}_{\geq 0}`),
        " が ",
        math(String.raw`u^2 \leq v^2`),
        " を満たすならば ",
        math(String.raw`u \leq v`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`v < u`),
        " と仮定する。",
        math(String.raw`0 \leq v < u`),
        " なので ",
        math(String.raw`u > 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
v^2
&= v\cdot v\\
&\leq v\cdot u
&&(\because\ \text{仮定}\ v < u\ \text{の両辺に}\ v \geq 0\ \text{を掛ける})\\
&< u\cdot u
&&(\because\ \text{仮定}\ v < u\ \text{の両辺に}\ u > 0\ \text{を掛ける})\\
&= u^2
\end{aligned}`),
      paragraph([
        "となり、",
        math(String.raw`u^2 \leq v^2`),
        " に矛盾する。よって ",
        math(String.raw`u \leq v`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: sine_integral_two_sided の証明が平方根どうしの大小（D_2 ≤ D_1、D_1 ≥ p、D_2 ≥ c_0 p、D_1, D_2 ≥ δ）を本文に無い平方根の単調性で済ませていたので、その根拠として足した。",
      ],
    },
  },

  {
    id: "critical_definition_sine_integral_constant",
    kind: "definition",
    title: { tex: String.raw`B := \tfrac{\pi^2}{12\,c_0(1+c_0)}` },
    labels: ["def_sine_integral_constant"],
    statement: [
      paragraph([
        ref("def_sine_bound_constant"),
        " の ",
        math(String.raw`c_0`),
        " を用いて",
      ]),
      displayMath(String.raw`B := \frac{\pi^2}{12\,c_0\left(1+c_0\right)} \in \mathbb{R}`),
      paragraph([
        "と定める。",
        ref("sine_bound_constant_numerical_bounds"),
        " より ",
        math(String.raw`c_0 \geq 0.5887 > 0`),
        "、したがって ",
        math(String.raw`1 + c_0 > 0`),
        " で、分母 ",
        math(String.raw`12\,c_0(1+c_0)`),
        " は正の実数の積なので 0 でない。",
        math(String.raw`\mathbb{R}`),
        " を使うのは ",
        math(String.raw`\pi`),
        " が実数だからである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: sine_integral_two_sided の主張の中で置いていた B を独立の定義にし、分母が 0 でないことを書いた。",
      ],
    },
  },

  {
    id: "critical_claim_sine_integral_constant_numerical_bound",
    kind: "claim",
    title: { tex: String.raw`B \leq 0.88` },
    labels: ["sine_integral_constant_numerical_bound"],
    statement: [
      paragraph([
        ref("def_sine_integral_constant"),
        " の ",
        math(String.raw`B`),
        " について ",
        math(String.raw`B \leq 0.88`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("sine_bound_constant_numerical_bounds"),
        " の ",
        math(String.raw`c_0 \geq 0.5887`),
        " の両辺に ",
        math(String.raw`1`),
        " を足して ",
        math(String.raw`1 + c_0 \geq 1.5887 > 0`),
        " である。これらから次を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
12\,c_0\left(1+c_0\right)
&\geq 12\cdot 0.5887\cdot\left(1+c_0\right)
&&(\because\ c_0 \geq 0.5887\ \text{の両辺に}\ 12\left(1+c_0\right) > 0\ \text{を掛ける})\\
&\geq 12\cdot 0.5887\cdot 1.5887
&&(\because\ 1 + c_0 \geq 1.5887\ \text{の両辺に}\ 12\cdot 0.5887 > 0\ \text{を掛ける})\\
&= 11.22321228
&&(\because\ \mathbb{Q}\ \text{の四則})\\
&\geq 11.22
&&(\because\ \mathbb{Q}\ \text{の大小比較})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\frac{1}{12\,c_0\left(1+c_0\right)}
&= \frac{11.22}{12\,c_0\left(1+c_0\right)}\cdot\frac{1}{11.22}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\leq \frac{12\,c_0\left(1+c_0\right)}{12\,c_0\left(1+c_0\right)}\cdot\frac{1}{11.22}
&&(\because\ 11.22 \leq 12\,c_0(1+c_0)\ \text{の両辺に}\ \tfrac{1}{12c_0(1+c_0)\cdot 11.22} > 0\ \text{を掛ける})\\
&= \frac{1}{11.22}
&&(\because\ \text{約分})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
B
&= \frac{\pi^2}{12\,c_0\left(1+c_0\right)}
&&(\because\ \blkref{def_sine_integral_constant})\\
&\leq \frac{9.8697}{12\,c_0\left(1+c_0\right)}
&&(\because\ \blkref{pi_squared_numerical_bounds}\ \text{の}\ \pi^2 \leq 9.8697\ \text{の両辺を}\ 12\,c_0(1+c_0) > 0\ \text{で割る})\\
&\leq \frac{9.8697}{11.22}
&&(\because\ \text{準備の}\ \tfrac{1}{12c_0(1+c_0)} \leq \tfrac{1}{11.22}\ \text{の両辺に}\ 9.8697 > 0\ \text{を掛ける})\\
&= \frac{98697}{112200}
&&(\because\ \mathbb{Q}\ \text{の四則})\\
&\leq \frac{98736}{112200}
&&(\because\ 98697 \leq 98736\ \text{の両辺を}\ 112200 > 0\ \text{で割る})\\
&= 0.88
&&(\because\ \mathbb{Q}\ \text{の四則。}0.88\cdot 112200 = 98736)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: sine_integral_two_sided の主張の括弧書きと証明の末尾にあった B の数値評価を独立の主張にし、積の評価と割り算の評価を 1 行 1 操作の鎖にした。",
      ],
    },
  },

  {
    id: "critical_010_claim_sine_integral_two_sided",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`2\log\frac{\pi}{\delta} \leq \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\sin^2(\theta/2)}} \leq 2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2} + B` },
    labels: ["sine_integral_two_sided"],
    statement: [
      paragraph([
        "平方根は ",
        ref("definition_of_sqrt_r_positive"),
        "、正弦は ",
        ref("def_sin"),
        "、",
        math(String.raw`\log`),
        " は ",
        ref("def_real_logarithm_positive"),
        "、",
        math(String.raw`B`),
        " は ",
        ref("def_sine_integral_constant"),
        " のものを用いる。",
        math(String.raw`\delta \in \mathbb{R}_{>0}`),
        " なら",
      ]),
      displayMath(
        String.raw`2\log\frac{\pi}{\delta}
\ \leq\ \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\sin^2\!\left(\frac{\theta}{2}\right)}}
\ \leq\ 2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2} + B`,
      ),
      paragraph([
        math(String.raw`\theta \in [0,\pi]`),
        " なら ",
        math(String.raw`\tfrac{\theta}{2} \in [0,\tfrac{\pi}{2}]`),
        " なので ",
        math(String.raw`\sin\tfrac{\theta}{2}`),
        " は定まり、平方根の中身は ",
        math(String.raw`\delta^2 > 0`),
        " 以上なので平方根も定まる。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、区間 ",
        math(String.raw`[0,\pi]`),
        " 上の積分と実対数を使うからである（",
        ref("remark_real_analysis_facts_R3_R4"),
        " の (R3)(R4) と微分の公式）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("remark_real_analysis_facts_R3_R4"),
        " の円周率の数値の評価より ",
        math(String.raw`\pi > 0`),
        "、",
        ref("sine_bound_constant_numerical_bounds"),
        " より ",
        math(String.raw`c_0 \geq 0.5887 > 0`),
        " である。",
        math(String.raw`\theta \in [0,\pi]`),
        " について ",
        math(String.raw`p := \tfrac{\theta}{2} \in [0,\tfrac{\pi}{2}]`),
        "、",
        math(String.raw`s := \sin p`),
        "、",
        math(String.raw`D_1 := \sqrt{\delta^2+p^2}`),
        "、",
        math(String.raw`D_2 := \sqrt{\delta^2+s^2}`),
        " と置く（",
        math(String.raw`p, s, D_1, D_2`),
        " は ",
        math(String.raw`\theta`),
        " の関数で、値は ",
        math(String.raw`\mathbb{R}`),
        " の元）。",
        ref("sine_half_angle_linear_bounds"),
        " より ",
        math(String.raw`c_0 p \leq s \leq p`),
        "、",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`D_1, D_2 \geq 0`),
        "、",
        math(String.raw`D_1^2 = \delta^2+p^2`),
        "、",
        math(String.raw`D_2^2 = \delta^2+s^2`),
        " である。また ",
        math(String.raw`p^2 = \tfrac{\theta^2}{4}`),
        " なので ",
        math(String.raw`D_1 = \sqrt{\delta^2+\theta^2/4}`),
        " である。",
      ]),
      displayMath(String.raw`0 \leq c_0 p \leq s
\qquad (\because\ c_0 > 0,\ p \geq 0\ \text{より}\ c_0 p \geq 0\text{。}\blkref{sine_half_angle_linear_bounds})`),
      displayMath(String.raw`\delta^2 \leq \delta^2 + p^2 = D_1^2,\quad \delta^2 \leq \delta^2 + s^2 = D_2^2
\qquad (\because\ p^2, s^2 \geq 0)`),
      displayMath(String.raw`0 < \delta \leq D_1,\quad 0 < \delta \leq D_2
\qquad (\because\ \blkref{nonnegative_real_order_from_squares}\ \text{を}\ (u,v) = (\delta, D_1), (\delta, D_2)\ \text{に})`),
      paragraph([
        ref("remark_real_analysis_facts_R3_R4"),
        " の微分の公式（定数関数・恒等関数・定数倍・積・和・平方根・合成・商）と正弦の導関数より、",
        math(String.raw`\theta \mapsto \tfrac{1}{D_1}`),
        "、",
        math(String.raw`\theta \mapsto \tfrac{1}{D_2}`),
        " は ",
        math(String.raw`[0,\pi]`),
        " 上微分可能（平方根の中身は ",
        math(String.raw`\delta^2 > 0`),
        " 以上、分母は ",
        math(String.raw`\delta > 0`),
        " 以上）、したがって連続であり、その差も連続である。",
      ]),
      paragraph(["各点の大小。"]),
      displayMath(String.raw`\begin{aligned}
s^2
&= s\cdot s\\
&\leq s\cdot p
&&(\because\ s \leq p\ \text{の両辺に}\ s \geq 0\ \text{を掛ける})\\
&\leq p\cdot p
&&(\because\ s \leq p\ \text{の両辺に}\ p \geq 0\ \text{を掛ける})\\
&= p^2
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
D_2^2
&= \delta^2 + s^2
&&(\because\ \blkref{definition_of_sqrt_r_positive})\\
&\leq \delta^2 + p^2
&&(\because\ s^2 \leq p^2\ \text{の両辺に}\ \delta^2\ \text{を足す})\\
&= D_1^2
&&(\because\ \blkref{definition_of_sqrt_r_positive})
\end{aligned}`),
      displayMath(String.raw`D_2 \leq D_1
\qquad (\because\ \blkref{nonnegative_real_order_from_squares}\ \text{を}\ (u,v) = (D_2, D_1)\ \text{に})`),
      displayMath(String.raw`\begin{aligned}
\frac{1}{D_1}
&= D_2\cdot\frac{1}{D_1D_2}
&&(\because\ \mathbb{R}\ \text{の四則。}D_1D_2 \neq 0)\\
&\leq D_1\cdot\frac{1}{D_1D_2}
&&(\because\ D_2 \leq D_1\ \text{の両辺に}\ \tfrac{1}{D_1D_2} > 0\ \text{を掛ける})\\
&= \frac{1}{D_2}
&&(\because\ \text{約分})
\end{aligned}`),
      paragraph(["下からの評価。"]),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\sin^2(\theta/2)}}
&= \int_0^{\pi}\frac{d\theta}{D_2}
&&(\because\ p, s, D_2\ \text{の置き方})\\
&\geq \int_0^{\pi}\frac{d\theta}{D_1}
&&(\because\ \text{(R3) の単調性と、各点で}\ \tfrac{1}{D_1} \leq \tfrac{1}{D_2})\\
&= \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}}
&&(\because\ D_1 = \sqrt{\delta^2+\theta^2/4})\\
&\geq 2\log\frac{\pi}{\delta}
&&(\because\ \blkref{log_integral_two_sided_bounds}\ \text{の下からの評価})
\end{aligned}`),
      paragraph([
        "差の各点評価の準備。",
        math(String.raw`\theta^3 = (2p)^3 = 8p^3`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
p - s
&= \frac{\theta}{2} - \sin\frac{\theta}{2}
&&(\because\ p, s\ \text{の置き方})\\
&\leq \frac{\theta^3}{48}
&&(\because\ \blkref{elementary_sine_bounds})\\
&= \frac{p^3}{6}
&&(\because\ \theta^3 = 8p^3\ \text{と}\ \mathbb{Q}\ \text{の四則})
\end{aligned}`),
      displayMath(String.raw`0 \leq p + s \leq p + p = 2p
\qquad (\because\ 0 \leq s \leq p)`),
      displayMath(String.raw`p \leq D_1
\qquad (\because\ p^2 \leq \delta^2 + p^2 = D_1^2\ \text{と}\ \blkref{nonnegative_real_order_from_squares}\ \text{を}\ (u,v) = (p, D_1)\ \text{に})`),
      displayMath(String.raw`\begin{aligned}
\left(c_0p\right)^2
&= c_0p\cdot c_0p\\
&\leq c_0p\cdot s
&&(\because\ c_0p \leq s\ \text{の両辺に}\ c_0p \geq 0\ \text{を掛ける})\\
&\leq s\cdot s
&&(\because\ c_0p \leq s\ \text{の両辺に}\ s \geq 0\ \text{を掛ける})\\
&\leq \delta^2 + s^2
&&(\because\ \delta^2 \geq 0)\\
&= D_2^2
&&(\because\ \blkref{definition_of_sqrt_r_positive})
\end{aligned}`),
      displayMath(String.raw`c_0p \leq D_2
\qquad (\because\ \blkref{nonnegative_real_order_from_squares}\ \text{を}\ (u,v) = (c_0p, D_2)\ \text{に})`),
      displayMath(String.raw`p + c_0p \leq D_1 + D_2
\qquad (\because\ p \leq D_1\ \text{と}\ c_0p \leq D_2\ \text{を辺ごとに足す})`),
      displayMath(String.raw`\begin{aligned}
D_1D_2\left(D_1+D_2\right)
&\geq p\cdot D_2\left(D_1+D_2\right)
&&(\because\ p \leq D_1\ \text{の両辺に}\ D_2(D_1+D_2) > 0\ \text{を掛ける})\\
&\geq p\cdot c_0p\cdot\left(D_1+D_2\right)
&&(\because\ c_0p \leq D_2\ \text{の両辺に}\ p(D_1+D_2) \geq 0\ \text{を掛ける})\\
&\geq p\cdot c_0p\cdot\left(p + c_0p\right)
&&(\because\ p + c_0p \leq D_1 + D_2\ \text{の両辺に}\ p\cdot c_0p \geq 0\ \text{を掛ける})\\
&= c_0\left(1+c_0\right)p^3
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`),
      paragraph([
        "差の各点評価。",
        math(String.raw`p > 0`),
        " のとき、",
        math(String.raw`c_0(1+c_0)p^3 > 0`),
        " なので、分母の逆数の評価",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{D_1D_2\left(D_1+D_2\right)}
&= \frac{c_0\left(1+c_0\right)p^3}{D_1D_2\left(D_1+D_2\right)}\cdot\frac{1}{c_0\left(1+c_0\right)p^3}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\leq \frac{D_1D_2\left(D_1+D_2\right)}{D_1D_2\left(D_1+D_2\right)}\cdot\frac{1}{c_0\left(1+c_0\right)p^3}
&&(\because\ c_0(1+c_0)p^3 \leq D_1D_2(D_1+D_2)\ \text{の両辺に}\ \tfrac{1}{D_1D_2(D_1+D_2)\,c_0(1+c_0)p^3} > 0\ \text{を掛ける})\\
&= \frac{1}{c_0\left(1+c_0\right)p^3}
&&(\because\ \text{約分})
\end{aligned}`),
      paragraph(["を使って"]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{D_2} - \frac{1}{D_1}
&= \frac{D_1 - D_2}{D_1D_2}
&&(\because\ \mathbb{R}\ \text{の四則。}D_1D_2 \neq 0)\\
&= \frac{\left(D_1 - D_2\right)\left(D_1+D_2\right)}{D_1D_2\left(D_1+D_2\right)}
&&(\because\ \text{分子と分母に}\ D_1+D_2 > 0\ \text{を掛ける})\\
&= \frac{D_1^2 - D_2^2}{D_1D_2\left(D_1+D_2\right)}
&&(\because\ \text{分配則})\\
&= \frac{\left(\delta^2+p^2\right) - \left(\delta^2+s^2\right)}{D_1D_2\left(D_1+D_2\right)}
&&(\because\ \blkref{definition_of_sqrt_r_positive})\\
&= \frac{p^2 - s^2}{D_1D_2\left(D_1+D_2\right)}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \frac{\left(p-s\right)\left(p+s\right)}{D_1D_2\left(D_1+D_2\right)}
&&(\because\ \text{分配則})\\
&\leq \frac{\frac{p^3}{6}\left(p+s\right)}{D_1D_2\left(D_1+D_2\right)}
&&(\because\ p - s \leq \tfrac{p^3}{6}\ \text{の両辺に}\ \tfrac{p+s}{D_1D_2(D_1+D_2)} \geq 0\ \text{を掛ける})\\
&\leq \frac{\frac{p^3}{6}\cdot 2p}{D_1D_2\left(D_1+D_2\right)}
&&(\because\ p + s \leq 2p\ \text{の両辺に}\ \tfrac{p^3/6}{D_1D_2(D_1+D_2)} \geq 0\ \text{を掛ける})\\
&= \frac{p^4}{3}\cdot\frac{1}{D_1D_2\left(D_1+D_2\right)}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&\leq \frac{p^4}{3}\cdot\frac{1}{c_0\left(1+c_0\right)p^3}
&&(\because\ \text{分母の逆数の評価の両辺に}\ \tfrac{p^4}{3} \geq 0\ \text{を掛ける})\\
&= \frac{p}{3c_0\left(1+c_0\right)}
&&(\because\ \text{約分。}p \neq 0)\\
&= \frac{\theta}{6c_0\left(1+c_0\right)}
&&(\because\ p = \tfrac{\theta}{2})
\end{aligned}`),
      paragraph([
        math(String.raw`p = 0`),
        " のとき、",
        ref("sine_zero"),
        " より ",
        math(String.raw`s = \sin 0 = 0 = p`),
        " なので ",
        math(String.raw`D_2 = D_1`),
        " で、",
        math(String.raw`\theta = 2p = 0`),
        " なので",
      ]),
      displayMath(String.raw`\frac{1}{D_2} - \frac{1}{D_1} = 0 = \frac{\theta}{6c_0\left(1+c_0\right)}
\qquad (\because\ D_2 = D_1,\ \theta = 0)`),
      paragraph([
        "したがって ",
        math(String.raw`[0,\pi]`),
        " の各点で ",
        math(String.raw`\tfrac{1}{D_2} - \tfrac{1}{D_1} \leq \tfrac{\theta}{6c_0(1+c_0)}`),
        " である。",
        math(String.raw`F(\theta) := \tfrac{\theta^2}{2}`),
        " は微分の公式（定数倍・積・恒等関数）より微分可能で ",
        math(String.raw`F'(\theta) = \tfrac{1}{2}(1\cdot\theta + \theta\cdot 1) = \theta`),
        "、",
        math(String.raw`F'`),
        " は恒等関数なので連続である。",
        math(String.raw`\theta \mapsto \tfrac{\theta}{6c_0(1+c_0)}`),
        " も恒等関数の定数倍なので微分可能、したがって連続である（微分の公式）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\left(\frac{1}{D_2}-\frac{1}{D_1}\right)d\theta
&\leq \int_0^{\pi}\frac{\theta}{6c_0\left(1+c_0\right)}\,d\theta
&&(\because\ \text{(R3) の単調性と、差の各点評価})\\
&= \frac{1}{6c_0\left(1+c_0\right)}\int_0^{\pi}\theta\,d\theta
&&(\because\ \text{(R3) の線型性を}\ \lambda = \tfrac{1}{6c_0(1+c_0)},\ \nu = 0\ \text{で})\\
&= \frac{1}{6c_0\left(1+c_0\right)}\left(\frac{\pi^2}{2} - \frac{0^2}{2}\right)
&&(\because\ \text{(R4) を}\ F\ \text{に})\\
&= \frac{\pi^2}{12c_0\left(1+c_0\right)}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= B
&&(\because\ \blkref{def_sine_integral_constant})
\end{aligned}`),
      paragraph(["上からの評価。"]),
      displayMath(String.raw`\begin{aligned}
\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\sin^2(\theta/2)}}
&= \int_0^{\pi}\frac{d\theta}{D_2}
&&(\because\ p, s, D_2\ \text{の置き方})\\
&= \int_0^{\pi}\left(\frac{1}{D_1} + \left(\frac{1}{D_2}-\frac{1}{D_1}\right)\right)d\theta
&&(\because\ \mathbb{R}\ \text{の四則を各点で})\\
&= \int_0^{\pi}\frac{d\theta}{D_1} + \int_0^{\pi}\left(\frac{1}{D_2}-\frac{1}{D_1}\right)d\theta
&&(\because\ \text{(R3) の線型性を}\ \lambda = \nu = 1\ \text{で})\\
&= \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}} + \int_0^{\pi}\left(\frac{1}{D_2}-\frac{1}{D_1}\right)d\theta
&&(\because\ D_1 = \sqrt{\delta^2+\theta^2/4})\\
&\leq \left(2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2}\right) + \int_0^{\pi}\left(\frac{1}{D_2}-\frac{1}{D_1}\right)d\theta
&&(\because\ \blkref{log_integral_two_sided_bounds}\ \text{の上からの評価})\\
&\leq \left(2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2}\right) + B
&&(\because\ \text{差の積分の評価}\ \textstyle\int_0^{\pi}(\tfrac{1}{D_2}-\tfrac{1}{D_1})\,d\theta \leq B)\\
&= 2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2} + B
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 1 ブロック 1 主張にするため、B の定義を def_sine_integral_constant へ、B ≤ 0.88 を sine_integral_constant_numerical_bound へ分けた。平方根どうしの大小を nonnegative_real_order_from_squares から、0 ≤ c_0 p ≤ s・D_1, D_2 ≥ δ > 0・被積分関数の連続性・F(θ) = θ²/2 の導関数を準備に書き、各点の大小と差の各点評価を 1 行 1 操作の鎖にした。「これが対数発散の源である」の段落は解釈なので注記 note_critical_010_claim_sine_integral_two_sided_log_divergence_source へ移した。",
      ],
    },
  },
]);
