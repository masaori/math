# SageMath Check: T_V_plus_eq_T_check_Vprime_on_check_Z_Y

## 対象

**対象ラベル**: `T_V_plus_eq_T_check_Vprime_on_check_Z_Y`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `evenfermi_007_claim_T_eq_on_check_Z_Y`（T_{(V^{(+)})} と T_{(V̌')} は Ž_μ, Y̌_μ 上で一致する）
- 範囲: 証明の準備 1（7 個の等号）、準備 2 の δ の鎖（2 個）と本体の鎖（14 個）、本体の鎖（10 個の等号、l = 1, 2）、主張そのもの。
  準備 3 は等号の鎖を持たない。そこで読む `T_{(V^{(+)})} = T_{V^{(+)}}`・`T_{(V̌')} = T_{V̌'}` は、本体の第 2・第 4・第 7・第 9 等号の検算に入る。

## 証明の行との対応

記号は証明のもの: `X_1 := Ž_μ`、`X_2 := Y̌_μ`、`Ψ_1 := ψ̌_μ^†`、`Ψ_2 := ψ̌_μ`、`p_{kl} := (P̌_μ)_{kl}`、`q_{kl} := (P̌_μ^{-1})_{kl}`。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 1 の 7 個の等号（`pr_k`、`def_check_fermi`、`def_pair_of_matrices_times_two_by_two_matrix`、`pr_k`、`def_pair_of_matrices_times_column_of_numbers`、`def_finite_sum_of_matrices` の r = 1 と r+1） | `check_preparations_generic.sage` | 各行を本文の成分の式で別々に組み、隣り合う行が等しい。終点を Sage の `p_{1k}X_1 + p_{2k}X_2` と比べる。対照: 行で読んだ `p_{k1}X_1 + p_{k2}X_2` とは異なる | **PASS** | X_1, X_2 ∈ Mat(4,ℂ) と P̌ の成分を QQ 上の独立な不定元に、q = P̌^{-1} をその分数体で取る。k = 1, 2 |
| 準備 2 の δ の鎖（`def_kronecker_delta`、`zero_scalar_multiple_is_zero_matrix`） | `check_preparations_generic.sage` | 同上 | **PASS** | 同上（i ≠ l の 2 組） |
| 準備 2 の 14 個の等号（`scalar_multiple_by_one`、`def_kronecker_delta`、`finite_sum_of_matrices_with_single_nonzero_term`、`def_identity_matrix`、`def_invertible_elements_of_R` の P̌P̌^{-1} = I、`mat_mult`、ℂ の乗法の可換則、`finite_sum_of_scalar_multiples_of_one_matrix`、`scalar_multiple_is_associative`、`finite_double_sum_of_matrices_interchange`、`finite_sum_of_scalar_multiples`、準備 1、`def_finite_sum_of_matrices` の r+1 と r = 1） | `check_preparations_generic.sage` | 同上。終点を Sage の `q_{1l}Ψ_1 + q_{2l}Ψ_2` と比べる。P̌P̌^{-1} = P̌^{-1}P̌ = I を本文の積で確かめてから使う。対照: 行で読んだ `q_{l1}Ψ_1 + q_{l2}Ψ_2` とは異なる、P̌P̌^T ≠ I | **PASS** | 同上（l = 1, 2） |
| 準備 1・準備 2 を本物の Ž_μ・Y̌_μ・P̌_μ・ψ̌_μ で | `check_main_chain_exact.sage` | 同じ行の組み方で、隣り合う行が等しい。ψ̌ は `def_check_fermi` の第二の式で作り、第一の式（P̌ との積）と一致することも見る | **PASS** | 結合定数 3 組 × M_col = 2, 3, 4 × 全 μ。数体 E の中で厳密 |
| 本体の第 1〜第 5 等号（準備 2、`T_V_plus_is_conjugation`、`linearity_of_T`、`T_V_plus_is_conjugation`、`commutation_V_plus_check_psi`） | `check_main_chain_exact.sage` | T_{(V^{(+)})} を `def_T_V_plus` の三つの共役の合成で、T_{V^{(+)}} を `def_V_plus` の V^{(+)} = (SV_2)S による `def_T_g` の共役で作り、各行を別々に組んで等しい。第 5 等号の右辺の (exp(±γ(θ̃_μ)))_C は λ_{±,μ} と置き、λ_{±,μ} = γ_1 ± √(γ_1²−1) = exp(±arccosh γ_1) を AA で確かめる。左辺を Sage の `V X_l V^{-1}` と比べる。対照: λ_± を入れ替えると第 5 等号が、逆向きの共役では第 2 等号が崩れる | **PASS** | 同上 × l = 1, 2 |
| 本体の第 5〜第 10 等号（`commutation_V_plus_check_psi`、`action_of_T_check_Vprime_on_check_psi`、`def_check_Vprime` (2)、`linearity_of_T`、`def_check_Vprime` (2)、準備 2） | `check_vprime_ball.sage` | 厳密な値を ComplexBallField(512) へ移し、γ(θ̃_λ) を実対数の arccosh、(exp(±γ))_C を実数の exp、V̌' = exp(X̌) と (V̌')^{-1} = exp(−X̌) を `def_exp` の部分和に尾の上界を足したボールで作り、隣り合う行のボールが重なる。第 5 等号の右辺の λ_± 版と (exp(±γ))_C 版が重なることも見る。第 7・第 9 等号は def_check_Vprime (2) の T_{(V̌')} = T_{V̌'}（def_T_g の定め方そのもの）の書き換えで、両辺を同じ V̌'W(V̌')^{-1} で組むので独立な確認ではない | **PASS** | 同上 × l = 1, 2 |
| 主張 | `check_vprime_ball.sage` | `def_T_V_plus` の三つの共役の合成で厳密に作った T_{(V^{(+)})}(X_l) を移した値が、Sage の行列の exp・逆行列で作った V̌'X_l(V̌')^{-1} と、本文の部分和のボールの T_{(V̌')}(X_l) の両方と重なる。対照: 逆向きの共役 (V̌')^{-1}X_l V̌' とは重ならない | **PASS** | 同上 |

## 計算の帰属と範囲

- 共通の準備は `_prelude.sage`（`commutation_V_plus_check_psi` の検算の準備を写し、ボールへの埋め込みと行列の exp のボールを足したもの）と
  `_shared/transfer_factor_actions_on_check_Z_Y.sage`。K_1 = 2 log y、K_2 = log x（x, y ∈ QQ_{>1}）と選ぶと、S = exp(X)・V_2・
  c_1, s_1, c_2, c_2^*, s_2^*・位相が一つの数体 F に入る。σ = (√M_col)_C も F に入る。r_μ = |γ_2(θ̃_μ)| は F に無ければ E := F(R)、R² = n_μ に持つ。
- 結合定数は (x, y) = (2, 2)、(3, 3/2)、(5/4, 3)。
- **浮動小数点を使う所と理由**: `check_vprime_ball.sage` だけで、ℝ への脱出を含む量（γ(θ̃_λ) の実対数、実数の exp、行列の exp の極限）である。
  RealBallField・ComplexBallField（512 ビット）の区間で囲み、等号は区間が重なることで判定する。行列の exp の尾の上界は
  `s^{N+1}/(N+1)!/(1 − s/(N+2))`（s は成分の 2 乗和の平方根の上界で `def_matrix_norm` のノルム以上）で、2^{-300} 未満になるまで N を伸ばす。
  ほかの検算はすべて数体と QQ 上の分数体の中で厳密である。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh T_V_plus_eq_T_check_Vprime_on_check_Z_Y
# 個別（M_col を引数で絞れる）
cd sagemath/check/T_V_plus_eq_T_check_Vprime_on_check_Z_Y && sage check_main_chain_exact.sage 2 3
```
