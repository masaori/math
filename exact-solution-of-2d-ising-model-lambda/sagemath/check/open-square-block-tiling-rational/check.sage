# 対象ラベル: claim_open_square_block_tiling_rational
#
# 一辺 a の開境界正方形を k×k 個敷き詰めた値の上下評価の、正の有理点 q ∈ Q_{>0} 版。
# 値は Z[x] の分配多項式への q の代入（def_open_rectangle_partition_value_at_positive_rational）
# で取り、配位ごとの和 Σ_σ q^{b^op(σ)} と一致することも見る。
# 本文の鎖（第一座標方向の反復接合評価・その k 乗・第二座標方向の反復接合評価・合成）を
# 二場合それぞれ段ごとに検査する。浮動小数点・RR・CC は使わない（主張は Q で閉じている）。

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


def check_square_tiling(a, k, q):
    block = partition_value(a, a, q)
    strip = partition_value(k * a, a, q)
    square = partition_value(k * a, k * a, q)
    first_factor = q ** ((k - 1) * a)
    second_factor = q ** ((k - 1) * (k * a))
    # 主張の二場合（q = 1 は両方に属し、両方を見る）。
    if q <= 1:
        # 第一座標方向の反復接合評価（b = a）
        assert first_factor * block ** k <= strip <= block ** k
        # 準備: 正の底の自然数冪は順序を保つ
        assert (first_factor * block ** k) ** k <= strip ** k <= (block ** k) ** k
        # 第二座標方向の反復接合評価（第一座標の長さ ka）
        assert second_factor * strip ** k <= square <= strip ** k
        # 合成の鎖の各段
        assert second_factor * (first_factor * block ** k) ** k <= second_factor * strip ** k
        assert second_factor * (first_factor * block ** k) ** k <= square
        assert square <= (block ** k) ** k
    if q >= 1:
        assert block ** k <= strip <= first_factor * block ** k
        assert (block ** k) ** k <= strip ** k <= (first_factor * block ** k) ** k
        assert strip ** k <= square <= second_factor * strip ** k
        assert second_factor * strip ** k <= second_factor * (first_factor * block ** k) ** k
        assert (block ** k) ** k <= square
        assert square <= second_factor * (first_factor * block ** k) ** k


test_points = (QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(2) / 3, QQ(1),
               QQ(3) / 2, QQ(22) / 7, QQ(5), QQ(11))
sizes = ((1, 1), (1, 2), (1, 3), (2, 1), (2, 2))
total = 0
for a, k in sizes:
    for q in test_points:
        check_square_tiling(a, k, q)
        total += 1

print(f"開境界正方形のブロック敷き詰め評価（正の有理点。QQ で厳密）: {total} 組 OK")
