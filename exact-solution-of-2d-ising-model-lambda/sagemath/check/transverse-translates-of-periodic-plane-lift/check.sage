"""横断幅を超えて離した周期持ち上げが交わらないことを整数上で厳密検査する。

対象:
- claim_transverse_translates_of_periodic_plane_lift_disjoint

L=1,2,3 の非零巻き付きの頂点単純な閉じた非後退辺列について、横断平行移動後の
横断座標の等式と、有限幅を超える二移動の全点対の横断座標の真の不等式を ZZ 上で検査する。
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


def transverse(point, w_h, w_v):
    row, col = point
    return w_h * row - w_v * col


cycle_total = 0
identity_total = 0
separated_pair_total = 0
translations = list(range(-3, 4))
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
                        d_perp = (w_h, -w_v)
                        width = w_h^2 + w_v^2
                        assert width >= 1
                        base_values = [transverse(points[r], w_h, w_v)
                                       for r in range(len(walk))]
                        k_min = min(base_values)
                        k_max = max(base_values)
                        translated_points = {}
                        for u in translations:
                            translated_points[u] = []
                            for q in range(-1, 2):
                                for r in range(len(walk)):
                                    extended = (
                                        points[r][0] + ZZ(q) * period[0],
                                        points[r][1] + ZZ(q) * period[1])
                                    translated = (
                                        extended[0] + ZZ(u) * d_perp[0],
                                        extended[1] + ZZ(u) * d_perp[1])
                                    assert transverse(translated, w_h, w_v) \
                                        == transverse(extended, w_h, w_v) + ZZ(u) * width
                                    translated_points[u].append(translated)
                                    identity_total += 1
                        for u in translations:
                            for v in translations:
                                if u < v and ZZ(v - u) * width > k_max - k_min:
                                    left_levels = [transverse(point, w_h, w_v)
                                                   for point in translated_points[u]]
                                    right_levels = [transverse(point, w_h, w_v)
                                                    for point in translated_points[v]]
                                    assert max(left_levels) < min(right_levels)
                                    assert set(translated_points[u]).isdisjoint(
                                        set(translated_points[v]))
                                    separated_pair_total += len(left_levels) * len(right_levels)
                        cycle_total += 1

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks "
      f"({identity_total} translated lift point identities and "
      f"{separated_pair_total} separated point pairs over L=1,2,3)")
