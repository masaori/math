# 対象ラベル: def_open_rectangle_partition_value,
#             claim_open_rectangle_gluing_inequality
#
# 開境界長方形を二つ接いだとき、接合面の破れ辺数による重みの差だけが
# 分配多項式の積と接合後の値との差になることを QQ 上で厳密に検査する。
# 浮動小数点・RR・CC は使わない。

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


def partition_value(a, b, t):
    return sum((t ** broken_count(a, b, sigma)
                for sigma in open_configurations(a, b)), QQ.zero())


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


def check_first_direction(a, b, c, t):
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

    product_value = partition_value(a, b, t) * partition_value(c, b, t)
    glued_value = partition_value(a + c, b, t)
    if t <= 1:
        assert t ** b * product_value <= glued_value <= product_value
    else:
        assert product_value <= glued_value <= t ** b * product_value


def check_second_direction(a, b, c, t):
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

    product_value = partition_value(a, b, t) * partition_value(a, c, t)
    glued_value = partition_value(a, b + c, t)
    if t <= 1:
        assert t ** a * product_value <= glued_value <= product_value
    else:
        assert product_value <= glued_value <= t ** a * product_value


test_points = (QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(2), QQ(3))
total = 0
for a in range(1, 3):
    for b in range(1, 3):
        for c in range(1, 3):
            for t in test_points:
                check_first_direction(a, b, c, t)
                check_second_direction(a, b, c, t)
                total += 2

print(f"開境界長方形の接合不等式（QQ で厳密）: {total} 組 OK")
