# 代数的評価点における Fisher 零点差の逆数和と係数表示の検算

**対象ラベル**: `theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio`）
- 範囲: 係数表示と一次因子分解の形式微分、零点差の項別消去、係数有限和の比
- 依存する本文ラベル: `def_fisher_zero_algebraic_shifted_reciprocal_sum`、`claim_partition_polynomial_coefficient_expansion`、`theorem_fisher_zero_algebraic_shifted_product_coefficient_ratio`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_formal_derivative.sage` | 係数表示の項別形式微分 | PASS | 全例で多項式として一致 |
| `check_product_formal_derivative.sage` | 一次因子積の形式微分と一因子を除いた積の和 | PASS | 全例で多項式として一致 |
| `check_distribute_root_product.sage` | 零点差積を逆数和の各項へ分配する中間等式 | PASS | 全例・全対象評価点で一致 |
| `check_cancel_root_differences.sage` | 非零な各零点差を対応する項で消去する中間等式 | PASS | 全例・全対象評価点で一致 |
| `check_final_coefficient_ratio.sage` | 逆数和と係数有限和の評価値比の一致 | PASS | 全例・全対象評価点で一致 |
| `check_degree_zero_empty_sum.sage` | 次数零における二つの空和 | PASS | 二つの空和が `QQbar(0)` に一致 |

## 備考

- 無辺グラフ、一辺グラフ、四辺道、五サイクル、四頂点完全グラフを用いる。
- 代数的評価点は `t^2-2`、`t^2+1`、`t^3-2` の全ての `QQbar` 根とし、評価値が非零の点だけを用いる。
- `NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
