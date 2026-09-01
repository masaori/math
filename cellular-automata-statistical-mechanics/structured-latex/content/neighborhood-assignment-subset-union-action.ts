/**
 * 章「近傍割り当てが部分集合に定める合併作用」。
 * 近傍割り当てを部分集合上の写像として読み直し、合成・単位元・冪等性が
 * 忠実に保存されることを示す。有限集合と有限部分集合だけを使い、R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "neighborhood_assignment_subset_union_action_definition_subset_space",
    kind: "definition",
    title: { text: "有限基礎集合の部分集合全体" },
    labels: ["def_finite_carrier_subset_space"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`V`), " に対し、その部分集合全体を"]),
      displayMath(String.raw`\operatorname{Sub}(V):=\{S\mid S\subseteq V\}`),
      paragraph([
        "と書く。", math(String.raw`\operatorname{Sub}(V)`), " は有限集合であり、その元数は ",
        math(String.raw`2^{|V|}\in\mathbb N`), " である。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_subset_union_action_definition_union_map",
    kind: "definition",
    title: { text: "近傍割り当てが定める部分集合の合併写像" },
    labels: ["def_neighborhood_assignment_subset_union_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、写像 ",
        math(String.raw`U_N:\operatorname{Sub}(V)\to\operatorname{Sub}(V)`), " を",
      ]),
      displayMath(String.raw`U_N(S):=\bigcup_{v\in S}N(v)\qquad(S\in\operatorname{Sub}(V))`),
      paragraph([
        "で定める。", math(String.raw`S`), " と各 ", math(String.raw`N(v)`),
        " は有限なので、この合併は近傍割り当ての有限な所属表から決定できる。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_subset_union_action_claim_composition",
    kind: "claim",
    title: { text: "合成近傍は合併写像の合成として作用する" },
    labels: ["claim_neighborhood_assignment_subset_union_map_composition"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N,M\in\mathcal N(V)`), " に対し、",
      ]),
      displayMath(String.raw`U_{N\star M}=U_M\circ U_N`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "任意の ", math(String.raw`S\in\operatorname{Sub}(V)`), " と ",
        math(String.raw`w\in V`), " を取る。", ref("def_neighborhood_assignment_subset_union_map"),
        " と ", ref("def_composed_neighborhood"), " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in U_{N\star M}(S)
&\Longleftrightarrow \exists v\in S,\ w\in(N\star M)(v)
  \qquad(\because\ \text{合併写像の定義})\\
&\Longleftrightarrow \exists v\in S,\ \exists u\in N(v),\ w\in M(u)
  \qquad(\because\ \text{合成近傍の定義})\\
&\Longleftrightarrow \exists u\in V,\ (\exists v\in S,\ u\in N(v))\land w\in M(u)
  \qquad(\because\ \text{有限存在量化の並べ替え})\\
&\Longleftrightarrow \exists u\in U_N(S),\ w\in M(u)
  \qquad(\because\ \text{合併写像の定義})\\
&\Longleftrightarrow w\in U_M(U_N(S))
  \qquad(\because\ \text{合併写像の定義})\\
&\Longleftrightarrow w\in (U_M\circ U_N)(S)
  \qquad(\because\ \text{写像の合成の定義}).
\end{aligned}`),
      paragraph([
        math(String.raw`w`), " の任意性から部分集合の外延性により ",
        math(String.raw`U_{N\star M}(S)=(U_M\circ U_N)(S)`), " である。",
        math(String.raw`S`), " の任意性から写像の外延性により結論を得る。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_subset_union_action_claim_identity",
    kind: "claim",
    title: { text: "自己近傍割り当ては部分集合上の恒等写像として作用する" },
    labels: ["claim_identity_neighborhood_subset_union_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " の自己近傍割り当てを ",
        math(String.raw`I_V(v):=\{v\}`), " とすると、",
      ]),
      displayMath(String.raw`U_{I_V}=\operatorname{id}_{\operatorname{Sub}(V)}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "任意の ", math(String.raw`S\in\operatorname{Sub}(V)`), " と ",
        math(String.raw`w\in V`), " を取る。", ref("def_neighborhood_assignment_subset_union_map"),
        " と ", ref("def_identity_neighborhood_assignment"), " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in U_{I_V}(S)
&\Longleftrightarrow \exists v\in S,\ w\in\{v\}
  \qquad(\because\ \text{合併写像の定義})\\
&\Longleftrightarrow \exists v\in S,\ w=v
  \qquad(\because\ \text{一元集合への所属})\\
&\Longleftrightarrow w\in S
  \qquad(\because\ \text{等号による置換}).
\end{aligned}`),
      paragraph([
        math(String.raw`w`), " と ", math(String.raw`S`),
        " の任意性、および部分集合と写像の外延性から結論を得る。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_subset_union_action_claim_singleton_recovery",
    kind: "claim",
    title: { text: "一元部分集合から近傍割り当てを復元できる" },
    labels: ["claim_neighborhood_assignment_recovered_from_singletons"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), "、点 ", math(String.raw`v\in V`), " に対し、",
      ]),
      displayMath(String.raw`U_N(\{v\})=N(v)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "任意の ", math(String.raw`w\in V`), " を取る。",
        ref("def_neighborhood_assignment_subset_union_map"), " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in U_N(\{v\})
&\Longleftrightarrow \exists u\in\{v\},\ w\in N(u)
  \qquad(\because\ \text{合併写像の定義})\\
&\Longleftrightarrow w\in N(v)
  \qquad(\because\ \text{一元集合への所属}).
\end{aligned}`),
      paragraph([math(String.raw`w`), " の任意性と部分集合の外延性から結論を得る。"]),
    ],
  },
  {
    id: "neighborhood_assignment_subset_union_action_claim_injective",
    kind: "claim",
    title: { text: "合併写像は近傍割り当てを区別する" },
    labels: ["claim_neighborhood_assignment_subset_union_map_injective"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        math(String.raw`N,M\in\mathcal N(V)`), " に対し、",
      ]),
      displayMath(String.raw`U_N=U_M\quad\Longrightarrow\quad N=M`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`U_N=U_M`), " と仮定し、任意の ", math(String.raw`v\in V`),
        " を取る。", ref("claim_neighborhood_assignment_recovered_from_singletons"), " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
N(v)
&=U_N(\{v\})
  \qquad(\because\ \text{一元部分集合からの復元})\\
&=U_M(\{v\})
  \qquad(\because\ U_N=U_M)\\
&=M(v)
  \qquad(\because\ \text{一元部分集合からの復元}).
\end{aligned}`),
      paragraph([math(String.raw`v`), " の任意性と写像の外延性から ", math(String.raw`N=M`), " を得る。"]),
    ],
  },
  {
    id: "neighborhood_assignment_subset_union_action_claim_idempotence",
    kind: "claim",
    title: { text: "合成冪等性は合併写像の冪等性と同値である" },
    labels: ["claim_neighborhood_assignment_idempotent_iff_subset_union_map_idempotent"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
      ]),
      displayMath(String.raw`N\star N=N\quad\Longleftrightarrow\quad U_N\circ U_N=U_N`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`N\star N=N`), " と仮定する。", ref("claim_neighborhood_assignment_subset_union_map_composition"), " より、"]),
      displayMath(String.raw`\begin{aligned}
U_N\circ U_N
&=U_{N\star N}
  \qquad(\because\ \text{合成近傍と合併写像の合成})\\
&=U_N
  \qquad(\because\ N\star N=N).
\end{aligned}`),
      paragraph([
        "逆に ", math(String.raw`U_N\circ U_N=U_N`), " と仮定する。",
        ref("claim_neighborhood_assignment_subset_union_map_composition"), " より、",
      ]),
      displayMath(String.raw`\begin{aligned}
U_{N\star N}
&=U_N\circ U_N
  \qquad(\because\ \text{合成近傍と合併写像の合成})\\
&=U_N
  \qquad(\because\ U_N\circ U_N=U_N).
\end{aligned}`),
      paragraph([
        ref("claim_neighborhood_assignment_subset_union_map_injective"),
        " を ", math(String.raw`N\star N`), " と ", math(String.raw`N`),
        " に適用して ", math(String.raw`N\star N=N`), " を得る。",
      ]),
    ],
  },
  {
    id: "neighborhood_assignment_subset_union_action_claim_finite_decidable",
    kind: "claim",
    title: { text: "合併写像とその冪等性は有限決定できる" },
    labels: ["claim_neighborhood_assignment_subset_union_map_finite_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と近傍割り当ての有限な所属表 ",
        math(String.raw`N\in\mathcal N(V)`), " から、写像 ",
        math(String.raw`U_N:\operatorname{Sub}(V)\to\operatorname{Sub}(V)`),
        " の全表と命題 ", math(String.raw`U_N\circ U_N=U_N`),
        " の真偽を有限回の所属判定で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_finite_carrier_subset_space"), " より入力集合は ",
        math(String.raw`2^{|V|}\in\mathbb N`), " 個である。各入力 ",
        math(String.raw`S\in\operatorname{Sub}(V)`), " に対する ",
        math(String.raw`U_N(S)`), " は、", ref("def_neighborhood_assignment_subset_union_map"),
        " に従い有限個の ", math(String.raw`N(v)`), " の有限合併として決まる。したがって全表を列挙できる。",
      ]),
      paragraph([
        "得られた有限表について、全ての ", math(String.raw`S\in\operatorname{Sub}(V)`),
        " で ", math(String.raw`U_N(U_N(S))=U_N(S)`),
        " を有限個の元の所属判定へ分解して検査すれば、冪等性の真偽が決まる。",
      ]),
    ],
  },
]);
