/**
 * 章「有限半順序の被覆関係と被覆近傍割り当てによる生成」。
 * 前章で、任意の有限半順序が近傍割り当ての相互到達成分の商としてちょうど現れることを示した。
 * そこで使った近傍割り当て N_R は半順序の全ての対を辺として持つ。ここでは逆に、
 * どこまで辺を減らしても同じ到達関係が得られるかを問い、被覆関係だけを辺とする
 * 近傍割り当てが同じ反射推移閉包を持つことを示す。
 * 有限集合、写像、自然数だけを使い、R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_covering_relation_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限半順序の被覆関係と被覆近傍割り当てによる生成" },
    labels: [],
  },

  {
    id: "neighborhood_covering_relation_definition_interval",
    kind: "definition",
    title: { text: "部分順序の区間" },
    labels: ["def_finite_poset_interval"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ", math(String.raw`V`), " 上の部分順序 ",
        math(String.raw`R\subseteq V\times V`), "（", ref("def_partial_order"), "）と ",
        math(String.raw`v,w\in V`), " に対し、", math(String.raw`V`), " の部分集合",
      ]),
      displayMath(String.raw`I_R(v,w):=\{\,u\in V\ \mid\ (v,u)\in R\ \land\ (u,w)\in R\,\}`),
      paragraph(["を ", math(String.raw`(v,w)`), " の区間と呼ぶ。"]),
    ],
  },

  {
    id: "neighborhood_covering_relation_claim_interval_finite",
    kind: "claim",
    title: { text: "有限半順序の区間は有限である" },
    labels: ["claim_finite_poset_interval_finite"],
    habitat: "finite",
    statement: [paragraph([
      ref("def_finite_poset_interval"), " の区間 ", math(String.raw`I_R(v,w)`),
      " は有限集合であり、その元数 ", math(String.raw`|I_R(v,w)|\in\mathbb{N}`), " が定まる。",
    ])],
    proof: [paragraph([
      math(String.raw`I_R(v,w)\subseteq V`), "（", math(String.raw`\because`), " ", ref("def_finite_poset_interval"),
      "）であり、有限集合の部分集合は有限である。",
    ])],
  },

  {
    id: "neighborhood_covering_relation_claim_interval_endpoints",
    kind: "claim",
    title: { text: "区間は両端を含む" },
    labels: ["claim_finite_poset_interval_endpoints"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " と ",
        math(String.raw`v,w\in V`), " が ", math(String.raw`(v,w)\in R`), " を満たすとき ",
        math(String.raw`v\in I_R(v,w)`), " かつ ", math(String.raw`w\in I_R(v,w)`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(v,v)&\in R
  \qquad(\because\ \blkref{def_partial_order} \text{ の反射性})\\
(v,v)\in R\ \land\ (v,w)\in R
&\Longrightarrow v\in I_R(v,w)
  \qquad(\because\ \blkref{def_finite_poset_interval})\\
(w,w)&\in R
  \qquad(\because\ \blkref{def_partial_order} \text{ の反射性})\\
(v,w)\in R\ \land\ (w,w)\in R
&\Longrightarrow w\in I_R(v,w)
  \qquad(\because\ \blkref{def_finite_poset_interval})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_covering_relation_definition_covering",
    kind: "definition",
    title: { text: "有限半順序の被覆関係" },
    labels: ["def_finite_poset_covering_relation"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`),
        " に対し、", math(String.raw`V\times V`), " の部分集合",
      ]),
      displayMath(String.raw`H_R:=\{\,(v,w)\in R\ \mid\ v\neq w\ \land\ I_R(v,w)=\{v,w\}\,\}`),
      paragraph([
        "を ", math(String.raw`R`), " の被覆関係と呼ぶ。", math(String.raw`I_R`), " は ",
        ref("def_finite_poset_interval"), " の区間である。",
      ]),
    ],
  },

  {
    id: "neighborhood_covering_relation_definition_assignment",
    kind: "definition",
    title: { text: "被覆近傍割り当て" },
    labels: ["def_covering_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " に対し、",
        math(String.raw`N^{\mathrm{cov}}_R\in\mathcal N(V)`), "（",
        ref("def_finite_neighborhood_assignment_space"), "）を",
      ]),
      displayMath(String.raw`N^{\mathrm{cov}}_R(v):=\{\,w\in V\ \mid\ (v,w)\in H_R\,\}\qquad(v\in V)`),
      paragraph([
        "で定める。", math(String.raw`H_R`), " は ",
        ref("def_finite_poset_covering_relation"), " の被覆関係である。",
      ]),
    ],
  },

  {
    id: "neighborhood_covering_relation_claim_included",
    kind: "claim",
    title: { text: "被覆近傍割り当ては半順序が定める近傍割り当てに含まれる" },
    labels: ["claim_covering_neighborhood_assignment_included"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " について ",
        math(String.raw`N^{\mathrm{cov}}_R\sqsubseteq N_R`), " が成り立つ。",
        math(String.raw`N_R`), " は ", ref("def_partial_order_neighborhood_assignment"),
        " の近傍割り当て、", math(String.raw`\sqsubseteq`), " は ",
        ref("def_neighborhood_assignment_pointwise_inclusion"), " の点ごとの包含である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`v,w\in V`), " が ",
        math(String.raw`w\in N^{\mathrm{cov}}_R(v)`), " を満たすとする。"]),
      displayMath(String.raw`\begin{aligned}
w\in N^{\mathrm{cov}}_R(v)
&\Longrightarrow (v,w)\in H_R
  \qquad(\because\ \blkref{def_covering_neighborhood_assignment})\\
&\Longrightarrow (v,w)\in R
  \qquad(\because\ \blkref{def_finite_poset_covering_relation})\\
&\Longrightarrow w\in N_R(v)
  \qquad(\because\ \blkref{def_partial_order_neighborhood_assignment})
\end{aligned}`),
      paragraph([
        "であり、各 ", math(String.raw`v\in V`), " について ",
        math(String.raw`N^{\mathrm{cov}}_R(v)\subseteq N_R(v)`), " が言えたので、",
        ref("def_neighborhood_assignment_pointwise_inclusion"), " により主張が従う。",
      ]),
    ],
  },

  {
    id: "neighborhood_covering_relation_claim_interval_shrinks",
    kind: "claim",
    title: { text: "中間の元を取ると区間の元数が真に減る" },
    labels: ["claim_finite_poset_interval_strictly_smaller"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " と ",
        math(String.raw`v,w,u\in V`), " が ", math(String.raw`(v,w)\in R`), "、",
        math(String.raw`u\in I_R(v,w)`), "、", math(String.raw`u\neq v`), "、",
        math(String.raw`u\neq w`), " を満たすとき",
      ]),
      displayMath(String.raw`|I_R(v,u)|<|I_R(v,w)|\qquad\text{かつ}\qquad|I_R(u,w)|<|I_R(v,w)|`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "仮定と ", ref("def_finite_poset_interval"), " により ",
        math(String.raw`(v,u)\in R`), " かつ ", math(String.raw`(u,w)\in R`), " である。",
        "まず ", math(String.raw`I_R(v,u)\subseteq I_R(v,w)`), " を示す。",
        math(String.raw`x\in I_R(v,u)`), " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
x\in I_R(v,u)
&\Longrightarrow (v,x)\in R\ \land\ (x,u)\in R
  \qquad(\because\ \blkref{def_finite_poset_interval})\\
(x,u)\in R\ \land\ (u,w)\in R
&\Longrightarrow (x,w)\in R
  \qquad(\because\ \blkref{def_partial_order} \text{ の推移性})\\
(v,x)\in R\ \land\ (x,w)\in R
&\Longrightarrow x\in I_R(v,w)
  \qquad(\because\ \blkref{def_finite_poset_interval})
\end{aligned}`),
      paragraph([
        "次に ", math(String.raw`w\in I_R(v,w)`), " かつ ",
        math(String.raw`w\notin I_R(v,u)`), " を示す。前者は ",
        ref("claim_finite_poset_interval_endpoints"), " による。後者を背理法で示す。",
        math(String.raw`w\in I_R(v,u)`), " と仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in I_R(v,u)
&\Longrightarrow (w,u)\in R
  \qquad(\because\ \blkref{def_finite_poset_interval})\\
(u,w)\in R\ \land\ (w,u)\in R
&\Longrightarrow u=w
  \qquad(\because\ \blkref{def_partial_order} \text{ の反対称性})
\end{aligned}`),
      paragraph([
        "これは仮定 ", math(String.raw`u\neq w`), " に反する。したがって ",
        math(String.raw`I_R(v,u)\subsetneq I_R(v,w)`), " であり、有限集合の真部分集合の元数は",
        "真に小さいので ", math(String.raw`|I_R(v,u)|<|I_R(v,w)|`), " である。",
      ]),
      paragraph([
        "同様に ", math(String.raw`I_R(u,w)\subseteq I_R(v,w)`), " を示す。",
        math(String.raw`x\in I_R(u,w)`), " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
x\in I_R(u,w)
&\Longrightarrow (u,x)\in R\ \land\ (x,w)\in R
  \qquad(\because\ \blkref{def_finite_poset_interval})\\
(v,u)\in R\ \land\ (u,x)\in R
&\Longrightarrow (v,x)\in R
  \qquad(\because\ \blkref{def_partial_order} \text{ の推移性})\\
(v,x)\in R\ \land\ (x,w)\in R
&\Longrightarrow x\in I_R(v,w)
  \qquad(\because\ \blkref{def_finite_poset_interval})
\end{aligned}`),
      paragraph([
        math(String.raw`v\in I_R(v,w)`), " は ",
        ref("claim_finite_poset_interval_endpoints"), " による。",
        math(String.raw`v\notin I_R(u,w)`), " を背理法で示す。",
        math(String.raw`v\in I_R(u,w)`), " と仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
v\in I_R(u,w)
&\Longrightarrow (u,v)\in R
  \qquad(\because\ \blkref{def_finite_poset_interval})\\
(v,u)\in R\ \land\ (u,v)\in R
&\Longrightarrow v=u
  \qquad(\because\ \blkref{def_partial_order} \text{ の反対称性})
\end{aligned}`),
      paragraph([
        "これは仮定 ", math(String.raw`u\neq v`), " に反する。したがって ",
        math(String.raw`I_R(u,w)\subsetneq I_R(v,w)`), " であり ",
        math(String.raw`|I_R(u,w)|<|I_R(v,w)|`), " である。",
      ]),
    ],
  },

  {
    id: "neighborhood_covering_relation_claim_generates",
    kind: "claim",
    title: { text: "半順序の各対は被覆近傍割り当ての反射推移閉包で到達できる" },
    labels: ["claim_covering_neighborhood_assignment_generates"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " と ",
        math(String.raw`v,w\in V`), " が ", math(String.raw`(v,w)\in R`), " を満たすとき",
      ]),
      displayMath(String.raw`w\in\bigl(N^{\mathrm{cov}}_R\bigr)^{*}(v)`),
      paragraph([
        "が成り立つ。", math(String.raw`(\cdot)^{*}`), " は ",
        ref("def_neighborhood_assignment_reflexive_transitive_closure"),
        " の反射推移閉包である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n:=|I_R(v,w)|\in\mathbb N`), " についての強い数学的帰納法で示す。",
        "すなわち、", math(String.raw`|I_R(v',w')|<n`), " を満たす全ての ",
        math(String.raw`(v',w')\in R`), " について主張が成り立つと仮定して、",
        math(String.raw`|I_R(v,w)|=n`), " の場合を示す。",
        "場合分けは ", math(String.raw`v=w`), " か、",
        math(String.raw`v\neq w`), " かつ ", math(String.raw`I_R(v,w)=\{v,w\}`), " か、",
        math(String.raw`v\neq w`), " かつ ", math(String.raw`I_R(v,w)\neq\{v,w\}`),
        " かの三つで、", ref("claim_finite_poset_interval_endpoints"),
        " により ", math(String.raw`\{v,w\}\subseteq I_R(v,w)`), " なので、",
        "この三つで尽きる。",
      ]),
      paragraph([math(String.raw`v=w`), " のとき。"]),
      displayMath(String.raw`\begin{aligned}
w&=v\\
&\in\bigl(N^{\mathrm{cov}}_R\bigr)^{*}(v)
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_reflexive})
\end{aligned}`),
      paragraph([
        math(String.raw`v\neq w`), " かつ ", math(String.raw`I_R(v,w)=\{v,w\}`), " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
(v,w)\in R\ \land\ v\neq w\ \land\ I_R(v,w)=\{v,w\}
&\Longrightarrow (v,w)\in H_R
  \qquad(\because\ \blkref{def_finite_poset_covering_relation})\\
&\Longrightarrow w\in N^{\mathrm{cov}}_R(v)
  \qquad(\because\ \blkref{def_covering_neighborhood_assignment})\\
&\Longrightarrow w\in\bigl(N^{\mathrm{cov}}_R\bigr)^{*}(v)
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_contains_original},\
  \blkref{def_neighborhood_assignment_pointwise_inclusion})
\end{aligned}`),
      paragraph([
        math(String.raw`v\neq w`), " かつ ", math(String.raw`I_R(v,w)\neq\{v,w\}`), " のとき。",
        ref("claim_finite_poset_interval_endpoints"), " により ",
        math(String.raw`\{v,w\}\subseteq I_R(v,w)`), " なので、",
        math(String.raw`u\in I_R(v,w)`), " で ", math(String.raw`u\neq v`), " かつ ",
        math(String.raw`u\neq w`), " を満たすものが取れる。",
        ref("def_finite_poset_interval"), " により ", math(String.raw`(v,u)\in R`),
        " かつ ", math(String.raw`(u,w)\in R`), " である。",
        ref("claim_finite_poset_interval_strictly_smaller"), " により ",
        math(String.raw`|I_R(v,u)|<n`), " かつ ", math(String.raw`|I_R(u,w)|<n`),
        " なので、帰納法の仮定を ", math(String.raw`(v,u)`), " と ",
        math(String.raw`(u,w)`), " に適用できる。",
      ]),
      displayMath(String.raw`\begin{aligned}
u&\in\bigl(N^{\mathrm{cov}}_R\bigr)^{*}(v)
  \qquad(\because\ \text{帰納法の仮定を } (v,u) \text{ に適用})\\
w&\in\bigl(N^{\mathrm{cov}}_R\bigr)^{*}(u)
  \qquad(\because\ \text{帰納法の仮定を } (u,w) \text{ に適用})\\
w&\in\bigl(N^{\mathrm{cov}}_R\bigr)^{*}(v)
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_transitive})
\end{aligned}`),
      paragraph(["であり、三つの場合すべてで主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_covering_relation_claim_closure_eq",
    kind: "claim",
    title: { text: "被覆近傍割り当ての反射推移閉包は半順序の近傍割り当てに等しい" },
    labels: ["claim_covering_neighborhood_assignment_closure_eq"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " について",
      ]),
      displayMath(String.raw`\bigl(N^{\mathrm{cov}}_R\bigr)^{*}=N_R`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\bigl(N^{\mathrm{cov}}_R\bigr)^{*}&\sqsubseteq N_R
  \qquad(\because\ \blkref{claim_reflexive_transitive_closure_minimal} \text{ を }
  \blkref{claim_partial_order_neighborhood_assignment_reflexive},\
  \blkref{claim_partial_order_neighborhood_assignment_transitive},\
  \blkref{claim_covering_neighborhood_assignment_included} \text{ に適用})\\
N_R&\sqsubseteq\bigl(N^{\mathrm{cov}}_R\bigr)^{*}
  \qquad(\because\ \blkref{claim_covering_neighborhood_assignment_generates},\
  \blkref{def_partial_order_neighborhood_assignment},\
  \blkref{def_neighborhood_assignment_pointwise_inclusion})\\
\bigl(N^{\mathrm{cov}}_R\bigr)^{*}&=N_R
  \qquad(\because\ \blkref{claim_neighborhood_assignment_pointwise_inclusion_partial_order}
  \text{ の反対称性})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_covering_relation_claim_reachability_eq",
    kind: "claim",
    title: { text: "被覆近傍割り当ての到達関係は部分順序そのものに一致する" },
    labels: ["claim_covering_neighborhood_assignment_reachability_eq"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`), " と ",
        math(String.raw`v,w\in V`), " について",
      ]),
      displayMath(String.raw`v\preceq_{N^{\mathrm{cov}}_R}w\Longleftrightarrow(v,w)\in R`),
      paragraph([
        "が成り立つ。", math(String.raw`\preceq`), " は ",
        ref("def_neighborhood_reachability_preorder"), " の到達関係である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
v\preceq_{N^{\mathrm{cov}}_R}w
&\Longleftrightarrow w\in\bigl(N^{\mathrm{cov}}_R\bigr)^{*}(v)
  \qquad(\because\ \blkref{def_neighborhood_reachability_preorder})\\
&\Longleftrightarrow w\in N_R(v)
  \qquad(\because\ \blkref{claim_covering_neighborhood_assignment_closure_eq})\\
&\Longleftrightarrow (v,w)\in R
  \qquad(\because\ \blkref{def_partial_order_neighborhood_assignment})
\end{aligned}`),
    ],
  },

  {
    id: "neighborhood_covering_relation_claim_finite_decidable",
    kind: "claim",
    title: { text: "被覆関係は有限手続きで決定できる" },
    labels: ["claim_finite_poset_covering_relation_finite_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の部分順序 ", math(String.raw`R`),
        " が与えられたとき、", math(String.raw`H_R`), " への所属は各組 ",
        math(String.raw`(v,w)\in V\times V`), " について ",
        math(String.raw`2|V|+1`), " 回以下の ", math(String.raw`R`),
        " への所属判定と ", math(String.raw`2|V|+1`), " 回以下の ",
        math(String.raw`V`), " の元の等号判定で決定でき、",
        math(String.raw`H_R`), " 全体は ", math(String.raw`|V|^2`), " 個の組の走査で構成できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_finite_poset_covering_relation"), " により ",
        math(String.raw`(v,w)\in H_R`), " の判定は、",
        math(String.raw`(v,w)\in R`), " の所属判定 1 回、",
        math(String.raw`v\neq w`), " の等号判定 1 回、そして ",
        math(String.raw`I_R(v,w)=\{v,w\}`), " の判定に分かれる。",
      ]),
      paragraph([
        ref("def_finite_poset_interval"), " により ", math(String.raw`I_R(v,w)`),
        " の元は各 ", math(String.raw`u\in V`), " について ",
        math(String.raw`(v,u)\in R`), " と ", math(String.raw`(u,w)\in R`),
        " の所属判定で決まり、", ref("claim_finite_poset_interval_endpoints"),
        " により ", math(String.raw`\{v,w\}\subseteq I_R(v,w)`), " が既に分かっているので、",
        math(String.raw`I_R(v,w)=\{v,w\}`), " は「",
        math(String.raw`u\in I_R(v,w)`), " なる各 ", math(String.raw`u`), " が ",
        math(String.raw`u=v`), " または ", math(String.raw`u=w`), " を満たす」ことと同値である。",
        "各 ", math(String.raw`u`), " について前者には ", math(String.raw`R`),
        " への所属判定が高々 2 回、後者には ", math(String.raw`V`),
        " の元の等号判定が高々 2 回要る。したがって ", math(String.raw`|V|`),
        " 個の ", math(String.raw`u`), " の走査を、最初の所属判定 1 回と等号判定 1 回に加えて行えば決定できる。",
      ]),
      paragraph([
        "組 ", math(String.raw`(v,w)`), " の個数は ",
        math(String.raw`|V|\cdot|V|=|V|^2`), " であり、走査の範囲は有限である。",
      ]),
    ],
  },
]);
