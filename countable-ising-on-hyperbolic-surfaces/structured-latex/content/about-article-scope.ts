import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "foundations_definition_field_with_two_elements",
    kind: "definition",
    title: { text: "二元体" },
    labels: ["def_field_with_two_elements"],
    habitat: "finite",
    statement: [
      paragraph(["二元集合 ", math(String.raw`\mathbb F_2:=\{0,1\}`), " の加法と乗法を"]),
      displayMath(String.raw`\begin{array}{c|cc}+&0&1\\\hline0&0&1\\1&1&0\end{array}\qquad
\begin{array}{c|cc}\cdot&0&1\\\hline0&0&0\\1&0&1\end{array}`),
      paragraph(["で定める。以後の ", math(String.raw`\mathbb F_2`), " 上の和、行列、線形写像、ベクトル空間はこの演算を用いる。"]),
    ],
  },
  {
    id: "foundations_definition_finite_group_notation",
    kind: "definition",
    title: { text: "有限群の記法" },
    labels: ["def_finite_group_notation"],
    habitat: "finite",
    statement: [
      paragraph(["有限群 ", math(String.raw`(G,\cdot,1_G,(-)^{-1})`), " に対し、部分群を ", math(String.raw`H\leq G`), " と書く。有限集合 ", math(String.raw`S\subseteq G`), " を含む最小の部分群を ", math(String.raw`\langle S\rangle`), " とし、", math(String.raw`\langle g_1,\ldots,g_m\rangle:=\langle\{g_1,\ldots,g_m\}\rangle`), " と略記する。", math(String.raw`g^0:=1_G`), "、", math(String.raw`g^{n+1}:=g\cdot g^n`), " とし、"]),
      displayMath(String.raw`\operatorname{ord}_G(g):=\min\{n\in\mathbb N_{>0}\mid g^n=1_G\}`),
      paragraph(["と定める。群が文脈から一意なとき添字 ", math("G"), " を省く。"]),
    ],
  },
  {
    id: "foundations_definition_finite_permutation_group_notation",
    kind: "definition",
    title: { text: "有限置換群の記法" },
    labels: ["def_finite_permutation_group_notation"],
    habitat: "finite",
    statement: [paragraph(["空でない有限集合 ", math(String.raw`\Omega`), " に対し、", math(String.raw`\operatorname{Sym}(\Omega)`), " を ", math(String.raw`\Omega`), " から自身への全単射全体とし、積を写像の合成 ", math(String.raw`(gk)(\alpha):=g(k(\alpha))`), " とする。単位元を ", math(String.raw`\operatorname{id}_{\Omega}`), " と書く。これは ", ref("def_finite_group_notation"), " の有限群である。"])],
  },
  {
    id: "foundations_definition_finite_group_action_and_transitivity",
    kind: "definition",
    title: { text: "有限群作用と推移性" },
    labels: ["def_finite_group_action_and_transitivity"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_finite_permutation_group_notation"), " の ", math(String.raw`Q\leq\operatorname{Sym}(\Omega)`), " に対し、評価写像 ", math(String.raw`Q\times\Omega\to\Omega`), "、", math(String.raw`(g,\alpha)\mapsto g(\alpha)`), " を ", math(String.raw`Q\curvearrowright\Omega`), " と書く。この作用が推移的であるとは"]),
      displayMath(String.raw`\forall\alpha,\beta\in\Omega\quad\exists g\in Q\quad g(\alpha)=\beta`),
      paragraph(["が成り立つことと定める。"]),
    ],
  },
  {
    id: "foundations_definition_left_coset_set",
    kind: "definition",
    title: { text: "左剰余類集合" },
    labels: ["def_left_coset_set"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_finite_group_notation"), " の有限群 ", math("Q"), " と部分群 ", math(String.raw`H\leq Q`), " に対し、", math(String.raw`g\in Q`), " の左剰余類と左剰余類集合を"]),
      displayMath(String.raw`gH:=\{gh\mid h\in H\},\qquad Q/H:=\{gH\mid g\in Q\}`),
      paragraph(["と定める。", math(String.raw`Q/H`), " の元は代表元ではなく ", math("Q"), " の部分集合である。"]),
    ],
  },
  {
    id: "article_scope_definition_finite_quotient_cellulation_candidate",
    kind: "definition",
    title: { text: "有限置換商から得るセル分割候補" },
    labels: ["def_finite_quotient_cellulation_candidate"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_hyperbolic_triangle_permutation_quotient_input"), " の有限置換商入力 ", math(String.raw`\mathcal Q_{p,q}`), " と、", ref("def_finite_quotient_oriented_coset_edge_endpoint_data"), " の辺剰余類代表元選択 ", math(String.raw`\eta_E`), " を入力とする。", ref("def_finite_quotient_role_stabilizers_and_coset_cell_sets"), " のセル集合、", ref("def_finite_quotient_oriented_coset_edge_endpoint_data"), " の端点写像、", ref("def_finite_quotient_face_cyclic_position_system"), " の巡回位置系、", ref("def_finite_quotient_oriented_coset_face_boundary_word"), " の境界語を一つの有限データにまとめて"]),
      displayMath(String.raw`\mathcal X(\mathcal Q_{p,q},\eta_E):=\left(
(\mathcal V_Q,\mathcal E_Q,\partial_{Q,\eta_E}),
(\mathcal V_Q,\mathcal E_Q,\mathcal F_Q),
\left(P_f^Q,\partial_{\mathrm{word}}^{Q,\eta_E}f\right)_{f\in\mathcal F_Q}
\right),`),
      paragraph(["さらに、面境界語の巡回順序を指定する写像の族も合わせたデータを"]),
      displayMath(String.raw`\mathcal C(\mathcal Q_{p,q},\eta_E):=\left(
\mathcal X(\mathcal Q_{p,q},\eta_E),
\left(s_f^Q\right)_{f\in\mathcal F_Q}
\right)`),
      paragraph(["と定め、有限置換商から得るセル分割候補と呼ぶ。この定義だけでは、", ref("def_oriented_closed_surface_cellulation"), " の有限述語が真であるとは主張しない。"]),
    ],
  },
  {
    id: "article_scope_definition_finite_quotient_combinatorially_hyperbolic_cellulation",
    kind: "definition",
    title: { text: "有限置換商由来の組合せ的双曲セル分割" },
    labels: ["def_finite_quotient_combinatorially_hyperbolic_cellulation"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_finite_quotient_cellulation_candidate"), " の有限データ ", math(String.raw`\mathcal C(\mathcal Q_{p,q},\eta_E)`), " を取る。このデータが有限置換商由来の組合せ的双曲セル分割であるとは、"]),
      displayMath(String.raw`\operatorname{OrientedClosedSurfaceCellulation}\!\left(
(\mathcal V_Q,\mathcal E_Q,\partial_{Q,\eta_E}),
(\mathcal V_Q,\mathcal E_Q,\mathcal F_Q),
\left(\partial_{\mathrm{word}}^{Q,\eta_E}f\right)_{f\in\mathcal F_Q}
\right)=\mathrm{true}`),
      paragraph(["かつ"]),
      displayMath(String.raw`(p,q)\in
\operatorname{HyperbolicRegularTypes}
\left(\mathcal X(\mathcal Q_{p,q},\eta_E)\right)`),
      paragraph(["が成り立つことと定める。前者は有限セルの incidence と頂点リンクの有限検査、後者は自然数不等式 ", math(String.raw`2(p+q)<pq`), " の検査である。本論文の定理はこの有限データに対する主張であり、滑らかな曲面、Riemann 計量、曲率、測地線、実数座標を入力にも結論にも含めない。曲率マイナス一の計量的実現は、本論文の有限恒等式とは独立な外部の幾何学的解釈である。"]),
    ],
  },
]);
