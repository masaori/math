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
    id: "linear_space_general_002b_definition_matrix_norm",
    kind: "definition",
    sourcePath: "structured-latex/content/002_linear_space_general.mjs",
    sourceOrdinal: 3,
    title: { text: "数ベクトル・行列のノルムと収束" },
    labels: ["def_matrix_norm"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`d, n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
      ]),
      paragraph([
        math(String.raw`|\cdot| : K \to \mathbb{R}_{\geq 0}`),
        " を、",
        math(String.raw`K=\mathbb{R}`),
        " のときは実数の絶対値、",
        math(String.raw`K=\mathbb{C}`),
        " のときは ",
        ref("def_abs_arg"),
        " の絶対値とする（",
        ref("abs_basic_properties"),
        " (6) より、",
        math(String.raw`\mathbb{R}`),
        " を ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " で ",
        math(String.raw`\mathbb{C}`),
        " に埋め込んだとき両者は一致する）。",
      ]),
      paragraph([
        math(String.raw`w = (w_1,\dots,w_d) \in K^d`),
        " のノルムを",
      ]),
      displayMath(
        String.raw`\|w\| := \sqrt{\sum_{i=1}^{d} |w_i|^2}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`,
      ),
      paragraph([
        "と定める。また ",
        math(String.raw`A = (a_{ij})_{1\le i,j\le n} \in \mathrm{Mat}(n,K)`),
        " のノルムを",
      ]),
      displayMath(
        String.raw`\|A\| := \sqrt{\sum_{i=1}^{n}\sum_{j=1}^{n} |a_{ij}|^2}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`,
      ),
      paragraph([
        "と定める（いずれも根号の中は非負実数の有限和なので ",
        ref("definition_of_sqrt_r_positive"),
        " により定まる）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(n,K)`),
        " の列 ",
        math(String.raw`(A_N)_{N \in \mathbb{Z}_{\ge 0}}`),
        " と ",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        " について、",
      ]),
      displayMath(
        String.raw`A_N \to A \overset{\mathrm{def}}{\Longleftrightarrow}
\|A_N - A\| \to 0 \ (N\to\infty)`,
      ),
      paragraph([
        "と定める（右辺は実数列 ",
        math(String.raw`(\|A_N-A\|)_N`),
        " の ",
        math(String.raw`0`),
        " への収束）。このとき ",
        math(String.raw`A`),
        " を ",
        math(String.raw`(A_N)`),
        " の極限といい ",
        math(String.raw`A = \lim_{N\to\infty} A_N`),
        " と書く。さらに ",
        math(String.raw`B_0, B_1, \dots \in \mathrm{Mat}(n,K)`),
        " について、部分和 ",
        math(String.raw`S_N := \sum_{m=0}^{N} B_m`),
        " が ",
        math(String.raw`S`),
        " に収束するとき",
      ]),
      displayMath(String.raw`\sum_{m=0}^{\infty} B_m := S`),
      paragraph(["と書く。"]),
      paragraph([
        math(String.raw`K^d`),
        " の列の収束も同様に ",
        math(String.raw`\|w_N - w\| \to 0`),
        " で定める。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文は行列ノルムの劣乗法性" +
          "（labels: matrix_norm_submultiplicativity）や exp 級数の収束（labels: exp_converges）で" +
          "ノルム記号を使うが、ノルムそのものの定義がどこにも無かったため、" +
          "初出の直前に置いた。採用したのは Frobenius ノルム（成分の平方和の平方根）で、" +
          "これは 005 章の M(n;C) の内積・ノルムの定義（原文では TODO）が意図する" +
          "Hilbert--Schmidt 内積 ⟨A,B⟩ = tr(A^* B) から定まるノルムと同一である。",
      ],
    },
  },
  {
    id: "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    kind: "claim",
    sourcePath: "structured-latex/content/002_linear_space_general.mjs",
    sourceOrdinal: 3,
    title: { text: "ノルムの基本性質（非退化性・斉次性・三角不等式）" },
    labels: ["matrix_norm_triangle_inequality"],
    statement: [
      paragraph([
        ref("def_matrix_norm"),
        " のノルムについて、",
        math(String.raw`A, B \in \mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`c \in K`),
        " に対して次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\|A\| \ge 0`),
          " であり、",
          math(String.raw`\|A\| = 0 \iff A = O`),
          "（",
          math(String.raw`O`),
          " は零行列）。",
        ],
        ["(2) ", math(String.raw`\|cA\| = |c|\,\|A\|`), "。"],
        ["(3) ", math(String.raw`\|A+B\| \le \|A\| + \|B\|`), "。"],
        [
          "(4) ",
          ref("def_matrix_norm"),
          " の意味での極限は、存在すれば一意である。すなわち ",
          math(String.raw`A_N \to A`),
          " かつ ",
          math(String.raw`A_N \to A'`),
          " ならば ",
          math(String.raw`A = A'`),
          "。",
        ],
      ]),
      paragraph([
        math(String.raw`K^d`),
        " のノルムについても同じ 4 つが成り立つ（証明は成分の添字を 1 重にするだけで同一）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`A=(a_{ij})`),
        "、",
        math(String.raw`B=(b_{ij})`),
        " とおき、和は ",
        math(String.raw`1\le i,j\le n`),
        " の全体にわたるものとする。",
      ]),
      paragraph([
        "Step 0: 補題（非負実数の平方の単調性）。",
        math(String.raw`u,v\in\mathbb{R}_{\ge 0}`),
        " について",
      ]),
      displayMath(String.raw`u\le v \iff u^2\le v^2`),
      paragraph([
        "が成り立つ。実際、",
        math(String.raw`u\le v`),
        " ならば ",
        math(String.raw`u^2=u\cdot u\le v\cdot u\le v\cdot v=v^2`),
        "（",
        math(String.raw`u\ge 0,\ v\ge 0`),
        " による）。逆に ",
        math(String.raw`u>v\ (\ge 0)`),
        " ならば ",
        math(String.raw`u>0`),
        " より ",
        math(String.raw`u^2=u\cdot u>v\cdot u\ge v\cdot v=v^2`),
        " であるから、対偶により ",
        math(String.raw`u^2\le v^2\Rightarrow u\le v`),
        "。特に ",
        math(String.raw`u^2=v^2\Rightarrow u=v`),
        "。",
      ]),
      paragraph([
        "Step 1: 絶対値の性質。",
        math(String.raw`z,w\in K`),
        " について",
      ]),
      displayMath(
        String.raw`|z|\ge 0, \qquad |zw|=|z|\,|w|, \qquad |z+w|\le|z|+|w|,
\qquad \left(|z|=0\iff z=0\right)`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`K=\mathbb{C}`),
        " のときは ",
        ref("abs_basic_properties"),
        " (3)(4)(5) と ",
        ref("def_abs_arg"),
        "（値域が ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        "）による。",
        math(String.raw`K=\mathbb{R}`),
        " のときは、",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " が和と積を保つこと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\iota_{\mathbb{R}\to\mathbb{C}}(x)+\iota_{\mathbb{R}\to\mathbb{C}}(y)
&= (x,0)+(y,0) = (x+y,0) = \iota_{\mathbb{R}\to\mathbb{C}}(x+y) \\
\iota_{\mathbb{R}\to\mathbb{C}}(x)\cdot\iota_{\mathbb{R}\to\mathbb{C}}(y)
&= (x,0)\cdot(y,0) = (xy-0\cdot 0,\ x\cdot 0+0\cdot y) = (xy,0)
= \iota_{\mathbb{R}\to\mathbb{C}}(xy)
\end{aligned}`,
      ),
      paragraph([
        "と ",
        ref("abs_basic_properties"),
        " (6) を組み合わせて同じ 4 つの性質が従う。たとえば ",
        math(String.raw`x,y\in\mathbb{R}`),
        " について ",
        math(String.raw`|x+y|=\left|\iota_{\mathbb{R}\to\mathbb{C}}(x+y)\right|
=\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)+\iota_{\mathbb{R}\to\mathbb{C}}(y)\right|
\le\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)\right|+\left|\iota_{\mathbb{R}\to\mathbb{C}}(y)\right|=|x|+|y|`),
        " であり、乗法性・非負性・非退化性も同様である。",
      ]),
      paragraph([
        "Step 2: (1)。",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\|A\|\ge 0`),
        "。また Step 0 より ",
        math(String.raw`\|A\|=0`),
        " と ",
        math(String.raw`\|A\|^2=0`),
        " は同値であり、",
      ]),
      displayMath(
        String.raw`\|A\|^2=\sum_{i,j}|a_{ij}|^2`,
      ),
      paragraph([
        "は非負実数の有限和であるから、",
        math(String.raw`\|A\|^2=0`),
        " と「すべての ",
        math(String.raw`i,j`),
        " について ",
        math(String.raw`|a_{ij}|^2=0`),
        "」は同値（非負数の有限和が ",
        math(String.raw`0`),
        " ならば各項が ",
        math(String.raw`0`),
        "、逆も明らか）。Step 1 より ",
        math(String.raw`|a_{ij}|=0\iff a_{ij}=0`),
        " であるから ",
        math(String.raw`\|A\|=0\iff A=O`),
        "。",
      ]),
      paragraph(["Step 3: (2)。Step 1 の乗法性より、"]),
      displayMath(
        String.raw`\begin{aligned}
\|cA\|^2
&= \sum_{i,j}|c\,a_{ij}|^2 \\
&= \sum_{i,j}\left(|c|\,|a_{ij}|\right)^2 \quad (\because \text{Step 1}) \\
&= |c|^2\sum_{i,j}|a_{ij}|^2 \\
&= \left(|c|\,\|A\|\right)^2
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\|cA\|\ge 0`),
        " かつ ",
        math(String.raw`|c|\,\|A\|\ge 0`),
        " であるから Step 0 より ",
        math(String.raw`\|cA\|=|c|\,\|A\|`),
        "。",
      ]),
      paragraph([
        "Step 4: 有限列に対する Cauchy--Schwarz の不等式。",
        math(String.raw`m\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`u_1,\dots,u_m,v_1,\dots,v_m\in\mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\left(\sum_{k=1}^{m}u_kv_k\right)^2
\le \left(\sum_{k=1}^{m}u_k^2\right)\left(\sum_{k=1}^{m}v_k^2\right)`,
      ),
      paragraph([
        "が成り立つ。実際 ",
        math(String.raw`P:=\sum_k u_k^2,\ Q:=\sum_k v_k^2,\ R:=\sum_k u_kv_k`),
        " とおく。",
        math(String.raw`Q=0`),
        " のときは非負数の有限和が ",
        math(String.raw`0`),
        " であることから各 ",
        math(String.raw`v_k^2=0`),
        " すなわち ",
        math(String.raw`v_k=0`),
        " となり ",
        math(String.raw`R=0`),
        " であるから ",
        math(String.raw`R^2=0=PQ`),
        "。",
        math(String.raw`Q>0`),
        " のときは、任意の ",
        math(String.raw`t\in\mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`0\le\sum_{k=1}^{m}(u_k-tv_k)^2
= P-2tR+t^2Q
\quad (\because \text{実数の平方は非負、および分配律})`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`t:=R/Q`),
        " とおくと",
      ]),
      displayMath(
        String.raw`0\le P-2\frac{R^2}{Q}+\frac{R^2}{Q}=P-\frac{R^2}{Q}`,
      ),
      paragraph([
        "となり、両辺に ",
        math(String.raw`Q>0`),
        " を掛けて ",
        math(String.raw`R^2\le PQ`),
        "。",
      ]),
      paragraph([
        "Step 5: (3)。Step 1 の三角不等式と Step 0 より、各 ",
        math(String.raw`i,j`),
        " について ",
        math(String.raw`|a_{ij}+b_{ij}|\le|a_{ij}|+|b_{ij}|`),
        " であり、両辺とも非負なので",
      ]),
      displayMath(
        String.raw`|a_{ij}+b_{ij}|^2\le\left(|a_{ij}|+|b_{ij}|\right)^2
= |a_{ij}|^2+2|a_{ij}||b_{ij}|+|b_{ij}|^2
\quad (\because \text{Step 0, 分配律})`,
      ),
      paragraph(["これを ", math(String.raw`i,j`), " について加えると、"]),
      displayMath(
        String.raw`\begin{aligned}
\|A+B\|^2
&= \sum_{i,j}|a_{ij}+b_{ij}|^2 \\
&\le \sum_{i,j}|a_{ij}|^2+2\sum_{i,j}|a_{ij}||b_{ij}|+\sum_{i,j}|b_{ij}|^2 \\
&= \|A\|^2+2\sum_{i,j}|a_{ij}||b_{ij}|+\|B\|^2
\end{aligned}`,
      ),
      paragraph([
        "ここで Step 4 を ",
        math(String.raw`m=n^2`),
        " 個の添字 ",
        math(String.raw`(i,j)`),
        " について ",
        math(String.raw`u_{(i,j)}=|a_{ij}|,\ v_{(i,j)}=|b_{ij}|`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\left(\sum_{i,j}|a_{ij}||b_{ij}|\right)^2
\le\left(\sum_{i,j}|a_{ij}|^2\right)\left(\sum_{i,j}|b_{ij}|^2\right)
= \|A\|^2\|B\|^2=\left(\|A\|\,\|B\|\right)^2`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\sum_{i,j}|a_{ij}||b_{ij}|\ge 0`),
        " かつ ",
        math(String.raw`\|A\|\,\|B\|\ge 0`),
        " であるから Step 0 より ",
        math(String.raw`\sum_{i,j}|a_{ij}||b_{ij}|\le\|A\|\,\|B\|`),
        "。よって",
      ]),
      displayMath(
        String.raw`\|A+B\|^2\le\|A\|^2+2\|A\|\,\|B\|+\|B\|^2=\left(\|A\|+\|B\|\right)^2`,
      ),
      paragraph([
        "となり、両辺の平方根をとる（Step 0、",
        math(String.raw`\|A+B\|\ge 0`),
        "、",
        math(String.raw`\|A\|+\|B\|\ge 0`),
        "）ことで ",
        math(String.raw`\|A+B\|\le\|A\|+\|B\|`),
        " を得る。",
      ]),
      paragraph([
        "Step 6: (4)。",
        math(String.raw`A_N\to A`),
        " かつ ",
        math(String.raw`A_N\to A'`),
        " とする。各 ",
        math(String.raw`N`),
        " について ",
        math(String.raw`A-A'=(A-A_N)+(A_N-A')`),
        " であるから、Step 5 より",
      ]),
      displayMath(
        String.raw`0\le\|A-A'\|\le\|A-A_N\|+\|A_N-A'\|
= \|A_N-A\|+\|A_N-A'\|`,
      ),
      paragraph([
        "最後の等号は ",
        math(String.raw`A-A_N=(-1)(A_N-A)`),
        " と Step 3（",
        math(String.raw`c=-1`),
        "）、および ",
        math(String.raw`|-1|=1`),
        "（",
        math(String.raw`K=\mathbb{C}`),
        " のときは ",
        ref("abs_basic_properties"),
        " (6) より ",
        math(String.raw`|-1_{\mathbb{C}}|=|-1|=1`),
        "）による。",
      ]),
      paragraph([
        "右辺は ",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`0`),
        " に収束する実数列であり、左辺の ",
        math(String.raw`\|A-A'\|`),
        " は ",
        math(String.raw`N`),
        " によらない定数である。非負の定数が ",
        math(String.raw`0`),
        " に収束する列で上から抑えられるならその定数は ",
        math(String.raw`0`),
        " であるから ",
        math(String.raw`\|A-A'\|=0`),
        "、Step 2 より ",
        math(String.raw`A-A'=O`),
        " すなわち ",
        math(String.raw`A=A'`),
        "。",
      ]),
      paragraph([
        "Step 7: ",
        math(String.raw`K^d`),
        " の場合。上の Step 2・Step 3・Step 5・Step 6 で添字の組 ",
        math(String.raw`(i,j)`),
        " を単一の添字 ",
        math(String.raw`i`),
        " に置き換えれば、同じ議論がそのまま通用する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。ノルムの定義（labels: def_matrix_norm）を置いた以上、" +
          "極限の一意性や行列乗算の連続性（labels: matrix_multiplication_continuity）の議論が" +
          "前提としている非退化性・斉次性・三角不等式を明示的に証明しておく必要があるため追加した。",
      ],
    },
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
      paragraph([
        "ここで ",
        math(String.raw`\|\cdot\|`),
        " は ",
        ref("def_matrix_norm"),
        " のノルムである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A=(a_{ij})_{1\le i,j\le n}`),
        "、",
        math(String.raw`B=(b_{ij})_{1\le i,j\le n}`),
        " とおく。行列の積の定義より ",
        math(String.raw`(AB)_{ij}=\sum_{k=1}^{n}a_{ik}b_{kj}`),
        " である。",
      ]),
      paragraph([
        "Step 1: 有限和の三角不等式。",
        math(String.raw`m\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m\in K`),
        " について",
      ]),
      displayMath(
        String.raw`\left|\sum_{k=1}^{m}z_k\right|\le\sum_{k=1}^{m}|z_k|`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のときは両辺とも ",
        math(String.raw`|z_1|`),
        " で等号成立。",
        math(String.raw`m`),
        " で成り立つと仮定すると、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 1（絶対値の三角不等式）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\sum_{k=1}^{m+1}z_k\right|
&= \left|\left(\sum_{k=1}^{m}z_k\right)+z_{m+1}\right| \\
&\le \left|\sum_{k=1}^{m}z_k\right|+|z_{m+1}|
\quad (\because \text{絶対値の三角不等式}) \\
&\le \sum_{k=1}^{m}|z_k|+|z_{m+1}|
\quad (\because \text{帰納法の仮定}) \\
&= \sum_{k=1}^{m+1}|z_k|
\end{aligned}`,
      ),
      paragraph([
        "Step 2: 各成分の評価。",
        math(String.raw`1\le i,j\le n`),
        " を固定する。Step 1 と絶対値の乗法性（",
        ref("matrix_norm_triangle_inequality"),
        " の Step 1）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(AB)_{ij}\right|
&= \left|\sum_{k=1}^{n}a_{ik}b_{kj}\right| \\
&\le \sum_{k=1}^{n}\left|a_{ik}b_{kj}\right|
\quad (\because \text{Step 1}) \\
&= \sum_{k=1}^{n}|a_{ik}|\,|b_{kj}|
\quad (\because \text{絶対値の乗法性})
\end{aligned}`,
      ),
      paragraph([
        "両辺は非負であるから、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0（非負実数の平方の単調性）より",
      ]),
      displayMath(
        String.raw`\left|(AB)_{ij}\right|^2\le\left(\sum_{k=1}^{n}|a_{ik}|\,|b_{kj}|\right)^2`,
      ),
      paragraph([
        "さらに ",
        ref("matrix_norm_triangle_inequality"),
        " の Step 4（Cauchy--Schwarz の不等式）を ",
        math(String.raw`u_k=|a_{ik}|,\ v_k=|b_{kj}|`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\left(\sum_{k=1}^{n}|a_{ik}|\,|b_{kj}|\right)^2
\le\left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{k=1}^{n}|b_{kj}|^2\right)`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\left|(AB)_{ij}\right|^2
\le\left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{l=1}^{n}|b_{lj}|^2\right)`,
      ),
      paragraph([
        "Step 3: 全成分についての和。Step 2 の不等式を ",
        math(String.raw`1\le i,j\le n`),
        " について加えると、右辺の第 1 因子は ",
        math(String.raw`i`),
        " のみ、第 2 因子は ",
        math(String.raw`j`),
        " のみに依存するので二重和が積に分解して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|AB\|^2
&= \sum_{i=1}^{n}\sum_{j=1}^{n}\left|(AB)_{ij}\right|^2
\quad (\because \|\cdot\| \text{ の定義と } \left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a) \\
&\le \sum_{i=1}^{n}\sum_{j=1}^{n}
\left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{l=1}^{n}|b_{lj}|^2\right)
\quad (\because \text{Step 2}) \\
&= \left(\sum_{i=1}^{n}\sum_{k=1}^{n}|a_{ik}|^2\right)
   \left(\sum_{j=1}^{n}\sum_{l=1}^{n}|b_{lj}|^2\right)
\quad (\because \text{有限和の分配律}) \\
&= \|A\|^2\,\|B\|^2 \\
&= \left(\|A\|\cdot\|B\|\right)^2
\end{aligned}`,
      ),
      paragraph([
        "Step 4: 結論。",
        math(String.raw`\|AB\|\ge 0`),
        " かつ ",
        math(String.raw`\|A\|\cdot\|B\|\ge 0`),
        " であるから、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より",
      ]),
      displayMath(String.raw`\|AB\|\le\|A\|\cdot\|B\|`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は TODO のみ。ここで証明を与えた。" +
          "原文にはノルムの定義そのものが無かったため、Frobenius ノルムを定義するブロック" +
          "（labels: def_matrix_norm）とその基本性質のブロック（labels: matrix_norm_triangle_inequality）を" +
          "本ブロックの直前に追加している。",
      ],
    },
  },
  {
    id: "linear_space_general_003c_claim_matrix_norm_vector_bound",
    kind: "claim",
    sourcePath: "structured-latex/content/002_linear_space_general.mjs",
    sourceOrdinal: 3,
    title: { text: "行列ノルムによる数ベクトルの評価" },
    labels: ["matrix_norm_vector_bound"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`w \in K^n`),
        " について、",
      ]),
      displayMath(String.raw`\|Aw\| \le \|A\| \cdot \|w\|`),
      paragraph([
        "ここで ",
        math(String.raw`\|\cdot\|`),
        " は ",
        ref("def_matrix_norm"),
        " のノルム（左辺と右辺第 2 因子は ",
        math(String.raw`K^n`),
        " のノルム、右辺第 1 因子は ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " のノルム）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w=(w_1,\dots,w_n)`),
        " に対し、第 1 列が ",
        math(String.raw`w`),
        "、第 2 列以降が ",
        math(String.raw`0`),
        " である行列 ",
        math(String.raw`W\in\mathrm{Mat}(n,K)`),
        " を",
      ]),
      displayMath(
        String.raw`W_{i1} := w_i \quad (1\le i\le n), \qquad
W_{ij} := 0 \quad (1\le i\le n,\ 2\le j\le n)`,
      ),
      paragraph(["で定める。行列の積の定義より"]),
      displayMath(
        String.raw`(AW)_{i1}=\sum_{k=1}^{n}a_{ik}W_{k1}=\sum_{k=1}^{n}a_{ik}w_k=(Aw)_i,
\qquad
(AW)_{ij}=\sum_{k=1}^{n}a_{ik}\cdot 0=0 \quad (j\ge 2)`,
      ),
      paragraph([
        "である。",
        math(String.raw`|0|=0`),
        "（",
        ref("matrix_norm_triangle_inequality"),
        " の Step 1）より第 2 列以降は平方和に寄与しないので、",
      ]),
      displayMath(
        String.raw`\|AW\|=\sqrt{\sum_{i=1}^{n}\left|(Aw)_i\right|^2}^{\,(\mathbb{R}_{\ge 0})}=\|Aw\|,
\qquad
\|W\|=\sqrt{\sum_{i=1}^{n}|w_i|^2}^{\,(\mathbb{R}_{\ge 0})}=\|w\|`,
      ),
      paragraph([
        "したがって ",
        ref("matrix_norm_submultiplicativity"),
        " より",
      ]),
      displayMath(
        String.raw`\|Aw\|=\|AW\|\le\|A\|\cdot\|W\|=\|A\|\cdot\|w\|`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。exp 級数の各点収束（labels: exp_converges）の証明で" +
          "行列ノルムから数ベクトルの評価へ移る箇所が必要になるため、劣乗法性の直後に置いた。",
      ],
    },
  },
  {
    id: "linear_space_general_003d_claim_matrix_completeness",
    kind: "claim",
    sourcePath: "structured-latex/content/002_linear_space_general.mjs",
    sourceOrdinal: 3,
    title: { tex: String.raw`\mathrm{Mat}(n,K) \text{ の完備性と絶対収束判定}` },
    labels: ["matrix_completeness"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とし、ノルムと収束は ",
        ref("def_matrix_norm"),
        " のものとする。",
      ]),
      list([
        [
          "(1)（完備性）",
          math(String.raw`(A_N)_{N\ge 0}`),
          " を ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " の列とし、Cauchy 列である、すなわち",
          math(
            String.raw`\ \forall\varepsilon\in\mathbb{R}_{>0},\ \exists N_0\in\mathbb{Z}_{\ge 0}\ \text{s.t.}\ \forall N,M\ge N_0,\ \|A_N-A_M\|<\varepsilon\ `,
          ),
          "とする。このとき ",
          math(String.raw`A\in\mathrm{Mat}(n,K)`),
          " が存在して ",
          math(String.raw`A_N\to A`),
          "。",
        ],
        [
          "(2)（絶対収束判定）",
          math(String.raw`B_0,B_1,\dots\in\mathrm{Mat}(n,K)`),
          " について実数列の級数 ",
          math(String.raw`\sum_{m=0}^{\infty}\|B_m\|`),
          " が収束するならば ",
          math(String.raw`\sum_{m=0}^{\infty}B_m`),
          " は ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " において収束し、",
          math(String.raw`\left\|\sum_{m=0}^{\infty}B_m\right\|\le\sum_{m=0}^{\infty}\|B_m\|`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: 成分は ノルムで抑えられる。",
        math(String.raw`A=(a_{ij})\in\mathrm{Mat}(n,K)`),
        " と ",
        math(String.raw`1\le i,j\le n`),
        " について",
      ]),
      displayMath(
        String.raw`|a_{ij}|^2\le\sum_{k=1}^{n}\sum_{l=1}^{n}|a_{kl}|^2=\|A\|^2
\quad (\because \text{非負項の有限和は各項以上})`,
      ),
      paragraph([
        "であり、",
        math(String.raw`|a_{ij}|\ge 0`),
        "、",
        math(String.raw`\|A\|\ge 0`),
        " であるから ",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        math(String.raw`|a_{ij}|\le\|A\|`),
        "。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`K`),
        " の Cauchy 列は収束する。",
        math(String.raw`K=\mathbb{R}`),
        " のときは ",
        math(String.raw`\mathbb{R}`),
        " の完備性そのものである。",
        math(String.raw`K=\mathbb{C}`),
        " のとき、",
        math(String.raw`z=(x,y)\in\mathbb{C}`),
        " について ",
        ref("abs_basic_properties"),
        " (2) より ",
        math(String.raw`|z|^2=x^2+y^2\ge x^2=|x|^2`),
        "（最後の等号は実数の絶対値の定義 ",
        math(String.raw`|x|\in\{x,-x\}`),
        " による）であり、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        math(String.raw`|x|\le|z|`),
        "、同様に ",
        math(String.raw`|y|\le|z|`),
        "。",
        ref("complex_numbers_form_a_field"),
        " より ",
        math(String.raw`\mathbb{C}`),
        " の加法とその逆元は成分ごとであるから ",
        math(String.raw`z_N-z_M=(x_N-x_M,\ y_N-y_M)`),
        " であり、いま示した評価を ",
        math(String.raw`z=z_N-z_M`),
        " に適用すると ",
        math(String.raw`|x_N-x_M|\le|z_N-z_M|`),
        "、",
        math(String.raw`|y_N-y_M|\le|z_N-z_M|`),
        "。よって ",
        math(String.raw`\mathbb{C}`),
        " の Cauchy 列 ",
        math(String.raw`(z_N)=((x_N,y_N))`),
        " に対して ",
        math(String.raw`(x_N),(y_N)`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の Cauchy 列であり、",
        math(String.raw`\mathbb{R}`),
        " の完備性より ",
        math(String.raw`x_N\to x`),
        "、",
        math(String.raw`y_N\to y`),
        " なる ",
        math(String.raw`x,y\in\mathbb{R}`),
        " が存在する。このとき ",
        ref("abs_basic_properties"),
        " (2) より",
      ]),
      displayMath(
        String.raw`|z_N-(x,y)|^2=(x_N-x)^2+(y_N-y)^2\to 0`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`|z_N-(x,y)|\to 0`),
        "（非負実数について ",
        math(String.raw`u_N^2\to 0\Rightarrow u_N\to 0`),
        "。実際 ",
        math(String.raw`\varepsilon>0`),
        " に対し ",
        math(String.raw`u_N^2<\varepsilon^2`),
        " なる ",
        math(String.raw`N`),
        " 以降で ",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        math(String.raw`u_N<\varepsilon`),
        "）。",
      ]),
      paragraph([
        "Step 3: (1) の証明。",
        math(String.raw`(A_N)`),
        " を Cauchy 列とすると、Step 1 より各成分について",
      ]),
      displayMath(
        String.raw`\left|(A_N)_{ij}-(A_M)_{ij}\right|=\left|(A_N-A_M)_{ij}\right|\le\|A_N-A_M\|`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`((A_N)_{ij})_N`),
        " は ",
        math(String.raw`K`),
        " の Cauchy 列である。Step 2 よりその極限 ",
        math(String.raw`a_{ij}\in K`),
        " が存在する。",
        math(String.raw`A:=(a_{ij})\in\mathrm{Mat}(n,K)`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\|A_N-A\|^2=\sum_{i=1}^{n}\sum_{j=1}^{n}\left|(A_N)_{ij}-a_{ij}\right|^2\to 0
\quad (\because \text{有限個の } 0 \text{ に収束する実数列の和})`,
      ),
      paragraph([
        "であり、Step 2 末尾と同じ理由で ",
        math(String.raw`\|A_N-A\|\to 0`),
        "、すなわち ",
        math(String.raw`A_N\to A`),
        "。",
      ]),
      paragraph([
        "Step 4: (2) の証明。",
        math(String.raw`S_N:=\sum_{m=0}^{N}B_m`),
        "、",
        math(String.raw`T_N:=\sum_{m=0}^{N}\|B_m\|`),
        " とおく。仮定より ",
        math(String.raw`(T_N)`),
        " は収束するので Cauchy 列である。",
        math(String.raw`N>M`),
        " のとき ",
        ref("matrix_norm_triangle_inequality"),
        " (3) を繰り返し用いて",
      ]),
      displayMath(
        String.raw`\|S_N-S_M\|=\left\|\sum_{m=M+1}^{N}B_m\right\|
\le\sum_{m=M+1}^{N}\|B_m\|=T_N-T_M`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`(S_N)`),
        " は Cauchy 列であり、(1) より ",
        math(String.raw`S:=\lim_{N\to\infty}S_N`),
        " が存在する。すなわち ",
        math(String.raw`\sum_{m=0}^{\infty}B_m=S`),
        "。",
      ]),
      paragraph([
        "Step 5: ノルムの評価。",
        ref("matrix_norm_triangle_inequality"),
        " (3) より ",
        math(String.raw`\|S_N\|\le T_N\le T:=\sum_{m=0}^{\infty}\|B_m\|`),
        "（",
        math(String.raw`(T_N)`),
        " は非負項の級数の部分和なので単調非減少であり ",
        math(String.raw`T_N\le T`),
        "）。また ",
        ref("matrix_norm_triangle_inequality"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\|S\|\le\|S-S_N\|+\|S_N\|\le\|S-S_N\|+T`,
      ),
      paragraph([
        "であり、右辺第 1 項は ",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`0`),
        " に収束する。",
        math(String.raw`\|S\|`),
        " は ",
        math(String.raw`N`),
        " によらない定数であるから ",
        math(String.raw`\|S\|\le T`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。exp 級数の収束（labels: exp_converges）と" +
          "可換行列の exp 積公式（labels: theorem_exp_product）が前提とする" +
          "「Mat(n,K) が完備であること」「絶対収束すれば収束すること」を明示するために追加した。",
      ],
    },
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
