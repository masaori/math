# SageMath Check: 動く辺の軌道族による分割

**対象ラベル**: `def_moved_edge_set`, `def_permutation_orbit_set`,
`def_moved_orbit_family`, `claim_moved_orbit_partition`

一辺二の周期正方格子の向き付き辺のうち先頭六本の全置換 $6!$ 個を取り、残りを固定した。
各置換について、動く辺上の軌道関係の反射律・対称律・推移律を検査し、同じ軌道を集合として
重複排除した族の各元が空でなく、相異なる二元が互いに素で、合併が動く辺集合に等しいことを
全数検査した。動く辺を持たない恒等置換では、空族の合併と空の動く辺集合が一致することも検査した。

- 実行: `sage sagemath/check/permutation-moved-orbit-partition/check.sage`
- 状態: PASS（2026-08-30、全置換 $6!$ 個・動く辺 3,600 例）
- 浮動小数点: 不使用
