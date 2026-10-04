# 対象ラベル: claim_dual_broken_edges_even
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/_shared/defs.sage')

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


def local_data():
    for L in (1, 2, 3):
        for sigma in configurations(L):
            broken = broken_edge_set(L, sigma)
            dual_broken = frozenset(dual_edge(L, edge) for edge in broken)
            for i, j in vertices(L):
                dual_edges = (
                    edge_number_horizontal(L, i, j),
                    edge_number_horizontal(L, i, j - 1),
                    edge_number_vertical(L, i, j),
                    edge_number_vertical(L, i - 1, j),
                )
                inverse_edges = (
                    edge_number_vertical(L, i - 1, j),
                    edge_number_vertical(L, i - 1, j - 1),
                    edge_number_horizontal(L, i, j - 1),
                    edge_number_horizontal(L, i - 1, j - 1),
                )
                boundary_edges = (inverse_edges[0], inverse_edges[2],
                                  inverse_edges[1], inverse_edges[3])
                spins = tuple(ZZ(sigma[(ii % L, jj % L)]) for ii, jj in (
                    (i - 1, j - 1), (i - 1, j), (i, j), (i, j - 1)))
                yield L, sigma, broken, dual_broken, (i, j), dual_edges, inverse_edges, boundary_edges, spins
