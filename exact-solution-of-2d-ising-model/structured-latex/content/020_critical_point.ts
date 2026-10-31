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
    title: { text: "積分の評価で持ち込む実数解析の事実（(R3)・(R4)）" },
    labels: ["remark_real_analysis_facts_R3_R4"],
    statement: [
      paragraph([
        "以下の ",
        ref("cosh_addition_and_half_angle"),
        "・",
        ref("elementary_sine_bounds"),
        "・",
        ref("closed_form_log_integral"),
        "・",
        ref("sine_integral_two_sided"),
        " は、実数の区間上の連続関数の積分を扱うので、次の 2 つの実数解析の事実を外部から持ち込む。",
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
      ]),
      paragraph(["どの段でどれを使うかは次のとおりである。"]),
      list([
        [
          "(R3) は ",
          ref("cosh_addition_and_half_angle"),
          " (5)、",
          ref("elementary_sine_bounds"),
          "、",
          ref("sine_integral_two_sided"),
          " で、被積分関数の各点評価を積分へ持ち上げる段と積分を足し合わせる段に使う。",
        ],
        [
          "(R4) は ",
          ref("cosh_addition_and_half_angle"),
          " (5)、",
          ref("elementary_sine_bounds"),
          "、",
          ref("closed_form_log_integral"),
          "、",
          ref("sine_integral_two_sided"),
          " で、導関数が分かっている関数の積分値を求める段に使う。",
        ],
      ]),
      paragraph([
        "**これ以外の解析的道具（広義積分、一様収束、優収束、実解析性、平均値の定理）は使わない。**",
        "とくに以下の 4 項に現れる積分はすべて有界閉区間上の連続関数の積分であり、広義積分は現れない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、臨界点の章の注記 remark_real_analysis_escape_chapter_E から、数学的道具立ての章に残った 4 項が使う (R3)(R4) の宣言を、その文面のまま分けて置いた。",
      ],
    },
  },

  {
    id: "critical_001_claim_cosh_addition_and_half_angle",
    kind: "claim",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\cosh,\sinh \text{ の加法定理・半角公式と } \mathrm{arcsinh}` },
    labels: ["cosh_addition_and_half_angle"],
    statement: [
      paragraph(["非負実数の平方根は ", ref("definition_of_sqrt_r_positive"), " を使う。"]),
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
&= \frac{\left(\exp(x)+\exp(-x)\right)\left(\exp(y)+\exp(-y)\right)}{4}
 + \frac{\left(\exp(x)-\exp(-x)\right)\left(\exp(y)-\exp(-y)\right)}{4}
   &&(\because \text{cosh\_sinh\_basic\_properties の定義}) \\
&= \frac{\left(\exp(x+y)+\exp(x-y)+\exp(-x+y)+\exp(-x-y)\right)
       + \left(\exp(x+y)-\exp(x-y)-\exp(-x+y)+\exp(-x-y)\right)}{4}
   &&(\because \exp(a)\exp(b)=\exp(a+b)) \\
&= \frac{2\exp(x+y)+2\exp(-(x+y))}{4} \\
&= \frac{\exp(x+y)+\exp(-(x+y))}{2} \\
&= \cosh(x+y)
   &&(\because \text{cosh\_sinh\_basic\_properties の定義})
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
   &&(\because \text{cosh\_addition\_and\_half\_angle (1)}) \\
&= \left(1 + \sinh^2\!\left(\tfrac{x}{2}\right)\right) + \sinh^2\!\left(\tfrac{x}{2}\right)
   &&(\because \text{cosh\_sinh\_basic\_properties (2)}) \\
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
        math(String.raw`\exp(x) < \exp(y)`),
        " かつ ",
        math(String.raw`\exp(-x) > \exp(-y)`),
        "。よって",
      ]),
      displayMath(
        String.raw`\sinh x = \frac{\exp(x)-\exp(-x)}{2} < \frac{\exp(y)-\exp(-y)}{2} = \sinh y`,
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
\exp(-u)
&= \frac{1}{y+\sqrt{y^2+1}} \\
&= \frac{\sqrt{y^2+1}-y}{\left(\sqrt{y^2+1}+y\right)\left(\sqrt{y^2+1}-y\right)}
   &&(\because \text{分母の有理化}) \\
&= \frac{\sqrt{y^2+1}-y}{\left(y^2+1\right)-y^2} \\
&= \sqrt{y^2+1}-y
\end{aligned}`,
      ),
      paragraph(["であるから"]),
      displayMath(
        String.raw`\sinh u
= \frac{\exp(u)-\exp(-u)}{2}
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
   &&(\because \log \text{ と } \sqrt{\ } \text{ の微分・合成関数の微分}) \\
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
    conversion: {
      status: "added",
      notes: [
        "2026-09-01 の式変形統一で、(1)(2)(4) の四本の鎖にあった根拠 7 行を行中の \\quad (\\because …) から" +
          "行末の根拠列（aligned の &&）へ揃えた。式変形・根拠・段数・参照は変えていない。",
      ],
    },
  },

  {
    id: "critical_008_claim_elementary_sine_bounds",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`0 \leq \tfrac{\theta}{2} - \sin\tfrac{\theta}{2} \leq \tfrac{\theta^3}{48} \quad (0 \leq \theta \leq \pi)` },
    labels: ["elementary_sine_bounds"],
    statement: [
      paragraph(["正弦・余弦は ", ref("def_sin"), "、", ref("def_cos"), " のものを用いる。"]),
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
        String.raw`\begin{aligned}
t-\sin t
&=\int_0^t(1-\cos v)\,dv
&& (\because \text{(R4) を }F(t)=t-\sin t\text{ に適用}) \\
&\geq\int_0^t0\,dv
&& (\because 1-\cos v\geq0\text{ と (R3) の単調性}) \\
&=0
&& (\because \text{零関数の積分})
\end{aligned}`,
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
        String.raw`\begin{aligned}
\cos t-1+\frac{t^2}{2}
&=\int_0^t(u-\sin u)\,du
&& (\because \text{(R4) と }(\cos t-1+t^2/2)'=t-\sin t) \\
&\geq\int_0^t0\,du
&& (\because \text{Step 1 と (R3) の単調性}) \\
&=0
&& (\because \text{零関数の積分})
\end{aligned}
\qquad (t\geq0)`,
      ),
      paragraph(["次に、これを被積分関数として"]),
      displayMath(
        String.raw`\begin{aligned}
\sin t-t+\frac{t^3}{6}
&=\int_0^t\left(\cos v-1+\frac{v^2}{2}\right)dv
&& (\because \text{(R4) と }(\sin t-t+t^3/6)'=\cos t-1+t^2/2) \\
&\geq\int_0^t0\,dv
&& (\because \text{直前の非負性と (R3) の単調性}) \\
&=0
&& (\because \text{零関数の積分})
\end{aligned}
\qquad (t\geq0)`,
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
        String.raw`\begin{aligned}
0
&\leq\frac{\theta}{2}-\sin\frac{\theta}{2}
&& (\because \text{Step 1 を }t=\theta/2\text{ に適用}) \\
&\leq\frac{1}{6}\left(\frac{\theta}{2}\right)^3
&& (\because \text{Step 2 を }t=\theta/2\text{ に適用}) \\
&=\frac{\theta^3}{48}
&& (\because \mathbb R\text{ の四則})
\end{aligned}`,
      ),
      paragraph(["また"]),
      displayMath(
        String.raw`\begin{aligned}
\sin\frac{\theta}{2}
&\geq \frac{\theta}{2} - \frac{1}{6}\left(\frac{\theta}{2}\right)^3
&& (\because \text{Step 2}) \\
&= \frac{\theta}{2}\left(1 - \frac{1}{6}\left(\frac{\theta}{2}\right)^2\right)
&& (\because \mathbb R\text{ の分配則}) \\
&\geq \frac{\theta}{2}\left(1 - \frac{1}{6}\cdot\frac{\pi^2}{4}\right)
&& (\because 0 \leq \tfrac{\theta}{2} \leq \tfrac{\pi}{2}) \\
&= c_0\,\frac{\theta}{2}
&& (\because c_0=1-\pi^2/24\text{ の定義と }\mathbb R\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`c_0`),
        " の数値評価は ",
        math(String.raw`9.8696 \leq \pi^2 \leq 9.8697`),
        " を使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
c_0
&=1-\frac{\pi^2}{24}
&& (\because c_0\text{ の定義})\\
&\geq 1-\frac{9.8697}{24}
&& (\because \pi^2\leq9.8697)\\
&\geq 0.5887
&& (\because \mathbb R\text{ の四則}).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
c_0
&=1-\frac{\pi^2}{24}
&& (\because c_0\text{ の定義})\\
&\leq 1-\frac{9.8696}{24}
&& (\because 9.8696\leq\pi^2)\\
&\leq 0.5888
&& (\because \mathbb R\text{ の四則}).
\end{aligned}`),
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
      paragraph(["非負実数の平方根は ", ref("definition_of_sqrt_r_positive"), " を用いる。"]),
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
      paragraph(["平方根と正弦は ", ref("definition_of_sqrt_r_positive"), "、", ref("def_sin"), " を用いる。"]),
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
        " との差が有界に留まる。",
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
]);
