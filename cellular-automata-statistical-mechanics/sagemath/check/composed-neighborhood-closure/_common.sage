# 章「合成近傍による大域写像の合成表現」の検算で共有する補助。
# 帰属: 有限集合、有限写像表、0/1 の等号だけを使う。浮動小数点と R/C 脱出はない。

from itertools import combinations, product


def subsets(cells):
    for size in range(len(cells) + 1):
        for combination in combinations(cells, size):
            yield frozenset(combination)


def index_tuple(cell_set):
    """A^S の座標の並び。"""
    return tuple(sorted(cell_set))


def restrict(y, source_index, target_set):
    """rho^{source}_{target}。y は source_index に沿った値の組。"""
    position = {cell: place for place, cell in enumerate(source_index)}
    return tuple(y[position[cell]] for cell in index_tuple(target_set))


def local_rules(neighborhood):
    """A^{S} -> A の全ての真理値表を辞書として返す。"""
    inputs = tuple(product((0, 1), repeat=len(neighborhood)))
    return tuple(dict(zip(inputs, outputs))
                 for outputs in product((0, 1), repeat=len(inputs)))


def cellular_automata(cells):
    """(近傍割り当て, 局所規則族) の全ての組を返す。"""
    per_cell = tuple((neighborhood, rule)
                     for neighborhood in subsets(cells)
                     for rule in local_rules(neighborhood))
    return tuple((tuple(item[0] for item in family), tuple(item[1] for item in family))
                 for family in product(per_cell, repeat=len(cells)))


def composed_neighborhood(cells, outer, inner):
    """def_composed_neighborhood の (N*M)(v) を各 v について返す。"""
    return tuple(
        frozenset().union(*[inner[u] for u in outer[v]]) if outer[v] else frozenset()
        for v in cells
    )


def composed_rule_family(cells, outer, outer_rules, inner, inner_rules):
    """def_composed_local_rule_family の h_v を真理値表の族として返す。"""
    composed = composed_neighborhood(cells, outer, inner)
    family = []
    for v in cells:
        composed_index = index_tuple(composed[v])
        table = {}
        for z in product((0, 1), repeat=len(composed[v])):
            argument = tuple(inner_rules[u][restrict(z, composed_index, inner[u])]
                             for u in index_tuple(outer[v]))
            table[z] = outer_rules[v][argument]
        family.append(table)
    return composed, tuple(family)


def global_table(cells, configurations, place, neighborhood, rules):
    """大域写像を配位の番号づけ上の表として返す。"""
    return tuple(
        place[tuple(rules[v][restrict(x, cells, neighborhood[v])] for v in cells)]
        for x in configurations
    )
