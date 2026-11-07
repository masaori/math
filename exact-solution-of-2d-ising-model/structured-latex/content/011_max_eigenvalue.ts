import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

const SRC = "structured-latex/content/011_max_eigenvalue.ts";

export default defineBlocks([
  {
    id: "heading_max_eigenvalue",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "半正定値双線型形式の Cauchy–Schwarz の不等式" },
    labels: [],
  },

  {
    id: "maxeig_definition_real_bilinear_value",
    kind: "definition",
    title: { tex: String.raw`\text{実数の数ベクトルと実数の行列から作る数 } x^\top Py` },
    labels: ["def_real_bilinear_value"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`\mathbb{R}^n`),
        " は実数の ",
        math(String.raw`n`),
        " 個の組 ",
        math(String.raw`x = (x_1,\dots,x_n)`),
        " の全体、",
        math(String.raw`\mathrm{Mat}(n,\mathbb{R})`),
        " は成分 ",
        math(String.raw`P_{kl}`),
        "（",
        math(String.raw`k,l \in \{1,\dots,n\}`),
        "）が実数である ",
        math(String.raw`n`),
        " 行 ",
        math(String.raw`n`),
        " 列の行列の全体である。",
        math(String.raw`x, y \in \mathbb{R}^n`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        " に対し、",
      ]),
      displayMath(String.raw`x^\top P y := \sum_{k=1}^{n}\sum_{l=1}^{n} x_k\,P_{kl}\,y_l \in \mathbb{R}`),
      paragraph([
        "と定める。",
        math(String.raw`x_k\,P_{kl}\,y_l := \bigl(x_k\,P_{kl}\bigr)\,y_l`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の積、",
        math(String.raw`\sum`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の有限和で、",
        ref("def_finite_sum_of_complex_numbers"),
        " と同じく左から順に足したものとする。",
        math(String.raw`x^\top Py`),
        " はこの式で定める一つの記号であり、数ベクトルの転置と行列の積を組み合わせたものとしては読まない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。psd_cauchy_schwarz は x^⊤Px を定めずに使い、根拠を「成分積は mat_mult の式を実数成分について用い」としていた（mat_mult は複素行列についてだけ述べ、数ベクトルを n×1 行列とみなす同一視を含む）。def_conjugate_bilinear_value と同じく、値を成分の和で定める記号として切り出した。",
      ],
    },
  },

  {
    id: "maxeig_definition_real_symmetric_matrix",
    kind: "definition",
    title: { text: "実数の行列が対称であること" },
    labels: ["def_real_symmetric_matrix"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        "（",
        ref("def_real_bilinear_value"),
        " の記号）とする。",
        math(String.raw`P`),
        " が対称であるとは、すべての ",
        math(String.raw`k,l \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`P_{kl} = P_{lk}`),
        " であることをいう。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。psd_cauchy_schwarz は「対称」を P^⊤ = P と書いていたが、実数の行列の転置は本文に定義が無いので、成分の等式で定めた。",
      ],
    },
  },

  {
    id: "maxeig_claim_real_bilinear_value_of_symmetric_matrix_is_symmetric",
    kind: "claim",
    title: { text: "対称な実数の行列について、u^⊤Pv と v^⊤Pu は等しい" },
    labels: ["real_bilinear_value_of_symmetric_matrix_is_symmetric"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        " が対称（",
        ref("def_real_symmetric_matrix"),
        "）であるとする。",
        math(String.raw`u, v \in \mathbb{R}^n`),
        " に対し、",
        math(String.raw`u^\top Pv,\ v^\top Pu \in \mathbb{R}`),
        " は ",
        ref("def_real_bilinear_value"),
        " の値である。このとき",
      ]),
      displayMath(String.raw`u^\top P v = v^\top P u`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        ref("psd_cauchy_schwarz"),
        " と熱力学極限の章で、成分が実数の値をとる行列にこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の乗法の可換則・結合則と有限和だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
u^\top Pv
&=\sum_{k=1}^{n}\sum_{l=1}^{n} u_k\,P_{kl}\,v_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to u,\ y \to v)\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(u_k\,P_{lk}\bigr)\,v_l
&&\bigl(\because\ P\ \text{は対称}\ \blkref{def_real_symmetric_matrix}\ (k \to k,\ l \to l)\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} v_l\,\bigl(u_k\,P_{lk}\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換則}\ (u_k\,P_{lk})\,v_l = v_l\,(u_k\,P_{lk})\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} v_l\,\bigl(P_{lk}\,u_k\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換則}\ u_k\,P_{lk} = P_{lk}\,u_k\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(v_l\,P_{lk}\bigr)\,u_k
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則を各項へ}\bigr)\\
&=\sum_{l=1}^{n}\sum_{k=1}^{n} \bigl(v_l\,P_{lk}\bigr)\,u_k
&&\bigl(\because\ \blkref{finite_double_sum_of_real_numbers_interchange}\ (n_1 \to n,\ n_2 \to n,\ c_{k,l} \to (v_l\,P_{lk})\,u_k)\bigr)\\
&=v^\top Pu
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to v,\ y \to u。\text{和の添字}\ k, l\ \text{を}\ l, k\ \text{と書く})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。psd_cauchy_schwarz の証明の準備に置いていた u^⊤Pv = v^⊤Pu の鎖を、ほかの証明からも引けるよう主張として切り出した（c_between_Lambda_half_and_twice_Lambda_half の Step 2 を W_ℝ・ε_ℝ で書き直すときに引く）。準備の鎖の「ℝ の乗法の結合則・可換則」の一行は、可換則 2 回と結合則 1 回の 3 行に割った。数値検証: sagemath/check/real_bilinear_value_of_symmetric_matrix_is_symmetric/。",
      ],
    },
  },

  {
    id: "maxeig_claim_real_bilinear_value_is_additive_in_right_vector",
    kind: "claim",
    title: { text: "右のベクトルが成分ごとの和なら、実数の双線型値 x^⊤Pw は和に分かれる" },
    labels: ["real_bilinear_value_is_additive_in_right_vector"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        "、",
        math(String.raw`x, y, z, w \in \mathbb{R}^n`),
        "（",
        ref("def_real_bilinear_value"),
        " の記号）とし、すべての ",
        math(String.raw`l \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`w_l = y_l + z_l`),
        "（",
        math(String.raw`y_l + z_l`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の和）であるとする。",
        math(String.raw`x^\top Pw,\ x^\top Py,\ x^\top Pz \in \mathbb{R}`),
        " は ",
        ref("def_real_bilinear_value"),
        " の値である。このとき",
      ]),
      displayMath(String.raw`x^\top P w = x^\top P y + x^\top P z`),
      paragraph([
        "が成り立つ。",
        math(String.raw`x^\top P y + x^\top P z`),
        " の和は ",
        math(String.raw`\mathbb{R}`),
        " の和である。",
        math(String.raw`\mathbb{R}^n`),
        " の元どうしの和は本文で定めていないので、",
        math(String.raw`w`),
        " を成分の等式で与える。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、熱力学極限の章で、成分が実数の値をとる行列にこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の分配則と有限和だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
x^\top Pw
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(x_k\,P_{kl}\bigr)\,w_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to x,\ y \to w)\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(x_k\,P_{kl}\bigr)\,\bigl(y_l + z_l\bigr)
&&\bigl(\because\ \text{仮定}\ w_l = y_l + z_l\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \Bigl(\bigl(x_k\,P_{kl}\bigr)\,y_l + \bigl(x_k\,P_{kl}\bigr)\,z_l\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則}\ a\,(b + c) = a\,b + a\,c\ (a \to x_k\,P_{kl},\ b \to y_l,\ c \to z_l)\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\Bigl(\Bigl(\sum_{l=1}^{n} \bigl(x_k\,P_{kl}\bigr)\,y_l\Bigr) + \Bigl(\sum_{l=1}^{n} \bigl(x_k\,P_{kl}\bigr)\,z_l\Bigr)\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_real_sums}\ (m \to n,\ \text{添字}\ j \to l,\ a_l \to (x_k\,P_{kl})\,y_l,\ b_l \to (x_k\,P_{kl})\,z_l)\ \text{を各}\ k\ \text{へ}\bigr)\\
&=\Bigl(\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(x_k\,P_{kl}\bigr)\,y_l\Bigr) + \Bigl(\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(x_k\,P_{kl}\bigr)\,z_l\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_real_sums}\ (m \to n,\ \text{添字}\ j \to k,\ a_k \to \textstyle\sum_{l=1}^{n} (x_k\,P_{kl})\,y_l,\ b_k \to \textstyle\sum_{l=1}^{n} (x_k\,P_{kl})\,z_l)\bigr)\\
&=x^\top Py + x^\top Pz
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to x,\ y \to y\ \text{と}\ y \to z)\ \text{を右辺から左辺へ 2 か所へ同時適用}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 を W_ℝ・ε_ℝ で書き直すとき、v := u + ε_ℝu について v^⊤W_ℝv を展開する段で引くために足した。数値検証: sagemath/check/real_bilinear_value_is_additive_in_right_vector/。",
      ],
    },
  },

  {
    id: "maxeig_claim_real_bilinear_value_is_additive_in_left_vector",
    kind: "claim",
    title: { text: "左のベクトルが成分ごとの和なら、実数の双線型値 w^⊤Px は和に分かれる" },
    labels: ["real_bilinear_value_is_additive_in_left_vector"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        "、",
        math(String.raw`x, y, z, w \in \mathbb{R}^n`),
        "（",
        ref("def_real_bilinear_value"),
        " の記号）とし、すべての ",
        math(String.raw`k \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`w_k = y_k + z_k`),
        "（",
        math(String.raw`y_k + z_k`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の和）であるとする。",
        math(String.raw`w^\top Px,\ y^\top Px,\ z^\top Px \in \mathbb{R}`),
        " は ",
        ref("def_real_bilinear_value"),
        " の値である。このとき",
      ]),
      displayMath(String.raw`w^\top P x = y^\top P x + z^\top P x`),
      paragraph([
        "が成り立つ。",
        math(String.raw`y^\top P x + z^\top P x`),
        " の和は ",
        math(String.raw`\mathbb{R}`),
        " の和である。",
        math(String.raw`\mathbb{R}^n`),
        " の元どうしの和は本文で定めていないので、",
        math(String.raw`w`),
        " を成分の等式で与える。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、熱力学極限の章で、成分が実数の値をとる行列にこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の分配則と有限和だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
w^\top Px
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(w_k\,P_{kl}\bigr)\,x_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to w,\ y \to x)\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \Bigl(\bigl(y_k + z_k\bigr)\,P_{kl}\Bigr)\,x_l
&&\bigl(\because\ \text{仮定}\ w_k = y_k + z_k\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(y_k\,P_{kl} + z_k\,P_{kl}\bigr)\,x_l
&&\bigl(\because\ \mathbb{R}\ \text{の分配則}\ (b + c)\,a = b\,a + c\,a\ (a \to P_{kl},\ b \to y_k,\ c \to z_k)\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \Bigl(\bigl(y_k\,P_{kl}\bigr)\,x_l + \bigl(z_k\,P_{kl}\bigr)\,x_l\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則}\ (b + c)\,a = b\,a + c\,a\ (a \to x_l,\ b \to y_k\,P_{kl},\ c \to z_k\,P_{kl})\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\Bigl(\Bigl(\sum_{l=1}^{n} \bigl(y_k\,P_{kl}\bigr)\,x_l\Bigr) + \Bigl(\sum_{l=1}^{n} \bigl(z_k\,P_{kl}\bigr)\,x_l\Bigr)\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_real_sums}\ (m \to n,\ \text{添字}\ j \to l,\ a_l \to (y_k\,P_{kl})\,x_l,\ b_l \to (z_k\,P_{kl})\,x_l)\ \text{を各}\ k\ \text{へ}\bigr)\\
&=\Bigl(\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(y_k\,P_{kl}\bigr)\,x_l\Bigr) + \Bigl(\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(z_k\,P_{kl}\bigr)\,x_l\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_real_sums}\ (m \to n,\ \text{添字}\ j \to k,\ a_k \to \textstyle\sum_{l=1}^{n} (y_k\,P_{kl})\,x_l,\ b_k \to \textstyle\sum_{l=1}^{n} (z_k\,P_{kl})\,x_l)\bigr)\\
&=y^\top Px + z^\top Px
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to y,\ y \to x\ \text{と}\ x \to z,\ y \to x)\ \text{を右辺から左辺へ 2 か所へ同時適用}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 を W_ℝ・ε_ℝ で書き直すとき、v := u + ε_ℝu について v^⊤W_ℝv を展開する段で引くために足した。右のベクトルについての real_bilinear_value_is_additive_in_right_vector と別のブロックにした（1 ブロック 1 主張）。数値検証: sagemath/check/real_bilinear_value_is_additive_in_left_vector/。",
      ],
    },
  },

  {
    id: "maxeig_claim_real_bilinear_value_with_nonnegative_entries_is_nonnegative",
    kind: "claim",
    title: {
      text: "成分が非負の実数の行列と、成分が非負の二つの実数のベクトルについて、x^⊤Py は非負である",
    },
    labels: ["real_bilinear_value_with_nonnegative_entries_is_nonnegative"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        "、",
        math(String.raw`x, y \in \mathbb{R}^n`),
        "（",
        ref("def_real_bilinear_value"),
        " の記号）が、すべての ",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " で ",
        math(String.raw`P_{kl} \geq 0`),
        "、",
        math(String.raw`x_k \geq 0`),
        "、",
        math(String.raw`y_l \geq 0`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の順序）を満たすとする。",
        math(String.raw`x^\top Py \in \mathbb{R}`),
        " は ",
        ref("def_real_bilinear_value"),
        " の値である。このとき",
      ]),
      displayMath(String.raw`x^\top P y \geq 0`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、熱力学極限の章で、成分が実数の値をとる行列にこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の順序と積・有限和だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`p, q \in \{1,\dots,n\}`),
        " を取る。",
        math(String.raw`x_p \geq 0`),
        "、",
        math(String.raw`P_{pq} \geq 0`),
        "、",
        math(String.raw`y_q \geq 0`),
        " なので",
      ]),
      displayMath(String.raw`x_p\,P_{pq} \geq 0
  \qquad\bigl(\because\ \text{非負の実数の積は非負}\ (x_p \geq 0,\ P_{pq} \geq 0)\bigr)`),
      displayMath(String.raw`\bigl(x_p\,P_{pq}\bigr)\,y_q \geq 0
  \qquad\bigl(\because\ \text{非負の実数の積は非負}\ (x_p\,P_{pq} \geq 0\ \text{（上の不等式）},\ y_q \geq 0)\bigr)`),
      paragraph([
        "である（以下、この 2 つ目の不等式を「項の非負性」と呼ぶ）。これを使って、各 ",
        math(String.raw`p \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{l=1}^{n} \bigl(x_p\,P_{pl}\bigr)\,y_l
&\geq \bigl(x_p\,P_{p1}\bigr)\,y_1
&&\bigl(\because\ \blkref{finite_sum_of_nonnegative_reals_is_at_least_each_term}\ (m \to n,\ a_j \to (x_p\,P_{pj})\,y_j,\ k \to 1)\text{。仮定の}\ a_j \geq 0\ \text{は項の非負性}\ (q \to j)\bigr)\\
&\geq 0
&&\bigl(\because\ \text{項の非負性}\ (q \to 1)\bigr)
\end{aligned}`),
      paragraph(["である（以下、この不等式を「行の和の非負性」と呼ぶ）。これらを使って"]),
      displayMath(String.raw`\begin{aligned}
x^\top Py
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(x_k\,P_{kl}\bigr)\,y_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to x,\ y \to y)\bigr)\\
&\geq \sum_{l=1}^{n} \bigl(x_1\,P_{1l}\bigr)\,y_l
&&\bigl(\because\ \blkref{finite_sum_of_nonnegative_reals_is_at_least_each_term}\ (m \to n,\ a_j \to \textstyle\sum_{l=1}^{n} (x_j\,P_{jl})\,y_l,\ k \to 1)\text{。仮定の}\ a_j \geq 0\ \text{は行の和の非負性}\ (p \to j)\bigr)\\
&\geq 0
&&\bigl(\because\ \text{行の和の非負性}\ (p \to 1)\bigr)
\end{aligned}`),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は u^⊤Wεu ≥ 0 と u^⊤Wu ≥ 0 を「u, εu ≥ 0 と W_kl > 0」の名前だけで出していた。W_ℝ・ε_ℝ で書き直すときに引くために足した。使うのは成分の非負性だけなので、仮定は P_kl ≥ 0 にした。引く finite_sum_of_nonnegative_reals_is_at_least_each_term の記号 a_j・k とぶつからないよう、ベクトルを x・y、準備の添字を p・q と書く。数値検証: sagemath/check/real_bilinear_value_with_nonnegative_entries_is_nonnegative/。",
      ],
    },
  },

  {
    id: "maxeig_claim_real_bilinear_value_of_scalar_multiple_vector",
    kind: "claim",
    title: {
      text: "ベクトルを実数倍すると、実数の双線型値 w^⊤Pw はその実数どうしの積の倍になる",
    },
    labels: ["real_bilinear_value_of_scalar_multiple_vector"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        "、",
        math(String.raw`u, w \in \mathbb{R}^n`),
        "（",
        ref("def_real_bilinear_value"),
        " の記号）、",
        math(String.raw`c \in \mathbb{R}`),
        " とし、すべての ",
        math(String.raw`k \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`w_k = c\,u_k`),
        "（",
        math(String.raw`c\,u_k`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の積）であるとする。",
        math(String.raw`w^\top Pw,\ u^\top Pu \in \mathbb{R}`),
        " は ",
        ref("def_real_bilinear_value"),
        " の値である。このとき",
      ]),
      displayMath(String.raw`w^\top P w = (c\,c)\,\bigl(u^\top P u\bigr)`),
      paragraph([
        "が成り立つ。",
        math(String.raw`c\,c`),
        " と、それと ",
        math(String.raw`u^\top Pu`),
        " の積は ",
        math(String.raw`\mathbb{R}`),
        " の積である。",
        math(String.raw`\mathbb{R}^n`),
        " の元の実数倍は本文で定めていないので、",
        math(String.raw`w`),
        " を成分の等式で与える。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、熱力学極限の章で、成分が実数の値をとる行列にこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の乗法の結合則・可換則と有限和だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
w^\top Pw
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(w_k\,P_{kl}\bigr)\,w_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to w,\ y \to w)\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \Bigl(\bigl(c\,u_k\bigr)\,P_{kl}\Bigr)\,\bigl(c\,u_l\bigr)
&&\bigl(\because\ \text{仮定}\ w_k = c\,u_k\ \text{を各項の}\ w_k\ \text{と}\ w_l\ \text{へ同時適用}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \Bigl(c\,\bigl(u_k\,P_{kl}\bigr)\Bigr)\,\bigl(c\,u_l\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則}\ (c\,u_k)\,P_{kl} = c\,(u_k\,P_{kl})\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} c\,\Bigl(\bigl(u_k\,P_{kl}\bigr)\,\bigl(c\,u_l\bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則}\ (c\,s)\,t = c\,(s\,t)\ (s \to u_k\,P_{kl},\ t \to c\,u_l)\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} c\,\Bigl(\Bigl(\bigl(u_k\,P_{kl}\bigr)\,c\Bigr)\,u_l\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則}\ s\,(c\,u_l) = (s\,c)\,u_l\ (s \to u_k\,P_{kl})\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} c\,\Bigl(\Bigl(c\,\bigl(u_k\,P_{kl}\bigr)\Bigr)\,u_l\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換則}\ s\,c = c\,s\ (s \to u_k\,P_{kl})\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} c\,\Bigl(c\,\Bigl(\bigl(u_k\,P_{kl}\bigr)\,u_l\Bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則}\ (c\,s)\,u_l = c\,(s\,u_l)\ (s \to u_k\,P_{kl})\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n} c\sum_{l=1}^{n} c\,\Bigl(\bigl(u_k\,P_{kl}\bigr)\,u_l\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to n,\ c \to c,\ x_j \to c\,((u_k\,P_{kj})\,u_j))\ \text{を各}\ k\ \text{へ}\bigr)\\
&=\sum_{k=1}^{n} c\,\Bigl(c\sum_{l=1}^{n} \bigl(u_k\,P_{kl}\bigr)\,u_l\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to n,\ c \to c,\ x_j \to (u_k\,P_{kj})\,u_j)\ \text{を各}\ k\ \text{へ}\bigr)\\
&=c\sum_{k=1}^{n} c\sum_{l=1}^{n} \bigl(u_k\,P_{kl}\bigr)\,u_l
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to n,\ c \to c,\ x_j \to c\,\textstyle\sum_{l=1}^{n} (u_j\,P_{jl})\,u_l)\bigr)\\
&=c\,\Bigl(c\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(u_k\,P_{kl}\bigr)\,u_l\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to n,\ c \to c,\ x_j \to \textstyle\sum_{l=1}^{n} (u_j\,P_{jl})\,u_l)\bigr)\\
&=c\,\Bigl(c\,\bigl(u^\top Pu\bigr)\Bigr)
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to u,\ y \to u)\ \text{を右辺から左辺へ}\bigr)\\
&=(c\,c)\,\bigl(u^\top Pu\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則}\ c\,(c\,t) = (c\,c)\,t\ (t \to u^\top Pu)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は v̂ := v/‖v‖ について v̂^⊤Wv̂ = v^⊤Wv/‖v‖^2 を「v̂ = v/‖v‖ の代入と二次形式の斉次性」の名前だけで出していた。W_ℝ で書き直すときに c → 1/‖v‖ として引くために足した。実数の冪 c^2（def_power_of_real_number）を経ずに積 c c で述べたのは、引く側で 1/‖v‖ どうしの積として使えば足りるためである。引く finite_sum_of_real_scalar_multiples の記号 x_j とぶつからないよう、ベクトルを u・w と書く。数値検証: sagemath/check/real_bilinear_value_of_scalar_multiple_vector/。",
      ],
    },
  },

  {
    id: "maxeig_claim_real_bilinear_value_is_sum_with_real_matrix_vector_product",
    kind: "claim",
    title: {
      text: "実数の双線型値 u^⊤Pv は、u の成分と Pv の成分の積の和である",
    },
    labels: ["real_bilinear_value_is_sum_with_real_matrix_vector_product"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        "、",
        math(String.raw`u, v \in \mathbb{R}^n`),
        "（",
        ref("def_real_bilinear_value"),
        " の記号）とする。",
        math(String.raw`u^\top Pv \in \mathbb{R}`),
        " は ",
        ref("def_real_bilinear_value"),
        " の値、",
        math(String.raw`Pv \in \mathbb{R}^n`),
        " は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m \to n,\ n \to n,\ P \to P,\ x \to v`),
        "）の積である。このとき",
      ]),
      displayMath(String.raw`u^\top P v = \sum_{k=1}^{n} u_k\,(Pv)_k`),
      paragraph([
        "が成り立つ。右辺の ",
        math(String.raw`u_k\,(Pv)_k`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の積、",
        math(String.raw`\sum`),
        " は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、熱力学極限の章で、成分が実数の値をとる行列にこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の乗法の結合則・分配則と有限和だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
u^\top Pv
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(u_k\,P_{kl}\bigr)\,v_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to u,\ y \to v)\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} u_k\,\bigl(P_{kl}\,v_l\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則を各項へ}\bigr)\\
&=\sum_{k=1}^{n} u_k\sum_{l=1}^{n} P_{kl}\,v_l
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to n,\ c \to u_k,\ x_j \to P_{kj}\,v_j)\ \text{を各}\ k\ \text{へ}\bigr)\\
&=\sum_{k=1}^{n} u_k\,(Pv)_k
&&\bigl(\because\ \blkref{def_real_matrix_vector_product}\ (m \to n,\ n \to n,\ P \to P,\ x \to v,\ i \to k。\text{和の添字}\ j\ \text{を}\ l\ \text{と書く})\ \text{を右辺から左辺へ、各}\ k\ \text{へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は v^⊤Wv の展開で (εu)^⊤W(εu) = u^⊤Wu を「ε は W と可換で ε^2 = I」の名前だけで出していた。W_ℝ・ε_ℝ で書き直すと、行列とベクトルの積の等式（real_matrix_vector_product_is_associative・real_identity_matrix_is_left_unit_of_real_matrix_vector_product・epsilon_real_commutes_with_W_real・epsilon_real_square_is_identity）を双線型値へ運ぶ段が要るので、その形として足した。実数の行列の積の結合則と右単位の主張は本文に無いので、行列の積ではなく行列とベクトルの積の等式を運ぶ形にした。引く finite_sum_of_real_scalar_multiples・def_real_matrix_vector_product の記号 x とぶつからないよう、ベクトルを u・v と書く。数値検証: sagemath/check/real_bilinear_value_is_sum_with_real_matrix_vector_product/。",
      ],
    },
  },

  {
    id: "maxeig_claim_real_symmetric_matrix_moves_between_factors_of_sum_of_products",
    kind: "claim",
    title: {
      text: "対称な実数の行列は、成分の積の和で左の因子から右の因子へ移せる",
    },
    labels: ["real_symmetric_matrix_moves_between_factors_of_sum_of_products"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`Q \in \mathrm{Mat}(n,\mathbb{R})`),
        " が対称（",
        ref("def_real_symmetric_matrix"),
        "（",
        math(String.raw`P \to Q`),
        "））であるとし、",
        math(String.raw`u, v \in \mathbb{R}^n`),
        " とする。",
        math(String.raw`Qu, Qv \in \mathbb{R}^n`),
        " は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m \to n,\ n \to n,\ P \to Q`),
        "）の積である。このとき",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n} (Qu)_k\,v_k = \sum_{k=1}^{n} u_k\,(Qv)_k`),
      paragraph([
        "が成り立つ。各項は ",
        math(String.raw`\mathbb{R}`),
        " の積、",
        math(String.raw`\sum`),
        " は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、熱力学極限の章で、成分が実数の値をとる行列にこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の乗法の結合則・可換則・分配則と有限和だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n} (Qu)_k\,v_k
&=\sum_{k=1}^{n} \Bigl(\sum_{l=1}^{n} Q_{kl}\,u_l\Bigr)\,v_k
&&\bigl(\because\ \blkref{def_real_matrix_vector_product}\ (m \to n,\ n \to n,\ P \to Q,\ x \to u,\ i \to k。\text{和の添字}\ j\ \text{を}\ l\ \text{と書く})\ \text{を各}\ k\ \text{へ}\bigr)\\
&=\sum_{k=1}^{n} v_k\sum_{l=1}^{n} Q_{kl}\,u_l
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換則を各}\ k\ \text{へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} v_k\,\bigl(Q_{kl}\,u_l\bigr)
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to n,\ c \to v_k,\ x_j \to Q_{kj}\,u_j)\ \text{を右辺から左辺へ、各}\ k\ \text{へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} v_k\,\bigl(Q_{lk}\,u_l\bigr)
&&\bigl(\because\ Q\ \text{は対称}\ \blkref{def_real_symmetric_matrix}\ (P \to Q,\ k \to k,\ l \to l)\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(Q_{lk}\,u_l\bigr)\,v_k
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換則を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(u_l\,Q_{lk}\bigr)\,v_k
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換則}\ Q_{lk}\,u_l = u_l\,Q_{lk}\ \text{を各項へ}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} u_l\,\bigl(Q_{lk}\,v_k\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則を各項へ}\bigr)\\
&=\sum_{l=1}^{n}\sum_{k=1}^{n} u_l\,\bigl(Q_{lk}\,v_k\bigr)
&&\bigl(\because\ \blkref{finite_double_sum_of_real_numbers_interchange}\ (n_1 \to n,\ n_2 \to n,\ c_{k,l} \to u_l\,(Q_{lk}\,v_k))\bigr)\\
&=\sum_{l=1}^{n} u_l\sum_{k=1}^{n} Q_{lk}\,v_k
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to n,\ c \to u_l,\ x_j \to Q_{lj}\,v_j)\ \text{を各}\ l\ \text{へ}\bigr)\\
&=\sum_{k=1}^{n} u_k\,(Qv)_k
&&\bigl(\because\ \blkref{def_real_matrix_vector_product}\ (m \to n,\ n \to n,\ P \to Q,\ x \to v,\ i \to l。\text{和の添字}\ j\ \text{を}\ k\ \text{と書く})\ \text{を右辺から左辺へ、各}\ l\ \text{へ。外側の和の添字}\ l\ \text{を}\ k\ \text{と書く}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 の (εu)^⊤W(εu) = u^⊤Wu を W_ℝ・ε_ℝ で書き直すとき、real_bilinear_value_is_sum_with_real_matrix_vector_product で開いた和の左の因子 (ε_ℝu)_k の ε_ℝ を右の因子へ移す段に引くために足した。実数の行列の転置は本文に定義が無いので、対称な行列に限って述べた（引く側の ε_ℝ は epsilon_real_is_symmetric により対称）。数値検証: sagemath/check/real_symmetric_matrix_moves_between_factors_of_sum_of_products/。",
      ],
    },
  },

  {
    id: "maxeig_claim_real_bilinear_value_at_most_value_at_absolute_vector",
    kind: "claim",
    title: {
      text: "成分が非負の実数の行列について、x^⊤Px は成分の絶対値を並べたベクトルでの値以下である",
    },
    labels: ["real_bilinear_value_at_most_value_at_absolute_vector"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        " がすべての ",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " で ",
        math(String.raw`P_{kl} \geq 0`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の順序）を満たすとする。",
        math(String.raw`x \in \mathbb{R}^n`),
        " に対し、",
        math(String.raw`u \in \mathbb{R}^n`),
        " を ",
        math(String.raw`u_k := |x_k|`),
        "（",
        math(String.raw`k \in \{1,\dots,n\}`),
        "。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値）で定める。",
        math(String.raw`x^\top Px,\ u^\top Pu \in \mathbb{R}`),
        " は ",
        ref("def_real_bilinear_value"),
        " の値である。このとき",
      ]),
      displayMath(String.raw`x^\top P x \leq u^\top P u`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " を取る。",
        math(String.raw`x_k\,P_{kl}\,x_l := \bigl(x_k\,P_{kl}\bigr)\,x_l`),
        " は ",
        ref("def_real_bilinear_value"),
        " の項である。",
      ]),
      displayMath(String.raw`\left|\sum_{l=1}^{n} x_k\,P_{kl}\,x_l\right| \leq \sum_{l=1}^{n} \left|x_k\,P_{kl}\,x_l\right|
  \qquad\bigl(\because\ \blkref{finite_sum_of_real_numbers_triangle_inequality}\ (m \to n,\ \text{添字}\ j \to l,\ a_l \to x_k\,P_{kl}\,x_l)\bigr)`),
      paragraph([
        "である。また ",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`P_{kl} \geq 0`),
        " なので、",
        ref("def_real_absolute_value"),
        "（",
        math(String.raw`q \to P_{kl}`),
        " の ",
        math(String.raw`q \geq 0`),
        " の場合）より ",
        math(String.raw`|P_{kl}| = P_{kl}`),
        " である。これらを使って",
      ]),
      displayMath(String.raw`\begin{aligned}
x^\top P x
&\leq \left|x^\top P x\right|
  &&\bigl(\because\ \blkref{real_number_is_at_most_its_absolute_value}\ (q \to x^\top P x)\bigr)\\
&= \left|\sum_{k=1}^{n}\sum_{l=1}^{n} x_k\,P_{kl}\,x_l\right|
  &&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ y \to x)\bigr)\\
&\leq \sum_{k=1}^{n}\left|\sum_{l=1}^{n} x_k\,P_{kl}\,x_l\right|
  &&\bigl(\because\ \blkref{finite_sum_of_real_numbers_triangle_inequality}\ (m \to n,\ \text{添字}\ j \to k,\ a_k \to \textstyle\sum_{l} x_k\,P_{kl}\,x_l)\bigr)\\
&\leq \sum_{k=1}^{n}\sum_{l=1}^{n} \left|x_k\,P_{kl}\,x_l\right|
  &&\bigl(\because\ \blkref{finite_sum_of_real_numbers_is_monotone}\ (m \to n,\ \text{添字}\ j \to k,\ a_k \to \bigl|\textstyle\sum_{l} x_k\,P_{kl}\,x_l\bigr|,\ b_k \to \textstyle\sum_{l}|x_k\,P_{kl}\,x_l|)\text{。各}\ k\ \text{の大小は準備の不等式}\bigr)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} \left|x_k\,P_{kl}\right|\,|x_l|
  &&\bigl(\because\ \blkref{real_abs_of_product}\ (a \to x_k\,P_{kl},\ b \to x_l)\ \text{を各項へ}\bigr)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} |x_k|\,|P_{kl}|\,|x_l|
  &&\bigl(\because\ \blkref{real_abs_of_product}\ (a \to x_k,\ b \to P_{kl})\ \text{を各項へ}\bigr)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} |x_k|\,P_{kl}\,|x_l|
  &&\bigl(\because\ |P_{kl}| = P_{kl}\ \text{（準備）を各項へ}\bigr)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n} u_k\,P_{kl}\,u_l
  &&\bigl(\because\ u_k := |x_k|\ \text{を各項へ}\bigr)\\
&= u^\top P u
  &&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to P,\ x \to u,\ y \to u)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は u^⊤Wu ≥ |Σ x_kx_lW_kl| ≥ x^⊤Wx を「三角不等式と W_kl > 0」の一行で、実数のベクトルと複素行列 W の二次形式として出していた。def_W_real の W_ℝ で書き直すために、成分が非負の実数の行列についての主張として切り出した。使うのは成分の非負性だけなので、仮定は P_kl ≥ 0 にした（W_real_has_positive_entries の正値性から従う）。鎖の形は def_rayleigh_sup の上に有界であることの段と同じである。数値検証: sagemath/check/real_bilinear_value_at_most_value_at_absolute_vector/。",
      ],
    },
  },

  {
    id: "maxeig_claim_norm_of_vector_of_absolute_values_equals_norm",
    kind: "claim",
    title: {
      text: "成分の絶対値を並べたベクトルのノルムは、もとのベクトルのノルムに等しい",
    },
    labels: ["norm_of_vector_of_absolute_values_equals_norm"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`x \in \mathbb{R}^n`),
        " とする。",
        math(String.raw`u \in \mathbb{R}^n`),
        " を ",
        math(String.raw`u_k := |x_k|`),
        "（",
        math(String.raw`k \in \{1,\dots,n\}`),
        "。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値）で定める。両辺のノルムを ",
        ref("def_matrix_norm"),
        "（",
        math(String.raw`K = \mathbb{R}`),
        "、",
        math(String.raw`d \to n`),
        "）の数ベクトルのノルムとして",
      ]),
      displayMath(String.raw`\|u\| = \|x\|`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\|u\|
&= \sqrt{\sum_{k=1}^{n} |u_k|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to n,\ i \to k,\ w \to u)\bigr)\\
&= \sqrt{\sum_{k=1}^{n} \bigl|\,|x_k|\,\bigr|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ u_k := |x_k|\ \text{を}\ n\ \text{個の項へ同時に適用}\bigr)\\
&= \sqrt{\sum_{k=1}^{n} |x_k|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{square_of_real_absolute_value}\ (q \to |x_k|)\ \text{を}\ n\ \text{個の項へ同時に適用}\bigr)\\
&= \|x\|
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to n,\ i \to k,\ w \to x)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は ‖u‖ = ‖x‖（u_k = |x_k|）を「ノルムは成分の絶対値だけで決まる」の散文で出していた。この行を参照に替えるために、real_bilinear_value_at_most_value_at_absolute_vector と同じ u について足した。数値検証: sagemath/check/norm_of_vector_of_absolute_values_equals_norm/。",
      ],
    },
  },

  {
    id: "maxeig_claim_norm_of_normalized_real_vector_is_one",
    kind: "claim",
    title: {
      text: "零でない実数のベクトルの各成分をそのノルムで割ったベクトルは、ノルムが 1 である",
    },
    labels: ["norm_of_normalized_real_vector_is_one"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`v \in \mathbb{R}^n`),
        " が ",
        math(String.raw`v \neq 0`),
        " を満たすとする（",
        math(String.raw`\mathbb{R}^{n}`),
        " の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`x = 0`),
        " は、すべての ",
        math(String.raw`k \in \{1,\dots,n\}`),
        " で ",
        math(String.raw`x_k = 0`),
        " であることを表す）。ノルムは ",
        ref("def_matrix_norm"),
        "（",
        math(String.raw`K = \mathbb{R}`),
        "、",
        math(String.raw`d \to n`),
        "）の数ベクトルのノルムである。このとき ",
        math(String.raw`\|v\| \in \mathbb{R}_{>0}`),
        " であり（証明の準備で示す）、",
        math(String.raw`\hat{v} \in \mathbb{R}^n`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`\hat{v}_k := \frac{v_k}{\|v\|} \qquad (k \in \{1,\dots,n\})`),
      paragraph([
        "（",
        math(String.raw`\mathbb{R}`),
        " の商）で定めると",
      ]),
      displayMath(String.raw`\|\hat{v}\| = 1`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、熱力学極限の章で、成分が実数の値をとるベクトルにこの主張を使うためである。",
        "ノルムの平方根は ",
        ref("definition_of_sqrt_r_positive"),
        " のもので、その存在に ",
        math(String.raw`\mathbb{R}`),
        " の完備性を使う（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。証明はそのほかに ",
        math(String.raw`\mathbb{R}`),
        " の四則演算と順序と有限和だけを使い、極限を使わない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値、二乗は ",
        math(String.raw`\mathbb{R}`),
        " の積 ",
        math(String.raw`r^2 := r\,r`),
        " である。まず ",
        ref("matrix_norm_triangle_inequality"),
        " (1)（",
        math(String.raw`K = \mathbb{R}`),
        " の ",
        math(String.raw`K^{d}`),
        " のノルム、",
        math(String.raw`d \to n,\ A \to v`),
        "）より ",
        math(String.raw`\|v\| \geq 0`),
        " であり、",
        math(String.raw`\|v\| = 0`),
        " なら ",
        math(String.raw`v = 0`),
        " となって仮定 ",
        math(String.raw`v \neq 0`),
        " に反するので ",
        math(String.raw`\|v\| \neq 0`),
        "、よって ",
        math(String.raw`\|v\| > 0`),
        "、とくに ",
        math(String.raw`\|v\|^2 = \|v\|\,\|v\| > 0`),
        "（正の実数どうしの積は正）、よって ",
        math(String.raw`\|v\|^2 \neq 0`),
        " である。次に、",
        math(String.raw`x \in \mathbb{R}^{n}`),
        " について ",
        math(String.raw`\sum_{k=1}^{n} |x_k|^2 \geq 0`),
        "（",
        ref("def_matrix_norm"),
        " の根号の中）であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|x\|^2
&= \Bigl(\sqrt{\textstyle\sum_{k=1}^{n} |x_k|^2}^{\,(\mathbb{R}_{\ge 0})}\Bigr)^2
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to n,\ i \to k,\ w \to x)\bigr)\\
&= \sum_{k=1}^{n} |x_k|^2
  &&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ y^2 = x\ (x \to \textstyle\sum_{k=1}^{n} |x_k|^2)\bigr)
\end{aligned}`),
      paragraph(["である。よって"]),
      displayMath(String.raw`\begin{aligned}
\|\hat{v}\|
&= \sqrt{\sum_{k=1}^{n} |\hat{v}_k|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to n,\ i \to k,\ w \to \hat{v})\bigr)\\
&= \sqrt{\sum_{k=1}^{n} \Bigl|\frac{v_k}{\|v\|}\Bigr|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \hat{v}\ \text{の定義を}\ n\ \text{個の項へ同時に適用}\bigr)\\
&= \sqrt{\sum_{k=1}^{n} \Bigl(\frac{v_k}{\|v\|}\Bigr)^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{square_of_real_absolute_value}\ (q \to v_k/\|v\|)\ \text{を}\ n\ \text{個の項へ同時に適用}\bigr)\\
&= \sqrt{\sum_{k=1}^{n} \frac{1}{\|v\|^2}\,v_k^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\ (a/b)^2 = (1/b^2)\,a^2\ (a \to v_k,\ b \to \|v\| \neq 0)\ \text{を}\ n\ \text{個の項へ同時に適用}\bigr)\\
&= \sqrt{\frac{1}{\|v\|^2}\sum_{k=1}^{n} v_k^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to n,\ c \to 1/\|v\|^2,\ \text{添字}\ j \to k,\ x_j \to v_k^2)\bigr)\\
&= \sqrt{\frac{1}{\|v\|^2}\sum_{k=1}^{n} |v_k|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{square_of_real_absolute_value}\ (q \to v_k)\ \text{を右辺から左辺へ}\ n\ \text{個の項へ同時に適用}\bigr)\\
&= \sqrt{\frac{1}{\|v\|^2}\,\|v\|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \text{上で示した}\ \|x\|^2 = \textstyle\sum_{k=1}^{n} |x_k|^2\ (x \to v)\ \text{を右辺から左辺へ}\bigr)\\
&= \sqrt{1}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\ (1/b)\,b = 1\ (b \to \|v\|^2 \neq 0)\bigr)\\
&= 1
  &&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\ (x \to 1)\ \text{と}\ 1 \geq 0,\ 1^2 = 1\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は v̂ := v/‖v‖ を「𝓕^{(+)} ∩ ℝ^{2^{M_col}} の単位ベクトル」とだけ書き、‖v̂‖ = 1 を示していなかった。この行を参照に替えるために足した。ℝ^n の元の実数倍は本文で定めていないので、v̂ を成分の等式で与える（real_bilinear_value_of_scalar_multiple_vector と同じ）。数値検証: sagemath/check/norm_of_normalized_real_vector_is_one/。",
      ],
    },
  },

  {
    id: "maxeig_005_claim_psd_cauchy_schwarz",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "半正定値双線型形式の Cauchy–Schwarz の不等式" },
    labels: ["psd_cauchy_schwarz"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        " が対称（",
        ref("def_real_symmetric_matrix"),
        "）かつ半正定値（",
        math(String.raw`\forall x \in \mathbb{R}^n : x^\top P x \geq 0`),
        "。",
        math(String.raw`x^\top Px`),
        " は ",
        ref("def_real_bilinear_value"),
        " の ",
        math(String.raw`y = x`),
        " の値）とする。このとき任意の ",
        math(String.raw`x, y \in \mathbb{R}^n`),
        " について",
      ]),
      displayMath(
        String.raw`\left(y^\top P x\right)^2 \leq \left(x^\top P x\right)\left(y^\top P y\right)`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、熱力学極限の章で、成分が実数の値をとる行列にこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の四則演算と大小関係だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`t \in \mathbb{R}`),
        " について ",
        math(String.raw`w(t) \in \mathbb{R}^n`),
        " を ",
        math(String.raw`w(t)_k := y_k + t\,x_k`),
        "（",
        math(String.raw`k \in \{1,\dots,n\}`),
        "）で定め、",
        math(String.raw`q(t) := w(t)^\top P\,w(t) \in \mathbb{R}`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
q(t)
&=\sum_{k=1}^{n}\sum_{l=1}^{n} (y_k+t\,x_k)\,P_{kl}\,(y_l+t\,x_l)
&&\bigl(\because\ q(t),\ w(t)\ \text{の定義と}\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} \bigl(y_kP_{kl}y_l+t\,y_kP_{kl}x_l+t\,x_kP_{kl}y_l+t^2\,x_kP_{kl}x_l\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則・乗法の結合則・可換則}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} y_kP_{kl}y_l
+\sum_{k=1}^{n}\sum_{l=1}^{n} t\,y_kP_{kl}x_l\\
&\qquad+\sum_{k=1}^{n}\sum_{l=1}^{n} t\,x_kP_{kl}y_l
+\sum_{k=1}^{n}\sum_{l=1}^{n} t^2\,x_kP_{kl}x_l
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合則・可換則による有限和の項の並べ替え}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} y_kP_{kl}y_l
+t\sum_{k=1}^{n}\sum_{l=1}^{n} y_kP_{kl}x_l\\
&\qquad+t\sum_{k=1}^{n}\sum_{l=1}^{n} x_kP_{kl}y_l
+t^2\sum_{k=1}^{n}\sum_{l=1}^{n} x_kP_{kl}x_l
&&\bigl(\because\ \mathbb{R}\ \text{の分配則で}\ t,\ t^2\ \text{を有限和の外へ出す}\bigr)\\
&=y^\top Py+t\,y^\top Px+t\,x^\top Py+t^2\,x^\top Px
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=y^\top Py+t\,y^\top Px+t\,y^\top Px+t^2\,x^\top Px
&&\bigl(\because\ \blkref{real_bilinear_value_of_symmetric_matrix_is_symmetric}\ (n \to n,\ P \to P,\ u \to x,\ v \to y)\bigr)\\
&=(x^\top Px)\,t^2+2\,(y^\top Px)\,t+y^\top Py
&&\bigl(\because\ \mathbb{R}\ \text{の加法と乗法の可換則・分配則}\bigr)
\end{aligned}`),
      paragraph([
        "仮定の半正定値性を ",
        math(String.raw`w(t)`),
        " に当てはめると、すべての ",
        math(String.raw`t\in\mathbb{R}`),
        " について ",
        math(String.raw`0\leq q(t)`),
        " である。",
        math(String.raw`a := x^\top Px \in \mathbb{R}`),
        "、",
        math(String.raw`b := y^\top Px \in \mathbb{R}`),
        "、",
        math(String.raw`c := y^\top Py \in \mathbb{R}`),
        " と置くと、半正定値性を ",
        math(String.raw`x`),
        " に当てはめて ",
        math(String.raw`0 \leq a`),
        "、",
        math(String.raw`y`),
        " に当てはめて ",
        math(String.raw`0 \leq c`),
        " であり、",
        math(String.raw`0 \leq a`),
        " より ",
        math(String.raw`a > 0`),
        " か ",
        math(String.raw`a = 0`),
        " のどちらかである。",
      ]),
      paragraph(["(i) ", math(String.raw`a > 0`), " のとき。"]),
      displayMath(String.raw`\begin{aligned}
0
&\leq q(-b/a)
&&\bigl(\because\ P\ \text{の半正定値性を}\ w(-b/a)\ \text{に当てはめる。}\ a\neq0\ \text{なので}\ -b/a\in\mathbb{R}\ \text{が定まる}\bigr)\\
&=a\left(-\frac{b}{a}\right)^2+2b\left(-\frac{b}{a}\right)+c
&&\bigl(\because\ \text{上の}\ q(t)\ \text{の表示へ}\ t=-b/a\ \text{を代入}\bigr)\\
&=\frac{b^2}{a}-\frac{2b^2}{a}+c
&&\bigl(\because\ a\neq0\ \text{のもとでの}\ \mathbb{R}\ \text{の四則演算}\bigr)\\
&=c-\frac{b^2}{a}
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(y^\top Px)^2
&=b^2
&&\bigl(\because\ b=y^\top Px\bigr)\\
&=a\cdot\frac{b^2}{a}
&&\bigl(\because\ a\neq0\bigr)\\
&\leq a\,c
&&\bigl(\because\ 0\leq c-b^2/a\ \text{の移項で}\ b^2/a\leq c\ \text{とし、}\ a>0\ \text{を両辺へ掛ける}\bigr)\\
&=(x^\top Px)(y^\top Py)
&&\bigl(\because\ a=x^\top Px,\ c=y^\top Py\bigr)
\end{aligned}`),
      paragraph(["(ii) ", math(String.raw`a = 0`), " のとき。すべての ", math(String.raw`t\in\mathbb{R}`), " について"]),
      displayMath(String.raw`\begin{aligned}
q(t)
&=0\cdot t^2+2bt+c
&&\bigl(\because\ \text{上の}\ q(t)\ \text{の表示と}\ a=0\bigr)\\
&=2bt+c
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)
\end{aligned}`),
      paragraph([math(String.raw`b\neq0`), " と仮定し、", math(String.raw`t_0:=-(c+1)/(2b) \in \mathbb{R}`), " と置くと"]),
      displayMath(String.raw`\begin{aligned}
q(t_0)
&=2b\left(-\frac{c+1}{2b}\right)+c
&&\bigl(\because\ q(t)=2bt+c\ \text{へ}\ t=t_0\ \text{を代入}\bigr)\\
&=-(c+1)+c
&&\bigl(\because\ b\neq0\ \text{のもとでの}\ \mathbb{R}\ \text{の四則演算}\bigr)\\
&=-1
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)\\
&<0
&&\bigl(\because\ -1<0\bigr)
\end{aligned}`),
      paragraph(["これは ", math(String.raw`0\leq q(t_0)`), " と矛盾するので ", math(String.raw`b=0`), " である。したがって"]),
      displayMath(String.raw`\begin{aligned}
(y^\top Px)^2
&=b^2
&&\bigl(\because\ b=y^\top Px\bigr)\\
&=0
&&\bigl(\because\ b=0\bigr)\\
&=0\cdot c
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)\\
&=(x^\top Px)(y^\top Py)
&&\bigl(\because\ a=x^\top Px=0,\ c=y^\top Py\bigr)
\end{aligned}`),
      paragraph(["(i)(ii) のどちらでも ", math(String.raw`\left(y^\top P x\right)^2 \leq \left(x^\top P x\right)\left(y^\top P y\right)`), " が成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: SageMath の検算（sagemath/check/psd_cauchy_schwarz/）を付けるときに直した。未定義だった x^⊤Py を def_real_bilinear_value の成分の和で定め、対称性を def_real_symmetric_matrix の P_kl = P_lk とした。原文の冒頭の「成分積は mat_mult の式を実数成分について用い、複素数への包含は inclusion_rr_to_cc による」は外した（mat_mult は複素行列の積で、証明は ℂ を使わないので inclusion_rr_to_cc も要らない）。「転置・行列積の分配法則」の一行を、成分の和の展開・項の並べ替え・t と t^2 を和の外へ出す段に、「P^⊤ = P より x^⊤Py = y^⊤Px」を準備の成分の鎖に割った。a ≥ 0 から a > 0 か a = 0 に分かれること（原文は a < 0 の場合を除く理由を書いていなかった）、(i) の結論を主張の左辺から始まる鎖にすること、(ii) の 0·t^2 の行と最後の 0 = 0·c の行を足した。計算の誤りは無かった。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 証明の準備の u^⊤Pv = v^⊤Pu の鎖を主張 real_bilinear_value_of_symmetric_matrix_is_symmetric に切り出し、q(t) の展開の行はその参照で引くようにした。",
      ],
    },
  },

]);
