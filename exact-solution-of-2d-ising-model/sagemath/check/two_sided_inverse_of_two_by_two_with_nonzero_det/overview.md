# SageMath Check: two_sided_inverse_of_two_by_two_with_nonzero_det

## 対象

**対象ラベル**: `two_sided_inverse_of_two_by_two_with_nonzero_det` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`
  （ブロック `finite_matrix_claim_two_sided_inverse_of_two_by_two_with_nonzero_det`）
- 主張: `B ∈ Mat(2,ℂ)`、`det B ≠ 0_ℂ` のとき、`h := (det B)^{-1}(adj B)` は `Bh = I` かつ `hB = I`
- 範囲: 証明の 2 本の 6 行の鎖の各行。あわせて主張そのものの全数検査。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | `Bh`・`hB` の鎖の各行が有理関数体 `QQ(B11, B12, B21, B22)` の行列として一致すること。成分の実部・虚部が `{−1,0,1}` のガウス有理数 `QQ[i]` の 2×2 行列 6561 個の全数で、det ≠ 0 の 5888 個は `Bh = hB = I`（Sage の逆行列とも一致）、det = 0 の 673 個は `B adj B = 0`。否定コントロール: `(det B)^{-1}` を掛けないと `I` にならない | PASS | すべて厳密に一致 |

## 備考

- 浮動小数点は使っていない。`diagonalization_check_P_D` の Step 4 はこの主張を `B → P̌_μ` で引く（`det P̌_μ ≠ 0` は `048_claim_A_theta_tilde/check_07` が確かめる）。

## 実行方法

```bash
cd sagemath/check/two_sided_inverse_of_two_by_two_with_nonzero_det
~/micromamba/envs/sage/bin/sage check_steps.sage
```

実行ログは `logs/` に保存してある（2026-11-11）。
