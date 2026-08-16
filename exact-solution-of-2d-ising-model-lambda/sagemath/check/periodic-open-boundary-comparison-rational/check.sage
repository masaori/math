# 対象ラベル: claim_periodic_open_boundary_comparison_rational
#
# 周期境界の分配多項式 Z_L ∈ Z[x] へ正の有理数 q を代入した値と、一辺 L の開境界正方形の
# 正の有理点での値 Z^op_{L,L}(q)（def_open_rectangle_partition_value_at_positive_rational）
# の間の上下評価（0<q≤1: q^{2L} Z^op ≤ Z_L(q) ≤ Z^op、1≤q: その逆向き）を QQ 上で厳密に検査する。
# 併せて、周期境界の破れボンド数が、同じ配位を開境界で読んだ破れボンド数と境界を横切る 2L 本の
# うち破れた本数 s^bd との和になること、および値が Z[x] の多項式への代入と配位和で一致することも見る。
# 浮動小数点・RR・CC は使わない（主張は Q で閉じている）。

from itertools import product


def vertices(L):
    return [(i, j) for i in range(L) for j in range(L)]


def configurations(L):
    points = vertices(L)
    for values in product((ZZ(1), ZZ(-1)), repeat=L * L):
        yield dict(zip(points, values))


def open_edges(L):
    horizontal = [((i, j), (i, j + 1)) for i in range(L) for j in range(L - 1)]
    vertical = [((i, j), (i + 1, j)) for i in range(L - 1) for j in range(L)]
    return horizontal + vertical


def boundary_edges(L):
    horizontal = [((i, L - 1), (i, 0)) for i in range(L)]
    vertical = [((L - 1, j), (0, j)) for j in range(L)]
    return horizontal + vertical


def broken_count(edges, sigma):
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in edges)


R = PolynomialRing(ZZ, 'x')
x = R.gen()


def partition_polynomial(configs, edges):
    return sum((x ** broken_count(edges, sigma) for sigma in configs), R.zero())


def partition_value_by_sum(configs, edges, q):
    return sum((q ** broken_count(edges, sigma) for sigma in configs), QQ.zero())


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(1),
               QQ(3) / 2, QQ(22) / 7, QQ(5), QQ(11))
total = 0
for L in range(1, 4):
    configs = list(configurations(L))
    internal = open_edges(L)
    boundary = boundary_edges(L)
    periodic = internal + boundary

    assert len(boundary) == 2 * L
    for sigma in configs:
        seam = broken_count(boundary, sigma)
        assert 0 <= seam <= 2 * L
        assert broken_count(periodic, sigma) == broken_count(internal, sigma) + seam

    Z_periodic = partition_polynomial(configs, periodic)
    Z_open = partition_polynomial(configs, internal)
    assert Z_periodic.parent() is R and Z_open.parent() is R

    for q in test_points:
        assert q.parent() is QQ and q > 0
        open_value = Z_open(q)
        periodic_value = Z_periodic(q)
        assert open_value.parent() is QQ and periodic_value.parent() is QQ
        # 値は Z[x] への代入であり、配位ごとの和と一致し、正である
        assert open_value == partition_value_by_sum(configs, internal, q)
        assert periodic_value == partition_value_by_sum(configs, periodic, q)
        assert open_value > 0 and periodic_value > 0
        # 本文の鎖: Z_L(q) = Σ_τ q^{b^op(τ)} q^{s^bd(τ)}
        assert periodic_value == sum(
            (q ** broken_count(internal, sigma) * q ** broken_count(boundary, sigma)
             for sigma in configs), QQ.zero())
        # 境界因子の順序（各配位）
        for sigma in configs:
            seam = broken_count(boundary, sigma)
            if q <= 1:
                assert q ** (2 * L) <= q ** seam <= 1
            if q >= 1:
                assert 1 <= q ** seam <= q ** (2 * L)
        # 主張の二場合（q=1 は両方に属し、両方を見る）
        if q <= 1:
            assert q ** (2 * L) * open_value <= periodic_value <= open_value
        if q >= 1:
            assert open_value <= periodic_value <= q ** (2 * L) * open_value
        total += 1

print(f"周期境界と開境界の境界評価（正の有理点。QQ で厳密）: {total} 組 OK")
