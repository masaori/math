# 章「自己転置な近傍割り当て全体の合成閉性の特徴づけ」の検算で共有する補助。
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


def loop_witness(cells, a):
    """本文の N_a: v = a のとき {a}、それ以外は空集合。"""
    return tuple(frozenset((a,)) if v == a else frozenset() for v in cells)


def edge_witness(cells, a, b):
    """本文の M_{a,b}: a に {b}、b に {a}、それ以外は空集合。"""
    table = []
    for v in cells:
        if v == a:
            table.append(frozenset((b,)))
        elif v == b:
            table.append(frozenset((a,)))
        else:
            table.append(frozenset())
    return tuple(table)


def self_transpose_assignments_by_symmetry(cells):
    """対称な所属関係（非順序対の選択）から自己転置な割り当てを直に構成する。

    全列挙 self_transpose_assignments は 2^{|V|^2} 通りを走るため |V| >= 5 で走査できない。
    こちらは 2^{|V|(|V|+1)/2} 通りで済む。両者の一致は有限決定の検算で確かめる。
    """
    pairs = [(v, w) for v in cells for w in cells if v <= w]
    result = []
    for chosen in product((False, True), repeat=len(pairs)):
        table = {v: set() for v in cells}
        for (v, w), taken in zip(pairs, chosen):
            if taken:
                table[v].add(w)
                table[w].add(v)
        result.append(tuple(frozenset(table[v]) for v in cells))
    return tuple(result)


def closed_st(cells):
    """def_all_self_transpose_assignments_composition_closed を全数走査で判定する。"""
    witnesses = self_transpose_assignments_by_symmetry(cells)
    for N in witnesses:
        for M in witnesses:
            NM = compose(cells, N, M)
            if transpose(cells, NM) != NM:
                return False
    return True
