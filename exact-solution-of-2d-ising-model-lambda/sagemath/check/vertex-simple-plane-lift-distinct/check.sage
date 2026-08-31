"""頂点単純閉路の一周期の平面持ち上げ点の相異なりを厳密検査する。

対象:
- claim_vertex_simple_plane_lift_points_distinct

L=1,2,3 の全頂点単純な閉じた非後退辺列について、P_0,...,P_{m-1}
が二つずつ相異なることを ZZ 上で検査する。浮動小数点は使わない。
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


cycle_total = 0
point_total = 0
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
                    points = [(ZZ(endpoints(L, walk[0])[0][0]),
                               ZZ(endpoints(L, walk[0])[0][1]))]
                    for edge in walk:
                        dr, dc = displacement(edge)
                        points.append((points[-1][0] + dr, points[-1][1] + dc))
                    one_period = points[:-1]
                    assert len(set(one_period)) == len(one_period)
                    cycle_total += 1
                    point_total += len(one_period)

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple closed nonbacktracking walks "
      f"({point_total} one-period lift points, L=1,2,3)")
