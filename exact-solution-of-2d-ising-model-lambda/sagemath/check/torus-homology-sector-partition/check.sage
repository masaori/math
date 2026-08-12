# 対象ラベル: claim_torus_homology_sector_partition
# 帰属: 有限集合と NN。浮動小数点を使わない。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def edge_subsets(L):
    edges = list(range(1, 2 * L * L + 1))
    for size in range(len(edges) + 1):
        for subset in combinations(edges, size):
            yield frozenset(subset)


def incidence_count(L, subset, vertex):
    return sum(ZZ(1) for edge in subset for endpoint in endpoints(L, edge)
               if endpoint == vertex)


def is_even_subgraph(L, subset):
    return all(incidence_count(L, subset, vertex) % 2 == 0
               for vertex in vertices(L))


def horizontal_cut(L):
    return frozenset(edge_number_horizontal(L, i, -1) for i in range(L))


def vertical_cut(L):
    return frozenset(edge_number_vertical(L, -1, j) for j in range(L))


def winding_sector(L, subset):
    return (len(subset.intersection(horizontal_cut(L))) % 2,
            len(subset.intersection(vertical_cut(L))) % 2)


for L in (1, 2, 3):
    even_subsets = [subset for subset in edge_subsets(L) if is_even_subgraph(L, subset)]
    sectors = {(a, b): [] for a in (0, 1) for b in (0, 1)}
    for subset in even_subsets:
        sector = winding_sector(L, subset)
        assert sector in sectors
        sectors[sector].append(subset)
        assert sum(subset in sectors[key] for key in sectors) == 1
    assert sum(len(members) for members in sectors.values()) == len(even_subsets)
    assert all(sectors[key] for key in sectors)
    print("L=%d: 偶部分グラフ %d 個を四セクターへ一意に分割" %
          (L, len(even_subsets)))

print("RESULT: PASS")
