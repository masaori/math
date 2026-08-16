# 章「反復モノイドの巡回部がなす有限巡回群」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、非負整数の除法・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-cycle-idempotent', '_common.sage'))


def cycle_group_data(table):
    """μ_F、λ_F、e_F（D_F の最小元）、および指数 0..(2e_F + 2λ_F + 2μ_F + 4) の反復写像を返す。
    逆元の指数 e_F + n(λ_F-1)（n ≤ μ_F+λ_F-1）と積の指数 2μ_F+2λ_F を含む範囲まで列挙する。"""
    _, mu, collision_end = monoid_and_collision(table)
    lam_powers = power_tables(table, mu + collision_end + 2)
    lam = min(p for p in range(1, collision_end + 1) if lam_powers[mu] == lam_powers[mu + p])
    e = min(k for k in range(mu * lam + 1) if mu <= k and k % lam == 0)
    n_max = mu + lam - 1
    last = max(2 * e + 2 * lam + 2 * mu + 4, e + n_max * (lam - 1) + n_max + 2, 2 * n_max + 2)
    powers = power_tables(table, last)
    return mu, lam, e, powers


def propagate(powers, start, steps, lam):
    """claim_iterate_monoid_period_propagates_after_collision_start を start, start+λ, ... に順に適用し、
    F^{start} = F^{start + steps·λ} を一段ずつ確かめる。"""
    for d in range(steps):
        assert powers[start + d * lam] == powers[start + (d + 1) * lam]
    return powers[start + steps * lam]
