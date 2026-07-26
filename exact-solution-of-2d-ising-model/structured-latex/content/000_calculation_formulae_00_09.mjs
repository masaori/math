import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_calculation_formulae",
    kind: "heading",
    level: 2,
    sourcePath: "_old/typst/main.typ",
    sourceOrdinal: 1,
    title: { text: "計算公式" },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "calc_formulae_000_cosh_sinh_product",
    kind: "theorem",
    sourcePath: "_old/typst/parts/000_計算公式/000_theorem_cosh_sinhの掛け算.typ",
    sourceOrdinal: 1,
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
    sourcePath: "structured-latex/content/000_calculation_formulae_00_09.mjs",
    sourceOrdinal: 1,
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
    id: "calc_formulae_001_sqrt_nonnegative_real",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/001_definition_非負実数のsqrt.typ",
    sourceOrdinal: 2,
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
        "を満たすものがただ一つ存在する（存在と一意性は下の proof で証明する。これは本定義が well-defined であるために必要な事実である）。",
      ]),
      paragraph(["この ", math("y"), " を用いて"]),
      displayMath(String.raw`\sqrt{x}^{(\mathbb{R}_{\ge 0})}:=y`),
      paragraph(["と定める。"]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\mathbb{R}`),
        " については順序体の公理に加えて次の 1 つだけを使う。",
      ]),
      list([
        [
          "(完備性 / 上限性質) ",
          math(String.raw`\mathbb{R}`),
          " の空でない部分集合が上に有界ならば、上限（最小の上界）が ",
          math(String.raw`\mathbb{R}`),
          " の中に存在する。",
        ],
      ]),
      paragraph([
        "本証明の存在部分は、この完備性を使う箇所でのみ非可算集合 ",
        math(String.raw`\mathbb{R}`),
        " へ移行する（有理数体 ",
        math(String.raw`\mathbb{Q}`),
        " では ",
        math(String.raw`x=2`),
        " に対する ",
        math(String.raw`y`),
        " が存在しないので、この移行は省略できない）。一意性部分は順序体の代数計算だけで済み、",
        math(String.raw`\mathbb{R}`),
        " の完備性を使わない。",
      ]),
      paragraph([
        "また、順序体の公理から従う次の 2 つの事実を断りなく使う。",
        math(String.raw`a,b\in\mathbb{R}`),
        " について、",
      ]),
      list([
        [
          "(M1) ",
          math(String.raw`0\le a\le b \Rightarrow a^2\le b^2`),
          "。（",
          math(String.raw`b^2-a^2=(b-a)(b+a)`),
          " で ",
          math(String.raw`b-a\ge 0`),
          "、",
          math(String.raw`b+a\ge 0`),
          " なので積は ",
          math(String.raw`\ge 0`),
          "。）",
        ],
        [
          "(M2) ",
          math(String.raw`\mathbb{R}`),
          " は整域である。すなわち ",
          math(String.raw`ab=0 \Rightarrow a=0 \lor b=0`),
          "。（体は整域である。）",
        ],
      ]),
      paragraph([
        "存在。",
        math(String.raw`x\in\mathbb{R}_{\ge 0}`),
        " を固定し、",
      ]),
      displayMath(
        String.raw`S := \left\{\, s\in\mathbb{R} \;\middle|\; s\ge 0 \ \wedge\ s^2\le x \,\right\} \subset \mathbb{R}`,
      ),
      paragraph([
        "とおく。",
      ]),
      list([
        [
          math(String.raw`S\neq\emptyset`),
          "：",
          math(String.raw`0\ge 0`),
          " かつ ",
          math(String.raw`0^2=0\le x`),
          " より ",
          math(String.raw`0\in S`),
          "。",
        ],
        [
          math(String.raw`S`),
          " は ",
          math(String.raw`1+x`),
          " を上界にもつ：",
          math(String.raw`s\in S`),
          " について ",
          math(String.raw`s>1+x`),
          " と仮定すると、",
          math(String.raw`x\ge 0`),
          " より ",
          math(String.raw`1+x\ge 1`),
          " なので ",
          math(String.raw`s>1`),
          "。よって ",
          math(String.raw`s>0`),
          " かつ ",
          math(String.raw`s-1>0`),
          " より ",
          math(String.raw`s^2-s=s(s-1)>0`),
          " すなわち ",
          math(String.raw`s^2>s`),
          " であり、",
          math(String.raw`s^2>s>1+x>x`),
          " となって ",
          math(String.raw`s^2\le x`),
          " に矛盾する。ゆえに ",
          math(String.raw`s\le 1+x`),
          "。",
        ],
      ]),
      paragraph([
        "したがって完備性より上限 ",
        math(String.raw`y:=\sup S\in\mathbb{R}`),
        " が存在する。",
        math(String.raw`0\in S`),
        " より ",
        math(String.raw`y\ge 0`),
        "。以下 ",
        math(String.raw`y^2=x`),
        " を、",
        math(String.raw`y^2<x`),
        " と ",
        math(String.raw`y^2>x`),
        " の両方を排除して示す（",
        math(String.raw`\mathbb{R}`),
        " は全順序体なので三分律によりこの 2 つを排除すれば ",
        math(String.raw`y^2=x`),
        "）。",
      ]),
      paragraph([
        "(i) ",
        math(String.raw`y^2<x`),
        " と仮定する。",
        math(String.raw`y\ge 0`),
        " より ",
        math(String.raw`2y+1\ge 1>0`),
        " なので",
      ]),
      displayMath(
        String.raw`h := \min\left\{\,1,\ \frac{x-y^2}{2(2y+1)}\,\right\} \in \mathbb{R}`,
      ),
      paragraph([
        "が定まり、",
        math(String.raw`x-y^2>0`),
        " より ",
        math(String.raw`h>0`),
        "、また ",
        math(String.raw`h\le 1`),
        " かつ",
      ]),
      displayMath(
        String.raw`h \le \frac{x-y^2}{2(2y+1)} < \frac{x-y^2}{2y+1}`,
      ),
      paragraph([
        "（最後の不等号は ",
        math(String.raw`\frac{x-y^2}{2y+1}>0`),
        " を ",
        math(String.raw`2`),
        " で割ると真に小さくなることによる）。このとき ",
        math(String.raw`y+h>0`),
        " かつ ",
        math(String.raw`h^2\le h`),
        "（",
        math(String.raw`0<h\le 1`),
        " より ",
        math(String.raw`h-h^2=h(1-h)\ge 0`),
        "）であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(y+h)^2
&= y^2+2yh+h^2 \\
&\le y^2+2yh+h \quad (\because h^2\le h) \\
&= y^2+h(2y+1) \\
&< y^2+\frac{x-y^2}{2y+1}\cdot(2y+1) \quad \left(\because h<\frac{x-y^2}{2y+1},\ 2y+1>0\right) \\
&= y^2+(x-y^2) = x
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`y+h\ge 0`),
        " かつ ",
        math(String.raw`(y+h)^2\le x`),
        " すなわち ",
        math(String.raw`y+h\in S`),
        " であるが、",
        math(String.raw`h>0`),
        " より ",
        math(String.raw`y+h>y=\sup S`),
        " となり、",
        math(String.raw`y`),
        " が ",
        math(String.raw`S`),
        " の上界であることに矛盾する。",
      ]),
      paragraph([
        "(ii) ",
        math(String.raw`y^2>x`),
        " と仮定する。",
        math(String.raw`x\ge 0`),
        " より ",
        math(String.raw`y^2>0`),
        " であり、(M2) より ",
        math(String.raw`y\neq 0`),
        "、",
        math(String.raw`y\ge 0`),
        " と合わせて ",
        math(String.raw`y>0`),
        "。そこで",
      ]),
      displayMath(String.raw`k := \frac{y^2-x}{2y} \in \mathbb{R}`),
      paragraph([
        "とおくと ",
        math(String.raw`y^2-x>0`),
        "、",
        math(String.raw`2y>0`),
        " より ",
        math(String.raw`k>0`),
        "、また ",
        math(String.raw`y^2-x\le y^2`),
        "（",
        math(String.raw`x\ge 0`),
        "）より",
      ]),
      displayMath(
        String.raw`k = \frac{y^2-x}{2y} \le \frac{y^2}{2y} = \frac{y}{2} < y`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`0<y-k`),
        "。さらに",
      ]),
      displayMath(
        String.raw`(y-k)^2 = y^2-2yk+k^2 = y^2-(y^2-x)+k^2 = x+k^2 > x
\qquad (\because k>0 \Rightarrow k^2>0)`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`s\in S`),
        " を任意にとる。",
        math(String.raw`s\ge y-k`),
        " と仮定すると、",
        math(String.raw`0<y-k\le s`),
        " と (M1) より ",
        math(String.raw`(y-k)^2\le s^2\le x`),
        " となり ",
        math(String.raw`(y-k)^2>x`),
        " に矛盾する。よって ",
        math(String.raw`s<y-k`),
        " であり、",
        math(String.raw`y-k`),
        " は ",
        math(String.raw`S`),
        " の上界である。しかし ",
        math(String.raw`k>0`),
        " より ",
        math(String.raw`y-k<y=\sup S`),
        " であり、",
        math(String.raw`y`),
        " が最小の上界であることに矛盾する。",
      ]),
      paragraph([
        "(i)(ii) より ",
        math(String.raw`y^2=x`),
        " であり、",
        math(String.raw`y\ge 0`),
        " と合わせて存在が示された。",
      ]),
      paragraph([
        "一意性。",
        math(String.raw`y_1,y_2\in\mathbb{R}`),
        " がともに ",
        math(String.raw`y_i\ge 0`),
        " かつ ",
        math(String.raw`y_i^2=x`),
        "（",
        math(String.raw`i=1,2`),
        "）を満たすとする。",
      ]),
      list([
        [
          math(String.raw`y_1=0`),
          " の場合。",
          math(String.raw`x=y_1^2=0`),
          " なので ",
          math(String.raw`y_2\cdot y_2=y_2^2=0`),
          "。(M2) より ",
          math(String.raw`y_2=0=y_1`),
          "。",
        ],
        [
          math(String.raw`y_2=0`),
          " の場合。上と同様（添字を入れ替える）に ",
          math(String.raw`y_1=0=y_2`),
          "。",
        ],
        [
          math(String.raw`y_1>0`),
          " かつ ",
          math(String.raw`y_2>0`),
          " の場合。",
          math(String.raw`y_1^2=x=y_2^2`),
          " であるから、",
          ref("cosh_sinh_basic_properties"),
          " (4)（",
          math(String.raw`a,b\in\mathbb{R}_{>0}`),
          " について ",
          math(String.raw`a^2=b^2 \iff a=b`),
          "）を ",
          math(String.raw`a=y_1,\ b=y_2`),
          " に適用して ",
          math(String.raw`y_1=y_2`),
          "。",
        ],
      ]),
      paragraph([
        math(String.raw`y_1,y_2\ge 0`),
        " なので以上で場合分けは尽きており、いずれの場合も ",
        math(String.raw`y_1=y_2`),
        "。よって一意性が示された。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）は「ただ一つ存在する（証明略）」だった。これは本定義が well-defined で" +
          "あるために必要な事実なので、注記ではなく proof として証明を書いた。存在は R の完備性" +
          "（上限性質）による S = {s ≥ 0 | s^2 ≤ x} の上限の構成、一意性は既存の " +
          "labels: cosh_sinh_basic_properties (4)（正実数について a^2 = b^2 ⟺ a = b）を参照し、" +
          "y = 0 の場合だけ R が整域であることから別途処理した（重複した補題は作っていない）。",
      ],
    },
  },
  {
    id: "calc_formulae_002_negative_number_to_sqrt",
    kind: "theorem",
    sourcePath: "_old/typst/parts/000_計算公式/002_theorem_負数からsqrtへの変換.typ",
    sourceOrdinal: 3,
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
    sourcePath: "_old/typst/parts/000_計算公式/003_theorem_行列の分解.typ",
    sourceOrdinal: 4,
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
    sourcePath: "_old/typst/parts/000_計算公式/004_theorem_行列の組みへの作用.typ",
    sourceOrdinal: 5,
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
    sourcePath: "_old/typst/parts/000_計算公式/005_theorem_行列の共役.typ",
    sourceOrdinal: 6,
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
    sourcePath: "_old/typst/parts/000_計算公式/006_definition_CCの定義.typ",
    sourceOrdinal: 7,
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
    sourcePath: "_old/typst/parts/000_計算公式/007_definition_RRからCCへの包含写像.typ",
    sourceOrdinal: 8,
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
    sourcePath: "_old/typst/parts/000_計算公式/008_definition_マイナス1倍.typ",
    sourceOrdinal: 9,
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
    sourcePath: "_old/typst/parts/000_計算公式/009_definition_sqrt_minus_1.typ",
    sourceOrdinal: 10,
    title: { tex: "\\sqrt{-1}" },
    labels: [],
    statement: [
      displayMath("\\sqrt{-1}:=\\sqrt{-1_{\\mathbb{C}}}"),
    ],
  },
]);
