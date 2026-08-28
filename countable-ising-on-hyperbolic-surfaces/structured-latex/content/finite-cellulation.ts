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
    id: "finite_cellulation_definition_orientation_labels",
    kind: "definition",
    title: { text: "境界辺の向きラベル集合" },
    labels: ["def_finite_cellulation_orientation_label_set"],
    habitat: "finite",
    statement: [
      paragraph(["面境界における辺の進み方を表す形式的ラベルの有限集合を"]),
      displayMath(String.raw`\mathsf{Ori}:=\{\mathsf{forward},\mathsf{reverse}\}`),
      paragraph([
        "と定める。",
        math(String.raw`\mathsf{forward}`),
        " と ",
        math(String.raw`\mathsf{reverse}`),
        " は向きを区別するラベルであり、整数 ",
        math(String.raw`+1,-1\in\mathbb Z`),
        " ではない。この集合には整数の演算を入れない。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_orientation_endpoint_selectors",
    kind: "definition",
    title: { text: "向きラベルから辺端ラベルを選ぶ写像" },
    labels: ["def_finite_cellulation_orientation_endpoint_selectors"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_cellulation_orientation_label_set"),
        " の向きラベルから、進行の始点と終点に当たる ",
        ref("def_edge_endpoint_label_set"),
        " の辺端ラベルを選ぶ二つの写像を",
      ]),
      displayMath(String.raw`\iota,\tau:\mathsf{Ori}\to\mathsf{End}`),
      paragraph(["とし、その値を"]),
      displayMath(String.raw`\begin{array}{c|cc}
\omega & \iota(\omega) & \tau(\omega)\\ \hline
\mathsf{forward} & \mathsf{source} & \mathsf{target}\\
\mathsf{reverse} & \mathsf{target} & \mathsf{source}
\end{array}`),
      paragraph([
        "で定める。",
        math(String.raw`\iota(\omega)`),
        " は向き ",
        math(String.raw`\omega\in\mathsf{Ori}`),
        " で辺を進むときの始点ラベル、",
        math(String.raw`\tau(\omega)`),
        " は終点ラベルである。異なるラベル集合の間の移行は、この二写像だけを通して行う。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_orientation_reversal",
    kind: "definition",
    title: { text: "向きラベルの反転写像" },
    labels: ["def_finite_cellulation_orientation_reversal"],
    habitat: "finite",
    statement: [
      paragraph(["向きラベルを反転する写像を"]),
      displayMath(String.raw`\rho:\mathsf{Ori}\to\mathsf{Ori},\qquad
\rho(\mathsf{forward})=\mathsf{reverse},\qquad
\rho(\mathsf{reverse})=\mathsf{forward}`),
      paragraph([
        "と定める。これは形式的ラベル上の写像であり、整数の加法逆元を用いない。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_cyclic_position_system",
    kind: "definition",
    title: { text: "面境界の巡回位置系" },
    labels: ["def_finite_cellulation_cyclic_position_system"],
    habitat: "finite",
    statement: [
      paragraph([
        "各面 ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " に対し、空でない有限集合 ",
        math(String.raw`P_f`),
        " と全単射 ",
        math(String.raw`s_f:P_f\to P_f`),
        " の組 ",
        math(String.raw`\mathcal P_f=(P_f,s_f)`),
        " を巡回位置系と呼ぶ。ただし",
      ]),
      displayMath(String.raw`\text{任意の }i,j\in P_f\text{ に対して、ある }r\in\mathbb N\text{ が存在して }s_f^{\circ r}(i)=j`),
      paragraph([
        "を要求する。ここで ",
        math(String.raw`s_f^{\circ r}`),
        " は写像 ",
        math(String.raw`s_f`),
        " の ",
        math(String.raw`r`),
        " 回合成であり、",
        math(String.raw`s_f^{\circ 0}=\operatorname{id}_{P_f}`),
        " とする。位置は有限集合 ",
        math(String.raw`P_f`),
        " の元であり、整数添字ではない。次位置は整数加算ではなく写像 ",
        math(String.raw`s_f`),
        " で選ぶ。",
      ]),
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
        math(String.raw`G=(V,E,\partial_G)`),
        " と ",
        ref("def_finite_cellulation_cell_sets"),
        " のセル集合入力 ",
        math(String.raw`\mathcal C_{\mathrm{cell}}=(V_{\mathrm{cell}},E_{\mathrm{cell}},F_{\mathrm{cell}})`),
        " が ",
        math(String.raw`V_{\mathrm{cell}}=V`),
        " および ",
        math(String.raw`E_{\mathrm{cell}}=E`),
        " を満たすとし、各面には ",
        ref("def_finite_cellulation_cyclic_position_system"),
        " の巡回位置系 ",
        math(String.raw`\mathcal P_f=(P_f,s_f)`),
        " が与えられているとする。各面 ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " の向き付き境界語を写像",
      ]),
      displayMath(String.raw`\partial_{\mathrm{word}}f:P_f\to E_{\mathrm{cell}}\times\mathsf{Ori},\qquad
\partial_{\mathrm{word}}f(i)=\bigl(e_{f,i},\omega_{f,i}\bigr)`),
      paragraph([
        "として定める。ここで各 ",
        math(String.raw`i\in P_f`),
        " に対し ",
        math(String.raw`e_{f,i}\in E_{\mathrm{cell}}`),
        " および ",
        math(String.raw`\omega_{f,i}\in\mathsf{Ori}`),
        " であり、接続条件",
      ]),
      displayMath(String.raw`\partial_G\!\left(e_{f,i},\tau(\omega_{f,i})\right)
=
\partial_G\!\left(e_{f,s_f(i)},\iota(\omega_{f,s_f(i)})\right)
\qquad(i\in P_f)`),
      paragraph([
        "を要求する。端点の選択には ",
        ref("def_finite_cellulation_orientation_endpoint_selectors"),
        " の写像 ",
        math(String.raw`\iota,\tau`),
        " を用い、次位置の選択には ",
        math(String.raw`s_f`),
        " を用いる。したがって接続条件は、各向き付き辺の終点が次の向き付き辺の始点に等しいことを、ラベルへの整数演算なしに述べる。",
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
    f\in F_{\mathrm{cell}},\quad i\in P_f,\\
    e_{f,i}=e
    \end{array}
  \right\}
\right|=2,\\[8pt]
\text{その相異なる二つの出現位置を }(f,i),(g,j)\text{ と書けば}\\[4pt]
\qquad \omega_{g,j}=\rho(\omega_{f,i}).
\end{cases}
\end{aligned}`),
      paragraph([
        "出現位置 ",
        math(String.raw`(f,i)`),
        " は有限集合 ",
        math(String.raw`\{(f,i)\mid f\in F_{\mathrm{cell}},\ i\in P_f\}`),
        " の元である。二つの出現位置は異なるが、二つの面は同じでもよい。向きの比較には ",
        ref("def_finite_cellulation_orientation_reversal"),
        " の反転写像 ",
        math(String.raw`\rho`),
        " だけを用いる。この述語は有限集合の列挙、元数、ラベルの等号だけで判定できる。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_corner_side_labels",
    kind: "definition",
    title: { text: "角に接する辺端の役割ラベル集合" },
    labels: ["def_finite_cellulation_corner_side_label_set"],
    habitat: "finite",
    statement: [
      paragraph(["一つの角へ到着する辺端と、その角から出発する辺端を区別する形式的ラベル集合を"]),
      displayMath(String.raw`\mathsf{CornerSide}:=\{\mathsf{arriving},\mathsf{departing}\}`),
      paragraph([
        "と定める。この二つは整数や符号ではなく、角に対する辺端の役割だけを表すラベルである。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_corner_edge_end_map",
    kind: "definition",
    title: { text: "角から辺端を選ぶ写像" },
    labels: ["def_finite_cellulation_corner_edge_end_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "各 ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " と ",
        math(String.raw`i\in P_f`),
        " に対し、角に接する辺端を選ぶ写像 ",
        math(String.raw`h_{f,i}:\mathsf{CornerSide}\to E_{\mathrm{cell}}\times\mathsf{End}`),
        " を",
      ]),
      displayMath(String.raw`\begin{aligned}
h_{f,i}(\mathsf{arriving})
&:=\bigl(e_{f,i},\tau(\omega_{f,i})\bigr),\\
h_{f,i}(\mathsf{departing})
&:=\bigl(e_{f,s_f(i)},\iota(\omega_{f,s_f(i)})\bigr)
\end{aligned}`),
      paragraph([
        "と定める。面境界語の接続条件により、二つの辺端は同じ頂点へ写る。",
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
        ref("def_finite_cellulation_corner_edge_end_map"),
        " の辺端選択写像に対し、各 ",
        math(String.raw`v\in V_{\mathrm{cell}}`),
        " における角位置の有限集合を",
      ]),
      displayMath(String.raw`C_v:=
\left\{
  (f,i)\ \middle|\
  \begin{array}{l}
  f\in F_{\mathrm{cell}},\quad i\in P_f,\\
  \partial_G\!\left(h_{f,i}(\mathsf{arriving})\right)=v
  \end{array}
\right\}`),
      paragraph(["また、同じ頂点へ写る辺端の有限集合を"]),
      displayMath(String.raw`H_v:=
\left\{
  (e,\xi)\in E_{\mathrm{cell}}\times\mathsf{End}
  \ \middle|\
  \ \partial_G(e,\xi)=v
\right\}`),
      paragraph([
        "と書く。各 ",
        math(String.raw`h\in H_v`),
        " に接する角側の有限集合を",
      ]),
      displayMath(String.raw`I_v(h):=
\left\{
  ((f,i),\alpha)\in C_v\times\mathsf{CornerSide}
  \ \middle|\
  \ h_{f,i}(\alpha)=h
\right\}`),
      paragraph([
        "と書く。角位置の有限集合と辺端の有限集合を同一視しない。頂点リンク単巡回述語 ",
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
|I_v(h)|=2
\quad
\left(
  \text{任意の }h\in H_v\text{ に対して}
\right),\\[12pt]
\text{任意の }c,c'\in C_v\text{ に対して、ある }r\in\mathbb N\text{ と}\\
\qquad c_j=(f_j,i_j)\in C_v\quad(0\le j\le r)\text{ が存在し、}\\
\qquad c_0=c,\quad c_r=c',\\
\qquad \{h_{f_j,i_j}(\alpha)\mid \alpha\in\mathsf{CornerSide}\}\\
\qquad \cap
\{h_{f_{j+1},i_{j+1}}(\alpha)\mid \alpha\in\mathsf{CornerSide}\}
\ne\varnothing\\
\qquad\left(j\in\mathbb N,\ 0\le j<r\right).
\end{cases}
\end{aligned}`),
      paragraph([
        math(String.raw`C_v`),
        "、辺端の集合、および角位置の列は有限集合に属し、",
        math(String.raw`r`),
        " と各元の個数は ",
        math(String.raw`\mathbb N`),
        " に属する。第二条件は各辺端に二つの角が接すること、第三条件は全ての角が辺端の共有によって一つにつながることを表す。辺端と角での役割は別々の形式的ラベル集合に属し、その間の選択は明示した写像だけを通す。この述語は有限集合の列挙と等号だけで判定できる。",
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
        math(String.raw`G=(V,E,\partial_G)`),
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
\{\partial_G(e_j,\mathsf{source}),\partial_G(e_j,\mathsf{target})\}=\{v_{j-1},v_j\}
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
        math(String.raw`G=(V,E,\partial_G)`),
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
        " で定めた有限述語である。第一条件が面境界の向きを全辺で整合させ、第二条件が各頂点の近傍を一つの円周にし、第三条件がセル分割全体を一つの連結成分にする。この連言は有限集合の列挙、元数、形式的ラベルの等号、真偽値演算だけで判定でき、整数環上の符号演算、実数・複素数・極限・積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_regular_type_set",
    kind: "definition",
    title: { text: "有限セル分割データの正則型集合" },
    labels: ["def_finite_cellulation_regular_type_set"],
    habitat: "finite",
    verification: ["sagemath/check/finite-cellulation-regular-type"],
    statement: [
      paragraph([
        ref("def_oriented_closed_surface_cellulation"),
        " を満たす有限セル分割の入力を、一つの構造化データ",
      ]),
      displayMath(String.raw`\mathcal X
:=
\left(
  G,
  \mathcal C_{\mathrm{cell}},
  \left(
    \mathcal P_f,
    \partial_{\mathrm{word}}f
  \right)_{f\in F_{\mathrm{cell}}}
\right)`),
      paragraph([
        "とまとめる。以下では ",
        math(String.raw`\mathcal X`),
        " が向き付け閉曲面条件",
      ]),
      displayMath(String.raw`\operatorname{OrientedClosedSurfaceCellulation}
\left(
  G,
  \mathcal C_{\mathrm{cell}},
  \bigl(\partial_{\mathrm{word}}f\bigr)_{f\in F_{\mathrm{cell}}}
\right)
=\mathrm{true}`),
      paragraph([
        "を満たすことを仮定する。面次数写像と頂点次数写像をそれぞれ",
      ]),
      displayMath(String.raw`\begin{aligned}
d_F^{\mathcal X}
&:F_{\mathrm{cell}}\longrightarrow\mathbb N_{>0},
&d_F^{\mathcal X}(f)&:=\lvert P_f\rvert,\\
d_V^{\mathcal X}
&:V_{\mathrm{cell}}\longrightarrow\mathbb N_{>0},
&d_V^{\mathcal X}(v)&:=\lvert C_v\rvert
\end{aligned}`),
      paragraph(["と定め、その像を有限集合"]),
      displayMath(String.raw`D_F(\mathcal X):=d_F^{\mathcal X}\!\left(F_{\mathrm{cell}}\right),
\qquad
D_V(\mathcal X):=d_V^{\mathcal X}\!\left(V_{\mathrm{cell}}\right)`),
      paragraph([
        "と書く。このとき、",
        math(String.raw`\mathcal X`),
        " の正則型集合を",
      ]),
      displayMath(String.raw`\operatorname{RegularTypes}(\mathcal X)
:=
\left\{
  (p,q)\in\mathbb N_{>0}^{\,2}
  \ \middle|\
  D_F(\mathcal X)=\{p\},\quad
  D_V(\mathcal X)=\{q\}
\right\}`),
      paragraph([
        ref("def_finite_cellulation_face_boundary_word"),
        " の有限集合 ",
        math(String.raw`P_f`),
        " は面 ",
        math(String.raw`f`),
        " の向き付き境界語に現れる辺の出現位置の集合であり、",
        ref("def_finite_cellulation_vertex_links_are_cycles"),
        " の有限集合 ",
        math(String.raw`C_v`),
        " は頂点 ",
        math(String.raw`v`),
        " に接する角の出現位置の集合である。したがって第一の元数条件は全ての面が ",
        math(String.raw`p`),
        " 個の辺出現を持つこと、第二の元数条件は全ての頂点に ",
        math(String.raw`q`),
        " 個の角出現が接することを表す。面や辺が境界語の中で反復する場合も、相異なる面や辺の個数へ置き換えず、有限の出現位置を数える。セル集合は空でないので、",
        math(String.raw`\operatorname{RegularTypes}(\mathcal X)`),
        " は空集合または一元集合である。この定義は真偽値述語を入れ子にせず、型の順序対を元にもつ有限集合を返す。実数・複素数・極限・積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_definition_hyperbolic_regular_type_set",
    kind: "definition",
    title: { text: "有限セル分割データの双曲正則型集合" },
    labels: ["def_finite_cellulation_hyperbolic_regular_type_set"],
    habitat: "N",
    verification: ["sagemath/check/finite-cellulation-hyperbolic-regular-type"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_regular_type_set"),
        " の正則型集合を用い、有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " の双曲正則型集合を",
      ]),
      displayMath(String.raw`\operatorname{HyperbolicRegularTypes}(\mathcal X)
:=
\left\{
  (p,q)\in\operatorname{RegularTypes}(\mathcal X)
  \ \middle|\
  2(p+q)<pq
\right\}`),
      paragraph([
        "と定める。これは ",
        math(String.raw`\operatorname{RegularTypes}(\mathcal X)`),
        " の部分集合であり、型の順序対 ",
        math(String.raw`(p,q)`),
        " が双曲条件を満たす場合だけその元を残す。条件は自然数の加法、乗法、順序比較だけで判定できる。逆数、双曲関数、実数、複素数、極限、積分は用いない。",
      ]),
    ],
  },
  {
    id: "finite_cellulation_theorem_regular_face_edge_incidence",
    kind: "theorem",
    title: { text: "正則セル分割の面と辺の incidence 等式" },
    labels: ["theorem_regular_cellulation_face_edge_incidence"],
    habitat: "N",
    verification: ["sagemath/check/regular-cellulation-face-edge-incidence"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と正則型 ",
        math(String.raw`(p,q)\in\operatorname{RegularTypes}(\mathcal X)`),
        " に対して、",
      ]),
      displayMath(String.raw`p\lvert F_{\mathrm{cell}}\rvert
=
2\lvert E_{\mathrm{cell}}\rvert
\in\mathbb N.`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        " であり、",
        math(String.raw`\lvert F_{\mathrm{cell}}\rvert,\lvert E_{\mathrm{cell}}\rvert\in\mathbb N`),
        " である。等式は面境界の有限な辺出現位置を二通りに数えるだけであり、実数・複素数・極限・積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        "全ての面境界に現れる辺出現位置の有限集合を",
      ]),
      displayMath(String.raw`\mathcal O_{\mathcal X}
:=
\left\{
  (f,i)
  \ \middle|\
  f\in F_{\mathrm{cell}},\ i\in P_f
\right\}`),
      paragraph([
        "と置く。",
        ref("def_finite_cellulation_regular_type_set"),
        " により全ての ",
        math(String.raw`f\in F_{\mathrm{cell}}`),
        " について ",
        math(String.raw`\lvert P_f\rvert=p`),
        " であり、",
        ref("def_finite_cellulation_opposite_edge_occurrences"),
        " により各 ",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " の出現位置ファイバーは二元である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
p\lvert F_{\mathrm{cell}}\rvert
&=
\sum_{f\in F_{\mathrm{cell}}}p
&&\bigl(\because\ \text{有限集合上の定数和}\bigr)\\
&=
\sum_{f\in F_{\mathrm{cell}}}\lvert P_f\rvert
&&\bigl(\because\ \text{正則型集合の定義}\bigr)\\
&=
\lvert\mathcal O_{\mathcal X}\rvert
&&\bigl(\because\ \text{面ごとの互いに素な有限和集合の元数}\bigr)\\
&=
\sum_{e\in E_{\mathrm{cell}}}
\left\lvert
  \left\{
    (f,i)\in\mathcal O_{\mathcal X}
    \ \middle|\
    e_{f,i}=e
  \right\}
\right\rvert
&&\bigl(\because\ \text{辺成分による有限ファイバー分割}\bigr)\\
&=
\sum_{e\in E_{\mathrm{cell}}}2
&&\bigl(\because\ \text{各辺の逆向き二回出現}\bigr)\\
&=
2\lvert E_{\mathrm{cell}}\rvert
&&\bigl(\because\ \text{有限集合上の定数和}\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_regular_vertex_edge_incidence",
    kind: "theorem",
    title: { text: "正則セル分割の頂点と辺の incidence 等式" },
    labels: ["theorem_regular_cellulation_vertex_edge_incidence"],
    habitat: "N",
    verification: ["sagemath/check/regular-cellulation-vertex-edge-incidence"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と正則型 ",
        math(String.raw`(p,q)\in\operatorname{RegularTypes}(\mathcal X)`),
        " に対して、",
      ]),
      displayMath(String.raw`q\lvert V_{\mathrm{cell}}\rvert
=
2\lvert E_{\mathrm{cell}}\rvert
\in\mathbb N.`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        " であり、",
        math(String.raw`\lvert V_{\mathrm{cell}}\rvert,\lvert E_{\mathrm{cell}}\rvert\in\mathbb N`),
        " である。等式は全ての角位置を頂点ごと・辺ごとに二通りに数えるだけであり、実数・複素数・極限・積分を用いない。",
      ]),
    ],
    proof: [
      paragraph(["全ての面境界に現れる角位置の有限集合を"]),
      displayMath(String.raw`\mathcal O_{\mathcal X}
:=
\left\{
  (f,i)
  \ \middle|\
  f\in F_{\mathrm{cell}},\ i\in P_f
\right\}`),
      paragraph([
        "と置く。",
        ref("def_finite_cellulation_regular_type_set"),
        " により全ての ",
        math(String.raw`v\in V_{\mathrm{cell}}`),
        " について ",
        math(String.raw`\lvert C_v\rvert=q`),
        " である。さらに ",
        ref("def_finite_cellulation_vertex_links_are_cycles"),
        " の定義により各角位置は到着側の辺端が写るただ一つの頂点の集合 ",
        math(String.raw`C_v`),
        " に属し、",
        ref("def_finite_cellulation_opposite_edge_occurrences"),
        " により各 ",
        math(String.raw`e\in E_{\mathrm{cell}}`),
        " の出現位置ファイバーは二元である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
q\lvert V_{\mathrm{cell}}\rvert
&=
\sum_{v\in V_{\mathrm{cell}}}q
&&\bigl(\because\ \text{有限集合上の定数和}\bigr)\\
&=
\sum_{v\in V_{\mathrm{cell}}}\lvert C_v\rvert
&&\bigl(\because\ \text{正則型集合の定義}\bigr)\\
&=
\lvert\mathcal O_{\mathcal X}\rvert
&&\bigl(\because\ \text{到着頂点による角位置の互いに素な有限和集合}\bigr)\\
&=
\sum_{e\in E_{\mathrm{cell}}}
\left\lvert
  \left\{
    (f,i)\in\mathcal O_{\mathcal X}
    \ \middle|\
    e_{f,i}=e
  \right\}
\right\rvert
&&\bigl(\because\ \text{辺成分による有限ファイバー分割}\bigr)\\
&=
\sum_{e\in E_{\mathrm{cell}}}2
&&\bigl(\because\ \text{各辺の逆向き二回出現}\bigr)\\
&=
2\lvert E_{\mathrm{cell}}\rvert
&&\bigl(\because\ \text{有限集合上の定数和}\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_regular_euler_incidence_identity",
    kind: "theorem",
    title: { text: "正則セル分割の Euler 標数と incidence 数の等式" },
    labels: ["theorem_regular_cellulation_euler_incidence_identity"],
    habitat: "Z",
    verification: ["sagemath/check/regular-cellulation-euler-incidence-identity"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と正則型 ",
        math(String.raw`(p,q)\in\operatorname{RegularTypes}(\mathcal X)`),
        " に対し、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q),\qquad
\bar e:=\iota_{\mathbb N,\mathbb Z}\!\left(\lvert E_{\mathrm{cell}}\rvert\right)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\bar p\,\bar q\,
\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)
=
\left(
  2\bar p+2\bar q-\bar p\,\bar q
\right)\bar e
\in\mathbb Z.`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q,\bar e\in\mathbb Z`),
        "、",
        math(String.raw`\chi_{\mathrm{cell}}(\mathcal C_{\mathrm{cell}})\in\mathbb Z`),
        " である。この等式は自然数の incidence 等式を標準単射で整数へ移して得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明中だけ用いる整数記号を ",
        math(String.raw`\bar v:=\iota_{\mathbb N,\mathbb Z}(\lvert V_{\mathrm{cell}}\rvert)`),
        "、",
        math(String.raw`\bar f:=\iota_{\mathbb N,\mathbb Z}(\lvert F_{\mathrm{cell}}\rvert)`),
        " と置く。自然数の二つの incidence 等式は、標準単射が加法と乗法を保つことにより整数の等式へ移される。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bar p\,\bar q\,\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)
&=
\bar p\,\bar q
\left(
  \bar v-\bar e+\bar f
\right)
&&\bigl(\because\ \text{\blkref{def_finite_cellulation_euler_characteristic}}\bigr)\\
&=
\bar p\,\bar q\,\bar v
-\bar p\,\bar q\,\bar e
+\bar p\,\bar q\,\bar f
&&\bigl(\because\ \text{整数の分配律}\bigr)\\
&=
\bar p\left(\bar q\,\bar v\right)
-\bar p\,\bar q\,\bar e
+\bar q\left(\bar p\,\bar f\right)
&&\bigl(\because\ \text{整数の乗法の結合律・交換律}\bigr)\\
&=
\bar p\,\iota_{\mathbb N,\mathbb Z}\!\left(q\lvert V_{\mathrm{cell}}\rvert\right)
-\bar p\,\bar q\,\bar e
+\bar q\,\iota_{\mathbb N,\mathbb Z}\!\left(p\lvert F_{\mathrm{cell}}\rvert\right)
&&\bigl(\because\ \text{標準単射は乗法を保つ}\bigr)\\
&=
\bar p\,\iota_{\mathbb N,\mathbb Z}\!\left(2\lvert E_{\mathrm{cell}}\rvert\right)
-\bar p\,\bar q\,\bar e
+\bar q\,\iota_{\mathbb N,\mathbb Z}\!\left(p\lvert F_{\mathrm{cell}}\rvert\right)
&&\bigl(\because\ \text{\blkref{theorem_regular_cellulation_vertex_edge_incidence}}\bigr)\\
&=
\bar p\left(2\bar e\right)
-\bar p\,\bar q\,\bar e
+\bar q\,\iota_{\mathbb N,\mathbb Z}\!\left(p\lvert F_{\mathrm{cell}}\rvert\right)
&&\bigl(\because\ \text{標準単射は乗法を保つ}\bigr)\\
&=
\bar p\left(2\bar e\right)
-\bar p\,\bar q\,\bar e
+\bar q\,\iota_{\mathbb N,\mathbb Z}\!\left(2\lvert E_{\mathrm{cell}}\rvert\right)
&&\bigl(\because\ \text{\blkref{theorem_regular_cellulation_face_edge_incidence}}\bigr)\\
&=
\bar p\left(2\bar e\right)
-\bar p\,\bar q\,\bar e
+\bar q\left(2\bar e\right)
&&\bigl(\because\ \text{標準単射は乗法を保つ}\bigr)\\
&=
\left(
  2\bar p+2\bar q-\bar p\,\bar q
\right)\bar e
&&\bigl(\because\ \text{整数の分配律}\bigr),
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_hyperbolic_regular_type_negative_euler_characteristic",
    kind: "theorem",
    title: { text: "双曲正則型をもつ有限セル分割の負の Euler 標数" },
    labels: ["theorem_hyperbolic_regular_type_negative_euler_characteristic"],
    habitat: "Z",
    verification: ["sagemath/check/hyperbolic-regular-type-negative-euler-characteristic"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対して、",
      ]),
      displayMath(String.raw`\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)<0
\quad\text{in }\mathbb Z.`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        " であり、Euler 標数は整数に属する。結論は自然数の双曲不等式と有限セル集合の元数だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        "自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q),\qquad
\bar e:=\iota_{\mathbb N,\mathbb Z}\!\left(\lvert E_{\mathrm{cell}}\rvert\right)`),
      paragraph([
        "と置く。双曲正則型集合の定義、標準単射の順序保存性、セル集合の非空性、および ",
        ref("theorem_regular_cellulation_euler_incidence_identity"),
        " を順に用いると、",
      ]),
      displayMath(String.raw`\begin{aligned}
2(p+q)&<pq
&&\bigl(\because\ \text{\blkref{def_finite_cellulation_hyperbolic_regular_type_set}}\bigr)\\
2\bar p+2\bar q&<\bar p\,\bar q
&&\bigl(\because\ \text{標準単射は加法・乗法・狭義順序を保つ}\bigr)\\
2\bar p+2\bar q-\bar p\,\bar q&<0
&&\bigl(\because\ \text{整数の加法による順序保存}\bigr)\\
0&<\bar e
&&\bigl(\because\ E_{\mathrm{cell}}\text{ は空でなく、標準単射は狭義順序を保つ}\bigr)\\
\left(
  2\bar p+2\bar q-\bar p\,\bar q
\right)\bar e&<0
&&\bigl(\because\ \text{負の整数と正の整数の積は負}\bigr)\\
\bar p\,\bar q\,
\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)&<0
&&\bigl(\because\ \text{\blkref{theorem_regular_cellulation_euler_incidence_identity}}\bigr)\\
0&<\bar p\,\bar q
&&\bigl(\because\ p,q\in\mathbb N_{>0}\text{ かつ標準単射は積と狭義順序を保つ}\bigr)\\
\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)&<0
&&\bigl(\because\ \text{正の整数による乗法は狭義順序を反映する}\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_hyperbolic_regular_type_iff_negative_euler_characteristic",
    kind: "theorem",
    title: { text: "正則型の双曲性と負の Euler 標数の同値性" },
    labels: ["theorem_hyperbolic_regular_type_iff_negative_euler_characteristic"],
    habitat: "Z",
    verification: ["sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と正則型 ",
        math(String.raw`(p,q)\in\operatorname{RegularTypes}(\mathcal X)`),
        " に対して、",
      ]),
      displayMath(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)
\quad\Longleftrightarrow\quad
\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)<0.`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        " であり、Euler 標数は整数に属する。この同値性は自然数の双曲不等式と整数の Euler incidence 等式だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        "自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q),\qquad
\bar e:=\iota_{\mathbb N,\mathbb Z}\!\left(\lvert E_{\mathrm{cell}}\rvert\right)`),
      paragraph(["順方向は既に証明した負性定理そのものである。"]),
      displayMath(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)
\Longrightarrow
\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)<0
\quad\bigl(\because\ \text{\blkref{theorem_hyperbolic_regular_type_negative_euler_characteristic}}\bigr).`),
      paragraph(["逆方向を示す。"]),
      displayMath(String.raw`\begin{aligned}
\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)<0
&\Longrightarrow
\bar p\,\bar q\,
\chi_{\mathrm{cell}}\!\left(\mathcal C_{\mathrm{cell}}\right)<0
&&\bigl(\because\ 0<\bar p\,\bar q\text{ かつ正の整数による乗法は狭義順序を保つ}\bigr)\\
&\Longrightarrow
\left(
  2\bar p+2\bar q-\bar p\,\bar q
\right)\bar e<0
&&\bigl(\because\ \text{\blkref{theorem_regular_cellulation_euler_incidence_identity}}\bigr)\\
&\Longrightarrow
2\bar p+2\bar q-\bar p\,\bar q<0
&&\bigl(\because\ 0<\bar e\text{ かつ正の整数による乗法は狭義順序を反映する}\bigr)\\
&\Longrightarrow
2\bar p+2\bar q<\bar p\,\bar q
&&\bigl(\because\ \text{整数の加法による順序保存}\bigr)\\
&\Longrightarrow
2(p+q)<pq
&&\bigl(\because\ \text{標準単射は加法・乗法・狭義順序を反映する}\bigr)\\
&\Longrightarrow
(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)
&&\bigl(\because\ \text{\blkref{def_finite_cellulation_hyperbolic_regular_type_set}}\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_hyperbolic_regular_type_product_difference_criterion",
    kind: "theorem",
    title: { text: "双曲正則型の積差による特徴付け" },
    labels: ["theorem_hyperbolic_regular_type_product_difference_criterion"],
    habitat: "Z",
    verification: ["sagemath/check/hyperbolic-regular-type-product-difference-criterion"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と正則型 ",
        math(String.raw`(p,q)\in\operatorname{RegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)
\quad\Longleftrightarrow\quad
4<\left(\bar p-2\right)\left(\bar q-2\right)
\quad\text{in }\mathbb Z.`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この同値性は自然数の双曲不等式を整数へ移して分配律で書き換えるだけで得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)
&\Longleftrightarrow 2(p+q)<pq
&&\bigl(\because\ \text{\blkref{def_finite_cellulation_hyperbolic_regular_type_set}}\bigr)\\
&\Longleftrightarrow 2\bar p+2\bar q<\bar p\,\bar q
&&\bigl(\because\ \text{標準単射は加法・乗法・狭義順序を保存し反映する}\bigr)\\
&\Longleftrightarrow 0<\bar p\,\bar q-2\bar p-2\bar q
&&\bigl(\because\ \text{整数の加法による狭義順序の保存と反映}\bigr)\\
&\Longleftrightarrow 4<\bar p\,\bar q-2\bar p-2\bar q+4
&&\bigl(\because\ \text{両辺への整数 }4\text{ の加法}\bigr)\\
&\Longleftrightarrow 4<\left(\bar p-2\right)\left(\bar q-2\right)
&&\bigl(\because\ \text{整数の分配律}\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_hyperbolic_regular_type_nonstrict_product_difference_criterion",
    kind: "theorem",
    title: { text: "双曲正則型の非狭義積差による特徴付け" },
    labels: ["theorem_hyperbolic_regular_type_nonstrict_product_difference_criterion"],
    habitat: "Z",
    verification: ["sagemath/check/hyperbolic-regular-type-nonstrict-product-difference-criterion"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と正則型 ",
        math(String.raw`(p,q)\in\operatorname{RegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)
\quad\Longleftrightarrow\quad
5\le\left(\bar p-2\right)\left(\bar q-2\right)
\quad\text{in }\mathbb Z.`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この同値性は直前の積差による特徴付けと整数順序の離散性だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)
&\Longleftrightarrow 4<\left(\bar p-2\right)\left(\bar q-2\right)
&&\bigl(\because\ \text{\blkref{theorem_hyperbolic_regular_type_product_difference_criterion}}\bigr)\\
&\Longleftrightarrow 5\le\left(\bar p-2\right)\left(\bar q-2\right)
&&\bigl(\because\ \text{整数順序の離散性}\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_hyperbolic_regular_type_degree_lower_bounds",
    kind: "theorem",
    title: { text: "双曲正則型の面次数と頂点次数の下界" },
    labels: ["theorem_hyperbolic_regular_type_degree_lower_bounds"],
    habitat: "N",
    verification: ["sagemath/check/hyperbolic-regular-type-degree-lower-bounds"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、",
      ]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad 3\le q\quad\text{in }\mathbb N.`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        " である。この下界は双曲正則型集合を定める自然数不等式だけから得られ、整数への移送、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`p\le2`), " と仮定する。このとき、"]),
      displayMath(String.raw`\begin{aligned}
pq
&\le 2q
&&\bigl(\because\ p\le2\text{ と }0<q\text{ による乗法順序保存}\bigr)\\
&<2p+2q
&&\bigl(\because\ 0<2p\text{ による加法順序保存}\bigr)\\
&=2(p+q)
&&\bigl(\because\ \text{自然数の分配律}\bigr)\\
&<pq
&&\bigl(\because\ \text{\blkref{def_finite_cellulation_hyperbolic_regular_type_set}}\bigr).
\end{aligned}`),
      paragraph(["これは ", math(String.raw`pq<pq`), " を与えて矛盾する。したがって、"]),
      displayMath(String.raw`\begin{aligned}
p\nleq2
&\Longrightarrow 2<p
&&\bigl(\because\ \mathbb N\text{ の全順序性}\bigr)\\
&\Longrightarrow 3\le p
&&\bigl(\because\ \mathbb N\text{ の順序の離散性}\bigr).
\end{aligned}`),
      paragraph([math(String.raw`q\le2`), " と仮定すると、同様に"]),
      displayMath(String.raw`\begin{aligned}
pq
&\le 2p
&&\bigl(\because\ q\le2\text{ と }0<p\text{ による乗法順序保存}\bigr)\\
&<2p+2q
&&\bigl(\because\ 0<2q\text{ による加法順序保存}\bigr)\\
&=2(p+q)
&&\bigl(\because\ \text{自然数の分配律}\bigr)\\
&<pq
&&\bigl(\because\ \text{\blkref{def_finite_cellulation_hyperbolic_regular_type_set}}\bigr).
\end{aligned}`),
      paragraph(["これは ", math(String.raw`pq<pq`), " を与えて矛盾する。したがって、"]),
      displayMath(String.raw`\begin{aligned}
q\nleq2
&\Longrightarrow 2<q
&&\bigl(\because\ \mathbb N\text{ の全順序性}\bigr)\\
&\Longrightarrow 3\le q
&&\bigl(\because\ \mathbb N\text{ の順序の離散性}\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_minimal_product_difference_hyperbolic_types",
    kind: "theorem",
    title: { text: "最小積差をもつ双曲正則型の分類" },
    labels: ["theorem_minimal_product_difference_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/minimal-product-difference-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=5
\quad\Longleftrightarrow\quad
(p,q)=(3,7)\ \text{または}\ (p,q)=(7,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=5
&\Longleftrightarrow ab=5
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,5)\ \text{または}\ (a,b)=(5,1)
&&\bigl(\because\ 5\text{ は素数であり }a,b>0\bigr)\\
&\Longleftrightarrow (p,q)=(3,7)\ \text{または}\ (p,q)=(7,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=6
\quad\Longleftrightarrow\quad
&(p,q)=(3,8)\ \text{または}\ (p,q)=(4,5)\\
&\text{または}\ (p,q)=(5,4)\ \text{または}\ (p,q)=(8,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=6
&\Longleftrightarrow ab=6
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,6)\ \text{または}\ (a,b)=(2,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,2)\ \text{または}\ (a,b)=(6,1)
&&\bigl(\because\ 6\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,8)\ \text{または}\ (p,q)=(4,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,4)\ \text{または}\ (p,q)=(8,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=7
\quad\Longleftrightarrow\quad
(p,q)=(3,9)\ \text{または}\ (p,q)=(9,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=7
&\Longleftrightarrow ab=7
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,7)\ \text{または}\ (a,b)=(7,1)
&&\bigl(\because\ 7\text{ は素数であり }a,b>0\bigr)\\
&\Longleftrightarrow (p,q)=(3,9)\ \text{または}\ (p,q)=(9,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=8
\quad\Longleftrightarrow\quad
&(p,q)=(3,10)\ \text{または}\ (p,q)=(4,6)\\
&\text{または}\ (p,q)=(6,4)\ \text{または}\ (p,q)=(10,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=8
&\Longleftrightarrow ab=8
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,8)\ \text{または}\ (a,b)=(2,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,2)\ \text{または}\ (a,b)=(8,1)
&&\bigl(\because\ 8\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,10)\ \text{または}\ (p,q)=(4,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,4)\ \text{または}\ (p,q)=(10,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=9
\quad\Longleftrightarrow\quad
&(p,q)=(3,11)\ \text{または}\ (p,q)=(5,5)\\
&\text{または}\ (p,q)=(11,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=9
&\Longleftrightarrow ab=9
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,9)\ \text{または}\ (a,b)=(3,3)\ \text{または}\ (a,b)=(9,1)
&&\bigl(\because\ 9\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,11)\ \text{または}\ (p,q)=(5,5)\ \text{または}\ (p,q)=(11,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ten_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ten_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ten-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=10
\quad\Longleftrightarrow\quad
&(p,q)=(3,12)\ \text{または}\ (p,q)=(4,7)\\
&\text{または}\ (p,q)=(7,4)\ \text{または}\ (p,q)=(12,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=10
&\Longleftrightarrow ab=10
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,10)\ \text{または}\ (a,b)=(2,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(5,2)\ \text{または}\ (a,b)=(10,1)
&&\bigl(\because\ 10\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,12)\ \text{または}\ (p,q)=(4,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(7,4)\ \text{または}\ (p,q)=(12,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eleven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eleven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eleven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=11
\quad\Longleftrightarrow\quad
(p,q)=(3,13)\ \text{または}\ (p,q)=(13,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数十一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=11
&\Longleftrightarrow ab=11
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,11)\ \text{または}\ (a,b)=(11,1)
&&\bigl(\because\ 11\text{ は素数であり }a,b>0\bigr)\\
&\Longleftrightarrow (p,q)=(3,13)\ \text{または}\ (p,q)=(13,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twelve_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twelve_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twelve-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=12
\quad\Longleftrightarrow\quad
&(p,q)=(3,14)\ \text{または}\ (p,q)=(4,8)\ \text{または}\\
&(p,q)=(5,6)\ \text{または}\ (p,q)=(6,5)\ \text{または}\\
&(p,q)=(8,4)\ \text{または}\ (p,q)=(14,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=12
&\Longleftrightarrow ab=12
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,12)\ \text{または}\ (a,b)=(2,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,4)\ \text{または}\ (a,b)=(4,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,2)\ \text{または}\ (a,b)=(12,1)
&&\bigl(\because\ 12\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,14)\ \text{または}\ (p,q)=(4,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,6)\ \text{または}\ (p,q)=(6,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,4)\ \text{または}\ (p,q)=(14,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirteen_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirteen_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirteen-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=13
\quad\Longleftrightarrow\quad
(p,q)=(3,15)\ \text{または}\ (p,q)=(15,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数十三の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=13
&\Longleftrightarrow ab=13
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,13)\ \text{または}\ (a,b)=(13,1)
&&\bigl(\because\ 13\text{ は素数であり }a,b>0\bigr)\\
&\Longleftrightarrow (p,q)=(3,15)\ \text{または}\ (p,q)=(15,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fourteen_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fourteen_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fourteen-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=14
\quad\Longleftrightarrow\quad
&(p,q)=(3,16)\ \text{または}\ (p,q)=(4,9)\ \text{または}\\
&(p,q)=(9,4)\ \text{または}\ (p,q)=(16,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=14
&\Longleftrightarrow ab=14
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,14)\ \text{または}\ (a,b)=(2,7)\ \text{または}\\
&\hspace{5.7em}(a,b)=(7,2)\ \text{または}\ (a,b)=(14,1)
&&\bigl(\because\ 14\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,16)\ \text{または}\ (p,q)=(4,9)\ \text{または}\\
&\hspace{5.7em}(p,q)=(9,4)\ \text{または}\ (p,q)=(16,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifteen_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifteen_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifteen-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=15
\quad\Longleftrightarrow\quad
&(p,q)=(3,17)\ \text{または}\ (p,q)=(5,7)\ \text{または}\\
&(p,q)=(7,5)\ \text{または}\ (p,q)=(17,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=15
&\Longleftrightarrow ab=15
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,15)\ \text{または}\ (a,b)=(3,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(5,3)\ \text{または}\ (a,b)=(15,1)
&&\bigl(\because\ 15\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,17)\ \text{または}\ (p,q)=(5,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(7,5)\ \text{または}\ (p,q)=(17,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixteen_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixteen_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixteen-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=16
\quad\Longleftrightarrow\quad
&(p,q)=(3,18)\ \text{または}\ (p,q)=(4,10)\ \text{または}\\
&(p,q)=(6,6)\ \text{または}\ (p,q)=(10,4)\ \text{または}\ (p,q)=(18,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=16
&\Longleftrightarrow ab=16
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,16)\ \text{または}\ (a,b)=(2,8)\ \text{または}\ (a,b)=(4,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(8,2)\ \text{または}\ (a,b)=(16,1)
&&\bigl(\because\ 16\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,18)\ \text{または}\ (p,q)=(4,10)\ \text{または}\ (p,q)=(6,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(10,4)\ \text{または}\ (p,q)=(18,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventeen_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventeen_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventeen-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=17
\quad\Longleftrightarrow\quad
(p,q)=(3,19)\ \text{または}\ (p,q)=(19,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数十七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=17
&\Longleftrightarrow ab=17
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,17)\ \text{または}\ (a,b)=(17,1)
&&\bigl(\because\ 17\text{ は素数であり }a,b>0\bigr)\\
&\Longleftrightarrow (p,q)=(3,19)\ \text{または}\ (p,q)=(19,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighteen_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighteen_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighteen-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=18
\quad\Longleftrightarrow\quad
&(p,q)=(3,20)\ \text{または}\ (p,q)=(4,11)\ \text{または}\ (p,q)=(5,8)\ \text{または}\\
&(p,q)=(8,5)\ \text{または}\ (p,q)=(11,4)\ \text{または}\ (p,q)=(20,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=18
&\Longleftrightarrow ab=18
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,18)\ \text{または}\ (a,b)=(2,9)\ \text{または}\ (a,b)=(3,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,3)\ \text{または}\ (a,b)=(9,2)\ \text{または}\ (a,b)=(18,1)
&&\bigl(\because\ 18\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,20)\ \text{または}\ (p,q)=(4,11)\ \text{または}\ (p,q)=(5,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,5)\ \text{または}\ (p,q)=(11,4)\ \text{または}\ (p,q)=(20,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_nineteen_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_nineteen_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-nineteen-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=19
\quad\Longleftrightarrow\quad
(p,q)=(3,21)\ \text{または}\ (p,q)=(21,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数十九の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=19
&\Longleftrightarrow ab=19
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,19)\ \text{または}\ (a,b)=(19,1)
&&\bigl(\because\ 19\text{ は素数であり }a,b>0\bigr)\\
&\Longleftrightarrow (p,q)=(3,21)\ \text{または}\ (p,q)=(21,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=20
\quad\Longleftrightarrow\quad
&(p,q)=(3,22)\ \text{または}\ (p,q)=(4,12)\ \text{または}\ (p,q)=(6,7)\ \text{または}\\
&(p,q)=(7,6)\ \text{または}\ (p,q)=(12,4)\ \text{または}\ (p,q)=(22,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、二十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=20
&\Longleftrightarrow ab=20
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,20)\ \text{または}\ (a,b)=(2,10)\ \text{または}\ (a,b)=(4,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(5,4)\ \text{または}\ (a,b)=(10,2)\ \text{または}\ (a,b)=(20,1)
&&\bigl(\because\ 20\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,22)\ \text{または}\ (p,q)=(4,12)\ \text{または}\ (p,q)=(6,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(7,6)\ \text{または}\ (p,q)=(12,4)\ \text{または}\ (p,q)=(22,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=21
\quad\Longleftrightarrow\quad
&(p,q)=(3,23)\ \text{または}\ (p,q)=(5,9)\ \text{または}\\
&(p,q)=(9,5)\ \text{または}\ (p,q)=(23,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、二十一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=21
&\Longleftrightarrow ab=21
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,21)\ \text{または}\ (a,b)=(3,7)\ \text{または}\\
&\hspace{5.7em}(a,b)=(7,3)\ \text{または}\ (a,b)=(21,1)
&&\bigl(\because\ 21\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,23)\ \text{または}\ (p,q)=(5,9)\ \text{または}\\
&\hspace{5.7em}(p,q)=(9,5)\ \text{または}\ (p,q)=(23,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=22
\quad\Longleftrightarrow\quad
&(p,q)=(3,24)\ \text{または}\ (p,q)=(4,13)\ \text{または}\\
&(p,q)=(13,4)\ \text{または}\ (p,q)=(24,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、二十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=22
&\Longleftrightarrow ab=22
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,22)\ \text{または}\ (a,b)=(2,11)\ \text{または}\\
&\hspace{5.7em}(a,b)=(11,2)\ \text{または}\ (a,b)=(22,1)
&&\bigl(\because\ 22\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,24)\ \text{または}\ (p,q)=(4,13)\ \text{または}\\
&\hspace{5.7em}(p,q)=(13,4)\ \text{または}\ (p,q)=(24,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=23
\quad\Longleftrightarrow\quad
(p,q)=(3,25)\ \text{または}\ (p,q)=(25,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数二十三の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=23
&\Longleftrightarrow ab=23
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,23)\ \text{または}\ (a,b)=(23,1)
&&\bigl(\because\ 23\text{ は素数であり }a,b>0\bigr)\\
&\Longleftrightarrow (p,q)=(3,25)\ \text{または}\ (p,q)=(25,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=24
\quad\Longleftrightarrow\quad
&(p,q)=(3,26)\ \text{または}\ (p,q)=(4,14)\ \text{または}\ (p,q)=(5,10)\ \text{または}\\
&(p,q)=(6,8)\ \text{または}\ (p,q)=(8,6)\ \text{または}\ (p,q)=(10,5)\ \text{または}\\
&(p,q)=(14,4)\ \text{または}\ (p,q)=(26,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、二十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=24
&\Longleftrightarrow ab=24
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,24)\ \text{または}\ (a,b)=(2,12)\ \text{または}\ (a,b)=(3,8)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,6)\ \text{または}\ (a,b)=(6,4)\ \text{または}\ (a,b)=(8,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(12,2)\ \text{または}\ (a,b)=(24,1)
&&\bigl(\because\ 24\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,26)\ \text{または}\ (p,q)=(4,14)\ \text{または}\ (p,q)=(5,10)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,8)\ \text{または}\ (p,q)=(8,6)\ \text{または}\ (p,q)=(10,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(14,4)\ \text{または}\ (p,q)=(26,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=25
\quad\Longleftrightarrow\quad
(p,q)=(3,27)\ \text{または}\ (p,q)=(7,7)\ \text{または}\ (p,q)=(27,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、二十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=25
&\Longleftrightarrow ab=25
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,25)\ \text{または}\ (a,b)=(5,5)\ \text{または}\ (a,b)=(25,1)
&&\bigl(\because\ 25\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,27)\ \text{または}\ (p,q)=(7,7)\ \text{または}\ (p,q)=(27,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=26
\quad\Longleftrightarrow\quad
&(p,q)=(3,28)\ \text{または}\ (p,q)=(4,15)\ \text{または}\\
&(p,q)=(15,4)\ \text{または}\ (p,q)=(28,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、二十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=26
&\Longleftrightarrow ab=26
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,26)\ \text{または}\ (a,b)=(2,13)\ \text{または}\\
&\hspace{5.7em}(a,b)=(13,2)\ \text{または}\ (a,b)=(26,1)
&&\bigl(\because\ 26\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,28)\ \text{または}\ (p,q)=(4,15)\ \text{または}\\
&\hspace{5.7em}(p,q)=(15,4)\ \text{または}\ (p,q)=(28,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=27
\quad\Longleftrightarrow\quad
&(p,q)=(3,29)\ \text{または}\ (p,q)=(5,11)\ \text{または}\\
&(p,q)=(11,5)\ \text{または}\ (p,q)=(29,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、二十七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=27
&\Longleftrightarrow ab=27
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,27)\ \text{または}\ (a,b)=(3,9)\ \text{または}\\
&\hspace{5.7em}(a,b)=(9,3)\ \text{または}\ (a,b)=(27,1)
&&\bigl(\because\ 27\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,29)\ \text{または}\ (p,q)=(5,11)\ \text{または}\\
&\hspace{5.7em}(p,q)=(11,5)\ \text{または}\ (p,q)=(29,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=28
\quad\Longleftrightarrow\quad
&(p,q)=(3,30)\ \text{または}\ (p,q)=(4,16)\ \text{または}\\
&(p,q)=(6,9)\ \text{または}\ (p,q)=(9,6)\ \text{または}\\
&(p,q)=(16,4)\ \text{または}\ (p,q)=(30,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、二十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=28
&\Longleftrightarrow ab=28
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,28)\ \text{または}\ (a,b)=(2,14)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,7)\ \text{または}\ (a,b)=(7,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(14,2)\ \text{または}\ (a,b)=(28,1)
&&\bigl(\because\ 28\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,30)\ \text{または}\ (p,q)=(4,16)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,9)\ \text{または}\ (p,q)=(9,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(16,4)\ \text{または}\ (p,q)=(30,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_twenty_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差二十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_twenty_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-twenty-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=29
\quad\Longleftrightarrow\quad
(p,q)=(3,31)\ \text{または}\ (p,q)=(31,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数二十九の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=29
&\Longleftrightarrow ab=29
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,29)\ \text{または}\ (a,b)=(29,1)
&&\bigl(\because\ 29\text{ は素数}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,31)\ \text{または}\ (p,q)=(31,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=30
\quad\Longleftrightarrow\quad
&(p,q)=(3,32)\ \text{または}\ (p,q)=(4,17)\ \text{または}\\
&(p,q)=(5,12)\ \text{または}\ (p,q)=(7,8)\ \text{または}\\
&(p,q)=(8,7)\ \text{または}\ (p,q)=(12,5)\ \text{または}\\
&(p,q)=(17,4)\ \text{または}\ (p,q)=(32,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=30
&\Longleftrightarrow ab=30
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,30)\ \text{または}\ (a,b)=(2,15)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,10)\ \text{または}\ (a,b)=(5,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,5)\ \text{または}\ (a,b)=(10,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(15,2)\ \text{または}\ (a,b)=(30,1)
&&\bigl(\because\ 30\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,32)\ \text{または}\ (p,q)=(4,17)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,12)\ \text{または}\ (p,q)=(7,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,7)\ \text{または}\ (p,q)=(12,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(17,4)\ \text{または}\ (p,q)=(32,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=31
\quad\Longleftrightarrow\quad
(p,q)=(3,33)\ \text{または}\ (p,q)=(33,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、素数三十一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=31
&\Longleftrightarrow ab=31
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,31)\ \text{または}\ (a,b)=(31,1)
&&\bigl(\because\ 31\text{ は素数}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,33)\ \text{または}\ (p,q)=(33,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=32
\quad\Longleftrightarrow\quad
&(p,q)=(3,34)\ \text{または}\ (p,q)=(4,18)\ \text{または}\\
&(p,q)=(6,10)\ \text{または}\ (p,q)=(10,6)\ \text{または}\\
&(p,q)=(18,4)\ \text{または}\ (p,q)=(34,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=32
&\Longleftrightarrow ab=32
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,32)\ \text{または}\ (a,b)=(2,16)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,8)\ \text{または}\ (a,b)=(8,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(16,2)\ \text{または}\ (a,b)=(32,1)
&&\bigl(\because\ 32\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,34)\ \text{または}\ (p,q)=(4,18)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,10)\ \text{または}\ (p,q)=(10,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(18,4)\ \text{または}\ (p,q)=(34,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=33
\quad\Longleftrightarrow\quad
&(p,q)=(3,35)\ \text{または}\ (p,q)=(5,13)\ \text{または}\\
&(p,q)=(13,5)\ \text{または}\ (p,q)=(35,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十三の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=33
&\Longleftrightarrow ab=33
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,33)\ \text{または}\ (a,b)=(3,11)\ \text{または}\\
&\hspace{5.7em}(a,b)=(11,3)\ \text{または}\ (a,b)=(33,1)
&&\bigl(\because\ 33\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,35)\ \text{または}\ (p,q)=(5,13)\ \text{または}\\
&\hspace{5.7em}(p,q)=(13,5)\ \text{または}\ (p,q)=(35,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=34
\quad\Longleftrightarrow\quad
&(p,q)=(3,36)\ \text{または}\ (p,q)=(4,19)\ \text{または}\\
&(p,q)=(19,4)\ \text{または}\ (p,q)=(36,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=34
&\Longleftrightarrow ab=34
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,34)\ \text{または}\ (a,b)=(2,17)\ \text{または}\\
&\hspace{5.7em}(a,b)=(17,2)\ \text{または}\ (a,b)=(34,1)
&&\bigl(\because\ 34\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,36)\ \text{または}\ (p,q)=(4,19)\ \text{または}\\
&\hspace{5.7em}(p,q)=(19,4)\ \text{または}\ (p,q)=(36,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=35
\quad\Longleftrightarrow\quad
&(p,q)=(3,37)\ \text{または}\ (p,q)=(7,9)\ \text{または}\\
&(p,q)=(9,7)\ \text{または}\ (p,q)=(37,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=35
&\Longleftrightarrow ab=35
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,35)\ \text{または}\ (a,b)=(5,7)\ \text{または}\\
&\hspace{5.7em}(a,b)=(7,5)\ \text{または}\ (a,b)=(35,1)
&&\bigl(\because\ 35\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,37)\ \text{または}\ (p,q)=(7,9)\ \text{または}\\
&\hspace{5.7em}(p,q)=(9,7)\ \text{または}\ (p,q)=(37,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=36
\quad\Longleftrightarrow\quad
&(p,q)=(3,38)\ \text{または}\ (p,q)=(4,20)\ \text{または}\\
&(p,q)=(5,14)\ \text{または}\ (p,q)=(6,11)\ \text{または}\\
&(p,q)=(8,8)\ \text{または}\ (p,q)=(11,6)\ \text{または}\\
&(p,q)=(14,5)\ \text{または}\ (p,q)=(20,4)\ \text{または}\\
&(p,q)=(38,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=36
&\Longleftrightarrow ab=36
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,36)\ \text{または}\ (a,b)=(2,18)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,12)\ \text{または}\ (a,b)=(4,9)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,6)\ \text{または}\ (a,b)=(9,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(12,3)\ \text{または}\ (a,b)=(18,2)\ \text{または}\\
&\hspace{5.7em}(a,b)=(36,1)
&&\bigl(\because\ 36\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,38)\ \text{または}\ (p,q)=(4,20)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,14)\ \text{または}\ (p,q)=(6,11)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,8)\ \text{または}\ (p,q)=(11,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(14,5)\ \text{または}\ (p,q)=(20,4)\ \text{または}\\
&\hspace{5.7em}(p,q)=(38,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=37
\quad\Longleftrightarrow\quad
(p,q)=(3,39)\ \text{または}\ (p,q)=(39,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十七の素数性、三十七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=37
&\Longleftrightarrow ab=37
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,37)\ \text{または}\ (a,b)=(37,1)
&&\bigl(\because\ 37\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow (p,q)=(3,39)\ \text{または}\ (p,q)=(39,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=38
\quad\Longleftrightarrow\quad
&(p,q)=(3,40)\ \text{または}\ (p,q)=(4,21)\ \text{または}\\
&(p,q)=(21,4)\ \text{または}\ (p,q)=(40,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=38
&\Longleftrightarrow ab=38
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,38)\ \text{または}\ (a,b)=(2,19)\ \text{または}\\
&\hspace{5.7em}(a,b)=(19,2)\ \text{または}\ (a,b)=(38,1)
&&\bigl(\because\ 38\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,40)\ \text{または}\ (p,q)=(4,21)\ \text{または}\\
&\hspace{5.7em}(p,q)=(21,4)\ \text{または}\ (p,q)=(40,3)
      &&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_thirty_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差三十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_thirty_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-thirty-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=39
\quad\Longleftrightarrow\quad
&(p,q)=(3,41)\ \text{または}\ (p,q)=(5,15)\ \text{または}\\
&(p,q)=(15,5)\ \text{または}\ (p,q)=(41,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、三十九の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=39
&\Longleftrightarrow ab=39
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,39)\ \text{または}\ (a,b)=(3,13)\ \text{または}\\
&\hspace{5.7em}(a,b)=(13,3)\ \text{または}\ (a,b)=(39,1)
&&\bigl(\because\ 39\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,41)\ \text{または}\ (p,q)=(5,15)\ \text{または}\\
&\hspace{5.7em}(p,q)=(15,5)\ \text{または}\ (p,q)=(41,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=40
\quad\Longleftrightarrow\quad
&(p,q)=(3,42)\ \text{または}\ (p,q)=(4,22)\ \text{または}\\
&(p,q)=(6,12)\ \text{または}\ (p,q)=(7,10)\ \text{または}\\
&(p,q)=(10,7)\ \text{または}\ (p,q)=(12,6)\ \text{または}\\
&(p,q)=(22,4)\ \text{または}\ (p,q)=(42,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=40
&\Longleftrightarrow ab=40
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,40)\ \text{または}\ (a,b)=(2,20)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,10)\ \text{または}\ (a,b)=(5,8)\ \text{または}\\
&\hspace{5.7em}(a,b)=(8,5)\ \text{または}\ (a,b)=(10,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(20,2)\ \text{または}\ (a,b)=(40,1)
&&\bigl(\because\ 40\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,42)\ \text{または}\ (p,q)=(4,22)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,12)\ \text{または}\ (p,q)=(7,10)\ \text{または}\\
&\hspace{5.7em}(p,q)=(10,7)\ \text{または}\ (p,q)=(12,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(22,4)\ \text{または}\ (p,q)=(42,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=41
\quad\Longleftrightarrow\quad
(p,q)=(3,43)\ \text{または}\ (p,q)=(43,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十一の素数性、四十一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=41
&\Longleftrightarrow ab=41
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,41)\ \text{または}\ (a,b)=(41,1)
&&\bigl(\because\ 41\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow (p,q)=(3,43)\ \text{または}\ (p,q)=(43,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=42
\quad\Longleftrightarrow\quad
&(p,q)=(3,44)\ \text{または}\ (p,q)=(4,23)\ \text{または}\\
&(p,q)=(5,16)\ \text{または}\ (p,q)=(8,9)\ \text{または}\\
&(p,q)=(9,8)\ \text{または}\ (p,q)=(16,5)\ \text{または}\\
&(p,q)=(23,4)\ \text{または}\ (p,q)=(44,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=42
&\Longleftrightarrow ab=42
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,42)\ \text{または}\ (a,b)=(2,21)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,14)\ \text{または}\ (a,b)=(6,7)\ \text{または}\\
&\hspace{5.7em}(a,b)=(7,6)\ \text{または}\ (a,b)=(14,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(21,2)\ \text{または}\ (a,b)=(42,1)
&&\bigl(\because\ 42\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,44)\ \text{または}\ (p,q)=(4,23)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,16)\ \text{または}\ (p,q)=(8,9)\ \text{または}\\
&\hspace{5.7em}(p,q)=(9,8)\ \text{または}\ (p,q)=(16,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(23,4)\ \text{または}\ (p,q)=(44,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=43
\quad\Longleftrightarrow\quad
(p,q)=(3,45)\ \text{または}\ (p,q)=(45,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十三の素数性、四十三の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=43
&\Longleftrightarrow ab=43
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,43)\ \text{または}\ (a,b)=(43,1)
&&\bigl(\because\ 43\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow (p,q)=(3,45)\ \text{または}\ (p,q)=(45,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=44
\quad\Longleftrightarrow\quad
&(p,q)=(3,46)\ \text{または}\ (p,q)=(4,24)\ \text{または}\ (p,q)=(6,13)\ \text{または}\\
&(p,q)=(13,6)\ \text{または}\ (p,q)=(24,4)\ \text{または}\ (p,q)=(46,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=44
&\Longleftrightarrow ab=44
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,44)\ \text{または}\ (a,b)=(2,22)\ \text{または}\ (a,b)=(4,11)\ \text{または}\\
&\hspace{5.7em}(a,b)=(11,4)\ \text{または}\ (a,b)=(22,2)\ \text{または}\ (a,b)=(44,1)
&&\bigl(\because\ 44\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,46)\ \text{または}\ (p,q)=(4,24)\ \text{または}\ (p,q)=(6,13)\ \text{または}\\
&\hspace{5.7em}(p,q)=(13,6)\ \text{または}\ (p,q)=(24,4)\ \text{または}\ (p,q)=(46,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=45
\quad\Longleftrightarrow\quad
&(p,q)=(3,47)\ \text{または}\ (p,q)=(5,17)\ \text{または}\ (p,q)=(7,11)\ \text{または}\\
&(p,q)=(11,7)\ \text{または}\ (p,q)=(17,5)\ \text{または}\ (p,q)=(47,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=45
&\Longleftrightarrow ab=45
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,45)\ \text{または}\ (a,b)=(3,15)\ \text{または}\ (a,b)=(5,9)\ \text{または}\\
&\hspace{5.7em}(a,b)=(9,5)\ \text{または}\ (a,b)=(15,3)\ \text{または}\ (a,b)=(45,1)
&&\bigl(\because\ 45\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,47)\ \text{または}\ (p,q)=(5,17)\ \text{または}\ (p,q)=(7,11)\ \text{または}\\
&\hspace{5.7em}(p,q)=(11,7)\ \text{または}\ (p,q)=(17,5)\ \text{または}\ (p,q)=(47,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=46
\quad\Longleftrightarrow\quad
&(p,q)=(3,48)\ \text{または}\ (p,q)=(4,25)\ \text{または}\\
&(p,q)=(25,4)\ \text{または}\ (p,q)=(48,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=46
&\Longleftrightarrow ab=46
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,46)\ \text{または}\ (a,b)=(2,23)\ \text{または}\\
&\hspace{5.7em}(a,b)=(23,2)\ \text{または}\ (a,b)=(46,1)
&&\bigl(\because\ 46\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,48)\ \text{または}\ (p,q)=(4,25)\ \text{または}\\
&\hspace{5.7em}(p,q)=(25,4)\ \text{または}\ (p,q)=(48,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=47
\quad\Longleftrightarrow\quad
(p,q)=(3,49)\ \text{または}\ (p,q)=(49,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十七の素数性、四十七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=47
&\Longleftrightarrow ab=47
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,47)\ \text{または}\ (a,b)=(47,1)
&&\bigl(\because\ 47\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow (p,q)=(3,49)\ \text{または}\ (p,q)=(49,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=48
\quad\Longleftrightarrow\quad
&(p,q)=(3,50)\ \text{または}\ (p,q)=(4,26)\ \text{または}\ (p,q)=(5,18)\ \text{または}\\
&(p,q)=(6,14)\ \text{または}\ (p,q)=(8,10)\ \text{または}\ (p,q)=(10,8)\ \text{または}\\
&(p,q)=(14,6)\ \text{または}\ (p,q)=(18,5)\ \text{または}\ (p,q)=(26,4)\ \text{または}\\
&(p,q)=(50,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=48
&\Longleftrightarrow ab=48
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,48)\ \text{または}\ (a,b)=(2,24)\ \text{または}\ (a,b)=(3,16)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,12)\ \text{または}\ (a,b)=(6,8)\ \text{または}\ (a,b)=(8,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(12,4)\ \text{または}\ (a,b)=(16,3)\ \text{または}\ (a,b)=(24,2)\ \text{または}\\
&\hspace{5.7em}(a,b)=(48,1)
&&\bigl(\because\ 48\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,50)\ \text{または}\ (p,q)=(4,26)\ \text{または}\ (p,q)=(5,18)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,14)\ \text{または}\ (p,q)=(8,10)\ \text{または}\ (p,q)=(10,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(14,6)\ \text{または}\ (p,q)=(18,5)\ \text{または}\ (p,q)=(26,4)\ \text{または}\\
&\hspace{5.7em}(p,q)=(50,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_forty_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差四十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_forty_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-forty-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=49
\quad\Longleftrightarrow\quad
(p,q)=(3,51)\ \text{または}\ (p,q)=(9,9)\ \text{または}\ (p,q)=(51,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、四十九の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=49
&\Longleftrightarrow ab=49
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,49)\ \text{または}\ (a,b)=(7,7)\ \text{または}\ (a,b)=(49,1)
&&\bigl(\because\ 49\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,51)\ \text{または}\ (p,q)=(9,9)\ \text{または}\ (p,q)=(51,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=50
\quad\Longleftrightarrow\quad
(p,q)=(3,52)\ \text{または}\ (p,q)=(4,27)\ \text{または}\ (p,q)=(7,12)\ \text{または}\\
\hspace{9.5em}(p,q)=(12,7)\ \text{または}\ (p,q)=(27,4)\ \text{または}\ (p,q)=(52,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=50
&\Longleftrightarrow ab=50
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,50)\ \text{または}\ (a,b)=(2,25)\ \text{または}\ (a,b)=(5,10)\ \text{または}\\
&\hspace{5.7em}(a,b)=(10,5)\ \text{または}\ (a,b)=(25,2)\ \text{または}\ (a,b)=(50,1)
&&\bigl(\because\ 50\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,52)\ \text{または}\ (p,q)=(4,27)\ \text{または}\ (p,q)=(7,12)\ \text{または}\\
&\hspace{5.7em}(p,q)=(12,7)\ \text{または}\ (p,q)=(27,4)\ \text{または}\ (p,q)=(52,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=51
\quad\Longleftrightarrow\quad
(p,q)=(3,53)\ \text{または}\ (p,q)=(5,19)\ \text{または}\\
\hspace{9.5em}(p,q)=(19,5)\ \text{または}\ (p,q)=(53,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=51
&\Longleftrightarrow ab=51
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,51)\ \text{または}\ (a,b)=(3,17)\ \text{または}\\
&\hspace{5.7em}(a,b)=(17,3)\ \text{または}\ (a,b)=(51,1)
&&\bigl(\because\ 51\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,53)\ \text{または}\ (p,q)=(5,19)\ \text{または}\\
&\hspace{5.7em}(p,q)=(19,5)\ \text{または}\ (p,q)=(53,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=52
\quad\Longleftrightarrow\quad
&(p,q)=(3,54)\ \text{または}\ (p,q)=(4,28)\ \text{または}\ (p,q)=(6,15)\ \text{または}\\
\hspace{9.5em}&(p,q)=(15,6)\ \text{または}\ (p,q)=(28,4)\ \text{または}\ (p,q)=(54,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=52
&\Longleftrightarrow ab=52
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,52)\ \text{または}\ (a,b)=(2,26)\ \text{または}\ (a,b)=(4,13)\ \text{または}\\
&\hspace{5.7em}(a,b)=(13,4)\ \text{または}\ (a,b)=(26,2)\ \text{または}\ (a,b)=(52,1)
&&\bigl(\because\ 52\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,54)\ \text{または}\ (p,q)=(4,28)\ \text{または}\ (p,q)=(6,15)\ \text{または}\\
&\hspace{5.7em}(p,q)=(15,6)\ \text{または}\ (p,q)=(28,4)\ \text{または}\ (p,q)=(54,3)
      &&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=53
\quad\Longleftrightarrow\quad
(p,q)=(3,55)\ \text{または}\ (p,q)=(55,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十三の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=53
&\Longleftrightarrow ab=53
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,53)\ \text{または}\ (a,b)=(53,1)
&&\bigl(\because\ 53\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,55)\ \text{または}\ (p,q)=(55,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=54
\quad\Longleftrightarrow\quad
&(p,q)=(3,56)\ \text{または}\ (p,q)=(4,29)\ \text{または}\ (p,q)=(5,20)\ \text{または}\ (p,q)=(8,11)\ \text{または}\\
\hspace{9.5em}&(p,q)=(11,8)\ \text{または}\ (p,q)=(20,5)\ \text{または}\ (p,q)=(29,4)\ \text{または}\ (p,q)=(56,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=54
&\Longleftrightarrow ab=54
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,54)\ \text{または}\ (a,b)=(2,27)\ \text{または}\ (a,b)=(3,18)\ \text{または}\ (a,b)=(6,9)\ \text{または}\\
&\hspace{5.7em}(a,b)=(9,6)\ \text{または}\ (a,b)=(18,3)\ \text{または}\ (a,b)=(27,2)\ \text{または}\ (a,b)=(54,1)
&&\bigl(\because\ 54\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,56)\ \text{または}\ (p,q)=(4,29)\ \text{または}\ (p,q)=(5,20)\ \text{または}\ (p,q)=(8,11)\ \text{または}\\
&\hspace{5.7em}(p,q)=(11,8)\ \text{または}\ (p,q)=(20,5)\ \text{または}\ (p,q)=(29,4)\ \text{または}\ (p,q)=(56,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=55
\quad\Longleftrightarrow\quad
(p,q)=(3,57)\ \text{または}\ (p,q)=(7,13)\ \text{または}\\
\hspace{9.5em}(p,q)=(13,7)\ \text{または}\ (p,q)=(57,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=55
&\Longleftrightarrow ab=55
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,55)\ \text{または}\ (a,b)=(5,11)\ \text{または}\\
&\hspace{5.7em}(a,b)=(11,5)\ \text{または}\ (a,b)=(55,1)
&&\bigl(\because\ 55\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,57)\ \text{または}\ (p,q)=(7,13)\ \text{または}\\
&\hspace{5.7em}(p,q)=(13,7)\ \text{または}\ (p,q)=(57,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=56
\quad\Longleftrightarrow\quad
&(p,q)=(3,58)\ \text{または}\ (p,q)=(4,30)\ \text{または}\ (p,q)=(6,16)\ \text{または}\ (p,q)=(9,10)\ \text{または}\\
\hspace{9.5em}&(p,q)=(10,9)\ \text{または}\ (p,q)=(16,6)\ \text{または}\ (p,q)=(30,4)\ \text{または}\ (p,q)=(58,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=56
&\Longleftrightarrow ab=56
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,56)\ \text{または}\ (a,b)=(2,28)\ \text{または}\ (a,b)=(4,14)\ \text{または}\ (a,b)=(7,8)\ \text{または}\\
&\hspace{5.7em}(a,b)=(8,7)\ \text{または}\ (a,b)=(14,4)\ \text{または}\ (a,b)=(28,2)\ \text{または}\ (a,b)=(56,1)
&&\bigl(\because\ 56\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,58)\ \text{または}\ (p,q)=(4,30)\ \text{または}\ (p,q)=(6,16)\ \text{または}\ (p,q)=(9,10)\ \text{または}\\
&\hspace{5.7em}(p,q)=(10,9)\ \text{または}\ (p,q)=(16,6)\ \text{または}\ (p,q)=(30,4)\ \text{または}\ (p,q)=(58,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=57
\quad\Longleftrightarrow\quad
(p,q)=(3,59)\ \text{または}\ (p,q)=(5,21)\ \text{または}\\
\hspace{9.5em}(p,q)=(21,5)\ \text{または}\ (p,q)=(59,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=57
&\Longleftrightarrow ab=57
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,57)\ \text{または}\ (a,b)=(3,19)\ \text{または}\\
&\hspace{5.7em}(a,b)=(19,3)\ \text{または}\ (a,b)=(57,1)
&&\bigl(\because\ 57\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,59)\ \text{または}\ (p,q)=(5,21)\ \text{または}\\
&\hspace{5.7em}(p,q)=(21,5)\ \text{または}\ (p,q)=(59,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=58
\quad\Longleftrightarrow\quad
(p,q)=(3,60)\ \text{または}\ (p,q)=(4,31)\ \text{または}\\
\hspace{9.5em}(p,q)=(31,4)\ \text{または}\ (p,q)=(60,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=58
&\Longleftrightarrow ab=58
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,58)\ \text{または}\ (a,b)=(2,29)\ \text{または}\\
&\hspace{5.7em}(a,b)=(29,2)\ \text{または}\ (a,b)=(58,1)
&&\bigl(\because\ 58\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,60)\ \text{または}\ (p,q)=(4,31)\ \text{または}\\
&\hspace{5.7em}(p,q)=(31,4)\ \text{または}\ (p,q)=(60,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_fifty_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差五十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_fifty_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-fifty-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=59
\quad\Longleftrightarrow\quad
(p,q)=(3,61)\ \text{または}\ (p,q)=(61,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、五十九の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=59
&\Longleftrightarrow ab=59
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,59)\ \text{または}\ (a,b)=(59,1)
&&\bigl(\because\ 59\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,61)\ \text{または}\ (p,q)=(61,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=60
\quad\Longleftrightarrow\quad
(p,q)=(3,62)\ \text{または}\ (p,q)=(4,32)\ \text{または}\\
\hspace{9.5em}(p,q)=(5,22)\ \text{または}\ (p,q)=(6,17)\ \text{または}\\
\hspace{9.5em}(p,q)=(7,14)\ \text{または}\ (p,q)=(8,12)\ \text{または}\\
\hspace{9.5em}(p,q)=(12,8)\ \text{または}\ (p,q)=(14,7)\ \text{または}\\
\hspace{9.5em}(p,q)=(17,6)\ \text{または}\ (p,q)=(22,5)\ \text{または}\\
\hspace{9.5em}(p,q)=(32,4)\ \text{または}\ (p,q)=(62,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=60
&\Longleftrightarrow ab=60
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,60)\ \text{または}\ (a,b)=(2,30)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,20)\ \text{または}\ (a,b)=(4,15)\ \text{または}\\
&\hspace{5.7em}(a,b)=(5,12)\ \text{または}\ (a,b)=(6,10)\ \text{または}\\
&\hspace{5.7em}(a,b)=(10,6)\ \text{または}\ (a,b)=(12,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(15,4)\ \text{または}\ (a,b)=(20,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(30,2)\ \text{または}\ (a,b)=(60,1)
&&\bigl(\because\ 60\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,62)\ \text{または}\ (p,q)=(4,32)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,22)\ \text{または}\ (p,q)=(6,17)\ \text{または}\\
&\hspace{5.7em}(p,q)=(7,14)\ \text{または}\ (p,q)=(8,12)\ \text{または}\\
&\hspace{5.7em}(p,q)=(12,8)\ \text{または}\ (p,q)=(14,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(17,6)\ \text{または}\ (p,q)=(22,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(32,4)\ \text{または}\ (p,q)=(62,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=61
\quad\Longleftrightarrow\quad
(p,q)=(3,63)\ \text{または}\ (p,q)=(63,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十一の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=61
&\Longleftrightarrow ab=61
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,61)\ \text{または}\ (a,b)=(61,1)
&&\bigl(\because\ 61\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,63)\ \text{または}\ (p,q)=(63,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=62
\quad\Longleftrightarrow\quad
(p,q)=(3,64)\ \text{または}\ (p,q)=(4,33)\ \text{または}\\
\hspace{9.5em}(p,q)=(33,4)\ \text{または}\ (p,q)=(64,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=62
&\Longleftrightarrow ab=62
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,62)\ \text{または}\ (a,b)=(2,31)\ \text{または}\\
&\hspace{5.7em}(a,b)=(31,2)\ \text{または}\ (a,b)=(62,1)
&&\bigl(\because\ 62\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,64)\ \text{または}\ (p,q)=(4,33)\ \text{または}\\
&\hspace{5.7em}(p,q)=(33,4)\ \text{または}\ (p,q)=(64,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=63
\quad\Longleftrightarrow\quad
(p,q)=(3,65)\ \text{または}\ (p,q)=(5,23)\ \text{または}\\
\hspace{9.5em}(p,q)=(9,11)\ \text{または}\ (p,q)=(11,9)\ \text{または}\\
\hspace{9.5em}(p,q)=(23,5)\ \text{または}\ (p,q)=(65,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十三の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=63
&\Longleftrightarrow ab=63
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,63)\ \text{または}\ (a,b)=(3,21)\ \text{または}\\
&\hspace{5.7em}(a,b)=(7,9)\ \text{または}\ (a,b)=(9,7)\ \text{または}\\
&\hspace{5.7em}(a,b)=(21,3)\ \text{または}\ (a,b)=(63,1)
&&\bigl(\because\ 63\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,65)\ \text{または}\ (p,q)=(5,23)\ \text{または}\\
&\hspace{5.7em}(p,q)=(9,11)\ \text{または}\ (p,q)=(11,9)\ \text{または}\\
&\hspace{5.7em}(p,q)=(23,5)\ \text{または}\ (p,q)=(65,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=64
\quad\Longleftrightarrow\quad
(p,q)=(3,66)\ \text{または}\ (p,q)=(4,34)\ \text{または}\\
\hspace{9.5em}(p,q)=(6,18)\ \text{または}\ (p,q)=(10,10)\ \text{または}\\
\hspace{9.5em}(p,q)=(18,6)\ \text{または}\ (p,q)=(34,4)\ \text{または}\\
\hspace{9.5em}(p,q)=(66,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=64
&\Longleftrightarrow ab=64
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,64)\ \text{または}\ (a,b)=(2,32)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,16)\ \text{または}\ (a,b)=(8,8)\ \text{または}\\
&\hspace{5.7em}(a,b)=(16,4)\ \text{または}\ (a,b)=(32,2)\ \text{または}\\
&\hspace{5.7em}(a,b)=(64,1)
&&\bigl(\because\ 64\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,66)\ \text{または}\ (p,q)=(4,34)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,18)\ \text{または}\ (p,q)=(10,10)\ \text{または}\\
&\hspace{5.7em}(p,q)=(18,6)\ \text{または}\ (p,q)=(34,4)\ \text{または}\\
&\hspace{5.7em}(p,q)=(66,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=65
\quad\Longleftrightarrow\quad
(p,q)=(3,67)\ \text{または}\ (p,q)=(7,15)\ \text{または}\\
\hspace{9.5em}(p,q)=(15,7)\ \text{または}\ (p,q)=(67,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=65
&\Longleftrightarrow ab=65
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,65)\ \text{または}\ (a,b)=(5,13)\ \text{または}\\
&\hspace{5.7em}(a,b)=(13,5)\ \text{または}\ (a,b)=(65,1)
&&\bigl(\because\ 65\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,67)\ \text{または}\ (p,q)=(7,15)\ \text{または}\\
&\hspace{5.7em}(p,q)=(15,7)\ \text{または}\ (p,q)=(67,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=66
\quad\Longleftrightarrow\quad
(p,q)=(3,68)\ \text{または}\ (p,q)=(4,35)\ \text{または}\\
\hspace{4.5em}(p,q)=(5,24)\ \text{または}\ (p,q)=(8,13)\ \text{または}\\
\hspace{4.5em}(p,q)=(13,8)\ \text{または}\ (p,q)=(24,5)\ \text{または}\\
\hspace{4.5em}(p,q)=(35,4)\ \text{または}\ (p,q)=(68,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=66
&\Longleftrightarrow ab=66
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,66)\ \text{または}\ (a,b)=(2,33)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,22)\ \text{または}\ (a,b)=(6,11)\ \text{または}\\
&\hspace{5.7em}(a,b)=(11,6)\ \text{または}\ (a,b)=(22,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(33,2)\ \text{または}\ (a,b)=(66,1)
&&\bigl(\because\ 66\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,68)\ \text{または}\ (p,q)=(4,35)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,24)\ \text{または}\ (p,q)=(8,13)\ \text{または}\\
&\hspace{5.7em}(p,q)=(13,8)\ \text{または}\ (p,q)=(24,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(35,4)\ \text{または}\ (p,q)=(68,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=67
\quad\Longleftrightarrow\quad
(p,q)=(3,69)\ \text{または}\ (p,q)=(69,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十七の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=67
&\Longleftrightarrow ab=67
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,67)\ \text{または}\ (a,b)=(67,1)
&&\bigl(\because\ 67\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,69)\ \text{または}\ (p,q)=(69,3)
      &&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=68
\quad\Longleftrightarrow\quad
(p,q)=(3,70)\ \text{または}\ (p,q)=(4,36)\ \text{または}\\
\hspace{4.5em}(p,q)=(6,19)\ \text{または}\ (p,q)=(19,6)\ \text{または}\\
\hspace{4.5em}(p,q)=(36,4)\ \text{または}\ (p,q)=(70,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=68
&\Longleftrightarrow ab=68
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,68)\ \text{または}\ (a,b)=(2,34)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,17)\ \text{または}\ (a,b)=(17,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(34,2)\ \text{または}\ (a,b)=(68,1)
&&\bigl(\because\ 68\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,70)\ \text{または}\ (p,q)=(4,36)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,19)\ \text{または}\ (p,q)=(19,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(36,4)\ \text{または}\ (p,q)=(70,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_sixty_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差六十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_sixty_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-sixty-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=69
\quad\Longleftrightarrow\quad
(p,q)=(3,71)\ \text{または}\ (p,q)=(5,25)\ \text{または}\\
\hspace{4.5em}(p,q)=(25,5)\ \text{または}\ (p,q)=(71,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、六十九の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=69
&\Longleftrightarrow ab=69
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,69)\ \text{または}\ (a,b)=(3,23)\ \text{または}\\
&\hspace{5.7em}(a,b)=(23,3)\ \text{または}\ (a,b)=(69,1)
&&\bigl(\because\ 69\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,71)\ \text{または}\ (p,q)=(5,25)\ \text{または}\\
&\hspace{5.7em}(p,q)=(25,5)\ \text{または}\ (p,q)=(71,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=70
\quad\Longleftrightarrow\quad
(p,q)=(3,72)\ \text{または}\ (p,q)=(4,37)\ \text{または}\\
\hspace{4.5em}(p,q)=(7,16)\ \text{または}\ (p,q)=(9,12)\ \text{または}\\
\hspace{4.5em}(p,q)=(12,9)\ \text{または}\ (p,q)=(16,7)\ \text{または}\\
\hspace{4.5em}(p,q)=(37,4)\ \text{または}\ (p,q)=(72,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=70
&\Longleftrightarrow ab=70
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,70)\ \text{または}\ (a,b)=(2,35)\ \text{または}\\
&\hspace{5.7em}(a,b)=(5,14)\ \text{または}\ (a,b)=(7,10)\ \text{または}\\
&\hspace{5.7em}(a,b)=(10,7)\ \text{または}\ (a,b)=(14,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(35,2)\ \text{または}\ (a,b)=(70,1)
&&\bigl(\because\ 70\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,72)\ \text{または}\ (p,q)=(4,37)\ \text{または}\\
&\hspace{5.7em}(p,q)=(7,16)\ \text{または}\ (p,q)=(9,12)\ \text{または}\\
&\hspace{5.7em}(p,q)=(12,9)\ \text{または}\ (p,q)=(16,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(37,4)\ \text{または}\ (p,q)=(72,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=71
\quad\Longleftrightarrow\quad
(p,q)=(3,73)\ \text{または}\ (p,q)=(73,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十一の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=71
&\Longleftrightarrow ab=71
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,71)\ \text{または}\ (a,b)=(71,1)
&&\bigl(\because\ 71\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,73)\ \text{または}\ (p,q)=(73,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=72
\quad\Longleftrightarrow\quad
(p,q)=(3,74)\ \text{または}\ (p,q)=(4,38)\ \text{または}\\
\hspace{4.5em}(p,q)=(5,26)\ \text{または}\ (p,q)=(6,20)\ \text{または}\\
\hspace{4.5em}(p,q)=(8,14)\ \text{または}\ (p,q)=(10,11)\ \text{または}\\
\hspace{4.5em}(p,q)=(11,10)\ \text{または}\ (p,q)=(14,8)\ \text{または}\\
\hspace{4.5em}(p,q)=(20,6)\ \text{または}\ (p,q)=(26,5)\ \text{または}\\
\hspace{4.5em}(p,q)=(38,4)\ \text{または}\ (p,q)=(74,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=72
&\Longleftrightarrow ab=72
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,72)\ \text{または}\ (a,b)=(2,36)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,24)\ \text{または}\ (a,b)=(4,18)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,12)\ \text{または}\ (a,b)=(8,9)\ \text{または}\\
&\hspace{5.7em}(a,b)=(9,8)\ \text{または}\ (a,b)=(12,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(18,4)\ \text{または}\ (a,b)=(24,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(36,2)\ \text{または}\ (a,b)=(72,1)
&&\bigl(\because\ 72\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,74)\ \text{または}\ (p,q)=(4,38)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,26)\ \text{または}\ (p,q)=(6,20)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,14)\ \text{または}\ (p,q)=(10,11)\ \text{または}\\
&\hspace{5.7em}(p,q)=(11,10)\ \text{または}\ (p,q)=(14,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(20,6)\ \text{または}\ (p,q)=(26,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(38,4)\ \text{または}\ (p,q)=(74,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=73
\quad\Longleftrightarrow\quad
(p,q)=(3,75)\ \text{または}\ (p,q)=(75,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十三の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=73
&\Longleftrightarrow ab=73
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,73)\ \text{または}\ (a,b)=(73,1)
&&\bigl(\because\ 73\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,75)\ \text{または}\ (p,q)=(75,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=74
\quad\Longleftrightarrow\quad
(p,q)=(3,76)\ \text{または}\ (p,q)=(4,39)\ \text{または}\\
\hspace{4.5em}(p,q)=(39,4)\ \text{または}\ (p,q)=(76,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=74
&\Longleftrightarrow ab=74
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,74)\ \text{または}\ (a,b)=(2,37)\ \text{または}\\
&\hspace{5.7em}(a,b)=(37,2)\ \text{または}\ (a,b)=(74,1)
&&\bigl(\because\ 74\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,76)\ \text{または}\ (p,q)=(4,39)\ \text{または}\\
&\hspace{5.7em}(p,q)=(39,4)\ \text{または}\ (p,q)=(76,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=75
\quad\Longleftrightarrow\quad
(p,q)=(3,77)\ \text{または}\ (p,q)=(5,27)\ \text{または}\\
\hspace{4.5em}(p,q)=(7,17)\ \text{または}\ (p,q)=(17,7)\ \text{または}\\
\hspace{4.5em}(p,q)=(27,5)\ \text{または}\ (p,q)=(77,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=75
&\Longleftrightarrow ab=75
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,75)\ \text{または}\ (a,b)=(3,25)\ \text{または}\\
&\hspace{5.7em}(a,b)=(5,15)\ \text{または}\ (a,b)=(15,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(25,3)\ \text{または}\ (a,b)=(75,1)
&&\bigl(\because\ 75\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,77)\ \text{または}\ (p,q)=(5,27)\ \text{または}\\
&\hspace{5.7em}(p,q)=(7,17)\ \text{または}\ (p,q)=(17,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(27,5)\ \text{または}\ (p,q)=(77,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=76
\quad\Longleftrightarrow\quad
(p,q)=(3,78)\ \text{または}\ (p,q)=(4,40)\ \text{または}\\
\hspace{4.5em}(p,q)=(6,21)\ \text{または}\ (p,q)=(21,6)\ \text{または}\\
\hspace{4.5em}(p,q)=(40,4)\ \text{または}\ (p,q)=(78,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=76
&\Longleftrightarrow ab=76
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,76)\ \text{または}\ (a,b)=(2,38)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,19)\ \text{または}\ (a,b)=(19,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(38,2)\ \text{または}\ (a,b)=(76,1)
&&\bigl(\because\ 76\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,78)\ \text{または}\ (p,q)=(4,40)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,21)\ \text{または}\ (p,q)=(21,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(40,4)\ \text{または}\ (p,q)=(78,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=77
\quad\Longleftrightarrow\quad
(p,q)=(3,79)\ \text{または}\ (p,q)=(9,13)\ \text{または}\\
\hspace{4.5em}(p,q)=(13,9)\ \text{または}\ (p,q)=(79,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=77
&\Longleftrightarrow ab=77
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,77)\ \text{または}\ (a,b)=(7,11)\ \text{または}\\
&\hspace{5.7em}(a,b)=(11,7)\ \text{または}\ (a,b)=(77,1)
&&\bigl(\because\ 77\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,79)\ \text{または}\ (p,q)=(9,13)\ \text{または}\\
&\hspace{5.7em}(p,q)=(13,9)\ \text{または}\ (p,q)=(79,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=78
\quad\Longleftrightarrow\quad
(p,q)=(3,80)\ \text{または}\ (p,q)=(4,41)\ \text{または}\\
\hspace{4.5em}(p,q)=(5,28)\ \text{または}\ (p,q)=(8,15)\ \text{または}\\
\hspace{4.5em}(p,q)=(15,8)\ \text{または}\ (p,q)=(28,5)\ \text{または}\\
\hspace{4.5em}(p,q)=(41,4)\ \text{または}\ (p,q)=(80,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=78
&\Longleftrightarrow ab=78
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,78)\ \text{または}\ (a,b)=(2,39)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,26)\ \text{または}\ (a,b)=(6,13)\ \text{または}\\
&\hspace{5.7em}(a,b)=(13,6)\ \text{または}\ (a,b)=(26,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(39,2)\ \text{または}\ (a,b)=(78,1)
&&\bigl(\because\ 78\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,80)\ \text{または}\ (p,q)=(4,41)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,28)\ \text{または}\ (p,q)=(8,15)\ \text{または}\\
&\hspace{5.7em}(p,q)=(15,8)\ \text{または}\ (p,q)=(28,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(41,4)\ \text{または}\ (p,q)=(80,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_seventy_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差七十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_seventy_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-seventy-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=79
\quad\Longleftrightarrow\quad
(p,q)=(3,81)\ \text{または}\ (p,q)=(81,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、七十九の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=79
&\Longleftrightarrow ab=79
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,79)\ \text{または}\ (a,b)=(79,1)
&&\bigl(\because\ 79\text{ は素数である}\bigr)\\
&\Longleftrightarrow (p,q)=(3,81)\ \text{または}\ (p,q)=(81,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=80
\quad\Longleftrightarrow\quad
(p,q)=(3,82)\ \text{または}\ (p,q)=(4,42)\ \text{または}\\
\hspace{4.5em}(p,q)=(6,22)\ \text{または}\ (p,q)=(7,18)\ \text{または}\\
\hspace{4.5em}(p,q)=(10,12)\ \text{または}\ (p,q)=(12,10)\ \text{または}\\
\hspace{4.5em}(p,q)=(18,7)\ \text{または}\ (p,q)=(22,6)\ \text{または}\\
\hspace{4.5em}(p,q)=(42,4)\ \text{または}\ (p,q)=(82,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=80
&\Longleftrightarrow ab=80
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,80)\ \text{または}\ (a,b)=(2,40)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,20)\ \text{または}\ (a,b)=(5,16)\ \text{または}\\
&\hspace{5.7em}(a,b)=(8,10)\ \text{または}\ (a,b)=(10,8)\ \text{または}\\
&\hspace{5.7em}(a,b)=(16,5)\ \text{または}\ (a,b)=(20,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(40,2)\ \text{または}\ (a,b)=(80,1)
&&\bigl(\because\ 80\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,82)\ \text{または}\ (p,q)=(4,42)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,22)\ \text{または}\ (p,q)=(7,18)\ \text{または}\\
&\hspace{5.7em}(p,q)=(10,12)\ \text{または}\ (p,q)=(12,10)\ \text{または}\\
&\hspace{5.7em}(p,q)=(18,7)\ \text{または}\ (p,q)=(22,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(42,4)\ \text{または}\ (p,q)=(82,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=81
\quad\Longleftrightarrow\quad
(p,q)=(3,83)\ \text{または}\ (p,q)=(5,29)\ \text{または}\\
\hspace{4.5em}(p,q)=(11,11)\ \text{または}\ (p,q)=(29,5)\ \text{または}\\
\hspace{4.5em}(p,q)=(83,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=81
&\Longleftrightarrow ab=81
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,81)\ \text{または}\ (a,b)=(3,27)\ \text{または}\\
&\hspace{5.7em}(a,b)=(9,9)\ \text{または}\ (a,b)=(27,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(81,1)
&&\bigl(\because\ 81\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,83)\ \text{または}\ (p,q)=(5,29)\ \text{または}\\
&\hspace{5.7em}(p,q)=(11,11)\ \text{または}\ (p,q)=(29,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(83,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=82
\quad\Longleftrightarrow\quad
(p,q)=(3,84)\ \text{または}\ (p,q)=(4,43)\ \text{または}\\
\hspace{4.5em}(p,q)=(43,4)\ \text{または}\ (p,q)=(84,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=82
&\Longleftrightarrow ab=82
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,82)\ \text{または}\ (a,b)=(2,41)\ \text{または}\\
&\hspace{5.7em}(a,b)=(41,2)\ \text{または}\ (a,b)=(82,1)
&&\bigl(\because\ 82\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,84)\ \text{または}\ (p,q)=(4,43)\ \text{または}\\
&\hspace{5.7em}(p,q)=(43,4)\ \text{または}\ (p,q)=(84,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=83
\quad\Longleftrightarrow\quad
(p,q)=(3,85)\ \text{または}\ (p,q)=(85,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十三の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=83
&\Longleftrightarrow ab=83
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,83)\ \text{または}\ (a,b)=(83,1)
&&\bigl(\because\ 83\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,85)\ \text{または}\ (p,q)=(85,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=84
\quad\Longleftrightarrow\quad
&(p,q)=(3,86)\ \text{または}\ (p,q)=(4,44)\ \text{または}\\
&(p,q)=(5,30)\ \text{または}\ (p,q)=(6,23)\ \text{または}\\
&(p,q)=(8,16)\ \text{または}\ (p,q)=(9,14)\ \text{または}\\
&(p,q)=(14,9)\ \text{または}\ (p,q)=(16,8)\ \text{または}\\
&(p,q)=(23,6)\ \text{または}\ (p,q)=(30,5)\ \text{または}\\
&(p,q)=(44,4)\ \text{または}\ (p,q)=(86,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=84
&\Longleftrightarrow ab=84
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,84)\ \text{または}\ (a,b)=(2,42)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,28)\ \text{または}\ (a,b)=(4,21)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,14)\ \text{または}\ (a,b)=(7,12)\ \text{または}\\
&\hspace{5.7em}(a,b)=(12,7)\ \text{または}\ (a,b)=(14,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(21,4)\ \text{または}\ (a,b)=(28,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(42,2)\ \text{または}\ (a,b)=(84,1)
&&\bigl(\because\ 84\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,86)\ \text{または}\ (p,q)=(4,44)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,30)\ \text{または}\ (p,q)=(6,23)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,16)\ \text{または}\ (p,q)=(9,14)\ \text{または}\\
&\hspace{5.7em}(p,q)=(14,9)\ \text{または}\ (p,q)=(16,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(23,6)\ \text{または}\ (p,q)=(30,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(44,4)\ \text{または}\ (p,q)=(86,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=85
\quad\Longleftrightarrow\quad
&(p,q)=(3,87)\ \text{または}\ (p,q)=(7,19)\ \text{または}\\
&(p,q)=(19,7)\ \text{または}\ (p,q)=(87,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=85
&\Longleftrightarrow ab=85
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,85)\ \text{または}\ (a,b)=(5,17)\ \text{または}\\
&\hspace{5.7em}(a,b)=(17,5)\ \text{または}\ (a,b)=(85,1)
&&\bigl(\because\ 85\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,87)\ \text{または}\ (p,q)=(7,19)\ \text{または}\\
&\hspace{5.7em}(p,q)=(19,7)\ \text{または}\ (p,q)=(87,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=86
\quad\Longleftrightarrow\quad
&(p,q)=(3,88)\ \text{または}\ (p,q)=(4,45)\ \text{または}\\
&(p,q)=(45,4)\ \text{または}\ (p,q)=(88,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=86
&\Longleftrightarrow ab=86
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,86)\ \text{または}\ (a,b)=(2,43)\ \text{または}\\
&\hspace{5.7em}(a,b)=(43,2)\ \text{または}\ (a,b)=(86,1)
&&\bigl(\because\ 86\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,88)\ \text{または}\ (p,q)=(4,45)\ \text{または}\\
&\hspace{5.7em}(p,q)=(45,4)\ \text{または}\ (p,q)=(88,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=87
\quad\Longleftrightarrow\quad
&(p,q)=(3,89)\ \text{または}\ (p,q)=(5,31)\ \text{または}\\
&(p,q)=(31,5)\ \text{または}\ (p,q)=(89,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=87
&\Longleftrightarrow ab=87
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,87)\ \text{または}\ (a,b)=(3,29)\ \text{または}\\
&\hspace{5.7em}(a,b)=(29,3)\ \text{または}\ (a,b)=(87,1)
&&\bigl(\because\ 87\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,89)\ \text{または}\ (p,q)=(5,31)\ \text{または}\\
&\hspace{5.7em}(p,q)=(31,5)\ \text{または}\ (p,q)=(89,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=88
\quad\Longleftrightarrow\quad
&(p,q)=(3,90)\ \text{または}\ (p,q)=(4,46)\ \text{または}\\
&(p,q)=(6,24)\ \text{または}\ (p,q)=(10,13)\ \text{または}\\
&(p,q)=(13,10)\ \text{または}\ (p,q)=(24,6)\ \text{または}\\
&(p,q)=(46,4)\ \text{または}\ (p,q)=(90,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=88
&\Longleftrightarrow ab=88
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,88)\ \text{または}\ (a,b)=(2,44)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,22)\ \text{または}\ (a,b)=(8,11)\ \text{または}\\
&\hspace{5.7em}(a,b)=(11,8)\ \text{または}\ (a,b)=(22,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(44,2)\ \text{または}\ (a,b)=(88,1)
&&\bigl(\because\ 88\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,90)\ \text{または}\ (p,q)=(4,46)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,24)\ \text{または}\ (p,q)=(10,13)\ \text{または}\\
&\hspace{5.7em}(p,q)=(13,10)\ \text{または}\ (p,q)=(24,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(46,4)\ \text{または}\ (p,q)=(90,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_eighty_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差八十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_eighty_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-eighty-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=89
\quad\Longleftrightarrow\quad
(p,q)=(3,91)\ \text{または}\ (p,q)=(91,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、八十九の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=89
&\Longleftrightarrow ab=89
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,89)\ \text{または}\ (a,b)=(89,1)
&&\bigl(\because\ 89\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow (p,q)=(3,91)\ \text{または}\ (p,q)=(91,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=90
\quad\Longleftrightarrow\quad
&(p,q)=(3,92)\ \text{または}\ (p,q)=(4,47)\ \text{または}\\
&(p,q)=(5,32)\ \text{または}\ (p,q)=(7,20)\ \text{または}\\
&(p,q)=(8,17)\ \text{または}\ (p,q)=(11,12)\ \text{または}\\
&(p,q)=(12,11)\ \text{または}\ (p,q)=(17,8)\ \text{または}\\
&(p,q)=(20,7)\ \text{または}\ (p,q)=(32,5)\ \text{または}\\
&(p,q)=(47,4)\ \text{または}\ (p,q)=(92,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=90
&\Longleftrightarrow ab=90
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,90)\ \text{または}\ (a,b)=(2,45)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,30)\ \text{または}\ (a,b)=(5,18)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,15)\ \text{または}\ (a,b)=(9,10)\ \text{または}\\
&\hspace{5.7em}(a,b)=(10,9)\ \text{または}\ (a,b)=(15,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(18,5)\ \text{または}\ (a,b)=(30,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(45,2)\ \text{または}\ (a,b)=(90,1)
&&\bigl(\because\ 90\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,92)\ \text{または}\ (p,q)=(4,47)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,32)\ \text{または}\ (p,q)=(7,20)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,17)\ \text{または}\ (p,q)=(11,12)\ \text{または}\\
&\hspace{5.7em}(p,q)=(12,11)\ \text{または}\ (p,q)=(17,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(20,7)\ \text{または}\ (p,q)=(32,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(47,4)\ \text{または}\ (p,q)=(92,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=91
\quad\Longleftrightarrow\quad
&(p,q)=(3,93)\ \text{または}\ (p,q)=(9,15)\ \text{または}\\
&(p,q)=(15,9)\ \text{または}\ (p,q)=(93,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=91
&\Longleftrightarrow ab=91
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,91)\ \text{または}\ (a,b)=(7,13)\ \text{または}\\
&\hspace{5.7em}(a,b)=(13,7)\ \text{または}\ (a,b)=(91,1)
&&\bigl(\because\ 91\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,93)\ \text{または}\ (p,q)=(9,15)\ \text{または}\\
&\hspace{5.7em}(p,q)=(15,9)\ \text{または}\ (p,q)=(93,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=92
\quad\Longleftrightarrow\quad
&(p,q)=(3,94)\ \text{または}\ (p,q)=(4,48)\ \text{または}\\
&(p,q)=(6,25)\ \text{または}\ (p,q)=(25,6)\ \text{または}\\
&(p,q)=(48,4)\ \text{または}\ (p,q)=(94,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=92
&\Longleftrightarrow ab=92
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,92)\ \text{または}\ (a,b)=(2,46)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,23)\ \text{または}\ (a,b)=(23,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(46,2)\ \text{または}\ (a,b)=(92,1)
&&\bigl(\because\ 92\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,94)\ \text{または}\ (p,q)=(4,48)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,25)\ \text{または}\ (p,q)=(25,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(48,4)\ \text{または}\ (p,q)=(94,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=93
\quad\Longleftrightarrow\quad
&(p,q)=(3,95)\ \text{または}\ (p,q)=(5,33)\ \text{または}\\
&(p,q)=(33,5)\ \text{または}\ (p,q)=(95,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十三の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=93
&\Longleftrightarrow ab=93
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,93)\ \text{または}\ (a,b)=(3,31)\ \text{または}\\
&\hspace{5.7em}(a,b)=(31,3)\ \text{または}\ (a,b)=(93,1)
&&\bigl(\because\ 93\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,95)\ \text{または}\ (p,q)=(5,33)\ \text{または}\\
&\hspace{5.7em}(p,q)=(33,5)\ \text{または}\ (p,q)=(95,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=94
\quad\Longleftrightarrow\quad
&(p,q)=(3,96)\ \text{または}\ (p,q)=(4,49)\ \text{または}\\
&(p,q)=(49,4)\ \text{または}\ (p,q)=(96,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=94
&\Longleftrightarrow ab=94
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,94)\ \text{または}\ (a,b)=(2,47)\ \text{または}\\
&\hspace{5.7em}(a,b)=(47,2)\ \text{または}\ (a,b)=(94,1)
&&\bigl(\because\ 94\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,96)\ \text{または}\ (p,q)=(4,49)\ \text{または}\\
&\hspace{5.7em}(p,q)=(49,4)\ \text{または}\ (p,q)=(96,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=95
\quad\Longleftrightarrow\quad
&(p,q)=(3,97)\ \text{または}\ (p,q)=(7,21)\ \text{または}\\
&(p,q)=(21,7)\ \text{または}\ (p,q)=(97,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=95
&\Longleftrightarrow ab=95
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,95)\ \text{または}\ (a,b)=(5,19)\ \text{または}\\
&\hspace{5.7em}(a,b)=(19,5)\ \text{または}\ (a,b)=(95,1)
&&\bigl(\because\ 95\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,97)\ \text{または}\ (p,q)=(7,21)\ \text{または}\\
&\hspace{5.7em}(p,q)=(21,7)\ \text{または}\ (p,q)=(97,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=96
\quad\Longleftrightarrow\quad
&(p,q)=(3,98)\ \text{または}\ (p,q)=(4,50)\ \text{または}\\
&(p,q)=(5,34)\ \text{または}\ (p,q)=(6,26)\ \text{または}\\
&(p,q)=(8,18)\ \text{または}\ (p,q)=(10,14)\ \text{または}\\
&(p,q)=(14,10)\ \text{または}\ (p,q)=(18,8)\ \text{または}\\
&(p,q)=(26,6)\ \text{または}\ (p,q)=(34,5)\ \text{または}\\
&(p,q)=(50,4)\ \text{または}\ (p,q)=(98,3).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=96
&\Longleftrightarrow ab=96
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,96)\ \text{または}\ (a,b)=(2,48)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,32)\ \text{または}\ (a,b)=(4,24)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,16)\ \text{または}\ (a,b)=(8,12)\ \text{または}\\
&\hspace{5.7em}(a,b)=(12,8)\ \text{または}\ (a,b)=(16,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(24,4)\ \text{または}\ (a,b)=(32,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(48,2)\ \text{または}\ (a,b)=(96,1)
&&\bigl(\because\ 96\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,98)\ \text{または}\ (p,q)=(4,50)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,34)\ \text{または}\ (p,q)=(6,26)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,18)\ \text{または}\ (p,q)=(10,14)\ \text{または}\\
&\hspace{5.7em}(p,q)=(14,10)\ \text{または}\ (p,q)=(18,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(26,6)\ \text{または}\ (p,q)=(34,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(50,4)\ \text{または}\ (p,q)=(98,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=97
\quad\Longleftrightarrow\quad
(p,q)=(3,99)\ \text{または}\ (p,q)=(99,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十七の素数性、九十七の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=97
&\Longleftrightarrow ab=97
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,97)\ \text{または}\ (a,b)=(97,1)
&&\bigl(\because\ 97\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,99)\ \text{または}\ (p,q)=(99,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=98
\quad\Longleftrightarrow\quad
\begin{aligned}
(p,q)={}&(3,100)\ \text{または}\ (4,51)\ \text{または}\ (9,16)\ \text{または}\\
        &(16,9)\ \text{または}\ (51,4)\ \text{または}\ (100,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=98
&\Longleftrightarrow ab=98
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,98)\ \text{または}\ (a,b)=(2,49)\ \text{または}\\
&\hspace{5.7em}(a,b)=(7,14)\ \text{または}\ (a,b)=(14,7)\ \text{または}\\
&\hspace{5.7em}(a,b)=(49,2)\ \text{または}\ (a,b)=(98,1)
&&\bigl(\because\ 98\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,100)\ \text{または}\ (p,q)=(4,51)\ \text{または}\\
&\hspace{5.7em}(p,q)=(9,16)\ \text{または}\ (p,q)=(16,9)\ \text{または}\\
&\hspace{5.7em}(p,q)=(51,4)\ \text{または}\ (p,q)=(100,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_ninety_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差九十九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_ninety_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-ninety-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=99
\quad\Longleftrightarrow\quad
\begin{aligned}
(p,q)={}&(3,101)\ \text{または}\ (5,35)\ \text{または}\ (11,13)\ \text{または}\\
        &(13,11)\ \text{または}\ (35,5)\ \text{または}\ (101,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、九十九の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=99
&\Longleftrightarrow ab=99
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,99)\ \text{または}\ (a,b)=(3,33)\ \text{または}\\
&\hspace{5.7em}(a,b)=(9,11)\ \text{または}\ (a,b)=(11,9)\ \text{または}\\
&\hspace{5.7em}(a,b)=(33,3)\ \text{または}\ (a,b)=(99,1)
&&\bigl(\because\ 99\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,101)\ \text{または}\ (p,q)=(5,35)\ \text{または}\\
&\hspace{5.7em}(p,q)=(11,13)\ \text{または}\ (p,q)=(13,11)\ \text{または}\\
&\hspace{5.7em}(p,q)=(35,5)\ \text{または}\ (p,q)=(101,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=100
\quad\Longleftrightarrow\quad
\begin{aligned}
(p,q)={}&(3,102)\ \text{または}\ (4,52)\ \text{または}\ (6,27)\ \text{または}\\
        &(7,22)\ \text{または}\ (12,12)\ \text{または}\ (22,7)\ \text{または}\\
        &(27,6)\ \text{または}\ (52,4)\ \text{または}\ (102,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=100
&\Longleftrightarrow ab=100
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,100)\ \text{または}\ (a,b)=(2,50)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,25)\ \text{または}\ (a,b)=(5,20)\ \text{または}\\
&\hspace{5.7em}(a,b)=(10,10)\ \text{または}\ (a,b)=(20,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(25,4)\ \text{または}\ (a,b)=(50,2)\ \text{または}\\
&\hspace{5.7em}(a,b)=(100,1)
&&\bigl(\because\ 100\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,102)\ \text{または}\ (p,q)=(4,52)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,27)\ \text{または}\ (p,q)=(7,22)\ \text{または}\\
&\hspace{5.7em}(p,q)=(12,12)\ \text{または}\ (p,q)=(22,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(27,6)\ \text{または}\ (p,q)=(52,4)\ \text{または}\\
&\hspace{5.7em}(p,q)=(102,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_one_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_one_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-one-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=101
\quad\Longleftrightarrow\quad
(p,q)=(3,103)\ \text{または}\ (p,q)=(103,3).`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百一の素数性、百一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=101
&\Longleftrightarrow ab=101
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,101)\ \text{または}\ (a,b)=(101,1)
&&\bigl(\because\ 101\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,103)\ \text{または}\ (p,q)=(103,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_two_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_two_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-two-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=102
\quad\Longleftrightarrow\quad
\begin{aligned}
(p,q)={}&(3,104)\ \text{または}\ (4,53)\ \text{または}\ (5,36)\ \text{または}\\
        &(8,19)\ \text{または}\ (19,8)\ \text{または}\ (36,5)\ \text{または}\\
        &(53,4)\ \text{または}\ (104,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=102
&\Longleftrightarrow ab=102
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,102)\ \text{または}\ (a,b)=(2,51)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,34)\ \text{または}\ (a,b)=(6,17)\ \text{または}\\
&\hspace{5.7em}(a,b)=(17,6)\ \text{または}\ (a,b)=(34,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(51,2)\ \text{または}\ (a,b)=(102,1)
&&\bigl(\because\ 102\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,104)\ \text{または}\ (p,q)=(4,53)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,36)\ \text{または}\ (p,q)=(8,19)\ \text{または}\\
&\hspace{5.7em}(p,q)=(19,8)\ \text{または}\ (p,q)=(36,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(53,4)\ \text{または}\ (p,q)=(104,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_three_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百三をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_three_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-three-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=103
\quad\Longleftrightarrow\quad
(p,q)=(3,105)\ \text{または}\ (p,q)=(105,3)`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百三の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=103
&\Longleftrightarrow ab=103
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,103)\ \text{または}\ (a,b)=(103,1)
&&\bigl(\because\ 103\text{ は素数であり、これらが正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,105)\ \text{または}\ (p,q)=(105,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_four_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百四をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_four_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-four-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=104
\quad\Longleftrightarrow\quad
\begin{aligned}
(p,q)={}&(3,106)\ \text{または}\ (4,54)\ \text{または}\ (6,28)\ \text{または}\\
        &(10,15)\ \text{または}\ (15,10)\ \text{または}\ (28,6)\ \text{または}\\
        &(54,4)\ \text{または}\ (106,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百四の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=104
&\Longleftrightarrow ab=104
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,104)\ \text{または}\ (a,b)=(2,52)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,26)\ \text{または}\ (a,b)=(8,13)\ \text{または}\\
&\hspace{5.7em}(a,b)=(13,8)\ \text{または}\ (a,b)=(26,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(52,2)\ \text{または}\ (a,b)=(104,1)
&&\bigl(\because\ 104\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,106)\ \text{または}\ (p,q)=(4,54)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,28)\ \text{または}\ (p,q)=(10,15)\ \text{または}\\
&\hspace{5.7em}(p,q)=(15,10)\ \text{または}\ (p,q)=(28,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(54,4)\ \text{または}\ (p,q)=(106,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_five_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百五をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_five_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-five-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=105
\quad\Longleftrightarrow\quad
\begin{aligned}
(p,q)={}&(3,107)\ \text{または}\ (5,37)\ \text{または}\ (7,23)\ \text{または}\\
        &(9,17)\ \text{または}\ (17,9)\ \text{または}\ (23,7)\ \text{または}\\
        &(37,5)\ \text{または}\ (107,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百五の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=105
&\Longleftrightarrow ab=105
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,105)\ \text{または}\ (a,b)=(3,35)\ \text{または}\\
&\hspace{5.7em}(a,b)=(5,21)\ \text{または}\ (a,b)=(7,15)\ \text{または}\\
&\hspace{5.7em}(a,b)=(15,7)\ \text{または}\ (a,b)=(21,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(35,3)\ \text{または}\ (a,b)=(105,1)
&&\bigl(\because\ 105\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,107)\ \text{または}\ (p,q)=(5,37)\ \text{または}\\
&\hspace{5.7em}(p,q)=(7,23)\ \text{または}\ (p,q)=(9,17)\ \text{または}\\
&\hspace{5.7em}(p,q)=(17,9)\ \text{または}\ (p,q)=(23,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(37,5)\ \text{または}\ (p,q)=(107,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_six_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百六をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_six_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-six-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=106
\quad\Longleftrightarrow\quad
\begin{aligned}
(p,q)={}&(3,108)\ \text{または}\ (4,55)\ \text{または}\\
        &(55,4)\ \text{または}\ (108,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百六の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=106
&\Longleftrightarrow ab=106
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,106)\ \text{または}\ (a,b)=(2,53)\ \text{または}\\
&\hspace{5.7em}(a,b)=(53,2)\ \text{または}\ (a,b)=(106,1)
&&\bigl(\because\ 106\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,108)\ \text{または}\ (p,q)=(4,55)\ \text{または}\\
&\hspace{5.7em}(p,q)=(55,4)\ \text{または}\ (p,q)=(108,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_seven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百七をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_seven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-seven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=107
\quad\Longleftrightarrow\quad
(p,q)=(3,109)\ \text{または}\ (p,q)=(109,3)`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百七の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=107
&\Longleftrightarrow ab=107
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,107)\ \text{または}\ (a,b)=(107,1)
&&\bigl(\because\ 107\text{ は素数である}\bigr)\\
&\Longleftrightarrow (p,q)=(3,109)\ \text{または}\ (p,q)=(109,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_eight_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百八をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_eight_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-eight-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=108
\quad\Longleftrightarrow\quad
(p,q)={}&(3,110)\ \text{または}\ (4,56)\ \text{または}\ (5,38)\ \text{または}\\
&(6,29)\ \text{または}\ (8,20)\ \text{または}\ (11,14)\ \text{または}\\
&(14,11)\ \text{または}\ (20,8)\ \text{または}\ (29,6)\ \text{または}\\
&(38,5)\ \text{または}\ (56,4)\ \text{または}\ (110,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百八の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=108
&\Longleftrightarrow ab=108
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,108)\ \text{または}\ (a,b)=(2,54)\ \text{または}\\
&\hspace{5.7em}(a,b)=(3,36)\ \text{または}\ (a,b)=(4,27)\ \text{または}\\
&\hspace{5.7em}(a,b)=(6,18)\ \text{または}\ (a,b)=(9,12)\ \text{または}\\
&\hspace{5.7em}(a,b)=(12,9)\ \text{または}\ (a,b)=(18,6)\ \text{または}\\
&\hspace{5.7em}(a,b)=(27,4)\ \text{または}\ (a,b)=(36,3)\ \text{または}\\
&\hspace{5.7em}(a,b)=(54,2)\ \text{または}\ (a,b)=(108,1)
&&\bigl(\because\ 108\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,110)\ \text{または}\ (p,q)=(4,56)\ \text{または}\\
&\hspace{5.7em}(p,q)=(5,38)\ \text{または}\ (p,q)=(6,29)\ \text{または}\\
&\hspace{5.7em}(p,q)=(8,20)\ \text{または}\ (p,q)=(11,14)\ \text{または}\\
&\hspace{5.7em}(p,q)=(14,11)\ \text{または}\ (p,q)=(20,8)\ \text{または}\\
&\hspace{5.7em}(p,q)=(29,6)\ \text{または}\ (p,q)=(38,5)\ \text{または}\\
&\hspace{5.7em}(p,q)=(56,4)\ \text{または}\ (p,q)=(110,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_nine_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百九をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_nine_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-nine-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\left(\bar p-2\right)\left(\bar q-2\right)=109
\quad\Longleftrightarrow\quad
(p,q)=(3,111)\ \text{または}\ (p,q)=(111,3)`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百九の素数性と正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=109
&\Longleftrightarrow ab=109
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow (a,b)=(1,109)\ \text{または}\ (a,b)=(109,1)
&&\bigl(\because\ 109\text{ は素数である}\bigr)\\
&\Longleftrightarrow (p,q)=(3,111)\ \text{または}\ (p,q)=(111,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_ten_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百十をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_ten_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-ten-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=110
\quad\Longleftrightarrow\quad
(p,q)={}&(3,112)\ \text{または}\ (4,57)\ \text{または}\ (7,24)\ \text{または}\ (12,13)\ \text{または}\\
&(13,12)\ \text{または}\ (24,7)\ \text{または}\ (57,4)\ \text{または}\ (112,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百十の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=110
&\Longleftrightarrow ab=110
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,110)\ \text{または}\ (a,b)=(2,55)\ \text{または}\\
&\hspace{5.7em}(a,b)=(5,22)\ \text{または}\ (a,b)=(10,11)\ \text{または}\\
&\hspace{5.7em}(a,b)=(11,10)\ \text{または}\ (a,b)=(22,5)\ \text{または}\\
&\hspace{5.7em}(a,b)=(55,2)\ \text{または}\ (a,b)=(110,1)
&&\bigl(\because\ 110\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,112)\ \text{または}\ (p,q)=(4,57)\ \text{または}\\
&\hspace{5.7em}(p,q)=(7,24)\ \text{または}\ (p,q)=(12,13)\ \text{または}\\
&\hspace{5.7em}(p,q)=(13,12)\ \text{または}\ (p,q)=(24,7)\ \text{または}\\
&\hspace{5.7em}(p,q)=(57,4)\ \text{または}\ (p,q)=(112,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_eleven_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百十一をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_eleven_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-eleven-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=111
\quad\Longleftrightarrow\quad
(p,q)={}&(3,113)\ \text{または}\ (5,39)\ \text{または}\\
&(39,5)\ \text{または}\ (113,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百十一の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=111
&\Longleftrightarrow ab=111
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,111)\ \text{または}\ (a,b)=(3,37)\ \text{または}\\
&\hspace{5.7em}(a,b)=(37,3)\ \text{または}\ (a,b)=(111,1)
&&\bigl(\because\ 111\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,113)\ \text{または}\ (p,q)=(5,39)\ \text{または}\\
&\hspace{5.7em}(p,q)=(39,5)\ \text{または}\ (p,q)=(113,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
  {
    id: "finite_cellulation_theorem_product_difference_one_hundred_twelve_hyperbolic_types",
    kind: "theorem",
    title: { text: "積差百十二をもつ双曲正則型の分類" },
    labels: ["theorem_product_difference_one_hundred_twelve_hyperbolic_types"],
    habitat: "Z",
    verification: ["sagemath/check/product-difference-one-hundred-twelve-hyperbolic-types"],
    statement: [
      paragraph([
        ref("def_finite_cellulation_hyperbolic_regular_type_set"),
        " の有限セル分割データ ",
        math(String.raw`\mathcal X`),
        " と双曲正則型 ",
        math(String.raw`(p,q)\in\operatorname{HyperbolicRegularTypes}(\mathcal X)`),
        " に対し、自然数から整数への標準単射を ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\to\mathbb Z`),
        " とし、",
      ]),
      displayMath(String.raw`\bar p:=\iota_{\mathbb N,\mathbb Z}(p),\qquad
\bar q:=\iota_{\mathbb N,\mathbb Z}(q)`),
      paragraph(["と書けば、"]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=112
\quad\Longleftrightarrow\quad
(p,q)={}&(3,114)\ \text{または}\ (4,58)\ \text{または}\ (6,30)\ \text{または}\ (9,18)\ \text{または}\ (10,16)\ \text{または}\\
&(16,10)\ \text{または}\ (18,9)\ \text{または}\ (30,6)\ \text{または}\ (58,4)\ \text{または}\ (114,3)
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in\mathbb N_{>0}`),
        "、",
        math(String.raw`\bar p,\bar q\in\mathbb Z`),
        " である。この分類は自然数の加法、百十二の正の因子対、および標準単射だけから得られ、除算、実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_hyperbolic_regular_type_degree_lower_bounds"), " より"]),
      displayMath(String.raw`3\le p\qquad\text{かつ}\qquad3\le q.`),
      paragraph([
        "したがって、一意な ",
        math(String.raw`a,b\in\mathbb N_{>0}`),
        " が存在して ",
        math(String.raw`p=a+2`),
        " および ",
        math(String.raw`q=b+2`),
        " を満たす。この ",
        math(String.raw`a,b`),
        " に対し、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\bar p-2\right)\left(\bar q-2\right)=112
&\Longleftrightarrow ab=112
&&\bigl(\because\ \text{標準単射は加法・乗法・等号を保存し反映する}\bigr)\\
&\Longleftrightarrow
(a,b)=(1,112)\ \text{または}\ (a,b)=(2,56)\ \text{または}\\
&\hspace{5.7em}(a,b)=(4,28)\ \text{または}\ (a,b)=(7,16)\ \text{または}\\
&\hspace{5.7em}(a,b)=(8,14)\ \text{または}\ (a,b)=(14,8)\ \text{または}\\
&\hspace{5.7em}(a,b)=(16,7)\ \text{または}\ (a,b)=(28,4)\ \text{または}\\
&\hspace{5.7em}(a,b)=(56,2)\ \text{または}\ (a,b)=(112,1)
&&\bigl(\because\ 112\text{ の正の因子対の全体}\bigr)\\
&\Longleftrightarrow
(p,q)=(3,114)\ \text{または}\ (p,q)=(4,58)\ \text{または}\\
&\hspace{5.7em}(p,q)=(6,30)\ \text{または}\ (p,q)=(9,18)\ \text{または}\\
&\hspace{5.7em}(p,q)=(10,16)\ \text{または}\ (p,q)=(16,10)\ \text{または}\\
&\hspace{5.7em}(p,q)=(18,9)\ \text{または}\ (p,q)=(30,6)\ \text{または}\\
&\hspace{5.7em}(p,q)=(58,4)\ \text{または}\ (p,q)=(114,3)
&&\bigl(\because\ p=a+2\text{ および }q=b+2\bigr).
\end{aligned}`),
    ],
  },
]);
