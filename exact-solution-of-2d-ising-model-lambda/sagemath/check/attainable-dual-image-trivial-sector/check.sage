# 対象ラベル: claim_attainable_dual_image_trivial_sector
# 帰属: 有限集合、NN。浮動小数点を使わない。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def edge_subsets(L):
    edge_list = list(range(1, 2 * L * L + 1))
    for size in range(len(edge_list) + 1):
        for subset in combinations(edge_list, size):
            yield frozenset(subset)


def broken_edge_set(L, sigma):
    return frozenset(edge for edge in range(1, 2 * L * L + 1)
                     if sigma[endpoints(L, edge)[0]] != sigma[endpoints(L, edge)[1]])


def dual_edge(L, edge):
    if edge <= L * L:
        index = edge - 1
        i, j = index // L, index % L
        return edge_number_vertical(L, i, j + 1)
    index = edge - L * L - 1
    i, j = index // L, index % L
    return edge_number_horizontal(L, i + 1, j)


def incidence_count(L, subset, vertex):
    return sum(ZZ(1) for edge in subset for endpoint in endpoints(L, edge)
               if endpoint == vertex)


def is_even_subgraph(L, subset):
    return all(incidence_count(L, subset, vertex) % 2 == 0
               for vertex in vertices(L))


def winding_sector(L, subset):
    horizontal_cut = frozenset(edge_number_horizontal(L, i, -1) for i in range(L))
    vertical_cut = frozenset(edge_number_vertical(L, -1, j) for j in range(L))
    return (len(subset.intersection(horizontal_cut)) % 2,
            len(subset.intersection(vertical_cut)) % 2)


for L in (1, 2, 3):
    # 左辺: 実現できる破れた辺集合の全体 𝔅_L の双対像
    attainable = {frozenset(broken_edge_set(L, sigma)) for sigma in configurations(L)}
    dual_images = {frozenset(dual_edge(L, edge) for edge in subset)
                   for subset in attainable}

    # 右辺: 自明セクター E^{0,0}_L の全体
    trivial_sector = {
        subset for subset in edge_subsets(L)
        if is_even_subgraph(L, subset) and winding_sector(L, subset) == (0, 0)
    }

    assert dual_images == trivial_sector
    print("L=%d: 双対像 %d 個と自明セクター %d 個が集合として一致" %
          (L, len(dual_images), len(trivial_sector)))

print("RESULT: PASS")
