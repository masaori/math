# 章「安定ファイバー間の分岐個数」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属、非負整数の加算だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-stable-fiber-dynamics', '_common.sage'))


def predecessor_set(F, z):
    """def_iterate_monoid_stable_fiber_predecessor_set: Pre_F(z) = { y ∈ A^V | F(y) = z }。"""
    return frozenset(y for y in range(len(F)) if F[y] == z)


def predecessor_count(F, z):
    """def_iterate_monoid_stable_fiber_predecessor_count: b_F(z) = |Pre_F(z)| ∈ N。"""
    return len(predecessor_set(F, z))


def branching_data(table):
    """F、E_F、Q_F、安定ファイバー、σ_F、全 z の Pre_F(z)、b_F(z) を返す。"""
    F, mu, lam, e, E, FE1, Q, fibers, sigma = stable_fiber_dynamics_data(table)
    pre = {z: predecessor_set(F, z) for z in range(len(F))}
    d = {z: len(pre[z]) for z in range(len(F))}
    return F, E, Q, fibers, sigma, pre, d
