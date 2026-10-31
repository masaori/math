import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

const SRC = "structured-latex/content/011_max_eigenvalue.ts";

export default defineBlocks([
  {
    id: "heading_max_eigenvalue",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "半正定値双線型形式の Cauchy–Schwarz の不等式" },
    labels: [],
  },

  {
    id: "maxeig_005_claim_psd_cauchy_schwarz",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "半正定値双線型形式の Cauchy–Schwarz の不等式" },
    labels: ["psd_cauchy_schwarz"],
    statement: [
      paragraph(["成分積は ", ref("mat_mult"), " の式を実数成分について用い、複素数への包含は ", ref("inclusion_rr_to_cc"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        " が対称かつ半正定値（",
        math(String.raw`\forall x \in \mathbb{R}^n : x^\top P x \geq 0`),
        "）とする。このとき任意の ",
        math(String.raw`x, y \in \mathbb{R}^n`),
        " について",
      ]),
      displayMath(
        String.raw`\left(y^\top P x\right)^2 \leq \left(x^\top P x\right)\left(y^\top P y\right)`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`t \in \mathbb{R}`),
        " について ",
        math(String.raw`q(t) := (y + t x)^\top P (y + t x)`),
        " と置く。半正定値性により、すべての ",
        math(String.raw`t\in\mathbb{R}`),
        " について ",
        math(String.raw`0\leq q(t)`),
        " である。対称性を使って展開すると",
      ]),
      displayMath(String.raw`\begin{aligned}
q(t)
&=(y+t x)^\top P(y+t x)
&&\bigl(\because\ q(t)\ \text{の定義}\bigr)\\
&=y^\top Py+t\,y^\top Px+t\,x^\top Py+t^2x^\top Px
&&\bigl(\because\ \text{転置・行列積の分配法則}\bigr)\\
&=y^\top Py+2t\,y^\top Px+t^2x^\top Px
&&\bigl(\because\ P^\top=P\ \text{より}\ x^\top Py=y^\top Px\bigr)\\
&=(x^\top Px)t^2+2(y^\top Px)t+y^\top Py
&&\bigl(\because\ \mathbb{R}\ \text{の加法と乗法の可換則}\bigr)
\end{aligned}`),
      paragraph([
        "(i) ",
        math(String.raw`a := x^\top Px > 0`),
        " のとき。",
        math(String.raw`b:=y^\top Px`),
        " と置き、",
        math(String.raw`t=-b/a`),
        " を上の式へ代入すると",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&\leq q(-b/a)
&&\bigl(\because\ P\ \text{の半正定値性}\bigr)\\
&=a\left(-\frac{b}{a}\right)^2+2b\left(-\frac{b}{a}\right)+y^\top Py
&&\bigl(\because\ \text{上の}\ q(t)\ \text{の表示へ}\ t=-b/a\ \text{を代入}\bigr)\\
&=\frac{b^2}{a}-\frac{2b^2}{a}+y^\top Py
&&\bigl(\because\ a>0\ \text{より}\ a\neq0\bigr)\\
&=y^\top Py-\frac{b^2}{a}
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\frac{b^2}{a}
&\leq y^\top Py
&&\bigl(\because\ 0\leq y^\top Py-b^2/a\ \text{の移項}\bigr)\\
b^2
&\leq a\,(y^\top Py)
&&\bigl(\because\ a>0\ \text{を両辺へ掛ける}\bigr)
\end{aligned}`),
      paragraph([
        "(ii) ",
        math(String.raw`a = 0`),
        " のとき。",
        math(String.raw`b:=y^\top Px`),
        " と置くと、すべての ",
        math(String.raw`t\in\mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
q(t)
&=2bt+y^\top Py
&&\bigl(\because\ \text{上の}\ q(t)\ \text{の表示と}\ a=0\bigr)\\
0
&\leq q(t)
&&\bigl(\because\ P\ \text{の半正定値性}\bigr)
\end{aligned}`),
      paragraph([math(String.raw`b\neq0`), " と仮定し、", math(String.raw`t_0:=-(y^\top Py+1)/(2b)`), " と置くと"]),
      displayMath(String.raw`\begin{aligned}
q(t_0)
&=2b\left(-\frac{y^\top Py+1}{2b}\right)+y^\top Py
&&\bigl(\because\ q(t)=2bt+y^\top Py\ \text{へ}\ t=t_0\ \text{を代入}\bigr)\\
&=-(y^\top Py+1)+y^\top Py
&&\bigl(\because\ b\neq0\bigr)\\
&=-1
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)\\
&<0
&&\bigl(\because\ -1<0\bigr)
\end{aligned}`),
      paragraph(["これは半正定値性と矛盾するので ", math(String.raw`b=0`), " である。したがって"]),
      displayMath(String.raw`\begin{aligned}
(y^\top Px)^2
&=b^2
&&\bigl(\because\ b=y^\top Px\bigr)\\
&=0
&&\bigl(\because\ b=0\bigr)\\
&=(x^\top Px)(y^\top Py)
&&\bigl(\because\ a=x^\top Px=0\bigr)
\end{aligned}`),
    ],
    conversion: { status: "added" },
  },
]);
