import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "linear_space_general_001_theorem_tensor_product_basis",
    kind: "theorem",
    sourcePath: "parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ",
    sourceOrdinal: 1,
    title: null,
    labels: [],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`V`),
        ": ",
        math(String.raw`m`),
        "次元 ",
        math(String.raw`K`),
        "-線型空間 について、",
        math(String.raw`E = \{e_1,\dots,e_m\}`),
        ": ",
        math(String.raw`V`),
        " の基底とするとき、",
      ]),
      displayMath(String.raw`\forall (i_1,\dots,i_m) \in \{1,\dots,m\}^m`),
      displayMath(
        String.raw`e_{i_1} \otimes \cdots \otimes e_{i_m} \text{ は } V^{\otimes m} \text{ の基底である}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "linear_space_general_002_claim_scalar_identity_commutes",
    kind: "claim",
    sourcePath: "parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ",
    sourceOrdinal: 2,
    title: { tex: String.raw`c \cdot I \text{ は全行列と可換}` },
    labels: ["scalar_identity_commutes"],
    statement: [
      paragraph([
        "体 ",
        math(String.raw`K`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in K`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n, K)`),
        " について、",
      ]),
      displayMath(String.raw`[c \cdot I,\, A] = 0`),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
[c \cdot I,\, A]
&= (c \cdot I)A - A(c \cdot I) \\
&= cA - cA \\
&= 0
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    kind: "claim",
    sourcePath: "parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ",
    sourceOrdinal: 3,
    title: { text: "行列ノルムの劣乗法性" },
    labels: ["matrix_norm_submultiplicativity"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n, K)`),
        " について、",
      ]),
      displayMath(String.raw`\|AB\| \leq \|A\| \cdot \|B\|`),
    ],
    proof: [todo("TODO")],
    conversion: { status: "converted" },
  },
  {
    id: "linear_space_general_003b_claim_matrix_multiplication_continuity",
    kind: "claim",
    sourcePath: "parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ",
    sourceOrdinal: 3,
    title: { text: "行列乗算の連続性" },
    labels: ["matrix_multiplication_continuity"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A_N, A, B \in \mathrm{Mat}(n, K)`),
        "、",
        math(String.raw`\|A_N - A\| \to 0`),
        " のとき、",
      ]),
      displayMath(String.raw`\|A_N B - AB\| \to 0`),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\|A_N B - AB\|
&= \|(A_N - A)B\| \\
&\leq \|A_N - A\| \cdot \|B\| \\
&\to 0
\end{aligned}`,
      ),
      paragraph(["（", ref("matrix_norm_submultiplicativity"), " を使用）"]),
    ],
    conversion: { status: "converted" },
  },
]);
