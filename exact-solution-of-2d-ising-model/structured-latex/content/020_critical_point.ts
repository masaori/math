import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/020_critical_point.ts";

export default defineBlocks([
  {
    id: "heading_critical_point",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "臨界点と比熱の対数発散" },
    labels: [],
  },

  {
    id: "critical_000_remark_escape_to_real_analysis_chapter_E",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章で新たに持ち込む実数解析の事実（(R3)〜(R6)）" },
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
        "追加するのは次の 4 つだけであり、他では使わない。",
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
          ref("sine_integral_two_sided"),
          " と ",
          ref("second_derivative_log_divergence"),
          " の各不等式（被積分関数の各点評価を積分へ持ち上げる段）で使う。",
        ],
        [
          "(R4) は ",
          ref("closed_form_log_integral"),
          "（閉じた形の積分値の計算）と ",
          ref("elementary_sine_bounds"),
          "、",
          ref("kappa_of_K_basic"),
          "（増分の評価）で使う。",
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
    conversion: { status: "added" },
  },

  {
    id: "critical_001_claim_cosh_addition_and_half_angle",
    kind: "claim",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\cosh,\sinh \text{ の加法定理・半角公式と } \mathrm{arcsinh}` },
    labels: ["cosh_addition_and_half_angle"],
    statement: [
      paragraph([
        ref("cosh_sinh_basic_properties"),
        " の ",
        math(String.raw`\cosh, \sinh : \mathbb{R} \to \mathbb{R}`),
        " について次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`x, y \in \mathbb{R}`),
          " について ",
          math(String.raw`\cosh(x \pm y) = \cosh x\cosh y \pm \sinh x \sinh y`),
          "、",
          math(String.raw`\sinh(x \pm y) = \sinh x\cosh y \pm \cosh x \sinh y`),
          "。",
        ],
        [
          "(2) ",
          math(String.raw`x \in \mathbb{R}`),
          " について ",
          math(String.raw`\cosh x = 1 + 2\sinh^2\!\left(\tfrac{x}{2}\right)`),
          "、",
          math(String.raw`\sinh x = 2\sinh\!\left(\tfrac{x}{2}\right)\cosh\!\left(\tfrac{x}{2}\right)`),
          "。",
        ],
        [
          "(3) ",
          math(String.raw`\sinh`),
          " は ",
          math(String.raw`\mathbb{R}`),
          " 上狭義単調増加である。",
        ],
        [
          "(4) ",
          math(String.raw`y \in \mathbb{R}`),
          " について ",
          math(String.raw`\mathrm{arcsinh}(y) := \log\left(y + \sqrt{y^2+1}\right)`),
          " が定まり、",
          math(String.raw`\sinh(\mathrm{arcsinh}(y)) = y`),
          "。したがって (3) と合わせて ",
          math(String.raw`u \in \mathbb{R}`),
          " について ",
          math(String.raw`\sinh u = y \iff u = \mathrm{arcsinh}(y)`),
          "。さらに ",
          math(String.raw`\mathrm{arcsinh}`),
          " は微分可能で ",
          math(String.raw`\mathrm{arcsinh}'(y) = \dfrac{1}{\sqrt{y^2+1}}`),
          "。",
        ],
        [
          "(5) ",
          math(String.raw`t \in \mathbb{R}_{\geq 0}`),
          " について ",
          math(String.raw`t \leq \sinh t \leq t\cosh t`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) の証明。",
        ref("cosh_sinh_basic_properties"),
        " の定義と ",
        math(String.raw`\exp(a)\exp(b) = \exp(a+b)`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cosh x\cosh y + \sinh x\sinh y
&= \frac{\left(e^{x}+e^{-x}\right)\left(e^{y}+e^{-y}\right)}{4}
 + \frac{\left(e^{x}-e^{-x}\right)\left(e^{y}-e^{-y}\right)}{4}
   \quad (\because \text{cosh\_sinh\_basic\_properties の定義}) \\
&= \frac{\left(e^{x+y}+e^{x-y}+e^{-x+y}+e^{-x-y}\right)
       + \left(e^{x+y}-e^{x-y}-e^{-x+y}+e^{-x-y}\right)}{4}
   \quad (\because \exp(a)\exp(b)=\exp(a+b)) \\
&= \frac{2e^{x+y}+2e^{-(x+y)}}{4} \\
&= \frac{e^{x+y}+e^{-(x+y)}}{2} \\
&= \cosh(x+y)
   \quad (\because \text{cosh\_sinh\_basic\_properties の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`y`),
        " を ",
        math(String.raw`-y`),
        " に置き換えると（",
        math(String.raw`\cosh(-y)=\cosh y`),
        "、",
        math(String.raw`\sinh(-y)=-\sinh y`),
        " は定義から直ちに従う）",
        math(String.raw`\cosh(x-y) = \cosh x\cosh y - \sinh x\sinh y`),
        " を得る。",
        math(String.raw`\sinh`),
        " についても同じ計算（2 つの積の差を取る）で従う。",
      ]),
      paragraph([
        "(2) の証明。(1) で ",
        math(String.raw`x = y = \tfrac{x}{2}`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cosh x
&= \cosh^2\!\left(\tfrac{x}{2}\right) + \sinh^2\!\left(\tfrac{x}{2}\right)
   \quad (\because \text{cosh\_addition\_and\_half\_angle (1)}) \\
&= \left(1 + \sinh^2\!\left(\tfrac{x}{2}\right)\right) + \sinh^2\!\left(\tfrac{x}{2}\right)
   \quad (\because \text{cosh\_sinh\_basic\_properties (2)}) \\
&= 1 + 2\sinh^2\!\left(\tfrac{x}{2}\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\sinh x = 2\sinh(\tfrac{x}{2})\cosh(\tfrac{x}{2})`),
        " も (1) の ",
        math(String.raw`\sinh`),
        " の加法定理で ",
        math(String.raw`x = y = \tfrac{x}{2}`),
        " とすれば従う。",
      ]),
      paragraph([
        "(3) の証明。",
        math(String.raw`x < y`),
        " とする。",
        ref("cosh_sinh_basic_properties"),
        " で用いた ",
        math(String.raw`\exp`),
        " の狭義単調増加性より ",
        math(String.raw`e^{x} < e^{y}`),
        " かつ ",
        math(String.raw`e^{-x} > e^{-y}`),
        "。よって",
      ]),
      displayMath(
        String.raw`\sinh x = \frac{e^{x}-e^{-x}}{2} < \frac{e^{y}-e^{-y}}{2} = \sinh y`,
      ),
      paragraph([
        "(4) の証明。",
        math(String.raw`\sqrt{y^2+1} > \sqrt{y^2} = |y| \geq -y`),
        " より ",
        math(String.raw`y+\sqrt{y^2+1} > 0`),
        " なので ",
        math(String.raw`u := \log(y+\sqrt{y^2+1})`),
        " が定まる。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-u}
&= \frac{1}{y+\sqrt{y^2+1}} \\
&= \frac{\sqrt{y^2+1}-y}{\left(\sqrt{y^2+1}+y\right)\left(\sqrt{y^2+1}-y\right)}
   \quad (\because \text{分母の有理化}) \\
&= \frac{\sqrt{y^2+1}-y}{\left(y^2+1\right)-y^2} \\
&= \sqrt{y^2+1}-y
\end{aligned}`,
      ),
      paragraph(["であるから"]),
      displayMath(
        String.raw`\sinh u
= \frac{e^{u}-e^{-u}}{2}
= \frac{\left(y+\sqrt{y^2+1}\right)-\left(\sqrt{y^2+1}-y\right)}{2}
= y`,
      ),
      paragraph([
        "(3) より ",
        math(String.raw`\sinh`),
        " は単射なので ",
        math(String.raw`\sinh u = y \iff u = \mathrm{arcsinh}(y)`),
        "。微分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arcsinh}'(y)
&= \frac{1}{y+\sqrt{y^2+1}}\cdot\left(1 + \frac{y}{\sqrt{y^2+1}}\right)
   \quad (\because \log \text{ と } \sqrt{\ } \text{ の微分・合成関数の微分}) \\
&= \frac{1}{y+\sqrt{y^2+1}}\cdot\frac{\sqrt{y^2+1}+y}{\sqrt{y^2+1}} \\
&= \frac{1}{\sqrt{y^2+1}}
\end{aligned}`,
      ),
      paragraph([
        "(5) の証明。",
        ref("cosh_sinh_basic_properties"),
        " (3) より ",
        math(String.raw`u > 0`),
        " で ",
        math(String.raw`\sinh u > 0`),
        " であり、",
        math(String.raw`\cosh' = \sinh`),
        "、",
        math(String.raw`\sinh' = \cosh`),
        " は定義から直ちに従う。(R4) を ",
        math(String.raw`F = \sinh`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\sinh t = \sinh t - \sinh 0 = \int_0^t \cosh u\,du
\qquad (t \in \mathbb{R}_{\geq 0})`,
      ),
      paragraph([
        "同様に ",
        math(String.raw`\cosh u = 1 + \int_0^u \sinh v\,dv`),
        " であり、",
        math(String.raw`v \in [0,u]`),
        " で ",
        math(String.raw`\sinh v \geq 0`),
        " なので (R3) の単調性より ",
        math(String.raw`\cosh u \geq 1`),
        " かつ ",
        math(String.raw`\cosh`),
        " は ",
        math(String.raw`[0,\infty)`),
        " 上で単調増加である。よって ",
        math(String.raw`u \in [0,t]`),
        " で ",
        math(String.raw`1 \leq \cosh u \leq \cosh t`),
        " であり、(R3) の単調性を ",
        math(String.raw`\int_0^t`),
        " に適用して",
      ]),
      displayMath(
        String.raw`t = \int_0^t 1\,du \ \leq\ \int_0^t\cosh u\,du = \sinh t
\ \leq\ \int_0^t \cosh t\,du = t\cosh t`,
      ),
    ],
    conversion: { status: "added" },
  },

  {
    id: "critical_002_definition_kappa_and_A",
    kind: "definition",
    origin: { path: SRC, ordinal: 4 },
    title: { tex: String.raw`\kappa := 2K_1 - 2K_2^* \text{ と } A := \sinh 2K_1\sinh 2K_2^*` },
    labels: ["def_kappa_and_A"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもとで、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\kappa := 2K_1 - 2K_2^* \in \mathbb{R},
\qquad
A := s_1 s_2^* = \sinh 2K_1\,\sinh 2K_2^* \in \mathbb{R}_{>0}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`A > 0`),
        " であることは ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_1, K_2^* > 0`),
        " と ",
        ref("cosh_sinh_basic_properties"),
        " (3) から従う（",
        math(String.raw`s_1 > 0`),
        "、",
        math(String.raw`s_2^* > 0`),
        "）。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "critical_003_claim_gamma_kappa_identity",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`\sinh^2\!\left(\tfrac{\gamma(\theta)}{2}\right) = \sinh^2\!\left(\tfrac{\kappa}{2}\right) + A\sin^2\!\left(\tfrac{\theta}{2}\right)` },
    labels: ["gamma_kappa_identity"],
    statement: [
      paragraph([
        ref("def_kappa_and_A"),
        " の ",
        math(String.raw`\kappa, A`),
        " と ",
        ref("gamma1_lower_bound_all_theta"),
        " の ",
        math(String.raw`\gamma_1, \gamma`),
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
        ref("def_A_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " から出発する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)
&= c_1c_2^* - s_1s_2^*\cos\theta
   \quad (\because \text{def\_A\_theta}) \\
&= \left(c_1c_2^* - s_1s_2^*\right) + s_1s_2^*\left(1 - \cos\theta\right) \\
&= \cosh\left(2K_1 - 2K_2^*\right) + s_1s_2^*\left(1-\cos\theta\right)
   \quad (\because \text{cosh\_addition\_and\_half\_angle (1) を } x = 2K_1,\ y = 2K_2^* \text{ に適用}) \\
&= \cosh\kappa + A\left(1-\cos\theta\right)
   \quad (\because \text{def\_kappa\_and\_A}) \\
&= \cosh\kappa + 2A\sin^2\!\left(\frac{\theta}{2}\right)
   \quad (\because \text{倍角公式 } \cos 2t = 1 - 2\sin^2 t \text{ を } t = \tfrac{\theta}{2} \text{ に適用})
\end{aligned}`,
      ),
      paragraph([
        ref("gamma1_lower_bound_all_theta"),
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
   \quad (\because \text{cosh\_addition\_and\_half\_angle (2)}) \\
&= \cosh\kappa + 2A\sin^2\!\left(\frac{\theta}{2}\right)
   \quad (\because \text{Step 1}) \\
&= 1 + 2\sinh^2\!\left(\frac{\kappa}{2}\right) + 2A\sin^2\!\left(\frac{\theta}{2}\right)
   \quad (\because \text{cosh\_addition\_and\_half\_angle (2)})
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
    origin: { path: SRC, ordinal: 6 },
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
        ["(3) ", ref("def_kappa_and_A"), " の ", math(String.raw`\kappa = 2K_1 - 2K_2^*`), " が ", math(String.raw`0`), " に等しい"],
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
   \quad (\because s_2 > 0 \text{ で両辺を割る}) \\
&\iff \sinh 2K_1 = \sinh 2K_2^* \\
&\iff 2K_1 = 2K_2^*
   \quad (\because \text{cosh\_addition\_and\_half\_angle (3)：} \sinh \text{ は狭義単調増加ゆえ単射}) \\
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
    origin: { path: SRC, ordinal: 7 },
    title: { tex: String.raw`\text{等方な場合 } K_1 = K_2 = K \text{ では } A = 1` },
    labels: ["isotropic_A_equals_one"],
    statement: [
      paragraph([
        "以下、**等方な場合** ",
        math(String.raw`K_1 = K_2 = K \in \mathbb{R}_{>0}`),
        " を考える。このとき ",
        ref("def_kappa_and_A"),
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
      displayMath(
        String.raw`A = s_1 s_2^* = \sinh 2K_1 \sinh 2K_2^* = \sinh 2K\,\sinh 2K^* = 1
\quad (\because \text{def\_transfer\_matrix\_symbols の } K^* \text{ の定義})`,
      ),
      paragraph([
        "これを ",
        ref("gamma_kappa_identity"),
        " の 3 番目の式へ代入すれば主張の表示を得る。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "critical_006_claim_kappa_of_K_basic",
    kind: "claim",
    origin: { path: SRC, ordinal: 8 },
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
   \quad (\because \log \text{ の微分と合成関数の微分}) \\
&= -\frac{1}{2}\cdot\frac{\cosh K}{\sinh K}\cdot\frac{1}{\cosh^2 K}
   \quad (\because (\tanh)' = 1/\cosh^2) \\
&= -\frac{1}{2\sinh K\cosh K} \\
&= -\frac{1}{\sinh 2K}
   \quad (\because \text{cosh\_addition\_and\_half\_angle (2) を } x = 2K \text{ に適用})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\kappa'(K) = 2 - 2\dfrac{dK^*}{dK} = 2 + \dfrac{2}{\sinh 2K}`),
        "。",
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
        String.raw`\kappa''(K)
= \frac{d}{dK}\left(2 + \frac{2}{\sinh 2K}\right)
= -\frac{2}{\sinh^2 2K}\cdot 2\cosh 2K
= -\frac{4\cosh 2K}{\sinh^2 2K}`,
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
&= \sinh\left(2K_c + 2(K-K_c)\right) \\
&= \sinh 2K_c\cosh\left(2(K-K_c)\right) + \cosh 2K_c\sinh\left(2(K-K_c)\right)
   \quad (\because \text{cosh\_addition\_and\_half\_angle (1)}) \\
&= \cosh\left(2(K-K_c)\right) + \sqrt2\,\sinh\left(2(K-K_c)\right)
   \quad (\because \sinh 2K_c = 1,\ \cosh 2K_c = \sqrt2)
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
        math(String.raw`1.02006 \leq \cosh 0.2 \leq 1.02007`),
        "、",
        math(String.raw`0.201336 \leq \sinh 0.2 \leq 0.201337`),
        "、",
        math(String.raw`1.414213 \leq \sqrt2 \leq 1.414214`),
        " を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sinh 2K &\geq \cosh 0.2 - \sqrt2\sinh 0.2 \geq 1.02006 - 1.414214\cdot 0.201337 \geq 0.7353
   \quad (\because \text{cosh\_addition\_and\_half\_angle (3)：} \sinh \text{ の単調性と上の数値評価}) \\
\sinh 2K &\leq \cosh 0.2 + \sqrt2\sinh 0.2 \leq 1.02007 + 1.414214\cdot 0.201337 \leq 1.3048
   \quad (\because \text{同上})
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
        String.raw`\frac{d}{dt}\frac{\cosh t}{\sinh^2 t}
= \frac{\sinh^2 t\cdot\sinh t - \cosh t\cdot 2\sinh t\cosh t}{\sinh^4 t}
= \frac{\sinh^2 t - 2\cosh^2 t}{\sinh^3 t} < 0
\quad (\because \sinh^2 t < \cosh^2 t < 2\cosh^2 t,\ \sinh t>0)`,
      ),
      paragraph([
        "より、",
        math(String.raw`2K \geq 2K_c - 0.2`),
        " での最大値をとればよい。",
        math(String.raw`\sinh(2K_c-0.2) \geq 0.7353`),
        " と ",
        math(String.raw`\cosh(2K_c-0.2) = \sqrt2\cosh 0.2 - \sinh 0.2 \leq 1.414214\cdot 1.02007 - 0.201336 \leq 1.2413`),
        " より",
      ]),
      displayMath(
        String.raw`\left|\kappa''(K)\right| = \frac{4\cosh 2K}{\sinh^2 2K}
\leq \frac{4\cdot 1.2413}{0.7353^2} \leq 9.19`,
      ),
      paragraph([
        "最後に ",
        math(String.raw`\left(\kappa'^2\right)' = 2\kappa'\kappa''`),
        " なので ",
        math(String.raw`\left|\left(\kappa'^2\right)'\right| \leq 2\cdot 4.72\cdot 9.19 \leq 87`),
        "。",
      ]),
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
        String.raw`3.53\,|K-K_c| \ \leq\ |\kappa(K)| \ \leq\ 4.72\,|K-K_c| \ \leq\ 4.72\cdot\frac{1}{10} = 0.472`,
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
   \quad (\because \text{(1) の } \kappa' \text{ の表示を } K = K_c \text{ で読む}) \\
&= 2 + \frac{2}{1}
   \quad (\because \sinh 2K_c = 1\text{。本主張の } K_c \text{ の定義}) \\
&= 4
   \quad (\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "に注意すると",
      ]),
      displayMath(
        String.raw`\left|\kappa'(K)^2 - 16\right|
= \left|\int_{K_c}^{K}\left(\kappa'^2\right)'(t)\,dt\right|
\leq 87\,|K-K_c|
\leq 87\cdot\frac{|\kappa(K)|}{3.53}
\leq 24.7\,|\kappa(K)|`,
      ),
    ],
    conversion: { status: "added" },
  },

  {
    id: "critical_007_claim_gamma_derivatives_in_kappa",
    kind: "claim",
    origin: { path: SRC, ordinal: 9 },
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
   \quad (\because \text{cosh\_addition\_and\_half\_angle (2)}) \\
&= 2\sqrt{S}\sqrt{1+S} \\
&= 2\sqrt{S(1+S)} \\
\cosh\gamma
&= 1 + 2\sinh^2\!\left(\frac{\gamma}{2}\right)
   \quad (\because \text{cosh\_addition\_and\_half\_angle (2)}) \\
&= 1 + 2S
   \quad (\because \text{本主張 (1) の } \sinh(\tfrac\gamma2) = \sqrt S)
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
   \quad (\because (\sinh)' = \cosh \text{ と合成関数の微分}) \\
&= \sinh\!\left(\frac{\kappa}{2}\right)\cosh\!\left(\frac{\kappa}{2}\right) \\
&= \frac{1}{2}\sinh\kappa
   \quad (\because \text{cosh\_addition\_and\_half\_angle (2)})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\partial\gamma}{\partial\kappa}
&= 2\cdot\mathrm{arcsinh}'\!\left(\sqrt S\right)\cdot\frac{1}{2\sqrt S}\cdot\frac{\partial S}{\partial\kappa}
   \quad (\because \text{合成関数の微分と } (\sqrt{\ })' = \tfrac{1}{2\sqrt{\ }}) \\
&= 2\cdot\frac{1}{\sqrt{S+1}}\cdot\frac{1}{2\sqrt S}\cdot\frac{1}{2}\sinh\kappa
   \quad (\because \text{cosh\_addition\_and\_half\_angle (4)}) \\
&= \frac{\sinh\kappa}{2\sqrt{S(1+S)}} \\
&= \frac{\sinh\kappa}{\sinh\gamma}
   \quad (\because \text{本主張 (1)})
\end{aligned}`,
      ),
      paragraph(["もう一度微分すると"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\partial^2\gamma}{\partial\kappa^2}
&= \frac{\cosh\kappa\cdot\sinh\gamma - \sinh\kappa\cdot\cosh\gamma\cdot\dfrac{\partial\gamma}{\partial\kappa}}{\sinh^2\gamma}
   \quad (\because \text{商の微分と } (\sinh)' = \cosh) \\
&= \frac{\cosh\kappa}{\sinh\gamma}
 - \frac{\sinh\kappa\cosh\gamma}{\sinh^2\gamma}\cdot\frac{\sinh\kappa}{\sinh\gamma}
   \quad (\because \text{直前の式}) \\
&= \frac{\cosh\kappa}{\sinh\gamma} - \frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}
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
   \quad (\because \text{本主張 (1)}) \\
&\geq 2\sqrt{\sinh^2\!\left(\frac{\kappa}{2}\right)\cosh^2\!\left(\frac{\kappa}{2}\right)}
   \quad (\because S \geq \sinh^2(\tfrac\kappa2),\ 1+S \geq \cosh^2(\tfrac\kappa2)) \\
&= 2\left|\sinh\!\left(\frac{\kappa}{2}\right)\right|\cosh\!\left(\frac{\kappa}{2}\right)
   \quad (\because \cosh > 0) \\
&= \left|\sinh\kappa\right|
   \quad (\because \text{cosh\_addition\_and\_half\_angle (2)})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\sinh\gamma > 0`),
        "（",
        math(String.raw`S>0`),
        " より）なので ",
        math(String.raw`\left|\dfrac{\partial\gamma}{\partial\kappa}\right| = \dfrac{|\sinh\kappa|}{\sinh\gamma} \leq 1`),
        "。",
      ]),
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
    id: "critical_008_claim_elementary_sine_bounds",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`0 \leq \tfrac{\theta}{2} - \sin\tfrac{\theta}{2} \leq \tfrac{\theta^3}{48} \quad (0 \leq \theta \leq \pi)` },
    labels: ["elementary_sine_bounds"],
    statement: [
      paragraph([
        math(String.raw`c_0 := 1 - \dfrac{\pi^2}{24}`),
        " とおく（",
        math(String.raw`0.5887 \leq c_0 \leq 0.5888`),
        "）。",
        math(String.raw`\theta \in [0,\pi]`),
        " について次が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0 \ \leq\ \frac{\theta}{2} - \sin\frac{\theta}{2} \ &\leq\ \frac{\theta^3}{48} \\
c_0\,\frac{\theta}{2} \ \leq\ \sin\frac{\theta}{2} \ &\leq\ \frac{\theta}{2}
\end{aligned}`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1。",
        math(String.raw`t \geq 0`),
        " について ",
        math(String.raw`1 - \cos v \geq 0`),
        " なので、(R4) を ",
        math(String.raw`F(t) = t - \sin t`),
        "（",
        math(String.raw`F' = 1-\cos`),
        " は連続）に適用し (R3) の単調性を使うと",
      ]),
      displayMath(
        String.raw`t - \sin t = \int_0^t\left(1-\cos v\right)dv \ \geq\ \int_0^t 0\,dv = 0`,
      ),
      paragraph([
        "Step 2。Step 1 より ",
        math(String.raw`u \geq 0`),
        " で ",
        math(String.raw`u - \sin u \geq 0`),
        " なので、(R4) を ",
        math(String.raw`F(t) = \sin t - t + \tfrac{t^3}{6}`),
        " の導関数 ",
        math(String.raw`F'(t) = \cos t - 1 + \tfrac{t^2}{2}`),
        " に対して 2 段階に使う。まず",
      ]),
      displayMath(
        String.raw`\cos t - 1 + \frac{t^2}{2} = \int_0^t\left(u - \sin u\right)du \ \geq\ 0
\qquad (t \geq 0)`,
      ),
      paragraph(["次に、これを被積分関数として"]),
      displayMath(
        String.raw`\sin t - t + \frac{t^3}{6} = \int_0^t\left(\cos v - 1 + \frac{v^2}{2}\right)dv \ \geq\ 0
\qquad (t \geq 0)`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`t \geq 0`),
        " で ",
        math(String.raw`t - \dfrac{t^3}{6} \leq \sin t \leq t`),
        "。",
      ]),
      paragraph([
        "Step 3。",
        math(String.raw`t = \dfrac{\theta}{2}`),
        " とおくと ",
        math(String.raw`\theta \in [0,\pi]`),
        " より ",
        math(String.raw`t \in [0,\tfrac\pi2]`),
        " であり、Step 2 から",
      ]),
      displayMath(
        String.raw`0 \ \leq\ \frac{\theta}{2}-\sin\frac{\theta}{2} \ \leq\ \frac{1}{6}\left(\frac{\theta}{2}\right)^3 = \frac{\theta^3}{48}`,
      ),
      paragraph(["また"]),
      displayMath(
        String.raw`\begin{aligned}
\sin\frac{\theta}{2}
&\geq \frac{\theta}{2} - \frac{1}{6}\left(\frac{\theta}{2}\right)^3
   \quad (\because \text{Step 2}) \\
&= \frac{\theta}{2}\left(1 - \frac{1}{6}\left(\frac{\theta}{2}\right)^2\right) \\
&\geq \frac{\theta}{2}\left(1 - \frac{1}{6}\cdot\frac{\pi^2}{4}\right)
   \quad (\because 0 \leq \tfrac{\theta}{2} \leq \tfrac{\pi}{2}) \\
&= c_0\,\frac{\theta}{2}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`c_0`),
        " の数値評価は ",
        math(String.raw`9.8696 \leq \pi^2 \leq 9.8697`),
        " より ",
        math(String.raw`1 - \tfrac{9.8697}{24} \leq c_0 \leq 1 - \tfrac{9.8696}{24}`),
        " すなわち ",
        math(String.raw`0.5887 \leq c_0 \leq 0.5888`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "critical_009_claim_closed_form_log_integral",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}} = 2\,\mathrm{arcsinh}\!\left(\frac{\pi}{2\delta}\right)` },
    labels: ["closed_form_log_integral"],
    statement: [
      paragraph([
        math(String.raw`\delta \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`a \in \mathbb{R}_{>0}`),
        " について次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\displaystyle\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2 + \theta^2/4}}
             = 2\,\mathrm{arcsinh}\!\left(\frac{\pi}{2\delta}\right)`),
        ],
        [
          "(2) ",
          math(String.raw`y \in \mathbb{R}_{>0}`),
          " について ",
          math(String.raw`\log(2y) \leq \mathrm{arcsinh}(y) \leq \log(2y) + \dfrac{1}{4y^2}`),
          "。とくに (1) と合わせて",
          math(String.raw`\quad 2\log\dfrac{\pi}{\delta} \ \leq\ \displaystyle\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}}
             \ \leq\ 2\log\dfrac{\pi}{\delta} + \dfrac{2\delta^2}{\pi^2}`),
          "。",
        ],
        [
          "(3) ",
          math(String.raw`\displaystyle\int_0^{\pi}\frac{d\theta}{\left(\delta^2 + a^2\theta^2/4\right)^{3/2}}
             \ \leq\ \frac{2}{a\,\delta^2}`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) の証明。",
        math(String.raw`F(\theta) := 2\,\mathrm{arcsinh}\!\left(\dfrac{\theta}{2\delta}\right)`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F'(\theta)
&= 2\cdot\frac{1}{\sqrt{\left(\frac{\theta}{2\delta}\right)^2+1}}\cdot\frac{1}{2\delta}
   \quad (\because \text{cosh\_addition\_and\_half\_angle (4) と合成関数の微分}) \\
&= \frac{1}{\delta}\cdot\frac{2\delta}{\sqrt{\theta^2 + 4\delta^2}}
   \quad (\because \delta > 0 \text{ より } \sqrt{\tfrac{\theta^2+4\delta^2}{4\delta^2}} = \tfrac{\sqrt{\theta^2+4\delta^2}}{2\delta}) \\
&= \frac{2}{\sqrt{\theta^2+4\delta^2}} \\
&= \frac{1}{\sqrt{\delta^2 + \theta^2/4}}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`F'`),
        " は ",
        math(String.raw`[0,\pi]`),
        " 上連続（分母は ",
        math(String.raw`\geq \delta > 0`),
        "）なので (R4) より",
      ]),
      displayMath(
        String.raw`\int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}}
= F(\pi) - F(0)
= 2\,\mathrm{arcsinh}\!\left(\frac{\pi}{2\delta}\right) - 0`,
      ),
      paragraph([
        "(2) の証明。",
        ref("cosh_addition_and_half_angle"),
        " (4) の ",
        math(String.raw`\mathrm{arcsinh}(y) = \log(y+\sqrt{y^2+1})`),
        " について、",
        math(String.raw`y > 0`),
        " のとき",
      ]),
      displayMath(
        String.raw`2y \ \leq\ y + \sqrt{y^2+1} \ \leq\ 2y + \frac{1}{2y}`,
      ),
      paragraph([
        "が成り立つ（左は ",
        math(String.raw`\sqrt{y^2+1} \geq y`),
        "、右は ",
        math(String.raw`\left(y+\tfrac{1}{2y}\right)^2 = y^2+1+\tfrac{1}{4y^2} \geq y^2+1`),
        " と両辺の正値性から ",
        math(String.raw`\sqrt{y^2+1} \leq y + \tfrac1{2y}`),
        "）。",
        math(String.raw`\log`),
        " は狭義単調増加なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arcsinh}(y)
&\leq \log\left(2y + \frac{1}{2y}\right)
   \quad (\because \text{直前の不等式と } \log \text{ の狭義単調増加性}) \\
&= \log(2y) + \log\left(1 + \frac{1}{4y^2}\right)
   \quad (\because \log(ab) = \log a + \log b) \\
&\leq \log(2y) + \frac{1}{4y^2}
   \quad (\because \log(1+x) \leq x)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\log(1+x)\leq x`),
        " は (R4) より ",
        math(String.raw`x - \log(1+x) = \int_0^x\left(1-\tfrac1{1+v}\right)dv \geq 0`),
        "（",
        math(String.raw`x \geq 0`),
        "）から従う。）",
        math(String.raw`y = \dfrac{\pi}{2\delta}`),
        " を (1) へ代入すると ",
        math(String.raw`\log(2y) = \log\dfrac{\pi}{\delta}`),
        "、",
        math(String.raw`\dfrac{1}{4y^2} = \dfrac{\delta^2}{\pi^2}`),
        " なので、両辺を 2 倍して主張の評価を得る。",
      ]),
      paragraph([
        "(3) の証明。",
        math(String.raw`G(\theta) := \dfrac{\theta}{\delta^2\sqrt{\delta^2 + a^2\theta^2/4}}`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
G'(\theta)
&= \frac{\sqrt{\delta^2+\frac{a^2\theta^2}{4}} - \theta\cdot\frac{a^2\theta/4}{\sqrt{\delta^2+\frac{a^2\theta^2}{4}}}}
        {\delta^2\left(\delta^2+\frac{a^2\theta^2}{4}\right)}
   \quad (\because \text{商の微分}) \\
&= \frac{\left(\delta^2+\frac{a^2\theta^2}{4}\right) - \frac{a^2\theta^2}{4}}
        {\delta^2\left(\delta^2+\frac{a^2\theta^2}{4}\right)^{3/2}} \\
&= \frac{1}{\left(\delta^2+\frac{a^2\theta^2}{4}\right)^{3/2}}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`G'`),
        " は ",
        math(String.raw`[0,\pi]`),
        " 上連続なので (R4) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\int_0^{\pi}\frac{d\theta}{\left(\delta^2+\frac{a^2\theta^2}{4}\right)^{3/2}}
&= G(\pi) - G(0) \\
&= \frac{\pi}{\delta^2\sqrt{\delta^2 + \frac{a^2\pi^2}{4}}} \\
&\leq \frac{\pi}{\delta^2\cdot\frac{a\pi}{2}}
   \quad (\because \sqrt{\delta^2 + \tfrac{a^2\pi^2}{4}} \geq \sqrt{\tfrac{a^2\pi^2}{4}} = \tfrac{a\pi}{2}) \\
&= \frac{2}{a\delta^2}
\end{aligned}`,
      ),
    ],
    conversion: { status: "added" },
  },

  {
    id: "critical_010_claim_sine_integral_two_sided",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`2\log\frac{\pi}{\delta} \leq \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\sin^2(\theta/2)}} \leq 2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2} + B` },
    labels: ["sine_integral_two_sided"],
    statement: [
      paragraph([
        ref("elementary_sine_bounds"),
        " の ",
        math(String.raw`c_0 = 1-\tfrac{\pi^2}{24}`),
        " を用いて",
      ]),
      displayMath(
        String.raw`B := \frac{\pi^2}{12\,c_0\left(1+c_0\right)}`,
      ),
      paragraph([
        "とおく（",
        math(String.raw`B \leq 0.88`),
        "）。このとき ",
        math(String.raw`\delta \in \mathbb{R}_{>0}`),
        " について",
      ]),
      displayMath(
        String.raw`2\log\frac{\pi}{\delta}
\ \leq\ \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\sin^2\!\left(\frac{\theta}{2}\right)}}
\ \leq\ 2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2} + B`,
      ),
      paragraph([
        "**これが対数発散の源である。** 右辺・左辺の差は ",
        math(String.raw`\delta \to +0`),
        " で有界に留まるので、この積分は ",
        math(String.raw`2\log\frac{1}{\delta}`),
        " と定数の差しかもたない。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（積分が定まること）。",
        math(String.raw`\delta > 0`),
        " なので被積分関数は ",
        math(String.raw`[0,\pi]`),
        " 上連続（分母は ",
        math(String.raw`\geq \delta > 0`),
        "）である。以下 ",
        math(String.raw`p := \dfrac{\theta}{2} \in [0,\tfrac\pi2]`),
        "、",
        math(String.raw`s := \sin p`),
        "、",
        math(String.raw`D_1 := \sqrt{\delta^2+p^2}`),
        "、",
        math(String.raw`D_2 := \sqrt{\delta^2+s^2}`),
        " と略記する。",
      ]),
      paragraph([
        "Step 1（下からの評価）。",
        ref("elementary_sine_bounds"),
        " より ",
        math(String.raw`s \leq p`),
        " なので ",
        math(String.raw`D_2 \leq D_1`),
        "、したがって各点で ",
        math(String.raw`\dfrac{1}{D_2} \geq \dfrac{1}{D_1}`),
        "。(R3) の単調性と ",
        ref("closed_form_log_integral"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\int_0^{\pi}\frac{d\theta}{D_2}
\ \geq\ \int_0^{\pi}\frac{d\theta}{D_1}
\ =\ \int_0^{\pi}\frac{d\theta}{\sqrt{\delta^2+\theta^2/4}}
\ \geq\ 2\log\frac{\pi}{\delta}`,
      ),
      paragraph([
        "Step 2（差の各点評価）。",
        math(String.raw`p \in (0,\tfrac\pi2]`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{D_2} - \frac{1}{D_1}
&= \frac{D_1 - D_2}{D_1D_2} \\
&= \frac{D_1^2 - D_2^2}{D_1D_2\left(D_1+D_2\right)}
   \quad (\because D_1 - D_2 = \tfrac{D_1^2-D_2^2}{D_1+D_2},\ D_1+D_2 > 0) \\
&= \frac{p^2 - s^2}{D_1D_2\left(D_1+D_2\right)}
   \quad (\because D_1^2 - D_2^2 = (\delta^2+p^2)-(\delta^2+s^2) = p^2-s^2) \\
&= \frac{\left(p-s\right)\left(p+s\right)}{D_1D_2\left(D_1+D_2\right)}
\end{aligned}`,
      ),
      paragraph([
        "分子は ",
        ref("elementary_sine_bounds"),
        " の ",
        math(String.raw`0 \leq p - s \leq \tfrac{p^3}{6}`),
        " と ",
        math(String.raw`p+s \leq 2p`),
        " より ",
        math(String.raw`\left(p-s\right)\left(p+s\right) \leq \dfrac{p^3}{6}\cdot 2p = \dfrac{p^4}{3}`),
        "。分母は ",
        math(String.raw`D_1 \geq p`),
        "、",
        math(String.raw`D_2 \geq s \geq c_0 p`),
        "（",
        ref("elementary_sine_bounds"),
        "）より",
      ]),
      displayMath(
        String.raw`D_1D_2\left(D_1+D_2\right) \ \geq\ p\cdot c_0p\cdot\left(p + c_0p\right) = c_0\left(1+c_0\right)p^3`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`0 \ \leq\ \frac{1}{D_2} - \frac{1}{D_1}
\ \leq\ \frac{p^4/3}{c_0\left(1+c_0\right)p^3}
= \frac{p}{3c_0\left(1+c_0\right)}
= \frac{\theta}{6c_0\left(1+c_0\right)}`,
      ),
      paragraph([
        "（",
        math(String.raw`p = 0`),
        " では ",
        math(String.raw`\tfrac1{D_2}-\tfrac1{D_1} = 0`),
        " なので、この評価は ",
        math(String.raw`[0,\tfrac\pi2]`),
        " 全体で成り立つ。）",
      ]),
      paragraph(["Step 3（積分して足す）。(R3) の単調性と (R4) より"]),
      displayMath(
        String.raw`\begin{aligned}
\int_0^{\pi}\left(\frac{1}{D_2}-\frac{1}{D_1}\right)d\theta
&\leq \int_0^{\pi}\frac{\theta}{6c_0\left(1+c_0\right)}\,d\theta
   \quad (\because \text{Step 2 と (R3)}) \\
&= \frac{1}{6c_0\left(1+c_0\right)}\cdot\frac{\pi^2}{2}
   \quad (\because \text{(R4) を } F(\theta)=\tfrac{\theta^2}{2} \text{ に適用}) \\
&= \frac{\pi^2}{12c_0\left(1+c_0\right)} \\
&= B
\end{aligned}`,
      ),
      paragraph([
        "よって (R3) の線型性と ",
        ref("closed_form_log_integral"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\int_0^{\pi}\frac{d\theta}{D_2}
= \int_0^{\pi}\frac{d\theta}{D_1} + \int_0^{\pi}\left(\frac{1}{D_2}-\frac{1}{D_1}\right)d\theta
\ \leq\ \left(2\log\frac{\pi}{\delta} + \frac{2\delta^2}{\pi^2}\right) + B`,
      ),
      paragraph([
        "数値評価は ",
        ref("elementary_sine_bounds"),
        " の ",
        math(String.raw`c_0 \geq 0.5887`),
        " より ",
        math(String.raw`12c_0(1+c_0) \geq 12\cdot 0.5887\cdot 1.5887 \geq 11.22`),
        "、",
        math(String.raw`B \leq \dfrac{9.8697}{11.22} \leq 0.88`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "critical_011_theorem_second_derivative_log_divergence",
    kind: "theorem",
    origin: { path: SRC, ordinal: 13 },
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
        ref("gamma_kappa_identity"),
        " より ",
        math(String.raw`\gamma(\theta,-\kappa) = \gamma(\theta,\kappa)`),
        " なので、被積分関数が一致することから ",
        math(String.raw`G(-\kappa) = G(\kappa)`),
        "（すべての実数 ",
        math(String.raw`\kappa`),
        "）。ここから ",
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
        " と (R3) より ",
        math(String.raw`|G'(\kappa)| \leq \dfrac{1}{4\pi}\cdot 2\pi\cdot 1 = \dfrac12`),
        "。",
      ]),
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
      displayMath(
        String.raw`G''(\kappa)
= \frac{1}{4\pi}\left(\int_0^{\pi} + \int_{\pi}^{2\pi}\right)\frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta
= \frac{1}{2\pi}\int_0^{\pi}\frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta`,
      ),
      paragraph([
        "Step 3（2 つの項に分ける）。",
        ref("gamma_derivatives_in_kappa"),
        " (1)(2) より ",
        math(String.raw`\sinh\gamma = 2\sqrt{S(1+S)}`),
        "、",
        math(String.raw`\cosh\gamma = 1+2S`),
        "、",
        math(String.raw`S = \delta^2 + \sin^2\!\left(\tfrac\theta2\right)`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\int_0^{\pi}\frac{\partial^2\gamma}{\partial\kappa^2}\,d\theta
&= \int_0^{\pi}\left(\frac{\cosh\kappa}{\sinh\gamma}
   - \frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\right)d\theta
   \quad (\because \text{gamma\_derivatives\_in\_kappa (2)}) \\
&= \frac{\cosh\kappa}{2}\,J \;-\; T
   \quad (\because \text{(R3) の線型性}) \\
J &:= \int_0^{\pi}\frac{d\theta}{\sqrt{S(1+S)}},
\qquad
T := \int_0^{\pi}\frac{\sinh^2\kappa\,\cosh\gamma}{\sinh^3\gamma}\,d\theta
\end{aligned}`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`J`),
        " の評価）。まず各点で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0 \ \leq\ \frac{1}{\sqrt S} - \frac{1}{\sqrt{S(1+S)}}
&= \frac{1}{\sqrt S}\left(1 - \frac{1}{\sqrt{1+S}}\right)
   \quad (\because 1+S \geq 1 \text{ より } \sqrt{1+S} \geq 1) \\
&= \frac{1}{\sqrt S}\cdot\frac{\sqrt{1+S}-1}{\sqrt{1+S}} \\
&= \frac{1}{\sqrt S}\cdot\frac{S}{\sqrt{1+S}\left(\sqrt{1+S}+1\right)}
   \quad (\because \sqrt{1+S}-1 = \tfrac{S}{\sqrt{1+S}+1}) \\
&\leq \frac{1}{\sqrt S}\cdot\frac{S}{2}
   \quad (\because \sqrt{1+S}\geq 1 \text{ より分母} \geq 2) \\
&= \frac{\sqrt S}{2} \\
&\leq \frac{\sqrt{\delta^2+1}}{2}
   \quad (\because \sin^2 \leq 1) \\
&= \frac{\cosh\!\left(\frac{\kappa}{2}\right)}{2}
   \quad (\because \text{cosh\_sinh\_basic\_properties (2)})
\end{aligned}`,
      ),
      paragraph([
        "この各点評価は **符号のついた片側の評価** である。(R3) の単調性を ",
        math(String.raw`[0,\pi]`),
        " 上で使うと",
      ]),
      displayMath(
        String.raw`0 \ \leq\ \int_0^{\pi}\frac{d\theta}{\sqrt S} - J \ \leq\ \frac{\pi}{2}\cosh\!\left(\frac{\kappa}{2}\right)`,
      ),
      paragraph([
        ref("sine_integral_two_sided"),
        " を ",
        math(String.raw`\delta = \sinh(\tfrac\kappa2)`),
        " に適用すると ",
        math(String.raw`\displaystyle\int_0^{\pi}\frac{d\theta}{\sqrt S} = 2\log\frac{\pi}{\delta} + R_0`),
        "（",
        math(String.raw`0 \leq R_0 \leq \frac{2\delta^2}{\pi^2} + B`),
        "）なので、",
        math(String.raw`R := J - 2\log\frac{\pi}{\delta}`),
        " とおくと ",
        math(String.raw`R = R_0 - \left(\displaystyle\int_0^{\pi}\frac{d\theta}{\sqrt S} - J\right)`),
        " であり、**上界は ",
        math(String.raw`R_0`),
        " だけから、下界は直前の評価だけから来る**（両者を足す必要はない）：",
      ]),
      displayMath(
        String.raw`J = 2\log\frac{\pi}{\delta} + R,
\qquad
-\frac{\pi}{2}\cosh\!\left(\frac{\kappa}{2}\right) \ \leq\ R \ \leq\ \frac{2\delta^2}{\pi^2} + B`,
      ),
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
      displayMath(
        String.raw`|R| \ \leq\ \max\left\{\frac{2\cdot 0.2527^2}{9.8696} + 0.88,\ \ \frac{3.1416}{2}\cdot 1.0315\right\}
\ \leq\ \max\left\{0.0130 + 0.88,\ \ 1.6203\right\} \ \leq\ 1.621`,
      ),
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
      displayMath(
        String.raw`\begin{aligned}
0 \ \leq\ \frac{\cosh\gamma}{\sinh^3\gamma}
&= \frac{1+2S}{8\,S^{3/2}(1+S)^{3/2}}
   \quad (\because \text{gamma\_derivatives\_in\_kappa (1)}) \\
&\leq \frac{2(1+S)}{8\,S^{3/2}(1+S)}
   \quad (\because 1+2S \leq 2(1+S) \text{ と } (1+S)^{3/2} \geq 1+S) \\
&= \frac{1}{4\,S^{3/2}}
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
   \quad (\because \text{直前の各点評価と (R3) の単調性}) \\
&\leq \frac{\sinh^2\kappa}{4}\int_0^{\pi}\frac{d\theta}{\left(\delta^2+\frac{c_0^2\theta^2}{4}\right)^{3/2}}
   \quad (\because \text{(R3) の単調性}) \\
&\leq \frac{\sinh^2\kappa}{4}\cdot\frac{2}{c_0\delta^2}
   \quad (\because \text{closed\_form\_log\_integral (3)}) \\
&= \frac{4\delta^2\cosh^2\!\left(\frac{\kappa}{2}\right)}{4}\cdot\frac{2}{c_0\delta^2}
   \quad (\because \text{cosh\_addition\_and\_half\_angle (2)：} \sinh\kappa = 2\delta\cosh(\tfrac\kappa2)) \\
&= \frac{2\cosh^2\!\left(\frac{\kappa}{2}\right)}{c_0} \\
&\leq \frac{2\cdot 1.0315^2}{0.5887}
   \quad (\because \kappa \leq \tfrac12 \text{ と elementary\_sine\_bounds の } c_0 \geq 0.5887) \\
&\leq 3.614
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
        " なので",
      ]),
      displayMath(
        String.raw`\frac{2}{\cosh\!\left(\frac{\kappa}{2}\right)} \ \leq\ \frac{\kappa}{\delta} \ \leq\ 2,
\qquad\text{すなわち}\qquad
-\log\cosh\!\left(\frac{\kappa}{2}\right) \ \leq\ \log\frac{\kappa}{\delta} - \log 2 \ \leq\ 0`,
      ),
      paragraph([
        math(String.raw`\rho := \log\frac{\kappa}{\delta} - \log 2`),
        " とおくと ",
        math(String.raw`\log\frac{\pi}{\delta} = \log\frac{1}{\kappa} + \log(2\pi) + \rho`),
        " であり、",
        math(String.raw`|\rho| \leq \log\cosh\tfrac14 \leq 0.0310`),
        "。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cosh\kappa\,\log\frac{\pi}{\delta} - \log\frac{1}{\kappa}
&= \left(\cosh\kappa - 1\right)\log\frac{1}{\kappa}
 + \cosh\kappa\left(\log(2\pi) + \rho\right)
\end{aligned}`,
      ),
      paragraph([
        "右辺第 1 項は、",
        ref("cosh_addition_and_half_angle"),
        " (2)(5) より ",
        math(String.raw`\cosh\kappa - 1 = 2\sinh^2\!\left(\tfrac\kappa2\right) \leq 2\left(\tfrac\kappa2\cosh\tfrac14\right)^2 \leq 0.532\,\kappa^2`),
        " であり、",
        math(String.raw`\kappa^2\log\frac1\kappa`),
        " は ",
        math(String.raw`(0,\tfrac12]`),
        " 上単調増加（導関数 ",
        math(String.raw`\kappa\left(2\log\frac1\kappa - 1\right) > 0`),
        "）で最大値は ",
        math(String.raw`\tfrac14\log 2 \leq 0.1733`),
        " なので",
      ]),
      displayMath(
        String.raw`0 \ \leq\ \left(\cosh\kappa-1\right)\log\frac{1}{\kappa} \ \leq\ 0.532\cdot 0.1733 \ \leq\ 0.093`,
      ),
      paragraph([
        "第 2 項は ",
        math(String.raw`\cosh\kappa \leq \cosh\tfrac12 \leq 1.1277`),
        "、",
        math(String.raw`\log(2\pi) \leq 1.8380`),
        " より",
      ]),
      displayMath(
        String.raw`\left|\cosh\kappa\left(\log(2\pi)+\rho\right)\right|
\ \leq\ 1.1277\left(1.8380 + 0.0310\right) \ \leq\ 2.108`,
      ),
      paragraph(["以上を合わせると"]),
      displayMath(
        String.raw`\left|\cosh\kappa\,\log\frac{\pi}{\delta} - \log\frac{1}{\kappa}\right| \ \leq\ 0.093 + 2.108 \ =\ 2.201`,
      ),
      paragraph(["Step 7（総合）。Step 2〜6 より"]),
      displayMath(
        String.raw`\begin{aligned}
2\pi\,G''(\kappa)
&= \frac{\cosh\kappa}{2}J - T
   \quad (\because \text{Step 2, Step 3}) \\
&= \frac{\cosh\kappa}{2}\left(2\log\frac{\pi}{\delta} + R\right) - T
   \quad (\because \text{Step 4}) \\
&= \cosh\kappa\,\log\frac{\pi}{\delta} + \frac{\cosh\kappa}{2}R - T
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\left|2\pi\,G''(\kappa) - \log\frac{1}{\kappa}\right|
&\leq \left|\cosh\kappa\,\log\frac{\pi}{\delta} - \log\frac{1}{\kappa}\right|
 + \frac{\cosh\kappa}{2}|R| + |T|
   \quad (\because \text{三角不等式}) \\
&\leq 2.201 + \frac{1.1277}{2}\cdot 1.621 + 3.614
   \quad (\because \text{Step 4, Step 5, Step 6}) \\
&\leq 2.201 + 0.915 + 3.614 \\
&= 6.730
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`2\pi \geq 6.2831`),
        " で割ると",
      ]),
      displayMath(
        String.raw`\left|G''(\kappa) - \frac{1}{2\pi}\log\frac{1}{\kappa}\right|
\ \leq\ \frac{6.730}{6.2831} \ \leq\ 1.08 \ \leq\ \frac{6}{5}`,
      ),
      paragraph([
        "最後に ",
        math(String.raw`\kappa \to 0`),
        " で ",
        math(String.raw`\log\frac1{|\kappa|} \to +\infty`),
        " なので ",
        math(String.raw`G''(\kappa) \geq \frac{1}{2\pi}\log\frac{1}{|\kappa|} - \frac65 \to +\infty`),
        "。",
      ]),
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
    origin: { path: SRC, ordinal: 14 },
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
&= \frac{\cosh 2K}{\sinh 2K} \\
\frac{d^2}{dK^2}\left(\frac12\log\left(2\sinh 2K\right)\right)
&= \frac{2\sinh 2K\cdot\sinh 2K - \cosh 2K\cdot 2\cosh 2K}{\sinh^2 2K}
   \quad (\because \text{商の微分}) \\
&= \frac{2\left(\sinh^2 2K - \cosh^2 2K\right)}{\sinh^2 2K} \\
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
        String.raw`\left|\frac{d^2}{dK^2}\left(\frac12\log\left(2\sinh 2K\right)\right)\right|
\ \leq\ \frac{2}{0.7353^2} \ \leq\ 3.70`,
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
= G''\!\left(\kappa(K)\right)\kappa'(K)^2 + G'\!\left(\kappa(K)\right)\kappa''(K)`,
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
        String.raw`\left|G'\!\left(\kappa(K)\right)\kappa''(K)\right| \ \leq\ \frac{9.19}{2} \ \leq\ 4.60`,
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
   \quad (\because \text{second\_derivative\_log\_divergence}) \\
&= 24.7\left(\frac{1}{2\pi}\,|\kappa|\log\frac{1}{|\kappa|} + \frac65|\kappa|\right) \\
&\leq 24.7\left(\frac{1}{2\pi}\cdot\frac1e + \frac65\cdot 0.472\right)
   \quad (\because |\kappa| \leq 0.472 \text{ と下記の } |\kappa|\log\tfrac1{|\kappa|}\leq \tfrac1e) \\
&\leq 24.7\left(0.0586 + 0.5664\right) \\
&\leq 15.44
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
        String.raw`\left|16\,G''(\kappa) - \frac{8}{\pi}\log\frac{1}{|\kappa|}\right|
= 16\left|G''(\kappa) - \frac{1}{2\pi}\log\frac{1}{|\kappa|}\right|
\ \leq\ 16\cdot\frac65 \ =\ 19.2`,
      ),
      paragraph(["Step 6（総合）。Step 2〜5 と三角不等式より"]),
      displayMath(
        String.raw`\begin{aligned}
\left|\frac{d^2f}{dK^2} - \frac{8}{\pi}\log\frac{1}{|\kappa|}\right|
&\leq \left|\frac{d^2}{dK^2}\left(\tfrac12\log(2\sinh 2K)\right)\right|
 + \left|G'\kappa''\right|
 + \left|\left(\kappa'^2-16\right)G''\right|
 + \left|16G'' - \frac{8}{\pi}\log\frac{1}{|\kappa|}\right| \\
&\leq 3.70 + 4.60 + 15.44 + 19.2 \\
&= 42.94 \\
&\leq 45
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
        String.raw`\left|\log\frac{1}{|\kappa|} - \log\frac{1}{|K-K_c|}\right|
= \left|\log\frac{|\kappa|}{|K-K_c|}\right|
\ \leq\ \log 4.72 \ \leq\ 1.5518`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\left|\frac{d^2f}{dK^2} - \frac{8}{\pi}\log\frac{1}{|K-K_c|}\right|
\ \leq\ 45 + \frac{8}{\pi}\cdot 1.5518
\ \leq\ 45 + 3.96 \ \leq\ 49`,
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
        String.raw`\left|\frac{\dfrac{d^2f}{dK^2}}{\log\dfrac{1}{|K-K_c|}} - \frac{8}{\pi}\right|
\ \leq\ \frac{49}{\log\dfrac{1}{|K-K_c|}} \ \xrightarrow[K\to K_c]{}\ 0`,
      ),
      paragraph([
        "（",
        math(String.raw`|K-K_c| < e^{-1}`),
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
    id: "critical_013_remark_physical_specific_heat",
    kind: "remark",
    origin: { path: SRC, ordinal: 15 },
    title: { tex: String.raw`\text{物理的な比熱 } C \text{ との対応：} C = k_B K^2 \frac{d^2 f}{dK^2}` },
    labels: ["remark_physical_specific_heat"],
    statement: [
      paragraph([
        ref("specific_heat_log_divergence"),
        " は結合定数 ",
        math(String.raw`K`),
        " についての 2 階微分の発散を述べている。物理でいう比熱は温度についての 2 階微分だが、",
        "両者は次のように比例する。",
      ]),
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の ",
        math(String.raw`Z(J,J')`),
        " において、等方な場合の結合定数を",
      ]),
      displayMath(
        String.raw`K = \beta \mathcal{J},
\qquad \beta := \frac{1}{k_B T}`,
      ),
      paragraph([
        "と書く（",
        math(String.raw`\mathcal{J}`),
        " は相互作用の強さ、",
        math(String.raw`T`),
        " は絶対温度、",
        math(String.raw`k_B`),
        " は Boltzmann 定数。",
        math(String.raw`\mathcal{J}, k_B, T \in \mathbb{R}_{>0}`),
        "）。1 サイトあたりの内部エネルギー ",
        math(String.raw`u`),
        " と比熱 ",
        math(String.raw`C`),
        " は",
      ]),
      displayMath(
        String.raw`u := -\frac{\partial}{\partial\beta}f(K),
\qquad
C := \frac{\partial u}{\partial T}`,
      ),
      paragraph([
        "で定義される（",
        math(String.raw`f`),
        " は ",
        ref("specific_heat_log_divergence"),
        " の 1 サイトあたりの ",
        math(String.raw`\log Z`),
        " の極限）。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u &= -\mathcal{J}\,\frac{df}{dK}
   \quad (\because \tfrac{dK}{d\beta} = \mathcal{J} \text{ と合成関数の微分}) \\
\frac{\partial u}{\partial\beta} &= -\mathcal{J}^2\,\frac{d^2f}{dK^2}
   \quad (\because \text{もう一度 } \tfrac{dK}{d\beta} = \mathcal{J} \text{ を適用}) \\
\frac{d\beta}{dT} &= -\frac{1}{k_BT^2} = -k_B\beta^2
   \quad (\because \beta = \tfrac{1}{k_BT} \text{ の微分}) \\
C &= \frac{\partial u}{\partial\beta}\cdot\frac{d\beta}{dT}
   \quad (\because \text{合成関数の微分})
   = \left(-\mathcal{J}^2\frac{d^2f}{dK^2}\right)\left(-k_B\beta^2\right)
   = k_B\left(\beta\mathcal{J}\right)^2\frac{d^2f}{dK^2}
   = k_B K^2\,\frac{d^2f}{dK^2}
\end{aligned}`,
      ),
      paragraph([
        "**したがって比熱 ",
        math(String.raw`C`),
        " は ",
        math(String.raw`\dfrac{d^2f}{dK^2}`),
        " の正の定数倍（臨界点の近傍では ",
        math(String.raw`k_BK^2 \to k_BK_c^2 > 0`),
        "）であり、",
        ref("specific_heat_log_divergence"),
        " はそのまま比熱の対数発散",
      ]),
      displayMath(
        String.raw`C = k_BK^2\,\frac{d^2f}{dK^2}
= k_BK^2\left(\frac{8}{\pi}\log\frac{1}{\left|K-K_c\right|} + O\right),
\qquad |O| \leq 49`,
      ),
      paragraph([
        "を意味する。**",
        math(String.raw`K = \beta\mathcal{J}`),
        " は ",
        math(String.raw`T`),
        " の狭義単調減少関数なので、",
        math(String.raw`K \to K_c`),
        " と ",
        math(String.raw`T \to T_c := \dfrac{\mathcal{J}}{k_BK_c}`),
        " は同じことである。",
      ]),
      paragraph([
        "なお ",
        math(String.raw`2K_c = \log(1+\sqrt2)`),
        "（",
        ref("kappa_of_K_basic"),
        "）なので ",
        math(String.raw`\dfrac{\mathcal{J}}{k_BT_c} = K_c = \dfrac{\log(1+\sqrt2)}{2}`),
        " であり、これが Onsager の臨界温度である。",
      ]),
    ],
    conversion: { status: "added" },
  },
]);
