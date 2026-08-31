"""
一側閉包（周期持ち上げ c 周期分・反復横断階段・逆向き平行階段 c 本・逆向き反復横断階段）が
閉じた単位格子路であることを ZZ 上で検査する。
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


def transverse_staircase(w_h, w_v):
    height = abs(w_h)
    width = abs(w_v)
    points = [(integer_sign(w_h) * s, ZZ(0)) for s in range(height + 1)]
    points += [(w_h, -integer_sign(w_v) * s) for s in range(1, width + 1)]
    return points


def parallel_staircase(L, w_h, w_v):
    height = L * abs(w_v)
    width = L * abs(w_h)
    if w_h * w_v > 0:
        points = [(ZZ(0), integer_sign(w_h) * t) for t in range(width + 1)]
        points += [(integer_sign(w_v) * s, L * w_h)
                   for s in range(1, height + 1)]
        return points
    points = [(integer_sign(w_v) * s, ZZ(0)) for s in range(height + 1)]
    points += [(L * w_v, integer_sign(w_h) * t) for t in range(1, width + 1)]
    return points


def add(p, q):
    return (p[0] + q[0], p[1] + q[1])


def sub(p, q):
    return (p[0] - q[0], p[1] - q[1])


def scale(z, p):
    return (z * p[0], z * p[1])


UNIT_STEPS = {(ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)), (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1))}

cycle_total = 0
closure_total = 0
step_total = 0
distinct_vertex_total = 0
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
                        cycle_total += 1
                        m = ZZ(len(walk))
                        lifted = lifted_vertices(ZZ(L), walk)
                        period_points = lifted[:-1]
                        big_b = (ZZ(L) * w_v, ZZ(L) * w_h)
                        assert lifted[-1] == add(lifted[0], big_b)
                        d_perp = (w_h, -w_v)
                        w_perp = w_h ** 2 + w_v ** 2
                        levels = [transverse(point, w_h, w_v)
                                  for point in period_points]
                        k_max = max(levels)
                        c_stairs = transverse_staircase(w_h, w_v)
                        n_perp = ZZ(len(c_stairs) - 1)
                        g_stairs = parallel_staircase(ZZ(L), w_h, w_v)
                        n_par = ZZ(len(g_stairs) - 1)

                        def lift(k):
                            q, r = divmod(k, m)
                            return add(period_points[r], scale(q, big_b))

                        def iterated(base, t, s):
                            q, r = divmod(s, n_perp)
                            return add(add(base, scale(q, d_perp)), c_stairs[r])

                        t_min = ZZ(1)
                        base_indices = [r for r in range(m)
                                        if levels[r] == k_max]
                        for k0 in base_indices:
                            start = lift(ZZ(k0))
                            for c in (ZZ(1), ZZ(2)):
                                for t in (t_min, t_min + 1):
                                    n_total = c * m + 2 * t * n_perp + c * n_par
                                    q1 = lift(ZZ(k0) + c * m)
                                    assert q1 == add(start, scale(c, big_b))
                                    top = add(start, scale(t, d_perp))

                                    def closure_point(j):
                                        if j <= c * m:
                                            return lift(ZZ(k0) + j)
                                        if j <= c * m + t * n_perp:
                                            return iterated(q1, t, j - c * m)
                                        if j <= c * m + t * n_perp + c * n_par:
                                            i = j - c * m - t * n_perp
                                            a, b = divmod(i, n_par)
                                            return sub(
                                                add(top, scale(c - a, big_b)),
                                                g_stairs[b])
                                        return iterated(start, t, n_total - j)

                                    points = [closure_point(ZZ(j))
                                              for j in range(n_total + 1)]
                                    assert points[0] == start
                                    assert points[n_total] == start
                                    boundary1 = c * m
                                    boundary2 = c * m + t * n_perp
                                    boundary3 = boundary2 + c * n_par
                                    assert points[boundary1] == q1
                                    assert points[boundary2] == add(
                                        add(start, scale(c, big_b)),
                                        scale(t, d_perp))
                                    assert points[boundary3] == top
                                    assert len(set(points[:-1])) == n_total
                                    distinct_vertex_total += n_total
                                    for j in range(n_total):
                                        step = sub(points[j + 1], points[j])
                                        assert step in UNIT_STEPS
                                        step_total += 1
                                    closure_total += 1

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks, "
      f"{closure_total} one-sided closures, "
      f"{step_total} exact unit-step checks, "
      f"{distinct_vertex_total} vertices in distinctness checks over L=1,2,3")
