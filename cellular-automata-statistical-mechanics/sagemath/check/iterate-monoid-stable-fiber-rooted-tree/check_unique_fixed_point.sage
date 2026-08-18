# 対象ラベル: claim_iterate_monoid_one_period_map_unique_fixed_point
# 各根が R_F の不動点であり、各安定ファイバー内の R_F 不動点集合が根の一元集合に等しいことを検査する。
# 帰属: 有限写像と有限集合の等号だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
fibers_checked = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, powers = rooted_tree_data(table)
    for q in Q:
        assert R[q] == q
        fixed = frozenset(y for y in fibers[q] if R[y] == y)
        assert fixed == frozenset([q])
        for y in fixed:
            for d in range(m + 1):
                assert apply_table_power(F, y, d * lam) == y
            assert apply_table_power(F, y, m * lam) == q
        fibers_checked += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("stable fibers with unique fixed root: {}".format(fibers_checked))
print("RESULT: PASS")
