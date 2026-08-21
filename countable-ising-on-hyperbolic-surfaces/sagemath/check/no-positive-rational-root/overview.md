# 正の有理数に零点を持たないことの検算

**対象ラベル**: `theorem_no_positive_rational_root`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_no_positive_rational_root`）
- 範囲: 多重度係数表示、相異なる全頂点上向き・下向き配位の破れ辺数、定数項による正の有理評価の二配位下界
- 併せて検証: `claim_partition_polynomial_coefficient_expansion`、`def_broken_edge_set`、`def_broken_edge_multiplicity`

## チェック一覧

実行日: 2026-08-21

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_evaluation.sage` | `Z_G(q)` と多重度係数和の一致 | PASS | 全八グラフ・全五評価点で一致 |
| `check_constant_configurations_membership.sage` | 二つの定数配位がスピン配位集合に属する | PASS | 全八グラフで両定数配位が所属 |
| `check_constant_configurations_distinct.sage` | 空でない頂点集合上で二つの定数配位が相異なる | PASS | 全八グラフで両定数配位が相異なる |
| `check_constant_configuration_broken_edges.sage` | 全頂点上向き・下向き配位の破れ辺集合が空集合 | PASS | 全八グラフで空集合 |
| `check_constant_configuration_broken_count.sage` | 全頂点上向き・下向き配位の破れ辺数が零 | PASS | 全八グラフで零 |
| `check_zero_multiplicity_positive.sage` | 定数項の多重度が二以上 | PASS | 全八グラフで二以上 |
| `check_evaluation_lower_bound.sage` | 正の有理評価が定数項以上 | PASS | 全八グラフ・全五評価点で成立 |
| `check_zero_power.sage` | 次数零の項が定数項に等しい | PASS | 全八グラフ・全五評価点で成立 |
| `check_positive_evaluation.sage` | 正の有理評価が二以上 | PASS | 全八グラフ・全五評価点で二以上 |

## 備考

- 一頂点無辺、一辺、二本・三本の平行辺、三頂点道、三角形、四頂点サイクル、奇接続辺数頂点をもつ四頂点五辺グラフを用いる。
- 各グラフで正の有理数 `1/3, 1/2, 1, 3/2, 2` を `QQ` 上で評価する。
- 有限集合、`NN`、`QQ`、`QQ[x]` の厳密演算だけを用いる。実数、複素数、浮動小数点近似、極限、積分を用いない。
- 全検算は PASS。Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for check_file in countable-ising-on-hyperbolic-surfaces/sagemath/check/no-positive-rational-root/check_*.sage; do
  sage "$check_file"
done
```
