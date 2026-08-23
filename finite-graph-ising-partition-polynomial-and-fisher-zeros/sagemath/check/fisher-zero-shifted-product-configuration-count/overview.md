# 一般有限グラフの Fisher 零点の一との差の積と全配位数の検算

**対象ラベル**: `theorem_fisher_zero_shifted_product_configuration_count`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_fisher_zero_shifted_product_configuration_count`）
- 範囲: 係数総和、一次因子分解の一点評価、最高次係数の消去
- 依存する本文ラベル: `theorem_partition_polynomial_degree_maximum_broken_edge_count`、
  `claim_partition_polynomial_coefficient_expansion`、`claim_partition_polynomial_value_at_one`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_partition_polynomial_value_at_one.sage` | 一点評価と全スピン配位数 | PASS | 全例で一致 |
| `check_factorization_evaluation_at_one.sage` | 一次因子分解の一点評価 | PASS | 次数零を含む全例で一致 |
| `check_shifted_product_configuration_ratio.sage` | 一との差の積と全配位数・最高次係数比 | PASS | 全例で正の有理数として一致 |

## 備考

- 無辺グラフ、一辺グラフ、四辺道、五サイクル、四頂点完全グラフを用い、次数零の場合も検査する。
- 有限集合、`NN`、`ZZ`、`QQ`、`QQbar`、`QQbar[x]` の厳密演算だけを用いる。複素平面への埋め込み、
  浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- 記述と SageMath 検算までを対象とする。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-shifted-product-configuration-count/check_*.sage; do
  sage "$file"
done
```
