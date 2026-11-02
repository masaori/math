# SageMath Check: finite_sum_of_zero_matrices

## 対象

**対象ラベル**: `finite_sum_of_zero_matrices` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_sum_of_zero_matrices`
- 主張: `r ∈ ℤ_{≥1}` について `Σ_{j=1}^{r} O = O`
- 範囲: 帰納法の基底の 1 行と帰納の段の 3 行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 有限和を `def_finite_sum_of_matrices` のとおり `def_matrix_sum` の和で左から順に足して組み（`_shared/matrix_operations_by_definition.sage` の `body_finite_sum`）、`r = 1..7` の帰納の段の 4 つの項が隣り合って等しいこと。基底。独立な経路として Sage の行列の和で `r = 1..8` を確かめた。否定コントロール: 零でない項が混じると `O` にならない | PASS | すべて一致 |

## 備考

- 浮動小数点は使っていない。帰納法そのもの（`r` についての全称）は有限の計算に落ちないので、`r` を固定した各段を確かめた。
- 帰属: `QQ` 上の多項式環（または `QQ`）。不定元で成り立つ多項式の等号は、成分へ任意の実数を代入しても成り立つ。
- 大きさは `m, n ∈ {1, 2, 3}` の 9 通りで、一般の大きさは人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_zero_matrices
```

実行ログは `logs/` に保存してある（2026-11-01）。
