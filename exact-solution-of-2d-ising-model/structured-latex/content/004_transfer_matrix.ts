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
    id: "transfer_matrix_000_definition_site_pauli_matrices",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "サイトごとの Pauli 行列族" },
    labels: ["def_site_pauli_matrices"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("pauli_matrix_products"),
        " で定めた二次の Pauli 行列 ",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z`),
        " と単位行列 ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "、および ",
        ref("def_kronecker"),
        " のクロネッカー積を用いる。",
      ]),
      paragraph([
        math(String.raw`1\leq k\leq M_{\mathrm{col}}`),
        " と ",
        math(String.raw`a\in\{x,y,z\}`),
        " に対して、サイト ",
        math(String.raw`k`),
        " だけに ",
        math(String.raw`\sigma^a`),
        " を置く行列を",
      ]),
      displayMath(
        String.raw`\sigma_k^a := I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。これにより ",
        math(String.raw`(\sigma_k^a)_{\substack{1\leq k\leq M_{\mathrm{col}}\\ a\in\{x,y,z\}}}`),
        " は一つの添字つき行列族として定まる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、サイトごとの三つの Pauli 行列を一つの添字つき行列族として分離した。旧ラベルからの後続参照は、残した複合定義が本定義を明示参照することで意味を保つ。",
      ],
    },
  },
  {
    id: "transfer_matrix_definition_site_pauli_periodic_extension",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 2 },
    title: { text: "サイトごとの Pauli 行列族の周期的な延長" },
    labels: ["def_site_pauli_periodic_extension"],
    statement: [
      paragraph([
        ref("def_site_pauli_matrices"),
        " のサイトごとの Pauli 行列族 ",
        math(String.raw`(\sigma_k^z)_{1\leq k\leq M_{\mathrm{col}}}`),
        " の添字は ",
        math(String.raw`\{1,\dots,M_{\mathrm{col}}\}`),
        " に限られ、",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z`),
        " はそのままでは定義されない。",
        ref("def_transfer_matrix"),
        " の周期規約 ",
        math(String.raw`\mu(M_{\mathrm{col}}+1):=\mu(1)`),
        " と同じく周期的に延長して",
      ]),
      displayMath(String.raw`\sigma_{M_{\mathrm{col}}+1}^z := \sigma_1^z \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。旧 <def_first_transfer_matrix_pauli> の中にあった周期規約 σ^z_{M_col+1} := σ^z_1 を独立した定義にした。",
      ],
    },
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
    id: "bridge_001_definition_config_basis",
    kind: "definition",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 3 },
    title: { text: "スピン配置から多重添字への写像" },
    labels: ["def_config_basis_iso"],
    statement: [
      paragraph([
        ref("def_row_configurations"),
        " の ",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,M_{\mathrm{col}}\},\{-1,1\})`),
        " と、",
        ref("def_end_iso"),
        " を ",
        math(String.raw`M := M_{\mathrm{col}}`),
        " として用いたときの多重添字の集合 ",
        math(String.raw`\mathcal{I} = \{1,2\}^{M_{\mathrm{col}}}`),
        "・基底 ",
        math(String.raw`f_I = e_{i_1}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}} \in \mathcal{F} = \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " を用いる。写像 ",
        math(String.raw`\iota : \mathfrak{M} \to \mathcal{I}`),
        " を",
      ]),
      displayMath(
        String.raw`\iota(\mu) := (i_1,\dots,i_{M_{\mathrm{col}}}), \qquad
i_m := \begin{cases} 1 & (\mu(m) = +1) \\ 2 & (\mu(m) = -1) \end{cases}
\qquad (m\in\{1,\dots,M_{\mathrm{col}}\})`,
      ),
      paragraph([
        "で定める。以後、スピン配置 ",
        math(String.raw`\mu\in\mathfrak{M}`),
        " に対応する ",
        math(String.raw`\mathcal{F}`),
        " の基底ベクトルを ",
        math(String.raw`f_{\iota(\mu)}`),
        " と書く。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "分配関数の転送行列の章から転送行列の章へ移した。旧版の「転送行列の定義の全単射として ι を取る（取り方に依らない）」という同一視は、" +
          "<def_transfer_matrix> が番号付け ord を明示したため不要になり削除した。ord と ι の関係は <config_numbering_equals_kronecker_numbering> で示す。",
      ],
    },
  },

  {
    id: "transfer_matrix_claim_config_numbering_equals_kronecker_numbering",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 3 },
    title: { text: "スピン配置の番号付けはクロネッカー積の番号付けと一致する" },
    labels: ["config_numbering_equals_kronecker_numbering"],
    statement: [
      paragraph([
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord}`),
        "、",
        ref("def_kronecker"),
        " を ",
        math(String.raw`M := M_{\mathrm{col}}`),
        " として用いたときの番号付け ",
        math(String.raw`\nu : \{1,2\}^{M_{\mathrm{col}}} \to \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        "、",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " について、任意の ",
        math(String.raw`\mu\in\mathfrak{M}`),
        " で",
      ]),
      displayMath(String.raw`\mathrm{ord}(\mu) = \nu(\iota(\mu))`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\iota(\mu) = (i_1,\dots,i_{M_{\mathrm{col}}})`),
        " とおく。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        math(String.raw`\mu(m)=1`),
        " なら ",
        math(String.raw`i_m-1 = 0 = \tfrac{1-\mu(m)}{2}`),
        "、",
        math(String.raw`\mu(m)=-1`),
        " なら ",
        math(String.raw`i_m-1 = 1 = \tfrac{1-\mu(m)}{2}`),
        " であるから（",
        ref("def_config_basis_iso"),
        "）、",
        math(String.raw`i_m - 1 = \tfrac{1-\mu(m)}{2}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\nu(\iota(\mu))
&= 1 + \sum_{m=1}^{M_{\mathrm{col}}} (i_m - 1)\,2^{M_{\mathrm{col}}-m}
   &&(\because \blkref{def_kronecker}\text{ の }\nu\text{ の定義}) \\
&= 1 + \sum_{m=1}^{M_{\mathrm{col}}} \frac{1-\mu(m)}{2}\cdot 2^{M_{\mathrm{col}}-m}
   &&(\because \text{各 }m\text{ で }i_m-1=\tfrac{1-\mu(m)}{2}) \\
&= \mathrm{ord}(\mu)
   &&(\because \blkref{def_row_configuration_numbering})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "成分で定義した V_1, V_2 の番号 ord(μ) と、クロネッカー積で作るパウリ行列の番号 ν(ι(μ)) が同じ番号であることを主張として置いた。",
      ],
    },
  },

  {
    id: "bridge_002_claim_sigma_z_diagonal_action",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 4 },
    title: { tex: String.raw`\sigma_m^z \text{ の基底 } f_{\iota(\mu)} \text{ への作用}` },
    labels: ["sigma_z_diagonal_action"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathfrak{M}`),
        "、",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
      ]),
      displayMath(String.raw`\sigma_m^z\, f_{\iota(\mu)} = \mu(m)\, f_{\iota(\mu)}`),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`m, m' \in \{1,\dots,M_{\mathrm{col}}\}`),
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
        ref("def_site_pauli_matrices"),
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
   \left(e_{i_1}\boxtimes\cdots\boxtimes e_{i_m}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}\right)
   \quad (\because \text{配位基底同型の定義}) \\
&= (I e_{i_1})\boxtimes\cdots\boxtimes(\sigma^z e_{i_m})\boxtimes\cdots\boxtimes(I e_{i_{M_{\mathrm{col}}}})
   \quad (\because \text{クロネッカー積の積の規則}) \\
&= e_{i_1}\boxtimes\cdots\boxtimes(\sigma^z e_{i_m})\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}
   \quad (\because \text{恒等行列の作用}) \\
&= e_{i_1}\boxtimes\cdots\boxtimes\left(\mu(m)e_{i_m}\right)\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}
   \quad (\because \sigma^z e_{i_m}=\mu(m)e_{i_m}) \\
&= \mu(m)\,\left(e_{i_1}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}\right)
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
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。分配関数の転送行列の章から転送行列の章へ移した。",
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
    id: "transfer_matrix_claim_first_transfer_matrix_pauli_form",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { tex: String.raw`V_1 \text{ のパウリ行列表示}` },
    labels: ["first_transfer_matrix_pauli_form"],
    statement: [
      paragraph([
        ref("def_transfer_matrix"),
        " で成分により定めた ",
        math(String.raw`V_1 \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（結合定数 ",
        math(String.raw`K_1\in\mathbb{R}_{>0}`),
        "）は、",
        ref("def_site_pauli_matrices"),
        " のサイトごとの Pauli 行列族と ",
        ref("def_site_pauli_periodic_extension"),
        " の周期的な延長を用いて",
      ]),
      displayMath(
        String.raw`V_1 = \exp\!\left(K_1 \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\right)
= \exp\!\left(K_1 \left(\sigma_1^z\sigma_2^z + \sigma_2^z\sigma_3^z + \cdots + \sigma_{M_{\mathrm{col}}}^z\sigma_1^z\right)\right)`,
      ),
      paragraph([
        "と表せる。ここに現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_exp"),
        " で成分級数として定めた行列の指数関数である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`D := \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " とおく。",
        ref("def_site_pauli_periodic_extension"),
        " より ",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z=\sigma_1^z`),
        " なので、周期端を分けると ",
        math(String.raw`D=\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z+\sigma_{M_{\mathrm{col}}}^z\sigma_1^z`),
        " であり、",
        ref("sigma_z_diagonal_action"),
        " を前半の和では ",
        math(String.raw`1\leq m\leq M_{\mathrm{col}}-1`),
        " の ",
        math(String.raw`(m,m+1)`),
        " に、周期端では ",
        math(String.raw`(M_{\mathrm{col}},1)`),
        " に適用できる。",
      ]),
      paragraph(["中間目標: ", math(String.raw`D`), " の対角成分。", math(String.raw`\mu \in \mathfrak{M}`), " を任意に取る。"]),
      displayMath(
        String.raw`\begin{aligned}
D\, f_{\iota(\mu)}
&= \left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z+\sigma_{M_{\mathrm{col}}}^z\sigma_1^z\right)f_{\iota(\mu)}
   &&(\because D\text{ の定義と }\blkref{def_site_pauli_periodic_extension}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left(\sigma_m^z\sigma_{m+1}^z f_{\iota(\mu)}\right)
   +\sigma_{M_{\mathrm{col}}}^z\sigma_1^z f_{\iota(\mu)}
   &&(\because \text{行列の有限和とベクトルの積の分配則}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\Bigl(\mu(m)\mu(m+1)\,f_{\iota(\mu)}\Bigr)
   +\mu(M_{\mathrm{col}})\mu(1)\,f_{\iota(\mu)}
   &&(\because \blkref{sigma_z_diagonal_action}\text{ を前半では }(m,m+1)\text{、周期端では }(M_{\mathrm{col}},1)\text{ へ}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}-1}\mu(m)\mu(m+1)+\mu(M_{\mathrm{col}})\mu(1)\right)f_{\iota(\mu)}
   &&(\because \text{スカラー倍の有限和の括り出し（分配則）}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1)\right) f_{\iota(\mu)}
   &&(\because \blkref{def_transfer_matrix}\text{ の周期規約 }\mu(M_{\mathrm{col}}+1)=\mu(1))
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        ref("sigma_z_diagonal_action"),
        " と同じく ",
        math(String.raw`D`),
        " は基底 ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " に関して対角行列であり、その ",
        math(String.raw`\iota(\mu)`),
        " 番目（行・列番号では ",
        math(String.raw`\nu(\iota(\mu))`),
        " 番目）の対角成分は ",
        math(String.raw`d(\mu) := \sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1)`),
        " である。",
        math(String.raw`K_1 D`),
        " も対角行列で、対角成分は ",
        math(String.raw`K_1 d(\mu)`),
        " である。",
      ]),
      paragraph([
        "中間目標: 成分の一致。",
        math(String.raw`\mu,\mu' \in \mathfrak{M}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\exp(K_1 D)\right)_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
&= \left(\exp(K_1 D)\right)_{\nu(\iota(\mu)),\nu(\iota(\mu'))}
  &&(\because \blkref{config_numbering_equals_kronecker_numbering}) \\
&= \begin{cases}
\exp\!\left(K_1 d(\mu)\right) & (\nu(\iota(\mu)) = \nu(\iota(\mu'))) \\
0 & (\nu(\iota(\mu)) \neq \nu(\iota(\mu')))
\end{cases}
  &&(\because \blkref{exp_of_diagonal_matrix}\text{ を対角行列 }K_1 D\text{ へ}) \\
&= \begin{cases}
\exp\!\left(K_1 d(\mu)\right) & (\mathrm{ord}(\mu) = \mathrm{ord}(\mu')) \\
0 & (\mathrm{ord}(\mu) \neq \mathrm{ord}(\mu'))
\end{cases}
  &&(\because \blkref{config_numbering_equals_kronecker_numbering}) \\
&= \delta_{\mu=\mu'}\exp\!\left(K_1\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1)\right)
  &&(\because \blkref{row_configuration_numbering_bijective}\text{ の単射性より }\mathrm{ord}(\mu)=\mathrm{ord}(\mu')\iff\mu=\mu') \\
&= (V_1)_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
  &&(\because \blkref{def_transfer_matrix})
\end{aligned}`,
      ),
      paragraph([
        ref("row_configuration_numbering_bijective"),
        " の全射性より、すべての行・列番号の組 ",
        math(String.raw`(k,l)\in\{1,\dots,2^{M_{\mathrm{col}}}\}^2`),
        " は ",
        math(String.raw`(\mathrm{ord}(\mu),\mathrm{ord}(\mu'))`),
        " の形に書ける。したがってすべての成分が一致し、",
        math(String.raw`V_1 = \exp(K_1 D)`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "旧 <def_first_transfer_matrix_pauli>（V_1 をパウリ行列で定義していたブロック）と旧 <V1_component_equals_pauli>（成分定義との一致の主張）を統合した。" +
          "証明は旧 <V1_component_equals_pauli> の証明を、成分の番号を ord で指す形に直したものである。",
        "原文の V_1 の定義は exp(√-1 K_1 (σ^z_1σ^z_2 + ⋯ + σ^z_Mσ^z_1)) と虚数単位を含んでいたが、これは誤りなので K_1 に訂正済みである。Y_m Z_{m+1} = -√-1 σ^z_mσ^z_{m+1} なので、虚数単位は Jordan--Wigner 置換から生じる。",
        "M=2,3,4 と複数の K_1 について、成分定義の V_1 とパウリ表示の V_1 が残差 0.00e+00 で一致することを確認した（sagemath/check/043_claim_transfer_matrix_bridge/check_01_V1_bridge.sage）。",
      ],
    },
  },

  {
    id: "transfer_matrix_000c_definition_jordan_wigner_Z_matrices",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { text: "Jordan–Wigner 行列族 Z_m" },
    labels: ["def_jordan_wigner_Z_matrices"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_site_pauli_matrices"),
        " で定めたサイトごとの Pauli 行列族を用いる。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " に対して、Jordan--Wigner 行列 ",
        math(String.raw`Z_m`),
        " を",
      ]),
      displayMath(
        String.raw`Z_m:=\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`m=1`),
        " では左側の積を空積とし、",
        math(String.raw`Z_1:=\sigma_1^z`),
        " とする。また周期端では ",
        math(String.raw`Z_{M_{\mathrm{col}}+1}:=Z_1`),
        " と定める。ホロノミック量子場では ",
        math(String.raw`Z_m`),
        " を ",
        math(String.raw`p_m`),
        " と書く。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、Jordan--Wigner 行列族 Z_m と周期端の規約だけを一つの定義として分離した。旧ラベルからの後続参照は、残した複合定義が本定義を明示参照することで意味を保つ。",
      ],
    },
  },
  {
    id: "transfer_matrix_000d_definition_jordan_wigner_Y_matrices",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 5 },
    title: { text: "Jordan–Wigner 行列族 Y_m" },
    labels: ["def_jordan_wigner_Y_matrices"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_site_pauli_matrices"),
        " で定めたサイトごとの Pauli 行列族を用いる。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " に対して、Jordan--Wigner 行列 ",
        math(String.raw`Y_m`),
        " を",
      ]),
      displayMath(
        String.raw`Y_m:=\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`m=1`),
        " では左側の積を空積とし、",
        math(String.raw`Y_1:=\sigma_1^y`),
        " とする。また周期端では ",
        math(String.raw`Y_{M_{\mathrm{col}}+1}:=Y_1`),
        " と定める。ホロノミック量子場では ",
        math(String.raw`Y_m`),
        " を ",
        math(String.raw`q_m`),
        " と書く。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、Jordan--Wigner 行列族 Y_m と周期端の規約だけを一つの定義として分離した。旧ラベルからの後続参照は、残した複合定義が本定義を明示参照することで意味を保つ。",
      ],
    },
  },
  {
    id: "transfer_matrix_000e_definition_global_spin_flip_matrix",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 6 },
    title: { text: "全スピン反転行列" },
    labels: ["def_global_spin_flip_matrix"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_site_pauli_matrices"),
        " で定めたサイトごとの Pauli 行列族を用いて、全スピン反転行列を",
      ]),
      displayMath(
        String.raw`\varepsilon:=\sigma_1^x\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}}^x\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。積はサイト番号の昇順に取る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、全スピン反転行列の定義だけを分離した。Jordan--Wigner 行列による表示は <global_spin_flip_jordan_wigner_representation> へ分離し、そこから本定義を明示参照している。旧ラベルからの後続参照は、残した複合定義が新しい表示主張を明示参照することで意味を保つ。",
      ],
    },
  },
  {
    id: "transfer_matrix_000f_claim_global_spin_flip_jordan_wigner_representation",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 7 },
    title: { text: "全スピン反転行列の Jordan–Wigner 表示" },
    labels: ["global_spin_flip_jordan_wigner_representation"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_jordan_wigner_Z_matrices"),
        " の ",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}}`),
        "、",
        ref("def_jordan_wigner_Y_matrices"),
        " の ",
        math(String.raw`Y_1,\dots,Y_{M_{\mathrm{col}}}`),
        "、および ",
        ref("def_global_spin_flip_matrix"),
        " の全スピン反転行列 ",
        math(String.raw`\varepsilon`),
        " について、",
      ]),
      displayMath(
        String.raw`\varepsilon=i^{M_{\mathrm{col}}}(Z_1Y_1)(Z_2Y_2)\cdots(Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}})\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "が成り立つ。右辺は ",
        math(String.raw`Z_mY_m`),
        " の積であって、和ではない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("pauli_matrix_products"),
        " の Pauli 行列の成分表示、",
        ref("mat_mult"),
        " の行列積、および ",
        ref("complex_numbers_form_a_field"),
        " の複素数の四則から、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sigma^z\sigma^y
&=\begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because\ \text{Pauli 行列の定義。}\blkref{pauli_matrix_products})\\
&=\begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&&(\because\ 2\times2\text{ 行列の積の定義。}\blkref{mat_mult})\\
&=-i\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because\ \mathbb{C}\text{ の四則})\\
&=-i\,\sigma^x
&&(\because\ \text{Pauli 行列の定義。}\blkref{pauli_matrix_products})
\end{aligned}`),
      paragraph([
        "を得る。次に任意の ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " を固定する。まず ",
        math(String.raw`r\in\{0,1,\dots,M_{\mathrm{col}}\}`),
        " に対して ",
        math(String.raw`P_r:=\sigma_1^x\cdots\sigma_r^x\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)`),
        " と置き、",
        math(String.raw`P_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}`),
        " とする。",
        ref("def_site_pauli_matrices"),
        " と ",
        ref("kronecker_product_rule"),
        " を用いる有限帰納法で、次の表示を示す。後で一因子の複素スカラーを外へ出すときは ",
        ref("kronecker_multilinear"),
        " の各因子についての線型性を用いる。",
      ]),
      displayMath(String.raw`P_r=
\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{r}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}
\qquad(0\leq r\leq M_{\mathrm{col}})`),
      paragraph(["を示す。初項では"]),
      displayMath(String.raw`\begin{aligned}
P_0
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}
&&(\because\ P_0\text{ の定義})\\
&=\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}}
&&(\because\ \text{単位因子のクロネッカー積。}\blkref{kronecker_product_rule})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`0\leq r<M_{\mathrm{col}}`),
        " で帰納法の仮定が成り立つとする。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
P_{r+1}
&=P_r\sigma_{r+1}^x
&&(\because\ P_{r+1}\text{ の定義})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{r}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}\right)\sigma_{r+1}^x
&&(\because\ \text{帰納法の仮定})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{r}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}\right)
\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{r}
\boxtimes\sigma^x\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r-1}\right)
&&(\because\ \text{サイト行列の定義。}\blkref{def_site_pauli_matrices})\\
&=\overbrace{(\sigma^xI)\boxtimes\cdots\boxtimes(\sigma^xI)}^{r}
\boxtimes(I\sigma^x)\boxtimes
\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-r-1}
&&(\because\ \text{クロネッカー積の積の規則。}\blkref{kronecker_product_rule})\\
&=\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{r+1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r-1}
&&(\because\ AI=IA=A)
\end{aligned}`),
      paragraph([
        "となる。よって有限帰納法により上の ",
        math(String.raw`P_r`),
        " の表示がすべての ",
        math(String.raw`0\leq r\leq M_{\mathrm{col}}`),
        " で成り立つ。特に ",
        ref("def_jordan_wigner_Z_matrices"),
        " と ",
        ref("def_jordan_wigner_Y_matrices"),
        " から、",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_m
&=P_{m-1}\sigma_m^z
&&(\because\ Z_m\text{ の定義。}\blkref{def_jordan_wigner_Z_matrices})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m+1}\right)\sigma_m^z
&&(\because\ P_{m-1}\text{ の表示})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m+1}\right)
\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
&&(\because\ \text{サイト行列の定義。}\blkref{def_site_pauli_matrices})\\
&=\overbrace{(\sigma^xI)\boxtimes\cdots\boxtimes(\sigma^xI)}^{m-1}
\boxtimes(I\sigma^z)\boxtimes\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-m}
&&(\because\ \text{クロネッカー積の積の規則。}\blkref{kronecker_product_rule})\\
&=\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ AI=IA=A)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Y_m
&=P_{m-1}\sigma_m^y
&&(\because\ Y_m\text{ の定義。}\blkref{def_jordan_wigner_Y_matrices})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m+1}\right)\sigma_m^y
&&(\because\ P_{m-1}\text{ の表示})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m+1}\right)
\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
&&(\because\ \text{サイト行列の定義。}\blkref{def_site_pauli_matrices})\\
&=\overbrace{(\sigma^xI)\boxtimes\cdots\boxtimes(\sigma^xI)}^{m-1}
\boxtimes(I\sigma^y)\boxtimes\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-m}
&&(\because\ \text{クロネッカー積の積の規則。}\blkref{kronecker_product_rule})\\
&=\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ AI=IA=A)
\end{aligned}`),
      paragraph(["を得る。したがって"]),
      displayMath(String.raw`\begin{aligned}
Z_mY_m
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
&&(\because\ \text{直前の }Z_m,Y_m\text{ のクロネッカー積表示})\\
&=\overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}
\boxtimes(\sigma^z\sigma^y)\boxtimes
\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-m}
&&(\because\ \text{クロネッカー積の積の規則。}\blkref{kronecker_product_rule})\\
&=\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes(\sigma^z\sigma^y)\boxtimes
\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-m}
&&(\because\ \sigma^x\sigma^x=I.\ \blkref{pauli_matrix_products})\\
&=\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes(\sigma^z\sigma^y)\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ II=I)\\
&=\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes(-i\,\sigma^x)\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ \text{上の }\sigma^z\sigma^y=-i\sigma^x)\\
&=-i\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes\sigma^x\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
&&(\because\ \text{クロネッカー積の線型性。}\blkref{kronecker_multilinear})\\
&=-i\,\sigma_m^x
&&(\because\ \text{サイト行列の定義。}\blkref{def_site_pauli_matrices})
\end{aligned}`),
      paragraph([
        math(String.raw`m=1`),
        " では先頭の ",
        math(String.raw`m-1`),
        " 因子を空積、",
        math(String.raw`m=M_{\mathrm{col}}`),
        " では末尾の ",
        math(String.raw`M_{\mathrm{col}}-m`),
        " 因子を空積と読む。ここで ",
        math(String.raw`Q_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}`),
        "、",
        math(String.raw`Q_r:=(Z_1Y_1)\cdots(Z_rY_r)\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)`),
        " と置く。",
        math(String.raw`Q_r=(-i)^rP_r`),
        " を ",
        math(String.raw`r=0,\dots,M_{\mathrm{col}}`),
        " について有限帰納法で示す。初項は",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_0
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}
&&(\because\ Q_0\text{ の定義})\\
&=(-i)^0I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}
&&(\because\ (-i)^0=1)\\
&=(-i)^0P_0
&&(\because\ P_0\text{ の定義})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`0\leq r<M_{\mathrm{col}}`),
        " で帰納法の仮定が成り立つとすると、因子を並べ替えずに",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_{r+1}
&=Q_r(Z_{r+1}Y_{r+1})
&&(\because\ Q_{r+1}\text{ の定義})\\
&=(-i)^rP_r(Z_{r+1}Y_{r+1})
&&(\because\ \text{帰納法の仮定})\\
&=(-i)^rP_r(-i\,\sigma_{r+1}^x)
&&(\because\ Z_{r+1}Y_{r+1}=-i\sigma_{r+1}^x)\\
&=(-i)^r\bigl(P_r(-i\,\sigma_{r+1}^x)\bigr)
&&(\because\ \text{左側のスカラー倍と行列積の両立})\\
&=(-i)^r\bigl((-i)(P_r\sigma_{r+1}^x)\bigr)
&&(\because\ \text{右側のスカラー倍と行列積の両立})\\
&=\bigl((-i)^r(-i)\bigr)(P_r\sigma_{r+1}^x)
&&(\because\ \text{スカラー倍の結合律})\\
&=(-i)^{r+1}P_r\sigma_{r+1}^x
&&(\because\ \text{冪の再帰})\\
&=(-i)^{r+1}P_{r+1}
&&(\because\ P_{r+1}\text{ の定義})
\end{aligned}`),
      paragraph([
        "となる。したがって有限帰納法の終端 ",
        math(String.raw`r=M_{\mathrm{col}}`),
        " で ",
        math(String.raw`Q_{M_{\mathrm{col}}}=(-i)^{M_{\mathrm{col}}}P_{M_{\mathrm{col}}}`),
        " を得る。ゆえに",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon
&=\sigma_1^x\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}}^x
&&(\because\ \text{全スピン反転行列の定義。}\blkref{def_global_spin_flip_matrix})\\
&=P_{M_{\mathrm{col}}}
&&(\because\ P_{M_{\mathrm{col}}}\text{ の定義})\\
&=1^{M_{\mathrm{col}}}P_{M_{\mathrm{col}}}
&&(\because\ 1^{M_{\mathrm{col}}}=1)\\
&=(i(-i))^{M_{\mathrm{col}}}P_{M_{\mathrm{col}}}
&&(\because\ i(-i)=1)\\
&=i^{M_{\mathrm{col}}}(-i)^{M_{\mathrm{col}}}P_{M_{\mathrm{col}}}
&&(\because\ \mathbb{C}\text{ の乗法の可換律と冪の法則})\\
&=i^{M_{\mathrm{col}}}Q_{M_{\mathrm{col}}}
&&(\because\ \text{有限帰納法の終端})\\
&=i^{M_{\mathrm{col}}}(Z_1Y_1)(Z_2Y_2)\cdots(Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}})
&&(\because\ Q_{M_{\mathrm{col}}}\text{ の定義})
\end{aligned}`),
      paragraph(["ゆえに主張が示された。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、全スピン反転行列の Jordan--Wigner 表示だけを独立した主張として分離した。各サイトの積 Z_mY_m=-i sigma_m^x と昇順の有限積を明示し、右辺が和でないことを保持した。Lean の zyPrefixProduct_eq_neg_i_pow_smul_xString と epsilon_eq_i_pow_smul_zyPrefixProduct が本文の向きの第二の有限帰納法と終端に対応し、NecSuf.prefix_eq_pow_smul_of_local_smul が同じ手順の必要十分版を担う。SageMath は同じ各行を global_spin_flip_jordan_wigner_representation で検算する。",
      ],
    },
  },
  {
    id: "transfer_matrix_000g_definition_positive_coupling_tanh",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "正の結合定数上の双曲線正接" },
    labels: ["def_positive_coupling_tanh"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の双曲線余弦・双曲線正弦を用いる。このイジング模型で用いる正の結合定数を ",
        math(String.raw`K\in\mathbb{R}_{>0}`),
        " とする。このとき",
      ]),
      displayMath(String.raw`\tanh K:=\frac{\sinh K}{\cosh K}\in\{y\in\mathbb{R}\mid 0<y<1\}`),
      paragraph(["と定める。右辺が指定した集合の元になることを以下で確認する。"]),
    ],
    proof: [
      paragraph([ref("cosh_sinh_basic_properties"), " の (3) を次の行で用いる。"]),
      displayMath(String.raw`\begin{aligned}
\cosh K&>\sinh K>0
&&(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (3)})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh K>0
&\Longrightarrow \cosh K\ne0
&&(\because\ \mathbb{R}\text{ の正の元は零でない})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K\in\mathbb{R}_{>0}
&\Longrightarrow K\in\mathbb{R}
&&(\because\ \mathbb{R}_{>0}\subset\mathbb{R})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K\in\mathbb{R}
&\Longrightarrow \sinh K,\cosh K\in\mathbb{R}
&&(\because\ \blkref{def_cosh_sinh})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh K,\cosh K\in\mathbb{R}\ \land\ \cosh K\ne0
&\Longrightarrow \frac{\sinh K}{\cosh K}\in\mathbb{R}
&&(\because\ \mathbb{R}\text{ の零でない元による除法の閉性})
\end{aligned}`),
      paragraph(["定義した実数の商の正値性は"]),
      displayMath(String.raw`\begin{aligned}
\tanh K
&=\frac{\sinh K}{\cosh K}
&&(\because\ \tanh\ \text{の定義})\\
&>0
&&(\because\ \sinh K>0\ \text{かつ}\ \cosh K>0)
\end{aligned}`),
      paragraph(["上側の評価は"]),
      displayMath(String.raw`\begin{aligned}
\tanh K
&=\frac{\sinh K}{\cosh K}
&&(\because\ \tanh\ \text{の定義})\\
&<\frac{\cosh K}{\cosh K}
&&(\because\ \sinh K<\cosh K\ \text{かつ}\ \cosh K>0)\\
&=1
&&(\because\ \cosh K\ne0)
\end{aligned}`),
      paragraph([
        "である。以上より ",
        math(String.raw`\tanh K\in\{y\in\mathbb{R}\mid 0<y<1\}`),
        " であり、定義可能性が確認できた。この項は実数の指数関数から定めた双曲線関数を正の実数上で割るため、有限な複素行列計算から実数解析へ移る先行定義である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "第一の双対結合定数を定める前提として、このイジング模型で用いる正の結合定数に対する双曲線正接を、値域を余域へ含めた一つの定義として独立させた。数学的道具立ての既存分類・節境界は変更していない。",
      ],
    },
  },
  {
    id: "transfer_matrix_000h_definition_real_logarithm_positive",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "正の実数上の実対数" },
    labels: ["def_real_logarithm_positive"],
    statement: [
      paragraph([
        ref("def_scalar_exp"),
        " の実数の exp を考える。",
        ref("real_exp_positive"),
        " と ",
        ref("real_exp_strictly_increasing"),
        " より、",
        math(String.raw`\exp:\mathbb{R}\longrightarrow\mathbb{R}_{>0}`),
        " は狭義単調増加な単射である。全射であることは実解析の標準的な事実（連続性と中間値の定理）として用いる。その逆写像を正の実数上の実対数と呼び、",
      ]),
      displayMath(String.raw`\log:\mathbb{R}_{>0}\longrightarrow\mathbb{R}`),
      paragraph([
        "と書く。したがって、任意の ",
        math(String.raw`y\in\mathbb{R}_{>0}`),
        " と ",
        math(String.raw`x\in\mathbb{R}`),
        " に対して",
      ]),
      displayMath(String.raw`\exp(\log y)=y,\qquad \log(\exp x)=x`),
      paragraph([
        "が成り立つ。狭義単調増加な全単射の逆写像も狭義単調増加なので、",
      ]),
      displayMath(String.raw`0<u<v\Longrightarrow\log u<\log v\qquad(u,v\in\mathbb{R}_{>0})`),
      paragraph([
        "である。とくに、",
        math(String.raw`y\in\mathbb{R}`),
        " が ",
        math(String.raw`0<y<1`),
        " を満たすならば ",
        math(String.raw`\log y<0`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y\in\mathbb{R}`),
        " かつ ",
        math(String.raw`0<y<1`),
        " とする。まず、",
      ]),
      displayMath(String.raw`\begin{aligned}
0<y
&\Longrightarrow y\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
1>0
&\Longrightarrow 1\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
y\in\mathbb{R}_{>0}
&\Longrightarrow \log y\in\mathbb{R}
&&\left(\because\ \log:\mathbb{R}_{>0}\to\mathbb{R}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
1\in\mathbb{R}_{>0}
&\Longrightarrow \log 1\in\mathbb{R}
&&\left(\because\ \log:\mathbb{R}_{>0}\to\mathbb{R}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<y<1
&\Longrightarrow \log y<\log 1
&&\left(\because\ \log\text{ は狭義単調増加}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp 0&=1
&&\left(\because\ \blkref{scalar_exp_zero}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp 0=1
&\Longrightarrow \log 1=\log(\exp 0)
&&\left(\because\ \exp 0=1\text{ による左辺の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\log(\exp 0)&=0
&&\left(\because\ \log\text{ は }\exp\text{ の逆写像}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\log 1=\log(\exp 0)\ \land\ \log(\exp 0)=0
&\Longrightarrow \log 1=0
&&\left(\because\ \mathbb{R}\text{ の等号の推移律}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\log y<\log 1\ \land\ \log 1=0
&\Longrightarrow \log y<0
&&\left(\because\ \text{等しい実数による右辺の置換}\right)
\end{aligned}`),
      paragraph([
        "ゆえに ",
        math(String.raw`0<y<1`),
        " ならば ",
        math(String.raw`\log y<0`),
        " である。（実対数による ",
        math(String.raw`\mathbb R`),
        " 脱出）この項は実数指数関数の全単射性、実対数、および実数の順序を用いるため、有限な複素行列計算から実数解析へ移る先行定義である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "第一の双対結合定数を定める前提として、正の実数上の実対数と、0<y<1 なら log y<0 となる符号性を一つの独立定義として置いた。数学的道具立ての既存分類・節境界は変更していない。",
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
    id: "transfer_matrix_000i_definition_first_dual_coupling_constant",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "第一の双対結合定数" },
    labels: ["def_first_dual_coupling_constant"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の正の結合定数 ",
        math(String.raw`K_1\in\mathbb{R}_{>0}`),
        " をとる。",
        ref("def_positive_coupling_tanh"),
        " の双曲線正接と ",
        ref("def_real_logarithm_positive"),
        " の実対数を用いて、第一の双対結合定数を",
      ]),
      displayMath(String.raw`K_1^*:=-\frac{1}{2}\log(\tanh K_1)\in\mathbb{R}_{>0}`),
      paragraph(["と定める。右辺の定義可能性と正値性を以下で確認する。"]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）この証明では、実数値の双曲線正接と実対数、および実数の順序を用いる。以下の各量の所属と符号を一段ずつ確認する。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_1\in\mathbb{R}_{>0}
&\Longrightarrow 0<\tanh K_1<1
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_1
&\Longrightarrow \tanh K_1\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tanh K_1\in\mathbb{R}_{>0}
&\Longrightarrow \log(\tanh K_1)\in\mathbb{R}
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log:\mathbb{R}_{>0}\to\mathbb{R}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_1<1
&\Longrightarrow \log(\tanh K_1)<0
&&\left(\because\ \blkref{def_real_logarithm_positive}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}&\in\mathbb{R}
&&\left(\because\ \mathbb{R}\text{ は体であり、逆元と符号反転について閉じている}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}&<0
&&\left(\because\ \mathbb{R}\text{ の分数の大小}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}\in\mathbb{R}\ \land\ \log(\tanh K_1)\in\mathbb{R}
&\Longrightarrow -\frac{1}{2}\log(\tanh K_1)\in\mathbb{R}
&&\left(\because\ \mathbb{R}\text{ の乗法についての閉性}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}<0\ \land\ \log(\tanh K_1)<0
&\Longrightarrow -\frac{1}{2}\log(\tanh K_1)>0
&&\left(\because\ \text{負の実数二つの積は正である}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1^*&=-\frac{1}{2}\log(\tanh K_1)
&&\left(\because\ K_1^*\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1^*=-\frac{1}{2}\log(\tanh K_1)\ \land\ -\frac{1}{2}\log(\tanh K_1)\in\mathbb{R}
&\Longrightarrow K_1^*\in\mathbb{R}
&&\left(\because\ \text{等しい対象による所属の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1^*=-\frac{1}{2}\log(\tanh K_1)\ \land\ -\frac{1}{2}\log(\tanh K_1)>0
&\Longrightarrow K_1^*>0
&&\left(\because\ \text{等しい実数による左辺の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1^*\in\mathbb{R}\ \land\ K_1^*>0
&\Longrightarrow K_1^*\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      paragraph(["以上により、第一の双対結合定数は正の実数として定まる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、第一の双対結合定数の定義と正値性だけを独立させた。二つの双対関係、第二の双対結合定数、双曲線関数の略記、およびそれらの正値性には進んでいない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照先を分配関数の定義の結合定数にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_000j_claim_first_dual_coupling_relation",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "第一の結合定数と双対結合定数の双対関係" },
    labels: ["first_dual_coupling_relation"],
    statement: [
      paragraph([
        ref("def_first_dual_coupling_constant"),
        " の ",
        math(String.raw`K_1,K_1^*\in\mathbb{R}_{>0}`),
        " に対して、",
      ]),
      displayMath(String.raw`\sinh(2K_1)\sinh(2K_1^*)=1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）この証明では、",
        ref("def_positive_coupling_tanh"),
        " の実数値の双曲線正接、",
        ref("def_real_logarithm_positive"),
        " の実対数、",
        ref("def_cosh_sinh"),
        " の双曲線関数の定義、および ",
        ref("cosh_sinh_basic_properties"),
        " の実双曲線関数の基本性質を用いる。まず、各分母が零でないことを確認する。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_1\in\mathbb{R}_{>0}
&\Longrightarrow \cosh K_1>\sinh K_1>0
&&\left(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (3)}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh K_1>\sinh K_1>0
&\Longrightarrow \sinh K_1\ne0\ \land\ \cosh K_1\ne0
&&\left(\because\ \mathbb{R}\text{ の正の元は零でない}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh K_1\ne0\ \land\ \cosh K_1\ne0
&\Longrightarrow \sinh K_1\cosh K_1\ne0
&&\left(\because\ \mathbb{R}\text{ は体である}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1\in\mathbb{R}_{>0}
&\Longrightarrow 0<\tanh K_1<1
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_1
&\Longrightarrow \tanh K_1\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tanh K_1\in\mathbb{R}_{>0}
&\Longrightarrow \tanh K_1\ne0
&&\left(\because\ \mathbb{R}\text{ の正の元は零でない}\right)
\end{aligned}`),
      paragraph(["双対結合定数の定義を指数関数へ戻すと、"]),
      displayMath(String.raw`\begin{aligned}
K_1^*&=-\frac12\log(\tanh K_1)
&&\left(\because\ \blkref{def_first_dual_coupling_constant}\right)\\
2K_1^*&=-\log(\tanh K_1)
&&\left(\because\ \mathbb{R}\text{ の等式の両辺を }2\text{ 倍}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
&\exp\!\left(-\log(\tanh K_1)\right)\exp\!\left(\log(\tanh K_1)\right)\\
&\qquad=\exp\!\left(-\log(\tanh K_1)+\log(\tanh K_1)\right)
&&\left(\because\ \exp(x)\exp(y)=\exp(x+y)\ \blkref{scalar_exp_product}\right)\\
&\qquad=\exp(0)
&&\left(\because\ \mathbb{R}\text{ の加法逆元}\right)\\
&\qquad=1
&&\left(\because\ \exp(0)=1\ \blkref{scalar_exp_zero}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(-\log(\tanh K_1)\right)\tanh K_1
&=1
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)\\
\exp\!\left(-\log(\tanh K_1)\right)
&=\frac1{\tanh K_1}
&&\left(\because\ \tanh K_1\ne0\text{ と }\mathbb{R}\text{ の除法}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp(2K_1^*)
&=\exp\!\left(-\log(\tanh K_1)\right)
&&\left(\because\ 2K_1^*=-\log(\tanh K_1)\right)\\
&=\frac{1}{\tanh K_1}
&&\left(\because\ \text{直前の等式}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-2K_1^*&=\log(\tanh K_1)
&&\left(\because\ 2K_1^*=-\log(\tanh K_1)\text{ の両辺を符号反転}\right)\\
\exp(-2K_1^*)&=\exp(\log(\tanh K_1))
&&\left(\because\ \text{等しい実数への指数関数の適用}\right)\\
&=\tanh K_1
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh(2K_1^*)
&=\frac{\exp(2K_1^*)-\exp(-2K_1^*)}{2}
&&\left(\because\ \blkref{def_cosh_sinh}\right)\\
&=\frac{\frac1{\tanh K_1}-\exp(-2K_1^*)}{2}
&&\left(\because\ \exp(2K_1^*)=\frac1{\tanh K_1}\right)\\
&=\frac{\frac1{\tanh K_1}-\tanh K_1}{2}
&&\left(\because\ \exp(-2K_1^*)=\tanh K_1\right)\\
&=\frac12\left(\frac1{\tanh K_1}-\tanh K_1\right)
&&\left(\because\ \mathbb{R}\text{ の分配法則}\right)
\end{aligned}`),
      paragraph(["一方、倍角の双曲線正弦は定義から"]),
      displayMath(String.raw`\begin{aligned}
2\sinh K_1\cosh K_1
&=2\frac{\exp(K_1)-\exp(-K_1)}2\frac{\exp(K_1)+\exp(-K_1)}2
&&\left(\because\ \blkref{def_cosh_sinh}\right)\\
&=\frac12\left(\exp(K_1)-\exp(-K_1)\right)\left(\exp(K_1)+\exp(-K_1)\right)
&&\left(\because\ 2\cdot\frac12\cdot\frac12=\frac12\right)\\
&=\frac{\exp(K_1)^2-\exp(-K_1)^2}{2}
&&\left(\because\ (a-b)(a+b)=a^2-b^2\right)\\
&=\frac{\exp(2K_1)-\exp(-2K_1)}2
&&\left(\because\ \exp(x)\exp(y)=\exp(x+y)\ \blkref{scalar_exp_product}\right)\\
&=\sinh(2K_1)
&&\left(\because\ \blkref{def_cosh_sinh}\right)
\end{aligned}`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\begin{aligned}
\sinh(2K_1)\sinh(2K_1^*)
&=2\sinh K_1\cosh K_1\sinh(2K_1^*)
&&\left(\because\ \sinh(2K_1)=2\sinh K_1\cosh K_1\right)\\
&=2\sinh K_1\cosh K_1\cdot\frac12\left(\frac1{\tanh K_1}-\tanh K_1\right)
&&\left(\because\ \sinh(2K_1^*)=\frac12\left(\frac1{\tanh K_1}-\tanh K_1\right)\right)\\
&=\sinh K_1\cosh K_1\left(\frac1{\tanh K_1}-\tanh K_1\right)
&&\left(\because\ 2\cdot\frac12=1\right)\\
&=\sinh K_1\cosh K_1\left(\frac1{\sinh K_1/\cosh K_1}-\frac{\sinh K_1}{\cosh K_1}\right)
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)\\
&=\sinh K_1\cosh K_1\left(\frac{\cosh K_1}{\sinh K_1}-\frac{\sinh K_1}{\cosh K_1}\right)
&&\left(\because\ \sinh K_1\ne0\ \land\ \cosh K_1\ne0\right)\\
&=\sinh K_1\cosh K_1\frac{(\cosh K_1)^2-(\sinh K_1)^2}{\sinh K_1\cosh K_1}
&&\left(\because\ \mathbb{R}\text{ の分数の通分}\right)\\
&=(\cosh K_1)^2-(\sinh K_1)^2
&&\left(\because\ \sinh K_1\cosh K_1\ne0\right)\\
&=1
&&\left(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (2)}\right)
\end{aligned}`),
      paragraph(["ゆえに第一の結合定数と双対結合定数の双対関係が示された。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "残余複合定義から第一の双対関係だけを独立した主張として分離した。第一の双対結合定数、双曲線正接、実対数、および双曲線関数の基本性質を先行入力とし、指数関数へ戻す計算から双対関係を一段ずつ示した。第二の双対結合定数、第二の双対関係、双曲線関数の略記、および残る正値性には進んでいない。",
      ],
    },
  },
  {
    id: "transfer_matrix_000k_definition_second_dual_coupling_constant",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "第二の双対結合定数" },
    labels: ["def_second_dual_coupling_constant"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の正の結合定数 ",
        math(String.raw`K_2\in\mathbb{R}_{>0}`),
        " をとる。",
        ref("def_positive_coupling_tanh"),
        " の双曲線正接と ",
        ref("def_real_logarithm_positive"),
        " の実対数を用いて、第二の双対結合定数を",
      ]),
      displayMath(String.raw`K_2^*:=-\frac{1}{2}\log(\tanh K_2)\in\mathbb{R}_{>0}`),
      paragraph(["と定める。右辺の定義可能性と正値性を以下で確認する。"]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）この証明では、実数値の双曲線正接と実対数、および実数の順序を用いる。以下の各量の所属と符号を一段ずつ確認する。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_2\in\mathbb{R}_{>0}
&\Longrightarrow 0<\tanh K_2<1
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_2
&\Longrightarrow \tanh K_2\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tanh K_2\in\mathbb{R}_{>0}
&\Longrightarrow \log(\tanh K_2)\in\mathbb{R}
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log:\mathbb{R}_{>0}\to\mathbb{R}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_2<1
&\Longrightarrow \log(\tanh K_2)<0
&&\left(\because\ \blkref{def_real_logarithm_positive}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}&\in\mathbb{R}
&&\left(\because\ \mathbb{R}\text{ は体であり、逆元と符号反転について閉じている}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}&<0
&&\left(\because\ \mathbb{R}\text{ の分数の大小}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}\in\mathbb{R}\ \land\ \log(\tanh K_2)\in\mathbb{R}
&\Longrightarrow -\frac{1}{2}\log(\tanh K_2)\in\mathbb{R}
&&\left(\because\ \mathbb{R}\text{ の乗法についての閉性}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}<0\ \land\ \log(\tanh K_2)<0
&\Longrightarrow -\frac{1}{2}\log(\tanh K_2)>0
&&\left(\because\ \text{負の実数二つの積は正である}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2^*&=-\frac{1}{2}\log(\tanh K_2)
&&\left(\because\ K_2^*\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2^*=-\frac{1}{2}\log(\tanh K_2)\ \land\ -\frac{1}{2}\log(\tanh K_2)\in\mathbb{R}
&\Longrightarrow K_2^*\in\mathbb{R}
&&\left(\because\ \text{等しい対象による所属の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2^*=-\frac{1}{2}\log(\tanh K_2)\ \land\ -\frac{1}{2}\log(\tanh K_2)>0
&\Longrightarrow K_2^*>0
&&\left(\because\ \text{等しい実数による左辺の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2^*\in\mathbb{R}\ \land\ K_2^*>0
&\Longrightarrow K_2^*\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      paragraph(["以上により、第二の双対結合定数は正の実数として定まる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、第二の双対結合定数の定義と正値性だけを独立させた。第二の双対関係、双曲線関数の略記、およびそれらの正値性には進んでいない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照先を分配関数の定義の結合定数にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_000l_claim_second_dual_coupling_relation",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "第二の結合定数と双対結合定数の双対関係" },
    labels: ["second_dual_coupling_relation"],
    statement: [
      paragraph([
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2,K_2^*\in\mathbb{R}_{>0}`),
        " に対して、",
      ]),
      displayMath(String.raw`\sinh(2K_2)\sinh(2K_2^*)=1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）この証明では、",
        ref("def_positive_coupling_tanh"),
        " の実数値の双曲線正接、",
        ref("def_real_logarithm_positive"),
        " の実対数、",
        ref("def_cosh_sinh"),
        " の双曲線関数の定義、および ",
        ref("cosh_sinh_basic_properties"),
        " の実双曲線関数の基本性質を用いる。まず、各分母が零でないことを確認する。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_2\in\mathbb{R}_{>0}
&\Longrightarrow \cosh K_2>\sinh K_2>0
&&\left(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (3)}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh K_2>\sinh K_2>0
&\Longrightarrow \sinh K_2\ne0\ \land\ \cosh K_2\ne0
&&\left(\because\ \mathbb{R}\text{ の正の元は零でない}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh K_2\ne0\ \land\ \cosh K_2\ne0
&\Longrightarrow \sinh K_2\cosh K_2\ne0
&&\left(\because\ \mathbb{R}\text{ は体である}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2\in\mathbb{R}_{>0}
&\Longrightarrow 0<\tanh K_2<1
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_2
&\Longrightarrow \tanh K_2\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tanh K_2\in\mathbb{R}_{>0}
&\Longrightarrow \tanh K_2\ne0
&&\left(\because\ \mathbb{R}\text{ の正の元は零でない}\right)
\end{aligned}`),
      paragraph(["双対結合定数の定義を指数関数へ戻すと、"]),
      displayMath(String.raw`\begin{aligned}
K_2^*&=-\frac12\log(\tanh K_2)
&&\left(\because\ \blkref{def_second_dual_coupling_constant}\right)\\
2K_2^*&=-\log(\tanh K_2)
&&\left(\because\ \mathbb{R}\text{ の等式の両辺を }2\text{ 倍}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
&\exp\!\left(-\log(\tanh K_2)\right)\exp\!\left(\log(\tanh K_2)\right)\\
&\qquad=\exp\!\left(-\log(\tanh K_2)+\log(\tanh K_2)\right)
&&\left(\because\ \exp(x)\exp(y)=\exp(x+y)\ \blkref{scalar_exp_product}\right)\\
&\qquad=\exp(0)
&&\left(\because\ \mathbb{R}\text{ の加法逆元}\right)\\
&\qquad=1
&&\left(\because\ \exp(0)=1\ \blkref{scalar_exp_zero}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(-\log(\tanh K_2)\right)\tanh K_2
&=1
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)\\
\exp\!\left(-\log(\tanh K_2)\right)
&=\frac1{\tanh K_2}
&&\left(\because\ \tanh K_2\ne0\text{ と }\mathbb{R}\text{ の除法}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp(2K_2^*)
&=\exp\!\left(-\log(\tanh K_2)\right)
&&\left(\because\ 2K_2^*=-\log(\tanh K_2)\right)\\
&=\frac{1}{\tanh K_2}
&&\left(\because\ \text{直前の等式}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-2K_2^*&=\log(\tanh K_2)
&&\left(\because\ 2K_2^*=-\log(\tanh K_2)\text{ の両辺を符号反転}\right)\\
\exp(-2K_2^*)&=\exp(\log(\tanh K_2))
&&\left(\because\ \text{等しい実数への指数関数の適用}\right)\\
&=\tanh K_2
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh(2K_2^*)
&=\frac{\exp(2K_2^*)-\exp(-2K_2^*)}{2}
&&\left(\because\ \blkref{def_cosh_sinh}\right)\\
&=\frac{\frac1{\tanh K_2}-\exp(-2K_2^*)}{2}
&&\left(\because\ \exp(2K_2^*)=\frac1{\tanh K_2}\right)\\
&=\frac{\frac1{\tanh K_2}-\tanh K_2}{2}
&&\left(\because\ \exp(-2K_2^*)=\tanh K_2\right)\\
&=\frac12\left(\frac1{\tanh K_2}-\tanh K_2\right)
&&\left(\because\ \mathbb{R}\text{ の分配法則}\right)
\end{aligned}`),
      paragraph(["一方、倍角の双曲線正弦は定義から"]),
      displayMath(String.raw`\begin{aligned}
2\sinh K_2\cosh K_2
&=2\frac{\exp(K_2)-\exp(-K_2)}2\frac{\exp(K_2)+\exp(-K_2)}2
&&\left(\because\ \blkref{def_cosh_sinh}\right)\\
&=\frac12\left(\exp(K_2)-\exp(-K_2)\right)\left(\exp(K_2)+\exp(-K_2)\right)
&&\left(\because\ 2\cdot\frac12\cdot\frac12=\frac12\right)\\
&=\frac{\exp(K_2)^2-\exp(-K_2)^2}{2}
&&\left(\because\ (a-b)(a+b)=a^2-b^2\right)\\
&=\frac{\exp(2K_2)-\exp(-2K_2)}2
&&\left(\because\ \exp(x)\exp(y)=\exp(x+y)\ \blkref{scalar_exp_product}\right)\\
&=\sinh(2K_2)
&&\left(\because\ \blkref{def_cosh_sinh}\right)
\end{aligned}`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\begin{aligned}
\sinh(2K_2)\sinh(2K_2^*)
&=2\sinh K_2\cosh K_2\sinh(2K_2^*)
&&\left(\because\ \sinh(2K_2)=2\sinh K_2\cosh K_2\right)\\
&=2\sinh K_2\cosh K_2\cdot\frac12\left(\frac1{\tanh K_2}-\tanh K_2\right)
&&\left(\because\ \sinh(2K_2^*)=\frac12\left(\frac1{\tanh K_2}-\tanh K_2\right)\right)\\
&=\sinh K_2\cosh K_2\left(\frac1{\tanh K_2}-\tanh K_2\right)
&&\left(\because\ 2\cdot\frac12=1\right)\\
&=\sinh K_2\cosh K_2\left(\frac1{\sinh K_2/\cosh K_2}-\frac{\sinh K_2}{\cosh K_2}\right)
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)\\
&=\sinh K_2\cosh K_2\left(\frac{\cosh K_2}{\sinh K_2}-\frac{\sinh K_2}{\cosh K_2}\right)
&&\left(\because\ \sinh K_2\ne0\ \land\ \cosh K_2\ne0\right)\\
&=\sinh K_2\cosh K_2\frac{(\cosh K_2)^2-(\sinh K_2)^2}{\sinh K_2\cosh K_2}
&&\left(\because\ \mathbb{R}\text{ の分数の通分}\right)\\
&=(\cosh K_2)^2-(\sinh K_2)^2
&&\left(\because\ \sinh K_2\cosh K_2\ne0\right)\\
&=1
&&\left(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (2)}\right)
\end{aligned}`),
      paragraph(["ゆえに第二の結合定数と双対結合定数の双対関係が示された。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "残余複合定義から第二の双対関係だけを独立した主張として分離した。第二の双対結合定数、双曲線正接、実対数、および双曲線関数の基本性質を先行入力とし、指数関数へ戻す計算から双対関係を一段ずつ示した。双曲線関数の略記と残る正値性には進んでいない。",
      ],
    },
  },
  {
    id: "transfer_matrix_000m_definition_indexed_hyperbolic_abbreviations",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/000_definition_転送行列の記号の定義.typ", ordinal: 1 },
    title: { text: "双曲線関数の添字つき略記" },
    labels: ["def_indexed_hyperbolic_abbreviations"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の正の結合定数 ",
        math(String.raw`K_1,K_2\in\mathbb{R}_{>0}`),
        "、および ",
        ref("def_first_dual_coupling_constant"),
        " と ",
        ref("def_second_dual_coupling_constant"),
        " で定めた双対結合定数 ",
        math(String.raw`K_1^*,K_2^*`),
        " に対し、各 ",
        math(String.raw`i\in\{1,2\}`),
        " について次の略記を定める。",
      ]),
      list([
        [
          math(String.raw`c_i := \cosh 2K_i,\quad s_i := \sinh 2K_i,\quad c_i^* := \cosh 2K_i^*,\quad s_i^* := \sinh 2K_i^*`),
        ],
      ]),
      paragraph([
        "右辺の双曲線余弦と双曲線正弦は ",
        ref("def_cosh_sinh"),
        " で定めた実数値関数である。したがって各 ",
        math(String.raw`i\in\{1,2\}`),
        " について ",
        math(String.raw`c_i,s_i,c_i^*,s_i^*\in\mathbb{R}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "残余複合定義から双曲線関数の添字つき略記だけを独立した定義へ分離した。略記の正値性は <indexed_hyperbolic_abbreviations_positive> へ分離した。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照先を分配関数の定義の結合定数にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_000n_claim_indexed_hyperbolic_abbreviations_positive",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/000_definition_転送行列の記号の定義.typ", ordinal: 1 },
    title: { text: "双曲線関数の添字つき略記の正値性" },
    labels: ["indexed_hyperbolic_abbreviations_positive"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`i\in\{1,2\}`),
        " について、",
        math(String.raw`K_i,K_i^*\in\mathbb{R}_{>0}`),
        " ならば、",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の略記は ",
        math(String.raw`c_i,s_i,c_i^*,s_i^*\in\mathbb{R}`),
        " であり、",
      ]),
      displayMath(String.raw`c_i>0,\qquad s_i>0,\qquad c_i^*>0,\qquad s_i^*>0`),
      paragraph(["を満たす。"]),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`i\in\{1,2\}`),
        " を固定する。（実双曲線関数の評価と実数順序による実数への脱出）ここでは ",
        math(String.raw`K_i,K_i^*\in\mathbb{R}_{>0}`),
        " を実双曲線関数へ入力し、実数の順序で値を比較する。したがって、以下は実双曲線関数の評価と実数順序を用いる実数上の主張である。",
      ]),
      displayMath(String.raw`\begin{aligned}
2K_i&>0
&&\bigl(\because 2>0,\ K_i>0,\ \text{正数の積}\bigr),\\
2K_i^*&>0
&&\bigl(\because 2>0,\ K_i^*>0,\ \text{正数の積}\bigr).
\end{aligned}`),
      paragraph([
        ref("cosh_sinh_basic_properties"),
        " の (3) を二つの正の引数へ適用する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cosh(2K_i)&>\sinh(2K_i)>0
&&\bigl(\because \blkref{cosh_sinh_basic_properties}\text{ の (3) と }2K_i>0\bigr),\\
\cosh(2K_i^*)&>\sinh(2K_i^*)>0
&&\bigl(\because \blkref{cosh_sinh_basic_properties}\text{ の (3) と }2K_i^*>0\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
c_i&>s_i>0
&&\bigl(\because \blkref{def_indexed_hyperbolic_abbreviations}\text{ の定義で上の第 1 式を書き換えた}\bigr),\\
c_i^*&>s_i^*>0
&&\bigl(\because \blkref{def_indexed_hyperbolic_abbreviations}\text{ の定義で上の第 2 式を書き換えた}\bigr),\\
s_i&>0
&&\bigl(\because c_i>s_i>0\text{ の後半}\bigr),\\
s_i^*&>0
&&\bigl(\because c_i^*>s_i^*>0\text{ の後半}\bigr),\\
c_i&>0
&&\bigl(\because c_i>s_i\text{ と }s_i>0\text{ の推移律}\bigr),\\
c_i^*&>0
&&\bigl(\because c_i^*>s_i^*\text{ と }s_i^*>0\text{ の推移律}\bigr).
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "残余複合定義から、添字つき略記の正値性だけを独立した主張へ分離した。実数の順序を用いる実数への脱出であるため、双曲線関数の基本性質を入力として正値性を一段ずつ示した。",
      ],
    },
  },
  {
    id: "bridge_005_claim_two_by_two_transfer_identity",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 7 },
    title: { tex: String.raw`2\times 2 \text{ の転送行列の恒等式}` },
    labels: ["two_by_two_transfer_identity"],
    statement: [
      paragraph([
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^* = -\tfrac{1}{2}\log(\tanh K_2)`),
        "、",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の ",
        math(String.raw`s_2 = \sinh 2K_2`),
        " を用いる。",
        math(String.raw`A \in \mathrm{Mat}(2,\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`A := \begin{pmatrix} \exp(K_2) & \exp(-K_2) \\ \exp(-K_2) & \exp(K_2) \end{pmatrix}`,
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
        "中間目標: ",
        math(String.raw`\exp(t\sigma^x)`),
        " の閉じた形。",
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
        String.raw`(2s_2)^{1/2}\cosh K_2^* = \exp(K_2), \qquad
(2s_2)^{1/2}\sinh K_2^* = \exp(-K_2)`,
      ),
      paragraph([
        "中間目標: ",
        math(String.raw`\cosh K_2^*, \sinh K_2^*`),
        " を ",
        math(String.raw`K_2`),
        " で書く。",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^* = -\tfrac12\log(\tanh K_2)`),
        " より ",
        math(String.raw`\log(\tanh K_2) = -2K_2^*`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-2K_2^*)
&= \exp(\log(\tanh K_2))
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
\exp(-K_2^*)
&= \left(\exp(-2K_2^*)\right)^{1/2}
   \quad (\because \text{指数法則 } \exp(-2K_2^*) = (\exp(-K_2^*))^2 \text{ と } \exp(-K_2^*) > 0 \text{ の正の平方根}) \\
&= t^{1/2}
   \quad (\because \exp(-2K_2^*) = t),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(K_2^*)
&= \frac{1}{\exp(-K_2^*)}
   \quad (\because \text{指数法則 } \exp(K_2^*)\exp(-K_2^*) = 1) \\
&= \frac{1}{t^{1/2}}
   \quad (\because \exp(-K_2^*) = t^{1/2}) \\
&= t^{-1/2}
   \quad (\because \text{負冪の定義 } t^{-1/2} = 1/t^{1/2})
\end{aligned}`,
      ),
      paragraph(["である。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\cosh K_2^*
&= \frac{\exp(K_2^*) + \exp(-K_2^*)}{2}
   \quad (\because \cosh \text{ の定義 } \cosh x = \tfrac{\exp(x)+\exp(-x)}{2}) \\
&= \frac{t^{-1/2} + t^{1/2}}{2}
   \quad (\because \exp(K_2^*) = t^{-1/2},\ \exp(-K_2^*) = t^{1/2}) \\
&= \frac{1+t}{2\,t^{1/2}}
   \quad (\because \text{分子・分母に } t^{1/2} \text{ を掛ける}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh K_2^*
&= \frac{\exp(K_2^*) - \exp(-K_2^*)}{2}
   \quad (\because \sinh \text{ の定義 } \sinh x = \tfrac{\exp(x)-\exp(-x)}{2}) \\
&= \frac{t^{-1/2} - t^{1/2}}{2}
   \quad (\because \exp(K_2^*) = t^{-1/2},\ \exp(-K_2^*) = t^{1/2}) \\
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
&= \frac{\exp(K_2)}{\cosh K_2}
   \quad (\because \cosh x + \sinh x = \exp(x)),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
1 - t
&= 1 - \frac{\sinh K_2}{\cosh K_2}
   \quad (\because t = \tanh K_2 = \tfrac{\sinh K_2}{\cosh K_2}) \\
&= \frac{\cosh K_2 - \sinh K_2}{\cosh K_2}
   \quad (\because \text{通分}) \\
&= \frac{\exp(-K_2)}{\cosh K_2}
   \quad (\because \cosh x - \sinh x = \exp(-x)).
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\cosh x \pm \sinh x = \exp(\pm x)`),
        " は ",
        ref("cosh_sinh_basic_properties"),
        " による。）",
      ]),
      paragraph(["中間目標: 前因子。まず"]),
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
      paragraph(["中間目標: 結論。上の二つの中間目標で得た式を合わせて"]),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\cosh K_2^*
&= (2s_2)^{1/2}\,\frac{1+t}{2\,t^{1/2}}
   \quad (\because \cosh K_2^* \text{ を } K_2 \text{ で書いた式}) \\
&= \frac{(2s_2)^{1/2}}{2\,t^{1/2}}\,(1+t)
   \quad (\because \text{積の並べ替え}) \\
&= \cosh K_2 \cdot (1+t)
   \quad (\because \tfrac{(2s_2)^{1/2}}{2\,t^{1/2}}=\cosh K_2) \\
&= \cosh K_2 \cdot \frac{\exp(K_2)}{\cosh K_2}
   \quad (\because 1+t=\tfrac{\exp(K_2)}{\cosh K_2}) \\
&= \exp(K_2)
   \quad (\because \text{約分 } \tfrac{\cosh K_2}{\cosh K_2} = 1),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\sinh K_2^*
&= (2s_2)^{1/2}\,\frac{1-t}{2\,t^{1/2}}
   \quad (\because \sinh K_2^* \text{ を } K_2 \text{ で書いた式}) \\
&= \frac{(2s_2)^{1/2}}{2\,t^{1/2}}\,(1-t)
   \quad (\because \text{積の並べ替え}) \\
&= \cosh K_2 \cdot (1-t)
   \quad (\because \tfrac{(2s_2)^{1/2}}{2\,t^{1/2}}=\cosh K_2) \\
&= \cosh K_2 \cdot \frac{\exp(-K_2)}{\cosh K_2}
   \quad (\because 1-t=\tfrac{\exp(-K_2)}{\cosh K_2}) \\
&= \exp(-K_2)
   \quad (\because \text{約分 } \tfrac{\cosh K_2}{\cosh K_2} = 1).
\end{aligned}`,
      ),
      paragraph(["これで主張の 2 式が示された。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。分配関数の転送行列の章から転送行列の章へ移し、K_2^* と s_2 の参照先を <def_second_dual_coupling_constant> と <def_indexed_hyperbolic_abbreviations> にした。番号で区切っていた四つの段を中間目標の名前へ変えた。",
      ],
    },
  },
  {
    id: "transfer_matrix_definition_second_transfer_matrix_prefactor",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 5 },
    title: { text: "第二の転送行列のパウリ行列表示の前係数" },
    labels: ["def_second_transfer_matrix_prefactor"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の結合定数 ",
        math(String.raw`K_2\in\mathbb{R}_{>0}`),
        " と ",
        ref("def_lattice_size"),
        " の列数 ",
        math(String.raw`M_{\mathrm{col}}`),
        " について、",
        ref("definition_of_sqrt_r_positive"),
        " の非負平方根を用いて",
      ]),
      displayMath(
        String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2}:=\left(\sqrt{2\sinh 2K_2}^{\,(\mathbb{R}_{\geq 0})}\right)^{M_{\mathrm{col}}}\in\mathbb{R}_{>0}`,
      ),
      paragraph([
        "と定める。ここに現れる ",
        math(String.raw`\sinh`),
        " は ",
        ref("def_cosh_sinh"),
        " の双曲線正弦である。",
        math(String.raw`K_2>0`),
        " と ",
        ref("cosh_sinh_basic_properties"),
        " より ",
        math(String.raw`2\sinh 2K_2>0`),
        " なので、平方根は正の実数として定まり、その ",
        math(String.raw`M_{\mathrm{col}}`),
        " 乗も正の実数である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。旧 <def_second_transfer_matrix_pauli> の中にあった前係数の定義を独立した定義にした。",
      ],
    },
  },

  {
    id: "transfer_matrix_claim_second_transfer_matrix_pauli_form",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 6 },
    title: { tex: String.raw`V_2 \text{ のパウリ行列表示}` },
    labels: ["second_transfer_matrix_pauli_form"],
    statement: [
      paragraph([
        ref("def_transfer_matrix"),
        " で成分により定めた ",
        math(String.raw`V_2 \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（結合定数 ",
        math(String.raw`K_2\in\mathbb{R}_{>0}`),
        "）は、",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^*\in\mathbb{R}_{>0}`),
        "、",
        ref("def_second_transfer_matrix_prefactor"),
        " の前係数、",
        ref("def_site_pauli_matrices"),
        " のサイトごとの Pauli 行列族を用いて",
      ]),
      displayMath(
        String.raw`V_2 = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\left(\sigma_1^x+\sigma_2^x+\cdots+\sigma_{M_{\mathrm{col}}}^x\right)\right)`,
      ),
      paragraph([
        "と表せる。ここに現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_exp"),
        " で成分級数として定めた行列の指数関数である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("two_by_two_transfer_identity"),
        " の ",
        math(String.raw`A \in \mathrm{Mat}(2,\mathbb{C})`),
        "（",
        math(String.raw`A_{ij} = \exp(K_2\varsigma_i\varsigma_j)`),
        "、",
        math(String.raw`\varsigma_1 = +1,\ \varsigma_2 = -1`),
        "）と、",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の ",
        math(String.raw`s_2=\sinh 2K_2`),
        " を用いる。",
        math(String.raw`\mu,\mu'\in\mathfrak{M}`),
        " について ",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota(\mu) = (i_1,\dots,i_{M_{\mathrm{col}}})`),
        "、",
        math(String.raw`\iota(\mu') = (j_1,\dots,j_{M_{\mathrm{col}}})`),
        " と書くと、",
        math(String.raw`\iota`),
        " の定義より ",
        math(String.raw`\varsigma_{i_m} = \mu(m)`),
        "、",
        math(String.raw`\varsigma_{j_m} = \mu'(m)`),
        " である。",
      ]),
      paragraph([
        "中間目標: ",
        math(String.raw`V_2`),
        " を ",
        math(String.raw`A`),
        " のクロネッカー冪で書く。",
        math(String.raw`\mu,\mu'\in\mathfrak{M}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_2)_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
&= \exp\!\left(K_2\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\mu'(m)\right)
   &&(\because \blkref{def_transfer_matrix}) \\
&= \exp\!\left(\sum_{m=1}^{M_{\mathrm{col}}} K_2\,\mu(m)\mu'(m)\right)
   &&(\because \mathbb{R}\text{ の分配則}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}}\exp\!\left(K_2\,\mu(m)\mu'(m)\right)
   &&(\because \blkref{theorem_exp_product}\text{ を }n=1,\ K=\mathbb{R}\text{ で有限和へ繰り返し適用}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}} A_{i_m j_m}
   &&(\because A\text{ の成分と }\varsigma_{i_m}=\mu(m),\ \varsigma_{j_m}=\mu'(m)\text{ を全因子へ同時適用}) \\
&= \left(\underbrace{A \boxtimes \cdots \boxtimes A}_{M_{\mathrm{col}}}\right)_{\nu(\iota(\mu)),\nu(\iota(\mu'))}
   &&(\because \blkref{def_kronecker}\text{ (2) のクロネッカー積の成分}) \\
&= \left(\underbrace{A \boxtimes \cdots \boxtimes A}_{M_{\mathrm{col}}}\right)_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
   &&(\because \blkref{config_numbering_equals_kronecker_numbering})
\end{aligned}`,
      ),
      paragraph([
        ref("row_configuration_numbering_bijective"),
        " の全射性より、すべての行・列番号の組は ",
        math(String.raw`(\mathrm{ord}(\mu),\mathrm{ord}(\mu'))`),
        " の形に書けるので、",
        math(String.raw`V_2 = A \boxtimes \cdots \boxtimes A`),
        "（",
        math(String.raw`M_{\mathrm{col}}`),
        " 個）である。",
      ]),
      paragraph([
        "中間目標: 1 因子の ",
        math(String.raw`\exp`),
        " をサイト演算子の ",
        math(String.raw`\exp`),
        " にする。",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " を固定する。",
        ref("def_site_pauli_matrices"),
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
\quad (\because \blkref{kronecker_product_rule}\text{ (1) と }I^p=I)`,
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
        " の極限の段と同じ評価 ",
        math(String.raw`|B_{kl}| \leq \|B\|`),
        "）から",
      ]),
      displayMath(
        String.raw`\exp\!\left(K_2^*\sigma_m^x\right)
= I\boxtimes\cdots\boxtimes\exp\!\left(K_2^*\sigma^x\right)\boxtimes\cdots\boxtimes I
\quad (\because \text{指数級数の部分和へ直前の冪の等式を適用し、成分ごとの極限を取る})`,
      ),
      paragraph([
        "中間目標: 積にまとめる。相異なる ",
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
        "」になる）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
&= \prod_{m=1}^{M_{\mathrm{col}}}\exp\!\left(K_2^*\sigma_m^x\right)
   &&(\because \blkref{theorem_exp_product}\text{ を互いに可換な }K_2^*\sigma_m^x\text{ の有限和へ繰り返し適用}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}}\left(I\boxtimes\cdots\boxtimes\exp\!\left(K_2^*\sigma^x\right)\boxtimes\cdots\boxtimes I\right)
   &&(\because \text{直前の中間目標の等式を全因子へ同時適用}) \\
&= \underbrace{\exp(K_2^*\sigma^x)\boxtimes\cdots\boxtimes\exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because \blkref{kronecker_product_rule}\text{ (1) で因子ごとの積にまとめる})
\end{aligned}`,
      ),
      paragraph(["中間目標: 結論。"]),
      displayMath(
        String.raw`\begin{aligned}
V_2
&= \underbrace{A \boxtimes \cdots \boxtimes A}_{M_{\mathrm{col}}}
   &&(\because V_2\text{ を }A\text{ のクロネッカー冪で書いた式}) \\
&= \underbrace{\left((2s_2)^{1/2}\exp(K_2^*\sigma^x)\right) \boxtimes \cdots \boxtimes \left((2s_2)^{1/2}\exp(K_2^*\sigma^x)\right)}_{M_{\mathrm{col}}}
   &&(\because \blkref{two_by_two_transfer_identity}\text{ を全因子へ同時適用}) \\
&= \left((2s_2)^{1/2}\right)^{M_{\mathrm{col}}}
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because \blkref{kronecker_multilinear}\text{ で各因子のスカラーを前へ出す}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because s_2=\sinh 2K_2\text{ と }\blkref{def_second_transfer_matrix_prefactor}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
   &&(\because \text{積にまとめた式})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "旧 <def_second_transfer_matrix_pauli>（V_2 をパウリ行列で定義していたブロック）と旧 <V2_component_equals_pauli>（成分定義との一致の主張）を統合した。" +
          "証明は旧 <V2_component_equals_pauli> の証明を、成分の番号を ord で指し、V_2 から始まる一続きの結論の式へ組み直したものである。前係数の定義は <def_second_transfer_matrix_prefactor> へ分けた。",
        "V_2 の exp の意味（どの代数のどの位相での級数か）が書かれていなかったため、<def_exp> の exp であることを明示した（定義が意味をもつために必要な事項）。",
        "M=2,3,4 と複数の K_2 について、成分定義の V_2 とパウリ表示の V_2 が残差 1e-14 以下で一致することを確認した（sagemath/check/043_claim_transfer_matrix_bridge/check_02_V2_bridge.sage）。2×2 の恒等式も同ファイルで確認している。",
      ],
    },
  },

  {
    id: "transfer_matrix_001_definition_symbols",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/000_definition_転送行列の記号の定義.typ", ordinal: 1 },
    title: { text: "記号の定義" },
    labels: ["def_transfer_matrix_symbols"],
    statement: [
      paragraph([
        ref("def_transfer_matrix"),
        " で成分により定めた転送行列 ",
        math(String.raw`V_1, V_2`),
        " と、",
        ref("first_transfer_matrix_pauli_form"),
        " で示した ",
        math(String.raw`V_1`),
        " のパウリ行列表示、",
        ref("second_transfer_matrix_pauli_form"),
        " で示した ",
        math(String.raw`V_2`),
        " のパウリ行列表示、",
        ref("def_site_pauli_periodic_extension"),
        " で定めた周期的な延長 ",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z=\sigma_1^z`),
        "、",
        ref("pauli_matrix_products"),
        " で定めた二次の Pauli 行列と単位行列、",
        ref("kronecker_product_rule"),
        " の (2) で示した二次の単位行列のクロネッカー積、",
        ref("def_site_pauli_matrices"),
        " で定めたサイトごとの Pauli 行列族、",
        ref("global_spin_flip_jordan_wigner_representation"),
        " で示した全スピン反転行列の Jordan--Wigner 表示、および ",
        ref("def_cosh_sinh"),
        " で定めた双曲線余弦・双曲線正弦を用いる。また、双対結合定数の式に現れる双曲線正接は ",
        ref("def_positive_coupling_tanh"),
        " で定めたものを用いる。実対数は ",
        ref("def_real_logarithm_positive"),
        " で定めたものを用いる。第一の双対結合定数は ",
        ref("def_first_dual_coupling_constant"),
        " で定めたものを用いる。第一の双対関係は ",
        ref("first_dual_coupling_relation"),
        " で示したものを用いる。第二の双対結合定数は ",
        ref("def_second_dual_coupling_constant"),
        " で定めたものを用いる。第二の双対関係は ",
        ref("second_dual_coupling_relation"),
        " で示したものに加え、双曲線関数の添字つき略記は ",
        ref("def_indexed_hyperbolic_abbreviations"),
        " で定めたものを用い、その正値性は ",
        ref("indexed_hyperbolic_abbreviations_positive"),
        " で示したものを用いる。",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`\boxtimes`),
        " は ",
        ref("def_kronecker"),
        " のクロネッカー積であり、",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素正方行列全体である。すなわち上の ",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z, Z_m, Y_m, \varepsilon`),
        " などはすべて具体的な ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素行列である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "第一の転送行列と周期規約は <def_first_transfer_matrix_pauli> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新定義を明示参照している。",
        "第二の転送行列は <def_second_transfer_matrix_pauli> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新定義を明示参照している。",
        "Jordan--Wigner 行列族 Z_m は <def_jordan_wigner_Z_matrices> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新定義を明示参照している。",
        "Jordan--Wigner 行列族 Y_m は <def_jordan_wigner_Y_matrices> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新定義を明示参照している。",
        "全スピン反転行列 epsilon は <def_global_spin_flip_matrix> へ、その Jordan--Wigner 行列による表示は <global_spin_flip_jordan_wigner_representation> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新しい表示主張を明示参照している。",
        "二次の単位行列 I_{Mat(2,C)} は <pauli_matrix_products> で既に定義されているため、本ブロックの重複した一覧項目を削除し、先頭段落の参照だけで接続した。",
        "2^M 次の単位行列 I_{Mat(2^M,C)} と二次の単位行列のクロネッカー積の等式は <kronecker_product_rule> (2) で既に示されているため、本ブロックの重複した一覧項目を削除し、先頭段落の参照だけで接続した。",
        "第一の双対結合定数 K_1^* の定義と正値性は <def_first_dual_coupling_constant> へ、第一の双対関係は <first_dual_coupling_relation> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから両者を明示参照している。",
        "第二の双対結合定数 K_2^* の定義と正値性は <def_second_dual_coupling_constant> へ、第二の双対関係は <second_dual_coupling_relation> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから両者を明示参照している。",
        "双曲線関数の添字つき略記は <def_indexed_hyperbolic_abbreviations> へ、その正値性は <indexed_hyperbolic_abbreviations_positive> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから両者を明示参照している。",
        '旧 main.typ には、見出し「対角化の計算」直下に同内容のインライン #definition("記号の定義") が' +
          "重複して置かれていた。相違は双対関係の注記のみで、そちらは旧版の sinh(K_i)sinh(K_i^*)=1" +
          "（parts/004/000 で sinh(2K_i)sinh(2K_i^*)=1 に訂正済み）。よって重複ブロックは作らず、" +
          "本ブロックへ集約した（インライン側にのみ在った σ_k^y, σ_k^z, I_{(Mat(2,C))^{⊗M}}, " +
          "p_m/q_m の対応は本ブロックへ補記済み）。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。本ブロックは V_1, V_2 を定義せず、<def_transfer_matrix> の成分定義と、<first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> のパウリ行列表示を参照する。上の <def_first_transfer_matrix_pauli>・<def_second_transfer_matrix_pauli> への分離の記録は、両ブロックがこの主張へ統合されたため歴史的な記録である。",
      ],
    },
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
    id: "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/002_claim_V1V2をZYepsilonで表す.typ", ordinal: 3 },
    title: { tex: String.raw`V_1 \text{ を } Z, Y, \varepsilon \text{ で表す}` },
    labels: ["V1_in_Z_Y_epsilon"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1, Z_m, Y_m, \varepsilon, K_1`),
        " を考える。このとき ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`V_1 = \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - \varepsilon Y_{M_{\mathrm{col}}} Z_1)\right)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`i \in \mathbb{C}`),
        " は虚数単位）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の方針: ",
        math(String.raw`\exp`),
        " の中身どうしが ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元として等しいことを示す。",
        math(String.raw`\exp`),
        " は写像であるから、これが示されれば ",
        math(String.raw`\exp`),
        " の値も等しく、主張が従う（したがって ",
        ref("theorem_exp_product"),
        " のような ",
        math(String.raw`\exp`),
        " の分解は用いない）。",
      ]),
      paragraph([
        "以下、",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z, I := I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2,\mathbb{C})`),
        " は ",
        ref("pauli_matrix_products"),
        " の Pauli 行列とし、クロネッカー積の積が各サイトごとの積であること（",
        ref("kronecker_product_rule"),
        " (1)）",
      ]),
      displayMath(
        String.raw`(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}})(B_1\boxtimes\cdots\boxtimes B_{M_{\mathrm{col}}})
= (A_1B_1)\boxtimes\cdots\boxtimes(A_{M_{\mathrm{col}}}B_{M_{\mathrm{col}}})
\quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "と、クロネッカー積が各因子について ",
        math(String.raw`\mathbb{C}`),
        "-線型であること（",
        ref("kronecker_multilinear"),
        "）",
      ]),
      displayMath(
        String.raw`C_1\boxtimes\cdots\boxtimes\overbrace{(c\,C_j)}^{j\text{th}}\boxtimes\cdots\boxtimes C_{M_{\mathrm{col}}}
= c\,(C_1\boxtimes\cdots\boxtimes C_{M_{\mathrm{col}}}) \quad (c\in\mathbb{C})
\quad (\because \text{第 } j \text{ 因子についての } \mathbb{C}\text{-線型性})`,
      ),
      paragraph(["を繰り返し用いる。"]),
      paragraph([
        "Step 0: 単一サイトの Pauli 行列の積。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x\sigma^x = I`),
        " に加えて、以下の 3 式を ",
        math(String.raw`2\times 2`),
        " 行列の積の成分計算で確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}0\cdot0+(-i)\cdot1 & 0\cdot1+(-i)\cdot0 \\ i\cdot0+0\cdot1 & i\cdot1+0\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= -i\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= -i\,\sigma^z
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^y
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}0\cdot0+1\cdot i & 0\cdot(-i)+1\cdot0 \\ 1\cdot0+0\cdot i & 1\cdot(-i)+0\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}i&0\\0&-i\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= i\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= i\,\sigma^z
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}1\cdot0+0\cdot i & 1\cdot(-i)+0\cdot0 \\ 0\cdot0+(-1)\cdot i & 0\cdot(-i)+(-1)\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= -i\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= -i\,\sigma^x
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 1: ",
        math(String.raw`Z_m, Y_m, \varepsilon, \sigma_m^z\sigma_{m+1}^z, \sigma_m^x`),
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
        "が成り立つ。これを ",
        math(String.raw`r`),
        " に関する帰納法で示す。",
        math(String.raw`r=1`),
        " のときは ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_1^{a_1}`),
        " の定義そのものである。",
        math(String.raw`r`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^{a_1}\cdots\sigma_r^{a_r}\sigma_{r+1}^{a_{r+1}}
&= \left(\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(I\boxtimes\cdots\boxtimes I\boxtimes\overbrace{\sigma^{a_{r+1}}}^{(r+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because \text{帰納法の仮定}) \\
&= (\sigma^{a_1}I)\boxtimes\cdots\boxtimes(\sigma^{a_r}I)\boxtimes(I\sigma^{a_{r+1}})\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&&(\because \text{クロネッカー積の積の規則}) \\
&= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_{r+1}}\boxtimes
   \overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-(r+1)}
&&(\because AI=IA=A)
\end{aligned}`,
      ),
      paragraph([
        "これを ",
        ref("def_jordan_wigner_Z_matrices"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        ref("def_jordan_wigner_Y_matrices"),
        " の ",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        "、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " に適用すると（",
        math(String.raw`m=1`),
        " のときは前半の積が空積で ",
        math(String.raw`Z_1=\sigma_1^z`),
        "、",
        math(String.raw`Y_1=\sigma_1^y`),
        "。以下の式で ",
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
&&(\because \text{上の一般式と } Z_m \text{ の定義}) \\
Y_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^y}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because \text{上の一般式と } Y_m \text{ の定義 }\blkref{def_jordan_wigner_Y_matrices}) \\
\varepsilon &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}}
&&(\because \text{上の一般式（} r=M_{\mathrm{col}} \text{）と } \varepsilon \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\sigma_m^x`),
        " は第 ",
        math(String.raw`m`),
        " 因子のみ ",
        math(String.raw`\sigma^x`),
        " で他は ",
        math(String.raw`I`),
        " であり、",
        math(String.raw`1\le m\le M_{\mathrm{col}}-1`),
        " について（第 ",
        math(String.raw`m`),
        " 因子と第 ",
        math(String.raw`m+1`),
        " 因子以外はすべて ",
        math(String.raw`II=I`),
        "）",
      ]),
      displayMath(
        String.raw`\sigma_m^z\sigma_{m+1}^z
= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m-1}
\quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "である。同様に ",
        math(String.raw`M_{\mathrm{col}}\ge 2`),
        " より第 ",
        math(String.raw`1`),
        " 因子と第 ",
        math(String.raw`M_{\mathrm{col}}`),
        " 因子は異なるので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&= \overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-2}\boxtimes\overbrace{\sigma^z}^{M_{\mathrm{col}}\text{th}}
&& (\because \text{クロネッカー積の積の規則})\\
&= \sigma_1^z\sigma_{M_{\mathrm{col}}}^z
&& (\because \text{クロネッカー積の積の規則})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`1\le m\le M_{\mathrm{col}}-1`),
        " について ",
        math(String.raw`Y_m Z_{m+1} = -i\,\sigma_m^z\sigma_{m+1}^z`),
        "。Step 1 の表示を用いて因子ごとに計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_m Z_{m+1}
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^y}^{m\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^x}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&& (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}
   \boxtimes\overbrace{(\sigma^y\sigma^x)}^{m\text{th}}\boxtimes\overbrace{(I\sigma^z)}^{(m+1)\text{th}}\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&& (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{(-i\,\sigma^z)}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I
&& (\because \sigma^x\sigma^x = I,\ \sigma^y\sigma^x = -i\,\sigma^z \text{（Step 0）}) \\
&= (-i)\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&& (\because \text{第 } m \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= -i\,\sigma_m^z\sigma_{m+1}^z
&& (\because \text{Step 1}) \\
\sigma_m^z\sigma_{m+1}^z
&= \bigl(i\cdot(-i)\bigr)\sigma_m^z\sigma_{m+1}^z
&& (\because\ i\cdot(-i)=1\text{（複素数の四則）})\\
&= i\bigl((-i)\sigma_m^z\sigma_{m+1}^z\bigr)
&& (\because\ \text{複素数倍の結合則})\\
&= i\,Y_m Z_{m+1}
&& (\because\ \text{上の Step 2 の等式})
\qquad (1\le m\le M_{\mathrm{col}}-1)
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 境界項 ",
        math(String.raw`\varepsilon\, Y_{M_{\mathrm{col}}} Z_1 = i\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z`),
        "。ここで Jordan--Wigner 文字列 ",
        math(String.raw`\sigma_1^x\cdots\sigma_{M_{\mathrm{col}}-1}^x`),
        " が周期境界で一周し、",
        math(String.raw`Z_1 = \sigma_1^z`),
        " の側に文字列が付いていないため、Step 2 の計算では第 ",
        math(String.raw`1`),
        " 因子の ",
        math(String.raw`\sigma^x`),
        " が相殺せずに残る。これを打ち消すのが ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " である。実際、",
        math(String.raw`M_{\mathrm{col}}\ge 2`),
        " のもとで 3 つの元の積を（クロネッカー積の積の規則を 2 回使って）因子ごとに計算すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\, Y_{M_{\mathrm{col}}} Z_1
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}}\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}-1}\boxtimes\overbrace{\sigma^y}^{M_{\mathrm{col}}\text{th}}\right)
   \left(\overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-1}\right)
&& (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x\sigma^z)}^{1\text{st}}
   \boxtimes\overbrace{(\sigma^x\sigma^x I)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x I)}^{2\text{nd},\dots,(M_{\mathrm{col}}-1)\text{th}}
   \boxtimes\overbrace{(\sigma^x\sigma^y I)}^{M_{\mathrm{col}}\text{th}}
&& (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-2}\boxtimes\overbrace{(i\,\sigma^z)}^{M_{\mathrm{col}}\text{th}}
&& (\because \sigma^x\sigma^x = I,\ AI=A,\ \sigma^x\sigma^y = i\,\sigma^z \text{（Step 0）}) \\
&= i\left(\overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-2}\boxtimes\overbrace{\sigma^z}^{M_{\mathrm{col}}\text{th}}\right)
&& (\because \text{第 } M_{\mathrm{col}} \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= i\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&& (\because \text{Step 1 の最後の式})
\end{aligned}`,
      ),
      paragraph([
        "したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&= \bigl((-i)\cdot i\bigr)\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&& (\because\ (-i)\cdot i=1\text{（複素数の四則）})\\
&= (-i)\bigl(i\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z\bigr)
&& (\because\ \text{複素数倍の結合則})\\
&= -i\,\varepsilon\, Y_{M_{\mathrm{col}}} Z_1
&& (\because\ \text{上の Step 3 の等式})
\end{aligned}`,
      ),
      paragraph([
        "Step 4: ",
        math(String.raw`V_1`),
        " の表式。",
        ref("first_transfer_matrix_pauli_form"),
        " の ",
        math(String.raw`V_1`),
        " の指数の中身を、",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z = \sigma_1^z`),
        " により最後の項 ",
        math(String.raw`\sigma_{M_{\mathrm{col}}}^z\sigma_{M_{\mathrm{col}}+1}^z = \sigma_{M_{\mathrm{col}}}^z\sigma_1^z`),
        " だけ分けて書くと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
K_1\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z
&= K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right) + K_1\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&&(\because\ \sigma_{M_{\mathrm{col}}+1}^z=\sigma_1^z\ \text{として有限和の最後の項を分ける}) \\
&= K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} i\,Y_m Z_{m+1}\right) + K_1\left(-i\,\varepsilon\,Y_{M_{\mathrm{col}}} Z_1\right)
&&(\because \text{Step 2, Step 3}) \\
&= i K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_m Z_{m+1} - \varepsilon\, Y_{M_{\mathrm{col}}} Z_1\right)
&&(\because \mathbb{C}\text{-線型空間 } \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) \text{ でのスカラー倍の分配律}) \\
&= i K_1\left(Y_1Z_2 + Y_2Z_3 + \cdots + Y_{M_{\mathrm{col}}-1}Z_{M_{\mathrm{col}}} - \varepsilon\,Y_{M_{\mathrm{col}}} Z_1\right)
&&(\because\ \text{有限和を項ごとに書く})
\end{aligned}`,
      ),
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の同一の元であるから、",
        math(String.raw`\exp`),
        " の値も等しく、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V_1
&= \exp\!\left(K_1\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\right)
&&(\because\ \blkref{first_transfer_matrix_pauli_form}) \\
&= \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - \varepsilon Y_{M_{\mathrm{col}}} Z_1)\right)
&&(\because\ \text{直前の指数の等式})
\end{aligned}`,
      ),
      paragraph(["以上で主張が示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO」のみ。ここで証明を与えた。",
        "証明の過程で、原文の V_1 の定義に含まれていた虚数単位が誤りであることが判明したため、" +
          "<def_transfer_matrix_symbols> 側を訂正した（理由はそちらの conversion.notes を参照）。",
        "原文の statement は式のみで M の範囲・記号の出典が書かれていなかったため、M ≥ 2 と" +
          "参照先（<def_transfer_matrix_symbols>）を明示した（主張の内容自体は変えていない）。",
        "2026-09-02 の式変形統一で、Step 1 の帰納法と Z_m・Y_m・ε の三本の表示に行中の " +
          "\\quad (\\because …) で置かれていた根拠 6 行を、aligned の行末の根拠列へ揃えた。" +
          "内容・式変形・根拠・参照は変えていない。",
        "2026-09-02 の式変形統一で、Step 3 の境界項 εY_MZ_1 の鎖に行中の " +
          "\\quad (\\because …) で置かれていた根拠 5 行を、aligned の行末の根拠列へ揃えた。" +
          "内容・式変形・根拠・参照は変えていない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。パウリ行列の指数表示を引く箇所の参照先を <first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_003a_claim_V2_in_Z_Y",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/002_claim_V1V2をZYepsilonで表す.typ", ordinal: 3 },
    title: { tex: String.raw`V_2 \text{ を } Z, Y \text{ で表す}` },
    labels: ["V2_in_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_2, Z_m, Y_m, K_2^*, s_2 \;(= \sinh 2K_2)`),
        " を考える。このとき ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`V_2 = (2s_2)^{M_{\mathrm{col}}/2} \exp\!\left(i K_2^* (Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_{M_{\mathrm{col}}} Y_{M_{\mathrm{col}}})\right)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`i \in \mathbb{C}`),
        " は虚数単位）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の方針: ",
        math(String.raw`\exp`),
        " の中身どうしが ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元として等しいことを示す。以下、",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z, I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " は ",
        ref("pauli_matrix_products"),
        " の Pauli 行列とする。クロネッカー積の積の規則（",
        ref("kronecker_product_rule"),
        " (1)）と各因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）を用いる。",
      ]),
      paragraph([
        "Step 0: 単一サイトの積 ",
        math(String.raw`\sigma^z\sigma^y=-i\,\sigma^x`),
        " を成分計算で確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&& (\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}1\cdot0+0\cdot i & 1\cdot(-i)+0\cdot0 \\ 0\cdot0+(-1)\cdot i & 0\cdot(-i)+(-1)\cdot0\end{pmatrix}
&& (\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&& (\because \mathbb{C} \text{ の四則}) \\
&= -i\begin{pmatrix}0&1\\1&0\end{pmatrix}
&& (\because \text{行列のスカラー倍の定義}) \\
&= -i\,\sigma^x
&& (\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 1: ",
        math(String.raw`Z_m,Y_m,\sigma_m^x`),
        " のクロネッカー積表示。まず ",
        math(String.raw`1\le r\le M_{\mathrm{col}}`),
        " と ",
        math(String.raw`a_1,\dots,a_r\in\{x,y,z\}`),
        " について",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\cdots\sigma_r^{a_r}
= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`r=1`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の定義である。",
        math(String.raw`r`),
        " で成り立つと仮定して ",
        math(String.raw`\sigma_{r+1}^{a_{r+1}}`),
        " を右から掛けると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^{a_1}\cdots\sigma_r^{a_r}\sigma_{r+1}^{a_{r+1}}
&= \left(\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(I\boxtimes\cdots\boxtimes I\boxtimes\overbrace{\sigma^{a_{r+1}}}^{(r+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&& (\because \text{帰納法の仮定とサイト作用素の定義}) \\
&= (\sigma^{a_1}I)\boxtimes\cdots\boxtimes(\sigma^{a_r}I)\boxtimes(I\sigma^{a_{r+1}})\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&& (\because \text{クロネッカー積の積の規則}) \\
&= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_{r+1}}\boxtimes
   \overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-(r+1)}
&& (\because AI=IA=A)
\end{aligned}`,
      ),
      paragraph(["よって帰納法により一般式が成り立つ。定義へ適用すると"]),
      displayMath(
        String.raw`\begin{aligned}
Z_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^z}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}, \\
Y_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^y}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}, \\
\sigma_m^x &= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes\overbrace{\sigma^x}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
\end{aligned}
\quad (\because \text{一般式とサイト作用素の定義})`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`1\le m\le M_{\mathrm{col}}`),
        " について ",
        math(String.raw`Z_mY_m=-i\,\sigma_m^x`),
        "。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_mY_m
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\sigma^z\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\sigma^y\boxtimes I\boxtimes\cdots\boxtimes I\right)
&& (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}\boxtimes(\sigma^z\sigma^y)\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&& (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes(-i\,\sigma^x)\boxtimes I\boxtimes\cdots\boxtimes I
&& (\because \sigma^x\sigma^x=I\ \text{と Step 0}) \\
&= -i\,\sigma_m^x
&& (\because \text{第 }m\text{ 因子についての複素線型性と Step 1})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^x
&= \bigl(i\cdot(-i)\bigr)\sigma_m^x
&& (\because i\cdot(-i)=1) \\
&= i\bigl((-i)\sigma_m^x\bigr)
&& (\because \text{複素数倍の結合則}) \\
&= i\,Z_mY_m
&& (\because \text{Step 2})
\end{aligned}`,
      ),
      paragraph([
        "Step 3: ",
        math(String.raw`V_2`),
        " の表式。指数の中身は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
K_2^*\left(\sigma_1^x+\cdots+\sigma_{M_{\mathrm{col}}}^x\right)
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
&& (\because \text{有限和を}\ \textstyle\sum\ \text{記法で書く}) \\
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}i\,Z_mY_m
&& (\because \text{Step 2 の直後の等式を各項へ適用}) \\
&= iK_2^*\left(Z_1Y_1+\cdots+Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}}\right)
&& (\because \text{スカラー倍の分配律と有限和を項ごとに書く})
\end{aligned}`,
      ),
      paragraph([
        "両辺へ行列指数関数を適用し、",
        ref("second_transfer_matrix_pauli_form"),
        " の ",
        math(String.raw`V_2`),
        " のパウリ行列表示と ",
        math(String.raw`s_2=\sinh 2K_2`),
        " の定義を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V_2
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*(\sigma_1^x+\cdots+\sigma_{M_{\mathrm{col}}}^x)\right)
&& (\because \blkref{second_transfer_matrix_pauli_form}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*(\sigma_1^x+\cdots+\sigma_{M_{\mathrm{col}}}^x)\right)
&& (\because s_2=\sinh 2K_2) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*(Z_1Y_1+\cdots+Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}})\right)
&& (\because \text{直前の指数の等式})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧ブロックは独立した V1 と V2 の二等式を一つの主張へ束ねていたため、一ブロック一主張の規約に従って V2 の等式を分離した。",
        "抽象テンソル積を使わず、具体的なクロネッカー積と二次 Pauli 行列の成分計算だけで証明した。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。パウリ行列の指数表示を引く箇所の参照先を <first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> にした。",
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
    id: "transfer_matrix_004_definition_eigenspace_even_of_epsilon",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { tex: String.raw`\varepsilon\text{ の固有値 }+1\text{ の固有ベクトル全体}` },
    labels: ["def_even_eigenvectors_of_epsilon"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を考える。",
        math(String.raw`\varepsilon`),
        " を ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 成分の複素数ベクトルへ ",
        ref("mat_mult"),
        " の通常の行列と数ベクトルの積として作用させ、",
      ]),
      displayMath(
        String.raw`\mathcal{F}^{(+)}
:=\left\{f\in\mathbb{C}^{2^{M_{\mathrm{col}}}}\;\middle|\;\varepsilon f=f\right\}`,
      ),
      paragraph([
        "と定める。すなわち ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " は、全スピン反転行列を左から掛けても変わらない複素数ベクトルの全体である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "二つの固有ベクトル集合と二つの部分空間性を束ねていたブロックから、固有値 +1 の集合定義だけを分離した。",
        "抽象線型写像 end(ε) を経由せず、2^M 次複素行列 ε と数ベクトルの積で定義した。",
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
    id: "transfer_matrix_004b_claim_epsilon_square_and_eigenvalues",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { tex: String.raw`\varepsilon\text{ の二乗}` },
    labels: ["epsilon_square_and_eigenvalues", "epsilon_square_identity"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、",
      ]),
      displayMath(String.raw`\varepsilon^2=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
    ],
    proof: [
      paragraph([
        "まず ",
        math(String.raw`I:=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " と略記し、",
        math(String.raw`P_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`P_r:=\sigma_1^x\cdots\sigma_r^x\ (1\leq r\leq M_{\mathrm{col}})`),
        " と置く。各 ",
        math(String.raw`r\in\{0,\dots,M_{\mathrm{col}}\}`),
        " について、",
      ]),
      displayMath(
        String.raw`P_r
=\underbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}_{r}
 \boxtimes
 \underbrace{I\boxtimes\cdots\boxtimes I}_{M_{\mathrm{col}}-r}`,
      ),
      paragraph([
        "を示す。ただし、因子が零個の部分は書かない。",
        math(String.raw`r=0`),
        " の場合は、",
        ref("kronecker_product_rule"),
        " (2) を繰り返し使うと、右辺は ",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}=P_0`),
        " である。ある ",
        math(String.raw`r\in\{0,\dots,M_{\mathrm{col}}-1\}`),
        " についてこの式が成り立つと仮定する。このとき ",
        math(String.raw`r+1\leq M_{\mathrm{col}}`),
        " なので、サイト作用素の定義と ",
        ref("kronecker_product_rule"),
        " (1)(2) より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{r+1}=P_r\sigma_{r+1}^x
&=\left(
   \underbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}_{r}
   \boxtimes
   \underbrace{I\boxtimes\cdots\boxtimes I}_{M_{\mathrm{col}}-r}
  \right)
  \left(
   \underbrace{I\boxtimes\cdots\boxtimes I}_{r}
   \boxtimes\sigma^x\boxtimes
   \underbrace{I\boxtimes\cdots\boxtimes I}_{M_{\mathrm{col}}-r-1}
  \right)
&&(\because\ \text{帰納法の仮定と}\ \sigma_{r+1}^x\ \text{の定義})\\
&=\underbrace{(\sigma^x I)\boxtimes\cdots\boxtimes(\sigma^x I)}_{r}
  \boxtimes(I\sigma^x)\boxtimes
  \underbrace{(II)\boxtimes\cdots\boxtimes(II)}_{M_{\mathrm{col}}-r-1}
&&(\because\ \text{クロネッカー積の積の規則})\\
&=\underbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}_{r+1}
  \boxtimes
  \underbrace{I\boxtimes\cdots\boxtimes I}_{M_{\mathrm{col}}-r-1}
&&(\because\ \sigma^x I=I\sigma^x=\sigma^x\ \text{と}\ II=I).
\end{aligned}`,
      ),
      paragraph([
        "よって有限帰納法により一般式が成り立つ。",
        math(String.raw`r=M_{\mathrm{col}}`),
        " と ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon=\sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " の定義から ",
        math(String.raw`\varepsilon=\sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " を得る。したがって、",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x\sigma^x = I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "、および ",
        ref("kronecker_product_rule"),
        " (1)(2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon^2
&= (\sigma^x\boxtimes\cdots\boxtimes\sigma^x)(\sigma^x\boxtimes\cdots\boxtimes\sigma^x)
&&(\because\ \varepsilon=\sigma^x\boxtimes\cdots\boxtimes\sigma^x)\\
&= (\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)
&&(\because\ \text{クロネッカー積の積の規則})\\
&= \underbrace{I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}}_{M_{\mathrm{col}}}
&&(\because\ \sigma^x\sigma^x=I_{\mathrm{Mat}(2,\mathbb{C})}\ \text{を各因子へ同時に適用})\\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \text{クロネッカー積の単位元の規則})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: ["全スピン反転行列の二乗と固有値候補を、一ブロック一主張になるよう分離した。"],
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
    id: "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "_old/typst/parts/004_転送行列/005_claim_V1の固有空間への制限.typ", ordinal: 6 },
    title: { tex: String.raw`V_1 \text{ の }\mathcal{F}^{(+)}\text{ への制限}` },
    labels: ["V1_restriction_to_eigenspaces"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1`),
        "、",
        ref("def_end_iso"),
        " の ",
        math(String.raw`\mathbf{end}`),
        "、",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について、",
      ]),
      displayMath(
        String.raw`\left(\mathbf{end}(V_1)\right)\big|_{\mathcal{F}^{(+)}}
= \left(\mathbf{end}\!\left(\exp\!\left(i K_1 (Y_1 Z_2 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - Y_{M_{\mathrm{col}}} Z_1)\right)\right)\right)\big|_{\mathcal{F}^{(+)}}`,
      ),
      paragraph([
        "が成り立つ。両辺は ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " から ",
        math(String.raw`\mathcal{F}`),
        " への写像として一致する、という意味である（右辺の ",
        math(String.raw`\exp(\cdots)`),
        " をこの証明内で ",
        math(String.raw`V_1^{(+)}`),
        " と略記する）。",
      ]),
    ],
    proof: [
      paragraph([
        "記号を固定する。",
        ref("V1_in_Z_Y_epsilon"),
        " より ",
        math(String.raw`V_1 = \exp(G)`),
        "、また上の略記より ",
        math(String.raw`V_1^{(+)} = \exp(G^{(+)})`),
        "。ここで",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W &:= Y_{M_{\mathrm{col}}} Z_1 \ \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) \\
G &:= i K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_m Z_{m+1} - \varepsilon W\right) \ \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) \\
G^{(+)} &:= i K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_m Z_{m+1} - W\right) \ \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})
\end{aligned}`,
      ),
      paragraph([
        "である。以下 ",
        math(String.raw`A \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " に対し ",
        math(String.raw`\hat{A} := \mathbf{end}(A) \in \mathrm{End}(\mathcal{F})`),
        " と書く。",
        ref("end_is_algebra_isomorphism"),
        " より ",
        math(String.raw`\widehat{AB} = \hat{A}\circ\hat{B}`),
        " かつ ",
        math(String.raw`A \mapsto \hat{A}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\varepsilon`),
        " は各 ",
        math(String.raw`Z_m, Y_m`),
        "（",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        "）と反交換する。すなわち",
      ]),
      displayMath(
        String.raw`\varepsilon Z_m = -\,Z_m\varepsilon, \qquad \varepsilon Y_m = -\,Y_m\varepsilon`,
      ),
      paragraph([
        ref("V1_in_Z_Y_epsilon"),
        " の証明 Step 1 と同じクロネッカー積による表示",
      ]),
      displayMath(
        String.raw`\varepsilon = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}},\qquad
Z_m = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m},\qquad
Y_m = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^y}^{m\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}`,
      ),
      paragraph([
        "のもとで ",
        ref("tensor_anticommutation_from_single_site"),
        " を ",
        math(String.raw`X=\varepsilon`),
        "、",
        math(String.raw`Y=Z_m`),
        " に適用する。第 ",
        math(String.raw`k`),
        " 因子の組 ",
        math(String.raw`(x_k,y_k)`),
        " は",
      ]),
      list([
        [
          math(String.raw`k<m`),
          " のとき ",
          math(String.raw`(\sigma^x,\sigma^x)`),
          "。",
          math(String.raw`\sigma^x\sigma^x = \sigma^x\sigma^x`),
          " より可換。",
        ],
        [
          math(String.raw`k=m`),
          " のとき ",
          math(String.raw`(\sigma^x,\sigma^z)`),
          "。",
          ref("pauli_matrix_products"),
          " の ",
          math(String.raw`\sigma^z\sigma^x = -\,\sigma^x\sigma^z`),
          " より反可換。",
        ],
        [
          math(String.raw`k>m`),
          " のとき ",
          math(String.raw`(\sigma^x,I)`),
          "。",
          math(String.raw`I\sigma^x = \sigma^x I`),
          " より可換。",
        ],
      ]),
      paragraph([
        "であり、反可換なサイトはちょうど 1 つ（",
        math(String.raw`k=m`),
        "）だから ",
        math(String.raw`[\varepsilon, Z_m]_+ = \varepsilon Z_m + Z_m\varepsilon = 0`),
        "、すなわち ",
        math(String.raw`\varepsilon Z_m = -Z_m\varepsilon`),
        "。",
        math(String.raw`Y_m`),
        " についても、",
        math(String.raw`k=m`),
        " の組が ",
        math(String.raw`(\sigma^x,\sigma^y)`),
        " で ",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^y\sigma^x = -\,\sigma^x\sigma^y`),
        " より反可換、他のサイトは同じく可換であるから ",
        math(String.raw`\varepsilon Y_m = -Y_m\varepsilon`),
        "。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`W`),
        "、各 ",
        math(String.raw`Y_mZ_{m+1}`),
        "、",
        math(String.raw`\varepsilon W`),
        "、および ",
        math(String.raw`G, G^{(+)}`),
        " と可換である。実際、",
        math(String.raw`a,b\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について Step 1 を 2 回使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon (Y_a Z_b)
&= (\varepsilon Y_a) Z_b
&&(\because\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\ \text{の積の結合律})\\
&= (-Y_a\varepsilon)Z_b
&&(\because\ \text{Step 1 の}\ \varepsilon Y_a = -Y_a\varepsilon)\\
&= -\left(Y_a\varepsilon\right)Z_b
&&(\because\ \text{スカラー倍と積の可換性})\\
&= -Y_a(\varepsilon Z_b)
&&(\because\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\ \text{の積の結合律})\\
&= -Y_a(-Z_b\varepsilon)
&&(\because\ \text{Step 1 の}\ \varepsilon Z_b = -Z_b\varepsilon)\\
&= (Y_a Z_b)\varepsilon
&&(\because\ \text{スカラー倍と積の可換性、および}\ -(-1)=1)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。特に ",
        math(String.raw`\varepsilon W = W\varepsilon`),
        " かつ ",
        math(String.raw`\varepsilon(Y_mZ_{m+1}) = (Y_mZ_{m+1})\varepsilon`),
        "。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon(\varepsilon W)
&= \varepsilon(W\varepsilon)
&&(\because\ \text{上で示した}\ \varepsilon W = W\varepsilon)\\
&= (\varepsilon W)\varepsilon
&&(\because\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\ \text{の積の結合律})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`G, G^{(+)}`),
        " はいずれも ",
        math(String.raw`\varepsilon`),
        " と可換な元の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合であり、積の双線型性より ",
        math(String.raw`\varepsilon G = G\varepsilon`),
        "、",
        math(String.raw`\varepsilon G^{(+)} = G^{(+)}\varepsilon`),
        "。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " は ",
        math(String.raw`\hat{W}, \hat{G}, \hat{G}^{(+)}`),
        " で不変である。",
        math(String.raw`A \in \{W, G, G^{(+)}\}`),
        " は Step 2 より ",
        math(String.raw`\varepsilon A = A\varepsilon`),
        " を満たすから、",
        ref("end_is_algebra_isomorphism"),
        " (2) より次が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{\varepsilon}\circ\hat{A}
&= \widehat{\varepsilon A}
&&(\because\ \mathbf{end}\ \text{が積を保つこと})\\
&= \widehat{A\varepsilon}
&&(\because\ \text{Step 2 の}\ \varepsilon A = A\varepsilon)\\
&= \hat{A}\circ\hat{\varepsilon}
&&(\because\ \mathbf{end}\ \text{が積を保つこと})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        "（すなわち ",
        math(String.raw`\hat{\varepsilon}f = f`),
        "）に対し",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{\varepsilon}\left(\hat{A}f\right)
&= \hat{A}\left(\hat{\varepsilon}f\right)
&&(\because\ \hat{\varepsilon}\circ\hat{A} = \hat{A}\circ\hat{\varepsilon})\\
&= \hat{A}f
&&(\because\ f\in\mathcal{F}^{(+)}\ \text{すなわち}\ \hat{\varepsilon}f = f)
\end{aligned}`,
      ),
      paragraph([
        "であり ",
        math(String.raw`\hat{A}f \in \mathcal{F}^{(+)}`),
        "。",
      ]),
      paragraph([
        "Step 4: ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " に対し ",
        math(String.raw`\hat{G}f = \hat{G}^{(+)}f`),
        "。まず ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
G-G^{(+)}
&=iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}-\varepsilon W\right)
  -iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}- W\right)
&&\left(\because\ G,G^{(+)}\ \text{の定義}\right)\\
&=iK_1\left(
  \left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}-\varepsilon W\right)
  -\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}- W\right)
\right)
&&\left(\because\ \text{スカラー倍の分配則}\right)\\
&=iK_1\left(-\varepsilon W+ W\right)
&&\left(\because\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)\ \text{の加法の四則}\right)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("end_is_algebra_isomorphism"),
        " の線型性と (2) より ",
        math(String.raw`\widehat{\varepsilon W} = \hat{\varepsilon}\circ\hat{W}`),
        " だから、Step 3 の ",
        math(String.raw`\hat{W}f\in\mathcal{F}^{(+)}`),
        " を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\hat{G} - \hat{G}^{(+)}\right)f
&= \left(\widehat{G-G^{(+)}}\right)f
&&(\because\ \mathbf{end}\ \text{の線型性（差の像は像の差）})\\
&= \left(\widehat{iK_1\left(-\varepsilon W+ W\right)}\right)f
&&(\because\ \text{上で示した}\ G-G^{(+)}\ \text{の表示})\\
&= i K_1\left(-\widehat{\varepsilon W} + \hat{W}\right)f
&&(\because\ \mathbf{end}\ \text{の線型性})\\
&= i K_1\left(-\hat{\varepsilon}\!\left(\hat{W}f\right) + \hat{W}f\right)
&&(\because\ \widehat{\varepsilon W} = \hat{\varepsilon}\circ\hat{W}\ \text{（}\mathbf{end}\ \text{が積を保つこと）と写像の値の書き下し})\\
&= i K_1\left(-\hat{W}f + \hat{W}f\right)
&&(\because\ \hat{W}f\in\mathcal{F}^{(+)}\ \text{より}\ \hat{\varepsilon}(\hat{W}f) = \hat{W}f\text{（Step 3）})\\
&= i K_1\cdot 0
&&(\because\ -x + x = 0)\\
&= 0
&&(\because\ \text{零ベクトルのスカラー倍は零ベクトル})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。よって ",
        math(String.raw`\hat{G}f = \hat{G}^{(+)}f`),
        "。",
      ]),
      paragraph([
        "Step 5: ",
        math(String.raw`n\in\mathbb{Z}_{\geq 0}`),
        " と ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " について ",
        math(String.raw`\hat{G}^{\,n}f = \left(\hat{G}^{(+)}\right)^{n}f`),
        "（",
        math(String.raw`\hat{G}^{\,0} := \mathrm{id}_{\mathcal{F}}`),
        "）。",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n=0`),
        " では",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{G}^{\,0}f
&= \mathrm{id}_{\mathcal F}(f)
&&(\because\ \text{写像の零乗の定義})\\
&= f
&&(\because\ \text{恒等写像の定義})\\
&= \mathrm{id}_{\mathcal F}(f)
&&(\because\ \text{恒等写像の定義})\\
&= \left(\hat{G}^{(+)}\right)^{0}f
&&(\because\ \text{写像の零乗の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`n`),
        " で成立するとし ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " を取ると、Step 4 より ",
        math(String.raw`g := \hat{G}f = \hat{G}^{(+)}f`),
        " であり、Step 3 より ",
        math(String.raw`g\in\mathcal{F}^{(+)}`),
        " だから帰納法の仮定を ",
        math(String.raw`g`),
        " に適用でき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{G}^{\,n+1}f
&= \hat{G}^{\,n}\!\left(\hat{G}f\right)
&&(\because\ \text{写像の冪の定義})\\
&= \hat{G}^{\,n}g
&&(\because\ g := \hat{G}f)\\
&= \left(\hat{G}^{(+)}\right)^{n}g
&&(\because\ \text{帰納法の仮定を}\ g\in\mathcal{F}^{(+)}\ \text{に適用})\\
&= \left(\hat{G}^{(+)}\right)^{n}\!\left(\hat{G}^{(+)}f\right)
&&(\because\ \text{Step 4 の}\ g = \hat{G}^{(+)}f)\\
&= \left(\hat{G}^{(+)}\right)^{n+1}f
&&(\because\ \text{写像の冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 6: ",
        math(String.raw`\exp`),
        " への持ち上げ。",
        ref("end_preserves_matrix_exponential"),
        " を ",
        math(String.raw`A=G`),
        " と ",
        math(String.raw`A=G^{(+)}`),
        " に適用する。任意の ",
        math(String.raw`f\in\mathcal{F}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}(V_1)\right)(f)
&= \left(\mathbf{end}(\exp(G))\right)(f)
&&\left(\because\ V_1=\exp(G)\right)\\
&= \lim_{N\to\infty}\sum_{n=0}^{N}\frac{1}{n!}\hat{G}^{\,n}f
&&\left(\because\ \text{行列表示と線型写像表示の間の指数関数保存}\right),
\end{aligned}`,
      ),
      paragraph(["および"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}\!\left(V_1^{(+)}\right)\right)(f)
&= \left(\mathbf{end}\!\left(\exp\!\left(G^{(+)}\right)\right)\right)(f)
&&\left(\because\ V_1^{(+)}=\exp(G^{(+)})\right)\\
&= \lim_{N\to\infty}\sum_{n=0}^{N}\frac{1}{n!}\left(\hat{G}^{(+)}\right)^{n}f
&&\left(\because\ \text{行列表示と線型写像表示の間の指数関数保存}\right)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。ここで解析的操作（",
        math(String.raw`\mathbb{C}`),
        " 上の無限級数の極限）へ移行するのはこの箇所だけであり、Step 1〜5 はすべて有限個の元の" +
          "代数的な等式である。",
      ]),
      paragraph([
        "いま ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " を任意に取る。Step 5 より、各 ",
        math(String.raw`N\in\mathbb{Z}_{\geq 0}`),
        " について部分和が",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_N := \sum_{n=0}^{N}\frac{1}{n!}\hat{G}^{\,n}f
&= \sum_{n=0}^{N}\frac{1}{n!}\left(\hat{G}^{(+)}\right)^{n}f
&&(\because\ \text{Step 5 を各}\ n\in\{0,\dots,N\}\ \text{に適用})\\
&=: S_N^{(+)}
&&(\because\ S_N^{(+)}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "と一致する。上の各点収束より ",
        math(String.raw`S_N \to \left(\mathbf{end}(V_1)\right)(f)`),
        " かつ ",
        math(String.raw`S_N^{(+)} = S_N \to \left(\mathbf{end}(V_1^{(+)})\right)(f)`),
        " であり、同一の点列が 2 つの極限 ",
        math(String.raw`\alpha,\beta`),
        " を持てば、ノルムの三角不等式と極限の定義から次の鎖を得る。",
        ref("matrix_norm_triangle_inequality"),
        " のノルムの非負性・三角不等式・非退化性を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\leq \|\alpha-\beta\|
&&\left(\because\ \text{ノルムの非負性}\right)\\
&\leq \|\alpha-S_N\|+\|S_N-\beta\|
&&\left(\because\ \alpha-\beta=(\alpha-S_N)+(S_N-\beta)\ \text{と三角不等式}\right)\\
&\longrightarrow 0
&&\left(\because\ S_N\to\alpha\ \text{かつ}\ S_N\to\beta\right).
\end{aligned}`,
      ),
      paragraph(["したがって次の鎖を得る。"]),
      displayMath(
        String.raw`\begin{aligned}
\|\alpha-\beta\|
&=0
&&\left(\because\ 0\leq\|\alpha-\beta\|\leq\|\alpha-S_N\|+\|S_N-\beta\|\to0\right)\\
\alpha
&=\beta
&&\left(\because\ \|\alpha-\beta\|=0\ \text{なら}\ \alpha-\beta=0\right).
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}(V_1)\right)f
&= \left(\mathbf{end}\!\left(V_1^{(+)}\right)\right)f
&&(\because\ \text{同一の点列}\ S_N = S_N^{(+)}\ \text{の極限の一意性})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " は任意だったから、",
        math(String.raw`\mathcal{F}^{(+)}`),
        " 上の写像として",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}(V_1)\right)\big|_{\mathcal{F}^{(+)}}
&= \left(\mathbf{end}\!\left(V_1^{(+)}\right)\right)\big|_{\mathcal{F}^{(+)}}
&&(\because\ \text{上の等式が任意の}\ f\in\mathcal{F}^{(+)}\ \text{で成り立つこと})\\
&= \left(\mathbf{end}\!\left(\exp\!\left(i K_1 (Y_1 Z_2 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - Y_{M_{\mathrm{col}}} Z_1)\right)\right)\right)\big|_{\mathcal{F}^{(+)}}
&&(\because\ V_1^{(+)}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph(["が示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO」のみ。ここで証明を与えた。",
        "証明には end が単位的代数の同型であること（積の保存）が必要であり、原文のように" +
          "「線型同型を一つ取る」だけでは Step 3・Step 4 が成立しない。<def_end_iso> を書き換えた理由はそちら参照。",
        "原文の statement は式のみで、両辺が F^{(±)} 上の写像として一致するという意味であることと" +
          "M の範囲が書かれていなかったため明示した（主張の内容自体は変えていない）。",
        "式変形の書き方の統一（2026-08-14）: 同一の点列の極限の一意性を散文中で圧縮していた箇所を、" +
          "三角不等式・二つの収束・ノルム零からの一致を一行ずつ根拠付きで示す鎖へ開いた。内容は変えていない。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_007_definition_V1_pm",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/006_definition_V1_plus_minusの定義.typ", ordinal: 7 },
    title: { tex: String.raw`V_1^{(+)} \text{ の定義}` },
    labels: ["def_V1_plus"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_1,Y_m,Z_m`),
        " を用いて",
      ]),
      displayMath(
        String.raw`V_1^{(+)} := \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - Y_{M_{\mathrm{col}}} Z_1)\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\exp`),
        " は ",
        ref("def_end_iso"),
        " の同一視のもとでの ",
        ref("def_exp"),
        " の ",
        math(String.raw`\exp`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "参照のためラベル <def_V1_pm> を付け、M の範囲と exp の意味（<def_end_iso> の同一視による）を" +
          "明示した（定義の内容自体は変えていない）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
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
    id: "transfer_matrix_011a_definition_H1_pm",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: { tex: String.raw`\text{一般生成子 } H_1^{(+)}` },
    labels: ["def_H1_plus"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とし、各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        ref("def_jordan_wigner_Y_matrices"),
        " と ",
        ref("def_jordan_wigner_Z_matrices"),
        " で定めた具体的な複素行列 ",
        math(String.raw`Y_m,Z_m\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
        math(String.raw`H_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`H_1^{(+)} := \sum_{m=1}^{M_{\mathrm{col}}-1} Y_m Z_{m+1} - Y_{M_{\mathrm{col}}} Z_1`,
      ),
      paragraph(["と定める。行列の積は ", ref("mat_mult"), " の成分表示による。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロック <def_H1_H2> から、一般生成子 H_1^{(±)} の定義だけを独立させた。端点を含めて曖昧さのない有限和で、元の式と同じ内容を記した。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_011b_definition_H2",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: { tex: String.raw`\text{一般生成子 } H_2` },
    labels: ["def_H2"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        ref("def_jordan_wigner_Z_matrices"),
        " と ",
        ref("def_jordan_wigner_Y_matrices"),
        " で定めた具体的な複素行列 ",
        math(String.raw`Z_m,Y_m\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用い、",
        math(String.raw`H_2\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を",
      ]),
      displayMath(String.raw`H_2 := \sum_{m=1}^{M_{\mathrm{col}}} Z_m Y_m`),
      paragraph(["と定める。行列の積は ", ref("mat_mult"), " の成分表示による。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロック <def_H1_H2> から、一般生成子 H_2 の定義だけを独立させた。端点を含めて曖昧さのない有限和で、元の式と同じ内容を記した。",
      ],
    },
  },
  {
    id: "transfer_matrix_011c_claim_V1_pm_exponential_representation",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: { tex: String.raw`V_1^{(+)} \text{ の一般生成子による指数表示}` },
    labels: ["V1_plus_exponential_representation"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        "、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_1\in\mathbb{R}_{>0}\subset\mathbb{C}`),
        "、および虚数単位 ",
        math(String.raw`i\in\mathbb{C}`),
        " を用いる。",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        ref("def_V1_plus"),
        " の ",
        math(String.raw`V_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、",
      ]),
      displayMath(
        String.raw`V_1^{(+)}
= \exp\!\left(i K_1 H_1^{(+)}\right)`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_V1_plus"),
        " の表示中の ",
        math(String.raw`Y_1Z_2+Y_2Z_3+\cdots+Y_{M_{\mathrm{col}}-1}Z_{M_{\mathrm{col}}}`),
        " は、添字を省略しない有限和 ",
        math(String.raw`\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}`),
        " を表す。特に ",
        math(String.raw`M_{\mathrm{col}}=2`),
        " では一項 ",
        math(String.raw`Y_1Z_2`),
        " だけである。したがって、",
      ]),
      displayMath(String.raw`\begin{aligned}
V_1^{(+)}
&=\exp\!\left(iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}- Y_{M_{\mathrm{col}}}Z_1\right)\right)
&&(\because\ \text{第一転送行列の定義と上の有限和記法。}\blkref{def_V1_plus})\\
&=\exp\!\left(iK_1H_1^{(+)}\right)
&&(\because\ \text{一般生成子の定義。}\blkref{def_H1_plus})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロック <def_H1_H2> から、V1^{(±)} の指数表示だけを独立主張として分離した。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_011d_claim_V2_exponential_representation",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: { tex: String.raw`V_2 \text{ の一般生成子による指数表示}` },
    labels: ["V2_exponential_representation"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        "、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_2^*,s_2\in\mathbb{R}_{>0}\subset\mathbb{C}`),
        "、および虚数単位 ",
        math(String.raw`i\in\mathbb{C}`),
        " を用いる。",
        ref("def_H2"),
        " の ",
        math(String.raw`H_2\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と同じ記号定義の ",
        math(String.raw`V_2\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、",
        ref("V2_in_Z_Y"),
        " と合わせると",
      ]),
      displayMath(
        String.raw`V_2
= (2s_2)^{M_{\mathrm{col}}/2} \exp\!\left(i K_2^* H_2\right)`,
      ),
    ],
    proof: [
      paragraph([
        ref("V2_in_Z_Y"),
        " の表示中の ",
        math(String.raw`Z_1Y_1+Z_2Y_2+\cdots+Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}}`),
        " は、添字を省略しない有限和 ",
        math(String.raw`\sum_{m=1}^{M_{\mathrm{col}}}Z_mY_m`),
        " を表す。特に ",
        math(String.raw`M_{\mathrm{col}}=1`),
        " では一項 ",
        math(String.raw`Z_1Y_1`),
        " だけである。したがって、",
      ]),
      displayMath(String.raw`\begin{aligned}
V_2
&=(2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*\sum_{m=1}^{M_{\mathrm{col}}}Z_mY_m\right)
&&(\because\ \text{第二転送行列の Jordan--Wigner 表示と上の有限和記法。}\blkref{V2_in_Z_Y})\\
&=(2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)
&&(\because\ \text{一般生成子の定義。}\blkref{def_H2})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロック <def_H1_H2> から、V2 の指数表示だけを独立主張として分離した。",
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
