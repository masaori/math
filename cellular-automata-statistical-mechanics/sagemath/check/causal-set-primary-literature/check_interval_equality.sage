# 対象ラベル: claim_event_order_locally_finite
# 一次文献の区間 A_R(x,y) と前章の区間 I_tau(a,b) が集合として一致することを全数検査する。
# 二つの区間は独立した手続きで構成して比較する。
# 帰属: 有限集合と有限関係の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_equalities = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    order = reflexive_order(event_set, dependency)

    for a in event_set:
        for b in event_set:
            primary_interval = primary_literature_interval(a, b, event_set, order)
            previous_interval = previous_chapter_interval(a, b, event_set, order)
            assert primary_interval == previous_interval
            tested_equalities += 1

    tested_instances += 1

print("instances checked: {}; interval equalities checked: {}".format(tested_instances, tested_equalities))
print("RESULT: PASS")
