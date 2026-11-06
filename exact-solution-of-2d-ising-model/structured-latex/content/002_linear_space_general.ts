import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_linear_space_general",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 3 },
    title: { text: "線型空間の一般論" },
    labels: [],
  },
  {
    id: "linear_space_general_definition_kronecker_delta",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカーのデルタ" },
    labels: ["def_kronecker_delta"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`i, j \in \{1,\dots,n\}`),
        " について、",
        math(String.raw`\delta_{ij} \in \mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`\delta_{ij} := \begin{cases} 1_{\mathbb{C}} & (i = j) \\ 0_{\mathbb{C}} & (i \neq j) \end{cases}`),
      paragraph([
        "で定める。",
        math(String.raw`1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(1)`),
        "、",
        math(String.raw`0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0)`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。記号 δ_{ij}は本文全体で使われていたが、定めるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、足した。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_identity_matrix",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "単位行列" },
    labels: ["def_identity_matrix"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とする。単位行列 ",
        math(String.raw`I_{\mathrm{Mat}(n,\mathbb{C})} \in \mathrm{Mat}(n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）を、",
        ref("def_kronecker_delta"),
        " の ",
        math(String.raw`\delta_{ij}`),
        " を使って成分ごとに",
      ]),
      displayMath(String.raw`\left(I_{\mathrm{Mat}(n,\mathbb{C})}\right)_{ij} := \delta_{ij}
\qquad (i, j \in \{1,\dots,n\})`),
      paragraph(["で定める。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。単位行列は本文全体で使われていたが、定めるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、足した。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_matrix_scalar_multiple",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "行列のスカラー倍" },
    labels: ["def_matrix_scalar_multiple"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。",
        math(String.raw`A`),
        " のスカラー倍 ",
        math(String.raw`aA \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        math(String.raw`a \cdot A`),
        " とも書く）を、成分ごとに",
      ]),
      displayMath(String.raw`(aA)_{ij} := a\,A_{ij}
\qquad (i \in \{1,\dots,m\},\ j \in \{1,\dots,n\})`),
      paragraph([
        "で定める。右辺は ",
        ref("definition_of_cc"),
        " の複素数の積である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。行列のスカラー倍は本文全体で使われていたが、定めるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、足した。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_matrix_sum",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "行列の和" },
    labels: ["def_matrix_sum"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。和 ",
        math(String.raw`A + B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`(A + B)_{ij} := A_{ij} + B_{ij}
\qquad (i \in \{1,\dots,m\},\ j \in \{1,\dots,n\})`),
      paragraph([
        "で定める。右辺は ",
        ref("definition_of_cc"),
        " の複素数の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。行列の和は本文全体で使われていたが、定めるブロックが無かった。" +
          "トレースの基本性質（trace_basic_properties）の検算で、線型性の行の根拠として欠けが見つかり、足した。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_finite_sum_of_matrices",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "行列の有限和" },
    labels: ["def_finite_sum_of_matrices"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）について、有限和 ",
        math(String.raw`\sum_{j=1}^{r} X_j \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " を ",
        math(String.raw`r`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\sum_{j=1}^{1} X_j := X_1,
\qquad
\sum_{j=1}^{r+1} X_j := \Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}`),
      paragraph([
        "と定める（左から順に足す）。和は ",
        ref("def_matrix_sum"),
        " の行列の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。行列の有限和は本文全体（指数級数の部分和、基底による展開など）で使われていたが、定めるブロックが無かった。" +
          "複素数の有限和（def_finite_sum_of_complex_numbers）と同じ形で定めた。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_finite_sum_of_matrices_from_index_zero",
    kind: "definition",
    title: { text: "添字が 0 から始まる行列の有限和" },
    labels: ["def_finite_sum_of_matrices_from_index_zero"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`K \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`X_0,\dots,X_K \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）について、有限和 ",
        math(String.raw`\sum_{k=0}^{K} X_k \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " を",
      ]),
      displayMath(String.raw`\sum_{k=0}^{K} X_k := \sum_{j=1}^{K+1} X_{j-1}`),
      paragraph([
        "と定める。右辺は ",
        ref("def_finite_sum_of_matrices"),
        " の有限和（",
        math(String.raw`r \to K+1`),
        "、",
        math(String.raw`j`),
        " 番目の項を ",
        math(String.raw`X_{j-1}`),
        " とする）である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。eigenvalues_of_check_Vprime の Step 3・Step 3' の部分和 E_K = Σ_{k=0}^{K}(1/k!)X̌^k は添字が 0 から始まり、" +
          "def_finite_sum_of_matrices（添字 1..r）が覆わなかったので、その和へ添字をずらして定めた。def_finite_sum_of_complex_numbers_from_index_zero と同じ形である。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_matrices_entrywise",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "行列の有限和の成分は成分の有限和" },
    labels: ["finite_sum_of_matrices_entrywise"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。行列の有限和は ",
        ref("def_finite_sum_of_matrices"),
        "、右辺の複素数の有限和は ",
        ref("def_finite_sum_of_complex_numbers"),
        " による。このとき、",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\Bigl(\sum_{j=1}^{r} X_j\Bigr)_{ik} = \sum_{j=1}^{r} (X_j)_{ik}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を固定し、",
        math(String.raw`r`),
        " についての帰納法で示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{j=1}^{1} X_j\Bigr)_{ik}
&= (X_1)_{ik}
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \sum_{j=1}^{1} (X_j)_{ik}
&&\bigl(\because\ \blkref{def_finite_sum_of_complex_numbers}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r`),
        " で成り立つと仮定すると、",
        math(String.raw`X_1,\dots,X_{r+1} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{j=1}^{r+1} X_j\Bigr)_{ik}
&= \Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)_{ik}
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \Bigl(\sum_{j=1}^{r} X_j\Bigr)_{ik} + (X_{r+1})_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= \Bigl(\sum_{j=1}^{r} (X_j)_{ik}\Bigr) + (X_{r+1})_{ik}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \sum_{j=1}^{r+1} (X_j)_{ik}
&&\bigl(\because\ \blkref{def_finite_sum_of_complex_numbers}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。対角行列の指数関数（exp_of_diagonal_matrix）と線型写像表示の値（end_agrees_with_matrix_vector_product）の証明が、" +
          "行列の有限和の成分を「行列の和とスカラー倍は成分ごと」と名前だけで根拠にしていたので、引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_plus_zero_matrix",
    kind: "claim",
    title: { text: "零行列を右から足しても行列は変わらない" },
    labels: ["matrix_plus_zero_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`X + O = X`),
      paragraph([
        "が成り立つ。和は ",
        ref("def_matrix_sum"),
        "、",
        math(String.raw`O \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を固定し、",
        math(String.raw`a, b \in \mathbb{R}`),
        " を ",
        math(String.raw`X_{ik} = (a,b)`),
        "（",
        ref("definition_of_cc"),
        " の台集合 ",
        math(String.raw`\mathbf{C} = \mathbf{R}^2`),
        " の元として）となるように取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(X + O)_{ik}
&= X_{ik} + O_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= X_{ik} + 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)\\
&= (a,b) + 0_{\mathbb{C}}
&&\bigl(\because\ a, b\ \text{の取り方}\bigr)\\
&= (a,b) + (0,0)
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= (a+0,\ b+0)
&&\bigl(\because\ \blkref{definition_of_cc}\ \text{の和}\bigr)\\
&= (a,b)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a + 0 = a,\ b + 0 = b\bigr)\\
&= X_{ik}
&&\bigl(\because\ a, b\ \text{の取り方}\bigr)
\end{aligned}`),
      paragraph([
        "であり、すべての成分が等しいので ",
        math(String.raw`X + O = X`),
        " である（行列の等号は成分ごと）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。commutator_of_H_and_check_Z_Y Step 1 が「零行列の和は零行列」と名前だけで根拠にしていた段を、" +
          "有限和を O にする段と O を足して消す段に分け、後者を引けるよう足した（前者は 4 か所で添字の集合の上の和のため名前の根拠のまま）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_zero_matrix_plus_matrix",
    kind: "claim",
    title: { text: "零行列を左から足しても行列は変わらない" },
    labels: ["zero_matrix_plus_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`O + X = X`),
      paragraph([
        "が成り立つ。和は ",
        ref("def_matrix_sum"),
        "、",
        math(String.raw`O \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を固定し、",
        math(String.raw`a, b \in \mathbb{R}`),
        " を ",
        math(String.raw`X_{ik} = (a,b)`),
        "（",
        ref("definition_of_cc"),
        " の台集合 ",
        math(String.raw`\mathbf{C} = \mathbf{R}^2`),
        " の元として）となるように取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(O + X)_{ik}
&= O_{ik} + X_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= 0_{\mathbb{C}} + X_{ik}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)\\
&= 0_{\mathbb{C}} + (a,b)
&&\bigl(\because\ a, b\ \text{の取り方}\bigr)\\
&= (0,0) + (a,b)
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= (0+a,\ 0+b)
&&\bigl(\because\ \blkref{definition_of_cc}\ \text{の和}\bigr)\\
&= (a,b)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0 + a = a,\ 0 + b = b\bigr)\\
&= X_{ik}
&&\bigl(\because\ a, b\ \text{の取り方}\bigr)
\end{aligned}`),
      paragraph([
        "であり、すべての成分が等しいので ",
        math(String.raw`O + X = X`),
        " である（行列の等号は成分ごと）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。commutator_of_H_and_check_Z_Y Step 1 の j = 1・j = M_col の鎖が、" +
          "零行列の有限和を左に持つ和を「零行列の和は零行列」と名前だけで根拠にしていたので、引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_minus_zero_matrix",
    kind: "claim",
    title: { text: "零行列を引いても行列は変わらない" },
    labels: ["matrix_minus_zero_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`X - O = X`),
      paragraph([
        "が成り立つ。差は ",
        ref("def_matrix_difference"),
        "、",
        math(String.raw`O \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を固定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
(X - O)_{ik}
&= X_{ik} - O_{ik}
&&\bigl(\because\ \blkref{def_matrix_difference}\bigr)\\
&= X_{ik} - 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)\\
&= X_{ik} + (-0_{\mathbb{C}})
&&\bigl(\because\ \blkref{def_complex_difference}\bigr)\\
&= X_{ik} + (-1_{\mathbb{C}}) \cdot 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= X_{ik} + (-1,0) \cdot (0,0)
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= X_{ik} + \bigl((-1)\cdot 0 - 0 \cdot 0,\ (-1)\cdot 0 + 0 \cdot 0\bigr)
&&\bigl(\because\ \blkref{definition_of_cc}\ \text{の積}\bigr)\\
&= X_{ik} + (0,0)
&&\bigl(\because\ \mathbb{R}\ \text{の四則}\bigr)\\
&= X_{ik} + 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= X_{ik} + O_{ik}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)\\
&= (X + O)_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)
\end{aligned}`),
      paragraph([
        "であり、すべての成分が等しいので ",
        math(String.raw`X - O = X + O`),
        " である（行列の等号は成分ごと）。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
X - O
&= X + O
&&\bigl(\because\ \text{上の成分ごとの等式}\bigr)\\
&= X
&&\bigl(\because\ \blkref{matrix_plus_zero_matrix}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。commutator_of_H_and_check_Z_Y Step 1 が「零行列を引いても変わらない」と名前だけで根拠にしていたので、引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_zero_matrices",
    kind: "claim",
    title: { text: "零行列の有限和は零行列" },
    labels: ["finite_sum_of_zero_matrices"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        " について、",
        math(String.raw`O \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("def_zero_matrix"),
        "）を ",
        math(String.raw`r`),
        " 個足した有限和（",
        ref("def_finite_sum_of_matrices"),
        " で ",
        math(String.raw`X_1 = \dots = X_r = O`),
        " としたもの）について",
      ]),
      displayMath(String.raw`\sum_{j=1}^{r} O = O`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`r`), " についての帰納法で示す。", math(String.raw`r = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} O
&= O
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)
\end{aligned}`),
      paragraph(["である。", math(String.raw`r`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{r+1} O
&= \Bigl(\sum_{j=1}^{r} O\Bigr) + O
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= O + O
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= O
&&\bigl(\because\ \blkref{matrix_plus_zero_matrix}\ (X = O)\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。commutator_of_H_and_check_Z_Y Step 1 が「零行列の和は零行列」と名前だけで根拠にしていた段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_multiple_of_zero_matrix",
    kind: "claim",
    title: { text: "零行列のスカラー倍は零行列" },
    labels: ["scalar_multiple_of_zero_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a \in \mathbb{C}`),
        " について",
      ]),
      displayMath(String.raw`aO = O`),
      paragraph([
        "が成り立つ。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、",
        math(String.raw`O \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を固定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(aO)_{ik}
&= a\,O_{ik}
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\bigr)\\
&= a\,0_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z = a)\bigr)\\
&= O_{ik}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)
\end{aligned}`),
      paragraph([
        "であり、すべての成分が等しいので ",
        math(String.raw`aO = O`),
        " である（行列の等号は成分ごと）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。theorem_exp_zero の証明が「零行列のスカラー倍は零行列である」と名前だけで根拠にしていた段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_zero_scalar_multiple_is_zero_matrix",
    kind: "claim",
    title: { text: "行列の 0 倍は零行列" },
    labels: ["zero_scalar_multiple_is_zero_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`0_{\mathbb{C}}\,A = O`),
      paragraph([
        "が成り立つ。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、",
        math(String.raw`O \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を固定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(0_{\mathbb{C}}\,A)_{ik}
&= 0_{\mathbb{C}}\,A_{ik}
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\bigr)\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_zero_times_is_zero}\ (z \to A_{ik})\bigr)\\
&= O_{ik}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)
\end{aligned}`),
      paragraph([
        "であり、すべての成分が等しいので ",
        math(String.raw`0_{\mathbb{C}}\,A = O`),
        " である（行列の等号は成分ごと）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_number_operators_commute の Step 1 の δ_{M+1-ν, M+1-μ} I = O が「δ = 0 を代入する」と「0_ℂ I = O」の 2 段を 1 行で済ませていたので、後者を引けるよう足した。scalar_multiple_of_zero_matrix（aO = O）とは向きが逆である。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_sum_is_commutative",
    kind: "claim",
    title: { text: "行列の和の可換則" },
    labels: ["matrix_sum_is_commutative"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`A + B = B + A`),
      paragraph([
        "が成り立つ。和は ",
        ref("def_matrix_sum"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を固定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(A + B)_{ik}
&= A_{ik} + B_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= B_{ik} + A_{ik}
&&\bigl(\because\ \mathbb{C}\ \text{の加法の交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= (B + A)_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "であり、すべての成分が等しいので ",
        math(String.raw`A + B = B + A`),
        " である（行列の等号は成分ごと）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_number_operators_commute の Step 1 の第 3 式が、反交換子が引数の順序に依らないことを行列の和の交換で示す段を、主張を置かずに使っていたので足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_mat_mult_associative",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "行列の積の結合律" },
    labels: ["mat_mult_associative"],
    statement: [
      paragraph([
        math(String.raw`m, n, p, q \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        "、",
        math(String.raw`C \in \mathrm{Mat}(p,q,\mathbb{C})`),
        " とする。積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`(AB)C = A(BC)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,q,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,q\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((AB)C\bigr)_{ik}
&= \sum_{l=1}^{p} (AB)_{il}\,C_{lk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{l=1}^{p} \Bigl(\sum_{j=1}^{n} A_{ij}\,B_{jl}\Bigr) C_{lk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\ \text{を}\ (AB)_{il}\ \text{へ適用}\bigr)\\
&= \sum_{l=1}^{p} \sum_{j=1}^{n} (A_{ij}\,B_{jl})\,C_{lk}
&&\bigl(\because\ \mathbb{C}\ \text{の分配律を有限和の項の数だけ繰り返す }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{l=1}^{p} \sum_{j=1}^{n} A_{ij}\,(B_{jl}\,C_{lk})
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{j=1}^{n} \sum_{l=1}^{p} A_{ij}\,(B_{jl}\,C_{lk})
&&\bigl(\because\ \text{有限個の項の和の順序の入れ替え（}\mathbb{C}\ \text{の加法の結合律・交換律 }\blkref{complex_numbers_form_a_field}\text{）}\bigr)\\
&= \sum_{j=1}^{n} A_{ij} \Bigl(\sum_{l=1}^{p} B_{jl}\,C_{lk}\Bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の分配律を有限和の項の数だけ繰り返す }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{j=1}^{n} A_{ij}\,(BC)_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\ \text{を}\ (BC)_{jk}\ \text{へ適用}\bigr)\\
&= \bigl(A(BC)\bigr)_{ik}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。行列の積の結合律は本文全体で根拠として使われていたが、述べるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_identity_matrix_is_left_unit_of_mat_mult",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "単位行列を左から掛けても変わらない" },
    labels: ["identity_matrix_is_left_unit_of_mat_mult"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。単位行列は ",
        ref("def_identity_matrix"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`I_{\mathrm{Mat}(m,\mathbb{C})}\,A = A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(I_{\mathrm{Mat}(m,\mathbb{C})}\,A\bigr)_{ik}
&= \sum_{j=1}^{m} \bigl(I_{\mathrm{Mat}(m,\mathbb{C})}\bigr)_{ij}\,A_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{m} \delta_{ij}\,A_{jk}
&&\bigl(\because\ \text{単位行列の定義 }\blkref{def_identity_matrix}\bigr)\\
&= \delta_{ii}\,A_{ik} + \sum_{\substack{1 \leq j \leq m \\ j \neq i}} \delta_{ij}\,A_{jk}
&&\bigl(\because\ j = i\ \text{の項を分ける（}\mathbb{C}\ \text{の加法の結合律・交換律 }\blkref{complex_numbers_form_a_field}\text{）}\bigr)\\
&= 1_{\mathbb{C}}\,A_{ik} + \sum_{\substack{1 \leq j \leq m \\ j \neq i}} 0_{\mathbb{C}}\,A_{jk}
&&\bigl(\because\ \delta\ \text{の値 }\blkref{def_kronecker_delta}\bigr)\\
&= A_{ik} + \sum_{\substack{1 \leq j \leq m \\ j \neq i}} 0_{\mathbb{C}}\,A_{jk}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= A_{ik} + \sum_{\substack{1 \leq j \leq m \\ j \neq i}} 0_{\mathbb{C}}
&&\bigl(\because\ 0_{\mathbb{C}} z = 0_{\mathbb{C}}\ \blkref{complex_zero_times_is_zero}\ \text{を各項へ適用}\bigr)\\
&= A_{ik}
&&\bigl(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元で、これを項の数だけ繰り返す }\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。単位行列を左から掛けても行列が変わらないことは本文全体で根拠として使われていたが、述べるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_identity_matrix_is_right_unit_of_mat_mult",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "単位行列を右から掛けても変わらない" },
    labels: ["identity_matrix_is_right_unit_of_mat_mult"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。単位行列は ",
        ref("def_identity_matrix"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`A\,I_{\mathrm{Mat}(n,\mathbb{C})} = A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\,I_{\mathrm{Mat}(n,\mathbb{C})}\bigr)_{ik}
&= \sum_{j=1}^{n} A_{ij}\,\bigl(I_{\mathrm{Mat}(n,\mathbb{C})}\bigr)_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} A_{ij}\,\delta_{jk}
&&\bigl(\because\ \text{単位行列の定義 }\blkref{def_identity_matrix}\bigr)\\
&= A_{ik}\,\delta_{kk} + \sum_{\substack{1 \leq j \leq n \\ j \neq k}} A_{ij}\,\delta_{jk}
&&\bigl(\because\ j = k\ \text{の項を分ける（}\mathbb{C}\ \text{の加法の結合律・交換律 }\blkref{complex_numbers_form_a_field}\text{）}\bigr)\\
&= A_{ik}\,1_{\mathbb{C}} + \sum_{\substack{1 \leq j \leq n \\ j \neq k}} A_{ij}\,0_{\mathbb{C}}
&&\bigl(\because\ \delta\ \text{の値 }\blkref{def_kronecker_delta}\bigr)\\
&= A_{ik} + \sum_{\substack{1 \leq j \leq n \\ j \neq k}} A_{ij}\,0_{\mathbb{C}}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= A_{ik} + \sum_{\substack{1 \leq j \leq n \\ j \neq k}} 0_{\mathbb{C}}
&&\bigl(\because\ z\,0_{\mathbb{C}} = 0_{\mathbb{C}}\ \blkref{complex_times_zero_is_zero}\ \text{を各項へ適用}\bigr)\\
&= A_{ik}
&&\bigl(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元で、これを項の数だけ繰り返す }\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。単位行列を右から掛けても行列が変わらないことは本文全体で根拠として使われていたが、述べるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、成分計算の鎖で示した。",
        "2026-11-01: 右から 0 を掛けた項を、積の交換律で左から掛ける形にしてから complex_zero_times_is_zero を使う 2 段を、" +
          "complex_times_zero_is_zero を引く 1 段にした（この主張に乗法の可換則は効いていない）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_multiple_factors_out_of_left_factor",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "左の因子のスカラー倍は行列の積の外へ出せる" },
    labels: ["scalar_multiple_factors_out_of_left_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`(aA)B = a(AB)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((aA)B\bigr)_{ik}
&= \sum_{j=1}^{n} (aA)_{ij}\,B_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} (a\,A_{ij})\,B_{jk}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= \sum_{j=1}^{n} a\,(A_{ij}\,B_{jk})
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= a \sum_{j=1}^{n} A_{ij}\,B_{jk}
&&\bigl(\because\ \mathbb{C}\ \text{の分配律を有限和の項の数だけ繰り返す }\blkref{complex_numbers_form_a_field}\bigr)\\
&= a\,(AB)_{ik}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \bigl(a(AB)\bigr)_{ik}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。左の因子のスカラー倍を行列の積の外へ出すことは本文全体で根拠として使われていたが、述べるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_multiple_factors_out_of_right_factor",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "右の因子のスカラー倍は行列の積の外へ出せる" },
    labels: ["scalar_multiple_factors_out_of_right_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`A(aB) = a(AB)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A(aB)\bigr)_{ik}
&= \sum_{j=1}^{n} A_{ij}\,(aB)_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} A_{ij}\,(a\,B_{jk})
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= \sum_{j=1}^{n} (A_{ij}\,a)\,B_{jk}
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{j=1}^{n} (a\,A_{ij})\,B_{jk}
&&\bigl(\because\ \mathbb{C}\ \text{の積の交換律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{j=1}^{n} a\,(A_{ij}\,B_{jk})
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= a \sum_{j=1}^{n} A_{ij}\,B_{jk}
&&\bigl(\because\ \mathbb{C}\ \text{の分配律を有限和の項の数だけ繰り返す }\blkref{complex_numbers_form_a_field}\bigr)\\
&= a\,(AB)_{ik}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \bigl(a(AB)\bigr)_{ik}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。右の因子のスカラー倍を行列の積の外へ出すことは本文全体で根拠として使われていたが、述べるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_negation_factors_out_of_left_factor",
    kind: "claim",
    title: { text: "左の因子の符号反転は行列の積の外へ出る" },
    labels: ["negation_factors_out_of_left_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。符号反転は ",
        ref("def_matrix_negation"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`(-A)B = -(AB)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((-A)B\bigr)_{ik}
&= \sum_{j=1}^{n} (-A)_{ij}\,B_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} (-A_{ij})\,B_{jk}
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)\\
&= \sum_{j=1}^{n} \bigl((-1_{\mathbb{C}})\,A_{ij}\bigr)\,B_{jk}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= \sum_{j=1}^{n} (-1_{\mathbb{C}})\,(A_{ij}\,B_{jk})
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (-1_{\mathbb{C}}) \sum_{j=1}^{n} A_{ij}\,B_{jk}
&&\bigl(\because\ \mathbb{C}\ \text{の分配律を有限和の項の数だけ繰り返す }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (-1_{\mathbb{C}})\,(AB)_{ik}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= -(AB)_{ik}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= \bigl(-(AB)\bigr)_{ik}
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。matrix_exp_conjugation の Step 7 が「行列のスカラー倍と積の両立を c=−1 に取ること」と名前だけで根拠にしていた段を引けるよう足した。" +
          "−A は def_matrix_negation の成分ごとの符号反転であって (−1)A ではないので、スカラー倍の主張の特殊化としてではなく、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_negation_factors_out_of_right_factor",
    kind: "claim",
    title: { text: "右の因子の符号反転は行列の積の外へ出る" },
    labels: ["negation_factors_out_of_right_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。符号反転は ",
        ref("def_matrix_negation"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`A(-B) = -(AB)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A(-B)\bigr)_{ik}
&= \sum_{j=1}^{n} A_{ij}\,(-B)_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} A_{ij}\,(-B_{jk})
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)\\
&= \sum_{j=1}^{n} A_{ij}\,\bigl((-1_{\mathbb{C}})\,B_{jk}\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= \sum_{j=1}^{n} \bigl(A_{ij}\,(-1_{\mathbb{C}})\bigr)\,B_{jk}
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{j=1}^{n} \bigl((-1_{\mathbb{C}})\,A_{ij}\bigr)\,B_{jk}
&&\bigl(\because\ \mathbb{C}\ \text{の積の交換律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{j=1}^{n} (-1_{\mathbb{C}})\,(A_{ij}\,B_{jk})
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (-1_{\mathbb{C}}) \sum_{j=1}^{n} A_{ij}\,B_{jk}
&&\bigl(\because\ \mathbb{C}\ \text{の分配律を有限和の項の数だけ繰り返す }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (-1_{\mathbb{C}})\,(AB)_{ik}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= -(AB)_{ik}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= \bigl(-(AB)\bigr)_{ik}
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。matrix_exp_conjugation の Step 7 が「行列のスカラー倍と積の両立を c=−1 に取ること」と名前だけで根拠にしていた段を引けるよう足した。" +
          "−B は def_matrix_negation の成分ごとの符号反転であって (−1)B ではないので、スカラー倍の主張の特殊化としてではなく、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_complex_sums",
    kind: "claim",
    title: { text: "複素数の和の有限和は有限和の和" },
    labels: ["finite_sum_of_complex_sums"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a_1,\dots,a_n, b_1,\dots,b_n \in \mathbb{C}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_complex_numbers"),
        "、和は ",
        ref("definition_of_cc"),
        " の和による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{n} (a_j + b_j) = \Bigl(\sum_{j=1}^{n} a_j\Bigr) + \Bigl(\sum_{j=1}^{n} b_j\Bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (a_j + b_j)
&= a_1 + b_1
&&\bigl(\because\ \blkref{def_finite_sum_of_complex_numbers}\bigr)\\
&= \Bigl(\sum_{j=1}^{1} a_j\Bigr) + \Bigl(\sum_{j=1}^{1} b_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_complex_numbers}\text{ を 2 か所へ同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n`),
        " で成り立つと仮定し、",
        math(String.raw`a_1,\dots,a_{n+1}, b_1,\dots,b_{n+1} \in \mathbb{C}`),
        " を取る。",
        math(String.raw`\alpha := \sum_{j=1}^{n} a_j`),
        "、",
        math(String.raw`\beta := \sum_{j=1}^{n} b_j`),
        " とおく（",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{n+1} (a_j + b_j)
&= \Bigl(\sum_{j=1}^{n} (a_j + b_j)\Bigr) + (a_{n+1} + b_{n+1})
&&\bigl(\because\ \blkref{def_finite_sum_of_complex_numbers}\bigr)\\
&= (\alpha + \beta) + (a_{n+1} + b_{n+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \alpha + \bigl(\beta + (a_{n+1} + b_{n+1})\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の和の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \alpha + \bigl((\beta + a_{n+1}) + b_{n+1}\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の和の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \alpha + \bigl((a_{n+1} + \beta) + b_{n+1}\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の和の交換律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \alpha + \bigl(a_{n+1} + (\beta + b_{n+1})\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の和の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (\alpha + a_{n+1}) + (\beta + b_{n+1})
&&\bigl(\because\ \mathbb{C}\ \text{の和の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl(\sum_{j=1}^{n+1} a_j\Bigr) + \Bigl(\sum_{j=1}^{n+1} b_j\Bigr)
&&\bigl(\because\ \alpha, \beta\ \text{の置き方と }\blkref{def_finite_sum_of_complex_numbers}\text{ を 2 か所へ同時適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。行列の積が右の因子の和・左の因子の和に分配すること（mat_mult_distributes_over_sum_in_right_factor・mat_mult_distributes_over_sum_in_left_factor）の成分の鎖で、" +
          "項ごとの和の有限和を二つの有限和に分ける段を引けるよう足した。和の結合律・交換律の適用を、帰納法の 1 段ずつに割った。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_mat_mult_distributes_over_sum_in_right_factor",
    kind: "claim",
    title: { text: "行列の積は右の因子の和に分配する" },
    labels: ["mat_mult_distributes_over_sum_in_right_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B, C \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。和は ",
        ref("def_matrix_sum"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`A(B + C) = AB + AC`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A(B + C)\bigr)_{ik}
&= \sum_{j=1}^{n} A_{ij}\,(B + C)_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} A_{ij}\,(B_{jk} + C_{jk})
&&\bigl(\because\ \text{行列の和の定義 }\blkref{def_matrix_sum}\bigr)\\
&= \sum_{j=1}^{n} \bigl(A_{ij}\,B_{jk} + A_{ij}\,C_{jk}\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の分配律 }\blkref{complex_numbers_form_a_field}\text{ を各項へ同時適用}\bigr)\\
&= \Bigl(\sum_{j=1}^{n} A_{ij}\,B_{jk}\Bigr) + \Bigl(\sum_{j=1}^{n} A_{ij}\,C_{jk}\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_complex_sums}\bigr)\\
&= (AB)_{ik} + (AC)_{ik}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\text{ を 2 か所へ同時適用}\bigr)\\
&= (AB + AC)_{ik}
&&\bigl(\because\ \text{行列の和の定義 }\blkref{def_matrix_sum}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。linearity_of_T の証明が「左からの行列積の分配法則」と名前だけで根拠にしていた段を引けるよう足した。" +
          "sign_flip_conjugation の Step 3 の「共役の ℂ 線型性」（有限和への適用）は、いまは名前だけの根拠であり、共役が和を保つことを示す主張を経てこの主張を引くよう直す予定である。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_mat_mult_distributes_over_sum_in_left_factor",
    kind: "claim",
    title: { text: "行列の積は左の因子の和に分配する" },
    labels: ["mat_mult_distributes_over_sum_in_left_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`C \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。和は ",
        ref("def_matrix_sum"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`(A + B)C = AC + BC`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((A + B)C\bigr)_{ik}
&= \sum_{j=1}^{n} (A + B)_{ij}\,C_{jk}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} (A_{ij} + B_{ij})\,C_{jk}
&&\bigl(\because\ \text{行列の和の定義 }\blkref{def_matrix_sum}\bigr)\\
&= \sum_{j=1}^{n} \bigl(A_{ij}\,C_{jk} + B_{ij}\,C_{jk}\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の分配律 }\blkref{complex_numbers_form_a_field}\text{ を各項へ同時適用}\bigr)\\
&= \Bigl(\sum_{j=1}^{n} A_{ij}\,C_{jk}\Bigr) + \Bigl(\sum_{j=1}^{n} B_{ij}\,C_{jk}\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_complex_sums}\bigr)\\
&= (AC)_{ik} + (BC)_{ik}
&&\bigl(\because\ \text{行列の積の定義 }\blkref{mat_mult}\text{ を 2 か所へ同時適用}\bigr)\\
&= (AC + BC)_{ik}
&&\bigl(\because\ \text{行列の和の定義 }\blkref{def_matrix_sum}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。linearity_of_T の証明が「右からの行列積の分配法則」と名前だけで根拠にしていた段を引けるよう足した。" +
          "sign_flip_conjugation の Step 3 の「共役の ℂ 線型性」（有限和への適用）は、いまは名前だけの根拠であり、共役が和を保つことを示す主張を経てこの主張を引くよう直す予定である。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_negation_is_scalar_multiple_by_minus_one",
    kind: "claim",
    title: { text: "行列の符号反転は −1 倍に等しい" },
    labels: ["negation_is_scalar_multiple_by_minus_one"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。符号反転は ",
        ref("def_matrix_negation"),
        "、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        " による。このとき",
      ]),
      displayMath(String.raw`-A = (-1_{\mathbb{C}})\,A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`j \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(-A)_{ij}
&= -A_{ij}
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)\\
&= (-1_{\mathbb{C}})\,A_{ij}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= \bigl((-1_{\mathbb{C}})\,A\bigr)_{ij}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation の Step 1 が「パウリ行列の積」と名前だけで根拠にしていた σ_k^zσ_k^x = −(σ_k^xσ_k^z) を一ステップ一定理に割ると、" +
          "サイト k の因子の符号反転をクロネッカー積の外へ出す段で kronecker_multilinear（スカラー倍についての線型性）を使うために、−C を (−1)C に書き直す段が要るので足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_multiple_of_negated_matrix",
    kind: "claim",
    title: { text: "符号反転した行列のスカラー倍はスカラー倍の符号反転に等しい" },
    labels: ["scalar_multiple_of_negated_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、符号反転は ",
        ref("def_matrix_negation"),
        " による。このとき",
      ]),
      displayMath(String.raw`a(-A) = -(aA)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`j \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(a(-A)\bigr)_{ij}
&= a\,(-A)_{ij}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= a\,(-A_{ij})
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)\\
&= a\,\bigl((-1_{\mathbb{C}})\,A_{ij}\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= \bigl(a\,(-1_{\mathbb{C}})\bigr)\,A_{ij}
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl((-1_{\mathbb{C}})\,a\bigr)\,A_{ij}
&&\bigl(\because\ \mathbb{C}\ \text{の積の交換律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (-1_{\mathbb{C}})\,(a\,A_{ij})
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= -(a\,A_{ij})
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= -(aA)_{ij}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= \bigl(-(aA)\bigr)_{ij}
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation の Step 4 が「共役はスカラー倍を保つ」と名前だけで根拠にしていた鎖を一ステップ一定理に割ると、" +
          "iK_1(−H_1^{(+)}) = −(iK_1H_1^{(+)}) の段が要るので足した。−A は def_matrix_negation の成分ごとの符号反転であって (−1)A ではないので、スカラー倍の結合律の特殊化としてではなく、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_double_negation",
    kind: "claim",
    title: { text: "行列の符号反転を二回施すと元に戻る" },
    labels: ["matrix_double_negation"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。符号反転は ",
        ref("def_matrix_negation"),
        " による。このとき",
      ]),
      displayMath(String.raw`-(-A) = A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`j \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(-(-A)\bigr)_{ij}
&= -\bigl((-A)_{ij}\bigr)
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)\\
&= -(-A_{ij})
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)\\
&= (-1_{\mathbb{C}})\,\bigl((-1_{\mathbb{C}})\,A_{ij}\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\text{ を 2 か所へ同時適用}\bigr)\\
&= \bigl((-1_{\mathbb{C}})\,(-1_{\mathbb{C}})\bigr)\,A_{ij}
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= 1_{\mathbb{C}}\,A_{ij}
&&\bigl(\because\ \mathbb{C}\ \text{で}\ (-1_{\mathbb{C}})(-1_{\mathbb{C}})=1_{\mathbb{C}}\text{。}\blkref{definition_of_cc}\ \text{の積}\bigr)\\
&= A_{ij}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元 }\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation の Step 1 の合成の段で、k が奇数のときの Uσ_k^yU^{-1} が −(−σ_k^y) になり、" +
          "σ_k^y へ戻す段を引けるよう足した。−A は def_matrix_negation の成分ごとの符号反転なので、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_negation_distributes_over_matrix_sum",
    kind: "claim",
    title: { text: "行列の和の符号反転は符号反転の和に等しい" },
    labels: ["negation_distributes_over_matrix_sum"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。符号反転は ",
        ref("def_matrix_negation"),
        "、和は ",
        ref("def_matrix_sum"),
        " による。このとき",
      ]),
      displayMath(String.raw`-(A + B) = (-A) + (-B)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`j \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(-(A + B)\bigr)_{ij}
&= -\bigl((A + B)_{ij}\bigr)
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)\\
&= -(A_{ij} + B_{ij})
&&\bigl(\because\ \text{和の定義 }\blkref{def_matrix_sum}\bigr)\\
&= (-1_{\mathbb{C}})\,(A_{ij} + B_{ij})
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= (-1_{\mathbb{C}})\,A_{ij} + (-1_{\mathbb{C}})\,B_{ij}
&&\bigl(\because\ \mathbb{C}\ \text{の分配律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (-A_{ij}) + (-B_{ij})
&&\bigl(\because\ \blkref{multiply_by_minus_one}\text{ を 2 か所へ同時適用}\bigr)\\
&= (-A)_{ij} + (-B)_{ij}
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\text{ を 2 か所へ同時適用}\bigr)\\
&= \bigl((-A) + (-B)\bigr)_{ij}
&&\bigl(\because\ \text{和の定義 }\blkref{def_matrix_sum}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation の Step 3 の H_2 の鎖で、符号反転した項の有限和 Σ(−(Z_mY_m)) を −Σ Z_mY_m にまとめる段（finite_sum_of_negated_matrices）の帰納法の段に要るので足した。" +
          "−A は def_matrix_negation の成分ごとの符号反転なので、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_negated_matrices",
    kind: "claim",
    title: { text: "符号反転した行列の有限和は有限和の符号反転に等しい" },
    labels: ["finite_sum_of_negated_matrices"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。有限和は ",
        ref("def_finite_sum_of_matrices"),
        "、符号反転は ",
        ref("def_matrix_negation"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{r} (-X_j) = -\sum_{j=1}^{r} X_j`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`r`), " についての帰納法で示す。", math(String.raw`r = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (-X_j)
&= -X_1
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 } -X_j\text{）}\bigr)\\
&= -\sum_{j=1}^{1} X_j
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r`),
        " で成り立つと仮定すると、",
        math(String.raw`X_1,\dots,X_{r+1} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{r+1} (-X_j)
&= \Bigl(\sum_{j=1}^{r} (-X_j)\Bigr) + (-X_{r+1})
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 } -X_j\text{）}\bigr)\\
&= \Bigl(-\sum_{j=1}^{r} X_j\Bigr) + (-X_{r+1})
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= -\Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)
&&\bigl(\because\ \blkref{negation_distributes_over_matrix_sum}\ \bigl(A = \textstyle\sum_{j=1}^{r} X_j,\ B = X_{r+1}\bigr)\bigr)\\
&= -\sum_{j=1}^{r+1} X_j
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation の Step 3 の H_2 の鎖 UH_2U^{-1} = Σ T_U(Z_mY_m) = Σ(−(Z_mY_m)) = −Σ Z_mY_m の最後の段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_difference_is_sum_with_negation",
    kind: "claim",
    title: { text: "行列の差は符号反転した行列との和に等しい" },
    labels: ["matrix_difference_is_sum_with_negation"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。差は ",
        ref("def_matrix_difference"),
        "、符号反転は ",
        ref("def_matrix_negation"),
        "、和は ",
        ref("def_matrix_sum"),
        " による。このとき",
      ]),
      displayMath(String.raw`A - B = A + (-B)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`j \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(A - B)_{ij}
&= A_{ij} - B_{ij}
&&\bigl(\because\ \text{差の定義 }\blkref{def_matrix_difference}\bigr)\\
&= A_{ij} + (-B_{ij})
&&\bigl(\because\ \text{複素数の差の定義 }\blkref{def_complex_difference}\bigr)\\
&= A_{ij} + (-B)_{ij}
&&\bigl(\because\ \text{符号反転の定義 }\blkref{def_matrix_negation}\bigr)\\
&= \bigl(A + (-B)\bigr)_{ij}
&&\bigl(\because\ \text{和の定義 }\blkref{def_matrix_sum}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation の Step 3 の H_1^{(+)} の鎖は差 Σ Y_mZ_{m+1} − Y_{M_col}Z_1 を含むので、差を和と符号反転へ戻す段（difference_of_negated_matrices・matrix_conjugation_preserves_difference）に要る。" +
          "行列の差 def_matrix_difference は成分の複素数の差で定まり、和と符号反転とは別に定義されているので、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_difference_of_negated_matrices",
    kind: "claim",
    title: { text: "符号反転した行列の差は差の符号反転に等しい" },
    labels: ["difference_of_negated_matrices"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。差は ",
        ref("def_matrix_difference"),
        "、符号反転は ",
        ref("def_matrix_negation"),
        " による。このとき",
      ]),
      displayMath(String.raw`(-A) - (-B) = -(A - B)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(-A) - (-B)
&= (-A) + \bigl(-(-B)\bigr)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ (A \to -A,\ B \to -B)\bigr)\\
&= -\bigl(A + (-B)\bigr)
&&\bigl(\because\ \blkref{negation_distributes_over_matrix_sum}\ (A \to A,\ B \to -B)\bigr)\\
&= -(A - B)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ \text{を}\ -(\cdot)\ \text{の中へ右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。sign_flip_conjugation の Step 3 の H_1^{(+)} の鎖で、Σ(−(Y_mZ_{m+1})) − (−(Y_{M_col}Z_1)) を −H_1^{(+)} にまとめる段を引けるよう足した。" +
          "行列の等号の 3 行の鎖で、二重の符号反転 −(−B) は B へ戻さずに negation_distributes_over_matrix_sum の右辺として読む。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_multiple_distributes_over_matrix_difference",
    kind: "claim",
    title: { text: "スカラー倍は行列の差に分配する" },
    labels: ["scalar_multiple_distributes_over_matrix_difference"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、差は ",
        ref("def_matrix_difference"),
        " による。このとき",
      ]),
      displayMath(String.raw`c(A - B) = cA - cB`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c(A - B)\bigr)_{ik}
&= c\,(A - B)_{ik}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= c\,(A_{ik} - B_{ik})
&&\bigl(\because\ \text{差の定義 }\blkref{def_matrix_difference}\bigr)\\
&= c\,\bigl(A_{ik} + (-B_{ik})\bigr)
&&\bigl(\because\ \blkref{def_complex_difference}\bigr)\\
&= c\,A_{ik} + c\,(-B_{ik})
&&\bigl(\because\ \mathbb{C}\ \text{の分配律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= c\,A_{ik} + c\,\bigl((-1_{\mathbb{C}})\,B_{ik}\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= c\,A_{ik} + \bigl(c\,(-1_{\mathbb{C}})\bigr)\,B_{ik}
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= c\,A_{ik} + \bigl((-1_{\mathbb{C}})\,c\bigr)\,B_{ik}
&&\bigl(\because\ \mathbb{C}\ \text{の積の交換律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= c\,A_{ik} + (-1_{\mathbb{C}})\,(c\,B_{ik})
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= c\,A_{ik} + \bigl(-(c\,B_{ik})\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= c\,A_{ik} - c\,B_{ik}
&&\bigl(\because\ \blkref{def_complex_difference}\bigr)\\
&= (cA)_{ik} - (cB)_{ik}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\ \text{を 2 箇所へ適用}\bigr)\\
&= (cA - cB)_{ik}
&&\bigl(\because\ \text{差の定義 }\blkref{def_matrix_difference}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。matrix_exp_conjugation の Step 1 の ad_X(cZ) の鎖が「スカラー倍の分配律」と名前だけで根拠にしていた段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_multiple_distributes_over_matrix_sum",
    kind: "claim",
    title: { text: "スカラー倍は行列の和に分配する" },
    labels: ["scalar_multiple_distributes_over_matrix_sum"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、和は ",
        ref("def_matrix_sum"),
        " による。このとき",
      ]),
      displayMath(String.raw`c(A + B) = cA + cB`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`j \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(c(A + B)\bigr)_{ij}
&= c\,(A + B)_{ij}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= c\,(A_{ij} + B_{ij})
&&\bigl(\because\ \text{和の定義 }\blkref{def_matrix_sum}\bigr)\\
&= c\,A_{ij} + c\,B_{ij}
&&\bigl(\because\ \mathbb{C}\ \text{の分配律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (cA)_{ij} + (cB)_{ij}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\ \text{を 2 箇所へ適用}\bigr)\\
&= (cA + cB)_{ij}
&&\bigl(\because\ \text{和の定義 }\blkref{def_matrix_sum}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。スカラー倍を有限和の外へ出す finite_sum_of_scalar_multiples の帰納法の段に要るので足した。" +
          "iH_is_real_symmetric の Step 1・Step 2 の鎖が「スカラー倍の和の分配」と名前だけで根拠にしていた段を、その主張で引けるようにするためである。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_scalar_multiples",
    kind: "claim",
    title: { text: "スカラー倍した行列の有限和は有限和のスカラー倍に等しい" },
    labels: ["finite_sum_of_scalar_multiples"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。有限和は ",
        ref("def_finite_sum_of_matrices"),
        "、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{r} (cX_j) = c\sum_{j=1}^{r} X_j`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`r`), " についての帰納法で示す。", math(String.raw`r = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} (cX_j)
&= cX_1
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 } cX_j\text{）}\bigr)\\
&= c\sum_{j=1}^{1} X_j
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r`),
        " で成り立つと仮定すると、",
        math(String.raw`X_1,\dots,X_{r+1} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{r+1} (cX_j)
&= \Bigl(\sum_{j=1}^{r} (cX_j)\Bigr) + cX_{r+1}
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 } cX_j\text{）}\bigr)\\
&= \Bigl(c\sum_{j=1}^{r} X_j\Bigr) + cX_{r+1}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= c\Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_distributes_over_matrix_sum}\ \bigl(A \to \textstyle\sum_{j=1}^{r} X_j,\ B \to X_{r+1}\bigr)\ \text{を右辺から左辺へ}\bigr)\\
&= c\sum_{j=1}^{r+1} X_j
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 1 の Σ(−iσ_m^x) = −iΣσ_m^x と、Step 2 の Σ(−iσ_m^zσ_{m+1}^z) = −iΣσ_m^zσ_{m+1}^z が" +
          "「スカラー倍の和の分配」と名前だけで根拠にしていた段を引けるよう足した。finite_sum_of_negated_matrices と同じ帰納法の形で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_scalar_multiples_of_one_matrix",
    kind: "claim",
    title: { text: "一つの行列のスカラー倍の有限和は係数の有限和によるスカラー倍に等しい" },
    labels: ["finite_sum_of_scalar_multiples_of_one_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c_1,\dots,c_r \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。行列の有限和は ",
        ref("def_finite_sum_of_matrices"),
        "、複素数の有限和は ",
        ref("def_finite_sum_of_complex_numbers"),
        "、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{r} (c_jA) = \Bigl(\sum_{j=1}^{r} c_j\Bigr)A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{j=1}^{r} (c_jA)\Bigr)_{ik}
&= \sum_{j=1}^{r} (c_jA)_{ik}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\bigr)\\
&= \sum_{j=1}^{r} c_j\,A_{ik}
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\text{ を }r\text{ 個の項へ同時適用}\bigr)\\
&= \Bigl(\sum_{j=1}^{r} c_j\Bigr)A_{ik}
&&\bigl(\because\ \mathbb{C}\text{ の有限和の分配則}\bigr)\\
&= \Bigl(\Bigl(\sum_{j=1}^{r} c_j\Bigr)A\Bigr)_{ik}
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（全証明の SageMath 検算 anticommutator_of_check_Z_Y）: 原文（Typst）に対応ブロックは無い。anticommutator_of_check_Z_Y の証明が二重和の係数をまとめる段を「反交換子の ℂ 双線型性」と名前だけで根拠にしていたので、その段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_matrices_distributes_in_left_factor",
    kind: "claim",
    title: { text: "行列の有限和を左の因子とする積は各項の積の有限和に等しい" },
    labels: ["finite_sum_of_matrices_distributes_in_left_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`C \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。有限和は ",
        ref("def_finite_sum_of_matrices"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`\Bigl(\sum_{j=1}^{r} X_j\Bigr)C = \sum_{j=1}^{r} (X_jC)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`r`), " についての帰納法で示す。", math(String.raw`r = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{j=1}^{1} X_j\Bigr)C
&= X_1C
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \sum_{j=1}^{1} (X_jC)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 } X_jC\text{）を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r`),
        " で成り立つと仮定すると、",
        math(String.raw`X_1,\dots,X_{r+1} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{j=1}^{r+1} X_j\Bigr)C
&= \Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)C
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \Bigl(\sum_{j=1}^{r} X_j\Bigr)C + X_{r+1}C
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor}\ \bigl(A \to \textstyle\sum_{j=1}^{r} X_j,\ B \to X_{r+1}\bigr)\bigr)\\
&= \Bigl(\sum_{j=1}^{r} (X_jC)\Bigr) + X_{r+1}C
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \sum_{j=1}^{r+1} (X_jC)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 } X_jC\text{）を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。eigenvalues_of_check_Vprime の Step 1 が X̌Q̌_ε の展開を「行列の積の分配法則」と名前だけで根拠にしていた段のうち、有限和を左の因子とする積を各項へ配る段を引けるよう足した。finite_sum_of_scalar_multiples と同じ帰納法の形で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_matrices_distributes_in_right_factor",
    kind: "claim",
    title: { text: "行列の有限和を右の因子とする積は各項の積の有限和に等しい" },
    labels: ["finite_sum_of_matrices_distributes_in_right_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`C \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。有限和は ",
        ref("def_finite_sum_of_matrices"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`C\Bigl(\sum_{j=1}^{r} X_j\Bigr) = \sum_{j=1}^{r} (CX_j)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`r`), " についての帰納法で示す。", math(String.raw`r = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
C\Bigl(\sum_{j=1}^{1} X_j\Bigr)
&= CX_1
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \sum_{j=1}^{1} (CX_j)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 } CX_j\text{）を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r`),
        " で成り立つと仮定すると、",
        math(String.raw`X_1,\dots,X_{r+1} \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
C\Bigl(\sum_{j=1}^{r+1} X_j\Bigr)
&= C\Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= C\Bigl(\sum_{j=1}^{r} X_j\Bigr) + CX_{r+1}
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\ \bigl(A \to C,\ B \to \textstyle\sum_{j=1}^{r} X_j,\ C \to X_{r+1}\ \text{を同時に置き換える}\bigr)\bigr)\\
&= \Bigl(\sum_{j=1}^{r} (CX_j)\Bigr) + CX_{r+1}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \sum_{j=1}^{r+1} (CX_j)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ \text{（項 } CX_j\text{）を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。eigenvalues_of_check_Vprime の Step 1 の右から掛ける形（Q̌_εX̌）を「同じ計算を (3) の右から掛ける形に対して行えば」と名前だけで済ませていた段のうち、有限和を右の因子とする積を各項へ配る段を引けるよう足した。finite_sum_of_matrices_distributes_in_left_factor と同じ帰納法の形で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_difference_of_scalar_multiples_of_one_matrix",
    kind: "claim",
    title: { text: "一つの行列のスカラー倍の差は係数の差によるスカラー倍に等しい" },
    labels: ["difference_of_scalar_multiples_of_one_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a, b \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、行列の差は ",
        ref("def_matrix_difference"),
        "、複素数の差は ",
        ref("def_complex_difference"),
        " による。このとき",
      ]),
      displayMath(String.raw`aA - bA = (a - b)A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(aA - bA)_{ik}
&= (aA)_{ik} - (bA)_{ik}
&&\bigl(\because\ \text{差の定義 }\blkref{def_matrix_difference}\bigr)\\
&= a\,A_{ik} - b\,A_{ik}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\ \text{を 2 箇所へ適用}\bigr)\\
&= a\,A_{ik} + \bigl(-(b\,A_{ik})\bigr)
&&\bigl(\because\ \blkref{def_complex_difference}\bigr)\\
&= a\,A_{ik} + (-1_{\mathbb{C}})\,(b\,A_{ik})
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= a\,A_{ik} + \bigl((-1_{\mathbb{C}})\,b\bigr)\,A_{ik}
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= a\,A_{ik} + (-b)\,A_{ik}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl(a + (-b)\bigr)\,A_{ik}
&&\bigl(\because\ \mathbb{C}\ \text{の分配律 }\blkref{complex_numbers_form_a_field}\ \text{を右辺から左辺へ}\bigr)\\
&= (a - b)\,A_{ik}
&&\bigl(\because\ \blkref{def_complex_difference}\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl((a - b)A\bigr)_{ik}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。eigenvalues_of_check_Vprime の Step 1 が γ(θ̃_μ)(ε_μQ̌_ε − ½Q̌_ε) を (γ(θ̃_μ)(ε_μ − ½))Q̌_ε へまとめる段を「有限和のくくり出し」と名前だけで根拠にしていたので、係数の差をくくり出す段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_double_sum_of_matrices_interchange",
    kind: "claim",
    title: { text: "行列の二重の有限和は和の順序を入れ替えても等しい" },
    labels: ["finite_double_sum_of_matrices_interchange"],
    statement: [
      paragraph([
        math(String.raw`m, n, r, s \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`a \in \{1,\dots,r\}`),
        "、",
        math(String.raw`b \in \{1,\dots,s\}`),
        " について ",
        math(String.raw`X_{a,b} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。行列の有限和は ",
        ref("def_finite_sum_of_matrices"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{a=1}^{r}\sum_{b=1}^{s} X_{a,b} = \sum_{b=1}^{s}\sum_{a=1}^{r} X_{a,b}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{a=1}^{r}\sum_{b=1}^{s} X_{a,b}\Bigr)_{ik}
&= \sum_{a=1}^{r}\Bigl(\sum_{b=1}^{s} X_{a,b}\Bigr)_{ik}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\bigr)\\
&= \sum_{a=1}^{r}\sum_{b=1}^{s} (X_{a,b})_{ik}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\text{ を各 }a\text{ へ同時適用}\bigr)\\
&= \sum_{b=1}^{s}\sum_{a=1}^{r} (X_{a,b})_{ik}
&&\bigl(\because\ \mathbb{C}\ \text{の加法の結合法則・交換法則による有限和の順序交換。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{b=1}^{s}\Bigl(\sum_{a=1}^{r} X_{a,b}\Bigr)_{ik}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\text{ を右辺から左辺へ、各 }b\text{ へ同時適用}\bigr)\\
&= \Bigl(\sum_{b=1}^{s}\sum_{a=1}^{r} X_{a,b}\Bigr)_{ik}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\text{ を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（全証明の SageMath 検算 recover_Z_Y_from_check_Z_Y）: 原文（Typst）に対応ブロックは無い。recover_Z_Y_from_check_Z_Y の証明が行列の二重和の順序を「有限和の順序交換」と名前だけで入れ替えていたので、その段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_matrices_with_single_nonzero_term",
    kind: "claim",
    title: { text: "一つを除く項が零行列である行列の有限和は、その一つの項に等しい" },
    labels: ["finite_sum_of_matrices_with_single_nonzero_term"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`q \in \{1,\dots,r\}`),
        " とし、",
        math(String.raw`a \neq q`),
        " のすべての ",
        math(String.raw`a \in \{1,\dots,r\}`),
        " について ",
        math(String.raw`X_a = O`),
        "（",
        ref("def_zero_matrix"),
        " の零行列）とする。行列の有限和は ",
        ref("def_finite_sum_of_matrices"),
        " による。このとき",
      ]),
      displayMath(String.raw`\sum_{a=1}^{r} X_a = X_q`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を取る。",
        math(String.raw`a \neq q`),
        " なら ",
        math(String.raw`(X_a)_{ik} = O_{ik} = 0_{\mathbb C}`),
        "（",
        ref("def_zero_matrix"),
        "）なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{a=1}^{r} X_a\Bigr)_{ik}
&= \sum_{a=1}^{r} (X_a)_{ik}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\bigr)\\
&= (X_q)_{ik}
&&\bigl(\because\ \blkref{finite_sum_with_single_nonzero_term}\ (m \to r,\ z_a \to (X_a)_{ik},\ n \to q)\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（全証明の SageMath 検算 recover_Z_Y_from_check_Z_Y）: 原文（Typst）に対応ブロックは無い。recover_Z_Y_from_check_Z_Y の証明が行列の有限和で「k = j の項だけが残る」と名前だけで述べていたので、その段を引けるよう、複素数の finite_sum_with_single_nonzero_term の行列版を足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_multiple_is_associative",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "スカラー倍を続けて施すことは積のスカラー倍に等しい" },
    labels: ["scalar_multiple_is_associative"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a, b \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        " による。このとき",
      ]),
      displayMath(String.raw`a(bA) = (ab)A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`j \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(a(bA)\bigr)_{ij}
&= a\,(bA)_{ij}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= a\,(b\,A_{ij})
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= (ab)\,A_{ij}
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl((ab)A\bigr)_{ij}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。スカラー倍を続けて施すことが積のスカラー倍に等しいことは本文全体で根拠として使われていたが、述べるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_multiple_by_one",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "1 倍しても行列は変わらない" },
    labels: ["scalar_multiple_by_one"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、",
        math(String.raw`1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(1)`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記による。このとき",
      ]),
      displayMath(String.raw`1_{\mathbb{C}}\,A = A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`j \in \{1,\dots,n\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(1_{\mathbb{C}}\,A\bigr)_{ij}
&= 1_{\mathbb{C}}\,A_{ij}
&&\bigl(\because\ \text{スカラー倍の定義 }\blkref{def_matrix_scalar_multiple}\bigr)\\
&= A_{ij}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元 }\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。1 倍しても行列が変わらないことは本文全体で根拠として使われていたが、述べるブロックが無かった。" +
          "可逆元の定義（def_invertible_elements_of_R）の検算のレビューで欠けが見つかり、成分計算の鎖で示した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_equals_negation_if_sum_is_zero",
    kind: "claim",
    title: { text: "和が零行列なら一方は他方の符号反転" },
    labels: ["matrix_equals_negation_if_sum_is_zero"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X, Y \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " が ",
        math(String.raw`X + Y = O`),
        " を満たすとする。和は ",
        ref("def_matrix_sum"),
        "、符号反転は ",
        ref("def_matrix_negation"),
        "、",
        math(String.raw`O`),
        " は ",
        ref("def_zero_matrix"),
        " による。このとき",
      ]),
      displayMath(String.raw`X = -Y`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
X - (-Y)
&= X + \bigl(-(-Y)\bigr)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ (A \to X,\ B \to -Y)\bigr)\\
&= X + Y
&&(\because\ \blkref{matrix_double_negation})\\
&= O
&&(\because\ \text{仮定}\ X + Y = O)
\end{aligned}`),
      paragraph([
        "であるから、",
        ref("matrix_difference_zero_iff_equal"),
        " を ",
        math(String.raw`A \to X`),
        "、",
        math(String.raw`B \to -Y`),
        " で引いて ",
        math(String.raw`X = -Y`),
        " を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算 epsilon_commutes_with_transfer_matrices）: 原文（Typst）に対応ブロックは無い。tensor_anticommutation_from_single_site の結論 XY + YX = O から XY = -(YX) を引くために足した。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_matrix_anticommutator",
    kind: "definition",
    title: { text: "行列の反交換子" },
    labels: ["def_matrix_anticommutator"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X, W \in \mathrm{Mat}(n,\mathbb{C})`),
        " について、反交換子 ",
        math(String.raw`[X, W]_+ \in \mathrm{Mat}(n,\mathbb{C})`),
        " を",
      ]),
      displayMath(String.raw`[X, W]_+ := XW + WX`),
      paragraph([
        "で定める。積は ",
        ref("mat_mult"),
        "、和は ",
        ref("def_matrix_sum"),
        " による。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_number_operator_idempotent の (1)(2) が「反交換子の定義」を定義のブロックを置かずに根拠にしていたので足した。Lean は Ising2D.matAnticomm（DefinitionMatrixAnticommutator.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_anticommutator_of_finite_sums_of_scalar_multiples",
    kind: "claim",
    title: { text: "スカラー倍の有限和どうしの反交換子は反交換子の二重和に等しい" },
    labels: ["anticommutator_of_finite_sums_of_scalar_multiples"],
    statement: [
      paragraph([
        math(String.raw`n, r, s \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`a_1,\dots,a_r,\ b_1,\dots,b_s \in \mathbb{C}`),
        "、",
        math(String.raw`X_1,\dots,X_r,\ W_1,\dots,W_s \in \mathrm{Mat}(n,\mathbb{C})`),
        " とする。反交換子は ",
        ref("def_matrix_anticommutator"),
        "、行列の有限和は ",
        ref("def_finite_sum_of_matrices"),
        "、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        " による。二重和は内側から定める：",
        math(String.raw`\sum_{j=1}^{r}\sum_{k=1}^{s} B_{jk} := \sum_{j=1}^{r}\Bigl(\sum_{k=1}^{s} B_{jk}\Bigr)`),
        "。このとき",
      ]),
      displayMath(String.raw`\Bigl[\sum_{j=1}^{r} a_jX_j,\ \sum_{k=1}^{s} b_kW_k\Bigr]_+
= \sum_{j=1}^{r}\sum_{k=1}^{s} (a_jb_k)\,[X_j, W_k]_+`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`p, q \in \{1,\dots,n\}`),
        " を取る。",
        math(String.raw`S := \sum_{j=1}^{r} a_jX_j`),
        "、",
        math(String.raw`T := \sum_{k=1}^{s} b_kW_k`),
        " と置く。複素数の二重和も内側から定める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl([S, T]_+\bigr)_{pq}
&= (ST + TS)_{pq}
&&\bigl(\because\ \blkref{def_matrix_anticommutator}\bigr)\\
&= (ST)_{pq} + (TS)_{pq}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= \sum_{l=1}^{n} S_{pl}\,T_{lq} + \sum_{l=1}^{n} T_{pl}\,S_{lq}
&&\bigl(\because\ \blkref{mat_mult}\text{ を 2 箇所へ同時適用}\bigr)\\
&= \sum_{l=1}^{n} \Bigl(\sum_{j=1}^{r} (a_jX_j)_{pl}\Bigr)\Bigl(\sum_{k=1}^{s} (b_kW_k)_{lq}\Bigr)
 + \sum_{l=1}^{n} \Bigl(\sum_{k=1}^{s} (b_kW_k)_{pl}\Bigr)\Bigl(\sum_{j=1}^{r} (a_jX_j)_{lq}\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\text{ を 4 箇所へ同時適用}\bigr)\\
&= \sum_{l=1}^{n} \Bigl(\sum_{j=1}^{r} a_j(X_j)_{pl}\Bigr)\Bigl(\sum_{k=1}^{s} b_k(W_k)_{lq}\Bigr)
 + \sum_{l=1}^{n} \Bigl(\sum_{k=1}^{s} b_k(W_k)_{pl}\Bigr)\Bigl(\sum_{j=1}^{r} a_j(X_j)_{lq}\Bigr)
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\text{ を全ての項へ同時適用}\bigr)\\
&= \sum_{l=1}^{n} \Bigl(\sum_{j=1}^{r} a_j(X_j)_{pl}\Bigr)\Bigl(\sum_{k=1}^{s} b_k(W_k)_{lq}\Bigr)
 + \sum_{l=1}^{n} \Bigl(\sum_{j=1}^{r} a_j(X_j)_{lq}\Bigr)\Bigl(\sum_{k=1}^{s} b_k(W_k)_{pl}\Bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の交換律を第 2 項の各 }l\text{ へ同時適用。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{l=1}^{n}\sum_{j=1}^{r} \bigl(a_j(X_j)_{pl}\bigr)\Bigl(\sum_{k=1}^{s} b_k(W_k)_{lq}\Bigr)
 + \sum_{l=1}^{n}\sum_{j=1}^{r} \bigl(a_j(X_j)_{lq}\bigr)\Bigl(\sum_{k=1}^{s} b_k(W_k)_{pl}\Bigr)
&&\bigl(\because\ \mathbb{C}\text{ の有限和の分配則 }\bigl(\textstyle\sum_j x_j\bigr)y=\sum_j x_jy\text{ を全ての }l\text{ へ同時適用}\bigr)\\
&= \sum_{l=1}^{n}\sum_{j=1}^{r}\sum_{k=1}^{s} \bigl(a_j(X_j)_{pl}\bigr)\bigl(b_k(W_k)_{lq}\bigr)
 + \sum_{l=1}^{n}\sum_{j=1}^{r}\sum_{k=1}^{s} \bigl(a_j(X_j)_{lq}\bigr)\bigl(b_k(W_k)_{pl}\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の有限和の分配則 }x\textstyle\sum_k y_k=\sum_k xy_k\text{ を全ての }(l,j)\text{ へ同時適用}\bigr)\\
&= \sum_{l=1}^{n}\sum_{j=1}^{r}\sum_{k=1}^{s} (a_jb_k)\bigl((X_j)_{pl}(W_k)_{lq}\bigr)
 + \sum_{l=1}^{n}\sum_{j=1}^{r}\sum_{k=1}^{s} (a_jb_k)\bigl((W_k)_{pl}(X_j)_{lq}\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律を全ての項へ同時適用。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{j=1}^{r}\sum_{l=1}^{n}\sum_{k=1}^{s} (a_jb_k)\bigl((X_j)_{pl}(W_k)_{lq}\bigr)
 + \sum_{j=1}^{r}\sum_{l=1}^{n}\sum_{k=1}^{s} (a_jb_k)\bigl((W_k)_{pl}(X_j)_{lq}\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の有限和の順序交換（}l\text{ と }j\text{）を 2 箇所へ同時適用}\bigr)\\
&= \sum_{j=1}^{r}\sum_{k=1}^{s}\sum_{l=1}^{n} (a_jb_k)\bigl((X_j)_{pl}(W_k)_{lq}\bigr)
 + \sum_{j=1}^{r}\sum_{k=1}^{s}\sum_{l=1}^{n} (a_jb_k)\bigl((W_k)_{pl}(X_j)_{lq}\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の有限和の順序交換（}l\text{ と }k\text{）を各 }j\text{ の 2 箇所へ同時適用}\bigr)\\
&= \sum_{j=1}^{r}\Bigl(\sum_{k=1}^{s}\sum_{l=1}^{n} (a_jb_k)\bigl((X_j)_{pl}(W_k)_{lq}\bigr)
 + \sum_{k=1}^{s}\sum_{l=1}^{n} (a_jb_k)\bigl((W_k)_{pl}(X_j)_{lq}\bigr)\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_complex_sums}\text{ を右辺から左辺へ（外側の }j\text{）}\bigr)\\
&= \sum_{j=1}^{r}\sum_{k=1}^{s}\Bigl(\sum_{l=1}^{n} (a_jb_k)\bigl((X_j)_{pl}(W_k)_{lq}\bigr)
 + \sum_{l=1}^{n} (a_jb_k)\bigl((W_k)_{pl}(X_j)_{lq}\bigr)\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_complex_sums}\text{ を右辺から左辺へ、各 }j\text{ の内側の }k\text{ へ同時適用}\bigr)\\
&= \sum_{j=1}^{r}\sum_{k=1}^{s}\Bigl((a_jb_k)\sum_{l=1}^{n} (X_j)_{pl}(W_k)_{lq}
 + (a_jb_k)\sum_{l=1}^{n} (W_k)_{pl}(X_j)_{lq}\Bigr)
&&\bigl(\because\ \mathbb{C}\text{ の有限和の分配則 }\textstyle\sum_l cx_l=c\sum_l x_l\text{ を全ての }(j,k)\text{ の 2 箇所へ同時適用}\bigr)\\
&= \sum_{j=1}^{r}\sum_{k=1}^{s}(a_jb_k)\Bigl(\sum_{l=1}^{n} (X_j)_{pl}(W_k)_{lq}
 + \sum_{l=1}^{n} (W_k)_{pl}(X_j)_{lq}\Bigr)
&&\bigl(\because\ \mathbb{C}\text{ の分配法則 }ca+cb=c(a+b)\text{。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \sum_{j=1}^{r}\sum_{k=1}^{s}(a_jb_k)\bigl((X_jW_k)_{pq} + (W_kX_j)_{pq}\bigr)
&&\bigl(\because\ \blkref{mat_mult}\text{ を全ての項へ同時適用}\bigr)\\
&= \sum_{j=1}^{r}\sum_{k=1}^{s}(a_jb_k)\,(X_jW_k + W_kX_j)_{pq}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= \sum_{j=1}^{r}\sum_{k=1}^{s}(a_jb_k)\,\bigl([X_j, W_k]_+\bigr)_{pq}
&&\bigl(\because\ \blkref{def_matrix_anticommutator}\bigr)\\
&= \sum_{j=1}^{r}\sum_{k=1}^{s}\bigl((a_jb_k)[X_j, W_k]_+\bigr)_{pq}
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\bigr)\\
&= \sum_{j=1}^{r}\Bigl(\sum_{k=1}^{s}(a_jb_k)[X_j, W_k]_+\Bigr)_{pq}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\text{ を各 }j\text{ へ同時適用}\bigr)\\
&= \Bigl(\sum_{j=1}^{r}\sum_{k=1}^{s}(a_jb_k)[X_j, W_k]_+\Bigr)_{pq}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（全証明の SageMath 検算 anticommutator_of_check_Z_Y）: 原文（Typst）に対応ブロックは無い。anticommutator_of_check_Z_Y の証明が「反交換子の ℂ 双線型性」と名前だけで根拠にしていた二重和への展開を、引けるよう足した。Lean は Ising2D.acomm_sum_smul（ClaimCommutatorViaAnticommutators.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_zero_matrix_is_left_zero_of_mat_mult",
    kind: "claim",
    title: { text: "零行列を左から掛けると零行列" },
    labels: ["zero_matrix_is_left_zero_of_mat_mult"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。",
        math(String.raw`O_{m,n} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`O_{m,p} \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`O_{m,n}\,B = O_{m,p}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(O_{m,n}\,B\bigr)_{ik}
&= \sum_{j=1}^{n} \bigl(O_{m,n}\bigr)_{ij}\,B_{jk}
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} 0_{\mathbb{C}}\,B_{jk}
&&\bigl(\because\ \blkref{def_zero_matrix}\ \text{を各項へ}\bigr)\\
&= \sum_{j=1}^{n} 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_zero_times_is_zero}\ (z \to B_{jk})\ \text{を各項へ}\bigr)\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{finite_sum_of_complex_zeros}\ (m \to n)\bigr)\\
&= \bigl(O_{m,p}\bigr)_{ik}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_number_operator_idempotent (3) の末尾が「零元との積」を名前だけで根拠にしていたので足した。Lean は具体版 Ising2D.zero_matrix_mul（ClaimZeroMatrixProductAndSumEquations.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_zero_matrix_is_right_zero_of_mat_mult",
    kind: "claim",
    title: { text: "零行列を右から掛けると零行列" },
    labels: ["zero_matrix_is_right_zero_of_mat_mult"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。",
        math(String.raw`O_{n,p} \in \mathrm{Mat}(n,p,\mathbb{C})`),
        "、",
        math(String.raw`O_{m,p} \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`A\,O_{n,p} = O_{m,p}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\,O_{n,p}\bigr)_{ik}
&= \sum_{j=1}^{n} A_{ij}\,\bigl(O_{n,p}\bigr)_{jk}
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&= \sum_{j=1}^{n} A_{ij}\,0_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_zero_matrix}\ \text{を各項へ}\bigr)\\
&= \sum_{j=1}^{n} 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z \to A_{ij})\ \text{を各項へ}\bigr)\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{finite_sum_of_complex_zeros}\ (m \to n)\bigr)\\
&= \bigl(O_{m,p}\bigr)_{ik}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 1 の最後の行が「零行列は行列積の零元」を名前だけで根拠にしていたので足した。Lean は具体版 Ising2D.matrix_mul_zero_matrix（ClaimZeroMatrixIsRightZeroOfMatMult.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_finite_product_of_matrices",
    kind: "definition",
    title: { text: "行列の有限積" },
    labels: ["def_finite_product_of_matrices"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A_1,\dots,A_r \in \mathrm{Mat}(n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）について、有限積 ",
        math(String.raw`\prod_{j=1}^{r} A_j \in \mathrm{Mat}(n,\mathbb{C})`),
        " を ",
        math(String.raw`r`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\prod_{j=1}^{1} A_j := A_1,
\qquad
\prod_{j=1}^{r+1} A_j := \Bigl(\prod_{j=1}^{r} A_j\Bigr)\, A_{r+1}`),
      paragraph([
        "と定める（左から順に掛ける）。積は ",
        ref("mat_mult"),
        "（",
        math(String.raw`m, n, p \to n`),
        "）の行列の積である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Q̌_ε をはじめ本文が行列の有限積を使っていたが、定めるブロックが無かった。" +
          "複素数の有限積（def_finite_product_of_complex_numbers）・行列の有限和（def_finite_sum_of_matrices）と同じ形で定めた。Lean は Ising2D.finiteMatrixProduct（DefinitionFiniteProductOfMatrices.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_product_of_identity_matrices",
    kind: "claim",
    title: { text: "単位行列の有限積は単位行列" },
    labels: ["finite_product_of_identity_matrices"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(String.raw`\prod_{j=1}^{r} I_{\mathrm{Mat}(n,\mathbb{C})} = I_{\mathrm{Mat}(n,\mathbb{C})}`),
      paragraph([
        "が成り立つ。有限積は ",
        ref("def_finite_product_of_matrices"),
        "（",
        math(String.raw`A_1 = \dots = A_r = I_{\mathrm{Mat}(n,\mathbb{C})}`),
        "）、単位行列は ",
        ref("def_identity_matrix"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`r`), " についての帰納法で示す。", math(String.raw`r = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} I_{\mathrm{Mat}(n,\mathbb{C})}
&= I_{\mathrm{Mat}(n,\mathbb{C})}
&&(\because\ \blkref{def_finite_product_of_matrices})
\end{aligned}`),
      paragraph([math(String.raw`r`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{r+1} I_{\mathrm{Mat}(n,\mathbb{C})}
&= \Bigl(\prod_{j=1}^{r} I_{\mathrm{Mat}(n,\mathbb{C})}\Bigr)\, I_{\mathrm{Mat}(n,\mathbb{C})}
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= I_{\mathrm{Mat}(n,\mathbb{C})}\, I_{\mathrm{Mat}(n,\mathbb{C})}
&&(\because\ \text{帰納法の仮定})\\
&= I_{\mathrm{Mat}(n,\mathbb{C})}
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (m, n \to n,\ A \to I_{\mathrm{Mat}(n,\mathbb{C})})\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 2 の最後の行が「単位行列の有限積は単位行列」を名前だけで根拠にしていたので足した。Lean は具体版 Ising2D.finite_product_of_identity_matrices（DefinitionFiniteProductOfMatrices.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_sum_over_binary_words",
    kind: "definition",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の行列の和}` },
    labels: ["def_sum_over_binary_words"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{Z}_{\geq 1}`),
        " について、",
        math(String.raw`\{0,1\} \subset \mathbb{Z}`),
        " とし、",
        math(String.raw`\{0,1\}^{r}`),
        " は写像 ",
        math(String.raw`\epsilon : \{1,\dots,r\} \to \{0,1\}`),
        " の全体とし、",
        math(String.raw`\epsilon`),
        " を ",
        math(String.raw`(\epsilon_1,\dots,\epsilon_r)`),
        "（",
        math(String.raw`\epsilon_j := \epsilon(j)`),
        "）と書く。",
        math(String.raw`\epsilon' \in \{0,1\}^{r}`),
        " と ",
        math(String.raw`e \in \{0,1\}`),
        " に対して、",
        math(String.raw`(\epsilon', e) \in \{0,1\}^{r+1}`),
        " を",
      ]),
      displayMath(String.raw`(\epsilon', e)_j := \epsilon'_j \quad (j \in \{1,\dots,r\}),
\qquad
(\epsilon', e)_{r+1} := e`),
      paragraph([
        "と定める。",
        math(String.raw`\{0,1\}^{1}`),
        " の元は ",
        math(String.raw`(1)`),
        "（",
        math(String.raw`(1)_1 = 1`),
        "）と ",
        math(String.raw`(0)`),
        "（",
        math(String.raw`(0)_1 = 0`),
        "）の二つである。",
      ]),
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        " と、",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`B_\epsilon \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）について、和 ",
        math(String.raw`\sum_{\epsilon \in \{0,1\}^{r}} B_\epsilon \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " を ",
        math(String.raw`r`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\sum_{\epsilon \in \{0,1\}^{1}} B_\epsilon := B_{(1)} + B_{(0)},
\qquad
\sum_{\epsilon \in \{0,1\}^{r+1}} B_\epsilon := \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(B_{(\epsilon',1)} + B_{(\epsilon',0)}\Bigr)`),
      paragraph([
        "と定める（右辺の和は ",
        math(String.raw`\epsilon' \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`B_{(\epsilon',1)} + B_{(\epsilon',0)}`),
        " の和である）。和 ",
        math(String.raw`+`),
        " は ",
        ref("def_matrix_sum"),
        " の行列の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の (2) の Σ_{ε∈{0,1}^𝓜̌} Q̌_ε と Step 2 の「可換な有限個の因子の積の分配法則による展開」が、{0,1}^𝓜̌ の上の和の足す順序を定めずに使っていたので足した。" +
          "最後の成分で 1 を 0 より先に置くのは、展開する因子 R_μ^{(1)} + R_μ^{(0)} の並びに合わせたためである。Lean は Ising2D.binaryWordMatrixSum（DefinitionSumOverBinaryWords.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_sum_over_binary_words_of_complex_numbers",
    kind: "definition",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の複素数の和}` },
    labels: ["def_sum_over_binary_words_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{Z}_{\geq 1}`),
        " について、",
        math(String.raw`\{0,1\}^{r}`),
        " と ",
        math(String.raw`(\epsilon', e) \in \{0,1\}^{r+1}`),
        "（",
        math(String.raw`\epsilon' \in \{0,1\}^{r}`),
        "、",
        math(String.raw`e \in \{0,1\}`),
        "）は ",
        ref("def_sum_over_binary_words"),
        " のものとする。",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`z_\epsilon \in \mathbb{C}`),
        " について、和 ",
        math(String.raw`\sum_{\epsilon \in \{0,1\}^{r}} z_\epsilon \in \mathbb{C}`),
        " を ",
        math(String.raw`r`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\sum_{\epsilon \in \{0,1\}^{1}} z_\epsilon := z_{(1)} + z_{(0)},
\qquad
\sum_{\epsilon \in \{0,1\}^{r+1}} z_\epsilon := \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(z_{(\epsilon',1)} + z_{(\epsilon',0)}\Bigr)`),
      paragraph([
        "と定める（右辺の和は ",
        math(String.raw`\epsilon' \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`z_{(\epsilon',1)} + z_{(\epsilon',0)}`),
        " の和である）。和 ",
        math(String.raw`+`),
        " は ",
        ref("definition_of_cc"),
        " の複素数の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 1 が {0,1}^𝓜̌ で添字付けられた複素数 tr(V̌'Q̌_ε) を足していたが、def_sum_over_binary_words は行列の和しか定めないので足した。足す順序は def_sum_over_binary_words と同じ（最後の成分で 1 を 0 より先に足す）。Lean の具体版は Ising2D.binaryWordComplexSum（DefinitionSumOverBinaryWords.lean）で、TensorPow M の鎖では同じ 2 つの節を持つ必要十分版 Ising2D.NecSuf.binWordSum（α := ℂ）を使う（一致は binaryWordComplexSum_eq_binWordSum）。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_sum_over_binary_words_of_real_numbers",
    kind: "definition",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の実数の和}` },
    labels: ["def_sum_over_binary_words_of_real_numbers"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{Z}_{\geq 1}`),
        " について、",
        math(String.raw`\{0,1\}^{r}`),
        " と ",
        math(String.raw`(\epsilon', e) \in \{0,1\}^{r+1}`),
        "（",
        math(String.raw`\epsilon' \in \{0,1\}^{r}`),
        "、",
        math(String.raw`e \in \{0,1\}`),
        "）は ",
        ref("def_sum_over_binary_words"),
        " のものとする。",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`x_\epsilon \in \mathbb{R}`),
        " について、和 ",
        math(String.raw`\sum_{\epsilon \in \{0,1\}^{r}} x_\epsilon \in \mathbb{R}`),
        " を ",
        math(String.raw`r`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\sum_{\epsilon \in \{0,1\}^{1}} x_\epsilon := x_{(1)} + x_{(0)},
\qquad
\sum_{\epsilon \in \{0,1\}^{r+1}} x_\epsilon := \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(x_{(\epsilon',1)} + x_{(\epsilon',0)}\Bigr)`),
      paragraph([
        "と定める（右辺の和は ",
        math(String.raw`\epsilon' \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`x_{(\epsilon',1)} + x_{(\epsilon',0)}`),
        " の和である）。和 ",
        math(String.raw`+`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の和である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 2 が {0,1}^𝓜̌ で添字付けられた実数 exp(ǧ(ε)) を足していたが、本文は ℂ の和（def_sum_over_binary_words_of_complex_numbers）しか定めていなかったので足した。足す順序は def_sum_over_binary_words と同じ（最後の成分で 1 を 0 より先に足す）。Lean の具体版は Ising2D.binaryWordRealSum（DefinitionSumOverBinaryWords.lean）で、必要十分版 Ising2D.NecSuf.binWordSum（α := ℝ）との一致は binaryWordRealSum_eq_binWordSum。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_real_inclusion_preserves_sum_over_binary_words",
    kind: "claim",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の実数の和の包含は、包含の和に等しい}` },
    labels: ["real_inclusion_preserves_sum_over_binary_words"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`x_\epsilon \in \mathbb{R}`),
        " とする。",
        math(String.raw`s_{\mathbb{C}}`),
        "（",
        math(String.raw`s \in \mathbb{R}`),
        "）は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。このとき",
      ]),
      displayMath(String.raw`\sum_{\epsilon \in \{0,1\}^{r}} (x_\epsilon)_{\mathbb{C}} = \Bigl(\sum_{\epsilon \in \{0,1\}^{r}} x_\epsilon\Bigr)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。左辺の和は ",
        ref("def_sum_over_binary_words_of_complex_numbers"),
        "、右辺の和は ",
        ref("def_sum_over_binary_words_of_real_numbers"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、",
        math(String.raw`\{0,1\}^{r}`),
        " で添字付けられた実数の全ての族について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{1}} (x_\epsilon)_{\mathbb{C}}
&= (x_{(1)})_{\mathbb{C}} + (x_{(0)})_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_complex_numbers}\bigr)\\
&= \bigl(x_{(1)} + x_{(0)}\bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to x_{(1)},\ b \to x_{(0)})\bigr)\\
&= \Bigl(\sum_{\epsilon \in \{0,1\}^{1}} x_\epsilon\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で、",
        math(String.raw`\{0,1\}^{r}`),
        " で添字付けられた実数の全ての族について成り立つと仮定する。",
        math(String.raw`\epsilon \in \{0,1\}^{r+1}`),
        " で添字付けられた ",
        math(String.raw`x_\epsilon \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{r+1}} (x_\epsilon)_{\mathbb{C}}
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl((x_{(\epsilon',1)})_{\mathbb{C}} + (x_{(\epsilon',0)})_{\mathbb{C}}\Bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_complex_numbers}\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \bigl(x_{(\epsilon',1)} + x_{(\epsilon',0)}\bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to x_{(\epsilon',1)},\ b \to x_{(\epsilon',0)})\ \text{を各項へ同時に}\bigr)\\
&= \Bigl(\sum_{\epsilon' \in \{0,1\}^{r}} \bigl(x_{(\epsilon',1)} + x_{(\epsilon',0)}\bigr)\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \text{帰納法の仮定}\ (x_{\epsilon'} \to x_{(\epsilon',1)} + x_{(\epsilon',0)})\bigr)\\
&= \Bigl(\sum_{\epsilon \in \{0,1\}^{r+1}} x_\epsilon\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 1 は ℂ の和 Σ_ε (exp(ǧ(ε)))_ℂ で終わり、Step 2 は ℝ の和 Σ_ε exp(ǧ(ε)) から始まっていて、二つをつなぐ行が無かったので足した。real_inclusion_preserves_finite_sum の {0,1}^r 版である。Lean の具体版は Ising2D.binaryWordComplexSum_ofReal（ClaimRealInclusionPreservesSumOverBinaryWords.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_real_sum_over_binary_words_distributes_in_left_factor",
    kind: "claim",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の実数の和に右から実数を掛けると、各項に掛けた和になる}` },
    labels: ["real_sum_over_binary_words_distributes_in_left_factor"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`x_\epsilon \in \mathbb{R}`),
        "、",
        math(String.raw`c \in \mathbb{R}`),
        " とする。和は ",
        ref("def_sum_over_binary_words_of_real_numbers"),
        "、積は ",
        math(String.raw`\mathbb{R}`),
        " の積である。このとき",
      ]),
      displayMath(String.raw`\Bigl(\sum_{\epsilon \in \{0,1\}^{r}} x_\epsilon\Bigr) c = \sum_{\epsilon \in \{0,1\}^{r}} x_\epsilon c`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、",
        math(String.raw`\{0,1\}^{r}`),
        " で添字付けられた実数の全ての族について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{\epsilon \in \{0,1\}^{1}} x_\epsilon\Bigr) c
&= \bigl(x_{(1)} + x_{(0)}\bigr) c
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_real_numbers}\bigr)\\
&= x_{(1)} c + x_{(0)} c
&&\bigl(\because\ \mathbb{R}\ \text{の分配則}\ (a + b)c = ac + bc\ (a \to x_{(1)},\ b \to x_{(0)})\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{1}} x_\epsilon c
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_real_numbers}\ (x_\epsilon \to x_\epsilon c)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で全ての族について成り立つと仮定する。",
        math(String.raw`\{0,1\}^{r+1}`),
        " で添字付けられた族 ",
        math(String.raw`x_\epsilon`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{\epsilon \in \{0,1\}^{r+1}} x_\epsilon\Bigr) c
&= \Bigl(\sum_{\epsilon' \in \{0,1\}^{r}} \bigl(x_{(\epsilon',1)} + x_{(\epsilon',0)}\bigr)\Bigr) c
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_real_numbers}\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \bigl(x_{(\epsilon',1)} + x_{(\epsilon',0)}\bigr) c
&&\bigl(\because\ \text{帰納法の仮定}\ (x_{\epsilon'} \to x_{(\epsilon',1)} + x_{(\epsilon',0)})\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \bigl(x_{(\epsilon',1)} c + x_{(\epsilon',0)} c\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則}\ (a + b)c = ac + bc\ (a \to x_{(\epsilon',1)},\ b \to x_{(\epsilon',0)})\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{r+1}} x_\epsilon c
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_real_numbers}\ (x_\epsilon \to x_\epsilon c)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。expansion_of_finite_product_of_two_term_sums_of_real_numbers の帰納法の段が使うので足した。sum_over_binary_words_distributes_in_left_factor（行列）と同じ帰納法で、項と掛ける数を実数にしたもの。Lean は具体版 Ising2D.binaryWordRealSum_mul（ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers.lean）。数値検証: sagemath/check/real_sum_over_binary_words_distributes_in_left_factor/。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_expansion_of_finite_product_of_two_term_sums_of_real_numbers",
    kind: "claim",
    title: { text: "実数の二項の和の有限積の展開" },
    labels: ["expansion_of_finite_product_of_two_term_sums_of_real_numbers"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`j \in \{1,\dots,r\}`),
        " と ",
        math(String.raw`e \in \{0,1\}`),
        " で添字付けられた ",
        math(String.raw`a_j^{(e)} \in \mathbb{R}`),
        " とする。有限積は ",
        ref("def_finite_product_of_real_numbers"),
        "、",
        math(String.raw`\{0,1\}^{r}`),
        " の上の和は ",
        ref("def_sum_over_binary_words_of_real_numbers"),
        "、和 ",
        math(String.raw`a_j^{(1)} + a_j^{(0)}`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の和による。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{r} \Bigl(a_j^{(1)} + a_j^{(0)}\Bigr) = \sum_{\epsilon \in \{0,1\}^{r}} \prod_{j=1}^{r} a_j^{(\epsilon_j)}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、実数の全ての族 ",
        math(String.raw`(a_j^{(e)})`),
        " について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} \Bigl(a_j^{(1)} + a_j^{(0)}\Bigr)
&= a_1^{(1)} + a_1^{(0)}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (m \to 1,\ r_j \to a_j^{(1)} + a_j^{(0)})\bigr)\\
&= a_1^{((1)_1)} + a_1^{((0)_1)}
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ \text{の}\ (1)_1 = 1,\ (0)_1 = 0\bigr)\\
&= \prod_{j=1}^{1} a_j^{((1)_j)} + \prod_{j=1}^{1} a_j^{((0)_j)}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (m \to 1,\ r_j \to a_j^{((1)_j)},\ r_j \to a_j^{((0)_j)})\ \text{を右辺から左辺へ 2 か所}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{1}} \prod_{j=1}^{1} a_j^{(\epsilon_j)}
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_real_numbers}\ (x_\epsilon \to \textstyle\prod_{j=1}^{1} a_j^{(\epsilon_j)})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で全ての族について成り立つと仮定する。",
        math(String.raw`j \in \{1,\dots,r+1\}`),
        " で添字付けられた族 ",
        math(String.raw`(a_j^{(e)})`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{r+1} \Bigl(a_j^{(1)} + a_j^{(0)}\Bigr)
&= \Bigl(\prod_{j=1}^{r} \Bigl(a_j^{(1)} + a_j^{(0)}\Bigr)\Bigr)\Bigl(a_{r+1}^{(1)} + a_{r+1}^{(0)}\Bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (m \to r,\ r_j \to a_j^{(1)} + a_j^{(0)})\bigr)\\
&= \Bigl(\sum_{\epsilon' \in \{0,1\}^{r}} \prod_{j=1}^{r} a_j^{(\epsilon'_j)}\Bigr)\Bigl(a_{r+1}^{(1)} + a_{r+1}^{(0)}\Bigr)
&&\bigl(\because\ \text{帰納法の仮定}\ (a_j^{(e)} \to a_j^{(e)}\ (j \in \{1,\dots,r\}))\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\prod_{j=1}^{r} a_j^{(\epsilon'_j)}\Bigr)\Bigl(a_{r+1}^{(1)} + a_{r+1}^{(0)}\Bigr)
&&\bigl(\because\ \blkref{real_sum_over_binary_words_distributes_in_left_factor}\ (x_{\epsilon'} \to \textstyle\prod_{j=1}^{r} a_j^{(\epsilon'_j)},\ c \to a_{r+1}^{(1)} + a_{r+1}^{(0)})\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\Bigl(\prod_{j=1}^{r} a_j^{(\epsilon'_j)}\Bigr) a_{r+1}^{(1)} + \Bigl(\prod_{j=1}^{r} a_j^{(\epsilon'_j)}\Bigr) a_{r+1}^{(0)}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則}\ a(b + c) = ab + ac\ (a \to \textstyle\prod_{j=1}^{r} a_j^{(\epsilon'_j)},\ b \to a_{r+1}^{(1)},\ c \to a_{r+1}^{(0)})\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\Bigl(\prod_{j=1}^{r} a_j^{((\epsilon',1)_j)}\Bigr) a_{r+1}^{((\epsilon',1)_{r+1})} + \Bigl(\prod_{j=1}^{r} a_j^{((\epsilon',0)_j)}\Bigr) a_{r+1}^{((\epsilon',0)_{r+1})}\Bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ \text{の}\ (\epsilon', e)_j = \epsilon'_j\ (j \leq r),\ (\epsilon', e)_{r+1} = e\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\prod_{j=1}^{r+1} a_j^{((\epsilon',1)_j)} + \prod_{j=1}^{r+1} a_j^{((\epsilon',0)_j)}\Bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (m \to r,\ r_j \to a_j^{((\epsilon',e)_j)})\ \text{を右辺から左辺へ、各項の 2 か所へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{r+1}} \prod_{j=1}^{r+1} a_j^{(\epsilon_j)}
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_real_numbers}\ (x_\epsilon \to \textstyle\prod_{j=1}^{r+1} a_j^{(\epsilon_j)})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 2 が Σ_ε exp(ǧ(ε)) = Π_μ(exp(−γ/2) + exp(γ/2)) を「有限個の因子の積の展開」と名前だけで根拠にしていた。本文の展開の主張 expansion_of_finite_product_of_two_term_sums は行列の主張なので、因子を実数にした同じ帰納法を足した。Lean は具体版 Ising2D.expansion_of_finite_product_of_two_term_sums_of_real（ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers.lean）、必要十分版は行列の場合と同じ Ising2D.NecSuf.finProdLeft_add_eq_binWordSum（R := ℝ）。数値検証: sagemath/check/expansion_of_finite_product_of_two_term_sums_of_real_numbers/。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_sum_over_binary_words_distributes_in_left_factor",
    kind: "claim",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の和に右から行列を掛けると、各項に掛けた和になる}` },
    labels: ["sum_over_binary_words_distributes_in_left_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`X_\epsilon \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`C \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。和は ",
        ref("def_sum_over_binary_words"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`\Bigl(\sum_{\epsilon \in \{0,1\}^{r}} X_\epsilon\Bigr) C = \sum_{\epsilon \in \{0,1\}^{r}} X_\epsilon C`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、",
        math(String.raw`\{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元の全ての族について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{\epsilon \in \{0,1\}^{1}} X_\epsilon\Bigr) C
&= \bigl(X_{(1)} + X_{(0)}\bigr) C
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (B_\epsilon \to X_\epsilon)\bigr)\\
&= X_{(1)} C + X_{(0)} C
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor}\ (A \to X_{(1)},\ B \to X_{(0)})\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{1}} X_\epsilon C
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (B_\epsilon \to X_\epsilon C)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で全ての族について成り立つと仮定する。",
        math(String.raw`\{0,1\}^{r+1}`),
        " で添字付けられた族 ",
        math(String.raw`X_\epsilon`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{\epsilon \in \{0,1\}^{r+1}} X_\epsilon\Bigr) C
&= \Bigl(\sum_{\epsilon' \in \{0,1\}^{r}} \bigl(X_{(\epsilon',1)} + X_{(\epsilon',0)}\bigr)\Bigr) C
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (B_\epsilon \to X_\epsilon)\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \bigl(X_{(\epsilon',1)} + X_{(\epsilon',0)}\bigr) C
&&\bigl(\because\ \text{帰納法の仮定}\ (X_{\epsilon'} \to X_{(\epsilon',1)} + X_{(\epsilon',0)})\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \bigl(X_{(\epsilon',1)} C + X_{(\epsilon',0)} C\bigr)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor}\ (A \to X_{(\epsilon',1)},\ B \to X_{(\epsilon',0)})\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{r+1}} X_\epsilon C
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (B_\epsilon \to X_\epsilon C)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。expansion_of_finite_product_of_two_term_sums の帰納法の段が使うので足した。Lean は具体版 Ising2D.binaryWordMatrixSum_mul（DefinitionSumOverBinaryWords.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_sum_over_binary_words_distributes_in_right_factor",
    kind: "claim",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の和に左から行列を掛けると、各項に掛けた和になる}` },
    labels: ["sum_over_binary_words_distributes_in_right_factor"],
    statement: [
      paragraph([
        math(String.raw`m, n, p, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`C \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`X_\epsilon \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " とする。和は ",
        ref("def_sum_over_binary_words"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`C \Bigl(\sum_{\epsilon \in \{0,1\}^{r}} X_\epsilon\Bigr) = \sum_{\epsilon \in \{0,1\}^{r}} C X_\epsilon`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、",
        math(String.raw`\{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`\mathrm{Mat}(n,p,\mathbb{C})`),
        " の元の全ての族について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
C \Bigl(\sum_{\epsilon \in \{0,1\}^{1}} X_\epsilon\Bigr)
&= C \bigl(X_{(1)} + X_{(0)}\bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (m \to n,\ n \to p,\ B_\epsilon \to X_\epsilon)\bigr)\\
&= C X_{(1)} + C X_{(0)}
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\ (A \to C,\ B \to X_{(1)},\ C \to X_{(0)})\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{1}} C X_\epsilon
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (n \to p,\ B_\epsilon \to C X_\epsilon)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で全ての族について成り立つと仮定する。",
        math(String.raw`\{0,1\}^{r+1}`),
        " で添字付けられた族 ",
        math(String.raw`X_\epsilon`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
C \Bigl(\sum_{\epsilon \in \{0,1\}^{r+1}} X_\epsilon\Bigr)
&= C \Bigl(\sum_{\epsilon' \in \{0,1\}^{r}} \bigl(X_{(\epsilon',1)} + X_{(\epsilon',0)}\bigr)\Bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (m \to n,\ n \to p,\ B_\epsilon \to X_\epsilon)\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} C \bigl(X_{(\epsilon',1)} + X_{(\epsilon',0)}\bigr)
&&\bigl(\because\ \text{帰納法の仮定}\ (X_{\epsilon'} \to X_{(\epsilon',1)} + X_{(\epsilon',0)})\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \bigl(C X_{(\epsilon',1)} + C X_{(\epsilon',0)}\bigr)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\ (A \to C,\ B \to X_{(\epsilon',1)},\ C \to X_{(\epsilon',0)})\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{r+1}} C X_\epsilon
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (n \to p,\ B_\epsilon \to C X_\epsilon)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 5 の Q̌_{ε'}(Σ_ε y_ε) = Σ_ε Q̌_{ε'}y_ε が「行列の作用の分配法則」を名前だけで根拠にしていたので足した。" +
          "sum_over_binary_words_distributes_in_left_factor と同じ帰納法で、分配を右の因子の側にしたもの。Lean は具体版 Ising2D.mul_binaryWordMatrixSum（DefinitionSumOverBinaryWords.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_sum_over_binary_words_entrywise",
    kind: "claim",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の行列の和の成分は、成分の和に等しい}` },
    labels: ["sum_over_binary_words_entrywise"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`X_\epsilon \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とする。行列の和は ",
        ref("def_sum_over_binary_words"),
        "、右辺の複素数の和は ",
        ref("def_sum_over_binary_words_of_complex_numbers"),
        " による。このとき、",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\Bigl(\sum_{\epsilon \in \{0,1\}^{r}} X_\epsilon\Bigr)_{ik} = \sum_{\epsilon \in \{0,1\}^{r}} (X_\epsilon)_{ik}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、",
        math(String.raw`\{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元の全ての族について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{\epsilon \in \{0,1\}^{1}} X_\epsilon\Bigr)_{ik}
&= \bigl(X_{(1)} + X_{(0)}\bigr)_{ik}
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (B_\epsilon \to X_\epsilon)\bigr)\\
&= (X_{(1)})_{ik} + (X_{(0)})_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{1}} (X_\epsilon)_{ik}
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_complex_numbers}\ (z_\epsilon \to (X_\epsilon)_{ik})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で全ての族について成り立つと仮定する。",
        math(String.raw`\{0,1\}^{r+1}`),
        " で添字付けられた族 ",
        math(String.raw`X_\epsilon`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{\epsilon \in \{0,1\}^{r+1}} X_\epsilon\Bigr)_{ik}
&= \Bigl(\sum_{\epsilon' \in \{0,1\}^{r}} \bigl(X_{(\epsilon',1)} + X_{(\epsilon',0)}\bigr)\Bigr)_{ik}
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (B_\epsilon \to X_\epsilon)\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \bigl(X_{(\epsilon',1)} + X_{(\epsilon',0)}\bigr)_{ik}
&&\bigl(\because\ \text{帰納法の仮定}\ (X_{\epsilon'} \to X_{(\epsilon',1)} + X_{(\epsilon',0)})\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \bigl((X_{(\epsilon',1)})_{ik} + (X_{(\epsilon',0)})_{ik}\bigr)
&&\bigl(\because\ \blkref{def_matrix_sum}\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{r+1}} (X_\epsilon)_{ik}
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_complex_numbers}\ (z_\epsilon \to (X_\epsilon)_{ik})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05: 原文（Typst）に対応ブロックは無い。c_plus_equals_Lambda_half_integer の証明の Step 1 が、u = Σ_ε w_ε と V^{(+)}u = Σ_ε (Λ̌_ε)_ℂ w_ε の第 k 成分を成分の和として読むところを、主張の無い帰納法の散文で済ませていたので足した。" +
          "{1,…,r} の上の和の finite_sum_of_matrices_entrywise に当たる。sum_over_binary_words_distributes_in_right_factor と同じ帰納法。Lean は未形式化。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_sum_over_binary_words_with_one_nonzero_term",
    kind: "claim",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の和で、一つの項以外が零行列なら、和はその項に等しい}` },
    labels: ["sum_over_binary_words_with_one_nonzero_term"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\epsilon' \in \{0,1\}^{r}`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`B_\epsilon \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " とし、",
        math(String.raw`\epsilon \neq \epsilon'`),
        " を満たす全ての ",
        math(String.raw`\epsilon`),
        " について ",
        math(String.raw`B_\epsilon = O`),
        " とする。和は ",
        ref("def_sum_over_binary_words"),
        "、",
        math(String.raw`O \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列である。このとき",
      ]),
      displayMath(String.raw`\sum_{\epsilon \in \{0,1\}^{r}} B_\epsilon = B_{\epsilon'}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\{0,1\}^{r}`),
        " の二つの元は写像なので、",
        math(String.raw`\epsilon = \epsilon'`),
        " は全ての ",
        math(String.raw`j \in \{1,\dots,r\}`),
        " で ",
        math(String.raw`\epsilon_j = \epsilon'_j`),
        " であることを指し、",
        math(String.raw`\epsilon \neq \epsilon'`),
        " はある ",
        math(String.raw`j`),
        " で ",
        math(String.raw`\epsilon_j \neq \epsilon'_j`),
        " であることを指す。",
        math(String.raw`r`),
        " についての帰納法で、全ての ",
        math(String.raw`\epsilon' \in \{0,1\}^{r}`),
        " と、仮定を満たす ",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の元の全ての族について示す。",
      ]),
      paragraph([
        math(String.raw`r = 1`),
        " のとき、",
        math(String.raw`\{0,1\}^{1}`),
        " の元は ",
        math(String.raw`(1)`),
        " と ",
        math(String.raw`(0)`),
        " である（",
        ref("def_sum_over_binary_words"),
        "）。",
        math(String.raw`\epsilon' = (1)`),
        " なら ",
        math(String.raw`(0)_1 = 0 \neq 1 = (1)_1`),
        " なので仮定から ",
        math(String.raw`B_{(0)} = O`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{1}} B_\epsilon
&= B_{(1)} + B_{(0)}
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\bigr)\\
&= B_{(1)} + O
&&\bigl(\because\ B_{(0)} = O\bigr)\\
&= B_{(1)}
&&\bigl(\because\ \blkref{matrix_plus_zero_matrix}\ (X \to B_{(1)})\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\epsilon' = (0)`),
        " なら ",
        math(String.raw`(1)_1 = 1 \neq 0 = (0)_1`),
        " なので仮定から ",
        math(String.raw`B_{(1)} = O`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{1}} B_\epsilon
&= B_{(1)} + B_{(0)}
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\bigr)\\
&= O + B_{(0)}
&&\bigl(\because\ B_{(1)} = O\bigr)\\
&= B_{(0)}
&&\bigl(\because\ \blkref{zero_matrix_plus_matrix}\ (X \to B_{(0)})\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で成り立つと仮定する。",
        math(String.raw`\epsilon' \in \{0,1\}^{r+1}`),
        " と、仮定を満たす ",
        math(String.raw`\{0,1\}^{r+1}`),
        " で添字付けられた族 ",
        math(String.raw`B_\epsilon`),
        " を取る。",
        math(String.raw`\delta \in \{0,1\}^{r}`),
        " を ",
        math(String.raw`\delta_j := \epsilon'_j\ (j \in \{1,\dots,r\})`),
        "、",
        math(String.raw`e := \epsilon'_{r+1} \in \{0,1\}`),
        " と置くと、",
        math(String.raw`(\delta, e)_j = \delta_j = \epsilon'_j\ (j \leq r)`),
        "、",
        math(String.raw`(\delta, e)_{r+1} = e = \epsilon'_{r+1}`),
        " なので ",
        math(String.raw`(\delta, e) = \epsilon'`),
        " である（",
        math(String.raw`(\cdot,\cdot)`),
        " は ",
        ref("def_sum_over_binary_words"),
        " のもの）。",
        math(String.raw`\delta' \in \{0,1\}^{r}`),
        " が ",
        math(String.raw`\delta' \neq \delta`),
        " なら、ある ",
        math(String.raw`j \leq r`),
        " で ",
        math(String.raw`\delta'_j \neq \delta_j`),
        " であり、",
        math(String.raw`e'' \in \{0,1\}`),
        " のどちらについても ",
        math(String.raw`(\delta', e'')_j = \delta'_j \neq \delta_j = \epsilon'_j`),
        " なので ",
        math(String.raw`(\delta', e'') \neq \epsilon'`),
        "、仮定から ",
        math(String.raw`B_{(\delta', e'')} = O`),
        " である。全ての ",
        math(String.raw`\delta' \in \{0,1\}^{r}`),
        " について ",
        math(String.raw`C_{\delta'} := B_{(\delta',1)} + B_{(\delta',0)} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " と置く。",
        math(String.raw`\delta' \neq \delta`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
C_{\delta'}
&= B_{(\delta',1)} + B_{(\delta',0)}
&&\bigl(\because\ C_{\delta'}\ \text{の定義}\bigr)\\
&= O + O
&&\bigl(\because\ B_{(\delta',1)} = O,\ B_{(\delta',0)} = O\bigr)\\
&= O
&&\bigl(\because\ \blkref{matrix_plus_zero_matrix}\ (X \to O)\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\delta' \in \{0,1\}^{r}`),
        " で添字付けられた族 ",
        math(String.raw`C_{\delta'}`),
        " は ",
        math(String.raw`\epsilon' \to \delta`),
        " について帰納法の仮定の前提を満たす。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{r+1}} B_\epsilon
&= \sum_{\delta' \in \{0,1\}^{r}} \Bigl(B_{(\delta',1)} + B_{(\delta',0)}\Bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\bigr)\\
&= \sum_{\delta' \in \{0,1\}^{r}} C_{\delta'}
&&\bigl(\because\ C_{\delta'}\ \text{の定義を各項へ同時適用}\bigr)\\
&= C_\delta
&&\bigl(\because\ \text{帰納法の仮定}\ (\epsilon' \to \delta,\ B_\epsilon \to C_\epsilon)\bigr)\\
&= B_{(\delta,1)} + B_{(\delta,0)}
&&\bigl(\because\ C_\delta\ \text{の定義}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`e = 1`),
        " なら ",
        math(String.raw`(\delta,0)_{r+1} = 0 \neq 1 = \epsilon'_{r+1}`),
        " なので ",
        math(String.raw`(\delta,0) \neq \epsilon'`),
        "、仮定から ",
        math(String.raw`B_{(\delta,0)} = O`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
B_{(\delta,1)} + B_{(\delta,0)}
&= B_{(\delta,1)} + O
&&\bigl(\because\ B_{(\delta,0)} = O\bigr)\\
&= B_{(\delta,1)}
&&\bigl(\because\ \blkref{matrix_plus_zero_matrix}\ (X \to B_{(\delta,1)})\bigr)\\
&= B_{\epsilon'}
&&\bigl(\because\ (\delta,1) = (\delta,e) = \epsilon'\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`e = 0`),
        " なら ",
        math(String.raw`(\delta,1)_{r+1} = 1 \neq 0 = \epsilon'_{r+1}`),
        " なので ",
        math(String.raw`(\delta,1) \neq \epsilon'`),
        "、仮定から ",
        math(String.raw`B_{(\delta,1)} = O`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
B_{(\delta,1)} + B_{(\delta,0)}
&= O + B_{(\delta,0)}
&&\bigl(\because\ B_{(\delta,1)} = O\bigr)\\
&= B_{(\delta,0)}
&&\bigl(\because\ \blkref{zero_matrix_plus_matrix}\ (X \to B_{(\delta,0)})\bigr)\\
&= B_{\epsilon'}
&&\bigl(\because\ (\delta,0) = (\delta,e) = \epsilon'\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 5 の直和の鎖の 1 行目 y_{ε'} = Σ_ε Q̌_{ε'}y_ε が「Step 1 の直交性と冪等性」を名前だけで根拠にしており、" +
          "ε' 以外の項が零の和がその項に等しいことを引ける主張が無かったので足した。Lean は具体版 Ising2D.binaryWordMatrixSum_eq_of_eq_zero（DefinitionSumOverBinaryWords.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_expansion_of_finite_product_of_two_term_sums",
    kind: "claim",
    title: { text: "二項の和の有限積の展開" },
    labels: ["expansion_of_finite_product_of_two_term_sums"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`j \in \{1,\dots,r\}`),
        " と ",
        math(String.raw`e \in \{0,1\}`),
        " で添字付けられた ",
        math(String.raw`A_j^{(e)} \in \mathrm{Mat}(n,\mathbb{C})`),
        " とする。有限積は ",
        ref("def_finite_product_of_matrices"),
        "、",
        math(String.raw`\{0,1\}^{r}`),
        " の上の和は ",
        ref("def_sum_over_binary_words"),
        "、和 ",
        math(String.raw`A_j^{(1)} + A_j^{(0)}`),
        " は ",
        ref("def_matrix_sum"),
        " による。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{r} \Bigl(A_j^{(1)} + A_j^{(0)}\Bigr) = \sum_{\epsilon \in \{0,1\}^{r}} \prod_{j=1}^{r} A_j^{(\epsilon_j)}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、",
        math(String.raw`\mathrm{Mat}(n,\mathbb{C})`),
        " の元の全ての族 ",
        math(String.raw`(A_j^{(e)})`),
        " について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} \Bigl(A_j^{(1)} + A_j^{(0)}\Bigr)
&= A_1^{(1)} + A_1^{(0)}
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (A_j \to A_j^{(1)} + A_j^{(0)})\bigr)\\
&= A_1^{((1)_1)} + A_1^{((0)_1)}
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ \text{の}\ (1)_1 = 1,\ (0)_1 = 0\bigr)\\
&= \prod_{j=1}^{1} A_j^{((1)_j)} + \prod_{j=1}^{1} A_j^{((0)_j)}
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (A_j \to A_j^{((1)_j)},\ A_j \to A_j^{((0)_j)})\ \text{を右辺から左辺へ 2 か所}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{1}} \prod_{j=1}^{1} A_j^{(\epsilon_j)}
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (B_\epsilon \to \textstyle\prod_{j=1}^{1} A_j^{(\epsilon_j)})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で全ての族について成り立つと仮定する。",
        math(String.raw`j \in \{1,\dots,r+1\}`),
        " で添字付けられた族 ",
        math(String.raw`(A_j^{(e)})`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{r+1} \Bigl(A_j^{(1)} + A_j^{(0)}\Bigr)
&= \Bigl(\prod_{j=1}^{r} \Bigl(A_j^{(1)} + A_j^{(0)}\Bigr)\Bigr)\Bigl(A_{r+1}^{(1)} + A_{r+1}^{(0)}\Bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (A_j \to A_j^{(1)} + A_j^{(0)})\bigr)\\
&= \Bigl(\sum_{\epsilon' \in \{0,1\}^{r}} \prod_{j=1}^{r} A_j^{(\epsilon'_j)}\Bigr)\Bigl(A_{r+1}^{(1)} + A_{r+1}^{(0)}\Bigr)
&&\bigl(\because\ \text{帰納法の仮定}\ (A_j^{(e)} \to A_j^{(e)}\ (j \in \{1,\dots,r\}))\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\prod_{j=1}^{r} A_j^{(\epsilon'_j)}\Bigr)\Bigl(A_{r+1}^{(1)} + A_{r+1}^{(0)}\Bigr)
&&\bigl(\because\ \blkref{sum_over_binary_words_distributes_in_left_factor}\ (m, n, p \to n,\ X_{\epsilon'} \to \textstyle\prod_{j=1}^{r} A_j^{(\epsilon'_j)},\ C \to A_{r+1}^{(1)} + A_{r+1}^{(0)})\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\Bigl(\prod_{j=1}^{r} A_j^{(\epsilon'_j)}\Bigr) A_{r+1}^{(1)} + \Bigl(\prod_{j=1}^{r} A_j^{(\epsilon'_j)}\Bigr) A_{r+1}^{(0)}\Bigr)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\ (m, n, p \to n,\ A \to \textstyle\prod_{j=1}^{r} A_j^{(\epsilon'_j)},\ B \to A_{r+1}^{(1)},\ C \to A_{r+1}^{(0)})\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\Bigl(\prod_{j=1}^{r} A_j^{((\epsilon',1)_j)}\Bigr) A_{r+1}^{((\epsilon',1)_{r+1})} + \Bigl(\prod_{j=1}^{r} A_j^{((\epsilon',0)_j)}\Bigr) A_{r+1}^{((\epsilon',0)_{r+1})}\Bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ \text{の}\ (\epsilon', e)_j = \epsilon'_j\ (j \leq r),\ (\epsilon', e)_{r+1} = e\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\prod_{j=1}^{r+1} A_j^{((\epsilon',1)_j)} + \prod_{j=1}^{r+1} A_j^{((\epsilon',0)_j)}\Bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (A_j \to A_j^{((\epsilon',e)_j)})\ \text{を右辺から左辺へ、各項の 2 か所へ同時適用}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{r+1}} \prod_{j=1}^{r+1} A_j^{(\epsilon_j)}
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (B_\epsilon \to \textstyle\prod_{j=1}^{r+1} A_j^{(\epsilon_j)})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 2 が「可換な有限個の因子の積の分配法則による展開」を名前だけで根拠にしていたので足した。" +
          "積は左から掛ける（def_finite_product_of_matrices）ので、因子の可換性は要らない。Lean は具体版 Ising2D.expansion_of_finite_product_of_two_term_sums（ClaimExpansionOfFiniteProductOfTwoTermSums.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_commuting_with_each_factor_commutes_with_finite_product",
    kind: "claim",
    title: { text: "各因子と可換な行列は有限積とも可換" },
    labels: ["matrix_commuting_with_each_factor_commutes_with_finite_product"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X, A_1,\dots,A_r \in \mathrm{Mat}(n,\mathbb{C})`),
        " が、全ての ",
        math(String.raw`j \in \{1,\dots,r\}`),
        " について ",
        math(String.raw`XA_j = A_jX`),
        " を満たすとする。有限積は ",
        ref("def_finite_product_of_matrices"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`X\prod_{j=1}^{r} A_j = \Bigl(\prod_{j=1}^{r} A_j\Bigr)X`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、仮定を満たす全ての ",
        math(String.raw`X`),
        " と族 ",
        math(String.raw`(A_j)`),
        " について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
X\prod_{j=1}^{1} A_j
&= XA_1
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= A_1X
&&(\because\ \text{仮定}\ XA_j = A_jX\ (j \to 1))\\
&= \Bigl(\prod_{j=1}^{1} A_j\Bigr)X
&&(\because\ \blkref{def_finite_product_of_matrices}\ \text{を右辺から左辺へ})
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で成り立つと仮定する。",
        math(String.raw`X, A_1,\dots,A_{r+1}`),
        " が全ての ",
        math(String.raw`j \in \{1,\dots,r+1\}`),
        " について ",
        math(String.raw`XA_j = A_jX`),
        " を満たすとき、",
        math(String.raw`X, A_1,\dots,A_r`),
        " は帰納法の仮定の前提を満たすので",
      ]),
      displayMath(String.raw`\begin{aligned}
X\prod_{j=1}^{r+1} A_j
&= X\Bigl(\Bigl(\prod_{j=1}^{r} A_j\Bigr)A_{r+1}\Bigr)
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= \Bigl(X\prod_{j=1}^{r} A_j\Bigr)A_{r+1}
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to X,\ B \to \textstyle\prod_{j=1}^{r} A_j,\ C \to A_{r+1})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{r} A_j\Bigr)X\Bigr)A_{r+1}
&&(\because\ \text{帰納法の仮定})\\
&= \Bigl(\prod_{j=1}^{r} A_j\Bigr)\bigl(XA_{r+1}\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to \textstyle\prod_{j=1}^{r} A_j,\ B \to X,\ C \to A_{r+1})\bigr)\\
&= \Bigl(\prod_{j=1}^{r} A_j\Bigr)\bigl(A_{r+1}X\bigr)
&&(\because\ \text{仮定}\ XA_j = A_jX\ (j \to r+1))\\
&= \Bigl(\Bigl(\prod_{j=1}^{r} A_j\Bigr)A_{r+1}\Bigr)X
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to \textstyle\prod_{j=1}^{r} A_j,\ B \to A_{r+1},\ C \to X)\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\prod_{j=1}^{r+1} A_j\Bigr)X
&&(\because\ \blkref{def_finite_product_of_matrices}\ \text{を右辺から左辺へ})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 3 の Q̌_εň_ν = ň_νQ̌_ε が「ň_ν と Q̌_ε の全因子の可換性」を名前だけで根拠にしていたので足した。" +
          "Lean は具体版 Ising2D.matrix_commuting_with_each_factor_commutes_with_finite_product（ClaimFiniteProductsOfCommutingMatrices.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_product_of_two_finite_products_of_matrices",
    kind: "claim",
    title: { text: "二つの有限積の積は、因子ごとの積の有限積" },
    labels: ["product_of_two_finite_products_of_matrices"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A_1,\dots,A_r, B_1,\dots,B_r \in \mathrm{Mat}(n,\mathbb{C})`),
        " が、",
        math(String.raw`1 \leq j < i \leq r`),
        " を満たす全ての ",
        math(String.raw`i, j \in \{1,\dots,r\}`),
        " について ",
        math(String.raw`A_iB_j = B_jA_i`),
        " を満たすとする。有限積は ",
        ref("def_finite_product_of_matrices"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`\Bigl(\prod_{j=1}^{r} A_j\Bigr)\Bigl(\prod_{j=1}^{r} B_j\Bigr) = \prod_{j=1}^{r} \bigl(A_jB_j\bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、仮定を満たす全ての族 ",
        math(String.raw`(A_j), (B_j)`),
        " について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\prod_{j=1}^{1} A_j\Bigr)\Bigl(\prod_{j=1}^{1} B_j\Bigr)
&= A_1B_1
&&(\because\ \blkref{def_finite_product_of_matrices}\ \text{を 2 か所})\\
&= \prod_{j=1}^{1} \bigl(A_jB_j\bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (A_j \to A_jB_j)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で成り立つと仮定する。",
        math(String.raw`A_1,\dots,A_{r+1}, B_1,\dots,B_{r+1}`),
        " が ",
        math(String.raw`1 \leq j < i \leq r+1`),
        " で ",
        math(String.raw`A_iB_j = B_jA_i`),
        " を満たすとき、",
        math(String.raw`A_1,\dots,A_r, B_1,\dots,B_r`),
        " は帰納法の仮定の前提を満たす。また ",
        math(String.raw`j \in \{1,\dots,r\}`),
        " なら ",
        math(String.raw`j < r+1`),
        " なので ",
        math(String.raw`A_{r+1}B_j = B_jA_{r+1}`),
        " であり、",
        math(String.raw`X := A_{r+1}`),
        " と ",
        math(String.raw`B_1,\dots,B_r`),
        " は ",
        ref("matrix_commuting_with_each_factor_commutes_with_finite_product"),
        " の前提を満たす。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\prod_{j=1}^{r+1} A_j\Bigr)\Bigl(\prod_{j=1}^{r+1} B_j\Bigr)
&= \Bigl(\Bigl(\prod_{j=1}^{r} A_j\Bigr)A_{r+1}\Bigr)\Bigl(\Bigl(\prod_{j=1}^{r} B_j\Bigr)B_{r+1}\Bigr)
&&(\because\ \blkref{def_finite_product_of_matrices}\ \text{を 2 か所})\\
&= \Bigl(\Bigl(\Bigl(\prod_{j=1}^{r} A_j\Bigr)A_{r+1}\Bigr)\prod_{j=1}^{r} B_j\Bigr)B_{r+1}
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to (\textstyle\prod_{j=1}^{r} A_j)A_{r+1},\ B \to \textstyle\prod_{j=1}^{r} B_j,\ C \to B_{r+1})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{r} A_j\Bigr)\Bigl(A_{r+1}\prod_{j=1}^{r} B_j\Bigr)\Bigr)B_{r+1}
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to \textstyle\prod_{j=1}^{r} A_j,\ B \to A_{r+1},\ C \to \textstyle\prod_{j=1}^{r} B_j)\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{r} A_j\Bigr)\Bigl(\Bigl(\prod_{j=1}^{r} B_j\Bigr)A_{r+1}\Bigr)\Bigr)B_{r+1}
&&\bigl(\because\ \blkref{matrix_commuting_with_each_factor_commutes_with_finite_product}\ (r \to r,\ X \to A_{r+1},\ A_j \to B_j)\bigr)\\
&= \Bigl(\Bigl(\Bigl(\prod_{j=1}^{r} A_j\Bigr)\prod_{j=1}^{r} B_j\Bigr)A_{r+1}\Bigr)B_{r+1}
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to \textstyle\prod_{j=1}^{r} A_j,\ B \to \textstyle\prod_{j=1}^{r} B_j,\ C \to A_{r+1})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{r} \bigl(A_jB_j\bigr)\Bigr)A_{r+1}\Bigr)B_{r+1}
&&(\because\ \text{帰納法の仮定})\\
&= \Bigl(\prod_{j=1}^{r} \bigl(A_jB_j\bigr)\Bigr)\bigl(A_{r+1}B_{r+1}\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to \textstyle\prod_{j=1}^{r} (A_jB_j),\ B \to A_{r+1},\ C \to B_{r+1})\bigr)\\
&= \prod_{j=1}^{r+1} \bigl(A_jB_j\bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (A_j \to A_jB_j)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 1 の Q̌_ε^2 の鎖が「異なる添字の因子の可換性」を名前だけで根拠にしていたので足した。" +
          "要るのは j < i の組の可換性だけで、A_i どうし・B_j どうしの可換性は使わない。Lean は具体版 Ising2D.product_of_two_finite_products_of_matrices（ClaimFiniteProductsOfCommutingMatrices.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_finite_product_of_matrices_omitting_one_index",
    kind: "definition",
    title: { text: "一つの添字を除いた行列の有限積" },
    labels: ["def_finite_product_of_matrices_omitting_one_index"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\nu \in \{1,\dots,r\}`),
        "、",
        math(String.raw`A_1,\dots,A_r \in \mathrm{Mat}(n,\mathbb{C})`),
        " とする。写像 ",
        math(String.raw`s_{r,\nu} : \{1,\dots,r-1\} \to \{1,\dots,r\}`),
        " を",
      ]),
      displayMath(String.raw`s_{r,\nu}(j) := \begin{cases} j & (j < \nu) \\ j + 1 & (\nu \leq j) \end{cases}`),
      paragraph([
        "と定める（",
        math(String.raw`j < \nu`),
        " なら ",
        math(String.raw`j \leq r`),
        "、",
        math(String.raw`\nu \leq j \leq r-1`),
        " なら ",
        math(String.raw`j+1 \leq r`),
        " なので、値は ",
        math(String.raw`\{1,\dots,r\}`),
        " に入る）。そのうえで",
      ]),
      displayMath(String.raw`\prod_{j=1,\ j\neq\nu}^{r} A_j := \prod_{j=1}^{r-1} A_{s_{r,\nu}(j)} \ \in\ \mathrm{Mat}(n,\mathbb{C})`),
      paragraph([
        "と定める。右辺の有限積は ",
        ref("def_finite_product_of_matrices"),
        "（",
        math(String.raw`n \to n,\ r \to r-1,\ A_j \to A_{s_{r,\nu}(j)}`),
        "）による（",
        math(String.raw`r - 1 \geq 1`),
        " なので定まる）。",
        math(String.raw`s_{r,\nu}`),
        " は ",
        math(String.raw`\{1,\dots,r\}`),
        " から ",
        math(String.raw`\nu`),
        " を除いた添字を小さい順に並べるので、左辺は ",
        math(String.raw`A_\nu`),
        " 以外の因子を添字の小さい順に左から掛けた積である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 1・Step 3 が ∏_{μ≠ν} を、添字が {1,…,r} の形でないのに def_finite_product_of_matrices の積として使っていたので足した。" +
          "Lean は Ising2D.finiteMatrixProductOmitting（DefinitionFiniteProductOfMatricesOmittingOneIndex.lean）。s_{r,ν} は Fin.succAbove。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_moving_one_factor_of_finite_product_to_the_end",
    kind: "claim",
    title: { text: "有限積の一つの因子を末尾へ寄せる" },
    labels: ["moving_one_factor_of_finite_product_to_the_end"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\nu \in \{1,\dots,r\}`),
        "、",
        math(String.raw`A_1,\dots,A_r \in \mathrm{Mat}(n,\mathbb{C})`),
        " が、",
        math(String.raw`\nu < j \leq r`),
        " を満たす全ての ",
        math(String.raw`j \in \{1,\dots,r\}`),
        " について ",
        math(String.raw`A_\nu A_j = A_j A_\nu`),
        " を満たすとする。有限積は ",
        ref("def_finite_product_of_matrices"),
        " と ",
        ref("def_finite_product_of_matrices_omitting_one_index"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{r} A_j = \Bigl(\prod_{j=1,\ j\neq\nu}^{r} A_j\Bigr)A_\nu`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、全ての ",
        math(String.raw`\nu \in \{1,\dots,r\}`),
        " と仮定を満たす全ての族 ",
        math(String.raw`(A_j)`),
        " について示す。",
        math(String.raw`r = 2`),
        "、",
        math(String.raw`\nu = 1`),
        " のとき、",
        math(String.raw`s_{2,1}(1) = 2`),
        "（",
        math(String.raw`s_{2,1}`),
        " の定義の ",
        math(String.raw`\nu \leq j`),
        " の場合）なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{2} A_j
&= \Bigl(\prod_{j=1}^{1} A_j\Bigr)A_2
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= A_1A_2
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= A_2A_1
&&(\because\ \text{仮定}\ A_\nu A_j = A_jA_\nu\ (\nu \to 1,\ j \to 2))\\
&= A_{s_{2,1}(1)}A_1
&&(\because\ s_{2,1}(1) = 2)\\
&= \Bigl(\prod_{j=1}^{1} A_{s_{2,1}(j)}\Bigr)A_1
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (r \to 1,\ A_j \to A_{s_{2,1}(j)})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\prod_{j=1,\ j\neq 1}^{2} A_j\Bigr)A_1
&&\bigl(\because\ \blkref{def_finite_product_of_matrices_omitting_one_index}\ (r \to 2,\ \nu \to 1)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r = 2`),
        "、",
        math(String.raw`\nu = 2`),
        " のとき、",
        math(String.raw`s_{2,2}(1) = 1`),
        "（",
        math(String.raw`s_{2,2}`),
        " の定義の ",
        math(String.raw`j < \nu`),
        " の場合）なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{2} A_j
&= \Bigl(\prod_{j=1}^{1} A_j\Bigr)A_2
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= A_1A_2
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= A_{s_{2,2}(1)}A_2
&&(\because\ s_{2,2}(1) = 1)\\
&= \Bigl(\prod_{j=1}^{1} A_{s_{2,2}(j)}\Bigr)A_2
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (r \to 1,\ A_j \to A_{s_{2,2}(j)})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\prod_{j=1,\ j\neq 2}^{2} A_j\Bigr)A_2
&&\bigl(\because\ \blkref{def_finite_product_of_matrices_omitting_one_index}\ (r \to 2,\ \nu \to 2)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r \geq 2`),
        " で成り立つと仮定し、",
        math(String.raw`\nu \in \{1,\dots,r+1\}`),
        " と、",
        math(String.raw`\nu < j \leq r+1`),
        " で ",
        math(String.raw`A_\nu A_j = A_jA_\nu`),
        " を満たす ",
        math(String.raw`A_1,\dots,A_{r+1}`),
        " を取る。",
        math(String.raw`\nu = r+1`),
        " のとき、全ての ",
        math(String.raw`j \in \{1,\dots,r\}`),
        " で ",
        math(String.raw`j < \nu`),
        " なので ",
        math(String.raw`s_{r+1,r+1}(j) = j`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{r+1} A_j
&= \Bigl(\prod_{j=1}^{r} A_j\Bigr)A_{r+1}
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= \Bigl(\prod_{j=1}^{r} A_{s_{r+1,r+1}(j)}\Bigr)A_{r+1}
&&(\because\ s_{r+1,r+1}(j) = j\ (j \in \{1,\dots,r\}))\\
&= \Bigl(\prod_{j=1,\ j\neq r+1}^{r+1} A_j\Bigr)A_{r+1}
&&\bigl(\because\ \blkref{def_finite_product_of_matrices_omitting_one_index}\ (r \to r+1,\ \nu \to r+1)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\nu \leq r`),
        " のとき、",
        math(String.raw`\nu \in \{1,\dots,r\}`),
        " と ",
        math(String.raw`A_1,\dots,A_r`),
        " は帰納法の仮定の前提（",
        math(String.raw`\nu < j \leq r`),
        " で ",
        math(String.raw`A_\nu A_j = A_jA_\nu`),
        "）を満たす。また ",
        math(String.raw`\nu \leq r`),
        " なので ",
        math(String.raw`s_{r+1,\nu}(r) = r+1`),
        "（",
        math(String.raw`\nu \leq j`),
        " の場合）であり、",
        math(String.raw`s_{r+1,\nu}`),
        " と ",
        math(String.raw`s_{r,\nu}`),
        " は同じ式で定まるので ",
        math(String.raw`j \in \{1,\dots,r-1\}`),
        " で ",
        math(String.raw`s_{r+1,\nu}(j) = s_{r,\nu}(j)`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{r+1} A_j
&= \Bigl(\prod_{j=1}^{r} A_j\Bigr)A_{r+1}
&&(\because\ \blkref{def_finite_product_of_matrices})\\
&= \Bigl(\Bigl(\prod_{j=1,\ j\neq\nu}^{r} A_j\Bigr)A_\nu\Bigr)A_{r+1}
&&(\because\ \text{帰納法の仮定}\ (\nu \to \nu,\ A_1,\dots,A_r \to A_1,\dots,A_r))\\
&= \Bigl(\prod_{j=1,\ j\neq\nu}^{r} A_j\Bigr)\bigl(A_\nu A_{r+1}\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to \textstyle\prod_{j=1,\ j\neq\nu}^{r} A_j,\ B \to A_\nu,\ C \to A_{r+1})\bigr)\\
&= \Bigl(\prod_{j=1,\ j\neq\nu}^{r} A_j\Bigr)\bigl(A_{r+1}A_\nu\bigr)
&&(\because\ \text{仮定}\ A_\nu A_j = A_jA_\nu\ (j \to r+1)\text{。}\nu \leq r < r+1)\\
&= \Bigl(\Bigl(\prod_{j=1,\ j\neq\nu}^{r} A_j\Bigr)A_{r+1}\Bigr)A_\nu
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m,n,p,q \to n,\ A \to \textstyle\prod_{j=1,\ j\neq\nu}^{r} A_j,\ B \to A_{r+1},\ C \to A_\nu)\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{r-1} A_{s_{r,\nu}(j)}\Bigr)A_{r+1}\Bigr)A_\nu
&&\bigl(\because\ \blkref{def_finite_product_of_matrices_omitting_one_index}\ (r \to r)\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{r-1} A_{s_{r,\nu}(j)}\Bigr)A_{s_{r+1,\nu}(r)}\Bigr)A_\nu
&&(\because\ s_{r+1,\nu}(r) = r+1)\\
&= \Bigl(\Bigl(\prod_{j=1}^{r-1} A_{s_{r+1,\nu}(j)}\Bigr)A_{s_{r+1,\nu}(r)}\Bigr)A_\nu
&&(\because\ s_{r+1,\nu}(j) = s_{r,\nu}(j)\ (j \in \{1,\dots,r-1\}))\\
&= \Bigl(\prod_{j=1}^{r} A_{s_{r+1,\nu}(j)}\Bigr)A_\nu
&&\bigl(\because\ \blkref{def_finite_product_of_matrices}\ (r \to r-1,\ A_j \to A_{s_{r+1,\nu}(j)})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\prod_{j=1,\ j\neq\nu}^{r+1} A_j\Bigr)A_\nu
&&\bigl(\because\ \blkref{def_finite_product_of_matrices_omitting_one_index}\ (r \to r+1)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 1・Step 3 が「因子の可換性により添字 ν の因子を末尾へ寄せる」「異なる添字の因子の可換性」を名前だけで根拠にしていたので足した。" +
          "要るのは ν < j の組の可換性だけである。Lean は具体版 Ising2D.moving_one_factor_of_finite_product_to_the_end（DefinitionFiniteProductOfMatricesOmittingOneIndex.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_sum_with_itself_zero_implies_zero",
    kind: "claim",
    title: { text: "自分自身との和が零行列なら零行列" },
    labels: ["matrix_sum_with_itself_zero_implies_zero"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " が ",
        math(String.raw`X + X = O`),
        " を満たすとする。和は ",
        ref("def_matrix_sum"),
        "、",
        math(String.raw`O \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列である。このとき",
      ]),
      displayMath(String.raw`X = O`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`2_{\mathbb{C}} := \iota_{\mathbb{R}\to\mathbb{C}}(2)`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}} + 1_{\mathbb{C}}
&= (1,0) + (1,0)
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= (1+1,\ 0+0)
&&\bigl(\because\ \blkref{definition_of_cc}\ \text{の和}\bigr)\\
&= (2,0)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= 2_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
2_{\mathbb{C}}
&= (2,0)
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)\\
&\neq (0,0)
&&(\because\ \text{第 1 成分が}\ 2 \neq 0\ (\mathbb{R}))\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`2_{\mathbb{C}} \neq 0_{\mathbb{C}}`),
        " なので、",
        ref("complex_numbers_form_a_field"),
        " の逆元の存在から ",
        math(String.raw`2_{\mathbb{C}}^{-1} \in \mathbb{C}`),
        " で ",
        math(String.raw`2_{\mathbb{C}}^{-1}\,2_{\mathbb{C}} = 1_{\mathbb{C}}`),
        " となるものが取れる。両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
X_{ik}
&= 1_{\mathbb{C}}\,X_{ik}
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(2_{\mathbb{C}}^{-1}\,2_{\mathbb{C}}\bigr)\,X_{ik}
&&\bigl(\because\ 2_{\mathbb{C}}^{-1}\ \text{の取り方}\bigr)\\
&= 2_{\mathbb{C}}^{-1}\bigl(2_{\mathbb{C}}\,X_{ik}\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の積の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= 2_{\mathbb{C}}^{-1}\bigl((1_{\mathbb{C}} + 1_{\mathbb{C}})\,X_{ik}\bigr)
&&(\because\ \text{上の鎖}\ 1_{\mathbb{C}} + 1_{\mathbb{C}} = 2_{\mathbb{C}}\ \text{を右辺から左辺へ})\\
&= 2_{\mathbb{C}}^{-1}\bigl(1_{\mathbb{C}}\,X_{ik} + 1_{\mathbb{C}}\,X_{ik}\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の分配律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= 2_{\mathbb{C}}^{-1}\bigl(X_{ik} + X_{ik}\bigr)
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元 }\blkref{complex_numbers_form_a_field}\ \text{を 2 か所へ}\bigr)\\
&= 2_{\mathbb{C}}^{-1}\,(X + X)_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= 2_{\mathbb{C}}^{-1}\,O_{ik}
&&(\because\ \text{仮定}\ X + X = O)\\
&= 2_{\mathbb{C}}^{-1}\,0_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z \to 2_{\mathbb{C}}^{-1})\bigr)\\
&= O_{ik}
&&\bigl(\because\ \blkref{def_zero_matrix}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_number_operator_idempotent (1) が「同じ項の和」で X + X を 2X とし、行列に「ℂ の四則」を当てて ½ を掛けていたので、成分の鎖で示すこの主張に置き換えた。Lean は具体版 Ising2D.matrix_eq_zero_of_add_self_eq_zero（ClaimZeroMatrixProductAndSumEquations.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_summand_from_sum_equation",
    kind: "claim",
    title: { text: "和の等式から右の項を差で表す" },
    labels: ["matrix_summand_from_sum_equation"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B, C \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " が ",
        math(String.raw`A + B = C`),
        " を満たすとする。和は ",
        ref("def_matrix_sum"),
        "、差は ",
        ref("def_matrix_difference"),
        " による。このとき",
      ]),
      displayMath(String.raw`B = C - A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
B_{ik}
&= 0_{\mathbb{C}} + B_{ik}
&&\bigl(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl((-A_{ik}) + A_{ik}\bigr) + B_{ik}
&&\bigl(\because\ -A_{ik}\ \text{は}\ A_{ik}\ \text{の加法の逆元 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (-A_{ik}) + \bigl(A_{ik} + B_{ik}\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の加法の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= (-A_{ik}) + (A + B)_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= (-A_{ik}) + C_{ik}
&&(\because\ \text{仮定}\ A + B = C)\\
&= C_{ik} + (-A_{ik})
&&\bigl(\because\ \mathbb{C}\ \text{の加法の交換律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= C_{ik} - A_{ik}
&&\bigl(\because\ \blkref{def_complex_difference}\ \text{を右辺から左辺へ}\bigr)\\
&= (C - A)_{ik}
&&\bigl(\because\ \blkref{def_matrix_difference}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_number_operator_idempotent (2) が行列の等式に「ℂ の四則」を当てて ψ̌ψ̌^† = (ψ̌^†ψ̌ + ψ̌ψ̌^†) - ψ̌^†ψ̌ としていたので、成分の鎖で示すこの主張に置き換えた。Lean は具体版 Ising2D.matrix_eq_sub_of_add_eq（ClaimZeroMatrixProductAndSumEquations.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_plus_difference_cancels",
    kind: "claim",
    title: { text: "行列 A と差 B − A の和は B" },
    labels: ["matrix_plus_difference_cancels"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`A + (B - A) = B`),
      paragraph([
        "が成り立つ。和は ",
        ref("def_matrix_sum"),
        "、差は ",
        ref("def_matrix_difference"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(m,p,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A + (B - A)\bigr)_{ik}
&= A_{ik} + (B - A)_{ik}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)\\
&= A_{ik} + \bigl(B_{ik} - A_{ik}\bigr)
&&\bigl(\because\ \blkref{def_matrix_difference}\bigr)\\
&= A_{ik} + \bigl(B_{ik} + (-A_{ik})\bigr)
&&\bigl(\because\ \blkref{def_complex_difference}\bigr)\\
&= A_{ik} + \bigl((-A_{ik}) + B_{ik}\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{の加法の交換律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(A_{ik} + (-A_{ik})\bigr) + B_{ik}
&&\bigl(\because\ \mathbb{C}\ \text{の加法の結合律 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= 0_{\mathbb{C}} + B_{ik}
&&\bigl(\because\ -A_{ik}\ \text{は}\ A_{ik}\ \text{の加法の逆元 }\blkref{complex_numbers_form_a_field}\bigr)\\
&= B_{ik}
&&\bigl(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元 }\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 0 が R_μ^{(1)} + R_μ^{(0)} = ň_μ + (I − ň_μ) = I を「行列の加法（加法逆元と単位元）」とだけ書いて主張を置かずに使っていたので足した。Lean は具体版 Ising2D.matrix_add_sub_cancel（ClaimMatrixPlusDifferenceCancels.lean）。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_product_of_anticommuting_matrices_commutes",
    kind: "claim",
    title: { text: "反可換な二つの行列の積は可換" },
    labels: ["product_of_anticommuting_matrices_commutes"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`G, X, Y \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`GX = -(XG)`),
        " と ",
        math(String.raw`GY = -(YG)`),
        " を満たすとする。積は ",
        ref("mat_mult"),
        "、符号反転は ",
        ref("def_matrix_negation"),
        " による。このとき",
      ]),
      displayMath(String.raw`G(XY) = (XY)G`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
G(XY)
&= (GX)Y
&&(\because\ \blkref{mat_mult_associative})\\
&= \bigl(-(XG)\bigr)Y
&&(\because\ \text{仮定}\ GX = -(XG))\\
&= -\bigl((XG)Y\bigr)
&&(\because\ \blkref{negation_factors_out_of_left_factor})\\
&= -\bigl(X(GY)\bigr)
&&(\because\ \blkref{mat_mult_associative})\\
&= -\Bigl(X\bigl(-(YG)\bigr)\Bigr)
&&(\because\ \text{仮定}\ GY = -(YG))\\
&= -\Bigl(-\bigl(X(YG)\bigr)\Bigr)
&&(\because\ \blkref{negation_factors_out_of_right_factor})\\
&= X(YG)
&&(\because\ \blkref{matrix_double_negation})\\
&= (XY)G
&&(\because\ \blkref{mat_mult_associative})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算 epsilon_commutes_with_transfer_matrices）: 原文（Typst）に対応ブロックは無い。ε と σ_m^zσ_{m+1}^z、ε と Y_mZ_{m'} の可換性を「反可換性を二回使う」の散文で済ませていたので、一つの主張として切り出した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_commuting_with_scalar_multiple",
    kind: "claim",
    title: { text: "可換な行列のスカラー倍とも可換" },
    labels: ["commuting_with_scalar_multiple"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`G, X \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`GX = XG`),
        " を満たすとする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`G(cX) = (cX)G`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
G(cX)
&= c(GX)
&&(\because\ \blkref{scalar_multiple_factors_out_of_right_factor})\\
&= c(XG)
&&(\because\ \text{仮定}\ GX = XG)\\
&= (cX)G
&&(\because\ \blkref{scalar_multiple_factors_out_of_left_factor})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算 epsilon_commutes_with_transfer_matrices）: 原文（Typst）に対応ブロックは無い。ε と転送行列の可換性の証明が「スカラー倍との可換性」を根拠なしで使っていたので足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_commuting_with_finite_sum",
    kind: "claim",
    title: { text: "可換な行列の有限和とも可換" },
    labels: ["commuting_with_finite_sum"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`G, X_1, \dots, X_r \in \mathrm{Mat}(n,\mathbb{C})`),
        " が、すべての ",
        math(String.raw`j \in \{1,\dots,r\}`),
        " について ",
        math(String.raw`GX_j = X_jG`),
        " を満たすとする。有限和は ",
        ref("def_finite_sum_of_matrices"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`G\Bigl(\sum_{j=1}^{r} X_j\Bigr) = \Bigl(\sum_{j=1}^{r} X_j\Bigr)G`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で示す。",
        math(String.raw`r = 1`),
        " のとき、",
      ]),
      displayMath(String.raw`\begin{aligned}
G\Bigl(\sum_{j=1}^{1} X_j\Bigr)
&= GX_1
&&(\because\ \blkref{def_finite_sum_of_matrices})\\
&= X_1G
&&(\because\ \text{仮定}\ GX_1 = X_1G)\\
&= \Bigl(\sum_{j=1}^{1} X_j\Bigr)G
&&(\because\ \blkref{def_finite_sum_of_matrices})
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で成り立つとし、",
        math(String.raw`X_1,\dots,X_{r+1}`),
        " がすべて ",
        math(String.raw`G`),
        " と可換とする。",
        math(String.raw`X_1,\dots,X_r`),
        " に帰納法の仮定を当てて",
      ]),
      displayMath(String.raw`\begin{aligned}
G\Bigl(\sum_{j=1}^{r+1} X_j\Bigr)
&= G\Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)
&&(\because\ \blkref{def_finite_sum_of_matrices})\\
&= G\Bigl(\sum_{j=1}^{r} X_j\Bigr) + GX_{r+1}
&&(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor})\\
&= \Bigl(\sum_{j=1}^{r} X_j\Bigr)G + GX_{r+1}
&&(\because\ \text{帰納法の仮定})\\
&= \Bigl(\sum_{j=1}^{r} X_j\Bigr)G + X_{r+1}G
&&(\because\ \text{仮定}\ GX_{r+1} = X_{r+1}G)\\
&= \Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)G
&&(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor})\\
&= \Bigl(\sum_{j=1}^{r+1} X_j\Bigr)G
&&(\because\ \blkref{def_finite_sum_of_matrices})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算 epsilon_commutes_with_transfer_matrices）: 原文（Typst）に対応ブロックは無い。ε と転送行列の可換性の証明が「行列積の有限和への分配」で済ませていた段を、有限和の定義による帰納法として足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_commuting_with_difference",
    kind: "claim",
    title: { text: "可換な二つの行列の差とも可換" },
    labels: ["commuting_with_difference"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`G, X, W \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`GX = XG`),
        " と ",
        math(String.raw`GW = WG`),
        " を満たすとする。差は ",
        ref("def_matrix_difference"),
        "、積は ",
        ref("mat_mult"),
        " による。このとき",
      ]),
      displayMath(String.raw`G(X - W) = (X - W)G`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
G(X - W)
&= G\bigl(X + (-W)\bigr)
&&(\because\ \blkref{matrix_difference_is_sum_with_negation})\\
&= GX + G(-W)
&&(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor})\\
&= XG + G(-W)
&&(\because\ \text{仮定}\ GX = XG)\\
&= XG + \bigl(-(GW)\bigr)
&&(\because\ \blkref{negation_factors_out_of_right_factor})\\
&= XG + \bigl(-(WG)\bigr)
&&(\because\ \text{仮定}\ GW = WG)\\
&= XG + (-W)G
&&(\because\ \blkref{negation_factors_out_of_left_factor})\\
&= \bigl(X + (-W)\bigr)G
&&(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor})\\
&= (X - W)G
&&(\because\ \blkref{matrix_difference_is_sum_with_negation})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算 epsilon_commutes_with_transfer_matrices）: 原文（Typst）に対応ブロックは無い。H_1^{(+)} = Σ Y_mZ_{m+1} - Y_{M_col}Z_1 の差の項と ε の可換性を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_000_definition_kronecker_product",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカー積（2 次の複素行列・2 次元数ベクトルの M 個の積）" },
    labels: ["def_kronecker"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とする。各成分が ",
        math(String.raw`1`),
        " か ",
        math(String.raw`2`),
        " である ",
        math(String.raw`M`),
        " 個組の全体",
      ]),
      displayMath(
        String.raw`\mathcal{I}_M := \{1,2\}^M
= \left\{\,(i_1,\dots,i_M) \;\middle|\; i_1,\dots,i_M \in \{1,2\}\,\right\}`,
      ),
      paragraph([
        "を添字集合とする。",
        math(String.raw`\#\mathcal{I}_M = 2^M`),
        " である（下の Step 1）。写像",
      ]),
      displayMath(
        String.raw`\nu : \mathcal{I}_M \to \{1,2,\dots,2^M\},\qquad
\nu(I) := 1 + \sum_{k=1}^{M} (i_k - 1)\,2^{M-k}
\quad (I = (i_1,\dots,i_M))`,
      ),
      paragraph([
        "は全単射である（下の Step 2・Step 3）。以後、",
        math(String.raw`\mathcal{I}_M`),
        " の元 ",
        math(String.raw`I`),
        " を、行番号・列番号 ",
        math(String.raw`\nu(I) \in \{1,\dots,2^M\}`),
        " と同一視して使う。",
      ]),
      paragraph([
        "（1）数ベクトルのクロネッカー積。",
        math(String.raw`v_1,\dots,v_M \in \mathbb{C}^2`),
        " に対し、",
        math(String.raw`v_1 \boxtimes \cdots \boxtimes v_M \in \mathbb{C}^{2^M}`),
        " を成分で",
      ]),
      displayMath(
        String.raw`\left(v_1 \boxtimes \cdots \boxtimes v_M\right)_{\nu(I)}
:= \prod_{k=1}^{M} (v_k)_{i_k}
\qquad (I = (i_1,\dots,i_M) \in \mathcal{I}_M)`,
      ),
      paragraph([
        "と定める（右辺は ",
        ref("def_finite_product_of_complex_numbers"),
        " の複素数の有限積であり、",
        math(String.raw`(v_k)_{i_k}\in\mathbb{C}`),
        " は ",
        math(String.raw`v_k`),
        " の第 ",
        math(String.raw`i_k`),
        " 成分）。",
        math(String.raw`\nu`),
        " が全単射だから、これで ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の元が 1 つ確定する。",
      ]),
      paragraph([
        "（2）行列のクロネッカー積。",
        math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " に対し、",
        math(String.raw`A_1 \boxtimes \cdots \boxtimes A_M \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を成分で",
      ]),
      displayMath(
        String.raw`\left(A_1 \boxtimes \cdots \boxtimes A_M\right)_{\nu(I),\,\nu(J)}
:= \prod_{k=1}^{M} (A_k)_{i_k j_k}
\qquad (I = (i_1,\dots,i_M),\ J = (j_1,\dots,j_M) \in \mathcal{I}_M)`,
      ),
      paragraph([
        "と定める（右辺は ",
        ref("def_finite_product_of_complex_numbers"),
        " の有限積）。これは ",
        math(String.raw`2^M`),
        " 行 ",
        math(String.raw`2^M`),
        " 列の複素行列であって、抽象的なテンソル積ではない。",
      ]),
      paragraph([
        "（3）これらが住む空間。",
        math(String.raw`A_1 \boxtimes \cdots \boxtimes A_M`),
        " は ",
        math(String.raw`2^M`),
        " 次の複素正方行列全体 ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の元、",
        math(String.raw`v_1 \boxtimes \cdots \boxtimes v_M`),
        " は ",
        math(String.raw`2^M`),
        " 次元数ベクトル全体 ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の元である。基底と単位行列に関する帰結は、定義後の成分計算で別に示す。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\nu`),
        " が定義どおりの写像であり全単射であること（定義が意味をもつために必要な事項）を確かめる。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\#\mathcal{I}_M = 2^M`),
        "。",
        math(String.raw`M`),
        " についての帰納法による。",
        math(String.raw`M=1`),
        " のとき ",
        math(String.raw`\mathcal{I}_1=\{(1),(2)\}`),
        " で元数は ",
        math(String.raw`2=2^1`),
        "。",
        math(String.raw`M`),
        " で ",
        math(String.raw`\#\mathcal{I}_M=2^M`),
        " とすると、",
        math(String.raw`\mathcal{I}_{M+1}`),
        " の元は ",
        math(String.raw`(I, i_{M+1})`),
        "（",
        math(String.raw`I\in\mathcal{I}_M`),
        "、",
        math(String.raw`i_{M+1}\in\{1,2\}`),
        "）と一対一に対応するから、次の一続きで ",
        math(String.raw`M+1`),
        " でも成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\#\mathcal{I}_{M+1}
&=\#\mathcal{I}_M\cdot 2
   &&(\because \text{一対一対応で }I\text{ が }\#\mathcal{I}_M\text{ 通り、}i_{M+1}\text{ が }2\text{ 通り}) \\
&=2^M\cdot 2
   &&(\because \text{帰納法の仮定}\ \#\mathcal{I}_M=2^M) \\
&=2^{M+1}
   &&(\because \text{指数法則}\ 2^M\cdot 2=2^{M+1})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: 値域。まず ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\sum_{t=0}^{n-1}2^{t}=2^{n}-1`),
        "（",
        math(String.raw`n=0`),
        " のときは空和で ",
        math(String.raw`0=2^0-1`),
        "、",
        math(String.raw`n`),
        " で成り立てば次の一続きで ",
        math(String.raw`n+1`),
        " でも成り立つ）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{t=0}^{n}2^t
&=\sum_{t=0}^{n-1}2^t+2^n
   &&(\because \text{有限和の最後の項を分ける}) \\
&=(2^n-1)+2^n
   &&(\because \text{帰納法の仮定}\ \textstyle\sum_{t=0}^{n-1}2^{t}=2^{n}-1) \\
&=2\cdot 2^n-1
   &&(\because \text{加法の結合則と }2^n+2^n=2\cdot 2^n) \\
&=2^{n+1}-1
   &&(\because \text{指数法則}\ 2\cdot 2^n=2^{n+1})
\end{aligned}`,
      ),
      paragraph([
        "各 ",
        math(String.raw`k`),
        " について ",
        math(String.raw`i_k-1\in\{0,1\}`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \sum_{k=1}^{M}(i_k-1)2^{M-k}
   &&(\because \text{各項は }0\le i_k-1\text{ と }2^{M-k}>0\text{ の積で非負}) \\
&\le \sum_{k=1}^{M}2^{M-k}
   &&(\because \text{各項で }i_k-1\le 1\text{ かつ }2^{M-k}>0) \\
&= \sum_{t=0}^{M-1}2^{t}
   &&(\because \text{添字の置き換え }t:=M-k) \\
&= 2^{M}-1
   &&(\because \text{上の }\textstyle\sum_{t=0}^{n-1}2^{t}=2^{n}-1\text{ を }n:=M\text{ で})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`1\le\nu(I)\le 2^M`),
        "。よって ",
        math(String.raw`\nu`),
        " は ",
        math(String.raw`\mathcal{I}_M`),
        " から ",
        math(String.raw`\{1,\dots,2^M\}`),
        " への写像である。",
      ]),
      paragraph([
        "Step 3: 単射性、および全単射性。",
        math(String.raw`I=(i_1,\dots,i_M)\neq J=(j_1,\dots,j_M)`),
        " とし、",
        math(String.raw`i_k\neq j_k`),
        " となる最小の ",
        math(String.raw`k`),
        " をとる。必要なら ",
        math(String.raw`I`),
        " と ",
        math(String.raw`J`),
        " を入れ替えて ",
        math(String.raw`i_k=2,\ j_k=1`),
        " としてよい。",
        math(String.raw`l<k`),
        " では ",
        math(String.raw`i_l=j_l`),
        " だから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\nu(I)-\nu(J)
&= \Bigl(1+\sum_{l=1}^{M}(i_l-1)2^{M-l}\Bigr)-\Bigl(1+\sum_{l=1}^{M}(j_l-1)2^{M-l}\Bigr)
   &&(\because \nu\text{ の定義}) \\
&= \sum_{l=1}^{M}(i_l-j_l)2^{M-l}
   &&(\because \text{和の差を項ごとに取る。}(i_l-1)-(j_l-1)=i_l-j_l) \\
&= \sum_{l=k}^{M}(i_l-j_l)2^{M-l}
   &&(\because l<k\text{ では }i_l=j_l\text{ で項が }0) \\
&= 2^{M-k} + \sum_{l=k+1}^{M}(i_l-j_l)2^{M-l}
   &&(\because l=k\text{ の項を分ける。}i_k-j_k=2-1=1)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`i_l-j_l\in\{-1,0,1\}`),
        " より次の一続きが成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\sum_{l=k+1}^{M}(i_l-j_l)2^{M-l}\right|
&\le \sum_{l=k+1}^{M}\left|i_l-j_l\right|2^{M-l}
   &&(\because \text{三角不等式と }2^{M-l}>0) \\
&\le \sum_{l=k+1}^{M}2^{M-l}
   &&(\because \text{各項で }|i_l-j_l|\le 1\text{ かつ }2^{M-l}>0) \\
&= \sum_{t=0}^{M-k-1}2^{t}
   &&(\because \text{添字の置き換え }t:=M-l) \\
&= 2^{M-k}-1
   &&(\because \text{Step 2 の }\textstyle\sum_{t=0}^{n-1}2^{t}=2^{n}-1\text{ を }n:=M-k\text{ で}) \\
&< 2^{M-k}
   &&(\because 2^{M-k}-1<2^{M-k})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\nu(I)-\nu(J)\neq 0`),
        " すなわち ",
        math(String.raw`\nu`),
        " は単射である。Step 1 より ",
        math(String.raw`\#\mathcal{I}_M=2^M=\#\{1,\dots,2^M\}`),
        " であり、有限集合の間の単射で元数が等しいものは全射でもあるから（像は ",
        math(String.raw`2^M`),
        " 個の元をもつ ",
        math(String.raw`\{1,\dots,2^M\}`),
        " の部分集合、すなわち全体）、",
        math(String.raw`\nu`),
        " は全単射である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-09-01 の式変形統一で、全五本の aligned 鎖にある根拠 20 行を" +
          "行中の \\quad (\\because …) から行末の根拠列（aligned の &&）へ揃えた。" +
          "式変形・根拠・段数・参照は変えていない。",
        "2026-08-17: 式変形の書き方の統一。Step 3（単射性）の二つの式（ν(I)−ν(J) の分解と、残りの和の絶対値の評価）を、" +
          "1 行 1 等号の一続きの鎖と行末の (∵ …) へ揃えた（ν の定義から始め、和の差・l<k の項の消去・l=k の項の分離、" +
          "三角不等式・各項の評価・添字の置き換え・Step 2 の等比和・最後の狭義不等号）。内容は不変で、段は増えており減った段は無い。",
        "2026-08-09: 式変形の書き方の統一。Step 0〜3 という番号での区切りを、" +
          "それぞれの中間目標の名前（多重添字の和を各因子ごとの和の積へ直すこと・" +
          "(1) の証明・(2) の証明・(3) の証明）へ変えた（リポジトリの規約「番号や記号で管理しない」）。" +
          "(2) は式のあとに置かれていた日本語の説明（積が 1 になる条件、ν の単射性）を、" +
          "3 段の一続きの鎖の各行末の (∵ …) へ移した。段は増えており、減った段は無い。",
        "原文（Typst）に対応ブロックは無い。原文および旧構造化テキストは ⊗ を抽象テンソル積の記号として" +
          "定義せずに使っていたため、README のゴール設定（M 個の 2×2 行列の積は具体的な 2^M × 2^M の" +
          "複素行列として専用記号で定義する）に従い、成分の式によるクロネッカー積 ⊠ を本文に置いた。" +
          "移行期には既存章の ⊗ をこの ⊠ の別記法として同一視する注記を置いていたが、" +
          "本文全章の書き換えが完了したので同一視の注記は削除した（本文に ⊗ はもう現れない）。",
      ],
    },
  },
  {
    id: "linear_space_general_000b_claim_kronecker_product_rule",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカー積の積の規則（各因子ごとの積になること）" },
    labels: ["kronecker_product_rule"],
    statement: [
      paragraph([
        ref("def_kronecker"),
        " の記号のもと、",
        math(String.raw`A_1,\dots,A_M,B_1,\dots,B_M \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        math(String.raw`v_1,\dots,v_M \in \mathbb{C}^2`),
        " について次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(
            String.raw`\left(A_1\boxtimes\cdots\boxtimes A_M\right)\left(B_1\boxtimes\cdots\boxtimes B_M\right)
= (A_1B_1)\boxtimes\cdots\boxtimes(A_MB_M)`,
          ),
          "（左辺は ",
          math(String.raw`2^M`),
          " 次の行列の積、右辺の各 ",
          math(String.raw`A_kB_k`),
          " は ",
          math(String.raw`2`),
          " 次の行列の積）。",
        ],
        [
          "(2) ",
          math(
            String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}
= I_{\mathrm{Mat}(2^M,\mathbb{C})}`,
          ),
          "。",
        ],
        [
          "(3) ",
          math(
            String.raw`\left(A_1\boxtimes\cdots\boxtimes A_M\right)\left(v_1\boxtimes\cdots\boxtimes v_M\right)
= (A_1v_1)\boxtimes\cdots\boxtimes(A_Mv_M)`,
          ),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph(["行列積と列ベクトルへの作用は ", ref("mat_mult"), " に従い、複素数の結合律・可換律・分配律は ", ref("complex_numbers_form_a_field"), " を用いる。"]),
      paragraph([
        "多重添字についての和を、各因子ごとの和の積へ直すこと。",
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " と、各 ",
        math(String.raw`k\in\{1,\dots,M\}`),
        " ごとに与えられた複素数 ",
        math(String.raw`c_k(1),c_k(2)\in\mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\sum_{K\in\mathcal{I}_M}\ \prod_{k=1}^{M}c_k(t_k)
= \prod_{k=1}^{M}\left(\sum_{t=1}^{2}c_k(t)\right)
\qquad (K=(t_1,\dots,t_M))`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`M`),
        " についての帰納法で示す。",
        math(String.raw`M=1`),
        " のときは両辺とも ",
        math(String.raw`c_1(1)+c_1(2)`),
        "。",
        math(String.raw`M`),
        " で成り立つとすると、",
        math(String.raw`\mathcal{I}_{M+1}`),
        " の元は ",
        math(String.raw`(K,t)`),
        "（",
        math(String.raw`K\in\mathcal{I}_M,\ t\in\{1,2\}`),
        "）と一対一に対応するから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{(t_1,\dots,t_{M+1})\in\mathcal{I}_{M+1}}\prod_{k=1}^{M+1}c_k(t_k)
&= \sum_{t=1}^{2}\sum_{K\in\mathcal{I}_M}\left(\prod_{k=1}^{M}c_k(t_k)\right)c_{M+1}(t)
   &&(\because \text{最後の成分 } t_{M+1}=t \text{ で場合分けした有限和の分割}) \\
&= \left(\sum_{K\in\mathcal{I}_M}\prod_{k=1}^{M}c_k(t_k)\right)\left(\sum_{t=1}^{2}c_{M+1}(t)\right)
   &&(\because \text{分配律}) \\
&= \left(\prod_{k=1}^{M}\left(\sum_{s=1}^{2}c_k(s)\right)\right)\left(\sum_{t=1}^{2}c_{M+1}(t)\right)
   &&(\because \text{帰納法の仮定}) \\
&= \prod_{k=1}^{M+1}\left(\sum_{t=1}^{2}c_k(t)\right)
   &&(\because \text{有限積の最後の因子を戻した（積の定義）})
\end{aligned}`,
      ),
      paragraph([
        "(1) の証明。",
        math(String.raw`I=(i_1,\dots,i_M),\ L=(l_1,\dots,l_M)\in\mathcal{I}_M`),
        " を任意に取る。行列の積の定義と、",
        ref("def_kronecker"),
        " の ",
        math(String.raw`\nu`),
        " が全単射であること（和の変数 ",
        math(String.raw`p\in\{1,\dots,2^M\}`),
        " を ",
        math(String.raw`p=\nu(K),\ K=(t_1,\dots,t_M)\in\mathcal{I}_M`),
        " と書き換えてよい）より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(A_1\boxtimes\cdots\boxtimes A_M\right)\left(B_1\boxtimes\cdots\boxtimes B_M\right)\right)_{\nu(I),\nu(L)}
&= \sum_{p=1}^{2^M}
\left(A_1\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),p}
\left(B_1\boxtimes\cdots\boxtimes B_M\right)_{p,\nu(L)}
   &&(\because \text{行列の積の定義}) \\
&= \sum_{K\in\mathcal{I}_M}
\left(\prod_{k=1}^{M}(A_k)_{i_kt_k}\right)\left(\prod_{k=1}^{M}(B_k)_{t_kl_k}\right)
   &&(\because \nu \text{ は全単射、} \boxtimes \text{ の定義}) \\
&= \sum_{K\in\mathcal{I}_M}\prod_{k=1}^{M}\left((A_k)_{i_kt_k}(B_k)_{t_kl_k}\right)
   &&(\because \text{複素数の積の可換律・結合律}) \\
&= \prod_{k=1}^{M}\left(\sum_{t=1}^{2}(A_k)_{i_kt}(B_k)_{tl_k}\right)
   &&(\because \text{多重添字の和を各因子ごとの和の積へ直す段を } c_k(t)=(A_k)_{i_kt}(B_k)_{tl_k} \text{ に適用}) \\
&= \prod_{k=1}^{M}(A_kB_k)_{i_kl_k}
   &&(\because \text{行列の積の定義}) \\
&= \left((A_1B_1)\boxtimes\cdots\boxtimes(A_MB_M)\right)_{\nu(I),\nu(L)}
   &&(\because \boxtimes \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は全単射だから、これで両辺のすべての成分が一致することが示された。",
      ]),
      paragraph([
        "(2) の証明。",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " を任意に取る。単位行列の成分は ",
        math(String.raw`\left(I_{\mathrm{Mat}(2,\mathbb{C})}\right)_{ij}=\delta_{ij}`),
        "（",
        math(String.raw`i=j`),
        " のとき ",
        math(String.raw`1`),
        "、そうでなければ ",
        math(String.raw`0`),
        "）である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}\right)_{\nu(I),\nu(J)}
&= \prod_{k=1}^{M}\delta_{i_kj_k}
   &&(\because \boxtimes \text{ の定義と単位行列の成分}) \\
&= \begin{cases}1 & (I=J)\\ 0 & (I\neq J)\end{cases}
   &&(\because \text{積が } 1 \text{ になるのは全ての } k \text{ で } i_k=j_k \text{、すなわち } I=J \text{ のときに限り、そうでなければ因子に } 0 \text{ が現れる}) \\
&= \left(I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)_{\nu(I),\nu(J)}
   &&(\because \nu \text{ は単射なので } I=J \iff \nu(I)=\nu(J) \text{、および単位行列の成分})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は全単射だから、これで両辺のすべての成分が一致することが示された。",
      ]),
      paragraph([
        "(3) の証明。(1) と同じ計算を、第 2 の因子を数ベクトルに置き換えて行う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(A_1\boxtimes\cdots\boxtimes A_M\right)\left(v_1\boxtimes\cdots\boxtimes v_M\right)\right)_{\nu(I)}
&= \sum_{p=1}^{2^M}\left(A_1\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),p}
\left(v_1\boxtimes\cdots\boxtimes v_M\right)_{p}
   &&(\because \text{行列と数ベクトルの積の定義}) \\
&= \sum_{K\in\mathcal{I}_M}
\left(\prod_{k=1}^{M}(A_k)_{i_kt_k}\right)\left(\prod_{k=1}^{M}(v_k)_{t_k}\right)
   &&(\because \nu \text{ は全単射、} \boxtimes \text{ の定義}) \\
&= \sum_{K\in\mathcal{I}_M}\prod_{k=1}^{M}\left((A_k)_{i_kt_k}(v_k)_{t_k}\right)
   &&(\because \text{複素数の積の可換律・結合律}) \\
&= \prod_{k=1}^{M}\left(\sum_{t=1}^{2}(A_k)_{i_kt}(v_k)_{t}\right)
   &&(\because \text{多重添字の和を各因子ごとの和の積へ直す段を } c_k(t)=(A_k)_{i_kt}(v_k)_{t} \text{ に適用}) \\
&= \prod_{k=1}^{M}(A_kv_k)_{i_k}
   &&(\because \text{行列と数ベクトルの積の定義}) \\
&= \left((A_1v_1)\boxtimes\cdots\boxtimes(A_Mv_M)\right)_{\nu(I)}
   &&(\because \boxtimes \text{ の定義})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。「テンソル積上の積は各因子ごとの積」という規則は" +
          "004 章以降の証明で繰り返し根拠として使われているのに、定義も証明も本文に無かった" +
          "（goal-alignment-audit の A-3）。クロネッカー積として定義したことで、成分計算で証明できる" +
          "主張になったのでここに置いた。",
        "2026-08-10: 式変形の書き方の統一。2 箇所を直した。準備（多重添字の和を各因子ごとの" +
          "和の積へ直す段）の鎖の最終行に根拠が無かったので (∵ …) を付けた。" +
          "(3) の鎖は、1 行で 2 つの定理を同時に適用していた段（ν が全単射であることと ⊠ の定義で" +
          "書き換える段に、複素数の積の可換律・結合律による並べ替えを混ぜていた）を 2 段へ割り、" +
          "さらに最後の行が 1 行に 2 つの等号を並べて根拠を 1 つも書いていなかったので" +
          "2 段へ割って各行に (∵ …) を置いた（(1) の鎖と同じ形になった）。" +
          "段は増えており、減った段は無い。主張も証明の筋も変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_000c_claim_kronecker_multilinear",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカー積の各因子についての線型性" },
    labels: ["kronecker_multilinear"],
    statement: [
      paragraph([
        ref("def_kronecker"),
        " の記号のもと、",
        math(String.raw`j\in\{1,\dots,M\}`),
        " を固定し、",
        math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        math(String.raw`r\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`c_1,\dots,c_r\in\mathbb{C}`),
        "、",
        math(String.raw`B_1,\dots,B_r\in\mathrm{Mat}(2,\mathbb{C})`),
        " とする。第 ",
        math(String.raw`j`),
        " 因子が ",
        math(String.raw`A_j=\sum_{a=1}^{r}c_aB_a`),
        " と書けているとき、",
      ]),
      displayMath(
        String.raw`A_1\boxtimes\cdots\boxtimes\overbrace{\left(\sum_{a=1}^{r}c_aB_a\right)}^{j\text{ 番目}}\boxtimes\cdots\boxtimes A_M
= \sum_{a=1}^{r}c_a\left(A_1\boxtimes\cdots\boxtimes\overbrace{B_a}^{j\text{ 番目}}\boxtimes\cdots\boxtimes A_M\right)`,
      ),
      paragraph([
        "が成り立つ。特に ",
        math(String.raw`r=1`),
        " として、",
        math(String.raw`c\in\mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`A_1\boxtimes\cdots\boxtimes\overbrace{(c\,A_j)}^{j\text{ 番目}}\boxtimes\cdots\boxtimes A_M
= c\left(A_1\boxtimes\cdots\boxtimes A_M\right)`,
      ),
      paragraph([
        "である。数ベクトルのクロネッカー積についても、",
        math(String.raw`\mathbb{C}^2`),
        " の元を同じ形に分解したとき同じ等式が成り立つ。",
      ]),
    ],
    proof: [
      paragraph(["成分の複素数の演算には ", ref("complex_numbers_form_a_field"), " の結合律・可換律・分配律を用いる。"]),
      paragraph([
        "準備。",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " を任意に取り、両辺の ",
        math(String.raw`(\nu(I),\nu(J))`),
        " 成分を比べる。以下で ",
        math(String.raw`\prod_{k\neq j}(A_k)_{i_kj_k}`),
        " は ",
        math(String.raw`k\in\{1,\dots,M\}\setminus\{j\}`),
        " についての積を表す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A_1\boxtimes\cdots\boxtimes\left(\sum_{a=1}^{r}c_aB_a\right)\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),\nu(J)}
&= \left(\prod_{k\neq j}(A_k)_{i_kj_k}\right)\left(\sum_{a=1}^{r}c_aB_a\right)_{i_jj_j}
&&(\because \boxtimes \text{ の定義}) \\
&= \left(\prod_{k\neq j}(A_k)_{i_kj_k}\right)\left(\sum_{a=1}^{r}c_a(B_a)_{i_jj_j}\right)
&&(\because \text{行列の和・スカラー倍は成分ごとの演算}) \\
&= \sum_{a=1}^{r}c_a\left(\prod_{k\neq j}(A_k)_{i_kj_k}\right)(B_a)_{i_jj_j}
&&(\because \text{複素数の分配律}) \\
&= \sum_{a=1}^{r}c_a\left(A_1\boxtimes\cdots\boxtimes B_a\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),\nu(J)}
&&(\because \boxtimes \text{ の定義}) \\
&= \left(\sum_{a=1}^{r}c_a\left(A_1\boxtimes\cdots\boxtimes B_a\boxtimes\cdots\boxtimes A_M\right)\right)_{\nu(I),\nu(J)}
&&(\because \text{行列の和・スカラー倍は成分ごとの演算})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は全単射だから、すべての成分が一致し両辺は等しい。",
        math(String.raw`r=1,\ c_1=c,\ B_1=A_j`),
        " とすればスカラーを前に出す式を得る。数ベクトルの場合は、上の計算で ",
        math(String.raw`(A_k)_{i_kj_k}`),
        " を ",
        math(String.raw`(v_k)_{i_k}`),
        " に置き換えれば同じ議論がそのまま通用する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。「テンソル積の各因子についての C-線型性」" +
          "（スカラーを前に出す・和で展開する）は 004 章以降で繰り返し根拠として使われているのに、" +
          "定義も証明も本文に無かった（goal-alignment-audit の A-3）。",
        "2026-08-10: 式変形の書き方の統一。第 1 段が「⊠ の定義」と「行列の和・スカラー倍は" +
          "成分ごとの演算」の 2 つを同時に適用していたので 2 段に割った（一ステップ一定理）。" +
          "式変形の前に置かれていた成分の分解の式は、鎖の中の 1 段になったので準備から外し、" +
          "式変形の後ろにあった記法の断り（∏_{k≠j} の意味）は準備へ移した。" +
          "段は増えており、減った段は無い。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_matrix_transpose",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "行列の転置" },
    labels: ["def_matrix_transpose"],
    statement: [
      paragraph([
        math(String.raw`m,n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。",
        math(String.raw`B`),
        " の転置 ",
        math(String.raw`B^\top \in \mathrm{Mat}(n,m,\mathbb{C})`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`\left(B^\top\right)_{pq} := B_{qp}
\qquad (p \in \{1,\dots,n\},\ q \in \{1,\dots,m\})`),
      paragraph([
        "で定める。右辺は ",
        math(String.raw`B`),
        " の ",
        math(String.raw`(q,p)`),
        " 成分であり、",
        math(String.raw`q \in \{1,\dots,m\}`),
        "、",
        math(String.raw`p \in \{1,\dots,n\}`),
        " だから定まっている。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。クロネッカー積の転置の主張（kronecker_transpose）が" +
          "主張の中で 2^M 次の行列の転置を定め、証明では 2 次の行列の転置の定義を根拠にしていたが、" +
          "転置を定めるブロックが本文に無かった。1 ブロック 1 主張に従い、定義をこのブロックへ切り出した。",
      ],
    },
  },
  {
    id: "linear_space_general_000d_claim_kronecker_transpose",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカー積の転置（因子ごとの転置になること）" },
    labels: ["kronecker_transpose"],
    statement: [
      paragraph([
        ref("def_kronecker"),
        " の記号のもと、",
        math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
        ref("def_matrix_transpose"),
        " の転置に関して",
      ]),
      displayMath(
        String.raw`\left(A_1\boxtimes\cdots\boxtimes A_M\right)^\top
= A_1^\top\boxtimes\cdots\boxtimes A_M^\top`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " を任意に取り、両辺の ",
        math(String.raw`(\nu(I),\nu(J))`),
        " 成分を比べる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(A_1\boxtimes\cdots\boxtimes A_M\right)^\top\right)_{\nu(I),\nu(J)}
&= \left(A_1\boxtimes\cdots\boxtimes A_M\right)_{\nu(J),\nu(I)}
&&(\because \blkref{def_matrix_transpose} \text{ で } m=n=2^M) \\
&= \prod_{k=1}^{M}(A_k)_{j_ki_k}
&&(\because \blkref{def_kronecker} \text{ を } A_1,\dots,A_M \text{ に適用}) \\
&= \prod_{k=1}^{M}\left(A_k^\top\right)_{i_kj_k}
&&(\because \blkref{def_matrix_transpose} \text{ で } m=n=2 \text{ を各 } k \text{ に適用}) \\
&= \left(A_1^\top\boxtimes\cdots\boxtimes A_M^\top\right)_{\nu(I),\nu(J)}
&&(\because \blkref{def_kronecker} \text{ を } A_1^\top,\dots,A_M^\top \text{（} \blkref{def_matrix_transpose} \text{ により } \mathrm{Mat}(2,\mathbb{C}) \text{ の元）に適用})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は ",
        ref("def_kronecker"),
        " により全単射であり、",
        math(String.raw`\{1,\dots,2^M\}`),
        " のどの成分の番号も ",
        math(String.raw`\nu(I)`),
        " の形に書けるので、これで両辺のすべての成分が一致することが示された。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。009 章（V の固有値）の実対称性の議論が" +
          "「テンソル積の転置は因子ごとの転置になる」を根拠なしに使っていたので、" +
          "クロネッカー積の成分の定義から証明できる主張としてここに置いた。",
        "式変形の書き方の統一（2026-08-10）。鎖と行末の (∵ …) は既にあったが、" +
          "引いたブロックへのラベル参照が無く、(∵ ⊠ の定義) がどのブロックを指すかが" +
          "式の中からは辿れなかった。式の直後に参照を置いた。" +
          "あわせて、最後の段が「ν は全単射だから」とだけ述べていたところを、" +
          "全単射性がどこで定めたものかと、そこから成分の番号がすべて尽くされることを書いた。" +
          "式変形の段は 1 つも増減しておらず、主張と証明の中身は変えていない。",
        "2026-09-01 の式変形統一で、四段の根拠を行中の \\quad (\\because …) から" +
          "行末の根拠列（aligned の &&）へ揃えた。式変形・根拠・段数・参照は変えていない。",
        "2026-11-01: 主張の中で定めていた 2^M 次の行列の転置と、証明が根拠にしていた 2 次の行列の転置を、" +
          "新しい定義 def_matrix_transpose（m 行 n 列の行列の転置）へ切り出し、第一行と第三行の根拠をそれへの参照にした。第二行と第四行の根拠に、定義をどの行列へ適用したかを書いた。" +
          "式変形の段と主張の中身は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_transpose_of_matrix_sum",
    kind: "claim",
    title: { text: "行列の和の転置は転置の和" },
    labels: ["transpose_of_matrix_sum"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。和は ",
        ref("def_matrix_sum"),
        "、転置は ",
        ref("def_matrix_transpose"),
        " による。このとき",
      ]),
      displayMath(String.raw`(A + B)^\top = A^\top + B^\top`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(n,m,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`p \in \{1,\dots,n\}`),
        "、",
        math(String.raw`q \in \{1,\dots,m\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((A + B)^\top\bigr)_{pq}
&= (A + B)_{qp}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (B \to A + B)\bigr)\\
&= A_{qp} + B_{qp}
&&\bigl(\because\ \blkref{def_matrix_sum}\ (i \to q,\ j \to p)\bigr)\\
&= \left(A^\top\right)_{pq} + \left(B^\top\right)_{pq}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (B \to A \text{ と } B \to B)\ \text{を 2 箇所へ適用}\bigr)\\
&= \left(A^\top + B^\top\right)_{pq}
&&\bigl(\because\ \blkref{def_matrix_sum}\ (m \to n,\ n \to m,\ A \to A^\top,\ B \to B^\top,\ i \to p,\ j \to q)\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の結論が、S_1^{(+)}・S_2 の転置での対称性を「実係数の有限和」と名前だけで述べていたので、S_1^{(+)}・S_2 の転置の鎖が引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_transpose_of_matrix_scalar_multiple",
    kind: "claim",
    title: { text: "行列のスカラー倍の転置は転置のスカラー倍" },
    labels: ["transpose_of_matrix_scalar_multiple"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、転置は ",
        ref("def_matrix_transpose"),
        " による。このとき",
      ]),
      displayMath(String.raw`(cA)^\top = c\,A^\top`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(n,m,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`p \in \{1,\dots,n\}`),
        "、",
        math(String.raw`q \in \{1,\dots,m\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((cA)^\top\bigr)_{pq}
&= (cA)_{qp}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (B \to cA)\bigr)\\
&= c\,A_{qp}
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\ (a \to c,\ i \to q,\ j \to p)\bigr)\\
&= c\,\left(A^\top\right)_{pq}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (B \to A)\bigr)\\
&= \left(c\,A^\top\right)_{pq}
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\ (m \to n,\ n \to m,\ a \to c,\ A \to A^\top,\ i \to p,\ j \to q)\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の S_1^{(+)}・S_2 の転置の鎖が、係数 K_1・K_2^* を転置の外へ出す段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_transpose_of_matrix_difference",
    kind: "claim",
    title: { text: "行列の差の転置は転置の差" },
    labels: ["transpose_of_matrix_difference"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,p,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。差は ",
        ref("def_matrix_difference"),
        "、転置は ",
        ref("def_matrix_transpose"),
        " による。このとき",
      ]),
      displayMath(String.raw`(A - B)^\top = A^\top - B^\top`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(p,m,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`k \in \{1,\dots,p\}`),
        "、",
        math(String.raw`i \in \{1,\dots,m\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((A - B)^\top\bigr)_{ki}
&= (A - B)_{ik}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (n \to p,\ B \to A - B,\ p \to k,\ q \to i\ \text{を同時に置き換える})\bigr)\\
&= A_{ik} - B_{ik}
&&\bigl(\because\ \blkref{def_matrix_difference}\bigr)\\
&= \left(A^\top\right)_{ki} - \left(B^\top\right)_{ki}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (n \to p,\ B \to A \text{ と } B \to B,\ p \to k,\ q \to i\ \text{を同時に置き換える})\ \text{を 2 箇所へ適用}\bigr)\\
&= \left(A^\top - B^\top\right)_{ki}
&&\bigl(\because\ \blkref{def_matrix_difference}\ (m \to p,\ p \to m,\ A \to A^\top,\ B \to B^\top,\ i \to k,\ k \to i)\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の S_1^{(+)} = K_1Σσ^z_mσ^z_{m+1} − K_1G の転置の鎖が、差の転置を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_transpose_of_finite_sum_of_matrices",
    kind: "claim",
    title: { text: "行列の有限和の転置は転置の有限和" },
    labels: ["transpose_of_finite_sum_of_matrices"],
    statement: [
      paragraph([
        math(String.raw`m, n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。左辺の有限和は ",
        ref("def_finite_sum_of_matrices"),
        "（",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        " の中）、右辺の有限和は ",
        ref("def_finite_sum_of_matrices"),
        "（",
        math(String.raw`\mathrm{Mat}(n,m,\mathbb{C})`),
        " の中）、転置は ",
        ref("def_matrix_transpose"),
        " による。このとき",
      ]),
      displayMath(String.raw`\Bigl(\sum_{j=1}^{r} X_j\Bigr)^\top = \sum_{j=1}^{r} X_j^\top`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{j=1}^{1} X_j\Bigr)^\top
&= X_1^\top
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \sum_{j=1}^{1} X_j^\top
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ (m \to n,\ n \to m,\ X_j \to X_j^\top)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r`),
        " で成り立つと仮定すると、",
        math(String.raw`X_1,\dots,X_{r+1} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{j=1}^{r+1} X_j\Bigr)^\top
&= \Bigl(\Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}\Bigr)^\top
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\bigr)\\
&= \Bigl(\sum_{j=1}^{r} X_j\Bigr)^\top + X_{r+1}^\top
&&\bigl(\because\ \blkref{transpose_of_matrix_sum}\ (A \to \textstyle\sum_{j=1}^{r} X_j,\ B \to X_{r+1})\bigr)\\
&= \Bigl(\sum_{j=1}^{r} X_j^\top\Bigr) + X_{r+1}^\top
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \sum_{j=1}^{r+1} X_j^\top
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ (m \to n,\ n \to m,\ X_j \to X_j^\top)\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の S_1^{(+)}・S_2 の転置の鎖が、Σσ^x_m・Σσ^z_mσ^z_{m+1} の転置を各項の転置の和にする段を引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_transpose_of_matrix_product",
    kind: "claim",
    title: { text: "行列の積の転置は転置を逆の順に掛けた積" },
    labels: ["transpose_of_matrix_product"],
    statement: [
      paragraph([
        math(String.raw`m, n, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。積は ",
        ref("mat_mult"),
        "、転置は ",
        ref("def_matrix_transpose"),
        " による。このとき",
      ]),
      displayMath(String.raw`(AB)^\top = B^\top A^\top`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(p,m,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`k \in \{1,\dots,p\}`),
        "、",
        math(String.raw`l \in \{1,\dots,m\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((AB)^\top\bigr)_{kl}
&= (AB)_{lk}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (n \to p,\ B \to AB,\ p \to k,\ q \to l\ \text{を同時に置き換える})\bigr)\\
&= \sum_{j=1}^{n} A_{lj}\,B_{jk}
&&\bigl(\because\ \blkref{mat_mult}\ (i \to l)\bigr)\\
&= \sum_{j=1}^{n} \left(A^\top\right)_{jl}\left(B^\top\right)_{kj}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ \text{を各項の 2 箇所へ同時に適用。}A_{lj}\ \text{へ}\ (B \to A,\ p \to j,\ q \to l)\text{、}B_{jk}\ \text{へ}\ (m \to n,\ n \to p,\ B \to B,\ p \to k,\ q \to j)\text{（それぞれ同時に置き換える）}\bigr)\\
&= \sum_{j=1}^{n} \left(B^\top\right)_{kj}\left(A^\top\right)_{jl}
&&\bigl(\because\ \mathbb{C}\ \text{の積の交換律 }\blkref{complex_numbers_form_a_field}\ \text{を各項へ同時に適用}\bigr)\\
&= \left(B^\top A^\top\right)_{kl}
&&\bigl(\because\ \blkref{mat_mult}\ (m \to p,\ p \to m,\ A \to B^\top,\ B \to A^\top,\ i \to k,\ k \to l)\bigr)
\end{aligned}`),
      paragraph(["よって全ての成分が一致し、主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。W_is_real_symmetric_positive_definite の実対称性の鎖が「転置の積の法則 (ABC)^⊤ = C^⊤B^⊤A^⊤」を名前だけで引いていたので、それを 2 つの因子の積について述べた主張として足した。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_matrix_with_real_entries",
    kind: "definition",
    title: { text: "成分がすべて実数の行列" },
    labels: ["def_matrix_with_real_entries"],
    statement: [
      paragraph([
        math(String.raw`m,n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。",
        math(String.raw`B`),
        " の**成分がすべて実数である**とは、すべての ",
        math(String.raw`p \in \{1,\dots,m\}`),
        "、",
        math(String.raw`q \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`B_{pq} = r_{\mathbb{C}}`),
      paragraph([
        "を満たす ",
        math(String.raw`r \in \mathbb{R}`),
        " が存在することをいう。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric・def_hermitian_positive_definite の最後の注意・epsilon_is_real_symmetric が「成分がすべて実数」を定義なしに使っていたので、inclusion_rr_to_cc の像に入ることとして定めた（def_hermitian_positive_definite の「z ∈ ℝ_{>0}」の略記と同じ読み方）。",
      ],
    },
  },
  {
    id: "linear_space_general_definition_real_matrix_of_real_entry_matrix",
    kind: "definition",
    title: { text: "成分がすべて実数の複素行列から実数の行列への写像" },
    labels: ["def_real_matrix_of_real_entry_matrix"],
    statement: [
      paragraph([
        math(String.raw`m,n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{R})`),
        " は成分 ",
        math(String.raw`P_{pq}`),
        "（",
        math(String.raw`p \in \{1,\dots,m\}`),
        "、",
        math(String.raw`q \in \{1,\dots,n\}`),
        "）が実数である ",
        math(String.raw`m`),
        " 行 ",
        math(String.raw`n`),
        " 列の行列の全体、",
        math(String.raw`\mathrm{Mat}(n,\mathbb{R}) := \mathrm{Mat}(n,n,\mathbb{R})`),
        " である。",
        math(String.raw`\mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）の元のうち ",
        ref("def_matrix_with_real_entries"),
        " の意味で成分がすべて実数であるものの全体を",
      ]),
      displayMath(String.raw`\mathrm{Mat}^{\mathrm{re}}(m,n,\mathbb{C}) := \left\{\, B \in \mathrm{Mat}(m,n,\mathbb{C}) \ \middle|\ B\ \text{の成分はすべて実数} \,\right\}`),
      paragraph([
        "とおく。",
        math(String.raw`B \in \mathrm{Mat}^{\mathrm{re}}(m,n,\mathbb{C})`),
        " と ",
        math(String.raw`p \in \{1,\dots,m\}`),
        "、",
        math(String.raw`q \in \{1,\dots,n\}`),
        " について、",
        math(String.raw`B_{pq} = r_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r \in \mathbb{R}`),
        " は ",
        ref("def_matrix_with_real_entries"),
        " より存在し、",
        math(String.raw`r, r' \in \mathbb{R}`),
        " がともにこれを満たすなら ",
        math(String.raw`r_{\mathbb{C}} = B_{pq} = r'_{\mathbb{C}}`),
        " なので ",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to r,\ b \to r'`),
        "）より ",
        math(String.raw`r = r'`),
        " である。この ",
        math(String.raw`r`),
        " を ",
        math(String.raw`w_{pq}(B) \in \mathbb{R}`),
        " と書き、写像",
      ]),
      displayMath(String.raw`\varrho^{m,n}_{\mathbb{C}\to\mathbb{R}} : \mathrm{Mat}^{\mathrm{re}}(m,n,\mathbb{C}) \to \mathrm{Mat}(m,n,\mathbb{R}), \qquad
\bigl(\varrho^{m,n}_{\mathbb{C}\to\mathbb{R}}(B)\bigr)_{pq} := w_{pq}(B)`),
      paragraph([
        "を定める。略記として ",
        math(String.raw`B_{\mathbb{R}} := \varrho^{m,n}_{\mathbb{C}\to\mathbb{R}}(B)`),
        " と書く。",
        math(String.raw`w_{pq}(B)`),
        " の取り方から、すべての ",
        math(String.raw`p, q`),
        " について",
      ]),
      displayMath(String.raw`\bigl((B_{\mathbb{R}})_{pq}\bigr)_{\mathbb{C}} = B_{pq}`),
      paragraph([
        "である。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06: 原文（Typst）に対応ブロックは無い。def_rayleigh_sup が「W は実行列とみなせる」と、成分がすべて実数の複素行列 W を実数の行列として扱っていた（同一視）。証明の書き方の「同一視は写像を定義してからでないとできない」に従い、その行き来の写像に名前を付けて定めた。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_kronecker_of_real_entry_matrices_has_real_entries",
    kind: "claim",
    title: { text: "成分がすべて実数の行列のクロネッカー積は成分がすべて実数" },
    labels: ["kronecker_of_real_entry_matrices_has_real_entries"],
    statement: [
      paragraph([
        ref("def_kronecker"),
        " の記号のもと、",
        math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " の成分がすべて実数（",
        ref("def_matrix_with_real_entries"),
        " で ",
        math(String.raw`m = n = 2`),
        "）ならば、",
        math(String.raw`A_1\boxtimes\cdots\boxtimes A_M \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " の成分もすべて実数（",
        ref("def_matrix_with_real_entries"),
        " で ",
        math(String.raw`m = n = 2^M`),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " を任意に取る。各 ",
        math(String.raw`k \in \{1,\dots,M\}`),
        " について、仮定（",
        ref("def_matrix_with_real_entries"),
        " で ",
        math(String.raw`B \to A_k,\ p \to i_k,\ q \to j_k`),
        "）から ",
        math(String.raw`(A_k)_{i_kj_k} = (r_k)_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r_k \in \mathbb{R}`),
        " がある。",
        ref("finite_product_of_real_inclusions_is_real"),
        "（",
        math(String.raw`m \to M,\ j \to k,\ z_j \to (A_k)_{i_kj_k},\ r_j \to r_k`),
        "）から ",
        math(String.raw`\prod_{k=1}^{M}(A_k)_{i_kj_k} = r_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r \in \mathbb{R}`),
        " を取ると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A_1\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),\nu(J)}
&= \prod_{k=1}^{M}(A_k)_{i_kj_k}
&&(\because \blkref{def_kronecker} \text{ を } A_1,\dots,A_M \text{ に適用}) \\
&= r_{\mathbb{C}}
&&(\because r \text{ の取り方})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`\nu`),
        " は ",
        ref("def_kronecker"),
        " により全単射であり、",
        math(String.raw`\{1,\dots,2^M\}`),
        " のどの成分の番号も ",
        math(String.raw`\nu(I)`),
        " の形に書けるので、",
        math(String.raw`A_1\boxtimes\cdots\boxtimes A_M`),
        " のすべての成分について ",
        ref("def_matrix_with_real_entries"),
        " の条件が示された。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 と epsilon_is_real_symmetric の証明が「クロネッカー積の成分は各因子の成分の積だから実」を名前だけで述べていたので、引けるよう足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_real_scalar_multiple_of_real_entry_matrix_has_real_entries",
    kind: "claim",
    title: { text: "成分がすべて実数の行列の実数倍は成分がすべて実数" },
    labels: ["real_scalar_multiple_of_real_entry_matrix_has_real_entries"],
    statement: [
      paragraph([
        math(String.raw`m,n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{R}`),
        " とし、",
        math(String.raw`B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " の成分がすべて実数（",
        ref("def_matrix_with_real_entries"),
        "）とする。このとき ",
        math(String.raw`c_{\mathbb{C}}B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍。",
        math(String.raw`c_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記）の成分もすべて実数である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`p \in \{1,\dots,m\}`),
        "、",
        math(String.raw`q \in \{1,\dots,n\}`),
        " を任意に取る。仮定（",
        ref("def_matrix_with_real_entries"),
        "）から ",
        math(String.raw`B_{pq} = s_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`s \in \mathbb{R}`),
        " がある。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(c_{\mathbb{C}}B)_{pq}
&= c_{\mathbb{C}}\,B_{pq}
&&(\because \blkref{def_matrix_scalar_multiple}\ (a \to c_{\mathbb{C}},\ A \to B,\ i \to p,\ j \to q)) \\
&= c_{\mathbb{C}}\,s_{\mathbb{C}}
&&(\because s \text{ の取り方}) \\
&= (cs)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product}\ (a \to c,\ b \to s))
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`r := cs \in \mathbb{R}`),
        " と取れば ",
        math(String.raw`(c_{\mathbb{C}}B)_{pq} = r_{\mathbb{C}}`),
        " であり、",
        math(String.raw`p, q`),
        " は任意なので ",
        ref("def_matrix_with_real_entries"),
        " の条件が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の G の成分の実性の鎖が、G = (-1)_ℂ(R^y⊠σ^x⊠⋯⊠σ^x⊠R^y) から G の成分が実であることを引くために足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_sum_of_real_entry_matrices_has_real_entries",
    kind: "claim",
    title: { text: "成分がすべて実数の行列の和は成分がすべて実数" },
    labels: ["sum_of_real_entry_matrices_has_real_entries"],
    statement: [
      paragraph([
        math(String.raw`m,n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " の成分がすべて実数（",
        ref("def_matrix_with_real_entries"),
        "）とする。このとき ",
        math(String.raw`A + B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("def_matrix_sum"),
        " の和）の成分もすべて実数である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`p \in \{1,\dots,m\}`),
        "、",
        math(String.raw`q \in \{1,\dots,n\}`),
        " を任意に取る。仮定（",
        ref("def_matrix_with_real_entries"),
        "）から ",
        math(String.raw`A_{pq} = s_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`s \in \mathbb{R}`),
        " と、",
        math(String.raw`B_{pq} = t_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`t \in \mathbb{R}`),
        " がある。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(A + B)_{pq}
&= A_{pq} + B_{pq}
&&(\because \blkref{def_matrix_sum}\ (i \to p,\ j \to q)) \\
&= s_{\mathbb{C}} + t_{\mathbb{C}}
&&(\because s, t \text{ の取り方}) \\
&= (s, 0) + (t, 0)
&&(\because \blkref{inclusion_rr_to_cc}\ \text{を 2 箇所へ同時に適用}) \\
&= (s + t,\ 0 + 0)
&&(\because \blkref{definition_of_cc}\ \text{の和}) \\
&= (s + t,\ 0)
&&(\because \mathbb{R}\ \text{で}\ 0 + 0 = 0) \\
&= (s + t)_{\mathbb{C}}
&&(\because \blkref{inclusion_rr_to_cc})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`r := s + t \in \mathbb{R}`),
        " と取れば ",
        math(String.raw`(A + B)_{pq} = r_{\mathbb{C}}`),
        " であり、",
        math(String.raw`p, q`),
        " は任意なので ",
        ref("def_matrix_with_real_entries"),
        " の条件が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の結論が「実係数の有限和なので成分がすべて実数」と名前だけで述べていたのを、成分が実の行列の和・差・有限和の主張を引く形にするために足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_difference_of_real_entry_matrices_has_real_entries",
    kind: "claim",
    title: { text: "成分がすべて実数の行列の差は成分がすべて実数" },
    labels: ["difference_of_real_entry_matrices_has_real_entries"],
    statement: [
      paragraph([
        math(String.raw`m,n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " の成分がすべて実数（",
        ref("def_matrix_with_real_entries"),
        "）とする。このとき ",
        math(String.raw`A - B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("def_matrix_difference"),
        " の差）の成分もすべて実数である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
A - B
&= A + (-B)
&&(\because \blkref{matrix_difference_is_sum_with_negation}) \\
&= A + (-1_{\mathbb{C}})B
&&(\because \blkref{negation_is_scalar_multiple_by_minus_one}\ (A \to B)) \\
&= A + (-1)_{\mathbb{C}}B
&&(\because \blkref{inclusion_rr_to_cc} \text{ の略記 } -1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(-1))
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`B`),
        " の成分はすべて実数なので、",
        ref("real_scalar_multiple_of_real_entry_matrix_has_real_entries"),
        "（",
        math(String.raw`c \to -1`),
        "）より ",
        math(String.raw`(-1)_{\mathbb{C}}B`),
        " の成分はすべて実数である。",
        math(String.raw`A`),
        " の成分もすべて実数なので、",
        ref("sum_of_real_entry_matrices_has_real_entries"),
        "（",
        math(String.raw`B \to (-1)_{\mathbb{C}}B`),
        "）より ",
        math(String.raw`A + (-1)_{\mathbb{C}}B`),
        " の成分はすべて実数である。上の鎖より、",
        math(String.raw`A - B`),
        " の成分はすべて実数である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の結論で、S_1^{(+)} = (K_1)_ℂΣσ^zσ^z − (K_1)_ℂG の成分が実であることを引くために足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_finite_sum_of_real_entry_matrices_has_real_entries",
    kind: "claim",
    title: { text: "成分がすべて実数の行列の有限和は成分がすべて実数" },
    labels: ["finite_sum_of_real_entry_matrices_has_real_entries"],
    statement: [
      paragraph([
        math(String.raw`m,n,r \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`X_1,\dots,X_r \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " の成分がすべて実数（",
        ref("def_matrix_with_real_entries"),
        "）とする。このとき ",
        math(String.raw`\sum_{j=1}^{r} X_j \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "（",
        ref("def_finite_sum_of_matrices"),
        " の有限和）の成分もすべて実数である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`r`),
        " についての帰納法で示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{1} X_j = X_1
\qquad (\because \blkref{def_finite_sum_of_matrices})`,
      ),
      paragraph([
        "であり、",
        math(String.raw`X_1`),
        " の成分はすべて実数である（仮定）。",
        math(String.raw`r`),
        " で成り立つと仮定し、成分がすべて実数の ",
        math(String.raw`X_1,\dots,X_{r+1} \in \mathrm{Mat}(m,n,\mathbb{C})`),
        " を取る。",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{r+1} X_j = \Bigl(\sum_{j=1}^{r} X_j\Bigr) + X_{r+1}
\qquad (\because \blkref{def_finite_sum_of_matrices})`,
      ),
      paragraph([
        "である。帰納法の仮定より ",
        math(String.raw`\sum_{j=1}^{r} X_j`),
        " の成分はすべて実数で、",
        math(String.raw`X_{r+1}`),
        " の成分もすべて実数（仮定）なので、",
        ref("sum_of_real_entry_matrices_has_real_entries"),
        "（",
        math(String.raw`A \to \sum_{j=1}^{r} X_j,\ B \to X_{r+1}`),
        "）より ",
        math(String.raw`\sum_{j=1}^{r+1} X_j`),
        " の成分はすべて実数である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の結論で、Σσ_m^x・Σσ_m^zσ_{m+1}^z の成分が実であることを引くために足した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_product_of_real_entry_matrices_has_real_entries",
    kind: "claim",
    title: { text: "成分がすべて実数の行列の積は成分がすべて実数" },
    labels: ["product_of_real_entry_matrices_has_real_entries"],
    statement: [
      paragraph([
        math(String.raw`m,n,p \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`B \in \mathrm{Mat}(n,p,\mathbb{C})`),
        " の成分がすべて実数（",
        ref("def_matrix_with_real_entries"),
        "）とする。このとき ",
        math(String.raw`AB \in \mathrm{Mat}(m,p,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の積）の成分もすべて実数である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        "、",
        math(String.raw`k \in \{1,\dots,p\}`),
        " を任意に取る。仮定（",
        ref("def_matrix_with_real_entries"),
        "）から、各 ",
        math(String.raw`j \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`A_{ij} = (s_j)_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`s_j \in \mathbb{R}`),
        " と、",
        math(String.raw`B_{jk} = (t_j)_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`t_j \in \mathbb{R}`),
        " がある。",
      ]),
      displayMath(String.raw`\begin{aligned}
(AB)_{ik}
&= \sum_{j=1}^{n} A_{ij}B_{jk}
&&(\because \blkref{mat_mult}) \\
&= \sum_{j=1}^{n} (s_j)_{\mathbb{C}}\,(t_j)_{\mathbb{C}}
&&(\because s_j, t_j \text{ の取り方}) \\
&= \sum_{j=1}^{n} (s_jt_j)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product}\ (a \to s_j,\ b \to t_j)\ \text{を}\ n\ \text{個の項へ同時に適用}) \\
&= \Bigl(\sum_{j=1}^{n} s_jt_j\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_finite_sum}\ (m \to n,\ r_j \to s_jt_j))
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\sum_{j=1}^{n} s_jt_j \in \mathbb{R}`),
        "（",
        ref("def_finite_sum_of_real_numbers"),
        "）である。",
        math(String.raw`i, k`),
        " は任意なので ",
        ref("def_matrix_with_real_entries"),
        " の条件が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。trace_power_upper_bound の証明が W の冪の成分を実数として読むのに、成分が実の行列の積の成分が実であることを述べる主張が本文に無かったので足した（power_of_real_symmetric_complex_matrix_is_real_symmetric から引く）。数値検証: sagemath/check/product_of_real_entry_matrices_has_real_entries/。",
      ],
    },
  },
  {
    id: "linear_space_general_001_theorem_tensor_product_basis",
    kind: "theorem",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ", ordinal: 1 },
    title: { text: "クロネッカー積がつくる基底" },
    labels: ["tensor_basis"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、記号は ",
        ref("def_kronecker"),
        " のものとする。",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位を ",
        math(String.raw`E_{ij}`),
        "（",
        math(String.raw`(i,j)`),
        " 成分が ",
        math(String.raw`1`),
        " で他の成分が ",
        math(String.raw`0`),
        "、",
        math(String.raw`i,j\in\{1,2\}`),
        "）、",
        math(String.raw`\mathbb{C}^2`),
        " の標準基底を ",
        math(String.raw`e_1=(1,0),\ e_2=(0,1)`),
        " とする。",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " について",
      ]),
      displayMath(
        String.raw`E_{I,J} := E_{i_1j_1}\boxtimes\cdots\boxtimes E_{i_Mj_M} \in \mathrm{Mat}(2^M,\mathbb{C}),
\qquad
f_I := e_{i_1}\boxtimes\cdots\boxtimes e_{i_M} \in \mathbb{C}^{2^M}`,
      ),
      paragraph(["とおく。次が成り立つ。"]),
      list([
        [
          "(1) 族 ",
          math(String.raw`\left(E_{I,J}\right)_{I,J\in\mathcal{I}_M}`),
          " は ",
          math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
          " の ",
          math(String.raw`\mathbb{C}`),
          "-基底である。特に ",
          math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2^M,\mathbb{C}) = 4^M`),
          "。",
        ],
        [
          "(2) ",
          math(String.raw`\mathcal{B}=\{b_1,b_2,b_3,b_4\}`),
          " を ",
          math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
          " の任意の ",
          math(String.raw`\mathbb{C}`),
          "-基底とするとき、多重添字 ",
          math(String.raw`(a_1,\dots,a_M)\in\{1,2,3,4\}^M`),
          " で添字づけられた ",
          math(String.raw`4^M`),
          " 個の元からなる族",
          math(String.raw`\ \left(b_{a_1}\boxtimes\cdots\boxtimes b_{a_M}\right)_{(a_1,\dots,a_M)\in\{1,2,3,4\}^M}`),
          " は ",
          math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
          " の ",
          math(String.raw`\mathbb{C}`),
          "-基底である。",
        ],
        [
          "(3) ",
          math(String.raw`\{u_1,u_2\}`),
          " を ",
          math(String.raw`\mathbb{C}^2`),
          " の任意の ",
          math(String.raw`\mathbb{C}`),
          "-基底とするとき、族 ",
          math(String.raw`\left(u_{a_1}\boxtimes\cdots\boxtimes u_{a_M}\right)_{(a_1,\dots,a_M)\in\{1,2\}^M}`),
          " は ",
          math(String.raw`\mathbb{C}^{2^M}`),
          " の ",
          math(String.raw`\mathbb{C}`),
          "-基底である。特に ",
          math(String.raw`\left(f_I\right)_{I\in\mathcal{I}_M}`),
          " は ",
          math(String.raw`\mathbb{C}^{2^M}`),
          " の基底であり ",
          math(String.raw`\dim_{\mathbb{C}}\mathbb{C}^{2^M}=2^M`),
          "。",
        ],
      ]),
      paragraph([
        "(1)(2) は ",
        math(String.raw`2^M`),
        " 次の複素正方行列全体 ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の基底についての主張、(3) は ",
        math(String.raw`2^M`),
        " 次元数ベクトル空間 ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の基底についての主張である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: (3) の特別な場合（標準基底）。",
        math(String.raw`(e_i)_t=\delta_{it}`),
        " であるから、",
        math(String.raw`K=(k_1,\dots,k_M)\in\mathcal{I}_M`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(f_I)_{\nu(K)}
&= \prod_{k=1}^{M}(e_{i_k})_{k_k}
&&(\because \blkref{def_kronecker} \text{ のクロネッカー積の成分の定め方}) \\
&= \prod_{k=1}^{M}\delta_{i_kk_k}
&&(\because (e_i)_t=\delta_{it}) \\
&= \begin{cases}1 & (I=K)\\ 0 & (I\neq K)\end{cases}
&&(\because I=K \text{ ならばどの因子も } 1\text{、}
I\neq K \text{ ならば } i_k\neq k_k \text{ となる } k \text{ があってその因子が } 0)
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`f_I`),
        " は第 ",
        math(String.raw`\nu(I)`),
        " 成分だけが ",
        math(String.raw`1`),
        " で他が ",
        math(String.raw`0`),
        " の数ベクトル、つまり ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の標準基底ベクトルである。",
        math(String.raw`\nu`),
        " が全単射だから ",
        math(String.raw`(f_I)_{I\in\mathcal{I}_M}`),
        " は標準基底全体と一致し、これは ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の基底である（任意の ",
        math(String.raw`w=(w_1,\dots,w_{2^M})`),
        " は ",
        math(String.raw`w=\sum_{p=1}^{2^M}w_p\,(\text{第 } p \text{ 標準基底ベクトル})`),
        " と成分比較で一意に書ける）。特に ",
        math(String.raw`\dim_{\mathbb{C}}\mathbb{C}^{2^M}=2^M`),
        "。",
      ]),
      paragraph([
        "Step 2: (1)。同様に ",
        math(String.raw`(E_{ij})_{st}=\delta_{is}\delta_{jt}`),
        " であるから、",
        math(String.raw`K,L\in\mathcal{I}_M`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(E_{I,J}\right)_{\nu(K),\nu(L)}
&= \prod_{k=1}^{M}(E_{i_kj_k})_{k_kl_k}
&&(\because \blkref{def_kronecker} \text{ のクロネッカー積の成分の定め方}) \\
&= \prod_{k=1}^{M}\delta_{i_kk_k}\delta_{j_kl_k}
&&(\because (E_{ij})_{st}=\delta_{is}\delta_{jt}) \\
&= \begin{cases}1 & (I=K \text{ かつ } J=L)\\ 0 & (\text{それ以外})\end{cases}
&&(\because I=K \text{ かつ } J=L \text{ ならばどの因子も } 1\text{、}
\text{そうでなければ } 0 \text{ となる因子がある})
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`E_{I,J}`),
        " は ",
        math(String.raw`(\nu(I),\nu(J))`),
        " 成分だけが ",
        math(String.raw`1`),
        " で他が ",
        math(String.raw`0`),
        " の ",
        math(String.raw`2^M`),
        " 次行列（",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の行列単位）である。",
        math(String.raw`\nu`),
        " が全単射だから ",
        math(String.raw`(E_{I,J})_{I,J\in\mathcal{I}_M}`),
        " は ",
        math(String.raw`2^M`),
        " 次の行列単位全体と一致する。任意の ",
        math(String.raw`A=(a_{pq})\in\mathrm{Mat}(2^M,\mathbb{C})`),
        " は成分比較により ",
        math(String.raw`A=\sum_{p,q=1}^{2^M}a_{pq}\,(\text{第 }(p,q)\text{ 行列単位})`),
        " と一意に書けるから、これは基底であり、元数は ",
        math(String.raw`2^M\cdot 2^M=4^M`),
        "。よって ",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2^M,\mathbb{C})=4^M`),
        "。",
      ]),
      paragraph([
        "Step 3: 有限次元線型空間についての 2 つの事実。以下で次を使う。",
      ]),
      list([
        [
          "(a) ",
          math(String.raw`d`),
          " 次元 ",
          math(String.raw`\mathbb{C}`),
          "-線型空間を張る有限族の元数は ",
          math(String.raw`d`),
          " 以上である。",
        ],
        [
          "(b) したがって、",
          math(String.raw`d`),
          " 次元 ",
          math(String.raw`\mathbb{C}`),
          "-線型空間を張る、ちょうど ",
          math(String.raw`d`),
          " 個の元からなる族は基底である。実際、線型独立でなければ、ある元が他の元の線型結合になり、その元を除いた ",
          math(String.raw`d-1`),
          " 個の族がなお全体を張るので (a) に反する。",
        ],
      ]),
      paragraph([
        "Step 4: (2)。",
        math(String.raw`\mathcal{B}=\{b_1,\dots,b_4\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の基底だから、各行列単位 ",
        math(String.raw`E_{ij}`),
        "（",
        math(String.raw`i,j\in\{1,2\}`),
        "）は",
      ]),
      displayMath(
        String.raw`E_{ij} = \sum_{a=1}^{4} d^{(ij)}_{a}\,b_a \qquad (d^{(ij)}_{a}\in\mathbb{C})`,
      ),
      paragraph([
        "と書ける。",
        math(String.raw`I,J\in\mathcal{I}_M`),
        " を固定し、",
        math(String.raw`E_{I,J}=E_{i_1j_1}\boxtimes\cdots\boxtimes E_{i_Mj_M}`),
        " の第 ",
        math(String.raw`1`),
        " 因子から順にこの展開を代入する。",
        ref("kronecker_multilinear"),
        " を第 ",
        math(String.raw`j`),
        " 因子に適用する操作を ",
        math(String.raw`j=1,2,\dots,M`),
        " と繰り返す（",
        math(String.raw`j`),
        " についての帰納法）と、",
      ]),
      displayMath(
        String.raw`E_{I,J}
= \sum_{(a_1,\dots,a_M)\in\{1,2,3,4\}^M}
\left(\prod_{k=1}^{M} d^{(i_kj_k)}_{a_k}\right)
\left(b_{a_1}\boxtimes\cdots\boxtimes b_{a_M}\right)
\quad (\because \text{各因子についての線型性})`,
      ),
      paragraph([
        "を得る（各段階で和の項数が ",
        math(String.raw`4`),
        " 倍になり、",
        math(String.raw`M`),
        " 段階で ",
        math(String.raw`4^M`),
        " 項になる）。よって ",
        math(String.raw`E_{I,J}`),
        " は族 ",
        math(String.raw`\left(b_{a_1}\boxtimes\cdots\boxtimes b_{a_M}\right)`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合である。Step 2 より ",
        math(String.raw`(E_{I,J})`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " を張るから、",
        math(String.raw`\left(b_{a_1}\boxtimes\cdots\boxtimes b_{a_M}\right)`),
        " も ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " を張る（既知の基底の各元がこの候補族の線型結合で書けるので、既知の基底が張る空間は候補族が張る空間に含まれる）。この族の元数は ",
        math(String.raw`\#\{1,2,3,4\}^M=4^M`),
        " であり、Step 2 より ",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2^M,\mathbb{C})=4^M`),
        " であるから、Step 3 (b) よりこの族は基底である。",
      ]),
      paragraph([
        "Step 5: (3) の一般の基底の場合。Step 4 とまったく同じ議論を、",
        math(String.raw`e_i=\sum_{a=1}^{2}d^{(i)}_{a}u_a`),
        "、",
        ref("kronecker_multilinear"),
        " の数ベクトル版、Step 1 の ",
        math(String.raw`(f_I)`),
        " が ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " を張ること、",
        math(String.raw`\#\{1,2\}^M=2^M=\dim_{\mathbb{C}}\mathbb{C}^{2^M}`),
        " に対して行えばよい。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文(Typst)のステートメントは「単一のテンソル積が基底である」と読め、" +
          "かつ V の次元とテンソル冪の階数に同じ記号 m を二重使用していた。" +
          "Lean 形式化(lean/Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/TheoremTensorBasis.lean)で判明したため、" +
          "原文側を修正し本ブロックも同期済み。",
        "さらに本ブロックは「任意の体 K 上の任意の n 次元線型空間のテンソル冪の基底」という" +
          "抽象テンソル積の一般論だった。README 2 節がまさにこの主張（基底のテンソル積が基底）を" +
          "本文に置くことを禁じているため、クロネッカー積（<def_kronecker>）についての具体的な主張" +
          "（行列単位のクロネッカー積が Mat(2^M,C) の基底、次元は 4^M）へ置き換えた。" +
          "ラベル <tensor_basis> は参照元（<centralizer_is_scalar>, <Z_Y_linearly_independent>, " +
          "<def_end_iso>, <Z_Y_generate_algebra>, 008 章）を保つためそのままにしている。" +
          "抽象的な見方は notes/002_linear_space_general.ts へ退避した。",
        "参照元が必要とする形はそれぞれ、(1) 行列単位（<centralizer_is_scalar>, <def_end_iso>）、" +
          "(2) 一般の基底 {I,σ^x,σ^y,σ^z}（<Z_Y_linearly_independent>, <Z_Y_generate_algebra>, 008 章）、" +
          "(3) 数ベクトルの標準基底（<def_end_iso> の F の基底）であるため、3 つの形を並べた。",
        "式変形の書き方の統一（2026-08-10）。Step 1 と Step 2 の式が、3 つの等号を 1 行へ潰したうえで" +
          "行末の (∵ ⊠ の定義) を式全体へ 1 つだけ付けていた。どの等号がその根拠によるのかが" +
          "式から読み取れないので、1 行 1 等号の鎖へ分け、各行の末尾に根拠を置いた" +
          "（クロネッカー積の成分の定め方・成分の定義・添字の一致による場合分けの 3 つが" +
          "別々の根拠であることが、これで式の上に現れる）。あわせて、クロネッカー積の成分を" +
          "取り出す段を明示的な 1 段として書き（Step 2 では (E_{i_k j_k})_{k_k l_k} の積を経由する）、" +
          "引いたブロック <def_kronecker> への参照を式の直後に置いた。" +
          "主張と証明の中身、および Step の分け方は変えていない。",
        "2026-09-02 の式変形統一で、Step 1 と Step 2 の二本の鎖の根拠 6 行を行中の \\quad (\\because …) から" +
          "他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠・参照は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_002_claim_scalar_identity_commutes",
    kind: "claim",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ", ordinal: 2 },
    title: { tex: String.raw`c \cdot I \text{ は全行列と可換}` },
    labels: ["scalar_identity_commutes"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " について、",
      ]),
      displayMath(String.raw`[c \cdot I_{\mathrm{Mat}(n,\mathbb{C})},\, A] = O`),
      paragraph([
        "行列積は ", ref("mat_mult"),
        "、交換子は ", ref("commutator_via_anticommutators"),
        "、単位行列 ", math(String.raw`I_{\mathrm{Mat}(n,\mathbb{C})}`), " は ", ref("def_identity_matrix"),
        "、スカラー倍は ", ref("def_matrix_scalar_multiple"),
        "、差は ", ref("def_matrix_difference"),
        "、零行列 ", math(String.raw`O \in \mathrm{Mat}(n,\mathbb{C})`), " は ", ref("def_zero_matrix"),
        " の定義を用いる。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`),
        " と書く。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[c \cdot I,\, A]
&= (c \cdot I)A - A(c \cdot I)
&&\bigl(\because\ \text{交換子の定義 }\blkref{commutator_via_anticommutators}\bigr) \\
&= c(IA) - A(c \cdot I)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\bigr) \\
&= c(IA) - c(AI)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr) \\
&= cA - c(AI)
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr) \\
&= cA - cA
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\bigr) \\
&= O
&&\bigl(\because\ \blkref{matrix_difference_zero_iff_equal}\ \text{の}\ \Leftarrow\ \text{を}\ cA = cA\ \text{へ適用}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-10）。もとの鎖はどの行にも根拠が書かれておらず、" +
          "さらに第 2 段が 2 つの定理を同時に適用していた" +
          "（スカラー倍を積の外へ出すことと、単位行列を消すこと）。" +
          "この 2 つを別々の段に割り、全 4 段のそれぞれに行末の (∵ …) を付けた。" +
          "段は増えており、減った段は無い。主張と証明の中身は変えていない。",
        "2026-09-01 の式変形統一で、四段の根拠を行中の \\quad (\\because …) から" +
          "他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠は変えていない。",
        "2026-11-01: 根拠を名前だけで書いていた段（「スカラー倍は行列の積の外へ出せる」「単位行列の性質 IA=A, AI=A」「同じ元の差は零行列」）を、" +
          "左右の因子それぞれの主張と単位元の左右それぞれの主張への参照に替え、二つの主張を同時に使っていた二段を四段に割った。" +
          "右辺の 0 を def_zero_matrix の零行列 O に、I を def_identity_matrix の I_{Mat(n,C)} にした。",
      ],
    },
  },
  {
    id: "linear_space_general_004_lemma_centralizer_is_scalar",
    kind: "claim",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ", ordinal: 4 },
    title: { tex: String.raw`\mathrm{Mat}(2^M,\mathbb{C}) \text{ の中で全元と可換な元はスカラー}` },
    labels: ["centralizer_is_scalar"],
    statement: [
      paragraph(["行列単位の成分積は ", ref("mat_mult"), "、複素係数の演算は ", ref("complex_numbers_form_a_field"), " による。"]),
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`W \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " が、すべての ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について ",
        math(String.raw`Wx = xW`),
        " を満たすならば、ある ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在して ",
        math(String.raw`W = c\cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の行列単位。",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位を",
      ]),
      displayMath(
        String.raw`E_{11}=\begin{pmatrix}1&0\\0&0\end{pmatrix},\quad
E_{12}=\begin{pmatrix}0&1\\0&0\end{pmatrix},\quad
E_{21}=\begin{pmatrix}0&0\\1&0\end{pmatrix},\quad
E_{22}=\begin{pmatrix}0&0\\0&1\end{pmatrix}`,
      ),
      paragraph([
        "とする。任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}\in\mathrm{Mat}(2,\mathbb{C})`),
        " に対し",
      ]),
      displayMath(
        String.raw`A = a_{11}E_{11} + a_{12}E_{12} + a_{21}E_{21} + a_{22}E_{22} \quad (\because \text{成分比較})`,
      ),
      paragraph([
        " が成り立つので ",
        math(String.raw`\mathcal{E}_0 := \{E_{11},E_{12},E_{21},E_{22}\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " を張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{E}_0`),
        " であるから ",
        math(String.raw`\mathcal{E}_0`),
        " は基底である。成分計算により、",
        math(String.raw`i,j,k,l\in\{1,2\}`),
        " について",
      ]),
      displayMath(
        String.raw`E_{ij}E_{kl} = \delta_{jk}E_{il} \quad (\because \text{行列の積の成分計算})`,
      ),
      paragraph([
        "（",
        math(String.raw`\delta_{jk}`),
        " は Kronecker のデルタ）。特に ",
        math(String.raw`E_{11}+E_{22}=\begin{pmatrix}1&0\\0&1\end{pmatrix}=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "。多重添字 ",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\{1,2\}^M`),
        " について ",
        math(String.raw`E_{IJ}:=E_{i_1 j_1}\boxtimes E_{i_2 j_2}\boxtimes\cdots\boxtimes E_{i_M j_M}\in\mathrm{Mat}(2^M,\mathbb{C})`),
        " とおく（",
        ref("def_kronecker"),
        " のクロネッカー積。これは ",
        math(String.raw`2^M`),
        " 次の複素行列である）。",
        math(String.raw`\mathcal{E}:=\{E_{IJ}:I,J\in\{1,2\}^M\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の基底である（",
        ref("tensor_basis"),
        " (1)）。その元数は ",
        math(String.raw`\#\mathcal{E}=(2^M)^2=4^M`),
        "。",
      ]),
      paragraph([
        "Step 2: 行列単位 ",
        math(String.raw`E_{IJ}`),
        " の積公式。",
        math(String.raw`I,J,K,L\in\{1,2\}^M`),
        " について、",
        ref("kronecker_product_rule"),
        " (1)、",
        ref("kronecker_multilinear"),
        " と Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{IJ} E_{KL}
&= (E_{i_1 j_1}\boxtimes\cdots\boxtimes E_{i_M j_M})(E_{k_1 l_1}\boxtimes\cdots\boxtimes E_{k_M l_M}) \\
&= (E_{i_1 j_1}E_{k_1 l_1})\boxtimes\cdots\boxtimes(E_{i_M j_M}E_{k_M l_M})
&&(\because \text{クロネッカー積の積の規則}) \\
&= (\delta_{j_1 k_1}E_{i_1 l_1})\boxtimes\cdots\boxtimes(\delta_{j_M k_M}E_{i_M l_M})
&&(\because E_{ij}E_{kl}=\delta_{jk}E_{il}) \\
&= \left(\prod_{r=1}^M \delta_{j_r k_r}\right)E_{IL}
&&(\because \text{各因子についての線型性を } M \text{ 回})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta_{JK}:=\prod_{r=1}^M \delta_{j_r k_r}`),
        " とおくと、これは ",
        math(String.raw`J=K`),
        " のとき ",
        math(String.raw`1`),
        "、そうでなければ ",
        math(String.raw`0`),
        " であるから ",
        math(String.raw`E_{IJ}E_{KL}=\delta_{JK}E_{IL}`),
        "。また各因子に ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}=E_{11}+E_{22}`),
        " を代入して展開すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
I_{\mathrm{Mat}(2^M,\mathbb{C})}
&= I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}
&&(\because \text{クロネッカー積の積の規則 (2) を右辺から左辺へ}) \\
&= (E_{11}+E_{22})\boxtimes\cdots\boxtimes(E_{11}+E_{22})
&&(\because I_{\mathrm{Mat}(2,\mathbb{C})}=E_{11}+E_{22}) \\
&= \sum_{P=(p_1,\dots,p_M)\in\{1,2\}^M}
   E_{p_1 p_1}\boxtimes\cdots\boxtimes E_{p_M p_M}
&&(\because \text{各因子についての線型性を } M \text{ 回}) \\
&= \sum_{P\in\{1,2\}^M} E_{PP}
&&(\because E_{PP} \text{ の定め方})
\end{aligned}`,
      ),
      paragraph([
        "（引いたのは ",
        ref("kronecker_product_rule"),
        " (2) と ",
        ref("kronecker_multilinear"),
        " である）。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`W`),
        " を行列単位で展開し、可換性から係数を決定する。",
        math(String.raw`\mathcal{E}`),
        " は基底であるから ",
        math(String.raw`W`),
        " は一意に ",
        math(String.raw`W=\sum_{I,J\in\{1,2\}^M} w_{IJ}E_{IJ}`),
        "（",
        math(String.raw`w_{IJ}\in\mathbb{C}`),
        "）と展開できる。仮定より各 ",
        math(String.raw`E_{KL}`),
        " について ",
        math(String.raw`W E_{KL}=E_{KL} W`),
        "。左辺は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W E_{KL}
&= \left(\sum_{I,J} w_{IJ}E_{IJ}\right)E_{KL}
&&(\because W \text{ の基底 } \mathcal{E} \text{ による展開}) \\
&= \sum_{I,J} w_{IJ}(E_{IJ}E_{KL})
&&(\because \text{積の双線型性}) \\
&= \sum_{I,J} w_{IJ}\delta_{JK}E_{IL}
&&(\because \text{Step 2 の積公式}) \\
&= \sum_{I\in\{1,2\}^M} w_{IK}E_{IL}
&&(\because \delta_{JK} \text{ は } J=K \text{ でのみ非零})
\end{aligned}`,
      ),
      paragraph(["右辺は"]),
      displayMath(
        String.raw`\begin{aligned}
E_{KL} W
&= E_{KL}\left(\sum_{I,J} w_{IJ}E_{IJ}\right)
&&(\because W \text{ の基底 } \mathcal{E} \text{ による展開}) \\
&= \sum_{I,J} w_{IJ}(E_{KL}E_{IJ})
&&(\because \text{積の双線型性}) \\
&= \sum_{I,J} w_{IJ}\delta_{LI}E_{KJ}
&&(\because \text{Step 2 の積公式}) \\
&= \sum_{J\in\{1,2\}^M} w_{LJ}E_{KJ}
&&(\because \delta_{LI} \text{ は } I=L \text{ でのみ非零})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mathcal{E}`),
        " は基底であるから両辺の係数は一致する。任意に ",
        math(String.raw`P,Q\in\{1,2\}^M`),
        " を固定し ",
        math(String.raw`E_{PQ}`),
        " の係数を比較する。",
      ]),
      paragraph([
        "場合 1: ",
        math(String.raw`Q=L`),
        " かつ ",
        math(String.raw`P=K`),
        " のとき。左辺で ",
        math(String.raw`E_{PL}`),
        " の係数は ",
        math(String.raw`w_{PK}=w_{KK}`),
        "、右辺で ",
        math(String.raw`E_{KQ}`),
        " の係数は ",
        math(String.raw`w_{LQ}=w_{LL}`),
        " であるから ",
        math(String.raw`w_{KK}=w_{LL}`),
        "。これは任意の ",
        math(String.raw`K,L`),
        " で成立するから対角係数は ",
        math(String.raw`K`),
        " によらない定数 ",
        math(String.raw`c:=w_{KK}`),
        " である。",
      ]),
      paragraph([
        "場合 2: ",
        math(String.raw`K\neq L`),
        " とし ",
        math(String.raw`P=K,\ Q=K`),
        " のとき（",
        math(String.raw`E_{KK}`),
        " の係数比較）。第 2 添字が ",
        math(String.raw`K\neq L`),
        " なので左辺に ",
        math(String.raw`E_{KK}`),
        " は現れず係数は ",
        math(String.raw`0`),
        "、右辺で ",
        math(String.raw`E_{KK}`),
        " の係数は ",
        math(String.raw`w_{LK}`),
        " であるから ",
        math(String.raw`w_{LK}=0`),
        "。すなわち ",
        math(String.raw`I\neq J`),
        " なる非対角係数 ",
        math(String.raw`w_{IJ}`),
        " はすべて ",
        math(String.raw`0`),
        "。",
      ]),
      paragraph(["Step 4: 結論。"]),
      displayMath(
        String.raw`\begin{aligned}
W
&= \sum_{I,J\in\{1,2\}^M} w_{IJ}E_{IJ}
&&(\because \text{Step 3 の } W \text{ の基底 } \mathcal{E} \text{ による展開}) \\
&= \sum_{P\in\{1,2\}^M} w_{PP}E_{PP}
&&(\because \text{Step 3: 非対角係数は } 0) \\
&= \sum_{P\in\{1,2\}^M} c\,E_{PP}
&&(\because \text{Step 3: 対角係数は共通の } c) \\
&= c\sum_{P\in\{1,2\}^M} E_{PP}
&&(\because \text{和のスカラー倍}) \\
&= c\cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because I_{\mathrm{Mat}(2^M,\mathbb{C})}=\sum_{P\in\{1,2\}^M} E_{PP})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "抽象テンソル積の記法を廃した。Mat(2,C)^{⊗M}（抽象テンソル冪）を <def_kronecker> の" +
          "クロネッカー積が住む具体的な空間 Mat(2^M,C) へ、I_{(Mat(2,C))^{⊗M}} を 2^M 次の" +
          "単位行列 I_{Mat(2^M,C)} へ置き換えた（README のゴール設定 2 節に従う）。",
        "2026-08-17: 式変形の書き方の統一。Step 3 の二本の鎖の第 1 段（W E_{KL}・E_{KL} W を展開で書く行）と" +
          "Step 4 の鎖の第 1 段（W の展開）に根拠が無かったので、行末に (∵ W の基底 𝓔 による展開) を置いた。" +
          "段は増減せず、主張も証明の筋も変えていない。",
        "2026-09-01 の式変形統一で、Step 3 の二本の鎖と Step 4 の鎖に行中の \\quad(\\because …) で" +
          "置かれていた根拠 13 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。" +
          "内容・式変形・根拠・参照は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_002b_definition_matrix_norm",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 3 },
    title: { text: "数ベクトル・行列のノルムと収束" },
    labels: ["def_matrix_norm"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`d, n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
      ]),
      paragraph([
        math(String.raw`|\cdot| : K \to \mathbb{R}_{\geq 0}`),
        " を、",
        math(String.raw`K=\mathbb{R}`),
        " のときは実数の絶対値、",
        math(String.raw`K=\mathbb{C}`),
        " のときは ",
        ref("def_abs_arg"),
        " の絶対値とする（",
        ref("abs_basic_properties"),
        " (6) より、",
        math(String.raw`\mathbb{R}`),
        " を ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        "（", ref("inclusion_rr_to_cc"), "）で ",
        math(String.raw`\mathbb{C}`),
        " に埋め込んだとき両者は一致する）。",
      ]),
      paragraph([
        math(String.raw`w = (w_1,\dots,w_d) \in K^d`),
        " のノルムを",
      ]),
      displayMath(
        String.raw`\|w\| := \sqrt{\sum_{i=1}^{d} |w_i|^2}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`,
      ),
      paragraph([
        "と定める。また ",
        math(String.raw`A = (a_{ij})_{1\le i,j\le n} \in \mathrm{Mat}(n,K)`),
        " のノルムを",
      ]),
      displayMath(
        String.raw`\|A\| := \sqrt{\sum_{i=1}^{n}\sum_{j=1}^{n} |a_{ij}|^2}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`,
      ),
      paragraph([
        "と定める（いずれも根号の中は非負実数の有限和なので ",
        ref("definition_of_sqrt_r_positive"),
        " により定まる）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(n,K)`),
        " の列 ",
        math(String.raw`(A_N)_{N \in \mathbb{Z}_{\ge 0}}`),
        " と ",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        " について、",
      ]),
      displayMath(
        String.raw`A_N \to A \overset{\mathrm{def}}{\Longleftrightarrow}
\|A_N - A\| \to 0 \ (N\to\infty)`,
      ),
      paragraph([
        "と定める（右辺は実数列 ",
        math(String.raw`(\|A_N-A\|)_N`),
        " の ",
        math(String.raw`0`),
        " への収束）。このとき ",
        math(String.raw`A`),
        " を ",
        math(String.raw`(A_N)`),
        " の極限といい ",
        math(String.raw`A = \lim_{N\to\infty} A_N`),
        " と書く。さらに ",
        math(String.raw`B_0, B_1, \dots \in \mathrm{Mat}(n,K)`),
        " について、部分和 ",
        math(String.raw`S_N := \sum_{m=0}^{N} B_m`),
        " が ",
        math(String.raw`S`),
        " に収束するとき",
      ]),
      displayMath(String.raw`\sum_{m=0}^{\infty} B_m := S`),
      paragraph(["と書く。"]),
      paragraph([
        math(String.raw`K^d`),
        " の列の収束も同様に ",
        math(String.raw`\|w_N - w\| \to 0`),
        " で定める。",
        math(String.raw`K`),
        " の列 ",
        math(String.raw`(a_N)_{N \in \mathbb{Z}_{\ge 0}}`),
        " と ",
        math(String.raw`a \in K`),
        " についても、",
        math(String.raw`a_N \to a`),
        " を実数列の収束 ",
        math(String.raw`|a_N - a| \to 0`),
        " で定める。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文は行列ノルムの劣乗法性" +
          "（labels: matrix_norm_submultiplicativity）や exp 級数の収束（labels: exp_converges）で" +
          "ノルム記号を使うが、ノルムそのものの定義がどこにも無かったため、" +
          "初出の直前に置いた。採用したのは Frobenius ノルム（成分の平方和の平方根）で、" +
          "これは 005 章の M(n;C) の内積・ノルムの定義（原文では TODO）が意図する" +
          "Hilbert--Schmidt 内積 ⟨A,B⟩ = tr(A^* B) から定まるノルムと同一である。",
          "K の列の収束 a_N → a :⇔ |a_N − a| → 0 は、数の exp が指数級数の部分和の極限であること（labels: scalar_exp_is_limit_of_partial_sums）の主張の収束の意味を定めるために、K^d の列の収束と並べて足した。",
      ],
    },
  },
  {
    id: "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 3 },
    title: { text: "ノルムの基本性質（非退化性・斉次性・三角不等式）" },
    labels: ["matrix_norm_triangle_inequality"],
    statement: [
      paragraph([
        ref("def_matrix_norm"),
        " のノルムについて、",
        math(String.raw`A, B \in \mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`c \in K`),
        " に対して次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\|A\| \ge 0`),
          " であり、",
          math(String.raw`\|A\| = 0 \iff A = O`),
          "（",
          math(String.raw`O`),
          " は零行列）。",
        ],
        ["(2) ", math(String.raw`\|cA\| = |c|\,\|A\|`), "。"],
        ["(3) ", math(String.raw`\|A+B\| \le \|A\| + \|B\|`), "。"],
        [
          "(4) ",
          ref("def_matrix_norm"),
          " の意味での極限は、存在すれば一意である。すなわち ",
          math(String.raw`A_N \to A`),
          " かつ ",
          math(String.raw`A_N \to A'`),
          " ならば ",
          math(String.raw`A = A'`),
          "。",
        ],
      ]),
      paragraph([
        math(String.raw`K^d`),
        " のノルムについても同じ 4 つが成り立つ（証明は成分の添字を 1 重にするだけで同一）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`A=(a_{ij})`),
        "、",
        math(String.raw`B=(b_{ij})`),
        " とおき、和は ",
        math(String.raw`1\le i,j\le n`),
        " の全体にわたるものとする。",
      ]),
      paragraph([
        "Step 0: 補題（非負実数の平方の単調性）。",
        math(String.raw`u,v\in\mathbb{R}_{\ge 0}`),
        " について",
      ]),
      displayMath(String.raw`u\le v \iff u^2\le v^2`),
      paragraph([
        "が成り立つ。実際、", math(String.raw`u\le v`), " ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
u^2&=u\cdot u &&(\because\ \text{平方の定義})\\
&\le v\cdot u &&(\because\ u\le v,\ u\ge0)\\
&\le v\cdot v &&(\because\ u\le v,\ v\ge0)\\
&=v^2 &&(\because\ \text{平方の定義})
\end{aligned}`),
      paragraph([
        "である。逆に ", math(String.raw`u>v\ (\ge 0)`), " ならば ",
        math(String.raw`u>0`), " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
u^2&=u\cdot u &&(\because\ \text{平方の定義})\\
&>v\cdot u &&(\because\ u>v,\ u>0)\\
&\ge v\cdot v &&(\because\ u>v,\ v\ge0)\\
&=v^2 &&(\because\ \text{平方の定義})
\end{aligned}`),
      paragraph([
        "であるから、対偶により ",
        math(String.raw`u^2\le v^2\Rightarrow u\le v`),
        "。特に ",
        math(String.raw`u^2=v^2\Rightarrow u=v`),
        "。",
      ]),
      paragraph([
        "Step 1: 絶対値の性質。",
        math(String.raw`z,w\in K`),
        " について",
      ]),
      displayMath(
        String.raw`|z|\ge 0, \qquad |zw|=|z|\,|w|, \qquad |z+w|\le|z|+|w|,
\qquad \left(|z|=0\iff z=0\right)`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`K=\mathbb{C}`),
        " のときは ",
        ref("abs_basic_properties"),
        " (3)(4)(5) と ",
        ref("def_abs_arg"),
        "（値域が ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        "）による。",
        math(String.raw`K=\mathbb{R}`),
        " のときは、",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " が和と積を保つこと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\iota_{\mathbb{R}\to\mathbb{C}}(x)+\iota_{\mathbb{R}\to\mathbb{C}}(y)
&= (x,0)+(y,0)
&&(\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ の定め方}) \\
&= (x+y,0)
&&(\because \text{複素数の和の定め方}) \\
&= \iota_{\mathbb{R}\to\mathbb{C}}(x+y)
&&(\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ の定め方})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\iota_{\mathbb{R}\to\mathbb{C}}(x)\cdot\iota_{\mathbb{R}\to\mathbb{C}}(y)
&= (x,0)\cdot(y,0)
&&(\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ の定め方}) \\
&= (xy-0\cdot 0,\ x\cdot 0+0\cdot y)
&&(\because \text{複素数の積の定め方}) \\
&= (xy,0)
&&(\because 0 \text{ を掛けた項が消えること}) \\
&= \iota_{\mathbb{R}\to\mathbb{C}}(xy)
&&(\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ の定め方})
\end{aligned}`,
      ),
      paragraph([
        "と ",
        ref("abs_basic_properties"),
        " (6) を組み合わせて同じ 4 つの性質が従う。たとえば ",
        math(String.raw`x,y\in\mathbb{R}`),
        " について ",
        math(String.raw`|x+y|=\left|\iota_{\mathbb{R}\to\mathbb{C}}(x+y)\right|
=\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)+\iota_{\mathbb{R}\to\mathbb{C}}(y)\right|
\le\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)\right|+\left|\iota_{\mathbb{R}\to\mathbb{C}}(y)\right|=|x|+|y|`),
        " であり、乗法性・非負性・非退化性も同様である。",
      ]),
      paragraph([
        "Step 2: (1)。",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\|A\|\ge 0`),
        "。また Step 0 より ",
        math(String.raw`\|A\|=0`),
        " と ",
        math(String.raw`\|A\|^2=0`),
        " は同値であり、",
      ]),
      displayMath(
        String.raw`\|A\|^2=\sum_{i,j}|a_{ij}|^2`,
      ),
      paragraph([
        "は非負実数の有限和であるから、",
        math(String.raw`\|A\|^2=0`),
        " と「すべての ",
        math(String.raw`i,j`),
        " について ",
        math(String.raw`|a_{ij}|^2=0`),
        "」は同値（非負数の有限和が ",
        math(String.raw`0`),
        " ならば各項が ",
        math(String.raw`0`),
        "、逆も明らか）。Step 1 より ",
        math(String.raw`|a_{ij}|=0\iff a_{ij}=0`),
        " であるから ",
        math(String.raw`\|A\|=0\iff A=O`),
        "。",
      ]),
      paragraph(["Step 3: (2)。Step 1 の乗法性より、"]),
      displayMath(
        String.raw`\begin{aligned}
\|cA\|^2
&= \sum_{i,j}|c\,a_{ij}|^2
&&(\because \text{ノルムの定め方と } (cA)_{ij}=c\,a_{ij}) \\
&= \sum_{i,j}\left(|c|\,|a_{ij}|\right)^2
&&(\because \text{Step 1 の乗法性 } |zw|=|z||w|) \\
&= \sum_{i,j}|c|^2\,|a_{ij}|^2
&&(\because \text{積の平方は平方の積}) \\
&= |c|^2\sum_{i,j}|a_{ij}|^2
&&(\because \text{有限和についての分配律}) \\
&= |c|^2\,\|A\|^2
&&(\because \text{ノルムの定め方}) \\
&= \left(|c|\,\|A\|\right)^2
&&(\because \text{積の平方は平方の積})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\|cA\|\ge 0`),
        " かつ ",
        math(String.raw`|c|\,\|A\|\ge 0`),
        " であるから Step 0 より ",
        math(String.raw`\|cA\|=|c|\,\|A\|`),
        "。",
      ]),
      paragraph([
        "Step 4: 有限列に対する Cauchy--Schwarz の不等式。",
        math(String.raw`m\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`u_1,\dots,u_m,v_1,\dots,v_m\in\mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\left(\sum_{k=1}^{m}u_kv_k\right)^2
\le \left(\sum_{k=1}^{m}u_k^2\right)\left(\sum_{k=1}^{m}v_k^2\right)`,
      ),
      paragraph([
        "が成り立つ。実際 ",
        math(String.raw`P:=\sum_k u_k^2,\ Q:=\sum_k v_k^2,\ R:=\sum_k u_kv_k`),
        " とおく。",
        math(String.raw`Q=0`),
        " のときは非負数の有限和が ",
        math(String.raw`0`),
        " であることから各 ",
        math(String.raw`v_k^2=0`),
        " すなわち ",
        math(String.raw`v_k=0`),
        " となり ",
        math(String.raw`R=0`),
        " であるから ",
        math(String.raw`R^2=0=PQ`),
        "。",
        math(String.raw`Q>0`),
        " のときは、任意の ",
        math(String.raw`t\in\mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le\sum_{k=1}^{m}(u_k-tv_k)^2
&&(\because \text{実数の平方は非負であり、非負数の有限和は非負}) \\
&= \sum_{k=1}^{m}\left(u_k^2-2tu_kv_k+t^2v_k^2\right)
&&(\because \text{分配律}) \\
&= P-2tR+t^2Q
&&(\because P,\ Q,\ R \text{ の置き方と有限和の分解})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`t:=R/Q`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le P-2\frac{R}{Q}R+\left(\frac{R}{Q}\right)^2Q
&&(\because \text{上の不等式に } t=R/Q \text{ を代入した}) \\
&= P-2\frac{R^2}{Q}+\frac{R^2}{Q}
&&(\because Q>0 \text{ による約分}) \\
&= P-\frac{R^2}{Q}
&&(\because \text{同類項をまとめた})
\end{aligned}`,
      ),
      paragraph(["となる。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
R^2
&= \frac{R^2}{Q}\cdot Q
&&(\because Q>0 \text{ と } \mathbb{R} \text{ の四則}) \\
&\le P\cdot Q
&&(\because \text{直前の } 0\le P-R^2/Q \text{ の移項による } R^2/Q\le P \text{ と、両辺に正の数 } Q \text{ を掛けても順序が保たれること})
\end{aligned}`,
      ),
      paragraph([
        "を得る。すなわち ",
        math(String.raw`R^2\le PQ`),
        "。",
      ]),
      paragraph([
        "Step 5: (3)。Step 1 の三角不等式と Step 0 より、各 ",
        math(String.raw`i,j`),
        " について ",
        math(String.raw`|a_{ij}+b_{ij}|\le|a_{ij}|+|b_{ij}|`),
        " であり、両辺とも非負なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|a_{ij}+b_{ij}|^2
&\le\left(|a_{ij}|+|b_{ij}|\right)^2
&&(\because \text{Step 0 を } u=|a_{ij}+b_{ij}|,\ v=|a_{ij}|+|b_{ij}| \text{ に当てた}) \\
&= |a_{ij}|^2+2|a_{ij}||b_{ij}|+|b_{ij}|^2
&&(\because \text{分配律})
\end{aligned}`,
      ),
      paragraph(["これを ", math(String.raw`i,j`), " について加えると、"]),
      displayMath(
        String.raw`\begin{aligned}
\|A+B\|^2
&= \sum_{i,j}|a_{ij}+b_{ij}|^2
&&(\because \text{ノルムの定め方と } (A+B)_{ij}=a_{ij}+b_{ij}) \\
&\le \sum_{i,j}\left(|a_{ij}|^2+2|a_{ij}||b_{ij}|+|b_{ij}|^2\right)
&&(\because \text{上の各項ごとの不等式を } i,j \text{ について加えた}) \\
&= \sum_{i,j}|a_{ij}|^2+2\sum_{i,j}|a_{ij}||b_{ij}|+\sum_{i,j}|b_{ij}|^2
&&(\because \text{有限和の分解と分配律}) \\
&= \|A\|^2+2\sum_{i,j}|a_{ij}||b_{ij}|+\|B\|^2
&&(\because \text{ノルムの定め方})
\end{aligned}`,
      ),
      paragraph([
        "ここで Step 4 を ",
        math(String.raw`m=n^2`),
        " 個の添字 ",
        math(String.raw`(i,j)`),
        " について ",
        math(String.raw`u_{(i,j)}=|a_{ij}|,\ v_{(i,j)}=|b_{ij}|`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{i,j}|a_{ij}||b_{ij}|\right)^2
&\le\left(\sum_{i,j}|a_{ij}|^2\right)\left(\sum_{i,j}|b_{ij}|^2\right)
&&(\because \text{Step 4}) \\
&= \|A\|^2\|B\|^2
&&(\because \text{ノルムの定め方}) \\
&= \left(\|A\|\,\|B\|\right)^2
&&(\because \text{積の平方は平方の積})
\end{aligned}`,
      ),
      paragraph(["である。また"]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \sum_{i,j}|a_{ij}||b_{ij}|
&&(\because\ \text{非負実数の有限和は非負}) \\
0
&\le \|A\|\,\|B\|
&&(\because\ \text{ノルムは非負であり、非負実数の積は非負}) \\
\sum_{i,j}|a_{ij}||b_{ij}|
&\le \|A\|\,\|B\|
&&(\because\ \text{直前の平方の不等式と Step 0})
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
\|A+B\|^2
&\le\|A\|^2+2\sum_{i,j}|a_{ij}||b_{ij}|+\|B\|^2
&&(\because \text{上の式変形}) \\
&\le\|A\|^2+2\|A\|\,\|B\|+\|B\|^2
&&(\because \sum_{i,j}|a_{ij}||b_{ij}|\le\|A\|\,\|B\|) \\
&=\left(\|A\|+\|B\|\right)^2
&&(\because \text{分配律})
\end{aligned}`,
      ),
      paragraph([
        "となり、両辺の平方根をとる（Step 0、",
        math(String.raw`\|A+B\|\ge 0`),
        "、",
        math(String.raw`\|A\|+\|B\|\ge 0`),
        "）ことで ",
        math(String.raw`\|A+B\|\le\|A\|+\|B\|`),
        " を得る。",
      ]),
      paragraph([
        "Step 6: (4)。",
        math(String.raw`A_N\to A`),
        " かつ ",
        math(String.raw`A_N\to A'`),
        " とする。各 ",
        math(String.raw`N`),
        " について ",
        math(String.raw`A-A'=(A-A_N)+(A_N-A')`),
        " であるから、Step 5 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le\|A-A'\|
&&(\because \text{(1)}) \\
&\le\|A-A_N\|+\|A_N-A'\|
&&(\because \text{Step 5 を } A-A'=(A-A_N)+(A_N-A') \text{ に当てた}) \\
&= \|A_N-A\|+\|A_N-A'\|
&&(\because\ A-A_N=(-1)(A_N-A) \text{ と Step 3（} c=-1 \text{）、および } |-1|=1 \text{（} K=\mathbb{C} \text{ のときは } \blkref{abs_basic_properties} \text{ (6) より } |-1_{\mathbb{C}}|=|-1|=1 \text{）})
\end{aligned}`,
      ),
      paragraph([
        "右辺は ",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`0`),
        " に収束する実数列であり、左辺の ",
        math(String.raw`\|A-A'\|`),
        " は ",
        math(String.raw`N`),
        " によらない定数である。非負の定数が ",
        math(String.raw`0`),
        " に収束する列で上から抑えられるならその定数は ",
        math(String.raw`0`),
        " であるから ",
        math(String.raw`\|A-A'\|=0`),
        "、Step 2 より ",
        math(String.raw`A-A'=O`),
        " すなわち ",
        math(String.raw`A=A'`),
        "。",
      ]),
      paragraph([
        "Step 7: ",
        math(String.raw`K^d`),
        " の場合。上の Step 2・Step 3・Step 5・Step 6 で添字の組 ",
        math(String.raw`(i,j)`),
        " を単一の添字 ",
        math(String.raw`i`),
        " に置き換えれば、同じ議論がそのまま通用する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。ノルムの定義（labels: def_matrix_norm）を置いた以上、" +
          "極限の一意性や行列乗算の連続性（labels: matrix_multiplication_continuity）の議論が" +
          "前提としている非退化性・斉次性・三角不等式を明示的に証明しておく必要があるため追加した。",
        "2026-08-10: 式変形の書き方の統一。証明の中の 8 つの式が、1 行に 2 つ以上の等号・不等号を" +
          "並べたうえで根拠を 1 つだけ（あるいは 1 つも）付けていなかったので、" +
          "1 行 1 関係の鎖へ分け、各行の末尾に (∵ …) を置いた。" +
          "対象は、実数を複素数へ送る写像が和と積を保つことの 2 式、斉次性の式、" +
          "Cauchy--Schwarz の証明の 2 式、三角不等式の 4 式、極限の一意性の式である。" +
          "段は増えており、減った段は無い。主張も証明の筋も変えていない。",
        "2026-09-04: 式変形の書き方の統一。Cauchy--Schwarz の結びで散文に埋まっていた" +
          "「両辺に Q>0 を掛けて R^2≤PQ」を、R^2 から始まり PQ へ至る二段の式変形と" +
          "行末の根拠（移項と、正の数を掛けても順序が保たれること）へ開いた。内容と根拠は変えていない。",
        "2026-09-04: 式変形の書き方の統一。Step 5 で平方の不等式から平方根側の" +
          "不等式を得る推論が散文に埋まっていたので、両辺の非負性と Step 0 の適用を" +
          "三行の表示へ開いた。内容と根拠は変えていない。",
        "2026-09-04: 式変形の書き方の統一。Step 6 の最後の等号の根拠が式変形の後の" +
          "散文段落に置かれていたので、その行の末尾の (∵ …) へ移した" +
          "（Step 3 の c=-1 と |-1|=1 の参照を含む）。内容と根拠は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    kind: "claim",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ", ordinal: 3 },
    title: { text: "行列ノルムの劣乗法性" },
    labels: ["matrix_norm_submultiplicativity"],
    statement: [
      paragraph(["行列積の成分式は ", ref("mat_mult"), "、非負実数の平方根は ", ref("definition_of_sqrt_r_positive"), " を用いる。"]),
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
      paragraph([
        "ここで ",
        math(String.raw`\|\cdot\|`),
        " は ",
        ref("def_matrix_norm"),
        " のノルムである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A=(a_{ij})_{1\le i,j\le n}`),
        "、",
        math(String.raw`B=(b_{ij})_{1\le i,j\le n}`),
        " とおく。行列の積の定義より ",
        math(String.raw`(AB)_{ij}=\sum_{k=1}^{n}a_{ik}b_{kj}`),
        " である。",
      ]),
      paragraph([
        "Step 1: 有限和の三角不等式。",
        math(String.raw`m\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m\in K`),
        " について",
      ]),
      displayMath(
        String.raw`\left|\sum_{k=1}^{m}z_k\right|\le\sum_{k=1}^{m}|z_k|`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のときは両辺とも ",
        math(String.raw`|z_1|`),
        " で等号成立。",
        math(String.raw`m`),
        " で成り立つと仮定すると、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 1（絶対値の三角不等式）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\sum_{k=1}^{m+1}z_k\right|
&= \left|\left(\sum_{k=1}^{m}z_k\right)+z_{m+1}\right| \\
&\le \left|\sum_{k=1}^{m}z_k\right|+|z_{m+1}| &&(\because\ \blkref{matrix_norm_triangle_inequality}\text{ の Step 1}) \\
&\le \sum_{k=1}^{m}|z_k|+|z_{m+1}| &&(\because\ \text{帰納法の仮定}) \\
&= \sum_{k=1}^{m+1}|z_k| &&(\because\ \text{有限和の末項の吸収})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: 各成分の評価。",
        math(String.raw`1\le i,j\le n`),
        " を固定する。Step 1 と絶対値の乗法性（",
        ref("matrix_norm_triangle_inequality"),
        " の Step 1）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(AB)_{ij}\right|
&= \left|\sum_{k=1}^{n}a_{ik}b_{kj}\right| &&(\because\ \text{行列の積の定義}) \\
&\le \sum_{k=1}^{n}\left|a_{ik}b_{kj}\right| &&(\because\ \text{Step 1}) \\
&= \sum_{k=1}^{n}|a_{ik}|\,|b_{kj}| &&(\because\ \text{絶対値の乗法性})
\end{aligned}`,
      ),
      paragraph([
        "である。ここから、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0（非負実数の平方の単調性）と Step 4（Cauchy--Schwarz の不等式）により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(AB)_{ij}\right|^2
&\le \left(\sum_{k=1}^{n}|a_{ik}|\,|b_{kj}|\right)^2 &&(\because\ \text{直前の評価と }\blkref{matrix_norm_triangle_inequality}\text{ の Step 0}) \\
&\le \left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{k=1}^{n}|b_{kj}|^2\right) &&(\because\ \blkref{matrix_norm_triangle_inequality}\text{ の Step 4 を } u_k=|a_{ik}|,\ v_k=|b_{kj}| \text{ として適用}) \\
&= \left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{l=1}^{n}|b_{lj}|^2\right) &&(\because\ \text{第 2 因子の和の添字の付け替え})
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 全成分についての和。Step 2 の不等式を ",
        math(String.raw`1\le i,j\le n`),
        " について加えると、右辺の第 1 因子は ",
        math(String.raw`i`),
        " のみ、第 2 因子は ",
        math(String.raw`j`),
        " のみに依存するので二重和が積に分解して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|AB\|^2
&= \sum_{i=1}^{n}\sum_{j=1}^{n}\left|(AB)_{ij}\right|^2 &&(\because\ \|\cdot\| \text{ の定義と } \left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a) \\
&\le \sum_{i=1}^{n}\sum_{j=1}^{n}
\left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{l=1}^{n}|b_{lj}|^2\right) &&(\because\ \text{Step 2}) \\
&= \left(\sum_{i=1}^{n}\sum_{k=1}^{n}|a_{ik}|^2\right)
   \left(\sum_{j=1}^{n}\sum_{l=1}^{n}|b_{lj}|^2\right) &&(\because\ \text{有限和の分配律}) \\
&= \|A\|^2\,\|B\|^2 &&(\because\ \|\cdot\| \text{ の定義と } \left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a) \\
&= \left(\|A\|\cdot\|B\|\right)^2 &&(\because\ \text{非負実数の積の平方 } (xy)^2=x^2y^2)
\end{aligned}`,
      ),
      paragraph([
        "Step 4: 結論。",
        math(String.raw`\|AB\|\ge 0`),
        " かつ ",
        math(String.raw`\|A\|\cdot\|B\|\ge 0`),
        " であるから、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より",
      ]),
      displayMath(String.raw`\|AB\|\le\|A\|\cdot\|B\|
\qquad(\because\ \blkref{matrix_norm_triangle_inequality}\text{ の Step 0 を Step 3 の平方の不等式へ適用})`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-10: Step 2（各成分の評価）が、3 つの式を別々の displayMath に置き、" +
          "その間に「両辺は非負であるから」「さらに…適用すると」「よって」という日本語を" +
          "挟んでいた。どの不等号がどの根拠によるのかが式から読み取れないので、" +
          "平方以降を 1 行 1 関係の 3 段の鎖へまとめ、各行の末尾に (∵ …) を置いた" +
          "（平方の単調性・Cauchy--Schwarz・和の添字の付け替えが別々の根拠であることが式の上に現れる）。" +
          "あわせて、鎖の第 1 段（絶対値を行列の積の定義で書き下す段）に根拠が無かったので付けた。" +
          "段は増えており、減った段は無い。主張も証明の筋も変えていない。",
        "2026-08-31: 根拠の無い行が四つ残っていた（Step 1 の末項の吸収の段、Step 2 の" +
          "行列の積の定義で書き下す段、Step 3 のノルムの定義へ戻す段と積の平方へまとめる段）。" +
          "それぞれの行末に (∵ …) を付けた。式・段数・主張・証明の筋は変えていない。",
        "2026-09-02 の式変形統一で、四本の鎖の根拠 14 行を行中の \\quad (\\because …) から" +
          "行末の根拠列（aligned の &&）へ揃えた。式変形・根拠・段数・参照は変えていない。",
        "2026-09-04: 式変形の書き方の統一。Step 4 の結論式の根拠が直前の散文だけに" +
          "置かれていたので、式の行末へ Step 0 と Step 3 の平方の不等式を明記した。" +
          "内容・式変形・根拠は変えていない。",
        "2026-09-04: 式変形の書き方の統一。行列ノルムの基本性質を使う四つの行で、" +
          "根拠名だけを書いていた箇所へ対応ラベルを行末から直接付けた。" +
          "内容・式変形・根拠は変えていない。",
        "原文の proof は TODO のみ。ここで証明を与えた。" +
          "原文にはノルムの定義そのものが無かったため、Frobenius ノルムを定義するブロック" +
          "（labels: def_matrix_norm）とその基本性質のブロック（labels: matrix_norm_triangle_inequality）を" +
          "本ブロックの直前に追加している。",
      ],
    },
  },
  {
    id: "linear_space_general_003c_claim_matrix_norm_vector_bound",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 3 },
    title: { text: "行列ノルムによる数ベクトルの評価" },
    labels: ["matrix_norm_vector_bound"],
    statement: [
      paragraph(["行列と数ベクトルの積は ", ref("mat_mult"), "、零成分の絶対値は ", ref("matrix_norm_triangle_inequality"), " の証明冒頭、積のノルムの評価は ", ref("matrix_norm_submultiplicativity"), " による。"]),
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`w \in K^n`),
        " について、",
      ]),
      displayMath(String.raw`\|Aw\| \le \|A\| \cdot \|w\|`),
      paragraph([
        "ここで ",
        math(String.raw`\|\cdot\|`),
        " は ",
        ref("def_matrix_norm"),
        " のノルム（左辺と右辺第 2 因子は ",
        math(String.raw`K^n`),
        " のノルム、右辺第 1 因子は ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " のノルム）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w=(w_1,\dots,w_n)`),
        " に対し、第 1 列が ",
        math(String.raw`w`),
        "、第 2 列以降が ",
        math(String.raw`0`),
        " である行列 ",
        math(String.raw`W\in\mathrm{Mat}(n,K)`),
        " を",
      ]),
      displayMath(
        String.raw`W_{i1} := w_i \quad (1\le i\le n), \qquad
W_{ij} := 0 \quad (1\le i\le n,\ 2\le j\le n)`,
      ),
      paragraph(["で定める。第 1 列の成分は"]),
      displayMath(String.raw`\begin{aligned}
(AW)_{i1}
&=\sum_{k=1}^{n}a_{ik}W_{k1}
&&(\because\ \text{行列の積の定義})\\
&=\sum_{k=1}^{n}a_{ik}w_k
&&(\because\ W\ \text{の第 1 列の定め方})\\
&=(Aw)_i
&&(\because\ \text{行列と数ベクトルの積の定義})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`2\le j\le n`),
        " について第 ",
        math(String.raw`j`),
        " 列の成分は",
      ]),
      displayMath(String.raw`\begin{aligned}
(AW)_{ij}
&=\sum_{k=1}^{n}a_{ik}W_{kj}
&&(\because\ \text{行列の積の定義})\\
&=\sum_{k=1}^{n}a_{ik}\cdot 0
&&(\because\ W\ \text{の第 2 列以降の定め方})\\
&=0
&&(\because\ 0\ \text{を掛けた項だけの有限和は}\ 0)
\end{aligned}`),
      paragraph(["である。これを使って"]),
      displayMath(String.raw`\begin{aligned}
\|AW\|
&=\sqrt{\sum_{i=1}^{n}\sum_{j=1}^{n}\left|(AW)_{ij}\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \text{ノルムの定義。}\blkref{def_matrix_norm})\\
&=\sqrt{\sum_{i=1}^{n}\left|(AW)_{i1}\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ |0|=0\ \text{（ノルムの基本性質の Step 1。}\blkref{matrix_norm_triangle_inequality}\text{）なので第 2 列以降は平方和に寄与しない})\\
&=\sqrt{\sum_{i=1}^{n}\left|(Aw)_i\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \text{上の第 1 列の成分の等式})\\
&=\|Aw\|
&&(\because\ \text{ノルムの定義。}\blkref{def_matrix_norm})
\end{aligned}`),
      paragraph([
        "、および",
      ]),
      displayMath(String.raw`\begin{aligned}
\|W\|
&=\sqrt{\sum_{i=1}^{n}\sum_{j=1}^{n}\left|W_{ij}\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \text{ノルムの定義。}\blkref{def_matrix_norm})\\
&=\sqrt{\sum_{i=1}^{n}\left|W_{i1}\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ |0|=0\ \text{（ノルムの基本性質の Step 1。}\blkref{matrix_norm_triangle_inequality}\text{）なので第 2 列以降は平方和に寄与しない})\\
&=\sqrt{\sum_{i=1}^{n}\left|w_i\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ W\ \text{の第 1 列の定め方})\\
&=\|w\|
&&(\because\ \text{ノルムの定義。}\blkref{def_matrix_norm})
\end{aligned}`),
      paragraph([
        "を得る。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\|Aw\|
&=\|AW\|
&&(\because\ \text{上の第 1 の等式})\\
&\le\|A\|\cdot\|W\|
&&(\because\ \text{行列ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity})\\
&=\|A\|\cdot\|w\|
&&(\because\ \text{上の第 2 の等式})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。exp 級数の各点収束（labels: exp_converges）の証明で" +
          "行列ノルムから数ベクトルの評価へ移る箇所が必要になるため、劣乗法性の直後に置いた。",
        "2026-08-10: 式変形の書き方を統一した。もとは 4 つの式を別々に置き、その間に" +
          "「行列の積の定義より」「である。|0|=0 より第 2 列以降は平方和に寄与しないので」" +
          "「したがって …より」という日本語を挟んだうえ、1 つの式に 2 つ以上の等号を並べて" +
          "根拠を 1 つも書いていなかった。どの等号がどの根拠によるのかが式から読み取れないので、" +
          "1 行 1 関係の 4 つの鎖へ分け（第 1 列の成分・第 2 列以降の成分・‖AW‖=‖Aw‖ と ‖W‖=‖w‖・" +
          "結論）、各行の末尾に (∵ …) を置いた。この生成器は blkref を定義していないので、" +
          "(∵ …) には引いたブロックの題を書き、ラベル参照は式の直後に置いた。" +
          "段は増えており、減った段は無い（‖W‖=‖w‖ の側はもとが 2 つの等号を 1 行に並べていたので" +
          "4 段へ開いた）。主張も証明の筋も変えていない。",
        "2026-09-02: 三つの鎖の直後に置いていた参照一覧（ノルムの定義・ノルムの基本性質の Step 1・" +
          "劣乗法性）を削り、それらを実際に使う各行末の (∵ …) の \\blkref へ移した" +
          "（blkref が使えるようになったため）。内容・式変形・根拠・参照は不変である。",
      ],
    },
  },
  {
    id: "linear_space_general_003d_claim_matrix_completeness",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 3 },
    title: { tex: String.raw`\mathrm{Mat}(n,K) \text{ の完備性と絶対収束判定}` },
    labels: ["matrix_completeness"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とし、ノルムと収束は ",
        ref("def_matrix_norm"),
        " のものとする。",
      ]),
      list([
        [
          "(1)（完備性）",
          math(String.raw`(A_N)_{N\ge 0}`),
          " を ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " の列とし、Cauchy 列である、すなわち",
          math(
            String.raw`\ \forall\varepsilon\in\mathbb{R}_{>0},\ \exists N_0\in\mathbb{Z}_{\ge 0}\ \text{s.t.}\ \forall N,M\ge N_0,\ \|A_N-A_M\|<\varepsilon\ `,
          ),
          "とする。このとき ",
          math(String.raw`A\in\mathrm{Mat}(n,K)`),
          " が存在して ",
          math(String.raw`A_N\to A`),
          "。",
        ],
        [
          "(2)（絶対収束判定）",
          math(String.raw`B_0,B_1,\dots\in\mathrm{Mat}(n,K)`),
          " について実数列の級数 ",
          math(String.raw`\sum_{m=0}^{\infty}\|B_m\|`),
          " が収束するならば ",
          math(String.raw`\sum_{m=0}^{\infty}B_m`),
          " は ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " において収束し、",
          math(String.raw`\left\|\sum_{m=0}^{\infty}B_m\right\|\le\sum_{m=0}^{\infty}\|B_m\|`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: 成分は ノルムで抑えられる。",
        math(String.raw`A=(a_{ij})\in\mathrm{Mat}(n,K)`),
        " と ",
        math(String.raw`1\le i,j\le n`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|a_{ij}|^2
&\le\sum_{k=1}^{n}\sum_{l=1}^{n}|a_{kl}|^2
&& (\because \text{非負項の有限和は各項以上})\\
&=\|A\|^2
&& (\because \text{行列ノルムの定義})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`|a_{ij}|\ge 0`),
        "、",
        math(String.raw`\|A\|\ge 0`),
        " であるから ",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        "次の一段を得る。",
      ]),
      displayMath(String.raw`|a_{ij}|\le\|A\|
\quad (\because \text{直前の平方の評価と非負実数の平方の単調性})`),
      paragraph([
        "Step 2: ",
        math(String.raw`K`),
        " の Cauchy 列は収束する。",
        math(String.raw`K=\mathbb{R}`),
        " のときは ",
        math(String.raw`\mathbb{R}`),
        " の完備性そのものである。",
        math(String.raw`K=\mathbb{C}`),
        " のとき、",
        math(String.raw`z=(x,y)\in\mathbb{C}`),
        " について ",
        ref("abs_basic_properties"),
        " (2) より、次の一続きの評価を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
|z|^2
&=x^2+y^2
&& (\because \text{複素数の絶対値の平方})\\
&\ge x^2
&& (\because y^2\ge0)\\
&=|x|^2
&& (\because \text{実数の絶対値の定義})
\end{aligned}`),
      paragraph([
        "最後の等号は実数の絶対値の定義 ",
        math(String.raw`|x|\in\{x,-x\}`),
        " による。",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        math(String.raw`|x|\le|z|`),
        "、同様に ",
        math(String.raw`|y|\le|z|`),
        "。",
        ref("complex_numbers_form_a_field"),
        " より ",
        math(String.raw`\mathbb{C}`),
        " の加法とその逆元は成分ごとである。いま示した評価を ",
        math(String.raw`z=z_N-z_M`),
        " に適用すると",
      ]),
      displayMath(String.raw`\begin{aligned}
z_N-z_M&=(x_N-x_M,\ y_N-y_M)
&& (\because \mathbb C\text{ の減法は成分ごと})\\
|x_N-x_M|&\le|z_N-z_M|
&& (\because \text{直前の第 1 成分の評価})\\
|y_N-y_M|&\le|z_N-z_M|
&& (\because \text{同じ評価の第 2 成分版})
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`\mathbb{C}`),
        " の Cauchy 列 ",
        math(String.raw`(z_N)=((x_N,y_N))`),
        " に対して ",
        math(String.raw`(x_N),(y_N)`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の Cauchy 列であり、",
        math(String.raw`\mathbb{R}`),
        " の完備性より ",
        math(String.raw`x_N\to x`),
        "、",
        math(String.raw`y_N\to y`),
        " なる ",
        math(String.raw`x,y\in\mathbb{R}`),
        " が存在する。このとき ",
        ref("abs_basic_properties"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|z_N-(x,y)|^2
&=(x_N-x)^2+(y_N-y)^2
&& (\because \text{複素数の絶対値の平方})\\
&\longrightarrow 0
&& (\because x_N\to x\text{ と }y_N\to y)
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`|z_N-(x,y)|\to 0`),
        "（非負実数について ",
        math(String.raw`u_N^2\to 0\Rightarrow u_N\to 0`),
        "。実際 ",
        math(String.raw`\varepsilon>0`),
        " に対し ",
        math(String.raw`u_N^2<\varepsilon^2`),
        " なる ",
        math(String.raw`N`),
        " 以降で ",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        math(String.raw`u_N<\varepsilon`),
        "）。",
      ]),
      paragraph([
        "Step 3: (1) の証明。",
        math(String.raw`(A_N)`),
        " を Cauchy 列とすると、Step 1 より各成分について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(A_N)_{ij}-(A_M)_{ij}\right|
&=\left|(A_N-A_M)_{ij}\right|
&&(\because\ \text{行列の差は成分ごとである})\\
&\le\|A_N-A_M\|
&&(\because\ \text{Step 1})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`((A_N)_{ij})_N`),
        " は ",
        math(String.raw`K`),
        " の Cauchy 列である。Step 2 よりその極限 ",
        math(String.raw`a_{ij}\in K`),
        " が存在する。",
        math(String.raw`A:=(a_{ij})\in\mathrm{Mat}(n,K)`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A_N-A\|^2
&=\sum_{i=1}^{n}\sum_{j=1}^{n}\left|(A_N)_{ij}-a_{ij}\right|^2
&& (\because \text{行列ノルムの定義})\\
&\longrightarrow 0
&& (\because \text{有限個の }0\text{ に収束する実数列の和})
\end{aligned}`,
      ),
      paragraph([
        "であり、Step 2 末尾と同じ理由で ",
        math(String.raw`\|A_N-A\|\to 0`),
        "、すなわち ",
        math(String.raw`A_N\to A`),
        "。",
      ]),
      paragraph([
        "Step 4: (2) の証明。",
        math(String.raw`S_N:=\sum_{m=0}^{N}B_m`),
        "、",
        math(String.raw`T_N:=\sum_{m=0}^{N}\|B_m\|`),
        " とおく。仮定より ",
        math(String.raw`(T_N)`),
        " は収束するので Cauchy 列である。",
        math(String.raw`N>M`),
        " のとき ",
        ref("matrix_norm_triangle_inequality"),
        " (3) を繰り返し用いて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S_N-S_M\|
&=\left\|\sum_{m=M+1}^{N}B_m\right\|
&&(\because\ S_N\ \text{と}\ S_M\ \text{の定義と、有限和の差})\\
&\le\sum_{m=M+1}^{N}\|B_m\|
&&(\because\ \text{行列ノルムの三角不等式を繰り返し用いる})\\
&=T_N-T_M
&&(\because\ T_N\ \text{と}\ T_M\ \text{の定義と、有限和の差})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`(S_N)`),
        " は Cauchy 列であり、(1) より ",
        math(String.raw`S:=\lim_{N\to\infty}S_N`),
        " が存在する。すなわち ",
        math(String.raw`\sum_{m=0}^{\infty}B_m=S`),
        "。",
      ]),
      paragraph([
        "Step 5: ノルムの評価。",
        ref("matrix_norm_triangle_inequality"),
        " (3) より",
      ]),
      displayMath(String.raw`\begin{aligned}
\|S_N\|
&\le T_N
&& (\because \text{行列ノルムの三角不等式を有限回適用})\\
&\le T
&& (\because \text{非負項の級数の部分和はその極限以下})
\end{aligned}`),
      paragraph([
        "ここで ", math(String.raw`T:=\sum_{m=0}^{\infty}\|B_m\|`), " である。",
        math(String.raw`(T_N)`),
        " は非負項の級数の部分和なので単調非減少であり ",
        math(String.raw`T_N\le T`),
        "。また ",
        ref("matrix_norm_triangle_inequality"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S\|
&\le\|S-S_N\|+\|S_N\|
&&(\because\ S=(S-S_N)+S_N\ \text{と行列ノルムの三角不等式})\\
&\le\|S-S_N\|+T
&&(\because\ \|S_N\|\le T)
\end{aligned}`,
      ),
      paragraph([
        "であり、右辺第 1 項は ",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`0`),
        " に収束する。",
        math(String.raw`\|S\|`),
        " は ",
        math(String.raw`N`),
        " によらない定数であるから ",
        math(String.raw`\|S\|\le T`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。exp 級数の収束（labels: exp_converges）と" +
          "可換行列の exp 積公式（labels: theorem_exp_product）が前提とする" +
          "「Mat(n,K) が完備であること」「絶対収束すれば収束すること」を明示するために追加した。",
        "式変形の書き方の統一（2026-08-10）。3 箇所の式が 1 行に 2 つ以上の関係を並べ、" +
          "根拠を 1 つも書いていなかった（Step 3 の成分の評価、Step 4 の部分和の差の評価、" +
          "Step 5 のノルムの評価）。どの関係がどの根拠によるのかが式から読み取れないので、" +
          "それぞれ 1 行 1 関係の鎖へ分け、各行の末尾に (∵ …) を置いた。" +
        "段は増えており、減った段は無い。主張も証明の筋も変えていない。",
        "2026-08-31: 完備性と絶対収束判定の証明に残っていた一行複数関係を開いた。" +
          "成分平方の評価、複素数の成分評価、複素差の二成分評価、極限二箇所、部分和ノルムの二段を、" +
          "一行一関係と行末根拠へ直した。既存の参照・段・主張・証明の筋は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_003b_claim_matrix_multiplication_continuity",
    kind: "claim",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ", ordinal: 3 },
    title: { text: "行列乗算の連続性" },
    labels: ["matrix_multiplication_continuity"],
    statement: [
      paragraph(["ノルムと収束は ", ref("def_matrix_norm"), "、行列積は ", ref("mat_mult"), "、積のノルムの評価は ", ref("matrix_norm_submultiplicativity"), " による。", math(String.raw`(A_N)_{N\in\mathbb Z_{\ge0}}`), " は以下の行列空間の列とする。"]),
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
&= \|(A_N - A)B\|
&&(\because\ \text{行列の積の右分配則})\\
&\leq \|A_N - A\| \cdot \|B\|
&&(\because\ \text{行列ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity})\\
&\to 0
&&(\because\ \|A_N - A\| \to 0\ \text{と、収束する実数列に定数を掛けた列の極限})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-10）。3 段の鎖はもとから 1 行 1 関係になっていたが、" +
          "どの関係がどの根拠によるのかが式の上に無く、引いたブロックの参照が式の後ろに" +
          "1 つだけ置かれていた。各行の末尾に (∵ …) を置いた（右分配則・劣乗法性・" +
          "収束する実数列に定数を掛けた列の極限が別々の根拠であることが、これで式の上に現れる）。" +
          "段は増えておらず減ってもおらず、主張も証明の筋も変えていない。",
        "2026-09-03 の式変形統一で、証明末尾の参照一覧を削除し、行列ノルムの劣乗法性を" +
          "使う不等式行の行末へラベル参照を移した。内容・式変形・根拠は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_matrix_multiplication_continuity_in_right_factor",
    kind: "claim",
    title: { text: "行列乗算の右の因子についての連続性" },
    labels: ["matrix_multiplication_continuity_in_right_factor"],
    statement: [
      paragraph(["ノルムと収束は ", ref("def_matrix_norm"), "、行列積は ", ref("mat_mult"), "、積のノルムの評価は ", ref("matrix_norm_submultiplicativity"), " による。", math(String.raw`(A_N)_{N\in\mathbb Z_{\ge0}}`), " は以下の行列空間の列とする。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A_N, A, B \in \mathrm{Mat}(n, \mathbb{C})`),
        "、",
        math(String.raw`\|A_N - A\| \to 0`),
        " のとき、",
      ]),
      displayMath(String.raw`\|B A_N - BA\| \to 0`),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\|B A_N - BA\|
&= \|B(A_N - A)\|
&&(\because\ \text{行列の積の左分配則})\\
&\leq \|B\| \cdot \|A_N - A\|
&&(\because\ \blkref{matrix_norm_submultiplicativity}\ (K \to \mathbb{C},\ A \to B,\ B \to A_N - A))\\
&\to 0
&&(\because\ \|A_N - A\| \to 0\ \text{と、収束する実数列に定数を掛けた列の極限。左辺は非負なので、上の評価から挟み撃ちで})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。eigenvalues_of_check_Vprime の Step 3' が Q̌_ε(lim E_K) = lim(Q̌_εE_K) を「行列積の連続性」で済ませていたが、matrix_multiplication_continuity は左の因子が動く形 A_NB → AB しか述べていないので、右の因子が動く形を足した。証明は matrix_multiplication_continuity と同じ 3 行で、根拠の名前の付け方も揃えた（分配則の根拠は同じく名前だけ）。係数は使う箇所に合わせて ℂ に固定した。",
      ],
    },
  },
  {
    id: "linear_space_general_claim_scalar_sequence_times_matrix_converges",
    kind: "claim",
    title: { text: "収束する複素数の列による行列のスカラー倍は収束する" },
    labels: ["scalar_sequence_times_matrix_converges"],
    statement: [
      paragraph([
        "ノルムと収束は ",
        ref("def_matrix_norm"),
        "、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、行列の差は ",
        ref("def_matrix_difference"),
        "、複素数の差は ",
        ref("def_complex_difference"),
        " による。",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`(c_N)_{N\in\mathbb Z_{\ge0}}`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の列、",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n, \mathbb{C})`),
        " とし、",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の列の収束の意味で ",
        math(String.raw`c_N \to c`),
        "（すなわち ",
        math(String.raw`|c_N - c| \to 0`),
        "）とする。このとき",
      ]),
      displayMath(String.raw`\|c_N A - cA\| \to 0`),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\|c_N A - cA\|
&= \|(c_N - c)A\|
&&(\because\ \blkref{difference_of_scalar_multiples_of_one_matrix}\ (m \to n,\ a \to c_N,\ b \to c))\\
&= |c_N - c| \cdot \|A\|
&&(\because\ \blkref{matrix_norm_triangle_inequality}\ (2)\ (K \to \mathbb{C},\ c \to c_N - c))\\
&\to 0
&&(\because\ |c_N - c| \to 0\ \text{と、収束する実数列に定数を掛けた列の極限})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。eigenvalues_of_check_Vprime の Step 3・Step 3' の極限の鎖の最後の行が「実指数級数の収束と極限の一意性」で lim((Σ(1/k!)ǧ(ε)^k)Q̌_ε) = exp(ǧ(ε))Q̌_ε を出していた。引いていた real_exp_series_converges は a ∈ ℝ_{≥0} についての主張で、ǧ(ε) < 0 を覆わず、数の列の収束から行列のスカラー倍の列の収束へ移る段も無かった。数の列の極限（scalar_exp_is_limit_of_partial_sums）を行列のスカラー倍の列の極限へ移すために足した。係数は使う箇所に合わせて ℂ に固定した（difference_of_scalar_multiples_of_one_matrix が ℂ だけを述べるため）。",
      ],
    },
  },
]);
