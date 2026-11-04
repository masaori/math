# SageMath Check: sign_flip_conjugation

## 対象

**対象ラベル**: `sign_flip_conjugation`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `eigenvalues_of_V_016_claim_sign_flip_conjugation`（符号反転共役 `U := EF` は可逆で、`US_1^{(+)}U^{-1} = -S_1^{(+)}`、`US_2U^{-1} = -S_2`、すなわち `UH_1^{(+)}U^{-1} = -H_1^{(+)}`、`UH_2U^{-1} = -H_2`）
- 範囲: 主張と、証明の Step 0〜Step 4 の全ての鎖と最後の段落

## 証明の行との対応

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_step3_term_chains_three_line_form.sage` | `sign_flip_conjugation` の Step 3 の二つの鎖（`U(Y_jZ_k)U^{-1} = Y_j(-Z_k) = -(Y_jZ_k)`、`U(Z_jY_j)U^{-1} = (-Z_j)Y_j = -(Z_jY_j)`）を一行ずつ。`QQ(i)` の厳密計算、`M = 2,3,4` の全ての `j, k`、符号反転は `def_matrix_negation` のとおり成分ごと。否定コントロール 1 件 | PASS | 114 段、全段で厳密に一致 |
| `check_step3_T_U_rows_and_step4_chains.sage` | `sign_flip_conjugation` の Step 3 の「`conjugation_is_ring_homomorphism` の `T_B` の定義 → 乗法性 → `T_B` の定義」の三行（二つの鎖とも）と、Step 4 の二つの六行の鎖（`S` の定義・`scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor`・Step 3・`scalar_multiple_of_negated_matrix`・`S` の定義）を一行ずつ。`QQ(i)` の厳密計算、`M = 2,3,4`、`UXU^{-1}` は本文どおり `(UX)U^{-1}`、`K_1, K_2^*` は正の有理数の代表値、符号反転とスカラー倍は成分ごと。否定コントロール 1 件 | PASS | 150 段、全段で厳密に一致 |
| `check_step0_site_square_chains.sage` | `sign_flip_conjugation` の Step 0 の鎖 `σ_m^aσ_m^a = I_{Mat(2^{M_col},ℂ)}`（`a ∈ {x, z}`）の 5 行（`def_site_pauli_matrices`・`kronecker_product_rule` (1)・`pauli_matrix_products`・`identity_matrix_is_left_unit_of_mat_mult`・`kronecker_product_rule` (2)）を一行ずつ。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての `m`、クロネッカー積は `def_kronecker` の成分の式で作り Sage の `tensor_product` と突き合わせる。否定コントロール 1 件 | PASS | 90 段、全段で厳密に一致 |
| `check_step1_F_conjugation_x_z_chains.sage` | `sign_flip_conjugation` の Step 1 の `σ_k^zσ_k^x = -(σ_k^xσ_k^z)` の 10 行の鎖（`def_site_pauli_matrices`・`kronecker_product_rule` (1)・`identity_matrix_is_left_unit_of_mat_mult`・`pauli_matrix_products`・`negation_is_scalar_multiple_by_minus_one`・`kronecker_multilinear`・その逆向き）と、`Fσ_k^xF^{-1}`（`(σ_k^zσ_k^x)σ_k^z` から 5 行）・`Fσ_k^zF^{-1}`（2 行）の鎖を一行ずつ。旧版の本文の 1 行目（`k` 以外のサイトの因子は可換）を `F = ∏σ_m^z`・`F^{-1} = F` から組んで比べる段も残す（いまの本文の鎖の先頭、`W` の鎖と `(σ_k^pσ_k^a)σ_k^p` の鎖は `check_step1_W_conjugation_chains.sage` が受け持つ）。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての `k`、符号反転とスカラー倍は成分ごと。否定コントロール 1 件 | PASS | 171 段、全段で厳密に一致 |
| `check_step1_F_conjugation_y_chain.sage` | `sign_flip_conjugation` の Step 1 の `σ_k^pσ_k^q = -(σ_k^qσ_k^p)` の 10 行の鎖を `(p, q) = (z, x), (y, z)` の両方で、`Fσ_k^yF^{-1}` の鎖（`(σ_k^zσ_k^y)σ_k^z` から `mat_mult_associative`・上の鎖の `(y, z)`・`negation_factors_out_of_right_factor`・`mat_mult_associative`・Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 6 行）を一行ずつ。旧版の本文の 1 行目（`k` 以外のサイトの因子は可換）を `F = ∏σ_m^z`・`F^{-1} = F` から組んで比べる段も残す（いまの本文の鎖の先頭、`W` の鎖と `(σ_k^pσ_k^a)σ_k^p` の鎖は `check_step1_W_conjugation_chains.sage` が受け持つ）。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての `k`、符号反転とスカラー倍は成分ごと。否定コントロール 1 件 | PASS | 243 段、全段で厳密に一致 |
| `check_step1_E_conjugation_chains.sage` | `sign_flip_conjugation` の Step 1 の `σ_k^pσ_k^q` の 10 行の鎖を足した組 `(p, q) = (y, x)` で、`k` が奇数のときの `Eσ_k^xE^{-1}` の鎖（Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 2 行）と `Eσ_k^aE^{-1}`（`a = y, z`）の鎖（`(σ_k^xσ_k^a)σ_k^x` から `mat_mult_associative`・上の鎖の `(a, x)`・`negation_factors_out_of_right_factor`・`mat_mult_associative`・Step 0・`identity_matrix_is_left_unit_of_mat_mult` の 6 行）を一行ずつ。旧版の本文の 1 行目（第 `k` 因子だけが効く）を `E = ∏_{m 奇数}σ_m^x`・`E^{-1} = E` から組んで比べる段も残す（いまの本文の鎖の先頭は `check_step1_W_conjugation_chains.sage` が受け持つ）。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての奇数 `k`。否定コントロール 1 件 | PASS | 135 段、全段で厳密に一致 |
| `check_step0_invertibility_chains.sage` | `sign_flip_conjugation` の Step 0 の可逆性の鎖。`E_mE_m = σ^xσ^x = I`（`m` 奇数）・`E_mE_m = II = I`（`m` 偶数）、`FF = I`・`EE = I` の 4 行ずつ（`F`・`E` の定義・`kronecker_product_rule` (1)・`pauli_matrix_products` / 上の `E_mE_m = I`・`kronecker_product_rule` (2)）、`def_invertible_elements_of_R` (ii) の証明の 6 行ずつを `g_1 = E`・`g_2 = F` で、`U^{-1} = F^{-1}E^{-1} = FE^{-1} = FE` を Sage の逆行列と突き合わせる。クロネッカー積の `E`・`F` が旧定義の行列の積 `∏_{m 奇数}σ_m^x`・`∏_mσ_m^z` と一致することも確かめる。`QQ(i)` の厳密計算、`M = 2,3,4,5`。否定コントロール 1 件 | PASS | 120 段、全段で厳密に一致 |
| `check_step1_W_conjugation_chains.sage` | `sign_flip_conjugation` の Step 1 の先頭の 3 本の鎖を一行ずつ。`Wσ_k^aW^{-1} = I⊠⋯⊠((W_kσ^a)W_k)⊠⋯⊠I`（`W ∈ {E, F}`、Step 0 の `W^{-1} = W`・`W` の定義・`def_site_pauli_matrices`・`kronecker_product_rule` (1) 2 回・`identity_matrix_is_right_unit_of_mat_mult`・Step 0 の `W_mW_m = I` の 7 行）、`I⊠⋯⊠((σ^pσ^a)σ^p)⊠⋯⊠I = (σ_k^pσ_k^a)σ_k^p`（`p ∈ {x, z}`、5 行）、`k` 偶数の `I⊠⋯⊠((E_kσ^a)E_k)⊠⋯⊠I = σ_k^a`（4 行）。`F`・`E` の鎖の 1 行目の結論の符号も突き合わせる。`QQ(i)` の厳密計算、`M = 2,3,4`、全ての `k` と `a ∈ {x, y, z}`。否定コントロール 1 件 | PASS | 690 段、全段で厳密に一致 |
| `check_step1_composition_chains.sage` | `sign_flip_conjugation` の Step 1 の合成の段を一行ずつ。合成の鎖 `UXU^{-1} = E(FXF^{-1})E^{-1}`（`U` の定義・Step 0 の `U^{-1} = FE`・`mat_mult_associative` 3 回・Step 0 の `F^{-1} = F`・`E^{-1} = E` の 7 行。成分を不定元に置いた `X` と全ての `σ_k^a` で）と、`a = x, y, z` の鎖（上の `F` の式・`negation_factors_out_of_right_factor`・`negation_factors_out_of_left_factor`・`E` の式（`k` の偶奇）・`k` 奇数の `σ^y` で `matrix_double_negation`）。否定コントロールとして、`U^{-1}` を `EF` と取り違えると合成の鎖の 3 行目の符号反転になり一致しないことを確かめる | PASS | `M = 2, 3, 4`、全ての `k`、`QQ(i)` と `QQ(i)` 上の多項式環で厳密等号（336 段） |
| `check_step2_Z_Y_chains.sage` | `sign_flip_conjugation` の Step 2 を一行ずつ。`P_0 := I`・`P_{r+1} := P_rσ_{r+1}^x` の `UP_rU^{-1}` の帰納法（`r = 0` の 4 行: `P_0` の定義・`T_B` の定義・`conjugation_is_ring_homomorphism` の単位性・`P_0` の定義。帰納法の段の 10 行: `P_{r+1}` の定義・`T_B` の定義・乗法性・`T_B` の定義・Step 1 の `Uσ_k^xU^{-1} = -σ_k^x`・`negation_factors_out_of_right_factor`・帰納法の仮定・`r` 奇数の `negation_factors_out_of_left_factor`・`matrix_double_negation`・`P_{r+1}` の定義）と、`Z_m`・`Y_m` の鎖（`T_B` の定義・乗法性・`T_B` の定義の 3 行・`UP_rU^{-1}` を `r = m-1` で・Step 1 の `Uσ_m^aU^{-1}`・符号の外出し・`Y_m` の `m` 偶数で `matrix_double_negation`）。`Z_m`・`Y_m` を定義の積 `σ_1^x⋯σ_{m-1}^xσ_m^a` から作り `P_{m-1}σ_m^a` と突き合わせる。否定コントロールとして、Step 1 の `Uσ_k^xU^{-1}` の符号を落とすと `UP_1U^{-1} = -P_1` と一致しないことを確かめる | PASS | `M = 2, 3, 4, 5`、全ての `r`・`m`、`QQ(i)` で厳密等号（436 段） |
| `check_step3_H2_chain.sage` | `sign_flip_conjugation` の Step 3 の `H_2` の鎖を一行ずつ。項の鎖 `U(Z_jY_j)U^{-1} = -(Z_jY_j)`（`T_B` の定義・乗法性・`T_B` の定義・Step 2・`negation_factors_out_of_left_factor` の 5 行）と、`UH_2U^{-1}` の 7 行（`def_H2`・`T_B` の定義・`matrix_conjugation_preserves_finite_sum`・`T_B` の定義を各項に・項の鎖・`finite_sum_of_negated_matrices`・`def_H2`）。有限和は `def_finite_sum_of_matrices` のとおり左から足す。否定コントロールとして、項の鎖の 4 行目で `UZ_jU^{-1}` を `+Z_j` と取り違えると、その行も和も右端と一致しないことを確かめる | PASS | `M = 2, 3, 4, 5`、全ての `j`、`QQ(i)` で厳密等号（98 段） |
| `check_step3_H1plus_chain.sage` | `sign_flip_conjugation` の Step 3 の `H_1^{(+)}` の鎖を一行ずつ。項の鎖 `U(Y_jZ_k)U^{-1} = -(Y_jZ_k)`（`T_B` の定義・乗法性・`T_B` の定義・Step 2・`negation_factors_out_of_right_factor` の 5 行、全ての `j, k`）と、`UH_1^{(+)}U^{-1}` の 9 行（`def_H1_plus`・`T_B` の定義・`matrix_conjugation_preserves_difference`・`matrix_conjugation_preserves_finite_sum`・`T_B` の定義を各項と引く項に・項の鎖・`finite_sum_of_negated_matrices`・`difference_of_negated_matrices`・`def_H1_plus`）。有限和は `def_finite_sum_of_matrices` のとおり左から足し、差は成分ごとに取る。否定コントロールとして、`(-A)-(-B)` を `-(A+B)` と取り違えると右端と一致しないこと、項の鎖で `UZ_kU^{-1}` を `+Z_k` と取り違えると一致しないことを確かめる | PASS | `M = 2, 3, 4, 5`、全ての `j, k`、`QQ(i)` で厳密等号（306 段） |
| `check_claim_statement_and_step4_equivalence.sage` | 主張そのものと Step 4 の最後の段落。主張の定義どおりに `E_m`・`E := E_1⊠⋯⊠E_{M_col}`・`F := σ^z⊠⋯⊠σ^z`・`U := EF` を組み、`det U ≠ 0`、Sage の逆行列が Step 0 の `U^{-1} = FE` と一致すること、`UH_1^{(+)}U^{-1} = -H_1^{(+)}`・`UH_2U^{-1} = -H_2`（`Z_m`・`Y_m` は Jordan–Wigner の左から掛けた積、逆行列は Sage の計算で、証明の鎖とは別の経路）、`K_1`・`K_2^*` を不定元にした `US_1^{(+)}U^{-1} = -S_1^{(+)}`・`US_2U^{-1} = -S_2`。最後の段落の「逆に」の向きは、正の有理数 `K`（実数の代表）で `a := iK ≠ 0`・`a^{-1} = (-i)K^{-1}` とし、`UHU^{-1} = a^{-1}(a(UHU^{-1})) = a^{-1}((U(aH))U^{-1}) = a^{-1}(-(aH)) = -H` を一行ずつ。否定コントロール: `F` だけの共役は `H_1^{(+)}` の符号を反転しない、`E` だけの共役は `H_2` の符号を反転しない、`a = 0` なら `S` の等式は `F` でも成り立つが `H` の等式は成り立たない（最後の段落が `a ≠ 0` を要ること） | **PASS** | `M_col = 2..6`（不定元の `S` の等式は `2..5`）、`QQ(i)` と `QQ(i)[K_1, K_2^*]` で厳密等号 218 段、否定コントロール 15 件 |

Step 4 の最後の段落は本文では文章だけで書かれており、`check_claim_statement_and_step4_equivalence.sage` の (d) の 5 行の鎖は、その「逆に」の向きを検算の側で鎖に組んだものである（本文の行と 1 対 1 ではない）。

確かめていない行: Step 0 の「逆元の一意性より `F^{-1} = F`、`E^{-1} = E`」の段落（`def_invertible_elements_of_R` の条件を述べるだけで、条件 `FF = EE = I` と `U^{-1} = FE` は `check_step0_invertibility_chains.sage` と `check_claim_statement_and_step4_equivalence.sage` が Sage の逆行列と突き合わせる）。

## 計算の帰属と範囲

- **厳密**: 全てのファイルが `QQ(i)`（ガウス有理数体）またはそれを係数とする多項式環の上の厳密等号で確かめる。係数 `K_1`・`K_2^*` は不定元か正の有理数（実数の代表）である。浮動小数点と ℝ/ℂ への脱出はない。
- 範囲: `M_col` はファイルごとに表の範囲（`2..4` から `2..6`）。主張は全ての `M_col ≥ 2` についてのものなので、有限個の `M_col` での確認である。
- 本文の改稿に合わせて足した経緯から、同じ行を 2 本のファイルが確かめるところがある。`check_step3_term_chains_three_line_form.sage` は Step 3 の項の鎖の旧い 3 行の形で、いまの 5 行の形は `check_step3_H2_chain.sage`・`check_step3_H1plus_chain.sage` が確かめる。`check_step1_F_conjugation_x_z_chains.sage`・`check_step1_F_conjugation_y_chain.sage`・`check_step1_E_conjugation_chains.sage` の「旧版の本文の 1 行目」の段は、いまの本文の鎖の先頭（`check_step1_W_conjugation_chains.sage`）と同じ行列を別の組み方で比べる。
- Sage は行列の積をその場で計算するので、`identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`・`mat_mult_associative`・定義を書くだけの行の比較は構成上かならず一致し、写し間違いの検出だけに効く。中身は各ファイルの否定コントロールが確かめる。

## 由来

この 12 本は、2026-11-02 に `050_claim_even_sector_eigenvalues/` の番号付きの検算として足したものを、2026-11-03 にこのディレクトリへ移した（検算の中身は変えていない。コメントが旧い名前で指していた 4 か所だけを新しい名前に直した）。旧い記録（本文の `conversion.notes`・`MEMORY.md`・Lean の状態台帳）の「050 の check_17」などは、ここの同じ内容のファイルを指す。

| 旧い名前 | このディレクトリの名前 |
|---|---|
| `check_09_sign_flip_step3_chains.sage` | `check_step3_term_chains_three_line_form.sage` |
| `check_11_sign_flip_step3_step4_conjugation_chains.sage` | `check_step3_T_U_rows_and_step4_chains.sage` |
| `check_12_sign_flip_step0_site_square_chains.sage` | `check_step0_site_square_chains.sage` |
| `check_13_sign_flip_step1_F_conjugation_chains.sage` | `check_step1_F_conjugation_x_z_chains.sage` |
| `check_14_sign_flip_step1_F_conjugation_sigma_y_chain.sage` | `check_step1_F_conjugation_y_chain.sage` |
| `check_15_sign_flip_step1_E_conjugation_chains.sage` | `check_step1_E_conjugation_chains.sage` |
| `check_16_sign_flip_step0_E_F_U_invertibility_chains.sage` | `check_step0_invertibility_chains.sage` |
| `check_17_sign_flip_step1_W_conjugation_chains.sage` | `check_step1_W_conjugation_chains.sage` |
| `check_18_sign_flip_step1_composition_chains.sage` | `check_step1_composition_chains.sage` |
| `check_19_sign_flip_step2_Z_Y_chains.sage` | `check_step2_Z_Y_chains.sage` |
| `check_20_sign_flip_step3_H2_chain.sage` | `check_step3_H2_chain.sage` |
| `check_21_sign_flip_step3_H1plus_chain.sage` | `check_step3_H1plus_chain.sage` |

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sign_flip_conjugation
```

実行ログは `logs/` に保存する。
