# SageMath Check: eigenvector_of_A_theta_tilde（det(A(θ) − λI) の成分の行と因数分解の恒等式）

## 対象

**対象ラベル**: `eigenvector_of_A_theta_tilde` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
  （ブロック `Athetatilde_004_claim_eigenvector`）
- 範囲: Step 1 の `det(A(θ) − λI)` の鎖の先頭から `det [[g_1 − λ, a], [−b, g_1 − λ]]` までの行
  （`def_matrix_difference`・`def_matrix_scalar_multiple`・`def_identity_matrix`・`def_kronecker_delta` の成分、`x·1 = x`・`x·0 = 0`・`y − 0 = y`、
  `def_gamma1_gamma2_of_theta` の代入）。`x·1 = x`・`x·0 = 0` の本文の根拠は `complex_numbers_form_a_field` の乗法の単位元と `complex_times_zero_is_zero`（2026-11-14）。鎖の残りの行は `048_claim_A_theta_tilde` と `nonzero_kernel_iff_det_zero_two_by_two` が扱う。
- 範囲（2026-11-14 に足した）: Step 1 の準備の因数分解の恒等式 `(λ − (x+y))(λ − (x−y)) = λ^2 − 2_ℂxλ + (x^2 − y^2)`（`λ, x, y ∈ ℂ`。det の鎖の最後の行で `x → (g_1)_ℂ, y → r_ℂ` として引く）の 30 行の鎖の全行。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_factorization_identity.sage | 多項式環 `QQ(i)[λ, x, y]` で、因数分解の鎖の 31 個の式を行の括弧どおりに組み、隣どうしが等しいこと。行で当てた事実（`sum_plus_difference_is_twice_first_in_cc`・`negation_times_complex_is_negation_of_product_in_cc`・`complex_times_negation_is_negation_of_product_in_cc`・`double_negation_in_cc`・`multiply_by_minus_one`・`square_of_complex_number_is_product`、積の可換律 `yx = xy`・`(−(xy)) + xy = 0`・`x^2 + 0 = x^2`）を個別にも確かめる（多項式環の等号は値の一致なので、括弧の付き方そのものではなく各行の値の一致の裏取りである）。否定コントロール: 最後の行を `x^2 + y^2` にしても、係数を `2` でなく `1` にしても先頭と一致しない | PASS | 30 個の等号がすべて厳密に一致 |
| check_steps.sage | 多項式環 `QQ[A11, A12, A21, A22, λ, g1, a, b]` で、各行の行列が成分ごとに一致し行列式も一致すること。最後の行が `A − λI`（Sage の組み込みの演算）と一致し、`A(θ) = [[g1, a], [−b, g1]]` の代入で `[[g1 − λ, a], [−b, g1 − λ]]` になること。否定コントロール: 単位行列の非対角を 1 にした行列から作り直すと、最後の行とも行列式とも一致しない | PASS | すべて厳密に一致 |

## 備考

- 浮動小数点は使っていない。単位行列・スカラー倍・差は Sage の組み込みの演算ではなく本文の成分の式どおりに書いた。

## 実行方法

```bash
cd sagemath/check/eigenvector_of_A_theta_tilde_determinant_entries
~/micromamba/envs/sage/bin/sage check_steps.sage
~/micromamba/envs/sage/bin/sage check_factorization_identity.sage
```

実行ログは `logs/` に保存してある（2026-11-01。因数分解の鎖は 2026-11-14）。
