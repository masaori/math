# 対象ラベル: claim_iterate_monoid_positive_depth_layer_predecessor_count
# 各 q ∈ Q_F, k >= 1 で |L_F(q,k+1)| = Σ_{z ∈ L_F(σ_F(q),k)} b_F(z) を、人手証明の 4 等号を分けて確かめる。
#   |L_F(q,k+1)| = |F^{-1}(L_F(σ_F(q),k))|          (claim_iterate_monoid_positive_depth_layer_exact_preimage)
#              = |∪_{z} Pre_F(z)|                    (claim_iterate_monoid_finite_subset_preimage_decomposition)
#              = Σ_{z} |Pre_F(z)|                    (claim_iterate_monoid_stable_fiber_predecessors_disjoint)
#              = Σ_{z} b_F(z)                        (def_iterate_monoid_stable_fiber_predecessor_count)
# 帰属: 有限集合の等号・所属・合併・共通部分と非負整数の加算・等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
equalities = 0
nonempty_equalities = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    pre_sets = {z: predecessor_set(F, z) for z in range(M)}
    for q in Q:
        for k in range(1, M + 1):
            source = layers[sigma[q]][k]
            upper = layers[q][k + 1] if k + 1 <= M else frozenset()
            c1 = len(upper)
            inverse = full_preimage(F, source)
            assert inverse == upper                       # 層別完全逆像の既証明
            c2 = len(inverse)
            union = frozenset().union(*(pre_sets[z] for z in source)) if source else frozenset()
            assert union == inverse                       # 一段前像集合への分解
            c3 = len(union)
            assert_pairwise_disjoint(pre_sets[z] for z in source)  # 前像非交差
            c4 = sum(len(pre_sets[z]) for z in source)
            assert c3 == c4                               # 非交和の個数は和
            c5 = sum(predecessor_count(F, z) for z in source)
            assert c4 == c5                               # b_F の定義
            assert c1 == c2 == c3 == c4 == c5
            equalities += 1
            if source or upper:
                nonempty_equalities += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("count equalities checked: {}".format(equalities))
print("nonempty count equalities checked: {}".format(nonempty_equalities))
print("RESULT: PASS")
