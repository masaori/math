# 章「反復モノイドの巡回部にある唯一の冪等元」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、非負整数の除法・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-minimal-period', '_prelude.sage'))


def mu_lambda_powers(table):
    """最小衝突開始位置 μ_F、最小正周期 λ_F、および指数 0..(μ_F + 3·衝突終端 + 6) の反復写像を返す。"""
    _, mu, collision_end = monoid_and_collision(table)
    powers = power_tables(table, mu + 3 * collision_end + 6)
    lam = min(p for p in range(1, collision_end + 1) if powers[mu] == powers[mu + p])
    return mu, lam, powers


def cycle_part(mu, lam, powers):
    """C_F = {F^{μ_F + r} | r < λ_F}（def_iterate_monoid_transient_and_cycle_parts）。"""
    return tuple(powers[mu + r] for r in range(lam))
