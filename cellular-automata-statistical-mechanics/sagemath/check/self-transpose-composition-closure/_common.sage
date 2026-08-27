# 章「自己転置な近傍割り当ての合成閉性」の検算で共有する補助。
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


def transpose(cells, assignment):
    """def_neighborhood_assignment_transpose の N^T(w) = {v in V | w in N(v)}。"""
    return tuple(
        frozenset(v for v in cells if w in assignment[v])
        for w in cells
    )


def compose(cells, first, second):
    """def_composed_neighborhood の (N star M)(v) = ∪_{u in N(v)} M(u)。"""
    composed = []
    for v in cells:
        collected = set()
        for u in first[v]:
            collected |= set(second[u])
        composed.append(frozenset(collected))
    return tuple(composed)


def self_transpose_assignments(cells):
    """N^T = N を満たす近傍割り当てを全数走査で集める。"""
    return tuple(
        N for N in neighborhood_assignments(cells) if transpose(cells, N) == N
    )


# def_self_transpose_composition_nonclosure_witness の二元舞台と二つの証人。
# a = 0, b = 1（相異なる二元）。
WITNESS_CELLS = (0, 1)
WITNESS_LOOP = (frozenset((0,)), frozenset())          # N(a) = {a}, N(b) = ∅
WITNESS_EDGE = (frozenset((1,)), frozenset((0,)))      # M(a) = {b}, M(b) = {a}
