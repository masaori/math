# 章「近傍割り当ての包含順序と合成の単調性」の検算で共有する補助。
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


def compose(cells, outer, inner):
    """def_composed_neighborhood の (N*M)(v) = ∪_{u in N(v)} M(u)。"""
    return tuple(
        frozenset().union(*[inner[u] for u in outer[v]]) if outer[v] else frozenset()
        for v in cells
    )


def precedes(cells, lower, upper):
    """def_neighborhood_assignment_pointwise_inclusion の N <= M。

    定義そのもの（各 v で N(v) ⊆ M(v)）を書き下す。
    """
    return all(lower[v] <= upper[v] for v in cells)
