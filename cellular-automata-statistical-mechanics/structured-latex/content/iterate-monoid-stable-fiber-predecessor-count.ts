/**
 * 章「安定ファイバー間の分岐個数」。
 * 一段発展の点ごとの逆像を有限集合として数え、完全逆像の等号から
 * 安定ファイバーの個数に対する保存式を導く。R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stable_fiber_branching_heading",
    kind: "heading",
    level: 1,
    title: { text: "安定ファイバー間の分岐個数" },
    labels: [],
  },
  {
    id: "iterate_monoid_stable_fiber_branching_definition_predecessor_set",
    kind: "definition",
    title: { text: "一段前像集合" },
    labels: ["def_iterate_monoid_stable_fiber_predecessor_set"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合上の自己写像を ",
        math(String.raw`F:X\to X`), " とする。各 ", math(String.raw`z\in X`),
        " の一段前像集合を",
      ]),
      displayMath(String.raw`\operatorname{Pre}_F(z):=\{y\in X\mid F(y)=z\}\subseteq X`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_branching_claim_predecessor_set_finite",
    kind: "claim",
    title: { text: "一段前像集合は有限集合である" },
    labels: ["claim_iterate_monoid_stable_fiber_predecessor_set_finite"],
    habitat: "finite",
    statement: [
      paragraph([
        "各 ", math(String.raw`z\in X`), " について ",
        math(String.raw`\operatorname{Pre}_F(z)`), " は有限集合である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_iterate_monoid_stable_fiber_predecessor_set"), " より ",
        math(String.raw`\operatorname{Pre}_F(z)\subseteq X`),
        " であり、有限集合の部分集合は有限集合である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_branching_definition_predecessor_count",
    kind: "definition",
    title: { text: "一段前像数" },
    labels: ["def_iterate_monoid_stable_fiber_predecessor_count"],
    habitat: "N",
    statement: [
      paragraph([math(String.raw`z\in X`), " と ", ref("def_iterate_monoid_stable_fiber_predecessor_set"),
        " の一段前像集合に対して"]),
      displayMath(String.raw`b_F(z):=\left|\operatorname{Pre}_F(z)\right|\in\mathbb N`),
      paragraph(["と定める。"])],
  },
  {
    id: "iterate_monoid_stable_fiber_branching_claim_disjoint_predecessors",
    kind: "claim",
    title: { text: "異なる元の一段前像集合は交わらない" },
    labels: ["claim_iterate_monoid_stable_fiber_predecessors_disjoint"],
    habitat: "finite",
    statement: [
      paragraph([math(String.raw`z,w\in X`), " と ", math(String.raw`z\ne w`),
        " に対し、一段前像集合（", ref("def_iterate_monoid_stable_fiber_predecessor_set"), "）は"]),
      displayMath(String.raw`\operatorname{Pre}_F(z)\cap\operatorname{Pre}_F(w)=\varnothing`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`y\in\operatorname{Pre}_F(z)\cap\operatorname{Pre}_F(w)`),
        " を仮定すると、一段前像集合の定義から ", math(String.raw`F(y)=z`),
        " かつ ", math(String.raw`F(y)=w`), " である。よって ", math(String.raw`z=w`),
        " となり、", math(String.raw`z\ne w`), " に反する。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_branching_claim_preimage_decomposition",
    kind: "claim",
    title: { text: "安定ファイバーの完全逆像は一段前像集合へ分解される" },
    labels: ["claim_iterate_monoid_stable_fiber_preimage_decomposition"],
    habitat: "finite",
    statement: [
      paragraph([math(String.raw`q\in Q_F`), " に対して"]),
      displayMath(String.raw`F^{-1}\!\left(B_F(\sigma_F(q))\right)
=\bigcup_{z\in B_F(\sigma_F(q))}\operatorname{Pre}_F(z)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([math(String.raw`y\in X`), " を取る。"]),
      displayMath(String.raw`\begin{aligned}
y\in F^{-1}\!\left(B_F(\sigma_F(q))\right)
&\Longleftrightarrow F(y)\in B_F(\sigma_F(q))
  \quad(\because\ \text{写像の完全逆像の定義})\\
&\Longleftrightarrow \exists z\in B_F(\sigma_F(q)),\ F(y)=z
  \quad(\because\ z:=F(y))\\
&\Longleftrightarrow \exists z\in B_F(\sigma_F(q)),\ y\in\operatorname{Pre}_F(z)
  \quad(\because\ \blkref{def_iterate_monoid_stable_fiber_predecessor_set})\\
&\Longleftrightarrow y\in\bigcup_{z\in B_F(\sigma_F(q))}\operatorname{Pre}_F(z)
  \quad(\because\ \text{有限合併への所属の定義}).
\end{aligned}`),
      paragraph(["任意の ", math(String.raw`y\in X`), " で所属が同値なので、集合は等しい。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_branching_claim_count_conservation",
    kind: "claim",
    title: { text: "一段前像数の総和は元の安定ファイバーの個数に等しい" },
    labels: ["claim_iterate_monoid_stable_fiber_predecessor_count_conservation"],
    habitat: "N",
    statement: [
      paragraph([math(String.raw`q\in Q_F`), " に対して"]),
      displayMath(String.raw`\left|B_F(q)\right|
=\sum_{z\in B_F(\sigma_F(q))}b_F(z)`),
      paragraph(["である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\left|B_F(q)\right|
&=\left|F^{-1}\!\left(B_F(\sigma_F(q))\right)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_stable_fiber_exact_preimage})\\
&=\left|\bigcup_{z\in B_F(\sigma_F(q))}\operatorname{Pre}_F(z)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_stable_fiber_preimage_decomposition})\\
&=\sum_{z\in B_F(\sigma_F(q))}\left|\operatorname{Pre}_F(z)\right|
  \quad(\because\ \blkref{claim_iterate_monoid_stable_fiber_predecessors_disjoint})\\
&=\sum_{z\in B_F(\sigma_F(q))}b_F(z)
  \quad(\because\ \blkref{def_iterate_monoid_stable_fiber_predecessor_count}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_branching_claim_finite_decidability",
    kind: "claim",
    title: { text: "安定ファイバー間の分岐個数は有限決定できる" },
    labels: ["claim_iterate_monoid_stable_fiber_branching_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合上の自己写像の有限表から、全ての ", math(String.raw`z\in X`),
        " に対する ", math(String.raw`\operatorname{Pre}_F(z)`), " と ", math(String.raw`b_F(z)`),
        "、および各 ", math(String.raw`q\in Q_F`), " に対する一段前像数の総和を、",
        "有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_stable_fiber_dynamics_finite_decidability"),
        " により ", math(String.raw`Q_F`), "、各 ", math(String.raw`B_F(q)`),
        "、および ", math(String.raw`\sigma_F`), " の表を有限決定できる。有限集合 ",
        math(String.raw`X`), " の全ての組 ", math(String.raw`(y,z)\in X\times X`),
        " について ", math(String.raw`F(y)=z`), " を検査すれば、全ての一段前像集合とその個数を得る。",
        "各 ", math(String.raw`B_F(\sigma_F(q))`), " 上で得られた自然数を有限加算すれば総和を得る。",
        "全ての走査対象は有限集合である。",
      ]),
    ],
  },
]);
