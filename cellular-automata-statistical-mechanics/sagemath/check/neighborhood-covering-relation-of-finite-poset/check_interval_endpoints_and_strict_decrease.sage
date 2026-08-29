# 対象ラベル: claim_finite_poset_interval_strictly_smaller
# 区間の両端所属と、中間元で分けた二つの区間の真包含・元数減少を段ごとに検査する。
# 帰属: 有限集合、有限関係、ZZ だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
intermediate_elements_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        for v in cells:
            for w in cells:
                if (v, w) not in relation:
                    continue
                interval = order_interval(cells, relation, v, w)
                assert v in interval
                assert w in interval
                for u in interval:
                    if u == v or u == w:
                        continue
                    left = order_interval(cells, relation, v, u)
                    right = order_interval(cells, relation, u, w)
                    assert left < interval
                    assert right < interval
                    assert ZZ(len(left)) < ZZ(len(interval))
                    assert ZZ(len(right)) < ZZ(len(interval))
                    intermediate_elements_checked += 1
        orders_checked += 1

assert orders_checked == 243
print("PASS check_interval_endpoints_and_strict_decrease")
print("  partial orders checked:", orders_checked)
print("  intermediate elements checked:", intermediate_elements_checked)
