from itertools import combinations

checked = 0
for n in range(2, 6):
    vertices = set(range(n))
    edges = tuple(combinations(range(n), 2))
    for selected in combinations(edges, n - 1):
        tree = Graph()
        tree.add_vertices(vertices)
        tree.add_edges(selected)
        if not tree.is_tree():
            continue
        for size in range(2, n + 1):
            for subset in combinations(vertices, size):
                U = set(subset)
                induced = tree.subgraph(vertices=U)
                if not induced.is_tree():
                    continue
                for leaf in U:
                    if induced.degree(leaf) != 1:
                        continue
                    for root in U - {leaf}:
                        remaining = U - {leaf}
                        residual = tree.subgraph(vertices=remaining)
                        assert root in residual
                        assert residual.is_tree()
                        expected = {frozenset(e) for e in selected
                                    if set(e) <= remaining}
                        actual = {frozenset(e) for e in residual.edges(labels=False)}
                        assert actual == expected
                        checked += 1
assert checked > 0
print(f"PASS: {checked} induced-tree leaf removals")
