# 対象ラベル: claim_iterate_monoid_conjugacy_transports_tree_edges
# 併せて claim_iterate_monoid_conjugacy_preserves_tree_depth と
# claim_iterate_monoid_conjugacy_preserves_tree_branching を検査する。
# 各 q∈Q_F で、辺の保存と反映（両所属の同値）、根への深さの一致、各頂点の分岐個数の一致を確かめる。
# 帰属: 有限集合の等号・所属・個数、非負整数の乗算・大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

pairs = 0
edge_pair_checks = 0
depth_checks = 0
branching_checks = 0
for stage_size, rule, table, h, g_table in conjugate_instances():
    F, _, lam_f, _, m_f, _, R_f, Q_f, fibers_f, _ = rooted_tree_data(table)
    G, _, lam_g, _, m_g, _, R_g, Q_g, fibers_g, _ = rooted_tree_data(g_table)
    for q in Q_f:
        fiber_f = fibers_f[q]
        fiber_g = fibers_g[h[q]]
        T_f = tree_edges(R_f, fiber_f, q)
        T_g = tree_edges(R_g, fiber_g, h[q])
        for y in fiber_f:
            for z in fiber_f:
                assert (((y, z) in T_f) == ((h[y], h[z]) in T_g))
                edge_pair_checks += 1
        for y in fiber_f:
            assert tree_depth(F, lam_f, m_f, y, q) == tree_depth(G, lam_g, m_g, h[y], h[q])
            depth_checks += 1
        for z in fiber_f:
            assert branching_count(T_f, z) == branching_count(T_g, h[z])
            branching_checks += 1
    pairs += 1

print("conjugate pairs checked: {}".format(pairs))
print("edge membership pairs checked: {}".format(edge_pair_checks))
print("depth equalities checked: {}".format(depth_checks))
print("branching equalities checked: {}".format(branching_checks))
print("RESULT: PASS")
