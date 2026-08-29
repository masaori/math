/**
 * 章「反復モノイドの巡回部がなす有限巡回群」。
 * 巡回部に閉じた合成、唯一の冪等元を単位元とする逆元、周期を一つ進める生成元を、
 * 既存の群を目標仕様として仮定せず、反復写像の加法則と最小正周期だけから導く。
 * 有限集合、自然数、写像合成だけを使い、R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_cyclic_group_heading",
    kind: "heading",
    level: 1,
    title: { text: "反復モノイドの巡回部がなす有限巡回群" },
    labels: [],
  },
  {
    id: "iterate_monoid_cyclic_group_definition_cycle_operation",
    kind: "definition",
    title: { text: "巡回部上の合成と周期を一つ進める元" },
    labels: ["def_iterate_monoid_cycle_operation_and_successor"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_transient_and_cycle_parts"), " の巡回部 ",
        math(String.raw`C_F`), " には、写像の合成 ", math(String.raw`\circ`),
        " をそのまま用いる。", ref("def_iterate_monoid_cycle_idempotent_candidate"),
        " の唯一の冪等元を ", math(String.raw`E_F=F^{e_F}`), " とし、",
      ]),
      displayMath(String.raw`K_F:=F^{e_F+1}`),
      paragraph(["と定める。"])],
  },
  {
    id: "iterate_monoid_cyclic_group_claim_closed_identity_inverse",
    kind: "claim",
    title: { text: "巡回部は合成について閉じ、単位元と逆元をもつ" },
    labels: ["claim_iterate_monoid_cycle_part_group_laws"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_cycle_operation_and_successor"), " の巡回部と演算について、",
        math(String.raw`G,H\in C_F`), " なら ", math(String.raw`G\circ H\in C_F`),
        " である。", math(String.raw`E_F`), " は ", math(String.raw`C_F`),
        " 上の左右単位元であり、各 ", math(String.raw`G\in C_F`),
        " に対してある ", math(String.raw`H\in C_F`), " が存在して",
      ]),
      displayMath(String.raw`G\circ H=H\circ G=E_F`),
      paragraph(["となる。したがって ", math(String.raw`(C_F,\circ,E_F)`), " は有限可換群である。"]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_stable_tail_equals_cycle_part"), " より、ある ",
        math(String.raw`a,b\in\mathbb{N}`), " が存在して ",
        math(String.raw`G=F^{\mu_F+a}`), "、", math(String.raw`H=F^{\mu_F+b}`),
        " と書ける。", ref("claim_iterate_composition_addition"), " より",
      ]),
      displayMath(String.raw`G\circ H=F^{2\mu_F+a+b}`),
      paragraph([
        math(String.raw`2\mu_F+a+b\ge\mu_F`), " なので、再び ",
        ref("claim_iterate_monoid_stable_tail_equals_cycle_part"), " より ",
        math(String.raw`G\circ H\in C_F`), " である。",
      ]),
      paragraph([
        "任意の ", math(String.raw`G=F^n\in C_F`), " を取る。",
        math(String.raw`n\ge\mu_F`), " である。", ref("def_iterate_monoid_minimal_stable_period_multiple"),
        " と ", ref("def_iterate_monoid_stable_period_multiple_exponents"), " より、ある ",
        math(String.raw`q\in\mathbb{N}`), " が存在して ", math(String.raw`e_F=q\lambda_F`),
        " である。", ref("claim_iterate_monoid_period_propagates_after_collision_start"),
        " を ", math(String.raw`n,n+\lambda_F,\ldots,n+(q-1)\lambda_F`), " に順に適用し、",
        ref("claim_iterate_composition_addition"), " を使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
E_F\circ G
&=F^{e_F+n}
  \quad(\because\ \text{反復回数の加法})\\
&=F^{n+q\lambda_F}
  \quad(\because\ e_F=q\lambda_F)\\
&=F^n
  \quad(\because\ \lambda_F\text{ の周期の伝播})\\
&=G
  \quad(\because\ G=F^n)
\end{aligned}`),
      paragraph([
        "可換性により ", math(String.raw`G\circ E_F=G`), " でもある。次に",
      ]),
      displayMath(String.raw`m:=e_F+n(\lambda_F-1)\in\mathbb{N},\qquad H:=F^m`),
      paragraph([
        "と置く。", math(String.raw`m\ge e_F\ge\mu_F`), " なので ",
        ref("claim_iterate_monoid_stable_tail_equals_cycle_part"), " より ",
        math(String.raw`H\in C_F`), " である。また ", math(String.raw`n+m=e_F+n\lambda_F`),
        " である。", ref("claim_iterate_monoid_period_propagates_after_collision_start"),
        " を ", math(String.raw`e_F,e_F+\lambda_F,\ldots,e_F+(n-1)\lambda_F`),
        " に順に適用し、", ref("claim_iterate_composition_addition"), " を使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
G\circ H
&=F^{n+m}
  \quad(\because\ \text{反復回数の加法})\\
&=F^{e_F+n\lambda_F}
  \quad(\because\ n+m=e_F+n\lambda_F)\\
&=F^{e_F}
  \quad(\because\ \lambda_F\text{ の周期の伝播})\\
&=E_F
  \quad(\because\ E_F=F^{e_F})
\end{aligned}`),
      paragraph([
        "である。可換性から ", math(String.raw`H\circ G=E_F`), " も従う。結合律と可換律は ",
        ref("claim_iterate_powers_form_finite_commutative_monoid"), " から継承され、有限性は ",
        math(String.raw`C_F\subseteq P_F`), " から従う。よって有限可換群である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_cyclic_group_claim_generated_by_successor",
    kind: "claim",
    title: { text: "周期を一つ進める元が巡回部全体を生成する" },
    labels: ["claim_iterate_monoid_cycle_part_is_cyclic_of_order_min_period"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`K_F`), " は ", math(String.raw`C_F`), " に属し、単位元を ",
        math(String.raw`E_F`), " とする群の冪を ", math(String.raw`K_F^{\langle r\rangle}`),
        " と書けば、",
      ]),
      displayMath(String.raw`C_F=\{K_F^{\langle r\rangle}\mid 0\le r<\lambda_F\}`),
      paragraph(["であり、右辺の ", math(String.raw`\lambda_F`), " 個の元は互いに異なる。したがって ",
        math(String.raw`C_F`), " は位数 ", math(String.raw`\lambda_F`), " の有限巡回群である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`e_F+1\ge\mu_F`), " なので ",
        ref("claim_iterate_monoid_stable_tail_equals_cycle_part"), " より ",
        math(String.raw`K_F\in C_F`), " である。群の冪を ",
        math(String.raw`K_F^{\langle0\rangle}:=E_F`), "、",
        math(String.raw`K_F^{\langle r+1\rangle}:=K_F^{\langle r\rangle}\circ K_F`),
        " と定める。", math(String.raw`r\in\mathbb{N}`), " について帰納すると",
      ]),
      displayMath(String.raw`K_F^{\langle r\rangle}=F^{e_F+r}`),
      paragraph([
        "を得る。基底は定義そのものである。帰納段では ",
        ref("claim_iterate_composition_addition"), " により指数が ",
        math(String.raw`2e_F+r+1`), " となり、", math(String.raw`e_F`),
        " が ", math(String.raw`\lambda_F`), " の倍数であることと周期の伝播により ",
        math(String.raw`e_F+r+1`), " へ戻る。",
      ]),
      paragraph([
        ref("claim_iterate_monoid_stable_tail_equals_cycle_part"), " と自然数の除法により、安定後の連続する ",
        math(String.raw`\lambda_F`), " 個の反復写像 ",
        math(String.raw`F^{e_F},F^{e_F+1},\ldots,F^{e_F+\lambda_F-1}`),
        " は ", math(String.raw`C_F`), " を尽くす。もしこの列の二元が等しければ、それぞれの指数を ",
        math(String.raw`\mu_F`), " から始まる一周期へ還元した後、",
        ref("claim_iterate_monoid_cycle_part_pairwise_distinct"), " により二つの剰余は等しい。したがって元の ",
        math(String.raw`0\le r<\lambda_F`), " も等しい。よって上の表示は重複がなく、",
        math(String.raw`K_F`), " が ", math(String.raw`C_F`), " 全体を生成する。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_cyclic_group_claim_finite_decidability",
    kind: "claim",
    title: { text: "巡回群の演算表と逆元は有限決定できる" },
    labels: ["claim_iterate_monoid_cycle_group_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合と自己写像の有限表から、", math(String.raw`C_F`), " の合成表、単位元 ",
        math(String.raw`E_F`), "、各元の逆元、生成元 ", math(String.raw`K_F`),
        "、位数 ", math(String.raw`\lambda_F`), " を有限回の自然数演算と有限集合 ",
        math(String.raw`X`), " の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_transient_cycle_finite_decidability"), " により ",
        math(String.raw`C_F`), " と ", math(String.raw`\lambda_F`), " を有限決定でき、",
        ref("claim_iterate_monoid_cycle_idempotent_finite_decidability"), " により ",
        math(String.raw`e_F`), " と ", math(String.raw`E_F`), " を有限決定できる。自己写像の有限表を合成して ",
        math(String.raw`K_F=F^{e_F+1}`), " と全ての積を求める。各行で積が ",
        math(String.raw`E_F`), " となる列を有限走査すれば逆元を得る。前 claim により各行で該当列は必ず存在する。",
        "全対象は有限集合・自然数・有限自己写像であり、無限極限、位相、実数、複素数は使わない。",
      ]),
    ],
  },
]);
