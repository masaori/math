import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_Z_Y_anticommutation",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 8 },
    title: { text: "Pauli 行列の積と、クロネッカー積の反交換" },
    labels: [],
  },
  {
    id: "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    kind: "claim",
    origin: { path: "structured-latex/content/006_Z_Y_anticommutation.ts", ordinal: 1 },
    title: { text: "Pauli 行列の積" },
    labels: ["pauli_matrix_products"],
    statement: [
      paragraph([
        math(String.raw`2`),
        " 次の複素行列を",
      ]),
      displayMath(
        String.raw`\sigma^x=\begin{pmatrix}0&1\\1&0\end{pmatrix},\quad
\sigma^y=\begin{pmatrix}0&-i\\i&0\end{pmatrix},\quad
\sigma^z=\begin{pmatrix}1&0\\0&-1\end{pmatrix},\quad
I:=I_{\mathrm{Mat}(2,\mathbb{C})}=\begin{pmatrix}1&0\\0&1\end{pmatrix}
\ \in\mathrm{Mat}(2,\mathbb{C})`,
      ),
      paragraph([
        "とする（",
        math(String.raw`i \in \mathbb{C}`),
        " は ",
        ref("def_imaginary_unit"),
        " の虚数単位）。このとき ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`\sigma^x\sigma^x = \sigma^y\sigma^y = \sigma^z\sigma^z = I,`,
      ),
      displayMath(
        String.raw`\sigma^z\sigma^x = -\,\sigma^x\sigma^z,\qquad
\sigma^y\sigma^x = -\,\sigma^x\sigma^y,\qquad
\sigma^y\sigma^z = -\,\sigma^z\sigma^y`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "準備として ",
        math(String.raw`\mathbb{C}`),
        " の中で次を計算しておく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-i)\cdot i
&= -(i\cdot i)
&&(\because \mathbb{C} \text{ の乗法と符号の計算}) \\
&= -(-1)
&&(\because i\cdot i=-1\text{。}\blkref{def_imaginary_unit}\text{ の } i = (0_{\mathbb{R}}, 1_{\mathbb{R}})\text{ と }\blkref{definition_of_cc}\text{ の積}) \\
&= 1
&&(\because \mathbb{C} \text{ の符号の計算})
\end{aligned}`,
      ),
      paragraph(["続けて逆順の積を計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
i\cdot(-i)
&= (-i)\cdot i
&&(\because \mathbb{C} \text{ の乗法の可換律}) \\
&= 1
&&(\because \text{直前の鎖})
\end{aligned}`,
      ),
      paragraph([
        "反可換性の 3 式の右辺に現れる積も計算しておく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^z
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \sigma^x,\ \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}0&-1\\1&0\end{pmatrix}
&&(\because \blkref{mat_mult})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^y
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \sigma^x,\ \sigma^y \text{ の定義}) \\
&= \begin{pmatrix}i&0\\0&-i\end{pmatrix}
&&(\because \blkref{mat_mult})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \sigma^z,\ \sigma^y \text{ の定義}) \\
&= \begin{pmatrix}0&-i\\(-1)\cdot i&0\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&&(\because \blkref{multiply_by_minus_one})
\end{aligned}`,
      ),
      paragraph([
        "まず ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、",
        math(String.raw`\sigma^y\sigma^y = I`),
        "、",
        math(String.raw`\sigma^z\sigma^z = I`),
        " の 3 式を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^x
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}\delta_{11}&\delta_{12}\\\delta_{21}&\delta_{22}\end{pmatrix}
&&(\because \blkref{def_kronecker_delta}) \\
&= I
&&(\because \blkref{def_identity_matrix})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^y
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \sigma^y \text{ の定義}) \\
&= \begin{pmatrix}(-i)\cdot i&0\\0&i\cdot(-i)\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix}
&&(\because \text{上の準備}) \\
&= \begin{pmatrix}\delta_{11}&\delta_{12}\\\delta_{21}&\delta_{22}\end{pmatrix}
&&(\because \blkref{def_kronecker_delta}) \\
&= I
&&(\because \blkref{def_identity_matrix})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^z
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}1&0\\0&(-1)\cdot(-1)\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix}
&&(\because \mathbb{C} \text{ で } (-1)\cdot(-1)=1) \\
&= \begin{pmatrix}\delta_{11}&\delta_{12}\\\delta_{21}&\delta_{22}\end{pmatrix}
&&(\because \blkref{def_kronecker_delta}) \\
&= I
&&(\because \blkref{def_identity_matrix})
\end{aligned}`,
      ),
      paragraph(["次に反可換性の 3 式を、それぞれ左辺から計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^x
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \sigma^z,\ \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}0&1\\-1&0\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}-0&1\\-1&-0\end{pmatrix}
&&(\because \mathbb{C} \text{ で } 0=-0\text{。}-z\text{ は }\blkref{multiply_by_minus_one}\text{ の記号}) \\
&= \begin{pmatrix}-0&-(-1)\\-1&-0\end{pmatrix}
&&(\because \mathbb{C} \text{ で } 1=-(-1)\text{。}-z\text{ は }\blkref{multiply_by_minus_one}\text{ の記号}) \\
&= -\begin{pmatrix}0&-1\\1&0\end{pmatrix}
&&(\because \blkref{def_matrix_negation}) \\
&= -\,\sigma^x\sigma^z
&&(\because \text{上で計算した}\ \sigma^x\sigma^z)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \sigma^y,\ \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}-i&-0\\-0&i\end{pmatrix}
&&(\because \mathbb{C} \text{ で } 0=-0\text{。}-z\text{ は }\blkref{multiply_by_minus_one}\text{ の記号}) \\
&= \begin{pmatrix}-i&-0\\-0&-(-i)\end{pmatrix}
&&(\because \mathbb{C} \text{ で } i=-(-i)\text{。}-z\text{ は }\blkref{multiply_by_minus_one}\text{ の記号}) \\
&= -\begin{pmatrix}i&0\\0&-i\end{pmatrix}
&&(\because \blkref{def_matrix_negation}) \\
&= -\,\sigma^x\sigma^y
&&(\because \text{上で計算した}\ \sigma^x\sigma^y)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^z
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \sigma^y,\ \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}0&(-i)\cdot(-1)\\i&0\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}0&i\\i&0\end{pmatrix}
&&(\because \mathbb{C} \text{ で } (-i)\cdot(-1)=i) \\
&= \begin{pmatrix}-0&i\\i&-0\end{pmatrix}
&&(\because \mathbb{C} \text{ で } 0=-0\text{。}-z\text{ は }\blkref{multiply_by_minus_one}\text{ の記号}) \\
&= \begin{pmatrix}-0&-(-i)\\-(-i)&-0\end{pmatrix}
&&(\because \mathbb{C} \text{ で } i=-(-i)\text{。}-z\text{ は }\blkref{multiply_by_minus_one}\text{ の記号}) \\
&= -\begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&&(\because \blkref{def_matrix_negation}) \\
&= -\,\sigma^z\sigma^y
&&(\because \text{上で計算した}\ \sigma^z\sigma^y)
\end{aligned}`,
      ),
      paragraph([
        "以上で 6 式すべてが確かめられた。なお ",
        math(String.raw`\sigma^x\sigma^x = I`),
        " より ",
        math(String.raw`\sigma^x`),
        " は ",
        math(String.raw`\sigma^x`),
        " と可換であり、",
        math(String.raw`I`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " のすべての元 ",
        math(String.raw`A`),
        " と可換である（",
        ref("identity_matrix_is_left_unit_of_mat_mult"),
        " と ",
        ref("identity_matrix_is_right_unit_of_mat_mult"),
        " より ",
        math(String.raw`IA = A = AI`),
        "）。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文の [Z_μ,Z_ν]_+ の証明は σ^x σ^z = -σ^z σ^x を" +
          "無根拠に使っており、[Z_μ,Y_ν]_+ / [Y_μ,Y_ν]_+ ではさらに σ^y σ^x, σ^y σ^z の" +
          "反可換性と σ^y σ^y = I が要る。参照先を作るため、単一サイトの積公式を独立の主張として切り出した。",
        "2026-11-01: 根拠を名前だけで書いていた段（「I の定義」「行列のスカラー倍の定義と ℂ の符号の計算」）を、def_kronecker_delta・def_identity_matrix と、" +
          "新しく足した def_matrix_negation へのラベル参照にした。反可換性の 3 式は、右辺の積を先に計算し、主張の左辺から始まる鎖にした" +
          "（以前は σ^x σ^z = -σ^z σ^x のように主張と逆向きの式を示していた）。符号の段は 0 = -0 と 1 = -(-1)（または i = -(-i)）の 2 段に割り、" +
          "行列の積の段と成分の積の段（(-1)·(-1) = 1 など）を分けた。右辺の積の計算は冒頭の準備へ移した。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_pauli_y_times_pauli_x",
    kind: "claim",
    title: { tex: String.raw`\sigma^y\sigma^x = (-i)\,\sigma^z` },
    labels: ["pauli_y_times_pauli_x"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " と、",
        ref("def_imaginary_unit"),
        " の虚数単位 ",
        math(String.raw`i \in \mathbb{C}`),
        " について、",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の中で",
      ]),
      displayMath(String.raw`\sigma^y\sigma^x = (-i)\,\sigma^z`),
      paragraph([
        "が成り立つ。右辺は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \blkref{pauli_matrix_products}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}(-i)\cdot 1&0\\0&i\end{pmatrix}
&&(\because 1_{\mathbb{C}}\ \text{は積の単位元。}\blkref{complex_numbers_form_a_field}\ \text{を右辺から左辺へ}) \\
&= \begin{pmatrix}(-i)\cdot 1&(-i)\cdot 0\\(-i)\cdot 0&i\end{pmatrix}
&&(\because \blkref{complex_times_zero_is_zero}\ \text{を 2 箇所へ右辺から左辺へ同時適用}) \\
&= \begin{pmatrix}(-i)\cdot 1&(-i)\cdot 0\\(-i)\cdot 0&(-i)\cdot(-1)\end{pmatrix}
&&(\because \mathbb{C}\ \text{で}\ (-i)\cdot(-1)=i\text{。}\blkref{definition_of_cc}\ \text{の積}) \\
&= (-i)\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= (-i)\,\sigma^z
&&(\because \blkref{pauli_matrix_products})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04（全証明の SageMath 検算 H1_plus_in_sigma_z_form）: 原文（Typst）に対応ブロックは無い。H1_plus_in_sigma_z_form の証明が「V1_in_Z_Y_epsilon の Step 0」という他のブロックの証明の途中を根拠にしていたので、引ける主張として足した。",
        "数値検証: sagemath/check/pauli_y_times_pauli_x/。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_pauli_x_times_pauli_z",
    kind: "claim",
    title: { tex: String.raw`\sigma^x\sigma^z = (-i)\,\sigma^y` },
    labels: ["pauli_x_times_pauli_z"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " と、",
        ref("def_imaginary_unit"),
        " の虚数単位 ",
        math(String.raw`i \in \mathbb{C}`),
        " について、",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の中で",
      ]),
      displayMath(String.raw`\sigma^x\sigma^z = (-i)\,\sigma^y`),
      paragraph([
        "が成り立つ。右辺は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^z
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \blkref{pauli_matrix_products}) \\
&= \begin{pmatrix}0&-1\\1&0\end{pmatrix}
&&(\because \blkref{mat_mult}) \\
&= \begin{pmatrix}(-i)\cdot 0&-1\\1&(-i)\cdot 0\end{pmatrix}
&&(\because \blkref{complex_times_zero_is_zero}\ \text{を 2 箇所へ右辺から左辺へ同時適用}) \\
&= \begin{pmatrix}(-i)\cdot 0&(-i)\cdot(-i)\\1&(-i)\cdot 0\end{pmatrix}
&&(\because \mathbb{C}\ \text{で}\ (-i)\cdot(-i)=-1\text{。}\blkref{definition_of_cc}\ \text{の積}) \\
&= \begin{pmatrix}(-i)\cdot 0&(-i)\cdot(-i)\\(-i)\cdot i&(-i)\cdot 0\end{pmatrix}
&&(\because \mathbb{C}\ \text{で}\ (-i)\cdot i=1\text{。}\blkref{definition_of_cc}\ \text{の積}) \\
&= (-i)\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= (-i)\,\sigma^y
&&(\because \blkref{pauli_matrix_products})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04（全証明の SageMath 検算 H1_plus_in_sigma_z_form）: 原文（Typst）に対応ブロックは無い。H1_plus_in_sigma_z_form の証明が証明の中で確かめていた 1 サイトの積を、引ける主張として足した。",
        "数値検証: sagemath/check/pauli_x_times_pauli_z/。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_transpose_of_identity_matrix_of_order_two",
    kind: "claim",
    title: { text: "2 次の単位行列の転置" },
    labels: ["transpose_of_identity_matrix_of_order_two"],
    statement: [
      paragraph([
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        " で ",
        math(String.raw`n = 2`),
        "）とする。転置は ",
        ref("def_matrix_transpose"),
        " による。このとき",
      ]),
      displayMath(String.raw`I^\top = I`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
I^\top
&= \begin{pmatrix}I_{11}&I_{21}\\I_{12}&I_{22}\end{pmatrix}
&&(\because \blkref{def_matrix_transpose} \text{ で } m=n=2) \\
&= \begin{pmatrix}\delta_{11}&\delta_{21}\\\delta_{12}&\delta_{22}\end{pmatrix}
&&(\because \blkref{def_identity_matrix} \text{ で } n=2) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix}
&&(\because \blkref{def_kronecker_delta}) \\
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
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 が、σ_m^x・σ_m^zσ_{m+1}^z・G の転置を因子ごとの転置に分けたあと、因子の I が転置で変わらないことを名前を出さずに使っていたので、引ける主張として足した。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_transpose_of_pauli_x",
    kind: "claim",
    title: { tex: String.raw`\sigma^x \text{ の転置}` },
    labels: ["transpose_of_pauli_x"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
        ref("def_matrix_transpose"),
        " の転置に関して",
      ]),
      displayMath(String.raw`(\sigma^x)^\top = \sigma^x`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
(\sigma^x)^\top
&= \begin{pmatrix}(\sigma^x)_{11}&(\sigma^x)_{21}\\(\sigma^x)_{12}&(\sigma^x)_{22}\end{pmatrix}
&&(\because \blkref{def_matrix_transpose} \text{ で } m=n=2) \\
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^x \text{ の成分}) \\
&= \sigma^x
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^x)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 が「σ^x は転置について対称」を根拠なしに述べていたので、def_matrix_transpose の成分の式から示す主張として足した。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_transpose_of_pauli_z",
    kind: "claim",
    title: { tex: String.raw`\sigma^z \text{ の転置}` },
    labels: ["transpose_of_pauli_z"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
        ref("def_matrix_transpose"),
        " の転置に関して",
      ]),
      displayMath(String.raw`(\sigma^z)^\top = \sigma^z`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
(\sigma^z)^\top
&= \begin{pmatrix}(\sigma^z)_{11}&(\sigma^z)_{21}\\(\sigma^z)_{12}&(\sigma^z)_{22}\end{pmatrix}
&&(\because \blkref{def_matrix_transpose} \text{ で } m=n=2) \\
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^z \text{ の成分}) \\
&= \sigma^z
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^z)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 が「σ^z は転置について対称」を根拠なしに述べていたので、def_matrix_transpose の成分の式から示す主張として足した。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_transpose_of_pauli_y",
    kind: "claim",
    title: { tex: String.raw`\sigma^y \text{ の転置}` },
    labels: ["transpose_of_pauli_y"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^y \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
        ref("def_matrix_transpose"),
        " の転置と ",
        ref("def_matrix_negation"),
        " の符号反転に関して",
      ]),
      displayMath(String.raw`(\sigma^y)^\top = -\,\sigma^y`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
(\sigma^y)^\top
&= \begin{pmatrix}(\sigma^y)_{11}&(\sigma^y)_{21}\\(\sigma^y)_{12}&(\sigma^y)_{22}\end{pmatrix}
&&(\because \blkref{def_matrix_transpose} \text{ で } m=n=2) \\
&= \begin{pmatrix}0&i\\-i&0\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^y \text{ の成分}) \\
&= \begin{pmatrix}-0&i\\-i&-0\end{pmatrix}
&&(\because \mathbb{C} \text{ で } 0=-0\text{。}-z\text{ は }\blkref{multiply_by_minus_one}\text{ の記号}) \\
&= \begin{pmatrix}-0&-(-i)\\-i&-0\end{pmatrix}
&&(\because \mathbb{C} \text{ で } i=-(-i)\text{。}-z\text{ は }\blkref{multiply_by_minus_one}\text{ の記号}) \\
&= -\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \blkref{def_matrix_negation}) \\
&= -\,\sigma^y
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^y)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 が「σ^y は交代（(σ^y)^⊤ = -σ^y）」を根拠なしに述べていたので、def_matrix_transpose の成分の式から示す主張として足した。符号の 2 段は pauli_matrix_products の反可換性の鎖と同じ書き方である。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_identity_matrix_of_order_two_has_real_entries",
    kind: "claim",
    title: { text: "2 次の単位行列の成分はすべて実数" },
    labels: ["identity_matrix_of_order_two_has_real_entries"],
    statement: [
      paragraph([
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        " で ",
        math(String.raw`n = 2`),
        "）の成分はすべて実数（",
        ref("def_matrix_with_real_entries"),
        " で ",
        math(String.raw`m = n = 2`),
        "）である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
I
&= \begin{pmatrix}\delta_{11}&\delta_{12}\\\delta_{21}&\delta_{22}\end{pmatrix}
&&(\because \blkref{def_identity_matrix} \text{ で } n=2) \\
&= \begin{pmatrix}1_{\mathbb{C}}&0_{\mathbb{C}}\\0_{\mathbb{C}}&1_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{def_kronecker_delta}) \\
&= \begin{pmatrix}\iota_{\mathbb{R}\to\mathbb{C}}(1)&\iota_{\mathbb{R}\to\mathbb{C}}(0)\\\iota_{\mathbb{R}\to\mathbb{C}}(0)&\iota_{\mathbb{R}\to\mathbb{C}}(1)\end{pmatrix}
&&(\because \blkref{inclusion_rr_to_cc} \text{ の略記 } 1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(1),\ 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0) \text{ を各成分へ同時に適用})
\end{aligned}`,
      ),
      paragraph([
        "したがって各成分 ",
        math(String.raw`I_{pq}`),
        "（",
        math(String.raw`p, q \in \{1, 2\}`),
        "）について ",
        math(String.raw`r := 1`),
        "（",
        math(String.raw`p = q`),
        "）または ",
        math(String.raw`r := 0`),
        "（",
        math(String.raw`p \neq q`),
        "）と取れば ",
        math(String.raw`I_{pq} = r_{\mathbb{C}}`),
        "、",
        math(String.raw`r \in \mathbb{R}`),
        " であり、",
        ref("def_matrix_with_real_entries"),
        " の条件が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の成分の実性が、因子の I の成分が実であることを名前を出さずに使っていたので、引ける主張として足した。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_pauli_x_has_real_entries",
    kind: "claim",
    title: { tex: String.raw`\sigma^x \text{ の成分はすべて実数}` },
    labels: ["pauli_x_has_real_entries"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x \in \mathrm{Mat}(2,\mathbb{C})`),
        " の成分はすべて実数（",
        ref("def_matrix_with_real_entries"),
        " で ",
        math(String.raw`m = n = 2`),
        "）である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\sigma^x
&= \begin{pmatrix}0_{\mathbb{C}}&1_{\mathbb{C}}\\1_{\mathbb{C}}&0_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^x) \\
&= \begin{pmatrix}\iota_{\mathbb{R}\to\mathbb{C}}(0)&\iota_{\mathbb{R}\to\mathbb{C}}(1)\\\iota_{\mathbb{R}\to\mathbb{C}}(1)&\iota_{\mathbb{R}\to\mathbb{C}}(0)\end{pmatrix}
&&(\because \blkref{inclusion_rr_to_cc} \text{ の略記 } 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0),\ 1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(1) \text{ を各成分へ同時に適用})
\end{aligned}`,
      ),
      paragraph([
        "したがって各成分 ",
        math(String.raw`(\sigma^x)_{pq}`),
        "（",
        math(String.raw`p, q \in \{1, 2\}`),
        "）について ",
        math(String.raw`r := 0`),
        "（",
        math(String.raw`p = q`),
        "）または ",
        math(String.raw`r := 1`),
        "（",
        math(String.raw`p \neq q`),
        "）と取れば ",
        math(String.raw`(\sigma^x)_{pq} = r_{\mathbb{C}}`),
        "、",
        math(String.raw`r \in \mathbb{R}`),
        " であり、",
        ref("def_matrix_with_real_entries"),
        " の条件が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 と epsilon_is_real_symmetric の証明が「σ^x の成分は実」を pauli_matrix_products の行列表示だけで述べていたので、def_matrix_with_real_entries の条件として示す主張を足した。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_pauli_z_has_real_entries",
    kind: "claim",
    title: { tex: String.raw`\sigma^z \text{ の成分はすべて実数}` },
    labels: ["pauli_z_has_real_entries"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " の成分はすべて実数（",
        ref("def_matrix_with_real_entries"),
        " で ",
        math(String.raw`m = n = 2`),
        "）である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\sigma^z
&= \begin{pmatrix}1_{\mathbb{C}}&0_{\mathbb{C}}\\0_{\mathbb{C}}&-1_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^z) \\
&= \begin{pmatrix}\iota_{\mathbb{R}\to\mathbb{C}}(1)&\iota_{\mathbb{R}\to\mathbb{C}}(0)\\\iota_{\mathbb{R}\to\mathbb{C}}(0)&\iota_{\mathbb{R}\to\mathbb{C}}(-1)\end{pmatrix}
&&(\because \blkref{inclusion_rr_to_cc} \text{ の略記 } 1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(1),\ 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0),\ -1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(-1) \text{ を各成分へ同時に適用})
\end{aligned}`,
      ),
      paragraph([
        "したがって各成分 ",
        math(String.raw`(\sigma^z)_{pq}`),
        "（",
        math(String.raw`p, q \in \{1, 2\}`),
        "）について ",
        math(String.raw`r := 1`),
        "（",
        math(String.raw`p = q = 1`),
        "）、",
        math(String.raw`r := -1`),
        "（",
        math(String.raw`p = q = 2`),
        "）、",
        math(String.raw`r := 0`),
        "（",
        math(String.raw`p \neq q`),
        "）と取れば ",
        math(String.raw`(\sigma^z)_{pq} = r_{\mathbb{C}}`),
        "、",
        math(String.raw`r \in \mathbb{R}`),
        " であり、",
        ref("def_matrix_with_real_entries"),
        " の条件が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 が「σ^z の成分は実」を pauli_matrix_products の行列表示だけで述べていたので、def_matrix_with_real_entries の条件として示す主張を足した。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_definition_real_factor_of_pauli_y",
    kind: "definition",
    title: { tex: String.raw`\sigma^y \text{ の実の因子 } R^y` },
    labels: ["def_real_factor_of_pauli_y"],
    statement: [
      paragraph([
        math(String.raw`R^y \in \mathrm{Mat}(2,\mathbb{C})`),
        " を",
      ]),
      displayMath(String.raw`R^y := \begin{pmatrix}0_{\mathbb{C}}&-1_{\mathbb{C}}\\1_{\mathbb{C}}&0_{\mathbb{C}}\end{pmatrix}`),
      paragraph(["で定める。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 が「G の成分は、純虚数成分の因子 σ^y が 2 個なので i^2 = -1 の形でまとまり実数」を名前だけで述べていたので、σ^y を i と成分が実数の行列の積に書くために置いた。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_pauli_y_is_i_times_real_factor",
    kind: "claim",
    title: { tex: String.raw`\sigma^y = i R^y` },
    labels: ["pauli_y_is_i_times_real_factor"],
    statement: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^y \in \mathrm{Mat}(2,\mathbb{C})`),
        " と ",
        ref("def_real_factor_of_pauli_y"),
        " の ",
        math(String.raw`R^y`),
        " について、",
        ref("def_imaginary_unit"),
        " の虚数単位 ",
        math(String.raw`i \in \mathbb{C}`),
        " を使うと",
      ]),
      displayMath(String.raw`\sigma^y = i R^y`),
      paragraph([
        "が成り立つ。右辺は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\sigma^y
&= \begin{pmatrix}0_{\mathbb{C}}&-i\\i&0_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{pauli_matrix_products} \text{ の } \sigma^y) \\
&= \begin{pmatrix}0_{\mathbb{C}}&(-1_{\mathbb{C}})\cdot i\\i&0_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{multiply_by_minus_one}\ (z \to i)) \\
&= \begin{pmatrix}0_{\mathbb{C}}&i\cdot(-1_{\mathbb{C}})\\i&0_{\mathbb{C}}\end{pmatrix}
&&(\because \text{積の可換律}\ ((-1_{\mathbb{C}})\cdot i = i\cdot(-1_{\mathbb{C}}))\text{。}\blkref{complex_numbers_form_a_field}) \\
&= \begin{pmatrix}0_{\mathbb{C}}&i\cdot(-1_{\mathbb{C}})\\i\cdot 1_{\mathbb{C}}&0_{\mathbb{C}}\end{pmatrix}
&&(\because 1_{\mathbb{C}}\ \text{は積の単位元}\ (i = i\cdot 1_{\mathbb{C}})\text{。}\blkref{complex_numbers_form_a_field}) \\
&= \begin{pmatrix}i\cdot 0_{\mathbb{C}}&i\cdot(-1_{\mathbb{C}})\\i\cdot 1_{\mathbb{C}}&i\cdot 0_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{complex_times_zero_is_zero}\ (z \to i)\ \text{を}\ (1,1)\ \text{成分と}\ (2,2)\ \text{成分へ同時に適用}) \\
&= i\begin{pmatrix}0_{\mathbb{C}}&-1_{\mathbb{C}}\\1_{\mathbb{C}}&0_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{def_matrix_scalar_multiple}\ (m, n \to 2,\ a \to i)) \\
&= i R^y
&&(\because \blkref{def_real_factor_of_pauli_y})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の G の成分の実性の鎖で、第 1 因子と第 M_col 因子の σ^y から i を前へ出すために足した。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_real_factor_of_pauli_y_has_real_entries",
    kind: "claim",
    title: { tex: String.raw`R^y \text{ の成分はすべて実数}` },
    labels: ["real_factor_of_pauli_y_has_real_entries"],
    statement: [
      paragraph([
        ref("def_real_factor_of_pauli_y"),
        " の ",
        math(String.raw`R^y \in \mathrm{Mat}(2,\mathbb{C})`),
        " の成分はすべて実数（",
        ref("def_matrix_with_real_entries"),
        " で ",
        math(String.raw`m = n = 2`),
        "）である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
R^y
&= \begin{pmatrix}0_{\mathbb{C}}&-1_{\mathbb{C}}\\1_{\mathbb{C}}&0_{\mathbb{C}}\end{pmatrix}
&&(\because \blkref{def_real_factor_of_pauli_y}) \\
&= \begin{pmatrix}\iota_{\mathbb{R}\to\mathbb{C}}(0)&\iota_{\mathbb{R}\to\mathbb{C}}(-1)\\\iota_{\mathbb{R}\to\mathbb{C}}(1)&\iota_{\mathbb{R}\to\mathbb{C}}(0)\end{pmatrix}
&&(\because \blkref{inclusion_rr_to_cc} \text{ の略記 } 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0),\ -1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(-1),\ 1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(1) \text{ を各成分へ同時に適用})
\end{aligned}`,
      ),
      paragraph([
        "したがって各成分 ",
        math(String.raw`(R^y)_{pq}`),
        "（",
        math(String.raw`p, q \in \{1, 2\}`),
        "）について ",
        math(String.raw`r := 0`),
        "（",
        math(String.raw`p = q`),
        "）、",
        math(String.raw`r := -1`),
        "（",
        math(String.raw`(p, q) = (1, 2)`),
        "）、",
        math(String.raw`r := 1`),
        "（",
        math(String.raw`(p, q) = (2, 1)`),
        "）と取れば ",
        math(String.raw`(R^y)_{pq} = r_{\mathbb{C}}`),
        "、",
        math(String.raw`r \in \mathbb{R}`),
        " であり、",
        ref("def_matrix_with_real_entries"),
        " の条件が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 の G の成分の実性の鎖で、i を前へ出した後の因子 R^y の成分が実であることを引くために足した（pauli_z_has_real_entries と同じ形）。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
    kind: "claim",
    origin: { path: "structured-latex/content/006_Z_Y_anticommutation.ts", ordinal: 2 },
    title: { text: "1 因子だけ反可換ならクロネッカー積は反交換する" },
    labels: ["tensor_anticommutation_from_single_site"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`x_1,\dots,x_M,\ y_1,\dots,y_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " に対して",
      ]),
      displayMath(
        String.raw`X := x_1\boxtimes\cdots\boxtimes x_M,\qquad
Y := y_1\boxtimes\cdots\boxtimes y_M \ \in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "とおく。ある ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " が存在して",
      ]),
      list([
        [math(String.raw`y_j x_j = -\,(x_j y_j)`), "（第 ", math(String.raw`j`), " 因子では反可換）"],
        [
          math(String.raw`i \in \{1,\dots,M\},\ i \neq j \implies y_i x_i = x_i y_i`),
          "（他の因子では可換）",
        ],
      ]),
      paragraph(["が成り立つならば、"]),
      displayMath(String.raw`[X, Y]_+ := XY + YX = 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`2^M`),
        " 次の複素行列としての積は、クロネッカー積で書かれた行列どうしでは各因子ごとの ",
        math(String.raw`2`),
        " 次の行列の積になる。すなわち ",
        math(String.raw`A_1,\dots,A_M,B_1,\dots,B_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " に対し、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(A_1\boxtimes\cdots\boxtimes A_M)(B_1\boxtimes\cdots\boxtimes B_M)
&= (A_1B_1)\boxtimes\cdots\boxtimes(A_MB_M)
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則})
\end{aligned}`,
      ),
      paragraph([
        "また ", math(String.raw`c \in \mathbb{C}`),
        " と ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " に対し",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_1\boxtimes\cdots\boxtimes\overbrace{(c\,C_j)}^{j\text{th}}\boxtimes\cdots\boxtimes C_M
&= c\,\left(C_1\boxtimes\cdots\boxtimes C_M\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 } j \text{ 因子についての } \mathbb{C}\text{-線型性})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
XY
&= (x_1\boxtimes\cdots\boxtimes x_M)(y_1\boxtimes\cdots\boxtimes y_M)
&&(\because\ X, Y \text{ の定義}) \\
&= (x_1y_1)\boxtimes\cdots\boxtimes(x_My_M)
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
YX
&= (y_1\boxtimes\cdots\boxtimes y_M)(x_1\boxtimes\cdots\boxtimes x_M)
&&(\because\ X, Y \text{ の定義}) \\
&= (y_1x_1)\boxtimes\cdots\boxtimes(y_Mx_M)
&&(\because\ \blkref{kronecker_product_rule}\text{ の積の規則}) \\
&= (x_1y_1)\boxtimes\cdots\boxtimes\overbrace{(y_jx_j)}^{j\text{th}}\boxtimes\cdots\boxtimes(x_My_M)
&&(\because\ i\neq j \text{ では } y_ix_i = x_iy_i) \\
&= (x_1y_1)\boxtimes\cdots\boxtimes\overbrace{\left((-1)\,(x_jy_j)\right)}^{j\text{th}}\boxtimes\cdots\boxtimes(x_My_M)
&&(\because\ y_jx_j = -(x_jy_j)) \\
&= (-1)\left((x_1y_1)\boxtimes\cdots\boxtimes(x_My_M)\right)
&&(\because\ \blkref{kronecker_multilinear}\text{ の第 } j \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= (-1)\,(XY)
&&(\because\ \text{上の } XY \text{ の計算}) \\
&= -\,XY
&&(\because\ \text{スカラー } -1 \text{ 倍は加法の逆元})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
[X, Y]_+
&= XY + YX
&&(\because\ [X, Y]_+ \text{ の定義}) \\
&= XY + (-\,XY)
&&(\because\ \text{上の } YX \text{ の計算}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文が [Z_μ,Z_ν]_+ の μ<ν の場合に行っている" +
          "「食い違うのは 1 因子だけで、そこの符号が全体の符号になる」という計算を、" +
          "3 式すべてで共通に使えるよう主張として切り出した（lean/Ising2D/EigenvalueProblem/ReductionToATheta/ClaimAnticommutatorZY.lean の " +
          "siteProd_anticomm_of_single_site に対応する）。",
        "2026-09-04 の式変形統一で、クロネッカー積の積の規則と各因子の線型性に前置きしていた参照を削った。各適用行の末尾に同じ \\blkref があるため、内容・式変形・根拠は変えていない。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_claim_tensor_commutation_from_all_sites",
    kind: "claim",
    title: { text: "全ての因子で可換ならクロネッカー積は可換" },
    labels: ["tensor_commutation_from_all_sites"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`x_1,\dots,x_M,\ y_1,\dots,y_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " に対して",
      ]),
      displayMath(
        String.raw`X := x_1\boxtimes\cdots\boxtimes x_M,\qquad
Y := y_1\boxtimes\cdots\boxtimes y_M \ \in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "とおく（",
        math(String.raw`\boxtimes`),
        " は ",
        ref("def_kronecker"),
        " のクロネッカー積）。すべての ",
        math(String.raw`i \in \{1,\dots,M\}`),
        " について ",
        math(String.raw`y_ix_i = x_iy_i`),
        " ならば、",
      ]),
      displayMath(String.raw`XY = YX`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
XY
&= (x_1\boxtimes\cdots\boxtimes x_M)(y_1\boxtimes\cdots\boxtimes y_M)
&&(\because\ X, Y \text{ の定義}) \\
&= (x_1y_1)\boxtimes\cdots\boxtimes(x_My_M)
&&(\because\ \blkref{kronecker_product_rule}\ (1)) \\
&= (y_1x_1)\boxtimes\cdots\boxtimes(y_Mx_M)
&&(\because\ \text{仮定}\ y_ix_i = x_iy_i\ \text{を右辺から左辺へ、全ての}\ i\ \text{へ同時に適用}) \\
&= (y_1\boxtimes\cdots\boxtimes y_M)(x_1\boxtimes\cdots\boxtimes x_M)
&&(\because\ \blkref{kronecker_product_rule}\ (1)\ \text{を右辺から左辺へ}) \\
&= YX
&&(\because\ X, Y \text{ の定義})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02（全証明の SageMath 検算 epsilon_commutes_with_transfer_matrices）: 原文（Typst）に対応ブロックは無い。tensor_anticommutation_from_single_site の可換の側として、ε と σ_k^x の可換性を引けるよう足した。",
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 3 行目の根拠を、仮定 y_ix_i = x_iy_i を右辺から左辺へ使う形に、4 行目の根拠を kronecker_product_rule (1) を右辺から左辺へ使う形に書き直した。主張と式は変えていない。",
      ],
    },
  },
]);
