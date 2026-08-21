# 辺をもつ有限グラフの正の有理評価の厳密単調性

**対象ラベル**: `theorem_partition_polynomial_positive_rational_evaluation_strict_monotonicity`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_positive_rational_evaluation_strict_monotonicity`）
- 範囲: 正次数の非零係数の構成、正の有理数の正整数冪の厳密順序、正係数を掛けた項の厳密順序、一項が厳密な有限和の厳密順序
- 併せて検証: `def_finite_graph_input`、`def_broken_edge_set`、`def_broken_edge_multiplicity`、`claim_partition_polynomial_coefficient_expansion`

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_positive_degree_witness.sage` | 選んだ辺の始点だけを上向きにした配位が正の破れ辺数と正係数を与える | PASS | 全七グラフで正の破れ辺数と正係数を確認 |
| `check_strict_power_and_term_order.sage` | 正整数冪と正係数項の厳密順序 | PASS | 全七グラフ・全五評価点対で成立 |
| `check_strict_finite_sum.sage` | 一項が厳密で他項が弱い有限和の厳密順序 | PASS | 全七グラフ・全五評価点対で成立 |
| `check_strict_evaluation_monotonicity.sage` | `Z_G(q_1)<Z_G(q_2)` | PASS | 全七グラフ・全五評価点対で成立 |

## 備考

- 一辺、二本・三本の平行辺、三頂点道、三角形、四頂点サイクル、奇接続辺数頂点をもつ四頂点五辺グラフを用いる。
- 五つの狭義順序付き正有理評価点対を `QQ` 上で評価する。
- 有限集合、`NN`、`QQ`、`QQ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。
- 全検算は PASS。

## 実行方法

```sh
for check_file in countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-strict-monotonicity/check_*.sage; do
  sage "$check_file"
done
```
