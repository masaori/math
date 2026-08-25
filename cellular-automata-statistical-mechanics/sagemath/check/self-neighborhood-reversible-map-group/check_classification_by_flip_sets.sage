# claim_self_neighborhood_reversible_maps_classified_by_flip_sets の検算。
# 1 <= |V| <= 5 で、S |-> F_S が冪集合から可逆大域写像全体への全単射であり、
# 元数が 2^|V| であることを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

checked = 0
for cell_count in range(1, 6):
    size = 2 ** cell_count
    flip_sets = subsets(cell_count)
    assert len(flip_sets) == 2 ** cell_count
    tables = {}
    for flip_set in flip_sets:
        table = flip_table(cell_count, flip_set)
        # F_S o F_S = id （対合であり、したがって可逆）
        assert compose(table, table) == identity_table(size)
        assert is_injective(table)
        tables[flip_set] = table
    # 単射性
    assert len(set(tables.values())) == len(flip_sets)
    # 全射性: 自己近傍舞台の可逆大域写像は全て F_S の形
    reversible = set()
    for family in self_neighborhood_families(cell_count):
        table = global_table(family)
        if is_injective(table):
            reversible.add(table)
    assert reversible == set(tables.values())
    assert len(reversible) == 2 ** cell_count
    checked += len(flip_sets)

print(f"PASS flip_sets={checked}")
