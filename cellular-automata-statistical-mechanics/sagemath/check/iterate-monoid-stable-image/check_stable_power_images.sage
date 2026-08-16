# 対象ラベル: claim_iterate_monoid_stable_power_image_equals_stable_image
# μ_F ≤ n の各 n（μ_F ≤ n ≤ μ_F + 2λ_F + 1 の有限範囲）について、F^n ∈ C_F、
# E_F∘F^n = F^n（左単位元）、F^n∘H = E_F（H ∈ C_F は前章の逆元。指数 e_F + n'(λ_F-1) の n' は周期の伝播で一周期内へ還元した位置）を確かめ、
# 任意の y に対し F^n(y) = E_F(F^n(y)) ∈ Q_F（包含 ⊆）と E_F(y) = F^n(H(y)) ∈ im F^n（包含 ⊇）を
# 点ごとに検査して像の等号 im F^n = Q_F を得る。
# 帰属: 有限集合の写像の等号、非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
exponents = 0
point_checks = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, powers, E, R, Q = stable_image_data(table)
    cycle_set = frozenset(cycle_part(mu, lam, powers))
    for n in range(mu, mu + 2 * lam + 2):
        Fn = powers[n]
        assert Fn in cycle_set                                # claim_iterate_monoid_stable_tail_equals_cycle_part
        # 逆元 H は前章の指数 e_F + n'(λ_F-1)（n' は F^n = F^{n'} となる μ_F ≤ n' < μ_F+λ_F。周期の伝播で還元）
        n_reduced = mu + (n - mu) % lam
        assert propagate(powers, n_reduced, (n - n_reduced) // lam, lam) == Fn
        assert powers[n_reduced] == Fn
        m = e + n_reduced * (lam - 1)
        assert m < len(powers)
        H = powers[m]
        assert H in cycle_set                                 # claim_iterate_monoid_cycle_part_group_laws の逆元
        assert compose(E, Fn) == Fn                           # E_F ∘ F^n = F^n
        assert compose(Fn, H) == E                            # F^n ∘ H = E_F
        for y in range(len(table)):
            assert Fn[y] == E[Fn[y]]                          # F^n(y) = E_F(F^n(y))
            assert Fn[y] in Q                                 # ∈ Q_F
            assert E[y] == Fn[H[y]]                           # E_F(y) = F^n(H(y))
            point_checks += 1
        assert image_of(Fn) <= Q                              # ⊆
        assert Q <= image_of(Fn)                              # ⊇
        assert image_of(Fn) == Q
        exponents += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("exponents n >= mu_F checked: {}".format(exponents))
print("pointwise inclusion checks: {}".format(point_checks))
print("RESULT: PASS")
