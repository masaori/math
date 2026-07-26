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
      paragraph(["を満たすものがただ一つ存在する（証明略）。"]),
      paragraph(["この ", math("y"), " を用いて"]),
      displayMath(String.raw`\sqrt{x}^{(\mathbb{R}_{\ge 0})}:=y`),
      paragraph(["と定める。"]),
    ],
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
