# SageMath Check: matrix_difference_zero_iff_equal

## 対象

**対象ラベル**: `matrix_difference_zero_iff_equal` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`
  （ブロック `finite_matrix_claim_difference_is_zero_iff_equal`）
- 主張: `A, B ∈ Mat(m,p,ℂ)` について `A − B = O ⟺ A = B`
- 範囲: 証明の成分ごとの鎖の各行。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 大きさ `(m,p) ∈ {(1,1),(1,2),(2,1),(2,2)}`、成分 `∈ {−1,0,1}` の行列の組 6732 個で、同値の鎖の 5 つの条件（`def_zero_matrix` の段を含む）が一致すること。否定コントロール: 差の代わりに和を使うと崩れる | PASS | すべて一致 |

## 備考

- 浮動小数点は使っていない。`ZZ` の小さな成分の全数検査だけで確かめた。
- 差と零行列は本文の成分の式どおりに書き、Sage の組み込みの行列の等号との一致も確かめた。

## 実行方法

```bash
cd sagemath/check/matrix_difference_zero_iff_equal
~/micromamba/envs/sage/bin/sage check_steps.sage
```

実行ログは `logs/` に保存してある（2026-11-01）。
