"""台の辺が相異なる閉歩道を接触点で二本の短い閉歩道へ分けることを厳密検査する。"""

L = 2
MAX_LENGTH = 8

oriented_edges = [(kind, i, j, d)
                  for kind in ("h", "v") for i in range(L) for j in range(L)
                  for d in (0, 1)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def base_edge(edge):
    kind, i, j, _ = edge
    return (kind, i, j)


def endpoints(edge):
    kind, i, j, d = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if d == 0 else (boundary1, boundary0)


def src(edge):
    return endpoints(edge)[0]


def tgt(edge):
    return endpoints(edge)[1]


def is_nonbacktracking_connection(edge, following):
    return src(following) == tgt(edge) and following != reversal(edge)


def successors(edge):
    return [following for following in oriented_edges
            if is_nonbacktracking_connection(edge, following)]


def is_closed_nonbacktracking(walk):
    return (0 < len(walk)
            and all(is_nonbacktracking_connection(walk[r], walk[(r + 1) % len(walk)])
                    for r in range(len(walk))))


closed_walks = []


def extend(walk):
    if 2 <= len(walk) and walk[0] in successors(walk[-1]):
        closed_walks.append(tuple(walk))
    if len(walk) == MAX_LENGTH:
        return
    for following in successors(walk[-1]):
        walk.append(following)
        extend(walk)
        walk.pop()


for start in oriented_edges:
    extend([start])

edge_simple_walks = [walk for walk in closed_walks
                     if len(set(base_edge(edge) for edge in walk)) == len(walk)]

checked_contacts = ZZ(0)
for walk in edge_simple_walks:
    m = len(walk)
    for k in range(m):
        for l in range(k + 1, m):
            if tgt(walk[k]) != tgt(walk[l]):
                continue
            walk_a = walk[k + 1:l + 1]
            walk_b = walk[l + 1:] + walk[:k + 1]
            assert is_closed_nonbacktracking(walk_a)
            assert is_closed_nonbacktracking(walk_b)
            assert 0 < len(walk_a) < m
            assert 0 < len(walk_b) < m
            bases = set(base_edge(edge) for edge in walk)
            bases_a = set(base_edge(edge) for edge in walk_a)
            bases_b = set(base_edge(edge) for edge in walk_b)
            assert bases_a.isdisjoint(bases_b)
            assert bases_a.union(bases_b) == bases
            checked_contacts += 1

assert 0 < len(edge_simple_walks)
assert 0 < checked_contacts

print("PASS: closed walks (L=%d, length <= %d): %d; base-edge-simple: %d; "
      "contact splits checked: %d"
      % (L, MAX_LENGTH, len(closed_walks), len(edge_simple_walks), checked_contacts))
