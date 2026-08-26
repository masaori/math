# 対象ラベル: claim_empty_neighborhood_assignment_is_composition_absorbing
# 空近傍割り当てが合成近傍の両側吸収元であることを、本文の証明の二つの式変形に分けて検査する。
# 左からは空集合を添字とする合併、右からは空集合だけの合併である。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

left_checked = 0
right_checked = 0

for cell_count in range(0, 4):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    zero = empty_assignment(cells)

    for assignment in assignments:
        # (O_V * N)(v) = ∪_{u ∈ ∅} N(u) = ∅ = O_V(v)
        composed = compose(cells, zero, assignment)
        for v in cells:
            assert zero[v] == frozenset()
            index_set = zero[v]
            assert len(index_set) == 0
            assert composed[v] == frozenset()
            assert composed[v] == zero[v]
        assert composed == zero
        left_checked += 1

        # (N * O_V)(v) = ∪_{u ∈ N(v)} ∅ = ∅ = O_V(v)
        composed = compose(cells, assignment, zero)
        for v in cells:
            for u in assignment[v]:
                assert zero[u] == frozenset()
            assert composed[v] == frozenset()
            assert composed[v] == zero[v]
        assert composed == zero
        right_checked += 1

print("PASS left_absorbing={} right_absorbing={}".format(left_checked, right_checked))
