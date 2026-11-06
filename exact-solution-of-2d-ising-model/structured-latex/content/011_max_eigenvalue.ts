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
        "準備として、",
        math(String.raw`u, v \in \mathbb{R}^n`),
        " について ",
        math(String.raw`u^\top Pv = v^\top Pu`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
u^\top Pv
&=\sum_{k=1}^{n}\sum_{l=1}^{n} u_k\,P_{kl}\,v_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} u_k\,P_{lk}\,v_l
&&\bigl(\because\ P\ \text{は対称}\ \blkref{def_real_symmetric_matrix}\bigr)\\
&=\sum_{k=1}^{n}\sum_{l=1}^{n} v_l\,P_{lk}\,u_k
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則・可換則}\bigr)\\
&=\sum_{l=1}^{n}\sum_{k=1}^{n} v_l\,P_{lk}\,u_k
&&\bigl(\because\ \blkref{finite_double_sum_of_real_numbers_interchange}\ (n_1 \to n,\ n_2 \to n,\ c_{k,l} \to v_l\,P_{lk}\,u_k)\bigr)\\
&=v^\top Pu
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)
\end{aligned}`),
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
&&\bigl(\because\ \text{準備の}\ u^\top Pv=v^\top Pu\ \text{を}\ u=x,\ v=y\ \text{で}\bigr)\\
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
      ],
    },
  },

]);
