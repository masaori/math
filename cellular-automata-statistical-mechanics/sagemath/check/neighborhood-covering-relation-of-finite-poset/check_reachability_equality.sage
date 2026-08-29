# 対象ラベル: claim_covering_neighborhood_assignment_reachability_eq
# 被覆近傍割り当ての到達関係が、与えた部分順序と各組で一致することを検査する。
# 帰属: 有限集合、有限関係、有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
pairs_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        result = closure(cells, covering_assignment(cells, relation))
        for v in cells:
            for w in cells:
                assert reachable(result, v, w) == ((v, w) in relation)
                pairs_checked += 1
        orders_checked += 1

assert orders_checked == 243
print("PASS check_reachability_equality")
print("  partial orders checked:", orders_checked)
print("  pairs checked:", pairs_checked)
