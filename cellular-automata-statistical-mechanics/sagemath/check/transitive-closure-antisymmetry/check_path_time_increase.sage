# 対象ラベル: claim_path_time_strictly_increases
# 全依存経路の始点時刻が終点時刻より小さいことを有限範囲で全数検査する。
# 帰属: 有限集合と非負整数の大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_paths = 0
for tau, stage_size, event_set, relation in exhaustive_instances():
    for path in all_nonempty_paths(event_set, relation):
        assert path[0][0] < path[-1][0]
        assert all(path[index][0] < path[index + 1][0] for index in range(len(path) - 1))
        tested_paths += 1
    tested_instances += 1

print("instances checked: {}; paths checked: {}".format(tested_instances, tested_paths))
print("RESULT: PASS")
