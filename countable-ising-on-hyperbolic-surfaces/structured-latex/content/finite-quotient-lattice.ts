import { defineBlocks, displayMath, math, paragraph } from "../schema.ts";

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
]);
