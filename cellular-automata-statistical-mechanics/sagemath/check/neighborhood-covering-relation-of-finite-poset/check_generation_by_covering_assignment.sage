# 対象ラベル: claim_covering_neighborhood_assignment_generates
# 部分順序の各対が被覆近傍割り当ての反射推移閉包で到達できることを検査する。
# 帰属: 有限集合、有限関係、有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
ordered_pairs_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        result = closure(cells, covering_assignment(cells, relation))
        for v, w in relation:
            assert reachable(result, v, w)
            ordered_pairs_checked += 1
        orders_checked += 1

assert orders_checked == 243
print("PASS check_generation_by_covering_assignment")
print("  partial orders checked:", orders_checked)
print("  ordered pairs checked:", ordered_pairs_checked)
