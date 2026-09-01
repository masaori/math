# 章「近傍割り当てが部分集合に定める合併作用」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、有限写像表だけを使う。
# 浮動小数点と R/C 脱出はない。

from itertools import combinations, product


def subsets(cells):
    """def_finite_carrier_subset_space の Sub(V) を全列挙する。"""
    for size in range(len(cells) + 1):
        for combination in combinations(cells, size):
            yield frozenset(combination)


def neighborhood_assignments(cells):
    """def_finite_neighborhood_assignment_space の N(V) を全列挙する。"""
    return tuple(product(tuple(subsets(cells)), repeat=len(cells)))


def compose(cells, first, second):
    """def_composed_neighborhood の (N star M)(v) = ∪_{u in N(v)} M(u)。"""
    composed = []
    for v in cells:
        collected = set()
        for u in first[v]:
            collected |= set(second[u])
        composed.append(frozenset(collected))
    return tuple(composed)


def identity_assignment(cells):
    """def_identity_neighborhood_assignment の I_V(v) = {v}。"""
    return tuple(frozenset((v,)) for v in cells)


def union_map_value(cells, N, S):
    """def_neighborhood_assignment_subset_union_map の U_N(S) = ∪_{v in S} N(v)。"""
    collected = set()
    for v in S:
        collected |= set(N[v])
    return frozenset(collected)


def union_map_table(cells, N):
    """U_N の全表を Sub(V) 上の辞書として作る。"""
    return {S: union_map_value(cells, N, S) for S in subsets(cells)}
