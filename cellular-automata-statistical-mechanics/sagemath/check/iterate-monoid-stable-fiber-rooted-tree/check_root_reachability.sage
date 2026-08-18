# 対象ラベル: claim_iterate_monoid_one_period_map_reaches_root
# e_F=m_Fλ_F と F^{m_Fλ_F}(y)=E_F(y)=q を全ファイバー元で検査する。
# 帰属: 非負整数の厳密除法と有限写像の等号だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
reaches = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, powers = rooted_tree_data(table)
    assert e == m * lam
    assert powers[m * lam] == powers[e] == E
    for q in Q:
        for y in fibers[q]:
            assert apply_table_power(F, y, m * lam) == E[y] == q
            reaches += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("fiber elements reaching their roots: {}".format(reaches))
print("RESULT: PASS")
