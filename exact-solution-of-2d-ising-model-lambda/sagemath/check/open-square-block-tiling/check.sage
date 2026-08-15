# 対象ラベル: claim_open_square_block_tiling
#
# 一辺 a の開境界正方形を k×k 個敷き詰めた値の上下評価を QQ 上で厳密に検査する。
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


def check_square_tiling(a, k, t):
    block = partition_value(a, a, t)
    strip = partition_value(k * a, a, t)
    square = partition_value(k * a, k * a, t)
    first_factor = t ** ((k - 1) * a)
    second_factor = t ** ((k - 1) * (k * a))
    if t <= 1:
        assert first_factor * block ** k <= strip <= block ** k
        assert second_factor * strip ** k <= square <= strip ** k
        assert second_factor * (first_factor * block ** k) ** k <= square
        assert square <= (block ** k) ** k
    else:
        assert block ** k <= strip <= first_factor * block ** k
        assert strip ** k <= square <= second_factor * strip ** k
        assert (block ** k) ** k <= square
        assert square <= second_factor * (first_factor * block ** k) ** k


test_points = (QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(2), QQ(3))
sizes = ((1, 1), (1, 2), (1, 3), (2, 1), (2, 2))
total = 0
for a, k in sizes:
    for t in test_points:
        check_square_tiling(a, k, t)
        total += 1

print(f"開境界正方形のブロック敷き詰め評価（QQ で厳密）: {total} 組 OK")
