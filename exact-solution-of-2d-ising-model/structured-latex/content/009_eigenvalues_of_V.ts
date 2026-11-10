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
    id: "eigenvalues_of_V_claim_trace_of_sum_over_binary_words",
    kind: "claim",
    title: { tex: String.raw`\{0,1\}^{r}\ \text{の上の和のトレース}` },
    labels: ["trace_of_sum_over_binary_words"],
    statement: [
      paragraph([
        math(String.raw`n, r \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`B_\epsilon \in \mathrm{Mat}(n,\mathbb{C})`),
        " とする。トレースは ",
        ref("def_trace"),
        "、左辺の行列の和は ",
        ref("def_sum_over_binary_words"),
        "（",
        math(String.raw`m, n \to n`),
        "）、右辺の複素数の和は ",
        ref("def_sum_over_binary_words_of_complex_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\mathrm{tr}\Bigl(\sum_{\epsilon \in \{0,1\}^{r}} B_\epsilon\Bigr) = \sum_{\epsilon \in \{0,1\}^{r}} \mathrm{tr}\bigl(B_\epsilon\bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`A, B \in \mathrm{Mat}(n,\mathbb{C})`),
        " について次の鎖を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(A + B)
&= \mathrm{tr}\bigl(1_{\mathbb{C}}A + 1_{\mathbb{C}}B\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\ (m, n \to n)\ \text{を二つの項へ同時に右辺から左辺へ}\bigr)\\
&= 1_{\mathbb{C}}\,\mathrm{tr}(A) + 1_{\mathbb{C}}\,\mathrm{tr}(B)
&&\bigl(\because\ \blkref{trace_basic_properties}\ \text{(1)}\ (\alpha, \beta \to 1_{\mathbb{C}})\bigr)\\
&= \mathrm{tr}(A) + \mathrm{tr}(B)
&&\bigl(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field}\ \text{を二つの項へ同時に}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " についての帰納法で、",
        math(String.raw`\{0,1\}^{r}`),
        " で添字付けられた ",
        math(String.raw`\mathrm{Mat}(n,\mathbb{C})`),
        " の元の全ての族について示す。",
        math(String.raw`r = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}\Bigl(\sum_{\epsilon \in \{0,1\}^{1}} B_\epsilon\Bigr)
&= \mathrm{tr}\bigl(B_{(1)} + B_{(0)}\bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (m, n \to n)\bigr)\\
&= \mathrm{tr}\bigl(B_{(1)}\bigr) + \mathrm{tr}\bigl(B_{(0)}\bigr)
&&\bigl(\because\ \text{準備の鎖}\ (A \to B_{(1)},\ B \to B_{(0)})\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{1}} \mathrm{tr}\bigl(B_\epsilon\bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_complex_numbers}\ (z_\epsilon \to \mathrm{tr}(B_\epsilon))\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`r`),
        " で全ての族について成り立つと仮定する。",
        math(String.raw`\{0,1\}^{r+1}`),
        " で添字付けられた族 ",
        math(String.raw`B_\epsilon`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}\Bigl(\sum_{\epsilon \in \{0,1\}^{r+1}} B_\epsilon\Bigr)
&= \mathrm{tr}\Bigl(\sum_{\epsilon' \in \{0,1\}^{r}} \bigl(B_{(\epsilon',1)} + B_{(\epsilon',0)}\bigr)\Bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words}\ (m, n \to n)\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \mathrm{tr}\bigl(B_{(\epsilon',1)} + B_{(\epsilon',0)}\bigr)
&&\bigl(\because\ \text{帰納法の仮定}\ (B_{\epsilon'} \to B_{(\epsilon',1)} + B_{(\epsilon',0)})\bigr)\\
&= \sum_{\epsilon' \in \{0,1\}^{r}} \Bigl(\mathrm{tr}\bigl(B_{(\epsilon',1)}\bigr) + \mathrm{tr}\bigl(B_{(\epsilon',0)}\bigr)\Bigr)
&&\bigl(\because\ \text{準備の鎖}\ (A \to B_{(\epsilon',1)},\ B \to B_{(\epsilon',0)})\ \text{を各項へ同時に}\bigr)\\
&= \sum_{\epsilon \in \{0,1\}^{r+1}} \mathrm{tr}\bigl(B_\epsilon\bigr)
&&\bigl(\because\ \blkref{def_sum_over_binary_words_of_complex_numbers}\ (z_\epsilon \to \mathrm{tr}(B_\epsilon))\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 1 が tr(Σ_ε V̌'Q̌_ε) = Σ_ε tr(V̌'Q̌_ε) を「トレースの線型性」と名前だけで根拠にしていたので足した。trace_basic_properties (1) は二項の和についての主張なので、{0,1}^r の上の和へ帰納法で広げる。Lean は具体版 Ising2D.trace_binWordSum（ClaimTraceOfSumOverBinaryWords.lean）。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_trace_of_scalar_multiple",
    kind: "claim",
    title: { text: "行列のスカラー倍のトレース" },
    labels: ["trace_of_scalar_multiple"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`\alpha \in \mathbb{C}`),
        " とする。トレースは ",
        ref("def_trace"),
        "、行列のスカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        " による。このとき",
      ]),
      displayMath(String.raw`\mathrm{tr}(\alpha A) = \alpha\,\mathrm{tr}(A)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(\alpha A)
&= \mathrm{tr}(\alpha A + O)
&&\bigl(\because\ \blkref{matrix_plus_zero_matrix}\ (m, n \to n,\ X \to \alpha A)\ \text{を右辺から左辺へ}\bigr)\\
&= \mathrm{tr}(\alpha A + 0_{\mathbb{C}}A)
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\ (m, n \to n)\ \text{を右辺から左辺へ}\bigr)\\
&= \alpha\,\mathrm{tr}(A) + 0_{\mathbb{C}}\,\mathrm{tr}(A)
&&\bigl(\because\ \blkref{trace_basic_properties}\ \text{(1)}\ (\beta \to 0_{\mathbb{C}},\ B \to A)\bigr)\\
&= \alpha\,\mathrm{tr}(A) + 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_zero_times_is_zero}\ (z \to \mathrm{tr}(A))\bigr)\\
&= \alpha\,\mathrm{tr}(A)
&&\bigl(\because\ 0_{\mathbb{C}}\ \text{は加法の単位元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 1 が tr(exp(ǧ(ε))Q̌_ε) = exp(ǧ(ε))tr(Q̌_ε) を根拠なしに使っていたので足した。trace_basic_properties (1) の β = 0_ℂ の場合として示す。Lean は具体版 Ising2D.trace_of_scalar_multiple（ClaimTraceOfSumOverBinaryWords.lean）。",
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
    id: "eigenvalues_of_V_definition_conjugate_bilinear_value",
    kind: "definition",
    title: { tex: String.raw`\text{数ベクトルと行列から作る数 } x^*Ay` },
    labels: ["def_conjugate_bilinear_value"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`x = (x_1,\dots,x_n),\ y = (y_1,\dots,y_n) \in \mathbb{C}^n`),
        "、",
        math(String.raw`A = (A_{kl}) \in \mathrm{Mat}(n,\mathbb{C})`),
        " に対し、",
      ]),
      displayMath(String.raw`x^*Ay := \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,A_{kl}\,y_l \in \mathbb{C}`),
      paragraph([
        "と定める。",
        math(String.raw`\overline{\phantom{z}}`),
        " は ",
        ref("def_complex_conjugate"),
        " の複素共役、積と和は ",
        ref("definition_of_cc"),
        " の積と ",
        ref("def_finite_sum_of_complex_numbers"),
        " の有限和で、",
        math(String.raw`\overline{x_k}\,A_{kl}\,y_l := \bigl(\overline{x_k}\,A_{kl}\bigr)\,y_l`),
        " とする。",
        math(String.raw`x^*Ay`),
        " はこの式で定める一つの記号であり、数ベクトルの共役転置と行列の積を組み合わせたものとしては読まない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。def_hermitian_positive_definite は x^*Ax を「x を n×1 行列とみなし、1×1 行列を ℂ と同一視する」ことで定めていた。同一視をしない規律に合わせ、同じ値を成分の和で定める記号として切り出した。",
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
        math(String.raw`x \in \mathbb{C}^n`),
        " について ",
        math(String.raw`x^* A x \in \mathbb{C}`),
        " は ",
        ref("def_conjugate_bilinear_value"),
        " の ",
        math(String.raw`y = x`),
        " の値である。",
        math(String.raw`z \in \mathbb{C}`),
        " について「",
        math(String.raw`z \in \mathbb{R}_{>0}`),
        "」は、",
        math(String.raw`z = r_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        " の略記）を満たす ",
        math(String.raw`r \in \mathbb{R}_{>0}`),
        " が存在することの略記とする。",
        math(String.raw`\mathbb{C}^n`),
        " の ",
        math(String.raw`0`),
        " は ",
        ref("def_zero_matrix"),
        " の零ベクトルである。",
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
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 最後の段落「成分がすべて実数で A^⊤ = A な行列は \\overline{A_{lk}} = A_{lk} = A_{kl} よりエルミートである。以下ではこれを実対称と呼ぶ」は、定義の中で主張を述べていた（1 ブロック 1 主張）。呼び名を定義 def_real_symmetric_complex_matrix へ、エルミートであることを主張 real_symmetric_matrix_is_hermitian へ切り出し、この段落を外した。共役転置・エルミート・正定値の定義は変えていない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_conjugate_transpose_of_identity_matrix_of_order_two",
    kind: "claim",
    title: { text: "2 次の単位行列の共役転置" },
    labels: ["conjugate_transpose_of_identity_matrix_of_order_two"],
    statement: [
      paragraph([
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        " で ",
        math(String.raw`n = 2`),
        "）とする。共役転置は ",
        ref("def_hermitian_positive_definite"),
        " による。このとき",
      ]),
      displayMath(String.raw`I^* = I`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
I^*
&= \begin{pmatrix}\overline{I_{11}}&\overline{I_{21}}\\\overline{I_{12}}&\overline{I_{22}}\end{pmatrix}
&&(\because \blkref{def_hermitian_positive_definite} \text{ で } n=2) \\
&= \begin{pmatrix}\overline{\delta_{11}}&\overline{\delta_{21}}\\\overline{\delta_{12}}&\overline{\delta_{22}}\end{pmatrix}
&&(\because \blkref{def_identity_matrix} \text{ で } n=2) \\
&= \begin{pmatrix}\overline{1_{\mathbb{C}}}&\overline{0_{\mathbb{C}}}\\\overline{0_{\mathbb{C}}}&\overline{1_{\mathbb{C}}}\end{pmatrix}
&&(\because \blkref{def_kronecker_delta}) \\
&= \begin{pmatrix}1_{\mathbb{C}}&0_{\mathbb{C}}\\0_{\mathbb{C}}&1_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{complex_conjugate_of_real_inclusion} \text{ を } r = 1, 0 \text{ で 4 成分へ同時に}) \\
&= \begin{pmatrix}\delta_{11}&\delta_{12}\\\delta_{21}&\delta_{22}\end{pmatrix}
&&(\because \blkref{def_kronecker_delta}) \\
&= I
&&(\because \blkref{def_identity_matrix} \text{ で } n=2)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。check_number_operator_is_hermitian の (1) の証明が「def_identity_matrix の成分 δ_{kl} は実数で δ_{lk} = δ_{kl}」と文で述べていたので、transpose_of_identity_matrix_of_order_two と同じ成分の鎖で示す主張として足した。",
        "数値検証: sagemath/check/conjugate_transpose_of_identity_matrix_of_order_two/。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_conjugate_transpose_of_pauli_x",
    kind: "claim",
    title: { tex: String.raw`\sigma^x \text{ の共役転置}` },
    labels: ["conjugate_transpose_of_pauli_x"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
        ref("def_hermitian_positive_definite"),
        " の共役転置に関して",
      ]),
      displayMath(String.raw`(\sigma^x)^* = \sigma^x`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
(\sigma^x)^*
&= \begin{pmatrix}\overline{(\sigma^x)_{11}}&\overline{(\sigma^x)_{21}}\\\overline{(\sigma^x)_{12}}&\overline{(\sigma^x)_{22}}\end{pmatrix}
&&(\because \blkref{def_hermitian_positive_definite} \text{ で } n=2) \\
&= \begin{pmatrix}\overline{0_{\mathbb{C}}}&\overline{1_{\mathbb{C}}}\\\overline{1_{\mathbb{C}}}&\overline{0_{\mathbb{C}}}\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^x \text{ の成分}) \\
&= \begin{pmatrix}0_{\mathbb{C}}&1_{\mathbb{C}}\\1_{\mathbb{C}}&0_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{complex_conjugate_of_real_inclusion} \text{ を } r = 0, 1 \text{ で 4 成分へ同時に}) \\
&= \sigma^x
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^x)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。check_number_operator_is_hermitian の (1) の証明が「pauli_matrix_products の Pauli 行列の成分より (σ^x)^* = σ^x」と文で述べていたので、transpose_of_pauli_x と同じ成分の鎖で示す主張として足した。",
        "数値検証: sagemath/check/conjugate_transpose_of_pauli_x/。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_conjugate_transpose_of_pauli_z",
    kind: "claim",
    title: { tex: String.raw`\sigma^z \text{ の共役転置}` },
    labels: ["conjugate_transpose_of_pauli_z"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
        ref("def_hermitian_positive_definite"),
        " の共役転置に関して",
      ]),
      displayMath(String.raw`(\sigma^z)^* = \sigma^z`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\sigma^z`),
        " の成分 ",
        math(String.raw`-1`),
        " は ",
        math(String.raw`(-1)_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        " の略記で ",
        math(String.raw`r = -1`),
        "）である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
(\sigma^z)^*
&= \begin{pmatrix}\overline{(\sigma^z)_{11}}&\overline{(\sigma^z)_{21}}\\\overline{(\sigma^z)_{12}}&\overline{(\sigma^z)_{22}}\end{pmatrix}
&&(\because \blkref{def_hermitian_positive_definite} \text{ で } n=2) \\
&= \begin{pmatrix}\overline{1_{\mathbb{C}}}&\overline{0_{\mathbb{C}}}\\\overline{0_{\mathbb{C}}}&\overline{(-1)_{\mathbb{C}}}\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^z \text{ の成分}) \\
&= \begin{pmatrix}1_{\mathbb{C}}&0_{\mathbb{C}}\\0_{\mathbb{C}}&(-1)_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{complex_conjugate_of_real_inclusion} \text{ を } r = 1, 0, -1 \text{ で 4 成分へ同時に}) \\
&= \sigma^z
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^z)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。check_number_operator_is_hermitian の (1) の証明が「pauli_matrix_products の Pauli 行列の成分より (σ^z)^* = σ^z」と文で述べていたので、transpose_of_pauli_z と同じ成分の鎖で示す主張として足した。",
        "数値検証: sagemath/check/conjugate_transpose_of_pauli_z/。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_conjugate_transpose_of_pauli_y",
    kind: "claim",
    title: { tex: String.raw`\sigma^y \text{ の共役転置}` },
    labels: ["conjugate_transpose_of_pauli_y"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^y \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
        ref("def_hermitian_positive_definite"),
        " の共役転置に関して",
      ]),
      displayMath(String.raw`(\sigma^y)^* = \sigma^y`),
      paragraph([
        "が成り立つ。",
        math(String.raw`i`),
        " は ",
        ref("antiperiodic_exp_sum"),
        " の前置きの ",
        math(String.raw`i := (0,1)`),
        "、",
        math(String.raw`-i`),
        " は ",
        ref("multiply_by_minus_one"),
        " の記号である。",
      ]),
    ],
    proof: [
      paragraph(["準備として ", math(String.raw`\bar i`), " と ", math(String.raw`\overline{-i}`), " を求める。"]),
      displayMath(String.raw`\begin{aligned}
\bar i
&= \overline{(0,1)}
&&(\because\ \blkref{antiperiodic_exp_sum}\ \text{の前置きの}\ i := (0,1))\\
&= (0,-1)
&&(\because\ \blkref{def_complex_conjugate})\\
&= (-1,0)(0,1)
&&(\because\ \blkref{definition_of_cc}\ \text{の積}\ ((-1)\cdot 0 - 0\cdot 1,\ (-1)\cdot 1 + 0\cdot 0))\\
&= (-1_{\mathbb{C}})(0,1)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (-1)_{\mathbb{C}} = (-1,0))\\
&= (-1_{\mathbb{C}})\,i
&&(\because\ \blkref{antiperiodic_exp_sum}\ \text{の前置きの}\ i := (0,1))\\
&= -i
&&(\because\ \blkref{multiply_by_minus_one})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\overline{-i}
&= \overline{(-1_{\mathbb{C}})\,i}
&&(\because\ \blkref{multiply_by_minus_one})\\
&= \overline{(-1_{\mathbb{C}})(0,1)}
&&(\because\ \blkref{antiperiodic_exp_sum}\ \text{の前置きの}\ i := (0,1))\\
&= \overline{(-1,0)(0,1)}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (-1)_{\mathbb{C}} = (-1,0))\\
&= \overline{(0,-1)}
&&(\because\ \blkref{definition_of_cc}\ \text{の積}\ ((-1)\cdot 0 - 0\cdot 1,\ (-1)\cdot 1 + 0\cdot 0))\\
&= (0,-(-1))
&&(\because\ \blkref{def_complex_conjugate})\\
&= (0,1)
&&(\because\ \mathbb{R}\ \text{で}\ -(-1) = 1)\\
&= i
&&(\because\ \blkref{antiperiodic_exp_sum}\ \text{の前置きの}\ i := (0,1))
\end{aligned}`),
      displayMath(
        String.raw`\begin{aligned}
(\sigma^y)^*
&= \begin{pmatrix}\overline{(\sigma^y)_{11}}&\overline{(\sigma^y)_{21}}\\\overline{(\sigma^y)_{12}}&\overline{(\sigma^y)_{22}}\end{pmatrix}
&&(\because \blkref{def_hermitian_positive_definite} \text{ で } n=2) \\
&= \begin{pmatrix}\overline{0_{\mathbb{C}}}&\bar i\\\overline{-i}&\overline{0_{\mathbb{C}}}\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^y \text{ の成分}) \\
&= \begin{pmatrix}0_{\mathbb{C}}&\bar i\\\overline{-i}&0_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{complex_conjugate_of_real_inclusion} \text{ を } r = 0 \text{ で 2 成分へ同時に}) \\
&= \begin{pmatrix}0_{\mathbb{C}}&-i\\\overline{-i}&0_{\mathbb{C}}\end{pmatrix}
&&(\because \text{準備の } \bar i = -i) \\
&= \begin{pmatrix}0_{\mathbb{C}}&-i\\i&0_{\mathbb{C}}\end{pmatrix}
&&(\because \text{準備の } \overline{-i} = i) \\
&= \sigma^y
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^y)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。check_number_operator_is_hermitian の (1) の証明が「σ^y は転置で (1,2) 成分 -i と (2,1) 成分 i が入れ替わり、複素共役でさらに符号が戻る」と文で述べていたので、transpose_of_pauli_y と同じ成分の鎖で示す主張として足した。準備の \\bar i = -i の 6 行は relation_of_gamma_2_theta_tilde の「第二に」の鎖と同じである。",
        "数値検証: sagemath/check/conjugate_transpose_of_pauli_y/。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_definition_real_symmetric_complex_matrix",
    kind: "definition",
    title: { text: "実対称な複素行列" },
    labels: ["def_real_symmetric_complex_matrix"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。",
        math(String.raw`A`),
        " の成分がすべて実数であり（",
        ref("def_matrix_with_real_entries"),
        "）、かつ ",
        math(String.raw`A^{\top} = A`),
        "（転置は ",
        ref("def_matrix_transpose"),
        "）であるとき、",
        math(String.raw`A`),
        " は**実対称**であるという。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_hermitian_positive_definite の最後の段落が「以下ではこれを実対称と呼ぶ」と呼び名を定め、同じ段落でエルミートであることを主張していたので、呼び名をこのブロックへ切り出した。def_real_symmetric_matrix（011_max_eigenvalue.ts）は Mat(n,ℝ) の元が対称であること（P_{kl} = P_{lk}）を定め、こちらは Mat(n,ℂ) の元について成分が inclusion_rr_to_cc の像に入ることと転置で不変なことを定める。台集合が違う別の定義であり、互いに引かない。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_real_symmetric_matrix_is_hermitian",
    kind: "claim",
    title: { text: "実対称な複素行列はエルミート" },
    labels: ["real_symmetric_matrix_is_hermitian"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " が実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）ならば、",
        math(String.raw`A^* = A`),
        "、すなわち ",
        math(String.raw`A`),
        " は ",
        ref("def_hermitian_positive_definite"),
        " の意味でエルミートである。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathrm{Mat}(n,\mathbb{C})`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " を取る。",
        math(String.raw`A`),
        " の成分はすべて実数なので（",
        ref("def_real_symmetric_complex_matrix"),
        "）、",
        ref("def_matrix_with_real_entries"),
        "（",
        math(String.raw`m, n \to n,\ B \to A,\ p \to l,\ q \to k`),
        "）により ",
        math(String.raw`A_{lk} = r_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r \in \mathbb{R}`),
        " を取れる（",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(A^*\right)_{kl}
&= \overline{A_{lk}}
&&\bigl(\because\ \blkref{def_hermitian_positive_definite}\ \text{の共役転置}\bigr)\\
&= \overline{r_{\mathbb{C}}}
&&\bigl(\because\ r\ \text{の取り方}\ A_{lk} = r_{\mathbb{C}}\bigr)\\
&= r_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_conjugate_of_real_inclusion}\bigr)\\
&= A_{lk}
&&\bigl(\because\ r\ \text{の取り方}\ A_{lk} = r_{\mathbb{C}}\bigr)\\
&= \left(A^{\top}\right)_{kl}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (m, n \to n,\ B \to A,\ p \to k,\ q \to l)\bigr)\\
&= A_{kl}
&&\bigl(\because\ A^{\top} = A\text{。}\blkref{def_real_symmetric_complex_matrix}\bigr)
\end{aligned}`),
      paragraph([
        "よって全ての成分が一致し、",
        math(String.raw`A^* = A`),
        " を得る。これは ",
        ref("def_hermitian_positive_definite"),
        " のエルミートの条件そのものである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_hermitian_positive_definite の最後の段落が定義の中で「\\overline{A_{lk}} = A_{lk} = A_{kl} よりエルミートである」と主張し、iH_is_real_symmetric の Step 3・V_plus_is_positive_definite の Step 2・W_is_real_symmetric_positive_definite の Step 2 がそれを「最後の注意」として引いていたので、主張のブロックに切り出した。段落の 2 つの等号（成分が実数なので共役で変わらない、転置で不変）を、共役転置の定義・r の取り方・complex_conjugate_of_real_inclusion・def_matrix_transpose・A^⊤ = A の 1 行 1 根拠に割った。",
      ],
    },
  },
  {
    id: "eigenvalues_of_V_claim_hermitian_and_transpose_invariant_matrix_is_real_symmetric",
    kind: "claim",
    title: { text: "エルミートかつ転置で不変な複素行列は実対称" },
    labels: ["hermitian_and_transpose_invariant_matrix_is_real_symmetric"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）が ",
        math(String.raw`A^* = A`),
        "（共役転置は ",
        ref("def_hermitian_positive_definite"),
        "）と ",
        math(String.raw`A^{\top} = A`),
        "（転置は ",
        ref("def_matrix_transpose"),
        "）を満たすならば、",
        math(String.raw`A`),
        " は実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A^{\top} = A`),
        " は仮定にあるので、",
        math(String.raw`A`),
        " の成分がすべて実数であること（",
        ref("def_matrix_with_real_entries"),
        "）を示せばよい。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " を取る。",
        ref("definition_of_cc"),
        " より ",
        math(String.raw`A_{kl} = (a, b)`),
        " を満たす ",
        math(String.raw`a, b \in \mathbb{R}`),
        " を取れる。",
      ]),
      displayMath(String.raw`\begin{aligned}
(a, -b)
&= \overline{(a, b)}
&&\bigl(\because\ \blkref{def_complex_conjugate}\ (x \to a,\ y \to b)\bigr)\\
&= \overline{A_{kl}}
&&\bigl(\because\ a, b\ \text{の取り方}\ A_{kl} = (a, b)\bigr)\\
&= \left(A^*\right)_{lk}
&&\bigl(\because\ \blkref{def_hermitian_positive_definite}\ \text{の共役転置}\ (k \to l,\ l \to k)\bigr)\\
&= A_{lk}
&&\bigl(\because\ A^* = A\bigr)\\
&= \left(A^{\top}\right)_{kl}
&&\bigl(\because\ \blkref{def_matrix_transpose}\ (m, n \to n,\ B \to A,\ p \to k,\ q \to l)\bigr)\\
&= A_{kl}
&&\bigl(\because\ A^{\top} = A\bigr)\\
&= (a, b)
&&\bigl(\because\ a, b\ \text{の取り方}\ A_{kl} = (a, b)\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\mathbf{C} = \mathbf{R}^2`),
        "（",
        ref("definition_of_cc"),
        "）の二つの元が等しいことは第 1 成分どうし・第 2 成分どうしが等しいことなので、第 2 成分から ",
        math(String.raw`-b = b`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
b
&= \tfrac12\,(b + b)
&&\bigl(\because\ \mathbb{R}\ \text{の四則}\bigr)\\
&= \tfrac12\,\bigl((-b) + b\bigr)
&&\bigl(\because\ -b = b\bigr)\\
&= \tfrac12 \cdot 0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (-b) + b = 0\bigr)\\
&= 0
&&\bigl(\because\ \mathbb{R}\ \text{の四則}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
A_{kl}
&= (a, b)
&&\bigl(\because\ a, b\ \text{の取り方}\bigr)\\
&= (a, 0)
&&\bigl(\because\ b = 0\bigr)\\
&= a_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)
\end{aligned}`),
      paragraph([
        "よって ",
        ref("def_matrix_with_real_entries"),
        "（",
        math(String.raw`m, n \to n,\ B \to A,\ p \to k,\ q \to l,\ r \to a`),
        "）の条件が全ての ",
        math(String.raw`k, l`),
        " で成り立ち、",
        math(String.raw`A`),
        " の成分はすべて実数である。",
        math(String.raw`A^{\top} = A`),
        " と合わせて、",
        ref("def_real_symmetric_complex_matrix"),
        " の条件そのものである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。W_is_real_symmetric_positive_definite の Step 2 が「実対称行列の冪は実対称で、def_exp の級数の部分和は実対称、star_preserves_norm_and_limits (3) と同じ議論（転置もノルムを保つ）から極限も実対称」と名前だけで述べていた。そのうちエルミート性は exp_of_hermitian_is_hermitian、転置で不変であることは exp_of_symmetric_is_symmetric が運ぶので、二つから成分が実数であることへ戻す段を real_symmetric_matrix_is_hermitian の逆向きの主張として足した。",
      ],
    },
  },
  {
    id: "eigenvalues_of_V_claim_power_of_real_symmetric_complex_matrix_is_real_symmetric",
    kind: "claim",
    title: { text: "実対称な複素行列の冪は実対称" },
    labels: ["power_of_real_symmetric_complex_matrix_is_real_symmetric"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " を実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）とする。このとき、すべての ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`A^p`),
        "（",
        ref("def_exp"),
        " (1) の冪）は実対称である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`A^1 = A`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
A^1
&= A^{0+1}
&&(\because \mathbb{Z}\ \text{で}\ 1 = 0 + 1) \\
&= A^0A
&&(\because \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA\ \text{を}\ m = 0\ \text{に適用}) \\
&= I_{\mathrm{Mat}(n,\mathbb{C})}\,A
&&(\because \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I) \\
&= A
&&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`),
      paragraph([
        math(String.raw`p`),
        " についての帰納法で示す。",
        math(String.raw`p = 0`),
        " のとき、",
        math(String.raw`A^0 = I_{\mathrm{Mat}(n,\mathbb{C})}`),
        "（",
        ref("def_exp"),
        " (1)）である。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(I_{\mathrm{Mat}(n,\mathbb{C})}\bigr)_{kl}
&= \delta_{kl}
&&(\because \blkref{def_identity_matrix}) \\
&= \begin{cases} 1_{\mathbb{C}} & (k = l) \\ 0_{\mathbb{C}} & (k \neq l) \end{cases}
&&(\because \blkref{def_kronecker_delta}) \\
&= \begin{cases} \iota_{\mathbb{R}\to\mathbb{C}}(1) & (k = l) \\ \iota_{\mathbb{R}\to\mathbb{C}}(0) & (k \neq l) \end{cases}
&&(\because \blkref{def_kronecker_delta}\ \text{の略記}\ 1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(1),\ 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0))
\end{aligned}`),
      paragraph([
        "なので、",
        math(String.raw`I_{\mathrm{Mat}(n,\mathbb{C})}`),
        " の成分はすべて実数である（",
        ref("def_matrix_with_real_entries"),
        "）。また",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(I_{\mathrm{Mat}(n,\mathbb{C})}^{\top}\bigr)_{kl}
&= \bigl(I_{\mathrm{Mat}(n,\mathbb{C})}\bigr)_{lk}
&&(\because \blkref{def_matrix_transpose}) \\
&= \delta_{lk}
&&(\because \blkref{def_identity_matrix}) \\
&= \delta_{kl}
&&(\because \blkref{def_kronecker_delta}\ \text{の場合分けは}\ k = l\ \text{と}\ l = k\ \text{で同じ}) \\
&= \bigl(I_{\mathrm{Mat}(n,\mathbb{C})}\bigr)_{kl}
&&(\because \blkref{def_identity_matrix})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`k, l`),
        " は任意なので ",
        math(String.raw`I_{\mathrm{Mat}(n,\mathbb{C})}^{\top} = I_{\mathrm{Mat}(n,\mathbb{C})}`),
        " である。よって ",
        math(String.raw`A^0`),
        " は実対称である。",
      ]),
      paragraph([
        math(String.raw`A^p`),
        " が実対称であるとする。",
        math(String.raw`A^{p+1} = A^pA`),
        "（",
        ref("def_exp"),
        " (1)）であり、",
        math(String.raw`A^p`),
        " と ",
        math(String.raw`A`),
        " の成分はすべて実数なので、",
        ref("product_of_real_entry_matrices_has_real_entries"),
        "（行列の大きさはすべて ",
        math(String.raw`n`),
        "、",
        math(String.raw`A \to A^p`),
        "、",
        math(String.raw`B \to A`),
        "）より ",
        math(String.raw`A^{p+1}`),
        " の成分はすべて実数である。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((A^{p+1})^{\top}\bigr)_{kl}
&= (A^{p+1})_{lk}
&&(\because \blkref{def_matrix_transpose}) \\
&= (A^pA)_{lk}
&&(\because \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA\ \text{を}\ m = p\ \text{に適用}) \\
&= \sum_{j=1}^{n} (A^p)_{lj}\,A_{jk}
&&(\because \blkref{mat_mult}) \\
&= \sum_{j=1}^{n} \bigl((A^p)^{\top}\bigr)_{jl}\,\bigl(A^{\top}\bigr)_{kj}
&&(\because \blkref{def_matrix_transpose}\ \text{を 2 箇所へ同時に適用}) \\
&= \sum_{j=1}^{n} (A^p)_{jl}\,\bigl(A^{\top}\bigr)_{kj}
&&(\because \text{帰納法の仮定の}\ (A^p)^{\top} = A^p) \\
&= \sum_{j=1}^{n} (A^p)_{jl}\,A_{kj}
&&(\because \text{仮定の}\ A^{\top} = A) \\
&= \sum_{j=1}^{n} A_{kj}\,(A^p)_{jl}
&&(\because \blkref{complex_numbers_form_a_field}\ \text{の乗法の可換則}) \\
&= (AA^p)_{kl}
&&(\because \blkref{mat_mult}) \\
&= (A^1A^p)_{kl}
&&(\because \text{準備の}\ A^1 = A) \\
&= (A^{1+p})_{kl}
&&(\because \blkref{matrix_power_exponent_law}\ (p \to 1,\ q \to p)) \\
&= (A^{p+1})_{kl}
&&(\because \mathbb{Z}\ \text{の加法の可換則})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`k, l`),
        " は任意なので ",
        math(String.raw`(A^{p+1})^{\top} = A^{p+1}`),
        " である。よって ",
        math(String.raw`A^{p+1}`),
        " は実対称である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。trace_power_upper_bound の証明が「W は実対称なので、その冪 W^n も実対称である」と根拠なしに述べていたので足した。def_exp (1) の冪は A^{m+1} := A^mA なので、転置を取ると AA^p が現れ、A^{1+p} = A^1A^p（matrix_power_exponent_law）で戻す。数値検証: sagemath/check/power_of_real_symmetric_complex_matrix_is_real_symmetric/。",
      ],
    },
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
    id: "eigenvalues_of_V_claim_transpose_preserves_matrix_norm",
    kind: "claim",
    title: { tex: String.raw`\|A^{\top}\| = \|A\|` },
    labels: ["transpose_preserves_matrix_norm"],
    statement: [
      paragraph(["転置は ", ref("def_matrix_transpose"), "、ノルムは ", ref("def_matrix_norm"), "（", math(String.raw`K = \mathbb{C}`), "）のものとする。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の記号）とする。このとき",
      ]),
      displayMath(String.raw`\|A^{\top}\| = \|A\|`),
      paragraph([
        "が成り立つ。両辺は ",
        ref("def_matrix_norm"),
        " のとおり非負実数の有限和の非負の平方根であり、平方根を取るところで ",
        math(String.raw`\mathbb{R}`),
        " を使う。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\|A^{\top}\|
&= \sqrt{\textstyle\sum_{k=1}^{n}\sum_{l=1}^{n}|(A^{\top})_{kl}|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \blkref{def_matrix_norm}\ (A \to A^{\top}))\\
&= \sqrt{\textstyle\sum_{k=1}^{n}\sum_{l=1}^{n}|A_{lk}|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \blkref{def_matrix_transpose}\ (m, n \to n,\ B \to A,\ p \to k,\ q \to l)\ \text{を各項へ})\\
&= \sqrt{\textstyle\sum_{l=1}^{n}\sum_{k=1}^{n}|A_{lk}|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{の有限和の順序の入れ替え})\\
&= \|A\|
&&(\because\ \blkref{def_matrix_norm}\ \text{の}\ i = l,\ j = k)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。W_is_real_symmetric_positive_definite の Step 2 が、指数関数の極限が実対称であることを「star_preserves_norm_and_limits (3) と同じ議論（転置もノルムを保つ）」と名前だけで述べていたので、その議論の転置の側を主張に切り出した。鎖は star_preserves_norm_and_limits (2) と同じ並びで、共役転置の 2 行（定義と abs_of_complex_conjugate）が転置の定義の 1 行になる。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_transpose_preserves_matrix_limits",
    kind: "claim",
    title: { text: "収束する行列の列の転置は極限の転置へ収束する" },
    labels: ["transpose_preserves_matrix_limits"],
    statement: [
      paragraph(["転置は ", ref("def_matrix_transpose"), "、差は ", ref("def_matrix_difference"), "、ノルムと行列の列の収束は ", ref("def_matrix_norm"), "（", math(String.raw`K = \mathbb{C}`), "）のものとする。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`(A_N)_{N\in\mathbb Z_{\ge0}}`),
        " を ",
        math(String.raw`\mathrm{Mat}(n,\mathbb{C})`),
        " の列とする。このとき",
      ]),
      displayMath(String.raw`A_N \to A \ \Longrightarrow\ A_N^{\top} \to A^{\top}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`N \to \infty`),
        " の極限は ",
        math(String.raw`\mathbb{R}`),
        " の数列 ",
        math(String.raw`\|A_N - A\|`),
        " の極限であり、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出する。",
      ]),
    ],
    proof: [
      paragraph([
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
\|A_N^{\top}-A^{\top}\|
&= \|(A_N-A)^{\top}\|
&&(\because\ \blkref{transpose_of_matrix_difference}\ (m, p \to n,\ A \to A_N,\ B \to A\ \text{を同時に置き換える}))\\
&= \|A_N-A\|
&&(\because\ \blkref{transpose_preserves_matrix_norm}\ (A \to A_N - A))
\end{aligned}`,
      ),
      paragraph([
        "なので、",
        math(String.raw`\mathbb{R}`),
        " の数列 ",
        math(String.raw`(\|A_N^{\top}-A^{\top}\|)_{N}`),
        " と ",
        math(String.raw`(\|A_N-A\|)_{N}`),
        " はすべての項が等しく、仮定より ",
        math(String.raw`\|A_N^{\top}-A^{\top}\| \to 0`),
        " である。",
        ref("def_matrix_norm"),
        " の収束の定義より ",
        math(String.raw`A_N^{\top} \to A^{\top}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。W_is_real_symmetric_positive_definite の Step 2 が「star_preserves_norm_and_limits (3) と同じ議論（転置もノルムを保つ）から極限も実対称」と名前だけで述べていたので、転置の側を主張に切り出した。star_preserves_norm_and_limits (3) では準備の成分の鎖で示した差の等式を、ここでは既存の transpose_of_matrix_difference から引く。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_real_multiple_of_hermitian_is_hermitian",
    kind: "claim",
    title: { text: "エルミート行列の実数倍はエルミート" },
    labels: ["real_multiple_of_hermitian_is_hermitian"],
    statement: [
      paragraph(["共役転置とエルミート性は ", ref("def_hermitian_positive_definite"), "、スカラー倍は ", ref("def_matrix_scalar_multiple"), "、", math(String.raw`\alpha_{\mathbb{C}}`), " は ", ref("inclusion_rr_to_cc"), " の略記による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`\alpha \in \mathbb{R}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`A^* = A`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`(\alpha_{\mathbb{C}}A)^* = \alpha_{\mathbb{C}}A`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([math(String.raw`k, l \in \{1,\dots,n\}`), " について"]),
      displayMath(String.raw`\begin{aligned}
((\alpha_{\mathbb{C}}A)^*)_{kl}
&= \overline{(\alpha_{\mathbb{C}}A)_{lk}}
&&(\because\ \blkref{def_hermitian_positive_definite})\\
&= \overline{\alpha_{\mathbb{C}}A_{lk}}
&&(\because\ \blkref{def_matrix_scalar_multiple})\\
&= \overline{\alpha_{\mathbb{C}}}\;\overline{A_{lk}}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= \alpha_{\mathbb{C}}\,\overline{A_{lk}}
&&(\because\ \blkref{complex_conjugate_of_real_inclusion})\\
&= \alpha_{\mathbb{C}}\,(A^*)_{kl}
&&(\because\ \blkref{def_hermitian_positive_definite})\\
&= \alpha_{\mathbb{C}}\,A_{kl}
&&(\because\ A^* = A)\\
&= (\alpha_{\mathbb{C}}A)_{kl}
&&(\because\ \blkref{def_matrix_scalar_multiple})
\end{aligned}`),
      paragraph(["すべての成分が等しいので ", math(String.raw`(\alpha_{\mathbb{C}}A)^* = \alpha_{\mathbb{C}}A`), " である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。exp_hermitian_is_positive_definite の (1) の証明の「S/2 もエルミート」と (3) のエルミート性の鎖を、正定値性の主張を分けるときに独立の主張にした。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_conjugate_bilinear_value_of_congruence",
    kind: "claim",
    title: { tex: String.raw`x^*(B^*(AB))y = (Bx)^*A(By)` },
    labels: ["conjugate_bilinear_value_of_congruence"],
    statement: [
      paragraph(["記号 ", math(String.raw`x^*Ay`), " は ", ref("def_conjugate_bilinear_value"), "、共役転置は ", ref("def_hermitian_positive_definite"), "、行列の積と行列と数ベクトルの積は ", ref("mat_mult"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`x, y \in \mathbb{C}^n`),
        " について",
      ]),
      displayMath(String.raw`x^*\bigl(B^*(AB)\bigr)y = (Bx)^*A(By)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "5 つの複素数の積は左から順に掛けたものとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
x^*\bigl(B^*(AB)\bigr)y
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,\bigl(B^*(AB)\bigr)_{kl}\,y_l
&&(\because\ \blkref{def_conjugate_bilinear_value})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,\Bigl(\sum_{j=1}^{n} (B^*)_{kj}\,(AB)_{jl}\Bigr)\,y_l
&&(\because\ \blkref{mat_mult})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,\Bigl(\sum_{j=1}^{n} \overline{B_{jk}}\,(AB)_{jl}\Bigr)\,y_l
&&(\because\ \blkref{def_hermitian_positive_definite}\ \text{を各項へ})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,\Bigl(\sum_{j=1}^{n} \overline{B_{jk}}\,\Bigl(\sum_{m=1}^{n} A_{jm}B_{ml}\Bigr)\Bigr)\,y_l
&&(\because\ \blkref{mat_mult}\ \text{を各項へ})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\sum_{j=1}^{n}\sum_{m=1}^{n} \Bigl(\overline{x_k}\,\Bigl(\overline{B_{jk}}\,\bigl(A_{jm}B_{ml}\bigr)\Bigr)\Bigr)\,y_l
&&(\because\ \text{分配律を項の数だけ繰り返す。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\sum_{j=1}^{n}\sum_{m=1}^{n} \overline{x_k}\,\overline{B_{jk}}\,A_{jm}\,B_{ml}\,y_l
&&(\because\ \text{積の結合律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{j=1}^{n}\sum_{m=1}^{n}\sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,\overline{B_{jk}}\,A_{jm}\,B_{ml}\,y_l
&&(\because\ \text{加法の結合律・交換律による有限和の順序の入れ替え。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{j=1}^{n}\sum_{m=1}^{n}\sum_{k=1}^{n}\sum_{l=1}^{n} \overline{B_{jk}}\,\overline{x_k}\,A_{jm}\,B_{ml}\,y_l
&&(\because\ \text{積の可換律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{j=1}^{n}\sum_{m=1}^{n}\sum_{k=1}^{n}\sum_{l=1}^{n} \Bigl(\bigl(\overline{B_{jk}}\,\overline{x_k}\bigr)A_{jm}\Bigr)\bigl(B_{ml}\,y_l\bigr)
&&(\because\ \text{積の結合律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{j=1}^{n}\sum_{m=1}^{n} \Bigl(\sum_{k=1}^{n}\overline{B_{jk}}\,\overline{x_k}\Bigr)\,A_{jm}\,\Bigl(\sum_{l=1}^{n}B_{ml}\,y_l\Bigr)
&&(\because\ \text{分配律を項の数だけ繰り返す。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{j=1}^{n}\sum_{m=1}^{n} \Bigl(\sum_{k=1}^{n}\overline{B_{jk}\,x_k}\Bigr)\,A_{jm}\,\Bigl(\sum_{l=1}^{n}B_{ml}\,y_l\Bigr)
&&(\because\ \blkref{complex_conjugate_of_product}\ \text{を各項へ})\\
&= \sum_{j=1}^{n}\sum_{m=1}^{n} \overline{\sum_{k=1}^{n}B_{jk}\,x_k}\,A_{jm}\,\Bigl(\sum_{l=1}^{n}B_{ml}\,y_l\Bigr)
&&(\because\ \blkref{complex_conjugate_of_sum}\ \text{の}\ m = n)\\
&= \sum_{j=1}^{n}\sum_{m=1}^{n} \overline{(Bx)_j}\,A_{jm}\,(By)_m
&&(\because\ \blkref{mat_mult})\\
&= (Bx)^*A(By)
&&(\because\ \blkref{def_conjugate_bilinear_value})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。exp_hermitian_is_positive_definite の (1)(2) の証明は x^*(B^*AB)x = (Bx)^*A(Bx) を「積の共役転置を n×1 行列 x へ適用」で得ていた。共役転置は正方行列についてだけ定義されているので、def_conjugate_bilinear_value の成分の和から示す独立の主張にした。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_congruence_preserves_positive_definite",
    kind: "claim",
    title: { tex: String.raw`\text{左逆行列をもつ } B \text{ による } B^*(AB) \text{ は正定値}` },
    labels: ["congruence_preserves_positive_definite"],
    statement: [
      paragraph(["共役転置・エルミート性・正定値性は ", ref("def_hermitian_positive_definite"), "、行列の積は ", ref("mat_mult"), "、単位行列 ", math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`), " は ", ref("def_identity_matrix"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B, B' \in \mathrm{Mat}(n,\mathbb{C})`),
        " とし、",
        math(String.raw`A`),
        " は正定値、",
        math(String.raw`B'B = I`),
        " とする。このとき ",
        math(String.raw`B^*(AB)`),
        " は正定値である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`B_{kl} = (a,b)`),
        "（",
        math(String.raw`a, b \in \mathbb{R}`),
        "）と書くと",
      ]),
      displayMath(String.raw`\begin{aligned}
((B^*)^*)_{kl}
&= \overline{(B^*)_{lk}}
&&(\because\ \blkref{def_hermitian_positive_definite})\\
&= \overline{\overline{B_{kl}}}
&&(\because\ \blkref{def_hermitian_positive_definite})\\
&= \overline{(a,-b)}
&&(\because\ \blkref{def_complex_conjugate})\\
&= (a,-(-b))
&&(\because\ \blkref{def_complex_conjugate})\\
&= (a,b)
&&(\because\ \mathbb{R}\ \text{で}\ -(-b) = b)\\
&= B_{kl}
&&(\because\ B_{kl} = (a,b)\ \text{の置き方})
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`(B^*)^* = B`),
        " である。また ",
        math(String.raw`k \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(B'0)_k
&= \sum_{j=1}^{n} B'_{kj}\,0_j
&&(\because\ \blkref{mat_mult})\\
&= \sum_{j=1}^{n} B'_{kj}\,0_{\mathbb{C}}
&&(\because\ \blkref{def_zero_matrix}\ \text{を各項へ})\\
&= \sum_{j=1}^{n} 0_{\mathbb{C}}
&&(\because\ \blkref{complex_times_zero_is_zero}\ \text{を各項へ})\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{finite_sum_of_complex_zeros})\\
&= 0_k
&&(\because\ \blkref{def_zero_matrix})
\end{aligned}`),
      paragraph(["なので ", math(String.raw`B'0 = 0`), " である。"]),
      paragraph(["エルミート性。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(B^*(AB)\bigr)^*
&= (AB)^*\,(B^*)^*
&&(\because\ \blkref{star_preserves_norm_and_limits}\ (1)\ \text{の第 1 式})\\
&= (B^*A^*)\,(B^*)^*
&&(\because\ \blkref{star_preserves_norm_and_limits}\ (1)\ \text{の第 1 式})\\
&= (B^*A)\,(B^*)^*
&&(\because\ A\ \text{は正定値なのでエルミート、}A^* = A)\\
&= (B^*A)\,B
&&(\because\ \text{準備の}\ (B^*)^* = B)\\
&= B^*(AB)
&&(\because\ \blkref{mat_mult_associative})
\end{aligned}`),
      paragraph([
        "正値性。",
        math(String.raw`x \in \mathbb{C}^n \setminus \{0\}`),
        " とする。",
        math(String.raw`Bx = 0`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
x
&= Ix
&&(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult})\\
&= (B'B)\,x
&&(\because\ B'B = I)\\
&= B'(Bx)
&&(\because\ \blkref{mat_mult_associative})\\
&= B'0
&&(\because\ Bx = 0\ \text{の仮定})\\
&= 0
&&(\because\ \text{準備の}\ B'0 = 0)
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`x \ne 0`),
        " に反する。よって ",
        math(String.raw`Bx \ne 0`),
        " であり、",
        math(String.raw`A`),
        " が正定値なので ",
        math(String.raw`(Bx)^*A(Bx) = r_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r \in \mathbb{R}_{>0}`),
        " がある（",
        ref("def_hermitian_positive_definite"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
x^*\bigl(B^*(AB)\bigr)x
&= (Bx)^*A(Bx)
&&(\because\ \blkref{conjugate_bilinear_value_of_congruence}\ \text{の}\ y = x)\\
&= r_{\mathbb{C}}
&&(\because\ r\ \text{の取り方})
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`x^*\bigl(B^*(AB)\bigr)x \in \mathbb{R}_{>0}`), " であり、", math(String.raw`B^*(AB)`), " は正定値である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: exp_hermitian_is_positive_definite の (2)（A が正定値、B が可逆なら B^*AB は正定値）を、1 ブロック 1 主張に合わせて独立の主張にした。本文の可逆の定義は Mat(2^M, ℂ) についてのもの（def_invertible_elements_of_R）だけで、証明が使うのは Bx = 0 ⇒ x = 0 だけなので、仮定を左逆行列 B' の存在 B'B = I にした。(B^*)^* = B、B'0 = 0、x^*(B^*(AB))x = (Bx)^*A(Bx) を根拠付きで示した。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_identity_matrix_is_positive_definite",
    kind: "claim",
    title: { text: "単位行列は正定値" },
    labels: ["identity_matrix_is_positive_definite"],
    statement: [
      paragraph(["共役転置・エルミート性・正定値性は ", ref("def_hermitian_positive_definite"), "、単位行列は ", ref("def_identity_matrix"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " について、",
        math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`),
        " は正定値である。",
      ]),
    ],
    proof: [
      paragraph([
        "エルミート性。",
        math(String.raw`i, j \in \{1,\dots,n\}`),
        " について、",
        ref("def_kronecker_delta"),
        " より ",
        math(String.raw`\delta_{ij}`),
        " は ",
        math(String.raw`1_{\mathbb{C}}`),
        " か ",
        math(String.raw`0_{\mathbb{C}}`),
        " なので ",
        ref("complex_conjugate_of_real_inclusion"),
        " より ",
        math(String.raw`\overline{\delta_{ij}} = \delta_{ij}`),
        "、また ",
        math(String.raw`i = j \iff j = i`),
        " なので ",
        math(String.raw`\delta_{ij} = \delta_{ji}`),
        " である。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(I^*)_{kl}
&= \overline{I_{lk}}
&&(\because\ \blkref{def_hermitian_positive_definite})\\
&= \overline{\delta_{lk}}
&&(\because\ \blkref{def_identity_matrix})\\
&= \delta_{lk}
&&(\because\ \overline{\delta_{lk}} = \delta_{lk})\\
&= \delta_{kl}
&&(\because\ \delta_{lk} = \delta_{kl})\\
&= I_{kl}
&&(\because\ \blkref{def_identity_matrix})
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`I^* = I`),
        " である。正値性。",
        math(String.raw`x = (x_1,\dots,x_n) \in \mathbb{C}^n \setminus \{0\}`),
        " とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
x^*Ix
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,I_{kl}\,x_l
&&(\because\ \blkref{def_conjugate_bilinear_value})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,\bigl(I_{kl}\,x_l\bigr)
&&(\because\ \text{積の結合律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{k=1}^{n} \overline{x_k}\,\Bigl(\sum_{l=1}^{n} I_{kl}\,x_l\Bigr)
&&(\because\ \text{分配律を項の数だけ繰り返す。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{k=1}^{n} \overline{x_k}\,(Ix)_k
&&(\because\ \blkref{mat_mult})\\
&= \sum_{k=1}^{n} \overline{x_k}\,x_k
&&(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult})\\
&= \sum_{k=1}^{n} \bigl(|x_k|^2\bigr)_{\mathbb{C}}
&&(\because\ \blkref{complex_conjugate_times_self}\ \text{を各項へ})\\
&= \Bigl(\sum_{k=1}^{n} |x_k|^2\Bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_finite_sum})
\end{aligned}`),
      paragraph([
        math(String.raw`x \ne 0`),
        " なので、",
        ref("def_zero_matrix"),
        " より ",
        math(String.raw`x_{k_0} \ne 0_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`k_0 \in \{1,\dots,n\}`),
        " がある。",
        ref("abs_basic_properties"),
        " (3) より ",
        math(String.raw`|x_{k_0}| \ne 0`),
        " であり、",
        math(String.raw`|x_k| \in \mathbb{R}_{\ge 0}`),
        "（",
        ref("def_abs_arg"),
        "）なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n} |x_k|^2
&\ge |x_{k_0}|^2
&&(\because\ k \ne k_0\ \text{の項は実数の二乗で}\ \ge 0)\\
&> 0
&&(\because\ \text{非零の実数の二乗は正})
\end{aligned}`),
      paragraph(["である。したがって ", math(String.raw`x^*Ix \in \mathbb{R}_{>0}`), " であり、", math(String.raw`I`), " は正定値である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。exp_hermitian_is_positive_definite の (1) の証明は w^*w = ‖w‖^2 > 0 を直接計算していた。正定値性の主張を分けるときに、exp(S) = T^*(IT) と書いて congruence_preserves_positive_definite を A = I に当てはめる形にしたので、I が正定値であることを独立の主張にした。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_positive_real_multiple_preserves_positive_definite",
    kind: "claim",
    title: { text: "正定値行列の正の実数倍は正定値" },
    labels: ["positive_real_multiple_preserves_positive_definite"],
    statement: [
      paragraph(["正定値性は ", ref("def_hermitian_positive_definite"), "、スカラー倍は ", ref("def_matrix_scalar_multiple"), "、", math(String.raw`\alpha_{\mathbb{C}}`), " は ", ref("inclusion_rr_to_cc"), " の略記による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " が正定値、",
        math(String.raw`\alpha \in \mathbb{R}_{>0}`),
        " のとき、",
        math(String.raw`\alpha_{\mathbb{C}}A`),
        " は正定値である。",
      ]),
    ],
    proof: [
      paragraph([
        "エルミート性。",
        math(String.raw`A`),
        " は正定値なのでエルミートであり、",
        ref("real_multiple_of_hermitian_is_hermitian"),
        " より ",
        math(String.raw`(\alpha_{\mathbb{C}}A)^* = \alpha_{\mathbb{C}}A`),
        " である。",
      ]),
      paragraph([
        "正値性。",
        math(String.raw`x \in \mathbb{C}^n \setminus \{0\}`),
        " とする。",
        math(String.raw`A`),
        " が正定値なので ",
        math(String.raw`x^*Ax = r_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r \in \mathbb{R}_{>0}`),
        " がある。",
      ]),
      displayMath(String.raw`\begin{aligned}
x^*(\alpha_{\mathbb{C}}A)x
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,(\alpha_{\mathbb{C}}A)_{kl}\,x_l
&&(\because\ \blkref{def_conjugate_bilinear_value})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,\bigl(\alpha_{\mathbb{C}}A_{kl}\bigr)\,x_l
&&(\because\ \blkref{def_matrix_scalar_multiple}\ \text{を各項へ})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(\bigl(\overline{x_k}\,\alpha_{\mathbb{C}}\bigr)A_{kl}\bigr)\,x_l
&&(\because\ \text{積の結合律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(\bigl(\alpha_{\mathbb{C}}\,\overline{x_k}\bigr)A_{kl}\bigr)\,x_l
&&(\because\ \text{積の可換律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(\alpha_{\mathbb{C}}\bigl(\overline{x_k}\,A_{kl}\bigr)\bigr)\,x_l
&&(\because\ \text{積の結合律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \alpha_{\mathbb{C}}\,\bigl(\overline{x_k}\,A_{kl}\,x_l\bigr)
&&(\because\ \text{積の結合律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \alpha_{\mathbb{C}}\sum_{k=1}^{n}\sum_{l=1}^{n} \overline{x_k}\,A_{kl}\,x_l
&&(\because\ \text{分配律を項の数だけ繰り返す。}\blkref{complex_numbers_form_a_field})\\
&= \alpha_{\mathbb{C}}\,\bigl(x^*Ax\bigr)
&&(\because\ \blkref{def_conjugate_bilinear_value})\\
&= \alpha_{\mathbb{C}}\,r_{\mathbb{C}}
&&(\because\ r\ \text{の取り方})\\
&= (\alpha,0)\,(r,0)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= (\alpha r - 0\cdot 0,\ \alpha\cdot 0 + 0\cdot r)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= (\alpha r,\ 0)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= (\alpha r)_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
      paragraph([
        math(String.raw`\alpha, r \in \mathbb{R}_{>0}`),
        " なので ",
        math(String.raw`\alpha r \in \mathbb{R}_{>0}`),
        "（正の実数の積は正）であり、",
        math(String.raw`x^*(\alpha_{\mathbb{C}}A)x \in \mathbb{R}_{>0}`),
        " である。よって ",
        math(String.raw`\alpha_{\mathbb{C}}A`),
        " は正定値である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: exp_hermitian_is_positive_definite の (3) を、1 ブロック 1 主張に合わせて独立の主張にした。「共役転置の線型性」「スカラー倍と行列積の結合則」と書いていた行を、real_multiple_of_hermitian_is_hermitian と def_conjugate_bilinear_value の成分の和の鎖にした。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_trace_of_positive_definite_is_positive",
    kind: "claim",
    title: { text: "正定値行列のトレースは正" },
    labels: ["trace_of_positive_definite_is_positive"],
    statement: [
      paragraph(["正定値性は ", ref("def_hermitian_positive_definite"), "、トレースは ", ref("def_trace"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " が正定値なら ",
        math(String.raw`\mathrm{tr}(A) \in \mathbb{R}_{>0}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`b^{(k)} \in \mathbb{C}^n`),
        " を ",
        math(String.raw`b^{(k)}_i := \delta_{ik}`),
        "（",
        ref("def_kronecker_delta"),
        "）で定める。",
        math(String.raw`b^{(k)}_k = 1_{\mathbb{C}} = (1,0) \ne (0,0) = 0_{\mathbb{C}}`),
        " なので ",
        math(String.raw`b^{(k)} \ne 0`),
        " である。また ",
        math(String.raw`i, j \in \{1,\dots,n\}`),
        " について、",
        math(String.raw`\delta_{ij}`),
        " は ",
        math(String.raw`1_{\mathbb{C}}`),
        " か ",
        math(String.raw`0_{\mathbb{C}}`),
        " なので ",
        ref("complex_conjugate_of_real_inclusion"),
        " より ",
        math(String.raw`\overline{\delta_{ij}} = \delta_{ij}`),
        "、",
        math(String.raw`i = j \iff j = i`),
        " なので ",
        math(String.raw`\delta_{ij} = \delta_{ji}`),
        " である。単位行列 ",
        math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`),
        " は ",
        ref("def_identity_matrix"),
        " による。",
      ]),
      displayMath(String.raw`\begin{aligned}
b^{(k)*}Ab^{(k)}
&= \sum_{i=1}^{n}\sum_{l=1}^{n} \overline{\delta_{ik}}\,A_{il}\,\delta_{lk}
&&(\because\ \blkref{def_conjugate_bilinear_value}\ \text{と}\ b^{(k)}\ \text{の定義})\\
&= \sum_{i=1}^{n}\sum_{l=1}^{n} \delta_{ik}\,A_{il}\,\delta_{lk}
&&(\because\ \overline{\delta_{ik}} = \delta_{ik}\ \text{を各項へ})\\
&= \sum_{i=1}^{n}\sum_{l=1}^{n} \delta_{ik}\,\bigl(A_{il}\,\delta_{lk}\bigr)
&&(\because\ \text{積の結合律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{i=1}^{n} \delta_{ik}\,\Bigl(\sum_{l=1}^{n} A_{il}\,\delta_{lk}\Bigr)
&&(\because\ \text{分配律を項の数だけ繰り返す。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{i=1}^{n} \delta_{ik}\,\Bigl(\sum_{l=1}^{n} A_{il}\,I_{lk}\Bigr)
&&(\because\ \blkref{def_identity_matrix}\ \text{を各項へ})\\
&= \sum_{i=1}^{n} \delta_{ik}\,(AI)_{ik}
&&(\because\ \blkref{mat_mult})\\
&= \sum_{i=1}^{n} \delta_{ik}\,A_{ik}
&&(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult})\\
&= \sum_{i=1}^{n} \delta_{ki}\,A_{ik}
&&(\because\ \delta_{ik} = \delta_{ki}\ \text{を各項へ})\\
&= \sum_{i=1}^{n} I_{ki}\,A_{ik}
&&(\because\ \blkref{def_identity_matrix}\ \text{を各項へ})\\
&= (IA)_{kk}
&&(\because\ \blkref{mat_mult})\\
&= A_{kk}
&&(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`),
      paragraph([
        math(String.raw`A`),
        " が正定値で ",
        math(String.raw`b^{(k)} \ne 0`),
        " なので、",
        math(String.raw`A_{kk} = b^{(k)*}Ab^{(k)} = (r_k)_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r_k \in \mathbb{R}_{>0}`),
        " がある（",
        ref("def_hermitian_positive_definite"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(A)
&= \sum_{k=1}^{n} A_{kk}
&&(\because\ \blkref{def_trace})\\
&= \sum_{k=1}^{n} (r_k)_{\mathbb{C}}
&&(\because\ r_k\ \text{の取り方を各項へ})\\
&= \Bigl(\sum_{k=1}^{n} r_k\Bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_finite_sum})
\end{aligned}`),
      paragraph([math(String.raw`n \ge 1`), " なので ", math(String.raw`r_1`), " があり、"]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n} r_k
&\ge r_1
&&\bigl(\because\ \blkref{finite_sum_of_nonnegative_reals_is_at_least_each_term}\ \text{を}\ m = n,\ a_j = r_j,\ k = 1\ \text{へ。各}\ r_j \in \mathbb{R}_{>0}\ \text{なので}\ r_j \ge 0\bigr)\\
&> 0
&&(\because\ r_1 \in \mathbb{R}_{>0})
\end{aligned}`),
      paragraph(["であり、", math(String.raw`\mathrm{tr}(A) \in \mathbb{R}_{>0}`), " である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: exp_hermitian_is_positive_definite の (4) を、1 ブロック 1 主張に合わせて独立の主張にした。「標準基底ベクトルによる対角成分の表示」と書いていた行を、δ の性質と単位行列の左右の単位元への参照による成分の鎖にし、トレースが正の実数の包含であることを real_inclusion_preserves_finite_sum から示した。",
        "2026-11-04（Lean の通しの証明のゴールラインの確認）: 最後の鎖の「Σ r_k ≥ r_1」の根拠「k ≠ 1 の項は r_k > 0」は名前だけの根拠だったので、finite_sum_of_nonnegative_reals_is_at_least_each_term（m = n、a_j = r_j、k = 1）を引く形にした（主張と値は不変）。Lean の具体版は Ising2D.trace_of_positive_definite_is_positive（MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTraceOfPositiveDefiniteIsPositive.lean）。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_exp_of_negative_is_left_inverse",
    kind: "claim",
    title: { tex: String.raw`\exp(-A)\exp(A) = I` },
    labels: ["exp_of_negative_is_left_inverse"],
    statement: [
      paragraph(["指数は ", ref("def_exp"), "、符号反転は ", ref("def_matrix_negation"), "、行列の積は ", ref("mat_mult"), "、単位行列 ", math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`), " は ", ref("def_identity_matrix"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`\exp(-A)\exp(A) = I`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        " の級数の極限（部分和と ",
        math(String.raw`\exp`),
        " の値の差のノルムという ",
        math(String.raw`\mathbb{R}`),
        " の数列の極限）であり、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出する。",
      ]),
    ],
    proof: [
      paragraph(["準備として、", math(String.raw`k, l \in \{1,\dots,n\}`), " について"]),
      displayMath(String.raw`\begin{aligned}
((-A)A)_{kl}
&= \sum_{j=1}^{n} (-A)_{kj}\,A_{jl}
&&(\because\ \blkref{mat_mult})\\
&= \sum_{j=1}^{n} (-A_{kj})\,A_{jl}
&&(\because\ \blkref{def_matrix_negation}\ \text{を各項へ})\\
&= \sum_{j=1}^{n} \bigl((-1_{\mathbb{C}})A_{kj}\bigr)\,A_{jl}
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を各項へ})\\
&= \sum_{j=1}^{n} \bigl(A_{kj}(-1_{\mathbb{C}})\bigr)\,A_{jl}
&&(\because\ \text{積の可換律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{j=1}^{n} A_{kj}\,\bigl((-1_{\mathbb{C}})A_{jl}\bigr)
&&(\because\ \text{積の結合律を各項へ。}\blkref{complex_numbers_form_a_field})\\
&= \sum_{j=1}^{n} A_{kj}\,(-A_{jl})
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を各項へ})\\
&= \sum_{j=1}^{n} A_{kj}\,(-A)_{jl}
&&(\because\ \blkref{def_matrix_negation}\ \text{を各項へ})\\
&= (A(-A))_{kl}
&&(\because\ \blkref{mat_mult})
\end{aligned}`),
      paragraph(["なので ", math(String.raw`(-A)A = A(-A)`), " であり、また"]),
      displayMath(String.raw`\begin{aligned}
((-A)+A)_{kl}
&= (-A)_{kl} + A_{kl}
&&(\because\ \blkref{def_matrix_sum})\\
&= (-A_{kl}) + A_{kl}
&&(\because\ \blkref{def_matrix_negation})\\
&= (-1_{\mathbb{C}})A_{kl} + A_{kl}
&&(\because\ \blkref{multiply_by_minus_one})\\
&= (-1_{\mathbb{C}})A_{kl} + 1_{\mathbb{C}}A_{kl}
&&(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field})\\
&= \bigl((-1_{\mathbb{C}}) + 1_{\mathbb{C}}\bigr)A_{kl}
&&(\because\ \text{分配律。}\blkref{complex_numbers_form_a_field})\\
&= \bigl((-1,0) + (1,0)\bigr)A_{kl}
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= (-1+1,\ 0+0)\,A_{kl}
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= (0,0)\,A_{kl}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= 0_{\mathbb{C}}\,A_{kl}
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{complex_zero_times_is_zero})\\
&= O_{kl}
&&(\because\ \blkref{def_zero_matrix})
\end{aligned}`),
      paragraph(["なので ", math(String.raw`(-A)+A = O`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\exp(-A)\exp(A)
&= \exp\bigl((-A)+A\bigr)
&&(\because\ \blkref{theorem_exp_product}\ \text{の}\ K = \mathbb{C}\ \text{と準備の}\ (-A)A = A(-A))\\
&= \exp(O)
&&(\because\ \text{準備の}\ (-A)+A = O)\\
&= I
&&(\because\ \blkref{theorem_exp_zero})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。exp_hermitian_is_positive_definite の (1) の証明は exp(S/2)exp(-S/2) = I（右逆元）から可逆性を述べていたが、Bx = 0 ⇒ x = 0 に要るのは左逆元である。正定値性の主張を分けるときに、左逆元を与える独立の主張にした。下流（V^{(+)} と対称化した転送行列の正定値性）も B' := exp(-½S) をこれで得る。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_exp_of_hermitian_is_hermitian",
    kind: "claim",
    title: { text: "エルミート行列の exp はエルミート" },
    labels: ["exp_of_hermitian_is_hermitian"],
    statement: [
      paragraph(["指数と冪は ", ref("def_exp"), "、共役転置は ", ref("def_hermitian_positive_definite"), "、行列の積は ", ref("mat_mult"), "、和とスカラー倍は ", ref("def_matrix_sum"), "・", ref("def_matrix_scalar_multiple"), "、ノルムと行列の列の収束は ", ref("def_matrix_norm"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`S \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`S^* = S`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`\exp(S)^* = \exp(S)`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\exp(S)`),
        " は ",
        ref("def_exp"),
        " の部分和の極限（部分和と ",
        math(String.raw`\exp(S)`),
        " の差のノルムという ",
        math(String.raw`\mathbb{R}`),
        " の数列の極限）であり、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出する。",
      ]),
    ],
    proof: [
      paragraph([
        "単位行列を ",
        math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        "）と書く。",
        ref("identity_matrix_is_positive_definite"),
        " より ",
        math(String.raw`I`),
        " は正定値なのでエルミートであり、",
        math(String.raw`I^* = I`),
        " である。",
      ]),
      paragraph([
        "準備として、すべての ",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`SS^m = S^mS`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
SS^0
&= SI
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I)\\
&= S
&&(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult})\\
&= IS
&&(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult})\\
&= S^0S
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I)
\end{aligned}`),
      paragraph([math(String.raw`m`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
SS^{m+1}
&= S(S^mS)
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA)\\
&= (SS^m)S
&&(\because\ \blkref{mat_mult_associative})\\
&= (S^mS)S
&&(\because\ \text{帰納法の仮定})\\
&= S^{m+1}S
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA)
\end{aligned}`),
      paragraph([
        "次に、すべての ",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`(S^m)^* = S^m`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
(S^0)^*
&= I^*
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I)\\
&= I
&&(\because\ I^* = I)\\
&= S^0
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I)
\end{aligned}`),
      paragraph([math(String.raw`m`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
(S^{m+1})^*
&= (S^mS)^*
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA)\\
&= S^*(S^m)^*
&&(\because\ \blkref{star_preserves_norm_and_limits}\ (1)\ \text{の第 1 式})\\
&= S(S^m)^*
&&(\because\ S^* = S)\\
&= SS^m
&&(\because\ \text{帰納法の仮定})\\
&= S^mS
&&(\because\ \text{準備の}\ SS^m = S^mS)\\
&= S^{m+1}
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA)
\end{aligned}`),
      paragraph([
        math(String.raw`N \in \mathbb{Z}_{\geq 0}`),
        " について部分和を ",
        math(String.raw`E_N := \sum_{m=0}^{N}\frac{1}{m!}S^m`),
        "（",
        ref("def_exp"),
        " (1) の部分和。係数は ",
        math(String.raw`(1/m!)_{\mathbb{C}}`),
        "、",
        ref("inclusion_rr_to_cc"),
        "）と置く。",
        ref("def_matrix_sum"),
        " を項の数についての帰納法で、",
        ref("def_matrix_scalar_multiple"),
        " を各項へ当てはめると、",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`(E_N)_{kl} = \sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,(S^m)_{kl}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
((E_N)^*)_{kl}
&= \overline{(E_N)_{lk}}
&&(\because\ \blkref{def_hermitian_positive_definite})\\
&= \overline{\textstyle\sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,(S^m)_{lk}}
&&(\because\ (E_N)_{lk}\ \text{の成分の式})\\
&= \textstyle\sum_{m=0}^{N}\overline{(1/m!)_{\mathbb{C}}\,(S^m)_{lk}}
&&(\because\ \blkref{complex_conjugate_of_sum}\ \text{の}\ m = N+1)\\
&= \textstyle\sum_{m=0}^{N}\overline{(1/m!)_{\mathbb{C}}}\;\overline{(S^m)_{lk}}
&&(\because\ \blkref{complex_conjugate_of_product}\ \text{を各項へ})\\
&= \textstyle\sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,\overline{(S^m)_{lk}}
&&(\because\ \blkref{complex_conjugate_of_real_inclusion}\ \text{を各項へ})\\
&= \textstyle\sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,((S^m)^*)_{kl}
&&(\because\ \blkref{def_hermitian_positive_definite}\ \text{を各項へ})\\
&= \textstyle\sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,(S^m)_{kl}
&&(\because\ \text{上で示した}\ (S^m)^* = S^m\ \text{を各項へ})\\
&= (E_N)_{kl}
&&(\because\ (E_N)_{kl}\ \text{の成分の式})
\end{aligned}`),
      paragraph([
        "なので、すべての ",
        math(String.raw`N`),
        " で ",
        math(String.raw`E_N^* = E_N`),
        " である。",
        ref("def_exp"),
        " (1) より ",
        math(String.raw`E_N \to \exp(S)`),
        " であり、",
        ref("star_preserves_norm_and_limits"),
        " (3) より ",
        math(String.raw`E_N^* \to \exp(S)^*`),
        " である。",
        math(String.raw`E_N^* = E_N`),
        " なので ",
        math(String.raw`E_N \to \exp(S)^*`),
        " でもあり、",
        ref("matrix_norm_triangle_inequality"),
        " (4)（極限の一意性）より ",
        math(String.raw`\exp(S)^* = \exp(S)`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: exp_hermitian_is_positive_definite の (1) のエルミート性の段を、1 ブロック 1 主張に合わせて独立の主張にした。「積の共役転置を k 回繰り返す」を SS^m = S^mS と (S^m)^* = S^m の二つの帰納法に、「共役転置の線型性を和の各項へ」を部分和の成分の鎖にした。部分和の記号は def_exp に合わせて添字を N にした。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_exp_of_symmetric_is_symmetric",
    kind: "claim",
    title: { text: "転置で不変な行列の exp は転置で不変" },
    labels: ["exp_of_symmetric_is_symmetric"],
    statement: [
      paragraph(["指数と冪は ", ref("def_exp"), "、転置は ", ref("def_matrix_transpose"), "、行列の積は ", ref("mat_mult"), "、和とスカラー倍は ", ref("def_matrix_sum"), "・", ref("def_matrix_scalar_multiple"), "、ノルムと行列の列の収束は ", ref("def_matrix_norm"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`S \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`S^{\top} = S`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`\exp(S)^{\top} = \exp(S)`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\exp(S)`),
        " は ",
        ref("def_exp"),
        " の部分和の極限（部分和と ",
        math(String.raw`\exp(S)`),
        " の差のノルムという ",
        math(String.raw`\mathbb{R}`),
        " の数列の極限）であり、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出する。",
      ]),
    ],
    proof: [
      paragraph([
        "単位行列を ",
        math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        "）と書く。",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(I^{\top})_{kl}
&= I_{lk}
&&(\because\ \blkref{def_matrix_transpose}\ (m \to n,\ B \to I,\ p \to k,\ q \to l\ \text{を同時に置き換える}))\\
&= \delta_{lk}
&&(\because\ \blkref{def_identity_matrix}\ (i \to l,\ j \to k))\\
&= \delta_{kl}
&&(\because\ \blkref{def_kronecker_delta}\ \text{で}\ l = k\ \text{と}\ k = l\ \text{は同じ条件})\\
&= I_{kl}
&&(\because\ \blkref{def_identity_matrix}\ (i \to k,\ j \to l))
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`I^{\top} = I`),
        " である。",
      ]),
      paragraph([
        "準備として、すべての ",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`SS^m = S^mS`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
SS^0
&= SI
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I)\\
&= S
&&(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult})\\
&= IS
&&(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult})\\
&= S^0S
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I)
\end{aligned}`),
      paragraph([math(String.raw`m`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
SS^{m+1}
&= S(S^mS)
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA)\\
&= (SS^m)S
&&(\because\ \blkref{mat_mult_associative})\\
&= (S^mS)S
&&(\because\ \text{帰納法の仮定})\\
&= S^{m+1}S
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA)
\end{aligned}`),
      paragraph([
        "次に、すべての ",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`(S^m)^{\top} = S^m`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
(S^0)^{\top}
&= I^{\top}
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I)\\
&= I
&&(\because\ I^{\top} = I)\\
&= S^0
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I)
\end{aligned}`),
      paragraph([math(String.raw`m`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
(S^{m+1})^{\top}
&= (S^mS)^{\top}
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA)\\
&= S^{\top}(S^m)^{\top}
&&(\because\ \blkref{transpose_of_matrix_product}\ (m, n, p \to n,\ A \to S^m,\ B \to S\ \text{を同時に置き換える}))\\
&= S(S^m)^{\top}
&&(\because\ S^{\top} = S)\\
&= SS^m
&&(\because\ \text{帰納法の仮定})\\
&= S^mS
&&(\because\ \text{準備の}\ SS^m = S^mS)\\
&= S^{m+1}
&&(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA)
\end{aligned}`),
      paragraph([
        math(String.raw`N \in \mathbb{Z}_{\geq 0}`),
        " について部分和を ",
        math(String.raw`E_N := \sum_{m=0}^{N}\frac{1}{m!}S^m`),
        "（",
        ref("def_exp"),
        " (1) の部分和。係数は ",
        math(String.raw`(1/m!)_{\mathbb{C}}`),
        "、",
        ref("inclusion_rr_to_cc"),
        "）と置く。",
        ref("def_matrix_sum"),
        " を項の数についての帰納法で、",
        ref("def_matrix_scalar_multiple"),
        " を各項へ当てはめると、",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`(E_N)_{kl} = \sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,(S^m)_{kl}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
((E_N)^{\top})_{kl}
&= (E_N)_{lk}
&&(\because\ \blkref{def_matrix_transpose}\ (m \to n,\ B \to E_N,\ p \to k,\ q \to l\ \text{を同時に置き換える}))\\
&= \textstyle\sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,(S^m)_{lk}
&&(\because\ (E_N)_{lk}\ \text{の成分の式})\\
&= \textstyle\sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,((S^m)^{\top})_{kl}
&&(\because\ \blkref{def_matrix_transpose}\ (m \to n,\ B \to S^m,\ p \to k,\ q \to l)\ \text{を各項へ})\\
&= \textstyle\sum_{m=0}^{N}(1/m!)_{\mathbb{C}}\,(S^m)_{kl}
&&(\because\ \text{上で示した}\ (S^m)^{\top} = S^m\ \text{を各項へ})\\
&= (E_N)_{kl}
&&(\because\ (E_N)_{kl}\ \text{の成分の式})
\end{aligned}`),
      paragraph([
        "なので、すべての ",
        math(String.raw`N`),
        " で ",
        math(String.raw`E_N^{\top} = E_N`),
        " である。",
        ref("def_exp"),
        " (1) より ",
        math(String.raw`E_N \to \exp(S)`),
        " であり、",
        ref("transpose_preserves_matrix_limits"),
        "（",
        math(String.raw`A_N`),
        " を ",
        math(String.raw`E_N`),
        " に、",
        math(String.raw`A`),
        " を ",
        math(String.raw`\exp(S)`),
        " に同時に置き換える）より ",
        math(String.raw`E_N^{\top} \to \exp(S)^{\top}`),
        " である。",
        math(String.raw`E_N^{\top} = E_N`),
        " なので ",
        math(String.raw`E_N \to \exp(S)^{\top}`),
        " でもあり、",
        ref("matrix_norm_triangle_inequality"),
        " (4)（極限の一意性）より ",
        math(String.raw`\exp(S)^{\top} = \exp(S)`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。W_is_real_symmetric_positive_definite の Step 2 が「実対称行列の冪は実対称で、def_exp の級数の部分和は実対称、star_preserves_norm_and_limits (3) と同じ議論（転置もノルムを保つ）から極限も実対称」と名前だけで述べていたので、そのうち転置で不変であることの側を主張に切り出した。手順は exp_of_hermitian_is_hermitian と同じで、共役転置の積の法則を transpose_of_matrix_product に替え、部分和の成分の 8 行の鎖からは複素共役の 3 行（complex_conjugate_of_sum・complex_conjugate_of_product・complex_conjugate_of_real_inclusion）を落とし、def_hermitian_positive_definite の 2 行を def_matrix_transpose に替えて 5 行にし、極限の段を transpose_preserves_matrix_limits に替えた。I^⊤ = I は本文に主張が無いので、証明の冒頭で成分の鎖として示した。",
      ],
    },
  },

  {
    id: "eigenvalues_of_V_claim_exp_of_real_symmetric_is_real_symmetric",
    kind: "claim",
    title: { text: "実対称な複素行列の exp は実対称" },
    labels: ["exp_of_real_symmetric_is_real_symmetric"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " が実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）ならば、",
        math(String.raw`\exp(A)`),
        "（",
        ref("def_exp"),
        "）も実対称である。",
        math(String.raw`\exp(A)`),
        " は ",
        ref("def_exp"),
        " の部分和の極限（部分和と ",
        math(String.raw`\exp(A)`),
        " の差のノルムという ",
        math(String.raw`\mathbb{R}`),
        " の数列の極限）であり、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出する。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
&A^* = A
&&\bigl(\because\ \blkref{real_symmetric_matrix_is_hermitian}\ (n \to n,\ A \to A)\bigr)\\
&A^{\top} = A
&&\bigl(\because\ \blkref{def_real_symmetric_complex_matrix}\bigr)\\
&\exp(A)^* = \exp(A)
&&\bigl(\because\ A^* = A,\ \blkref{exp_of_hermitian_is_hermitian}\ (n \to n,\ S \to A)\bigr)\\
&\exp(A)^{\top} = \exp(A)
&&\bigl(\because\ A^{\top} = A,\ \blkref{exp_of_symmetric_is_symmetric}\ (n \to n,\ S \to A)\bigr)
\end{aligned}`),
      paragraph([
        "後の二つの等式から、",
        ref("hermitian_and_transpose_invariant_matrix_is_real_symmetric"),
        "（",
        math(String.raw`n \to n,\ A \to \exp(A)`),
        "）より ",
        math(String.raw`\exp(A)`),
        " は実対称である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。W_is_real_symmetric_positive_definite の Step 2 が「実対称行列の冪は実対称で、def_exp の級数の部分和は実対称、star_preserves_norm_and_limits (3) と同じ議論（転置もノルムを保つ）から極限も実対称」と名前だけで述べていたので、主張に切り出した。極限で成分の実性が保たれることを ℝ の閉性から示す代わりに、実対称 ⟹ エルミートかつ転置で不変（real_symmetric_matrix_is_hermitian と定義）、エルミート性と転置での不変性を exp へ運ぶ（exp_of_hermitian_is_hermitian・exp_of_symmetric_is_symmetric）、エルミートかつ転置で不変 ⟹ 実対称（hermitian_and_transpose_invariant_matrix_is_real_symmetric）の順に引く。",
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
      paragraph(["指数は ", ref("def_exp"), "、共役転置と正定値性は ", ref("def_hermitian_positive_definite"), "、スカラー倍は ", ref("def_matrix_scalar_multiple"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`S \in \mathrm{Mat}(n,\mathbb{C})`),
        " が ",
        math(String.raw`S^* = S`),
        " を満たすとき、",
        math(String.raw`\exp(S)`),
        " は正定値である（正定値の定義より、とくにエルミートである）。",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        " の級数の極限であり、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出する。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`H := (1/2)_{\mathbb{C}}\,S`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）、",
        math(String.raw`T := \exp(H)`),
        "、",
        math(String.raw`T' := \exp(-H)`),
        "、",
        math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`),
        " と置く。",
        ref("real_multiple_of_hermitian_is_hermitian"),
        " の ",
        math(String.raw`\alpha = 1/2`),
        " より ",
        math(String.raw`H^* = H`),
        "、",
        ref("exp_of_hermitian_is_hermitian"),
        " を ",
        math(String.raw`H`),
        " に当てはめて ",
        math(String.raw`T^* = T`),
        "、",
        ref("exp_of_negative_is_left_inverse"),
        " を ",
        math(String.raw`H`),
        " に当てはめて ",
        math(String.raw`T'T = I`),
        " である。また ",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(H+H)_{kl}
&= H_{kl} + H_{kl}
&&(\because\ \blkref{def_matrix_sum})\\
&= (1/2)_{\mathbb{C}}S_{kl} + (1/2)_{\mathbb{C}}S_{kl}
&&(\because\ \blkref{def_matrix_scalar_multiple})\\
&= \bigl((1/2)_{\mathbb{C}} + (1/2)_{\mathbb{C}}\bigr)S_{kl}
&&(\because\ \text{分配律。}\blkref{complex_numbers_form_a_field})\\
&= \bigl((1/2,0) + (1/2,0)\bigr)S_{kl}
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= (1/2+1/2,\ 0+0)\,S_{kl}
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= (1,0)\,S_{kl}
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= 1_{\mathbb{C}}S_{kl}
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= S_{kl}
&&(\because\ 1_{\mathbb{C}}\ \text{は乗法の単位元。}\blkref{complex_numbers_form_a_field})
\end{aligned}`),
      paragraph(["なので ", math(String.raw`H+H = S`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\exp(S)
&= \exp(H+H)
&&(\because\ H+H = S)\\
&= \exp(H)\exp(H)
&&(\because\ \blkref{theorem_exp_product}\ \text{の}\ K = \mathbb{C}\ \text{と}\ HH = HH)\\
&= TT
&&(\because\ T\ \text{の定義})\\
&= T^*T
&&(\because\ T^* = T)\\
&= T^*(IT)
&&(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`),
      paragraph([
        ref("identity_matrix_is_positive_definite"),
        " より ",
        math(String.raw`I`),
        " は正定値であり、",
        math(String.raw`T'T = I`),
        " なので、",
        ref("congruence_preserves_positive_definite"),
        " の ",
        math(String.raw`A = I`),
        "、",
        math(String.raw`B = T`),
        "、",
        math(String.raw`B' = T'`),
        " より ",
        math(String.raw`T^*(IT)`),
        " は正定値である。上の鎖より ",
        math(String.raw`\exp(S) = T^*(IT)`),
        " なので、",
        math(String.raw`\exp(S)`),
        " は正定値である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の式変形統一で、共役転置・可換な行列指数の積・零行列の指数への後置き参照を、実際に適用する各等号の行末へ移した。内容・式変形・根拠・参照は変えていない。",
        "2026-11-01: SageMath の検算（sagemath/check/exp_hermitian_is_positive_definite/ ほか）を付けるときに、四つの主張を束ねていたブロックを 1 ブロック 1 主張に分けた。(2) は congruence_preserves_positive_definite、(3) は positive_real_multiple_preserves_positive_definite、(4) は trace_of_positive_definite_is_positive、(1) のエルミート性は exp_of_hermitian_is_hermitian へ移し、このブロックは (1) の正定値性だけを述べる。証明は exp(S) = T^*(IT) と書いて congruence_preserves_positive_definite を A = I に当てはめる形にした。x^*Ax の「n×1 行列へ積の共役転置を適用」と、右逆元からの可逆性を、def_conjugate_bilinear_value の成分の和と左逆元（exp_of_negative_is_left_inverse）に直した。",
      ],
    },
  },
]);
