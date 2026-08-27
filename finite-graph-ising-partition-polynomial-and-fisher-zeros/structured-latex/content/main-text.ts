import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export const finiteGraphTheory = defineBlocks([
  {
    id: "finite_graph_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限グラフ上の Ising 多項式" },
    labels: [],
  },
  {
    id: "finite_graph_definition_endpoint_labels",
    kind: "definition",
    title: { text: "辺端ラベル集合" },
    labels: ["def_edge_endpoint_label_set"],
    habitat: "finite",
    statement: [
      paragraph(["二つの形式的ラベルからなる有限集合を"]),
      displayMath(String.raw`\mathsf{End}:=\{\mathsf{source},\mathsf{target}\}`),
      paragraph([
        "と定める。",
        math(String.raw`\mathsf{source}`),
        " と ",
        math(String.raw`\mathsf{target}`),
        " は辺の二つの端を区別するラベルであり、整数 ",
        math(String.raw`0,1\in\mathbb Z`),
        " ではない。この集合には加法、減法、乗法、大小関係を入れない。",
      ]),
    ],
  },
  {
    id: "finite_graph_definition_input",
    kind: "definition",
    title: { text: "有限グラフの入力" },
    labels: ["def_finite_graph_input"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限グラフの入力を、空でない有限集合 ",
        math(String.raw`V`),
        "、有限集合 ",
        math(String.raw`E`),
        "、",
        ref("def_edge_endpoint_label_set"),
        " の辺端ラベルを入力に取る写像 ",
        math(String.raw`\partial_G:E\times\mathsf{End}\to V`),
        " の組 ",
        math(String.raw`G=(V,E,\partial_G)`),
        " と定める。任意の ",
        math(String.raw`e\in E`),
        " について ",
        math(String.raw`\partial_G(e,\mathsf{source})\ne\partial_G(e,\mathsf{target})`),
        " を仮定する。異なる辺が同じ二頂点を結ぶことは許す。",
      ]),
    ],
  },
  {
    id: "finite_graph_definition_spin_labels",
    kind: "definition",
    title: { text: "スピンラベル集合" },
    labels: ["def_spin_label_set"],
    habitat: "finite",
    statement: [
      paragraph(["二つの形式的ラベルからなる有限集合を"]),
      displayMath(String.raw`\mathsf{Spin}:=\{\mathsf{up},\mathsf{down}\}`),
      paragraph([
        "と定める。",
        math(String.raw`\mathsf{up}`),
        " と ",
        math(String.raw`\mathsf{down}`),
        " はスピン状態を区別するラベルであり、それ自体には整数の演算を入れない。",
      ]),
    ],
  },
  {
    id: "finite_graph_definition_spin_integer_realization",
    kind: "definition",
    title: { text: "スピンラベルの整数実現" },
    labels: ["def_spin_integer_realization"],
    habitat: "Z",
    statement: [
      paragraph([
        ref("def_spin_label_set"),
        " のスピンラベルを整数係数の式で使うための写像を",
      ]),
      displayMath(String.raw`\kappa:\mathsf{Spin}\to\{-1,+1\}\subset\mathbb Z,\qquad
\kappa(\mathsf{up})=+1,\qquad \kappa(\mathsf{down})=-1`),
      paragraph([
        "と定める。右辺の ",
        math(String.raw`-1,+1`),
        " は整数である。以後、スピンラベルを整数として演算するときは必ず ",
        math(String.raw`\kappa`),
        " を明記する。",
      ]),
    ],
  },
  {
    id: "finite_graph_definition_spin_reversal",
    kind: "definition",
    title: { text: "スピンラベルの反転写像" },
    labels: ["def_spin_label_reversal"],
    habitat: "finite",
    statement: [
      paragraph(["スピンラベルを反転する写像を"]),
      displayMath(String.raw`\nu:\mathsf{Spin}\to\mathsf{Spin},\qquad
\nu(\mathsf{up})=\mathsf{down},\qquad
\nu(\mathsf{down})=\mathsf{up}`),
      paragraph(["と定める。これは形式的ラベル上の写像であり、整数の加法逆元ではない。"]),
    ],
  },
  {
    id: "finite_graph_claim_spin_reversal_integer_realization",
    kind: "claim",
    title: { text: "スピン反転と整数実現の整合性" },
    labels: ["claim_spin_reversal_integer_realization"],
    habitat: "Z",
    statement: [
      displayMath(String.raw`\kappa(\nu(a))=-\kappa(a)\in\mathbb Z\qquad(a\in\mathsf{Spin}).`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\kappa(\nu(\mathsf{up}))
&=\kappa(\mathsf{down})
&&\bigl(\because\ \text{スピンラベルの反転写像の定義}\bigr)\\
&=-1
&&\bigl(\because\ \text{スピンラベルの整数実現の定義}\bigr)\\
&=-\kappa(\mathsf{up})
&&\bigl(\because\ \kappa(\mathsf{up})=+1\bigr),\\[4pt]
\kappa(\nu(\mathsf{down}))
&=\kappa(\mathsf{up})
&&\bigl(\because\ \text{スピンラベルの反転写像の定義}\bigr)\\
&=+1
&&\bigl(\because\ \text{スピンラベルの整数実現の定義}\bigr)\\
&=-\kappa(\mathsf{down})
&&\bigl(\because\ \kappa(\mathsf{down})=-1\bigr).
\end{aligned}`),
      paragraph([
        "二つの場合が ",
        ref("def_spin_label_set"),
        " の全ての元を尽くすので結論を得る。用いた写像は ",
        ref("def_spin_label_reversal"),
        " と ",
        ref("def_spin_integer_realization"),
        " で定めた。",
      ]),
    ],
  },
  {
    id: "finite_graph_definition_spin_configurations",
    kind: "definition",
    title: { text: "スピン配位集合" },
    labels: ["def_spin_configuration_set"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限グラフ ",
        math(String.raw`G`),
        " のスピン配位集合を",
      ]),
      displayMath(String.raw`\mathcal S_G:=\{\sigma\mid \sigma:V\to\mathsf{Spin}\ \text{は写像}\}`),
      paragraph([
        "と定める。",
        math(String.raw`\mathcal S_G`),
        " は有限集合であり、",
        math(String.raw`|\mathcal S_G|=2^{|V|}`),
        " である。ここで ",
        math(String.raw`|X|\in\mathbb N`),
        " は有限集合 ",
        math(String.raw`X`),
        " の元の個数を表す。",
      ]),
    ],
  },
  {
    id: "finite_graph_definition_single_vertex_spin_flip",
    kind: "definition",
    title: { text: "一頂点での配位反転写像" },
    labels: ["def_single_vertex_spin_flip"],
    habitat: "finite",
    statement: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\mathcal S_G`),
        " と頂点 ",
        math(String.raw`w\in V`),
        " に対し、配位 ",
        math(String.raw`T_w(\sigma)\in\mathcal S_G`),
        " を",
      ]),
      displayMath(String.raw`T_w(\sigma)(v):=
\begin{cases}
\nu(\sigma(v)) & (v=w),\\
\sigma(v) & (v\ne w)
\end{cases}
\qquad(v\in V)`),
      paragraph([
        "と定める。スピンラベルの反転には ",
        ref("def_spin_label_reversal"),
        " の写像 ",
        math(String.raw`\nu`),
        " を用いる。",
      ]),
    ],
  },
  {
    id: "finite_graph_claim_single_vertex_spin_flip_involution",
    kind: "claim",
    title: { text: "一頂点での配位反転は不動点を持たない対合である" },
    labels: ["claim_single_vertex_spin_flip_involution"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`T_w(T_w(\sigma))=\sigma,\qquad T_w(\sigma)\ne\sigma
\qquad(\sigma\in\mathcal S_G,\ w\in V).`),
    ],
    proof: [
      paragraph([
        ref("def_spin_label_reversal"),
        " の二つの定義値から、任意の ",
        math(String.raw`a\in\mathsf{Spin}`),
        " に対して ",
        math(String.raw`\nu(\nu(a))=a`),
        " および ",
        math(String.raw`\nu(a)\ne a`),
        " が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
T_w(T_w(\sigma))(w)
&=\nu(T_w(\sigma)(w))
&&\bigl(\because\ \text{一頂点での配位反転写像の定義}\bigr)\\
&=\nu(\nu(\sigma(w)))
&&\bigl(\because\ \text{一頂点での配位反転写像の定義}\bigr)\\
&=\sigma(w)
&&\bigl(\because\ \nu(\nu(a))=a\bigr),\\[4pt]
T_w(T_w(\sigma))(v)
&=T_w(\sigma)(v)
&&\bigl(\because\ v\ne w\text{ と一頂点での配位反転写像の定義}\bigr)\\
&=\sigma(v)
&&\bigl(\because\ v\ne w\text{ と一頂点での配位反転写像の定義}\bigr).
\end{aligned}`),
      paragraph([
        "第二の計算は任意の ",
        math(String.raw`v\in V\setminus\{w\}`),
        " に対して成り立つので、二つの配位は全頂点で等しく、",
        math(String.raw`T_w(T_w(\sigma))=\sigma`),
        " である。また ",
        math(String.raw`T_w(\sigma)(w)=\nu(\sigma(w))\ne\sigma(w)`),
        " なので ",
        math(String.raw`T_w(\sigma)\ne\sigma`),
        " である。",
      ]),
    ],
  },
  {
    id: "finite_graph_definition_broken_edges",
    kind: "definition",
    title: { text: "破れ辺集合と破れ辺数" },
    labels: ["def_broken_edge_set"],
    habitat: "N",
    statement: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\mathcal S_G`),
        " の破れ辺集合と破れ辺数を",
      ]),
      displayMath(String.raw`B_G(\sigma):=\left\{e\in E\ \middle|\ \sigma\!\left(\partial_G(e,\mathsf{source})\right)\ne\sigma\!\left(\partial_G(e,\mathsf{target})\right)\right\},\qquad b_G(\sigma):=|B_G(\sigma)|\in\mathbb N`),
      paragraph(["と定める。端点写像と配位は ", ref("def_finite_graph_input"), " と ", ref("def_spin_configuration_set"), " で定めた。"]),
    ],
  },
  {
    id: "finite_graph_definition_multiplicity",
    kind: "definition",
    title: { text: "破れ辺数の多重度" },
    labels: ["def_broken_edge_multiplicity"],
    habitat: "N",
    statement: [
      paragraph(["各 ", math(String.raw`m\in\{0,1,\ldots,|E|\}`), " に対し多重度を"]),
      displayMath(String.raw`\Omega_G(m):=|\{\sigma\in\mathcal S_G\mid b_G(\sigma)=m\}|\in\mathbb N`),
      paragraph(["と定める。破れ辺数は ", ref("def_broken_edge_set"), " で定めた。"]),
    ],
  },
  {
    id: "finite_graph_definition_partition_polynomial",
    kind: "definition",
    title: { text: "Ising 分配多項式" },
    labels: ["def_ising_partition_polynomial"],
    habitat: "ZPolynomial",
    statement: [
      paragraph(["不定元 ", math(String.raw`x`), " に対し Ising 分配多項式を"]),
      displayMath(String.raw`Z_G(x):=\sum_{\sigma\in\mathcal S_G}x^{b_G(\sigma)}\in\mathbb Z[x]`),
      paragraph(["と定める。これは多項式そのものであり、数を代入した値とは区別する。"]),
    ],
  },
  {
    id: "finite_graph_claim_coefficient_expansion",
    kind: "claim",
    standing: "mainTheorem",
    title: { text: "多重度による係数表示" },
    labels: ["claim_partition_polynomial_coefficient_expansion"],
    habitat: "ZPolynomial",
    statement: [
      displayMath(String.raw`Z_G(x)=\sum_{m=0}^{|E|}\Omega_G(m)x^m\in\mathbb Z[x].`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
Z_G(x)
&=\sum_{\sigma\in\mathcal S_G}x^{b_G(\sigma)}
&&\bigl(\because\ \text{Ising 分配多項式の定義}\bigr)\\
&=\sum_{m=0}^{|E|}\ \sum_{\substack{\sigma\in\mathcal S_G\\ b_G(\sigma)=m}}x^m
&&\bigl(\because\ \mathcal S_G\text{ を }b_G\text{ の値ごとのファイバーへ分割}\bigr)\\
&=\sum_{m=0}^{|E|}\Omega_G(m)x^m
&&\bigl(\because\ \text{多重度の定義}\bigr).
\end{aligned}`),
      paragraph(["最初の等号は ", ref("def_ising_partition_polynomial"), "、最後の等号は ", ref("def_broken_edge_multiplicity"), " を用いた。"]),
    ],
  },
  {
    id: "finite_graph_theorem_partition_polynomial_coefficient_evenness",
    kind: "theorem",
    title: { text: "Ising 分配多項式の全係数の偶数性" },
    labels: ["theorem_partition_polynomial_coefficient_evenness"],
    habitat: "N",
    verification: ["sagemath/check/partition-polynomial-coefficient-evenness"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の空でない頂点集合をもつ任意の有限グラフに対し、全ての ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " について",
      ]),
      displayMath(String.raw`\Omega_G(m)\in\{2n\mid n\in\mathbb N\}.`),
    ],
    proof: [
      paragraph([
        ref("def_spin_configuration_set"),
        " の配位集合上に、大域スピン反転写像 ",
        math(String.raw`\mathfrak F_G:\mathcal S_G\to\mathcal S_G`),
        " を",
      ]),
      displayMath(String.raw`\mathfrak F_G(\sigma)(v):=\nu(\sigma(v))
\qquad(\sigma\in\mathcal S_G,\ v\in V)`),
      paragraph([
        "で定める。",
        ref("def_spin_label_reversal"),
        " の二つの定義値より、任意の ",
        math(String.raw`a\in\mathsf{Spin}`),
        " に対して ",
        math(String.raw`\nu(\nu(a))=a`),
        " および ",
        math(String.raw`\nu(a)\ne a`),
        " が成り立つ。したがって任意の ",
        math(String.raw`\sigma\in\mathcal S_G`),
        " と ",
        math(String.raw`v\in V`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathfrak F_G(\mathfrak F_G(\sigma))(v)
&=\nu(\mathfrak F_G(\sigma)(v))
&&\bigl(\because\ \mathfrak F_G\text{ の定義}\bigr)\\
&=\nu(\nu(\sigma(v)))
&&\bigl(\because\ \mathfrak F_G\text{ の定義}\bigr)\\
&=\sigma(v)
&&\bigl(\because\ \nu(\nu(a))=a\bigr).
\end{aligned}`),
      paragraph([
        "ゆえに ",
        math(String.raw`\mathfrak F_G(\mathfrak F_G(\sigma))=\sigma`),
        " である。また ",
        ref("def_finite_graph_input"),
        " より ",
        math(String.raw`V`),
        " は空でないので、",
        math(String.raw`w\in V`),
        " を一つ選べる。このとき",
      ]),
      displayMath(String.raw`\mathfrak F_G(\sigma)(w)
=\nu(\sigma(w))
\ne\sigma(w)
\quad\bigl(\because\ \nu(a)\ne a\bigr).`),
      paragraph([
        "したがって ",
        math(String.raw`\mathfrak F_G`),
        " は不動点を持たない対合である。任意の ",
        math(String.raw`e\in E`),
        " に対して、",
        ref("def_broken_edge_set"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
e\in B_G(\mathfrak F_G(\sigma))
&\iff
\nu\!\left(\sigma\!\left(\partial_G(e,\mathsf{source})\right)\right)
\ne
\nu\!\left(\sigma\!\left(\partial_G(e,\mathsf{target})\right)\right)
&&\bigl(\because\ B_G\text{ と }\mathfrak F_G\text{ の定義}\bigr)\\
&\iff
\sigma\!\left(\partial_G(e,\mathsf{source})\right)
\ne
\sigma\!\left(\partial_G(e,\mathsf{target})\right)
&&\bigl(\because\ \nu\text{ は全単射}\bigr)\\
&\iff e\in B_G(\sigma)
&&\bigl(\because\ B_G\text{ の定義}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
B_G(\mathfrak F_G(\sigma))
&=B_G(\sigma)
&&\bigl(\because\ E\text{ の全ての元について所属が同値}\bigr)\\
b_G(\mathfrak F_G(\sigma))
&=b_G(\sigma)
&&\bigl(\because\ \text{等しい有限集合の元数は等しい}\bigr).
\end{aligned}`),
      paragraph([
        "各 ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " に対し、有限集合を",
      ]),
      displayMath(String.raw`\mathcal A_m:=\{\sigma\in\mathcal S_G\mid b_G(\sigma)=m\}`),
      paragraph([
        "と置く。直前の等式より ",
        math(String.raw`\mathfrak F_G`),
        " は ",
        math(String.raw`\mathcal A_m`),
        " を保つ。不動点を持たない対合は有限集合を二元部分集合へ分割するので、ある ",
        math(String.raw`n_m\in\mathbb N`),
        " が存在して",
      ]),
      paragraph([ref("def_broken_edge_multiplicity"), " より"]),
      displayMath(String.raw`\Omega_G(m)
=|\mathcal A_m|
=2n_m
\in\{2n\mid n\in\mathbb N\}.`),
      paragraph([
        "全ての集合は有限であり、多重度は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_odd_incident_edge_count_root_minus_one",
    kind: "theorem",
    title: { text: "奇数本の辺が接続する頂点と零点 -1" },
    labels: ["theorem_odd_incident_edge_count_root_minus_one"],
    habitat: "Z",
    verification: ["sagemath/check/odd-incident-edge-count-root-minus-one"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフに、接続する辺の本数が奇数である頂点 ",
        math(String.raw`w\in V`),
        " が存在すると仮定する。すなわち",
      ]),
      displayMath(String.raw`I_w:=\left\{e\in E\ \middle|\ \partial_G(e,\mathsf{source})=w\ \text{または}\ \partial_G(e,\mathsf{target})=w\right\},\qquad |I_w|\in\{2n+1\mid n\in\mathbb N\}.`),
      paragraph(["このとき"]),
      displayMath(String.raw`Z_G(-1)=0\in\mathbb Z.`),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`\sigma\in\mathcal S_G`),
        " に対し、",
        math(String.raw`r_w(\sigma):=|B_G(\sigma)\cap I_w|\in\mathbb N`),
        " と置く。",
        ref("def_finite_graph_input"),
        " は自己ループを許さないので、",
        math(String.raw`I_w`),
        " の各辺では二端点のうち一方だけが ",
        math(String.raw`w`),
        " である。したがって ",
        ref("def_single_vertex_spin_flip"),
        " の ",
        math(String.raw`T_w`),
        " は ",
        math(String.raw`I_w`),
        " に属する辺の破れ・非破れを交換し、それ以外の辺の状態を保存する。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
b_G(T_w(\sigma))
&=|I_w\setminus B_G(\sigma)|+|B_G(\sigma)\setminus I_w|
&&\bigl(\because\ T_w\text{ は }I_w\text{ 上だけ破れ・非破れを交換する}\bigr)\\
&=\bigl(|I_w|-r_w(\sigma)\bigr)+\bigl(b_G(\sigma)-r_w(\sigma)\bigr)
&&\bigl(\because\ r_w(\sigma)=|B_G(\sigma)\cap I_w|\bigr)\\
&=b_G(\sigma)+|I_w|-2r_w(\sigma)
&&\bigl(\because\ \mathbb Z\text{ 上の加法の整理}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`|I_w|`),
        " は奇数であり、",
        math(String.raw`2r_w(\sigma)`),
        " は偶数なので",
      ]),
      displayMath(String.raw`\begin{aligned}
(-1)^{b_G(T_w(\sigma))}
&=(-1)^{b_G(\sigma)+|I_w|-2r_w(\sigma)}
&&\bigl(\because\ \text{直前の破れ辺数の等式}\bigr)\\
&=-(-1)^{b_G(\sigma)}
&&\bigl(\because\ |I_w|\text{ は奇数かつ }2r_w(\sigma)\text{ は偶数}\bigr).
\end{aligned}`),
      paragraph([
        ref("claim_single_vertex_spin_flip_involution"),
        " より、",
        math(String.raw`T_w`),
        " は有限集合 ",
        math(String.raw`\mathcal S_G`),
        " を二元部分集合 ",
        math(String.raw`\{\sigma,T_w(\sigma)\}`),
        " へ分割する。各二元部分集合からの二項は直前の等式により相殺する。",
        ref("def_ising_partition_polynomial"),
        " に整数 ",
        math(String.raw`-1`),
        " を評価すると",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_G(-1)
&=\sum_{\sigma\in\mathcal S_G}(-1)^{b_G(\sigma)}
&&\bigl(\because\ \text{Ising 分配多項式の定義}\bigr)\\
&=0
&&\bigl(\because\ T_w\text{ の各二元軌道内で二項が相殺する}\bigr).
\end{aligned}`),
      paragraph([
        "全ての集合は有限であり、破れ辺数と元数は自然数、評価値は整数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_even_incident_edge_counts_evaluation_minus_one",
    kind: "theorem",
    title: { text: "全頂点の接続辺数が偶数の場合の -1 評価" },
    labels: ["theorem_even_incident_edge_counts_evaluation_minus_one"],
    habitat: "Z",
    verification: ["sagemath/check/even-incident-edge-counts-evaluation-minus-one"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、全ての頂点 ",
        math(String.raw`v\in V`),
        " に接続する辺の本数が偶数であると仮定する。すなわち",
      ]),
      displayMath(String.raw`I_v:=\left\{e\in E\ \middle|\ \partial_G(e,\mathsf{source})=v\ \text{または}\ \partial_G(e,\mathsf{target})=v\right\},\qquad |I_v|\in\{2n\mid n\in\mathbb N\}\quad(v\in V).`),
      paragraph(["このとき"]),
      displayMath(String.raw`Z_G(-1)=2^{|V|}\in\mathbb Z.`),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`\sigma\in\mathcal S_G`),
        " に対し、上向きスピンをもつ頂点集合と、その内部だけを結ぶ辺集合を",
      ]),
      displayMath(String.raw`U_\sigma:=\{v\in V\mid \sigma(v)=\mathsf{up}\},\qquad
E_\sigma^{\mathrm{in}}:=\left\{e\in E\ \middle|\ \partial_G(e,\mathsf{source})\in U_\sigma,\ \partial_G(e,\mathsf{target})\in U_\sigma\right\}`),
      paragraph([
        "と置く。",
        ref("def_finite_graph_input"),
        " は自己ループを許さない。したがって、",
        math(String.raw`U_\sigma`),
        " に接続する辺端を数えると、",
        math(String.raw`E_\sigma^{\mathrm{in}}`),
        " の各辺は二回、",
        ref("def_broken_edge_set"),
        " の各辺は一回だけ数えられるので",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{v\in U_\sigma}|I_v|
&=2|E_\sigma^{\mathrm{in}}|+|B_G(\sigma)|
&&\bigl(\because\ \text{有限集合 }U_\sigma\text{ に接続する辺端の二通りの数え上げ}\bigr)\\
&=2|E_\sigma^{\mathrm{in}}|+b_G(\sigma)
&&\bigl(\because\ b_G(\sigma)=|B_G(\sigma)|\bigr).
\end{aligned}`),
      paragraph([
        "各 ",
        math(String.raw`|I_v|`),
        " は偶数なので左辺は偶数であり、",
        math(String.raw`2|E_\sigma^{\mathrm{in}}|`),
        " も偶数である。整数加法の消去律より、",
        math(String.raw`b_G(\sigma)`),
        " は偶数である。ゆえに",
      ]),
      displayMath(String.raw`(-1)^{b_G(\sigma)}=1
\quad\bigl(\because\ b_G(\sigma)\text{ は偶数}\bigr).`),
      paragraph([
        ref("def_ising_partition_polynomial"),
        " に整数 ",
        math(String.raw`-1`),
        " を評価すると",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_G(-1)
&=\sum_{\sigma\in\mathcal S_G}(-1)^{b_G(\sigma)}
&&\bigl(\because\ \text{Ising 分配多項式の定義}\bigr)\\
&=\sum_{\sigma\in\mathcal S_G}1
&&\bigl(\because\ \text{全ての }b_G(\sigma)\text{ は偶数}\bigr)\\
&=|\mathcal S_G|
&&\bigl(\because\ \text{有限集合上の定数 }1\text{ の和}\bigr).
\end{aligned}`),
      paragraph([ref("def_spin_configuration_set"), " より"]),
      displayMath(String.raw`|\mathcal S_G|=2^{|V|}.`),
      paragraph([
        "全ての集合は有限であり、接続辺数、破れ辺数、元数は自然数、評価値は整数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_root_minus_one_characterizes_odd_incident_edge_count",
    kind: "theorem",
    title: { text: "零点 -1 による奇接続辺数頂点の特徴付け" },
    labels: ["theorem_root_minus_one_characterizes_odd_incident_edge_count"],
    habitat: "Z",
    verification: ["sagemath/check/root-minus-one-odd-incident-edge-characterization"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、整数 ",
        math(String.raw`-1`),
        " が Ising 分配多項式の零点であることと、接続する辺の本数が奇数である頂点が存在することは同値である。すなわち",
      ]),
      displayMath(String.raw`Z_G(-1)=0
\quad\Longleftrightarrow\quad
\exists w\in V,\quad
\left|
  \left\{
    e\in E
    \ \middle|\;
    \partial_G(e,\mathsf{source})=w
    \quad\text{または}\quad
    \partial_G(e,\mathsf{target})=w
  \right\}
\right|
\in\{2n+1\mid n\in\mathbb N\}.`),
    ],
    proof: [
      paragraph([
        "まず、接続する辺の本数が奇数である頂点が存在すると仮定する。",
        ref("theorem_odd_incident_edge_count_root_minus_one"),
        " より",
      ]),
      displayMath(String.raw`Z_G(-1)=0.`),
      paragraph([
        "逆に、",
        math(String.raw`Z_G(-1)=0`),
        " と仮定する。接続する辺の本数が奇数である頂点が存在しないと仮定すると、各接続辺数は自然数なので、全ての頂点の接続辺数は偶数である。",
        ref("theorem_even_incident_edge_counts_evaluation_minus_one"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_G(-1)
&=2^{|V|}
&&\bigl(\because\ \text{全頂点の接続辺数が偶数である}\bigr)\\
&\ne0
&&\bigl(\because\ |V|\in\mathbb N\text{ かつ }2^{|V|}\text{ は正の整数である}\bigr).
\end{aligned}`),
      paragraph([
        "これは仮定 ",
        math(String.raw`Z_G(-1)=0`),
        " に反する。したがって、接続する辺の本数が奇数である頂点が存在する。全ての集合は有限であり、接続辺数は自然数、評価値は整数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_linear_factor_characterizes_odd_incident_edge_count",
    kind: "theorem",
    title: { text: "一次因子 x+1 による奇接続辺数頂点の特徴付け" },
    labels: ["theorem_linear_factor_characterizes_odd_incident_edge_count"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/linear-factor-odd-incident-edge-characterization"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、整数係数多項式 ",
        math(String.raw`x+1`),
        " が Ising 分配多項式を割り切ることと、接続する辺の本数が奇数である頂点が存在することは同値である。すなわち",
      ]),
      displayMath(String.raw`(x+1)\mid Z_G(x)\ \text{ in }\mathbb Z[x]
\quad\Longleftrightarrow\quad
\exists w\in V,\quad
\left|
  \left\{
    e\in E
    \ \middle|\;
    \partial_G(e,\mathsf{source})=w
    \quad\text{または}\quad
    \partial_G(e,\mathsf{target})=w
  \right\}
\right|
\in\{2n+1\mid n\in\mathbb N\}.`),
    ],
    proof: [
      paragraph([
        ref("def_ising_partition_polynomial"),
        " より ",
        math(String.raw`Z_G(x)\in\mathbb Z[x]`),
        " である。モニック一次多項式による整数係数多項式の除法より、ある ",
        math(String.raw`Q_G(x)\in\mathbb Z[x]`),
        " と ",
        math(String.raw`r_G\in\mathbb Z`),
        " が一意に存在して",
      ]),
      displayMath(String.raw`Z_G(x)=(x+1)Q_G(x)+r_G.`),
      displayMath(String.raw`\begin{aligned}
r_G
&=Z_G(-1)
&&\bigl(\because\ x=-1\text{ を直前の除法等式へ代入}\bigr),\\
(x+1)\mid Z_G(x)\ \text{ in }\mathbb Z[x]
&\Longleftrightarrow r_G=0
&&\bigl(\because\ \text{多項式の整除と除法の余りの定義}\bigr),\\
&\Longleftrightarrow Z_G(-1)=0
&&\bigl(\because\ r_G=Z_G(-1)\bigr).
\end{aligned}`),
      paragraph([ref("theorem_root_minus_one_characterizes_odd_incident_edge_count"), " より"]),
      displayMath(String.raw`Z_G(-1)=0
\quad\Longleftrightarrow\quad
\exists w\in V,\quad
\left|
  \left\{
    e\in E
    \ \middle|\;
    \partial_G(e,\mathsf{source})=w
    \quad\text{または}\quad
    \partial_G(e,\mathsf{target})=w
  \right\}
\right|
\in\{2n+1\mid n\in\mathbb N\}.`),
      paragraph([
        "以上の二つの同値性を接続して結論を得る。除法の商は整数係数多項式、余りと評価値は整数、接続辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_even_linear_factor_characterizes_odd_incident_edge_count",
    kind: "theorem",
    title: { text: "因子 2(x+1) による奇接続辺数頂点の特徴付け" },
    labels: ["theorem_even_linear_factor_characterizes_odd_incident_edge_count"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/even-linear-factor-odd-incident-edge-characterization"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、整数係数多項式 ",
        math(String.raw`2(x+1)`),
        " が Ising 分配多項式を割り切ることと、接続する辺の本数が奇数である頂点が存在することは同値である。すなわち",
      ]),
      displayMath(String.raw`2(x+1)\mid Z_G(x)\ \text{ in }\mathbb Z[x]
\quad\Longleftrightarrow\quad
\exists w\in V,\quad
\left|
  \left\{
    e\in E
    \ \middle|\;
    \partial_G(e,\mathsf{source})=w
    \quad\text{または}\quad
    \partial_G(e,\mathsf{target})=w
  \right\}
\right|
\in\{2n+1\mid n\in\mathbb N\}.`),
    ],
    proof: [
      paragraph([
        ref("theorem_partition_polynomial_coefficient_evenness"),
        " より、各 ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " に対してある ",
        math(String.raw`n_m\in\mathbb N`),
        " が存在して ",
        math(String.raw`\Omega_G(m)=2n_m`),
        " である。整数係数多項式を",
      ]),
      displayMath(String.raw`P_G(x):=\sum_{m=0}^{|E|}n_mx^m\in\mathbb Z[x]`),
      paragraph(["と置く。", ref("claim_partition_polynomial_coefficient_expansion"), " より"]),
      displayMath(String.raw`\begin{aligned}
Z_G(x)
&=\sum_{m=0}^{|E|}\Omega_G(m)x^m
&&\bigl(\because\ \text{多重度による係数表示}\bigr)\\
&=\sum_{m=0}^{|E|}2n_mx^m
&&\bigl(\because\ \Omega_G(m)=2n_m\bigr)\\
&=2P_G(x)
&&\bigl(\because\ P_G(x)\text{ の定義}\bigr).
\end{aligned}`),
      paragraph([
        "まず、接続する辺の本数が奇数である頂点が存在すると仮定する。",
        ref("theorem_root_minus_one_characterizes_odd_incident_edge_count"),
        " より ",
        math(String.raw`Z_G(-1)=0`),
        " である。直前の多項式等式へ ",
        math(String.raw`x=-1`),
        " を代入すると",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&=2P_G(-1)
&&\bigl(\because\ Z_G(-1)=0\text{ かつ }Z_G(x)=2P_G(x)\bigr),\\
P_G(-1)
&=0
&&\bigl(\because\ \mathbb Z\text{ は整域であり }2\ne0\bigr).
\end{aligned}`),
      paragraph([
        "モニック一次多項式による整数係数多項式の除法より、ある ",
        math(String.raw`R_G(x)\in\mathbb Z[x]`),
        " と ",
        math(String.raw`s_G\in\mathbb Z`),
        " が存在して",
      ]),
      displayMath(String.raw`\begin{aligned}
P_G(x)
&=(x+1)R_G(x)+s_G
&&\bigl(\because\ x+1\text{ による除法}\bigr),\\
s_G
&=P_G(-1)
&&\bigl(\because\ x=-1\text{ を除法等式へ代入}\bigr),\\
&=0
&&\bigl(\because\ P_G(-1)=0\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Z_G(x)
&=2P_G(x)
&&\bigl(\because\ \text{直前の係数表示}\bigr)\\
&=2(x+1)R_G(x)
&&\bigl(\because\ P_G(x)=(x+1)R_G(x)\bigr).
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`2(x+1)\mid Z_G(x)`), " が成り立つ。"]),
      paragraph([
        "逆に、",
        math(String.raw`2(x+1)\mid Z_G(x)`),
        " と仮定する。ある ",
        math(String.raw`S_G(x)\in\mathbb Z[x]`),
        " が存在して",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_G(x)
&=2(x+1)S_G(x)
&&\bigl(\because\ \text{整除の定義}\bigr)\\
&=(x+1)\bigl(2S_G(x)\bigr)
&&\bigl(\because\ \mathbb Z[x]\text{ 上の結合律}\bigr).
\end{aligned}`),
      paragraph([
        "ゆえに ",
        math(String.raw`(x+1)\mid Z_G(x)`),
        " である。",
        ref("theorem_linear_factor_characterizes_odd_incident_edge_count"),
        " より、接続する辺の本数が奇数である頂点が存在する。全ての係数と評価値は整数、接続辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_partition_polynomial_degree_maximum_broken_edge_count",
    kind: "theorem",
    title: { text: "Ising 分配多項式の次数と最大破れ辺数" },
    labels: ["theorem_partition_polynomial_degree_maximum_broken_edge_count"],
    habitat: "N",
    verification: ["sagemath/check/partition-polynomial-degree-maximum-broken-edge-count"],
    statement: [
      paragraph([
        ref("def_spin_configuration_set"),
        " の有限で空でないスピン配位集合に対し、",
        ref("def_broken_edge_set"),
        " の破れ辺数が取る最大値を用いると、",
      ]),
      displayMath(String.raw`\deg Z_G(x)
=
\max_{\sigma\in\mathcal S_G} b_G(\sigma)
\in\mathbb N.`),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathcal S_G`),
        " は有限で空でなく、任意の ",
        math(String.raw`\sigma\in\mathcal S_G`),
        " に対して ",
        math(String.raw`b_G(\sigma)\in\{0,1,\ldots,|E|\}`),
        " である。したがって破れ辺数の像は有限で空でなく、その最大値は自然数として存在する。また、任意の配位を一つ取れば、その破れ辺数における多重度は正なので ",
        math(String.raw`Z_G(x)\ne0`),
        " である。",
      ]),
      paragraph([
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の係数表示と ",
        ref("def_broken_edge_multiplicity"),
        " の多重度の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\deg Z_G(x)
&=
\max\left\{
  m\in\{0,1,\ldots,|E|\}
  \ \middle|\;
  \Omega_G(m)\ne0
\right\}
&&\bigl(\because\ \text{非零多項式の次数の定義}\bigr)\\
&=
\max\left\{
  m\in\{0,1,\ldots,|E|\}
  \ \middle|\;
  \exists\sigma\in\mathcal S_G,\ b_G(\sigma)=m
\right\}
&&\bigl(\because\ \text{多重度が正である条件}\bigr)\\
&=
\max_{\sigma\in\mathcal S_G} b_G(\sigma)
&&\bigl(\because\ \text{有限像集合の定義}\bigr).
\end{aligned}`),
      paragraph([
        "全ての集合は有限であり、次数、破れ辺数、多重度は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_partition_polynomial_degree_maximum_cut_size",
    kind: "theorem",
    title: { text: "Ising 分配多項式の次数と最大カット辺数" },
    labels: ["theorem_partition_polynomial_degree_maximum_cut_size"],
    habitat: "N",
    verification: ["sagemath/check/partition-polynomial-degree-maximum-cut-size"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフに対し、Ising 分配多項式の次数は、頂点部分集合とその補集合を横切る辺数の最大値に等しい。すなわち",
      ]),
      displayMath(String.raw`\deg Z_G(x)
=
\max_{A\subseteq V}
\left|
  \left\{
    e\in E
    \ \middle|\;
    \begin{array}{l}
      \partial_G(e,\mathsf{source})\in A,\;
      \partial_G(e,\mathsf{target})\notin A,\\
      \text{または }\partial_G(e,\mathsf{source})\notin A,\;
      \partial_G(e,\mathsf{target})\in A
    \end{array}
  \right\}
\right|
\in\mathbb N.`),
    ],
    proof: [
      paragraph([
        "各配位 ",
        math(String.raw`\sigma\in\mathcal S_G`),
        " と各頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " に対し、証明中だけ用いる記号を",
      ]),
      displayMath(String.raw`A_\sigma:=\{v\in V\mid \sigma(v)=\mathsf{up}\},\qquad
\sigma_A(v):=
\begin{cases}
  \mathsf{up} & (v\in A),\\
  \mathsf{down} & (v\notin A)
\end{cases}
\quad(v\in V)`),
      paragraph([
        "と置く。",
        ref("def_spin_label_set"),
        " の二つのスピンラベルは相異なるので、",
      ]),
      displayMath(String.raw`\begin{aligned}
A_{\sigma_A}
&=A
&&\bigl(\because\ \text{二つの定義の展開}\bigr),\\
\sigma_{A_\sigma}(v)
&=\sigma(v)
&&\bigl(\because\ \sigma(v)=\mathsf{up}\text{ と }\sigma(v)=\mathsf{down}\text{ の二場合}\bigr).
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`\sigma\mapsto A_\sigma`),
        " と ",
        math(String.raw`A\mapsto\sigma_A`),
        " は有限集合 ",
        math(String.raw`\mathcal S_G`),
        " と ",
        math(String.raw`\{A\mid A\subseteq V\}`),
        " の間の互いに逆な全単射である。さらに ",
        ref("def_broken_edge_set"),
        " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
b_G(\sigma)
&=
\left|
  \left\{
    e\in E
    \ \middle|\;
    \sigma\!\left(\partial_G(e,\mathsf{source})\right)
    \ne
    \sigma\!\left(\partial_G(e,\mathsf{target})\right)
  \right\}
\right|
&&\bigl(\because\ \text{破れ辺数の定義}\bigr)\\
&=
\left|
  \left\{
    e\in E
    \ \middle|\;
    \begin{array}{l}
      \partial_G(e,\mathsf{source})\in A_\sigma,\;
      \partial_G(e,\mathsf{target})\notin A_\sigma,\\
      \text{または }\partial_G(e,\mathsf{source})\notin A_\sigma,\;
      \partial_G(e,\mathsf{target})\in A_\sigma
    \end{array}
  \right\}
\right|
&&\bigl(\because\ A_\sigma\text{ の定義と二つのスピンラベルの相異性}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と上の全単射および辺数の一致より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\deg Z_G(x)
&=
\max_{\sigma\in\mathcal S_G}b_G(\sigma)
&&\bigl(\because\ \text{Ising 分配多項式の次数と最大破れ辺数}\bigr)\\
&=
\max_{A\subseteq V}
\left|
  \left\{
    e\in E
    \ \middle|\;
    \begin{array}{l}
      \partial_G(e,\mathsf{source})\in A,\;
      \partial_G(e,\mathsf{target})\notin A,\\
      \text{または }\partial_G(e,\mathsf{source})\notin A,\;
      \partial_G(e,\mathsf{target})\in A
    \end{array}
  \right\}
\right|
&&\bigl(\because\ \sigma\mapsto A_\sigma\text{ は全単射で各辺数を保存する}\bigr).
\end{aligned}`),
      paragraph([
        "全ての集合は有限であり、次数と辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_product_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点積と両端係数比" },
    labels: ["theorem_fisher_zero_product_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-product-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書くとき、",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}\alpha_j
=
(-1)^d\frac{\Omega_G(0)}{\Omega_G(d)}
\quad\text{in }\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`d=0`),
        " の場合、左辺は空積 ",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "全頂点下向き配位は ",
        ref("def_spin_configuration_set"),
        " に属し、",
        ref("def_broken_edge_set"),
        " の破れ辺数零をもつので、",
        ref("def_broken_edge_multiplicity"),
        " より ",
        math(String.raw`\Omega_G(0)\in\mathbb N_{>0}`),
        " である。",
      ]),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数であり、",
        math(String.raw`\Omega_G(0)`),
        " は定数項である。標準単射で移した多項式を ",
        math(String.raw`\overline P_G(x)`),
        " と書く。代数的閉体 ",
        math(String.raw`\overline{\mathbb Q}`),
        " 上の一次因子分解により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\Omega_G(d)\prod_{j=1}^{d}(x-\alpha_j)`),
      paragraph(["と書ける。したがって、"]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(0)
&=\overline P_G(0)
&&\bigl(\because\ \text{定数項の定義}\bigr)\\
&=\Omega_G(d)\prod_{j=1}^{d}(0-\alpha_j)
&&\bigl(\because\ \text{一次因子分解へ }x=0\text{ を代入}\bigr)\\
&=\Omega_G(d)(-1)^d\prod_{j=1}^{d}\alpha_j
&&\bigl(\because\ \text{有限積の各因子から }-1\text{ を取り出す}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\Omega_G(d)\ne0`),
        " なので、代数的数の体で ",
        math(String.raw`\Omega_G(d)`),
        " を消去すると、",
      ]),
      displayMath(String.raw`\frac{\Omega_G(0)}{\Omega_G(d)}
=
(-1)^d\prod_{j=1}^{d}\alpha_j.`),
      paragraph([math(String.raw`(-1)^{2d}=1`), " なので、"]),
      displayMath(String.raw`\prod_{j=1}^{d}\alpha_j
=
(-1)^d\frac{\Omega_G(0)}{\Omega_G(d)}.`),
      paragraph([
        "零点と積は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、次数と多重度は自然数、両端係数は正の自然数、その比は正の有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zeros_nonzero",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点の非零性" },
    labels: ["theorem_fisher_zeros_nonzero"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zeros-nonzero"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を ",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、全ての ",
        math(String.raw`j\in\{1,\ldots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\alpha_j\ne0\quad\text{in }\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`d=0`),
        " の場合、添字集合 ",
        math(String.raw`\{1,\ldots,d\}`),
        " は空集合であり、主張は空虚に真である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fisher_zero_product_coefficient_ratio"),
        " より、重複度込み Fisher 零点の積は",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}\alpha_j
=
(-1)^d\frac{\Omega_G(0)}{\Omega_G(d)}
\quad\text{in }\overline{\mathbb Q}.`),
      paragraph([
        "全頂点下向き配位 ",
        math(String.raw`\sigma_{\mathsf{down}}:V\to\mathsf{Spin}`),
        " を全ての ",
        math(String.raw`v\in V`),
        " について ",
        math(String.raw`\sigma_{\mathsf{down}}(v):=\mathsf{down}`),
        " と定める。",
        ref("def_spin_configuration_set"),
        " と ",
        ref("def_broken_edge_set"),
        " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sigma_{\mathsf{down}}
&\in\mathcal S_G
&&\bigl(\because\ V\text{ から }\mathsf{Spin}\text{ への写像である}\bigr)\\
B_G(\sigma_{\mathsf{down}})
&=\varnothing
&&\bigl(\because\ \text{全頂点のスピンラベルが }\mathsf{down}\text{ で等しい}\bigr)\\
b_G(\sigma_{\mathsf{down}})
&=0
&&\bigl(\because\ |\varnothing|=0\bigr).
\end{aligned}`),
      paragraph([ref("def_broken_edge_multiplicity"), " より、"]),
      displayMath(String.raw`\Omega_G(0)>0
\quad\bigl(\because\ \sigma_{\mathsf{down}}\text{ は破れ辺数 }0\text{ のファイバーに属する}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
      ]),
      displayMath(String.raw`\Omega_G(d)>0
\quad\bigl(\because\ \Omega_G(d)\text{ は }Z_G(x)\text{ の非零な最高次係数である}\bigr).`),
      paragraph(["自然数から代数的数への標準単射より、"]),
      displayMath(String.raw`\begin{aligned}
(-1)^d
&\ne0
&&\bigl(\because\ (-1)^d\in\{-1,1\}\bigr)\\
\frac{\Omega_G(0)}{\Omega_G(d)}
&\ne0
&&\bigl(\because\ \Omega_G(0)>0\text{ かつ }\Omega_G(d)>0\bigr)\\
(-1)^d\frac{\Omega_G(0)}{\Omega_G(d)}
&\ne0
&&\bigl(\because\ \overline{\mathbb Q}\text{ は体であり、二つの非零元の積は非零}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_fisher_zero_product_coefficient_ratio"),
        " と直前の非零性より、",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}\alpha_j\ne0
\quad\text{in }\overline{\mathbb Q}.`),
      paragraph([
        "任意の ",
        math(String.raw`k\in\{1,\ldots,d\}`),
        " を取る。もし ",
        math(String.raw`\alpha_k=0`),
        " なら、",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{d}\alpha_j
&=
\alpha_k\prod_{\substack{1\le j\le d\\j\ne k}}\alpha_j
&&\bigl(\because\ \text{有限積の交換律と結合律}\bigr)\\
&=
0
&&\bigl(\because\ \alpha_k=0\bigr),
\end{aligned}`),
      paragraph([
        "となり、直前に得た積の非零性に反する。したがって ",
        math(String.raw`\alpha_k\ne0`),
        " である。",
        math(String.raw`k`),
        " は任意だったので結論を得る。零点と有限積は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、次数と多重度は自然数、両端係数は正の自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_reciprocal_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点の逆数和と低次係数比" },
    labels: ["theorem_fisher_zero_reciprocal_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-reciprocal-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        math(String.raw`E\ne\varnothing`),
        " と仮定し、",
        ref("def_ising_partition_polynomial"),
        " の次数を ",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N_{>0}`),
        " と置く。係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\frac{1}{\alpha_j}
=
-\frac{\Omega_G(1)}{\Omega_G(0)}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        math(String.raw`e_0\in E`),
        " を一つ選ぶ。配位",
      ]),
      displayMath(String.raw`\sigma_0(v):=
\begin{cases}
  \mathsf{down} & \bigl(v=\partial_G(e_0,\mathsf{target})\bigr),\\
  \mathsf{up} & \bigl(v\ne\partial_G(e_0,\mathsf{target})\bigr)
\end{cases}
\qquad(v\in V)`),
      paragraph(["を定める。", ref("def_spin_configuration_set"), " より、"]),
      displayMath(String.raw`\sigma_0\in\mathcal S_G
\quad\bigl(\because\ \sigma_0:V\to\mathsf{Spin}\text{ は写像である}\bigr).`),
      paragraph([ref("def_finite_graph_input"), " の二端点の相異性と ", ref("def_broken_edge_set"), " より、"]),
      displayMath(String.raw`\begin{aligned}
e_0
&\in B_G(\sigma_0)
&&\bigl(\because\ \sigma_0(\partial_G(e_0,\mathsf{source}))=\mathsf{up}\ne\mathsf{down}=\sigma_0(\partial_G(e_0,\mathsf{target}))\bigr)\\
b_G(\sigma_0)
&\ge1
&&\bigl(\because\ e_0\in B_G(\sigma_0)\bigr).
\end{aligned}`),
      paragraph([ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"), " より、"]),
      displayMath(String.raw`\begin{aligned}
d
&=\max_{\sigma\in\mathcal S_G}b_G(\sigma)
&&\bigl(\because\ \text{Ising 分配多項式の次数と最大破れ辺数}\bigr)\\
&\ge b_G(\sigma_0)
&&\bigl(\because\ \sigma_0\in\mathcal S_G\bigr)\\
&\ge1
&&\bigl(\because\ b_G(\sigma_0)\ge1\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_fisher_zeros_nonzero"),
        " より、全ての",
        math(String.raw`j\in\{1,\ldots,d\}`),
        " について",
        math(String.raw`\alpha_j\ne0`),
        " であり、逆数",
        math(String.raw`\alpha_j^{-1}\in\overline{\mathbb Q}`),
        " が定まる。",
      ]),
      paragraph([
        "係数を移した多項式を",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        " と書く。代数的閉体上の一次因子分解と",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の係数表示より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(1)
&=
\Omega_G(d)
\sum_{k=1}^{d}
\prod_{\substack{1\le j\le d\\j\ne k}}
(-\alpha_j)
&&\bigl(\because\ \overline P_G(x)=\Omega_G(d)\prod_{j=1}^{d}(x-\alpha_j)\text{ の }x\text{ の係数}\bigr)\\
&=
\Omega_G(d)(-1)^{d-1}
\sum_{k=1}^{d}
\prod_{\substack{1\le j\le d\\j\ne k}}
\alpha_j
&&\bigl(\because\ \text{各積の }d-1\text{ 個の因子から }-1\text{ を取り出す}\bigr)\\
&=
\Omega_G(d)(-1)^{d-1}
\left(\prod_{j=1}^{d}\alpha_j\right)
\sum_{k=1}^{d}\frac{1}{\alpha_k}
&&\bigl(\because\ \alpha_k\ne0\text{ なので }\prod_{j\ne k}\alpha_j=(\prod_j\alpha_j)/\alpha_k\bigr).
\end{aligned}`),
      paragraph([ref("theorem_fisher_zero_product_coefficient_ratio"), " より、"]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(1)
&=
\Omega_G(d)(-1)^{d-1}
\left(
  (-1)^d\frac{\Omega_G(0)}{\Omega_G(d)}
\right)
\sum_{k=1}^{d}\frac{1}{\alpha_k}
&&\bigl(\because\ \text{Fisher 零点積と両端係数比}\bigr)\\
&=
(-1)^{2d-1}\Omega_G(0)
\sum_{k=1}^{d}\frac{1}{\alpha_k}
&&\bigl(\because\ \Omega_G(d)\ne0\text{ なので約分する}\bigr)\\
&=
-\Omega_G(0)
\sum_{k=1}^{d}\frac{1}{\alpha_k}
&&\bigl(\because\ (-1)^{2d-1}=-1\bigr).
\end{aligned}`),
      paragraph([
        "全頂点下向き配位は破れ辺数零をもつので",
        math(String.raw`\Omega_G(0)>0`),
        " である。したがって代数的数の体で",
        math(String.raw`-\Omega_G(0)`),
        " を消去すると、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\frac{1}{\alpha_j}
=
-\frac{\Omega_G(1)}{\Omega_G(0)}.`),
      paragraph([
        "右辺は有理数なので、逆数和は",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点と逆数は代数的数、次数と多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点和と高次係数比" },
    labels: ["theorem_fisher_zero_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        math(String.raw`E\ne\varnothing`),
        " と仮定し、",
        ref("def_ising_partition_polynomial"),
        " の次数を ",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N_{>0}`),
        " と置く。係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j
=
-\frac{\Omega_G(d-1)}{\Omega_G(d)}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        math(String.raw`e_0\in E`),
        " を一つ選び、配位 ",
        math(String.raw`\sigma_0`),
        " を",
      ]),
      displayMath(String.raw`\sigma_0(v):=
\begin{cases}
  \mathsf{down} & \bigl(v=\partial_G(e_0,\mathsf{target})\bigr),\\
  \mathsf{up} & \bigl(v\ne\partial_G(e_0,\mathsf{target})\bigr)
\end{cases}
\qquad(v\in V)`),
      paragraph([ref("def_spin_configuration_set"), " より、"]),
      displayMath(String.raw`\sigma_0\in\mathcal S_G
\quad\bigl(\because\ \sigma_0:V\to\mathsf{Spin}\text{ は写像である}\bigr).`),
      paragraph([ref("def_finite_graph_input"), " の二端点の相異性と ", ref("def_broken_edge_set"), " より、"]),
      displayMath(String.raw`\begin{aligned}
e_0
&\in B_G(\sigma_0)
&&\bigl(\because\ \sigma_0(\partial_G(e_0,\mathsf{source}))=\mathsf{up}\ne\mathsf{down}=\sigma_0(\partial_G(e_0,\mathsf{target}))\bigr)\\
b_G(\sigma_0)
&\ge1
&&\bigl(\because\ e_0\in B_G(\sigma_0)\bigr).
\end{aligned}`),
      paragraph([ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"), " より、"]),
      displayMath(String.raw`\begin{aligned}
d
&=\max_{\sigma\in\mathcal S_G}b_G(\sigma)
&&\bigl(\because\ \text{Ising 分配多項式の次数と最大破れ辺数}\bigr)\\
&\ge b_G(\sigma_0)
&&\bigl(\because\ \sigma_0\in\mathcal S_G\bigr)\\
&\ge1
&&\bigl(\because\ b_G(\sigma_0)\ge1\bigr).
\end{aligned}`),
      paragraph([
        "係数を移した多項式を ",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        " と書く。代数的閉体上の一次因子分解と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の係数表示より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(d-1)
&=
\Omega_G(d)
\sum_{k=1}^{d}(-\alpha_k)
&&\bigl(\because\ \overline P_G(x)=\Omega_G(d)\prod_{j=1}^{d}(x-\alpha_j)\text{ の }x^{d-1}\text{ の係数}\bigr)\\
&=
-\Omega_G(d)
\sum_{k=1}^{d}\alpha_k
&&\bigl(\because\ \text{分配律}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数である。したがって代数的数の体で ",
        math(String.raw`-\Omega_G(d)`),
        " を消去すると、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j
=
-\frac{\Omega_G(d-1)}{\Omega_G(d)}.`),
      paragraph([
        "右辺は有理数なので、零点和は ",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点は代数的数、次数と多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_elementary_symmetric_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点の基本対称式と係数比" },
    labels: ["theorem_fisher_zero_elementary_symmetric_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-elementary-symmetric-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を ",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、任意の ",
        math(String.raw`k\in\{0,\ldots,d\}`),
        " について、",
      ]),
      displayMath(String.raw`\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}\alpha_j
=
(-1)^k\frac{\Omega_G(d-k)}{\Omega_G(d)}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`I=\varnothing`),
        " の項に現れる積は空積 ",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " とする。",
      ]),
    ],
    proof: [
      paragraph([
        "係数を移した多項式を ",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        " と書く。",
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数である。代数的閉体上の一次因子分解により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\Omega_G(d)\prod_{j=1}^{d}(x-\alpha_j)`),
      paragraph([
        "と書ける。任意の ",
        math(String.raw`k\in\{0,\ldots,d\}`),
        " を取る。",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の係数表示と上の一次因子分解の ",
        math(String.raw`x^{d-k}`),
        " の係数より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(d-k)
&=
\Omega_G(d)
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}(-\alpha_j)
&&\bigl(\because\ k\text{ 個の因子から定数項を選ぶ}\bigr)\\
&=
\Omega_G(d)(-1)^k
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}\alpha_j
&&\bigl(\because\ \text{各選択積の }k\text{ 個の因子から }-1\text{ を取り出す}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\Omega_G(d)\ne0`),
        " なので、代数的数の体で最高次係数を消去すると、",
      ]),
      displayMath(String.raw`\frac{\Omega_G(d-k)}{\Omega_G(d)}
=
(-1)^k
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}\alpha_j.`),
      paragraph([math(String.raw`(-1)^{2k}=1`), " なので、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}\alpha_j
&=
(-1)^{2k}
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}\alpha_j
&&\bigl(\because\ (-1)^{2k}=1\bigr)\\
&=
(-1)^k\frac{\Omega_G(d-k)}{\Omega_G(d)}
&&\bigl(\because\ \text{直前の係数比の等式}\bigr).
\end{aligned}`),
      paragraph([
        "右辺は有理数なので、基本対称式は ",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点と有限積は代数的数、次数、添字部分集合の元数、多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_power_sum_newton_recurrence",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点冪和の Newton 漸化式と係数比" },
    labels: ["theorem_fisher_zero_power_sum_newton_recurrence"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-power-sum-newton-recurrence"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を ",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。各 ",
        math(String.raw`s\in\{1,\ldots,d\}`),
        " について ",
        math(String.raw`p_s:=\sum_{j=1}^{d}\alpha_j^s\in\overline{\mathbb Q}`),
        " と定める。このとき、任意の ",
        math(String.raw`k\in\{1,\ldots,d\}`),
        " について、",
      ]),
      displayMath(String.raw`p_k
=
-\frac{
  \displaystyle
  \sum_{r=1}^{k-1}\Omega_G(d-r)p_{k-r}
  +k\Omega_G(d-k)
}{
  \Omega_G(d)
}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`k=1`),
        " のとき、右辺の和は空和 ",
        math(String.raw`0\in\overline{\mathbb Q}`),
        " とする。",
      ]),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`k\in\{1,\ldots,d\}`),
        " を取る。まず ",
        math(String.raw`k=1`),
        " の場合、",
        ref("theorem_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を一次へ適用すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
p_1
&=e_1
&&\bigl(\because\ p_1\text{ と一次基本対称式の定義}\bigr)\\
&=-\frac{\Omega_G(d-1)}{\Omega_G(d)}
&&\bigl(\because\ \text{Fisher 零点の一次基本対称式と係数比}\bigr).
\end{aligned}`),
      paragraph([
        "これは空和を用いた主張の式に等しい。以下では ",
        math(String.raw`k\ge2`),
        " とする。各 ",
        math(String.raw`r\in\{1,\ldots,k\}`),
        " について代数的数 ",
        math(String.raw`e_r,h_r\in\overline{\mathbb Q}`),
        " を",
      ]),
      displayMath(String.raw`e_r
:=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\prod_{i\in I}\alpha_i,
\qquad
h_r
:=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\alpha_i
\right)
\left(
  \sum_{j\in I}\alpha_j^{k-r}
\right)`),
      paragraph(["と定める。各 ", math(String.raw`r\in\{1,\ldots,k-1\}`), " について有限和の分配律により、"]),
      displayMath(String.raw`\begin{aligned}
e_rp_{k-r}
&=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\alpha_i
\right)
\left(
  \sum_{j=1}^{d}\alpha_j^{k-r}
\right)
&&\bigl(\because\ \text{定義を代入する}\bigr)\\
&=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\alpha_i
\right)
\left(
  \sum_{j\in I}\alpha_j^{k-r}
\right)
+
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\alpha_i
\right)
\left(
  \sum_{\substack{1\le j\le d\\j\notin I}}\alpha_j^{k-r}
\right)
&&\bigl(\because\ \{1,\ldots,d\}=I\sqcup(\{1,\ldots,d\}\setminus I)\bigr)\\
&=h_r+h_{r+1}
&&\bigl(\because\ J=I\cup\{j\}\text{ と置いて第二項を }|J|=r+1\text{ の和へ移す}\bigr).
\end{aligned}`),
      paragraph(["直前の等式へ ", math(String.raw`(-1)^{r-1}`), " を掛けて ", math(String.raw`r=1,\ldots,k-1`), " を足すと、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{r=1}^{k-1}(-1)^{r-1}e_rp_{k-r}
&=
\sum_{r=1}^{k-1}(-1)^{r-1}(h_r+h_{r+1})
&&\bigl(\because\ e_rp_{k-r}=h_r+h_{r+1}\bigr)\\
&=h_1+(-1)^{k-2}h_k
&&\bigl(\because\ h_2,\ldots,h_{k-1}\text{ の係数が }(-1)^{r-1}+(-1)^r=0\bigr).
\end{aligned}`),
      paragraph(["定義から、"]),
      displayMath(String.raw`\begin{aligned}
h_1
&=\sum_{j=1}^{d}\alpha_j\alpha_j^{k-1}
&&\bigl(\because\ |I|=1\bigr)\\
&=p_k
&&\bigl(\because\ \alpha_j\alpha_j^{k-1}=\alpha_j^k\bigr),\\
h_k
&=\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\left(
  \prod_{i\in I}\alpha_i
\right)
\sum_{j\in I}1
&&\bigl(\because\ \alpha_j^{k-k}=1\bigr)\\
&=ke_k
&&\bigl(\because\ |I|=k\bigr).
\end{aligned}`),
      paragraph(["したがって代数的数の体で、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{r=1}^{k-1}(-1)^{r-1}e_rp_{k-r}
&=p_k+(-1)^{k-2}ke_k
&&\bigl(\because\ h_1=p_k\text{ および }h_k=ke_k\bigr)\\
p_k
&=
\sum_{r=1}^{k-1}(-1)^{r-1}e_rp_{k-r}
+(-1)^{k-1}ke_k
&&\bigl(\because\ \text{移項する}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を ",
        math(String.raw`r=1,\ldots,k`),
        " に適用すると、",
      ]),
      displayMath(String.raw`e_r=(-1)^r\frac{\Omega_G(d-r)}{\Omega_G(d)}
\qquad(r\in\{1,\ldots,k\}).`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " である。直前の係数比を Newton 漸化式へ代入すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
p_k
&=
\sum_{r=1}^{k-1}
(-1)^{r-1}
(-1)^r
\frac{\Omega_G(d-r)}{\Omega_G(d)}p_{k-r}
+
(-1)^{k-1}k(-1)^k
\frac{\Omega_G(d-k)}{\Omega_G(d)}
&&\bigl(\because\ \text{基本対称式の係数比を代入する}\bigr)\\
&=
-\sum_{r=1}^{k-1}
\frac{\Omega_G(d-r)}{\Omega_G(d)}p_{k-r}
-
k\frac{\Omega_G(d-k)}{\Omega_G(d)}
&&\bigl(\because\ (-1)^{2r-1}=(-1)^{2k-1}=-1\bigr)\\
&=
-\frac{
  \displaystyle
  \sum_{r=1}^{k-1}\Omega_G(d-r)p_{k-r}
  +k\Omega_G(d-k)
}{
  \Omega_G(d)
}
&&\bigl(\because\ \Omega_G(d)\ne0\text{ なので共通分母へ移す}\bigr).
\end{aligned}`),
      paragraph([
        "この等式を ",
        math(String.raw`k=1`),
        " から順に用いると、空和から始まり、自然数と有理数の四則演算だけで全ての ",
        math(String.raw`p_k`),
        " が有理数として定まる。したがって ",
        math(String.raw`p_k\in\mathbb Q\subset\overline{\mathbb Q}`),
        " である。零点、その冪、有限積および有限和は代数的数、次数、冪指数、添字部分集合の元数、多重度は自然数、係数比と冪和は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_square_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点の二乗和と係数比" },
    labels: ["theorem_fisher_zero_square_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-square-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置き、",
        math(String.raw`d\ge2`),
        " と仮定する。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j^2
=
\frac{
  \Omega_G(d-1)^2-2\Omega_G(d)\Omega_G(d-2)
}{
  \Omega_G(d)^2
}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph(["有限和の分配律より、"]),
      displayMath(String.raw`\left(\sum_{j=1}^{d}\alpha_j\right)^2
=
\sum_{j=1}^{d}\alpha_j^2
+
2\sum_{1\le i<j\le d}\alpha_i\alpha_j.`),
      paragraph([
        ref("theorem_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を",
        math(String.raw`k=1`),
        " と",
        math(String.raw`k=2`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j
=
-\frac{\Omega_G(d-1)}{\Omega_G(d)},
\qquad
\sum_{1\le i<j\le d}\alpha_i\alpha_j
=
\frac{\Omega_G(d-2)}{\Omega_G(d)}.`),
      paragraph([ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"), " と", ref("claim_partition_polynomial_coefficient_expansion"), " より", math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`), " である。したがって代数的数の体で、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{d}\alpha_j^2
&=
\left(\sum_{j=1}^{d}\alpha_j\right)^2
-
2\sum_{1\le i<j\le d}\alpha_i\alpha_j
&&\bigl(\because\ \text{最初の有限和恒等式を移項する}\bigr)\\
&=
\left(-\frac{\Omega_G(d-1)}{\Omega_G(d)}\right)^2
-
2\frac{\Omega_G(d-2)}{\Omega_G(d)}
&&\bigl(\because\ \text{直前の二つの基本対称式を代入する}\bigr)\\
&=
\frac{\Omega_G(d-1)^2}{\Omega_G(d)^2}
-
2\frac{\Omega_G(d-2)}{\Omega_G(d)}
&&\bigl(\because\ \text{商の平方と }(-1)^2=1\bigr)\\
&=
\frac{\Omega_G(d-1)^2}{\Omega_G(d)^2}
-
\frac{2\Omega_G(d)\Omega_G(d-2)}{\Omega_G(d)^2}
&&\bigl(\because\ \Omega_G(d)/\Omega_G(d)=1\bigr)\\
&=
\frac{
  \Omega_G(d-1)^2-2\Omega_G(d)\Omega_G(d-2)
}{
  \Omega_G(d)^2
}
&&\bigl(\because\ \text{同じ分母をもつ二つの分数を引く}\bigr).
\end{aligned}`),
      paragraph([
        "右辺は有理数なので、Fisher 零点の二乗和は",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点とその二乗および有限和は代数的数、次数と多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_cube_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点の三乗和と係数比" },
    labels: ["theorem_fisher_zero_cube_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-cube-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置き、",
        math(String.raw`d\ge3`),
        " と仮定する。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j^3
=
\frac{
  -\Omega_G(d-1)^3
  +3\Omega_G(d)\Omega_G(d-1)\Omega_G(d-2)
  -3\Omega_G(d)^2\Omega_G(d-3)
}{
  \Omega_G(d)^3
}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        "代数的数",
        math(String.raw`e_1,e_2,e_3,s_{2,1}\in\overline{\mathbb Q}`),
        " を",
      ]),
      displayMath(String.raw`e_1:=\sum_{j=1}^{d}\alpha_j,
\qquad
e_2:=\sum_{1\le i<j\le d}\alpha_i\alpha_j,
\qquad
e_3:=\sum_{1\le i<j<k\le d}\alpha_i\alpha_j\alpha_k,
\qquad
s_{2,1}:=\sum_{\substack{1\le i,j\le d\\i\ne j}}\alpha_i^2\alpha_j`),
      paragraph(["と定める。有限和の分配律により、"]),
      displayMath(String.raw`\begin{aligned}
e_1^3
&=
\sum_{j=1}^{d}\alpha_j^3+3s_{2,1}+6e_3
&&\bigl(\because\ \text{三つの添字が全て同じ、二つだけ同じ、全て異なる場合へ分ける}\bigr),\\
e_1e_2
&=
s_{2,1}+3e_3
&&\bigl(\because\ \text{一つの添字が選択対に属する場合と属さない場合へ分ける}\bigr).
\end{aligned}`),
      paragraph(["したがって代数的数の体で、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{d}\alpha_j^3
&=
e_1^3-3s_{2,1}-6e_3
&&\bigl(\because\ \text{最初の有限和恒等式を移項する}\bigr)\\
&=
e_1^3-3(e_1e_2-3e_3)-6e_3
&&\bigl(\because\ \text{二番目の有限和恒等式を }s_{2,1}\text{ について解いて代入する}\bigr)\\
&=
e_1^3-3e_1e_2+9e_3-6e_3
&&\bigl(\because\ \text{分配律}\bigr)\\
&=
e_1^3-3e_1e_2+3e_3
&&\bigl(\because\ 9e_3-6e_3=3e_3\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を",
        math(String.raw`k=1,2,3`),
        " に適用すると、",
      ]),
      displayMath(String.raw`e_1=-\frac{\Omega_G(d-1)}{\Omega_G(d)},
\qquad
e_2=\frac{\Omega_G(d-2)}{\Omega_G(d)},
\qquad
e_3=-\frac{\Omega_G(d-3)}{\Omega_G(d)}.`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " である。直前の三つの基本対称式を代入すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{d}\alpha_j^3
&=
\left(-\frac{\Omega_G(d-1)}{\Omega_G(d)}\right)^3
-3\left(-\frac{\Omega_G(d-1)}{\Omega_G(d)}\right)
\frac{\Omega_G(d-2)}{\Omega_G(d)}
+3\left(-\frac{\Omega_G(d-3)}{\Omega_G(d)}\right)
&&\bigl(\because\ \text{三つの基本対称式を代入する}\bigr)\\
&=
-\frac{\Omega_G(d-1)^3}{\Omega_G(d)^3}
+\frac{3\Omega_G(d-1)\Omega_G(d-2)}{\Omega_G(d)^2}
-\frac{3\Omega_G(d-3)}{\Omega_G(d)}
&&\bigl(\because\ \text{商の積と }(-1)^3=-1\bigr)\\
&=
-\frac{\Omega_G(d-1)^3}{\Omega_G(d)^3}
+\frac{3\Omega_G(d)\Omega_G(d-1)\Omega_G(d-2)}{\Omega_G(d)^3}
-\frac{3\Omega_G(d)^2\Omega_G(d-3)}{\Omega_G(d)^3}
&&\bigl(\because\ \Omega_G(d)\ne0\text{ なので共通分母へ移す}\bigr)\\
&=
\frac{
  -\Omega_G(d-1)^3
  +3\Omega_G(d)\Omega_G(d-1)\Omega_G(d-2)
  -3\Omega_G(d)^2\Omega_G(d-3)
}{
  \Omega_G(d)^3
}
&&\bigl(\because\ \text{同じ分母をもつ三つの分数を加える}\bigr).
\end{aligned}`),
      paragraph([
        "右辺は有理数なので、Fisher 零点の三乗和は",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点、その三乗、有限積および有限和は代数的数、次数と多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_fourth_power_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点の四乗和と係数比" },
    labels: ["theorem_fisher_zero_fourth_power_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-fourth-power-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置き、",
        math(String.raw`d\ge4`),
        " と仮定する。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j^4
=
\frac{
  \Omega_G(d-1)^4
  -4\Omega_G(d)\Omega_G(d-1)^2\Omega_G(d-2)
  +2\Omega_G(d)^2\Omega_G(d-2)^2
  +4\Omega_G(d)^2\Omega_G(d-1)\Omega_G(d-3)
  -4\Omega_G(d)^3\Omega_G(d-4)
}{
  \Omega_G(d)^4
}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        "各",
        math(String.raw`r\in\{1,2,3,4\}`),
        "について代数的数",
        math(String.raw`p_r\in\overline{\mathbb Q}`),
        "を",
        math(String.raw`p_r:=\sum_{j=1}^{d}\alpha_j^r`),
        "と定める。また代数的数",
        math(String.raw`e_1,e_2,e_3,e_4,s_{3,1},s_{2,1,1}\in\overline{\mathbb Q}`),
        "を",
      ]),
      displayMath(String.raw`\begin{aligned}
e_r
&:=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\prod_{j\in I}\alpha_j
&&\bigl(r\in\{1,2,3,4\}\bigr),\\
s_{3,1}
&:=
\sum_{1\le i<j\le d}
\left(\alpha_i^3\alpha_j+\alpha_i\alpha_j^3\right),\\
s_{2,1,1}
&:=
\sum_{1\le i<j<k\le d}
\alpha_i\alpha_j\alpha_k
\left(\alpha_i+\alpha_j+\alpha_k\right)
\end{aligned}`),
      paragraph(["と定める。有限和の分配律により、"]),
      displayMath(String.raw`\begin{aligned}
e_1p_3
&=p_4+s_{3,1}
&&\bigl(\because\ \text{二つの添字が同じ場合と異なる場合へ分ける}\bigr),\\
e_2p_2
&=s_{3,1}+s_{2,1,1}
&&\bigl(\because\ \text{平方を取る添字が選択対に属する場合と属さない場合へ分ける}\bigr),\\
e_3p_1
&=s_{2,1,1}+4e_4
&&\bigl(\because\ \text{一つの添字が選択三つ組に属する場合と属さない場合へ分ける}\bigr).
\end{aligned}`),
      paragraph(["したがって代数的数の体で、"]),
      displayMath(String.raw`\begin{aligned}
p_4
&=e_1p_3-s_{3,1}
&&\bigl(\because\ \text{最初の有限和恒等式を移項する}\bigr)\\
&=e_1p_3-\left(e_2p_2-s_{2,1,1}\right)
&&\bigl(\because\ \text{二番目の有限和恒等式を }s_{3,1}\text{ について解いて代入する}\bigr)\\
&=e_1p_3-e_2p_2+s_{2,1,1}
&&\bigl(\because\ \text{分配律}\bigr)\\
&=e_1p_3-e_2p_2+\left(e_3p_1-4e_4\right)
&&\bigl(\because\ \text{三番目の有限和恒等式を }s_{2,1,1}\text{ について解いて代入する}\bigr)\\
&=e_1p_3-e_2p_2+e_3p_1-4e_4
&&\bigl(\because\ \text{括弧を外す}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を",
        math(String.raw`r=1,2,3,4`),
        " に適用し、",
        ref("theorem_fisher_zero_square_sum_coefficient_ratio"),
        " と",
        ref("theorem_fisher_zero_cube_sum_coefficient_ratio"),
        " を用いる。さらに",
        math(String.raw`B:=\Omega_G(d)`),
        " および各",
        math(String.raw`r\in\{1,2,3,4\}`),
        "について",
        math(String.raw`A_r:=\Omega_G(d-r)`),
        "と置くと、",
      ]),
      displayMath(String.raw`\begin{aligned}
e_r&=(-1)^r\frac{A_r}{B}&&\bigl(r\in\{1,2,3,4\}\bigr),\\
p_1&=-\frac{A_1}{B},\\
p_2&=\frac{A_1^2-2BA_2}{B^2},\\
p_3&=\frac{-A_1^3+3BA_1A_2-3B^2A_3}{B^3}.
\end{aligned}`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より",
        math(String.raw`B\in\mathbb N_{>0}`),
        " である。直前の係数比を四次 Newton 恒等式へ代入すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
p_4
&=
\left(-\frac{A_1}{B}\right)
\frac{-A_1^3+3BA_1A_2-3B^2A_3}{B^3}
-\frac{A_2}{B}\frac{A_1^2-2BA_2}{B^2}
+\left(-\frac{A_3}{B}\right)\left(-\frac{A_1}{B}\right)
-4\frac{A_4}{B}
&&\bigl(\because\ \text{直前の係数比を代入する}\bigr)\\
&=
\frac{A_1^4-3BA_1^2A_2+3B^2A_1A_3}{B^4}
+\frac{-A_1^2A_2+2BA_2^2}{B^3}
+\frac{A_1A_3}{B^2}
-\frac{4A_4}{B}
&&\bigl(\because\ \text{各積を展開する}\bigr)\\
&=
\frac{A_1^4-3BA_1^2A_2+3B^2A_1A_3}{B^4}
+\frac{-BA_1^2A_2+2B^2A_2^2}{B^4}
+\frac{B^2A_1A_3}{B^4}
-\frac{4B^3A_4}{B^4}
&&\bigl(\because\ B\ne0\text{ なので共通分母へ移す}\bigr)\\
&=
\frac{
  A_1^4
  -4BA_1^2A_2
  +2B^2A_2^2
  +4B^2A_1A_3
  -4B^3A_4
}{B^4}
&&\bigl(\because\ \text{同じ分母をもつ項を加えて同類項をまとめる}\bigr).
\end{aligned}`),
      paragraph([
        "右辺は有理数なので、Fisher 零点の四乗和は",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点、その四乗、有限積および有限和は代数的数、次数と多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点逆数族の基本対称式と係数比" },
    labels: ["theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/reciprocal-fisher-zero-elementary-symmetric-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を ",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、任意の ",
        math(String.raw`k\in\{0,\ldots,d\}`),
        " について、",
      ]),
      displayMath(String.raw`\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}\alpha_j^{-1}
=
(-1)^k\frac{\Omega_G(k)}{\Omega_G(0)}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`I=\varnothing`),
        " の項に現れる積は空積 ",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " とする。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fisher_zeros_nonzero"),
        " より、全ての ",
        math(String.raw`j\in\{1,\ldots,d\}`),
        " について ",
        math(String.raw`\alpha_j\ne0`),
        " であり、逆数 ",
        math(String.raw`\alpha_j^{-1}\in\overline{\mathbb Q}`),
        " が定まる。",
      ]),
      paragraph([
        "全頂点下向き配位 ",
        math(String.raw`\sigma_{\mathsf{down}}:V\to\mathsf{Spin}`),
        " を全ての ",
        math(String.raw`v\in V`),
        " について ",
        math(String.raw`\sigma_{\mathsf{down}}(v):=\mathsf{down}`),
        " と定める。",
        ref("def_spin_configuration_set"),
        " と ",
        ref("def_broken_edge_set"),
        " より ",
        math(String.raw`\sigma_{\mathsf{down}}\in\mathcal S_G`),
        " かつ ",
        math(String.raw`b_G(\sigma_{\mathsf{down}})=0`),
        " なので、",
        ref("def_broken_edge_multiplicity"),
        " より ",
        math(String.raw`\Omega_G(0)\in\mathbb N_{>0}`),
        " である。任意の ",
        math(String.raw`k\in\{0,\ldots,d\}`),
        " を取り、",
        math(String.raw`I\subseteq\{1,\ldots,d\}`),
        " かつ ",
        math(String.raw`|I|=k`),
        " とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j\in I}\alpha_j^{-1}
&=
\left(
  \prod_{j=1}^{d}\alpha_j
\right)^{-1}
\prod_{j\in\{1,\ldots,d\}\setminus I}\alpha_j
&&\bigl(\because\ \text{全ての }\alpha_j\text{ が非零であり、有限積を }I\text{ とその補集合へ分割する}\bigr).
\end{aligned}`),
      paragraph([
        "補集合写像 ",
        math(String.raw`I\mapsto\{1,\ldots,d\}\setminus I`),
        " は、元数 ",
        math(String.raw`k`),
        " の部分集合全体から元数 ",
        math(String.raw`d-k`),
        " の部分集合全体への全単射である。したがって、直前の等式を全ての ",
        math(String.raw`I`),
        " について加えると、",
      ]),
      displayMath(String.raw`\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}\alpha_j^{-1}
=
\frac{
  \displaystyle
  \sum_{\substack{J\subseteq\{1,\ldots,d\}\\|J|=d-k}}
  \prod_{j\in J}\alpha_j
}{
  \displaystyle
  \prod_{j=1}^{d}\alpha_j
}
\quad\bigl(\because\ \text{補集合写像は全単射である}\bigr).`),
      paragraph([
        ref("theorem_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を元数 ",
        math(String.raw`d-k`),
        " と元数 ",
        math(String.raw`d`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\substack{J\subseteq\{1,\ldots,d\}\\|J|=d-k}}
\prod_{j\in J}\alpha_j
&=
(-1)^{d-k}\frac{\Omega_G(k)}{\Omega_G(d)}
&&\bigl(\because\ \text{Fisher 零点の基本対称式と係数比}\bigr),\\
\prod_{j=1}^{d}\alpha_j
&=
(-1)^d\frac{\Omega_G(0)}{\Omega_G(d)}
&&\bigl(\because\ \text{Fisher 零点の基本対称式と係数比}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より ",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " である。直前の二等式を補集合による等式へ代入すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\prod_{j\in I}\alpha_j^{-1}
&=
\frac{
  \displaystyle
  (-1)^{d-k}\frac{\Omega_G(k)}{\Omega_G(d)}
}{
  \displaystyle
  (-1)^d\frac{\Omega_G(0)}{\Omega_G(d)}
}
&&\bigl(\because\ \text{二つの基本対称式の係数比を代入する}\bigr)\\
&=
(-1)^{d-k}\frac{\Omega_G(k)}{\Omega_G(d)}
\cdot
(-1)^d\frac{\Omega_G(d)}{\Omega_G(0)}
&&\bigl(\because\ (-1)^d\text{ は自身の逆元である}\bigr)\\
&=
(-1)^{2d-k}\frac{\Omega_G(k)}{\Omega_G(0)}
&&\bigl(\because\ \Omega_G(d)\ne0\text{ なので約分する}\bigr)\\
&=
(-1)^k\frac{\Omega_G(k)}{\Omega_G(0)}
&&\bigl(\because\ 2d-k\text{ と }k\text{ の差 }2(d-k)\text{ は偶数である}\bigr).
\end{aligned}`),
      paragraph([
        "右辺は有理数なので、逆数族の基本対称式は ",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点、その逆数、有限積は代数的数、次数、添字部分集合の元数、多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_reciprocal_fisher_zero_power_sum_newton_recurrence",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点逆数冪和の Newton 漸化式と係数比" },
    labels: ["theorem_reciprocal_fisher_zero_power_sum_newton_recurrence"],
    habitat: "Qbar",
    verification: ["sagemath/check/reciprocal-fisher-zero-power-sum-newton-recurrence"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を ",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。各 ",
        math(String.raw`s\in\mathbb N_{>0}`),
        " について ",
        math(String.raw`\widehat p_s:=\sum_{j=1}^{d}\alpha_j^{-s}\in\overline{\mathbb Q}`),
        " と定める。このとき、任意の ",
        math(String.raw`k\in\mathbb N_{>0}`),
        " について、次の漸化式が成り立つ。",
      ]),
      displayMath(String.raw`\widehat p_k
=
\begin{cases}
-\frac{
  \displaystyle
  \sum_{r=1}^{k-1}\Omega_G(r)\widehat p_{k-r}
  +k\Omega_G(k)
}{
  \Omega_G(0)
},
&1\le k\le d,\\[8pt]
-\frac{
  \displaystyle
  \sum_{r=1}^{d}\Omega_G(r)\widehat p_{k-r}
}{
  \Omega_G(0)
},
&k>d
\end{cases}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`k=1`),
        " のとき、右辺の和は空和 ",
        math(String.raw`0\in\overline{\mathbb Q}`),
        " とする。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ",
        math(String.raw`d=0`),
        " の場合、Fisher 零点の重複度込み族は空族なので、全ての ",
        math(String.raw`k\in\mathbb N_{>0}`),
        " について ",
        math(String.raw`\widehat p_k=0`),
        " である。主張の第二の場合の右辺も空和により ",
        math(String.raw`0`),
        " である。以下では ",
        math(String.raw`d\ge1`),
        " とする。",
      ]),
      paragraph([
        ref("theorem_fisher_zeros_nonzero"),
        " より、全ての ",
        math(String.raw`j\in\{1,\ldots,d\}`),
        " について ",
        math(String.raw`\beta_j:=\alpha_j^{-1}\in\overline{\mathbb Q}`),
        " が定まる。任意の ",
        math(String.raw`k\in\{1,\ldots,d\}`),
        " を取る。まず ",
        math(String.raw`k=1`),
        " の場合、",
        ref("theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を一次へ適用すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat p_1
&=\widehat e_1
&&\bigl(\because\ \widehat p_1\text{ と逆数族の一次基本対称式の定義}\bigr)\\
&=-\frac{\Omega_G(1)}{\Omega_G(0)}
&&\bigl(\because\ \text{Fisher 零点逆数族の一次基本対称式と係数比}\bigr).
\end{aligned}`),
      paragraph([
        "これは空和を用いた主張の第一の場合に等しい。以下では ",
        math(String.raw`2\le k\le d`),
        " とする。各 ",
        math(String.raw`r\in\{1,\ldots,k\}`),
        " について代数的数 ",
        math(String.raw`\widehat e_r,\widehat h_r\in\overline{\mathbb Q}`),
        " を",
      ]),
      displayMath(String.raw`\widehat e_r
:=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\prod_{i\in I}\beta_i,
\qquad
\widehat h_r
:=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\beta_i
\right)
\left(
  \sum_{j\in I}\beta_j^{k-r}
\right)`),
      paragraph(["と定める。各 ", math(String.raw`r\in\{1,\ldots,k-1\}`), " について有限和の分配律により、"]),
      displayMath(String.raw`\begin{aligned}
\widehat e_r\widehat p_{k-r}
&=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\beta_i
\right)
\left(
  \sum_{j=1}^{d}\beta_j^{k-r}
\right)
&&\bigl(\because\ \text{定義を代入する}\bigr)\\
&=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\beta_i
\right)
\left(
  \sum_{j\in I}\beta_j^{k-r}
\right)
+
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\beta_i
\right)
\left(
  \sum_{\substack{1\le j\le d\\j\notin I}}\beta_j^{k-r}
\right)
&&\bigl(\because\ \{1,\ldots,d\}=I\sqcup(\{1,\ldots,d\}\setminus I)\bigr)\\
&=\widehat h_r+\widehat h_{r+1}
&&\bigl(\because\ J=I\cup\{j\}\text{ と置いて第二項を }|J|=r+1\text{ の和へ移す}\bigr).
\end{aligned}`),
      paragraph(["直前の等式へ ", math(String.raw`(-1)^{r-1}`), " を掛けて ", math(String.raw`r=1,\ldots,k-1`), " を足すと、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{r=1}^{k-1}(-1)^{r-1}\widehat e_r\widehat p_{k-r}
&=
\sum_{r=1}^{k-1}(-1)^{r-1}(\widehat h_r+\widehat h_{r+1})
&&\bigl(\because\ \widehat e_r\widehat p_{k-r}=\widehat h_r+\widehat h_{r+1}\bigr)\\
&=\widehat h_1+(-1)^{k-2}\widehat h_k
&&\bigl(\because\ \widehat h_2,\ldots,\widehat h_{k-1}\text{ の係数が }(-1)^{r-1}+(-1)^r=0\bigr).
\end{aligned}`),
      paragraph(["定義から、"]),
      displayMath(String.raw`\begin{aligned}
\widehat h_1
&=\sum_{j=1}^{d}\beta_j\beta_j^{k-1}
&&\bigl(\because\ |I|=1\bigr)\\
&=\widehat p_k
&&\bigl(\because\ \beta_j\beta_j^{k-1}=\beta_j^k\bigr),\\
\widehat h_k
&=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=k}}
\left(
  \prod_{i\in I}\beta_i
\right)
\sum_{j\in I}1
&&\bigl(\because\ \beta_j^{k-k}=1\bigr)\\
&=k\widehat e_k
&&\bigl(\because\ |I|=k\bigr).
\end{aligned}`),
      paragraph(["したがって代数的数の体で、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{r=1}^{k-1}(-1)^{r-1}\widehat e_r\widehat p_{k-r}
&=\widehat p_k+(-1)^{k-2}k\widehat e_k
&&\bigl(\because\ \widehat h_1=\widehat p_k\text{ および }\widehat h_k=k\widehat e_k\bigr)\\
\widehat p_k
&=
\sum_{r=1}^{k-1}(-1)^{r-1}\widehat e_r\widehat p_{k-r}
+(-1)^{k-1}k\widehat e_k
&&\bigl(\because\ \text{移項する}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を ",
        math(String.raw`r=1,\ldots,k`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\widehat e_r=(-1)^r\frac{\Omega_G(r)}{\Omega_G(0)}
\qquad(r\in\{1,\ldots,k\}).`),
      paragraph([
        "全頂点下向き配位 ",
        math(String.raw`\sigma_{\mathsf{down}}:V\to\mathsf{Spin}`),
        " を全ての ",
        math(String.raw`v\in V`),
        " について ",
        math(String.raw`\sigma_{\mathsf{down}}(v):=\mathsf{down}`),
        " と定める。",
        ref("def_spin_configuration_set"),
        " と ",
        ref("def_broken_edge_set"),
        " より ",
        math(String.raw`\sigma_{\mathsf{down}}\in\mathcal S_G`),
        " かつ ",
        math(String.raw`b_G(\sigma_{\mathsf{down}})=0`),
        " なので、",
        ref("def_broken_edge_multiplicity"),
        " より ",
        math(String.raw`\Omega_G(0)\in\mathbb N_{>0}`),
        " である。直前の係数比を Newton 漸化式へ代入すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat p_k
&=
\sum_{r=1}^{k-1}
(-1)^{r-1}
(-1)^r
\frac{\Omega_G(r)}{\Omega_G(0)}\widehat p_{k-r}
+
(-1)^{k-1}k(-1)^k
\frac{\Omega_G(k)}{\Omega_G(0)}
&&\bigl(\because\ \text{逆数族の基本対称式の係数比を代入する}\bigr)\\
&=
-\sum_{r=1}^{k-1}
\frac{\Omega_G(r)}{\Omega_G(0)}\widehat p_{k-r}
-
k\frac{\Omega_G(k)}{\Omega_G(0)}
&&\bigl(\because\ (-1)^{2r-1}=(-1)^{2k-1}=-1\bigr)\\
&=
-\frac{
  \displaystyle
  \sum_{r=1}^{k-1}\Omega_G(r)\widehat p_{k-r}
  +k\Omega_G(k)
}{
  \Omega_G(0)
}
&&\bigl(\because\ \Omega_G(0)\ne0\text{ なので共通分母へ移す}\bigr).
\end{aligned}`),
      paragraph([
        "以上で ",
        math(String.raw`1\le k\le d`),
        " の場合を得た。次に任意の ",
        math(String.raw`q\in\mathbb N_{>0}`),
        " で ",
        math(String.raw`q>d`),
        " を満たすものを取る。各 ",
        math(String.raw`r\in\{1,\ldots,d\}`),
        " について ",
        math(String.raw`E_r,H_r^{(q)}\in\overline{\mathbb Q}`),
        " を",
      ]),
      displayMath(String.raw`E_r
:=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\prod_{i\in I}\beta_i,
\qquad
H_r^{(q)}
:=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\beta_i
\right)
\left(
  \sum_{j\in I}\beta_j^{q-r}
\right),
\qquad
H_{d+1}^{(q)}:=0`),
      paragraph(["と定める。各 ", math(String.raw`r\in\{1,\ldots,d\}`), " について有限和の分配律により、"]),
      displayMath(String.raw`\begin{aligned}
E_r\widehat p_{q-r}
&=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\beta_i
\right)
\left(
  \sum_{j=1}^{d}\beta_j^{q-r}
\right)
&&\bigl(\because\ \text{定義を代入する}\bigr)\\
&=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\beta_i
\right)
\left(
  \sum_{j\in I}\beta_j^{q-r}
\right)
+
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\left(
  \prod_{i\in I}\beta_i
\right)
\left(
  \sum_{\substack{1\le j\le d\\j\notin I}}\beta_j^{q-r}
\right)
&&\bigl(\because\ \{1,\ldots,d\}=I\sqcup(\{1,\ldots,d\}\setminus I)\bigr)\\
&=H_r^{(q)}+H_{r+1}^{(q)}
&&\bigl(\because\ J=I\cup\{j\}\text{ と置いて第二項を }|J|=r+1\text{ の和へ移す}\bigr).
\end{aligned}`),
      paragraph(["直前の等式へ ", math(String.raw`(-1)^{r-1}`), " を掛けて ", math(String.raw`r=1,\ldots,d`), " を足すと、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{r=1}^{d}(-1)^{r-1}E_r\widehat p_{q-r}
&=
\sum_{r=1}^{d}(-1)^{r-1}\left(H_r^{(q)}+H_{r+1}^{(q)}\right)
&&\bigl(\because\ E_r\widehat p_{q-r}=H_r^{(q)}+H_{r+1}^{(q)}\bigr)\\
&=H_1^{(q)}
&&\bigl(\because\ H_2^{(q)},\ldots,H_d^{(q)}\text{ が相殺し }H_{d+1}^{(q)}=0\bigr)\\
&=\widehat p_q
&&\bigl(\because\ H_1^{(q)}=\sum_{j=1}^{d}\beta_j\beta_j^{q-1}=\widehat p_q\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を ",
        math(String.raw`r=1,\ldots,d`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat p_q
&=
\sum_{r=1}^{d}
(-1)^{r-1}
(-1)^r
\frac{\Omega_G(r)}{\Omega_G(0)}\widehat p_{q-r}
&&\bigl(\because\ E_r=(-1)^r\Omega_G(r)/\Omega_G(0)\bigr)\\
&=
-\sum_{r=1}^{d}
\frac{\Omega_G(r)}{\Omega_G(0)}\widehat p_{q-r}
&&\bigl(\because\ (-1)^{2r-1}=-1\bigr)\\
&=
-\frac{
  \displaystyle
  \sum_{r=1}^{d}\Omega_G(r)\widehat p_{q-r}
}{
  \Omega_G(0)
}
&&\bigl(\because\ \Omega_G(0)\ne0\text{ なので共通分母へ移す}\bigr).
\end{aligned}`),
      paragraph([
        "第一の場合を ",
        math(String.raw`k=1,\ldots,d`),
        " の順に用い、続いて第二の場合を ",
        math(String.raw`k=d+1,d+2,\ldots`),
        " の順に用いると、自然数と有理数の四則演算だけで全ての ",
        math(String.raw`\widehat p_k`),
        " が有理数として定まる。したがって ",
        math(String.raw`\widehat p_k\in\mathbb Q\subset\overline{\mathbb Q}`),
        " である。零点、その逆数と冪、有限積および有限和は代数的数、次数、冪指数、添字部分集合の元数、多重度は自然数、係数比と逆数冪和は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点逆数の二乗和と係数比" },
    labels: ["theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/reciprocal-fisher-zero-square-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置き、",
        math(String.raw`d\ge2`),
        " と仮定する。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j^{-2}
=
\frac{
  \Omega_G(1)^2-2\Omega_G(0)\Omega_G(2)
}{
  \Omega_G(0)^2
}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        ref("theorem_fisher_zeros_nonzero"),
        " より、全ての",
        math(String.raw`j\in\{1,\ldots,d\}`),
        " について",
        math(String.raw`\alpha_j\ne0`),
        " であり、逆数",
        math(String.raw`\alpha_j^{-1}\in\overline{\mathbb Q}`),
        " が定まる。有限和の分配律より、",
      ]),
      displayMath(String.raw`\left(\sum_{j=1}^{d}\alpha_j^{-1}\right)^2
=
\sum_{j=1}^{d}\alpha_j^{-2}
+
2\sum_{1\le i<j\le d}\alpha_i^{-1}\alpha_j^{-1}.`),
      paragraph([
        ref("theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を",
        math(String.raw`k=1`),
        " と",
        math(String.raw`k=2`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j^{-1}
=
-\frac{\Omega_G(1)}{\Omega_G(0)},
\qquad
\sum_{1\le i<j\le d}\alpha_i^{-1}\alpha_j^{-1}
=
\frac{\Omega_G(2)}{\Omega_G(0)}.`),
      paragraph([
        "全頂点下向き配位は",
        ref("def_spin_configuration_set"),
        " に属し、",
        ref("def_broken_edge_set"),
        " の破れ辺数零をもつので、",
        ref("def_broken_edge_multiplicity"),
        " より",
        math(String.raw`\Omega_G(0)\in\mathbb N_{>0}`),
        " である。したがって代数的数の体で、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{d}\alpha_j^{-2}
&=
\left(\sum_{j=1}^{d}\alpha_j^{-1}\right)^2
-
2\sum_{1\le i<j\le d}\alpha_i^{-1}\alpha_j^{-1}
&&\bigl(\because\ \text{最初の有限和恒等式を移項する}\bigr)\\
&=
\left(-\frac{\Omega_G(1)}{\Omega_G(0)}\right)^2
-
2\frac{\Omega_G(2)}{\Omega_G(0)}
&&\bigl(\because\ \text{直前の二つの逆数族基本対称式を代入する}\bigr)\\
&=
\frac{\Omega_G(1)^2}{\Omega_G(0)^2}
-
2\frac{\Omega_G(2)}{\Omega_G(0)}
&&\bigl(\because\ \text{商の平方と }(-1)^2=1\bigr)\\
&=
\frac{\Omega_G(1)^2}{\Omega_G(0)^2}
-
\frac{2\Omega_G(0)\Omega_G(2)}{\Omega_G(0)^2}
&&\bigl(\because\ \Omega_G(0)/\Omega_G(0)=1\bigr)\\
&=
\frac{
  \Omega_G(1)^2-2\Omega_G(0)\Omega_G(2)
}{
  \Omega_G(0)^2
}
&&\bigl(\because\ \text{同じ分母をもつ二つの分数を引く}\bigr).
\end{aligned}`),
      paragraph([
        "右辺は有理数なので、Fisher 零点逆数の二乗和は",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点、その逆数と二乗および有限和は代数的数、次数と多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点逆数の三乗和と係数比" },
    labels: ["theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置き、",
        math(String.raw`d\ge3`),
        " と仮定する。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j^{-3}
=
\frac{
  -\Omega_G(1)^3
  +3\Omega_G(0)\Omega_G(1)\Omega_G(2)
  -3\Omega_G(0)^2\Omega_G(3)
}{
  \Omega_G(0)^3
}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        ref("theorem_fisher_zeros_nonzero"),
        " より、全ての",
        math(String.raw`j\in\{1,\ldots,d\}`),
        " について",
        math(String.raw`\alpha_j\ne0`),
        " であり、逆数",
        math(String.raw`\alpha_j^{-1}\in\overline{\mathbb Q}`),
        " が定まる。代数的数",
        math(String.raw`\widehat e_1,\widehat e_2,\widehat e_3,\widehat s_{2,1}\in\overline{\mathbb Q}`),
        " を",
      ]),
      displayMath(String.raw`\widehat e_1:=\sum_{j=1}^{d}\alpha_j^{-1},
\qquad
\widehat e_2:=\sum_{1\le i<j\le d}\alpha_i^{-1}\alpha_j^{-1},
\qquad
\widehat e_3:=\sum_{1\le i<j<k\le d}\alpha_i^{-1}\alpha_j^{-1}\alpha_k^{-1},
\qquad
\widehat s_{2,1}:=\sum_{\substack{1\le i,j\le d\\i\ne j}}\alpha_i^{-2}\alpha_j^{-1}`),
      paragraph(["と定める。有限和の分配律により、"]),
      displayMath(String.raw`\begin{aligned}
\widehat e_1^3
&=
\sum_{j=1}^{d}\alpha_j^{-3}+3\widehat s_{2,1}+6\widehat e_3
&&\bigl(\because\ \text{三つの添字が全て同じ、二つだけ同じ、全て異なる場合へ分ける}\bigr),\\
\widehat e_1\widehat e_2
&=
\widehat s_{2,1}+3\widehat e_3
&&\bigl(\because\ \text{一つの添字が選択対に属する場合と属さない場合へ分ける}\bigr).
\end{aligned}`),
      paragraph(["したがって代数的数の体で、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{d}\alpha_j^{-3}
&=
\widehat e_1^3-3\widehat s_{2,1}-6\widehat e_3
&&\bigl(\because\ \text{最初の有限和恒等式を移項する}\bigr)\\
&=
\widehat e_1^3-3(\widehat e_1\widehat e_2-3\widehat e_3)-6\widehat e_3
&&\bigl(\because\ \text{二番目の有限和恒等式を }\widehat s_{2,1}\text{ について解いて代入する}\bigr)\\
&=
\widehat e_1^3-3\widehat e_1\widehat e_2+9\widehat e_3-6\widehat e_3
&&\bigl(\because\ \text{分配律}\bigr)\\
&=
\widehat e_1^3-3\widehat e_1\widehat e_2+3\widehat e_3
&&\bigl(\because\ 9\widehat e_3-6\widehat e_3=3\widehat e_3\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を",
        math(String.raw`k=1,2,3`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\widehat e_1=-\frac{\Omega_G(1)}{\Omega_G(0)},
\qquad
\widehat e_2=\frac{\Omega_G(2)}{\Omega_G(0)},
\qquad
\widehat e_3=-\frac{\Omega_G(3)}{\Omega_G(0)}.`),
      paragraph([
        "全頂点下向き配位は",
        ref("def_spin_configuration_set"),
        " に属し、",
        ref("def_broken_edge_set"),
        " の破れ辺数零をもつので、",
        ref("def_broken_edge_multiplicity"),
        " より",
        math(String.raw`\Omega_G(0)\in\mathbb N_{>0}`),
        " である。直前の三つの逆数族基本対称式を代入すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{d}\alpha_j^{-3}
&=
\left(-\frac{\Omega_G(1)}{\Omega_G(0)}\right)^3
-3\left(-\frac{\Omega_G(1)}{\Omega_G(0)}\right)
\frac{\Omega_G(2)}{\Omega_G(0)}
+3\left(-\frac{\Omega_G(3)}{\Omega_G(0)}\right)
&&\bigl(\because\ \text{三つの逆数族基本対称式を代入する}\bigr)\\
&=
-\frac{\Omega_G(1)^3}{\Omega_G(0)^3}
+\frac{3\Omega_G(1)\Omega_G(2)}{\Omega_G(0)^2}
-\frac{3\Omega_G(3)}{\Omega_G(0)}
&&\bigl(\because\ \text{商の積と }(-1)^3=-1\bigr)\\
&=
-\frac{\Omega_G(1)^3}{\Omega_G(0)^3}
+\frac{3\Omega_G(0)\Omega_G(1)\Omega_G(2)}{\Omega_G(0)^3}
-\frac{3\Omega_G(0)^2\Omega_G(3)}{\Omega_G(0)^3}
&&\bigl(\because\ \Omega_G(0)\ne0\text{ なので共通分母へ移す}\bigr)\\
&=
\frac{
  -\Omega_G(1)^3
  +3\Omega_G(0)\Omega_G(1)\Omega_G(2)
  -3\Omega_G(0)^2\Omega_G(3)
}{
  \Omega_G(0)^3
}
&&\bigl(\because\ \text{同じ分母をもつ三つの分数を加える}\bigr).
\end{aligned}`),
      paragraph([
        "右辺は有理数なので、Fisher 零点逆数の三乗和は",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点、その逆数と三乗、有限積および有限和は代数的数、次数と多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点逆数の四乗和と係数比" },
    labels: ["theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/reciprocal-fisher-zero-fourth-power-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置き、",
        math(String.raw`d\ge4`),
        " と仮定する。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\alpha_j^{-4}
=
\frac{
  \Omega_G(1)^4
  -4\Omega_G(0)\Omega_G(1)^2\Omega_G(2)
  +2\Omega_G(0)^2\Omega_G(2)^2
  +4\Omega_G(0)^2\Omega_G(1)\Omega_G(3)
  -4\Omega_G(0)^3\Omega_G(4)
}{
  \Omega_G(0)^4
}
\in\mathbb Q
\subset\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        ref("theorem_fisher_zeros_nonzero"),
        " より、全ての",
        math(String.raw`j\in\{1,\ldots,d\}`),
        " について",
        math(String.raw`\beta_j:=\alpha_j^{-1}\in\overline{\mathbb Q}`),
        " が定まる。各",
        math(String.raw`r\in\{1,2,3,4\}`),
        "について代数的数",
        math(String.raw`\widehat p_r:=\sum_{j=1}^{d}\beta_j^r`),
        "と定める。また代数的数",
        math(String.raw`\widehat e_1,\widehat e_2,\widehat e_3,\widehat e_4,\widehat s_{3,1},\widehat s_{2,1,1}\in\overline{\mathbb Q}`),
        "を",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat e_r
&:=
\sum_{\substack{I\subseteq\{1,\ldots,d\}\\|I|=r}}
\prod_{j\in I}\beta_j
&&\bigl(r\in\{1,2,3,4\}\bigr),\\
\widehat s_{3,1}
&:=
\sum_{1\le i<j\le d}
\left(\beta_i^3\beta_j+\beta_i\beta_j^3\right),\\
\widehat s_{2,1,1}
&:=
\sum_{1\le i<j<k\le d}
\beta_i\beta_j\beta_k
\left(\beta_i+\beta_j+\beta_k\right)
\end{aligned}`),
      paragraph(["と定める。有限和の分配律により、"]),
      displayMath(String.raw`\begin{aligned}
\widehat e_1\widehat p_3
&=\widehat p_4+\widehat s_{3,1}
&&\bigl(\because\ \text{二つの添字が同じ場合と異なる場合へ分ける}\bigr),\\
\widehat e_2\widehat p_2
&=\widehat s_{3,1}+\widehat s_{2,1,1}
&&\bigl(\because\ \text{平方を取る添字が選択対に属する場合と属さない場合へ分ける}\bigr),\\
\widehat e_3\widehat p_1
&=\widehat s_{2,1,1}+4\widehat e_4
&&\bigl(\because\ \text{一つの添字が選択三つ組に属する場合と属さない場合へ分ける}\bigr).
\end{aligned}`),
      paragraph(["したがって代数的数の体で、"]),
      displayMath(String.raw`\begin{aligned}
\widehat p_4
&=\widehat e_1\widehat p_3-\widehat s_{3,1}
&&\bigl(\because\ \text{最初の有限和恒等式を移項する}\bigr)\\
&=\widehat e_1\widehat p_3-\left(\widehat e_2\widehat p_2-\widehat s_{2,1,1}\right)
&&\bigl(\because\ \text{二番目の有限和恒等式を }\widehat s_{3,1}\text{ について解いて代入する}\bigr)\\
&=\widehat e_1\widehat p_3-\widehat e_2\widehat p_2+\widehat s_{2,1,1}
&&\bigl(\because\ \text{分配律}\bigr)\\
&=\widehat e_1\widehat p_3-\widehat e_2\widehat p_2+\left(\widehat e_3\widehat p_1-4\widehat e_4\right)
&&\bigl(\because\ \text{三番目の有限和恒等式を }\widehat s_{2,1,1}\text{ について解いて代入する}\bigr)\\
&=\widehat e_1\widehat p_3-\widehat e_2\widehat p_2+\widehat e_3\widehat p_1-4\widehat e_4
&&\bigl(\because\ \text{括弧を外す}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_reciprocal_fisher_zero_elementary_symmetric_coefficient_ratio"),
        " を",
        math(String.raw`r=1,2,3,4`),
        " に適用し、",
        ref("theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio"),
        " と",
        ref("theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio"),
        " を用いる。さらに",
        math(String.raw`B:=\Omega_G(0)`),
        " および各",
        math(String.raw`r\in\{1,2,3,4\}`),
        "について",
        math(String.raw`A_r:=\Omega_G(r)`),
        "と置くと、",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat e_r&=(-1)^r\frac{A_r}{B}&&\bigl(r\in\{1,2,3,4\}\bigr),\\
\widehat p_1&=-\frac{A_1}{B},\\
\widehat p_2&=\frac{A_1^2-2BA_2}{B^2},\\
\widehat p_3&=\frac{-A_1^3+3BA_1A_2-3B^2A_3}{B^3}.
\end{aligned}`),
      paragraph([
        "全頂点下向き配位は",
        ref("def_spin_configuration_set"),
        " に属し、",
        ref("def_broken_edge_set"),
        " の破れ辺数零をもつので、",
        ref("def_broken_edge_multiplicity"),
        " より",
        math(String.raw`B\in\mathbb N_{>0}`),
        " である。直前の係数比を四次 Newton 恒等式へ代入すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat p_4
&=
\left(-\frac{A_1}{B}\right)
\frac{-A_1^3+3BA_1A_2-3B^2A_3}{B^3}
-\frac{A_2}{B}\frac{A_1^2-2BA_2}{B^2}
+\left(-\frac{A_3}{B}\right)\left(-\frac{A_1}{B}\right)
-4\frac{A_4}{B}
&&\bigl(\because\ \text{直前の係数比を代入する}\bigr)\\
&=
\frac{A_1^4-3BA_1^2A_2+3B^2A_1A_3}{B^4}
+\frac{-A_1^2A_2+2BA_2^2}{B^3}
+\frac{A_1A_3}{B^2}
-\frac{4A_4}{B}
&&\bigl(\because\ \text{各積を展開する}\bigr)\\
&=
\frac{A_1^4-3BA_1^2A_2+3B^2A_1A_3}{B^4}
+\frac{-BA_1^2A_2+2B^2A_2^2}{B^4}
+\frac{B^2A_1A_3}{B^4}
-\frac{4B^3A_4}{B^4}
&&\bigl(\because\ B\ne0\text{ なので共通分母へ移す}\bigr)\\
&=
\frac{
  A_1^4
  -4BA_1^2A_2
  +2B^2A_2^2
  +4B^2A_1A_3
  -4B^3A_4
}{B^4}
&&\bigl(\because\ \text{同じ分母をもつ項を加えて同類項をまとめる}\bigr).
\end{aligned}`),
      paragraph([
        "右辺は有理数なので、Fisher 零点逆数の四乗和は",
        math(String.raw`\mathbb Q\subset\overline{\mathbb Q}`),
        " に属する。零点、その逆数と四乗、有限積および有限和は代数的数、次数と多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_coefficient_symmetry",
    kind: "theorem",
    title: { text: "全ての辺を横切る頂点二分割と係数対称性" },
    labels: ["theorem_full_cut_coefficient_symmetry"],
    habitat: "N",
    verification: ["sagemath/check/full-cut-coefficient-symmetry"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。すなわち、全ての ",
        math(String.raw`e\in E`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
&\partial_G(e,\mathsf{source})\in A,\;
\partial_G(e,\mathsf{target})\notin A,\\
&\text{または }\partial_G(e,\mathsf{source})\notin A,\;
\partial_G(e,\mathsf{target})\in A
\end{aligned}`),
      paragraph(["が成り立つ。このとき、全ての ", math(String.raw`m\in\{0,1,\ldots,|E|\}`), " について"]),
      displayMath(String.raw`\Omega_G(m)=\Omega_G(|E|-m)\in\mathbb N.`),
    ],
    proof: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\mathcal S_G`),
        " に対し、頂点部分集合 ",
        math(String.raw`A`),
        " 上だけスピンを反転する写像 ",
        math(String.raw`T_A:\mathcal S_G\to\mathcal S_G`),
        " を",
      ]),
      displayMath(String.raw`T_A(\sigma)(v):=
\begin{cases}
  \nu(\sigma(v)) & (v\in A),\\
  \sigma(v) & (v\notin A)
\end{cases}
\qquad(v\in V)`),
      paragraph([
        "で定める。",
        ref("def_spin_label_reversal"),
        " より任意の ",
        math(String.raw`a\in\mathsf{Spin}`),
        " に対して ",
        math(String.raw`\nu(\nu(a))=a`),
        " なので、任意の ",
        math(String.raw`v\in V`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T_A(T_A(\sigma))(v)
&=\nu(T_A(\sigma)(v))
&&\bigl(\because\ v\in A\text{ と }T_A\text{ の定義}\bigr)\\
&=\nu(\nu(\sigma(v)))
&&\bigl(\because\ v\in A\text{ と }T_A\text{ の定義}\bigr)\\
&=\sigma(v)
&&\bigl(\because\ \nu(\nu(a))=a\bigr)
\qquad(v\in A),\\[4pt]
T_A(T_A(\sigma))(v)
&=T_A(\sigma)(v)
&&\bigl(\because\ v\notin A\text{ と }T_A\text{ の定義}\bigr)\\
&=\sigma(v)
&&\bigl(\because\ v\notin A\text{ と }T_A\text{ の定義}\bigr)
\qquad(v\notin A).
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`T_A`),
        " は有限集合 ",
        math(String.raw`\mathcal S_G`),
        " 上の対合であり、全単射である。仮定より任意の ",
        math(String.raw`e\in E`),
        " の二端点のうちちょうど一方だけでスピンが反転する。",
        ref("def_broken_edge_set"),
        " とスピンラベルが二元であることより、",
      ]),
      displayMath(String.raw`\begin{aligned}
e\in B_G(T_A(\sigma))
&\iff e\notin B_G(\sigma)
&&\bigl(\because\ e\text{ の二端点のうちちょうど一方だけでスピンを反転する}\bigr),\\
B_G(T_A(\sigma))
&=E\setminus B_G(\sigma)
&&\bigl(\because\ E\text{ の全ての元について所属が同値}\bigr),\\
b_G(T_A(\sigma))
&=|E|-b_G(\sigma)
&&\bigl(\because\ \text{有限集合の補集合の元数}\bigr).
\end{aligned}`),
      paragraph([
        "各 ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " に対し、",
        math(String.raw`T_A`),
        " は有限集合 ",
        math(String.raw`\{\sigma\in\mathcal S_G\mid b_G(\sigma)=m\}`),
        " から有限集合 ",
        math(String.raw`\{\sigma\in\mathcal S_G\mid b_G(\sigma)=|E|-m\}`),
        " への全単射を与える。",
        ref("def_broken_edge_multiplicity"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(m)
&=\left|\{\sigma\in\mathcal S_G\mid b_G(\sigma)=m\}\right|
&&\bigl(\because\ \text{破れ辺数の多重度の定義}\bigr)\\
&=\left|\{\sigma\in\mathcal S_G\mid b_G(\sigma)=|E|-m\}\right|
&&\bigl(\because\ T_A\text{ が二つの有限集合の間の全単射}\bigr)\\
&=\Omega_G(|E|-m)
&&\bigl(\because\ \text{破れ辺数の多重度の定義}\bigr).
\end{aligned}`),
      paragraph([
        "全ての集合は有限であり、多重度と辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_coefficient_symmetry_characterizes_full_cut",
    kind: "theorem",
    title: { text: "係数対称性による全辺二分割の特徴付け" },
    labels: ["theorem_coefficient_symmetry_characterizes_full_cut"],
    habitat: "finite",
    verification: ["sagemath/check/coefficient-symmetry-full-cut-characterization"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、次の二条件は同値である。",
      ]),
      paragraph([
        "ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての ",
        math(String.raw`e\in E`),
        " について二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属する。",
      ]),
      paragraph([
        "全ての ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " について",
      ]),
      displayMath(String.raw`\Omega_G(m)=\Omega_G(|E|-m)\in\mathbb N.`),
    ],
    proof: [
      paragraph([
        "全ての辺の二端点のうちちょうど一方だけを含む頂点部分集合が存在すると仮定する。",
        ref("theorem_full_cut_coefficient_symmetry"),
        " より、全ての ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " について係数対称性が成り立つ。",
      ]),
      paragraph([
        "逆に、全ての ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " について係数対称性が成り立つと仮定する。配位 ",
        math(String.raw`\sigma_{\mathsf{down}}:V\to\mathsf{Spin}`),
        " を",
      ]),
      displayMath(String.raw`\sigma_{\mathsf{down}}(v):=\mathsf{down}
\qquad(v\in V)`),
      paragraph([
        "で定める。",
        ref("def_spin_configuration_set"),
        " より ",
        math(String.raw`\sigma_{\mathsf{down}}\in\mathcal S_G`),
        " である。",
        ref("def_broken_edge_set"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
B_G(\sigma_{\mathsf{down}})
&=\varnothing
&&\bigl(\because\ \text{全頂点のスピンラベルが }\mathsf{down}\text{ で等しい}\bigr)\\
b_G(\sigma_{\mathsf{down}})
&=0
&&\bigl(\because\ |\varnothing|=0\bigr).
\end{aligned}`),
      paragraph([ref("def_broken_edge_multiplicity"), " より"]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(0)
&=\left|\left\{\sigma\in\mathcal S_G\ \middle|\ b_G(\sigma)=0\right\}\right|
&&\bigl(\because\ \text{破れ辺数の多重度の定義}\bigr)\\
&\ge 1
&&\bigl(\because\ \sigma_{\mathsf{down}}\text{ がこの有限集合に属する}\bigr).
\end{aligned}`),
      paragraph(["仮定した係数対称性へ ", math(String.raw`m=0`), " を適用すると"]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(|E|)
&=\Omega_G(0)
&&\bigl(\because\ \text{係数対称性の仮定を }m=0\text{ に適用}\bigr)\\
&\ge 1
&&\bigl(\because\ \Omega_G(0)\ge 1\bigr).
\end{aligned}`),
      paragraph([
        ref("def_broken_edge_multiplicity"),
        " より、ある配位 ",
        math(String.raw`\sigma_*\in\mathcal S_G`),
        " が存在して ",
        math(String.raw`b_G(\sigma_*)=|E|`),
        " である。",
        ref("def_broken_edge_set"),
        " より ",
        math(String.raw`B_G(\sigma_*)\subseteq E`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
|B_G(\sigma_*)|
&=|E|
&&\bigl(\because\ b_G(\sigma_*)=|E|\text{ と破れ辺数の定義}\bigr)\\
B_G(\sigma_*)
&=E
&&\bigl(\because\ B_G(\sigma_*)\subseteq E\text{ かつ二つの有限集合の元数が等しい}\bigr).
\end{aligned}`),
      paragraph([
        "頂点部分集合 ",
        math(String.raw`A_*\subseteq V`),
        " を",
      ]),
      displayMath(String.raw`A_*:=\{v\in V\mid \sigma_*(v)=\mathsf{up}\}`),
      paragraph([
        "で定める。任意の ",
        math(String.raw`e\in E`),
        " に対し、直前の集合等式と ",
        ref("def_broken_edge_set"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
e
&\in B_G(\sigma_*)
&&\bigl(\because\ B_G(\sigma_*)=E\bigr)\\
\sigma_*\!\left(\partial_G(e,\mathsf{source})\right)
&\ne
\sigma_*\!\left(\partial_G(e,\mathsf{target})\right)
&&\bigl(\because\ \text{破れ辺集合の定義}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_spin_label_set"),
        " の元は相異なる二つのラベル ",
        math(String.raw`\mathsf{up},\mathsf{down}`),
        " だけなので、各辺の二端点のうちちょうど一方の ",
        math(String.raw`\sigma_*`),
        " 値が ",
        math(String.raw`\mathsf{up}`),
        " である。したがって各辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A_*`),
        " に属する。全ての集合は有限であり、多重度と辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_positive_rational_reciprocity",
    kind: "theorem",
    title: { text: "全辺二分割をもつ有限グラフの正の有理評価における逆数対称性" },
    labels: ["theorem_full_cut_positive_rational_evaluation_reciprocity"],
    habitat: "Q",
    verification: ["sagemath/check/full-cut-positive-rational-evaluation-reciprocity"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。このとき、任意の正の有理数 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " について",
      ]),
      displayMath(String.raw`Z_G(q)=q^{|E|}Z_G(q^{-1})\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([
        ref("def_ising_partition_polynomial"),
        " と ",
        ref("def_broken_edge_multiplicity"),
        " より、正の有理数 ",
        math(String.raw`q`),
        " における評価は多重度の有限和である。さらに ",
        ref("theorem_full_cut_coefficient_symmetry"),
        " より係数は辺数を中心に対称である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_G(q)
&=\sum_{m=0}^{|E|}\Omega_G(m)q^m
&&\bigl(\because\ \text{Ising 分配多項式の定義を }q\text{ で評価}\bigr)\\
&=\sum_{m=0}^{|E|}\Omega_G(|E|-m)q^m
&&\bigl(\because\ \text{全辺二分割による係数対称性}\bigr)\\
&=\sum_{n=0}^{|E|}\Omega_G(n)q^{|E|-n}
&&\bigl(\because\ n=|E|-m\text{ による有限和の添字付け替え}\bigr)\\
&=\sum_{n=0}^{|E|}\Omega_G(n)q^{|E|}q^{-n}
&&\bigl(\because\ q^{|E|-n}=q^{|E|}q^{-n}\bigr)\\
&=q^{|E|}\sum_{n=0}^{|E|}\Omega_G(n)q^{-n}
&&\bigl(\because\ \text{有限和の分配律}\bigr)\\
&=q^{|E|}Z_G(q^{-1})
&&\bigl(\because\ q^{-1}\in\mathbb Q_{>0}\text{ と Ising 分配多項式の定義}\bigr).
\end{aligned}`),
      paragraph([
        "評価点と評価値は有理数、多重度と辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_polynomial_reciprocity_characterizes_full_cut",
    kind: "theorem",
    title: { text: "多項式逆数対称性による全辺二分割の特徴付け" },
    labels: ["theorem_partition_polynomial_reciprocity_characterizes_full_cut"],
    habitat: "Z",
    verification: ["sagemath/check/polynomial-reciprocity-full-cut-characterization"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、次の二条件は同値である。",
      ]),
      paragraph([
        "ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属する。",
      ]),
      paragraph([
        "不定元 ",
        math(String.raw`x`),
        " の整数係数 Laurent 多項式環 ",
        math(String.raw`\mathbb Z[x,x^{-1}]`),
        " において",
      ]),
      displayMath(String.raw`Z_G(x)=x^{|E|}Z_G(x^{-1}).`),
    ],
    proof: [
      paragraph([
        "全ての辺の二端点のうちちょうど一方だけを含む頂点部分集合が存在すると仮定する。",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " と ",
        ref("theorem_full_cut_coefficient_symmetry"),
        " より、整数係数 Laurent 多項式環で",
      ]),
      displayMath(String.raw`\begin{aligned}
x^{|E|}Z_G(x^{-1})
&=x^{|E|}\sum_{m=0}^{|E|}\Omega_G(m)x^{-m}
&&\bigl(\because\ \text{多重度による係数表示へ }x^{-1}\text{ を代入}\bigr)\\
&=\sum_{m=0}^{|E|}x^{|E|}\Omega_G(m)x^{-m}
&&\bigl(\because\ \text{有限和に対する分配律}\bigr)\\
&=\sum_{m=0}^{|E|}\Omega_G(m)x^{|E|}x^{-m}
&&\bigl(\because\ \text{Laurent 多項式環の乗法の可換律}\bigr)\\
&=\sum_{m=0}^{|E|}\Omega_G(m)x^{|E|-m}
&&\bigl(\because\ \text{整数指数の加法則}\bigr)\\
&=\sum_{n=0}^{|E|}\Omega_G(|E|-n)x^n
&&\bigl(\because\ n=|E|-m\text{ による有限和の添字付け替え}\bigr)\\
&=\sum_{n=0}^{|E|}\Omega_G(n)x^n
&&\bigl(\because\ \text{全辺二分割による係数対称性}\bigr)\\
&=Z_G(x)
&&\bigl(\because\ \text{多重度による係数表示}\bigr).
\end{aligned}`),
      paragraph([
        "逆に、整数係数 Laurent 多項式環で ",
        math(String.raw`Z_G(x)=x^{|E|}Z_G(x^{-1})`),
        " と仮定する。Laurent 多項式 ",
        math(String.raw`P`),
        " と整数 ",
        math(String.raw`k\in\mathbb Z`),
        " に対し、",
        math(String.raw`[x^k]P\in\mathbb Z`),
        " を ",
        math(String.raw`x^k`),
        " の係数と書く。任意の ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(m)
&=[x^m]Z_G(x)
&&\bigl(\because\ \text{多重度による係数表示}\bigr)\\
&=[x^m]\!\left(x^{|E|}Z_G(x^{-1})\right)
&&\bigl(\because\ \text{仮定した Laurent 多項式の等式}\bigr)\\
&=[x^m]\!\left(x^{|E|}\sum_{n=0}^{|E|}\Omega_G(n)x^{-n}\right)
&&\bigl(\because\ \text{多重度による係数表示へ }x^{-1}\text{ を代入}\bigr)\\
&=\Omega_G(|E|-m)
&&\bigl(\because\ \text{Laurent 多項式の係数の定義}\bigr).
\end{aligned}`),
      paragraph([
        "したがって全ての ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " について係数対称性が成り立つ。",
        ref("theorem_coefficient_symmetry_characterizes_full_cut"),
        " より、全ての辺の二端点のうちちょうど一方だけを含む頂点部分集合が存在する。多重度と辺数は自然数、Laurent 多項式の係数は整数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_fisher_zero_reciprocal_multiplicity",
    kind: "theorem",
    title: { text: "全辺二分割をもつ有限グラフの Fisher 零点重複度の逆数対称性" },
    labels: ["theorem_full_cut_fisher_zero_reciprocal_multiplicity"],
    habitat: "Qbar",
    verification: ["sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。",
        ref("def_ising_partition_polynomial"),
        " の係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式を",
      ]),
      displayMath(String.raw`\overline P_G(x):=\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}\!\left(Z_G(x)\right)
\in\overline{\mathbb Q}[x]`),
      paragraph(["と置く。各 ", math(String.raw`\alpha\in\overline{\mathbb Q}`), " の零点重複度を"]),
      displayMath(String.raw`\mu_G(\alpha):=
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  (x-\alpha)^k\mid\overline P_G(x)
  \text{ in }\overline{\mathbb Q}[x]
\right\}
\in\mathbb N`),
      paragraph(["で定める。このとき任意の ", math(String.raw`\alpha\in\overline{\mathbb Q}^{\times}`), " について"]),
      displayMath(String.raw`\mu_G(\alpha^{-1})=\mu_G(\alpha).`),
      paragraph([
        "特に、非零 Fisher 零点は逆数を取る写像で重複度ごとに保たれる。",
      ]),
    ],
    proof: [
      paragraph([
        "全頂点下向き配位 ",
        math(String.raw`\sigma_{\mathsf{down}}\in\mathcal S_G`),
        " は破れ辺数零をもつので、",
        ref("def_broken_edge_multiplicity"),
        " より",
      ]),
      displayMath(String.raw`\Omega_G(0)\geq1.`),
      paragraph([
        ref("theorem_full_cut_coefficient_symmetry"),
        " を ",
        math(String.raw`m=0`),
        " に適用すると",
      ]),
      displayMath(String.raw`\Omega_G(|E|)=\Omega_G(0)\geq1.`),
      paragraph([ref("claim_partition_polynomial_coefficient_expansion"), " より"]),
      displayMath(String.raw`\deg\overline P_G=|E|,
\qquad
\overline P_G(0)=\Omega_G(0)\ne0.`),
      paragraph([
        "したがって ",
        math(String.raw`\overline P_G`),
        " は非零多項式であり、零点重複度を定める集合は ",
        math(String.raw`k=0`),
        " を含み、",
        math(String.raw`|E|`),
        " 以下なので、",
        math(String.raw`\mu_G(\alpha)`),
        " は全ての ",
        math(String.raw`\alpha\in\overline{\mathbb Q}`),
        " で一意に定まる。",
      ]),
      paragraph([
        math(String.raw`\alpha\in\overline{\mathbb Q}^{\times}`),
        " を固定し、",
        math(String.raw`r:=\mu_G(\alpha)\in\mathbb N`),
        " と置く。重複度の定義より、ある ",
        math(String.raw`Q_\alpha(x)\in\overline{\mathbb Q}[x]`),
        " が一意に存在して",
      ]),
      displayMath(String.raw`\overline P_G(x)=(x-\alpha)^rQ_\alpha(x),
\qquad
Q_\alpha(\alpha)\ne0,
\qquad
\deg Q_\alpha=|E|-r.`),
      paragraph([
        ref("theorem_partition_polynomial_reciprocity_characterizes_full_cut"),
        " の順方向を標準単射で ",
        math(String.raw`\overline{\mathbb Q}[x,x^{-1}]`),
        " へ移し、直前の因子分解を代入すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline P_G(x)
&=x^{|E|}\overline P_G(x^{-1})
&&\bigl(\because\ \text{全辺二分割による多項式逆数対称性}\bigr)\\
&=x^{|E|}(x^{-1}-\alpha)^rQ_\alpha(x^{-1})
&&\bigl(\because\ \overline P_G(x^{-1})=(x^{-1}-\alpha)^rQ_\alpha(x^{-1})\bigr)\\
&=x^{|E|-r}(1-\alpha x)^rQ_\alpha(x^{-1})
&&\bigl(\because\ x^{-1}-\alpha=x^{-1}(1-\alpha x)\bigr)\\
&=(-\alpha)^r(x-\alpha^{-1})^r x^{|E|-r}Q_\alpha(x^{-1})
&&\bigl(\because\ 1-\alpha x=-\alpha(x-\alpha^{-1})\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\deg Q_\alpha=|E|-r`),
        " なので、逆順多項式",
      ]),
      displayMath(String.raw`R_\alpha(x):=x^{|E|-r}Q_\alpha(x^{-1})
\in\overline{\mathbb Q}[x]`),
      paragraph(["は次を満たす。"]),
      displayMath(String.raw`\begin{aligned}
R_\alpha(\alpha^{-1})
&=(\alpha^{-1})^{|E|-r}Q_\alpha(\alpha)
&&\bigl(\because\ R_\alpha\text{ の定義へ }x=\alpha^{-1}\text{ を代入}\bigr)\\
&\ne0
&&\bigl(\because\ \alpha\ne0\text{ かつ }Q_\alpha(\alpha)\ne0\bigr).
\end{aligned}`),
      paragraph([
        "また ",
        math(String.raw`(-\alpha)^r\ne0`),
        " である。したがって直前の因子分解における ",
        math(String.raw`x-\alpha^{-1}`),
        " の指数はちょうど ",
        math(String.raw`r`),
        " であり、",
      ]),
      displayMath(String.raw`\mu_G(\alpha^{-1})=r=\mu_G(\alpha).`),
      paragraph([
        "多項式と係数は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、重複度と辺数は自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_fisher_zero_product",
    kind: "theorem",
    title: { text: "全辺二分割をもつ有限グラフの Fisher 零点積" },
    labels: ["theorem_full_cut_fisher_zero_product"],
    habitat: "Qbar",
    verification: ["sagemath/check/full-cut-fisher-zero-product"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。",
        ref("def_ising_partition_polynomial"),
        " の係数を標準単射で ",
        math(String.raw`\overline{\mathbb Q}[x]`),
        " へ移した多項式を ",
        math(String.raw`\overline P_G(x)`),
        " と書く。重複度を込めた全ての零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_{|E|}\in\overline{\mathbb Q}`),
        " と書くとき、",
      ]),
      displayMath(String.raw`\prod_{j=1}^{|E|}\alpha_j=(-1)^{|E|}\quad\text{in }\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`E=\varnothing`),
        " の場合、左辺は空積 ",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "全頂点下向き配位は破れ辺数零をもつので、",
        ref("def_broken_edge_multiplicity"),
        " より",
      ]),
      displayMath(String.raw`\Omega_G(0)\geq1.`),
      paragraph([
        ref("theorem_full_cut_coefficient_symmetry"),
        " を ",
        math(String.raw`m=0`),
        " に適用すると",
      ]),
      displayMath(String.raw`\Omega_G(|E|)=\Omega_G(0)\geq1.`),
      paragraph([
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より ",
        math(String.raw`\deg\overline P_G=|E|`),
        " かつ ",
        math(String.raw`\overline P_G(0)=\Omega_G(0)\ne0`),
        " である。代数的閉体 ",
        math(String.raw`\overline{\mathbb Q}`),
        " 上の一次因子分解により、重複度を込めた零点 ",
        math(String.raw`\alpha_1,\ldots,\alpha_{|E|}`),
        " を選んで",
      ]),
      displayMath(String.raw`\overline P_G(x)
=\Omega_G(|E|)\prod_{j=1}^{|E|}(x-\alpha_j)`),
      paragraph(["と書ける。したがって、"]),
      displayMath(String.raw`\begin{aligned}
\Omega_G(0)
&=\overline P_G(0)
&&\bigl(\because\ \text{定数項の定義}\bigr)\\
&=\Omega_G(|E|)\prod_{j=1}^{|E|}(0-\alpha_j)
&&\bigl(\because\ \text{一次因子分解へ }x=0\text{ を代入}\bigr)\\
&=\Omega_G(|E|)(-1)^{|E|}\prod_{j=1}^{|E|}\alpha_j
&&\bigl(\because\ \text{有限積の各因子から }-1\text{ を取り出す}\bigr).
\end{aligned}`),
      paragraph([ref("theorem_full_cut_coefficient_symmetry"), " を再び ", math(String.raw`m=0`), " に適用すると"]),
      displayMath(String.raw`\Omega_G(|E|)(-1)^{|E|}\prod_{j=1}^{|E|}\alpha_j
=\Omega_G(0)(-1)^{|E|}\prod_{j=1}^{|E|}\alpha_j.`),
      paragraph(["直前の二つの等式より"]),
      displayMath(String.raw`\Omega_G(0)=\Omega_G(0)(-1)^{|E|}\prod_{j=1}^{|E|}\alpha_j.`),
      paragraph([
        math(String.raw`\Omega_G(0)\ne0`),
        " なので、代数的数の体の消去律より",
      ]),
      displayMath(String.raw`1=(-1)^{|E|}\prod_{j=1}^{|E|}\alpha_j.`),
      paragraph([math(String.raw`(-1)^{2|E|}=1`), " なので、"]),
      displayMath(String.raw`\prod_{j=1}^{|E|}\alpha_j=(-1)^{|E|}.`),
      paragraph([
        "零点と積は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、多重度と辺数は自然数、係数は整数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_fisher_zero_minus_one_multiplicity_parity",
    kind: "theorem",
    title: { text: "全辺二分割をもつ有限グラフの零点 -1 の重複度の偶奇" },
    labels: ["theorem_full_cut_fisher_zero_minus_one_multiplicity_parity"],
    habitat: "N",
    verification: ["sagemath/check/full-cut-fisher-zero-minus-one-multiplicity-parity"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。",
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " の零点重複度 ",
        math(String.raw`\mu_G:\overline{\mathbb Q}\to\mathbb N`),
        " について、零点 ",
        math(String.raw`-1\in\overline{\mathbb Q}`),
        " の重複度と辺数の偶奇は一致する。すなわち",
      ]),
      displayMath(String.raw`\mu_G(-1)\equiv |E|\pmod 2.`),
    ],
    proof: [
      paragraph([
        "全頂点下向き配位は破れ辺数零をもつので、",
        ref("def_broken_edge_multiplicity"),
        " より",
      ]),
      displayMath(String.raw`\Omega_G(0)\geq1.`),
      paragraph([
        ref("theorem_full_cut_coefficient_symmetry"),
        " を ",
        math(String.raw`m=0`),
        " に適用すると",
      ]),
      displayMath(String.raw`\Omega_G(|E|)=\Omega_G(0)\geq1.`),
      paragraph([ref("claim_partition_polynomial_coefficient_expansion"), " より"]),
      displayMath(String.raw`\deg\overline P_G=|E|,
\qquad
\overline P_G(0)=\Omega_G(0)\ne0.`),
      paragraph(["したがって零点台を"]),
      displayMath(String.raw`\mathcal Z_G:=
\left\{
  \alpha\in\overline{\mathbb Q}^{\times}
  \;\middle|\;
  \mu_G(\alpha)>0
\right\}`),
      paragraph([
        "と書ける。これは ",
        math(String.raw`\overline P_G`),
        " の有限な零点集合である。さらに、",
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " より逆数写像 ",
        math(String.raw`\alpha\mapsto\alpha^{-1}`),
        " は ",
        math(String.raw`\mathcal Z_G`),
        " を保ち、各零点の重複度を保つ。",
      ]),
      displayMath(String.raw`\mu_G(\alpha^{-1})=\mu_G(\alpha)
\quad\text{for every }\alpha\in\mathcal Z_G.`),
      paragraph([
        math(String.raw`\alpha\in\mathcal Z_G`),
        " が逆数写像の固定点ならば、代数的数の体で",
      ]),
      displayMath(String.raw`\begin{aligned}
\alpha
&=\alpha^{-1}
&&\bigl(\because\ \text{逆数写像の固定点である}\bigr)\\
\alpha^2
&=1
&&\bigl(\because\ \alpha\ne0\text{ なので両辺へ }\alpha\text{ を掛ける}\bigr)\\
\alpha^2-1
&=0
&&\bigl(\because\ \text{両辺から }1\text{ を引く}\bigr)\\
(\alpha-1)(\alpha+1)
&=0
&&\bigl(\because\ \alpha^2-1=(\alpha-1)(\alpha+1)\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\overline{\mathbb Q}`),
        " は体なので、固定点は ",
        math(String.raw`\alpha\in\{-1,1\}`),
        " に限られる。ゆえに ",
        math(String.raw`\mathcal Z_G\setminus\{-1,1\}`),
        " は逆数写像の二元軌道へ分割され、各軌道 ",
        math(String.raw`\{\alpha,\alpha^{-1}\}`),
        " の重複度総和は",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu_G(\alpha)+\mu_G(\alpha^{-1})
&=\mu_G(\alpha)+\mu_G(\alpha)
&&\bigl(\because\ \text{逆数による重複度保存}\bigr)\\
&=2\mu_G(\alpha)
&&\bigl(\because\ \mathbb N\text{ の加法}\bigr).
\end{aligned}`),
      paragraph(["したがって"]),
      displayMath(String.raw`\sum_{\alpha\in\mathcal Z_G\setminus\{-1,1\}}\mu_G(\alpha)
\equiv0\pmod2.`),
      paragraph([ref("claim_partition_polynomial_value_at_one"), " を標準単射で移すと"]),
      displayMath(String.raw`\begin{aligned}
\overline P_G(1)
&=2^{|V|}
&&\bigl(\because\ Z_G(1)=2^{|V|}\bigr)\\
&\ne0
&&\bigl(\because\ |V|\in\mathbb N\text{ かつ }2^{|V|}>0\bigr).
\end{aligned}`),
      displayMath(String.raw`\mu_G(1)=0
\quad\bigl(\because\ \overline P_G(1)\ne0\bigr).`),
      paragraph([
        "代数的閉体上の一次因子分解における重複度総和は多項式の次数に等しく、",
        "上で得た ",
        math(String.raw`\deg\overline P_G=|E|`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
|E|
&=\sum_{\alpha\in\mathcal Z_G}\mu_G(\alpha)
&&\bigl(\because\ \text{一次因子分解における重複度総和}\bigr)\\
&=\mu_G(-1)+\mu_G(1)
  +\sum_{\alpha\in\mathcal Z_G\setminus\{-1,1\}}\mu_G(\alpha)
&&\bigl(\because\ \mu_G\text{ は零点台の外で零、有限零点台を三部分へ分割}\bigr)\\
&\equiv\mu_G(-1)+\mu_G(1)\pmod2
&&\bigl(\because\ \text{非固定軌道の重複度総和は偶数}\bigr)\\
&=\mu_G(-1)\pmod2
&&\bigl(\because\ \mu_G(1)=0\bigr).
\end{aligned}`),
      paragraph([
        "零点は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、重複度と辺数は自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_fisher_zero_product_away_from_minus_one",
    kind: "theorem",
    title: { text: "全辺二分割をもつ有限グラフの零点 -1 を除く Fisher 零点積" },
    labels: ["theorem_full_cut_fisher_zero_product_away_from_minus_one"],
    habitat: "Qbar",
    verification: ["sagemath/check/full-cut-fisher-zero-product-away-from-minus-one"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。",
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " の零点重複度を ",
        math(String.raw`\mu_G:\overline{\mathbb Q}\to\mathbb N`),
        " とし、非零 Fisher 零点の有限集合を",
      ]),
      displayMath(String.raw`\mathcal Z_G:=
\left\{
  \alpha\in\overline{\mathbb Q}^{\times}
  \;\middle|\;
  \mu_G(\alpha)>0
\right\}`),
      paragraph(["と置く。このとき零点 ", math(String.raw`-1`), " を除く重複度込み積は"]),
      displayMath(String.raw`\prod_{\alpha\in\mathcal Z_G\setminus\{-1\}}
\alpha^{\mu_G(\alpha)}=1
\quad\text{in }\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`\mathcal Z_G\setminus\{-1\}=\varnothing`),
        " の場合、左辺は空積 ",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([ref("claim_partition_polynomial_value_at_one"), " を標準単射で ", math(String.raw`\overline{\mathbb Q}`), " へ移すと"]),
      displayMath(String.raw`\begin{aligned}
\overline P_G(1)
&=2^{|V|}
&&\bigl(\because\ Z_G(1)=2^{|V|}\bigr)\\
&\ne0
&&\bigl(\because\ |V|\in\mathbb N\text{ かつ }2^{|V|}>0\bigr).
\end{aligned}`),
      displayMath(String.raw`\mu_G(1)=0
\quad\bigl(\because\ \overline P_G(1)\ne0\bigr).`),
      paragraph([
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " より、逆数写像は ",
        math(String.raw`\mathcal Z_G`),
        " と各零点の重複度を保つ。さらに ",
        math(String.raw`\alpha\in\overline{\mathbb Q}^{\times}`),
        " が逆数写像の固定点ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
\alpha
&=\alpha^{-1}
&&\bigl(\because\ \text{逆数写像の固定点である}\bigr)\\
\alpha^2
&=1
&&\bigl(\because\ \alpha\ne0\text{ なので両辺へ }\alpha\text{ を掛ける}\bigr)\\
\alpha^2-1
&=0
&&\bigl(\because\ \text{両辺から }1\text{ を引く}\bigr)\\
(\alpha-1)(\alpha+1)
&=0
&&\bigl(\because\ \alpha^2-1=(\alpha-1)(\alpha+1)\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\overline{\mathbb Q}`),
        " は体であり、",
        math(String.raw`\mu_G(1)=0`),
        " なので、",
        math(String.raw`\mathcal Z_G\setminus\{-1\}`),
        " は相異なる二元からなる逆数軌道 ",
        math(String.raw`\{\alpha,\alpha^{-1}\}`),
        " へ分割される。その軌道全体からなる有限集合を",
      ]),
      displayMath(String.raw`\mathcal O_G:=
\left\{
  \{\alpha,\alpha^{-1}\}
  \;\middle|\;
  \alpha\in\mathcal Z_G\setminus\{-1\}
\right\}`),
      paragraph(["と置く。各 ", math(String.raw`O=\{\alpha,\alpha^{-1}\}\in\mathcal O_G`), " について"]),
      displayMath(String.raw`\begin{aligned}
\prod_{\beta\in O}\beta^{\mu_G(\beta)}
&=\alpha^{\mu_G(\alpha)}(\alpha^{-1})^{\mu_G(\alpha^{-1})}
&&\bigl(\because\ O=\{\alpha,\alpha^{-1}\}\text{ かつ }\alpha\ne\alpha^{-1}\bigr)\\
&=\alpha^{\mu_G(\alpha)}(\alpha^{-1})^{\mu_G(\alpha)}
&&\bigl(\because\ \mu_G(\alpha^{-1})=\mu_G(\alpha)\bigr)\\
&=(\alpha\alpha^{-1})^{\mu_G(\alpha)}
&&\bigl(\because\ \text{可換体における同じ自然数冪の積}\bigr)\\
&=1
&&\bigl(\because\ \alpha\ne0\text{ かつ }\alpha\alpha^{-1}=1\bigr).
\end{aligned}`),
      paragraph(["したがって有限な逆数軌道全体にわたって積を取ると"]),
      displayMath(String.raw`\begin{aligned}
\prod_{\alpha\in\mathcal Z_G\setminus\{-1\}}\alpha^{\mu_G(\alpha)}
&=\prod_{O\in\mathcal O_G}\prod_{\beta\in O}\beta^{\mu_G(\beta)}
&&\bigl(\because\ \text{有限集合の逆数二元軌道による分割}\bigr)\\
&=\prod_{O\in\mathcal O_G}1
&&\bigl(\because\ \text{各逆数軌道の積は }1\bigr)\\
&=1
&&\bigl(\because\ \text{有限個の }1\text{ の積、空積も }1\bigr).
\end{aligned}`),
      paragraph([
        "零点と積は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、重複度は自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_fisher_zero_support_parity_characterization",
    kind: "theorem",
    title: { text: "全辺二分割をもつ有限グラフの Fisher 零点台の奇偶による奇接続辺数頂点の特徴付け" },
    labels: ["theorem_full_cut_fisher_zero_support_parity_characterization"],
    habitat: "N",
    verification: ["sagemath/check/full-cut-fisher-zero-support-parity-characterization"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。",
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " の零点重複度を ",
        math(String.raw`\mu_G:\overline{\mathbb Q}\to\mathbb N`),
        " とし、非零 Fisher 零点の有限集合を",
      ]),
      displayMath(String.raw`\mathcal Z_G:=
\left\{
  \alpha\in\overline{\mathbb Q}^{\times}
  \;\middle|\;
  \mu_G(\alpha)>0
\right\}`),
      paragraph(["と置く。各 ", math(String.raw`w\in V`), " に接続する辺の有限集合を"]),
      displayMath(String.raw`I_w:=
\left\{
  e\in E
  \;\middle|\;
  \partial_G(e,\mathsf{source})=w
  \quad\text{または}\quad
  \partial_G(e,\mathsf{target})=w
\right\}`),
      paragraph(["と置く。このとき、Fisher 零点台の元数が奇数であることと、奇数本の辺が接続する頂点が存在することは同値である。すなわち"]),
      displayMath(String.raw`|\mathcal Z_G|\in\{2n+1\mid n\in\mathbb N\}
\quad\Longleftrightarrow\quad
\exists w\in V,\quad |I_w|\in\{2n+1\mid n\in\mathbb N\}.`),
    ],
    proof: [
      paragraph([
        "全頂点下向き配位は破れ辺数零をもつので、",
        ref("def_broken_edge_multiplicity"),
        " より ",
        math(String.raw`\Omega_G(0)\geq1`),
        " である。",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " を標準単射で ",
        math(String.raw`\overline{\mathbb Q}`),
        " へ移すと",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline P_G(0)
&=\Omega_G(0)
&&\bigl(\because\ \text{定数項の定義}\bigr)\\
&\ne0
&&\bigl(\because\ \Omega_G(0)\geq1\bigr).
\end{aligned}`),
      displayMath(String.raw`\mu_G(0)=0
\quad\bigl(\because\ \overline P_G(0)\ne0\bigr).`),
      paragraph(["したがって ", math(String.raw`\mathcal Z_G`), " は相異なる Fisher 零点全体の有限集合である。"]),
      paragraph([ref("claim_partition_polynomial_value_at_one"), " を標準単射で ", math(String.raw`\overline{\mathbb Q}`), " へ移すと"]),
      displayMath(String.raw`\begin{aligned}
\overline P_G(1)
&=2^{|V|}
&&\bigl(\because\ Z_G(1)=2^{|V|}\bigr)\\
&\ne0
&&\bigl(\because\ |V|\in\mathbb N\text{ かつ }2^{|V|}>0\bigr).
\end{aligned}`),
      displayMath(String.raw`\mu_G(1)=0
\quad\bigl(\because\ \overline P_G(1)\ne0\bigr).`),
      paragraph([
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " より、逆数写像は ",
        math(String.raw`\mathcal Z_G`),
        " を保つ。さらに ",
        math(String.raw`\alpha\in\overline{\mathbb Q}^{\times}`),
        " が逆数写像の固定点ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
\alpha
&=\alpha^{-1}
&&\bigl(\because\ \text{逆数写像の固定点である}\bigr)\\
\alpha^2
&=1
&&\bigl(\because\ \alpha\ne0\text{ なので両辺へ }\alpha\text{ を掛ける}\bigr)\\
\alpha^2-1
&=0
&&\bigl(\because\ \text{両辺から }1\text{ を引く}\bigr)\\
(\alpha-1)(\alpha+1)
&=0
&&\bigl(\because\ \alpha^2-1=(\alpha-1)(\alpha+1)\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\overline{\mathbb Q}`),
        " は体であり、",
        math(String.raw`\mu_G(1)=0`),
        " なので、",
        math(String.raw`\mathcal Z_G\setminus\{-1\}`),
        " は相異なる二元からなる逆数軌道へ分割される。その軌道全体の有限集合を ",
        math(String.raw`\mathcal O_G`),
        " と置く。また",
      ]),
      displayMath(String.raw`\varepsilon_G:=
\begin{cases}
1,&\mu_G(-1)>0,\\
0,&\mu_G(-1)=0
\end{cases}
\in\mathbb N`),
      paragraph(["と置く。有限集合の二元軌道による分割から"]),
      displayMath(String.raw`|\mathcal Z_G|=2|\mathcal O_G|+\varepsilon_G
\quad\bigl(\because\ -1\text{ だけが }\mathcal Z_G\text{ に属し得る逆数固定点である}\bigr).`),
      paragraph(["したがって、", ref("theorem_root_minus_one_characterizes_odd_incident_edge_count"), " と上の定義を順に用いると"]),
      displayMath(String.raw`\begin{aligned}
|\mathcal Z_G|\in\{2n+1\mid n\in\mathbb N\}
&\Longleftrightarrow\varepsilon_G=1
&&\bigl(\because\ |\mathcal Z_G|=2|\mathcal O_G|+\varepsilon_G\bigr)\\
&\Longleftrightarrow\mu_G(-1)>0
&&\bigl(\because\ \varepsilon_G\text{ の定義}\bigr)\\
&\Longleftrightarrow\overline P_G(-1)=0
&&\bigl(\because\ \mu_G(-1)\text{ は零点重複度である}\bigr)\\
&\Longleftrightarrow Z_G(-1)=0
&&\bigl(\because\ \mathbb Z\hookrightarrow\overline{\mathbb Q}\text{ は単射である}\bigr)\\
&\Longleftrightarrow\exists w\in V,\quad |I_w|\in\{2n+1\mid n\in\mathbb N\}
&&\bigl(\because\ \text{零点 }-1\text{ による奇接続辺数頂点の特徴付け}\bigr),
\end{aligned}`),
      paragraph([
        "零点は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、零点台、逆数軌道、頂点集合、辺集合は有限集合、重複度、元数、接続辺数は自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_distinct_fisher_zero_product",
    kind: "theorem",
    title: { text: "全辺二分割をもつ有限グラフの相異なる Fisher 零点積" },
    labels: ["theorem_full_cut_distinct_fisher_zero_product"],
    habitat: "Qbar",
    verification: ["sagemath/check/full-cut-distinct-fisher-zero-product"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。",
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " の零点重複度を ",
        math(String.raw`\mu_G:\overline{\mathbb Q}\to\mathbb N`),
        " とし、相異なる非零 Fisher 零点の有限集合を",
      ]),
      displayMath(String.raw`\mathcal Z_G:=
\left\{
  \alpha\in\overline{\mathbb Q}^{\times}
  \;\middle|\;
  \mu_G(\alpha)>0
\right\}`),
      paragraph(["と置く。各 ", math(String.raw`w\in V`), " に接続する辺の有限集合を"]),
      displayMath(String.raw`I_w:=
\left\{
  e\in E
  \;\middle|\;
  \partial_G(e,\mathsf{source})=w
  \quad\text{または}\quad
  \partial_G(e,\mathsf{target})=w
\right\}`),
      paragraph(["と置く。このとき、相異なる非零 Fisher 零点の積は"]),
      displayMath(String.raw`\prod_{\alpha\in\mathcal Z_G}\alpha
=
\begin{cases}
-1,&\exists w\in V,\quad |I_w|\in\{2n+1\mid n\in\mathbb N\},\\
1,&\forall w\in V,\quad |I_w|\in\{2n\mid n\in\mathbb N\}
\end{cases}
\quad\text{in }\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([ref("claim_partition_polynomial_value_at_one"), " を標準単射で ", math(String.raw`\overline{\mathbb Q}`), " へ移すと"]),
      displayMath(String.raw`\begin{aligned}
\overline P_G(1)
&=2^{|V|}
&&\bigl(\because\ Z_G(1)=2^{|V|}\bigr)\\
&\ne0
&&\bigl(\because\ |V|\in\mathbb N\text{ かつ }2^{|V|}>0\bigr).
\end{aligned}`),
      displayMath(String.raw`\mu_G(1)=0
\quad\bigl(\because\ \overline P_G(1)\ne0\bigr).`),
      paragraph([
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " より逆数写像は ",
        math(String.raw`\mathcal Z_G`),
        " を保つ。また、",
        math(String.raw`\alpha\in\overline{\mathbb Q}^{\times}`),
        " が逆数写像の固定点ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
\alpha
&=\alpha^{-1}
&&\bigl(\because\ \text{逆数写像の固定点である}\bigr)\\
\alpha^2
&=1
&&\bigl(\because\ \alpha\ne0\text{ なので両辺へ }\alpha\text{ を掛ける}\bigr)\\
\alpha^2-1
&=0
&&\bigl(\because\ \text{両辺から }1\text{ を引く}\bigr)\\
(\alpha-1)(\alpha+1)
&=0
&&\bigl(\because\ \alpha^2-1=(\alpha-1)(\alpha+1)\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\overline{\mathbb Q}`),
        " は体なので零積律より固定点は ",
        math(String.raw`1,-1`),
        " だけである。さらに ",
        math(String.raw`\mu_G(1)=0`),
        " である。したがって ",
        math(String.raw`\mathcal Z_G\setminus\{-1\}`),
        " は相異なる二元からなる逆数軌道へ分割される。その軌道全体の有限集合を ",
        math(String.raw`\mathcal O_G`),
        " と置く。各 ",
        math(String.raw`O\in\mathcal O_G`),
        " について、ある ",
        math(String.raw`\alpha\in\mathcal Z_G\setminus\{-1\}`),
        " が存在して ",
        math(String.raw`O=\{\alpha,\alpha^{-1}\}`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\beta\in O}\beta
&=\alpha\alpha^{-1}
&&\bigl(\because\ O=\{\alpha,\alpha^{-1}\}\bigr)\\
&=1
&&\bigl(\because\ \alpha\in\overline{\mathbb Q}^{\times}\bigr).
\end{aligned}`),
      paragraph(["有限集合の逆数軌道による分割と空積の規約から"]),
      displayMath(String.raw`\begin{aligned}
\prod_{\alpha\in\mathcal Z_G}\alpha
&=
\begin{cases}
(-1)\displaystyle\prod_{O\in\mathcal O_G}\prod_{\beta\in O}\beta,&-1\in\mathcal Z_G,\\
\displaystyle\prod_{O\in\mathcal O_G}\prod_{\beta\in O}\beta,&-1\notin\mathcal Z_G
\end{cases}
&&\bigl(\because\ \mathcal Z_G\text{ の逆数軌道分割}\bigr)\\
&=
\begin{cases}
-1,&-1\in\mathcal Z_G,\\
1,&-1\notin\mathcal Z_G
\end{cases}
&&\bigl(\because\ \text{各二元軌道の積は }1\bigr).
\end{aligned}`),
      paragraph([ref("theorem_root_minus_one_characterizes_odd_incident_edge_count"), " と零点重複度の定義より"]),
      displayMath(String.raw`\begin{aligned}
-1\in\mathcal Z_G
&\Longleftrightarrow\mu_G(-1)>0
&&\bigl(\because\ \mathcal Z_G\text{ の定義}\bigr)\\
&\Longleftrightarrow\overline P_G(-1)=0
&&\bigl(\because\ \mu_G(-1)\text{ は零点重複度である}\bigr)\\
&\Longleftrightarrow Z_G(-1)=0
&&\bigl(\because\ \mathbb Z\hookrightarrow\overline{\mathbb Q}\text{ は単射である}\bigr)\\
&\Longleftrightarrow\exists w\in V,\quad |I_w|\in\{2n+1\mid n\in\mathbb N\}
&&\bigl(\because\ \text{零点 }-1\text{ による奇接続辺数頂点の特徴付け}\bigr).
\end{aligned}`),
      paragraph(["自然数の二による除法の一意性より、奇数本の辺が接続する頂点が存在しないことは、全ての頂点で接続辺数が偶数であることと同値である。以上を直前の積の場合分けへ代入すると主張を得る。"]),
      paragraph([
        "零点と積は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、零点台、逆数軌道、頂点集合、辺集合は有限集合、重複度と接続辺数は自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_full_cut_distinct_fisher_zero_product_support_parity",
    kind: "theorem",
    title: { text: "全辺二分割をもつ有限グラフの相異なる Fisher 零点積と零点台の奇偶" },
    labels: ["theorem_full_cut_distinct_fisher_zero_product_support_parity"],
    habitat: "Qbar",
    verification: ["sagemath/check/full-cut-distinct-fisher-zero-product-support-parity"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、ある頂点部分集合 ",
        math(String.raw`A\subseteq V`),
        " が存在し、全ての辺の二端点のうちちょうど一方だけが ",
        math(String.raw`A`),
        " に属すると仮定する。",
        ref("theorem_full_cut_fisher_zero_reciprocal_multiplicity"),
        " の零点重複度を ",
        math(String.raw`\mu_G:\overline{\mathbb Q}\to\mathbb N`),
        " とし、相異なる非零 Fisher 零点の有限集合を",
      ]),
      displayMath(String.raw`\mathcal Z_G:=
\left\{
  \alpha\in\overline{\mathbb Q}^{\times}
  \;\middle|\;
  \mu_G(\alpha)>0
\right\}`),
      paragraph(["と置く。また、各 ", math(String.raw`w\in V`), " に接続する辺の有限集合を"]),
      displayMath(String.raw`I_w:=
\left\{
  e\in E
  \;\middle|\;
  \partial_G(e,\mathsf{source})=w
  \quad\text{または}\quad
  \partial_G(e,\mathsf{target})=w
\right\}`),
      paragraph(["と置く。このとき、相異なる非零 Fisher 零点の積は零点台の元数の奇偶だけで定まり、"]),
      displayMath(String.raw`\prod_{\alpha\in\mathcal Z_G}\alpha
=(-1)^{|\mathcal Z_G|}
\quad\text{in }\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        "自然数の二による除法の一意性より、",
        math(String.raw`|\mathcal Z_G|`),
        " は偶数または奇数のちょうど一方である。まず、ある ",
        math(String.raw`n\in\mathbb N`),
        " について ",
        math(String.raw`|\mathcal Z_G|=2n+1`),
        " と仮定する。",
        ref("theorem_full_cut_fisher_zero_support_parity_characterization"),
        " より",
      ]),
      displayMath(String.raw`\exists w\in V,\quad
|I_w|\in\{2m+1\mid m\in\mathbb N\}
\quad\bigl(\because\ |\mathcal Z_G|\text{ は奇数である}\bigr).`),
      paragraph([
        ref("theorem_full_cut_distinct_fisher_zero_product"),
        " の奇接続辺数頂点が存在する場合を用いると",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\alpha\in\mathcal Z_G}\alpha
&=-1
&&\bigl(\because\ \exists w\in V,\ |I_w|\in\{2m+1\mid m\in\mathbb N\}\bigr)\\
&=(-1)^{2n+1}
&&\bigl(\because\ (-1)^{2n}=1\bigr)\\
&=(-1)^{|\mathcal Z_G|}
&&\bigl(\because\ |\mathcal Z_G|=2n+1\bigr).
\end{aligned}`),
      paragraph([
        "次に、ある ",
        math(String.raw`n\in\mathbb N`),
        " について ",
        math(String.raw`|\mathcal Z_G|=2n`),
        " と仮定する。",
        ref("theorem_full_cut_fisher_zero_support_parity_characterization"),
        " の同値性の対偶より",
      ]),
      displayMath(String.raw`\neg\left(
\exists w\in V,\quad |I_w|\in\{2m+1\mid m\in\mathbb N\}
\right)
\quad\bigl(\because\ |\mathcal Z_G|\text{ は偶数である}\bigr).`),
      paragraph(["各 ", math(String.raw`|I_w|\in\mathbb N`), " に二による除法を適用すると"]),
      displayMath(String.raw`\forall w\in V,\quad
|I_w|\in\{2m\mid m\in\mathbb N\}
\quad\bigl(\because\ \text{奇数でない自然数は偶数である}\bigr).`),
      paragraph([
        ref("theorem_full_cut_distinct_fisher_zero_product"),
        " の全接続辺数が偶数である場合を用いると",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\alpha\in\mathcal Z_G}\alpha
&=1
&&\bigl(\because\ \text{全頂点の接続辺数が偶数である}\bigr)\\
&=(-1)^{2n}
&&\bigl(\because\ (-1)^{2n}=1\bigr)\\
&=(-1)^{|\mathcal Z_G|}
&&\bigl(\because\ |\mathcal Z_G|=2n\bigr).
\end{aligned}`),
      paragraph([
        "以上の二場合で全ての自然数 ",
        math(String.raw`|\mathcal Z_G|`),
        " を尽くすので主張を得る。零点と積は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、零点台は有限集合、重複度と零点台の元数は自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_claim_value_at_one",
    kind: "claim",
    title: { text: "係数総和" },
    labels: ["claim_partition_polynomial_value_at_one"],
    habitat: "N",
    statement: [displayMath(String.raw`Z_G(1)=\sum_{m=0}^{|E|}\Omega_G(m)=2^{|V|}.`)],
    proof: [
      displayMath(String.raw`\begin{aligned}
Z_G(1)
&=\sum_{\sigma\in\mathcal S_G}1^{b_G(\sigma)}
&&\bigl(\because\ \text{Ising 分配多項式の定義}\bigr)\\
&=\sum_{\sigma\in\mathcal S_G}1
&&\bigl(\because\ 1^n=1\ \text{for every }n\in\mathbb N\bigr)\\
&=|\mathcal S_G|
&&\bigl(\because\ \text{有限集合の元の個数の定義}\bigr)\\
&=2^{|V|}
&&\bigl(\because\ \text{各頂点で二つのスピン値を独立に選ぶ}\bigr).
\end{aligned}`),
      paragraph(["多重度の和との等号は ", ref("claim_partition_polynomial_coefficient_expansion"), " に ", math(String.raw`x=1`), " を代入して得る。"]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_shifted_product_configuration_count",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点の一との差の積と全配位数" },
    labels: ["theorem_fisher_zero_shifted_product_configuration_count"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-shifted-product-configuration-count"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を ",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を ",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。このとき、",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}(1-\alpha_j)
=
\frac{2^{|V|}}{\Omega_G(d)}
\in\mathbb Q_{>0}
\subset\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`d=0`),
        " の場合、左辺は空積 ",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数である。標準単射で係数を移した多項式を ",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        " と書く。代数的閉体上の一次因子分解により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\Omega_G(d)\prod_{j=1}^{d}(x-\alpha_j)`),
      paragraph([ref("claim_partition_polynomial_value_at_one"), " より、"]),
      displayMath(String.raw`\begin{aligned}
2^{|V|}
&=Z_G(1)
&&\bigl(\because\ \text{係数総和}\bigr)\\
&=\overline P_G(1)
&&\bigl(\because\ \text{標準単射は整数 }1\text{ での評価を保存する}\bigr)\\
&=\Omega_G(d)\prod_{j=1}^{d}(1-\alpha_j)
&&\bigl(\because\ \text{一次因子分解へ }x=1\text{ を代入する}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\Omega_G(d)\ne0`),
        " なので、代数的数の体で最高次係数を消去すると、",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}(1-\alpha_j)
=
\frac{2^{|V|}}{\Omega_G(d)}.`),
      paragraph([
        math(String.raw`2^{|V|}\in\mathbb N_{>0}`),
        " かつ ",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " なので、右辺は正の有理数に属する。零点、一との差、有限積は代数的数、頂点数、次数、多重度は自然数、係数比は有理数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点と代数的評価点との差の積" },
    labels: ["theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-algebraic-shifted-product-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式を",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        "、その重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。自然数から有理数への標準単射を",
        math(String.raw`\eta_{\mathbb N,\mathbb Q}:\mathbb N\hookrightarrow\mathbb Q`),
        "、有理数から代数的数への標準単射を",
        math(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}:\mathbb Q\hookrightarrow\overline{\mathbb Q}`),
        " と書く。このとき、任意の代数的数",
        math(String.raw`a\in\overline{\mathbb Q}`),
        " について",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}(a-\alpha_j)
=
\frac{
  \overline P_G(a)
}{
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  \right)
}
\in\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`d=0`),
        " の場合、左辺は空積",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数である。代数的閉体上の一次因子分解により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\prod_{j=1}^{d}(x-\alpha_j).`),
      displayMath(String.raw`\overline P_G(a)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\prod_{j=1}^{d}(a-\alpha_j)
\quad\bigl(\because\ \text{一次因子分解へ }x=a\text{ を代入する}\bigr).`),
      paragraph([
        math(String.raw`\eta_{\mathbb N,\mathbb Q}(\Omega_G(d))\ne0`),
        " かつ標準単射は零でない元を零でない元へ移すので、代数的数の体で最高次係数を消去すると、",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}(a-\alpha_j)
=
\frac{
  \overline P_G(a)
}{
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  \right)
}
\quad\bigl(\because\ \text{零でない最高次係数を消去する}\bigr).`),
      paragraph([
        "評価点、評価値、Fisher 零点、差、有限積、係数比は代数的数、次数と多重度は自然数、最高次係数は正の自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient",
    kind: "theorem",
    title: { text: "一般有限グラフの二つの代数的評価点における Fisher 零点差積の商" },
    labels: ["theorem_fisher_zero_algebraic_shifted_product_evaluation_quotient"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-algebraic-shifted-product-evaluation-quotient"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式を",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        "、その重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。自然数から有理数への標準単射を",
        math(String.raw`\eta_{\mathbb N,\mathbb Q}:\mathbb N\hookrightarrow\mathbb Q`),
        "、有理数から代数的数への標準単射を",
        math(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}:\mathbb Q\hookrightarrow\overline{\mathbb Q}`),
        " と書く。代数的数",
        math(String.raw`a,b\in\overline{\mathbb Q}`),
        " が",
        math(String.raw`\overline P_G(b)\ne0`),
        " を満たすならば、",
      ]),
      displayMath(String.raw`\frac{
  \prod_{j=1}^{d}(a-\alpha_j)
}{
  \prod_{j=1}^{d}(b-\alpha_j)
}
=
\frac{
  \overline P_G(a)
}{
  \overline P_G(b)
}
\in\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`d=0`),
        " の場合、二つの有限積はいずれも空積",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio"),
        " を評価点",
        math(String.raw`b`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}(b-\alpha_j)
=
\frac{
  \overline P_G(b)
}{
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  \right)
}.`),
      displayMath(String.raw`\prod_{j=1}^{d}(b-\alpha_j)
\ne0
\quad\bigl(\because\ \overline P_G(b)\ne0\text{ かつ最高次係数は零でない}\bigr).`),
      paragraph([
        ref("theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio"),
        " を評価点",
        math(String.raw`a`),
        " と",
        math(String.raw`b`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{
  \prod_{j=1}^{d}(a-\alpha_j)
}{
  \prod_{j=1}^{d}(b-\alpha_j)
}
&=
\frac{
  \dfrac{
    \overline P_G(a)
  }{
    \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
      \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
    \right)
  }
}{
  \dfrac{
    \overline P_G(b)
  }{
    \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
      \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
    \right)
  }
}
\quad\bigl(\because\ \text{二つの代数的評価点における零点差積の係数比表示}\bigr)\\
&=
\frac{
  \overline P_G(a)
}{
  \overline P_G(b)
}
\quad\bigl(\because\ \text{零でない共通の最高次係数を消去する}\bigr).
\end{aligned}`),
      paragraph([
        "評価点、評価値、Fisher 零点、差、有限積、商は代数的数、次数と多重度は自然数、最高次係数は正の自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_definition_fisher_zero_algebraic_shifted_reciprocal_sum",
    kind: "definition",
    title: { text: "一般有限グラフの代数的評価点における Fisher 零点差の逆数和" },
    labels: ["def_fisher_zero_algebraic_shifted_reciprocal_sum"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式を",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        "、その重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。",
        math(String.raw`\overline P_G(a)\ne0`),
        " を満たす代数的評価点",
        math(String.raw`a\in\overline{\mathbb Q}`),
        " における Fisher 零点差の逆数和を",
      ]),
      displayMath(String.raw`\mathcal R_G(a)
:=
\sum_{j=1}^{d}\frac{1}{a-\alpha_j}
\in\overline{\mathbb Q}`),
      paragraph([
        "と定める。",
        ref("theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio"),
        " より",
        math(String.raw`\prod_{j=1}^{d}(a-\alpha_j)\ne0`),
        " であるから、各",
        math(String.raw`a-\alpha_j\in\overline{\mathbb Q}`),
        " は零でなく、全ての逆数が定義される。有限和は零点の並べ方に依存しない。",
        math(String.raw`d=0`),
        " の場合は空和",
        math(String.raw`\mathcal R_G(a):=0\in\overline{\mathbb Q}`),
        " と定める。評価点、Fisher 零点、差、逆数、有限和は代数的数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの代数的評価点における Fisher 零点差の逆数和と係数表示" },
    labels: ["theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式を",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        "、その重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。自然数から有理数への標準単射を",
        math(String.raw`\eta_{\mathbb N,\mathbb Q}:\mathbb N\hookrightarrow\mathbb Q`),
        "、有理数から代数的数への標準単射を",
        math(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}:\mathbb Q\hookrightarrow\overline{\mathbb Q}`),
        " と書く。",
        math(String.raw`\overline P_G(a)\ne0`),
        " を満たす代数的評価点",
        math(String.raw`a\in\overline{\mathbb Q}`),
        " について、",
        ref("def_fisher_zero_algebraic_shifted_reciprocal_sum"),
        " の逆数和は",
      ]),
      displayMath(String.raw`\mathcal R_G(a)
=
\frac{
  \displaystyle
  \sum_{m=1}^{|E|}
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}\!\left(m\Omega_G(m)\right)
  \right)
  a^{m-1}
}{
  \overline P_G(a)
}
\in\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`|E|=0`),
        " の場合、分子は空和",
        math(String.raw`0\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "代数的数係数多項式の形式微分を",
        math(String.raw`D:\overline{\mathbb Q}[x]\to\overline{\mathbb Q}[x]`),
        " と書く。すなわち任意の",
        math(String.raw`c\in\overline{\mathbb Q}`),
        " に対して",
        math(String.raw`D(c)=0`),
        " と定め、任意の",
        math(String.raw`m\in\mathbb N_{>0}`),
        " に対して",
        math(String.raw`D(cx^m)=c\,\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(\eta_{\mathbb N,\mathbb Q}(m)\right)x^{m-1}`),
        " と定め、これらの規則を",
        math(String.raw`\overline{\mathbb Q}`),
        " 上線形に拡張する。",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の係数表示を標準単射で移すと、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\sum_{m=0}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
x^m
\quad\bigl(\because\ \text{係数表示を二つの標準単射で移す}\bigr).`),
      paragraph(["直前の多項式恒等式を形式微分すると、"]),
      displayMath(String.raw`D\overline P_G(x)
=
\sum_{m=1}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(m)
\right)
x^{m-1}
\quad\bigl(\because\ \text{有限和の項別形式微分}\bigr).`),
      displayMath(String.raw`D\overline P_G(x)
=
\sum_{m=1}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m\Omega_G(m)\right)
\right)
x^{m-1}
\quad\bigl(\because\ \text{二つの標準単射は積を保つ}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数である。",
        "代数的閉体上の一次因子分解により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\prod_{j=1}^{d}(x-\alpha_j)
\quad\bigl(\because\ \text{代数的閉体上の重複度込み一次因子分解}\bigr).`),
      paragraph(["直前の一次因子分解を形式微分すると、"]),
      displayMath(String.raw`D\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\sum_{k=1}^{d}
\prod_{\substack{1\le j\le d\\j\ne k}}(x-\alpha_j)
\quad\bigl(\because\ \text{有限積の形式微分の積法則}\bigr).`),
      displayMath(String.raw`D\overline P_G(a)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\sum_{k=1}^{d}
\prod_{\substack{1\le j\le d\\j\ne k}}(a-\alpha_j)
\quad\bigl(\because\ \text{直前の多項式恒等式へ }x=a\text{ を代入する}\bigr).`),
      paragraph([ref("def_fisher_zero_algebraic_shifted_reciprocal_sum"), " より、"]),
      displayMath(String.raw`\begin{aligned}
\overline P_G(a)\mathcal R_G(a)
&=
\overline P_G(a)
\sum_{k=1}^{d}\frac{1}{a-\alpha_k}
&&\bigl(\because\ \text{Fisher 零点差の逆数和の定義}\bigr)\\
&=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\prod_{j=1}^{d}(a-\alpha_j)
\sum_{k=1}^{d}\frac{1}{a-\alpha_k}
&&\bigl(\because\ \text{一次因子分解へ }x=a\text{ を代入する}\bigr)\\
&=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\sum_{k=1}^{d}
\frac{
  \displaystyle
  \prod_{j=1}^{d}(a-\alpha_j)
}{
  a-\alpha_k
}
&&\bigl(\because\ \text{有限和に対する分配律}\bigr)\\
&=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\sum_{k=1}^{d}
\prod_{\substack{1\le j\le d\\j\ne k}}(a-\alpha_j)
&&\bigl(\because\ a-\alpha_k\ne0\text{ を各項で消去する}\bigr)\\
&=D\overline P_G(a)
&&\bigl(\because\ \text{評価点における有限積の形式微分}\bigr)\\
&=
\sum_{m=1}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m\Omega_G(m)\right)
\right)
a^{m-1}
&&\bigl(\because\ \text{係数表示の項別形式微分}\bigr).
\end{aligned}`),
      displayMath(String.raw`\mathcal R_G(a)
=
\frac{
  \displaystyle
  \sum_{m=1}^{|E|}
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}\!\left(m\Omega_G(m)\right)
  \right)
  a^{m-1}
}{
  \overline P_G(a)
}
\quad\bigl(\because\ \overline P_G(a)\ne0\text{ を消去する}\bigr).`),
      paragraph([
        "グラフ、スピン配位集合、零点添字集合は有限集合、次数、係数添字、多重度とその積は自然数、分配多項式は整数係数多項式、評価点、Fisher 零点、差、逆数、有限和、評価値と商は代数的数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの代数的評価点における Fisher 零点差の逆二乗和と係数表示" },
    labels: ["theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式を",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        "、その重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。自然数から有理数への標準単射を",
        math(String.raw`\eta_{\mathbb N,\mathbb Q}:\mathbb N\hookrightarrow\mathbb Q`),
        "、有理数から代数的数への標準単射を",
        math(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}:\mathbb Q\hookrightarrow\overline{\mathbb Q}`),
        " と書く。",
        math(String.raw`\overline P_G(a)\ne0`),
        " を満たす代数的評価点",
        math(String.raw`a\in\overline{\mathbb Q}`),
        " について、Fisher 零点差の逆二乗和は",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\frac{1}{(a-\alpha_j)^2}
=
\frac{
  \displaystyle
  \left(
    \sum_{m=1}^{|E|}
    \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
      \eta_{\mathbb N,\mathbb Q}\!\left(m\Omega_G(m)\right)
    \right)
    a^{m-1}
  \right)^2
  -
  \overline P_G(a)
  \displaystyle
  \sum_{m=2}^{|E|}
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)\Omega_G(m)\right)
  \right)
  a^{m-2}
}{
  \overline P_G(a)^2
}
\in\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`|E|=0`),
        " の場合と",
        math(String.raw`|E|=1`),
        " の場合、上端が下端より小さい有限和は空和",
        math(String.raw`0\in\overline{\mathbb Q}`),
        " とする。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_fisher_zero_algebraic_shifted_reciprocal_sum"),
        " の逆数和を",
        math(String.raw`\mathcal R_G(a)\in\overline{\mathbb Q}`),
        " と書く。証明中だけ用いる代数的数を",
      ]),
      displayMath(String.raw`\begin{aligned}
A_G(a)
&:=
\sum_{m=1}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m\Omega_G(m)\right)
\right)
a^{m-1}
\in\overline{\mathbb Q},\\
B_G(a)
&:=
\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)\Omega_G(m)\right)
\right)
a^{m-2}
\in\overline{\mathbb Q},\\
S_{G,2}(a)
&:=
\sum_{j=1}^{d}\frac{1}{(a-\alpha_j)^2}
\in\overline{\mathbb Q}
\end{aligned}`),
      paragraph([
        "と置く。代数的数係数多項式の形式微分を",
        math(String.raw`D:\overline{\mathbb Q}[x]\to\overline{\mathbb Q}[x]`),
        " と書く。すなわち任意の",
        math(String.raw`c\in\overline{\mathbb Q}`),
        " に対して",
        math(String.raw`D(c)=0`),
        " と定め、任意の",
        math(String.raw`m\in\mathbb N_{>0}`),
        " に対して",
        math(String.raw`D(cx^m)=c\,\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(\eta_{\mathbb N,\mathbb Q}(m)\right)x^{m-1}`),
        " と定め、これらの規則を",
        math(String.raw`\overline{\mathbb Q}`),
        " 上線形に拡張する。",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の係数表示を二つの標準単射で移すと、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\sum_{m=0}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
x^m
\quad\bigl(\because\ \text{二つの標準単射で係数を移す}\bigr).`),
      paragraph(["直前の多項式恒等式を一回形式微分すると、"]),
      displayMath(String.raw`D\overline P_G(x)
=
\sum_{m=1}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(m)
\right)
x^{m-1}
\quad\bigl(\because\ \text{有限和の項別形式微分}\bigr).`),
      paragraph(["直前の多項式恒等式をもう一回形式微分すると、"]),
      displayMath(String.raw`D^2\overline P_G(x)
=
\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(m)
\right)
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(m-1)
\right)
x^{m-2}
\quad\bigl(\because\ \text{有限和の項別形式微分}\bigr).`),
      displayMath(String.raw`D^2\overline P_G(x)
=
\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
  \eta_{\mathbb N,\mathbb Q}(m)
  \eta_{\mathbb N,\mathbb Q}(m-1)
\right)
x^{m-2}
\quad\bigl(\because\ \iota_{\mathbb Q,\overline{\mathbb Q}}\text{ は積を保つ}\bigr).`),
      displayMath(String.raw`D^2\overline P_G(x)
=
\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)m(m-1)\right)
\right)
x^{m-2}
\quad\bigl(\because\ \eta_{\mathbb N,\mathbb Q}\text{ は積を保つ}\bigr).`),
      displayMath(String.raw`D^2\overline P_G(x)
=
\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)\Omega_G(m)\right)
\right)
x^{m-2}
\quad\bigl(\because\ \mathbb N\text{ の乗法の結合律と交換律}\bigr).`),
      displayMath(String.raw`D^2\overline P_G(a)
=
\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)\Omega_G(m)\right)
\right)
a^{m-2}
\quad\bigl(\because\ \text{直前の多項式恒等式へ }x=a\text{ を代入する}\bigr).`),
      displayMath(String.raw`\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)\Omega_G(m)\right)
\right)
a^{m-2}
=B_G(a)
\quad\bigl(\because\ B_G(a)\text{ の定義}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数である。代数的閉体上の重複度込み一次因子分解により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\prod_{j=1}^{d}(x-\alpha_j)
\quad\bigl(\because\ \text{代数的閉体上の重複度込み一次因子分解}\bigr).`),
      displayMath(String.raw`\overline P_G(a)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\prod_{j=1}^{d}(a-\alpha_j)
\quad\bigl(\because\ \text{直前の多項式恒等式へ }x=a\text{ を代入する}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\prod_{j=1}^{d}(a-\alpha_j)
\ne0
\quad\bigl(\because\ \overline P_G(a)\ne0\text{ を直前の等式へ代入する}\bigr).`),
      displayMath(String.raw`\prod_{j=1}^{d}(a-\alpha_j)
\ne0
\quad\bigl(\because\ \overline{\mathbb Q}\text{ の零積律の対偶}\bigr).`),
      displayMath(String.raw`a-\alpha_j
\ne0
\qquad(1\le j\le d)
\quad\bigl(\because\ \text{有限積が非零なら各因子は非零}\bigr).`),
      paragraph(["直前の一次因子分解を一回形式微分すると、"]),
      displayMath(String.raw`D\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\prod_{\substack{1\le j\le d\\j\ne k}}(x-\alpha_j)
\quad\bigl(\because\ \text{有限積の形式微分の積法則}\bigr).`),
      paragraph(["直前の多項式恒等式をもう一回形式微分すると、"]),
      displayMath(String.raw`D^2\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell}}(x-\alpha_j)
\quad\bigl(\because\ \text{有限積の形式微分の積法則}\bigr).`),
      displayMath(String.raw`D^2\overline P_G(a)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell}}(a-\alpha_j)
\quad\bigl(\because\ \text{直前の多項式恒等式へ }x=a\text{ を代入する}\bigr).`),
      paragraph([ref("def_fisher_zero_algebraic_shifted_reciprocal_sum"), " より、"]),
      displayMath(String.raw`\begin{aligned}
\overline P_G(a)\!\left(\mathcal R_G(a)^2-S_{G,2}(a)\right)
&=
\overline P_G(a)\!\left(
  \left(\sum_{k=1}^{d}\frac{1}{a-\alpha_k}\right)^2
  -
  S_{G,2}(a)
\right)
&&\bigl(\because\ \text{Fisher 零点差の逆数和の定義}\bigr)\\
&=
\overline P_G(a)\!\left(
  \left(\sum_{k=1}^{d}\frac{1}{a-\alpha_k}\right)^2
  -
  \sum_{k=1}^{d}\frac{1}{(a-\alpha_k)^2}
\right)
&&\bigl(\because\ \text{Fisher 零点差の逆二乗和の定義}\bigr)\\
&=
\overline P_G(a)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\frac{1}{(a-\alpha_k)(a-\alpha_\ell)}
&&\bigl(\because\ \text{有限和の平方を対角項と相異なる順序付き添字対へ分ける}\bigr)\\
&=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\prod_{j=1}^{d}(a-\alpha_j)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\frac{1}{(a-\alpha_k)(a-\alpha_\ell)}
&&\bigl(\because\ \text{一次因子分解へ }x=a\text{ を代入する}\bigr)\\
&=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\frac{
  \displaystyle
  \prod_{j=1}^{d}(a-\alpha_j)
}{
  (a-\alpha_k)(a-\alpha_\ell)
}
&&\bigl(\because\ \text{有限二重和に対する分配律}\bigr)\\
&=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell}}(a-\alpha_j)
&&\bigl(\because\ (a-\alpha_k)(a-\alpha_\ell)\ne0\text{ を各項で消去する}\bigr)\\
&=D^2\overline P_G(a)
&&\bigl(\because\ \text{評価点における有限積の二回の形式微分}\bigr)\\
&=B_G(a)
&&\bigl(\because\ \text{係数表示の二回の項別形式微分}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\mathcal R_G(a)^2-S_{G,2}(a)
&=
\frac{B_G(a)}{\overline P_G(a)}
&&\bigl(\because\ \overline P_G(a)\ne0\text{ を消去する}\bigr)\\
S_{G,2}(a)
&=
\mathcal R_G(a)^2-\frac{B_G(a)}{\overline P_G(a)}
&&\bigl(\because\ \text{移項}\bigr).
\end{aligned}`),
      paragraph([ref("theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio"), " より、"]),
      displayMath(String.raw`\mathcal R_G(a)
=
\frac{
  \displaystyle
  \sum_{m=1}^{|E|}
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}\!\left(m\Omega_G(m)\right)
  \right)
  a^{m-1}
}{
  \overline P_G(a)
}
\quad\bigl(\because\ \text{Fisher 零点差の逆数和の係数表示}\bigr).`),
      displayMath(String.raw`\mathcal R_G(a)
=
\frac{
  A_G(a)
}{
  \overline P_G(a)
}
\quad\bigl(\because\ A_G(a)\text{ の定義}\bigr).`),
      displayMath(String.raw`\begin{aligned}
S_{G,2}(a)
&=
\left(\frac{A_G(a)}{\overline P_G(a)}\right)^2
-
\frac{B_G(a)}{\overline P_G(a)}
&&\bigl(\because\ \text{Fisher 零点差の逆数和の係数表示}\bigr)\\
&=
\frac{A_G(a)^2}{\overline P_G(a)^2}
-
\frac{B_G(a)}{\overline P_G(a)}
&&\bigl(\because\ \text{商の平方}\bigr)\\
&=
\frac{A_G(a)^2-\overline P_G(a)B_G(a)}{\overline P_G(a)^2}
&&\bigl(\because\ \text{共通分母化}\bigr).
\end{aligned}`),
      paragraph([
        "グラフ、スピン配位集合、零点添字集合は有限集合、次数、係数添字、多重度とそれらの積は自然数、分配多項式は整数係数多項式、評価点、Fisher 零点、差、逆数、二乗、有限和、評価値と商は代数的数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの代数的評価点における Fisher 零点差の逆三乗和と係数表示" },
    labels: ["theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式を",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        "、その重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。自然数から有理数への標準単射を",
        math(String.raw`\eta_{\mathbb N,\mathbb Q}:\mathbb N\hookrightarrow\mathbb Q`),
        "、有理数から代数的数への標準単射を",
        math(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}:\mathbb Q\hookrightarrow\overline{\mathbb Q}`),
        " と書き、",
        math(String.raw`q_r:=\iota_{\mathbb Q,\overline{\mathbb Q}}(\eta_{\mathbb N,\mathbb Q}(r))\in\overline{\mathbb Q}`),
        " を",
        math(String.raw`r\in\{1,2,3\}`),
        " に対して定める。",
        math(String.raw`\overline P_G(a)\ne0`),
        " を満たす",
        math(String.raw`a\in\overline{\mathbb Q}`),
        " について、次の三つの代数的数を定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
A_G(a)
&:=
\sum_{m=1}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m\Omega_G(m)\right)
\right)
a^{m-1},\\
B_G(a)
&:=
\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)\Omega_G(m)\right)
\right)
a^{m-2},\\
C_G(a)
&:=
\sum_{m=3}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)(m-2)\Omega_G(m)\right)
\right)
a^{m-3}
\end{aligned}`),
      paragraph([
        "上端が下端より小さい有限和は空和",
        math(String.raw`0\in\overline{\mathbb Q}`),
        " とする。このとき Fisher 零点差の逆三乗和は",
      ]),
      displayMath(String.raw`\sum_{j=1}^{d}\frac{1}{(a-\alpha_j)^3}
=
\frac{
  \displaystyle
  q_2 A_G(a)^3
  -q_3\overline P_G(a)A_G(a)B_G(a)
  +\overline P_G(a)^2C_G(a)
}{
  q_2\overline P_G(a)^3
}
\in\overline{\mathbb Q}.`),
    ],
    proof: [
      paragraph([
        "代数的数係数多項式の形式微分を",
        math(String.raw`D:\overline{\mathbb Q}[x]\to\overline{\mathbb Q}[x]`),
        " と書く。すなわち任意の",
        math(String.raw`c\in\overline{\mathbb Q}`),
        " に対して",
        math(String.raw`D(c)=0`),
        " と定め、任意の",
        math(String.raw`m\in\mathbb N_{>0}`),
        " に対して",
        math(String.raw`D(cx^m)=c\,\iota_{\mathbb Q,\overline{\mathbb Q}}(\eta_{\mathbb N,\mathbb Q}(m))x^{m-1}`),
        " と定め、これらの規則を",
        math(String.raw`\overline{\mathbb Q}`),
        " 上線形に拡張する。整数係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\mathbb Q[x]}:\mathbb Z[x]\hookrightarrow\mathbb Q[x]`),
        " で移した多項式を",
        math(String.raw`P_G^{\mathbb Q}(x):=\iota_{\mathbb Z[x],\mathbb Q[x]}(Z_G(x))\in\mathbb Q[x]`),
        " と書く。",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の係数表示を自然数から有理数への標準単射で移すと、",
      ]),
      displayMath(String.raw`P_G^{\mathbb Q}(x)
=
\sum_{m=0}^{|E|}
\eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)x^m
\quad\bigl(\because\ \iota_{\mathbb Z[x],\mathbb Q[x]}\text{ で係数を移す}\bigr).`),
      paragraph([
        "有理数係数多項式から代数的数係数多項式への標準単射を",
        math(String.raw`\iota_{\mathbb Q[x],\overline{\mathbb Q}[x]}:\mathbb Q[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " と書く。標準単射の合成により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=\iota_{\mathbb Q[x],\overline{\mathbb Q}[x]}\!\left(P_G^{\mathbb Q}(x)\right)
\quad\bigl(\because\ \iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}
=\iota_{\mathbb Q[x],\overline{\mathbb Q}[x]}\circ\iota_{\mathbb Z[x],\mathbb Q[x]}\bigr).`),
      displayMath(String.raw`\overline P_G(x)
=
\sum_{m=0}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
x^m
\quad\bigl(\because\ \iota_{\mathbb Q[x],\overline{\mathbb Q}[x]}\text{ を係数ごとに適用する}\bigr).`),
      paragraph(["直前の多項式恒等式を一回形式微分すると、"]),
      displayMath(String.raw`D\overline P_G(x)
=
\sum_{m=1}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(m)
\right)
x^{m-1}
\quad\bigl(\because\ \text{有限和の項別形式微分}\bigr).`),
      paragraph(["直前の多項式恒等式をもう一回形式微分すると、"]),
      displayMath(String.raw`D^2\overline P_G(x)
=
\sum_{m=2}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(m)
\right)
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(m-1)
\right)
x^{m-2}
\quad\bigl(\because\ \text{有限和の項別形式微分}\bigr).`),
      paragraph(["直前の多項式恒等式をもう一回形式微分すると、"]),
      displayMath(String.raw`D^3\overline P_G(x)
=
\sum_{m=3}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
\right)
\prod_{r=0}^{2}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(m-r)
\right)
x^{m-3}
\quad\bigl(\because\ \text{有限和の項別形式微分}\bigr).`),
      displayMath(String.raw`D^3\overline P_G(x)
=
\sum_{m=3}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)\right)
  \prod_{r=0}^{2}
  \eta_{\mathbb N,\mathbb Q}(m-r)
\right)
x^{m-3}
\quad\bigl(\because\ \iota_{\mathbb Q,\overline{\mathbb Q}}\text{ は有限積を保つ}\bigr).`),
      displayMath(String.raw`D^3\overline P_G(x)
=
\sum_{m=3}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(
    \Omega_G(m)
    \prod_{r=0}^{2}(m-r)
  \right)
\right)
x^{m-3}
\quad\bigl(\because\ \eta_{\mathbb N,\mathbb Q}\text{ は有限積を保つ}\bigr).`),
      displayMath(String.raw`D^3\overline P_G(x)
=
\sum_{m=3}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(m)m(m-1)(m-2)\right)
\right)
x^{m-3}
\quad\bigl(\because\ \text{有限積を展開する}\bigr).`),
      displayMath(String.raw`D^3\overline P_G(x)
=
\sum_{m=3}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)(m-2)\Omega_G(m)\right)
\right)
x^{m-3}
\quad\bigl(\because\ \mathbb N\text{ の乗法の交換律}\bigr).`),
      displayMath(String.raw`D^3\overline P_G(a)
=
\sum_{m=3}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)(m-2)\Omega_G(m)\right)
\right)
a^{m-3}
\quad\bigl(\because\ \text{直前の多項式恒等式へ }x=a\text{ を代入する}\bigr).`),
      displayMath(String.raw`\sum_{m=3}^{|E|}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(m(m-1)(m-2)\Omega_G(m)\right)
\right)
a^{m-3}
=C_G(a)
\quad\bigl(\because\ C_G(a)\text{ の定義}\bigr).`),
      displayMath(String.raw`D^3\overline P_G(a)=C_G(a)
\quad\bigl(\because\ \text{直前の二つの等式の推移律}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数である。代数的閉体上の重複度込み一次因子分解により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\prod_{j=1}^{d}(x-\alpha_j)
\quad\bigl(\because\ \text{代数的閉体上の重複度込み一次因子分解}\bigr).`),
      displayMath(String.raw`\overline P_G(a)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\prod_{j=1}^{d}(a-\alpha_j)
\quad\bigl(\because\ \text{直前の多項式恒等式へ }x=a\text{ を代入する}\bigr).`),
      displayMath(String.raw`\Omega_G(d)\ne0
\quad\bigl(\because\ \Omega_G(d)>0\bigr).`),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\ne0
\quad\bigl(\because\ \eta_{\mathbb N,\mathbb Q}\text{ は単射である}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\ne0
\quad\bigl(\because\ \iota_{\mathbb Q,\overline{\mathbb Q}}\text{ は単射である}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\prod_{j=1}^{d}(a-\alpha_j)
\ne0
\quad\bigl(\because\ \overline P_G(a)\ne0\text{ を直前の等式へ代入する}\bigr).`),
      displayMath(String.raw`\prod_{j=1}^{d}(a-\alpha_j)
\ne0
\quad\bigl(\because\ \overline{\mathbb Q}\text{ の零積律の対偶}\bigr).`),
      displayMath(String.raw`a-\alpha_j\ne0
\qquad(1\le j\le d)
\quad\bigl(\because\ \text{有限積が非零なら各因子は非零}\bigr).`),
      paragraph([
        ref("def_fisher_zero_algebraic_shifted_reciprocal_sum"),
        " の逆数和を",
        math(String.raw`\mathcal R_G(a)\in\overline{\mathbb Q}`),
        " と書き、証明中だけ用いる代数的数を",
      ]),
      displayMath(String.raw`\begin{aligned}
S_{G,2}(a)
&:=\sum_{j=1}^{d}\frac{1}{(a-\alpha_j)^2}
\in\overline{\mathbb Q},\\
S_{G,3}(a)
&:=\sum_{j=1}^{d}\frac{1}{(a-\alpha_j)^3}
\in\overline{\mathbb Q},\\
U_{G,2,1}(a)
&:=
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\frac{1}{(a-\alpha_k)^2(a-\alpha_\ell)}
\in\overline{\mathbb Q},\\
V_{G,1,2}(a)
&:=
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\frac{1}{(a-\alpha_k)(a-\alpha_\ell)^2}
\in\overline{\mathbb Q},\\
T_{G,3}(a)
&:=
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\sum_{\substack{1\le h\le d\\h\ne k,\ h\ne\ell}}
\frac{1}{(a-\alpha_k)(a-\alpha_\ell)(a-\alpha_h)}
\in\overline{\mathbb Q}
\end{aligned}`),
      paragraph([
        "と置く。直前に示した",
        math(String.raw`a-\alpha_j\ne0`),
        "により、すべての逆数と有限和は",
        math(String.raw`\overline{\mathbb Q}`),
        " 内で定義される。",
      ]),
      paragraph(["一次因子分解を一回形式微分すると、"]),
      displayMath(String.raw`D\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\prod_{\substack{1\le j\le d\\j\ne k}}(x-\alpha_j)
\quad\bigl(\because\ \text{有限積の形式微分の積法則}\bigr).`),
      paragraph(["直前の多項式恒等式をもう一回形式微分すると、"]),
      displayMath(String.raw`D^2\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell}}(x-\alpha_j)
\quad\bigl(\because\ \text{有限積の形式微分の積法則}\bigr).`),
      paragraph(["直前の多項式恒等式をもう一回形式微分すると、"]),
      displayMath(String.raw`D^3\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\sum_{\substack{1\le h\le d\\h\ne k,\ h\ne\ell}}
\prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell,\ j\ne h}}(x-\alpha_j)
\quad\bigl(\because\ \text{有限積の形式微分の積法則}\bigr).`),
      displayMath(String.raw`D^3\overline P_G(a)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
\right)
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\sum_{\substack{1\le h\le d\\h\ne k,\ h\ne\ell}}
\prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell,\ j\ne h}}(a-\alpha_j)
\quad\bigl(\because\ \text{直前の多項式恒等式へ }x=a\text{ を代入する}\bigr).`),
      displayMath(String.raw`\frac{D^3\overline P_G(a)}{\overline P_G(a)}
=
\frac{
  \displaystyle
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
  \right)
  \sum_{k=1}^{d}
  \sum_{\substack{1\le\ell\le d\\\ell\ne k}}
  \sum_{\substack{1\le h\le d\\h\ne k,\ h\ne\ell}}
  \prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell,\ j\ne h}}(a-\alpha_j)
}{
  \displaystyle
  \overline P_G(a)
}
\quad\bigl(\because\ \text{三回形式微分式を分子へ代入する}\bigr).`),
      displayMath(String.raw`\frac{D^3\overline P_G(a)}{\overline P_G(a)}
=
\frac{
  \displaystyle
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
  \right)
  \sum_{k=1}^{d}
  \sum_{\substack{1\le\ell\le d\\\ell\ne k}}
  \sum_{\substack{1\le h\le d\\h\ne k,\ h\ne\ell}}
  \prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell,\ j\ne h}}(a-\alpha_j)
}{
  \displaystyle
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}\!\left(\Omega_G(d)\right)
  \right)
  \prod_{j=1}^{d}(a-\alpha_j)
}
\quad\bigl(\because\ \text{一次因子分解を分母へ代入する}\bigr).`),
      displayMath(String.raw`\frac{D^3\overline P_G(a)}{\overline P_G(a)}
=
\frac{
  \displaystyle
  \sum_{k=1}^{d}
  \sum_{\substack{1\le\ell\le d\\\ell\ne k}}
  \sum_{\substack{1\le h\le d\\h\ne k,\ h\ne\ell}}
  \prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell,\ j\ne h}}(a-\alpha_j)
}{
  \displaystyle
  \prod_{j=1}^{d}(a-\alpha_j)
}
\quad\bigl(\because\ \iota_{\mathbb Q,\overline{\mathbb Q}}(\eta_{\mathbb N,\mathbb Q}(\Omega_G(d)))\ne0\text{ を消去する}\bigr).`),
      displayMath(String.raw`\frac{D^3\overline P_G(a)}{\overline P_G(a)}
=
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\sum_{\substack{1\le h\le d\\h\ne k,\ h\ne\ell}}
\frac{
  \displaystyle
  \prod_{\substack{1\le j\le d\\j\ne k,\ j\ne\ell,\ j\ne h}}(a-\alpha_j)
}{
  \displaystyle
  \prod_{j=1}^{d}(a-\alpha_j)
}
\quad\bigl(\because\ \text{有限三重和に対する分配律}\bigr).`),
      displayMath(String.raw`\frac{D^3\overline P_G(a)}{\overline P_G(a)}
=
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\sum_{\substack{1\le h\le d\\h\ne k,\ h\ne\ell}}
\frac{1}{(a-\alpha_k)(a-\alpha_\ell)(a-\alpha_h)}
\quad\bigl(\because\ \text{各項で三つの非零因子を消去する}\bigr).`),
      displayMath(String.raw`\frac{D^3\overline P_G(a)}{\overline P_G(a)}
=T_{G,3}(a)
\quad\bigl(\because\ T_{G,3}(a)\text{ の定義}\bigr).`),
      paragraph([ref("def_fisher_zero_algebraic_shifted_reciprocal_sum"), " より、"]),
      displayMath(String.raw`\begin{aligned}
\mathcal R_G(a)S_{G,2}(a)
&=
\left(
  \sum_{k=1}^{d}\frac{1}{a-\alpha_k}
\right)
S_{G,2}(a)
&&\bigl(\because\ \text{Fisher 零点差の逆数和の定義}\bigr)\\
&=
\left(
  \sum_{k=1}^{d}\frac{1}{a-\alpha_k}
\right)
\left(
  \sum_{\ell=1}^{d}\frac{1}{(a-\alpha_\ell)^2}
\right)
&&\bigl(\because\ S_{G,2}(a)\text{ の定義}\bigr)\\
&=
\sum_{k=1}^{d}
\sum_{\ell=1}^{d}
\frac{1}{(a-\alpha_k)(a-\alpha_\ell)^2}
&&\bigl(\because\ \text{有限和に対する分配律}\bigr)\\
&=
S_{G,3}(a)
+
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\frac{1}{(a-\alpha_k)(a-\alpha_\ell)^2}
&&\bigl(\because\ \text{有限二重和を対角項と非対角項へ分ける}\bigr)\\
&=
S_{G,3}(a)
+
\sum_{k=1}^{d}
\sum_{\substack{1\le\ell\le d\\\ell\ne k}}
\frac{1}{(a-\alpha_k)^2(a-\alpha_\ell)}
&&\bigl(\because\ \text{非対角項の添字 }k,\ell\text{ を交換する}\bigr)\\
&=
S_{G,3}(a)+U_{G,2,1}(a)
&&\bigl(\because\ U_{G,2,1}(a)\text{ の定義}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\mathcal R_G(a)^3
&=
\left(
  \sum_{k=1}^{d}\frac{1}{a-\alpha_k}
\right)^3
&&\bigl(\because\ \text{Fisher 零点差の逆数和の定義}\bigr)\\
&=
\sum_{k=1}^{d}
\sum_{\ell=1}^{d}
\sum_{h=1}^{d}
\frac{1}{(a-\alpha_k)(a-\alpha_\ell)(a-\alpha_h)}
&&\bigl(\because\ \text{有限和に対する分配律}\bigr)\\
&=
S_{G,3}(a)
+U_{G,2,1}(a)
+U_{G,2,1}(a)
+V_{G,1,2}(a)
+T_{G,3}(a)
&&\bigl(\because\ \text{有限三重和を添字の一致型ごとに分ける}\bigr).
\end{aligned}`),
      displayMath(String.raw`V_{G,1,2}(a)
=U_{G,2,1}(a)
\quad\bigl(\because\ \text{非対角項の添字 }k,\ell\text{ を交換する}\bigr).`),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}(1)=1_{\mathbb Q}
\quad\bigl(\because\ \eta_{\mathbb N,\mathbb Q}\text{ は乗法単位元を保つ}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(1)
\right)
=1_{\overline{\mathbb Q}}
\quad\bigl(\because\ \iota_{\mathbb Q,\overline{\mathbb Q}}\text{ は乗法単位元を保つ}\bigr).`),
      displayMath(String.raw`q_1=1_{\overline{\mathbb Q}}
\quad\bigl(\because\ q_1\text{ の定義}\bigr).`),
      displayMath(String.raw`3=1+1+1
\quad\text{in }\mathbb N
\quad\bigl(\because\ \mathbb N\text{ の加法}\bigr).`),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}(3)
=\eta_{\mathbb N,\mathbb Q}(1+1+1)
\quad\bigl(\because\ \text{直前の等式へ }\eta_{\mathbb N,\mathbb Q}\text{ を適用する}\bigr).`),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}(3)
=\eta_{\mathbb N,\mathbb Q}(1)
+\eta_{\mathbb N,\mathbb Q}(1)
+\eta_{\mathbb N,\mathbb Q}(1)
\quad\bigl(\because\ \eta_{\mathbb N,\mathbb Q}\text{ は有限和を保つ}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(3)
\right)
=\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(1)
  +\eta_{\mathbb N,\mathbb Q}(1)
  +\eta_{\mathbb N,\mathbb Q}(1)
\right)
\quad\bigl(\because\ \text{直前の等式へ }\iota_{\mathbb Q,\overline{\mathbb Q}}\text{ を適用する}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(3)
\right)
=\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(1)
\right)
+\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(1)
\right)
+\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(1)
\right)
\quad\bigl(\because\ \iota_{\mathbb Q,\overline{\mathbb Q}}\text{ は有限和を保つ}\bigr).`),
      displayMath(String.raw`q_3=q_1+q_1+q_1
\quad\bigl(\because\ q_1,q_3\text{ の定義}\bigr).`),
      displayMath(String.raw`\mathcal R_G(a)^3
=
S_{G,3}(a)
+U_{G,2,1}(a)
+U_{G,2,1}(a)
+U_{G,2,1}(a)
+T_{G,3}(a)
\quad\bigl(\because\ V_{G,1,2}(a)=U_{G,2,1}(a)\text{ を代入する}\bigr).`),
      displayMath(String.raw`U_{G,2,1}(a)
+U_{G,2,1}(a)
+U_{G,2,1}(a)
=q_1U_{G,2,1}(a)
+q_1U_{G,2,1}(a)
+q_1U_{G,2,1}(a)
\quad\bigl(\because\ q_1=1_{\overline{\mathbb Q}}\text{ を同じ三項へ適用する}\bigr).`),
      displayMath(String.raw`q_1U_{G,2,1}(a)
+q_1U_{G,2,1}(a)
+q_1U_{G,2,1}(a)
=\left(q_1+q_1+q_1\right)U_{G,2,1}(a)
\quad\bigl(\because\ \text{分配律}\bigr).`),
      displayMath(String.raw`\left(q_1+q_1+q_1\right)U_{G,2,1}(a)
=q_3U_{G,2,1}(a)
\quad\bigl(\because\ q_3=q_1+q_1+q_1\text{ を代入する}\bigr).`),
      displayMath(String.raw`\mathcal R_G(a)^3
=
S_{G,3}(a)
+q_3U_{G,2,1}(a)
+T_{G,3}(a)
\quad\bigl(\because\ \text{直前の等式を代入する}\bigr).`),
      displayMath(String.raw`\mathcal R_G(a)^3-S_{G,3}(a)
=q_3U_{G,2,1}(a)+T_{G,3}(a)
\quad\bigl(\because\ \text{直前の一致型分解の両辺から }S_{G,3}(a)\text{ を引く}\bigr).`),
      displayMath(String.raw`\mathcal R_G(a)^3-S_{G,3}(a)-q_3U_{G,2,1}(a)
=T_{G,3}(a)
\quad\bigl(\because\ \text{直前の等式の両辺から }q_3U_{G,2,1}(a)\text{ を引く}\bigr).`),
      displayMath(String.raw`T_{G,3}(a)
=\mathcal R_G(a)^3-S_{G,3}(a)-q_3U_{G,2,1}(a)
\quad\bigl(\because\ \text{直前の等式の対称律}\bigr).`),
      displayMath(String.raw`U_{G,2,1}(a)
=\mathcal R_G(a)S_{G,2}(a)-S_{G,3}(a)
\quad\bigl(\because\ \mathcal R_G(a)S_{G,2}(a)=S_{G,3}(a)+U_{G,2,1}(a)\text{ から移項する}\bigr).`),
      displayMath(String.raw`T_{G,3}(a)
=
\mathcal R_G(a)^3
-S_{G,3}(a)
-q_3\left(\mathcal R_G(a)S_{G,2}(a)-S_{G,3}(a)\right)
\quad\bigl(\because\ U_{G,2,1}(a)\text{ の式を代入する}\bigr).`),
      displayMath(String.raw`T_{G,3}(a)
=
\mathcal R_G(a)^3
-S_{G,3}(a)
-q_3\mathcal R_G(a)S_{G,2}(a)
+q_3S_{G,3}(a)
\quad\bigl(\because\ \text{分配律}\bigr).`),
      displayMath(String.raw`T_{G,3}(a)
=
\mathcal R_G(a)^3
-q_3\mathcal R_G(a)S_{G,2}(a)
+q_3S_{G,3}(a)
-S_{G,3}(a)
\quad\bigl(\because\ \overline{\mathbb Q}\text{ の加法の交換律}\bigr).`),
      displayMath(String.raw`T_{G,3}(a)
=
\mathcal R_G(a)^3
-q_3\mathcal R_G(a)S_{G,2}(a)
+(q_3-1_{\overline{\mathbb Q}})S_{G,3}(a)
\quad\bigl(\because\ \text{分配律}\bigr).`),
      displayMath(String.raw`3=1+2
\quad\text{in }\mathbb N
\quad\bigl(\because\ \mathbb N\text{ の加法}\bigr).`),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}(3)
=\eta_{\mathbb N,\mathbb Q}(1+2)
\quad\bigl(\because\ \text{直前の等式へ }\eta_{\mathbb N,\mathbb Q}\text{ を適用する}\bigr).`),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}(3)
=\eta_{\mathbb N,\mathbb Q}(1)+\eta_{\mathbb N,\mathbb Q}(2)
\quad\bigl(\because\ \eta_{\mathbb N,\mathbb Q}\text{ は加法を保つ}\bigr).`),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}(3)-\eta_{\mathbb N,\mathbb Q}(1)
=\eta_{\mathbb N,\mathbb Q}(2)
\quad\bigl(\because\ \mathbb Q\text{ の加法で移項する}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(3)-\eta_{\mathbb N,\mathbb Q}(1)
\right)
=\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(2)
\right)
\quad\bigl(\because\ \text{直前の等式へ }\iota_{\mathbb Q,\overline{\mathbb Q}}\text{ を適用する}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(3)
\right)
-\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(1)
\right)
=\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(2)
\right)
\quad\bigl(\because\ \iota_{\mathbb Q,\overline{\mathbb Q}}\text{ は差を保つ}\bigr).`),
      displayMath(String.raw`q_3-q_1=q_2
\quad\bigl(\because\ q_1,q_2,q_3\text{ の定義}\bigr).`),
      displayMath(String.raw`q_3-1_{\overline{\mathbb Q}}=q_3-q_1
\quad\bigl(\because\ q_1=1_{\overline{\mathbb Q}}\text{ を代入する}\bigr).`),
      displayMath(String.raw`q_3-1_{\overline{\mathbb Q}}=q_2
\quad\bigl(\because\ \text{直前の二つの等式の推移律}\bigr).`),
      displayMath(String.raw`T_{G,3}(a)
=
\mathcal R_G(a)^3
-q_3\mathcal R_G(a)S_{G,2}(a)
+q_2S_{G,3}(a)
\quad\bigl(\because\ q_3-1_{\overline{\mathbb Q}}=q_2\text{ を代入する}\bigr).`),
      displayMath(String.raw`\frac{C_G(a)}{\overline P_G(a)}
=T_{G,3}(a)
\quad\bigl(\because\ D^3\overline P_G(a)/\overline P_G(a)=T_{G,3}(a)\text{ へ }D^3\overline P_G(a)=C_G(a)\text{ を代入する}\bigr).`),
      displayMath(String.raw`\frac{C_G(a)}{\overline P_G(a)}
=
\mathcal R_G(a)^3
-q_3\mathcal R_G(a)S_{G,2}(a)
+q_2S_{G,3}(a)
\quad\bigl(\because\ \text{直前の二つの等式の推移律}\bigr).`),
      displayMath(String.raw`\frac{C_G(a)}{\overline P_G(a)}
-\mathcal R_G(a)^3
=
-q_3\mathcal R_G(a)S_{G,2}(a)
+q_2S_{G,3}(a)
\quad\bigl(\because\ \text{直前の等式の両辺から }\mathcal R_G(a)^3\text{ を引く}\bigr).`),
      displayMath(String.raw`\frac{C_G(a)}{\overline P_G(a)}
-\mathcal R_G(a)^3
+q_3\mathcal R_G(a)S_{G,2}(a)
=q_2S_{G,3}(a)
\quad\bigl(\because\ \text{直前の等式の両辺へ }q_3\mathcal R_G(a)S_{G,2}(a)\text{ を加える}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{C_G(a)}{\overline P_G(a)}
-\mathcal R_G(a)^3
+q_3\mathcal R_G(a)S_{G,2}(a)
\quad\bigl(\because\ \text{直前の等式の対称律}\bigr).`),
      paragraph([ref("theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio"), " より、"]),
      displayMath(String.raw`\mathcal R_G(a)
=\frac{A_G(a)}{\overline P_G(a)}
\quad\bigl(\because\ \text{Fisher 零点差の逆数和の係数表示}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{C_G(a)}{\overline P_G(a)}
-\left(\frac{A_G(a)}{\overline P_G(a)}\right)^3
+q_3\frac{A_G(a)}{\overline P_G(a)}S_{G,2}(a)
\quad\bigl(\because\ \text{直前の等式を代入する}\bigr).`),
      paragraph([ref("theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio"), " より、"]),
      displayMath(String.raw`S_{G,2}(a)
=
\frac{A_G(a)^2-\overline P_G(a)B_G(a)}{\overline P_G(a)^2}
\quad\bigl(\because\ \text{Fisher 零点差の逆二乗和の係数表示}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{C_G(a)}{\overline P_G(a)}
-\left(\frac{A_G(a)}{\overline P_G(a)}\right)^3
+q_3\frac{A_G(a)}{\overline P_G(a)}
\frac{A_G(a)^2-\overline P_G(a)B_G(a)}{\overline P_G(a)^2}
\quad\bigl(\because\ \text{直前の等式を代入する}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{C_G(a)}{\overline P_G(a)}
-\frac{A_G(a)^3}{\overline P_G(a)^3}
+q_3\frac{A_G(a)}{\overline P_G(a)}
\frac{A_G(a)^2-\overline P_G(a)B_G(a)}{\overline P_G(a)^2}
\quad\bigl(\because\ \text{商の三乗則}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{C_G(a)}{\overline P_G(a)}
-\frac{A_G(a)^3}{\overline P_G(a)^3}
+q_3\frac{
  A_G(a)\left(A_G(a)^2-\overline P_G(a)B_G(a)\right)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ \text{商の積の法則}\bigr).`),
      displayMath(String.raw`\overline P_G(a)^2\ne0
\quad\bigl(\because\ \overline P_G(a)\ne0\text{ と }\overline{\mathbb Q}\text{ の零積律}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{\overline P_G(a)^2C_G(a)}{\overline P_G(a)^3}
-\frac{A_G(a)^3}{\overline P_G(a)^3}
+q_3\frac{
  A_G(a)\left(A_G(a)^2-\overline P_G(a)B_G(a)\right)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ \text{直前の非零な }\overline P_G(a)^2\text{ を第一項の分母と分子へ掛ける}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{
  \overline P_G(a)^2C_G(a)
  -A_G(a)^3
  +q_3A_G(a)\left(A_G(a)^2-\overline P_G(a)B_G(a)\right)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ \text{同じ分母を持つ三つの商を結合する}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{
  \overline P_G(a)^2C_G(a)
  -q_1A_G(a)^3
  +q_3A_G(a)\left(A_G(a)^2-\overline P_G(a)B_G(a)\right)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ q_1=1_{\overline{\mathbb Q}}\text{ を代入する}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{
  \overline P_G(a)^2C_G(a)
  -q_1A_G(a)^3
  +q_3A_G(a)^3
  -q_3\overline P_G(a)A_G(a)B_G(a)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ \text{分配律}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{
  -q_1A_G(a)^3
  +q_3A_G(a)^3
  -q_3\overline P_G(a)A_G(a)B_G(a)
  +\overline P_G(a)^2C_G(a)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ \overline{\mathbb Q}\text{ の加法の交換律}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{
  (q_3-q_1)A_G(a)^3
  -q_3\overline P_G(a)A_G(a)B_G(a)
  +\overline P_G(a)^2C_G(a)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ \text{分配律}\bigr).`),
      displayMath(String.raw`q_2S_{G,3}(a)
=
\frac{
  q_2A_G(a)^3
  -q_3\overline P_G(a)A_G(a)B_G(a)
  +\overline P_G(a)^2C_G(a)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ q_3-q_1=q_2\text{ を代入する}\bigr).`),
      displayMath(String.raw`2\in\mathbb N_{>0}
\quad\bigl(\because\ \mathbb N_{>0}\text{ の定義}\bigr).`),
      displayMath(String.raw`2\ne0
\quad\bigl(\because\ \mathbb N_{>0}\text{ の元は零でない}\bigr).`),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}(2)\ne0
\quad\bigl(\because\ \eta_{\mathbb N,\mathbb Q}\text{ は単射である}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(2)
\right)
\ne0
\quad\bigl(\because\ \iota_{\mathbb Q,\overline{\mathbb Q}}\text{ は単射である}\bigr).`),
      displayMath(String.raw`q_2\ne0
\quad\bigl(\because\ q_2\text{ の定義}\bigr).`),
      displayMath(String.raw`S_{G,3}(a)
=
\frac{1}{q_2}
\frac{
  q_2A_G(a)^3
  -q_3\overline P_G(a)A_G(a)B_G(a)
  +\overline P_G(a)^2C_G(a)
}{
  \overline P_G(a)^3
}
\quad\bigl(\because\ q_2\ne0\text{ を消去する}\bigr).`),
      displayMath(String.raw`S_{G,3}(a)
=
\frac{
  q_2A_G(a)^3
  -q_3\overline P_G(a)A_G(a)B_G(a)
  +\overline P_G(a)^2C_G(a)
}{
  q_2\overline P_G(a)^3
}
\quad\bigl(\because\ \overline{\mathbb Q}\text{ の商の結合律}\bigr).`),
      displayMath(String.raw`\sum_{j=1}^{d}\frac{1}{(a-\alpha_j)^3}
=S_{G,3}(a)
\quad\bigl(\because\ S_{G,3}(a)\text{ の定義}\bigr).`),
      displayMath(String.raw`\sum_{j=1}^{d}\frac{1}{(a-\alpha_j)^3}
=
\frac{
  q_2A_G(a)^3
  -q_3\overline P_G(a)A_G(a)B_G(a)
  +\overline P_G(a)^2C_G(a)
}{
  q_2\overline P_G(a)^3
}
\quad\bigl(\because\ \text{直前の二つの等式の推移律}\bigr).`),
      paragraph([
        "グラフ、スピン配位集合、零点添字集合は有限集合、次数、係数添字、多重度とそれらの積は自然数、分配多項式は整数係数多項式、評価点、Fisher 零点、差、逆数、三乗、有限和、評価値と商は代数的数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_rational_shifted_product_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点と有理評価点との差の積" },
    labels: ["theorem_fisher_zero_rational_shifted_product_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-rational-shifted-product-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。自然数から有理数への標準単射を",
        math(String.raw`\eta_{\mathbb N,\mathbb Q}:\mathbb N\hookrightarrow\mathbb Q`),
        "、有理数から代数的数への標準単射を",
        math(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}:\mathbb Q\hookrightarrow\overline{\mathbb Q}`),
        " と書く。整数係数を有理数へ移した",
        math(String.raw`Z_G(x)`),
        " の、任意の有理数",
        math(String.raw`q\in\mathbb Q`),
        " における値を",
        math(String.raw`Z_G(q)\in\mathbb Q`),
        " と書く。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}\left(\iota_{\mathbb Q,\overline{\mathbb Q}}(q)-\alpha_j\right)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \frac{
    Z_G(q)
  }{
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  }
\right)
\in\iota_{\mathbb Q,\overline{\mathbb Q}}(\mathbb Q)
\subset\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`d=0`),
        " の場合、左辺は空積",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"),
        " と",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " より、",
        math(String.raw`\Omega_G(d)\in\mathbb N_{>0}`),
        " は最高次係数である。標準単射で係数を移した多項式を",
        math(String.raw`\overline P_G(x)\in\overline{\mathbb Q}[x]`),
        " と書く。代数的閉体上の一次因子分解により、",
      ]),
      displayMath(String.raw`\overline P_G(x)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\prod_{j=1}^{d}(x-\alpha_j).`),
      displayMath(String.raw`\begin{aligned}
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(Z_G(q)\right)
&=\overline P_G\!\left(\iota_{\mathbb Q,\overline{\mathbb Q}}(q)\right)
&&\bigl(\because\ \text{係数の標準単射と評価は可換する}\bigr)\\
&=\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
\right)
\prod_{j=1}^{d}\left(\iota_{\mathbb Q,\overline{\mathbb Q}}(q)-\alpha_j\right)
&&\bigl(\because\ \text{一次因子分解へ }x=\iota_{\mathbb Q,\overline{\mathbb Q}}(q)\text{ を代入する}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\eta_{\mathbb N,\mathbb Q}(\Omega_G(d))\ne0`),
        " かつ標準単射は零でない元を零でない元へ移すので、代数的数の体で最高次係数を消去すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{d}\left(\iota_{\mathbb Q,\overline{\mathbb Q}}(q)-\alpha_j\right)
&=
\frac{
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(Z_G(q)\right)
}{
  \iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  \right)
}
&&\bigl(\because\ \text{零でない最高次係数を消去する}\bigr)\\
&=\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \frac{
    Z_G(q)
  }{
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  }
\right)
&&\bigl(\because\ \text{標準単射は商を保存する}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`Z_G(q)\in\mathbb Q,\quad \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))\in\mathbb Q_{>0}`),
        " なので、単射の引数である係数比は有理数に属する。評価点と係数比は有理数、その標準単射像、Fisher 零点、差、有限積は代数的数、次数と多重度は自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_no_positive_rational_root",
    kind: "theorem",
    title: { text: "Ising 分配多項式の正の有理評価の二配位下界" },
    labels: ["theorem_no_positive_rational_root"],
    habitat: "Q",
    verification: ["sagemath/check/no-positive-rational-root"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の任意の有限グラフと任意の正の有理数 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " について",
      ]),
      displayMath(String.raw`Z_G(q)\ge 2\quad\text{in }\mathbb Q.`),
      paragraph([
        "特に、正の有理数は Ising 分配多項式の零点ではない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の整数係数を自然数から有理数への標準単射で移し、",
        math(String.raw`x=q`),
        " を代入すると",
      ]),
      displayMath(String.raw`Z_G(q)
=\sum_{m=0}^{|E|}\Omega_G(m)q^m
\quad\bigl(\because\ \text{多重度による係数表示}\bigr).`),
      paragraph([
        "二つの配位 ",
        math(String.raw`\sigma_{\mathsf{up}},\sigma_{\mathsf{down}}:V\to\mathsf{Spin}`),
        " を全ての ",
        math(String.raw`v\in V`),
        " について ",
        math(String.raw`\sigma_{\mathsf{up}}(v):=\mathsf{up}`),
        " および ",
        math(String.raw`\sigma_{\mathsf{down}}(v):=\mathsf{down}`),
        " と定める。",
        ref("def_spin_configuration_set"),
        " より",
      ]),
      displayMath(String.raw`\sigma_{\mathsf{up}},\sigma_{\mathsf{down}}\in\mathcal S_G
\quad\bigl(\because\ \text{いずれも }V\text{ から }\mathsf{Spin}\text{ への写像である}\bigr).`),
      paragraph([
        ref("def_finite_graph_input"),
        " より ",
        math(String.raw`V`),
        " は空でないので、ある ",
        math(String.raw`v_*\in V`),
        " を選ぶ。すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\sigma_{\mathsf{up}}(v_*)
&=\mathsf{up}
&&\bigl(\because\ \sigma_{\mathsf{up}}\text{ の定義}\bigr)\\
&\ne\mathsf{down}
&&\bigl(\because\ \mathsf{up}\ne\mathsf{down}\bigr)\\
&=\sigma_{\mathsf{down}}(v_*)
&&\bigl(\because\ \sigma_{\mathsf{down}}\text{ の定義}\bigr).
\end{aligned}`),
      displayMath(String.raw`\sigma_{\mathsf{up}}\ne\sigma_{\mathsf{down}}
\quad\bigl(\because\ v_*\text{ における二つの写像の値が異なる}\bigr).`),
      paragraph([
        ref("def_broken_edge_set"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
B_G(\sigma_{\mathsf{up}})
&=\varnothing
&&\bigl(\because\ \text{全頂点のスピンラベルが }\mathsf{up}\text{ で等しい}\bigr)\\
b_G(\sigma_{\mathsf{up}})
&=0
&&\bigl(\because\ |\varnothing|=0\bigr),\\[4pt]
B_G(\sigma_{\mathsf{down}})
&=\varnothing
&&\bigl(\because\ \text{全頂点のスピンラベルが }\mathsf{down}\text{ で等しい}\bigr)\\
b_G(\sigma_{\mathsf{down}})
&=0
&&\bigl(\because\ |\varnothing|=0\bigr).
\end{aligned}`),
      paragraph([ref("def_broken_edge_multiplicity"), " より"]),
      displayMath(String.raw`\Omega_G(0)
\ge 2
\quad\bigl(\because\ \sigma_{\mathsf{up}},\sigma_{\mathsf{down}}\text{ は破れ辺数 }0\text{ のファイバーに属する相異なる二元である}\bigr).`),
      displayMath(String.raw`\begin{aligned}
Z_G(q)
&\ge \Omega_G(0)q^0
&&\bigl(\because\ \Omega_G(m)\in\mathbb N\text{ かつ }q^m>0\text{ for every }m\in\mathbb N\bigr)\\
&=\Omega_G(0)
&&\bigl(\because\ q^0=1\bigr)\\
&\ge2
&&\bigl(\because\ \Omega_G(0)\ge2\bigr).
\end{aligned}`),
      paragraph([
        "評価点と評価値は有理数、多重度と辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio",
    kind: "theorem",
    title: { text: "一般有限グラフの Fisher 零点と正有理評価点との差の積" },
    labels: ["theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio"],
    habitat: "Qbar",
    verification: ["sagemath/check/fisher-zero-positive-rational-shifted-product-coefficient-ratio"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフについて、",
        ref("def_ising_partition_polynomial"),
        " の次数を",
        math(String.raw`d:=\deg Z_G(x)\in\mathbb N`),
        " と置く。係数を標準単射",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で移した多項式の重複度込み Fisher 零点を",
        math(String.raw`\alpha_1,\ldots,\alpha_d\in\overline{\mathbb Q}`),
        " と書く。任意の正の有理数",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " について、自然数から有理数への標準単射を",
        math(String.raw`\eta_{\mathbb N,\mathbb Q}:\mathbb N\hookrightarrow\mathbb Q`),
        "、有理数から代数的数への標準単射を",
        math(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}:\mathbb Q\hookrightarrow\overline{\mathbb Q}`),
        " と書く。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{d}\left(\iota_{\mathbb Q,\overline{\mathbb Q}}(q)-\alpha_j\right)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \frac{
    Z_G(q)
  }{
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  }
\right)
\in\iota_{\mathbb Q,\overline{\mathbb Q}}(\mathbb Q_{>0})
\subset\overline{\mathbb Q}.`),
      paragraph([
        math(String.raw`d=0`),
        " の場合、左辺は空積",
        math(String.raw`1\in\overline{\mathbb Q}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_fisher_zero_rational_shifted_product_coefficient_ratio"), " を正の有理数", math(String.raw`q`), "に適用すると"]),
      displayMath(String.raw`\prod_{j=1}^{d}\left(\iota_{\mathbb Q,\overline{\mathbb Q}}(q)-\alpha_j\right)
=
\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \frac{
    Z_G(q)
  }{
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  }
\right)
\quad\bigl(\because\ \text{有理評価点との差の積}\bigr).`),
      paragraph([ref("theorem_no_positive_rational_root"), " より"]),
      displayMath(String.raw`Z_G(q)\in\mathbb Q_{>0}
\quad\bigl(\because\ Z_G(q)\ge2\text{ in }\mathbb Q\bigr).`),
      paragraph([ref("theorem_partition_polynomial_degree_maximum_broken_edge_count"), " と", ref("claim_partition_polynomial_coefficient_expansion"), "より"]),
      displayMath(String.raw`\eta_{\mathbb N,\mathbb Q}(\Omega_G(d))\in\mathbb Q_{>0}
\quad\bigl(\because\ \Omega_G(d)\in\mathbb N_{>0}\text{ は最高次係数である}\bigr).`),
      displayMath(String.raw`\frac{
  Z_G(q)
}{
  \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
}
\in\mathbb Q_{>0}
\quad\bigl(\because\ \text{正の有理数どうしの商は正の有理数である}\bigr).`),
      displayMath(String.raw`\iota_{\mathbb Q,\overline{\mathbb Q}}\!\left(
  \frac{
    Z_G(q)
  }{
    \eta_{\mathbb N,\mathbb Q}(\Omega_G(d))
  }
\right)
\in\iota_{\mathbb Q,\overline{\mathbb Q}}(\mathbb Q_{>0})
\quad\bigl(\because\ \text{標準単射の像の定義}\bigr).`),
      paragraph([
        "評価点と係数比は有理数、その標準単射像、Fisher 零点、差、有限積は代数的数、次数と多重度は自然数に属する。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_monotonicity",
    kind: "theorem",
    title: { text: "Ising 分配多項式の正の有理評価の単調性" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_monotonicity"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-monotonicity"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の任意の有限グラフと、",
        math(String.raw`0<q_1\le q_2`),
        " を満たす任意の正の有理数 ",
        math(String.raw`q_1,q_2\in\mathbb Q_{>0}`),
        " について",
      ]),
      displayMath(String.raw`Z_G(q_1)\le Z_G(q_2)\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の整数係数を自然数から有理数への標準単射で移す。各 ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " について、正の有理数の冪の順序保存より",
      ]),
      displayMath(String.raw`q_1^m\le q_2^m
\quad\bigl(\because\ 0<q_1\le q_2\text{ かつ }m\in\mathbb N\bigr).`),
      paragraph([
        ref("def_broken_edge_multiplicity"),
        " より ",
        math(String.raw`\Omega_G(m)\in\mathbb N`),
        " なので、有理数の順序と非負数の乗法の両立性より",
      ]),
      displayMath(String.raw`\Omega_G(m)q_1^m\le\Omega_G(m)q_2^m
\quad\bigl(\because\ q_1^m\le q_2^m\text{ かつ }\Omega_G(m)\ge0\bigr).`),
      paragraph([
        "直前の項別不等式を有限集合 ",
        math(String.raw`\{0,1,\ldots,|E|\}`),
        " 上で加えると",
      ]),
      displayMath(String.raw`\sum_{m=0}^{|E|}\Omega_G(m)q_1^m
\le
\sum_{m=0}^{|E|}\Omega_G(m)q_2^m
\quad\bigl(\because\ \text{有理数の有限和は項別順序を保存する}\bigr).`),
      paragraph([
        ref("claim_partition_polynomial_coefficient_expansion"),
        " の係数表示へ二つの評価点をそれぞれ代入すると",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_G(q_1)
&=\sum_{m=0}^{|E|}\Omega_G(m)q_1^m
&&\bigl(\because\ \text{多重度による係数表示}\bigr)\\
&\le\sum_{m=0}^{|E|}\Omega_G(m)q_2^m
&&\bigl(\because\ \text{直前に得た有限和の不等式}\bigr)\\
&=Z_G(q_2)
&&\bigl(\because\ \text{多重度による係数表示}\bigr).
\end{aligned}`),
      paragraph([
        "評価点と評価値は有理数、多重度、指数、辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_strict_monotonicity",
    kind: "theorem",
    title: { text: "辺をもつ有限グラフの正の有理評価の厳密単調性" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-strict-monotonicity"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。",
        math(String.raw`0<q_1<q_2`),
        " を満たす任意の正の有理数 ",
        math(String.raw`q_1,q_2\in\mathbb Q_{>0}`),
        " について",
      ]),
      displayMath(String.raw`Z_G(q_1)<Z_G(q_2)\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([
        math(String.raw`E\ne\varnothing`),
        " より辺 ",
        math(String.raw`e_*\in E`),
        " を一つ選ぶ。配位 ",
        math(String.raw`\sigma_*:V\to\mathsf{Spin}`),
        " を",
      ]),
      displayMath(String.raw`\sigma_*(v):=
\begin{cases}
\mathsf{up} & \bigl(v=\partial_G(e_*,\mathsf{source})\bigr),\\
\mathsf{down} & \bigl(v\ne\partial_G(e_*,\mathsf{source})\bigr)
\end{cases}
\qquad(v\in V)`),
      paragraph([ref("def_spin_configuration_set"), " より ", math(String.raw`\sigma_*\in\mathcal S_G`), " である。", ref("def_finite_graph_input"), " の端点相異性より"]),
      displayMath(String.raw`\begin{aligned}
\sigma_*\!\left(\partial_G(e_*,\mathsf{source})\right)
&=\mathsf{up}
&&\bigl(\because\ \sigma_*\text{ の定義}\bigr)\\
&\ne\mathsf{down}
&&\bigl(\because\ \mathsf{up}\ne\mathsf{down}\bigr)\\
&=\sigma_*\!\left(\partial_G(e_*,\mathsf{target})\right)
&&\bigl(\because\ \partial_G(e_*,\mathsf{source})\ne\partial_G(e_*,\mathsf{target})\text{ と }\sigma_*\text{ の定義}\bigr).
\end{aligned}`),
      paragraph([ref("def_broken_edge_set"), " より"]),
      displayMath(String.raw`\begin{aligned}
e_*
&\in B_G(\sigma_*)
&&\bigl(\because\ \text{破れ辺集合の定義}\bigr)\\
b_G(\sigma_*)
&\ge1
&&\bigl(\because\ e_*\in B_G(\sigma_*)\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`m_*:=b_G(\sigma_*)\in\{1,\ldots,|E|\}`),
        " と置く。",
        ref("def_broken_edge_multiplicity"),
        " より",
      ]),
      displayMath(String.raw`\Omega_G(m_*)\ge1
\quad\bigl(\because\ \sigma_*\text{ は破れ辺数 }m_*\text{ のファイバーに属する}\bigr).`),
      displayMath(String.raw`q_1^{m_*}<q_2^{m_*}
\quad\bigl(\because\ 0<q_1<q_2\text{ かつ }m_*\ge1\bigr).`),
      displayMath(String.raw`\Omega_G(m_*)q_1^{m_*}<\Omega_G(m_*)q_2^{m_*}
\quad\bigl(\because\ \Omega_G(m_*)\ge1\bigr).`),
      paragraph([
        "また各 ",
        math(String.raw`m\in\{0,1,\ldots,|E|\}`),
        " について、",
        ref("theorem_partition_polynomial_positive_rational_evaluation_monotonicity"),
        " の項別計算と同じく",
      ]),
      displayMath(String.raw`\Omega_G(m)q_1^m\le\Omega_G(m)q_2^m
\quad\bigl(\because\ 0<q_1<q_2\text{ かつ }\Omega_G(m)\ge0\bigr).`),
      displayMath(String.raw`\sum_{m=0}^{|E|}\Omega_G(m)q_1^m
<
\sum_{m=0}^{|E|}\Omega_G(m)q_2^m
\quad\bigl(\because\ m=m_*\text{ の項は狭義不等式であり、他の項は弱不等式である}\bigr).`),
      paragraph([ref("claim_partition_polynomial_coefficient_expansion"), " の係数表示へ二つの評価点を代入すると"]),
      displayMath(String.raw`\begin{aligned}
Z_G(q_1)
&=\sum_{m=0}^{|E|}\Omega_G(m)q_1^m
&&\bigl(\because\ \text{多重度による係数表示}\bigr)\\
&<\sum_{m=0}^{|E|}\Omega_G(m)q_2^m
&&\bigl(\because\ \text{直前に得た有限和の狭義不等式}\bigr)\\
&=Z_G(q_2)
&&\bigl(\because\ \text{多重度による係数表示}\bigr).
\end{aligned}`),
      paragraph([
        "評価点と評価値は有理数、多重度、指数、頂点数、辺数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_injectivity",
    kind: "theorem",
    title: { text: "辺をもつ有限グラフの正の有理評価点の一意性" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_injectivity"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-injectivity"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。任意の正の有理数 ",
        math(String.raw`q_1,q_2\in\mathbb Q_{>0}`),
        " について",
      ]),
      displayMath(String.raw`Z_G(q_1)=Z_G(q_2)\quad\Longleftrightarrow\quad q_1=q_2\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([math(String.raw`q_1=q_2`), " とする。等しい有理数を同じ整数係数多項式へ代入すると"]),
      displayMath(String.raw`Z_G(q_1)=Z_G(q_2)
\quad\bigl(\because\ q_1=q_2\text{ の等号への代入}\bigr).`),
      paragraph([
        "逆に ",
        math(String.raw`Z_G(q_1)=Z_G(q_2)`),
        " とする。",
        math(String.raw`q_1\ne q_2`),
        " と仮定すると、有理数の全順序性より",
      ]),
      displayMath(String.raw`q_1<q_2\quad\text{または}\quad q_2<q_1
\quad\bigl(\because\ q_1\ne q_2\text{ かつ }\mathbb Q\text{ の全順序性}\bigr).`),
      paragraph([
        math(String.raw`q_1<q_2`),
        " の場合、",
        ref("theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity"),
        " より",
      ]),
      displayMath(String.raw`Z_G(q_1)<Z_G(q_2)
\quad\bigl(\because\ 0<q_1<q_2\bigr),`),
      paragraph(["となり、", math(String.raw`Z_G(q_1)=Z_G(q_2)`), " に反する。"]),
      paragraph([
        math(String.raw`q_2<q_1`),
        " の場合も、",
        ref("theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity"),
        " より",
      ]),
      displayMath(String.raw`Z_G(q_2)<Z_G(q_1)
\quad\bigl(\because\ 0<q_2<q_1\bigr),`),
      paragraph(["となり、", math(String.raw`Z_G(q_1)=Z_G(q_2)`), " に反する。したがって"]),
      displayMath(String.raw`q_1=q_2
\quad\bigl(\because\ q_1\ne q_2\text{ の仮定から得る二場合がともに矛盾}\bigr).`),
      paragraph(["評価点と評価値は有理数に属する。実数、複素数、極限、積分を用いない。"]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_order_reflection",
    kind: "theorem",
    title: { text: "辺をもつ有限グラフの正の有理評価における狭義順序の反映" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_order_reflection"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-order-reflection"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。任意の正の有理数 ",
        math(String.raw`q_1,q_2\in\mathbb Q_{>0}`),
        " について",
      ]),
      displayMath(String.raw`Z_G(q_1)<Z_G(q_2)\quad\Longleftrightarrow\quad q_1<q_2\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([
        math(String.raw`q_1<q_2`),
        " とする。",
        ref("theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity"),
        " より",
      ]),
      displayMath(String.raw`Z_G(q_1)<Z_G(q_2)
\quad\bigl(\because\ 0<q_1<q_2\bigr).`),
      paragraph([
        "逆に ",
        math(String.raw`Z_G(q_1)<Z_G(q_2)`),
        " とする。",
        math(String.raw`q_1<q_2`),
        " でないと仮定すると、有理数の全順序性より",
      ]),
      displayMath(String.raw`q_2\le q_1
\quad\bigl(\because\ q_1<q_2\text{ でないことと }\mathbb Q\text{ の全順序性}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_positive_rational_evaluation_monotonicity"),
        " を ",
        math(String.raw`q_2\le q_1`),
        " へ適用すると",
      ]),
      displayMath(String.raw`Z_G(q_2)\le Z_G(q_1)
\quad\bigl(\because\ 0<q_2\le q_1\bigr),`),
      paragraph([
        "となり、",
        math(String.raw`Z_G(q_1)<Z_G(q_2)`),
        " に反する。したがって",
      ]),
      displayMath(String.raw`q_1<q_2
\quad\bigl(\because\ q_1<q_2\text{ でないという仮定から矛盾を得た}\bigr).`),
      paragraph(["評価点と評価値は有理数に属する。実数、複素数、極限、積分を用いない。"]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_weak_order_reflection",
    kind: "theorem",
    title: { text: "辺をもつ有限グラフの正の有理評価における弱順序の反映" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_weak_order_reflection"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-weak-order-reflection"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。任意の正の有理数 ",
        math(String.raw`q_1,q_2\in\mathbb Q_{>0}`),
        " について",
      ]),
      displayMath(String.raw`Z_G(q_1)\le Z_G(q_2)\quad\Longleftrightarrow\quad q_1\le q_2\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([
        math(String.raw`q_1\le q_2`),
        " とする。",
        ref("theorem_partition_polynomial_positive_rational_evaluation_monotonicity"),
        " より",
      ]),
      displayMath(String.raw`Z_G(q_1)\le Z_G(q_2)
\quad\bigl(\because\ 0<q_1\le q_2\bigr).`),
      paragraph([
        "逆に ",
        math(String.raw`Z_G(q_1)\le Z_G(q_2)`),
        " とする。",
        math(String.raw`q_1\le q_2`),
        " でないと仮定すると、有理数の全順序性より",
      ]),
      displayMath(String.raw`q_2<q_1
\quad\bigl(\because\ q_1\le q_2\text{ でないことと }\mathbb Q\text{ の全順序性}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity"),
        " を ",
        math(String.raw`q_2<q_1`),
        " へ適用すると",
      ]),
      displayMath(String.raw`Z_G(q_2)<Z_G(q_1)
\quad\bigl(\because\ 0<q_2<q_1\bigr),`),
      paragraph([
        "となり、",
        math(String.raw`Z_G(q_1)\le Z_G(q_2)`),
        " に反する。したがって",
      ]),
      displayMath(String.raw`q_1\le q_2
\quad\bigl(\because\ q_1\le q_2\text{ でないという仮定から矛盾を得た}\bigr).`),
      paragraph(["評価点と評価値は有理数に属する。実数、複素数、極限、積分を用いない。"]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_at_most_configuration_count",
    kind: "theorem",
    title: { text: "正の有理評価が全配位数以下となる評価点の特徴付け" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_at_most_configuration_count"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-at-most-configuration-count"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。任意の正の有理数 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " について、自然数 ",
        math(String.raw`2^{|V|}`),
        " を有理数へ標準単射で移すと",
      ]),
      displayMath(String.raw`Z_G(q)\le 2^{|V|}\quad\Longleftrightarrow\quad q\le1\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([ref("claim_partition_polynomial_value_at_one"), " より"]),
      displayMath(String.raw`Z_G(1)=2^{|V|}
\quad\bigl(\because\ \text{係数総和}\bigr).`),
      displayMath(String.raw`Z_G(q)\le2^{|V|}
\quad\Longleftrightarrow\quad
Z_G(q)\le Z_G(1)
\quad\bigl(\because\ Z_G(1)=2^{|V|}\text{ の代入}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_positive_rational_evaluation_weak_order_reflection"),
        " を正の有理評価点 ",
        math(String.raw`q,1\in\mathbb Q_{>0}`),
        " へ適用すると",
      ]),
      displayMath(String.raw`Z_G(q)\le Z_G(1)
\quad\Longleftrightarrow\quad
q\le1
\quad\bigl(\because\ \text{正の有理評価における弱順序の反映}\bigr).`),
      displayMath(String.raw`Z_G(q)\le2^{|V|}
\quad\Longleftrightarrow\quad
q\le1
\quad\bigl(\because\ \text{直前の二つの同値関係の推移性}\bigr).`),
      paragraph([
        "評価点と評価値は有理数、頂点数と全配位数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_at_least_configuration_count",
    kind: "theorem",
    title: { text: "正の有理評価が全配位数以上となる評価点の特徴付け" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_at_least_configuration_count"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-at-least-configuration-count"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。任意の正の有理数 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " について、自然数 ",
        math(String.raw`2^{|V|}`),
        " を有理数へ標準単射で移すと",
      ]),
      displayMath(String.raw`2^{|V|}\le Z_G(q)\quad\Longleftrightarrow\quad 1\le q\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([ref("claim_partition_polynomial_value_at_one"), " より"]),
      displayMath(String.raw`Z_G(1)=2^{|V|}
\quad\bigl(\because\ \text{係数総和}\bigr).`),
      displayMath(String.raw`2^{|V|}\le Z_G(q)
\quad\Longleftrightarrow\quad
Z_G(1)\le Z_G(q)
\quad\bigl(\because\ Z_G(1)=2^{|V|}\text{ の代入}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_positive_rational_evaluation_weak_order_reflection"),
        " を正の有理評価点 ",
        math(String.raw`1,q\in\mathbb Q_{>0}`),
        " へ適用すると",
      ]),
      displayMath(String.raw`Z_G(1)\le Z_G(q)
\quad\Longleftrightarrow\quad
1\le q
\quad\bigl(\because\ \text{正の有理評価における弱順序の反映}\bigr).`),
      displayMath(String.raw`2^{|V|}\le Z_G(q)
\quad\Longleftrightarrow\quad
1\le q
\quad\bigl(\because\ \text{直前の二つの同値関係の推移性}\bigr).`),
      paragraph([
        "評価点と評価値は有理数、頂点数と全配位数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_equal_configuration_count",
    kind: "theorem",
    title: { text: "正の有理評価が全配位数に等しくなる評価点の特徴付け" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_equal_configuration_count"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-equal-configuration-count"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。任意の正の有理数 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " について、自然数 ",
        math(String.raw`2^{|V|}`),
        " を有理数へ標準単射で移すと",
      ]),
      displayMath(String.raw`Z_G(q)=2^{|V|}\quad\Longleftrightarrow\quad q=1\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([ref("claim_partition_polynomial_value_at_one"), " より"]),
      displayMath(String.raw`Z_G(1)=2^{|V|}
\quad\bigl(\because\ \text{係数総和}\bigr).`),
      displayMath(String.raw`Z_G(q)=2^{|V|}
\quad\Longleftrightarrow\quad
Z_G(q)=Z_G(1)
\quad\bigl(\because\ Z_G(1)=2^{|V|}\text{ の代入}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_positive_rational_evaluation_injectivity"),
        " を正の有理評価点 ",
        math(String.raw`q,1\in\mathbb Q_{>0}`),
        " へ適用すると",
      ]),
      displayMath(String.raw`Z_G(q)=Z_G(1)
\quad\Longleftrightarrow\quad
q=1
\quad\bigl(\because\ \text{正の有理評価点の一意性}\bigr).`),
      displayMath(String.raw`Z_G(q)=2^{|V|}
\quad\Longleftrightarrow\quad
q=1
\quad\bigl(\because\ \text{直前の二つの同値関係の推移性}\bigr).`),
      paragraph([
        "評価点と評価値は有理数、頂点数と全配位数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_strictly_below_configuration_count",
    kind: "theorem",
    title: { text: "正の有理評価が全配位数より小さくなる評価点の特徴付け" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_strictly_below_configuration_count"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-strictly-below-configuration-count"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。任意の正の有理数 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " について、自然数 ",
        math(String.raw`2^{|V|}`),
        " を有理数へ標準単射で移すと",
      ]),
      displayMath(String.raw`Z_G(q)<2^{|V|}\quad\Longleftrightarrow\quad q<1\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([ref("claim_partition_polynomial_value_at_one"), " より"]),
      displayMath(String.raw`Z_G(1)=2^{|V|}
\quad\bigl(\because\ \text{係数総和}\bigr).`),
      displayMath(String.raw`Z_G(q)<2^{|V|}
\quad\Longleftrightarrow\quad
Z_G(q)<Z_G(1)
\quad\bigl(\because\ Z_G(1)=2^{|V|}\text{ の代入}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_positive_rational_evaluation_order_reflection"),
        " を正の有理評価点 ",
        math(String.raw`q,1\in\mathbb Q_{>0}`),
        " へ適用すると",
      ]),
      displayMath(String.raw`Z_G(q)<Z_G(1)
\quad\Longleftrightarrow\quad
q<1
\quad\bigl(\because\ \text{正の有理評価における狭義順序の反映}\bigr).`),
      displayMath(String.raw`Z_G(q)<2^{|V|}
\quad\Longleftrightarrow\quad
q<1
\quad\bigl(\because\ \text{直前の二つの同値関係の推移性}\bigr).`),
      paragraph([
        "評価点と評価値は有理数、頂点数と全配位数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_positive_rational_evaluation_strictly_above_configuration_count",
    kind: "theorem",
    title: { text: "正の有理評価が全配位数より大きくなる評価点の特徴付け" },
    labels: ["theorem_partition_polynomial_positive_rational_evaluation_strictly_above_configuration_count"],
    habitat: "Q",
    verification: ["sagemath/check/positive-rational-evaluation-strictly-above-configuration-count"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフで ",
        math(String.raw`E\ne\varnothing`),
        " とする。任意の正の有理数 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " について、自然数 ",
        math(String.raw`2^{|V|}`),
        " を有理数へ標準単射で移すと",
      ]),
      displayMath(String.raw`2^{|V|}<Z_G(q)\quad\Longleftrightarrow\quad 1<q\quad\text{in }\mathbb Q.`),
    ],
    proof: [
      paragraph([ref("claim_partition_polynomial_value_at_one"), " より"]),
      displayMath(String.raw`Z_G(1)=2^{|V|}
\quad\bigl(\because\ \text{係数総和}\bigr).`),
      displayMath(String.raw`2^{|V|}<Z_G(q)
\quad\Longleftrightarrow\quad
Z_G(1)<Z_G(q)
\quad\bigl(\because\ Z_G(1)=2^{|V|}\text{ の代入}\bigr).`),
      paragraph([
        ref("theorem_partition_polynomial_positive_rational_evaluation_order_reflection"),
        " を正の有理評価点 ",
        math(String.raw`1,q\in\mathbb Q_{>0}`),
        " へ適用すると",
      ]),
      displayMath(String.raw`Z_G(1)<Z_G(q)
\quad\Longleftrightarrow\quad
1<q
\quad\bigl(\because\ \text{正の有理評価における狭義順序の反映}\bigr).`),
      displayMath(String.raw`2^{|V|}<Z_G(q)
\quad\Longleftrightarrow\quad
1<q
\quad\bigl(\because\ \text{直前の二つの同値関係の推移性}\bigr).`),
      paragraph([
        "評価点と評価値は有理数、頂点数と全配位数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_graph_theorem_no_linear_factor_x_minus_one",
    kind: "theorem",
    title: { text: "一次多項式 x-1 は Ising 分配多項式を割り切らない" },
    labels: ["theorem_no_linear_factor_x_minus_one"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/no-linear-factor-x-minus-one"],
    statement: [
      paragraph([ref("def_finite_graph_input"), " の任意の有限グラフについて、整数係数多項式 ", math(String.raw`x-1`), " は Ising 分配多項式を割り切らない。すなわち"]),
      displayMath(String.raw`(x-1)\nmid Z_G(x)\quad\text{in }\mathbb Z[x].`),
    ],
    proof: [
      paragraph([
        ref("def_ising_partition_polynomial"),
        " より ",
        math(String.raw`Z_G(x)\in\mathbb Z[x]`),
        " である。モニック一次多項式による整数係数多項式の除法より、ある ",
        math(String.raw`Q_G(x)\in\mathbb Z[x]`),
        " と ",
        math(String.raw`r_G\in\mathbb Z`),
        " が一意に存在して",
      ]),
      displayMath(String.raw`Z_G(x)=(x-1)Q_G(x)+r_G.`),
      displayMath(String.raw`r_G
=Z_G(1)
\quad\bigl(\because\ x=1\text{ を直前の除法等式へ代入}\bigr).`),
      paragraph([ref("claim_partition_polynomial_value_at_one"), " より"]),
      displayMath(String.raw`\begin{aligned}
r_G
&=2^{|V|}
&&\bigl(\because\ Z_G(1)=2^{|V|}\bigr)\\
&\ne0
&&\bigl(\because\ |V|\in\mathbb N\text{ かつ }2^{|V|}\text{ は正の整数である}\bigr).
\end{aligned}`),
      displayMath(String.raw`(x-1)\nmid Z_G(x)
\quad\bigl(\because\ x-1\text{ による除法の余り }r_G\text{ が零でない}\bigr).`),
      paragraph([
        "除法の商は整数係数多項式、余りと評価値は整数、頂点数は自然数に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "formal_high_temperature_heading",
    kind: "heading",
    level: 1,
    title: { text: "形式的高温展開" },
    labels: [],
  },
  {
    id: "formal_high_temperature_definition_edge_sign",
    kind: "definition",
    title: { text: "辺のスピン符号" },
    labels: ["def_edge_spin_sign"],
    habitat: "Z",
    statement: [
      paragraph(["各 ", math(String.raw`\sigma\in\mathcal S_G`), " と ", math(String.raw`e\in E`), " に対し"]),
      displayMath(String.raw`s_G(\sigma,e):=\kappa\!\left(\sigma\!\left(\partial_G(e,\mathsf{source})\right)\right)\kappa\!\left(\sigma\!\left(\partial_G(e,\mathsf{target})\right)\right)\in\{-1,+1\}\subset\mathbb Z`),
      paragraph([
        "と定める。スピンラベルから整数への移行には ",
        ref("def_spin_integer_realization"),
        " の写像 ",
        math(String.raw`\kappa`),
        " だけを用いる。",
      ]),
    ],
  },
  {
    id: "formal_high_temperature_definition_weight_sum",
    kind: "definition",
    title: { text: "形式的辺重み和" },
    labels: ["def_formal_edge_weight_sum"],
    habitat: "ZPolynomial",
    statement: [
      paragraph(["独立な不定元 ", math(String.raw`u,v`), " に対し"]),
      displayMath(String.raw`H_G(u,v):=\sum_{\sigma\in\mathcal S_G}\prod_{e\in E}\bigl(u+v\,s_G(\sigma,e)\bigr)\in\mathbb Z[u,v]`),
      paragraph(["と定める。指数関数、双曲関数、実温度はこの定義に含まれない。"]),
    ],
  },
  {
    id: "formal_high_temperature_definition_boundary_parity",
    kind: "definition",
    title: { text: "辺部分集合の境界偶奇" },
    labels: ["def_mod_two_boundary_parity"],
    habitat: "F2",
    statement: [
      paragraph(["辺部分集合 ", math(String.raw`A\subseteq E`), " と頂点 ", math(String.raw`w\in V`), " に対し"]),
      displayMath(String.raw`\beta_G(A)(w):=\left|\left\{(e,a)\in A\times\mathsf{End}\ \middle|\ \partial_G(e,a)=w\right\}\right|\bmod 2\in\mathbb F_2`),
      paragraph(["と定める。各辺の二端点は異なるので、一つの辺を同じ頂点で二重に数えない。"]),
    ],
  },
  {
    id: "formal_high_temperature_definition_even_subsets",
    kind: "definition",
    title: { text: "偶辺部分集合" },
    labels: ["def_even_edge_subset"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`\mathcal Z_1(G):=\{A\subseteq E\mid \beta_G(A)(w)=0\ \text{for every }w\in V\}`),
      paragraph(["と定める。これは有限集合である。境界偶奇は ", ref("def_mod_two_boundary_parity"), " で定めた。"]),
    ],
  },
  {
    id: "formal_high_temperature_definition_even_polynomial",
    kind: "definition",
    title: { text: "偶部分グラフ多項式" },
    labels: ["def_even_subgraph_polynomial"],
    habitat: "ZPolynomial",
    statement: [
      displayMath(String.raw`Q_G(u,v):=\sum_{A\in\mathcal Z_1(G)}u^{|E|-|A|}v^{|A|}\in\mathbb Z[u,v]`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "formal_high_temperature_theorem_expansion",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "形式的高温展開の有限和恒等式" },
    labels: ["theorem_formal_high_temperature_expansion"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/formal-high-temperature-expansion"],
    statement: [displayMath(String.raw`H_G(u,v)=2^{|V|}Q_G(u,v)\in\mathbb Z[u,v].`)],
    proof: [
      paragraph(["積を辺部分集合ごとに展開すると"]),
      displayMath(String.raw`\begin{aligned}
H_G(u,v)
&=\sum_{\sigma\in\mathcal S_G}\ \sum_{A\subseteq E}u^{|E|-|A|}v^{|A|}\prod_{e\in A}s_G(\sigma,e)
&&\bigl(\because\ \text{有限積に分配則を適用}\bigr)\\
&=\sum_{A\subseteq E}u^{|E|-|A|}v^{|A|}\sum_{\sigma\in\mathcal S_G}\prod_{e\in A}s_G(\sigma,e)
&&\bigl(\because\ \text{二つの有限和の順序交換}\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`A\in\mathcal Z_1(G)`),
        " なら、各頂点のスピンは積に偶数回現れるので内側の積は全ての配位で ",
        math(String.raw`1`),
        " となり、内側の和は ",
        math(String.raw`2^{|V|}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`A\notin\mathcal Z_1(G)`),
        " なら、境界偶奇が ",
        math(String.raw`1`),
        " である頂点 ",
        math(String.raw`w`),
        " が存在する。",
        ref("def_single_vertex_spin_flip"),
        " の写像 ",
        math(String.raw`T_w`),
        " は ",
        math(String.raw`\mathcal S_G`),
        " 上の不動点を持たない対合であることは ",
        ref("claim_single_vertex_spin_flip_involution"),
        " で示した。境界偶奇が ",
        math(String.raw`1`),
        " なので、",
        ref("claim_spin_reversal_integer_realization"),
        " により ",
        math(String.raw`\sigma`),
        " と ",
        math(String.raw`T_w(\sigma)`),
        " に対応する積の整数符号は逆になる。したがって内側の和は ",
        math(String.raw`0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
H_G(u,v)
&=\sum_{A\in\mathcal Z_1(G)}u^{|E|-|A|}v^{|A|}\,2^{|V|}
&&\bigl(\because\ \text{上の偶奇による二場合}\bigr)\\
&=2^{|V|}Q_G(u,v)
&&\bigl(\because\ \text{偶部分グラフ多項式の定義}\bigr).
\end{aligned}`),
      paragraph([
        "用いた定義は ",
        ref("def_formal_edge_weight_sum"),
        "、",
        ref("def_edge_spin_sign"),
        "、",
        ref("def_even_edge_subset"),
        "、",
        ref("def_even_subgraph_polynomial"),
        " である。",
      ]),
    ],
  },
]);

type FiniteGraphBlock = (typeof finiteGraphTheory)[number];
type FiniteGraphLabel = FiniteGraphBlock["labels"][number];
type BlockWithLabel<L extends FiniteGraphLabel> = Extract<FiniteGraphBlock, { labels: readonly L[] }>;
type BlockWithId<I extends string> = Extract<FiniteGraphBlock, { id: I }>;

export function selectFiniteGraphBlocksByLabel<const L extends readonly FiniteGraphLabel[]>(
  labels: L,
): { readonly [K in keyof L]: BlockWithLabel<L[K]> } {
  const selected = labels.map((label) => {
    const matches = finiteGraphTheory.filter((block) => block.labels.some((candidate) => candidate === label));
    if (matches.length !== 1) {
      throw new Error(`有限グラフ理論ラベル ${label} の対応ブロック数が ${matches.length}`);
    }
    return matches[0];
  });
  return selected as { readonly [K in keyof L]: BlockWithLabel<L[K]> };
}

export function selectFiniteGraphBlockByLabel<const L extends FiniteGraphLabel>(label: L): BlockWithLabel<L> {
  return selectFiniteGraphBlocksByLabel([label] as const)[0];
}

export function selectFiniteGraphBlockByLabelAndId<
  const L extends FiniteGraphLabel,
  const I extends string,
>(label: L, id: I): BlockWithId<I> {
  const matches = finiteGraphTheory.filter(
    (block) => block.id === id && block.labels.some((candidate) => candidate === label),
  );
  if (matches.length !== 1) throw new Error(`有限グラフ理論の内容 ${label} (${id}) の対応ブロック数が ${matches.length}`);
  return matches[0] as BlockWithId<I>;
}

export const hyperbolicFiniteGraphConnection = {
  edgeEndpointLabels: selectFiniteGraphBlockByLabelAndId("def_edge_endpoint_label_set", "finite_graph_definition_endpoint_labels"),
  finiteGraphInput: selectFiniteGraphBlockByLabelAndId("def_finite_graph_input", "finite_graph_definition_input"),
  spinLabels: selectFiniteGraphBlockByLabelAndId("def_spin_label_set", "finite_graph_definition_spin_labels"),
  spinReversal: selectFiniteGraphBlockByLabelAndId("def_spin_label_reversal", "finite_graph_definition_spin_reversal"),
  spinConfigurations: selectFiniteGraphBlockByLabelAndId("def_spin_configuration_set", "finite_graph_definition_spin_configurations"),
  brokenEdgeSet: selectFiniteGraphBlockByLabelAndId("def_broken_edge_set", "finite_graph_definition_broken_edges"),
  brokenEdgeMultiplicity: selectFiniteGraphBlockByLabelAndId("def_broken_edge_multiplicity", "finite_graph_definition_multiplicity"),
  isingPartitionPolynomial: selectFiniteGraphBlockByLabelAndId("def_ising_partition_polynomial", "finite_graph_definition_partition_polynomial"),
  partitionPolynomialCoefficientExpansion: selectFiniteGraphBlockByLabelAndId(
    "claim_partition_polynomial_coefficient_expansion",
    "finite_graph_claim_coefficient_expansion",
  ),
  modTwoBoundaryParity: selectFiniteGraphBlockByLabelAndId("def_mod_two_boundary_parity", "formal_high_temperature_definition_boundary_parity"),
  evenEdgeSubset: selectFiniteGraphBlockByLabelAndId("def_even_edge_subset", "formal_high_temperature_definition_even_subsets"),
  evenSubgraphPolynomial: selectFiniteGraphBlockByLabelAndId("def_even_subgraph_polynomial", "formal_high_temperature_definition_even_polynomial"),
} as const;

export default finiteGraphTheory;
