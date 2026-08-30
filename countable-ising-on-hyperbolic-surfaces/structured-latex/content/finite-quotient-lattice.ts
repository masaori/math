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
        math(String.raw`\Omega\in\mathcal P_{\mathrm{fin}}(\operatorname{HF}(\mathbb N))`),
        " に対し、",
        ref("def_finite_permutation_group_notation"),
        " の有限置換群の記法と ",
        ref("def_finite_group_action_and_transitivity"),
        " の群作用を用いる。双曲三角群の有限置換商入力を、順序付き組",
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
        ref("def_natural_rational_embedding"),
        " の標準単射を用いる。最初の六条件は有限置換の合成と等号、推移性の有限探索で判定でき、最後の条件は有理数の厳密比較で判定できる。",
      ]),
      paragraph([
        math(String.raw`r_F,r_V,r_E`),
        " の添字は、後に面、頂点、辺の安定化部分群を作るための役割名である。この定義だけから剰余類をセルと同一視せず、生成されるセルデータの閉曲面性、正則性、向き付けも結論しない。それらは始域と終域を明示した剰余類写像を定義した後、既存の有限セル分割述語で別に検査する。全ての群と集合は有限であり、双曲平面の座標、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_quotient_lattice_definition_cell_role_label_set",
    kind: "definition",
    title: { text: "セルの役割ラベル集合" },
    labels: ["def_finite_quotient_cell_role_label_set"],
    habitat: "finite",
    statement: [
      paragraph(["面、頂点、辺の役割を表す互いに異なる形式的ラベルを ", math(String.raw`\mathsf{FaceRole},\mathsf{VertexRole},\mathsf{EdgeRole}`), " とし、役割ラベル集合を"]),
      displayMath(String.raw`\mathsf{CellRole}:=\{\mathsf{FaceRole},\mathsf{VertexRole},\mathsf{EdgeRole}\}`),
      paragraph(["と定める。添字の略記 ", math(String.raw`R\in\{F,V,E\}`), " に対する実データのタグを写像"]),
      displayMath(String.raw`\mathsf{role}:\{F,V,E\}\to\mathsf{CellRole},\qquad
\mathsf{role}(F)=\mathsf{FaceRole},\quad\mathsf{role}(V)=\mathsf{VertexRole},\quad\mathsf{role}(E)=\mathsf{EdgeRole}`),
      paragraph(["で定める。", math("R"), " はメタ添字、", math(String.raw`\mathsf{role}(R)`), " は集合の元として使える形式的ラベルであり、頂点集合や辺集合と同一視しない。"])],
  },
  {
    id: "finite_quotient_lattice_definition_role_stabilizers",
    kind: "definition",
    title: { text: "役割安定化部分群" },
    labels: ["def_finite_quotient_role_stabilizers"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_hyperbolic_triangle_permutation_quotient_input"), " の入力 ", math(String.raw`\mathcal Q_{p,q}=(\Omega,Q,r_F,r_V,r_E)`), " と ", ref("def_finite_quotient_cell_role_label_set"), " の役割メタ添字に対し、役割安定化部分群の族を"]),
      displayMath(String.raw`(H_R)_{R\in\{F,V,E\}}:=\bigl(\langle r_F\rangle,\langle r_V\rangle,\langle r_E\rangle\bigr)`),
      paragraph(["と定める。すなわち ", math(String.raw`H_F=\langle r_F\rangle`), "、", math(String.raw`H_V=\langle r_V\rangle`), "、", math(String.raw`H_E=\langle r_E\rangle`), " であり、いずれも ", math("Q"), " の部分群である。"])],
  },
  {
    id: "finite_quotient_lattice_definition_role_coset_sets",
    kind: "definition",
    title: { text: "役割別の左剰余類集合" },
    labels: ["def_finite_quotient_role_coset_sets"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_finite_quotient_role_stabilizers"), " の部分群族に対し、", ref("def_left_coset_set"), " の左剰余類集合の族を"]),
      displayMath(String.raw`(Q/H_R)_{R\in\{F,V,E\}}:=\bigl(Q/H_F,Q/H_V,Q/H_E\bigr)`),
      paragraph(["と定める。各元 ", math(String.raw`gH_R\in Q/H_R`), " は代表元 ", math("g"), " ではなく ", math("Q"), " の部分集合である。"])],
  },
  {
    id: "finite_quotient_lattice_definition_role_stabilizers_and_coset_cell_sets",
    kind: "definition",
    title: { text: "剰余類セルラベル集合" },
    labels: ["def_finite_quotient_role_stabilizers_and_coset_cell_sets"],
    habitat: "finite",
    verification: ["sagemath/check/finite-quotient-coset-cell-sets"],
    statement: [
      paragraph([ref("def_finite_quotient_role_coset_sets"), " の三つの剰余類集合と、互いに異なる形式的ラベル ", math(String.raw`\mathtt{face},\mathtt{vertex},\mathtt{edge}`), " を用いる。剰余類セルラベル集合の族を"]),
      displayMath(String.raw`(\mathcal F_Q,\mathcal V_Q,\mathcal E_Q):=\left(\{\mathtt{face}\}\times(Q/H_F),\{\mathtt{vertex}\}\times(Q/H_V),\{\mathtt{edge}\}\times(Q/H_E)\right)`),
      paragraph(["と定める。第一成分の役割ラベルにより三集合を同一視しない。この定義は端点写像、面境界語、閉曲面性、正則性、向き付けを結論しない。"])],
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
  \mathsf{forward}
  \right),
&\eta_E(C_E(a))=a,\\[6pt]
\left(
  (\mathtt{edge},C_E(a)),
  \mathsf{reverse}
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
        math(String.raw`(\mathtt{vertex},aH_V)`),
        " から頂点 ",
        math(String.raw`(\mathtt{vertex},ar_EH_V)`),
        " へ進む。さらに三角群関係 ",
        math(String.raw`r_F\circ r_V\circ r_E=\operatorname{id}_{\Omega}`),
        " から ",
        math(String.raw`r_EH_V=r_FH_V`),
        " が従うので、次位置 ",
        math(String.raw`s_f^Q(\mathtt{position},a)=(\mathtt{position},ar_F)`),
        " の始点は ",
        math(String.raw`(\mathtt{vertex},ar_FH_V)=(\mathtt{vertex},ar_EH_V)`),
        " である。したがって ",
        ref("def_finite_cellulation_face_boundary_word"),
        " の端点接続条件を満たす。辺の向きは代表元選択写像に依存するが、各位置で実際に進む二頂点と辺剰余類は変わらない。閉曲面性、正則性、向き付けはこの定義から結論せず、生成後の有限セル分割述語で検査する。全ての対象と量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "finite_quotient_lattice_theorem_generated_cellulation_is_hyperbolic_regular",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "生成剰余類セルデータの有限検査" },
    labels: ["theorem_generated_quotient_cellulation_is_hyperbolic_regular"],
    habitat: "N",
    verification: ["sagemath/check/generated-quotient-cellulation-finite-check"],
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`\Omega:=\{1,2,3,4,5,6,7,8\}`),
        " 上の置換を",
      ]),
      displayMath(String.raw`\begin{aligned}
r_F
&:=
(1\ 6\ 2)(3\ 8\ 4),\\
r_V
&:=
(1\ 8\ 4\ 2\ 5\ 6\ 7),\\
r_E
&:=
(1\ 4)(2\ 5)(3\ 8)(6\ 7)
\end{aligned}`),
      paragraph([
        "とし、有限置換群 ",
        math(String.raw`Q:=\langle r_F,r_V,r_E\rangle\leq\operatorname{Sym}(\Omega)`),
        " を取る。各 ",
        math(String.raw`g\in Q`),
        " に対して ",
        math(String.raw`\operatorname{code}(g):=(g(1),g(2),\ldots,g(8))\in\Omega^8`),
        " と置き、",
        math(String.raw`\Omega^8`),
        " の辞書式順序に関する各辺剰余類の最小元を選ぶ代表元選択写像を ",
        math(String.raw`\eta_E^{\min}\in\operatorname{Rep}_E(Q)`),
        " とする。",
      ]),
      paragraph([
        "上で定めた有限データの組を ",
        math(String.raw`\mathcal Q_{3,7}:=(\Omega,Q,r_F,r_V,r_E)`),
        " と書く。置換を直接計算すると ",
        math(String.raw`Q=\langle r_F,r_V,r_E\rangle`),
        "、",
        math(String.raw`\operatorname{ord}(r_F)=3`),
        "、",
        math(String.raw`\operatorname{ord}(r_V)=7`),
        "、",
        math(String.raw`\operatorname{ord}(r_E)=2`),
        "、",
        math(String.raw`r_Fr_Vr_E=1_Q`),
        "、推移性が成り立つ。したがって ",
        ref("def_hyperbolic_triangle_permutation_quotient_input"),
        " の ",
        math(String.raw`\mathcal Q_{3,7}`),
        " と、",
        ref("def_finite_quotient_role_stabilizers_and_coset_cell_sets"),
        "、",
        ref("def_finite_quotient_oriented_coset_edge_endpoint_data"),
        "、",
        ref("def_finite_quotient_oriented_coset_face_boundary_word"),
        " によりこの入力から生成した有限グラフ、セル集合入力、向き付き境界語の族をそれぞれ ",
        math(String.raw`G_Q`),
        "、",
        math(String.raw`\mathcal C_Q`),
        "、",
        math(String.raw`\bigl(\partial_{\mathrm{word}}^{Q,\eta_E^{\min}}f\bigr)_{f\in\mathcal F_Q}`),
        " と書き、構造化データを",
      ]),
      displayMath(String.raw`\mathcal X_Q
:=
\left(
  G_Q,
  \mathcal C_Q,
  \left(
    \mathcal P_f^Q,
    \partial_{\mathrm{word}}^{Q,\eta_E^{\min}}f
  \right)_{f\in\mathcal F_Q}
\right)`),
      paragraph(["とする。このとき"]),
      displayMath(String.raw`(3,7)
\in
\operatorname{HyperbolicRegularTypes}(\mathcal X_Q)`),
      paragraph([
        "である。ここで ",
        math(String.raw`3,7\in\mathbb N_{>0}`),
        "、三つのセル集合、端点写像、位置集合、境界語は有限集合または有限集合間の写像である。双曲条件も自然数上で判定し、実数、複素数、極限、積分は用いない。",
      ]),
    ],
    proof: [
      paragraph([
        "有限置換と全ての剰余類を列挙すると、",
        math(String.raw`|Q|=168`),
        "、",
        math(String.raw`|\mathcal V_Q|=24`),
        "、",
        math(String.raw`|\mathcal E_Q|=84`),
        "、",
        math(String.raw`|\mathcal F_Q|=56`),
        " である。各辺は全境界語に正逆一回ずつ現れ、各頂点の角は辺端の共有により一つの巡回列をなし、有限集合上の幅優先探索は一次骨格の全二十四頂点へ到達する。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{OppositeEdgeTwice}
\left(
  \left(
    \partial_{\mathrm{word}}^{Q,\eta_E^{\min}}f
  \right)_{f\in\mathcal F_Q}
\right)
&=\mathrm{true},\\
\operatorname{VertexLinksAreCycles}
\left(
  G_Q,
  \left(
    \partial_{\mathrm{word}}^{Q,\eta_E^{\min}}f
  \right)_{f\in\mathcal F_Q}
\right)
&=\mathrm{true},\\
\operatorname{ConnectedOneSkeleton}(G_Q)
&=\mathrm{true}.
\end{aligned}`),
      paragraph([ref("def_oriented_closed_surface_cellulation"), " より"]),
      displayMath(String.raw`\operatorname{OrientedClosedSurfaceCellulation}
\left(
  G_Q,
  \mathcal C_Q,
  \left(
    \partial_{\mathrm{word}}^{Q,\eta_E^{\min}}f
  \right)_{f\in\mathcal F_Q}
\right)
=\mathrm{true}.`),
      paragraph([
        "さらに全五十六面の位置集合の元数は三であり、全二十四頂点に接する角位置の元数は七である。",
        "したがって ",
        math(String.raw`D_F(\mathcal X_Q)=\{3\}`),
        " および ",
        math(String.raw`D_V(\mathcal X_Q)=\{7\}`),
        " である。",
        ref("def_finite_cellulation_regular_type_set"),
        " より",
      ]),
      displayMath(String.raw`(3,7)
\in
\operatorname{RegularTypes}(\mathcal X_Q).`),
      displayMath(String.raw`\begin{aligned}
2(3+7)
&=20,\\
3\cdot 7
&=21,\\
20
&<21.
\end{aligned}`),
      paragraph([ref("def_finite_cellulation_hyperbolic_regular_type_set"), " より"]),
      displayMath(String.raw`(3,7)
\in
\operatorname{HyperbolicRegularTypes}(\mathcal X_Q).`),
    ],
  },
  {
    id: "finite_quotient_lattice_theorem_fixed_quotient_ising_partition_polynomial",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "固定剰余類格子の Ising 分配多項式" },
    labels: ["theorem_fixed_quotient_ising_partition_polynomial"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/fixed-quotient-ising-partition-polynomial"],
    statement: [
      paragraph([
        ref("theorem_generated_quotient_cellulation_is_hyperbolic_regular"),
        " で生成した有限グラフ ",
        math(String.raw`G_Q`),
        " の Ising 分配多項式は",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_{G_Q}(x)
&=2+48x^{7}+168x^{12}+384x^{14}+112x^{15}\\
&\quad{}+672x^{17}+168x^{18}+2016x^{19}+1092x^{20}+1584x^{21}\\
&\quad{}+3696x^{22}+2688x^{23}+9030x^{24}+7392x^{25}+13776x^{26}\\
&\quad{}+23520x^{27}+21552x^{28}+46368x^{29}+67760x^{30}+100800x^{31}\\
&\quad{}+142674x^{32}+194208x^{33}+339360x^{34}+458784x^{35}+530824x^{36}\\
&\quad{}+696192x^{37}+938448x^{38}+1128848x^{39}+1150716x^{40}+1253280x^{41}\\
&\quad{}+1541040x^{42}+1570464x^{43}+1338120x^{44}+1243872x^{45}+1213968x^{46}\\
&\quad{}+984144x^{47}+662508x^{48}+461376x^{49}+329784x^{50}+183680x^{51}\\
&\quad{}+75348x^{52}+27216x^{53}+8064x^{54}+1344x^{55}+126x^{56}
\in\mathbb Z[x].
\end{aligned}`),
    ],
    proof: [
      paragraph([
        "有限集合 ",
        math(String.raw`\mathcal V_Q`),
        " に一つの全順序を固定する。各配位 ",
        math(String.raw`\sigma\in\mathcal S_{G_Q}`),
        " を、その順序で並べた二十四成分のスピン列へ送る。この写像は ",
        math(String.raw`\mathcal S_{G_Q}`),
        " から二十四成分の二値列全体への全単射である。",
      ]),
      paragraph([ref("claim_partition_polynomial_coefficient_expansion"), " より"]),
      displayMath(String.raw`\begin{aligned}
Z_{G_Q}(x)
&=\sum_{m=0}^{84}\Omega_{G_Q}(m)x^m
&&\bigl(\because\ \text{多重度による係数表示}\bigr)\\
&=2+48x^{7}+168x^{12}
&&\bigl(\because\ \text{全二値列の有限計数}\bigr)\\
&\quad{}+384x^{14}+112x^{15}+672x^{17}\\
&\quad{}+168x^{18}+2016x^{19}+1092x^{20}\\
&\quad{}+1584x^{21}+3696x^{22}+2688x^{23}\\
&\quad{}+9030x^{24}+7392x^{25}+13776x^{26}\\
&\quad{}+23520x^{27}+21552x^{28}+46368x^{29}\\
&\quad{}+67760x^{30}+100800x^{31}+142674x^{32}\\
&\quad{}+194208x^{33}+339360x^{34}+458784x^{35}\\
&\quad{}+530824x^{36}+696192x^{37}+938448x^{38}\\
&\quad{}+1128848x^{39}+1150716x^{40}+1253280x^{41}\\
&\quad{}+1541040x^{42}+1570464x^{43}+1338120x^{44}\\
&\quad{}+1243872x^{45}+1213968x^{46}+984144x^{47}\\
&\quad{}+662508x^{48}+461376x^{49}+329784x^{50}\\
&\quad{}+183680x^{51}+75348x^{52}+27216x^{53}\\
&\quad{}+8064x^{54}+1344x^{55}+126x^{56}.
\end{aligned}`),
      paragraph([
        "有限計数では、",
        ref("def_finite_quotient_oriented_coset_edge_endpoint_data"),
        " の端点写像から得る全八十四辺について、各二値列の相異なる端点値をもつ辺数を ",
        ref("def_broken_edge_set"),
        " に従って数えた。係数の総和は ",
        math(String.raw`16777216=2^{24}`),
        " である。全ての係数と指数は自然数であり、多項式は ",
        math(String.raw`\mathbb Z[x]`),
        " に属する。実数、複素数、極限、積分は用いない。",
      ]),
    ],
  },
]);
