# SageMath Check: 050_claim_even_sector_eigenvalues

## 対象

**対象ラベル**: `eigenvalues_of_V_plus` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`、`eigenvalue_problem_diagonalization_and_exponential_form.ts`（`def_check_number_operator`）
- 併せて検証（この章の全ブロック）:
  - `def_check_number_operator`（数演算子 `ň_μ := ψ̌_μ^† ψ̌_{1−μ}`）
  - `check_number_operator_idempotent`（`ň_μ² = ň_μ`。(1)(2) の反交換子の鎖は check_28、(3) の鎖は check_23）
  - `check_number_operators_commute`（`ň_μ ň_ν = ň_ν ň_μ`。Step 1 の反交換子の鎖は check_29、Step 2・Step 3 の鎖は check_23）
  - `trace_of_check_number_operator_product`（`tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M−k}`）
  - `check_joint_eigenspace_decomposition`（`Q̌_ε`、**各同時固有空間は 1 次元**、`2^M` 個。Step 0・Step 3 の分配と単位行列の鎖は check_24、Step 0 の冒頭の `ň_μň_μ = ň_μ`・`ň − ň = O` の行・和 `R^{(1)} + R^{(0)} = I` の鎖は check_30、Step 3 の二つの場合の末尾（`1_ℂ R^{(1)}`・`0_ℂ R^{(0)}`）は check_31、Step 2 の鎖（`finite_product_of_identity_matrices` の行）は check_32、和を `def_sum_over_binary_words` どおりに組んだ Step 2 の鎖（`expansion_of_finite_product_of_two_term_sums` の行）は check_33、Step 0 の異なる添字の因子の可換性の鎖・Step 1 の `Q̌_ε^2` の鎖（`product_of_two_finite_products_of_matrices` の行）・Step 3 の `Q̌_εň_ν` の鎖（`matrix_commuting_with_each_factor_commutes_with_finite_product` の行）は check_34、Step 1 の `ε ≠ ε'` の鎖と Step 3 の `ň_νQ̌_ε` の鎖（`moving_one_factor_of_finite_product_to_the_end` の行）は check_35、Step 4 の `tr(Q̌_ε)` の鎖（`def_power_of_complex_number` の行）と Step 5 の数ベクトルの二つの鎖は check_36、Step 5 の直和の鎖の 1 行目（`sum_over_binary_words_with_one_nonzero_term` の行）とその前提の鎖は check_joint_eigenspace_step5_direct_sum_first_line）
  - `eigenvalues_of_check_Vprime`（`V̌' Q̌_ε = e^{ǧ(ε)} Q̌_ε`。Step 1 の左から掛ける形の 14 行の鎖は check_eigenvalues_of_check_Vprime_step1_left_chain、右から掛ける形の 14 行の鎖は check_eigenvalues_of_check_Vprime_step1_right_chain、Step 3・Step 3' の部分和の 8 行の鎖（添字 0 からの和をずらす 2 つの定義の行は、同じ項の並びから組むので構成上一致し、検算としては確かめていない）は check_eigenvalues_of_check_Vprime_step3_partial_sum_chains、Step 2・Step 3' の帰納法と Step 4 の `Q̌_εy = y` の鎖は check_25、Step 4 の後半の 5 行の鎖は check_eigenvalues_of_check_Vprime_step4_eigenvector_chain）
  - `trace_of_check_Vprime`（`tr(V̌') = tr((V̌')^{−1}) = Π_μ 2cosh(γ(θ~_μ)/2) > 0`）
  - `V_plus_is_positive_definite`（`V^{(+)}` は正定値）
  - `V_plus_is_invertible`（明示した候補が `V^{(+)}` の右逆かつ左逆）
  - `V_plus_inverse_is_positive_definite`（`(V^{(+)})^{-1}` の正定値性。下の注を見よ）
  - `trace_V_plus_is_positive`（`tr(V^{(+)})` の正値性）
  - `V_plus_inverse_positive_and_trace_positivity`（`tr((V^{(+)})^{-1})` の正値性。下の注を見よ）
- 注: `V_plus_inverse_is_positive_definite` と `V_plus_inverse_positive_and_trace_positivity` は、どの章のゴールの主張からも
  使われないので、2026-10-31 に本文から参照用ノート `structured-latex/notes/claims_unused_by_chapter_goals_not_adopted.ts`
  へ退避した。それらの検算（check_05 の一部と check_V_plus_inverse_positive_definite）は記録として残す。
  - `constant_c_value_even_sector`（**`c = (2 sinh 2K_2)^{M/2}`**）
  - `eigenvalues_of_V_plus`（`Λ̌_ε = (2 sinh 2K_2)^{M/2} exp(Σ_μ γ(θ~_μ)(ε_μ − 1/2))`）
  - `max_eigenvalue_of_V_plus_simple`（`Λ̌_max = Λ^{(1/2)}_M` であり**単純固有値**。(3) の左から `Q̌_{ε'}` を掛ける鎖は check_26、(1) の 4 行の鎖は check_max_eigenvalue_simple_step1_lambda_half_chain、(2) の `ǧ(1,…,1) − ǧ(ε)` と `Λ̌_ε` の鎖は check_max_eigenvalue_simple_step2_strict_inequality_chains、(3) の後半の差・割り算・項を消す・逆向きの鎖は check_max_eigenvalue_simple_step3_eigenspace_chains）
  - `iH_is_real_symmetric`（Step 0 の準備の 2 本と 2×2 の積の 3 本の鎖は check_37、Step 1 の準備の `Z_m`・`Y_m` のクロネッカー積表示と `Z_mY_m = (-i)σ_m^x` の 8 行の鎖は check_38、Step 1・Step 2 のスカラー倍の鎖は check_22。実対称性そのものは check_05 の (a)）
  - `sign_flip_conjugation`（Step 0・Step 1 の F・E による共役・Step 2・Step 3・Step 4 の鎖。check_09・check_11・check_12・check_13・check_14・check_15・check_16・check_17・check_18・check_19・check_20・check_21）

### 何を確定させるための検証か

章 C′（偶セクターの半整数運動量モード）の C′-15 にあたる。016 章の到達点は
`V^{(+)} = c V̌'`（ある `c ∈ ℂ^×`）までで、**`c` の値は未決定**だった。この章で

1. `V̌'` を数演算子 `ň_μ` の同時固有空間で対角化し（009 章と同じ道筋）、
2. `tr(V^{(+)})/tr((V^{(+)})^{−1}) = c²` と符号反転共役 `U`、および `V^{(+)}` の正定値性から
   `c = (2 sinh 2K_2)^{M/2}` を決め、
3. `V^{(+)}` の固有値 `Λ̌_ε` を全部求めて `Λ̌_max = Λ^{(1/2)}_M`（012 章 `def_Lambda_delta_M`
   の `Λ^{(δ)}_M` で `δ = 1/2`）を確定させ、
4. `γ(θ~_μ) > 0` から **最大固有値が単純**であることを言う

までを本文で閉じる。この検証はその各段を**ラベル単位で個別に**確かめる。

### 009 章（整数運動量）との差

| | 009 章（整数運動量） | 017 章（半整数運動量） |
|---|---|---|
| 添字集合 | `I = {μ : γ_2(θ_μ) ≠ 0}`、臨界点では `m = |I| = M−1` | `μ = 1,…,M` の全部（`m = M`） |
| 同時固有空間の次元 | `2^{M−m}`（臨界点で 2 次元） | 常に `1` 次元 |
| `tr(Q_ε)` | `2^{M−m}` | `1` |
| `tr(V')` の前因子 | `2^{M−m}` | `1`（消える） |
| 最大固有値 | `γ(θ_M) = 0` になりうるので縮退しうる | `γ(θ~_μ) > 0` ゆえ**必ず単純** |

`ň_μ` の対になる添字は `−μ` ではなく `1−μ` である（`def_half_integer_modes` (3)）。
check_01 では対を `−μ` に取り違えると冪等性が壊れることも対照として示す。

**本文が主張しないこと（一次情報で確認した）**: `V^{(+)}` の固有値が「すべて相異なる」ことは
**成り立たない**。`periodicity_of_check_fermi` (3) より `γ(θ~_μ) = γ(θ~_{M+1−μ})` なので、
`μ ↔ M+1−μ` で `ε` を入れ替えても `Λ̌_ε` は変わらない（check_03 で縮退ペアの実在を記録）。
単純性を主張するのは**最大固有値だけ**である。

## 検証の枠組み

`_prelude.sage` は `_shared/spin_ops.sage`（`Z_j, Y_j, H_1^{(±)}, H_2, σ_k^a` の明示行列）の上に、
016 章までの道具（`Ž_μ, Y̌_μ, γ_1, γ_2, γ, P̌_μ, ψ̌_μ^†, ψ̌_μ, X̌, V̌', V^{(+)}`）と
本章の道具を積む。

```
ň_μ      := ψ̌_μ^† ψ̌_{1−μ}
Q̌_ε      := Π_{μ=1}^{M} ( ε_μ ň_μ + (1−ε_μ)(I − ň_μ) )        (ε ∈ {0,1}^M)
ǧ(ε)     := Σ_{μ=1}^{M} γ(θ~_μ)(ε_μ − 1/2)
Λ̌_ε      := (2 sinh 2K_2)^{M/2} exp(ǧ(ε))
Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp( (1/2) Σ_{μ=1}^{M} γ(2π(μ−δ)/M) )
S_1^{(+)} := i K_1 H_1^{(+)},   S_2 := i K_2^* H_2
U        := E F,  E = E_1⊠…⊠E_M（E_m = σ^x（m 奇数）, I（m 偶数））,  F = σ^z⊠…⊠σ^z
```

`V^{(+)}` と `V̌'` はいずれも**行列指数関数から直接構成する**（証明が使う交換子の級数展開とは
独立な経路）。`V_2` の前因子 `(2 s_2)^{M/2}` も明示的に付けてある。

パラメータ:

- `M = 2, 3, 4, 5`、`ε` は `{0,1}^M` を**全列挙**（`M = 5` で 32 通り）
- `(K_1, K_2)` は 6 組。**厳密な臨界点**（`K_2 = arcsinh(1/sinh 2K_1)/2` で構成）2 組
  （非等方・等方 `K_1 = K_2 = K_c`）、臨界点近傍 1 組、一般点 2 組、高温側 1 組。

判定閾値は `TOL = 1e-8`（`report()` で最大残差と比較）。固有値の一致は**相対誤差**で見る。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_number_operator.sage | `def_check_number_operator` / `check_number_operator_idempotent`（`(ψ̌_μ^†)² = 0`、`ψ̌_{1−μ}ψ̌_μ^† = I − ň_μ`、`ň_μ² = ň_μ`）/ `check_number_operators_commute` / `trace_of_check_number_operator_product`（`{1..M}` の**全部分集合**について `tr = 2^{M−|T|}`）。**対照: 対を `−μ` に取り違えると冪等性が破れる** | PASS | 残差 ≤ 7.1e-15、誤った対の破れ `2.59e0` |
| 02 | check_02_joint_eigenspace.sage | `check_joint_eigenspace_decomposition` の (1)〜(5)。`tr(Q̌_ε) = 1`、**特異値で `rank Q̌_ε = 1` を判定**、`Σ_ε Q̌_ε = I`、個数 `2^M` | PASS | 残差 ≤ 2.6e-15、rank 違反 0 件 |
| 03 | check_03_Vprime_eigenvalues.sage | `eigenvalues_of_check_Vprime`。`X̌ Q̌_ε = ǧ(ε)Q̌_ε`、`V̌'Q̌_ε = e^{ǧ(ε)}Q̌_ε`、Sage の固有値集合（`2^M` 個）との一致、正値性。**縮退ペアの実在も記録** | PASS | 残差 ≤ 8.0e-12、固有値最小 `9.4e-4 > 0`、縮退ペア 144 件（正常） |
| 04 | check_04_trace_Vprime.sage | `trace_of_check_Vprime`。`V̌'(V̌')^{−1} = I`、`tr(V̌') = Π_μ 2cosh(γ/2)`、`tr((V̌')^{−1}) = tr(V̌')`、正値性 | PASS | 残差 ≤ 6.9e-12、`min tr(V̌') = 4.90e0` |
| 05 | check_05_positive_definite_and_c.sage | `V_plus_is_positive_definite` / `trace_V_plus_is_positive` / `V_plus_inverse_positive_and_trace_positivity` / `constant_c_value_even_sector`。(a) `S_1^{(+)}, S_2` が実対称（`iH_is_real_symmetric` の **(+) 側**）、(b) `V^{(+)} = (2s_2)^{M/2}exp(S_1/2)exp(S_2)exp(S_1/2)`、(c) `V^{(+)}` のエルミート性と固有値の正値性、候補逆行列のエルミート性、二つのトレース正値性、(d) `U S_1^{(+)}U^{−1} = −S_1^{(+)}`（`sign_flip_conjugation` の **(+) 側**）、(e) `tr(exp(−S_1)exp(−S_2)) = τ`、(f) `tr(V^{(+)})/tr((V^{(+)})^{-1}) = (2s_2)^M`、(g) `c = (2 sinh 2K_2)^{M/2}` と `V^{(+)} = cV̌'` | PASS | 実対称性の残差 `0.0`、`U` 共役の残差 `0.0`、`c` の相対差 ≤ 4.3e-15、`V^{(+)}` の固有値最小 `3.2e-4 > 0` |
| 06 | check_06_eigenvalues_V_plus.sage | `eigenvalues_of_V_plus` / `max_eigenvalue_of_V_plus_simple`。`V^{(+)}Q̌_ε = Λ̌_εQ̌_ε`、**`V^{(+)}` の `2^M` 個の固有値全体が `{Λ̌_ε}` に相対誤差 1e-8 以下で一致**、`Λ̌_max = Λ^{(1/2)}_M`、`γ(θ~_μ) > 0`、**最大固有値の単純性**。対照として `Λ^{(0)}_M`（整数運動量）とは一致しないこと | PASS | 固有値一致の相対差 ≤ 9.0e-12、`Λ̌_max = Λ^{(1/2)}_M` の相対差 `0.0`、`min γ = 5.4e-1`、単純性の相対差 ≥ 4.17e-1 |
| 07 | check_07_V_plus_mul_inverse.sage | `V_plus_is_invertible` の右逆検査。本文と同じ明示式で作った `R^{(+)}` について `V^{(+)}R^{(+)} = I` | PASS | 相対残差 ≤ 1.889e-11 |
| 08 | check_08_inverse_mul_V_plus.sage | `V_plus_is_invertible` の左逆検査。本文と同じ明示式で作った `R^{(+)}` について `R^{(+)}V^{(+)} = I` | PASS | 相対残差 ≤ 2.197e-11 |
| 09 | check_09_sign_flip_step3_chains.sage | `sign_flip_conjugation` の Step 3 の二つの鎖（`U(Y_jZ_k)U^{-1} = Y_j(-Z_k) = -(Y_jZ_k)`、`U(Z_jY_j)U^{-1} = (-Z_j)Y_j = -(Z_jY_j)`）を一行ずつ。`QQ(i)` の厳密計算、`M = 2,3,4` の全ての `j, k`、符号反転は `def_matrix_negation` のとおり成分ごと。否定コントロール 1 件 | PASS | 114 段、全段で厳密に一致 |
| 10 | check_10_V_plus_inverse_chains.sage | `V_plus_is_invertible` の Step 2・Step 3 の鎖の 2 行目以降を一行ずつ（1 行目の表示は check_07・check_08 が覆う）。`E_±, A_±` の代わりに `QQ` 上の可逆行列と逆行列を置き（各段は Step 1 の左右逆だけを使う）、スカラー倍の 5 段・結合律・左右逆・単位行列を左右から掛ける段を本文と同じ括弧で確かめる。否定コントロール 1 件 | PASS | 252 段、全段で厳密に一致 |
| 11 | check_11_sign_flip_step3_step4_conjugation_chains.sage | `sign_flip_conjugation` の Step 3 の「`conjugation_is_ring_homomorphism` の `T_B` の定義 → 乗法性 → `T_B` の定義」の三行（二つの鎖とも）と、Step 4 の二つの六行の鎖（`S` の定義・`scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor`・Step 3・`scalar_multiple_of_negated_matrix`・`S` の定義）を一行ずつ。`QQ(i)` の厳密計算、`M = 2,3,4`、`UXU^{-1}` は本文どおり `(UX)U^{-1}`、`K_1, K_2^*` は正の有理数の代表値、符号反転とスカラー倍は成分ごと。否定コントロール 1 件 | PASS | 150 段、全段で厳密に一致 |
| 12 | check_12_sign_flip_step0_site_square_chains.sage | `sign_flip_conjugation` の Step 0 の鎖 `σ_m^aσ_m^a = I_{Mat(2^{M_col},ℂ)}`（`a ∈ {x, z}`）の 5 行（`def_site_pauli_matrices`・`kronecker_product_rule` (1)・`pauli_matrix_products`・`identity_matrix_is_left_unit_of_mat_mult`・`kronecker_product_rule` (2)）を一行ずつ。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての `m`、クロネッカー積は `def_kronecker` の成分の式で作り Sage の `tensor_product` と突き合わせる。否定コントロール 1 件 | PASS | 90 段、全段で厳密に一致 |
| 13 | check_13_sign_flip_step1_F_conjugation_chains.sage | `sign_flip_conjugation` の Step 1 の `σ_k^zσ_k^x = -(σ_k^xσ_k^z)` の 10 行の鎖（`def_site_pauli_matrices`・`kronecker_product_rule` (1)・`identity_matrix_is_left_unit_of_mat_mult`・`pauli_matrix_products`・`negation_is_scalar_multiple_by_minus_one`・`kronecker_multilinear`・その逆向き）と、`Fσ_k^xF^{-1}`（`(σ_k^zσ_k^x)σ_k^z` から 5 行）・`Fσ_k^zF^{-1}`（2 行）の鎖を一行ずつ。旧版の本文の 1 行目（`k` 以外のサイトの因子は可換）を `F = ∏σ_m^z`・`F^{-1} = F` から組んで比べる段も残す（いまの本文の鎖の先頭、`W` の鎖と `(σ_k^pσ_k^a)σ_k^p` の鎖は check_17 が受け持つ）。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての `k`、符号反転とスカラー倍は成分ごと。否定コントロール 1 件 | PASS | 171 段、全段で厳密に一致 |
| 14 | check_14_sign_flip_step1_F_conjugation_sigma_y_chain.sage | `sign_flip_conjugation` の Step 1 の `σ_k^pσ_k^q = -(σ_k^qσ_k^p)` の 10 行の鎖を `(p, q) = (z, x), (y, z)` の両方で、`Fσ_k^yF^{-1}` の鎖（`(σ_k^zσ_k^y)σ_k^z` から `mat_mult_associative`・上の鎖の `(y, z)`・`negation_factors_out_of_right_factor`・`mat_mult_associative`・Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 6 行）を一行ずつ。旧版の本文の 1 行目（`k` 以外のサイトの因子は可換）を `F = ∏σ_m^z`・`F^{-1} = F` から組んで比べる段も残す（いまの本文の鎖の先頭、`W` の鎖と `(σ_k^pσ_k^a)σ_k^p` の鎖は check_17 が受け持つ）。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての `k`、符号反転とスカラー倍は成分ごと。否定コントロール 1 件 | PASS | 243 段、全段で厳密に一致 |
| 15 | check_15_sign_flip_step1_E_conjugation_chains.sage | `sign_flip_conjugation` の Step 1 の `σ_k^pσ_k^q` の 10 行の鎖を足した組 `(p, q) = (y, x)` で、`k` が奇数のときの `Eσ_k^xE^{-1}` の鎖（Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 2 行）と `Eσ_k^aE^{-1}`（`a = y, z`）の鎖（`(σ_k^xσ_k^a)σ_k^x` から `mat_mult_associative`・上の鎖の `(a, x)`・`negation_factors_out_of_right_factor`・`mat_mult_associative`・Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 6 行）を一行ずつ。旧版の本文の 1 行目（第 `k` 因子だけが効く）を `E = ∏_{m 奇数}σ_m^x`・`E^{-1} = E` から組んで比べる段も残す（いまの本文の鎖の先頭は check_17 が受け持つ）。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての奇数 `k`。否定コントロール 1 件 | PASS | 135 段、全段で厳密に一致 |
| 16 | check_16_sign_flip_step0_E_F_U_invertibility_chains.sage | `sign_flip_conjugation` の Step 0 の可逆性の鎖。`E_mE_m = σ^xσ^x = I`（`m` 奇数）・`E_mE_m = II = I`（`m` 偶数）、`FF = I`・`EE = I` の 4 行ずつ（`F`・`E` の定義・`kronecker_product_rule` (1)・`pauli_matrix_products` / 上の `E_mE_m = I`・`kronecker_product_rule` (2)）、`def_invertible_elements_of_R` (ii) の証明の 6 行ずつを `g_1 = E`・`g_2 = F` で、`U^{-1} = F^{-1}E^{-1} = FE^{-1} = FE` を Sage の逆行列と突き合わせる。クロネッカー積の `E`・`F` が旧定義の行列の積 `∏_{m 奇数}σ_m^x`・`∏_mσ_m^z` と一致することも確かめる。`QQ(i)` の厳密計算、`M = 2,3,4,5`。否定コントロール 1 件 | PASS | 120 段、全段で厳密に一致 |
| 17 | check_17_sign_flip_step1_W_conjugation_chains.sage | `sign_flip_conjugation` の Step 1 の先頭の 3 本の鎖を一行ずつ。`Wσ_k^aW^{-1} = I⊠⋯⊠((W_kσ^a)W_k)⊠⋯⊠I`（`W ∈ {E, F}`、Step 0 の `W^{-1} = W`・`W` の定義・`def_site_pauli_matrices`・`kronecker_product_rule` (1) 2 回・`identity_matrix_is_right_unit_of_mat_mult`・Step 0 の `W_mW_m = I` の 7 行）、`I⊠⋯⊠((σ^pσ^a)σ^p)⊠⋯⊠I = (σ_k^pσ_k^a)σ_k^p`（`p ∈ {x, z}`、5 行）、`k` 偶数の `I⊠⋯⊠((E_kσ^a)E_k)⊠⋯⊠I = σ_k^a`（4 行）。`F`・`E` の鎖の 1 行目の結論の符号も突き合わせる。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての `k` と `a ∈ {x, y, z}`。否定コントロール 1 件 | PASS | 690 段、全段で厳密に一致 |
| 18 | check_18_sign_flip_step1_composition_chains.sage | `sign_flip_conjugation` の Step 1 の合成の段を一行ずつ。合成の鎖 `UXU^{-1} = E(FXF^{-1})E^{-1}`（`U` の定義・Step 0 の `U^{-1} = FE`・`mat_mult_associative` 3 回・Step 0 の `F^{-1} = F`・`E^{-1} = E` の 7 行。成分を不定元に置いた `X` と全ての `σ_k^a` で）と、`a = x, y, z` の鎖（上の `F` の式・`negation_factors_out_of_right_factor`・`negation_factors_out_of_left_factor`・`E` の式（`k` の偶奇）・`k` 奇数の `σ^y` で `matrix_double_negation`）。否定コントロールとして、`U^{-1}` を `EF` と取り違えると合成の鎖の 3 行目の符号反転になり一致しないことを確かめる | PASS | `M = 2, 3, 4`、全ての `k`、`QQ(i)` と `QQ(i)` 上の多項式環で厳密等号（336 段） |
| 19 | check_19_sign_flip_step2_Z_Y_chains.sage | `sign_flip_conjugation` の Step 2 を一行ずつ。`P_0 := I`・`P_{r+1} := P_rσ_{r+1}^x` の `UP_rU^{-1}` の帰納法（`r = 0` の 4 行: `P_0` の定義・`T_B` の定義・`conjugation_is_ring_homomorphism` の単位性・`P_0` の定義。帰納法の段の 10 行: `P_{r+1}` の定義・`T_B` の定義・乗法性・`T_B` の定義・Step 1 の `Uσ_k^xU^{-1} = -σ_k^x`・`negation_factors_out_of_right_factor`・帰納法の仮定・`r` 奇数の `negation_factors_out_of_left_factor`・`matrix_double_negation`・`P_{r+1}` の定義）と、`Z_m`・`Y_m` の鎖（`T_B` の定義・乗法性・`T_B` の定義の 3 行・`UP_rU^{-1}` を `r = m-1` で・Step 1 の `Uσ_m^aU^{-1}`・符号の外出し・`Y_m` の `m` 偶数で `matrix_double_negation`）。`Z_m`・`Y_m` を定義の積 `σ_1^x⋯σ_{m-1}^xσ_m^a` から作り `P_{m-1}σ_m^a` と突き合わせる。否定コントロールとして、Step 1 の `Uσ_k^xU^{-1}` の符号を落とすと `UP_1U^{-1} = -P_1` と一致しないことを確かめる | PASS | `M = 2, 3, 4, 5`、全ての `r`・`m`、`QQ(i)` で厳密等号（436 段） |
| 20 | check_20_sign_flip_step3_H2_chain.sage | `sign_flip_conjugation` の Step 3 の `H_2` の鎖を一行ずつ。項の鎖 `U(Z_jY_j)U^{-1} = -(Z_jY_j)`（`T_B` の定義・乗法性・`T_B` の定義・Step 2・`negation_factors_out_of_left_factor` の 5 行）と、`UH_2U^{-1}` の 7 行（`def_H2`・`T_B` の定義・`matrix_conjugation_preserves_finite_sum`・`T_B` の定義を各項に・項の鎖・`finite_sum_of_negated_matrices`・`def_H2`）。有限和は `def_finite_sum_of_matrices` のとおり左から足す。否定コントロールとして、項の鎖の 4 行目で `UZ_jU^{-1}` を `+Z_j` と取り違えると、その行も和も右端と一致しないことを確かめる | PASS | `M = 2, 3, 4, 5`、全ての `j`、`QQ(i)` で厳密等号（98 段） |
| 21 | check_21_sign_flip_step3_H1plus_chain.sage | `sign_flip_conjugation` の Step 3 の `H_1^{(+)}` の鎖を一行ずつ。項の鎖 `U(Y_jZ_k)U^{-1} = -(Y_jZ_k)`（`T_B` の定義・乗法性・`T_B` の定義・Step 2・`negation_factors_out_of_right_factor` の 5 行、全ての `j, k`）と、`UH_1^{(+)}U^{-1}` の 9 行（`def_H1_plus`・`T_B` の定義・`matrix_conjugation_preserves_difference`・`matrix_conjugation_preserves_finite_sum`・`T_B` の定義を各項と引く項に・項の鎖・`finite_sum_of_negated_matrices`・`difference_of_negated_matrices`・`def_H1_plus`）。有限和は `def_finite_sum_of_matrices` のとおり左から足し、差は成分ごとに取る。否定コントロールとして、`(-A)-(-B)` を `-(A+B)` と取り違えると右端と一致しないこと、項の鎖で `UZ_kU^{-1}` を `+Z_k` と取り違えると一致しないことを確かめる | PASS | `M = 2, 3, 4, 5`、全ての `j, k`、`QQ(i)` で厳密等号（306 段） |
| 22 | check_22_iH_real_symmetric_scalar_chains.sage | `iH_is_real_symmetric` の Step 1 の `H_2` の 3 行（`def_H2`・上で得た `Z_mY_m`・`finite_sum_of_scalar_multiples`）と `S_2` の 8 行（`S_2` の定義・`H_2` の表示・`scalar_multiple_is_associative`・ℂ の積の結合律・交換律・結合律・`i(-i) = 1`・乗法の単位元）、Step 2 の `S_1^{(+)}` の 13 行（`def_H1_plus`・上で得た `Y_mZ_{m+1}` を各項へ・上で得た `Y_{M_col}Z_1`・`finite_sum_of_scalar_multiples`・`scalar_multiple_distributes_over_matrix_difference` を右辺から左辺へ・`scalar_multiple_is_associative`・ℂ の積の 3 行・`i(-i) = 1`・乗法の単位元・`scalar_multiple_distributes_over_matrix_difference`）を一行ずつ。スカラー倍・和・差・有限和は本文の定義どおり成分から組む。ℂ の積の結合律・交換律・単位元の行は、成分を可換な多項式環に置くので構成上かならず一致し、写し間違いは検出できない。否定コントロールとして、境界項の符号を取り違えた `K_1Σσ^zσ^z + K_1G` とは一致しないことを確かめる | **PASS** | 成分は `QQ(i)[K_1, K_2^*]`（不定元）で厳密等号、`M = 2, 3, 4, 5` |
| 23 | check_23_check_number_operator_associativity_chains.sage | `check_number_operator_idempotent` (3) の 23 行（先頭 4 行は `def_exp` (1) の冪を積へ運ぶ行）、`check_number_operators_commute` Step 2 の 10 行と Step 3 の 7 行を、括弧どおりに一行ずつ `QQ` で厳密に。仮定（(1)(2)、Step 1 の `AB = -(BA)`）を満たす模型として Jordan–Wigner のフェルミ演算子 `c_μ` を取り `D_μ := c_μ^T`、`P_μ := c_μ`（`M = 2, 3, 4`）。否定コントロールとして、仮定を満たさない不定元の行列では仮定を使う 6 行だけが外れ、結合律・分配律・単位行列・符号の外出し・二重の符号反転・差の書き換えの行は成り立つことを確かめる | **PASS** | `M = 2, 3, 4` で `QQ` の厳密等号 747 段、不定元の行列で 34 段（計 781 段）、否定コントロール 6 行 |
| 24 | check_24_joint_eigenspace_distributivity_chains.sage | `check_joint_eigenspace_decomposition` の Step 0 の `R^{(1)}R^{(0)} = 0`（7 行）・`R^{(0)}R^{(1)} = 0`（7 行）・`R^{(0)}R^{(0)} = R^{(0)}`（8 行。最後の行は `R^{(0)}` の定義）と、Step 3 の `ε_ν = 0` の場合の `ň_νR_ν^{(0)} = 0`（`R^{(1)}R^{(0)}` と同じ 7 行）を、括弧どおりに一行ずつ `QQ` で厳密に。仮定（`check_number_operator_idempotent` (3) の `ňň = ň`）を満たす模型として Jordan–Wigner のフェルミ演算子から `n_μ := c_μ^Tc_μ` を取る（`M = 2, 3, 4`）。否定コントロールとして、冪等でない不定元の行列では冪等性と `R^{(1)}R^{(0)} = 0` を使う 3 行だけが外れ、差の書き換え・分配・単位行列・符号の外出し・零行列を引く行は成り立つことを確かめる | **PASS** | `M = 2, 3, 4` で `QQ` の厳密等号 198 段、不定元の行列で 19 段（計 217 段）、否定コントロール 3 行 |
| 25 | check_25_Vprime_eigenvalue_power_chains.sage | `eigenvalues_of_check_Vprime` の Step 2 の帰納法（`k = 0` の 4 行、`k + 1` の 8 行）・Step 3' の帰納法（`k = 0` の 4 行、`k + 1` の 7 行）・Step 4 の `Q̌_εy = y`（8 行）を、括弧どおりに一行ずつ `QQ` で厳密に。行列の冪は `def_exp` (1) の `A^0 := I`・`A^{m+1} := A^mA`、数の冪は `g^0 := 1`・`g^{k+1} := g^kg`。仮定（Step 1 の `X̌Q̌ = gQ̌ = Q̌X̌`、帰納法の仮定、`Q̌^2 = Q̌`）を満たす模型として Jordan–Wigner のフェルミ演算子から `n_μ := c_μ^Tc_μ`、`Q̌_ε := Π_μR_μ^{(ε_μ)}`、有理数 `γ_μ` の `X̌ := Σ_μγ_μ(n_μ − (1/2)I)` を取る（`M = 2, 3`、`ε` を全列挙、`k = 0, …, 4`）。否定コントロールとして、不定元の行列 `X, Q` と不定元 `g, x` では Step 1・帰納法の仮定（`k ≥ 1`）・冪等性を使う 9 行だけが外れ、冪の定義・結合律・単位行列・スカラー倍・ℂ の交換律を引く行は成り立つことを確かめる。ℂ の交換律の行は、可換な `QQ` と多項式環の上では構成上いつも一致する | **PASS** | 厳密等号 1129 段（模型と不定元の行列の合計）、否定コントロール 9 行 |
| 26 | check_26_max_eigenvalue_simple_left_projection_chain.sage | `max_eigenvalue_of_V_plus_simple` (3) の、固有方程式 `V^{(+)}x = Λ̌_max x` に左から `Q̌_{ε'}` を掛ける鎖（5 行: 左の因子のスカラー倍の外出し、`eigenvalues_of_V_plus` (1)、`mat_mult_associative`（`q → 1`）、固有方程式、右の因子のスカラー倍の外出し）を、括弧どおりに一行ずつ `QQ` で厳密に。仮定（(1) の `Q̌_εV^{(+)} = Λ̌_εQ̌_ε` と固有方程式）を満たす模型として Jordan–Wigner のフェルミ演算子から `Q̌_ε` を作り、有理数 `Λ_ε` で `V := Σ_εΛ_εQ̌_ε`、`x := Q̌_{(1,…,1)}y` を取る（`M = 2, 3, 4`、`ε'` を全列挙）。否定コントロールとして、不定元の行列 `Q, V` と不定元 `λ, λ_max, x` では (1) と固有方程式を使う 2 行だけが外れ、スカラー倍と結合律を引く 3 行は成り立つことを確かめる | **PASS** | 厳密等号 143 段（模型と不定元の行列の合計）、否定コントロール 2 行 |
| 27 | check_27_V_plus_inverse_real_inclusion_chains.sage | `V_plus_is_invertible` の Step 2 の `a := (2s_2)^{M_col/2} ∈ ℝ_{>0}`・`a^{-1} = (2s_2)^{-M_col/2}`（`a` を `√((2s_2)^M)` と `(√(2s_2))^M` の 2 経路で、`a^{-1}` を `a` を使わず `√((2s_2)^{-M})` で計算して比べる）と、Step 2・Step 3 の鎖のうち係数を包含 `a_ℂ`・`(a^{-1})_ℂ` で扱う 2〜8 行目（左右の因子のスカラー倍の外出し、`scalar_multiple_is_associative`、`real_inclusion_preserves_product`、`ℝ` の `aa^{-1} = 1`、`1_ℂ = (1)_ℂ`、`scalar_multiple_by_one`）を一行ずつ。`ℝ` は `AA`、`ℂ` は `QQbar`、包含は `ι(r) = (r, 0)` を実部・虚部で確かめた `QQbar(r)`。係数の `M` は `2..5`、`s_2 ∈ {1/3, 2, 5/7}`（`M` が奇数なら `a` は無理数）、`X, Y` は虚部を持つ `QQbar` の `2^{min(M,3)}` 次の行列（係数の段は行列の大きさに依らない）。否定コントロールは同じ鎖を係数 `a, a` で回し、`ℝ` の `cd = 1` を引く段だけが外れること | **PASS** | 厳密等号 168 段、否定コントロール 12 行 |
| 28 | check_28_check_number_operator_idempotent_anticommutator_chains.sage | `check_number_operator_idempotent` (1) の 2 本の鎖（`XX + XX = [X, X]_+ = O`、`X ∈ {ψ̌_μ^†, ψ̌_{M+1-μ}}`）と `XX = O`、(2) の鎖（`DP + PD = [D, P]_+ = δI = 1_ℂI = I`）と `PD = I - DP = I - ň_μ` を、Jordan–Wigner の模型（`M = 2, 3, 4`）で `QQ` の厳密等号で一行ずつ。不定元の行列では反交換関係を使う行だけが外れる（否定コントロール）。反交換子の定義を写した 2 行は構成上かならず一致する | **PASS** | 厳密等号 95 段、否定コントロール 3 行 |
| 29 | check_29_check_number_operators_commute_step1_anticommutator_chains.sage | `check_number_operators_commute` Step 1 の 4 式の全行（第 1 式・第 4 式 `[X, W]_+ = O`、第 2 式 `[ψ̌_μ^†, ψ̌_{M+1-ν}]_+ = δI = 0_ℂI = O`、第 3 式 `[ψ̌_{M+1-μ}, ψ̌_ν^†]_+` から和の交換・反交換子へ戻す・第 2 式・`δ` の対称性・`0_ℂI = O` の 7 行）、直前の `δ_{M+1-ν, M+1-μ} = δ_{μ,ν} = 0`、続く `XW + WX = [X, W]_+ = O` と `matrix_equals_negation_if_sum_is_zero` による `XW = -(WX)` を、Jordan–Wigner の模型（`M = 2, 3, 4`、`μ ≠ ν` の全 20 組）で `QQ` の厳密等号で一行ずつ。不定元の行列では反交換関係を引く仮定の行 5 行と `XW = -(WX)` の計 6 行だけが外れ、ほかの行は一致する（否定コントロール） | **PASS** | 厳密等号 520 個（1 組 26 個）、否定コントロール 6 行 |
| 30 | check_30_joint_eigenspace_step0_square_inverse_and_sum_chains.sage | `check_joint_eigenspace_decomposition` の Step 0 の冒頭の `ň_μň_μ = ň_μ`（5 行。冪は `def_exp` (1) どおりに組む）、Step 0・Step 3 の `ň − ň = O`（`matrix_difference_zero_iff_equal` の `⟸`）、Step 0 の和 `R^{(1)} + R^{(0)} = ň + (I − ň) = I`（`matrix_plus_difference_cancels`）を、`M = 2, 3, 4` の `ň_μ` で一行ずつ `QQ` の厳密計算で確かめる。冒頭の鎖の 2〜4 行目（`def_exp` (1) の定義の行）は、冪を定義どおりに組むので構成上かならず一致する。否定コントロール: 冪等でない不定元の 2×2 行列では (3) を使う行だけが等号を外れる | PASS | 79 段、否定コントロール 1 行 |
| 31 | check_31_joint_eigenspace_step3_scalar_chains.sage | `check_joint_eigenspace_decomposition` Step 3 の `ε_ν = 1` の場合の鎖（`ň_νň_ν = ň_ν = R^{(1)} = 1_ℂR^{(1)}`（`scalar_multiple_by_one` を右辺から左辺へ）= `ε_νR^{(ε_ν)}`）と、`ε_ν = 0` の場合の末尾（`O = 0_ℂR^{(0)}`（`zero_scalar_multiple_is_zero_matrix` を右辺から左辺へ）= `ε_νR^{(ε_ν)}`）を、`M = 2, 3, 4` の全ての `ň_μ` で `QQ` の厳密等号で一行ずつ。`ε_ν = 1` の場合の `R^{(1)}` の定義の行と場合の仮定の行は、`R^{(1)} := ň`・`ε_ν = 1` で組むので構成上かならず一致する（check_35 の「直前の二つの場合」の前提の検査が、全ての `ε` で `ň_νR^{(ε_ν)} = ε_νR^{(ε_ν)}` と突き合わせる）。否定コントロール: 冪等でない不定元の 2×2 行列では冪等性を使う 2 行だけが外れる | PASS | 88 段（Jordan–Wigner の模型で 81 段、不定元の行列で 7 段）、否定コントロール 2 行 |
| 32 | check_32_joint_eigenspace_step1_step2_zero_and_identity_products.sage | `check_joint_eigenspace_decomposition` Step 2 の鎖（分配による展開の行・Step 0 の和の行・`finite_product_of_identity_matrices` の行）を、`M = 2, 3, 4` で `QQ` の厳密等号で一行ずつ。有限積は `def_finite_product_of_matrices` どおり `μ = 1` の因子から左へ掛ける（空の積は使わない）。否定コントロール: 単位行列でない因子があれば有限積は単位行列にならない （Step 2 の 1 行目の和は Sage の `sum` で組む。展開の行の根拠が `expansion_of_finite_product_of_two_term_sums` になった後の、和を定義どおりに組んだ鎖は check_33 が確かめる。Step 1 の `ε ≠ ε'` の鎖は check_35 が確かめる） | PASS | 9 段、否定コントロール 1 行 |
| 33 | check_33_joint_eigenspace_step2_expansion_over_binary_words.sage | `check_joint_eigenspace_decomposition` Step 2 の鎖（`Q̌_ε` の定義の行・`expansion_of_finite_product_of_two_term_sums` を右辺から左辺へ使う行・Step 0 の和の行・`finite_product_of_identity_matrices` の行）を、(2) の和を `def_sum_over_binary_words`（最後の成分で `1` を `0` より先に足す帰納法）どおりに組んで、`M = 2, 3, 4` で `QQ` の厳密等号で一行ずつ。`Q̌_ε` の定義の行は `Q̌_ε` を定義どおりに組むので構成上かならず一致する。否定コントロール: `R^{(0)}` を零行列に替えると展開の行は成り立ち、Step 0 の和の行だけが外れる | PASS | 12 段、否定コントロール 3 行 |
| 34 | check_34_joint_eigenspace_commutation_and_square_chains.sage | `check_joint_eigenspace_decomposition` Step 0 の異なる添字の因子の可換性（単位行列との積の 2 行と、4 通りの上付き添字の組の鎖）、Step 1 の `ε = ε'` の鎖（`def_exp` (1) の冪の 4 行・`Q̌_ε` の定義の行・`product_of_two_finite_products_of_matrices` の行（前提の `j < i` の可換性も）・冪等性の行・定義の行）、Step 3 の左右の鎖（因子ごとの可換性の 3 つの場合と、`matrix_commuting_with_each_factor_commutes_with_finite_product` を右辺から左辺へ使う行を含む 4 行）を、`M = 2, 3, 4` の全ての `ε`・`μ`・`ν` で `QQ` の厳密等号で一行ずつ。冪は `A^0 := I`、`A^{m+1} := A^mA` どおりに組む。否定コントロール: 可換でない因子の族では `∏(RR)` の行が外れる | PASS | 1916 段、否定コントロール 1 行 |
| 35 | check_35_joint_eigenspace_moving_one_factor_chains.sage | `check_joint_eigenspace_decomposition` Step 1 の `ε ≠ ε'` の鎖（`μ = ν` の可換性の 2 行と、`Q̌_ε` の定義・`moving_one_factor_of_finite_product_to_the_end`・結合律・`Q̌_{ε'}` の定義・`matrix_commuting_with_each_factor_commutes_with_finite_product`・`moving_one_factor_of_finite_product_to_the_end`・結合律・Step 0 の異なる上付き添字の積・`zero_matrix_is_right_zero_of_mat_mult` 2 回の 10 行。二つの主張の前提も）を `ε_ν ≠ ε'_ν` の全ての `ν` で、Step 3 の `ň_νQ̌_ε` の鎖（`Q̌_ε` の定義・`matrix_commuting_with_each_factor_commutes_with_finite_product`・`moving_one_factor_of_finite_product_to_the_end`・結合律・`μ = ν` の場合・二つの場合・`scalar_multiple_factors_out_of_right_factor`・`moving_one_factor_of_finite_product_to_the_end` を右辺から左辺へ・定義の 9 行）を全ての `ν` で、`M = 2, 3, 4` の全ての `ε`・`ε'` について `QQ` の厳密等号で一行ずつ。`∏_{μ≠ν}` は `def_finite_product_of_matrices_omitting_one_index` どおり `s_{M,ν}` で添字を並べて組む。否定コントロール: `ν < j` の因子と可換でない族では、`ν` の因子を末尾へ寄せる行が外れる | PASS | 8352 段、否定コントロール 1 行 |
| 36 | check_36_joint_eigenspace_step4_step5_power_and_vector_chains.sage | `check_joint_eigenspace_decomposition` Step 4 の `tr(Q̌_ε) = 2^{M−M} = 2^0 = 1`（冪は `def_power_of_complex_number` どおり `z^0 := 1`、`z^{m+1} := z^m z` で組む）を全ての `ε` で、Step 5 の全体を張る鎖（`identity_matrix_is_left_unit_of_mat_mult`（`n → 1`）・(2)・`sum_over_binary_words_distributes_in_left_factor`（`p → 1`）の 3 行。`x` の成分は不定元）と、直和の鎖（1 行目は当時「Step 1 の直交性と冪等性」で、いまの根拠の鎖は check_joint_eigenspace_step5_direct_sum_first_line。ここでは `y_ε = Q̌_εx_ε` で、2 行目 `sum_over_binary_words_distributes_in_right_factor`（`p → 1`）は一般の `y_ε` で、4 行目 `zero_matrix_is_right_zero_of_mat_mult`（`p → 1`）は零ベクトルで）を全ての `ε'` で、`M = 2, 3, 4` について `QQ` と `QQ` 上の多項式環の厳密等号で一行ずつ。数ベクトルは `2^M` 行 1 列の行列、`ε` で添字付けた和は `def_sum_over_binary_words` どおりに組む。3 行目は仮定 `Σ_ε y_ε = O` の代入なので構成上かならず一致する。否定コントロール: `R^{(0)}` の代わりに `R^{(1)}` を使った族では `(Σ Q̌)x = x` が外れる | PASS | 177 段、否定コントロール 3 行 |
| 37 | check_37_iH_real_symmetric_step0_pauli_product_chains.sage | `iH_is_real_symmetric` の Step 0 の準備 `(-i)·i = 1`（4 行）・`(-i)·(-i) = -1`（6 行）と、2×2 の積の鎖 `σ^zσ^y = (-i)σ^x`（11 行）・`σ^yσ^x = (-i)σ^z`（12 行）・`σ^xσ^z = (-i)σ^y`（11 行）を 1 行ずつ（`mat_mult`・`def_matrix_scalar_multiple` は成分の式どおりに組み Sage の演算とも比べる）。否定コントロール: スカラーの符号を取り違えた 3 本と、準備の符号を取り違えた 2 本は一致しない | PASS | `QQ(i)` で厳密等号（44 段、否定コントロール 5 件） |
| 38 | check_38_iH_real_symmetric_step1_ZY_kronecker_chain.sage | `iH_is_real_symmetric` の Step 1 の準備（`Z_m`・`Y_m` を `def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices` の左から掛けた積から `site_pauli_prefix_product_kronecker_form` のクロネッカー積へ移す各 1 段）と、`Z_mY_m` の 8 行（準備の `Z_m`・`Y_m` の表示・`kronecker_product_rule` (1)・`σ^xσ^x = I`・`identity_matrix_is_left_unit_of_mat_mult`・Step 0 の `σ^zσ^y = (-i)σ^x`・`kronecker_multilinear`・`def_site_pauli_matrices`）を、`M_col = 1..5` の全ての `m` で `QQ[i]` の厳密等号で一行ずつ。各行は本文の字面どおりの 2×2 の因子の並びのクロネッカー積として組む。否定コントロール: スカラーを `i` に替えると偽、`σ^x` を置くサイトを替えると偽（`M_col ≥ 2`）。準備の `Z_m` の表示の行と鎖の 1 行目は Sage の中では同じ行列なので、写し間違いの検出だけに効く | **PASS** | 150 段、否定コントロール 2 種 |
| 直和の鎖の 1 行目 | check_joint_eigenspace_step5_direct_sum_first_line.sage | `check_joint_eigenspace_decomposition` Step 5 の直和の鎖の 1 行目（`y_{ε'} = Q̌_{ε'}y_{ε'}` と `sum_over_binary_words_with_one_nonzero_term` を右辺から左辺へ使う行）と、その前提の二つの鎖（`ε ≠ ε'` の `Q̌_{ε'}y_ε` の 4 行：`x_ε` の取り方・`mat_mult_associative`（`q → 1`）・Step 1 の (1)・`zero_matrix_is_left_zero_of_mat_mult`（`p → 1`）。`Q̌_{ε'}y_{ε'} = y_{ε'}` の 4 行）を、`y_ε = Q̌_εx_ε`（`x_ε` の成分は不定元）として `M = 2, 3, 4` の全ての `ε`・`ε'` で `QQ` 上の多項式環の厳密等号で一行ずつ。否定コントロールは `R^{(0)}_μ` を単位行列に替えると `ε = (1,…,1)`・`ε' = (0,…,0)` で `Q̌_{ε'}Q̌_ε = O` が外れること | **PASS** | 1400 段、否定コントロール 3 行 |
| Step 1 の左から掛ける形 | check_eigenvalues_of_check_Vprime_step1_left_chain.sage | `eigenvalues_of_check_Vprime` Step 1 の `X̌Q̌_ε` から `ǧ(ε)Q̌_ε` までの 14 行（`def_check_number_operator` (2)・`finite_sum_of_matrices_distributes_in_left_factor`・`scalar_multiple_factors_out_of_left_factor`・`matrix_difference_is_sum_with_negation`・`mat_mult_distributes_over_sum_in_left_factor`・`negation_factors_out_of_left_factor`・`identity_matrix_is_left_unit_of_mat_mult`・(3)・`difference_of_scalar_multiples_of_one_matrix`・`scalar_multiple_is_associative`・`finite_sum_of_scalar_multiples_of_one_matrix`・`ǧ` の定義）を、本文の定義どおり成分から組んだ行列で `M = 2, 3, 4` の全ての `ε` について `QQ` の厳密等号で一行ずつ。模型は Jordan–Wigner のフェルミ演算子から `n_μ := c_μ^Tc_μ`、`Q̌_ε := Π_μR_μ^{(ε_μ)}`、有理数 `γ_μ`。左辺と右辺は Sage の演算（独立な経路）とも比べる。否定コントロール: 不定元の行列 `N_μ, Q` と不定元 `γ_μ, ε_μ` では (3) を引く行だけが外れ、残り 13 行は成り立つ。1 行目と 14 行目は `X̌`・`ǧ` を同じ式で組むので構成上かならず一致する。模型の `n_μ := c_μ^Tc_μ` は本文の `ň_μ` そのものではないが、鎖が使う仮定は (3) だけなので検算として足りる | **PASS** | 405 段（否定コントロールの 13 段を含む）、否定コントロール 1 行 |
| Step 1 の右から掛ける形 | check_eigenvalues_of_check_Vprime_step1_right_chain.sage | `eigenvalues_of_check_Vprime` Step 1 の `Q̌_εX̌` から `ǧ(ε)Q̌_ε` までの 14 行（`def_check_number_operator` (2)・`finite_sum_of_matrices_distributes_in_right_factor`・`scalar_multiple_factors_out_of_right_factor`・`matrix_difference_is_sum_with_negation`・`mat_mult_distributes_over_sum_in_right_factor`・`negation_factors_out_of_right_factor`・`identity_matrix_is_right_unit_of_mat_mult`・(3)・`difference_of_scalar_multiples_of_one_matrix`・`scalar_multiple_is_associative`・`finite_sum_of_scalar_multiples_of_one_matrix`・`ǧ` の定義）を、本文の定義どおり成分から組んだ行列で `M = 2, 3, 4` の全ての `ε` について `QQ` の厳密等号で一行ずつ。模型は Jordan–Wigner のフェルミ演算子から `n_μ := c_μ^Tc_μ`、`Q̌_ε := Π_μR_μ^{(ε_μ)}`、有理数 `γ_μ`。左辺と右辺は Sage の演算（独立な経路）とも比べる。否定コントロール: 不定元の行列 `N_μ, Q` と不定元 `γ_μ, ε_μ` では (3) を引く行だけが外れ、残り 13 行は成り立つ。1 行目と 14 行目は `X̌`・`ǧ` を同じ式で組むので構成上かならず一致する。模型の `n_μ := c_μ^Tc_μ` は本文の `ň_μ` そのものではないが、鎖が使う仮定は (3) だけなので検算として足りる | **PASS** | 405 段（否定コントロールの 13 段を含む）、否定コントロール 1 行 |
| Step 3・Step 3' の部分和 | check_eigenvalues_of_check_Vprime_step3_partial_sum_chains.sage | `eigenvalues_of_check_Vprime` Step 3 の `E_KQ̌_ε` と Step 3' の `Q̌_εE_K` から `(Σ_{k=0}^{K}(1/k!)ǧ(ε)^k)Q̌_ε` までの各 8 行（`E_K` の定義・`def_finite_sum_of_matrices_from_index_zero`・`finite_sum_of_matrices_distributes_in_left_factor`（右は `_right_factor`）・`scalar_multiple_factors_out_of_left_factor`（右は `_right_factor`）・Step 2（右は Step 3' の帰納法）・`scalar_multiple_is_associative`・`finite_sum_of_scalar_multiples_of_one_matrix`・`def_finite_sum_of_complex_numbers_from_index_zero`）を、本文の定義どおり成分から組んだ行列（冪は `def_exp` (1) の `A^0 := I`、`A^{m+1} := A^mA`）で `M = 2, 3` の全ての `ε`、`K = 0..4` について `QQ` の厳密等号で一行ずつ。模型は Step 1 の検算と同じ。両端は Sage の演算（独立な経路）とも比べる。否定コントロール: 不定元の 2×2 行列 `X, Q` と不定元 `g`（`K = 2`）では Step 2（右は Step 3' の帰納法）を引く行だけが外れ、残り 7 行は成り立つ。1 行目と 2 行目は `E_K` の定義なので、2 行目と 3 行目・8 行目と 9 行目は添字をずらす定義の行で同じ項の並びから組むので、構成上かならず一致する（検算としては確かめていない） | **PASS** | 974 段（否定コントロールの 14 段を含む）、否定コントロール 2 行 |
| Step 3・Step 3' の極限 | check_eigenvalues_of_check_Vprime_step3_limit_chains.sage | `eigenvalues_of_check_Vprime` Step 3・Step 3' の極限の鎖。1 行目の `E_K → V̌'`（`‖E_K − V̌'‖` が `K ≥ 5` で狭義に減り `K = 20` で `10^{-8}` 未満）、「`(1/k!)z = z/k!` を各項へ」の行（`QQ` で厳密）、部分和の鎖の両端 `E_KQ̌_ε = Q̌_εE_K = (Σ_{k≤K}ǧ^k/k!)Q̌_ε`（`QQ` で厳密）、行列積の連続性の評価（左右の因子の両方）・`scalar_sequence_times_matrix_converges` の 2 行目の等号・`scalar_exp_is_limit_of_partial_sums` の極限（`K = 60` で `10^{-40}` 未満）・`complex_exp_of_real_argument`（`RealField(256)`・`ComplexField(256)`。ℝ への脱出: 極限と exp の値）。「`(1/k!)z = z/k!`」と `complex_exp_of_real_argument` の比較は Sage の中ではほぼ恒等的に成り立ち、写し間違いの検出だけに効く。模型に `ǧ(ε) < 0` の `ε` が在ることも確かめる（`real_exp_series_converges` を引いていた旧い行が覆わなかった場合）。`V̌'` は対角成分の実数の exp で組む（独立な経路）。`M = 2, 3`、全 `ε`、`K = 0..20` | PASS | 1044 の関係 |
| Step 4 の後半 | check_eigenvalues_of_check_Vprime_step4_eigenvector_chain.sage | `eigenvalues_of_check_Vprime` Step 4 の後半の鎖 `V̌'y = V̌'(Q̌_εy) = (V̌'Q̌_ε)y = ((exp ǧ)_ℂQ̌_ε)y = (exp ǧ)_ℂ(Q̌_εy) = (exp ǧ)_ℂy`（`y = Q̌_εx`）を、括弧どおりに一行ずつ厳密に。模型は check_25 と同じ `n_μ`・`Q̌_ε` に、`exp(γ_μ/2)` を不定元 `t_μ` に置いた `V̌' := Π_μ(t_μ^{-1}(I − n_μ) + t_μn_μ)`・`(exp ǧ(ε))_ℂ := Π_μt_μ^{2ε_μ−1}`（成分は有理関数体 `QQ(t)`。指数関数の値そのものは ℝ への脱出なので扱わず、鎖の形だけを確かめる）。鎖の仮定（前半の鎖の `Q̌_εy = y` と Step 3）が模型で成り立つことも確かめる。`M = 2, 3`、全 `ε`、有理数の `x` 2 本。否定コントロールとして、不定元の行列 `V, Q` と不定元 `e, y` では仮定を使う 3 行だけが外れ、`mat_mult_associative`・`scalar_multiple_factors_out_of_left_factor` の 2 行は成り立つことを確かめる。この 2 行は Sage の行列演算では構成上いつも成り立つので、写し間違いの検出だけに効く | PASS | 厳密等号 122 段（否定コントロールの 2 段を含む）、否定コントロール 3 行 |
| (1) の Λ^{(1/2)} の鎖 | check_max_eigenvalue_simple_step1_lambda_half_chain.sage | `max_eigenvalue_of_V_plus_simple` (1) の 4 行（`eigenvalues_of_V_plus` (2)・`θ̃_μ` の定義・`def_Theta_delta_M`（`δ → 1/2`）・`def_Lambda_delta_M`（`δ → 1/2`））。角の行は各項の角を π の有理数倍として `QQ` で厳密に、exp・arccosh・実数冪を含む行は `RealField(200)` で（ℝ 脱出: 超越関数の値）。`M_col = 2..8`、結合定数 4 組と臨界点。1 行目は `Λ̌_{(1,…,1)}` の定義の値と比べる。否定コントロール: `Λ^{(0)}_M`・前因子の冪を `M` にしたもの・和の `1/2` を落としたもの | PASS | 角の一致 35 項、隣どうしの行 140 段（差 `< 10^{-50}`）、否定コントロール 105 件 |
| (2) の狭義の不等号の鎖 | check_max_eigenvalue_simple_step2_strict_inequality_chains.sage | `max_eigenvalue_of_V_plus_simple` (2) の二つの鎖。`ǧ(1,…,1) − ǧ(ε)` の 10 行（`ǧ` の定義・`finite_sum_of_real_differences`・ℝ の分配法則・ℝ の計算・`a_μ` の置き方・`finite_sum_of_nonnegative_reals_is_at_least_each_term`・`a_μ` の置き方・`ε_{μ_0} = 0`・積の単位元・`gamma_theta_tilde_mu_positive`）を、等号の行は `γ_μ` を不定元に置いた `QQ` 上の多項式環で `M = 2..6`・`ε ≠ (1,…,1)` と `μ_0` を全列挙して恒等式として、不等号の行は `γ_μ` を正の有理数に置いて厳密に（鎖が使う `γ` の性質は `γ_μ > 0` だけ）。不等号の 2 行は、両辺の差が `Σ_{μ≠μ_0} a_μ` と `γ_{μ_0}` に恒等的に一致することも多項式環で確かめる。`Λ̌_ε` の 8 行と、物理の `γ(θ̃_μ) = arccosh(γ_1(θ̃_μ))` での `ǧ` の鎖の端は、結合定数 4 組（臨界点を含む）× `M = 2..6` で `RealField(200)`（ℝ 脱出: exp・arccosh・実数冪の値の比較）。`Λ̌_ε` の鎖の定義の展開の行（`Λ̌_ε`・`s_2`・`ǧ` の定義）は同じ定義から組むので構成上一致する。実質の比較は狭義不等号の行と、最後の行の `Λ̌_{(1,…,1)} = (2 sinh 2K_2)^{M/2}exp(½Σγ)`（`eigenvalues_of_V_plus` (2) の表式）である。否定コントロールとして、`γ_{μ_0} = 0` だと最後の狭義不等号が外れることを確かめる | **PASS** | 等号 3200 段（多項式環。差の恒等式を含む）、不等号 1920 段（正の有理数）、物理の結合定数で 476 通り |
| (3) の後半の固有空間の鎖 | check_max_eigenvalue_simple_step3_eigenspace_chains.sage | `max_eigenvalue_of_V_plus_simple` (3) の後半の 5 本の鎖を、括弧どおりに一行ずつ `QQ` で厳密に。`d(Q̌_{ε'}x) = O` の 4 行（`d` の置き方・`difference_of_scalar_multiples_of_one_matrix`・上の鎖の両端・`matrix_difference_zero_iff_equal`）、`Q̌_{ε'}x = O` の 5 行（`scalar_multiple_by_one`・`d^{-1}d = 1`・`scalar_multiple_is_associative`・上の鎖・`scalar_multiple_of_zero_matrix`）、`x = Q̌_{(1,…,1)}x` の 4 行（`identity_matrix_is_left_unit_of_mat_mult`・`check_joint_eigenspace_decomposition` (2)・`sum_over_binary_words_distributes_in_left_factor`・`sum_over_binary_words_with_one_nonzero_term`）、逆向きの `Q̌y = y` の 8 行と `V^{(+)}y = Λ̌_max y` の 6 行。模型は check_26 と同じ（Jordan–Wigner のフェルミ演算子からの `Q̌_ε`、`(1,…,1)` で狭義に最大な有理数 `Λ_ε` で `V := Σ_εΛ_εQ̌_ε`、`M = 2, 3, 4`、`ε' ≠ (1,…,1)` を全列挙）。否定コントロールとして、固有ベクトルでない `x` では差の鎖の 3 行目・割り算の鎖の 4 行目・項を消す行だけが、`im Q̌_{(1,…,1)}` に入らない `y` では `Q̌y = y` の最後の行だけが外れることを確かめる。`(Λ̌_{(1,…,1)}Q̌)y = (Λ̌_maxQ̌)y` の行は模型では `Λ̌_max := Λ̌_{(1,…,1)}` なので構成上成り立ち、写し間違いの検出だけに効く | **PASS** | 厳密等号 279 段、否定コントロール 12 件 |
| 逆行列の正定値性 | check_V_plus_inverse_positive_definite.sage | `V_plus_inverse_is_positive_definite`。本文の候補逆行列について全固有値の虚部が許容誤差以下で、実部がすべて正であることを独立検査 | PASS | 虚部の最大絶対値 `1.732e-14`、実部の最小値 `5.145e-4 > 0` |

## 結論

- `ň_μ = ψ̌_μ^† ψ̌_{1−μ}` は冪等かつ互いに可換で、`tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M−k}`（check_01）。
  対になる添字は `1−μ` であり、`−μ` では成り立たない。
- `Q̌_ε` は `2^M` 個の互いに直交する冪等元で、和が `I`、**各々の像は 1 次元**（check_02）。
  009 章の `2^{M−m}` 重の縮退は `m = M` により起こらない。
- `V^{(+)}` の固有値は `Λ̌_ε = (2 sinh 2K_2)^{M/2} exp(Σ_μ γ(θ~_μ)(ε_μ − 1/2))` で尽きる。
  `M = 2,3,4,5`・6 組の `(K_1,K_2)` すべてで、`2^M` 個の固有値全体が相対誤差 `9.0e-12` 以下で
  一致した（check_06）。
- `c = (2 sinh 2K_2)^{M/2}`（相対差 ≤ 4.3e-15、check_05）。009 章の証明経路
  （`tr(V)/tr(V^{−1}) = c²` と符号反転共役 `U`、正定値性からの符号確定）が
  `H_1^{(+)}` でもそのまま通ることを、実対称性と `U` 共役の残差 `0.0` で確認した。
- 本文で明示した候補 `R^{(+)}` が `V^{(+)}` の右逆かつ左逆であることを別々に検査し、
  右積は相対残差 `1.889e-11` 以下、左積は `2.197e-11` 以下で単位行列に一致した
  （check_07、check_08）。
- 候補逆行列の全固有値を独立に検査し、虚部の最大絶対値は `1.732e-14`、実部の最小値は
  `5.145e-4 > 0` だった（check_V_plus_inverse_positive_definite）。
- `Λ̌_max = Λ̌_{(1,…,1)} = Λ^{(1/2)}_M` が相対差 `0.0` で成立し、`γ(θ~_μ) > 0` により
  2 番目の固有値との相対差は `4.17e-1` 以上ある（＝**最大固有値は単純**、check_06）。
  これで `c_+(M) = Λ^{(1/2)}_M` を示す準備が整う。

## μ の量化範囲の絞り込み（2026-07-27）

`def_check_number_operator` の `ň_μ` を `ψ̌^†_μ ψ̌_{1−μ}` から `ψ̌^†_μ ψ̌_{M+1−μ}`
（`μ ∈ 𝓜̌ = {1,…,M}`）へ書き換え、017 章の全主張の量化範囲を `𝓜̌` に絞ったのに合わせて
`_prelude.sage` / check_01 を更新し、**再実行した**（`run-log.txt` はその出力）。

check_01 には次を追加してある。

- `def_check_index_set` (2) の `1 ≤ M+1−μ ≤ M` と対合 `M+1−(M+1−μ) = μ` を `assert` で確認。
- **書き換えの正当性** `ψ̌_{M+1−μ} = ψ̌_{1−μ}`（添字の周期性による）を残差で確認。

`check_number_operators_commute` で消えるデルタは、以前は
`δ^M_{(μ+(1−ν),1)} = δ^M_{(μ−ν,0)}` という合同式の書き換えを要したが、
`𝓜̌` に絞ったことで `δ_{M+1−ν, M+1−μ} = δ_{μ,ν} = 0`（`μ ≠ ν`）だけで済む。

## 実行

```bash
cd sagemath/check/050_claim_even_sector_eigenvalues
for f in check_0*.sage; do /usr/local/bin/sage "$f"; done
```

実行出力は `run-log.txt`。
