/**
 * 章「反復モノイドの冪等元が定める安定像」。
 * 巡回部の唯一の冪等元が元集合上に定める像と、その像上の自己写像を、
 * 有限集合、自然数、写像合成だけから導く。R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stable_image_definition",
    kind: "definition",
    title: { text: "安定像" },
    labels: ["def_iterate_monoid_stable_image"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_cycle_idempotent_candidate"), " の冪等反復写像 ",
        math(String.raw`E_F=F^{e_F}:X\to X`), " の像を",
      ]),
      displayMath(String.raw`Q_F:=\{E_F(y)\mid y\in X\}\subseteq X`),
      paragraph(["と定め、これを ", math(String.raw`F`), " の安定像と呼ぶ。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_image_claim_idempotent_retraction",
    kind: "claim",
    title: { text: "冪等反復写像は安定像上で恒等写像になる" },
    labels: ["claim_iterate_monoid_cycle_idempotent_retracts_stable_image"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`z\in Q_F`), " なら ", math(String.raw`E_F(z)=z`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_iterate_monoid_stable_image"), " より、ある ",
        math(String.raw`y\in X`), " が存在して ", math(String.raw`z=E_F(y)`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
E_F(z)
&=E_F(E_F(y))
  \quad(\because\ z=E_F(y))\\
&=(E_F\circ E_F)(y)
  \quad(\because\ \text{写像合成の定義})\\
&=E_F(y)
  \quad(\because\ \blkref{claim_iterate_monoid_cycle_idempotent_candidate_is_idempotent})\\
&=z
  \quad(\because\ z=E_F(y)).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_image_claim_stable_power_images",
    kind: "claim",
    title: { text: "衝突開始後の全ての反復写像は同じ像をもつ" },
    labels: ["claim_iterate_monoid_stable_power_image_equals_stable_image"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`), " と ", math(String.raw`\mu_F\le n`), " に対して",
      ]),
      displayMath(String.raw`\{F^n(y)\mid y\in X\}=Q_F`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_stable_tail_equals_cycle_part"), " より ",
        math(String.raw`F^n\in C_F`), " である。",
        ref("claim_iterate_monoid_cycle_part_group_laws"), " より、ある ",
        math(String.raw`H\in C_F`), " が存在して",
      ]),
      displayMath(String.raw`E_F\circ F^n=F^n,\qquad F^n\circ H=E_F`),
      paragraph(["となる。任意の ", math(String.raw`y\in X`), " に対して"]),
      displayMath(String.raw`F^n(y)=E_F(F^n(y))\in Q_F
\quad(\because\ E_F\circ F^n=F^n)`),
      paragraph(["なので ", math(String.raw`\operatorname{im}(F^n)\subseteq Q_F`), " である。逆に"]),
      displayMath(String.raw`E_F(y)=F^n(H(y))\in\operatorname{im}(F^n)
\quad(\because\ F^n\circ H=E_F)`),
      paragraph(["なので ", math(String.raw`Q_F\subseteq\operatorname{im}(F^n)`), " である。両包含から結論を得る。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_image_definition_inverse_candidate",
    kind: "definition",
    title: { text: "安定像上の一段発展の逆写像候補" },
    labels: ["def_iterate_monoid_stable_image_inverse_candidate"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_minimal_positive_period"), " の ",
        math(String.raw`\lambda_F\in\mathbb{N}_{>0}`), " を用いて",
      ]),
      displayMath(String.raw`S_F:=F^{e_F+\lambda_F-1}:X\to X`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_image_claim_restricted_bijection",
    kind: "claim",
    title: { text: "自己写像は安定像上で全単射になる" },
    labels: ["claim_iterate_monoid_generator_bijective_on_stable_image"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F`), " と ", math(String.raw`S_F`), " は ",
        math(String.raw`Q_F`), " をそれ自身へ写し、その制限は互いに逆写像である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z\in Q_F`), " を取る。", ref("def_iterate_monoid_stable_image"), " より、ある ",
        math(String.raw`y\in X`), " が存在して ", math(String.raw`z=F^{e_F}(y)`), " である。",
        math(String.raw`e_F\ge\mu_F`), "、", math(String.raw`\lambda_F\ge1`), " なので、",
      ]),
      displayMath(String.raw`F(z)=F^{e_F+1}(y)\in Q_F
\quad(\because\ \blkref{claim_iterate_monoid_stable_power_image_equals_stable_image})`),
      displayMath(String.raw`S_F(z)=F^{2e_F+\lambda_F-1}(y)\in Q_F
\quad(\because\ \blkref{claim_iterate_monoid_stable_power_image_equals_stable_image})`),
      paragraph(["である。したがって ", math(String.raw`F`), " と ", math(String.raw`S_F`), " は ",
        math(String.raw`Q_F`), " をそれ自身へ写す。"]),
      paragraph([
        ref("claim_iterate_monoid_period_propagates_after_collision_start"), " を指数 ",
        math(String.raw`e_F`), " に適用すると ", math(String.raw`F^{e_F+\lambda_F}=F^{e_F}`), " である。したがって",
      ]),
      displayMath(String.raw`F\circ S_F=S_F\circ F=E_F
\quad(\because\ \blkref{claim_iterate_composition_addition})`),
      paragraph([
        math(String.raw`z\in Q_F`), " に対し、", ref("claim_iterate_monoid_cycle_idempotent_retracts_stable_image"), " より",
      ]),
      displayMath(String.raw`F(S_F(z))=E_F(z)=z,\qquad S_F(F(z))=E_F(z)=z`),
      paragraph(["である。よって二つの制限は互いに逆写像であり、", math(String.raw`F|_{Q_F}`), " は全単射である。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_image_claim_finite_decidability",
    kind: "claim",
    title: { text: "安定像と制限写像は有限決定できる" },
    labels: ["claim_iterate_monoid_stable_image_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合上の自己写像の有限表から、", math(String.raw`Q_F`), " の元、",
        math(String.raw`E_F|_{Q_F}`), "、", math(String.raw`F|_{Q_F}`), "、",
        math(String.raw`S_F|_{Q_F}`), " の表を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_cycle_idempotent_finite_decidability"), " により ",
        math(String.raw`e_F`), " と ", math(String.raw`E_F`), " を有限決定でき、",
        ref("claim_iterate_monoid_minimal_period_finite_decidability"), " により ",
        math(String.raw`\lambda_F`), " を有限決定できる。有限集合 ",
        math(String.raw`X`), " の全元へ ", math(String.raw`E_F`), " を適用して重複を除けば ",
        math(String.raw`Q_F`), " を得る。さらに ", math(String.raw`Q_F`), " の各元へ ",
        math(String.raw`E_F,F,S_F`), " を適用して表を作る。各手順は有限集合上の有限走査である。",
      ]),
    ],
  },
]);
