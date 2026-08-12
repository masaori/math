# 対象ラベル: claim_dual_broken_edges_even
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


def incidence_count(L, subset, vertex):
    return sum(ZZ(1) for edge in subset for endpoint in endpoints(L, edge)
               if endpoint == vertex)


for L in (1, 2, 3):
    checked = 0
    for sigma in configurations(L):
        broken = broken_edge_set(L, sigma)
        dual_broken = frozenset(dual_edge(L, edge) for edge in broken)
        assert len(dual_broken) == len(broken)
        for i, j in vertices(L):
            local_primal_edges = (
                edge_number_vertical(L, i - 1, j),
                edge_number_horizontal(L, i, j - 1),
                edge_number_vertical(L, i - 1, j - 1),
                edge_number_horizontal(L, i - 1, j - 1),
            )
            local_broken_count = sum(ZZ(edge in broken) for edge in local_primal_edges)
            degree = incidence_count(L, dual_broken, (i, j))
            assert degree == local_broken_count
            assert prod(ZZ(sigma[u]) * ZZ(sigma[v])
                        for edge in local_primal_edges for u, v in [endpoints(L, edge)]) == 1
            assert (-1) ** degree == 1
            assert degree % 2 == 0
        checked += 1
    print("L=%d: %d 配位の全双対頂点で偶次数を確認" % (L, checked))

print("RESULT: PASS")
