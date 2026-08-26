# 対象ラベル: claim_neighborhood_assignment_pointwise_inclusion_partial_order
# 点ごとの包含 <= が N(V) 上の部分順序（反射律・反対称律・推移律）であることを、
# 本文の証明の三段に分けて検査する。
# 帰属: 有限集合と有限写像だけを使う。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

reflexive_checked = 0
antisymmetric_checked = 0
transitive_checked = 0

for cell_count in range(1, 4):
    cells = tuple(range(cell_count))
    assignments = neighborhood_assignments(cells)

    # 反射律: 各 v で N(v) ⊆ N(v)
    for assignment in assignments:
        for v in cells:
            assert assignment[v] <= assignment[v]
        assert precedes(cells, assignment, assignment)
        reflexive_checked += 1

    if cell_count <= 2:
        # 反対称律: N <= M かつ M <= N から、各 v で N(v) = M(v)、写像の外延性で N = M
        for lower in assignments:
            for upper in assignments:
                if precedes(cells, lower, upper) and precedes(cells, upper, lower):
                    for v in cells:
                        assert lower[v] == upper[v]
                    assert lower == upper
                antisymmetric_checked += 1

        # 推移律: w ∈ N(v) → w ∈ M(v) → w ∈ L(v)
        for first in assignments:
            for second in assignments:
                if not precedes(cells, first, second):
                    continue
                for third in assignments:
                    if not precedes(cells, second, third):
                        continue
                    for v in cells:
                        for w in first[v]:
                            assert w in second[v]
                            assert w in third[v]
                        assert first[v] <= third[v]
                    assert precedes(cells, first, third)
                    transitive_checked += 1

print(
    "PASS reflexive={} antisymmetric_pairs={} transitive_triples={}".format(
        reflexive_checked, antisymmetric_checked, transitive_checked
    )
)
