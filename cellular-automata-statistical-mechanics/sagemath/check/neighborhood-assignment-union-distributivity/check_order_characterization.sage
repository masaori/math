# 対象ラベル: claim_neighborhood_assignment_inclusion_iff_union_eq
# N <= M と N⊔M = M の同値を、本文の証明の両方向に分けて検査する。
# 順方向は各 v での N(v) ∪ M(v) = M(v)、逆方向は w ∈ N(v) を追う所属の含意列である。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

forward_checked = 0
backward_checked = 0
equivalence_checked = 0

for cell_count in range(0, 4):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)

    for lower in assignments:
        for upper in assignments:
            union = pointwise_union(cells, lower, upper)

            if precedes(cells, lower, upper):
                # 順方向: N(v) ⊆ M(v) から (N⊔M)(v) = N(v) ∪ M(v) = M(v)
                for v in cells:
                    assert lower[v] <= upper[v]
                    assert union[v] == lower[v] | upper[v]
                    assert lower[v] | upper[v] == upper[v]
                assert union == upper
                forward_checked += 1

            if union == upper:
                # 逆方向: w ∈ N(v) ⇒ w ∈ N(v)∪M(v) = (N⊔M)(v) = M(v)
                for v in cells:
                    for w in lower[v]:
                        assert w in lower[v] | upper[v]
                        assert w in union[v]
                        assert w in upper[v]
                    assert lower[v] <= upper[v]
                assert precedes(cells, lower, upper)
                backward_checked += 1

            assert precedes(cells, lower, upper) == (union == upper)
            equivalence_checked += 1

print(
    "PASS forward={} backward={} pairs={}".format(
        forward_checked, backward_checked, equivalence_checked
    )
)
