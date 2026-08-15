# 対象ラベル: claim_covering_subset_one_step
# 到達可能だが一段辺でない対には、経路の最初の一段を終点とする中間イベントがあることを全数検査する。
# 帰属: 有限集合と有限関係の所属だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_covering_pairs = 0
tested_non_edges = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    closure = reachability(event_set, dependency)
    covering = covering_relation(event_set, closure)
    assert covering.issubset(dependency)
    for a, b in covering:
        assert (a, b) in dependency
        tested_covering_pairs += 1
    for a, b in closure - dependency:
        assert any((a, c) in closure and (c, b) in closure for c in event_set)
        tested_non_edges += 1
    tested_instances += 1

print("instances checked: {}; covering pairs: {}; non-edge reachable pairs: {}".format(
    tested_instances, tested_covering_pairs, tested_non_edges))
print("RESULT: PASS")
