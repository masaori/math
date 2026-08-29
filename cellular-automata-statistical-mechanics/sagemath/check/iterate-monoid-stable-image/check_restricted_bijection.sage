# 対象ラベル: claim_iterate_monoid_generator_bijective_on_stable_image
# S_F := F^{e_F+λ_F-1}。各 z = F^{e_F}(y) ∈ Q_F について F(z) = F^{e_F+1}(y) ∈ Q_F、
# S_F(z) = F^{2e_F+λ_F-1}(y) ∈ Q_F（前 claim の像の一致を指数 e_F+1、2e_F+λ_F-1 に適用）、
# 周期の伝播 F^{e_F+λ_F} = F^{e_F} と反復回数の加法則から F∘S_F = S_F∘F = E_F、
# Q_F 上で F(S_F(z)) = E_F(z) = z、S_F(F(z)) = E_F(z) = z を確かめ、F|_{Q_F} が全単射であることを見る。
# 帰属: 有限集合の写像の等号、非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, powers, E, R, Q = stable_image_data(table)
    assert lam >= 1 and e >= mu
    assert R == powers[e + lam - 1]                          # def_iterate_monoid_stable_image_inverse_candidate
    # 周期の伝播と加法則
    assert powers[e + lam] == powers[e]                      # claim_iterate_monoid_period_propagates_after_collision_start
    assert compose(table, R) == powers[e + lam]              # F ∘ F^{e_F+λ_F-1} = F^{e_F+λ_F}（加法則）
    assert compose(R, table) == powers[e + lam]
    assert compose(table, R) == E
    assert compose(R, table) == E
    for z in Q:
        y = next(y for y in range(len(E)) if powers[e][y] == z)   # z = F^{e_F}(y)
        assert table[z] == powers[e + 1][y]                  # F(z) = F^{e_F+1}(y)
        assert e + 1 >= mu
        assert powers[e + 1][y] in Q                         # 前 claim（像の一致）
        assert 2 * e + lam - 1 < len(powers)
        assert R[z] == powers[2 * e + lam - 1][y]            # S_F(z) = F^{2e_F+λ_F-1}(y)
        assert 2 * e + lam - 1 >= mu
        assert powers[2 * e + lam - 1][y] in Q               # 前 claim（像の一致）
        assert table[R[z]] == E[z]                           # F(S_F(z)) = E_F(z)
        assert E[z] == z                                     # 安定像上で恒等
        assert R[table[z]] == E[z]                           # S_F(F(z)) = E_F(z)
        points += 1
    restricted_F = {z: table[z] for z in Q}
    restricted_R = {z: R[z] for z in Q}
    assert set(restricted_F.values()) <= Q
    assert set(restricted_R.values()) <= Q
    assert all(restricted_R[restricted_F[z]] == z for z in Q)
    assert all(restricted_F[restricted_R[z]] == z for z in Q)
    assert len(set(restricted_F.values())) == len(Q)         # F|_{Q_F} は全単射
    instances += 1

print("global maps checked: {}".format(instances))
print("stable image points checked: {}".format(points))
print("RESULT: PASS")
