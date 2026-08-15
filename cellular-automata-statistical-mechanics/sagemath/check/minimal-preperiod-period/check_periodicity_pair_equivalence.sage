# 対象ラベル: claim_periodicity_pair_iff_collision
# (i,p) の周期性と F^(i+p)y = F^i y の同値を、各有限軌道の有限窓で検査する。
# 帰属: 有限集合と非負整数の等号・加法・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_pairs = 0
for name, state_count, prefix in exhaustive_instances():
    for preperiod in range(state_count + 1):
        for period in range(1, state_count + 1):
            collision = prefix[preperiod + period] == prefix[preperiod]
            periodic = periodicity_pair_in_window(prefix, preperiod, period, state_count)
            assert periodic == collision, (name, preperiod, period)
            tested_pairs += 1
    tested_instances += 1

print("orbit instances checked: {}; pairs checked: {}".format(tested_instances, tested_pairs))
print("RESULT: PASS")
