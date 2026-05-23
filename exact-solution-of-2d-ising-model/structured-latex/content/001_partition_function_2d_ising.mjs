import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "partition_function_2d_ising_001_definition_lattice_size",
    kind: "definition",
    sourcePath: "parts/001_2次元ising模型の分配関数/000_definition_格子サイズ.typ",
    sourceOrdinal: 1,
    title: { text: "格子サイズ" },
    labels: [],
    statement: [
      paragraph([math(String.raw`M, N \in \mathbb{N}`), " を格子のサイズとする。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "partition_function_2d_ising_002_definition_partition_function",
    kind: "definition",
    sourcePath: "parts/001_2次元ising模型の分配関数/001_definition_2次元ising模型の分配関数.typ",
    sourceOrdinal: 2,
    title: { text: "2次元ising模型の分配関数" },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`Z : \mathbb{R}_{>0} \times \mathbb{R}_{>0} \to \mathbb{R}_{>0}`),
        " を以下のように定める。",
      ]),
      paragraph([
        math(String.raw`\mathfrak{S} := \mathrm{Map}(\{1,\dots,M\}\times\{1,\dots,N\},\{-1,1\})`),
        " として、",
      ]),
      displayMath(
        String.raw`Z(J, J') := \sum_{s \in \mathfrak{S}} \exp\!\left(\sum_{\substack{i\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J\,s(i,j)s(i+1,j) + J'\,s(i,j)s(i,j+1)\bigr)\right)`,
      ),
    ],
    notes: [
      paragraph(["", math(String.raw`s`), " は格子の状態（スピンの配置）を表している。"]),
      paragraph([math(String.raw`\mathfrak{S}`), " は全ての状態の集合である。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "partition_function_2d_ising_003_definition_transfer_matrix",
    kind: "definition",
    sourcePath: "parts/001_2次元ising模型の分配関数/002_definition_転送行列.typ",
    sourceOrdinal: 3,
    title: { text: "転送行列" },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^N, \mathbb{C})`),
        " を以下のように定める。",
      ]),
      paragraph([
        math(String.raw`\mu, \mu' : \{1,\dots,N\} \to \{-1,1\}`),
        " を添え字として用いて、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_1)_{\mu,\mu'} &:= \delta_{\mu=\mu'} \exp\!\left(\sum_{j\in\{1,\dots,N\}} J\,\mu(j)\,\mu(j+1)\right) \\
(V_2)_{\mu,\mu'} &:= \exp\!\left(\sum_{j\in\{1,\dots,N\}} J'\,\mu(j)\,\mu'(j)\right)
\end{aligned}`,
      ),
    ],
    notes: [
      paragraph([math(String.raw`V_1`), " は格子のある行内の横の相互作用を表している。"]),
      paragraph([math(String.raw`V_2`), " はそれを縦に積み上げた時の隣り合う行同士の相互作用を表している。"]),
      paragraph([math(String.raw`V_1`), " は対角行列になっている。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
    kind: "claim",
    sourcePath: "parts/001_2次元ising模型の分配関数/003_claim_転送行列による分配関数の表式.typ",
    sourceOrdinal: 4,
    title: { text: "転送行列による分配関数の表式" },
    labels: [],
    statement: [
      displayMath(String.raw`Z(J, J') = \mathrm{tr}\!\left((V_1 V_2)^M\right)`),
    ],
    proof: [
      paragraph([
        math(String.raw`\mu, \mu' : \{1,\dots,N\} \to \{-1,1\}`),
        " に対して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_1 V_2)_{\mu,\mu'}
&= \sum_{\nu:\{1,\dots,N\}\to\{-1,1\}} (V_1)_{\mu,\nu}(V_2)_{\nu,\mu'} \\
&= \sum_{\nu} \delta_{\mu=\nu}
   \exp\!\left(\sum_j J\,\mu(j)\mu(j+1)\right)
   \exp\!\left(\sum_j J'\,\nu(j)\mu'(j)\right) \\
&= \exp\!\left(\sum_j J\,\mu(j)\mu(j+1)\right)
   \exp\!\left(\sum_j J'\,\mu(j)\mu'(j)\right) \\
&= \exp\!\left(\sum_j \bigl(J\,\mu(j)\mu(j+1) + J'\,\mu(j)\mu'(j)\bigr)\right)
\end{aligned}`,
      ),
      paragraph([todo("TODO: トレースの展開によって分配関数の式と一致することの証明")]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文のproofは (V_1 V_2) の (μ,μ') 成分の計算のみで、trace展開の部分は省略されている。"],
    },
  },
]);
