# 対象ラベル: claim_iterate_monoid_cycle_idempotent_commutes_with_generator
# すべての y について E_F(F(y)) = F^{e_F+1}(y) = F(E_F(y)) を、人手証明の等号ごとに確かめる。
# 帰属: 有限集合の写像の値の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, E, FE1, Q, fibers, sigma = stable_fiber_dynamics_data(table)
    for y in range(len(F)):
        assert E[F[y]] == FE1[y]      # (E_F ∘ F)(y) = F^{e_F+1}(y)（claim_iterate_composition_addition）
        assert FE1[y] == F[E[y]]      # F^{e_F+1}(y) = (F ∘ E_F)(y)（同上）
        assert E[F[y]] == F[E[y]]     # 主張
        points += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("configurations checked: {}".format(points))
print("RESULT: PASS")
