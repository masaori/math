# 一般有限グラフの Fisher 零点と有理評価点との差の積の検算

**対象ラベル**: `theorem_fisher_zero_rational_shifted_product_coefficient_ratio`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_rational_shifted_product_coefficient_ratio`）
- 範囲: 一次因子分解の有理点評価、最高次係数の消去、有理数への帰属
- 依存する本文ラベル: `theorem_partition_polynomial_degree_maximum_broken_edge_count`、
  `claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_factorization_evaluation_at_rational.sage` | 一次因子分解の有理点評価 | PASS | 全例・全評価点で一致 |
| `check_rational_shifted_product_ratio.sage` | 零点差積と評価値・最高次係数比 | PASS | 全例・全評価点で有理数として一致 |
| `check_zero_negative_positive_specializations.sage` | 零、負、正の有理評価点への特殊化 | PASS | 全例で係数比表示と一致 |

## 備考

- 無辺グラフ、一辺グラフ、四辺道、五サイクル、四頂点完全グラフを用い、次数零の場合も検査する。
- 評価点は `-2`、`-1`、`0`、`1/2`、`1`、`3/2` とし、有限集合、`NN`、`ZZ`、`QQ`、
  `QQbar`、`QQbar[x]` の厳密演算だけを用いる。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-rational-shifted-product-coefficient-ratio/check_*.sage; do
  sage "$file"
done
```
