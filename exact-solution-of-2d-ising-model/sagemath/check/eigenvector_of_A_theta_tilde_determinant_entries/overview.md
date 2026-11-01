# SageMath Check: eigenvector_of_A_theta_tilde（det(A(θ) − λI) の成分の行）

## 対象

**対象ラベル**: `eigenvector_of_A_theta_tilde` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
  （ブロック `Athetatilde_004_claim_eigenvector`）
- 範囲: Step 1 の `det(A(θ) − λI)` の鎖の先頭から `det [[g_1 − λ, a], [−b, g_1 − λ]]` までの行
  （`def_matrix_difference`・`def_matrix_scalar_multiple`・`def_identity_matrix`・`def_kronecker_delta` の成分、`x·1 = x`・`x·0 = 0`・`y − 0 = y`、
  `def_gamma1_gamma2_of_theta` の代入）。鎖の残りの行は `048_claim_A_theta_tilde` と `nonzero_kernel_iff_det_zero_two_by_two` が扱う。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 多項式環 `QQ[A11, A12, A21, A22, λ, g1, a, b]` で、各行の行列が成分ごとに一致し行列式も一致すること。最後の行が `A − λI`（Sage の組み込みの演算）と一致し、`A(θ) = [[g1, a], [−b, g1]]` の代入で `[[g1 − λ, a], [−b, g1 − λ]]` になること。否定コントロール: 単位行列の非対角を 1 にした行列から作り直すと、最後の行とも行列式とも一致しない | PASS | すべて厳密に一致 |

## 備考

- 浮動小数点は使っていない。単位行列・スカラー倍・差は Sage の組み込みの演算ではなく本文の成分の式どおりに書いた。

## 実行方法

```bash
cd sagemath/check/eigenvector_of_A_theta_tilde_determinant_entries
~/micromamba/envs/sage/bin/sage check_steps.sage
```

実行ログは `logs/` に保存してある（2026-11-01）。
