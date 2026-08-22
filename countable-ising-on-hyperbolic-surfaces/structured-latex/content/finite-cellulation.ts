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
]);
