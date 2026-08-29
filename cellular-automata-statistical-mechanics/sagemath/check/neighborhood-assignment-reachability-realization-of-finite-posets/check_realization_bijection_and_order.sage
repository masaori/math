# 対象ラベル: claim_partial_order_quotient_realization_order
# 一元集合への実現写像の全単射性と、部分順序を商の順序へ両方向に移すことを検査する。
# 帰属: 有限集合、有限写像表、有限関係だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
ordered_pairs_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        assignment = assignment_from_relation(cells, relation)
        result = closure(cells, assignment)
        quotient = component_set(cells, result)
        realization = {v: frozenset((v,)) for v in cells}

        assert set(realization.values()) == set(quotient)
        assert len(set(realization.values())) == len(cells)
        for v in cells:
            assert realization[v] in quotient
            for w in cells:
                if realization[v] == realization[w]:
                    assert v == w
                quotient_relation = quotient_order(result, realization[v], realization[w])
                assert quotient_relation == reachable(result, v, w)
                assert quotient_relation == ((v, w) in relation)
                ordered_pairs_checked += 1
        orders_checked += 1

assert orders_checked == 243
print("PASS check_realization_bijection_and_order")
print("  partial orders checked:", orders_checked)
print("  ordered pairs checked:", ordered_pairs_checked)
