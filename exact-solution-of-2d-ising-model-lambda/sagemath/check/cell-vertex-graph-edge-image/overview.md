# SageMath Check: セル集合の頂点辺グラフの辺集合

**対象ラベル**: `claim_cell_vertex_graph_edge_image`

整数座標 $-1$ から $1$ の九セルから作る全 512 集合について、格子辺の端点集合の像が頂点辺グラフの辺集合と一致し、符号化辺との個数も一致することを検算する。全整数上の証明は本文と Lean が担う。

- 実行: `sage sagemath/check/cell-vertex-graph-edge-image/check.sage`
- 状態: PASS（2026-11-10）。512 集合で辺集合と像が一致した。
- 計算: `ZZ` と有限集合のみ。浮動小数点を使わない。
