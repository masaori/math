# 対象ラベル: claim_path_time_increment_exact
# 各依存経路で終点時刻 = 始点時刻 + 経路長となることを全数検査する。
# 帰属: 有限集合と ZZ の非負元だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
paths = 0
for tau, stage_size, supports in exhaustive_instances():
    for path in all_nonempty_paths(tau, supports):
        length = ZZ(len(path) - 1)
        assert ZZ(path[-1][0]) == ZZ(path[0][0]) + length
        paths += 1
    instances += 1

print("instances checked: {}; paths checked: {}".format(instances, paths))
print("RESULT: PASS")
