# 正の有理評価の単調性

**対象ラベル**: `theorem_partition_polynomial_positive_rational_evaluation_monotonicity`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_positive_rational_evaluation_monotonicity`）
- 範囲: 多重度係数表示、正の有理数の冪の順序、非負係数を掛けた項別順序、有限和による評価値の単調性
- 併せて検証: `claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_evaluations.sage` | 二つの評価値と多重度係数和の一致 | PASS | 全八グラフ・全六評価点対で一致 |
| `check_power_order.sage` | 正の有理数の非負整数冪が順序を保つ | PASS | 全八グラフの次数範囲・全六評価点対で成立 |
| `check_termwise_order.sage` | 非負多重度を掛けた各項の順序 | PASS | 全八グラフの全次数・全六評価点対で成立 |
| `check_evaluation_monotonicity.sage` | `Z_G(q_1) <= Z_G(q_2)` | PASS | 全八グラフ・全六評価点対で成立 |

## 備考

- 一頂点無辺、一辺、二本・三本の平行辺、三頂点道、三角形、四頂点サイクル、奇接続辺数頂点をもつ四頂点五辺グラフを用いる。
- 等しい評価点を含む六つの順序対を `QQ` 上で評価する。
- 有限集合、`NN`、`QQ`、`QQ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- 全検算は PASS。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for check_file in finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-monotonicity/check_*.sage; do
  sage "$check_file"
done
```
