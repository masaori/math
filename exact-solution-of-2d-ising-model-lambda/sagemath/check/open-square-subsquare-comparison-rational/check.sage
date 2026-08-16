# 対象ラベル: claim_open_square_subsquare_comparison_rational_le_one
#
# 一辺 L の開境界正方形の値と、一辺 a (< L) の部分正方形の値の比較の、正の有理点 q ∈ Q_{>0}、
# 0 < q ≤ 1 の場合。値は Z[x] の分配多項式への q の代入
# （def_open_rectangle_partition_value_at_positive_rational）で取り、配位ごとの和と一致することも見る。
# 本文の鎖（下側 7 段・上側 8 段）を段ごとに検査する。浮動小数点・RR・CC は使わない（主張は Q で閉じている）。

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




def check_subsquare(a, L, q):
    assert 1 <= a < L and 0 < q <= 1
    c = L - a                                   # 準備の第一
    assert a * c + c * L == L ** 2 - a ** 2     # 準備の第二
    Zaa = partition_value(a, a, q)
    Zac = partition_value(a, c, q)
    ZaL = partition_value(a, L, q)
    ZcL = partition_value(c, L, q)
    ZLL = partition_value(L, L, q)
    Bac = ZZ(2) ** (a * c) * (1 + q) ** (2 * a * c)
    BcL = ZZ(2) ** (c * L) * (1 + q) ** (2 * c * L)
    # 下からの評価の鎖
    lower = [q ** (a + L) * Zaa,
             q ** L * q ** a * Zaa,
             q ** L * q ** a * Zaa * Zac,
             q ** L * partition_value(a, a + c, q),
             q ** L * ZaL,
             q ** L * ZaL * ZcL,
             partition_value(a + c, L, q),
             ZLL]
    assert lower[0] == lower[1]
    assert lower[1] <= lower[2]                 # 1 ≤ Z_{a,c}
    assert lower[2] <= lower[3]                 # 第二座標方向の接合の下側
    assert lower[3] == lower[4]
    assert lower[4] <= lower[5]                 # 1 ≤ Z_{c,L}
    assert lower[5] <= lower[6]                 # 第一座標方向の接合の下側
    assert lower[6] == lower[7]
    # 上からの評価の鎖
    upper = [ZLL,
             partition_value(a + c, L, q),
             ZaL * ZcL,
             partition_value(a, a + c, q) * ZcL,
             Zaa * Zac * ZcL,
             Zaa * Bac * ZcL,
             Zaa * Bac * BcL,
             ZZ(2) ** (a * c + c * L) * (1 + q) ** (2 * (a * c + c * L)) * Zaa,
             ZZ(2) ** (L ** 2 - a ** 2) * (1 + q) ** (2 * (L ** 2 - a ** 2)) * Zaa]
    assert upper[0] == upper[1]
    assert upper[1] <= upper[2]                 # 第一座標方向の接合の上側
    assert upper[2] == upper[3]
    assert upper[3] <= upper[4]                 # 第二座標方向の接合の上側
    assert upper[4] <= upper[5]                 # Z_{a,c} ≤ B_{a,c}
    assert upper[5] <= upper[6]                 # Z_{c,L} ≤ B_{c,L}
    assert upper[6] == upper[7]
    assert upper[7] == upper[8]
    # 主張そのもの
    assert lower[0] <= ZLL <= upper[8]
    return 15


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(9) / 10, QQ(1))
sizes = ((1, 2), (1, 3), (2, 3))
total = 0
for a, L in sizes:
    for q in test_points:
        total += check_subsquare(a, L, q)

print(f"開境界正方形と部分正方形の値の比較（正の有理点、q ≤ 1。QQ で厳密）: {total} 検査 OK")
