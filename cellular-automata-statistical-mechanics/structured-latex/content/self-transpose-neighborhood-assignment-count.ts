/**
 * 章「自己転置な近傍割り当ての個数」。
 * 自己転置な近傍割り当てをセルの非空な一元・二元部分集合の選択として符号化し、個数を数える。
 * 有限集合、有限部分集合、自然数だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "self_transpose_neighborhood_assignment_count_heading",
    kind: "heading",
    level: 1,
    title: { text: "自己転置な近傍割り当ての個数" },
    labels: [],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_definition_self_transpose",
    kind: "definition",
    title: { text: "自己転置な近傍割り当て" },
    labels: ["def_self_transpose_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と近傍割り当て ",
        math(String.raw`N\in\mathcal N(V)`), " に対し、",
        math(String.raw`N^{\mathsf T}=N`), " であるとき ", math(String.raw`N`),
        " を自己転置という（", ref("def_neighborhood_assignment_transpose"), "）。",
      ]),
    ],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_claim_symmetric_membership",
    kind: "claim",
    title: { text: "自己転置性は近傍所属の対称性と同値である" },
    labels: ["claim_self_transpose_iff_symmetric_membership"],
    habitat: "finite",
    statement: [
      paragraph(["任意の ", math(String.raw`N\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`N^{\mathsf T}=N
\Longleftrightarrow
\bigl(\forall v,w\in V,\ w\in N(v)\Longleftrightarrow v\in N(w)\bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`N^{\mathsf T}=N`), " と仮定する。任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in N(v)
&\Longleftrightarrow w\in N^{\mathsf T}(v)
  \qquad(\because\ N^{\mathsf T}=N)\\
&\Longleftrightarrow v\in N(w)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership}).
\end{aligned}`),
      paragraph(["よって右辺が成り立つ。逆に右辺を仮定する。任意の ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in N^{\mathsf T}(v)
&\Longleftrightarrow v\in N(w)
  \qquad(\because\ \blkref{claim_neighborhood_assignment_transpose_membership})\\
&\Longleftrightarrow w\in N(v)
  \qquad(\because\ \text{仮定}).
\end{aligned}`),
      paragraph(["所属条件の同値と二回の外延性により ", math(String.raw`N^{\mathsf T}=N`), " を得る。"]),
    ],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_definition_unordered_cell_pairs",
    kind: "definition",
    title: { text: "セルの非空な一元・二元部分集合" },
    labels: ["def_unordered_cell_pairs"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`V`), " に対し、"]),
      displayMath(String.raw`\mathcal U(V):=\bigl\{\{v,w\}\subseteq V\mid v,w\in V\bigr\}`),
      paragraph(["と定める。各元は一元集合または二元集合であり、", math(String.raw`\mathcal U(V)`), " は有限集合である。"]),
    ],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_definition_pair_encoding",
    kind: "definition",
    title: { text: "自己転置な近傍割り当ての非順序対符号" },
    labels: ["def_self_transpose_pair_encoding"],
    habitat: "finite",
    statement: [
      paragraph(["自己転置な ", math(String.raw`N\in\mathcal N(V)`), " に対し、"]),
      displayMath(String.raw`\varepsilon_V(N):=\bigl\{\{v,w\}\in\mathcal U(V)\mid w\in N(v)\bigr\}`),
      paragraph([
        "と定める。", ref("claim_self_transpose_iff_symmetric_membership"), " により ",
        math(String.raw`w\in N(v)`), " と ", math(String.raw`v\in N(w)`),
        " は同値なので、この所属条件は ", math(String.raw`\{v,w\}`), " の表示順序に依存しない。",
      ]),
    ],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_definition_pair_reconstruction",
    kind: "definition",
    title: { text: "非順序対の集合からの近傍割り当ての復元" },
    labels: ["def_pair_set_neighborhood_reconstruction"],
    habitat: "finite",
    statement: [
      paragraph([math(String.raw`B\subseteq\mathcal U(V)`), " に対し、近傍割り当て ", math(String.raw`\rho_V(B)\in\mathcal N(V)`), " を"]),
      displayMath(String.raw`\rho_V(B)(v):=\{w\in V\mid\{v,w\}\in B\}\qquad(v\in V)`),
      paragraph(["で定める。"]),
    ],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_claim_encoding_bijection",
    kind: "claim",
    title: { text: "非順序対符号は全単射である" },
    labels: ["claim_self_transpose_pair_encoding_bijection"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`\varepsilon_V`), " は、自己転置な近傍割り当て全体から ",
        math(String.raw`\mathcal U(V)`), " の部分集合全体への全単射であり、逆写像は ",
        math(String.raw`\rho_V`), " である。",
      ]),
    ],
    proof: [
      paragraph(["まず任意の ", math(String.raw`B\subseteq\mathcal U(V)`), " と ", math(String.raw`v,w\in V`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in\rho_V(B)(v)
&\Longleftrightarrow \{v,w\}\in B
  \qquad(\because\ \blkref{def_pair_set_neighborhood_reconstruction})\\
&\Longleftrightarrow \{w,v\}\in B
  \qquad(\because\ \{v,w\}=\{w,v\})\\
&\Longleftrightarrow v\in\rho_V(B)(w)
  \qquad(\because\ \blkref{def_pair_set_neighborhood_reconstruction}).
\end{aligned}`),
      paragraph([ref("claim_self_transpose_iff_symmetric_membership"), " により ", math(String.raw`\rho_V(B)`), " は自己転置である。さらに"]),
      displayMath(String.raw`\begin{aligned}
\{v,w\}\in\varepsilon_V(\rho_V(B))
&\Longleftrightarrow w\in\rho_V(B)(v)
  \qquad(\because\ \blkref{def_self_transpose_pair_encoding})\\
&\Longleftrightarrow \{v,w\}\in B
  \qquad(\because\ \blkref{def_pair_set_neighborhood_reconstruction}).
\end{aligned}`),
      paragraph([math(String.raw`\{v,w\}`), " の任意性と集合の外延性により ", math(String.raw`\varepsilon_V(\rho_V(B))=B`), " である。逆に、自己転置な ", math(String.raw`N\in\mathcal N(V)`), " について"]),
      displayMath(String.raw`\begin{aligned}
w\in\rho_V(\varepsilon_V(N))(v)
&\Longleftrightarrow \{v,w\}\in\varepsilon_V(N)
  \qquad(\because\ \blkref{def_pair_set_neighborhood_reconstruction})\\
&\Longleftrightarrow w\in N(v)
  \qquad(\because\ \blkref{def_self_transpose_pair_encoding}).
\end{aligned}`),
      paragraph(["二回の外延性により ", math(String.raw`\rho_V(\varepsilon_V(N))=N`), " である。二つの合成が恒等写像なので主張が従う。"]),
    ],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_claim_unordered_pair_count",
    kind: "claim",
    title: { text: "非順序対の個数" },
    labels: ["claim_unordered_cell_pair_count"],
    habitat: "N",
    statement: [
      paragraph([math(String.raw`n:=|V|\in\mathbb N`), " とおくと"]),
      displayMath(String.raw`|\mathcal U(V)|=n+\binom n2=\frac{n(n+1)}2`),
      paragraph(["が成り立つ。右端の商は自然数である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathcal U(V)`), " は一元部分集合全体と二元部分集合全体の非交和である。",
        "一元部分集合は ", math(String.raw`v\mapsto\{v\}`), " により ", math(String.raw`V`),
        " と全単射なので ", math(String.raw`n`), " 個である。二元部分集合は有限集合から二元を選ぶ集合なので ",
        math(String.raw`\binom n2`), " 個である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
|\mathcal U(V)|
&=n+\binom n2
  \qquad(\because\ \text{非交和の個数})\\
&=n+\frac{n(n-1)}2
  \qquad(\because\ \text{二項係数の定義})\\
&=\frac{2n+n(n-1)}2
  \qquad(\because\ \text{通分})\\
&=\frac{n(n+1)}2
  \qquad(\because\ \text{分配律}).
\end{aligned}`),
      paragraph([math(String.raw`n(n+1)`), " は連続する二自然数の積なので偶数であり、右端の商は ", math(String.raw`\mathbb N`), " に属する。"]),
    ],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_claim_cardinality",
    kind: "claim",
    title: { text: "自己転置な近傍割り当ての個数" },
    labels: ["claim_self_transpose_neighborhood_assignment_count"],
    habitat: "N",
    statement: [
      paragraph([math(String.raw`n:=|V|\in\mathbb N`), " とおくと、自己転置な近傍割り当ての個数は"]),
      displayMath(String.raw`2^{n(n+1)/2}\in\mathbb N`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([ref("claim_self_transpose_pair_encoding_bijection"), " と ", ref("claim_unordered_cell_pair_count"), " により"]),
      displayMath(String.raw`\begin{aligned}
|\{N\in\mathcal N(V)\mid N^{\mathsf T}=N\}|
&=|\{B\mid B\subseteq\mathcal U(V)\}|
  \qquad(\because\ \blkref{claim_self_transpose_pair_encoding_bijection})\\
&=2^{|\mathcal U(V)|}
  \qquad(\because\ \text{有限集合の部分集合の個数})\\
&=2^{n(n+1)/2}
  \qquad(\because\ \blkref{claim_unordered_cell_pair_count}).
\end{aligned}`),
    ],
  },
  {
    id: "self_transpose_neighborhood_assignment_count_claim_finite_decision",
    kind: "claim",
    title: { text: "自己転置な近傍割り当ては有限決定できる" },
    labels: ["claim_self_transpose_neighborhood_assignments_finitely_decidable"],
    habitat: "N",
    statement: [
      paragraph(["自己転置な近傍割り当て全体とその個数は、有限舞台 ", math(String.raw`V`), " から有限決定できる。"]),
    ],
    proof: [
      paragraph([
        ref("claim_finite_neighborhood_assignment_monoid_cardinality_decidable"), " により ",
        math(String.raw`\mathcal N(V)`), " は有限列挙できる。各 ", math(String.raw`N`),
        " について ", ref("claim_neighborhood_assignment_transpose_finitely_decidable"),
        " で転置表を作り、有限個の値を比較すれば自己転置性を決定できる。全ての ",
        math(String.raw`N\in\mathcal N(V)`), " を走査して自己転置なものを集め、その有限集合の元を数えれば主張が従う。",
      ]),
    ],
  },
]);
