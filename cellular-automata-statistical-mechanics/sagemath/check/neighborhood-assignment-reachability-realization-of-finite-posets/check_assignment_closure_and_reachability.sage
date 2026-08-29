# 対象ラベル: claim_partial_order_neighborhood_assignment_preorder_eq
# 部分順序から作る近傍割り当ての自己近傍性・推移性・閉包との一致・到達関係との一致を段ごとに検査する。
# 帰属: 有限集合と有限関係だけ。浮動小数点と R/C 脱出はない。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_common.sage"))

orders_checked = 0
ordered_pairs_checked = 0
for n in (0, 1, 2, 3, 4):
    cells = tuple(range(n))
    for relation in partial_orders(cells):
        assignment = assignment_from_relation(cells, relation)

        for v in cells:
            assert v in assignment[v]
            for u in assignment[v]:
                for w in assignment[u]:
                    assert (v, u) in relation
                    assert (u, w) in relation
                    assert (v, w) in relation
                    assert w in assignment[v]

        result = closure(cells, assignment)
        assert result == assignment
        for v in cells:
            for w in cells:
                assert reachable(result, v, w) == ((v, w) in relation)
                ordered_pairs_checked += 1
        orders_checked += 1

assert orders_checked == 243
print("PASS check_assignment_closure_and_reachability")
print("  partial orders checked:", orders_checked)
print("  ordered pairs checked:", ordered_pairs_checked)
