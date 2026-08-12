# 対象ラベル: claim_mixed_boundary_duality_identity
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
    # 左辺: 高温展開のセクター多項式 H^{a,b}_L（def_high_temperature_sector_polynomial）を
    # 全辺部分集合から独立に数え上げる
    sector_high_polynomials = {(a, b): R(0) for a in (0, 1) for b in (0, 1)}
    # 右辺の素材: 自明セクターの生成多項式 G^{0,0}_L（def_sector_generating_polynomial）
    trivial_sector_generating = R(0)
    for subset in edge_subsets(L):
        if not is_even_subgraph(L, subset):
            continue
        sector = winding_sector(L, subset)
        sector_high_polynomials[sector] += high_temperature_weight(L, subset)
        if sector == (0, 0):
            trivial_sector_generating += x ** len(subset)

    left_side = sum(sector_high_polynomials.values())

    # 検証 1: 主張 H^{0,0}+H^{0,1}+H^{1,0}+H^{1,1} = 2^{L^2+1} G^{0,0}_L
    assert left_side == ZZ(2) ** (L * L + 1) * trivial_sector_generating

    # 検証 2: 鎖の中間段の整合。全配位からの Z_L（def_partition_polynomial）で
    # H_L = 2^{L^2} Z_L（claim_high_temperature_polynomial_identity）と
    # Z_L = 2 G^{0,0}_L（claim_low_temperature_trivial_sector_expression）を突き合わせる
    Z = partition_polynomial(L)
    assert left_side == ZZ(2) ** (L * L) * Z
    assert Z == ZZ(2) * trivial_sector_generating

    print(f"L={L}: ok (left side degree {left_side.degree()})")

print("all checks passed")
