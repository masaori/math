import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "homology_sector_expansion_heading",
    kind: "heading",
    level: 1,
    title: { text: "セル鎖複体とホモロジー類別生成多項式" },
    labels: [],
  },
  {
    id: "homology_sector_definition_first_boundary_matrix",
    kind: "definition",
    title: { text: "F_2 上の一次境界写像" },
    labels: ["def_first_boundary_matrix_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/first-boundary-matrix-over-f2"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフ ",
        math(String.raw`G=(V,E,\partial_G)`),
        " と ",
        ref("def_finite_cellulation_cell_sets"),
        " のセル集合入力 ",
        math(String.raw`\mathcal C_{\mathrm{cell}}=(V_{\mathrm{cell}},E_{\mathrm{cell}},F_{\mathrm{cell}})`),
        " が ",
        math(String.raw`V_{\mathrm{cell}}=V`),
        " および ",
        math(String.raw`E_{\mathrm{cell}}=E`),
        " を満たすとする。有限集合 ",
        math(String.raw`S`),
        " に対し ",
        math(String.raw`\mathbb F_2^S`),
        " は写像 ",
        math(String.raw`S\to\mathbb F_2`),
        " の有限ベクトル空間を表す。一次境界写像を有限行列",
      ]),
      displayMath(String.raw`\partial_1:=
\left[
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G(e,a)=w
  }}1_{\mathbb F_2}
\right]_{w\in V_{\mathrm{cell}},\ e\in E_{\mathrm{cell}}}
\in
\operatorname{Mat}_{V_{\mathrm{cell}}\times E_{\mathrm{cell}}}(\mathbb F_2)`),
      paragraph([
        "で定める。この行列が定める線形写像の始域は ",
        math(String.raw`\mathbb F_2^{E_{\mathrm{cell}}}`),
        "、終域は ",
        math(String.raw`\mathbb F_2^{V_{\mathrm{cell}}}`),
        " である。行列の ",
        math(String.raw`(w,e)`),
        " 成分は、",
        ref("def_edge_endpoint_label_set"),
        " の辺端ラベル ",
        math(String.raw`a\in\mathsf{End}`),
        " のうち ",
        math(String.raw`\partial_G(e,a)=w`),
        " を満たすものごとに ",
        math(String.raw`1_{\mathbb F_2}`),
        " を一回加えた値である。全ての和は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_definition_second_boundary_matrix",
    kind: "definition",
    title: { text: "F_2 上の二次境界写像" },
    labels: ["def_second_boundary_matrix_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/second-boundary-matrix-over-f2"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_face_boundary_word"),
        " の各面 ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " の向き付き境界語 ",
        math(String.raw`\partial_{\mathrm{word}}f(i)=\bigl(e_{f,i},\omega_{f,i}\bigr)`),
        " に対し、二次境界写像を有限行列",
      ]),
      displayMath(String.raw`\partial_2:=
\left[
  \sum_{\substack{
    i\in P_f\\
    e_{f,i}=e
  }}1_{\mathbb F_2}
\right]_{e\in E_{\mathrm{cell}},\ f\in F_{\mathrm{cell}}}
\in
\operatorname{Mat}_{E_{\mathrm{cell}}\times F_{\mathrm{cell}}}(\mathbb F_2)`),
      paragraph([
        "で定める。この行列が定める線形写像の始域は ",
        math(String.raw`\mathbb F_2^{F_{\mathrm{cell}}}`),
        "、終域は ",
        math(String.raw`\mathbb F_2^{E_{\mathrm{cell}}}`),
        " である。行列の ",
        math(String.raw`(e,f)`),
        " 成分は、面 ",
        math(String.raw`f`),
        " の境界位置 ",
        math(String.raw`i\in P_f`),
        " のうち辺成分が ",
        math(String.raw`e_{f,i}=e`),
        " を満たすものごとに ",
        math(String.raw`1_{\mathbb F_2}`),
        " を一回加えた値である。したがって同じ辺が一つの面境界に偶数回現れれば、その面の境界における当該辺の係数は ",
        math(String.raw`0_{\mathbb F_2}`),
        " になる。向きラベル ",
        math(String.raw`\omega_{f,i}\in\mathsf{Ori}`),
        " は境界語の接続を指定するが、係数体 ",
        math(String.raw`\mathbb F_2`),
        " では向きによる符号差がないため、この行列成分には入らない。全ての和は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_theorem_boundary_of_boundary_is_zero",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "二つの境界写像の積は零行列である" },
    labels: ["theorem_boundary_of_boundary_is_zero_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/boundary-of-boundary-is-zero-over-f2"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_face_boundary_word"),
        " の面境界語から定めた ",
        ref("def_first_boundary_matrix_over_f2"),
        " と ",
        ref("def_second_boundary_matrix_over_f2"),
        " に対して、",
      ]),
      displayMath(String.raw`\partial_1\partial_2
=0_{V_{\mathrm{cell}}\times F_{\mathrm{cell}}}
\in
\operatorname{Mat}_{V_{\mathrm{cell}}\times F_{\mathrm{cell}}}(\mathbb F_2).`),
    ],
    proof: [
      paragraph([
        "命題 ",
        math(String.raw`Q`),
        " に対し、",
        math(String.raw`\mathbf 1[Q]\in\mathbb F_2`),
        " を ",
        math(String.raw`Q`),
        " が真なら ",
        math(String.raw`1_{\mathbb F_2}`),
        "、偽なら ",
        math(String.raw`0_{\mathbb F_2}`),
        " と定める。任意の ",
        math(String.raw`w\in V_{\mathrm{cell}}`),
        " と ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " を固定する。一次・二次境界写像の定義と有限行列の積から、",
      ]),
      displayMath(String.raw`\begin{aligned}
(\partial_1\partial_2)_{w,f}
&=
\sum_{e\in E_{\mathrm{cell}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G(e,a)=w
  }}1_{\mathbb F_2}
\right)
\left(
  \sum_{\substack{
    i\in P_f\\
    e_{f,i}=e
  }}1_{\mathbb F_2}
\right)
&&\bigl(\because\ \text{有限行列の積と二つの境界写像の定義}\bigr)\\
&=
\sum_{i\in P_f}
\sum_{\substack{
  a\in\mathsf{End}\\
  \partial_G(e_{f,i},a)=w
}}1_{\mathbb F_2}
&&\bigl(\because\ \text{有限和の分配則と添字の付け替え}\bigr)\\
&=
\sum_{i\in P_f}
\left(
  \mathbf 1\!\left[\partial_G(e_{f,i},\iota(\omega_{f,i}))=w\right]
  +
  \mathbf 1\!\left[\partial_G(e_{f,i},\tau(\omega_{f,i}))=w\right]
\right)
&&\bigl(\because\ \{\iota(\omega),\tau(\omega)\}=\mathsf{End}\bigr)\\
&=
\sum_{i\in P_f}
\mathbf 1\!\left[
  \partial_G(e_{f,s_f(i)},\iota(\omega_{f,s_f(i)}))=w
\right]
+
\sum_{i\in P_f}
\mathbf 1\!\left[
  \partial_G(e_{f,i},\iota(\omega_{f,i}))=w
\right]
&&\bigl(\because\ \text{面境界語の接続条件}\bigr)\\
&=
\sum_{i\in P_f}
\mathbf 1\!\left[
  \partial_G(e_{f,i},\iota(\omega_{f,i}))=w
\right]
+
\sum_{i\in P_f}
\mathbf 1\!\left[
  \partial_G(e_{f,i},\iota(\omega_{f,i}))=w
\right]
&&\bigl(\because\ s_f:P_f\to P_f\text{ は全単射}\bigr)\\
&=0_{\mathbb F_2}
&&\bigl(\because\ 1_{\mathbb F_2}+1_{\mathbb F_2}=0_{\mathbb F_2}\bigr).
\end{aligned}`),
      paragraph([
        "最初の等号では ",
        ref("def_first_boundary_matrix_over_f2"),
        " と ",
        ref("def_second_boundary_matrix_over_f2"),
        " を用いた。第三の等号では ",
        ref("def_finite_cellulation_orientation_endpoint_selectors"),
        "、第四の等号では ",
        ref("def_finite_cellulation_face_boundary_word"),
        " を用いた。任意の ",
        math(String.raw`(w,f)\in V_{\mathrm{cell}}\times F_{\mathrm{cell}}`),
        " 成分が ",
        math(String.raw`0_{\mathbb F_2}`),
        " なので、主張の零行列との等式が成り立つ。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_definition_first_cycle_space",
    kind: "definition",
    title: { text: "F_2 上の一次サイクル空間" },
    labels: ["def_first_cycle_space_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/first-cycle-space-over-f2"],
    statement: [
      paragraph([
        ref("def_first_boundary_matrix_over_f2"),
        " が定める有限線形写像 ",
        math(String.raw`\partial_1:\mathbb F_2^{E_{\mathrm{cell}}}\to\mathbb F_2^{V_{\mathrm{cell}}}`),
        " に対し、一次サイクル空間を",
      ]),
      displayMath(String.raw`\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
:=
\left\{
  c\in\mathbb F_2^{E_{\mathrm{cell}}}
  \ \middle|\
  \ \partial_1c=0_{\mathbb F_2^{V_{\mathrm{cell}}}}
\right\}
=\ker(\partial_1)
\subseteq\mathbb F_2^{E_{\mathrm{cell}}}`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`c:E_{\mathrm{cell}}\to\mathbb F_2`),
        " は辺ラベルごとの係数を与える写像であり、",
        math(String.raw`\partial_1c`),
        " は有限行列と係数列の積である。したがって ",
        math(String.raw`\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " は有限な ",
        math(String.raw`\mathbb F_2`),
        " ベクトル空間である。辺部分集合とは同一視せず、辺部分集合から係数写像への写像は別の主張で定義する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_definition_edge_subset_coefficient_map",
    kind: "definition",
    title: { text: "辺部分集合から F_2 辺係数写像への変換" },
    labels: ["def_edge_subset_coefficient_map_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/edge-subset-coefficient-map-over-f2"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_cell_sets"),
        " の有限辺集合 ",
        math(String.raw`E_{\mathrm{cell}}`),
        " の冪集合を ",
        math(String.raw`\mathcal P(E_{\mathrm{cell}})`),
        " と書く。辺部分集合から辺係数写像への変換を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_{E_{\mathrm{cell}}}:
\mathcal P(E_{\mathrm{cell}})
&\longrightarrow
\mathbb F_2^{E_{\mathrm{cell}}},\\
A
&\longmapsto
\chi_{E_{\mathrm{cell}}}(A),\\
\chi_{E_{\mathrm{cell}}}(A)(e)
&:=
\begin{cases}
1_{\mathbb F_2} & (e\in A),\\
0_{\mathbb F_2} & (e\notin A)
\end{cases}
\qquad(e\in E_{\mathrm{cell}})
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`A\in\mathcal P(E_{\mathrm{cell}})`),
        " は辺ラベルの部分集合であり、",
        math(String.raw`\chi_{E_{\mathrm{cell}}}(A):E_{\mathrm{cell}}\to\mathbb F_2`),
        " は辺ラベルごとの係数を与える写像である。したがって辺部分集合と辺係数写像を同一視せず、両者の移行には必ず ",
        math(String.raw`\chi_{E_{\mathrm{cell}}}`),
        " を用いる。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_claim_even_edge_subset_maps_to_first_cycle",
    kind: "claim",
    title: { text: "偶辺部分集合の係数写像は一次サイクルである" },
    labels: ["claim_even_edge_subset_maps_to_first_cycle"],
    habitat: "F2",
    verification: ["sagemath/check/even-edge-subset-maps-to-first-cycle"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフ ",
        math(String.raw`G=(V,E,\partial_G)`),
        " と ",
        ref("def_finite_cellulation_cell_sets"),
        " のセル集合入力が ",
        math(String.raw`V_{\mathrm{cell}}=V`),
        " および ",
        math(String.raw`E_{\mathrm{cell}}=E`),
        " を満たすとする。このとき、",
      ]),
      displayMath(String.raw`\chi_{E_{\mathrm{cell}}}\!\left(\mathcal Z_1(G)\right)
\subseteq
\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2).`),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`A\in\mathcal Z_1(G)`),
        " と ",
        math(String.raw`w\in V_{\mathrm{cell}}=V`),
        " を固定する。",
        ref("def_first_boundary_matrix_over_f2"),
        "、",
        ref("def_edge_subset_coefficient_map_over_f2"),
        "、",
        ref("def_mod_two_boundary_parity"),
        "、",
        ref("def_even_edge_subset"),
        " を順に用いると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\partial_1\chi_{E_{\mathrm{cell}}}(A)\right)(w)
&=
\sum_{e\in E_{\mathrm{cell}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G(e,a)=w
  }}1_{\mathbb F_2}
\right)
\chi_{E_{\mathrm{cell}}}(A)(e)
&&\bigl(\because\ \text{一次境界写像と有限行列積の定義}\bigr)\\
&=
\sum_{\substack{
  (e,a)\in A\times\mathsf{End}\\
  \partial_G(e,a)=w
}}1_{\mathbb F_2}
&&\bigl(\because\ \text{係数写像の二場合と有限和の添字の付け替え}\bigr)\\
&=\beta_G(A)(w)
&&\bigl(\because\ \text{辺部分集合の境界偶奇の定義}\bigr)\\
&=0_{\mathbb F_2}
&&\bigl(\because\ A\in\mathcal Z_1(G)\bigr).
\end{aligned}`),
      paragraph([
        "任意の ",
        math(String.raw`w\in V_{\mathrm{cell}}`),
        " で成分が零なので ",
        math(String.raw`\partial_1\chi_{E_{\mathrm{cell}}}(A)=0_{\mathbb F_2^{V_{\mathrm{cell}}}}`),
        " である。したがって ",
        ref("def_first_cycle_space_over_f2"),
        " により ",
        math(String.raw`\chi_{E_{\mathrm{cell}}}(A)\in\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " である。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_definition_face_boundary_space",
    kind: "definition",
    title: { text: "F_2 上の面境界空間" },
    labels: ["def_face_boundary_space_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/face-boundary-space-over-f2"],
    statement: [
      paragraph([
        ref("def_second_boundary_matrix_over_f2"),
        " が定める有限線形写像 ",
        math(String.raw`\partial_2:\mathbb F_2^{F_{\mathrm{cell}}}\to\mathbb F_2^{E_{\mathrm{cell}}}`),
        " に対し、面境界空間を",
      ]),
      displayMath(String.raw`\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
:=
\operatorname{im}(\partial_2)
=
\left\{
  \partial_2b
  \ \middle|\
  \ b\in\mathbb F_2^{F_{\mathrm{cell}}}
\right\}`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`b:F_{\mathrm{cell}}\to\mathbb F_2`),
        " は面ラベルごとの係数を与える写像であり、",
        math(String.raw`\partial_2b:E_{\mathrm{cell}}\to\mathbb F_2`),
        " は有限行列と係数列の積である。",
        ref("theorem_boundary_of_boundary_is_zero_over_f2"),
        " により、任意の ",
        math(String.raw`b\in\mathbb F_2^{F_{\mathrm{cell}}}`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\partial_1(\partial_2b)
&=(\partial_1\partial_2)b
\quad\bigl(\because\ \text{有限線形写像の合成の結合則}\bigr)\\
&=0_{\mathbb F_2^{V_{\mathrm{cell}}}}
\quad\bigl(\because\ \text{二つの境界写像の積は零行列である}\bigr)
\end{aligned}`),
      paragraph([
        "である。したがって ",
        ref("def_first_cycle_space_over_f2"),
        " の部分空間として",
      ]),
      displayMath(String.raw`\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\subseteq
\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\subseteq
\mathbb F_2^{E_{\mathrm{cell}}}`),
      paragraph([
        "が成り立つ。面部分集合とは同一視せず、面部分集合から面係数写像への写像は別の主張で定義する。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_definition_first_homology_group",
    kind: "definition",
    title: { text: "F_2 上の第一ホモロジー群" },
    labels: ["def_first_homology_group_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/first-homology-group-over-f2"],
    statement: [
      paragraph([
        ref("def_first_cycle_space_over_f2"),
        " と ",
        ref("def_face_boundary_space_over_f2"),
        " に対し、第一ホモロジー群を、一次サイクルごとの面境界空間の剰余集合からなる有限商ベクトル空間",
      ]),
      displayMath(String.raw`H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
:=
\left\{
  \left\{
    c+b
    \ \middle|\
    \ b\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
  \right\}
  \ \middle|\
  \ c\in\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\right\}`),
      paragraph([
        "で定める。サイクルをその剰余集合へ送る商写像は、始域、終域、作用を明示すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
&\longrightarrow
H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2),\\
c
&\longmapsto
\left\{
  c+b
  \ \middle|\
  \ b\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\right\}
\end{aligned}`),
      paragraph([
        "で定める。ここで加法は有限ベクトル空間 ",
        math(String.raw`\mathbb F_2^{E_{\mathrm{cell}}}`),
        " の加法である。面境界空間が一次サイクル空間の部分空間であるため、各剰余集合は一次サイクル空間の部分集合であり、商の加法は剰余集合の代表の選択に依存しない。商写像の始域、終域、作用を明示したので、サイクルとそのホモロジー類を同一視しない。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_definition_even_edge_subset_homology_class_map",
    kind: "definition",
    title: { text: "偶辺部分集合の第一ホモロジー類写像" },
    labels: ["def_even_edge_subset_homology_class_map"],
    habitat: "F2",
    verification: ["sagemath/check/even-edge-subset-homology-class-map"],
    statement: [
      paragraph([
        ref("def_first_homology_group_over_f2"),
        " で定めた商写像を ",
        math(String.raw`\pi_1:\operatorname{Cycle}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)\to H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " と書く。",
        ref("claim_even_edge_subset_maps_to_first_cycle"),
        " により、",
        ref("def_edge_subset_coefficient_map_over_f2"),
        " の写像は偶辺部分集合上で一次サイクル空間に値を取る。偶辺部分集合の第一ホモロジー類写像を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\eta_{\mathcal C_{\mathrm{cell}}}:
\mathcal Z_1(G)
&\longrightarrow
H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2),\\
A
&\longmapsto
\pi_1\!\left(\chi_{E_{\mathrm{cell}}}(A)\right)\\
&=
\left\{
  \chi_{E_{\mathrm{cell}}}(A)+b
  \ \middle|\
  \ b\in\operatorname{Boundary}_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)
\right\}
\end{aligned}`),
      paragraph([
        "で定める。すなわち ",
        math(String.raw`\eta_{\mathcal C_{\mathrm{cell}}}`),
        " は、辺部分集合を辺係数写像へ送る写像の ",
        math(String.raw`\mathcal Z_1(G)`),
        " への制限と商写像 ",
        math(String.raw`\pi_1`),
        " の合成である。辺部分集合、辺係数写像、一次サイクル、剰余集合を同一視せず、二つの明示した写像だけを通る。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_definition_homology_class_generating_polynomial",
    kind: "definition",
    title: { text: "第一ホモロジー類別の偶部分グラフ生成多項式" },
    labels: ["def_homology_class_generating_polynomial"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/homology-class-generating-polynomial"],
    statement: [
      paragraph([
        ref("def_even_edge_subset_homology_class_map"),
        " の第一ホモロジー類写像に対し、任意の ",
        math(String.raw`h\in H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " と独立な不定元 ",
        math(String.raw`u,v`),
        " について、第一ホモロジー類 ",
        math(String.raw`h`),
        " の偶部分グラフ生成多項式を",
      ]),
      displayMath(String.raw`Q_{\mathcal C_{\mathrm{cell}},h}(u,v)
:=
\sum_{A\in\eta_{\mathcal C_{\mathrm{cell}}}^{-1}(\{h\})}
u^{|E_{\mathrm{cell}}|-|A|}v^{|A|}
\in\mathbb Z[u,v]`),
      paragraph([
        "で定める。和の添字集合は、有限集合 ",
        math(String.raw`\mathcal Z_1(G)`),
        " から有限商集合 ",
        math(String.raw`H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)`),
        " への写像 ",
        math(String.raw`\eta_{\mathcal C_{\mathrm{cell}}}`),
        " による ",
        math(String.raw`\{h\}`),
        " の逆像である。添字には商集合の元 ",
        math(String.raw`h`),
        " 自体を用い、その剰余集合から代表サイクルを選ばないため、この定義は代表の選択に依存しない。各ファイバーと辺集合は有限なので、係数は整数であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "homology_sector_theorem_homology_class_polynomials_recombine",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "第一ホモロジー類別の偶部分グラフ生成多項式の再結合" },
    labels: ["theorem_homology_class_polynomials_recombine"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/homology-class-polynomials-recombine"],
    statement: [
      displayMath(String.raw`\sum_{h\in H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)}
Q_{\mathcal C_{\mathrm{cell}},h}(u,v)
=
Q_G(u,v)
\in\mathbb Z[u,v].`),
    ],
    proof: [
      paragraph([ref("def_homology_class_generating_polynomial"), " より"]),
      displayMath(String.raw`\sum_{h\in H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)}
Q_{\mathcal C_{\mathrm{cell}},h}(u,v)
=
\sum_{h\in H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)}
\sum_{A\in\eta_{\mathcal C_{\mathrm{cell}}}^{-1}(\{h\})}
u^{|E_{\mathrm{cell}}|-|A|}v^{|A|}
\quad\bigl(\because\ Q_{\mathcal C_{\mathrm{cell}},h}\text{ の定義}\bigr).`),
      paragraph([
        ref("def_even_edge_subset_homology_class_map"),
        " の写像のファイバーは、その始域である有限集合 ",
        math(String.raw`\mathcal Z_1(G)`),
        " を重複なく分割する。したがって",
      ]),
      displayMath(String.raw`\sum_{h\in H_1(\mathcal C_{\mathrm{cell}};\mathbb F_2)}
\sum_{A\in\eta_{\mathcal C_{\mathrm{cell}}}^{-1}(\{h\})}
u^{|E_{\mathrm{cell}}|-|A|}v^{|A|}
=
\sum_{A\in\mathcal Z_1(G)}
u^{|E_{\mathrm{cell}}|-|A|}v^{|A|}
\quad\bigl(\because\ \eta_{\mathcal C_{\mathrm{cell}}}\text{ のファイバーによる有限和の分割}\bigr).`),
      paragraph([
        math(String.raw`E_{\mathrm{cell}}=E`),
        " と ",
        ref("def_even_subgraph_polynomial"),
        " より",
      ]),
      displayMath(String.raw`\sum_{A\in\mathcal Z_1(G)}
u^{|E_{\mathrm{cell}}|-|A|}v^{|A|}
=
Q_G(u,v)
\quad\bigl(\because\ Q_G\text{ の定義}\bigr).`),
      paragraph([
        "全ての添字集合は有限であり、等式は ",
        math(String.raw`\mathbb Z[u,v]`),
        " の有限和だけからなる。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
]);
