/**
 * 章「反復モノイドの巡回部にある唯一の冪等元」。
 * 過渡部と巡回部の分解から、巡回部の中では冪等元が一意に定まることを導く。
 * 有限集合、自然数、写像合成だけを使い、既存の半群論の分類名と R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_cycle_idempotent_heading",
    kind: "heading",
    level: 1,
    title: { text: "反復モノイドの巡回部にある唯一の冪等元" },
    labels: [],
  },
  {
    id: "iterate_monoid_cycle_idempotent_definition_admissible_exponents",
    kind: "definition",
    title: { text: "安定後の周期倍数指数" },
    labels: ["def_iterate_monoid_stable_period_multiple_exponents"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_iterate_monoid_collision_start"), " の最小衝突開始位置 ",
        math(String.raw`\mu_F\in\mathbb{N}`), " と ",
        ref("def_iterate_monoid_minimal_positive_period"), " の最小正周期 ",
        math(String.raw`\lambda_F\in\mathbb{N}_{>0}`), " に対し、",
      ]),
      displayMath(String.raw`D_F:=\{n\in\mathbb{N}\mid \mu_F\le n\ \text{かつ}\ \lambda_F\mid n\}`),
      paragraph(["と定める。"])],
  },
  {
    id: "iterate_monoid_cycle_idempotent_claim_admissible_exponents_nonempty",
    kind: "claim",
    title: { text: "安定後の周期倍数指数は存在する" },
    labels: ["claim_iterate_monoid_stable_period_multiple_exists"],
    habitat: "N",
    statement: [paragraph([ref("def_iterate_monoid_stable_period_multiple_exponents"), " の集合 ",
      math(String.raw`D_F`), " は ", math(String.raw`D_F\ne\varnothing`), " を満たす。"])],
    proof: [
      paragraph([math(String.raw`n:=\mu_F\lambda_F\in\mathbb{N}`), " と置く。"]),
      displayMath(String.raw`\lambda_F\mid n\quad(\because\ n=\mu_F\lambda_F)`),
      displayMath(String.raw`\mu_F\le n\quad(\because\ \lambda_F\ge1)`),
      paragraph(["したがって ", math(String.raw`n\in D_F`), " である。"]),
    ],
  },
  {
    id: "iterate_monoid_cycle_idempotent_definition_stable_exponent",
    kind: "definition",
    title: { text: "最小の安定後周期倍数指数" },
    labels: ["def_iterate_monoid_minimal_stable_period_multiple"],
    habitat: "N",
    statement: [
      paragraph([
        ref("claim_iterate_monoid_stable_period_multiple_exists"), " により空でない自然数集合 ",
        math(String.raw`D_F`), " の最小元を ", math(String.raw`e_F:=\min D_F\in\mathbb{N}`),
        " と定める。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_cycle_idempotent_definition_candidate",
    kind: "definition",
    title: { text: "巡回部の冪等元候補" },
    labels: ["def_iterate_monoid_cycle_idempotent_candidate"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_iterate_monoid_minimal_stable_period_multiple"), " の指数 ",
        math(String.raw`e_F`), " に対し、"]),
      displayMath(String.raw`E_F:=F^{e_F}`),
      paragraph(["と定める。"])],
  },
  {
    id: "iterate_monoid_cycle_idempotent_claim_candidate_is_idempotent",
    kind: "claim",
    title: { text: "冪等元候補は巡回部に属して冪等である" },
    labels: ["claim_iterate_monoid_cycle_idempotent_candidate_is_idempotent"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`E_F\in C_F`),
      paragraph(["かつ"]),
      displayMath(String.raw`E_F\circ E_F=E_F`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("def_iterate_monoid_cycle_idempotent_candidate"), "、",
        ref("def_iterate_monoid_minimal_stable_period_multiple"), " と ",
        ref("def_iterate_monoid_stable_period_multiple_exponents"), " より、",
        math(String.raw`\mu_F\le e_F`), " かつ、ある ", math(String.raw`q\in\mathbb{N}`),
        " が存在して ", math(String.raw`e_F=q\lambda_F`), " である。",
        ref("claim_iterate_monoid_stable_tail_equals_cycle_part"), " より ",
        math(String.raw`E_F=F^{e_F}\in C_F`), " である。",
      ]),
      paragraph([
        ref("claim_iterate_monoid_period_propagates_after_collision_start"), " を ",
        math(String.raw`e_F,e_F+\lambda_F,\ldots,e_F+(q-1)\lambda_F`),
        " に順に適用すると、",
      ]),
      displayMath(String.raw`F^{e_F}=F^{e_F+q\lambda_F}`),
      paragraph([ref("claim_iterate_composition_addition"), " と ", math(String.raw`e_F=q\lambda_F`), " より、"]),
      displayMath(String.raw`\begin{aligned}
E_F\circ E_F
&=F^{e_F}\circ F^{e_F}
  \quad(\because\ E_F=F^{e_F})\\
&=F^{e_F+e_F}
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^{e_F+q\lambda_F}
  \quad(\because\ e_F=q\lambda_F)\\
&=F^{e_F}
  \quad(\because\ \lambda_F\text{ の周期の伝播})\\
&=E_F
  \quad(\because\ E_F=F^{e_F})
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_cycle_idempotent_claim_uniqueness",
    kind: "claim",
    title: { text: "巡回部の冪等元は一意である" },
    labels: ["claim_iterate_monoid_cycle_idempotent_unique"],
    habitat: "finite",
    statement: [
      paragraph([math(String.raw`G\in C_F`), " かつ ", math(String.raw`G\circ G=G`), " ならば"]),
      displayMath(String.raw`G=E_F`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        ref("def_iterate_monoid_transient_and_cycle_parts"), " により、ある ",
        math(String.raw`r\in\mathbb{N}`), " が存在して ", math(String.raw`r<\lambda_F`),
        " かつ ", math(String.raw`G=F^{\mu_F+r}`), " である。",
        math(String.raw`n:=\mu_F+r\in\mathbb{N}`), " と置く。",
      ]),
      paragraph([ref("claim_iterate_composition_addition"), " と冪等性より、"]),
      displayMath(String.raw`F^{2n}=F^n`),
      paragraph([
        math(String.raw`2n=\mu_F+(\mu_F+2r)`), " である。自然数の除法により ",
        math(String.raw`s:=(\mu_F+2r)\bmod\lambda_F`), " と置くと ",
        math(String.raw`0\le s<\lambda_F`), " である。",
        ref("claim_iterate_monoid_period_propagates_after_collision_start"),
        " による周期の除去を右辺へ行うと、",
      ]),
      displayMath(String.raw`F^{\mu_F+r}=F^{\mu_F+s}`),
      paragraph([
        ref("claim_iterate_monoid_cycle_part_pairwise_distinct"), " より指数の剰余が等しいので、",
      ]),
      displayMath(String.raw`r=s`),
      paragraph([
        math(String.raw`s\equiv\mu_F+2r\pmod{\lambda_F}`), " と ", math(String.raw`r=s`),
        " より ", math(String.raw`\mu_F+r\equiv0\pmod{\lambda_F}`),
        " を得る。", math(String.raw`n=\mu_F+r`), " なので ",
        math(String.raw`\lambda_F\mid n`), " である。",
        math(String.raw`n\ge\mu_F`), " なので ", math(String.raw`n\in D_F`), " である。",
      ]),
      paragraph([
        math(String.raw`n\in D_F`), " と ", ref("def_iterate_monoid_minimal_stable_period_multiple"),
        " の最小性より ", math(String.raw`e_F\le n`), " である。",
        math(String.raw`e_F,n`), " はともに ", math(String.raw`\lambda_F`),
        " の倍数なので、ある ", math(String.raw`t\in\mathbb{N}`), " が存在して ",
        math(String.raw`n=e_F+t\lambda_F`), " である。", math(String.raw`e_F\ge\mu_F`), " なので ",
        ref("claim_iterate_monoid_period_propagates_after_collision_start"), " を ",
        math(String.raw`e_F,e_F+\lambda_F,\ldots,e_F+(t-1)\lambda_F`), " に順に適用して",
      ]),
      displayMath(String.raw`F^{e_F}=F^{e_F+t\lambda_F}=F^n`),
      paragraph(["を得る。よって ", math(String.raw`G=F^n=F^{e_F}=E_F`), " である。"]),
    ],
  },
  {
    id: "iterate_monoid_cycle_idempotent_claim_finite_decidability",
    kind: "claim",
    title: { text: "巡回部の唯一の冪等元は有限決定できる" },
    labels: ["claim_iterate_monoid_cycle_idempotent_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合と自己写像の有限表から ", math(String.raw`e_F`), " と ",
        math(String.raw`E_F`), " を有限回の自然数演算と有限集合 ", math(String.raw`X`),
        " の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_first_stable_equals_min_collision_start"), " により ",
        math(String.raw`\mu_F`), " を有限決定でき、",
        ref("claim_iterate_monoid_minimal_period_finite_decidability"), " により ",
        math(String.raw`\lambda_F`), " を有限決定できる。",
        math(String.raw`n=\mu_F,\mu_F+1,\ldots`), " の順に ",
        math(String.raw`\lambda_F\mid n`), " を判定して最初の値を返せば ",
        math(String.raw`e_F`), " を得る。", ref("claim_iterate_monoid_stable_period_multiple_exists"),
        " によりこの走査は停止する。自己写像の有限表から自己写像の有限表を作り ",
        math(String.raw`e_F`), " 回合成すれば ", math(String.raw`E_F=F^{e_F}`),
        " を得る。無限極限、位相、実数、複素数は使わない。",
      ]),
    ],
  },
]);
