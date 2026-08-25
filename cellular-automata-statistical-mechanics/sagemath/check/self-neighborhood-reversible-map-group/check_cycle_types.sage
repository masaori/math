# claim_self_neighborhood_reversible_map_cycle_types_general の検算。
# 1 <= |V| <= 5 で、S = 空集合 の巡回型が 2^|V| 個の 1、
# S ≠ 空集合 の F_S が固定点を持たず巡回型が 2^(|V|-1) 個の 2 であることを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked = 0
for cell_count in range(1, 6):
    size = 2 ** cell_count
    for flip_set in subsets(cell_count):
        table = flip_table(cell_count, flip_set)
        observed = sorted(cycle_type(table))
        if len(flip_set) == 0:
            assert observed == [1] * size
            assert all(table[point] == point for point in range(size))
        else:
            assert all(table[point] != point for point in range(size))  # 固定点なし
            assert observed == [2] * (size // 2)
            assert len(observed) == 2 ** (cell_count - 1)
        assert sum(observed) == size  # 周期軌道は配位を分割する
        checked += 1

print(f"PASS flip_sets={checked}")
