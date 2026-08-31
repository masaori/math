"""反復横断階段が各歩で横断座標を増やし基点より歩数以上高くなることを厳密検査する。

対象:
- claim_iterated_transverse_staircase_lower_bound

L=1,2,3 の非零巻き付きの頂点単純な閉じた非後退辺列について、基点 Q・反復回数 t の
反復横断階段の各差が横断階段の一歩に等しい単位格子ベクトルであり、整数横断座標が
各歩で真に増え、s 歩後に基点より s 以上高いことを ZZ 上で検査する。
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
step_total = 0
base_points = [(ZZ(0), ZZ(0)), (ZZ(2), ZZ(-1))]
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
                        stair = staircase(w_h, w_v)
                        n_perp = len(stair) - 1
                        for base in base_points:
                            for repetition in repetitions:
                                points = iterated_staircase(
                                    base, repetition, w_h, w_v, stair)
                                assert points[0] == base
                                assert points[-1] == (
                                    base[0] + ZZ(repetition) * w_h,
                                    base[1] - ZZ(repetition) * w_v)
                                base_level = transverse(base, w_h, w_v)
                                for s in range(len(points) - 1):
                                    q, r = divmod(s, n_perp)
                                    difference = (
                                        points[s + 1][0] - points[s][0],
                                        points[s + 1][1] - points[s][1])
                                    stair_step = (
                                        stair[r + 1][0] - stair[r][0],
                                        stair[r + 1][1] - stair[r][1])
                                    assert difference == stair_step
                                    assert abs(difference[0]) \
                                        + abs(difference[1]) == 1
                                    assert transverse(points[s + 1], w_h, w_v) \
                                        > transverse(points[s], w_h, w_v)
                                    step_total += 1
                                for s in range(len(points)):
                                    assert transverse(points[s], w_h, w_v) \
                                        >= base_level + ZZ(s)
                                assert len(set(points)) == len(points)
                        cycle_total += 1

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks "
      f"({step_total} iterated staircase steps over L=1,2,3, "
      f"{len(base_points)} base points x {len(repetitions)} repetitions)")
