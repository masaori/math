/**
 * 章「安定ファイバー間への自己写像の作用」。
 * 自己写像が安定ファイバーの添字をどう移し、各ファイバーをどこへ写すかを、
 * 有限集合、写像合成、写像の等号だけから導く。R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stable_fiber_dynamics_definition_index_map",
    kind: "definition",
    title: { text: "安定像上の添字写像" },
    labels: ["def_iterate_monoid_stable_fiber_index_map"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_stable_image"), " の安定像 ", math(String.raw`Q_F`),
        " 上の写像 ", math(String.raw`\sigma_F:Q_F\to Q_F`), " を",
      ]),
      displayMath(String.raw`\sigma_F(q):=F(q)\qquad(q\in Q_F)`),
      paragraph([
        "と定める。", ref("claim_iterate_monoid_generator_bijective_on_stable_image"),
        " より ", math(String.raw`F(q)\in Q_F`), " なので、この写像は定義され、全単射である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_dynamics_claim_commutation",
    kind: "claim",
    title: { text: "冪等反復写像は自己写像と可換である" },
    labels: ["claim_iterate_monoid_cycle_idempotent_commutes_with_generator"],
    habitat: "finite",
    statement: [
      paragraph(["すべての ", math(String.raw`y\in X`), " に対して"]),
      displayMath(String.raw`E_F(F(y))=F(E_F(y))`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        ref("def_iterate_monoid_cycle_idempotent_candidate"), " より ",
        math(String.raw`E_F=F^{e_F}`), " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
E_F(F(y))
&=(E_F\circ F)(y)
  \quad(\because\ \text{写像合成の定義})\\
&=F^{e_F+1}(y)
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=(F\circ E_F)(y)
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F(E_F(y))
  \quad(\because\ \text{写像合成の定義}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_dynamics_claim_exact_preimage",
    kind: "claim",
    title: { text: "自己写像は安定ファイバーの完全逆像を定める" },
    labels: ["claim_iterate_monoid_stable_fiber_exact_preimage"],
    habitat: "finite",
    statement: [
      paragraph([math(String.raw`q\in Q_F`), " に対して"]),
      displayMath(String.raw`F^{-1}\!\left(B_F(\sigma_F(q))\right)=B_F(q)`),
      paragraph(["である。すなわち、すべての ", math(String.raw`y\in X`), " に対して"]),
      displayMath(String.raw`F(y)\in B_F(\sigma_F(q))\quad\Longleftrightarrow\quad y\in B_F(q)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([math(String.raw`y\in B_F(q)`), " を仮定する。すると"]),
      displayMath(String.raw`\begin{aligned}
E_F(F(y))
&=F(E_F(y))
  \quad(\because\ \blkref{claim_iterate_monoid_cycle_idempotent_commutes_with_generator})\\
&=F(q)
  \quad(\because\ y\in B_F(q))\\
&=\sigma_F(q)
  \quad(\because\ \blkref{def_iterate_monoid_stable_fiber_index_map}).
\end{aligned}`),
      paragraph([
        ref("def_iterate_monoid_stable_fiber"), " より ",
        math(String.raw`F(y)\in B_F(\sigma_F(q))`), " である。逆に ",
        math(String.raw`F(y)\in B_F(\sigma_F(q))`), " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
F(E_F(y))
&=E_F(F(y))
  \quad(\because\ \blkref{claim_iterate_monoid_cycle_idempotent_commutes_with_generator})\\
&=\sigma_F(q)
  \quad(\because\ F(y)\in B_F(\sigma_F(q)))\\
&=F(q)
  \quad(\because\ \blkref{def_iterate_monoid_stable_fiber_index_map}).
\end{aligned}`),
      paragraph([
        ref("def_iterate_monoid_stable_image"), " より ", math(String.raw`E_F(y)\in Q_F`),
        " であり、仮定より ", math(String.raw`q\in Q_F`), " である。",
        ref("claim_iterate_monoid_generator_bijective_on_stable_image"),
        " の単射性から ", math(String.raw`E_F(y)=q`), " である。よって ",
        ref("def_iterate_monoid_stable_fiber"), " より ", math(String.raw`y\in B_F(q)`), " である。",
      ]),
      paragraph(["両方向から完全逆像の等号を得る。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_dynamics_claim_image_can_be_strict",
    kind: "claim",
    title: { text: "ファイバーの像は次のファイバー全体とは限らない" },
    labels: ["claim_iterate_monoid_stable_fiber_image_can_be_strict"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_stable_image"), " の ", math(String.raw`Q_F`), "、",
        ref("def_iterate_monoid_stable_fiber"), " の ", math(String.raw`B_F`), "、",
        ref("def_iterate_monoid_stable_fiber_index_map"), " の ", math(String.raw`\sigma_F`),
        " に対し、", math(String.raw`F(B_F(q))\subsetneq B_F(\sigma_F(q))`),
        " となる有限集合上の自己写像が存在する。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X:=\{x_0,x_1\}`), " とし、自己写像 ",
        math(String.raw`F:X\to X`), " を次の表で定める。",
      ]),
      displayMath(String.raw`X=\{x_0,x_1\},\qquad F(x_0)=x_0,\qquad F(x_1)=x_0`),
      displayMath(String.raw`F^0(x_1)=x_1\ne x_0=F^1(x_1)`),
      displayMath(String.raw`F^2(x_i)=F(x_0)=x_0=F(x_i)\qquad(i\in\{0,1\})`),
      paragraph([
        "よって ", math(String.raw`F^0\ne F^1`), " かつ写像として ", math(String.raw`F^1=F^2`),
        " であるので、衝突開始位置は ", math(String.raw`\mu_F=1`),
        "、最小正周期は ", math(String.raw`\lambda_F=1`), " であり、",
        ref("def_iterate_monoid_cycle_idempotent_candidate"), " から ", math(String.raw`e_F=1`),
        "、", math(String.raw`E_F=F`), " である。したがって ", math(String.raw`Q_F=\{x_0\}`),
        "、", math(String.raw`B_F(x_0)=\{x_0,x_1\}`), "、",
        math(String.raw`\sigma_F(x_0)=x_0`), " である。しかし",
      ]),
      displayMath(String.raw`F(B_F(x_0))=\{x_0\}\subsetneq\{x_0,x_1\}=B_F(\sigma_F(x_0))`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "iterate_monoid_stable_fiber_dynamics_claim_finite_decidability",
    kind: "claim",
    title: { text: "ファイバー間の自己写像の作用は有限決定できる" },
    labels: ["claim_iterate_monoid_stable_fiber_dynamics_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合上の自己写像の有限表から、", math(String.raw`\sigma_F`), " の表と、各 ",
        math(String.raw`q\in Q_F`), " に対する ", math(String.raw`F(B_F(q))`),
        "、", math(String.raw`F^{-1}(B_F(\sigma_F(q)))`),
        " を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_stable_fibers_finite_decidability"),
        " により ", math(String.raw`Q_F`), " と全ての ", math(String.raw`B_F(q)`),
        " を有限決定できる。有限集合 ", math(String.raw`Q_F`), " の各元へ ",
        math(String.raw`F`), " を適用すれば ", math(String.raw`\sigma_F`), " の表を得る。さらに各 ",
        math(String.raw`B_F(q)`), " の全元へ ", math(String.raw`F`),
        " を適用して重複を除けば像を得る。有限集合 ", math(String.raw`X`),
        " の各元について、その像が ", math(String.raw`B_F(\sigma_F(q))`),
        " に属するかを検査すれば完全逆像を得る。各手順は有限集合上の有限走査である。",
      ]),
    ],
  },
]);
