# 対象ラベル: claim_high_temperature_polynomial_identity
# 帰属: 有限集合、ZZ、ZZ[x]。浮動小数点を使わない。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

R.<x> = PolynomialRing(ZZ)


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


def high_temperature_polynomial(L):
    edge_count = 2 * L * L
    return sum(((1 + x) ** (edge_count - len(subset)) *
                (1 - x) ** len(subset)
                for subset in edge_subsets(L) if is_even_subgraph(L, subset)), R.zero())


def one_edge_weight(sigma, u, v):
    return (1 + x) + (1 - x) * ZZ(sigma[u]) * ZZ(sigma[v])


for L in (1, 2):
    for sigma in configurations(L):
        broken = broken_bond_count(L, sigma)
        edge_product = prod(one_edge_weight(sigma, *endpoints(L, edge))
                            for edge in range(1, 2 * L * L + 1))
        assert edge_product == ZZ(2) ** (2 * L * L) * x ** broken

    lhs = ZZ(2) ** (L * L) * partition_polynomial(L)
    rhs = high_temperature_polynomial(L)
    assert lhs == rhs
    print("L=%d: 一辺の二項表示と高温展開の多項式恒等式を厳密検査" % L)

print("RESULT: PASS")
