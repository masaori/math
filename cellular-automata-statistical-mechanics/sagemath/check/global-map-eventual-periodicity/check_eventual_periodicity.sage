# 対象ラベル: claim_finite_self_map_repeating_tail
# 衝突から得る p = j-i が正で、i+p <= 2^|V| かつ F^(n+p)y = F^n y となることを検査する。
# 帰属: 有限集合と非負整数の等号・大小比較・加減算だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

tested_instances = 0
tested_periodic_equalities = 0
for stage_size, rule, initial, prefix in exhaustive_instances():
    bound = 2 ** stage_size
    left, right = collision_pairs(prefix, bound)[0]
    period = right - left
    assert period >= 1
    assert left + period == right
    assert left + period <= bound
    for exponent in range(left, left + 2 * bound + 1):
        assert prefix[exponent + period] == prefix[exponent]
        tested_periodic_equalities += 1
    tested_instances += 1

print("orbit instances checked: {}; periodic equalities checked: {}".format(tested_instances, tested_periodic_equalities))
print("RESULT: PASS")
