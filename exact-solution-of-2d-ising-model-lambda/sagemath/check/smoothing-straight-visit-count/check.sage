"""横断の平滑化が横断の頂点で各軸の直進通過数を一つ減らすことを厳密検査する。"""


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
crossing_pair_total = 0
same_vertex_checks = 0
other_vertex_checks = 0
smoothed_crossing_checks = 0
other_vertex_crossing_checks = 0
global_crossing_update_checks = 0
non_isolated_pairs = 0
max_length = {1: 5, 2: 8, 3: 8}
for L in range(1, 4):
    oriented = edges(L)
    vertices = [(i, j) for i in range(L) for j in range(L)]
    frontier = [[edge] for edge in oriented]
    for length in range(1, max_length[L] + 1):
        for walk in frontier:
            if walk[0] not in successors(L, oriented, walk[-1]):
                continue
            m = len(walk)
            pairs = [(k, l) for k in range(m) for l in range(m)
                     if k < l and crossing(L, walk, k, l)]
            for k, l in pairs:
                cross_vertex = endpoints(L, walk[k])[1]
                # 平滑化後の出辺（def_smoothing_straight_visit_count の f_r）
                out_edge = {r: walk[(r + 1) % m] for r in range(m)}
                out_edge[k] = walk[(l + 1) % m]
                out_edge[l] = walk[(k + 1) % m]
                # 平滑化後の各接続は非後退のまま（def_isolated_crossing_smoothing の注意）
                for r in range(m):
                    assert out_edge[r] != reversal(walk[r])
                if sum(1 for r in range(m)
                       if endpoints(L, walk[r])[1] == cross_vertex) >= 3:
                    non_isolated_pairs += 1
                for vertex in vertices:
                    for axis in (0, 1):
                        before = ZZ(sum(
                            1 for r in range(m)
                            if endpoints(L, walk[r])[1] == vertex
                            and straight(walk[r], walk[(r + 1) % m])
                            and direction_number(walk[r]) % 2 == axis))
                        after = ZZ(sum(
                            1 for r in range(m)
                            if endpoints(L, walk[r])[1] == vertex
                            and straight(walk[r], out_edge[r])
                            and direction_number(walk[r]) % 2 == axis))
                        if vertex == cross_vertex:
                            assert before >= 1
                            assert after == before - 1
                            same_vertex_checks += 1
                        else:
                            assert after == before
                            other_vertex_checks += 1
                before_axis = {
                    axis: ZZ(sum(
                        1 for r in range(m)
                        if endpoints(L, walk[r])[1] == cross_vertex
                        and straight(walk[r], walk[(r + 1) % m])
                        and direction_number(walk[r]) % 2 == axis))
                    for axis in (0, 1)
                }
                after_axis = {
                    axis: ZZ(sum(
                        1 for r in range(m)
                        if endpoints(L, walk[r])[1] == cross_vertex
                        and straight(walk[r], out_edge[r])
                        and direction_number(walk[r]) % 2 == axis))
                    for axis in (0, 1)
                }
                after_crossings = ZZ(sum(
                    1 for r in range(m) for s in range(m)
                    if r < s
                    and endpoints(L, walk[r])[1] == cross_vertex
                    and endpoints(L, walk[s])[1] == cross_vertex
                    and straight(walk[r], out_edge[r])
                    and straight(walk[s], out_edge[s])
                    and direction_number(walk[r]) % 2
                    != direction_number(walk[s]) % 2))
                assert after_crossings == after_axis[0] * after_axis[1]
                assert after_crossings == ((before_axis[0] - 1)
                                           * (before_axis[1] - 1))
                smoothed_crossing_checks += 1
                before_total = ZZ(sum(
                    1 for r in range(m) for s in range(m)
                    if r < s and crossing(L, walk, r, s)))
                after_total = ZZ(sum(
                    1 for r in range(m) for s in range(m)
                    if r < s
                    and endpoints(L, walk[r])[1] == endpoints(L, walk[s])[1]
                    and straight(walk[r], out_edge[r])
                    and straight(walk[s], out_edge[s])
                    and direction_number(walk[r]) % 2
                    != direction_number(walk[s]) % 2))
                assert (before_total + 1
                        == after_total + before_axis[0] + before_axis[1])
                global_crossing_update_checks += 1
                for vertex in vertices:
                    if vertex == cross_vertex:
                        continue
                    before_w = ZZ(sum(
                        1 for r in range(m) for s in range(m)
                        if r < s
                        and endpoints(L, walk[r])[1] == vertex
                        and endpoints(L, walk[s])[1] == vertex
                        and straight(walk[r], walk[(r + 1) % m])
                        and straight(walk[s], walk[(s + 1) % m])
                        and direction_number(walk[r]) % 2
                        != direction_number(walk[s]) % 2))
                    after_w = ZZ(sum(
                        1 for r in range(m) for s in range(m)
                        if r < s
                        and endpoints(L, walk[r])[1] == vertex
                        and endpoints(L, walk[s])[1] == vertex
                        and straight(walk[r], out_edge[r])
                        and straight(walk[s], out_edge[s])
                        and direction_number(walk[r]) % 2
                        != direction_number(walk[s]) % 2))
                    assert after_w == before_w
                    other_vertex_crossing_checks += 1
                crossing_pair_total += 1
            closed_walk_total += 1
        if length < max_length[L]:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]

assert closed_walk_total == 24628
assert crossing_pair_total == 3584
assert same_vertex_checks > 0
assert other_vertex_checks > 0
assert non_isolated_pairs > 0
assert smoothed_crossing_checks == crossing_pair_total
assert other_vertex_crossing_checks > 0
assert global_crossing_update_checks == crossing_pair_total
print(f"PASS: {closed_walk_total} closed walks, {crossing_pair_total} crossing pairs, "
      f"{same_vertex_checks} same-vertex and {other_vertex_checks} other-vertex "
      f"count checks, {smoothed_crossing_checks} smoothed vertex-crossing checks, "
      f"{other_vertex_crossing_checks} other-vertex crossing invariance checks "
      f"and {global_crossing_update_checks} global crossing update checks "
      f"({non_isolated_pairs} non-isolated pairs) verified over ZZ")
