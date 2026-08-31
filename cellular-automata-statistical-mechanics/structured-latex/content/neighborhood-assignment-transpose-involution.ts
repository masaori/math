/**
 * 章「近傍割り当ての転置対合」。
 * 近傍割り当てを有限二項関係として逆向きに読み、転置が合成順序を反転する対合であることを示す。
 * 有限集合、有限部分集合、所属判定だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_transpose_involution_definition_transpose",
    kind: "definition",
    title: { text: "近傍割り当ての転置" },
    labels: ["def_neighborhood_assignment_transpose"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、転置近傍割り当て ",
        math(String.raw`N^{\mathsf T}\in\mathcal N(V)`), " を",
      ]),
      displayMath(String.raw`N^{\mathsf T}(w):=\{v\in V\mid w\in N(v)\}\qquad(w\in V)`),
      paragraph([
        "で定める。", math(String.raw`V`), " は有限なので右辺は有限部分集合であり、",
        math(String.raw`N^{\mathsf T}`), " は有限舞台上の近傍割り当てである。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_transpose_involution_claim_membership",
    kind: "claim",
    title: { text: "転置は近傍所属の向きを逆にする" },
    labels: ["claim_neighborhood_assignment_transpose_membership"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`v\in N^{\mathsf T}(w)\Longleftrightarrow w\in N(v)`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph([
        "これは ", ref("def_neighborhood_assignment_transpose"),
        " の右辺の所属条件そのものである。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_transpose_involution_claim_involution",
    kind: "claim",
    title: { text: "転置は対合である" },
    labels: ["claim_neighborhood_assignment_transpose_involutive"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`(N^{\mathsf T})^{\mathsf T}=N`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph(["任意の ", math(String.raw`v,w\in V`), " を取ると"]),
      displayMath(String.raw`\begin{aligned}
w\in(N^{\mathsf T})^{\mathsf T}(v)
&\Longleftrightarrow v\in N^{\mathsf T}(w)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership})\\
&\Longleftrightarrow w\in N(v)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership}).
\end{aligned}`),
      paragraph([
        math(String.raw`w`), " の任意性と集合の外延性、さらに ", math(String.raw`v`),
        " の任意性と写像の外延性により主張が従う。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_transpose_involution_claim_composition_reversal",
    kind: "claim",
    title: { text: "転置は合成近傍の順序を逆にする" },
    labels: ["claim_neighborhood_assignment_transpose_reverses_composition"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N,M\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`(N\star M)^{\mathsf T}=M^{\mathsf T}\star N^{\mathsf T}`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph(["任意の ", math(String.raw`v,w\in V`), " を取る。定義を一段ずつ展開すると"]),
      displayMath(String.raw`\begin{aligned}
w\in(N\star M)^{\mathsf T}(v)
&\Longleftrightarrow v\in(N\star M)(w)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership})\\
&\Longleftrightarrow \exists u\in N(w),\ v\in M(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&\Longleftrightarrow \exists u\in M^{\mathsf T}(v),\ w\in N^{\mathsf T}(u)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership})\\
&\Longleftrightarrow w\in(M^{\mathsf T}\star N^{\mathsf T})(v)
  \qquad(\because\ \blkref{def_composed_neighborhood}).
\end{aligned}`),
      paragraph(["所属条件の同値と二回の外延性により主張が従う。"]),
    ],
  },
  {
    id: "neighborhood_assignment_transpose_involution_claim_lattice_operations",
    kind: "claim",
    title: { text: "転置は点ごとの和と積および単位元を保つ" },
    labels: ["claim_neighborhood_assignment_transpose_preserves_lattice_operations"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N,M\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`(N\sqcup M)^{\mathsf T}=N^{\mathsf T}\sqcup M^{\mathsf T},\qquad
(N\sqcap M)^{\mathsf T}=N^{\mathsf T}\sqcap M^{\mathsf T},\qquad
I_V^{\mathsf T}=I_V`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph(["任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in(N\sqcup M)^{\mathsf T}(v)
&\Longleftrightarrow v\in N(w)\cup M(w)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership},\ \blkref{def_neighborhood_assignment_pointwise_union})\\
&\Longleftrightarrow w\in N^{\mathsf T}(v)\cup M^{\mathsf T}(v)
  \qquad(\because\ \text{合併への所属},\ \blkref{claim_neighborhood_assignment_transpose_membership}),\\
w\in(N\sqcap M)^{\mathsf T}(v)
&\Longleftrightarrow v\in N(w)\cap M(w)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership},\ \blkref{def_neighborhood_assignment_pointwise_intersection})\\
&\Longleftrightarrow w\in N^{\mathsf T}(v)\cap M^{\mathsf T}(v)
  \qquad(\because\ \text{共通部分への所属},\ \blkref{claim_neighborhood_assignment_transpose_membership}),\\
w\in I_V^{\mathsf T}(v)
&\Longleftrightarrow v\in\{w\}
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership},\ \blkref{def_identity_neighborhood_assignment})\\
&\Longleftrightarrow w\in\{v\}
  \qquad(\because\ \text{等号の対称性})\\
&\Longleftrightarrow w\in I_V(v)
  \qquad(\because\ \blkref{def_identity_neighborhood_assignment}).
\end{aligned}`),
      paragraph(["各同値に集合と写像の外延性を適用すると三つの等号を得る。"]),
    ],
  },
  {
    id: "neighborhood_assignment_transpose_involution_claim_finite_decision",
    kind: "claim",
    title: { text: "転置表と対合法則は有限決定できる" },
    labels: ["claim_neighborhood_assignment_transpose_finitely_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        "転置写像 ", math(String.raw`N\mapsto N^{\mathsf T}`), " の全表と、",
        ref("claim_neighborhood_assignment_transpose_involutive"), " から ",
        ref("claim_neighborhood_assignment_transpose_preserves_lattice_operations"),
        " までの各等号は有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_finite_neighborhood_assignment_monoid_cardinality_decidable"), " により ",
        math(String.raw`\mathcal N(V)`), " は ", math(String.raw`2^{|V|^2}\in\mathbb N`),
        " 元の有限集合である。各 ", math(String.raw`N`), " と各 ", math(String.raw`v,w\in V`),
        " について ", math(String.raw`w\in N(v)`), " を判定すれば ",
        math(String.raw`N^{\mathsf T}`), " の全値を得る。得られた有限表上で、各等号を全ての入力について比較できる。",
      ]),
    ],
  },
]);
