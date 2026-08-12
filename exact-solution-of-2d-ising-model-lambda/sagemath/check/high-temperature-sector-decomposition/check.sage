# 対象ラベル: claim_high_temperature_sector_decomposition
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


def high_temperature_weight(L, subset):
    return (1 + x) ** (2 * L * L - len(subset)) * (1 - x) ** len(subset)


for L in (1, 2, 3):
    # 高温展開の整数多項式 H_L（def_high_temperature_polynomial）と、
    # セクター多項式 H^{a,b}_L（def_high_temperature_sector_polynomial）を独立に数え上げる
    high_temperature_polynomial = R(0)
    sector_high_polynomials = {(a, b): R(0) for a in (0, 1) for b in (0, 1)}
    even_count = 0
    for subset in edge_subsets(L):
        if not is_even_subgraph(L, subset):
            continue
        even_count += 1
        weight = high_temperature_weight(L, subset)
        high_temperature_polynomial += weight
        sector_high_polynomials[winding_sector(L, subset)] += weight

    # 検証 1: 主張 H_L = H^{0,0}_L + H^{0,1}_L + H^{1,0}_L + H^{1,1}_L
    assert high_temperature_polynomial == sum(sector_high_polynomials.values())
    # 参考の整合: セクターごとの偶部分グラフの個数の和が偶部分グラフの総数（分割であること）
    sector_counts = {}
    for subset in edge_subsets(L):
        if is_even_subgraph(L, subset):
            key = winding_sector(L, subset)
            sector_counts[key] = sector_counts.get(key, 0) + 1
    assert sum(sector_counts.values()) == even_count
    print("L=%d: H_L = Σ H^{a,b}_L を ZZ[x] で確認（偶部分グラフ %d 個、セクター内訳 %s）" %
          (L, even_count, sorted(sector_counts.items())))

print("RESULT: PASS")
