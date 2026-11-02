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
        "（正則）について、",
        ref("mat_conj"),
        " の共役写像 ",
        math(String.raw`T_B : \mathrm{Mat}(n,\mathbb{C}) \to \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`T_B(A) = (BA)B^{-1}`),
        "（",
        ref("mat_conj"),
        " の定義）は次を満たす。ここで、正則な ",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{C})`),
        " について ",
        math(String.raw`P^{-1}`),
        " は ",
        math(String.raw`PP^{-1} = I`),
        " かつ ",
        math(String.raw`P^{-1}P = I`),
        " を満たす行列である（正則の意味。",
        math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`),
        "）。",
      ]),
      list([
        ["乗法的: 任意の ", math(String.raw`A, C \in \mathrm{Mat}(n,\mathbb{C})`), " について ", math(String.raw`T_B(AC) = T_B(A) T_B(C)`)],
        ["単位的: ", math(String.raw`T_B(I) = I`)],
        [
          "合成則: ",
          math(String.raw`G, H \in (\mathrm{Mat}(n,\mathbb{C}))^\times`),
          "（正則）について ",
          math(String.raw`GH`),
          " は正則であり、",
          ref("mat_conj"),
          " の共役写像 ",
          math(String.raw`T_G, T_H, T_{GH}`),
          " について ",
          math(String.raw`T_G \circ T_H = T_{GH}`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "鎖が引く 3 つの主張（行列の積の結合法則と、単位行列を左右から掛けること）は、どれもその行列の大きさをすべてこの主張の ",
        math("n"),
        " として使う。",
      ]),
      paragraph(["乗法性を示す。", math(String.raw`A, C \in \mathrm{Mat}(n,\mathbb{C})`), " とする。"]),
      displayMath(
        String.raw`\begin{aligned}
T_B(AC)
&= \bigl(B(AC)\bigr)B^{-1}
&&\bigl(\because\ \blkref{mat_conj}\text{ の }T_B\text{ の定義}\bigr)\\
&= \bigl((BA)C\bigr)B^{-1}
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= \bigl((BA)(IC)\bigr)B^{-1}
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&= \Bigl((BA)\bigl((B^{-1}B)C\bigr)\Bigr)B^{-1}
&&\bigl(\because\ B^{-1}B = I\bigr)\\
&= \Bigl((BA)\bigl(B^{-1}(BC)\bigr)\Bigr)B^{-1}
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= \Bigl(\bigl((BA)B^{-1}\bigr)(BC)\Bigr)B^{-1}
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= \bigl((BA)B^{-1}\bigr)\bigl((BC)B^{-1}\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= T_B(A)\bigl((BC)B^{-1}\bigr)
&&\bigl(\because\ \blkref{mat_conj}\text{ の }T_B\text{ の定義}\bigr)\\
&= T_B(A) T_B(C)
&&\bigl(\because\ \blkref{mat_conj}\text{ の }T_B\text{ の定義}\bigr)
\end{aligned}`,
      ),
      paragraph(["単位性を示す。"]),
      displayMath(
        String.raw`\begin{aligned}
T_B(I)
&= (BI)B^{-1}
&&\bigl(\because\ \blkref{mat_conj}\text{ の }T_B\text{ の定義}\bigr)\\
&= BB^{-1}
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\bigr)\\
&= I
&&\bigl(\because\ BB^{-1} = I\bigr)
\end{aligned}`,
      ),
      paragraph([
        "合成則を示す。",
        math(String.raw`G, H \in (\mathrm{Mat}(n,\mathbb{C}))^\times`),
        "（正則）とする。準備として、",
        math(String.raw`GH`),
        " が正則で ",
        math(String.raw`(GH)^{-1} = H^{-1}G^{-1}`),
        " であることを確認する。",
        math(String.raw`H^{-1}G^{-1}`),
        " が ",
        math(String.raw`GH`),
        " の右逆元かつ左逆元であることを示せばよい。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(GH)(H^{-1}G^{-1})
&= G\bigl(H(H^{-1}G^{-1})\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= G\bigl((HH^{-1})G^{-1}\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= G(IG^{-1})
&&\bigl(\because\ HH^{-1} = I\bigr)\\
&= GG^{-1}
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&= I
&&\bigl(\because\ GG^{-1} = I\bigr)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(H^{-1}G^{-1})(GH)
&= H^{-1}\bigl(G^{-1}(GH)\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= H^{-1}\bigl((G^{-1}G)H\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= H^{-1}(IH)
&&\bigl(\because\ G^{-1}G = I\bigr)\\
&= H^{-1}H
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&= I
&&\bigl(\because\ H^{-1}H = I\bigr)
\end{aligned}`,
      ),
      paragraph([
        "よって、",
        math(String.raw`H^{-1}G^{-1}`),
        " は ",
        math(String.raw`GH`),
        " の両側逆元であり、",
        math(String.raw`GH`),
        " は正則である。",
        math(String.raw`(GH)^{-1}`),
        " は ",
        math(String.raw`(GH)^{-1}(GH) = I`),
        " を満たすので（正則の意味）、逆元は一つに定まる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(GH)^{-1}
&= (GH)^{-1}I
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\bigr)\\
&= (GH)^{-1}\bigl((GH)(H^{-1}G^{-1})\bigr)
&&\bigl(\because\ \text{上の右逆元の鎖}\bigr)\\
&= \bigl((GH)^{-1}(GH)\bigr)(H^{-1}G^{-1})
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= I(H^{-1}G^{-1})
&&\bigl(\because\ (GH)^{-1}(GH) = I\bigr)\\
&= H^{-1}G^{-1}
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "任意の ",
        math(String.raw`X \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(T_G \circ T_H)(X)
&= T_G\bigl(T_H(X)\bigr)
&&\bigl(\because\ \text{写像の合成の定義}\bigr)\\
&= T_G\bigl((HX)H^{-1}\bigr)
&&\bigl(\because\ \blkref{mat_conj}\text{ の }T_B\text{ の定義（}B \to H\text{）}\bigr)\\
&= \Bigl(G\bigl((HX)H^{-1}\bigr)\Bigr)G^{-1}
&&\bigl(\because\ \blkref{mat_conj}\text{ の }T_B\text{ の定義（}B \to G\text{）}\bigr)\\
&= \Bigl(\bigl(G(HX)\bigr)H^{-1}\Bigr)G^{-1}
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= \Bigl(\bigl((GH)X\bigr)H^{-1}\Bigr)G^{-1}
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= \bigl((GH)X\bigr)(H^{-1}G^{-1})
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= \bigl((GH)X\bigr)(GH)^{-1}
&&\bigl(\because\ (GH)^{-1} = H^{-1}G^{-1}\bigr)\\
&= T_{GH}(X)
&&\bigl(\because\ \blkref{mat_conj}\text{ の }T_B\text{ の定義（}B \to GH\text{）}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。よって、任意の ",
        math(String.raw`X \in \mathrm{Mat}(n,\mathbb{C})`),
        " について ",
        math(String.raw`(T_G \circ T_H)(X) = T_{GH}(X)`),
        " であるから、",
        math(String.raw`T_G \circ T_H = T_{GH}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-11-02: 主張の中で T_B(A) = BAB^{-1} と定義し直していた共役写像を mat_conj の T_B（(BA)B^{-1} と読む）として述べ直し、合成則の T_A・T_{AB} も同じ写像とし、AB が正則であることを主張に入れた（証明の準備で示していた）。" +
          "三つの鎖の括弧を外した行（BACB^{-1} など）を括弧付きの行にし、名前だけの根拠「行列の積の結合法則」「単位元の性質」を mat_mult_associative・identity_matrix_is_left_unit_of_mat_mult・identity_matrix_is_right_unit_of_mat_mult へのラベル参照にした。結合法則を 1 行に 2 回使っていた行を 1 回ずつに割った（乗法性の鎖は 7 行から 9 行、合成則の鎖は 6 行から 8 行、逆元の 2 本は 4 行から 5 行）。合成則の正則な行列を A, B から G, H に、変数 M を X にした（乗法性の A と主張の頭の B、行列の大きさの文字と紛れないように）。「逆元の一意性から (AB)^{-1} = B^{-1}A^{-1}」を、(GH)^{-1}(GH) = I と右逆元の鎖から (GH)^{-1} = H^{-1}G^{-1} を出す 5 行の鎖にした（左逆元の鎖は GH が正則であることに使う）。正則の意味（正則な P について P^{-1} が満たす 2 式）を主張に書いた。主張は弱めていない（「GH は正則」を足した分だけ強めた）。" +
          "Lean の対応は Ising2D.Conjugation.conj_mul_matrix・conj_one_matrix・mul_mul_inv_rev_matrix・inv_rev_mul_mul_matrix・mulUnitOfChains（GH が正則）・units_mul_inv_rev_matrix・conj_comp_matrix・conj_comp_matrix_of_chains（ClaimConjugationIsRingHom.lean）、必要十分版 NecSuf.Conj.sandwich_mul・sandwich_one・sandwich_comp を同じ段の calc にした。数値検証: sagemath/check/117_conjugation_is_ring_homomorphism/check_02_chains.sage。",
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
    id: "finite_matrix_definition_difference",
    kind: "definition",
    title: { text: "行列の差" },
    labels: ["def_matrix_difference"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " について、差 ",
        math(String.raw`A - B \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`(A - B)_{ik} := A_{ik} - B_{ik}
\qquad (i \in \{1,\dots,m\},\ k \in \{1,\dots,p\})`),
      paragraph([
        "で定める。右辺は ",
        ref("def_complex_difference"),
        " の複素数の差である。数ベクトルの差も ",
        ref("mat_mult"),
        " のとおり ",
        math(String.raw`m`),
        " 行 1 列の行列の差としてこの式で定まる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 本文の多くの証明が「行列の差は成分ごと」を定義のブロックを置かずに根拠にしていた。eigenvector_of_A_theta_tilde Step 1 の同値の鎖を定義から引けるよう足した。",
      ],
    },
  },
  {
    id: "finite_matrix_definition_zero_matrix",
    kind: "definition",
    title: { text: "零行列" },
    labels: ["def_zero_matrix"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        " について、",
        math(String.raw`O \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`O_{ik} := 0
\qquad (i \in \{1,\dots,m\},\ k \in \{1,\dots,p\})`),
      paragraph([
        "で定め、零行列と呼ぶ。",
        math(String.raw`p = 1`),
        " のとき（数ベクトルのとき）は ",
        math(String.raw`0`),
        " と書いて零ベクトルと呼ぶ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 本文の証明が「零行列」「零ベクトル」を定義のブロックを置かずに使っていた。matrix_difference_zero_iff_equal と def_eigenvector が引けるよう足した。",
      ],
    },
  },
  {
    id: "finite_matrix_definition_negation",
    kind: "definition",
    title: { text: "行列の符号反転" },
    labels: ["def_matrix_negation"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " について、",
        math(String.raw`-A \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`(-A)_{ik} := -A_{ik}
\qquad (i \in \{1,\dots,m\},\ k \in \{1,\dots,p\})`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`-A_{ik} \in \mathbb{C}`),
        " は ",
        ref("multiply_by_minus_one"),
        " による。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 本文の証明が行列の符号反転 -A を定義のブロックを置かずに使っていた（pauli_matrix_products の反可換性の 3 式など）。pauli_matrix_products が引けるよう足した。",
      ],
    },
  },
  {
    id: "finite_matrix_claim_difference_is_zero_iff_equal",
    kind: "claim",
    title: { text: "行列の差が零行列であることと等しいことの同値" },
    labels: ["matrix_difference_zero_iff_equal"],
    statement: [
      paragraph([
        math(String.raw`m, p \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,p,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`A - B = O \iff A = B`),
      paragraph([
        "が成り立つ。",
        math(String.raw`A - B`),
        " は ",
        ref("def_matrix_difference"),
        "、",
        math(String.raw`O`),
        " は ",
        ref("def_zero_matrix"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([
        "行列が等しいことは、同じ大きさのもとですべての成分が等しいことである。",
        math(String.raw`i`),
        " は ",
        math(String.raw`\{1,\dots,m\}`),
        "、",
        math(String.raw`k`),
        " は ",
        math(String.raw`\{1,\dots,p\}`),
        " を動く。",
      ]),
      displayMath(String.raw`\begin{aligned}
&A - B = O \\
&\iff \forall i, k,\ (A - B)_{ik} = O_{ik}
   &&\bigl(\because \text{行列の等号は成分ごと}\bigr) \\
&\iff \forall i, k,\ A_{ik} - B_{ik} = O_{ik}
   &&\bigl(\because \blkref{def_matrix_difference}\bigr) \\
&\iff \forall i, k,\ A_{ik} - B_{ik} = 0
   &&\bigl(\because \blkref{def_zero_matrix}\bigr) \\
&\iff \forall i, k,\ A_{ik} = B_{ik}
   &&\bigl(\because \text{移項}\bigr) \\
&\iff A = B
   &&\bigl(\because \text{行列の等号は成分ごと}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: eigenvector_of_A_theta_tilde Step 1 の「Av = λv ⟺ Av − λv = 0」が「移項」とだけ書いて行列（数ベクトル）の差の定義を経ていなかったので、成分ごとの移項に帰着する主張として足した。",
      ],
    },
  },
  {
    id: "finite_matrix_claim_difference_distributes_over_vector_product",
    kind: "claim",
    title: { text: "行列の差と数ベクトルの積の分配則" },
    labels: ["matrix_difference_mul_vector"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`v \in \mathbb{C}^n`),
        " について",
      ]),
      displayMath(String.raw`Av - Bv = (A - B) v`),
      paragraph([
        "が成り立つ。差は ",
        ref("def_matrix_difference"),
        "、行列と数ベクトルの積は ",
        ref("mat_mult"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(Av - Bv)_i
&= (Av)_i - (Bv)_i
   &&\bigl(\because \blkref{def_matrix_difference}\bigr) \\
&= \sum_{j=1}^{n} A_{ij}\,v_j - \sum_{j=1}^{n} B_{ij}\,v_j
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= \sum_{j=1}^{n} \left(A_{ij}\,v_j - B_{ij}\,v_j\right)
   &&\bigl(\because \text{有限和の差は項ごとの差の和}\bigr) \\
&= \sum_{j=1}^{n} \left(A_{ij} - B_{ij}\right) v_j
   &&\bigl(\because \text{分配則}\bigr) \\
&= \sum_{j=1}^{n} (A - B)_{ij}\,v_j
   &&\bigl(\because \blkref{def_matrix_difference}\bigr) \\
&= ((A - B) v)_i
   &&\bigl(\because \blkref{mat_mult}\bigr)
\end{aligned}`),
      paragraph([
        "よって全ての成分が一致し、主張を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: eigenvector_of_A_theta_tilde Step 1 が「行列とベクトルの積の分配則」を証明なしに根拠にしていたので足した。",
      ],
    },
  },
  {
    id: "finite_matrix_claim_vector_product_distributes_over_vector_difference",
    kind: "claim",
    title: { text: "行列と数ベクトルの差の積の分配則" },
    labels: ["mat_mult_vector_difference"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(m,n,\mathbb{C})`),
        "、",
        math(String.raw`u, w \in \mathbb{C}^n`),
        " について",
      ]),
      displayMath(String.raw`A(u - w) = Au - Aw`),
      paragraph([
        "が成り立つ。差は ",
        ref("def_matrix_difference"),
        "、行列と数ベクトルの積は ",
        ref("mat_mult"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i \in \{1,\dots,m\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A(u - w)\bigr)_i
&= \sum_{j=1}^{n} A_{ij}\,(u - w)_j
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= \sum_{j=1}^{n} A_{ij}\,(u_j - w_j)
   &&\bigl(\because \blkref{def_matrix_difference}\bigr) \\
&= \sum_{j=1}^{n} \left(A_{ij}\,u_j - A_{ij}\,w_j\right)
   &&\bigl(\because \text{分配則}\bigr) \\
&= \sum_{j=1}^{n} A_{ij}\,u_j - \sum_{j=1}^{n} A_{ij}\,w_j
   &&\bigl(\because \text{有限和の差は項ごとの差の和}\bigr) \\
&= (Au)_i - (Aw)_i
   &&\bigl(\because \blkref{mat_mult}\bigr) \\
&= (Au - Aw)_i
   &&\bigl(\because \blkref{def_matrix_difference}\bigr)
\end{aligned}`),
      paragraph([
        "よって全ての成分が一致し、主張を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: trace_of_idempotent Step 1 の Q(x − Qx) = Qx − Q(Qx) が「行列の積の分配則」を証明なしに根拠にしていたので、行列の差についての matrix_difference_mul_vector と対をなす、数ベクトルの差についての分配則として足した。",
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
        " の零ベクトル（",
        ref("def_zero_matrix"),
        "）、",
        math(String.raw`Av`),
        " は ",
        ref("mat_mult"),
        " の行列とベクトルの積、",
        math(String.raw`\lambda v`),
        " は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍である。",
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
