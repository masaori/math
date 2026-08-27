# 章「有限近傍割り当てモノイドの中心」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、有限写像表、自然数の等号だけを使う。
# 浮動小数点と R/C 脱出はない。

from itertools import combinations, product


def subsets(cells):
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


def empty_assignment(cells):
    """def_empty_neighborhood_assignment の O_V。"""
    return tuple(frozenset() for _ in cells)


def identity_assignment(cells):
    """def_identity_neighborhood_assignment の I_V(v) = {v}。"""
    return tuple(frozenset((v,)) for v in cells)


def single_edge(cells, a, b):
    """def_single_edge_neighborhood_assignment の E_{a,b}。"""
    return tuple(frozenset((b,)) if v == a else frozenset() for v in cells)


def is_central(cells, assignment):
    """def_neighborhood_assignment_monoid_center の Z_star(V) への所属を全数走査で判定する。"""
    for M in neighborhood_assignments(cells):
        if compose(cells, assignment, M) != compose(cells, M, assignment):
            return False
    return True


def center(cells):
    """Z_star(V) を全数走査で集める。"""
    return tuple(
        N for N in neighborhood_assignments(cells) if is_central(cells, N)
    )
