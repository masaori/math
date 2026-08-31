/**
 * 章「近傍割り当ての包含順序と合成の単調性」。
 * 有限舞台上の近傍割り当てに点ごとの包含順序を入れ、合成近傍が両引数で単調であることを示す。
 * 有限集合、写像、所属判定だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "ordered_neighborhood_assignment_monoid_definition_refinement",
    kind: "definition",
    title: { text: "近傍割り当ての点ごとの包含順序" },
    labels: ["def_neighborhood_assignment_pointwise_inclusion"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の近傍割り当て全体 ",
        math(String.raw`\mathcal N(V)`), "（", ref("def_finite_neighborhood_assignment_space"),
        "）に対し、二元関係 ", math(String.raw`\preccurlyeq`), " を",
      ]),
      displayMath(String.raw`N\preccurlyeq M\quad:\Longleftrightarrow\quad
\forall v\in V,\ N(v)\subseteq M(v)\qquad(N,M\in\mathcal N(V))`),
      paragraph(["で定める。"])],
  },

  {
    id: "ordered_neighborhood_assignment_monoid_claim_partial_order",
    kind: "claim",
    title: { text: "点ごとの包含は近傍割り当て全体の部分順序である" },
    labels: ["claim_neighborhood_assignment_pointwise_inclusion_partial_order"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_neighborhood_assignment_pointwise_inclusion"), " の関係 ",
        math(String.raw`\preccurlyeq`), " は ", math(String.raw`\mathcal N(V)`),
        " 上の反射的・反対称・推移的な関係である。",
      ]),
    ],
    proof: [
      paragraph([
        "任意の ", math(String.raw`N\in\mathcal N(V)`), " と ", math(String.raw`v\in V`),
        " について ", math(String.raw`N(v)\subseteq N(v)`),
        " なので、", math(String.raw`N\preccurlyeq N`), " である。よって反射的である。",
      ]),
      paragraph([
        "次に ", math(String.raw`N\preccurlyeq M`), " かつ ",
        math(String.raw`M\preccurlyeq N`), " とする。任意の ", math(String.raw`v\in V`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
N(v)
&\subseteq M(v)\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_inclusion})\\
M(v)
&\subseteq N(v)\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_inclusion})
\end{aligned}`),
      paragraph([
        "なので、集合の外延性より ", math(String.raw`N(v)=M(v)`), " である。",
        math(String.raw`v`), " の任意性と写像の外延性より ", math(String.raw`N=M`),
        " である。よって反対称である。",
      ]),
      paragraph([
        "最後に ", math(String.raw`N\preccurlyeq M`), " かつ ",
        math(String.raw`M\preccurlyeq L`), " とする。任意の ", math(String.raw`v\in V`),
        " と ", math(String.raw`w\in N(v)`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
w
&\in M(v)\qquad(\because\ N\preccurlyeq M,\ \blkref{def_neighborhood_assignment_pointwise_inclusion})\\
&\in L(v)\qquad(\because\ M\preccurlyeq L,\ \blkref{def_neighborhood_assignment_pointwise_inclusion})
\end{aligned}`),
      paragraph([
        "である。したがって ", math(String.raw`N(v)\subseteq L(v)`), " であり、",
        math(String.raw`v`), " の任意性より ", math(String.raw`N\preccurlyeq L`),
        " である。よって推移的である。",
      ]),
    ],
  },

  {
    id: "ordered_neighborhood_assignment_monoid_claim_composition_monotone",
    kind: "claim",
    title: { text: "合成近傍は両引数の包含について単調である" },
    labels: ["claim_composed_neighborhood_monotone"],
    habitat: "finite",
    statement: [
      paragraph([
        "任意の ", math(String.raw`N,N',M,M'\in\mathcal N(V)`), " について、",
        math(String.raw`N\preccurlyeq N'`), " かつ ", math(String.raw`M\preccurlyeq M'`),
        " ならば",
      ]),
      displayMath(String.raw`N\star M\preccurlyeq N'\star M'`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph([
        "任意の ", math(String.raw`v,w\in V`), " を取り、",
        math(String.raw`w\in(N\star M)(v)`), " とする。すると",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in(N\star M)(v)
&\Longleftrightarrow \exists u\in N(v),\ w\in M(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&\Longrightarrow \exists u\in N'(v),\ w\in M(u)
  \qquad(\because\ N\preccurlyeq N',\ \blkref{def_neighborhood_assignment_pointwise_inclusion})\\
&\Longrightarrow \exists u\in N'(v),\ w\in M'(u)
  \qquad(\because\ M\preccurlyeq M',\ \blkref{def_neighborhood_assignment_pointwise_inclusion})\\
&\Longleftrightarrow w\in(N'\star M')(v)
  \qquad(\because\ \blkref{def_composed_neighborhood})
\end{aligned}`),
      paragraph([
        "である。", math(String.raw`w`), " の任意性より ",
        math(String.raw`(N\star M)(v)\subseteq(N'\star M')(v)`),
        " であり、", math(String.raw`v`), " の任意性と ",
        ref("def_neighborhood_assignment_pointwise_inclusion"), " より主張が従う。",
      ]),
    ],
  },

  {
    id: "ordered_neighborhood_assignment_monoid_claim_finite_decidability",
    kind: "claim",
    title: { text: "近傍割り当ての包含順序は有限決定できる" },
    labels: ["claim_neighborhood_assignment_pointwise_inclusion_finite_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と二つの近傍割り当て ",
        math(String.raw`N,M\in\mathcal N(V)`), " が有限表として与えられたとき、",
        math(String.raw`N\preccurlyeq M`), " の成否は有限回の所属判定で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " の全ての組 ", math(String.raw`(v,w)\in V\times V`),
        " を列挙し、", math(String.raw`w\in N(v)`), " ならば ",
        math(String.raw`w\in M(v)`), " であることを検査する。この有限検査が全て真であることは、",
        ref("def_neighborhood_assignment_pointwise_inclusion"), " により ",
        math(String.raw`N\preccurlyeq M`), " と同値である。",
      ]),
    ],
  },

  {
    id: "ordered_neighborhood_assignment_monoid_claim_ordered_monoid",
    kind: "claim",
    title: { text: "有限近傍割り当ては有限順序モノイドをなす" },
    labels: ["claim_finite_neighborhood_assignments_form_ordered_monoid"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の近傍割り当て全体 ",
        math(String.raw`\mathcal N(V)`), " は、合成 ", math(String.raw`\star`), "、単位元 ",
        math(String.raw`I_V`), "、点ごとの包含順序 ", math(String.raw`\preccurlyeq`),
        " について有限順序モノイドをなす。すなわち、有限モノイドかつ有限部分順序集合であり、",
        "積は両引数について単調である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_finite_neighborhood_assignments_form_monoid"), " により有限モノイドをなし、",
        ref("claim_neighborhood_assignment_pointwise_inclusion_partial_order"),
        " により部分順序集合をなす。", ref("claim_composed_neighborhood_monotone"),
        " により積は両引数について単調である。有限性と有限決定は ",
        ref("claim_finite_neighborhood_assignment_monoid_cardinality_decidable"), " と ",
        ref("claim_neighborhood_assignment_pointwise_inclusion_finite_decidable"), " から従う。",
      ]),
    ],
  },
]);
