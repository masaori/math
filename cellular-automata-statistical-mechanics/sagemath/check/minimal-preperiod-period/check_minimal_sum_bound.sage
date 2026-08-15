# 対象ラベル: claim_min_preperiod_period_bound
# 最小前周期と最小周期の和が有限状態集合の個数以下であることを検査する。
# 帰属: 有限集合と非負整数の等号・加法・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
for name, state_count, prefix in exhaustive_instances():
    mu, pi = direct_min_preperiod_period(prefix)
    assert pi >= 1, (name, mu, pi)
    assert mu + pi <= state_count, (name, state_count, mu, pi)
    tested_instances += 1

print("orbit instances checked: {}".format(tested_instances))
print("RESULT: PASS")
