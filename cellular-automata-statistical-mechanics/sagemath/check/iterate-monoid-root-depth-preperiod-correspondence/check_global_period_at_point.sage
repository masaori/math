# 対象ラベル: claim_iterate_monoid_global_period_at_point_min_preperiod
# 全配位 y について μ(y) <= μ_F と F^{μ(y)+λ_F}(y) = F^{μ(y)}(y) を検査する。
# 帰属: 有限写像の等号と非負整数の大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, mu_of = correspondence_data(table)
    for y in range(len(F)):
        mu_y = mu_of[y]
        assert mu_y <= mu
        assert apply_table_power(F, y, mu_y + lam) == apply_table_power(F, y, mu_y)
        points += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("configurations with transported period: {}".format(points))
print("RESULT: PASS")
