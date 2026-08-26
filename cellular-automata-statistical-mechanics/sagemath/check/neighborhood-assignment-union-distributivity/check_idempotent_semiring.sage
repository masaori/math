# 対象ラベル: claim_finite_neighborhood_assignments_form_idempotent_semiring
# 同じ舞台の上で、冪等可換モノイド（和）・モノイド（合成）・両側分配・空近傍の吸収が
# 同時に成り立つことと、両演算の表が有限走査で決定できることを検査する。
# 帰属: 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

for cell_count in range(0, 3):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    unit = identity_assignment(cells)
    zero = empty_assignment(cells)
    element_count = len(assignments)
    assert element_count == (2 ** cell_count) ** cell_count

    index = {assignment: position for position, assignment in enumerate(assignments)}
    union_table = {}
    compose_table = {}
    for left in assignments:
        for right in assignments:
            union = pointwise_union(cells, left, right)
            composed = compose(cells, left, right)
            # 両演算の値が再び N(V) の元であること（表が閉じていること）
            assert union in index
            assert composed in index
            union_table[(index[left], index[right])] = index[union]
            compose_table[(index[left], index[right])] = index[composed]
    assert len(union_table) == element_count ** 2
    assert len(compose_table) == element_count ** 2

    for left in assignments:
        # 和の単位元と冪等律、合成の単位元、合成の吸収元
        assert pointwise_union(cells, left, zero) == left
        assert pointwise_union(cells, zero, left) == left
        assert pointwise_union(cells, left, left) == left
        assert compose(cells, unit, left) == left
        assert compose(cells, left, unit) == left
        assert compose(cells, zero, left) == zero
        assert compose(cells, left, zero) == zero

        for right in assignments:
            assert pointwise_union(cells, left, right) == pointwise_union(cells, right, left)

            for third in assignments:
                assert pointwise_union(
                    cells, pointwise_union(cells, left, right), third
                ) == pointwise_union(cells, left, pointwise_union(cells, right, third))
                assert compose(cells, compose(cells, left, right), third) == compose(
                    cells, left, compose(cells, right, third)
                )
                assert compose(cells, pointwise_union(cells, left, right), third) == pointwise_union(
                    cells, compose(cells, left, third), compose(cells, right, third)
                )
                assert compose(cells, third, pointwise_union(cells, left, right)) == pointwise_union(
                    cells, compose(cells, third, left), compose(cells, third, right)
                )

    print(
        "  |V|={} elements={} union_table={} compose_table={}".format(
            cell_count, element_count, len(union_table), len(compose_table)
        )
    )

print("PASS idempotent semiring axioms verified for |V| <= 2")
