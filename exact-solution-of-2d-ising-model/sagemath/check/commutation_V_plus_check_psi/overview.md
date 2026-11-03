# SageMath Check: commutation_V_plus_check_psi

## 対象

**対象ラベル**: `commutation_V_plus_check_psi`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `evenfermi_004_claim_commutation_V_plus_psi`（V^{(+)} と ψ̌ の交換関係 T_{(V^{(+)})}(ψ̌_μ^†) = (exp(+γ(θ̃_μ)))_C ψ̌_μ^†、T_{(V^{(+)})}(ψ̌_μ) = (exp(−γ(θ̃_μ)))_C ψ̌_μ）
- 範囲: 証明の準備 1〜3 の鎖、本体の 17 式の鎖、成分を取り出す二本の鎖（exp の行を除く各 4 式）、主張そのもの

## 証明の行との対応

`T := T_{(V^{(+)})}`、`pr_l(Y_1, Y_2) := Y_l`。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 1 の 6 式（`def_pair_of_matrices_times_two_by_two_matrix`・`pr_l`・`def_pair_of_matrices_times_column_of_numbers`・`def_finite_sum_of_matrices` の r = 1 と r+1） | `check_preparations_generic.sage` | 各式を本文の成分の式で別々に組み、隣り合う式が多項式として等しい。終点を Sage の `g_{1l}X_1 + g_{2l}X_2` と比べる。対照: 行で読んだ `g_{l1}X_1 + g_{l2}X_2` とは異なる | **PASS** | X_1, X_2 ∈ Mat(4,ℂ) と G の成分を QQ 上の独立な不定元に取り、l = 1, 2 |
| 準備 2 の 10 式の鎖（準備 1、`finite_sum_of_scalar_multiples`、`scalar_multiple_is_associative`、`finite_double_sum_of_matrices_interchange`、`finite_sum_of_scalar_multiples_of_one_matrix`、ℂ の乗法の可換則、`mat_mult`、準備 1）と組の 3 式 | `check_preparations_generic.sage` | 同上。終点を Sage の行列積 GH による `(GH)_{1l}X_1 + (GH)_{2l}X_2` と比べる。対照: `(X_1, X_2)(HG)` とは異なる | **PASS** | 同上（G, H の成分も不定元） |
| 準備 3 の 6 式の鎖（準備 1、`T_V_plus_is_conjugation`、`linearity_of_T`、`T_V_plus_is_conjugation`、準備 1）と組の 3 式 | `check_linearity_lift.sage` | T を `def_T_V_plus` の三つの共役の合成で、T_{V^{(+)}} を `def_V_plus` の V^{(+)} = (SV_2)S による `(V^{(+)}X)(V^{(+)})^{-1}` で作り、各式を別々に組んで等しい。対照: G を転置して読んだ値とは異なる | **PASS** | 結合定数 3 組 × M_col = 2, 3 × 全 μ、X_1, X_2 は (Ž_μ, Y̌_μ) と乱択行列の組、G の成分は E 上の不定元。数体 E の中で厳密 |
| 本体の 17 式（`def_check_fermi`、準備 3、`T_V_plus_check_Z_Y`、準備 2、`diagonalization_check_P_D`、`mat_mult_associative`、`def_invertible_elements_of_R`、`identity_matrix_is_right_unit_of_mat_mult`、準備 2、`def_check_fermi`、`pr` の定め方、準備 1、Ď の成分、`zero_scalar_multiple_is_zero_matrix`、`matrix_plus_zero_matrix`、`zero_matrix_plus_matrix`） | `check_main_chain.sage` | 各式を別々に組んで、隣り合う組が等しい。第 1 式の ψ̌ は `def_check_fermi` の第二の式（P̌ との積を使わない形）で、A(θ̃_μ) は `def_A_theta` の成分の式で、P̌_μ・Ď_μ・λ_{±,μ} は `diagonalization_check_P_D`・`eigenvector_of_A_theta_tilde` の式で作る。P̌^{-1} は Sage の inverse で作り、P̌^{-1}P̌ = P̌P̌^{-1} = I を本文の積で確かめる | **PASS** | 結合定数 3 組 × M_col = 2, 3, 4 × 全 μ。数体 E の中で厳密 |
| 成分を取り出す二本の鎖（`pr_l` の定め方、本体の鎖、`pr_l` の定め方） | `check_main_chain.sage` | 各式が等しい | **PASS** | 同上 |
| 二本の鎖の最終行（`lambda_eq_exp_gamma_theta_tilde`） | `check_main_chain.sage` | `def_arccosh` の arccosh(g) = log(g + √(g²−1)) から exp(±γ) = γ_1 ± √(γ_1²−1) を AA で λ_{±,μ}（r_μ > 0 の値）と比べ、RealBallField（256 ビット）の exp(±acosh γ_1) が λ_{±,μ} を囲むことも見る。対照: exp(+acosh γ_1) は λ_− を囲まない | **PASS** | 同上 |
| 主張 | `check_main_chain.sage` | Sage の積・inverse・スカラー倍で作った V^{(+)}ψ̌(V^{(+)})^{-1} が λ_{±,μ}ψ̌ に等しい。対照: T(ψ̌^†) ≠ λ_−ψ̌^†、(Ž, Y̌)(P̌A) ≠ (Ž, Y̌)(AP̌)、行で読んだ組の積は第 2 式と異なる | **PASS** | 同上 |

## 計算の帰属と範囲

- 共通の準備は `_prelude.sage` と `_shared/transfer_factor_actions_on_check_Z_Y.sage`（`calc_of_TxT_check_Z_Y` の検算と共有）。
  K_1 = 2 log y、K_2 = log x（x, y ∈ QQ_{>1}）と選ぶと、S = exp(X)（`def_V1_plus_square_root`）・V_2・c_1, s_1, c_2, c_2^*, s_2^*・位相が
  一つの数体 F = QQ(ζ_{4M}, √(2s_2), √t) に入る。σ = (√M_col)_C も F に入る。r_μ = |γ_2(θ̃_μ)| は n_μ := γ_2 conj(γ_2) ∈ F の平方根で、
  F に無ければ E := F(R)、R² = n_μ に持つ。R ↦ ±r_μ のどちらの取り方も E の自己同型で移り合うので、等号はどちらでも同じに判定される。
  r_μ > 0 を使う行（λ_+ と exp(+γ) の対応）だけは AA の値で確かめる。
- 結合定数は (x, y) = (2, 2), (3, 3/2), (5/4, 3) の 3 組。
- ℝ への脱出は K_1・K_2 の選び方、σ・r_μ（ℝ_{≥0} の平方根）、exp(±γ(θ̃_μ))（実数の exp）だけである。前の二つは代数的数として厳密に持ち、
  exp(±γ) は def_arccosh により代数的数 γ_1 ± √(γ_1²−1) と比べる。ボールは exp と acosh の値の照合にだけ使う。
- 範囲外: 準備 3 の M_col ≥ 4、本体の M_col ≥ 5、log の形でない K_1・K_2。

## 確かめられない行と理由

作り方から必ず通る遷移（両側を同じ式から組んでいるので、配置の写ししか確かめていない）:

- 準備 1 の全ての遷移（定義の展開と `pr_l`。左から順に足す有限和の 1 項・2 項）。値として独立なのは終点と Sage の `g_{1l}X_1 + g_{2l}X_2` の比較と、行で読んだ対照である。
- 準備 2 の第 1 式 → 第 2 式と第 9 式 → 第 10 式（準備 1 の当てはめ）、第 7 式 → 第 8 式（ℂ の乗法の可換則。不定元の多項式環が可換なので同じ多項式になる）。
- 準備 3 の第 1 式 → 第 2 式と第 5 式 → 第 6 式（準備 1 の当てはめ）。
- 本体の第 1 式 → 第 2 式（`def_check_fermi`。ψ̌ を第二の式で、第 2 式を組と P̌ の積で作るが、どちらも同じ E の元 −r/(2σb)・1/(2σ) を係数に使う。第 10 式 → 第 11 式も同じ）、第 11 式 → 第 12 式・第 12 式 → 第 13 式（`pr` と準備 1）、第 13 式 → 第 14 式（Ď の成分。Ď を λ_± から組んでいる）。
- 成分を取り出す鎖の第 1 式 → 第 2 式と第 3 式 → 第 4 式（`pr` の定め方）。

値として独立に確かめている遷移:

- 準備 2 の第 2 式 → 第 7 式（和とスカラー倍の 4 本の主張）と、終点と Sage の行列積 GH による値の比較。
- 準備 3 の第 2 式 → 第 5 式（`T_V_plus_is_conjugation`：三つの共役の合成と V^{(+)} による共役の一致、`linearity_of_T`）。
- 本体の第 2 式 → 第 10 式（準備 3・`T_V_plus_check_Z_Y`・準備 2・`diagonalization_check_P_D`・P̌^{-1}P̌ = I・単位行列）、第 14 式 → 第 17 式（零行列）、主張と Sage の演算による値の比較、対照、exp の行。

引いた主張の当てはめで、具体値で両辺の一致を見るにとどまる行: 本体の第 3 式 → 第 4 式（`T_V_plus_check_Z_Y`）、第 5 式 → 第 6 式（`diagonalization_check_P_D`）、成分の鎖の最終行（`lambda_eq_exp_gamma_theta_tilde`）。それらの主張の証明はそれぞれの検算が確かめる。

主張の全ての μ・M_col・K_1・K_2 への一般化は確かめられない。範囲は表の「結果」のとおり。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh commutation_V_plus_check_psi
```

`check_linearity_lift.sage`・`check_main_chain.sage` は引数で M_col を絞れる（既定はそれぞれ 2 3 と 2 3 4）。実行ログは `logs/` に保存する。
