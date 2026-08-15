# 対象ラベル: claim_open_rectangle_iterated_gluing_second
#
# 同じ開境界長方形を第二座標方向へ k 個接いだ値の上下評価を QQ 上で厳密に検査する。
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


def check_iterated_second(a, b, k, t):
    single = partition_value(a, b, t)
    joined = partition_value(a, k * b, t)
    boundary_factor = t ** ((k - 1) * a)
    if t <= 1:
        assert boundary_factor * single ** k <= joined <= single ** k
    else:
        assert single ** k <= joined <= boundary_factor * single ** k


test_points = (QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(2), QQ(3))
sizes = ((1, 1, 1), (1, 1, 2), (1, 1, 3),
         (2, 1, 1), (2, 1, 2), (2, 1, 3),
         (1, 2, 1), (1, 2, 2))
total = 0
for a, b, k in sizes:
    for t in test_points:
        check_iterated_second(a, b, k, t)
        total += 1

print(f"開境界長方形の第二座標方向の反復接合不等式（QQ で厳密）: {total} 組 OK")
