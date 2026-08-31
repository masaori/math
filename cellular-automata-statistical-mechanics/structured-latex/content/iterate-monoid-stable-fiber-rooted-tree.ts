/**
 * 章「安定ファイバー上の一周期写像が定める根付き木」。
 * 一周期写像 R_F = F^{λ_F} が各安定ファイバーを保ち、安定像の元を唯一の不動点として
 * 全元を有限回の適用で根へ送ることから、根の自己ループを除いた一段の辺が有限根付き木を
 * なすことを導く。有限集合、自然数、写像の等号だけを使い、R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_definition_one_period_map",
    kind: "definition",
    title: { text: "一周期写像" },
    labels: ["def_iterate_monoid_one_period_map"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_minimal_positive_period"), " の最小正周期 ",
        math(String.raw`\lambda_F\in\mathbb{N}_{>0}`), " に対し、",
      ]),
      displayMath(String.raw`R_F:=F^{\lambda_F}:X\to X`),
      paragraph(["と定め、一周期写像と呼ぶ。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_multiple_iteration",
    kind: "claim",
    title: { text: "最小正周期の倍数だけの遅れは衝突開始後に消える" },
    labels: ["claim_iterate_monoid_period_multiple_propagates"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ", math(String.raw`n\in\mathbb{N}`), " と ",
        math(String.raw`d\in\mathbb{N}`), " について、",
        math(String.raw`n\ge\mu_F`), " なら写像 ",
        math(String.raw`X\to X`), " として",
      ]),
      displayMath(String.raw`F^{n+d\lambda_F}=F^{n}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n\ge\mu_F`), " を固定し、", math(String.raw`d`),
        " についての帰納法を行う。", math(String.raw`d=0`), " のとき、",
      ]),
      displayMath(String.raw`F^{n+0\cdot\lambda_F}=F^{n}\quad(\because\ 0\cdot\lambda_F=0\ \text{と加法の単位元則})`),
      paragraph([
        "である。", math(String.raw`F^{n+d\lambda_F}=F^{n}`), " と仮定する。",
        ref("def_iterate_monoid_minimal_positive_period"), " より ",
        math(String.raw`\lambda_F\in\Pi_F`), " であり、",
        math(String.raw`n+d\lambda_F\ge n\ge\mu_F`), " なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n+(d+1)\lambda_F}
&=F^{(n+d\lambda_F)+\lambda_F}
  \quad(\because\ \text{分配則と加法の結合則})\\
&=F^{n+d\lambda_F}
  \quad(\because\ \blkref{claim_iterate_monoid_period_propagates_after_collision_start})\\
&=F^{n}
  \quad(\because\ \text{帰納法の仮定}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_definition_reach_exponent",
    kind: "definition",
    title: { text: "根到達指数" },
    labels: ["def_iterate_monoid_root_reach_exponent"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_iterate_monoid_minimal_stable_period_multiple"), " の ",
        math(String.raw`e_F=\min D_F`), " は ",
        ref("def_iterate_monoid_stable_period_multiple_exponents"), " より ",
        math(String.raw`\lambda_F\mid e_F`), " を満たすので、",
      ]),
      displayMath(String.raw`e_F=m_F\,\lambda_F`),
      paragraph([
        "を満たす ", math(String.raw`m_F\in\mathbb{N}`),
        " がただ一つ存在する（", math(String.raw`\because`), " ",
        math(String.raw`\lambda_F\ge1`), " と自然数の乗法の簡約則）。この ",
        math(String.raw`m_F`), " を根到達指数と呼ぶ。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_step_composition",
    kind: "claim",
    title: { text: "最小正周期の倍数乗は一周期写像の合成で一段ずつ進む" },
    labels: ["claim_iterate_monoid_one_period_step_composition"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ", math(String.raw`d\in\mathbb{N}`), " について、写像 ",
        math(String.raw`X\to X`), " として",
      ]),
      displayMath(String.raw`F^{(d+1)\lambda_F}=R_F\circ F^{d\lambda_F}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
F^{(d+1)\lambda_F}
&=F^{\lambda_F+d\lambda_F}
  \quad(\because\ \text{分配則})\\
&=F^{\lambda_F}\circ F^{d\lambda_F}
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=R_F\circ F^{d\lambda_F}
  \quad(\because\ \blkref{def_iterate_monoid_one_period_map}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_preserves_fiber",
    kind: "claim",
    title: { text: "一周期写像は各安定ファイバーを保つ" },
    labels: ["claim_iterate_monoid_one_period_map_preserves_fiber"],
    habitat: "finite",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " と ",
        math(String.raw`y\in B_F(q)`), " について、",
        math(String.raw`R_F(y)\in B_F(q)`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
E_F(R_F(y))
&=(E_F\circ R_F)(y)
  \quad(\because\ \text{写像合成の定義})\\
&=(F^{e_F}\circ F^{\lambda_F})(y)
  \quad(\because\ \blkref{def_iterate_monoid_cycle_idempotent_candidate}\ \text{と}\ \blkref{def_iterate_monoid_one_period_map})\\
&=F^{e_F+\lambda_F}(y)
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^{e_F}(y)
  \quad(\because\ \blkref{claim_iterate_monoid_period_multiple_propagates}\ \text{を}\ n=e_F\ge\mu_F,\ d=1\ \text{に適用})\\
&=E_F(y)
  \quad(\because\ \blkref{def_iterate_monoid_cycle_idempotent_candidate})\\
&=q
  \quad(\because\ y\in B_F(q)\ \text{と}\ \blkref{def_iterate_monoid_stable_fiber}).
\end{aligned}`),
      paragraph([
        "ここで ", math(String.raw`e_F\ge\mu_F`), " は ",
        ref("def_iterate_monoid_stable_period_multiple_exponents"), " と ",
        ref("def_iterate_monoid_minimal_stable_period_multiple"), " による。",
        ref("def_iterate_monoid_stable_fiber"), " より ",
        math(String.raw`R_F(y)\in B_F(q)`), " である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_reaches_root",
    kind: "claim",
    title: { text: "根到達指数乗の一周期写像は全元を根へ送る" },
    labels: ["claim_iterate_monoid_one_period_map_reaches_root"],
    habitat: "finite",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " と ",
        math(String.raw`y\in B_F(q)`), " について、",
      ]),
      displayMath(String.raw`F^{m_F\lambda_F}(y)=q`),
      paragraph(["である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
F^{m_F\lambda_F}(y)
&=F^{e_F}(y)
  \quad(\because\ \blkref{def_iterate_monoid_root_reach_exponent})\\
&=E_F(y)
  \quad(\because\ \blkref{def_iterate_monoid_cycle_idempotent_candidate})\\
&=q
  \quad(\because\ y\in B_F(q)\ \text{と}\ \blkref{def_iterate_monoid_stable_fiber}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_root_fixed",
    kind: "claim",
    title: { text: "根は一周期写像の不動点である" },
    labels: ["claim_iterate_monoid_one_period_map_fixes_root"],
    habitat: "finite",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " について、",
        math(String.raw`R_F(q)=q`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
R_F(q)
&=F^{\lambda_F}(q)
  \quad(\because\ \blkref{def_iterate_monoid_one_period_map})\\
&=F^{\lambda_F}(E_F(q))
  \quad(\because\ \blkref{claim_iterate_monoid_cycle_idempotent_retracts_stable_image})\\
&=(F^{\lambda_F}\circ F^{e_F})(q)
  \quad(\because\ \blkref{def_iterate_monoid_cycle_idempotent_candidate}\ \text{と写像合成の定義})\\
&=F^{e_F+\lambda_F}(q)
  \quad(\because\ \blkref{claim_iterate_composition_addition}\ \text{と加法の交換則})\\
&=F^{e_F}(q)
  \quad(\because\ \blkref{claim_iterate_monoid_period_multiple_propagates}\ \text{を}\ n=e_F\ge\mu_F,\ d=1\ \text{に適用})\\
&=E_F(q)
  \quad(\because\ \blkref{def_iterate_monoid_cycle_idempotent_candidate})\\
&=q
  \quad(\because\ \blkref{claim_iterate_monoid_cycle_idempotent_retracts_stable_image}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_unique_fixed_point",
    kind: "claim",
    title: { text: "各安定ファイバー内で一周期写像の不動点は根だけである" },
    labels: ["claim_iterate_monoid_one_period_map_unique_fixed_point"],
    habitat: "finite",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " と ",
        math(String.raw`y\in B_F(q)`), " について、",
        math(String.raw`R_F(y)=y`), " なら ", math(String.raw`y=q`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ", math(String.raw`d\in\mathbb{N}`), " についての帰納法で ",
        math(String.raw`F^{d\lambda_F}(y)=y`), " を示す。",
        math(String.raw`d=0`), " のとき、",
      ]),
      displayMath(String.raw`F^{0\cdot\lambda_F}(y)=F^{0}(y)=y\quad(\because\ 0\cdot\lambda_F=0\ \text{と}\ \blkref{def_finite_self_map_iterate})`),
      paragraph([math(String.raw`F^{d\lambda_F}(y)=y`), " と仮定すると、"]),
      displayMath(String.raw`\begin{aligned}
F^{(d+1)\lambda_F}(y)
&=(R_F\circ F^{d\lambda_F})(y)
  \quad(\because\ \blkref{claim_iterate_monoid_one_period_step_composition})\\
&=R_F(F^{d\lambda_F}(y))
  \quad(\because\ \text{写像合成の定義})\\
&=R_F(y)
  \quad(\because\ \text{帰納法の仮定})\\
&=y
  \quad(\because\ \text{仮定}\ R_F(y)=y).
\end{aligned}`),
      paragraph([math(String.raw`d=m_F`), " と置くと、"]),
      displayMath(String.raw`\begin{aligned}
y
&=F^{m_F\lambda_F}(y)
  \quad(\because\ \text{上の帰納法})\\
&=q
  \quad(\because\ \blkref{claim_iterate_monoid_one_period_map_reaches_root}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_definition_edges",
    kind: "definition",
    title: { text: "安定ファイバーの根付き辺集合" },
    labels: ["def_iterate_monoid_fiber_tree_edges"],
    habitat: "finite",
    statement: [
      paragraph([math(String.raw`q\in Q_F`), " に対し、"]),
      displayMath(String.raw`T_F(q):=\{\,(y,R_F(y))\mid y\in B_F(q)\setminus\{q\}\,\}\subseteq B_F(q)\times B_F(q)`),
      paragraph([
        "と定め、", math(String.raw`q`), " の根付き辺集合と呼ぶ。第二成分が ",
        math(String.raw`B_F(q)`), " に属することは ",
        ref("claim_iterate_monoid_one_period_map_preserves_fiber"),
        " による。定義から、第一成分が ", math(String.raw`y\in B_F(q)\setminus\{q\}`),
        " である辺はちょうど一つ（第二成分は ", math(String.raw`R_F(y)`),
        " に定まる）であり、第一成分が ", math(String.raw`q`), " である辺は存在しない。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_edge_count",
    kind: "claim",
    title: { text: "根付き辺集合の辺数は頂点数より一つ少ない" },
    labels: ["claim_iterate_monoid_fiber_tree_edge_count"],
    habitat: "N",
    statement: [
      paragraph(["すべての ", math(String.raw`q\in Q_F`), " について、"]),
      displayMath(String.raw`|T_F(q)|=|B_F(q)|-1`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "写像 ", math(String.raw`B_F(q)\setminus\{q\}\to T_F(q)`), "、",
        math(String.raw`y\mapsto(y,R_F(y))`), " は ",
        ref("def_iterate_monoid_fiber_tree_edges"),
        " より全射である。第一成分が等しい二つの像は元が等しいので単射でもある。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
|T_F(q)|
&=|B_F(q)\setminus\{q\}|
  \quad(\because\ \text{有限集合間の全単射は個数を保つ})\\
&=|B_F(q)|-1
  \quad(\because\ q\in B_F(q).\ \blkref{claim_iterate_monoid_stable_representative_belongs_to_fiber}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_definition_depth",
    kind: "definition",
    title: { text: "根への深さ" },
    labels: ["def_iterate_monoid_fiber_tree_depth"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`q\in Q_F`), " と ", math(String.raw`y\in B_F(q)`), " に対し、集合 ",
        math(String.raw`\{\,d\in\mathbb{N}\mid F^{d\lambda_F}(y)=q\,\}`), " は ",
        ref("claim_iterate_monoid_one_period_map_reaches_root"), " より ",
        math(String.raw`m_F`), " を含むので空でない。自然数の整列性により、その最小元を",
      ]),
      displayMath(String.raw`d_F(y):=\min\{\,d\in\mathbb{N}\mid F^{d\lambda_F}(y)=q\,\}\in\mathbb{N}`),
      paragraph([
        "と定め、", math(String.raw`y`), " の根への深さと呼ぶ（",
        math(String.raw`q=E_F(y)`), " は ",
        ref("claim_iterate_monoid_stable_fiber_unique_representative"),
        " より ", math(String.raw`y`), " から一意に定まる）。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_depth_zero_iff_root",
    kind: "claim",
    title: { text: "深さが零であることと根であることは同値である" },
    labels: ["claim_iterate_monoid_fiber_tree_depth_zero_iff_root"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " と ",
        math(String.raw`y\in B_F(q)`), " について、",
        math(String.raw`d_F(y)=0`), " と ", math(String.raw`y=q`), " は同値である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`d_F(y)=0`), " なら、", ref("def_iterate_monoid_fiber_tree_depth"), " より"]),
      displayMath(String.raw`\begin{aligned}
q
&=F^{0\cdot\lambda_F}(y)
  \quad(\because\ d=0\ \text{が最小元として集合に属する})\\
&=F^{0}(y)
  \quad(\because\ 0\cdot\lambda_F=0)\\
&=y
  \quad(\because\ \blkref{def_finite_self_map_iterate}).
\end{aligned}`),
      paragraph([
        "逆に ", math(String.raw`y=q`), " なら ",
        math(String.raw`F^{0}(y)=y=q`), "（", math(String.raw`\because`), " ",
        ref("def_finite_self_map_iterate"), "）なので ", math(String.raw`0`),
        " が集合に属し、最小元は ", math(String.raw`0`), " である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_depth_decrement",
    kind: "claim",
    title: { text: "一周期写像は非根の深さをちょうど一つ減らす" },
    labels: ["claim_iterate_monoid_fiber_tree_depth_decrement"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " と ",
        math(String.raw`y\in B_F(q)\setminus\{q\}`), " について、",
        math(String.raw`d_F(y)\ge1`), " であり、",
      ]),
      displayMath(String.raw`d_F(R_F(y))=d_F(y)-1`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`d:=d_F(y)`), " と置く。",
        math(String.raw`y\ne q`), " なので ",
        ref("claim_iterate_monoid_fiber_tree_depth_zero_iff_root"), " より ",
        math(String.raw`d\ne0`), "、したがって ", math(String.raw`d\ge1`), " である。",
        ref("claim_iterate_monoid_one_period_map_preserves_fiber"), " より ",
        math(String.raw`R_F(y)\in B_F(q)`), " なので ",
        math(String.raw`d_F(R_F(y))`), " は定義される。まず",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{(d-1)\lambda_F}(R_F(y))
&=(F^{(d-1)\lambda_F}\circ R_F)(y)
  \quad(\because\ \text{写像合成の定義})\\
&=F^{((d-1)+1)\lambda_F}(y)
  \quad(\because\ \blkref{def_iterate_monoid_one_period_map}\ \text{と}\ \blkref{claim_iterate_composition_addition}\ \text{と分配則})\\
&=F^{d\lambda_F}(y)
  \quad(\because\ (d-1)+1=d.\ d\ge1)\\
&=q
  \quad(\because\ \blkref{def_iterate_monoid_fiber_tree_depth}).
\end{aligned}`),
      paragraph([
        "よって ", ref("def_iterate_monoid_fiber_tree_depth"), " の最小性から ",
        math(String.raw`d_F(R_F(y))\le d-1`), " である。次に ",
        math(String.raw`k:=d_F(R_F(y))`), " と置くと、",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{(k+1)\lambda_F}(y)
&=(F^{k\lambda_F}\circ R_F)(y)
  \quad(\because\ \blkref{def_iterate_monoid_one_period_map}\ \text{と}\ \blkref{claim_iterate_composition_addition}\ \text{と分配則})\\
&=F^{k\lambda_F}(R_F(y))
  \quad(\because\ \text{写像合成の定義})\\
&=q
  \quad(\because\ \blkref{def_iterate_monoid_fiber_tree_depth}).
\end{aligned}`),
      paragraph([
        "よって ", ref("def_iterate_monoid_fiber_tree_depth"), " の最小性から ",
        math(String.raw`d\le k+1`), "、すなわち ", math(String.raw`d-1\le k`),
        " である。二つの不等式と ", math(String.raw`\mathbb{N}`),
        " の反対称性から ", math(String.raw`k=d-1`), " を得る。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_no_cycle",
    kind: "claim",
    title: { text: "根付き辺集合に有向閉路は存在しない" },
    labels: ["claim_iterate_monoid_fiber_tree_no_cycle"],
    habitat: "finite",
    statement: [
      paragraph([
        "すべての ", math(String.raw`q\in Q_F`), " と ",
        math(String.raw`n\in\mathbb{N}_{>0}`), " について、",
        math(String.raw`y_0,y_1,\ldots,y_n\in B_F(q)`), " で ",
        math(String.raw`y_n=y_0`), " かつ、すべての ",
        math(String.raw`i\in[0,n-1]_{\mathbb{N}}`), " で ",
        math(String.raw`(y_i,y_{i+1})\in T_F(q)`),
        " となる列は存在しない。",
      ]),
    ],
    proof: [
      paragraph([
        "そのような列が存在すると仮定する。各 ",
        math(String.raw`i\in[0,n-1]_{\mathbb{N}}`), " について、",
        ref("def_iterate_monoid_fiber_tree_edges"), " より ",
        math(String.raw`y_i\in B_F(q)\setminus\{q\}`), " かつ ",
        math(String.raw`y_{i+1}=R_F(y_i)`), " なので、",
        ref("claim_iterate_monoid_fiber_tree_depth_decrement"), " より ",
        math(String.raw`d_F(y_i)\ge1`), " かつ ",
        math(String.raw`d_F(y_{i+1})=d_F(y_i)-1`), " である。",
        math(String.raw`i`), " についての帰納法により、すべての ",
        math(String.raw`i\in[0,n]_{\mathbb{N}}`), " で ",
        math(String.raw`d_F(y_0)\ge i`), " かつ ",
        math(String.raw`d_F(y_i)=d_F(y_0)-i`), " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
d_F(y_0)
&=d_F(y_n)
  \quad(\because\ y_n=y_0)\\
&=d_F(y_0)-n
  \quad(\because\ \text{上の帰納法}).
\end{aligned}`),
      paragraph([
        "両辺から ", math(String.raw`d_F(y_0)-n`), " を移項すると ",
        math(String.raw`n=0`), " となり、仮定 ",
        math(String.raw`n\ge1`), " に矛盾する。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_definition_rooted_tree",
    kind: "definition",
    title: { text: "安定ファイバーの根付き木" },
    labels: ["def_iterate_monoid_stable_fiber_rooted_tree"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`q\in Q_F`), " に対し、組 ",
        math(String.raw`(B_F(q),\,q,\,T_F(q))`),
        " を安定ファイバーの根付き木と呼ぶ。この呼び名は次の既証明の性質による: 頂点集合 ",
        math(String.raw`B_F(q)`), " は有限で ",
        math(String.raw`q\in B_F(q)`), "（",
        ref("claim_iterate_monoid_stable_representative_belongs_to_fiber"),
        "）、根 ", math(String.raw`q`), " を第一成分とする辺は無く、各非根頂点を第一成分とする辺はちょうど一つ（",
        ref("def_iterate_monoid_fiber_tree_edges"),
        "）、各頂点は辺を ", math(String.raw`d_F`),
        " の値の回数だけ辿って根に達し（",
        ref("claim_iterate_monoid_fiber_tree_depth_decrement"), " と ",
        ref("claim_iterate_monoid_fiber_tree_depth_zero_iff_root"),
        "）、有向閉路は存在しない（",
        ref("claim_iterate_monoid_fiber_tree_no_cycle"), "）。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_rooted_tree_claim_finite_decidability",
    kind: "claim",
    title: { text: "根付き木は有限決定できる" },
    labels: ["claim_iterate_monoid_fiber_tree_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合上の自己写像の有限表から、すべての ", math(String.raw`q\in Q_F`),
        " について、辺集合 ", math(String.raw`T_F(q)`), "、各 ",
        math(String.raw`y\in B_F(q)`), " の深さ ", math(String.raw`d_F(y)`),
        "、および各 ", math(String.raw`y\in B_F(q)`), " の分岐数（",
        math(String.raw`T_F(q)`), " の第二成分が ", math(String.raw`y`),
        " に等しい辺の個数）を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_minimal_period_finite_decidability"), " により ",
        math(String.raw`\lambda_F`), " を、",
        ref("claim_iterate_monoid_cycle_idempotent_finite_decidability"), " により ",
        math(String.raw`e_F`), " を有限決定でき、",
        math(String.raw`m_F=e_F/\lambda_F`), " は自然数の有限除法で決まる（",
        ref("def_iterate_monoid_root_reach_exponent"), "）。有限集合 ",
        math(String.raw`X`), " の各元へ ", math(String.raw`F`), " を ",
        math(String.raw`\lambda_F`), " 回適用すれば ", math(String.raw`R_F`),
        " の表を得る（", ref("def_iterate_monoid_one_period_map"), "）。",
        ref("claim_iterate_monoid_stable_fibers_finite_decidability"), " により ",
        math(String.raw`Q_F`), " と全ての ", math(String.raw`B_F(q)`),
        " を有限決定できる。",
      ]),
      paragraph([
        "辺集合は、各 ", math(String.raw`y\in B_F(q)\setminus\{q\}`), " について対 ",
        math(String.raw`(y,R_F(y))`), " を表から読めば得られる（",
        ref("def_iterate_monoid_fiber_tree_edges"), "）。深さは、各 ",
        math(String.raw`y\in B_F(q)`), " について ",
        math(String.raw`d=0,1,\ldots,m_F`), " の順に ",
        math(String.raw`F^{d\lambda_F}(y)=q`), " を検査し、最初に成り立つ ",
        math(String.raw`d`), " を返せば得られる。",
        ref("claim_iterate_monoid_one_period_map_reaches_root"),
        " によりこの走査は有限回で停止し、返す値は ",
        ref("def_iterate_monoid_fiber_tree_depth"), " の最小元である。分岐数は、有限集合 ",
        math(String.raw`T_F(q)`), " の元のうち第二成分が ", math(String.raw`y`),
        " に等しいものを数えれば得られる。",
      ]),
      paragraph(["この検査は有限集合と自然数だけで閉じる。実数、複素数、極限、完備化は使わない。"]),
    ],
  },
]);
