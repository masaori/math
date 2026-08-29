/**
 * 章「合成冪等な近傍割り当ての特徴づけ」。
 * 合成近傍についての冪等性を、推移性と各近傍辺の二段分解可能性に分ける。
 * 有限集合・有限部分集合・写像だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_composition_idempotents_heading",
    kind: "heading",
    level: 1,
    title: { text: "合成冪等な近傍割り当ての特徴づけ" },
    labels: [],
  },
  {
    id: "neighborhood_assignment_composition_idempotents_definition_idempotent",
    kind: "definition",
    title: { text: "合成冪等な近傍割り当て" },
    labels: ["def_composition_idempotent_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
      ]),
      displayMath(String.raw`N\star N=N`),
      paragraph([
        "が成り立つとき、", math(String.raw`N`), " を合成近傍について冪等と呼ぶ。",
        math(String.raw`\star`), " は ", ref("def_composed_neighborhood"), " の合成近傍である。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_composition_idempotents_definition_transitive",
    kind: "definition",
    title: { text: "推移的な近傍割り当て" },
    labels: ["def_transitive_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), "（", ref("def_finite_neighborhood_assignment_space"),
        "）が推移的であるとは、任意の ",
        math(String.raw`v,u,w\in V`), " について",
      ]),
      displayMath(String.raw`u\in N(v)\ \land\ w\in N(u)\quad\Longrightarrow\quad w\in N(v)`),
      paragraph(["が成り立つことをいう。"])],
  },
  {
    id: "neighborhood_assignment_composition_idempotents_definition_factorable",
    kind: "definition",
    title: { text: "二段分解可能な近傍割り当て" },
    labels: ["def_two_step_factorable_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), "（", ref("def_finite_neighborhood_assignment_space"),
        "）が二段分解可能であるとは、任意の ",
        math(String.raw`v,w\in V`), " について",
      ]),
      displayMath(String.raw`w\in N(v)\quad\Longrightarrow\quad
\exists u\in N(v),\ w\in N(u)`),
      paragraph(["が成り立つことをいう。"])],
  },
  {
    id: "neighborhood_assignment_composition_idempotents_claim_characterization",
    kind: "claim",
    title: { text: "合成冪等性は推移性と二段分解可能性に等しい" },
    labels: ["claim_composition_idempotent_neighborhood_assignment_characterization"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ", math(String.raw`N\in\mathcal N(V)`),
        " について、次の二条件は同値である。",
      ]),
      displayMath(String.raw`N\star N=N`),
      paragraph([
        math(String.raw`N`), " は推移的かつ二段分解可能である。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ", math(String.raw`N\star N=N`), " とする。任意の ",
        math(String.raw`v,u,w\in V`), " について、", math(String.raw`u\in N(v)`),
        " かつ ", math(String.raw`w\in N(u)`), " ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
w
&\in(N\star N)(v)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&\in N(v)\qquad(\because\ N\star N=N)
\end{aligned}`),
      paragraph([
        "なので、", ref("def_transitive_neighborhood_assignment"), " より ",
        math(String.raw`N`), " は推移的である。また任意の ",
        math(String.raw`v,w\in V`), " と ", math(String.raw`w\in N(v)`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
w
&\in(N\star N)(v)\qquad(\because\ N\star N=N)\\
&\Longleftrightarrow \exists u\in N(v),\ w\in N(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})
\end{aligned}`),
      paragraph([
        "なので、", ref("def_two_step_factorable_neighborhood_assignment"), " より ",
        math(String.raw`N`), " は二段分解可能である。",
      ]),
      paragraph([
        "逆に ", math(String.raw`N`), " が推移的かつ二段分解可能であるとする。任意の ",
        math(String.raw`v,w\in V`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in(N\star N)(v)
&\Longrightarrow w\in N(v)
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_transitive_neighborhood_assignment}),\\
w\in N(v)
&\Longrightarrow w\in(N\star N)(v)
  \qquad(\because\ \blkref{def_two_step_factorable_neighborhood_assignment},\ \blkref{def_composed_neighborhood})
\end{aligned}`),
      paragraph([
        "である。よって集合の外延性より ", math(String.raw`(N\star N)(v)=N(v)`),
        " であり、", math(String.raw`v`), " の任意性と写像の外延性より ",
        math(String.raw`N\star N=N`), " である。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_composition_idempotents_claim_reflexive_case",
    kind: "claim",
    title: { text: "自己近傍を含む場合は推移性だけで足りる" },
    labels: ["claim_reflexive_neighborhood_assignment_idempotent_iff_transitive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ", math(String.raw`N\in\mathcal N(V)`),
        " が任意の ", math(String.raw`v\in V`), " について ",
        math(String.raw`v\in N(v)`), " を満たすとする。このとき ",
        math(String.raw`N`), " が合成近傍について冪等であることと、推移的であることは同値である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_composition_idempotent_neighborhood_assignment_characterization"),
        " より、冪等なら推移的である。逆に ", math(String.raw`N`), " が推移的とする。任意の ",
        math(String.raw`v,w\in V`), " と ", math(String.raw`w\in N(v)`), " について、",
      ]),
      displayMath(String.raw`w\in N(v)\ \land\ w\in N(w)
\qquad(\because\ w\in N(v),\ \text{自己近傍の包含})`),
      paragraph([
        "なので、", math(String.raw`u:=w`), " は ",
        ref("def_two_step_factorable_neighborhood_assignment"), " の存在証人である。したがって ",
        math(String.raw`N`), " は二段分解可能であり、",
        ref("claim_composition_idempotent_neighborhood_assignment_characterization"),
        " より冪等である。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_composition_idempotents_claim_conditions_independent",
    kind: "claim",
    title: { text: "推移性と二段分解可能性は互いを含意しない" },
    labels: ["claim_transitive_and_factorable_neighborhood_assignment_independent"],
    habitat: "finite",
    statement: [
      paragraph([
        "推移的（", ref("def_transitive_neighborhood_assignment"),
        "）だが二段分解可能（", ref("def_two_step_factorable_neighborhood_assignment"),
        "）でない有限近傍割り当てと、その逆の有限近傍割り当てが存在する。",
      ]),
    ],
    proof: [
      paragraph([
        "相異なる二元からなる ", math(String.raw`V_1:=\{a,b\}`), " 上で ",
        math(String.raw`N_1(a):=\{b\}`), "、", math(String.raw`N_1(b):=\varnothing`),
        " と定める。二段の辺が存在しないので ", math(String.raw`N_1`), " は推移的である。一方、",
      ]),
      displayMath(String.raw`b\in N_1(a)\quad\land\quad
\neg\exists u\in N_1(a),\ b\in N_1(u)`),
      paragraph([
        "なので二段分解可能でない。次に相異なる三元からなる ",
        math(String.raw`V_2:=\{a,b,c\}`), " 上で",
      ]),
      displayMath(String.raw`\begin{aligned}
N_2(a)&:=\{a,b\},\\
N_2(b)&:=\{b,c\},\\
N_2(c)&:=\{c\}
\end{aligned}`),
      paragraph([
        "と定める。各 ", math(String.raw`w\in N_2(v)`), " に対し ",
        math(String.raw`u:=v`), " を取れば ", math(String.raw`u\in N_2(v)`), " かつ ",
        math(String.raw`w\in N_2(u)`), " なので二段分解可能である。しかし ",
        math(String.raw`b\in N_2(a)`), " かつ ", math(String.raw`c\in N_2(b)`),
        " である一方、", math(String.raw`c\notin N_2(a)`), " なので推移的でない。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_composition_idempotents_claim_finite_decidability",
    kind: "claim",
    title: { text: "合成冪等性は有限決定できる" },
    labels: ["claim_composition_idempotent_neighborhood_assignment_finite_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), " が有限表として与えられたとき、合成冪等性、推移性、",
        "二段分解可能性は有限回の所属判定で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "有限集合 ", math(String.raw`V^3`), " の全ての組 ",
        math(String.raw`(v,u,w)`), " を列挙すれば、",
        ref("def_transitive_neighborhood_assignment"), " の含意を有限回で検査できる。有限集合 ",
        math(String.raw`V^2`), " の全ての組 ", math(String.raw`(v,w)`),
        " について、", math(String.raw`w\in N(v)`), " の場合に有限集合 ",
        math(String.raw`N(v)`), " を走査すれば、",
        ref("def_two_step_factorable_neighborhood_assignment"), " の存在証人の有無を決定できる。",
        ref("claim_composition_idempotent_neighborhood_assignment_characterization"),
        " により、この二つの有限検査から合成冪等性も決定できる。",
      ]),
    ],
  },
]);
