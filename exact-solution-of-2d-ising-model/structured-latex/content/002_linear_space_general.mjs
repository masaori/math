import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_linear_space_general",
    kind: "heading",
    level: 2,
    sourcePath: "_old/typst/main.typ",
    sourceOrdinal: 3,
    title: { text: "線型空間の一般論" },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "linear_space_general_001_theorem_tensor_product_basis",
    kind: "theorem",
    sourcePath: "_old/typst/parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ",
    sourceOrdinal: 1,
    title: { text: "テンソル冪の基底は基底のテンソル積の族" },
    labels: ["tensor_basis"],
    statement: [
      paragraph([
        math(String.raw`m, n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`V`),
        " を ",
        math(String.raw`n`),
        " 次元 ",
        math(String.raw`K`),
        "-線型空間、",
        math(String.raw`E = \{e_1,\dots,e_n\}`),
        " を ",
        math(String.raw`V`),
        " の基底とするとき、多重添字 ",
        math(String.raw`(i_1,\dots,i_m) \in \{1,\dots,n\}^m`),
        " で添字づけられた族",
      ]),
      displayMath(
        String.raw`\left\{\, e_{i_1} \otimes \cdots \otimes e_{i_m} \;\middle|\; (i_1,\dots,i_m) \in \{1,\dots,n\}^m \,\right\}`,
      ),
      paragraph([
        "は、",
        math(String.raw`m`),
        " 階テンソル冪 ",
        math(String.raw`V^{\otimes m}`),
        " の基底である。特に ",
        math(String.raw`\dim_K V^{\otimes m} = n^m`),
        " である。",
      ]),
    ],
    notes: [
      paragraph([
        "基底であるのは族全体であって、個々のテンソル積 ",
        math(String.raw`e_{i_1} \otimes \cdots \otimes e_{i_m}`),
        " ではない（単一の元は 1 次元しか張らないので、",
        math(String.raw`n^m \geq 2`),
        " のとき基底になり得ない）。また ",
        math(String.raw`V`),
        " の次元 ",
        math(String.raw`n`),
        " とテンソル冪の階数 ",
        math(String.raw`m`),
        " は独立な量である。本論文での主な用途は ",
        math(String.raw`V = \mathrm{Mat}(2,\mathbb{C})`),
        "（",
        math(String.raw`n = 4`),
        "）、",
        math(String.raw`m = M`),
        " の場合であり、",
        ref("Z_Y_generate_algebra"),
        " や ",
        ref("centralizer_is_scalar"),
        " で ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の基底を得るために使う。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文(Typst)のステートメントは「単一のテンソル積が基底である」と読め、" +
          "かつ V の次元とテンソル冪の階数に同じ記号 m を二重使用していた。" +
          "Lean 形式化(lean/Ising2D/Part002/Theorem000_TensorBasis.lean)で判明したため、" +
          "原文側を修正し本ブロックも同期済み。",
      ],
    },
  },
  {
    id: "linear_space_general_002_claim_scalar_identity_commutes",
    kind: "claim",
    sourcePath: "_old/typst/parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ",
    sourceOrdinal: 2,
    title: { tex: String.raw`c \cdot I \text{ は全行列と可換}` },
    labels: ["scalar_identity_commutes"],
    statement: [
      paragraph([
        "体 ",
        math(String.raw`K`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in K`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n, K)`),
        " について、",
      ]),
      displayMath(String.raw`[c \cdot I,\, A] = 0`),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
[c \cdot I,\, A]
&= (c \cdot I)A - A(c \cdot I) \\
&= cA - cA \\
&= 0
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "linear_space_general_004_lemma_centralizer_is_scalar",
    kind: "claim",
    sourcePath: "_old/typst/parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ",
    sourceOrdinal: 4,
    title: { tex: String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M} \text{ の中で全元と可換な元はスカラー}` },
    labels: ["centralizer_is_scalar"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`W \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " が、すべての ",
        math(String.raw`x \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " について ",
        math(String.raw`Wx = xW`),
        " を満たすならば、ある ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在して ",
        math(String.raw`W = c\cdot I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の行列単位。",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位を",
      ]),
      displayMath(
        String.raw`E_{11}=\begin{pmatrix}1&0\\0&0\end{pmatrix},\quad
E_{12}=\begin{pmatrix}0&1\\0&0\end{pmatrix},\quad
E_{21}=\begin{pmatrix}0&0\\1&0\end{pmatrix},\quad
E_{22}=\begin{pmatrix}0&0\\0&1\end{pmatrix}`,
      ),
      paragraph([
        "とする。任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}\in\mathrm{Mat}(2,\mathbb{C})`),
        " に対し",
      ]),
      displayMath(
        String.raw`A = a_{11}E_{11} + a_{12}E_{12} + a_{21}E_{21} + a_{22}E_{22} \quad (\because \text{成分比較})`,
      ),
      paragraph([
        " が成り立つので ",
        math(String.raw`\mathcal{E}_0 := \{E_{11},E_{12},E_{21},E_{22}\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " を張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{E}_0`),
        " であるから ",
        math(String.raw`\mathcal{E}_0`),
        " は基底である。成分計算により、",
        math(String.raw`i,j,k,l\in\{1,2\}`),
        " について",
      ]),
      displayMath(
        String.raw`E_{ij}E_{kl} = \delta_{jk}E_{il} \quad (\because \text{行列の積の成分計算})`,
      ),
      paragraph([
        "（",
        math(String.raw`\delta_{jk}`),
        " は Kronecker のデルタ）。特に ",
        math(String.raw`E_{11}+E_{22}=\begin{pmatrix}1&0\\0&1\end{pmatrix}=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "。多重添字 ",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\{1,2\}^M`),
        " について ",
        math(String.raw`E_{IJ}:=E_{i_1 j_1}\otimes E_{i_2 j_2}\otimes\cdots\otimes E_{i_M j_M}\in\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " とおく。",
        math(String.raw`\mathcal{E}_0`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の基底であるから、",
        math(String.raw`\mathcal{E}:=\{E_{IJ}:I,J\in\{1,2\}^M\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の基底である（",
        ref("tensor_basis"),
        "）。その元数は ",
        math(String.raw`\#\mathcal{E}=(2^M)^2=4^M`),
        "。",
      ]),
      paragraph([
        "Step 2: 行列単位 ",
        math(String.raw`E_{IJ}`),
        " の積公式。",
        math(String.raw`I,J,K,L\in\{1,2\}^M`),
        " について、テンソル積上の積の定義と Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{IJ} E_{KL}
&= (E_{i_1 j_1}\otimes\cdots\otimes E_{i_M j_M})(E_{k_1 l_1}\otimes\cdots\otimes E_{k_M l_M}) \\
&= (E_{i_1 j_1}E_{k_1 l_1})\otimes\cdots\otimes(E_{i_M j_M}E_{k_M l_M}) \quad (\because \text{テンソル積上の積の定義}) \\
&= (\delta_{j_1 k_1}E_{i_1 l_1})\otimes\cdots\otimes(\delta_{j_M k_M}E_{i_M l_M}) \quad (\because E_{ij}E_{kl}=\delta_{jk}E_{il}) \\
&= \left(\prod_{r=1}^M \delta_{j_r k_r}\right)E_{IL} \quad (\because \text{スカラーのテンソル多重線型性})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta_{JK}:=\prod_{r=1}^M \delta_{j_r k_r}`),
        " とおくと、これは ",
        math(String.raw`J=K`),
        " のとき ",
        math(String.raw`1`),
        "、そうでなければ ",
        math(String.raw`0`),
        " であるから ",
        math(String.raw`E_{IJ}E_{KL}=\delta_{JK}E_{IL}`),
        "。また各因子に ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}=E_{11}+E_{22}`),
        " を代入して多重線型性で展開すると",
      ]),
      displayMath(
        String.raw`I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}} = \sum_{P\in\{1,2\}^M} E_{PP} \quad (\because I_{\mathrm{Mat}(2,\mathbb{C})}=E_{11}+E_{22} \text{ とテンソル積の多重線型性})`,
      ),
      paragraph([
        "Step 3: ",
        math(String.raw`W`),
        " を行列単位で展開し、可換性から係数を決定する。",
        math(String.raw`\mathcal{E}`),
        " は基底であるから ",
        math(String.raw`W`),
        " は一意に ",
        math(String.raw`W=\sum_{I,J\in\{1,2\}^M} w_{IJ}E_{IJ}`),
        "（",
        math(String.raw`w_{IJ}\in\mathbb{C}`),
        "）と展開できる。仮定より各 ",
        math(String.raw`E_{KL}`),
        " について ",
        math(String.raw`W E_{KL}=E_{KL} W`),
        "。左辺は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W E_{KL}
&= \left(\sum_{I,J} w_{IJ}E_{IJ}\right)E_{KL} \\
&= \sum_{I,J} w_{IJ}(E_{IJ}E_{KL}) \quad (\because \text{積の双線型性}) \\
&= \sum_{I,J} w_{IJ}\delta_{JK}E_{IL} \quad (\because \text{Step 2 の積公式}) \\
&= \sum_{I\in\{1,2\}^M} w_{IK}E_{IL} \quad (\because \delta_{JK} \text{ は } J=K \text{ でのみ非零})
\end{aligned}`,
      ),
      paragraph(["右辺は"]),
      displayMath(
        String.raw`\begin{aligned}
E_{KL} W
&= E_{KL}\left(\sum_{I,J} w_{IJ}E_{IJ}\right) \\
&= \sum_{I,J} w_{IJ}(E_{KL}E_{IJ}) \quad (\because \text{積の双線型性}) \\
&= \sum_{I,J} w_{IJ}\delta_{LI}E_{KJ} \quad (\because \text{Step 2 の積公式}) \\
&= \sum_{J\in\{1,2\}^M} w_{LJ}E_{KJ} \quad (\because \delta_{LI} \text{ は } I=L \text{ でのみ非零})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mathcal{E}`),
        " は基底であるから両辺の係数は一致する。任意に ",
        math(String.raw`P,Q\in\{1,2\}^M`),
        " を固定し ",
        math(String.raw`E_{PQ}`),
        " の係数を比較する。",
      ]),
      paragraph([
        "場合 1: ",
        math(String.raw`Q=L`),
        " かつ ",
        math(String.raw`P=K`),
        " のとき。左辺で ",
        math(String.raw`E_{PL}`),
        " の係数は ",
        math(String.raw`w_{PK}=w_{KK}`),
        "、右辺で ",
        math(String.raw`E_{KQ}`),
        " の係数は ",
        math(String.raw`w_{LQ}=w_{LL}`),
        " であるから ",
        math(String.raw`w_{KK}=w_{LL}`),
        "。これは任意の ",
        math(String.raw`K,L`),
        " で成立するから対角係数は ",
        math(String.raw`K`),
        " によらない定数 ",
        math(String.raw`c:=w_{KK}`),
        " である。",
      ]),
      paragraph([
        "場合 2: ",
        math(String.raw`K\neq L`),
        " とし ",
        math(String.raw`P=K,\ Q=K`),
        " のとき（",
        math(String.raw`E_{KK}`),
        " の係数比較）。第 2 添字が ",
        math(String.raw`K\neq L`),
        " なので左辺に ",
        math(String.raw`E_{KK}`),
        " は現れず係数は ",
        math(String.raw`0`),
        "、右辺で ",
        math(String.raw`E_{KK}`),
        " の係数は ",
        math(String.raw`w_{LK}`),
        " であるから ",
        math(String.raw`w_{LK}=0`),
        "。すなわち ",
        math(String.raw`I\neq J`),
        " なる非対角係数 ",
        math(String.raw`w_{IJ}`),
        " はすべて ",
        math(String.raw`0`),
        "。",
      ]),
      paragraph(["Step 4: 結論。"]),
      displayMath(
        String.raw`\begin{aligned}
W
&= \sum_{I,J\in\{1,2\}^M} w_{IJ}E_{IJ} \\
&= \sum_{P\in\{1,2\}^M} w_{PP}E_{PP} \quad (\because \text{Step 3: 非対角係数は } 0) \\
&= \sum_{P\in\{1,2\}^M} c\,E_{PP} \quad (\because \text{Step 3: 対角係数は共通の } c) \\
&= c\sum_{P\in\{1,2\}^M} E_{PP} \quad (\because \text{和のスカラー倍}) \\
&= c\cdot I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}} \quad (\because I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}=\sum_{P\in\{1,2\}^M} E_{PP})
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    kind: "claim",
    sourcePath: "_old/typst/parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ",
    sourceOrdinal: 3,
    title: { text: "行列ノルムの劣乗法性" },
    labels: ["matrix_norm_submultiplicativity"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n, K)`),
        " について、",
      ]),
      displayMath(String.raw`\|AB\| \leq \|A\| \cdot \|B\|`),
    ],
    proof: [todo("TODO")],
    conversion: { status: "converted" },
  },
  {
    id: "linear_space_general_003b_claim_matrix_multiplication_continuity",
    kind: "claim",
    sourcePath: "_old/typst/parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ",
    sourceOrdinal: 3,
    title: { text: "行列乗算の連続性" },
    labels: ["matrix_multiplication_continuity"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A_N, A, B \in \mathrm{Mat}(n, K)`),
        "、",
        math(String.raw`\|A_N - A\| \to 0`),
        " のとき、",
      ]),
      displayMath(String.raw`\|A_N B - AB\| \to 0`),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\|A_N B - AB\|
&= \|(A_N - A)B\| \\
&\leq \|A_N - A\| \cdot \|B\| \\
&\to 0
\end{aligned}`,
      ),
      paragraph(["（", ref("matrix_norm_submultiplicativity"), " を使用）"]),
    ],
    conversion: { status: "converted" },
  },
]);
