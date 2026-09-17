/**
 * 有限集合上の二体写像に対する Yang--Baxter 条件を、有限写像の等号として定義し、
 * 連続スペクトルパラメータを導入する前に有限決定できる範囲を確定する。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_yang_baxter_decision_definition_pair_map",
    kind: "definition",
    title: { text: "有限集合上の二体写像" },
    labels: ["def_finite_pair_map"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`X`), " を元数 ", math(String.raw`n:=|X|\in\mathbb N`),
        " の有限集合とする。写像 ", math(String.raw`R:X\times X\to X\times X`),
        " を有限二体写像と呼ぶ。有限二体写像全体は有限集合であり、その元数は",
      ]),
      displayMath(String.raw`\left|(X\times X)^{X\times X}\right|=(n^2)^{n^2}`),
      paragraph([
        "である。ここでは ", math(String.raw`X`), " に加法、積、位相、確率、外在的な解釈を仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_definition_adjacent_lifts",
    kind: "definition",
    title: { text: "三体直積上の隣接持ち上げ" },
    labels: ["def_finite_pair_map_adjacent_lifts"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_pair_map"), " の ", math(String.raw`R`), " に対し、写像 ",
        math(String.raw`R_{12},R_{23}:X^3\to X^3`), " を次で定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
R(x,y)&=\bigl(R_1(x,y),R_2(x,y)\bigr),\\
R_{12}(x,y,z)&=\bigl(R_1(x,y),R_2(x,y),z\bigr),\\
R_{23}(x,y,z)&=\bigl(x,R_1(y,z),R_2(y,z)\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`R_1,R_2:X\times X\to X`),
        " はそれぞれ ", math(String.raw`R`), " の第一成分と第二成分である。直積と成分射影以外の演算は使わない。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_definition_condition",
    kind: "definition",
    title: { text: "有限 Yang–Baxter 条件" },
    labels: ["def_finite_yang_baxter_map"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_pair_map_adjacent_lifts"), " の二体写像 ", math(String.raw`R`), " が",
      ]),
      displayMath(String.raw`R_{12}\circ R_{23}\circ R_{12}
=R_{23}\circ R_{12}\circ R_{23}:X^3\to X^3`),
      paragraph([
        "を満たすとき、", math(String.raw`R`), " を有限 Yang--Baxter 写像と呼ぶ。",
        "合成は右端の写像から適用する。この定義は一つの有限写像の等号であり、",
        "実数体、複素数体、行列、スペクトルパラメータを仮定しない。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_claim_decidable",
    kind: "claim",
    title: { text: "有限 Yang–Baxter 条件は三体入力の全走査で決定できる" },
    labels: ["claim_finite_yang_baxter_condition_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_yang_baxter_map"), " の条件は、全ての ",
        math(String.raw`(x,y,z)\in X^3`), " について両辺の値を比較する有限手続きで決定できる。",
        "比較する入力はちょうど ", math(String.raw`|X^3|=n^3`), " 個である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X`), " は有限集合なので ", math(String.raw`X^3`),
        " も有限集合であり、その元数は ", math(String.raw`n^3`), " である。各 ",
        math(String.raw`t\in X^3`), " について、有限表 ", math(String.raw`R`),
        " を三回引けば二つの合成写像の値をそれぞれ計算できる。",
      ]),
      paragraph(["全入力で値が等しいなら有限写像の外延性により"]),
      displayMath(String.raw`R_{12}\circ R_{23}\circ R_{12}
=R_{23}\circ R_{12}\circ R_{23}`),
      paragraph([
        "である。逆にこの写像等式が成り立つなら各入力で値が等しい。従って全 ",
        math(String.raw`n^3`), " 入力の比較と条件は同値であり、有限手続きで決定できる。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_claim_swap_example",
    kind: "claim",
    title: { text: "成分交換は有限 Yang–Baxter 写像である" },
    labels: ["claim_finite_swap_is_yang_baxter"],
    habitat: "finite",
    statement: [
      paragraph([
        "任意の有限集合 ", math(String.raw`X`), " について、",
        math(String.raw`S:X\times X\to X\times X`), " を ",
        math(String.raw`S(x,y):=(y,x)`), " と定めると、", math(String.raw`S`),
        " は有限 Yang--Baxter 写像である。",
      ]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`(x,y,z)\in X^3`), " について"]),
      displayMath(String.raw`\begin{aligned}
(S_{12}\circ S_{23}\circ S_{12})(x,y,z)
&=(z,y,x),\\
(S_{23}\circ S_{12}\circ S_{23})(x,y,z)
&=(z,y,x).
\end{aligned}`),
      paragraph([
        "従って二つの写像は全入力で一致し、",
        ref("def_finite_yang_baxter_map"), " の条件を満たす。",
      ]),
    ],
  },
  {
    id: "finite_yang_baxter_decision_claim_two_element_counterexample",
    kind: "claim",
    title: { text: "二元集合上でも有限 Yang–Baxter 条件は自動ではない" },
    labels: ["claim_two_element_pair_map_not_always_yang_baxter"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`B:=\{0,1\}`), " とし、二体写像 ",
        math(String.raw`Q:B\times B\to B\times B`), " を",
      ]),
      displayMath(String.raw`Q(0,0)=Q(0,1)=Q(1,0)=(0,0),\qquad Q(1,1)=(0,1)`),
      paragraph([
        "と定める。このとき ", math(String.raw`Q`), " は有限 Yang--Baxter 写像ではない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(Q_{12}\circ Q_{23}\circ Q_{12})(1,1,1)
&=(0,0,1),\\
(Q_{23}\circ Q_{12}\circ Q_{23})(1,1,1)
&=(0,0,0).
\end{aligned}`),
      paragraph([
        "一つの入力で値が異なるので、", ref("def_finite_yang_baxter_map"),
        " の有限写像等式は成り立たない。",
      ]),
    ],
  },
]);
