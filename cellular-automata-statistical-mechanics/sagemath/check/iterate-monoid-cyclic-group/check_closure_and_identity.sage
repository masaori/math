# 対象ラベル: claim_iterate_monoid_cycle_part_group_laws
# 巡回部 C_F が合成で閉じること（G=F^{μ_F+a}, H=F^{μ_F+b} の積が F^{2μ_F+a+b} で 2μ_F+a+b ≥ μ_F）、
# 唯一の冪等元 E_F=F^{e_F} が左右単位元であること（e_F=qλ_F、伝播を n, n+λ_F, ..., n+(q-1)λ_F へ順に適用）、
# 結合律・可換律が C_F 上で成り立つことを検査する。
# 帰属: 有限集合の写像の等号、非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
products = 0
identity_checks = 0
propagation_steps = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, powers = cycle_group_data(table)
    cycle = cycle_part(mu, lam, powers)
    cycle_set = frozenset(cycle)
    assert len(cycle_set) == lam
    E = powers[e]
    assert e % lam == 0 and e >= mu
    q = e // lam
    assert compose(E, E) == E and E in cycle_set
    # 閉性
    for a in range(lam):
        for b in range(lam):
            G = powers[mu + a]
            H = powers[mu + b]
            prod = compose(G, H)
            assert prod == powers[2 * mu + a + b]          # 反復回数の加法
            assert 2 * mu + a + b >= mu                    # 安定後の指数
            assert prod in cycle_set                       # I_{μ_F}(F) = C_F
            assert prod == compose(H, G)                   # 可換律
            products += 1
    # 結合律（有限可換モノイドから継承）
    for a in range(lam):
        for b in range(lam):
            for c in range(lam):
                G, H, K = powers[mu + a], powers[mu + b], powers[mu + c]
                assert compose(compose(G, H), K) == compose(G, compose(H, K))
    # 単位元
    for r in range(lam):
        n = mu + r
        G = powers[n]
        left = compose(E, G)
        assert left == powers[e + n]                       # 反復回数の加法
        assert e + n == n + q * lam                        # e_F = qλ_F
        assert propagate(powers, n, q, lam) == powers[n]   # 周期の伝播を q 段
        propagation_steps += q
        assert left == G
        assert compose(G, E) == G                          # 可換性
        identity_checks += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("products checked for closure and commutativity: {}".format(products))
print("identity checks: {}".format(identity_checks))
print("propagation steps: {}".format(propagation_steps))
print("RESULT: PASS")
