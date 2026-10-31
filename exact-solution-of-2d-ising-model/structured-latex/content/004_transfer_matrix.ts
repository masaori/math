import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_diagonalization_appendix_B",
    kind: "heading",
    level: 1,
    origin: { path: "_old/typst/main.typ", ordinal: 5 },
    title: { text: "対角化の計算 (ホロノミック量子場 付録B)" },
    labels: [],
  },
  {
    id: "heading_transfer_matrix",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 6 },
    title: { text: "転送行列" },
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
      paragraph(["行列の成分積は ", ref("mat_mult"), "、複素成分の演算は ", ref("complex_numbers_form_a_field"), "、実数係数の包含は ", ref("inclusion_rr_to_cc"), "、非負平方根は ", ref("definition_of_sqrt_r_positive"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`D \in \mathrm{Mat}(n,\mathbb{C})`),
        " が対角行列（",
        math(String.raw`k \neq l \Rightarrow D_{kl} = 0`),
        "）で対角成分を ",
        math(String.raw`d_k := D_{kk}`),
        " とすると、",
      ]),
      displayMath(
        String.raw`\exp(D)_{kl} = \begin{cases} \exp(d_k) & (k = l) \\ 0 & (k \neq l)\end{cases}`,
      ),
      paragraph(["すなわち ", math(String.raw`\exp(D)`), " も対角行列で、対角成分は ", math(String.raw`\exp(d_k)`), " である。"]),
    ],
    proof: [
      paragraph([
        "中間目標: 対角行列の積と冪。対角行列 ",
        math(String.raw`D, D'`),
        " の積の成分を計算する。",
        math(String.raw`k \neq l`),
        " の場合:",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(DD')_{kl}
&= \sum_{j=1}^{n} D_{kj}D'_{jl}
   \quad (\because \text{行列積の成分の定義}) \\
&= D_{kk}D'_{kl}
   \quad (\because j \neq k \text{ の項は } D_{kj} = 0) \\
&= 0
   \quad (\because k \neq l \text{ より } D'_{kl} = 0).
\end{aligned}`,
      ),
      paragraph([math(String.raw`k = l`), " の場合:"]),
      displayMath(
        String.raw`\begin{aligned}
(DD')_{kk}
&= \sum_{j=1}^{n} D_{kj}D'_{jk}
   \quad (\because \text{行列積の成分の定義}) \\
&= D_{kk}D'_{kk}
   \quad (\because j \neq k \text{ の項は } D_{kj} = 0).
\end{aligned}`,
      ),
      paragraph([
        "よって対角行列どうしの積は対角行列で、対角成分は成分ごとの積である。ゆえに ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について帰納法により ",
        math(String.raw`D^p`),
        " は対角行列で ",
        math(String.raw`(D^p)_{kk} = d_k^{\,p}`),
        "（",
        math(String.raw`p = 0`),
        " のときは ",
        math(String.raw`D^0 = I`),
        " で ",
        math(String.raw`d_k^0 = 1`),
        "）。",
      ]),
      paragraph([
        "中間目標: 指数級数の部分和。",
        ref("def_exp"),
        " の部分和 ",
        math(String.raw`E_K := \sum_{p=0}^{K}\frac{1}{p!}D^p`),
        " は、有限個の対角行列の線型結合なので対角行列で、成分は次のとおりである。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(E_K)_{kk}
&= \sum_{p=0}^{K}\frac{1}{p!}(D^p)_{kk}
   \quad (\because \text{行列の和とスカラー倍は成分ごと}) \\
&= \sum_{p=0}^{K}\frac{d_k^{\,p}}{p!}
   \quad (\because \text{対角行列の冪の成分 } (D^p)_{kk} = d_k^{\,p}), \\
(E_K)_{kl}
&= \sum_{p=0}^{K}\frac{1}{p!}(D^p)_{kl}
   \quad (\because \text{行列の和とスカラー倍は成分ごと}) \\
&= 0
   \quad (\because \text{対角行列の冪は対角行列なので } k \neq l \text{ では } (D^p)_{kl} = 0).
\end{aligned}`,
      ),
      paragraph([
        "中間目標: 極限。",
        ref("exp_converges"),
        " より ",
        math(String.raw`E_K \to \exp(D)`),
        "（",
        ref("def_matrix_norm"),
        " のノルムについて）。任意の ",
        math(String.raw`(k,l)`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(E_K)_{kl} - \exp(D)_{kl}\right|
&= \left|\bigl(E_K - \exp(D)\bigr)_{kl}\right|
   \quad (\because \text{行列の差は成分ごと}) \\
&\leq \|E_K - \exp(D)\|
   \quad (\because \|A\| = \sqrt{\textstyle\sum_{k,l}|A_{kl}|^2}\text{ の非負実数の有限和の 1 項}) \\
&\to 0
   \quad (\because E_K \to \exp(D)).
\end{aligned}`,
      ),
      paragraph([
        "すなわち成分ごとに収束する。",
        math(String.raw`k \neq l`),
        " では左側が常に ",
        math(String.raw`0`),
        " なので ",
        math(String.raw`\exp(D)_{kl} = 0`),
        "。",
        math(String.raw`k = l`),
        " では ",
        ref("real_exp_series_converges"),
        "（複素数の場合も同じ級数）より ",
        math(String.raw`\sum_{p=0}^{K} d_k^{\,p}/p! \to \exp(d_k)`),
        " なので ",
        math(String.raw`\exp(D)_{kk} = \exp(d_k)`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。分配関数の転送行列の章から転送行列の章へ移した。Step 1〜3 の番号を中間目標の名前（対角行列の積と冪・指数級数の部分和・極限）へ変えた。",
      ],
    },
  },

  {
    id: "transfer_matrix_000h2_definition_arccosh",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "逆双曲線余弦" },
    labels: ["def_arccosh"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        " が ",
        math(String.raw`y \ge 1`),
        " を満たすとき、",
      ]),
      displayMath(
        String.raw`\mathrm{arccosh}(y) := \log\!\left(y + \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}\right) \in \mathbb{R}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        ref("definition_of_sqrt_r_positive"),
        "、",
        math(String.raw`\log`),
        " は ",
        ref("def_real_logarithm_positive"),
        " である。右辺が定まることは次による。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
y \ge 1
&\Longrightarrow y^2 - 1 \ge 0
   &&(\because\ y \ge 1 > 0 \text{ より } y^2 \ge 1) \\
y \ge 1 \ \land\ \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \ge 0
&\Longrightarrow y + \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \ge 1 > 0
   &&(\because\ \text{実数の順序と加法})
\end{aligned}`,
      ),
      paragraph([
        "すなわち平方根の中身は非負であり、",
        math(String.raw`\log`),
        " の引数は正である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "それまで本文は arccosh を「cosh|_[0,∞) の逆写像」と呼ぶだけで定義を置いていなかった。逆写像として定義すると cosh|_[0,∞) が [1,∞) への全単射であることを先に示す必要があるので、log と非負平方根による式で定義し、逆写像であることを arccosh_properties で示す形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_000h3_claim_arccosh_properties",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "逆双曲線余弦は非負側の双曲線余弦の逆" },
    labels: ["arccosh_properties"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        "、",
        math(String.raw`y \ge 1`),
        " とする。",
        ref("def_arccosh"),
        " の ",
        math(String.raw`\mathrm{arccosh}`),
        " と ",
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`\cosh`),
        " について次が成り立つ。",
      ]),
      list([
        ["(1) ", math(String.raw`\mathrm{arccosh}(y) \ge 0`), "。"],
        ["(2) ", math(String.raw`\cosh\!\left(\mathrm{arccosh}(y)\right) = y`), "。"],
        [
          "(3) ",
          math(String.raw`t \in \mathbb{R}`),
          " が ",
          math(String.raw`t \ge 0`),
          " かつ ",
          math(String.raw`\cosh t = y`),
          " を満たすなら ",
          math(String.raw`t = \mathrm{arccosh}(y)`),
          "。",
        ],
        ["(4) ", math(String.raw`\mathrm{arccosh}(1) = 0`), "。"],
      ]),
    ],
    proof: [
      paragraph([
        "証明の中だけの記号として ",
        math(String.raw`r := \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}`),
        "、",
        math(String.raw`u := \mathrm{arccosh}(y) = \log(y + r)`),
        " とおく。",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`r \ge 0`),
        " かつ ",
        math(String.raw`r^2 = y^2 - 1`),
        "、",
        ref("def_arccosh"),
        " より ",
        math(String.raw`y + r \ge 1`),
        " である。また ",
        ref("def_real_logarithm_positive"),
        " の証明で示した ",
        math(String.raw`\log 1 = 0`),
        " を使う。",
      ]),
      paragraph(["(1) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(y)
&= \log(y + r)
   &&(\because\ \blkref{def_arccosh}) \\
&\ge \log 1
   &&(\because\ y + r \ge 1 \text{ と } \log \text{ の単調性。}\blkref{def_real_logarithm_positive}) \\
&= 0
   &&(\because\ \log 1 = 0)
\end{aligned}`,
      ),
      paragraph(["(2) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(u)
&= y + r
   &&(\because\ u = \log(y+r) \text{ と } \exp(\log z) = z\ \blkref{def_real_logarithm_positive})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
y^2 - r^2
&= y^2 - (y^2 - 1)
   &&(\because\ r^2 = y^2 - 1) \\
&= 1
   &&(\because\ \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(-u)
&= \exp(-u)\,(y^2 - r^2)
   &&(\because\ y^2 - r^2 = 1) \\
&= \exp(-u)\,(y + r)(y - r)
   &&(\because\ \text{和と差の積}) \\
&= \exp(-u)\exp(u)\,(y - r)
   &&(\because\ \exp(u) = y + r) \\
&= \exp(0)\,(y - r)
   &&(\because\ \blkref{scalar_exp_product}) \\
&= y - r
   &&(\because\ \blkref{scalar_exp_zero})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh(u)
&= \frac{\exp(u) + \exp(-u)}{2}
   &&(\because\ \blkref{def_cosh_sinh}) \\
&= \frac{(y + r) + (y - r)}{2}
   &&(\because\ \text{上の 2 式}) \\
&= y
   &&(\because\ \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "(3) の証明。",
        math(String.raw`t \ge 0`),
        " なら ",
        math(String.raw`\sinh t \ge 0`),
        " である（",
        math(String.raw`t > 0`),
        " なら ",
        ref("cosh_sinh_basic_properties"),
        " (3)、",
        math(String.raw`t = 0`),
        " なら ",
        math(String.raw`\sinh 0 = (\exp(0) - \exp(0))/2 = 0`),
        "）。さらに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\sinh t)^2
&= (\cosh t)^2 - 1
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (2)}) \\
&= y^2 - 1
   &&(\because\ \cosh t = y)
\end{aligned}`,
      ),
      paragraph([
        "なので、",
        ref("sqrt_nonnegative_existence_uniqueness"),
        " の一意性より ",
        math(String.raw`\sinh t = r`),
        "。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
t
&= \log(\exp(t))
   &&(\because\ \blkref{def_real_logarithm_positive}) \\
&= \log(\cosh t + \sinh t)
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (1)}) \\
&= \log(y + r)
   &&(\because\ \cosh t = y,\ \sinh t = r) \\
&= \mathrm{arccosh}(y)
   &&(\because\ \blkref{def_arccosh})
\end{aligned}`,
      ),
      paragraph(["(4) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(1)
&= \log\!\left(1 + \sqrt{1^2-1}^{(\mathbb{R}_{\ge 0})}\right)
   &&(\because\ \blkref{def_arccosh}) \\
&= \log(1 + 0)
   &&(\because\ 1^2 - 1 = 0 \text{ と } \sqrt{0}^{(\mathbb{R}_{\ge 0})} = 0) \\
&= \log 1
   &&(\because\ 1 + 0 = 1) \\
&= 0
   &&(\because\ \log 1 = 0)
\end{aligned}`,
      ),
    ],
    conversion: { status: "added", notes: ["arccosh を式で定義したことに伴い、本文が使っている性質（非負・cosh との合成・非負側での一意性・arccosh(1)=0）を主張として置いた。"] },
  },
  {
    id: "transfer_matrix_002_claim_Z_Y_linearly_independent",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ", ordinal: 2 },
    title: { tex: String.raw`Z_m, Y_m \text{ は線型独立}` },
    labels: ["Z_Y_linearly_independent"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_jordan_wigner_Z_matrices"),
        " の ",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}}`),
        " と ",
        ref("def_jordan_wigner_Y_matrices"),
        " の ",
        math(String.raw`Y_1,\dots,Y_{M_{\mathrm{col}}}`),
        " を ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元として考える。",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を ",
        math(String.raw`\mathbb{C}`),
        "-線型空間とみなすとき、",
      ]),
      displayMath(
        String.raw`\{Z_1, \dots, Z_{M_{\mathrm{col}}}, Y_1, \dots, Y_{M_{\mathrm{col}}}\} \text{ は線型独立}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\alpha_1,\dots,\alpha_{M_{\mathrm{col}}},\beta_1,\dots,\beta_{M_{\mathrm{col}}} \in \mathbb{C}`),
        " が ",
        math(String.raw`\sum_{m=1}^{M_{\mathrm{col}}}\alpha_m Z_m+\sum_{m=1}^{M_{\mathrm{col}}}\beta_m Y_m=0`),
        " を満たすならば、すべての ",
        math(String.raw`m`),
        " について ",
        math(String.raw`\alpha_m=\beta_m=0`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z\in\mathrm{Mat}(2,\mathbb{C})`),
        " を標準的な Pauli 行列",
      ]),
      displayMath(
        String.raw`\sigma^x=\begin{pmatrix}0&1\\1&0\end{pmatrix},\quad
\sigma^y=\begin{pmatrix}0&-i\\i&0\end{pmatrix},\quad
\sigma^z=\begin{pmatrix}1&0\\0&-1\end{pmatrix},\quad
I:=I_{\mathrm{Mat}(2,\mathbb{C})}=\begin{pmatrix}1&0\\0&1\end{pmatrix}`,
      ),
      paragraph([
        "とする。",
        ref("def_site_pauli_matrices"),
        " のとおり ",
        math(String.raw`\sigma_k^a`),
        "（",
        math(String.raw`a\in\{x,y,z\}`),
        "）は第 ",
        math(String.raw`k`),
        " 番目の因子（サイト）のみが ",
        math(String.raw`\sigma^a`),
        " で他の因子がすべて ",
        math(String.raw`I`),
        " である元である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\mathcal{B}:=\{I,\sigma^x,\sigma^y,\sigma^z\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底である。任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}\in\mathrm{Mat}(2,\mathbb{C})`),
        " に対して",
      ]),
      displayMath(
        String.raw`A=\frac{a_{11}+a_{22}}{2}I
+\frac{a_{12}+a_{21}}{2}\sigma^x
+\frac{i(a_{12}-a_{21})}{2}\sigma^y
+\frac{a_{11}-a_{22}}{2}\sigma^z
\quad (\because \text{成分比較})`,
      ),
      paragraph([
        "が成り立つ。右辺の 4 つの成分を 1 つずつ計算すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\frac{a_{11}+a_{22}}{2}I
+\frac{a_{12}+a_{21}}{2}\sigma^x
+\frac{i(a_{12}-a_{21})}{2}\sigma^y
+\frac{a_{11}-a_{22}}{2}\sigma^z\right)_{11}
&=\frac{a_{11}+a_{22}}{2}\cdot 1+\frac{a_{11}-a_{22}}{2}\cdot 1
&&(\because\ I_{11}=\sigma^z_{11}=1,\ \sigma^x_{11}=\sigma^y_{11}=0)\\
&=\frac{a_{11}+a_{22}}{2}+\frac{a_{11}-a_{22}}{2}
&&(\because\ \text{1 を掛けても変わらない})\\
&=\frac{2a_{11}}{2}
&&(\because\ \text{同分母の和})\\
&=a_{11}
&&(\because\ \text{約分})
\end{aligned}`),
      paragraph([
        "であり、同じ計算を残りの 3 つの成分について行うと、",
      ]),
      displayMath(String.raw`\begin{aligned}
(\cdots)_{22}
&=\frac{a_{11}+a_{22}}{2}\cdot 1+\frac{a_{11}-a_{22}}{2}\cdot(-1)
&&(\because\ I_{22}=1,\ \sigma^z_{22}=-1,\ \sigma^x_{22}=\sigma^y_{22}=0)\\
&=\frac{a_{11}+a_{22}}{2}-\frac{a_{11}-a_{22}}{2}
&&(\because\ (-1)\ \text{を掛けることは符号を変えること})\\
&=\frac{2a_{22}}{2}
&&(\because\ \text{同分母の差})\\
&=a_{22}
&&(\because\ \text{約分})\\[1ex]
(\cdots)_{12}
&=\frac{a_{12}+a_{21}}{2}\cdot 1+\frac{i(a_{12}-a_{21})}{2}\cdot(-i)
&&(\because\ \sigma^x_{12}=1,\ \sigma^y_{12}=-i,\ I_{12}=\sigma^z_{12}=0)\\
&=\frac{a_{12}+a_{21}}{2}+\frac{a_{12}-a_{21}}{2}
&&(\because\ i\cdot(-i)=1)\\
&=\frac{2a_{12}}{2}
&&(\because\ \text{同分母の和})\\
&=a_{12}
&&(\because\ \text{約分})\\[1ex]
(\cdots)_{21}
&=\frac{a_{12}+a_{21}}{2}\cdot 1+\frac{i(a_{12}-a_{21})}{2}\cdot i
&&(\because\ \sigma^x_{21}=1,\ \sigma^y_{21}=i,\ I_{21}=\sigma^z_{21}=0)\\
&=\frac{a_{12}+a_{21}}{2}-\frac{a_{12}-a_{21}}{2}
&&(\because\ i\cdot i=-1)\\
&=\frac{2a_{21}}{2}
&&(\because\ \text{同分母の差})\\
&=a_{21}
&&(\because\ \text{約分})
\end{aligned}`),
      paragraph([
        "となる（",
        math(String.raw`(\cdots)`),
        " は上と同じ右辺の行列である）。よって ",
        math(String.raw`\mathcal{B}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " を張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{B}`),
        " であるから ",
        math(String.raw`\mathcal{B}`),
        " は基底である。以下",
      ]),
      displayMath(
        String.raw`e_1:=I,\quad e_2:=\sigma^x,\quad e_3:=\sigma^y,\quad e_4:=\sigma^z`,
      ),
      paragraph(["と番号を付ける。"]),
      paragraph([
        "Step 2: クロネッカー積がつくる基底。",
        ref("tensor_basis"),
        " (2) を基底 ",
        math(String.raw`\mathcal{B}=\{e_1,e_2,e_3,e_4\}`),
        " に適用すると、多重添字 ",
        math(String.raw`(i_1,\dots,i_{M_{\mathrm{col}}})\in\{1,2,3,4\}^{M_{\mathrm{col}}}`),
        " で添字づけられた族",
      ]),
      displayMath(
        String.raw`\mathcal{E}:=\left\{\,e_{i_1}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}
\;\middle|\;(i_1,\dots,i_{M_{\mathrm{col}}})\in\{1,2,3,4\}^{M_{\mathrm{col}}}\,\right\}`,
      ),
      paragraph([
        "は ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-基底である。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`Z_m,Y_m`),
        " のクロネッカー積による表示。まず ",
        math(String.raw`1\le r\le M_{\mathrm{col}}`),
        " と ",
        math(String.raw`a_1,\dots,a_r\in\{x,y,z\}`),
        " について",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_r^{a_r}
= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}`,
      ),
      paragraph([
        "が成り立つことを ",
        math(String.raw`r`),
        " に関する帰納法で示す。",
        math(String.raw`r=1`),
        " のときは ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_1^{a_1}`),
        " の定義そのものである。",
        math(String.raw`r`),
        " で成り立つとすると、クロネッカー積の積が各サイトごとの積であること（",
        ref("kronecker_product_rule"),
        " (1)）",
      ]),
      displayMath(
        String.raw`(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}})(B_1\boxtimes\cdots\boxtimes B_{M_{\mathrm{col}}})
= (A_1B_1)\boxtimes\cdots\boxtimes(A_{M_{\mathrm{col}}}B_{M_{\mathrm{col}}})`,
      ),
      paragraph(["と ", math(String.raw`AI=IA=A`), " より、"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^{a_1}\cdots\sigma_r^{a_r}\sigma_{r+1}^{a_{r+1}}
&= \left(\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes I\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(I\boxtimes\cdots\boxtimes I\boxtimes\overbrace{\sigma^{a_{r+1}}}^{(r+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because\ \text{帰納法の仮定}) \\
&= (\sigma^{a_1}I)\boxtimes\cdots\boxtimes(\sigma^{a_r}I)\boxtimes(I\sigma^{a_{r+1}})\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&&(\because\ \text{クロネッカー積の積の規則}) \\
&= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes\sigma^{a_{r+1}}\boxtimes
   \overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-(r+1)}
&&(\because\ AI=IA=A)
\end{aligned}`,
      ),
      paragraph([
        ref("def_jordan_wigner_Z_matrices"),
        " の ",
        math(String.raw`Z_m=\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        " と、",
        ref("def_jordan_wigner_Y_matrices"),
        " の ",
        math(String.raw`Y_m=\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        " にこれを適用すると（",
        math(String.raw`m=1`),
        " のときは前半の積が空積で ",
        math(String.raw`Z_1=\sigma_1^z`),
        "、",
        math(String.raw`Y_1=\sigma_1^y`),
        " であり、下の式で ",
        math(String.raw`\sigma^x`),
        " の個数を ",
        math(String.raw`0`),
        " とすればよい）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^z}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ \text{Step 3 の帰納法と }Z_m\text{ の定義}) \\
Y_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^y}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ \text{Step 3 の帰納法と }Y_m\text{ の定義 }\blkref{def_jordan_wigner_Y_matrices})
\end{aligned}`,
      ),
      paragraph([
        "Step 4: 対応する多重添字。Step 1 の番号付け ",
        math(String.raw`e_1=I,\ e_2=\sigma^x,\ e_3=\sigma^y,\ e_4=\sigma^z`),
        " のもとで、Step 3 の表示は ",
        math(String.raw`Z_m,Y_m`),
        " がそれぞれ多重添字",
      ]),
      displayMath(
        String.raw`\zeta(m)_k:=\begin{cases}2 & (k<m)\\ 4 & (k=m)\\ 1 & (k>m)\end{cases}
\qquad
\eta(m)_k:=\begin{cases}2 & (k<m)\\ 3 & (k=m)\\ 1 & (k>m)\end{cases}`,
      ),
      paragraph([
        "に対応する ",
        math(String.raw`\mathcal{E}`),
        " の元であることを意味する。すなわち ",
        math(String.raw`Z_m=e_{\zeta(m)_1}\boxtimes\cdots\boxtimes e_{\zeta(m)_{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`Y_m=e_{\eta(m)_1}\boxtimes\cdots\boxtimes e_{\eta(m)_{M_{\mathrm{col}}}}`),
        "。",
      ]),
      paragraph([
        "Step 5: これら ",
        math(String.raw`2M_{\mathrm{col}}`),
        " 個の多重添字は相異なる。",
        math(String.raw`m,m'\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について次のように場合分けする。",
      ]),
      list([
        [
          math(String.raw`\zeta(m)`),
          " と ",
          math(String.raw`\zeta(m')`),
          "（",
          math(String.raw`m<m'`),
          "）: 第 ",
          math(String.raw`m`),
          " 成分は ",
          math(String.raw`\zeta(m)_m=4`),
          "、",
          math(String.raw`\zeta(m')_m=2`),
          "（",
          math(String.raw`m<m'`),
          " より）であり相異なる。",
        ],
        [
          math(String.raw`\eta(m)`),
          " と ",
          math(String.raw`\eta(m')`),
          "（",
          math(String.raw`m<m'`),
          "）: 第 ",
          math(String.raw`m`),
          " 成分は ",
          math(String.raw`\eta(m)_m=3`),
          "、",
          math(String.raw`\eta(m')_m=2`),
          " であり相異なる。",
        ],
        [
          math(String.raw`\zeta(m)`),
          " と ",
          math(String.raw`\eta(m')`),
          " で ",
          math(String.raw`m=m'`),
          " のとき: 第 ",
          math(String.raw`m`),
          " 成分は ",
          math(String.raw`4`),
          " と ",
          math(String.raw`3`),
          " で相異なる。",
        ],
        [
          math(String.raw`\zeta(m)`),
          " と ",
          math(String.raw`\eta(m')`),
          " で ",
          math(String.raw`m<m'`),
          " のとき: 第 ",
          math(String.raw`m`),
          " 成分は ",
          math(String.raw`4`),
          " と ",
          math(String.raw`2`),
          " で相異なる。",
        ],
        [
          math(String.raw`\zeta(m)`),
          " と ",
          math(String.raw`\eta(m')`),
          " で ",
          math(String.raw`m>m'`),
          " のとき: 第 ",
          math(String.raw`m'`),
          " 成分は ",
          math(String.raw`\zeta(m)_{m'}=2`),
          "（",
          math(String.raw`m'<m`),
          " より）と ",
          math(String.raw`\eta(m')_{m'}=3`),
          " で相異なる。",
        ],
      ]),
      paragraph([
        "以上より ",
        math(String.raw`\zeta(1),\dots,\zeta(M_{\mathrm{col}}),\eta(1),\dots,\eta(M_{\mathrm{col}})`),
        " は相異なる ",
        math(String.raw`2M_{\mathrm{col}}`),
        " 個の多重添字であり、対応する ",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}}`),
        " は基底 ",
        math(String.raw`\mathcal{E}`),
        " の相異なる ",
        math(String.raw`2M_{\mathrm{col}}`),
        " 個の元である。",
      ]),
      paragraph([
        "Step 6: 結論。",
        math(String.raw`\alpha_1,\dots,\alpha_{M_{\mathrm{col}}},\beta_1,\dots,\beta_{M_{\mathrm{col}}}\in\mathbb{C}`),
        " が",
      ]),
      displayMath(
        String.raw`\sum_{m=1}^{M_{\mathrm{col}}}\alpha_m Z_m+\sum_{m=1}^{M_{\mathrm{col}}}\beta_m Y_m=0`,
      ),
      paragraph([
        "を満たすとする。Step 5 より左辺は基底 ",
        math(String.raw`\mathcal{E}`),
        " の相異なる元の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合であり、",
        math(String.raw`\mathcal{E}`),
        " のそれ以外の元の係数は ",
        math(String.raw`0`),
        " である。基底による表示は一意（特に ",
        math(String.raw`0`),
        " の表示はすべての係数が ",
        math(String.raw`0`),
        "）であるから、",
      ]),
      displayMath(
        String.raw`\alpha_1=\cdots=\alpha_{M_{\mathrm{col}}}=\beta_1=\cdots=\beta_{M_{\mathrm{col}}}=0`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\{Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}}\}`),
        " は線型独立である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO: 証明略」のみ。ここで証明を与えた。",
        "原文の statement は式のみで、どの体上・どの空間での線型独立かが書かれていなかったため、" +
          "Mat(2,C)^{⊗M} を C-線型空間とみなしたときの線型独立性であることを statement に明示した" +
          "（主張の内容自体は変えていない）。",
        "記号の定義（labels: def_transfer_matrix_symbols）は sigma^x, sigma^y, sigma^z を" +
          "定義せずに sigma_k^x 等を導入している。本証明では標準的な Pauli 行列として明示した" +
          "（Z_Y_generate_algebra の証明も同じ扱いをしている）。",
        "2026-09-02 の式変形統一で、Step 3 の二本の鎖に行中の \\quad (\\because …) で置かれていた根拠 5 行を、" +
          "他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠は変えていない。",
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
  {
    id: "transfer_matrix_004_claim_even_eigenspace_is_complex_subspace",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { tex: String.raw`\mathcal{F}^{(+)}\text{ の複素部分線型空間性}` },
    labels: ["even_eigenspace_is_complex_subspace"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}\subseteq\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " を考える。この集合は零ベクトルを含み、複素数ベクトルの和と複素スカラー倍について閉じる。すなわち、",
      ]),
      displayMath(String.raw`0\in\mathcal{F}^{(+)}`),
      paragraph(["であり、任意の ", math(String.raw`f,g\in\mathcal{F}^{(+)}`), " と ", math(String.raw`a\in\mathbb{C}`), " に対して、"]),
      displayMath(String.raw`f+g\in\mathcal{F}^{(+)},\qquad af\in\mathcal{F}^{(+)}`),
      paragraph(["が成り立つ。したがって ", math(String.raw`\mathcal{F}^{(+)}`), " は ", math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`), " の複素部分線型空間である。"]),
    ],
    proof: [
      paragraph([
        ref("mat_mult"),
        " の行列と数ベクトルの積、および ",
        ref("complex_numbers_form_a_field"),
        " の複素数の演算法則を用いる。複素数ベクトルの演算は成分ごとに定め、任意の ",
        math(String.raw`u,v\in\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`a\in\mathbb{C}`),
        "、",
        math(String.raw`r\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " に対して ",
        math(String.raw`[u+v]_r:=u_r+v_r`),
        " および ",
        math(String.raw`[au]_r:=au_r`),
        " とする。まず零ベクトルを考える。任意の ",
        math(String.raw`r\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
[\varepsilon 0]_r
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}0
&&\left(\because\ \blkref{mat_mult}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}0
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の零倍}\right)\\
&=0
&&\left(\because\ \text{有限個の零の和}\right).
\end{aligned}`),
      paragraph([
        "全ての成分が一致するので ",
        math(String.raw`\varepsilon 0=0`),
        " である。よって ",
        ref("def_even_eigenvectors_of_epsilon"),
        " から ",
        math(String.raw`0\in\mathcal{F}^{(+)}`),
        " である。",
      ]),
      paragraph([
        "次に ",
        math(String.raw`f,g\in\mathcal{F}^{(+)}`),
        " とする。",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon f=f`),
        " かつ ",
        math(String.raw`\varepsilon g=g`),
        " である。任意の ",
        math(String.raw`r\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
[\varepsilon(f+g)]_r
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}(f_s+g_s)
&&\left(\because\ \blkref{mat_mult}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}(\varepsilon_{rs}f_s+\varepsilon_{rs}g_s)
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の分配律}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}f_s+\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}g_s
&&\left(\because\ \text{有限和を項ごとに分ける}\right)\\
&=[\varepsilon f]_r+[\varepsilon g]_r
&&\left(\because\ \blkref{mat_mult}\right)\\
&=f_r+g_r
&&\left(\because\ \varepsilon f=f\ \text{かつ}\ \varepsilon g=g\right)\\
&=[f+g]_r
&&\left(\because\ \text{複素数ベクトルの和の定義}\right).
\end{aligned}`),
      paragraph([
        "全ての成分が一致するので ",
        math(String.raw`\varepsilon(f+g)=f+g`),
        " である。よって ",
        ref("def_even_eigenvectors_of_epsilon"),
        " から ",
        math(String.raw`f+g\in\mathcal{F}^{(+)}`),
        " である。",
      ]),
      paragraph([
        "最後に ",
        math(String.raw`a\in\mathbb{C}`),
        " と ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " を取る。",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon f=f`),
        " である。任意の ",
        math(String.raw`r\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
[\varepsilon(af)]_r
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}(af_s)
&&\left(\because\ \blkref{mat_mult}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}(\varepsilon_{rs}a)f_s
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}(a\varepsilon_{rs})f_s
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の可換律}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}a(\varepsilon_{rs}f_s)
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律}\right)\\
&=a\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}f_s
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の分配律を有限回適用}\right)\\
&=a[\varepsilon f]_r
&&\left(\because\ \blkref{mat_mult}\right)\\
&=af_r
&&\left(\because\ \varepsilon f=f\right)\\
&=[af]_r
&&\left(\because\ \text{複素数ベクトルのスカラー倍の定義}\right).
\end{aligned}`),
      paragraph([
        "全ての成分が一致するので ",
        math(String.raw`\varepsilon(af)=af`),
        " である。よって ",
        ref("def_even_eigenvectors_of_epsilon"),
        " から ",
        math(String.raw`af\in\mathcal{F}^{(+)}`),
        " である。零ベクトル・和・複素スカラー倍についての三つの結果から、主張を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "二つの部分空間性を束ねていた後続ブロックから、F^{(+)} の複素部分線型空間性だけを分離した。",
        "抽象線型写像 end(ε) を経由せず、通常の行列と数ベクトルの積を成分ごとに展開した。F^{(-)} の部分空間性は後続ブロックに残す。",
      ],
    },
  },
  {
    id: "transfer_matrix_004_definition_eigenspaces_of_epsilon",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/003_definition_epsilonの固有空間.typ", ordinal: 4 },
    title: { tex: String.raw`\varepsilon\text{ の固有値 }+1\text{ の固有ベクトル集合は複素部分線型空間である}` },
    labels: ["def_eigenspaces_of_epsilon"],
    statement: [
      paragraph([
        ref("def_even_eigenvectors_of_epsilon"),
        " で定めた ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " は ",
        math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-部分線型空間である（",
        math(String.raw`\because`),
        " ",
        ref("even_eigenspace_is_complex_subspace"),
        "）。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "二つの部分空間性をそれぞれ独立ブロックへ分離し、このブロックは後続参照のための統合結果として保持する。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_004c_claim_epsilon_action_eigenvalues",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { tex: String.raw`\varepsilon\text{ の行列作用の固有値候補}` },
    labels: ["epsilon_action_eigenvalues_are_signs"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を考える。非零ベクトル ",
        math(String.raw`f\in\mathbb{C}^{2^{M_{\mathrm{col}}}}\setminus\{0\}`),
        " と複素数 ",
        math(String.raw`\lambda\in\mathbb{C}`),
        " が ",
        math(String.raw`\varepsilon f=\lambda f`),
        " を満たすなら、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`1`),
        " または ",
        math(String.raw`-1`),
        " に限る。",
      ]),
    ],
    proof: [
      paragraph([
        ref("epsilon_square_identity"),
        "、行列と数ベクトルの積の結合則 ",
        ref("mat_mult"),
        "、および複素数の体の法則 ",
        ref("complex_numbers_form_a_field"),
        " を用いる。まず、この証明で使う行列作用の結合則を成分から確かめる。任意の ",
        math(String.raw`A,B\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        math(String.raw`g\in\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`i\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
((AB)g)_i
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}(AB)_{ik}g_k
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\left(\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}A_{i\ell}B_{\ell k}\right)g_k
&&(\because\ \blkref{mat_mult}\ \text{の行列積の成分の定義})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}(A_{i\ell}B_{\ell k})g_k
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を有限回適用})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}A_{i\ell}(B_{\ell k}g_k)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&=\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}\sum_{k=1}^{2^{M_{\mathrm{col}}}}A_{i\ell}(B_{\ell k}g_k)
&&(\because\ \text{有限二重和の順序交換})\\
&=\sum_{\ell=1}^{2^{M_{\mathrm{col}}}}A_{i\ell}\left(\sum_{k=1}^{2^{M_{\mathrm{col}}}}B_{\ell k}g_k\right)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を有限回適用})\\
&=(A(Bg))_i
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義}).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`(AB)g=A(Bg)`),
        " である。同様に、任意の ",
        math(String.raw`\mu\in\mathbb{C}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(A(\mu g))_i
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}A_{ik}(\mu g_k)
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}(A_{ik}\mu)g_k
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}(\mu A_{ik})g_k
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の交換律})\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\mu(A_{ik}g_k)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&=\mu\sum_{k=1}^{2^{M_{\mathrm{col}}}}A_{ik}g_k
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を有限回適用})\\
&=(\mu(Ag))_i
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義}).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`A(\mu g)=\mu(Ag)`),
        " である。また、単位行列の作用も成分から確かめると、任意の ",
        math(String.raw`i\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}f)_i
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}(I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})})_{ik}f_k
&&(\because\ \blkref{mat_mult}\ \text{の数ベクトルへの作用の定義})\\
&=f_i
&&(\because\ \text{単位行列の成分と }\blkref{complex_numbers_form_a_field}\ \text{の }0,1\text{ の法則}).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}f=f`),
        " である。以上の三つの等式と仮定 ",
        math(String.raw`\varepsilon f=\lambda f`),
        " を二回適用すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
f
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}f
&&(\because\ \text{直前に成分ごとに示した単位行列の作用})\\
&=\varepsilon^2f
&&(\because\ \blkref{epsilon_square_identity})\\
&=\varepsilon(\varepsilon f)
&&(\because\ \blkref{mat_mult},\blkref{complex_numbers_form_a_field}\ \text{から直前に成分ごとに示した結合則})\\
&=\varepsilon(\lambda f)
&&(\because\ \varepsilon f=\lambda f)\\
&=\lambda(\varepsilon f)
&&(\because\ \blkref{mat_mult},\blkref{complex_numbers_form_a_field}\ \text{から直前に成分ごとに示した複素線型性})\\
&=\lambda(\lambda f)
&&(\because\ \varepsilon f=\lambda f)\\
&=(\lambda\lambda)f
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合則})\\
&=\lambda^2f
&&(\because\ \lambda^2=\lambda\lambda\ \text{という二乗の定義}).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`f\neq 0`),
        " だから、ある ",
        math(String.raw`j\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について ",
        math(String.raw`f_j\neq 0`),
        " である。等式 ",
        math(String.raw`f=\lambda^2f`),
        " の第 ",
        math(String.raw`j`),
        " 成分を比べると ",
        math(String.raw`f_j=\lambda^2f_j`),
        " だから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lambda^2f_j-f_j&=0
&&(\because\ f_j=\lambda^2f_j\ \text{の両辺から }f_j\text{ を引く})\\
(\lambda^2-1)f_j&=\lambda^2f_j-1f_j
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&=\lambda^2f_j-f_j
&&(\because\ 1f_j=f_j)\\
&=0
&&(\because\ \lambda^2f_j-f_j=0)\\
\lambda^2-1&=0
&&(\because\ f_j\neq0\ \text{と }\blkref{complex_numbers_form_a_field}\ \text{の零積則})\\
(\lambda-1)(\lambda+1)&=\lambda^2-1
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&=0
&&(\because\ \lambda^2-1=0)\\
\lambda-1=0\quad\text{または}\quad\lambda+1&=0
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零積則})\\
\lambda=1\quad\text{または}\quad\lambda&=-1
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: ["全スピン反転行列の二乗を入力に、通常の行列と数ベクトルの積だけで固有値候補を述べる独立主張へ分離した。"],
    },
  },
  {
    id: "transfer_matrix_008_definition_delta_M",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ", ordinal: 8 },
    title: { tex: String.raw`\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)} \text{ の定義}` },
    labels: ["def_delta_M"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{N}_{\geq 1}`),
        " とし、",
        math(String.raw`\mu,\nu \in \mathbb{Z}`),
        " とする。",
      ]),
      displayMath(
        String.raw`\delta^{M_{\mathrm{col}}} : \mathbb{Z}\times\mathbb{Z}\longrightarrow\mathbb{C},\qquad
\delta^{(M_{\mathrm{col}})}_{(\mu,\nu)} :=
\begin{cases}
1 & (\mu \equiv \nu \pmod{M_{\mathrm{col}}}) \\
0 & (\mu \not\equiv \nu \pmod{M_{\mathrm{col}}})
\end{cases}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-09-20: M を正の自然数、μ,ν を整数として明記し、δ^M の定義域と値域を ℤ×ℤ→ℂ とした。Lean の M : ℕ, M ≠ 0 および SageMath の正の M という検査範囲に仮定を同期した。合同条件は変えていない。",
      ],
    },
  },
  {
    id: "transfer_matrix_009_claim_exp_sum",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ", ordinal: 9 },
    title: null,
    labels: ["exp_sum"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{N}_{\geq 1}`),
        " とし、",
        math(String.raw`k \in \mathbb{Z}`),
        " について、",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j k}{M_{\mathrm{col}}}\right) = M_{\mathrm{col}}\,\delta^{(M_{\mathrm{col}})}_{(k,0)}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`k \equiv 0 \pmod{M_{\mathrm{col}}}`),
        " であるか否かで場合を分ける。",
      ]),
      paragraph([
        math(String.raw`(a)\; k \equiv 0 \pmod{M_{\mathrm{col}}}`),
        " のとき。",
        math(String.raw`k = lM_{\mathrm{col}}`),
        " を満たす ",
        math(String.raw`l \in \mathbb{Z}`),
        " を 1 つ取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j k}{M_{\mathrm{col}}}\right)
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j \cdot lM_{\mathrm{col}}}{M_{\mathrm{col}}}\right)
&&(\because\ k = lM_{\mathrm{col}}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(2\pi i\, l j\right)
&&(\because\ M_{\mathrm{col}}\geq1\ \text{より}\ M_{\mathrm{col}}\neq0\ \text{なので約分した}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \left(\cos 2\pi l j + i \sin 2\pi l j\right)
&&(\because\ \text{オイラーの公式}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} \left(1 + i \cdot 0\right)
&&(\because\ lj \in \mathbb{Z}\ \text{なので}\ \cos 2\pi lj = 1,\ \sin 2\pi lj = 0) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} 1
&&(\because\ 1 + i \cdot 0 = 1) \\
&= M_{\mathrm{col}}
&&(\because\ \text{項数が}\ M_{\mathrm{col}}\ \text{である}) \\
&= M_{\mathrm{col}}\,\delta^{(M_{\mathrm{col}})}_{(k,0)}
&&(\because\ k \equiv 0 \pmod{M_{\mathrm{col}}}\ \text{なので}\ \delta^{(M_{\mathrm{col}})}_{(k,0)} = 1\ \text{である})
\end{aligned}`,
      ),
      paragraph([
        "引いたのは ",
        ref("euler_formula_cos_sin"),
        " と ",
        ref("def_delta_M"),
        " である。",
      ]),
      paragraph([
        math(String.raw`(b)\; k \not\equiv 0 \pmod{M_{\mathrm{col}}}`),
        " のとき。",
        math(String.raw`r := \exp\!\left(\frac{2\pi i k}{M_{\mathrm{col}}}\right) \in \mathbb{C}`),
        " と置く。",
        math(String.raw`k \not\equiv 0 \pmod{M_{\mathrm{col}}}`),
        " なので ",
        math(String.raw`r \neq 1`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j k}{M_{\mathrm{col}}}\right)
&= \sum_{j=1}^{M_{\mathrm{col}}} r^{\,j}
&&(\because\ r\ \text{の定義と}\ \exp(a)^{j} = \exp(ja)) \\
&= r \cdot \frac{1 - r^{M_{\mathrm{col}}}}{1 - r}
&&(\because\ \text{等比数列の和の公式（}r \neq 1\text{）}) \\
&= r \cdot \frac{1 - \exp\!\left(2\pi i k\right)}{1 - r}
&&(\because\ r^{M_{\mathrm{col}}} = \exp\!\left(2\pi i k\right)) \\
&= r \cdot \frac{1 - 1}{1 - r}
&&(\because\ k \in \mathbb{Z}\ \text{なので}\ \exp(2\pi i k) = 1) \\
&= 0
&&(\because\ 1 - 1 = 0\ \text{であり、分子が}\ 0\ \text{の分数は}\ 0\ \text{である（}1 - r \neq 0\text{）}) \\
&= M_{\mathrm{col}}\,\delta^{(M_{\mathrm{col}})}_{(k,0)}
&&(\because\ k \not\equiv 0 \pmod{M_{\mathrm{col}}}\ \text{なので}\ \delta^{(M_{\mathrm{col}})}_{(k,0)} = 0\ \text{である})
\end{aligned}`,
      ),
      paragraph([
        "引いたのは ",
        ref("def_delta_M"),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-09-20: M を正の自然数として明記し、約分に使う M≠0 の根拠を補った。Lean の M : ℕ, hM : M ≠ 0 および SageMath の M = 1,...,12 という検査範囲に仮定を同期した。主張の数学的内容は変えていない。",
      ],
    },
  },
  {
    id: "transfer_matrix_015_claim_Z_Y_generate_algebra",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ", ordinal: 15 },
    title: {
      text: "Z, Y から和・スカラー倍・積だけで 2^M 次の複素行列がすべて得られる",
    },
    labels: ["Z_Y_generate_algebra"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        "（004 章冒頭の記号の定義）で定義された ",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}}, Y_1,\dots,Y_{M_{\mathrm{col}}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、集合 ",
        math(String.raw`S := \{Z_1,\dots,Z_{M_{\mathrm{col}}}, Y_1,\dots,Y_{M_{\mathrm{col}}}\}`),
        " を考える（",
        ref("def_kronecker"),
        " の同一視により ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " であり、",
        math(String.raw`S`),
        " の元はいずれも ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素行列である）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の部分集合 ",
        math(String.raw`T`),
        " が「閉じている」とは、次の 4 条件を満たすことをいう。",
      ]),
      list([
        [
          "(i) ",
          math(String.raw`S \subseteq T`),
          "、すなわち ",
          math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}} \in T`),
          "。",
        ],
        [
          "(ii) ",
          math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \in T`),
          "（単位行列を含む）。",
        ],
        [
          "(iii) ",
          math(String.raw`A, B \in T`),
          " ならば ",
          math(String.raw`A + B \in T`),
          "、および ",
          math(String.raw`c \in \mathbb{C}`),
          " について ",
          math(String.raw`cA \in T`),
          "（和とスカラー倍で閉じる）。",
        ],
        [
          "(iv) ",
          math(String.raw`A, B \in T`),
          " ならば ",
          math(String.raw`AB \in T`),
          "（行列の積で閉じる）。",
        ],
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " 自身は閉じているからそのような ",
        math(String.raw`T`),
        " は少なくとも 1 つ存在し、閉じている部分集合すべての共通部分もまた (i)〜(iv) を満たす",
        "（共通部分の元は各 ",
        math(String.raw`T`),
        " に属するので、和・スカラー倍・積も各 ",
        math(String.raw`T`),
        " に属し、したがって共通部分に属する）。よって、閉じている部分集合のうち最小のものが存在する。それを ",
        math(String.raw`\mathcal{A}`),
        " とおく。",
      ]),
      paragraph([
        "このとき ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " である。すなわち、",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}}`),
        " と単位行列から出発して、和・スカラー倍・行列の積を有限回繰り返すだけで ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素行列がすべて得られる。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\sigma^x, \sigma^y, \sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " を標準的な Pauli 行列 ",
        math(String.raw`\sigma^x=\begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^y=\begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^z=\begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " とする。",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " のとおり、第 ",
        math(String.raw`k`),
        " 番目の因子（サイト）のみが対応する Pauli 行列で、他の因子はすべて ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " であるものとする。",
      ]),
      paragraph(["Step 1: 単一サイトの Pauli 行列の積公式。"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^x
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix} \quad (\because \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix} \quad (\because \text{行列の積の成分計算}) \\
&= I_{\mathrm{Mat}(2,\mathbb{C})} \quad (\because \text{単位行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^z
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix} \quad (\because \sigma^y,\ \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}0&i\\i&0\end{pmatrix} \quad (\because \text{行列の積の成分計算}) \\
&= i\begin{pmatrix}0&1\\1&0\end{pmatrix} \quad (\because \text{スカラー倍の成分計算}) \\
&= i\,\sigma^x \quad (\because \sigma^x \text{ の定義})
\end{aligned}`,
      ),
      paragraph(["第 2 式から ", math(String.raw`\sigma^x`), " を書き直す。"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x
&= 1\cdot\sigma^x \quad (\because 1 \text{ は積の単位元}) \\
&= ((-i)\,i)\,\sigma^x \quad (\because (-i)\,i = 1) \\
&= -i\,(i\,\sigma^x) \quad (\because \text{スカラー倍の結合則}) \\
&= -i\,\sigma^y\sigma^z \quad (\because \text{第 2 式 } \sigma^y\sigma^z = i\,\sigma^x)
\end{aligned}`,
      ),
      paragraph([
        "これらをクロネッカー積へ持ち上げる。",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の積は各因子ごとの積であり ",
        math(String.raw`(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}})(B_1\boxtimes\cdots\boxtimes B_{M_{\mathrm{col}}}) = (A_1 B_1)\boxtimes\cdots\boxtimes(A_{M_{\mathrm{col}}} B_{M_{\mathrm{col}}})`),
        "（",
        ref("kronecker_product_rule"),
        " (1)）。第 ",
        math(String.raw`k`),
        " 因子のみが非自明な ",
        math(String.raw`\sigma_k^a`),
        " どうしの積は（",
        math(String.raw`I:=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_k^b
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{k\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \sigma_k^a,\ \sigma_k^b \text{ の定義の代入}) \\
&= (II)\boxtimes\cdots\boxtimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\boxtimes\cdots\boxtimes(II) \quad (\because \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\boxtimes\cdots\boxtimes I \quad (\because II=I)
\end{aligned}`,
      ),
      paragraph([
        "これより ",
        math(String.raw`\sigma_k^x\sigma_k^x = I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`\sigma_k^x = -i\,\sigma_k^y\sigma_k^z`),
        " を得る。また異なるサイト ",
        math(String.raw`k\neq l`),
        " の ",
        math(String.raw`\sigma_k^a, \sigma_l^b`),
        " は可換である（",
        math(String.raw`k<l`),
        " として）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_l^b
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \sigma_k^a,\ \sigma_l^b \text{ の定義の代入}) \\
&= I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I \quad (\because \text{クロネッカー積の積の規則}) \\
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \text{クロネッカー積の積の規則}) \\
&= \sigma_l^b \sigma_k^a \quad (\because \sigma_l^b, \sigma_k^a \text{ の定義（第 } l \text{ 因子・第 } k \text{ 因子のみが非自明）})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`\mathcal{A}`),
        " が各 ",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " を含むこと。各 ",
        math(String.raw`m`),
        " について「",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x \in \mathcal{A}`),
        "」を仮定とする ",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のとき ",
        math(String.raw`\sigma_1^z=Z_1\in\mathcal{A}`),
        "、",
        math(String.raw`\sigma_1^y=Y_1\in\mathcal{A}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^x
&= -i\,\sigma_1^y\sigma_1^z \quad (\because \text{Step 1 の } \sigma_k^x = -i\,\sigma_k^y\sigma_k^z \text{ を } k=1 \text{ に取る}) \\
&= -i\,Y_1 Z_1 \quad (\because \sigma_1^y = Y_1, \ \sigma_1^z = Z_1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_1, Z_1\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積とスカラー倍について閉じるから ",
        math(String.raw`\sigma_1^x\in\mathcal{A}`),
        "。",
      ]),
      paragraph([
        math(String.raw`m\geq 2`),
        " とし ",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x\in\mathcal{A}`),
        " を仮定する。",
        math(String.raw`P_{m-1}:=\sigma_1^x\sigma_2^x\cdots\sigma_{m-1}^x`),
        " とおくと ",
        math(String.raw`P_{m-1}\in\mathcal{A}`),
        "（",
        math(String.raw`m=1`),
        " では空積 ",
        math(String.raw`P_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "）。異サイトの可換性と ",
        math(String.raw`\sigma_k^x\sigma_k^x=I`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}P_{m-1}
&= (\sigma_1^x\cdots\sigma_{m-1}^x)(\sigma_1^x\cdots\sigma_{m-1}^x) \quad (\because P_{m-1} \text{ の定義}) \\
&= (\sigma_1^x\sigma_1^x)(\sigma_2^x\sigma_2^x)\cdots(\sigma_{m-1}^x\sigma_{m-1}^x) \quad (\because \text{異サイトの可換性}) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \quad (\because \sigma_k^x\sigma_k^x=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})})
\end{aligned}`,
      ),
      paragraph([
        "ゆえに ",
        math(String.raw`P_{m-1}`),
        " は可逆で ",
        math(String.raw`P_{m-1}^{-1}=P_{m-1}\in\mathcal{A}`),
        "。定義より ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z = P_{m-1}\sigma_m^z`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}Z_m
&= P_{m-1}P_{m-1}\sigma_m^z \quad (\because Z_m = P_{m-1}\sigma_m^z) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\sigma_m^z \quad (\because P_{m-1}P_{m-1}=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}) \\
&= \sigma_m^z \quad (\because I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \text{ は積の単位元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`P_{m-1}, Z_m\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`\sigma_m^z = P_{m-1}Z_m\in\mathcal{A}`),
        "。",
        math(String.raw`\sigma_m^y`),
        " についても同じ形の鎖が書ける。定義より ",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y = P_{m-1}\sigma_m^y`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}Y_m
&= P_{m-1}P_{m-1}\sigma_m^y \quad (\because Y_m = P_{m-1}\sigma_m^y) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\sigma_m^y \quad (\because P_{m-1}P_{m-1}=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}) \\
&= \sigma_m^y \quad (\because I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \text{ は積の単位元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`P_{m-1}, Y_m\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`\sigma_m^y = P_{m-1}Y_m\in\mathcal{A}`),
        "。さらに Step 1 より ",
        math(String.raw`\sigma_m^x = -i\,\sigma_m^y\sigma_m^z`),
        " であり、",
        math(String.raw`\mathcal{A}`),
        " は積とスカラー倍について閉じるから ",
        math(String.raw`\sigma_m^x\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\sigma_m^x,\sigma_m^y,\sigma_m^z\in\mathcal{A}`),
        " が示され、帰納法により すべての ",
        math(String.raw`k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\sigma_k^x,\sigma_k^y,\sigma_k^z\in\mathcal{A}`),
        "。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "。まず ",
        math(String.raw`\mathcal{B}:=\{I_{\mathrm{Mat}(2,\mathbb{C})}, \sigma^x, \sigma^y, \sigma^z\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 上の基底である。実際、任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}`),
        " に対し",
      ]),
      displayMath(
        String.raw`A = \frac{a_{11}+a_{22}}{2}I_{\mathrm{Mat}(2,\mathbb{C})} + \frac{a_{12}+a_{21}}{2}\sigma^x + \frac{i(a_{12}-a_{21})}{2}\sigma^y + \frac{a_{11}-a_{22}}{2}\sigma^z \quad (\because \text{成分比較})`,
      ),
      paragraph([
        " が成り立つので ",
        math(String.raw`\mathcal{B}`),
        " は張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{B}`),
        " より基底である。次に ",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}:=\{e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}}: e_1,\dots,e_{M_{\mathrm{col}}}\in\mathcal{B}\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の基底である（",
        ref("tensor_basis"),
        " (2) を基底 ",
        math(String.raw`\mathcal{B}`),
        " に適用した）。一方、各 ",
        math(String.raw`e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}}`),
        " について、各 ",
        math(String.raw`k`),
        " で ",
        math(String.raw`\sigma_k^{a_k}:=I\boxtimes\cdots\boxtimes\overbrace{e_k}^{k\text{th}}\boxtimes\cdots\boxtimes I`),
        " とおくと、Step 1 の異サイト積公式を繰り返して",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_{M_{\mathrm{col}}}^{a_{M_{\mathrm{col}}}} = e_1\boxtimes e_2\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}} \quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "Step 2 より各 ",
        math(String.raw`\sigma_k^{a_k}\in\mathcal{A}`),
        "（",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\in\mathcal{A}`),
        " も含む）であり、",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}} = \sigma_1^{a_1}\cdots\sigma_{M_{\mathrm{col}}}^{a_{M_{\mathrm{col}}}}\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}\subseteq\mathcal{A}`),
        "。",
        math(String.raw`\mathcal{A}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型結合について閉じ、",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}`),
        " は基底であるから",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) = \mathrm{span}_{\mathbb{C}}(\mathcal{B}^{\boxtimes M_{\mathrm{col}}}) \subseteq \mathcal{A} \quad (\because \mathcal{A} \text{ は } \mathbb{C}\text{-線型結合について閉じる})`,
      ),
      paragraph([
        "一方 ",
        math(String.raw`\mathcal{A}\subseteq\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は定義より明らかであるから ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "タイトルと statement にあった多元環の一般論の語彙（「環として生成する」「C 上の単位的結合多元環」" +
          "「S を含む最小の C-部分多元環」）を、「和・スカラー倍・積で閉じた最小の集合」という具体的な" +
          "言い換えへ直した（goal-alignment-audit の A-6。README 2 節「環・体などの一般論に持ち上げた証明」" +
          "を避けるため）。主張の内容と証明は変えていない。あわせて、最小の集合が存在すること" +
          "（閉じている部分集合の共通部分もまた閉じている）を明示した。",
      ],
    },
  },
]);
