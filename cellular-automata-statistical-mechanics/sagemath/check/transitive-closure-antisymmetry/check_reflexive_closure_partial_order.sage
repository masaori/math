# 対象ラベル: claim_reachability_partial_order
# 到達可能関係の反射閉包が反射的・反対称・推移的であることを全数検査する。
# 帰属: 有限集合の等号・所属だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_order_pairs = 0
for tau, stage_size, event_set, relation in exhaustive_instances():
    order = reflexive_closure(event_set, reachability(event_set, relation))
    assert is_partial_order(event_set, order)
    tested_instances += 1
    tested_order_pairs += len(order)

print("instances checked: {}; order pairs checked: {}".format(tested_instances, tested_order_pairs))
print("RESULT: PASS")
