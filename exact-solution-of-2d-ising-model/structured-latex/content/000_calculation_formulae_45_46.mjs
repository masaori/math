import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/045_claim_共役写像は環準同型.typ",
    sourceOrdinal: 46,
    title: { text: "共役写像は環準同型" },
    labels: ["conjugation_is_ring_homomorphism"],
    statement: [
      paragraph([math(String.raw`n \in \mathbb{Z}_{\geq 1}`), " とする。"]),
      paragraph([
        math(String.raw`B \in (\mathrm{Mat}(n,\mathbb{C}))^\times`),
        "（正則）について、共役写像 ",
        math(String.raw`T_B : \mathrm{Mat}(n,\mathbb{C}) \to \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`T_B(A) = B A B^{-1}`),
        " は次を満たす。",
      ]),
      list([
        ["乗法的: 任意の ", math(String.raw`A, C \in \mathrm{Mat}(n,\mathbb{C})`), " について ", math(String.raw`T_B(AC) = T_B(A) T_B(C)`)],
        ["単位的: ", math(String.raw`T_B(I) = I`)],
        ["合成則: ", math(String.raw`A, B \in (\mathrm{Mat}(n,\mathbb{C}))^\times`), "（正則）について ", math(String.raw`T_A \circ T_B = T_{AB}`)],
      ]),
    ],
    proof: [
      paragraph(["（共役写像 ", math(String.raw`T_B`), " の定義は ", ref("mat_conj"), "）"]),
      paragraph(["Step 1: 乗法性。", math(String.raw`A, C \in \mathrm{Mat}(n,\mathbb{C})`), " に対して、"]),
      displayMath(
        String.raw`\begin{aligned}
T_B(AC)
&= B(AC)B^{-1} \quad (\because T_B \text{ の定義}) \\
&= BACB^{-1} \quad (\because \text{行列の積の結合法則}) \\
&= BAICB^{-1} \quad (\because \text{単位元の性質 } IC = C) \\
&= BA(B^{-1}B)CB^{-1} \quad (\because B^{-1}B = I) \\
&= (BAB^{-1})(BCB^{-1}) \quad (\because \text{行列の積の結合法則}) \\
&= T_B(A)(BCB^{-1}) \quad (\because T_B \text{ の定義}) \\
&= T_B(A) T_B(C) \quad (\because T_B \text{ の定義})
\end{aligned}`,
      ),
      paragraph(["Step 2: 単位性。"]),
      displayMath(
        String.raw`\begin{aligned}
T_B(I)
&= BIB^{-1} \quad (\because T_B \text{ の定義}) \\
&= BB^{-1} \quad (\because \text{単位元の性質 } BI = B) \\
&= I \quad (\because BB^{-1} = I)
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 合成則。",
        math(String.raw`A, B \in (\mathrm{Mat}(n,\mathbb{C}))^\times`),
        "（正則）とする。まず、行列の積の逆元 ",
        math(String.raw`(AB)^{-1} = B^{-1}A^{-1}`),
        " を確認する。",
        math(String.raw`B^{-1}A^{-1}`),
        " が ",
        math(String.raw`AB`),
        " の右逆元かつ左逆元であることを示せばよい。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(AB)(B^{-1}A^{-1})
&= A(BB^{-1})A^{-1} \quad (\because \text{行列の積の結合法則}) \\
&= AIA^{-1} \quad (\because BB^{-1} = I) \\
&= AA^{-1} \quad (\because \text{単位元の性質 } AI = A) \\
&= I \quad (\because AA^{-1} = I)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(B^{-1}A^{-1})(AB)
&= B^{-1}(A^{-1}A)B \quad (\because \text{行列の積の結合法則}) \\
&= B^{-1}IB \quad (\because A^{-1}A = I) \\
&= B^{-1}B \quad (\because \text{単位元の性質 } IB = B) \\
&= I \quad (\because B^{-1}B = I)
\end{aligned}`,
      ),
      paragraph([
        "よって、",
        math(String.raw`B^{-1}A^{-1}`),
        " は ",
        math(String.raw`AB`),
        " の両側逆元であり、逆元の一意性から ",
        math(String.raw`(AB)^{-1} = B^{-1}A^{-1}`),
        " が成り立つ。任意の ",
        math(String.raw`M \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(T_A \circ T_B)(M)
&= T_A(T_B(M)) \quad (\because \text{写像の合成の定義}) \\
&= T_A(BMB^{-1}) \quad (\because T_B \text{ の定義}) \\
&= A(BMB^{-1})A^{-1} \quad (\because T_A \text{ の定義}) \\
&= (AB)M(B^{-1}A^{-1}) \quad (\because \text{行列の積の結合法則}) \\
&= (AB)M(AB)^{-1} \quad (\because (AB)^{-1} = B^{-1}A^{-1}) \\
&= T_{AB}(M) \quad (\because T_{AB} \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。よって、任意の ",
        math(String.raw`M \in \mathrm{Mat}(n,\mathbb{C})`),
        " について ",
        math(String.raw`(T_A \circ T_B)(M) = T_{AB}(M)`),
        " であるから、",
        math(String.raw`T_A \circ T_B = T_{AB}`),
        " である。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_047_claim_commutator_via_anticommutators",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/046_claim_交換子と反交換子の関係.typ",
    sourceOrdinal: 47,
    title: { text: "交換子と反交換子の関係" },
    labels: ["commutator_via_anticommutators"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`a, b, c \in \mathrm{Mat}(n,\mathbb{C})`),
        " について、交換子を ",
        math(String.raw`[x, y] := xy - yx`),
        "、反交換子を ",
        math(String.raw`[x, y]_+ := xy + yx`),
        " と定めるとき、",
      ]),
      displayMath(String.raw`[ab, c] = a[b, c]_+ - [a, c]_+ b`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["右辺を反交換子の定義に従って展開する。"]),
      displayMath(
        String.raw`\begin{aligned}
a[b, c]_+ - [a, c]_+ b
&= a(bc + cb) - (ac + ca)b \quad (\because \text{反交換子の定義}) \\
&= abc + acb - acb - cab \quad (\because \text{行列の積の分配法則・結合法則}) \\
&= abc - cab \\
&= (ab)c - c(ab) \quad (\because \text{行列の積の結合法則}) \\
&= [ab, c] \quad (\because \text{交換子の定義})
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
]);
