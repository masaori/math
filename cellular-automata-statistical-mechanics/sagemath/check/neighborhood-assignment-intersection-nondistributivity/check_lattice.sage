# 対象ラベル: claim_neighborhood_assignment_pointwise_union_intersection_lattice
# 点ごとの和と積が有限分配束をなすことを、本文の証明の段ごとに分けて検査する。
#   (1) 積の和に対する分配律   N⊓(M⊔L) = (N⊓M)⊔(N⊓L)
#   (2) 和の積に対する分配律   N⊔(M⊓L) = (N⊔M)⊓(N⊔L)
#   (3) 和が包含順序の最小上界であること
#   (4) 積が包含順序の最大下界であること
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

distributive_checked = 0
join_checked = 0
meet_checked = 0

for cell_count in range(0, 3):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)

    for left in assignments:
        for right in assignments:
            union = pointwise_union(cells, left, right)
            meet = pointwise_intersection(cells, left, right)

            # 和は上界、積は下界である
            assert precedes(cells, left, union)
            assert precedes(cells, right, union)
            assert precedes(cells, meet, left)
            assert precedes(cells, meet, right)

            for third in assignments:
                # (1) w ∈ N(v) ∧ (w ∈ M(v) ∨ w ∈ L(v)) ⟺ (w∈N∧w∈M) ∨ (w∈N∧w∈L)
                lhs = pointwise_intersection(cells, left, pointwise_union(cells, right, third))
                rhs = pointwise_union(
                    cells,
                    pointwise_intersection(cells, left, right),
                    pointwise_intersection(cells, left, third),
                )
                for v in cells:
                    for w in cells:
                        assert (w in lhs[v]) == ((w in left[v]) and ((w in right[v]) or (w in third[v])))
                        assert (((w in left[v]) and (w in right[v])) or ((w in left[v]) and (w in third[v]))) == (w in rhs[v])
                assert lhs == rhs

                # (2) w ∈ N(v) ∨ (w ∈ M(v) ∧ w ∈ L(v)) ⟺ (w∈N∨w∈M) ∧ (w∈N∨w∈L)
                lhs2 = pointwise_union(cells, left, pointwise_intersection(cells, right, third))
                rhs2 = pointwise_intersection(
                    cells,
                    pointwise_union(cells, left, right),
                    pointwise_union(cells, left, third),
                )
                for v in cells:
                    for w in cells:
                        assert (w in lhs2[v]) == ((w in left[v]) or ((w in right[v]) and (w in third[v])))
                        assert (((w in left[v]) or (w in right[v])) and ((w in left[v]) or (w in third[v]))) == (w in rhs2[v])
                assert lhs2 == rhs2
                distributive_checked += 1

                # (3) 最小上界: N <= L かつ M <= L ならば N⊔M <= L
                if precedes(cells, left, third) and precedes(cells, right, third):
                    assert precedes(cells, union, third)
                    join_checked += 1

                # (4) 最大下界: L <= N かつ L <= M ならば L <= N⊓M
                if precedes(cells, third, left) and precedes(cells, third, right):
                    assert precedes(cells, third, meet)
                    meet_checked += 1

print(
    "PASS distributive_triples={} join_upper_bounds={} meet_lower_bounds={}".format(
        distributive_checked, join_checked, meet_checked
    )
)
