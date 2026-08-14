# 対象ラベル: claim_reachability_transitive
# 二経路の連結が経路であり、到達可能関係が推移的であることを全数検査する。
# 帰属: 有限列と有限集合の所属だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_concatenations = 0
for tau, stage_size, event_set, relation in exhaustive_instances():
    paths = all_nonempty_paths(event_set, relation)
    closure = reachability(event_set, relation)
    assert is_transitive(closure)
    for first in paths:
        for second in paths:
            if first[-1] != second[0]:
                continue
            concatenated = first + second[1:]
            assert all((concatenated[index], concatenated[index + 1]) in relation for index in range(len(concatenated) - 1))
            assert (concatenated[0], concatenated[-1]) in closure
            tested_concatenations += 1
    tested_instances += 1

print("instances checked: {}; path concatenations checked: {}".format(tested_instances, tested_concatenations))
print("RESULT: PASS")
