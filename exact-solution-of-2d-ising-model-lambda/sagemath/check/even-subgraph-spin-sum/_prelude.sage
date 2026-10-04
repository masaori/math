# 共通定義: 番号つき端点を数え、辺積と頂点冪積を別々に構成する。
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


def spin_monomial(L, subset, sigma):
    return prod(ZZ(sigma[u]) * ZZ(sigma[v])
                for edge in subset for u, v in [endpoints(L, edge)])


def vertex_power_monomial(L, subset, sigma):
    return prod(ZZ(sigma[vertex]) ** incidence_count(L, subset, vertex)
                for vertex in vertices(L))


def direct_spin_sum(L, subset):
    return sum((spin_monomial(L, subset, sigma) for sigma in configurations(L)), ZZ(0))


def factorized_spin_sum(L, subset):
    return prod(sum((ZZ(s) ** incidence_count(L, subset, vertex) for s in (-1, 1)), ZZ(0))
                for vertex in vertices(L))
