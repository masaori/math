import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_cellulation_heading_input",
    kind: "heading",
    level: 1,
    title: { text: "有限セル分割の入力" },
    labels: [],
  },
  {
    id: "finite_cellulation_definition_cell_sets",
    kind: "definition",
    title: { text: "頂点・辺・面の有限集合" },
    labels: ["def_finite_cellulation_cell_sets"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限セル分割のセル集合入力を、空でない三つの有限集合 ",
        math(String.raw`V_{\mathrm{cell}}`),
        "、",
        math(String.raw`E_{\mathrm{cell}}`),
        "、",
        math(String.raw`F_{\mathrm{cell}}`),
        " の順序付き三つ組",
      ]),
      displayMath(String.raw`\mathcal C_{\mathrm{cell}}:=\bigl(V_{\mathrm{cell}},E_{\mathrm{cell}},F_{\mathrm{cell}}\bigr)`),
      paragraph([
        "と定める。",
        math(String.raw`V_{\mathrm{cell}}`),
        " は頂点の集合、",
        math(String.raw`E_{\mathrm{cell}}`),
        " は辺の集合、",
        math(String.raw`F_{\mathrm{cell}}`),
        " は面の集合である。三つの集合には",
      ]),
      displayMath(String.raw`V_{\mathrm{cell}}\cap E_{\mathrm{cell}}=\varnothing,\qquad E_{\mathrm{cell}}\cap F_{\mathrm{cell}}=\varnothing,\qquad F_{\mathrm{cell}}\cap V_{\mathrm{cell}}=\varnothing`),
      paragraph(["を要求し、頂点、辺、面の元を互いに同一視しない。"]),
    ],
  },
  {
    id: "finite_cellulation_definition_face_boundary_word",
    kind: "definition",
    title: { text: "面の向き付き境界語" },
    labels: ["def_finite_cellulation_face_boundary_word"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフ ",
        math(String.raw`G=(V,E,\partial_0,\partial_1)`),
        " と ",
        ref("def_finite_cellulation_cell_sets"),
        " のセル集合入力 ",
        math(String.raw`\mathcal C_{\mathrm{cell}}=(V_{\mathrm{cell}},E_{\mathrm{cell}},F_{\mathrm{cell}})`),
        " が ",
        math(String.raw`V_{\mathrm{cell}}=V`),
        " および ",
        math(String.raw`E_{\mathrm{cell}}=E`),
        " を満たすとする。各面 ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " の向き付き境界語を、正整数 ",
        math(String.raw`n_f\in\mathbb N_{>0}`),
        " と有限列",
      ]),
      displayMath(String.raw`\partial_{\mathrm{word}}f:=\bigl((e_{f,i},\varepsilon_{f,i})\bigr)_{i=0}^{n_f-1}\in\bigl(E_{\mathrm{cell}}\times\{-1,+1\}\bigr)^{n_f}`),
      paragraph([
        "の組として定める。ここで各 ",
        math(String.raw`i\in\{0,1,\ldots,n_f-1\}`),
        " に対し ",
        math(String.raw`e_{f,i}\in E_{\mathrm{cell}}`),
        " および ",
        math(String.raw`\varepsilon_{f,i}\in\{-1,+1\}`),
        " であり、添字を巡回的に ",
        math(String.raw`e_{f,n_f}:=e_{f,0}`),
        "、",
        math(String.raw`\varepsilon_{f,n_f}:=\varepsilon_{f,0}`),
        " と延長して、接続条件",
      ]),
      displayMath(String.raw`\partial_{(1+\varepsilon_{f,i})/2}(e_{f,i})=\partial_{(1-\varepsilon_{f,i+1})/2}(e_{f,i+1})\qquad\bigl(i\in\{0,1,\ldots,n_f-1\}\bigr)`),
      paragraph([
        "を要求する。符号 ",
        math(String.raw`+1`),
        " は辺を ",
        math(String.raw`\partial_0(e)`),
        " から ",
        math(String.raw`\partial_1(e)`),
        " へ進む向き、符号 ",
        math(String.raw`-1`),
        " は逆向きを表す。したがって接続条件は、各向き付き辺の終点が次の向き付き辺の始点に等しく、最後の終点が最初の始点に等しいことを述べる。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_opposite_edge_occurrences",
    kind: "definition",
    title: { text: "辺の逆向き二回出現" },
    labels: ["def_finite_cellulation_opposite_edge_occurrences"],
    habitat: "finite",
    verification: ["sagemath/check/finite-cellulation-opposite-edge-occurrences"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_face_boundary_word"),
        " の向き付き境界語の族 ",
        math(String.raw`\bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}`),
        " に対し、辺の逆向き二回出現述語 ",
        math(String.raw`\operatorname{OppositeEdgeTwice}`),
        " を真偽値集合 ",
        math(String.raw`\{\mathrm{false},\mathrm{true}\}`),
        " に値を取る次の条件として定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\operatorname{OppositeEdgeTwice}
\left(
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
\Longleftrightarrow \\
&\qquad
\text{任意の }e\in E_{\mathrm{cell}}\text{ に対して}
\begin{cases}
\left|
  \left\{
    (f,i)\ \middle|\
    \begin{array}{l}
    f\in F_{\mathrm{cell}},\quad i\in\mathbb N,\quad 0\le i<n_f,\\
    e_{f,i}=e
    \end{array}
  \right\}
\right|=2,\\[8pt]
\displaystyle
\sum_{\substack{
  f\in F_{\mathrm{cell}},\ 0\le i<n_f\\
  e_{f,i}=e
}}
\varepsilon_{f,i}=0.
\end{cases}
\end{aligned}`),
      paragraph([
        "出現位置 ",
        math(String.raw`(f,i)`),
        " の集合は有限集合、その元の個数は ",
        math(String.raw`\mathbb N`),
        "、符号和は ",
        math(String.raw`\mathbb Z`),
        " に属する。各符号は ",
        math(String.raw`\{-1,+1\}`),
        " に属するため、二つの出現の符号和が ",
        math(String.raw`0`),
        " であることは、一方が ",
        math(String.raw`+1`),
        "、他方が ",
        math(String.raw`-1`),
        " であることと同値である。二つの出現位置は異なるが、二つの面は同じでもよい。この述語は有限列の走査、整数の加法、有限整数の等号だけで判定できる。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_vertex_links_are_cycles",
    kind: "definition",
    title: { text: "頂点リンクが一つの巡回列であるための有限述語" },
    labels: ["def_finite_cellulation_vertex_links_are_cycles"],
    habitat: "finite",
    verification: ["sagemath/check/finite-cellulation-vertex-links-are-cycles"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_face_boundary_word"),
        " の各出現位置 ",
        math(String.raw`(f,i)`),
        " に対し、その角を挟む二つの辺端を",
      ]),
      displayMath(String.raw`\begin{aligned}
h^-_{f,i}
&:=
\left(
  e_{f,i},
  \frac{1+\varepsilon_{f,i}}{2}
\right)
\in E_{\mathrm{cell}}\times\{0,1\},\\
h^+_{f,i}
&:=
\left(
  e_{f,i+1},
  \frac{1-\varepsilon_{f,i+1}}{2}
\right)
\in E_{\mathrm{cell}}\times\{0,1\}
\end{aligned}`),
      paragraph([
        "と書く。ここで添字 ",
        math(String.raw`i+1`),
        " は ",
        math(String.raw`n_f`),
        " を法として巡回的に読む。接続条件により、両辺端の頂点は等しい。各 ",
        math(String.raw`v\in V_{\mathrm{cell}}`),
        " における角位置の有限集合を",
      ]),
      displayMath(String.raw`C_v:=
\left\{
  (f,i)\ \middle|\
  \begin{array}{l}
  f\in F_{\mathrm{cell}},\quad i\in\mathbb N,\quad 0\le i<n_f,\\
  \partial_{(1+\varepsilon_{f,i})/2}(e_{f,i})=v
  \end{array}
\right\}`),
      paragraph([
        "と書く。頂点リンク単巡回述語 ",
        math(String.raw`\operatorname{VertexLinksAreCycles}`),
        " を、",
        ref("def_finite_cellulation_opposite_edge_occurrences"),
        " と次の有限条件の連言として定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\operatorname{VertexLinksAreCycles}
\left(
  G,
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
\Longleftrightarrow\\
&\quad
\operatorname{OppositeEdgeTwice}
\left(
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
\ \land\\
&\quad
\text{任意の }v\in V_{\mathrm{cell}}\text{ に対して}
\begin{cases}
C_v\ne\varnothing,\\[4pt]
\left|
  \left\{
    ((f,i),s)\in C_v\times\{-,+\}\ \middle|\
    h^s_{f,i}=h
  \right\}
\right|=2
\quad
\left(
  \text{任意の }h\in
  \left\{
    (e,\delta)\in E_{\mathrm{cell}}\times\{0,1\}
    \ \middle|\
    \partial_\delta(e)=v
  \right\}
  \text{ に対して}
\right),\\[12pt]
\text{任意の }c,c'\in C_v\text{ に対して、ある }r\in\mathbb N\text{ と}\\
\qquad c_j=(f_j,i_j)\in C_v\quad(0\le j\le r)\text{ が存在し、}\\
\qquad c_0=c,\quad c_r=c',\quad
\{h^-_{f_j,i_j},h^+_{f_j,i_j}\}\cap
\{h^-_{f_{j+1},i_{j+1}},h^+_{f_{j+1},i_{j+1}}\}\ne\varnothing\\
\qquad\left(j\in\mathbb N,\ 0\le j<r\right).
\end{cases}
\end{aligned}`),
      paragraph([
        math(String.raw`C_v`),
        "、辺端の集合、および角位置の列は有限集合に属し、",
        math(String.raw`r`),
        " と各元の個数は ",
        math(String.raw`\mathbb N`),
        " に属する。第二条件は各辺端に二つの角が接すること、第三条件は全ての角が辺端の共有によって一つにつながることを表す。この述語は有限集合の列挙と等号だけで判定できる。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_connected_one_skeleton",
    kind: "definition",
    title: { text: "一次骨格の連結性を判定する有限述語" },
    labels: ["def_finite_cellulation_connected_one_skeleton"],
    habitat: "finite",
    verification: ["sagemath/check/finite-cellulation-connected-one-skeleton"],
    statement: [
      paragraph([
        ref("def_finite_graph_input"),
        " の有限グラフ ",
        math(String.raw`G=(V,E,\partial_0,\partial_1)`),
        " に対し、一次骨格連結述語 ",
        math(String.raw`\operatorname{ConnectedOneSkeleton}`),
        " を真偽値集合 ",
        math(String.raw`\{\mathrm{false},\mathrm{true}\}`),
        " に値を取る次の条件として定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\operatorname{ConnectedOneSkeleton}(G)
\Longleftrightarrow\\
&\quad
\text{任意の }v,w\in V\text{ に対して、ある }r\in\mathbb N\text{ と}\\
&\quad
v_j\in V\quad(0\le j\le r),\qquad
e_j\in E\quad(1\le j\le r)\text{ が存在し、}\\
&\quad
v_0=v,\qquad v_r=w,\qquad
\{\partial_0(e_j),\partial_1(e_j)\}=\{v_{j-1},v_j\}
\quad(1\le j\le r).
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " は ",
        math(String.raw`\mathbb N`),
        "、頂点列の各元は有限集合 ",
        math(String.raw`V`),
        "、辺列の各元は有限集合 ",
        math(String.raw`E`),
        " に属する。",
        math(String.raw`v=w`),
        " の場合は ",
        math(String.raw`r=0`),
        " の列を許す。この述語は一つの頂点から端点写像を通じて到達できる頂点を有限回列挙し、その集合が ",
        math(String.raw`V`),
        " に等しいかを有限集合の等号で比較して判定できる。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_euler_characteristic",
    kind: "definition",
    title: { text: "有限セル分割の Euler 標数" },
    labels: ["def_finite_cellulation_euler_characteristic"],
    habitat: "Z",
    verification: ["sagemath/check/finite-cellulation-euler-characteristic"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_cell_sets"),
        " のセル集合入力 ",
        math(String.raw`\mathcal C_{\mathrm{cell}}=(V_{\mathrm{cell}},E_{\mathrm{cell}},F_{\mathrm{cell}})`),
        " に対し、その Euler 標数を",
      ]),
      displayMath(String.raw`\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)
:=
\iota_{\mathbb N,\mathbb Z}\!\left(\lvert V_{\mathrm{cell}}\rvert\right)
-
\iota_{\mathbb N,\mathbb Z}\!\left(\lvert E_{\mathrm{cell}}\rvert\right)
+
\iota_{\mathbb N,\mathbb Z}\!\left(\lvert F_{\mathrm{cell}}\rvert\right)
\in\mathbb Z`),
      paragraph([
        "と定める。ここで有限集合 ",
        math(String.raw`A`),
        " に対して ",
        math(String.raw`\lvert A\rvert\in\mathbb N`),
        " は元の個数を表し、",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " は ",
        math(String.raw`n\mapsto n`),
        " で与えられる標準単射である。したがって減法を含む右辺は整数として定まり、実数・複素数・極限・積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_oriented_closed_surface_cellulation",
    kind: "definition",
    title: { text: "向き付けられた閉曲面セル分割を判定する有限述語" },
    labels: ["def_oriented_closed_surface_cellulation"],
    habitat: "finite",
    verification: ["sagemath/check/oriented-closed-surface-cellulation"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_face_boundary_word"),
        " の入力である有限グラフ ",
        math(String.raw`G=(V,E,\partial_0,\partial_1)`),
        "、セル集合入力 ",
        math(String.raw`\mathcal C_{\mathrm{cell}}=(V_{\mathrm{cell}},E_{\mathrm{cell}},F_{\mathrm{cell}})`),
        "、向き付き境界語の族 ",
        math(String.raw`\bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}`),
        " に対し、向き付けられた閉曲面セル分割述語 ",
        math(String.raw`\operatorname{OrientedClosedSurfaceCellulation}`),
        " を真偽値集合 ",
        math(String.raw`\{\mathrm{false},\mathrm{true}\}`),
        " に値を取る次の条件として定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\operatorname{OrientedClosedSurfaceCellulation}
\left(
  G,
  \mathcal C_{\mathrm{cell}},
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
\Longleftrightarrow\\
&\quad
\operatorname{OppositeEdgeTwice}
\left(
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
\ \land\\
&\quad
\operatorname{VertexLinksAreCycles}
\left(
  G,
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
\ \land\\
&\quad
\operatorname{ConnectedOneSkeleton}(G).
\end{aligned}`),
      paragraph([
        "三つの条件はそれぞれ ",
        ref("def_finite_cellulation_opposite_edge_occurrences"),
        "、",
        ref("def_finite_cellulation_vertex_links_are_cycles"),
        "、",
        ref("def_finite_cellulation_connected_one_skeleton"),
        " で定めた有限述語である。第一条件が面境界の向きを全辺で整合させ、第二条件が各頂点の近傍を一つの円周にし、第三条件がセル分割全体を一つの連結成分にする。この連言は有限集合の列挙、自然数と整数の等号、真偽値演算だけで判定でき、実数・複素数・極限・積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_regular_type",
    kind: "definition",
    title: { text: "有限セル分割の正則型" },
    labels: ["def_finite_cellulation_regular_type"],
    habitat: "finite",
    verification: ["sagemath/check/finite-cellulation-regular-type"],
    statement: [
      paragraph([
        ref("def_oriented_closed_surface_cellulation"),
        " を満たす有限セル分割と、正整数 ",
        math(String.raw`p,q\in\mathbb N_{>0}`),
        " に対し、そのセル分割が正則型 ",
        math(String.raw`\{p,q\}`),
        " であることを表す述語 ",
        math(String.raw`\operatorname{RegularType}_{p,q}`),
        " を次の条件として定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\operatorname{RegularType}_{p,q}
\left(
  G,
  \mathcal C_{\mathrm{cell}},
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
\Longleftrightarrow\\
&\quad
\operatorname{OrientedClosedSurfaceCellulation}
\left(
  G,
  \mathcal C_{\mathrm{cell}},
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
\ \land\\
&\quad
n_f=p
\qquad\left(\text{任意の }f\in F_{\mathrm{cell}}\text{ に対して}\right)
\ \land\\
&\quad
\lvert C_v\rvert=q
\qquad\left(\text{任意の }v\in V_{\mathrm{cell}}\text{ に対して}\right).
\end{aligned}`),
      paragraph([
        ref("def_finite_cellulation_face_boundary_word"),
        " の ",
        math(String.raw`n_f\in\mathbb N_{>0}`),
        " は面 ",
        math(String.raw`f`),
        " の向き付き境界語に現れる辺の出現位置の個数であり、",
        ref("def_finite_cellulation_vertex_links_are_cycles"),
        " の有限集合 ",
        math(String.raw`C_v`),
        " は頂点 ",
        math(String.raw`v`),
        " に接する角の出現位置の集合である。したがって第一の元数条件は全ての面が ",
        math(String.raw`p`),
        " 個の辺出現を持つこと、第二の元数条件は全ての頂点に ",
        math(String.raw`q`),
        " 個の角出現が接することを表す。面や辺が境界語の中で反復する場合も、相異なる面や辺の個数へ置き換えず、有限の出現位置を数える。この述語は有限集合の元数と自然数の等号だけで判定でき、実数・複素数・極限・積分を用いない。",
      ]),
    ],
  },
]);
