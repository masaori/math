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
&= a(bc + cb) - acb - cab &&\bigl(\because \text{行列の積の分配法則}\bigr) \\
&= a(bc + cb) - (ac + ca)b &&\bigl(\because \text{行列の積の分配法則}\bigr) \\
&= a[b, c]_+ - [a, c]_+ b &&\bigl(\because \text{反交換子の定義}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-09）。原文は右辺から始めて左辺へ着く鎖だったので、主張の左辺 [ab, c] から始める向きへ書き直した。原文が黙って使っていた「acb - acb = O を足す」段を 1 行として明示し、原文が 1 行にまとめていた結合法則と分配法則の適用を分けた。段は増えており、減った段は無い。",
        "2026-09-01 の式変形統一で、五段の根拠を行中の \\quad(\\because …) から他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠は変えていない。",
        "2026-09-03 の式変形統一で、二箇所への分配法則を一行にまとめていた段を、左の括り出しと右の括り出しの二段へ分けた。内容・根拠は変えていない。",
      ],
    },
  },
  {
    id: "finite_matrix_definition_eigenvector",
    kind: "definition",
    title: { text: "固有ベクトル" },
    labels: ["def_eigenvector"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`\lambda \in \mathbb{C}`),
        " とする。",
        math(String.raw`v \in \mathbb{C}^n`),
        " が",
      ]),
      displayMath(String.raw`v \neq 0 \quad\text{かつ}\quad Av = \lambda v`),
      paragraph([
        "を満たすとき、",
        math(String.raw`v`),
        " を ",
        math(String.raw`A`),
        " の ",
        math(String.raw`\lambda`),
        " に属する固有ベクトルと呼ぶ。",
        math(String.raw`0`),
        " は ",
        math(String.raw`\mathbb{C}^n`),
        " の零ベクトル、",
        math(String.raw`Av`),
        " は ",
        ref("mat_mult"),
        " の行列とベクトルの積、",
        math(String.raw`\lambda v`),
        " は成分ごとのスカラー倍である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: eigenvector_of_A_theta_tilde の statement と Step 2 が「固有ベクトル」を定義せずに使っていたので足した。",
      ],
    },
  },
  {
    id: "finite_matrix_definition_eigenvalue",
    kind: "definition",
    title: { text: "固有値" },
    labels: ["def_eigenvalue"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " とする。",
        math(String.raw`\lambda \in \mathbb{C}`),
        " について、",
        math(String.raw`A`),
        " の ",
        math(String.raw`\lambda`),
        " に属する固有ベクトル（",
        ref("def_eigenvector"),
        "）が存在するとき、すなわち",
      ]),
      displayMath(String.raw`\exists\, v \in \mathbb{C}^n,\quad v \neq 0 \ \text{かつ}\ Av = \lambda v`),
      paragraph([
        "が成り立つとき、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`A`),
        " の固有値と呼ぶ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: eigenvector_of_A_theta_tilde の Step 1 が「固有値」を定義せずに「固有値 ⟺ det(A(θ) − λI) = 0」を使っていたので足した。",
      ],
    },
  },
  {
    id: "finite_matrix_definition_determinant_two_by_two",
    kind: "definition",
    title: { tex: String.raw`2 \times 2 \text{ 行列の行列式}` },
    labels: ["def_det_two_by_two"],
    statement: [
      paragraph([
        math(String.raw`B \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、その行列式 ",
        math(String.raw`\det B \in \mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`\det B := B_{11}B_{22} - B_{12}B_{21}`),
      paragraph([
        "で定める。この論文で行列式を使うのは ",
        math(String.raw`2 \times 2`),
        " 行列に対してだけである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: eigenvector_of_A_theta_tilde と diagonalization_check_P_D が「2×2 行列の行列式の定義」を本文に置かずに引いていたので足した。一般の n×n の行列式（Leibniz の定義）は使わない。",
      ],
    },
  },
  {
    id: "finite_matrix_claim_nonzero_kernel_iff_determinant_zero_two_by_two",
    kind: "claim",
    title: { tex: String.raw`2 \times 2 \text{ 行列が } 0 \text{ でないベクトルを } 0 \text{ へ送ることと行列式が } 0 \text{ であることの同値}` },
    labels: ["nonzero_kernel_iff_det_zero_two_by_two"],
    statement: [
      paragraph([
        math(String.raw`B \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
      ]),
      displayMath(String.raw`\left(\exists\, v \in \mathbb{C}^2,\quad v \neq 0 \ \text{かつ}\ Bv = 0\right)
\iff \det B = 0`),
      paragraph([
        "が成り立つ。",
        math(String.raw`Bv`),
        " は ",
        ref("mat_mult"),
        "、",
        math(String.raw`\det B`),
        " は ",
        ref("def_det_two_by_two"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([
        "（⇒）",
        math(String.raw`v = (v_1, v_2)^{\mathsf T} \in \mathbb{C}^2`),
        " が ",
        math(String.raw`v \neq 0`),
        " かつ ",
        math(String.raw`Bv = 0`),
        " を満たすとする。",
        ref("mat_mult"),
        " より ",
        math(String.raw`(Bv)_1 = B_{11}v_1 + B_{12}v_2`),
        "、",
        math(String.raw`(Bv)_2 = B_{21}v_1 + B_{22}v_2`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\det B \cdot v_1
&= \left(B_{11}B_{22} - B_{12}B_{21}\right)v_1
   &&\bigl(\because \blkref{def_det_two_by_two}\bigr) \\
&= B_{11}B_{22}v_1 - B_{12}B_{21}v_1
   &&\bigl(\because \text{分配則}\bigr) \\
&= B_{22}B_{11}v_1 - B_{12}B_{21}v_1
   &&\bigl(\because \mathbb{C}\text{ の乗法の可換則}\bigr) \\
&= B_{22}B_{11}v_1 - B_{12}B_{21}v_1 + \left(B_{22}B_{12}v_2 - B_{22}B_{12}v_2\right)
   &&\bigl(\because x - x = 0\ (x := B_{22}B_{12}v_2)\bigr) \\
&= B_{22}B_{11}v_1 - B_{12}B_{21}v_1 + \left(B_{22}B_{12}v_2 - B_{12}B_{22}v_2\right)
   &&\bigl(\because \mathbb{C}\text{ の乗法の可換則}\bigr) \\
&= B_{22}B_{11}v_1 + B_{22}B_{12}v_2 - B_{12}B_{21}v_1 - B_{12}B_{22}v_2
   &&\bigl(\because \mathbb{C}\text{ の加法の交換則と結合則}\bigr) \\
&= B_{22}\left(B_{11}v_1 + B_{12}v_2\right) - B_{12}\left(B_{21}v_1 + B_{22}v_2\right)
   &&\bigl(\because \text{分配則}\bigr) \\
&= B_{22}(Bv)_1 - B_{12}(Bv)_2
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= B_{22}\cdot 0 - B_{12}\cdot 0
   &&\bigl(\because Bv = 0\bigr) \\
&= 0
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\det B \cdot v_2
&= \left(B_{11}B_{22} - B_{12}B_{21}\right)v_2
   &&\bigl(\because \blkref{def_det_two_by_two}\bigr) \\
&= B_{11}B_{22}v_2 - B_{12}B_{21}v_2
   &&\bigl(\because \text{分配則}\bigr) \\
&= B_{11}B_{22}v_2 - B_{21}B_{12}v_2
   &&\bigl(\because \mathbb{C}\text{ の乗法の可換則}\bigr) \\
&= B_{11}B_{22}v_2 - B_{21}B_{12}v_2 + \left(B_{11}B_{21}v_1 - B_{11}B_{21}v_1\right)
   &&\bigl(\because x - x = 0\ (x := B_{11}B_{21}v_1)\bigr) \\
&= B_{11}B_{22}v_2 - B_{21}B_{12}v_2 + \left(B_{11}B_{21}v_1 - B_{21}B_{11}v_1\right)
   &&\bigl(\because \mathbb{C}\text{ の乗法の可換則}\bigr) \\
&= B_{11}B_{21}v_1 + B_{11}B_{22}v_2 - B_{21}B_{11}v_1 - B_{21}B_{12}v_2
   &&\bigl(\because \mathbb{C}\text{ の加法の交換則と結合則}\bigr) \\
&= B_{11}\left(B_{21}v_1 + B_{22}v_2\right) - B_{21}\left(B_{11}v_1 + B_{12}v_2\right)
   &&\bigl(\because \text{分配則}\bigr) \\
&= B_{11}(Bv)_2 - B_{21}(Bv)_1
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= B_{11}\cdot 0 - B_{21}\cdot 0
   &&\bigl(\because Bv = 0\bigr) \\
&= 0
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`v \neq 0`),
        " なので、",
        math(String.raw`v_i \neq 0`),
        " となる ",
        math(String.raw`i \in \{1, 2\}`),
        " がある。上の 2 本の鎖のうちその ",
        math(String.raw`i`),
        " の鎖から ",
        math(String.raw`\det B \cdot v_i = 0`),
        " である。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ零因子を持たないので、",
        math(String.raw`\det B = 0`),
        " または ",
        math(String.raw`v_i = 0`),
        " であり、後者は ",
        math(String.raw`v_i \neq 0`),
        " に反する。よって ",
        math(String.raw`\det B = 0`),
        " である。",
      ]),
      paragraph([
        "（⇐）",
        math(String.raw`\det B = 0`),
        " とする。",
        math(String.raw`B`),
        " の 1 行目 ",
        math(String.raw`(B_{11}, B_{12})`),
        " と 2 行目 ",
        math(String.raw`(B_{21}, B_{22})`),
        " が零であるかどうかで、次の 3 つの場合に分ける。3 つの場合は互いに重ならず、すべての ",
        math(String.raw`B`),
        " を尽くす。",
      ]),
      paragraph([
        "1 行目が零でない場合（",
        math(String.raw`(B_{11}, B_{12}) \neq (0, 0)`),
        "）。",
        math(String.raw`v := (B_{12},\ -B_{11})^{\mathsf T}`),
        " と置く。",
        math(String.raw`B_{12} \neq 0`),
        " または ",
        math(String.raw`-B_{11} \neq 0`),
        " なので ",
        math(String.raw`v \neq 0`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(Bv)_1
&= B_{11}B_{12} + B_{12}\left(-B_{11}\right)
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= B_{11}B_{12} - B_{12}B_{11}
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr) \\
&= B_{11}B_{12} - B_{11}B_{12}
   &&\bigl(\because \mathbb{C}\text{ の乗法の可換則}\bigr) \\
&= 0
   &&\bigl(\because x - x = 0\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(Bv)_2
&= B_{21}B_{12} + B_{22}\left(-B_{11}\right)
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= B_{21}B_{12} - B_{22}B_{11}
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr) \\
&= B_{12}B_{21} - B_{11}B_{22}
   &&\bigl(\because \mathbb{C}\text{ の乗法の可換則}\bigr) \\
&= -\left(B_{11}B_{22} - B_{12}B_{21}\right)
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr) \\
&= -\det B
   &&\bigl(\because \blkref{def_det_two_by_two}\bigr) \\
&= -0
   &&\bigl(\because \det B = 0\bigr) \\
&= 0
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "1 行目が零で 2 行目が零でない場合（",
        math(String.raw`B_{11} = B_{12} = 0`),
        " かつ ",
        math(String.raw`(B_{21}, B_{22}) \neq (0, 0)`),
        "）。",
        math(String.raw`v := (B_{22},\ -B_{21})^{\mathsf T}`),
        " と置く。",
        math(String.raw`B_{22} \neq 0`),
        " または ",
        math(String.raw`-B_{21} \neq 0`),
        " なので ",
        math(String.raw`v \neq 0`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(Bv)_1
&= B_{11}B_{22} + B_{12}\left(-B_{21}\right)
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= 0\cdot B_{22} + 0\cdot\left(-B_{21}\right)
   &&\bigl(\because B_{11} = B_{12} = 0\bigr) \\
&= 0
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(Bv)_2
&= B_{21}B_{22} + B_{22}\left(-B_{21}\right)
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= B_{21}B_{22} - B_{22}B_{21}
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr) \\
&= B_{21}B_{22} - B_{21}B_{22}
   &&\bigl(\because \mathbb{C}\text{ の乗法の可換則}\bigr) \\
&= 0
   &&\bigl(\because x - x = 0\bigr)
\end{aligned}`,
      ),
      paragraph([
        "1 行目も 2 行目も零の場合（",
        math(String.raw`B_{11} = B_{12} = B_{21} = B_{22} = 0`),
        "）。",
        math(String.raw`v := (1,\ 0)^{\mathsf T}`),
        " と置く。",
        math(String.raw`1 \neq 0`),
        " なので ",
        math(String.raw`v \neq 0`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(Bv)_1
&= B_{11}\cdot 1 + B_{12}\cdot 0
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= 0\cdot 1 + 0\cdot 0
   &&\bigl(\because B_{11} = B_{12} = 0\bigr) \\
&= 0
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(Bv)_2
&= B_{21}\cdot 1 + B_{22}\cdot 0
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= 0\cdot 1 + 0\cdot 0
   &&\bigl(\because B_{21} = B_{22} = 0\bigr) \\
&= 0
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "どの場合も ",
        math(String.raw`v \neq 0`),
        " かつ ",
        math(String.raw`Bv = 0`),
        " となる ",
        math(String.raw`v \in \mathbb{C}^2`),
        " がある。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: eigenvector_of_A_theta_tilde の Step 1 が「λ が固有値であることは det(A(θ) − λI) = 0 と同値」を証明なしに使っていたので、その中身として足した。一般の n×n の行列式の理論（余因子展開・乗法性）は使わず、2×2 の成分計算だけで示す。",
        "数値検証: sagemath/check/nonzero_kernel_iff_det_zero_two_by_two/。",
      ],
    },
  },
]);
