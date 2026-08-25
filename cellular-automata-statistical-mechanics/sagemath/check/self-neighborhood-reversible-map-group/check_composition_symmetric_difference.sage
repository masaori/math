# claim_self_neighborhood_flip_composition_symmetric_difference の検算。
# 1 <= |V| <= 5 の全ての組 (S, T) について F_S o F_T = F_{S △ T} = F_T o F_S を検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked = 0
for cell_count in range(1, 6):
    flip_sets = subsets(cell_count)
    tables = {flip_set: flip_table(cell_count, flip_set) for flip_set in flip_sets}
    for left in flip_sets:
        for right in flip_sets:
            symmetric_difference = frozenset((left - right) | (right - left))
            assert compose(tables[left], tables[right]) == tables[symmetric_difference]
            assert compose(tables[right], tables[left]) == tables[symmetric_difference]
            checked += 1

print(f"PASS pairs={checked}")
