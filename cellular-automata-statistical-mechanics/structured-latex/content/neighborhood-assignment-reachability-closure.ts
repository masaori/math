/**
 * 章「近傍割り当ての反射推移閉包」。
 * 近傍割り当ての反復合成の有限近似が有限段で安定し、その安定値が
 * 「自己近傍を含み推移的で、もとの割り当てを含む」割り当てのうち最小のものに
 * なることを示す。有限集合、写像、自然数だけを使い、R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_reachability_closure_definition_power",
    kind: "definition",
    title: { text: "近傍割り当ての合成冪" },
    labels: ["def_neighborhood_assignment_composition_power"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), "（", ref("def_finite_neighborhood_assignment_space"),
        "）に対し、", math(String.raw`k\in\mathbb N`), " についての合成冪 ",
        math(String.raw`N^{\langle k\rangle}\in\mathcal N(V)`), " を",
      ]),
      displayMath(String.raw`N^{\langle 0\rangle}:=I_V,\qquad
N^{\langle k+1\rangle}:=N^{\langle k\rangle}\star N`),
      paragraph([
        "で定める。", math(String.raw`I_V`), " は ",
        ref("def_identity_neighborhood_assignment"), " の自己近傍割り当て、",
        math(String.raw`\star`), " は ", ref("def_composed_neighborhood"),
        " の合成近傍である。", math(String.raw`\mathcal N(V)`),
        " は合成について閉じているので、各 ", math(String.raw`N^{\langle k\rangle}`),
        " は再び ", math(String.raw`V`), " 上の近傍割り当てである。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_definition_approximation",
    kind: "definition",
    title: { text: "到達近傍の有限近似" },
    labels: ["def_neighborhood_assignment_reachability_approximation"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`k\in\mathbb N`), " に対し、",
        math(String.raw`N^{\leq k}\in\mathcal N(V)`), " を",
      ]),
      displayMath(String.raw`N^{\leq k}(v):=\bigcup_{j=0}^{k}N^{\langle j\rangle}(v)
\qquad(v\in V)`),
      paragraph([
        "で定める。右辺は ", ref("def_neighborhood_assignment_pointwise_union"),
        " の点ごとの和を ", math(String.raw`j=0,\dots,k`),
        " について取ったものであり、有限個の有限集合の合併なので再び有限集合である。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_monotone",
    kind: "claim",
    title: { text: "有限近似の列は包含について増大する" },
    labels: ["claim_reachability_approximation_monotone"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`k\in\mathbb N`), " について",
      ]),
      displayMath(String.raw`N^{\leq k}\sqsubseteq N^{\leq k+1}`),
      paragraph([
        "が成り立つ（", ref("def_neighborhood_assignment_pointwise_inclusion"), "）。",
      ]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v\in V`), " を取る。"]),
      displayMath(String.raw`\begin{aligned}
N^{\leq k}(v)
&=\bigcup_{j=0}^{k}N^{\langle j\rangle}(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_reachability_approximation})\\
&\subseteq\bigcup_{j=0}^{k}N^{\langle j\rangle}(v)\cup N^{\langle k+1\rangle}(v)
  \qquad(\because\ \text{合併は各成分を含む})\\
&=\bigcup_{j=0}^{k+1}N^{\langle j\rangle}(v)
  \qquad(\because\ \text{添字 } j=k+1 \text{ の項を分けただけ})\\
&=N^{\leq k+1}(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_reachability_approximation})
\end{aligned}`),
      paragraph([
        "であり、", math(String.raw`v`), " は任意なので ",
        ref("def_neighborhood_assignment_pointwise_inclusion"), " の包含が従う。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_recursion",
    kind: "claim",
    title: { text: "有限近似は一段の合成で書き直せる" },
    labels: ["claim_reachability_approximation_recursion"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`k\in\mathbb N`), " について",
      ]),
      displayMath(String.raw`N^{\leq k+1}=I_V\sqcup\left(N^{\leq k}\star N\right)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v\in V`), " を取る。"]),
      displayMath(String.raw`\begin{aligned}
N^{\leq k+1}(v)
&=\bigcup_{j=0}^{k+1}N^{\langle j\rangle}(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_reachability_approximation})\\
&=N^{\langle 0\rangle}(v)\cup\bigcup_{j=0}^{k}N^{\langle j+1\rangle}(v)
  \qquad(\because\ \text{添字 } j=0 \text{ の項を分け、残りを } j+1 \text{ で番号付け直した})\\
&=I_V(v)\cup\bigcup_{j=0}^{k}\left(N^{\langle j\rangle}\star N\right)(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_composition_power})\\
&=I_V(v)\cup\bigcup_{j=0}^{k}\ \bigcup_{u\in N^{\langle j\rangle}(v)}N(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&=I_V(v)\cup\bigcup_{u\in\bigcup_{j=0}^{k}N^{\langle j\rangle}(v)}N(u)
  \qquad(\because\ \text{合併を添字とする合併は添字ごとの合併の合併})\\
&=I_V(v)\cup\bigcup_{u\in N^{\leq k}(v)}N(u)
  \qquad(\because\ \blkref{def_neighborhood_assignment_reachability_approximation})\\
&=I_V(v)\cup\left(N^{\leq k}\star N\right)(v)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&=\left(I_V\sqcup\left(N^{\leq k}\star N\right)\right)(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_pointwise_union})
\end{aligned}`),
      paragraph([
        "であり、", math(String.raw`v`), " は任意なので写像の外延性より主張が従う。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_stable_forever",
    kind: "claim",
    title: { text: "一段で安定すれば以後ずっと安定する" },
    labels: ["claim_reachability_approximation_stable_forever"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`k\in\mathbb N`), " が ",
        math(String.raw`N^{\leq k+1}=N^{\leq k}`), " を満たすならば、任意の ",
        math(String.raw`m\in\mathbb N`), " について",
      ]),
      displayMath(String.raw`N^{\leq k+m}=N^{\leq k}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`), " についての数学的帰納法で示す。",
        math(String.raw`m=0`), " のときは主張が ",
        math(String.raw`N^{\leq k}=N^{\leq k}`), " なので成り立つ。",
        math(String.raw`m`), " で成り立つとして ", math(String.raw`m+1`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
N^{\leq k+m+1}
&=I_V\sqcup\left(N^{\leq k+m}\star N\right)
  \qquad(\because\ \blkref{claim_reachability_approximation_recursion})\\
&=I_V\sqcup\left(N^{\leq k}\star N\right)
  \qquad(\because\ \text{帰納法の仮定 } N^{\leq k+m}=N^{\leq k})\\
&=N^{\leq k+1}
  \qquad(\because\ \blkref{claim_reachability_approximation_recursion})\\
&=N^{\leq k}
  \qquad(\because\ \text{仮定})
\end{aligned}`),
      paragraph(["であり、帰納法が完成する。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_stabilizes",
    kind: "claim",
    title: { text: "有限近似は基礎集合の元数の二乗までに安定する" },
    labels: ["claim_reachability_approximation_stabilizes"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
      ]),
      displayMath(String.raw`\exists k\in\mathbb N,\ k\leq|V|^2\ \land\ N^{\leq k+1}=N^{\leq k}`),
      paragraph([
        "が成り立つ。ここで ", math(String.raw`|V|\in\mathbb N`), " は ",
        math(String.raw`V`), " の元の個数である。",
      ]),
    ],
    proof: [
      paragraph([
        "各 ", math(String.raw`k\in\mathbb N`), " について ",
        math(String.raw`c(k):=\sum_{v\in V}|N^{\leq k}(v)|\in\mathbb N`),
        " と置く（有限集合の元の個数の有限和なので ", math(String.raw`\mathbb N`),
        " に属する）。まず上界を見る。",
      ]),
      displayMath(String.raw`\begin{aligned}
c(k)&=\sum_{v\in V}|N^{\leq k}(v)|
  \qquad(\because\ c \text{ の定義})\\
&\leq\sum_{v\in V}|V|
  \qquad(\because\ N^{\leq k}(v)\subseteq V \text{ と部分集合の元数の単調性})\\
&=|V|\cdot|V|
  \qquad(\because\ \text{同じ値の } |V| \text{ 項の和})\\
&=|V|^2
\end{aligned}`),
      paragraph([
        "次に増加の様子を見る。", math(String.raw`k\in\mathbb N`), " について ",
        ref("claim_reachability_approximation_monotone"), " より各 ",
        math(String.raw`v\in V`), " で ",
        math(String.raw`N^{\leq k}(v)\subseteq N^{\leq k+1}(v)`),
        " なので、元数の単調性から ", math(String.raw`c(k)\leq c(k+1)`), " である。さらに ",
        math(String.raw`N^{\leq k+1}\neq N^{\leq k}`), " ならば、ある ",
        math(String.raw`v\in V`), " で ",
        math(String.raw`N^{\leq k}(v)\subsetneq N^{\leq k+1}(v)`),
        " となり、真の部分集合の元数は真に小さいので ",
        math(String.raw`c(k)+1\leq c(k+1)`), " が従う。",
      ]),
      paragraph([
        "結論を背理法で示す。すべての ", math(String.raw`k\leq|V|^2`), " について ",
        math(String.raw`N^{\leq k+1}\neq N^{\leq k}`), " と仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
c(|V|^2+1)
&\geq c(0)+(|V|^2+1)
  \qquad(\because\ k=0,\dots,|V|^2 \text{ の各段で } c \text{ が } 1 \text{ 以上増える})\\
&\geq|V|^2+1
  \qquad(\because\ c(0)\in\mathbb N \text{ より } c(0)\geq0)
\end{aligned}`),
      paragraph([
        "となるが、これは上で示した ",
        math(String.raw`c(|V|^2+1)\leq|V|^2`), " に矛盾する。したがって、ある ",
        math(String.raw`k\leq|V|^2`), " で ",
        math(String.raw`N^{\leq k+1}=N^{\leq k}`), " が成り立つ。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_definition_closure",
    kind: "definition",
    title: { text: "近傍割り当ての反射推移閉包" },
    labels: ["def_neighborhood_assignment_reflexive_transitive_closure"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
      ]),
      displayMath(String.raw`N^{*}:=N^{\leq|V|^2}`),
      paragraph([
        "と定め、", math(String.raw`N`), " の反射推移閉包と呼ぶ。",
        ref("claim_reachability_approximation_stabilizes"), " により、ある ",
        math(String.raw`k\leq|V|^2`), " で ",
        math(String.raw`N^{\leq k+1}=N^{\leq k}`), " となるので、",
        ref("claim_reachability_approximation_stable_forever"), " と合わせて ",
        math(String.raw`N^{*}=N^{\leq k}`), " であり、この定義は右辺の有限個の合成と合併だけで定まる。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_power_included",
    kind: "claim",
    title: { text: "すべての合成冪は反射推移閉包に含まれる" },
    labels: ["claim_composition_power_included_in_closure"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`m\in\mathbb N`), " について",
      ]),
      displayMath(String.raw`N^{\langle m\rangle}\sqsubseteq N^{*}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "まず任意の ", math(String.raw`k\in\mathbb N`), " と ",
        math(String.raw`j\leq k`), " について、",
        ref("def_neighborhood_assignment_reachability_approximation"),
        " の右辺が ", math(String.raw`j`), " 番目の項を含むので ",
        math(String.raw`N^{\langle j\rangle}\sqsubseteq N^{\leq k}`), " である。",
      ]),
      paragraph([
        ref("claim_reachability_approximation_stabilizes"), " により ",
        math(String.raw`k_0\leq|V|^2`), " を ",
        math(String.raw`N^{\leq k_0+1}=N^{\leq k_0}`), " となるように取る。",
        math(String.raw`M:=\max\{m,|V|^2\}`), " と置くと ",
        math(String.raw`m\leq M`), " かつ ", math(String.raw`k_0\leq M`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
N^{\langle m\rangle}
&\sqsubseteq N^{\leq M}
  \qquad(\because\ m\leq M \text{ と上の包含})\\
&=N^{\leq k_0}
  \qquad(\because\ \blkref{claim_reachability_approximation_stable_forever} \text{ を } m:=M-k_0 \text{ に適用})\\
&=N^{\leq|V|^2}
  \qquad(\because\ \blkref{claim_reachability_approximation_stable_forever} \text{ を } m:=|V|^2-k_0 \text{ に適用})\\
&=N^{*}
  \qquad(\because\ \blkref{def_neighborhood_assignment_reflexive_transitive_closure})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_power_additive",
    kind: "claim",
    title: { text: "合成冪の合成は指数の和の合成冪である" },
    labels: ["claim_composition_power_additive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`i,j\in\mathbb N`), " について",
      ]),
      displayMath(String.raw`N^{\langle i\rangle}\star N^{\langle j\rangle}
=N^{\langle i+j\rangle}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`j`), " についての数学的帰納法で示す。",
        math(String.raw`j=0`), " のとき、",
      ]),
      displayMath(String.raw`\begin{aligned}
N^{\langle i\rangle}\star N^{\langle 0\rangle}
&=N^{\langle i\rangle}\star I_V
  \qquad(\because\ \blkref{def_neighborhood_assignment_composition_power})\\
&=N^{\langle i\rangle}
  \qquad(\because\ \blkref{claim_identity_neighborhood_assignment_is_composition_identity})\\
&=N^{\langle i+0\rangle}
  \qquad(\because\ i+0=i)
\end{aligned}`),
      paragraph([
        "である。", math(String.raw`j`), " で成り立つとして ", math(String.raw`j+1`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
N^{\langle i\rangle}\star N^{\langle j+1\rangle}
&=N^{\langle i\rangle}\star\left(N^{\langle j\rangle}\star N\right)
  \qquad(\because\ \blkref{def_neighborhood_assignment_composition_power})\\
&=\left(N^{\langle i\rangle}\star N^{\langle j\rangle}\right)\star N
  \qquad(\because\ \blkref{claim_composed_neighborhood_associative})\\
&=N^{\langle i+j\rangle}\star N
  \qquad(\because\ \text{帰納法の仮定})\\
&=N^{\langle i+j+1\rangle}
  \qquad(\because\ \blkref{def_neighborhood_assignment_composition_power})
\end{aligned}`),
      paragraph(["であり、帰納法が完成する。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_reflexive",
    kind: "claim",
    title: { text: "反射推移閉包は自己近傍を含む" },
    labels: ["claim_reflexive_transitive_closure_reflexive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、", math(String.raw`N\in\mathcal N(V)`),
        " と ", math(String.raw`v\in V`), " について ",
        math(String.raw`v\in N^{*}(v)`), " が成り立つ。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
v&\in\{v\}\\
&=I_V(v)
  \qquad(\because\ \blkref{def_identity_neighborhood_assignment})\\
&=N^{\langle 0\rangle}(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_composition_power})\\
&\subseteq N^{*}(v)
  \qquad(\because\ \blkref{claim_composition_power_included_in_closure} \text{ を } m:=0 \text{ に適用})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_contains",
    kind: "claim",
    title: { text: "反射推移閉包はもとの近傍割り当てを含む" },
    labels: ["claim_reflexive_transitive_closure_contains_original"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " について ",
        math(String.raw`N\sqsubseteq N^{*}`), " が成り立つ。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
N&=I_V\star N
  \qquad(\because\ \blkref{claim_identity_neighborhood_assignment_is_composition_identity})\\
&=N^{\langle 0\rangle}\star N
  \qquad(\because\ \blkref{def_neighborhood_assignment_composition_power})\\
&=N^{\langle 1\rangle}
  \qquad(\because\ \blkref{def_neighborhood_assignment_composition_power})\\
&\sqsubseteq N^{*}
  \qquad(\because\ \blkref{claim_composition_power_included_in_closure} \text{ を } m:=1 \text{ に適用})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_transitive",
    kind: "claim",
    title: { text: "反射推移閉包は推移的である" },
    labels: ["claim_reflexive_transitive_closure_transitive"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " について、",
        math(String.raw`N^{*}`), " は ",
        ref("def_transitive_neighborhood_assignment"), " の意味で推移的である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`v,u,w\in V`), " が ", math(String.raw`u\in N^{*}(v)`),
        " と ", math(String.raw`w\in N^{*}(u)`), " を満たすとする。",
        ref("def_neighborhood_assignment_reachability_approximation"), " と ",
        ref("def_neighborhood_assignment_reflexive_transitive_closure"),
        " により、ある ", math(String.raw`i\leq|V|^2`), " で ",
        math(String.raw`u\in N^{\langle i\rangle}(v)`), " となり、ある ",
        math(String.raw`j\leq|V|^2`), " で ",
        math(String.raw`w\in N^{\langle j\rangle}(u)`), " となる。",
      ]),
      displayMath(String.raw`\begin{aligned}
w&\in\bigcup_{r\in N^{\langle i\rangle}(v)}N^{\langle j\rangle}(r)
  \qquad(\because\ u\in N^{\langle i\rangle}(v) \text{ と } w\in N^{\langle j\rangle}(u))\\
&=\left(N^{\langle i\rangle}\star N^{\langle j\rangle}\right)(v)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&=N^{\langle i+j\rangle}(v)
  \qquad(\because\ \blkref{claim_composition_power_additive})\\
&\subseteq N^{*}(v)
  \qquad(\because\ \blkref{claim_composition_power_included_in_closure} \text{ を } m:=i+j \text{ に適用})
\end{aligned}`),
      paragraph([
        "であり、", ref("def_transitive_neighborhood_assignment"),
        " の条件が満たされる。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_idempotent",
    kind: "claim",
    title: { text: "反射推移閉包は合成について冪等である" },
    labels: ["claim_reflexive_transitive_closure_idempotent"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " について",
      ]),
      displayMath(String.raw`N^{*}\star N^{*}=N^{*}`),
      paragraph([
        "が成り立つ（", ref("def_composition_idempotent_neighborhood_assignment"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_reflexive_transitive_closure_reflexive"), " により ",
        math(String.raw`N^{*}`), " は任意の ", math(String.raw`v\in V`), " で ",
        math(String.raw`v\in N^{*}(v)`), " を満たし、",
        ref("claim_reflexive_transitive_closure_transitive"),
        " により推移的である。したがって ",
        ref("claim_reflexive_neighborhood_assignment_idempotent_iff_transitive"),
        " の仮定が満たされ、その同値の推移的な側から ",
        math(String.raw`N^{*}\star N^{*}=N^{*}`), " が従う。",
      ]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_minimal",
    kind: "claim",
    title: { text: "反射推移閉包は条件を満たす最小の近傍割り当てである" },
    labels: ["claim_reflexive_transitive_closure_minimal"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N,M\in\mathcal N(V)`), " について、",
        math(String.raw`M`), " が次の三条件を満たすとする。任意の ",
        math(String.raw`v\in V`), " について ", math(String.raw`v\in M(v)`),
        " であること。", math(String.raw`M`), " が ",
        ref("def_transitive_neighborhood_assignment"),
        " の意味で推移的であること。", math(String.raw`N\sqsubseteq M`),
        " であること。このとき",
      ]),
      displayMath(String.raw`N^{*}\sqsubseteq M`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "まず ", ref("claim_reflexive_neighborhood_assignment_idempotent_iff_transitive"),
        " により ", math(String.raw`M\star M=M`), " である。次に ",
        math(String.raw`m\in\mathbb N`), " についての数学的帰納法で ",
        math(String.raw`N^{\langle m\rangle}\sqsubseteq M`), " を示す。",
        math(String.raw`m=0`), " のとき、任意の ", math(String.raw`v\in V`), " で",
      ]),
      displayMath(String.raw`N^{\langle 0\rangle}(v)
=I_V(v)
=\{v\}
\subseteq M(v)`),
      paragraph([
        "である（順に ", ref("def_neighborhood_assignment_composition_power"), "、",
        ref("def_identity_neighborhood_assignment"), "、仮定 ",
        math(String.raw`v\in M(v)`), " による）。",
        math(String.raw`m`), " で成り立つとして ", math(String.raw`m+1`), " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
N^{\langle m+1\rangle}
&=N^{\langle m\rangle}\star N
  \qquad(\because\ \blkref{def_neighborhood_assignment_composition_power})\\
&\sqsubseteq M\star M
  \qquad(\because\ \blkref{claim_composed_neighborhood_monotone} \text{ を帰納法の仮定と } N\sqsubseteq M \text{ に適用})\\
&=M
  \qquad(\because\ \blkref{claim_reflexive_neighborhood_assignment_idempotent_iff_transitive})
\end{aligned}`),
      paragraph([
        "であり、帰納法が完成する。最後に任意の ", math(String.raw`v\in V`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
N^{*}(v)
&=\bigcup_{j=0}^{|V|^2}N^{\langle j\rangle}(v)
  \qquad(\because\ \blkref{def_neighborhood_assignment_reflexive_transitive_closure},\ \blkref{def_neighborhood_assignment_reachability_approximation})\\
&\subseteq M(v)
  \qquad(\because\ \text{各 } j \text{ で } N^{\langle j\rangle}(v)\subseteq M(v) \text{ であり、合併は上界で抑えられる})
\end{aligned}`),
      paragraph(["であり、主張が従う。"]),
    ],
  },

  {
    id: "neighborhood_assignment_reachability_closure_claim_finite_decidable",
    kind: "claim",
    title: { text: "反射推移閉包は有限手続きで決定できる" },
    labels: ["claim_reflexive_transitive_closure_finite_decidable"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N\in\mathcal N(V)`), " について、",
        math(String.raw`N^{*}`), " の各値 ", math(String.raw`N^{*}(v)`),
        " は、", math(String.raw`V`),
        " の元の有限個の所属判定だけで決定できる。所属判定の回数は ",
        math(String.raw`(|V|^2+1)\cdot|V|^3`), " 回以下である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j\in\mathbb N`), " について ",
        math(String.raw`N^{\langle j\rangle}`), " から ",
        math(String.raw`N^{\langle j+1\rangle}`),
        " を作る手続きを数える。",
        ref("def_composed_neighborhood"), " により、各 ",
        math(String.raw`v\in V`), " と各 ", math(String.raw`w\in V`), " について ",
        math(String.raw`w\in N^{\langle j+1\rangle}(v)`), " は ",
        math(String.raw`\exists u\in V,\ u\in N^{\langle j\rangle}(v)\land w\in N(u)`),
        " と同値であり、",
        math(String.raw`u`), " の候補は ", math(String.raw`|V|`),
        " 個なので、一つの組 ", math(String.raw`(v,w)`), " について ",
        math(String.raw`|V|`), " 回の所属判定で決まる。組 ",
        math(String.raw`(v,w)`), " は ", math(String.raw`|V|^2`), " 個なので、一段の合成は ",
        math(String.raw`|V|^3`), " 回以下の所属判定で終わる。",
      ]),
      paragraph([
        ref("def_neighborhood_assignment_reflexive_transitive_closure"), " により ",
        math(String.raw`N^{*}=N^{\leq|V|^2}`),
        " であり、", ref("def_neighborhood_assignment_reachability_approximation"),
        " によりこれは ", math(String.raw`j=0,\dots,|V|^2`), " の ",
        math(String.raw`|V|^2+1`), " 個の合成冪の合併である。",
        math(String.raw`N^{\langle 0\rangle}=I_V`), " は ",
        ref("def_identity_neighborhood_assignment"),
        " により所属判定なしに書き下せ、残りの各段は上の ", math(String.raw`|V|^3`),
        " 回以下で作れる。合併は既に得た有限集合の元を集めるだけで新たな所属判定を要しない。",
        "したがって全体で ", math(String.raw`(|V|^2+1)\cdot|V|^3`),
        " 回以下の所属判定で ", math(String.raw`N^{*}`), " が決まる。",
      ]),
    ],
  },
]);
