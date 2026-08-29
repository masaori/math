"""閉歩道の横断数が頂点ごとの横断数の和になることを厳密検査する。"""


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


def step_turning(edge, successor):
    turn = (direction_number(successor) - direction_number(edge)) % 4
    assert turn in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[turn]


def crossing(L, walk, k, l):
    """添字 k, l の通過が横断するか（def_index_pair_crossing）。"""
    m = len(walk)
    vertex_k = endpoints(L, walk[k])[1]
    vertex_l = endpoints(L, walk[l])[1]
    if vertex_k != vertex_l:
        return False
    straight_k = step_turning(walk[k], walk[(k + 1) % m]) == 0
    straight_l = step_turning(walk[l], walk[(l + 1) % m]) == 0
    axis_k = direction_number(walk[k]) % 2
    axis_l = direction_number(walk[l]) % 2
    return straight_k and straight_l and axis_k != axis_l


# claim_crossing_number_vertex_decomposition:
# L=1,2,3、辺 1〜5 本の全閉じた非後退辺列について、
#   c(γ) = Σ_{v∈V_L} c_v(γ)
# を ZZ で厳密に確認する。あわせて def_vertexwise_crossing_number の前提
# （横断対の二つの通過の頂点は等しい）も全対で確認する。
closed_walk_total = 0
positive_crossing_walks = 0
checked_pairs = 0
for L in range(1, 4):
    oriented = edges(L)
    vertices = [(i, j) for i in range(L) for j in range(L)]
    frontier = [[edge] for edge in oriented]
    for length in range(1, 6):
        for walk in frontier:
            if walk[0] not in successors(L, oriented, walk[-1]):
                continue
            m = len(walk)
            pairs = [(k, l) for k in range(m) for l in range(m)
                     if k < l and crossing(L, walk, k, l)]
            for k, l in pairs:
                assert endpoints(L, walk[k])[1] == endpoints(L, walk[l])[1]
                checked_pairs += 1
            total = ZZ(len(pairs))
            vertexwise = [ZZ(sum(1 for (k, l) in pairs
                                 if endpoints(L, walk[k])[1] == v))
                          for v in vertices]
            assert total == sum(vertexwise)
            assert (total % 2) == (sum(1 for c_v in vertexwise if c_v % 2 == 1) % 2)
            if total > 0:
                positive_crossing_walks += 1
            closed_walk_total += 1
        if length < 5:
            frontier = [walk + [nxt] for walk in frontier
                        for nxt in successors(L, oriented, walk[-1])]

assert closed_walk_total > 0
assert positive_crossing_walks > 0
assert checked_pairs > 0
print(f"PASS: closed walks {closed_walk_total} "
      f"(crossing walks {positive_crossing_walks}, crossing pairs {checked_pairs}) "
      f"c(gamma) = sum over vertices of c_v(gamma) verified over ZZ")
