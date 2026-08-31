/**
 * 章「相互到達成分の商が定める有限半順序」。
 * 前章で得た相互到達成分の全体を有限集合として取り出し、その上に到達関係から誘導される
 * 二項関係を定める。代表の取り方に依らないこと、反射的・推移的であること、そして
 * 前章では破れていた反対称性が商の上では回復することを示す。
 * 有限集合、写像、自然数だけを使い、R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_reachability_quotient_order_definition_component_set",
    kind: "definition",
    title: { text: "相互到達成分の全体" },
    labels: ["def_neighborhood_mutual_reachability_component_set"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), "（",
        ref("def_finite_neighborhood_assignment_space"),
        "）に対し、", math(String.raw`V`), " の部分集合の集合 ",
        math(String.raw`\mathcal Q(N)`), " を",
      ]),
      displayMath(String.raw`\mathcal Q(N):=\bigl\{\,C_N(v)\ \bigm|\ v\in V\,\bigr\}`),
      paragraph([
        "で定める。", math(String.raw`C_N`), " は ",
        ref("def_neighborhood_mutual_reachability_component"),
        " の相互到達成分割り当てである。",
        math(String.raw`\mathcal Q(N)`), " は写像 ",
        math(String.raw`v\mapsto C_N(v)`), " の像であり、",
        math(String.raw`V`), " が有限なので有限集合である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_claim_component_nonempty",
    kind: "claim",
    title: { text: "相互到達成分は空でない" },
    labels: ["claim_neighborhood_mutual_reachability_component_nonempty"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`Q\in\mathcal Q(N)`), " について ",
        math(String.raw`Q\neq\emptyset`), " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_neighborhood_mutual_reachability_component_set"),
        " により、", math(String.raw`Q=C_N(u)`), " となる ",
        math(String.raw`u\in V`), " が存在する。",
        ref("claim_neighborhood_mutual_reachability_components_partition"),
        " の後半により ", math(String.raw`u\in C_N(u)`), " であり、",
        math(String.raw`u\in Q`), " を得るので ", math(String.raw`Q\neq\emptyset`),
        " である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_claim_representative",
    kind: "claim",
    title: { text: "成分はその任意の元の相互到達成分に一致する" },
    labels: ["claim_neighborhood_mutual_reachability_component_representative"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        "、", math(String.raw`Q\in\mathcal Q(N)`), " と ",
        math(String.raw`v\in Q`), " について ", math(String.raw`Q=C_N(v)`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_neighborhood_mutual_reachability_component_set"),
        " により、", math(String.raw`Q=C_N(u)`), " となる ",
        math(String.raw`u\in V`), " が存在する。仮定より ",
        math(String.raw`v\in C_N(u)`), " である。",
        ref("claim_neighborhood_mutual_reachability_components_partition"),
        " の後半により ", math(String.raw`v\in C_N(v)`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
v&\in C_N(u)\cap C_N(v)\\
&\Longrightarrow C_N(u)\cap C_N(v)\neq\emptyset
  \qquad(\because\ \text{元を持つ集合は空でない})\\
&\Longrightarrow C_N(u)=C_N(v)
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_components_partition} \text{ の前半})\\
&\Longrightarrow Q=C_N(v)
  \qquad(\because\ Q=C_N(u))
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_definition_relation",
    kind: "definition",
    title: { text: "相互到達成分の上の到達関係" },
    labels: ["def_neighborhood_mutual_reachability_component_order"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
        math(String.raw`\mathcal Q(N)`), " 上の二項関係 ",
        math(String.raw`\sqsubseteq_N`), " を",
      ]),
      displayMath(String.raw`Q\sqsubseteq_N R
:\Longleftrightarrow
\exists v\in Q,\ \exists w\in R,\ v\preceq_N w
\qquad(Q,R\in\mathcal Q(N))`),
      paragraph([
        "で定める。", math(String.raw`\preceq_N`), " は ",
        ref("def_neighborhood_reachability_preorder"),
        " の到達関係である。", math(String.raw`\mathcal Q(N)`),
        " が有限なので、この関係は ",
        math(String.raw`\mathcal Q(N)\times\mathcal Q(N)`),
        " の有限部分集合として与えられる。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_claim_representative_independent",
    kind: "claim",
    title: { text: "成分の上の到達関係は代表の取り方に依らない" },
    labels: ["claim_neighborhood_mutual_reachability_component_order_representative_independent"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`Q,R\in\mathcal Q(N)`), " について",
      ]),
      displayMath(String.raw`Q\sqsubseteq_N R
\Longleftrightarrow
\bigl(\forall v\in Q,\ \forall w\in R,\ v\preceq_N w\bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "右向きを示す。", math(String.raw`Q\sqsubseteq_N R`), " を仮定する。",
        ref("def_neighborhood_mutual_reachability_component_order"),
        " により、", math(String.raw`v_0\in Q`), "、", math(String.raw`w_0\in R`),
        " で ", math(String.raw`v_0\preceq_N w_0`),
        " を満たすものが存在する。任意の ", math(String.raw`v\in Q`),
        " と ", math(String.raw`w\in R`), " を取る。",
      ]),
      paragraph([
        ref("claim_neighborhood_mutual_reachability_component_representative"),
        " を ", math(String.raw`v\in Q`), " に適用して ",
        math(String.raw`Q=C_N(v)`), " であり、",
        math(String.raw`v_0\in Q`), " より ", math(String.raw`v_0\in C_N(v)`),
        " である。同様に ", math(String.raw`R=C_N(w)`), " であり ",
        math(String.raw`w_0\in C_N(w)`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
v_0&\in C_N(v)\\
&\Longrightarrow v\approx_N v_0
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_membership})\\
&\Longrightarrow v\preceq_N v_0
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
w_0&\in C_N(w)\\
&\Longrightarrow w\approx_N w_0
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_membership})\\
&\Longrightarrow w_0\preceq_N w
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
v&\preceq_N v_0\\
&\Longrightarrow v\preceq_N w_0
  \qquad(\because\ \blkref{claim_neighborhood_reachability_preorder_transitive} \text{ を } v\preceq_N v_0,\ v_0\preceq_N w_0 \text{ に適用})\\
&\Longrightarrow v\preceq_N w
  \qquad(\because\ \blkref{claim_neighborhood_reachability_preorder_transitive} \text{ を } v\preceq_N w_0,\ w_0\preceq_N w \text{ に適用})
\end{aligned}`),
      paragraph([
        "であり、右辺を得る。",
      ]),
      paragraph([
        "左向きを示す。右辺を仮定する。",
        ref("claim_neighborhood_mutual_reachability_component_nonempty"),
        " により ", math(String.raw`v\in Q`), " と ", math(String.raw`w\in R`),
        " を取れる。右辺をこの組に適用して ", math(String.raw`v\preceq_N w`),
        " を得るので、", ref("def_neighborhood_mutual_reachability_component_order"),
        " の存在条件が満たされ ", math(String.raw`Q\sqsubseteq_N R`), " である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_claim_reflexive",
    kind: "claim",
    title: { text: "成分の上の到達関係は反射的である" },
    labels: ["claim_neighborhood_mutual_reachability_component_order_reflexive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`Q\in\mathcal Q(N)`), " について ",
        math(String.raw`Q\sqsubseteq_N Q`), " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_neighborhood_mutual_reachability_component_nonempty"),
        " により ", math(String.raw`v\in Q`), " を取れる。",
        ref("claim_neighborhood_reachability_preorder_reflexive"),
        " により ", math(String.raw`v\preceq_N v`), " であり、",
        ref("def_neighborhood_mutual_reachability_component_order"),
        " の存在条件が ", math(String.raw`v\in Q`), "、",
        math(String.raw`v\in Q`), " で満たされるので ",
        math(String.raw`Q\sqsubseteq_N Q`), " である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_claim_transitive",
    kind: "claim",
    title: { text: "成分の上の到達関係は推移的である" },
    labels: ["claim_neighborhood_mutual_reachability_component_order_transitive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`Q,R,S\in\mathcal Q(N)`), " について、",
        math(String.raw`Q\sqsubseteq_N R`), " かつ ",
        math(String.raw`R\sqsubseteq_N S`), " ならば ",
        math(String.raw`Q\sqsubseteq_N S`), " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_neighborhood_mutual_reachability_component_nonempty"),
        " により ", math(String.raw`v\in Q`), "、", math(String.raw`u\in R`),
        "、", math(String.raw`w\in S`), " を取れる。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q\sqsubseteq_N R
&\Longrightarrow v\preceq_N u
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_order_representative_independent})\\
R\sqsubseteq_N S
&\Longrightarrow u\preceq_N w
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_order_representative_independent})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
v&\preceq_N u\\
&\Longrightarrow v\preceq_N w
  \qquad(\because\ \blkref{claim_neighborhood_reachability_preorder_transitive} \text{ を } v\preceq_N u,\ u\preceq_N w \text{ に適用})\\
&\Longrightarrow Q\sqsubseteq_N S
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability_component_order} \text{ の存在条件が } v\in Q,\ w\in S \text{ で満たされる})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_claim_antisymmetric",
    kind: "claim",
    title: { text: "成分の上の到達関係は反対称である" },
    labels: ["claim_neighborhood_mutual_reachability_component_order_antisymmetric"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`Q,R\in\mathcal Q(N)`), " について、",
        math(String.raw`Q\sqsubseteq_N R`), " かつ ",
        math(String.raw`R\sqsubseteq_N Q`), " ならば ",
        math(String.raw`Q=R`), " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_neighborhood_mutual_reachability_component_nonempty"),
        " により ", math(String.raw`v\in Q`), " を取り、固定する。任意の ",
        math(String.raw`w\in R`), " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q\sqsubseteq_N R
&\Longrightarrow v\preceq_N w
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_order_representative_independent})\\
R\sqsubseteq_N Q
&\Longrightarrow w\preceq_N v
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_order_representative_independent})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
v&\preceq_N w\\
&\Longrightarrow v\approx_N w
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability} \text{ の二条件が } v\preceq_N w,\ w\preceq_N v \text{ で満たされる})\\
&\Longrightarrow w\in C_N(v)
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_membership})\\
&\Longrightarrow w\in Q
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_representative} \text{ を } v\in Q \text{ に適用})
\end{aligned}`),
      paragraph([
        "であり ", math(String.raw`R\subseteq Q`), " を得る。",
        math(String.raw`Q`), " と ", math(String.raw`R`),
        " を入れ替えて同じ論証を繰り返すと ",
        math(String.raw`Q\subseteq R`), " を得るので、",
        math(String.raw`Q=R`), " である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_claim_partial_order",
    kind: "claim",
    title: { text: "商は有限半順序集合である" },
    labels: ["claim_neighborhood_mutual_reachability_component_order_is_partial_order"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " について、組 ",
        math(String.raw`(\mathcal Q(N),\sqsubseteq_N)`),
        " は有限半順序集合である。すなわち ",
        math(String.raw`\mathcal Q(N)`), " は有限集合であり、",
        math(String.raw`\sqsubseteq_N`),
        " は反射的・推移的・反対称である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathcal Q(N)`), " が有限であることは ",
        ref("def_neighborhood_mutual_reachability_component_set"),
        " による。反射性は ",
        ref("claim_neighborhood_mutual_reachability_component_order_reflexive"),
        "、推移性は ",
        ref("claim_neighborhood_mutual_reachability_component_order_transitive"),
        "、反対称性は ",
        ref("claim_neighborhood_mutual_reachability_component_order_antisymmetric"),
        " による。",
      ]),
      paragraph([
        ref("claim_neighborhood_reachability_preorder_not_antisymmetric"),
        " で ", math(String.raw`\preceq_N`),
        " について破れていた反対称性が、商の上では回復している。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_quotient_order_claim_finite_decidable",
    kind: "claim",
    title: { text: "商と半順序は有限手続きで決定できる" },
    labels: ["claim_neighborhood_mutual_reachability_component_order_finite_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " について、",
        math(String.raw`\mathcal Q(N)`), " の元の全体と、",
        math(String.raw`\sqsubseteq_N`), " の全ての組に対する成否は、",
        math(String.raw`V`),
        " の元の有限個の所属判定だけで決定できる。所属判定の回数は ",
        math(String.raw`(|V|^2+1)\cdot|V|^3+4|V|^2`), " 回以下である。さらに ",
        math(String.raw`|\mathcal Q(N)|\leq|V|`), " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_neighborhood_reachability_preorder_finite_decidable"), " により、",
        math(String.raw`N^{*}`), " の全ての値と、全ての ",
        math(String.raw`v\in V`), " についての ", math(String.raw`C_N(v)`),
        " は ", math(String.raw`(|V|^2+1)\cdot|V|^3+3|V|^2`),
        " 回以下の所属判定で決まる。以下ではこの表が得られているとして、追加の回数を数える。",
      ]),
      paragraph([
        ref("def_neighborhood_mutual_reachability_component_set"), " により ",
        math(String.raw`\mathcal Q(N)`), " は写像 ",
        math(String.raw`v\mapsto C_N(v)`), " の像であり、この表から追加の所属判定なしに ",
        math(String.raw`|V|`), " 個の部分集合として書き下せる。像は ",
        math(String.raw`|V|`), " 個の値からなるので ",
        math(String.raw`|\mathcal Q(N)|\leq|V|`), " である。",
      ]),
      paragraph([
        ref("claim_neighborhood_mutual_reachability_component_representative"),
        " により、各 ", math(String.raw`Q\in\mathcal Q(N)`),
        " はその任意の元 ", math(String.raw`v\in Q`), " について ",
        math(String.raw`Q=C_N(v)`), " を満たすので、代表 ",
        math(String.raw`v_Q\in Q`), " を一つ選べる。組 ",
        math(String.raw`(Q,R)\in\mathcal Q(N)\times\mathcal Q(N)`), " について ",
        ref("claim_neighborhood_mutual_reachability_component_order_representative_independent"),
        " により ", math(String.raw`Q\sqsubseteq_N R`), " は ",
        math(String.raw`v_Q\preceq_N v_R`), " と同値であり、",
        ref("def_neighborhood_reachability_preorder"), " によりこれは ",
        math(String.raw`v_R\in N^{*}(v_Q)`),
        " の一回の所属判定で決まる。組は ",
        math(String.raw`|\mathcal Q(N)|^2\leq|V|^2`),
        " 個なので、追加は ", math(String.raw`|V|^2`), " 回以下である。",
      ]),
      paragraph([
        "合計すると ",
        math(String.raw`(|V|^2+1)\cdot|V|^3+3|V|^2+|V|^2
=(|V|^2+1)\cdot|V|^3+4|V|^2`),
        " 回以下の所属判定で全てが決まる。",
      ]),
    ],
  },
]);
