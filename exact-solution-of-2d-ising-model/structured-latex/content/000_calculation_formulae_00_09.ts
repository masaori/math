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
    id: "calc_formulae_definition_cosh_sinh",
    kind: "definition",
    origin: { path: "structured-latex/content/000_calculation_formulae_00_09.ts", ordinal: 1 },
    title: { text: "双曲線余弦と双曲線正弦" },
    labels: ["def_cosh_sinh"],
    statement: [
      paragraph([math(String.raw`x\in\mathbb R`), " に対して、実数値の指数関数を使い"]),
      displayMath(String.raw`\cosh x:=\frac{\exp(x)+\exp(-x)}2,\qquad \sinh x:=\frac{\exp(x)-\exp(-x)}2`),
      paragraph(["と定める。"]),
    ],
    conversion: { status: "added", notes: ["双曲線関数の定義と、その性質を依存境界で分離した。"] },
  },
  {
    id: "calculation_formulae_definition_set_and_algebra_notation",
    kind: "definition",
    origin: { path: "exact-solution-of-2d-ising-model/main.md", ordinal: 1 },
    title: { text: "集合と代数構造の記号" },
    labels: ["set_and_algebra_notation"],
    statement: [
      paragraph([
        "自然数・整数・実数の集合そのものはこの論文では構成せず、既知の集合としてそれぞれ ",
        math(String.raw`\mathbf{N},\ \mathbf{Z},\ \mathbf{R}`),
        " と書く。演算を持たない集合の記号と、演算を持つ代数構造の記号を区別する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathbb{N}&:=\left(\mathbf{N},+_{\mathbb{N}},\cdot_{\mathbb{N}},0_{\mathbb{N}},1_{\mathbb{N}},\le_{\mathbb{N}}\right),\\
\mathbb{Z}&:=\left(\mathbf{Z},+_{\mathbb{Z}},\cdot_{\mathbb{Z}},0_{\mathbb{Z}},1_{\mathbb{Z}},\le_{\mathbb{Z}}\right),\\
\mathbb{R}&:=\left(\mathbf{R},+_{\mathbb{R}},\cdot_{\mathbb{R}},0_{\mathbb{R}},1_{\mathbb{R}},\le_{\mathbb{R}}\right).
\end{aligned}`),
      paragraph(["各演算と順序の所属は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
+_{\mathbb{N}},\cdot_{\mathbb{N}}&:\mathbf{N}\times\mathbf{N}\to\mathbf{N},\\
+_{\mathbb{Z}},\cdot_{\mathbb{Z}}&:\mathbf{Z}\times\mathbf{Z}\to\mathbf{Z},\\
+_{\mathbb{R}},\cdot_{\mathbb{R}}&:\mathbf{R}\times\mathbf{R}\to\mathbf{R},\\
\le_{\mathbb{N}}&\subset\mathbf{N}\times\mathbf{N},\qquad
\le_{\mathbb{Z}}\subset\mathbf{Z}\times\mathbf{Z},\qquad
\le_{\mathbb{R}}\subset\mathbf{R}\times\mathbf{R}.
\end{aligned}`),
      paragraph([
        math(String.raw`\mathbb{N}`),
        " は自然数の半環、",
        math(String.raw`\mathbb{Z}`),
        " は整数環、",
        math(String.raw`\mathbb{R}`),
        " は順序体を表す。たとえば ",
        math(String.raw`n\in\mathbb{Z}`),
        " は厳密には ",
        math(String.raw`n\in\mathbf{Z}`),
        " の略記であり、計算式中の ",
        math(String.raw`a+b`),
        " は所属が ",
        math(String.raw`a,b\in\mathbf{Z}`),
        " なら ",
        math(String.raw`a+_{\mathbb{Z}}b`),
        "、所属が ",
        math(String.raw`a,b\in\mathbf{R}`),
        " なら ",
        math(String.raw`a+_{\mathbb{R}}b`),
        " の略記とする。積、零元、単位元についても同様に、所属する代数構造の添字を省略した略記である。",
      ]),
      paragraph([
        math(String.raw`\mathbb{Z}_{\ge k}`),
        "、",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        " などは代数構造そのものではなく、その台集合から順序条件で切り出した部分集合の略記とする。たとえば",
      ]),
      displayMath(String.raw`\mathbb{Z}_{\ge k}:=\{n\in\mathbf{Z}\mid k\le_{\mathbb{Z}}n\},\qquad
\mathbb{R}_{\ge 0}:=\{x\in\mathbf{R}\mid 0_{\mathbb{R}}\le_{\mathbb{R}}x\}.`),
      paragraph([
        "複素数の台集合と演算を持つ構造 ",
        math(String.raw`\mathbb{C}`),
        " はここでは定義せず、後の ",
        ref("definition_of_cc"),
        " で ",
        math(String.raw`\mathbf{R}^{2}`),
        " に加法と乗法を入れて定義する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: ["main.md 冒頭の記号方針を、集合と代数構造を混同しない本文定義として追加した。複素数は既存定義と重複させていない。"],
    },
  },
  {
    id: "calc_formulae_000_cosh_sinh_product",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/000_theorem_cosh_sinhの掛け算.typ", ordinal: 1 },
    title: { tex: "\\cosh,\\sinh\\text{の掛け算}" },
    labels: [],
    statement: [
      paragraph([ref("def_cosh_sinh"), " の記号を用いる。"]),
      displayMath("\\forall a,b\\in\\mathbb{R}"),
      displayMath(String.raw`\begin{aligned}
\cosh(a)\sinh(b) &= \frac{1}{2}\left(\sinh(a+b)-\sinh(a-b)\right) \\
\cosh(a)\cosh(b) &= \frac{1}{2}\left(\cosh(a+b)+\cosh(a-b)\right)
\end{aligned}`),
    ],
    proof: [
      paragraph(["1 つめの等式。"]),
      displayMath(String.raw`\begin{aligned}
\cosh(a)\sinh(b)
&=
\frac{\exp(a)+\exp(-a)}{2}
\frac{\exp(b)-\exp(-b)}{2}
&&(\because\ \cosh,\ \sinh\ \text{の定義})
\\
&=
\frac{1}{4}
\left(
\left(\exp(a)\exp(b)-\exp(-a)\exp(-b)\right)
-
\left(\exp(a)\exp(-b)-\exp(-a)\exp(b)\right)
\right)
&&(\because\ \text{分配則})
\\
&=
\frac{1}{2}
\left(
\frac{\exp(a+b)-\exp(-(a+b))}{2}
-
\frac{\exp(a-b)-\exp(-(a-b))}{2}
\right)
&&(\because\ \exp(s)\exp(t)=\exp(s+t)\ \text{を 4 箇所へ})
\\
&=
\frac{1}{2}
\left(
\sinh(a+b)-\sinh(a-b)
\right)
&&(\because\ \sinh\ \text{の定義})
\end{aligned}`),
      paragraph(["2 つめの等式。"]),
      displayMath(String.raw`\begin{aligned}
\cosh(a)\cosh(b)
&=
\frac{\exp(a)+\exp(-a)}{2}
\frac{\exp(b)+\exp(-b)}{2}
&&(\because\ \cosh\ \text{の定義})
\\
&=
\frac{1}{4}
\left(
\left(\exp(a)\exp(b)+\exp(-a)\exp(-b)\right)
+
\left(\exp(a)\exp(-b)+\exp(-a)\exp(b)\right)
\right)
&&(\because\ \text{分配則})
\\
&=
\frac{1}{2}
\left(
\frac{\exp(a+b)+\exp(-(a+b))}{2}
+
\frac{\exp(a-b)+\exp(-(a-b))}{2}
\right)
&&(\because\ \exp(s)\exp(t)=\exp(s+t)\ \text{を 4 箇所へ})
\\
&=
\frac{1}{2}
\left(
\cosh(a+b)+\cosh(a-b)
\right)
&&(\because\ \cosh\ \text{の定義})
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
        ref("def_cosh_sinh"), " の ", math(String.raw`x\in\mathbb R`), " における値について、次が成り立つ。",
      ]),
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
      paragraph(["(1) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\cosh x - \sinh x
&= \frac{\exp(x) + \exp(-x)}{2} - \frac{\exp(x) - \exp(-x)}{2}
&&(\because\ \cosh,\ \sinh\ \text{の定義})\\
&= \frac{\bigl(\exp(x) + \exp(-x)\bigr) - \bigl(\exp(x) - \exp(-x)\bigr)}{2}
&&(\because\ \text{分母の等しい分数の差})\\
&= \frac{2\exp(-x)}{2}
&&(\because\ \text{分子の整理})\\
&= \exp(-x)
&&(\because\ \text{約分})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh x + \sinh x
&= \frac{\exp(x) + \exp(-x)}{2} + \frac{\exp(x) - \exp(-x)}{2}
&&(\because\ \cosh,\ \sinh\ \text{の定義})\\
&= \frac{\bigl(\exp(x) + \exp(-x)\bigr) + \bigl(\exp(x) - \exp(-x)\bigr)}{2}
&&(\because\ \text{分母の等しい分数の和})\\
&= \frac{2\exp(x)}{2}
&&(\because\ \text{分子の整理})\\
&= \exp(x)
&&(\because\ \text{約分})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh x - \sinh x
&= \exp(-x)
&&(\because\ \text{上の第 1 式})\\
&> 0
&&(\because\ \exp\ \text{の正値性})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh x - \sinh x > 0
&\Longrightarrow \cosh x > \sinh x
&&(\because\ \text{両辺に}\ \sinh x\ \text{を加える})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
2\cosh x
&= (\cosh x - \sinh x) + (\cosh x + \sinh x)
&&(\because\ \text{右辺の整理})\\
&= \exp(-x) + \exp(x)
&&(\because\ \text{上の 2 式})\\
&> 0
&&(\because\ \exp\ \text{の正値性})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
2\cosh x > 0
&\Longrightarrow \cosh x > 0
&&(\because\ \text{両辺を}\ 2 > 0\ \text{で割る})
\end{aligned}`,
      ),
      paragraph(["(2) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
(\cosh x)^2 - (\sinh x)^2
&= (\cosh x - \sinh x)(\cosh x + \sinh x)
&&(\because\ \text{2 乗の差の因数分解})\\
&= \exp(-x)\exp(x)
&&(\because\ \text{(1) の 2 式})\\
&= \exp(-x + x)
&&(\because\ \exp(x)\exp(y) = \exp(x+y))\\
&= \exp(0)
&&(\because\ -x + x = 0)\\
&= 1
&&(\because\ \exp(0) = 1)
\end{aligned}`,
      ),
      paragraph(["(3) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
x>0
&\Longrightarrow -x<0
&&(\because\ \text{両辺に }-1<0\text{ を掛けると不等号の向きが反転する})\\
x>0
&\Longrightarrow 0<x
&&(\because\ \text{同じ不等式の左右を入れ替える})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(-x)
&< \exp(0)
&&(\because\ \exp\ \text{が狭義単調増加で}\ -x < 0)\\
&= 1
&&(\because\ \exp(0) = 1)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
1
&= \exp(0)
&&(\because\ \exp(0) = 1)\\
&< \exp(x)
&&(\because\ \exp\ \text{が狭義単調増加で}\ 0 < x)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(-x)<1<\exp(x)
&\Longrightarrow \exp(-x)<\exp(x)
&&(\because\ \mathbb R\text{ の順序の推移律})\\
&\Longrightarrow \exp(x)-\exp(-x)>0
&&(\because\ \text{両辺に }-\exp(-x)\text{ を加える})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh x
&= \frac{\exp(x) - \exp(-x)}{2}
&&(\because\ \sinh\ \text{の定義})\\
&> 0
&&(\because\ \text{正の実数を}\ 2 > 0\ \text{で割った値は正})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh x>\sinh x\ \land\ \sinh x>0
&\Longrightarrow \cosh x>\sinh x>0
&&(\because\ \text{(1) と直前の不等式})
\end{aligned}`,
      ),
      paragraph([
        "(4) の証明。両方向を別々に示すので、ここは一続きの式にしない。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a=b
&\Longrightarrow a^2=b^2
&&(\because\ \text{等しい実数を二乗しても等しい})
\end{aligned}`,
      ),
      paragraph([
        "逆に ",
        math(String.raw`a^2 = b^2`),
        " とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(a - b)(a + b)
&= a^2 - b^2
&&(\because\ \text{2 乗の差の因数分解})\\
&= 0
&&(\because\ a^2 = b^2)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
a>0\ \land\ b>0
&\Longrightarrow a+b>0
&&(\because\ \text{正の実数の和は正})\\
&\Longrightarrow a+b\ne0
&&(\because\ \text{正の実数は }0\text{ でない})\\
(a-b)(a+b)=0\ \land\ a+b\ne0
&\Longrightarrow a-b=0
&&(\because\ \mathbb R\text{ は整域})\\
&\Longrightarrow a=b
&&(\because\ \text{両辺に }b\text{ を加える})
\end{aligned}`,
      ),
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
      paragraph([
        math(String.raw`x=0`),
        " の場合と ",
        math(String.raw`x>0`),
        " の場合に分ける。",
      ]),
      paragraph([
        math(String.raw`x=0`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
y_1^2
&= x
&&(\because\ y_1\ \text{の仮定})\\
&= 0
&&(\because\ \text{いまの場合分け})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\mathbb{R}`),
        " は整域だから ",
        math(String.raw`y_1=0`),
        " である。",
        math(String.raw`y_2`),
        " についても同じ議論で ",
        math(String.raw`y_2=0`),
        " なので ",
        math(String.raw`y_1=y_2`),
        " である。",
      ]),
      paragraph([
        math(String.raw`x>0`),
        " のとき。まず ",
        math(String.raw`y_1>0`),
        " である。実際 ",
        math(String.raw`y_1=0`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
x
&= y_1^2
&&(\because\ y_1\ \text{の仮定})\\
&= 0^2
&&(\because\ \text{仮定}\ y_1=0)\\
&= 0
&&(\because\ 0\ \text{の冪})
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`x>0`),
        " に矛盾する。",
        math(String.raw`y_1\in\mathbb{R}_{\ge0}`),
        " なので ",
        math(String.raw`y_1>0`),
        " である。",
        math(String.raw`y_2`),
        " についても同じ議論で ",
        math(String.raw`y_2>0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
y_1^2
&= x
&&(\because\ y_1\ \text{の仮定})\\
&= y_2^2
&&(\because\ y_2\ \text{の仮定})
\end{aligned}`),
      paragraph([
        "と ",
        ref("cosh_sinh_basic_properties"),
        " (4)（",
        math(String.raw`a,b\in\mathbb{R}_{>0}`),
        " について ",
        math(String.raw`a^2=b^2\iff a=b`),
        "）より ",
        math(String.raw`y_1=y_2`),
        " である。",
      ]),
      paragraph([
        "存在。",
        math(String.raw`x=0`),
        " のときは ",
        math(String.raw`y:=0`),
        " と置けば ",
        math(String.raw`y\ge 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
y^2
&= 0^2
&&(\because\ y\ \text{の定め方})\\
&= 0
&&(\because\ 0\ \text{の冪})\\
&= x
&&(\because\ \text{いまの場合分け})
\end{aligned}`),
      paragraph([
        "を満たす。以下 ",
        math(String.raw`x>0`),
        " とし、",
      ]),
      displayMath(String.raw`S:=\left\{\,s\in\mathbb{R}_{\ge 0} \;\middle|\; s^2\le x\,\right\}\subset\mathbb{R}`),
      paragraph([
        "とおく。",
        math(String.raw`0\in S`),
        " を確かめると、",
      ]),
      displayMath(String.raw`\begin{aligned}
0^2
&=0
&&(\because\ 0\ \text{の冪})\\
&\le x
&&(\because\ x\in\mathbb{R}_{\ge0})
\end{aligned}`),
      paragraph([
        "より ",
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
      ]),
      displayMath(String.raw`\begin{aligned}
s>1+x\ \land\ 1+x>1
&\Longrightarrow s>1
&&(\because\ \mathbb{R}\ \text{の順序の推移律。}\ 1+x>1\ \text{は}\ x>0\ \text{による})
\end{aligned}`),
      paragraph([
        "であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
s^2
&= s\cdot s
&&(\because\ \text{2 乗の定義})\\
&> (1+x)\cdot 1
&&(\because\ s>1+x>0\ \text{と}\ s>1>0\text{、順序体の乗法の単調性})\\
&= 1+x
&&(\because\ 1\ \text{は乗法の単位元})\\
&> x
&&(\because\ 1>0)
\end{aligned}`),
      paragraph([
        "となり ",
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
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon^2
&= \varepsilon\cdot\varepsilon
&&(\because\ \text{2 乗の定義})\\
&\le 1\cdot\varepsilon
&&(\because\ \varepsilon\le 1,\ \varepsilon>0\text{、順序体の乗法の単調性})\\
&= \varepsilon
&&(\because\ 1\ \text{は乗法の単位元})
\end{aligned}`),
      paragraph([
        "であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(y+\varepsilon)^2
&= y^2+2y\varepsilon+\varepsilon^2
&&(\because\ \text{分配律})\\
&\le y^2+2y\varepsilon+\varepsilon
&&(\because\ \varepsilon^2\le\varepsilon)\\
&= y^2+(2y+1)\varepsilon
&&(\because\ \text{分配律})\\
&\le y^2+(2y+1)\cdot\frac{x-y^2}{2y+1}
&&\left(\because\ \varepsilon\le\frac{x-y^2}{2y+1},\ 2y+1>0\right)\\
&= y^2+(x-y^2)
&&(\because\ 2y+1\ne0\ \text{による約分})\\
&= x
&&(\because\ \mathbb{R}\ \text{の加法の結合性と逆元})
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
      ]),
      displayMath(String.raw`\begin{aligned}
y^2>x\ \land\ x>0
&\Longrightarrow y^2>0
&&(\because\ \mathbb{R}\ \text{の順序の推移律})\\
&\Longrightarrow y>0
&&(\because\ y\ge0\ \text{と正実数の二乗の単射性})
\end{aligned}`),
      paragraph([
          math(String.raw`\delta:=\dfrac{y^2-x}{2y}\in\mathbb{R}_{>0}`),
          " とおくと ",
          math(String.raw`\delta>0`),
          " である。また",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta
&= \frac{y^2-x}{2y}
&&(\because\ \delta\ \text{の定め方})\\
&< \frac{y^2}{2y}
&&(\because\ y^2-x<y^2\ \text{と}\ 2y>0)\\
&= \frac{y}{2}
&&(\because\ y\ne0\ \text{による約分})\\
&< y
&&(\because\ y>0)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`y-\delta\in\mathbb{R}_{>0}`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(y-\delta)^2
&= y^2-2y\delta+\delta^2
&&(\because\ \text{分配律})\\
&\ge y^2-2y\delta
&&(\because\ \delta^2\ge 0)\\
&= y^2-2y\cdot\frac{y^2-x}{2y}
&&(\because\ \delta\ \text{の定め方})\\
&= y^2-(y^2-x)
&&(\because\ 2y\ne0\ \text{による約分})\\
&= x
&&(\because\ \mathbb{R}\ \text{の加法の結合性と逆元})
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
      paragraph([
        "準備として ",
        math(String.raw`-x`),
        " が平方根の定義の条件を満たすことを見る。",
      ]),
      displayMath(String.raw`\begin{aligned}
-x
&>-0
&&(\because\ x<0\ \text{と加法の逆元による順序の反転})\\
&=0
&&(\because\ 0\ \text{の加法の逆元は}\ 0)
\end{aligned}`),
      paragraph([
        "であり、とくに ",
        math(String.raw`-x\in\mathbb{R}_{\ge 0}`),
        " である。また、実数の平方は非負なので ",
        math(String.raw`(-x)^2\in\mathbb{R}_{\ge 0}`),
        " である。したがって ",
        math(String.raw`y=-x`),
        " は条件 ",
        math(String.raw`y\in\mathbb{R}_{\ge 0}\ \land\ y^2=(-x)^2`),
        " を満たす。この条件を満たす ",
        math(String.raw`y`),
        " はただ一つであり（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）、それが ",
        math(String.raw`\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}`),
        " である（",
        ref("definition_of_sqrt_r_positive"),
        "）。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}
&=-x
&&(\because\ \text{平方根の定義 }\blkref{definition_of_sqrt_r_positive}
\text{ と条件を満たす元の一意性 }\blkref{sqrt_nonnegative_existence_uniqueness})
\end{aligned}`),
      paragraph([
        "である。以上を使って主張を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
-\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}
&=-(-x)
&&(\because\ \text{準備で得た等式})\\
&=x
&&(\because\ \text{加法の逆元の逆元はもとの元})
\end{aligned}`),
      paragraph([
        "すなわち ",
        math(String.raw`x=-\sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）の証明は等号でつながった式変形ではなく、" +
          "「-√a = x になるような a」「自乗して a になる実数のうち…」という探索の過程を" +
          "数式の中の日本語として並べたものだった。どの行がどの行から従うのかが書かれておらず、" +
          "そのままでは一ステップ一定理の形に写せない。" +
          "原文が辿っていた筋（-x が平方根の条件を満たすことを見て、一意性から √((-x)^2) = -x を" +
          "出し、両辺の符号を反転する）をそのまま保ったうえで、" +
          "一続きの式変形と行末の根拠へ書き換えた。ステップは減らしていない。",
      ],
    },
  },
  {
    id: "calc_formulae_003_matrix_decomposition",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/003_theorem_行列の分解.typ", ordinal: 4 },
    title: { text: "行列の積の成分による定義" },
    labels: ["mat_mult"],
    statement: [
      paragraph([
        math(String.raw`m,n,p \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする（",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " は成分が ",
        ref("definition_of_cc"),
        " の複素数である ",
        math(String.raw`m`),
        " 行 ",
        math(String.raw`n`),
        " 列の行列全体、",
        math(String.raw`\mathrm{Mat}(n,\mathbb{C}) := \mathrm{Mat}(n,n,\mathbb{C})`),
        "）。積 ",
        math(String.raw`AB \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`(AB)_{ik} := \sum_{j=1}^{n} A_{ij}\,B_{jk}
\qquad (i \in \{1,\dots,m\},\ k \in \{1,\dots,p\})`),
      paragraph([
        "で定める。右辺は ",
        math(String.raw`n`),
        " 個の複素数の有限和である。数ベクトル ",
        math(String.raw`a \in \mathbb{C}^n`),
        " は ",
        math(String.raw`n`),
        " 行 1 列の行列とみなし、",
        math(String.raw`Aa`),
        " も同じ式で定める。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05: 原文のこのブロックは Typst の行列構成子 mat(...) を使った「行列の分解」で、記号 mat が本文で定義されておらず証明も無かった。一方このラベル mat_mult は本文の20箇所以上から「行列の積の定義」として引かれていた。引用の意味と一致するよう、成分による積の定義そのものをこのラベルの内容とした。原文が述べていた列ごとの作用は次のブロックへ、記法を定義したうえで移した。",
      ],
    },
  },
  {
    id: "calc_formulae_004_action_on_matrix_pair",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/004_theorem_行列の組みへの作用.typ", ordinal: 5 },
    title: { text: "行列の積は列ごとに作用する" },
    labels: ["mat_columnwise"],
    statement: [
      paragraph([
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`b_1,\dots,b_p \in \mathbb{C}^n`),
        " とし、これらを列に並べた行列を ",
        math(String.raw`\left[\,b_1\ \cdots\ b_p\,\right] \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " と書く（第 ",
        math(String.raw`k`),
        " 列の第 ",
        math(String.raw`j`),
        " 成分が ",
        math(String.raw`(b_k)_j`),
        " である行列）。このとき",
      ]),
      displayMath(String.raw`A\left[\,b_1\ \cdots\ b_p\,\right]
= \left[\,Ab_1\ \cdots\ Ab_p\,\right]`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺は同じ大きさの行列なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(A\left[\,b_1\ \cdots\ b_p\,\right]\right)_{ik}
&=\sum_{j=1}^{n} A_{ij}\,\left(\left[\,b_1\ \cdots\ b_p\,\right]\right)_{jk}
  &&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&=\sum_{j=1}^{n} A_{ij}\,(b_k)_j
  &&\bigl(\because\ \text{列に並べた行列の成分の定め方}\bigr)\\
&=(Ab_k)_i
  &&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\ \text{を}\ Ab_k\ \text{へ適用}\bigr)\\
&=\left(\left[\,Ab_1\ \cdots\ Ab_p\,\right]\right)_{ik}
  &&\bigl(\because\ \text{列に並べた行列の成分の定め方}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05: 原文は Typst の行列構成子 mat(...) で「mat(Aa,Ab)=A mat(a,b)」と書いていたが、その記号は本文で定義されておらず証明も無かった。列に並べた行列という記法を主張の中で定義し、成分計算の四段で証明した。",
      ],
    },
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
      paragraph([
        math("\\operatorname{Mat}(n,\\mathbb{C})"),
        " の各元 ",
        math("A"),
        " に対して ",
        math("T_B(A):=BAB^{-1} \\in \\operatorname{Mat}(n,\\mathbb{C})"),
        " と定める。このとき ",
        math("T_B"),
        " は和とスカラー倍を保つ。すなわち",
      ]),
      displayMath(String.raw`T_B(A+C)=T_B(A)+T_B(C),\qquad
T_B(\alpha A)=\alpha\,T_B(A)
\qquad (A,C\in\operatorname{Mat}(n,\mathbb{C}),\ \alpha\in\mathbb{C})`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["和を保つことと、スカラー倍を保つことを別々に示す。"]),
      paragraph([
        "第一に、和を保つこと。",
        math("A,C\\in\\operatorname{Mat}(n,\\mathbb{C})"),
        " に対して、",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B(A+C)
&=B(A+C)B^{-1}
&&(\because\ T_B\ \text{の定義})\\
&=(BA+BC)B^{-1}
&&(\because\ \text{行列の積の左からの分配則})\\
&=BAB^{-1}+BCB^{-1}
&&(\because\ \text{行列の積の右からの分配則})\\
&=T_B(A)+T_B(C)
&&(\because\ T_B\ \text{の定義})
\end{aligned}`),
      paragraph([
        "である。第二に、スカラー倍を保つこと。",
        math("A\\in\\operatorname{Mat}(n,\\mathbb{C})"),
        " と ",
        math("\\alpha\\in\\mathbb{C}"),
        " に対して、",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B(\alpha A)
&=B(\alpha A)B^{-1}
&&(\because\ T_B\ \text{の定義})\\
&=\bigl(\alpha(BA)\bigr)B^{-1}
&&(\because\ \text{スカラー倍と行列の積の交換})\\
&=\alpha\bigl(BAB^{-1}\bigr)
&&(\because\ \text{スカラー倍と行列の積の交換})\\
&=\alpha\,T_B(A)
&&(\because\ T_B\ \text{の定義})
\end{aligned}`),
      paragraph([
        "である。以上より ",
        math("T_B"),
        " は和とスカラー倍を保つ。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）の証明は等号でつなげてはあったが、各行の根拠が書かれておらず、" +
          "スカラー倍の側では B(αA)B^{-1} = α(BAB^{-1}) が 1 行に詰められていた" +
          "（スカラー倍と行列の積の交換を 2 度使っている）。" +
          "行末の (∵ …) を付け、詰まっていた行を 2 段へ分けた。ステップは減らしていない。",
      ],
    },
  },
  {
    id: "calc_formulae_006_definition_of_cc",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/006_definition_CCの定義.typ", ordinal: 7 },
    title: { tex: "\\mathbb{C}\\text{の定義}" },
    labels: ["definition_of_cc"],
    statement: [
      paragraph([ref("set_and_algebra_notation"), " の実数の台集合と演算を使う。"]),
      paragraph([math(String.raw`\mathbf{C}:=\mathbf{R}^2`), " を複素数の台集合とし、その上に以下の演算を入れた構造を ", math(String.raw`\mathbb C`), " と書く。"]),
      paragraph(["和（成分ごと）"]),
      displayMath(String.raw`+_{\mathbb C}:\mathbf C\times\mathbf C\to\mathbf C,\qquad(a,b)+_{\mathbb C}(c,d):=(a+_{\mathbb R}c,\ b+_{\mathbb R}d)`),
      paragraph(["積"]),
      displayMath(String.raw`\cdot_{\mathbb C}:\mathbf C\times\mathbf C\to\mathbf C,\qquad(a,b)\cdot_{\mathbb C}(c,d):=(a\cdot_{\mathbb R}c-b\cdot_{\mathbb R}d,\ a\cdot_{\mathbb R}d+b\cdot_{\mathbb R}c)`),
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
