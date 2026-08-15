# 対象ラベル: claim_order_interval_finite
# 各順序区間がイベント集合の部分集合であり、その個数以下であることを全数検査する。
# 帰属: 有限集合と非負整数の等号・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_intervals = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    event_fset = frozenset(event_set)
    order = reflexive_order(event_set, dependency)
    assert len(event_set) == (tau + 1) * stage_size
    for a in event_set:
        for b in event_set:
            interval = order_interval(a, b, event_set, order)
            assert interval.issubset(event_fset)
            assert len(interval) <= len(event_set)
            assert len(interval) <= (tau + 1) * stage_size
            tested_intervals += 1
    tested_instances += 1

print("instances checked: {}; intervals checked: {}".format(tested_instances, tested_intervals))
print("RESULT: PASS")
