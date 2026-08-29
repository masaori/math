# 対象ラベル: claim_iterate_monoid_rounded_preperiod_reaches_root
# 全ての q ∈ Q_F と y ∈ B_F(q) について F^{r_F(y)·λ_F}(y) = q を検査する。
# 帰属: 有限写像の反復適用と有限集合の等号だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, mu_of = correspondence_data(table)
    for q in Q:
        for y in fibers[q]:
            c = rounded_preperiod(mu_of[y], lam, m)
            assert apply_table_power(F, y, c * lam) == q
            points += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("fiber elements reaching their roots at r_F(y): {}".format(points))
print("RESULT: PASS")
