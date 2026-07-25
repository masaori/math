import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

// 旧 calculation_formulae_021（極座標表現の同値類の性質の remark）は、定義から直ちに従う
// 読み手向けの補足であり出版本文には載らないため、
// notes/000_calculation_formulae.mjs（targets: polar_equivalence_class）へ移設した。
export default defineBlocks([
  {
    id: "calculation_formulae_022_definition_operations_on_polar_representation",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/021_definition_極座標表現の演算.typ",
    sourceOrdinal: 22,
    title: {
      text: "極座標表現の演算",
    },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\left((\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim\right)`),
        " に二項演算 ",
        math(String.raw`\cdot`),
        " を次で定める。",
      ]),
      displayMath(
        String.raw`\cdot : \left((\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim\right)\times\left((\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim\right)\to\left((\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim\right)`,
      ),
      displayMath(
        String.raw`\left([(r,\theta)]_{\sim},[(r',\theta')]_{\sim}\right)\mapsto[(rr',\theta+\theta')]_{\sim}`,
      ),
      paragraph(["この構造を「極座標表現」と呼ぶ。"]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/022_claim_極座標表現の乗法群.typ",
    sourceOrdinal: 23,
    title: {
      text: "（極座標表現）の乗法群",
    },
    labels: [],
    statement: [
      paragraph(["（極座標表現）は二項演算 ", math(String.raw`\cdot`), " についてモノイドをなす。"]),
      displayMath(
        String.raw`(\text{極座標表現})^{\times} := (\text{極座標表現})\setminus\{[(0,0)]_{\sim}\}`,
      ),
      paragraph(["は二項演算 ", math(String.raw`\cdot`), " について群をなす。"]),
      paragraph([
        math(String.raw`[(r,\theta)]_{\sim}`),
        "（",
        math(String.raw`r\ne 0`),
        "）の逆元は",
      ]),
      displayMath(String.raw`\left([(r,\theta)]_{\sim}\right)^{-1}=[(1/r,-\theta)]_{\sim}`),
    ],
    proof: [todo("TODO")],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/023_claim_CCの乗法群.typ",
    sourceOrdinal: 24,
    title: {
      tex: "\\mathbb{C}\\text{の乗法群}",
    },
    labels: [],
    statement: [
      displayMath(String.raw`\mathbb{C}^{\times}:=\mathbb{C}\setminus\{(0,0)\}`),
      paragraph(["は群をなす。"]),
      paragraph([
        math(String.raw`z\in\mathbb{C},\ z\ne 0`),
        " に対して逆元を ",
        math(String.raw`z^{-1}`),
        " と書き、",
      ]),
      displayMath(String.raw`z^{-1}=1/z`),
    ],
    proof: [todo("TODO")],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_025_claim_complex_numbers_form_a_field",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/024_claim_CCは体をなす.typ",
    sourceOrdinal: 25,
    title: {
      tex: "\\mathbb{C}\\text{は体}",
    },
    labels: [],
    statement: [paragraph([math(String.raw`\mathbb{C}`), " は体をなす。"])],
    proof: [todo("TODO")],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_026_claim_polar_representation_forms_a_field",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/025_claim_極座標表現は体をなす.typ",
    sourceOrdinal: 26,
    title: {
      text: "極座標表現は体",
    },
    labels: [],
    statement: [paragraph(["（極座標表現）は体をなす。"])],
    proof: [todo("TODO")],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_027_definition_phi_polar",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/026_definition_極座標表現のCCへの写像_phi_polar.typ",
    sourceOrdinal: 27,
    title: {
      tex: "\\text{極座標表現の}\\mathbb{C}\\text{への写像}",
    },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\phi_{\mathrm{polar}} : \mathbb{C} \to (\text{極座標表現})`),
        " を次で定める。",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(x,y):=
\begin{cases}
	\left[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\ge 0}},\arctan(y/x))\right]_{\sim} & (x>0),\\
	\left[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\ge 0}},\arctan(y/x)+\pi)\right]_{\sim} & (x<0,\ y\ge 0),\\
	\left[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\ge 0}},\arctan(y/x)-\pi)\right]_{\sim} & (x<0,\ y<0),\\
\left[(y,\pi/2)\right]_{\sim} & (x=0,\ y>0),\\
\left[(-y,-\pi/2)\right]_{\sim} & (x=0,\ y<0),\\
\left[(0,0)\right]_{\sim} & (x=0,\ y=0).
\end{cases}`,
      ),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_028_definition_phi_cartesian",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/027_definition_CCの極座標表現への写像_phi_cartesian.typ",
    sourceOrdinal: 28,
    title: {
      tex: "\\mathbb{C}\\text{の極座標表現への写像}",
    },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\phi_{\mathrm{cartesian}} : (\text{極座標表現}) \to \mathbb{C}`),
        " を次で定める。",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{cartesian}}([(r,\theta)]_{\sim}) := (r\cos\theta,\ r\sin\theta)`,
      ),
      paragraph([
        "この右辺は同値類の代表元の取り方によらないので、",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は well-defined である。実際、",
      ]),
      displayMath(
        String.raw`[\theta]_{\sim_{\mathrm{angle}}}=[\theta']_{\sim_{\mathrm{angle}}}
\Rightarrow \exists n\in\mathbb{Z}\ \text{s.t.}\ \theta-\theta'=2n\pi
\Rightarrow \cos\theta=\cos\theta',\ \sin\theta=\sin\theta'`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "定義の well-defined 性（代表元によらないこと）は、原文では note に置かれていたが" +
          "定義の妥当性そのものなので statement へ格上げした。",
      ],
    },
  },
  {
    id: "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    kind: "claim",
    sourcePath:
      "parts/000_計算公式/028_claim_phi_cartesianの同型性_モノイド準同型と全単射.typ",
    sourceOrdinal: 29,
    title: {
      tex: "\\phi_{\\mathrm{cartesian}}\\text{の同型性}",
    },
    labels: ["isomorphism_of_phi_cartesian"],
    statement: [
      paragraph(["（TODO: 原稿注記「体として同型を示す」あり）"]),
      paragraph([
        math(String.raw`A,B\in(\text{極座標表現})`),
        " に対して次が成り立つ。",
      ]),
      list([
        [
          math(
            String.raw`\phi_{\mathrm{cartesian}}(A\cdot B)=\phi_{\mathrm{cartesian}}(A)\cdot\phi_{\mathrm{cartesian}}(B)`,
          ),
          "（モノイド準同型）",
        ],
        [math(String.raw`\phi_{\mathrm{cartesian}}`), " は全単射。"],
      ]),
    ],
    proof: [
      paragraph([
        "1. モノイド準同型性。",
        math(String.raw`[(r,\theta)]_{\sim}, [(r',\theta')]_{\sim} \in (\text{極座標表現})`),
        " に対して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}([(r,\theta)]_{\sim}\cdot[(r',\theta')]_{\sim})
&= \phi_{\mathrm{cartesian}}([(rr',\theta+\theta')]_{\sim}) \\
&= (rr'\cos(\theta+\theta'),\ rr'\sin(\theta+\theta'))
\end{aligned}`,
      ),
      paragraph(["また、"]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}([(r,\theta)]_{\sim})\cdot\phi_{\mathrm{cartesian}}([(r',\theta')]_{\sim})
&= (r\cos\theta,\ r\sin\theta)\cdot(r'\cos\theta',\ r'\sin\theta') \\
&= (rr'\cos\theta\cos\theta' - rr'\sin\theta\sin\theta',\ rr'\cos\theta\sin\theta' + rr'\sin\theta\cos\theta') \\
&= (rr'(\cos\theta\cos\theta'-\sin\theta\sin\theta'),\ rr'(\cos\theta\sin\theta'+\sin\theta\cos\theta')) \\
&= (rr'\cos(\theta+\theta'),\ rr'\sin(\theta+\theta'))
\end{aligned}`,
      ),
      paragraph([
        "よって両者は一致する（積 ",
        math(String.raw`(a,b)\cdot(c,d) := (ac-bd,\ ad+bc)`),
        " と三角関数の加法定理を用いた）。",
      ]),
      paragraph([
        "2. 全単射性。合成 ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}`),
        " を計算する。以下で ",
        math(String.raw`\cos(\arctan(y/x))=\dfrac{1}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}`),
        "、",
        math(String.raw`\sin(\arctan(y/x))=\dfrac{y/x}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}`),
        "（",
        ref("cos_arctan_sin_arctan"),
        "）と、",
        math(String.raw`x<0`),
        " のとき ",
        math(String.raw`x=-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}`),
        "（",
        ref("negative_number_to_sqrt"),
        "）を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\!\left(
\begin{cases}
[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x))]_{\sim} & (x>0) \\
[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)+\pi)]_{\sim} & (x<0,\ y\geq 0) \\
[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)-\pi)]_{\sim} & (x<0,\ y<0) \\
[(y,\ \pi/2)]_{\sim} & (x=0 \wedge y>0) \\
[(-y,\ -\pi/2)]_{\sim} & (x=0 \wedge y<0) \\
[(0,0)]_{\sim} & (x=0 \wedge y=0)
\end{cases}\right) \\[4pt]
&= \begin{cases}
(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))) & (x>0) \\
(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)+\pi),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x)+\pi)) & (x<0,\ y\geq 0) \\
(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)-\pi),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x)-\pi)) & (x<0,\ y<0) \\
(y\cos(\pi/2),\ y\sin(\pi/2)) & (x=0 \wedge y>0) \\
(-y\cos(-\pi/2),\ -y\sin(-\pi/2)) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&= \begin{cases}
(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))) & (x>0) \\
(-\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ -\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))) & (x<0) \\
(y\cos(\pi/2),\ y\sin(\pi/2)) & (x=0 \wedge y>0) \\
(-y\cos(-\pi/2),\ -y\sin(-\pi/2)) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&\overset{(\ast)}{=} \begin{cases}
\left(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\dfrac{1}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\dfrac{y/x}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x>0) \\
\left(-\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\dfrac{1}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\ -\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\dfrac{y/x}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x<0) \\
(0,\ y) & (x=0 \wedge y>0) \\
(0,\ y) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&\overset{(\ast\ast)}{=} \begin{cases}
\left(\dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\ \dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x>0) \\
\left(\dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\ \dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x<0) \\
(0,\ y) & (x=0 \wedge y>0) \\
(0,\ y) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&= \begin{cases}
\left(\dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}},\ \dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x>0) \\
\left(\dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}},\ \dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x<0) \\
(0,\ y) & (x=0 \wedge y>0) \\
(0,\ y) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&= (x,y)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(\ast)`),
        " は ",
        ref("cos_arctan_sin_arctan"),
        " による（",
        math(String.raw`x=0`),
        " の行では ",
        math(String.raw`\cos(\pm\pi/2)=0`),
        "、",
        math(String.raw`\sin(\pi/2)=1`),
        "、",
        math(String.raw`\sin(-\pi/2)=-1`),
        " を用いた）。",
        math(String.raw`(\ast\ast)`),
        " は分母・分子に ",
        math(String.raw`x`),
        " を掛け、",
        ref("negative_number_to_sqrt"),
        " により ",
        math(String.raw`x>0`),
        " のとき ",
        math(String.raw`x=\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}`),
        "、",
        math(String.raw`x<0`),
        " のとき ",
        math(String.raw`x=-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}`),
        " を用いた（",
        math(String.raw`x<0`),
        " では負号が分母の負号と相殺する）。続いて ",
        math(String.raw`x^2(1+(y/x)^2)=x^2+y^2`),
        "、",
        math(String.raw`(-x)^2=x^2`),
        " による。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の part 2 は phi_cartesian ∘ phi_polar = id_CC を示すところまでで、全単射（特に単射性）の明示的な導出は原文にない。ここでは原文の計算を全ステップ忠実に再現した。",
      ],
    },
  },
  {
    id: "calculation_formulae_030_definition_first_and_second_projections",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/029_definition_第1座標と第2座標_pr1_pr2.typ",
    sourceOrdinal: 30,
    title: {
      text: "第1座標, 第2座標",
    },
    labels: [],
    statement: [
      paragraph([math(String.raw`[(r,\theta)]_{\sim}\in(\text{極座標表現})`), " について、"]),
      displayMath(
        String.raw`\operatorname{pr}_1 : (\text{極座標表現})\to\mathbb{R}_{\ge 0},\quad
[(r,\theta)]_{\sim}\mapsto r`,
      ),
      displayMath(
        String.raw`\operatorname{pr}_2 : (\text{極座標表現})\to(\text{角度表現}),\quad
[(r,\theta)]_{\sim}\mapsto
\begin{cases}
[0]_{\sim_{\mathrm{angle}}} & (r=0),\\
[\theta]_{\sim_{\mathrm{angle}}} & (r\ne 0).
\end{cases}`,
      ),
    ],
    conversion: {
      status: "converted",
    },
  },
]);
