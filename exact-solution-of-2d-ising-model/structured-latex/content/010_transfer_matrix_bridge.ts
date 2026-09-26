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
        ref("partition_function_via_transfer_matrix"),
        " の ",
        math(String.raw`Z(K_1,K_2) = \mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)`),
        " を、",
        ref("def_global_spin_flip_matrix"),
        " の全スピン反転行列 ",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        "、",
        math(String.raw`-1`),
        " の固有空間（セクター）ごとの和に分ける。",
      ]),
      paragraph([
        ref("def_epsilon_projectors"),
        " で ",
        math(String.raw`\varepsilon`),
        " の固有空間への射影子 ",
        math(String.raw`P^{(\pm)}`),
        " を定め、",
        ref("epsilon_projector_properties"),
        " でその性質を示す。",
        ref("def_V1_pm_square_root"),
        " で ",
        math(String.raw`(V_1^{(\pm)})^{1/2}`),
        " を定め、",
        ref("V1_pm_square_root_squares_to_V1_pm"),
        " でその二乗が ",
        ref("def_V1_pm"),
        " の ",
        math(String.raw`V_1^{(\pm)}`),
        " であることを示す。",
        ref("epsilon_commutes_with_transfer_matrices"),
        " と ",
        ref("epsilon_projectors_commute_with_transfer_matrices"),
        " で、",
        math(String.raw`\varepsilon`),
        " と ",
        math(String.raw`P^{(\pm)}`),
        " が ",
        math(String.raw`V_1, V_2, V_1^{(\pm)}, (V_1^{(\pm)})^{1/2}`),
        " と可換であることを示す。",
        ref("sector_replacement_of_V1"),
        " と ",
        ref("sector_replacement_pow"),
        " で、各セクター上では ",
        math(String.raw`V_1`),
        " を ",
        math(String.raw`V_1^{(\pm)}`),
        " に置き換えられることを示す。",
      ]),
      paragraph([
        "結論は ",
        ref("partition_function_sector_decomposition"),
        " の",
      ]),
      displayMath(
        String.raw`Z(K_1, K_2)
= \mathrm{tr}\!\left(P^{(+)}\left(V^{(+)}\right)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}\left(V^{(-)}\right)^{N_{\mathrm{row}}}\right),
\qquad V^{(\pm)} := (V_1^{(\pm)})^{1/2} V_2 (V_1^{(\pm)})^{1/2}`,
      ),
      paragraph([
        "である。これで分配関数が、各セクターの転送行列 ",
        math(String.raw`V^{(\pm)}`),
        " の冪のトレースで書ける。",
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
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について（複号同順）",
      ]),
      displayMath(
        String.raw`P^{(\pm)} := \tfrac{1}{2}\left(I \pm \varepsilon\right)
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
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし（複号同順）、",
        ref("def_V1_pm"),
        " の ",
        math(String.raw`V_1^{(\pm)}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\left(V_1^{(\pm)}\right)^{1/2}
:= \exp\!\left(\frac12 i K_1
\left(Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} \mp Y_{M_{\mathrm{col}}} Z_1\right)\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
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
        math(String.raw`G^{(\pm)}:=Y_1 Z_2+Y_2 Z_3+\cdots+Y_{M_{\mathrm{col}}-1}Z_{M_{\mathrm{col}}}\mp Y_{M_{\mathrm{col}}}Z_1`),
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
        ref("def_transfer_matrix"),
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
        String.raw`G^{(\pm)} := Y_1Z_2 + Y_2Z_3 + \cdots + Y_{M_{\mathrm{col}}-1}Z_{M_{\mathrm{col}}} \mp Y_{M_{\mathrm{col}}}Z_1`,
      ),
      paragraph([
        "これは各項が ",
        math(String.raw`Y\cdot Z`),
        " の形なので、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon G^{(\pm)}
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\varepsilon\,(Y_mZ_{m+1}) \mp \varepsilon\,(Y_{M_{\mathrm{col}}}Z_1)
   \quad (\because \text{行列積の有限和への分配}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}(Y_mZ_{m+1})\,\varepsilon \mp (Y_{M_{\mathrm{col}}}Z_1)\,\varepsilon
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
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。V_1, V_2 の参照先を <def_transfer_matrix> にし、パウリ行列表示を使う行の根拠を <first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> にした。",
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
        math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
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
        math(String.raw`\mathcal{F} = \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
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
    standing: "mainTheorem",
    origin: { path: SRC, ordinal: 14 },
    title: { text: "分配関数の偶奇セクター分解" },
    labels: ["partition_function_sector_decomposition"],
    statement: [
      paragraph([
        ref("partition_function_via_transfer_matrix"),
        " と同じ設定のもと、",
      ]),
      displayMath(
        String.raw`V^{(\pm)} := \left(V_1^{(\pm)}\right)^{1/2} V_2 \left(V_1^{(\pm)}\right)^{1/2},
\qquad \left(V_1^{(\pm)}\right)^{1/2} := \exp\!\left(\tfrac{1}{2}iK_1H_1^{(\pm)}\right)`,
      ),
      paragraph(["について"]),
      displayMath(
        String.raw`Z(K_1, K_2)
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
        String.raw`Z(K_1,K_2) = \tfrac{1}{2}\Bigl(
  \mathrm{tr}\bigl((V^{(+)})^{N_{\mathrm{row}}}\bigr)
+ \mathrm{tr}\bigl(\varepsilon\,(V^{(+)})^{N_{\mathrm{row}}}\bigr)
+ \mathrm{tr}\bigl((V^{(-)})^{N_{\mathrm{row}}}\bigr)
- \mathrm{tr}\bigl(\varepsilon\,(V^{(-)})^{N_{\mathrm{row}}}\bigr)
\Bigr)`,
      ),
      paragraph(["とも書ける。"]),
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
        math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
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
        ref("partition_function_via_transfer_matrix"),
        " の ",
        math(String.raw`X = (V_1V_2)^{N_{\mathrm{row}}}`),
        " に適用して",
      ]),
      displayMath(
        String.raw`Z(K_1,K_2)
= \mathrm{tr}\!\left(P^{(+)}(V_1V_2)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}(V_1V_2)^{N_{\mathrm{row}}}\right)
\quad (\because \blkref{partition_function_via_transfer_matrix}\text{ と上のトレース分解})`,
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
        String.raw`Z(K_1,K_2)
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
Z(K_1,K_2)
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
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。削除した <partition_function_in_pauli_form> の参照を <partition_function_via_transfer_matrix> へ付け替え、Z(J,J') を Z(K_1,K_2) にした。",
      ],
    },
  },
]);
