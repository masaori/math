# 章「近傍割り当ての点ごとの和と合成の分配性」の検算で共有する補助。
# 帰属: 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

from itertools import combinations, product


def subsets(cells):
    for size in range(len(cells) + 1):
        for combination in combinations(cells, size):
            yield frozenset(combination)


def neighborhood_assignments(cells):
    """def_finite_neighborhood_assignment_space の N(V) を全列挙する。"""
    return tuple(product(tuple(subsets(cells)), repeat=len(cells)))


def identity_assignment(cells):
    """def_identity_neighborhood_assignment の I_V。"""
    return tuple(frozenset({v}) for v in cells)


def empty_assignment(cells):
    """def_empty_neighborhood_assignment の O_V。"""
    return tuple(frozenset() for _ in cells)


def compose(cells, outer, inner):
    """def_composed_neighborhood の (N*M)(v) = ∪_{u in N(v)} M(u)。"""
    return tuple(
        frozenset().union(*[inner[u] for u in outer[v]]) if outer[v] else frozenset()
        for v in cells
    )


def pointwise_union(cells, left, right):
    """def_neighborhood_assignment_pointwise_union の (N⊔M)(v) = N(v) ∪ M(v)。"""
    return tuple(left[v] | right[v] for v in cells)


def precedes(cells, lower, upper):
    """def_neighborhood_assignment_pointwise_inclusion の N <= M。"""
    return all(lower[v] <= upper[v] for v in cells)
