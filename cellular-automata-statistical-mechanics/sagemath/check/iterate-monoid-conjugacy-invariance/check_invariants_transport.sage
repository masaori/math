# 対象ラベル: claim_iterate_monoid_conjugacy_preserves_collision_start
# 併せて claim_iterate_monoid_conjugacy_preserves_minimal_period と
# claim_iterate_monoid_conjugacy_transports_cycle_idempotent を検査する。
# μ_F=μ_G、Π の一致（有限窓）と λ_F=λ_G、D の一致（有限窓）と e_F=e_G、h∘E_F=E_G∘h を確かめる。
# 帰属: 有限写像の合成と等号、非負整数の除法・大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

pairs = 0
window_checks = 0
for stage_size, rule, table, h, g_table in conjugate_instances():
    _, mu_f, lam_f, e_f, _, E_f, _, _, _, powers_f = rooted_tree_data(table)
    _, mu_g, lam_g, e_g, _, E_g, _, _, _, powers_g = rooted_tree_data(g_table)
    assert mu_f == mu_g
    assert lam_f == lam_g
    assert e_f == e_g
    assert compose(h, E_f) == compose(E_g, h)
    K = e_f + 2 * lam_f + 1
    for p in range(1, K + 1):
        # Π の一致（def_iterate_monoid_minimal_positive_period の所属条件を両側で評価）
        assert (powers_f[mu_f] == powers_f[mu_f + p]) == (powers_g[mu_g] == powers_g[mu_g + p])
        window_checks += 1
    for n in range(K + 1):
        # D の一致（def_iterate_monoid_stable_period_multiple_exponents の所属条件を両側で評価）
        assert ((mu_f <= n) and (n % lam_f == 0)) == ((mu_g <= n) and (n % lam_g == 0))
        window_checks += 1
    pairs += 1

print("conjugate pairs checked: {}".format(pairs))
print("membership window checks: {}".format(window_checks))
print("RESULT: PASS")
