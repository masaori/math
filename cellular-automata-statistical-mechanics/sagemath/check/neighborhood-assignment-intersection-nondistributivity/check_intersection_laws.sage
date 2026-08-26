# 対象ラベル: claim_neighborhood_assignment_pointwise_intersection_laws
# 点ごとの積が可換・結合的・冪等であり、U_V がその単位元であることを、
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
    full = full_assignment(cells)

    for assignment in assignments:
        # 冪等律: (N⊓N)(v) = N(v) ∩ N(v) = N(v)
        for v in cells:
            assert pointwise_intersection(cells, assignment, assignment)[v] == assignment[v] & assignment[v]
            assert assignment[v] & assignment[v] == assignment[v]
        assert pointwise_intersection(cells, assignment, assignment) == assignment
        idempotent_checked += 1

        # 単位律: (N⊓U_V)(v) = N(v) ∩ V = N(v)。V は全体集合なので N(v) ⊆ V である
        for v in cells:
            assert full[v] == frozenset(cells)
            assert assignment[v] <= frozenset(cells)
            assert pointwise_intersection(cells, assignment, full)[v] == assignment[v] & frozenset(cells)
            assert assignment[v] & frozenset(cells) == assignment[v]
        assert pointwise_intersection(cells, assignment, full) == assignment
        assert pointwise_intersection(cells, full, assignment) == assignment
        unit_checked += 1

    if cell_count <= 2:
        for left in assignments:
            for right in assignments:
                # 可換律: (N⊓M)(v) = N(v) ∩ M(v) = M(v) ∩ N(v) = (M⊓N)(v)
                for v in cells:
                    assert pointwise_intersection(cells, left, right)[v] == left[v] & right[v]
                    assert left[v] & right[v] == right[v] & left[v]
                    assert right[v] & left[v] == pointwise_intersection(cells, right, left)[v]
                assert pointwise_intersection(cells, left, right) == pointwise_intersection(cells, right, left)
                commutative_checked += 1

                for third in assignments:
                    # 結合律: ((N⊓M)⊓L)(v) = (N(v)∩M(v))∩L(v) = N(v)∩(M(v)∩L(v))
                    left_first = pointwise_intersection(cells, pointwise_intersection(cells, left, right), third)
                    right_first = pointwise_intersection(cells, left, pointwise_intersection(cells, right, third))
                    for v in cells:
                        assert left_first[v] == (left[v] & right[v]) & third[v]
                        assert (left[v] & right[v]) & third[v] == left[v] & (right[v] & third[v])
                        assert left[v] & (right[v] & third[v]) == right_first[v]
                    assert left_first == right_first
                    associative_checked += 1

print(
    "PASS idempotent={} unit={} commutative_pairs={} associative_triples={}".format(
        idempotent_checked, unit_checked, commutative_checked, associative_checked
    )
)
