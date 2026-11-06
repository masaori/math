# 境界鎖の二辺の向き付き係数の伝播

**対象ラベル**: `claim_cell_boundary_two_edge_propagation`

| 式変形 | 検証ファイル | 状態 |
|---|---|---|
| 頂点別零和の二辺への縮約 | `check_support_reduction.sage` | PASS（2026-11-06、476 例） |
| 入辺と出辺の向きによる頂点寄与 | `check_orientation.sage` | PASS（2026-11-06、476 例） |
| 二辺の向き付き係数の一致 | `check_propagation.sage` | PASS（2026-11-06、476 例中 116 例は係数が非零） |

辺長二の全セル集合と辺長三の指定したセル集合を整数で厳密に検算した。有限例の検算であり、一般の場合の証明は本文と Lean に置く。
