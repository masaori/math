import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "calc_formulae_010_definition_real_imag_parts_of_cc",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/010_definition_CCの実部虚部.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/011_definition_単位円.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/012_definition_円弧の定義.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/013_definition_CCからC_unitへの写像.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/014_definition_CCの逆三角関数の定義.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/015_claim_cos_arctan_sin_arctan.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/016_definition_角度表現の同値類.typ",
    sourceOrdinal: 17,
    title: { text: "角度表現の同値類" },
    labels: ["angle_equivalence_class"],
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
    id: "calc_formulae_016b_claim_unique_angle_reduction_mod_2pi",
    kind: "claim",
    sourcePath: "structured-latex/content/000_calculation_formulae_10_19.mjs",
    sourceOrdinal: 17,
    title: { tex: String.raw`\text{角度の }[0,2\pi)\text{ への一意な還元}` },
    labels: ["unique_angle_reduction_mod_2pi"],
    statement: [
      paragraph([
        math(String.raw`\theta\in\mathbb{R}`),
        " について、",
      ]),
      displayMath(String.raw`0\le\theta-2n\pi<2\pi`),
      paragraph([
        "を満たす ",
        math(String.raw`n\in\mathbb{Z}`),
        " がただ一つ存在する。",
      ]),
    ],
    proof: [
      paragraph([
        "存在。",
        math(String.raw`\pi>0`),
        " より ",
        math(String.raw`2\pi>0`),
        " であるから ",
        math(String.raw`t:=\dfrac{\theta}{2\pi}\in\mathbb{R}`),
        " が定まる。",
        math(String.raw`\mathbb{R}`),
        " のアルキメデス性（",
        math(String.raw`\forall a\in\mathbb{R}\ \exists N\in\mathbb{Z}\ \text{s.t.}\ N>a`),
        "）を ",
        math(String.raw`a=t`),
        " と ",
        math(String.raw`a=-t`),
        " に適用し、",
        math(String.raw`N>t`),
        " なる ",
        math(String.raw`N\in\mathbb{Z}`),
        " と ",
        math(String.raw`M>-t`),
        " なる ",
        math(String.raw`M\in\mathbb{Z}`),
        " をとる。ここで ",
        math(String.raw`-M<t`),
        " である。集合",
      ]),
      displayMath(String.raw`S:=\{\,m\in\mathbb{Z} \mid -M\le m\le N \ \wedge\ m\le t\,\}`),
      paragraph([
        "は ",
        math(String.raw`-M\in S`),
        "（",
        math(String.raw`-M<t`),
        " かつ ",
        math(String.raw`-M<t<N`),
        "）より空でなく、",
        math(String.raw`\{m\in\mathbb{Z}\mid -M\le m\le N\}`),
        " の部分集合として有限である。有限かつ空でない整数の集合は最大元をもつので、",
        math(String.raw`n:=\max S\in\mathbb{Z}`),
        " が定まる。",
        math(String.raw`n\in S`),
        " より ",
        math(String.raw`n\le t`),
        "。また ",
        math(String.raw`n+1\le t`),
        " と仮定すると ",
        math(String.raw`n+1\le t<N`),
        " かつ ",
        math(String.raw`-M\le n<n+1`),
        " より ",
        math(String.raw`n+1\in S`),
        " となり ",
        math(String.raw`n=\max S`),
        " に矛盾する。よって ",
        math(String.raw`t<n+1`),
        "。以上より ",
        math(String.raw`0\le t-n<1`),
        " であり、",
        math(String.raw`2\pi>0`),
        " を掛けて",
      ]),
      displayMath(String.raw`0\le 2\pi t-2n\pi<2\pi,\qquad \text{すなわち}\quad 0\le\theta-2n\pi<2\pi`),
      paragraph([
        "一意性。",
        math(String.raw`n,n'\in\mathbb{Z}`),
        " がともに ",
        math(String.raw`0\le\theta-2n\pi<2\pi`),
        "、",
        math(String.raw`0\le\theta-2n'\pi<2\pi`),
        " を満たすとする。第 2 式の各辺を第 1 式から辺々引くと",
      ]),
      displayMath(
        String.raw`-2\pi<(\theta-2n\pi)-(\theta-2n'\pi)=2(n'-n)\pi<2\pi`,
      ),
      paragraph([
        math(String.raw`2\pi>0`),
        " で割って ",
        math(String.raw`-1<n'-n<1`),
        "。",
        math(String.raw`n'-n\in\mathbb{Z}`),
        " であり、この範囲にある整数は ",
        math(String.raw`0`),
        " のみであるから ",
        math(String.raw`n'=n`),
        "。",
      ]),
      paragraph([
        "なお、本証明で ",
        math(String.raw`\mathbb{R}`),
        " について使ったのは順序体の公理とアルキメデス性だけであり、完備性（上限性質）は使っていない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。この存在と一意性は、角度表現の切断" +
          "（labels: section_of_angle_representation）の定義が well-defined であるために必要な事実だが、" +
          "原文では切断の定義側が「証明略」とし、それを使う側の主張" +
          "（labels: sqrt_expansion_via_polar）の proof の Step 1 で証明する、という依存の逆転が" +
          "起きていた。これを解消するため、Step 1 の内容を独立した claim として切り出し、" +
          "文書順で切断の定義より前に置いた。切断の定義と sqrt_expansion_via_polar の両方が" +
          "本ブロックを参照する。",
      ],
    },
  },
  {
    id: "calc_formulae_017_definition_section_of_angle_representation",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/017_definition_角度表現の切断.typ",
    sourceOrdinal: 18,
    title: { text: "角度表現の切断" },
    labels: ["section_of_angle_representation"],
    statement: [
      paragraph([math("s_{[0,2\\pi)}:\\mathbb{R}/\\sim_{\\mathrm{angle}}\\to[0,2\\pi)"), " を以下のように定める。"]),
      paragraph([math("[\\theta]_{\\sim_{\\mathrm{angle}}}\\in\\mathbb{R}/\\sim_{\\mathrm{angle}}"), " に対して、代表元 ", math("\\theta\\in\\mathbb{R}"), " をとる。"]),
      paragraph([
        math("n\\in\\mathbb{Z}"),
        " で ",
        math("0\\le\\theta-2n\\pi<2\\pi"),
        " を満たすようなものがただ一つ存在する（",
        ref("unique_angle_reduction_mod_2pi"),
        "）。この ",
        math("n"),
        " を用いて、",
      ]),
      displayMath("s_{[0,2\\pi)}([\\theta]_{\\sim_{\\mathrm{angle}}}):=\\theta-2n\\pi"),
      paragraph([
        "と定める。この定義は代表元 ",
        math("\\theta"),
        " の取り方によらず、値は ",
        math("[0,2\\pi)"),
        " に属する（下の proof）。",
      ]),
    ],
    proof: [
      paragraph([
        "代表元の取り方によらないこと。",
        math("\\theta'\\in\\mathbb{R}"),
        " を同じ同値類の別の代表元とすると、",
        ref("angle_equivalence_class"),
        " より ",
        math("k\\in\\mathbb{Z}"),
        " が存在して ",
        math("\\theta'-\\theta=2k\\pi"),
        "。",
        math("n'\\in\\mathbb{Z}"),
        " を ",
        math("0\\le\\theta'-2n'\\pi<2\\pi"),
        " を満たす（",
        ref("unique_angle_reduction_mod_2pi"),
        " により一意な）整数とすると、",
        math("\\theta-2(n'-k)\\pi=\\theta'-2k\\pi-2(n'-k)\\pi=\\theta'-2n'\\pi\\in[0,2\\pi)"),
        " であるから、",
        math("n'-k\\in\\mathbb{Z}"),
        " も ",
        math("\\theta"),
        " に対する条件を満たす。",
        ref("unique_angle_reduction_mod_2pi"),
        " の一意性より ",
        math("n=n'-k"),
        " であり、",
      ]),
      displayMath("\\theta'-2n'\\pi=(\\theta+2k\\pi)-2(n+k)\\pi=\\theta-2n\\pi"),
      paragraph([
        "となって値は一致する。よって ",
        math("s_{[0,2\\pi)}"),
        " は well-defined であり、値域が ",
        math("[0,2\\pi)"),
        " に収まることも ",
        math("0\\le\\theta-2n\\pi<2\\pi"),
        " から従う。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）は「ただ一つ存在して（証明略）」だった。この存在・一意性は" +
          "labels: unique_angle_reduction_mod_2pi として直前に切り出して証明したので、そこを参照する形へ" +
          "変更した。あわせて、原文が触れていなかった代表元の取り方によらないこと（well-defined 性）を" +
          "statement に追加して証明した（切断の定義が意味をもつために必要な事実であり、注記ではない）。",
      ],
    },
  },
  {
    id: "calc_formulae_018_definition_angle_representation_of_rr",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/018_definition_RRの角度表現.typ",
    sourceOrdinal: 19,
    title: { tex: "\\mathbb{R}\\text{の角度表現}" },
    labels: ["angle_representation_of_rr"],
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
    sourcePath: "_old/typst/parts/000_計算公式/019_definition_極座標表現の同値類.typ",
    sourceOrdinal: 20,
    title: { text: "極座標表現の同値類" },
    labels: ["polar_equivalence_class"],
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
