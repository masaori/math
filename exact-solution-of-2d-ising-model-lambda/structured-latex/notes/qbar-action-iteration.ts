import { defineNotes, displayMath, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_claim_qbar_eigenvector_pow_action_iteration",
    targets: ["claim_qbar_eigenvector_pow"],
    title: { text: "行列の冪の作用と作用の反復" },
    body: [
      paragraph([
        "本文から退避した主張である。後続の固有ベクトルの冪の証明は、",
        "行列の冪の定義と積の作用から直接帰納するため、この主張を引用しない。",
        "この主張にしか使わない反復記号も本文に置かない。",
      ]),
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{\mathcal{J}}(\overline{\mathbb{Q}})`),
        " と ",
        math(String.raw`v\in V_{\mathcal{J}}`),
        " に対し、作用の反復を ",
      ]),
      displayMath(String.raw`\mathrm{it}^{[0]}_A(v):=v,\qquad \mathrm{it}^{[k+1]}_A(v):=A\cdot\mathrm{it}^{[k]}_A(v)\quad(k\in\mathbb{N})`),
      paragraph(["で定める。行列の冪の定義から、次の等式が成り立つ。"]),
      displayMath(String.raw`A^k\cdot v=\mathrm{it}^{[k]}_A(v)\quad(k\in\mathbb{N})`),
      paragraph([
        "出発点では、冪の定義により ",
        math(String.raw`A^0\cdot v=I^{\overline{\mathbb{Q}}}_{\mathcal{J}}\cdot v`),
        "、単位行列の作用により ",
        math(String.raw`I^{\overline{\mathbb{Q}}}_{\mathcal{J}}\cdot v=v`),
        "、反復の定義により ",
        math(String.raw`v=\mathrm{it}^{[0]}_A(v)`),
        " となる。",
      ]),
      displayMath(String.raw`\begin{aligned}
A^{k+1}\cdot v
&=(A A^k)\cdot v &&(\because\ \text{冪の定義})\\
&=A\cdot(A^k\cdot v) &&(\because\ \blkref{claim_qbar_action_product})\\
&=A\cdot\mathrm{it}^{[k]}_A(v) &&(\because\ \text{帰納法の仮定})\\
&=\mathrm{it}^{[k+1]}_A(v) &&(\because\ \text{反復の定義})
\end{aligned}`),
      paragraph([
        "検算は ",
        math(String.raw`\mathcal{J}=R_L`),
        " の有限例で行った。Lean の具体版と必要十分版も保管する。",
      ]),
    ],
  },
]);
