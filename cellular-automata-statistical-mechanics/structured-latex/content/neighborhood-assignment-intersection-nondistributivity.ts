/**
 * 章「近傍割り当ての点ごとの積と合成の非分配性」。
 * 点ごとの共通部分から有限分配束を得る一方、合成近傍は共通部分を保存しないことを有限反例で示す。
 * 有限集合、写像、所属判定だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_intersection_nondistributivity_heading",
    kind: "heading",
    level: 1,
    title: { text: "近傍割り当ての点ごとの積と合成の非分配性" },
    labels: [],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_definition_intersection",
    kind: "definition",
    title: { text: "近傍割り当ての点ごとの積" },
    labels: ["def_neighborhood_assignment_pointwise_intersection"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`V`), " 上の ", math(String.raw`N,M\in\mathcal N(V)`),
        "（", ref("def_finite_neighborhood_assignment_space"), "）に対し、点ごとの積を"]),
      displayMath(String.raw`(N\sqcap M)(v):=N(v)\cap M(v)\qquad(v\in V)`),
      paragraph(["で定める。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_definition_full",
    kind: "definition",
    title: { text: "全近傍割り当て" },
    labels: ["def_full_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`V`), " 上の全近傍割り当て ",
        math(String.raw`U_V\in\mathcal N(V)`), "（", ref("def_finite_neighborhood_assignment_space"), "）を"]),
      displayMath(String.raw`U_V(v):=V\qquad(v\in V)`),
      paragraph(["で定める。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_claim_intersection_laws",
    kind: "claim",
    title: { text: "点ごとの積の法則" },
    labels: ["claim_neighborhood_assignment_pointwise_intersection_laws"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N,M,L\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`N\sqcap M=M\sqcap N,\qquad
(N\sqcap M)\sqcap L=N\sqcap(M\sqcap L),\qquad
N\sqcap N=N,\qquad N\sqcap U_V=N`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in(N\sqcap M)(v)
&\Longleftrightarrow w\in N(v)\land w\in M(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection})\\
&\Longleftrightarrow w\in M(v)\land w\in N(v)
  \qquad(\because\ \text{論理積の交換律})\\
&\Longleftrightarrow w\in(M\sqcap N)(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection})
\end{aligned}`),
      paragraph(["である。集合と写像の外延性により交換律が従う。同様に"]),
      displayMath(String.raw`\begin{aligned}
w\in((N\sqcap M)\sqcap L)(v)
&\Longleftrightarrow (w\in N(v)\land w\in M(v))\land w\in L(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection})\\
&\Longleftrightarrow w\in N(v)\land(w\in M(v)\land w\in L(v))
  \qquad(\because\ \text{論理積の結合律})\\
&\Longleftrightarrow w\in(N\sqcap(M\sqcap L))(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection})
\end{aligned}`),
      paragraph(["なので、集合と写像の外延性により結合律が従う。また"]),
      displayMath(String.raw`\begin{aligned}
w\in(N\sqcap N)(v)
&\Longleftrightarrow w\in N(v)\land w\in N(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection})\\
&\Longleftrightarrow w\in N(v)
  \qquad(\because\ \text{論理積の冪等律}),\\[4pt]
w\in(N\sqcap U_V)(v)
&\Longleftrightarrow w\in N(v)\land w\in V
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_full_neighborhood_assignment})\\
&\Longleftrightarrow w\in N(v)
  \qquad(\because\ w\in V)
\end{aligned}`),
      paragraph(["なので、集合と写像の外延性により冪等律と単位律が従う。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_claim_lattice",
    kind: "claim",
    title: { text: "点ごとの和と積は有限分配束をなす" },
    labels: ["claim_neighborhood_assignment_pointwise_union_intersection_lattice"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`V`), " 上の ", math(String.raw`\mathcal N(V)`), " は、点ごとの和 ", math(String.raw`\sqcup`), "、点ごとの積 ", math(String.raw`\sqcap`), "、空近傍 ", math(String.raw`O_V`), "、全近傍 ", math(String.raw`U_V`), " について有限分配束をなす。点ごとの包含順序に関して、和は最小上界、積は最大下界である。"]),
    ],
    proof: [
      paragraph([ref("claim_neighborhood_assignment_pointwise_union_laws"), " と ", ref("claim_neighborhood_assignment_pointwise_intersection_laws"), " により、和と積はそれぞれ可換・結合的・冪等であり、空近傍と全近傍を単位元に持つ。"]),
      paragraph(["任意の ", math(String.raw`N,M,L\in\mathcal N(V)`), " と ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in(N\sqcap(M\sqcup L))(v)
&\Longleftrightarrow w\in N(v)\land(w\in M(v)\lor w\in L(v))
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&\Longleftrightarrow (w\in N(v)\land w\in M(v))\lor(w\in N(v)\land w\in L(v))
  \qquad(\because\ \text{論理積の論理和に対する分配律})\\
&\Longleftrightarrow w\in((N\sqcap M)\sqcup(N\sqcap L))(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_neighborhood_assignment_pointwise_union})
\end{aligned}`),
      paragraph(["である。集合と写像の外延性により積の和に対する分配律が従う。また"]),
      displayMath(String.raw`\begin{aligned}
w\in(N\sqcup(M\sqcap L))(v)
&\Longleftrightarrow w\in N(v)\lor(w\in M(v)\land w\in L(v))
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union},\ \blkref{def_neighborhood_assignment_pointwise_intersection})\\
&\Longleftrightarrow (w\in N(v)\lor w\in M(v))\land(w\in N(v)\lor w\in L(v))
  \qquad(\because\ \text{論理和の論理積に対する分配律})\\
&\Longleftrightarrow w\in((N\sqcup M)\sqcap(N\sqcup L))(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union},\ \blkref{def_neighborhood_assignment_pointwise_intersection})
\end{aligned}`),
      paragraph(["なので、集合と写像の外延性により和の積に対する分配律が従う。"]),
      paragraph([ref("def_neighborhood_assignment_pointwise_inclusion"), " と点ごとの和の定義より"]),
      displayMath(String.raw`N\preccurlyeq N\sqcup M,\qquad M\preccurlyeq N\sqcup M`),
      paragraph(["である。また、", math(String.raw`N\preccurlyeq L`), " かつ ", math(String.raw`M\preccurlyeq L`), " ならば、任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in(N\sqcup M)(v)
&\Longleftrightarrow w\in N(v)\lor w\in M(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&\Longrightarrow w\in L(v)
  \qquad(\because\ N\preccurlyeq L,\ M\preccurlyeq L,\ \blkref{def_neighborhood_assignment_pointwise_inclusion})
\end{aligned}`),
      paragraph(["なので、", ref("def_neighborhood_assignment_pointwise_inclusion"), " より ", math(String.raw`N\sqcup M\preccurlyeq L`), " である。したがって和は最小上界である。"]),
      paragraph([ref("def_neighborhood_assignment_pointwise_inclusion"), " と点ごとの積の定義より"]),
      displayMath(String.raw`N\sqcap M\preccurlyeq N,\qquad N\sqcap M\preccurlyeq M`),
      paragraph(["である。また、", math(String.raw`L\preccurlyeq N`), " かつ ", math(String.raw`L\preccurlyeq M`), " ならば、任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in L(v)
&\Longrightarrow w\in N(v)\land w\in M(v)
  \qquad(\because\ L\preccurlyeq N,\ L\preccurlyeq M,\ \blkref{def_neighborhood_assignment_pointwise_inclusion})\\
&\Longleftrightarrow w\in(N\sqcap M)(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection})
\end{aligned}`),
      paragraph(["なので、", ref("def_neighborhood_assignment_pointwise_inclusion"), " より ", math(String.raw`L\preccurlyeq N\sqcap M`), " である。したがって積は最大下界である。有限性は ", ref("claim_finite_neighborhood_assignment_monoid_cardinality_decidable"), " から従う。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_definition_left_witness",
    kind: "definition",
    title: { text: "合成が左側の点ごとの積を保存しない舞台" },
    labels: ["def_composition_left_intersection_nondistributivity_witness"],
    habitat: "finite",
    statement: [
      paragraph(["相異なる元からなる有限集合 ", math(String.raw`V_{\cap}:=\{a,b,c\}`), " 上で"]),
      displayMath(String.raw`N(a):=\{b\},\qquad M(a):=\{c\},\qquad L(b):=L(c):=\{a\}`),
      paragraph(["とし、指定しなかった全ての近傍を空集合とする。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_claim_left_failure",
    kind: "claim",
    title: { text: "合成は左側の点ごとの積に分配しない" },
    labels: ["claim_composition_not_left_distributive_over_pointwise_intersection"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_composition_left_intersection_nondistributivity_witness"), " の舞台で"]),
      displayMath(String.raw`(N\sqcap M)\star L\neq(N\star L)\sqcap(M\star L)`),
      paragraph(["である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
((N\sqcap M)\star L)(a)
&=\bigcup_{u\in N(a)\cap M(a)}L(u)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_composed_neighborhood})\\
&=\bigcup_{u\in\varnothing}L(u)
  \qquad(\because\ \blkref{def_composition_left_intersection_nondistributivity_witness})\\
&=\varnothing
  \qquad(\because\ \text{空集合を添字とする合併}),\\[4pt]
((N\star L)\sqcap(M\star L))(a)
&=L(b)\cap L(c)
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_composition_left_intersection_nondistributivity_witness})\\
&=\{a\}
  \qquad(\because\ \blkref{def_composition_left_intersection_nondistributivity_witness})
\end{aligned}`),
      paragraph([math(String.raw`a\notin\varnothing`), " かつ ", math(String.raw`a\in\{a\}`), " なので二つの近傍割り当ては異なる。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_definition_right_witness",
    kind: "definition",
    title: { text: "合成が右側の点ごとの積を保存しない舞台" },
    labels: ["def_composition_right_intersection_nondistributivity_witness"],
    habitat: "finite",
    statement: [
      paragraph(["同じ有限集合 ", math(String.raw`V_{\cap}=\{a,b,c\}`), " 上で"]),
      displayMath(String.raw`L'(a):=\{b,c\},\qquad N'(b):=\{a\},\qquad M'(c):=\{a\}`),
      paragraph(["とし、指定しなかった全ての近傍を空集合とする。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_claim_right_failure",
    kind: "claim",
    title: { text: "合成は右側の点ごとの積に分配しない" },
    labels: ["claim_composition_not_right_distributive_over_pointwise_intersection"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_composition_right_intersection_nondistributivity_witness"), " の舞台で"]),
      displayMath(String.raw`L'\star(N'\sqcap M')\neq(L'\star N')\sqcap(L'\star M')`),
      paragraph(["である。したがって、合成近傍は点ごとの和には両側から分配するが、点ごとの積にはどちら側からも一般には分配しない。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(L'\star(N'\sqcap M'))(a)
&=(N'\sqcap M')(b)\cup(N'\sqcap M')(c)
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_composition_right_intersection_nondistributivity_witness})\\
&=\varnothing\cup\varnothing
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_composition_right_intersection_nondistributivity_witness})\\
&=\varnothing
  \qquad(\because\ \text{空集合の合併}),\\[4pt]
((L'\star N')\sqcap(L'\star M'))(a)
&=(N'(b)\cup N'(c))\cap(M'(b)\cup M'(c))
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_composition_right_intersection_nondistributivity_witness})\\
&=\{a\}\cap\{a\}
  \qquad(\because\ \blkref{def_composition_right_intersection_nondistributivity_witness})\\
&=\{a\}
  \qquad(\because\ \text{集合の冪等律})
\end{aligned}`),
      paragraph([math(String.raw`a\notin\varnothing`), " かつ ", math(String.raw`a\in\{a\}`), " なので二つの近傍割り当ては異なる。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_nondistributivity_claim_finite_decidability",
    kind: "claim",
    title: { text: "点ごとの積と分配性は有限決定できる" },
    labels: ["claim_neighborhood_assignment_intersection_and_distributivity_finite_decidable"],
    habitat: "finite",
    statement: [paragraph(["有限集合 ", math(String.raw`V`), " 上では、点ごとの積、その演算表、合成が積に分配する組の全体、分配しない反例の有無を有限回の所属判定で決定できる。"])],
    proof: [
      paragraph([ref("claim_finite_neighborhood_assignment_monoid_cardinality_decidable"), " により ", math(String.raw`\mathcal N(V)`), " は有限列挙できる。各積は各 ", math(String.raw`v,w\in V`), " について ", math(String.raw`w\in N(v)`), " かつ ", math(String.raw`w\in M(v)`), " を検査すれば求まる。全ての三つ組を列挙し、両辺の近傍割り当てを有限表として比較すれば、左右それぞれの分配性と反例の有無を有限決定できる。"]),
    ],
  },
]);
