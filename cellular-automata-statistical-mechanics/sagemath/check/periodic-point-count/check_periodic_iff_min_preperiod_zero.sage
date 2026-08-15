# 対象ラベル: claim_periodic_iff_min_preperiod_zero
# 周期点であることと最小前周期が 0 であることの同値を検査する。
# 帰属: 有限集合と非負整数の等号・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
for name, state_count, prefix in exhaustive_instances():
    mu, _ = direct_min_preperiod_period(prefix)
    assert is_periodic(prefix, state_count) == (mu == 0), (name, mu)
    tested_instances += 1

print("orbit instances checked: {}".format(tested_instances))
print("RESULT: PASS")
