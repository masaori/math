/**
 * 章「近傍割り当ての点ごとの和と合成の分配性」。
 * 空近傍割り当てと点ごとの合併を定義し、合成近傍との分配性を内在的に導く。
 * 有限集合、写像、所属判定だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_union_distributivity_definition_empty",
    kind: "definition",
    title: { text: "空近傍割り当て" },
    labels: ["def_empty_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の近傍割り当て ",
        math(String.raw`O_V\in\mathcal N(V)`), "（", ref("def_finite_neighborhood_assignment_space"), "）を",
      ]),
      displayMath(String.raw`O_V(v):=\varnothing\qquad(v\in V)`),
      paragraph(["で定める。"]),
    ],
  },

  {
    id: "neighborhood_assignment_union_distributivity_definition_union",
    kind: "definition",
    title: { text: "近傍割り当ての点ごとの和" },
    labels: ["def_neighborhood_assignment_pointwise_union"],
    habitat: "finite",
    statement: [
      paragraph([
        "任意の ", math(String.raw`N,M\in\mathcal N(V)`), "（",
        ref("def_finite_neighborhood_assignment_space"), "）に対し、点ごとの和 ",
        math(String.raw`N\sqcup M\in\mathcal N(V)`), " を",
      ]),
      displayMath(String.raw`(N\sqcup M)(v):=N(v)\cup M(v)\qquad(v\in V)`),
      paragraph(["で定める。有限集合の合併なので、各値は再び有限集合である。"]),
    ],
  },

  {
    id: "neighborhood_assignment_union_distributivity_claim_union_laws",
    kind: "claim",
    title: { text: "点ごとの和は可換で結合的かつ冪等である" },
    labels: ["claim_neighborhood_assignment_pointwise_union_laws"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N,M,L\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`N\sqcup M=M\sqcup N,\qquad
(N\sqcup M)\sqcup L=N\sqcup(M\sqcup L),\qquad
N\sqcup N=N`),
      paragraph(["が成り立ち、", math(String.raw`O_V`), " は点ごとの和の単位元である。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
(N\sqcup M)(v)
&=N(v)\cup M(v)\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&=M(v)\cup N(v)\qquad(\because\ \text{集合の合併の可換律})\\
&=(M\sqcup N)(v)\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union}),\\[4pt]
((N\sqcup M)\sqcup L)(v)
&=(N(v)\cup M(v))\cup L(v)\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&=N(v)\cup(M(v)\cup L(v))\qquad(\because\ \text{集合の合併の結合律})\\
&=(N\sqcup(M\sqcup L))(v)\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union}),\\[4pt]
(N\sqcup N)(v)
&=N(v)\cup N(v)\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&=N(v)\qquad(\because\ \text{集合の合併の冪等律}),\\[4pt]
(N\sqcup O_V)(v)
&=N(v)\cup\varnothing\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union},\ \blkref{def_empty_neighborhood_assignment})\\
&=N(v)\qquad(\because\ \text{空集合との合併})
\end{aligned}`),
      paragraph(["である。写像の外延性により各等号が従う。可換律から ",
        math(String.raw`O_V\sqcup N=N`), " も従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_union_distributivity_claim_order_characterization",
    kind: "claim",
    title: { text: "包含順序は点ごとの和だけで特徴づけられる" },
    labels: ["claim_neighborhood_assignment_inclusion_iff_union_eq"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N,M\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`N\preccurlyeq M\quad\Longleftrightarrow\quad N\sqcup M=M`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`N\preccurlyeq M`), " とする。任意の ", math(String.raw`v\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
(N\sqcup M)(v)
&=N(v)\cup M(v)\qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&=M(v)\qquad(\because\ N(v)\subseteq M(v),\ \blkref{def_neighborhood_assignment_pointwise_inclusion})
\end{aligned}`),
      paragraph(["なので、写像の外延性より ", math(String.raw`N\sqcup M=M`), " である。逆に ",
        math(String.raw`N\sqcup M=M`), " とする。任意の ", math(String.raw`v\in V`), " と ",
        math(String.raw`w\in N(v)`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in N(v)
&\Longrightarrow w\in N(v)\cup M(v)\qquad(\because\ \text{合併への所属})\\
&\Longleftrightarrow w\in(N\sqcup M)(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&\Longleftrightarrow w\in M(v)\qquad(\because\ N\sqcup M=M)
\end{aligned}`),
      paragraph(["である。したがって ", math(String.raw`N(v)\subseteq M(v)`), " であり、",
        math(String.raw`v`), " の任意性と ", ref("def_neighborhood_assignment_pointwise_inclusion"),
        " より ", math(String.raw`N\preccurlyeq M`), " である。"]),
    ],
  },

  {
    id: "neighborhood_assignment_union_distributivity_claim_distributive",
    kind: "claim",
    title: { text: "合成近傍は点ごとの和に両側から分配する" },
    labels: ["claim_composed_neighborhood_distributes_over_pointwise_union"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N,M,L\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`(N\sqcup M)\star L=(N\star L)\sqcup(M\star L),\qquad
L\star(N\sqcup M)=(L\star N)\sqcup(L\star M)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in((N\sqcup M)\star L)(v)
&\Longleftrightarrow \exists u\in N(v)\cup M(v),\ w\in L(u)
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&\Longleftrightarrow (\exists u\in N(v),\ w\in L(u))\ \lor\ (\exists u\in M(v),\ w\in L(u))
  \qquad(\because\ \text{合併への所属})\\
&\Longleftrightarrow w\in(N\star L)(v)\cup(M\star L)(v)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&\Longleftrightarrow w\in((N\star L)\sqcup(M\star L))(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union}),\\[4pt]
w\in(L\star(N\sqcup M))(v)
&\Longleftrightarrow \exists u\in L(v),\ w\in N(u)\cup M(u)
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&\Longleftrightarrow (\exists u\in L(v),\ w\in N(u))\ \lor\ (\exists u\in L(v),\ w\in M(u))
  \qquad(\because\ \text{存在量化の論理和への分配})\\
&\Longleftrightarrow w\in(L\star N)(v)\cup(L\star M)(v)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&\Longleftrightarrow w\in((L\star N)\sqcup(L\star M))(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union})
\end{aligned}`),
      paragraph(["集合の外延性と写像の外延性により二つの等号が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_union_distributivity_claim_absorbing",
    kind: "claim",
    title: { text: "空近傍割り当ては合成近傍の吸収元である" },
    labels: ["claim_empty_neighborhood_assignment_is_composition_absorbing"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`O_V\star N=O_V=N\star O_V`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
(O_V\star N)(v)
&=\bigcup_{u\in O_V(v)}N(u)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&=\bigcup_{u\in\varnothing}N(u)\qquad(\because\ \blkref{def_empty_neighborhood_assignment})\\
&=\varnothing\qquad(\because\ \text{空集合を添字とする合併})\\
&=O_V(v)\qquad(\because\ \blkref{def_empty_neighborhood_assignment}),\\[4pt]
(N\star O_V)(v)
&=\bigcup_{u\in N(v)}O_V(u)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&=\bigcup_{u\in N(v)}\varnothing\qquad(\because\ \blkref{def_empty_neighborhood_assignment})\\
&=\varnothing\qquad(\because\ \text{空集合だけの合併})\\
&=O_V(v)\qquad(\because\ \blkref{def_empty_neighborhood_assignment})
\end{aligned}`),
      paragraph(["写像の外延性により二つの等号が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_union_distributivity_claim_idempotent_semiring",
    kind: "claim",
    title: { text: "有限近傍割り当ては有限な冪等半環をなす" },
    labels: ["claim_finite_neighborhood_assignments_form_idempotent_semiring"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の ", math(String.raw`\mathcal N(V)`), " は、点ごとの和 ",
        math(String.raw`\sqcup`), "、空近傍割り当て ", math(String.raw`O_V`), "、合成近傍 ",
        math(String.raw`\star`), "、自己近傍割り当て ", math(String.raw`I_V`),
        " について有限な冪等半環をなす。両演算とその表は有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_neighborhood_assignment_pointwise_union_laws"), " により ",
        math(String.raw`(\mathcal N(V),\sqcup,O_V)`), " は冪等可換モノイドである。",
        ref("claim_finite_neighborhood_assignments_form_monoid"), " により ",
        math(String.raw`(\mathcal N(V),\star,I_V)`), " はモノイドである。",
        ref("claim_composed_neighborhood_distributes_over_pointwise_union"), " により分配律が成り立ち、",
        ref("claim_empty_neighborhood_assignment_is_composition_absorbing"), " により ",
        math(String.raw`O_V`), " は合成の吸収元である。有限性と合成表の有限決定は ",
        ref("claim_finite_neighborhood_assignment_monoid_cardinality_decidable"),
        " から従い、点ごとの和は各点で有限集合の合併を取ることで有限決定できる。",
      ]),
    ],
  },
]);
