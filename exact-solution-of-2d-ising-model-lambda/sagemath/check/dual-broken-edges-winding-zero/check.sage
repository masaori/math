# 対象ラベル: claim_dual_broken_edges_winding_zero
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def broken_edge_set(L, sigma):
    return frozenset(e for e in range(1, 2 * L * L + 1)
                     if sigma[endpoints(L, e)[0]] != sigma[endpoints(L, e)[1]])


def dual_edge(L, edge):
    if edge <= L * L:
        index = edge - 1
        i, j = index // L, index % L
        return edge_number_vertical(L, i, j + 1)
    index = edge - L * L - 1
    i, j = index // L, index % L
    return edge_number_horizontal(L, i + 1, j)


for L in (1, 2, 3, 4):
    checked = 0
    for sigma in configurations(L):
        broken = broken_edge_set(L, sigma)
        dual_broken = frozenset(dual_edge(L, edge) for edge in broken)
        horizontal = tuple(edge_number_horizontal(L, i, L - 1) for i in range(L))
        vertical = tuple(edge_number_vertical(L, L - 1, j) for j in range(L))
        horizontal_count = sum(ZZ(edge in dual_broken) for edge in horizontal)
        vertical_count = sum(ZZ(edge in dual_broken) for edge in vertical)
        assert horizontal_count == sum(
            ZZ(edge_number_vertical(L, i, L - 1) in broken) for i in range(L))
        assert vertical_count == sum(
            ZZ(edge_number_horizontal(L, L - 1, j) in broken) for j in range(L))
        assert horizontal_count % 2 == 0
        assert vertical_count % 2 == 0
        checked += 1
    print("L=%d: %d 配位の二つの巻き付き偶奇が零" % (L, checked))

print("RESULT: PASS")
