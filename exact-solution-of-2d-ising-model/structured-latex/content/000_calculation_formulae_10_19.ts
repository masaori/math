import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "calc_formulae_010_definition_real_imag_parts_of_cc",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/010_definition_CCの実部虚部.typ", ordinal: 11 },
    title: { tex: "\\mathbb{C}\\text{の実部/虚部}" },
    labels: ["def_real_imag_parts"],
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
    labels: ["def_unit_circle"],
    statement: [
      paragraph([ref("definition_of_cc"), " の台集合上で"]),
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
    labels: ["def_arc_length"],
    statement: [
      paragraph([ref("def_unit_circle"), " の点について、"]),
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
    id: "calc_formulae_012b_claim_radial_normalization_exists_unique",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_10_19.ts", ordinal: 13 },
    title: { text: "非零実数対の単位円への正規化" },
    labels: ["radial_normalization_exists_unique"],
    statement: [
      paragraph([ref("def_unit_circle"), " と ", ref("definition_of_sqrt_r_positive"), " を用いる。任意の ", math(String.raw`(x,y)\in\mathbf R^2\setminus\{(0,0)\}`), " に対し、"]),
      displayMath(String.raw`rx_c=x,\quad ry_c=y,\quad r\in\mathbf R_{>0},\quad(x_c,y_c)\in C_{\mathrm{unit}}`),
      paragraph(["を満たす ", math(String.raw`r,(x_c,y_c)`), " が一意に存在する。"]),
    ],
    proof: [
      paragraph([math(String.raw`(x,y)\ne(0,0)`), " なので ", math(String.raw`x\ne0`), " または ", math(String.raw`y\ne0`), " である。実数の平方は非負で、非零実数の平方は正だから ", math(String.raw`x^2+y^2>0`), "。よって"]),
      displayMath(String.raw`r:=\sqrt{x^2+y^2}^{(\mathbb R_{\ge0})}>0,\qquad x_c:=\frac{x}{r},\qquad y_c:=\frac{y}{r}`),
      paragraph(["と定められる。このとき ", math(String.raw`rx_c=x`), " と ", math(String.raw`ry_c=y`), " は ", math(String.raw`x_c,y_c`), " の定義の両辺に ", math(String.raw`r`), " を掛けて得られ、"]),
      displayMath(String.raw`\begin{aligned}
x_c^2+y_c^2
&=\left(\frac{x}{r}\right)^2+\left(\frac{y}{r}\right)^2
 &&\left(\because\ x_c,y_c\text{ の定義}\right)\\
&=\frac{x^2+y^2}{r^2}
 &&\left(\because\ \mathbb R\text{ の四則}\right)\\
&=\frac{x^2+y^2}{x^2+y^2}
 &&\left(\because\ r\text{ の定義と正の平方根の平方（}\text{定義: }\sqrt{\ }^{(\mathbb R_{\ge0})}\text{）}\right)\\
&=1
 &&\left(\because\ x^2+y^2>0\text{ なので約分できる}\right)
\end{aligned}`),
      paragraph(["だから存在する。別の ", math(String.raw`r'>0,(x_c',y_c')\in C_{\mathrm{unit}}`), " が条件を満たすなら"]),
      displayMath(String.raw`\begin{aligned}
x^2+y^2
&=(r'x_c')^2+(r'y_c')^2
 &&\left(\because\ \text{条件 }r'x_c'=x,\ r'y_c'=y\right)\\
&=(r')^2\bigl((x_c')^2+(y_c')^2\bigr)
 &&\left(\because\ \mathbb R\text{ の四則}\right)\\
&=(r')^2
 &&\left(\because\ (x_c',y_c')\in C_{\mathrm{unit}}\text{ の定義式 }(x_c')^2+(y_c')^2=1\right)
\end{aligned}`),
      paragraph(["である。正の平方根の一意性より ", math(String.raw`r'=r`), "。したがって"]),
      displayMath(String.raw`\begin{aligned}
x_c'
&=\frac{x}{r'}
 &&\left(\because\ \text{条件 }r'x_c'=x\text{ の両辺を }r'>0\text{ で割る}\right)\\
&=\frac{x}{r}
 &&\left(\because\ r'=r\right)\\
&=x_c
 &&\left(\because\ x_c\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
y_c'
&=\frac{y}{r'}
 &&\left(\because\ \text{条件 }r'y_c'=y\text{ の両辺を }r'>0\text{ で割る}\right)\\
&=\frac{y}{r}
 &&\left(\because\ r'=r\right)\\
&=y_c
 &&\left(\because\ y_c\text{ の定義}\right)
\end{aligned}`),
      paragraph(["であり一意である。"]),
    ],
    conversion: { status: "added", notes: ["写像定義に混在していた存在一意性を独立させた。"] },
  },
  {
    id: "calc_formulae_013_definition_map_cc_to_c_unit",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/013_definition_CCからC_unitへの写像.typ", ordinal: 14 },
    title: { tex: "\\mathbb{C}\\to C_{\\mathrm{unit}}" },
    labels: ["def_complex_to_unit_circle"],
    statement: [
      paragraph([
        ref("definition_of_cc"), " と ", ref("def_unit_circle"), "、", ref("radial_normalization_exists_unique"), " を用いる。",
        math("c_{\\mathrm{unit}}:\\mathbb{C}\\setminus\\{(0,0)\\}\\to C_{\\mathrm{unit}}"),
        " を以下のように定める。",
      ]),
      displayMath("\\forall (x,y)\\in\\mathbb{C}\\setminus\\{(0,0)\\}"),
      paragraph(["について、上の存在一意性で定まる ", math(String.raw`r,(x_c,y_c)`), " を用いて"]),
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
    title: { tex: "\\arcsin\\text{ の定義}" },
    labels: ["def_arcsin", "def_inverse_trig_functions"],
    statement: [
      paragraph([ref("definition_of_cc"), "、", ref("def_unit_circle"), "、", ref("def_arc_length"), "、", ref("definition_of_sqrt_r_positive"), " の記号を用いる。"]),
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
      ]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calc_formulae_014b_claim_arcsin_bijection",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_10_19.ts", ordinal: 15 },
    title: { text: "arcsin の単調性・連続性・全射性" },
    labels: ["arcsin_is_bijection"],
    statement: [paragraph([ref("def_arcsin"), " は ", math(String.raw`[-1,1]`), " から ", math(String.raw`[-\pi/2,\pi/2]`), " への狭義単調増加な連続全射であり、したがって全単射である。"])],
    proof: [paragraph(["円弧長による定義に対する齋藤微積分 命題 2.1.5 を適用する。狭義単調増加性から単射、値域の記述から全射を得る。"])],
    conversion: { status: "added", notes: ["sin の定義に混在していた外部主張を独立させた。"] },
  },
  {
    id: "calc_formulae_014c_definition_sin",
    kind: "definition",
    origin: { path: "structured-latex/content/000_calculation_formulae_10_19.ts", ordinal: 15 },
    title: { text: "sin の定義" },
    labels: ["def_sin"],
    statement: [paragraph([ref("arcsin_is_bijection"), " により ", ref("def_arcsin"), " の逆関数が存在する。この逆関数を ", math(String.raw`\sin:[-\pi/2,\pi/2]\to[-1,1]`), " と定める。"])],
    conversion: { status: "added" },
  },
  {
    id: "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_10_19.ts", ordinal: 15 },
    title: { text: "arctan の引数は arcsin の定義域に入る" },
    labels: ["arctan_argument_in_unit_interval"],
    statement: [paragraph([ref("definition_of_sqrt_r_positive"), " を用いる。任意の ", math(String.raw`x\in\mathbb R`), " について"]), displayMath(String.raw`-1\le\frac{x}{\sqrt{1+x^2}^{(\mathbb R_{\ge0})}}\le1`), paragraph(["が成り立つ。"])],
    proof: [
      paragraph([
        "準備として ",
        math(String.raw`s:=\sqrt{1+x^2}^{(\mathbb R_{\ge0})}`),
        " と書く。非負平方根の定義（",
        ref("definition_of_sqrt_r_positive"),
        "）から ",
        math(String.raw`s\ge0`),
        " かつ次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
s^2
&= 1+x^2
&&(\because\ \text{非負平方根の定義。}\blkref{definition_of_sqrt_r_positive})\\
&\ge 1
&&(\because\ x^2\ge0\ \text{と両辺への}\ 1\ \text{の加法})\\
&> 0
&&(\because\ 0<1)
\end{aligned}`),
      paragraph([
        "従って次の二つの不等式が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
s
&>0
&&(\because\ s\ge0\ \text{かつ}\ s^2>0)\\
|x|^2
&=x^2
&&(\because\ \text{絶対値の二乗})\\
&\le 1+x^2
&&(\because\ 0\le1\ \text{と両辺への}\ x^2\ \text{の加法})\\
&=s^2
&&(\because\ \text{非負平方根の定義。}\blkref{definition_of_sqrt_r_positive})
\end{aligned}`),
      paragraph([
        math(String.raw`|x|\ge0`), "、", math(String.raw`s\ge0`),
        " なので、最後の二行と非負数上での二乗の単調性から ", math(String.raw`|x|\le s`),
        " を得る。以上を使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\frac{x}{s}\right|
&= \frac{|x|}{s}
&&(\because\ s>0\ \text{と絶対値の商})\\
&\le \frac{s}{s}
&&(\because\ |x|\le s\ \text{と正の分母}\ s\ \text{で割る単調性})\\
&= 1
&&(\because\ s>0\ \text{による約分})
\end{aligned}`),
      paragraph([
        math(String.raw`\left|x/s\right|\le1`),
        " は主張の二つの不等式 ",
        math(String.raw`-1\le x/s\le1`),
        " と同値である（絶対値の定義）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "式変形の書き方の統一（2026-09-03）。散文で述べていた証明を、分母の正値性の鎖と" +
          "絶対値の商の鎖の 2 本＋行末の (∵ …) へ書き換えた。非負平方根の定義への参照は" +
          "実際に使う行の行末 blkref へ置いた。根拠（分母の正値性・x²≤1+x² と単調性・" +
          "正の分母で割る・二つの不等式との同値）は全て残し、中身は変えていない。",
        "2026-09-03 の次 tick の前進前レビューで、x²≤1+x²=s² と分母の非零性を散文の中で" +
          "まとめていた箇所を、一行一操作の鎖へ開いた。s>0 を直接得て後続の約分根拠も揃えた。",
      ],
    },
  },
  {
    id: "calc_formulae_014d_definition_arctan",
    kind: "definition",
    origin: { path: "structured-latex/content/000_calculation_formulae_10_19.ts", ordinal: 15 },
    title: { text: "arctan の定義" },
    labels: ["def_arctan"],
    statement: [paragraph([ref("def_arcsin"), "、", ref("definition_of_sqrt_r_positive"), "、", ref("arctan_argument_in_unit_interval"), " を使い、", math(String.raw`x\in\mathbb R`), " に対して"]), displayMath(String.raw`\arctan(x):=\arcsin\!\left(\frac{x}{\sqrt{1+x^2}^{(\mathbb R_{\ge0})}}\right)`), paragraph(["と定める。"])],
    conversion: { status: "added" },
  },
  {
    id: "calc_formulae_014e_definition_cos",
    kind: "definition",
    origin: { path: "structured-latex/content/000_calculation_formulae_10_19.ts", ordinal: 15 },
    title: { text: "cos の定義" },
    labels: ["def_cos"],
    statement: [paragraph([ref("def_sin"), " と ", ref("definition_of_sqrt_r_positive"), " を使い、", math(String.raw`-\pi/2\le\theta\le\pi/2`), " に対して"]), displayMath(String.raw`\cos(\theta):=\sqrt{1-(\sin\theta)^2}^{(\mathbb R_{\ge0})}`), paragraph(["と定める。"])],
    conversion: { status: "added" },
  },
  {
    id: "calc_formulae_015_claim_cos_arctan_sin_arctan",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/015_claim_cos_arctan_sin_arctan.typ", ordinal: 16 },
    title: { tex: "\\cos(\\arctan(x)),\\ \\sin(\\arctan(x))" },
    labels: ["cos_arctan_sin_arctan"],
    statement: [
      paragraph([ref("arctan_argument_in_unit_interval"), " の引数の範囲を用いる。"]),
      paragraph([ref("def_arctan"), "、", ref("def_sin"), "、", ref("def_cos"), "、", ref("definition_of_sqrt_r_positive"), " の定義を用いる。"]),
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
&&(\because\ \arctan\ \text{の定義})
\\
&=
\sqrt{
1-\left(
\sin\left(\arcsin\left(x/\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}\right)\right)
\right)^2
}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \cos\ \text{の定義})
\\
&=
\sqrt{
1-\left(
x/\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}
\right)^2
}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \sin\ \text{は}\ \arcsin\ \text{の逆関数})
\\
&=
\sqrt{1-\frac{x^2}{\left(\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}\right)^2}}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \text{商の二乗は二乗の商})
\\
&=
\sqrt{1-\frac{x^2}{1+x^2}}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \text{非負の平方根の二乗はもとの数})
\\
&=
\sqrt{\frac{(1+x^2)-x^2}{1+x^2}}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \text{通分})
\\
&=
\sqrt{\frac{1}{1+x^2}}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \text{加法逆元}\ x^2-x^2=0)
\\
&=
\frac{\sqrt{1}^{(\mathbb{R}_{\ge 0})}}{\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}}
&&(\because\ \text{商の平方根は平方根の商})
\\
&=
\frac{1}{\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}}
&&(\because\ \sqrt{1}=1)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sin(\arctan(x))
&=
\sin\left(\arcsin\left(x/\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}\right)\right)
&&(\because\ \arctan\ \text{の定義})
\\
&=
\frac{x}{\sqrt{1+x^2}^{(\mathbb{R}_{\ge 0})}}
&&(\because\ \sin\ \text{は}\ \arcsin\ \text{の逆関数})
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-14 の式変形統一で、根拠なしの圧縮鎖を行末根拠付きの九段・二段の鎖へ開いた（cos(arcsin(·)) の一段を cos の定義と逆関数の二段へ、平方・通分・平方根の商の各操作を一段ずつへ）。内容は変えていない。",
      ],
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
        ref("angle_equivalence_class"),
        " の同値関係 ",
        math("\\sim_{\\mathrm{angle}}"),
        " による商集合 ",
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
      paragraph([
        "を入れたものとして定める。ここで ",
        math("s_{[0,2\\pi)}"),
        " は ",
        ref("section_of_angle_representation"),
        " の切断である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文では最終行が pi/2, -pi/2 と同値類記号なしで書かれているため、そのまま保持した。",
        "2026-09-05: 同値関係と切断を記号だけで使っていたので、それぞれの定義ブロックへの参照を入れた。定義の内容は変えていない。",
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
      paragraph(["角度の同値関係は ", ref("angle_equivalence_class"), " で定めたものを使う。半径が零の対は角度によらず同じ同値類に属するとし、正の半径の対は半径が等しく角度が同値な場合に同じ同値類に属するとする。"]),
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
