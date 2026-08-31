/**
 * 章「有限半順序の相互到達成分商としての実現」。
 * 前章で、近傍割り当ての相互到達成分の商が有限半順序集合になることを示した。
 * ここでは逆向きに、任意の有限半順序が、ある近傍割り当ての商としてちょうど現れることを示す。
 * 有限集合、写像、自然数だけを使い、R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_reachability_realization_definition_assignment",
    kind: "definition",
    title: { text: "部分順序が定める近傍割り当て" },
    labels: ["def_partial_order_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と、", math(String.raw`V`), " 上の部分順序 ",
        math(String.raw`R\subseteq V\times V`), "（", ref("def_partial_order"), "）に対し、",
        math(String.raw`N_R\in\mathcal N(V)`), "（", ref("def_finite_neighborhood_assignment_space"),
        "）を",
      ]),
      displayMath(String.raw`N_R(v):=\{\,w\in V\ \mid\ (v,w)\in R\,\}\qquad(v\in V)`),
      paragraph([
        "で定める。", math(String.raw`V`), " が有限なので各 ", math(String.raw`N_R(v)`),
        " は ", math(String.raw`V`), " の部分集合であり、", math(String.raw`N_R`),
        " は近傍割り当てである。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_reflexive",
    kind: "claim",
    title: { text: "部分順序が定める近傍割り当ては自己近傍を含む" },
    labels: ["claim_partial_order_neighborhood_assignment_reflexive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " と ",
        math(String.raw`v\in V`), " について ", math(String.raw`v\in N_R(v)`), " が成り立つ。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(v,v)&\in R
  \qquad(\because\ \blkref{def_partial_order} \text{ の反射性})\\
&\Longrightarrow v\in N_R(v)
  \qquad(\because\ \blkref{def_partial_order_neighborhood_assignment})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_transitive",
    kind: "claim",
    title: { text: "部分順序が定める近傍割り当ては推移的である" },
    labels: ["claim_partial_order_neighborhood_assignment_transitive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " について ",
        math(String.raw`N_R`), " は ", ref("def_transitive_neighborhood_assignment"),
        " の意味で推移的である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`v,u,w\in V`), " が ", math(String.raw`u\in N_R(v)`), " かつ ",
        math(String.raw`w\in N_R(u)`), " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
u\in N_R(v)\ \land\ w\in N_R(u)
&\Longrightarrow (v,u)\in R\ \land\ (u,w)\in R
  \qquad(\because\ \blkref{def_partial_order_neighborhood_assignment})\\
&\Longrightarrow (v,w)\in R
  \qquad(\because\ \blkref{def_partial_order} \text{ の推移性})\\
&\Longrightarrow w\in N_R(v)
  \qquad(\because\ \blkref{def_partial_order_neighborhood_assignment})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_closure_eq",
    kind: "claim",
    title: { text: "部分順序が定める近傍割り当ては自身の反射推移閉包に等しい" },
    labels: ["claim_partial_order_neighborhood_assignment_closure_eq"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " について ",
        math(String.raw`N_R^{*}=N_R`), " が成り立つ。", math(String.raw`(\cdot)^{*}`), " は ",
        ref("def_neighborhood_assignment_reflexive_transitive_closure"), " の反射推移閉包である。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ", ref("claim_neighborhood_assignment_pointwise_inclusion_partial_order"),
        " の反射性により ", math(String.raw`N_R\sqsubseteq N_R`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
N_R^{*}&\sqsubseteq N_R
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_minimal} \text{ を }
  \blkref{claim_partial_order_neighborhood_assignment_reflexive},\
  \blkref{claim_partial_order_neighborhood_assignment_transitive},\
  N_R\sqsubseteq N_R \text{ に適用})\\
N_R&\sqsubseteq N_R^{*}
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_contains_original})\\
N_R^{*}&=N_R
  \qquad(\because\ \blkref{claim_neighborhood_assignment_pointwise_inclusion_partial_order}
  \text{ の反対称性})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_preorder_eq",
    kind: "claim",
    title: { text: "到達関係は部分順序そのものに一致する" },
    labels: ["claim_partial_order_neighborhood_assignment_preorder_eq"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " と ",
        math(String.raw`v,w\in V`), " について",
      ]),
      displayMath(String.raw`v\preceq_{N_R}w\Longleftrightarrow(v,w)\in R`),
      paragraph([
        "が成り立つ。", math(String.raw`\preceq_{N_R}`), " は ",
        ref("def_neighborhood_reachability_preorder"), " の到達関係である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
v\preceq_{N_R}w
&\Longleftrightarrow w\in N_R^{*}(v)
  \qquad(\because\ \blkref{def_neighborhood_reachability_preorder})\\
&\Longleftrightarrow w\in N_R(v)
  \qquad(\because\ \blkref{claim_partial_order_neighborhood_assignment_closure_eq})\\
&\Longleftrightarrow (v,w)\in R
  \qquad(\because\ \blkref{def_partial_order_neighborhood_assignment})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_component_singleton",
    kind: "claim",
    title: { text: "相互到達成分は一元集合である" },
    labels: ["claim_partial_order_neighborhood_assignment_component_singleton"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " と ",
        math(String.raw`v\in V`), " について ", math(String.raw`C_{N_R}(v)=\{v\}`),
        " が成り立つ。", math(String.raw`C_{N_R}`), " は ",
        ref("def_neighborhood_mutual_reachability_component"), " の相互到達成分割り当てである。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`w\in V`), " を取る。"]),
      displayMath(String.raw`\begin{aligned}
w\in C_{N_R}(v)
&\Longleftrightarrow v\approx_{N_R}w
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_membership})\\
&\Longleftrightarrow v\preceq_{N_R}w\ \land\ w\preceq_{N_R}v
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability})\\
&\Longleftrightarrow (v,w)\in R\ \land\ (w,v)\in R
  \qquad(\because\ \blkref{claim_partial_order_neighborhood_assignment_preorder_eq})
\end{aligned}`),
      paragraph([
        "を得る。右辺から ", math(String.raw`v=w`), " が従うのは ", ref("def_partial_order"),
        " の反対称性による。逆に ", math(String.raw`v=w`), " のとき ",
        math(String.raw`(v,w)\in R`), " と ", math(String.raw`(w,v)\in R`),
        " はいずれも ", ref("def_partial_order"), " の反射性による。したがって",
      ]),
      displayMath(String.raw`w\in C_{N_R}(v)\Longleftrightarrow w\in\{v\}`),
      paragraph(["であり、集合の外延性から主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_quotient_singletons",
    kind: "claim",
    title: { text: "商は一元集合の全体である" },
    labels: ["claim_partial_order_neighborhood_assignment_quotient_singletons"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " について",
      ]),
      displayMath(String.raw`\mathcal Q(N_R)=\bigl\{\,\{v\}\ \bigm|\ v\in V\,\bigr\}`),
      paragraph([
        "が成り立つ。", math(String.raw`\mathcal Q`), " は ",
        ref("def_neighborhood_mutual_reachability_component_set"), " の相互到達成分の全体である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\mathcal Q(N_R)
&=\bigl\{\,C_{N_R}(v)\ \bigm|\ v\in V\,\bigr\}
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability_component_set})\\
&=\bigl\{\,\{v\}\ \bigm|\ v\in V\,\bigr\}
  \qquad(\because\ \blkref{claim_partial_order_neighborhood_assignment_component_singleton})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_definition_realization_map",
    kind: "definition",
    title: { text: "実現写像" },
    labels: ["def_partial_order_quotient_realization_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " に対し、写像",
      ]),
      displayMath(String.raw`\eta_R:V\longrightarrow\mathcal Q(N_R),\qquad
\eta_R(v):=\{v\}`),
      paragraph([
        "を定める。値が ", math(String.raw`\mathcal Q(N_R)`), " に入ることは ",
        ref("claim_partial_order_neighborhood_assignment_quotient_singletons"), " による。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_bijective",
    kind: "claim",
    title: { text: "実現写像は全単射である" },
    labels: ["claim_partial_order_quotient_realization_map_bijective"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " について ",
        math(String.raw`\eta_R`), "（", ref("def_partial_order_quotient_realization_map"),
        "）は全単射である。",
      ]),
    ],
    proof: [
      paragraph(["単射性を示す。", math(String.raw`v,w\in V`), " が ",
        math(String.raw`\eta_R(v)=\eta_R(w)`), " を満たすとする。"]),
      displayMath(String.raw`\begin{aligned}
\{v\}&=\{w\}
  \qquad(\because\ \blkref{def_partial_order_quotient_realization_map})\\
&\Longrightarrow v\in\{w\}
  \qquad(\because\ v\in\{v\})\\
&\Longrightarrow v=w
  \qquad(\because\ \text{一元集合の所属})
\end{aligned}`),
      paragraph(["全射性を示す。", math(String.raw`Q\in\mathcal Q(N_R)`), " を取る。"]),
      displayMath(String.raw`\begin{aligned}
Q&\in\bigl\{\,\{v\}\ \bigm|\ v\in V\,\bigr\}
  \qquad(\because\ \blkref{claim_partial_order_neighborhood_assignment_quotient_singletons})\\
&\Longrightarrow \exists v\in V,\ Q=\{v\}
  \qquad(\because\ \text{像への所属})\\
&\Longrightarrow \exists v\in V,\ Q=\eta_R(v)
  \qquad(\because\ \blkref{def_partial_order_quotient_realization_map})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_order_preserved",
    kind: "claim",
    title: { text: "実現写像は部分順序を商の半順序へ両方向に移す" },
    labels: ["claim_partial_order_quotient_realization_order"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " と ",
        math(String.raw`v,w\in V`), " について",
      ]),
      displayMath(String.raw`\eta_R(v)\sqsubseteq_{N_R}\eta_R(w)\Longleftrightarrow(v,w)\in R`),
      paragraph([
        "が成り立つ。", math(String.raw`\sqsubseteq_{N_R}`), " は ",
        ref("def_neighborhood_mutual_reachability_component_order"), " の商の上の到達関係である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\eta_R(v)\sqsubseteq_{N_R}\eta_R(w)
&\Longleftrightarrow \{v\}\sqsubseteq_{N_R}\{w\}
  \qquad(\because\ \blkref{def_partial_order_quotient_realization_map})\\
&\Longleftrightarrow \exists a\in\{v\},\ \exists b\in\{w\},\ a\preceq_{N_R}b
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability_component_order})\\
&\Longleftrightarrow v\preceq_{N_R}w
  \qquad(\because\ \text{一元集合の所属})\\
&\Longleftrightarrow (v,w)\in R
  \qquad(\because\ \blkref{claim_partial_order_neighborhood_assignment_preorder_eq})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_realization_claim_finite_decidable",
    kind: "claim",
    title: { text: "実現は有限手続きで構成できる" },
    labels: ["claim_partial_order_quotient_realization_finite_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`),
        " が与えられたとき、", math(String.raw`N_R`), " は ", math(String.raw`|V|^2`),
        " 回以下の ", math(String.raw`R`), " への所属判定で構成でき、",
        math(String.raw`\mathcal Q(N_R)`), " と ", math(String.raw`\eta_R`), " は ",
        math(String.raw`|V|`), " 回以下の一元集合の書き出しで構成できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_partial_order_neighborhood_assignment"), " により ",
        math(String.raw`N_R`), " を定めるには、各 ", math(String.raw`v\in V`),
        " と各 ", math(String.raw`w\in V`), " について ", math(String.raw`(v,w)\in R`),
        " を判定すればよい。組の個数は ", math(String.raw`|V|\cdot|V|=|V|^2`), " である。",
      ]),
      paragraph([
        ref("claim_partial_order_neighborhood_assignment_quotient_singletons"), " により ",
        math(String.raw`\mathcal Q(N_R)`), " は各 ", math(String.raw`v\in V`), " に対する ",
        math(String.raw`\{v\}`), " を集めたものであり、",
        ref("def_partial_order_quotient_realization_map"), " により ",
        math(String.raw`\eta_R`), " の値も同じ ", math(String.raw`|V|`),
        " 個の一元集合で尽きる。",
      ]),
    ],
  },
]);
