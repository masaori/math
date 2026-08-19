# 対象ラベル: claim_iterate_monoid_conjugacy_transports_one_period_map
# 併せて claim_iterate_monoid_conjugacy_transports_one_period_iterates と
# claim_iterate_monoid_conjugacy_one_period_iterate_power を検査する。
# h∘R_F=R_G∘h、h∘R_F^n=R_G^n∘h、R_F^n=F^{nλ_F} を n = 0..m_F+1 で一段ずつ確かめる。
# 帰属: 有限写像の合成と等号、非負整数の乗算だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

pairs = 0
iterate_checks = 0
for stage_size, rule, table, h, g_table in conjugate_instances():
    _, _, lam_f, _, m_f, _, R_f, _, _, powers_f = rooted_tree_data(table)
    _, _, lam_g, _, m_g, _, R_g, _, _, powers_g = rooted_tree_data(g_table)
    assert compose(h, R_f) == compose(R_g, h)
    n_max = max(m_f, m_g) + 1
    Rf_powers = power_tables(R_f, n_max)
    Rg_powers = power_tables(R_g, n_max)
    for n in range(n_max + 1):
        assert Rf_powers[n] == powers_f[n * lam_f]
        assert Rg_powers[n] == powers_g[n * lam_g]
        assert compose(h, Rf_powers[n]) == compose(Rg_powers[n], h)
        iterate_checks += 1
    pairs += 1

print("conjugate pairs checked: {}".format(pairs))
print("one-period iterate checks: {}".format(iterate_checks))
print("RESULT: PASS")
