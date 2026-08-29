# 対象ラベル: claim_covering_neighborhood_assignment_closure_eq
# 被覆近傍割り当ての反射推移閉包と、部分順序から作る近傍割り当ての両包含・等号を検査する。
# 帰属: 有限集合、有限関係、有限写像表だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        result = closure(cells, covering_assignment(cells, relation))
        full = assignment_from_relation(cells, relation)
        assert all(result[v] <= full[v] for v in cells)
        assert all(full[v] <= result[v] for v in cells)
        assert result == full
        orders_checked += 1

assert orders_checked == 243
print("PASS check_closure_equality")
print("  partial orders checked:", orders_checked)
