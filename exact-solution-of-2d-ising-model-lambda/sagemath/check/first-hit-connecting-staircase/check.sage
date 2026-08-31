"""最初に当たる歩数で打ち切った接続階段が両端でのみ二つの持ち上げに接することを厳密検査する。

対象:
- def_first_hit_connecting_staircase
- claim_first_hit_connecting_staircase_meets_lifts_only_at_ends

L=1,2,3 の非零巻き付きの頂点単純な閉じた非後退辺列について、横断座標が一周期の
最大水準 K_max に等しい持ち上げ点（商 -2..2）を基点に取り、分離条件
u*W_perp > K_max - K_min を満たす最小の u と u+1 について、反復回数 u の
反復横断階段の最初の当たり歩数 s_hit を求め、接続階段の頂点がすべて相異なること、
s>=1 の頂点が元の周期持ち上げと交わらないこと、s<s_hit の頂点が移動後の
持ち上げと交わらないこと、s_hit の頂点が移動後の持ち上げに属することを
ZZ 上で検査する。持ち上げへの所属は周期並進ベクトルによる整数の割り算で
厳密に判定する（有限窓に頼らない）。
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


def in_translated_lift(point, base_points, period, shift):
    """point が {P_r + q*period + shift | r, q} に属するかを整数演算で判定する。"""
    for rep in base_points:
        diff0 = point[0] - rep[0] - shift[0]
        diff1 = point[1] - rep[1] - shift[1]
        if period[0] != 0:
            quotient, remainder = diff0.quo_rem(period[0])
            if remainder == 0 and diff1 == quotient * period[1]:
                return True
        else:
            quotient, remainder = diff1.quo_rem(period[1])
            if remainder == 0 and diff0 == quotient * period[0]:
                return True
    return False


cycle_total = 0
base_total = 0
staircase_vertex_total = 0
membership_total = 0
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
                        reps = points[:len(walk)]
                        period = (ZZ(L) * w_v, ZZ(L) * w_h)
                        base_values = [transverse(rep, w_h, w_v)
                                       for rep in reps]
                        k_max = max(base_values)
                        k_min = min(base_values)
                        w_perp = w_h * w_h + w_v * w_v
                        d_perp = (w_h, -w_v)
                        u_min = (k_max - k_min) // w_perp + 1
                        assert u_min * w_perp > k_max - k_min
                        window = set()
                        for q in range(-2, 3):
                            for rep in reps:
                                window.add((rep[0] + ZZ(q) * period[0],
                                            rep[1] + ZZ(q) * period[1]))
                        top_bases = [point for point in window
                                     if transverse(point, w_h, w_v) == k_max]
                        assert len(top_bases) >= 1
                        stair = staircase(w_h, w_v)
                        n_perp = len(stair) - 1
                        zero_shift = (ZZ(0), ZZ(0))
                        for base in top_bases:
                            assert in_translated_lift(
                                base, reps, period, zero_shift)
                            for u in (u_min, u_min + 1):
                                shift = (ZZ(u) * d_perp[0], ZZ(u) * d_perp[1])
                                walk_points = iterated_staircase(
                                    base, u, w_h, w_v, stair)
                                assert walk_points[0] == base
                                assert in_translated_lift(
                                    walk_points[-1], reps, period, shift)
                                hits = [s for s in range(1, len(walk_points))
                                        if in_translated_lift(
                                            walk_points[s], reps, period,
                                            shift)]
                                membership_total += len(walk_points) - 1
                                assert len(hits) >= 1
                                s_hit = min(hits)
                                connecting = walk_points[:s_hit + 1]
                                assert len(set(connecting)) == len(connecting)
                                assert not in_translated_lift(
                                    connecting[0], reps, period, shift)
                                membership_total += 1
                                for s in range(1, s_hit + 1):
                                    assert not in_translated_lift(
                                        connecting[s], reps, period,
                                        zero_shift)
                                    membership_total += 1
                                for s in range(1, s_hit):
                                    assert not in_translated_lift(
                                        connecting[s], reps, period, shift)
                                assert in_translated_lift(
                                    connecting[s_hit], reps, period, shift)
                                staircase_vertex_total += len(connecting)
                            base_total += 1
                        cycle_total += 1

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks, "
      f"{base_total} top bases, {staircase_vertex_total} connecting-staircase "
      f"vertices, {membership_total} exact lift-membership checks over L=1,2,3")
