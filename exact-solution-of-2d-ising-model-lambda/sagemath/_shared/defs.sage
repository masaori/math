# =============================================================
# 共通定義 (sagemath/_shared/defs.sage)
#
# structured-latex/content/main-text.ts の定義に 1 対 1 で対応させる。
#   def_lattice / def_configuration    -> vertices(L), edges(L), configurations(L)
#   def_broken_bond_count              -> broken_bond_count(L, sigma)
#   def_multiplicity                   -> multiplicity_vector(L)
#   def_partition_polynomial           -> partition_polynomial(L)
#   claim_coefficient_representation   -> partition_polynomial_from_multiplicity(L)
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
    """def_lattice: 頂点集合 V_L = (Z/LZ)^2 を添字の組 (i, j) として返す。|V_L| = L^2。

    本文と同じく、第 1 成分 i を行番号、第 2 成分 j を列番号と呼ぶ。
    """
    return [(i, j) for i in range(L) for j in range(L)]


def horizontal_edge_numbers(L):
    """def_lattice: 横向きの辺の番号の集合 E_{L,h} = {1, ..., L^2}。"""
    return range(1, L * L + 1)


def vertical_edge_numbers(L):
    """def_lattice: 縦向きの辺の番号の集合 E_{L,v} = {L^2+1, ..., 2L^2}。

    E_{L,h} と番号の範囲が重ならないので、両者は互いに素である
    （札を付けて区別する必要がない。本文と同じ約束）。
    """
    return range(L * L + 1, 2 * L * L + 1)


def endpoints(L, e):
    """def_lattice: 辺の番号 e から両端 (d0(e), d1(e)) を読み出す。

    本文と同じ分解を使う。番号を L で割った商が行番号 i、余りが列番号 j。
      e in E_{L,h} なら e - 1     = iL + j で、両端は (i,j) と (i,j+1)   同じ行の中
      e in E_{L,v} なら e - L^2-1 = iL + j で、両端は (i,j) と (i+1,j)   隣り合う行の間
    加法は Z/LZ の中で行う（周期境界）。
    """
    e = ZZ(e)
    if e <= L * L:
        i, j = divmod(e - 1, L)
        return ((i, j), (i, (j + 1) % L))
    i, j = divmod(e - L * L - 1, L)
    return ((i, j), ((i + 1) % L, j))


def edges(L):
    """def_lattice: 辺の番号ごとの端点の組を、番号 1, 2, ..., 2L^2 の順に並べて返す。

    長さは常に 2L^2（横向き L^2 本のあとに縦向き L^2 本）。
    L <= 2 では異なる番号が同じ頂点対を指す
    （L=1 は d0 = d1、L=2 は横向きの 2 本が同じ 2 点を結ぶ）。
    2 元集合として重複を潰すと本数が 2L^2 からずれるので、必ず番号ごとに数える
    （本文 def_lattice の但し書きと同じ理由）。
    """
    return [endpoints(L, e) for e in range(1, 2 * L * L + 1)]


def configurations(L):
    """def_configuration: 配位 sigma: V_L -> {+1,-1} を全列挙する。個数は 2^(L^2)。"""
    sites = vertices(L)
    for values in product([1, -1], repeat=len(sites)):
        yield dict(zip(sites, values))


def broken_bond_count(L, sigma):
    """def_broken_bond_count: 破れている辺の番号の個数 b(sigma) を返す（N の元）。"""
    return sum(1 for (u, w) in edges(L) if sigma[u] != sigma[w])


def multiplicity_vector(L):
    """def_multiplicity: Omega_L(m) を m = 0, 1, ..., 2L^2 の順に並べた整数の列。"""
    counts = [ZZ(0)] * (2 * L * L + 1)
    for sigma in configurations(L):
        counts[broken_bond_count(L, sigma)] += 1
    return counts


def partition_polynomial(L):
    """def_partition_polynomial: Z_L = sum_{sigma in Sigma_L} x^{b(sigma)} in ZZ[x]。

    本文の定義そのまま、配位ごとに単項式を足し上げて作る。
    多重度から作ってはならない。多重度から作ると係数表示
    Z_L = sum_m Omega_L(m) x^m が構成から自明になり、
    claim_coefficient_representation の検証が空になるためである。
    """
    total = PolynomialRingZx(0)
    for sigma in configurations(L):
        total += x ** broken_bond_count(L, sigma)
    return total


def partition_polynomial_from_multiplicity(L):
    """claim_coefficient_representation の右辺 sum_m Omega_L(m) x^m を、多重度から作る。

    partition_polynomial(L) とは作り方が独立なので、両者の一致が主張の内容になる。
    """
    return PolynomialRingZx(multiplicity_vector(L))
