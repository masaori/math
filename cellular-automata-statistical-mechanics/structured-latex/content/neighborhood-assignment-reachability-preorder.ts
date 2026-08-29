/**
 * 章「到達前順序と相互到達成分」。
 * 近傍割り当ての反射推移閉包が定める二項関係が前順序であること、それが一般には
 * 反対称でないこと（二元舞台の反例）、相互到達関係が同値関係をなし、その類が
 * 閉包と閉包の転置の点ごとの積として書けて舞台を分割することを示す。
 * 有限集合、写像、自然数だけを使い、R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_reachability_preorder_heading",
    kind: "heading",
    level: 1,
    title: { text: "到達前順序と相互到達成分" },
    labels: [],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_definition_relation",
    kind: "definition",
    title: { text: "近傍割り当てが定める到達関係" },
    labels: ["def_neighborhood_reachability_preorder"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), "（",
        ref("def_finite_neighborhood_assignment_space"),
        "）に対し、", math(String.raw`V`), " 上の二項関係 ",
        math(String.raw`\preceq_N`), " を",
      ]),
      displayMath(String.raw`v\preceq_N w
:\Longleftrightarrow
w\in N^{*}(v)
\qquad(v,w\in V)`),
      paragraph([
        "で定める。", math(String.raw`N^{*}`), " は ",
        ref("def_neighborhood_assignment_reflexive_transitive_closure"),
        " の反射推移閉包である。関係 ", math(String.raw`\preceq_N`),
        " は ", math(String.raw`V\times V`),
        " の部分集合として与えられ、", math(String.raw`V`),
        " が有限なのでこの部分集合も有限である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_reflexive",
    kind: "claim",
    title: { text: "到達関係は反射的である" },
    labels: ["claim_neighborhood_reachability_preorder_reflexive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`v\in V`), " について ",
        math(String.raw`v\preceq_N v`), " が成り立つ。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
v&\in N^{*}(v)
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_reflexive})\\
&\Longleftrightarrow v\preceq_N v
  \qquad(\because\ \blkref{def_neighborhood_reachability_preorder})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_transitive",
    kind: "claim",
    title: { text: "到達関係は推移的である" },
    labels: ["claim_neighborhood_reachability_preorder_transitive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`v,u,w\in V`), " について、",
        math(String.raw`v\preceq_N u`), " かつ ", math(String.raw`u\preceq_N w`),
        " ならば ", math(String.raw`v\preceq_N w`), " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`v\preceq_N u`), " かつ ", math(String.raw`u\preceq_N w`),
        " と仮定する。", ref("def_neighborhood_reachability_preorder"), " により ",
        math(String.raw`u\in N^{*}(v)`), " かつ ",
        math(String.raw`w\in N^{*}(u)`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
w&\in N^{*}(v)
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_transitive} \text{ を } u\in N^{*}(v),\ w\in N^{*}(u) \text{ に適用})\\
&\Longleftrightarrow v\preceq_N w
  \qquad(\because\ \blkref{def_neighborhood_reachability_preorder})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_definition_witness",
    kind: "definition",
    title: { text: "反対称性が破れる二元舞台の近傍割り当て" },
    labels: ["def_reachability_preorder_antisymmetry_counterexample"],
    habitat: "finite",
    statement: [
      paragraph([
        "相異なる二元からなる有限集合 ",
        math(String.raw`V_2:=\{v_0,v_1\}`), "（", math(String.raw`v_0\neq v_1`),
        "）と、", math(String.raw`N_2\in\mathcal N(V_2)`), " を",
      ]),
      displayMath(String.raw`N_2(v_0):=\{v_1\},\qquad N_2(v_1):=\{v_0\}`),
      paragraph([
        "で定める。右辺はいずれも ", math(String.raw`V_2`),
        " の有限部分集合なので、", math(String.raw`N_2`), " は ",
        ref("def_finite_neighborhood_assignment_space"), " の近傍割り当てである。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_not_antisymmetric",
    kind: "claim",
    title: { text: "到達関係は反対称とは限らない" },
    labels: ["claim_neighborhood_reachability_preorder_not_antisymmetric"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_reachability_preorder_antisymmetry_counterexample"), " の ",
        math(String.raw`V_2`), " と ", math(String.raw`N_2`), " について",
      ]),
      displayMath(String.raw`v_0\preceq_{N_2}v_1,\qquad
v_1\preceq_{N_2}v_0,\qquad
v_0\neq v_1`),
      paragraph([
        "が成り立つ。したがって ", ref("def_neighborhood_reachability_preorder"),
        " の到達関係は、一般には ", ref("def_partial_order"),
        " の意味の反対称性を満たさない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
v_1&\in N_2(v_0)
  \qquad(\because\ \blkref{def_reachability_preorder_antisymmetry_counterexample})\\
&\Longrightarrow v_1\in N_2^{*}(v_0)
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_contains_original})\\
&\Longrightarrow v_0\preceq_{N_2}v_1
  \qquad(\because\ \blkref{def_neighborhood_reachability_preorder})
\end{aligned}`),
      paragraph([
        math(String.raw`v_0`), " と ", math(String.raw`v_1`),
        " を入れ替えて同じ三行を繰り返すと ",
        math(String.raw`v_1\preceq_{N_2}v_0`), " を得る。",
        math(String.raw`v_0\neq v_1`), " は ",
        ref("def_reachability_preorder_antisymmetry_counterexample"),
        " の仮定である。反対称性は ", math(String.raw`v_0\preceq_{N_2}v_1`),
        " と ", math(String.raw`v_1\preceq_{N_2}v_0`), " から ",
        math(String.raw`v_0=v_1`), " を要求するので、この ",
        math(String.raw`N_2`), " では成り立たない。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_definition_mutual",
    kind: "definition",
    title: { text: "相互到達関係" },
    labels: ["def_neighborhood_mutual_reachability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
        math(String.raw`V`), " 上の二項関係 ", math(String.raw`\approx_N`), " を",
      ]),
      displayMath(String.raw`v\approx_N w
:\Longleftrightarrow
\bigl(v\preceq_N w \ \text{ かつ }\ w\preceq_N v\bigr)
\qquad(v,w\in V)`),
      paragraph([
        "で定める（", ref("def_neighborhood_reachability_preorder"), "）。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_mutual_reflexive",
    kind: "claim",
    title: { text: "相互到達関係は反射的である" },
    labels: ["claim_neighborhood_mutual_reachability_reflexive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`v\in V`), " について ",
        math(String.raw`v\approx_N v`), " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_neighborhood_reachability_preorder_reflexive"), " により ",
        math(String.raw`v\preceq_N v`),
        " であり、これを二つの条件の両方に用いると ",
        ref("def_neighborhood_mutual_reachability"), " の条件が満たされる。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_mutual_symmetric",
    kind: "claim",
    title: { text: "相互到達関係は対称的である" },
    labels: ["claim_neighborhood_mutual_reachability_symmetric"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`v,w\in V`), " について、",
        math(String.raw`v\approx_N w`), " ならば ", math(String.raw`w\approx_N v`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`v\approx_N w`), " と仮定する。",
        ref("def_neighborhood_mutual_reachability"), " により ",
        math(String.raw`v\preceq_N w`), " かつ ", math(String.raw`w\preceq_N v`),
        " である。この二つの条件を入れ替えた組は ",
        math(String.raw`w\preceq_N v`), " かつ ", math(String.raw`v\preceq_N w`),
        " であり、これは同じ二つの条件なので成り立つ。再び ",
        ref("def_neighborhood_mutual_reachability"), " により ",
        math(String.raw`w\approx_N v`), " を得る。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_mutual_transitive",
    kind: "claim",
    title: { text: "相互到達関係は推移的である" },
    labels: ["claim_neighborhood_mutual_reachability_transitive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`v,u,w\in V`), " について、",
        math(String.raw`v\approx_N u`), " かつ ", math(String.raw`u\approx_N w`),
        " ならば ", math(String.raw`v\approx_N w`), " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`v\approx_N u`), " かつ ", math(String.raw`u\approx_N w`),
        " と仮定する。", ref("def_neighborhood_mutual_reachability"), " により ",
        math(String.raw`v\preceq_N u`), "、", math(String.raw`u\preceq_N v`), "、",
        math(String.raw`u\preceq_N w`), "、", math(String.raw`w\preceq_N u`),
        " の四つが成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
v\preceq_N u \ \text{ かつ }\ u\preceq_N w
&\Longrightarrow v\preceq_N w
  \qquad(\because\ \blkref{claim_neighborhood_reachability_preorder_transitive})\\
w\preceq_N u \ \text{ かつ }\ u\preceq_N v
&\Longrightarrow w\preceq_N v
  \qquad(\because\ \blkref{claim_neighborhood_reachability_preorder_transitive})
\end{aligned}`),
      paragraph([
        "であり、", ref("def_neighborhood_mutual_reachability"),
        " の二つの条件が満たされるので ", math(String.raw`v\approx_N w`),
        " を得る。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_definition_component",
    kind: "definition",
    title: { text: "相互到達成分割り当て" },
    labels: ["def_neighborhood_mutual_reachability_component"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
        math(String.raw`C_N\in\mathcal N(V)`), " を",
      ]),
      displayMath(String.raw`C_N:=N^{*}\sqcap\left(N^{*}\right)^{\mathsf T}`),
      paragraph([
        "で定める。", math(String.raw`\sqcap`), " は ",
        ref("def_neighborhood_assignment_pointwise_intersection"),
        " の点ごとの積、", math(String.raw`(\cdot)^{\mathsf T}`), " は ",
        ref("def_neighborhood_assignment_transpose"), " の転置である。",
        math(String.raw`C_N(v)`), " を ", math(String.raw`v`),
        " の相互到達成分と呼ぶ。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_component_membership",
    kind: "claim",
    title: { text: "相互到達成分への所属は相互到達関係と一致する" },
    labels: ["claim_neighborhood_mutual_reachability_component_membership"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`v,w\in V`), " について",
      ]),
      displayMath(String.raw`w\in C_N(v)\Longleftrightarrow v\approx_N w`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
w\in C_N(v)
&\Longleftrightarrow w\in\left(N^{*}\sqcap\left(N^{*}\right)^{\mathsf T}\right)(v)
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability_component})\\
&\Longleftrightarrow w\in N^{*}(v)\cap\left(N^{*}\right)^{\mathsf T}(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_intersection})\\
&\Longleftrightarrow \bigl(w\in N^{*}(v)\ \text{ かつ }\ w\in\left(N^{*}\right)^{\mathsf T}(v)\bigr)
  \qquad(\because\ \text{共通部分への所属})\\
&\Longleftrightarrow \bigl(w\in N^{*}(v)\ \text{ かつ }\ v\in N^{*}(w)\bigr)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership})\\
&\Longleftrightarrow \bigl(v\preceq_N w\ \text{ かつ }\ w\preceq_N v\bigr)
  \qquad(\because\ \blkref{def_neighborhood_reachability_preorder})\\
&\Longleftrightarrow v\approx_N w
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_component_self_transpose",
    kind: "claim",
    title: { text: "相互到達成分割り当ては自己転置である" },
    labels: ["claim_neighborhood_mutual_reachability_component_self_transpose"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " について ",
        math(String.raw`C_N^{\mathsf T}=C_N`), " が成り立つ。すなわち ",
        math(String.raw`C_N`), " は ",
        ref("def_self_transpose_neighborhood_assignment"), " の意味で自己転置である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
C_N^{\mathsf T}
&=\left(N^{*}\sqcap\left(N^{*}\right)^{\mathsf T}\right)^{\mathsf T}
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability_component})\\
&=\left(N^{*}\right)^{\mathsf T}\sqcap\left(\left(N^{*}\right)^{\mathsf T}\right)^{\mathsf T}
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_preserves_lattice_operations})\\
&=\left(N^{*}\right)^{\mathsf T}\sqcap N^{*}
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_involutive})\\
&=N^{*}\sqcap\left(N^{*}\right)^{\mathsf T}
  \qquad(\because\ \blkref{claim_neighborhood_assignment_pointwise_intersection_laws} \text{ の可換律})\\
&=C_N
  \qquad(\because\ \blkref{def_neighborhood_mutual_reachability_component})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_partition",
    kind: "claim",
    title: { text: "相互到達成分は舞台を分割する" },
    labels: ["claim_neighborhood_mutual_reachability_components_partition"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`v,u\in V`), " について、",
        math(String.raw`C_N(v)\cap C_N(u)\neq\emptyset`), " ならば ",
        math(String.raw`C_N(v)=C_N(u)`), " が成り立つ。さらに任意の ",
        math(String.raw`v\in V`), " は ", math(String.raw`C_N(v)`), " に属する。",
      ]),
    ],
    proof: [
      paragraph([
        "後半を先に示す。", ref("claim_neighborhood_mutual_reachability_reflexive"),
        " により ", math(String.raw`v\approx_N v`), " であり、",
        ref("claim_neighborhood_mutual_reachability_component_membership"),
        " により ", math(String.raw`v\in C_N(v)`), " である。",
      ]),
      paragraph([
        "前半を示す。", math(String.raw`r\in C_N(v)\cap C_N(u)`), " を取る。",
        ref("claim_neighborhood_mutual_reachability_component_membership"),
        " により ", math(String.raw`v\approx_N r`), " かつ ",
        math(String.raw`u\approx_N r`), " である。任意の ",
        math(String.raw`w\in C_N(v)`), " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
w&\in C_N(v)\\
&\Longrightarrow v\approx_N w
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_membership})\\
&\Longrightarrow r\approx_N w
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_symmetric} \text{ を } v\approx_N r \text{ に適用し、}
   \blkref{claim_neighborhood_mutual_reachability_transitive})\\
&\Longrightarrow u\approx_N w
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_transitive} \text{ を } u\approx_N r,\ r\approx_N w \text{ に適用})\\
&\Longrightarrow w\in C_N(u)
  \qquad(\because\ \blkref{claim_neighborhood_mutual_reachability_component_membership})
\end{aligned}`),
      paragraph([
        "であり ", math(String.raw`C_N(v)\subseteq C_N(u)`), " を得る。",
        math(String.raw`v`), " と ", math(String.raw`u`),
        " を入れ替えて同じ論証を繰り返すと ",
        math(String.raw`C_N(u)\subseteq C_N(v)`), " を得るので、",
        math(String.raw`C_N(v)=C_N(u)`), " である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_preorder_claim_finite_decidable",
    kind: "claim",
    title: { text: "到達関係と相互到達成分は有限手続きで決定できる" },
    labels: ["claim_neighborhood_reachability_preorder_finite_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " について、関係 ",
        math(String.raw`\preceq_N`), " と ", math(String.raw`\approx_N`),
        " の全ての組に対する成否、および全ての ", math(String.raw`v\in V`),
        " についての ", math(String.raw`C_N(v)`), " は、",
        math(String.raw`V`), " の元の有限個の所属判定だけで決定できる。所属判定の回数は ",
        math(String.raw`(|V|^2+1)\cdot|V|^3+3|V|^2`), " 回以下である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_reflexive_transitive_closure_finite_decidable"), " により、",
        math(String.raw`N^{*}`), " の全ての値は ",
        math(String.raw`(|V|^2+1)\cdot|V|^3`),
        " 回以下の所属判定で決まる。以下ではこの表が得られているとして、追加の回数を数える。",
      ]),
      paragraph([
        ref("def_neighborhood_reachability_preorder"), " により、組 ",
        math(String.raw`(v,w)\in V\times V`), " についての ",
        math(String.raw`v\preceq_N w`), " は ",
        math(String.raw`w\in N^{*}(v)`),
        " の一回の所属判定で決まる。組は ", math(String.raw`|V|^2`),
        " 個なので ", math(String.raw`|V|^2`), " 回で全ての組が決まる。",
      ]),
      paragraph([
        ref("def_neighborhood_mutual_reachability"), " により、組 ",
        math(String.raw`(v,w)`), " についての ", math(String.raw`v\approx_N w`),
        " は ", math(String.raw`v\preceq_N w`), " と ",
        math(String.raw`w\preceq_N v`),
        " の成否から追加の所属判定なしに決まる。",
      ]),
      paragraph([
        ref("def_neighborhood_mutual_reachability_component"), " と ",
        ref("def_neighborhood_assignment_pointwise_intersection"), "、",
        ref("claim_neighborhood_assignment_transpose_membership"), " により、",
        math(String.raw`w\in C_N(v)`), " は ",
        math(String.raw`w\in N^{*}(v)`), " と ",
        math(String.raw`v\in N^{*}(w)`),
        " の二回の所属判定で決まる。組は ", math(String.raw`|V|^2`),
        " 個なので ", math(String.raw`2|V|^2`), " 回で全ての ",
        math(String.raw`C_N(v)`), " が書き下せる。",
      ]),
      paragraph([
        "合計すると ",
        math(String.raw`(|V|^2+1)\cdot|V|^3+|V|^2+2|V|^2
=(|V|^2+1)\cdot|V|^3+3|V|^2`),
        " 回以下の所属判定で全てが決まる。",
      ]),
    ],
  },
]);
