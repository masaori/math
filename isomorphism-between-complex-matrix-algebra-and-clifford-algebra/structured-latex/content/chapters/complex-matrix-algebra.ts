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
]);
