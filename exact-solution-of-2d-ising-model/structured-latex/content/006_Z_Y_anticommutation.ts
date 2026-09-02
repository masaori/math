import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

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
        ref("kronecker_product_rule"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(A_1\boxtimes\cdots\boxtimes A_M)(B_1\boxtimes\cdots\boxtimes B_M)
&= (A_1B_1)\boxtimes\cdots\boxtimes(A_MB_M)
&&(\because\ \text{クロネッカー積の積の規則})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\boxtimes`),
        " は各因子について ",
        math(String.raw`\mathbb{C}`),
        "-線型であるから（",
        ref("kronecker_multilinear"),
        "）、",
        math(String.raw`c \in \mathbb{C}`),
        " と ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " に対し",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_1\boxtimes\cdots\boxtimes\overbrace{(c\,C_j)}^{j\text{th}}\boxtimes\cdots\boxtimes C_M
&= c\,\left(C_1\boxtimes\cdots\boxtimes C_M\right)
&&(\because\ \text{クロネッカー積の第 } j \text{ 因子についての } \mathbb{C}\text{-線型性})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。準備は以上である。以下、この 2 つを ",
        math(String.raw`(\ast)`),
        " (積の規則)・",
        math(String.raw`(\ast\ast)`),
        " (第 ",
        math(String.raw`j`),
        " 因子についての線型性) と呼ぶ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
XY
&= (x_1\boxtimes\cdots\boxtimes x_M)(y_1\boxtimes\cdots\boxtimes y_M)
&&(\because\ X, Y \text{ の定義}) \\
&= (x_1y_1)\boxtimes\cdots\boxtimes(x_My_M)
&&(\because\ (\ast))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
YX
&= (y_1\boxtimes\cdots\boxtimes y_M)(x_1\boxtimes\cdots\boxtimes x_M)
&&(\because\ X, Y \text{ の定義}) \\
&= (y_1x_1)\boxtimes\cdots\boxtimes(y_Mx_M)
&&(\because\ (\ast)) \\
&= (x_1y_1)\boxtimes\cdots\boxtimes\overbrace{(y_jx_j)}^{j\text{th}}\boxtimes\cdots\boxtimes(x_My_M)
&&(\because\ i\neq j \text{ では } y_ix_i = x_iy_i) \\
&= (x_1y_1)\boxtimes\cdots\boxtimes\overbrace{\left((-1)\,(x_jy_j)\right)}^{j\text{th}}\boxtimes\cdots\boxtimes(x_My_M)
&&(\because\ y_jx_j = -(x_jy_j)) \\
&= (-1)\left((x_1y_1)\boxtimes\cdots\boxtimes(x_My_M)\right)
&&(\because\ (\ast\ast)) \\
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
          "3 式すべてで共通に使えるよう主張として切り出した（lean/Ising2D/Part006 の " +
          "siteProd_anticomm_of_single_site に対応する）。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_001_claim_anticommutation_relations_Z_and_Y",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ",
      ordinal: 1,
    },
    title: { tex: String.raw`Z\text{と}Y\text{の反交換関係}` },
    labels: ["anticommutator_of_Z_and_Y"],
    statement: [
      displayMath(
        String.raw`[Z_\mu, Z_\nu]_+ = 2I_{\mathrm{Mat}(2^M,\mathbb{C})} \delta^M_{(\mu,\nu)}, \quad
[Z_\mu, Y_\nu]_+ = 0, \quad
[Y_\mu, Y_\nu]_+ = 2I_{\mathrm{Mat}(2^M,\mathbb{C})} \delta^M_{(\mu,\nu)}`,
      ),
    ],
    proof: [
      paragraph([
        "記号を固定する。",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        math(String.raw`2`),
        " 次の単位行列）とし、",
        math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " を ",
        math(String.raw`2^M`),
        " 次の単位行列とする。",
        ref("kronecker_product_rule"),
        " (2) より",
        math(String.raw`\ I\boxtimes\cdots\boxtimes I = I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "（左辺は ",
        math(String.raw`M`),
        " 個のクロネッカー積）である。",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " は ",
        ref("pauli_matrix_products"),
        " の Pauli 行列である。",
      ]),
      paragraph([
        "添字について。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m, Y_m`),
        " は ",
        math(String.raw`m \in \{1,\dots,M\}`),
        " に対して定義され、",
        math(String.raw`Z_{M+1} := Z_1`),
        "、",
        math(String.raw`Y_{M+1} := Y_1`),
        " と ",
        math(String.raw`M`),
        " 周期に拡張されている。よって ",
        math(String.raw`Z_\mu, Y_\nu`),
        " は添字の ",
        math(String.raw`M`),
        " を法とする剰余類のみで定まり、代表元を ",
        math(String.raw`\mu,\nu \in \{1,\dots,M\}`),
        " にとってよい。この範囲では ",
        math(String.raw`\mu \equiv \nu \pmod M \iff \mu = \nu`),
        " であるから、",
        ref("def_delta_M"),
        " より",
      ]),
      displayMath(
        String.raw`\delta^M_{(\mu,\nu)} =
\begin{cases}
1 & (\mu = \nu) \\
0 & (\mu \neq \nu)
\end{cases}
\qquad (\mu,\nu \in \{1,\dots,M\})`,
      ),
      paragraph([
        "クロネッカー積による表示。",
        math(String.raw`m \in \{1,\dots,M\}`),
        " に対し、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_k^a`),
        " が「第 ",
        math(String.raw`k`),
        " 因子だけが ",
        math(String.raw`\sigma^a`),
        " で他は ",
        math(String.raw`I`),
        " であるクロネッカー積」であることと、",
        ref("kronecker_product_rule"),
        " (1)（クロネッカー積どうしの積は各サイトごとの積）および ",
        math(String.raw`I\sigma^a = \sigma^a I = \sigma^a`),
        " から、",
      ]),
      displayMath(
        String.raw`\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^a
= \overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(m-1)\text{th}}
\boxtimes\overbrace{\sigma^a}^{m\text{th}}
\boxtimes\overbrace{I}^{(m+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}
\quad (a \in \{x,y,z\})`,
      ),
      paragraph([
        "が成り立つ。特に ",
        ref("def_transfer_matrix_symbols"),
        " の定義により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu &= \overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }Z_\mu\text{ の定義と、直前の表示を }a=z\text{ で読む}\bigr)\\
Y_\mu &= \overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }Y_\mu\text{ の定義と、直前の表示を }a=y\text{ で読む}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\mu = 1`),
        " のときは第 1 因子の左に因子が無い。この端の場合も次の一続きで定義と一致する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_1
&= \sigma^z\boxtimes I\boxtimes\cdots\boxtimes I
&&\bigl(\because\ \text{上のクロネッカー積表示を }\mu=1\text{ で読む}\bigr)\\
&= \sigma_1^z
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }\sigma_1^z\text{ の定義}\bigr)\\[2mm]
Y_1
&= \sigma^y\boxtimes I\boxtimes\cdots\boxtimes I
&&\bigl(\because\ \text{上のクロネッカー積表示を }\mu=1\text{ で読む}\bigr)\\
&= \sigma_1^y
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の }\sigma_1^y\text{ の定義}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\mu = M`),
        " のときは第 ",
        math(String.raw`M`),
        " 因子の右に因子が無い。",
      ]),

      paragraph([
        "以下、",
        math(String.raw`\mu,\nu \in \{1,\dots,M\}`),
        " を固定して 3 つの式を順に示す。",
      ]),

      paragraph([
        "【第 1 式】",
        math(String.raw`[Z_\mu, Z_\nu]_+ = 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\delta^M_{(\mu,\nu)}`),
        "。",
      ]),
      paragraph([math(String.raw`\mu = \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Z_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則 (1)}) \\
&= \overbrace{I}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{I}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \text{Pauli 行列の積}) \\
&= \overbrace{I}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{I}^{(\mu-1)\text{th}}
\boxtimes\overbrace{I}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^z\sigma^z = I.\ \text{Pauli 行列の積}) \\
&= I\boxtimes\cdots\boxtimes I
&&(\because\ II = I) \\
&= I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{クロネッカー積の積の規則 (2)})
\end{aligned}`,
      ),
      paragraph(["であるから"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\mu]_+
&= Z_\mu Z_\mu + Z_\mu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= I_{\mathrm{Mat}(2^M,\mathbb{C})} + I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{上の計算を 2 箇所へ適用}) \\
&= 2 I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{同じ行列の和}) \\
&= 2 I_{\mathrm{Mat}(2^M,\mathbb{C})}\,\delta^M_{(\mu,\mu)}
&&(\because\ \delta^M_{(\mu,\mu)} = 1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu < \nu`),
        " のとき、",
        math(String.raw`Z_\mu, Z_\nu`),
        " をクロネッカー積で表して各サイトごとに積をとると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Z_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ \text{上のクロネッカー積による表示}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^z)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則 (1)}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^x = II = I,\ I\sigma^a = \sigma^a)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Z_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ \text{上のクロネッカー積による表示}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z I)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則 (1)}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^x = II = I,\ \sigma^a I = \sigma^a)
\end{aligned}`,
      ),
      paragraph([
        "2 つの結果は第 ",
        math(String.raw`\mu`),
        " 因子のみが異なり、そこでは ",
        math(String.raw`\sigma^x\sigma^z = -\,\sigma^z\sigma^x`),
        "（",
        ref("pauli_matrix_products"),
        "）である。クロネッカー積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）よりスカラー ",
        math(String.raw`-1`),
        " が外へ出て、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^z = -\,\sigma^z\sigma^x.\ \text{Pauli 行列の積}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \text{第 }\mu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Z_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\nu]_+
&= Z_\mu Z_\nu + Z_\nu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Z_\nu + (-\,Z_\mu Z_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu > \nu`),
        " のときは、上と同じ計算で ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\nu`),
        " の役割が入れ替わる。因子ごとの積は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Z_\nu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{クロネッカー積の積の規則 (1)、}\ \sigma^x\sigma^x = II = I) \\
Z_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{クロネッカー積の積の規則 (1)、}\ \sigma^x\sigma^x = II = I)
\end{aligned}`,
      ),
      paragraph([
        "であり（第 ",
        math(String.raw`i < \nu`),
        " 因子は ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、",
        math(String.raw`\nu < i < \mu`),
        " では一方が ",
        math(String.raw`I`),
        " なので ",
        math(String.raw`\sigma^x`),
        "、第 ",
        math(String.raw`\mu`),
        " 因子は一方が ",
        math(String.raw`I`),
        " なので ",
        math(String.raw`\sigma^z`),
        "、",
        math(String.raw`i > \mu`),
        " では ",
        math(String.raw`II = I`),
        "）、食い違うのは第 ",
        math(String.raw`\nu`),
        " 因子だけで ",
        math(String.raw`\sigma^z\sigma^x = -\,\sigma^x\sigma^z`),
        "（",
        ref("pauli_matrix_products"),
        "）である。クロネッカー積の第 ",
        math(String.raw`\nu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^x\sigma^z)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^z\sigma^x = -\,\sigma^x\sigma^z.\ \text{Pauli 行列の積}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \text{第 }\nu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Z_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\nu]_+
&= Z_\mu Z_\nu + Z_\nu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Z_\nu + (-\,Z_\mu Z_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\mu \neq \nu`),
        " では ",
        math(String.raw`[Z_\mu,Z_\nu]_+ = 0 = 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\delta^M_{(\mu,\nu)}`),
        " であり、第 1 式が示された。",
      ]),

      paragraph([
        "【第 2 式】",
        math(String.raw`[Z_\mu, Y_\nu]_+ = 0`),
        "。この式は ",
        math(String.raw`\mu = \nu`),
        " の場合も含めてすべての ",
        math(String.raw`\mu,\nu`),
        " で成り立つ（対角成分も消える）。",
        math(String.raw`\mu = \nu`),
        "、",
        math(String.raw`\mu < \nu`),
        "、",
        math(String.raw`\mu > \nu`),
        " の 3 通りに分ける。",
      ]),
      paragraph([
        math(String.raw`\mu = \nu`),
        " のとき、",
        math(String.raw`Z_\mu`),
        " と ",
        math(String.raw`Y_\mu`),
        " は第 ",
        math(String.raw`\mu`),
        " 因子以外がすべて等しいので、因子ごとの積をとると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Y_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ Z_\mu,\ Y_\mu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \text{Pauli 行列の積}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Z_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \text{Pauli 行列の積}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      paragraph([
        "食い違うのは第 ",
        math(String.raw`\mu`),
        " 因子だけであり、",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^y\sigma^z = -\,\sigma^z\sigma^y`),
        "。クロネッカー積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^y\sigma^z = -\,\sigma^z\sigma^y.\ \text{Pauli 行列の積}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \text{第 }\mu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Y_\mu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Y_\mu]_+
&= Z_\mu Y_\mu + Y_\mu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Y_\mu + (-\,Z_\mu Y_\mu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        "（これは ",
        ref("tensor_anticommutation_from_single_site"),
        " を ",
        math(String.raw`j = \mu`),
        "、",
        math(String.raw`x_i, y_i`),
        " を上の各因子として適用した形でもある。）",
      ]),
      paragraph([
        math(String.raw`\mu < \nu`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Y_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ Z_\mu,\ Y_\nu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \text{Pauli 行列の積}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ I\ \text{は積の単位元}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ Y_\nu,\ Z_\mu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y I)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y I)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \text{Pauli 行列の積}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ I\ \text{は積の単位元}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      paragraph([
        "第 ",
        math(String.raw`i`),
        " 因子を ",
        math(String.raw`i`),
        " の範囲ごとに比べると、",
        math(String.raw`i < \mu`),
        " では両者とも ",
        math(String.raw`I`),
        "、",
        math(String.raw`\mu < i < \nu`),
        " では両者とも ",
        math(String.raw`\sigma^x`),
        "、",
        math(String.raw`i = \nu`),
        " では両者とも ",
        math(String.raw`\sigma^y`),
        "、",
        math(String.raw`i > \nu`),
        " では両者とも ",
        math(String.raw`I`),
        " で一致する。食い違うのは第 ",
        math(String.raw`\mu`),
        " 因子だけで、そこは ",
        math(String.raw`\sigma^z\sigma^x`),
        " と ",
        math(String.raw`\sigma^x\sigma^z = -\,\sigma^z\sigma^x`),
        "（",
        ref("pauli_matrix_products"),
        "）である。クロネッカー積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^z = -\,\sigma^z\sigma^x.\ \text{Pauli 行列の積}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \text{第 }\mu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Y_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Y_\nu]_+
&= Z_\mu Y_\nu + Y_\nu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Y_\nu + (-\,Z_\mu Y_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu > \nu`),
        " のとき、",
        math(String.raw`\nu < \mu`),
        " なので第 ",
        math(String.raw`\nu`),
        " 因子で ",
        math(String.raw`Z_\mu`),
        " 側が ",
        math(String.raw`\sigma^x`),
        "、",
        math(String.raw`Y_\nu`),
        " 側が ",
        math(String.raw`\sigma^y`),
        " になる。因子ごとの積をとると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Y_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\nu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ Z_\mu,\ Y_\nu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z I)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^z I)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \text{Pauli 行列の積}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ I\ \text{は積の単位元}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\nu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ Y_\nu,\ Z_\mu\ \text{の定義}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^z)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \text{Pauli 行列の積}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ I\ \text{は積の単位元}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ II = I.\ \text{単位行列どうしの積})
\end{aligned}`,
      ),
      paragraph([
        "食い違うのは第 ",
        math(String.raw`\nu`),
        " 因子だけで、そこは ",
        math(String.raw`\sigma^x\sigma^y`),
        " と ",
        math(String.raw`\sigma^y\sigma^x = -\,\sigma^x\sigma^y`),
        "（",
        ref("pauli_matrix_products"),
        "）である。よって同様に、クロネッカー積の第 ",
        math(String.raw`\nu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " が外へ出て",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^y\sigma^x = -\,\sigma^x\sigma^y.\ \text{Pauli 行列の積}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^z}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \text{第 }\nu\text{ 因子についての線型性}) \\
&= -\,Z_\mu Y_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Y_\nu]_+
&= Z_\mu Y_\nu + Y_\nu Z_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Z_\mu Y_\nu + (-\,Z_\mu Y_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        "3 通りすべてで ",
        math(String.raw`[Z_\mu, Y_\nu]_+ = 0`),
        " が示されたので、第 2 式が成り立つ。",
      ]),

      paragraph([
        "【第 3 式】",
        math(String.raw`[Y_\mu, Y_\nu]_+ = 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\delta^M_{(\mu,\nu)}`),
        "。",
      ]),
      paragraph([math(String.raw`\mu = \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Y_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則 (1)}) \\
&= \overbrace{I}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{I}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^x\sigma^x = I.\ \text{Pauli 行列の積}) \\
&= \overbrace{I}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{I}^{(\mu-1)\text{th}}
\boxtimes\overbrace{I}^{\mu\text{th}}
\boxtimes\overbrace{(II)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \sigma^y\sigma^y = I.\ \text{Pauli 行列の積}) \\
&= I\boxtimes\cdots\boxtimes I
&&(\because\ II = I) \\
&= I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{クロネッカー積の積の規則 (2)})
\end{aligned}`,
      ),
      paragraph(["であるから"]),
      displayMath(
        String.raw`\begin{aligned}
[Y_\mu, Y_\mu]_+
&= Y_\mu Y_\mu + Y_\mu Y_\mu
&&(\because\ \text{反交換子の定義}) \\
&= I_{\mathrm{Mat}(2^M,\mathbb{C})} + I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{上の計算を 2 箇所へ適用}) \\
&= 2 I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{同じ行列の和}) \\
&= 2 I_{\mathrm{Mat}(2^M,\mathbb{C})}\,\delta^M_{(\mu,\mu)}
&&(\because\ \delta^M_{(\mu,\mu)} = 1)
\end{aligned}`,
      ),
      paragraph([math(String.raw`\mu < \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Y_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ \text{上のクロネッカー積による表示}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(I\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則 (1)}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^x = II = I,\ I\sigma^a = \sigma^a)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Y_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^x}^{\mu\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes\overbrace{I}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes\overbrace{I}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{I}^{M\text{th}}\right)
&&(\because\ \text{上のクロネッカー積による表示}) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\boxtimes\overbrace{(\sigma^y I)}^{\nu\text{th}}
\boxtimes\overbrace{(II)}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{(II)}^{M\text{th}}
&&(\because\ \text{クロネッカー積の積の規則 (1)}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^x = II = I,\ \sigma^a I = \sigma^a)
\end{aligned}`,
      ),
      paragraph([
        "食い違うのは第 ",
        math(String.raw`\mu`),
        " 因子だけで、そこは ",
        math(String.raw`\sigma^y\sigma^x`),
        " と ",
        math(String.raw`\sigma^x\sigma^y = -\,\sigma^y\sigma^x`),
        "（",
        ref("pauli_matrix_products"),
        "）である。クロネッカー積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Y_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^y\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^x\sigma^y = -\,\sigma^y\sigma^x.\ \text{Pauli 行列の積}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\mu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\nu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \text{第 }\mu\text{ 因子についての線型性}) \\
&= -\,Y_\mu Y_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Y_\mu, Y_\nu]_+
&= Y_\mu Y_\nu + Y_\nu Y_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Y_\mu Y_\nu + (-\,Y_\mu Y_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu > \nu`),
        " のときは、上の計算で ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\nu`),
        " の役割を入れ替えればよい。因子ごとの積は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Y_\nu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{クロネッカー積の積の規則 (1)、}\ \sigma^x\sigma^x = II = I) \\
Y_\nu Y_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{クロネッカー積の積の規則 (1)、}\ \sigma^x\sigma^x = II = I)
\end{aligned}`,
      ),
      paragraph([
        "であり（第 ",
        math(String.raw`i < \nu`),
        " 因子は ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、",
        math(String.raw`\nu < i < \mu`),
        " では一方が ",
        math(String.raw`I`),
        " なので ",
        math(String.raw`\sigma^x`),
        "、第 ",
        math(String.raw`\mu`),
        " 因子は一方が ",
        math(String.raw`I`),
        " なので ",
        math(String.raw`\sigma^y`),
        "、",
        math(String.raw`i > \mu`),
        " では ",
        math(String.raw`II = I`),
        "）、食い違うのは第 ",
        math(String.raw`\nu`),
        " 因子だけで ",
        math(String.raw`\sigma^y\sigma^x = -\,\sigma^x\sigma^y`),
        " であるから、クロネッカー積の第 ",
        math(String.raw`\nu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Y_\mu
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \text{上の計算}) \\
&= I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(-\,\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I
&&(\because\ \sigma^y\sigma^x = -\,\sigma^x\sigma^y.\ \text{Pauli 行列の積}) \\
&= -\left(I\boxtimes\cdots\boxtimes I
\boxtimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\boxtimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\boxtimes\overbrace{\sigma^y}^{\mu\text{th}}
\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \text{第 }\nu\text{ 因子についての線型性}) \\
&= -\,Y_\mu Y_\nu
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
[Y_\mu, Y_\nu]_+
&= Y_\mu Y_\nu + Y_\nu Y_\mu
&&(\because\ \text{反交換子の定義}) \\
&= Y_\mu Y_\nu + (-\,Y_\mu Y_\nu)
&&(\because\ \text{直前の等式}) \\
&= 0
&&(\because\ \text{加法の逆元})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\mu \neq \nu`),
        " では ",
        math(String.raw`[Y_\mu,Y_\nu]_+ = 0 = 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\delta^M_{(\mu,\nu)}`),
        " であり、第 3 式が示された。以上で 3 式すべてが証明された。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-31 の式変形統一で、Z_μ・Y_μ のクロネッカー積表示の二行の根拠（定義の適用と直前の表示の読み）を、" +
          "前置の日本語文だけに置かず、他の証明と同じ行末の根拠列（aligned の &&）へも明記した。内容・式・参照は変えていない。",
        "原文の μ<ν のテンソル積展開を全ステップ忠実に再現した（σ^x σ^z = -σ^z σ^x による相殺）。",
        "原文が TODO のまま残していた [Z_μ,Y_ν]_+ = 0 と [Y_μ,Y_ν]_+ = 2Iδ^M を、" +
          "原文と同じ「テンソル因子を並べて書く」書式で場合分けごとに証明した。" +
          "[Z_μ,Y_ν]_+ は μ=ν でも 0 になる（σ^y σ^z = -σ^z σ^y で対角も消える）ことを明示した。" +
          "設計は lean/Ising2D/Part006/Claim000_AnticommutatorZY.lean（anticomm_Z_Z, anticomm_Z_Y, " +
          "anticomm_Y_Y）を参考にしたが、人手証明は Lean に依存せず自己完結している。",
        "原文の μ<ν の計算はテンソル因子の位置に I_{(C^2)^{⊗M}}（全体の単位元）を書いていたが、" +
          "テンソル因子に入るのは 2×2 の単位行列 I_{Mat(2,C)} なので、そちらへ直した。",
        "原文は μ>ν の場合を「左右対称に同様」で済ませていたが、食い違うサイトが μ から ν へ移るので、" +
          "その場合も因子ごとに書き下した。",
        "抽象テンソル積の記法を廃した。⊗ を <def_kronecker> のクロネッカー積 ⊠ へ、" +
          "Mat(2,C)^{⊗M} を Mat(2^M,C) へ、I_{(C^2)^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ" +
          "置き換えた。根拠として挙げていた「テンソル積代数の積の定義」は " +
          "<kronecker_product_rule> (1)、「テンソル積の第 j 因子についての C-線型性」は " +
          "<kronecker_multilinear> の参照に直した。μ>ν の場合に符号 -1 を外へ出す箇所は" +
          "根拠を書いていなかったので、同じく <kronecker_multilinear> を明示した" +
          "（README のゴール設定 2 節に従う）。",
      ],
    },
  },
]);
