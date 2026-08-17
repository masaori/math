# 対象ラベル: claim_iterate_monoid_stable_fiber_exact_preimage
# 各 q ∈ Q_F について F^{-1}(B_F(σ_F(q))) = B_F(q) を両包含で確かめる。
# 順方向: y ∈ B_F(q) なら E_F(F(y)) = F(E_F(y)) = F(q) = σ_F(q)。
# 逆方向: F(y) ∈ B_F(σ_F(q)) なら F(E_F(y)) = E_F(F(y)) = σ_F(q) = F(q)、Q_F 上の単射性から E_F(y) = q。
# 帰属: 有限集合の写像の値の等号と所属判定だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
forward = 0
backward = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, E, FE1, Q, fibers, sigma = stable_fiber_dynamics_data(table)
    for q in Q:
        target = fibers[sigma[q]]
        preimage = frozenset(y for y in range(len(F)) if F[y] in target)
        for y in fibers[q]:                       # 順方向
            assert E[F[y]] == F[E[y]]
            assert F[E[y]] == F[q]                # E_F(y) = q
            assert F[q] == sigma[q]
            assert F[y] in target
            forward += 1
        for y in preimage:                        # 逆方向
            assert F[E[y]] == E[F[y]]
            assert E[F[y]] == sigma[q]            # F(y) ∈ B_F(σ_F(q))
            assert sigma[q] == F[q]
            assert E[y] in Q and q in Q
            assert E[y] == q                      # Q_F 上の単射性
            assert y in fibers[q]
            backward += 1
        assert preimage == fibers[q]              # 完全逆像の等号
    instances += 1

print("global maps checked: {}".format(instances))
print("forward memberships checked: {}".format(forward))
print("backward memberships checked: {}".format(backward))
print("RESULT: PASS")
