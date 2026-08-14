# 対象ラベル: claim_one_step_subset_reachability
# 一段依存関係が長さ 1 の経路として到達可能関係に含まれることを全数検査する。
# 帰属: 有限集合の所属だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_edges = 0
for tau, stage_size, event_set, relation in exhaustive_instances():
    closure = reachability(event_set, relation)
    assert relation.issubset(closure)
    tested_instances += 1
    tested_edges += len(relation)

print("instances checked: {}; one-step edges checked: {}".format(tested_instances, tested_edges))
print("RESULT: PASS")
