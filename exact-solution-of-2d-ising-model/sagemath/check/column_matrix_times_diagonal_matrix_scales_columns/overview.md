# SageMath Check: column_matrix_times_diagonal_matrix_scales_columns

## 対象

**対象ラベル**: `column_matrix_times_diagonal_matrix_scales_columns` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
  （ブロック `transfer_matrix_claim_column_matrix_times_diagonal_matrix_scales_columns`）
- 主張: `b_1, …, b_p ∈ ℂ^n`、対角行列 `D ∈ Mat(p,ℂ)` について `[b_1 ⋯ b_p] D = [D_11 b_1 ⋯ D_pp b_p]`
- 範囲: 前置き（`j ≠ k` の `(b_j)_i D_jk = (b_j)_i 0_ℂ = 0_ℂ` の 2 行）と、`(i, k)` 成分の 6 行の鎖の各行。`n, p ∈ {1, 2, 3}` の全ての `(i, k)`。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 成分 `(b_k)_j` と対角成分 `D_kk` を不定元にした `QQ[…]` の多項式として、前置きの 2 行と鎖の 6 行の隣り合う辺が一致すること。否定コントロール: `(1,2)` 成分に 1 を入れた対角でない `D` では成り立たない | PASS | 279 件、厳密 |

## 備考

- 浮動小数点は使っていない。`QQ[…]` の乗法は可換なので、4 行目から 5 行目（積の可換律）は多項式として一致する。

## 実行方法

```bash
cd sagemath/check/column_matrix_times_diagonal_matrix_scales_columns
~/micromamba/envs/sage/bin/sage check_steps.sage
```

実行ログは `logs/` に保存してある（2026-11-11）。
