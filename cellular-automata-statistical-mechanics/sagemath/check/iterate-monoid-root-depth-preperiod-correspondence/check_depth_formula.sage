# 対象ラベル: claim_iterate_monoid_fiber_tree_depth_equals_rounded_preperiod
# 全ての q ∈ Q_F と y ∈ B_F(q) について、根付き木の深さ d_F(y)
# （def_iterate_monoid_fiber_tree_depth の有限走査）が r_F(y) に一致することを検査する。
# 帰属: 有限写像の反復適用、有限集合の等号、非負整数の乗算・大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, mu_of = correspondence_data(table)
    for q in Q:
        for y in fibers[q]:
            depth = tree_depth(F, lam, m, y, q)
            c = rounded_preperiod(mu_of[y], lam, m)
            assert depth == c
            points += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("fiber elements with d_F(y) = r_F(y): {}".format(points))
print("RESULT: PASS")
