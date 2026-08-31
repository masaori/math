"""閉歩道の平面持ち上げの終点が始点と巻き付きベクトルの L 倍だけ違うことを厳密検査する。

対象:
- claim_plane_lift_endpoint_winding

L=1,2,3・長さ 6 までのすべての閉じた非後退辺列について、def_plane_lift の
漸化式で P_0,...,P_m を計算し、def_directed_winding_numbers の w_h, w_v と
P_m = P_0 + (L*w_v, L*w_h) が ZZ 上で成り立つことを検査する。浮動小数点は使わない。
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


def seam_crossings(L, edge):
    kind, i, j, d = edge
    c_h = ZZ(1) if kind == "h" and j == L - 1 else ZZ(0)
    c_v = ZZ(1) if kind == "v" and i == L - 1 else ZZ(0)
    return c_h, c_v


closed_total = 0
max_length = 6
for L in range(1, 4):
    oriented = edges(L)
    for first in oriented:
        frontier = [[first]]
        for length in range(1, max_length + 1):
            next_frontier = []
            for walk in frontier:
                if walk[0] in successors(L, oriented, walk[-1]):
                    start = (ZZ(endpoints(L, walk[0])[0][0]),
                             ZZ(endpoints(L, walk[0])[0][1]))
                    point = start
                    w_h = ZZ(0)
                    w_v = ZZ(0)
                    for edge in walk:
                        dr, dc = displacement(edge)
                        point = (point[0] + dr, point[1] + dc)
                        c_h, c_v = seam_crossings(L, edge)
                        sign = ZZ(1 - 2 * edge[3])
                        w_h += c_h * sign
                        w_v += c_v * sign
                    assert point == (start[0] + ZZ(L) * w_v,
                                     start[1] + ZZ(L) * w_h)
                    closed_total += 1

                if length < max_length:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {closed_total} closed nonbacktracking walks "
      f"(length<=6, L=1,2,3) satisfy P_m = P_0 + (L*w_v, L*w_h)")
