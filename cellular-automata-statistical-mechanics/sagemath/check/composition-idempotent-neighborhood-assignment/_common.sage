# 章「合成冪等な近傍割り当ての特徴づけ」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、有限写像表だけを使う。
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


def is_idempotent(cells, N):
    """def_composition_idempotent_neighborhood_assignment の N star N = N。"""
    return compose(cells, N, N) == N


def is_transitive(cells, N):
    """def_transitive_neighborhood_assignment を V^3 の全列挙で判定する。"""
    for v in cells:
        for u in N[v]:
            for w in N[u]:
                if w not in N[v]:
                    return False
    return True


def is_two_step_factorable(cells, N):
    """def_two_step_factorable_neighborhood_assignment を V^2 と N(v) の走査で判定する。"""
    for v in cells:
        for w in N[v]:
            if not any(w in N[u] for u in N[v]):
                return False
    return True


def is_reflexive(cells, N):
    """各 v について v in N(v)（自己近傍の包含）。"""
    return all(v in N[v] for v in cells)
