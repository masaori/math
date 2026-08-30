import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "quotient_tower_heading_input",
    kind: "heading",
    level: 1,
    title: { text: "被覆写像をもつ商の塔" },
    labels: [],
  },
  {
    id: "quotient_tower_definition_two_stage_finite_quotient_tower_input",
    kind: "definition",
    title: { text: "二段の有限商の塔の入力" },
    labels: ["def_two_stage_finite_quotient_tower_input"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-finite-quotient-tower-input"],
    statement: [
      paragraph([
        ref("def_hereditarily_finite_data_over_naturals"),
        " に属する空でない有限集合 ",
        math(String.raw`\Omega\in\mathcal P_{\mathrm{fin}}(\operatorname{HF}(\mathbb N))`),
        " と ",
        ref("def_finite_permutation_group_notation"),
        " の有限置換群 ",
        math(String.raw`A\leq\operatorname{Sym}(\Omega)`),
        " に対し、二段の有限商の塔の入力を順序付き組",
      ]),
      displayMath(String.raw`\mathcal T:=
\left(
  \Omega,
  A,
  N_{\mathrm{fine}},
  N_{\mathrm{coarse}},
  Q_{\mathrm{fine}},
  Q_{\mathrm{coarse}},
  \pi_{\mathrm{fine}},
  \pi_{\mathrm{coarse}},
  \kappa
\right)`),
      paragraph([
        "であって、",
        math(String.raw`N_{\mathrm{fine}},N_{\mathrm{coarse}}`),
        " は ",
        math(String.raw`A`),
        " の正規部分群、",
        math(String.raw`\mathtt{fine},\mathtt{coarse}`),
        " は互いに異なる形式的な段ラベルであり、次を全て満たすものと定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_{\mathrm{fine}}
&\subseteq N_{\mathrm{coarse}}
\subseteq A,\\
Q_{\mathrm{fine}}
&:=
\{\mathtt{fine}\}\times(A/N_{\mathrm{fine}}),\\
Q_{\mathrm{coarse}}
&:=
\{\mathtt{coarse}\}\times(A/N_{\mathrm{coarse}}),\\
\pi_{\mathrm{fine}}
&:A\longrightarrow Q_{\mathrm{fine}},
&
a
&\longmapsto
\left(
  \mathtt{fine},
  aN_{\mathrm{fine}}
\right),\\
\pi_{\mathrm{coarse}}
&:A\longrightarrow Q_{\mathrm{coarse}},
&
a
&\longmapsto
\left(
  \mathtt{coarse},
  aN_{\mathrm{coarse}}
\right),\\
\kappa
&:Q_{\mathrm{fine}}\longrightarrow Q_{\mathrm{coarse}},
&
\left(
  \mathtt{fine},
  aN_{\mathrm{fine}}
\right)
&\longmapsto
\left(
  \mathtt{coarse},
  aN_{\mathrm{coarse}}
\right),\\
\kappa\circ\pi_{\mathrm{fine}}
&=\pi_{\mathrm{coarse}}.
\end{aligned}`),
      paragraph(["タグ付き商集合上の群演算を、", math(String.raw`R\in\{\mathrm{fine},\mathrm{coarse}\}`), " と対応する正規部分群 ", math(String.raw`N_R`), " に対して"]),
      displayMath(String.raw`\begin{aligned}
(\mathtt R,aN_R)\cdot_R(\mathtt R,bN_R)&:=(\mathtt R,(ab)N_R),\\
1_R&:=(\mathtt R,N_R),\\
(\mathtt R,aN_R)^{-1_R}&:=(\mathtt R,a^{-1}N_R)
\end{aligned}`),
      paragraph(["で定める。ここで ", math(String.raw`\mathtt R`), " は ", math(String.raw`R=\mathrm{fine}`), " なら ", math(String.raw`\mathtt{fine}`), "、", math(String.raw`R=\mathrm{coarse}`), " なら ", math(String.raw`\mathtt{coarse}`), " である。"]),
      paragraph([
        "ここで ",
        math(String.raw`A/N_{\mathrm{fine}}`),
        " と ",
        math(String.raw`A/N_{\mathrm{coarse}}`),
        " は ", ref("def_left_coset_set"), " の左剰余類集合である。二つの部分群が正規であるため、上の積と逆元は代表元に依存せず、タグ付き集合はそれぞれ有限群をなす。段ラベルにより二つの商群を同一視しない。",
      ]),
      displayMath(String.raw`\begin{aligned}
aN_{\mathrm{fine}}=bN_{\mathrm{fine}}
&\Longrightarrow b^{-1}a\in N_{\mathrm{fine}}\\
&\Longrightarrow b^{-1}a\in N_{\mathrm{coarse}}
&&\bigl(\because\ N_{\mathrm{fine}}\subseteq N_{\mathrm{coarse}}\bigr)\\
&\Longrightarrow aN_{\mathrm{coarse}}=bN_{\mathrm{coarse}}.
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`\kappa`),
        " は代表元に依存しない全射群準同型である。写像 ",
        math(String.raw`\pi_{\mathrm{fine}},\pi_{\mathrm{coarse}}`),
        " はそれぞれの標準全射群準同型であり、最後の等式は二つの段を結ぶ可換条件である。有限商を二つ並べただけの列は、始域と終域をもつ ",
        math(String.raw`\kappa`),
        " とこの可換条件を欠くため、この定義の入力ではない。全ての対象と量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_role_generator_compatibility",
    kind: "definition",
    title: { text: "商の塔における役割生成元の整合性" },
    labels: ["def_quotient_tower_role_generator_compatibility"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-role-generators"],
    statement: [
      paragraph([
        ref("def_two_stage_finite_quotient_tower_input"),
        " の二段の有限商の塔 ",
        math(String.raw`\mathcal T`),
        " と、",
        ref("def_hyperbolic_triangle_permutation_quotient_input"),
        " で用いた面・頂点・辺に対応する相異なる形式的役割ラベルの有限集合 ",
        math(String.raw`\mathsf{RoleIndex}:=\{F,V,E\}`),
        " を取る。共通有限群の元の族 ",
        math(String.raw`s=(s_R)_{R\in\mathsf{RoleIndex}}\in A^{\mathsf{RoleIndex}}`),
        " が",
      ]),
      displayMath(String.raw`A=\langle s_F,s_V,s_E\rangle`),
      paragraph([
        "を満たすとする。各役割 ",
        math(String.raw`R\in\mathsf{RoleIndex}`),
        " について、細段と粗段の役割生成元を",
      ]),
      displayMath(String.raw`\begin{aligned}
r_R^{\mathrm{fine}}
&:=
\pi_{\mathrm{fine}}(s_R)
\in Q_{\mathrm{fine}},\\
r_R^{\mathrm{coarse}}
&:=
\pi_{\mathrm{coarse}}(s_R)
\in Q_{\mathrm{coarse}}
\end{aligned}`),
      paragraph([
        "で定める。この六元を伴う塔が役割生成元について整合するとは、各 ",
        math(String.raw`R\in\mathsf{RoleIndex}`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa\left(r_R^{\mathrm{fine}}\right)
&=
\kappa\left(\pi_{\mathrm{fine}}(s_R)\right)\\
&=
\pi_{\mathrm{coarse}}(s_R)
&&\bigl(\because\ \kappa\circ\pi_{\mathrm{fine}}=\pi_{\mathrm{coarse}}\bigr)\\
&=
r_R^{\mathrm{coarse}}
\end{aligned}`),
      paragraph([
        "が成り立つことと定める。標準射影は全射群準同型であり、",
        math(String.raw`A=\langle s_F,s_V,s_E\rangle`),
        " なので、両段ではそれぞれ",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_{\mathrm{fine}}
&=
\left\langle
  r_F^{\mathrm{fine}},
  r_V^{\mathrm{fine}},
  r_E^{\mathrm{fine}}
\right\rangle,\\
Q_{\mathrm{coarse}}
&=
\left\langle
  r_F^{\mathrm{coarse}},
  r_V^{\mathrm{coarse}},
  r_E^{\mathrm{coarse}}
\right\rangle.
\end{aligned}`),
      paragraph(["さらに、両段で辺役割生成元と三角関係が退化しないことを入力条件として要求する。"]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(r_E^{\mathrm{fine}})&=2,&
r_F^{\mathrm{fine}}r_V^{\mathrm{fine}}r_E^{\mathrm{fine}}&=1_{\mathrm{fine}},\\
\operatorname{ord}(r_E^{\mathrm{coarse}})&=2,&
r_F^{\mathrm{coarse}}r_V^{\mathrm{coarse}}r_E^{\mathrm{coarse}}&=1_{\mathrm{coarse}}.
\end{aligned}`),
      paragraph([
        "ここでは役割名の一致を、名前の使い回しではなく始域と終域をもつ ",
        math(String.raw`\kappa`),
        " による三つの等式として固定する。面・頂点役割生成元の位数が小さくなることは許すが、辺役割生成元の位数二と三角関係は両段で保持する。各段が双曲型正則セル分割を生成することはこの定義から結論しない。全ての群、元、写像は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_induced_coset_cell_maps",
    kind: "definition",
    title: { text: "商の塔が誘導する剰余類セル写像" },
    labels: ["def_quotient_tower_induced_coset_cell_maps"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-coset-cell-maps"],
    statement: [
      paragraph([
        ref("def_finite_quotient_cell_role_label_set"),
        " の実データ役割タグと ",
        ref("def_quotient_tower_role_generator_compatibility"),
        " の役割生成元について整合する二段の有限商の塔と、",
        ref("def_finite_quotient_role_stabilizers_and_coset_cell_sets"),
        " の役割安定化部分群と剰余類セル集合の構成を取る。各形式的役割ラベル ",
        math(String.raw`R\in\mathsf{RoleIndex}=\{F,V,E\}`),
        " について、両段の役割安定化部分群を",
      ]),
      displayMath(String.raw`\begin{aligned}
H_R^{\mathrm{fine}}
&:=
\left\langle
  r_R^{\mathrm{fine}}
\right\rangle
\leq Q_{\mathrm{fine}},\\
H_R^{\mathrm{coarse}}
&:=
\left\langle
  r_R^{\mathrm{coarse}}
\right\rangle
\leq Q_{\mathrm{coarse}}
\end{aligned}`),
      paragraph([
        "で定める。役割生成元の整合性と ",
        math(String.raw`\kappa`),
        " の群準同型性により、各役割について",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa\left(H_R^{\mathrm{fine}}\right)
&=
\kappa\left(
  \left\langle
    r_R^{\mathrm{fine}}
  \right\rangle
\right)\\
&=
\left\langle
  \kappa\left(r_R^{\mathrm{fine}}\right)
\right\rangle
&&\bigl(\because\ \kappa\ \text{は群準同型}\bigr)\\
&=
\left\langle
  r_R^{\mathrm{coarse}}
\right\rangle
&&\bigl(\because\ \text{役割生成元の整合性}\bigr)\\
&=
H_R^{\mathrm{coarse}}.
\end{aligned}`),
      paragraph([
        "細段と粗段を同一視せず、段ラベルと役割ラベルを付けた有限剰余類セル集合を",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathcal C_R^{\mathrm{fine}}
&:=
\{\mathtt{fine}\}\times\{\mathsf{role}(R)\}\times
\left(Q_{\mathrm{fine}}/H_R^{\mathrm{fine}}\right),\\
\mathcal C_R^{\mathrm{coarse}}
&:=
\{\mathtt{coarse}\}\times\{\mathsf{role}(R)\}\times
\left(Q_{\mathrm{coarse}}/H_R^{\mathrm{coarse}}\right)
\end{aligned}`),
      paragraph([
        "と定める。ここで各商は左剰余類集合である。段間全射群準同型が誘導する役割 ",
        math(String.raw`R`),
        " の剰余類セル写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_R:
\mathcal C_R^{\mathrm{fine}}
&\longrightarrow
\mathcal C_R^{\mathrm{coarse}},\\
\left(
  \mathtt{fine},
  \mathsf{role}(R),
  gH_R^{\mathrm{fine}}
\right)
&\longmapsto
\left(
  \mathtt{coarse},
  \mathsf{role}(R),
  \kappa(g)H_R^{\mathrm{coarse}}
\right)
\qquad
\left(g\in Q_{\mathrm{fine}}\right)
\end{aligned}`),
      paragraph([
        "で定める。この作用が細段の左剰余類の代表元に依存しないことは、任意の ",
        math(String.raw`g,h\in Q_{\mathrm{fine}}`),
        " に対する次の含意で確定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
gH_R^{\mathrm{fine}}
&=hH_R^{\mathrm{fine}}\\
&\Longrightarrow
h^{-1}g\in H_R^{\mathrm{fine}}\\
&\Longrightarrow
\kappa\left(h^{-1}g\right)
\in
\kappa\left(H_R^{\mathrm{fine}}\right)\\
&\Longrightarrow
\kappa(h)^{-1}\kappa(g)
\in
H_R^{\mathrm{coarse}}
&&\bigl(\because\ \kappa\ \text{は群準同型かつ }\kappa(H_R^{\mathrm{fine}})=H_R^{\mathrm{coarse}}\bigr)\\
&\Longrightarrow
\kappa(g)H_R^{\mathrm{coarse}}
=
\kappa(h)H_R^{\mathrm{coarse}}.
\end{aligned}`),
      paragraph([
        math(String.raw`\kappa`),
        " は全射なので、三つの ",
        math(String.raw`\overline\kappa_R`),
        " も全射である。これらは面、頂点、辺の各ラベル付き有限セルを対応する役割のセルへ送るだけであり、端点写像、面境界語、incidence、閉曲面性、正則性、向き付けを保存する被覆写像であることはまだ主張しない。全ての集合、群、部分群、商集合、写像は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_stage_coset_cell_incidence_relations",
    kind: "definition",
    title: { text: "商の各段における剰余類セル incidence" },
    labels: ["def_quotient_tower_stage_coset_cell_incidence_relations"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_quotient_tower_induced_coset_cell_maps"), " の段ラベル付き剰余類セル集合に対し、各 ", math(String.raw`T\in\{\mathrm{fine},\mathrm{coarse}\}`), " の incidence 関係を"]),
      displayMath(String.raw`\mathcal I_{Q_T}:=\left\{
\bigl((\mathtt T,\mathsf{role}(R),C_R),(\mathtt T,\mathsf{role}(S),C_S)\bigr)
\ \middle|\
(R,S)\in\{(F,V),(F,E),(V,E)\},\ C_R\in Q_T/H_R^T,\ C_S\in Q_T/H_S^T,\ C_R\cap C_S\ne\varnothing
\right\}`),
      paragraph(["と定める。ここで ", math(String.raw`\mathtt T`), " は段 ", math("T"), " の形式的ラベルである。この関係は三重タグ付きセル上に定義され、タグを持たない一般の剰余類セル関係とは型を混同しない。"])],
  },
  {
    id: "quotient_tower_theorem_coset_cell_incidence_forward_preservation",
    kind: "theorem",
    title: { text: "商の塔における剰余類セル incidence の順方向保存" },
    labels: ["theorem_quotient_tower_coset_cell_incidence_forward_preservation"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-incidence-forward-preservation"],
    statement: [
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導剰余類セル写像と ", ref("def_quotient_tower_stage_coset_cell_incidence_relations"), " の段別 incidence を取る。役割対 ",
        math(String.raw`(R,S)\in\{(F,V),(F,E),(V,E)\}`),
        "、元 ",
        math(String.raw`g,k\in Q_{\mathrm{fine}}`),
        "、および細段セル",
      ]),
      displayMath(String.raw`c_R:=
\left(
  \mathtt{fine},
  \mathsf{role}(R),
  gH_R^{\mathrm{fine}}
\right)
\in\mathcal C_R^{\mathrm{fine}},
\qquad
c_S:=
\left(
  \mathtt{fine},
  \mathsf{role}(S),
  kH_S^{\mathrm{fine}}
\right)
\in\mathcal C_S^{\mathrm{fine}}`),
      paragraph([
        "に対して、細段での incidence は粗段での incidence を含意する。すなわち、",
      ]),
      displayMath(String.raw`(c_R,c_S)\in\mathcal I_{Q_{\mathrm{fine}}}
\quad\Longrightarrow\quad
\left(
  \overline\kappa_R(c_R),
  \overline\kappa_S(c_S)
\right)
\in\mathcal I_{Q_{\mathrm{coarse}}}.`),
    ],
    proof: [
      paragraph([
        "役割対 ",
        math(String.raw`(R,S)\in\{(F,V),(F,E),(V,E)\}`),
        " と細段で incident なセル ",
        math(String.raw`c_R,c_S`),
        " を固定する。",
        ref("def_quotient_tower_stage_coset_cell_incidence_relations"),
        " の細段 incidence の定義より、ある ",
        math(String.raw`x\in Q_{\mathrm{fine}}`),
        "、",
        math(String.raw`h_R\in H_R^{\mathrm{fine}}`),
        "、",
        math(String.raw`h_S\in H_S^{\mathrm{fine}}`),
        " が存在して",
      ]),
      displayMath(String.raw`x
=
gh_R
=
kh_S.`),
      paragraph([
        ref("def_two_stage_finite_quotient_tower_input"),
        " の群準同型 ",
        math(String.raw`\kappa`),
        " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa(x)
&=
\kappa(gh_R)
&&\bigl(\because\ x=gh_R\bigr)\\
&=
\kappa(g)\kappa(h_R)
&&\bigl(\because\ \kappa\text{ は群準同型}\bigr)\\
\kappa(x)
&=
\kappa(kh_S)
&&\bigl(\because\ x=kh_S\bigr)\\
&=
\kappa(k)\kappa(h_S)
&&\bigl(\because\ \kappa\text{ は群準同型}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の部分群像の等式より、",
      ]),
      displayMath(String.raw`\kappa(g)\kappa\left(H_R^{\mathrm{fine}}\right)
=
\kappa(g)H_R^{\mathrm{coarse}}.`),
      paragraph([
        math(String.raw`h_R\in H_R^{\mathrm{fine}}`),
        " なので、",
      ]),
      displayMath(String.raw`\kappa(g)\kappa(h_R)
\in
\kappa(g)H_R^{\mathrm{coarse}}.`),
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の部分群像の等式より、",
      ]),
      displayMath(String.raw`\kappa(k)\kappa\left(H_S^{\mathrm{fine}}\right)
=
\kappa(k)H_S^{\mathrm{coarse}}.`),
      paragraph([
        math(String.raw`h_S\in H_S^{\mathrm{fine}}`),
        " なので、",
      ]),
      displayMath(String.raw`\kappa(k)\kappa(h_S)
\in
\kappa(k)H_S^{\mathrm{coarse}}.`),
      paragraph([
        "以上の四つの等式と二つの所属関係により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa(x)
&\in
\kappa(g)H_R^{\mathrm{coarse}},\\
\kappa(x)
&\in
\kappa(k)H_S^{\mathrm{coarse}}.
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`\kappa(x)`),
        " は二つの粗段剰余類の共通元であるから、",
      ]),
      displayMath(String.raw`\kappa(g)H_R^{\mathrm{coarse}}
\cap
\kappa(k)H_S^{\mathrm{coarse}}
\ne\varnothing.`),
      paragraph([
        ref("def_quotient_tower_stage_coset_cell_incidence_relations"),
        " の粗段 incidence の定義と、",
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導写像の定義より、",
      ]),
      displayMath(String.raw`\left(
  \overline\kappa_R(c_R),
  \overline\kappa_S(c_S)
\right)
\in
\mathcal I_{Q_{\mathrm{coarse}}}.`),
      paragraph([
        "全ての群、部分群、剰余類、写像、量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_oriented_edge_representative_selector_compatibility",
    kind: "definition",
    title: { text: "商の塔における向き付き辺代表元選択の整合性" },
    labels: ["def_quotient_tower_oriented_edge_representative_selector_compatibility"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-oriented-edge-representative-selectors"],
    statement: [
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の辺セル写像と、",
        ref("def_finite_quotient_oriented_coset_edge_endpoint_data"),
        " の代表元選択写像全体を取る。細段と粗段を同一視せず、二つの有限写像",
      ]),
      displayMath(String.raw`\eta_E^{\mathrm{fine}}
\in
\operatorname{Rep}_E\left(Q_{\mathrm{fine}}\right),
\qquad
\eta_E^{\mathrm{coarse}}
\in
\operatorname{Rep}_E\left(Q_{\mathrm{coarse}}\right)`),
      paragraph([
        "をそれぞれ選ぶ。対 ",
        math(String.raw`\left(\eta_E^{\mathrm{fine}},\eta_E^{\mathrm{coarse}}\right)`),
        " が段間全射群準同型 ",
        math(String.raw`\kappa`),
        " と整合するとは、全ての細段辺剰余類 ",
        math(String.raw`C_E\in Q_{\mathrm{fine}}/H_E^{\mathrm{fine}}`),
        " と粗段辺剰余類 ",
        math(String.raw`D_E\in Q_{\mathrm{coarse}}/H_E^{\mathrm{coarse}}`),
        " に対して次の含意が成り立つことと定める。",
      ]),
      displayMath(String.raw`\overline\kappa_E
\left(
  \mathtt{fine},
  \mathsf{EdgeRole},
  C_E
\right)
=
\left(
  \mathtt{coarse},
  \mathsf{EdgeRole},
  D_E
\right)
\quad\Longrightarrow\quad
\kappa\left(\eta_E^{\mathrm{fine}}(C_E)\right)
=
\eta_E^{\mathrm{coarse}}(D_E).`),
      paragraph([
        "左辺の等式は、細段辺セルの像である粗段辺セル ",
        math(String.raw`D_E`),
        " を代表元に依存せずに指定する。右辺は、そのセルを選んだ後で、細段の向きを指定する群元の像と粗段の向きを指定する群元とが一致することを要求する。したがって二段の代表元選択を名前だけで揃えず、始域と終域をもつ写像の可換条件として固定する。この定義だけから端点写像または面境界語の保存は結論しない。全ての群、剰余類、写像、量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_stage_oriented_edge_endpoint_maps",
    kind: "definition",
    title: { text: "商の各段における向き付き辺端点写像" },
    labels: ["def_quotient_tower_stage_oriented_edge_endpoint_maps"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_quotient_tower_oriented_edge_representative_selector_compatibility"), " の代表元選択に対し、各 ", math(String.raw`T\in\{\mathrm{fine},\mathrm{coarse}\}`), " の辺端点写像を"]),
      displayMath(String.raw`\begin{aligned}
\partial_G^T:\mathcal C_E^T\times\mathsf{End}&\longrightarrow\mathcal C_V^T,\\
\partial_G^T((\mathtt T,\mathsf{EdgeRole},C_E),\mathsf{source})&:=(\mathtt T,\mathsf{VertexRole},\eta_E^T(C_E)H_V^T),\\
\partial_G^T((\mathtt T,\mathsf{EdgeRole},C_E),\mathsf{target})&:=(\mathtt T,\mathsf{VertexRole},\eta_E^T(C_E)r_E^T H_V^T)
\end{aligned}`),
      paragraph(["で定める。", math(String.raw`\mathtt T`), " は段ラベルである。始域と終域はいずれも三重タグ付きセル集合であり、一般の二重タグ付き端点写像とは型を混同しない。"])],
  },
  {
    id: "quotient_tower_theorem_oriented_edge_endpoint_map_preservation",
    kind: "theorem",
    title: { text: "商の塔における向き付き辺端点写像の保存" },
    labels: ["theorem_quotient_tower_oriented_edge_endpoint_map_preservation"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-oriented-edge-endpoint-preservation"],
    statement: [
      paragraph([
        ref("def_quotient_tower_stage_oriented_edge_endpoint_maps"),
        " の端点写像を、整合する代表元選択について取る。細段辺剰余類 ",
        math(String.raw`C_E\in Q_{\mathrm{fine}}/H_E^{\mathrm{fine}}`),
        " と粗段辺剰余類 ",
        math(String.raw`D_E\in Q_{\mathrm{coarse}}/H_E^{\mathrm{coarse}}`),
        " が",
      ]),
      displayMath(String.raw`\overline\kappa_E
\left(
  \mathtt{fine},
  \mathsf{EdgeRole},
  C_E
\right)
=
\left(
  \mathtt{coarse},
  \mathsf{EdgeRole},
  D_E
\right)`),
      paragraph([
        "を満たすなら、細段の始点と終点を誘導頂点写像で送った結果は、対応する粗段辺の始点と終点にそれぞれ一致する。すなわち、",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_V
\left(
  \mathtt{fine},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{fine}}(C_E)H_V^{\mathrm{fine}}
\right)
&=
\left(
  \mathtt{coarse},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{coarse}}(D_E)H_V^{\mathrm{coarse}}
\right),\\
\overline\kappa_V
\left(
  \mathtt{fine},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{fine}}(C_E)r_E^{\mathrm{fine}}H_V^{\mathrm{fine}}
\right)
&=
\left(
  \mathtt{coarse},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{coarse}}(D_E)r_E^{\mathrm{coarse}}H_V^{\mathrm{coarse}}
\right).
\end{aligned}`),
    ],
    proof: [
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導頂点写像の定義より、始点側は",
      ]),
      displayMath(String.raw`\overline\kappa_V
\left(
  \mathtt{fine},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{fine}}(C_E)H_V^{\mathrm{fine}}
\right)
=
\left(
  \mathtt{coarse},
  \mathsf{VertexRole},
  \kappa\left(\eta_E^{\mathrm{fine}}(C_E)\right)H_V^{\mathrm{coarse}}
\right).`),
      paragraph([
        ref("def_quotient_tower_oriented_edge_representative_selector_compatibility"),
        " の代表元選択の可換条件より、",
      ]),
      displayMath(String.raw`\kappa\left(\eta_E^{\mathrm{fine}}(C_E)\right)
=
\eta_E^{\mathrm{coarse}}(D_E).`),
      paragraph(["この等式を始点側の右辺へ代入すると、"]),
      displayMath(String.raw`\overline\kappa_V
\left(
  \mathtt{fine},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{fine}}(C_E)H_V^{\mathrm{fine}}
\right)
=
\left(
  \mathtt{coarse},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{coarse}}(D_E)H_V^{\mathrm{coarse}}
\right).`),
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導頂点写像の定義より、終点側は",
      ]),
      displayMath(String.raw`\overline\kappa_V
\left(
  \mathtt{fine},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{fine}}(C_E)r_E^{\mathrm{fine}}H_V^{\mathrm{fine}}
\right)
=
\left(
  \mathtt{coarse},
  \mathsf{VertexRole},
  \kappa\left(\eta_E^{\mathrm{fine}}(C_E)r_E^{\mathrm{fine}}\right)H_V^{\mathrm{coarse}}
\right).`),
      paragraph([
        ref("def_two_stage_finite_quotient_tower_input"),
        " の群準同型 ",
        math(String.raw`\kappa`),
        " より、",
      ]),
      displayMath(String.raw`\kappa\left(\eta_E^{\mathrm{fine}}(C_E)r_E^{\mathrm{fine}}\right)
=
\kappa\left(\eta_E^{\mathrm{fine}}(C_E)\right)
\kappa\left(r_E^{\mathrm{fine}}\right).`),
      paragraph([
        ref("def_quotient_tower_oriented_edge_representative_selector_compatibility"),
        " の代表元選択の可換条件より、",
      ]),
      displayMath(String.raw`\kappa\left(\eta_E^{\mathrm{fine}}(C_E)\right)
\kappa\left(r_E^{\mathrm{fine}}\right)
=
\eta_E^{\mathrm{coarse}}(D_E)
\kappa\left(r_E^{\mathrm{fine}}\right).`),
      paragraph([
        ref("def_quotient_tower_role_generator_compatibility"),
        " の辺役割生成元の整合性より、",
      ]),
      displayMath(String.raw`\eta_E^{\mathrm{coarse}}(D_E)
\kappa\left(r_E^{\mathrm{fine}}\right)
=
\eta_E^{\mathrm{coarse}}(D_E)r_E^{\mathrm{coarse}}.`),
      paragraph(["以上の三等式を終点側の右辺へ順に代入すると、"]),
      displayMath(String.raw`\overline\kappa_V
\left(
  \mathtt{fine},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{fine}}(C_E)r_E^{\mathrm{fine}}H_V^{\mathrm{fine}}
\right)
=
\left(
  \mathtt{coarse},
  \mathsf{VertexRole},
  \eta_E^{\mathrm{coarse}}(D_E)r_E^{\mathrm{coarse}}H_V^{\mathrm{coarse}}
\right).`),
      paragraph([
        "したがって始点と終点はそれぞれ保存される。全ての群、部分群、剰余類、写像、量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_stage_face_cyclic_position_systems",
    kind: "definition",
    title: { text: "商の各段における面の巡回位置系" },
    labels: ["def_quotient_tower_stage_face_cyclic_position_systems"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_quotient_tower_induced_coset_cell_maps"), " の各段 ", math(String.raw`T\in\{\mathrm{fine},\mathrm{coarse}\}`), " と三重タグ付き面 ", math(String.raw`f=(\mathtt T,\mathsf{FaceRole},C_F)\in\mathcal C_F^T`), " に対し、位置集合と次位置写像を"]),
      displayMath(String.raw`P_f^{Q_T}:=\{\mathtt{position}\}\times C_F,\qquad
s_f^{Q_T}:P_f^{Q_T}\to P_f^{Q_T},\quad s_f^{Q_T}(\mathtt{position},a):=(\mathtt{position},ar_F^T)`),
      paragraph(["で定める。", math(String.raw`C_F`), " は ", math(String.raw`H_F^T=\langle r_F^T\rangle`), " の左剰余類なので、", math(String.raw`s_f^{Q_T}`), " は一つの巡回列をなす全単射である。"])],
  },
  {
    id: "quotient_tower_definition_induced_face_position_map",
    kind: "definition",
    title: { text: "商の塔が誘導する剰余類面の巡回位置写像" },
    labels: ["def_quotient_tower_induced_face_position_map"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-face-position-map"],
    statement: [
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の面セル写像と、",
        ref("def_quotient_tower_stage_face_cyclic_position_systems"),
        " の段別巡回位置系を取る。細段面剰余類 ",
        math(String.raw`C_F\in Q_{\mathrm{fine}}/H_F^{\mathrm{fine}}`),
        " と粗段面剰余類 ",
        math(String.raw`D_F\in Q_{\mathrm{coarse}}/H_F^{\mathrm{coarse}}`),
        " が",
      ]),
      displayMath(String.raw`\overline\kappa_F
\left(
  \mathtt{fine},
  \mathsf{FaceRole},
  C_F
\right)
=
\left(
  \mathtt{coarse},
  \mathsf{FaceRole},
  D_F
\right)`),
      paragraph([
        "を満たすとする。対応する細段面と粗段面をそれぞれ ",
        math(String.raw`f_{\mathrm{fine}}`),
        "、",
        math(String.raw`f_{\mathrm{coarse}}`),
        " と書く。段間の剰余類面位置写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{P,C_F}:
P_{f_{\mathrm{fine}}}^{Q_{\mathrm{fine}}}
&\longrightarrow
P_{f_{\mathrm{coarse}}}^{Q_{\mathrm{coarse}}},\\
\overline\kappa_{P,C_F}
\left(
  \mathtt{position},
  a
\right)
&:=
\left(
  \mathtt{position},
  \kappa(a)
\right)
\qquad(a\in C_F)
\end{aligned}`),
      paragraph([
        "で定める。この作用は粗段面の位置集合に入る。実際、",
        math(String.raw`C_F=gH_F^{\mathrm{fine}}`),
        " と ",
        math(String.raw`a=gh`),
        " を満たす ",
        math(String.raw`g\in Q_{\mathrm{fine}}`),
        "、",
        math(String.raw`h\in H_F^{\mathrm{fine}}`),
        " を取ると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa(a)
&=
\kappa(gh)
&&\bigl(\because\ a=gh\bigr)\\
&=
\kappa(g)\kappa(h)
&&\bigl(\because\ \kappa\text{ は群準同型}\bigr)\\
&\in
\kappa(g)H_F^{\mathrm{coarse}}
&&\bigl(\because\ \kappa(h)\in
  \kappa(H_F^{\mathrm{fine}})=H_F^{\mathrm{coarse}}\bigr)\\
&=
D_F
&&\bigl(\because\ \overline\kappa_F(C_F)=D_F\bigr).
\end{aligned}`),
      paragraph([
        "さらに、この位置写像は細段と粗段の次位置写像と可換する。各 ",
        math(String.raw`a\in C_F`),
        " に対して、",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{P,C_F}
\left(
  s_{f_{\mathrm{fine}}}^{Q_{\mathrm{fine}}}
  \left(
    \mathtt{position},
    a
  \right)
\right)
&=
\overline\kappa_{P,C_F}
\left(
  \mathtt{position},
  ar_F^{\mathrm{fine}}
\right)
&&\bigl(\because\ \text{細段の次位置写像の定義}\bigr)\\
&=
\left(
  \mathtt{position},
  \kappa\left(ar_F^{\mathrm{fine}}\right)
\right)
&&\bigl(\because\ \overline\kappa_{P,C_F}\text{ の定義}\bigr)\\
&=
\left(
  \mathtt{position},
  \kappa(a)\kappa\left(r_F^{\mathrm{fine}}\right)
\right)
&&\bigl(\because\ \kappa\text{ は群準同型}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_quotient_tower_role_generator_compatibility"),
        " の面役割生成元の整合性より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(
  \mathtt{position},
  \kappa(a)\kappa\left(r_F^{\mathrm{fine}}\right)
\right)
&=
\left(
  \mathtt{position},
  \kappa(a)r_F^{\mathrm{coarse}}
\right)
&&\bigl(\because\ \text{面役割生成元の整合性}\bigr)\\
&=
s_{f_{\mathrm{coarse}}}^{Q_{\mathrm{coarse}}}
\left(
  \mathtt{position},
  \kappa(a)
\right)
&&\bigl(\because\ \text{粗段の次位置写像の定義}\bigr)\\
&=
s_{f_{\mathrm{coarse}}}^{Q_{\mathrm{coarse}}}
\left(
  \overline\kappa_{P,C_F}
  \left(
    \mathtt{position},
    a
  \right)
\right)
&&\bigl(\because\ \overline\kappa_{P,C_F}\text{ の定義}\bigr).
\end{aligned}`),
      paragraph([
        "位置写像は有限集合間の写像であり、粗段で複数の細段位置が同じ位置へ移ることを許す。この定義から向き付き面境界語、局所全単射性、被覆次数の保存は結論しない。全ての群、部分群、剰余類、位置集合、写像、量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_stage_oriented_face_boundary_words",
    kind: "definition",
    title: { text: "商の各段における向き付き面境界語" },
    labels: ["def_quotient_tower_stage_oriented_face_boundary_words"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_quotient_tower_stage_oriented_edge_endpoint_maps"), " の端点写像と ", ref("def_quotient_tower_stage_face_cyclic_position_systems"), " の巡回位置系を取る。各 ", math(String.raw`T\in\{\mathrm{fine},\mathrm{coarse}\}`), "、面 ", math(String.raw`f=(\mathtt T,\mathsf{FaceRole},C_F)\in\mathcal C_F^T`), " に対し段別境界語を写像 ", math(String.raw`\partial_{\mathrm{word}}^T f:P_f^{Q_T}\to\mathcal C_E^T\times\mathsf{Ori}`), " であって"]),
      displayMath(String.raw`\partial_{\mathrm{word}}^T f(\mathtt{position},a):=
\begin{cases}
((\mathtt T,\mathsf{EdgeRole},aH_E^T),\mathsf{forward}),&\eta_E^T(aH_E^T)=a,\\
((\mathtt T,\mathsf{EdgeRole},aH_E^T),\mathsf{reverse}),&\eta_E^T(aH_E^T)=ar_E^T
\end{cases}`),
      paragraph([ref("def_quotient_tower_role_generator_compatibility"), " の位数二条件により二場合のちょうど一方が成立し、三角関係により次位置との端点が接続する。"])],
  },
  {
    id: "quotient_tower_definition_stage_oriented_cellulation_data",
    kind: "definition",
    title: { text: "商の各段における向き付きセル分割データ" },
    labels: ["def_quotient_tower_stage_oriented_cellulation_data"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_quotient_tower_stage_oriented_edge_endpoint_maps"), " の端点写像、", ref("def_quotient_tower_stage_face_cyclic_position_systems"), " の巡回位置系、", ref("def_quotient_tower_stage_oriented_face_boundary_words"), " の境界語、および ", ref("def_quotient_tower_stage_coset_cell_incidence_relations"), " の incidence を一つの型付き構造にまとめる。各 ", math(String.raw`T\in\{\mathrm{fine},\mathrm{coarse}\}`), " に対し"]),
      displayMath(String.raw`\mathcal C^T:=\left(
(\mathcal C_V^T,\mathcal C_E^T,\partial_G^T),
(\mathcal C_V^T,\mathcal C_E^T,\mathcal C_F^T),
\left(P_f^{Q_T},s_f^{Q_T},\partial_{\mathrm{word}}^T f\right)_{f\in\mathcal C_F^T},
\mathcal I_{Q_T}
\right)`),
      paragraph(["と定める。これにより後続の境界行列、サイクル空間、面境界空間で使う ", math(String.raw`\mathcal C^{\mathrm{fine}},\mathcal C^{\mathrm{coarse}}`), " の全成分と型が確定する。この定義は閉曲面性を主張しない。"])],
  },
  {
    id: "quotient_tower_theorem_oriented_face_boundary_word_preservation",
    kind: "theorem",
    title: { text: "商の塔における剰余類面の向き付き境界語の保存" },
    labels: ["theorem_quotient_tower_oriented_face_boundary_word_preservation"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-oriented-face-boundary-word-preservation"],
    statement: [
      paragraph([
        ref("def_quotient_tower_stage_oriented_cellulation_data"),
        " の段別境界語と ",
        ref("def_quotient_tower_induced_face_position_map"),
        " の面位置写像、",
        ref("def_quotient_tower_oriented_edge_representative_selector_compatibility"),
        " の整合する辺代表元選択写像、および ",
        ref("def_finite_quotient_oriented_coset_face_boundary_word"),
        " の二段の向き付き面境界語を取る。細段面剰余類 ",
        math(String.raw`C_F\in Q_{\mathrm{fine}}/H_F^{\mathrm{fine}}`),
        " の像を粗段面剰余類 ",
        math(String.raw`D_F\in Q_{\mathrm{coarse}}/H_F^{\mathrm{coarse}}`),
        " とし、対応する面を ",
        math(String.raw`f_{\mathrm{fine}}`),
        "、",
        math(String.raw`f_{\mathrm{coarse}}`),
        " と書く。辺セル成分へ ",
        math(String.raw`\overline\kappa_E`),
        " を作用させ、形式的向きラベルを変えない積写像を ",
        math(String.raw`\overline\kappa_E\times\operatorname{id}_{\mathsf{Ori}}`),
        " と書く。このとき、全ての細段面位置 ",
        math(String.raw`(\mathtt{position},a)\in P_{f_{\mathrm{fine}}}^{Q_{\mathrm{fine}}}`),
        " に対して、",
      ]),
      displayMath(String.raw`\left(
  \overline\kappa_E
  \times
  \operatorname{id}_{\mathsf{Ori}}
\right)
\left(
  \partial_{\mathrm{word}}^{\mathrm{fine}}
  f_{\mathrm{fine}}
  \left(
    \mathtt{position},
    a
  \right)
\right)
=
\partial_{\mathrm{word}}^{\mathrm{coarse}}
f_{\mathrm{coarse}}
\left(
  \overline\kappa_{P,C_F}
  \left(
    \mathtt{position},
    a
  \right)
\right).`),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`a\in C_F`),
        " を固定し、細段と粗段でこの位置に置かれる辺剰余類をそれぞれ",
      ]),
      displayMath(String.raw`C_E(a):=aH_E^{\mathrm{fine}},
\qquad
D_E\left(\kappa(a)\right):=
\kappa(a)H_E^{\mathrm{coarse}}`),
      paragraph([
        "と書く。",
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導辺セル写像の定義より、",
      ]),
      displayMath(String.raw`\overline\kappa_E
\left(
  \mathtt{fine},
  \mathsf{EdgeRole},
  C_E(a)
\right)
=
\left(
  \mathtt{coarse},
  \mathsf{EdgeRole},
  D_E\left(\kappa(a)\right)
\right).`),
      paragraph([
        ref("def_finite_quotient_oriented_coset_face_boundary_word"),
        " の細段境界語の定義により、代表元選択には次の二場合のちょうど一方が成り立つ。まず ",
        math(String.raw`\eta_E^{\mathrm{fine}}(C_E(a))=a`),
        " の場合を取る。",
      ]),
      paragraph([
        ref("def_quotient_tower_oriented_edge_representative_selector_compatibility"),
        " の代表元選択の可換条件より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\eta_E^{\mathrm{coarse}}
\left(
  D_E\left(\kappa(a)\right)
\right)
&=
\kappa\left(
  \eta_E^{\mathrm{fine}}(C_E(a))
\right)
&&\bigl(\because\ \text{代表元選択の可換条件}\bigr)\\
&=
\kappa(a)
&&\bigl(\because\ \eta_E^{\mathrm{fine}}(C_E(a))=a\bigr).
\end{aligned}`),
      paragraph([
        ref("def_finite_quotient_oriented_coset_face_boundary_word"),
        " の二段の境界語の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\partial_{\mathrm{word}}^{\mathrm{fine}}
f_{\mathrm{fine}}
\left(
  \mathtt{position},
  a
\right)
&=
\left(
  (\mathtt{fine},\mathsf{EdgeRole},C_E(a)),
  \mathsf{forward}
\right)
&&\bigl(\because\ \text{細段境界語の定義}\bigr),\\
\partial_{\mathrm{word}}^{\mathrm{coarse}}
f_{\mathrm{coarse}}
\left(
  \mathtt{position},
  \kappa(a)
\right)
&=
\left(
  (\mathtt{coarse},\mathsf{EdgeRole},D_E(\kappa(a))),
  \mathsf{forward}
\right)
&&\bigl(\because\ \text{粗段境界語の定義}\bigr).
\end{aligned}`),
      paragraph([
        "誘導辺セル写像の等式と、形式的向きラベル ",
        math(String.raw`\mathsf{forward}`),
        " の一致より、主張の等式が成り立つ。次に ",
        math(String.raw`\eta_E^{\mathrm{fine}}(C_E(a))=ar_E^{\mathrm{fine}}`),
        " の場合を取る。",
      ]),
      paragraph([
        ref("def_quotient_tower_oriented_edge_representative_selector_compatibility"),
        " の代表元選択の可換条件、",
        ref("def_two_stage_finite_quotient_tower_input"),
        " の群準同型性、および ",
        ref("def_quotient_tower_role_generator_compatibility"),
        " の辺役割生成元の整合性より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\eta_E^{\mathrm{coarse}}
\left(
  D_E\left(\kappa(a)\right)
\right)
&=
\kappa\left(
  \eta_E^{\mathrm{fine}}(C_E(a))
\right)
&&\bigl(\because\ \text{代表元選択の可換条件}\bigr)\\
&=
\kappa\left(ar_E^{\mathrm{fine}}\right)
&&\bigl(\because\ \eta_E^{\mathrm{fine}}(C_E(a))=ar_E^{\mathrm{fine}}\bigr)\\
&=
\kappa(a)\kappa\left(r_E^{\mathrm{fine}}\right)
&&\bigl(\because\ \kappa\text{ は群準同型}\bigr)\\
&=
\kappa(a)r_E^{\mathrm{coarse}}
&&\bigl(\because\ \text{辺役割生成元の整合性}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_finite_quotient_oriented_coset_face_boundary_word"),
        " の二段の境界語の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\partial_{\mathrm{word}}^{\mathrm{fine}}
f_{\mathrm{fine}}
\left(
  \mathtt{position},
  a
\right)
&=
\left(
  (\mathtt{fine},\mathsf{EdgeRole},C_E(a)),
  \mathsf{reverse}
\right)
&&\bigl(\because\ \text{細段境界語の定義}\bigr),\\
\partial_{\mathrm{word}}^{\mathrm{coarse}}
f_{\mathrm{coarse}}
\left(
  \mathtt{position},
  \kappa(a)
\right)
&=
\left(
  (\mathtt{coarse},\mathsf{EdgeRole},D_E(\kappa(a))),
  \mathsf{reverse}
\right)
&&\bigl(\because\ \text{粗段境界語の定義}\bigr).
\end{aligned}`),
      paragraph([
        "誘導辺セル写像の等式と、形式的向きラベル ",
        math(String.raw`\mathsf{reverse}`),
        " の一致より、この場合にも主張の等式が成り立つ。最後に ",
        ref("def_quotient_tower_induced_face_position_map"),
        " の位置写像の定義より、",
      ]),
      displayMath(String.raw`\overline\kappa_{P,C_F}
\left(
  \mathtt{position},
  a
\right)
=
\left(
  \mathtt{position},
  \kappa(a)
\right).`),
      paragraph([
        "したがって二場合のいずれでも向き付き面境界語は保存される。全ての群、部分群、剰余類、位置集合、辺セル、向きラベル、写像、量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_edge_coefficient_pushforward_over_f2",
    kind: "definition",
    title: { text: "商の塔が誘導する F_2 辺係数押し出し写像" },
    labels: ["def_quotient_tower_edge_coefficient_pushforward_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-edge-coefficient-pushforward-over-f2"],
    statement: [
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の全射な誘導辺セル写像 ",
        math(String.raw`\overline\kappa_E:\mathcal C_E^{\mathrm{fine}}\to\mathcal C_E^{\mathrm{coarse}}`),
        " を取る。",
        ref("def_first_boundary_matrix_over_f2"),
        " と同様に、有限辺セル集合 ",
        math(String.raw`S`),
        " に対する ",
        math(String.raw`\mathbb F_2^S`),
        " は写像 ",
        math(String.raw`S\to\mathbb F_2`),
        " の有限ベクトル空間を表す。細段辺係数写像を粗段辺係数写像へ送る押し出し写像を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{E,!}:
\mathbb F_2^{\mathcal C_E^{\mathrm{fine}}}
&\longrightarrow
\mathbb F_2^{\mathcal C_E^{\mathrm{coarse}}},\\
c
&\longmapsto
\overline\kappa_{E,!}(c),\\
\overline\kappa_{E,!}(c)(D_E)
&:=
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
c(C_E)
\qquad
\left(D_E\in\mathcal C_E^{\mathrm{coarse}}\right)
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`c:\mathcal C_E^{\mathrm{fine}}\to\mathbb F_2`),
        " は細段辺セルごとの係数写像であり、",
        math(String.raw`\overline\kappa_{E,!}(c):\mathcal C_E^{\mathrm{coarse}}\to\mathbb F_2`),
        " は粗段辺セルごとの係数写像である。各成分の和は、粗段辺セル ",
        math(String.raw`D_E`),
        " の有限ファイバー ",
        math(String.raw`\overline\kappa_E^{-1}(D_E)`),
        " に属する細段辺セルの係数を ",
        math(String.raw`\mathbb F_2`),
        " で加えた値である。したがって複数の細段辺セルが同じ粗段辺セルへ移る場合、それらを同一視せず、係数だけを有限和でまとめる。この定義は辺係数空間間の写像だけを定め、一次サイクル空間への制限、第一ホモロジーへの作用、局所全単射性、被覆次数は主張しない。全ての辺セル集合、ファイバー、係数写像、和は有限または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_vertex_coefficient_pushforward_over_f2",
    kind: "definition",
    title: { text: "商の塔が誘導する F_2 頂点係数押し出し写像" },
    labels: ["def_quotient_tower_vertex_coefficient_pushforward_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-vertex-coefficient-pushforward-over-f2"],
    statement: [
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の全射な誘導頂点セル写像 ",
        math(String.raw`\overline\kappa_V:\mathcal C_V^{\mathrm{fine}}\to\mathcal C_V^{\mathrm{coarse}}`),
        " を取る。",
        ref("def_first_boundary_matrix_over_f2"),
        " と同様に、有限頂点セル集合 ",
        math(String.raw`S`),
        " に対する ",
        math(String.raw`\mathbb F_2^S`),
        " は写像 ",
        math(String.raw`S\to\mathbb F_2`),
        " の有限ベクトル空間を表す。細段頂点係数写像を粗段頂点係数写像へ送る押し出し写像を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{V,!}:
\mathbb F_2^{\mathcal C_V^{\mathrm{fine}}}
&\longrightarrow
\mathbb F_2^{\mathcal C_V^{\mathrm{coarse}}},\\
b
&\longmapsto
\overline\kappa_{V,!}(b),\\
\overline\kappa_{V,!}(b)(D_V)
&:=
\sum_{\substack{
  C_V\in\mathcal C_V^{\mathrm{fine}}\\
  \overline\kappa_V(C_V)=D_V
}}
b(C_V)
\qquad
\left(D_V\in\mathcal C_V^{\mathrm{coarse}}\right)
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`b:\mathcal C_V^{\mathrm{fine}}\to\mathbb F_2`),
        " は細段頂点セルごとの係数写像であり、",
        math(String.raw`\overline\kappa_{V,!}(b):\mathcal C_V^{\mathrm{coarse}}\to\mathbb F_2`),
        " は粗段頂点セルごとの係数写像である。各成分の和は、粗段頂点セル ",
        math(String.raw`D_V`),
        " の有限ファイバー ",
        math(String.raw`\overline\kappa_V^{-1}(D_V)`),
        " に属する細段頂点セルの係数を ",
        math(String.raw`\mathbb F_2`),
        " で加えた値である。したがって複数の細段頂点セルが同じ粗段頂点セルへ移る場合、それらを同一視せず、係数だけを有限和でまとめる。この定義は頂点係数空間間の写像だけを定め、一次境界写像との可換性、一次サイクル空間への作用、局所全単射性、被覆次数は主張しない。全ての頂点セル集合、ファイバー、係数写像、和は有限または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_first_boundary_pushforward_commutativity_over_f2",
    kind: "theorem",
    title: { text: "商の塔における F_2 一次境界写像と押し出しの可換性" },
    labels: ["theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-first-boundary-pushforward-commutativity-over-f2"],
    statement: [
      paragraph([
        ref("def_quotient_tower_stage_oriented_cellulation_data"),
        " の細段と粗段の有限頂点セル集合をそれぞれ ",
        math(String.raw`\mathcal C_V^{\mathrm{fine}}`),
        " と ",
        math(String.raw`\mathcal C_V^{\mathrm{coarse}}`),
        "、有限辺セル集合をそれぞれ ",
        math(String.raw`\mathcal C_E^{\mathrm{fine}}`),
        " と ",
        math(String.raw`\mathcal C_E^{\mathrm{coarse}}`),
        " とする。同じ段別セル分割データの辺端写像は",
      ]),
      displayMath(String.raw`\partial_G^{\mathrm{fine}}:
\mathcal C_E^{\mathrm{fine}}\times\mathsf{End}
\longrightarrow
\mathcal C_V^{\mathrm{fine}},
\qquad
\partial_G^{\mathrm{coarse}}:
\mathcal C_E^{\mathrm{coarse}}\times\mathsf{End}
\longrightarrow
\mathcal C_V^{\mathrm{coarse}}`),
      paragraph([
        "であり、これらから ",
        ref("def_first_boundary_matrix_over_f2"),
        " により定まる ",
        math(String.raw`\mathbb F_2`),
        " 上の一次境界写像を ",
        math(String.raw`\partial_1^{\mathrm{fine}}`),
        " と ",
        math(String.raw`\partial_1^{\mathrm{coarse}}`),
        " と書く。",
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導セル写像を ",
        math(String.raw`\overline\kappa_E`),
        "、",
        math(String.raw`\overline\kappa_V`),
        " とする。",
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " と ",
        ref("def_quotient_tower_vertex_coefficient_pushforward_over_f2"),
        " の押し出し写像に対し、次の二つの合成は等しい。",
      ]),
      displayMath(String.raw`\partial_1^{\mathrm{coarse}}
\circ
\overline\kappa_{E,!}
=
\overline\kappa_{V,!}
\circ
\partial_1^{\mathrm{fine}}
:
\mathbb F_2^{\mathcal C_E^{\mathrm{fine}}}
\longrightarrow
\mathbb F_2^{\mathcal C_V^{\mathrm{coarse}}}.`),
    ],
    proof: [
      paragraph([
        "任意の細段辺係数写像 ",
        math(String.raw`c\in\mathbb F_2^{\mathcal C_E^{\mathrm{fine}}}`),
        " と粗段頂点セル ",
        math(String.raw`D_V\in\mathcal C_V^{\mathrm{coarse}}`),
        " を固定する。",
        ref("def_first_boundary_matrix_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(
  \partial_1^{\mathrm{coarse}}
  \left(
    \overline\kappa_{E,!}(c)
  \right)
\right)(D_V)
&=
\sum_{D_E\in\mathcal C_E^{\mathrm{coarse}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G^{\mathrm{coarse}}(D_E,a)=D_V
  }}
  1_{\mathbb F_2}
\right)
\left(
  \overline\kappa_{E,!}(c)
\right)(D_E).
\end{aligned}`),
      paragraph([
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
&\sum_{D_E\in\mathcal C_E^{\mathrm{coarse}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G^{\mathrm{coarse}}(D_E,a)=D_V
  }}
  1_{\mathbb F_2}
\right)
\left(
  \overline\kappa_{E,!}(c)
\right)(D_E)\\
&=
\sum_{D_E\in\mathcal C_E^{\mathrm{coarse}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G^{\mathrm{coarse}}(D_E,a)=D_V
  }}
  1_{\mathbb F_2}
\right)
\left(
  \sum_{\substack{
    C_E\in\mathcal C_E^{\mathrm{fine}}\\
    \overline\kappa_E(C_E)=D_E
  }}
  c(C_E)
\right).
\end{aligned}`),
      paragraph(["有限和を誘導辺セル写像のファイバーごとにまとめ直すと、"]),
      displayMath(String.raw`\begin{aligned}
&\sum_{D_E\in\mathcal C_E^{\mathrm{coarse}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G^{\mathrm{coarse}}(D_E,a)=D_V
  }}
  1_{\mathbb F_2}
\right)
\left(
  \sum_{\substack{
    C_E\in\mathcal C_E^{\mathrm{fine}}\\
    \overline\kappa_E(C_E)=D_E
  }}
  c(C_E)
\right)\\
&=
\sum_{C_E\in\mathcal C_E^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G^{\mathrm{coarse}}
    \left(
      \overline\kappa_E(C_E),a
    \right)
    =D_V
  }}
  1_{\mathbb F_2}
\right)c(C_E)
\qquad
\bigl(\because\ \text{有限和の添字付け替え}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_quotient_tower_oriented_edge_endpoint_map_preservation"),
        " を二つの辺端ラベルに適用すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
&\sum_{C_E\in\mathcal C_E^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G^{\mathrm{coarse}}
    \left(
      \overline\kappa_E(C_E),a
    \right)
    =D_V
  }}
  1_{\mathbb F_2}
\right)c(C_E)\\
&=
\sum_{C_E\in\mathcal C_E^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \overline\kappa_V
    \left(
      \partial_G^{\mathrm{fine}}(C_E,a)
    \right)
    =D_V
  }}
  1_{\mathbb F_2}
\right)c(C_E)
\qquad
\bigl(\because\ \text{二つの辺端の保存}\bigr).
\end{aligned}`),
      paragraph(["辺端を、その細段頂点セルによる有限分割へ書き換えると、"]),
      displayMath(String.raw`\begin{aligned}
&\sum_{C_E\in\mathcal C_E^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \overline\kappa_V
    \left(
      \partial_G^{\mathrm{fine}}(C_E,a)
    \right)
    =D_V
  }}
  1_{\mathbb F_2}
\right)c(C_E)\\
&=
\sum_{\substack{
  C_V\in\mathcal C_V^{\mathrm{fine}}\\
  \overline\kappa_V(C_V)=D_V
}}
\sum_{C_E\in\mathcal C_E^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G^{\mathrm{fine}}(C_E,a)=C_V
  }}
  1_{\mathbb F_2}
\right)c(C_E)
\qquad
\bigl(\because\ \text{有限集合のファイバー分割と有限和の交換}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_first_boundary_matrix_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
&\sum_{\substack{
  C_V\in\mathcal C_V^{\mathrm{fine}}\\
  \overline\kappa_V(C_V)=D_V
}}
\sum_{C_E\in\mathcal C_E^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    a\in\mathsf{End}\\
    \partial_G^{\mathrm{fine}}(C_E,a)=C_V
  }}
  1_{\mathbb F_2}
\right)c(C_E)\\
&=
\sum_{\substack{
  C_V\in\mathcal C_V^{\mathrm{fine}}\\
  \overline\kappa_V(C_V)=D_V
}}
\left(
  \partial_1^{\mathrm{fine}}(c)
\right)(C_V).
\end{aligned}`),
      paragraph([
        ref("def_quotient_tower_vertex_coefficient_pushforward_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
&\sum_{\substack{
  C_V\in\mathcal C_V^{\mathrm{fine}}\\
  \overline\kappa_V(C_V)=D_V
}}
\left(
  \partial_1^{\mathrm{fine}}(c)
\right)(C_V)\\
&=
\left(
  \overline\kappa_{V,!}
  \left(
    \partial_1^{\mathrm{fine}}(c)
  \right)
\right)(D_V).
\end{aligned}`),
      paragraph([
        "任意の ",
        math(String.raw`c\in\mathbb F_2^{\mathcal C_E^{\mathrm{fine}}}`),
        " と ",
        math(String.raw`D_V\in\mathcal C_V^{\mathrm{coarse}}`),
        " で両成分が一致したので、二つの合成写像は等しい。全てのセル集合、辺端ラベル集合、ファイバー、係数写像、和は有限または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_first_cycle_pushforward_over_f2",
    kind: "theorem",
    title: { text: "商の塔における一次サイクルの押し出し" },
    labels: ["theorem_quotient_tower_first_cycle_pushforward_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-first-cycle-pushforward-over-f2"],
    statement: [
      paragraph([
        "細段と粗段の有限セルデータへ ",
        ref("def_first_cycle_space_over_f2"),
        " をそれぞれ適用する。任意の細段辺係数写像 ",
        math(String.raw`c\in\mathbb F_2^{\mathcal C_E^{\mathrm{fine}}}`),
        " と ",
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " の辺係数押し出しに対し、次の含意が成り立つ。すなわち、細段一次サイクルは粗段一次サイクルへ送られる。",
      ]),
      displayMath(String.raw`c\in\ker
\left(
  \partial_1^{\mathrm{fine}}
\right)
\quad\Longrightarrow\quad
\overline\kappa_{E,!}(c)
\in\ker
\left(
  \partial_1^{\mathrm{coarse}}
\right).`),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`c\in\ker\left(\partial_1^{\mathrm{fine}}\right)`),
        " を固定する。",
        ref("theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2"),
        " より、",
      ]),
      displayMath(String.raw`\partial_1^{\mathrm{coarse}}
\left(
  \overline\kappa_{E,!}(c)
\right)
=
\overline\kappa_{V,!}
\left(
  \partial_1^{\mathrm{fine}}(c)
\right).`),
      paragraph([
        ref("def_first_cycle_space_over_f2"),
        " と ",
        math(String.raw`c\in\ker\left(\partial_1^{\mathrm{fine}}\right)`),
        " より、",
      ]),
      displayMath(String.raw`\overline\kappa_{V,!}
\left(
  \partial_1^{\mathrm{fine}}(c)
\right)
=
\overline\kappa_{V,!}
\left(
  0_{\mathbb F_2^{\mathcal C_V^{\mathrm{fine}}}}
\right).`),
      paragraph([
        "任意の粗段頂点セル ",
        math(String.raw`D_V\in\mathcal C_V^{\mathrm{coarse}}`),
        " に対し、",
        ref("def_quotient_tower_vertex_coefficient_pushforward_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(
  \overline\kappa_{V,!}
  \left(
    0_{\mathbb F_2^{\mathcal C_V^{\mathrm{fine}}}}
  \right)
\right)(D_V)
&=
\sum_{\substack{
  C_V\in\mathcal C_V^{\mathrm{fine}}\\
  \overline\kappa_V(C_V)=D_V
}}
0_{\mathbb F_2}
&&\bigl(\because\ \text{頂点係数押し出し写像の定義}\bigr)\\
&=0_{\mathbb F_2}
&&\bigl(\because\ \text{有限個の零元の和}\bigr).
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`\overline\kappa_{V,!}\left(0_{\mathbb F_2^{\mathcal C_V^{\mathrm{fine}}}}\right)`),
        " は粗段頂点係数空間の零元である。以上の等式と ",
        ref("def_first_cycle_space_over_f2"),
        " より、",
      ]),
      displayMath(String.raw`\overline\kappa_{E,!}(c)
\in
\ker
\left(
  \partial_1^{\mathrm{coarse}}
\right)
=
\operatorname{Cycle}_1
\left(
  \mathcal C^{\mathrm{coarse}};\mathbb F_2
\right).`),
      paragraph([
        "全てのセル集合、係数写像、核、ファイバー、和は有限または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_first_cycle_pushforward_map_over_f2",
    kind: "definition",
    title: { text: "商の塔が誘導する一次サイクル押し出し写像" },
    labels: ["def_quotient_tower_first_cycle_pushforward_map_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-first-cycle-pushforward-map-over-f2"],
    statement: [
      paragraph([
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " の辺係数押し出し写像を細段一次サイクル空間へ制限する。",
        ref("theorem_quotient_tower_first_cycle_pushforward_over_f2"),
        " により像は粗段一次サイクル空間に属するので、始域、終域、作用を明示した一次サイクル押し出し写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{1,!}:
\operatorname{Cycle}_1
\left(
  \mathcal C^{\mathrm{fine}};\mathbb F_2
\right)
&\longrightarrow
\operatorname{Cycle}_1
\left(
  \mathcal C^{\mathrm{coarse}};\mathbb F_2
\right),\\
c
&\longmapsto
\overline\kappa_{1,!}(c)
:=
\overline\kappa_{E,!}(c)
\end{aligned}`),
      paragraph([
        "で定める。ここで細段一次サイクル空間と粗段一次サイクル空間は、それぞれ有限辺係数空間の中で ",
        ref("def_first_cycle_space_over_f2"),
        " により定まる有限な ",
        math(String.raw`\mathbb F_2`),
        " ベクトル空間である。この定義は一次サイクル空間間の写像だけを定め、第一ホモロジーへの作用、局所全単射性、被覆次数は主張しない。全てのセル集合、係数写像、核、ファイバー、和は有限または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_face_coefficient_pushforward_over_f2",
    kind: "definition",
    title: { text: "商の塔が誘導する F_2 面係数押し出し写像" },
    labels: ["def_quotient_tower_face_coefficient_pushforward_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-face-coefficient-pushforward-over-f2"],
    statement: [
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の全射な誘導面セル写像 ",
        math(String.raw`\overline\kappa_F:\mathcal C_F^{\mathrm{fine}}\to\mathcal C_F^{\mathrm{coarse}}`),
        " を取る。",
        ref("def_second_boundary_matrix_over_f2"),
        " と同様に、有限面セル集合 ",
        math(String.raw`S`),
        " に対する ",
        math(String.raw`\mathbb F_2^S`),
        " は写像 ",
        math(String.raw`S\to\mathbb F_2`),
        " の有限ベクトル空間を表す。細段面係数写像を粗段面係数写像へ送る押し出し写像を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{F,!}:
\mathbb F_2^{\mathcal C_F^{\mathrm{fine}}}
&\longrightarrow
\mathbb F_2^{\mathcal C_F^{\mathrm{coarse}}},\\
a
&\longmapsto
\overline\kappa_{F,!}(a),\\
\overline\kappa_{F,!}(a)(D_F)
&:=
\sum_{\substack{
  C_F\in\mathcal C_F^{\mathrm{fine}}\\
  \overline\kappa_F(C_F)=D_F
}}
a(C_F)
\qquad
\left(D_F\in\mathcal C_F^{\mathrm{coarse}}\right)
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`a:\mathcal C_F^{\mathrm{fine}}\to\mathbb F_2`),
        " は細段面セルごとの係数写像であり、",
        math(String.raw`\overline\kappa_{F,!}(a):\mathcal C_F^{\mathrm{coarse}}\to\mathbb F_2`),
        " は粗段面セルごとの係数写像である。各成分の和は、粗段面セル ",
        math(String.raw`D_F`),
        " の有限ファイバー ",
        math(String.raw`\overline\kappa_F^{-1}(D_F)`),
        " に属する細段面セルの係数を ",
        math(String.raw`\mathbb F_2`),
        " で加えた値である。したがって複数の細段面セルが同じ粗段面セルへ移る場合、それらを同一視せず、係数だけを有限和でまとめる。この定義は面係数空間間の写像だけを定め、二次境界写像との可換性、面境界空間への作用、第一ホモロジーへの作用、局所全単射性、被覆次数は主張しない。全ての面セル集合、ファイバー、係数写像、和は有限または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_second_boundary_pushforward_commutativity_over_f2",
    kind: "theorem",
    title: { text: "商の塔における F_2 二次境界写像と押し出しの可換性" },
    labels: ["theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-second-boundary-pushforward-commutativity-over-f2"],
    statement: [
      paragraph([
        ref("def_quotient_tower_stage_oriented_cellulation_data"),
        " の細段と粗段の有限面セル集合をそれぞれ ",
        math(String.raw`\mathcal C_F^{\mathrm{fine}}`),
        " と ",
        math(String.raw`\mathcal C_F^{\mathrm{coarse}}`),
        "、有限辺セル集合をそれぞれ ",
        math(String.raw`\mathcal C_E^{\mathrm{fine}}`),
        " と ",
        math(String.raw`\mathcal C_E^{\mathrm{coarse}}`),
        " とする。同じ段別セル分割データの向き付き面境界語から ",
        ref("def_second_boundary_matrix_over_f2"),
        " により定まる二次境界写像を ",
        math(String.raw`\partial_2^{\mathrm{fine}}`),
        " と ",
        math(String.raw`\partial_2^{\mathrm{coarse}}`),
        " と書く。",
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導面セル写像と誘導辺セル写像を ",
        math(String.raw`\overline\kappa_F`),
        "、",
        math(String.raw`\overline\kappa_E`),
        " とする。さらに、各細段面 ",
        math(String.raw`f=(\mathtt{fine},\mathsf{FaceRole},C_F)\in\mathcal C_F^{\mathrm{fine}}`),
        " と、その像である粗段面 ",
        math(String.raw`f'=\overline\kappa_F(f)=(\mathtt{coarse},\mathsf{FaceRole},D_F)`),
        " に対し、",
        ref("def_quotient_tower_induced_face_position_map"),
        " の位置写像の各ファイバーの元数が奇数であると仮定する。すなわち、全ての ",
        math(String.raw`j\in P_{f'}^{Q_{\mathrm{coarse}}}`),
        " について",
      ]),
      displayMath(String.raw`\sum_{\substack{
  i\in P_f^{Q_{\mathrm{fine}}}\\
  \overline\kappa_{P,C_F}(i)=j
}}
1_{\mathbb F_2}
=
1_{\mathbb F_2}.`),
      paragraph([
        ref("def_quotient_tower_face_coefficient_pushforward_over_f2"),
        " と ",
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " の押し出し写像に対し、次の二つの合成は等しい。",
      ]),
      displayMath(String.raw`\partial_2^{\mathrm{coarse}}
\circ
\overline\kappa_{F,!}
=
\overline\kappa_{E,!}
\circ
\partial_2^{\mathrm{fine}}
:
\mathbb F_2^{\mathcal C_F^{\mathrm{fine}}}
\longrightarrow
\mathbb F_2^{\mathcal C_E^{\mathrm{coarse}}}.`),
    ],
    proof: [
      paragraph([
        "任意の細段面係数写像 ",
        math(String.raw`a\in\mathbb F_2^{\mathcal C_F^{\mathrm{fine}}}`),
        " と粗段辺セル ",
        math(String.raw`D_E\in\mathcal C_E^{\mathrm{coarse}}`),
        " を固定する。",
        ref("def_second_boundary_matrix_over_f2"),
        " と ",
        ref("def_quotient_tower_face_coefficient_pushforward_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(
  \partial_2^{\mathrm{coarse}}
  \left(
    \overline\kappa_{F,!}(a)
  \right)
\right)(D_E)
&=
\sum_{f_{\mathrm{coarse}}\in\mathcal C_F^{\mathrm{coarse}}}
\left(
  \sum_{\substack{
    j\in P_{f_{\mathrm{coarse}}}^{Q_{\mathrm{coarse}}}\\
    e_{f_{\mathrm{coarse}},j}=D_E
  }}
  1_{\mathbb F_2}
\right)
\left(
  \sum_{\substack{
    f_{\mathrm{fine}}\in\mathcal C_F^{\mathrm{fine}}\\
    \overline\kappa_F(f_{\mathrm{fine}})=f_{\mathrm{coarse}}
  }}
  a(f_{\mathrm{fine}})
\right).
\end{aligned}`),
      paragraph(["有限和を誘導面セル写像のファイバーごとにまとめ直すと、"]),
      displayMath(String.raw`\begin{aligned}
&\sum_{f_{\mathrm{coarse}}\in\mathcal C_F^{\mathrm{coarse}}}
\left(
  \sum_{\substack{
    j\in P_{f_{\mathrm{coarse}}}^{Q_{\mathrm{coarse}}}\\
    e_{f_{\mathrm{coarse}},j}=D_E
  }}
  1_{\mathbb F_2}
\right)
\left(
  \sum_{\substack{
    f_{\mathrm{fine}}\in\mathcal C_F^{\mathrm{fine}}\\
    \overline\kappa_F(f_{\mathrm{fine}})=f_{\mathrm{coarse}}
  }}
  a(f_{\mathrm{fine}})
\right)\\
&=
\sum_{f_{\mathrm{fine}}\in\mathcal C_F^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    j\in P_{\overline\kappa_F(f_{\mathrm{fine}})}^{Q_{\mathrm{coarse}}}\\
    e_{\overline\kappa_F(f_{\mathrm{fine}}),j}=D_E
  }}
  1_{\mathbb F_2}
\right)a(f_{\mathrm{fine}})
\qquad
\bigl(\because\ \text{有限和の添字付け替え}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_quotient_tower_oriented_face_boundary_word_preservation"),
        " と位置写像の奇数ファイバー条件より、",
      ]),
      displayMath(String.raw`\begin{aligned}
&\sum_{f_{\mathrm{fine}}\in\mathcal C_F^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    j\in P_{\overline\kappa_F(f_{\mathrm{fine}})}^{Q_{\mathrm{coarse}}}\\
    e_{\overline\kappa_F(f_{\mathrm{fine}}),j}=D_E
  }}
  1_{\mathbb F_2}
\right)a(f_{\mathrm{fine}})\\
&=
\sum_{f_{\mathrm{fine}}\in\mathcal C_F^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    i\in P_{f_{\mathrm{fine}}}^{Q_{\mathrm{fine}}}\\
    \overline\kappa_E(e_{f_{\mathrm{fine}},i})=D_E
  }}
  1_{\mathbb F_2}
\right)a(f_{\mathrm{fine}})
\qquad
\bigl(\because\ \text{向き付き境界語の辺成分保存と奇数ファイバー条件}\bigr).
\end{aligned}`),
      paragraph(["有限和を誘導辺セル写像のファイバーごとにまとめ直すと、"]),
      displayMath(String.raw`\begin{aligned}
&\sum_{f_{\mathrm{fine}}\in\mathcal C_F^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    i\in P_{f_{\mathrm{fine}}}^{Q_{\mathrm{fine}}}\\
    \overline\kappa_E(e_{f_{\mathrm{fine}},i})=D_E
  }}
  1_{\mathbb F_2}
\right)a(f_{\mathrm{fine}})\\
&=
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
\sum_{f_{\mathrm{fine}}\in\mathcal C_F^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    i\in P_{f_{\mathrm{fine}}}^{Q_{\mathrm{fine}}}\\
    e_{f_{\mathrm{fine}},i}=C_E
  }}
  1_{\mathbb F_2}
\right)a(f_{\mathrm{fine}})
\qquad
\bigl(\because\ \text{有限集合のファイバー分割と有限和の交換}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_second_boundary_matrix_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
&\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
\sum_{f_{\mathrm{fine}}\in\mathcal C_F^{\mathrm{fine}}}
\left(
  \sum_{\substack{
    i\in P_{f_{\mathrm{fine}}}^{Q_{\mathrm{fine}}}\\
    e_{f_{\mathrm{fine}},i}=C_E
  }}
  1_{\mathbb F_2}
\right)a(f_{\mathrm{fine}})\\
&=
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
\left(
  \partial_2^{\mathrm{fine}}(a)
\right)(C_E).
\end{aligned}`),
      paragraph([
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
&\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
\left(
  \partial_2^{\mathrm{fine}}(a)
\right)(C_E)\\
&=
\left(
  \overline\kappa_{E,!}
  \left(
    \partial_2^{\mathrm{fine}}(a)
  \right)
\right)(D_E).
\end{aligned}`),
      paragraph([
        "任意の ",
        math(String.raw`a\in\mathbb F_2^{\mathcal C_F^{\mathrm{fine}}}`),
        " と ",
        math(String.raw`D_E\in\mathcal C_E^{\mathrm{coarse}}`),
        " で両成分が一致したので、二つの合成写像は等しい。奇数ファイバー条件を外すと、同じ粗段位置へ移る細段位置が偶数個の場合に右辺の係数が消えるため、この条件は境界語の点ごとの保存だけからは省けない。全てのセル集合、境界位置集合、ファイバー、係数写像、和は有限または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_face_boundary_space_pushforward_over_f2",
    kind: "theorem",
    title: { text: "商の塔における面境界空間の押し出し" },
    labels: ["theorem_quotient_tower_face_boundary_space_pushforward_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-face-boundary-space-pushforward-over-f2"],
    statement: [
      paragraph([
        ref("def_face_boundary_space_over_f2"),
        " により、細段と粗段の面境界空間をそれぞれ ",
        math(String.raw`\operatorname{Boundary}_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " と ",
        math(String.raw`\operatorname{Boundary}_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)`),
        " と書く。",
        ref("theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2"),
        " の仮定の下で、",
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " の辺係数押し出し写像は細段面境界空間を粗段面境界空間へ送る。すなわち",
      ]),
      displayMath(String.raw`\overline\kappa_{E,!}
\left(
  \operatorname{Boundary}_1
  \left(
    \mathcal C^{\mathrm{fine}};\mathbb F_2
  \right)
\right)
\subseteq
\operatorname{Boundary}_1
\left(
  \mathcal C^{\mathrm{coarse}};\mathbb F_2
\right).`),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`b\in\operatorname{Boundary}_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " を固定する。",
        ref("def_face_boundary_space_over_f2"),
        " より、ある細段面係数写像 ",
        math(String.raw`a\in\mathbb F_2^{\mathcal C_F^{\mathrm{fine}}}`),
        " が存在して、",
      ]),
      displayMath(String.raw`b
=
\partial_2^{\mathrm{fine}}(a).`),
      paragraph([
        ref("theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2"),
        " をこの ",
        math(String.raw`a`),
        " に適用すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{E,!}(b)
&=
\overline\kappa_{E,!}
\left(
  \partial_2^{\mathrm{fine}}(a)
\right)
&&\bigl(\because\ b=\partial_2^{\mathrm{fine}}(a)\bigr)\\
&=
\partial_2^{\mathrm{coarse}}
\left(
  \overline\kappa_{F,!}(a)
\right)
&&\bigl(\because\ \text{二次境界写像と押し出しの可換性}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_quotient_tower_face_coefficient_pushforward_over_f2"),
        " より ",
        math(String.raw`\overline\kappa_{F,!}(a)\in\mathbb F_2^{\mathcal C_F^{\mathrm{coarse}}}`),
        " である。したがって ",
        ref("def_face_boundary_space_over_f2"),
        " より、",
      ]),
      displayMath(String.raw`\overline\kappa_{E,!}(b)
\in
\operatorname{im}
\left(
  \partial_2^{\mathrm{coarse}}
\right)
=
\operatorname{Boundary}_1
\left(
  \mathcal C^{\mathrm{coarse}};\mathbb F_2
\right).`),
      paragraph([
        "任意の細段面境界 ",
        math(String.raw`b`),
        " で像の帰属を示したので、包含が成り立つ。全てのセル集合、係数写像、像、ファイバー、和は有限または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_first_homology_pushforward_map_over_f2",
    kind: "definition",
    title: { text: "商の塔が誘導する第一ホモロジー押し出し写像" },
    labels: ["def_quotient_tower_first_homology_pushforward_map_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-first-homology-pushforward-map-over-f2"],
    statement: [
      paragraph([
        ref("def_first_homology_group_over_f2"),
        " により、細段と粗段の第一ホモロジー群をそれぞれ ",
        math(String.raw`H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " と ",
        math(String.raw`H_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)`),
        " と書く。",
        ref("theorem_quotient_tower_face_boundary_space_pushforward_over_f2"),
        " の仮定の下で、",
        ref("def_quotient_tower_first_cycle_pushforward_map_over_f2"),
        " の一次サイクル押し出し写像から誘導される写像を、始域、終域、作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{H_1,!}:
H_1
\left(
  \mathcal C^{\mathrm{fine}};\mathbb F_2
\right)
&\longrightarrow
H_1
\left(
  \mathcal C^{\mathrm{coarse}};\mathbb F_2
\right),\\
\left\{
  c+b
  \ \middle|\
  \ b\in\operatorname{Boundary}_1
  \left(
    \mathcal C^{\mathrm{fine}};\mathbb F_2
  \right)
\right\}
&\longmapsto
\left\{
  \overline\kappa_{1,!}(c)+d
  \ \middle|\
  \ d\in\operatorname{Boundary}_1
  \left(
    \mathcal C^{\mathrm{coarse}};\mathbb F_2
  \right)
\right\}
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`c\in\operatorname{Cycle}_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        "、",
        math(String.raw`b\in\operatorname{Boundary}_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        "、",
        math(String.raw`d\in\operatorname{Boundary}_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)`),
        " であり、加法は対応する有限 ",
        math(String.raw`\mathbb F_2`),
        " 辺係数空間の成分ごとの加法である。",
      ]),
      paragraph([
        "この作用が細段一次サイクルの代表の選択に依存しないことを確かめる。同じ細段第一ホモロジー類を表す ",
        math(String.raw`c,c'\in\operatorname{Cycle}_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " に対し、ある ",
        math(String.raw`b_0\in\operatorname{Boundary}_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " が存在して ",
        math(String.raw`c'=c+b_0`),
        " である。任意の粗段辺セル ",
        math(String.raw`D_E\in\mathcal C_E^{\mathrm{coarse}}`),
        " に対し、",
        ref("def_quotient_tower_first_cycle_pushforward_map_over_f2"),
        " と ",
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " の定義より、",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{1,!}(c')(D_E)
&=
\overline\kappa_{E,!}(c')(D_E)
&&\bigl(\because\ \text{一次サイクル押し出し写像の定義}\bigr)\\
&=
\overline\kappa_{E,!}(c+b_0)(D_E)
&&\bigl(\because\ c'=c+b_0\bigr)\\
&=
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
\left(
  c(C_E)+b_0(C_E)
\right)
&&\bigl(\because\ \text{辺係数押し出し写像の定義}\bigr)\\
&=
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
c(C_E)
+
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
b_0(C_E)
&&\bigl(\because\ \mathbb F_2\text{ 上の有限和の分配律}\bigr)\\
&=
\overline\kappa_{1,!}(c)(D_E)
+
\overline\kappa_{E,!}(b_0)(D_E)
&&\bigl(\because\ \text{二つの押し出し写像の定義}\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_quotient_tower_face_boundary_space_pushforward_over_f2"),
        " より ",
        math(String.raw`\overline\kappa_{E,!}(b_0)\in\operatorname{Boundary}_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)`),
        " なので、",
      ]),
      displayMath(String.raw`\left\{
  \overline\kappa_{1,!}(c')+d
  \ \middle|\
  \ d\in\operatorname{Boundary}_1
  \left(
    \mathcal C^{\mathrm{coarse}};\mathbb F_2
  \right)
\right\}
=
\left\{
  \overline\kappa_{1,!}(c)+d
  \ \middle|\
  \ d\in\operatorname{Boundary}_1
  \left(
    \mathcal C^{\mathrm{coarse}};\mathbb F_2
  \right)
\right\}.`),
      paragraph([
        "したがって ",
        math(String.raw`\overline\kappa_{H_1,!}`),
        " は代表の選択に依存せず well-defined である。細段一次サイクル、その第一ホモロジー類、粗段一次サイクル、その第一ホモロジー類を同一視せず、移行には二つの商集合と ",
        math(String.raw`\overline\kappa_{H_1,!}`),
        " だけを用いる。この定義は誘導写像の単射性、全射性、局所全単射性、被覆次数を主張しない。全ての対象は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_first_homology_pushforward_additivity_over_f2",
    kind: "theorem",
    title: { text: "商の塔が誘導する第一ホモロジー押し出し写像の加法性" },
    labels: ["theorem_quotient_tower_first_homology_pushforward_additivity_over_f2"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-first-homology-pushforward-additivity-over-f2"],
    statement: [
      paragraph([
        ref("def_quotient_tower_first_homology_pushforward_map_over_f2"),
        " の第一ホモロジー押し出し写像に対し、任意の ",
        math(String.raw`h,h'\in H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " について",
      ]),
      displayMath(String.raw`\overline\kappa_{H_1,!}(h+h')
=
\overline\kappa_{H_1,!}(h)
+
\overline\kappa_{H_1,!}(h')
\in
H_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)`),
      paragraph([
        "が成り立つ。ここで加法は、それぞれの有限 ",
        math(String.raw`\mathbb F_2`),
        " 商ベクトル空間の加法である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`h,h'\in H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " を任意に取る。",
        ref("def_first_homology_group_over_f2"),
        " の商写像を細段では ",
        math(String.raw`\pi_1^{\mathrm{fine}}`),
        "、粗段では ",
        math(String.raw`\pi_1^{\mathrm{coarse}}`),
        " と書く。商写像は全射なので、ある ",
        math(String.raw`c,c'\in\operatorname{Cycle}_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " が存在して ",
        math(String.raw`h=\pi_1^{\mathrm{fine}}(c)`),
        " および ",
        math(String.raw`h'=\pi_1^{\mathrm{fine}}(c')`),
        " となる。",
      ]),
      paragraph([
        "まず、任意の粗段辺セル ",
        math(String.raw`D_E\in\mathcal C_E^{\mathrm{coarse}}`),
        " に対して辺係数押し出しの加法性を確かめる。",
        ref("def_quotient_tower_edge_coefficient_pushforward_over_f2"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{E,!}(c+c')(D_E)
&=
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
\left(
  c(C_E)+c'(C_E)
\right)
&&\bigl(\because\ \text{辺係数押し出し写像の定義}\bigr)\\
&=
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
c(C_E)
+
\sum_{\substack{
  C_E\in\mathcal C_E^{\mathrm{fine}}\\
  \overline\kappa_E(C_E)=D_E
}}
c'(C_E)
&&\bigl(\because\ \mathbb F_2\text{ 上の有限和の分配律}\bigr)\\
&=
\overline\kappa_{E,!}(c)(D_E)
+
\overline\kappa_{E,!}(c')(D_E)
&&\bigl(\because\ \text{辺係数押し出し写像の定義}\bigr).
\end{aligned}`),
      paragraph([
        "任意の ",
        math(String.raw`D_E\in\mathcal C_E^{\mathrm{coarse}}`),
        " で成分が等しいので、",
      ]),
      displayMath(String.raw`\overline\kappa_{E,!}(c+c')
=
\overline\kappa_{E,!}(c)
+
\overline\kappa_{E,!}(c')`),
      paragraph([
        "である。",
        ref("def_quotient_tower_first_cycle_pushforward_map_over_f2"),
        " により、細段一次サイクル上では ",
        math(String.raw`\overline\kappa_{1,!}`),
        " と ",
        math(String.raw`\overline\kappa_{E,!}`),
        " の作用が一致する。したがって、",
        ref("def_quotient_tower_first_homology_pushforward_map_over_f2"),
        " と商ベクトル空間の加法の定義より",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{H_1,!}(h+h')
&=
\overline\kappa_{H_1,!}
\left(
  \pi_1^{\mathrm{fine}}(c+c')
\right)
&&\bigl(\because\ \text{商ベクトル空間の加法の定義}\bigr)\\
&=
\pi_1^{\mathrm{coarse}}
\left(
  \overline\kappa_{1,!}(c+c')
\right)
&&\bigl(\because\ \text{第一ホモロジー押し出し写像の定義}\bigr)\\
&=
\pi_1^{\mathrm{coarse}}
\left(
  \overline\kappa_{1,!}(c)
  +
  \overline\kappa_{1,!}(c')
\right)
&&\bigl(\because\ \text{辺係数押し出しの加法性}\bigr)\\
&=
\pi_1^{\mathrm{coarse}}
\left(
  \overline\kappa_{1,!}(c)
\right)
+
\pi_1^{\mathrm{coarse}}
\left(
  \overline\kappa_{1,!}(c')
\right)
&&\bigl(\because\ \text{商ベクトル空間の加法の定義}\bigr)\\
&=
\overline\kappa_{H_1,!}(h)
+
\overline\kappa_{H_1,!}(h')
&&\bigl(\because\ \text{第一ホモロジー押し出し写像の定義}\bigr).
\end{aligned}`),
      paragraph([
        "以上は任意の ",
        math(String.raw`h,h'\in H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " に対して成り立つ。全ての対象と和は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_f2_character_pullback_map",
    kind: "definition",
    title: { text: "商の塔が誘導する F_2 値文字の引き戻し写像" },
    labels: ["def_quotient_tower_f2_character_pullback_map"],
    habitat: "F2",
    verification: ["sagemath/check/two-stage-quotient-tower-f2-character-pullback-map"],
    statement: [
      paragraph([
        ref("def_f2_linear_character_space"),
        " により、細段と粗段の第一ホモロジー群の文字空間をそれぞれ ",
        math(String.raw`H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)^\vee`),
        " と ",
        math(String.raw`H_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)^\vee`),
        " と書く。",
        ref("def_quotient_tower_first_homology_pushforward_map_over_f2"),
        " の第一ホモロジー押し出し写像との合成により、粗段文字を細段文字へ送る引き戻し写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{H_1}^{\ast}:
H_1
\left(
  \mathcal C^{\mathrm{coarse}};\mathbb F_2
\right)^\vee
&\longrightarrow
H_1
\left(
  \mathcal C^{\mathrm{fine}};\mathbb F_2
\right)^\vee,\\
\psi
&\longmapsto
\psi\circ\overline\kappa_{H_1,!}
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`\psi\in H_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)^\vee`),
        " であり、任意の ",
        math(String.raw`h,h'\in H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " と ",
        math(String.raw`a,b\in\mathbb F_2`),
        " とする。",
        ref("theorem_quotient_tower_first_homology_pushforward_additivity_over_f2"),
        " と、スカラーが ",
        math(String.raw`0_{\mathbb F_2}`),
        " と ",
        math(String.raw`1_{\mathbb F_2}`),
        " の二つだけであることより、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(
  \psi\circ\overline\kappa_{H_1,!}
\right)
(ah+bh')
&=
\psi
\left(
  \overline\kappa_{H_1,!}(ah+bh')
\right)
&&\bigl(\because\ \text{合成写像の定義}\bigr)\\
&=
\psi
\left(
  a\overline\kappa_{H_1,!}(h)
  +
  b\overline\kappa_{H_1,!}(h')
\right)
&&\bigl(\because\ \text{第一ホモロジー押し出し写像の加法性}\bigr)\\
&=
a\psi
\left(
  \overline\kappa_{H_1,!}(h)
\right)
+
b\psi
\left(
  \overline\kappa_{H_1,!}(h')
\right)
&&\bigl(\because\ \psi\text{ の }\mathbb F_2\text{ 線形性}\bigr)\\
&=
a
\left(
  \psi\circ\overline\kappa_{H_1,!}
\right)(h)
+
b
\left(
  \psi\circ\overline\kappa_{H_1,!}
\right)(h')
&&\bigl(\because\ \text{合成写像の定義}\bigr).
\end{aligned}`),
      paragraph([
        "したがって合成写像は細段の ",
        math(String.raw`\mathbb F_2`),
        " 値文字であり、表示した写像の終域は正しい。この定義は文字の単射性または全射性を主張しない。全ての群、文字空間、写像は有限集合または ",
        math(String.raw`\mathbb F_2`),
        " 上にあり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_integer_sign_character_evaluation_pullback_compatibility",
    kind: "theorem",
    title: { text: "商の塔における整数符号文字評価と引き戻しの整合性" },
    labels: ["theorem_quotient_tower_integer_sign_character_evaluation_pullback_compatibility"],
    habitat: "Z",
    verification: ["sagemath/check/two-stage-quotient-tower-integer-sign-character-evaluation-pullback-compatibility"],
    statement: [
      paragraph([
        ref("def_quotient_tower_f2_character_pullback_map"),
        " の文字引き戻し写像と ",
        ref("def_integer_sign_character_realization"),
        " の整数符号実現を用いる。任意の粗段文字 ",
        math(String.raw`\psi\in H_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)^\vee`),
        " と任意の細段第一ホモロジー類 ",
        math(String.raw`h\in H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)`),
        " に対して、",
      ]),
      displayMath(String.raw`\left(
  \operatorname{sgn}_{H_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)}(\psi)
\right)
\left(
  \overline\kappa_{H_1,!}(h)
\right)
=
\left(
  \operatorname{sgn}_{H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)}
  \left(
    \overline\kappa_{H_1}^{\ast}(\psi)
  \right)
\right)(h)
\in\{-1,+1\}\subset\mathbb Z`),
      paragraph([
        "が成り立つ。すなわち、粗段文字を押し出し像で整数符号評価する経路と、文字を引き戻してから細段類で整数符号評価する経路は一致する。",
      ]),
    ],
    proof: [
      paragraph([
        "左辺を粗段での整数符号実現の定義から展開する。",
        ref("def_integer_sign_character_realization"),
        "、",
        ref("def_quotient_tower_f2_character_pullback_map"),
        "、再び ",
        ref("def_integer_sign_character_realization"),
        " の順に用いると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(
  \operatorname{sgn}_{H_1(\mathcal C^{\mathrm{coarse}};\mathbb F_2)}(\psi)
\right)
\left(
  \overline\kappa_{H_1,!}(h)
\right)
&=
\begin{cases}
  +1,&\psi\left(\overline\kappa_{H_1,!}(h)\right)=0_{\mathbb F_2},\\
  -1,&\psi\left(\overline\kappa_{H_1,!}(h)\right)=1_{\mathbb F_2}
\end{cases}
&&\bigl(\because\ \text{粗段での整数符号実現の定義}\bigr)\\
&=
\begin{cases}
  +1,&\left(\overline\kappa_{H_1}^{\ast}(\psi)\right)(h)=0_{\mathbb F_2},\\
  -1,&\left(\overline\kappa_{H_1}^{\ast}(\psi)\right)(h)=1_{\mathbb F_2}
\end{cases}
&&\bigl(\because\ \text{文字引き戻し写像の定義}\bigr)\\
&=
\left(
  \operatorname{sgn}_{H_1(\mathcal C^{\mathrm{fine}};\mathbb F_2)}
  \left(
    \overline\kappa_{H_1}^{\ast}(\psi)
  \right)
\right)(h)
&&\bigl(\because\ \text{細段での整数符号実現の定義}\bigr).
\end{aligned}`),
      paragraph([
        "各場合の値は整数 ",
        math(String.raw`-1,+1\in\mathbb Z`),
        " である。全ての第一ホモロジー群と文字空間は有限であり、評価は ",
        math(String.raw`\mathbb F_2`),
        " と ",
        math(String.raw`\mathbb Z`),
        " の有限演算だけを用いる。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_homology_polynomial_family_pushforward_map",
    kind: "definition",
    title: { text: "商の塔に沿うホモロジー類別多項式族の押し出し写像" },
    labels: ["def_quotient_tower_homology_polynomial_family_pushforward_map"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/two-stage-quotient-tower-homology-polynomial-family-pushforward-map"],
    statement: [
      paragraph([
        ref("def_quotient_tower_first_homology_pushforward_map_over_f2"),
        " の第一ホモロジー押し出し写像を固定する。細段と粗段の第一ホモロジー群をそれぞれ",
      ]),
      displayMath(String.raw`H_{\mathrm{fine}}
:=
H_1
\left(
  \mathcal C^{\mathrm{fine}};\mathbb F_2
\right),
\qquad
H_{\mathrm{coarse}}
:=
H_1
\left(
  \mathcal C^{\mathrm{coarse}};\mathbb F_2
\right)`),
      paragraph([
        "と書く。独立な不定元 ",
        math(String.raw`u,v`),
        " と、任意の整数係数多項式族 ",
        math(String.raw`A=(A_h)_{h\in H_{\mathrm{fine}}}\in\bigl(\mathbb Z[u,v]\bigr)^{H_{\mathrm{fine}}}`),
        " に対し、ホモロジー類別多項式族の押し出し写像を、始域、終域、各粗段成分の作用を明示して",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_{\mathrm{poly},!}:
\bigl(\mathbb Z[u,v]\bigr)^{H_{\mathrm{fine}}}
&\longrightarrow
\bigl(\mathbb Z[u,v]\bigr)^{H_{\mathrm{coarse}}},\\
A
&\longmapsto
\overline\kappa_{\mathrm{poly},!}(A),\\
\left(
  \overline\kappa_{\mathrm{poly},!}(A)
\right)_k
&:=
\sum_{h\in
  \overline\kappa_{H_1,!}^{-1}(\{k\})
}
A_h
\in\mathbb Z[u,v]
\qquad
\left(k\in H_{\mathrm{coarse}}\right)
\end{aligned}`),
      paragraph([
        "で定める。各ファイバーは有限集合である。空のファイバーにわたる和は ",
        math(String.raw`\mathbb Z[u,v]`),
        " の零多項式とするので、粗段の全ての第一ホモロジー類について成分が定まり、表示した終域は正しい。この定義は、特定のセル分割から得た高温生成多項式族がこの写像で互いに移ることも、第一ホモロジー押し出し写像の単射性または全射性も主張しない。全ての添字集合は有限であり、整数係数多項式の有限和だけを用いる。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_fourier_pushforward_pullback_compatibility",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "商の塔における有限 Fourier 変換と押し出し・引き戻しの整合性" },
    labels: ["theorem_quotient_tower_fourier_pushforward_pullback_compatibility"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/two-stage-quotient-tower-fourier-pushforward-pullback-compatibility"],
    statement: [
      paragraph([
        ref("def_quotient_tower_homology_polynomial_family_pushforward_map"),
        " の多項式族押し出し写像と、",
        ref("def_quotient_tower_f2_character_pullback_map"),
        " の文字引き戻し写像を用いる。細段と粗段の第一ホモロジー群をそれぞれ ",
        math(String.raw`H_{\mathrm{fine}}`),
        " と ",
        math(String.raw`H_{\mathrm{coarse}}`),
        " と書く。独立な不定元 ",
        math(String.raw`u,v`),
        "、任意の多項式族 ",
        math(String.raw`A\in\bigl(\mathbb Z[u,v]\bigr)^{H_{\mathrm{fine}}}`),
        "、任意の粗段文字 ",
        math(String.raw`\psi\in H_{\mathrm{coarse}}^\vee`),
        " に対して、",
      ]),
      displayMath(String.raw`\left(
  \mathcal F_{H_{\mathrm{coarse}}}
  \left(
    \overline\kappa_{\mathrm{poly},!}(A)
  \right)
\right)_{\psi}
=
\left(
  \mathcal F_{H_{\mathrm{fine}}}(A)
\right)_{\overline\kappa_{H_1}^{\ast}(\psi)}
\in\mathbb Z[u,v]`),
      paragraph([
        "が成り立つ。左辺は第一ホモロジー類を押し出してから粗段で Fourier 変換した成分、右辺は粗段文字を引き戻してから細段で Fourier 変換した成分である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=\overline\kappa_{\mathrm{poly},!}(A)`),
        " と置く。任意の ",
        math(String.raw`k\in H_{\mathrm{coarse}}`),
        " と ",
        math(String.raw`h\in H_{\mathrm{fine}}`),
        " に対し、整数符号を ",
        math(String.raw`\varepsilon_{\psi}(k):=\bigl(\operatorname{sgn}_{H_{\mathrm{coarse}}}(\psi)\bigr)(k)\in\{-1,+1\}`),
        " および ",
        math(String.raw`\varepsilon_{\overline\kappa^{\ast}(\psi)}(h):=\bigl(\operatorname{sgn}_{H_{\mathrm{fine}}}(\overline\kappa_{H_1}^{\ast}(\psi))\bigr)(h)\in\{-1,+1\}`),
        " と書く。",
      ]),
      paragraph([
        ref("def_finite_fourier_transform"),
        " の有限 Fourier 変換の定義と ",
        ref("def_quotient_tower_homology_polynomial_family_pushforward_map"),
        " より",
      ]),
      displayMath(String.raw`\left(
  \mathcal F_{H_{\mathrm{coarse}}}(B)
\right)_{\psi}
=
\sum_{k\in H_{\mathrm{coarse}}}
\varepsilon_{\psi}(k)
\sum_{h\in\overline\kappa_{H_1,!}^{-1}(\{k\})}
A_h
\quad\bigl(\because\ \text{有限 Fourier 変換と多項式族押し出しの定義}\bigr).`),
      displayMath(String.raw`\sum_{k\in H_{\mathrm{coarse}}}
\varepsilon_{\psi}(k)
\sum_{h\in\overline\kappa_{H_1,!}^{-1}(\{k\})}
A_h
=
\sum_{h\in H_{\mathrm{fine}}}
\varepsilon_{\psi}
\left(
  \overline\kappa_{H_1,!}(h)
\right)
A_h
\quad\bigl(\because\ \text{写像の全ファイバーによる有限添字集合の分割}\bigr).`),
      paragraph([
        ref("theorem_quotient_tower_integer_sign_character_evaluation_pullback_compatibility"),
        " より",
      ]),
      displayMath(String.raw`\sum_{h\in H_{\mathrm{fine}}}
\varepsilon_{\psi}
\left(
  \overline\kappa_{H_1,!}(h)
\right)
A_h
=
\sum_{h\in H_{\mathrm{fine}}}
\varepsilon_{\overline\kappa^{\ast}(\psi)}(h)A_h
\quad\bigl(\because\ \text{整数符号文字評価と引き戻しの整合性}\bigr).`),
      paragraph([
        ref("def_finite_fourier_transform"),
        " の有限 Fourier 変換の定義より",
      ]),
      displayMath(String.raw`\sum_{h\in H_{\mathrm{fine}}}
\varepsilon_{\overline\kappa^{\ast}(\psi)}(h)A_h
=
\left(
  \mathcal F_{H_{\mathrm{fine}}}(A)
\right)_{\overline\kappa_{H_1}^{\ast}(\psi)}
\quad\bigl(\because\ \text{有限 Fourier 変換の定義}\bigr).`),
      paragraph([
        "以上の等式を順に用いて主張を得る。全ての添字集合は有限であり、係数は ",
        math(String.raw`\mathbb Z`),
        "、多項式は ",
        math(String.raw`\mathbb Z[u,v]`),
        " に属する。実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_two_stage_ising_coefficient_pair_map",
    kind: "definition",
    title: { text: "商の塔に沿う二段 Ising 係数対写像" },
    labels: ["def_quotient_tower_two_stage_ising_coefficient_pair_map"],
    habitat: "N",
    verification: ["sagemath/check/two-stage-quotient-tower-ising-coefficient-pair-map"],
    statement: [
      paragraph([
        ref("def_two_stage_finite_quotient_tower_input"),
        " と ",
        ref("def_quotient_tower_induced_coset_cell_maps"),
        "、",
        ref("def_quotient_tower_oriented_edge_representative_selector_compatibility"),
        "、",
        ref("def_quotient_tower_stage_oriented_edge_endpoint_maps"),
        "、",
        ref("def_quotient_tower_stage_oriented_cellulation_data"),
        " を固定し、両段のセルデータが ",
        ref("def_oriented_closed_surface_cellulation"),
        " の有限述語を満たすと仮定する。細段と粗段の一次骨格を、それぞれ有限グラフ ",
        math(String.raw`G_{\mathrm{fine}}=(V_{\mathrm{fine}},E_{\mathrm{fine}},\partial_{G_{\mathrm{fine}}})`),
        " と ",
        math(String.raw`G_{\mathrm{coarse}}=(V_{\mathrm{coarse}},E_{\mathrm{coarse}},\partial_{G_{\mathrm{coarse}}})`),
        " と書く。端点写像の段間整合性には ",
        ref("theorem_quotient_tower_oriented_edge_endpoint_map_preservation"),
        " の条件を用いる。両段で ",
        ref("def_spin_label_set"),
        " の同じ形式的スピンラベル集合と ",
        ref("def_broken_edge_set"),
        " の同じ破れ辺規則を用いる。",
      ]),
      paragraph([
        ref("def_broken_edge_multiplicity"),
        " の多重度を次数外で零へ延長し、二段の係数を同じ自然数で比較する一つの写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat\Omega_{\mathcal T}:\mathbb N
&\longrightarrow
\mathbb N\times\mathbb N,\\
m
&\longmapsto
\left(
  \widehat\Omega_{\mathrm{fine}}(m),
  \widehat\Omega_{\mathrm{coarse}}(m)
\right),\\
\widehat\Omega_{\mathrm{fine}}(m)
&:=
\begin{cases}
  \Omega_{G_{\mathrm{fine}}}(m)
  &\left(0\le m\le |E_{\mathrm{fine}}|\right),\\
  0
  &\left(m>|E_{\mathrm{fine}}|\right),
\end{cases}\\
\widehat\Omega_{\mathrm{coarse}}(m)
&:=
\begin{cases}
  \Omega_{G_{\mathrm{coarse}}}(m)
  &\left(0\le m\le |E_{\mathrm{coarse}}|\right),\\
  0
  &\left(m>|E_{\mathrm{coarse}}|\right)
\end{cases}
\end{aligned}`),
      paragraph([
        "で定める。ここで ",
        math(String.raw`m,|E_{\mathrm{fine}}|,|E_{\mathrm{coarse}}|\in\mathbb N`),
        " であり、各成分は自然数に属する。両段の Ising 分配多項式には ",
        ref("def_ising_partition_polynomial"),
        " の同じ不定元 ",
        math(String.raw`x`),
        " を用いる。各段は閉曲面セルデータの一次骨格全体なので外部境界条件を追加しない。係数は頂点数、辺数、被覆次数で割らない生の配位数であり、この写像は段間の係数等式、単調性、比例関係を主張しない。全ての集合と計数は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_two_stage_ising_coefficient_valuation_pair_map",
    kind: "definition",
    title: { text: "商の塔に沿う二段 Ising 係数付値対写像" },
    labels: ["def_quotient_tower_two_stage_ising_coefficient_valuation_pair_map"],
    habitat: "Z",
    verification: ["sagemath/check/two-stage-quotient-tower-ising-coefficient-valuation-pair-map"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_ising_coefficient_pair_map"),
        " の二段 Ising 係数対写像と、",
        ref("def_fixed_quotient_coefficient_valuation"),
        " の正整数係数に対する指定素数付値を用いる。二段の係数がともに正である次数と素数からなる入力集合を",
      ]),
      displayMath(String.raw`D_{\mathcal T}
:=
\left\{
  (m,p)\in\mathbb N\times\mathbb N_{>1}
  \,\middle|\,
  \begin{array}{l}
    p\text{ は素数},\\
    \widehat\Omega_{\mathrm{fine}}(m)>0,\\
    \widehat\Omega_{\mathrm{coarse}}(m)>0
  \end{array}
\right\}`),
      paragraph([
        "と定める。各 ",
        math(String.raw`(m,p)\in D_{\mathcal T}`),
        " に対し、二段 Ising 係数付値対写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\nu_{\mathcal T}:D_{\mathcal T}
&\longrightarrow
\mathbb N\times\mathbb N
\subset
\mathbb Z\times\mathbb Z,\\
(m,p)
&\longmapsto
\left(
  \nu_{\mathrm{fine},p}(m),
  \nu_{\mathrm{coarse},p}(m)
\right),\\
\nu_{\mathrm{fine},p}(m)
&:=
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  \exists r\in\mathbb N_{>0},\quad
  \widehat\Omega_{\mathrm{fine}}(m)=p^k r
\right\},\\
\nu_{\mathrm{coarse},p}(m)
&:=
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  \exists s\in\mathbb N_{>0},\quad
  \widehat\Omega_{\mathrm{coarse}}(m)=p^k s
\right\}
\end{aligned}`),
      paragraph([
        "で定める。次数 ",
        math(String.raw`m`),
        " の候補は二つの有限辺集合の大きい方の濃度以下に限られるが、素数 ",
        math(String.raw`p`),
        " は全ての素数を走るので、定義域 ",
        math(String.raw`D_{\mathcal T}`),
        " は自然数対の可算部分集合であり、有限集合とは限らない。定義域の正値条件により両係数は ",
        math(String.raw`\mathbb N_{>0}`),
        " に属するため、二つの最大値は正整数を指定素数で割り切れる間だけ反復除算した有限回数として一意に定まる。係数の一方が零である次数には整数付値を定義せず、零延長した係数対と付値対を同一視しない。この写像は二つの付値の等式、大小、差、被覆次数に関する関係を主張しない。各入力で扱うセル集合、スピン配位集合、係数および反復除算は有限であり、完全因数分解、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_two_stage_ising_coefficient_valuation_difference_map",
    kind: "definition",
    title: { text: "商の塔に沿う二段 Ising 係数付値差写像" },
    labels: ["def_quotient_tower_two_stage_ising_coefficient_valuation_difference_map"],
    habitat: "Z",
    verification: ["sagemath/check/two-stage-quotient-tower-ising-coefficient-valuation-difference-map"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_ising_coefficient_valuation_pair_map"),
        " の定義域 ",
        math(String.raw`D_{\mathcal T}`),
        " と二段 Ising 係数付値対写像 ",
        math(String.raw`\nu_{\mathcal T}`),
        " を用いる。各 ",
        math(String.raw`(m,p)\in D_{\mathcal T}`),
        " に対し、細段成分から粗段成分を引く整数値写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\Delta\nu_{\mathcal T}:D_{\mathcal T}
&\longrightarrow
\mathbb Z,\\
(m,p)
&\longmapsto
\nu_{\mathrm{fine},p}(m)
-
\nu_{\mathrm{coarse},p}(m)
\end{aligned}`),
      paragraph([
        "で定める。二つの付値はそれぞれ ",
        math(String.raw`\mathbb N\subset\mathbb Z`),
        " に属するので、差は一意な整数に属する。この写像の値域を ",
        math(String.raw`\mathbb N`),
        " に制限せず、値の正、零、負のいずれも定義から排除しない。したがって、この定義だけから付値の段間単調性、差の符号、被覆次数との関係は主張しない。全ての対象は有限係数の指定素数付値と整数の減法だけで定まり、完全因数分解、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_two_stage_ising_coefficient_valuation_difference_finite_support",
    kind: "theorem",
    title: { text: "固定次数における二段 Ising 係数付値差の有限台" },
    labels: ["theorem_quotient_tower_two_stage_ising_coefficient_valuation_difference_finite_support"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-ising-coefficient-valuation-difference-finite-support"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_ising_coefficient_valuation_difference_map"),
        " の二段 Ising 係数付値差写像を用いる。次数 ",
        math(String.raw`m\in\mathbb N`),
        " を、",
        math(String.raw`\widehat\Omega_{\mathrm{fine}}(m)>0`),
        " かつ ",
        math(String.raw`\widehat\Omega_{\mathrm{coarse}}(m)>0`),
        " を満たすように固定する。この次数で付値差が非零となる素数の集合を",
      ]),
      displayMath(String.raw`\operatorname{Supp}_{\Delta\nu_{\mathcal T}}(m)
:=
\left\{
  p\in\mathbb N_{>1}
  \,\middle|\,
  \begin{array}{l}
    p\text{ は素数},\\
    \Delta\nu_{\mathcal T}(m,p)\ne 0
  \end{array}
\right\}`),
      paragraph([
        "で定める。このとき ",
        math(String.raw`\operatorname{Supp}_{\Delta\nu_{\mathcal T}}(m)`),
        " は有限集合である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a:=\widehat\Omega_{\mathrm{fine}}(m)\in\mathbb N_{>0}`),
        "、",
        math(String.raw`b:=\widehat\Omega_{\mathrm{coarse}}(m)\in\mathbb N_{>0}`),
        "、",
        math(String.raw`N_m:=ab\in\mathbb N_{>0}`),
        " と置く。",
      ]),
      paragraph([
        ref("def_quotient_tower_two_stage_ising_coefficient_valuation_pair_map"),
        " と ",
        ref("def_quotient_tower_two_stage_ising_coefficient_valuation_difference_map"),
        " より、素数 ",
        math(String.raw`p\in\mathbb N_{>1}`),
        " が ",
        math(String.raw`N_m`),
        " を割らないなら、",
      ]),
      displayMath(String.raw`\begin{aligned}
p\nmid N_m
&\Longrightarrow
p\nmid a\ \text{かつ}\ p\nmid b
\quad(\because p\mid a\ \text{または}\ p\mid b\ \text{ならば}\ p\mid ab),\\
&\Longrightarrow
\nu_{\mathrm{fine},p}(m)=0\ \text{かつ}\ \nu_{\mathrm{coarse},p}(m)=0
\quad(\because p\nmid a,\ p\nmid b),\\
&\Longrightarrow
\Delta\nu_{\mathcal T}(m,p)=0
\quad(\because 0-0=0)
\end{aligned}`),
      paragraph([
        "したがって、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{Supp}_{\Delta\nu_{\mathcal T}}(m)
&\subseteq
\left\{
  p\in\mathbb N_{>1}
  \,\middle|\,
  p\text{ は素数かつ }p\mid N_m
\right\}
\quad(\because \text{上の含意の対偶}),\\
\left\{
  p\in\mathbb N_{>1}
  \,\middle|\,
  p\text{ は素数かつ }p\mid N_m
\right\}
&\subseteq
\left\{
  n\in\mathbb N
  \,\middle|\,
  2\le n\le N_m
\right\}
\quad(\because p\mid N_m\ \text{かつ}\ N_m>0)
\end{aligned}`),
      paragraph([
        math(String.raw`\left\{n\in\mathbb N\mid 2\le n\le N_m\right\}`),
        " は有限集合なので、その部分集合である ",
        math(String.raw`\operatorname{Supp}_{\Delta\nu_{\mathcal T}}(m)`),
        " も有限集合である。全ての対象は自然数、整数、有限集合および指定素数付値だけで定まり、完全因数分解、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_two_stage_ising_coefficient_valuation_difference_logarithmic_value",
    kind: "definition",
    title: { text: "固定次数における二段 Ising 係数付値差の素指数加法群値" },
    labels: ["def_quotient_tower_two_stage_ising_coefficient_valuation_difference_logarithmic_value"],
    habitat: "Lambda",
    verification: ["sagemath/check/two-stage-quotient-tower-ising-coefficient-valuation-difference-logarithmic-value"],
    statement: [
      paragraph([
        ref("def_prime_exponent_logarithmic_group"),
        " の素数集合 ",
        math(String.raw`\mathcal P`),
        "、形式的生成元 ",
        math(String.raw`\ell_p`),
        "、素指数加法群 ",
        math(String.raw`\Lambda`),
        " を用いる。",
        ref("theorem_quotient_tower_two_stage_ising_coefficient_valuation_difference_finite_support"),
        " の次数 ",
        math(String.raw`m\in\mathbb N`),
        " を固定する。この次数における二段 Ising 係数付値差の素指数加法群値を",
      ]),
      displayMath(String.raw`\Delta\mathcal L_{\mathcal T}(m)
:=
\sum_{p\in\operatorname{Supp}_{\Delta\nu_{\mathcal T}}(m)}
\Delta\nu_{\mathcal T}(m,p)\,\ell_p
\in\Lambda`),
      paragraph([
        "で定める。",
        ref("def_quotient_tower_two_stage_ising_coefficient_valuation_difference_map"),
        " より各係数 ",
        math(String.raw`\Delta\nu_{\mathcal T}(m,p)`),
        " は整数であり、",
        ref("theorem_quotient_tower_two_stage_ising_coefficient_valuation_difference_finite_support"),
        " より和の添字集合は有限である。したがって右辺は有限台をもつ整数係数写像を一意に定め、表示した ",
        math(String.raw`\Lambda`),
        " に属する。台が空のときは ",
        math(String.raw`\Lambda`),
        " の零元とする。この定義は実対数、完全因数分解、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_positive_rational_logarithmic_value_map",
    kind: "definition",
    title: { text: "正有理数の素指数データを素指数加法群へ送る写像" },
    labels: ["def_quotient_tower_positive_rational_logarithmic_value_map"],
    habitat: "Lambda",
    verification: ["sagemath/check/positive-rational-logarithmic-value-map"],
    statement: [
      paragraph([
        ref("def_prime_exponent_logarithmic_group"),
        " の素数集合 ",
        math(String.raw`\mathcal P`),
        "、形式的生成元 ",
        math(String.raw`\ell_p`),
        "、素指数加法群 ",
        math(String.raw`\Lambda`),
        " を用いる。各 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " に対し、互いに素な ",
        math(String.raw`a_q,b_q\in\mathbb N_{>0}`),
        " で ",
        math(String.raw`q=a_q/b_q`),
        " を満たすものを一意に選ぶ。各素数 ",
        math(String.raw`p\in\mathcal P`),
        " における素指数を",
      ]),
      displayMath(String.raw`v_p(q)
:=
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  \exists r\in\mathbb N_{>0},\quad a_q=p^k r
\right\}
-
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  \exists s\in\mathbb N_{>0},\quad b_q=p^k s
\right\}
\in\mathbb Z`),
      paragraph([
        "で定め、非零素指数の台を",
      ]),
      displayMath(String.raw`\operatorname{Supp}_v(q)
:=
\left\{
  p\in\mathcal P
  \,\middle|\,
  v_p(q)\ne 0
\right\}`),
      paragraph([
        "と定める。",
        math(String.raw`v_p(q)\ne0`),
        " ならば ",
        math(String.raw`p\mid a_qb_q`),
        " であり、正整数 ",
        math(String.raw`a_qb_q`),
        " の素数約数は有限個なので、",
        math(String.raw`\operatorname{Supp}_v(q)`),
        " は有限集合である。正有理数の素指数データを素指数加法群へ送る写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\log_{\Lambda}:\mathbb Q_{>0}
&\longrightarrow
\Lambda,\\
q
&\longmapsto
\sum_{p\in\operatorname{Supp}_v(q)}
v_p(q)\,\ell_p
\end{aligned}`),
      paragraph([
        "で定める。各係数は整数であり、和の添字集合は有限なので、右辺は ",
        math(String.raw`\Lambda`),
        " の元を一意に定める。",
        math(String.raw`q=1`),
        " のときは ",
        math(String.raw`a_q=b_q=1`),
        " かつ台が空であり、像を ",
        math(String.raw`\Lambda`),
        " の零元とする。この定義は正有理数の既約分数表示と指定素数での反復除算だけを用い、実対数、完全因数分解、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility",
    kind: "theorem",
    title: { text: "二段 Ising 係数比と付値差の素指数加法群値の一致" },
    labels: ["theorem_quotient_tower_two_stage_ising_coefficient_ratio_logarithmic_value_compatibility"],
    habitat: "Lambda",
    verification: ["sagemath/check/two-stage-quotient-tower-ising-coefficient-ratio-logarithmic-value-compatibility"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_ising_coefficient_pair_map"),
        " の二段 Ising 係数対写像について、次数 ",
        math(String.raw`m\in\mathbb N`),
        " が ",
        math(String.raw`\widehat\Omega_{\mathrm{fine}}(m)>0`),
        " かつ ",
        math(String.raw`\widehat\Omega_{\mathrm{coarse}}(m)>0`),
        " を満たすと仮定する。このとき正有理係数比の素指数加法群値は、同じ次数の付値差の素指数加法群値に一致する。",
      ]),
      displayMath(String.raw`\log_{\Lambda}
\left(
  \frac{
    \widehat\Omega_{\mathrm{fine}}(m)
  }{
    \widehat\Omega_{\mathrm{coarse}}(m)
  }
\right)
=
\Delta\mathcal L_{\mathcal T}(m)
\in\Lambda.`),
    ],
    proof: [
      paragraph([
        math(String.raw`a:=\widehat\Omega_{\mathrm{fine}}(m)\in\mathbb N_{>0}`),
        "、",
        math(String.raw`b:=\widehat\Omega_{\mathrm{coarse}}(m)\in\mathbb N_{>0}`),
        "、",
        math(String.raw`g:=\gcd(a,b)\in\mathbb N_{>0}`),
        " と置く。すると ",
        math(String.raw`a/g,b/g\in\mathbb N_{>0}`),
        " は互いに素であり、",
        math(String.raw`a/b=(a/g)/(b/g)\in\mathbb Q_{>0}`),
        " は既約分数表示である。",
      ]),
      paragraph([
        ref("def_quotient_tower_positive_rational_logarithmic_value_map"),
        " の素指数と ",
        ref("def_quotient_tower_two_stage_ising_coefficient_valuation_pair_map"),
        " の二段付値対、および ",
        ref("def_quotient_tower_two_stage_ising_coefficient_valuation_difference_map"),
        " の付値差より、各素数 ",
        math(String.raw`p\in\mathcal P`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
v_p
\left(
  \frac{a}{b}
\right)
&=
\left(
  \nu_{\mathrm{fine},p}(m)-v_p(g)
\right)
-
\left(
  \nu_{\mathrm{coarse},p}(m)-v_p(g)
\right)
\quad\bigl(\because\ \text{既約分数の分子と分母は }a/g\text{ と }b/g\bigr),\\
&=
\nu_{\mathrm{fine},p}(m)
-
\nu_{\mathrm{coarse},p}(m)
\quad\bigl(\because\ \text{整数の加法における相殺}\bigr),\\
&=
\Delta\nu_{\mathcal T}(m,p)
\quad\bigl(\because\ \text{二段 Ising 係数付値差の定義}\bigr).
\end{aligned}`),
      paragraph([
        "したがって、",
        math(String.raw`v_p(a/b)\ne0`),
        " と ",
        math(String.raw`\Delta\nu_{\mathcal T}(m,p)\ne0`),
        " は同値であり、二つの有限台は同じ素数集合である。",
      ]),
      paragraph([
        ref("def_quotient_tower_positive_rational_logarithmic_value_map"),
        " より",
      ]),
      displayMath(String.raw`\log_{\Lambda}
\left(
  \frac{a}{b}
\right)
=
\sum_{p\in\operatorname{Supp}_v(a/b)}
v_p
\left(
  \frac{a}{b}
\right)\ell_p
\quad\bigl(\because\ \text{正有理数の素指数加法群値写像の定義}\bigr).`),
      displayMath(String.raw`\sum_{p\in\operatorname{Supp}_v(a/b)}
v_p
\left(
  \frac{a}{b}
\right)\ell_p
=
\sum_{p\in\operatorname{Supp}_{\Delta\nu_{\mathcal T}}(m)}
\Delta\nu_{\mathcal T}(m,p)\ell_p
\quad\bigl(\because\ \text{上で示した係数ごとの等式と台の一致}\bigr).`),
      paragraph([
        ref("def_quotient_tower_two_stage_ising_coefficient_valuation_difference_logarithmic_value"),
        " より",
      ]),
      displayMath(String.raw`\sum_{p\in\operatorname{Supp}_{\Delta\nu_{\mathcal T}}(m)}
\Delta\nu_{\mathcal T}(m,p)\ell_p
=
\Delta\mathcal L_{\mathcal T}(m)
\quad\bigl(\because\ \text{付値差の素指数加法群値の定義}\bigr).`),
      paragraph([
        math(String.raw`a=\widehat\Omega_{\mathrm{fine}}(m)`),
        " と ",
        math(String.raw`b=\widehat\Omega_{\mathrm{coarse}}(m)`),
        " を戻すと主張を得る。全ての係数は正整数、比は正有理数、素指数と付値差は整数、二つの台は有限集合、両辺は ",
        math(String.raw`\Lambda`),
        " に属する。実対数、完全因数分解、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_two_stage_fisher_zero_multiplicity_pair_map",
    kind: "definition",
    title: { text: "商の塔に沿う二段 Fisher 零点重複度対写像" },
    labels: ["def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map"],
    habitat: "Qbar",
    verification: ["sagemath/check/two-stage-quotient-tower-fisher-zero-multiplicity-pair-map"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_ising_coefficient_pair_map"),
        " の二段係数から、同じ不定元 ",
        math(String.raw`x`),
        " をもつ二つの Ising 分配多項式を",
      ]),
      displayMath(String.raw`\begin{aligned}
P_{\mathrm{fine}}(x)
&:=
\sum_{m=0}^{|E_{\mathrm{fine}}|}
\widehat\Omega_{\mathrm{fine}}(m)x^m
\in\mathbb Z[x],\\
P_{\mathrm{coarse}}(x)
&:=
\sum_{m=0}^{|E_{\mathrm{coarse}}|}
\widehat\Omega_{\mathrm{coarse}}(m)x^m
\in\mathbb Z[x]
\end{aligned}`),
      paragraph([
        "と置く。標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " による像をそれぞれ ",
        math(String.raw`\overline P_{\mathrm{fine}},\overline P_{\mathrm{coarse}}\in\overline{\mathbb Q}[x]`),
        " と書き、二段の Fisher 零点台の和集合を",
      ]),
      displayMath(String.raw`\mathcal Z_{\mathcal T}
:=
\left\{
  \alpha\in\overline{\mathbb Q}
  \,\middle|\,
  \overline P_{\mathrm{fine}}(\alpha)=0
  \text{ または }
  \overline P_{\mathrm{coarse}}(\alpha)=0
\right\}`),
      paragraph([
        "と定める。各 ",
        math(String.raw`\alpha\in\mathcal Z_{\mathcal T}`),
        " に対し、細段と粗段の零点重複度を零延長した一つの写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu_{\mathcal T}:\mathcal Z_{\mathcal T}
&\longrightarrow
\mathbb N\times\mathbb N,\\
\alpha
&\longmapsto
\left(
  \mu_{\mathrm{fine}}(\alpha),
  \mu_{\mathrm{coarse}}(\alpha)
\right),\\
\mu_{s}(\alpha)
&:=
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  (x-\alpha)^k\mid\overline P_s(x)
  \text{ in }\overline{\mathbb Q}[x]
\right\}
\quad
\left(s\in\{\mathrm{fine},\mathrm{coarse}\}\right)
\end{aligned}`),
      paragraph([
        "で定める。各最大値の集合は ",
        math(String.raw`k=0`),
        " を含み、対応する多項式の次数で上に有界なので、二成分は一意な自然数として定まる。一方の段だけの零点では、他方の成分は整除可能な最大指数 ",
        math("0"),
        " となる。この写像は二段の零点を同一視せず、共通の代数的数における二つの重複度を順序付き対として記録する。全ての対象は ",
        math(String.raw`\overline{\mathbb Q}`),
        " と代数的多項式の有限整除で定まり、複素平面への埋め込み、数値近似、距離、偏角、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_two_stage_fisher_zero_multiplicity_difference_map",
    kind: "definition",
    title: { text: "商の塔に沿う二段 Fisher 零点重複度差写像" },
    labels: ["def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map"],
    habitat: "Z",
    verification: ["sagemath/check/two-stage-quotient-tower-fisher-zero-multiplicity-difference-map"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map"),
        " の二段 Fisher 零点重複度対写像について、自然数の標準単射 ",
        math(String.raw`\iota_{\mathbb N,\mathbb Z}:\mathbb N\hookrightarrow\mathbb Z`),
        " を用いる。二段 Fisher 零点重複度差写像を",
      ]),
      displayMath(String.raw`\begin{aligned}
\Delta\mu_{\mathcal T}:\mathcal Z_{\mathcal T}
&\longrightarrow
\mathbb Z,\\
\alpha
&\longmapsto
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{fine}}(\alpha)
\right)
-
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{coarse}}(\alpha)
\right)
\end{aligned}`),
      paragraph([
        "で定める。共通零点では二つの重複度の整数差を記録し、細段だけの零点では正の自然数、粗段だけの零点では負の整数を返す。値域を ",
        math(String.raw`\mathbb Z`),
        " 全体に置き、差の符号、零点台の包含、段間単調性を仮定しない。この写像は ",
        math(String.raw`\overline{\mathbb Q}`),
        " 上の有限多項式整除と整数の減法だけで定まり、複素平面への埋め込み、数値近似、距離、偏角、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_two_stage_fisher_zero_multiplicity_difference_finite_support",
    kind: "theorem",
    title: { text: "商の塔に沿う二段 Fisher 零点重複度差の有限台" },
    labels: ["theorem_quotient_tower_two_stage_fisher_zero_multiplicity_difference_finite_support"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-fisher-zero-multiplicity-difference-finite-support"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map"),
        " の二段 Fisher 零点重複度差が非零となる零点の集合を",
      ]),
      displayMath(String.raw`\operatorname{Supp}_{\Delta\mu_{\mathcal T}}
:=
\left\{
  \alpha\in\mathcal Z_{\mathcal T}
  \,\middle|\,
  \Delta\mu_{\mathcal T}(\alpha)\ne0
\right\}`),
      paragraph([
        "で定める。このとき ",
        math(String.raw`\operatorname{Supp}_{\Delta\mu_{\mathcal T}}`),
        " は二段 Fisher 零点台 ",
        math(String.raw`\mathcal Z_{\mathcal T}\subset\overline{\mathbb Q}`),
        " の有限部分集合である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map"),
        " の二つの Ising 分配多項式について、両段の全てのスピンを同じ形式的ラベルにした配位と、全てをもう一方の形式的ラベルにした配位は、ともに破れ辺数 ",
        math("0"),
        " をもつ。したがって各 ",
        math(String.raw`s\in\{\mathrm{fine},\mathrm{coarse}\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat\Omega_s(0)
&\ge 2
\quad\bigl(\because\ \text{二つの定数スピン配位は相異なる}\bigr),\\
P_s(x)
&\ne 0
\quad\bigl(\because\ \text{定数項 }\widehat\Omega_s(0)\text{ が正である}\bigr).
\end{aligned}`),
      paragraph([
        "非零な一変数多項式の零点集合は、その次数以下の濃度をもつ有限集合である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathcal Z_{\mathcal T}
&=
\left\{
  \alpha\in\overline{\mathbb Q}
  \,\middle|\,
  \overline P_{\mathrm{fine}}(\alpha)=0
\right\}
\cup
\left\{
  \alpha\in\overline{\mathbb Q}
  \,\middle|\,
  \overline P_{\mathrm{coarse}}(\alpha)=0
\right\}
\quad\bigl(\because\ \text{二段 Fisher 零点台の定義}\bigr),\\
\left|\mathcal Z_{\mathcal T}\right|
&\le
\deg P_{\mathrm{fine}}+\deg P_{\mathrm{coarse}}
\quad\bigl(\because\ \text{有限集合の和集合の濃度評価}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map"),
        " と有限台の定義より",
      ]),
      displayMath(String.raw`\operatorname{Supp}_{\Delta\mu_{\mathcal T}}
\subseteq
\mathcal Z_{\mathcal T}
\quad\bigl(\because\ \text{集合の内包的定義}\bigr).`),
      paragraph([
        "したがって ",
        math(String.raw`\operatorname{Supp}_{\Delta\mu_{\mathcal T}}`),
        " は有限集合 ",
        math(String.raw`\mathcal Z_{\mathcal T}`),
        " の部分集合なので有限である。零点と多項式係数は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、重複度差は ",
        math(String.raw`\mathbb Z`),
        " に属し、複素平面への埋め込み、数値近似、距離、偏角、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_definition_two_stage_fisher_zero_multiplicity_difference_formal_divisor",
    kind: "definition",
    title: { text: "商の塔に沿う二段 Fisher 零点重複度差の形式的因子" },
    labels: ["def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor"],
    habitat: "Qbar",
    verification: ["sagemath/check/two-stage-quotient-tower-fisher-zero-multiplicity-difference-formal-divisor"],
    statement: [
      paragraph([
        ref("theorem_quotient_tower_two_stage_fisher_zero_multiplicity_difference_finite_support"),
        " の有限台と ",
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map"),
        " の整数値写像を用いる。記号 ",
        math(String.raw`[\alpha]`),
        " を各 ",
        math(String.raw`\alpha\in\overline{\mathbb Q}`),
        " に付随する形式的生成元とし、二段 Fisher 零点重複度差の形式的因子を",
      ]),
      displayMath(String.raw`\operatorname{Div}_{\Delta\mu}(\mathcal T)
:=
\sum_{\alpha\in\operatorname{Supp}_{\Delta\mu_{\mathcal T}}}
\Delta\mu_{\mathcal T}(\alpha)[\alpha]
\in
\bigoplus_{\alpha\in\overline{\mathbb Q}}
\mathbb Z[\alpha]`),
      paragraph([
        "で定める。右辺は有限台にわたる有限和であり、各係数 ",
        math(String.raw`\Delta\mu_{\mathcal T}(\alpha)`),
        " は整数である。したがって形式的因子は ",
        math(String.raw`\overline{\mathbb Q}`),
        " で添字付けた自由アーベル群の一意な元として定まる。共通零点で細段と粗段の重複度が等しい場合、その係数は零であり、有限台にも形式和にも現れない。複素平面への埋め込み、数値近似、距離、偏角、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_two_stage_fisher_zero_formal_divisor_stage_difference",
    kind: "theorem",
    title: { text: "二段 Fisher 零点形式的因子の段別差表示" },
    labels: ["theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_stage_difference"],
    habitat: "Qbar",
    verification: ["sagemath/check/two-stage-quotient-tower-fisher-zero-formal-divisor-stage-difference"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map"),
        " の二段 Fisher 零点重複度と ",
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map"),
        " の自然数から整数への標準単射、および ",
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor"),
        " の形式的因子について、",
      ]),
      displayMath(String.raw`\operatorname{Div}_{\Delta\mu}(\mathcal T)
=
\sum_{\substack{
  \alpha\in\overline{\mathbb Q}\\
  \overline P_{\mathrm{fine}}(\alpha)=0
}}
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{fine}}(\alpha)
\right)[\alpha]
-
\sum_{\substack{
  \alpha\in\overline{\mathbb Q}\\
  \overline P_{\mathrm{coarse}}(\alpha)=0
}}
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{coarse}}(\alpha)
\right)[\alpha]`),
      paragraph([
        "が ",
        math(String.raw`\overline{\mathbb Q}`),
        " で添字付けた自由アーベル群 ",
        math(String.raw`\bigoplus_{\alpha\in\overline{\mathbb Q}}\mathbb Z[\alpha]`),
        " の等式として成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor"),
        " より",
      ]),
      displayMath(String.raw`\operatorname{Div}_{\Delta\mu}(\mathcal T)
=
\sum_{\alpha\in\operatorname{Supp}_{\Delta\mu_{\mathcal T}}}
\Delta\mu_{\mathcal T}(\alpha)[\alpha]
\quad\bigl(\because\ \text{二段重複度差の形式的因子の定義}\bigr).`),
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map"),
        " より、有限集合 ",
        math(String.raw`\mathcal Z_{\mathcal T}`),
        " 上で零係数を補うと",
      ]),
      displayMath(String.raw`\sum_{\alpha\in\operatorname{Supp}_{\Delta\mu_{\mathcal T}}}
\Delta\mu_{\mathcal T}(\alpha)[\alpha]
=
\sum_{\alpha\in\mathcal Z_{\mathcal T}}
\left(
  \iota_{\mathbb N,\mathbb Z}
  \left(
    \mu_{\mathrm{fine}}(\alpha)
  \right)
  -
  \iota_{\mathbb N,\mathbb Z}
  \left(
    \mu_{\mathrm{coarse}}(\alpha)
  \right)
\right)[\alpha]
\quad\bigl(\because\ \text{台の外では重複度差が零である}\bigr).`),
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map"),
        " の零延長された二つの重複度写像と、有限和における分配律より",
      ]),
      displayMath(String.raw`\sum_{\alpha\in\mathcal Z_{\mathcal T}}
\left(
  \iota_{\mathbb N,\mathbb Z}
  \left(
    \mu_{\mathrm{fine}}(\alpha)
  \right)
  -
  \iota_{\mathbb N,\mathbb Z}
  \left(
    \mu_{\mathrm{coarse}}(\alpha)
  \right)
\right)[\alpha]
=
\sum_{\substack{
  \alpha\in\overline{\mathbb Q}\\
  \overline P_{\mathrm{fine}}(\alpha)=0
}}
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{fine}}(\alpha)
\right)[\alpha]
-
\sum_{\substack{
  \alpha\in\overline{\mathbb Q}\\
  \overline P_{\mathrm{coarse}}(\alpha)=0
}}
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{coarse}}(\alpha)
\right)[\alpha]
\quad\bigl(\because\ \text{各段の零点台外では対応する重複度が零である}\bigr).`),
      paragraph([
        "各零点台は有限であり、各重複度と重複度差は整数である。したがって全ての和は ",
        math(String.raw`\bigoplus_{\alpha\in\overline{\mathbb Q}}\mathbb Z[\alpha]`),
        " の有限和として定まる。複素平面への埋め込み、数値近似、距離、偏角、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_two_stage_fisher_zero_formal_divisor_coefficient_sum",
    kind: "theorem",
    title: { text: "二段 Fisher 零点形式的因子の係数総和" },
    labels: ["theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_coefficient_sum"],
    habitat: "Z",
    verification: ["sagemath/check/two-stage-quotient-tower-fisher-zero-formal-divisor-coefficient-sum"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor"),
        " の形式的因子について、係数の総和は二段の Ising 分配多項式の次数差に等しい。すなわち",
      ]),
      displayMath(String.raw`\sum_{\alpha\in\operatorname{Supp}_{\Delta\mu_{\mathcal T}}}
\Delta\mu_{\mathcal T}(\alpha)
=
\deg P_{\mathrm{fine}}-\deg P_{\mathrm{coarse}}
\in\mathbb Z.`),
    ],
    proof: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map"),
        " の零延長された整数値重複度差を用いると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\alpha\in\operatorname{Supp}_{\Delta\mu_{\mathcal T}}}
\Delta\mu_{\mathcal T}(\alpha)
&=
\sum_{\alpha\in\mathcal Z_{\mathcal T}}
\Delta\mu_{\mathcal T}(\alpha)
\quad\bigl(\because\ \text{台の外では重複度差が零である}\bigr),\\
&=
\sum_{\alpha\in\mathcal Z_{\mathcal T}}
\left(
  \iota_{\mathbb N,\mathbb Z}
  \left(
    \mu_{\mathrm{fine}}(\alpha)
  \right)
  -
  \iota_{\mathbb N,\mathbb Z}
  \left(
    \mu_{\mathrm{coarse}}(\alpha)
  \right)
\right)
\quad\bigl(\because\ \text{二段重複度差写像の定義}\bigr),\\
&=
\sum_{\alpha\in\mathcal Z_{\mathcal T}}
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{fine}}(\alpha)
\right)
-
\sum_{\alpha\in\mathcal Z_{\mathcal T}}
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{coarse}}(\alpha)
\right)
\quad\bigl(\because\ \text{整数の有限和に対する分配律}\bigr),\\
&=
\sum_{\substack{
  \alpha\in\overline{\mathbb Q}\\
  \overline P_{\mathrm{fine}}(\alpha)=0
}}
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{fine}}(\alpha)
\right)
-
\sum_{\substack{
  \alpha\in\overline{\mathbb Q}\\
  \overline P_{\mathrm{coarse}}(\alpha)=0
}}
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{coarse}}(\alpha)
\right)
\quad\bigl(\because\ \text{各段の零点台外では対応する重複度が零である}\bigr),\\
&=
\deg P_{\mathrm{fine}}-\deg P_{\mathrm{coarse}}
\quad\bigl(\because\ \text{代数閉体上で零点重複度の総和は非零多項式の次数に等しい}\bigr).
\end{aligned}`),
      paragraph([
        "二つの多項式は正の定数項をもつ非零な整係数多項式である。各次数は自然数、その差と各重複度差は整数であり、全ての和は有限である。複素平面への埋め込み、数値近似、距離、偏角、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "quotient_tower_theorem_two_stage_fisher_zero_formal_divisor_vanishing_criterion",
    kind: "theorem",
    title: { text: "二段 Fisher 零点形式的因子の消滅条件" },
    labels: ["theorem_quotient_tower_two_stage_fisher_zero_formal_divisor_vanishing_criterion"],
    habitat: "Qbar",
    verification: ["sagemath/check/two-stage-quotient-tower-fisher-zero-formal-divisor-vanishing-criterion"],
    statement: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor"),
        " の形式的因子について、",
        math(String.raw`a_{\mathrm{fine}},a_{\mathrm{coarse}}\in\overline{\mathbb Q}^{\times}`),
        " をそれぞれ ",
        math(String.raw`\overline P_{\mathrm{fine}},\overline P_{\mathrm{coarse}}\in\overline{\mathbb Q}[x]`),
        " の最高次係数とすると、",
      ]),
      displayMath(String.raw`\operatorname{Div}_{\Delta\mu}(\mathcal T)=0
\quad\Longleftrightarrow\quad
a_{\mathrm{coarse}}\overline P_{\mathrm{fine}}(x)
=
a_{\mathrm{fine}}\overline P_{\mathrm{coarse}}(x)
\quad\text{in }\overline{\mathbb Q}[x].`),
      paragraph([
        "したがって形式的因子が零であることは、細段と粗段の分配多項式が非零定数倍だけ異なることと同値である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map"),
        " で示した正の定数項により二つの多項式は非零である。代数閉体 ",
        math(String.raw`\overline{\mathbb Q}`),
        " 上の一次因子分解から、各 ",
        math(String.raw`s\in\{\mathrm{fine},\mathrm{coarse}\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline P_s(x)
&=
a_s
\prod_{\substack{
  \alpha\in\overline{\mathbb Q}\\
  \overline P_s(\alpha)=0
}}
(x-\alpha)^{\mu_s(\alpha)}
\quad\bigl(\because\ \overline{\mathbb Q}[x]\text{ における一次因子分解}\bigr),\\
&=
a_s
\prod_{\alpha\in\mathcal Z_{\mathcal T}}
(x-\alpha)^{\mu_s(\alpha)}
\quad\bigl(\because\ \text{各段の零点台外では対応する重複度が零である}\bigr).
\end{aligned}`),
      paragraph([
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map"),
        " と ",
        ref("def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor"),
        " を用いると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{Div}_{\Delta\mu}(\mathcal T)=0
&\Longleftrightarrow
\Delta\mu_{\mathcal T}(\alpha)=0
\text{ for every }\alpha\in\mathcal Z_{\mathcal T}
\quad\bigl(\because\ \text{形式的生成元の一次独立性}\bigr),\\
&\Longleftrightarrow
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{fine}}(\alpha)
\right)
-
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{coarse}}(\alpha)
\right)
=0
\text{ for every }\alpha\in\mathcal Z_{\mathcal T}
\quad\bigl(\because\ \text{二段重複度差写像の定義}\bigr),\\
&\Longleftrightarrow
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{fine}}(\alpha)
\right)
=
\iota_{\mathbb N,\mathbb Z}
\left(
  \mu_{\mathrm{coarse}}(\alpha)
\right)
\text{ for every }\alpha\in\mathcal Z_{\mathcal T}
\quad\bigl(\because\ \text{整数加法の消去律}\bigr),\\
&\Longleftrightarrow
\mu_{\mathrm{fine}}(\alpha)=\mu_{\mathrm{coarse}}(\alpha)
\text{ for every }\alpha\in\mathcal Z_{\mathcal T}
\quad\bigl(\because\ \iota_{\mathbb N,\mathbb Z}\text{ の単射性}\bigr),\\
&\Longleftrightarrow
\prod_{\alpha\in\mathcal Z_{\mathcal T}}
(x-\alpha)^{\mu_{\mathrm{fine}}(\alpha)}
=
\prod_{\alpha\in\mathcal Z_{\mathcal T}}
(x-\alpha)^{\mu_{\mathrm{coarse}}(\alpha)}
\quad\bigl(\because\ \overline{\mathbb Q}[x]\text{ におけるモニック多項式の一意な一次因子分解}\bigr),\\
&\Longleftrightarrow
a_{\mathrm{coarse}}\overline P_{\mathrm{fine}}(x)
=
a_{\mathrm{fine}}\overline P_{\mathrm{coarse}}(x)
\quad\bigl(\because\ \text{上の二つの一次因子分解}\bigr).
\end{aligned}`),
      paragraph([
        "二つの最高次係数は ",
        math(String.raw`\overline{\mathbb Q}^{\times}`),
        "、零点は ",
        math(String.raw`\overline{\mathbb Q}`),
        "、重複度は ",
        math(String.raw`\mathbb N`),
        "、重複度差は ",
        math(String.raw`\mathbb Z`),
        " に属する。全ての積と和は有限であり、複素平面への埋め込み、数値近似、距離、偏角、極限、積分を用いない。",
      ]),
    ],
  },
]);
