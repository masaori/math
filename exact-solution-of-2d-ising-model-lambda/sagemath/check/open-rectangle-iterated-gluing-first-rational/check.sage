# 対象ラベル: claim_open_rectangle_iterated_gluing_first_rational
#
# 同じ開境界長方形を第一座標方向へ k 個接いだ値の上下評価の、正の有理点 q ∈ Q_{>0} 版。
# 値は Z[x] の分配多項式への q の代入（def_open_rectangle_partition_value_at_positive_rational）
# で取り、配位ごとの和 Σ_σ q^{b^op(σ)} と一致することも見る。
# 本文の帰納段（一辺 ka と a の二長方形への接合不等式と帰納法の仮定の積）も k ごとに検査する。
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


def check_iterated_first(a, b, k, q):
    single = partition_value(a, b, q)
    joined = partition_value(k * a, b, q)
    boundary_factor = q ** ((k - 1) * b)
    # 主張の二場合（q = 1 は両方に属し、両方を見る）。
    if q <= 1:
        assert boundary_factor * single ** k <= joined <= single ** k
    if q >= 1:
        assert single ** k <= joined <= boundary_factor * single ** k
    # 帰納段: 一辺 ka と a の二長方形への接合不等式（正の有理点）と帰納法の仮定の積。
    if k >= 2:
        prev = partition_value((k - 1) * a, b, q)
        prev_factor = q ** ((k - 2) * b)
        assert q ** ((k - 1) * b) == q ** b * prev_factor            # kb = b + (k-1)b
        if q <= 1:
            assert q ** b * prev_factor * single ** (k - 1) * single <= q ** b * prev * single
            assert q ** b * prev * single <= joined <= prev * single
            assert prev * single <= single ** (k - 1) * single == single ** k
        if q >= 1:
            assert single ** (k - 1) * single <= prev * single <= joined
            assert joined <= q ** b * prev * single
            assert q ** b * prev * single <= q ** b * prev_factor * single ** (k - 1) * single


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(1),
               QQ(3) / 2, QQ(22) / 7, QQ(5), QQ(11))
sizes = ((1, 1, 1), (1, 1, 2), (1, 1, 3), (1, 1, 4),
         (1, 2, 1), (1, 2, 2), (1, 2, 3),
         (2, 1, 1), (2, 1, 2), (2, 1, 3),
         (2, 2, 1), (2, 2, 2),
         (3, 1, 1), (3, 1, 2))
total = 0
for a, b, k in sizes:
    for q in test_points:
        check_iterated_first(a, b, k, q)
        total += 1

print(f"開境界長方形の第一座標方向の反復接合不等式（正の有理点。QQ で厳密）: {total} 組 OK")
