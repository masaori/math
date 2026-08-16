# 対象ラベル: claim_iterate_monoid_cycle_part_group_laws
# 各 G=F^n ∈ C_F に対し m := e_F + n(λ_F-1)、H := F^m と置き、m ≥ e_F ≥ μ_F から H ∈ C_F、
# n+m = e_F + nλ_F、伝播を e_F, e_F+λ_F, ..., e_F+(n-1)λ_F に順に適用して G∘H = F^{e_F} = E_F、
# 可換性から H∘G = E_F を検査する。参考として逆元が C_F 内で一意であることも確かめる。
# 帰属: 有限集合の写像の等号、非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
inverses = 0
propagation_steps = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, powers = cycle_group_data(table)
    cycle = cycle_part(mu, lam, powers)
    cycle_set = frozenset(cycle)
    E = powers[e]
    for r in range(lam):
        n = mu + r
        G = powers[n]
        m = e + n * (lam - 1)
        H = powers[m]
        assert m >= e and e >= mu
        assert H in cycle_set
        assert n + m == e + n * lam
        prod = compose(G, H)
        assert prod == powers[n + m]                          # 反復回数の加法
        assert propagate(powers, e, n, lam) == powers[e]      # 周期の伝播を n 段
        propagation_steps += n
        assert prod == E
        assert compose(H, G) == E                             # 可換性
        # 参考: 逆元は C_F 内で一意
        assert sum(1 for X in cycle if compose(G, X) == E) == 1
        inverses += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("inverses constructed: {}".format(inverses))
print("propagation steps: {}".format(propagation_steps))
print("RESULT: PASS")
