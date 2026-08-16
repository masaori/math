# 章「反復モノイドの安定像による配位集合の分割」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、非負整数の加算・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-stable-image', '_common.sage'))


def stable_fiber(E, q):
    """def_iterate_monoid_stable_fiber: B_F(q) = { y ∈ A^V | E_F(y) = q } を frozenset で返す。"""
    return frozenset(y for y in range(len(E)) if E[y] == q)


def stable_partition_data(table):
    """μ_F、λ_F、e_F、E_F、Q_F と、q ∈ Q_F ごとの安定ファイバーの辞書を返す。"""
    mu, lam, e, powers, E, R, Q = stable_image_data(table)
    fibers = {q: stable_fiber(E, q) for q in Q}
    return mu, lam, e, E, Q, fibers
