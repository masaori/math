# 対象ラベル: claim_reachability_minimal
# C_tau が D_tau を含む全ての推移的関係に含まれることを、小さいイベント集合で全数検査する。
# 帰属: 有限集合の包含・所属だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_dependencies = 0
tested_transitive_supersets = 0
for stage_size in range(3):
    for tau in range(3):
        event_set = events(tau, stage_size)
        if len(event_set) > 3:
            continue
        all_pairs = tuple((a, b) for a in event_set for b in event_set)
        for dependency in powerset(adjacent_edges(tau, stage_size)):
            closure = reachability(event_set, dependency)
            for candidate in powerset(all_pairs):
                if dependency.issubset(candidate) and is_transitive(candidate):
                    assert closure.issubset(candidate)
                    tested_transitive_supersets += 1
            tested_dependencies += 1

print("dependencies checked: {}; transitive supersets checked: {}".format(tested_dependencies, tested_transitive_supersets))
print("RESULT: PASS")
