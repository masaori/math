# 対象ラベル: claim_periodic_open_boundary_comparison
#
# 周期境界の破れボンド数が、同じ配位を開境界で読んだ破れボンド数と
# 境界を横切る 2L 本のうち破れた本数との和になること、および分配値の
# 上下評価を QQ 上で厳密に検査する。浮動小数点・RR・CC は使わない。

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


def partition_value(configs, edges, t):
    return sum((t ** broken_count(edges, sigma) for sigma in configs), QQ.zero())


test_points = (QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(2), QQ(3))
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

    for t in test_points:
        open_value = partition_value(configs, internal, t)
        periodic_value = partition_value(configs, periodic, t)
        if t <= 1:
            assert t ** (2 * L) * open_value <= periodic_value <= open_value
        else:
            assert open_value <= periodic_value <= t ** (2 * L) * open_value
        total += 1

print(f"周期境界と開境界の境界評価（QQ で厳密）: {total} 組 OK")
