from collections import deque


def corners(cell):
    r, c = cell
    return {(r, c), (r, c + 1), (r + 1, c), (r + 1, c + 1)}


def edges(cell):
    r, c = cell
    return {
        frozenset(((r, c), (r, c + 1))),
        frozenset(((r + 1, c), (r + 1, c + 1))),
        frozenset(((r, c), (r + 1, c))),
        frozenset(((r, c + 1), (r + 1, c + 1))),
    }


for r in range(-4, 5):
    for c in range(-4, 5):
        p = (ZZ(r), ZZ(c))
        for dr, dc in ((0, -1), (0, 1), (-1, 0), (1, 0)):
            q = (p[0] + dr, p[1] + dc)
            vp, vq = corners(p), corners(q)
            ep, eq = edges(p), edges(q)
            shared = ep & eq
            assert len(shared) == 1
            w = next(iter(shared))
            assert w <= vp & vq
            vertices, all_edges = vp | vq, ep | eq
            assert ep <= all_edges and eq <= all_edges
            for start in vertices:
                reached, queue = {start}, deque([start])
                while queue:
                    current = queue.popleft()
                    for edge in all_edges:
                        if current in edge:
                            for neighbor in edge:
                                if neighbor not in reached:
                                    reached.add(neighbor)
                                    queue.append(neighbor)
                assert reached == vertices

print("PASS: 324 adjacent integer-cell pairs, shared edges, all corner pairs")
