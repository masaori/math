/**
 * 章「安定ファイバーの層別分岐個数」。
 * 層別完全逆像と一段前像集合への分解を組み合わせ、各深さへ流れ込む
 * 一段前像数の保存式を導く。有限集合と自然数だけを使い、R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stable_fiber_layer_branching_heading",
    kind: "heading",
    level: 1,
    title: { text: "安定ファイバーの層別分岐個数" },
    labels: [],
  },
  {
    id: "iterate_monoid_stable_fiber_layer_branching_claim_subset_preimage_decomposition",
    kind: "claim",
    title: { text: "有限元集合の完全逆像は一段前像集合へ分解される" },
    labels: ["claim_iterate_monoid_finite_subset_preimage_decomposition"],
    habitat: "finite",
    statement: [
      paragraph(["各有限部分集合 ", math(String.raw`T\subseteq X`), " に対して"]),
      displayMath(String.raw`F^{-1}(T)=\bigcup_{z\in T}\operatorname{Pre}_F(z)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([math(String.raw`y\in X`), " を取る。"]),
      displayMath(String.raw`\begin{aligned}
y\in F^{-1}(T)
&\Longleftrightarrow F(y)\in T
  \quad(\because\ \text{写像の完全逆像の定義})\\
&\Longleftrightarrow \exists z\in T,\ F(y)=z
  \quad(\because\ z:=F(y))\\
&\Longleftrightarrow \exists z\in T,\ y\in\operatorname{Pre}_F(z)
  \quad(\because\ \blkref{def_iterate_monoid_stable_fiber_predecessor_set})\\
&\Longleftrightarrow y\in\bigcup_{z\in T}\operatorname{Pre}_F(z)
  \quad(\because\ \text{有限合併への所属の定義}).
\end{aligned}`),
      paragraph(["任意の ", math(String.raw`y\in X`), " で所属が同値なので、集合は等しい。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_positive_layer_branching_claim",
    kind: "claim",
    title: { text: "正の層へ流れ込む一段前像数は一つ上の層の個数に等しい" },
    labels: ["claim_iterate_monoid_positive_depth_layer_predecessor_count"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ", math(String.raw`q\in Q_F`), " と ", math(String.raw`k\in\mathbb N_{>0}`), " に対して",
      ]),
      displayMath(String.raw`\left|L_F(q,k+1)\right|
=\sum_{z\in L_F(\sigma_F(q),k)}b_F(z)`),
      paragraph(["である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\left|L_F(q,k+1)\right|
&=\left|F^{-1}\!\left(L_F(\sigma_F(q),k)\right)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_positive_depth_layer_exact_preimage})\\
&=\left|\bigcup_{z\in L_F(\sigma_F(q),k)}\operatorname{Pre}_F(z)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_finite_subset_preimage_decomposition})\\
&=\sum_{z\in L_F(\sigma_F(q),k)}\left|\operatorname{Pre}_F(z)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_stable_fiber_predecessors_disjoint})\\
&=\sum_{z\in L_F(\sigma_F(q),k)}b_F(z)
  \quad(\because\ \blkref{def_iterate_monoid_stable_fiber_predecessor_count}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_zero_layer_branching_claim",
    kind: "claim",
    title: { text: "零層へ流れ込む一段前像数は零層と一層の個数の和に等しい" },
    labels: ["claim_iterate_monoid_zero_depth_layer_predecessor_count"],
    habitat: "N",
    statement: [
      paragraph(["各 ", math(String.raw`q\in Q_F`), " に対して"]),
      displayMath(String.raw`\left|L_F(q,0)\right|+\left|L_F(q,1)\right|
=\sum_{z\in L_F(\sigma_F(q),0)}b_F(z)`),
      paragraph(["である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\left|L_F(q,0)\right|+\left|L_F(q,1)\right|
&=\left|L_F(q,0)\cup L_F(q,1)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_stable_fiber_depth_partition})\\
&=\left|F^{-1}\!\left(L_F(\sigma_F(q),0)\right)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_zero_depth_layer_exact_preimage})\\
&=\left|\bigcup_{z\in L_F(\sigma_F(q),0)}\operatorname{Pre}_F(z)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_finite_subset_preimage_decomposition})\\
&=\sum_{z\in L_F(\sigma_F(q),0)}\left|\operatorname{Pre}_F(z)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_stable_fiber_predecessors_disjoint})\\
&=\sum_{z\in L_F(\sigma_F(q),0)}b_F(z)
  \quad(\because\ \blkref{def_iterate_monoid_stable_fiber_predecessor_count}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_layer_branching_finite_decidability_claim",
    kind: "claim",
    title: { text: "層別分岐個数は有限決定できる" },
    labels: ["claim_iterate_monoid_depth_layer_branching_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合上の自己写像の有限表から、全ての安定ファイバーの層について、一段前像数の層別総和と",
        "上の二つの等式を有限回の元の等号検査と自然数の有限加算で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_stable_fiber_depth_finite_decidability"), " により全ての ",
        math(String.raw`L_F(q,k)`), " とその個数を有限決定できる。",
        ref("claim_iterate_monoid_stable_fiber_branching_finite_decidability"), " により全ての ",
        math(String.raw`b_F(z)`), " を有限決定できる。各有限層の元 ",
        math(String.raw`z`), " に対応する自然数 ", math(String.raw`b_F(z)`),
        " を有限加算し、既に得た層の個数と比較すればよい。実数、複素数、極限、完備化は使わない。",
      ]),
    ],
  },
]);
