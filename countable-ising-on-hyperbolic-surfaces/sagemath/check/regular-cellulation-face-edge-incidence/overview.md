# 正則セル分割の面と辺の incidence 等式の検算

**対象ラベル**: `theorem_regular_cellulation_face_edge_incidence`

## 対象

- 構造化本文: 「正則セル分割の面と辺の incidence 等式」
- 検算範囲: 面境界の辺出現位置を面ごと・辺ごとに数える六つの等式
- 併せて検証: `def_finite_cellulation_regular_type_set`、`def_finite_cellulation_opposite_edge_occurrences`
- 帰属: 有限集合と自然数。浮動小数点、実数、複素数、極限、積分を用いない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_constant_sum_over_faces.sage` | `p|F|` を面上の定数和へ展開する | PASS | 二面三角形球面と一面正方形トーラスで一致 |
| `check_regular_face_degrees.sage` | 正則型条件で各 `p` を面境界位置数へ置換する | PASS | 両例の全ての面で一致 |
| `check_occurrence_disjoint_union.sage` | 面ごとの位置数和を全出現位置集合の元数へまとめる | PASS | 両例で一致 |
| `check_edge_fiber_partition.sage` | 全出現位置集合を辺成分の有限ファイバーへ分割する | PASS | 両例で一致 |
| `check_two_occurrences_per_edge.sage` | 各辺の出現位置ファイバーが二元であることを使う | PASS | 両例の全ての辺で一致 |
| `check_constant_sum_over_edges.sage` | 辺上の定数和を `2|E|` へまとめる | PASS | 両例で一致 |

実行日: 2026-08-23

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-face-edge-incidence/check_*.sage; do
  sage "$f"
done
```
