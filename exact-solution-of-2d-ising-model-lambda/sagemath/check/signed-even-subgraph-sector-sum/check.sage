# 対象ラベル: claim_signed_even_subgraph_sector_sum
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


for L in (1, 2, 3):
    even_subsets = [subset for subset in edge_subsets(L) if is_even_subgraph(L, subset)]

    # セクターごとの生成多項式 G^{c,d}_L（def_sector_generating_polynomial）
    sector_polynomials = {(c, d): R(0) for c in (0, 1) for d in (0, 1)}
    for subset in even_subsets:
        sector_polynomials[winding_sector(L, subset)] += x ** len(subset)

    for a in (0, 1):
        for b in (0, 1):
            # 左辺: 符号付き偶部分グラフ多項式 Q^{a,b}_L の直接計算
            # （def_signed_even_subgraph_polynomial。偶部分グラフごとに符号を付けて足す）
            lhs = R(0)
            for subset in even_subsets:
                c, d = winding_sector(L, subset)
                exponent = (1 + a) * c + (1 + b) * d + c * d
                lhs += (-1) ** exponent * x ** len(subset)

            # 右辺: セクター生成多項式の符号付き和
            rhs = sum((-1) ** ((1 + a) * c + (1 + b) * d + c * d)
                      * sector_polynomials[(c, d)]
                      for c in (0, 1) for d in (0, 1))

            assert lhs == rhs, (L, a, b)
    print("L=%d: 偶部分グラフ %d 個、四つのスピン構造で Q^{a,b}_L = Σ ±G^{c,d}_L を ZZ[x] で確認" %
          (L, len(even_subsets)))

print("RESULT: PASS")
