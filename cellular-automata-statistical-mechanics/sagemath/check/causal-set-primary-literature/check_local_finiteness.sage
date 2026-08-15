# 対象ラベル: claim_event_order_locally_finite
# 一次文献の区間が有限イベント集合の部分集合であり、したがって有限であることを全数検査する。
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

    for x in event_set:
        for y in event_set:
            interval = primary_literature_interval(x, y, event_set, order)
            assert interval.issubset(event_fset)
            assert len(interval) <= len(event_set)
            assert len(interval) <= (tau + 1) * stage_size
            tested_intervals += 1

    tested_instances += 1

print("instances checked: {}; finite intervals checked: {}".format(tested_instances, tested_intervals))
print("RESULT: PASS")
