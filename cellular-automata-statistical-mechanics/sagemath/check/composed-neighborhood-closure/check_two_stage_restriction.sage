# 対象ラベル: claim_global_map_composition_representable_on_composed_neighborhood
# 証明中の二段制限の段だけを検査する。すなわち u in N(v) について
# rho^{(N*M)(v)}_{M(u)} ( rho^V_{(N*M)(v)} x ) = rho^V_{M(u)} x を、
# |V| <= 3 の全ての近傍割り当ての組と全ての配位 x で検査する。
# 帰属: 有限集合、有限写像、0/1 の等号だけを使う。浮動小数点と R/C 脱出はない。

from itertools import combinations, product


def subsets(cells):
    for size in range(len(cells) + 1):
        for combination in combinations(cells, size):
            yield frozenset(combination)


def neighborhood_assignments(cells):
    return tuple(product(tuple(subsets(cells)), repeat=len(cells)))


def index_tuple(cell_set):
    """部分集合の元を並べた添字（A^S の座標の並び）。"""
    return tuple(sorted(cell_set))


def restrict(y, source_index, target_set):
    """rho^{source}_{target}。y は source_index に沿った値の組。"""
    position = {cell: place for place, cell in enumerate(source_index)}
    return tuple(y[position[cell]] for cell in index_tuple(target_set))


tested = 0
for cell_count in range(1, 4):
    cells = tuple(range(cell_count))
    configurations = tuple(product((0, 1), repeat=cell_count))
    assignments = neighborhood_assignments(cells)
    for outer in assignments:
        for inner in assignments:
            for v in cells:
                composed = frozenset().union(*[inner[u] for u in outer[v]]) if outer[v] else frozenset()
                composed_index = index_tuple(composed)
                for u in outer[v]:
                    for x in configurations:
                        restricted_once = restrict(x, cells, composed)
                        two_stage = restrict(restricted_once, composed_index, inner[u])
                        direct = restrict(x, cells, inner[u])
                        assert two_stage == direct
                        tested += 1

print(f"PASS restriction_checks={tested}")
