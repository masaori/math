# SageMath Check: check_joint_eigenspace_decomposition

## 対象

**対象ラベル**: `check_joint_eigenspace_decomposition`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_005_claim_check_joint_eigenspace_decomposition`（ε ∈ {0,1}^{M̌} について
  Q̌_ε := ∏_μ (ε_μň_μ + (1−ε_μ)(I − ň_μ)) と置くと、(1) Q̌_εQ̌_{ε'} = 0（ε ≠ ε'）、Q̌_ε^2 = Q̌_ε、(2) Σ_ε Q̌_ε = I、
  (3) ň_νQ̌_ε = Q̌_εň_ν = ε_νQ̌_ε、(4) tr(Q̌_ε) = 1、dim im Q̌_ε = 1、(5) ℂ^{2^{M_col}} = ⊕_ε im Q̌_ε）
- 範囲: 証明の全ての鎖（冒頭の定義の因子を R_μ^{(ε_μ)} で書く二場合の鎖と Q̌_ε = ∏R の鎖、Step 0〜Step 5 の全ての鎖）、
  鎖が引く主張の前提（可換性・冪等性）、主張 (1)〜(5) そのもの。
- 記号: R_μ^{(1)} := ň_μ、R_μ^{(0)} := I − ň_μ（証明の冒頭）。ň_μ := ψ̌_μ^†ψ̌_{σ(μ)}、σ(μ) := M_col + 1 − μ（`def_check_number_operator`）。

## ň_μ の供給元

全ての検算は ň_μ を `_number_operators.sage` の `number_operator_settings()` から取る。供給元は二つで、どちらでも同じ鎖の関数を通す。

- **既定（Jordan–Wigner の模型）**: 証明の鎖が ň_μ について使う性質は `check_number_operator_idempotent` (3)（ň_μň_μ = ň_μ）と
  `check_number_operators_commute` (2)（ň_μň_ν = ň_νň_μ）だけなので、二つを満たす n_μ := c_μ^Tc_μ（c_μ は Jordan–Wigner のフェルミ演算子）を
  `QQ` の行列で取る（M_col = 2, 3, 4）。「二つの性質さえ満たせば鎖が通る」ことを、本文の ψ̌ より大きい M_col = 4 まで示す。
- **本物の ψ̌（`check_with_check_psi.sage`）**: `USE_CHECK_PSI = True` と置いてから、同じ検算を全て読み込む。ň_μ は本文の ψ̌
  （`def_check_fermi` の式どおり、`../def_check_number_operator/_prelude.sage` の `NumberOperatorSetting`）から作り、全ての μ を一つの数体
  F := E_1 に移す（結合定数 3 組 × M_col = 2, 3）。移し方は `trace_of_check_number_operator_product/overview.md` の「計算の帰属と範囲」と同じで、
  F は体、F → QQbar の埋め込みで本物の値に移るので、F の中の等号・不等号は本物の値の等号・不等号である。

どちらの供給元でも、返す前に二つの性質と ň_μ ≠ O, I（等号が自明でないこと）を確かめる。
模型の n_μ は全て同じ基底で対角なので、可換性を使う行の等号は模型では自動的に成り立つ。可換性を使う行が意味を持つのは、
本物の ψ̌ で走らせる分と、可換でない族を使う否定コントロールである。

## 証明の行との対応

| 証明の行 | 検算 | 段数（模型） |
|---|---|---|
| 冒頭: 定義の因子 ε_μň_μ + (1−ε_μ)(I−ň_μ) = R_μ^{(ε_μ)} の二場合の 10 行の鎖（場合の仮定・`def_complex_difference`・`multiply_by_minus_one`・乗法の単位元／`complex_times_zero_is_zero`・加法の逆元／単位元・`scalar_multiple_by_one`・`zero_scalar_multiple_is_zero_matrix`・`matrix_plus_zero_matrix`／`zero_matrix_plus_matrix`・R の定義）、Q̌_ε = ∏(定義の因子) = ∏R の 2 行 | `check_factor_as_R_chains.sage` | 236 |
| Step 0 の冒頭の ň_μň_μ = ň_μ（5 行。冪は `def_exp` (1) どおり）、ň − ň = O の行（`matrix_difference_zero_iff_equal` の ⟸。3 か所とも同じ行）、和 R^{(1)} + R^{(0)} = I（`matrix_plus_difference_cancels`） | `check_step0_square_zero_difference_and_sum_chains.sage` | 79 |
| Step 0 の R^{(1)}R^{(0)} = 0・R^{(0)}R^{(1)} = 0（本文の 8 行のうち先頭の R の定義の行を除く 7 行）・R^{(0)}R^{(0)} = R^{(0)}（本文の 9 行のうち先頭を除く 8 行）、Step 3 の ε_ν = 0 の ň_νR_ν^{(0)} = 0（同じ 7 行） | `check_step0_step3_distributivity_chains.sage` | 217 |
| Step 0 の R^{(1)}R^{(1)} = R^{(1)}（本文の 3 行）は、Step 3 の ε_ν = 1 の場合の鎖の先頭 3 行と同じ式で、`check_step3_scalar_case_chains.sage` が確かめる | 同左 | — |
| Step 0 の異なる添字の因子の可換性（YI = Y = IY と、4 通りの上付き添字の組の鎖。`check_number_operators_commute` (2)・`commuting_with_difference`）、Step 1 の ε = ε' の Q̌_ε^2 の 8 行（`def_exp` (1)・`product_of_two_finite_products_of_matrices` とその前提・冪等性）、Step 3 の因子ごとの可換性の三つの場合と Q̌_εň_ν の 4 行（`matrix_commuting_with_each_factor_commutes_with_finite_product` を右辺から左辺へ） | `check_step0_commutation_step1_square_step3_chains.sage` | 1916 |
| Step 1 の ε ≠ ε' の鎖（μ = ν の可換性の 2 行と、Q̌_ε の定義・`moving_one_factor_of_finite_product_to_the_end`・結合律・Q̌_{ε'} の定義・`matrix_commuting_with_each_factor_commutes_with_finite_product`・`moving_one_factor_of_finite_product_to_the_end`・結合律・Step 0 の異なる上付き添字の積・`zero_matrix_is_right_zero_of_mat_mult` 2 回の 10 行。二つの主張の前提も）、Step 3 の ň_νQ̌_ε の 9 行（`scalar_multiple_factors_out_of_right_factor` を含む。∏_{μ≠ν} は `def_finite_product_of_matrices_omitting_one_index` どおり） | `check_step1_orthogonality_step3_moving_one_factor_chains.sage` | 8352 |
| Step 2 の鎖（分配による展開・Step 0 の和・`finite_product_of_identity_matrices`。和は Sage の sum） | `check_step2_identity_product_chain.sage` | 9 |
| Step 2 の鎖を、(2) の和を `def_sum_over_binary_words` どおりに組んで（Q̌_ε の定義・`expansion_of_finite_product_of_two_term_sums` を右辺から左辺へ・Step 0 の和・`finite_product_of_identity_matrices`） | `check_step2_expansion_over_binary_words.sage` | 12 |
| Step 3 の ε_ν = 1 の 5 行（`scalar_multiple_by_one` を右辺から左辺へ）と ε_ν = 0 の場合の末尾（`zero_scalar_multiple_is_zero_matrix` を右辺から左辺へ） | `check_step3_scalar_case_chains.sage` | 88 |
| Step 4 の tr(Q̌_ε) = 2^{M−M} = 2^0 = 1（`def_power_of_complex_number`）、Step 5 の全体を張る 3 行（`identity_matrix_is_left_unit_of_mat_mult`（n → 1）・(2)・`sum_over_binary_words_distributes_in_left_factor`（p → 1）。x の成分は不定元）、直和の鎖の 2・4 行目（`sum_over_binary_words_distributes_in_right_factor`・`zero_matrix_is_right_zero_of_mat_mult`（p → 1）） | `check_step4_step5_power_and_vector_chains.sage` | 177 |
| Step 5 の直和の鎖の 1 行目（`sum_over_binary_words_with_one_nonzero_term` を右辺から左辺へ）と、その前提の二つの 4 行の鎖（ε ≠ ε' の Q̌_{ε'}y_ε = O と Q̌_{ε'}y_{ε'} = y_{ε'}。y_ε = Q̌_εx_ε、x_ε の成分は不定元） | `check_step5_direct_sum_first_line.sage` | 1400 |
| Step 4 の dim im Q̌_ε = tr(Q̌_ε)（`trace_of_idempotent`）、主張 (1)〜(5) そのもの（証明の行を経ずに主張の式を直接比べる。dim im と (5) は体の上の rank で厳密に） | `check_claim_statements.sage` | 717 件 |
| Step 5 の「Q̌_εx ∈ im Q̌_ε」（`trace_of_idempotent` の im の定義そのもので、x を取れば Q̌_εx の形なので等号の検算が無い）と、末尾の「次元の整合」の段落（証明の推論に使われない注記。同じ内容の (5) の次元の和を `check_claim_statements.sage` が rank で確かめる） | 確かめない | — |

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| 上の表の 11 本（`check_with_check_psi.sage` 以外） | 模型の ň_μ（`QQ`、M_col = 2, 3, 4）で、上の表の全ての鎖と主張 | **PASS** | 鎖の等号 12486 段（10 本の合計。移す前の段数と一致）、主張 717 件、否定コントロール 23 件（鎖の検算 20 件・主張の検算 3 件） |
| `check_with_check_psi.sage` | 本物の ψ̌ の ň_μ（数体 F、結合定数 3 組 × M_col = 2, 3）で、上の 11 本を全て読み込んで走らせる | **PASS** | 鎖の等号 8998 段、主張 654 件、否定コントロール 35 件（内訳は下の「本物の ψ̌ での結果」） |

### 本物の ψ̌ での結果

結合定数 (x, y) = (2, 2), (3, 3/2), (5/4, 3) の 3 組 × M_col = 2, 3 の 6 組の ň_μ（数体 F の行列）で、上の 11 本を全て走らせた。全て PASS。

| 検算 | 本物の ψ̌ での段数 | 否定コントロール |
|---|---|---|
| `check_factor_as_R_chains.sage` | 364（語 36 個） | 2 |
| `check_step0_square_zero_difference_and_sum_chains.sage` | 127 | 1 |
| `check_step0_step3_distributivity_chains.sage` | 349 | 3 |
| `check_step0_commutation_step1_square_step3_chains.sage` | 1812 | 1 |
| `check_step1_orthogonality_step3_moving_one_factor_chains.sage` | 4896 | 1 |
| `check_step2_identity_product_chain.sage` | 18 | 1 |
| `check_step2_expansion_over_binary_words.sage` | 24 | 6 |
| `check_step3_scalar_case_chains.sage` | 142 | 2 |
| `check_step4_step5_power_and_vector_chains.sage` | 234 | 6 |
| `check_step5_direct_sum_first_line.sage` | 1032 | 6 |
| `check_claim_statements.sage` | 主張 654 件 | 6 |

鎖の等号は合計 8998 段。各段は本物の ň_μ の行列（不定元の数ベクトルを含む）の厳密な等号である。この VM で約 15 分かかる。

## 計算の帰属と範囲

- **厳密**: すべて。模型は `QQ`、本物の ψ̌ は数体 F、不定元の成分は `QQ` か F の上の多項式環の等号。浮動小数点は使わない。
- **ℝ への脱出**: 本物の ψ̌ の r_μ = |γ_2(θ̃_μ)| と (√M_col)_ℂ（ℝ_{≥0} の平方根）。どちらも代数的数として厳密に持つ（`def_check_number_operator` の検算の準備と同じ）。
- **作り方で自明な比較**（両辺を同じ Sage の式から作るので、本文の写し間違いだけを検出する）: 証明が
  「R_μ^{(e)} の定義（冒頭）」「Q̌_ε の定義（冒頭・主張）」「場合の仮定」「x_ε の取り方」「`def_exp` (1) の A^0 := I・A^{m+1} := A^mA」を根拠に引く行は、
  検算が R・Q̌・冪・y_ε をその定義どおりに組むので、全ての検算で作り方で自明である（例: Step 0 の 4 通りの可換性の鎖の先頭と末尾、
  Step 1 の Q̌^2 の 1〜3 行目と「Q̌ の定義を 2 か所」の行と最後の行、Step 3 の μ = ν、ε_ν = 1 の 2 行の鎖の全体、
  Step 3 の ε_ν = 0 の R^{(0)} の定義と場合の仮定の行、Step 5 の直和の前提の鎖の「x_ε の取り方」の行）。この規則の外の自明な比較は次だけである:
  冒頭の二場合の鎖のスカラーの行（スカラーの鎖は `QQ[i]` の元で行ごとに別に確かめる）、
  Step 4 の 2^{M−M} = 2^0 の行（M − M は Sage の整数の 0 として計算されるので両辺が同じ値）、Step 5 の直和の鎖の 3 行目（仮定 Σ_ε y_ε = O の代入）。
- **否定コントロール**: 各検算のとおり（冪等でない不定元の 2×2 行列では冪等性を使う行だけが外れる、可換でない族では積を並べ替える行が外れる、
  R^{(0)} を別の行列に替えると和・直交性・次元の行が外れる、など）。鎖の検算のうち 6 本の否定コントロールは `QQ` 上の不定元・固定の行列で作り、`check_step2_expansion_over_binary_words.sage`・
  `check_step4_step5_power_and_vector_chains.sage`・`check_step5_direct_sum_first_line.sage`・`check_claim_statements.sage` の否定コントロールは供給元の ň_μ と体 F で作る
  （本物の ψ̌ で走らせると、これらの件数は ň_μ の組の数だけ増える）。
- 範囲外: 本物の ψ̌ の M_col ≥ 4（σ の対が二組になり平方根が二つ要るうえ、ψ̌ を作るだけで重い。`check_number_operator_idempotent` の overview を見よ）。
  M_col = 4 の鎖は模型の検算が受け持つ。模型の M_col ≥ 5 も範囲外。

## 由来

2026-11-04 まで、この主張の検算は `050_claim_even_sector_eigenvalues/` の番号付きの検算にあった（そのディレクトリの対象ラベルは
`eigenvalues_of_V_plus` だけなので、この主張は未検算に数えられていた）。移すときに ň_μ の作り方を `_number_operators.sage` へ出し
（模型の作り方は不変）、使わなくなったクロネッカー積の関数を消し、成分の体を供給元の体 F で組むようにした。鎖の各行の式は変えていない。

| いまの名前 | 旧い名前 |
|---|---|
| `check_factor_as_R_chains.sage` | `check_48_joint_eigenspace_factor_as_R_chains.sage` |
| `check_step0_square_zero_difference_and_sum_chains.sage` | `check_30_joint_eigenspace_step0_square_inverse_and_sum_chains.sage` |
| `check_step0_step3_distributivity_chains.sage` | `check_24_joint_eigenspace_distributivity_chains.sage` |
| `check_step0_commutation_step1_square_step3_chains.sage` | `check_34_joint_eigenspace_commutation_and_square_chains.sage` |
| `check_step1_orthogonality_step3_moving_one_factor_chains.sage` | `check_35_joint_eigenspace_moving_one_factor_chains.sage` |
| `check_step2_identity_product_chain.sage` | `check_32_joint_eigenspace_step1_step2_zero_and_identity_products.sage` |
| `check_step2_expansion_over_binary_words.sage` | `check_33_joint_eigenspace_step2_expansion_over_binary_words.sage` |
| `check_step3_scalar_case_chains.sage` | `check_31_joint_eigenspace_step3_scalar_chains.sage` |
| `check_step4_step5_power_and_vector_chains.sage` | `check_36_joint_eigenspace_step4_step5_power_and_vector_chains.sage` |
| `check_step5_direct_sum_first_line.sage` | `check_joint_eigenspace_step5_direct_sum_first_line.sage` |
| `check_claim_statements.sage`、`check_with_check_psi.sage`、`_number_operators.sage` | 新しく足した |

(1)〜(5) を浮動小数点（特異値による rank の判定）で確かめた `050_claim_even_sector_eigenvalues/check_02_joint_eigenspace.sage` は、
そこに残した。同じ内容を `check_claim_statements.sage` が厳密に確かめる。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh check_joint_eigenspace_decomposition
# 個別（本物の ψ̌ の検算は M_col を引数で絞れる）
cd sagemath/check/check_joint_eigenspace_decomposition && sage check_with_check_psi.sage 2 3
```
