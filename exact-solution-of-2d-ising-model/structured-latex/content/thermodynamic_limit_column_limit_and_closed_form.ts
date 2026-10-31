import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「熱力学極限」の章「M→∞ の極限と閉形式」。章立て（`tools/chapter-plan.ts`）で
 * この章に割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_chapter_column_limit_and_closed_form",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`M\to\infty\text{ の極限と閉形式}` },
    labels: [],
  },
  {
    id: "closing_remark_overview_c_plus_and_onsager",
    kind: "remark",
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) \text{ を } \Lambda^{(1/2)}_{M_{\mathrm{col}}} \text{ で決め、} M_{\mathrm{col}}\to\infty \text{ の極限を取る道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " は ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルにわたる上限であり、",
        ref("symmetrized_transfer_matrix_on_sectors"),
        " の ",
        math(String.raw`WP^{(+)} = V^{(+)}P^{(+)}`),
        " により ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上では ",
        math(String.raw`W`),
        " と ",
        math(String.raw`V^{(+)}`),
        " が一致する。したがって、",
        ref("max_eigenvalue_of_V_plus_simple"),
        " の ",
        math(String.raw`V^{(+)}`),
        " の最大固有値 ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " について",
      ]),
      displayMath(
        String.raw`c_+(M_{\mathrm{col}}) \leq \check\Lambda_{\max}`,
      ),
      paragraph([
        "は容易である。逆向きの不等号には、",
        math(String.raw`\check\Lambda_{\max}`),
        " の固有ベクトルが ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " に属すること（",
        ref("max_eigenvector_in_even_sector"),
        "）を使う。",
      ]),
      paragraph([
        "そのうえで ",
        math(String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        "（",
        ref("c_plus_equals_Lambda_half_integer"),
        "）を示し、",
        math(String.raw`c(M_{\mathrm{col}})`),
        " を ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " と ",
        math(String.raw`2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " で挟む（",
        ref("c_between_Lambda_half_and_twice_Lambda_half"),
        "）。これを ",
        ref("onsager_free_energy_expression"),
        " と合わせて ",
        ref("remark_remaining_input_even_sector"),
        " の「残っている入力」を解消する（",
        ref("onsager_exact_solution"),
        "）。",
      ]),
      paragraph([
        "以下で用いる道具は、複素数を成分とする行列の積・和・スカラー倍、行列の指数関数（",
        ref("def_exp"),
        "）、有限個の実数の和と積、",
        math(String.raw`\cosh, \sinh, \log`),
        "、実数の上限、",
        ref("remark_real_analysis_escape_point"),
        " の (R0)（初等関数の連続性。",
        ref("gamma_is_continuous"),
        " が使う）、および ",
        ref("riemann_sum_to_integral"),
        "（等間隔点の平均の積分への収束）である。",
        ref("riemann_sum_to_integral"),
        " を引くのは ",
        ref("onsager_free_energy_expression"),
        " の証明であり、",
        ref("onsager_exact_solution"),
        " はそれを通して有限和の極限を積分として計算する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、旧い章の案内文 closing_000_remark_overview のうち c_+(M) と Onsager の自由エネルギーに関わる段落を、この案内文として 018 に残した（残りは V^{(+)} の最大固有値に属する固有ベクトルの章の案内文になった）。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章の冒頭へ移した。題に M_col→∞ の極限を足し、c(M) を Λ^{(1/2)}_M と 2Λ^{(1/2)}_M で挟む主張（c_between_Lambda_half_and_twice_Lambda_half）を道筋に足した。最後の段落の道具の列挙を、移した中身（実数の上限、gamma_is_continuous の (R0)、riemann_sum_to_integral を引く onsager_free_energy_expression）に合わせた。",
      ],
    },
  },

  {
    id: "maxeig_remark_overview_c_plus_and_epsilon",
    kind: "remark",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 2 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) \text{ と、} W \text{ と } \varepsilon \text{ の性質を示す道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " の固有空間 ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について次を示す。",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルにわたる上限 ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " を定め（",
        ref("def_sector_rayleigh_sup"),
        "）、",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " について ",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq c(M_{\mathrm{col}})`),
        " を示す（",
        ref("c_plus_le_c"),
        "）。",
        math(String.raw`W`),
        " が ",
        math(String.raw`\varepsilon`),
        " と可換で ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " を保つこと（",
        ref("epsilon_commutes_with_W"),
        "）、",
        math(String.raw`\varepsilon`),
        " が実対称であること（",
        ref("epsilon_is_real_symmetric"),
        "）を示す。",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上で ",
        math(String.raw`W`),
        " が ",
        math(String.raw`V^{(+)}`),
        " に一致すること ",
        math(String.raw`WP^{(+)} = V^{(+)}P^{(+)}`),
        "（",
        ref("symmetrized_transfer_matrix_on_sectors"),
        "）は、",
        ref("c_plus_equals_Lambda_half_integer"),
        " で ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " の値を求めるために使う。",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq c(M_{\mathrm{col}})`),
        " と ",
        math(String.raw`W`),
        "・",
        math(String.raw`\varepsilon`),
        " の性質は、",
        ref("c_between_Lambda_half_and_twice_Lambda_half"),
        " で ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " を ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " と ",
        math(String.raw`2c_+(M_{\mathrm{col}})`),
        " で挟むために使う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、旧い案内文 maxeig_000_remark_overview を N→∞ の極限と最大固有値 c(M) の章の冒頭へ移し、ここに残る c_+(M) と ε の性質を述べる段落だけをこの案内文とした。「偶セクター」を「ε の固有値 +1 の固有空間」に直し、c(M) の出どころ（def_rayleigh_sup）を添えた。数学の中身は変えていない。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した。WP^{(+)} = V^{(+)}P^{(+)} の使い先を c_plus_equals_Lambda_half_integer に、c(M) を c_+(M) と 2c_+(M) で挟む場所を、onsager_exact_solution の証明から独立させた c_between_Lambda_half_and_twice_Lambda_half に直した。",
      ],
    },
  },

  {
    id: "maxeig_004_claim_W_has_positive_entries",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 6 },
    title: { tex: String.raw`W \text{ の成分はすべて正}` },
    labels: ["W_has_positive_entries"],
    statement: [
      paragraph([
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " による番号付け（",
        ref("config_numbering_equals_kronecker_numbering"),
        "）のもとで、",
        ref("def_symmetrized_transfer_matrix"),
        " で定めた ",
        math(String.raw`W`),
        " のすべての成分は正の実数である：",
      ]),
      displayMath(
        String.raw`W_{\iota(\mu),\iota(\mu')} > 0 \qquad (\mu,\mu' \in \mathfrak{M})`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`V_1^{1/2}`),
        " は正の対角行列）。以下、周期端では ",
        math(String.raw`\mu(M_{\mathrm{col}}+1):=\mu(1)`),
        " と書く。",
        ref("def_transfer_matrix_square_root"),
        " の定義と ",
        ref("sigma_z_diagonal_action"),
        " より ",
        math(String.raw`D f_{\iota(\mu)} = \left(\sum_{m}\mu(m)\mu(m+1)\right)f_{\iota(\mu)}`),
        " なので ",
        math(String.raw`\tfrac12 K_1 D`),
        " は対角行列である。",
        ref("exp_of_diagonal_matrix"),
        " と ",
        ref("cosh_sinh_basic_properties"),
        " に記録した実指数関数の正値性より",
      ]),
      displayMath(
        String.raw`\left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu')}
= \begin{cases}
\exp\!\left(\tfrac{1}{2}K_1\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1)\right) > 0 & (\mu = \mu') \\
0 & (\mu \neq \mu')
\end{cases}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`V_2`),
        " の成分は正）。",
        ref("def_transfer_matrix"),
        " と ",
        ref("config_numbering_equals_kronecker_numbering"),
        "（行・列番号 ",
        math(String.raw`\nu(\iota(\mu)) = \mathrm{ord}(\mu)`),
        "）より ",
        math(String.raw`(V_2)_{\iota(\mu),\iota(\mu')} = \exp\!\left(K_2\sum_{m}\mu(m)\mu'(m)\right)`),
        " である。指数は実数なので、",
        ref("cosh_sinh_basic_properties"),
        " に記録した実指数関数の正値性より、この値は正である。",
      ]),
      paragraph(["Step 3。"]),
      displayMath(
        String.raw`\begin{aligned}
W_{\iota(\mu),\iota(\mu')}
&= \left(V_1^{1/2}\,V_2\,V_1^{1/2}\right)_{\iota(\mu),\iota(\mu')}
   \quad (\because W = V_1^{1/2}V_2V_1^{1/2}) \\
&= \sum_{j=1}^{2^{M_{\mathrm{col}}}}\sum_{k=1}^{2^{M_{\mathrm{col}}}}
   \left(V_1^{1/2}\right)_{\iota(\mu),j}\left(V_2\right)_{j,k}\left(V_1^{1/2}\right)_{k,\iota(\mu')}
   \quad (\because \text{行列の積の定義}) \\
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}}
   \left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu)}\left(V_2\right)_{\iota(\mu),k}\left(V_1^{1/2}\right)_{k,\iota(\mu')}
   \quad (\because \text{Step 1 の対角性で } j\neq\iota(\mu)\ \text{の項は } 0) \\
&= \left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu)}
   \left(V_2\right)_{\iota(\mu),\iota(\mu')}
   \left(V_1^{1/2}\right)_{\iota(\mu'),\iota(\mu')}
   \quad (\because \text{Step 1 の対角性で } k\neq\iota(\mu')\ \text{の項は } 0)
\end{aligned}`,
      ),
      paragraph([
        "3 つの因子はいずれも正の実数なので、積も正である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この正値性は、最大固有値が偶セクター（ε の固有値 +1 の側）で達成されることの理由でもある（Perron–Frobenius）。本文ではその事実を使っていないが、docs/tasks/free-energy-roadmap に次章の指針として記録した。数値でも M=2,3,4 で最大が (+) セクターにあることを確認している。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
      ],
    },
  },

  {
    id: "maxeig_010a_definition_sector_rayleigh_sup",
    kind: "definition",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 12 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) := \sup \mathcal{R}_+ \text{（}\mathcal{F}^{(+)}\text{ での上限）}` },
    labels: ["def_sector_rayleigh_sup"],
    statement: [
      paragraph([
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        " と ",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathcal{R}_+ := \left\{\, x^\top W x \ \middle|\ x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1 \,\right\},
\qquad c_+(M_{\mathrm{col}}) := \sup \mathcal{R}_+`,
      ),
      paragraph([
        "とおく。この上限が定まること、すなわち ",
        math(String.raw`\mathcal{R}_+`),
        " が空でなく上に有界であることを先に確かめる。上に有界なのは ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}} \subseteq \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " より ",
        math(String.raw`\mathcal{R}_+ \subseteq \mathcal{R}`),
        "（",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        "）であり、",
        math(String.raw`\mathcal{R}`),
        " が成分の絶対値の有限和 ",
        math(String.raw`\sum_{i,j}|W_{ij}|`),
        " で上に有界だからである（",
        ref("def_rayleigh_sup"),
        " の有界性の評価）。空でないことは、",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルを具体的に作れることから従う。",
      ]),
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix} \in \mathrm{Mat}(2,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`a_+ := \frac{1}{\sqrt{2}}\begin{pmatrix}1 \\ 1\end{pmatrix} \in \mathbb{R}^2,
\qquad
\sigma^x a_+ = \frac{1}{\sqrt{2}}\begin{pmatrix}1 \\ 1\end{pmatrix} = a_+`,
      ),
      paragraph([
        "とおき（右の等式は ",
        math(String.raw`2\times 2`),
        " 行列と ",
        math(String.raw`2`),
        " 次元数ベクトルの積の計算そのもの）、",
        ref("def_kronecker"),
        " (1) の数ベクトルのクロネッカー積で",
      ]),
      displayMath(
        String.raw`x^{(+)} := \overbrace{a_+ \boxtimes a_+ \boxtimes \cdots \boxtimes a_+}^{M_{\mathrm{col}}}
\quad \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`,
      ),
      paragraph([
        "と定める（",
        ref("def_kronecker"),
        " (1) より成分は各因子の成分の積だから、",
        math(String.raw`x^{(+)}`),
        " の各成分は ",
        math(String.raw`2^{-M_{\mathrm{col}}/2}`),
        " という実数であり、とくに ",
        math(String.raw`x^{(+)} \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "）。",
        ref("epsilon_square_and_eigenvalues"),
        " の証明で得た ",
        math(String.raw`\varepsilon = \sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " と ",
        ref("kronecker_product_rule"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,x^{(+)}
&= \left(\sigma^x\boxtimes\cdots\boxtimes\sigma^x\right)\left(a_+\boxtimes\cdots\boxtimes a_+\right)
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示と}\ x^{(+)}\ \text{の定義}) \\
&= \left(\sigma^xa_+\right)\boxtimes\cdots\boxtimes\left(\sigma^xa_+\right)
   \quad (\because \blkref{kronecker_product_rule}\ \text{(3)}) \\
&= a_+\boxtimes\cdots\boxtimes a_+
   \quad (\because \sigma^x a_+ = a_+\ \text{を各因子へ同時に適用}) \\
&= x^{(+)}
   \quad (\because x^{(+)}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。よって ",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`x^{(+)} \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " である。さらに ",
        math(String.raw`x^{(+)}`),
        " の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 個の成分はすべて ",
        math(String.raw`2^{-M_{\mathrm{col}}/2}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|x^{(+)}\right\|^2
&= \sum_{I \in \mathcal{I}_{M_{\mathrm{col}}}}\left(2^{-M_{\mathrm{col}}/2}\right)^2
   \quad (\because \blkref{def_matrix_norm}\ \text{の数ベクトルのノルムの定義と各成分の値}) \\
&= 2^{M_{\mathrm{col}}}\cdot 2^{-M_{\mathrm{col}}}
   \quad (\because \#\mathcal{I}_{M_{\mathrm{col}}} = 2^{M_{\mathrm{col}}}\ \text{と}\ \left(2^{-M_{\mathrm{col}}/2}\right)^2 = 2^{-M_{\mathrm{col}}}) \\
&= 1
   \quad (\because \text{指数法則})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\mathcal{I}_{M_{\mathrm{col}}}`),
        " は ",
        ref("def_kronecker"),
        " の添字集合）。したがって ",
        math(String.raw`\left(x^{(+)}\right)^\top Wx^{(+)} \in \mathcal{R}_+`),
        " で ",
        math(String.raw`\mathcal{R}_+ \neq \emptyset`),
        " であり、上限 ",
        math(String.raw`c_+(M_{\mathrm{col}}) \in \mathbb{R}`),
        " が定まる。上限の存在は ",
        ref("def_rayleigh_sup"),
        " と同じく、空でなく上に有界な実数の集合が上限をもつという ",
        math(String.raw`\mathbb{R}`),
        " の性質による（実数への脱出）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の分割で、上限のセクター分解のブロックから、セクターごとの上限の定義とその整合性（値の集合が空でなく上に有界であること）を独立させた。式変形と根拠は分割前と同じである。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。ε のクロネッカー積表示の参照先を <epsilon_square_and_eigenvalues> の証明に直し（旧参照 <def_eigenspaces_of_epsilon> にはこの表示が無い）、ε x^{(+)} = x^{(+)} とノルムの計算を一行一等号の鎖に開いた。",
      ],
    },
  },

  {
    id: "maxeig_claim_c_plus_le_c",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 12 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) \leq c(M_{\mathrm{col}})` },
    labels: ["c_plus_le_c"],
    statement: [
      paragraph([
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`c_+(M_{\mathrm{col}}) \in \mathbb{R}`),
        " と ",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        " について、",
      ]),
      displayMath(String.raw`c_+(M_{\mathrm{col}}) \leq c(M_{\mathrm{col}})`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}} \subseteq \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " なので、",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルは ",
        math(String.raw`\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルでもあり、",
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}_+`),
        " と ",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        " について ",
        math(String.raw`\mathcal{R}_+ \subseteq \mathcal{R}`),
        " である。",
        math(String.raw`\mathcal{R}_+`),
        " は空でない（",
        ref("def_sector_rayleigh_sup"),
        "）。上限の比較は ",
        math(String.raw`\mathbb{R}`),
        " の中で行う（両辺の上限はいずれも ",
        math(String.raw`\mathbb{R}`),
        " の上限の存在によって定まった実数である）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_+(M_{\mathrm{col}})
&= \sup \mathcal{R}_+
  \quad (\because \blkref{def_sector_rayleigh_sup}) \\
&\leq \sup \mathcal{R}
  \quad (\because \mathcal{R}_+ \subseteq \mathcal{R},\ \mathcal{R}_+ \neq \emptyset\ \text{と上限の単調性}) \\
&= c(M_{\mathrm{col}})
  \quad (\because \blkref{def_rayleigh_sup})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。最大値分解 c(M_col) = max(c_+(M_col), c_-(M_col)) のうち、最終定理が使う片側の不等式 c_+(M_col) ≤ c(M_col) だけを独立した主張として立てた（証明は最大値分解の証明の該当部分と同じ）。",
      ],
    },
  },

  {
    id: "maxeig_010b_claim_epsilon_commutes_with_W",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 12 },
    title: { tex: String.raw`\varepsilon W = W\varepsilon` },
    labels: ["epsilon_commutes_with_W"],
    statement: [
      paragraph([
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        " は全スピン反転行列 ",
        math(String.raw`\varepsilon`),
        " と可換である。したがって ",
        math(String.raw`W`),
        " は ",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " を保つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("epsilon_commutes_with_transfer_matrices"),
        " の Step 3 で ",
        math(String.raw`\varepsilon`),
        " が ",
        math(String.raw`D = \sum_m\sigma_m^z\sigma_{m+1}^z`),
        " と可換であることを示した。同 Step 2 と同じ議論（可換なら冪とも可換、部分和とも可換、極限とも可換）で ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`V_1^{1/2} = \exp(\tfrac12 K_1D)`),
        " と可換であり、同 Step 2 より ",
        math(String.raw`V_2`),
        " とも可換である。よって次の等式鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon W
&= \varepsilon V_1^{1/2}V_2V_1^{1/2}
   \quad (\because W=V_1^{1/2}V_2V_1^{1/2}) \\
&= V_1^{1/2}\varepsilon V_2V_1^{1/2}
   \quad (\because \varepsilon V_1^{1/2}=V_1^{1/2}\varepsilon) \\
&= V_1^{1/2}V_2\varepsilon V_1^{1/2}
   \quad (\because \varepsilon V_2=V_2\varepsilon) \\
&= V_1^{1/2}V_2V_1^{1/2}\varepsilon
   \quad (\because \varepsilon V_1^{1/2}=V_1^{1/2}\varepsilon) \\
&= W\varepsilon
   \quad (\because W=V_1^{1/2}V_2V_1^{1/2}).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`f \in \mathcal{F}^{(+)}`),
        " とすると、",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon f = f`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon(Wf)
&= (\varepsilon W)f
   \quad (\because \text{行列の積の結合則}) \\
&= (W\varepsilon)f
   \quad (\because \text{上の等式鎖 } \varepsilon W = W\varepsilon) \\
&= W(\varepsilon f)
   \quad (\because \text{行列の積の結合則}) \\
&= Wf
   \quad (\because \varepsilon f = f)
\end{aligned}`,
      ),
      paragraph([
        "なので ",
        math(String.raw`Wf \in \mathcal{F}^{(+)}`),
        "（",
        ref("def_even_eigenvectors_of_epsilon"),
        "）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の分割で、上限のセクター分解のブロックから、全スピン反転行列との可換性と固有空間の保存を独立させた。式変形と根拠は分割前と同じである。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },

  {
    id: "maxeig_claim_epsilon_is_real_symmetric",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 12 },
    title: { tex: String.raw`\varepsilon^\top = \varepsilon` },
    labels: ["epsilon_is_real_symmetric"],
    statement: [
      paragraph([
        ref("def_global_spin_flip_matrix"),
        " の全スピン反転行列 ",
        math(String.raw`\varepsilon \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は成分がすべて実数であり、転置について対称である。",
      ]),
      displayMath(String.raw`\varepsilon^\top = \varepsilon`),
    ],
    proof: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        " の成分はすべて実数（",
        math(String.raw`0`),
        " または ",
        math(String.raw`1`),
        "）であり、",
        ref("def_kronecker"),
        " (1) よりクロネッカー積の成分は各因子の成分の積だから、",
        math(String.raw`\varepsilon = \sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " の成分もすべて実数である。転置については",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon^\top
&=\left(\sigma^x\boxtimes\cdots\boxtimes\sigma^x\right)^\top
  \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示})\\
&=(\sigma^x)^\top\boxtimes\cdots\boxtimes(\sigma^x)^\top
  \quad (\because \blkref{kronecker_transpose})\\
&=\sigma^x\boxtimes\cdots\boxtimes\sigma^x
  \quad (\because \blkref{pauli_matrix_products}\ \text{の }\sigma^x\text{ の成分表示から }(\sigma^x)^\top=\sigma^x)\\
&=\varepsilon
  \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。旧 <sector_decomposition_of_rayleigh_sup> の証明の中にあった ε^⊤ = ε の導出を、最終定理が引く独立した主張として取り出した。",
      ],
    },
  },

  {
    id: "freeenergy_000_remark_escape_to_real_analysis",
    kind: "remark",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 2 },
    title: { text: "実数解析（Riemann 積分）へ移行する箇所" },
    labels: ["remark_real_analysis_escape_point"],
    statement: [
      paragraph([
        "分配関数の部から ",
        math(String.raw`N_{\mathrm{row}}\to\infty`),
        " の極限の章までは、複素数を成分とする有限サイズの行列の積・和・スカラー倍と、",
        "行列の指数関数（",
        ref("def_exp"),
        "：ノルムについて収束する級数）だけで書かれてきた。",
        "実数の極限は使ったが、積分は一度も使っていない。",
      ]),
      paragraph([
        "**",
        ref("onsager_free_energy_expression"),
        " の証明が ",
        ref("riemann_sum_to_integral"),
        " を引く箇所が、自由エネルギーの表式（",
        ref("onsager_exact_solution"),
        "）を得るまでに実数解析（Riemann 積分）へ移行する唯一の箇所である。**",
        ref("riemann_sum_to_integral"),
        " の証明が**積分について**外部から持ち込む事実は次の 2 つだけであり、",
        "この表式を得るまでの他の箇所では使わない。",
      ]),
      list([
        [
          "(R1) **Heine–Cantor**：有界閉区間 ",
          math(String.raw`[a,b] \subset \mathbb{R}`),
          " 上の連続関数は一様連続である。すなわち ",
          math(String.raw`\forall\epsilon>0\ \exists\delta>0`),
          " が存在して ",
          math(String.raw`|s-t|\leq\delta \Rightarrow |g(s)-g(t)|\leq\epsilon`),
          "。",
        ],
        [
          "(R2) **連続関数の Riemann 可積分性**：",
          math(String.raw`[a,b]`),
          " 上の連続関数 ",
          math(String.raw`g`),
          " は Riemann 積分可能で、積分は区間についての加法性 ",
          math(String.raw`\int_a^c = \int_a^b + \int_b^c`),
          " と評価 ",
          math(String.raw`\left|\int_a^b g\right| \leq (b-a)\sup_{[a,b]}|g|`),
          "、および定数の積分 ",
          math(String.raw`\int_a^b \lambda\,dt = \lambda(b-a)`),
          " を満たす。",
        ],
      ]),
      paragraph([
        "**積分とは別に、被積分関数の連続性を示すところでもう 1 種類の外部事実を使う。**",
        ref("gamma_is_continuous"),
        " の証明は、",
        math(String.raw`\gamma = \mathrm{arccosh}\circ\gamma_1`),
        " を初等関数の合成として書いて連続性を導くので、次を認める必要がある。",
      ]),
      list([
        [
          "(R0) **初等関数の連続性**：",
          math(String.raw`\cos : \mathbb{R}\to\mathbb{R}`),
          " は連続、",
          math(String.raw`\sqrt{\ \cdot\ } : \mathbb{R}_{\geq 0}\to\mathbb{R}`),
          " は連続、",
          math(String.raw`\log : \mathbb{R}_{>0}\to\mathbb{R}`),
          " は連続であり、連続関数の四則（分母が 0 にならない範囲）と合成は連続である。",
        ],
      ]),
      paragraph([
        "(R0) は Riemann 積分とは独立の事実であり、(R1)(R2) には含まれない。",
        "これも有限の代数計算では代用できないので、外部事実として明示的に数える。",
        "自由エネルギーの表式を得るまでに持ち込む実数解析の事実は (R0)(R1)(R2) の 3 種類でちょうど尽きている。",
      ]),
      paragraph([
        "移行が必要になる理由も明示しておく。",
        ref("partition_function_sandwich"),
        " と ",
        ref("limit_of_log_Z_in_N_row"),
        " により、鎖の長さ ",
        math(String.raw`M_{\mathrm{col}}`),
        " を固定したままの量 ",
        math(String.raw`\frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`),
        " までは有限の行列計算で到達する。",
        "しかし ",
        math(String.raw`M_{\mathrm{col}} \to \infty`),
        " で現れるのは ",
        math(String.raw`\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu-\frac12)}{M_{\mathrm{col}}}\right)`),
        " という**点の個数が増えていく有限和**であり、その極限を閉じた式で書くには",
        "「等間隔の点での値の平均が積分に収束する」という実数解析の事実が要る。",
        "ここだけは有限の代数計算では代用できない。",
      ]),
      paragraph([
        "**表式を得た後の臨界点の章では、得られた積分を微分するために",
        "外部事実を追加で持ち込む。** 追加分のうち (R3)(R4) は ",
        ref("remark_real_analysis_facts_R3_R4"),
        " に、(R5)(R6) は臨界点の章の冒頭に列挙し、",
        "自由エネルギーの表式を得るまでに持ち込む (R0)(R1)(R2) とは独立に管理する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した。「章 E（臨界点と比熱の対数発散）」を「臨界点の章」に直し、riemann_sum_to_integral が前の章（012）に残ったので、「この章の」「ここまでの章」を、移行する箇所（onsager_free_energy_expression の証明が riemann_sum_to_integral を引く箇所）と範囲（分配関数の部から N→∞ の極限の章まで）で書き直し、題を「実数解析（Riemann 積分）へ移行する箇所」にした。数学の中身は変えていない。",
        "2026-10-31: 臨界点の章を組み直し、remark_real_analysis_escape_chapter_E がこの章より後ろの臨界点の章の冒頭へ移ったので、それを指す参照を外し、(R3)(R4) は数学的道具立ての章の注記 remark_real_analysis_facts_R3_R4 を引き、(R5)(R6) は「臨界点の章の冒頭に列挙し」と書いた。",
      ],
    },
  },

  {
    id: "freeenergy_002_claim_gamma_is_continuous",
    kind: "claim",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 4 },
    title: { tex: String.raw`\gamma \text{ は } \mathbb{R} \text{ 上で連続}` },
    labels: ["gamma_is_continuous"],
    statement: [
      paragraph([
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma : \mathbb{R} \to \mathbb{R}_{\geq 0}`),
        " は連続であり、周期 ",
        math(String.raw`2\pi`),
        " をもつ：",
        math(String.raw`\gamma(\theta + 2\pi) = \gamma(\theta)`),
        "。",
      ]),
      paragraph([
        ref("riemann_sum_to_integral"),
        " を適用するために使うのは**連続性だけ**である。",
        "周期 ",
        math(String.raw`2\pi`),
        " をもつことは ",
        math(String.raw`\gamma`),
        " の性質として併せて述べておく（積分区間を ",
        math(String.raw`[0,2\pi]`),
        " に取れば十分であることの根拠にはなるが、",
        ref("riemann_sum_to_integral"),
        " の仮定には入っていない）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`\gamma_1`),
        " の連続性と周期性）。",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " は定数と ",
        math(String.raw`\cos`),
        " の 1 次式である。",
        math(String.raw`\cos`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続（",
        ref("remark_real_analysis_escape_point"),
        " の (R0)）で周期 ",
        math(String.raw`2\pi`),
        " をもつので、",
        math(String.raw`\gamma_1`),
        " も連続で周期 ",
        math(String.raw`2\pi`),
        " をもつ。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\mathrm{arccosh}`),
        " の連続性）。",
        math(String.raw`y \geq 1`),
        " とし、準備として",
      ]),
      displayMath(
        String.raw`u:=\log\left(y+\sqrt{y^2-1}\right)`,
      ),
      paragraph([
        "とおく。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(u)
&=y+\sqrt{y^2-1}
&&\left(\because\ \log\text{ と }\exp\text{ は正の実数上で互いに逆写像}\right),\\
\exp(-u)
&=\frac{1}{\exp(u)}
&&\left(\because\ \text{指数法則 }\exp(-u)\cdot \exp(u)=\exp(0)=1\right)\\
&=\frac{1}{y+\sqrt{y^2-1}}
&&\left(\because\ \text{上の }\exp(u)\text{ の表示}\right)\\
&=y-\sqrt{y^2-1}
&&\left(\because\ \text{分母の有理化と }y^2-(y^2-1)=1\right),\\
\cosh u
&=\frac{\exp(u)+\exp(-u)}{2}
&&\left(\because\ \cosh\text{ の定義}\right)\\
&=\frac{y+\sqrt{y^2-1}+y-\sqrt{y^2-1}}{2}
&&\left(\because\ \text{上の }\exp(u),\exp(-u)\text{ の表示}\right)\\
&=y
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
u
&=\log\left(y+\sqrt{y^2-1}\right)
&&\left(\because\ u\text{ の定義}\right)\\
&\geq\log 1
&&\left(\because\ y\geq1,\ \sqrt{y^2-1}\geq0,\ \log\text{ の単調性}\right)\\
&=0
&&\left(\because\ \log 1=0\right).
\end{aligned}`,
      ),
      paragraph(["したがって、"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(y)
&=u
&&\left(\because\ \blkref{def_arccosh}\text{ と }u\text{ の定義}\right)\\
&=\log\left(y+\sqrt{y^2-1}\right)
&&\left(\because\ u\text{ の定義}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`y \mapsto y^2-1`),
        " は連続で ",
        math(String.raw`[1,\infty)`),
        " 上非負、非負実数の平方根は連続、",
        math(String.raw`y+\sqrt{y^2-1} \geq 1 > 0`),
        " 上で ",
        math(String.raw`\log`),
        " は連続である（いずれも ",
        ref("remark_real_analysis_escape_point"),
        " の (R0)）。よって合成として ",
        math(String.raw`\mathrm{arccosh}`),
        " は ",
        math(String.raw`[1,\infty)`),
        " 上連続である。",
      ]),
      paragraph([
        "Step 3。",
        ref("gamma1_lower_bound_all_theta"),
        " より ",
        math(String.raw`\gamma_1(\mathbb{R}) \subseteq [1,\infty)`),
        " なので、連続写像の合成 ",
        math(String.raw`\gamma = \mathrm{arccosh}\circ\gamma_1`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続である。周期性は ",
        math(String.raw`\gamma_1`),
        " の周期性から従う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。arccosh の表示を確かめる e^u・e^{-u}・cosh u の計算が散文中に連結されていたのを、準備と一続きの式変形へ開き、根拠を各行末の (∵ …) へ移した。連続性・周期性の論法と参照は変更していない。",
      ],
    },
  },

  {
    id: "freeenergy_005_theorem_onsager_expression",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 7 },
    title: { text: "Onsager の自由エネルギーの表式" },
    labels: ["onsager_free_energy_expression"],
    statement: [
      paragraph([
        math(String.raw`\delta \in [0,1)`),
        " を固定し、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " について ",
        ref("def_Theta_delta_M"),
        " の ",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(\delta)}`),
        " と ",
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\Lambda^{(\delta)}_{M_{\mathrm{col}}}`),
        " を考える。このとき",
      ]),
      displayMath(
        String.raw`\lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\log \Lambda^{(\delta)}_{M_{\mathrm{col}}}
= \frac{1}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "が成り立つ。**右辺は ",
        math(String.raw`\delta`),
        " に依らない。** ここで",
      ]),
      displayMath(
        String.raw`\gamma(\theta) = \mathrm{arccosh}\left(\cosh 2K_1\cosh 2K_2^* - \sinh 2K_1 \sinh 2K_2^*\cos\theta\right)`,
      ),
      paragraph([
        "であり（",
        ref("def_gamma1_gamma2_of_theta"),
        "、",
        ref("def_gamma_theta"),
        "）、これが Onsager の自由エネルギーの表式である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\Lambda := \Lambda^{(\delta)}_{M_{\mathrm{col}}}`),
        " の ",
        math(String.raw`\log`),
        " を取る。",
        math(String.raw`2\sinh 2K_2 > 0`),
        "（",
        math(String.raw`K_2 > 0`),
        "）と ",
        math(String.raw`\exp`),
        " の正値性より ",
        math(String.raw`\Lambda > 0`),
        " なので ",
        math(String.raw`\log\Lambda`),
        " が定まり、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\log\Lambda^{(\delta)}_{M_{\mathrm{col}}}
&=\log\left(\left(2\sinh 2K_2\right)^{M_{\mathrm{col}}/2}
\exp\left(\frac{1}{2}\sum_{\theta\in\Theta_{M_{\mathrm{col}}}^{(\delta)}}\gamma(\theta)\right)\right)
&&\left(\because\ \Lambda^{(\delta)}_{M_{\mathrm{col}}}\text{ の定義。}\blkref{def_Lambda_delta_M}\right)\\
&=\log\left(\left(2\sinh 2K_2\right)^{M_{\mathrm{col}}/2}\right)
+\log\left(\exp\left(\frac{1}{2}\sum_{\theta\in\Theta_{M_{\mathrm{col}}}^{(\delta)}}\gamma(\theta)\right)\right)
&&\left(\because\ \text{積の対数 }\log(ab)=\log a+\log b\right)\\
&=\frac{M_{\mathrm{col}}}{2}\log\left(2\sinh 2K_2\right)
+\log\left(\exp\left(\frac{1}{2}\sum_{\theta\in\Theta_{M_{\mathrm{col}}}^{(\delta)}}\gamma(\theta)\right)\right)
&&\left(\because\ \text{冪の対数 }\log(x^{r})=r\log x\right)\\
&=\frac{M_{\mathrm{col}}}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{2}\sum_{\theta\in\Theta_{M_{\mathrm{col}}}^{(\delta)}}\gamma(\theta)
&&\left(\because\ \log(\exp(y))=y\right)
\end{aligned}`,
      ),
      paragraph(["を得る。"]),
      paragraph([
        "ここで集合 ",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(\delta)}`),
        " 上の和を添字 ",
        math(String.raw`\mu`),
        " についての和に書き換える。写像 ",
        math(String.raw`\mu \mapsto \dfrac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}`),
        " は ",
        math(String.raw`\{1,\dots,M_{\mathrm{col}}\}`),
        " 上単射である。実際、",
        math(String.raw`\mu,\nu\in\{1,\dots,M_{\mathrm{col}}\}`),
        " と ",
        math(String.raw`\mu \neq \nu`),
        " を仮定すると、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}-\frac{2\pi(\nu-\delta)}{M_{\mathrm{col}}}
&=\frac{2\pi(\mu-\nu)}{M_{\mathrm{col}}}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&\ne0
&&\left(\because\ \frac{2\pi}{M_{\mathrm{col}}}>0\text{ かつ }\mu-\nu\ne0\right)
\end{aligned}`,
      ),
      paragraph([
        "を得る。よって ",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(\delta)}`),
        " はちょうど ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個の元をもち、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\theta\in\Theta_{M_{\mathrm{col}}}^{(\delta)}}\gamma(\theta)
&=\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}\right)
&&\left(\because\ \mu\mapsto\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}\text{ は }\{1,\dots,M_{\mathrm{col}}\}\text{ から }\Theta_{M_{\mathrm{col}}}^{(\delta)}\text{ への全単射。}\blkref{def_Theta_delta_M}\right)
\end{aligned}`,
      ),
      paragraph([
        "を得る。また、",
        math(String.raw`M_{\mathrm{col}} > 0`),
        " なので、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(\delta)}_{M_{\mathrm{col}}}
&=\frac{1}{M_{\mathrm{col}}}\left(
  \frac{M_{\mathrm{col}}}{2}\log\left(2\sinh 2K_2\right)
  +\frac{1}{2}\sum_{\theta\in\Theta_{M_{\mathrm{col}}}^{(\delta)}}\gamma(\theta)
\right)
&&\left(\because\ \text{上で得た }\log\Lambda^{(\delta)}_{M_{\mathrm{col}}}\text{ の表示を代入}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2M_{\mathrm{col}}}\sum_{\theta\in\Theta_{M_{\mathrm{col}}}^{(\delta)}}\gamma(\theta)
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}\right)
&&\left(\because\ \text{上で得た添字の取り替え}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2}\cdot\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}\right)
&&\left(\because\ \mathbb{R}\text{ の四則}\right)
\end{aligned}`,
      ),
      paragraph([
        "第 1 項は ",
        math(String.raw`M_{\mathrm{col}}`),
        " に依らない定数である。第 2 項について、",
        ref("gamma_is_continuous"),
        " より ",
        math(String.raw`\gamma`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続であり、",
        math(String.raw`\delta \in [0,1) \subset [0,1]`),
        " なので、",
        ref("riemann_sum_to_integral"),
        " を ",
        math(String.raw`g = \gamma`),
        " として適用でき",
      ]),
      displayMath(
        String.raw`\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}\right)
\ \xrightarrow[M_{\mathrm{col}}\to\infty]{}\ \frac{1}{2\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "を得る。よって、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(\delta)}_{M_{\mathrm{col}}}
&=\lim_{M_{\mathrm{col}}\to\infty}\left(
  \frac{1}{2}\log\left(2\sinh 2K_2\right)
  +\frac{1}{2}\cdot\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}\right)
\right)
&&\left(\because\ \text{上で得た }\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(\delta)}_{M_{\mathrm{col}}}\text{ の表示を代入}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\lim_{M_{\mathrm{col}}\to\infty}\left(\frac{1}{2}\cdot\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}\right)\right)
&&\left(\because\ \text{収束する実数列に定数を加えた列は収束し、極限に定数が加わる}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2}\cdot\lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}}\right)
&&\left(\because\ \text{収束する実数列の定数倍は収束し、極限が定数倍になる}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2}\cdot\frac{1}{2\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta
&&\left(\because\ \text{上の収束（等間隔点の平均は積分に収束する）}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta
&&\left(\because\ \mathbb{R}\text{ の四則 }\frac12\cdot\frac1{2\pi}=\frac1{4\pi}\right)
\end{aligned}`,
      ),
      paragraph([
        "が成り立ち、主張の式を得る（第 2 行・第 3 行の極限法則が適用できるのは、第 4 行で引いた ",
        ref("riemann_sum_to_integral"),
        " の収束が第 2 項の収束を与えるからである）。",
        ref("riemann_sum_to_integral"),
        " の極限が ",
        math(String.raw`\delta`),
        " に依らないので、右辺も ",
        math(String.raw`\delta`),
        " に依らない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },

  {
    id: "freeenergy_006_remark_remaining_input",
    kind: "remark",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 8 },
    title: { tex: String.raw`\text{厳密解へ残っている入力：} c_+(M_{\mathrm{col}}) \text{ の値}` },
    labels: ["remark_remaining_input_even_sector"],
    statement: [
      paragraph([
        "ここまでで得られたものを並べると、分配関数から自由エネルギーまでの経路は次のようになっている。",
      ]),
      list([
        [
          ref("partition_function_via_transfer_matrix"),
          "：",
          math(String.raw`Z = \mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)`),
        ],
        [
          ref("partition_function_sandwich"),
          "：",
          math(String.raw`c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \leq Z \leq 2^{M_{\mathrm{col}}}c(M_{\mathrm{col}})^{N_{\mathrm{row}}}`),
        ],
        [
          ref("limit_of_log_Z_in_N_row"),
          "：",
          math(String.raw`\dfrac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z \to \dfrac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`),
        ],
        [
          ref("c_plus_le_c"),
          "：",
          math(String.raw`c_+(M_{\mathrm{col}}) \leq c(M_{\mathrm{col}})`),
        ],
        [
          ref("onsager_free_energy_expression"),
          "：",
          math(String.raw`\dfrac{1}{M_{\mathrm{col}}}\log\Lambda^{(\delta)}_{M_{\mathrm{col}}} \to \dfrac12\log(2\sinh 2K_2) + \dfrac1{4\pi}\displaystyle\int_0^{2\pi}\gamma`),
          "（",
          math(String.raw`\delta`),
          " に依らない）",
        ],
      ]),
      paragraph([
        "**残っている入力は 1 つだけである**（",
        "これは固有値問題の部で求めた ",
        math(String.raw`V^{(+)}`),
        " の固有値から ",
        ref("c_plus_equals_Lambda_half_integer"),
        " で示す。最終的な結論は ",
        ref("onsager_exact_solution"),
        "）：",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        "（",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " の固有空間での上限）が ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " に等しいこと、すなわち ",
        math(String.raw`V^{(+)}`),
        " の固有値が ",
        math(String.raw`\tilde\theta_\mu = 2\pi(\mu-\tfrac12)/M_{\mathrm{col}}`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "）での ",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " で与えられることである。",
        "上からの評価 ",
        math(String.raw`c(M_{\mathrm{col}}) \leq 2c_+(M_{\mathrm{col}})`),
        " は、",
        ref("W_has_positive_entries"),
        " の成分の正値性から ",
        ref("c_between_Lambda_half_and_twice_Lambda_half"),
        " で示す。",
      ]),
      paragraph([
        math(String.raw`V^{(+)}`),
        " を作る ",
        math(String.raw`H_1^{(+)}`),
        "（",
        ref("def_H1_plus"),
        "）は、境界項 ",
        math(String.raw`-Y_{M_{\mathrm{col}}}Z_1`),
        " を持つ：",
      ]),
      displayMath(String.raw`H_1^{(+)} = \sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1`),
      paragraph([
        "この符号のため、",
        math(String.raw`V^{(+)}`),
        " を対角化する行列は、",
        math(String.raw`\tilde\theta_\mu`),
        "（",
        ref("antiperiodic_exp_sum"),
        "）で ",
        math(String.raw`Z_j, Y_j`),
        " を離散 Fourier 変換した",
      ]),
      displayMath(
        String.raw`\check{Z}_\mu := \sum_{j=1}^{M_{\mathrm{col}}} Z_j\,\exp(-i j \tilde\theta_\mu),\qquad
\check{Y}_\mu := \sum_{j=1}^{M_{\mathrm{col}}} Y_j\,\exp(-i j \tilde\theta_\mu),\qquad
\tilde\theta_\mu := \frac{2\pi\left(\mu-\tfrac12\right)}{M_{\mathrm{col}}}`,
      ),
      paragraph([
        "になる（",
        ref("def_half_integer_checkZ"),
        "、",
        ref("def_half_integer_checkY"),
        "）。この ",
        math(String.raw`\check{Z}, \check{Y}`),
        " は ",
        math(String.raw`H_1^{(+)}, H_2`),
        " との交換関係 (A)〜(D) を満たし（",
        ref("commutator_of_H_and_check_Z_Y"),
        "）、反交換関係の対は ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " になる（",
        ref("anticommutator_of_check_Z_Y"),
        "）。",
        "**この道筋は固有値問題の部で本文として実行済みであり、以降の証明の根拠として使ってよい。**",
        "到達点は ",
        ref("c_plus_equals_Lambda_half_integer"),
        " の ",
        math(String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " と ",
        ref("onsager_exact_solution"),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "V^{(+)} の固有値が半整数運動量で与えられることは M=2,3,4 で数値的に確認済み（相対誤差 1e-14 以下、整数運動量では 0.5〜2.4 の相対差で明確に不一致）。また最大固有値が (+) セクターで達成されることも M=2,3,4 で確認した（W の成分がすべて正なので Perron–Frobenius から期待される通り）。これらは sagemath/check/044_claim_max_eigenvalue/ と 045_claim_free_energy/ に記録した。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した。「013 章から 018 章」を「固有値問題の部」に、「セクター」「半整数運動量」「偶セクターの転送行列」「モード」を、ε の固有空間・θ̃_μ・V^{(+)}・Ž_μ, Y̌_μ で指す言い方に直し、上からの評価の場所を c_between_Lambda_half_and_twice_Lambda_half に付け替えた。数学の中身は変えていない。",
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
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した（c_plus_equals_Lambda_half_integer の証明が引く check_number_operator_is_hermitian の証明がこの主張を使う）。",
      ],
    },
  },

  {
    id: "closing_008_claim_check_Q_is_hermitian",
    kind: "claim",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 10 },
    title: { tex: String.raw`\check{n}_\mu, \check{Q}_\epsilon \text{ はエルミート}` },
    labels: ["check_number_operator_is_hermitian"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " とする。",
        math(String.raw`X^*`),
        " を ",
        ref("def_hermitian_positive_definite"),
        " の転置共役とすると、",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad Z_j^* = Z_j, \qquad Y_j^* = Y_j
\qquad (j \in \{1,\dots,M_{\mathrm{col}}\})`),
        ],
        [
          math(String.raw`\text{(2)}\quad \check{Z}_\mu^* = \check{Z}_{M_{\mathrm{col}}+1-\mu},
\qquad \check{Y}_\mu^* = \check{Y}_{M_{\mathrm{col}}+1-\mu}`),
        ],
        [
          math(String.raw`\text{(3)}\quad \left(\check\psi_\mu^\dagger\right)^*
= \check\psi_{M_{\mathrm{col}}+1-\mu}`),
        ],
        [
          math(String.raw`\text{(4)}\quad \check{n}_\mu^* = \check{n}_\mu,
\qquad \check{Q}_\epsilon^* = \check{Q}_\epsilon
\qquad \left(\epsilon \in \{0,1\}^{\check{\mathcal{M}}}\right)`),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\check{Q}_\epsilon`),
        " はエルミートな冪等行列なので、任意の ",
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " について",
      ]),
      displayMath(
        String.raw`x^*\check{Q}_\epsilon x
= x^*\check{Q}_\epsilon^*\check{Q}_\epsilon x
= \left\|\check{Q}_\epsilon x\right\|^2 \geq 0`,
      ),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("Z_Y_linearly_independent"),
        " の証明で用いた Pauli 行列の成分表示より ",
        math(String.raw`\left(\sigma^x\right)^* = \sigma^x`),
        "、",
        math(String.raw`\left(\sigma^y\right)^* = \sigma^y`),
        "、",
        math(String.raw`\left(\sigma^z\right)^* = \sigma^z`),
        " である（",
        math(String.raw`\sigma^y`),
        " は転置で ",
        math(String.raw`(1,2)`),
        " 成分 ",
        math(String.raw`-i`),
        " と ",
        math(String.raw`(2,1)`),
        " 成分 ",
        math(String.raw`i`),
        " が入れ替わり、複素共役でさらに符号が戻る）。",
        ref("kronecker_product_rule"),
        " (2) の成分の定義より ",
        math(String.raw`\left(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}\right)^*
= A_1^*\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}^*`),
        " なので ",
        math(String.raw`\left(\sigma_k^a\right)^* = \sigma_k^a`),
        "（",
        math(String.raw`a \in \{x,y,z\}`),
        "）。",
      ]),
      paragraph([
        math(String.raw`(XW)^* = W^*X^*`),
        " と、相異なるサイトの因子が可換であること（",
        ref("kronecker_product_rule"),
        " (1)）から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_j^*
&= \left(\sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z\right)^*
   \quad (\because \text{def\_transfer\_matrix\_symbols}) \\
&= \left(\sigma_j^z\right)^*\left(\sigma_{j-1}^x\right)^*\cdots\left(\sigma_1^x\right)^*
   \quad (\because (XW)^* = W^*X^*) \\
&= \sigma_j^z\,\sigma_{j-1}^x\cdots\sigma_1^x
   \quad (\because \text{直前の段落}) \\
&= \sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z
   \quad (\because \text{相異なるサイトの因子は可換}) \\
&= Z_j
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_j`),
        " も同じ計算である。",
      ]),
      paragraph([
        "(2) ",
        ref("conjugate_index_of_check_Z_Y"),
        " (2) より ",
        math(String.raw`\exp(-ij\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \exp(ij\tilde\theta_\mu)`),
        " である。",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        " なので ",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`\overline{\exp(-ij\tilde\theta_\mu)} = \exp(ij\tilde\theta_\mu)`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_\mu^*
&= \left(\sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)Z_j\right)^*
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\overline{\exp(-ij\tilde\theta_\mu)}\;Z_j^*
   \quad (\because \text{転置共役は和を保ち、スカラー倍を複素共役つきで保つ}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\exp(ij\tilde\theta_\mu)\,Z_j
   \quad (\because \text{(1) と } \tilde\theta_\mu \in \mathbb{R}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_{M_{\mathrm{col}}+1-\mu})\,Z_j
   \quad (\because \text{conjugate\_index\_of\_check\_Z\_Y (2)}) \\
&= \check{Z}_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{def\_half\_integer\_modes})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\check{Y}_\mu`),
        " も同じ計算である（",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " なので右辺は定義されている）。",
      ]),
      paragraph([
        "(3) ",
        ref("def_check_fermi"),
        " より、",
        math(String.raw`\nu := M_{\mathrm{col}}+1-\mu`),
        "、",
        math(String.raw`\beta := \dfrac{1}{2\sqrt{M_{\mathrm{col}}}} \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`\alpha_\mu := \dfrac{-\left|\gamma_2(\tilde\theta_\mu)\right|}
{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)}`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\check\psi_\mu^\dagger = \alpha_\mu\check{Z}_\mu + \beta\check{Y}_\mu,
\qquad
\check\psi_\nu = -\alpha_\nu\check{Z}_\nu + \beta\check{Y}_\nu`,
      ),
      paragraph([
        "である。まず ",
        math(String.raw`\overline{\alpha_\mu} = -\alpha_\nu`),
        " を示す。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の ",
        math(String.raw`\gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)}`),
        " より ",
        math(String.raw`\left|\gamma_2(-\tilde\theta_\mu)\right|
= \left|\gamma_2(\tilde\theta_\mu)\right|`),
        " であり、",
        ref("periodicity_of_check_fermi"),
        " (3) より ",
        math(String.raw`\gamma_2(\tilde\theta_\nu) = \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`\gamma_2(-\tilde\theta_\nu) = \gamma_2(\tilde\theta_\mu)`),
        " である。よって ",
        math(String.raw`r := \left|\gamma_2(\tilde\theta_\mu)\right|
= \left|\gamma_2(\tilde\theta_\nu)\right| \in \mathbb{R}_{>0}`),
        "（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）と書けて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\overline{\alpha_\mu}
&= \overline{\left(\frac{-r}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)}\right)}
   \quad (\because \alpha_\mu \text{ の定義}) \\
&= \frac{-r}{2\sqrt{M_{\mathrm{col}}}\,\overline{\gamma_2(-\tilde\theta_\mu)}}
   \quad \left(\because r, 2\sqrt{M_{\mathrm{col}}} \in \mathbb{R} \text{ と }
   \overline{z^{-1}} = \left(\bar z\right)^{-1}\right) \\
&= \frac{-r}{2\sqrt{M_{\mathrm{col}}}\left(-\gamma_2(\tilde\theta_\mu)\right)}
   \quad \left(\because \text{relation\_of\_gamma\_2\_theta\_tilde (1) を }
   \overline{\gamma_2(-\tilde\theta_\mu)} = -\gamma_2(\tilde\theta_\mu)
   \text{ の形で使う}\right) \\
&= \frac{r}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(\tilde\theta_\mu)} \\
&= \frac{r}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\nu)}
   \quad (\because \text{periodicity\_of\_check\_fermi (3)}) \\
&= -\alpha_\nu
   \quad (\because \alpha_\nu \text{ の定義と }
   \left|\gamma_2(\tilde\theta_\nu)\right| = r)
\end{aligned}`,
      ),
      paragraph([
        "（3 段目で使った ",
        math(String.raw`\overline{\gamma_2(-\tilde\theta_\mu)} = -\gamma_2(\tilde\theta_\mu)`),
        " は、",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の両辺の複素共役を取り ",
        math(String.raw`\overline{\overline{z}} = z`),
        " を使ったものである。）これを使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\check\psi_\mu^\dagger\right)^*
&= \left(\alpha_\mu\check{Z}_\mu + \beta\check{Y}_\mu\right)^*
   \quad (\because \text{def\_check\_fermi}) \\
&= \overline{\alpha_\mu}\,\check{Z}_\mu^* + \overline{\beta}\,\check{Y}_\mu^*
   \quad (\because \text{転置共役の線型性（複素共役つき）}) \\
&= \overline{\alpha_\mu}\,\check{Z}_\nu + \beta\,\check{Y}_\nu
   \quad (\because \text{(2) と } \beta \in \mathbb{R}) \\
&= -\alpha_\nu\check{Z}_\nu + \beta\check{Y}_\nu
   \quad \left(\because \overline{\alpha_\mu} = -\alpha_\nu\right) \\
&= \check\psi_\nu
   \quad (\because \text{def\_check\_fermi})
\end{aligned}`,
      ),
      paragraph([
        "(4) (3) の両辺の転置共役を取り ",
        math(String.raw`(X^*)^* = X`),
        " を使うと ",
        math(String.raw`\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^* = \check\psi_\mu^\dagger`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu^*
&= \left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^*
&&\left(\because\ \text{def\_check\_fermi}\right)\\
&= \left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^*\left(\check\psi_\mu^\dagger\right)^*
&&\left(\because\ (XW)^*=W^*X^*\right)\\
&= \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}
&&\left(\because\ \text{(3) とその転置共役}\right)\\
&= \check{n}_\mu
&&\left(\because\ \text{def\_check\_fermi}\right)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M_{\mathrm{col}}}R_\mu^{(\epsilon_\mu)}`),
        "（",
        math(String.raw`R_\mu^{(1)} = \check{n}_\mu`),
        "、",
        math(String.raw`R_\mu^{(0)} = I - \check{n}_\mu`),
        "）について、各因子はエルミートで（",
        math(String.raw`I^* = I`),
        "）、",
        ref("check_number_operators_commute"),
        " (2) より互いに可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon^*
&= \left(R_1^{(\epsilon_1)}\cdots R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}\right)^*
&&\left(\because\ \text{check\_joint\_eigenspace\_decomposition}\right)\\
&= \left(R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}\right)^*\cdots\left(R_1^{(\epsilon_1)}\right)^*
&&\left(\because\ (XW)^*=W^*X^*\text{ の反復適用}\right)\\
&= R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}\cdots R_1^{(\epsilon_1)}
&&\left(\because\ \check n_\mu^*=\check n_\mu\text{ と }I^*=I\right)\\
&= R_1^{(\epsilon_1)}\cdots R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}
&&\left(\because\ \text{因子の可換性。check\_number\_operators\_commute (2)}\right)\\
&= \check{Q}_\epsilon
&&\left(\because\ \text{check\_joint\_eigenspace\_decomposition}\right)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " (1) の ",
        math(String.raw`\check{Q}_\epsilon^2 = \check{Q}_\epsilon`),
        " と合わせると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*\check{Q}_\epsilon x
&=x^*\check{Q}_\epsilon^*\check{Q}_\epsilon x
&&\left(\because\ \check{Q}_\epsilon^*=\check{Q}_\epsilon\text{ と }\check{Q}_\epsilon^2=\check{Q}_\epsilon\right)\\
&=\left(\check{Q}_\epsilon x\right)^*\left(\check{Q}_\epsilon x\right)
&&\left(\because\ (XW)^*=W^*X^*\right)\\
&=\left\|\check{Q}_\epsilon x\right\|^2
&&\left(\because\ \text{複素ベクトルのノルムの定義}\right)\\
&\geq0
&&\left(\because\ \text{実数の平方和は非負}\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "c_+(M) ≤ Λ̌_max を示すのに必要なのは「Q̌_ε がエルミートな冪等行列であること」だけである。これがあれば x^*V^{(+)}x = Σ_ε Λ̌_ε ‖Q̌_ε x‖² と書けて、スペクトル定理（実対称行列の対角化可能性）を持ち出さずに Rayleigh 商の上限が押さえられる。011 章が「固有値の存在を使わない」方針を取っているのと整合する。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_04（(ψ̌_μ^†)^* = ψ̌_{M+1−μ}、ň_μ, Q̌_ε のエルミート性、残差 ≤ 1.2e-14）。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した（c_plus_equals_Lambda_half_integer の証明が (4) を引く）。",
      ],
    },
  },

  {
    id: "closing_009_theorem_c_plus_equals_Lambda_half",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 11 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}` },
    labels: ["c_plus_equals_Lambda_half_integer"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_sector_rayleigh_sup"),
        " の",
      ]),
      displayMath(
        String.raw`c_+(M_{\mathrm{col}}) = \sup\left\{\, x^\top W x \ \middle|\
x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1 \,\right\}`,
      ),
      paragraph([
        "と ",
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " について",
      ]),
      displayMath(
        String.raw`c_+(M_{\mathrm{col}}) = \check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}
= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\right)`,
      ),
      paragraph([
        "が成り立つ。**上限は達成される**（最大値である）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上で ",
        math(String.raw`W`),
        " と ",
        math(String.raw`V^{(+)}`),
        " が一致すること）。",
        math(String.raw`x \in \mathcal{F}^{(+)}`),
        " なら、",
        ref("def_epsilon_projectors"),
        " と ",
        ref("def_even_eigenvectors_of_epsilon"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)}x
&= \tfrac12(x + \varepsilon x)
   \quad (\because \blkref{def_epsilon_projectors}\text{ の } P^{(+)} \text{ の定義}) \\
&= \tfrac12(x + x)
   \quad (\because x \in \mathcal{F}^{(+)} \text{ より } \varepsilon x = x.\ \blkref{def_even_eigenvectors_of_epsilon}) \\
&= x
   \quad (\because \text{スカラー倍を整理する})
\end{aligned}`,
      ),
      paragraph([
        "である。したがって ",
        ref("symmetrized_transfer_matrix_on_sectors"),
        " の ",
        math(String.raw`WP^{(+)} = V^{(+)}P^{(+)}`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Wx
&= WP^{(+)}x
   \quad (\because \text{直前の } P^{(+)}x = x) \\
&= V^{(+)}P^{(+)}x
   \quad (\because \blkref{symmetrized_transfer_matrix_on_sectors}\text{ の }
   WP^{(+)} = V^{(+)}P^{(+)}) \\
&= V^{(+)}x
   \quad (\because \text{直前の } P^{(+)}x = x)
\end{aligned}
\qquad \left(x \in \mathcal{F}^{(+)}\right)`,
      ),
      paragraph([
        "Step 1（",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq \check\Lambda_{\max}`),
        "）。",
        math(String.raw`x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " とする。",
        math(String.raw`x`),
        " は実ベクトルなので ",
        math(String.raw`x^\top = x^*`),
        " である。",
        ref("check_joint_eigenspace_decomposition"),
        " (2) と ",
        ref("eigenvalues_of_V_plus"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top W x
&= x^*V^{(+)}x
   \quad (\because \text{Step 0 と } x^\top = x^*) \\
&= x^*V^{(+)}\left(\sum_{\epsilon}\check{Q}_\epsilon\right)x
   \quad (\because \blkref{check_joint_eigenspace_decomposition}\text{ (2)}) \\
&= \sum_{\epsilon}\check\Lambda_\epsilon\,x^*\check{Q}_\epsilon x
   \quad (\because \blkref{eigenvalues_of_V_plus}\text{ (1)}) \\
&= \sum_{\epsilon}\check\Lambda_\epsilon
   \left\|\check{Q}_\epsilon x\right\|^2
   \quad (\because \blkref{check_number_operator_is_hermitian}\text{ (4)})
\end{aligned}`,
      ),
      paragraph([
        ref("eigenvalues_of_V_plus"),
        " (2) より ",
        math(String.raw`0 < \check\Lambda_\epsilon \leq \check\Lambda_{\max}`),
        " であり、各 ",
        math(String.raw`\left\|\check{Q}_\epsilon x\right\|^2 \geq 0`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top Wx
&\leq \check\Lambda_{\max}
 \sum_{\epsilon}\left\|\check{Q}_\epsilon x\right\|^2
 &&\left(\because\ 0<\check\Lambda_\epsilon\leq\check\Lambda_{\max}
 \text{ と }\left\|\check{Q}_\epsilon x\right\|^2\geq0\right)\\
&= \check\Lambda_{\max}\sum_{\epsilon}x^*\check{Q}_\epsilon x
 &&\left(\because\ \check Q_\epsilon\text{ はエルミートな冪等行列}
 \text{（}\blkref{check_number_operator_is_hermitian}\text{ (4)）}\right)\\
&= \check\Lambda_{\max}\,x^*\!\left(\sum_{\epsilon}\check{Q}_\epsilon\right)\!x
 &&\left(\because\ \text{有限和に対する行列積の分配則}\right)\\
&= \check\Lambda_{\max}\,x^*x
 &&\left(\because\ \sum_\epsilon\check Q_\epsilon=I
 \text{（}\blkref{check_joint_eigenspace_decomposition}\text{ (2)）}\right)\\
&= \check\Lambda_{\max}\,\|x\|^2
 &&\left(\because\ \text{複素ベクトルのノルムの定義}\right)\\
&= \check\Lambda_{\max}
 &&\left(\because\ \|x\|=1\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x`),
        " は任意だったので ",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq \check\Lambda_{\max}`),
        "。",
      ]),
      paragraph([
        "Step 2（実の最大固有ベクトルの存在）。",
        ref("check_joint_eigenspace_decomposition"),
        " (4) より ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " は 1 次元なので、生成元 ",
        math(String.raw`q \neq 0`),
        " を取る。",
        ref("eigenvalues_of_V_plus"),
        " (1) より ",
        math(String.raw`V^{(+)}q = \check\Lambda_{\max}q`),
        " である。",
      ]),
      paragraph([
        math(String.raw`V^{(+)}`),
        " の成分は実である。実際 ",
        ref("V_plus_is_positive_definite"),
        " の表示 ",
        math(String.raw`V^{(+)} = (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(\tfrac12S_1^{(+)}\right)
\exp(S_2)\exp\!\left(\tfrac12S_1^{(+)}\right)`),
        " において、",
        ref("iH_is_real_symmetric"),
        " より ",
        math(String.raw`S_1^{(+)}, S_2`),
        " は実対称であり、",
        ref("W_is_real_symmetric_positive_definite"),
        " の Step 2 と同じ議論（実対称行列の冪は実対称、",
        ref("def_exp"),
        " の部分和も実対称、",
        ref("star_preserves_norm_and_limits"),
        " (3) と同様に転置もノルムを保つので極限も実対称）により ",
        math(String.raw`\exp\!\left(\tfrac12S_1^{(+)}\right)`),
        " と ",
        math(String.raw`\exp(S_2)`),
        " は実対称、",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} \in \mathbb{R}_{>0}`),
        " なので ",
        math(String.raw`V^{(+)}`),
        " も実行列である。",
      ]),
      paragraph([
        "したがって ",
        math(String.raw`\overline{V^{(+)}q} = V^{(+)}\overline{q}`),
        " であり、",
        math(String.raw`\check\Lambda_{\max} \in \mathbb{R}`),
        "（",
        ref("eigenvalues_of_V_plus"),
        "）なので ",
        math(String.raw`V^{(+)}\overline{q} = \check\Lambda_{\max}\overline{q}`),
        "。",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (3) より固有空間は 1 次元の ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)} = \mathbb{C}q`),
        " なので、ある ",
        math(String.raw`z \in \mathbb{C}`),
        " で ",
        math(String.raw`\overline{q} = zq`),
        " と書ける。",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`p := q + \overline{q} = (1+z)q`),
        "、",
        math(String.raw`p' := i\left(q - \overline{q}\right) = i(1-z)q`),
        " とおくと、",
        math(String.raw`\overline{p} = p`),
        "、",
        math(String.raw`\overline{p'} = \overline{i}\left(\overline{q}-q\right)
= (-i)\left(\overline{q}-q\right) = p'`),
        " なので ",
        math(String.raw`p, p'`),
        " はいずれも実ベクトルである。",
        math(String.raw`1+z`),
        " と ",
        math(String.raw`i(1-z)`),
        " が同時に ",
        math(String.raw`0`),
        " になることはない（",
        math(String.raw`z = -1`),
        " かつ ",
        math(String.raw`z = 1`),
        " は不可能）ので、",
        math(String.raw`p`),
        " と ",
        math(String.raw`p'`),
        " の少なくとも一方は ",
        math(String.raw`0`),
        " でない。それを ",
        math(String.raw`v`),
        " とすると ",
        math(String.raw`v \in \mathbb{C}q\setminus\{0\}`),
        " かつ ",
        math(String.raw`v \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " である。",
        math(String.raw`x_0 := v/\|v\|`),
        " とおく。",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`c_+(M_{\mathrm{col}}) \geq \check\Lambda_{\max}`),
        "）。",
        math(String.raw`x_0 \in \mathbb{C}q = \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " なので ",
        ref("max_eigenvector_in_even_sector"),
        " (4) より ",
        math(String.raw`x_0 \in \mathcal{F}^{(+)}`),
        " であり、",
        math(String.raw`x_0`),
        " は実で ",
        math(String.raw`\|x_0\| = 1`),
        " である。Step 0 と ",
        ref("eigenvalues_of_V_plus"),
        " (1) より",
      ]),
      displayMath(
        String.raw`x_0^\top Wx_0
= x_0^\top V^{(+)}x_0
= x_0^\top\left(\check\Lambda_{\max}x_0\right)
= \check\Lambda_{\max}\,x_0^\top x_0
= \check\Lambda_{\max}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " を定める集合は ",
        math(String.raw`\check\Lambda_{\max}`),
        " を要素にもち、",
        math(String.raw`c_+(M_{\mathrm{col}}) \geq \check\Lambda_{\max}`),
        "。Step 1 と合わせて ",
        math(String.raw`c_+(M_{\mathrm{col}}) = \check\Lambda_{\max}`),
        " であり、上限は ",
        math(String.raw`x_0`),
        " で達成される。",
      ]),
      paragraph([
        "最後に ",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (1) の ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " を代入すれば主張の等式を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "分割前の上限のセクター分解の注記が「c_+(M) に対応する V^{(+)} の固有値は本文では未確立」としていた点が、ここで解消される。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_04（P^{(+)}WP^{(+)} を F^{(+)} の実基底へ制限して最大固有値を直接求め、Λ^{(1/2)}_M と比較。相対差 ≤ 2e-14）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した。証明の式の根拠欄でラベルを文字として書いていた箇所（check_joint_eigenspace_decomposition・eigenvalues_of_V_plus・check_number_operator_is_hermitian）を、ブロックへの参照に直した。数学の中身は変えていない。",
      ],
    },
  },

  {
    id: "column_limit_claim_c_between_Lambda_half_and_twice_Lambda_half",
    kind: "claim",
    title: {
      tex: String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \leq c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`,
    },
    labels: ["c_between_Lambda_half_and_twice_Lambda_half"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、上限の存在を ",
        math(String.raw`\mathbb{R}`),
        " の完備性から得るため。完備性による脱出）と、",
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \in \mathbb{R}_{>0}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、実数の指数関数と ",
        math(String.raw`\mathrm{arccosh}`),
        " の値から作るため。指数評価による脱出）について",
      ]),
      displayMath(
        String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \ \leq\ c(M_{\mathrm{col}}) \ \leq\ 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "Step 1（下からの評価 ",
        math(String.raw`c(M_{\mathrm{col}}) \geq \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        "）。",
        ref("c_plus_le_c"),
        " と ",
        ref("c_plus_equals_Lambda_half_integer"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
c(M_{\mathrm{col}})
&\geq c_+(M_{\mathrm{col}})
&&\left(\because\ \blkref{c_plus_le_c}\right)\\
&= \Lambda^{(1/2)}_{M_{\mathrm{col}}}
&&\left(\because\ \blkref{c_plus_equals_Lambda_half_integer}\right)
\end{aligned}`),
      paragraph([
        "Step 2（上からの評価 ",
        math(String.raw`c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        "）。",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を任意に取る。成分ごとの絶対値を取ったベクトルを ",
        math(String.raw`u`),
        "（",
        math(String.raw`u_k := |x_k|`),
        "）とし、",
        math(String.raw`v := u + \varepsilon u`),
        " とおく。",
      ]),
      paragraph([
        ref("W_has_positive_entries"),
        " より ",
        math(String.raw`W`),
        " の成分はすべて正なので、",
      ]),
      displayMath(
        String.raw`u^\top Wu = \sum_{k,l}|x_k|\,|x_l|\,W_{kl}
\ \geq\ \left|\sum_{k,l}x_kx_lW_{kl}\right|
\ \geq\ x^\top Wx
\quad (\because \text{三角不等式と } W_{kl} > 0)`,
      ),
      paragraph([
        "である。また ",
        math(String.raw`\varepsilon`),
        " は各基底ベクトルを別の基底ベクトルへ写す置換行列（",
        ref("trace_of_epsilon_V_plus"),
        " の証明 Step 3 の (b)）なので、",
        math(String.raw`u \geq 0`),
        " なら ",
        math(String.raw`\varepsilon u \geq 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|\varepsilon u\|
&= \|u\|
&&\left(\because\ \varepsilon\ \text{は置換行列であり、成分の並べ替えは二乗和を変えない}\right)\\
&= \|x\|
&&\left(\because\ u_k=|x_k|\ \text{であり、ノルムは成分の絶対値だけで決まる}\right)\\
&= 1
&&\left(\because\ \|x\|=1\ \text{（Step 2 の }x\text{ の取り方）}\right)
\end{aligned}`),
      paragraph([
        "である。さらに ",
        math(String.raw`\varepsilon^\top = \varepsilon`),
        "（",
        ref("epsilon_is_real_symmetric"),
        "）、",
        math(String.raw`\varepsilon^2 = I`),
        "（",
        ref("epsilon_square_and_eigenvalues"),
        "）である。",
      ]),
      list([
        [
          displayMath(String.raw`\begin{aligned}
\varepsilon v
&= \varepsilon\left(u+\varepsilon u\right)
&&\left(\because\ v=u+\varepsilon u\right)\\
&= \varepsilon u+\varepsilon^2u
&&\left(\because\ \text{行列の分配則}\right)\\
&= \varepsilon u+u
&&\left(\because\ \blkref{epsilon_square_and_eigenvalues}\text{ の }\varepsilon^2=I\right)\\
&=v
&&\left(\because\ v=u+\varepsilon u\right)
\end{aligned}`),
          " より ",
          math(String.raw`v \in \mathcal{F}^{(+)}`),
          "（",
          ref("def_even_eigenvectors_of_epsilon"),
          "）。また ",
          math(String.raw`v`),
          " は実である。",
        ],
        [
          math(String.raw`v \geq u \geq 0`),
          " かつ ",
          math(String.raw`u \neq 0`),
          " より ",
          math(String.raw`v \neq 0`),
          "。",
        ],
        [
          displayMath(String.raw`\begin{aligned}
\|v\|^2
&= \|u\|^2 + 2u^\top\varepsilon u + \|\varepsilon u\|^2
&&\left(\because\ v=u+\varepsilon u\text{ の展開と }\varepsilon^\top=\varepsilon.\ \blkref{epsilon_is_real_symmetric}\right)\\
&= 2 + 2u^\top\varepsilon u
&&\left(\because\ \|u\| = \|\varepsilon u\| = 1\right)\\
&\leq 4
&&\left(\because\ \text{Cauchy–Schwarz より } u^\top\varepsilon u \leq \|u\|\|\varepsilon u\| = 1\right)
\end{aligned}`),
        ],
        [
          displayMath(String.raw`\begin{aligned}
v^\top Wv
&=u^\top Wu+2u^\top W\varepsilon u+(\varepsilon u)^\top W(\varepsilon u)
&&\left(\because\ v=u+\varepsilon u\text{ の展開と }W^\top=W\right)\\
&=u^\top Wu+2u^\top W\varepsilon u+u^\top\varepsilon W\varepsilon u
&&\left(\because\ \blkref{epsilon_is_real_symmetric}\text{ の }\varepsilon^\top=\varepsilon\right)\\
&=u^\top Wu+2u^\top W\varepsilon u+u^\top W\varepsilon^2u
&&\left(\because\ \varepsilon W=W\varepsilon.\ \blkref{epsilon_commutes_with_W}\right)\\
&=2u^\top Wu+2u^\top W\varepsilon u
&&\left(\because\ \blkref{epsilon_square_and_eigenvalues}\text{ の }\varepsilon^2=I\right)\\
&\geq2u^\top Wu
&&\left(\because\ u,\varepsilon u\geq0\text{ と }W_{kl}>0\text{ より }u^\top W\varepsilon u\geq0\right)
\end{aligned}`),
        ],
      ]),
      paragraph([
        math(String.raw`\hat{v} := v/\|v\|`),
        " は ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルなので ",
        ref("c_plus_equals_Lambda_half_integer"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
\Lambda^{(1/2)}_{M_{\mathrm{col}}}
&= c_+(M_{\mathrm{col}})
&&\left(\because\ \blkref{c_plus_equals_Lambda_half_integer}\right)\\
&\geq \hat{v}^\top W\hat{v}
&&\left(\because\ c_+(M_{\mathrm{col}})\text{ は }\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}\text{ の単位ベクトル上の上限. }\blkref{def_sector_rayleigh_sup}\right)\\
&= \frac{v^\top Wv}{\|v\|^2}
&&\left(\because\ \hat{v}=v/\|v\|\text{ の代入と二次形式の斉次性}\right)\\
&\geq \frac{2\,u^\top Wu}{\|v\|^2}
&&\left(\because\ v^\top Wv\geq2u^\top Wu\text{（上の式変形）と }\|v\|^2>0\right)\\
&\geq \frac{2\,u^\top Wu}{4}
&&\left(\because\ \|v\|^2\leq4\text{（上の式変形）と }u^\top Wu\geq0\text{（}u\geq0,\ W_{kl}>0\text{）}\right)\\
&= \frac{u^\top Wu}{2}
&&\left(\because\ \mathbb{R}\text{ の約分}\right)\\
&\geq \frac{x^\top Wx}{2}
&&\left(\because\ u^\top Wu\geq x^\top Wx\text{（上の三角不等式）}\right)
\end{aligned}`),
      paragraph([
        math(String.raw`x`),
        " は任意だったので、上限を取って ",
        math(String.raw`c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章のゴールの式の Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M を主張するブロックが無かったため、onsager_exact_solution の証明の Step 2（下からの評価）・Step 3（上からの評価）を、内容を変えずにこの主張の証明の Step 1・Step 2 として独立させた。Step の番号と、それを指す「Step 3 の x の取り方」を「Step 2 の x の取り方」に直しただけで、式と根拠は変えていない。",
        "上からの評価（Step 2）の係数 2 は最良ではない（数値では c(M) = c_+(M) が全パラメータで成り立つ。sagemath/check/053_claim_even_sector_closing/check_05 (3')）。しかし 1/M を掛けて M → ∞ とすると log 2 / M → 0 で消えるため、Onsager の表式を出すにはこの粗い評価で十分である。",
        "この粗い評価を採ったのは c_-(M) の値に依存しないためである。一次情報で確認したところ c_-(M) = Λ^{(0)}_M は一般には成り立たない: 高温側 (K_1,K_2) = (0.05,0.1)（sinh2K_1 sinh2K_2 ≈ 0.020）では c_-(M)/Λ^{(0)}_M = 0.1102 で、M = 2,3,4,5 のすべてで一致しない（同 check_05 の対照出力）。V^{(-)} の最大固有値の固有ベクトルが F^{(+)} 側に落ちる場合があるためで、偶セクターで解決したのと同じ問題が奇セクターでは別の答えになりうる。本文はこの点に触れずに済む形にしてある。",
        "数値検証: sagemath/check/c_between_Lambda_half_and_twice_Lambda_half（Step 1・Step 2 の各行）と sagemath/check/053_claim_even_sector_closing/check_05 (1)〜(3)。",
      ],
    },
  },

  {
    id: "closing_010_theorem_onsager_exact_solution",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/018_even_sector_closing.ts", ordinal: 12 },
    title: { text: "2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）" },
    labels: ["onsager_exact_solution"],
    statement: [
      paragraph([
        ref("partition_function_via_transfer_matrix"),
        " と同じ設定（結合定数 ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "）のもとで、",
      ]),
      displayMath(
        String.raw`\lim_{M_{\mathrm{col}}\to\infty}\ \lim_{N_{\mathrm{row}}\to\infty}
\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2)
= \frac{1}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "が成り立つ。ここで",
      ]),
      displayMath(
        String.raw`\gamma(\theta)
= \mathrm{arccosh}\!\left(\cosh 2K_1\cosh 2K_2^*
- \sinh 2K_1\sinh 2K_2^*\cos\theta\right)`,
      ),
      paragraph([
        "であり（",
        ref("def_gamma_theta"),
        "）、これが Onsager の自由エネルギーの表式である。",
      ]),
      paragraph([
        "とくに ",
        ref("remark_remaining_input_even_sector"),
        " が「残っている入力」として挙げていた ",
        math(String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " は ",
        ref("c_plus_equals_Lambda_half_integer"),
        " で証明された。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`N_{\mathrm{row}}`),
        " の極限）。",
        ref("limit_of_log_Z_in_N_row"),
        " より、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " を固定すると",
      ]),
      displayMath(
        String.raw`\lim_{N_{\mathrm{row}}\to\infty}
\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2) = \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`,
      ),
      paragraph([
        "である。以下 ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " の ",
        math(String.raw`M_{\mathrm{col}} \to \infty`),
        " の挙動を調べる。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`c(M_{\mathrm{col}})`),
        " の挟み込み）。",
        ref("c_between_Lambda_half_and_twice_Lambda_half"),
        " より",
      ]),
      displayMath(
        String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \leq c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`,
      ),
      paragraph([
        "Step 3（挟み撃ち）。Step 2 より ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \leq c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " であり、すべて正の実数なので ",
        math(String.raw`\log`),
        " の単調性から",
      ]),
      displayMath(
        String.raw`\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}}
\ \leq\ \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})
\ \leq\ \frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}} + \frac{\log 2}{M_{\mathrm{col}}}`,
      ),
      paragraph([
        math(String.raw`(\log 2)/M_{\mathrm{col}} \to 0`),
        " なので、",
        ref("onsager_free_energy_expression"),
        " を ",
        math(String.raw`\delta = \tfrac12`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})
= \lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}}
= \frac{1}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "Step 1 と合わせて主張の 2 重極限の値が定まる。",
      ]),
      paragraph([
        "**実数解析（Riemann 積分）を使ったのは ",
        ref("riemann_sum_to_integral"),
        " を経由する最後の等号だけである**（",
        ref("remark_real_analysis_escape_point"),
        "）。それ以外の段はすべて有限サイズの複素行列の積・和・トレースと、",
        "有限個の実数の不等式で書かれている。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_05（M=2,3,4,5 で c(M) = max(c_+,c_-) と W の最大固有値の一致、Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M、および M を大きくしたときの (1/M) log Λ^{(1/2)}_M の Onsager 積分への収束）。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した。証明の Step 2（下からの評価）と Step 3（上からの評価）を、内容を変えずに主張 c_between_Lambda_half_and_twice_Lambda_half の証明の Step 1・Step 2 へ移し、ここではそれを引く。旧 Step 4 を Step 3 にした。",
      ],
    },
  },

  {
    id: "column_limit_and_closed_form_claim_c_plus_sandwich_and_double_limit",
    kind: "claim",
    standing: "mainTheorem",
    title: {
      tex: String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}\text{、}\Lambda^{(1/2)}_{M_{\mathrm{col}}} \leq c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}\text{ と }\lim_{M_{\mathrm{col}}\to\infty}\lim_{N_{\mathrm{row}}\to\infty}\frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z\text{ の閉形式}`,
    },
    labels: ["c_plus_value_c_sandwich_and_double_limit_of_log_Z"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（",
        ref("def_partition_function_2d_ising"),
        " の定義域が ",
        math(String.raw`\mathbb{R}_{>0}\times\mathbb{R}_{>0}`),
        " であるため）とする。",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " について、",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        "、",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        "、",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        "、",
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`c_+(M_{\mathrm{col}}) \in \mathbb{R}`),
        "（どちらも ",
        math(String.raw`\mathbb{R}`),
        " に住むのは、上限の存在を ",
        math(String.raw`\mathbb{R}`),
        " の完備性から得るため。完備性による脱出）、",
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \in \mathbb{R}_{>0}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、実数の指数関数と ",
        math(String.raw`\mathrm{arccosh}`),
        " の値から作るため。指数評価による脱出）、",
        ref("def_partition_function_2d_ising"),
        " の ",
        math(String.raw`Z(K_1,K_2) \in \mathbb{R}_{>0}`),
        "（行数 ",
        math(String.raw`N_{\mathrm{row}}`),
        " と列数 ",
        math(String.raw`M_{\mathrm{col}}`),
        " に依る）、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\theta) = \mathrm{arccosh}\!\left(\cosh 2K_1\cosh 2K_2^* - \sinh 2K_1\sinh 2K_2^*\cos\theta\right) \in \mathbb{R}`),
        "（",
        math(String.raw`\theta \in \mathbb{R}`),
        "）は次を満たす。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad c_+(M_{\mathrm{col}}) = \sup\left\{\, x^\top W x \ \middle|\ x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1 \,\right\} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        ],
        [
          math(String.raw`\text{(2)}\quad \Lambda^{(1/2)}_{M_{\mathrm{col}}} \leq c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        ],
        [
          math(String.raw`\text{(3)}\quad \lim_{M_{\mathrm{col}}\to\infty}\ \lim_{N_{\mathrm{row}}\to\infty}\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2) = \frac{1}{2}\log\left(2\sinh 2K_2\right) + \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`),
          "（",
          math(String.raw`\log`),
          " は正の実数上の実対数で、両辺の値は ",
          math(String.raw`\mathbb{R}`),
          " に住む。実対数・極限・Riemann 積分による脱出。積分を使うのは ",
          ref("remark_real_analysis_escape_point"),
          " の箇所だけである）",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("c_plus_equals_Lambda_half_integer"),
        " そのものである。",
      ]),
      paragraph([
        "(2) ",
        ref("c_between_Lambda_half_and_twice_Lambda_half"),
        " そのものである。",
      ]),
      paragraph([
        "(3) ",
        ref("onsager_exact_solution"),
        " そのものである（その証明は (2) の挟み込みを ",
        ref("onsager_free_energy_expression"),
        " と合わせて使う）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章のゴールの式（c_+(M) = Λ^{(1/2)}_M、Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M、2 重極限の閉形式）を一つの主張として立てた。既存の主張 c_plus_equals_Lambda_half_integer・c_between_Lambda_half_and_twice_Lambda_half・onsager_exact_solution を並べるだけで、新しい証明は無い。",
      ],
    },
  },
]);
