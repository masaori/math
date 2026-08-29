/**
 * 章「反復モノイドの過渡部と巡回部への分解」。
 * 最小衝突開始位置より前の相異なる反復写像と、最小正周期で巡回する安定後の反復写像を分離し、
 * 反復モノイドの元数を両部分の元数の和として求める。
 * 有限集合、自然数、写像合成だけを使い、既存の半群論の分類名と R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_tail_cycle_decomposition_heading",
    kind: "heading",
    level: 1,
    title: { text: "反復モノイドの過渡部と巡回部への分解" },
    labels: [],
  },
  {
    id: "iterate_monoid_tail_cycle_decomposition_definition",
    kind: "definition",
    title: { text: "過渡部と巡回部" },
    labels: ["def_iterate_monoid_transient_and_cycle_parts"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_collision_start"), " の最小衝突開始位置 ",
        math(String.raw`\mu_F\in\mathbb{N}`), " と ",
        ref("def_iterate_monoid_minimal_positive_period"), " の最小正周期 ",
        math(String.raw`\lambda_F\in\mathbb{N}_{>0}`), " に対し、",
      ]),
      displayMath(String.raw`T_F:=\{F^n\mid n\in\mathbb{N},\ n<\mu_F\}`),
      displayMath(String.raw`C_F:=\{F^{\mu_F+r}\mid r\in\mathbb{N},\ r<\lambda_F\}`),
      paragraph([
        "と定める。", math(String.raw`T_F`), " を過渡部、", math(String.raw`C_F`),
        " を巡回部と呼ぶ。これは有限集合 ", ref("def_iterate_monoid"),
        " の部分集合である。名称はこの二つの有限部分集合だけを指し、極限集合や位相を仮定しない。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_tail_cycle_decomposition_claim_collision_before_start_impossible",
    kind: "claim",
    title: { text: "最小衝突開始位置より前では反復写像は衝突しない" },
    labels: ["claim_iterate_monoid_no_collision_before_min_start"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`a,b\in\mathbb{N}`), "、", math(String.raw`a\le b`), "、",
        math(String.raw`a<\mu_F`), " とする。このとき",
      ]),
      displayMath(String.raw`F^a=F^b\ \Longleftrightarrow\ a=b`),
      paragraph([
        "が成り立つ。さらに、", math(String.raw`a<\mu_F\le n`), " なら ",
        math(String.raw`F^a\ne F^n`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`F^a=F^b`), " かつ ", math(String.raw`a<b`),
        " と仮定する。", math(String.raw`p:=b-a\in\mathbb{N}_{>0}`), " とおけば、",
      ]),
      displayMath(String.raw`\begin{aligned}
F^a
&=F^b
  \quad(\because\ \text{仮定})\\
&=F^{a+p}
  \quad(\because\ p=b-a\ \text{かつ}\ a<b)
\end{aligned}`),
      paragraph([
        "である。よって ", math(String.raw`a`), " は衝突開始位置である。",
        ref("def_iterate_monoid_collision_start"), " の最小性から ",
        math(String.raw`\mu_F\le a`), " となり、", math(String.raw`a<\mu_F`),
        " に矛盾する。したがって等号は ", math(String.raw`a=b`),
        " の場合に限る。逆向きは反射律である。", math(String.raw`a<\mu_F\le n`),
        " の場合も、もし ", math(String.raw`F^a=F^n`),
        " なら同じ論証で ", math(String.raw`\mu_F\le a`), " となるため不可能である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_tail_cycle_decomposition_claim_stable_tail_enumeration",
    kind: "claim",
    title: { text: "安定後の後尾集合は一周期分で尽くされる" },
    labels: ["claim_iterate_monoid_stable_tail_equals_cycle_part"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_iterate_monoid_tail"), " の後尾集合と ",
        ref("def_iterate_monoid_transient_and_cycle_parts"), " の巡回部について、"]),
      displayMath(String.raw`I_{\mu_F}(F)=C_F`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`F^{\mu_F+k}\in I_{\mu_F}(F)`),
        " とする。自然数の除法により、ただ一つの ", math(String.raw`q,r\in\mathbb{N}`),
        " が存在して",
      ]),
      displayMath(String.raw`k=q\lambda_F+r,\qquad 0\le r<\lambda_F`),
      paragraph([
        "となる。", ref("claim_iterate_monoid_period_propagates_after_collision_start"),
        " を ", math(String.raw`n=\mu_F+r+d\lambda_F`), " へ順に適用し、",
        math(String.raw`d\in\mathbb{N}`), " について帰納すると",
      ]),
      displayMath(String.raw`F^{\mu_F+r}=F^{\mu_F+r+d\lambda_F}`),
      paragraph(["を得る。したがって ", math(String.raw`d=q`), " では"]),
      displayMath(String.raw`\begin{aligned}
F^{\mu_F+k}
&=F^{\mu_F+r+q\lambda_F}
  \quad(\because\ k=q\lambda_F+r)\\
&=F^{\mu_F+r}
  \quad(\because\ \lambda_F\text{ の周期の伝播})
\end{aligned}`),
      paragraph([
        "であり、", math(String.raw`r<\lambda_F`), " なので ",
        math(String.raw`F^{\mu_F+k}\in C_F`), " である。逆に ",
        math(String.raw`r<\lambda_F`), " なら ", math(String.raw`F^{\mu_F+r}`),
        " は定義から ", math(String.raw`I_{\mu_F}(F)`), " に属する。両包含から等号を得る。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_tail_cycle_decomposition_claim_cycle_distinct",
    kind: "claim",
    title: { text: "一周期分の反復写像は互いに異なる" },
    labels: ["claim_iterate_monoid_cycle_part_pairwise_distinct"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`r,s\in\mathbb{N}`), "、", math(String.raw`r<s<\lambda_F`), " ならば",
      ]),
      displayMath(String.raw`F^{\mu_F+r}\ne F^{\mu_F+s}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`F^{\mu_F+r}=F^{\mu_F+s}`), " と仮定し、両辺へ左から ",
        math(String.raw`F^{\lambda_F-r}`), " を合成する。",
        ref("claim_iterate_composition_addition"), " より",
      ]),
      displayMath(String.raw`F^{\mu_F+\lambda_F}=F^{\mu_F+\lambda_F+(s-r)}`),
      paragraph([
        ref("def_iterate_monoid_minimal_positive_period"), " と ",
        ref("claim_iterate_monoid_period_propagates_after_collision_start"), " より、左辺は ",
        math(String.raw`F^{\mu_F}`), "、右辺は ", math(String.raw`F^{\mu_F+(s-r)}`),
        " に等しい。したがって",
      ]),
      displayMath(String.raw`F^{\mu_F}=F^{\mu_F+(s-r)}`),
      paragraph([
        "を得る。しかし ", math(String.raw`0<s-r<\lambda_F`), " なので、",
        math(String.raw`s-r\in\Pi_F`), " は ", math(String.raw`\lambda_F=\min\Pi_F`),
        " に矛盾する。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_tail_cycle_decomposition_claim_partition_cardinality",
    kind: "claim",
    title: { text: "反復モノイドは過渡部と巡回部へ一意に分かれる" },
    labels: ["claim_iterate_monoid_transient_cycle_partition_cardinality"],
    habitat: "N",
    statement: [
      paragraph([ref("def_iterate_monoid"), " の反復モノイドは"]),
      displayMath(String.raw`P_F=T_F\sqcup C_F`),
      paragraph(["と非交和に分かれ、その元数は"]),
      displayMath(String.raw`|P_F|=\mu_F+\lambda_F`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`F^n\in P_F`), " とする。", math(String.raw`n<\mu_F`), " なら ",
        math(String.raw`F^n\in T_F`), " である。", math(String.raw`\mu_F\le n`),
        " なら、ある ", math(String.raw`k\in\mathbb{N}`), " が存在して ",
        math(String.raw`n=\mu_F+k`), " であり、",
        ref("claim_iterate_monoid_stable_tail_equals_cycle_part"), " から ",
        math(String.raw`F^n\in C_F`), " である。よって ",
        math(String.raw`P_F=T_F\cup C_F`), " である。",
        ref("claim_iterate_monoid_no_collision_before_min_start"), " により二つの集合は交わらない。",
      ]),
      paragraph([
        "同じ claim により、写像 ", math(String.raw`n\mapsto F^n`), " は ",
        math(String.raw`\{n\in\mathbb{N}\mid n<\mu_F\}`), " から ", math(String.raw`T_F`),
        " への全単射である。したがって ", math(String.raw`|T_F|=\mu_F`), " である。",
        ref("claim_iterate_monoid_cycle_part_pairwise_distinct"), " により、写像 ",
        math(String.raw`r\mapsto F^{\mu_F+r}`), " は ",
        math(String.raw`\{r\in\mathbb{N}\mid r<\lambda_F\}`), " から ", math(String.raw`C_F`),
        " への全単射なので ", math(String.raw`|C_F|=\lambda_F`),
        " である。非交和の元数は元数の和だから、",
      ]),
      displayMath(String.raw`\begin{aligned}
|P_F|
&=|T_F|+|C_F|
  \quad(\because\ P_F=T_F\sqcup C_F)\\
&=\mu_F+\lambda_F
  \quad(\because\ |T_F|=\mu_F\ \text{かつ}\ |C_F|=\lambda_F)
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_tail_cycle_decomposition_claim_finite_decidability",
    kind: "claim",
    title: { text: "過渡部・巡回部と反復モノイドの元数は有限決定できる" },
    labels: ["claim_iterate_monoid_transient_cycle_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合と自己写像の有限表から、", math(String.raw`T_F`), "、",
        math(String.raw`C_F`), "、および ", math(String.raw`|P_F|=\mu_F+\lambda_F`),
        " を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_first_stable_equals_min_collision_start"), " により ",
        math(String.raw`\mu_F`), " を有限決定でき、",
        ref("claim_iterate_monoid_minimal_period_finite_decidability"), " により ",
        math(String.raw`\lambda_F`), " を有限決定できる。自己写像の有限表を ",
        math(String.raw`\mu_F+\lambda_F`), " 回まで合成して並べれば ",
        math(String.raw`T_F`), " と ", math(String.raw`C_F`),
        " を得る。前 claim により、この列挙は ", math(String.raw`P_F`),
        " の全ての元を重複なく尽くす。無限極限、位相、実数、複素数は使わない。",
      ]),
    ],
  },
]);
