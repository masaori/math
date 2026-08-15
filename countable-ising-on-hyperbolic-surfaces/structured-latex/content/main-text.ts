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
        "、二つの写像 ",
        math(String.raw`\partial_0,\partial_1:E\to V`),
        " の組 ",
        math(String.raw`G=(V,E,\partial_0,\partial_1)`),
        " と定める。任意の ",
        math(String.raw`e\in E`),
        " について ",
        math(String.raw`\partial_0(e)\ne\partial_1(e)`),
        " を仮定する。異なる辺が同じ二頂点を結ぶことは許す。",
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
      displayMath(String.raw`\mathcal S_G:=\{\sigma\mid \sigma:V\to\{-1,+1\}\ \text{は写像}\}`),
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
      displayMath(String.raw`B_G(\sigma):=\{e\in E\mid \sigma(\partial_0(e))\ne\sigma(\partial_1(e))\},\qquad b_G(\sigma):=|B_G(\sigma)|\in\mathbb N`),
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
      displayMath(String.raw`s_G(\sigma,e):=\sigma(\partial_0(e))\sigma(\partial_1(e))\in\{-1,+1\}`),
      paragraph(["と定める。"]),
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
      displayMath(String.raw`\partial_G(A)(w):=\left|\{e\in A\mid \partial_0(e)=w\ \text{または}\ \partial_1(e)=w\}\right|\bmod 2\in\mathbb F_2`),
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
      displayMath(String.raw`\mathcal Z_1(G):=\{A\subseteq E\mid \partial_G(A)(w)=0\ \text{for every }w\in V\}`),
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
        " が存在する。配位の ",
        math(String.raw`w`),
        " での値だけを反転する写像は ",
        math(String.raw`\mathcal S_G`),
        " 上の不動点を持たない対合であり、対になった二項の積の符号が逆になるので、内側の和は ",
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

