# SageMath Check: 符号化格子辺と頂点辺グラフの辺の全単射

**対象ラベル**: `claim_cell_graph_edge_bijection`

整数座標 $-1$ から $1$ の九セルから作る全 512 集合について、各グラフ辺がちょうど一つの符号化格子辺の像であることを検算する。全整数上の証明は本文と Lean が担う。

- 実行: `sage sagemath/check/cell-graph-edge-bijection/check.sage`
- 状態: PASS（2026-11-10）。512 集合の全グラフ辺で原像が一意だった。
- 計算: `ZZ` と有限集合のみ。浮動小数点を使わない。
