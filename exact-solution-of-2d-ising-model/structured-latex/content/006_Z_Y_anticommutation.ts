import { defineBlocks, paragraph, math, displayMath, list } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_Z_Y_anticommutation",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 8 },
    title: { tex: String.raw`Z\text{と}Y\text{の反交換関係}` },
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
      paragraph(["とする。このとき ", math(String.raw`\mathrm{Mat}(2,\mathbb{C})`), " の中で"]),
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
&&(\because i\cdot i=-1) \\
&= 1
&&(\because \mathbb{R} \text{ の符号の計算})
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
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^x
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult}) \\
&= I
&&(\because I \text{ の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^y
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \sigma^y \text{ の定義}) \\
&= \begin{pmatrix}(-i)\cdot i&0\\0&i\cdot(-i)\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix}
&&(\because \text{上の準備}) \\
&= I
&&(\because I \text{ の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^z
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult}\text{ と }(-1)\cdot(-1)=1) \\
&= I
&&(\because I \text{ の定義})
\end{aligned}`,
      ),
      paragraph(["次に反可換性の 3 式について、"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^x
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \sigma^z,\ \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}0&1\\-1&0\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^z
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \sigma^x,\ \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}0&-1\\1&0\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult}) \\
&= -\begin{pmatrix}0&1\\-1&0\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義と} \mathbb{C} \text{ の符号の計算}) \\
&= -\,\sigma^z\sigma^x
&&(\because \text{上で計算した}\ \sigma^z\sigma^x)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \sigma^y,\ \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^y
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \sigma^x,\ \sigma^y \text{ の定義}) \\
&= \begin{pmatrix}i&0\\0&-i\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult}) \\
&= -\begin{pmatrix}-i&0\\0&i\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義と} \mathbb{C} \text{ の符号の計算}) \\
&= -\,\sigma^y\sigma^x
&&(\because \text{上で計算した}\ \sigma^y\sigma^x)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^z
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \sigma^y,\ \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}0&i\\i&0\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult}\text{ と }(-i)\cdot(-1)=i)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \sigma^z,\ \sigma^y \text{ の定義}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&&(\because \text{行列の積の定義。}\blkref{mat_mult}\text{ と }(-1)\cdot i=-i) \\
&= -\begin{pmatrix}0&i\\i&0\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義と} \mathbb{C} \text{ の符号の計算}) \\
&= -\,\sigma^y\sigma^z
&&(\because \text{上で計算した}\ \sigma^y\sigma^z)
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
        " のすべての元と可換である（",
        math(String.raw`IA = AI = A`),
        "）。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文の [Z_μ,Z_ν]_+ の証明は σ^x σ^z = -σ^z σ^x を" +
          "無根拠に使っており、[Z_μ,Y_ν]_+ / [Y_μ,Y_ν]_+ ではさらに σ^y σ^x, σ^y σ^z の" +
          "反可換性と σ^y σ^y = I が要る。参照先を作るため、単一サイトの積公式を独立の主張として切り出した。",
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
]);
