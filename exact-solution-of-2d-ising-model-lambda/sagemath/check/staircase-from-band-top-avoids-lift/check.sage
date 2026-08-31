"""整数帯の上端以上の基点からの反復横断階段が基点以外で周期持ち上げと交わらないことを厳密検査する。

対象:
- claim_staircase_from_band_top_meets_lift_only_at_base

L=1,2,3 の非零巻き付きの頂点単純な閉じた非後退辺列について、横断座標が一周期の
最大水準 K_max に等しい持ち上げ点を基点に取り、反復回数 t=1,2 の反復横断階段の
s>=1 の全頂点の横断座標が K_max を真に超え、周期延長した持ち上げ点（商 -2..2）と
一致しないことを ZZ 上で検査する。
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


def displacement(edge):
    kind, i, j, d = edge
    sign = ZZ(1 - 2 * d)
    return (sign, ZZ(0)) if kind == "v" else (ZZ(0), sign)


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


def staircase(w_h, w_v):
    height = abs(w_h)
    width = abs(w_v)
    points = [(integer_sign(w_h) * s, ZZ(0)) for s in range(height + 1)]
    points += [(w_h, -integer_sign(w_v) * t) for t in range(1, width + 1)]
    return points


def iterated_staircase(base, repetition, w_h, w_v, stair):
    n_perp = len(stair) - 1
    points = []
    for s in range(repetition * n_perp + 1):
        q, r = divmod(s, n_perp)
        points.append((base[0] + ZZ(q) * w_h + stair[r][0],
                       base[1] - ZZ(q) * w_v + stair[r][1]))
    return points


cycle_total = 0
staircase_vertex_total = 0
comparison_total = 0
repetitions = [1, 2]
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
                        points = [(ZZ(endpoints(L, walk[0])[0][0]),
                                   ZZ(endpoints(L, walk[0])[0][1]))]
                        for edge in walk:
                            dr, dc = displacement(edge)
                            points.append((points[-1][0] + dr,
                                           points[-1][1] + dc))
                        period = (ZZ(L) * w_v, ZZ(L) * w_h)
                        base_values = [transverse(points[r], w_h, w_v)
                                       for r in range(len(walk))]
                        k_max = max(base_values)
                        lift_points = set()
                        for q in range(-2, 3):
                            for r in range(len(walk)):
                                lift_points.add((points[r][0] + ZZ(q) * period[0],
                                                 points[r][1] + ZZ(q) * period[1]))
                        top_bases = [point for point in lift_points
                                     if transverse(point, w_h, w_v) == k_max]
                        assert len(top_bases) >= 1
                        stair = staircase(w_h, w_v)
                        for base in top_bases:
                            for repetition in repetitions:
                                walk_points = iterated_staircase(
                                    base, repetition, w_h, w_v, stair)
                                assert walk_points[0] == base
                                for s in range(1, len(walk_points)):
                                    assert transverse(walk_points[s], w_h, w_v) \
                                        > k_max
                                    assert walk_points[s] not in lift_points
                                    staircase_vertex_total += 1
                                    comparison_total += len(lift_points)
                        cycle_total += 1

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks "
      f"({staircase_vertex_total} staircase vertices above the band and "
      f"{comparison_total} vertex-lift comparisons over L=1,2,3)")
