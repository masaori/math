# 対象ラベル: claim_iterate_monoid_period_multiple_propagates
# 最小正周期の倍数だけの遅れが衝突開始後に消える各帰納段と、R_F の反復が F^{dλ_F} に一致する各段を検査する。
# 帰属: 有限写像の真理値表と非負整数だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
propagation_steps = 0
composition_steps = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, powers = rooted_tree_data(table)
    M = len(F)
    last = max(mu + M + M * lam, (m + M + 1) * lam)
    powers = power_tables(table, last)
    for n in range(mu, mu + M + 1):
        for d in range(M + 1):
            assert powers[n + d * lam] == powers[n]
            propagation_steps += 1
    current = identity_table(M)
    for d in range(m + M + 1):
        assert current == powers[d * lam]
        current = compose(R, current)
        assert current == powers[(d + 1) * lam]
        composition_steps += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("period-propagation pairs checked: {}".format(propagation_steps))
print("one-period composition steps checked: {}".format(composition_steps))
print("RESULT: PASS")
