# 対象ラベル: claim_iterate_monoid_one_period_map_preserves_fiber
# E_F(R_F(y))=E_F(y)=q の各段と R_F(y)∈B_F(q) を全ファイバー元で検査する。
# 帰属: 有限写像の等号・有限集合の所属だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
memberships = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, powers = rooted_tree_data(table)
    assert compose(E, R) == powers[e + lam]
    assert powers[e + lam] == powers[e]
    for q in Q:
        for y in fibers[q]:
            assert E[R[y]] == E[y]
            assert E[y] == q
            assert R[y] in fibers[q]
            memberships += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("fiber memberships checked: {}".format(memberships))
print("RESULT: PASS")
