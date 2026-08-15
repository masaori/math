# 対象ラベル: claim_down_set_order_convex
# 併せて検証: claim_up_set_order_convex
# 下方集合と上方集合が順序凸であることを全数検査する。
# 帰属: 有限集合の所属・包含だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_down_sets = 0
tested_up_sets = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    order = reflexive_order(event_set, dependency)
    for subset in powerset(event_set):
        if is_down_set(subset, event_set, order):
            assert is_order_convex(subset, event_set, order)
            tested_down_sets += 1
        if is_up_set(subset, event_set, order):
            assert is_order_convex(subset, event_set, order)
            tested_up_sets += 1
    tested_instances += 1

print("instances checked: {}; down sets: {}; up sets: {}".format(tested_instances, tested_down_sets, tested_up_sets))
print("RESULT: PASS")
