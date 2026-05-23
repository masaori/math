import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "calculation_formulae_021_remark_polar_equivalence_class_properties",
    kind: "remark",
    sourcePath: "parts/000_計算公式/020_remark_極座標表現の同値類の性質.typ",
    sourceOrdinal: 21,
    title: null,
    labels: [],
    statement: [
      displayMath(String.raw`[(r,\theta)]_{\sim} = [(r,\theta + 2n\pi)]_{\sim}\quad \forall n \in \mathbb{Z}`),
      displayMath(
        String.raw`[(0,\theta)]_{\sim} = [(0,\theta')]_{\sim}\quad \forall \theta,\theta' \in \mathbb{R}`,
      ),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_022_definition_operations_on_polar_representation",
    kind: "definition",
    sourcePath: "parts/000_計算公式/021_definition_極座標表現の演算.typ",
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
    sourcePath: "parts/000_計算公式/022_claim_極座標表現の乗法群.typ",
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
    sourcePath: "parts/000_計算公式/023_claim_CCの乗法群.typ",
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
    sourcePath: "parts/000_計算公式/024_claim_CCは体をなす.typ",
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
    sourcePath: "parts/000_計算公式/025_claim_極座標表現は体をなす.typ",
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
    sourcePath: "parts/000_計算公式/026_definition_極座標表現のCCへの写像_phi_polar.typ",
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
    sourcePath: "parts/000_計算公式/027_definition_CCの極座標表現への写像_phi_cartesian.typ",
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
    ],
    notes: [
      displayMath(
        String.raw`[\theta]_{\sim_{\mathrm{angle}}}=[\theta']_{\sim_{\mathrm{angle}}}
\Rightarrow \exists n\in\mathbb{Z}\ \text{s.t.}\ \theta-\theta'=2n\pi
\Rightarrow \cos\theta=\cos\theta',\ \sin\theta=\sin\theta'`,
      ),
    ],
    conversion: {
      status: "converted",
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
    labels: [],
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
      paragraph(["1. モノイド準同型性"]),
      displayMath(
        String.raw`\phi_{\mathrm{cartesian}}([(r,\theta)]_{\sim}\cdot[(r',\theta')]_{\sim})
=\phi_{\mathrm{cartesian}}([(rr',\theta+\theta')]_{\sim})
=(rr'\cos(\theta+\theta'),\ rr'\sin(\theta+\theta'))`,
      ),
      displayMath(
        String.raw`\phi_{\mathrm{cartesian}}([(r,\theta)]_{\sim})\cdot\phi_{\mathrm{cartesian}}([(r',\theta')]_{\sim})
=(r\cos\theta,r\sin\theta)\cdot(r'\cos\theta',r'\sin\theta')
=\left(rr'(\cos\theta\cos\theta'-\sin\theta\sin\theta'),\ rr'(\cos\theta\sin\theta'+\sin\theta\cos\theta')\right)
=(rr'\cos(\theta+\theta'),\ rr'\sin(\theta+\theta'))`,
      ),
      paragraph(["よって両者は一致する。"]),
      paragraph(["2. 合成 ", math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}`), " の計算"]),
      paragraph([math(String.raw`\rho:=\sqrt{x^2+y^2}`), " とおくと、"]),
      displayMath(
        String.raw`(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)=
\begin{cases}
\left(\rho\cos(\arctan(y/x)),\ \rho\sin(\arctan(y/x))\right) & (x>0),\\
\left(-\rho\cos(\arctan(y/x)),\ -\rho\sin(\arctan(y/x))\right) & (x<0),\\
\left(y\cos(\pi/2),\ y\sin(\pi/2)\right) & (x=0,\ y>0),\\
\left(-y\cos(-\pi/2),\ -y\sin(-\pi/2)\right) & (x=0,\ y<0),\\
(0,0) & (x=0,\ y=0).
\end{cases}`,
      ),
      paragraph([
        math(String.raw`\cos(\arctan t),\sin(\arctan t)`),
        " の公式は ",
        ref("cos_arctan_sin_arctan"),
        " を使う。",
      ]),
      displayMath(
        String.raw`\cos(\arctan(y/x))=\frac{1}{\sqrt{1+(y/x)^2}},\quad
\sin(\arctan(y/x))=\frac{(y/x)}{\sqrt{1+(y/x)^2}}`,
      ),
      paragraph([
        math(String.raw`x<0`),
        " の場合の符号処理には ",
        ref("negative_number_to_sqrt"),
        "（",
        math(String.raw`x=-\sqrt{(-x)^2}`),
        "）を使う。",
      ]),
      displayMath(
        String.raw`(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
=\begin{cases}
(x,y) & (x>0),\\
(x,y) & (x<0),\\
(0,y) & (x=0,\ y>0),\\
(0,y) & (x=0,\ y<0),\\
(0,0) & (x=0,\ y=0),
\end{cases}
=(x,y)`,
      ),
    ],
    conversion: {
      status: "partially_simplified",
      notes: [
        "原文の長大な三角関数・平方根変形は、論理順序を維持したまま displayMath の要点列に圧縮した。",
        "原文は phi_cartesian ∘ phi_polar = id_CC を詳細計算しているが、全単射のうち単射性の明示的証明は省略されている。",
      ],
    },
  },
  {
    id: "calculation_formulae_030_definition_first_and_second_projections",
    kind: "definition",
    sourcePath: "parts/000_計算公式/029_definition_第1座標と第2座標_pr1_pr2.typ",
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
