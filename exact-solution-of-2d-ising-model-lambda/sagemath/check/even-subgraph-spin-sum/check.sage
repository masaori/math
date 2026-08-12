# 対象ラベル: claim_even_subgraph_spin_sum
# 帰属: 頂点・辺・配位は有限集合、次数は ZZ。浮動小数点を使わない。

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


def direct_spin_sum(L, subset):
    return sum((spin_monomial(L, subset, sigma) for sigma in configurations(L)), ZZ(0))


def factorized_spin_sum(L, subset):
    return prod(sum((ZZ(s) ** incidence_count(L, subset, vertex) for s in (-1, 1)), ZZ(0))
                for vertex in vertices(L))


for L in (1, 2):
    checked = 0
    for subset in edge_subsets(L):
        expected = ZZ(2) ** (L * L) if is_even_subgraph(L, subset) else ZZ(0)
        assert direct_spin_sum(L, subset) == expected
        assert factorized_spin_sum(L, subset) == expected
        checked += 1
    print("L=%d: %d 個の辺部分集合を配位の全数和で検査" % (L, checked))

L = 3
checked = 0
for subset in edge_subsets(L):
    expected = ZZ(2) ** (L * L) if is_even_subgraph(L, subset) else ZZ(0)
    assert factorized_spin_sum(L, subset) == expected
    checked += 1
print("L=3: %d 個の辺部分集合を頂点ごとの厳密因数分解で検査" % checked)

print("RESULT: PASS")
