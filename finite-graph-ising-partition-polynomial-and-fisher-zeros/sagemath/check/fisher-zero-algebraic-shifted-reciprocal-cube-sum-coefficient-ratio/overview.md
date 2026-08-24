# SageMath Check: 代数的評価点における Fisher 零点差の逆三乗和と係数表示

## 対象

**対象ラベル**: `theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio`

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio`）
- 範囲: 係数表示と一次因子積の前三回の形式微分、有限三重和の分解、最終係数比
- 併せて検証: 逆数和と逆二乗和の既存係数表示の代入

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_coefficient_formal_derivatives.sage` | 係数表示の前三回の形式微分 | PASS | 三つの多項式恒等式が一致 |
| `check_third_coefficient_sum_definition.sage` | 三回形式微分の評価と第三係数和 | PASS | 全例・全評価点で一致 |
| `check_product_formal_derivatives.sage` | 一次因子積の前三回の形式微分 | PASS | 順序付き除外添字和と一致 |
| `check_third_derivative_root_ratio.sage` | 三回微分と相異なる順序付き三重和 | PASS | 全ての非零評価で一致 |
| `check_reciprocal_product_decomposition.sage` | 逆数和と逆二乗和の積の分解 | PASS | 対角・非対角分解が一致 |
| `check_reciprocal_cube_decomposition.sage` | 逆数和の三乗の一致型分解 | PASS | 三つの添字一致型が一致 |
| `check_eliminate_non_diagonal_pair_sum.sage` | 非対角二重和の消去 | PASS | 三次恒等式が一致 |
| `check_substitute_lower_reciprocal_sums.sage` | 既存の一次・二次係数表示の代入 | PASS | 既存二定理の代入後も一致 |
| `check_common_denominator.sage` | 共通分母化 | PASS | 共通分母化の前後が一致 |
| `check_q1_multiplicative_identity.sage` | 標準単射像 `q_1` と乗法単位元 | PASS | `q_1=1` を厳密確認 |
| `check_embedded_integer_coefficients.sage` | 標準単射像の整数係数整理 | PASS | `q_3-q_1=q_2` と分配を確認 |
| `check_final_coefficient_ratio.sage` | 最終逆三乗和係数比 | PASS | 全ての非零評価で一致 |
| `check_low_degree_empty_sums.sage` | 次数三未満の空和 | PASS | 第三係数和と三重和が零 |

## 備考

- `NN`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。
- `R/C` 脱出および浮動小数点計算は無い。
- Lean 具体版と必要十分版は未着手である。

## 実行方法

```bash
for f in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/check_*.sage; do
  sage "$f"
done
```
