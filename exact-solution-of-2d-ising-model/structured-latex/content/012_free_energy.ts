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
      paragraph([
        "以下では、次を外部前提として用いる。有界閉区間 ",
        math(String.raw`[a,b] \subset \mathbb{R}`),
        " 上の連続実関数 ",
        math(String.raw`g`),
        " は一様連続である。すなわち任意の ",
        math(String.raw`\epsilon \in \mathbb{R}_{>0}`),
        " に対して ",
        math(String.raw`\eta \in \mathbb{R}_{>0}`),
        " が存在して、",
        math(String.raw`s,t \in [a,b]`),
        "、",
        math(String.raw`|s-t| \leq \eta`),
        " なら ",
        math(String.raw`|g(s)-g(t)| \leq \epsilon`),
        " である。",
      ]),
      paragraph(["また、有界閉区間上の連続実関数のRiemann可積分性、積分の線型性と区間加法性、定数の積分、および積分の絶対値が区間の長さと関数の絶対値の上限の積以下であることを、積分の基本性質として用いる。"]),
      paragraph(["この主張は積分・上限・極限を扱うので、現れる数はすべて ", math(String.raw`\mathbb{R}`), " の元である（", math(String.raw`\mathbb{R}`), " への脱出。上限の存在には ", math(String.raw`\mathbb{R}`), " の完備性を、整数の取り方には ", math(String.raw`\mathbb{R}`), " のアルキメデス性を使う）。"]),
      paragraph([
        "実数列 ",
        math(String.raw`(c_M)_{M \in \mathbb{Z}_{\geq 1}}`),
        " と ",
        math(String.raw`L \in \mathbb{R}`),
        " について ",
        math(String.raw`\lim_{M\to\infty} c_M = L`),
        " とは、任意の ",
        math(String.raw`\epsilon \in \mathbb{R}_{>0}`),
        " に対して ",
        math(String.raw`N \in \mathbb{Z}_{\geq 1}`),
        " が存在し、",
        math(String.raw`M \geq N`),
        " なら ",
        math(String.raw`|c_M - L| \leq \epsilon`),
        " となることをいう。",
      ]),
      paragraph([
        math(String.raw`g : \mathbb{R} \to \mathbb{R}`),
        " を連続関数とし、",
        math(String.raw`\delta \in [0,1]`),
        " を固定する（**周期性は仮定しない**）。",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " に対して",
      ]),
      displayMath(
        String.raw`t^{(M)}_\mu := \frac{2\pi(\mu-\delta)}{M} \in \mathbb{R} \qquad (\mu \in \{1,\dots,M\})`,
      ),
      paragraph(["とおく。このとき"]),
      displayMath(
        String.raw`\lim_{M\to\infty} \frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
= \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt`,
      ),
      paragraph([
        "が成り立つ。より詳しく、",
        math(String.raw`h \in \mathbb{R}_{>0}`),
        " に対して ",
        math(String.raw`g`),
        " の ",
        math(String.raw`[0,2\pi]`),
        " 上の連続度を",
      ]),
      displayMath(
        String.raw`\omega(h) := \sup\left\{\,|g(s)-g(t)| \ \middle|\ s,t \in [0,2\pi],\ |s-t| \leq h \,\right\}`,
      ),
      paragraph([
        "とおくと、",
        math(String.raw`\omega(h)`),
        " は ",
        math(String.raw`\mathbb{R}_{\geq 0}`),
        " の元として定まり",
      ]),
      displayMath(
        String.raw`\left|\frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
- \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt\right|
\ \leq\ \omega\!\left(\frac{2\pi}{M}\right)`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\omega(h) \to 0\ (h \to +0)`),
        "（任意の ",
        math(String.raw`\epsilon \in \mathbb{R}_{>0}`),
        " に対して ",
        math(String.raw`\eta \in \mathbb{R}_{>0}`),
        " が存在し、",
        math(String.raw`0 < h \leq \eta`),
        " なら ",
        math(String.raw`0 \leq \omega(h) \leq \epsilon`),
        "）である。",
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
        "Step 0（区間への分割）。",
        math(String.raw`g`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続なので、とくに有界閉区間 ",
        math(String.raw`[0,2\pi]`),
        " 上で連続であり、積分の基本性質 より ",
        math(String.raw`\int_0^{2\pi}g(t)\,dt \in \mathbb{R}`),
        " が定まる。",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " を固定し",
      ]),
      displayMath(
        String.raw`x_\nu := \frac{2\pi\nu}{M} \in \mathbb{R} \quad (\nu \in \{0,\dots,M\}),\qquad
I_\mu := \left[x_{\mu-1},\ x_\mu\right] \subset \mathbb{R} \quad (\mu \in \{1,\dots,M\})`,
      ),
      paragraph(["とおく。両端と区間の長さを確かめる。"]),
      displayMath(
        String.raw`\begin{aligned}
x_0&=\frac{2\pi\cdot0}{M}
&&\left(\because\ x_\nu\text{ の定義}\right)\\
&=0
&&\left(\because\ \mathbb{R}\text{ の四則}\right),\\[4pt]
x_M&=\frac{2\pi M}{M}
&&\left(\because\ x_\nu\text{ の定義}\right)\\
&=2\pi
&&\left(\because\ \mathbb{R}\text{ の四則}\right),\\[4pt]
x_\mu-x_{\mu-1}&=\frac{2\pi\mu}{M}-\frac{2\pi(\mu-1)}{M}
&&\left(\because\ x_\nu\text{ の定義}\right)\\
&=\frac{2\pi}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        "区間の長さを右端から左端を引いた数で定め、",
        math(String.raw`\operatorname{len}(I_\mu) := x_\mu - x_{\mu-1}`),
        " と書く。したがって ",
        math(String.raw`\operatorname{len}(I_\mu) = 2\pi/M > 0`),
        " であり、",
        math(String.raw`I_\mu`),
        " の右端 ",
        math(String.raw`x_\mu`),
        " は ",
        math(String.raw`I_{\mu+1}`),
        " の左端と同じ点である（",
        math(String.raw`\mu \in \{1,\dots,M-1\}`),
        "）。これらを使い、積分を区間ごとに分ける。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\int_0^{2\pi} g(t)\,dt
&=\int_{x_0}^{x_M} g(t)\,dt
&&\left(\because\ x_0=0,\ x_M=2\pi\right)\\
&=\sum_{\mu=1}^{M}\int_{x_{\mu-1}}^{x_\mu} g(t)\,dt
&&\left(\because\ x_\mu-x_{\mu-1}=2\pi/M>0\ \text{より }x_0<x_1<\dots<x_M\text{。積分の基本性質 の区間加法性}\right)\\
&=\sum_{\mu=1}^{M}\int_{I_\mu} g(t)\,dt
&&\left(\because\ I_\mu\text{ の定義}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`I_\mu \subset [0,2\pi]`),
        " であることを、両端について確かめる（",
        math(String.raw`2\pi/M > 0`),
        "、",
        math(String.raw`0 \leq \mu-1`),
        "、",
        math(String.raw`\mu \leq M`),
        " を使う）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0&=\frac{2\pi}{M}\cdot 0
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&\leq\frac{2\pi}{M}(\mu-1)
&&\left(\because\ 0\leq\mu-1\text{ の両辺に正の }2\pi/M\text{ を掛ける}\right)\\
&=x_{\mu-1}
&&\left(\because\ x_\nu\text{ の定義}\right),\\[4pt]
x_\mu&=\frac{2\pi}{M}\mu
&&\left(\because\ x_\nu\text{ の定義}\right)\\
&\leq\frac{2\pi}{M}M
&&\left(\because\ \mu\leq M\text{ の両辺に正の }2\pi/M\text{ を掛ける}\right)\\
&=2\pi
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        "Step 1（連続度が実数として定まること）。一様連続性 を ",
        math(String.raw`\epsilon = 1`),
        " で ",
        math(String.raw`[0,2\pi]`),
        " 上の ",
        math(String.raw`g`),
        " に適用し、",
        math(String.raw`s',t' \in [0,2\pi]`),
        "、",
        math(String.raw`|s'-t'| \leq \eta_1`),
        " なら ",
        math(String.raw`|g(s')-g(t')| \leq 1`),
        " となる ",
        math(String.raw`\eta_1 \in \mathbb{R}_{>0}`),
        " を取る。",
        math(String.raw`\mathbb{R}`),
        " のアルキメデス性より ",
        math(String.raw`K\eta_1 \geq 2\pi`),
        " となる ",
        math(String.raw`K \in \mathbb{Z}_{\geq 1}`),
        " を取る。",
        math(String.raw`s,t \in [0,2\pi]`),
        " を取る。まず ",
        math(String.raw`|t-s| \leq 2\pi`),
        " を、",
        math(String.raw`s \leq t`),
        " と ",
        math(String.raw`t < s`),
        " に分けて示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&s\leq t\text{ のとき}:\\
|t-s|&=t-s
&&\left(\because\ t-s\geq0\right)\\
&\leq2\pi-s
&&\left(\because\ t\leq2\pi\right)\\
&\leq2\pi-0
&&\left(\because\ 0\leq s\right)\\
&=2\pi
&&\left(\because\ \mathbb{R}\text{ の四則}\right),\\[4pt]
&t<s\text{ のとき}:\\
|t-s|&=s-t
&&\left(\because\ t-s<0\right)\\
&\leq2\pi-t
&&\left(\because\ s\leq2\pi\right)\\
&\leq2\pi-0
&&\left(\because\ 0\leq t\right)\\
&=2\pi
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`j \in \{0,\dots,K\}`),
        " に対して ",
        math(String.raw`u_j := \left(1-\tfrac{j}{K}\right)s + \tfrac{j}{K}\,t \in \mathbb{R}`),
        " とおく。",
        math(String.raw`0 \leq 1-\tfrac{j}{K}`),
        "、",
        math(String.raw`0 \leq \tfrac{j}{K}`),
        " と ",
        math(String.raw`0 \leq s \leq 2\pi`),
        "、",
        math(String.raw`0 \leq t \leq 2\pi`),
        " の各辺に非負の数を掛けて、準備として",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(1-\tfrac{j}{K}\right)0&\leq\left(1-\tfrac{j}{K}\right)s\leq\left(1-\tfrac{j}{K}\right)2\pi
&&\left(\because\ 0\leq s\leq2\pi\text{ の各辺に非負の }1-\tfrac{j}{K}\text{ を掛ける}\right),\\
\tfrac{j}{K}\,0&\leq\tfrac{j}{K}\,t\leq\tfrac{j}{K}\,2\pi
&&\left(\because\ 0\leq t\leq2\pi\text{ の各辺に非負の }\tfrac{j}{K}\text{ を掛ける}\right)
\end{aligned}`,
      ),
      paragraph(["を得る。これらを使い、", math(String.raw`u_j \in [0,2\pi]`), " を示す。"]),
      displayMath(
        String.raw`\begin{aligned}
0&=\left(1-\tfrac{j}{K}\right)0+\tfrac{j}{K}\,0
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&\leq\left(1-\tfrac{j}{K}\right)s+\tfrac{j}{K}\,0
&&\left(\because\ \text{準備の第一の左の不等式の両辺に }\tfrac{j}{K}\,0\text{ を足す}\right)\\
&\leq\left(1-\tfrac{j}{K}\right)s+\tfrac{j}{K}\,t
&&\left(\because\ \text{準備の第二の左の不等式の両辺に }\left(1-\tfrac{j}{K}\right)s\text{ を足す}\right)\\
&=u_j
&&\left(\because\ u_j\text{ の定義}\right),\\[4pt]
u_j&=\left(1-\tfrac{j}{K}\right)s+\tfrac{j}{K}\,t
&&\left(\because\ u_j\text{ の定義}\right)\\
&\leq\left(1-\tfrac{j}{K}\right)2\pi+\tfrac{j}{K}\,t
&&\left(\because\ \text{準備の第一の右の不等式の両辺に }\tfrac{j}{K}\,t\text{ を足す}\right)\\
&\leq\left(1-\tfrac{j}{K}\right)2\pi+\tfrac{j}{K}\,2\pi
&&\left(\because\ \text{準備の第二の右の不等式の両辺に }\left(1-\tfrac{j}{K}\right)2\pi\text{ を足す}\right)\\
&=2\pi
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`j \in \{0,\dots,K-1\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|u_{j+1}-u_j|&=\left|\frac{t-s}{K}\right|
&&\left(\because\ u_j\text{ の定義と }\mathbb{R}\text{ の四則}\right)\\
&=\frac{|t-s|}{K}
&&\left(\because\ K>0\text{ による絶対値の商}\right)\\
&\leq\frac{2\pi}{K}
&&\left(\because\ |t-s|\leq2\pi\text{ の両辺を正の }K\text{ で割る}\right)\\
&\leq\eta_1
&&\left(\because\ 2\pi\leq K\eta_1\text{ の両辺を正の }K\text{ で割る}\right)
\end{aligned}`,
      ),
      paragraph(["であり、", math(String.raw`u_0 = s`), "、", math(String.raw`u_K = t`), " だから"]),
      displayMath(
        String.raw`\begin{aligned}
|g(t)-g(s)|&=\left|\sum_{j=0}^{K-1}\bigl(g(u_{j+1})-g(u_j)\bigr)\right|
&&\left(\because\ \text{隣り合う項が打ち消し合う和}\right)\\
&\leq\sum_{j=0}^{K-1}\bigl|g(u_{j+1})-g(u_j)\bigr|
&&\left(\because\ \text{三角不等式}\right)\\
&\leq\sum_{j=0}^{K-1}1
&&\left(\because\ u_j,u_{j+1}\in[0,2\pi],\ |u_{j+1}-u_j|\leq\eta_1\text{ と }\eta_1\text{ の取り方}\right)\\
&=K
&&\left(\because\ 1\text{ の }K\text{ 個の和}\right).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\omega(h)`),
        " の定義の集合は上に ",
        math(String.raw`K`),
        " で抑えられる。",
        math(String.raw`s = t = 0`),
        " のとき ",
        math(String.raw`|g(0)-g(0)| = 0`),
        " なので、この集合は ",
        math(String.raw`0`),
        " を元に持ち、空でない。上限の存在（",
        math(String.raw`\mathbb{R}`),
        " の完備性）より ",
        math(String.raw`\omega(h) \in \mathbb{R}`),
        " が定まり、上限は元以上で上界以下なので ",
        math(String.raw`0 \leq \omega(h) \leq K`),
        " である。",
      ]),
      paragraph([
        "Step 2（代表点が区間に入ること）。",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " とする。",
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
        "を得る。これらを使い、代表点の左側と右側をそれぞれ評価する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x_{\mu-1}
&=x_{\mu-1}+0
&&\left(\because\ \mathbb{R}\text{ の加法単位元}\right)\\
&\leq x_{\mu-1}+\frac{2\pi}{M}(1-\delta)
&&\left(\because\ \text{準備の第一の不等式の両辺に }x_{\mu-1}\text{ を足す}\right)\\
&=\frac{2\pi(\mu-1)}{M}+\frac{2\pi}{M}(1-\delta)
&&\left(\because\ x_\nu\text{ の定義}\right)\\
&=\frac{2\pi(\mu-\delta)}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=t^{(M)}_\mu
&&\left(\because\ t^{(M)}_\mu\text{ の定義}\right),\\[4pt]
t^{(M)}_\mu&=\frac{2\pi(\mu-\delta)}{M}
&&\left(\because\ t^{(M)}_\mu\text{ の定義}\right)\\
&=\frac{2\pi(\mu-1)}{M}+\frac{2\pi}{M}(1-\delta)
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=x_{\mu-1}+\frac{2\pi}{M}(1-\delta)
&&\left(\because\ x_\nu\text{ の定義}\right)\\
&\leq x_{\mu-1}+\frac{2\pi}{M}
&&\left(\because\ \text{準備の第二の不等式の両辺に }x_{\mu-1}\text{ を足す}\right)\\
&=x_\mu
&&\left(\because\ \text{Step 0 の }x_\mu-x_{\mu-1}=2\pi/M\right).
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`t^{(M)}_\mu \in I_\mu`),
        " であり、Step 0 の ",
        math(String.raw`I_\mu \subset [0,2\pi]`),
        " より ",
        math(String.raw`t^{(M)}_\mu \in [0,2\pi]`),
        " である。",
        math(String.raw`t \in I_\mu`),
        " との距離を、",
        math(String.raw`t \geq t^{(M)}_\mu`),
        " と ",
        math(String.raw`t < t^{(M)}_\mu`),
        " に分けて評価する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&t\geq t^{(M)}_\mu\text{ のとき}:\\
\left|t-t^{(M)}_\mu\right|&=t-t^{(M)}_\mu
&&\left(\because\ t-t^{(M)}_\mu\geq0\right)\\
&\leq x_\mu-t^{(M)}_\mu
&&\left(\because\ t\leq x_\mu\ (t\in I_\mu)\right)\\
&\leq x_\mu-x_{\mu-1}
&&\left(\because\ x_{\mu-1}\leq t^{(M)}_\mu\ (t^{(M)}_\mu\in I_\mu)\right)\\
&=\frac{2\pi}{M}
&&\left(\because\ \text{Step 0}\right),\\[4pt]
&t< t^{(M)}_\mu\text{ のとき}:\\
\left|t-t^{(M)}_\mu\right|&=t^{(M)}_\mu-t
&&\left(\because\ t-t^{(M)}_\mu<0\right)\\
&\leq x_\mu-t
&&\left(\because\ t^{(M)}_\mu\leq x_\mu\ (t^{(M)}_\mu\in I_\mu)\right)\\
&\leq x_\mu-x_{\mu-1}
&&\left(\because\ x_{\mu-1}\leq t\ (t\in I_\mu)\right)\\
&=\frac{2\pi}{M}
&&\left(\because\ \text{Step 0}\right).
\end{aligned}`,
      ),
      paragraph([
        "Step 3（各区間での誤差）。",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " を固定する。",
        math(String.raw`t \in I_\mu`),
        " なら、",
        math(String.raw`t \in [0,2\pi]`),
        "（Step 0 の ",
        math(String.raw`I_\mu \subset [0,2\pi]`),
        "）、",
        math(String.raw`t^{(M)}_\mu \in [0,2\pi]`),
        "（Step 2）、",
        math(String.raw`\left|t-t^{(M)}_\mu\right| \leq 2\pi/M`),
        "（Step 2）なので、",
        math(String.raw`\left|g(t)-g\!\left(t^{(M)}_\mu\right)\right|`),
        " は ",
        math(String.raw`\omega(2\pi/M)`),
        " の定義の集合の元であり、",
        math(String.raw`\omega(2\pi/M)`),
        "（Step 1 で実数として定まった）以下である。",
        math(String.raw`t = t^{(M)}_\mu \in I_\mu`),
        " のとき値は ",
        math(String.raw`0`),
        " なので集合 ",
        math(String.raw`\left\{\left|g(t)-g\!\left(t^{(M)}_\mu\right)\right| \ \middle|\ t \in I_\mu\right\}`),
        " は空でなく、上限の存在より ",
        math(String.raw`\sup_{t\in I_\mu}\left|g(t)-g\!\left(t^{(M)}_\mu\right)\right| \in \mathbb{R}`),
        " が定まり、上限は上界以下なので ",
        math(String.raw`\omega(2\pi/M)`),
        " 以下である。また積分の基本性質 の定数の積分と Step 0 の ",
        math(String.raw`\operatorname{len}(I_\mu) = 2\pi/M`),
        " より ",
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
&&\left(\because\ \left|\int_If\right|\leq \operatorname{len}(I)\sup_I|f|\text{ を }f:=g-g\!\left(t^{(M)}_\mu\right),\ I:=I_\mu,\ \operatorname{len}(I_\mu)=\tfrac{2\pi}{M}\text{ で}\right)\\
\leq{}&\frac{2\pi}{M}\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \text{上の上限は }\omega(2\pi/M)\text{ 以下で、両辺に正の }\tfrac{2\pi}{M}\text{ を掛ける}\right).
\end{aligned}`,
      ),
      paragraph(["Step 4（総和）。全区間にわたる誤差を一続きに評価する。"]),
      displayMath(
        String.raw`\begin{aligned}
&\left|\int_0^{2\pi} g(t)\,dt - \frac{2\pi}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)\right|\\
={}&\left|\sum_{\mu=1}^{M}\int_{I_\mu}g(t)\,dt - \frac{2\pi}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \text{Step 0 の積分を区間ごとに分けた式}\right)\\
={}&\left|\sum_{\mu=1}^{M}\int_{I_\mu}g(t)\,dt - \sum_{\mu=1}^{M}\frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \text{分配法則}\right)\\
={}&\left|\sum_{\mu=1}^{M}\left(\int_{I_\mu}g(t)\,dt - \frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right)\right|
&&\left(\because\ \text{和の差は差の和}\right)\\
\leq{}&\sum_{\mu=1}^{M}\left|\int_{I_\mu}g(t)\,dt - \frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \text{三角不等式}\right)\\
\leq{}&\sum_{\mu=1}^{M}\frac{2\pi}{M}\,\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \text{Step 3 の評価}\right)\\
={}&M\cdot\frac{2\pi}{M}\,\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \mu\text{ に依らない同一の項の }M\text{ 個の和}\right)\\
={}&2\pi\,\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph(["Step 5（主張の評価）。主張の左辺から始めて評価する。"]),
      displayMath(
        String.raw`\begin{aligned}
&\left|\frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right) - \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt\right|\\
={}&\left|\frac{1}{2\pi}\cdot\frac{2\pi}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right) - \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt\right|
&&\left(\because\ \tfrac{1}{M}=\tfrac{1}{2\pi}\cdot\tfrac{2\pi}{M}\right)\\
={}&\left|\frac{1}{2\pi}\left(\frac{2\pi}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right) - \int_{0}^{2\pi} g(t)\,dt\right)\right|
&&\left(\because\ \text{分配法則}\right)\\
={}&\frac{1}{2\pi}\left|\frac{2\pi}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right) - \int_{0}^{2\pi} g(t)\,dt\right|
&&\left(\because\ |cy|=c|y|\ (c=\tfrac{1}{2\pi}>0)\right)\\
={}&\frac{1}{2\pi}\left|\int_{0}^{2\pi} g(t)\,dt - \frac{2\pi}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ |-y|=|y|\right)\\
\leq{}&\frac{1}{2\pi}\cdot2\pi\,\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \text{Step 4 の評価の両辺に正の }\tfrac{1}{2\pi}\text{ を掛ける}\right)\\
={}&\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        "Step 6（収束）。",
        math(String.raw`\epsilon \in \mathbb{R}_{>0}`),
        " を任意に取る。一様連続性 を ",
        math(String.raw`[0,2\pi]`),
        " 上の ",
        math(String.raw`g`),
        " に適用し、",
        math(String.raw`s,t \in [0,2\pi]`),
        "、",
        math(String.raw`|s-t| \leq \eta_0`),
        " なら ",
        math(String.raw`|g(s)-g(t)| \leq \epsilon`),
        " となる ",
        math(String.raw`\eta_0 \in \mathbb{R}_{>0}`),
        " を取る。",
        math(String.raw`0 < h \leq \eta_0`),
        " なら、",
        math(String.raw`\omega(h)`),
        " の定義の集合の元 ",
        math(String.raw`|g(s)-g(t)|`),
        "（",
        math(String.raw`|s-t| \leq h \leq \eta_0`),
        "）はすべて ",
        math(String.raw`\epsilon`),
        " 以下なので、上限は上界以下であることと Step 1 より ",
        math(String.raw`0 \leq \omega(h) \leq \epsilon`),
        " である。これで ",
        math(String.raw`\omega(h) \to 0\ (h \to +0)`),
        " が示せた。次に ",
        math(String.raw`N := \lfloor 2\pi/\eta_0 \rfloor + 1 \in \mathbb{Z}_{\geq 1}`),
        "（",
        math(String.raw`\lfloor y \rfloor`),
        " は ",
        math(String.raw`y`),
        " 以下の最大の整数。",
        math(String.raw`\mathbb{R}`),
        " のアルキメデス性で定まる）とおく。",
        math(String.raw`M \geq N`),
        " なる ",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
M&\geq\left\lfloor\frac{2\pi}{\eta_0}\right\rfloor+1
&&\left(\because\ M\geq N\text{ と }N\text{ の定義}\right)\\
&>\frac{2\pi}{\eta_0}
&&\left(\because\ y<\lfloor y\rfloor+1\right),\\[4pt]
\frac{2\pi}{M}&=\frac{\eta_0}{M}\cdot\frac{2\pi}{\eta_0}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&<\frac{\eta_0}{M}\cdot M
&&\left(\because\ \tfrac{2\pi}{\eta_0}<M\text{ の両辺に正の }\tfrac{\eta_0}{M}\text{ を掛ける}\right)\\
&=\eta_0
&&\left(\because\ \mathbb{R}\text{ の四則}\right)
\end{aligned}`,
      ),
      paragraph(["なので"]),
      displayMath(
        String.raw`\begin{aligned}
\left|\frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
- \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt\right|
&\leq\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \text{Step 5 の評価}\right)\\
&\leq\epsilon
&&\left(\because\ 0<2\pi/M<\eta_0\text{ と上の }\omega\text{ の評価}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon \in \mathbb{R}_{>0}`),
        " は任意だったので、主張の前に置いた極限の意味で、主張の極限が成り立つ。",
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
        " に属するので Step 3 の評価がそのまま通る。",
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
        "2026-11-01: SageMath の検算（sagemath/check/riemann_sum_to_integral/）を付けるにあたり、ω(h) が実数として定まること（定義の集合が上に有界）を一様連続性から示す段を足し、I_μ ⊂ [0,2π]、t ∈ I_μ と代表点の距離、主張の評価（2π で割る段）を (∵) 付きの鎖にした。現れる数が ℝ の元であること（積分・上限・極限のための ℝ への脱出）を主張に書いた。",
        "収束の速さは γ の連続度に支配される。臨界点（sinh 2K_1 sinh 2K_2 = 1）では γ(θ) が θ = 0 の近くで |θ| のオーダーでしか小さくならず、連続度が Lipschitz より悪くなるため収束が遅い。数値でも臨界点だけ収束が遅いことを確認している（sagemath/check/045_claim_free_energy/check_02_riemann_sum.sage）。",
      ],
    },
  },
]);
