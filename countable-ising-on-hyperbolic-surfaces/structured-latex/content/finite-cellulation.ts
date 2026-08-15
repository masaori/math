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
]);
