# 対象ラベル: claim_partial_order_neighborhood_assignment_quotient_singletons
# 相互到達成分が一元集合であり、商が一元集合の全体に一致することを分けて検査する。
# 帰属: 有限集合と有限関係だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
components_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    expected_quotient = singleton_quotient(cells)
    for relation in partial_orders(cells):
        assignment = assignment_from_relation(cells, relation)
        result = closure(cells, assignment)
        component_assignment = components(cells, result)

        for v in cells:
            expected = frozenset((v,))
            for w in cells:
                mutually_reachable = reachable(result, v, w) and reachable(result, w, v)
                assert mutually_reachable == ((v, w) in relation and (w, v) in relation)
                assert mutually_reachable == (v == w)
            assert component_assignment[v] == expected
            components_checked += 1

        quotient = component_set(cells, result)
        assert quotient == expected_quotient
        orders_checked += 1

assert orders_checked == 243
print("PASS check_singleton_components_and_quotient")
print("  partial orders checked:", orders_checked)
print("  components checked:", components_checked)
