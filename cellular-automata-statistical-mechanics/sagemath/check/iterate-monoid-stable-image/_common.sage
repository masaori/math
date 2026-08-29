# 章「反復モノイドの冪等元が定める安定像」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、非負整数の加減・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-cyclic-group', '_common.sage'))


def image_of(table):
    """写像の像 {table(k) | k} を frozenset で返す（def_iterate_monoid_stable_image の像の定義どおり）。"""
    return frozenset(table)


def stable_image_data(table):
    """μ_F、λ_F、e_F、反復写像列、E_F、S_F=F^{e_F+λ_F-1}、Q_F=E_F(A^V) を返す。"""
    mu, lam, e, powers = cycle_group_data(table)
    E = powers[e]
    R = powers[e + lam - 1]
    Q = image_of(E)
    return mu, lam, e, powers, E, R, Q
