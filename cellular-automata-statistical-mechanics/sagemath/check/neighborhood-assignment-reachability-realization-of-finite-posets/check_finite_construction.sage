# 対象ラベル: claim_partial_order_quotient_realization_finite_decidable
# 近傍割り当て・商・実現写像の本文どおりの有限構成と判定回数の上界を検査する。
# 帰属: 有限集合、有限写像表、ZZ だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        relation_membership_tests = ZZ(0)
        assignment_table = []
        for v in cells:
            neighbors = []
            for w in cells:
                relation_membership_tests += 1
                if (v, w) in relation:
                    neighbors.append(w)
            assignment_table.append(frozenset(neighbors))

        assert tuple(assignment_table) == assignment_from_relation(cells, relation)
        assert relation_membership_tests == n ** 2

        singleton_writes = ZZ(0)
        quotient = []
        realization = {}
        for v in cells:
            singleton = frozenset((v,))
            singleton_writes += 1
            quotient.append(singleton)
            realization[v] = singleton

        assert tuple(quotient) == singleton_quotient(cells)
        assert set(realization.values()) == set(quotient)
        assert singleton_writes == n
        orders_checked += 1

assert orders_checked == 243
print("PASS check_finite_construction")
print("  partial orders checked:", orders_checked)
