import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "calc_formulae_010_definition_real_imag_parts_of_cc",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/010_definition_CCの実部虚部.typ", ordinal: 11 },
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
    origin: { path: "_old/typst/parts/000_計算公式/011_definition_単位円.typ", ordinal: 12 },
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
    origin: { path: "_old/typst/parts/000_計算公式/012_definition_円弧の定義.typ", ordinal: 13 },
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
    origin: { path: "_old/typst/parts/000_計算公式/013_definition_CCからC_unitへの写像.typ", ordinal: 14 },
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
    origin: { path: "_old/typst/parts/000_計算公式/014_definition_CCの逆三角関数の定義.typ", ordinal: 15 },
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
    origin: { path: "_old/typst/parts/000_計算公式/015_claim_cos_arctan_sin_arctan.typ", ordinal: 16 },
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
    origin: { path: "_old/typst/parts/000_計算公式/016_definition_角度表現の同値類.typ", ordinal: 17 },
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
    id: "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_10_19.ts", ordinal: 17 },
    title: { tex: String.raw`0\le\theta-2n\pi<2\pi \text{ なる } n\in\mathbb{Z} \text{ の存在と一意性}` },
    labels: ["angle_section_existence_uniqueness"],
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
        "以下では非可算集合 ",
        math(String.raw`\mathbb{R}`),
        " の順序体としての構造と、そのアルキメデス性",
      ]),
      displayMath(
        String.raw`\forall a\in\mathbb{R}\ \exists N\in\mathbb{Z}\ \text{s.t.}\ N>a`,
      ),
      paragraph([
        "を使う（アルキメデス性は ",
        math(String.raw`\mathbb{R}`),
        " の完備性から従う。ここが有理数体の代数だけでは閉じない箇所である）。極限・連続性は使わない。",
      ]),
      paragraph([
        "存在。証明の中で使う記号を先に置く。",
        math(String.raw`\pi>0`),
        " より ",
        math(String.raw`2\pi>0`),
        " であるから ",
        math(String.raw`t:=\dfrac{\theta}{2\pi}\in\mathbb{R}`),
        " が定まる。アルキメデス性を ",
        math(String.raw`a=t`),
        " に適用して ",
        math(String.raw`N>t`),
        " なる ",
        math(String.raw`N\in\mathbb{Z}`),
        " を、",
        math(String.raw`a=-t`),
        " に適用して ",
        math(String.raw`M>-t`),
        " なる ",
        math(String.raw`M\in\mathbb{Z}`),
        " をとり、集合",
      ]),
      displayMath(String.raw`S:=\{\,m\in\mathbb{Z} \mid -M\le m\le N \ \wedge\ m\le t\,\}`),
      paragraph([
        "を置く。",
      ]),
      paragraph([
        "準備の第一は ",
        math(String.raw`-M<t`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
-M
&<-(-t)
&&(\because\ M>-t\ \text{の両辺に}\ -1\ \text{を掛けると不等号の向きが変わる})\\
&=t
&&(\because\ -(-t)=t)
\end{aligned}`),
      paragraph([
        "準備の第二は ",
        math(String.raw`n:=\max S\in\mathbb{Z}`),
        " が定まることである。",
        math(String.raw`-M<t`),
        " と ",
        math(String.raw`-M<t<N`),
        " より ",
        math(String.raw`-M\in S`),
        " なので ",
        math(String.raw`S`),
        " は空でなく、",
        math(String.raw`\{m\in\mathbb{Z}\mid -M\le m\le N\}`),
        " の部分集合として有限である。有限かつ空でない整数の集合は最大元をもつ。",
      ]),
      paragraph([
        "準備の第三は ",
        math(String.raw`n\le t`),
        " である。これは ",
        math(String.raw`n\in S`),
        " と ",
        math(String.raw`S`),
        " の定め方から出る。",
      ]),
      paragraph([
        "準備の第四は ",
        math(String.raw`t<n+1`),
        " である。",
        math(String.raw`n+1\le t`),
        " と仮定すると ",
        math(String.raw`n+1\le t<N`),
        " かつ ",
        math(String.raw`-M\le n<n+1`),
        " より ",
        math(String.raw`n+1\in S`),
        " となり、",
        math(String.raw`n=\max S`),
        " に矛盾する。",
      ]),
      paragraph([
        "以上のもとで、下界は",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&=2\pi\cdot0
&&(\because\ 0\ \text{との積は}\ 0)\\
&\le2\pi(t-n)
&&(\because\ \text{準備の第三の}\ n\le t\ \text{より}\ 0\le t-n\ \text{、および}\ 2\pi>0)\\
&=2\pi t-2n\pi
&&(\because\ \text{分配則})\\
&=\theta-2n\pi
&&(\because\ t\ \text{の定め方より}\ \theta=2\pi t)
\end{aligned}`),
      paragraph([
        "であり、上界は",
      ]),
      displayMath(String.raw`\begin{aligned}
\theta-2n\pi
&=2\pi t-2n\pi
&&(\because\ t\ \text{の定め方より}\ \theta=2\pi t)\\
&=2\pi(t-n)
&&(\because\ \text{分配則})\\
&<2\pi\cdot1
&&(\because\ \text{準備の第四の}\ t<n+1\ \text{より}\ t-n<1\ \text{、および}\ 2\pi>0)\\
&=2\pi
&&(\because\ 1\ \text{との積は変わらない})
\end{aligned}`),
      paragraph([
        "である。すなわち ",
        math(String.raw`0\le\theta-2n\pi<2\pi`),
        " を満たす ",
        math(String.raw`n\in\mathbb{Z}`),
        " が存在する。",
      ]),
      paragraph([
        "一意性。",
        math(String.raw`n,n'\in\mathbb{Z}`),
        " がともに ",
        math(String.raw`0\le\theta-2n\pi<2\pi`),
        "、",
        math(String.raw`0\le\theta-2n'\pi<2\pi`),
        " を満たすとする。下から評価すると",
      ]),
      displayMath(String.raw`\begin{aligned}
2(n'-n)\pi
&=(\theta-2n\pi)-(\theta-2n'\pi)
&&(\because\ \text{右辺を展開すると}\ 2n'\pi-2n\pi\ \text{になる})\\
&>0-2\pi
&&(\because\ 0\le\theta-2n\pi\ \text{と}\ \theta-2n'\pi<2\pi)\\
&=-2\pi
&&(\because\ 0\ \text{から引くと符号が変わる})
\end{aligned}`),
      paragraph([
        "であり、上から評価すると",
      ]),
      displayMath(String.raw`\begin{aligned}
2(n'-n)\pi
&=(\theta-2n\pi)-(\theta-2n'\pi)
&&(\because\ \text{右辺を展開すると}\ 2n'\pi-2n\pi\ \text{になる})\\
&<2\pi-0
&&(\because\ \theta-2n\pi<2\pi\ \text{と}\ 0\le\theta-2n'\pi)\\
&=2\pi
&&(\because\ 0\ \text{を引いても変わらない})
\end{aligned}`),
      paragraph([
        "である。各辺を ",
        math(String.raw`2\pi>0`),
        " で割って ",
        math(String.raw`-1<n'-n<1`),
        " を得る。",
        math(String.raw`n'-n\in\mathbb{Z}`),
        " であり、この範囲にある整数は ",
        math(String.raw`0`),
        " のみであるから ",
        math(String.raw`n'=n`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）の角度表現の切断の定義（labels: section_of_angle_representation）は" +
          "この存在と一意性を「証明略」としており、実際の証明は" +
          "labels: sqrt_expansion_via_polar の proof の Step 1 に書かれていた" +
          "（定義が依存する事実を、その定義を使う側の主張の中で証明するという依存の逆転）。" +
          "これを解消するため、独立した claim として切り出し、文書順で" +
          "section_of_angle_representation より前に置いた。証明内容は Step 1 と同一である。",
        "2026-08-08: 式変形の書き方の統一。存在の側は、記号を置く部分（t・N・M・S）を冒頭にまとめ、" +
          "そこから使う 4 つの事実（-M<t、max S が定まること、n≤t、t<n+1）を準備として名前で並べ、" +
          "そのうえで下界と上界をそれぞれ一続きの式にした。原文は 0≤t-n<1 を出してから" +
          "「2π>0 を掛けて」と日本語で継いで結論の不等式を 1 行で置いており、" +
          "分配則と θ=2πt の代入がどこで効いたのかが式に書かれていなかった。" +
          "一意性の側は、原文が 2 つの不等式を辺々引いて -2π<…<2π を 1 行で書いていたのを、" +
          "下からの評価と上からの評価の 2 つの鎖へ分けた（1 行では、どちらの端がどちらの仮定から" +
          "出たのかが書かれない）。各行の末尾へ (∵ …) を付けた。ステップは減らしていない。",
      ],
    },
  },
  {
    id: "calc_formulae_017_definition_section_of_angle_representation",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/017_definition_角度表現の切断.typ", ordinal: 18 },
    title: { text: "角度表現の切断" },
    labels: ["section_of_angle_representation"],
    statement: [
      paragraph([math("s_{[0,2\\pi)}:\\mathbb{R}/\\sim_{\\mathrm{angle}}\\to[0,2\\pi)"), " を以下のように定める。"]),
      paragraph([math("[\\theta]_{\\sim_{\\mathrm{angle}}}\\in\\mathbb{R}/\\sim_{\\mathrm{angle}}"), " に対して、"]),
      paragraph([
        math("n\\in\\mathbb{Z}"),
        " で ",
        math("0\\le\\theta-2n\\pi<2\\pi"),
        " を満たすようなものがただ一つ存在して（",
        ref("angle_section_existence_uniqueness"),
        "）、",
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
    origin: { path: "_old/typst/parts/000_計算公式/018_definition_RRの角度表現.typ", ordinal: 19 },
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
    origin: { path: "_old/typst/parts/000_計算公式/019_definition_極座標表現の同値類.typ", ordinal: 20 },
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
