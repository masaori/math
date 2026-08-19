# 章「安定ファイバー根付き木族の数値プロファイルは共役を決定しない」の検算で共有する補助。
# 帰属: 有限集合の写像の真理値表、有限集合の等号・所属・個数、非負整数の除法・乗算・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'iterate-monoid-conjugacy-invariance', '_common.sage'))


def counterexample_tables():
    """def_iterate_monoid_conjugacy_numerical_profile_counterexample の二つの写像表。
    配位番号 0..7 は x_0..x_7 に対応する。"""
    F = (0, 0, 0, 1, 1, 2, 4, 7)
    G = (0, 0, 0, 1, 1, 2, 5, 7)
    return F, G


def depth_layer_sequence(F, lam, m, fiber, root):
    """def_iterate_monoid_conjugacy_numerical_profile の深さ別個数列 L(q)。添字は k=0..m。"""
    counts = [0] * (m + 1)
    for y in fiber:
        counts[tree_depth(F, lam, m, y, root)] += 1
    return tuple(counts)


def branching_multiset(one_period, fiber, root):
    """def_iterate_monoid_conjugacy_numerical_profile の分岐個数多重集合 B(q)。整列した組で表す。"""
    edges = tree_edges(one_period, fiber, root)
    return tuple(sorted(branching_count(edges, z) for z in fiber))


def numerical_profile(table):
    """def_iterate_monoid_conjugacy_numerical_profile の P(F)。多重集合は整列した組で表す。"""
    F, mu, lam, e, m, E, one_period, Q, fibers, _ = rooted_tree_data(table)
    fiber_data = tuple(sorted(
        (depth_layer_sequence(F, lam, m, fibers[q], q), branching_multiset(one_period, fibers[q], q))
        for q in Q))
    return (mu, lam, len(Q), fiber_data)


def descendant_set(one_period, fiber, vertex):
    """一周期写像の有限回の反復で vertex へ到達するファイバー内の元全体（vertex 自身を含む）。"""
    result = set()
    for y in fiber:
        value = y
        for _ in range(len(fiber) + 1):
            if value == vertex:
                result.add(y)
                break
            value = one_period[value]
    return frozenset(result)


def conjugacy_scan(table_f, table_g):
    """claim_iterate_monoid_conjugacy_finite_decidability の全単射走査。
    共役全単射が存在すればその一つを、存在しなければ None を返す（存在の真偽は第 1 成分）。"""
    import itertools
    if len(table_f) != len(table_g):
        return False, None
    for h in itertools.permutations(range(len(table_f))):
        if all(h[table_f[y]] == table_g[h[y]] for y in range(len(table_f))):
            return True, h
    return False, None
