# 代数的評価点における Fisher 零点差の逆二乗和と係数表示の検算

**対象ラベル**: `theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio`）
- 範囲: 係数表示と一次因子分解の二回形式微分、逆数和の平方展開、零点差対の消去、最終係数比
- 依存する本文ラベル: `def_fisher_zero_algebraic_shifted_reciprocal_sum`、`theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio`、`claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-25

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_embedded_coefficient_expansion.sage` | 二つの標準単射で移した係数表示 | PASS | 全例で多項式として一致 |
| `check_coefficient_first_formal_derivative.sage` | 係数表示の一回の項別形式微分 | PASS | 全例で多項式として一致 |
| `check_coefficient_second_formal_derivative.sage` | 係数表示の二回の項別形式微分 | PASS | 全例で多項式として一致 |
| `check_rational_to_algebraic_embedding_preserves_triple_product.sage` | 有理数から代数的数への標準単射が三因子の積を保つこと | PASS | 全例・全二次以上の係数で一致 |
| `check_natural_to_rational_embedding_preserves_triple_product.sage` | 自然数から有理数への標準単射が三因子の積を保つこと | PASS | 全例・全二次以上の係数で一致 |
| `check_evaluate_second_coefficient_sum.sage` | 二回形式微分式への評価点代入と第二係数和 | PASS | 全例・全代数的評価点で一致 |
| `check_product_second_formal_derivative.sage` | 一次因子積の二回形式微分と相異なる順序付き添字対ごとに二因子を除いた積の和 | PASS | 全例で多項式として一致 |
| `check_product_second_derivative_ordered_pairs.sage` | 一回形式微分の因子和をもう一回微分した順序付き添字対の和 | PASS | 全例で多項式として一致 |
| `check_substitute_reciprocal_sum_definition.sage` | 逆数和の定義だけを代入する等式 | PASS | 全例・全対象評価点で一致 |
| `check_substitute_reciprocal_square_sum_definition.sage` | 逆二乗和の定義だけを代入する等式 | PASS | 全例・全対象評価点で一致 |
| `check_reciprocal_square_expansion.sage` | 逆数和の平方を対角項と相異なる順序付き添字対へ分離 | PASS | 全例・全対象評価点で一致 |
| `check_cancel_root_pairs.sage` | 一次因子分解の評価、非零積からの最高次係数の消去、各零点差の非零性、二つの零点差の消去 | PASS | 全段が全例・全対象評価点で成立 |
| `check_second_derivative_ratio.sage` | 逆数対和と二回形式微分の評価値の一致 | PASS | 全例・全対象評価点で一致 |
| `check_divide_nonzero_polynomial_value.sage` | 非零な評価値を消去して逆数対和を商として取り出す等式 | PASS | 全例・全対象評価点で一致 |
| `check_rearrange_reciprocal_square_sum.sage` | 移項により逆二乗和を単独で取り出す等式 | PASS | 全例・全対象評価点で一致 |
| `check_final_coefficient_ratio.sage` | 逆二乗和と係数有限和の比の一致 | PASS | 全例・全対象評価点で一致 |
| `check_degree_zero_empty_sums.sage` | 次数零における三つの空和 | PASS | 三つの空和が `QQbar(0)` に一致 |

## 備考

- 無辺グラフ、一辺グラフ、四辺道、五サイクル、四頂点完全グラフを用いる。
- 代数的評価点は `t^2-2`、`t^2+1`、`t^3-2` の全ての `QQbar` 根とし、評価値が非零の点だけを用いる。
- `NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
