import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
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
