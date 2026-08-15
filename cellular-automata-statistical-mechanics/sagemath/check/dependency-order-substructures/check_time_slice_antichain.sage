# 対象ラベル: claim_time_slice_antichain
# 同じ時刻に属する相異なるイベントが比較不能であることを全数検査する。
# 帰属: 有限集合と非負整数の等号・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_slices = 0
tested_distinct_pairs = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    order = reflexive_order(event_set, dependency)
    for time in range(tau + 1):
        time_slice = frozenset(event for event in event_set if event[0] == time)
        assert is_antichain(time_slice, order)
        for a in time_slice:
            for b in time_slice:
                if a != b:
                    assert incomparable(a, b, order)
                    tested_distinct_pairs += 1
        tested_slices += 1
    tested_instances += 1

print("instances checked: {}; time slices: {}; distinct pairs: {}".format(tested_instances, tested_slices, tested_distinct_pairs))
print("RESULT: PASS")
