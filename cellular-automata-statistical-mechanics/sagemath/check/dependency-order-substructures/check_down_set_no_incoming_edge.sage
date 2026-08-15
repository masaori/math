# 対象ラベル: claim_down_set_no_incoming_edge
# 下方集合へ外部から入る一段依存が存在しないことを全数検査する。
# 帰属: 有限集合と有限関係の所属だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_down_sets = 0
tested_edges = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    order = reflexive_order(event_set, dependency)
    for subset in powerset(event_set):
        if not is_down_set(subset, event_set, order):
            continue
        outside = frozenset(event_set) - subset
        assert all(not (b in outside and a in subset) for b, a in dependency)
        tested_down_sets += 1
        tested_edges += len(dependency)
    tested_instances += 1

print("instances checked: {}; down sets: {}; dependency-edge observations: {}".format(tested_instances, tested_down_sets, tested_edges))
print("RESULT: PASS")
