from collections import deque

for r in range(-4, 5):
    for c in range(-4, 5):
        r, c = ZZ(r), ZZ(c)
        a, b = (r, c), (r, c + 1)
        p, d = (r + 1, c), (r + 1, c + 1)
        vertices = {a, b, p, d}
        edges = {frozenset((a, b)), frozenset((a, p)),
                 frozenset((b, d)), frozenset((p, d))}
        assert len(vertices) == 4
        assert len(edges) == 4
        assert all(edge in edges for edge in
                   (frozenset((a, b)), frozenset((a, p)), frozenset((b, d))))
        for start in vertices:
            reached = {start}
            queue = deque([start])
            while queue:
                current = queue.popleft()
                for edge in edges:
                    if current in edge:
                        for neighbor in edge:
                            if neighbor not in reached:
                                reached.add(neighbor)
                                queue.append(neighbor)
            assert reached == vertices

print("PASS: 81 integer cells, three displayed edges, all corner pairs")
