# 章「根付き木の深さと最小前周期層の対応」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属、非負整数の乗算・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-stable-fiber-rooted-tree', '_common.sage'))
load(os.path.join(_dir, '..', 'iterate-monoid-stable-fiber-depth', '_common.sage'))


def rounded_preperiod(mu_y, lam, m):
    """def_iterate_monoid_rounded_preperiod_depth: r_F(y) = min{ d ∈ N | μ(y) <= d·λ_F }。
    定義の well-defined 性（m_F が集合に属する）により d = 0, 1, ..., m_F の有限走査で必ず見つかる。"""
    for d in range(m + 1):
        if mu_y <= d * lam:
            return d
    raise AssertionError("m_F is not in the defining set")


def correspondence_data(table):
    """F、μ_F、λ_F、e_F、m_F、E_F、R_F、Q_F、安定ファイバー、各配位の μ(y) を返す。"""
    F, mu, lam, e, m, E, one_period, Q, fibers, powers = rooted_tree_data(table)
    mu_of = {y: min_preperiod_period(F, y)[0] for y in range(len(F))}
    return F, mu, lam, e, m, E, one_period, Q, fibers, mu_of
