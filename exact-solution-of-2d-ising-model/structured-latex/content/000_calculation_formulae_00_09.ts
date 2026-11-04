import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_mathematical_tools",
    kind: "heading",
    level: 1,
    title: { text: "数学的道具立て" },
    labels: [],
  },
  {
    id: "heading_calculation_formulae",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 1 },
    title: { text: "計算公式" },
    labels: [],
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
    id: "calc_formulae_000c0_claim_positive_real_square_injective",
    kind: "claim",
    title: { text: "正の実数の二乗の一意性" },
    labels: ["positive_real_square_injective"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}_{>0}`),
        " について",
      ]),
      displayMath(String.raw`a^2 = b^2 \iff a = b`),
    ],
    proof: [
      paragraph(["両方向を別々に示すので、ここは一続きの式にしない。"]),
      displayMath(String.raw`\begin{aligned}
a=b
&\Longrightarrow a^2=b^2
&&(\because\ \text{等しい実数を二乗しても等しい})
\end{aligned}`),
      paragraph([
        "逆に ",
        math(String.raw`a^2 = b^2`),
        " とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
(a - b)(a + b)
&= a^2 - b^2
&&(\because\ \text{2 乗の差の因数分解})\\
&= 0
&&(\because\ a^2 = b^2)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
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
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "順序体の性質であり双曲線関数とは無関係なので、双曲線関数の基本性質 (4) から独立させた。非負実数の平方根の存在と一意性がこれを引くことで、平方根→行列ノルム→行列の exp→数の exp→双曲線関数→平方根という依存の循環を断つ。",
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
        ref("positive_real_square_injective"),
        "（",
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
        " 個の複素数の有限和（",
        ref("def_finite_sum_of_complex_numbers"),
        "）である。数ベクトル ",
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
        math(String.raw`m,n,p \in \mathbb{Z}_{\geq 1}`),
        "、",
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
        math("n\\in\\mathbb{Z}_{\\geq 1}"),
        "、",
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
        " と定める（",
        math("BAB^{-1}"),
        " は ",
        math("(BA)B^{-1}"),
        " と読む）。このとき ",
        math("T_B"),
        " は和とスカラー倍を保つ。すなわち",
      ]),
      displayMath(String.raw`T_B(A+C)=T_B(A)+T_B(C),\qquad
T_B(\alpha A)=\alpha\,T_B(A)
\qquad (A,C\in\operatorname{Mat}(n,\mathbb{C}),\ \alpha\in\mathbb{C})`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "和を保つことと、スカラー倍を保つことを別々に示す。鎖が引く 4 つの主張（行列の積の分配の 2 つと、スカラー倍を積の外へ出す 2 つ）は、どれもその ",
        math("m, n, p"),
        " をすべてこの主張の ",
        math("n"),
        " として使う。",
      ]),
      paragraph([
        "第一に、和を保つこと。",
        math("A,C\\in\\operatorname{Mat}(n,\\mathbb{C})"),
        " に対して、",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B(A+C)
&=\bigl(B(A+C)\bigr)B^{-1}
&&(\because\ T_B\ \text{の定義})\\
&=(BA+BC)B^{-1}
&&(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor})\\
&=(BA)B^{-1}+(BC)B^{-1}
&&(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor})\\
&=T_B(A)+T_B(C)
&&(\because\ T_B\ \text{の定義を 2 か所へ同時適用})
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
&=\bigl(B(\alpha A)\bigr)B^{-1}
&&(\because\ T_B\ \text{の定義})\\
&=\bigl(\alpha(BA)\bigr)B^{-1}
&&(\because\ \blkref{scalar_multiple_factors_out_of_right_factor})\\
&=\alpha\bigl((BA)B^{-1}\bigr)
&&(\because\ \blkref{scalar_multiple_factors_out_of_left_factor})\\
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
        "2026-11-02: 和の鎖の「行列の積の左からの分配則」「右からの分配則」と、スカラー倍の鎖の「スカラー倍と行列の積の交換」2 か所の名前だけの根拠を、" +
          "mat_mult_distributes_over_sum_in_right_factor・mat_mult_distributes_over_sum_in_left_factor・scalar_multiple_factors_out_of_right_factor・scalar_multiple_factors_out_of_left_factor へのラベル参照にした。" +
          "BAB^{-1} を (BA)B^{-1} と読むことと n ∈ ℤ_{≥1} を主張に書き、鎖の積に括弧を全て書いた。主張の中身は変えていない。" +
          "有限和を保つことは、別の主張 matrix_conjugation_preserves_finite_sum として足した。" +
          "Lean の対応は Ising2D.conj_add_matrix・Ising2D.conj_smul_matrix（同じ行の calc）。数値検証: sagemath/check/122_mat_conj/check_02_chains.sage。",
        "原文（Typst）の証明は等号でつなげてはあったが、各行の根拠が書かれておらず、" +
          "スカラー倍の側では B(αA)B^{-1} = α(BAB^{-1}) が 1 行に詰められていた" +
          "（スカラー倍と行列の積の交換を 2 度使っている）。" +
          "行末の (∵ …) を付け、詰まっていた行を 2 段へ分けた。ステップは減らしていない。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_matrix_conjugation_preserves_finite_sum",
    kind: "claim",
    title: { text: "行列の共役は有限和を保つ" },
    labels: ["matrix_conjugation_preserves_finite_sum"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`B \in \operatorname{Mat}(n,\mathbb{C})`),
        " は正則とし、",
        math(String.raw`T_B`),
        " は ",
        ref("mat_conj"),
        " の共役写像とする。",
        math(String.raw`X_1,\dots,X_r \in \operatorname{Mat}(n,\mathbb{C})`),
        " について、有限和は ",
        ref("def_finite_sum_of_matrices"),
        " による。このとき",
      ]),
      displayMath(String.raw`T_B\Bigl(\sum_{j=1}^{r} X_j\Bigr) = \sum_{j=1}^{r} T_B(X_j)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math("r"), " についての帰納法で示す。", math("r = 1"), " のとき"]),
      displayMath(String.raw`\begin{aligned}
T_B\Bigl(\sum_{j=1}^{1} X_j\Bigr)
&= T_B(X_1)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \sum_{j=1}^{1} T_B(X_j)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 }T_B(X_j)\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math("r"),
        " で成り立つと仮定すると、",
        math(String.raw`X_1,\dots,X_{r+1} \in \operatorname{Mat}(n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B\Bigl(\sum_{j=1}^{r+1} X_j\Bigr)
&= T_B\Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= T_B\Bigl(\sum_{j=1}^{r} X_j\Bigr) + T_B(X_{r+1})
&&\bigl(\because\ \blkref{mat_conj}\ \text{の和を保つこと}\bigr)\\
&= \Bigl(\sum_{j=1}^{r} T_B(X_j)\Bigr) + T_B(X_{r+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \sum_{j=1}^{r+1} T_B(X_j)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 }T_B(X_j)\text{）}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation Step 3 の「共役の ℂ 線型性」を H_1^{(+)}・H_2 の有限和へ適用する段を引けるよう足した。" +
          "Lean の対応は Ising2D.conj_finite_sum_of_matrices（同じ帰納法の calc）。数値検証: sagemath/check/matrix_conjugation_preserves_finite_sum/。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_matrix_conjugation_preserves_negation",
    kind: "claim",
    title: { text: "行列の共役は符号反転を保つ" },
    labels: ["matrix_conjugation_preserves_negation"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`B \in \operatorname{Mat}(n,\mathbb{C})`),
        " は正則とし、",
        math(String.raw`T_B`),
        " は ",
        ref("mat_conj"),
        " の共役写像とする。",
        math(String.raw`W \in \operatorname{Mat}(n,\mathbb{C})`),
        " について、符号反転は ",
        ref("def_matrix_negation"),
        " による。このとき",
      ]),
      displayMath(String.raw`T_B(-W) = -\,T_B(W)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "鎖が引く 2 つの主張（符号反転を積の外へ出す 2 つ）は、どちらもその ",
        math("m, n, p"),
        " をすべてこの主張の ",
        math("n"),
        " として使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
T_B(-W)
&=\bigl(B(-W)\bigr)B^{-1}
&&(\because\ \blkref{mat_conj}\ \text{の}\ T_B\ \text{の定義})\\
&=\bigl(-(BW)\bigr)B^{-1}
&&(\because\ \blkref{negation_factors_out_of_right_factor})\\
&=-\bigl((BW)B^{-1}\bigr)
&&(\because\ \blkref{negation_factors_out_of_left_factor})\\
&=-\,T_B(W)
&&(\because\ \blkref{mat_conj}\ \text{の}\ T_B\ \text{の定義})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation Step 3 の H_1^{(+)} の鎖で、差の項 Y_{M_col}Z_1 の共役を扱う段（matrix_conjugation_preserves_difference）に要るので足した。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_matrix_conjugation_preserves_difference",
    kind: "claim",
    title: { text: "行列の共役は差を保つ" },
    labels: ["matrix_conjugation_preserves_difference"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`B \in \operatorname{Mat}(n,\mathbb{C})`),
        " は正則とし、",
        math(String.raw`T_B`),
        " は ",
        ref("mat_conj"),
        " の共役写像とする。",
        math(String.raw`X, W \in \operatorname{Mat}(n,\mathbb{C})`),
        " について、差は ",
        ref("def_matrix_difference"),
        " による。このとき",
      ]),
      displayMath(String.raw`T_B(X - W) = T_B(X) - T_B(W)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
T_B(X - W)
&= T_B\bigl(X + (-W)\bigr)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ (A \to X,\ B \to W)\bigr)\\
&= T_B(X) + T_B(-W)
&&\bigl(\because\ \blkref{mat_conj}\ \text{の和を保つこと}\ (A \to X,\ C \to -W)\bigr)\\
&= T_B(X) + \bigl(-\,T_B(W)\bigr)
&&\bigl(\because\ \blkref{matrix_conjugation_preserves_negation}\bigr)\\
&= T_B(X) - T_B(W)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ (A \to T_B(X),\ B \to T_B(W))\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation Step 3 の H_1^{(+)} = Σ_{m=1}^{M_col−1} Y_mZ_{m+1} − Y_{M_col}Z_1 の共役を、和の項と差の項に割る段を引けるよう足した。",
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
    id: "calc_formulae_008b_definition_complex_difference",
    kind: "definition",
    title: { text: "複素数の差" },
    labels: ["def_complex_difference"],
    statement: [
      paragraph([
        math(String.raw`z, w \in \mathbb{C}`),
        " について、差 ",
        math(String.raw`z - w \in \mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`z - w := z + (-w)`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`-w`),
        " は ",
        ref("multiply_by_minus_one"),
        "、和は ",
        ref("definition_of_cc"),
        " の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。ℂ の差は本文全体で使われていたが、定めるブロックが無く、行列の差の定義（def_matrix_difference）も「複素数の差」を根拠にしていた。star_preserves_norm_and_limits の検算で、複素共役が差を保つことを示すのに要るので足した。",
      ],
    },
  },
  {
    id: "calc_formulae_008c_definition_finite_sum_of_complex_numbers",
    kind: "definition",
    title: { text: "複素数の有限和" },
    labels: ["def_finite_sum_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m \in \mathbb{C}`),
        " について、有限和 ",
        math(String.raw`\sum_{j=1}^{m} z_j \in \mathbb{C}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\sum_{j=1}^{1} z_j := z_1,
\qquad
\sum_{j=1}^{m+1} z_j := \Bigl(\sum_{j=1}^{m} z_j\Bigr) + z_{m+1}`),
      paragraph([
        "と定める（左から順に足す）。和は ",
        ref("definition_of_cc"),
        " の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。行列の積（mat_mult）をはじめ本文全体が有限和を使っていたが、定めるブロックが無かった。complex_conjugate_of_sum の帰納法の各行が引けるよう足した。",
      ],
    },
  },

  {
    id: "calc_formulae_008d_definition_finite_sum_of_complex_numbers_from_index_zero",
    kind: "definition",
    title: { text: "添字が 0 から始まる複素数の有限和" },
    labels: ["def_finite_sum_of_complex_numbers_from_index_zero"],
    statement: [
      paragraph([
        math(String.raw`K \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`z_0,\dots,z_K \in \mathbb{C}`),
        " について、有限和 ",
        math(String.raw`\sum_{k=0}^{K} z_k \in \mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`\sum_{k=0}^{K} z_k := \sum_{j=1}^{K+1} z_{j-1}`),
      paragraph([
        "と定める。右辺は ",
        ref("def_finite_sum_of_complex_numbers"),
        " の有限和（",
        math(String.raw`m \to K+1`),
        "、",
        math(String.raw`j`),
        " 番目の項を ",
        math(String.raw`z_{j-1}`),
        " とする）である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。eigenvalues_of_check_Vprime の Step 3・Step 3' の部分和 Σ_{k=0}^{K} は添字が 0 から始まり、" +
          "def_finite_sum_of_complex_numbers（添字 1..m）が覆わなかったので、その和へ添字をずらして定めた。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_complex_zeros",
    kind: "claim",
    title: { text: "複素数の零の有限和は零" },
    labels: ["finite_sum_of_complex_zeros"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`\sum_{j=1}^{m} 0_{\mathbb{C}} = 0_{\mathbb{C}}`),
        " が成り立つ。有限和は ",
        ref("def_finite_sum_of_complex_numbers"),
        "、",
        math(String.raw`0_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} 0_{\mathbb{C}}
&= 0_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})
\end{aligned}`),
      paragraph([math(String.raw`m`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} 0_{\mathbb{C}}
&= \Bigl(\sum_{j=1}^{m} 0_{\mathbb{C}}\Bigr) + 0_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= 0_{\mathbb{C}} + 0_{\mathbb{C}}
&&(\because\ \text{帰納法の仮定})\\
&= (0,0) + (0,0)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= (0+0,\ 0+0)
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= (0,0)
&&(\because\ \mathbb{R}\ \text{で}\ 0 + 0 = 0)\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。congruence_preserves_positive_definite の B'0 = 0 の証明が使うので足した。",
      ],
    },
  },

  {
    id: "calc_formulae_definition_finite_sum_of_real_numbers",
    kind: "definition",
    title: { text: "実数の有限和" },
    labels: ["def_finite_sum_of_real_numbers"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        " について、有限和 ",
        math(String.raw`\sum_{j=1}^{m} r_j \in \mathbb{R}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\sum_{j=1}^{1} r_j := r_1,
\qquad
\sum_{j=1}^{m+1} r_j := \Bigl(\sum_{j=1}^{m} r_j\Bigr) + r_{m+1}`),
      paragraph([
        "と定める（左から順に足す。",
        ref("def_finite_sum_of_complex_numbers"),
        " と同じ帰納法である）。和は ",
        math(String.raw`\mathbb{R}`),
        " の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。real_inclusion_preserves_finite_sum と max_eigenvalue_of_V_plus_simple (2) の ǧ の差の鎖が ℝ の有限和を名前だけで使っていたので、引けるよう足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_inclusion_preserves_finite_sum",
    kind: "claim",
    title: { text: "実数の有限和の包含は包含の有限和に等しい" },
    labels: ["real_inclusion_preserves_finite_sum"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} (r_j)_{\mathbb{C}} = \Bigl(\sum_{j=1}^{m} r_j\Bigr)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、左辺の和は ",
        ref("def_finite_sum_of_complex_numbers"),
        " の有限和、右辺の和は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (r_j)_{\mathbb{C}}
&= (r_1)_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= \Bigl(\sum_{j=1}^{1} r_j\Bigr)_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_real_numbers})
\end{aligned}`),
      paragraph([
        math(String.raw`m`),
        " で成り立つと仮定する。",
        math(String.raw`r_1,\dots,r_{m+1} \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} (r_j)_{\mathbb{C}}
&= \Bigl(\sum_{j=1}^{m} (r_j)_{\mathbb{C}}\Bigr) + (r_{m+1})_{\mathbb{C}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= \Bigl(\sum_{j=1}^{m} r_j\Bigr)_{\mathbb{C}} + (r_{m+1})_{\mathbb{C}}
&&(\because\ \text{帰納法の仮定})\\
&= \Bigl(\sum_{j=1}^{m} r_j,\ 0\Bigr) + (r_{m+1},\ 0)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{を各項へ})\\
&= \Bigl(\sum_{j=1}^{m} r_j + r_{m+1},\ 0 + 0\Bigr)
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= \Bigl(\sum_{j=1}^{m+1} r_j,\ 0 + 0\Bigr)
&&(\because\ \blkref{def_finite_sum_of_real_numbers})\\
&= \Bigl(\sum_{j=1}^{m+1} r_j,\ 0\Bigr)
&&(\because\ \mathbb{R}\ \text{で}\ 0 + 0 = 0)\\
&= \Bigl(\sum_{j=1}^{m+1} r_j\Bigr)_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。正定値性の主張（identity_matrix_is_positive_definite、trace_of_positive_definite_is_positive）が、ℂ の元が正の実数の包含であることを示すのに使うので足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_inclusion_preserves_sum",
    kind: "claim",
    title: { text: "実数の和の包含は包含の和に等しい" },
    labels: ["real_inclusion_preserves_sum"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`a_{\mathbb{C}} + b_{\mathbb{C}} = (a + b)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、左辺の和は ",
        ref("definition_of_cc"),
        " の和、右辺の和は ",
        math(String.raw`\mathbb{R}`),
        " の和である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a_{\mathbb{C}} + b_{\mathbb{C}}
&= (a,\ 0) + (b,\ 0)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{を 2 か所へ同時適用})\\
&= (a + b,\ 0 + 0)
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= (a + b,\ 0)
&&(\because\ \mathbb{R}\ \text{で}\ 0 + 0 = 0)\\
&= (a + b)_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。real_inclusion_preserves_sum_over_binary_words の帰納法の各段が二つの実数の和の包含を使うので足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_differences",
    kind: "claim",
    title: { text: "実数の差の有限和は有限和の差" },
    labels: ["finite_sum_of_real_differences"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a_1,\dots,a_m, b_1,\dots,b_m \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} (a_j - b_j) = \Bigl(\sum_{j=1}^{m} a_j\Bigr) - \Bigl(\sum_{j=1}^{m} b_j\Bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (a_j - b_j)
&= a_1 - b_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= \Bigl(\sum_{j=1}^{1} a_j\Bigr) - \Bigl(\sum_{j=1}^{1} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\text{ を 2 か所へ同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{m+1}, b_1,\dots,b_{m+1} \in \mathbb{R}`),
        " を取る。",
        math(String.raw`\alpha := \sum_{j=1}^{m} a_j`),
        "、",
        math(String.raw`\beta := \sum_{j=1}^{m} b_j`),
        " とおく（",
        math(String.raw`\alpha, \beta \in \mathbb{R}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} (a_j - b_j)
&= \Bigl(\sum_{j=1}^{m} (a_j - b_j)\Bigr) + (a_{m+1} - b_{m+1})
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= (\alpha - \beta) + (a_{m+1} - b_{m+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= (\alpha + a_{m+1}) - (\beta + b_{m+1})
&&\bigl(\because\ \mathbb{R}\ \text{の和と差の計算}\bigr)\\
&= \Bigl(\Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}\Bigr) - \Bigl(\Bigl(\sum_{j=1}^{m} b_j\Bigr) + b_{m+1}\Bigr)
&&\bigl(\because\ \alpha, \beta\ \text{の置き方}\bigr)\\
&= \Bigl(\sum_{j=1}^{m+1} a_j\Bigr) - \Bigl(\sum_{j=1}^{m+1} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\text{ を 2 か所へ同時適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。max_eigenvalue_of_V_plus_simple (2) の ǧ(1,…,1) − ǧ(ε) の鎖が「ǧ の定義と分配法則」の名前だけで二つの有限和の差を項ごとの差の有限和にしていたので、引けるよう足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_negated_real_numbers",
    kind: "claim",
    title: { text: "実数の符号反転の有限和は有限和の符号反転" },
    labels: ["finite_sum_of_negated_real_numbers"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`x_1,\dots,x_m \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} (-x_j) = -\sum_{j=1}^{m} x_j`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (-x_j)
&= -x_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to -x_j)\bigr)\\
&= -\sum_{j=1}^{1} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`x_1,\dots,x_{m+1} \in \mathbb{R}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} (-x_j)
&= \Bigl(\sum_{j=1}^{m} (-x_j)\Bigr) + (-x_{m+1})
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to -x_j)\bigr)\\
&= \Bigl(-\sum_{j=1}^{m} x_j\Bigr) + (-x_{m+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= -\Bigl(\Bigl(\sum_{j=1}^{m} x_j\Bigr) + x_{m+1}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (-a) + (-b) = -(a + b)\ \bigl(a \to \textstyle\sum_{j=1}^{m} x_j,\ b \to x_{m+1}\bigr)\bigr)\\
&= -\sum_{j=1}^{m+1} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 3 が −ǧ(ε) = −Σ_μ γ(θ̃_μ)(ε_μ − 1/2) の符号反転を有限和の各項へ入れるのに引くので足した（それまでは「Step 2 を γ → −γ として適用」と名前だけで根拠にしていた）。Lean は Ising2D.finite_sum_of_negated_real_numbers（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean）。数値検証: sagemath/check/finite_sum_of_negated_real_numbers/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_real_scalar_multiples",
    kind: "claim",
    title: { text: "実数の共通の因子は有限和の外へ出せる" },
    labels: ["finite_sum_of_real_scalar_multiples"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{R}`),
        "、",
        math(String.raw`x_1,\dots,x_m \in \mathbb{R}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} c\,x_j = c\sum_{j=1}^{m} x_j`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} c\,x_j
&= c\,x_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to c\,x_j)\bigr)\\
&= c\sum_{j=1}^{1} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`x_1,\dots,x_{m+1} \in \mathbb{R}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} c\,x_j
&= \Bigl(\sum_{j=1}^{m} c\,x_j\Bigr) + c\,x_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ (r_j \to c\,x_j)\bigr)\\
&= c\Bigl(\sum_{j=1}^{m} x_j\Bigr) + c\,x_{m+1}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= c\Bigl(\Bigl(\sum_{j=1}^{m} x_j\Bigr) + x_{m+1}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配法則}\ ca + cb = c(a + b)\ \bigl(a \to \textstyle\sum_{j=1}^{m} x_j,\ b \to x_{m+1}\bigr)\bigr)\\
&= c\sum_{j=1}^{m+1} x_j
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。eigenvalues_of_V_plus (2) の ǧ(1,…,1) = ½Σγ(θ~_μ)・ǧ(0,…,0) = −½Σγ(θ~_μ) の鎖が、共通の因子 ½・−½ を有限和の外へ出すのに引くので足した。Lean は Ising2D.finite_sum_of_real_scalar_multiples（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean）、必要十分版は Ising2D.NecSuf.finite_sum_mul_left_fin'。数値検証: sagemath/check/finite_sum_of_real_scalar_multiples/。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_finite_sum_of_nonnegative_reals_is_at_least_each_term",
    kind: "claim",
    title: { text: "非負の実数の有限和は各項以上" },
    labels: ["finite_sum_of_nonnegative_reals_is_at_least_each_term"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a_1,\dots,a_m \in \mathbb{R}`),
        " がすべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " で ",
        math(String.raw`a_j \geq 0`),
        " を満たすとする。有限和は ",
        ref("def_finite_sum_of_real_numbers"),
        " による。このとき、すべての ",
        math(String.raw`k \in \{1,\dots,m\}`),
        " について",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} a_j \geq a_k`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す（各 ",
        math(String.raw`m`),
        " で、すべての ",
        math(String.raw`k \in \{1,\dots,m\}`),
        " についての主張を示す）。",
        math(String.raw`m = 1`),
        " のとき ",
        math(String.raw`k = 1`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} a_j
&= a_1
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&= a_k
&&\bigl(\because\ k = 1\bigr)
\end{aligned}`),
      paragraph([
        "だから ",
        math(String.raw`\sum_{j=1}^{1} a_j \geq a_k`),
        " である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{m+1} \in \mathbb{R}`),
        " がすべて ",
        math(String.raw`0`),
        " 以上であるとして、",
        math(String.raw`k \in \{1,\dots,m+1\}`),
        " を取る。",
        math(String.raw`k \leq m`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} a_j
&= \Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&\geq \Bigl(\sum_{j=1}^{m} a_j\Bigr) + 0
&&\bigl(\because\ a_{m+1} \geq 0\ \text{の両辺に同じ実数を足す}\bigr)\\
&= \sum_{j=1}^{m} a_j
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&\geq a_k
&&\bigl(\because\ \text{帰納法の仮定（}k \leq m\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k = m+1`),
        " のとき、",
        math(String.raw`a_1,\dots,a_m`),
        " はすべて ",
        math(String.raw`0`),
        " 以上であり、",
        math(String.raw`m \geq 1`),
        " なので ",
        math(String.raw`1 \in \{1,\dots,m\}`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m} a_j
&\geq a_1
&&\bigl(\because\ \text{帰納法の仮定（}a_1,\dots,a_m\text{ について、}k \to 1\text{）}\bigr)\\
&\geq 0
&&\bigl(\because\ \text{仮定 }a_1 \geq 0\bigr)
\end{aligned}`),
      paragraph([
        "であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} a_j
&= \Bigl(\sum_{j=1}^{m} a_j\Bigr) + a_{m+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\bigr)\\
&\geq 0 + a_{m+1}
&&\bigl(\because\ \textstyle\sum_{j=1}^{m} a_j \geq 0\ \text{の両辺に同じ実数を足す}\bigr)\\
&= a_{m+1}
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の和の単位元}\bigr)\\
&= a_k
&&\bigl(\because\ k = m+1\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。max_eigenvalue_of_V_plus_simple (2) の ǧ(1,…,1) − ǧ(ε) の鎖が「各項は 0 以上。μ = μ_0 の項だけを残す」の名前だけで有限和を一つの項で下から抑えていたので、引けるよう足した。",
      ],
    },
  },

  {
    id: "calc_formulae_claim_real_inclusion_preserves_product",
    kind: "claim",
    title: { text: "実数の積の包含は包含の積に等しい" },
    labels: ["real_inclusion_preserves_product"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`a_{\mathbb{C}}\, b_{\mathbb{C}} = (ab)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、左辺の積は ",
        ref("definition_of_cc"),
        " の積である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a_{\mathbb{C}}\, b_{\mathbb{C}}
&= (a, 0)\,(b, 0)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= (a b - 0\cdot 0,\ a\cdot 0 + 0\cdot b)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= (a b - 0,\ 0 + 0)
&&(\because\ \mathbb{R}\ \text{で}\ x\cdot 0 = 0\ \text{と}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）を 3 箇所へ適用})\\
&= (a b,\ 0)
&&(\because\ \mathbb{R}\ \text{で}\ x - 0 = x\ \text{と}\ 0 + 0 = 0)\\
&= (ab)_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。first_transfer_matrix_pauli_form の証明の D の対角成分と成分の一致の鎖が、包含と ℂ の積の定義を開いて計算する段を一行で使っていたので、主張にして引けるようにした。",
      ],
    },
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
