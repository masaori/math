/**
 * 章「点ごとの積に対する合成の非分配反例の最小基礎集合」。
 * 空集合と一元集合では反例が存在しないことと、二元集合で左右の
 * 非分配反例が存在することを、有限集合と所属判定だけから示す。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_intersection_minimal_counterexample_claim_subsingleton_composition",
    kind: "claim",
    title: { text: "一元以下の基礎集合では合成と点ごとの積が一致する" },
    labels: ["claim_subsingleton_neighborhood_composition_equals_intersection"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " が ",
        math(String.raw`|V|\leq 1`), " を満たすとする。任意の ",
        math(String.raw`N,M\in\mathcal N(V)`), " について",
      ]),
      displayMath(String.raw`N\star M=N\sqcap M`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "任意の ", math(String.raw`v,w\in V`), " を取る。",
        math(String.raw`|V|\leq 1`), " より、", math(String.raw`V`),
        " の任意の二元は等しい。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in(N\star M)(v)
&\Longleftrightarrow \exists u\in N(v),\ w\in M(u)
  \qquad(\because\ \blkref{def_composed_neighborhood}).
\end{aligned}`),
      paragraph(["この存在文が成り立つならば、証人 ", math(String.raw`u\in V`), " に対して ", math(String.raw`u=v=w`), " なので"]),
      displayMath(String.raw`w\in N(v)\land w\in M(v)`),
      paragraph(["である。逆にこの論理積が成り立つならば、", math(String.raw`u:=w`), " と取ることにより"]),
      displayMath(String.raw`\exists u\in N(v),\ w\in M(u)`),
      paragraph(["である。ゆえに"]),
      displayMath(String.raw`\begin{aligned}
w\in(N\star M)(v)
&\Longleftrightarrow w\in N(v)\land w\in M(v)
  \qquad(\because\ \text{上の二つの含意})\\
&\Longleftrightarrow w\in(N\sqcap M)(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection}).
\end{aligned}`),
      paragraph([
        "二つの含意により所属条件は同値である。集合と写像の外延性により ",
        math(String.raw`N\star M=N\sqcap M`), " が従う。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_minimal_counterexample_claim_subsingleton_distributive",
    kind: "claim",
    title: { text: "一元以下の基礎集合では左右の分配律が成り立つ" },
    labels: ["claim_subsingleton_neighborhood_composition_distributes_over_intersection"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " が ", math(String.raw`|V|\leq 1`),
        " を満たすとする。任意の ", math(String.raw`N,M,L\in\mathcal N(V)`), " について",
      ]),
      displayMath(String.raw`(N\sqcap M)\star L=(N\star L)\sqcap(M\star L),\qquad
L\star(N\sqcap M)=(L\star N)\sqcap(L\star M)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([ref("claim_subsingleton_neighborhood_composition_equals_intersection"), " を各合成に適用すると"]),
      displayMath(String.raw`\begin{aligned}
(N\sqcap M)\star L
&=(N\sqcap M)\sqcap L
  \qquad(\because\ \blkref{claim_subsingleton_neighborhood_composition_equals_intersection})\\
&=(N\sqcap L)\sqcap(M\sqcap L)
  \qquad(\because\ \text{点ごとの共通部分の交換・結合・冪等律})\\
&=(N\star L)\sqcap(M\star L)
  \qquad(\because\ \blkref{claim_subsingleton_neighborhood_composition_equals_intersection}),\\[4pt]
L\star(N\sqcap M)
&=L\sqcap(N\sqcap M)
  \qquad(\because\ \blkref{claim_subsingleton_neighborhood_composition_equals_intersection})\\
&=(L\sqcap N)\sqcap(L\sqcap M)
  \qquad(\because\ \text{点ごとの共通部分の交換・結合・冪等律})\\
&=(L\star N)\sqcap(L\star M)
  \qquad(\because\ \blkref{claim_subsingleton_neighborhood_composition_equals_intersection}).
\end{aligned}`),
      paragraph(["よって左右の分配律が成り立つ。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_minimal_counterexample_definition_two_element_witnesses",
    kind: "definition",
    title: { text: "二元基礎集合上の左右の非分配証人" },
    labels: ["def_two_element_intersection_nondistributivity_witnesses"],
    habitat: "finite",
    statement: [
      paragraph(["相異なる二元からなる有限集合 ", math(String.raw`V_2:=\{a,b\}`), " 上で、左側の証人を"]),
      displayMath(String.raw`N(a):=\varnothing,\quad N(b):=\{a\},\qquad
M(a):=\varnothing,\quad M(b):=\{b\},\qquad
L(a):=L(b):=\{a\}`),
      paragraph(["で定める。右側の証人を"]),
      displayMath(String.raw`N'(a):=\varnothing,\quad N'(b):=\{a\},\qquad
M'(a):=\{a\},\quad M'(b):=\varnothing,\qquad
L'(a):=\varnothing,\quad L'(b):=\{a,b\}`),
      paragraph(["で定める。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_minimal_counterexample_claim_two_element_failures",
    kind: "claim",
    title: { text: "二元基礎集合で左右の分配律はともに破れる" },
    labels: ["claim_two_element_composition_intersection_nondistributivity"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_two_element_intersection_nondistributivity_witnesses"), " の証人について"]),
      displayMath(String.raw`(N\sqcap M)\star L\neq(N\star L)\sqcap(M\star L),\qquad
L'\star(N'\sqcap M')\neq(L'\star N')\sqcap(L'\star M')`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph(["左側について、", math(String.raw`b`), " での値を計算すると"]),
      displayMath(String.raw`\begin{aligned}
((N\sqcap M)\star L)(b)
&=\bigcup_{u\in N(b)\cap M(b)}L(u)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_composed_neighborhood})\\
&=\bigcup_{u\in\varnothing}L(u)
  \qquad(\because\ \blkref{def_two_element_intersection_nondistributivity_witnesses})\\
&=\varnothing
  \qquad(\because\ \text{空集合を添字とする合併}),\\[4pt]
((N\star L)\sqcap(M\star L))(b)
&=L(a)\cap L(b)
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_two_element_intersection_nondistributivity_witnesses})\\
&=\{a\}
  \qquad(\because\ \blkref{def_two_element_intersection_nondistributivity_witnesses}).
\end{aligned}`),
      paragraph(["右側について、", math(String.raw`b`), " での値を計算すると"]),
      displayMath(String.raw`\begin{aligned}
(L'\star(N'\sqcap M'))(b)
&=(N'\sqcap M')(a)\cup(N'\sqcap M')(b)
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_two_element_intersection_nondistributivity_witnesses})\\
&=\varnothing\cup\varnothing
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_two_element_intersection_nondistributivity_witnesses})\\
&=\varnothing
  \qquad(\because\ \text{空集合の合併}),\\[4pt]
((L'\star N')\sqcap(L'\star M'))(b)
&=(N'(a)\cup N'(b))\cap(M'(a)\cup M'(b))
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_neighborhood_assignment_pointwise_intersection},\ \blkref{def_two_element_intersection_nondistributivity_witnesses})\\
&=\{a\}\cap\{a\}
  \qquad(\because\ \blkref{def_two_element_intersection_nondistributivity_witnesses})\\
&=\{a\}
  \qquad(\because\ \text{集合の冪等律}).
\end{aligned}`),
      paragraph([math(String.raw`a\notin\varnothing`), " かつ ", math(String.raw`a\in\{a\}`), " なので、左右とも二つの近傍割り当ては異なる。"]),
    ],
  },
  {
    id: "neighborhood_assignment_intersection_minimal_counterexample_theorem_minimal_size",
    kind: "theorem",
    title: { text: "非分配反例の最小基礎集合は二元である" },
    labels: ["theorem_minimal_carrier_size_for_composition_intersection_nondistributivity"],
    habitat: "N",
    statement: [
      paragraph([
        "合成近傍が点ごとの積に左から分配しない反例、および右から分配しない反例の最小基礎集合の元数は、どちらも ",
        math(String.raw`2\in\mathbb N`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_subsingleton_neighborhood_composition_distributes_over_intersection"),
        " により、基礎集合の元数が ", math(String.raw`0`), " または ", math(String.raw`1`),
        " ならば左右の反例は存在しない。",
      ]),
      paragraph([
        ref("claim_two_element_composition_intersection_nondistributivity"),
        " により、基礎集合の元数 ", math(String.raw`2`), " で左右それぞれの反例が存在する。したがって最小の元数はどちらも ",
        math(String.raw`2`), " である。",
      ]),
    ],
  },
]);
