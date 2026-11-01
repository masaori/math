import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/009_eigenvalues_of_V.ts";

export default defineBlocks([
  {
    id: "heading_eigenvalues_of_V",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "トレース・エルミート行列・正定値性" },
    labels: [],
  },

  {
    id: "eigenvalues_of_V_001_definition_trace",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\text{トレース } \mathrm{tr}` },
    labels: ["def_trace"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`A = (A_{k l})_{1 \leq k, l \leq n} \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対して",
      ]),
      displayMath(String.raw`\mathrm{tr}(A) := \sum_{k=1}^{n} A_{k k} \in \mathbb{C}`),
      paragraph([
        "と定める（対角成分の有限和なので、収束の議論を要しない）。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_002_claim_trace_properties",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { text: "トレースの基本性質" },
    labels: ["trace_basic_properties"],
    statement: [
      paragraph([
        "トレースは ", ref("def_trace"), "、行列の積は ", ref("mat_mult"), "、行列の和は ", ref("def_matrix_sum"),
        "、行列のスカラー倍は ", ref("def_matrix_scalar_multiple"), "、単位行列は ", ref("def_identity_matrix"),
        "、複素数の演算の性質は ", ref("complex_numbers_form_a_field"), " のものとする。",
      ]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        " について、",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \mathrm{tr}(\alpha A + \beta B) = \alpha\,\mathrm{tr}(A) + \beta\,\mathrm{tr}(B)`), "（線型性）"],
        [math(String.raw`\text{(2)}\quad \mathrm{tr}(AB) = \mathrm{tr}(BA)`), "（巡回性）"],
        [
          math(String.raw`\text{(3)}\quad \mathrm{tr}\bigl(I_{\mathrm{Mat}(n,\mathbb{C})}\bigr) = \sum_{k=1}^{n} 1_{\mathbb{C}}`),
          "（",
          math(String.raw`1_{\mathbb{C}}`),
          " を ",
          math(String.raw`n`),
          " 個足した和。",
          math(String.raw`1_{\mathbb{C}}`),
          " は ",
          ref("inclusion_rr_to_cc"),
          " の略記）",
        ],
        [
          math(String.raw`\text{(4)}\quad P, P' \in \mathrm{Mat}(n,\mathbb{C})`),
          " が ",
          math(String.raw`P'P = I_{\mathrm{Mat}(n,\mathbb{C})}`),
          " を満たすなら ",
          math(String.raw`\mathrm{tr}\bigl(P(AP')\bigr) = \mathrm{tr}(A)`),
          "（相似変換で不変）",
        ],
      ]),
    ],
    proof: [
      paragraph(["(1)"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(\alpha A + \beta B)
&= \sum_{k=1}^{n} (\alpha A + \beta B)_{kk}
&&(\because \blkref{def_trace}) \\
&= \sum_{k=1}^{n} \bigl((\alpha A)_{kk} + (\beta B)_{kk}\bigr)
&&(\because \blkref{def_matrix_sum}) \\
&= \sum_{k=1}^{n} \bigl(\alpha A_{kk} + \beta B_{kk}\bigr)
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \sum_{k=1}^{n} \alpha A_{kk} + \sum_{k=1}^{n} \beta B_{kk}
&&(\because \mathbb{C}\ \text{の加法の結合法則・交換法則による有限和の並べ替え。}\blkref{complex_numbers_form_a_field}) \\
&= \alpha \sum_{k=1}^{n} A_{kk} + \beta \sum_{k=1}^{n} B_{kk}
&&(\because \mathbb{C}\ \text{の分配法則。}\blkref{complex_numbers_form_a_field}) \\
&= \alpha\,\mathrm{tr}(A) + \beta\,\mathrm{tr}(B)
&&(\because \blkref{def_trace})
\end{aligned}`,
      ),
      paragraph(["(2)"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(AB)
&= \sum_{k=1}^{n} (AB)_{kk}
&&(\because \blkref{def_trace}) \\
&= \sum_{k=1}^{n}\sum_{j=1}^{n} A_{kj}B_{jk}
&&(\because \blkref{mat_mult}) \\
&= \sum_{k=1}^{n}\sum_{j=1}^{n} B_{jk}A_{kj}
&&(\because \mathbb{C}\ \text{の積の交換法則。}\blkref{complex_numbers_form_a_field}) \\
&= \sum_{j=1}^{n}\sum_{k=1}^{n} B_{jk}A_{kj}
&&(\because \mathbb{C}\ \text{の加法の結合法則・交換法則による有限和の順序交換。}\blkref{complex_numbers_form_a_field}) \\
&= \sum_{j=1}^{n} (BA)_{jj}
&&(\because \blkref{mat_mult}) \\
&= \mathrm{tr}(BA)
&&(\because \blkref{def_trace})
\end{aligned}`,
      ),
      paragraph(["(3)"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\bigl(I_{\mathrm{Mat}(n,\mathbb{C})}\bigr)
&= \sum_{k=1}^{n} \bigl(I_{\mathrm{Mat}(n,\mathbb{C})}\bigr)_{kk}
&&(\because \blkref{def_trace}) \\
&= \sum_{k=1}^{n} \delta_{kk}
&&(\because \blkref{def_identity_matrix}) \\
&= \sum_{k=1}^{n} 1_{\mathbb{C}}
&&(\because \blkref{def_kronecker_delta}\ \text{の}\ i = j\ \text{の場合})
\end{aligned}`,
      ),
      paragraph(["(4)"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\bigl(P(AP')\bigr)
&= \mathrm{tr}\bigl((PA)P'\bigr)
&&(\because \blkref{mat_mult_associative}) \\
&= \mathrm{tr}\bigl(P'(PA)\bigr)
&&(\because \text{(2) を } A \to PA,\ B \to P' \text{ に適用}) \\
&= \mathrm{tr}\bigl((P'P)A\bigr)
&&(\because \blkref{mat_mult_associative}) \\
&= \mathrm{tr}\bigl(I_{\mathrm{Mat}(n,\mathbb{C})} A\bigr)
&&(\because P'P = I_{\mathrm{Mat}(n,\mathbb{C})}) \\
&= \mathrm{tr}(A)
&&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "本文はこれまでトレースを定義せずに使っていなかった（008 章までに tr は現れない）。本章で初めて必要になるため、定義と必要な性質だけをここで書き下した。",
        "2026-08-31 の式変形統一で、二本の鎖に行中の \\quad(\\because …) で置かれていた根拠 10 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・参照は変えていない。",
        "2026-11-01: SageMath の検算（sagemath/check/trace_basic_properties/）を付けるにあたり、(1)(3) の散文を根拠付きの鎖に、(2) の「順序交換と積の可換性」を二行に分け、各行へ blkref を足した。" +
          "行列の和の定義が本文に無かったので def_matrix_sum を足した。単位行列の記号を def_identity_matrix の I_{Mat(n,C)} に揃えた。" +
          "(3) の右辺 n は整数 n を ℂ の元として扱う写像が本文に無いので、1_C の n 個の和 Σ_{k=1}^{n} 1_C と書いた。" +
          "(4) の「P が可逆」は Mat(2^M,C) 以外の可逆性の定義が本文に無く、証明が使うのは P^{-1}P = I だけなので、仮定を P'P = I に改め、括弧を省く約束が本文に無いので左辺を tr(P(AP')) と書いた。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_003_claim_trace_of_idempotent",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { text: "冪等行列のトレースは像の次元" },
    labels: ["trace_of_idempotent"],
    statement: [
      paragraph([
        "トレースは ", ref("def_trace"), "、行列の積は ", ref("mat_mult"), "、行列の冪 ",
        math(String.raw`Q^2`), " は ", ref("def_exp"), " (1)、数ベクトルの和は ", ref("def_matrix_sum"),
        "、差は ", ref("def_matrix_difference"), "、零ベクトル ", math(String.raw`0`), " は ", ref("def_zero_matrix"),
        " のものとする。",
      ]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`Q \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`Q^2 = Q`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`\mathbb{C}^n = \mathrm{im}\,Q \oplus \ker Q, \qquad
\mathrm{tr}(Q) = \dim_{\mathbb{C}} \mathrm{im}\,Q`),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`\mathrm{im}\,Q := \{Qx \mid x \in \mathbb{C}^n\}`),
        "、",
        math(String.raw`\ker Q := \{x \in \mathbb{C}^n \mid Qx = 0\}`),
        " である。右辺の自然数 ",
        math(String.raw`\dim_{\mathbb{C}} \mathrm{im}\,Q`),
        " は、",
        math(String.raw`1_{\mathbb{C}}`),
        " をその個数だけ足した ",
        math(String.raw`\mathbb{C}`),
        " の元として読む（",
        math(String.raw`1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記。零個の和は ",
        math(String.raw`0_{\mathbb{C}}`),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備（",
        math(String.raw`Q^2`),
        " は積 ",
        math(String.raw`QQ`),
        " に等しい）。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q^2
&= Q^1 Q
&&(\because\ A^{m+1} := A^m A\ \text{を}\ m = 1\ \text{に。}\blkref{def_exp}\ (1))\\
&= (Q^0 Q) Q
&&(\because\ A^{m+1} := A^m A\ \text{を}\ m = 0\ \text{に。}\blkref{def_exp}\ (1))\\
&= (I Q) Q
&&(\because\ A^0 := I\ \text{。}\blkref{def_exp}\ (1))\\
&= Q Q
&&(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`),
      paragraph([
        "よって仮定 ",
        math(String.raw`Q^2 = Q`),
        " から ",
        math(String.raw`QQ = Q`),
        " である。",
      ]),
      paragraph([
        "Step 1（直和分解）。任意の ",
        math(String.raw`x \in \mathbb{C}^n`),
        " を取る。",
        math(String.raw`k \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(Qx + (x - Qx)\bigr)_k
&= (Qx)_k + (x - Qx)_k
&&(\because\ \blkref{def_matrix_sum})\\
&= (Qx)_k + \bigl(x_k - (Qx)_k\bigr)
&&(\because\ \blkref{def_matrix_difference})\\
&= x_k
&&(\because\ \mathbb{C}\ \text{の加法の結合律・交換律・加法逆元・零元。}\blkref{complex_numbers_form_a_field})
\end{aligned}`),
      paragraph([
        "なので、行列の等号は成分ごとであることから ",
        math(String.raw`x = Qx + (x - Qx)`),
        " であり、",
        math(String.raw`Qx \in \mathrm{im}\,Q`),
        "（",
        math(String.raw`\mathrm{im}\,Q`),
        " の定め方）である。",
        math(String.raw`x - Qx \in \ker Q`),
        " は次の計算による。",
      ]),
      displayMath(String.raw`\begin{aligned}
Q(x - Qx)
&= Qx - Q(Qx)
&&(\because\ \blkref{mat_mult_vector_difference})\\
&= Qx - (QQ)x
&&(\because\ \blkref{mat_mult_associative})\\
&= Qx - Qx
&&(\because\ \text{準備の}\ QQ = Q)\\
&= 0
&&(\because\ \blkref{matrix_difference_zero_iff_equal}\ \text{の}\ \Leftarrow\ \text{を}\ A = B = Qx\ \text{に})
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`\mathbb{C}^n = \mathrm{im}\,Q + \ker Q`),
        "。また ",
        math(String.raw`y \in \mathrm{im}\,Q \cap \ker Q`),
        " とすると、",
        math(String.raw`y = Qx`),
        " なる ",
        math(String.raw`x \in \mathbb{C}^n`),
        " が取れて",
      ]),
      displayMath(String.raw`\begin{aligned}
y
&= Qx
&&(\because\ x\ \text{の取り方})\\
&= (QQ)x
&&(\because\ \text{準備の}\ QQ = Q)\\
&= Q(Qx)
&&(\because\ \blkref{mat_mult_associative})\\
&= Qy
&&(\because\ Qx = y)\\
&= 0
&&(\because\ y \in \ker Q)
\end{aligned}`),
      paragraph([
        "よって交わりは ",
        math(String.raw`\{0\}`),
        " であり、和は直和である。",
      ]),
      paragraph([
        "Step 2（基底を並べた行列 ",
        math(String.raw`P`),
        " について ",
        math(String.raw`QP = PD`),
        "）。",
        math(String.raw`r := \dim_{\mathbb{C}}\mathrm{im}\,Q \in \mathbb{Z}_{\geq 0}`),
        " とおき、",
        math(String.raw`\mathrm{im}\,Q`),
        " の基底 ",
        math(String.raw`v_1,\dots,v_r`),
        " と ",
        math(String.raw`\ker Q`),
        " の基底 ",
        math(String.raw`v_{r+1},\dots,v_n`),
        " を取る（Step 1 の直和分解より ",
        math(String.raw`v_1,\dots,v_n`),
        " は ",
        math(String.raw`\mathbb{C}^n`),
        " の基底）。",
        math(String.raw`j \in \{1,\dots,r\}`),
        " のとき ",
        math(String.raw`v_j = Qx_j`),
        " なる ",
        math(String.raw`x_j \in \mathbb{C}^n`),
        " が取れて",
      ]),
      displayMath(String.raw`\begin{aligned}
Qv_j
&= Q(Qx_j)
&&(\because\ v_j = Qx_j)\\
&= (QQ)x_j
&&(\because\ \blkref{mat_mult_associative})\\
&= Qx_j
&&(\because\ \text{準備の}\ QQ = Q)\\
&= v_j
&&(\because\ v_j = Qx_j)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`j \in \{r+1,\dots,n\}`),
        " のとき ",
        math(String.raw`Qv_j = 0`),
        "（",
        math(String.raw`v_j \in \ker Q`),
        "）である。",
        math(String.raw`P := \left[\,v_1\ \cdots\ v_n\,\right] \in \mathrm{Mat}(n,\mathbb{C})`),
        "（",
        ref("mat_columnwise"),
        " の列に並べた行列）とおき、",
        math(String.raw`D \in \mathrm{Mat}(n,\mathbb{C})`),
        " を",
      ]),
      displayMath(String.raw`D_{kl} :=
\begin{cases}
  1_{\mathbb{C}} & (k = l \leq r) \\
  0_{\mathbb{C}} & (\text{それ以外})
\end{cases}
\qquad (k, l \in \{1,\dots,n\})`),
      paragraph([
        "で定める。",
        math(String.raw`i, l \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(PD)_{il}
&= \sum_{k=1}^{n} P_{ik}\,D_{kl}
&&(\because\ \blkref{mat_mult})\\
&= P_{il}\,D_{ll} + \sum_{k \neq l} P_{ik}\,D_{kl}
&&(\because\ k = l\ \text{の項を分ける。加法の結合律・交換律。}\blkref{complex_numbers_form_a_field})\\
&= P_{il}\,D_{ll} + \sum_{k \neq l} P_{ik}\,0_{\mathbb{C}}
&&(\because\ k \neq l\ \text{では}\ D\ \text{の定め方から}\ D_{kl} = 0_{\mathbb{C}})\\
&= P_{il}\,D_{ll} + \sum_{k \neq l} 0_{\mathbb{C}}
&&(\because\ \blkref{complex_times_zero_is_zero})\\
&= P_{il}\,D_{ll}
&&(\because\ 0_{\mathbb{C}}\ \text{は加法の単位元。}\blkref{complex_numbers_form_a_field})\\
&= (v_l)_i\,D_{ll}
&&(\because\ P\ \text{の定め方})\\
&= \begin{cases}
     (v_l)_i\,1_{\mathbb{C}} & (l \leq r) \\
     (v_l)_i\,0_{\mathbb{C}} & (l > r)
   \end{cases}
&&(\because\ D\ \text{の定め方})\\
&= \begin{cases}
     (v_l)_i & (l \leq r) \\
     0_{\mathbb{C}} & (l > r)
   \end{cases}
&&(\because\ 1_{\mathbb{C}}\ \text{は積の単位元（}\blkref{complex_numbers_form_a_field}\text{）と}\ \blkref{complex_times_zero_is_zero})\\
&= (Qv_l)_i
&&(\because\ l \leq r\ \text{では上の}\ Qv_l = v_l\text{、}l > r\ \text{では}\ Qv_l = 0\ \text{と}\ \blkref{def_zero_matrix})\\
&= \bigl(\left[\,Qv_1\ \cdots\ Qv_n\,\right]\bigr)_{il}
&&(\because\ \blkref{mat_columnwise}\ \text{の、列に並べた行列の成分の定め方})\\
&= (QP)_{il}
&&(\because\ \blkref{mat_columnwise})
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`QP = PD`),
        " である。",
      ]),
      paragraph([
        "Step 3（トレースの計算）。",
        math(String.raw`v_1,\dots,v_n`),
        " は ",
        math(String.raw`\mathbb{C}^n`),
        " の基底なので、",
        math(String.raw`P'P = PP' = I`),
        " を満たす ",
        math(String.raw`P' \in \mathrm{Mat}(n,\mathbb{C})`),
        " が取れる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(Q)
&= \mathrm{tr}\bigl(P'(QP)\bigr)
&&(\because\ \blkref{trace_basic_properties}\ (4)\ \text{を}\ P \to P',\ P' \to P,\ A \to Q\ \text{に。}PP' = I)\\
&= \mathrm{tr}\bigl(P'(PD)\bigr)
&&(\because\ \text{Step 2 の}\ QP = PD)\\
&= \mathrm{tr}\bigl((P'P)D\bigr)
&&(\because\ \blkref{mat_mult_associative})\\
&= \mathrm{tr}(ID)
&&(\because\ P'P = I)\\
&= \mathrm{tr}(D)
&&(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult})\\
&= \sum_{k=1}^{n} D_{kk}
&&(\because\ \blkref{def_trace})\\
&= \sum_{k=1}^{r} 1_{\mathbb{C}} + \sum_{k=r+1}^{n} 0_{\mathbb{C}}
&&(\because\ D\ \text{の定め方})\\
&= \sum_{k=1}^{r} 1_{\mathbb{C}}
&&(\because\ 0_{\mathbb{C}}\ \text{は加法の単位元。}\blkref{complex_numbers_form_a_field})\\
&= \dim_{\mathbb{C}} \mathrm{im}\,Q
&&(\because\ r\ \text{の定め方と、主張の右辺の読み方})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-17 の式変形統一で、Step 1 の二つの計算（x−Qx∈ker Q、交わりが零）、Step 2 の Qv_j=v_j、Step 3 のトレースの計算を、一続きの等号と行末の根拠へ揃えた。内容は変えていない。",
        "2026-09-02: Step 3 の鎖の直後に置いていた参照一覧を削り、相似変換でトレースが不変であることを使う行末の blkref へ移した。内容・式変形・根拠・参照は不変である。",
        "2026-11-01: SageMath の検算（sagemath/check/trace_of_idempotent/）を付けるときに直した。Q^2 = QQ を def_exp (1) の冪から導く準備を足し、Step 1 の分配則・結合則・零の行を mat_mult_vector_difference・mat_mult_associative・matrix_difference_zero_iff_equal で引き、x = Qx + (x − Qx) を成分の鎖にした。Step 2・3 は未定義の「表現行列」「基底変換行列」をやめ、基底を列に並べた P と対角の D を定めて QP = PD を成分の鎖で示し、tr(Q) を trace_basic_properties (4) から tr(D) へ運ぶ鎖にした。主張の右辺の自然数を ℂ の元として読む読み方を書いた。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    kind: "definition",
    origin: { path: SRC, ordinal: 13 },
    title: { text: "共役転置・エルミート行列・正定値行列" },
    labels: ["def_hermitian_positive_definite"],
    statement: [
      paragraph(["行列の積は ", ref("mat_mult"), "、実数の複素数への包含は ", ref("inclusion_rr_to_cc"), " を用いる。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A = (A_{kl}) \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対し、共役転置を",
      ]),
      displayMath(String.raw`(A^*)_{kl} := \overline{A_{lk}}`),
      paragraph([
        "で定める（",
        math(String.raw`\overline{\phantom{z}}`),
        " は ",
        ref("def_complex_conjugate"),
        " の複素共役）。",
        math(String.raw`x = (x_1,\dots,x_n) \in \mathbb{C}^n`),
        " を ",
        math(String.raw`n\times 1`),
        " 行列とみなすと ",
        math(String.raw`x^* A x \in \mathbb{C}`),
        "（",
        math(String.raw`1\times 1`),
        " 行列を ",
        math(String.raw`\mathbb{C}`),
        " と同一視する）である。",
      ]),
      paragraph([
        math(String.raw`A`),
        " が ",
        math(String.raw`A^* = A`),
        " を満たすとき ",
        math(String.raw`A`),
        " は**エルミート**であるという。エルミートな ",
        math(String.raw`A`),
        " が さらに",
      ]),
      displayMath(
        String.raw`\forall x \in \mathbb{C}^n \setminus \{0\} : \quad x^* A x \in \mathbb{R}_{>0}`,
      ),
      paragraph([
        "を満たすとき ",
        math(String.raw`A`),
        " は**正定値**であるという。",
      ]),
      paragraph([
        "成分がすべて実数で ",
        math(String.raw`A^{\top} = A`),
        "（転置に関して対称）な行列は ",
        math(String.raw`\overline{A_{lk}} = A_{lk} = A_{kl}`),
        " よりエルミートである。以下ではこれを**実対称**と呼ぶ。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "eigenvalues_of_V_012_claim_star_is_norm_preserving",
    kind: "claim",
    origin: { path: SRC, ordinal: 14 },
    title: { tex: String.raw`\|A^*\| = \|A\| \text{ と極限の共役転置}` },
    labels: ["star_preserves_norm_and_limits"],
    statement: [
      paragraph(["共役転置は ", ref("def_hermitian_positive_definite"), "、複素共役は ", ref("def_complex_conjugate"), "、行列積は ", ref("mat_mult"), "、行列の和・スカラー倍・差は ", ref("def_matrix_sum"), "・", ref("def_matrix_scalar_multiple"), "・", ref("def_matrix_difference"), "、ノルムと行列の列の収束は ", ref("def_matrix_norm"), " のものとする。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n,\mathbb{C})`),
        "、", math(String.raw`\alpha,\beta\in\mathbb C`), " および ", math(String.raw`(A_N)_{N\in\mathbb Z_{\ge0}}`), " を ", math(String.raw`\mathrm{Mat}(n,\mathbb{C})`), " の列とする。このとき、",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad (AB)^* = B^* A^*, \qquad (\alpha A + \beta B)^* = \overline{\alpha}A^* + \overline{\beta}B^*`)],
        [
          math(String.raw`\text{(2)}\quad \|A^*\| = \|A\|`),
          "（両辺は ",
          ref("def_matrix_norm"),
          " のとおり非負実数の有限和の非負の平方根であり、平方根を取るところで ",
          math(String.raw`\mathbb{R}`),
          " を使う）",
        ],
        [
          math(String.raw`\text{(3)}\quad A_N \to A \ \Longrightarrow\ A_N^* \to A^*`),
          "（",
          math(String.raw`N \to \infty`),
          " の極限は ",
          math(String.raw`\mathbb{R}`),
          " の数列 ",
          math(String.raw`\|A_N - A\|`),
          " の極限であり、ここで ",
          math(String.raw`\mathbb{R}`),
          " へ脱出する）",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) の第 1 式。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
((AB)^*)_{kl}
&= \overline{(AB)_{lk}}
&&(\because\ \blkref{def_hermitian_positive_definite})\\
&= \overline{\textstyle\sum_{j=1}^{n} A_{lj}B_{jk}}
&&(\because\ \blkref{mat_mult})\\
&= \textstyle\sum_{j=1}^{n} \overline{A_{lj}B_{jk}}
&&(\because\ \blkref{complex_conjugate_of_sum}\ \text{の}\ m = n)\\
&= \textstyle\sum_{j=1}^{n} \overline{A_{lj}}\;\overline{B_{jk}}
&&(\because\ \blkref{complex_conjugate_of_product}\ \text{を各項へ})\\
&= \textstyle\sum_{j=1}^{n} \overline{B_{jk}}\;\overline{A_{lj}}
&&(\because\ \text{積の可換性。}\blkref{complex_numbers_form_a_field}\ \text{を各項へ})\\
&= \textstyle\sum_{j=1}^{n} (B^*)_{kj}(A^*)_{jl}
&&(\because\ \blkref{def_hermitian_positive_definite}\ \text{を各項へ})\\
&= (B^*A^*)_{kl}
&&(\because\ \blkref{mat_mult})
\end{aligned}`,
      ),
      paragraph([
        "すべての成分が等しいので ",
        math(String.raw`(AB)^* = B^*A^*`),
        " である。",
      ]),
      paragraph([
        "(1) の第 2 式。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
((\alpha A + \beta B)^*)_{kl}
&= \overline{(\alpha A + \beta B)_{lk}}
&&(\because\ \blkref{def_hermitian_positive_definite})\\
&= \overline{(\alpha A)_{lk} + (\beta B)_{lk}}
&&(\because\ \blkref{def_matrix_sum})\\
&= \overline{\alpha A_{lk} + \beta B_{lk}}
&&(\because\ \blkref{def_matrix_scalar_multiple})\\
&= \overline{\alpha A_{lk}} + \overline{\beta B_{lk}}
&&(\because\ \blkref{complex_conjugate_of_sum}\ \text{の}\ m = 2)\\
&= \overline{\alpha}\;\overline{A_{lk}} + \overline{\beta}\;\overline{B_{lk}}
&&(\because\ \blkref{complex_conjugate_of_product}\ \text{を各項へ})\\
&= \overline{\alpha}\,(A^*)_{kl} + \overline{\beta}\,(B^*)_{kl}
&&(\because\ \blkref{def_hermitian_positive_definite}\ \text{を各項へ})\\
&= (\overline{\alpha}A^*)_{kl} + (\overline{\beta}B^*)_{kl}
&&(\because\ \blkref{def_matrix_scalar_multiple})\\
&= (\overline{\alpha}A^* + \overline{\beta}B^*)_{kl}
&&(\because\ \blkref{def_matrix_sum})
\end{aligned}`,
      ),
      paragraph([
        "すべての成分が等しいので ",
        math(String.raw`(\alpha A + \beta B)^* = \overline{\alpha}A^* + \overline{\beta}B^*`),
        " である。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`A\in\mathrm{Mat}(n,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A^*\|
&= \sqrt{\textstyle\sum_{k=1}^{n}\sum_{l=1}^{n}|(A^*)_{kl}|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \blkref{def_matrix_norm})\\
&= \sqrt{\textstyle\sum_{k=1}^{n}\sum_{l=1}^{n}|\overline{A_{lk}}|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \blkref{def_hermitian_positive_definite}\ \text{を各項へ})\\
&= \sqrt{\textstyle\sum_{k=1}^{n}\sum_{l=1}^{n}|A_{lk}|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \blkref{abs_of_complex_conjugate}\ \text{を各項へ})\\
&= \sqrt{\textstyle\sum_{l=1}^{n}\sum_{k=1}^{n}|A_{lk}|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{の有限和の順序の入れ替え})\\
&= \|A\|
&&(\because\ \blkref{def_matrix_norm}\ \text{の}\ i = l,\ j = k)
\end{aligned}`,
      ),
      paragraph([
        "(3) 準備として、",
        math(String.raw`N \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(A_N^* - A^*)_{kl}
&= (A_N^*)_{kl} - (A^*)_{kl}
&&(\because\ \blkref{def_matrix_difference})\\
&= \overline{(A_N)_{lk}} - \overline{A_{lk}}
&&(\because\ \blkref{def_hermitian_positive_definite}\ \text{を各項へ})\\
&= \overline{(A_N)_{lk} - A_{lk}}
&&(\because\ \blkref{complex_conjugate_of_difference})\\
&= \overline{(A_N - A)_{lk}}
&&(\because\ \blkref{def_matrix_difference})\\
&= ((A_N - A)^*)_{kl}
&&(\because\ \blkref{def_hermitian_positive_definite})
\end{aligned}`,
      ),
      paragraph([
        "なので ",
        math(String.raw`A_N^* - A^* = (A_N - A)^*`),
        " である。",
        math(String.raw`A_N\to A`),
        "、すなわち ",
        math(String.raw`\|A_N - A\| \to 0`),
        "（",
        ref("def_matrix_norm"),
        "）と仮定する。各 ",
        math(String.raw`N \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A_N^*-A^*\|
&= \|(A_N-A)^*\|
&&(\because\ \text{準備の}\ A_N^* - A^* = (A_N - A)^*)\\
&= \|A_N-A\|
&&(\because\ \text{(2) の}\ A\ \text{に}\ A_N - A\ \text{を入れたもの})
\end{aligned}`,
      ),
      paragraph([
        "なので、",
        math(String.raw`\mathbb{R}`),
        " の数列 ",
        math(String.raw`(\|A_N^*-A^*\|)_{N}`),
        " と ",
        math(String.raw`(\|A_N-A\|)_{N}`),
        " はすべての項が等しく、仮定より ",
        math(String.raw`\|A_N^*-A^*\| \to 0`),
        " である。",
        ref("def_matrix_norm"),
        " の収束の定義より ",
        math(String.raw`A_N^* \to A^*`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の式変形統一で、複素共役が和・積・絶対値を保つことと行列ノルムの定義への後置き参照を、実際に適用する各等号の行末へ移した。内容・式変形・根拠・参照は変えていない。",
        "2026-11-01: SageMath の検算（sagemath/check/star_preserves_norm_and_limits/）を付けるときに直した。複素共役が和・積・差・絶対値を保つことを、frobenius_inner_product_axioms の証明冒頭や「未記載の展開」からでなく、新しい主張 complex_conjugate_of_sum・complex_conjugate_of_product・complex_conjugate_of_difference・abs_of_complex_conjugate から引いた。「第 2 式も同様」としていた (1) の第 2 式を成分の鎖に書き下した。(2) の添字の付け替えを有限和の順序の入れ替えにした。(3) の「(1) の共役転置の線型性」を、def_matrix_difference と complex_conjugate_of_difference による成分の鎖 A_N^* − A^* = (A_N − A)^* にし、極限の段で ℝ へ脱出することを主張に書いた。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
    kind: "claim",
    origin: { path: SRC, ordinal: 15 },
    title: { tex: String.raw`\text{エルミート行列の } \exp \text{ は正定値}` },
    labels: ["exp_hermitian_is_positive_definite"],
    statement: [
      paragraph(["指数は ", ref("def_exp"), "、指数の積と零での値は ", ref("theorem_exp_product"), " と ", ref("theorem_exp_zero"), "、共役転置と正定値性は ", ref("def_hermitian_positive_definite"), "、行列積は ", ref("mat_mult"), " による。成分の共役と積は ", ref("def_complex_conjugate"), "、", ref("frobenius_inner_product_axioms"), " の証明冒頭、", ref("complex_numbers_form_a_field"), "、絶対値の零との同値は ", ref("abs_basic_properties"), "、ノルムは ", ref("def_matrix_norm"), "、実数の包含は ", ref("inclusion_rr_to_cc"), "、トレースは ", ref("def_trace"), " を用いる。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad S \in \mathrm{Mat}(n,\mathbb{C}) \text{ がエルミートなら } \exp(S) \text{ はエルミートかつ正定値}`),
        ],
        [
          math(String.raw`\text{(2)}\quad A \text{ が正定値、} B \text{ が可逆なら } B^* A B \text{ は正定値}`),
        ],
        [
          math(String.raw`\text{(3)}\quad A \text{ が正定値、} \alpha \in \mathbb{R}_{>0} \text{ なら } \alpha A \text{ は正定値}`),
        ],
        [math(String.raw`\text{(4)}\quad A \text{ が正定値なら } \mathrm{tr}(A) \in \mathbb{R}_{>0}`)],
      ]),
    ],
    proof: [
      paragraph([
        "(1) まずエルミート性。部分和を ",
        math(String.raw`E_K := \sum_{k=0}^{K}\frac{1}{k!}S^k`),
        " と置く。任意の ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(S^k)^*
&= (S^*)^k
   \quad (\because \text{積の共役転置を } k \text{ 回繰り返す、}\blkref{star_preserves_norm_and_limits}) \\
&= S^k
   \quad (\because S \text{ はエルミート、すなわち } S^* = S)
\end{aligned}`,
      ),
      paragraph(["したがって、"]),
      displayMath(
        String.raw`\begin{aligned}
E_K^*
&= \Bigl(\textstyle\sum_{k=0}^{K}\frac{1}{k!}S^k\Bigr)^*
   \quad (\because E_K \text{ の定義}) \\
&= \textstyle\sum_{k=0}^{K}\overline{\left(\frac{1}{k!}\right)}\,(S^k)^*
   \quad (\because \text{共役転置の線型性を和の各項へ適用、}\blkref{star_preserves_norm_and_limits}) \\
&= \textstyle\sum_{k=0}^{K}\frac{1}{k!}\,(S^k)^*
   \quad (\because 1/k! \in \mathbb{R} \text{ なので } \overline{1/k!} = 1/k!) \\
&= \textstyle\sum_{k=0}^{K}\frac{1}{k!}\,S^k
   \quad (\because \text{上で得た } (S^k)^* = S^k) \\
&= E_K
   \quad (\because E_K \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        ref("exp_converges"),
        " より ",
        math(String.raw`E_K \to \exp(S)`),
        " であり、",
        ref("star_preserves_norm_and_limits"),
        " (3) より ",
        math(String.raw`E_K^* \to \exp(S)^*`),
        "。上の等式 ",
        math(String.raw`E_K^* = E_K`),
        " より、同じ点列 ",
        math(String.raw`E_K`),
        " が ",
        math(String.raw`\exp(S)^*`),
        " と ",
        math(String.raw`\exp(S)`),
        " の両方へ収束するから、",
        ref("matrix_norm_triangle_inequality"),
        " (4)（極限の一意性）より ",
        math(String.raw`\exp(S)^* = \exp(S)`),
        "。",
      ]),
      paragraph([
        "次に正定値性。",
        math(String.raw`S/2`),
        " もエルミートなので、いま示したことから ",
        math(String.raw`\exp(S/2)^* = \exp(S/2)`),
        "。また ",
        math(String.raw`S/2`),
        " は自分自身と可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(S/2)\exp(S/2)
&= \exp(S/2 + S/2)
   \quad (\because \text{可換な行列の指数の積、}\blkref{theorem_exp_product}) \\
&= \exp(S)
   \quad (\because S/2 + S/2 = S)
\end{aligned}`,
      ),
      paragraph(["さらに、"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(S/2)\exp(-S/2)
&= \exp\bigl(S/2 + (-S/2)\bigr)
   \quad (\because \text{可換な行列の指数の積}) \\
&= \exp(0)
   \quad (\because S/2 + (-S/2) = 0) \\
&= I
   \quad (\because \text{零行列の指数、}\blkref{theorem_exp_zero})
\end{aligned}`,
      ),
      paragraph([
        "従って、",
        math(String.raw`\exp(S/2)`),
        " は可逆である。よって ",
        math(String.raw`x \in \mathbb{C}^n\setminus\{0\}`),
        " に対し ",
        math(String.raw`w := \exp(S/2)x \neq 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*\exp(S)x
&= x^*\bigl(\exp(S/2)\exp(S/2)\bigr)x
   \quad (\because \text{上で得た } \exp(S/2)\exp(S/2) = \exp(S)) \\
&= x^*\exp(S/2)^*\exp(S/2)x
   \quad (\because \text{上で示した } \exp(S/2)^* = \exp(S/2)) \\
&= \left(\exp(S/2)x\right)^*\left(\exp(S/2)x\right)
   \quad (\because \text{積の共役転置を } n \times 1 \text{ 行列 } x \text{ へ適用、}\blkref{star_preserves_norm_and_limits}) \\
&= w^* w
   \quad (\because w \text{ の定義}) \\
&= \textstyle\sum_{k=1}^{n}\overline{w_k}\,w_k
   \quad (\because \text{行列積の定義（} 1 \times 1 \text{ 成分）}) \\
&= \textstyle\sum_{k=1}^{n}|w_k|^2
   \quad (\because \overline{z}\,z = |z|^2) \\
&= \|w\|^2
   \quad (\because \text{ベクトルノルムの定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`w \neq 0`),
        " なのでどれかの ",
        math(String.raw`w_k \neq 0`),
        " であり、非負項の和が正の項を含むから ",
        math(String.raw`\|w\|^2 > 0`),
        "。よって ",
        math(String.raw`x^*\exp(S)x > 0`),
        " である。",
      ]),
      paragraph([
        "(2) 共役転置について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(B^*AB)^*
&= B^*A^*B^{**}
   \quad (\because \text{積の共役転置、}\blkref{star_preserves_norm_and_limits}) \\
&= B^*A^*B
   \quad (\because B^{**}=B) \\
&= B^*AB
   \quad (\because A^*=A)
\end{aligned}`,
      ),
      paragraph([
        "従って、エルミートである。",
        math(String.raw`x \neq 0`),
        " なら ",
        math(String.raw`B`),
        " が可逆なので ",
        math(String.raw`Bx \neq 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*(B^*AB)x
&= (Bx)^*A(Bx)
   \quad (\because \text{積の共役転置、}\blkref{star_preserves_norm_and_limits}) \\
&>0
   \quad (\because A\ \text{は正定値かつ}\ Bx\ne0)
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        math(String.raw`\alpha\in\mathbb{R}_{>0}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\alpha A)^*
&= \overline{\alpha}A^*
   \quad (\because \text{共役転置の線型性}) \\
&= \alpha A^*
   \quad (\because \alpha\in\mathbb{R}) \\
&= \alpha A
   \quad (\because A^*=A)
\end{aligned}`,
      ),
      paragraph(["よりエルミートである。また ", math(String.raw`x\ne0`), " ならば"]),
      displayMath(
        String.raw`\begin{aligned}
x^*(\alpha A)x
&= \alpha(x^*Ax)
   \quad (\because \text{スカラー倍と行列積の結合則}) \\
&>0
   \quad (\because \alpha>0\ \text{かつ}\ x^*Ax>0)
\end{aligned}`,
      ),
      paragraph([
        "(4) ",
        math(String.raw`e_k \in \mathbb{C}^n`),
        " を第 ",
        math(String.raw`k`),
        " 標準基底ベクトルとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A_{kk}
&= e_k^*Ae_k
   \quad (\because \text{標準基底ベクトルによる対角成分の表示}) \\
&>0
   \quad (\because A\ \text{は正定値かつ}\ e_k\ne0)
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(A)
&= \sum_{k=1}^{n}A_{kk}
   \quad (\because \text{トレースの定義}) \\
&>0
   \quad (\because n\ge1\ \text{かつ各}\ A_{kk}>0)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`A`),
        " はエルミートなので各 ",
        math(String.raw`A_{kk}`),
        " は実数であり、よって ",
        math(String.raw`\mathrm{tr}(A)\in\mathbb{R}_{>0}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の式変形統一で、共役転置・可換な行列指数の積・零行列の指数への後置き参照を、実際に適用する各等号の行末へ移した。内容・式変形・根拠・参照は変えていない。",
      ],
    },
  },
]);
