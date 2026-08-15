# 対象ラベル: claim_one_step_equals_covering
# 一段依存関係と到達可能関係の被覆関係が集合として一致することを全数検査する。
# 帰属: 有限集合と有限関係の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_pairs = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    covering = covering_relation(event_set, reachability(event_set, dependency))
    assert dependency == covering
    tested_instances += 1
    tested_pairs += len(dependency)

print("instances checked: {}; equal-relation pairs checked: {}".format(tested_instances, tested_pairs))
print("RESULT: PASS")
