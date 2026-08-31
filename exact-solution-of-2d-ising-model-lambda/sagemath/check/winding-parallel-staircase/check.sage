"""巻き付きベクトルの平行階段が平行座標を増やす単位歩であることを厳密検査する。

対象:
- claim_winding_parallel_staircase_step_increase

L=1,2,3 の非零巻き付きの頂点単純な閉じた非後退辺列について、平行階段の各差が
四つの単位格子ベクトルのいずれかであり、平行座標が各歩で真に増えること、
始点が (0,0)・終点が一周期の並進ベクトル (L w_v, L w_h) であること、
全頂点が相異なることを ZZ 上で検査する。
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


def parallel(point, w_h, w_v):
    row, col = point
    return w_v * row + w_h * col


def parallel_staircase(L, w_h, w_v):
    height = L * abs(w_v)
    width = L * abs(w_h)
    points = [(integer_sign(w_v) * s, ZZ(0)) for s in range(height + 1)]
    points += [(L * w_v, integer_sign(w_h) * t) for t in range(1, width + 1)]
    return points


cycle_total = 0
step_total = 0
unit_steps = {(ZZ(1), ZZ(0)), (ZZ(-1), ZZ(0)),
              (ZZ(0), ZZ(1)), (ZZ(0), ZZ(-1))}
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
                        assert points[0] == (ZZ(0), ZZ(0))
                        assert points[-1] == (ZZ(L) * w_v, ZZ(L) * w_h)
                        assert len(points) == ZZ(L) * (abs(w_v) + abs(w_h)) + 1
                        for left, right in zip(points, points[1:]):
                            difference = (right[0] - left[0], right[1] - left[1])
                            assert difference in unit_steps
                            assert parallel(right, w_h, w_v) \
                                > parallel(left, w_h, w_v)
                            step_total += 1
                        assert len(set(points)) == len(points)
                        cycle_total += 1

                if length < L * L:
                    for nxt in successors(L, oriented, walk[-1]):
                        next_targets = targets + [endpoints(L, nxt)[1]]
                        if len(set(next_targets)) == len(next_targets):
                            next_frontier.append(walk + [nxt])
            frontier = next_frontier

print(f"PASS: {cycle_total} vertex-simple nonzero-winding closed walks "
      f"({step_total} parallel staircase steps over L=1,2,3)")
