import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "foundations_definition_natural_numbers",
    kind: "definition",
    title: { text: "自然数と正整数" },
    labels: ["def_natural_numbers"],
    habitat: "finite",
    statement: [paragraph([math(String.raw`0:=\varnothing`), "、", math(String.raw`\operatorname{succ}(n):=n\cup\{n\}`), " とする。", math(String.raw`\mathbb N`), " を ", math("0"), " を含み後者の写像で閉じる最小の集合とし、", math(String.raw`1:=\operatorname{succ}(0)`), "、", math(String.raw`\mathbb N_{>0}:=\mathbb N\setminus\{0\}`), "、", math(String.raw`\mathbb N_{>1}:=\mathbb N\setminus\{0,1\}`), " と定める。"])],
  },
  {
    id: "foundations_definition_size_universe",
    kind: "definition",
    title: { text: "集合の大きさを固定する宇宙" },
    labels: ["def_size_universe"],
    habitat: "mixed",
    realEscape: "後続の位相的・計量的入力を一つの集合内に置くための集合論的な大きさの固定だけであり、物理的実数演算は行わない。",
    statement: [paragraph([ref("def_natural_numbers"), " の ", math(String.raw`\mathbb N`), " と後続の全ての位相的・計量的入力を含み、元を取る操作、冪集合、添字集合も属する族の和集合について閉じた Grothendieck 宇宙 ", math(String.raw`\mathcal U`), " を一つ固定する。以下の集合は ", math(String.raw`\mathcal U`), " の元に限る。"])],
  },
  {
    id: "foundations_definition_finite_subset_constructor",
    kind: "definition",
    title: { text: "有限部分集合の集合" },
    labels: ["def_finite_subset_constructor"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_size_universe"), " の集合 ", math(String.raw`A\in\mathcal U`), " に対し、その有限部分集合全体を"]),
      displayMath(String.raw`\mathcal P_{\mathrm{fin}}(A):=\{B\subseteq A\mid B\text{ は有限集合}\}`),
      paragraph(["と定める。"])],
  },
  {
    id: "foundations_definition_base_sets_and_finite_constructors",
    kind: "definition",
    title: { text: "順序対と直積" },
    labels: ["def_base_sets_and_finite_constructors"],
    habitat: "finite",
    statement: [
      paragraph(["二つの集合 ", math("A,B"), " と元 ", math(String.raw`a\in A,b\in B`), " に対し、順序対を ", math(String.raw`\langle a,b\rangle:=\{\{a\},\{a,b\}\}`), "、直積を"]),
      displayMath(String.raw`A\times B:=\{\langle a,b\rangle\mid a\in A,\ b\in B\}`),
      paragraph(["と定める。有限部分集合には ", ref("def_finite_subset_constructor"), " の記法を用いる。"])],
  },
  {
    id: "foundations_definition_field_with_two_elements",
    kind: "definition",
    title: { text: "二元体" },
    labels: ["def_field_with_two_elements"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_natural_numbers"), " の相異なる二元 ", math(String.raw`0,1\in\mathbb N`), " からなる集合 ", math(String.raw`\mathbb F_2:=\{0,1\}`), " に加法と乗法を"]),
      displayMath(String.raw`\begin{array}{c|cc}+&0&1\\\hline0&0&1\\1&1&0\end{array}\qquad
\begin{array}{c|cc}\cdot&0&1\\\hline0&0&0\\1&0&1\end{array}`),
      paragraph(["で定める。この演算をもつ集合を二元体と呼ぶ。以後の ", math(String.raw`\mathbb F_2`), " 上の和、行列、線形写像、ベクトル空間はこの二つの演算を用いる。"])],
  },
  {
    id: "foundations_definition_hereditarily_finite_data_over_naturals",
    kind: "definition",
    title: { text: "自然数上の遺伝的有限データ" },
    labels: ["def_hereditarily_finite_data_over_naturals"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_base_sets_and_finite_constructors"), " の有限構成を用いる。階層 ", math(String.raw`(\operatorname{HF}_n(\mathbb N))_{n\in\mathbb N}`), " を"]),
      displayMath(String.raw`\begin{aligned}
\operatorname{HF}_0(\mathbb N)&:=\mathbb N,\\
\operatorname{HF}_{n+1}(\mathbb N)&:=\operatorname{HF}_n(\mathbb N)
\cup\mathcal P_{\mathrm{fin}}\!\left(\operatorname{HF}_n(\mathbb N)\right)
\cup\left(\operatorname{HF}_n(\mathbb N)\times\operatorname{HF}_n(\mathbb N)\right)
\qquad(n\in\mathbb N)
\end{aligned}`),
      paragraph(["で再帰的に定め、自然数上の遺伝的有限データの集合を"]),
      displayMath(String.raw`\operatorname{HF}(\mathbb N):=\bigcup_{n\in\mathbb N}\operatorname{HF}_n(\mathbb N)`),
      paragraph(["と定める。右辺は既に定めた階層の和集合であり、", math(String.raw`\operatorname{HF}(\mathbb N)`), " 自身を定義に使用しない。"])],
  },
  {
    id: "foundations_definition_finite_group_notation",
    kind: "definition",
    title: { text: "有限群の記法" },
    labels: ["def_finite_group_notation"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_natural_numbers"), " の自然数を冪の添字に用い、", ref("def_base_sets_and_finite_constructors"), " の順序付き組として有限群 ", math(String.raw`(G,\cdot,1_G,(-)^{-1})`), " に対し、部分集合 ", math(String.raw`H\subseteq G`), " が積、逆元、単位元で閉じるとき ", math(String.raw`H\leq G`), " と書く。有限集合 ", math(String.raw`S\subseteq G`), " を含む最小の部分群を ", math(String.raw`\langle S\rangle`), " とし、略記 ", math(String.raw`\langle g_1,\ldots,g_m\rangle:=\langle\{g_1,\ldots,g_m\}\rangle`), " を用いる。", math(String.raw`g^0:=1_G`), "、", math(String.raw`g^{n+1}:=g\cdot g^n`), " とし、"]),
      displayMath(String.raw`\operatorname{ord}_G(g):=\min\{n\in\mathbb N_{>0}\mid g^n=1_G\}`),
      paragraph(["と定める。群が文脈から一意なとき添字 ", math("G"), " を省く。"])],
  },
  {
    id: "foundations_definition_finite_permutation_group_notation",
    kind: "definition",
    title: { text: "有限置換群の記法" },
    labels: ["def_finite_permutation_group_notation"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_hereditarily_finite_data_over_naturals"), " の中の空でない有限集合 ", math(String.raw`\Omega\in\mathcal P_{\mathrm{fin}}(\operatorname{HF}(\mathbb N))`), " に対し、", math(String.raw`\operatorname{Sym}(\Omega)`), " を ", math(String.raw`\Omega`), " から自身への全単射全体とし、積を写像の合成 ", math(String.raw`(gk)(\alpha):=g(k(\alpha))`), " とする。その単位元を ", math(String.raw`\operatorname{id}_{\Omega}`), " と書く。これは ", ref("def_finite_group_notation"), " の有限群であり、部分群、生成部分群、冪、位数には同定義の記法を用いる。"])],
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
      paragraph(["が成り立つことと定める。"])],
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
      paragraph(["と定める。", math(String.raw`Q/H`), " の元は代表元ではなく ", math("Q"), " の部分集合である。"])],
  },
  {
    id: "article_scope_definition_finite_quotient_cellulation_candidate",
    kind: "definition",
    title: { text: "有限置換商から得るセル分割候補" },
    labels: ["def_finite_quotient_cellulation_candidate"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_hyperbolic_triangle_permutation_quotient_input"), " の有限置換商入力 ", math(String.raw`\mathcal Q_{p,q}`), " と、", ref("def_finite_quotient_oriented_coset_edge_endpoint_data"), " の辺剰余類代表元選択 ", math(String.raw`\eta_E`), " を入力とする。", ref("def_finite_quotient_role_stabilizers_and_coset_cell_sets"), " のセル集合、", ref("def_finite_quotient_oriented_coset_edge_endpoint_data"), " の端点写像、", ref("def_finite_quotient_face_cyclic_position_system"), " の巡回位置系、", ref("def_finite_quotient_oriented_coset_face_boundary_word"), " の境界語を、一般セル分割データと同じ型の一つの有限データにまとめて"]),
      displayMath(String.raw`\mathcal C(\mathcal Q_{p,q},\eta_E):=\left(
(\mathcal V_Q,\mathcal E_Q,\partial_{Q,\eta_E}),
(\mathcal V_Q,\mathcal E_Q,\mathcal F_Q),
\left(P_f^Q,s_f^Q,\partial_{\mathrm{word}}^{Q,\eta_E}f\right)_{f\in\mathcal F_Q}
\right)`),
      paragraph(["と定め、有限置換商から得るセル分割候補と呼ぶ。これが向き付き閉曲面セル分割であるとは、", ref("def_oriented_closed_surface_cellulation"), " の有限述語が真であることを意味する。この定義だけでは、その述語が真であるとは主張しない。"])],
  },
  {
    id: "article_scope_definition_topological_realization_of_cellulation",
    kind: "definition",
    title: { text: "有限セル分割の位相的実現データ" },
    labels: ["def_topological_realization_of_cellulation"],
    habitat: "mixed",
    realEscape: "有限セルデータから位相空間を作る商位相だけを用いる。計量、曲率、極限、積分は用いない。",
    statement: [
      paragraph([ref("def_oriented_closed_surface_cellulation"), " の有限述語を満たすセル分割データ ", math(String.raw`\mathcal C=(G,\mathcal C_{\mathrm{cell}},(P_f,s_f,\partial_{\mathrm{word}}f)_{f\in F_{\mathrm{cell}}})`), " に対する位相的実現データを ", math(String.raw`\mathcal R=(S,\phi_V,(\phi_e)_{e\in E_{\mathrm{cell}}},(D_f,\phi_f)_{f\in F_{\mathrm{cell}}})`), " と定める。ここで ", math("S"), " は連結な向き付き閉滑らか二次元多様体、", math(String.raw`\phi_V:V_{\mathrm{cell}}\to S`), " は単射、", math(String.raw`\phi_e:[0,1]\to S`), " は端点が ", math(String.raw`\phi_V(\partial_G(e,\mathsf{source}))`), " と ", math(String.raw`\phi_V(\partial_G(e,\mathsf{target}))`), " である埋込みとする。各 ", math("D_f"), " は境界辺が ", math("P_f"), " で添字付けられ、向き付き境界順が ", math("s_f"), " である閉多角形円板とし、", math(String.raw`\phi_f:D_f\to S`), " は内部で埋込み、各境界辺では ", math(String.raw`\partial_{\mathrm{word}}f`), " が指定する ", math(String.raw`\phi_e`), " またはその逆向きと一致する連続写像とする。開セル像 ", math(String.raw`(\{\phi_V(v)\})_{v\in V_{\mathrm{cell}}}`), "、", math(String.raw`\{\phi_e((0,1))\}_{e\in E_{\mathrm{cell}}}`), "、", math(String.raw`\{\phi_f(\operatorname{int}D_f)\}_{f\in F_{\mathrm{cell}}}`), " は異なる添字・異なる次元を含めて対ごとに互いに素であり、それらの和が ", math("S"), " 全体であることを要求する。"])],
  },
  {
    id: "article_scope_definition_regular_hyperbolic_metric_realization",
    kind: "definition",
    title: { text: "正則双曲計量によるセル分割の実現" },
    labels: ["def_regular_hyperbolic_metric_realization"],
    habitat: "mixed",
    realEscape: "滑らかな曲面、Riemann 計量、測地線、角度、曲率の条件だけが実数を用いる。有限セル分割は有限データである。",
    statement: [
      paragraph([ref("def_topological_realization_of_cellulation"), " の位相的実現データ ", math(String.raw`\mathcal R=(S,\phi_V,(\phi_e)_e,(D_f,\phi_f)_f)`), " と ", math(String.raw`(p,q)\in\mathbb N_{>0}^2`), " に対し、その正則双曲計量実現を対 ", math(String.raw`(\mathcal R,h)`), " であって次を満たすものと定める。", math("h"), " は各接空間上の正定値対称双線形形式が点に滑らかに依存する ", math("S"), " 上の完備 Riemann 計量であり、Gauss 曲率は ", math(String.raw`K_h=-1`), " である。各 ", math(String.raw`\phi_e([0,1])`), " は測地線分であり、各面像 ", math(String.raw`\phi_f(D_f)`), " は辺長が等しく内角が全て ", math(String.raw`2\pi/q`), " である ", math("p"), " 角形とする。この定義は実現の存在を主張しない。"]),
    ],
  },
  {
    id: "article_scope_definition_finite_quotient_regular_cellulated_closed_hyperbolic_surface",
    kind: "definition",
    title: { text: "有限商正則セル分割付き閉双曲曲面" },
    labels: ["def_finite_quotient_regular_cellulated_closed_hyperbolic_surface"],
    habitat: "mixed",
    realEscape: "正則双曲計量実現の成分だけが実数を用いる。有限置換商とセル分割は有限データである。",
    statement: [
      paragraph([ref("def_hyperbolic_triangle_permutation_quotient_input"), " の有限置換商入力 ", math(String.raw`\mathcal Q_{p,q}`), "、辺剰余類代表元選択 ", math(String.raw`\eta_E`), "、", ref("def_finite_quotient_cellulation_candidate"), " のセル分割候補 ", math(String.raw`\mathcal C(\mathcal Q_{p,q},\eta_E)`), "、および ", ref("def_regular_hyperbolic_metric_realization"), " の正則双曲計量実現 ", math(String.raw`(\mathcal R,h)`), " を用いる。有限商正則セル分割付き閉双曲曲面を"]),
      displayMath(String.raw`\left(\mathcal Q_{p,q},\eta_E,\mathcal C(\mathcal Q_{p,q},\eta_E),\mathcal R,h\right)`),
      paragraph(["であって、全成分が固定した宇宙 ", math(String.raw`\mathcal U`), " に属し、セル分割候補が向き付き閉曲面セル分割の有限述語を満たし、", math(String.raw`(\mathcal R,h)`), " がその ", math(String.raw`(p,q)`), " 型正則双曲計量実現であるものと定める。このような組全体は ", math(String.raw`\mathcal U`), " の部分集合なので集合をなし、これを ", math(String.raw`\mathcal H_{\mathrm{fq}}`), " と書く。本論文で有限双曲曲面といった場合は ", math(String.raw`\mathcal H_{\mathrm{fq}}`), " の元を意味する。"]),
    ],
  },
]);
