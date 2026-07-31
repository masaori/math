import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_calculation_formulae",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 1 },
    title: { text: "計算公式" },
    labels: [],
  },
  {
    id: "calc_formulae_000_cosh_sinh_product",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/000_theorem_cosh_sinhの掛け算.typ", ordinal: 1 },
    title: { tex: "\\cosh,\\sinh\\text{の掛け算}" },
    labels: [],
    statement: [
      displayMath("\\forall a,b\\in\\mathbb{R}"),
      displayMath(String.raw`\begin{aligned}
\cosh(a)\sinh(b) &= \frac{1}{2}\left(\sinh(a+b)-\sinh(a-b)\right) \\
\cosh(a)\cosh(b) &= \frac{1}{2}\left(\cosh(a+b)+\cosh(a-b)\right)
\end{aligned}`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\cosh(a)\sinh(b)
&=
\frac{\exp(a)+\exp(-a)}{2}
\frac{\exp(b)-\exp(-b)}{2}
\\
&=
\frac{1}{4}
\left(
\left(\exp(a)\exp(b)-\exp(-a)\exp(-b)\right)
-
\left(\exp(a)\exp(-b)-\exp(-a)\exp(b)\right)
\right)
\\
&=
\frac{1}{2}
\left(
\frac{\exp(a+b)-\exp(-(a+b))}{2}
-
\frac{\exp(a-b)-\exp(-(a-b))}{2}
\right)
\\
&=
\frac{1}{2}
\left(
\sinh(a+b)-\sinh(a-b)
\right)
\\
\cosh(a)\cosh(b)
&=
\frac{\exp(a)+\exp(-a)}{2}
\frac{\exp(b)+\exp(-b)}{2}
\\
&=
\frac{1}{4}
\left(
\left(\exp(a)\exp(b)+\exp(-a)\exp(-b)\right)
+
\left(\exp(a)\exp(-b)+\exp(-a)\exp(b)\right)
\right)
\\
&=
\frac{1}{2}
\left(
\frac{\exp(a+b)+\exp(-(a+b))}{2}
+
\frac{\exp(a-b)+\exp(-(a-b))}{2}
\right)
\\
&=
\frac{1}{2}
\left(
\cosh(a+b)+\cosh(a-b)
\right)
\end{aligned}`),
    ],
  },
  {
    id: "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_00_09.ts", ordinal: 1 },
    title: { tex: String.raw`\cosh,\ \sinh\text{ の基本性質}` },
    labels: ["cosh_sinh_basic_properties"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " について、実数値の指数関数 ",
        math(String.raw`\exp : \mathbb{R} \to \mathbb{R}_{>0}`),
        " を用いて",
      ]),
      displayMath(
        String.raw`\cosh x := \frac{\exp(x) + \exp(-x)}{2} \in \mathbb{R}, \qquad
\sinh x := \frac{\exp(x) - \exp(-x)}{2} \in \mathbb{R}`,
      ),
      paragraph(["と定める（", math(String.raw`\exp(x) := e^x`), " とも書く）。このとき次が成り立つ。"]),
      list([
        [
          "(1) ",
          math(String.raw`\cosh x - \sinh x = \exp(-x) > 0`),
          " かつ ",
          math(String.raw`\cosh x + \sinh x = \exp(x) > 0`),
          "。特に ",
          math(String.raw`\cosh x > 0`),
          " かつ ",
          math(String.raw`\cosh x > \sinh x`),
          "。",
        ],
        ["(2) ", math(String.raw`(\cosh x)^2 - (\sinh x)^2 = 1`), "。"],
        [
          "(3) ",
          math(String.raw`x > 0`),
          " ならば ",
          math(String.raw`\cosh x > \sinh x > 0`),
          "。",
        ],
        [
          "(4) ",
          math(String.raw`a, b \in \mathbb{R}_{>0}`),
          " について ",
          math(String.raw`a^2 = b^2 \iff a = b`),
          "。",
        ],
      ]),
      paragraph([
        "ここで ",
        math(String.raw`\exp`),
        " については、実数の指数関数の基本性質として ",
        math(String.raw`\exp(x)\exp(y) = \exp(x+y)`),
        "、",
        math(String.raw`\exp(0) = 1`),
        "、",
        math(String.raw`\exp(x) > 0`),
        "、および ",
        math(String.raw`\exp`),
        " が狭義単調増加であること（",
        math(String.raw`x < y \Rightarrow \exp(x) < \exp(y)`),
        "）のみを用いる。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) の証明。定義より直ちに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cosh x - \sinh x
&= \frac{\exp(x) + \exp(-x)}{2} - \frac{\exp(x) - \exp(-x)}{2}
= \frac{2\exp(-x)}{2} = \exp(-x) \\
\cosh x + \sinh x
&= \frac{\exp(x) + \exp(-x)}{2} + \frac{\exp(x) - \exp(-x)}{2}
= \frac{2\exp(x)}{2} = \exp(x)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\exp(\pm x) > 0`),
        " である。特に ",
        math(String.raw`2\cosh x = (\cosh x - \sinh x) + (\cosh x + \sinh x) = \exp(-x) + \exp(x) > 0`),
        " より ",
        math(String.raw`\cosh x > 0`),
        "、また ",
        math(String.raw`\cosh x - \sinh x = \exp(-x) > 0`),
        " より ",
        math(String.raw`\cosh x > \sinh x`),
        "。",
      ]),
      paragraph(["(2) の証明。(1) の 2 式の積をとると、"]),
      displayMath(
        String.raw`(\cosh x)^2 - (\sinh x)^2
= (\cosh x - \sinh x)(\cosh x + \sinh x)
= \exp(-x)\exp(x)
= \exp(-x + x)
= \exp(0)
= 1`,
      ),
      paragraph([
        "(3) の証明。",
        math(String.raw`x > 0`),
        " のとき ",
        math(String.raw`-x < 0 < x`),
        " であり、",
        math(String.raw`\exp`),
        " は狭義単調増加であるから ",
        math(String.raw`\exp(-x) < \exp(0) = 1 < \exp(x)`),
        "。よって ",
        math(String.raw`\exp(x) - \exp(-x) > 0`),
        " すなわち ",
        math(String.raw`\sinh x = \dfrac{\exp(x) - \exp(-x)}{2} > 0`),
        "。(1) より ",
        math(String.raw`\cosh x > \sinh x`),
        " であるから ",
        math(String.raw`\cosh x > \sinh x > 0`),
        "。",
      ]),
      paragraph([
        "(4) の証明。",
        math(String.raw`a = b`),
        " ならば ",
        math(String.raw`a^2 = b^2`),
        " は明らか。逆に ",
        math(String.raw`a^2 = b^2`),
        " とすると ",
        math(String.raw`(a - b)(a + b) = a^2 - b^2 = 0`),
        " であり、",
        math(String.raw`a, b > 0`),
        " より ",
        math(String.raw`a + b > 0`),
        " すなわち ",
        math(String.raw`a + b \neq 0`),
        "。",
        math(String.raw`\mathbb{R}`),
        " は整域であるから ",
        math(String.raw`a - b = 0`),
        " すなわち ",
        math(String.raw`a = b`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。cosh, sinh の定義から直ちに従う基本性質" +
          "（cosh - sinh = e^{-x} > 0、cosh^2 - sinh^2 = 1、x>0 での正値性、正実数の自乗の単射性）は、" +
          "008_TV1_hatZ_hatY_part2 の γ_1 の偏角・臨界条件 c_1 = s_1 c_2 ⟺ s_1 s_2 = 1 の証明で必要になるが、" +
          "従来どのブロックにも主張として置かれていなかったため、cosh, sinh の積公式" +
          "（calc_formulae_000_cosh_sinh_product）の直後に追加した。",
      ],
    },
  },
  {
    id: "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_00_09.ts", ordinal: 1 },
    title: { tex: String.raw`\text{非負実数の平方根の存在と一意性}` },
    labels: ["sqrt_nonnegative_existence_uniqueness"],
    statement: [
      paragraph([
        math(String.raw`x\in\mathbb{R}_{\ge 0}`),
        " について、",
      ]),
      displayMath(String.raw`y\in\mathbb{R}_{\ge 0} \ \land\ y^2=x`),
      paragraph(["を満たす ", math(String.raw`y`), " がただ一つ存在する。"]),
    ],
    proof: [
      paragraph([
        "ここで初めて非可算集合 ",
        math(String.raw`\mathbb{R}`),
        " の完備性（上限性質）へ移行する。すなわち、以下では ",
        math(String.raw`\mathbb{R}`),
        " が「上に有界で空でない部分集合が必ず上限（最小上界）をもつ順序体」であるという性質を使う。",
        "有理数体 ",
        math(String.raw`\mathbb{Q}`),
        " はこの性質をもたない（",
        math(String.raw`x=2`),
        " のとき ",
        math(String.raw`y^2=2`),
        " なる ",
        math(String.raw`y\in\mathbb{Q}`),
        " は存在しない）ので、存在の主張は ",
        math(String.raw`\mathbb{R}`),
        " へ移行しなければ成り立たない。一方、一意性は順序体の代数だけで示せる。",
      ]),
      paragraph([
        "一意性。",
        math(String.raw`y_1,y_2\in\mathbb{R}_{\ge 0}`),
        " がともに ",
        math(String.raw`y_1^2=x`),
        "、",
        math(String.raw`y_2^2=x`),
        " を満たすとする。",
      ]),
      list([
        [
          math(String.raw`x=0`),
          " のとき。",
          math(String.raw`y_1^2=0`),
          " で ",
          math(String.raw`\mathbb{R}`),
          " は整域だから ",
          math(String.raw`y_1=0`),
          "。同様に ",
          math(String.raw`y_2=0`),
          " なので ",
          math(String.raw`y_1=y_2`),
          "。",
        ],
        [
          math(String.raw`x>0`),
          " のとき。",
          math(String.raw`y_1=0`),
          " なら ",
          math(String.raw`x=y_1^2=0`),
          " となって矛盾するので ",
          math(String.raw`y_1>0`),
          "、同様に ",
          math(String.raw`y_2>0`),
          "。",
          math(String.raw`y_1^2=y_2^2`),
          " と ",
          ref("cosh_sinh_basic_properties"),
          " (4)（",
          math(String.raw`a,b\in\mathbb{R}_{>0}`),
          " について ",
          math(String.raw`a^2=b^2\iff a=b`),
          "）より ",
          math(String.raw`y_1=y_2`),
          "。",
        ],
      ]),
      paragraph([
        "存在。",
        math(String.raw`x=0`),
        " のときは ",
        math(String.raw`y:=0`),
        " が ",
        math(String.raw`y\ge 0`),
        " かつ ",
        math(String.raw`y^2=0=x`),
        " を満たす。以下 ",
        math(String.raw`x>0`),
        " とし、",
      ]),
      displayMath(String.raw`S:=\left\{\,s\in\mathbb{R}_{\ge 0} \;\middle|\; s^2\le x\,\right\}\subset\mathbb{R}`),
      paragraph([
        "とおく。",
        math(String.raw`0\in S`),
        "（",
        math(String.raw`0^2=0\le x`),
        "）より ",
        math(String.raw`S\neq\emptyset`),
        "。また ",
        math(String.raw`1+x`),
        " は ",
        math(String.raw`S`),
        " の上界である。実際、",
        math(String.raw`s\in S`),
        " かつ ",
        math(String.raw`s>1+x`),
        " と仮定すると、",
        math(String.raw`1+x>1>0`),
        " より ",
        math(String.raw`s>1`),
        " であり、",
      ]),
      displayMath(
        String.raw`s^2 = s\cdot s > (1+x)\cdot 1 = 1+x > x`,
      ),
      paragraph([
        "（1 つ目の不等号は ",
        math(String.raw`s>1+x>0`),
        " と ",
        math(String.raw`s>1>0`),
        " から順序体の乗法の単調性による）となり ",
        math(String.raw`s^2\le x`),
        " に矛盾する。よって ",
        math(String.raw`S`),
        " は空でなく上に有界であるから、",
        math(String.raw`\mathbb{R}`),
        " の上限性質により ",
        math(String.raw`y:=\sup S\in\mathbb{R}`),
        " が定まる。",
        math(String.raw`0\in S`),
        " より ",
        math(String.raw`y\ge 0`),
        "。",
      ]),
      paragraph([
        "この ",
        math(String.raw`y`),
        " について ",
        math(String.raw`y^2=x`),
        " を示す。三分律により ",
        math(String.raw`y^2<x`),
        "、",
        math(String.raw`y^2>x`),
        "、",
        math(String.raw`y^2=x`),
        " のいずれか一つが成り立つので、初めの 2 つが矛盾を導くことを示せばよい。",
      ]),
      paragraph([
        "(a) ",
        math(String.raw`y^2<x`),
        " と仮定する。",
          math(String.raw`\varepsilon:=\min\left\{1,\ \dfrac{x-y^2}{2y+1}\right\}\in\mathbb{R}`),
          " とおく（",
          math(String.raw`2y+1\ge 1>0`),
          " なので商は定義され、",
          math(String.raw`x-y^2>0`),
          " より ",
          math(String.raw`\varepsilon>0`),
          "）。",
          math(String.raw`0<\varepsilon\le 1`),
          " より ",
        math(String.raw`\varepsilon^2\le\varepsilon`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(y+\varepsilon)^2
&= y^2+2y\varepsilon+\varepsilon^2
   \quad (\because \text{分配律}) \\
&\le y^2+2y\varepsilon+\varepsilon
   \quad (\because \varepsilon^2\le\varepsilon) \\
&= y^2+(2y+1)\varepsilon \\
&\le y^2+(2y+1)\cdot\frac{x-y^2}{2y+1}
   \quad \left(\because \varepsilon\le\frac{x-y^2}{2y+1},\ 2y+1>0\right) \\
&= y^2+(x-y^2) = x
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`y+\varepsilon\in S`),
        " であり ",
        math(String.raw`y+\varepsilon>y=\sup S`),
        " となって、",
        math(String.raw`y`),
        " が ",
        math(String.raw`S`),
        " の上界であることに矛盾する。",
      ]),
      paragraph([
        "(b) ",
        math(String.raw`y^2>x`),
        " と仮定する。",
          math(String.raw`x>0`),
          " より ",
          math(String.raw`y^2>0`),
          " すなわち ",
          math(String.raw`y>0`),
          "。",
          math(String.raw`\delta:=\dfrac{y^2-x}{2y}\in\mathbb{R}_{>0}`),
          " とおくと ",
          math(String.raw`\delta=\dfrac{y^2-x}{2y}<\dfrac{y^2}{2y}=\dfrac{y}{2}<y`),
          " なので ",
        math(String.raw`y-\delta\in\mathbb{R}_{>0}`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(y-\delta)^2
&= y^2-2y\delta+\delta^2
   \quad (\because \text{分配律}) \\
&\ge y^2-2y\delta
   \quad (\because \delta^2\ge 0) \\
&= y^2-2y\cdot\frac{y^2-x}{2y}
   = y^2-(y^2-x) = x
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`s\in S`),
        " すなわち ",
        math(String.raw`s\ge 0,\ s^2\le x`),
        " ならば ",
        math(String.raw`s^2\le x\le(y-\delta)^2`),
        " であり、",
        math(String.raw`s\ge 0`),
        " かつ ",
        math(String.raw`y-\delta>0`),
        " なので ",
        math(String.raw`s>y-\delta`),
        " と仮定すると ",
        math(String.raw`s^2>(y-\delta)^2`),
        "（正の数どうしの乗法の単調性）となって矛盾する。よって ",
        math(String.raw`s\le y-\delta`),
        " が全ての ",
        math(String.raw`s\in S`),
        " について成り立ち、",
        math(String.raw`y-\delta`),
        " は ",
        math(String.raw`S`),
        " の上界である。しかし ",
        math(String.raw`y-\delta<y=\sup S`),
        " であり、",
        math(String.raw`\sup S`),
        " が最小の上界であることに矛盾する。",
      ]),
      paragraph([
        "以上より ",
        math(String.raw`y^2=x`),
        " であり、",
        math(String.raw`y\in\mathbb{R}_{\ge 0}`),
        " なので存在が示された。一意性と合わせて主張を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）の非負実数の平方根の定義（labels: definition_of_sqrt_r_positive）は" +
          "存在と一意性を「証明略」としていたが、これは定義が well-defined であるために" +
          "必要な事実なので、独立した claim として切り出して証明した。" +
          "存在は R の上限性質（完備性）を使い、一意性は" +
          "labels: cosh_sinh_basic_properties の (4) を使う。" +
          "非可算集合 R の完備性へ移行する箇所を proof の冒頭で明示した。",
      ],
    },
  },
  {
    id: "calc_formulae_001_sqrt_nonnegative_real",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/001_definition_非負実数のsqrt.typ", ordinal: 2 },
    title: { tex: "\\sqrt{\\cdot}" },
    labels: ["definition_of_sqrt_r_positive"],
    statement: [
      paragraph([
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}:\mathbb{R}_{\ge 0}\to\mathbb{R}_{\ge 0}`),
        " を次で定める。",
      ]),
      displayMath("x\\in\\mathbb{R}_{\\ge 0}"),
      paragraph(["について、", math("y\\in\\mathbb{R}_{\\ge 0}"), " で"]),
      displayMath("y\\ge 0\\land y^2=x"),
      paragraph([
        "を満たすものがただ一つ存在する（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。",
      ]),
      paragraph(["この ", math("y"), " を用いて"]),
      displayMath(String.raw`\sqrt{x}^{(\mathbb{R}_{\ge 0})}:=y`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "calc_formulae_002_negative_number_to_sqrt",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/002_theorem_負数からsqrtへの変換.typ", ordinal: 3 },
    title: { tex: "\\text{負数 }\\to\\sqrt{\\cdot}" },
    labels: ["negative_number_to_sqrt"],
    statement: [
      displayMath("x\\in\\mathbb{R}_{<0}"),
      displayMath(String.raw`x=-\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
x&<0 \\
-\sqrt{a}^{(\mathbb{R}_{\ge 0})}=x \text{ になるような } a \\
\sqrt{a}^{(\mathbb{R}_{\ge 0})}=-x \\
\left(\text{自乗して }a\text{ になる実数のうち }a>0\text{ のもの}\right)=-x \\
\left(\text{自乗して }a\text{ になる実数のうち }a>0\text{ のもの}\right)^2=(-x)^2 \\
a=(-x)^2 \\
x=-\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}
\end{aligned}`),
    ],
  },
  {
    id: "calc_formulae_003_matrix_decomposition",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/003_theorem_行列の分解.typ", ordinal: 4 },
    title: { text: "行列の分解" },
    labels: ["mat_mult"],
    statement: [
      displayMath("A\\in\\operatorname{Mat}(n,\\mathbb{C}),\\ a,b\\in\\mathbb{C}^n"),
      displayMath(String.raw`\operatorname{mat}(Aa,Ab)=A\operatorname{mat}(a,b)`),
    ],
  },
  {
    id: "calc_formulae_004_action_on_matrix_pair",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/004_theorem_行列の組みへの作用.typ", ordinal: 5 },
    title: { text: "行列の組みへの作用" },
    labels: [],
    statement: [
      displayMath("A,B,C\\in\\operatorname{Mat}(n,\\mathbb{C})"),
      displayMath(String.raw`\operatorname{mat}(AB,AC)=A\operatorname{mat}(B,C)`),
    ],
  },
  {
    id: "calc_formulae_005_matrix_conjugation",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/005_theorem_行列の共役.typ", ordinal: 6 },
    title: { text: "行列の共役" },
    labels: ["mat_conj"],
    statement: [
      paragraph([
        math("A,B\\in\\operatorname{Mat}(n,\\mathbb{C})"),
        "、",
        math("B"),
        " は正則とする。",
      ]),
      paragraph([math("T_B:\\operatorname{Mat}(n,\\mathbb{C})\\to\\operatorname{Mat}(n,\\mathbb{C})"), " を、"]),
      displayMath("T_B(A):=BAB^{-1}"),
      paragraph(["と定めるとき、", math("T_B"), " は線型写像である。"]),
    ],
    proof: [
      paragraph([math("A,C\\in\\operatorname{Mat}(n,\\mathbb{C})"), " に対して、"]),
      displayMath(String.raw`\begin{aligned}
T_B(A+C)
&=
B(A+C)B^{-1}
\\
&=
(BA+BC)B^{-1}
\\
&=
BAB^{-1}+BCB^{-1}
\\
&=
T_B(A)+T_B(C)
\end{aligned}`),
      paragraph([math("\\alpha\\in\\mathbb{C}"), " に対して、"]),
      displayMath(String.raw`\begin{aligned}
T_B(\alpha A)
&=
B(\alpha A)B^{-1}
\\
&=
\alpha(BAB^{-1})
\\
&=
\alpha T_B(A)
\end{aligned}`),
    ],
  },
  {
    id: "calc_formulae_006_definition_of_cc",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/006_definition_CCの定義.typ", ordinal: 7 },
    title: { tex: "\\mathbb{C}\\text{の定義}" },
    labels: ["definition_of_cc"],
    statement: [
      paragraph([math("\\mathbb{C}:=\\mathbb{R}^2"), " に、以下の演算を入れたもの。"]),
      paragraph(["和（成分ごと）"]),
      displayMath("(a,b)+(c,d):=(a+c,\\; b+d)"),
      paragraph(["積"]),
      displayMath("(a,b)\\cdot(c,d):=(ac-bd,ad+bc)"),
      paragraph([
        "本論文で ",
        math("\\mathbb{C}"),
        " に必要な構造はこの2つの演算だけである。和は指数関数の級数（",
        ref("matrix_exp_series_converges"),
        "）と絶対値の三角不等式（",
        ref("abs_basic_properties"),
        "）で必要になる。",
      ]),
    ],
  },
  {
    id: "calc_formulae_007_inclusion_rr_to_cc",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/007_definition_RRからCCへの包含写像.typ", ordinal: 8 },
    title: { tex: "\\mathbb{R}\\to\\mathbb{C}\\text{の包含写像}" },
    labels: ["inclusion_rr_to_cc"],
    statement: [
      paragraph([math("\\iota_{\\mathbb{R}\\to\\mathbb{C}}:\\mathbb{R}\\to\\mathbb{C}"), " を"]),
      displayMath("\\iota_{\\mathbb{R}\\to\\mathbb{C}}(x):=(x,0)"),
      paragraph(["として定める。これを ", math("\\mathbb{R}"), " から ", math("\\mathbb{C}"), " への包含写像と呼ぶ。"]),
      paragraph(["略記として、", math("r\\in\\mathbb{R}"), " について"]),
      displayMath("r_{\\mathbb{C}}:=\\iota_{\\mathbb{R}\\to\\mathbb{C}}(r)"),
      paragraph(["と書く。"]),
    ],
  },
  {
    id: "calc_formulae_008_multiply_by_minus_one",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/008_definition_マイナス1倍.typ", ordinal: 9 },
    title: { tex: "-1\\text{倍}" },
    labels: ["multiply_by_minus_one"],
    statement: [
      paragraph([math("z\\in\\mathbb{C}"), " について、"]),
      displayMath("-z:=(-1_{\\mathbb{C}})\\cdot z"),
    ],
  },
  {
    id: "calc_formulae_009_sqrt_minus_one",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/009_definition_sqrt_minus_1.typ", ordinal: 10 },
    title: { tex: "\\sqrt{-1}" },
    labels: [],
    statement: [
      displayMath("\\sqrt{-1}:=\\sqrt{-1_{\\mathbb{C}}}"),
    ],
  },
]);
