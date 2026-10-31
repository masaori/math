# SageMath Check: 動く辺の軌道族による分割

**旧対象ラベル**: `def_moved_edge_set`（本文から退避）, `def_permutation_iterate`（参照用ノート「不採用経路: 置換の軌道集合」に対応）,
`def_moved_orbit_family`（本文から退避）, `claim_moved_orbit_partition`（本文から退避）

一辺二の周期正方格子の向き付き辺のうち先頭六本の全置換 $6!$ 個を取り、残りを固定した。
各置換について、動く辺上の軌道関係の反射律・対称律・推移律を検査し、同じ軌道を集合として
重複排除した族の各元が空でなく、相異なる二元が互いに素で、合併が動く辺集合に等しいことを
全数検査した。動く辺を持たない恒等置換では、空族の合併と空の動く辺集合が一致することも検査した。

- 実行: `sage sagemath/archive/permutation-moved-orbit-partition/check.sage`
- 状態: PASS（2026-10-31、全置換 $6!$ 個・動く辺 3,600 例）
- 浮動小数点: 不使用
