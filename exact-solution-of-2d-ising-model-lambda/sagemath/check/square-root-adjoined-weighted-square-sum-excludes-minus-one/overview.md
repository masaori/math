# 平方根添加後の正錐重み付き平方和

**対象ラベル**: `claim_square_root_adjoined_weighted_square_sum_excludes_minus_one`

**実行日**: 2026-11-19

| ファイル | 状態 | 結果 |
|---|---|---|
| `check_plus_square_expansion.sage` | PASS | 元の平方を展開。 |
| `check_plus_square_relation.sage` | PASS | b²=a を代入。 |
| `check_plus_distribution.sage` | PASS | 各項へ分配。 |
| `check_plus_sum_addition.sage` | PASS | 有限和の加法。 |
| `check_plus_A_definition.sage` | PASS | A の定義。 |
| `check_plus_B_definition.sage` | PASS | B の定義と有限和の分配。 |
| `check_minus_square_expansion.sage` | PASS | 共役側の平方を展開。 |
| `check_minus_square_relation.sage` | PASS | 共役側で b²=a を代入。 |
| `check_minus_distribution.sage` | PASS | 共役側の各項へ分配。 |
| `check_minus_sum_subtraction.sage` | PASS | 有限和の減法。 |
| `check_minus_A_definition.sage` | PASS | 共役側で A の定義。 |
| `check_minus_B_definition.sage` | PASS | 共役側で B の定義と有限和の分配。 |
| `check_conjugate_identity.sage` | PASS | 共役した和の恒等式。 |
| `check_base_weighted_sum.sage` | PASS | 基礎体の重み付き平方和への分解。 |
| `check.sage` | PASS | 上記の式変形を実行。全称命題は Lean 二版で証明。 |
