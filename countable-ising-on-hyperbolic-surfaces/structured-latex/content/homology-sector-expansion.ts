import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
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
]);
