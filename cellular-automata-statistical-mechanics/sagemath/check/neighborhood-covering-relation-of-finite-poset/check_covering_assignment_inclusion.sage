# 対象ラベル: claim_covering_neighborhood_assignment_included
# 被覆近傍割り当てが関係から作る近傍割り当てに点ごとに含まれることを検査する。
# 帰属: 有限集合と有限関係だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
cover_edges_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        covers = covering_relation(cells, relation)
        covered = covering_assignment(cells, relation)
        full = assignment_from_relation(cells, relation)
        for v, w in covers:
            assert (v, w) in relation
            assert w in covered[v]
            cover_edges_checked += 1
        for v in cells:
            assert covered[v] <= full[v]
        orders_checked += 1

assert orders_checked == 243
print("PASS check_covering_assignment_inclusion")
print("  partial orders checked:", orders_checked)
print("  cover edges checked:", cover_edges_checked)
