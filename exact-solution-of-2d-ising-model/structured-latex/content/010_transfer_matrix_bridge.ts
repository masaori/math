import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/010_transfer_matrix_bridge.ts";

export default defineBlocks([
  {
    id: "heading_transfer_matrix_bridge",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "分配関数の転送行列とパウリ行列表示の同一視" },
    labels: [],
  },

  {
    id: "bridge_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的と記号の対応" },
    labels: [],
    statement: [
      paragraph([
        ref("def_transfer_matrix"),
        " は転送行列 ",
        math(String.raw`V_1, V_2`),
        " を**成分**で定義し、",
        ref("partition_function_via_transfer_matrix"),
        " は分配関数をそのトレースで表した。一方 ",
        ref("def_transfer_matrix_symbols"),
        " は同じ名前の ",
        math(String.raw`V_1, V_2`),
        " を**パウリ行列**で定義し、以降の章はすべてそちらを使っている。",
        "**両者が同じ行列であることは、これまで本文のどこでも示されていなかった。**",
        "この章でそれを示す。これが無いと、固有値をいくら求めても分配関数へ戻れない。",
      ]),
      paragraph([
        "まず記号を対応させる。",
        ref("def_partition_function_2d_ising"),
        " の格子は ",
        math(String.raw`\{1,\dots,M\}\times\{1,\dots,N\}`),
        " で、第 1 引数（添字 ",
        math(String.raw`i`),
        "）方向の結合定数が ",
        math(String.raw`J`),
        "、第 2 引数（添字 ",
        math(String.raw`j`),
        "）方向の結合定数が ",
        math(String.raw`J'`),
        " であった。",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,N\},\{-1,1\})`),
        " は**第 2 引数方向の 1 列ぶんの配置**であり、転送行列はこの長さ ",
        math(String.raw`N`),
        " の鎖の上に作用する。トレースの冪 ",
        math(String.raw`M`),
        " は転送の回数である。",
      ]),
      paragraph([
        "一方 ",
        ref("def_transfer_matrix_symbols"),
        " 以降の章では、鎖の長さが ",
        math(String.raw`M`),
        " と書かれている（",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        "、",
        math(String.raw`\sigma_1^z\sigma_2^z + \cdots + \sigma_M^z\sigma_1^z`),
        "）。すなわち **001 章の ",
        math(String.raw`N`),
        " と 004 章以降の ",
        math(String.raw`M`),
        " が同じもの**（鎖の長さ）であり、001 章の ",
        math(String.raw`M`),
        "（転送の回数）に対応する記号は 004 章以降には無い。",
      ]),
      paragraph([
        "この章では 004 章以降の記号系に合わせ、**鎖の長さを ",
        math(String.raw`M`),
        "、転送の回数を ",
        math(String.raw`N_{\mathrm{row}}`),
        " と書く**。すなわち ",
        ref("def_partition_function_2d_ising"),
        " と ",
        ref("def_transfer_matrix"),
        " の主張を引用するときは、そこでの ",
        math(String.raw`N`),
        " を ",
        math(String.raw`M`),
        " に、そこでの ",
        math(String.raw`M`),
        " を ",
        math(String.raw`N_{\mathrm{row}}`),
        " に読み替える。この読み替えは記号の付け替えだけであり、主張の内容は変えない。",
      ]),
      paragraph(["結合定数の対応は"]),
      displayMath(String.raw`K_1 = J', \qquad K_2 = J`),
      paragraph([
        "である。根拠は次のとおり。",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`V_1`),
        " の指数には ",
        math(String.raw`J'\,\mu(j)\mu(j+1)`),
        "、すなわち**同一の鎖の隣接サイトどうし**の積が現れる。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1 = \exp(K_1(\sigma_1^z\sigma_2^z+\cdots+\sigma_M^z\sigma_1^z))`),
        " も同一の鎖の隣接サイトどうしである。",
        math(String.raw`V_2`),
        " はどちらも**隣り合う 2 本の鎖の同じサイトどうし**（",
        math(String.raw`J\,\mu(j)\mu'(j)`),
        "）を結ぶ。役割が一致するのはこの組み合わせに限る。",
      ]),
      paragraph([
        "この章の結論は、",
        ref("V2_component_equals_pauli"),
        " までで 2 つの ",
        math(String.raw`V_1, V_2`),
        " が同一の行列だと分かり、",
        ref("partition_function_sector_decomposition"),
        " で",
      ]),
      displayMath(
        String.raw`Z(J, J')
= \mathrm{tr}\!\left(P^{(+)}\left(V^{(+)}\right)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}\left(V^{(-)}\right)^{N_{\mathrm{row}}}\right)`,
      ),
      paragraph([
        "が得られることである（",
        math(String.raw`V^{(\pm)} := (V_1^{(\pm)})^{1/2} V_2 (V_1^{(\pm)})^{1/2}`),
        " は ",
        ref("V_eq_Vprime"),
        " の ",
        math(String.raw`V`),
        "、",
        math(String.raw`P^{(\pm)}`),
        " は ",
        math(String.raw`\varepsilon`),
        " の固有空間への射影子）。右辺は ",
        ref("eigenvalues_of_V"),
        " で固有値が分かっているので、これで分配関数が固有値の言葉で書ける。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "M と N の役割の対応は、001 章の V_1 が同一の μ の隣接成分を結び、004 章の V_1 が同一鎖の隣接サイトを結ぶ、という一次情報から確定させた。数値でも Z の直接和と tr((V_1V_2)^{N_row}) が K_1 = J'、K_2 = J のときに一致することを確認済み（sagemath/check/043_claim_transfer_matrix_bridge/check_04_partition_function.sage）。",
      ],
    },
  },

  {
    id: "bridge_001_definition_config_basis",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
    title: { text: "スピン配置と標準基底の同一視" },
    labels: ["def_config_basis_iso"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,M\},\{-1,1\})`),
        " とする。ここでは、転送行列の定義で鎖の長さを表していた ",
        math(String.raw`N`),
        " を ",
        math(String.raw`M`),
        " と書き換えている。この記号の付け替え以外は、同じスピン配置の集合である。また、",
        ref("def_end_iso"),
        " の多重添字 ",
        math(String.raw`\mathcal{I} = \{1,2\}^M`),
        "・基底 ",
        math(String.raw`f_I = e_{i_1}\boxtimes\cdots\boxtimes e_{i_M} \in \mathcal{F} = \mathbb{C}^{2^M}`),
        " について、写像 ",
        math(String.raw`\iota : \mathfrak{M} \to \mathcal{I}`),
        " を",
      ]),
      displayMath(
        String.raw`\iota(\mu) := (i_1,\dots,i_M), \qquad
i_m := \begin{cases} 1 & (\mu(m) = +1) \\ 2 & (\mu(m) = -1) \end{cases}`,
      ),
      paragraph([
        "で定める。",
        math(String.raw`\{-1,1\} \to \{1,2\}`),
        " の対応 ",
        math(String.raw`+1\mapsto 1,\ -1\mapsto 2`),
        " は全単射なので、",
        math(String.raw`\iota`),
        " は全単射である（成分ごとに全単射だから）。",
      ]),
      paragraph([
        ref("def_transfer_matrix"),
        " は「行・列の番号 ",
        math(String.raw`\{1,\dots,2^M\}`),
        " と ",
        math(String.raw`\mathfrak{M}`),
        " の間の全単射をひとつ固定して同一視する。以下の議論は、この全単射の取り方に依らない」と述べていた。",
        "**以下ではその全単射として ",
        math(String.raw`\iota`),
        " を（および ",
        ref("def_end_iso"),
        " による ",
        math(String.raw`\mathcal{I}`),
        " と行・列番号の対応を）取る。**",
        "すなわち ",
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " の成分を",
      ]),
      displayMath(
        String.raw`(V_a)_{\mu,\mu'} := (V_a)_{\iota(\mu),\iota(\mu')} \qquad (a = 1, 2)`,
      ),
      paragraph([
        "と読む。取り方に依らないと述べられているので、この選択で一般性を失わない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },

  {
    id: "bridge_002_claim_sigma_z_diagonal_action",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { tex: String.raw`\sigma_m^z \text{ の基底 } f_{\iota(\mu)} \text{ への作用}` },
    labels: ["sigma_z_diagonal_action"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathfrak{M}`),
        "、",
        math(String.raw`m \in \{1,\dots,M\}`),
        " について、",
      ]),
      displayMath(String.raw`\sigma_m^z\, f_{\iota(\mu)} = \mu(m)\, f_{\iota(\mu)}`),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`m, m' \in \{1,\dots,M\}`),
        " について ",
        math(String.raw`\sigma_m^z\sigma_{m'}^z f_{\iota(\mu)} = \mu(m)\mu(m')f_{\iota(\mu)}`),
        " であり、これらはすべて基底 ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " に関して対角行列である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z = \begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " と ",
        ref("def_end_iso"),
        " の ",
        math(String.raw`e_1 = (1,0),\ e_2 = (0,1)`),
        " より、",
        math(String.raw`\mathbb{C}^2`),
        " の中で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z e_1
&=
\begin{pmatrix}
  1 & 0 \\
  0 & -1
\end{pmatrix}
\begin{pmatrix}
  1 \\
  0
\end{pmatrix}
\quad (\because \text{定義の代入}) \\
&=
\begin{pmatrix}
  1 \\
  0
\end{pmatrix}
\quad (\because \text{行列と列ベクトルの積}) \\
&= e_1
\quad (\because e_1 \text{ の定義}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z e_2
&=
\begin{pmatrix}
  1 & 0 \\
  0 & -1
\end{pmatrix}
\begin{pmatrix}
  0 \\
  1
\end{pmatrix}
\quad (\because \text{定義の代入}) \\
&=
\begin{pmatrix}
  0 \\
  -1
\end{pmatrix}
\quad (\because \text{行列と列ベクトルの積}) \\
&= -e_2
\quad (\because e_2 \text{ の定義}).
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " は ",
        math(String.raw`\mu(m) = +1`),
        " のとき ",
        math(String.raw`i_m = 1`),
        "、",
        math(String.raw`\mu(m) = -1`),
        " のとき ",
        math(String.raw`i_m = 2`),
        " と定めたから、いずれの場合も ",
        math(String.raw`\sigma^z e_{i_m} = \mu(m)\,e_{i_m}`),
        " と一言で書ける。",
      ]),
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_m^z = I \boxtimes\cdots\boxtimes \sigma^z \boxtimes\cdots\boxtimes I`),
        "（第 ",
        math(String.raw`m`),
        " 因子だけが ",
        math(String.raw`\sigma^z`),
        "）より",
      ]),
      paragraph([
        ref("kronecker_product_rule"),
        "（クロネッカー積の積は因子ごとの積）と ",
        ref("kronecker_multilinear"),
        " を順に用いると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^z\, f_{\iota(\mu)}
&= \left(I \boxtimes\cdots\boxtimes \sigma^z \boxtimes\cdots\boxtimes I\right)
   f_{\iota(\mu)}
   \quad (\because \text{サイト演算子 }\sigma_m^z\text{ の定義}) \\
&= \left(I \boxtimes\cdots\boxtimes \sigma^z \boxtimes\cdots\boxtimes I\right)
   \left(e_{i_1}\boxtimes\cdots\boxtimes e_{i_m}\boxtimes\cdots\boxtimes e_{i_M}\right)
   \quad (\because \text{配位基底同型の定義}) \\
&= (I e_{i_1})\boxtimes\cdots\boxtimes(\sigma^z e_{i_m})\boxtimes\cdots\boxtimes(I e_{i_M})
   \quad (\because \text{クロネッカー積の積の規則}) \\
&= e_{i_1}\boxtimes\cdots\boxtimes(\sigma^z e_{i_m})\boxtimes\cdots\boxtimes e_{i_M}
   \quad (\because \text{恒等行列の作用}) \\
&= e_{i_1}\boxtimes\cdots\boxtimes\left(\mu(m)e_{i_m}\right)\boxtimes\cdots\boxtimes e_{i_M}
   \quad (\because \sigma^z e_{i_m}=\mu(m)e_{i_m}) \\
&= \mu(m)\,\left(e_{i_1}\boxtimes\cdots\boxtimes e_{i_M}\right)
   \quad (\because \text{クロネッカー積の多重線型性}) \\
&= \mu(m)\, f_{\iota(\mu)}
   \quad (\because \text{配位基底同型の定義})
\end{aligned}`,
      ),
      paragraph(["積については、いま示した作用を 2 回用いると"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^z\sigma_{m'}^z f_{\iota(\mu)}
&= \sigma_m^z\left(\mu(m')f_{\iota(\mu)}\right)
   \quad (\because \sigma_{m'}^z f_{\iota(\mu)}=\mu(m')f_{\iota(\mu)}) \\
&= \mu(m')\sigma_m^z f_{\iota(\mu)}
   \quad (\because \text{行列作用の線型性}) \\
&= \mu(m')\left(\mu(m)f_{\iota(\mu)}\right)
   \quad (\because \sigma_m^z f_{\iota(\mu)}=\mu(m)f_{\iota(\mu)}) \\
&= \left(\mu(m')\mu(m)\right)f_{\iota(\mu)}
   \quad (\because \text{スカラー倍の結合律}) \\
&= \mu(m)\mu(m')f_{\iota(\mu)}
   \quad (\because \text{複素数の乗法の交換律}).
\end{aligned}`,
      ),
      paragraph([
        "基底 ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " の各元が固有ベクトルなので、これらの行列は基底 ",
        math(String.raw`(f_I)`),
        " に関して対角行列である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },

  {
    id: "bridge_003_claim_exp_of_diagonal",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { text: "対角行列の指数関数" },
    labels: ["exp_of_diagonal_matrix"],
    statement: [
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
        String.raw`\exp(D)_{kl} = \begin{cases} e^{d_k} & (k = l) \\ 0 & (k \neq l)\end{cases}`,
      ),
      paragraph(["すなわち ", math(String.raw`\exp(D)`), " も対角行列で、対角成分は ", math(String.raw`e^{d_k}`), " である。"]),
    ],
    proof: [
      paragraph([
        "Step 1（冪）。対角行列 ",
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
        "Step 2（部分和）。",
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
   \quad (\because \text{Step 1 より } (D^p)_{kk} = d_k^{\,p}), \\
(E_K)_{kl}
&= \sum_{p=0}^{K}\frac{1}{p!}(D^p)_{kl}
   \quad (\because \text{行列の和とスカラー倍は成分ごと}) \\
&= 0
   \quad (\because \text{Step 1 より } k \neq l \text{ では } (D^p)_{kl} = 0).
\end{aligned}`,
      ),
      paragraph([
        "Step 3（極限）。",
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
        math(String.raw`\sum_{p=0}^{K} d_k^{\,p}/p! \to e^{d_k}`),
        " なので ",
        math(String.raw`\exp(D)_{kk} = e^{d_k}`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "bridge_004_claim_V1_component_equals_pauli",
    kind: "claim",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`V_1 \text{ の成分定義とパウリ表示の一致}` },
    labels: ["V1_component_equals_pauli"],
    statement: [
      paragraph([
        math(String.raw`K_1 = J' \in \mathbb{R}_{>0}`),
        " とする。",
        ref("def_transfer_matrix"),
        " の成分で定義された ",
        math(String.raw`V_1`),
        " と ",
        ref("def_transfer_matrix_symbols"),
        " のパウリ行列で定義された ",
        math(String.raw`V_1`),
        " は、",
        ref("def_config_basis_iso"),
        " の同一視のもとで同一の行列である。すなわち任意の ",
        math(String.raw`\mu,\mu' \in \mathfrak{M}`),
        " について",
      ]),
      displayMath(
        String.raw`\left(\exp\!\left(K_1\sum_{m=1}^{M}\sigma_m^z\sigma_{m+1}^z\right)\right)_{\iota(\mu),\iota(\mu')}
= \delta_{\mu=\mu'}\exp\!\left(\sum_{m=1}^{M} J'\,\mu(m)\,\mu(m+1)\right)`,
      ),
      paragraph([
        "（両辺とも ",
        math(String.raw`\sigma_{M+1}^z := \sigma_1^z`),
        "、",
        math(String.raw`\mu(M+1) := \mu(1)`),
        " と周期的に延長したうえでの式である。）",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1。",
        math(String.raw`D := \sum_{m=1}^{M}\sigma_m^z\sigma_{m+1}^z`),
        " とおく。",
        math(String.raw`\sigma_{M+1}^z=\sigma_1^z`),
        " なので、周期端を分けると ",
        math(String.raw`D=\sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z+\sigma_M^z\sigma_1^z`),
        " である。",
        ref("sigma_z_diagonal_action"),
        " を、前半の和では ",
        math(String.raw`1\leq m\leq M-1`),
        " の ",
        math(String.raw`(m,m+1)`),
        " に、周期端では ",
        math(String.raw`(M,1)`),
        " に適用できる。したがって各 ",
        math(String.raw`\mu \in \mathfrak{M}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D\, f_{\iota(\mu)}
&= \left(\sum_{m=1}^{M-1}\sigma_m^z\sigma_{m+1}^z+\sigma_M^z\sigma_1^z\right)f_{\iota(\mu)}
   \quad (\because D\text{ の定義と }\sigma_{M+1}^z=\sigma_1^z) \\
&= \sum_{m=1}^{M-1}\left(\sigma_m^z\sigma_{m+1}^z f_{\iota(\mu)}\right)
   +\sigma_M^z\sigma_1^z f_{\iota(\mu)}
   \quad (\because \text{行列の有限和とベクトルの積の分配則}) \\
&= \sum_{m=1}^{M-1}\Bigl(\mu(m)\mu(m+1)\,f_{\iota(\mu)}\Bigr)
   +\mu(M)\mu(1)\,f_{\iota(\mu)}
   \quad (\because \text{前半には }(m,m+1),\text{周期端には }(M,1)\text{ の }\sigma^z\text{ 作用公式}) \\
&= \left(\sum_{m=1}^{M-1}\mu(m)\mu(m+1)+\mu(M)\mu(1)\right)f_{\iota(\mu)}
   \quad (\because \text{スカラー倍の有限和の括り出し（分配則）})
\\
&= \left(\sum_{m=1}^{M}\mu(m)\mu(m+1)\right) f_{\iota(\mu)}
   \quad (\because \mu(M+1)=\mu(1))
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`D`),
        " は基底 ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " に関して対角行列であり、その ",
        math(String.raw`\iota(\mu)`),
        " 番目の対角成分は ",
        math(String.raw`d_{\iota(\mu)} = \sum_{m=1}^{M}\mu(m)\mu(m+1)`),
        " である。",
        math(String.raw`K_1 D`),
        " も対角行列で対角成分は ",
        math(String.raw`K_1 d_{\iota(\mu)}`),
        "。",
      ]),
      paragraph([
        "Step 2。",
        ref("exp_of_diagonal_matrix"),
        " を ",
        math(String.raw`K_1 D`),
        " に適用すると ",
        math(String.raw`\exp(K_1 D)`),
        " は対角行列である。さらに ",
        ref("def_config_basis_iso"),
        " より ",
        math(String.raw`\iota`),
        " は全単射なので、成分を主張の右辺まで一続きに計算できる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\exp(K_1 D)\right)_{\iota(\mu),\iota(\mu')}
&= \begin{cases}
\exp\!\left(K_1\displaystyle\sum_{m=1}^{M}\mu(m)\mu(m+1)\right)
  & (\iota(\mu) = \iota(\mu')) \\
0 & (\iota(\mu) \neq \iota(\mu'))
\end{cases}
  \quad (\because \text{対角行列の指数関数と Step 1 の対角成分}) \\
&= \delta_{\mu=\mu'}\exp\!\left(K_1\sum_{m=1}^{M}\mu(m)\mu(m+1)\right)
  \quad (\because \iota \text{ の単射性より }\iota(\mu)=\iota(\mu')\iff\mu=\mu') \\
&= \delta_{\mu=\mu'}\exp\!\left(\sum_{m=1}^{M}J'\,\mu(m)\mu(m+1)\right)
  \quad (\because K_1=J').
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "M=2,3,4 と複数の K_1 について、成分定義の V_1 とパウリ表示の V_1 が残差 0.00e+00 で一致することを確認した（sagemath/check/043_claim_transfer_matrix_bridge/check_01_V1_bridge.sage）。",
      ],
    },
  },

  {
    id: "bridge_005_claim_two_by_two_transfer_identity",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { tex: String.raw`2\times 2 \text{ の転送行列の恒等式}` },
    labels: ["two_by_two_transfer_identity"],
    statement: [
      paragraph([
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_2^* = -\tfrac{1}{2}\log(\tanh K_2)`),
        "、",
        math(String.raw`s_2 = \sinh 2K_2`),
        " を用いる。",
        math(String.raw`A \in \mathrm{Mat}(2,\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`A := \begin{pmatrix} e^{K_2} & e^{-K_2} \\ e^{-K_2} & e^{K_2} \end{pmatrix}`,
      ),
      paragraph([
        "（すなわち ",
        math(String.raw`A_{ij} = \exp(K_2\,\varsigma_i\,\varsigma_j)`),
        "、",
        math(String.raw`\varsigma_1 := +1,\ \varsigma_2 := -1`),
        "）と定めると、",
      ]),
      displayMath(String.raw`A = (2 s_2)^{1/2}\exp\!\left(K_2^*\,\sigma^x\right)`),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`(2s_2)^{1/2}`),
        " は正の実数 ",
        math(String.raw`2s_2`),
        " の非負平方根（",
        ref("definition_of_sqrt_r_positive"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`\exp(t\sigma^x)`),
        " の閉じた形）。",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = I`),
        " である。したがって ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\sigma^x)^{2p}
&= \left((\sigma^x)^2\right)^p
   \quad (\because \text{行列の冪の指数法則}) \\
&= I^p
   \quad (\because (\sigma^x)^2=I) \\
&= I
   \quad (\because \text{単位行列の自然数冪}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(\sigma^x)^{2p+1}
&= (\sigma^x)^{2p}\sigma^x
   \quad (\because \text{行列の冪の加法則}) \\
&= I\sigma^x
   \quad (\because (\sigma^x)^{2p}=I) \\
&= \sigma^x
   \quad (\because \text{単位行列の作用})
\end{aligned}`,
      ),
      paragraph([
        "である。よって ",
        math(String.raw`t \in \mathbb{R}`),
        " について ",
        ref("def_exp"),
        " の級数を偶数項と奇数項に分けると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(t\sigma^x)
&= \left(\sum_{p=0}^{\infty}\frac{t^{2p}}{(2p)!}\right) I
+ \left(\sum_{p=0}^{\infty}\frac{t^{2p+1}}{(2p+1)!}\right)\sigma^x
   \quad (\because \text{絶対収束する指数級数を偶数項と奇数項へ分割し、}(\sigma^x)^{2p}=I,\ (\sigma^x)^{2p+1}=\sigma^x\text{ を適用}) \\
&= \cosh(t)\,I + \sinh(t)\,\sigma^x
   \quad (\because \cosh,\sinh\text{ のテイラー展開})
\end{aligned}`,
      ),
      paragraph([
        "（級数の分割は ",
        ref("exp_converges"),
        " の絶対収束と ",
        ref("real_exp_series_converges"),
        " による。最後の等号は ",
        ref("cosh_sinh_basic_properties"),
        " の ",
        math(String.raw`\cosh, \sinh`),
        " のテイラー展開。）したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\exp\!\left(K_2^*\sigma^x\right)
&= (2s_2)^{1/2}\bigl(\cosh(K_2^*)\,I + \sinh(K_2^*)\,\sigma^x\bigr)
   \quad (\because \text{上の閉じた形に } t = K_2^* \text{ を代入}) \\
&= \begin{pmatrix}
(2s_2)^{1/2}\cosh K_2^* & (2s_2)^{1/2}\sinh K_2^* \\
(2s_2)^{1/2}\sinh K_2^* & (2s_2)^{1/2}\cosh K_2^*
\end{pmatrix}
   \quad (\because I,\ \sigma^x \text{ の成分を書き下し、スカラー倍を各成分へ掛ける})
\end{aligned}`,
      ),
      paragraph([
        "なので、示すべきは次の 2 つの等式である。",
      ]),
      displayMath(
        String.raw`(2s_2)^{1/2}\cosh K_2^* = e^{K_2}, \qquad
(2s_2)^{1/2}\sinh K_2^* = e^{-K_2}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\cosh K_2^*, \sinh K_2^*`),
        " を ",
        math(String.raw`K_2`),
        " で書く）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_2^* = -\tfrac12\log(\tanh K_2)`),
        " より ",
        math(String.raw`\log(\tanh K_2) = -2K_2^*`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-2K_2^*}
&= e^{\log(\tanh K_2)}
   \quad (\because \log(\tanh K_2) = -2K_2^* \text{ を指数へ代入}) \\
&= \tanh K_2
   \quad (\because \exp \text{ と } \log \text{ は互いに逆写像})
\end{aligned}`,
      ),
      paragraph([
        "以後 ",
        math(String.raw`t := \tanh K_2`),
        " と置く。",
      ]),
      paragraph([
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`0 < t < 1`),
        " である（",
        ref("cosh_sinh_basic_properties"),
        " の ",
        math(String.raw`\cosh x > \sinh x > 0\ (x>0)`),
        "）。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-K_2^*}
&= \left(e^{-2K_2^*}\right)^{1/2}
   \quad (\because \text{指数法則 } e^{-2K_2^*} = (e^{-K_2^*})^2 \text{ と } e^{-K_2^*} > 0 \text{ の正の平方根}) \\
&= t^{1/2}
   \quad (\because e^{-2K_2^*} = t),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
e^{K_2^*}
&= \frac{1}{e^{-K_2^*}}
   \quad (\because \text{指数法則 } e^{K_2^*}e^{-K_2^*} = 1) \\
&= \frac{1}{t^{1/2}}
   \quad (\because e^{-K_2^*} = t^{1/2}) \\
&= t^{-1/2}
   \quad (\because \text{負冪の定義 } t^{-1/2} = 1/t^{1/2})
\end{aligned}`,
      ),
      paragraph(["である。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\cosh K_2^*
&= \frac{e^{K_2^*} + e^{-K_2^*}}{2}
   \quad (\because \cosh \text{ の定義 } \cosh x = \tfrac{e^{x}+e^{-x}}{2}) \\
&= \frac{t^{-1/2} + t^{1/2}}{2}
   \quad (\because e^{K_2^*} = t^{-1/2},\ e^{-K_2^*} = t^{1/2}) \\
&= \frac{1+t}{2\,t^{1/2}}
   \quad (\because \text{分子・分母に } t^{1/2} \text{ を掛ける}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh K_2^*
&= \frac{e^{K_2^*} - e^{-K_2^*}}{2}
   \quad (\because \sinh \text{ の定義 } \sinh x = \tfrac{e^{x}-e^{-x}}{2}) \\
&= \frac{t^{-1/2} - t^{1/2}}{2}
   \quad (\because e^{K_2^*} = t^{-1/2},\ e^{-K_2^*} = t^{1/2}) \\
&= \frac{1-t}{2\,t^{1/2}}
   \quad (\because \text{分子・分母に } t^{1/2} \text{ を掛ける}).
\end{aligned}`,
      ),
      paragraph([
        "さらに ",
        math(String.raw`t = \tanh K_2 = \dfrac{\sinh K_2}{\cosh K_2}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1 + t
&= 1 + \frac{\sinh K_2}{\cosh K_2}
   \quad (\because t = \tanh K_2 = \tfrac{\sinh K_2}{\cosh K_2}) \\
&= \frac{\cosh K_2 + \sinh K_2}{\cosh K_2}
   \quad (\because \text{通分}) \\
&= \frac{e^{K_2}}{\cosh K_2}
   \quad (\because \cosh x + \sinh x = e^{x}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
1 - t
&= 1 - \frac{\sinh K_2}{\cosh K_2}
   \quad (\because t = \tanh K_2 = \tfrac{\sinh K_2}{\cosh K_2}) \\
&= \frac{\cosh K_2 - \sinh K_2}{\cosh K_2}
   \quad (\because \text{通分}) \\
&= \frac{e^{-K_2}}{\cosh K_2}
   \quad (\because \cosh x - \sinh x = e^{-x}).
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\cosh x \pm \sinh x = e^{\pm x}`),
        " は ",
        ref("cosh_sinh_basic_properties"),
        " による。）",
      ]),
      paragraph(["Step 3（前因子）。まず"]),
      displayMath(String.raw`\begin{aligned}
2s_2
&= 2\sinh 2K_2
   \quad (\because s_2 = \sinh 2K_2 \text{ の代入}) \\
&= 2\left(2\sinh K_2\cosh K_2\right)
   \quad (\because \text{倍角公式 }\sinh 2K_2 = 2\sinh K_2\cosh K_2) \\
&= 4\sinh K_2\cosh K_2
   \quad (\because \text{数の積の結合則})
\end{aligned}`),
      paragraph([
        "である（倍角公式は ",
        ref("cosh_sinh_basic_properties"),
        " による）。",
        math(String.raw`\sinh K_2, \cosh K_2 > 0`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}
&= \left(4\sinh K_2\,\cosh K_2\right)^{1/2}
   \quad (\because 2s_2 = 4\sinh K_2\cosh K_2 \text{ の代入}) \\
&= 4^{1/2}\left(\sinh K_2\,\cosh K_2\right)^{1/2}
   \quad (\because \text{非負実数の平方根は積を保つ}) \\
&= 2\left(\sinh K_2\,\cosh K_2\right)^{1/2}
   \quad (\because 4^{1/2} = 2)
\end{aligned}`,
      ),
      displayMath(
        String.raw`t^{1/2} = \left(\frac{\sinh K_2}{\cosh K_2}\right)^{1/2}
   \quad (\because t = \tanh K_2 = \tfrac{\sinh K_2}{\cosh K_2} \text{ の代入})`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{(2s_2)^{1/2}}{2\,t^{1/2}}
&= \frac{2\left(\sinh K_2\cosh K_2\right)^{1/2}}{2}
   \left(\frac{\cosh K_2}{\sinh K_2}\right)^{1/2}
   \quad (\because \text{直前の 2 式の代入}) \\
&= \left(\sinh K_2\cosh K_2\right)^{1/2}
   \left(\frac{\cosh K_2}{\sinh K_2}\right)^{1/2}
   \quad (\because \text{約分 } \tfrac{2}{2} = 1) \\
&= \left(\sinh K_2\cosh K_2 \cdot \frac{\cosh K_2}{\sinh K_2}\right)^{1/2}
   \quad (\because \text{非負実数の平方根は積を保つ}) \\
&= \left(\cosh^2 K_2\right)^{1/2}
   \quad (\because \text{約分 } \tfrac{\sinh K_2}{\sinh K_2} = 1) \\
&= \cosh K_2
   \quad (\because \cosh K_2 > 0)
\end{aligned}`,
      ),
      paragraph(["Step 4（結論）。Step 2・Step 3 を合わせて"]),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\cosh K_2^*
&= (2s_2)^{1/2}\,\frac{1+t}{2\,t^{1/2}}
   \quad (\because \text{Step 2 の } \cosh K_2^* \text{ の式}) \\
&= \frac{(2s_2)^{1/2}}{2\,t^{1/2}}\,(1+t)
   \quad (\because \text{積の並べ替え}) \\
&= \cosh K_2 \cdot (1+t)
   \quad (\because \text{Step 3 の前因子の式}) \\
&= \cosh K_2 \cdot \frac{e^{K_2}}{\cosh K_2}
   \quad (\because \text{Step 2 の } 1+t \text{ の式}) \\
&= e^{K_2}
   \quad (\because \text{約分 } \tfrac{\cosh K_2}{\cosh K_2} = 1),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\sinh K_2^*
&= (2s_2)^{1/2}\,\frac{1-t}{2\,t^{1/2}}
   \quad (\because \text{Step 2 の } \sinh K_2^* \text{ の式}) \\
&= \frac{(2s_2)^{1/2}}{2\,t^{1/2}}\,(1-t)
   \quad (\because \text{積の並べ替え}) \\
&= \cosh K_2 \cdot (1-t)
   \quad (\because \text{Step 3 の前因子の式}) \\
&= \cosh K_2 \cdot \frac{e^{-K_2}}{\cosh K_2}
   \quad (\because \text{Step 2 の } 1-t \text{ の式}) \\
&= e^{-K_2}
   \quad (\because \text{約分 } \tfrac{\cosh K_2}{\cosh K_2} = 1).
\end{aligned}`,
      ),
      paragraph(["これで主張の 2 式が示された。"]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "bridge_006_claim_V2_component_equals_pauli",
    kind: "claim",
    origin: { path: SRC, ordinal: 8 },
    title: { tex: String.raw`V_2 \text{ の成分定義とパウリ表示の一致}` },
    labels: ["V2_component_equals_pauli"],
    statement: [
      paragraph([
        math(String.raw`K_2 = J \in \mathbb{R}_{>0}`),
        " とする。",
        ref("def_transfer_matrix"),
        " の成分で定義された ",
        math(String.raw`V_2`),
        " と ",
        ref("def_transfer_matrix_symbols"),
        " のパウリ行列で定義された ",
        math(String.raw`V_2`),
        " は、",
        ref("def_config_basis_iso"),
        " の同一視のもとで同一の行列である。すなわち任意の ",
        math(String.raw`\mu,\mu' \in \mathfrak{M}`),
        " について",
      ]),
      displayMath(
        String.raw`\left((2\sinh 2K_2)^{M/2}\exp\!\left(K_2^*\sum_{m=1}^{M}\sigma_m^x\right)\right)_{\iota(\mu),\iota(\mu')}
= \exp\!\left(\sum_{m=1}^{M} J\,\mu(m)\,\mu'(m)\right)`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1（右辺を因子ごとの積に分ける）。実数の指数法則より",
      ]),
      displayMath(
        String.raw`\exp\!\left(\sum_{m=1}^{M} K_2\,\mu(m)\mu'(m)\right)
= \prod_{m=1}^{M}\exp\!\left(K_2\,\mu(m)\mu'(m)\right)
\quad (\because \text{実数の指数法則を有限和へ繰り返し適用})`,
      ),
      paragraph([
        ref("two_by_two_transfer_identity"),
        " の ",
        math(String.raw`A`),
        "（",
        math(String.raw`A_{ij} = \exp(K_2\varsigma_i\varsigma_j)`),
        "、",
        math(String.raw`\varsigma_1 = +1,\ \varsigma_2 = -1`),
        "）を使うと、",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota(\mu) = (i_1,\dots,i_M)`),
        "、",
        math(String.raw`\iota(\mu') = (j_1,\dots,j_M)`),
        " について ",
        math(String.raw`\varsigma_{i_m} = \mu(m)`),
        "、",
        math(String.raw`\varsigma_{j_m} = \mu'(m)`),
        " なので",
      ]),
      displayMath(
        String.raw`\exp\!\left(K_2\,\mu(m)\mu'(m)\right)
= A_{i_m j_m}
\quad (\because A \text{ の成分定義と }\varsigma_{i_m}=\mu(m),\ \varsigma_{j_m}=\mu'(m))`,
      ),
      paragraph(["すなわち"]),
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(\sum_{m=1}^{M} K_2\,\mu(m)\mu'(m)\right)
&= \prod_{m=1}^{M} A_{i_m j_m}
   \quad (\because \text{直前の成分の等式を有限積の全因子へ同時適用}) \\
&= \left(\underbrace{A \boxtimes \cdots \boxtimes A}_{M}\right)_{\iota(\mu),\iota(\mu')}
   \quad (\because \text{クロネッカー積の成分の定義})
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は ",
        ref("def_kronecker"),
        " (2) のクロネッカー積の成分の定義（成分は因子ごとの成分の積）である。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`A`),
        " のクロネッカー冪を書き換える）。",
        ref("two_by_two_transfer_identity"),
        " より ",
        math(String.raw`A = (2s_2)^{1/2}\exp(K_2^*\sigma^x)`),
        " なので、",
        ref("kronecker_multilinear"),
        "（各因子についての線型性）よりスカラーを ",
        math(String.raw`M`),
        " 個の因子から前へ出せて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{A \boxtimes \cdots \boxtimes A}_{M}
&= \left((2s_2)^{1/2}\right)^{M}
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M}
   \quad (\because A=(2s_2)^{1/2}\exp(K_2^*\sigma^x)\text{ とクロネッカー積の多重線型性}) \\
&= (2s_2)^{M/2}\,
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M}
   \quad (\because ((2s_2)^{1/2})^M=(2s_2)^{M/2})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（1 因子の ",
        math(String.raw`\exp`),
        " をサイト演算子の ",
        math(String.raw`\exp`),
        " にする）。",
        math(String.raw`m \in \{1,\dots,M\}`),
        " を固定する。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_m^x = I\boxtimes\cdots\boxtimes\sigma^x\boxtimes\cdots\boxtimes I`),
        "（第 ",
        math(String.raw`m`),
        " 因子だけが ",
        math(String.raw`\sigma^x`),
        "）について、",
        ref("kronecker_product_rule"),
        " (1) を繰り返し使うと ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " で",
      ]),
      displayMath(
        String.raw`(\sigma_m^x)^{p}
= I\boxtimes\cdots\boxtimes(\sigma^x)^{p}\boxtimes\cdots\boxtimes I
\quad (\because \text{クロネッカー積の積の法則と }I^p=I)`,
      ),
      paragraph([
        "であり（",
        math(String.raw`I \cdot I = I`),
        " なので他の因子は ",
        math(String.raw`I`),
        " のまま）、部分和と ",
        ref("kronecker_multilinear"),
        " の線型性、および ",
        ref("def_kronecker"),
        " (2) の成分表示による成分ごとの収束（",
        ref("exp_of_diagonal_matrix"),
        " の Step 3 と同じ評価 ",
        math(String.raw`|A_{kl}| \leq \|A\|`),
        "）から",
      ]),
      displayMath(
        String.raw`\exp\!\left(K_2^*\sigma_m^x\right)
= I\boxtimes\cdots\boxtimes\exp\!\left(K_2^*\sigma^x\right)\boxtimes\cdots\boxtimes I
\quad (\because \text{指数級数の部分和へ直前の冪の等式を適用し、成分ごとの極限を取る})`,
      ),
      paragraph([
        "Step 4（積にまとめる）。相異なる ",
        math(String.raw`m \neq m'`),
        " について ",
        math(String.raw`\sigma_m^x`),
        " と ",
        math(String.raw`\sigma_{m'}^x`),
        " は可換である（",
        ref("kronecker_product_rule"),
        " (1) より、積はどちらの順でも「第 ",
        math(String.raw`m`),
        " 因子と第 ",
        math(String.raw`m'`),
        " 因子が ",
        math(String.raw`\sigma^x`),
        "、他が ",
        math(String.raw`I`),
        "」になる）。よって ",
        ref("theorem_exp_product"),
        " を繰り返し適用して",
      ]),
      displayMath(
        String.raw`\exp\!\left(K_2^*\sum_{m=1}^{M}\sigma_m^x\right)
= \prod_{m=1}^{M}\exp\!\left(K_2^*\sigma_m^x\right)
\quad (\because \text{互いに可換な行列の指数の積の定理を有限和へ繰り返し適用})`,
      ),
      paragraph([
        "右辺に Step 3 を代入し、",
        ref("kronecker_product_rule"),
        " (1) で因子ごとの積にまとめると、第 ",
        math(String.raw`m`),
        " 因子だけが ",
        math(String.raw`\exp(K_2^*\sigma^x)`),
        " で他が ",
        math(String.raw`I`),
        " の行列を ",
        math(String.raw`m = 1,\dots,M`),
        " について掛け合わせることになるので",
      ]),
      displayMath(
        String.raw`\prod_{m=1}^{M}\exp\!\left(K_2^*\sigma_m^x\right)
= \underbrace{\exp(K_2^*\sigma^x)\boxtimes\cdots\boxtimes\exp(K_2^*\sigma^x)}_{M}
\quad (\because \text{Step 3 の表示とクロネッカー積の積の法則})`,
      ),
      paragraph([
        "Step 5（結論）。Step 2 と Step 4 を合わせると",
      ]),
      displayMath(
        String.raw`\underbrace{A \boxtimes \cdots \boxtimes A}_{M}
= (2s_2)^{M/2}\exp\!\left(K_2^*\sum_{m=1}^{M}\sigma_m^x\right)
\quad (\because \text{Step 2 の表示へ Step 4 の二つの等式を代入})`,
      ),
      paragraph([
        "であり、これと Step 1 を合わせて、",
        math(String.raw`K_2 = J`),
        " のもとで主張の等式を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "M=2,3,4 と複数の K_2 について、成分定義の V_2 とパウリ表示の V_2 が残差 1e-14 以下で一致することを確認した（sagemath/check/043_claim_transfer_matrix_bridge/check_02_V2_bridge.sage）。2×2 の恒等式も同ファイルで確認している。",
      ],
    },
  },

  {
    id: "bridge_007_claim_partition_function_in_pauli_form",
    kind: "claim",
    origin: { path: SRC, ordinal: 9 },
    title: { text: "分配関数をパウリ行列表示の転送行列で書く" },
    labels: ["partition_function_in_pauli_form"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "（鎖の長さ）、",
        math(String.raw`N_{\mathrm{row}} \in \mathbb{Z}_{\geq 1}`),
        "（転送の回数）、",
        math(String.raw`J, J' \in \mathbb{R}_{>0}`),
        " とし、",
        math(String.raw`K_1 := J'`),
        "、",
        math(String.raw`K_2 := J`),
        " とおく。",
        ref("def_partition_function_2d_ising"),
        " の分配関数（そこでの ",
        math(String.raw`M`),
        " を ",
        math(String.raw`N_{\mathrm{row}}`),
        "、",
        math(String.raw`N`),
        " を ",
        math(String.raw`M`),
        " と読み替える）は、",
        ref("def_transfer_matrix_symbols"),
        " のパウリ行列表示の ",
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を用いて",
      ]),
      displayMath(
        String.raw`Z(J, J') = \mathrm{tr}\!\left((V_1 V_2)^{N_{\mathrm{row}}}\right)`,
      ),
      paragraph(["と書ける。"]),
    ],
    proof: [
      paragraph([
        ref("partition_function_via_transfer_matrix"),
        " は、",
        ref("def_transfer_matrix"),
        " の**成分で定義された** ",
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を扱う。これらを ",
        math(String.raw`V_1^{\mathrm{comp}},V_2^{\mathrm{comp}}`),
        " と書き、パウリ行列表示の行列を ",
        math(String.raw`V_1^{\mathrm{Pauli}},V_2^{\mathrm{Pauli}}`),
        " と書く。",
        ref("V1_component_equals_pauli"),
        " と ",
        ref("V2_component_equals_pauli"),
        " により、",
        ref("def_config_basis_iso"),
        " の全単射が与える行列番号について ",
        math(String.raw`V_1^{\mathrm{comp}}=V_1^{\mathrm{Pauli}}`),
        " および ",
        math(String.raw`V_2^{\mathrm{comp}}=V_2^{\mathrm{Pauli}}`),
        " が成り立つ（すべての ",
        math(String.raw`(\mu,\mu')`),
        " 成分が一致し、",
        math(String.raw`\iota`),
        " が全単射なのですべての行・列番号の組を尽くす）。",
      ]),
      displayMath(String.raw`\begin{aligned}
Z(J,J')
&=\mathrm{tr}\!\left(\left(V_1^{\mathrm{comp}}V_2^{\mathrm{comp}}\right)^{N_{\mathrm{row}}}\right)
&&\bigl(\because\ \text{分配関数の転送行列表示}\bigr)\\
&=\mathrm{tr}\!\left(\left(V_1^{\mathrm{Pauli}}V_2^{\mathrm{comp}}\right)^{N_{\mathrm{row}}}\right)
&&\bigl(\because\ V_1\text{ の成分定義とパウリ表示の一致}\bigr)\\
&=\mathrm{tr}\!\left(\left(V_1^{\mathrm{Pauli}}V_2^{\mathrm{Pauli}}\right)^{N_{\mathrm{row}}}\right)
&&\bigl(\because\ V_2\text{ の成分定義とパウリ表示の一致}\bigr)
\end{aligned}`),
      paragraph([
        "（",
        ref("def_transfer_matrix"),
        " が「全単射の取り方に依らない」と述べていたので、",
        ref("def_config_basis_iso"),
        " で ",
        math(String.raw`\iota`),
        " を選んだことによる一般性の喪失は無い。実際、別の全単射を取ると ",
        math(String.raw`V_1, V_2`),
        " はともに同じ置換行列 ",
        math(String.raw`P`),
        " による ",
        math(String.raw`P V_a P^{-1}`),
        " に置き換わるだけで、",
        ref("trace_basic_properties"),
        " (4) よりトレースは変わらない。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "Z の定義（スピン配置についての直接和）と tr((V_1V_2)^{N_row}) が、K_1 = J'、K_2 = J のもとで一致することを N_row, M = 2,3 の全 4 組・複数の (K_1,K_2) について数値確認した（sagemath/check/043_claim_transfer_matrix_bridge/check_04_partition_function.sage）。これは 001 章の主張の再確認も兼ねる。",
      ],
    },
  },

  {
    id: "bridge_008_definition_epsilon_projectors",
    kind: "definition",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`\varepsilon \text{ の固有空間への射影子 } P^{(\pm)}` },
    labels: ["def_epsilon_projectors"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について（複号同順）",
      ]),
      displayMath(
        String.raw`P^{(\pm)} := \tfrac{1}{2}\left(I \pm \varepsilon\right)
\in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "と定める。ここで ",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },

  {
    id: "bridge_009_claim_epsilon_projector_properties",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`P^{(\pm)} \text{ の性質}` },
    labels: ["epsilon_projector_properties"],
    statement: [
      paragraph([
        ref("def_epsilon_projectors"),
        " の二つの行列は、互いに補い合い、",
        ref("def_eigenspaces_of_epsilon"),
        " の二つの固有空間へそれぞれ写す行列である。すなわち、次の三組の等式が成り立つ。",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \left(P^{(\pm)}\right)^2 = P^{(\pm)}, \qquad P^{(+)}P^{(-)} = P^{(-)}P^{(+)} = 0`)],
        [math(String.raw`\text{(2)}\quad P^{(+)} + P^{(-)} = I`)],
        [
          math(String.raw`\text{(3)}\quad \mathrm{im}\,P^{(\pm)} = \mathcal{F}^{(\pm)}`),
          "（",
          ref("def_eigenspaces_of_epsilon"),
          " の ",
          math(String.raw`\mathcal{F}^{(\pm)}`),
          "）",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("epsilon_square_and_eigenvalues"),
        " の ",
        math(String.raw`\varepsilon^2=I`),
        " と ",
        ref("def_epsilon_projectors"),
        " を使う。まず、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(P^{(\pm)}\right)^2
&= \tfrac{1}{4}\left(I \pm \varepsilon\right)\left(I \pm \varepsilon\right)
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{4}\left(I \pm \varepsilon \pm \varepsilon + \varepsilon^2\right)
   \quad (\because \text{分配法則と } I\varepsilon=\varepsilon I=\varepsilon) \\
&= \tfrac{1}{4}\left(I \pm 2\varepsilon + \varepsilon^2\right)
   \quad (\because \text{同類項をまとめる}) \\
&= \tfrac{1}{4}\left(2I \pm 2\varepsilon\right)
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の } \varepsilon^2=I) \\
&= \tfrac{1}{2}\left(I \pm \varepsilon\right)
   \quad (\because \text{スカラー倍を整理する}) \\
&= P^{(\pm)}
   \quad (\because \blkref{def_epsilon_projectors}), \\
P^{(+)}P^{(-)}
&= \tfrac{1}{4}\left(I + \varepsilon\right)\left(I - \varepsilon\right)
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{4}\left(I-I\varepsilon+\varepsilon I-\varepsilon^2\right)
   \quad (\because \text{分配法則}) \\
&= \tfrac{1}{4}\left(I-\varepsilon^2\right)
   \quad (\because I\varepsilon=\varepsilon I=\varepsilon) \\
&= \tfrac{1}{4}\left(I-I\right)
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の } \varepsilon^2=I) \\
&= 0
   \quad (\because I-I=0), \\
P^{(-)}P^{(+)}
&= \tfrac{1}{4}\left(I - \varepsilon\right)\left(I + \varepsilon\right)
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{4}\left(I+I\varepsilon-\varepsilon I-\varepsilon^2\right)
   \quad (\because \text{分配法則}) \\
&= \tfrac{1}{4}\left(I-\varepsilon^2\right)
   \quad (\because I\varepsilon=\varepsilon I=\varepsilon) \\
&= \tfrac{1}{4}\left(I-I\right)
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の } \varepsilon^2=I) \\
&= 0
   \quad (\because I-I=0)
\end{aligned}`,
      ),
      paragraph(["(2)"]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)} + P^{(-)}
&= \tfrac12\left(I+\varepsilon\right) + \tfrac12\left(I-\varepsilon\right)
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac12\left(I+\varepsilon+I-\varepsilon\right)
   \quad (\because \text{スカラー倍の分配法則}) \\
&= \tfrac12\left(2I\right)
   \quad (\because \text{同類項をまとめる}) \\
&= I
   \quad (\because \text{スカラー倍を整理する})
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        ref("def_eigenspaces_of_epsilon"),
        " より ",
        math(String.raw`\mathcal{F}^{(\pm)} = \{f \in \mathcal{F} \mid \varepsilon f = \pm f\}`),
        "（",
        ref("def_end_iso"),
        " の同一視のもとで ",
        math(String.raw`\varepsilon f`),
        " は行列とベクトルの積）。",
      ]),
      paragraph([
        math(String.raw`(\subseteq)`),
        " ",
        math(String.raw`y \in \mathrm{im}\,P^{(\pm)}`),
        " とすると、ある ",
        math(String.raw`x\in\mathcal{F}`),
        " について ",
        math(String.raw`y = P^{(\pm)}x`),
        " と書ける。まず",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(\pm)}y
&= P^{(\pm)}P^{(\pm)}x
   \quad (\because y = P^{(\pm)}x) \\
&= \left(P^{(\pm)}\right)^2x
   \quad (\because \text{積の冪の表記}) \\
&= P^{(\pm)}x
   \quad (\because \text{(1) の冪等性}) \\
&= y
   \quad (\because y = P^{(\pm)}x)
\end{aligned}`,
      ),
      paragraph(["である。よって（複号同順）"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon y
&= \varepsilon P^{(\pm)} y
   \quad (\because \text{上の等式 } y = P^{(\pm)}y) \\
&= \varepsilon\cdot\tfrac{1}{2}\left(I \pm \varepsilon\right) y
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{2}\left(\varepsilon I \pm \varepsilon^2\right) y
   \quad (\because \text{分配法則}) \\
&= \tfrac{1}{2}\left(\varepsilon \pm \varepsilon^2\right) y
   \quad (\because \varepsilon I=\varepsilon) \\
&= \tfrac{1}{2}\left(\varepsilon \pm I\right) y
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の } \varepsilon^2=I) \\
&= \pm\,\tfrac{1}{2}\left(I \pm \varepsilon\right) y
   \quad (\because \text{複号同順の符号の整理。上の符号では }
     \tfrac12(\varepsilon+I)=+\tfrac12(I+\varepsilon)
     \text{、下の符号では } \tfrac12(\varepsilon-I)=-\tfrac12(I-\varepsilon)) \\
&= \pm\,P^{(\pm)}y
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \pm\,y
   \quad (\because \text{上の等式 } y = P^{(\pm)}y)
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        ref("def_eigenspaces_of_epsilon"),
        " により ",
        math(String.raw`y \in \mathcal{F}^{(\pm)}`),
        "。",
      ]),
      paragraph([
        math(String.raw`(\supseteq)`),
        " ",
        math(String.raw`f \in \mathcal{F}^{(\pm)}`),
        " すなわち（",
        ref("def_eigenspaces_of_epsilon"),
        " により）",
        math(String.raw`\varepsilon f = \pm f`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(\pm)} f
&= \tfrac{1}{2}\left(I \pm \varepsilon\right) f
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{2}\left(If \pm \varepsilon f\right)
   \quad (\because \text{分配法則}) \\
&= \tfrac{1}{2}\left(f \pm \varepsilon f\right)
   \quad (\because If=f) \\
&= \tfrac{1}{2}\left(f \pm (\pm f)\right)
   \quad (\because \text{仮定 } \varepsilon f = \pm f) \\
&= \tfrac{1}{2}\left(f + f\right)
   \quad (\because \text{複号同順により } \pm(\pm f) = f) \\
&= \tfrac{1}{2}\left(2f\right)
   \quad (\because \text{同類項をまとめる}) \\
&= f
   \quad (\because \text{スカラー倍を整理する})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`f = P^{(\pm)}f \in \mathrm{im}\,P^{(\pm)}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "式変形の書き方の統一（2026-08-14）: 各式変形の行末に残っていた根拠に対応するラベル参照を、各鎖の直後へ追加した。等式・不等式・場合分け・使用する根拠の内容は変えていない。",
        "式変形の書き方の統一（2026-09-03）: 各鎖の直後に置かれた参照段落を削り、参照を実際に使う各式変形行の行末の \\blkref へ移した。内容・式変形・根拠・参照は不変である。",
      ],
    },
  },

  {
    id: "bridge_definition_V1_pm_square_root",
    kind: "definition",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`V_1^{(\pm)} \text{ の平方根として用いる行列}` },
    labels: ["def_V1_pm_square_root"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし（複号同順）、",
        ref("def_V1_pm"),
        " の ",
        math(String.raw`V_1^{(\pm)}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\left(V_1^{(\pm)}\right)^{1/2}
:= \exp\!\left(\frac12 i K_1
\left(Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1} Z_M \mp Y_M Z_1\right)\right)
\in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "もとの可換性の主張で未定義のまま使われていた (V_1^{(\pm)})^{1/2} を、1 ブロック 1 定義に従って独立させた。二乗が V_1^{(\pm)} に等しいことは後続の平方根の主張で証明する。",
      ],
    },
  },

  {
    id: "bridge_claim_V1_pm_square_root_squares_to_V1_pm",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`V_1^{(\pm)} \text{ の半指数行列の二乗}` },
    labels: ["V1_pm_square_root_squares_to_V1_pm"],
    statement: [
      paragraph([ref("def_V1_pm_square_root"), " の行列について、"]),
      displayMath(String.raw`\left(\left(V_1^{(\pm)}\right)^{1/2}\right)^2=V_1^{(\pm)}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`G^{(\pm)}:=Y_1 Z_2+Y_2 Z_3+\cdots+Y_{M-1}Z_M\mp Y_MZ_1`),
        " とおく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(V_1^{(\pm)}\right)^{1/2}\right)^2
&=\exp\!\left(\tfrac12 iK_1G^{(\pm)}\right)
  \exp\!\left(\tfrac12 iK_1G^{(\pm)}\right)
&&\left(\because\ \blkref{def_V1_pm_square_root}\right)\\
&=\exp\!\left(iK_1G^{(\pm)}\right)
&&\left(\because\ \blkref{theorem_exp_product}\ \text{と同じ行列どうしの可換性}\right)\\
&=V_1^{(\pm)}
&&\left(\because\ \blkref{def_V1_pm}\right).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "平方根として用いる半指数行列の定義と、その二乗が V_1^{(\pm)} になる主張を 1 ブロック 1 主張に従って分離した。",
        "式変形の書き方の統一（2026-09-03）: 計算前の参照一覧を削り、既に各式変形行の行末にある \\blkref だけを残した。内容・式変形・根拠・参照は不変である。",
      ],
    },
  },

  {
    id: "bridge_010_claim_epsilon_commutes",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`\varepsilon \text{ は } V_1, V_2, V_1^{(\pm)} \text{ と可換}` },
    labels: ["epsilon_commutes_with_transfer_matrices"],
    statement: [
      paragraph([
        math(String.raw`\varepsilon`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1, V_2`),
        " および ",
        ref("def_V1_pm"),
        " の ",
        math(String.raw`V_1^{(\pm)}`),
        "、さらに ",
        ref("def_V1_pm_square_root"),
        " の ",
        math(String.raw`(V_1^{(\pm)})^{1/2}`),
        " と可換である。この行列が実際に平方根であることは ",
        ref("V1_pm_square_root_squares_to_V1_pm"),
        " で示した。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（サイト演算子との関係）。",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、",
        math(String.raw`\sigma^z\sigma^x = -\sigma^x\sigma^z`),
        "、",
        math(String.raw`\sigma^y\sigma^x = -\sigma^x\sigma^y`),
        "。相異なるサイトに置かれた因子どうしは可換（",
        ref("kronecker_product_rule"),
        " (1)）なので、",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\sigma_k^x
&= \sigma_k^x\,\varepsilon
   \quad (\because \sigma^x\sigma^x=I\text{ と、相異なるサイトの因子の可換性}) \\
\varepsilon\,\sigma_k^z
&= -\,\sigma_k^z\,\varepsilon
   \quad (\because \sigma^z\sigma^x=-\sigma^x\sigma^z\text{ と、相異なるサイトの因子の可換性}) \\
\varepsilon\,\sigma_k^y
&= -\,\sigma_k^y\,\varepsilon
   \quad (\because \sigma^y\sigma^x=-\sigma^x\sigma^y\text{ と、相異なるサイトの因子の可換性})
\qquad (k \in \{1,\dots,M\})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\varepsilon`),
        " のうち第 ",
        math(String.raw`k`),
        " 因子の ",
        math(String.raw`\sigma^x`),
        " だけが ",
        math(String.raw`\sigma_k^a`),
        " と非可換になりうる。）",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`V_2`),
        " との可換性）。",
        math(String.raw`R := K_2^*\sum_{m=1}^{M}\sigma_m^x`),
        " と置くと、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon R
&= K_2^*\sum_{m=1}^{M}\varepsilon\,\sigma_m^x
   \quad (\because \text{スカラー倍との可換性と、行列積の有限和への分配}) \\
&= K_2^*\sum_{m=1}^{M}\sigma_m^x\,\varepsilon
   \quad (\because \text{Step 1 の }\varepsilon\sigma_k^x=\sigma_k^x\varepsilon\text{ を全項へ同時適用}) \\
&= R\,\varepsilon
   \quad (\because \text{行列積の有限和への分配とスカラー倍との可換性})
\end{aligned}`,
      ),
      paragraph([
        "可換なら冪とも可換（",
        math(String.raw`\varepsilon R^p = R^p\varepsilon`),
        " が ",
        math(String.raw`p`),
        " についての帰納法で従う）ので、",
        ref("def_exp"),
        " の部分和とも可換であり、",
        ref("matrix_multiplication_continuity"),
        " による極限との交換から次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\exp(R)
&= \varepsilon\lim_{n\to\infty}\sum_{p=0}^{n}\frac{R^p}{p!}
   \quad (\because \exp\text{ の定義}) \\
&= \lim_{n\to\infty}\sum_{p=0}^{n}\frac{\varepsilon R^p}{p!}
   \quad (\because \text{行列積の連続性と有限和への分配}) \\
&= \lim_{n\to\infty}\sum_{p=0}^{n}\frac{R^p\varepsilon}{p!}
   \quad (\because \varepsilon R^p=R^p\varepsilon) \\
&= \left(\lim_{n\to\infty}\sum_{p=0}^{n}\frac{R^p}{p!}\right)\varepsilon
   \quad (\because \text{有限和への分配と行列積の連続性}) \\
&= \exp(R)\varepsilon
   \quad (\because \exp\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "スカラー ",
        math(String.raw`(2\sinh 2K_2)^{M/2}`),
        " は ",
        ref("scalar_identity_commutes"),
        " より任意の行列と可換なので、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon V_2
&= \varepsilon\left((2\sinh 2K_2)^{M/2}\exp(R)\right)
   \quad (\because V_2\text{ の定義と }R\text{ の定義}) \\
&= (2\sinh 2K_2)^{M/2}\left(\varepsilon\exp(R)\right)
   \quad (\because \text{スカラー倍との可換性}) \\
&= (2\sinh 2K_2)^{M/2}\left(\exp(R)\,\varepsilon\right)
   \quad (\because \text{上の }\varepsilon\exp(R)=\exp(R)\varepsilon) \\
&= \left((2\sinh 2K_2)^{M/2}\exp(R)\right)\varepsilon
   \quad (\because \text{スカラー倍との可換性}) \\
&= V_2\,\varepsilon
   \quad (\because V_2\text{ の定義と }R\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`V_1`),
        " との可換性）。Step 1 より次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\sigma_m^z\sigma_{m+1}^z
&= (-1)^2\,\sigma_m^z\sigma_{m+1}^z\,\varepsilon
   \quad (\because \sigma^z\text{ が二個なので、Step 1 の反可換性を二回適用}) \\
&= \sigma_m^z\sigma_{m+1}^z\,\varepsilon
   \quad (\because (-1)^2=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`D = \sum_{m=1}^{M}\sigma_m^z\sigma_{m+1}^z`),
        " と置くと、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon D
&= \sum_{m=1}^{M}\varepsilon\,\sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{行列積の有限和への分配}) \\
&= \sum_{m=1}^{M}\sigma_m^z\sigma_{m+1}^z\,\varepsilon
   \quad (\because \text{上の }\varepsilon\,\sigma_m^z\sigma_{m+1}^z=\sigma_m^z\sigma_{m+1}^z\,\varepsilon\text{ を全項へ同時適用}) \\
&= D\,\varepsilon
   \quad (\because \text{行列積の有限和への分配})
\end{aligned}`,
      ),
      paragraph([
        "よって Step 2 と同じ冪・有限和・極限の議論で ",
        math(String.raw`\varepsilon\exp(K_1D)=\exp(K_1D)\varepsilon`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon V_1
&= \varepsilon\exp(K_1D)
   \quad (\because V_1\text{ の定義}) \\
&= \exp(K_1D)\varepsilon
   \quad (\because \varepsilon\text{ と }\exp(K_1D)\text{ の可換性}) \\
&= V_1\varepsilon
   \quad (\because V_1\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`V_1^{(\pm)}`),
        " との可換性）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        " について、Step 1 より ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`\sigma_j^x`),
        " と可換、",
        math(String.raw`\sigma_m^z`),
        "・",
        math(String.raw`\sigma_m^y`),
        " とは反可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon Z_m
&= -\,Z_m\,\varepsilon
   \quad (\because \sigma_j^x\text{ との可換性と }\sigma_m^z\text{ との反可換性}) \\
\varepsilon Y_m
&= -\,Y_m\,\varepsilon
   \quad (\because \sigma_j^x\text{ との可換性と }\sigma_m^y\text{ との反可換性})
\end{aligned}`,
      ),
      paragraph([
        "よって次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,(Y_mZ_{m'})
&= (-1)^2 (Y_mZ_{m'})\,\varepsilon
   \quad (\because \varepsilon\text{ と }Y_m,Z_{m'}\text{ の反可換性を一回ずつ適用}) \\
&= (Y_mZ_{m'})\,\varepsilon
   \quad (\because (-1)^2=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`G^{(\pm)}`),
        " を次のように定める。",
      ]),
      displayMath(
        String.raw`G^{(\pm)} := Y_1Z_2 + Y_2Z_3 + \cdots + Y_{M-1}Z_M \mp Y_MZ_1`,
      ),
      paragraph([
        "これは各項が ",
        math(String.raw`Y\cdot Z`),
        " の形なので、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon G^{(\pm)}
&= \sum_{m=1}^{M-1}\varepsilon\,(Y_mZ_{m+1}) \mp \varepsilon\,(Y_MZ_1)
   \quad (\because \text{行列積の有限和への分配}) \\
&= \sum_{m=1}^{M-1}(Y_mZ_{m+1})\,\varepsilon \mp (Y_MZ_1)\,\varepsilon
   \quad (\because \text{上の }\varepsilon\,(Y_mZ_{m'})=(Y_mZ_{m'})\,\varepsilon\text{ を全項へ同時適用}) \\
&= G^{(\pm)}\,\varepsilon
   \quad (\because \text{行列積の有限和への分配})
\end{aligned}`,
      ),
      paragraph([
        "Step 2 と同じ議論で ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`\exp(iK_1G^{(\pm)}) = V_1^{(\pm)}`),
        " とも ",
        math(String.raw`\exp\!\left(\tfrac12 iK_1G^{(\pm)}\right) = (V_1^{(\pm)})^{1/2}`),
        " とも可換である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "式変形の書き方の統一（2026-08-14）: Step 2 末尾の散文に埋まっていたスカラー因子の付加（εV₂=V₂ε の導出）を、一行一等号と行末根拠の鎖へ開いた。等式・根拠の内容は変えていない。",
        "2026-09-01 の構成レビューで、後続の未ラベル定義にある H_1^{(\pm)} を先取りしていた箇所を、証明内の局所記号 G^{(\pm)} へ置き換えた。平方根の定義と射影の可換性は独立ブロックへ分けた。",
      ],
    },
  },

  {
    id: "bridge_claim_epsilon_projectors_commute_with_transfer_matrices",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`P^{(\pm)} \text{ は転送行列と可換}` },
    labels: ["epsilon_projectors_commute_with_transfer_matrices"],
    statement: [
      paragraph([
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(\pm)}`),
        " は ",
        ref("epsilon_commutes_with_transfer_matrices"),
        " の ",
        math(String.raw`V_1,V_2,V_1^{(\pm)},(V_1^{(\pm)})^{1/2}`),
        " のすべてと可換である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を ",
        math(String.raw`\varepsilon X = X\varepsilon`),
        " を満たす行列とする（",
        ref("epsilon_commutes_with_transfer_matrices"),
        " より ",
        math(String.raw`V_1, V_2, V_1^{(\pm)}, (V_1^{(\pm)})^{1/2}`),
        " がこれにあたる）。次の鎖を得る（複号同順）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(\pm)}X
&= \tfrac12\left(I \pm \varepsilon\right)X
   \quad (\because \blkref{def_epsilon_projectors}\ \text{の }P^{(\pm)}\text{ の定義}) \\
&= \tfrac12\left(IX \pm \varepsilon X\right)
   \quad (\because \text{分配法則}) \\
&= \tfrac12\left(X \pm \varepsilon X\right)
   \quad (\because IX=X) \\
&= \tfrac12\left(X \pm X\varepsilon\right)
   \quad (\because \text{仮定 }\varepsilon X=X\varepsilon) \\
&= \tfrac12\left(XI \pm X\varepsilon\right)
   \quad (\because X=XI) \\
&= X\cdot\tfrac12\left(I \pm \varepsilon\right)
   \quad (\because \text{分配法則とスカラー倍との可換性}) \\
&= X\,P^{(\pm)}
   \quad (\because \blkref{def_epsilon_projectors}\ \text{の }P^{(\pm)}\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\varepsilon`),
        " と可換な行列は ",
        math(String.raw`P^{(\pm)}`),
        " とも可換である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "もとの epsilon_commutes_with_transfer_matrices の Step 5 を、1 ブロック 1 主張に従って独立させた。",
      ],
    },
  },

  {
    id: "bridge_011_claim_sector_replacement",
    kind: "claim",
    origin: { path: SRC, ordinal: 13 },
    title: { tex: String.raw`\text{セクター上での } V_1 \text{ の置き換え}` },
    labels: ["sector_replacement_of_V1"],
    statement: [
      paragraph([ref("def_V1_pm"), " の記号のもとで（複号同順）"]),
      displayMath(String.raw`V_1\,P^{(\pm)} = V_1^{(\pm)}\,P^{(\pm)}`),
    ],
    proof: [
      paragraph([
        "固有空間上では、",
      ]),
      displayMath(
        String.raw`\left(V_1\right)\big|_{\mathcal{F}^{(\pm)}}
= \left(V_1^{(\pm)}\right)\big|_{\mathcal{F}^{(\pm)}}
\quad (\because \blkref{V1_restriction_to_eigenspaces}\ \text{と }\blkref{def_end_iso}\ \text{の同一視})`,
      ),
      paragraph([
        "すなわち任意の ",
        math(String.raw`f \in \mathcal{F}^{(\pm)}`),
        " について次を主張している。",
      ]),
      displayMath(
        String.raw`V_1 f
= V_1^{(\pm)} f
\quad (\because \left.V_1\right|_{\mathcal{F}^{(\pm)}}=\left.V_1^{(\pm)}\right|_{\mathcal{F}^{(\pm)}})`,
      ),
      paragraph([
        "任意の ",
        math(String.raw`x \in \mathcal{F}`),
        " について ",
        math(String.raw`P^{(\pm)}x \in \mathrm{im}\,P^{(\pm)} = \mathcal{F}^{(\pm)}`),
        " なので、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(V_1P^{(\pm)}\right)x
&=V_1\left(P^{(\pm)}x\right)
  \quad (\because \text{行列積の作用})\\
&=V_1^{(\pm)}\left(P^{(\pm)}x\right)
  \quad (\because \blkref{epsilon_projector_properties}\ \text{と上の制限の等式})\\
&=\left(V_1^{(\pm)}P^{(\pm)}\right)x
  \quad (\because \text{行列積の作用})
\end{aligned}`,
      ),
      paragraph([
        "この等式が任意の ",
        math(String.raw`x`),
        " について成り立つ。行列は ",
        math(String.raw`\mathcal{F} = \mathbb{C}^{2^M}`),
        " のすべてのベクトルへの作用で決まるので、",
      ]),
      displayMath(
        String.raw`V_1P^{(\pm)}
=V_1^{(\pm)}P^{(\pm)}
\quad (\because \text{すべての }x\in\mathcal{F}\text{ への作用が等しい})`,
      ),
      paragraph([
        "である。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "bridge_011a_claim_sector_replacement_pow",
    kind: "claim",
    origin: { path: SRC, ordinal: 13 },
    title: { text: "セクター上での置き換えを転送行列の積の冪へ反復" },
    labels: ["sector_replacement_pow"],
    statement: [
      paragraph(["（複号同順）"]),
      displayMath(
        String.raw`n \in \mathbb{Z}_{\geq 0} \text{ について } (V_1V_2)^{n}\,P^{(\pm)} = \left(V_1^{(\pm)}V_2\right)^{n}P^{(\pm)}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`P := P^{(\pm)}`),
        " と略記する。",
        ref("epsilon_projectors_commute_with_transfer_matrices"),
        " より ",
        math(String.raw`P`),
        " は ",
        math(String.raw`V_1, V_2, V_1^{(\pm)}`),
        " のすべてと可換であり、",
        ref("epsilon_projector_properties"),
        " (2) より ",
        math(String.raw`P^2 = P`),
        " である。",
        math(String.raw`n`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`n = 0`),
        " のときは両辺とも ",
        math(String.raw`P`),
        " で成立。",
        math(String.raw`(V_1V_2)^{n}P = (V_1^{(\pm)}V_2)^{n}P`),
        " を仮定する。",
        ref("sector_replacement_of_V1"),
        " と合わせると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_1V_2)^{n+1}P
&= V_1V_2\,(V_1V_2)^{n}P
   \quad (\because \text{冪の定義}) \\
&= V_1V_2\,(V_1V_2)^{n}P\,P
   \quad (\because P^2 = P) \\
&= V_1V_2\,P\,(V_1V_2)^{n}P
   \quad (\because P \text{ は } V_1, V_2 \text{ と可換なので } (V_1V_2)^{n} \text{ とも可換}) \\
&= V_1\,P\,V_2\,(V_1V_2)^{n}P
   \quad (\because P \text{ は } V_2 \text{ と可換}) \\
&= V_1^{(\pm)}\,P\,V_2\,(V_1V_2)^{n}P
   \quad (\because \text{セクター上での } V_1 \text{ の置き換え}) \\
&= V_1^{(\pm)}\,V_2\,P\,(V_1V_2)^{n}P
   \quad (\because P \text{ は } V_2 \text{ と可換}) \\
&= V_1^{(\pm)}\,V_2\,(V_1V_2)^{n}P\,P
   \quad (\because P \text{ は } V_1, V_2 \text{ と可換なので } (V_1V_2)^{n} \text{ とも可換}) \\
&= V_1^{(\pm)}\,V_2\,(V_1V_2)^{n}P
   \quad (\because P^2 = P) \\
&= V_1^{(\pm)}\,V_2\,\left(V_1^{(\pm)}V_2\right)^{n}P
   \quad (\because \text{帰納法の仮定}) \\
&= \left(V_1^{(\pm)}V_2\right)^{n+1}P
   \quad (\because \text{冪の定義})
\end{aligned}`,
      ),
    ],
    conversion: { status: "added" },
  },

  {
    id: "bridge_012_claim_partition_function_sector_decomposition",
    kind: "claim",
    origin: { path: SRC, ordinal: 14 },
    title: { text: "分配関数の偶奇セクター分解" },
    labels: ["partition_function_sector_decomposition"],
    statement: [
      paragraph([
        ref("partition_function_in_pauli_form"),
        " と同じ設定のもと、",
        ref("V_eq_Vprime"),
        " の",
      ]),
      displayMath(
        String.raw`V^{(\pm)} := \left(V_1^{(\pm)}\right)^{1/2} V_2 \left(V_1^{(\pm)}\right)^{1/2},
\qquad \left(V_1^{(\pm)}\right)^{1/2} := \exp\!\left(\tfrac{1}{2}iK_1H_1^{(\pm)}\right)`,
      ),
      paragraph(["について"]),
      displayMath(
        String.raw`Z(J, J')
= \mathrm{tr}\!\left(P^{(+)}\left(V^{(+)}\right)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}\left(V^{(-)}\right)^{N_{\mathrm{row}}}\right)`,
      ),
      paragraph([
        "が成り立つ。",
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(\pm)} = \tfrac12(I\pm\varepsilon)`),
        " を代入すれば",
      ]),
      displayMath(
        String.raw`Z(J,J') = \tfrac{1}{2}\Bigl(
  \mathrm{tr}\bigl((V^{(+)})^{N_{\mathrm{row}}}\bigr)
+ \mathrm{tr}\bigl(\varepsilon\,(V^{(+)})^{N_{\mathrm{row}}}\bigr)
+ \mathrm{tr}\bigl((V^{(-)})^{N_{\mathrm{row}}}\bigr)
- \mathrm{tr}\bigl(\varepsilon\,(V^{(-)})^{N_{\mathrm{row}}}\bigr)
\Bigr)`,
      ),
      paragraph([
        "とも書ける。",
        math(String.raw`V^{(\pm)}`),
        " の固有値は ",
        ref("eigenvalues_of_V"),
        " で決まっているので、これで分配関数が固有値の言葉で書けたことになる。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（トレースをセクターに分ける）。",
        ref("epsilon_projector_properties"),
        " (3) の ",
        math(String.raw`P^{(+)} + P^{(-)} = I`),
        " と ",
        ref("trace_basic_properties"),
        " (1) の線型性より、任意の ",
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(X)
&= \mathrm{tr}\!\left(IX\right)
   \quad (\because \text{単位行列の作用}) \\
&= \mathrm{tr}\!\left(\left(P^{(+)}+P^{(-)}\right)X\right)
   \quad (\because P^{(+)}+P^{(-)}=I) \\
&= \mathrm{tr}\!\left(P^{(+)}X\right) + \mathrm{tr}\!\left(P^{(-)}X\right)
   \quad (\because \text{トレースの線型性})
\end{aligned}`,
      ),
      paragraph([
        "これを ",
        ref("partition_function_in_pauli_form"),
        " の ",
        math(String.raw`X = (V_1V_2)^{N_{\mathrm{row}}}`),
        " に適用して",
      ]),
      displayMath(
        String.raw`Z(J,J')
= \mathrm{tr}\!\left(P^{(+)}(V_1V_2)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}(V_1V_2)^{N_{\mathrm{row}}}\right)
\quad (\because \text{分配関数の Pauli 表示と上のトレース分解})`,
      ),
      paragraph([
        "Step 2（各セクターで ",
        math(String.raw`V_1`),
        " を ",
        math(String.raw`V_1^{(\pm)}`),
        " に置き換える）。",
        ref("sector_replacement_pow"),
        " より（複号同順）",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(P^{(\pm)}(V_1V_2)^{N_{\mathrm{row}}}\right)
= \mathrm{tr}\!\left(P^{(\pm)}\left(V_1^{(\pm)}V_2\right)^{N_{\mathrm{row}}}\right)
\quad (\because \text{セクター内での }V_1\text{ の置換})`,
      ),
      paragraph([
        "（",
        math(String.raw`P^{(\pm)}`),
        " は ",
        math(String.raw`V_1, V_2`),
        " と可換なので ",
        math(String.raw`P^{(\pm)}(V_1V_2)^n = (V_1V_2)^nP^{(\pm)}`),
        " であり、",
        ref("sector_replacement_pow"),
        " をそのまま使える。）",
      ]),
      paragraph([
        "Step 3（対称化）。",
        math(String.raw`B := \left(V_1^{(\pm)}\right)^{1/2}`),
        " と略記する。",
        ref("theorem_exp_product"),
        " と同じ行列どうしの可換性より次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
BB
&= \exp\!\left(\tfrac12 iK_1H_1^{(\pm)}\right)
   \exp\!\left(\tfrac12 iK_1H_1^{(\pm)}\right)
   \quad (\because B\text{ の定義}) \\
&= \exp\!\left(iK_1H_1^{(\pm)}\right)
   \quad (\because \text{可換する行列の指数関数の積}) \\
&= V_1^{(\pm)}
   \quad (\because V_1^{(\pm)}\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n := N_{\mathrm{row}} \geq 1`),
        " として",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(V^{(\pm)}\right)^{n}
&= \left(B V_2 B\right)^{n}
   \quad (\because V^{(\pm)}\text{ の定義}) \\
&= B\,\underbrace{(V_2 B B)(V_2 BB)\cdots(V_2BB)}_{n-1 \text{ 個}}\,V_2\,B
   \quad (\because \text{行列積の結合法則}) \\
&= B\,\left(V_2 V_1^{(\pm)}\right)^{n-1}V_2\,B
   \quad (\because BB=V_1^{(\pm)})
\end{aligned}`,
      ),
      paragraph([
        "（結合法則で括り直し、隣接する ",
        math(String.raw`B\,B = V_1^{(\pm)}`),
        " をまとめた。）よって ",
        ref("trace_basic_properties"),
        " (2) の巡回性と、",
        ref("epsilon_projectors_commute_with_transfer_matrices"),
        " による ",
        math(String.raw`P^{(\pm)}`),
        " と ",
        math(String.raw`B`),
        " の可換性から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(P^{(\pm)}\left(V^{(\pm)}\right)^{n}\right)
&= \mathrm{tr}\!\left(P^{(\pm)}B\left(V_2V_1^{(\pm)}\right)^{n-1}V_2B\right)
   \quad (\because \text{直前の鎖で得た }\left(V^{(\pm)}\right)^{n}\text{ の表示を代入}) \\
&= \mathrm{tr}\!\left(B\,P^{(\pm)}B\left(V_2V_1^{(\pm)}\right)^{n-1}V_2\right)
   \quad (\because \text{巡回性で右端の } B \text{ を左へ}) \\
&= \mathrm{tr}\!\left(P^{(\pm)}BB\left(V_2V_1^{(\pm)}\right)^{n-1}V_2\right)
   \quad (\because P^{(\pm)} \text{ と } B \text{ は可換}) \\
&= \mathrm{tr}\!\left(P^{(\pm)}V_1^{(\pm)}\left(V_2V_1^{(\pm)}\right)^{n-1}V_2\right)
   \quad (\because BB = V_1^{(\pm)}) \\
&= \mathrm{tr}\!\left(P^{(\pm)}\left(V_1^{(\pm)}V_2\right)^{n}\right)
   \quad (\because \text{行列積の結合法則})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（結論）。Step 1〜3 を合わせて",
      ]),
      displayMath(
        String.raw`Z(J,J')
= \mathrm{tr}\!\left(P^{(+)}\left(V^{(+)}\right)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}\left(V^{(-)}\right)^{N_{\mathrm{row}}}\right)
\quad (\because \text{Step 1--3})`,
      ),
      paragraph([
        "さらに ",
        ref("def_epsilon_projectors"),
        " の射影子の定義と ",
        ref("trace_basic_properties"),
        " (1) の線型性により、次の鎖で statement の 4 項の形を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z(J,J')
&= \mathrm{tr}\!\left(\tfrac12(I+\varepsilon)\left(V^{(+)}\right)^{N_{\mathrm{row}}}\right)
 + \mathrm{tr}\!\left(\tfrac12(I-\varepsilon)\left(V^{(-)}\right)^{N_{\mathrm{row}}}\right)
   \quad (\because P^{(\pm)}=\tfrac12(I\pm\varepsilon)) \\
&= \tfrac12\Bigl(
  \mathrm{tr}\bigl((V^{(+)})^{N_{\mathrm{row}}}\bigr)
 + \mathrm{tr}\bigl(\varepsilon\,(V^{(+)})^{N_{\mathrm{row}}}\bigr)
 + \mathrm{tr}\bigl((V^{(-)})^{N_{\mathrm{row}}}\bigr)
 - \mathrm{tr}\bigl(\varepsilon\,(V^{(-)})^{N_{\mathrm{row}}}\bigr)
\Bigr)
   \quad (\because \text{トレースの線型性})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "N_row = 2,3 と M = 2,3,4、複数の (K_1,K_2) について、tr((V_1V_2)^{N_row}) と右辺のセクター和が相対誤差 2e-15 以下で一致することを確認した（sagemath/check/043_claim_transfer_matrix_bridge/check_05_sector_decomposition.sage）。",
        "この主張は docs/tasks/free-energy-roadmap の章 C（最大固有値）の直接の入口になる。eigenvalues_of_V の Λ_ε をここへ代入すればよい。",
      ],
    },
  },
]);
