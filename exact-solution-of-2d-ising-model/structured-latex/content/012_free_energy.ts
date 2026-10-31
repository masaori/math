import { defineBlocks, paragraph, math, displayMath } from "../schema.ts";

const SRC = "structured-latex/content/012_free_energy.ts";

export default defineBlocks([
  {
    id: "heading_free_energy",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "等間隔点の平均の積分への収束" },
    labels: [],
  },

  {
    id: "freeenergy_004_theorem_riemann_sum_to_integral",
    kind: "theorem",
    origin: { path: SRC, ordinal: 6 },
    title: { text: "等間隔点の平均は積分に収束する" },
    labels: ["riemann_sum_to_integral"],
    statement: [
      paragraph(["以下では、有界閉区間上の連続実関数は一様連続であることを外部前提として用いる。"]),
      paragraph(["また、有界閉区間上の連続実関数のRiemann可積分性、積分の線型性と区間加法性、定数の積分、および積分の絶対値が区間の長さと関数の絶対値の上限の積以下であることを、積分の基本性質として用いる。"]),
      paragraph([
        math(String.raw`g : \mathbb{R} \to \mathbb{R}`),
        " を連続関数とし、",
        math(String.raw`\delta \in [0,1]`),
        " を固定する（**周期性は仮定しない**）。",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " に対して",
      ]),
      displayMath(
        String.raw`t^{(M)}_\mu := \frac{2\pi(\mu-\delta)}{M} \qquad (\mu = 1,\dots,M)`,
      ),
      paragraph(["とおく。このとき"]),
      displayMath(
        String.raw`\lim_{M\to\infty} \frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
= \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt`,
      ),
      paragraph([
        "が成り立つ。より詳しく、",
        math(String.raw`g`),
        " の ",
        math(String.raw`[0,2\pi]`),
        " 上の連続度を",
      ]),
      displayMath(
        String.raw`\omega(h) := \sup\left\{\,|g(s)-g(t)| \ \middle|\ s,t \in [0,2\pi],\ |s-t| \leq h \,\right\}`,
      ),
      paragraph(["とおくと"]),
      displayMath(
        String.raw`\left|\frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
- \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt\right|
\ \leq\ \omega\!\left(\frac{2\pi}{M}\right)`,
      ),
      paragraph([
        "であり、一様連続性 より ",
        math(String.raw`\omega(h) \to 0\ (h \to +0)`),
        " なので右辺は ",
        math(String.raw`0`),
        " に収束する。",
      ]),
      paragraph([
        "とくに ",
        math(String.raw`\delta = 0`),
        "（整数点 ",
        math(String.raw`2\pi\mu/M`),
        "）と ",
        math(String.raw`\delta = 1/2`),
        "（半整数点 ",
        math(String.raw`2\pi(\mu-\tfrac12)/M`),
        "）のどちらでも、極限は同じ値である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（設定）。",
        math(String.raw`g`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続なので、とくに有界閉区間 ",
        math(String.raw`[0,2\pi]`),
        " 上で連続であり、積分の基本性質 より ",
        math(String.raw`\int_0^{2\pi}g(t)\,dt`),
        " が定まる。",
        math(String.raw`M`),
        " を固定し",
      ]),
      displayMath(
        String.raw`I_\mu := \left[\frac{2\pi(\mu-1)}{M},\ \frac{2\pi\mu}{M}\right] \qquad (\mu = 1,\dots,M)`,
      ),
      paragraph([
        "とおく。これらは ",
        math(String.raw`[0,2\pi]`),
        " を長さ ",
        math(String.raw`2\pi/M`),
        " の ",
        math(String.raw`M`),
        " 個の区間に分割したものであり、積分の基本性質 の区間加法性より",
      ]),
      displayMath(
        String.raw`\int_0^{2\pi} g(t)\,dt = \sum_{\mu=1}^{M}\int_{I_\mu} g(t)\,dt`,
      ),
      paragraph([
        "Step 1（代表点が区間に入ること）。",
        math(String.raw`\delta \in [0,1]`),
        " より ",
        math(String.raw`0 \leq 1-\delta \leq 1`),
        " である。",
        math(String.raw`2\pi/M > 0`),
        " を用いると、準備として",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0&\leq\frac{2\pi}{M}(1-\delta)
&&\left(\because\ 0\leq1-\delta\text{ の両辺に正の }2\pi/M\text{ を掛ける}\right),\\
\frac{2\pi}{M}(1-\delta)&\leq\frac{2\pi}{M}
&&\left(\because\ 1-\delta\leq1\text{ の両辺に正の }2\pi/M\text{ を掛ける}\right)
\end{aligned}`,
      ),
      paragraph([
        "を得る。これらを使い、代表点の両側を一続きに評価する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{2\pi(\mu-1)}{M}
&=\frac{2\pi(\mu-1)}{M}+0
&&\left(\because\ \mathbb{R}\text{ の加法単位元}\right)\\
&\leq\frac{2\pi(\mu-1)}{M}+\frac{2\pi}{M}(1-\delta)
&&\left(\because\ \text{準備の第一の不等式の両辺に }2\pi(\mu-1)/M\text{ を足す}\right)\\
&=\frac{2\pi(\mu-\delta)}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&\leq\frac{2\pi(\mu-1)}{M}+\frac{2\pi}{M}
&&\left(\because\ \text{準備の第二の不等式の両辺に }2\pi(\mu-1)/M\text{ を足す}\right)\\
&=\frac{2\pi\mu}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`t^{(M)}_\mu \in I_\mu`),
        "。したがって ",
        math(String.raw`t \in I_\mu`),
        " なら ",
        math(String.raw`\left|t - t^{(M)}_\mu\right| \leq \dfrac{2\pi}{M}`),
        "（同じ長さ ",
        math(String.raw`2\pi/M`),
        " の区間に属する 2 点の距離）。",
      ]),
      paragraph([
        "Step 2（各区間での誤差）。",
        math(String.raw`\mu`),
        " を固定する。積分の基本性質 の定数の積分より ",
        math(String.raw`\int_{I_\mu} g\!\left(t^{(M)}_\mu\right)dt = \dfrac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)`),
        " である。各区間での誤差を一続きに評価する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\left|\int_{I_\mu}g(t)\,dt-\frac{2\pi}{M}g\!\left(t^{(M)}_\mu\right)\right|\\
={}&\left|\int_{I_\mu}g(t)\,dt-\int_{I_\mu}g\!\left(t^{(M)}_\mu\right)dt\right|
&&\left(\because\ \text{積分の基本性質 の定数の積分}\right)\\
={}&\left|\int_{I_\mu}\left(g(t)-g\!\left(t^{(M)}_\mu\right)\right)dt\right|
&&\left(\because\ \text{積分の線型性}\right)\\
\leq{}&\frac{2\pi}{M}\sup_{t\in I_\mu}\left|g(t)-g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \left|\int_Ih\right|\leq |I|\sup_I|h|\right)\\
\leq{}&\frac{2\pi}{M}\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \text{Step 1 と }\omega\text{ の定義}\right).
\end{aligned}`,
      ),
      paragraph(["Step 3（総和）。全区間にわたる誤差を一続きに評価する。"]),
      displayMath(
        String.raw`\begin{aligned}
&\left|\int_0^{2\pi} g(t)\,dt - \frac{2\pi}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)\right|\\
={}&\left|\sum_{\mu=1}^{M}\int_{I_\mu}g(t)\,dt - \sum_{\mu=1}^{M}\frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \text{Step 0 の区間加法性}\right)\\
={}&\left|\sum_{\mu=1}^{M}\left(\int_{I_\mu}g(t)\,dt - \frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right)\right|
&&\left(\because\ \text{和の差は差の和}\right)\\
\leq{}&\sum_{\mu=1}^{M}\left|\int_{I_\mu}g(t)\,dt - \frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \text{三角不等式}\right)\\
\leq{}&\sum_{\mu=1}^{M}\frac{2\pi}{M}\,\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \text{Step 2 の評価}\right)\\
={}&2\pi\,\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \mu\text{ に依らない同一の項の }M\text{ 個の和}\right).
\end{aligned}`,
      ),
      paragraph([
        "両辺を ",
        math(String.raw`2\pi > 0`),
        " で割ると statement の評価を得る。",
      ]),
      paragraph([
        "Step 4（収束）。一様連続性 を ",
        math(String.raw`[0,2\pi]`),
        " 上の連続関数 ",
        math(String.raw`g`),
        " に適用する。任意の ",
        math(String.raw`\epsilon > 0`),
        " に対して ",
        math(String.raw`\delta_0 > 0`),
        " が存在して、",
        math(String.raw`s,t \in [0,2\pi]`),
        "、",
        math(String.raw`|s-t| \leq \delta_0`),
        " なら ",
        math(String.raw`|g(s)-g(t)| \leq \epsilon`),
        " である。これは ",
        math(String.raw`h \leq \delta_0`),
        " なら ",
        math(String.raw`\omega(h) \leq \epsilon`),
        " を意味する。",
        math(String.raw`M > 2\pi/\delta_0`),
        " なら ",
        math(String.raw`2\pi/M < \delta_0`),
        " なので ",
        math(String.raw`\omega(2\pi/M) \leq \epsilon`),
        "。",
      ]),
      paragraph([
        "したがって Step 3 の評価より、",
        math(String.raw`M > 2\pi/\delta_0`),
        " なる ",
        math(String.raw`M`),
        " について",
      ]),
      displayMath(
        String.raw`\left|\frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
- \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt\right| \leq \epsilon`,
      ),
      paragraph([
        math(String.raw`\epsilon > 0`),
        " は任意だったので、主張の極限が成り立つ。",
      ]),
      paragraph([
        "（証明で ",
        math(String.raw`g`),
        " について使ったのは、有界閉区間 ",
        math(String.raw`[0,2\pi]`),
        " 上の連続性だけである。",
        math(String.raw`\delta = 0`),
        " のとき代表点 ",
        math(String.raw`t^{(M)}_M = 2\pi`),
        " は区間 ",
        math(String.raw`I_M`),
        " の右端、",
        math(String.raw`\delta = 1`),
        " のとき ",
        math(String.raw`t^{(M)}_1 = 0`),
        " は ",
        math(String.raw`I_1`),
        " の左端であり、どちらも ",
        math(String.raw`[0,2\pi]`),
        " に属するので Step 2 の評価がそのまま通る。",
        math(String.raw`g(2\pi)`),
        " と ",
        math(String.raw`g(0)`),
        " を比べる必要はどこにも生じない。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "delta ∈ [0,1] を許すことで、整数点（delta = 0、V^{(-)} セクター）と半整数点（delta = 1/2、V^{(+)} セクター）の両方を 1 つの主張で扱える。どちらでも極限が同じであることが、熱力学極限でセクターの区別が消える理由である。",
        "収束の速さは γ の連続度に支配される。臨界点（sinh 2K_1 sinh 2K_2 = 1）では γ(θ) が θ = 0 の近くで |θ| のオーダーでしか小さくならず、連続度が Lipschitz より悪くなるため収束が遅い。数値でも臨界点だけ収束が遅いことを確認している（sagemath/check/045_claim_free_energy/check_02_riemann_sum.sage）。",
      ],
    },
  },
]);
