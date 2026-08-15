# 対象ラベル: claim_fixed_iff_min_period_divides
# F^n y = y と、mu(y)=0 かつ pi(y) が n を割り切ることの同値を検査する。
# 帰属: 有限集合と非負整数の等号・剰余だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_exponents = 0
for name, state_count, prefix in exhaustive_instances():
    mu, pi = direct_min_preperiod_period(prefix)
    for exponent in range(1, 2 * state_count + 1):
        expected = (mu == 0 and exponent % pi == 0)
        assert fixed_by(prefix, exponent) == expected, (name, exponent, mu, pi)
        tested_exponents += 1
    tested_instances += 1

print("orbit instances checked: {}; exponents checked: {}".format(
    tested_instances, tested_exponents
))
print("RESULT: PASS")
