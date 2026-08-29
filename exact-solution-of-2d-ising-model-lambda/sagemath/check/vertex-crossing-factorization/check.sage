"""頂点ごとの横断数が二軸の直進通過数の積になることを厳密検査する。"""


def edges(L):
    return [(kind, i, j, direction) for kind in ("h", "v")
            for i in range(L) for j in range(L) for direction in (0, 1)]


def reversal(edge):
    kind, i, j, direction = edge
    return (kind, i, j, 1 - direction)


def endpoints(L, edge):
    kind, i, j, direction = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if direction == 0 else (boundary1, boundary0)


def direction_number(edge):
    kind, _, _, direction = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, direction)]


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


def straight(edge, successor):
    return (direction_number(successor) - direction_number(edge)) % 4 == 0


closed_walk_total = 0
vertex_checks = 0
multiple_visit_checks = 0
for L in range(1, 4):
    oriented = edges(L)
    vertices = [(i, j) for i in range(L) for j in range(L)]
    frontier = [[edge] for edge in oriented]
    for length in range(1, 6):
        for walk in frontier:
            if walk[0] not in successors(L, oriented, walk[-1]):
                continue
            m = len(walk)
            for vertex in vertices:
                horizontal = [k for k in range(m)
                              if endpoints(L, walk[k])[1] == vertex
                              and straight(walk[k], walk[(k + 1) % m])
                              and direction_number(walk[k]) % 2 == 0]
                vertical = [k for k in range(m)
                            if endpoints(L, walk[k])[1] == vertex
                            and straight(walk[k], walk[(k + 1) % m])
                            and direction_number(walk[k]) % 2 == 1]
                crossing_pairs = [(k, l) for k in horizontal for l in vertical]
                unordered_pairs = {tuple(sorted((k, l))) for k, l in crossing_pairs}
                assert len(unordered_pairs) == ZZ(len(horizontal)) * ZZ(len(vertical))
                vertex_checks += 1
                if len(horizontal) + len(vertical) >= 3:
                    multiple_visit_checks += 1
            closed_walk_total += 1
        if length < 5:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]

assert closed_walk_total == 1064
assert vertex_checks > 0
assert multiple_visit_checks > 0
print(f"PASS: {closed_walk_total} closed walks, {vertex_checks} vertex checks, "
      f"{multiple_visit_checks} multiple-straight-visit checks verified over ZZ")
