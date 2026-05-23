import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "calc_formulae_000_cosh_sinh_product",
    kind: "theorem",
    sourcePath: "parts/000_計算公式/000_theorem_cosh_sinhの掛け算.typ",
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
    id: "calc_formulae_001_sqrt_nonnegative_real",
    kind: "definition",
    sourcePath: "parts/000_計算公式/001_definition_非負実数のsqrt.typ",
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
    sourcePath: "parts/000_計算公式/002_theorem_負数からsqrtへの変換.typ",
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
    sourcePath: "parts/000_計算公式/003_theorem_行列の分解.typ",
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
    sourcePath: "parts/000_計算公式/004_theorem_行列の組みへの作用.typ",
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
    sourcePath: "parts/000_計算公式/005_theorem_行列の共役.typ",
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
    sourcePath: "parts/000_計算公式/006_definition_CCの定義.typ",
    sourceOrdinal: 7,
    title: { tex: "\\mathbb{C}\\text{の定義}" },
    labels: [],
    statement: [
      paragraph([math("\\mathbb{C}:=\\mathbb{R}^2"), " に、以下の演算を入れたもの。"]),
      paragraph(["積"]),
      displayMath("(a,b)\\cdot(c,d):=(ac-bd,ad+bc)"),
    ],
  },
  {
    id: "calc_formulae_007_inclusion_rr_to_cc",
    kind: "definition",
    sourcePath: "parts/000_計算公式/007_definition_RRからCCへの包含写像.typ",
    sourceOrdinal: 8,
    title: { tex: "\\mathbb{R}\\to\\mathbb{C}\\text{の包含写像}" },
    labels: [],
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
    sourcePath: "parts/000_計算公式/008_definition_マイナス1倍.typ",
    sourceOrdinal: 9,
    title: { tex: "-1\\text{倍}" },
    labels: [],
    statement: [
      paragraph([math("z\\in\\mathbb{C}"), " について、"]),
      displayMath("-z:=(-1_{\\mathbb{C}})\\cdot z"),
    ],
  },
  {
    id: "calc_formulae_009_sqrt_minus_one",
    kind: "definition",
    sourcePath: "parts/000_計算公式/009_definition_sqrt_minus_1.typ",
    sourceOrdinal: 10,
    title: { tex: "\\sqrt{-1}" },
    labels: [],
    statement: [
      displayMath("\\sqrt{-1}:=\\sqrt{-1_{\\mathbb{C}}}"),
    ],
  },
]);
