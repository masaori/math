import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/045_claim_共役写像は環準同型.typ", ordinal: 46 },
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
      paragraph(["乗法性を示す。", math(String.raw`A, C \in \mathrm{Mat}(n,\mathbb{C})`), " とする。"]),
      displayMath(
        String.raw`\begin{aligned}
T_B(AC)
&= B(AC)B^{-1}
&&\bigl(\because\ T_B\text{ の定義}\bigr)\\
&= BACB^{-1}
&&\bigl(\because\ \text{行列の積の結合法則}\bigr)\\
&= BAICB^{-1}
&&\bigl(\because\ \text{単位元の性質 }IC = C\bigr)\\
&= BA(B^{-1}B)CB^{-1}
&&\bigl(\because\ B^{-1}B = I\bigr)\\
&= (BAB^{-1})(BCB^{-1})
&&\bigl(\because\ \text{行列の積の結合法則}\bigr)\\
&= T_B(A)(BCB^{-1})
&&\bigl(\because\ T_B\text{ の定義}\bigr)\\
&= T_B(A) T_B(C)
&&\bigl(\because\ T_B\text{ の定義}\bigr)
\end{aligned}`,
      ),
      paragraph(["（引いたブロック: ", ref("mat_conj"), "）"]),
      paragraph(["単位性を示す。"]),
      displayMath(
        String.raw`\begin{aligned}
T_B(I)
&= BIB^{-1}
&&\bigl(\because\ T_B\text{ の定義}\bigr)\\
&= BB^{-1}
&&\bigl(\because\ \text{単位元の性質 }BI = B\bigr)\\
&= I
&&\bigl(\because\ BB^{-1} = I\bigr)
\end{aligned}`,
      ),
      paragraph(["（引いたブロック: ", ref("mat_conj"), "）"]),
      paragraph([
        "合成則を示す。",
        math(String.raw`A, B \in (\mathrm{Mat}(n,\mathbb{C}))^\times`),
        "（正則）とする。準備として、行列の積の逆元 ",
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
&= A(BB^{-1})A^{-1}
&&\bigl(\because\ \text{行列の積の結合法則}\bigr)\\
&= AIA^{-1}
&&\bigl(\because\ BB^{-1} = I\bigr)\\
&= AA^{-1}
&&\bigl(\because\ \text{単位元の性質 }AI = A\bigr)\\
&= I
&&\bigl(\because\ AA^{-1} = I\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(B^{-1}A^{-1})(AB)
&= B^{-1}(A^{-1}A)B
&&\bigl(\because\ \text{行列の積の結合法則}\bigr)\\
&= B^{-1}IB
&&\bigl(\because\ A^{-1}A = I\bigr)\\
&= B^{-1}B
&&\bigl(\because\ \text{単位元の性質 }IB = B\bigr)\\
&= I
&&\bigl(\because\ B^{-1}B = I\bigr)
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
&= T_A(T_B(M))
&&\bigl(\because\ \text{写像の合成の定義}\bigr)\\
&= T_A(BMB^{-1})
&&\bigl(\because\ T_B\text{ の定義}\bigr)\\
&= A(BMB^{-1})A^{-1}
&&\bigl(\because\ T_A\text{ の定義}\bigr)\\
&= (AB)M(B^{-1}A^{-1})
&&\bigl(\because\ \text{行列の積の結合法則}\bigr)\\
&= (AB)M(AB)^{-1}
&&\bigl(\because\ (AB)^{-1} = B^{-1}A^{-1}\bigr)\\
&= T_{AB}(M)
&&\bigl(\because\ T_{AB}\text{ の定義}\bigr)
\end{aligned}`,
      ),
      paragraph(["（引いたブロック: ", ref("mat_conj"), "）"]),
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
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-09）。Step 1 / Step 2 / Step 3 という番号での区切りを、それぞれの中間目標の名前（乗法性・単位性・合成則）へ変えた。合成則の中の逆元の公式は式変形ではなく準備なので、そう呼び直した。証明の冒頭に置かれていた共役写像の定義への参照を、それを使った各鎖の直後へ移した（この生成器は \\blkref を定義していないので、(∵ …) の中には題を書き、ラベル参照は式の直後に置く）。式変形の段は 1 つも増減していない。",
        "2026-08-31 の式変形統一で、五本の鎖に行中の \\quad(\\because …) で置かれていた根拠 20 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・参照は変えていない。",
      ],
    },
  },
  {
    id: "calculation_formulae_047_claim_commutator_via_anticommutators",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/046_claim_交換子と反交換子の関係.typ", ordinal: 47 },
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
      displayMath(
        String.raw`\begin{aligned}
[ab, c]
&= (ab)c - c(ab) &&\bigl(\because \text{交換子の定義}\bigr) \\
&= abc - cab &&\bigl(\because \text{行列の積の結合法則}\bigr) \\
&= abc + acb - acb - cab &&\bigl(\because\ acb - acb = O\bigr) \\
&= a(bc + cb) - (ac + ca)b &&\bigl(\because \text{行列の積の分配法則と結合法則}\bigr) \\
&= a[b, c]_+ - [a, c]_+ b &&\bigl(\because \text{反交換子の定義}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-09）。原文は右辺から始めて左辺へ着く鎖だったので、主張の左辺 [ab, c] から始める向きへ書き直した。原文が黙って使っていた「acb - acb = O を足す」段を 1 行として明示し、原文が 1 行にまとめていた結合法則と分配法則の適用を分けた。段は増えており、減った段は無い。",
        "2026-09-01 の式変形統一で、五段の根拠を行中の \\quad(\\because …) から他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠は変えていない。",
      ],
    },
  },
]);
