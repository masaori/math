# 対象ラベル: claim_one_step_subset_covering
# 隣接時刻間の一段関係の各辺に、到達可能な中間イベントが存在しないことを全数検査する。
# 帰属: 有限集合・有限関係と非負整数の大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_edges = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    closure = reachability(event_set, dependency)
    covering = covering_relation(event_set, closure)
    assert dependency.issubset(covering)
    for a, b in dependency:
        assert b[0] == a[0] + 1
        assert not any((a, c) in closure and (c, b) in closure for c in event_set)
        tested_edges += 1
    tested_instances += 1

print("instances checked: {}; one-step edges checked: {}".format(tested_instances, tested_edges))
print("RESULT: PASS")
