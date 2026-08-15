# 対象ラベル: claim_open_rectangle_gluing_inequality_rational
#
# 開境界長方形の接合不等式の正の有理点 q ∈ Q_{>0} 版。
# 二つを接いだとき、接合面の破れ辺数による重みの差だけが分配多項式の値の積と
# 接合後の値との差になることを QQ 上で厳密に検査する。値は Z[x] の分配多項式への
# q の代入（def_open_rectangle_partition_value_at_positive_rational）で取り、
# 配位ごとの和 Σ_σ q^{b^op(σ)} と一致することも見る。
# 浮動小数点・RR・CC は使わない（主張は Q で閉じている）。

from itertools import product


def open_vertices(a, b):
    return [(i, j) for i in range(a) for j in range(b)]


def open_edges(a, b):
    horizontal = [('h', i, j) for i in range(a) for j in range(b - 1)]
    vertical = [('v', i, j) for i in range(a - 1) for j in range(b)]
    return horizontal + vertical


def endpoints(edge):
    direction, i, j = edge
    if direction == 'h':
        return (i, j), (i, j + 1)
    return (i, j), (i + 1, j)


def open_configurations(a, b):
    vertices = open_vertices(a, b)
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vertices)):
        yield dict(zip(vertices, values))


def broken_count(a, b, sigma):
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in map(endpoints, open_edges(a, b)))


R = PolynomialRing(ZZ, 'x')
x = R.gen()


def partition_polynomial(a, b):
    return sum((x ** broken_count(a, b, sigma)
                for sigma in open_configurations(a, b)), R.zero())


def partition_value(a, b, q):
    # Z[x] の分配多項式へ q を代入した値（Q の元）。配位ごとの和と一致することも見る。
    value = QQ(partition_polynomial(a, b)(q))
    assert value == sum((q ** broken_count(a, b, sigma)
                         for sigma in open_configurations(a, b)), QQ.zero())
    assert value > 0
    return value


def glue_first(a, b, c, sigma, tau):
    rho = dict(sigma)
    rho.update({(a + i, j): value for (i, j), value in tau.items()})
    return rho


def glue_second(a, b, c, sigma, tau):
    rho = dict(sigma)
    rho.update({(i, b + j): value for (i, j), value in tau.items()})
    return rho


def seam_first(a, b, sigma, tau):
    return sum(ZZ(sigma[(a - 1, j)] != tau[(0, j)]) for j in range(b))


def seam_second(a, b, sigma, tau):
    return sum(ZZ(sigma[(i, b - 1)] != tau[(i, 0)]) for i in range(a))


def check_first_direction(a, b, c, q):
    left = list(open_configurations(a, b))
    right = list(open_configurations(c, b))
    glued = [glue_first(a, b, c, sigma, tau) for sigma in left for tau in right]

    assert len(glued) == 2 ** ((a + c) * b)
    assert len({tuple(sorted(rho.items())) for rho in glued}) == len(glued)

    for sigma in left:
        for tau in right:
            rho = glue_first(a, b, c, sigma, tau)
            seam = seam_first(a, b, sigma, tau)
            assert 0 <= seam <= b
            assert broken_count(a + c, b, rho) == (
                broken_count(a, b, sigma) + broken_count(c, b, tau) + seam
            )

            # 0<q≤1 では q^b ≤ q^s ≤ 1、1≤q では 1 ≤ q^s ≤ q^b（自然数冪の順序）
            if q <= 1:
                assert q ** b <= q ** seam <= 1
            if q >= 1:
                assert 1 <= q ** seam <= q ** b

    product_value = partition_value(a, b, q) * partition_value(c, b, q)
    glued_value = partition_value(a + c, b, q)
    assert product_value in QQ and glued_value in QQ
    if q <= 1:
        assert q ** b * product_value <= glued_value <= product_value
    if q >= 1:
        assert product_value <= glued_value <= q ** b * product_value


def check_second_direction(a, b, c, q):
    bottom = list(open_configurations(a, b))
    top = list(open_configurations(a, c))
    glued = [glue_second(a, b, c, sigma, tau) for sigma in bottom for tau in top]

    assert len(glued) == 2 ** (a * (b + c))
    assert len({tuple(sorted(rho.items())) for rho in glued}) == len(glued)

    for sigma in bottom:
        for tau in top:
            rho = glue_second(a, b, c, sigma, tau)
            seam = seam_second(a, b, sigma, tau)
            assert 0 <= seam <= a
            assert broken_count(a, b + c, rho) == (
                broken_count(a, b, sigma) + broken_count(a, c, tau) + seam
            )

            if q <= 1:
                assert q ** a <= q ** seam <= 1
            if q >= 1:
                assert 1 <= q ** seam <= q ** a

    product_value = partition_value(a, b, q) * partition_value(a, c, q)
    glued_value = partition_value(a, b + c, q)
    assert product_value in QQ and glued_value in QQ
    if q <= 1:
        assert q ** a * product_value <= glued_value <= product_value
    if q >= 1:
        assert product_value <= glued_value <= q ** a * product_value


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(1), QQ(3) / 2, QQ(22) / 7, QQ(5), QQ(11))
shapes = [(a, b, c) for a in range(1, 4) for b in range(1, 4) for c in range(1, 4)
          if (a + c) * b <= 12 and a * (b + c) <= 12]
total = 0
for a, b, c in shapes:
    for q in test_points:
        check_first_direction(a, b, c, q)
        check_second_direction(a, b, c, q)
        total += 2

print(f"開境界長方形の接合不等式（正の有理点。QQ で厳密）: 形 {len(shapes)} 通り × 有理点 {len(test_points)} 点、{total} 組 OK")
