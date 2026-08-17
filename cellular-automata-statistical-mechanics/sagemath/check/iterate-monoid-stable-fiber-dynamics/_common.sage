# 章「安定ファイバー間の一段発展」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表と有限集合の等号・包含だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-stable-partition', '_common.sage'))


def stable_fiber_dynamics_data(table):
    """F、μ_F、λ_F、e_F、E_F、F^{e_F+1}、Q_F、安定ファイバー、σ_F の表を返す。"""
    mu, lam, e, powers, E, R, Q = stable_image_data(table)
    F = powers[1]
    fibers = {q: stable_fiber(E, q) for q in Q}
    sigma = {q: F[q] for q in Q}   # def_iterate_monoid_stable_fiber_index_map: σ_F(q) = F(q)
    return F, mu, lam, e, E, powers[e + 1], Q, fibers, sigma
