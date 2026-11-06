# 境界鎖の頂点別釣り合いの基底辺係数表示

**対象ラベル**: `claim_cell_boundary_coefficient_vertex_balance`

| 式変形 | 検証ファイル | 状態 |
|---|---|---|
| 向きの反転による頂点寄与の符号反転 | `check_orientation.sage` | PASS（2026-11-06、辺長一から四） |
| 標識付き辺の和を基底辺ごとに集める等式 | `check_regrouping.sage` | PASS（2026-11-06、辺長一・二の全セル集合と三・四の指定集合） |
