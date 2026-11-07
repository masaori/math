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
        " は、",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}}`),
        " について ",
        math(String.raw`\varepsilon_{\mathbb{R}}x = x`),
        " を満たす単位ベクトル ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " にわたる上限であり、",
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
        math(String.raw`\varepsilon_{\mathbb{R}}x = x`),
        " を満たす単位ベクトル ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " にわたる上限 ",
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
        math(String.raw`W \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（結合定数 ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "）のすべての成分は正の実数である：",
      ]),
      displayMath(
        String.raw`W_{\iota(\mu),\iota(\mu')} > 0 \qquad (\mu,\mu' \in \mathfrak{M})`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`W_{\iota(\mu),\iota(\mu')}`),
        " は ",
        ref("def_kronecker"),
        " の取り決めにより ",
        math(String.raw`W_{\nu(\iota(\mu)),\nu(\iota(\mu'))}`),
        " を表し、",
        math(String.raw`z \in \mathbb{C}`),
        " について ",
        math(String.raw`z > 0`),
        " は「",
        math(String.raw`z = w_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`w \in \mathbb{R}_{>0}`),
        " が存在する」ことを表す（",
        math(String.raw`w_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記。正であることの判定に ",
        math(String.raw`\mathbb{R}`),
        " の順序を使うので、",
        math(String.raw`w`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の元として取る）。言い換えると、すべての ",
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について ",
        math(String.raw`W_{kl} > 0`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`n := 2^{M_{\mathrm{col}}}`),
        "、",
        math(String.raw`B := V_1^{1/2}`),
        "（",
        ref("def_transfer_matrix_square_root"),
        "）とおく。",
        ref("def_transfer_matrix_square_root"),
        " の ",
        math(String.raw`D = \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z`),
        "（",
        ref("def_finite_sum_of_matrices"),
        " の有限和）について、",
        math(String.raw`\tfrac12 K_1 D`),
        " は実数 ",
        math(String.raw`\tfrac12 K_1 \in \mathbb{R}`),
        " による ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍 ",
        math(String.raw`X := \left(\tfrac12 K_1\right)_{\mathbb{C}} D`),
        " と読む。",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`m^{+} := m+1`),
        "（",
        math(String.raw`m \leq M_{\mathrm{col}}-1`),
        "）、",
        math(String.raw`m^{+} := 1`),
        "（",
        math(String.raw`m = M_{\mathrm{col}}`),
        "）とおく。",
        ref("def_site_pauli_periodic_extension"),
        " より ",
        math(String.raw`\sigma_{m+1}^z = \sigma_{m^{+}}^z`),
        "、",
        ref("def_transfer_matrix"),
        " の周期規約 ",
        math(String.raw`\mu(M_{\mathrm{col}}+1) := \mu(1)`),
        " より ",
        math(String.raw`\mu(m+1) = \mu(m^{+})`),
        " である。",
        math(String.raw`\mu, \mu' \in \mathfrak{M}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
d(\mu) &:= \sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\,\mu(m+1) \in \mathbb{R}, &
b(\mu) &:= \exp\!\left(\tfrac12 K_1\,d(\mu)\right) \in \mathbb{R}, \\
e(\mu,\mu') &:= \sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\,\mu'(m) \in \mathbb{R}, &
v(\mu,\mu') &:= \exp\!\left(K_2\,e(\mu,\mu')\right) \in \mathbb{R}
\end{aligned}`,
      ),
      paragraph([
        "とおく（和は ",
        ref("def_finite_sum_of_real_numbers"),
        "、",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の実数の exp。実数の指数関数を使うので ",
        math(String.raw`\mathbb{R}`),
        " へ脱出している）。",
        ref("real_exp_positive"),
        " より ",
        math(String.raw`b(\mu) > 0`),
        "、",
        math(String.raw`v(\mu,\mu') > 0`),
        " である。以下、",
        math(String.raw`\mu, \mu' \in \mathfrak{M}`),
        " を固定し、",
        math(String.raw`k := \nu(\iota(\mu))`),
        "、",
        math(String.raw`l := \nu(\iota(\mu'))`),
        " とおく。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`B`),
        " は対角行列で、",
        math(String.raw`B_{kk} = b(\mu)_{\mathbb{C}}`),
        "）。",
        math(String.raw`p, q \in \{1,\dots,n\}`),
        "、",
        math(String.raw`p \neq q`),
        " とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{pq}
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m+1}^z\right)_{pq}
   &&(\because \blkref{finite_sum_of_matrices_entrywise}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m^{+}}^z\right)_{pq}
   &&(\because \sigma_{m+1}^z = \sigma_{m^{+}}^z\text{ を各項へ同時に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}} 0_{\mathbb{C}}
   &&(\because \blkref{site_sigma_z_product_is_diagonal}\text{ を各 }(m, m^{+})\text{ へ同時に適用}) \\
&= 0_{\mathbb{C}}
   &&(\because \blkref{finite_sum_of_complex_zeros})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
D_{kk}
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m+1}^z\right)_{kk}
   &&(\because \blkref{finite_sum_of_matrices_entrywise}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m^{+}}^z\right)_{kk}
   &&(\because \sigma_{m+1}^z = \sigma_{m^{+}}^z\text{ を各項へ同時に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\mu(m)_{\mathbb{C}}\,\mu(m^{+})_{\mathbb{C}}
   &&(\because \blkref{site_sigma_z_product_diagonal_entry}\text{ を各 }(m, m^{+})\text{ へ同時に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\mu(m)\,\mu(m^{+})\right)_{\mathbb{C}}
   &&(\because \blkref{real_inclusion_preserves_product}\text{ を各項へ同時に適用}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\,\mu(m^{+})\right)_{\mathbb{C}}
   &&(\because \blkref{real_inclusion_preserves_finite_sum}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\,\mu(m+1)\right)_{\mathbb{C}}
   &&(\because \mu(m+1) = \mu(m^{+})\text{ を各項へ同時に適用}) \\
&= d(\mu)_{\mathbb{C}}
   &&(\because d(\mu)\text{ の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
X_{pq}
&= \left(\tfrac12 K_1\right)_{\mathbb{C}} D_{pq}
   &&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \left(\tfrac12 K_1\right)_{\mathbb{C}}\,0_{\mathbb{C}}
   &&(\because \text{上の } D_{pq} = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}
   &&(\because \blkref{complex_times_zero_is_zero})
\end{aligned}`,
      ),
      paragraph([
        "より ",
        math(String.raw`X`),
        " は対角行列（",
        ref("def_diagonal_matrix"),
        "）である。ゆえに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
B_{pq}
&= \left(\exp(X)\right)_{pq}
   &&(\because \blkref{def_transfer_matrix_square_root}) \\
&= 0_{\mathbb{C}}
   &&(\because \blkref{exp_of_diagonal_matrix}\text{ を対角行列 }X\text{ へ})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
B_{kk}
&= \left(\exp(X)\right)_{kk}
   &&(\because \blkref{def_transfer_matrix_square_root}) \\
&= \exp\!\left(X_{kk}\right)
   &&(\because \blkref{exp_of_diagonal_matrix}\text{ を対角行列 }X\text{ へ}) \\
&= \exp\!\left(\left(\tfrac12 K_1\right)_{\mathbb{C}} D_{kk}\right)
   &&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \exp\!\left(\left(\tfrac12 K_1\right)_{\mathbb{C}}\,d(\mu)_{\mathbb{C}}\right)
   &&(\because \text{上の } D_{kk} = d(\mu)_{\mathbb{C}}) \\
&= \exp\!\left(\left(\tfrac12 K_1\,d(\mu)\right)_{\mathbb{C}}\right)
   &&(\because \blkref{real_inclusion_preserves_product}) \\
&= \left(\exp\!\left(\tfrac12 K_1\,d(\mu)\right)\right)_{\mathbb{C}}
   &&(\because \blkref{complex_exp_of_real_argument}) \\
&= b(\mu)_{\mathbb{C}}
   &&(\because b(\mu)\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "同じ鎖を ",
        math(String.raw`\mu'`),
        " と ",
        math(String.raw`l = \nu(\iota(\mu'))`),
        " に当てて ",
        math(String.raw`B_{ll} = b(\mu')_{\mathbb{C}}`),
        " である。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`(V_2)_{kl} = v(\mu,\mu')_{\mathbb{C}}`),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_2)_{kl}
&= (V_2)_{\mathrm{ord}(\mu),\,\mathrm{ord}(\mu')}
   &&(\because \blkref{config_numbering_equals_kronecker_numbering}\text{ を }\mu\text{ と }\mu'\text{ へ}) \\
&= \left(\exp\!\left(K_2\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\,\mu'(m)\right)\right)_{\mathbb{C}}
   &&(\because \blkref{def_transfer_matrix}\text{。指数の肩は実数で、値は実数の exp の }\mathbb{C}\text{ への包含}) \\
&= v(\mu,\mu')_{\mathbb{C}}
   &&(\because e(\mu,\mu')\text{ と }v(\mu,\mu')\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（成分の計算）。",
        math(String.raw`s, t \in \{1,\dots,n\}`),
        "、",
        math(String.raw`s \neq k`),
        "、",
        math(String.raw`t \neq l`),
        " とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(BV_2\right)_{kt}B_{tl}
&= \left(BV_2\right)_{kt}\,0_{\mathbb{C}}
   &&(\because \text{Step 1 の }B_{tl} = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}
   &&(\because \blkref{complex_times_zero_is_zero})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
B_{ks}\left(V_2\right)_{sl}
&= 0_{\mathbb{C}}\left(V_2\right)_{sl}
   &&(\because \text{Step 1 の }B_{ks} = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}
   &&(\because \blkref{complex_zero_times_is_zero})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
W_{kl}
&= \left(\left(BV_2\right)B\right)_{kl}
   &&(\because \blkref{def_symmetrized_transfer_matrix}) \\
&= \sum_{t=1}^{n}\left(BV_2\right)_{kt}B_{tl}
   &&(\because \blkref{mat_mult}) \\
&= \left(BV_2\right)_{kl}B_{ll}
   &&(\because \blkref{finite_sum_with_single_nonzero_term}\text{ を、上の }t \neq l\text{ の項の値へ}) \\
&= \left(\sum_{s=1}^{n}B_{ks}\left(V_2\right)_{sl}\right)B_{ll}
   &&(\because \blkref{mat_mult}) \\
&= \left(B_{kk}\left(V_2\right)_{kl}\right)B_{ll}
   &&(\because \blkref{finite_sum_with_single_nonzero_term}\text{ を、上の }s \neq k\text{ の項の値へ}) \\
&= \left(b(\mu)_{\mathbb{C}}\left(V_2\right)_{kl}\right)b(\mu')_{\mathbb{C}}
   &&(\because \text{Step 1 の }B_{kk}\text{ と }B_{ll}) \\
&= \left(b(\mu)_{\mathbb{C}}\,v(\mu,\mu')_{\mathbb{C}}\right)b(\mu')_{\mathbb{C}}
   &&(\because \text{Step 2}) \\
&= \left(b(\mu)\,v(\mu,\mu')\right)_{\mathbb{C}}\,b(\mu')_{\mathbb{C}}
   &&(\because \blkref{real_inclusion_preserves_product}) \\
&= \left(\left(b(\mu)\,v(\mu,\mu')\right)b(\mu')\right)_{\mathbb{C}}
   &&(\because \blkref{real_inclusion_preserves_product})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`w := \left(b(\mu)\,v(\mu,\mu')\right)b(\mu') \in \mathbb{R}`),
        "、",
        math(String.raw`r_1 := b(\mu),\ r_2 := v(\mu,\mu'),\ r_3 := b(\mu') \in \mathbb{R}`),
        " とおくと、準備の ",
        math(String.raw`b(\mu) > 0`),
        "・",
        math(String.raw`v(\mu,\mu') > 0`),
        "・",
        math(String.raw`b(\mu') > 0`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
w
&= \prod_{j=1}^{3} r_j
   &&(\because \blkref{def_finite_product_of_real_numbers}) \\
&> 0
   &&(\because \blkref{finite_product_of_positive_reals_is_positive}\text{ を }m := 3\text{ で})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`W_{kl} = w_{\mathbb{C}}`),
        " である。",
        math(String.raw`k = \nu(\iota(\mu))`),
        "、",
        math(String.raw`l = \nu(\iota(\mu'))`),
        " なので、これが主張である。",
        ref("config_numbering_equals_kronecker_numbering"),
        " と ",
        ref("row_configuration_numbering_bijective"),
        " より ",
        math(String.raw`\mathfrak{M} \ni \mu \mapsto \nu(\iota(\mu)) = \mathrm{ord}(\mu) \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " は全単射なので、どの ",
        math(String.raw`k', l' \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " もある ",
        math(String.raw`\lambda, \lambda' \in \mathfrak{M}`),
        " で ",
        math(String.raw`k' = \nu(\iota(\lambda))`),
        "、",
        math(String.raw`l' = \nu(\iota(\lambda'))`),
        " と書け、上の議論を ",
        math(String.raw`(\mu,\mu') := (\lambda,\lambda')`),
        " で行えば ",
        math(String.raw`W_{k'l'} > 0`),
        " である。これが言い換えの形である。",
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
    id: "maxeig_claim_W_real_has_positive_entries",
    kind: "claim",
    title: { tex: String.raw`W_{\mathbb{R}} \text{ の成分はすべて正}` },
    labels: ["W_real_has_positive_entries"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、結合定数 ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とする。",
        ref("def_W_real"),
        " の ",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " について、すべての ",
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " で ",
        math(String.raw`(W_{\mathbb{R}})_{kl} > 0`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の順序）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " を取る。",
        ref("W_has_positive_entries"),
        " の言い換えの形より ",
        math(String.raw`W_{kl} > 0`),
        "、すなわち ",
        math(String.raw`W_{kl} = w_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`w \in \mathbb{R}_{>0}`),
        " が存在する（",
        math(String.raw`w_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記）。この ",
        math(String.raw`w`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}
&= W_{kl}
  &&\bigl(\because\ \blkref{def_W_real}\bigr)\\
&= w_{\mathbb{C}}
  &&\bigl(\because\ w\ \text{の取り方（}\blkref{W_has_positive_entries}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to (W_{\mathbb{R}})_{kl},\ b \to w`),
        "）より ",
        math(String.raw`(W_{\mathbb{R}})_{kl} = w`),
        " である。",
        math(String.raw`w \in \mathbb{R}_{>0}`),
        " なので ",
        math(String.raw`(W_{\mathbb{R}})_{kl} > 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は実数のベクトルと複素行列 W の二次形式の評価に W_kl > 0（W_has_positive_entries は複素行列 W の成分が「正の実数の包含」であることを述べる）を使っていた。この同一視を def_W_real の W_ℝ で書き直すために、W_ℝ の成分が ℝ の順序で正であることを示す主張として足した。数値検証: sagemath/check/W_real_has_positive_entries/。",
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
        ref("epsilon_square_and_eigenvalues"),
        " の証明で得た表示より ",
        math(String.raw`\varepsilon = \sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        "（",
        math(String.raw`M_{\mathrm{col}}`),
        " 個の因子）である。因子 ",
        math(String.raw`\sigma^x`),
        " の成分はすべて実数（",
        ref("pauli_x_has_real_entries"),
        "）なので、",
        ref("kronecker_of_real_entry_matrices_has_real_entries"),
        "（",
        math(String.raw`M \to M_{\mathrm{col}},\ A_k \to \sigma^x\ (k \in \{1,\dots,M_{\mathrm{col}}\})`),
        "）より ",
        math(String.raw`\varepsilon`),
        " の成分はすべて実数（",
        ref("def_matrix_with_real_entries"),
        "）である。転置については",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon^\top
&=\left(\sigma^x\boxtimes\cdots\boxtimes\sigma^x\right)^\top
  \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示})\\
&=(\sigma^x)^\top\boxtimes\cdots\boxtimes(\sigma^x)^\top
  \quad (\because \blkref{kronecker_transpose})\\
&=\sigma^x\boxtimes\cdots\boxtimes\sigma^x
  \quad (\because \blkref{transpose_of_pauli_x}\ \text{を各因子へ同時に適用})\\
&=\varepsilon
  \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。旧 <sector_decomposition_of_rayleigh_sup> の証明の中にあった ε^⊤ = ε の導出を、最終定理が引く独立した主張として取り出した。",
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 成分の実性を「σ^x の成分は 0 または 1」「クロネッカー積の成分は各因子の成分の積」と名前だけで述べていたのを、epsilon_square_and_eigenvalues の証明の表示と pauli_x_has_real_entries・kronecker_of_real_entry_matrices_has_real_entries を引く形にした。転置の鎖の (σ^x)^⊤ = σ^x の段の根拠を pauli_matrix_products の成分表示から transpose_of_pauli_x に替えた。主張は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_definition_epsilon_real",
    kind: "definition",
    title: { tex: String.raw`\varepsilon \text{ の実数の行列 } \varepsilon_{\mathbb{R}}` },
    labels: ["def_epsilon_real"],
    statement: [
      paragraph([
        ref("epsilon_is_real_symmetric"),
        " より ",
        ref("def_global_spin_flip_matrix"),
        " の ",
        math(String.raw`\varepsilon \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の成分はすべて実数（",
        ref("def_matrix_with_real_entries"),
        "）なので、",
        ref("def_real_matrix_of_real_entry_matrix"),
        "（",
        math(String.raw`m \to 2^{M_{\mathrm{col}}},\ n \to 2^{M_{\mathrm{col}}},\ B \to \varepsilon`),
        "）の",
      ]),
      displayMath(String.raw`\varepsilon_{\mathbb{R}} := \varrho^{2^{M_{\mathrm{col}}},2^{M_{\mathrm{col}}}}_{\mathbb{C}\to\mathbb{R}}(\varepsilon) \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
      paragraph([
        "が定まる。",
        ref("def_real_matrix_of_real_entry_matrix"),
        " より、すべての ",
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について ",
        math(String.raw`\bigl((\varepsilon_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}} = \varepsilon_{kl}`),
        " である（",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_sector_rayleigh_sup の 𝓕^{(+)} ∩ ℝ^{2^{M_col}}（実数のベクトルを複素数のベクトルの集合 𝓕^{(+)} の元として扱う同一視）を、実数の行列 ε_ℝ と実数のベクトルの積の式 ε_ℝx = x で述べ直すために足した（def_W_real と同じ形）。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_real_is_symmetric",
    kind: "claim",
    title: { tex: String.raw`\varepsilon_{\mathbb{R}} \text{ は対称}` },
    labels: ["epsilon_real_is_symmetric"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " は ",
        ref("def_real_symmetric_matrix"),
        "（",
        math(String.raw`n \to 2^{M_{\mathrm{col}}},\ P \to \varepsilon_{\mathbb{R}}`),
        "）の意味で対称である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " を取る。",
        ref("epsilon_is_real_symmetric"),
        " より ",
        math(String.raw`\varepsilon^{\top} = \varepsilon`),
        "（転置は ",
        ref("def_matrix_transpose"),
        "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((\varepsilon_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}
&= \varepsilon_{kl}
  &&\bigl(\because\ \blkref{def_epsilon_real}\bigr)\\
&= \bigl(\varepsilon^{\top}\bigr)_{kl}
  &&\bigl(\because\ \varepsilon^{\top} = \varepsilon\ \text{（}\blkref{epsilon_is_real_symmetric}\text{）}\bigr)\\
&= \varepsilon_{lk}
  &&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)\\
&= \bigl((\varepsilon_{\mathbb{R}})_{lk}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{def_epsilon_real}\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to (\varepsilon_{\mathbb{R}})_{kl},\ b \to (\varepsilon_{\mathbb{R}})_{lk}`),
        "）より ",
        math(String.raw`(\varepsilon_{\mathbb{R}})_{kl} = (\varepsilon_{\mathbb{R}})_{lk}`),
        " である。",
        math(String.raw`k, l`),
        " は任意なので、",
        ref("def_real_symmetric_matrix"),
        " の意味で ",
        math(String.raw`\varepsilon_{\mathbb{R}}`),
        " は対称である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は実数のベクトル u に複素行列 ε を掛け、ε^⊤ = ε（epsilon_is_real_symmetric は複素行列 ε についての主張）を実数の二次形式 u^⊤εu の入れ替えに使っていた。この同一視を def_epsilon_real の ε_ℝ で書き直すために、ε_ℝ の対称性を W_real_is_symmetric と同じ形で示す主張として足した。数値検証: sagemath/check/epsilon_real_is_symmetric/。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_real_square_is_identity",
    kind: "claim",
    title: { tex: String.raw`\varepsilon_{\mathbb{R}}\varepsilon_{\mathbb{R}} = I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})}` },
    labels: ["epsilon_real_square_is_identity"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " について",
      ]),
      displayMath(String.raw`\varepsilon_{\mathbb{R}}\varepsilon_{\mathbb{R}} = I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})}`),
      paragraph([
        "が成り立つ。左辺の積は ",
        ref("def_real_matrix_product"),
        " のもの、右辺は ",
        ref("def_real_identity_matrix"),
        " の単位行列である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        " と略記する。",
        ref("epsilon_is_real_symmetric"),
        " より ",
        math(String.raw`\varepsilon \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の記号）であり、",
        ref("def_epsilon_real"),
        " より ",
        math(String.raw`\varepsilon_{\mathbb{R}} = \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(\varepsilon)`),
        " なので、",
        ref("real_matrix_of_real_entry_matrix_preserves_product"),
        "（",
        math(String.raw`m, n, p \to d,\ A \to \varepsilon,\ B \to \varepsilon`),
        "）と ",
        ref("real_matrix_of_real_entry_matrix_preserves_power"),
        "（",
        math(String.raw`n \to d,\ A \to \varepsilon`),
        "）が当てはまる。",
        ref("epsilon_square_and_eigenvalues"),
        " の ",
        math(String.raw`\varepsilon^2`),
        " は積 ",
        math(String.raw`\varepsilon\varepsilon`),
        "（",
        ref("mat_mult"),
        "）を表す（その証明の鎖の 1 行目）ので、",
        math(String.raw`\varepsilon\varepsilon = I_{\mathrm{Mat}(d,\mathbb{C})}`),
        " である。とくに ",
        math(String.raw`I_{\mathrm{Mat}(d,\mathbb{C})} = \varepsilon\varepsilon \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        ref("product_of_real_entry_matrices_has_real_entries"),
        "）で、",
        math(String.raw`\varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}\bigl(I_{\mathrm{Mat}(d,\mathbb{C})}\bigr)`),
        " が定まる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon_{\mathbb{R}}\varepsilon_{\mathbb{R}}
&= \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(\varepsilon\varepsilon)
  &&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A \to \varepsilon,\ B \to \varepsilon)\ \text{を右辺から左辺へ}\bigr)\\
&= \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}\bigl(I_{\mathrm{Mat}(d,\mathbb{C})}\bigr)
  &&\bigl(\because\ \blkref{epsilon_square_and_eigenvalues}\ \text{の}\ \varepsilon\varepsilon = I_{\mathrm{Mat}(d,\mathbb{C})}\bigr)\\
&= \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}\bigl(\varepsilon^0\bigr)
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\ (K = \mathbb{C},\ A \to \varepsilon)\ \text{を右辺から左辺へ}\bigr)\\
&= (\varepsilon_{\mathbb{R}})^0
  &&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_power}\ (n \to d,\ A \to \varepsilon,\ q \to 0)\bigr)\\
&= I_{\mathrm{Mat}(d,\mathbb{R})}
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\ (K = \mathbb{R},\ A \to \varepsilon_{\mathbb{R}}\text{、}I\ \text{は}\ \blkref{def_real_identity_matrix})\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は実数のベクトル u に複素行列 ε を掛け、ε^2 = I（epsilon_square_and_eigenvalues は複素行列 ε についての主張）で ε(εu) = u としていた。この同一視を def_epsilon_real の ε_ℝ で書き直すために、ε_ℝ と自身の積が実数の単位行列であることを示す主張として足した。冪 (ε_ℝ)^2 ではなく積で述べたのは、Step 2 が使う ε_ℝ(ε_ℝu) = u へ real_matrix_vector_product_is_associative だけで渡せるようにするため（冪の形だと実数の行列どうしの積の左単位が別に要る）。ϱ(I) = I_ℝ の段は trace_of_W_power_via_W_real と同じ経路（real_matrix_of_real_entry_matrix_preserves_power の q → 0）である。数値検証: sagemath/check/epsilon_real_square_is_identity/。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_real_fixes_sum_of_vector_and_its_image",
    kind: "claim",
    title: { text: "成分が u_k + (ε_ℝu)_k のベクトルは ε_ℝ を掛けても変わらない" },
    labels: ["epsilon_real_fixes_sum_of_vector_and_its_image"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        " とし、",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        "、",
        math(String.raw`u \in \mathbb{R}^{d}`),
        " を取る。",
        math(String.raw`v \in \mathbb{R}^{d}`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`v_k := u_k + (\varepsilon_{\mathbb{R}}u)_k \qquad (k \in \{1,\dots,d\})`),
      paragraph([
        "で定める（",
        math(String.raw`\varepsilon_{\mathbb{R}}u \in \mathbb{R}^{d}`),
        " は ",
        ref("def_real_matrix_vector_product"),
        " の積、和は ",
        math(String.raw`\mathbb{R}`),
        " の和）。このとき",
      ]),
      displayMath(String.raw`\varepsilon_{\mathbb{R}}v = v`),
      paragraph([
        "が成り立つ。左辺の積は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to d,\ P \to \varepsilon_{\mathbb{R}},\ x \to v`),
        "）のものである。",
        math(String.raw`\mathbb{R}^{d}`),
        " の元どうしの和は本文で定めていないので、",
        math(String.raw`v`),
        " を成分の等式で与える。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、この章で、成分が実数の値をとる行列とベクトルにこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の分配則・加法の交換則と有限和だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺はともに ",
        math(String.raw`\mathbb{R}^{d}`),
        " の元なので、各成分が一致することを示せばよい。",
        math(String.raw`k \in \{1,\dots,d\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\varepsilon_{\mathbb{R}}v)_k
&= \sum_{l=1}^{d} (\varepsilon_{\mathbb{R}})_{kl}\,v_l
  &&\bigl(\because\ \blkref{def_real_matrix_vector_product}\ (m, n \to d,\ P \to \varepsilon_{\mathbb{R}},\ x \to v,\ i \to k,\ j \to l)\bigr)\\
&= \sum_{l=1}^{d} (\varepsilon_{\mathbb{R}})_{kl}\,\bigl(u_l + (\varepsilon_{\mathbb{R}}u)_l\bigr)
  &&\bigl(\because\ v\ \text{の定義}\ (k \to l)\ \text{を}\ d\ \text{個の項へ同時に適用}\bigr)\\
&= \sum_{l=1}^{d} \bigl((\varepsilon_{\mathbb{R}})_{kl}\,u_l + (\varepsilon_{\mathbb{R}})_{kl}\,(\varepsilon_{\mathbb{R}}u)_l\bigr)
  &&\bigl(\because\ \mathbb{R}\ \text{の分配則}\ a(b + c) = ab + ac\ \text{を}\ d\ \text{個の項へ同時に適用}\bigr)\\
&= \sum_{l=1}^{d} (\varepsilon_{\mathbb{R}})_{kl}\,u_l + \sum_{l=1}^{d} (\varepsilon_{\mathbb{R}})_{kl}\,(\varepsilon_{\mathbb{R}}u)_l
  &&\bigl(\because\ \blkref{finite_sum_of_real_sums}\ (m \to d,\ j \to l,\ a_l \to (\varepsilon_{\mathbb{R}})_{kl}\,u_l,\ b_l \to (\varepsilon_{\mathbb{R}})_{kl}\,(\varepsilon_{\mathbb{R}}u)_l)\bigr)\\
&= (\varepsilon_{\mathbb{R}}u)_k + \bigl(\varepsilon_{\mathbb{R}}(\varepsilon_{\mathbb{R}}u)\bigr)_k
  &&\bigl(\because\ \blkref{def_real_matrix_vector_product}\ (m, n \to d,\ P \to \varepsilon_{\mathbb{R}},\ i \to k,\ j \to l\text{；}x \to u\ \text{と}\ x \to \varepsilon_{\mathbb{R}}u)\ \text{を右辺から左辺へ 2 か所へ同時適用}\bigr)\\
&= (\varepsilon_{\mathbb{R}}u)_k + \bigl((\varepsilon_{\mathbb{R}}\varepsilon_{\mathbb{R}})u\bigr)_k
  &&\bigl(\because\ \blkref{real_matrix_vector_product_is_associative}\ (m, n, p \to d,\ P, Q \to \varepsilon_{\mathbb{R}},\ x \to u)\ \text{を右辺から左辺へ}\bigr)\\
&= (\varepsilon_{\mathbb{R}}u)_k + \bigl(I_{\mathrm{Mat}(d,\mathbb{R})}\,u\bigr)_k
  &&\bigl(\because\ \blkref{epsilon_real_square_is_identity}\bigr)\\
&= (\varepsilon_{\mathbb{R}}u)_k + u_k
  &&\bigl(\because\ \blkref{real_identity_matrix_is_left_unit_of_real_matrix_vector_product}\ (n \to d,\ x \to u)\bigr)\\
&= u_k + (\varepsilon_{\mathbb{R}}u)_k
  &&\bigl(\because\ \mathbb{R}\ \text{の加法の交換則}\bigr)\\
&= v_k
  &&\bigl(\because\ v\ \text{の定義を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`k`),
        " は任意なので、",
        math(String.raw`\mathbb{R}^{d}`),
        " の二つの元の成分がすべて等しく、",
        math(String.raw`\varepsilon_{\mathbb{R}}v = v`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は実数のベクトル u に複素行列 ε を掛け、εv = ε(u + εu) = εu + ε^2u = εu + u = v を「行列の分配則」と ε^2 = I で出していた。この同一視を def_epsilon_real の ε_ℝ で書き直すために足した。ℝ^d の元どうしの和は本文に定義が無いので、v を成分の等式で与えた（real_bilinear_value_is_additive_in_right_vector と同じ）。行列とベクトルの積の分配則は本文に主張が無いので、成分の式で ℝ の分配則と finite_sum_of_real_sums を引いた。数値検証: sagemath/check/epsilon_real_fixes_sum_of_vector_and_its_image/。",
      ],
    },
  },
  {
    id: "maxeig_definition_negated_row_configuration",
    kind: "definition",
    title: { tex: String.raw`\text{符号を反転したスピン配置 } -s` },
    labels: ["def_negated_row_configuration"],
    statement: [
      paragraph([
        ref("def_row_configurations"),
        " の ",
        math(String.raw`s \in \mathfrak{M}`),
        " について、",
        math(String.raw`-s : \{1,\dots,M_{\mathrm{col}}\} \to \{-1,1\}`),
        " を",
      ]),
      displayMath(String.raw`(-s)(m) := -s(m) \qquad (m \in \{1,\dots,M_{\mathrm{col}}\})`),
      paragraph([
        "で定める。",
        math(String.raw`s(m) \in \{-1,1\}`),
        " なら ",
        math(String.raw`-s(m) \in \{-1,1\}`),
        " なので、",
        math(String.raw`-s \in \mathfrak{M}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。同じ記号は trace_of_epsilon_V_plus の証明の準備の中で置かれていたが、引ける定義ではなかった。epsilon_entries_in_row_configuration_numbering と epsilon_real_permutes_entries_by_spin_flip が引くので定義として足した（Lean は negSpinConf）。",
      ],
    },
  },
  {
    id: "maxeig_claim_negated_row_configuration_is_involutive",
    kind: "claim",
    title: { tex: String.raw`-(-s) = s` },
    labels: ["negated_row_configuration_is_involutive"],
    statement: [
      paragraph([
        ref("def_row_configurations"),
        " の ",
        math(String.raw`s \in \mathfrak{M}`),
        " について、",
        ref("def_negated_row_configuration"),
        " の符号の反転を 2 回行ったもの ",
        math(String.raw`-(-s) \in \mathfrak{M}`),
        " は",
      ]),
      displayMath(String.raw`-(-s) = s`),
      paragraph(["を満たす。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " を取る（",
        math(String.raw`s(m) \in \{-1,1\} \subset \mathbb{Z}`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(-(-s)\bigr)(m)
&= -\bigl((-s)(m)\bigr)
  &&\bigl(\because\ \blkref{def_negated_row_configuration}\ (s \to -s)\bigr)\\
&= -\bigl(-s(m)\bigr)
  &&\bigl(\because\ \blkref{def_negated_row_configuration}\ (s \to s)\bigr)\\
&= s(m)
  &&\bigl(\because\ \mathbb{Z}\ \text{の符号反転を 2 回行うと元に戻る}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`-(-s)`),
        " と ",
        math(String.raw`s`),
        " は同じ定義域 ",
        math(String.raw`\{1,\dots,M_{\mathrm{col}}\}`),
        " のすべての ",
        math(String.raw`m`),
        " で値が等しいので、写像として ",
        math(String.raw`-(-s) = s`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。trace_of_epsilon_V_plus の証明 Step 3 の (b)・Step 4 は δ_{-(-s)=s} = 1_ℂ として証明の中で使っていたが、引ける主張ではなかった。epsilon_real_preserves_norm の準備で添字の付け替え χ(k) := ord(-ord^{-1}(k)) が χ(χ(k)) = k を満たすことを示すのに引くので主張として足した。Lean は Ising2D.negSpinConf_negSpinConf（EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusMatrixEntries.lean）。数値検証: sagemath/check/negated_row_configuration_is_involutive/。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_entries_in_row_configuration_numbering",
    kind: "claim",
    title: { tex: String.raw`\varepsilon \text{ の成分を 1 行ぶんのスピン配置の番号で読む}` },
    labels: ["epsilon_entries_in_row_configuration_numbering"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        ref("def_row_configurations"),
        " の ",
        math(String.raw`s, s' \in \mathfrak{M}`),
        " とし、",
        math(String.raw`-s \in \mathfrak{M}`),
        " を ",
        ref("def_negated_row_configuration"),
        " のものとする。",
        ref("def_global_spin_flip_matrix"),
        " の ",
        math(String.raw`\varepsilon \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord}`),
        "（値は ",
        ref("row_configuration_numbering_bijective"),
        " より ",
        math(String.raw`\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " に属し、行列の番号として使える）について",
      ]),
      displayMath(String.raw`\varepsilon_{\mathrm{ord}(s),\,\mathrm{ord}(s')} =
\begin{cases}
1_{\mathbb{C}} & (s' = -s)\\
0_{\mathbb{C}} & (s' \neq -s)
\end{cases}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`0_{\mathbb{C}}, 1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " で ",
        math(String.raw`I := \iota(s) = (i_1,\dots,i_{M_{\mathrm{col}}})`),
        "、",
        math(String.raw`J := \iota(s') = (j_1,\dots,j_{M_{\mathrm{col}}})`),
        " とおく。準備として、",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " を取り、",
        math(String.raw`(\sigma^x)_{i_m j_m}`),
        " を場合分けで求める。",
        math(String.raw`s'(m) = -s(m)`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
&s'(m) = -s(m)\\
\Longrightarrow\ &s'(m) \neq s(m)
  &&\bigl(\because\ s(m) \in \{-1,1\}\ \text{なので}\ -s(m) \neq s(m)\bigr)\\
\Longrightarrow\ &i_m \neq j_m
  &&\bigl(\because\ \blkref{def_config_basis_iso}\ \text{の}\ i_m\ \text{の場合分け}\bigr)\\
\Longrightarrow\ &(\sigma^x)_{i_m j_m} = 1_{\mathbb{C}}
  &&\bigl(\because\ \blkref{pauli_matrix_products}\ \text{の}\ \sigma^x\ \text{の成分}\ (\sigma^x)_{12} = (\sigma^x)_{21} = 1_{\mathbb{C}}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`s'(m) \neq -s(m)`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
&s'(m) \neq -s(m)\\
\Longrightarrow\ &s'(m) = s(m)
  &&\bigl(\because\ s'(m)\ \text{は 2 元の集合}\ \{-1,1\} = \{s(m), -s(m)\}\ \text{の元}\bigr)\\
\Longrightarrow\ &i_m = j_m
  &&\bigl(\because\ \blkref{def_config_basis_iso}\ \text{の}\ i_m\ \text{の場合分け}\bigr)\\
\Longrightarrow\ &(\sigma^x)_{i_m j_m} = 0_{\mathbb{C}}
  &&\bigl(\because\ \blkref{pauli_matrix_products}\ \text{の}\ \sigma^x\ \text{の成分}\ (\sigma^x)_{11} = (\sigma^x)_{22} = 0_{\mathbb{C}}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`s' = -s`),
        "（",
        ref("def_negated_row_configuration"),
        "）のとき、すべての ",
        math(String.raw`m`),
        " で ",
        math(String.raw`s'(m) = -s(m)`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon_{\mathrm{ord}(s),\,\mathrm{ord}(s')}
&= \varepsilon_{\nu(I),\,\nu(J)}
  &&\bigl(\because\ \blkref{config_numbering_equals_kronecker_numbering}\ (\mu \to s,\ \mu \to s')\bigr)\\
&= \bigl(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}}\bigr)_{\nu(I),\,\nu(J)}
  &&\bigl(\because\ \blkref{global_spin_flip_kronecker_form}\bigr)\\
&= \prod_{m=1}^{M_{\mathrm{col}}} (\sigma^x)_{i_m j_m}
  &&\bigl(\because\ \blkref{def_kronecker}\ (2)\ (M \to M_{\mathrm{col}},\ A_k \to \sigma^x)\bigr)\\
&= \prod_{m=1}^{M_{\mathrm{col}}} 1_{\mathbb{C}}
  &&\bigl(\because\ \text{準備の}\ s'(m) = -s(m)\ \text{の場合を各因子へ同時に適用}\bigr)\\
&= 1_{\mathbb{C}}
  &&\bigl(\because\ \blkref{finite_product_of_complex_ones}\ (m \to M_{\mathrm{col}})\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`s' \neq -s`),
        " のとき、",
        math(String.raw`\mathfrak{M}`),
        " の二つの元 ",
        math(String.raw`s', -s`),
        " は写像として異なるので、",
        math(String.raw`s'(n) \neq (-s)(n) = -s(n)`),
        " を満たす ",
        math(String.raw`n \in \{1,\dots,M_{\mathrm{col}}\}`),
        " が在り、準備の ",
        math(String.raw`s'(m) \neq -s(m)`),
        " の場合（",
        math(String.raw`m \to n`),
        "）より ",
        math(String.raw`(\sigma^x)_{i_n j_n} = 0_{\mathbb{C}}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon_{\mathrm{ord}(s),\,\mathrm{ord}(s')}
&= \varepsilon_{\nu(I),\,\nu(J)}
  &&\bigl(\because\ \blkref{config_numbering_equals_kronecker_numbering}\ (\mu \to s,\ \mu \to s')\bigr)\\
&= \bigl(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}}\bigr)_{\nu(I),\,\nu(J)}
  &&\bigl(\because\ \blkref{global_spin_flip_kronecker_form}\bigr)\\
&= \prod_{m=1}^{M_{\mathrm{col}}} (\sigma^x)_{i_m j_m}
  &&\bigl(\because\ \blkref{def_kronecker}\ (2)\ (M \to M_{\mathrm{col}},\ A_k \to \sigma^x)\bigr)\\
&= 0_{\mathbb{C}}
  &&\bigl(\because\ \blkref{finite_product_with_zero_factor_is_zero}\ (m \to M_{\mathrm{col}},\ z_m \to (\sigma^x)_{i_m j_m},\ n \to n)\ \text{と}\ (\sigma^x)_{i_n j_n} = 0_{\mathbb{C}}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は「ε は各基底ベクトルを別の基底ベクトルへ写す置換行列」を trace_of_epsilon_V_plus の証明 Step 3 の (b)（証明の途中の段で、理由は散文）から引いていた。引ける主張にするため、ε の成分を global_spin_flip_kronecker_form と def_kronecker (2) から一行ずつ求める主張として足した。trace_of_epsilon_V_plus の (b) は列の向き ε_{ord(s'),ord(s)} = δ_{-s=s'} を基底ベクトルへの作用から読むもので、値は同じである。数値検証: sagemath/check/epsilon_entries_in_row_configuration_numbering/。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_real_permutes_entries_by_spin_flip",
    kind: "claim",
    title: { tex: String.raw`(\varepsilon_{\mathbb{R}}u)_{\mathrm{ord}(s)} = u_{\mathrm{ord}(-s)}` },
    labels: ["epsilon_real_permutes_entries_by_spin_flip"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`u \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        ref("def_row_configurations"),
        " の ",
        math(String.raw`s \in \mathfrak{M}`),
        " とし、",
        math(String.raw`-s`),
        " は ",
        ref("def_negated_row_configuration"),
        " のものとする。",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " と ",
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord}`),
        "（値は ",
        ref("row_configuration_numbering_bijective"),
        " より ",
        math(String.raw`\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " に属する）について",
      ]),
      displayMath(String.raw`(\varepsilon_{\mathbb{R}}u)_{\mathrm{ord}(s)} = u_{\mathrm{ord}(-s)}`),
      paragraph([
        "が成り立つ。左辺の積は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to 2^{M_{\mathrm{col}}},\ P \to \varepsilon_{\mathbb{R}},\ x \to u`),
        "）のものである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        " と略記し、",
        math(String.raw`r_{\mathbb{C}}`),
        "（",
        math(String.raw`r \in \mathbb{R}`),
        "）は ",
        ref("inclusion_rr_to_cc"),
        " の略記とする。",
        math(String.raw`l \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`y_l := (\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,l}\,u_l \in \mathbb{R}`),
        " とおく。",
        ref("row_configuration_numbering_bijective"),
        " より、",
        math(String.raw`l \neq \mathrm{ord}(-s)`),
        " の ",
        math(String.raw`l`),
        " は ",
        math(String.raw`t \neq -s`),
        " を満たす ",
        math(String.raw`t \in \mathfrak{M}`),
        " で ",
        math(String.raw`l = \mathrm{ord}(t)`),
        " と書ける。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
(y_l)_{\mathbb{C}}
&= \bigl((\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,\mathrm{ord}(t)}\,u_{\mathrm{ord}(t)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ y_l := (\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,l}\,u_l\ \text{と}\ l = \mathrm{ord}(t)\bigr)\\
&= \bigl((\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,\mathrm{ord}(t)}\bigr)_{\mathbb{C}}\,\bigl(u_{\mathrm{ord}(t)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a \to (\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,\mathrm{ord}(t)},\ b \to u_{\mathrm{ord}(t)})\ \text{を右辺から左辺へ}\bigr)\\
&= \varepsilon_{\mathrm{ord}(s),\,\mathrm{ord}(t)}\,\bigl(u_{\mathrm{ord}(t)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{def_epsilon_real}\bigr)\\
&= 0_{\mathbb{C}}\,\bigl(u_{\mathrm{ord}(t)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{epsilon_entries_in_row_configuration_numbering}\ (s' \to t,\ t \neq -s)\bigr)\\
&= 0_{\mathbb{C}}
  &&\bigl(\because\ \blkref{complex_zero_times_is_zero}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`l = \mathrm{ord}(-s)`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(y_{\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}
&= \bigl((\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,\mathrm{ord}(-s)}\,u_{\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ y_l := (\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,l}\,u_l\ (l \to \mathrm{ord}(-s))\bigr)\\
&= \bigl((\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}\,\bigl(u_{\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a \to (\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,\mathrm{ord}(-s)},\ b \to u_{\mathrm{ord}(-s)})\ \text{を右辺から左辺へ}\bigr)\\
&= \varepsilon_{\mathrm{ord}(s),\,\mathrm{ord}(-s)}\,\bigl(u_{\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{def_epsilon_real}\bigr)\\
&= 1_{\mathbb{C}}\,\bigl(u_{\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{epsilon_entries_in_row_configuration_numbering}\ (s' \to -s)\bigr)\\
&= \bigl(u_{\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元}\bigr)
\end{aligned}`),
      paragraph(["である。よって"]),
      displayMath(String.raw`\begin{aligned}
\bigl((\varepsilon_{\mathbb{R}}u)_{\mathrm{ord}(s)}\bigr)_{\mathbb{C}}
&= \Bigl(\sum_{l=1}^{d} (\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,l}\,u_l\Bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{def_real_matrix_vector_product}\ (m, n \to d,\ P \to \varepsilon_{\mathbb{R}},\ x \to u,\ i \to \mathrm{ord}(s))\bigr)\\
&= \Bigl(\sum_{l=1}^{d} y_l\Bigr)_{\mathbb{C}}
  &&\bigl(\because\ y_l := (\varepsilon_{\mathbb{R}})_{\mathrm{ord}(s),\,l}\,u_l\ \text{を}\ d\ \text{個の項へ同時に適用}\bigr)\\
&= \sum_{l=1}^{d} (y_l)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\ (m \to d,\ r_j \to y_j)\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl(y_{\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{finite_sum_with_single_nonzero_term}\ (m \to d,\ z_j \to (y_j)_{\mathbb{C}},\ n \to \mathrm{ord}(-s))\ \text{と、上で示した}\ l \neq \mathrm{ord}(-s)\ \text{のときの}\ (y_l)_{\mathbb{C}} = 0_{\mathbb{C}}\bigr)\\
&= \bigl(u_{\mathrm{ord}(-s)}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \text{上で示した}\ (y_{\mathrm{ord}(-s)})_{\mathbb{C}} = (u_{\mathrm{ord}(-s)})_{\mathbb{C}}\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to (\varepsilon_{\mathbb{R}}u)_{\mathrm{ord}(s)},\ b \to u_{\mathrm{ord}(-s)}`),
        "）より ",
        math(String.raw`(\varepsilon_{\mathbb{R}}u)_{\mathrm{ord}(s)} = u_{\mathrm{ord}(-s)}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は実数のベクトル u に複素行列 ε を掛け、「ε は置換行列」（trace_of_epsilon_V_plus の証明 Step 3 の (b)）から u ≥ 0 ⇒ εu ≥ 0 と ‖εu‖ = ‖u‖ を出していた。この同一視を def_epsilon_real の ε_ℝ で書き直すために、ε_ℝ を実数のベクトルに掛けると成分が符号反転 s ↦ -s で並べ替わることを示す主張として足した。実数の有限和のうち一つの項のほかが 0 のものを述べるブロックが本文に無いので、real_identity_matrix_is_left_unit_of_real_matrix_vector_product と同じく和を ℂ へ包含して finite_sum_with_single_nonzero_term を当て、単射性で戻す。数値検証: sagemath/check/epsilon_real_permutes_entries_by_spin_flip/。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_real_preserves_nonnegative_vectors",
    kind: "claim",
    title: { tex: String.raw`u_k \geq 0\ (\forall k) \Longrightarrow (\varepsilon_{\mathbb{R}}u)_k \geq 0\ (\forall k)` },
    labels: ["epsilon_real_preserves_nonnegative_vectors"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`d := 2^{M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        math(String.raw`u \in \mathbb{R}^{d}`),
        " がすべての ",
        math(String.raw`k \in \{1,\dots,d\}`),
        " で ",
        math(String.raw`u_k \geq 0`),
        " を満たすとする。",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " について、すべての ",
        math(String.raw`k \in \{1,\dots,d\}`),
        " で",
      ]),
      displayMath(String.raw`(\varepsilon_{\mathbb{R}}u)_k \geq 0`),
      paragraph([
        "が成り立つ。左辺の積は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to d,\ P \to \varepsilon_{\mathbb{R}},\ x \to u`),
        "）のものである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k \in \{1,\dots,d\}`),
        " を取る。",
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord}`),
        " について、",
        ref("row_configuration_numbering_bijective"),
        " より ",
        math(String.raw`k = \mathrm{ord}(s)`),
        " を満たす ",
        ref("def_row_configurations"),
        " の ",
        math(String.raw`s \in \mathfrak{M}`),
        " が在る。",
        ref("def_negated_row_configuration"),
        " より ",
        math(String.raw`-s \in \mathfrak{M}`),
        " なので、",
        ref("row_configuration_numbering_bijective"),
        " より ",
        math(String.raw`\mathrm{ord}(-s) \in \{1,\dots,d\}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\varepsilon_{\mathbb{R}}u)_k
&= (\varepsilon_{\mathbb{R}}u)_{\mathrm{ord}(s)}
  &&\bigl(\because\ k = \mathrm{ord}(s)\bigr)\\
&= u_{\mathrm{ord}(-s)}
  &&\bigl(\because\ \blkref{epsilon_real_permutes_entries_by_spin_flip}\ (u \to u,\ s \to s)\bigr)\\
&\geq 0
  &&\bigl(\because\ \text{仮定の}\ u_k \geq 0\ (k \to \mathrm{ord}(-s))\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は「ε は置換行列」（trace_of_epsilon_V_plus の証明 Step 3 の (b)）から u ≥ 0 ⇒ εu ≥ 0 を散文で出し、実数のベクトル u に複素行列 ε を掛けていた。この同一視を def_epsilon_real の ε_ℝ で書き直すために、epsilon_real_permutes_entries_by_spin_flip の帰結として足した。本文に実数のベクトルの順序 u ≥ 0 を定めるブロックが無いので、主張は成分ごとに述べる。数値検証: sagemath/check/epsilon_real_preserves_nonnegative_vectors/。",
      ],
    },
  },
  {
    id: "maxeig_claim_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero",
    kind: "claim",
    title: { text: "成分が非負で 0 でないベクトル u について、成分が u_k + (ε_ℝu)_k のベクトルは 0 でない" },
    labels: ["sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`d := 2^{M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を取る。",
        math(String.raw`u \in \mathbb{R}^{d}`),
        " がすべての ",
        math(String.raw`k \in \{1,\dots,d\}`),
        " で ",
        math(String.raw`u_k \geq 0`),
        " を満たし、かつ ",
        math(String.raw`u \neq 0`),
        " であるとする（",
        math(String.raw`\mathbb{R}^{d}`),
        " の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`x = 0`),
        " は、すべての ",
        math(String.raw`k \in \{1,\dots,d\}`),
        " で ",
        math(String.raw`x_k = 0`),
        " であることを表す。",
        ref("def_rayleigh_sup"),
        "・",
        ref("W_real_is_positive_definite"),
        " と同じ）。",
        math(String.raw`v \in \mathbb{R}^{d}`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`v_k := u_k + (\varepsilon_{\mathbb{R}}u)_k \qquad (k \in \{1,\dots,d\})`),
      paragraph([
        "で定める（",
        math(String.raw`\varepsilon_{\mathbb{R}}u \in \mathbb{R}^{d}`),
        " は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to d,\ P \to \varepsilon_{\mathbb{R}},\ x \to u`),
        "）の積、和は ",
        math(String.raw`\mathbb{R}`),
        " の和）。このとき",
      ]),
      displayMath(String.raw`v \neq 0`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、この章で、成分が実数の値をとる行列とベクトルにこの主張を使うためである。証明は ",
        math(String.raw`\mathbb{R}`),
        " の順序と加法だけを使い、極限・完備性を使わない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`u \neq 0`),
        " なので、",
        math(String.raw`u_{k_0} \neq 0`),
        " を満たす ",
        math(String.raw`k_0 \in \{1,\dots,d\}`),
        " が在る。仮定の ",
        math(String.raw`u_{k_0} \geq 0`),
        " と ",
        math(String.raw`u_{k_0} \neq 0`),
        " より ",
        math(String.raw`u_{k_0} > 0`),
        " である。",
        ref("epsilon_real_preserves_nonnegative_vectors"),
        "（",
        math(String.raw`u \to u,\ k \to k_0`),
        "）より、",
        math(String.raw`(\varepsilon_{\mathbb{R}}u)_{k_0} \geq 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
v_{k_0}
&= u_{k_0} + (\varepsilon_{\mathbb{R}}u)_{k_0}
  &&\bigl(\because\ v\ \text{の定義}\ (k \to k_0)\bigr)\\
&\geq u_{k_0} + 0
  &&\bigl(\because\ (\varepsilon_{\mathbb{R}}u)_{k_0} \geq 0\ \text{と}\ \mathbb{R}\ \text{の順序と加法の両立}\ (a \geq b \Rightarrow c + a \geq c + b)\bigr)\\
&= u_{k_0}
  &&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\bigr)\\
&> 0
  &&\bigl(\because\ u_{k_0} > 0\bigr)
\end{aligned}`),
      paragraph([
        "よって（",
        math(String.raw`\mathbb{R}`),
        " の順序の推移律で ",
        math(String.raw`v_{k_0} > 0`),
        "）",
        math(String.raw`v_{k_0} \neq 0`),
        " であり、すべての ",
        math(String.raw`k`),
        " で ",
        math(String.raw`v_k = 0`),
        " ではないので、",
        math(String.raw`v \neq 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は「v ≥ u ≥ 0 かつ u ≠ 0 より v ≠ 0」を散文で出し、実数のベクトル u に複素行列 ε を掛けていた。この同一視を def_epsilon_real の ε_ℝ で書き直すために、epsilon_real_preserves_nonnegative_vectors の帰結として足した。本文に実数のベクトルの順序と ℝ^d の元どうしの和を定めるブロックが無いので、v を成分の等式で与え、0 でない成分を一つ取って示す（epsilon_real_fixes_sum_of_vector_and_its_image と同じ v）。数値検証: sagemath/check/sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero/。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_real_preserves_norm",
    kind: "claim",
    title: { tex: String.raw`\|\varepsilon_{\mathbb{R}}u\| = \|u\|` },
    labels: ["epsilon_real_preserves_norm"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`d := 2^{M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`u \in \mathbb{R}^{d}`),
        " とする。",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " について",
      ]),
      displayMath(String.raw`\|\varepsilon_{\mathbb{R}}u\| = \|u\|`),
      paragraph([
        "が成り立つ。左辺の積は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to d,\ P \to \varepsilon_{\mathbb{R}},\ x \to u`),
        "）のもの、両辺のノルムは ",
        ref("def_matrix_norm"),
        "（",
        math(String.raw`K = \mathbb{R}`),
        "、",
        math(String.raw`d \to d`),
        "）の数ベクトルのノルムである。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord} : \mathfrak{M} \to \{1,\dots,d\}`),
        " は ",
        ref("row_configuration_numbering_bijective"),
        " より全単射なので、各 ",
        math(String.raw`k \in \{1,\dots,d\}`),
        " に ",
        math(String.raw`\mathrm{ord}(s) = k`),
        " を満たす ",
        math(String.raw`s \in \mathfrak{M}`),
        " がただ一つ在る。それを ",
        math(String.raw`\mathrm{ord}^{-1}(k) \in \mathfrak{M}`),
        " と書く。すなわち ",
        math(String.raw`\mathrm{ord}(\mathrm{ord}^{-1}(k)) = k`),
        "（",
        math(String.raw`k \in \{1,\dots,d\}`),
        "）、",
        math(String.raw`\mathrm{ord}^{-1}(\mathrm{ord}(t)) = t`),
        "（",
        math(String.raw`t \in \mathfrak{M}`),
        "）である。",
        ref("def_negated_row_configuration"),
        " より ",
        math(String.raw`-\mathrm{ord}^{-1}(k) \in \mathfrak{M}`),
        " なので、",
        math(String.raw`\chi : \{1,\dots,d\} \to \{1,\dots,d\}`),
        " を",
      ]),
      displayMath(String.raw`\chi(k) := \mathrm{ord}\bigl(-\mathrm{ord}^{-1}(k)\bigr) \qquad (k \in \{1,\dots,d\})`),
      paragraph([
        "で定める。",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi(\chi(k))
&= \mathrm{ord}\bigl(-\mathrm{ord}^{-1}(\chi(k))\bigr)
  &&\bigl(\because\ \chi\ \text{の定義}\ (k \to \chi(k))\bigr)\\
&= \mathrm{ord}\Bigl(-\mathrm{ord}^{-1}\bigl(\mathrm{ord}(-\mathrm{ord}^{-1}(k))\bigr)\Bigr)
  &&\bigl(\because\ \chi\ \text{の定義}\bigr)\\
&= \mathrm{ord}\bigl(-(-\mathrm{ord}^{-1}(k))\bigr)
  &&\bigl(\because\ \mathrm{ord}^{-1}(\mathrm{ord}(t)) = t\ (t \to -\mathrm{ord}^{-1}(k))\bigr)\\
&= \mathrm{ord}\bigl(\mathrm{ord}^{-1}(k)\bigr)
  &&\bigl(\because\ \blkref{negated_row_configuration_is_involutive}\ (s \to \mathrm{ord}^{-1}(k))\bigr)\\
&= k
  &&\bigl(\because\ \mathrm{ord}(\mathrm{ord}^{-1}(k)) = k\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\chi`),
        " は単射である。実際、",
        math(String.raw`k, k' \in \{1,\dots,d\}`),
        " が ",
        math(String.raw`\chi(k) = \chi(k')`),
        " を満たすなら",
      ]),
      displayMath(String.raw`\begin{aligned}
k
&= \chi(\chi(k))
  &&\bigl(\because\ \text{上で示した}\ \chi(\chi(k)) = k\ \text{を右辺から左辺へ}\bigr)\\
&= \chi(\chi(k'))
  &&\bigl(\because\ \chi(k) = \chi(k')\bigr)\\
&= k'
  &&\bigl(\because\ \text{上で示した}\ \chi(\chi(k)) = k\ (k \to k')\bigr)
\end{aligned}`),
      paragraph([
        "である。また ",
        math(String.raw`\chi`),
        " は全射である。実際、",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`\chi(k) \in \{1,\dots,d\}`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi\bigl(\chi(k)\bigr)
&= k
  &&\bigl(\because\ \text{上で示した}\ \chi(\chi(k)) = k\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        math(String.raw`k`),
        " は ",
        math(String.raw`\chi(k)`),
        " の像である。したがって ",
        math(String.raw`\chi`),
        " は全単射である。さらに ",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(\varepsilon_{\mathbb{R}}u)_k
&= (\varepsilon_{\mathbb{R}}u)_{\mathrm{ord}(\mathrm{ord}^{-1}(k))}
  &&\bigl(\because\ \mathrm{ord}(\mathrm{ord}^{-1}(k)) = k\ \text{を右辺から左辺へ}\bigr)\\
&= u_{\mathrm{ord}(-\mathrm{ord}^{-1}(k))}
  &&\bigl(\because\ \blkref{epsilon_real_permutes_entries_by_spin_flip}\ (u \to u,\ s \to \mathrm{ord}^{-1}(k))\bigr)\\
&= u_{\chi(k)}
  &&\bigl(\because\ \chi\ \text{の定義を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\|\varepsilon_{\mathbb{R}}u\|
&= \sqrt{\sum_{k=1}^{d} \bigl|(\varepsilon_{\mathbb{R}}u)_k\bigr|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to d,\ w \to \varepsilon_{\mathbb{R}}u)\bigr)\\
&= \sqrt{\sum_{k=1}^{d} \bigl|u_{\chi(k)}\bigr|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \text{上で示した}\ (\varepsilon_{\mathbb{R}}u)_k = u_{\chi(k)}\ \text{を}\ d\ \text{個の項へ同時に適用}\bigr)\\
&= \sqrt{\sum_{k=1}^{d} |u_k|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing}\ (m \to d,\ a_j \to |u_j|^2,\ \pi \to \chi)\bigr)\\
&= \|u\|
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to d,\ w \to u)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は「ε は置換行列であり、成分の並べ替えは二乗和を変えない」から ‖εu‖ = ‖u‖ を散文で出し、実数のベクトル u に複素行列 ε を掛けていた。この同一視を def_epsilon_real の ε_ℝ で書き直すために、epsilon_real_permutes_entries_by_spin_flip と finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing の帰結として足した。Lean は Ising2D.epsilon_real_preserves_norm（ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealPreservesNorm.lean）。付け替えの写像を χ と書くのは、π をこの章で円周率に、κ を論文の別の章で定数と添字に使っているためである。数値検証: sagemath/check/epsilon_real_preserves_norm/。",
      ],
    },
  },
  {
    id: "maxeig_claim_norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four",
    kind: "claim",
    title: { text: "‖u‖ = 1 のとき、成分が u_k + (ε_ℝu)_k のベクトル v について ‖v‖^2 ≤ 4" },
    labels: ["norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`d := 2^{M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を取る。",
        math(String.raw`u \in \mathbb{R}^{d}`),
        " が ",
        math(String.raw`\|u\| = 1`),
        " を満たすとする（ノルムは ",
        ref("def_matrix_norm"),
        "（",
        math(String.raw`K = \mathbb{R}`),
        "、",
        math(String.raw`d \to d`),
        "）の数ベクトルのノルム）。",
        math(String.raw`v \in \mathbb{R}^{d}`),
        " を、成分ごとに",
      ]),
      displayMath(String.raw`v_k := u_k + (\varepsilon_{\mathbb{R}}u)_k \qquad (k \in \{1,\dots,d\})`),
      paragraph([
        "で定める（",
        math(String.raw`\varepsilon_{\mathbb{R}}u \in \mathbb{R}^{d}`),
        " は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to d,\ P \to \varepsilon_{\mathbb{R}},\ x \to u`),
        "）の積、和は ",
        math(String.raw`\mathbb{R}`),
        " の和）。このとき",
      ]),
      displayMath(String.raw`\|v\|^2 \leq 4`),
      paragraph([
        "が成り立つ。",
        math(String.raw`\|v\|^2 := \|v\|\,\|v\|`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の積である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、この章で、成分が実数の値をとる行列とベクトルにこの主張を使うためである。",
        "ノルムの平方根は ",
        ref("definition_of_sqrt_r_positive"),
        " のもので、その存在に ",
        math(String.raw`\mathbb{R}`),
        " の完備性を使う（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。証明はそのほかに ",
        math(String.raw`\mathbb{R}`),
        " の四則演算と順序と有限和だけを使い、極限を使わない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値である。まず、",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " について ",
        math(String.raw`\sum_{k=1}^{d} |x_k|^2 \geq 0`),
        "（",
        ref("def_matrix_norm"),
        " の根号の中）であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|x\|^2
&= \Bigl(\sqrt{\textstyle\sum_{k=1}^{d} |x_k|^2}^{\,(\mathbb{R}_{\ge 0})}\Bigr)^2
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to d,\ w \to x)\bigr)\\
&= \sum_{k=1}^{d} |x_k|^2
  &&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ y^2 = x\ (x \to \textstyle\sum_{k=1}^{d} |x_k|^2)\bigr)
\end{aligned}`),
      paragraph([
        "である。次に、",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
|v_k|^2
&= v_k^2
  &&\bigl(\because\ \blkref{square_of_real_absolute_value}\ (q \to v_k)\bigr)\\
&= \bigl(u_k + (\varepsilon_{\mathbb{R}}u)_k\bigr)^2
  &&\bigl(\because\ v\ \text{の定義}\bigr)\\
&\leq 2u_k^2 + 2(\varepsilon_{\mathbb{R}}u)_k^2
  &&\bigl(\because\ \blkref{square_of_real_sum_is_at_most_twice_sum_of_squares}\ (a \to u_k,\ b \to (\varepsilon_{\mathbb{R}}u)_k)\bigr)\\
&= 2|u_k|^2 + 2\bigl|(\varepsilon_{\mathbb{R}}u)_k\bigr|^2
  &&\bigl(\because\ \blkref{square_of_real_absolute_value}\ (q \to u_k\ \text{と}\ q \to (\varepsilon_{\mathbb{R}}u)_k)\ \text{を右辺から左辺へ 2 か所へ同時適用}\bigr)
\end{aligned}`),
      paragraph(["である。よって"]),
      displayMath(String.raw`\begin{aligned}
\|v\|^2
&= \sum_{k=1}^{d} |v_k|^2
  &&\bigl(\because\ \text{上で示した}\ \|x\|^2 = \textstyle\sum_{k=1}^{d} |x_k|^2\ (x \to v)\bigr)\\
&\leq \sum_{k=1}^{d} \Bigl(2|u_k|^2 + 2\bigl|(\varepsilon_{\mathbb{R}}u)_k\bigr|^2\Bigr)
  &&\bigl(\because\ \blkref{finite_sum_of_real_numbers_is_monotone}\ (m \to d,\ a_j \to |v_j|^2,\ b_j \to 2|u_j|^2 + 2|(\varepsilon_{\mathbb{R}}u)_j|^2)\ \text{と上で示した}\ |v_k|^2\ \text{の評価}\bigr)\\
&= \Bigl(\sum_{k=1}^{d} 2|u_k|^2\Bigr) + \Bigl(\sum_{k=1}^{d} 2\bigl|(\varepsilon_{\mathbb{R}}u)_k\bigr|^2\Bigr)
  &&\bigl(\because\ \blkref{finite_sum_of_real_sums}\ (m \to d,\ \text{添字}\ j \to k,\ a_k \to 2|u_k|^2,\ b_k \to 2|(\varepsilon_{\mathbb{R}}u)_k|^2)\bigr)\\
&= 2\sum_{k=1}^{d} |u_k|^2 + 2\sum_{k=1}^{d} \bigl|(\varepsilon_{\mathbb{R}}u)_k\bigr|^2
  &&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (m \to d,\ c \to 2,\ \text{添字}\ j \to k,\ x_k \to |u_k|^2\ \text{と}\ x_k \to |(\varepsilon_{\mathbb{R}}u)_k|^2)\ \text{を 2 か所へ同時適用}\bigr)\\
&= 2\|u\|^2 + 2\|\varepsilon_{\mathbb{R}}u\|^2
  &&\bigl(\because\ \text{上で示した}\ \|x\|^2 = \textstyle\sum_{k=1}^{d} |x_k|^2\ (x \to u\ \text{と}\ x \to \varepsilon_{\mathbb{R}}u)\ \text{を右辺から左辺へ 2 か所へ同時適用}\bigr)\\
&= 2\|u\|^2 + 2\|u\|^2
  &&\bigl(\because\ \blkref{epsilon_real_preserves_norm}\ (u \to u)\bigr)\\
&= 2 \cdot 1^2 + 2 \cdot 1^2
  &&\bigl(\because\ \|u\| = 1\ \text{を 2 か所へ同時適用}\bigr)\\
&= 4
  &&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は ‖v‖^2 = ‖u‖^2 + 2u^⊤εu + ‖εu‖^2 = 2 + 2u^⊤εu ≤ 4 を「v = u + εu の展開と ε^⊤ = ε」「Cauchy–Schwarz」の名前で出し、実数のベクトル u に複素行列 ε を掛けていた。この同一視を def_epsilon_real の ε_ℝ で書き直すために足した。Cauchy–Schwarz（psd_cauchy_schwarz の P → I_ℝ）で示すには、x^⊤I_ℝy = Σ_k x_ky_k、I_ℝ の対称性と半正定値性、‖x‖^2 = x^⊤I_ℝx の主張が本文に要る。成分ごとに (a + b)^2 ≤ 2a^2 + 2b^2 で評価する道は、ℝ の四則演算と順序と有限和と epsilon_real_preserves_norm だけで閉じるので、こちらを採った。v は epsilon_real_fixes_sum_of_vector_and_its_image と同じく成分の等式で与える。数値検証: sagemath/check/norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four/。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors",
    kind: "claim",
    title: { tex: String.raw`\varepsilon_{\mathbb{R}}x = x \iff \iota^{2^{M_{\mathrm{col}}}}_{\mathbb{R}\to\mathbb{C}}(x) \in \mathcal{F}^{(+)}` },
    labels: ["epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " とする。",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " と ",
        ref("def_real_matrix_vector_product"),
        " の積 ",
        math(String.raw`\varepsilon_{\mathbb{R}}x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        ref("def_real_vector_inclusion"),
        " の ",
        math(String.raw`\iota^{2^{M_{\mathrm{col}}}}_{\mathbb{R}\to\mathbb{C}}`),
        "、",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について",
      ]),
      displayMath(String.raw`\varepsilon_{\mathbb{R}}x = x \iff \iota^{2^{M_{\mathrm{col}}}}_{\mathbb{R}\to\mathbb{C}}(x) \in \mathcal{F}^{(+)}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        "、",
        math(String.raw`\iota := \iota^{d}_{\mathbb{R}\to\mathbb{C}}`),
        " と略記する。",
        ref("epsilon_is_real_symmetric"),
        " より ",
        math(String.raw`\varepsilon \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の記号）であり、",
        ref("def_epsilon_real"),
        " より ",
        math(String.raw`\varepsilon_{\mathbb{R}} = \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(\varepsilon)`),
        " なので、",
        ref("real_vector_inclusion_intertwines_matrix_vector_product"),
        "（",
        math(String.raw`m \to d,\ n \to d,\ B \to \varepsilon`),
        "）が当てはまる。",
      ]),
      paragraph([
        math(String.raw`(\Rightarrow)`),
        " ",
        math(String.raw`\varepsilon_{\mathbb{R}}x = x`),
        " と仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon\,\iota(x)
&= \iota(\varepsilon_{\mathbb{R}}x)
  &&\bigl(\because\ \blkref{real_vector_inclusion_intertwines_matrix_vector_product}\ (m \to d,\ n \to d,\ B \to \varepsilon)\ \text{を右辺から左辺へ}\bigr)\\
&= \iota(x)
  &&\bigl(\because\ \text{仮定}\ \varepsilon_{\mathbb{R}}x = x\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("def_even_eigenvectors_of_epsilon"),
        "（",
        math(String.raw`f \to \iota(x)`),
        "）より ",
        math(String.raw`\iota(x) \in \mathcal{F}^{(+)}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`(\Leftarrow)`),
        " ",
        math(String.raw`\iota(x) \in \mathcal{F}^{(+)}`),
        " と仮定する。",
        ref("def_even_eigenvectors_of_epsilon"),
        "（",
        math(String.raw`f \to \iota(x)`),
        "）より ",
        math(String.raw`\varepsilon\,\iota(x) = \iota(x)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota(\varepsilon_{\mathbb{R}}x)
&= \varepsilon\,\iota(x)
  &&\bigl(\because\ \blkref{real_vector_inclusion_intertwines_matrix_vector_product}\ (m \to d,\ n \to d,\ B \to \varepsilon)\bigr)\\
&= \iota(x)
  &&\bigl(\because\ \text{仮定から得た}\ \varepsilon\,\iota(x) = \iota(x)\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("real_vector_inclusion_is_injective"),
        "（",
        math(String.raw`n \to d,\ x \to \varepsilon_{\mathbb{R}}x,\ y \to x`),
        "）より ",
        math(String.raw`\varepsilon_{\mathbb{R}}x = x`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_sector_rayleigh_sup の 𝓕^{(+)} ∩ ℝ^{2^{M_col}} を {x ∈ ℝ^{2^{M_col}} | ε_ℝx = x} と述べ直すときに、二つの集合の元の行き来を ι^{2^{M_col}}_{ℝ→ℂ} で書くために足した。",
      ],
    },
  },

  {
    id: "maxeig_010a_definition_sector_rayleigh_sup",
    kind: "definition",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 12 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) := \sup \mathcal{R}_+ \text{（}\varepsilon_{\mathbb{R}}x = x\text{ を満たす単位ベクトルでの上限）}` },
    labels: ["def_sector_rayleigh_sup"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_W_real"),
        " の ",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " と ",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " について（",
        math(String.raw`\varepsilon_{\mathbb{R}}x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " は ",
        ref("def_real_matrix_vector_product"),
        " の積）、",
      ]),
      displayMath(
        String.raw`\mathcal{R}_+ := \left\{\, x^\top W_{\mathbb{R}} x \ \middle|\ x \in \mathbb{R}^{2^{M_{\mathrm{col}}}},\ \varepsilon_{\mathbb{R}}x = x,\ \|x\| = 1 \,\right\} \subseteq \mathbb{R},
\qquad c_+(M_{\mathrm{col}}) := \sup \mathcal{R}_+`,
      ),
      paragraph([
        "とおく。",
        ref("epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors"),
        " より、条件 ",
        math(String.raw`\varepsilon_{\mathbb{R}}x = x`),
        " は ",
        math(String.raw`\iota^{2^{M_{\mathrm{col}}}}_{\mathbb{R}\to\mathbb{C}}(x) \in \mathcal{F}^{(+)}`),
        "（",
        ref("def_even_eigenvectors_of_epsilon"),
        "）と同値である。",
        math(String.raw`x^\top W_{\mathbb{R}} x \in \mathbb{R}`),
        " は ",
        ref("def_real_bilinear_value"),
        "（",
        math(String.raw`n \to 2^{M_{\mathrm{col}}},\ P \to W_{\mathbb{R}},\ y \to x`),
        "）の値であり、",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        " の元と同じ式である。この上限が定まること、すなわち ",
        math(String.raw`\mathcal{R}_+`),
        " が空でなく上に有界であることを先に確かめる。上に有界なのは、",
        math(String.raw`\mathcal{R}_+`),
        " の元 ",
        math(String.raw`x^\top W_{\mathbb{R}} x`),
        " の ",
        math(String.raw`x`),
        " が ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を満たすので ",
        math(String.raw`\mathcal{R}_+ \subseteq \mathcal{R}`),
        "（",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        "）であり、",
        math(String.raw`\mathcal{R}`),
        " が成分の絶対値の有限和 ",
        math(String.raw`\sum_{i=1}^{2^{M_{\mathrm{col}}}}\sum_{j=1}^{2^{M_{\mathrm{col}}}}|(W_{\mathbb{R}})_{ij}|`),
        " で上に有界だからである（",
        ref("def_rayleigh_sup"),
        " の有界性の評価）。空でないことは、",
        math(String.raw`\varepsilon_{\mathbb{R}}x = x`),
        " を満たす単位ベクトル ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " を具体的に作れることから従う。",
      ]),
      paragraph([
        math(String.raw`\iota^{n} := \iota^{n}_{\mathbb{R}\to\mathbb{C}}`),
        "（",
        ref("def_real_vector_inclusion"),
        "）と略記する。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix} \in \mathrm{Mat}(2,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`a_+ := \begin{pmatrix}\frac{1}{\sqrt{2}} \\ \frac{1}{\sqrt{2}}\end{pmatrix} \in \mathbb{R}^2,
\qquad
b_+ := \iota^{2}(a_+) \in \mathbb{C}^2`,
      ),
      paragraph([
        "とおく。",
        ref("def_real_vector_inclusion"),
        "（",
        math(String.raw`n \to 2,\ x \to a_+`),
        "）より ",
        math(String.raw`(b_+)_1 = \bigl(\tfrac{1}{\sqrt{2}}\bigr)_{\mathbb{C}} = (b_+)_2`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x b_+
&= \begin{pmatrix}(b_+)_2 \\ (b_+)_1\end{pmatrix}
   \quad (\because \blkref{mat_mult}\ \text{の行列と数ベクトルの積と}\ \sigma^x\ \text{の成分}) \\
&= \begin{pmatrix}(b_+)_1 \\ (b_+)_2\end{pmatrix}
   \quad (\because (b_+)_1 = (b_+)_2) \\
&= b_+
   \quad (\because \text{数ベクトルを成分で書いた})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("def_kronecker"),
        " の添字集合 ",
        math(String.raw`\mathcal{I}_{M_{\mathrm{col}}}`),
        " と番号 ",
        math(String.raw`\nu`),
        " で、",
        math(String.raw`x^{(+)} \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " を成分で",
      ]),
      displayMath(
        String.raw`\left(x^{(+)}\right)_{\nu(I)} := \prod_{k=1}^{M_{\mathrm{col}}} (a_+)_{i_k}
\qquad (I = (i_1,\dots,i_{M_{\mathrm{col}}}) \in \mathcal{I}_{M_{\mathrm{col}}})`,
      ),
      paragraph([
        "と定める（右辺は ",
        ref("def_finite_product_of_real_numbers"),
        " の実数の有限積。",
        math(String.raw`\nu`),
        " が全単射だから、これで ",
        math(String.raw`\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の元が 1 つ確定する）。",
        math(String.raw`(a_+)_{i_k} = \frac{1}{\sqrt{2}}`),
        " なので、",
        math(String.raw`x^{(+)}`),
        " の各成分は ",
        math(String.raw`\left(\frac{1}{\sqrt{2}}\right)^{M_{\mathrm{col}}} = 2^{-M_{\mathrm{col}}/2}`),
        " である。各 ",
        math(String.raw`I \in \mathcal{I}_{M_{\mathrm{col}}}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\iota^{2^{M_{\mathrm{col}}}}\!\left(x^{(+)}\right)\right)_{\nu(I)}
&= \left(\left(x^{(+)}\right)_{\nu(I)}\right)_{\mathbb{C}}
   \quad (\because \blkref{def_real_vector_inclusion}\ (n \to 2^{M_{\mathrm{col}}},\ x \to x^{(+)},\ i \to \nu(I))) \\
&= \left(\prod_{k=1}^{M_{\mathrm{col}}} (a_+)_{i_k}\right)_{\mathbb{C}}
   \quad (\because x^{(+)}\ \text{の定義}) \\
&= \prod_{k=1}^{M_{\mathrm{col}}} \bigl((a_+)_{i_k}\bigr)_{\mathbb{C}}
   \quad (\because \blkref{real_inclusion_preserves_finite_product}\ (m \to M_{\mathrm{col}},\ r_k \to (a_+)_{i_k})\ \text{を右辺から左辺へ}) \\
&= \prod_{k=1}^{M_{\mathrm{col}}} (b_+)_{i_k}
   \quad (\because \blkref{def_real_vector_inclusion}\ (n \to 2,\ x \to a_+)\ \text{を各因子へ同時に適用}) \\
&= \left(b_+\boxtimes\cdots\boxtimes b_+\right)_{\nu(I)}
   \quad (\because \blkref{def_kronecker}\ \text{(1)}\ (M \to M_{\mathrm{col}},\ v_k \to b_+)\ \text{を右辺から左辺へ})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`\nu`),
        " は全単射だから ",
        math(String.raw`\iota^{2^{M_{\mathrm{col}}}}\!\left(x^{(+)}\right) = b_+\boxtimes\cdots\boxtimes b_+`),
        "（",
        math(String.raw`M_{\mathrm{col}}`),
        " 個）である。",
        ref("epsilon_square_and_eigenvalues"),
        " の証明で得た ",
        math(String.raw`\varepsilon = \sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\iota^{2^{M_{\mathrm{col}}}}\!\left(x^{(+)}\right)
&= \left(\sigma^x\boxtimes\cdots\boxtimes\sigma^x\right)\iota^{2^{M_{\mathrm{col}}}}\!\left(x^{(+)}\right)
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示}) \\
&= \left(\sigma^x\boxtimes\cdots\boxtimes\sigma^x\right)\left(b_+\boxtimes\cdots\boxtimes b_+\right)
   \quad (\because \iota^{2^{M_{\mathrm{col}}}}\!\left(x^{(+)}\right) = b_+\boxtimes\cdots\boxtimes b_+) \\
&= \left(\sigma^xb_+\right)\boxtimes\cdots\boxtimes\left(\sigma^xb_+\right)
   \quad (\because \blkref{kronecker_product_rule}\ \text{(3)}) \\
&= b_+\boxtimes\cdots\boxtimes b_+
   \quad (\because \sigma^x b_+ = b_+\ \text{を各因子へ同時に適用}) \\
&= \iota^{2^{M_{\mathrm{col}}}}\!\left(x^{(+)}\right)
   \quad (\because \iota^{2^{M_{\mathrm{col}}}}\!\left(x^{(+)}\right) = b_+\boxtimes\cdots\boxtimes b_+\ \text{を右辺から左辺へ})
\end{aligned}`,
      ),
      paragraph([
        "である。よって ",
        ref("def_even_eigenvectors_of_epsilon"),
        "（",
        math(String.raw`f \to \iota^{2^{M_{\mathrm{col}}}}(x^{(+)})`),
        "）より ",
        math(String.raw`\iota^{2^{M_{\mathrm{col}}}}(x^{(+)}) \in \mathcal{F}^{(+)}`),
        " であり、",
        ref("epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors"),
        "（",
        math(String.raw`x \to x^{(+)}`),
        "、",
        math(String.raw`(\Leftarrow)`),
        "）より ",
        math(String.raw`\varepsilon_{\mathbb{R}}x^{(+)} = x^{(+)}`),
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
        math(String.raw`\left(x^{(+)}\right)^\top W_{\mathbb{R}}x^{(+)} \in \mathcal{R}_+`),
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
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 𝓡_+ の値 x^⊤Wx は複素行列 W の二次形式で、def_rayleigh_sup の 𝓡（W_ℝ の実数の二次形式 def_real_bilinear_value）と式が違い、𝓡_+ ⊆ 𝓡 も c_+(M_col) が実数の上限であることも型が合っていなかった。𝓡_+ の値を def_W_real の W_ℝ の x^⊤W_ℝx（def_real_bilinear_value）にし、有界性の評価の和を Σ_iΣ_j|(W_ℝ)_ij| に、空でないことの元を (x^{(+)})^⊤W_ℝx^{(+)} にした。値は不変（W_ℝ の成分の包含が W の成分）。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 𝓡_+ の条件 x ∈ 𝓕^{(+)} ∩ ℝ^{2^{M_col}} は実数のベクトルを複素数のベクトルの集合 𝓕^{(+)} の元とみなす同一視だったので、def_epsilon_real の ε_ℝ で x ∈ ℝ^{2^{M_col}}、ε_ℝx = x と述べ直した（epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors で ι(x) ∈ 𝓕^{(+)} と同値）。a_+ を ℝ^2 の元、x^{(+)} を成分 Π_k (a_+)_{i_k}（実数の有限積）で定め、def_kronecker (1) が複素数のベクトルのクロネッカー積だけを定めるので、b_+ := ι^2(a_+) を置いて ι(x^{(+)}) = b_+⊠⋯⊠b_+ を成分の 5 行の鎖（real_inclusion_preserves_finite_product を引く）で示し、ει(x^{(+)}) = ι(x^{(+)}) の鎖を b_+ で書き、epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors で ε_ℝx^{(+)} = x^{(+)} へ戻した。σ^x b_+ = b_+ を 3 行の鎖に開いた。M_col ∈ ℤ_{≥1} を明記した。ノルムの鎖と上限の存在は不変。",
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
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}_+`),
        " の元は、",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`\varepsilon_{\mathbb{R}}x = x`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を満たす ",
        math(String.raw`x`),
        " についての ",
        ref("def_real_bilinear_value"),
        "（",
        math(String.raw`n \to 2^{M_{\mathrm{col}}},\ P \to W_{\mathbb{R}},\ y \to x`),
        "）の値 ",
        math(String.raw`x^\top W_{\mathbb{R}} x`),
        " である。この ",
        math(String.raw`x`),
        " は ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を満たすので、同じ値 ",
        math(String.raw`x^\top W_{\mathbb{R}} x`),
        " は ",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        " の元である。よって ",
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
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: def_sector_rayleigh_sup の 𝓡_+ を W_ℝ の実数の二次形式にしたのに合わせ、𝓡_+ ⊆ 𝓡 を「単位ベクトルどうしの包含」から「𝓡_+ の元 x^⊤W_ℝx が同じ式で 𝓡 の元である」と値の包含で述べ直した。主張は不変。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: def_sector_rayleigh_sup の 𝓡_+ の条件を x ∈ ℝ^{2^{M_col}}、ε_ℝx = x に述べ直したのに合わせ、𝓡_+ の元の x の条件を書き直した。主張と論法は不変。",
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
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、結合定数 ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とする。",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は ",
        ref("def_global_spin_flip_matrix"),
        " の全スピン反転行列 ",
        math(String.raw`\varepsilon \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と可換である（積は ",
        ref("mat_mult"),
        "）。",
      ]),
      displayMath(String.raw`\varepsilon W = W\varepsilon`),
      paragraph([
        "したがって ",
        math(String.raw`W`),
        " は ",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " を保つ。すなわち、すべての ",
        math(String.raw`f \in \mathcal{F}^{(+)}`),
        " について ",
        math(String.raw`Wf \in \mathcal{F}^{(+)}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`S := V_1^{1/2}`),
        "（",
        ref("def_transfer_matrix_square_root"),
        "）とおく。",
        ref("def_transfer_matrix_square_root"),
        " の ",
        math(String.raw`D = \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z`),
        " は ",
        ref("epsilon_commutes_with_bond_sum"),
        " の ",
        math(String.raw`D`),
        " と同じ式で定まる同じ行列である。",
        math(String.raw`\tfrac12 K_1 D`),
        " は実数 ",
        math(String.raw`\tfrac12 K_1 \in \mathbb{R}`),
        " の ",
        ref("inclusion_rr_to_cc"),
        " による像 ",
        math(String.raw`c := \left(\tfrac12 K_1\right)_{\mathbb{C}} \in \mathbb{C}`),
        " による ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍 ",
        math(String.raw`cD`),
        " と読む。したがって ",
        math(String.raw`S = \exp(cD)`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon D &= D\varepsilon
   &&(\because \blkref{epsilon_commutes_with_bond_sum}) \\
\varepsilon(cD) &= (cD)\varepsilon
   &&(\because \blkref{commuting_with_scalar_multiple}\ (G \to \varepsilon,\ X \to D)\text{、仮定 }GX = XG\text{ は }\varepsilon D = D\varepsilon) \\
\varepsilon V_2 &= V_2\varepsilon
   &&(\because \blkref{epsilon_commutes_with_V2})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon S
&= \varepsilon\exp(cD)
   &&(\because \blkref{def_transfer_matrix_square_root}) \\
&= \exp(cD)\,\varepsilon
   &&(\because \blkref{commuting_matrix_commutes_with_exp}\ (A \to \varepsilon,\ B \to cD)\text{、仮定 }AB = BA\text{ は }\varepsilon(cD) = (cD)\varepsilon) \\
&= S\varepsilon
   &&(\because \blkref{def_transfer_matrix_square_root})
\end{aligned}`,
      ),
      paragraph([
        "本体。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon W
&= \varepsilon\left((SV_2)S\right)
   &&(\because \blkref{def_symmetrized_transfer_matrix}) \\
&= \left(\varepsilon(SV_2)\right)S
   &&(\because \blkref{mat_mult_associative}) \\
&= \left((\varepsilon S)V_2\right)S
   &&(\because \blkref{mat_mult_associative}) \\
&= \left((S\varepsilon)V_2\right)S
   &&(\because \varepsilon S = S\varepsilon) \\
&= \left(S(\varepsilon V_2)\right)S
   &&(\because \blkref{mat_mult_associative}) \\
&= \left(S(V_2\varepsilon)\right)S
   &&(\because \varepsilon V_2 = V_2\varepsilon) \\
&= \left((SV_2)\varepsilon\right)S
   &&(\because \blkref{mat_mult_associative}) \\
&= (SV_2)(\varepsilon S)
   &&(\because \blkref{mat_mult_associative}) \\
&= (SV_2)(S\varepsilon)
   &&(\because \varepsilon S = S\varepsilon) \\
&= \left((SV_2)S\right)\varepsilon
   &&(\because \blkref{mat_mult_associative}) \\
&= W\varepsilon
   &&(\because \blkref{def_symmetrized_transfer_matrix})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`f \in \mathcal{F}^{(+)}`),
        " とする。",
        math(String.raw`f`),
        " は ",
        ref("mat_mult"),
        " の取り決めで ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 行 1 列の行列として積に入る。",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon f = f`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon(Wf)
&= (\varepsilon W)f
   &&(\because \blkref{mat_mult_associative}\ (q = 1)) \\
&= (W\varepsilon)f
   &&(\because \varepsilon W = W\varepsilon) \\
&= W(\varepsilon f)
   &&(\because \blkref{mat_mult_associative}\ (q = 1)) \\
&= Wf
   &&(\because \varepsilon f = f)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Wf \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        "（",
        ref("mat_mult"),
        "）と ",
        math(String.raw`\varepsilon(Wf) = Wf`),
        " より、",
        ref("def_even_eigenvectors_of_epsilon"),
        " から ",
        math(String.raw`Wf \in \mathcal{F}^{(+)}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の分割で、上限のセクター分解のブロックから、全スピン反転行列との可換性と固有空間の保存を独立させた。式変形と根拠は分割前と同じである。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-11-05: 全証明の SageMath 検算（sagemath/check/epsilon_commutes_with_W/）に合わせ、括弧を省いた等式鎖を mat_mult_associative と可換性を一行ずつ当てる鎖にし、準備の可換性を (∵) 付きの鎖にした。主張文に M_col・K_1・K_2 の帰属と「F^(+) を保つ」の読み方を書いた（主張は不変）。",
      ],
    },
  },
  {
    id: "maxeig_claim_epsilon_real_commutes_with_W_real",
    kind: "claim",
    title: { tex: String.raw`\varepsilon_{\mathbb{R}} W_{\mathbb{R}} = W_{\mathbb{R}} \varepsilon_{\mathbb{R}}` },
    labels: ["epsilon_real_commutes_with_W_real"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        "、結合定数 ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とする。",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " と ",
        ref("def_W_real"),
        " の ",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{R})`),
        " について",
      ]),
      displayMath(String.raw`\varepsilon_{\mathbb{R}} W_{\mathbb{R}} = W_{\mathbb{R}} \varepsilon_{\mathbb{R}}`),
      paragraph([
        "が成り立つ。両辺の積は ",
        ref("def_real_matrix_product"),
        " のものである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        " と略記する。",
        ref("epsilon_is_real_symmetric"),
        " より ",
        math(String.raw`\varepsilon \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "、",
        ref("W_is_real_symmetric_positive_definite"),
        " より ",
        math(String.raw`W \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の記号）であり、",
        ref("def_epsilon_real"),
        " と ",
        ref("def_W_real"),
        " より ",
        math(String.raw`\varepsilon_{\mathbb{R}} = \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(\varepsilon)`),
        "、",
        math(String.raw`W_{\mathbb{R}} = \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W)`),
        " である。したがって ",
        ref("real_matrix_of_real_entry_matrix_preserves_product"),
        "（",
        math(String.raw`m, n, p \to d,\ A \to \varepsilon,\ B \to W`),
        "、および ",
        math(String.raw`m, n, p \to d,\ A \to W,\ B \to \varepsilon`),
        "）が当てはまり、",
        ref("product_of_real_entry_matrices_has_real_entries"),
        " より ",
        math(String.raw`\varepsilon W, W\varepsilon \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " で、",
        math(String.raw`\varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(\varepsilon W)`),
        "・",
        math(String.raw`\varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W\varepsilon)`),
        " が定まる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon_{\mathbb{R}} W_{\mathbb{R}}
&= \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(\varepsilon W)
  &&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A \to \varepsilon,\ B \to W)\ \text{を右辺から左辺へ}\bigr)\\
&= \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W\varepsilon)
  &&\bigl(\because\ \blkref{epsilon_commutes_with_W}\ \text{の}\ \varepsilon W = W\varepsilon\bigr)\\
&= W_{\mathbb{R}} \varepsilon_{\mathbb{R}}
  &&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A \to W,\ B \to \varepsilon)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。c_between_Lambda_half_and_twice_Lambda_half の Step 2 は実数のベクトル u に複素行列 ε・W を掛け、εW = Wε（epsilon_commutes_with_W は複素行列についての主張）を実数の二次形式 u^⊤εWεu の書き換えに使っていた。この同一視を def_epsilon_real の ε_ℝ と def_W_real の W_ℝ で書き直すために、実数の行列どうしの可換性を示す主張として足した。ϱ が積を保つことだけで閉じ、成分ごとの単射性の段は要らない（epsilon_real_square_is_identity と同じ経路）。数値検証: sagemath/check/epsilon_real_commutes_with_W_real/。",
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
        " は連続である。証明は全実数上の ",
        math(String.raw`\cos`),
        " とその連続性（",
        ref("remark_real_analysis_escape_point"),
        " の (R0)）を前提とする（本文の ",
        ref("def_cos"),
        " は ",
        math(String.raw`[-\pi/2, \pi/2]`),
        " に限る）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`\gamma_1`),
        " の連続性）。",
        math(String.raw`\theta \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta
\qquad \left(\because\ \blkref{def_gamma1_gamma2_of_theta}\right)`,
      ),
      paragraph([
        "であり、",
        math(String.raw`c_1c_2^*, s_1s_2^* \in \mathbb{R}`),
        " は ",
        math(String.raw`\theta`),
        " に依らない（",
        ref("def_indexed_hyperbolic_abbreviations"),
        "）。定数関数は連続である（連続の定義の ",
        math(String.raw`\delta`),
        " を任意に取れる）。",
        math(String.raw`\cos : \mathbb{R} \to \mathbb{R}`),
        " は連続、連続関数の積と差は連続である（",
        ref("remark_real_analysis_escape_point"),
        " の (R0)）。よって ",
        math(String.raw`\gamma_1 : \mathbb{R} \to \mathbb{R}`),
        " は連続である。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\mathrm{arccosh}`),
        " の ",
        math(String.raw`[1,\infty)`),
        " 上の連続性）。",
        math(String.raw`y \in [1,\infty)`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{arccosh}(y) = \log\left(y+\sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}\right)
\qquad \left(\because\ \blkref{def_arccosh}\right)`,
      ),
      paragraph([
        "であり、",
        ref("def_arccosh"),
        " の右辺が定まることの鎖により ",
        math(String.raw`y^2-1 \geq 0`),
        "、",
        math(String.raw`y+\sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \geq 1 > 0`),
        " である。恒等写像 ",
        math(String.raw`y \mapsto y`),
        " と定数関数は連続であり（連続の定義の ",
        math(String.raw`\delta`),
        " を ",
        math(String.raw`\epsilon`),
        " に、または任意に取れる）、連続写像を定義域の部分集合へ制限しても連続である（同じ ",
        math(String.raw`\delta`),
        " が使える）。これらと ",
        ref("remark_real_analysis_escape_point"),
        " の (R0) により、次の各写像は連続である。",
      ]),
      list([
        [
          math(String.raw`[1,\infty) \to \mathbb{R},\ y \mapsto y^2-1`),
          "（恒等写像の積と定数関数の差。値は ",
          math(String.raw`\mathbb{R}_{\geq 0}`),
          " に入る）",
        ],
        [
          math(String.raw`[1,\infty) \to \mathbb{R},\ y \mapsto \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}`),
          "（前の写像の値が ",
          math(String.raw`\sqrt{\ \cdot\ } : \mathbb{R}_{\geq 0} \to \mathbb{R}`),
          " の定義域に入るので、その連続性と合成）",
        ],
        [
          math(String.raw`[1,\infty) \to \mathbb{R},\ y \mapsto y+\sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}`),
          "（連続関数の和。値は ",
          math(String.raw`\mathbb{R}_{>0}`),
          " に入る）",
        ],
        [
          math(String.raw`\mathrm{arccosh} : [1,\infty) \to \mathbb{R}`),
          "（前の写像の値が ",
          math(String.raw`\log : \mathbb{R}_{>0} \to \mathbb{R}`),
          " の定義域に入るので、その連続性と合成）",
        ],
      ]),
      paragraph([
        "Step 3（合成）。",
        math(String.raw`\theta \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\gamma(\theta) = \mathrm{arccosh}\left(\gamma_1(\theta)\right)
\qquad \left(\because\ \blkref{def_gamma_theta}\right)`,
      ),
      paragraph([
        "であり、",
        ref("gamma1_lower_bound_all_theta"),
        " より ",
        math(String.raw`\gamma_1(\mathbb{R}) \subseteq [1,\infty)`),
        " である。Step 1 より ",
        math(String.raw`\gamma_1 : \mathbb{R} \to \mathbb{R}`),
        " は連続で、その値はすべて Step 2 で連続性を示した ",
        math(String.raw`\mathrm{arccosh}`),
        " の定義域 ",
        math(String.raw`[1,\infty)`),
        " に入るので、合成 ",
        math(String.raw`\theta \mapsto \mathrm{arccosh}(\gamma_1(\theta))`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続である（",
        ref("remark_real_analysis_escape_point"),
        " の (R0) の合成）。よって ",
        math(String.raw`\gamma`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続である（値が ",
        math(String.raw`\mathbb{R}_{\geq 0}`),
        " に入ることは ",
        ref("def_gamma_theta"),
        " が述べている）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。arccosh の表示を確かめる e^u・e^{-u}・cosh u の計算が散文中に連結されていたのを、準備と一続きの式変形へ開き、根拠を各行末の (∵ …) へ移した。連続性・周期性の論法と参照は変更していない。",
        "2026-11-05: SageMath の検算（sagemath/check/gamma_is_continuous/）のレビューの指摘で直した。(a) 主張が連続性と周期 2π の二つを持っていた（1 ブロック 1 主張の違反）。本文で引かれるのは連続性だけなので、周期性とその証明を参照用ノート notes/claims_unused_by_chapter_goals_not_adopted.ts へ移した。(b) このブロックは cos の 2π 周期性を前提として宣言していなかった（本文では定義も証明もされておらず、half_integer_phase_antiperiodicity は前提として宣言して使っている。周期性ごと移したので解消）。全実数上の cos を前提とすることを主張に書いた。(c) Step 2 の準備（u := log(y+√(y²-1)) と exp(u)・exp(-u)・cosh u = y・u ≥ 0 の計算）は連続性の結論に使われておらず、arccosh(y) = u = log(…) は定義へ戻るだけだったので除き、Step 2 を def_arccosh の式と (R0) による合成だけにした（除いた計算は arccosh_properties が示している）。(d) def_gamma1_gamma2_of_theta・def_arccosh・def_gamma_theta への blkref と、各段の (R0) への参照を足した。(R0) に無い定数関数・恒等写像・制限の連続性は、連続の定義から直ちに従うことを書いて分けた。Step 3 は γ_1 の値域を書き換えず、値が arccosh の定義域に入ることで合成した。",
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
\exp\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\bigl(\theta^{(\delta)}_{M_{\mathrm{col}},\mu}\bigr)\right)\right)
&&\left(\because\ \Lambda^{(\delta)}_{M_{\mathrm{col}}}\text{ の定義。}\blkref{def_Lambda_delta_M}\right)\\
&=\log\left(\left(2\sinh 2K_2\right)^{M_{\mathrm{col}}/2}\right)
+\log\left(\exp\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\bigl(\theta^{(\delta)}_{M_{\mathrm{col}},\mu}\bigr)\right)\right)
&&\left(\because\ \text{積の対数 }\log(ab)=\log a+\log b\right)\\
&=\frac{M_{\mathrm{col}}}{2}\log\left(2\sinh 2K_2\right)
+\log\left(\exp\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\bigl(\theta^{(\delta)}_{M_{\mathrm{col}},\mu}\bigr)\right)\right)
&&\left(\because\ \text{冪の対数 }\log(x^{r})=r\log x\right)\\
&=\frac{M_{\mathrm{col}}}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\bigl(\theta^{(\delta)}_{M_{\mathrm{col}},\mu}\bigr)
&&\left(\because\ \log(\exp(y))=y\right)
\end{aligned}`,
      ),
      paragraph(["を得る。"]),
      paragraph([
        "ここで ",
        math(String.raw`\theta^{(\delta)}_{M_{\mathrm{col}},\mu}`),
        " を展開する。一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\bigl(\theta^{(\delta)}_{M_{\mathrm{col}},\mu}\bigr)
&=\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu_{\mathbb R}-\delta)}{(M_{\mathrm{col}})_{\mathbb R}}\right)
&&\left(\because\ \blkref{def_Theta_delta_M}\text{ を各項へ同時適用}\right)
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
  +\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\bigl(\theta^{(\delta)}_{M_{\mathrm{col}},\mu}\bigr)
\right)
&&\left(\because\ \text{上で得た }\log\Lambda^{(\delta)}_{M_{\mathrm{col}}}\text{ の表示を代入}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\bigl(\theta^{(\delta)}_{M_{\mathrm{col}},\mu}\bigr)
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu_{\mathbb R}-\delta)}{(M_{\mathrm{col}})_{\mathbb R}}\right)
&&\left(\because\ \text{上で得た }\theta^{(\delta)}_{M_{\mathrm{col}},\mu}\text{ の展開}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2}\cdot\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu_{\mathbb R}-\delta)}{(M_{\mathrm{col}})_{\mathbb R}}\right)
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
        math(String.raw`g \to \gamma,\ M \to M_{\mathrm{col}}`),
        " として適用でき（",
        ref("riemann_sum_to_integral"),
        " の ",
        math(String.raw`t^{(M_{\mathrm{col}})}_\mu`),
        " が ",
        math(String.raw`\frac{2\pi(\mu_{\mathbb R}-\delta)}{(M_{\mathrm{col}})_{\mathbb R}}`),
        " に当たる）",
      ]),
      displayMath(
        String.raw`\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu_{\mathbb R}-\delta)}{(M_{\mathrm{col}})_{\mathbb R}}\right)
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
  +\frac{1}{2}\cdot\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu_{\mathbb R}-\delta)}{(M_{\mathrm{col}})_{\mathbb R}}\right)
\right)
&&\left(\because\ \text{上で得た }\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(\delta)}_{M_{\mathrm{col}}}\text{ の表示を代入}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\lim_{M_{\mathrm{col}}\to\infty}\left(\frac{1}{2}\cdot\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu_{\mathbb R}-\delta)}{(M_{\mathrm{col}})_{\mathbb R}}\right)\right)
&&\left(\because\ \text{収束する実数列に定数を加えた列は収束し、極限に定数が加わる}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2}\cdot\lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\!\left(\frac{2\pi(\mu_{\mathbb R}-\delta)}{(M_{\mathrm{col}})_{\mathbb R}}\right)
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
        "2026-11-03: def_Theta_delta_M を集合 Θ^{(δ)}_{M_col} から添字 μ の族 θ^{(δ)}_{M_col,μ} へ、def_Lambda_delta_M の和を添字の和へ改めたのに合わせ、集合の上の和を添字の和に替え、写像 μ ↦ 2π(μ−δ)/M_col の単射性と集合の上の和の付け替えの段落を、θ^{(δ)}_{M_col,μ} の展開の 1 行に替えた。主張から集合 Θ への言及を外した（主張は不変）。",
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
          math(String.raw`Z_{\mathbb{C}} = \mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)`),
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
        ref("pauli_matrix_products"),
        " の Pauli 行列の成分より ",
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
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}^* = I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " である（",
        ref("def_identity_matrix"),
        " の成分 ",
        math(String.raw`\delta_{kl}`),
        " は実数で、",
        math(String.raw`\delta_{lk} = \delta_{kl}`),
        "）。",
        math(String.raw`A_1,\dots,A_{M_{\mathrm{col}}} \in \mathrm{Mat}(2,\mathbb{C})`),
        " と ",
        ref("def_kronecker"),
        " の ",
        math(String.raw`I = (i_1,\dots,i_{M_{\mathrm{col}}}),\ J = (j_1,\dots,j_{M_{\mathrm{col}}}) \in \mathcal{I}_{M_{\mathrm{col}}}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}\right)^*\right)_{\nu(I),\,\nu(J)}
&= \overline{\left(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}\right)_{\nu(J),\,\nu(I)}}
&&\left(\because\ \blkref{def_hermitian_positive_definite}\right)\\
&= \overline{\prod_{k=1}^{M_{\mathrm{col}}}(A_k)_{j_k i_k}}
&&\left(\because\ \blkref{def_kronecker}\text{ (2)}\right)\\
&= \prod_{k=1}^{M_{\mathrm{col}}}\overline{(A_k)_{j_k i_k}}
&&\left(\because\ \blkref{complex_conjugate_of_product}\text{ の反復適用}\right)\\
&= \prod_{k=1}^{M_{\mathrm{col}}}\left(A_k^*\right)_{i_k j_k}
&&\left(\because\ \blkref{def_hermitian_positive_definite}\text{ を各因子へ}\right)\\
&= \left(A_1^*\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}^*\right)_{\nu(I),\,\nu(J)}
&&\left(\because\ \blkref{def_kronecker}\text{ (2)}\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は全単射なので ",
        math(String.raw`\left(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}\right)^*
= A_1^*\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}^*`),
        " である。よって ",
        math(String.raw`a \in \{x,y,z\}`),
        "、",
        math(String.raw`k \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sigma_k^a\right)^*
&= \left(I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes\sigma^a\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}\right)^*
&&\left(\because\ \blkref{def_site_pauli_matrices}\right)\\
&= I_{\mathrm{Mat}(2,\mathbb{C})}^*\boxtimes\cdots\boxtimes\left(\sigma^a\right)^*\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}^*
&&\left(\because\ \text{直前の式}\right)\\
&= I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes\sigma^a\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}
&&\left(\because\ \left(\sigma^a\right)^* = \sigma^a\text{ と }I_{\mathrm{Mat}(2,\mathbb{C})}^* = I_{\mathrm{Mat}(2,\mathbb{C})}\right)\\
&= \sigma_k^a
&&\left(\because\ \blkref{def_site_pauli_matrices}\right)
\end{aligned}`,
      ),
      paragraph([
        ref("star_preserves_norm_and_limits"),
        " (1) の ",
        math(String.raw`(XW)^* = W^*X^*`),
        " と、相異なるサイトの因子が可換であること（",
        ref("distinct_site_pauli_matrices_commute"),
        "）から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_j^*
&= \left(\sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z\right)^*
   \quad (\because \blkref{def_jordan_wigner_Z_matrices}) \\
&= \left(\sigma_j^z\right)^*\left(\sigma_{j-1}^x\right)^*\cdots\left(\sigma_1^x\right)^*
   \quad (\because \blkref{star_preserves_norm_and_limits}\text{ (1) の }(XW)^* = W^*X^*\text{ の反復適用}) \\
&= \sigma_j^z\,\sigma_{j-1}^x\cdots\sigma_1^x
   \quad (\because \left(\sigma_k^a\right)^* = \sigma_k^a) \\
&= \sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z
   \quad (\because \blkref{distinct_site_pauli_matrices_commute}\text{ の反復適用}) \\
&= Z_j
   \quad (\because \blkref{def_jordan_wigner_Z_matrices})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_j`),
        " も、",
        ref("def_jordan_wigner_Y_matrices"),
        " の ",
        math(String.raw`Y_j = \sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^y`),
        " について同じ計算である（",
        math(String.raw`\sigma_j^z`),
        " を ",
        math(String.raw`\sigma_j^y`),
        " に替える）。",
      ]),
      paragraph([
        "(2) ",
        ref("conjugate_index_of_check_Z_Y"),
        " (2) より ",
        math(String.raw`\exp(-i(j_{\mathbb R}\tilde\theta_{M_{\mathrm{col}}+1-\mu})_{\mathbb C}) = \exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})`),
        " である（以下の ",
        math(String.raw`\exp(\pm ij\tilde\theta_\mu)`),
        " は ",
        math(String.raw`\exp(\pm i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})`),
        " の略記である）。",
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
   \quad (\because \blkref{def_half_integer_checkZ}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\overline{\exp(-ij\tilde\theta_\mu)}\;Z_j^*
   \quad (\because \blkref{star_preserves_norm_and_limits}\text{ (1) の }(\alpha A + \beta B)^* = \overline{\alpha}A^* + \overline{\beta}B^*\text{ の反復適用}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\exp(ij\tilde\theta_\mu)\,Z_j
   \quad (\because \text{(1) と } \tilde\theta_\mu \in \mathbb{R}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_{M_{\mathrm{col}}+1-\mu})\,Z_j
   \quad (\because \blkref{conjugate_index_of_check_Z_Y}\text{ (2)}) \\
&= \check{Z}_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \blkref{def_half_integer_checkZ})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\check{Y}_\mu`),
        " も、",
        ref("def_half_integer_checkY"),
        " について同じ計算である（",
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
   \quad \left(\because \blkref{relation_of_gamma_2_theta_tilde}\text{ (1) を }
   \overline{\gamma_2(-\tilde\theta_\mu)} = -\gamma_2(\tilde\theta_\mu)
   \text{ の形で使う}\right) \\
&= \frac{r}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(\tilde\theta_\mu)} \\
&= \frac{r}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\nu)}
   \quad (\because \blkref{periodicity_of_check_fermi}\text{ (3)}) \\
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
   \quad (\because \blkref{def_check_fermi}) \\
&= \overline{\alpha_\mu}\,\check{Z}_\mu^* + \overline{\beta}\,\check{Y}_\mu^*
   \quad (\because \blkref{star_preserves_norm_and_limits}\text{ (1) の }(\alpha A + \beta B)^* = \overline{\alpha}A^* + \overline{\beta}B^*) \\
&= \overline{\alpha_\mu}\,\check{Z}_\nu + \beta\,\check{Y}_\nu
   \quad (\because \text{(2) と } \beta \in \mathbb{R}) \\
&= -\alpha_\nu\check{Z}_\nu + \beta\check{Y}_\nu
   \quad \left(\because \overline{\alpha_\mu} = -\alpha_\nu\right) \\
&= \check\psi_\nu
   \quad (\because \blkref{def_check_fermi})
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
&&\left(\because\ \blkref{def_check_number_operator}\right)\\
&= \left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^*\left(\check\psi_\mu^\dagger\right)^*
&&\left(\because\ \blkref{star_preserves_norm_and_limits}\text{ (1) の }(XW)^*=W^*X^*\right)\\
&= \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}
&&\left(\because\ \text{(3) とその転置共役}\right)\\
&= \check{n}_\mu
&&\left(\because\ \blkref{def_check_number_operator}\right)
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
&&\left(\because\ \blkref{check_joint_eigenspace_decomposition}\right)\\
&= \left(R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}\right)^*\cdots\left(R_1^{(\epsilon_1)}\right)^*
&&\left(\because\ \blkref{star_preserves_norm_and_limits}\text{ (1) の }(XW)^*=W^*X^*\text{ の反復適用}\right)\\
&= R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}\cdots R_1^{(\epsilon_1)}
&&\left(\because\ \check n_\mu^*=\check n_\mu\text{、}I^*=I\text{ と、}\blkref{star_preserves_norm_and_limits}\text{ (1) の線型性による }(I-\check n_\mu)^*=I^*-\check n_\mu^*\right)\\
&= R_1^{(\epsilon_1)}\cdots R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}
&&\left(\because\ \text{因子の可換性。}\blkref{check_number_operators_commute}\text{ (2) の }\check n_\mu\check n_\nu=\check n_\nu\check n_\mu\text{ と、分配則による }(I-\check n_\mu)\check n_\nu=\check n_\nu(I-\check n_\mu)\text{ など}\right)\\
&= \check{Q}_\epsilon
&&\left(\because\ \blkref{check_joint_eigenspace_decomposition}\right)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " (1) の ",
        math(String.raw`\check{Q}_\epsilon^2 = \check{Q}_\epsilon`),
        " と合わせる。",
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " に対し ",
        math(String.raw`w := \check{Q}_\epsilon x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " とおき、その第 ",
        math(String.raw`k`),
        " 成分を ",
        math(String.raw`w_k \in \mathbb{C}`),
        " と書くと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*\check{Q}_\epsilon x
&=x^*\check{Q}_\epsilon^2 x
&&\left(\because\ \blkref{check_joint_eigenspace_decomposition}\text{ (1) の }\check{Q}_\epsilon=\check{Q}_\epsilon^2\right)\\
&=x^*\left(\check{Q}_\epsilon^*\check{Q}_\epsilon\right) x
&&\left(\because\ \check{Q}_\epsilon^*=\check{Q}_\epsilon\right)\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{l=1}^{2^{M_{\mathrm{col}}}}\overline{x_k}\left(\check{Q}_\epsilon^*\check{Q}_\epsilon\right)_{kl}x_l
&&\left(\because\ \blkref{def_conjugate_bilinear_value}\right)\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{l=1}^{2^{M_{\mathrm{col}}}}\overline{x_k}\left(\sum_{m=1}^{2^{M_{\mathrm{col}}}}\overline{\left(\check{Q}_\epsilon\right)_{mk}}\left(\check{Q}_\epsilon\right)_{ml}\right)x_l
&&\left(\because\ \blkref{mat_mult}\text{ と }\blkref{def_hermitian_positive_definite}\right)\\
&=\sum_{m=1}^{2^{M_{\mathrm{col}}}}\left(\sum_{k=1}^{2^{M_{\mathrm{col}}}}\overline{\left(\check{Q}_\epsilon\right)_{mk}}\,\overline{x_k}\right)\left(\sum_{l=1}^{2^{M_{\mathrm{col}}}}\left(\check{Q}_\epsilon\right)_{ml}x_l\right)
&&\left(\because\ \text{分配則と有限和の並べ替え（}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&=\sum_{m=1}^{2^{M_{\mathrm{col}}}}\left(\sum_{k=1}^{2^{M_{\mathrm{col}}}}\overline{\left(\check{Q}_\epsilon\right)_{mk}x_k}\right)\left(\sum_{l=1}^{2^{M_{\mathrm{col}}}}\left(\check{Q}_\epsilon\right)_{ml}x_l\right)
&&\left(\because\ \blkref{complex_conjugate_of_product}\text{ を各項へ}\right)\\
&=\sum_{m=1}^{2^{M_{\mathrm{col}}}}\overline{\left(\sum_{k=1}^{2^{M_{\mathrm{col}}}}\left(\check{Q}_\epsilon\right)_{mk}x_k\right)}\left(\sum_{l=1}^{2^{M_{\mathrm{col}}}}\left(\check{Q}_\epsilon\right)_{ml}x_l\right)
&&\left(\because\ \blkref{complex_conjugate_of_sum}\right)\\
&=\sum_{m=1}^{2^{M_{\mathrm{col}}}}\overline{w_m}\,w_m
&&\left(\because\ \blkref{mat_mult}\text{ の行列と数ベクトルの積と }w\text{ の定義}\right)\\
&=\sum_{m=1}^{2^{M_{\mathrm{col}}}}\left(|w_m|^2\right)_{\mathbb{C}}
&&\left(\because\ \blkref{complex_conjugate_times_self}\text{ を各項へ}\right)\\
&=\left(\sum_{m=1}^{2^{M_{\mathrm{col}}}}|w_m|^2\right)_{\mathbb{C}}
&&\left(\because\ \blkref{real_inclusion_preserves_finite_sum}\right)\\
&=\left(\left(\sqrt{\sum_{m=1}^{2^{M_{\mathrm{col}}}}|w_m|^2}^{\,(\mathbb{R}_{\ge0})}\right)^2\right)_{\mathbb{C}}
&&\left(\because\ \blkref{definition_of_sqrt_r_positive}\right)\\
&=\left(\left\|\check{Q}_\epsilon x\right\|^2\right)_{\mathbb{C}}
&&\left(\because\ \blkref{def_matrix_norm}\text{ と }w=\check{Q}_\epsilon x\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\left\|\check{Q}_\epsilon x\right\|^2 \in \mathbb{R}_{\geq 0}`),
        " である（",
        ref("def_matrix_norm"),
        " のノルムは ",
        math(String.raw`\mathbb{R}_{\geq 0}`),
        " の元で、実数の平方は非負）。主張の ",
        math(String.raw`x^*\check{Q}_\epsilon x = \left\|\check{Q}_\epsilon x\right\|^2 \geq 0`),
        " の右辺は、この実数を ",
        ref("inclusion_rr_to_cc"),
        " で ",
        math(String.raw`\mathbb{C}`),
        " に入れた値と、その実数についての不等式である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "c_+(M) ≤ Λ̌_max を示すのに必要なのは「Q̌_ε がエルミートな冪等行列であること」だけである。これがあれば x^*V^{(+)}x = Σ_ε Λ̌_ε ‖Q̌_ε x‖² と書けて、スペクトル定理（実対称行列の対角化可能性）を持ち出さずに Rayleigh 商の上限が押さえられる。011 章が「固有値の存在を使わない」方針を取っているのと整合する。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_04（(ψ̌_μ^†)^* = ψ̌_{M+1−μ}、ň_μ, Q̌_ε のエルミート性、残差 ≤ 1.2e-14）。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した（c_plus_equals_Lambda_half_integer の証明が (4) を引く）。",
        "2026-11-05: 全証明の SageMath 検算（sagemath/check/check_number_operator_is_hermitian/）を付けたときに根拠を直した（計算と主張は不変）。Pauli 行列の成分の出典を pauli_matrix_products に、(A_1⊠⋯⊠A_M)^* = A_1^*⊠⋯⊠A_M^* の出典を kronecker_product_rule (2)（I⊠⋯⊠I = I の主張）から def_kronecker (2) の成分の鎖に、(σ_k^a)^* = σ_k^a を def_site_pauli_matrices の鎖に、相異なるサイトの因子の可換性を kronecker_product_rule (1) から distinct_site_pauli_matrices_commute に、Z_j・Y_j の定義を def_transfer_matrix_symbols から def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices に、Ž_μ・Y̌_μ の定義を def_half_integer_modes（θ̃ の共役添字恒等式のラベル）から def_half_integer_checkZ・def_half_integer_checkY に、ň_μ の定義を def_check_fermi から def_check_number_operator に直した。(XW)^* = W^*X^* と転置共役の線型性を star_preserves_norm_and_limits (1) で、結びの鎖を、数ベクトルの共役転置（本文に定義が無い）を経ない成分の鎖に書き直した（def_conjugate_bilinear_value・mat_mult・complex_conjugate_of_product・complex_conjugate_of_sum・complex_conjugate_times_self・real_inclusion_preserves_finite_sum・definition_of_sqrt_r_positive・def_matrix_norm）。Q̌_ε の鎖の (I−ň_μ)^* と因子の可換性の根拠を足した。名前だけの根拠（\\text{…}）を \\blkref に直した。",
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
        ref("def_W_real"),
        " の ",
        math(String.raw`W_{\mathbb{R}}`),
        " と ",
        ref("def_epsilon_real"),
        " の ",
        math(String.raw`\varepsilon_{\mathbb{R}}`),
        " で書いた ",
        ref("def_sector_rayleigh_sup"),
        " の",
      ]),
      displayMath(
        String.raw`c_+(M_{\mathrm{col}}) = \sup\left\{\, x^\top W_{\mathbb{R}} x \ \middle|\
x \in \mathbb{R}^{2^{M_{\mathrm{col}}}},\ \varepsilon_{\mathbb{R}}x = x,\ \|x\| = 1 \,\right\}`,
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
        "準備 1（記号）。",
        math(String.raw`n := 2^{M_{\mathrm{col}}}`),
        " とおき、",
        ref("def_real_vector_inclusion"),
        " の ",
        math(String.raw`\iota^{n}_{\mathbb{R}\to\mathbb{C}} : \mathbb{R}^{n} \to \mathbb{C}^{n}`),
        " を ",
        math(String.raw`\iota^{n}`),
        " と略記する。",
        ref("def_W_real"),
        " より、各 ",
        math(String.raw`k, l \in \{1,\dots,n\}`),
        " について ",
        math(String.raw`\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}} = W_{kl}`),
        " である。",
        ref("def_sector_rayleigh_sup"),
        " の条件 ",
        math(String.raw`\varepsilon_{\mathbb{R}}x = x`),
        "（",
        ref("def_epsilon_real"),
        "）は、",
        ref("epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors"),
        " より ",
        math(String.raw`\iota^{n}(x) \in \mathcal{F}^{(+)}`),
        " と同値である。以下、",
        math(String.raw`\mathcal{R}_+`),
        " の条件はこの同値で ",
        math(String.raw`\iota^{n}(x) \in \mathcal{F}^{(+)}`),
        " と読み替えて使う。",
      ]),
      paragraph([
        "準備 2（実の二次形式と複素の二次形式の橋）。",
        math(String.raw`x \in \mathbb{R}^{n}`),
        "、",
        math(String.raw`u := \iota^{n}(x)`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(x^\top W_{\mathbb{R}}x\right)_{\mathbb{C}}
&= \Bigl(\sum_{k=1}^{n}\sum_{l=1}^{n}\left(x_k\,(W_{\mathbb{R}})_{kl}\right)x_l\Bigr)_{\mathbb{C}}
 &&\left(\because\ \blkref{def_real_bilinear_value}\ (n \to n,\ P \to W_{\mathbb{R}},\ y \to x)\right)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\left(\left(x_k\,(W_{\mathbb{R}})_{kl}\right)x_l\right)_{\mathbb{C}}
 &&\left(\because\ \blkref{real_inclusion_preserves_finite_sum}\ \text{を外と内の和へ}\right)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\left((x_k)_{\mathbb{C}}\,\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}\right)(x_l)_{\mathbb{C}}
 &&\left(\because\ \blkref{real_inclusion_preserves_product}\ \text{を二つの積へ}\right)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\left(\overline{(x_k)_{\mathbb{C}}}\,\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}\right)(x_l)_{\mathbb{C}}
 &&\left(\because\ \blkref{complex_conjugate_of_real_inclusion}\right)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\left(\overline{u_k}\,\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}\right)u_l
 &&\left(\because\ \blkref{def_real_vector_inclusion}\ (n \to n,\ x \to x)\ \text{と}\ u = \iota^{n}(x)\right)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\left(\overline{u_k}\,W_{kl}\right)u_l
 &&\left(\because\ \blkref{def_W_real}\ \text{の}\ \bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}} = W_{kl}\right)\\
&= u^*Wu
 &&\left(\because\ \blkref{def_conjugate_bilinear_value}\right)
\end{aligned}`,
      ),
      paragraph([
        "準備 3。",
        math(String.raw`u \in \mathbb{C}^{n}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " について（",
        math(String.raw`Au`),
        " は ",
        ref("mat_mult"),
        " の積、",
        math(String.raw`(Au)_k`),
        " はその第 ",
        math(String.raw`k`),
        " 成分）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u^*Au
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\left(\overline{u_k}\,A_{kl}\right)u_l
 &&\left(\because\ \blkref{def_conjugate_bilinear_value}\right)\\
&= \sum_{k=1}^{n}\sum_{l=1}^{n}\overline{u_k}\left(A_{kl}\,u_l\right)
 &&\left(\because\ \mathbb{C}\ \text{の積の結合則（}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= \sum_{k=1}^{n}\overline{u_k}\sum_{l=1}^{n}A_{kl}\,u_l
 &&\left(\because\ \mathbb{C}\ \text{の分配則（}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= \sum_{k=1}^{n}\overline{u_k}\,(Au)_k
 &&\left(\because\ \blkref{mat_mult}\right)
\end{aligned}`,
      ),
      paragraph([
        "準備 4。",
        math(String.raw`u \in \mathbb{C}^{n}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{k=1}^{n}\overline{u_k}\,u_k
&= \sum_{k=1}^{n}\left(|u_k|^2\right)_{\mathbb{C}}
 &&\left(\because\ \blkref{complex_conjugate_times_self}\right)\\
&= \Bigl(\sum_{k=1}^{n}|u_k|^2\Bigr)_{\mathbb{C}}
 &&\left(\because\ \blkref{real_inclusion_preserves_finite_sum}\right)\\
&= \left(\|u\|^2\right)_{\mathbb{C}}
 &&\left(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ y^2 = x\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`u = \iota^{n}(x)`),
        "（",
        math(String.raw`x \in \mathbb{R}^{n}`),
        "）なら",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|u\|^2
&= \sum_{k=1}^{n}\left|(x_k)_{\mathbb{C}}\right|^2
 &&\left(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ y^2 = x\right)\\
&= \sum_{k=1}^{n}|x_k|^2
 &&\left(\because\ \blkref{abs_basic_properties}\ \text{(6)}\right)\\
&= \|x\|^2
 &&\left(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ y^2 = x\right)
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "Step 0（",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上で ",
        math(String.raw`W`),
        " と ",
        math(String.raw`V^{(+)}`),
        " が一致すること）。",
        math(String.raw`y \in \mathcal{F}^{(+)}`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)}y
&= \left(\tfrac12\left(I + \varepsilon\right)\right)y
 &&\left(\because\ \blkref{def_epsilon_projectors}\right)\\
&= \tfrac12\left(\left(I + \varepsilon\right)y\right)
 &&\left(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\right)\\
&= \tfrac12\left(Iy + \varepsilon y\right)
 &&\left(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor}\right)\\
&= \tfrac12\left(y + \varepsilon y\right)
 &&\left(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\right)\\
&= \tfrac12\left(y + y\right)
 &&\left(\because\ y \in \mathcal{F}^{(+)}\ \text{より}\ \varepsilon y = y\ \text{（}\blkref{def_even_eigenvectors_of_epsilon}\text{）}\right)\\
&= y
 &&\left(\because\ \blkref{def_matrix_sum}\ \text{と}\ \blkref{def_matrix_scalar_multiple}\ \text{の成分で}\ \tfrac12(y_k + y_k) = y_k\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Wy
&= W\left(P^{(+)}y\right)
 &&\left(\because\ \text{直前の}\ P^{(+)}y = y\right)\\
&= \left(WP^{(+)}\right)y
 &&\left(\because\ \blkref{mat_mult_associative}\right)\\
&= \left(V^{(+)}P^{(+)}\right)y
 &&\left(\because\ \blkref{symmetrized_transfer_matrix_on_sectors}\right)\\
&= V^{(+)}\left(P^{(+)}y\right)
 &&\left(\because\ \blkref{mat_mult_associative}\right)\\
&= V^{(+)}y
 &&\left(\because\ \text{直前の}\ P^{(+)}y = y\right)
\end{aligned}
\qquad \left(y \in \mathcal{F}^{(+)}\right)`,
      ),
      paragraph([
        "Step 1（",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq \check\Lambda_{\max}`),
        "）。",
        math(String.raw`x \in \mathbb{R}^{n}`),
        "、",
        math(String.raw`\iota^{n}(x) \in \mathcal{F}^{(+)}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " とし、",
        math(String.raw`u := \iota^{n}(x)`),
        "、",
        math(String.raw`w_\epsilon := \check{Q}_\epsilon u`),
        "（",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        "）とおく。まず",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u
&= Iu
 &&\left(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\right)\\
&= \Bigl(\sum_{\epsilon}\check{Q}_\epsilon\Bigr)u
 &&\left(\because\ \blkref{check_joint_eigenspace_decomposition}\ \text{(2)}\right)\\
&= \sum_{\epsilon}\check{Q}_\epsilon u
 &&\left(\because\ \blkref{sum_over_binary_words_distributes_in_left_factor}\right)\\
&= \sum_{\epsilon}w_\epsilon
 &&\left(\because\ w_\epsilon\ \text{の置き方}\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}u
&= V^{(+)}\Bigl(\sum_{\epsilon}\check{Q}_\epsilon u\Bigr)
 &&\left(\because\ \text{直前の鎖の 3 行目}\right)\\
&= \sum_{\epsilon}V^{(+)}\left(\check{Q}_\epsilon u\right)
 &&\left(\because\ \blkref{sum_over_binary_words_distributes_in_right_factor}\right)\\
&= \sum_{\epsilon}\left(V^{(+)}\check{Q}_\epsilon\right)u
 &&\left(\because\ \blkref{mat_mult_associative}\right)\\
&= \sum_{\epsilon}\left(\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\check{Q}_\epsilon\right)u
 &&\left(\because\ \blkref{eigenvalues_of_V_plus}\ \text{(1)}\right)\\
&= \sum_{\epsilon}\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}w_\epsilon
 &&\left(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ \text{と}\ w_\epsilon\ \text{の置き方}\right)
\end{aligned}`,
      ),
      paragraph([
        "である（",
        math(String.raw`\sum_\epsilon`),
        " は ",
        ref("def_sum_over_binary_words"),
        " の和）。",
        ref("sum_over_binary_words_entrywise"),
        " より、",
        math(String.raw`u_k = \sum_\epsilon (w_\epsilon)_k`),
        "、",
        math(String.raw`(V^{(+)}u)_k = \sum_\epsilon(\check\Lambda_\epsilon)_{\mathbb{C}}(w_\epsilon)_k`),
        " である（後者は ",
        ref("def_matrix_scalar_multiple"),
        " も使う）。これらを使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(x^\top W_{\mathbb{R}}x\right)_{\mathbb{C}}
&= u^*Wu
 &&\left(\because\ \text{準備 2}\right)\\
&= \sum_{k=1}^{n}\overline{u_k}\,(Wu)_k
 &&\left(\because\ \text{準備 3}\right)\\
&= \sum_{k=1}^{n}\overline{u_k}\,\left(V^{(+)}u\right)_k
 &&\left(\because\ u \in \mathcal{F}^{(+)}\ \text{と Step 0}\right)\\
&= \sum_{k=1}^{n}\overline{u_k}\sum_{\epsilon}\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}(w_\epsilon)_k
 &&\left(\because\ \text{直前の成分の式}\right)\\
&= \sum_{k=1}^{n}\sum_{\epsilon}\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\left(\overline{u_k}\,(w_\epsilon)_k\right)
 &&\left(\because\ \mathbb{C}\ \text{の分配則・交換則・結合則（}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= \sum_{\epsilon}\sum_{k=1}^{n}\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\left(\overline{u_k}\,(w_\epsilon)_k\right)
 &&\left(\because\ \text{有限個の複素数の和の順序の入れ替え（}\mathbb{C}\ \text{の加法の結合則・交換則。}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= \sum_{\epsilon}\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\sum_{k=1}^{n}\overline{u_k}\,(w_\epsilon)_k
 &&\left(\because\ \mathbb{C}\ \text{の分配則（}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= \sum_{\epsilon}\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\,u^*\check{Q}_\epsilon u
 &&\left(\because\ \text{準備 3（}A \to \check{Q}_\epsilon\text{）と}\ w_\epsilon = \check{Q}_\epsilon u\right)\\
&= \sum_{\epsilon}\left(\check\Lambda_\epsilon\right)_{\mathbb{C}}\left(\|w_\epsilon\|^2\right)_{\mathbb{C}}
 &&\left(\because\ \blkref{check_number_operator_is_hermitian}\ \text{の (4) に続く式}\right)\\
&= \sum_{\epsilon}\left(\check\Lambda_\epsilon\,\|w_\epsilon\|^2\right)_{\mathbb{C}}
 &&\left(\because\ \blkref{real_inclusion_preserves_product}\right)\\
&= \Bigl(\sum_{\epsilon}\check\Lambda_\epsilon\,\|w_\epsilon\|^2\Bigr)_{\mathbb{C}}
 &&\left(\because\ \blkref{real_inclusion_preserves_sum_over_binary_words}\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、同じく",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\sum_{\epsilon}\|w_\epsilon\|^2\Bigr)_{\mathbb{C}}
&= \sum_{\epsilon}\left(\|w_\epsilon\|^2\right)_{\mathbb{C}}
 &&\left(\because\ \blkref{real_inclusion_preserves_sum_over_binary_words}\right)\\
&= \sum_{\epsilon}u^*\check{Q}_\epsilon u
 &&\left(\because\ \blkref{check_number_operator_is_hermitian}\ \text{の (4) に続く式}\right)\\
&= \sum_{\epsilon}\sum_{k=1}^{n}\overline{u_k}\,(w_\epsilon)_k
 &&\left(\because\ \text{準備 3（}A \to \check{Q}_\epsilon\text{）と}\ w_\epsilon = \check{Q}_\epsilon u\right)\\
&= \sum_{k=1}^{n}\sum_{\epsilon}\overline{u_k}\,(w_\epsilon)_k
 &&\left(\because\ \text{有限個の複素数の和の順序の入れ替え（}\mathbb{C}\ \text{の加法の結合則・交換則。}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= \sum_{k=1}^{n}\overline{u_k}\sum_{\epsilon}(w_\epsilon)_k
 &&\left(\because\ \mathbb{C}\ \text{の分配則（}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= \sum_{k=1}^{n}\overline{u_k}\,u_k
 &&\left(\because\ u_k = \textstyle\sum_\epsilon (w_\epsilon)_k\right)\\
&= \left(\|u\|^2\right)_{\mathbb{C}}
 &&\left(\because\ \text{準備 4}\right)\\
&= \left(\|x\|^2\right)_{\mathbb{C}}
 &&\left(\because\ \text{準備 4 の}\ \|\iota^{n}(x)\|^2 = \|x\|^2\right)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to x^\top W_{\mathbb{R}}x,\ b \to \sum_\epsilon\check\Lambda_\epsilon\|w_\epsilon\|^2`),
        " と ",
        math(String.raw`a \to \sum_\epsilon\|w_\epsilon\|^2,\ b \to \|x\|^2`),
        "）より、二つの鎖の両端は ",
        math(String.raw`\mathbb{R}`),
        " の等式 ",
        math(String.raw`x^\top W_{\mathbb{R}}x = \sum_\epsilon\check\Lambda_\epsilon\|w_\epsilon\|^2`),
        "、",
        math(String.raw`\sum_\epsilon\|w_\epsilon\|^2 = \|x\|^2`),
        " を与える。",
        ref("eigenvalues_of_V_plus"),
        " (2) より ",
        math(String.raw`\check\Lambda_\epsilon \leq \check\Lambda_{\max}`),
        " であり、",
        math(String.raw`\|w_\epsilon\|^2 \geq 0`),
        " なので、各 ",
        math(String.raw`\epsilon`),
        " について ",
        math(String.raw`\check\Lambda_\epsilon\|w_\epsilon\|^2 \leq \check\Lambda_{\max}\|w_\epsilon\|^2`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top W_{\mathbb{R}}x
&= \sum_{\epsilon}\check\Lambda_\epsilon\,\|w_\epsilon\|^2
 &&\left(\because\ \text{直前の}\ \mathbb{R}\ \text{の等式}\right)\\
&\leq \sum_{\epsilon}\check\Lambda_{\max}\,\|w_\epsilon\|^2
 &&\left(\because\ \text{各項の不等式を}\ \blkref{def_sum_over_binary_words_of_real_numbers}\ \text{の和で足し合わせる}\right)\\
&= \check\Lambda_{\max}\sum_{\epsilon}\|w_\epsilon\|^2
 &&\left(\because\ \mathbb{R}\ \text{の分配則を}\ \blkref{def_sum_over_binary_words_of_real_numbers}\ \text{の各段の和へ}\right)\\
&= \check\Lambda_{\max}\,\|x\|^2
 &&\left(\because\ \text{直前の}\ \mathbb{R}\ \text{の等式}\right)\\
&= \check\Lambda_{\max}
 &&\left(\because\ \|x\| = 1\right)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`x`),
        " は任意だったので ",
        math(String.raw`\check\Lambda_{\max}`),
        " は ",
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}_+`),
        " の上界であり、上限は最小の上界なので ",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq \check\Lambda_{\max}`),
        " である。",
      ]),
      paragraph([
        "Step 2（実の最大固有ベクトルの存在）。",
        ref("check_joint_eigenspace_decomposition"),
        " (4) より ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " は 1 次元なので、生成元 ",
        math(String.raw`q \neq 0`),
        " を取ると ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)} = \mathbb{C}q`),
        " である。",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (3) より ",
        math(String.raw`V^{(+)}q = \left(\check\Lambda_{\max}\right)_{\mathbb{C}}q`),
        "、",
        ref("max_eigenvector_in_even_sector"),
        " (4) より ",
        math(String.raw`q \in \mathcal{F}^{(+)}`),
        " なので、Step 0 より ",
        math(String.raw`Wq = V^{(+)}q = \left(\check\Lambda_{\max}\right)_{\mathbb{C}}q`),
        "、",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon q = q`),
        " である。",
        math(String.raw`\overline{q} := \left(\overline{q_1},\dots,\overline{q_n}\right) \in \mathbb{C}^{n}`),
        " とおく。各 ",
        math(String.raw`k`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(W\overline{q}\right)_k
&= \sum_{l=1}^{n}W_{kl}\,\overline{q_l}
 &&\left(\because\ \blkref{mat_mult}\right)\\
&= \sum_{l=1}^{n}\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}\,\overline{q_l}
 &&\left(\because\ \blkref{def_W_real}\right)\\
&= \sum_{l=1}^{n}\overline{\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}}\,\overline{q_l}
 &&\left(\because\ \blkref{complex_conjugate_of_real_inclusion}\right)\\
&= \sum_{l=1}^{n}\overline{W_{kl}}\,\overline{q_l}
 &&\left(\because\ \blkref{def_W_real}\right)\\
&= \sum_{l=1}^{n}\overline{W_{kl}\,q_l}
 &&\left(\because\ \blkref{complex_conjugate_of_product}\right)\\
&= \overline{\sum_{l=1}^{n}W_{kl}\,q_l}
 &&\left(\because\ \blkref{complex_conjugate_of_sum}\ \text{を左から順の各和へ}\right)\\
&= \overline{(Wq)_k}
 &&\left(\because\ \blkref{mat_mult}\right)\\
&= \overline{\left(\check\Lambda_{\max}\right)_{\mathbb{C}}\,q_k}
 &&\left(\because\ Wq = \left(\check\Lambda_{\max}\right)_{\mathbb{C}}q\ \text{と}\ \blkref{def_matrix_scalar_multiple}\right)\\
&= \overline{\left(\check\Lambda_{\max}\right)_{\mathbb{C}}}\;\overline{q_k}
 &&\left(\because\ \blkref{complex_conjugate_of_product}\right)\\
&= \left(\check\Lambda_{\max}\right)_{\mathbb{C}}\,\overline{q_k}
 &&\left(\because\ \blkref{complex_conjugate_of_real_inclusion}\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("def_epsilon_real"),
        " より各 ",
        math(String.raw`k, l`),
        " について ",
        math(String.raw`\varepsilon_{kl} = \bigl((\varepsilon_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}`),
        " なので、同じ鎖（",
        math(String.raw`W \to \varepsilon`),
        "、",
        math(String.raw`W_{\mathbb{R}} \to \varepsilon_{\mathbb{R}}`),
        "、",
        ref("def_W_real"),
        " ",
        math(String.raw`\to`),
        " ",
        ref("def_epsilon_real"),
        "、",
        math(String.raw`\left(\check\Lambda_{\max}\right)_{\mathbb{C}} \to 1_{\mathbb{C}}`),
        "。",
        math(String.raw`\varepsilon q = q = 1_{\mathbb{C}}q`),
        " は ",
        ref("scalar_multiple_by_one"),
        "、",
        math(String.raw`1_{\mathbb{C}}`),
        " が共役で動かないことは ",
        ref("complex_conjugate_of_real_inclusion"),
        "）で ",
        math(String.raw`(\varepsilon\overline{q})_k = \overline{q_k}`),
        " である。よって ",
        math(String.raw`W\overline{q} = \left(\check\Lambda_{\max}\right)_{\mathbb{C}}\overline{q}`),
        "、",
        math(String.raw`\overline{q} \in \mathcal{F}^{(+)}`),
        " であり、Step 0 より ",
        math(String.raw`V^{(+)}\overline{q} = W\overline{q} = \left(\check\Lambda_{\max}\right)_{\mathbb{C}}\overline{q}`),
        "。",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (3) より ",
        math(String.raw`\overline{q} \in \mathrm{im}\,\check{Q}_{(1,\dots,1)} = \mathbb{C}q`),
        " なので、ある ",
        math(String.raw`z \in \mathbb{C}`),
        " で ",
        math(String.raw`\overline{q} = zq`),
        " である。",
      ]),
      paragraph([
        math(String.raw`i := (0,1) \in \mathbb{C}`),
        " とし、",
        math(String.raw`p := q + \overline{q}`),
        "、",
        math(String.raw`p' := i\left(q - \overline{q}\right)`),
        " とおく（和・差・スカラー倍は ",
        ref("def_matrix_sum"),
        "・",
        ref("def_matrix_difference"),
        "・",
        ref("def_matrix_scalar_multiple"),
        "）。",
        ref("def_complex_conjugate"),
        " より ",
        math(String.raw`\overline{\overline{c}} = c`),
        "（",
        math(String.raw`c \in \mathbb{C}`),
        "）、",
        math(String.raw`\overline{i} = (0,-1) = -i`),
        " である。各 ",
        math(String.raw`k`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\overline{p_k}
&= \overline{q_k + \overline{q_k}}
 &&\left(\because\ p\ \text{の置き方}\right)\\
&= \overline{q_k} + \overline{\overline{q_k}}
 &&\left(\because\ \blkref{complex_conjugate_of_sum}\right)\\
&= \overline{q_k} + q_k
 &&\left(\because\ \overline{\overline{c}} = c\right)\\
&= p_k
 &&\left(\because\ \mathbb{C}\ \text{の加法の交換則（}\blkref{complex_numbers_form_a_field}\text{）}\right)
\end{aligned}
\qquad
\begin{aligned}
\overline{p'_k}
&= \overline{i\left(q_k - \overline{q_k}\right)}
 &&\left(\because\ p'\ \text{の置き方}\right)\\
&= \overline{i}\;\overline{q_k - \overline{q_k}}
 &&\left(\because\ \blkref{complex_conjugate_of_product}\right)\\
&= (-i)\;\overline{q_k - \overline{q_k}}
 &&\left(\because\ \overline{i} = -i\right)\\
&= (-i)\left(\overline{q_k} - \overline{\overline{q_k}}\right)
 &&\left(\because\ \blkref{complex_conjugate_of_difference}\right)\\
&= (-i)\left(\overline{q_k} - q_k\right)
 &&\left(\because\ \overline{\overline{c}} = c\right)\\
&= i\left(q_k - \overline{q_k}\right)
 &&\left(\because\ \mathbb{C}\ \text{の分配則と符号（}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= p'_k
 &&\left(\because\ p'\ \text{の置き方}\right)
\end{aligned}`,
      ),
      paragraph([
        "である。また ",
        math(String.raw`\overline{q} = zq`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
p &= q + zq
 &&\left(\because\ \overline{q} = zq\right)\\
&= (1_{\mathbb{C}} + z)q
 &&\left(\because\ \blkref{scalar_multiple_by_one}\ \text{と}\ \blkref{def_matrix_sum}\ \text{・}\ \blkref{def_matrix_scalar_multiple}\ \text{の成分での分配則}\right)\\
p' &= i\left(q - zq\right)
 &&\left(\because\ \overline{q} = zq\right)\\
&= i\left((1_{\mathbb{C}} - z)q\right)
 &&\left(\because\ \blkref{scalar_multiple_by_one}\ \text{と}\ \blkref{def_matrix_difference}\ \text{・}\ \blkref{def_matrix_scalar_multiple}\ \text{の成分での分配則}\right)\\
&= \left(i(1_{\mathbb{C}} - z)\right)q
 &&\left(\because\ \blkref{scalar_multiple_is_associative}\right)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`1_{\mathbb{C}} + z = 0`),
        " と ",
        math(String.raw`i(1_{\mathbb{C}} - z) = 0`),
        " が同時に成り立つと、",
        math(String.raw`i \neq 0`),
        " なので ",
        math(String.raw`i^{-1}`),
        " を掛けて ",
        math(String.raw`z = -1_{\mathbb{C}}`),
        " かつ ",
        math(String.raw`z = 1_{\mathbb{C}}`),
        " となり矛盾する。よって ",
        math(String.raw`1_{\mathbb{C}} + z`),
        " と ",
        math(String.raw`i(1_{\mathbb{C}} - z)`),
        " のうち 0 でない方を ",
        math(String.raw`c`),
        " とし、対応する ",
        math(String.raw`p`),
        " または ",
        math(String.raw`p'`),
        " を ",
        math(String.raw`v`),
        " とする（",
        math(String.raw`v = cq`),
        "）。",
        math(String.raw`q_{k_0} \neq 0`),
        " なる ",
        math(String.raw`k_0`),
        " を取ると、",
        math(String.raw`v_{k_0} = 0`),
        " なら ",
        math(String.raw`q_{k_0} = c^{-1}(c\,q_{k_0}) = 0`),
        "（",
        ref("complex_numbers_form_a_field"),
        " の逆元）となるので ",
        math(String.raw`v_{k_0} \neq 0`),
        "、すなわち ",
        math(String.raw`v \neq 0`),
        " である。上の二つの鎖より各 ",
        math(String.raw`k`),
        " で ",
        math(String.raw`\overline{v_k} = v_k`),
        " である。",
        math(String.raw`v_k = (a_k, b_k)`),
        "（",
        ref("definition_of_cc"),
        "）とすると ",
        ref("def_complex_conjugate"),
        " より ",
        math(String.raw`(a_k, -b_k) = (a_k, b_k)`),
        "、よって ",
        math(String.raw`b_k = 0`),
        "、",
        math(String.raw`v_k = (a_k, 0) = (a_k)_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）である。",
        math(String.raw`r := (a_1,\dots,a_n) \in \mathbb{R}^{n}`),
        " とおくと ",
        math(String.raw`\iota^{n}(r) = v \neq 0`),
        " なので ",
        math(String.raw`r \neq 0`),
        "、すなわち ",
        math(String.raw`a_{k_1} \neq 0`),
        " なる ",
        math(String.raw`k_1`),
        " がある。",
        ref("def_matrix_norm"),
        " と ",
        ref("definition_of_sqrt_r_positive"),
        " の ",
        math(String.raw`y^2 = x`),
        " より ",
        math(String.raw`\|r\|^2 = \sum_k |a_k|^2`),
        "、",
        ref("finite_sum_of_nonnegative_reals_is_at_least_each_term"),
        " より ",
        math(String.raw`\|r\|^2 \geq |a_{k_1}|^2 > 0`),
        "、よって ",
        math(String.raw`\|r\| > 0`),
        " である。",
        math(String.raw`x_0 := \left(a_1/\|r\|,\dots,a_n/\|r\|\right) \in \mathbb{R}^{n}`),
        " とおくと、",
        ref("def_matrix_norm"),
        " と ",
        ref("definition_of_sqrt_r_positive"),
        " の ",
        math(String.raw`y^2 = x`),
        " より ",
        math(String.raw`\|x_0\|^2 = \sum_k |a_k|^2/\|r\|^2 = \|r\|^2/\|r\|^2 = 1`),
        " であり、",
        ref("real_inclusion_preserves_product"),
        " より ",
        math(String.raw`\iota^{n}(x_0) = \left(1/\|r\|\right)_{\mathbb{C}}v
= \left(\left(1/\|r\|\right)_{\mathbb{C}}c\right)q \in \mathbb{C}q`),
        "（",
        ref("scalar_multiple_is_associative"),
        "）である。",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`c_+(M_{\mathrm{col}}) \geq \check\Lambda_{\max}`),
        "）。",
        math(String.raw`u_0 := \iota^{n}(x_0)`),
        " とおく。",
        math(String.raw`u_0 \in \mathbb{C}q = \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " なので ",
        ref("max_eigenvector_in_even_sector"),
        " (4) より ",
        math(String.raw`u_0 \in \mathcal{F}^{(+)}`),
        "、",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (3) より ",
        math(String.raw`V^{(+)}u_0 = \left(\check\Lambda_{\max}\right)_{\mathbb{C}}u_0`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(x_0^\top W_{\mathbb{R}}x_0\right)_{\mathbb{C}}
&= u_0^*Wu_0
 &&\left(\because\ \text{準備 2}\right)\\
&= \sum_{k=1}^{n}\overline{(u_0)_k}\,(Wu_0)_k
 &&\left(\because\ \text{準備 3}\right)\\
&= \sum_{k=1}^{n}\overline{(u_0)_k}\,\left(V^{(+)}u_0\right)_k
 &&\left(\because\ u_0 \in \mathcal{F}^{(+)}\ \text{と Step 0}\right)\\
&= \sum_{k=1}^{n}\overline{(u_0)_k}\left(\left(\check\Lambda_{\max}\right)_{\mathbb{C}}(u_0)_k\right)
 &&\left(\because\ V^{(+)}u_0 = \left(\check\Lambda_{\max}\right)_{\mathbb{C}}u_0\ \text{と}\ \blkref{def_matrix_scalar_multiple}\right)\\
&= \left(\check\Lambda_{\max}\right)_{\mathbb{C}}\sum_{k=1}^{n}\overline{(u_0)_k}\,(u_0)_k
 &&\left(\because\ \mathbb{C}\ \text{の交換則・結合則・分配則（}\blkref{complex_numbers_form_a_field}\text{）}\right)\\
&= \left(\check\Lambda_{\max}\right)_{\mathbb{C}}\left(\|x_0\|^2\right)_{\mathbb{C}}
 &&\left(\because\ \text{準備 4（}u_0 = \iota^{n}(x_0)\text{）}\right)\\
&= \left(\check\Lambda_{\max}\,\|x_0\|^2\right)_{\mathbb{C}}
 &&\left(\because\ \blkref{real_inclusion_preserves_product}\right)\\
&= \left(\check\Lambda_{\max}\right)_{\mathbb{C}}
 &&\left(\because\ \|x_0\| = 1\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to x_0^\top W_{\mathbb{R}}x_0,\ b \to \check\Lambda_{\max}`),
        "）より ",
        math(String.raw`x_0^\top W_{\mathbb{R}}x_0 = \check\Lambda_{\max}`),
        " である。",
        math(String.raw`x_0 \in \mathbb{R}^{n}`),
        "、",
        math(String.raw`\iota^{n}(x_0) \in \mathcal{F}^{(+)}`),
        "、",
        math(String.raw`\|x_0\| = 1`),
        " なので ",
        math(String.raw`\check\Lambda_{\max} \in \mathcal{R}_+`),
        " であり、上限は上界なので ",
        math(String.raw`\check\Lambda_{\max} \leq c_+(M_{\mathrm{col}})`),
        " である。",
      ]),
      paragraph([
        "結び。",
        ref("def_Theta_delta_M"),
        " の ",
        math(String.raw`\delta = \tfrac12`),
        " と ",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " はどちらも ",
        math(String.raw`2\pi\left(\mu_{\mathbb{R}} - \tfrac12\right)/(M_{\mathrm{col}})_{\mathbb{R}}`),
        " なので ",
        math(String.raw`\theta^{(1/2)}_{M_{\mathrm{col}},\mu} = \tilde\theta_\mu`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_+(M_{\mathrm{col}})
&= \check\Lambda_{\max}
 &&\left(\because\ \text{Step 1 と Step 3（}\mathbb{R}\ \text{の順序の反対称律）}\right)\\
&= \Lambda^{(1/2)}_{M_{\mathrm{col}}}
 &&\left(\because\ \blkref{max_eigenvalue_of_V_plus_simple}\ \text{(1)}\right)\\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
 \exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma\bigl(\theta^{(1/2)}_{M_{\mathrm{col}},\mu}\bigr)\right)
 &&\left(\because\ \blkref{def_Lambda_delta_M}\ \text{の}\ \delta = \tfrac12\right)\\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
 \exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\right)
 &&\left(\because\ \theta^{(1/2)}_{M_{\mathrm{col}},\mu} = \tilde\theta_\mu\right)
\end{aligned}`,
      ),
      paragraph([
        "であり、上限は ",
        math(String.raw`x_0`),
        " で達成される。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "分割前の上限のセクター分解の注記が「c_+(M) に対応する V^{(+)} の固有値は本文では未確立」としていた点が、ここで解消される。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_04（P^{(+)}WP^{(+)} を F^{(+)} の実基底へ制限して最大固有値を直接求め、Λ^{(1/2)}_M と比較。相対差 ≤ 2e-14）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-10-31: 章立ての組み直しで、M→∞ の極限と閉形式の章へ移した。証明の式の根拠欄でラベルを文字として書いていた箇所（check_joint_eigenspace_decomposition・eigenvalues_of_V_plus・check_number_operator_is_hermitian）を、ブロックへの参照に直した。数学の中身は変えていない。",
        "2026-11-05: SageMath の検算（sagemath/check/c_plus_equals_Lambda_half_integer/）を付けるにあたり、主張は変えずに証明を書き直した。旧い証明は ℝ の値 x^⊤Wx と ℂ の値 x^*V^{(+)}x を「x^⊤ = x^*」で等号に結んでいた（def_real_bilinear_value・def_conjugate_bilinear_value はどちらも数ベクトルと行列の積としては読まない記号）。ℝ^n → ℂ^n の包含 ι^n と W の実成分の行列 W_ℝ に名前を付け、(x^⊤W_ℝx)_ℂ = ι^n(x)^*Wι^n(x) の鎖を準備に置き、Step 1・Step 3 を ℂ の鎖と (·)_ℂ の単射性で ℝ へ戻す形にした。Step 1 の一行で三つの操作をしていた行を分け、Step 0 の P^{(+)}x の行を分けた。Step 2 の V^{(+)} の成分が実であることを散文（W_is_real_symmetric_positive_definite の Step 2 と同じ議論）で示していた段を、既にある主張 W_is_real_symmetric_positive_definite（W の成分は実）と epsilon_is_real_symmetric（ε の成分は実）と Step 0 から conj(q) が同じ固有空間に入ることを示す成分の鎖に替えた（V^{(+)} の成分が実であることは使わない）。p・p' の段を成分の鎖にし、複素共役で動かない複素数が (a)_ℂ であることを def_complex_conjugate から書いた。最後に c_+ から閉形式までの鎖を置き、θ^{(1/2)}_{M,μ} = θ̃_μ を書いた。計算の誤りは無かった。",
        "数値検証の場所: 上の 053_claim_even_sector_closing/check_04 に加え、証明の行と対応する検算は sagemath/check/c_plus_equals_Lambda_half_integer/ にある。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: def_sector_rayleigh_sup の 𝓡_+ の条件を x ∈ ℝ^{2^{M_col}}、ε_ℝx = x に述べ直したのに合わせ、主張の集合の条件を同じ形にし、準備 1 の「x ∈ 𝓕^{(+)} ∩ ℝ^n を ι^n(x) ∈ 𝓕^{(+)} と読む」を、epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors による同値の読み替えにした。x^⊤Wx を W_ℝ で書き直すこと、準備 1 の ι^n を def_real_vector_inclusion への参照に替えることは残っている。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 主張の x^⊤Wx を def_W_real の W_ℝ による x^⊤W_ℝx に直した（def_sector_rayleigh_sup と同じ式。値は不変）。準備 1 で局所に置いていた写像 ι^n と行列 W_ℝ := (w_kl) を、def_real_vector_inclusion の ι^n_{ℝ→ℂ}（略記 ι^n）と def_W_real の W_ℝ への参照に替え、「(·)_ℂ の単射性」と呼んでいた事実を inclusion_rr_to_cc_is_injective への参照に替えた。準備 2 の 5 行目（u と W_kl の二つの書き換えを 1 行でしていた）と、Step 2 の (Wq̄)_k の鎖の 2 行目（W_kl = (w_kl)_ℂ と共役の 2 段を 1 行でしていた）を一ステップ一定理に分けた。ε の成分の実性は epsilon_is_real_symmetric の e_kl から def_epsilon_real の ε_ℝ に替えた。",
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
        " の単位ベクトル（",
        math(String.raw`1/\|v\|\in\mathbb{R}\subset\mathbb{C}`),
        " なので、",
        ref("even_eigenspace_is_complex_subspace"),
        " の複素スカラー倍で閉じることから ",
        math(String.raw`\hat{v}\in\mathcal{F}^{(+)}`),
        "）なので ",
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
        "まず任意の ", math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " について、", ref("limit_of_log_Z_in_N_row"), " により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lim_{N_{\mathrm{row}}\to\infty}
\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2)
&=\frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})
&&\bigl(\because\ \blkref{limit_of_log_Z_in_N_row}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "次に ", ref("c_between_Lambda_half_and_twice_Lambda_half"),
        " の両側評価を読む。",
      ]),
      displayMath(
        String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}}
\leq c(M_{\mathrm{col}})
\leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}
\qquad\bigl(\because\ \blkref{c_between_Lambda_half_and_twice_Lambda_half}\bigr)`,
      ),
      paragraph([
        "三つの量は正の実数である。実対数の単調性と正の整数 ",
        math(String.raw`M_{\mathrm{col}}`), " で割る操作から",
      ]),
      displayMath(
        String.raw`\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}}
\leq\frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})
\leq\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}}
+\frac{\log 2}{M_{\mathrm{col}}}
\qquad\bigl(\because\ \text{実対数の単調性と積公式、}M_{\mathrm{col}}>0\bigr)`,
      ),
      paragraph([
        "ここで ", math(String.raw`(\log 2)/M_{\mathrm{col}}\to0`),
        " である。", ref("onsager_free_energy_expression"),
        " を ", math(String.raw`\delta=\tfrac12`), " として使い、挟み撃ちすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lim_{M_{\mathrm{col}}\to\infty}\lim_{N_{\mathrm{row}}\to\infty}
\frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z(K_1,K_2)
&=\lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})
&&\bigl(\because\ \blkref{limit_of_log_Z_in_N_row}\bigr)\\
&=\lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}}
&&\bigl(\because\ \text{直前の両側評価と }(\log2)/M_{\mathrm{col}}\to0\bigr)\\
&=\frac12\log\left(2\sinh 2K_2\right)
+\frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta
&&\bigl(\because\ \blkref{onsager_free_energy_expression}\text{ に }\delta=\tfrac12\text{ を代入}\bigr).
\end{aligned}`,
      ),
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
          math(String.raw`\text{(1)}\quad c_+(M_{\mathrm{col}}) = \sup\left\{\, x^\top W x \ \middle|\ x \in \mathbb{R}^{2^{M_{\mathrm{col}}}},\ \varepsilon_{\mathbb{R}}x = x,\ \|x\| = 1 \,\right\} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
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
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: def_sector_rayleigh_sup の 𝓡_+ の条件を x ∈ ℝ^{2^{M_col}}、ε_ℝx = x に述べ直したのに合わせ、(1) の集合の条件を同じ形にした。",
      ],
    },
  },
]);
