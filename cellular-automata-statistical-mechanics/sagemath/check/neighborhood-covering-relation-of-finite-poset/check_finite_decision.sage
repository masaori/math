# 対象ラベル: claim_finite_poset_covering_relation_finite_decidable
# 本文どおり全組・全候補元を走査し、被覆関係と判定回数の修正後の上界を検査する。
# 帰属: 有限集合、有限関係、ZZ だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
pairs_scanned = ZZ(0)
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        computed = set()
        local_pairs = ZZ(0)
        for v in cells:
            for w in cells:
                local_pairs += 1
                relation_tests = ZZ(1)
                equality_tests = ZZ(1)
                in_relation = (v, w) in relation
                distinct = v != w
                no_intermediate = True
                for u in cells:
                    relation_tests += 1
                    left = (v, u) in relation
                    right = False
                    if left:
                        relation_tests += 1
                        right = (u, w) in relation
                    if left and right:
                        equality_tests += 1
                        is_left_endpoint = u == v
                        is_right_endpoint = False
                        if not is_left_endpoint:
                            equality_tests += 1
                            is_right_endpoint = u == w
                        if not is_left_endpoint and not is_right_endpoint:
                            no_intermediate = False
                if in_relation and distinct and no_intermediate:
                    computed.add((v, w))
                assert relation_tests <= 2 * n + 1
                assert equality_tests <= 2 * n + 1
        assert local_pairs == n ** 2
        assert frozenset(computed) == covering_relation(cells, relation)
        pairs_scanned += local_pairs
        orders_checked += 1

assert orders_checked == 243
print("PASS check_finite_decision")
print("  partial orders checked:", orders_checked)
print("  pairs scanned:", pairs_scanned)
