# =============================================================
# 共通定義 (sagemath/_shared/defs.sage)
#
# structured-latex/content/partition-polynomial.ts の定義に 1 対 1 で対応させる。
#   def_lattice / def_configuration    -> vertices(L), edges(L), configurations(L)
#   def_broken_bond_count              -> broken_bond_count(L, sigma)
#   def_multiplicity                   -> multiplicity_vector(L)
#   def_partition_polynomial           -> partition_polynomial(L)
#
# すべて厳密計算（ZZ / QQ / ZZ['x']）で書く。浮動小数点を使わない。
# 使い方:
#   import os
#   _dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
#   load(os.path.join(_dir, '<相対パス>/sagemath/_shared/defs.sage'))
# =============================================================

from itertools import product

# 分配多項式の係数環と不定元。指数関数を入口に置かない（README「形式変数のまま進む」）。
PolynomialRingZx = PolynomialRing(ZZ, 'x')
x = PolynomialRingZx.gen()


def vertices(L):
    """def_lattice: 頂点集合 V_L = (Z/LZ)^2 を添字の組として返す。|V_L| = L^2。"""
    return [(i, j) for i in range(L) for j in range(L)]


def edges(L):
    """def_lattice: 辺の添字集合 E_L = V_L x {h, v}（周期境界）と端点写像。

    返すのは添字ごとの端点の組 (d0(e), d1(e)) の列で、長さは常に 2L^2。
    L <= 2 では異なる添字が同じ頂点対を指す（L=1 は自己ループ、L=2 は同じ 2 点を 2 本）。
    頂点対の集合として重複を潰すと本数が 2L^2 からずれるので、必ず添字ごとに数える
    （本文 def_lattice の但し書きと同じ理由）。
    """
    result = []
    for (i, j) in vertices(L):
        result.append(((i, j), ((i + 1) % L, j)))   # 添字 ((i,j), h)
        result.append(((i, j), (i, (j + 1) % L)))   # 添字 ((i,j), v)
    return result


def configurations(L):
    """def_configuration: 配位 sigma: V_L -> {+1,-1} を全列挙する。個数は 2^(L^2)。"""
    sites = vertices(L)
    for values in product([1, -1], repeat=len(sites)):
        yield dict(zip(sites, values))


def broken_bond_count(L, sigma):
    """def_broken_bond_count: 破れている辺の添字の個数 m(sigma) を返す（N の元）。"""
    return sum(1 for (u, w) in edges(L) if sigma[u] != sigma[w])


def multiplicity_vector(L):
    """def_multiplicity: Omega_L(m) を m = 0, 1, ..., 2L^2 の順に並べた整数の列。"""
    counts = [ZZ(0)] * (2 * L * L + 1)
    for sigma in configurations(L):
        counts[broken_bond_count(L, sigma)] += 1
    return counts


def partition_polynomial(L):
    """def_partition_polynomial: Z_L(x) = sum_m Omega_L(m) x^m in ZZ[x]。"""
    return PolynomialRingZx(multiplicity_vector(L))
