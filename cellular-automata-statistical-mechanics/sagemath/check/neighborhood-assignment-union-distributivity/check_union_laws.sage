# 対象ラベル: claim_neighborhood_assignment_pointwise_union_laws
# 点ごとの和が可換・結合的・冪等であり、O_V がその単位元であることを、
# 本文の証明の四つの式変形（可換・結合・冪等・単位）に分けて検査する。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

commutative_checked = 0
idempotent_checked = 0
unit_checked = 0
associative_checked = 0

for cell_count in range(0, 4):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    zero = empty_assignment(cells)

    for assignment in assignments:
        # 冪等律: (N⊔N)(v) = N(v) ∪ N(v) = N(v)
        for v in cells:
            assert pointwise_union(cells, assignment, assignment)[v] == assignment[v] | assignment[v]
            assert assignment[v] | assignment[v] == assignment[v]
        assert pointwise_union(cells, assignment, assignment) == assignment
        idempotent_checked += 1

        # 単位律: (N⊔O_V)(v) = N(v) ∪ ∅ = N(v)、および可換律から O_V⊔N = N
        for v in cells:
            assert zero[v] == frozenset()
            assert pointwise_union(cells, assignment, zero)[v] == assignment[v] | frozenset()
            assert assignment[v] | frozenset() == assignment[v]
        assert pointwise_union(cells, assignment, zero) == assignment
        assert pointwise_union(cells, zero, assignment) == assignment
        unit_checked += 1

    if cell_count <= 2:
        for left in assignments:
            for right in assignments:
                # 可換律: (N⊔M)(v) = N(v) ∪ M(v) = M(v) ∪ N(v) = (M⊔N)(v)
                for v in cells:
                    assert pointwise_union(cells, left, right)[v] == left[v] | right[v]
                    assert left[v] | right[v] == right[v] | left[v]
                    assert right[v] | left[v] == pointwise_union(cells, right, left)[v]
                assert pointwise_union(cells, left, right) == pointwise_union(cells, right, left)
                commutative_checked += 1

                for third in assignments:
                    # 結合律: ((N⊔M)⊔L)(v) = (N(v)∪M(v))∪L(v) = N(v)∪(M(v)∪L(v))
                    left_first = pointwise_union(cells, pointwise_union(cells, left, right), third)
                    right_first = pointwise_union(cells, left, pointwise_union(cells, right, third))
                    for v in cells:
                        assert left_first[v] == (left[v] | right[v]) | third[v]
                        assert (left[v] | right[v]) | third[v] == left[v] | (right[v] | third[v])
                        assert left[v] | (right[v] | third[v]) == right_first[v]
                    assert left_first == right_first
                    associative_checked += 1

print(
    "PASS idempotent={} unit={} commutative_pairs={} associative_triples={}".format(
        idempotent_checked, unit_checked, commutative_checked, associative_checked
    )
)
