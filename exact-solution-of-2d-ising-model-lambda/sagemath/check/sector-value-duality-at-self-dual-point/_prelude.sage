import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

R = PolynomialRing(ZZ, 'x')
x = R.gen()

def edge_subsets(L):
    edge_list = list(range(1, 2 * L * L + 1))
    for size in range(len(edge_list) + 1):
        for subset in combinations(edge_list, size):
            yield frozenset(subset)

def incidence_count(L, subset, vertex):
    return sum(ZZ(1) for edge in subset for endpoint in endpoints(L, edge) if endpoint == vertex)

def is_even_subgraph(L, subset):
    return all(incidence_count(L, subset, vertex) % 2 == 0 for vertex in vertices(L))

def winding_sector(L, subset):
    horizontal_cut = frozenset(edge_number_horizontal(L, i, -1) for i in range(L))
    vertical_cut = frozenset(edge_number_vertical(L, -1, j) for j in range(L))
    return (len(subset.intersection(horizontal_cut)) % 2,
            len(subset.intersection(vertical_cut)) % 2)

def sector_polynomials(L):
    high = {(a, b): R(0) for a in (0, 1) for b in (0, 1)}
    low = {(a, b): R(0) for a in (0, 1) for b in (0, 1)}
    for subset in edge_subsets(L):
        if not is_even_subgraph(L, subset):
            continue
        key = winding_sector(L, subset)
        size = len(subset)
        high[key] += (1 + x) ** (2 * L * L - size) * (1 - x) ** size
        low[key] += x ** size
    return high, low

self_dual_point = QQbar(2).sqrt() - 1
