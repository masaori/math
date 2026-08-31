"""非零巻き付きの頂点単純閉路の周期延長した持ち上げ点の相異なりを厳密検査する。

対象:
- claim_periodic_plane_lift_points_distinct

L=1,2,3 の全頂点単純な閉じた非後退辺列のうち巻き付きベクトルが (0,0) でないものについて、
商 q を -2..2、余り r を 0..m-1 に走らせた周期延長した持ち上げ点
P~_{qm+r} = P_r + q・(L w_v, L w_h) が二つずつ相異なることを ZZ 上で検査する。
巻き付き数は切断線指示値の符号付き和で計算し、P_m - P_0 との一致も確認する。
浮動小数点は使わない。
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
                        assert (points[-1][0] - points[0][0],
                                points[-1][1] - points[0][1]) == period
                        extended = [(points[r][0] + ZZ(q) * period[0],
                                     points[r][1] + ZZ(q) * period[1])
                                    for q in range(-2, 3)
                                    for r in range(len(walk))]
                        assert len(set(extended)) == len(extended)
                        cycle_total += 1
                        point_total += len(extended)

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks "
      f"({point_total} extended lift points over q=-2..2, L=1,2,3)")
