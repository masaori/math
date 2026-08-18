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
        "空でない有限集合 ",
        math(String.raw`\Omega`),
        " と有限置換群 ",
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
      paragraph([
        "ここで ",
        math(String.raw`A/N_{\mathrm{fine}}`),
        " と ",
        math(String.raw`A/N_{\mathrm{coarse}}`),
        " は左剰余類集合であり、各商の積は ",
        math(String.raw`(aN)(bN):=(ab)N`),
        " で定める。二つの部分群が正規であるため、この積は代表元に依存せず、それぞれ有限群をなす。段ラベルにより二つの商群を同一視しない。",
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
        math(String.raw`\mathcal R:=\{F,V,E\}`),
        " を取る。共通有限群の元の族 ",
        math(String.raw`s=(s_R)_{R\in\mathcal R}\in A^{\mathcal R}`),
        " が",
      ]),
      displayMath(String.raw`A=\langle s_F,s_V,s_E\rangle`),
      paragraph([
        "を満たすとする。各役割 ",
        math(String.raw`R\in\mathcal R`),
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
        math(String.raw`R\in\mathcal R`),
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
      paragraph([
        "ここでは役割名の一致を、名前の使い回しではなく始域と終域をもつ ",
        math(String.raw`\kappa`),
        " による三つの等式として固定する。商で元の位数が小さくなることは許し、各段が双曲型正則セル分割を生成することはこの定義から結論しない。全ての群、元、写像は有限であり、実数、複素数、極限、積分を用いない。",
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
        ref("def_quotient_tower_role_generator_compatibility"),
        " の役割生成元について整合する二段の有限商の塔と、",
        ref("def_finite_quotient_role_stabilizers_and_coset_cell_sets"),
        " の役割安定化部分群と剰余類セル集合の構成を取る。各形式的役割ラベル ",
        math(String.raw`R\in\mathcal R=\{F,V,E\}`),
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
\{\mathtt{fine}\}\times\{R\}\times
\left(Q_{\mathrm{fine}}/H_R^{\mathrm{fine}}\right),\\
\mathcal C_R^{\mathrm{coarse}}
&:=
\{\mathtt{coarse}\}\times\{R\}\times
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
  R,
  gH_R^{\mathrm{fine}}
\right)
&\longmapsto
\left(
  \mathtt{coarse},
  R,
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
    id: "quotient_tower_theorem_coset_cell_incidence_forward_preservation",
    kind: "theorem",
    title: { text: "商の塔における剰余類セル incidence の順方向保存" },
    labels: ["theorem_quotient_tower_coset_cell_incidence_forward_preservation"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-incidence-forward-preservation"],
    statement: [
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導剰余類セル写像を取る。役割対 ",
        math(String.raw`(R,S)\in\{(F,V),(F,E),(V,E)\}`),
        "、元 ",
        math(String.raw`g,k\in Q_{\mathrm{fine}}`),
        "、および細段セル",
      ]),
      displayMath(String.raw`c_R:=
\left(
  \mathtt{fine},
  R,
  gH_R^{\mathrm{fine}}
\right)
\in\mathcal C_R^{\mathrm{fine}},
\qquad
c_S:=
\left(
  \mathtt{fine},
  S,
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
        ref("def_finite_quotient_coset_cell_incidence_relation"),
        " の incidence の定義より、ある ",
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
        ref("def_finite_quotient_coset_cell_incidence_relation"),
        " の incidence の定義と、",
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
  E,
  C_E
\right)
=
\left(
  \mathtt{coarse},
  E,
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
    id: "quotient_tower_theorem_oriented_edge_endpoint_map_preservation",
    kind: "theorem",
    title: { text: "商の塔における向き付き辺端点写像の保存" },
    labels: ["theorem_quotient_tower_oriented_edge_endpoint_map_preservation"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-oriented-edge-endpoint-preservation"],
    statement: [
      paragraph([
        ref("def_quotient_tower_oriented_edge_representative_selector_compatibility"),
        " の整合する代表元選択写像を取る。細段辺剰余類 ",
        math(String.raw`C_E\in Q_{\mathrm{fine}}/H_E^{\mathrm{fine}}`),
        " と粗段辺剰余類 ",
        math(String.raw`D_E\in Q_{\mathrm{coarse}}/H_E^{\mathrm{coarse}}`),
        " が",
      ]),
      displayMath(String.raw`\overline\kappa_E
\left(
  \mathtt{fine},
  E,
  C_E
\right)
=
\left(
  \mathtt{coarse},
  E,
  D_E
\right)`),
      paragraph([
        "を満たすなら、細段の始点と終点を誘導頂点写像で送った結果は、対応する粗段辺の始点と終点にそれぞれ一致する。すなわち、",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline\kappa_V
\left(
  \mathtt{fine},
  V,
  \eta_E^{\mathrm{fine}}(C_E)H_V^{\mathrm{fine}}
\right)
&=
\left(
  \mathtt{coarse},
  V,
  \eta_E^{\mathrm{coarse}}(D_E)H_V^{\mathrm{coarse}}
\right),\\
\overline\kappa_V
\left(
  \mathtt{fine},
  V,
  \eta_E^{\mathrm{fine}}(C_E)r_E^{\mathrm{fine}}H_V^{\mathrm{fine}}
\right)
&=
\left(
  \mathtt{coarse},
  V,
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
  V,
  \eta_E^{\mathrm{fine}}(C_E)H_V^{\mathrm{fine}}
\right)
=
\left(
  \mathtt{coarse},
  V,
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
  V,
  \eta_E^{\mathrm{fine}}(C_E)H_V^{\mathrm{fine}}
\right)
=
\left(
  \mathtt{coarse},
  V,
  \eta_E^{\mathrm{coarse}}(D_E)H_V^{\mathrm{coarse}}
\right).`),
      paragraph([
        ref("def_quotient_tower_induced_coset_cell_maps"),
        " の誘導頂点写像の定義より、終点側は",
      ]),
      displayMath(String.raw`\overline\kappa_V
\left(
  \mathtt{fine},
  V,
  \eta_E^{\mathrm{fine}}(C_E)r_E^{\mathrm{fine}}H_V^{\mathrm{fine}}
\right)
=
\left(
  \mathtt{coarse},
  V,
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
  V,
  \eta_E^{\mathrm{fine}}(C_E)r_E^{\mathrm{fine}}H_V^{\mathrm{fine}}
\right)
=
\left(
  \mathtt{coarse},
  V,
  \eta_E^{\mathrm{coarse}}(D_E)r_E^{\mathrm{coarse}}H_V^{\mathrm{coarse}}
\right).`),
      paragraph([
        "したがって始点と終点はそれぞれ保存される。全ての群、部分群、剰余類、写像、量化範囲は有限であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
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
        ref("def_finite_quotient_face_cyclic_position_system"),
        " の剰余類面の巡回位置系を取る。細段面剰余類 ",
        math(String.raw`C_F\in Q_{\mathrm{fine}}/H_F^{\mathrm{fine}}`),
        " と粗段面剰余類 ",
        math(String.raw`D_F\in Q_{\mathrm{coarse}}/H_F^{\mathrm{coarse}}`),
        " が",
      ]),
      displayMath(String.raw`\overline\kappa_F
\left(
  \mathtt{fine},
  F,
  C_F
\right)
=
\left(
  \mathtt{coarse},
  F,
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
    id: "quotient_tower_theorem_oriented_face_boundary_word_preservation",
    kind: "theorem",
    title: { text: "商の塔における剰余類面の向き付き境界語の保存" },
    labels: ["theorem_quotient_tower_oriented_face_boundary_word_preservation"],
    habitat: "finite",
    verification: ["sagemath/check/two-stage-quotient-tower-oriented-face-boundary-word-preservation"],
    statement: [
      paragraph([
        ref("def_quotient_tower_induced_face_position_map"),
        " の面位置写像と、",
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
  \partial_{\mathrm{word}}^{Q_{\mathrm{fine}},\eta_E^{\mathrm{fine}}}
  f_{\mathrm{fine}}
  \left(
    \mathtt{position},
    a
  \right)
\right)
=
\partial_{\mathrm{word}}^{Q_{\mathrm{coarse}},\eta_E^{\mathrm{coarse}}}
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
  E,
  C_E(a)
\right)
=
\left(
  \mathtt{coarse},
  E,
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
\partial_{\mathrm{word}}^{Q_{\mathrm{fine}},\eta_E^{\mathrm{fine}}}
f_{\mathrm{fine}}
\left(
  \mathtt{position},
  a
\right)
&=
\left(
  (\mathtt{fine},E,C_E(a)),
  \mathsf{reverse}
\right)
&&\bigl(\because\ \text{細段境界語の定義}\bigr),\\
\partial_{\mathrm{word}}^{Q_{\mathrm{coarse}},\eta_E^{\mathrm{coarse}}}
f_{\mathrm{coarse}}
\left(
  \mathtt{position},
  \kappa(a)
\right)
&=
\left(
  (\mathtt{coarse},E,D_E(\kappa(a))),
  \mathsf{reverse}
\right)
&&\bigl(\because\ \text{粗段境界語の定義}\bigr).
\end{aligned}`),
      paragraph([
        "誘導辺セル写像の等式と、形式的向きラベル ",
        math(String.raw`\mathsf{reverse}`),
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
\partial_{\mathrm{word}}^{Q_{\mathrm{fine}},\eta_E^{\mathrm{fine}}}
f_{\mathrm{fine}}
\left(
  \mathtt{position},
  a
\right)
&=
\left(
  (\mathtt{fine},E,C_E(a)),
  \mathsf{forward}
\right)
&&\bigl(\because\ \text{細段境界語の定義}\bigr),\\
\partial_{\mathrm{word}}^{Q_{\mathrm{coarse}},\eta_E^{\mathrm{coarse}}}
f_{\mathrm{coarse}}
\left(
  \mathtt{position},
  \kappa(a)
\right)
&=
\left(
  (\mathtt{coarse},E,D_E(\kappa(a))),
  \mathsf{forward}
\right)
&&\bigl(\because\ \text{粗段境界語の定義}\bigr).
\end{aligned}`),
      paragraph([
        "誘導辺セル写像の等式と、形式的向きラベル ",
        math(String.raw`\mathsf{forward}`),
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
]);
