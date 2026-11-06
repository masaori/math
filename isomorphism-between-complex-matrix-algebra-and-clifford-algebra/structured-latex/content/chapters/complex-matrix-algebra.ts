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
]);
