# 辺をもつ有限グラフの正の有理評価における弱順序の反映

**対象ラベル**: `theorem_partition_polynomial_positive_rational_evaluation_weak_order_reflection`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_positive_rational_evaluation_weak_order_reflection`）
- 範囲: 正の有理評価点の弱順序と Ising 分配多項式の評価値の弱順序の同値性
- 併せて検証: `theorem_partition_polynomial_positive_rational_evaluation_monotonicity`、`theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity`

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_weak_order_reflection.sage` | `Z_G(q_1)<=Z_G(q_2)` と `q_1<=q_2` の同値性 | PASS | 全七グラフ・全二十五評価点対で成立 |

## 備考

- 一辺、二本・三本の平行辺、三頂点道、三角形、四頂点サイクル、奇接続辺数頂点をもつ四頂点五辺グラフを用いる。
- 五つの正の有理評価点からなる全二十五順序対を `QQ` 上で評価する。
- `QQ` と `QQ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/positive-rational-evaluation-weak-order-reflection/check_weak_order_reflection.sage
```
