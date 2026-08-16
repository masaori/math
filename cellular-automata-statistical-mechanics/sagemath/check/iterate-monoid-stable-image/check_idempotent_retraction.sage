# 対象ラベル: claim_iterate_monoid_cycle_idempotent_retracts_stable_image
# Q_F := E_F(A^V) を像の定義で作り、各 z ∈ Q_F について証人 y（z = E_F(y)）を取り、
# E_F(z) = E_F(E_F(y)) = (E_F∘E_F)(y) = E_F(y) = z を人手証明の各等号どおりに確かめる。
# 帰属: 有限集合の写像の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, powers, E, R, Q = stable_image_data(table)
    EE = compose(E, E)
    assert EE == E                                   # claim_iterate_monoid_cycle_idempotent_candidate_is_idempotent
    for z in Q:
        witnesses = [y for y in range(len(E)) if E[y] == z]
        assert len(witnesses) >= 1                   # def_iterate_monoid_stable_image
        y = witnesses[0]
        assert E[z] == E[E[y]]                       # z = E_F(y)
        assert E[E[y]] == EE[y]                      # 写像合成の定義
        assert EE[y] == E[y]                         # 冪等性
        assert E[y] == z                             # z = E_F(y)
        assert E[z] == z
        points += 1
    # 参考: Q_F の外の点では E_F は恒等とは限らない（主張の外。反例が存在することの確認のみ）
    instances += 1

print("global maps checked: {}".format(instances))
print("stable image points checked: {}".format(points))
print("RESULT: PASS")
