# 一般有限グラフの Fisher 零点の四乗和と係数比の検算

**対象ラベル**: `theorem_fisher_zero_fourth_power_sum_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_fourth_power_sum_coefficient_ratio`）
- 範囲: 三つの有限和積、四次 Newton 恒等式の導出、基本対称式と低次冪和の代入、最高次側五係数による有理式への変形
- 依存する本文ラベル: `theorem_fisher_zero_elementary_symmetric_coefficient_ratio`、`theorem_fisher_zero_square_sum_coefficient_ratio`、`theorem_fisher_zero_cube_sum_coefficient_ratio`、`theorem_partition_polynomial_degree_maximum_broken_edge_count`、`claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_first_times_third_power_sum.sage` | 一次基本対称式と三乗和の積を展開する | PASS | 全四例で一致 |
| `check_second_times_square_power_sum.sage` | 二次基本対称式と二乗和の積を展開する | PASS | 全四例で一致 |
| `check_third_times_first_power_sum.sage` | 三次基本対称式と一次冪和の積を展開する | PASS | 全四例で一致 |
| `check_isolate_fourth_power_sum.sage` | 最初の積恒等式から四乗和を取り出す | PASS | 全四例で一致 |
| `check_substitute_three_one_sum.sage` | 三乗一次型和を二番目の積恒等式で置き換える | PASS | 全四例で一致 |
| `check_distribute_three_one_substitution.sage` | 三乗一次型和の置換後に分配律を適用する | PASS | 全四例で一致 |
| `check_substitute_two_one_one_sum.sage` | 二乗一次一次型和を三番目の積恒等式で置き換える | PASS | 全四例で一致 |
| `check_fourth_newton_identity.sage` | 最後の括弧を外して四次 Newton 恒等式を得る | PASS | 全四例で一致 |
| `check_substitute_coefficient_ratios.sage` | 基本対称式と低次冪和の係数比を代入する | PASS | 全四例で一致 |
| `check_expand_products.sage` | 代入した各積を分母を変えずに展開する | PASS | 全四例で一致 |
| `check_expand_common_denominator.sage` | 非零な最高次係数の四乗を共通分母にする | PASS | 全四例で一致 |
| `check_combined_coefficient_ratio.sage` | 同じ分母の項を一つの係数比へまとめる | PASS | 全四例で一致 |

## 備考

- 四辺道、四辺星、五サイクル、四頂点完全グラフを用い、次数四以上の例だけを検査する。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-fourth-power-sum-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
