from itertools import combinations

checked = 0
for n in range(2, 5):
    vertices = set(range(n))
    edges = tuple(combinations(range(n), 2))
    for tree_edges in combinations(edges, n - 1):
        tree = Graph()
        tree.add_vertices(vertices)
        tree.add_edges(tree_edges)
        if not tree.is_tree():
            continue
        for k in range(1, n + 1):
            for unprocessed_tuple in combinations(range(n), k):
                unprocessed = set(unprocessed_tuple)
                for j in range(len(edges) + 1):
                    for chosen_tuple in combinations(edges, j):
                        chosen = set(chosen_tuple)
                        if any(set(e) <= unprocessed for e in chosen.intersection(tree_edges)):
                            continue
                        for e in tree_edges:
                            if set(e) <= unprocessed:
                                assert e not in chosen
                                checked += 1
assert checked > 0
print(f"PASS: {checked} induced-tree edge cases")
