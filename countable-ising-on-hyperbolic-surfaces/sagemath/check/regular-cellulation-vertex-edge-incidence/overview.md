# 正則セル分割の頂点と辺の incidence 等式の検算

**対象ラベル**: `theorem_regular_cellulation_vertex_edge_incidence`

## 対象

- 構造化本文: 「正則セル分割の頂点と辺の incidence 等式」
- 検算範囲: 面境界の角位置を頂点ごと・辺ごとに数える六つの等式
- 併せて検証: `def_finite_cellulation_regular_type_set`、`def_finite_cellulation_vertex_links_are_cycles`、`def_finite_cellulation_opposite_edge_occurrences`
- 帰属: 有限集合と自然数。浮動小数点、実数、複素数、極限、積分を用いない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_constant_sum_over_vertices.sage` | `q|V|` を頂点上の定数和へ展開する | PASS | 二面三角形球面と一面正方形トーラスで一致 |
| `check_regular_vertex_degrees.sage` | 正則型条件で各 `q` を頂点角位置数へ置換する | PASS | 両例の全ての頂点で一致 |
| `check_corner_disjoint_union.sage` | 到着頂点ごとの角位置集合が全角位置集合を互いに素に分割する | PASS | 両例で一致 |
| `check_edge_fiber_partition.sage` | 全角位置集合を辺成分の有限ファイバーへ分割する | PASS | 両例で一致 |
| `check_two_occurrences_per_edge.sage` | 各辺の出現位置ファイバーが二元であることを使う | PASS | 両例の全ての辺で一致 |
| `check_constant_sum_over_edges.sage` | 辺上の定数和を `2|E|` へまとめる | PASS | 両例で一致 |

実行日: 2026-08-23

## 実行記録

- ERROR: 構造化本文ディレクトリからリポジトリ直下相対の glob を指定したため、SageMath 起動前に対象ファイルを解決できなかった。数学的検算は実行されていない。
- PASS: リポジトリ直下から同じ六ファイルを実行し、全件成功した。

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-vertex-edge-incidence/check_*.sage; do
  sage "$f"
done
```
