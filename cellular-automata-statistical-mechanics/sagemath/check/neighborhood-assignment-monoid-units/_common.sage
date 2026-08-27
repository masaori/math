# 章「有限近傍割り当てモノイドの可逆元」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、有限写像表、自然数の等号だけを使う。
# 浮動小数点と R/C 脱出はない。

from itertools import combinations, permutations, product


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


def identity_assignment(cells):
    """def_identity_neighborhood_assignment の I_V(v) = {v}。"""
    return tuple(frozenset((v,)) for v in cells)


def permutation_assignment(cells, sigma):
    """def_permutation_neighborhood_assignment の P_sigma(v) = {sigma(v)}。

    sigma は cells の位置番号を添字とする像の組で与える。
    """
    return tuple(frozenset((sigma[v],)) for v in cells)


def inverse_permutation(cells, sigma):
    """sigma の逆写像の表を作る。"""
    inverse = [None] * len(cells)
    for v in cells:
        inverse[sigma[v]] = v
    return tuple(inverse)


def inverses(cells, assignment):
    """def_invertible_neighborhood_assignment の逆元を全数走査で集める。"""
    I = identity_assignment(cells)
    found = []
    for M in neighborhood_assignments(cells):
        if compose(cells, assignment, M) == I and compose(cells, M, assignment) == I:
            found.append(M)
    return tuple(found)


def is_invertible(cells, assignment):
    """def_invertible_neighborhood_assignment の可逆性を全数走査で判定する。"""
    return len(inverses(cells, assignment)) > 0
