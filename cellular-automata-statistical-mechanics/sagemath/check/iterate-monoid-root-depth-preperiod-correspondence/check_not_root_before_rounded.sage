# 対象ラベル: claim_iterate_monoid_before_rounded_preperiod_not_root
# 全ての q ∈ Q_F、y ∈ B_F(q)、d < r_F(y) について F^{d·λ_F}(y) ≠ q を検査する。
# 帰属: 有限写像の反復適用と有限集合の等号の否定だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
pairs = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, mu_of = correspondence_data(table)
    for q in Q:
        for y in fibers[q]:
            c = rounded_preperiod(mu_of[y], lam, m)
            for d in range(c):
                assert apply_table_power(F, y, d * lam) != q
                pairs += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("earlier multiples verified not to reach the root: {}".format(pairs))
print("RESULT: PASS")
