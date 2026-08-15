# 対象ラベル: claim_period_descends_to_min_preperiod
# 有限範囲の全周期組について、周期が最小前周期の位置でも成立し最小周期以上であることを検査する。
# 帰属: 有限集合と非負整数の等号・加法・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_periodicity_pairs = 0
for name, state_count, prefix in exhaustive_instances():
    mu, pi = direct_min_preperiod_period(prefix)
    for preperiod in range(state_count + 1):
        for period in range(1, state_count + 1):
            if periodicity_pair_in_window(prefix, preperiod, period, state_count):
                assert prefix[mu + period] == prefix[mu], (name, preperiod, period)
                assert pi <= period, (name, preperiod, period, mu, pi)
                tested_periodicity_pairs += 1
    tested_instances += 1

print("orbit instances checked: {}; periodicity pairs checked: {}".format(
    tested_instances, tested_periodicity_pairs
))
print("RESULT: PASS")
