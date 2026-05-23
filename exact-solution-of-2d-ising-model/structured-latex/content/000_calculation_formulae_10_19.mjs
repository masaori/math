import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "calc_formulae_010_definition_real_imag_parts_of_cc",
    kind: "definition",
    sourcePath: "parts/000_計算公式/010_definition_CCの実部虚部.typ",
    sourceOrdinal: 11,
    title: { tex: "\\mathbb{C}\\text{の実部/虚部}" },
    labels: [],
    statement: [
      displayMath("x,y\\in\\mathbb{R},\\ (x,y)\\in\\mathbb{C}"),
      displayMath("Re:\\mathbb{C}\\to\\mathbb{R},\\quad (x,y)\\mapsto x"),
      displayMath("Im:\\mathbb{C}\\to\\mathbb{R},\\quad (x,y)\\mapsto y"),
      paragraph([
        "を定め、",
        math("Re(z)"),
        "、",
        math("Im(z)"),
        " をそれぞれ ",
        math("z"),
        " の実部、虚部と呼ぶ。",
      ]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_011_definition_unit_circle",
    kind: "definition",
    sourcePath: "parts/000_計算公式/011_definition_単位円.typ",
    sourceOrdinal: 12,
    title: { text: "単位円" },
    labels: [],
    statement: [
      displayMath("C_{\\mathrm{unit}}:=\\{(x,y)\\in\\mathbb{C}\\mid x^2+y^2=1\\}"),
      paragraph([math("C_{\\mathrm{unit}}"), " を単位円と呼ぶ。"]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_012_definition_arc_length",
    kind: "definition",
    sourcePath: "parts/000_計算公式/012_definition_円弧の定義.typ",
    sourceOrdinal: 13,
    title: { text: "円弧の定義" },
    labels: [],
    statement: [
      displayMath("P:=(x,y),\\ Q:=(x',y')\\in C_{\\mathrm{unit}}"),
      paragraph([
        "について、齋藤微積分 命題 2.1.3 (1) を満たす実数 ",
        math("l(PQ)"),
        " がただ一つ存在し、それを弧 ",
        math("PQ"),
        " の長さと呼ぶ。",
      ]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_013_definition_map_cc_to_c_unit",
    kind: "definition",
    sourcePath: "parts/000_計算公式/013_definition_CCからC_unitへの写像.typ",
    sourceOrdinal: 14,
    title: { tex: "\\mathbb{C}\\to C_{\\mathrm{unit}}" },
    labels: [],
    statement: [
      paragraph([
        math("c_{\\mathrm{unit}}:\\mathbb{C}\\setminus\\{(0,0)\\}\\to C_{\\mathrm{unit}}"),
        " を以下のように定める。",
      ]),
      displayMath("\\forall (x,y)\\in\\mathbb{C}\\setminus\\{(0,0)\\}"),
      paragraph([
        "について、以下を満たすような ",
        math("r\\in\\mathbb{R}_{>0}"),
        " と ",
        math("(x_c,y_c)\\in C_{\\mathrm{unit}}"),
        " がただ一つずつ存在する。",
      ]),
      displayMath("r x_c = x\\land r y_c = y"),
      paragraph(["これを用いて、"]),
      displayMath("c_{\\mathrm{unit}}(x,y):=(x_c,y_c)"),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_014_definition_inverse_trig_functions",
    kind: "definition",
    sourcePath: "parts/000_計算公式/014_definition_CCの逆三角関数の定義.typ",
    sourceOrdinal: 15,
    title: { tex: "\\mathbb{C}\\text{の逆三角関数の定義}" },
    labels: [],
    statement: [
      displayMath("A:=(1,0)\\in\\mathbb{C}"),
      list([
        [
          paragraph([
            "i) ",
            math("\\arcsin:\\{y\\in\\mathbb{R}\\mid -1\\le y\\le 1\\}\\to\\{\\theta\\in\\mathbb{R}\\mid -\\pi/2\\le\\theta\\le\\pi/2\\}"),
            " を以下のように定める。",
          ]),
          paragraph([
            math("y\\in\\mathbb{R},\\ 0\\le y\\le 1"),
            " について、",
            math("P:=(\\sqrt{1-y^2}^{(\\mathbb{R}_{\\ge 0})},y)\\in C_{\\mathrm{unit}}"),
            " とおき、",
          ]),
          displayMath("\\arcsin(y):=l(AP)"),
          paragraph(["と定める。"]),
          paragraph([math("y'\\in\\mathbb{R},\\ -1\\le y'\\le 0"), " について、"]),
          displayMath("\\arcsin(y'):=-\\arcsin(-y')"),
          paragraph(["と定める。"]),
        ],
        [
          paragraph([
            "ii) ",
            math("\\arctan:\\mathbb{R}\\to\\{\\theta\\in\\mathbb{R}\\mid -\\pi/2\\le\\theta\\le\\pi/2\\}"),
            " を以下のように定める。",
          ]),
          paragraph([
            math("x\\in\\mathbb{R}"),
            " について、",
            math("-1\\le x/\\sqrt{1+x^2}^{(\\mathbb{R}_{\\ge 0})}\\le 1"),
            " であるから、",
          ]),
          displayMath("\\arctan(x):=\\arcsin\\left(x/\\sqrt{1+x^2}^{(\\mathbb{R}_{\\ge 0})}\\right)"),
        ],
        [
          paragraph([
            "iii) ",
            math("\\sin:\\{\\theta\\in\\mathbb{R}\\mid -\\pi/2\\le\\theta\\le\\pi/2\\}\\to\\{x\\in\\mathbb{R}\\mid -1\\le x\\le 1\\}"),
            " を以下のように定める。",
          ]),
          paragraph([
            math("\\arcsin"),
            " は ",
            math("\\{x\\in\\mathbb{R}\\mid -1\\le x\\le 1\\}"),
            " において単調増加かつ連続（証明: 齋藤命題2.1.5）であり、値域が ",
            math("\\{x\\in\\mathbb{R}\\mid -\\pi/2\\le x\\le\\pi/2\\}"),
            " であるから、",
          ]),
          paragraph([math("\\arcsin"), " の逆関数が存在し、これを ", math("\\sin"), " と定める。"]),
        ],
        [
          paragraph([
            "iv) ",
            math("\\cos:\\{\\theta\\in\\mathbb{R}\\mid -\\pi/2\\le\\theta\\le\\pi/2\\}\\to\\{x\\in\\mathbb{R}\\mid -1\\le x\\le 1\\}"),
            " を以下のように定める。",
          ]),
          paragraph([
            math("-\\pi/2\\le\\theta\\le\\pi/2"),
            " で ",
            math("-1\\le\\sin(\\theta)\\le 1"),
            " であるから、",
          ]),
          displayMath("\\cos(\\theta):=\\sqrt{1-(\\sin(\\theta))^2}^{(\\mathbb{R}_{\\ge 0})}"),
          paragraph(["と定める。"]),
        ],
      ]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_015_claim_cos_arctan_sin_arctan",
    kind: "claim",
    sourcePath: "parts/000_計算公式/015_claim_cos_arctan_sin_arctan.typ",
    sourceOrdinal: 16,
    title: { tex: "\\cos(\\arctan(x)),\\ \\sin(\\arctan(x))" },
    labels: ["cos_arctan_sin_arctan"],
    statement: [
      paragraph([
        math("x\\in\\mathbb{R}"),
        " について、",
        math("-1\\le x/\\sqrt{1+x^2}^{(\\mathbb{R}_{\\ge 0})}\\le 1"),
        " であるから、",
      ]),
      displayMath(String.raw`\begin{aligned}
\cos(\arctan(x))
&=
\cos\left(\arcsin\left(x/\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}\right)\right)
\\
&=
\sqrt{
1-\left(
x/\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}
\right)^2
}^{(\mathbb{R}_{\ge 0})}
\\
&=
\sqrt{1-\frac{x^2}{1+x^2}}^{(\mathbb{R}_{\ge 0})}
\\
&=
\sqrt{\frac{1}{1+x^2}}^{(\mathbb{R}_{\ge 0})}
\\
&=
\frac{1}{\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}}
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sin(\arctan(x))
&=
\sin\left(\arcsin\left(x/\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}\right)\right)
\\
&=
\frac{x}{\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}}
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_016_definition_angle_equivalence_class",
    kind: "definition",
    sourcePath: "parts/000_計算公式/016_definition_角度表現の同値類.typ",
    sourceOrdinal: 17,
    title: { text: "角度表現の同値類" },
    labels: [],
    statement: [
      paragraph([
        math("\\mathbb{R}"),
        " の同値関係 ",
        math("\\sim_{\\mathrm{angle}}"),
        " を ",
        math("\\theta,\\theta'\\in\\mathbb{R}"),
        " に対して、",
      ]),
      displayMath(
        "\\theta\\sim_{\\mathrm{angle}}\\theta'\\overset{\\mathrm{def}}{\\Longleftrightarrow}\\exists n\\in\\mathbb{Z}\\ \\text{s.t.}\\ (\\theta-\\theta')=2n\\pi",
      ),
      paragraph(["と定めると、商集合 ", math("\\mathbb{R}/\\sim_{\\mathrm{angle}}"), " が定まる。"]),
      paragraph([math("\\theta\\in\\mathbb{R}"), " の ", math("\\mathbb{R}/\\sim_{\\mathrm{angle}}"), " における同値類を"]),
      displayMath("[\\theta]_{\\sim_{\\mathrm{angle}}}\\in\\mathbb{R}/\\sim_{\\mathrm{angle}}"),
      paragraph(["と書く。"]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_017_definition_section_of_angle_representation",
    kind: "definition",
    sourcePath: "parts/000_計算公式/017_definition_角度表現の切断.typ",
    sourceOrdinal: 18,
    title: { text: "角度表現の切断" },
    labels: [],
    statement: [
      paragraph([math("s_{[0,2\\pi)}:\\mathbb{R}/\\sim_{\\mathrm{angle}}\\to[0,2\\pi)"), " を以下のように定める。"]),
      paragraph([math("[\\theta]_{\\sim_{\\mathrm{angle}}}\\in\\mathbb{R}/\\sim_{\\mathrm{angle}}"), " に対して、"]),
      paragraph([
        math("n\\in\\mathbb{Z}"),
        " で ",
        math("0\\le\\theta-2n\\pi<2\\pi"),
        " を満たすようなものがただ一つ存在して（証明略）、",
      ]),
      paragraph(["この ", math("n"), " を用いて、"]),
      displayMath("s_{[0,2\\pi)}([\\theta]_{\\sim_{\\mathrm{angle}}}):=\\theta-2n\\pi"),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_018_definition_angle_representation_of_rr",
    kind: "definition",
    sourcePath: "parts/000_計算公式/018_definition_RRの角度表現.typ",
    sourceOrdinal: 19,
    title: { tex: "\\mathbb{R}\\text{の角度表現}" },
    labels: [],
    statement: [
      paragraph([
        math("\\mathbb{R}"),
        " の（角度表現）を、",
        math("\\mathbb{R}/\\sim_{\\mathrm{angle}}"),
        " に",
      ]),
      displayMath(
        "+:(\\mathbb{R}/\\sim_{\\mathrm{angle}})\\times(\\mathbb{R}/\\sim_{\\mathrm{angle}})\\to\\mathbb{R}/\\sim_{\\mathrm{angle}}",
      ),
      displayMath(
        "([\\theta]_{\\sim_{\\mathrm{angle}}},[\\theta']_{\\sim_{\\mathrm{angle}}})\\mapsto[\\theta+\\theta']_{\\sim_{\\mathrm{angle}}}",
      ),
      displayMath("\\cdot_{\\mathrm{real}}:\\mathbb{R}\\times(\\mathbb{R}/\\sim_{\\mathrm{angle}})\\to\\mathbb{R}/\\sim_{\\mathrm{angle}}"),
      displayMath(
        "(a,[\\theta]_{\\sim_{\\mathrm{angle}}})\\mapsto[a\\cdot s_{[0,2\\pi)}([\\theta]_{\\sim_{\\mathrm{angle}}})]_{\\sim_{\\mathrm{angle}}}",
      ),
      paragraph(["を入れたものとして定める。"]),
    ],
    notes: [
      paragraph([
        "この積 ",
        math("\\cdot_{\\mathrm{real}}"),
        " は、例えば次のようになり、スカラー積とはならない。",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{2}\cdot_{\mathrm{real}}\left(-2\cdot_{\mathrm{real}}[\pi/2]_{\sim_{\mathrm{angle}}}\right)
&=
\left[\frac{1}{2}\cdot s_{[0,2\pi)}\left(\left[-2\cdot s_{[0,2\pi)}([\pi/2]_{\sim_{\mathrm{angle}}})\right]_{\sim_{\mathrm{angle}}}\right)\right]_{\sim_{\mathrm{angle}}}
\\
&=
\left[\frac{1}{2}\cdot s_{[0,2\pi)}([-2\cdot\pi/2]_{\sim_{\mathrm{angle}}})\right]_{\sim_{\mathrm{angle}}}
\\
&=
\left[\frac{1}{2}\cdot s_{[0,2\pi)}([-\pi]_{\sim_{\mathrm{angle}}})\right]_{\sim_{\mathrm{angle}}}
\\
&=
\left[\frac{1}{2}\cdot\pi\right]_{\sim_{\mathrm{angle}}}
\\
&=
\pi/2
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\left(\frac{1}{2}\cdot(-2)\right)\cdot_{\mathrm{real}}[\pi/2]_{\sim_{\mathrm{angle}}}
&=
\left[-1\cdot s_{[0,2\pi)}([\pi/2]_{\sim_{\mathrm{angle}}})\right]_{\sim_{\mathrm{angle}}}
\\
&=
[-1\cdot\pi/2]_{\sim_{\mathrm{angle}}}
\\
&=
-\pi/2
\end{aligned}`),
      paragraph(["より、スカラー積とはならない。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文では最終行が pi/2, -pi/2 と同値類記号なしで書かれているため、そのまま保持した。",
      ],
    },
  },
  {
    id: "calc_formulae_019_definition_polar_equivalence_class",
    kind: "definition",
    sourcePath: "parts/000_計算公式/019_definition_極座標表現の同値類.typ",
    sourceOrdinal: 20,
    title: { text: "極座標表現の同値類" },
    labels: [],
    statement: [
      paragraph([
        math("\\mathbb{R}_{\\ge 0}\\times\\mathbb{R}"),
        " の同値関係 ",
        math("\\sim"),
        " を ",
        math("(r,\\theta),(r',\\theta')\\in\\mathbb{R}_{\\ge 0}\\times\\mathbb{R}"),
        " に対して、",
      ]),
      displayMath(
        "(r,\\theta)\\sim(r',\\theta')\\overset{\\mathrm{def}}{\\Longleftrightarrow}r=r'=0\\lor\\left(r=r'\\land\\theta\\sim_{\\mathrm{angle}}\\theta'\\right)",
      ),
      paragraph(["と定めると、商集合 ", math("(\\mathbb{R}_{\\ge 0}\\times\\mathbb{R})/\\sim"), " が定まる。"]),
      paragraph([
        math("(r,\\theta)\\in\\mathbb{R}_{\\ge 0}\\times\\mathbb{R}"),
        " の ",
        math("(\\mathbb{R}_{\\ge 0}\\times\\mathbb{R})/\\sim"),
        " における同値類を",
      ]),
      displayMath("[(r,\\theta)]_{\\sim}\\in(\\mathbb{R}_{\\ge 0}\\times\\mathbb{R})/\\sim"),
      paragraph(["と書く。"]),
    ],
    conversion: {
      status: "converted",
    },
  },
]);
