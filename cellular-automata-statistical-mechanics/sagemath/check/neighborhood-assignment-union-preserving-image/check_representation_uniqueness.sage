# 対象ラベル: claim_union_preserving_map_representation_unique
# 一元部分集合から N(v) = Phi({v}) を復元し、表現する割り当てが一意であることを検査する。
# 帰属: 有限集合、有限部分集合、有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

assignments_scanned = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    seen = {}
    for N in neighborhood_assignments(cells):
        assignments_scanned += 1
        table = union_map_table(cells, N)
        reconstructed = reconstruct_assignment(cells, table)
        for v in cells:
            assert N[v] == table_value(cells, table, frozenset((v,)))
            assert table_value(cells, table, frozenset((v,))) == reconstructed[v]
        assert reconstructed == N
        assert table not in seen
        seen[table] = N
    assert len(seen) == len(neighborhood_assignments(cells))

print("assignments scanned:", assignments_scanned)
print("PASS check_representation_uniqueness")
