import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_quotient_lattice_heading_input",
    kind: "heading",
    level: 1,
    title: { text: "有限群・剰余類からの格子生成" },
    labels: [],
  },
  {
    id: "finite_quotient_lattice_definition_hyperbolic_triangle_permutation_quotient_input",
    kind: "definition",
    title: { text: "双曲三角群の有限置換商入力" },
    labels: ["def_hyperbolic_triangle_permutation_quotient_input"],
    habitat: "Q",
    verification: ["sagemath/check/hyperbolic-triangle-permutation-quotient-input"],
    statement: [
      paragraph([
        "正整数 ",
        math(String.raw`p,q\in\mathbb N_{>0}`),
        " と空でない有限集合 ",
        math(String.raw`\Omega`),
        " に対し、",
        math(String.raw`\operatorname{Sym}(\Omega)`),
        " を ",
        math(String.raw`\Omega`),
        " からそれ自身への全単射全体が写像の合成でなす有限群とする。双曲三角群の有限置換商入力を、順序付き組",
      ]),
      displayMath(String.raw`\mathcal Q_{p,q}:=
\left(
  \Omega,
  Q,
  r_F,
  r_V,
  r_E
\right)`),
      paragraph([
        "であって、",
        math(String.raw`Q\leq\operatorname{Sym}(\Omega)`),
        " は有限部分群、",
        math(String.raw`r_F,r_V,r_E\in Q`),
        " は指定された三つの置換であり、次の有限条件を全て満たすものと定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q
&=
\langle r_F,r_V,r_E\rangle,\\
r_F^p
&=\operatorname{id}_{\Omega},
&
r_F^k
&\ne\operatorname{id}_{\Omega}
&&\left(k\in\mathbb N_{>0},\ k<p\right),\\
r_V^q
&=\operatorname{id}_{\Omega},
&
r_V^k
&\ne\operatorname{id}_{\Omega}
&&\left(k\in\mathbb N_{>0},\ k<q\right),\\
r_E^2
&=\operatorname{id}_{\Omega},
&
r_E
&\ne\operatorname{id}_{\Omega},\\
r_F\circ r_V\circ r_E
&=\operatorname{id}_{\Omega},\\
\forall\alpha,\beta\in\Omega\quad
\exists g\in Q\quad
g(\alpha)
&=\beta,\\
\frac{1}{\iota_{\mathbb N,\mathbb Q}(p)}
+
\frac{1}{\iota_{\mathbb N,\mathbb Q}(q)}
&<\frac12.
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`\operatorname{id}_{\Omega}`),
        " は有限集合 ",
        math(String.raw`\Omega`),
        " の恒等置換、置換積は右側の写像から順に作用する合成、",
        math(String.raw`\langle r_F,r_V,r_E\rangle`),
        " は三置換を含む最小の部分群である。",
        math(String.raw`\iota_{\mathbb N,\mathbb Q}:\mathbb N\to\mathbb Q`),
        " は ",
        math(String.raw`n\mapsto n/1`),
        " で与えられる標準単射である。最初の六条件は有限置換の合成と等号、推移性の有限探索で判定でき、最後の条件は有理数の厳密比較で判定できる。",
      ]),
      paragraph([
        math(String.raw`r_F,r_V,r_E`),
        " の添字は、後に面、頂点、辺の安定化部分群を作るための役割名である。この定義だけから剰余類をセルと同一視せず、生成されるセルデータの閉曲面性、正則性、向き付けも結論しない。それらは始域と終域を明示した剰余類写像を定義した後、既存の有限セル分割述語で別に検査する。全ての群と集合は有限であり、双曲平面の座標、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_quotient_lattice_definition_role_stabilizers_and_coset_cell_sets",
    kind: "definition",
    title: { text: "役割安定化部分群と剰余類セル集合" },
    labels: ["def_finite_quotient_role_stabilizers_and_coset_cell_sets"],
    habitat: "finite",
    verification: ["sagemath/check/finite-quotient-coset-cell-sets"],
    statement: [
      paragraph([
        ref("def_hyperbolic_triangle_permutation_quotient_input"),
        " の双曲三角群の有限置換商入力 ",
        math(String.raw`\mathcal Q_{p,q}=(\Omega,Q,r_F,r_V,r_E)`),
        " に対し、面、頂点、辺の役割安定化部分群をそれぞれ",
      ]),
      displayMath(String.raw`\begin{aligned}
H_F
&:=
\langle r_F\rangle
\leq Q,\\
H_V
&:=
\langle r_V\rangle
\leq Q,\\
H_E
&:=
\langle r_E\rangle
\leq Q
\end{aligned}`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`\langle r_R\rangle`),
        " は ",
        math(String.raw`r_R`),
        " を含む最小の部分群であり、",
        math(String.raw`R\in\{F,V,E\}`),
        " は三つの役割を表す形式的ラベルである。各部分群に対する左剰余類集合を",
      ]),
      displayMath(String.raw`\begin{aligned}
Q/H_F
&:=
\left\{
  gH_F
  \middle|
  g\in Q
\right\},\\
Q/H_V
&:=
\left\{
  gH_V
  \middle|
  g\in Q
\right\},\\
Q/H_E
&:=
\left\{
  gH_E
  \middle|
  g\in Q
\right\}
\end{aligned}`),
      paragraph([
        "と定める。さらに、互いに異なる形式的ラベル ",
        math(String.raw`\mathtt{face},\mathtt{vertex},\mathtt{edge}`),
        " を用いて、面、頂点、辺のセルラベル集合をそれぞれ",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathcal F_Q
&:=
\{\mathtt{face}\}\times(Q/H_F),\\
\mathcal V_Q
&:=
\{\mathtt{vertex}\}\times(Q/H_V),\\
\mathcal E_Q
&:=
\{\mathtt{edge}\}\times(Q/H_E)
\end{aligned}`),
      paragraph([
        "と定める。各セルラベルの第二成分は剰余類そのものであり、代表元 ",
        math(String.raw`g\in Q`),
        " ではない。第一成分の形式的ラベルにより、三つのセルラベル集合を互いに同一視しない。また、置換台 ",
        math(String.raw`\Omega`),
        "、有限群 ",
        math(String.raw`Q`),
        "、剰余類セル集合も互いに同一視しない。この定義はセルラベルだけを与え、端点写像、面境界語、閉曲面性、正則性、向き付けを結論しない。全ての対象は有限集合であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_quotient_lattice_definition_coset_cell_incidence_relation",
    kind: "definition",
    title: { text: "剰余類セル間の incidence 関係" },
    labels: ["def_finite_quotient_coset_cell_incidence_relation"],
    habitat: "finite",
    verification: ["sagemath/check/finite-quotient-coset-cell-incidence"],
    statement: [
      paragraph([
        ref("def_finite_quotient_role_stabilizers_and_coset_cell_sets"),
        " の三つの剰余類セル集合に対し、面・頂点、面・辺、頂点・辺の incidence を一つに集めた有限関係 ",
        math(String.raw`\mathcal I_Q`),
        " を",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathcal I_Q
&:=
\left\{
  \left(
    (\mathtt{face},C_F),
    (\mathtt{vertex},C_V)
  \right)
  \middle|
  \begin{array}{c}
  C_F\in Q/H_F,\ C_V\in Q/H_V,\\
  C_F\cap C_V\ne\varnothing
  \end{array}
\right\}\\
&\quad\cup
\left\{
  \left(
    (\mathtt{face},C_F),
    (\mathtt{edge},C_E)
  \right)
  \middle|
  \begin{array}{c}
  C_F\in Q/H_F,\ C_E\in Q/H_E,\\
  C_F\cap C_E\ne\varnothing
  \end{array}
\right\}\\
&\quad\cup
\left\{
  \left(
    (\mathtt{vertex},C_V),
    (\mathtt{edge},C_E)
  \right)
  \middle|
  \begin{array}{c}
  C_V\in Q/H_V,\ C_E\in Q/H_E,\\
  C_V\cap C_E\ne\varnothing
  \end{array}
\right\}.
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`C_F,C_V,C_E`),
        " はそれぞれ有限群 ",
        math(String.raw`Q`),
        " の部分集合である左剰余類そのものであり、代表元ではない。したがって incidence の真偽は有限集合の共通元の有無だけで決まり、代表元の選択に依存しない。実際、",
        math(String.raw`R,S\in\{F,V,E\}`),
        "、",
        math(String.raw`g,k\in Q`),
        " に対して",
      ]),
      displayMath(String.raw`gH_R\cap kH_S\ne\varnothing
\quad\Longleftrightarrow\quad
\exists h_R\in H_R\ \exists h_S\in H_S
\quad gh_R=kh_S`),
      paragraph([
        "である。右辺で選ぶ ",
        math(String.raw`g,k`),
        " を同じ左剰余類の別の元へ替えても、左辺の二つの部分集合は変わらない。関係 ",
        math(String.raw`\mathcal I_Q`),
        " はセル間の incidence だけを与え、端点の役割、面境界の巡回順序、閉曲面性、正則性、向き付けを結論しない。全ての対象と量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_quotient_lattice_definition_oriented_coset_edge_endpoint_data",
    kind: "definition",
    title: { text: "向き付き剰余類辺の端点写像" },
    labels: ["def_finite_quotient_oriented_coset_edge_endpoint_data"],
    habitat: "finite",
    verification: ["sagemath/check/finite-quotient-oriented-edge-endpoints"],
    statement: [
      paragraph([
        ref("def_finite_quotient_coset_cell_incidence_relation"),
        " の剰余類セル間 incidence と ",
        ref("def_edge_endpoint_label_set"),
        " の形式的辺端ラベル集合に対し、辺剰余類の向きを選ぶ代表元選択写像全体を",
      ]),
      displayMath(String.raw`\operatorname{Rep}_E(Q):=
\left\{
  \eta_E:Q/H_E\to Q
  \middle|
  \forall C_E\in Q/H_E\quad \eta_E(C_E)\in C_E
\right\}`),
      paragraph([
        "と定める。全ての左剰余類 ",
        math(String.raw`C_E\in Q/H_E`),
        " は空でない有限集合なので、有限列挙により ",
        math(String.raw`\operatorname{Rep}_E(Q)`),
        " は空でない。各 ",
        math(String.raw`\eta_E\in\operatorname{Rep}_E(Q)`),
        " に対し、向き付き剰余類辺の端点写像を",
      ]),
      displayMath(String.raw`\partial_{Q,\eta_E}:
\mathcal E_Q\times\mathsf{End}\longrightarrow\mathcal V_Q`),
      paragraph(["であって、各 ", math(String.raw`C_E\in Q/H_E`), " に対して"]),
      displayMath(String.raw`\begin{aligned}
\partial_{Q,\eta_E}
\left(
  (\mathtt{edge},C_E),
  \mathsf{source}
\right)
&:=
\left(
  \mathtt{vertex},
  \eta_E(C_E)H_V
\right),\\
\partial_{Q,\eta_E}
\left(
  (\mathtt{edge},C_E),
  \mathsf{target}
\right)
&:=
\left(
  \mathtt{vertex},
  \eta_E(C_E)r_EH_V
\right)
\end{aligned}`),
      paragraph([
        "を満たす写像と定める。",
        math(String.raw`\eta_E(C_E)\in C_E`),
        " かつ ",
        math(String.raw`r_E\in H_E`),
        " なので ",
        math(String.raw`\eta_E(C_E)r_E\in C_E`),
        " である。したがって右辺の二頂点セルは、どちらも ",
        math(String.raw`(\mathtt{edge},C_E)`),
        " と ",
        math(String.raw`\mathcal I_Q`),
        " で incident である。代表元選択写像 ",
        math(String.raw`\eta_E`),
        " は辺の向きを選ぶ追加の有限データであり、剰余類そのものと同一視しない。別の選択に対する ",
        math(String.raw`\mathsf{source}`),
        " と ",
        math(String.raw`\mathsf{target}`),
        " の一致は要求しない。また、二端の相異性、面境界の巡回順序、閉曲面性、正則性、向き付けはこの定義から結論せず、生成後の有限セル分割述語で検査する。全ての対象と量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_quotient_lattice_definition_face_cyclic_position_system",
    kind: "definition",
    title: { text: "剰余類面の巡回位置系" },
    labels: ["def_finite_quotient_face_cyclic_position_system"],
    habitat: "finite",
    verification: ["sagemath/check/finite-quotient-face-cyclic-position-system"],
    statement: [
      paragraph([
        ref("def_finite_quotient_role_stabilizers_and_coset_cell_sets"),
        " の面セル集合と ",
        ref("def_finite_cellulation_cyclic_position_system"),
        " の巡回位置系に対し、各剰余類面 ",
        math(String.raw`f=(\mathtt{face},C_F)\in\mathcal F_Q`),
        " の形式的位置集合を",
      ]),
      displayMath(String.raw`P_f^Q:=\{\mathtt{position}\}\times C_F`),
      paragraph([
        "と定める。ここで ",
        math(String.raw`\mathtt{position}`),
        " は面セル、頂点セル、辺セルの役割ラベルと異なる形式的ラベルである。次位置写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
s_f^Q:P_f^Q&\longrightarrow P_f^Q,\\
s_f^Q\left(\mathtt{position},a\right)
&:=
\left(
  \mathtt{position},
  ar_F
\right)
\qquad(a\in C_F)
\end{aligned}`),
      paragraph([
        "と定める。",
        math(String.raw`C_F=gH_F`),
        "、",
        math(String.raw`H_F=\langle r_F\rangle`),
        " なので、",
        math(String.raw`a\in C_F`),
        " なら ",
        math(String.raw`ar_F\in C_F`),
        " であり、この写像は well-defined である。さらに ",
        ref("def_hyperbolic_triangle_permutation_quotient_input"),
        " の位数条件により ",
        math(String.raw`r_F`),
        " の位数は ",
        math(String.raw`p\in\mathbb N_{>0}`),
        " であるから、逆写像と反復はそれぞれ",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(s_f^Q\right)^{-1}
\left(\mathtt{position},a\right)
&=
\left(
  \mathtt{position},
  ar_F^{p-1}
\right),\\
\left(s_f^Q\right)^{\circ m}
\left(\mathtt{position},a\right)
&=
\left(
  \mathtt{position},
  ar_F^m
\right)
\qquad(m\in\mathbb N)
\end{aligned}`),
      paragraph([
        "である。任意の ",
        math(String.raw`a,b\in C_F`),
        " に対して、左剰余類と巡回部分群の定義から、ある ",
        math(String.raw`m\in\mathbb N`),
        " が存在して ",
        math(String.raw`b=ar_F^m`),
        " となる。したがって ",
        math(String.raw`s_f^Q`),
        " は全単射であり、",
        math(String.raw`\mathcal P_f^Q=(P_f^Q,s_f^Q)`),
        " は一つの巡回列をなす有限な巡回位置系である。位置は整数添字でも群元そのものでもなく、形式的ラベルと剰余類の元の順序対である。定義は面剰余類の代表元選択に依存せず、面境界に置く辺と向きは後続の別ブロックで定める。全ての対象と量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_quotient_lattice_definition_oriented_coset_face_boundary_word",
    kind: "definition",
    title: { text: "剰余類面の向き付き境界語" },
    labels: ["def_finite_quotient_oriented_coset_face_boundary_word"],
    habitat: "finite",
    verification: ["sagemath/check/finite-quotient-oriented-face-boundary-word"],
    statement: [
      paragraph([
        ref("def_finite_quotient_oriented_coset_edge_endpoint_data"),
        " の代表元選択写像 ",
        math(String.raw`\eta_E\in\operatorname{Rep}_E(Q)`),
        " と端点写像、および ",
        ref("def_finite_quotient_face_cyclic_position_system"),
        " の巡回位置系に対し、各剰余類面 ",
        math(String.raw`f=(\mathtt{face},C_F)\in\mathcal F_Q`),
        " の向き付き境界語を写像",
      ]),
      displayMath(String.raw`\partial_{\mathrm{word}}^{Q,\eta_E}f:
P_f^Q\longrightarrow\mathcal E_Q\times\mathsf{Ori}`),
      paragraph([
        "であって、各 ",
        math(String.raw`a\in C_F`),
        " と辺剰余類 ",
        math(String.raw`C_E(a):=aH_E\in Q/H_E`),
        " に対して",
      ]),
      displayMath(String.raw`\partial_{\mathrm{word}}^{Q,\eta_E}f
\left(\mathtt{position},a\right)
:=
\begin{cases}
\left(
  (\mathtt{edge},C_E(a)),
  \mathsf{reverse}
\right),
&\eta_E(C_E(a))=a,\\[6pt]
\left(
  (\mathtt{edge},C_E(a)),
  \mathsf{forward}
\right),
&\eta_E(C_E(a))=ar_E
\end{cases}`),
      paragraph([
        "を満たす写像と定める。",
        math(String.raw`H_E=\langle r_E\rangle=\{\operatorname{id}_{\Omega},r_E\}`),
        " であり、",
        math(String.raw`\eta_E(C_E(a))\in C_E(a)=\{a,ar_E\}`),
        " なので二場合のちょうど一方が成立し、この写像は well-defined である。",
        ref("def_finite_cellulation_orientation_endpoint_selectors"),
        " の端点選択写像を用いると、どちらの場合も位置 ",
        math(String.raw`(\mathtt{position},a)`),
        " の向き付き辺は頂点 ",
        math(String.raw`(\mathtt{vertex},ar_EH_V)`),
        " から頂点 ",
        math(String.raw`(\mathtt{vertex},aH_V)`),
        " へ進む。さらに三角群関係 ",
        math(String.raw`r_F\circ r_V\circ r_E=\operatorname{id}_{\Omega}`),
        " から ",
        math(String.raw`r_EH_V=r_F^{-1}H_V`),
        " が従うので、次位置 ",
        math(String.raw`s_f^Q(\mathtt{position},a)=(\mathtt{position},ar_F)`),
        " の始点は ",
        math(String.raw`(\mathtt{vertex},ar_Fr_EH_V)=(\mathtt{vertex},aH_V)`),
        " である。したがって ",
        ref("def_finite_cellulation_face_boundary_word"),
        " の端点接続条件を満たす。辺の向きは代表元選択写像に依存するが、各位置で実際に進む二頂点と辺剰余類は変わらない。閉曲面性、正則性、向き付けはこの定義から結論せず、生成後の有限セル分割述語で検査する。全ての対象と量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
]);
