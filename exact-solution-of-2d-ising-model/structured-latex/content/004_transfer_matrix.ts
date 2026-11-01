import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_transfer_matrix",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 6 },
    title: { text: "行列と線型写像の対応と、対角行列の指数関数" },
    labels: [],
  },

  {
    id: "transfer_matrix_005_definition_end_isomorphism",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/004_転送行列/004_definition_EndFとMat2Cテンソル積Mの同型.typ",
      ordinal: 5,
    },
    title: { tex: String.raw`\mathbf{end}: \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{End}(\mathcal{F})` },
    labels: ["def_end_iso"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、",
      ]),
      displayMath(String.raw`\mathcal{F} := \mathbb{C}^{2^M}`),
      paragraph([
        "とおく（",
        math(String.raw`2^M`),
        " 次元の数ベクトル全体。",
        ref("def_kronecker"),
        " のクロネッカー積 ",
        math(String.raw`v_1\boxtimes\cdots\boxtimes v_M`),
        " が住む空間である）。",
        math(String.raw`\mathbb{C}^2`),
        " の標準基底を ",
        math(String.raw`e_1 := (1,0),\ e_2 := (0,1)`),
        "、",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位を ",
        math(String.raw`E_{ij}`),
        "（",
        math(String.raw`(i,j)`),
        " 成分が ",
        math(String.raw`1`),
        " で他が ",
        math(String.raw`0`),
        "、",
        math(String.raw`i,j\in\{1,2\}`),
        "）とする。多重添字 ",
        math(String.raw`\mathcal{I} := \{1,2\}^M`),
        " の元 ",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)`),
        " について",
      ]),
      displayMath(
        String.raw`f_I := e_{i_1}\boxtimes\cdots\boxtimes e_{i_M} \in \mathcal{F}, \qquad
E_{I,J} := E_{i_1j_1}\boxtimes\cdots\boxtimes E_{i_Mj_M} \in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "とおく（",
        ref("def_kronecker"),
        " のクロネッカー積。",
        math(String.raw`f_I \in \mathbb{C}^{2^M}`),
        " は数ベクトル、",
        math(String.raw`E_{I,J} \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " は ",
        math(String.raw`2^M`),
        " 次の複素行列である）。",
        ref("tensor_basis"),
        " (3) と (1) より ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " は ",
        math(String.raw`\mathcal{F}`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底（",
        math(String.raw`\dim_{\mathbb{C}}\mathcal{F} = 2^M`),
        "）であり、",
        math(String.raw`(E_{I,J})_{I,J\in\mathcal{I}}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底（",
        math(String.raw`\dim_{\mathbb{C}} = 4^M`),
        "）である。さらに ",
        math(String.raw`\Theta_{I,J} \in \mathrm{End}(\mathcal{F})`),
        " を、基底 ",
        math(String.raw`(f_K)_{K\in\mathcal{I}}`),
        " 上の値",
      ]),
      displayMath(
        String.raw`\Theta_{I,J}(f_K) := \begin{cases} f_I & (K=J) \\ 0 & (K\neq J)\end{cases}`,
      ),
      paragraph([
        "で定まる ",
        math(String.raw`\mathbb{C}`),
        "-線型写像とする（基底上の値を与えれば線型写像が一意に定まる）。このとき ",
        math(String.raw`\mathbf{end}`),
        " を、基底 ",
        math(String.raw`(E_{I,J})`),
        " 上で",
      ]),
      displayMath(
        String.raw`\mathbf{end}(E_{I,J}) := \Theta_{I,J} \qquad (I,J\in\mathcal{I})`,
      ),
      paragraph([
        "と定めて ",
        math(String.raw`\mathbb{C}`),
        "-線型に拡張した写像",
      ]),
      displayMath(
        String.raw`\mathbf{end}: \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{End}(\mathcal{F})`,
      ),
      paragraph([
        "とおく（",
        "この写像が積と単位行列を保つ全単射であることは、直後の主張で成分計算から示す）。",
        math(String.raw`A \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " の ",
        math(String.raw`\mathcal{F}`),
        " への作用 ",
        math(String.raw`Af`),
        "（",
        math(String.raw`f\in\mathcal{F}`),
        "）は、以後つねに ",
        math(String.raw`(\mathbf{end}(A))(f)`),
        " を意味する。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文は「End(F) と Mat(2,C)^{⊗M} の線型同型写像を一つ取る」としか書いていないが、" +
          "任意に取った線型同型では積・単位元が保たれず、<V1_restriction_to_eigenspaces> の証明" +
          "（ε の作用と exp の級数を交換する）が成立しない。そこで、正準な単位的 C-代数同型を" +
          "具体的に構成する形に書き換えた（正しさに必要な事項なので statement に置く）。",
        "写像の向きも原文は End(F) → Mat(2,C)^{⊗M} だが、原文の <V1_restriction_to_eigenspaces> は " +
          "end(V_1)|_{F^{(±)}} と、Mat(2,C)^{⊗M} の元 V_1 に end を適用して F 上の写像として制限している。" +
          "向きが逆でなければ型が合わないため、Mat(2,C)^{⊗M} → End(F) に訂正した。",
        "Mat(2,C)^{⊗M} 上の exp（<def_transfer_matrix_symbols> の V_1, V_2 で使われている）は、" +
          "どの位相での級数か原文に書かれていない。ここで end による移送として定義を与えた。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。V_1, V_2 のパウリ行列表示の証明が基底 f_I と行列の作用を使うため、転送行列の章の冒頭（サイトごとの Pauli 行列族の直後）へ移した。内容は変えていない。",
      ],
    },
  },

  {
    id: "bridge_003_claim_exp_of_diagonal",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 5 },
    title: { text: "対角行列の指数関数" },
    labels: ["exp_of_diagonal_matrix"],
    statement: [
      paragraph(["行列の積は ", ref("mat_mult"), "、複素成分の演算は ", ref("complex_numbers_form_a_field"), "、指数級数の部分和の実数の係数 ", math(String.raw`1/p!`), "（", math(String.raw`p \in \mathbb{Z}_{\ge 0}`), "）の複素数への包含は ", ref("inclusion_rr_to_cc"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`D \in \mathrm{Mat}(n,\mathbb{C})`),
        " が対角行列（すべての ",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`k \neq l \Rightarrow D_{kl} = 0`),
        "）で、",
        math(String.raw`k \in \{1,\dots,n\}`),
        " について対角成分を ",
        math(String.raw`d_k := D_{kk}`),
        " とすると、すべての ",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について",
      ]),
      displayMath(
        String.raw`\exp(D)_{kl} = \begin{cases} \exp(d_k) & (k = l) \\ 0 & (k \neq l)\end{cases}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\exp(D)`),
        " も対角行列で、対角成分は ",
        math(String.raw`\exp(d_k)`),
        " である。左辺の ",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        " (1) の行列の exp、右辺の ",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の複素数の exp であり、どちらも極限で定まる量である。また証明の中の絶対値の値は ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        " に入り（",
        ref("def_abs_arg"),
        "）、",
        math(String.raw`\mathbb{C}`),
        " の列の収束は実数列の収束である。これらの理由（極限）で、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出している。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中では、",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " は主張のとおりとし、",
        math(String.raw`p, N \in \mathbb{Z}_{\ge 0}`),
        " とし、数の冪を ",
        math(String.raw`d_k^{\,0} := 1`),
        "、",
        math(String.raw`d_k^{\,p+1} := d_k^{\,p}\,d_k`),
        " で、行列の冪を ",
        ref("def_exp"),
        " の ",
        math(String.raw`D^0 := I`),
        "、",
        math(String.raw`D^{p+1} := D^p D`),
        " で表す。部分和を",
      ]),
      displayMath(String.raw`S_N := \sum_{p=0}^{N}\frac{1}{p!}D^p \in \mathrm{Mat}(n,\mathbb{C})`),
      paragraph(["とおく。"]),
      paragraph([
        "中間目標: 対角行列の積。",
        math(String.raw`P, Q \in \mathrm{Mat}(n,\mathbb{C})`),
        " を対角行列とする。",
        math(String.raw`k \neq l`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(PQ)_{kl}
&= \sum_{j=1}^{n} P_{kj}Q_{jl}
   \quad (\because \blkref{mat_mult}) \\
&= P_{kk}Q_{kl}
   \quad (\because j \neq k \text{ の項は } P_{kj} = 0) \\
&= 0
   \quad (\because k \neq l \text{ より } Q_{kl} = 0)
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
(PQ)_{kk}
&= \sum_{j=1}^{n} P_{kj}Q_{jk}
   \quad (\because \blkref{mat_mult}) \\
&= P_{kk}Q_{kk}
   \quad (\because j \neq k \text{ の項は } P_{kj} = 0)
\end{aligned}`,
      ),
      paragraph(["である。すなわち対角行列どうしの積は対角行列で、対角成分は対角成分どうしの積である。"]),
      paragraph([
        "中間目標: 対角行列の冪。「",
        math(String.raw`D^p`),
        " は対角行列で ",
        math(String.raw`(D^p)_{kk} = d_k^{\,p}`),
        "」を ",
        math(String.raw`p`),
        " に関する帰納法で示す。",
        math(String.raw`p = 0`),
        " では、",
        math(String.raw`k \neq l`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(D^0)_{kl}
&= I_{kl}
   \quad (\because D^0 := I\text{。}\blkref{def_exp}) \\
&= 0
   \quad (\because \text{単位行列の非対角成分})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
(D^0)_{kk}
&= I_{kk}
   \quad (\because D^0 := I\text{。}\blkref{def_exp}) \\
&= 1
   \quad (\because \text{単位行列の対角成分}) \\
&= d_k^{\,0}
   \quad (\because d_k^{\,0} := 1)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`p`),
        " で成り立つと仮定する。",
        math(String.raw`k \neq l`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(D^{p+1})_{kl}
&= (D^p D)_{kl}
   \quad (\because D^{p+1} := D^p D\text{。}\blkref{def_exp}) \\
&= 0
   \quad (\because D^p \text{ は対角行列（帰納法の仮定）で、上の対角行列の積を } P := D^p,\ Q := D \text{ として適用})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
(D^{p+1})_{kk}
&= (D^p D)_{kk}
   \quad (\because D^{p+1} := D^p D\text{。}\blkref{def_exp}) \\
&= (D^p)_{kk}\,D_{kk}
   \quad (\because D^p \text{ は対角行列（帰納法の仮定）で、上の対角行列の積を } P := D^p,\ Q := D \text{ として適用}) \\
&= d_k^{\,p}\,D_{kk}
   \quad (\because \text{帰納法の仮定}) \\
&= d_k^{\,p}\,d_k
   \quad (\because d_k := D_{kk}) \\
&= d_k^{\,p+1}
   \quad (\because d_k^{\,p+1} := d_k^{\,p}\,d_k)
\end{aligned}`,
      ),
      paragraph(["である。"]),
      paragraph([
        "中間目標: 指数級数の部分和の成分。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(S_N)_{kk}
&= \sum_{p=0}^{N}\frac{1}{p!}(D^p)_{kk}
   \quad (\because \text{行列の和とスカラー倍は成分ごと}) \\
&= \sum_{p=0}^{N}\frac{d_k^{\,p}}{p!}
   \quad (\because \text{上の対角行列の冪を各項へ適用})
\end{aligned}`,
      ),
      paragraph([math(String.raw`k \neq l`), " のとき"]),
      displayMath(
        String.raw`\begin{aligned}
(S_N)_{kl}
&= \sum_{p=0}^{N}\frac{1}{p!}(D^p)_{kl}
   \quad (\because \text{行列の和とスカラー倍は成分ごと}) \\
&= \sum_{p=0}^{N}\frac{1}{p!}\cdot 0
   \quad (\because \text{上の対角行列の冪より } D^p \text{ は対角行列}) \\
&= 0
\end{aligned}`,
      ),
      paragraph([
        "中間目標: 極限。",
        ref("def_exp"),
        " (1) より ",
        math(String.raw`\exp(D) = \sum_{p=0}^{\infty}\frac{1}{p!}D^p`),
        " だから、",
        ref("exp_converges"),
        " (1b) を ",
        math(String.raw`A = D`),
        " に適用すると、すべての ",
        math(String.raw`(k,l)`),
        " について ",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の列の収束の意味で",
      ]),
      displayMath(String.raw`(S_N)_{kl} \to \exp(D)_{kl} \quad (N \to \infty)`),
      paragraph([
        "である。",
        math(String.raw`k \neq l`),
        " のとき、",
        math(String.raw`N \in \mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(S_N)_{kl} - 0\right|
&= |0 - 0|
   \quad (\because \text{上の部分和の成分 } (S_N)_{kl} = 0) \\
&= |0|
   \quad (\because 0 - 0 = 0) \\
&= 0
   \quad (\because \blkref{abs_basic_properties}\text{ (3)}) \\
&\to 0 \quad (N \to \infty)
   \quad (\because \text{各項が } 0 \text{ の実数列})
\end{aligned}`,
      ),
      paragraph([
        "であり、これは ",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の列の収束の意味で ",
        math(String.raw`(S_N)_{kl} \to 0`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\exp(D)_{kl} = 0
   \quad (\because \blkref{scalar_limit_is_unique}\text{ を、体を } \mathbb{C}\text{、列を } \bigl((S_N)_{kl}\bigr)_{N}\text{、}a := \exp(D)_{kl}\text{、}a' := 0 \text{ として。上の二つの収束})`,
      ),
      paragraph([
        "である。",
        math(String.raw`k = l`),
        " のとき、",
        math(String.raw`N \in \mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(S_N)_{kk} - \exp(d_k)\right|
&= \left|\sum_{p=0}^{N}\frac{d_k^{\,p}}{p!} - \exp(d_k)\right|
   \quad (\because \text{上の部分和の成分}) \\
&\to 0 \quad (N \to \infty)
   \quad (\because \blkref{scalar_exp_is_limit_of_partial_sums}\text{ を、体を } \mathbb{C}\text{、}x := d_k \text{ として})
\end{aligned}`,
      ),
      paragraph([
        "であり、これは ",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の列の収束の意味で ",
        math(String.raw`(S_N)_{kk} \to \exp(d_k)`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\exp(D)_{kk} = \exp(d_k)
   \quad (\because \blkref{scalar_limit_is_unique}\text{ を、体を } \mathbb{C}\text{、列を } \bigl((S_N)_{kk}\bigr)_{N}\text{、}a := \exp(D)_{kk}\text{、}a' := \exp(d_k) \text{ として。上の二つの収束})`,
      ),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。分配関数の転送行列の章から転送行列の章へ移した。Step 1〜3 の番号を中間目標の名前（対角行列の積と冪・指数級数の部分和・極限）へ変えた。",
        "2026-11-01: SageMath の検算（sagemath/check/exp_of_diagonal_matrix/）を付けるにあたり、証明を書き直した。冪の帰納法（基底と帰納の段）と、極限から成分を決める段を、根拠付きの鎖にした。対角成分の極限の根拠を、実数の級数の収束（labels: real_exp_series_converges）を複素数へ流用する書き方から、数の exp が部分和の極限であること（labels: scalar_exp_is_limit_of_partial_sums）と数の列の極限の一意性（labels: scalar_limit_is_unique。このとき足した）へ替えた。部分和の記号を E_K から S_N へ替えた（行列単位 E_{I,J} との衝突と、体 K との衝突を避けるため）。両辺の exp が極限で定まり、ℝ へ脱出していることを主張に書いた。",
      ],
    },
  },
  {
    id: "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 5 },
    title: { tex: String.raw`\mathbf{end} \text{ は単位的 } \mathbb{C}\text{-代数の同型}` },
    labels: ["end_is_algebra_isomorphism"],
    statement: [
      paragraph([
        ref("def_end_iso"),
        " の ",
        math(String.raw`\mathbf{end}`),
        " について、次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\mathbf{end}`),
          " は ",
          math(String.raw`\mathbb{C}`),
          "-線型同型（全単射）である。",
        ],
        [
          "(2) ",
          math(String.raw`\mathbf{end}(AB) = \mathbf{end}(A)\circ\mathbf{end}(B)`),
          "（",
          math(String.raw`A,B\in\mathrm{Mat}(2^M,\mathbb{C})`),
          "）。",
        ],
        [
          "(3) ",
          math(String.raw`\mathbf{end}\!\left(I_{\mathrm{Mat}(2^M,\mathbb{C})}\right) = \mathrm{id}_{\mathcal{F}}`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "記号は ",
        ref("def_end_iso"),
        " のものとする。多重添字 ",
        math(String.raw`I,J\in\mathcal{I}=\{1,2\}^M`),
        " について ",
        math(String.raw`\delta_{I,J} := 1`),
        "（",
        math(String.raw`I=J`),
        "）、",
        math(String.raw`0`),
        "（",
        math(String.raw`I\neq J`),
        "）とおく。成分ごとの ",
        math(String.raw`\delta_{i,j}`),
        " についても同様とし、",
        math(String.raw`I=J \iff \forall m,\ i_m=j_m`),
        " より",
      ]),
      displayMath(String.raw`\delta_{I,J} = \prod_{m=1}^{M}\delta_{i_m,j_m}`),
      paragraph(["が成り立つ。"]),
      paragraph([
        "Step 1: ",
        math(String.raw`(\Theta_{I,J})_{I,J\in\mathcal{I}}`),
        " は ",
        math(String.raw`\mathrm{End}(\mathcal{F})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底である。まず張ること: ",
        math(String.raw`T\in\mathrm{End}(\mathcal{F})`),
        " を任意に取り、基底 ",
        math(String.raw`(f_I)`),
        " による表示 ",
        math(String.raw`T(f_J) = \sum_{I\in\mathcal{I}} t_{I,J} f_I`),
        "（",
        math(String.raw`t_{I,J}\in\mathbb{C}`),
        " は一意）を取ると、任意の ",
        math(String.raw`K\in\mathcal{I}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{I,J\in\mathcal{I}} t_{I,J}\Theta_{I,J}\right)(f_K)
&= \sum_{I,J\in\mathcal{I}} t_{I,J}\,\Theta_{I,J}(f_K)
&&(\because\ \text{線型写像の和とスカラー倍の値の定義})\\
&= \sum_{I,J\in\mathcal{I}} t_{I,J}\,\delta_{J,K} f_I
&&(\because\ \Theta_{I,J}(f_K)=\delta_{J,K}f_I\ \text{（}\Theta_{I,J}\ \text{の定義）})\\
&= \sum_{I\in\mathcal{I}} t_{I,K} f_I
&&(\because\ \delta_{J,K}\ \text{は}\ J=K\ \text{のときだけ}\ 1\ \text{で他は}\ 0)\\
&= T(f_K)
&&(\because\ T(f_K)=\sum_{I\in\mathcal{I}} t_{I,K} f_I\ \text{（表示の取り方）})
\end{aligned}`,
      ),
      paragraph([
        "であり、基底上で一致する線型写像は等しいから ",
        math(String.raw`T = \sum_{I,J} t_{I,J}\Theta_{I,J}`),
        "。次に線型独立性: ",
        math(String.raw`c_{I,J}\in\mathbb{C}`),
        " が ",
        math(String.raw`\sum_{I,J} c_{I,J}\Theta_{I,J} = 0`),
        " を満たすとすると、各 ",
        math(String.raw`K`),
        " について次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&=\left(\sum_{I,J\in\mathcal I}c_{I,J}\Theta_{I,J}\right)(f_K)
&&(\because\ \sum_{I,J}c_{I,J}\Theta_{I,J}=0)\\
&=\sum_{I,J\in\mathcal I}c_{I,J}\delta_{J,K}f_I
&&(\because\ \Theta_{I,J}(f_K)=\delta_{J,K}f_I\ \text{と線型写像の和の値の定義})\\
&=\sum_{I\in\mathcal I}c_{I,K}f_I
&&(\because\ \delta_{J,K}\ \text{は}\ J=K\ \text{のときだけ}\ 1\ \text{で他は}\ 0)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(f_I)`),
        " が基底だからすべての ",
        math(String.raw`I`),
        " で ",
        math(String.raw`c_{I,K}=0`),
        "。",
        math(String.raw`K`),
        " は任意だからすべての係数が ",
        math(String.raw`0`),
        " である。",
      ]),
      paragraph([
        "Step 2: (1)。",
        math(String.raw`\mathbf{end}`),
        " は基底 ",
        math(String.raw`(E_{I,J})`),
        " を基底 ",
        math(String.raw`(\Theta_{I,J})`),
        " へ、添字を保って一対一に写す線型写像である。基底を基底へ写す線型写像は全単射である" +
          "（基底の像が張るので全射、基底の像が線型独立なので単射）。",
      ]),
      paragraph([
        "Step 3: (2)。両辺は ",
        math(String.raw`(A,B)`),
        " について ",
        math(String.raw`\mathbb{C}`),
        "-双線型（左辺は積の双線型性と ",
        math(String.raw`\mathbf{end}`),
        " の線型性、右辺は写像の合成の双線型性）だから、基底の元 ",
        math(String.raw`A=E_{I,J},\ B=E_{K,L}`),
        " について示せば十分である。",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位の積は ",
        math(String.raw`E_{ij}E_{kl} = \delta_{j,k}E_{il}`),
        "（成分計算）であるから、クロネッカー積の積の規則（",
        ref("kronecker_product_rule"),
        " (1)）と各因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{I,J}E_{K,L}
&= (E_{i_1j_1}E_{k_1l_1})\boxtimes\cdots\boxtimes(E_{i_Mj_M}E_{k_Ml_M})
&&(\because\ \text{クロネッカー積の積の規則})\\
&= (\delta_{j_1,k_1}E_{i_1l_1})\boxtimes\cdots\boxtimes(\delta_{j_M,k_M}E_{i_Ml_M})
&&(\because\ E_{ij}E_{kl}=\delta_{j,k}E_{il}\ \text{を各因子へ同時に適用})\\
&= \left(\prod_{m=1}^{M}\delta_{j_m,k_m}\right)
   \bigl(E_{i_1l_1}\boxtimes\cdots\boxtimes E_{i_Ml_M}\bigr)
&&(\because\ \text{各因子についての}\ \mathbb{C}\text{-線型性})\\
&= \left(\prod_{m=1}^{M}\delta_{j_m,k_m}\right) E_{I,L}
&&(\because\ E_{I,L}\ \text{の定義})\\
&= \delta_{J,K}E_{I,L}
&&(\because\ \delta_{J,K}=\prod_{m=1}^{M}\delta_{j_m,k_m})
\end{aligned}`,
      ),
      paragraph(["一方、任意の ", math(String.raw`P\in\mathcal{I}`), " について"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\Theta_{I,J}\circ\Theta_{K,L}\right)(f_P)
&= \Theta_{I,J}\!\left(\Theta_{K,L}(f_P)\right)
&&(\because\ \text{写像の合成の定義})\\
&= \Theta_{I,J}\!\left(\delta_{L,P}f_K\right)
&&(\because\ \Theta_{K,L}(f_P)=\delta_{L,P}f_K\ \text{（}\Theta_{K,L}\ \text{の定義）})\\
&= \delta_{L,P}\,\Theta_{I,J}(f_K)
&&(\because\ \Theta_{I,J}\ \text{の}\ \mathbb{C}\text{-線型性})\\
&= \delta_{L,P}\,\delta_{J,K}\,f_I
&&(\because\ \Theta_{I,J}(f_K)=\delta_{J,K}f_I\ \text{（}\Theta_{I,J}\ \text{の定義）})\\
&= \delta_{J,K}\,\delta_{L,P}\,f_I
&&(\because\ \mathbb{C}\ \text{の乗法の可換則})\\
&= \delta_{J,K}\,\Theta_{I,L}(f_P)
&&(\because\ \Theta_{I,L}(f_P)=\delta_{L,P}f_I\ \text{（}\Theta_{I,L}\ \text{の定義）})
\end{aligned}`,
      ),
      paragraph([
        "であり、基底上で一致するから ",
        math(String.raw`\Theta_{I,J}\circ\Theta_{K,L} = \delta_{J,K}\Theta_{I,L}`),
        "。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathbf{end}(E_{I,J}E_{K,L})
&= \mathbf{end}\!\left(\delta_{J,K}E_{I,L}\right)
&&(\because\ \text{上で示した}\ E_{I,J}E_{K,L}=\delta_{J,K}E_{I,L})\\
&= \delta_{J,K}\,\mathbf{end}(E_{I,L})
&&(\because\ \mathbf{end}\ \text{の}\ \mathbb{C}\text{-線型性})\\
&= \delta_{J,K}\,\Theta_{I,L}
&&(\because\ \mathbf{end}(E_{I,L})=\Theta_{I,L}\ \text{（}\mathbf{end}\ \text{の定義）})\\
&= \Theta_{I,J}\circ\Theta_{K,L}
&&(\because\ \text{上で示した}\ \Theta_{I,J}\circ\Theta_{K,L}=\delta_{J,K}\Theta_{I,L})\\
&= \mathbf{end}(E_{I,J})\circ\mathbf{end}(E_{K,L})
&&(\because\ \mathbf{end}\ \text{の定義を 2 箇所へ同時に適用})
\end{aligned}`,
      ),
      paragraph([
        "Step 4: (3)。",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})} = E_{11}+E_{22}`),
        "、",
        ref("kronecker_product_rule"),
        " (2)、およびクロネッカー積の各因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "。和で展開する）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
I_{\mathrm{Mat}(2^M,\mathbb{C})}
&= \underbrace{I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}}_{M}
&&(\because\ \text{クロネッカー積の単位元の規則})\\
&= \underbrace{(E_{11}+E_{22})\boxtimes\cdots\boxtimes(E_{11}+E_{22})}_{M}
&&(\because\ I_{\mathrm{Mat}(2,\mathbb{C})}=E_{11}+E_{22}\ \text{を各因子へ同時に適用})\\
&= \sum_{I\in\mathcal{I}} E_{i_1i_1}\boxtimes\cdots\boxtimes E_{i_Mi_M}
&&(\because\ \text{各因子についての}\ \mathbb{C}\text{-線型性で和を展開})\\
&= \sum_{I\in\mathcal{I}} E_{I,I}
&&(\because\ E_{I,I}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "であり、各 ",
        math(String.raw`K\in\mathcal{I}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{I\in\mathcal{I}}\Theta_{I,I}\right)(f_K)
&= \sum_{I\in\mathcal{I}}\Theta_{I,I}(f_K)
&&(\because\ \text{線型写像の和の値の定義})\\
&= \sum_{I\in\mathcal{I}}\delta_{I,K}f_I
&&(\because\ \Theta_{I,J}(f_K)=\delta_{J,K}f_I\ \text{（}\Theta_{I,J}\ \text{の定義）を}\ J=I\ \text{に取ること})\\
&= f_K
&&(\because\ \delta_{I,K}\ \text{は}\ I=K\ \text{のときだけ}\ 1\ \text{で他は}\ 0)\\
&= \mathrm{id}_{\mathcal{F}}(f_K)
&&(\because\ \text{恒等写像の定義})
\end{aligned}`,
      ),
      paragraph([
        "であり、基底上で一致する線型写像は等しいから ",
        math(String.raw`\sum_{I}\Theta_{I,I} = \mathrm{id}_{\mathcal{F}}`),
        " である。したがって次の一続きの式変形を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathbf{end}\!\left(I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&=\mathbf{end}\!\left(\sum_{I\in\mathcal I}E_{I,I}\right)
&&(\because\ I_{\mathrm{Mat}(2^M,\mathbb C)}=\sum_{I\in\mathcal I}E_{I,I}\ \text{を上で示した})\\
&=\sum_{I\in\mathcal I}\mathbf{end}(E_{I,I})
&&(\because\ \mathbf{end}\ \text{の}\ \mathbb C\text{-線型性})\\
&=\sum_{I\in\mathcal I}\Theta_{I,I}
&&(\because\ \mathbf{end}(E_{I,I})=\Theta_{I,I}\ \text{（}\mathbf{end}\ \text{の定義）})\\
&=\mathrm{id}_{\mathcal F}
&&(\because\ \sum_{I\in\mathcal I}\Theta_{I,I}=\mathrm{id}_{\mathcal F}\ \text{を上で示した})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文（Typst）に対応ブロックは無い。原文が「線型同型を一つ取る」で済ませていた end を" +
          "正準な単位的代数同型として構成したため、その性質（<V1_restriction_to_eigenspaces> の証明で" +
          "実際に使うのは線型性・乗法性・単位元の保存）をここで証明した。",
        "クロネッカー積で作る行列の作用公式は代数同型性とは独立した出力なので、別の主張へ分離した。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_end_acts_on_kronecker_products",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 5 },
    title: { text: "クロネッカー積で作る行列の作用" },
    labels: ["end_acts_on_kronecker_products"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        math(String.raw`v_1,\dots,v_M \in \mathbb{C}^2`),
        " とする。",
        ref("def_end_iso"),
        " の写像について",
      ]),
      displayMath(
        String.raw`\left(\mathbf{end}(A_1\boxtimes\cdots\boxtimes A_M)\right)(v_1\boxtimes\cdots\boxtimes v_M)
= (A_1v_1)\boxtimes\cdots\boxtimes(A_Mv_M)`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("kronecker_multilinear"),
        " より、両辺は ",
        math(String.raw`A_1,\dots,A_M,v_1,\dots,v_M`),
        " の各々について ",
        math(String.raw`\mathbb{C}`),
        "-線型であるから、",
        math(String.raw`A_m = E_{i_mj_m}`),
        "、",
        math(String.raw`v_m = e_{k_m}`),
        " の場合に示せば十分である。",
        math(String.raw`E_{ij}e_k = \delta_{j,k}e_i`),
        "（成分計算）より右辺は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(E_{i_1j_1}e_{k_1})\boxtimes\cdots\boxtimes(E_{i_Mj_M}e_{k_M})
&= (\delta_{j_1,k_1}e_{i_1})\boxtimes\cdots\boxtimes(\delta_{j_M,k_M}e_{i_M})
&&(\because\ E_{ij}e_k=\delta_{j,k}e_i\ \text{を各因子へ同時に適用})\\
&= \left(\prod_{m=1}^{M}\delta_{j_m,k_m}\right)
   \bigl(e_{i_1}\boxtimes\cdots\boxtimes e_{i_M}\bigr)
&&(\because\ \text{各因子についての}\ \mathbb{C}\text{-線型性})\\
&= \left(\prod_{m=1}^{M}\delta_{j_m,k_m}\right)f_I
&&(\because\ f_I\ \text{の定義})\\
&= \delta_{J,K}f_I
&&(\because\ \delta_{J,K}=\prod_{m=1}^{M}\delta_{j_m,k_m})
\end{aligned}`,
      ),
      paragraph(["であり、左辺は"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}(E_{I,J})\right)(f_K)
&= \Theta_{I,J}(f_K)
&&(\because\ \mathbf{end}(E_{I,J})=\Theta_{I,J}\ \text{（}\mathbf{end}\ \text{の定義）})\\
&= \delta_{J,K}f_I
&&(\because\ \Theta_{I,J}(f_K)=\delta_{J,K}f_I\ \text{（}\Theta_{I,J}\ \text{の定義）})
\end{aligned}`,
      ),
      paragraph(["であるから一致する。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "単位的代数同型の主張に混在していた独立した作用公式を、一ブロック一主張にするため分離した。",
        "抽象テンソル積を使わず、具体的なクロネッカー積と基底上の成分計算だけで示す。",
      ],
    },
  },
  {
    id: "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 5 },
    title: { text: "行列表示と線型写像表示は指数関数を保つ" },
    labels: ["end_preserves_matrix_exponential"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A\in\mathrm{Mat}(2^M,\mathbb{C})`),
        "、",
        math(String.raw`f\in\mathcal{F}=\mathbb{C}^{2^M}`),
        " とする。",
        ref("def_end_iso"),
        " の写像と ",
        ref("def_exp"),
        " の行列指数関数について",
      ]),
      paragraph([
        math(String.raw`\mathbf{end}(A)^0:=\mathrm{id}_{\mathcal{F}}`),
        "、",
        math(String.raw`\mathbf{end}(A)^{n+1}:=\mathbf{end}(A)^n\circ\mathbf{end}(A)`),
        "（",
        math(String.raw`n\in\mathbb{Z}_{\geq 0}`),
        "）と定める。このとき",
      ]),
      displayMath(
        String.raw`\left(\mathbf{end}(\exp(A))\right)(f)
= \lim_{N\to\infty}\sum_{n=0}^{N}\frac{1}{n!}\left(\mathbf{end}(A)^{n}\right)(f)
\qquad\left(\mathcal{F}\ \text{のノルムに関する収束}\right)`,
      ),
      paragraph(["が成り立つ。右辺は線型写像の指数関数という未定義の記号を使わず、数ベクトルの極限として定める。"]),
    ],
    proof: [
      paragraph([
        "Step 1: すべての ",
        math(String.raw`n\in\mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\mathbf{end}(A^n)=\mathbf{end}(A)^n`),
        "。",
        ref("end_is_algebra_isomorphism"),
        " の単位元保存より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathbf{end}(A^0)
&= \mathbf{end}\!\left(I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&\left(\because\ A^0=I_{\mathrm{Mat}(2^M,\mathbb{C})}\ \text{という行列の零乗の定義}\right)\\
&= \mathrm{id}_{\mathcal{F}}
&&\left(\because\ \mathbf{end}\ \text{の単位元保存}\right)\\
&= \mathbf{end}(A)^0
&&\left(\because\ \text{線型写像の零乗の定義}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n`),
        " で成り立つと仮定する。",
        ref("end_is_algebra_isomorphism"),
        " の乗法性より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathbf{end}(A^{n+1})
&= \mathbf{end}(A^nA)
&&\left(\because\ \text{行列の冪の定義}\right)\\
&= \mathbf{end}(A^n)\circ\mathbf{end}(A)
&&\left(\because\ \mathbf{end}\ \text{の乗法性}\right)\\
&= \mathbf{end}(A)^n\circ\mathbf{end}(A)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&= \mathbf{end}(A)^{n+1}
&&\left(\because\ \text{線型写像の冪の定義}\right).
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`S_N:=\sum_{n=0}^{N}\frac{1}{n!}A^n`),
        "、",
        math(String.raw`S:=\exp(A)`),
        " とおく。",
        ref("def_exp"),
        " と ",
        ref("exp_converges"),
        " の数ベクトルへの作用の各点収束より、",
      ]),
      displayMath(String.raw`S_Nf\longrightarrow Sf\qquad\left(\mathcal{F}\ \text{のノルムに関する収束}\right)`),
      paragraph([
        "が成り立つ。",
        ref("def_end_iso"),
        " の作用の記法と ",
        ref("end_is_algebra_isomorphism"),
        " の線型性、および Step 1 より、各 ",
        math(String.raw`N\in\mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_Nf
&= \left(\mathbf{end}(S_N)\right)(f)
&&\left(\because\ \text{行列の作用の記法}\right)\\
&= \left(\mathbf{end}\!\left(\sum_{n=0}^{N}\frac{1}{n!}A^n\right)\right)(f)
&&\left(\because\ S_N\ \text{の定義}\right)\\
&= \left(\sum_{n=0}^{N}\frac{1}{n!}\mathbf{end}(A^n)\right)(f)
&&\left(\because\ \mathbf{end}\ \text{の}\ \mathbb{C}\text{-線型性}\right)\\
&= \left(\sum_{n=0}^{N}\frac{1}{n!}\mathbf{end}(A)^n\right)(f)
&&\left(\because\ \text{Step 1 を各}\ n\in\{0,\dots,N\}\ \text{へ適用}\right)\\
&= \sum_{n=0}^{N}\frac{1}{n!}\left(\mathbf{end}(A)^n\right)(f)
&&\left(\because\ \text{線型写像の有限和とスカラー倍の値の定義}\right).
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`Sf=\left(\mathbf{end}(\exp(A))\right)(f)`),
        " である。Step 2 の収束でこの部分和表示を用いれば、主張の極限等式を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "代数同型の有限積に関する主張と、級数極限を使う指数関数保存を依存境界で分離した。",
        "End(F) 上の指数関数は現行本文で定義していないため、数ベクトルごとの具体的な部分和の極限として記述した。",
      ],
    },
  },
]);
