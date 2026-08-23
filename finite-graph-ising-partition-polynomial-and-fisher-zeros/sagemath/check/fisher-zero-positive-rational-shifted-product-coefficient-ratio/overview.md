# 一般有限グラフの Fisher 零点と正有理評価点との差の積の検算

**対象ラベル**: `theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_positive_rational_shifted_product_coefficient_ratio`）
- 範囲: 一次因子分解の正有理点評価、最高次係数の消去、係数比の正値性
- 依存する本文ラベル: `theorem_partition_polynomial_degree_maximum_broken_edge_count`、
  `claim_partition_polynomial_coefficient_expansion`、`theorem_no_positive_rational_root`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_factorization_evaluation_at_positive_rational.sage` | 一次因子分解の正有理点評価 | PASS | 全例・全評価点で一致 |
| `check_positive_rational_shifted_product_ratio.sage` | 零点差積と評価値・最高次係数比 | PASS | 全例・全評価点で一致 |
| `check_ratio_positivity_and_one_specialization.sage` | 係数比の正値性と一点評価への特殊化 | PASS | 全例で正有理数かつ既存表示と一致 |

## 備考

- 無辺グラフ、一辺グラフ、四辺道、五サイクル、四頂点完全グラフを用い、次数零の場合も検査する。
- 評価点は `1/2`、`1`、`3/2`、`2` とし、有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、
  `QQbar[x]` の厳密演算だけを用いる。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-positive-rational-shifted-product-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
