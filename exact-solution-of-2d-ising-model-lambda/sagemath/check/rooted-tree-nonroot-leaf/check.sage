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
        longest = max(
            (path for a in range(n) for b in range(n) if a != b
             for path in tree.all_paths(a, b)),
            key=len,
        )
        assert len(longest) >= 2
        assert tree.degree(longest[0]) == 1
        assert tree.degree(longest[-1]) == 1
        for root in range(n):
            assert any(tree.degree(v) == 1 and v != root for v in range(n))
            checked += 1

assert checked > 0
print(f"PASS: {checked} rooted trees")
