from itertools import combinations

checked = 0
for n in range(1, 5):
    vertices = list(range(n))
    possible_edges = list(combinations(vertices, 2))
    for mask in range(1 << len(possible_edges)):
        edges = {edge for i, edge in enumerate(possible_edges) if mask & (1 << i)}
        original = Graph([vertices, list(edges)])
        if not original.is_connected():
            continue
        selected = set()
        for u in vertices:
            for v in vertices:
                if (min(u, v), max(u, v)) not in edges:
                    continue
                forest = Graph([vertices, list(selected)])
                if forest.shortest_path(u, v) == []:
                    selected.add((min(u, v), max(u, v)))
        tree = Graph([vertices, list(selected)])
        assert selected <= edges
        assert tree.is_tree()
        assert tree.vertices(sort=True) == original.vertices(sort=True)
        checked += 1

print(f"PASS: {checked} connected graphs")
