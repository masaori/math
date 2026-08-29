/**
 * 章「反復モノイドの最小正周期」。
 * 最小衝突開始位置で反復写像の列が戻る最小の正周期を定義し、
 * すべての戻り周期がその倍数であることを有限集合と自然数だけから示す。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_minimal_period_heading",
    kind: "heading",
    level: 1,
    title: { text: "反復モノイドの最小正周期" },
    labels: [],
  },

  {
    id: "iterate_monoid_minimal_period_definition",
    kind: "definition",
    title: { text: "最小衝突開始位置での最小正周期" },
    labels: ["def_iterate_monoid_minimal_positive_period"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_iterate_monoid_collision_start"),
        " の最小衝突開始位置 ",
        math(String.raw`\mu_F\in\mathbb{N}`),
        " に対し、正周期の集合を",
      ]),
      displayMath(String.raw`\Pi_F:=\{p\in\mathbb{N}_{>0}\mid F^{\mu_F}=F^{\mu_F+p}\}`),
      paragraph([
        "と定義する。",
        math(String.raw`\mu_F`),
        " が衝突開始位置なので ",
        math(String.raw`\Pi_F`),
        " は空でない。自然数の整列性により、その最小元を ",
        math(String.raw`\lambda_F:=\min\Pi_F\in\mathbb{N}_{>0}`),
        " と書き、反復モノイドの最小正周期と呼ぶ。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_minimal_period_claim_divisibility_extension",
    kind: "claim",
    title: { text: "最小衝突開始位置での周期は以後の全ての位置へ伝わる" },
    labels: ["claim_iterate_monoid_period_propagates_after_collision_start"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_iterate_monoid_minimal_positive_period"), " の ", math(String.raw`p\in\Pi_F`),
        " ならば、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`n\ge\mu_F\ \Longrightarrow\ F^n=F^{n+p}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n\ge\mu_F`),
        " とする。ある ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在して ",
        math(String.raw`n=\mu_F+k`),
        " である。",
        ref("claim_iterate_composition_addition"),
        " と ",
        math(String.raw`p\in\Pi_F`),
        " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n+p}
&=F^{k}\circ F^{\mu_F+p}
  \quad(\because\ n=\mu_F+k\text{ と反復回数の加法})\\
&=F^{k}\circ F^{\mu_F}
  \quad(\because\ p\in\Pi_F)\\
&=F^{\mu_F+k}
  \quad(\because\ \text{反復回数の加法})\\
&=F^n
  \quad(\because\ n=\mu_F+k)
\end{aligned}`),
    ],
  },

  {
    id: "iterate_monoid_minimal_period_claim_divides_all_periods",
    kind: "claim",
    title: { text: "最小正周期は全ての正周期を割り切る" },
    labels: ["claim_iterate_monoid_minimal_period_divides_every_period"],
    habitat: "N",
    statement: [
      paragraph([ref("def_iterate_monoid_minimal_positive_period"), " のすべての ",
        math(String.raw`p\in\Pi_F`), " について、"]),
      displayMath(String.raw`\lambda_F\mid p`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`p\in\Pi_F`),
        " とする。自然数の除法により、ただ一つの ",
        math(String.raw`q,r\in\mathbb{N}`),
        " が存在して",
      ]),
      displayMath(String.raw`p=q\lambda_F+r,\qquad 0\le r<\lambda_F`),
      paragraph([
        "となる。まず ",
        ref("claim_iterate_monoid_period_propagates_after_collision_start"),
        " を用い、",
        math(String.raw`d\in\mathbb{N}`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`F^{\mu_F+r}=F^{\mu_F+r+d\lambda_F}`),
      paragraph([
        "を示す。",
        math(String.raw`d=0`),
        " では指数が等しい。",
        math(String.raw`d`),
        " で成り立つとき、",
        math(String.raw`\mu_F+r+d\lambda_F\ge\mu_F`),
        " なので、同 claim を ",
        math(String.raw`p=\lambda_F`),
        " に適用して",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{\mu_F+r}
&=F^{\mu_F+r+d\lambda_F}
  \quad(\because\ \text{帰納法の仮定})\\
&=F^{\mu_F+r+(d+1)\lambda_F}
  \quad(\because\ \lambda_F\in\Pi_F\text{ と周期の伝播})
\end{aligned}`),
      paragraph([
        "を得る。したがって ",
        math(String.raw`d=q`),
        " と除法の等式を用いると、",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{\mu_F+r}
&=F^{\mu_F+r+q\lambda_F}
  \quad(\because\ \text{上の帰納法})\\
&=F^{\mu_F+p}
  \quad(\because\ p=q\lambda_F+r)\\
&=F^{\mu_F}
  \quad(\because\ p\in\Pi_F)
\end{aligned}`),
      paragraph([
        "となる。もし ",
        math(String.raw`r>0`),
        " なら ",
        math(String.raw`r\in\Pi_F`),
        " かつ ",
        math(String.raw`r<\lambda_F`),
        " となり、",
        math(String.raw`\lambda_F=\min\Pi_F`),
        " に矛盾する。よって ",
        math(String.raw`r=0`),
        " であり、",
        math(String.raw`p=q\lambda_F`),
        " だから ",
        math(String.raw`\lambda_F\mid p`),
        " である。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_minimal_period_claim_finite_decidability",
    kind: "claim",
    title: { text: "最小正周期は自己写像の有限表から決定できる" },
    labels: ["claim_iterate_monoid_minimal_period_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合と自己写像の有限表から ",
        math(String.raw`\lambda_F`),
        " を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_first_stable_equals_min_collision_start"),
        " により ",
        math(String.raw`\mu_F`),
        " を有限決定できる。次に ",
        math(String.raw`p=1,2,3,\ldots`),
        " の順に、自己写像の有限表の全ての元を走査して ",
        math(String.raw`F^{\mu_F}=F^{\mu_F+p}`),
        " を判定し、最初に等号が成り立つ ",
        math(String.raw`p`),
        " を返す。",
        ref("def_iterate_monoid_minimal_positive_period"),
        " により ",
        math(String.raw`\Pi_F`),
        " は空でないので、この走査は有限回で停止し、返す値は ",
        math(String.raw`\lambda_F`),
        " である。各等号は有限集合 ", math(String.raw`X`),
        " の元の有限個の等号へ分解される。無限極限、位相、実数、複素数は使わない。",
      ]),
    ],
  },
]);
