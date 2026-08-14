# 対象ラベル: claim_start_cell_in_propagation_ball
# 各依存経路の始点セルが、終点セルの経路長に対応する伝播球に属することを全数検査する。
# 帰属: 有限集合と ZZ の非負元だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
paths = 0
for tau, stage_size, supports in exhaustive_instances():
    for path in all_nonempty_paths(tau, supports):
        depth = len(path) - 1
        assert path[0][1] in propagation_ball(supports, depth, path[-1][1])
        paths += 1
    instances += 1

print("instances checked: {}; paths checked: {}".format(instances, paths))
print("RESULT: PASS")
