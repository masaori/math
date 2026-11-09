from itertools import combinations


def subsets(items):
    for size in range(len(items) + 1):
        for selected in combinations(items, size):
            yield frozenset(selected)


def even_at_every_vertex(vertices, selected):
    return all(sum(v in edge for edge in selected) % 2 == 0 for v in vertices)


checked = 0
for size in range(1, 5):
    vertices = tuple(range(size))
    possible_edges = list(combinations(vertices, 2))
    for edges in subsets(possible_edges):
        graph = Graph()
        graph.add_vertices(vertices)
        graph.add_edges(edges)
        if not graph.is_connected():
            continue
        even_sets = [part for part in subsets(sorted(edges)) if even_at_every_vertex(vertices, part)]
        for tree_edges in combinations(sorted(edges), size - 1):
            tree = Graph()
            tree.add_vertices(vertices)
            tree.add_edges(tree_edges)
            if not tree.is_tree():
                continue
            outside = edges - frozenset(tree_edges)
            for left in even_sets:
                for right in even_sets:
                    difference = left.symmetric_difference(right)
                    assert even_at_every_vertex(vertices, difference)
                    if left & outside == right & outside:
                        assert difference <= frozenset(tree_edges)
                        assert not difference or any(
                            sum(v in edge for edge in difference) == 1 for v in vertices
                        )
                        assert not difference
                        assert left == right
                    checked += 1

print("PASS: %s ordered pairs of even edge subsets" % checked)
