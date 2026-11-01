# SageMath Check: matrix_difference_mul_vector

## 対象

**対象ラベル**: `matrix_difference_mul_vector` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`
  （ブロック `finite_matrix_claim_difference_distributes_over_vector_product`）
- 主張: `A, B ∈ Mat(m,n,ℂ)`、`v ∈ ℂ^n` について `Av − Bv = (A − B)v`
- 範囲: 証明の成分ごとの鎖の各行。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | `m, n = 1..3` の不定元の成分で、`(Av − Bv)_i` から `((A − B)v)_i` までの 6 行が多項式として一致すること。否定コントロール: `A + B` では一致しない | PASS | すべて厳密に一致 |

## 備考

- 浮動小数点は使っていない。多項式環 `QQ[A_{ij}, B_{ij}, v_j]` の恒等式だけで確かめた。
- 差は本文の成分の式どおりに書き、Sage の組み込みの演算との一致も確かめた。

## 実行方法

```bash
cd sagemath/check/matrix_difference_mul_vector
~/micromamba/envs/sage/bin/sage check_steps.sage
```

実行ログは `logs/` に保存してある（2026-11-01）。
