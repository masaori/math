# 対象ラベル: claim_iterate_monoid_conjugacy_transports_iterates
# 併せて claim_iterate_monoid_conjugacy_iterate_equality_equivalence を検査する。
# h∘F^n = G^n∘h を n = 0..K で一段ずつ確かめ、F^m=F^n ⟺ G^m=G^n を全対で確かめる。
# 帰属: 有限写像の合成と等号だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

pairs = 0
transport_steps = 0
equality_pairs = 0
for stage_size, rule, table, h, g_table in conjugate_instances():
    _, mu, lam, e, m, _, _, _, _, powers_f = rooted_tree_data(table)
    K = e + 2 * lam + 1
    powers_g = power_tables(g_table, K)
    for n in range(K + 1):
        assert compose(h, powers_f[n]) == compose(powers_g[n], h)
        transport_steps += 1
    for a in range(K + 1):
        for b in range(a + 1, K + 1):
            assert (powers_f[a] == powers_f[b]) == (powers_g[a] == powers_g[b])
            equality_pairs += 1
    pairs += 1

print("conjugate pairs checked: {}".format(pairs))
print("iterate transport steps checked: {}".format(transport_steps))
print("iterate equality pairs checked: {}".format(equality_pairs))
print("RESULT: PASS")
