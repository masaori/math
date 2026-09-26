# SageMath Check: positive_real_square_injective

## 対象

**対象ラベル**: `positive_real_square_injective` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_000c0_claim_positive_real_square_injective`（正の実数の二乗の一意性）
- 範囲: 主張 a, b ∈ ℝ_{>0} について a² = b² ⟺ a = b と、証明の各段
  （(a−b)(a+b) = a² − b²、a+b > 0、整域による a−b = 0）。正値性の仮定が要ること（(−a)² = a² だが −a ≠ a）も確かめる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | ステータス |
|---|---------|---------|-------|-----------|
| 01 | `check_01_square_injective.sage` | 正の有理数の組での主張と各段、仮定の必要性 | 3969 | **PASS** |

有理数体 `QQ` の厳密計算で行い、許容誤差は使わない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh positive_real_square_injective
```

実行ログは `logs/` に保存してある。
