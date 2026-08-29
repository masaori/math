# 章「安定ファイバー上の一周期写像が定める根付き木」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属、非負整数の除法・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-stable-partition', '_common.sage'))


def rooted_tree_data(table):
    """F, μ_F, λ_F, e_F, m_F, E_F, R_F, Q_F, 安定ファイバーを返す。"""
    mu, lam, e, powers, E, _, Q = stable_image_data(table)
    assert e % lam == 0
    m = e // lam
    F = powers[1]
    one_period = powers[lam]
    fibers = {q: stable_fiber(E, q) for q in Q}
    return F, mu, lam, e, m, E, one_period, Q, fibers, powers


def apply_table_power(table, y, exponent):
    """def_finite_self_map_iterate に従って table^exponent(y) を一段ずつ計算する。"""
    value = y
    for _ in range(exponent):
        value = table[value]
    return value


def tree_edges(one_period, fiber, root):
    """def_iterate_monoid_fiber_tree_edges の定義どおりの辺集合。"""
    return frozenset((y, one_period[y]) for y in fiber if y != root)


def tree_depth(F, lam, m, y, root):
    """def_iterate_monoid_fiber_tree_depth の有限走査。到達定理により 0..m で停止する。"""
    for d in range(m + 1):
        if apply_table_power(F, y, d * lam) == root:
            return d
    raise AssertionError("root was not reached by m_F")


def branching_count(edges, target):
    """第二成分が target に等しい辺の個数。"""
    return sum(1 for _, z in edges if z == target)
