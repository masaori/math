# 対象ラベル: claim_iterate_monoid_stable_fiber_depth_transition
# 各 q ∈ Q_F, k >= 1 で F(L_F(q,k)) ⊆ L_F(σ_F(q), k-1) を、人手証明の三段に分けて確かめる。
#   y ∈ L_F(q,k) ⇒ y ∈ B_F(q) かつ μ(y) = k > 0        (層の定義)
#               ⇒ F(y) ∈ B_F(σ_F(q))                    (claim_..._exact_preimage)
#               ⇒ μ(F(y)) = k-1                          (claim_iterate_monoid_min_preperiod_decrements)
#               ⇒ F(y) ∈ L_F(σ_F(q), k-1)                (層の定義)
# 帰属: 有限集合の所属・包含と非負整数の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
elements = 0
nonempty_layers = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    for q in Q:
        for k in range(1, M + 1):
            for y in layers[q][k]:
                assert y in fibers[q] and mu_of[y] == k and k > 0
                fy = F[y]
                assert fy in fibers[sigma[q]]            # 完全逆像の主張
                assert mu_of[fy] == k - 1                # 一段で最小前周期が一つ減る
                assert fy in layers[sigma[q]][k - 1]     # 層の定義
                elements += 1
            image = frozenset(F[y] for y in layers[q][k])
            assert image <= layers[sigma[q]][k - 1]
            if layers[q][k]:
                nonempty_layers += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("elements of positive layers checked: {}".format(elements))
print("nonempty positive layers checked: {}".format(nonempty_layers))
print("RESULT: PASS")
