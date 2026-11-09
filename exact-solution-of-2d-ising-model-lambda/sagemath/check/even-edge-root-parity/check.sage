from itertools import combinations


def subsets(items):
    for size in range(len(items) + 1):
        for selected in combinations(items, size):
            yield selected


checked = 0
for size in range(1, 6):
    vertices = tuple(range(size))
    possible_edges = tuple(combinations(vertices, 2))
    for selected in subsets(possible_edges):
        degrees = {v: sum(v in edge for edge in selected) for v in vertices}
        assert sum(degrees.values()) == 2 * len(selected)
        for root in vertices:
            if all(degrees[v] % 2 == 0 for v in vertices if v != root):
                assert degrees[root] % 2 == 0
            checked += 1

print("PASS: %s choices of an edge subset and root" % checked)
