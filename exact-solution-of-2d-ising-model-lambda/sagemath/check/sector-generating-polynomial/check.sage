# 対象ラベル: claim_low_temperature_trivial_sector_expression
# 帰属: 有限集合、ZZ[x]。浮動小数点を使わない。

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
    # セクターごとの生成多項式 G^{a,b}_L（def_sector_generating_polynomial）
    sector_polynomials = {(a, b): R(0) for a in (0, 1) for b in (0, 1)}
    for subset in edge_subsets(L):
        if is_even_subgraph(L, subset):
            sector_polynomials[winding_sector(L, subset)] += x ** len(subset)

    # 分配多項式 Z_L（全配位の数え上げ）と D_L（実現できる破れた辺集合の生成多項式）
    partition_polynomial = R(0)
    attainable = set()
    for sigma in configurations(L):
        subset = broken_edge_set(L, sigma)
        partition_polynomial += x ** len(subset)
        attainable.add(subset)
    low_temperature_polynomial = sum(x ** len(subset) for subset in attainable)

    # 検証 1: 全単射 Δ_L による添字の取り替え D_L = G^{0,0}_L
    assert low_temperature_polynomial == sector_polynomials[(0, 0)]
    # 検証 2: 主張 Z_L = 2 G^{0,0}_L
    assert partition_polynomial == 2 * sector_polynomials[(0, 0)]
    # 参考の整合: 双対像が元の個数を保つこと（|δ_L(B)| = |B|）
    for subset in attainable:
        dual_image = frozenset(dual_edge(L, edge) for edge in subset)
        assert len(dual_image) == len(subset)
    print("L=%d: Z_L = 2*G^{0,0}_L を ZZ[x] で確認（G^{0,0}_L の項数 %d）" %
          (L, len(sector_polynomials[(0, 0)].coefficients())))

print("RESULT: PASS")
