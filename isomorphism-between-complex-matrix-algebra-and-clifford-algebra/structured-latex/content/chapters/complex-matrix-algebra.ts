import { defineBlocks, displayMath, list, math, paragraph, ref } from "../../schema.ts";

export default defineBlocks([
  {
    id: "complex_matrix_algebra_heading",
    kind: "heading",
    level: 1,
    title: { text: "複素行列環" },
    labels: [],
  },
  {
    id: "complex_matrix_algebra_definition_matrices_indexed_by_finite_set",
    kind: "definition",
    title: { text: "有限集合で添字づけた行列の集合と演算" },
    labels: ["def_matrices_indexed_by_finite_set"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とする。写像 ",
        math(String.raw`A:X\times X\to\mathbb{C}`),
        " を、",
        math(String.raw`X`),
        " で添字づけた複素行列と呼び、その全体の集合を ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " と書く。",
        math(String.raw`A\in\mathrm{Mat}_X(\mathbb{C})`),
        " と ",
        math(String.raw`x,y\in X`),
        " について、",
        math(String.raw`A_{x,y}:=A((x,y))\in\mathbb{C}`),
        " と書き、",
        math(String.raw`A`),
        " の ",
        math(String.raw`(x,y)`),
        " 成分と呼ぶ。",
        math(String.raw`x`),
        " を行の添字、",
        math(String.raw`y`),
        " を列の添字と呼ぶ。",
      ]),
      paragraph([
        math(String.raw`A,B\in\mathrm{Mat}_X(\mathbb{C})`),
        " が等しいとは、写像として等しいこと、すなわちすべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`A_{x,y}=B_{x,y}`),
        " であることである。",
      ]),
      paragraph([
        "写像 ",
        math(String.raw`+_{\mathrm{Mat}_X}:\mathrm{Mat}_X(\mathbb{C})\times\mathrm{Mat}_X(\mathbb{C})\to\mathrm{Mat}_X(\mathbb{C})`),
        "、",
        math(String.raw`\cdot_{\mathrm{Mat}_X}:\mathrm{Mat}_X(\mathbb{C})\times\mathrm{Mat}_X(\mathbb{C})\to\mathrm{Mat}_X(\mathbb{C})`),
        "、",
        math(String.raw`\ast_{\mathrm{Mat}_X}:\mathbb{C}\times\mathrm{Mat}_X(\mathbb{C})\to\mathrm{Mat}_X(\mathbb{C})`),
        " と、元 ",
        math(String.raw`0_{\mathrm{Mat}_X},\ 1_{\mathrm{Mat}_X}\in\mathrm{Mat}_X(\mathbb{C})`),
        " を、",
        math(String.raw`A,B\in\mathrm{Mat}_X(\mathbb{C})`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        "、",
        math(String.raw`x,y\in X`),
        " についての成分で次のように定める。",
      ]),
      list([
        [math(String.raw`(A+_{\mathrm{Mat}_X}B)_{x,y}:=A_{x,y}+_{\mathbb{C}}B_{x,y}`), "（行列の和）"],
        [
          math(String.raw`(A\cdot_{\mathrm{Mat}_X}B)_{x,y}:=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}`),
          "（行列の積）",
        ],
        [math(String.raw`(\lambda\ast_{\mathrm{Mat}_X}A)_{x,y}:=\lambda\cdot_{\mathbb{C}}A_{x,y}`), "（行列のスカラー倍）"],
        [math(String.raw`(0_{\mathrm{Mat}_X})_{x,y}:=0_{\mathbb{C}}`), "（零行列）"],
        [math(String.raw`(1_{\mathrm{Mat}_X})_{x,y}:=\delta_{x,y}`), "（単位行列）"],
      ]),
      paragraph([
        "行列の積の右辺は、",
        math(String.raw`z\in X`),
        " に係数 ",
        math(String.raw`A_{x,z}\in\mathbb{C}`),
        " と元 ",
        math(String.raw`B_{z,y}\in\mathbb{C}`),
        " を与える族の、ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）である。この和は ",
        math(String.raw`X`),
        " の番号付けの取り方によらず一つに決まり（",
        ref("def_sum_over_finite_set"),
        "）、",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、その値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。単位行列の右辺は集合 ",
        math(String.raw`X`),
        " の二元のクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）である。",
      ]),
      paragraph([
        "五つの右辺はどれも、",
        math(String.raw`(x,y)\in X\times X`),
        " ごとに ",
        math(String.raw`\mathbb{C}`),
        " の元を一つ定める。したがって左辺は写像 ",
        math(String.raw`X\times X\to\mathbb{C}`),
        "、すなわち ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        "演算と単位元には ",
        math(String.raw`\mathrm{Mat}_X`),
        " を添字で書き、成分の側の ",
        math(String.raw`\mathbb{C}`),
        " の演算 ",
        math(String.raw`+_{\mathbb{C}},\ \cdot_{\mathbb{C}}`),
        " と区別する。乗法 ",
        math(String.raw`\cdot_{\mathrm{Mat}_X}`),
        " とスカラー倍 ",
        math(String.raw`\ast_{\mathrm{Mat}_X}`),
        " は定義域の異なる別の写像なので、別の記号で書く。組 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\cdot_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X},1_{\mathrm{Mat}_X})`),
        " が ℂ-代数（",
        ref("def_complex_algebra"),
        "）の条件を満たすことは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_matrices_form_complex_vector_space",
    kind: "claim",
    title: { text: "有限集合で添字づけた行列の集合は、成分ごとの和とスカラー倍で ℂ-線型空間である" },
    labels: ["claim_matrices_indexed_by_finite_set_form_complex_vector_space"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とする。組 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。ここで ℂ-線型空間の定義のスカラー倍 ",
        math(String.raw`\cdot_V`),
        " には ",
        math(String.raw`\ast_{\mathrm{Mat}_X}`),
        " を当てる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A,B,C`),
        " を ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の任意の元、",
        math(String.raw`\lambda,\mu`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。ℂ-線型空間の定義（",
        ref("def_complex_vector_space"),
        "）の八つの条件を順に示す。どの条件も ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の二つの元の等式であり、",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の二つの元が等しいことは、すべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`(x,y)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことである（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。以下の各式変形は、",
        math(String.raw`x,y\in X`),
        " を任意に固定した ",
        math(String.raw`\mathbb{C}`),
        " の中の等式の連なりである。",
      ]),
      paragraph(["加法の結合法則 ", math(String.raw`(A+_{\mathrm{Mat}_X}B)+_{\mathrm{Mat}_X}C=A+_{\mathrm{Mat}_X}(B+_{\mathrm{Mat}_X}C)`), " は、すべての ", math(String.raw`x,y\in X`), " について次の成分の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((A+_{\mathrm{Mat}_X}B)+_{\mathrm{Mat}_X}C\bigr)_{x,y}
&=(A+_{\mathrm{Mat}_X}B)_{x,y}+_{\mathbb{C}}C_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=(A_{x,y}+_{\mathbb{C}}B_{x,y})+_{\mathbb{C}}C_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=A_{x,y}+_{\mathbb{C}}(B_{x,y}+_{\mathbb{C}}C_{x,y})
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=A_{x,y}+_{\mathbb{C}}(B+_{\mathrm{Mat}_X}C)_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl(A+_{\mathrm{Mat}_X}(B+_{\mathrm{Mat}_X}C)\bigr)_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph(["加法の交換法則 ", math(String.raw`A+_{\mathrm{Mat}_X}B=B+_{\mathrm{Mat}_X}A`), " は、すべての ", math(String.raw`x,y\in X`), " について次の成分の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
(A+_{\mathrm{Mat}_X}B)_{x,y}
&=A_{x,y}+_{\mathbb{C}}B_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=B_{x,y}+_{\mathbb{C}}A_{x,y}
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=(B+_{\mathrm{Mat}_X}A)_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph(["加法の単位元 ", math(String.raw`A+_{\mathrm{Mat}_X}0_{\mathrm{Mat}_X}=A`), " は、すべての ", math(String.raw`x,y\in X`), " について次の成分の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
(A+_{\mathrm{Mat}_X}0_{\mathrm{Mat}_X})_{x,y}
&=A_{x,y}+_{\mathbb{C}}(0_{\mathrm{Mat}_X})_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=A_{x,y}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=A_{x,y}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "加法の逆元は次のとおりである。",
        math(String.raw`\mathbb{C}`),
        " の各元は ",
        math(String.raw`\mathbb{C}`),
        " の加法の逆元をただ一つもつので、",
        math(String.raw`a\in\mathbb{C}`),
        " の加法の逆元を ",
        math(String.raw`-_{\mathbb{C}}a\in\mathbb{C}`),
        " と書く（",
        math(String.raw`a+_{\mathbb{C}}(-_{\mathbb{C}}a)=0_{\mathbb{C}}`),
        "）。写像 ",
        math(String.raw`A':X\times X\to\mathbb{C}`),
        " を ",
        math(String.raw`A'_{x,y}:=-_{\mathbb{C}}A_{x,y}`),
        "（",
        math(String.raw`x,y\in X`),
        "）で定めると、",
        math(String.raw`A'\in\mathrm{Mat}_X(\mathbb{C})`),
        " であり（",
        ref("def_matrices_indexed_by_finite_set"),
        "）、",
        math(String.raw`A+_{\mathrm{Mat}_X}A'=0_{\mathrm{Mat}_X}`),
        " を満たす。これは、すべての ",
        math(String.raw`x,y\in X`),
        " について次の成分の等式が成り立つことである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(A+_{\mathrm{Mat}_X}A')_{x,y}
&=A_{x,y}+_{\mathbb{C}}A'_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=A_{x,y}+_{\mathbb{C}}(-_{\mathbb{C}}A_{x,y})
&&\left(\because\ A'\ \text{の定義}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ -_{\mathbb{C}}A_{x,y}\ \text{は}\ A_{x,y}\ \text{の}\ \mathbb{C}\ \text{の加法の逆元}\right)\\
&=(0_{\mathrm{Mat}_X})_{x,y}
&&\left(\because\ 0_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph(["スカラー倍の結合法則 ", math(String.raw`(\lambda\cdot_{\mathbb{C}}\mu)\ast_{\mathrm{Mat}_X}A=\lambda\ast_{\mathrm{Mat}_X}(\mu\ast_{\mathrm{Mat}_X}A)`), " は、すべての ", math(String.raw`x,y\in X`), " について次の成分の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda\cdot_{\mathbb{C}}\mu)\ast_{\mathrm{Mat}_X}A\bigr)_{x,y}
&=(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}A_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\lambda\cdot_{\mathbb{C}}(\mu\cdot_{\mathbb{C}}A_{x,y})
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}(\mu\ast_{\mathrm{Mat}_X}A)_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl(\lambda\ast_{\mathrm{Mat}_X}(\mu\ast_{\mathrm{Mat}_X}A)\bigr)_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph(["スカラー倍の単位元 ", math(String.raw`1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}A=A`), " は、すべての ", math(String.raw`x,y\in X`), " について次の成分の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
(1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}A)_{x,y}
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}A_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=A_{x,y}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph(["ベクトルの加法についての分配法則 ", math(String.raw`\lambda\ast_{\mathrm{Mat}_X}(A+_{\mathrm{Mat}_X}B)=(\lambda\ast_{\mathrm{Mat}_X}A)+_{\mathrm{Mat}_X}(\lambda\ast_{\mathrm{Mat}_X}B)`), " は、すべての ", math(String.raw`x,y\in X`), " について次の成分の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(\lambda\ast_{\mathrm{Mat}_X}(A+_{\mathrm{Mat}_X}B)\bigr)_{x,y}
&=\lambda\cdot_{\mathbb{C}}(A+_{\mathrm{Mat}_X}B)_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\lambda\cdot_{\mathbb{C}}(A_{x,y}+_{\mathbb{C}}B_{x,y})
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=(\lambda\cdot_{\mathbb{C}}A_{x,y})+_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}B_{x,y})
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(\lambda\ast_{\mathrm{Mat}_X}A)_{x,y}+_{\mathbb{C}}(\lambda\ast_{\mathrm{Mat}_X}B)_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義を二か所に適用。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl((\lambda\ast_{\mathrm{Mat}_X}A)+_{\mathrm{Mat}_X}(\lambda\ast_{\mathrm{Mat}_X}B)\bigr)_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph(["スカラーの加法についての分配法則 ", math(String.raw`(\lambda+_{\mathbb{C}}\mu)\ast_{\mathrm{Mat}_X}A=(\lambda\ast_{\mathrm{Mat}_X}A)+_{\mathrm{Mat}_X}(\mu\ast_{\mathrm{Mat}_X}A)`), " は、すべての ", math(String.raw`x,y\in X`), " について次の成分の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda+_{\mathbb{C}}\mu)\ast_{\mathrm{Mat}_X}A\bigr)_{x,y}
&=(\lambda+_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}A_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=(\lambda\cdot_{\mathbb{C}}A_{x,y})+_{\mathbb{C}}(\mu\cdot_{\mathbb{C}}A_{x,y})
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(\lambda\ast_{\mathrm{Mat}_X}A)_{x,y}+_{\mathbb{C}}(\mu\ast_{\mathrm{Mat}_X}A)_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義を二か所に適用。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\bigl((\lambda\ast_{\mathrm{Mat}_X}A)+_{\mathrm{Mat}_X}(\mu\ast_{\mathrm{Mat}_X}A)\bigr)_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "八つの条件が満たされたので、組 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X})`),
        " は ℂ-線型空間である（",
        ref("def_complex_vector_space"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_matrix_product_is_associative",
    kind: "claim",
    title: { text: "行列の積の結合法則" },
    labels: ["claim_matrix_product_is_associative"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`A,B,C\in\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`(A\cdot_{\mathrm{Mat}_X}B)\cdot_{\mathrm{Mat}_X}C=A\cdot_{\mathrm{Mat}_X}(B\cdot_{\mathrm{Mat}_X}C)`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`(x,y)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`x,y\in X`),
        " を任意に固定する。以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元であり、係数の側にもベクトルの側にも置ける。",
      ]),
      paragraph([
        "（準備）",
        math(String.raw`w,z\in X`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の元を次で置く。",
      ]),
      list([
        [math(String.raw`\lambda_{w,z}:=A_{x,z}\cdot_{\mathbb{C}}B_{z,w}`)],
        [math(String.raw`p_w:=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}} B_{z,w}`)],
        [math(String.raw`u_w:=p_w\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}`)],
      ]),
      paragraph([
        "まず、すべての ",
        math(String.raw`w,z\in X`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
(C_{w,y}\cdot_{\mathbb{C}}A_{x,z})\cdot_{\mathbb{C}^{\mathrm{vec}}} B_{z,w}
&=(C_{w,y}\cdot_{\mathbb{C}}A_{x,z})\cdot_{\mathbb{C}}B_{z,w}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=C_{w,y}\cdot_{\mathbb{C}}(A_{x,z}\cdot_{\mathbb{C}}B_{z,w})
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(A_{x,z}\cdot_{\mathbb{C}}B_{z,w})\cdot_{\mathbb{C}}C_{w,y}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\lambda_{w,z}\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義と}\ \lambda_{w,z}\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "次に、すべての ",
        math(String.raw`w\in X`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
u_w
&=p_w\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}
&&\left(\because\ u_w\ \text{の定義}\right)\\
&=p_w\cdot_{\mathbb{C}}C_{w,y}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=C_{w,y}\cdot_{\mathbb{C}}p_w
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=C_{w,y}\cdot_{\mathbb{C}^{\mathrm{vec}}} p_w
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=C_{w,y}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}} B_{z,w}\right)
&&\left(\because\ p_w\ \text{の定義}\right)\\
&=\sum_{z\in X}(C_{w,y}\cdot_{\mathbb{C}}A_{x,z})\cdot_{\mathbb{C}^{\mathrm{vec}}} B_{z,w}
&&\left(\because\ \rho:=C_{w,y}\ \text{とする。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=\sum_{z\in X}\lambda_{w,z}\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}
&&\left(\because\ \text{各}\ z\ \text{の項に直前の等式を当てる。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right).
\end{aligned}`),
      paragraph([
        "また、すべての ",
        math(String.raw`w\in X`),
        " について、",
        math(String.raw`(A\cdot_{\mathrm{Mat}_X}B)_{x,w}=p_w`),
        "（積の定義と ",
        math(String.raw`p_w`),
        " の定義。",
        ref("def_matrices_indexed_by_finite_set"),
        "）であり、",
        math(String.raw`p_w\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}=u_w=1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}} u_w`),
        "（",
        math(String.raw`u_w`),
        " の定義と、スカラー倍の単位元を ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " に当てたもの。",
        ref("def_complex_vector_space"),
        "・",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）である。同じく、すべての ",
        math(String.raw`z\in X`),
        " について、",
        math(String.raw`(B\cdot_{\mathrm{Mat}_X}C)_{z,y}=\sum_{w\in X}B_{z,w}\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）である。",
      ]),
      paragraph(["（式変形）準備の記号で、", math(String.raw`(x,y)`), " 成分は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((A\cdot_{\mathrm{Mat}_X}B)\cdot_{\mathrm{Mat}_X}C\bigr)_{x,y}
&=\sum_{w\in X}(A\cdot_{\mathrm{Mat}_X}B)_{x,w}\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{w\in X}p_w\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}
&&\left(\because\ \text{各}\ w\ \text{で}\ (A\cdot_{\mathrm{Mat}_X}B)_{x,w}=p_w\ \text{（準備）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{w\in X}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}} u_w
&&\left(\because\ \text{各}\ w\ \text{で}\ p_w\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}=1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}} u_w\ \text{（準備）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{w\in X}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{z\in X}\lambda_{w,z}\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}\right)
&&\left(\because\ \text{各}\ w\ \text{で}\ u_w\ \text{の準備の等式を当てる。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{z\in X}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{w\in X}\lambda_{w,z}\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}\right)
&&\left(\because\ \text{二つの有限集合をともに}\ X\ \text{、添字の組を}\ (w,z)\ \text{、}v_{w,z}:=C_{w,y}\ \text{とする。}\blkref{claim_interchange_of_double_sum_over_finite_sets}\right)\\
&=\sum_{z\in X}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{w\in X}B_{z,w}\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}\right)\right)
&&\left(\because\ \text{各}\ z\ \text{で、}\rho:=A_{x,z}\ \text{とする}\ \blkref{claim_scalar_multiple_of_sum_over_finite_set}\ \text{を逆向きに当てる。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{w\in X}B_{z,w}\cdot_{\mathbb{C}^{\mathrm{vec}}} C_{w,y}\right)
&&\left(\because\ \text{各}\ z\ \text{で、スカラー倍の単位元を}\ \mathbb{C}^{\mathrm{vec}}\ \text{に当てる。}\blkref{def_complex_vector_space}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}(B\cdot_{\mathrm{Mat}_X}C)_{z,y}
&&\left(\because\ \text{各}\ z\ \text{で}\ \cdot_{\mathrm{Mat}_X}\ \text{の定義（準備）。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\bigl(A\cdot_{\mathrm{Mat}_X}(B\cdot_{\mathrm{Mat}_X}C)\bigr)_{x,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y\in X`),
        " は任意だったので、",
        math(String.raw`(A\cdot_{\mathrm{Mat}_X}B)\cdot_{\mathrm{Mat}_X}C=A\cdot_{\mathrm{Mat}_X}(B\cdot_{\mathrm{Mat}_X}C)`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_matrix_product_distributes_over_sum_in_right_factor",
    kind: "claim",
    title: { text: "行列の積は、右の因子の和に分配する" },
    labels: ["claim_matrix_product_distributes_over_sum_in_right_factor"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`A,B,C\in\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`A\cdot_{\mathrm{Mat}_X}(B+_{\mathrm{Mat}_X}C)=(A\cdot_{\mathrm{Mat}_X}B)+_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}C)`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`(x,y)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`x,y\in X`),
        " を任意に固定する。以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot_{\mathrm{Mat}_X}(B+_{\mathrm{Mat}_X}C)\bigr)_{x,y}
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}(B+_{\mathrm{Mat}_X}C)_{z,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}(B_{z,y}+_{\mathbb{C}}C_{z,y})
&&\left(\because\ \text{各}\ z\ \text{で}\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}(B_{z,y}+_{\mathbb{C}^{\mathrm{vec}}}C_{z,y})
&&\left(\because\ \text{各}\ z\ \text{で}\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}\right)+_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}C_{z,y}\right)
&&\left(\because\ \lambda_z:=A_{x,z},\ v_z:=B_{z,y},\ w_z:=C_{z,y}\ \text{として逆向きに当てる。}\blkref{claim_sum_of_sums_over_finite_set_with_same_coefficients}\right)\\
&=(A\cdot_{\mathrm{Mat}_X}B)_{x,y}+_{\mathbb{C}^{\mathrm{vec}}}(A\cdot_{\mathrm{Mat}_X}C)_{x,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義を二か所に適用。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=(A\cdot_{\mathrm{Mat}_X}B)_{x,y}+_{\mathbb{C}}(A\cdot_{\mathrm{Mat}_X}C)_{x,y}
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\bigl((A\cdot_{\mathrm{Mat}_X}B)+_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}C)\bigr)_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y\in X`),
        " は任意だったので、",
        math(String.raw`A\cdot_{\mathrm{Mat}_X}(B+_{\mathrm{Mat}_X}C)=(A\cdot_{\mathrm{Mat}_X}B)+_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}C)`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_matrix_product_distributes_over_sum_in_left_factor",
    kind: "claim",
    title: { text: "行列の積は、左の因子の和に分配する" },
    labels: ["claim_matrix_product_distributes_over_sum_in_left_factor"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`A,B,C\in\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`(A+_{\mathrm{Mat}_X}B)\cdot_{\mathrm{Mat}_X}C=(A\cdot_{\mathrm{Mat}_X}C)+_{\mathrm{Mat}_X}(B\cdot_{\mathrm{Mat}_X}C)`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`(x,y)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`x,y\in X`),
        " を任意に固定する。以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((A+_{\mathrm{Mat}_X}B)\cdot_{\mathrm{Mat}_X}C\bigr)_{x,y}
&=\sum_{z\in X}(A+_{\mathrm{Mat}_X}B)_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}C_{z,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{z\in X}(A_{x,z}+_{\mathbb{C}}B_{x,z})\cdot_{\mathbb{C}^{\mathrm{vec}}}C_{z,y}
&&\left(\because\ \text{各}\ z\ \text{で}\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}C_{z,y}\right)+_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{z\in X}B_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}C_{z,y}\right)
&&\left(\because\ \lambda_z:=A_{x,z},\ \mu_z:=B_{x,z},\ v_z:=C_{z,y}\ \text{として逆向きに当てる。}\blkref{claim_sum_of_sums_over_finite_set_with_same_family}\right)\\
&=(A\cdot_{\mathrm{Mat}_X}C)_{x,y}+_{\mathbb{C}^{\mathrm{vec}}}(B\cdot_{\mathrm{Mat}_X}C)_{x,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義を二か所に適用。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=(A\cdot_{\mathrm{Mat}_X}C)_{x,y}+_{\mathbb{C}}(B\cdot_{\mathrm{Mat}_X}C)_{x,y}
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\bigl((A\cdot_{\mathrm{Mat}_X}C)+_{\mathrm{Mat}_X}(B\cdot_{\mathrm{Mat}_X}C)\bigr)_{x,y}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y\in X`),
        " は任意だったので、",
        math(String.raw`(A+_{\mathrm{Mat}_X}B)\cdot_{\mathrm{Mat}_X}C=(A\cdot_{\mathrm{Mat}_X}C)+_{\mathrm{Mat}_X}(B\cdot_{\mathrm{Mat}_X}C)`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_identity_matrix_is_left_unit_of_matrix_product",
    kind: "claim",
    title: { text: "単位行列を左から掛けても、行列は変わらない" },
    labels: ["claim_identity_matrix_is_left_unit_of_matrix_product"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`A\in\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`1_{\mathrm{Mat}_X}\cdot_{\mathrm{Mat}_X}A=A`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`(x,y)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`x,y\in X`),
        " を任意に固定する。以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(1_{\mathrm{Mat}_X}\cdot_{\mathrm{Mat}_X}A\bigr)_{x,y}
&=\sum_{z\in X}(1_{\mathrm{Mat}_X})_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{z,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{z\in X}\delta_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{z,y}
&&\left(\because\ \text{各}\ z\ \text{で}\ 1_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=A_{x,y}
&&\left(\because\ v_z:=A_{z,y}\ \text{として当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y\in X`),
        " は任意だったので、",
        math(String.raw`1_{\mathrm{Mat}_X}\cdot_{\mathrm{Mat}_X}A=A`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_identity_matrix_is_right_unit_of_matrix_product",
    kind: "claim",
    title: { text: "単位行列を右から掛けても、行列は変わらない" },
    labels: ["claim_identity_matrix_is_right_unit_of_matrix_product"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`A\in\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`A\cdot_{\mathrm{Mat}_X}1_{\mathrm{Mat}_X}=A`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`(x,y)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`x,y\in X`),
        " を任意に固定する。以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      paragraph([
        "準備として、各 ",
        math(String.raw`z\in X`),
        " について、項の係数と元を入れ替えた次の等式を示す。",
        math(String.raw`\delta_{z,y}`),
        " と ",
        math(String.raw`\delta_{y,z}`),
        " はどちらも ",
        math(String.raw`X`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）で、",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}\delta_{z,y}
&=A_{x,z}\cdot_{\mathbb{C}}\delta_{z,y}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\delta_{z,y}\cdot_{\mathbb{C}}A_{x,z}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{y,z}\cdot_{\mathbb{C}}A_{x,z}
&&\left(\because\ z=y\ \text{と}\ y=z\ \text{は同値なので、場合分けが一致する。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{y,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{x,z}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(x,y)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot_{\mathrm{Mat}_X}1_{\mathrm{Mat}_X}\bigr)_{x,y}
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}(1_{\mathrm{Mat}_X})_{z,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}\delta_{z,y}
&&\left(\because\ \text{各}\ z\ \text{で}\ 1_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{z\in X}\delta_{y,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{x,z}
&&\left(\because\ \text{各}\ z\ \text{で準備の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=A_{x,y}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ y\text{、和の変数に}\ z\text{、}v_z:=A_{x,z}\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y\in X`),
        " は任意だったので、",
        math(String.raw`A\cdot_{\mathrm{Mat}_X}1_{\mathrm{Mat}_X}=A`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor",
    kind: "claim",
    title: { text: "行列のスカラー倍は、行列の積の左の因子へ移せる" },
    labels: ["claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`A,B\in\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`\lambda\ast_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}B)=(\lambda\ast_{\mathrm{Mat}_X}A)\cdot_{\mathrm{Mat}_X}B`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`(x,y)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`x,y\in X`),
        " を任意に固定する。以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\lambda\ast_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}B)\bigr)_{x,y}
&=\lambda\cdot_{\mathbb{C}}(A\cdot_{\mathrm{Mat}_X}B)_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\lambda\cdot_{\mathbb{C}}\left(\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}\right)
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}\right)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\sum_{z\in X}(\lambda\cdot_{\mathbb{C}}A_{x,z})\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}
&&\left(\because\ \rho:=\lambda,\ \lambda_z:=A_{x,z},\ v_z:=B_{z,y}\ \text{として当てる。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=\sum_{z\in X}(\lambda\ast_{\mathrm{Mat}_X}A)_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}
&&\left(\because\ \text{各}\ z\ \text{で}\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\bigl((\lambda\ast_{\mathrm{Mat}_X}A)\cdot_{\mathrm{Mat}_X}B\bigr)_{x,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y\in X`),
        " は任意だったので、",
        math(String.raw`\lambda\ast_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}B)=(\lambda\ast_{\mathrm{Mat}_X}A)\cdot_{\mathrm{Mat}_X}B`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor",
    kind: "claim",
    title: { text: "行列のスカラー倍は、行列の積の右の因子へ移せる" },
    labels: ["claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`A,B\in\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`\lambda\ast_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}B)=A\cdot_{\mathrm{Mat}_X}(\lambda\ast_{\mathrm{Mat}_X}B)`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`x,y\in X`),
        " について ",
        math(String.raw`(x,y)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`x,y\in X`),
        " を任意に固定する。以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      paragraph([
        "準備として、各 ",
        math(String.raw`z\in X`),
        " について、スカラー ",
        math(String.raw`\lambda`),
        " を項の係数から元へ移す次の等式を示す。",
        math(String.raw`\lambda,\ A_{x,z},\ B_{z,y}`),
        " はどれも ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\lambda\cdot_{\mathbb{C}}A_{x,z})\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}
&=(\lambda\cdot_{\mathbb{C}}A_{x,z})\cdot_{\mathbb{C}}B_{z,y}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(A_{x,z}\cdot_{\mathbb{C}}\lambda)\cdot_{\mathbb{C}}B_{z,y}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=A_{x,z}\cdot_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}B_{z,y})
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}(\lambda\cdot_{\mathbb{C}}B_{z,y})
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(x,y)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\lambda\ast_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}B)\bigr)_{x,y}
&=\lambda\cdot_{\mathbb{C}}(A\cdot_{\mathrm{Mat}_X}B)_{x,y}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\lambda\cdot_{\mathbb{C}}\left(\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}\right)
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}\right)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\sum_{z\in X}(\lambda\cdot_{\mathbb{C}}A_{x,z})\cdot_{\mathbb{C}^{\mathrm{vec}}}B_{z,y}
&&\left(\because\ \rho:=\lambda,\ \lambda_z:=A_{x,z},\ v_z:=B_{z,y}\ \text{として当てる。}\blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}(\lambda\cdot_{\mathbb{C}}B_{z,y})
&&\left(\because\ \text{各}\ z\ \text{で準備の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{z\in X}A_{x,z}\cdot_{\mathbb{C}^{\mathrm{vec}}}(\lambda\ast_{\mathrm{Mat}_X}B)_{z,y}
&&\left(\because\ \text{各}\ z\ \text{で}\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\bigl(A\cdot_{\mathrm{Mat}_X}(\lambda\ast_{\mathrm{Mat}_X}B)\bigr)_{x,y}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y\in X`),
        " は任意だったので、",
        math(String.raw`\lambda\ast_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}B)=A\cdot_{\mathrm{Mat}_X}(\lambda\ast_{\mathrm{Mat}_X}B)`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_matrices_form_complex_algebra",
    kind: "claim",
    title: { text: "有限集合で添字づけた行列の集合は、成分ごとの和・行列の積・スカラー倍で ℂ-代数である" },
    labels: ["claim_matrices_indexed_by_finite_set_form_complex_algebra"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とする。組 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\cdot_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X},1_{\mathrm{Mat}_X})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）は ℂ-代数（",
        ref("def_complex_algebra"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A,B,C`),
        " を ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。ℂ-代数の定義（",
        ref("def_complex_algebra"),
        "）の四つの条件を順に示す。",
      ]),
      paragraph([
        "一つ目の条件は、組 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\cdot_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X},1_{\mathrm{Mat}_X})`),
        " が単位元をもつ環（",
        ref("def_unital_ring"),
        "）であることである。環の定義の七つの条件を、",
        math(String.raw`R:=\mathrm{Mat}_X(\mathbb{C})`),
        "、",
        math(String.raw`+_R:=+_{\mathrm{Mat}_X}`),
        "、",
        math(String.raw`\cdot_R:=\cdot_{\mathrm{Mat}_X}`),
        "、",
        math(String.raw`0_R:=0_{\mathrm{Mat}_X}`),
        "、",
        math(String.raw`1_R:=1_{\mathrm{Mat}_X}`),
        " として確かめる。",
      ]),
      list([
        [
          "加法の結合法則 ",
          math(String.raw`(A+_{\mathrm{Mat}_X}B)+_{\mathrm{Mat}_X}C=A+_{\mathrm{Mat}_X}(B+_{\mathrm{Mat}_X}C)`),
          "、加法の交換法則 ",
          math(String.raw`A+_{\mathrm{Mat}_X}B=B+_{\mathrm{Mat}_X}A`),
          "、加法の単位元 ",
          math(String.raw`A+_{\mathrm{Mat}_X}0_{\mathrm{Mat}_X}=A`),
          "、加法の逆元（各 ",
          math(String.raw`A`),
          " に対し ",
          math(String.raw`A+_{\mathrm{Mat}_X}A'=0_{\mathrm{Mat}_X}`),
          " を満たす ",
          math(String.raw`A'\in\mathrm{Mat}_X(\mathbb{C})`),
          " が存在すること）の四つは、ℂ-線型空間の定義（",
          ref("def_complex_vector_space"),
          "）の最初の四つの条件を ",
          math(String.raw`V:=\mathrm{Mat}_X(\mathbb{C})`),
          "、",
          math(String.raw`+_V:=+_{\mathrm{Mat}_X}`),
          "、",
          math(String.raw`0_V:=0_{\mathrm{Mat}_X}`),
          " に当てたものと同じ主張である。組 ",
          math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X})`),
          " は ℂ-線型空間である（",
          ref("claim_matrices_indexed_by_finite_set_form_complex_vector_space"),
          "）ので、四つとも成り立つ",
        ],
        [
          "乗法の結合法則 ",
          math(String.raw`(A\cdot_{\mathrm{Mat}_X}B)\cdot_{\mathrm{Mat}_X}C=A\cdot_{\mathrm{Mat}_X}(B\cdot_{\mathrm{Mat}_X}C)`),
          " は ",
          ref("claim_matrix_product_is_associative"),
          " である",
        ],
        [
          "乗法の単位元の一つ目 ",
          math(String.raw`A\cdot_{\mathrm{Mat}_X}1_{\mathrm{Mat}_X}=A`),
          " は ",
          ref("claim_identity_matrix_is_right_unit_of_matrix_product"),
          " であり、二つ目 ",
          math(String.raw`1_{\mathrm{Mat}_X}\cdot_{\mathrm{Mat}_X}A=A`),
          " は ",
          ref("claim_identity_matrix_is_left_unit_of_matrix_product"),
          " である",
        ],
        [
          "分配法則の一つ目 ",
          math(String.raw`A\cdot_{\mathrm{Mat}_X}(B+_{\mathrm{Mat}_X}C)=(A\cdot_{\mathrm{Mat}_X}B)+_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}C)`),
          " は ",
          ref("claim_matrix_product_distributes_over_sum_in_right_factor"),
          " であり、二つ目 ",
          math(String.raw`(A+_{\mathrm{Mat}_X}B)\cdot_{\mathrm{Mat}_X}C=(A\cdot_{\mathrm{Mat}_X}C)+_{\mathrm{Mat}_X}(B\cdot_{\mathrm{Mat}_X}C)`),
          " は ",
          ref("claim_matrix_product_distributes_over_sum_in_left_factor"),
          " である",
        ],
      ]),
      paragraph([
        "二つ目の条件は、組 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X})`),
        " が ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）であることであり、",
        ref("claim_matrices_indexed_by_finite_set_form_complex_vector_space"),
        " である。",
      ]),
      paragraph([
        "三つ目の条件（スカラー倍と乗法の両立、左の因子） ",
        math(String.raw`\lambda\ast_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}B)=(\lambda\ast_{\mathrm{Mat}_X}A)\cdot_{\mathrm{Mat}_X}B`),
        " は ",
        ref("claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor"),
        " である。",
      ]),
      paragraph([
        "四つ目の条件（スカラー倍と乗法の両立、右の因子） ",
        math(String.raw`\lambda\ast_{\mathrm{Mat}_X}(A\cdot_{\mathrm{Mat}_X}B)=A\cdot_{\mathrm{Mat}_X}(\lambda\ast_{\mathrm{Mat}_X}B)`),
        " は ",
        ref("claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor"),
        " である。",
      ]),
      paragraph([
        "二つの組は同じ集合 ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        "、同じ加法 ",
        math(String.raw`+_{\mathrm{Mat}_X}`),
        "、同じ加法の単位元 ",
        math(String.raw`0_{\mathrm{Mat}_X}`),
        " をもつ（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。四つの条件がすべて成り立つので、組 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\cdot_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X},1_{\mathrm{Mat}_X})`),
        " は ℂ-代数である（",
        ref("def_complex_algebra"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_definition_matrix_unit",
    kind: "definition",
    title: { text: "行列単位" },
    labels: ["def_matrix_unit"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とする。",
        math(String.raw`x,y\in X`),
        " について、",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）の元 ",
        math(String.raw`E_{x,y}`),
        " を、",
        math(String.raw`u,v\in X`),
        " についての成分で次のように定め、行列単位と呼ぶ。",
      ]),
      displayMath(String.raw`(E_{x,y})_{u,v}:=\delta_{x,u}\cdot_{\mathbb{C}}\delta_{y,v}`),
      paragraph([
        "右辺の ",
        math(String.raw`\delta_{x,u}`),
        " と ",
        math(String.raw`\delta_{y,v}`),
        " は集合 ",
        math(String.raw`X`),
        " の二元のクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）であり、どちらも ",
        math(String.raw`\mathbb{C}`),
        " の元である。右辺はその ",
        math(String.raw`\mathbb{C}`),
        " の中の積なので、",
        math(String.raw`(u,v)\in X\times X`),
        " ごとに ",
        math(String.raw`\mathbb{C}`),
        " の元を一つ定める。したがって ",
        math(String.raw`E_{x,y}`),
        " は写像 ",
        math(String.raw`X\times X\to\mathbb{C}`),
        "、すなわち ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        "記号 ",
        math(String.raw`E_{x,y}`),
        " は添字の集合 ",
        math(String.raw`X`),
        " を書かないが、",
        math(String.raw`X`),
        " ごとに別の行列である。",
        math(String.raw`X`),
        " は ",
        math(String.raw`x,y`),
        " が属する集合として決まる。下付きの添字 ",
        math(String.raw`x,y`),
        " は行列を選ぶ添字であり、成分の添字 ",
        math(String.raw`(u,v)`),
        " とは別である。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_product_of_matrix_units",
    kind: "claim",
    title: { text: "行列単位の積の規則" },
    labels: ["claim_product_of_matrix_units"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`x,y,z,w\in X`),
        " とする。このとき、行列単位（",
        ref("def_matrix_unit"),
        "）について次が成り立つ。",
        math(String.raw`\delta_{y,z}\in\mathbb{C}`),
        " は ",
        math(String.raw`X`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）であり、",
        math(String.raw`\cdot_{\mathrm{Mat}_X}`),
        " と ",
        math(String.raw`\ast_{\mathrm{Mat}_X}`),
        " は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の積とスカラー倍（",
        ref("def_matrices_indexed_by_finite_set"),
        "）である。",
      ]),
      displayMath(String.raw`E_{x,y}\cdot_{\mathrm{Mat}_X}E_{z,w}=\delta_{y,z}\ast_{\mathrm{Mat}_X}E_{x,w}`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`p,q\in X`),
        " について ",
        math(String.raw`(p,q)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`p,q\in X`),
        " を任意に固定する。以下の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）であり、有限集合の上の和についての主張はどれも ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        " に当てる。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`t\in X`),
        " について ",
        math(String.raw`r_t:=(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{w,q})\cdot_{\mathbb{C}}\delta_{z,t}\in\mathbb{C}`),
        " と置き、各 ",
        math(String.raw`t\in X`),
        " について、和の項から ",
        math(String.raw`t`),
        " に依る因子 ",
        math(String.raw`\delta_{y,t}`),
        " を係数の位置へ移した次の等式を示す。",
        math(String.raw`\delta_{x,p},\ \delta_{y,t},\ \delta_{z,t},\ \delta_{w,q}`),
        " はどれも ",
        math(String.raw`X`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）で、",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{y,t})\cdot_{\mathbb{C}^{\mathrm{vec}}}(\delta_{z,t}\cdot_{\mathbb{C}}\delta_{w,q})
&=(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{y,t})\cdot_{\mathbb{C}}(\delta_{z,t}\cdot_{\mathbb{C}}\delta_{w,q})
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(\delta_{y,t}\cdot_{\mathbb{C}}\delta_{x,p})\cdot_{\mathbb{C}}(\delta_{z,t}\cdot_{\mathbb{C}}\delta_{w,q})
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{y,t}\cdot_{\mathbb{C}}\bigl(\delta_{x,p}\cdot_{\mathbb{C}}(\delta_{z,t}\cdot_{\mathbb{C}}\delta_{w,q})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{y,t}\cdot_{\mathbb{C}}\bigl(\delta_{x,p}\cdot_{\mathbb{C}}(\delta_{w,q}\cdot_{\mathbb{C}}\delta_{z,t})\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{y,t}\cdot_{\mathbb{C}}\bigl((\delta_{x,p}\cdot_{\mathbb{C}}\delta_{w,q})\cdot_{\mathbb{C}}\delta_{z,t}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{y,t}\cdot_{\mathbb{C}}r_t
&&\left(\because\ r_t\ \text{の置き方}\right)\\
&=\delta_{y,t}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_t
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(p,q)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(E_{x,y}\cdot_{\mathrm{Mat}_X}E_{z,w}\bigr)_{p,q}
&=\sum_{t\in X}(E_{x,y})_{p,t}\cdot_{\mathbb{C}^{\mathrm{vec}}}(E_{z,w})_{t,q}
&&\left(\because\ \cdot_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{t\in X}(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{y,t})\cdot_{\mathbb{C}^{\mathrm{vec}}}(\delta_{z,t}\cdot_{\mathbb{C}}\delta_{w,q})
&&\left(\because\ \text{各}\ t\ \text{で行列単位の定義。}\blkref{def_matrix_unit}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{t\in X}\delta_{y,t}\cdot_{\mathbb{C}^{\mathrm{vec}}}r_t
&&\left(\because\ \text{各}\ t\ \text{で準備の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=r_y
&&\left(\because\ \text{主張の}\ x\ \text{に}\ y\text{、和の変数に}\ t\text{、}v_t:=r_t\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{w,q})\cdot_{\mathbb{C}}\delta_{z,y}
&&\left(\because\ r_t\ \text{の置き方で}\ t:=y\right)\\
&=\delta_{z,y}\cdot_{\mathbb{C}}(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{w,q})
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{y,z}\cdot_{\mathbb{C}}(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{w,q})
&&\left(\because\ y=z\ \text{と}\ z=y\ \text{は同値なので、場合分けが一致する。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{y,z}\cdot_{\mathbb{C}}(E_{x,w})_{p,q}
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=\bigl(\delta_{y,z}\ast_{\mathrm{Mat}_X}E_{x,w}\bigr)_{p,q}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in X`),
        " は任意だったので、",
        math(String.raw`E_{x,y}\cdot_{\mathrm{Mat}_X}E_{z,w}=\delta_{y,z}\ast_{\mathrm{Mat}_X}E_{x,w}`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_matrix_entry_map_is_linear_map",
    kind: "claim",
    title: { text: "行列の一つの成分を取り出す写像は線型写像である" },
    labels: ["claim_matrix_entry_map_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`p,q\in X`),
        " とする。写像 ",
        math(String.raw`\mathrm{ent}_{p,q}:\mathrm{Mat}_X(\mathbb{C})\to\mathbb{C}`),
        " を、",
        math(String.raw`A\in\mathrm{Mat}_X(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）について次で定める。",
      ]),
      displayMath(String.raw`\mathrm{ent}_{p,q}(A):=A_{p,q}`),
      paragraph([
        "右辺は ",
        math(String.raw`A`),
        " の ",
        math(String.raw`(p,q)`),
        " 成分で ",
        math(String.raw`\mathbb{C}`),
        " の元なので、",
        math(String.raw`\mathrm{ent}_{p,q}`),
        " は写像として一つに決まる。定義域には ℂ-線型空間 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X})`),
        "（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_vector_space"),
        "）を、値域には ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）を置く。このとき ",
        math(String.raw`\mathrm{ent}_{p,q}`),
        " は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " から ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " への線型写像（",
        ref("def_linear_map"),
        "）である。すなわち、",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の任意の元 ",
        math(String.raw`A,B`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の任意の元 ",
        math(String.raw`\lambda`),
        " について次の二つが成り立つ。",
      ]),
      list([
        [math(String.raw`\mathrm{ent}_{p,q}(A+_{\mathrm{Mat}_X}B)=\mathrm{ent}_{p,q}(A)+_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{p,q}(B)`), "（加法を保つ）"],
        [math(String.raw`\mathrm{ent}_{p,q}(\lambda\ast_{\mathrm{Mat}_X}A)=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{p,q}(A)`), "（スカラー倍を保つ）"],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A,B`),
        " を ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ent}_{p,q}(A+_{\mathrm{Mat}_X}B)
&=(A+_{\mathrm{Mat}_X}B)_{p,q}
&&\left(\because\ \mathrm{ent}_{p,q}\ \text{の定義}\right)\\
&=A_{p,q}+_{\mathbb{C}}B_{p,q}
&&\left(\because\ +_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=A_{p,q}+_{\mathbb{C}^{\mathrm{vec}}}B_{p,q}
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\mathrm{ent}_{p,q}(A)+_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{p,q}(B)
&&\left(\because\ \mathrm{ent}_{p,q}\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ent}_{p,q}(\lambda\ast_{\mathrm{Mat}_X}A)
&=(\lambda\ast_{\mathrm{Mat}_X}A)_{p,q}
&&\left(\because\ \mathrm{ent}_{p,q}\ \text{の定義}\right)\\
&=\lambda\cdot_{\mathbb{C}}A_{p,q}
&&\left(\because\ \ast_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}A_{p,q}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{p,q}(A)
&&\left(\because\ \mathrm{ent}_{p,q}\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、",
        math(String.raw`\mathrm{ent}_{p,q}`),
        " は線型写像である（",
        ref("def_linear_map"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_decomposition_of_identity_matrix_into_matrix_units",
    kind: "claim",
    title: { text: "単位行列は、対角の行列単位の和である" },
    labels: ["claim_decomposition_of_identity_matrix_into_matrix_units"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とする。ℂ-線型空間 ",
        math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X})`),
        "（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_vector_space"),
        "）の中で、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に行列単位 ",
        math(String.raw`E_{x,x}`),
        "（",
        ref("def_matrix_unit"),
        "）と係数 ",
        math(String.raw`1_{\mathbb{C}}`),
        " を与える族の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）について、次が成り立つ。",
        math(String.raw`1_{\mathrm{Mat}_X}`),
        " は単位行列（",
        ref("def_matrices_indexed_by_finite_set"),
        "）である。",
      ]),
      displayMath(String.raw`\sum_{x\in X}1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}E_{x,x}=1_{\mathrm{Mat}_X}`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の元なので、すべての ",
        math(String.raw`p,q\in X`),
        " について ",
        math(String.raw`(p,q)`),
        " 成分どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを示せばよい（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
        math(String.raw`p,q\in X`),
        " を任意に固定し、",
        math(String.raw`(p,q)`),
        " 成分を取り出す線型写像 ",
        math(String.raw`\mathrm{ent}_{p,q}:\mathrm{Mat}_X(\mathbb{C})\to\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("claim_matrix_entry_map_is_linear_map"),
        "）を使う。左辺の和は ",
        math(String.raw`\mathrm{Mat}_X(\mathbb{C})`),
        " の中の和であり、それ以外の和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）の中の有限集合 ",
        math(String.raw`X`),
        " の上の和（",
        ref("def_sum_over_finite_set"),
        "）である。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の台集合は ",
        math(String.raw`\mathbb{C}`),
        " なので、その和の値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      paragraph([
        "準備として、各 ",
        math(String.raw`x\in X`),
        " について、和の項を、係数が ",
        math(String.raw`\delta_{p,x}`),
        " の形に直した次の等式を示す。",
        math(String.raw`\delta_{x,p},\ \delta_{p,x},\ \delta_{x,q},\ \delta_{q,x}`),
        " はどれも ",
        math(String.raw`X`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）で、",
        math(String.raw`\mathbb{C}`),
        " の元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{p,q}(E_{x,x})
&=1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}(E_{x,x})_{p,q}
&&\left(\because\ \mathrm{ent}_{p,q}\ \text{の定義。}\blkref{claim_matrix_entry_map_is_linear_map}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{x,q})
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{x,q})
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\delta_{x,p}\cdot_{\mathbb{C}}\delta_{x,q}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{p,x}\cdot_{\mathbb{C}}\delta_{q,x}
&&\left(\because\ x=p\ \text{と}\ p=x\text{、}x=q\ \text{と}\ q=x\ \text{はそれぞれ同値なので、場合分けが一致する。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{p,x}\cdot_{\mathbb{C}^{\mathrm{vec}}}\delta_{q,x}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "これを使って ",
        math(String.raw`(p,q)`),
        " 成分を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\sum_{x\in X}1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}E_{x,x}\right)_{p,q}
&=\mathrm{ent}_{p,q}\left(\sum_{x\in X}1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}E_{x,x}\right)
&&\left(\because\ \mathrm{ent}_{p,q}\ \text{の定義。}\blkref{claim_matrix_entry_map_is_linear_map}\right)\\
&=\sum_{x\in X}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{p,q}(E_{x,x})
&&\left(\because\ V:=\mathrm{Mat}_X(\mathbb{C})\text{、}U:=\mathbb{C}^{\mathrm{vec}}\text{、}f:=\mathrm{ent}_{p,q}\text{、}\lambda_x:=1_{\mathbb{C}}\text{、}v_x:=E_{x,x}\ \text{として当てる。}\blkref{claim_matrix_entry_map_is_linear_map}\ \blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{x\in X}\delta_{p,x}\cdot_{\mathbb{C}^{\mathrm{vec}}}\delta_{q,x}
&&\left(\because\ \text{各}\ x\ \text{で準備の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\delta_{q,p}
&&\left(\because\ \text{主張の}\ x\ \text{に}\ p\text{、和の変数に}\ x\text{、}v_x:=\delta_{q,x}\ \text{を当てる。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=\delta_{p,q}
&&\left(\because\ q=p\ \text{と}\ p=q\ \text{は同値なので、場合分けが一致する。}\blkref{def_kronecker_delta}\right)\\
&=(1_{\mathrm{Mat}_X})_{p,q}
&&\left(\because\ 1_{\mathrm{Mat}_X}\ \text{の定義。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in X`),
        " は任意だったので、",
        math(String.raw`\sum_{x\in X}1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}E_{x,x}=1_{\mathrm{Mat}_X}`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_matrix_is_double_sum_of_entries_times_matrix_units",
    kind: "claim",
    title: { text: "行列は、成分を係数にした行列単位の和である" },
    labels: ["claim_matrix_is_double_sum_of_entries_times_matrix_units"],
    statement: [
      paragraph([
        math(String.raw`X`), " を有限集合（", ref("def_numbering_of_finite_set"), "）、", math(String.raw`F\in\mathrm{Mat}_X(\mathbb{C})`), "（",
        ref("def_matrices_indexed_by_finite_set"), "）とする。ℂ-線型空間 ", math(String.raw`(\mathrm{Mat}_X(\mathbb{C}),+_{\mathrm{Mat}_X},\ast_{\mathrm{Mat}_X},0_{\mathrm{Mat}_X})`),
        "（", ref("claim_matrices_indexed_by_finite_set_form_complex_vector_space"), "）の中の有限集合 ", math(String.raw`X`), " の上の和（", ref("def_sum_over_finite_set"),
        "）と行列単位 ", math(String.raw`E_{x,y}`), "（", ref("def_matrix_unit"), "）について、次が成り立つ。",
      ]),
      displayMath(String.raw`F=\sum_{x\in X}1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}\left(\sum_{y\in X}F_{x,y}\ast_{\mathrm{Mat}_X}E_{x,y}\right)`),
      paragraph([
        "内側の和は、", math(String.raw`x`), " を固定して ", math(String.raw`y\in X`), " に係数 ", math(String.raw`F_{x,y}\in\mathbb{C}`), " と元 ", math(String.raw`E_{x,y}`),
        " を与えた族の和であり、外側の和は、", math(String.raw`x\in X`), " にその内側の和と係数 ", math(String.raw`1_{\mathbb{C}}`), " を与えた族の和である。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺は ", math(String.raw`\mathrm{Mat}_X(\mathbb{C})`), " の元なので、すべての ", math(String.raw`p,q\in X`), " について ", math(String.raw`(p,q)`),
        " 成分どうしが ", math(String.raw`\mathbb{C}`), " の元として等しいことを示せばよい（", ref("def_matrices_indexed_by_finite_set"), "）。", math(String.raw`p,q\in X`),
        " を任意に固定し、", math(String.raw`(p,q)`), " 成分を取り出す線型写像 ", math(String.raw`\mathrm{ent}_{p,q}:\mathrm{Mat}_X(\mathbb{C})\to\mathbb{C}^{\mathrm{vec}}`), "（",
        ref("claim_matrix_entry_map_is_linear_map"), "）を使う。", math(String.raw`\mathrm{Mat}_X(\mathbb{C})`), " の中の和のほかは、和はすべて ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`), "（", ref("def_complex_numbers_as_complex_vector_space"), "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"), "）の中の有限集合 ", math(String.raw`X`), " の上の和であり、値は ", math(String.raw`\mathbb{C}`),
        " の元である。", math(String.raw`\delta`), " は ", math(String.raw`X`), " の二元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）である。",
      ]),
      paragraph(["準備の一つ目。", math(String.raw`x,y\in X`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
F_{x,y}\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{p,q}(E_{x,y})
&=F_{x,y}\cdot_{\mathbb{C}^{\mathrm{vec}}}(E_{x,y})_{p,q}
&&\left(\because\ \mathrm{ent}_{p,q}\ \text{の定義。}\blkref{claim_matrix_entry_map_is_linear_map}\right)\\
&=F_{x,y}\cdot_{\mathbb{C}^{\mathrm{vec}}}\bigl(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{y,q}\bigr)
&&\left(\because\ \text{行列単位の定義。}\blkref{def_matrix_unit}\right)\\
&=F_{x,y}\cdot_{\mathbb{C}}\bigl(\delta_{x,p}\cdot_{\mathbb{C}}\delta_{y,q}\bigr)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\bigl(F_{x,y}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)\cdot_{\mathbb{C}}\delta_{y,q}
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\delta_{y,q}\cdot_{\mathbb{C}}\bigl(F_{x,y}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{q,y}\cdot_{\mathbb{C}}\bigl(F_{x,y}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)
&&\left(\because\ y=q\ \text{と}\ q=y\ \text{は同値なので、場合分けが一致する。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{q,y}\cdot_{\mathbb{C}^{\mathrm{vec}}}\bigl(F_{x,y}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "準備の二つ目。", math(String.raw`x\in X`), " について、", ref("claim_sum_over_finite_set_with_kronecker_delta_picks_term"), " を、固定する元に ", math(String.raw`q`),
        "、和の変数に ", math(String.raw`y`), "、", math(String.raw`y`), " に与える元に ", math(String.raw`F_{x,y}\cdot_{\mathbb{C}}\delta_{x,p}`), " を当てて、次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{y\in X}\delta_{q,y}\cdot_{\mathbb{C}^{\mathrm{vec}}}\bigl(F_{x,y}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)=F_{x,q}\cdot_{\mathbb{C}}\delta_{x,p}`),
      paragraph(["準備の三つ目。", math(String.raw`x\in X`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\bigl(F_{x,q}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}\bigl(F_{x,q}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=F_{x,q}\cdot_{\mathbb{C}}\delta_{x,p}
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\delta_{x,p}\cdot_{\mathbb{C}}F_{x,q}
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\delta_{p,x}\cdot_{\mathbb{C}}F_{x,q}
&&\left(\because\ x=p\ \text{と}\ p=x\ \text{は同値なので、場合分けが一致する。}\blkref{def_kronecker_delta}\right)\\
&=\delta_{p,x}\cdot_{\mathbb{C}^{\mathrm{vec}}}F_{x,q}
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
F_{p,q}
&=\sum_{x\in X}\delta_{p,x}\cdot_{\mathbb{C}^{\mathrm{vec}}}F_{x,q}
&&\left(\because\ \text{固定する元に}\ p\text{、和の変数に}\ x\text{、}x\ \text{に与える元に}\ F_{x,q}\ \text{を当てて、右辺から左辺へ読む。}\blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=\sum_{x\in X}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\bigl(F_{x,q}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)
&&\left(\because\ \text{各}\ x\ \text{で準備の三つ目。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{x\in X}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{y\in X}\delta_{q,y}\cdot_{\mathbb{C}^{\mathrm{vec}}}\bigl(F_{x,y}\cdot_{\mathbb{C}}\delta_{x,p}\bigr)\right)
&&\left(\because\ \text{各}\ x\ \text{で準備の二つ目。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{x\in X}1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}\left(\sum_{y\in X}F_{x,y}\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ent}_{p,q}(E_{x,y})\right)
&&\left(\because\ \text{各}\ x,y\ \text{で準備の一つ目。}\blkref{claim_double_sums_over_finite_sets_with_equal_terms_are_equal}\right)\\
&=\mathrm{ent}_{p,q}\left(\sum_{x\in X}1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}\left(\sum_{y\in X}F_{x,y}\ast_{\mathrm{Mat}_X}E_{x,y}\right)\right)
&&\left(\because\ f:=\mathrm{ent}_{p,q}\text{、}Y:=X\text{、}\lambda_{x,y}:=F_{x,y}\text{、}v_{x,y}:=E_{x,y}\text{。}\blkref{claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values}\right)\\
&=\left(\sum_{x\in X}1_{\mathbb{C}}\ast_{\mathrm{Mat}_X}\left(\sum_{y\in X}F_{x,y}\ast_{\mathrm{Mat}_X}E_{x,y}\right)\right)_{p,q}
&&\left(\because\ \mathrm{ent}_{p,q}\ \text{の定義。}\blkref{claim_matrix_entry_map_is_linear_map}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`p,q\in X`), " は任意だったので、主張の等式が成り立つ（", ref("def_matrices_indexed_by_finite_set"), "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_definition_power_set_of_first_m_positive_integers",
    kind: "definition",
    title: { text: "{1,…,M} の部分集合全体の集合" },
    labels: ["def_power_set_of_first_m_positive_integers"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とする（",
        math(String.raw`M=0`),
        " のとき ",
        math(String.raw`\{1,\dots,0\}`),
        " は空集合である）。",
        math(String.raw`\{1,\dots,M\}`),
        " の部分集合全体の集合を ",
        math(String.raw`\mathcal{P}_M`),
        " と書く。",
      ]),
      displayMath(String.raw`\mathcal{P}_M:=\{\,T\ :\ T\subseteq\{1,\dots,M\}\,\}`),
      paragraph([
        math(String.raw`\mathcal{P}_M`),
        " の元 ",
        math(String.raw`T`),
        " は ",
        math(String.raw`\{1,\dots,M\}`),
        " の部分集合であり、各 ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\in T`),
        " か ",
        math(String.raw`t\notin T`),
        " のどちらか一方だけが成り立つ。",
        math(String.raw`S,T\in\mathcal{P}_M`),
        " について、",
        math(String.raw`S=T`),
        " は、すべての ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について「",
        math(String.raw`t\in S`),
        " と ",
        math(String.raw`t\in T`),
        " が同値である」ことである（集合の等しさ）。",
      ]),
      paragraph([
        math(String.raw`\mathcal{P}_M`),
        " の上の順序・演算と、",
        math(String.raw`T`),
        " の元の個数・",
        math(String.raw`T`),
        " の元を小さい順に並べる写像は、この定義では定めない。",
        math(String.raw`\mathcal{P}_M`),
        " が有限集合（",
        ref("def_numbering_of_finite_set"),
        "）であることも、この定義では主張しない。行列の添字集合に ",
        math(String.raw`\mathcal{P}_M`),
        " を当てるのに要る番号付けは、後の定義と主張で構成する。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_definition_binary_numbering_of_power_set",
    kind: "definition",
    title: { text: "{1,…,M} の部分集合全体の 2 進の番号付けの写像" },
    labels: ["def_binary_numbering_of_power_set"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " について、整数 ",
        math(String.raw`2^M\in\mathbb{Z}_{\ge 1}`),
        " を ",
        math(String.raw`2^0:=1`),
        "、",
        math(String.raw`2^M:=2\cdot 2^{M-1}`),
        "（",
        math(String.raw`M\ge 1`),
        "）で帰納的に定める。",
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " について、写像 ",
        math(String.raw`e_M:\{1,\dots,2^M\}\to\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）を、",
        math(String.raw`M`),
        " についての帰納法で次のように定める。",
      ]),
      list([
        [
          math(String.raw`M=0`),
          " のとき、",
          math(String.raw`\{1,\dots,2^0\}=\{1\}`),
          " であり、",
          math(String.raw`e_0(1):=\emptyset`),
          " とする。",
        ],
        [
          math(String.raw`M\ge 1`),
          " のとき、",
          math(String.raw`k\in\{1,\dots,2^M\}`),
          " について、",
          math(String.raw`k\le 2^{M-1}`),
          " なら ",
          math(String.raw`e_M(k):=e_{M-1}(k)`),
          "、",
          math(String.raw`k>2^{M-1}`),
          " なら ",
          math(String.raw`e_M(k):=e_{M-1}(k-2^{M-1})\cup\{M\}`),
          " とする。",
        ],
      ]),
      paragraph([
        "この式が ",
        math(String.raw`\{1,\dots,2^M\}`),
        " の各元に ",
        math(String.raw`\mathcal{P}_M`),
        " の元を一つずつ定めることを、",
        math(String.raw`M`),
        " についての帰納法で確かめる。",
        math(String.raw`M=0`),
        " のとき、",
        math(String.raw`\emptyset\subseteq\{1,\dots,0\}=\emptyset`),
        " なので ",
        math(String.raw`e_0(1)\in\mathcal{P}_0`),
        " である。",
        math(String.raw`M\ge 1`),
        " とし、",
        math(String.raw`e_{M-1}`),
        " が ",
        math(String.raw`\{1,\dots,2^{M-1}\}`),
        " の各元に ",
        math(String.raw`\mathcal{P}_{M-1}`),
        " の元を一つずつ定めているとする。",
      ]),
      list([
        [
          math(String.raw`1\le k\le 2^{M-1}`),
          " のとき、",
          math(String.raw`k\in\{1,\dots,2^{M-1}\}`),
          " なので ",
          math(String.raw`e_{M-1}(k)`),
          " は定まり、",
          math(String.raw`e_{M-1}(k)\subseteq\{1,\dots,M-1\}\subseteq\{1,\dots,M\}`),
          " なので ",
          math(String.raw`e_M(k)\in\mathcal{P}_M`),
          " である。",
        ],
        [
          math(String.raw`2^{M-1}<k\le 2^M`),
          " のとき、",
          math(String.raw`2^M=2^{M-1}+2^{M-1}`),
          " なので ",
          math(String.raw`0<k-2^{M-1}\le 2^{M-1}`),
          "、すなわち ",
          math(String.raw`k-2^{M-1}\in\{1,\dots,2^{M-1}\}`),
          " であり、",
          math(String.raw`e_{M-1}(k-2^{M-1})`),
          " は定まる。",
          math(String.raw`e_{M-1}(k-2^{M-1})\subseteq\{1,\dots,M-1\}`),
          " かつ ",
          math(String.raw`\{M\}\subseteq\{1,\dots,M\}`),
          " なので、",
          math(String.raw`e_M(k)=e_{M-1}(k-2^{M-1})\cup\{M\}\subseteq\{1,\dots,M\}`),
          "、すなわち ",
          math(String.raw`e_M(k)\in\mathcal{P}_M`),
          " である。",
        ],
      ]),
      paragraph([
        "二つの場合は ",
        math(String.raw`k\le 2^{M-1}`),
        " か ",
        math(String.raw`k>2^{M-1}`),
        " のどちらか一方だけが成り立つので、",
        math(String.raw`e_M(k)`),
        " は一つに決まる。",
        math(String.raw`k-2^{M-1}`),
        " は ",
        math(String.raw`\mathbb{Z}`),
        " の中の差であり、",
        math(String.raw`\cup`),
        " は集合の和集合、",
        math(String.raw`\{M\}`),
        " は ",
        math(String.raw`M`),
        " だけを元にもつ集合である。",
      ]),
      paragraph([
        math(String.raw`(2^M,e_M)`),
        " が ",
        math(String.raw`\mathcal{P}_M`),
        " の番号付け（",
        ref("def_numbering_of_finite_set"),
        "）であること、すなわち ",
        math(String.raw`e_M`),
        " が単射かつ全射であることは、この定義では主張しない。後の主張で示す。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_binary_numbering_is_numbering_of_power_set",
    kind: "claim",
    title: { text: "2 進の番号付けの写像は {1,…,M} の部分集合全体の番号付けを与え、部分集合全体は有限集合である" },
    labels: ["claim_binary_numbering_is_numbering_of_power_set"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とする。",
        math(String.raw`2^M\in\mathbb{Z}_{\ge 1}`),
        " と写像 ",
        math(String.raw`e_M:\{1,\dots,2^M\}\to\mathcal{P}_M`),
        " を ",
        ref("def_binary_numbering_of_power_set"),
        " のものとする。このとき組 ",
        math(String.raw`(2^M,e_M)`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        "（",
        ref("def_power_set_of_first_m_positive_integers"),
        "）の番号付け（",
        ref("def_numbering_of_finite_set"),
        "）である。したがって ",
        math(String.raw`\mathcal{P}_M`),
        " は有限集合（",
        ref("def_numbering_of_finite_set"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`M`),
        " についての帰納法で、",
        math(String.raw`e_M`),
        " が単射の条件と全射の条件（",
        ref("def_numbering_of_finite_set"),
        "）を満たすことを示す。集合の等しさ ",
        math(String.raw`S=T`),
        "（",
        math(String.raw`S,T\in\mathcal{P}_M`),
        "）は、",
        ref("def_power_set_of_first_m_positive_integers"),
        " に書いたとおり、すべての ",
        math(String.raw`t\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`t\in S`),
        " と ",
        math(String.raw`t\in T`),
        " が同値であることで確かめる。",
      ]),
      paragraph([
        math(String.raw`M=0`),
        " のとき。",
        math(String.raw`\{1,\dots,2^0\}=\{1\}`),
        " である（",
        ref("def_binary_numbering_of_power_set"),
        "）。単射の条件: ",
        math(String.raw`k,l\in\{1\}`),
        " なら ",
        math(String.raw`k=1=l`),
        " である。全射の条件: ",
        math(String.raw`T\in\mathcal{P}_0`),
        " とする。",
        math(String.raw`\{1,\dots,0\}`),
        " は空集合なので、「すべての ",
        math(String.raw`t\in\{1,\dots,0\}`),
        " について ",
        math(String.raw`t\in T`),
        " と ",
        math(String.raw`t\in\emptyset`),
        " が同値である」は成り立ち、",
        math(String.raw`T=\emptyset=e_0(1)`),
        " である（",
        ref("def_binary_numbering_of_power_set"),
        "）。よって ",
        math(String.raw`k:=1`),
        " が ",
        math(String.raw`e_0(k)=T`),
        " を満たす。",
      ]),
      paragraph([
        math(String.raw`M\ge 1`),
        " とし、",
        math(String.raw`(2^{M-1},e_{M-1})`),
        " が ",
        math(String.raw`\mathcal{P}_{M-1}`),
        " の番号付けであると仮定する（帰納法の仮定）。式を短くするため ",
        math(String.raw`h:=2^{M-1}\in\mathbb{Z}_{\ge 1}`),
        " と置く。",
        math(String.raw`2^M=2\cdot h=h+h`),
        " である（",
        ref("def_binary_numbering_of_power_set"),
        "）。準備として、",
        math(String.raw`k\in\{1,\dots,2^M\}`),
        " について次の三つを示す。",
      ]),
      list([
        [
          "（ア）",
          math(String.raw`k\le h`),
          " なら ",
          math(String.raw`M\notin e_M(k)`),
          "。実際、",
          math(String.raw`e_M(k)=e_{M-1}(k)`),
          "（",
          ref("def_binary_numbering_of_power_set"),
          "）であり、",
          math(String.raw`e_{M-1}(k)\in\mathcal{P}_{M-1}`),
          " なので ",
          math(String.raw`e_{M-1}(k)\subseteq\{1,\dots,M-1\}`),
          " であり、",
          math(String.raw`M\notin\{1,\dots,M-1\}`),
          " である。",
        ],
        [
          "（イ）",
          math(String.raw`k>h`),
          " なら ",
          math(String.raw`M\in e_M(k)`),
          "。実際、",
          math(String.raw`e_M(k)=e_{M-1}(k-h)\cup\{M\}`),
          "（",
          ref("def_binary_numbering_of_power_set"),
          "）であり、",
          math(String.raw`M\in\{M\}`),
          " である。",
        ],
        [
          "（ウ）",
          math(String.raw`k>h`),
          " なら、すべての ",
          math(String.raw`t\in\{1,\dots,M-1\}`),
          " について次の同値が成り立つ。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
t\in e_M(k)
&\iff t\in e_{M-1}(k-h)\cup\{M\}
&&\left(\because\ e_M\ \text{の定義（}k>h\text{ の場合）。}\blkref{def_binary_numbering_of_power_set}\right)\\
&\iff \bigl(t\in e_{M-1}(k-h)\ \text{または}\ t=M\bigr)
&&\left(\because\ \text{和集合と}\ \{M\}\ \text{の定義}\right)\\
&\iff t\in e_{M-1}(k-h)
&&\left(\because\ t\le M-1<M\ \text{なので}\ t\neq M\right).
\end{aligned}`),
      paragraph([
        "単射の条件を示す。",
        math(String.raw`k,l\in\{1,\dots,2^M\}`),
        " とし、",
        math(String.raw`e_M(k)=e_M(l)`),
        " とする。",
        math(String.raw`M\in\{1,\dots,M\}`),
        " なので、",
        math(String.raw`M\in e_M(k)`),
        " と ",
        math(String.raw`M\in e_M(l)`),
        " は同値である。",
      ]),
      list([
        [
          math(String.raw`k\le h`),
          " かつ ",
          math(String.raw`l>h`),
          " のとき、（ア）から ",
          math(String.raw`M\notin e_M(k)`),
          "、（イ）から ",
          math(String.raw`M\in e_M(l)`),
          " であり、この同値に反する。よってこの場合は起こらない。",
          math(String.raw`k>h`),
          " かつ ",
          math(String.raw`l\le h`),
          " の場合も、",
          math(String.raw`k`),
          " と ",
          math(String.raw`l`),
          " を入れ替えた同じ理由で起こらない。",
        ],
        [
          math(String.raw`k\le h`),
          " かつ ",
          math(String.raw`l\le h`),
          " のとき、",
          math(String.raw`e_{M-1}(k)=e_M(k)=e_M(l)=e_{M-1}(l)`),
          "（",
          ref("def_binary_numbering_of_power_set"),
          "）であり、",
          math(String.raw`k,l\in\{1,\dots,h\}`),
          " なので、帰納法の仮定の単射の条件から ",
          math(String.raw`k=l`),
          " である。",
        ],
        [
          math(String.raw`k>h`),
          " かつ ",
          math(String.raw`l>h`),
          " のとき、",
          math(String.raw`k-h,\ l-h\in\{1,\dots,h\}`),
          "（",
          ref("def_binary_numbering_of_power_set"),
          " の中で確かめた）である。すべての ",
          math(String.raw`t\in\{1,\dots,M-1\}`),
          " について次の同値が成り立つので、",
          math(String.raw`\mathcal{P}_{M-1}`),
          " の元として ",
          math(String.raw`e_{M-1}(k-h)=e_{M-1}(l-h)`),
          " である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。帰納法の仮定の単射の条件から ",
          math(String.raw`k-h=l-h`),
          "、すなわち ",
          math(String.raw`k=l`),
          " である。",
        ],
      ]),
      displayMath(String.raw`\begin{aligned}
t\in e_{M-1}(k-h)
&\iff t\in e_M(k)
&&\left(\because\ \text{（ウ）を}\ k\ \text{に適用}\right)\\
&\iff t\in e_M(l)
&&\left(\because\ e_M(k)=e_M(l)\ \text{と}\ t\in\{1,\dots,M\}\right)\\
&\iff t\in e_{M-1}(l-h)
&&\left(\because\ \text{（ウ）を}\ l\ \text{に適用}\right).
\end{aligned}`),
      paragraph([
        "全射の条件を示す。",
        math(String.raw`T\in\mathcal{P}_M`),
        " とし、",
        math(String.raw`T':=\{\,t\in\{1,\dots,M-1\}\ :\ t\in T\,\}`),
        " と置く。",
        math(String.raw`T'\subseteq\{1,\dots,M-1\}`),
        " なので ",
        math(String.raw`T'\in\mathcal{P}_{M-1}`),
        " であり、帰納法の仮定の全射の条件から、",
        math(String.raw`e_{M-1}(j)=T'`),
        " を満たす ",
        math(String.raw`j\in\{1,\dots,h\}`),
        " がある。",
        math(String.raw`T'`),
        " の定義から、すべての ",
        math(String.raw`t\in\{1,\dots,M-1\}`),
        " について ",
        math(String.raw`t\in T'`),
        " と ",
        math(String.raw`t\in T`),
        " は同値である。",
      ]),
      list([
        [
          math(String.raw`M\notin T`),
          " のとき、",
          math(String.raw`k:=j`),
          " と置く。",
          math(String.raw`1\le j\le h\le h+h=2^M`),
          " なので ",
          math(String.raw`k\in\{1,\dots,2^M\}`),
          " であり、",
          math(String.raw`k\le h`),
          " なので ",
          math(String.raw`e_M(k)=e_{M-1}(j)=T'`),
          "（",
          ref("def_binary_numbering_of_power_set"),
          "）である。",
          math(String.raw`t\in\{1,\dots,M-1\}`),
          " については ",
          math(String.raw`t\in e_M(k)\iff t\in T'\iff t\in T`),
          " である。",
          math(String.raw`t=M`),
          " については、（ア）から ",
          math(String.raw`M\notin e_M(k)`),
          "、仮定から ",
          math(String.raw`M\notin T`),
          " なので、",
          math(String.raw`M\in e_M(k)`),
          " と ",
          math(String.raw`M\in T`),
          " はともに成り立たず、同値である。よって ",
          math(String.raw`e_M(k)=T`),
          " である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
        [
          math(String.raw`M\in T`),
          " のとき、",
          math(String.raw`k:=j+h`),
          " と置く（",
          math(String.raw`\mathbb{Z}`),
          " の中の和）。",
          math(String.raw`h<j+h\le h+h=2^M`),
          " なので ",
          math(String.raw`k\in\{1,\dots,2^M\}`),
          " かつ ",
          math(String.raw`k>h`),
          " であり、",
          math(String.raw`k-h=j`),
          " である。",
          math(String.raw`t\in\{1,\dots,M-1\}`),
          " については、（ウ）から ",
          math(String.raw`t\in e_M(k)\iff t\in e_{M-1}(j)\iff t\in T'\iff t\in T`),
          " である。",
          math(String.raw`t=M`),
          " については、（イ）から ",
          math(String.raw`M\in e_M(k)`),
          "、仮定から ",
          math(String.raw`M\in T`),
          " なので、両方が成り立ち、同値である。よって ",
          math(String.raw`e_M(k)=T`),
          " である（",
          ref("def_power_set_of_first_m_positive_integers"),
          "）。",
        ],
      ]),
      paragraph([
        "どちらの場合も ",
        math(String.raw`e_M(k)=T`),
        " を満たす ",
        math(String.raw`k\in\{1,\dots,2^M\}`),
        " があるので、",
        math(String.raw`e_M`),
        " は全射の条件を満たす。以上で、すべての ",
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`(2^M,e_M)`),
        " が ",
        math(String.raw`\mathcal{P}_M`),
        " の番号付けであることが示された。",
        math(String.raw`\mathcal{P}_M`),
        " は番号付けを少なくとも一つもつので、有限集合である（",
        ref("def_numbering_of_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_definition_numbering_of_pairs_of_subsets",
    kind: "definition",
    title: { text: "{1,…,M} の部分集合の組全体の番号付けの写像" },
    labels: ["def_numbering_of_pairs_of_subsets"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`2^M\in\mathbb{Z}_{\ge 1}`),
        " と ",
        math(String.raw`e_M:\{1,\dots,2^M\}\to\mathcal{P}_M`),
        " を ",
        ref("def_binary_numbering_of_power_set"),
        " のものとする。整数 ",
        math(String.raw`N_M:=(2^M)^2`),
        " を ",
        ref("def_power_of_nonnegative_integer"),
        " の冪（",
        math(String.raw`n:=2^M`),
        "、",
        math(String.raw`k:=2`),
        "）で定め、",
        math(String.raw`\eta:=\eta_{2^M,2}:\{1,\dots,N_M\}\to X_{2^M,2}`),
        " を ",
        ref("def_base_n_numbering_of_maps"),
        " の写像とする（",
        math(String.raw`X_{2^M,2}`),
        " は ",
        ref("def_set_of_maps_between_initial_segments"),
        " の集合）。写像 ",
        math(String.raw`p_M:\{1,\dots,N_M\}\to\mathcal{P}_M\times\mathcal{P}_M`),
        " を次で定める。",
      ]),
      displayMath(String.raw`p_M(m):=\Bigl(e_M\bigl(\eta(m)(1)\bigr),\ e_M\bigl(\eta(m)(2)\bigr)\Bigr)`),
      paragraph([
        math(String.raw`m\in\{1,\dots,N_M\}`),
        " について ",
        math(String.raw`\eta(m)`),
        " は写像 ",
        math(String.raw`\{1,2\}\to\{1,\dots,2^M\}`),
        " なので、",
        math(String.raw`\eta(m)(1)`),
        " と ",
        math(String.raw`\eta(m)(2)`),
        " は ",
        math(String.raw`e_M`),
        " の定義域の元であり、右辺は ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M`),
        " の元（",
        math(String.raw`\mathcal{P}_M`),
        " の二つの元の順序対）として一つに決まる。",
        math(String.raw`2^M\ge 1`),
        " なので ",
        math(String.raw`N_M=2^M\cdot(2^M\cdot 1)\ge 1`),
        " である（",
        ref("def_power_of_nonnegative_integer"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_numbering_of_pairs_of_subsets_is_numbering",
    kind: "claim",
    title: { text: "部分集合の組全体の番号付けの写像は番号付けを与え、部分集合の組全体は有限集合である" },
    labels: ["claim_numbering_of_pairs_of_subsets_is_numbering"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`N_M`),
        " と ",
        math(String.raw`p_M:\{1,\dots,N_M\}\to\mathcal{P}_M\times\mathcal{P}_M`),
        " を ",
        ref("def_numbering_of_pairs_of_subsets"),
        " のものとする。このとき組 ",
        math(String.raw`(N_M,p_M)`),
        " は ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M`),
        " の番号付け（",
        ref("def_numbering_of_finite_set"),
        "）である。したがって ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M`),
        " は有限集合である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\eta:=\eta_{2^M,2}`),
        " と書く。",
        math(String.raw`(2^M,e_M)`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        " の番号付けであり（",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）、",
        math(String.raw`(N_M,\eta)`),
        " は ",
        math(String.raw`X_{2^M,2}`),
        " の番号付けである（",
        ref("claim_base_n_numbering_is_numbering_of_maps"),
        " で ",
        math(String.raw`n:=2^M`),
        "、",
        math(String.raw`k:=2`),
        "）。",
        math(String.raw`e_M^{-1}:\mathcal{P}_M\to\{1,\dots,2^M\}`),
        " と ",
        math(String.raw`\eta^{-1}:X_{2^M,2}\to\{1,\dots,N_M\}`),
        " をそれぞれの逆写像とする（",
        ref("def_numbering_of_finite_set"),
        "）。",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M`),
        " の二つの元 ",
        math(String.raw`(S,T)`),
        " と ",
        math(String.raw`(S',T')`),
        " が等しいとは、",
        math(String.raw`S=S'`),
        " かつ ",
        math(String.raw`T=T'`),
        " であることである（順序対の等しさ）。",
      ]),
      paragraph([
        "単射の条件を示す。",
        math(String.raw`m,m'\in\{1,\dots,N_M\}`),
        " が ",
        math(String.raw`p_M(m)=p_M(m')`),
        " を満たすとする。順序対の等しさから、",
        math(String.raw`s\in\{1,2\}`),
        " のそれぞれについて ",
        math(String.raw`e_M(\eta(m)(s))=e_M(\eta(m')(s))`),
        " であり（",
        ref("def_numbering_of_pairs_of_subsets"),
        "）、",
        math(String.raw`e_M`),
        " の単射の条件から ",
        math(String.raw`\eta(m)(s)=\eta(m')(s)`),
        " である。これがすべての ",
        math(String.raw`s\in\{1,2\}`),
        " で成り立つので、",
        math(String.raw`X_{2^M,2}`),
        " の元として ",
        math(String.raw`\eta(m)=\eta(m')`),
        " であり（",
        ref("def_set_of_maps_between_initial_segments"),
        "）、",
        math(String.raw`\eta`),
        " の単射の条件から ",
        math(String.raw`m=m'`),
        " である。",
      ]),
      paragraph([
        "全射の条件を示す。",
        math(String.raw`(S,T)\in\mathcal{P}_M\times\mathcal{P}_M`),
        " をとる。写像 ",
        math(String.raw`x:\{1,2\}\to\{1,\dots,2^M\}`),
        " を ",
        math(String.raw`x(1):=e_M^{-1}(S)`),
        "、",
        math(String.raw`x(2):=e_M^{-1}(T)`),
        " で定めると ",
        math(String.raw`x\in X_{2^M,2}`),
        " であり、",
        math(String.raw`m:=\eta^{-1}(x)\in\{1,\dots,N_M\}`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
p_M(m)
&=\Bigl(e_M\bigl(\eta(m)(1)\bigr),\ e_M\bigl(\eta(m)(2)\bigr)\Bigr)
&&\left(\because\ \blkref{def_numbering_of_pairs_of_subsets}\right)\\
&=\Bigl(e_M\bigl(\eta(\eta^{-1}(x))(1)\bigr),\ e_M\bigl(\eta(\eta^{-1}(x))(2)\bigr)\Bigr)
&&\left(\because\ m=\eta^{-1}(x)\right)\\
&=\bigl(e_M(x(1)),\ e_M(x(2))\bigr)
&&\left(\because\ \eta(\eta^{-1}(x))=x\text{。}\blkref{def_numbering_of_finite_set}\right)\\
&=\bigl(e_M(e_M^{-1}(S)),\ e_M(e_M^{-1}(T))\bigr)
&&\left(\because\ x\ \text{の定め方}\right)\\
&=(S,T)
&&\left(\because\ e_M(e_M^{-1}(U))=U\ \text{を}\ U:=S,T\ \text{に。}\blkref{def_numbering_of_finite_set}\right).
\end{aligned}`),
      paragraph([
        "以上で ",
        math(String.raw`(N_M,p_M)`),
        " は ",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M`),
        " の番号付けであり、",
        math(String.raw`\mathcal{P}_M\times\mathcal{P}_M`),
        " は有限集合である（",
        ref("def_numbering_of_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_definition_reindexing_of_matrices_by_numbering",
    kind: "definition",
    title: { text: "番号付けによる行列の添字の付け替え" },
    labels: ["def_reindexing_of_matrices_by_numbering"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を有限集合、",
        math(String.raw`(n,e)`),
        " をその番号付け（",
        ref("def_numbering_of_finite_set"),
        "）とする。",
        math(String.raw`\mathrm{id}_n:\{1,\dots,n\}\to\{1,\dots,n\}`),
        " を恒等写像とすると、",
        math(String.raw`(n,\mathrm{id}_n)`),
        " は ",
        math(String.raw`\{1,\dots,n\}`),
        " の番号付けなので（",
        ref("def_numbering_of_finite_set"),
        "）、",
        math(String.raw`\{1,\dots,n\}`),
        " は有限集合であり、",
        math(String.raw`\mathrm{Mat}_{\{1,\dots,n\}}(\mathbb{C})`),
        "（",
        ref("def_matrices_indexed_by_finite_set"),
        "）が定まる。写像 ",
        math(String.raw`\nu_e:\mathrm{Mat}_X(\mathbb{C})\to\mathrm{Mat}_{\{1,\dots,n\}}(\mathbb{C})`),
        " を、",
        math(String.raw`F\in\mathrm{Mat}_X(\mathbb{C})`),
        " と ",
        math(String.raw`k,l\in\{1,\dots,n\}`),
        " についての成分で次のように定める。",
      ]),
      displayMath(String.raw`\nu_e(F)_{k,l}:=F_{e(k),e(l)}`),
      paragraph([
        math(String.raw`e(k),e(l)\in X`),
        " なので右辺は ",
        math(String.raw`F`),
        " の成分で ",
        math(String.raw`\mathbb{C}`),
        " の元であり、",
        math(String.raw`\nu_e(F)`),
        " は写像 ",
        math(String.raw`\{1,\dots,n\}\times\{1,\dots,n\}\to\mathbb{C}`),
        " として一つに決まる。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_definition_reindexing_of_matrices_by_inverse_numbering",
    kind: "definition",
    title: { text: "番号付けの逆写像による行列の添字の付け替え" },
    labels: ["def_reindexing_of_matrices_by_inverse_numbering"],
    statement: [
      paragraph([
        math(String.raw`X`),
        "、",
        math(String.raw`(n,e)`),
        " を ",
        ref("def_reindexing_of_matrices_by_numbering"),
        " のものとし、",
        math(String.raw`e^{-1}:X\to\{1,\dots,n\}`),
        " を ",
        math(String.raw`e`),
        " の逆写像（",
        ref("def_numbering_of_finite_set"),
        "）とする。写像 ",
        math(String.raw`\mu_e:\mathrm{Mat}_{\{1,\dots,n\}}(\mathbb{C})\to\mathrm{Mat}_X(\mathbb{C})`),
        " を、",
        math(String.raw`G\in\mathrm{Mat}_{\{1,\dots,n\}}(\mathbb{C})`),
        " と ",
        math(String.raw`x,y\in X`),
        " についての成分で次のように定める。",
      ]),
      displayMath(String.raw`\mu_e(G)_{x,y}:=G_{e^{-1}(x),e^{-1}(y)}`),
      paragraph([
        math(String.raw`e^{-1}(x),e^{-1}(y)\in\{1,\dots,n\}`),
        " なので右辺は ",
        math(String.raw`G`),
        " の成分で ",
        math(String.raw`\mathbb{C}`),
        " の元であり、",
        math(String.raw`\mu_e(G)`),
        " は写像 ",
        math(String.raw`X\times X\to\mathbb{C}`),
        " として一つに決まる。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "番号付けによる行列の添字の付け替えは ℂ-代数の準同型である" },
    labels: ["claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`X`),
        "、",
        math(String.raw`(n,e)`),
        "、",
        math(String.raw`\nu_e`),
        " を ",
        ref("def_reindexing_of_matrices_by_numbering"),
        " のものとし、",
        math(String.raw`B:=\mathrm{Mat}_X(\mathbb{C})`),
        "、",
        math(String.raw`B':=\mathrm{Mat}_{\{1,\dots,n\}}(\mathbb{C})`),
        " と書く。",
        math(String.raw`B`),
        " と ",
        math(String.raw`B'`),
        " は ℂ-代数であり（",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        "）、",
        math(String.raw`\nu_e:B\to B'`),
        " は ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " と ",
        math(String.raw`\{1,\dots,n\}`),
        " は有限集合なので（",
        ref("def_reindexing_of_matrices_by_numbering"),
        "）、",
        ref("claim_matrices_indexed_by_finite_set_form_complex_algebra"),
        " により ",
        math(String.raw`B`),
        " と ",
        math(String.raw`B'`),
        " は ℂ-代数である。",
        ref("def_complex_algebra_homomorphism"),
        " に書き出した四つの等式を示す。行列の等しさは成分の等しさなので（",
        ref("def_matrices_indexed_by_finite_set"),
        "）、",
        math(String.raw`F,G\in B`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        "、",
        math(String.raw`k,l\in\{1,\dots,n\}`),
        " について両辺の ",
        math(String.raw`(k,l)`),
        " 成分が等しいことを示す。",
      ]),
      paragraph(["加法を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\nu_e(F+_B G)_{k,l}
&=(F+_B G)_{e(k),e(l)}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_numbering}\right)\\
&=F_{e(k),e(l)}+_{\mathbb{C}}G_{e(k),e(l)}
&&\left(\because\ \text{行列の和。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\nu_e(F)_{k,l}+_{\mathbb{C}}\nu_e(G)_{k,l}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_numbering}\right)\\
&=\bigl(\nu_e(F)+_{B'}\nu_e(G)\bigr)_{k,l}
&&\left(\because\ \text{行列の和。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph(["乗法を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\nu_e(F\cdot_B G)_{k,l}
&=(F\cdot_B G)_{e(k),e(l)}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_numbering}\right)\\
&=\sum_{z\in X}F_{e(k),z}\cdot_{\mathbb{C}^{\mathrm{vec}}}G_{z,e(l)}
&&\left(\because\ \text{行列の積。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\sum_{j=1}^{n}F_{e(k),e(j)}\cdot_{\mathbb{C}^{\mathrm{vec}}}G_{e(j),e(l)}
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を番号付け}\ (n,e)\ \text{で}\right)\\
&=\sum_{j=1}^{n}\nu_e(F)_{k,j}\cdot_{\mathbb{C}^{\mathrm{vec}}}\nu_e(G)_{j,l}
&&\left(\because\ \text{各}\ j\ \text{で}\ \blkref{def_reindexing_of_matrices_by_numbering}\text{。}\blkref{claim_linear_combinations_with_equal_terms_are_equal}\right)\\
&=\sum_{j\in\{1,\dots,n\}}\nu_e(F)_{k,j}\cdot_{\mathbb{C}^{\mathrm{vec}}}\nu_e(G)_{j,l}
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を番号付け}\ (n,\mathrm{id}_n)\ \text{で、右辺から左辺へ読む}\right)\\
&=\bigl(\nu_e(F)\cdot_{B'}\nu_e(G)\bigr)_{k,l}
&&\left(\because\ \text{行列の積。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "乗法の単位元を保つこと。",
        math(String.raw`e`),
        " は写像なので ",
        math(String.raw`k=l`),
        " なら ",
        math(String.raw`e(k)=e(l)`),
        " であり、",
        math(String.raw`e`),
        " の単射の条件から ",
        math(String.raw`e(k)=e(l)`),
        " なら ",
        math(String.raw`k=l`),
        " である（",
        ref("def_numbering_of_finite_set"),
        "）。したがって ",
        math(String.raw`X`),
        " の中の ",
        math(String.raw`e(k)=e(l)`),
        " と ",
        math(String.raw`\{1,\dots,n\}`),
        " の中の ",
        math(String.raw`k=l`),
        " は同値であり、二つのクロネッカーのデルタは等しい（",
        ref("def_kronecker_delta"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\nu_e(1_B)_{k,l}
&=(1_B)_{e(k),e(l)}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_numbering}\right)\\
&=\delta_{e(k),e(l)}
&&\left(\because\ \text{単位行列。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\delta_{k,l}
&&\left(\because\ e(k)=e(l)\ \text{と}\ k=l\ \text{は同値。}\blkref{def_kronecker_delta}\right)\\
&=(1_{B'})_{k,l}
&&\left(\because\ \text{単位行列。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\nu_e(\lambda\ast_B F)_{k,l}
&=(\lambda\ast_B F)_{e(k),e(l)}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_numbering}\right)\\
&=\lambda\cdot_{\mathbb{C}}F_{e(k),e(l)}
&&\left(\because\ \text{行列のスカラー倍。}\blkref{def_matrices_indexed_by_finite_set}\right)\\
&=\lambda\cdot_{\mathbb{C}}\nu_e(F)_{k,l}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_numbering}\right)\\
&=\bigl(\lambda\ast_{B'}\nu_e(F)\bigr)_{k,l}
&&\left(\because\ \text{行列のスカラー倍。}\blkref{def_matrices_indexed_by_finite_set}\right).
\end{aligned}`),
      paragraph([
        "四つの等式がすべての ",
        math(String.raw`k,l`),
        " で成り立つので、",
        math(String.raw`\nu_e`),
        " は加法・乗法・乗法の単位元・スカラー倍を保つ。すなわち ",
        math(String.raw`\nu_e`),
        " は環の準同型（",
        ref("def_ring_homomorphism"),
        "）かつ線型写像（",
        ref("def_linear_map"),
        "）であり、ℂ-代数の準同型である（",
        ref("def_complex_algebra_homomorphism"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_inverse_reindexing_after_reindexing_of_matrices_is_identity",
    kind: "claim",
    title: { text: "番号付けで付け替えた行列を逆写像で付け替え直すと、元の行列に戻る" },
    labels: ["claim_inverse_reindexing_after_reindexing_of_matrices_is_identity"],
    statement: [
      paragraph([
        math(String.raw`X`),
        "、",
        math(String.raw`(n,e)`),
        "、",
        math(String.raw`\nu_e`),
        " を ",
        ref("def_reindexing_of_matrices_by_numbering"),
        "、",
        math(String.raw`\mu_e`),
        " を ",
        ref("def_reindexing_of_matrices_by_inverse_numbering"),
        " のものとする。すべての ",
        math(String.raw`F\in\mathrm{Mat}_X(\mathbb{C})`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\mu_e\bigl(\nu_e(F)\bigr)=F`),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y\in X`),
        " をとる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu_e\bigl(\nu_e(F)\bigr)_{x,y}
&=\nu_e(F)_{e^{-1}(x),e^{-1}(y)}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_inverse_numbering}\right)\\
&=F_{e(e^{-1}(x)),e(e^{-1}(y))}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_numbering}\right)\\
&=F_{x,y}
&&\left(\because\ e(e^{-1}(u))=u\ \text{を}\ u:=x,y\ \text{に。}\blkref{def_numbering_of_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y\in X`),
        " は任意だったので、行列として ",
        math(String.raw`\mu_e(\nu_e(F))=F`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_reindexing_after_inverse_reindexing_of_matrices_is_identity",
    kind: "claim",
    title: { text: "逆写像で付け替えた行列を番号付けで付け替え直すと、元の行列に戻る" },
    labels: ["claim_reindexing_after_inverse_reindexing_of_matrices_is_identity"],
    statement: [
      paragraph([
        math(String.raw`X`),
        "、",
        math(String.raw`(n,e)`),
        "、",
        math(String.raw`\nu_e`),
        " を ",
        ref("def_reindexing_of_matrices_by_numbering"),
        "、",
        math(String.raw`\mu_e`),
        " を ",
        ref("def_reindexing_of_matrices_by_inverse_numbering"),
        " のものとする。すべての ",
        math(String.raw`G\in\mathrm{Mat}_{\{1,\dots,n\}}(\mathbb{C})`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\nu_e\bigl(\mu_e(G)\bigr)=G`),
    ],
    proof: [
      paragraph([
        math(String.raw`k,l\in\{1,\dots,n\}`),
        " をとる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\nu_e\bigl(\mu_e(G)\bigr)_{k,l}
&=\mu_e(G)_{e(k),e(l)}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_numbering}\right)\\
&=G_{e^{-1}(e(k)),e^{-1}(e(l))}
&&\left(\because\ \blkref{def_reindexing_of_matrices_by_inverse_numbering}\right)\\
&=G_{k,l}
&&\left(\because\ e^{-1}(e(j))=j\ \text{を}\ j:=k,l\ \text{に。}\blkref{def_numbering_of_finite_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`k,l`),
        " は任意だったので、行列として ",
        math(String.raw`\nu_e(\mu_e(G))=G`),
        " である（",
        ref("def_matrices_indexed_by_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "番号付けの逆写像による行列の添字の付け替えは ℂ-代数の準同型である" },
    labels: ["claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`X`),
        "、",
        math(String.raw`(n,e)`),
        " を ",
        ref("def_reindexing_of_matrices_by_numbering"),
        "、",
        math(String.raw`\mu_e`),
        " を ",
        ref("def_reindexing_of_matrices_by_inverse_numbering"),
        " のものとし、",
        math(String.raw`B:=\mathrm{Mat}_X(\mathbb{C})`),
        "、",
        math(String.raw`B':=\mathrm{Mat}_{\{1,\dots,n\}}(\mathbb{C})`),
        " と書く。",
        math(String.raw`\mu_e:B'\to B`),
        " は ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`B`),
        " と ",
        math(String.raw`B'`),
        " は ℂ-代数であり、",
        math(String.raw`\nu_e:B\to B'`),
        " は ℂ-代数の準同型である（",
        ref("claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism"),
        "）。",
        math(String.raw`G,H\in B'`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " をとり、",
        ref("def_complex_algebra_homomorphism"),
        " に書き出した四つの等式を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu_e(G+_{B'}H)
&=\mu_e\Bigl(\nu_e\bigl(\mu_e(G)\bigr)+_{B'}\nu_e\bigl(\mu_e(H)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_reindexing_after_inverse_reindexing_of_matrices_is_identity}\ \text{を}\ G,H\ \text{に}\right)\\
&=\mu_e\Bigl(\nu_e\bigl(\mu_e(G)+_B\mu_e(H)\bigr)\Bigr)
&&\left(\because\ \nu_e\ \text{は加法を保つ。}\blkref{claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism}\right)\\
&=\mu_e(G)+_B\mu_e(H)
&&\left(\because\ \blkref{claim_inverse_reindexing_after_reindexing_of_matrices_is_identity}\right),\\[4pt]
\mu_e(G\cdot_{B'}H)
&=\mu_e\Bigl(\nu_e\bigl(\mu_e(G)\bigr)\cdot_{B'}\nu_e\bigl(\mu_e(H)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_reindexing_after_inverse_reindexing_of_matrices_is_identity}\ \text{を}\ G,H\ \text{に}\right)\\
&=\mu_e\Bigl(\nu_e\bigl(\mu_e(G)\cdot_B\mu_e(H)\bigr)\Bigr)
&&\left(\because\ \nu_e\ \text{は乗法を保つ。}\blkref{claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism}\right)\\
&=\mu_e(G)\cdot_B\mu_e(H)
&&\left(\because\ \blkref{claim_inverse_reindexing_after_reindexing_of_matrices_is_identity}\right),\\[4pt]
\mu_e(1_{B'})
&=\mu_e\bigl(\nu_e(1_B)\bigr)
&&\left(\because\ \nu_e\ \text{は乗法の単位元を保つ。}\blkref{claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism}\right)\\
&=1_B
&&\left(\because\ \blkref{claim_inverse_reindexing_after_reindexing_of_matrices_is_identity}\right),\\[4pt]
\mu_e(\lambda\ast_{B'}G)
&=\mu_e\Bigl(\lambda\ast_{B'}\nu_e\bigl(\mu_e(G)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_reindexing_after_inverse_reindexing_of_matrices_is_identity}\right)\\
&=\mu_e\Bigl(\nu_e\bigl(\lambda\ast_B\mu_e(G)\bigr)\Bigr)
&&\left(\because\ \nu_e\ \text{はスカラー倍を保つ。}\blkref{claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism}\right)\\
&=\lambda\ast_B\mu_e(G)
&&\left(\because\ \blkref{claim_inverse_reindexing_after_reindexing_of_matrices_is_identity}\right).
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`\mu_e`),
        " は環の準同型（",
        ref("def_ring_homomorphism"),
        "）かつ線型写像（",
        ref("def_linear_map"),
        "）であり、ℂ-代数の準同型である（",
        ref("def_complex_algebra_homomorphism"),
        "）。",
      ]),
    ],
  },
  {
    id: "complex_matrix_algebra_theorem_binary_numbering_gives_isomorphism_of_matrix_algebras",
    kind: "theorem",
    title: { text: "系：2 進の番号付けによる、部分集合全体で添字づけた行列環と番号で添字づけた行列環の同型" },
    labels: ["theorem_binary_numbering_gives_isomorphism_of_matrix_algebras"],
    statement: [
      paragraph([
        math(String.raw`M\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`2^M`),
        " と ",
        math(String.raw`e_M:\{1,\dots,2^M\}\to\mathcal{P}_M`),
        " を ",
        ref("def_binary_numbering_of_power_set"),
        " のものとする。",
        math(String.raw`(2^M,e_M)`),
        " は ",
        math(String.raw`\mathcal{P}_M`),
        " の番号付けである（",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）。",
        ref("def_reindexing_of_matrices_by_numbering"),
        " と ",
        ref("def_reindexing_of_matrices_by_inverse_numbering"),
        " を ",
        math(String.raw`X:=\mathcal{P}_M`),
        "、",
        math(String.raw`(n,e):=(2^M,e_M)`),
        " に当てた写像を",
      ]),
      displayMath(String.raw`\nu_{e_M}:\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})\to\mathrm{Mat}_{\{1,\dots,2^M\}}(\mathbb{C}),\quad \nu_{e_M}(F)_{k,l}=F_{e_M(k),e_M(l)},`),
      displayMath(String.raw`\mu_{e_M}:\mathrm{Mat}_{\{1,\dots,2^M\}}(\mathbb{C})\to\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C}),\quad \mu_{e_M}(G)_{S,T}=G_{e_M^{-1}(S),e_M^{-1}(T)}`),
      paragraph([
        "とする。このとき次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\nu_{e_M}`),
          " と ",
          math(String.raw`\mu_{e_M}`),
          " はどちらも ℂ-代数の準同型（",
          ref("def_complex_algebra_homomorphism"),
          "）である。",
        ],
        [
          "すべての ",
          math(String.raw`F\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
          " について ",
          math(String.raw`\mu_{e_M}(\nu_{e_M}(F))=F`),
          " であり、すべての ",
          math(String.raw`G\in\mathrm{Mat}_{\{1,\dots,2^M\}}(\mathbb{C})`),
          " について ",
          math(String.raw`\nu_{e_M}(\mu_{e_M}(G))=G`),
          " である。",
        ],
      ]),
      paragraph([
        "したがって ",
        math(String.raw`\nu_{e_M}`),
        " は全単射であり、その逆写像は ",
        math(String.raw`\mu_{e_M}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X:=\mathcal{P}_M`),
        "、",
        math(String.raw`(n,e):=(2^M,e_M)`),
        " は ",
        ref("def_reindexing_of_matrices_by_numbering"),
        " の仮定（有限集合とその番号付け）を満たす（",
        ref("claim_binary_numbering_is_numbering_of_power_set"),
        "）。",
        math(String.raw`\nu_{e_M}`),
        " が ℂ-代数の準同型であることは ",
        ref("claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism"),
        "、",
        math(String.raw`\mu_{e_M}`),
        " が ℂ-代数の準同型であることは ",
        ref("claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism"),
        "、",
        math(String.raw`\mu_{e_M}(\nu_{e_M}(F))=F`),
        " は ",
        ref("claim_inverse_reindexing_after_reindexing_of_matrices_is_identity"),
        "、",
        math(String.raw`\nu_{e_M}(\mu_{e_M}(G))=G`),
        " は ",
        ref("claim_reindexing_after_inverse_reindexing_of_matrices_is_identity"),
        " である。",
      ]),
      paragraph([
        "単射であること。",
        math(String.raw`F,F'\in\mathrm{Mat}_{\mathcal{P}_M}(\mathbb{C})`),
        " が ",
        math(String.raw`\nu_{e_M}(F)=\nu_{e_M}(F')`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
F&=\mu_{e_M}\bigl(\nu_{e_M}(F)\bigr)
&&\left(\because\ \blkref{claim_inverse_reindexing_after_reindexing_of_matrices_is_identity}\right)\\
&=\mu_{e_M}\bigl(\nu_{e_M}(F')\bigr)
&&\left(\because\ \nu_{e_M}(F)=\nu_{e_M}(F')\right)\\
&=F'
&&\left(\because\ \blkref{claim_inverse_reindexing_after_reindexing_of_matrices_is_identity}\right).
\end{aligned}`),
      paragraph([
        "全射であること。",
        math(String.raw`G\in\mathrm{Mat}_{\{1,\dots,2^M\}}(\mathbb{C})`),
        " について、",
        math(String.raw`\mu_{e_M}(G)`),
        " は ",
        math(String.raw`\nu_{e_M}(\mu_{e_M}(G))=G`),
        " を満たす（",
        ref("claim_reindexing_after_inverse_reindexing_of_matrices_is_identity"),
        "）。",
      ]),
      paragraph([
        "したがって ",
        math(String.raw`\nu_{e_M}`),
        " は全単射である。",
        math(String.raw`G`),
        " について ",
        math(String.raw`\nu_{e_M}(F)=G`),
        " を満たすただ一つの ",
        math(String.raw`F`),
        " は、",
        math(String.raw`\mu_{e_M}(G)`),
        " が ",
        math(String.raw`\nu_{e_M}(\mu_{e_M}(G))=G`),
        " を満たすので ",
        math(String.raw`\mu_{e_M}(G)`),
        " であり、逆写像は ",
        math(String.raw`\mu_{e_M}`),
        " である。",
      ]),
    ],
  },
]);
