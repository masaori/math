import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_exp_conjugation_proof",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 7 },
    title: { tex: String.raw`\exp(X) Y \exp(-X) = \exp(\mathrm{ad}(X))(Y) \text{ の証明}` },
    labels: [],
  },
  {
    id: "exp_conjugation_definition_complex_conjugate_and_real_part",
    kind: "definition",
    origin: { path: "structured-latex/content/005_exp_conjugation_proof.ts", ordinal: 2 },
    title: { text: "複素共役" },
    labels: ["def_complex_conjugate"],
    statement: [
      paragraph([ref("definition_of_cc"), " の ", math(String.raw`z=(x,y)\in\mathbf C=\mathbf R^2`), " に対して"]),
      displayMath(String.raw`\overline z:=(x,-y)\in\mathbf C`),
      paragraph(["と定める。実部は ", ref("def_real_imag_parts"), " で定義済みである。"]),
    ],
    conversion: { status: "added", notes: ["行列の定義に混在していた複素数だけの演算を先に分離した。"] },
  },
  {
    id: "exp_conjugation_claim_complex_conjugate_of_sum",
    kind: "claim",
    title: { text: "複素共役は有限和を保つ" },
    labels: ["complex_conjugate_of_sum"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m \in \mathbb{C}`),
        " について",
      ]),
      displayMath(String.raw`\overline{\textstyle\sum_{j=1}^{m} z_j} = \textstyle\sum_{j=1}^{m} \overline{z_j}`),
      paragraph([
        "が成り立つ。複素共役は ",
        ref("def_complex_conjugate"),
        "、有限和は ",
        ref("def_finite_sum_of_complex_numbers"),
        " の有限和である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備（二つの和）。",
        math(String.raw`z = (x,y),\ w = (u,v) \in \mathbb{C}`),
        "（",
        math(String.raw`x,y,u,v \in \mathbb{R}`),
        "。",
        ref("definition_of_cc"),
        " が ",
        math(String.raw`\mathbb{C}`),
        " の台集合を ",
        math(String.raw`\mathbf{R}^2`),
        " と定めるので成分は実数である）について",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{z + w}
&= \overline{(x+u,\ y+v)}
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= \bigl(x+u,\ -(y+v)\bigr)
&&(\because\ \blkref{def_complex_conjugate})\\
&= \bigl(x+u,\ (-y)+(-v)\bigr)
&&(\because\ \mathbb{R}\ \text{で}\ -(y+v) = (-y)+(-v))\\
&= (x,-y) + (u,-v)
&&(\because\ \blkref{definition_of_cc}\ \text{の和})\\
&= \overline{z} + \overline{w}
&&(\because\ \blkref{def_complex_conjugate})
\end{aligned}`),
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{\textstyle\sum_{j=1}^{1} z_j}
&= \overline{z_1}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= \textstyle\sum_{j=1}^{1} \overline{z_j}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})
\end{aligned}`),
      paragraph([
        math(String.raw`m`),
        " で成り立つとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{\textstyle\sum_{j=1}^{m+1} z_j}
&= \overline{\bigl(\textstyle\sum_{j=1}^{m} z_j\bigr) + z_{m+1}}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= \overline{\textstyle\sum_{j=1}^{m} z_j} + \overline{z_{m+1}}
&&(\because\ \text{準備の二つの和})\\
&= \bigl(\textstyle\sum_{j=1}^{m} \overline{z_j}\bigr) + \overline{z_{m+1}}
&&(\because\ \text{帰納法の仮定})\\
&= \textstyle\sum_{j=1}^{m+1} \overline{z_j}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。star_preserves_norm_and_limits の証明は「複素共役は和を保つ」を frobenius_inner_product_axioms の証明冒頭から引いていた。証明の中の計算は主張として引けないので、有限和の形で独立の主張にした。",
      ],
    },
  },
  {
    id: "exp_conjugation_claim_complex_conjugate_of_product",
    kind: "claim",
    title: { text: "複素共役は積を保つ" },
    labels: ["complex_conjugate_of_product"],
    statement: [
      paragraph([
        math(String.raw`z, w \in \mathbb{C}`),
        " について ",
        math(String.raw`\overline{z\,w} = \overline{z}\,\overline{w}`),
        " が成り立つ。複素共役は ",
        ref("def_complex_conjugate"),
        "、積は ",
        ref("definition_of_cc"),
        " の積である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z = (x,y),\ w = (u,v)`),
        "（",
        math(String.raw`x,y,u,v \in \mathbb{R}`),
        "。",
        ref("definition_of_cc"),
        " が ",
        math(String.raw`\mathbb{C}`),
        " の台集合を ",
        math(String.raw`\mathbf{R}^2`),
        " と定めるので成分は実数である）と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{z\,w}
&= \overline{(xu - yv,\ xv + yu)}
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= \bigl(xu - yv,\ -(xv + yu)\bigr)
&&(\because\ \blkref{def_complex_conjugate})\\
&= \bigl(xu - (-y)(-v),\ -(xv + yu)\bigr)
&&(\because\ \mathbb{R}\ \text{で}\ (-y)(-v) = yv)\\
&= \bigl(xu - (-y)(-v),\ (-(xv)) + (-(yu))\bigr)
&&(\because\ \mathbb{R}\ \text{で}\ -(xv + yu) = (-(xv)) + (-(yu)))\\
&= \bigl(xu - (-y)(-v),\ x(-v) + (-(yu))\bigr)
&&(\because\ \mathbb{R}\ \text{で}\ -(xv) = x(-v))\\
&= \bigl(xu - (-y)(-v),\ x(-v) + (-y)u\bigr)
&&(\because\ \mathbb{R}\ \text{で}\ -(yu) = (-y)u)\\
&= (x,-y)\,(u,-v)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= \overline{z}\,\overline{w}
&&(\because\ \blkref{def_complex_conjugate})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。star_preserves_norm_and_limits の証明は「複素共役は積を保つ」を frobenius_inner_product_axioms の証明冒頭から引いていた。証明の中の計算は主張として引けないので、独立の主張にした。",
      ],
    },
  },
  {
    id: "exp_conjugation_claim_complex_conjugate_of_difference",
    kind: "claim",
    title: { text: "複素共役は差を保つ" },
    labels: ["complex_conjugate_of_difference"],
    statement: [
      paragraph([
        math(String.raw`z, w \in \mathbb{C}`),
        " について ",
        math(String.raw`\overline{z - w} = \overline{z} - \overline{w}`),
        " が成り立つ。複素共役は ",
        ref("def_complex_conjugate"),
        "、差は ",
        ref("def_complex_difference"),
        " の差である。",
      ]),
    ],
    proof: [
      paragraph(["準備（",  math(String.raw`-1_{\mathbb{C}}`), " の共役）。"]),
      displayMath(String.raw`\begin{aligned}
\overline{-1_{\mathbb{C}}}
&= \overline{(-1,\ 0)}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r = -1)\\
&= (-1,\ -0)
&&(\because\ \blkref{def_complex_conjugate})\\
&= (-1,\ 0)
&&(\because\ \mathbb{R}\ \text{で}\ -0 = 0)\\
&= -1_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ r_{\mathbb{C}}\ \text{の}\ r = -1)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\overline{z - w}
&= \overline{z + (-w)}
&&(\because\ \blkref{def_complex_difference})\\
&= \overline{z} + \overline{-w}
&&(\because\ \blkref{complex_conjugate_of_sum}\ \text{の}\ m = 2)\\
&= \overline{z} + \overline{(-1_{\mathbb{C}})\,w}
&&(\because\ \blkref{multiply_by_minus_one})\\
&= \overline{z} + \overline{-1_{\mathbb{C}}}\;\overline{w}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= \overline{z} + (-1_{\mathbb{C}})\,\overline{w}
&&(\because\ \text{準備の}\ \overline{-1_{\mathbb{C}}} = -1_{\mathbb{C}})\\
&= \overline{z} + \bigl(-\overline{w}\bigr)
&&(\because\ \blkref{multiply_by_minus_one})\\
&= \overline{z} - \overline{w}
&&(\because\ \blkref{def_complex_difference})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。star_preserves_norm_and_limits (3) の (A_N − A)^* = A_N^* − A^* を成分で示すのに要るので足した。",
      ],
    },
  },
  {
    id: "exp_conjugation_claim_abs_of_complex_conjugate",
    kind: "claim",
    title: { text: "複素共役の絶対値" },
    labels: ["abs_of_complex_conjugate"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " について ",
        math(String.raw`|\overline{z}| = |z|`),
        " が成り立つ。複素共役は ",
        ref("def_complex_conjugate"),
        "、絶対値は ",
        ref("def_abs_arg"),
        " の絶対値である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z = (x,y)`),
        "（",
        math(String.raw`x,y \in \mathbb{R}`),
        "。",
        ref("definition_of_cc"),
        " が ",
        math(String.raw`\mathbb{C}`),
        " の台集合を ",
        math(String.raw`\mathbf{R}^2`),
        " と定めるので成分は実数である）と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
|\overline{z}|
&= |(x,-y)|
&&(\because\ \blkref{def_complex_conjugate})\\
&= \sqrt{x^2 + (-y)^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \blkref{abs_basic_properties}\ (1))\\
&= \sqrt{x^2 + y^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{で}\ (-y)^2 = y^2)\\
&= |z|
&&(\because\ \blkref{abs_basic_properties}\ (1))
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。star_preserves_norm_and_limits (2) は |\\overline{A_{lk}}| = |A_{lk}| を「この代入の展開は未記載」として使っていたので、独立の主張にした。",
      ],
    },
  },

  {
    id: "exp_conjugation_claim_complex_conjugate_of_real_inclusion",
    kind: "claim",
    title: { text: "実数の包含の複素共役は自分自身" },
    labels: ["complex_conjugate_of_real_inclusion"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{R}`),
        " について ",
        math(String.raw`\overline{r_{\mathbb{C}}} = r_{\mathbb{C}}`),
        " が成り立つ。複素共役は ",
        ref("def_complex_conjugate"),
        "、",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である（",
        math(String.raw`1_{\mathbb{C}}`),
        "、",
        math(String.raw`0_{\mathbb{C}}`),
        " はその ",
        math(String.raw`r = 1, 0`),
        " である）。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\overline{r_{\mathbb{C}}}
&= \overline{(r,0)}
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= (r,-0)
&&(\because\ \blkref{def_complex_conjugate})\\
&= (r,0)
&&(\because\ \mathbb{R}\ \text{で}\ -0 = 0)\\
&= r_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。exp_hermitian_is_positive_definite の証明が「1/k! ∈ ℝ なので共役を取っても変わらない」と書いていたのを、正定値性の主張を分けるときに独立の主張にした。",
      ],
    },
  },

  {
    id: "exp_conjugation_claim_complex_conjugate_of_inverse",
    kind: "claim",
    title: { text: "逆元の複素共役は複素共役の逆元" },
    labels: ["complex_conjugate_of_inverse"],
    statement: [
      paragraph([
        math(String.raw`w \in \mathbb{C}^{\times}`),
        "（",
        ref("multiplicative_group_of_cc"),
        "）について、",
        math(String.raw`\overline{w} \in \mathbb{C}^{\times}`),
        " であり（したがって右辺の逆元は定まる）",
      ]),
      displayMath(String.raw`\overline{w^{-1}} = \bigl(\overline{w}\bigr)^{-1}`),
      paragraph([
        "が成り立つ。複素共役は ",
        ref("def_complex_conjugate"),
        "、逆元は ",
        ref("multiplicative_group_of_cc"),
        " の逆元、積は ",
        ref("definition_of_cc"),
        " の積である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備（",
        math(String.raw`\overline{w} \in \mathbb{C}^{\times}`),
        "）。",
        math(String.raw`w = (x,y)`),
        "（",
        math(String.raw`x,y \in \mathbb{R}`),
        "）と書くと、",
        ref("def_complex_conjugate"),
        " より ",
        math(String.raw`\overline{w} = (x,-y)`),
        " である。",
        math(String.raw`\overline{w} = (0,0)`),
        " と仮定すると、",
        ref("definition_of_cc"),
        " の ",
        math(String.raw`\mathbb{R}^2`),
        " の元の等号は成分ごとなので ",
        math(String.raw`x = 0`),
        " かつ ",
        math(String.raw`-y = 0`),
        "、よって ",
        math(String.raw`\mathbb{R}`),
        " で ",
        math(String.raw`y = -(-y) = -0 = 0`),
        " となり ",
        math(String.raw`w = (0,0)`),
        " である。これは ",
        math(String.raw`w \in \mathbb{C}^{\times} = \mathbb{C}\setminus\{(0,0)\}`),
        " に反する。したがって ",
        math(String.raw`\overline{w} \in \mathbb{C}^{\times}`),
        " であり、",
        ref("multiplicative_group_of_cc"),
        " の逆元 ",
        math(String.raw`\bigl(\overline{w}\bigr)^{-1}`),
        " が定まる。",
      ]),
      paragraph([
        "準備（",
        math(String.raw`\overline{w}\;\overline{w^{-1}} = 1_{\mathbb{C}}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{w}\;\overline{w^{-1}}
&= \overline{w\,w^{-1}}
&&\bigl(\because\ \blkref{complex_conjugate_of_product}\ (z \to w,\ w \to w^{-1}\ \text{を同時に})\ \text{を右辺から左辺へ}\bigr)\\
&= \overline{1_{\mathbb{C}}}
&&\bigl(\because\ \blkref{multiplicative_group_of_cc}\ \text{の逆元}\ (w \in \mathbb{C}^{\times})\bigr)\\
&= 1_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_conjugate_of_real_inclusion}\ (r \to 1)\bigr)
\end{aligned}`),
      paragraph(["これを使うと"]),
      displayMath(String.raw`\begin{aligned}
\overline{w^{-1}}
&= 1_{\mathbb{C}}\,\overline{w^{-1}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を右辺から左辺へ})\\
&= \Bigl(\bigl(\overline{w}\bigr)^{-1}\,\overline{w}\Bigr)\,\overline{w^{-1}}
&&\bigl(\because\ \blkref{multiplicative_group_of_cc}\ \text{の逆元}\ (\overline{w} \in \mathbb{C}^{\times})\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl(\overline{w}\bigr)^{-1}\Bigl(\overline{w}\;\overline{w^{-1}}\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \bigl(\overline{w}\bigr)^{-1}\,1_{\mathbb{C}}
&&(\because\ \text{準備の}\ \overline{w}\;\overline{w^{-1}} = 1_{\mathbb{C}})\\
&= \bigl(\overline{w}\bigr)^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-11（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。check_number_operator_is_hermitian (3) の conj(α_μ) の鎖が「\\overline{z^{-1}} = (\\bar z)^{-1}」を根拠なしに使っていたので、主張のブロックに切り出した。",
      ],
    },
  },

  {
    id: "exp_conjugation_claim_complex_conjugate_times_self",
    kind: "claim",
    title: { text: "複素共役と自分自身の積は絶対値の二乗の包含" },
    labels: ["complex_conjugate_times_self"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " について ",
        math(String.raw`\overline{z}\,z = \bigl(|z|^2\bigr)_{\mathbb{C}}`),
        " が成り立つ。複素共役は ",
        ref("def_complex_conjugate"),
        "、絶対値は ",
        ref("def_abs_arg"),
        "、積は ",
        ref("definition_of_cc"),
        "、",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z = (x,y)`),
        "（",
        math(String.raw`x,y \in \mathbb{R}`),
        "）と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{z}\,z
&= (x,-y)\,(x,y)
&&(\because\ \blkref{def_complex_conjugate})\\
&= \bigl(x x - (-y) y,\ x y + (-y) x\bigr)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= \bigl(x^2 + y^2,\ 0\bigr)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= \bigl(|z|^2,\ 0\bigr)
&&(\because\ \blkref{abs_basic_properties}\ (2))\\
&= \bigl(|z|^2\bigr)_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。identity_matrix_is_positive_definite の証明が「\\overline{z}z = |z|^2」を使うので、独立の主張にした。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_003_definition_M_n_C_convergence",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/002_式変形アプローチの概要と行列空間の内積ノルム収束の定義.typ",
      ordinal: 3,
    },
    title: { tex: String.raw`M(n;\mathbb{C}) \text{ の Frobenius 内積}` },
    labels: ["def_frobenius_inner_product"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`M(n;\mathbb{C}) := \mathrm{Mat}(n,\mathbb{C})`),
        " を ",
        math(String.raw`\mathbb{C}^{n\times n}`),
        "（成分が ",
        ref("definition_of_cc"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " に属する ",
        math(String.raw`n\times n`),
        " 配列全体）と同一視する。以下、",
        math(String.raw`A=(a_{ij})_{1\le i,j\le n},\ B=(b_{ij})_{1\le i,j\le n}\in M(n;\mathbb{C})`),
        " とする。",
      ]),
      paragraph([
        ref("def_hermitian_positive_definite"), " の共役転置、", ref("mat_mult"), " の行列積と ", ref("def_trace"), " のトレースを使い、Frobenius 内積 ",
        math(String.raw`\langle\cdot,\cdot\rangle : M(n;\mathbb{C})\times M(n;\mathbb{C})\to\mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`\langle A, B\rangle := \mathrm{tr}\!\left(A^{*}B\right)`),
      paragraph([
        "と定める。成分表示と内積の基本性質は後続の内積の性質の主張で成分計算から示す。この ",
        math(String.raw`\langle\cdot,\cdot\rangle`),
        " のノルムは既出の成分公式 ",
        ref("def_matrix_norm"),
        " を使う。後続の内積の性質の主張で、この内積から得る長さと同じ値になることを示す。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）は内積・ノルム・収束の3つとも本文が TODO だった。" +
          "ノルムと収束は既に labels: def_matrix_norm / matrix_norm_triangle_inequality / " +
          "matrix_norm_submultiplicativity / matrix_completeness として 002 章で定義・証明済みなので、" +
          "重複定義を避けて参照で結び、原文が意図していた内積（Frobenius 内積 tr(A^*B)）を" +
          "ここで新たに定義した。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
    kind: "claim",
    origin: { path: "structured-latex/content/005_exp_conjugation_proof.ts", ordinal: 3 },
    title: { text: "Frobenius 内積の性質（Hermite 内積の公理と Cauchy--Schwarz の不等式）" },
    labels: ["frobenius_inner_product_axioms"],
    statement: [
      paragraph(["成分計算に使う行列積は ", ref("mat_mult"), "、共役転置は ", ref("def_hermitian_positive_definite"), "、トレースは ", ref("def_trace"), " による。"]),
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`A=(a_{ij}),\ B=(b_{ij}),\ C=(c_{ij})\in M(n;\mathbb{C})`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " とし、",
        math(String.raw`\langle\cdot,\cdot\rangle`),
        "、",
        math(String.raw`\overline{\phantom{z}}`),
        "、",
        math(String.raw`\mathrm{Re}`),
        " は ",
        ref("def_frobenius_inner_product"), "、複素共役は ", ref("def_complex_conjugate"), "、実部は ", ref("def_real_imag_parts"), " のものとする。次が成り立つ。",
      ]),
      list([
        [
          "(0)（成分表示）",
          math(String.raw`\displaystyle \langle A,B\rangle=\mathrm{tr}(A^{*}B)=\sum_{i=1}^{n}\sum_{j=1}^{n}\overline{a_{ij}}\,b_{ij}`),
          "。",
        ],
        [
          "(1)（共役対称性）",
          math(String.raw`\langle B,A\rangle=\overline{\langle A,B\rangle}`),
          "。",
        ],
        [
          "(2)（第 2 変数についての線型性・第 1 変数についての共役線型性）",
          math(String.raw`\langle A,B+C\rangle=\langle A,B\rangle+\langle A,C\rangle`),
          "、",
          math(String.raw`\langle A,\lambda B\rangle=\lambda\langle A,B\rangle`),
          "、",
          math(String.raw`\langle A+B,C\rangle=\langle A,C\rangle+\langle B,C\rangle`),
          "、",
          math(String.raw`\langle \lambda A,B\rangle=\overline{\lambda}\langle A,B\rangle`),
          "。",
        ],
        [
          "(3)（正定値性）",
          math(String.raw`\displaystyle \langle A,A\rangle=\left(\sum_{i,j}|a_{ij}|^2\right)_{\mathbb{C}}`),
          "。特に ",
          math(String.raw`\langle A,A\rangle`),
          " は ",
          ref("inclusion_rr_to_cc"),
          " による非負実数の像であり、",
          math(String.raw`\langle A,A\rangle=0_{\mathbb{C}}\iff A=O`),
          "。また ", ref("def_matrix_norm"), " で定義したノルムについて ",
          math(String.raw`\langle A,A\rangle=\left(\|A\|^2\right)_{\mathbb{C}}`),
          "。",
        ],
        [
          "(4)（Cauchy--Schwarz の不等式）",
          math(String.raw`|\langle A,B\rangle|\le\|A\|\,\|B\|`),
          "（左辺は ",
          ref("def_abs_arg"),
          " の絶対値）。",
        ],
        [
          "(5)（三角不等式）",
          math(String.raw`\|A+B\|\le\|A\|+\|B\|`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "Step 0: 複素共役の基本性質。",
        math(String.raw`z=(x,y),\ w=(u,v)\in\mathbb{C}`),
        " について ",
        ref("definition_of_cc"),
        " の演算を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\overline{z+w}
&= \overline{(x+u,\ y+v)}
   \quad (\because \mathbb{C} \text{ の加法の定義}) \\
&= (x+u,\ -(y+v))
   \quad (\because \text{複素共役の定義}) \\
&= (x,-y)+(u,-v)
   \quad (\because \mathbb{R} \text{ の符号の計算と } \mathbb{C} \text{ の加法の定義}) \\
&= \overline{z}+\overline{w}
   \quad (\because \text{複素共役の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\overline{z\,w}
&= \overline{(xu-yv,\ xv+yu)}
   \quad (\because \mathbb{C} \text{ の乗法の定義}) \\
&= (xu-yv,\ -(xv+yu))
   \quad (\because \text{複素共役の定義}) \\
&= \left(x u-(-y)(-v),\ x(-v)+(-y)u\right)
   \quad (\because \mathbb{R} \text{ の符号の計算}) \\
&= (x,-y)\cdot(u,-v)
   \quad (\because \mathbb{C} \text{ の乗法の定義}) \\
&= \overline{z}\cdot\overline{w}
   \quad (\because \text{複素共役の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\overline{\overline{z}}
&= \overline{(x,-y)}
   \quad (\because \text{複素共役の定義}) \\
&= (x,y)
   \quad (\because \text{複素共役の定義}) \\
&= z
   \quad (\because z=(x,y))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\overline{z}\,z
&= (x,-y)\cdot(x,y)
   \quad (\because \text{複素共役の定義}) \\
&= (x\cdot x-(-y)\cdot y,\ x\cdot y+(-y)\cdot x)
   \quad (\because \mathbb{C} \text{ の乗法の定義}) \\
&= (x^2+y^2,\ 0)
   \quad (\because \mathbb{R} \text{ の符号の計算}) \\
&= \left(|z|^2\right)_{\mathbb{C}}
   \quad (\because \text{絶対値の基本性質 (2) と } \mathbb{R}\to\mathbb{C} \text{ の包含写像})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{Re}(z)
&= x
   \quad (\because \mathrm{Re} \text{ の定義}) \\
&\le \sqrt{x^2}^{\,(\mathbb{R}_{\ge 0})}
   \quad (\because x\le|x|=\sqrt{x^2}^{\,(\mathbb{R}_{\ge 0})}) \\
&\le \sqrt{x^2+y^2}^{\,(\mathbb{R}_{\ge 0})}
   \quad (\because \sqrt{\cdot} \text{ の単調性と } x^2\le x^2+y^2) \\
&= |z|
   \quad (\because \text{絶対値の基本性質 (1)})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ（用いた ",
        ref("definition_of_cc"),
        "、",
        ref("abs_basic_properties"),
        "、",
        ref("inclusion_rr_to_cc"),
        "、",
        ref("definition_of_sqrt_r_positive"),
        " は各行の ",
        math(String.raw`(\because\ \cdot)`),
        " に挙げたとおりである）。",
      ]),
      paragraph(["Step 1: (0)。行列の積の定義と ", ref("definition_of_cc"), " の加法・乗法より、"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(A^{*}B\right)
&= \sum_{i=1}^{n}\left(A^{*}B\right)_{ii}
   \quad (\because \mathrm{tr} \text{ の定義}) \\
&= \sum_{i=1}^{n}\sum_{j=1}^{n}\left(A^{*}\right)_{ij}\,b_{ji}
   \quad (\because \text{行列の積の定義}) \\
&= \sum_{i=1}^{n}\sum_{j=1}^{n}\overline{a_{ji}}\,b_{ji}
   \quad (\because \left(A^{*}\right)_{ij}=\overline{a_{ji}}) \\
&= \sum_{j=1}^{n}\sum_{i=1}^{n}\overline{a_{ji}}\,b_{ji}
   \quad (\because \text{有限和の順序交換}) \\
&= \sum_{i=1}^{n}\sum_{j=1}^{n}\overline{a_{ij}}\,b_{ij}
   \quad (\because \text{添字 } i,j \text{ の付け替え})
\end{aligned}`,
      ),
      paragraph(["Step 2: (1)。Step 0 の ", math(String.raw`\overline{z+w}=\overline{z}+\overline{w}`), "、", math(String.raw`\overline{zw}=\overline{z}\,\overline{w}`), "、", math(String.raw`\overline{\overline{z}}=z`), " より、"]),
      displayMath(
        String.raw`\begin{aligned}
\overline{\langle A,B\rangle}
&= \overline{\sum_{i,j}\overline{a_{ij}}\,b_{ij}}
   \quad (\because \text{(0)}) \\
&= \sum_{i,j}\overline{\overline{a_{ij}}\,b_{ij}}
   \quad (\because \overline{\phantom{z}} \text{ は加法的、有限和}) \\
&= \sum_{i,j}\overline{\overline{a_{ij}}}\cdot\overline{b_{ij}}
   \quad (\because \overline{\phantom{z}} \text{ は乗法的}) \\
&= \sum_{i,j}\overline{b_{ij}}\,a_{ij}
   \quad (\because \overline{\overline{z}}=z,\ \mathbb{C} \text{ の乗法の可換性}) \\
&= \langle B,A\rangle
   \quad (\because \text{(0)})
\end{aligned}`,
      ),
      paragraph(["Step 3: (2)。分配律と Step 0 の乗法性より、"]),
      displayMath(
        String.raw`\begin{aligned}
\langle A,B+C\rangle
&= \sum_{i,j}\overline{a_{ij}}\,(B+C)_{ij}
   \quad (\because \text{(0)}) \\
&= \sum_{i,j}\overline{a_{ij}}\left(b_{ij}+c_{ij}\right)
   \quad (\because \blkref{def_matrix_sum}) \\
&= \sum_{i,j}\left(\overline{a_{ij}}b_{ij}+\overline{a_{ij}}c_{ij}\right)
   \quad (\because \mathbb{C} \text{ の分配律}) \\
&= \sum_{i,j}\overline{a_{ij}}b_{ij}+\sum_{i,j}\overline{a_{ij}}c_{ij}
   \quad (\because \text{有限和の分割}) \\
&= \langle A,B\rangle+\langle A,C\rangle
   \quad (\because \text{(0)})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\langle A,\lambda B\rangle
&= \sum_{i,j}\overline{a_{ij}}\,(\lambda B)_{ij}
   \quad (\because \text{(0)}) \\
&= \sum_{i,j}\overline{a_{ij}}\left(\lambda b_{ij}\right)
   \quad (\because \blkref{def_matrix_scalar_multiple}) \\
&= \sum_{i,j}\lambda\left(\overline{a_{ij}}b_{ij}\right)
   \quad (\because \mathbb{C} \text{ の乗法の可換性と結合律}) \\
&= \lambda\sum_{i,j}\overline{a_{ij}}b_{ij}
   \quad (\because \text{有限和と元の積についての分配律}) \\
&= \lambda\langle A,B\rangle
   \quad (\because \text{(0)})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\langle A+B,C\rangle
&= \sum_{i,j}\overline{(A+B)_{ij}}\;c_{ij}
   \quad (\because \text{(0)}) \\
&= \sum_{i,j}\overline{a_{ij}+b_{ij}}\;c_{ij}
   \quad (\because \blkref{def_matrix_sum}) \\
&= \sum_{i,j}\left(\overline{a_{ij}}+\overline{b_{ij}}\right)c_{ij}
   \quad (\because \text{Step 0 の } \overline{z+w}=\overline{z}+\overline{w}) \\
&= \sum_{i,j}\left(\overline{a_{ij}}c_{ij}+\overline{b_{ij}}c_{ij}\right)
   \quad (\because \mathbb{C} \text{ の分配律}) \\
&= \sum_{i,j}\overline{a_{ij}}c_{ij}+\sum_{i,j}\overline{b_{ij}}c_{ij}
   \quad (\because \text{有限和の分割}) \\
&= \langle A,C\rangle+\langle B,C\rangle
   \quad (\because \text{(0)})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\langle \lambda A,B\rangle
&= \sum_{i,j}\overline{(\lambda A)_{ij}}\;b_{ij}
   \quad (\because \text{(0)}) \\
&= \sum_{i,j}\overline{\lambda a_{ij}}\;b_{ij}
   \quad (\because \blkref{def_matrix_scalar_multiple}) \\
&= \sum_{i,j}\overline{\lambda}\,\overline{a_{ij}}\,b_{ij}
   \quad (\because \text{Step 0 の } \overline{zw}=\overline{z}\,\overline{w}) \\
&= \overline{\lambda}\sum_{i,j}\overline{a_{ij}}\,b_{ij}
   \quad (\because \text{有限和と元の積についての分配律}) \\
&= \overline{\lambda}\langle A,B\rangle
   \quad (\because \text{(0)})
\end{aligned}`,
      ),
      paragraph(["Step 4: (3)。Step 0 の ", math(String.raw`\overline{z}z=\left(|z|^2\right)_{\mathbb{C}}`), " より、"]),
      displayMath(
        String.raw`\begin{aligned}
\langle A,A\rangle
&= \sum_{i,j}\overline{a_{ij}}\,a_{ij}
   \quad (\because \text{(0)}) \\
&= \sum_{i,j}\left(|a_{ij}|^2\right)_{\mathbb{C}}
   \quad (\because \text{Step 0 の } \overline{z}z=\left(|z|^2\right)_{\mathbb{C}}) \\
&= \left(\sum_{i,j}|a_{ij}|^2\right)_{\mathbb{C}}
   \quad (\because \mathbb{R}\to\mathbb{C} \text{ の包含写像 } \iota_{\mathbb{R}\to\mathbb{C}} \text{ が加法を保つこと})
\end{aligned}`,
      ),
      paragraph([
        "最後の段で引いたのは ",
        ref("inclusion_rr_to_cc"),
        " である。さらに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\langle A,A\rangle
&= \left(\sum_{i,j}|a_{ij}|^2\right)_{\mathbb{C}}
   \quad (\because \text{上の鎖}) \\
&= \left(\|A\|^2\right)_{\mathbb{C}}
   \quad (\because \|A\|^2=\sum_{i,j}|a_{ij}|^2\ \text{（ノルムの定義）})
\end{aligned}`,
      ),
      paragraph([
        "である（ノルムの定義は ",
        ref("def_matrix_norm"),
        "）。よって ",
        math(String.raw`\langle A,A\rangle`),
        " は非負実数 ",
        math(String.raw`\|A\|^2`),
        " の像であり、",
        math(String.raw`\sqrt{\langle A,A\rangle}=\|A\|`),
        "。",
        math(String.raw`\langle A,A\rangle=0_{\mathbb{C}}\iff\|A\|=0\iff A=O`),
        " は ",
        ref("matrix_norm_triangle_inequality"),
        " (1) による。",
      ]),
      paragraph([
        "Step 5: (4)。",
        math(String.raw`u:=\langle A,B\rangle\in\mathbb{C}`),
        " とおく。",
      ]),
      paragraph([
        "場合 1: ",
        math(String.raw`\|B\|=0`),
        " のとき。(3) より ",
        math(String.raw`B=O`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u
&= \sum_{i,j}\overline{a_{ij}}\,b_{ij}
   \quad (\because u \text{ の定義と (0)}) \\
&= \sum_{i,j}\overline{a_{ij}}\cdot 0_{\mathbb{C}}
   \quad (\because B=O \text{ なので各成分 } b_{ij}=0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}
   \quad (\because 0_{\mathbb{C}} \text{ との積が } 0_{\mathbb{C}} \text{ であることと有限和})
\end{aligned}`,
      ),
      paragraph([
        "となる。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|u|
&= |0_{\mathbb{C}}|
   \quad (\because \text{上の鎖 } u=0_{\mathbb{C}}) \\
&= 0
   \quad (\because \text{絶対値の基本性質}) \\
&= \|A\|\cdot 0
   \quad (\because \text{実数の } 0 \text{ との積は } 0) \\
&= \|A\|\,\|B\|
   \quad (\because \|B\|=0)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`|u|=\|A\|\,\|B\|`),
        "（",
        ref("abs_basic_properties"),
        "）を得る。",
      ]),
      paragraph([
        "場合 2: ",
        math(String.raw`\|B\|>0`),
        " のとき。",
        math(String.raw`\beta:=\|B\|^2\in\mathbb{R}`),
        " とおき、",
        math(String.raw`\beta_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記とする。",
        math(String.raw`\|B\|>0`),
        " より ",
        math(String.raw`\beta=\|B\|\,\|B\|>0`),
        "（",
        math(String.raw`\mathbb{R}`),
        " で正の数どうしの積は正）なので ",
        math(String.raw`\beta\neq 0`),
        " であり、",
        ref("real_inclusion_preserves_inverse"),
        "（",
        math(String.raw`r \to \beta`),
        "）により ",
        math(String.raw`\beta_{\mathbb{C}}\in\mathbb{C}^{\times}`),
        " かつ ",
        math(String.raw`\bigl(\beta^{-1}\bigr)_{\mathbb{C}}=\bigl(\beta_{\mathbb{C}}\bigr)^{-1}`),
        " である。",
        ref("def_complex_quotient"),
        "（",
        math(String.raw`z \to \overline{u},\ w \to \beta_{\mathbb{C}}`),
        "）により",
      ]),
      displayMath(String.raw`t:=\frac{\overline{u}}{\beta_{\mathbb{C}}}=\overline{u}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\in\mathbb{C}`),
      paragraph([
        "とおく。",
        math(String.raw`q:=|u|^2/\|B\|^2\in\mathbb{R}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の商。",
        math(String.raw`\|B\|^2=\beta\neq 0`),
        "）とおく。",
      ]),
      paragraph([
        "準備（",
        math(String.raw`\overline{t}=u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{t}
&= \overline{\overline{u}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}}
&&(\because\ t\ \text{の定義})\\
&= \overline{\overline{u}}\;\overline{\bigl(\beta_{\mathbb{C}}\bigr)^{-1}}
&&\bigl(\because\ \blkref{complex_conjugate_of_product}\ (z \to \overline{u},\ w \to (\beta_{\mathbb{C}})^{-1})\bigr)\\
&= u\,\overline{\bigl(\beta_{\mathbb{C}}\bigr)^{-1}}
&&(\because\ \text{Step 0 の}\ \overline{\overline{z}}=z\ (z \to u))\\
&= u\,\bigl(\overline{\beta_{\mathbb{C}}}\bigr)^{-1}
&&(\because\ \blkref{complex_conjugate_of_inverse}\ (w \to \beta_{\mathbb{C}}))\\
&= u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_conjugate_of_real_inclusion}\ (r \to \beta))
\end{aligned}`),
      paragraph([
        "準備（",
        math(String.raw`(\overline{u}\,u)\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}=q_{\mathbb{C}}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\overline{u}\,u)\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}
&= \bigl(|u|^2\bigr)_{\mathbb{C}}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_conjugate_times_self}\ (z \to u))\\
&= \bigl(|u|^2\bigr)_{\mathbb{C}}\,\bigl(\beta^{-1}\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_inverse}\ (r \to \beta)\ \text{を右辺から左辺へ})\\
&= \bigl(|u|^2\,\beta^{-1}\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ (a \to |u|^2,\ b \to \beta^{-1}))\\
&= \bigl(|u|^2\,(\|B\|^2)^{-1}\bigr)_{\mathbb{C}}
&&(\because\ \beta\ \text{の定義})\\
&= \Bigl(\frac{|u|^2}{\|B\|^2}\Bigr)_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{の商}\ x/y = x\,y^{-1}\ \text{を右辺から左辺へ})\\
&= q_{\mathbb{C}}
&&(\because\ q\ \text{の定義})
\end{aligned}`),
      paragraph(["(2)(1) を展開すると"]),
      displayMath(
        String.raw`\begin{aligned}
0 &\le \left\|A-tB\right\|^2 \\
\left(\left\|A-tB\right\|^2\right)_{\mathbb{C}}
&= \langle A-tB,\ A-tB\rangle
   \quad (\because \text{(3)}) \\
&= \langle A,A\rangle-\langle A,tB\rangle-\langle tB,A\rangle+\langle tB,tB\rangle
   \quad (\because \text{(2) を各変数に適用}) \\
&= \langle A,A\rangle-t\langle A,B\rangle-\overline{t}\langle B,A\rangle
   +\overline{t}\,t\,\langle B,B\rangle
   \quad (\because \text{(2)})
\end{aligned}`,
      ),
      paragraph(["三つの積の項を順に計算すると"]),
      displayMath(String.raw`\begin{aligned}
t\langle A,B\rangle
&= t\,u
&&(\because\ u\ \text{の定義})\\
&= \Bigl(\overline{u}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\,u
&&(\because\ t\ \text{の定義})\\
&= \overline{u}\,\Bigl(\bigl(\beta_{\mathbb{C}}\bigr)^{-1}u\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \overline{u}\,\Bigl(u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= (\overline{u}\,u)\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= q_{\mathbb{C}}
&&(\because\ \text{準備の}\ (\overline{u}\,u)\,(\beta_{\mathbb{C}})^{-1}=q_{\mathbb{C}})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\overline{t}\langle B,A\rangle
&= \overline{t}\;\overline{\langle A,B\rangle}
&&(\because\ \text{(1)})\\
&= \overline{t}\;\overline{u}
&&(\because\ u\ \text{の定義})\\
&= \Bigl(u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\,\overline{u}
&&(\because\ \text{準備の}\ \overline{t}=u\,(\beta_{\mathbb{C}})^{-1})\\
&= u\,\Bigl(\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\overline{u}\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= u\,\Bigl(\overline{u}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= (u\,\overline{u})\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= (\overline{u}\,u)\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= q_{\mathbb{C}}
&&(\because\ \text{準備の}\ (\overline{u}\,u)\,(\beta_{\mathbb{C}})^{-1}=q_{\mathbb{C}})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\overline{t}\,t\,\langle B,B\rangle
&= \bigl(\overline{t}\,t\bigr)\,\bigl(\|B\|^2\bigr)_{\mathbb{C}}
&&(\because\ \text{(3)}\ (A \to B)\ \text{の}\ \langle B,B\rangle=(\|B\|^2)_{\mathbb{C}})\\
&= \bigl(\overline{t}\,t\bigr)\,\beta_{\mathbb{C}}
&&(\because\ \beta\ \text{の定義})\\
&= \Bigl(\overline{t}\,\Bigl(\overline{u}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\Bigr)\,\beta_{\mathbb{C}}
&&(\because\ t\ \text{の定義})\\
&= \Bigl(\Bigl(u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\Bigl(\overline{u}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\Bigr)\,\beta_{\mathbb{C}}
&&(\because\ \text{準備の}\ \overline{t}=u\,(\beta_{\mathbb{C}})^{-1})\\
&= \Bigl(u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\Bigl(\Bigl(\overline{u}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\,\beta_{\mathbb{C}}\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \Bigl(u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\Bigl(\overline{u}\,\Bigl(\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\beta_{\mathbb{C}}\Bigr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \Bigl(u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\bigl(\overline{u}\,1_{\mathbb{C}}\bigr)
&&\bigl(\because\ \blkref{multiplicative_group_of_cc}\ \text{の逆元}\ (\beta_{\mathbb{C}} \in \mathbb{C}^{\times})\bigr)\\
&= \Bigl(u\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)\,\overline{u}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= u\,\Bigl(\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\overline{u}\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= u\,\Bigl(\overline{u}\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= (u\,\overline{u})\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= (\overline{u}\,u)\,\bigl(\beta_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= q_{\mathbb{C}}
&&(\because\ \text{準備の}\ (\overline{u}\,u)\,(\beta_{\mathbb{C}})^{-1}=q_{\mathbb{C}})
\end{aligned}`),
      paragraph(["となり、合わせて"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left\|A-tB\right\|^2\right)_{\mathbb{C}}
&= \langle A,A\rangle-t\langle A,B\rangle-\overline{t}\langle B,A\rangle+\overline{t}\,t\,\langle B,B\rangle
&&(\because\ \text{上の展開式})\\
&= \left(\|A\|^2\right)_{\mathbb{C}}-t\langle A,B\rangle-\overline{t}\langle B,A\rangle+\overline{t}\,t\,\langle B,B\rangle
&&(\because\ \text{(3) の}\ \langle A,A\rangle=\left(\|A\|^2\right)_{\mathbb{C}})\\
&= \left(\|A\|^2\right)_{\mathbb{C}}-q_{\mathbb{C}}-\overline{t}\langle B,A\rangle+\overline{t}\,t\,\langle B,B\rangle
&&(\because\ \text{直前の}\ t\langle A,B\rangle\ \text{の鎖})\\
&= \left(\|A\|^2\right)_{\mathbb{C}}-q_{\mathbb{C}}-q_{\mathbb{C}}+\overline{t}\,t\,\langle B,B\rangle
&&(\because\ \text{直前の}\ \overline{t}\langle B,A\rangle\ \text{の鎖})\\
&= \left(\|A\|^2\right)_{\mathbb{C}}-q_{\mathbb{C}}-q_{\mathbb{C}}+q_{\mathbb{C}}
&&(\because\ \text{直前の}\ \overline{t}\,t\,\langle B,B\rangle\ \text{の鎖})\\
&= \Bigl(\Bigl(\left(\|A\|^2\right)_{\mathbb{C}}+\bigl(-q_{\mathbb{C}}\bigr)\Bigr)+\bigl(-q_{\mathbb{C}}\bigr)\Bigr)+q_{\mathbb{C}}
&&(\because\ \blkref{def_complex_difference}\ \text{を 2 か所へ})\\
&= \Bigl(\left(\|A\|^2\right)_{\mathbb{C}}+\bigl(-q_{\mathbb{C}}\bigr)\Bigr)+\Bigl(\bigl(-q_{\mathbb{C}}\bigr)+q_{\mathbb{C}}\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法の結合律})\\
&= \Bigl(\left(\|A\|^2\right)_{\mathbb{C}}+\bigl(-q_{\mathbb{C}}\bigr)\Bigr)+0_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元（}(\mathbb{C},+)\ \text{は可換群）})\\
&= \left(\|A\|^2\right)_{\mathbb{C}}+\bigl(-q_{\mathbb{C}}\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法の単位元})\\
&= \left(\|A\|^2\right)_{\mathbb{C}}-q_{\mathbb{C}}
&&(\because\ \blkref{def_complex_difference}\ \text{を右辺から左辺へ})\\
&= \left(\|A\|^2-q\right)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_difference}\ (y \to \|A\|^2,\ z \to q))\\
&= \left(\|A\|^2-\frac{|u|^2}{\|B\|^2}\right)_{\mathbb{C}}
&&(\because\ q\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "上の鎖の両端に ",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to \|A-tB\|^2,\ b \to \|A\|^2-\frac{|u|^2}{\|B\|^2}`),
        "）を当てて、実数の等式 ",
        math(String.raw`\|A-tB\|^2=\|A\|^2-|u|^2/\|B\|^2`),
        " を得る。これと ",
        ref("matrix_norm_triangle_inequality"),
        " (1) から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0 &\le \|A-tB\|^2
   \quad (\because \text{ノルムの基本性質（非退化性・斉次性・三角不等式）の (1)}) \\
  &= \|A\|^2-\frac{|u|^2}{\|B\|^2}
   \quad (\because \text{直前の実数の等式})
\end{aligned}`,
      ),
      paragraph(["である。これを移項して"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{|u|^2}{\|B\|^2}
&= \|A\|^2-\left(\|A\|^2-\frac{|u|^2}{\|B\|^2}\right)
   \quad (\because \mathbb{R} \text{ の四則}) \\
&\le \|A\|^2-0
   \quad (\because \text{直前の } 0\le\|A\|^2-|u|^2/\|B\|^2 \text{ と、} \mathbb{R} \text{ で引く数が大きいほど差は小さいこと}) \\
&= \|A\|^2
   \quad (\because \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph(["を得る。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
|u|^2
&= \frac{|u|^2}{\|B\|^2}\cdot\|B\|^2
   \quad (\because \|B\|^2>0 \text{ と } \mathbb{R} \text{ の四則}) \\
&\le \|A\|^2\cdot\|B\|^2
   \quad (\because \text{直前の不等式の両辺に正の数 } \|B\|^2 \text{ を掛ける}) \\
&= \left(\|A\|\,\|B\|\right)^2
   \quad (\because \mathbb{R} \text{ の乗法の可換性と結合性})
\end{aligned}`,
      ),
      paragraph([
        "を得る。",
        math(String.raw`|u|\ge 0`),
        " かつ ",
        math(String.raw`\|A\|\,\|B\|\ge 0`),
        " なので非負実数の平方の単調性（",
        ref("matrix_norm_triangle_inequality"),
        " の証明 Step 0）により ",
        math(String.raw`|u|\le\|A\|\,\|B\|`),
        "。",
      ]),
      paragraph(["Step 6: (5)。(3)(2)(1) より"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\|A+B\|^2\right)_{\mathbb{C}}
&= \langle A+B,\ A+B\rangle
   \quad (\because \text{(3)}) \\
&= \langle A,A\rangle+\langle A,B\rangle+\langle B,A\rangle+\langle B,B\rangle
   \quad (\because \text{(2)}) \\
&= \left(\|A\|^2\right)_{\mathbb{C}}
   + \left(u+\overline{u}\right)
   + \left(\|B\|^2\right)_{\mathbb{C}}
   \quad (\because \text{(1),(3)},\ u=\langle A,B\rangle)
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`u=(x,y)`),
        " と書けば",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u+\overline{u}
&= (x,y)+(x,-y)
   \quad (\because u=(x,y) \text{ と複素共役の定義}) \\
&= (2x,\ 0)
   \quad (\because \mathbb{C} \text{ の加法の定義と } \mathbb{R} \text{ の計算}) \\
&= \left(2\,\mathrm{Re}(u)\right)_{\mathbb{C}}
   \quad (\because \mathrm{Re} \text{ の定義と } \mathbb{R}\to\mathbb{C} \text{ の包含写像})
\end{aligned}`,
      ),
      paragraph(["であるから、"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\|A+B\|^2\right)_{\mathbb{C}}
&= \left(\|A\|^2\right)_{\mathbb{C}}
   + \left(u+\overline{u}\right)
   + \left(\|B\|^2\right)_{\mathbb{C}}
   \quad (\because \text{上の 3 段の鎖}) \\
&= \left(\|A\|^2\right)_{\mathbb{C}}
   + \left(2\,\mathrm{Re}(u)\right)_{\mathbb{C}}
   + \left(\|B\|^2\right)_{\mathbb{C}}
   \quad (\because u+\overline{u} \text{ の鎖}) \\
&= \left(\|A\|^2+2\,\mathrm{Re}(u)+\|B\|^2\right)_{\mathbb{C}}
   \quad (\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ は加法を保つ})
\end{aligned}`,
      ),
      paragraph([
        "である。したがって、Step 0 の ",
        math(String.raw`\mathrm{Re}(u)\le|u|`),
        " と Step 5 の (4) を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A+B\|^2
&= \|A\|^2+2\,\mathrm{Re}(u)+\|B\|^2
   \quad (\because \text{上の鎖と } \blkref{inclusion_rr_to_cc_is_injective}\ (a \to \|A+B\|^2,\ b \to \|A\|^2+2\,\mathrm{Re}(u)+\|B\|^2)) \\
&\le \|A\|^2+2|u|+\|B\|^2
   \quad (\because \text{Step 0 の } \mathrm{Re}(u)\le |u|) \\
&\le \|A\|^2+2\|A\|\,\|B\|+\|B\|^2
   \quad (\because \text{Step 5 の Cauchy--Schwarz の不等式}) \\
&= \left(\|A\|+\|B\|\right)^2
   \quad (\because \mathbb{R} \text{ の分配律})
\end{aligned}`,
      ),
      paragraph([
        "となる。両辺とも非負実数（",
        math(String.raw`0\le\|A+B\|`),
        "、",
        math(String.raw`0\le\|A\|+\|B\|`),
        "。ノルムの非負性）なので、含意の鎖",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\|A+B\|^2\le\left(\|A\|+\|B\|\right)^2
   &&(\because\ \text{上の鎖}) \\
\Longrightarrow\ &\|A+B\|\le\|A\|+\|B\|
   &&(\because\ \text{非負実数の平方の単調性（「ノルムの基本性質（非退化性・斉次性・三角不等式）」の証明 Step 0）を } u=\|A+B\|,\ v=\|A\|+\|B\| \text{ に当てた})
\end{aligned}`,
      ),
      paragraph([
        "により (5) が従う（Step 0 の補題は ",
        ref("matrix_norm_triangle_inequality"),
        " の証明にある）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文が TODO のまま残していた M(n;C) の内積" +
          "（labels: def_frobenius_inner_product）を定義した以上、それが Hermite 内積の公理を" +
          "満たすこと、および Cauchy--Schwarz からノルムの三角不等式が導かれることを" +
          "明示的に証明しておく必要があるため追加した。",
        "2026-09-04 の式変形統一で、Step 5 場合 2 の三つの積の項の計算の前に散文でまとめて" +
          "いた代入根拠（(1) の ⟨B,A⟩=ū、(3) の ⟨B,B⟩・⟨A,A⟩、Step 0 による t̄ の表示）を、" +
          "それぞれを使う式変形行の行末の (∵ …) へ移した。内容・式変形・根拠は変えていない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: Step 5 と Step 6 で名前だけで根拠にしていた「ι_{ℝ→ℂ} の単射性」の 2 か所を、inclusion_rr_to_cc_is_injective への参照（a・b の当てはめ付き）に替えた。内容は変えていない。",
        "2026-11-11（Lean の通しの証明のゴールラインの確認）: Step 5 場合 2 の t := ū/(‖B‖²)_ℂ を β := ‖B‖² と def_complex_quotient で t = ū(β_ℂ)^{-1} と開き、β_ℂ ∈ ℂ^× と (β^{-1})_ℂ = (β_ℂ)^{-1} を新しい主張 real_inclusion_preserves_inverse から取った。三つの積の項の鎖の「約分」「ι_{ℝ→ℂ} が積と逆元を保つこと」「Step 0 による t̄ の表示」を、準備 t̄ = u(β_ℂ)^{-1}（complex_conjugate_of_product・complex_conjugate_of_inverse・complex_conjugate_of_real_inclusion）と準備 (ūu)(β_ℂ)^{-1} = q_ℂ（complex_conjugate_times_self・real_inclusion_preserves_product。q := |u|²/‖B‖²）と、積の結合律・可換律・逆元・単位元の 1 段ずつに開いた。三つの項の鎖は符号を付けない t⟨A,B⟩・t̄⟨B,A⟩・t̄t⟨B,B⟩ から始め、合わせる鎖は展開式の右辺から 1 行に 1 つずつ代入し、「ℂ の加法の結合律と加法逆元」を def_complex_difference と complex_numbers_form_a_field の結合律・加法逆元・単位元の行に、「ι_{ℝ→ℂ} が減法を保つこと」を real_inclusion_preserves_difference にした。主張と Step 5 の結論は変えていない。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_004_theorem_ad_binomial",
    kind: "theorem",
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/003_theorem_ad展開の二項定理的公式_BrianHall_exercise14.typ",
      ordinal: 4,
    },
    title: { text: "ad 展開の二項定理的公式（Brian Hall exercise 14）" },
    labels: ["ad_binomial"],
    statement: [
      paragraph(["行列の積は ", ref("mat_mult"), " の成分計算による。"]),
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " もしくは ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`d \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X, Y \in M(K,d) := \mathrm{Mat}(d,K)`),
        " とする。交換子を ",
        math(String.raw`[P,Q] := PQ-QP \in \mathrm{Mat}(d,K)`),
        " と定め、",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " 重の交換子 ",
        math(String.raw`\mathrm{ad}_X^{m}(Y)\in\mathrm{Mat}(d,K)`),
        " を ",
        math(String.raw`m`),
        " についての再帰で",
      ]),
      displayMath(
        String.raw`\mathrm{ad}_X^{0}(Y) := Y,
\qquad
\mathrm{ad}_X^{m+1}(Y) := \left[X,\ \mathrm{ad}_X^{m}(Y)\right]
\quad (m\in\mathbb{Z}_{\ge 0})`,
      ),
      paragraph([
        "と定める（すなわち ",
        math(String.raw`\mathrm{ad}_X^{m}(Y)=\underbrace{[X,[X,\dots,[X,Y]\dots]]}_{m\text{ times}}`),
        " であり、",
        math(String.raw`m=0`),
        " のときは括弧を付けずに ",
        math(String.raw`Y`),
        " そのものとする規約である）。また ",
        math(String.raw`P^0 := I`),
        "（単位行列）、",
        math(String.raw`\binom{m}{k} := \dfrac{m!}{k!\,(m-k)!}\in\mathbb{Z}_{\ge 1}`),
        "（",
        math(String.raw`0\le k\le m`),
        "）、および ",
        math(String.raw`k<0`),
        " または ",
        math(String.raw`k>m`),
        " のとき ",
        math(String.raw`\binom{m}{k} := 0`),
        " と約束する。このとき次が成り立つ。",
      ]),
      displayMath(
        String.raw`\underbrace{[X,[X,\dots,[X,Y]\dots]]}_{m\text{ times}}
= \mathrm{ad}_X^{m}(Y)
= \sum_{k=0}^{m} \binom{m}{k} X^k Y (-X)^{m-k}
\qquad (m\in\mathbb{Z}_{\ge 0})`,
      ),
    ],
    proof: [
      paragraph([
        "この主張は ",
        math(String.raw`\mathrm{Mat}(d,K)`),
        " の環構造（加法・乗法・分配律・結合律）と ",
        math(String.raw`K`),
        " のスカラー倍だけを使う純代数的な主張であり、収束・極限は一切使わない。",
        math(String.raw`m`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "Step 0: 準備（符号の処理）。",
        math(String.raw`l\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`(-X)^l=(-1)^l X^l`),
        " であり（",
        math(String.raw`-X=(-1)X`),
        " と、スカラー ",
        math(String.raw`(-1)\in K`),
        " が行列と可換であることによる ",
        math(String.raw`l`),
        " についての帰納法）、",
        math(String.raw`X`),
        " は自分自身と可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-X)^{l}\,X
&= (-1)^{l}X^{l}X
   \quad (\because (-X)^{l}=(-1)^{l}X^{l}) \\
&= (-1)^{l}X^{l+1}
   \quad (\because \text{冪の定義}) \\
&= -\left((-1)^{l+1}X^{l+1}\right)
   \quad (\because (-1)^{l}=-(-1)^{l+1}) \\
&= -(-X)^{l+1}
   \quad (\because (-X)^{l+1}=(-1)^{l+1}X^{l+1})
\end{aligned}`,
      ),
      paragraph([
        "Step 1: 準備（Pascal の法則）。",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`k\in\mathbb{Z}`),
        " について",
      ]),
      displayMath(
        String.raw`\binom{m}{k-1}+\binom{m}{k}=\binom{m+1}{k}`,
      ),
      paragraph([
        "が成り立つ。実際、",
        math(String.raw`1\le k\le m`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\binom{m}{k-1}+\binom{m}{k}
&= \frac{m!}{(k-1)!\,(m-k+1)!}+\frac{m!}{k!\,(m-k)!}
   \quad (\because \text{二項係数の定義}) \\
&= \frac{m!\cdot k}{k!\,(m+1-k)!}+\frac{m!\cdot (m+1-k)}{k!\,(m+1-k)!}
   \quad \left(\because k!=k\cdot(k-1)!,\ (m+1-k)!=(m+1-k)\cdot(m-k)!\right) \\
&= \frac{m!\left(k+(m+1-k)\right)}{k!\,(m+1-k)!}
   \quad (\because \text{分配律}) \\
&= \frac{m!\,(m+1)}{k!\,(m+1-k)!}
   \quad (\because k+(m+1-k)=m+1) \\
&= \frac{(m+1)!}{k!\,(m+1-k)!}
   \quad (\because (m+1)!=(m+1)\cdot m!) \\
&= \binom{m+1}{k}
   \quad (\because \text{二項係数の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k=0`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\binom{m}{-1}+\binom{m}{0}
&= 0+\binom{m}{0}
   \quad (\because k<0 \text{ のとき } \binom{m}{k}:=0 \text{ という約束}) \\
&= \binom{m}{0}
   \quad (\because \text{零元との和}) \\
&= 1
   \quad (\because \text{二項係数の定義と } 0!=1) \\
&= \binom{m+1}{0}
   \quad (\because \text{二項係数の定義と } 0!=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k=m+1`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\binom{m}{m}+\binom{m}{m+1}
&= \binom{m}{m}+0
   \quad (\because k>m \text{ のとき } \binom{m}{k}:=0 \text{ という約束}) \\
&= \binom{m}{m}
   \quad (\because \text{零元との和}) \\
&= 1
   \quad (\because \text{二項係数の定義と } 0!=1) \\
&= \binom{m+1}{m+1}
   \quad (\because \text{二項係数の定義と } 0!=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k<0`),
        " または ",
        math(String.raw`k>m+1`),
        " のときは、",
        math(String.raw`\binom{m}{k-1}`),
        " も ",
        math(String.raw`\binom{m}{k}`),
        " も ",
        math(String.raw`\binom{m+1}{k}`),
        " も約束により ",
        math(String.raw`0`),
        " なので、両辺とも ",
        math(String.raw`0`),
        " である。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`m=0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{k=0}^{0}\binom{0}{k}X^{k}Y(-X)^{0-k}
&= \binom{0}{0}X^{0}Y(-X)^{0}
   \quad (\because \text{和の項が } k=0 \text{ の 1 つだけである}) \\
&= 1\cdot X^{0}Y(-X)^{0}
   \quad (\because \binom{0}{0}=1) \\
&= 1\cdot I\,Y\,I
   \quad (\because P^{0}:=I \text{ という約束}) \\
&= Y
   \quad (\because \text{単位行列との積とスカラー } 1 \text{ 倍}) \\
&= \mathrm{ad}_X^{0}(Y)
   \quad (\because \mathrm{ad}_X^{0} \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 帰納段階。ある ",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{ad}_X^{m}(Y)=\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k}`,
      ),
      paragraph([
        "が成り立つと仮定する（帰納法の仮定）。定義と分配律より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}_X^{m+1}(Y)
&= \left[X,\ \mathrm{ad}_X^{m}(Y)\right]
   \quad (\because \mathrm{ad}_X^{m+1} \text{ の定義}) \\
&= X\,\mathrm{ad}_X^{m}(Y)-\mathrm{ad}_X^{m}(Y)\,X
   \quad (\because [P,Q]=PQ-QP) \\
&= X\left(\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k}\right)
   -\left(\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k}\right)X
   \quad (\because \text{帰納法の仮定}) \\
&= \sum_{k=0}^{m}\binom{m}{k}X^{k+1}Y(-X)^{m-k}
   -\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k}X
   \quad (\because \text{分配律・結合律・スカラーの可換性})
\end{aligned}`,
      ),
      paragraph(["第 2 項に Step 0 を ", math(String.raw`l=m-k`), " として適用すると"]),
      displayMath(
        String.raw`\begin{aligned}
-\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k}X
&= -\sum_{k=0}^{m}\binom{m}{k}X^{k}Y\left(-(-X)^{m+1-k}\right)
   \quad (\because \text{Step 0}) \\
&= \sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m+1-k}
   \quad (\because \text{符号の反転が 2 度で打ち消し合うこと})
\end{aligned}`,
      ),
      paragraph([
        "第 1 項は添字を ",
        math(String.raw`j:=k+1`),
        "（",
        math(String.raw`k=0,\dots,m`),
        " に対し ",
        math(String.raw`j=1,\dots,m+1`),
        "）と付け替えると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{k=0}^{m}\binom{m}{k}X^{k+1}Y(-X)^{m-k}
&= \sum_{j=1}^{m+1}\binom{m}{j-1}X^{j}Y(-X)^{m+1-j}
   \quad (\because \text{添字の付け替え } j:=k+1 \text{（全単射なので和の値は変わらない）})
\end{aligned}`,
      ),
      paragraph([
        "第 2 項の添字を ",
        math(String.raw`j:=k`),
        " と書き換え、",
        math(String.raw`\binom{m}{-1}=0`),
        "、",
        math(String.raw`\binom{m}{m+1}=0`),
        " の約束により両方の和の範囲を ",
        math(String.raw`j=0,\dots,m+1`),
        " に揃えると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}_X^{m+1}(Y)
&= \sum_{j=0}^{m+1}\binom{m}{j-1}X^{j}Y(-X)^{m+1-j}
   +\sum_{j=0}^{m+1}\binom{m}{j}X^{j}Y(-X)^{m+1-j}
   \quad (\because \binom{m}{-1}=0,\ \binom{m}{m+1}=0 \text{ の約束により足した項が } 0 \text{ である}) \\
&= \sum_{j=0}^{m+1}\left(\binom{m}{j-1}+\binom{m}{j}\right)X^{j}Y(-X)^{m+1-j}
   \quad (\because \text{分配律}) \\
&= \sum_{j=0}^{m+1}\binom{m+1}{j}X^{j}Y(-X)^{m+1-j}
   \quad (\because \text{Step 1: Pascal の法則})
\end{aligned}`,
      ),
      paragraph([
        "これは ",
        math(String.raw`m+1`),
        " についての主張である。したがって帰納法により、すべての ",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " について主張が成り立つ。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）の proof は「TODO: 帰納法で行ける」だけで、原文 note に" +
          "「このリポジトリでは未証明。証明の根拠として使用することは禁止する」とあった。" +
          "本ブロックで m についての帰納法（Pascal の法則を明示）により証明を完成させたので、" +
          "その使用禁止の注記は撤回した。labels: ad_binomial を付け、" +
          "labels: matrix_exp_conjugation の証明から参照している。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix",
    kind: "definition",
    origin: { path: "structured-latex/content/005_exp_conjugation_proof.ts", ordinal: 7 },
    title: { tex: String.raw`\mathrm{ad}_X \text{ と } \mathrm{Ad}_g \text{ の定義（複素行列）}` },
    labels: ["def_ad_X_matrix"],
    statement: [
      paragraph(["行列の積は ", ref("mat_mult"), " による。"]),
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`\mathrm{M}(n,\mathbb{C}) := \mathrm{Mat}(n,\mathbb{C})`),
        " は ",
        ref("def_frobenius_inner_product"),
        " のもの（成分が ",
        ref("definition_of_cc"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " に属する ",
        math(String.raw`n\times n`),
        " 行列全体）とする。交換子は ",
        ref("ad_binomial"),
        " と同じく ",
        math(String.raw`[P,Q] := PQ-QP\in\mathrm{M}(n,\mathbb{C})`),
        " とする。",
      ]),
      paragraph([
        "（1）",
        math(String.raw`X\in\mathrm{M}(n,\mathbb{C})`),
        " に対し、写像 ",
        math(String.raw`\mathrm{ad}_X`),
        " を",
      ]),
      displayMath(
        String.raw`\mathrm{ad}_X : \mathrm{M}(n,\mathbb{C}) \to \mathrm{M}(n,\mathbb{C}),
\quad Y \mapsto [X, Y] = XY - YX`,
      ),
      paragraph([
        "と定める（右辺は ",
        math(String.raw`\mathrm{M}(n,\mathbb{C})`),
        " の積と差だけで定まるので、",
        math(String.raw`\mathrm{ad}_X`),
        " は well-defined である）。",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " 重の反復 ",
        math(String.raw`\mathrm{ad}_X^{m}`),
        " は ",
        ref("ad_binomial"),
        " の再帰 ",
        math(String.raw`\mathrm{ad}_X^{0}(Y)=Y,\ \mathrm{ad}_X^{m+1}(Y)=[X,\mathrm{ad}_X^{m}(Y)]`),
        " による。",
      ]),
      paragraph([
        "（2）",
        math(String.raw`g\in\mathrm{M}(n,\mathbb{C})`),
        " が正則（すなわち、",
        math(String.raw`I := I_{\mathrm{Mat}(n,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        "）として ",
        math(String.raw`gh=hg=I`),
        " を満たす ",
        math(String.raw`h\in\mathrm{M}(n,\mathbb{C})`),
        " が存在し、この ",
        math(String.raw`h`),
        " を ",
        math(String.raw`g^{-1}`),
        " と書く）であるとき、写像 ",
        math(String.raw`\mathrm{Ad}_g`),
        " を",
      ]),
      displayMath(
        String.raw`\mathrm{Ad}_g : \mathrm{M}(n,\mathbb{C}) \to \mathrm{M}(n,\mathbb{C}),
\quad Y \mapsto g\,Y\,g^{-1}`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`g^{-1}`),
        " は存在すれば一意である。実際 ",
        math(String.raw`h,h'`),
        " がともに逆行列なら",
      ]),
      displayMath(
        String.raw`\begin{aligned}
h
&=hI
  \quad (\because \blkref{identity_matrix_is_right_unit_of_mat_mult}) \\
&=h(gh')
  \quad (\because gh'=I) \\
&=(hg)h'
  \quad (\because \blkref{mat_mult_associative}) \\
&=Ih'
  \quad (\because hg=I) \\
&=h'
  \quad (\because \blkref{identity_matrix_is_left_unit_of_mat_mult})
\end{aligned}`,
      ),
      paragraph([
        "である。したがって右辺は ",
        math(String.raw`\mathrm{M}(n,\mathbb{C})`),
        " の積だけで一意に定まる）。",
      ]),
      paragraph([
        "この定義に Lie 群・Lie 環は現れない。必要なのは ",
        math(String.raw`\mathrm{M}(n,\mathbb{C})`),
        " の和・積と、逆行列の存在だけである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "もとは Brian Hall Definition 3.32 に沿って Matrix Lie群 G 上の Ad_g : G→G として" +
          "定義していた（旧ブロック exp_conjugation_proof_007_definition_Ad_g_ad_X_matrix）。" +
          "README のゴール設定によりリー群の経路を本文から外したので、同じ labels: def_ad_X_matrix で" +
          "複素行列だけを使う具体版へ置き換えた。旧ブロックは " +
          "structured-latex/notes/005_exp_conjugation_lie_route.ts に原文のまま退避してある。",
        "2026-11-02: 逆行列の一意性の鎖で、名前だけの根拠「単位行列との右からの積」「単位行列との左からの積」を identity_matrix_is_right_unit_of_mat_mult・identity_matrix_is_left_unit_of_mat_mult へのラベル参照に、「行列積の結合律」を mat_mult_associative へのラベル参照に替え、正則の定義の I が I_{Mat(n,C)}（def_identity_matrix）であることを書いた。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_claim_commutator_of_scalar_multiples",
    kind: "claim",
    title: { text: "スカラー倍どうしの交換子は、係数の積のスカラー倍に等しい" },
    labels: ["commutator_of_scalar_multiples"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`\alpha, \beta \in \mathbb{C}`),
        "、",
        math(String.raw`X, W \in \mathrm{Mat}(n,\mathbb{C})`),
        " とする。交換子 ",
        math(String.raw`[P, Q] := PQ - QP`),
        " は ",
        ref("def_ad_X_matrix"),
        " のもの、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        " のものである。このとき",
      ]),
      displayMath(String.raw`[\alpha X, \beta W] = (\alpha\beta)[X, W]`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
[\alpha X, \beta W]
&= (\alpha X)(\beta W) - (\beta W)(\alpha X)
&&\bigl(\because\ \text{交換子の定義。}\blkref{def_ad_X_matrix}\bigr)\\
&= \alpha\bigl(X(\beta W)\bigr) - (\beta W)(\alpha X)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\bigr)\\
&= \alpha\bigl(\beta(XW)\bigr) - (\beta W)(\alpha X)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&= (\alpha\beta)(XW) - (\beta W)(\alpha X)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= (\alpha\beta)(XW) - \beta\bigl(W(\alpha X)\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\bigr)\\
&= (\alpha\beta)(XW) - \beta\bigl(\alpha(WX)\bigr)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&= (\alpha\beta)(XW) - (\beta\alpha)(WX)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= (\alpha\beta)(XW) - (\alpha\beta)(WX)
&&\bigl(\because\ \mathbb{C}\text{ の積の可換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= (\alpha\beta)(XW - WX)
&&\bigl(\because\ \blkref{scalar_multiple_distributes_over_matrix_difference}\bigr)\\
&= (\alpha\beta)[X, W]
&&\bigl(\because\ \text{交換子の定義。}\blkref{def_ad_X_matrix}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。nesting_of_commutator_of_H_and_check_Z の証明の冒頭の準備（交換子の双線型性）と同じ事実を cosh_sinh_coefficient_conversion_for_check の証明も使うので、全証明の SageMath 検算の単位で独立の主張に切り出し、二つの証明から引く形にした（鎖の中身は準備のものと同じ）。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/005_exp_conjugation_proof.ts", ordinal: 9 },
    title: {
      tex: String.raw`\text{行列版: } \exp(X) Y \exp(-X) = \exp(\mathrm{ad}_X)(Y)`,
    },
    labels: ["matrix_exp_conjugation"],
    statement: [
      paragraph(["行列積は ", ref("mat_mult"), "、複素成分の演算は ", ref("complex_numbers_form_a_field"), "、実数係数の包含は ", ref("inclusion_rr_to_cc"), "、ノルムの積の評価は ", ref("matrix_norm_submultiplicativity"), " を用いる。"]),
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`X, Y\in\mathrm{Mat}(n,\mathbb{C})`),
        " とする。ノルム ",
        math(String.raw`\|\cdot\|`),
        " と収束は ",
        ref("def_matrix_norm"),
        "、",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        "、",
        math(String.raw`\mathrm{ad}_X`),
        " は ",
        ref("def_ad_X_matrix"),
        "（",
        math(String.raw`\mathrm{ad}_X(Z)=[X,Z]=XZ-ZX`),
        "）、",
        math(String.raw`\mathrm{ad}_X^{m}`),
        " は ",
        ref("ad_binomial"),
        " の ",
        math(String.raw`m`),
        " 重交換子とする。このとき次が成り立つ。",
      ]),
      list([
        [
          "(1) 級数 ",
          math(String.raw`\displaystyle\sum_{m=0}^{\infty}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)`),
          " は ",
          math(String.raw`\mathrm{Mat}(n,\mathbb{C})`),
          " において収束し、",
        ],
        [
          "(2) ",
          math(String.raw`\displaystyle \exp(X)\,Y\,\exp(-X)
= \sum_{m=0}^{\infty}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)
= \exp\!\left(\mathrm{ad}_X\right)(Y)`),
          "。",
        ],
        [
          "(3) さらに ",
          math(String.raw`\exp(X)`),
          " は正則で ",
          math(String.raw`\exp(X)^{-1}=\exp(-X)`),
          " であるから、",
          math(String.raw`\mathrm{Ad}_{\exp(X)}(Y):=\exp(X)\,Y\,\exp(X)^{-1}=\exp(\mathrm{ad}_X)(Y)`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`a:=\|X\|\in\mathbb{R}_{\ge 0}`),
        " とおき、",
        ref("real_exp_series_converges"),
        " の記号 ",
        math(String.raw`E_N(a)=\sum_{m=0}^{N}a^m/m!`),
        "、",
        math(String.raw`E(a)=\lim_{N\to\infty}E_N(a)`),
        "、",
        math(String.raw`R_N(a)=E(a)-E_N(a)`),
        " を使う。また ",
        math(String.raw`N\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`A\in\mathrm{Mat}(n,\mathbb{C})`),
        " について ",
        math(String.raw`S_N(A):=\sum_{p=0}^{N}\frac{1}{p!}A^{p}\in\mathrm{Mat}(n,\mathbb{C})`),
        "（",
        math(String.raw`A^0:=I`),
        "）とおく。",
        ref("matrix_exp_series_converges"),
        " より ",
        math(String.raw`S_N(X)\to\exp(X)`),
        "、",
        math(String.raw`S_N(-X)\to\exp(-X)`),
        "。この二つの収束と、後で使う実指数級数の剰余 ",
        math(String.raw`R_N(a)\to 0`),
        " の根拠は ",
        math(String.raw`\mathbb{R}`),
        " の完備性（",
        ref("matrix_completeness"),
        " および ",
        ref("real_exp_series_converges"),
        "）へ遡る。さらに Step 2 では収束する実数列の有界性、有界列と 0 収束列の積、および 0 収束列の有限和を使う。Step 5 では ",
        math(String.raw`\lfloor N/2\rfloor\to\infty`),
        " に沿う 0 収束、0 収束列の非負定数倍、およびはさみうちを使う。Step 6 では 0 収束列の和と、",
        ref("matrix_norm_triangle_inequality"),
        " (4) の極限一意性を使う。したがって非可算集合 ",
        math(String.raw`\mathbb{R}/\mathbb{C}`),
        " の解析へ移る箇所は、これらの実数列・行列列の極限操作であり、それ以外は有限和の代数計算である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\mathrm{ad}_X`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型。",
        math(String.raw`Z,W\in\mathrm{Mat}(n,\mathbb{C})`),
        "、",
        math(String.raw`c\in\mathbb{C}`),
        " について分配律より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}_X(Z+W)
&= X(Z+W)-(Z+W)X
&&(\because\ \mathrm{ad}_X \text{ の定義})\\
&= (XZ+XW)-(ZX+WX)
&&(\because\ \text{行列の積の分配律})\\
&= (XZ-ZX)+(XW-WX)
&&(\because\ \text{行列の加法の交換則と結合則})\\
&= \mathrm{ad}_X(Z)+\mathrm{ad}_X(W)
&&(\because\ \mathrm{ad}_X \text{ の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}_X(cZ)
&= X(cZ)-(cZ)X
&&(\because\ \mathrm{ad}_X \text{ の定義})\\
&= c(XZ)-(cZ)X
&&(\because\ \blkref{scalar_multiple_factors_out_of_right_factor})\\
&= c(XZ)-c(ZX)
&&(\because\ \blkref{scalar_multiple_factors_out_of_left_factor})\\
&= c(XZ-ZX)
&&(\because\ \blkref{scalar_multiple_distributes_over_matrix_difference}\ (A = XZ,\ B = ZX))\\
&= c\,\mathrm{ad}_X(Z)
&&(\because\ \mathrm{ad}_X \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\mathrm{ad}_X\in\mathrm{End}\!\left(\mathrm{Mat}(n,\mathbb{C})\right)`),
        " であり、",
        math(String.raw`\mathrm{Mat}(n,\mathbb{C})`),
        " は ",
        ref("def_matrix_norm"),
        " のノルムをもつ有限次元 ",
        math(String.raw`\mathbb{C}`),
        "-線型空間（次元 ",
        math(String.raw`n^2`),
        "）なので、",
        ref("def_exp"),
        " の ",
        math(String.raw`\exp(\mathrm{ad}_X)`),
        " が定義され、",
        ref("exp_converges"),
        " より",
      ]),
      displayMath(
        String.raw`\exp(\mathrm{ad}_X)(Y)
= \sum_{m=0}^{\infty}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)
= \lim_{N\to\infty}P_N,
\qquad
P_N := \sum_{m=0}^{N}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)`,
      ),
      paragraph([
        "である（右辺の収束は Step 6 で独立に示すので、循環はしない）。",
      ]),
      paragraph([
        "Step 2: 積の同時収束。",
        math(String.raw`C_N\to C`),
        "、",
        math(String.raw`D_N\to D`),
        " ならば ",
        math(String.raw`C_N D_N\to CD`),
        "。実際",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|C_N D_N-CD\right\|
&= \left\|C_N D_N-C_N D+C_N D-CD\right\|
   \quad (\because \text{中間項 } C_N D \text{ を引いて足した}) \\
&= \left\|C_N(D_N-D)+(C_N-C)D\right\|
   \quad (\because \text{行列の積の分配律}) \\
&\le \left\|C_N(D_N-D)\right\|+\left\|(C_N-C)D\right\|
   \quad (\because \text{三角不等式。}\blkref{matrix_norm_triangle_inequality}) \\
&\le \left\|C_N\right\|\left\|D_N-D\right\|+\left\|C_N-C\right\|\left\|D\right\|
   \quad (\because \text{行列ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|C_N\right\|
&= \left\|C+(C_N-C)\right\|
   \quad (\because C_N=C+(C_N-C)) \\
&\le \left\|C\right\|+\left\|C_N-C\right\|
   \quad (\because \text{三角不等式。}\blkref{matrix_norm_triangle_inequality})
\end{aligned}`,
      ),
      paragraph([
        "は ",
        math(String.raw`\|C_N-C\|\to 0`),
        " より有界（十分大きい ",
        math(String.raw`N`),
        " で ",
        math(String.raw`\|C_N-C\|\le 1`),
        " なので ",
        math(String.raw`\|C_N\|\le\|C\|+1`),
        "）だから、右辺は ",
        math(String.raw`0`),
        " に収束する。これを 2 回使って",
      ]),
      displayMath(
        String.raw`Q_N := S_N(X)\,Y\,S_N(-X) \longrightarrow \exp(X)\,Y\,\exp(-X)
\qquad (N\to\infty)`,
      ),
      paragraph([
        "（1 回目は ",
        math(String.raw`C_N=S_N(X),\ D_N=Y`),
        "（定数列）として ",
        math(String.raw`S_N(X)Y\to\exp(X)Y`),
        "、2 回目は ",
        math(String.raw`C_N=S_N(X)Y,\ D_N=S_N(-X)`),
        " として）。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`Q_N`),
        " と ",
        math(String.raw`P_N`),
        " の有限和表示。まず ",
        math(String.raw`(-X)^q=(-1)^qX^q`),
        " に注意すると、有限和の分配律より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Q_N
&= S_N(X)\,Y\,S_N(-X)
   \quad (\because Q_N \text{ の定義（Step 2）}) \\
&= \left(\sum_{p=0}^{N}\frac{1}{p!}X^{p}\right)Y\left(\sum_{q=0}^{N}\frac{1}{q!}(-X)^{q}\right)
   \quad (\because \text{部分和 } S_N \text{ の定義}) \\
&= \sum_{p=0}^{N}\sum_{q=0}^{N}\frac{1}{p!}\,\frac{1}{q!}\,X^{p}\,Y\,(-X)^{q}
   \quad (\because \text{有限和の分配律を 2 度。}\blkref{ad_binomial}\text{ の証明 Step 0}) \\
&= \sum_{p=0}^{N}\sum_{q=0}^{N}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q}
   \quad (\because \text{スカラーの積})
\end{aligned}`,
      ),
      paragraph([
        "一方 ",
        math(String.raw`\mathrm{ad}_X^{m}(Y)=\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k}`),
        " であり、各 ",
        math(String.raw`0\le k\le m`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\dfrac{1}{m!}\binom{m}{k}
&= \dfrac{1}{m!}\cdot\dfrac{m!}{k!\,(m-k)!}
   \quad (\because \text{二項係数の定義}) \\
&= \dfrac{1}{k!\,(m-k)!}
   \quad (\because \text{約分（}m!\ne0\text{）})
\end{aligned}`,
      ),
      paragraph([
        "であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_N
&= \sum_{m=0}^{N}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)
   \quad (\because P_N \text{ の定義（Step 1）}) \\
&= \sum_{m=0}^{N}\frac{1}{m!}\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k}
   \quad (\because \text{ad の二項展開。}\blkref{ad_binomial}) \\
&= \sum_{m=0}^{N}\sum_{k=0}^{m}\frac{1}{m!}\binom{m}{k}\,X^{k}\,Y\,(-X)^{m-k}
   \quad (\because \text{有限和の分配律}) \\
&= \sum_{m=0}^{N}\sum_{k=0}^{m}\frac{1}{k!\,(m-k)!}\,X^{k}\,Y\,(-X)^{m-k}
   \quad (\because \tfrac{1}{m!}\tbinom{m}{k}=\tfrac{1}{k!\,(m-k)!}) \\
&= \sum_{(p,q)\in T_N}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q},
\qquad T_N:=\left\{(p,q)\in\mathbb{Z}_{\ge 0}^{2} \;\middle|\; p+q\le N\right\}
   \quad (\because \text{添字の全単射 } (m,k)\mapsto(k,\ m-k))
\end{aligned}`,
      ),
      paragraph([
        "（最後の等号は ",
        math(String.raw`(m,k)\mapsto(p,q):=(k,\ m-k)`),
        " が ",
        math(String.raw`\{(m,k)\mid 0\le m\le N,\ 0\le k\le m\}`),
        " から ",
        math(String.raw`T_N`),
        " への全単射であることによる。逆写像は ",
        math(String.raw`(p,q)\mapsto(p+q,\ p)`),
        "）。",
        math(String.raw`T_N\subset\{0,\dots,N\}^2`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Q_N-P_N
&= \sum_{(p,q)\in\{0,\dots,N\}^{2}}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q}
   -\sum_{(p,q)\in T_N}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q}
   \quad (\because \text{上の 2 つの有限和表示}) \\
&= \sum_{(p,q)\in\{0,\dots,N\}^{2}\setminus T_N}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q}
   \quad (\because T_N\subset\{0,\dots,N\}^{2} \text{ による有限和の差}) \\
&= \sum_{(p,q)\in D_N}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q},
\qquad
D_N := \left\{(p,q) \;\middle|\; 0\le p,q\le N,\ p+q>N\right\}
   \quad (\because D_N \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4: 項ごとのノルム評価。",
        math(String.raw`p,q\in\mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\left\|X^{p}\,Y\,(-X)^{q}\right\| \le a^{p+q}\,\|Y\|`,
      ),
      paragraph([
        "が成り立つ。準備として ",
        math(String.raw`l\in\mathbb{Z}_{\ge 1}`),
        " について ",
        math(String.raw`\|X^{l}\|\le a^{l}`),
        " を ",
        math(String.raw`l`),
        " についての帰納法で示す。",
        math(String.raw`l=1`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|X^{1}\right\|
&= \|X\|
   \quad (\because X^{1}=X\ \text{（行列の冪の定義）}) \\
&= a
   \quad (\because a \text{ の定義}) \\
&= a^{1}
   \quad (\because a^{1}=a\ \text{（指数法則）})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`l`),
        " のとき ",
        math(String.raw`\|X^{l}\|\le a^{l}`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|X^{l+1}\right\|
&= \left\|X^{l}X\right\|
   \quad (\because \text{行列の冪の定義}) \\
&\le \left\|X^{l}\right\|\,\|X\|
   \quad (\because \text{ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity}) \\
&\le a^{l}\,\|X\|
   \quad (\because \text{帰納法の仮定}) \\
&= a^{l}\,a
   \quad (\because a \text{ の定義}) \\
&= a^{l+1}
   \quad (\because \text{指数法則})
\end{aligned}`,
      ),
      paragraph([
        "であるから、任意の ",
        math(String.raw`l\in\mathbb{Z}_{\ge 1}`),
        " について ",
        math(String.raw`\|X^{l}\|\le a^{l}`),
        " が成り立つ。符号を付けたものも同じ評価をもつ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|(-X)^{l}\right\|
&= \left\|(-1)^{l}X^{l}\right\|
   \quad (\because (-X)^{l}=(-1)^{l}X^{l}) \\
&= \left|(-1)^{l}\right|\,\left\|X^{l}\right\|
   \quad (\because \text{ノルムの斉次性。}\blkref{matrix_norm_triangle_inequality}) \\
&= \left\|X^{l}\right\|
   \quad (\because \left|(-1)^{l}\right|=1) \\
&\le a^{l}
   \quad (\because \text{直前の帰納法})
\end{aligned}`,
      ),
      paragraph([
        "以上を使って ",
        math(String.raw`p,q`),
        " の 4 つの場合を評価する。",
      ]),
      list([
        [
          math(String.raw`p\ge 1,\ q\ge 1`),
          " のとき",
          displayMath(
            String.raw`\begin{aligned}
\left\|X^{p}\,Y\,(-X)^{q}\right\|
&\le \left\|X^{p}\right\|\,\left\|Y\,(-X)^{q}\right\|
   \quad (\because \text{ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity}) \\
&\le \left\|X^{p}\right\|\,\|Y\|\,\left\|(-X)^{q}\right\|
   \quad (\because \text{ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity}) \\
&\le a^{p}\,\|Y\|\,\left\|(-X)^{q}\right\|
   \quad (\because \|X^{p}\|\le a^{p}) \\
&\le a^{p}\,\|Y\|\,a^{q}
   \quad (\because \|(-X)^{q}\|\le a^{q})
\end{aligned}`,
          ),
        ],
        [
          math(String.raw`p=0,\ q\ge 1`),
          " のとき",
          displayMath(
            String.raw`\begin{aligned}
\left\|X^{0}\,Y\,(-X)^{q}\right\|
&= \left\|Y\,(-X)^{q}\right\|
   \quad (\because X^{0}=I \text{ と } IY=Y) \\
&\le \|Y\|\,\left\|(-X)^{q}\right\|
   \quad (\because \text{ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity}) \\
&\le \|Y\|\,a^{q}
   \quad (\because \|(-X)^{q}\|\le a^{q}) \\
&= a^{0}\,\|Y\|\,a^{q}
   \quad (\because a^{0}=1)
\end{aligned}`,
          ),
        ],
        [
          math(String.raw`p\ge 1,\ q=0`),
          " のとき",
          displayMath(
            String.raw`\begin{aligned}
\left\|X^{p}\,Y\,(-X)^{0}\right\|
&= \left\|X^{p}\,Y\right\|
   \quad (\because (-X)^{0}=I \text{ と } YI=Y) \\
&\le \left\|X^{p}\right\|\,\|Y\|
   \quad (\because \text{ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity}) \\
&\le a^{p}\,\|Y\|
   \quad (\because \|X^{p}\|\le a^{p}) \\
&= a^{p}\,\|Y\|\,a^{0}
   \quad (\because a^{0}=1)
\end{aligned}`,
          ),
        ],
        [
          math(String.raw`p=q=0`),
          " のとき",
          displayMath(
            String.raw`\begin{aligned}
\left\|X^{0}\,Y\,(-X)^{0}\right\|
&= \|Y\|
   \quad (\because X^{0}=(-X)^{0}=I \text{ と } IYI=Y) \\
&= a^{0}\,\|Y\|\,a^{0}
   \quad (\because a^{0}=1)
\end{aligned}`,
          ),
        ],
      ]),
      paragraph([
        "いずれの場合も次が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|X^{p}\,Y\,(-X)^{q}\right\|
&\le a^{p}\,\|Y\|\,a^{q}
   \quad (\because \text{上の 4 つの場合}) \\
&= a^{p}\,a^{q}\,\|Y\|
   \quad (\because \text{実数の積の可換性}) \\
&= a^{p+q}\,\|Y\|
   \quad (\because \text{指数法則})
\end{aligned}`,
      ),
      paragraph([
        "Step 5: ",
        math(String.raw`\|Q_N-P_N\|\to 0`),
        "。",
        math(String.raw`N\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`L:=\left\lfloor N/2\right\rfloor`),
        "（",
        math(String.raw`2L\le N`),
        " を満たす最大の非負整数）とおく。",
        math(String.raw`(p,q)\in D_N`),
        " ならば ",
        math(String.raw`p\ge L+1`),
        " または ",
        math(String.raw`q\ge L+1`),
        " である（もし ",
        math(String.raw`p\le L`),
        " かつ ",
        math(String.raw`q\le L`),
        " なら ",
        math(String.raw`p+q\le 2L\le N`),
        " となり ",
        math(String.raw`p+q>N`),
        " に矛盾する）。したがって",
      ]),
      displayMath(
        String.raw`D_N \subset
\underbrace{\left\{(p,q) \mid L+1\le p\le N,\ 0\le q\le N\right\}}_{=:A_N}
\cup
\underbrace{\left\{(p,q) \mid 0\le p\le N,\ L+1\le q\le N\right\}}_{=:B_N}`,
      ),
      paragraph([
        "であり（",
        math(String.raw`N\ge 1`),
        " より ",
        math(String.raw`L\le N/2<N`),
        " すなわち ",
        math(String.raw`L+1\le N`),
        " なので ",
        math(String.raw`A_N,B_N`),
        " は空でない）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|Q_N-P_N\right\|
&\le \sum_{(p,q)\in D_N}\frac{1}{p!\,q!}\left\|X^{p}Y(-X)^{q}\right\|
   \quad (\because \text{三角不等式・斉次性。}\blkref{matrix_norm_triangle_inequality}) \\
&\le \|Y\|\sum_{(p,q)\in D_N}\frac{a^{p}}{p!}\cdot\frac{a^{q}}{q!}
   \quad (\because \text{Step 4}) \\
&\le \|Y\|\left(\sum_{(p,q)\in A_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}
   +\sum_{(p,q)\in B_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}\right)
   \quad (\because D_N\subset A_N\cup B_N,\ \text{各項} \ge 0)
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`\sum_{q=0}^{N}\frac{a^{q}}{q!}=E_N(a)\le E(a)`),
        " かつ ",
        math(String.raw`\sum_{p=L+1}^{N}\frac{a^{p}}{p!}\le R_{L}(a)`),
        "（(3) の後半を ",
        math(String.raw`p=L+1\ge 1,\ q=N`),
        " として適用）であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{(p,q)\in A_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}
&= \left(\sum_{p=L+1}^{N}\frac{a^{p}}{p!}\right)\left(\sum_{q=0}^{N}\frac{a^{q}}{q!}\right)
   &&(\because\ \text{長方形の添字集合にわたる有限和の、積への分解（分配律）}) \\
&\le R_{L}(a)\left(\sum_{q=0}^{N}\frac{a^{q}}{q!}\right)
   &&(\because\ \sum_{p=L+1}^{N}\tfrac{a^{p}}{p!}\le R_{L}(a)\ \text{と}\ \sum_{q=0}^{N}\tfrac{a^{q}}{q!}\ge 0\text{。}\blkref{real_exp_series_converges}) \\
&= R_{L}(a)\,E_N(a)
   &&(\because\ E_N(a)\ \text{の定義}) \\
&\le R_{L}(a)\,E(a)
   &&(\because\ E_N(a)\le E(a)\ \text{と}\ R_{L}(a)\ge 0\text{。}\blkref{real_exp_series_converges})
\end{aligned}`,
      ),
      paragraph(["同じ 4 段を ", math(String.raw`B_N`), " について繰り返して"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{(p,q)\in B_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}
&= \left(\sum_{p=0}^{N}\frac{a^{p}}{p!}\right)\left(\sum_{q=L+1}^{N}\frac{a^{q}}{q!}\right)
   &&(\because\ \text{長方形の添字集合にわたる有限和の、積への分解（分配律）}) \\
&\le \left(\sum_{p=0}^{N}\frac{a^{p}}{p!}\right)R_{L}(a)
   &&(\because\ \sum_{q=L+1}^{N}\tfrac{a^{q}}{q!}\le R_{L}(a)\ \text{と}\ \sum_{p=0}^{N}\tfrac{a^{p}}{p!}\ge 0\text{。}\blkref{real_exp_series_converges}) \\
&= E_N(a)\,R_{L}(a)
   &&(\because\ E_N(a)\ \text{の定義}) \\
&\le E(a)\,R_{L}(a)
   &&(\because\ E_N(a)\le E(a)\ \text{と}\ R_{L}(a)\ge 0\text{。}\blkref{real_exp_series_converges})
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
\left\|Q_N-P_N\right\|
&\le \|Y\|\left(\sum_{(p,q)\in A_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}
   +\sum_{(p,q)\in B_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}\right)
   &&(\because\ \text{上の}\ \left\|Q_N-P_N\right\|\ \text{の評価の最後の行}) \\
&\le \|Y\|\bigl(R_{L}(a)\,E(a)+E(a)\,R_{L}(a)\bigr)
   &&(\because\ \text{直前の 2 つの評価と}\ \|Y\|\ge 0) \\
&= 2\,\|Y\|\,E(a)\,R_{L}(a)
   &&(\because\ \text{実数の積の可換性と}\ c+c=2c)
\end{aligned}`,
      ),
      paragraph([
        "である（",
        math(String.raw`L=\left\lfloor N/2\right\rfloor`),
        "）。",
      ]),
      paragraph([
        math(String.raw`N\to\infty`),
        " のとき ",
        math(String.raw`L=\lfloor N/2\rfloor\to\infty`),
        " であり、",
        ref("real_exp_series_converges"),
        " (3) より ",
        math(String.raw`R_{L}(a)\to 0`),
        "。",
        math(String.raw`2\|Y\|E(a)`),
        " は ",
        math(String.raw`N`),
        " によらない定数なので ",
        math(String.raw`\|Q_N-P_N\|\to 0`),
        "。",
      ]),
      paragraph([
        "Step 6: 結論。Step 2 より ",
        math(String.raw`\|Q_N-\exp(X)Y\exp(-X)\|\to 0`),
        "、Step 5 より ",
        math(String.raw`\|Q_N-P_N\|\to 0`),
        " である。ノルムの基本性質（",
        ref("matrix_norm_triangle_inequality"),
        " の (2)(3)）と実数列の評価により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|P_N-\exp(X)\,Y\,\exp(-X)\right\|
&= \left\|\left(P_N-Q_N\right)+\left(Q_N-\exp(X)\,Y\,\exp(-X)\right)\right\|
   &&(\because\ \text{行列の和の結合則と}\ (-Q_N)+Q_N=O) \\
&\le \left\|P_N-Q_N\right\|+\left\|Q_N-\exp(X)\,Y\,\exp(-X)\right\|
   &&(\because\ \text{ノルムの三角不等式。}\blkref{matrix_norm_triangle_inequality}) \\
&= \left\|Q_N-P_N\right\|+\left\|Q_N-\exp(X)\,Y\,\exp(-X)\right\|
   &&(\because\ \text{ノルムの斉次性を}\ c=-1\ \text{に取ること。}\blkref{matrix_norm_triangle_inequality}) \\
&\longrightarrow 0+0
   &&(\because\ \text{Step 5 と Step 2}) \\
&= 0
   &&(\because\ \text{実数の加法の単位元})
\end{aligned}`,
      ),
      paragraph([
        "であり、左辺は非負（",
        ref("matrix_norm_triangle_inequality"),
        " の (1)）なので ",
        math(String.raw`\left\|P_N-\exp(X)\,Y\,\exp(-X)\right\|\to 0`),
        "。すなわち ",
        math(String.raw`P_N\to\exp(X)Y\exp(-X)`),
        "。これは主張 (1)（級数の収束）と (2) の第 1 の等号 ",
        math(String.raw`\exp(X)Y\exp(-X)=\sum_{m=0}^{\infty}\frac{1}{m!}\mathrm{ad}_X^{m}(Y)`),
        " を与える。第 2 の等号は Step 1 の ",
        math(String.raw`\exp(\mathrm{ad}_X)(Y)=\lim_{N\to\infty}P_N`),
        " と極限の一意性（",
        ref("matrix_norm_triangle_inequality"),
        " (4)）による。",
      ]),
      paragraph([
        "Step 7: (3)。まず ",
        math(String.raw`X`),
        " と ",
        math(String.raw`-X`),
        " が交換することを見る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
X(-X)
&= -\left(XX\right)
   &&(\because\ \blkref{negation_factors_out_of_right_factor}\ (A = X,\ B = X)) \\
&= -X^2
   &&(\because\ \text{行列の冪の定義}) \\
&= -\left(XX\right)
   &&(\because\ \text{行列の冪の定義}) \\
&= (-X)X
   &&(\because\ \blkref{negation_factors_out_of_left_factor}\ (A = X,\ B = X))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(X)\exp(-X)
&= \exp\!\left(X+(-X)\right)
   &&(\because\ \text{可換な 2 つの行列の指数の積}\ \blkref{theorem_exp_product}\ \text{と、直前に示した}\ X(-X)=(-X)X) \\
&= \exp(O)
   &&(\because\ \text{行列の加法についての逆元}\ X+(-X)=O) \\
&= I
   &&(\because\ \text{零行列の指数は単位行列であること}\ \blkref{theorem_exp_zero})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(-X)\exp(X)
&= \exp\!\left((-X)+X\right)
   &&(\because\ \text{可換な 2 つの行列の指数の積}\ \blkref{theorem_exp_product}\ \text{と、直前に示した}\ (-X)X=X(-X)) \\
&= \exp(O)
   &&(\because\ \text{行列の加法についての逆元}\ (-X)+X=O) \\
&= I
   &&(\because\ \text{零行列の指数は単位行列であること}\ \blkref{theorem_exp_zero})
\end{aligned}`,
      ),
      paragraph([
        "2 つの積がどちらも ",
        math(String.raw`I`),
        " なので、逆行列の定義により ",
        math(String.raw`\exp(X)`),
        " は正則で ",
        math(String.raw`\exp(X)^{-1}=\exp(-X)`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{Ad}_{\exp(X)}(Y)
&= \exp(X)\,Y\,\exp(X)^{-1}
   &&(\because\ \mathrm{Ad}\ \text{の定義}) \\
&= \exp(X)\,Y\,\exp(-X)
   &&(\because\ \text{直前に示した}\ \exp(X)^{-1}=\exp(-X)) \\
&= \exp(\mathrm{ad}_X)(Y)
   &&(\because\ \text{Step 6 で示した (2)。}\ \mathrm{ad}_X\ \text{の定義は}\ \blkref{def_ad_X_matrix})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文は一般の Lie 群に対する " +
          "Ad(exp X)=exp(ad X) と Brian Hall Prop 3.35（Matrix Lie群版）を未証明のまま置いていたが、" +
          "本プロジェクトで実際に必要なのは複素行列環 Mat(n,C) 上の版だけである。" +
          "そちらは labels: ad_binomial / def_ad_X_matrix（交換子の純代数）、labels: def_matrix_norm / " +
          "matrix_norm_triangle_inequality / matrix_norm_submultiplicativity / matrix_completeness（ノルムと完備性）、" +
          "labels: real_exp_series_converges / matrix_exp_series_converges / exp_converges / def_exp（指数級数とその定義）、" +
          "labels: theorem_exp_product / theorem_exp_zero（可逆性）を使って完全に証明できるので、" +
        "Lie 群論を経由せずここで証明した。",
        "2026-09-04 の式変形統一で、指数の積・零行列の指数・ad_X の定義への後置き参照を削り、それぞれを使う行末の (∵ …) へ \\blkref を移した。内容・式変形・根拠は変えていない。",
        "2026-09-04 の式変形統一で、Step 4 の冪と項別ノルム評価に後置きしていた劣乗法性・斉次性の参照を、各適用行の末尾へ移した。内容・式変形・根拠は変えていない。",
        "2026-09-04 の式変形統一で、Step 5 の三角不等式・斉次性と指数級数の尾部評価に後置きしていた参照を、各適用行の末尾へ移した。内容・式変形・根拠は変えていない。",
        "2026-09-04 の式変形統一で、Step 6 の三角不等式と斉次性に前置きしていた参照を、各適用行の末尾へ移した。内容・式変形・根拠は変えていない。",
        "2026-09-04 の式変形統一で、Step 7 の指数の積の定理に前置きしていた参照段落を削った（各適用行の末尾に同じ \\blkref が既にある）。内容・式変形・根拠は変えていない。",
        "2026-11-02: Step 1 の ad_X(cZ) の鎖で、名前だけの根拠「スカラー倍と行列の積の両立」で 2 つの項を同時に変えていた 1 行を、scalar_multiple_factors_out_of_right_factor（X(cZ)=c(XZ)）と scalar_multiple_factors_out_of_left_factor（(cZ)X=c(ZX)）の 2 行に割ってラベル参照に替えた。",
        "2026-11-02: Step 1 の ad_X(cZ) の鎖の名前だけの根拠「スカラー倍の分配律」を scalar_multiple_distributes_over_matrix_difference へ、Step 7 の X(−X)=(−X)X の鎖の「行列のスカラー倍と積の両立を c=−1 に取ること」2 か所を negation_factors_out_of_right_factor・negation_factors_out_of_left_factor へのラベル参照に替えた（−X は def_matrix_negation の成分ごとの符号反転なので、(−1)X のスカラー倍としてではなく符号反転の主張として引く）。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_008_theorem_exp_ad_series",
    kind: "theorem",
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/007_theorem_exp(ad_X)(Y)の級数展開_BrianHall_Prop3.35.typ",
      ordinal: 8,
    },
    title: { tex: String.raw`\exp(\mathrm{ad}_X)(Y) \text{ の級数展開}` },
    labels: ["brianhall_exc14"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`\forall X, Y \in \mathrm{M}(n,\mathbb{C})`),
        " について考える。ここで ",
        math(String.raw`\mathrm{ad}_X:\mathrm{M}(n,\mathbb{C})\to\mathrm{M}(n,\mathbb{C})`),
        " は ",
        ref("def_ad_X_matrix"),
        " の写像 ",
        math(String.raw`Z\mapsto[X,Z]=XZ-ZX`),
        "、",
        math(String.raw`\mathrm{ad}_X^{m}`),
        "（",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        "）は ",
        ref("ad_binomial"),
        " の再帰 ",
        math(String.raw`\mathrm{ad}_X^{0}(Y)=Y,\ \mathrm{ad}_X^{m+1}(Y)=[X,\mathrm{ad}_X^{m}(Y)]`),
        " で定まる ",
        math(String.raw`m`),
        " 重交換子、",
        math(String.raw`\exp(\mathrm{ad}_X):=\exp(\mathrm{ad}_X)`),
        " は ",
        ref("def_exp"),
        " の指数写像を有限次元 ",
        math(String.raw`\mathbb{C}`),
        "-線型空間 ",
        math(String.raw`\mathrm{M}(n,\mathbb{C})`),
        "（次元 ",
        math(String.raw`n^2`),
        "、ノルムは ",
        ref("def_matrix_norm"),
        "）の自己準同型 ",
        math(String.raw`\mathrm{ad}_X`),
        " に適用したものとする。このとき右辺の級数は ",
        math(String.raw`\mathrm{M}(n,\mathbb{C})`),
        " において収束し、",
      ]),
      displayMath(
        String.raw`\exp(\mathrm{ad}_X)(Y)
= \sum_{n=0}^{\infty} \frac{1}{n!}
  \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{n\text{ times}}
= Y + [X,Y] + \tfrac{1}{2}[X,[X,Y]] + \tfrac{1}{6}[X,[X,[X,Y]]] + \cdots`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`Y`),
        " とする）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("matrix_exp_conjugation"),
        " を ",
        math(String.raw`K:=\mathbb{C}`),
        " として適用する（同ブロックは Lie 群論を使わず、",
        ref("ad_binomial"),
        "（純代数）と ",
        ref("real_exp_series_converges"),
        "・",
        ref("matrix_norm_submultiplicativity"),
        "・",
        ref("matrix_exp_series_converges"),
        " だけから証明されているので、循環しない）。",
      ]),
      paragraph([
        "Step 1: 記号の一致。",
        ref("ad_binomial"),
        " の再帰の定義より ",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}_X^{m}(Y)
&= \underbrace{\left[X,\left[X,\dots,\left[X,Y\right]\dots\right]\right]}_{m\text{ times}}
   \quad (\because \mathrm{ad}_X^m \text{ の再帰的定義}\ \blkref{ad_binomial})
\end{aligned}
\qquad (m=0 \text{ のときは } Y)`,
      ),
      paragraph([
        "であるから、主張の右辺は ",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}\mathrm{ad}_X^{m}(Y)`),
        " に他ならない。",
      ]),
      paragraph([
        "Step 2: 収束。",
        ref("matrix_exp_conjugation"),
        " (1) より、級数 ",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}\mathrm{ad}_X^{m}(Y)`),
        " は ",
        math(String.raw`\mathrm{M}(n,\mathbb{C})`),
        " において収束する。より正確には、同ブロックの証明 Step 6 で有限和 ",
        math(String.raw`P_N=\sum_{m=0}^{N}\frac{1}{m!}\mathrm{ad}_X^{m}(Y)`),
        " が ",
        math(String.raw`\exp(X)Y\exp(-X)`),
        " に収束することが示されている。",
      ]),
      paragraph([
        "Step 3: 等号。",
        ref("matrix_exp_conjugation"),
        " の証明 Step 1 より ",
        math(String.raw`\mathrm{ad}_X\in\mathrm{End}\!\left(\mathrm{M}(n,\mathbb{C})\right)`),
        " であり、",
        ref("def_exp"),
        " と ",
        ref("exp_converges"),
        " により ",
        math(String.raw`\exp(\mathrm{ad}_X)`),
        " が定まって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(\mathrm{ad}_X)(Y)
&= \exp\!\left(\mathrm{ad}_X\right)(Y)
   &&(\because\ \exp(\mathrm{ad}_X):=\exp(\mathrm{ad}_X)\ \text{という本定理の主張での記号の定め方}) \\
&= \lim_{N\to\infty}P_N
   &&(\because\ \text{指数写像の定義}\ \blkref{def_exp}\ \text{と級数の収束}\ \blkref{exp_converges}\ \text{および}\ \blkref{matrix_exp_conjugation}\ \text{の (2) の第 2 の等号。}\ P_N\ \text{は Step 2 の有限和}) \\
&= \sum_{m=0}^{\infty}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)
   &&(\because\ \text{無限級数の値は部分和の列の極限であること})
\end{aligned}`,
      ),
      paragraph(["が成り立つ。Step 1 の記号の一致と合わせて主張を得る。"]),
      paragraph([
        "解析（非可算集合 ",
        math(String.raw`\mathbb{R}/\mathbb{C}`),
        " の極限）を使うのは Step 2・Step 3 の極限操作だけであり、その根拠は ",
        ref("matrix_completeness"),
        "（",
        math(String.raw`\mathbb{R}`),
        " の完備性）である。Step 1 は ",
        math(String.raw`\mathrm{M}(n,\mathbb{C})`),
        " の環構造だけを使う純代数的な議論である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）の proof は Brian Hall Prop 3.35 への参照のみで、構造化側でも" +
          "「未証明につき使用禁止」の注記を置いていた。行列版 e^X Y e^{-X} = e^{ad_X}(Y)" +
        "（labels: matrix_exp_conjugation）をこのファイルで完全に証明済みであり、" +
          "本ブロックの主張はその (1)(2) の M(n,C) への特殊化にすぎないため、" +
          "証明を書いて使用禁止の注記を撤回した。statement 側にも、記号の所属集合" +
          "（ad_X の定義域・exp の適用先が有限次元線型空間の自己準同型であること）を明示した。",
        "2026-09-04 の式変形統一で、指数写像の定義・級数の収束・共役公式への後置き参照を削り、" +
          "それらを使う等号の行末の (∵ …) へ \\blkref を移した。内容・式変形・根拠は変えていない。",
      ],
    },
  },
]);
