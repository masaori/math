# 対象ラベル: claim_antichain_order_convex
# 反鎖が順序凸であることを全数検査する。
# 帰属: 有限集合と有限部分順序の所属だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_antichains = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    order = reflexive_order(event_set, dependency)
    for subset in powerset(event_set):
        if is_antichain(subset, order):
            assert is_order_convex(subset, event_set, order)
            tested_antichains += 1
    tested_instances += 1

print("instances checked: {}; antichains checked: {}".format(tested_instances, tested_antichains))
print("RESULT: PASS")
