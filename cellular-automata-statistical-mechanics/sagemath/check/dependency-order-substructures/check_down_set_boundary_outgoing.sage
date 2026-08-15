# 対象ラベル: claim_down_set_boundary_outgoing
# 下方集合の一段境界が外向きの一段依存だけで定まることを全数検査する。
# 併せて検証: def_one_step_boundary
# 帰属: 有限集合と有限関係の所属・集合の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_down_sets = 0
tested_boundary_elements = 0
for tau, stage_size, event_set, dependency in exhaustive_instances():
    order = reflexive_order(event_set, dependency)
    for subset in powerset(event_set):
        if not is_down_set(subset, event_set, order):
            continue
        boundary = one_step_boundary(subset, event_set, dependency)
        outgoing = outgoing_boundary(subset, event_set, dependency)
        assert boundary == outgoing
        tested_down_sets += 1
        tested_boundary_elements += len(boundary)
    tested_instances += 1

print("instances checked: {}; down sets: {}; boundary elements: {}".format(tested_instances, tested_down_sets, tested_boundary_elements))
print("RESULT: PASS")
