# 対象ラベル: claim_min_preperiod_period_finite_decidability
# 有限範囲の走査値が、最初の再訪から独立に得た最小前周期・最小周期と一致することを検査する。
# 帰属: 有限集合と非負整数の等号・加減算・最小値だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_candidates = 0
for name, state_count, prefix in exhaustive_instances():
    direct_mu, direct_pi = direct_min_preperiod_period(prefix)
    scan_mu, scan_pi, candidates = scanned_min_preperiod_period(prefix, state_count)
    assert scan_mu == direct_mu, (name, scan_mu, direct_mu)
    assert scan_pi == direct_pi, (name, scan_pi, direct_pi)
    assert len(tuple(
        (left, right)
        for left in range(state_count + 1)
        for right in range(left + 1, state_count + 1)
    )) == state_count * (state_count + 1) // 2
    tested_candidates += len(candidates)
    tested_instances += 1

print("orbit instances checked: {}; successful scan candidates checked: {}".format(
    tested_instances, tested_candidates
))
print("RESULT: PASS")
