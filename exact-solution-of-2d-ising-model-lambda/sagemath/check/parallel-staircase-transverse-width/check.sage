"""
平行階段の横断座標が 0 と L w_h w_v の間に収まり、
帯外条件の下で周期持ち上げと交わらないことを ZZ 上で検査する。
"""


def edges(L):
    return [(kind, i, j, d) for kind in ("h", "v")
            for i in range(L) for j in range(L) for d in (0, 1)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def endpoints(L, edge):
    kind, i, j, d = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if d == 0 else (boundary1, boundary0)


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


def seam_indicators(L, edge):
    kind, i, j, d = edge
    c_h = ZZ(1) if kind == "h" and j == L - 1 else ZZ(0)
    c_v = ZZ(1) if kind == "v" and i == L - 1 else ZZ(0)
    return (c_h, c_v)


def integer_sign(value):
    if value < 0:
        return ZZ(-1)
    if value > 0:
        return ZZ(1)
    return ZZ(0)


def transverse(point, w_h, w_v):
    row, col = point
    return w_h * row - w_v * col


def parallel_staircase(L, w_h, w_v):
    height = L * abs(w_v)
    width = L * abs(w_h)
    points = [(integer_sign(w_v) * s, ZZ(0)) for s in range(height + 1)]
    points += [(L * w_v, integer_sign(w_h) * t) for t in range(1, width + 1)]
    return points


def lifted_vertices(L, walk):
    point = (ZZ(0), ZZ(0))
    points = [point]
    for edge in walk:
        kind, _i, _j, direction = edge
        sign = ZZ(1 - 2 * direction)
        step = (ZZ(0), sign) if kind == "h" else (sign, ZZ(0))
        point = (point[0] + step[0], point[1] + step[1])
        points.append(point)
    return points


cycle_total = 0
vertex_total = 0
band_comparison_total = 0
for L in range(1, 4):
    oriented = edges(L)
    for first in oriented:
        frontier = [[first]]
        for length in range(1, L * L + 1):
            next_frontier = []
            for walk in frontier:
                targets = [endpoints(L, edge)[1] for edge in walk]
                if len(set(targets)) == len(targets) \
                        and walk[0] in successors(L, oriented, walk[-1]):
                    w_h = sum(seam_indicators(L, edge)[0] * ZZ(1 - 2 * edge[3])
                              for edge in walk)
                    w_v = sum(seam_indicators(L, edge)[1] * ZZ(1 - 2 * edge[3])
                              for edge in walk)
                    if (w_h, w_v) != (ZZ(0), ZZ(0)):
                        points = parallel_staircase(ZZ(L), w_h, w_v)
                        transverse_values = [transverse(point, w_h, w_v)
                                             for point in points]
                        endpoint_level = ZZ(L) * w_h * w_v
                        assert all(min(ZZ(0), endpoint_level) <= value
                                   <= max(ZZ(0), endpoint_level)
                                   for value in transverse_values)

                        lifted = lifted_vertices(ZZ(L), walk)
                        band_levels = [transverse(point, w_h, w_v)
                                       for point in lifted[:-1]]
                        band_max = max(band_levels)
                        base_level = band_max - min(ZZ(0), endpoint_level) + 1
                        translated_levels = [base_level + value
                                             for value in transverse_values]
                        assert all(value > band_max for value in translated_levels)
                        for translated_level in translated_levels:
                            for band_level in band_levels:
                                assert translated_level != band_level
                                band_comparison_total += 1
                        cycle_total += 1
                        vertex_total += len(points)

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks, "
      f"{vertex_total} parallel-staircase vertices, "
      f"{band_comparison_total} exact band comparisons over L=1,2,3")
