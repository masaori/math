import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_Z_Y_anticommutation",
    kind: "heading",
    level: 2,
    sourcePath: "_old/typst/main.typ",
    sourceOrdinal: 8,
    title: { tex: String.raw`Z\text{と}Y\text{の反交換関係}` },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    kind: "claim",
    sourcePath: "structured-latex/content/006_Z_Y_anticommutation.mjs",
    sourceOrdinal: 1,
    title: { text: "Pauli 行列の積" },
    labels: ["pauli_matrix_products"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_k^x,\sigma_k^y,\sigma_k^z`),
        " の各テンソル因子に現れる Pauli 行列を",
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
        "すべて ",
        math(String.raw`2\times 2`),
        " 行列の積の成分計算（",
        ref("mat_mult"),
        "）である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^x &= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
= \begin{pmatrix}1&0\\0&1\end{pmatrix} = I \\
\sigma^y\sigma^y &= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
= \begin{pmatrix}(-i)\cdot i&0\\0&i\cdot(-i)\end{pmatrix}
= \begin{pmatrix}1&0\\0&1\end{pmatrix} = I \\
\sigma^z\sigma^z &= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
= \begin{pmatrix}1&0\\0&1\end{pmatrix} = I
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`(-i)\cdot i = -(i\cdot i) = -(-1) = 1`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の積の計算）。次に反可換性の 3 式について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^x &= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
= \begin{pmatrix}0&1\\-1&0\end{pmatrix} \\
\sigma^x\sigma^z &= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
= \begin{pmatrix}0&-1\\1&0\end{pmatrix}
= -\begin{pmatrix}0&1\\-1&0\end{pmatrix} = -\,\sigma^z\sigma^x
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x &= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
= \begin{pmatrix}-i&0\\0&i\end{pmatrix} \\
\sigma^x\sigma^y &= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
= \begin{pmatrix}i&0\\0&-i\end{pmatrix}
= -\begin{pmatrix}-i&0\\0&i\end{pmatrix} = -\,\sigma^y\sigma^x
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^z &= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
= \begin{pmatrix}0&i\\i&0\end{pmatrix} \\
\sigma^z\sigma^y &= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
= -\begin{pmatrix}0&i\\i&0\end{pmatrix} = -\,\sigma^y\sigma^z
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
    sourcePath: "structured-latex/content/006_Z_Y_anticommutation.mjs",
    sourceOrdinal: 2,
    title: { text: "1 サイトだけ反可換ならテンソル積は反交換する" },
    labels: ["tensor_anticommutation_from_single_site"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`x_1,\dots,x_M,\ y_1,\dots,y_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " に対して",
      ]),
      displayMath(
        String.raw`X := x_1\otimes\cdots\otimes x_M,\qquad
Y := y_1\otimes\cdots\otimes y_M \ \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`,
      ),
      paragraph([
        "とおく。ある ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " が存在して",
      ]),
      list([
        [math(String.raw`y_j x_j = -\,(x_j y_j)`), "（第 ", math(String.raw`j`), " サイトでは反可換）"],
        [
          math(String.raw`i \in \{1,\dots,M\},\ i \neq j \implies y_i x_i = x_i y_i`),
          "（他のサイトでは可換）",
        ],
      ]),
      paragraph(["が成り立つならば、"]),
      displayMath(String.raw`[X, Y]_+ := XY + YX = 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の積は各テンソル因子ごとの積で定まる。すなわち ",
        math(String.raw`A_1,\dots,A_M,B_1,\dots,B_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " に対し",
      ]),
      displayMath(
        String.raw`(A_1\otimes\cdots\otimes A_M)(B_1\otimes\cdots\otimes B_M)
= (A_1B_1)\otimes\cdots\otimes(A_MB_M)
\quad (\because \text{テンソル積代数の積の定義})`,
      ),
      paragraph([
        "また ",
        math(String.raw`\otimes`),
        " は各因子について ",
        math(String.raw`\mathbb{C}`),
        "-線型（多重線型）であるから、",
        math(String.raw`c \in \mathbb{C}`),
        " と ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " に対し",
      ]),
      displayMath(
        String.raw`C_1\otimes\cdots\otimes\overbrace{(c\,C_j)}^{j\text{th}}\otimes\cdots\otimes C_M
= c\,\left(C_1\otimes\cdots\otimes C_M\right)
\quad (\because \text{テンソル積の第 } j \text{ 因子についての } \mathbb{C}\text{-線型性})`,
      ),
      paragraph(["が成り立つ。これらを使って計算する。まず"]),
      displayMath(
        String.raw`\begin{aligned}
XY &= (x_1\otimes\cdots\otimes x_M)(y_1\otimes\cdots\otimes y_M) \\
&= (x_1y_1)\otimes\cdots\otimes(x_My_M)
\quad (\because \text{テンソル積代数の積の定義})
\end{aligned}`,
      ),
      paragraph(["同様に（積の順序だけを入れ替えて）"]),
      displayMath(
        String.raw`\begin{aligned}
YX &= (y_1\otimes\cdots\otimes y_M)(x_1\otimes\cdots\otimes x_M) \\
&= (y_1x_1)\otimes\cdots\otimes(y_Mx_M)
\quad (\because \text{テンソル積代数の積の定義}) \\
&= (x_1y_1)\otimes\cdots\otimes\overbrace{(y_jx_j)}^{j\text{th}}\otimes\cdots\otimes(x_My_M)
\quad (\because\ i\neq j \text{ では } y_ix_i = x_iy_i) \\
&= (x_1y_1)\otimes\cdots\otimes\overbrace{\left((-1)\,(x_jy_j)\right)}^{j\text{th}}\otimes\cdots\otimes(x_My_M)
\quad (\because\ y_jx_j = -(x_jy_j)) \\
&= (-1)\left((x_1y_1)\otimes\cdots\otimes(x_My_M)\right)
\quad (\because \text{第 } j \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= -\,XY
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`XY + YX = XY + (-XY) = 0`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文が [Z_μ,Z_ν]_+ の μ<ν の場合に行っている" +
          "「食い違うのは 1 サイトだけで、そこの符号が全体の符号になる」という計算を、" +
          "3 式すべてで共通に使えるよう主張として切り出した（lean/Ising2D/Part006 の " +
          "siteProd_anticomm_of_single_site に対応する）。",
      ],
    },
  },
  {
    id: "Z_Y_anticommutation_001_claim_anticommutation_relations_Z_and_Y",
    kind: "claim",
    sourcePath: "_old/typst/parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ",
    sourceOrdinal: 1,
    title: { tex: String.raw`Z\text{と}Y\text{の反交換関係}` },
    labels: ["anticommutator_of_Z_and_Y"],
    statement: [
      displayMath(
        String.raw`[Z_\mu, Z_\nu]_+ = 2I_{(\mathbb{C}^2)^{\otimes M}} \delta^M_{(\mu,\nu)}, \quad
[Z_\mu, Y_\nu]_+ = 0, \quad
[Y_\mu, Y_\nu]_+ = 2I_{(\mathbb{C}^2)^{\otimes M}} \delta^M_{(\mu,\nu)}`,
      ),
    ],
    proof: [
      paragraph([
        "記号を固定する。",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " とし、",
        math(String.raw`I_{(\mathbb{C}^2)^{\otimes M}} := I\otimes\cdots\otimes I`),
        "（",
        math(String.raw`M`),
        " 個）を ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の単位元とする。",
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
        "テンソル因子による表示。",
        math(String.raw`m \in \{1,\dots,M\}`),
        " と ",
        math(String.raw`A \in \mathrm{Mat}(2,\mathbb{C})`),
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
        "」であることと、テンソル積代数の積が因子ごとの積であることから、",
      ]),
      displayMath(
        String.raw`\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^a
= \overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(m-1)\text{th}}
\otimes\overbrace{\sigma^a}^{m\text{th}}
\otimes\overbrace{I}^{(m+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}
\quad (a \in \{x,y,z\})`,
      ),
      paragraph([
        "が成り立つ。特に ",
        ref("def_transfer_matrix_symbols"),
        " の定義により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu &= \overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}} \\
Y_\mu &= \overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\mu = 1`),
        " のときは第 1 因子の左に因子が無く、",
        math(String.raw`Z_1 = \sigma^z\otimes I\otimes\cdots\otimes I = \sigma_1^z`),
        "、",
        math(String.raw`Y_1 = \sigma^y\otimes I\otimes\cdots\otimes I = \sigma_1^y`),
        " で、定義の ",
        math(String.raw`Z_1 := \sigma_1^z, Y_1 := \sigma_1^y`),
        " と一致する。",
        math(String.raw`\mu = M`),
        " のときは第 ",
        math(String.raw`M`),
        " 因子の右に因子が無い。）",
      ]),

      paragraph([
        "以下、",
        math(String.raw`\mu,\nu \in \{1,\dots,M\}`),
        " を固定して 3 つの式を順に示す。",
      ]),

      paragraph([
        "【第 1 式】",
        math(String.raw`[Z_\mu, Z_\nu]_+ = 2I_{(\mathbb{C}^2)^{\otimes M}}\delta^M_{(\mu,\nu)}`),
        "。",
      ]),
      paragraph([math(String.raw`\mu = \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Z_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^z\sigma^z)}^{\mu\text{th}}
\otimes\overbrace{(II)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}}
\quad (\because \text{テンソル積代数の積の定義}) \\
&= I\otimes\cdots\otimes I
\quad (\because\ \sigma^x\sigma^x = \sigma^z\sigma^z = II = I,\ \text{すなわち } \text{pauli\_matrix\_products}) \\
&= I_{(\mathbb{C}^2)^{\otimes M}}
\end{aligned}`,
      ),
      paragraph(["であるから"]),
      displayMath(
        String.raw`\begin{aligned}
[Z_\mu, Z_\mu]_+
&= Z_\mu Z_\mu + Z_\mu Z_\mu \\
&= I_{(\mathbb{C}^2)^{\otimes M}} + I_{(\mathbb{C}^2)^{\otimes M}} \\
&= 2 I_{(\mathbb{C}^2)^{\otimes M}}
= 2 I_{(\mathbb{C}^2)^{\otimes M}}\,\delta^M_{(\mu,\mu)}
\quad (\because\ \delta^M_{(\mu,\mu)} = 1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu < \nu`),
        " のとき、",
        math(String.raw`Z_\mu, Z_\nu`),
        " をテンソル積で表して各サイトごとに積をとると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_\mu Z_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\nu\text{th}}
\otimes\overbrace{I}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\otimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\otimes\overbrace{(I\sigma^z)}^{\nu\text{th}}
\otimes\overbrace{(II)}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\nu\text{th}}
\otimes I\otimes\cdots\otimes I
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Z_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\nu\text{th}}
\otimes\overbrace{I}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\otimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\otimes\overbrace{(\sigma^z I)}^{\nu\text{th}}
\otimes\overbrace{(II)}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\nu\text{th}}
\otimes I\otimes\cdots\otimes I
\end{aligned}`,
      ),
      paragraph([
        "2 つの結果は第 ",
        math(String.raw`\mu`),
        " 因子のみが異なり、そこでは ",
        math(String.raw`\sigma^x\sigma^z = -\,\sigma^z\sigma^x`),
        "（",
        ref("pauli_matrix_products"),
        "）である。テンソル積の第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("tensor_anticommutation_from_single_site"),
        " の証明中の式）よりスカラー ",
        math(String.raw`-1`),
        " が外へ出て、",
      ]),
      displayMath(
        String.raw`Z_\nu Z_\mu = -\,Z_\mu Z_\nu,
\qquad\text{したがって}\qquad
[Z_\mu, Z_\nu]_+ = Z_\mu Z_\nu + Z_\nu Z_\mu = 0`,
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
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^x\sigma^z)}^{\nu\text{th}}
\otimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes I\otimes\cdots\otimes I \\
Z_\nu Z_\mu
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^z\sigma^x)}^{\nu\text{th}}
\otimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes I\otimes\cdots\otimes I
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
        " であるから、同じく ",
        math(String.raw`Z_\nu Z_\mu = -\,Z_\mu Z_\nu`),
        " すなわち ",
        math(String.raw`[Z_\mu,Z_\nu]_+ = 0`),
        "。",
      ]),
      paragraph([
        "よって ",
        math(String.raw`\mu \neq \nu`),
        " では ",
        math(String.raw`[Z_\mu,Z_\nu]_+ = 0 = 2I_{(\mathbb{C}^2)^{\otimes M}}\delta^M_{(\mu,\nu)}`),
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
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\otimes\overbrace{(II)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^z\sigma^y)}^{\mu\text{th}}
\otimes I\otimes\cdots\otimes I
\quad (\because\ \sigma^x\sigma^x = II = I)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Z_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\otimes\overbrace{(II)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^y\sigma^z)}^{\mu\text{th}}
\otimes I\otimes\cdots\otimes I
\quad (\because\ \sigma^x\sigma^x = II = I)
\end{aligned}`,
      ),
      paragraph([
        "食い違うのは第 ",
        math(String.raw`\mu`),
        " 因子だけであり、",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^y\sigma^z = -\,\sigma^z\sigma^y`),
        "。第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性でスカラー ",
        math(String.raw`-1`),
        " を外へ出すと",
      ]),
      displayMath(
        String.raw`Y_\mu Z_\mu = -\,Z_\mu Y_\mu,
\qquad\text{したがって}\qquad
[Z_\mu, Y_\mu]_+ = Z_\mu Y_\mu + Y_\mu Z_\mu = 0`,
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
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes\overbrace{I}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\otimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\otimes\overbrace{(I\sigma^y)}^{\nu\text{th}}
\otimes\overbrace{(II)}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^z\sigma^x)}^{\mu\text{th}}
\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes I\otimes\cdots\otimes I
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes\overbrace{I}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\otimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\otimes\overbrace{(\sigma^y I)}^{\nu\text{th}}
\otimes\overbrace{(II)}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^x\sigma^z)}^{\mu\text{th}}
\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes I\otimes\cdots\otimes I
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
        "）である。第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性でスカラー ",
        math(String.raw`-1`),
        " を外へ出して",
      ]),
      displayMath(
        String.raw`Y_\nu Z_\mu = -\,Z_\mu Y_\nu,
\qquad\text{したがって}\qquad
[Z_\mu, Y_\nu]_+ = Z_\mu Y_\nu + Y_\nu Z_\mu = 0`,
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
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^x}^{\nu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes\overbrace{I}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\nu-1)\text{th}}
\otimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\otimes\overbrace{(\sigma^x I)}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{(\sigma^x I)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^z I)}^{\mu\text{th}}
\otimes\overbrace{(II)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\otimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes I\otimes\cdots\otimes I
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Z_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes\overbrace{I}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^x}^{\nu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\nu-1)\text{th}}
\otimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\otimes\overbrace{(I\sigma^x)}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{(I\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(I\sigma^z)}^{\mu\text{th}}
\otimes\overbrace{(II)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\otimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^z}^{\mu\text{th}}
\otimes I\otimes\cdots\otimes I
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
        "）である。よって同様にスカラー ",
        math(String.raw`-1`),
        " が外へ出て",
      ]),
      displayMath(
        String.raw`Y_\nu Z_\mu = -\,Z_\mu Y_\nu,
\qquad\text{したがって}\qquad
[Z_\mu, Y_\nu]_+ = 0`,
      ),
      paragraph([
        "3 通りすべてで ",
        math(String.raw`[Z_\mu, Y_\nu]_+ = 0`),
        " が示されたので、第 2 式が成り立つ。",
      ]),

      paragraph([
        "【第 3 式】",
        math(String.raw`[Y_\mu, Y_\nu]_+ = 2I_{(\mathbb{C}^2)^{\otimes M}}\delta^M_{(\mu,\nu)}`),
        "。",
      ]),
      paragraph([math(String.raw`\mu = \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Y_\mu
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^y\sigma^y)}^{\mu\text{th}}
\otimes\overbrace{(II)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}}
\quad (\because \text{テンソル積代数の積の定義}) \\
&= I\otimes\cdots\otimes I
\quad (\because\ \sigma^x\sigma^x = \sigma^y\sigma^y = II = I,\ \text{すなわち } \text{pauli\_matrix\_products}) \\
&= I_{(\mathbb{C}^2)^{\otimes M}}
\end{aligned}`,
      ),
      paragraph(["であるから"]),
      displayMath(
        String.raw`\begin{aligned}
[Y_\mu, Y_\mu]_+
&= Y_\mu Y_\mu + Y_\mu Y_\mu \\
&= I_{(\mathbb{C}^2)^{\otimes M}} + I_{(\mathbb{C}^2)^{\otimes M}} \\
&= 2 I_{(\mathbb{C}^2)^{\otimes M}}
= 2 I_{(\mathbb{C}^2)^{\otimes M}}\,\delta^M_{(\mu,\mu)}
\quad (\because\ \delta^M_{(\mu,\mu)} = 1)
\end{aligned}`,
      ),
      paragraph([math(String.raw`\mu < \nu`), " のとき、因子ごとの積をとると"]),
      displayMath(
        String.raw`\begin{aligned}
Y_\mu Y_\nu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes\overbrace{I}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^y\sigma^x)}^{\mu\text{th}}
\otimes\overbrace{(I\sigma^x)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(I\sigma^x)}^{(\nu-1)\text{th}}
\otimes\overbrace{(I\sigma^y)}^{\nu\text{th}}
\otimes\overbrace{(II)}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^y\sigma^x)}^{\mu\text{th}}
\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes I\otimes\cdots\otimes I
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
Y_\nu Y_\mu
&= \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^x}^{\mu\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes\overbrace{I}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&\qquad \cdot \left(\overbrace{\sigma^x}^{1\text{st}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\mu\text{th}}
\otimes\overbrace{I}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{I}^{M\text{th}}\right) \\
&= \overbrace{(\sigma^x\sigma^x)}^{1\text{st}}\otimes\cdots\otimes\overbrace{(\sigma^x\sigma^x)}^{(\mu-1)\text{th}}
\otimes\overbrace{(\sigma^x\sigma^y)}^{\mu\text{th}}
\otimes\overbrace{(\sigma^x I)}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{(\sigma^x I)}^{(\nu-1)\text{th}}
\otimes\overbrace{(\sigma^y I)}^{\nu\text{th}}
\otimes\overbrace{(II)}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{(II)}^{M\text{th}} \\
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^x\sigma^y)}^{\mu\text{th}}
\otimes\overbrace{\sigma^x}^{(\mu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\nu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\nu\text{th}}
\otimes I\otimes\cdots\otimes I
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
        "）である。第 ",
        math(String.raw`\mu`),
        " 因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性でスカラー ",
        math(String.raw`-1`),
        " を外へ出して",
      ]),
      displayMath(
        String.raw`Y_\nu Y_\mu = -\,Y_\mu Y_\nu,
\qquad\text{したがって}\qquad
[Y_\mu, Y_\nu]_+ = Y_\mu Y_\nu + Y_\nu Y_\mu = 0`,
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
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^x\sigma^y)}^{\nu\text{th}}
\otimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\mu\text{th}}
\otimes I\otimes\cdots\otimes I \\
Y_\nu Y_\mu
&= I\otimes\cdots\otimes I
\otimes\overbrace{(\sigma^y\sigma^x)}^{\nu\text{th}}
\otimes\overbrace{\sigma^x}^{(\nu+1)\text{th}}\otimes\cdots\otimes\overbrace{\sigma^x}^{(\mu-1)\text{th}}
\otimes\overbrace{\sigma^y}^{\mu\text{th}}
\otimes I\otimes\cdots\otimes I
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
        " であるから、同じく ",
        math(String.raw`Y_\nu Y_\mu = -\,Y_\mu Y_\nu`),
        " すなわち ",
        math(String.raw`[Y_\mu,Y_\nu]_+ = 0`),
        "。",
      ]),
      paragraph([
        "よって ",
        math(String.raw`\mu \neq \nu`),
        " では ",
        math(String.raw`[Y_\mu,Y_\nu]_+ = 0 = 2I_{(\mathbb{C}^2)^{\otimes M}}\delta^M_{(\mu,\nu)}`),
        " であり、第 3 式が示された。以上で 3 式すべてが証明された。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
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
      ],
    },
  },
]);
