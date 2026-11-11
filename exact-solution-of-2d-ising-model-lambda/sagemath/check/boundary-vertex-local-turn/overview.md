# SageMath Check: 境界頂点の局所回転数

**対象ラベル**: `claim_plane_simple_polygon_cyclic_turning`

四セルの非対角配置をすべて列挙し、選んだ入辺・出辺の左側が内側セルで右側が外側セルであること、二辺が異なること、二辺の回転数が接続数一・二・三で順に −1・0・1 となることを検査する。

- 実行: `sage sagemath/check/boundary-vertex-local-turn/check.sage`
- 状態: PASS（2026-11-11）。対象となる 12 配置すべてで境界辺性・二辺の相異性・回転数が一致。
- 計算: 整数と四方向の剰余だけ。浮動小数点は使わない。
