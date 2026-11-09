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
        for leaf in range(n):
            if tree.degree(leaf) != 1:
                continue
            for root in range(n):
                if root == leaf:
                    continue
                remaining = set(range(n)) - {leaf}
                induced = tree.subgraph(vertices=remaining)
                assert root in induced
                assert induced.is_tree()
                checked += 1
assert checked > 0
print(f"PASS: {checked} rooted leaf-removal cases")
