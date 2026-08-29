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


def crossing(L, walk, k, l):
    """添字 k, l の通過が横断するか（def_index_pair_crossing）。"""
    m = len(walk)
    vertex_k = endpoints(L, walk[k])[1]
    vertex_l = endpoints(L, walk[l])[1]
    if vertex_k != vertex_l:
        return False
    straight_k = straight(walk[k], walk[(k + 1) % m])
    straight_l = straight(walk[l], walk[(l + 1) % m])
    axis_k = direction_number(walk[k]) % 2
    axis_l = direction_number(walk[l]) % 2
    return straight_k and straight_l and axis_k != axis_l


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
                # 左辺 c_v(γ): 横断の定義（def_index_pair_crossing）から独立に数える
                vertexwise_crossing = ZZ(sum(
                    1 for k in range(m) for l in range(k + 1, m)
                    if crossing(L, walk, k, l)
                    and endpoints(L, walk[k])[1] == vertex))
                assert vertexwise_crossing == ZZ(len(horizontal)) * ZZ(len(vertical))
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
