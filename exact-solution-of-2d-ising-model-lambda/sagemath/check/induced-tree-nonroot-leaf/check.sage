from itertools import combinations

checked = 0
for n in range(2, 6):
    edges = tuple(combinations(range(n), 2))
    for selected in combinations(edges, n - 1):
        tree = Graph()
        tree.add_vertices(range(n))
        tree.add_edges(selected)
        if not tree.is_tree():
            continue
        for size in range(2, n + 1):
            for vertices in combinations(range(n), size):
                induced = tree.subgraph(vertices)
                if not induced.is_tree():
                    continue
                for root in vertices:
                    assert any(induced.degree(v) == 1 and v != root for v in vertices)
                    checked += 1

assert checked > 0
print(f"PASS: {checked} induced rooted trees")
