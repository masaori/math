# 対象ラベル: def_neighborhood_assignment_subset_union_map
# 併せて検査するラベル: def_finite_carrier_subset_space
# 本文の定義そのものを段ごとに検査する。
#   (a) Sub(V) の元数が 2^{|V|} である
#   (b) U_N(S) は V の部分集合であり、Sub(V) の元である（U_N が Sub(V) の自己写像である）
#   (c) U_N(S) への所属が「S の中に w を近傍に含む v が存在すること」と同値である
#   (d) 空集合の像は空集合である（合併の定義から従う退化した場合）
# 帰属: 有限集合と有限部分集合だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

scanned = 0
for n in (0, 1, 2, 3):
    cells = tuple(range(n))
    all_subsets = tuple(subsets(cells))
    # (a) Sub(V) の元数
    assert len(all_subsets) == 2 ** n
    assert len(set(all_subsets)) == 2 ** n
    for N in neighborhood_assignments(cells):
        scanned += 1
        table = union_map_table(cells, N)
        # (b) 像が Sub(V) に入る
        assert set(table.keys()) == set(all_subsets)
        for S in all_subsets:
            assert table[S] <= frozenset(cells)
            assert table[S] in set(all_subsets)
            # (c) 所属の同値
            for w in cells:
                assert (w in table[S]) == any(w in N[v] for v in S)
        # (d) 空集合の像
        assert table[frozenset()] == frozenset()

print("assignments scanned:", scanned)
print("PASS check_union_map_well_defined")
