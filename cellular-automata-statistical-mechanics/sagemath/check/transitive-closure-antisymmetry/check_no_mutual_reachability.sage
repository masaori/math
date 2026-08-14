# 対象ラベル: claim_no_mutual_reachability
# 到達可能関係に相互到達も自己到達もないことを全数検査する。
# 併せて検証: claim_reachability_irreflexive
# 帰属: 有限集合と非負整数の大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_reachable_pairs = 0
for tau, stage_size, event_set, relation in exhaustive_instances():
    closure = reachability(event_set, relation)
    for a, b in closure:
        assert a[0] < b[0]
        assert (b, a) not in closure
        assert a != b
        tested_reachable_pairs += 1
    assert all((a, a) not in closure for a in event_set)
    tested_instances += 1

print("instances checked: {}; reachable pairs checked: {}".format(tested_instances, tested_reachable_pairs))
print("RESULT: PASS")
