# 章「合成写像の本質的依存台」の検算で共有する補助。
# 帰属: 有限集合、有限写像表、0/1 の等号だけを使う。浮動小数点と R/C 脱出はない。

from itertools import combinations, product


def configurations(cells):
    """A^V の全列挙。配位は cells の順に並べた 0/1 の組で表す。"""
    return tuple(product((0, 1), repeat=len(cells)))


def flip(x, u):
    """一点反転写像 phi_u。u 番目の値だけを入れ替える。"""
    return tuple(1 - x[place] if place == u else x[place] for place in range(len(x)))


def cell_map(cells, F, u):
    """def_finite_configuration_map_cell_map の F_u: A^V -> A。F は配位から配位への辞書。"""
    return {x: F[x][u] for x in configurations(cells)}


def support(cells, g):
    """def_essential_dependency_support の supp(g)。一点反転検査で決定する。"""
    return frozenset(
        u for u in cells
        if any(g[x] != g[flip(x, u)] for x in configurations(cells))
    )


def dependency_assignment(cells, F):
    """def_global_map_essential_dependency_assignment の D_F。"""
    return tuple(support(cells, cell_map(cells, F, v)) for v in cells)


def composed_neighborhood(cells, outer, inner):
    """def_composed_neighborhood の (N*M)(v) = ∪_{u in N(v)} M(u)。"""
    return tuple(
        frozenset().union(*[inner[u] for u in outer[v]]) if outer[v] else frozenset()
        for v in cells
    )


def compose_maps(cells, F, G):
    """写像の合成 F∘G。"""
    return {x: F[G[x]] for x in configurations(cells)}


def all_maps(cells):
    """A^V -> A^V の全列挙。"""
    states = configurations(cells)
    for images in product(states, repeat=len(states)):
        yield dict(zip(states, images))


def depends_only_on(cells, g, cell_set):
    """g: A^V -> A が cell_set 上の局所規則で表せること（cell_set の外の値に依らないこと）。"""
    table = {}
    for x in configurations(cells):
        key = tuple(x[u] for u in sorted(cell_set))
        if key in table:
            if table[key] != g[x]:
                return False
        else:
            table[key] = g[x]
    return True
