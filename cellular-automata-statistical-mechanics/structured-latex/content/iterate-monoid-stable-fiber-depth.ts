/**
 * 章「安定ファイバーの最小前周期層」。
 * 既に定義した最小前周期と安定ファイバーだけから、各ファイバーの有限な層分解と
 * 一段発展による正の層の降下を導く。有限集合と自然数だけを使い、R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stable_fiber_depth_heading",
    kind: "heading",
    level: 1,
    title: { text: "安定ファイバーの最小前周期層" },
    labels: [],
  },
  {
    id: "iterate_monoid_stable_fiber_depth_definition",
    kind: "definition",
    title: { text: "安定ファイバーの最小前周期層" },
    labels: ["def_iterate_monoid_stable_fiber_depth_layer"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_stable_fiber"), " の安定ファイバー ",
        math(String.raw`B_F(q)`), " と ", ref("def_min_preperiod"), " の最小前周期 ",
        math(String.raw`\mu(y)\in\mathbb{N}`), " を用いる。各 ",
        math(String.raw`q\in Q_F`), " と ", math(String.raw`k\in\mathbb{N}`), " に対し、",
      ]),
      displayMath(String.raw`L_F(q,k):=\{\,y\in B_F(q)\mid \mu(y)=k\,\}\subseteq X`),
      paragraph(["と定め、", math(String.raw`q`), " の最小前周期 ", math(String.raw`k`), " の層と呼ぶ。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_depth_partition_claim",
    kind: "claim",
    title: { text: "各安定ファイバーは最小前周期層にただ一通り分かれる" },
    labels: ["claim_iterate_monoid_stable_fiber_depth_partition"],
    habitat: "finite",
    statement: [
      paragraph([
        "各 ", math(String.raw`q\in Q_F`), " と ", math(String.raw`y\in B_F(q)`),
        " に対し、", math(String.raw`y\in L_F(q,k)`), " を満たす ",
        math(String.raw`k\in\mathbb{N}`), " がただ一つ存在し、その値は ",
        math(String.raw`k=\mu(y)`), " である。したがって異なる ",
        math(String.raw`k,\ell\in\mathbb{N}`), " に対して ",
        math(String.raw`L_F(q,k)\cap L_F(q,\ell)=\varnothing`), " である。",
      ]),
    ],
    proof: [
      paragraph([ref("def_min_preperiod"), " により ", math(String.raw`\mu(y)\in\mathbb{N}`), " である。"]),
      displayMath(String.raw`y\in L_F(q,\mu(y))\quad(\because\ y\in B_F(q)\ \text{かつ}\ \mu(y)=\mu(y))`),
      paragraph([
        "また ", math(String.raw`y\in L_F(q,k)\cap L_F(q,\ell)`), " なら、",
        ref("def_iterate_monoid_stable_fiber_depth_layer"), " より",
      ]),
      displayMath(String.raw`k=\mu(y)=\ell`),
      paragraph(["なので一意性と非交差を得る。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_depth_decrement_claim",
    kind: "claim",
    title: { text: "一段発展は正の最小前周期を一つ減らす" },
    labels: ["claim_iterate_monoid_min_preperiod_decrements"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ", math(String.raw`y\in X`), " について ", math(String.raw`\mu(y)>0`), " なら",
      ]),
      displayMath(String.raw`\mu(F(y))=\mu(y)-1`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m:=\mu(y)>0`), "、", math(String.raw`p:=\pi(y)\ge1`), " と置く。",
        ref("def_min_period"), " により ", math(String.raw`(m,p)\in P(y)`), " である。任意の ",
        math(String.raw`n\ge m-1`), " に対して ", math(String.raw`n+1\ge m`), " なので、",
        ref("def_periodicity_pairs"), " の全称文を ", math(String.raw`n+1`), " に適用すると",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n+p}(F(y))
&=F^{n+p+1}(y)\quad(\because\ \blkref{def_global_map_iterate})\\
&=F^{n+1}(y)\quad(\because\ (m,p)\in P(y)\ \text{かつ}\ n+1\ge m)\\
&=F^n(F(y))\quad(\because\ \blkref{def_global_map_iterate}).
\end{aligned}`),
      paragraph([
        "よって ", math(String.raw`(m-1,p)\in P(F(y))`), " であり、",
        ref("def_min_preperiod"), " の最小性から ", math(String.raw`\mu(F(y))\le m-1`), "。",
      ]),
      paragraph([
        math(String.raw`j:=\mu(F(y))`), "、", math(String.raw`r:=\pi(F(y))`), " と置く。",
        ref("def_min_period"), " により ", math(String.raw`(j,r)\in P(F(y))`), "。任意の ",
        math(String.raw`n\ge j+1`), " に対して ", math(String.raw`h:=n-1\ge j`), " と置くと",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n+r}(y)
&=F^{h+r}(F(y))\quad(\because\ n=h+1\ \text{と}\ \blkref{def_global_map_iterate})\\
&=F^h(F(y))\quad(\because\ (j,r)\in P(F(y))\ \text{かつ}\ h\ge j)\\
&=F^n(y)\quad(\because\ n=h+1\ \text{と}\ \blkref{def_global_map_iterate}).
\end{aligned}`),
      paragraph([
        "よって ", math(String.raw`(j+1,r)\in P(y)`), " であり、",
        ref("def_min_preperiod"), " の最小性から ", math(String.raw`m\le j+1`), "、したがって ",
        math(String.raw`m-1\le j=\mu(F(y))`), "。二つの不等式と ",
        math(String.raw`\mathbb{N}`), " の反対称性から結論を得る。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_depth_transition_claim",
    kind: "claim",
    title: { text: "一段発展は正の層を一つ下の次ファイバーへ写す" },
    labels: ["claim_iterate_monoid_stable_fiber_depth_transition"],
    habitat: "finite",
    statement: [
      paragraph([
        "各 ", math(String.raw`q\in Q_F`), " と ", math(String.raw`k\in\mathbb{N}_{>0}`), " について",
      ]),
      displayMath(String.raw`F\bigl(L_F(q,k)\bigr)\subseteq L_F(\sigma_F(q),k-1)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`y\in L_F(q,k)`), " を取る。", ref("def_iterate_monoid_stable_fiber_depth_layer"),
        " より ", math(String.raw`y\in B_F(q)`), " かつ ", math(String.raw`\mu(y)=k>0`), "。",
        ref("claim_iterate_monoid_stable_fiber_exact_preimage"), " より ",
        math(String.raw`F(y)\in B_F(\sigma_F(q))`), " である。また ",
        ref("claim_iterate_monoid_min_preperiod_decrements"), " より",
      ]),
      displayMath(String.raw`\mu(F(y))=\mu(y)-1=k-1`),
      paragraph([
        "なので ", ref("def_iterate_monoid_stable_fiber_depth_layer"), " より ",
        math(String.raw`F(y)\in L_F(\sigma_F(q),k-1)`), "。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_depth_count_claim",
    kind: "claim",
    title: { text: "安定ファイバーの層ごとの個数は有限決定できる" },
    labels: ["claim_iterate_monoid_stable_fiber_depth_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([math(String.raw`M:=|X|`), " と置く。各 ", math(String.raw`q\in Q_F`), " について"]),
      displayMath(String.raw`|B_F(q)|=\sum_{k\in[0,M]_{\mathbb{N}}}|L_F(q,k)|`),
      paragraph([
        "であり、全ての層とその個数は有限集合上の自己写像の有限表から有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_min_preperiod_period_bound"), " と ", ref("def_min_period"), " の ",
        math(String.raw`\pi(y)\ge1`), " により、全ての ", math(String.raw`y\in X`), " で ",
        math(String.raw`\mu(y)\le M`), "。", ref("claim_iterate_monoid_stable_fiber_depth_partition"),
        " により各 ", math(String.raw`y\in B_F(q)`), " は添字区間 ",
        math(String.raw`[0,M]_{\mathbb{N}}`), " のただ一つの層に属する。したがって有限集合の非交和の個数から表示式を得る。",
      ]),
      paragraph([
        ref("claim_iterate_monoid_stable_fibers_finite_decidability"), " により ",
        math(String.raw`Q_F`), " と全ての ", math(String.raw`B_F(q)`), " を有限決定でき、",
        ref("claim_min_preperiod_period_finite_decidability"), " により各元の ",
        math(String.raw`\mu(y)`), " を有限決定できる。各元をその値の層へ一度だけ加え、各有限集合の元を数えればよい。",
      ]),
      paragraph(["この検査は有限集合と自然数だけで閉じる。実数、複素数、極限、完備化は使わない。"]),
    ],
  },
]);
