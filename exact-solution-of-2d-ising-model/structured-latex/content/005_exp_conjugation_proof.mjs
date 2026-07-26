import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_exp_conjugation_proof",
    kind: "heading",
    level: 2,
    sourcePath: "_old/typst/main.typ",
    sourceOrdinal: 7,
    title: { tex: String.raw`e^{X} Y e^{-X} = e^{\mathrm{ad}(X)}(Y) \text{ の証明}` },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_001_definition_Ad_ad_lie",
    kind: "definition",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/000_リー群リー環アプローチの概要とAd_adの定義.typ",
    sourceOrdinal: 1,
    title: null,
    labels: [],
    statement: [
      paragraph(["リー群・リー環を使うアプローチの概要（参考: 「Lie群とLie環1」定理 5.49）。"]),
      paragraph([
        math(String.raw`G, H`),
        ": Lie群、連続な準同型写像 ",
        math(String.raw`\phi : G \to H`),
        " について、",
      ]),
      list([
        [math(String.raw`\phi`), " は ", math(String.raw`C^{\omega}`), " 級である。"],
        [
          "Lie環 ",
          math(String.raw`\mathfrak{g} := \mathrm{Lie}(G)`),
          " から ",
          math(String.raw`\mathfrak{h} := \mathrm{Lie}(H)`),
          " への準同型写像 ",
          math(String.raw`\mathrm{d}\phi_e : \mathfrak{g} \to \mathfrak{h}`),
          " が存在し、",
          math(String.raw`\phi(\exp(X)) = \exp(\mathrm{d}\phi_e(X))`),
          " を満たす。",
        ],
      ]),
      paragraph([
        "この定理の証明を参考に、以下の定理を示したい。以下、",
        math(String.raw`\mathrm{Ad}`),
        "、",
        math(String.raw`\mathrm{ad}`),
        " を定める。",
      ]),
      paragraph([
        math(String.raw`G`),
        ": リー群、",
        math(String.raw`\mathfrak{g}`),
        ": リー環",
      ]),
      displayMath(
        String.raw`\mathrm{Ad} : G \to \mathrm{Aut}(G), \quad g \mapsto (x \mapsto g x g^{-1})`,
      ),
      displayMath(
        String.raw`\mathrm{ad} : \mathfrak{g} \to \mathrm{End}(\mathfrak{g}), \quad X \mapsto (Y \mapsto [X, Y])`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: ["原文冒頭の概要説明（Lie群・Lie環アプローチと参考定理 5.49）と Ad, ad の定義を忠実に反映した。"],
    },
  },
  {
    id: "exp_conjugation_proof_002_theorem_Ad_exp_lie",
    kind: "theorem",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/001_theorem_リー群上のAd(exp(X))=exp(ad(X)).typ",
    sourceOrdinal: 2,
    title: null,
    labels: [],
    statement: [
      paragraph([
        math(String.raw`G`),
        ": Lie群、",
        math(String.raw`\mathfrak{g}`),
        ": Lie環",
      ]),
      displayMath(String.raw`\mathrm{Ad}(\exp(X)) = \exp(\mathrm{ad}(X))`),
      paragraph([
        "本プロジェクトで実際に必要なのは、この一般の Lie 群に対する主張ではなく、行列環 ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        "（",
        math(String.raw`K=\mathbb{R}`),
        " または ",
        math(String.raw`\mathbb{C}`),
        "）における",
      ]),
      displayMath(
        String.raw`\exp(X)\,Y\,\exp(-X)=\exp\!\left(\mathrm{ad}_X\right)(Y)
\qquad \left(X,Y\in\mathrm{Mat}(n,K)\right)`,
      ),
      paragraph([
        "だけである。この行列版は ",
        ref("matrix_exp_conjugation"),
        " で証明済みであり、その証明は Lie 群論をいっさい使わず、",
        ref("ad_binomial"),
        "（純代数的な ad 展開公式）と ",
        ref("real_exp_series_converges"),
        "・",
        ref("matrix_norm_submultiplicativity"),
        "・",
        ref("matrix_exp_series_converges"),
        "（指数級数の絶対収束と行列ノルムの劣乗法性）だけから自己完結している。以降の議論はすべて ",
        ref("matrix_exp_conjugation"),
        " を根拠として使い、本ブロックの一般 Lie 群版を根拠として使うことはない。",
      ]),
    ],
    proof: [
      paragraph([
        "本ブロックの一般 Lie 群版は未証明である。理由は、このリポジトリに Lie 群・Lie 環・",
        math(String.raw`\mathrm{Lie}(G)`),
        "・",
        math(String.raw`\mathrm{Aut}(G)`),
        " の Lie 群構造を定義したブロックが存在せず（",
        ref("def_frobenius_inner_product"),
        " から先で扱っているのは行列環 ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " とその上のノルム位相だけである）、主張の記号が意味をもつ土台自体が未整備だからである。",
      ]),
      paragraph([
        todo(
          "TODO（一般 Lie 群版）: 多様体・Lie 群・Lie 環・指数写像の定義ブロックを整備し、Aut(G) が Lie 群で End(g) がその Lie 環であることを示したうえで証明する。本プロジェクトで必要な行列版は matrix_exp_conjugation で証明済みであり、この TODO は本論の依存関係には入らない。",
        ),
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）の proof も TODO のみ。一般 Lie 群版は土台（Lie 群・Lie 環の定義ブロック）が" +
          "リポジトリに存在しないため未証明のまま残し、本論で必要な行列版" +
          "（labels: matrix_exp_conjugation）を新規に追加して証明した旨を statement に明記した。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_003_definition_M_n_C_convergence",
    kind: "definition",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/002_式変形アプローチの概要と行列空間の内積ノルム収束の定義.typ",
    sourceOrdinal: 3,
    title: { tex: String.raw`M(n;\mathbb{C}) \text{ の内積・ノルム・収束}` },
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
        "（0）複素共役。",
        ref("definition_of_cc"),
        " により ",
        math(String.raw`\mathbb{C}=\mathbb{R}^2`),
        " であるから、",
        math(String.raw`z=(x,y)\in\mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\overline{z} := (x,-y) \in \mathbb{C},
\qquad \mathrm{Re}(z) := x \in \mathbb{R}`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`\overline{\phantom{z}} : \mathbb{C}\to\mathbb{C}`),
        "、",
        math(String.raw`\mathrm{Re} : \mathbb{C}\to\mathbb{R}`),
        "）。",
      ]),
      paragraph([
        "（1）随伴行列とトレース。",
        math(String.raw`A^{*} \in M(n;\mathbb{C})`),
        " と ",
        math(String.raw`\mathrm{tr} : M(n;\mathbb{C})\to\mathbb{C}`),
        " を",
      ]),
      displayMath(
        String.raw`\left(A^{*}\right)_{ij} := \overline{a_{ji}}
\quad (1\le i,j\le n),
\qquad
\mathrm{tr}(A) := \sum_{i=1}^{n} a_{ii} \in \mathbb{C}`,
      ),
      paragraph([
        "と定める（右辺はいずれも ",
        math(String.raw`\mathbb{C}`),
        " の有限個の元の和であり、",
        ref("definition_of_cc"),
        " の加法だけで定まる）。",
      ]),
      paragraph([
        "（2）内積（Frobenius 内積）。",
        math(String.raw`\langle\cdot,\cdot\rangle : M(n;\mathbb{C})\times M(n;\mathbb{C})\to\mathbb{C}`),
        " を",
      ]),
      displayMath(
        String.raw`\langle A, B\rangle := \mathrm{tr}\!\left(A^{*}B\right)
= \sum_{i=1}^{n}\sum_{j=1}^{n} \overline{a_{ij}}\, b_{ij}`,
      ),
      paragraph([
        "と定める（2 番目の等号は ",
        ref("frobenius_inner_product_axioms"),
        " (0) で示す）。この ",
        math(String.raw`\langle\cdot,\cdot\rangle`),
        " が Hermite 内積の公理（共役対称性・第 2 変数についての線型性・正定値性）を満たすことは ",
        ref("frobenius_inner_product_axioms"),
        " (1)(2)(3) で示す。",
      ]),
      paragraph([
        "（3）ノルム。",
        math(String.raw`\|\cdot\| : M(n;\mathbb{C})\to\mathbb{R}_{\ge 0}`),
        " を",
      ]),
      displayMath(
        String.raw`\|A\| := \sqrt{\,r_A\,}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0},
\qquad r_A \in \mathbb{R}_{\ge 0} \text{ は } \langle A,A\rangle = \iota_{\mathbb{R}\to\mathbb{C}}(r_A)
\text{ を満たす唯一の非負実数}`,
      ),
      paragraph([
        "と定める（内積の記号を使って ",
        math(String.raw`\|A\|=\sqrt{\langle A,A\rangle}`),
        " と略記する）。",
        ref("frobenius_inner_product_axioms"),
        " (3) により ",
        math(String.raw`\langle A,A\rangle=\iota_{\mathbb{R}\to\mathbb{C}}\!\left(\sum_{i,j}|a_{ij}|^2\right)`),
        " すなわち ",
        math(String.raw`r_A=\sum_{i,j}|a_{ij}|^2`),
        " が非負実数として一意に定まり（",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " は単射）、平方根は ",
        ref("definition_of_sqrt_r_positive"),
        " により定まる。したがってこのノルムは ",
        ref("def_matrix_norm"),
        " の Frobenius ノルム ",
        math(String.raw`\|A\|=\sqrt{\sum_{i,j}|a_{ij}|^2}^{\,(\mathbb{R}_{\ge 0})}`),
        " と一致し、ノルムの公理（正定値性・斉次性・三角不等式）は ",
        ref("matrix_norm_triangle_inequality"),
        " (1)(2)(3) で、劣乗法性 ",
        math(String.raw`\|AB\|\le\|A\|\,\|B\|`),
        " は ",
        ref("matrix_norm_submultiplicativity"),
        " で示されている。三角不等式を Cauchy--Schwarz の不等式 ",
        math(String.raw`|\langle A,B\rangle|\le\|A\|\,\|B\|`),
        " から導く別証明は ",
        ref("frobenius_inner_product_axioms"),
        " (4)(5) にある。",
      ]),
      paragraph([
        "（4）収束。列 ",
        math(String.raw`(A_N)_{N\in\mathbb{Z}_{\ge 0}}`),
        " の ",
        math(String.raw`A\in M(n;\mathbb{C})`),
        " への収束を",
      ]),
      displayMath(
        String.raw`A_N \to A \overset{\mathrm{def}}{\Longleftrightarrow}
\lim_{N\to\infty}\|A_N-A\| = 0`,
      ),
      paragraph([
        "で定める（",
        ref("def_matrix_norm"),
        " と同一の定義）。この収束は成分ごとの収束と同値であり、",
        math(String.raw`M(n;\mathbb{C})`),
        " はこの収束について完備である（したがって絶対収束する級数は収束する）。これらは ",
        ref("matrix_completeness"),
        " (1)(2) およびその証明の Step 1 で示されている。",
      ]),
      paragraph([
        "（5）解析への移行の明示。ここまでの（0）（1）（2）は ",
        math(String.raw`\mathbb{C}`),
        " の加法・乗法だけを使う代数的な構成であるが、（3）の平方根と（4）の極限は ",
        math(String.raw`\mathbb{R}`),
        " の順序完備性（上に有界な単調列の収束、Cauchy 列の収束）を使う。すなわち ",
        math(String.raw`M(n;\mathbb{C})\cong\mathbb{C}^{n^2}\cong\mathbb{R}^{2n^2}`),
        " の完備性は ",
        math(String.raw`\mathbb{R}`),
        " の完備性へ帰着され、この段階で本論は非可算集合 ",
        math(String.raw`\mathbb{R}/\mathbb{C}`),
        " の解析的性質へ移行している（",
        ref("matrix_completeness"),
        " の証明が使うのはこの一点である）。以降の級数収束の議論はすべてこの移行の上に乗る。",
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
    sourcePath: "structured-latex/content/005_exp_conjugation_proof.mjs",
    sourceOrdinal: 3,
    title: { text: "Frobenius 内積の性質（Hermite 内積の公理と Cauchy--Schwarz の不等式）" },
    labels: ["frobenius_inner_product_axioms"],
    statement: [
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
        ref("def_frobenius_inner_product"),
        " のものとする。次が成り立つ。",
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
          "。また ",
          ref("def_frobenius_inner_product"),
          " の ",
          math(String.raw`\|A\|=\sqrt{\langle A,A\rangle}`),
          " は ",
          ref("def_matrix_norm"),
          " のノルムと一致し ",
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
&= \overline{(x+u,\ y+v)} = (x+u,\ -(y+v)) = (x,-y)+(u,-v) = \overline{z}+\overline{w} \\
\overline{z\,w}
&= \overline{(xu-yv,\ xv+yu)} = (xu-yv,\ -(xv+yu)) \\
&= \left(x u-(-y)(-v),\ x(-v)+(-y)u\right) = (x,-y)\cdot(u,-v) = \overline{z}\cdot\overline{w} \\
\overline{\overline{z}}
&= \overline{(x,-y)} = (x,y) = z \\
\overline{z}\,z
&= (x,-y)\cdot(x,y) = (x\cdot x-(-y)\cdot y,\ x\cdot y+(-y)\cdot x) = (x^2+y^2,\ 0)
= \left(|z|^2\right)_{\mathbb{C}} \\
\mathrm{Re}(z) &= x \le \sqrt{x^2+y^2}^{\,(\mathbb{R}_{\ge 0})} = |z|
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\overline{z}z`),
        " の最後の等号は ",
        ref("abs_basic_properties"),
        " (2) と ",
        ref("inclusion_rr_to_cc"),
        "、",
        math(String.raw`\mathrm{Re}(z)\le|z|`),
        " は ",
        ref("abs_basic_properties"),
        " (1) と ",
        math(String.raw`x\le|x|=\sqrt{x^2}^{\,(\mathbb{R}_{\ge 0})}\le\sqrt{x^2+y^2}^{\,(\mathbb{R}_{\ge 0})}`),
        "（",
        ref("definition_of_sqrt_r_positive"),
        " の単調性）による）。",
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
&= \sum_{i,j}\overline{a_{ij}}\left(b_{ij}+c_{ij}\right)
 = \sum_{i,j}\left(\overline{a_{ij}}b_{ij}+\overline{a_{ij}}c_{ij}\right)
 = \langle A,B\rangle+\langle A,C\rangle \\
\langle A,\lambda B\rangle
&= \sum_{i,j}\overline{a_{ij}}\left(\lambda b_{ij}\right)
 = \lambda\sum_{i,j}\overline{a_{ij}}b_{ij}
 = \lambda\langle A,B\rangle \\
\langle A+B,C\rangle
&= \sum_{i,j}\overline{a_{ij}+b_{ij}}\;c_{ij}
 = \sum_{i,j}\left(\overline{a_{ij}}+\overline{b_{ij}}\right)c_{ij}
 = \langle A,C\rangle+\langle B,C\rangle \\
\langle \lambda A,B\rangle
&= \sum_{i,j}\overline{\lambda a_{ij}}\;b_{ij}
 = \sum_{i,j}\overline{\lambda}\,\overline{a_{ij}}\,b_{ij}
 = \overline{\lambda}\langle A,B\rangle
\end{aligned}`,
      ),
      paragraph(["Step 4: (3)。Step 0 の ", math(String.raw`\overline{z}z=\left(|z|^2\right)_{\mathbb{C}}`), " より、"]),
      displayMath(
        String.raw`\langle A,A\rangle
= \sum_{i,j}\overline{a_{ij}}\,a_{ij}
= \sum_{i,j}\left(|a_{ij}|^2\right)_{\mathbb{C}}
= \left(\sum_{i,j}|a_{ij}|^2\right)_{\mathbb{C}}`,
      ),
      paragraph([
        "（最後の等号は ",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " が加法を保つことによる）。よって ",
        math(String.raw`\langle A,A\rangle`),
        " は非負実数 ",
        math(String.raw`\sum_{i,j}|a_{ij}|^2`),
        " の像であり、",
        ref("def_matrix_norm"),
        " の定義から ",
        math(String.raw`\sum_{i,j}|a_{ij}|^2=\|A\|^2`),
        " すなわち ",
        math(String.raw`\langle A,A\rangle=\left(\|A\|^2\right)_{\mathbb{C}}`),
        "、および ",
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
        " であるから ",
        math(String.raw`u=\sum_{i,j}\overline{a_{ij}}\cdot 0_{\mathbb{C}}=0_{\mathbb{C}}`),
        " となり ",
        math(String.raw`|u|=0=\|A\|\,\|B\|`),
        "。",
      ]),
      paragraph([
        "場合 2: ",
        math(String.raw`\|B\|>0`),
        " のとき。",
        math(String.raw`\displaystyle t:=\frac{\overline{u}}{\left(\|B\|^2\right)_{\mathbb{C}}}\in\mathbb{C}`),
        " とおく（",
        math(String.raw`\|B\|^2>0`),
        " なので ",
        ref("complex_numbers_form_a_field"),
        " により逆元が存在する）。(2)(1) を展開すると",
      ]),
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
      paragraph([
        "ここで ",
        math(String.raw`\langle A,B\rangle=u`),
        "、",
        math(String.raw`\langle B,A\rangle=\overline{u}`),
        "（(1)）、",
        math(String.raw`\langle B,B\rangle=\left(\|B\|^2\right)_{\mathbb{C}}`),
        "（(3)）、",
        math(String.raw`\overline{t}=u/\left(\|B\|^2\right)_{\mathbb{C}}`),
        "（Step 0 と ",
        math(String.raw`\overline{\left(\|B\|^2\right)_{\mathbb{C}}}=\left(\|B\|^2\right)_{\mathbb{C}}`),
        "）であるから、",
        math(String.raw`\overline{u}u=\left(|u|^2\right)_{\mathbb{C}}`),
        "（Step 0）を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
-t\langle A,B\rangle &= -\frac{\overline{u}\,u}{\left(\|B\|^2\right)_{\mathbb{C}}}
 = -\left(\frac{|u|^2}{\|B\|^2}\right)_{\mathbb{C}} \\
-\overline{t}\langle B,A\rangle &= -\frac{u\,\overline{u}}{\left(\|B\|^2\right)_{\mathbb{C}}}
 = -\left(\frac{|u|^2}{\|B\|^2}\right)_{\mathbb{C}} \\
\overline{t}\,t\,\langle B,B\rangle
&= \frac{u\,\overline{u}}{\left(\|B\|^2\right)_{\mathbb{C}}\left(\|B\|^2\right)_{\mathbb{C}}}
   \cdot\left(\|B\|^2\right)_{\mathbb{C}}
 = \left(\frac{|u|^2}{\|B\|^2}\right)_{\mathbb{C}}
\end{aligned}`,
      ),
      paragraph(["となり、合わせて"]),
      displayMath(
        String.raw`\left(\left\|A-tB\right\|^2\right)_{\mathbb{C}}
= \left(\|A\|^2\right)_{\mathbb{C}}-\left(\frac{|u|^2}{\|B\|^2}\right)_{\mathbb{C}}
= \left(\|A\|^2-\frac{|u|^2}{\|B\|^2}\right)_{\mathbb{C}}`,
      ),
      paragraph([
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " は単射なので実数の等式 ",
        math(String.raw`\|A-tB\|^2=\|A\|^2-|u|^2/\|B\|^2`),
        " を得る。左辺は ",
        ref("matrix_norm_triangle_inequality"),
        " (1) より ",
        math(String.raw`\ge 0`),
        " であるから ",
        math(String.raw`|u|^2/\|B\|^2\le\|A\|^2`),
        "、両辺に ",
        math(String.raw`\|B\|^2>0`),
        " を掛けて ",
        math(String.raw`|u|^2\le\|A\|^2\|B\|^2=\left(\|A\|\,\|B\|\right)^2`),
        "。",
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
&= \langle A+B,\ A+B\rangle \\
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
        " と書けば ",
        math(String.raw`u+\overline{u}=(x,y)+(x,-y)=(2x,0)=\left(2\,\mathrm{Re}(u)\right)_{\mathbb{C}}`),
        " であるから、",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " の単射性により実数の等式 ",
        math(String.raw`\|A+B\|^2=\|A\|^2+2\,\mathrm{Re}(u)+\|B\|^2`),
        " を得る。Step 0 の ",
        math(String.raw`\mathrm{Re}(u)\le|u|`),
        " と Step 5 の (4) より",
      ]),
      displayMath(
        String.raw`\|A+B\|^2
\le \|A\|^2+2|u|+\|B\|^2
\le \|A\|^2+2\|A\|\,\|B\|+\|B\|^2
= \left(\|A\|+\|B\|\right)^2`,
      ),
      paragraph([
        "となり、両辺とも非負なので平方の単調性（",
        ref("matrix_norm_triangle_inequality"),
        " の証明 Step 0）により ",
        math(String.raw`\|A+B\|\le\|A\|+\|B\|`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文が TODO のまま残していた M(n;C) の内積" +
          "（labels: def_frobenius_inner_product）を定義した以上、それが Hermite 内積の公理を" +
          "満たすこと、および Cauchy--Schwarz からノルムの三角不等式が導かれることを" +
          "明示的に証明しておく必要があるため追加した。",
      ],
    },
  },
  {
    id: "exp_conjugation_proof_004_theorem_ad_binomial",
    kind: "theorem",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/003_theorem_ad展開の二項定理的公式_BrianHall_exercise14.typ",
    sourceOrdinal: 4,
    title: { text: "ad 展開の二項定理的公式（Brian Hall exercise 14）" },
    labels: ["ad_binomial"],
    statement: [
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
&= \frac{m!}{(k-1)!\,(m-k+1)!}+\frac{m!}{k!\,(m-k)!} \\
&= \frac{m!\cdot k}{k!\,(m+1-k)!}+\frac{m!\cdot (m+1-k)}{k!\,(m+1-k)!}
   \quad \left(\because k!=k\cdot(k-1)!,\ (m+1-k)!=(m+1-k)\cdot(m-k)!\right) \\
&= \frac{m!\left(k+(m+1-k)\right)}{k!\,(m+1-k)!} \\
&= \frac{m!\,(m+1)}{k!\,(m+1-k)!} \\
&= \frac{(m+1)!}{k!\,(m+1-k)!}
   \quad (\because (m+1)!=(m+1)\cdot m!) \\
&= \binom{m+1}{k}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k=0`),
        " のときは ",
        math(String.raw`\binom{m}{-1}+\binom{m}{0}=0+1=1=\binom{m+1}{0}`),
        "、",
        math(String.raw`k=m+1`),
        " のときは ",
        math(String.raw`\binom{m}{m}+\binom{m}{m+1}=1+0=1=\binom{m+1}{m+1}`),
        "、",
        math(String.raw`k<0`),
        " または ",
        math(String.raw`k>m+1`),
        " のときは両辺とも ",
        math(String.raw`0`),
        "。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`m=0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\sum_{k=0}^{0}\binom{0}{k}X^{k}Y(-X)^{0-k}
= \binom{0}{0}X^{0}Y(-X)^{0}
= 1\cdot I\,Y\,I
= Y
= \mathrm{ad}_X^{0}(Y)`,
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
        String.raw`\sum_{k=0}^{m}\binom{m}{k}X^{k+1}Y(-X)^{m-k}
= \sum_{j=1}^{m+1}\binom{m}{j-1}X^{j}Y(-X)^{m+1-j}`,
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
   +\sum_{j=0}^{m+1}\binom{m}{j}X^{j}Y(-X)^{m+1-j} \\
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
    id: "exp_conjugation_proof_005_definition_GL_n_C",
    kind: "definition",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/004_definition_一般線型群GL(n,CC)とその群構造.typ",
    sourceOrdinal: 5,
    title: { tex: String.raw`\mathbf{GL}(n,\mathbb{C}) \text{ の定義}（\text{Brian Hall Definition 1.4}）` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\mathrm{GL}(n,\mathbb{C}) := \{x \in \mathrm{M}(n,\mathbb{C}) \mid x \text{ は可逆}\}`,
      ),
      paragraph([
        math(String.raw`\mathbf{GL}(n,\mathbb{C}) := (\mathrm{GL}(n,\mathbb{C}), \cdot)`),
        " は群をなす。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_006_definition_matrix_lie_group",
    kind: "definition",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/005_definition_Matrix_Lie群の定義.typ",
    sourceOrdinal: 6,
    title: { text: "Matrix Lie群（Brian Hall Definition 1.4）" },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`G \subset \mathbf{GL}(n,\mathbb{C})`),
        " が以下を満たすとき、",
        math(String.raw`G`),
        " を Matrix Lie群という：",
      ]),
      list([
        [math(String.raw`G`), " は部分群"],
        [
          math(String.raw`G`),
          " の元の列 ",
          math(String.raw`A_m`),
          " が ",
          math(String.raw`\mathrm{M}(n,\mathbb{C})`),
          " 上で収束するとき、",
          math(String.raw`A := \lim_{m\to\infty} A_m`),
          " について ",
          math(String.raw`A \in G`),
          " または ",
          math(String.raw`A \notin \mathbf{GL}(n,\mathbb{C})`),
        ],
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_007_definition_Ad_g_ad_X_matrix",
    kind: "definition",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/006_definition_Matrix_Lie群上のAd_gとad_Xの定義.typ",
    sourceOrdinal: 7,
    title: { text: "Ad_g と ad_X の定義（Brian Hall Definition 3.32）" },
    labels: ["def_ad_X_matrix"],
    statement: [
      paragraph([
        math(String.raw`G`),
        ": Matrix Lie群、",
        math(String.raw`g \in G`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathrm{Ad}_g : G \to G, \quad h \mapsto g h g^{-1}`,
      ),
      paragraph([
        math(String.raw`X \in \mathrm{M}(n,\mathbb{C})`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathrm{ad}_X : \mathrm{M}(n,\mathbb{C}) \to \mathrm{M}(n,\mathbb{C}), \quad Y \mapsto [X, Y]`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_008_theorem_exp_ad_series",
    kind: "theorem",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/007_theorem_exp(ad_X)(Y)の級数展開_BrianHall_Prop3.35.typ",
    sourceOrdinal: 8,
    title: { tex: String.raw`e^{\mathrm{ad}_X}(Y) \text{ の級数展開}` },
    labels: ["brianhall_exc14"],
    statement: [
      paragraph([
        math(String.raw`\forall X, Y \in \mathrm{M}(n,\mathbb{C})`),
        " について、",
      ]),
      displayMath(
        String.raw`e^{\mathrm{ad}_X}(Y)
= \sum_{n=0}^{\infty} \frac{1}{n!}
  \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{n\text{ times}}
= Y + [X,Y] + \tfrac{1}{2}[X,[X,Y]] + \tfrac{1}{6}[X,[X,[X,Y]]] + \cdots`,
      ),
      paragraph([
        "（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`Y`),
        " とする）",
      ]),
    ],
    proof: [
      paragraph([
        "注意: Brian Hall「Lie Groups, Lie Algebras, and Representations」Proposition 3.35 の参考記述であり、このリポジトリでは未証明。証明の根拠として使用することは禁止する。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_009_theorem_exp_conjugation_main",
    kind: "theorem",
    sourcePath: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/008_theorem_exp(X)Yexp(-X)=Ad(exp(X))(Y)=exp(ad_X)(Y)_BrianHall_Prop3.35.typ",
    sourceOrdinal: 9,
    title: { tex: String.raw`e^X Y e^{-X} = \mathrm{Ad}_{e^X}(Y) = e^{\mathrm{ad}_X}(Y)` },
    labels: ["brianhall_3.35"],
    statement: [
      paragraph([
        math(String.raw`\forall X \in \mathrm{M}(n,\mathbb{C})`),
        " s.t. ",
        math(String.raw`\forall t \in \mathbb{R},\; \exp(tX) \in G`),
        "、",
        math(String.raw`\forall Y \in G`),
        " について、",
      ]),
      displayMath(
        String.raw`\exp(X)\, Y\, \exp(-X) = \mathrm{Ad}_{\exp(X)}(Y) = \exp(\mathrm{ad}_X)(Y)`,
      ),
    ],
    proof: [
      paragraph([
        "注意: Brian Hall「Lie Groups, Lie Algebras, and Representations」Proposition 3.35 の参考記述であり、このリポジトリでは未証明。証明の根拠として使用することは禁止する。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
    kind: "theorem",
    sourcePath: "structured-latex/content/005_exp_conjugation_proof.mjs",
    sourceOrdinal: 9,
    title: {
      tex: String.raw`\text{行列版: } e^{X} Y e^{-X} = e^{\mathrm{ad}_X}(Y)`,
    },
    labels: ["matrix_exp_conjugation"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`X, Y\in\mathrm{Mat}(n,K)`),
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
          math(String.raw`\mathrm{Mat}(n,K)`),
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
        math(String.raw`A\in\mathrm{Mat}(n,K)`),
        " について ",
        math(String.raw`S_N(A):=\sum_{p=0}^{N}\frac{1}{p!}A^{p}\in\mathrm{Mat}(n,K)`),
        "（",
        math(String.raw`A^0:=I`),
        "）とおく。",
        ref("matrix_exp_series_converges"),
        " より ",
        math(String.raw`S_N(X)\to\exp(X)`),
        "、",
        math(String.raw`S_N(-X)\to\exp(-X)`),
        "。この収束が本証明で使う唯一の解析的事実であり、その根拠は ",
        math(String.raw`\mathbb{R}`),
        " の完備性（",
        ref("matrix_completeness"),
        "）である。ここから先で非可算集合 ",
        math(String.raw`\mathbb{R}/\mathbb{C}`),
        " の解析を使うのは、この極限操作と ",
        math(String.raw`R_N(a)\to 0`),
        " の 2 箇所だけであり、残りはすべて有限和の代数計算である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\mathrm{ad}_X`),
        " は ",
        math(String.raw`K`),
        "-線型。",
        math(String.raw`Z,W\in\mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`c\in K`),
        " について分配律より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}_X(Z+W) &= X(Z+W)-(Z+W)X = (XZ-ZX)+(XW-WX) = \mathrm{ad}_X(Z)+\mathrm{ad}_X(W) \\
\mathrm{ad}_X(cZ) &= X(cZ)-(cZ)X = c(XZ-ZX) = c\,\mathrm{ad}_X(Z)
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\mathrm{ad}_X\in\mathrm{End}\!\left(\mathrm{Mat}(n,K)\right)`),
        " であり、",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " は ",
        ref("def_matrix_norm"),
        " のノルムをもつ有限次元 ",
        math(String.raw`K`),
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
        "。実際 ",
        ref("matrix_norm_triangle_inequality"),
        " (3) と ",
        ref("matrix_norm_submultiplicativity"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|C_N D_N-CD\right\|
&= \left\|C_N D_N-C_N D+C_N D-CD\right\| \\
&\le \left\|C_N(D_N-D)\right\|+\left\|(C_N-C)D\right\|
   \quad (\because \text{三角不等式}) \\
&\le \left\|C_N\right\|\left\|D_N-D\right\|+\left\|C_N-C\right\|\left\|D\right\|
   \quad (\because \text{劣乗法性})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\|C_N\|=\|C+(C_N-C)\|\le\|C\|+\|C_N-C\|`),
        " は ",
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
        "（",
        ref("ad_binomial"),
        " の証明 Step 0）に注意すると、有限和の分配律より",
      ]),
      displayMath(
        String.raw`Q_N
= \left(\sum_{p=0}^{N}\frac{1}{p!}X^{p}\right)Y\left(\sum_{q=0}^{N}\frac{1}{q!}(-X)^{q}\right)
= \sum_{p=0}^{N}\sum_{q=0}^{N}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q}`,
      ),
      paragraph([
        "一方 ",
        ref("ad_binomial"),
        " より ",
        math(String.raw`\mathrm{ad}_X^{m}(Y)=\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k}`),
        " であり、",
        math(String.raw`\dfrac{1}{m!}\binom{m}{k}=\dfrac{1}{m!}\cdot\dfrac{m!}{k!\,(m-k)!}=\dfrac{1}{k!\,(m-k)!}`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_N
&= \sum_{m=0}^{N}\frac{1}{m!}\sum_{k=0}^{m}\binom{m}{k}X^{k}Y(-X)^{m-k} \\
&= \sum_{m=0}^{N}\sum_{k=0}^{m}\frac{1}{k!\,(m-k)!}\,X^{k}\,Y\,(-X)^{m-k} \\
&= \sum_{(p,q)\in T_N}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q},
\qquad T_N:=\left\{(p,q)\in\mathbb{Z}_{\ge 0}^{2} \;\middle|\; p+q\le N\right\}
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
        String.raw`Q_N-P_N
= \sum_{(p,q)\in D_N}\frac{1}{p!\,q!}\,X^{p}\,Y\,(-X)^{q},
\qquad
D_N := \{0,\dots,N\}^{2}\setminus T_N
= \left\{(p,q) \;\middle|\; 0\le p,q\le N,\ p+q>N\right\}`,
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
        "が成り立つ。実際、",
        math(String.raw`l\in\mathbb{Z}_{\ge 1}`),
        " について ",
        math(String.raw`\|X^{l}\|\le a^{l}`),
        " は ",
        ref("matrix_norm_submultiplicativity"),
        " と ",
        math(String.raw`l`),
        " についての帰納法（",
        math(String.raw`l=1`),
        " は自明、",
        math(String.raw`\|X^{l+1}\|=\|X^{l}X\|\le\|X^{l}\|\,\|X\|\le a^{l}\cdot a=a^{l+1}`),
        "）で従い、",
        ref("matrix_norm_triangle_inequality"),
        " (2) より ",
        math(String.raw`\|(-X)^{l}\|=\|(-1)^{l}X^{l}\|=|(-1)^{l}|\,\|X^{l}\|=\|X^{l}\|\le a^{l}`),
        "。よって",
      ]),
      list([
        [
          math(String.raw`p\ge 1,\ q\ge 1`),
          " のとき ",
          math(String.raw`\left\|X^{p}Y(-X)^{q}\right\|\le\|X^{p}\|\,\|Y\|\,\|(-X)^{q}\|\le a^{p}\|Y\|a^{q}`),
          "（劣乗法性を 2 回）。",
        ],
        [
          math(String.raw`p=0,\ q\ge 1`),
          " のとき ",
          math(String.raw`X^{0}Y(-X)^{q}=Y(-X)^{q}`),
          " なので ",
          math(String.raw`\left\|Y(-X)^{q}\right\|\le\|Y\|a^{q}=a^{0}\|Y\|a^{q}`),
          "。",
        ],
        [
          math(String.raw`p\ge 1,\ q=0`),
          " のときも同様に ",
          math(String.raw`\left\|X^{p}Y\right\|\le a^{p}\|Y\|=a^{p}\|Y\|a^{0}`),
          "。",
        ],
        [
          math(String.raw`p=q=0`),
          " のとき ",
          math(String.raw`X^{0}Y(-X)^{0}=Y`),
          " なので ",
          math(String.raw`\|Y\|=a^{0}\|Y\|a^{0}`),
          "。",
        ],
      ]),
      paragraph([
        "いずれの場合も ",
        math(String.raw`\left\|X^{p}Y(-X)^{q}\right\|\le a^{p}\|Y\|a^{q}=a^{p+q}\|Y\|`),
        "。",
      ]),
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
        " は空でない）、三角不等式（",
        ref("matrix_norm_triangle_inequality"),
        " (3) を有限個に繰り返し適用）と ",
        ref("matrix_norm_triangle_inequality"),
        " (2)、および Step 4 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|Q_N-P_N\right\|
&\le \sum_{(p,q)\in D_N}\frac{1}{p!\,q!}\left\|X^{p}Y(-X)^{q}\right\|
   \quad (\because \text{三角不等式・斉次性}) \\
&\le \|Y\|\sum_{(p,q)\in D_N}\frac{a^{p}}{p!}\cdot\frac{a^{q}}{q!}
   \quad (\because \text{Step 4}) \\
&\le \|Y\|\left(\sum_{(p,q)\in A_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}
   +\sum_{(p,q)\in B_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}\right)
   \quad (\because D_N\subset A_N\cup B_N,\ \text{各項} \ge 0)
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        ref("real_exp_series_converges"),
        " (2)(3) より ",
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
 \le R_{L}(a)\,E(a) \\
\sum_{(p,q)\in B_N}\frac{a^{p}}{p!}\frac{a^{q}}{q!}
&= \left(\sum_{p=0}^{N}\frac{a^{p}}{p!}\right)\left(\sum_{q=L+1}^{N}\frac{a^{q}}{q!}\right)
 \le E(a)\,R_{L}(a)
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\left\|Q_N-P_N\right\| \le 2\,\|Y\|\,E(a)\,R_{L}(a),
\qquad L=\left\lfloor N/2\right\rfloor`,
      ),
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
        " であるから、三角不等式より",
      ]),
      displayMath(
        String.raw`\left\|P_N-\exp(X)\,Y\,\exp(-X)\right\|
\le \left\|P_N-Q_N\right\|+\left\|Q_N-\exp(X)\,Y\,\exp(-X)\right\|
\longrightarrow 0`,
      ),
      paragraph([
        "すなわち ",
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
        "Step 7: (3)。",
        math(String.raw`X(-X)=-X^2=(-X)X`),
        " なので ",
        ref("theorem_exp_product"),
        " が適用でき、",
        ref("theorem_exp_zero"),
        " と合わせて",
      ]),
      displayMath(
        String.raw`\exp(X)\exp(-X)=\exp\!\left(X+(-X)\right)=\exp(O)=I,
\qquad
\exp(-X)\exp(X)=\exp(O)=I`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\exp(X)`),
        " は正則で ",
        math(String.raw`\exp(X)^{-1}=\exp(-X)`),
        "。よって ",
        ref("def_ad_X_matrix"),
        " の ",
        math(String.raw`\mathrm{Ad}_{\exp(X)}(Y)=\exp(X)Y\exp(X)^{-1}=\exp(X)Y\exp(-X)=\exp(\mathrm{ad}_X)(Y)`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文は一般の Lie 群に対する " +
          "Ad(exp X)=exp(ad X)（このファイルの exp_conjugation_proof_002）と " +
          "Brian Hall Prop 3.35（labels: brianhall_3.35）を未証明のまま置いていたが、" +
          "本プロジェクトで実際に必要なのは行列環 Mat(n,K) 上の版だけである。" +
          "そちらは labels: ad_binomial（純代数）と labels: real_exp_series_converges / " +
          "matrix_norm_submultiplicativity / matrix_exp_series_converges（絶対収束と劣乗法性）" +
          "だけから完全に証明できるので、Lie 群論を経由せずここで証明した。",
      ],
    },
  },
]);
