"""
非零巻き付きの頂点単純な閉じた非後退辺列の循環総回転数が零であることを、
証明の合成（基点 k0・t=1 の一側閉包の c=1,2,3 の射影回転数と三周期比較）ごと ZZ 上で検査する。
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


def cyclic_total_turning(points):
    directions = {
        (ZZ(0), ZZ(1)): ZZ(0),
        (ZZ(1), ZZ(0)): ZZ(1),
        (ZZ(0), ZZ(-1)): ZZ(2),
        (ZZ(-1), ZZ(0)): ZZ(3),
    }
    edge_directions = [directions[sub(points[j + 1], points[j])]
                       for j in range(len(points) - 1)]
    total = ZZ(0)
    for j in range(len(edge_directions)):
        difference = (edge_directions[(j + 1) % len(edge_directions)]
                      - edge_directions[j]) % 4
        assert difference != 2
        total += ZZ(1) if difference == 1 else ZZ(-1) if difference == 3 else ZZ(0)
    return total


cycle_total = 0
composition_total = 0
zero_total = 0
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

                        # 証明と同じく、最大横断水準を達成する最初の添字と t=1 を取る
                        k0 = ZZ(min(r for r in range(m) if levels[r] == k_max))
                        t = ZZ(1)
                        cycle_turning = cyclic_total_turning(lifted)
                        closure_turnings = {}
                        for c in (ZZ(1), ZZ(2), ZZ(3)):
                            n_total = c * m + 2 * t * n_perp + c * n_par
                            q1 = lift(k0 + c * m)
                            top = add(lift(k0), scale(t, d_perp))

                            def closure_point(j):
                                if j <= c * m:
                                    return lift(k0 + j)
                                if j <= c * m + t * n_perp:
                                    return iterated(q1, t, j - c * m)
                                if j <= c * m + t * n_perp + c * n_par:
                                    i = j - c * m - t * n_perp
                                    a_q, b_r = divmod(i, n_par)
                                    return sub(
                                        add(top, scale(c - a_q, big_b)),
                                        g_stairs[b_r])
                                return iterated(lift(k0), t, n_total - j)

                            points = [closure_point(ZZ(j))
                                      for j in range(n_total + 1)]
                            closure_turnings[c] = cyclic_total_turning(points)

                        # 証明の a, b と c=1,2,3 の等式・帰属・結論を一行ずつ検査する
                        a_value = closure_turnings[ZZ(1)] - cycle_turning
                        b_value = cycle_turning
                        for c in (ZZ(1), ZZ(2), ZZ(3)):
                            assert a_value + c * b_value == closure_turnings[c]
                            assert closure_turnings[c] in (ZZ(4), ZZ(-4))
                            composition_total += 1
                        assert b_value == ZZ(0)
                        assert cycle_turning == ZZ(0)
                        zero_total += 1

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks, "
      f"{composition_total} composition identities a+cb=t(Gamma_c) in {{+4,-4}}, "
      f"{zero_total} conclusions t(gamma)=0 over L=1,2,3")
