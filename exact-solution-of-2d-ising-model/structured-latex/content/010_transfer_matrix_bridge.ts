import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/010_transfer_matrix_bridge.ts";

export default defineBlocks([
  {
    id: "heading_transfer_matrix_bridge",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "偶セクターへの射影と転送行列" },
    labels: [],
  },

  {
    id: "bridge_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の内容" },
    labels: [],
    statement: [
      paragraph([
        "この章は、",
        ref("def_global_spin_flip_matrix"),
        " の全スピン反転行列 ",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " の固有ベクトル全体 ",
        math(String.raw`\mathcal{F}^{(+)}`),
        "（",
        ref("def_even_eigenvectors_of_epsilon"),
        "、偶セクター）への射影と、偶セクターで用いる転送行列を準備する。",
      ]),
      paragraph([
        ref("def_epsilon_projectors"),
        " で ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " への射影子 ",
        math(String.raw`P^{(+)}`),
        " を定め、",
        ref("epsilon_projector_properties"),
        " でその冪等性と像が ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " であることを示す。",
        ref("def_V1_plus_square_root"),
        " で ",
        math(String.raw`(V_1^{(+)})^{1/2}`),
        " を定め、",
        ref("V1_plus_square_root_property"),
        " でその二乗が ",
        ref("def_V1_plus"),
        " の ",
        math(String.raw`V_1^{(+)}`),
        " であることを示す。",
        ref("def_V_plus"),
        " で偶セクターの転送行列 ",
        math(String.raw`V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`),
        " を定める。",
        ref("epsilon_commutes_with_transfer_matrices"),
        " と ",
        ref("epsilon_projectors_commute_with_transfer_matrices"),
        " で、",
        math(String.raw`\varepsilon`),
        " と ",
        math(String.raw`P^{(+)}`),
        " が ",
        math(String.raw`V_1, V_2, V_1^{(+)}, (V_1^{(+)})^{1/2}`),
        " と可換であることを示す。",
      ]),
      paragraph([
        "これらは、次の章で対称化転送行列 ",
        math(String.raw`W`),
        " が ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " 上で ",
        math(String.raw`V^{(+)}`),
        " に一致すること（",
        ref("symmetrized_transfer_matrix_on_sectors"),
        "）を示すための入力である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "M と N の役割の対応は、001 章の V_1 が同一の μ の隣接成分を結び、004 章の V_1 が同一鎖の隣接サイトを結ぶ、という一次情報から確定させた。数値でも Z の直接和と tr((V_1V_2)^{N_row}) が K_1 = J'、K_2 = J のときに一致することを確認済み（sagemath/check/043_claim_transfer_matrix_bridge/check_04_partition_function.sage）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "成分定義とパウリ行列表示の一致（旧 <V1_component_equals_pauli>・<V2_component_equals_pauli>）と、その前提のブロックを転送行列の章へ移し、" +
          "旧 <partition_function_in_pauli_form> は <partition_function_via_transfer_matrix> と同一になったため削除した。章名を「偶セクターへの射影と転送行列」に改め、この概要を章に残った内容の説明に書き直した。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。分配関数のセクター分解の結論を除き、この概要を偶セクターの射影と転送行列の準備の説明に書き直した。",
      ],
    },
  },

  {
    id: "bridge_008_definition_epsilon_projectors",
    kind: "definition",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`\mathcal{F}^{(+)} \text{ への射影子 } P^{(+)}` },
    labels: ["def_epsilon_projectors"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`P^{(+)} := \tfrac{1}{2}\left(I + \varepsilon\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。ここで ",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },

  {
    id: "bridge_009_claim_epsilon_projector_properties",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`P^{(+)} \text{ の性質}` },
    labels: ["epsilon_projector_properties"],
    statement: [
      paragraph([
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(+)}`),
        " と ",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について、次の二つが成り立つ。",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \left(P^{(+)}\right)^2 = P^{(+)}`)],
        [
          math(String.raw`\text{(2)}\quad \mathrm{im}\,P^{(+)} := \left\{P^{(+)}x \;\middle|\; x\in\mathbb{C}^{2^{M_{\mathrm{col}}}}\right\} = \mathcal{F}^{(+)}`),
        ],
      ]),
    ],
    proof: [
      paragraph(["(1)"]),
      displayMath(
        String.raw`\begin{aligned}
\left(P^{(+)}\right)^2
&= \tfrac{1}{4}\left(I + \varepsilon\right)\left(I + \varepsilon\right)
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{4}\left(I + \varepsilon + \varepsilon + \varepsilon^2\right)
   \quad (\because \text{分配法則と } I\varepsilon=\varepsilon I=\varepsilon) \\
&= \tfrac{1}{4}\left(I + 2\varepsilon + \varepsilon^2\right)
   \quad (\because \text{同類項をまとめる}) \\
&= \tfrac{1}{4}\left(2I + 2\varepsilon\right)
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の } \varepsilon^2=I) \\
&= \tfrac{1}{2}\left(I + \varepsilon\right)
   \quad (\because \text{スカラー倍を整理する}) \\
&= P^{(+)}
   \quad (\because \blkref{def_epsilon_projectors})
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`\mathcal{F}^{(+)} = \{f \in \mathbb{C}^{2^{M_{\mathrm{col}}}} \mid \varepsilon f = f\}`),
        "（",
        math(String.raw`\varepsilon f`),
        " は行列と数ベクトルの積）である。",
      ]),
      paragraph([
        math(String.raw`(\subseteq)`),
        " ",
        math(String.raw`y \in \mathrm{im}\,P^{(+)}`),
        " とすると、ある ",
        math(String.raw`x\in\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " について ",
        math(String.raw`y = P^{(+)}x`),
        " と書ける。まず",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)}y
&= P^{(+)}P^{(+)}x
   \quad (\because y = P^{(+)}x) \\
&= \left(P^{(+)}\right)^2x
   \quad (\because \text{積の冪の表記}) \\
&= P^{(+)}x
   \quad (\because \text{(1) の冪等性}) \\
&= y
   \quad (\because y = P^{(+)}x)
\end{aligned}`,
      ),
      paragraph(["である。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon y
&= \varepsilon P^{(+)} y
   \quad (\because \text{上の等式 } y = P^{(+)}y) \\
&= \varepsilon\cdot\tfrac{1}{2}\left(I + \varepsilon\right) y
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{2}\left(\varepsilon I + \varepsilon^2\right) y
   \quad (\because \text{分配法則}) \\
&= \tfrac{1}{2}\left(\varepsilon + \varepsilon^2\right) y
   \quad (\because \varepsilon I=\varepsilon) \\
&= \tfrac{1}{2}\left(\varepsilon + I\right) y
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の } \varepsilon^2=I) \\
&= \tfrac{1}{2}\left(I + \varepsilon\right) y
   \quad (\because \text{行列の加法の可換性}) \\
&= P^{(+)}y
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= y
   \quad (\because \text{上の等式 } y = P^{(+)}y)
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        ref("def_even_eigenvectors_of_epsilon"),
        " により ",
        math(String.raw`y \in \mathcal{F}^{(+)}`),
        "。",
      ]),
      paragraph([
        math(String.raw`(\supseteq)`),
        " ",
        math(String.raw`f \in \mathcal{F}^{(+)}`),
        " すなわち（",
        ref("def_even_eigenvectors_of_epsilon"),
        " により）",
        math(String.raw`\varepsilon f = f`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)} f
&= \tfrac{1}{2}\left(I + \varepsilon\right) f
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{2}\left(If + \varepsilon f\right)
   \quad (\because \text{分配法則}) \\
&= \tfrac{1}{2}\left(f + \varepsilon f\right)
   \quad (\because If=f) \\
&= \tfrac{1}{2}\left(f + f\right)
   \quad (\because \text{仮定 } \varepsilon f = f) \\
&= \tfrac{1}{2}\left(2f\right)
   \quad (\because \text{同類項をまとめる}) \\
&= f
   \quad (\because \text{スカラー倍を整理する})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`f = P^{(+)}f \in \mathrm{im}\,P^{(+)}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "式変形の書き方の統一（2026-08-14）: 各式変形の行末に残っていた根拠に対応するラベル参照を、各鎖の直後へ追加した。等式・不等式・場合分け・使用する根拠の内容は変えていない。",
        "式変形の書き方の統一（2026-09-03）: 各鎖の直後に置かれた参照段落を削り、参照を実際に使う各式変形行の行末の \\blkref へ移した。内容・式変形・根拠・参照は不変である。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。旧 (1) の P^{(+)}P^{(-)}=0 と旧 (2) の P^{(+)}+P^{(-)}=I を除き、旧 (3) を (2) とした。F^{(+)} の定義の参照先を <def_even_eigenvectors_of_epsilon> にし、像を数ベクトル空間 C^{2^M} の部分集合として書いた。",
      ],
    },
  },

  {
    id: "bridge_definition_V1_pm_square_root",
    kind: "definition",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`V_1^{(+)} \text{ の平方根として用いる行列}` },
    labels: ["def_V1_plus_square_root"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_1\in\mathbb{R}_{>0}\subset\mathbb{C}`),
        " と ",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いて",
      ]),
      displayMath(
        String.raw`\left(V_1^{(+)}\right)^{1/2}
:= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。二乗が ",
        ref("def_V1_plus"),
        " の ",
        math(String.raw`V_1^{(+)}`),
        " に等しいことは ",
        ref("V1_plus_square_root_property"),
        " で示す。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "もとの可換性の主張で未定義のまま使われていた (V_1^{(\pm)})^{1/2} を、1 ブロック 1 定義に従って独立させた。二乗が V_1^{(\pm)} に等しいことは後続の平方根の主張で証明する。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。偶セクターの章にあった同じ行列の重複定義（exp((i/2)K_1H_1^{(+)}) の形）を削除してこのブロックを唯一の定義とし、式をその形にそろえた。ラベルを <def_V1_pm_square_root> から <def_V1_plus_square_root> に改めた。",
      ],
    },
  },

  {
    id: "bridge_claim_V1_pm_square_root_squares_to_V1_pm",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`\left(V_1^{(+)}\right)^{1/2} \text{ の平方根性}` },
    labels: ["V1_plus_square_root_property"],
    statement: [
      paragraph([
        ref("def_V1_plus_square_root"),
        " の ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " と ",
        ref("def_V1_plus"),
        " の ",
        math(String.raw`V_1^{(+)}`),
        " について、",
      ]),
      displayMath(String.raw`\left(\left(V_1^{(+)}\right)^{1/2}\right)^2=V_1^{(+)}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`X := \tfrac{i}{2}K_1H_1^{(+)} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " とおく。",
        math(String.raw`X`),
        " は自分自身と可換である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(V_1^{(+)}\right)^{1/2}\right)^2
&=\exp\!\left(X\right)\exp\!\left(X\right)
&&\left(\because\ \blkref{def_V1_plus_square_root}\ \text{と}\ X\ \text{の定義}\right)\\
&=\exp\!\left(X+X\right)
&&\left(\because\ \blkref{theorem_exp_product}\ \text{を可換な}\ X,\ X\ \text{に適用}\right)\\
&=\exp\!\left(iK_1H_1^{(+)}\right)
&&\left(\because\ X\ \text{の定義と同類項}\ \tfrac{i}{2}K_1H_1^{(+)}\ \text{の加法}\right)\\
&=V_1^{(+)}
&&\left(\because\ \blkref{V1_plus_exponential_representation}\right).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "平方根として用いる半指数行列の定義と、その二乗が V_1^{(\pm)} になる主張を 1 ブロック 1 主張に従って分離した。",
        "式変形の書き方の統一（2026-09-03）: 計算前の参照一覧を削り、既に各式変形行の行末にある \\blkref だけを残した。内容・式変形・根拠・参照は不変である。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。偶セクターの章にあった同じ主張の重複ブロック（旧ラベル <V1_plus_square_root_property>）と統合し、ラベルを <V1_plus_square_root_property> に一本化した（旧ラベル <V1_pm_square_root_squares_to_V1_pm> は廃止）。",
      ],
    },
  },

  {
    id: "evensectorT_definition_V_plus",
    kind: "definition",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`\text{偶セクターの転送行列 } V^{(+)}` },
    labels: ["def_V_plus"],
    statement: [
      paragraph([
        ref("def_V1_plus_square_root"),
        " の ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " と ",
        ref("V2_exponential_representation"),
        " の ",
        math(String.raw`V_2 = (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^* H_2\right)`),
        " を用いて",
      ]),
      displayMath(
        String.raw`V^{(+)} := \left(V_1^{(+)}\right)^{1/2} V_2 \left(V_1^{(+)}\right)^{1/2}
\ \in\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。V^{(+)} の定義を偶セクターの章からこの章へ移し、唯一の定義とした（対称化転送行列の章が前方参照しないため）。",
      ],
    },
  },

  {
    id: "bridge_010_claim_epsilon_commutes",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`\varepsilon \text{ は } V_1, V_2, V_1^{(+)}, \left(V_1^{(+)}\right)^{1/2} \text{ と可換}` },
    labels: ["epsilon_commutes_with_transfer_matrices"],
    statement: [
      paragraph([
        math(String.raw`\varepsilon`),
        " は ",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`V_1, V_2`),
        " および ",
        ref("def_V1_plus"),
        " の ",
        math(String.raw`V_1^{(+)}`),
        "、さらに ",
        ref("def_V1_plus_square_root"),
        " の ",
        math(String.raw`(V_1^{(+)})^{1/2}`),
        " と可換である。",
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
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
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
\qquad (k \in \{1,\dots,M_{\mathrm{col}}\})
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
        math(String.raw`R := K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x`),
        " と置くと、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon R
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\varepsilon\,\sigma_m^x
   \quad (\because \text{スカラー倍との可換性と、行列積の有限和への分配}) \\
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\,\varepsilon
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
        math(String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2}`),
        " は ",
        ref("scalar_identity_commutes"),
        " より任意の行列と可換なので、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon V_2
&= \varepsilon\left((2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp(R)\right)
   \quad (\because \blkref{second_transfer_matrix_pauli_form}\text{ と }R\text{ の定義}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\left(\varepsilon\exp(R)\right)
   \quad (\because \text{スカラー倍との可換性}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\left(\exp(R)\,\varepsilon\right)
   \quad (\because \text{上の }\varepsilon\exp(R)=\exp(R)\varepsilon) \\
&= \left((2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp(R)\right)\varepsilon
   \quad (\because \text{スカラー倍との可換性}) \\
&= V_2\,\varepsilon
   \quad (\because \blkref{second_transfer_matrix_pauli_form}\text{ と }R\text{ の定義})
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
        math(String.raw`D = \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z`),
        " と置くと、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon D
&= \sum_{m=1}^{M_{\mathrm{col}}}\varepsilon\,\sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{行列積の有限和への分配}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\,\varepsilon
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
   \quad (\because \blkref{first_transfer_matrix_pauli_form}\text{ と }D\text{ の定義}) \\
&= \exp(K_1D)\varepsilon
   \quad (\because \varepsilon\text{ と }\exp(K_1D)\text{ の可換性}) \\
&= V_1\varepsilon
   \quad (\because \blkref{first_transfer_matrix_pauli_form}\text{ と }D\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`V_1^{(+)}`),
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
        ref("def_H1_plus"),
        " の ",
      ]),
      displayMath(
        String.raw`H_1^{(+)} = \sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1`,
      ),
      paragraph([
        "は各項が ",
        math(String.raw`Y\cdot Z`),
        " の形なので、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon H_1^{(+)}
&= \varepsilon\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1\right)
   \quad (\because \blkref{def_H1_plus}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\varepsilon\,(Y_mZ_{m+1}) - \varepsilon\,(Y_{M_{\mathrm{col}}}Z_1)
   \quad (\because \text{行列積の有限和への分配}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}(Y_mZ_{m+1})\,\varepsilon - (Y_{M_{\mathrm{col}}}Z_1)\,\varepsilon
   \quad (\because \text{上の }\varepsilon\,(Y_mZ_{m'})=(Y_mZ_{m'})\,\varepsilon\text{ を全項へ同時適用}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1\right)\varepsilon
   \quad (\because \text{行列積の有限和への分配}) \\
&= H_1^{(+)}\,\varepsilon
   \quad (\because \blkref{def_H1_plus})
\end{aligned}`,
      ),
      paragraph([
        "Step 2 と同じ議論で ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`\exp(iK_1H_1^{(+)})`),
        " とも ",
        math(String.raw`\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)`),
        " とも可換である。",
        ref("V1_plus_exponential_representation"),
        " より前者は ",
        math(String.raw`V_1^{(+)}`),
        "、",
        ref("def_V1_plus_square_root"),
        " より後者は ",
        math(String.raw`(V_1^{(+)})^{1/2}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "式変形の書き方の統一（2026-08-14）: Step 2 末尾の散文に埋まっていたスカラー因子の付加（εV₂=V₂ε の導出）を、一行一等号と行末根拠の鎖へ開いた。等式・根拠の内容は変えていない。",
        "2026-09-01 の構成レビューで、後続の未ラベル定義にある H_1^{(\pm)} を先取りしていた箇所を、証明内の局所記号 G^{(\pm)} へ置き換えた。平方根の定義と射影の可換性は独立ブロックへ分けた。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。V_1, V_2 の参照先を <def_transfer_matrix> にし、パウリ行列表示を使う行の根拠を <first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> にした。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },

  {
    id: "bridge_claim_epsilon_projectors_commute_with_transfer_matrices",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`P^{(+)} \text{ は転送行列と可換}` },
    labels: ["epsilon_projectors_commute_with_transfer_matrices"],
    statement: [
      paragraph([
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(+)}`),
        " は ",
        ref("epsilon_commutes_with_transfer_matrices"),
        " の ",
        math(String.raw`V_1,V_2,V_1^{(+)},(V_1^{(+)})^{1/2}`),
        " のすべてと可換である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を ",
        math(String.raw`\varepsilon X = X\varepsilon`),
        " を満たす行列とする（",
        ref("epsilon_commutes_with_transfer_matrices"),
        " より ",
        math(String.raw`V_1, V_2, V_1^{(+)}, (V_1^{(+)})^{1/2}`),
        " がこれにあたる）。次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)}X
&= \tfrac12\left(I + \varepsilon\right)X
   \quad (\because \blkref{def_epsilon_projectors}\ \text{の }P^{(+)}\text{ の定義}) \\
&= \tfrac12\left(IX + \varepsilon X\right)
   \quad (\because \text{分配法則}) \\
&= \tfrac12\left(X + \varepsilon X\right)
   \quad (\because IX=X) \\
&= \tfrac12\left(X + X\varepsilon\right)
   \quad (\because \text{仮定 }\varepsilon X=X\varepsilon) \\
&= \tfrac12\left(XI + X\varepsilon\right)
   \quad (\because X=XI) \\
&= X\cdot\tfrac12\left(I + \varepsilon\right)
   \quad (\because \text{分配法則とスカラー倍との可換性}) \\
&= X\,P^{(+)}
   \quad (\because \blkref{def_epsilon_projectors}\ \text{の }P^{(+)}\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\varepsilon`),
        " と可換な行列は ",
        math(String.raw`P^{(+)}`),
        " とも可換である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "もとの epsilon_commutes_with_transfer_matrices の Step 5 を、1 ブロック 1 主張に従って独立させた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },

]);
