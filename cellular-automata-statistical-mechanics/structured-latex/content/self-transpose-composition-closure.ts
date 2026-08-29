/**
 * 章「自己転置な近傍割り当ての合成閉性」。
 * 自己転置な二つの近傍割り当ての合成が自己転置であることと可換性の同値を示し、
 * 二元舞台で合成閉性が破れる反例を与える。有限集合と有限部分集合だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "self_transpose_composition_closure_heading",
    kind: "heading",
    level: 1,
    title: { text: "自己転置な近傍割り当ての合成閉性" },
    labels: [],
  },
  {
    id: "self_transpose_composition_closure_claim_iff_commute",
    kind: "claim",
    title: { text: "自己転置な二つの合成が自己転置であることと可換性は同値である" },
    labels: ["claim_self_transpose_composition_iff_commute"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と自己転置な近傍割り当て ",
        math(String.raw`N,M\in\mathcal N(V)`), "、すなわち ",
        math(String.raw`N^{\mathsf T}=N`), " かつ ", math(String.raw`M^{\mathsf T}=M`),
        " を取る。このとき",
      ]),
      displayMath(String.raw`(N\star M)^{\mathsf T}=N\star M
\quad\Longleftrightarrow\quad
N\star M=M\star N`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(N\star M)^{\mathsf T}=N\star M
&\Longleftrightarrow M^{\mathsf T}\star N^{\mathsf T}=N\star M
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_reverses_composition})\\
&\Longleftrightarrow M\star N=N\star M
  \qquad(\because\ N^{\mathsf T}=N,\ M^{\mathsf T}=M)\\
&\Longleftrightarrow N\star M=M\star N
  \qquad(\because\ \text{等号の対称性}).
\end{aligned}`),
    ],
  },
  {
    id: "self_transpose_composition_closure_definition_two_element_witness",
    kind: "definition",
    title: { text: "合成閉性を破る二元舞台" },
    labels: ["def_self_transpose_composition_nonclosure_witness"],
    habitat: "finite",
    statement: [
      paragraph([
        "相異なる元からなる有限集合 ", math(String.raw`V_{\mathrm{st}}:=\{a,b\}`),
        " 上の近傍割り当て ", math(String.raw`N,M\in\mathcal N(V_{\mathrm{st}})`), " を",
      ]),
      displayMath(String.raw`N(a):=\{a\},\qquad N(b):=\varnothing,\qquad
M(a):=\{b\},\qquad M(b):=\{a\}`),
      paragraph(["で定める。"]),
    ],
  },
  {
    id: "self_transpose_composition_closure_claim_loop_witness_self_transpose",
    kind: "claim",
    title: { text: "自己ループの証人は自己転置である" },
    labels: ["claim_self_transpose_composition_loop_witness_is_self_transpose"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_self_transpose_composition_nonclosure_witness"), " の ", math(String.raw`N`), " は",
      ]),
      displayMath(String.raw`N^{\mathsf T}=N`),
      paragraph(["を満たす。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v,w\in V_{\mathrm{st}}`), " について、定義した有限表から"]),
      displayMath(String.raw`\begin{aligned}
w\in N(v)&\Longleftrightarrow v=w=a
  \qquad(\because\ \blkref{def_self_transpose_composition_nonclosure_witness})\\
&\Longleftrightarrow v\in N(w)
  \qquad(\because\ \text{等号の対称性}).
\end{aligned}`),
      paragraph([
        ref("claim_self_transpose_iff_symmetric_membership"),
        " の逆向きを適用すると自己転置性が従う。",
      ]),
    ],
  },
  {
    id: "self_transpose_composition_closure_claim_edge_witness_self_transpose",
    kind: "claim",
    title: { text: "二点を結ぶ証人は自己転置である" },
    labels: ["claim_self_transpose_composition_edge_witness_is_self_transpose"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_self_transpose_composition_nonclosure_witness"), " の ", math(String.raw`M`), " は",
      ]),
      displayMath(String.raw`M^{\mathsf T}=M`),
      paragraph(["を満たす。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v,w\in V_{\mathrm{st}}`), " について、定義した有限表から"]),
      displayMath(String.raw`\begin{aligned}
w\in M(v)&\Longleftrightarrow \{v,w\}=\{a,b\}
  \qquad(\because\ \blkref{def_self_transpose_composition_nonclosure_witness})\\
&\Longleftrightarrow v\in M(w)
  \qquad(\because\ \text{二元集合の等号は表示順序に依らない}).
\end{aligned}`),
      paragraph([
        ref("claim_self_transpose_iff_symmetric_membership"),
        " の逆向きを適用すると自己転置性が従う。",
      ]),
    ],
  },
  {
    id: "self_transpose_composition_closure_claim_nonclosure",
    kind: "claim",
    title: { text: "自己転置な近傍割り当て全体は合成で閉じない" },
    labels: ["claim_self_transpose_neighborhood_assignments_not_composition_closed"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_self_transpose_composition_nonclosure_witness"), " の ", math(String.raw`N,M`), " について ",
        math(String.raw`N\star M`), " は自己転置でない。したがって、自己転置な近傍割り当て全体は",
        "一般には合成近傍について閉じない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(N\star M)(a)
&=\bigcup_{u\in N(a)}M(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&=M(a)
  \qquad(\because\ \blkref{def_self_transpose_composition_nonclosure_witness})\\
&=\{b\}
  \qquad(\because\ \blkref{def_self_transpose_composition_nonclosure_witness}),\\[4pt]
(M\star N)(a)
&=\bigcup_{u\in M(a)}N(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&=N(b)
  \qquad(\because\ \blkref{def_self_transpose_composition_nonclosure_witness})\\
&=\varnothing
  \qquad(\because\ \blkref{def_self_transpose_composition_nonclosure_witness}).
\end{aligned}`),
      paragraph([
        math(String.raw`b\in\{b\}`), " かつ ", math(String.raw`b\notin\varnothing`),
        " なので ", math(String.raw`N\star M\neq M\star N`), " である。",
        ref("claim_self_transpose_composition_loop_witness_is_self_transpose"), "、",
        ref("claim_self_transpose_composition_edge_witness_is_self_transpose"), " と ",
        ref("claim_self_transpose_composition_iff_commute"), " より ", math(String.raw`N\star M`),
        " は自己転置でない。",
      ]),
    ],
  },
  {
    id: "self_transpose_composition_closure_claim_finite_decision",
    kind: "claim",
    title: { text: "自己転置な組の合成閉性は有限決定できる" },
    labels: ["claim_self_transpose_composition_closure_finitely_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`V`), " では、自己転置な近傍割り当ての各順序対について、",
        "合成が自己転置か否かを有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_self_transpose_neighborhood_assignments_finitely_decidable"), " により自己転置な割り当て全体を有限列挙できる。",
        ref("claim_finite_neighborhood_assignment_monoid_cardinality_decidable"), " により各順序対の二つの合成を有限計算できる。",
        ref("claim_self_transpose_composition_iff_commute"), " により、その二つの有限表の等号判定が求める判定である。",
      ]),
    ],
  },
]);
