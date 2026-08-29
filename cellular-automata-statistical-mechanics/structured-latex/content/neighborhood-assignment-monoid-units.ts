/**
 * 章「有限近傍割り当てモノイドの可逆元」。
 * 合成近傍について可逆な割り当てが、有限舞台の置換から得る一元近傍割り当てに限ることを示す。
 * 有限集合・有限部分集合・自然数だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_monoid_units_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限近傍割り当てモノイドの可逆元" },
    labels: [],
  },
  {
    id: "neighborhood_assignment_monoid_units_definition_unit",
    kind: "definition",
    title: { text: "合成近傍について可逆な近傍割り当て" },
    labels: ["def_invertible_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ", math(String.raw`N\in\mathcal N(V)`),
        "（", ref("def_finite_neighborhood_assignment_space"), "）",
        " に対し、ある ", math(String.raw`M\in\mathcal N(V)`), " が存在して",
      ]),
      displayMath(String.raw`N\star M=I_V=M\star N`),
      paragraph([
        "となるとき（合成は ", ref("def_composed_neighborhood"), "、単位元は ",
        ref("def_identity_neighborhood_assignment"), "）、", math(String.raw`N`),
        " を合成近傍について可逆と呼び、",
        math(String.raw`M`), " をその逆元と呼ぶ。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_monoid_units_definition_permutation_assignment",
    kind: "definition",
    title: { text: "置換が定める一元近傍割り当て" },
    labels: ["def_permutation_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " の全単射 ", math(String.raw`\sigma:V\to V`),
        " に対し、近傍割り当て ", math(String.raw`P_\sigma\in\mathcal N(V)`),
        "（", ref("def_finite_neighborhood_assignment_space"), "）を",
      ]),
      displayMath(String.raw`P_\sigma(v):=\{\sigma(v)\}\qquad(v\in V)`),
      paragraph(["で定める。"])],
  },
  {
    id: "neighborhood_assignment_monoid_units_claim_characterization",
    kind: "claim",
    title: { text: "可逆元は置換が定める一元近傍割り当てに限る" },
    labels: ["claim_invertible_neighborhood_assignments_are_permutations"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ", math(String.raw`N\in\mathcal N(V)`),
        " について、", math(String.raw`N`), " が合成近傍について可逆であることと、ある全単射 ",
        math(String.raw`\sigma:V\to V`), " により ", math(String.raw`N=P_\sigma`),
        " と書けることは同値である。この ", math(String.raw`\sigma`), " は一意である。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ", math(String.raw`N`), " が可逆であり、", math(String.raw`M`),
        " がその逆元であるとする。任意の ", math(String.raw`v\in V`), " について",
      ]),
      displayMath(String.raw`(N\star M)(v)=\{v\}
\qquad(\because\ N\star M=I_V,\ \blkref{def_identity_neighborhood_assignment})`),
      paragraph([
        ref("def_composed_neighborhood"), " より、ある ", math(String.raw`u\in N(v)`),
        " が存在して ", math(String.raw`v\in M(u)`), " である。特に ",
        math(String.raw`N(v)\neq\varnothing`), " である。以下、任意の ",
        math(String.raw`u\in N(v)`), " を取る。",
      ]),
      displayMath(String.raw`M(u)\subseteq\{v\}
\qquad(\because\ M(u)\subseteq\bigcup_{x\in N(v)}M(x)=(N\star M)(v)=\{v\})`),
      paragraph(["一方で"]),
      displayMath(String.raw`(M\star N)(u)=\{u\}
\qquad(\because\ M\star N=I_V,\ \blkref{def_identity_neighborhood_assignment})`),
      paragraph([
        "である。右辺は空でないので、", ref("def_composed_neighborhood"), " より ",
        math(String.raw`M(u)\neq\varnothing`), " である。したがって",
      ]),
      displayMath(String.raw`M(u)=\{v\}
\qquad(\because\ M(u)\neq\varnothing\ \text{かつ}\ M(u)\subseteq\{v\})`),
      paragraph([ref("def_composed_neighborhood"), " をもう一度用いると"]),
      displayMath(String.raw`\begin{aligned}
\{u\}
&=(M\star N)(u)\qquad(\because\ M\star N=I_V)\\
&=\bigcup_{x\in M(u)}N(x)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&=N(v)\qquad(\because\ M(u)=\{v\})
\end{aligned}`),
      paragraph([
        "を得る。よって各 ", math(String.raw`v\in V`), " には ",
        math(String.raw`N(v)=\{u\}`), " を満たす唯一の ", math(String.raw`u\in V`),
        " がある。この元を ", math(String.raw`\sigma(v)`), " と定める。",
      ]),
      paragraph([
        math(String.raw`\sigma(v)=\sigma(v')`), " とすると、上で得た等式により",
      ]),
      displayMath(String.raw`\{v\}=M(\sigma(v))=M(\sigma(v'))=\{v'\}`),
      paragraph([
        "なので ", math(String.raw`v=v'`), " である。したがって ", math(String.raw`\sigma`),
        " は単射である。",
      ]),
      paragraph([
        "次に、上の一元性の論証で ", math(String.raw`N`), " と ", math(String.raw`M`),
        " の役割を入れ替える。各 ", math(String.raw`u\in V`), " に対して唯一の ",
        math(String.raw`\tau(u)\in V`), " が存在し、",
      ]),
      displayMath(String.raw`M(u)=\{\tau(u)\}\qquad\text{かつ}\qquad N(\tau(u))=\{u\}`),
      paragraph(["を得る。一方、", math(String.raw`N(v)=\{\sigma(v)\}`), " なので"]),
      displayMath(String.raw`\begin{aligned}
\{\sigma(\tau(u))\}
&=N(\tau(u))\qquad(\because\ N(v)=\{\sigma(v)\})\\
&=\{u\}\qquad(\because\ N(\tau(u))=\{u\})
\end{aligned}`),
      paragraph([
        "であり、", math(String.raw`\sigma(\tau(u))=u`), " である。任意の ",
        math(String.raw`u\in V`), " が ", math(String.raw`\sigma`),
        " の値なので、", math(String.raw`\sigma`),
        " は全射である。この全射性の導出は ", math(String.raw`V`),
        " の有限性を使わない。以上により ", math(String.raw`\sigma`), " は全単射である。",
        ref("def_permutation_neighborhood_assignment"), " より ", math(String.raw`N=P_\sigma`),
        " である。また各 ", math(String.raw`\sigma(v)`), " は一元集合 ", math(String.raw`N(v)`),
        " の唯一の元なので、", math(String.raw`\sigma`), " も一意である。",
      ]),
      paragraph([
        "逆に全単射 ", math(String.raw`\sigma:V\to V`), " を取り、その逆写像を ",
        math(String.raw`\sigma^{-1}`), " とする。任意の ", math(String.raw`v\in V`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(P_\sigma\star P_{\sigma^{-1}})(v)
&=\bigcup_{u\in\{\sigma(v)\}}\{\sigma^{-1}(u)\}
  \qquad(\because\ \blkref{def_composed_neighborhood},\ \blkref{def_permutation_neighborhood_assignment})\\
&=\{\sigma^{-1}(\sigma(v))\}\qquad(\because\ \text{一元集合を添字とする合併})\\
&=\{v\}\qquad(\because\ \sigma^{-1}\circ\sigma=\mathrm{id}_V)\\
&=I_V(v)\qquad(\because\ \blkref{def_identity_neighborhood_assignment})
\end{aligned}`),
      paragraph(["である。同様に"]),
      displayMath(String.raw`P_{\sigma^{-1}}\star P_\sigma=I_V
\qquad(\because\ \sigma\circ\sigma^{-1}=\mathrm{id}_V)`),
      paragraph([
        "である。写像の外延性により最初の合成も ", math(String.raw`I_V`),
        " に等しいので、", ref("def_invertible_neighborhood_assignment"), " より ",
        math(String.raw`P_\sigma`), " は可逆である。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_monoid_units_claim_inverse_unique",
    kind: "claim",
    title: { text: "可逆元の逆元は一意である" },
    labels: ["claim_invertible_neighborhood_assignment_inverse_unique"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ", math(String.raw`N\in\mathcal N(V)`),
        " について、", ref("def_invertible_neighborhood_assignment"), " の条件を満たす ",
        math(String.raw`M\in\mathcal N(V)`), " は高々一つである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`M,M'\in\mathcal N(V)`), " がともに ",
        ref("def_invertible_neighborhood_assignment"), " の条件を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
M
&=M\star I_V\qquad(\because\ \blkref{claim_identity_neighborhood_assignment_is_composition_identity})\\
&=M\star(N\star M')\qquad(\because\ N\star M'=I_V)\\
&=(M\star N)\star M'\qquad(\because\ \blkref{claim_composed_neighborhood_associative})\\
&=I_V\star M'\qquad(\because\ M\star N=I_V)\\
&=M'\qquad(\because\ \blkref{claim_identity_neighborhood_assignment_is_composition_identity})
\end{aligned}`),
    ],
  },
  {
    id: "neighborhood_assignment_monoid_units_claim_cardinality_decidable",
    kind: "claim",
    title: { text: "可逆元の個数と有限決定" },
    labels: ["claim_invertible_neighborhood_assignment_cardinality_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`|V|=n\in\mathbb N`), " のとき、合成近傍について可逆な近傍割り当ては ",
        math(String.raw`n!`), " 個である。可逆元全体、各可逆元の逆元、および可逆性は有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_invertible_neighborhood_assignments_are_permutations"), " により、可逆元と ",
        math(String.raw`V`), " の置換は一対一に対応する。有限な ", math(String.raw`n`),
        " 元集合の置換は ", math(String.raw`n!`), " 個なので個数公式を得る。有限集合 ",
        math(String.raw`V`), " の置換を全列挙し、", ref("def_permutation_neighborhood_assignment"),
        " の有限表を作れば可逆元全体を決定できる。",
        ref("claim_invertible_neighborhood_assignment_inverse_unique"),
        " により逆元は一意であり、逆置換の有限表からそれを決定できる。任意の ",
        math(String.raw`N\in\mathcal N(V)`), " と列挙した可逆元との等号を有限回比較すれば可逆性を決定できる。",
      ]),
    ],
  },
]);
