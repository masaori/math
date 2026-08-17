# 対象ラベル: claim_iterate_monoid_stable_fiber_image_can_be_strict
# 一元舞台 V = {v}、N(v) = {v}、定値規則 f_v(a) = 0 の大域写像 F(x_0) = x_0、F(x_1) = x_0 について、
# 人手証明の各段（F^0 ≠ F^1、F^1 = F^2、μ_F = 1、λ_F = 1、e_F = 1、E_F = F、Q_F = {x_0}、
# B_F(x_0) = {x_0, x_1}、σ_F(x_0) = x_0、F(B_F(x_0)) = {x_0} ⊊ B_F(σ_F(x_0))）を確かめる。
# 併せて全数範囲で F(B_F(q)) ⊆ B_F(σ_F(q)) が常に成り立ち、真の包含になる例が他にもあることを数える。
# 帰属: 有限集合の写像の真理値表と有限集合の等号・包含だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

# 配位番号 0 = x_0（x_0(v) = 0）、1 = x_1（x_1(v) = 1）。大域写像の真理値表は [F(x_0), F(x_1)]。
table = [0, 0]
F, mu, lam, e, E, FE1, Q, fibers, sigma = stable_fiber_dynamics_data(table)
assert list(F) == [0, 0]
powers = power_tables(table, 2)
assert list(powers[0]) == [0, 1] and powers[0][1] != powers[1][1]   # F^0(x_1) = x_1 ≠ x_0 = F^1(x_1)
assert list(powers[2]) == [0, 0] and powers[2] == powers[1]         # F^2 = F^1
assert mu == 1 and lam == 1 and e == 1
assert list(E) == list(F)
assert Q == frozenset([0])
assert fibers[0] == frozenset([0, 1])
assert sigma[0] == 0
image = frozenset(F[y] for y in fibers[0])
assert image == frozenset([0])
assert image < fibers[sigma[0]]                                # 真の包含

instances = 0
strict = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, E, FE1, Q, fibers, sigma = stable_fiber_dynamics_data(table)
    for q in Q:
        image = frozenset(F[y] for y in fibers[q])
        assert image <= fibers[sigma[q]]                        # 包含は常に成り立つ（完全逆像の帰結）
        if image < fibers[sigma[q]]:
            strict += 1
    instances += 1

print("counterexample verified: one-cell constant rule")
print("global maps checked: {}".format(instances))
print("strict inclusions found: {}".format(strict))
print("RESULT: PASS")
