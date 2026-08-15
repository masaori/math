# 対象ラベル: claim_event_order_locally_finite
# 反射的到達可能関係が有限イベント集合上の部分順序であることを全数検査する。
# 帰属: 有限集合、有限関係、非負整数の等号・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_ordered_pairs = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    order = reflexive_order(event_set, dependency)

    for a in event_set:
        assert (a, a) in order

    for a in event_set:
        for b in event_set:
            if (a, b) in order and (b, a) in order:
                assert a == b
            for c in event_set:
                if (a, b) in order and (b, c) in order:
                    assert (a, c) in order

    tested_instances += 1
    tested_ordered_pairs += len(order)

print("instances checked: {}; ordered pairs checked: {}".format(tested_instances, tested_ordered_pairs))
print("RESULT: PASS")
