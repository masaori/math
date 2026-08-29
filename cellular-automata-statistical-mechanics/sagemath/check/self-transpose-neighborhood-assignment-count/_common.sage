# 章「自己転置な近傍割り当ての個数」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、自然数の等号だけを使う。浮動小数点と R/C 脱出はない。

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


def unordered_pairs(cells):
    """def_unordered_carrier_pairs の U(V) = {{v,w} ⊆ V | v,w ∈ V}。

    定義の右辺そのものを v, w の全数走査で構成する（一元集合 {v,v} = {v} を含む）。
    """
    collected = set()
    for v in cells:
        for w in cells:
            collected.add(frozenset((v, w)))
    return collected


def ordered_representatives(pair):
    """非順序対 {v,w} を与える順序対を全て返す（表示順序の候補）。"""
    elements = tuple(sorted(pair))
    if len(elements) == 1:
        return ((elements[0], elements[0]),)
    return ((elements[0], elements[1]), (elements[1], elements[0]))


def pair_encoding(cells, assignment):
    """def_self_transpose_pair_encoding の ε_V(N) = {{v,w} ∈ U(V) | w ∈ N(v)}。

    各非順序対について表示順序を一つ選んで所属を判定する。
    表示順序に依存しないことは check_pair_encoding_bijection.sage で別途検査する。
    """
    collected = set()
    for pair in unordered_pairs(cells):
        v, w = ordered_representatives(pair)[0]
        if w in assignment[v]:
            collected.add(pair)
    return frozenset(collected)


def pair_reconstruction(cells, pair_set):
    """def_pair_set_neighborhood_reconstruction の ρ_V(B)(v) = {w ∈ V | {v,w} ∈ B}。"""
    return tuple(
        frozenset(w for w in cells if frozenset((v, w)) in pair_set)
        for v in cells
    )


def self_transpose_assignments(cells):
    """N^T = N を満たす近傍割り当てを全数走査で集める。"""
    return tuple(
        N for N in neighborhood_assignments(cells) if transpose(cells, N) == N
    )
