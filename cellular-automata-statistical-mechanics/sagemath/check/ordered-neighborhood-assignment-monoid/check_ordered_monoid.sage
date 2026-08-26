# 対象ラベル: claim_finite_neighborhood_assignments_form_ordered_monoid
# N(V) が合成 *、単位元 I_V、点ごとの包含 <= について有限順序モノイドをなすこと、すなわち
# (1) 合成で閉じ、I_V が両側単位元で、結合律が成り立つ（有限モノイド）
# (2) <= が反射・反対称・推移（有限部分順序集合）
# (3) 積が両引数について単調
# の三つを同じ舞台の上で同時に検査する。
# 帰属: 有限集合、有限写像、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

for cell_count in range(0, 3):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)
    universe = set(assignments)
    identity = identity_assignment(cells)
    assert identity in universe
    assert len(universe) == 2 ** (cell_count ** 2)

    # (1) 有限モノイド
    for first in assignments:
        assert compose(cells, identity, first) == first
        assert compose(cells, first, identity) == first
        for second in assignments:
            assert compose(cells, first, second) in universe
            for third in assignments:
                left = compose(cells, compose(cells, first, second), third)
                right = compose(cells, first, compose(cells, second, third))
                assert left == right

    # (2) 有限部分順序集合
    for first in assignments:
        assert precedes(cells, first, first)
        for second in assignments:
            if precedes(cells, first, second) and precedes(cells, second, first):
                assert first == second
            for third in assignments:
                if precedes(cells, first, second) and precedes(cells, second, third):
                    assert precedes(cells, first, third)

    # (3) 積の単調性
    for outer in assignments:
        for outer_upper in assignments:
            if not precedes(cells, outer, outer_upper):
                continue
            for inner in assignments:
                for inner_upper in assignments:
                    if not precedes(cells, inner, inner_upper):
                        continue
                    assert precedes(
                        cells,
                        compose(cells, outer, inner),
                        compose(cells, outer_upper, inner_upper),
                    )

    comparable = sum(
        1
        for first in assignments
        for second in assignments
        if precedes(cells, first, second)
    )
    print(
        "cells={} elements={} comparable_pairs={}".format(
            cell_count, len(universe), comparable
        )
    )

print("PASS ordered monoid axioms verified for |V| <= 2")
