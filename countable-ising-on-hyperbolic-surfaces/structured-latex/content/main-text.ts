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
