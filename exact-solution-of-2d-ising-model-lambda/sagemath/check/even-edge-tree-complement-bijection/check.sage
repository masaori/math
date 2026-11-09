from itertools import combinations


def subsets(items):
    items = tuple(items)
    for size in range(len(items) + 1):
        for chosen in combinations(items, size):
            yield frozenset(chosen)


checked = 0
for size in range(1, 5):
    vertices = tuple(range(size))
    all_edges = tuple(combinations(vertices, 2))
    for edges in subsets(all_edges):
        graph = Graph()
        graph.add_vertices(vertices)
        graph.add_edges(edges)
        if not graph.is_connected():
            continue
        even_sets = [selected for selected in subsets(edges)
                     if all(sum(v in edge for edge in selected) % 2 == 0
                            for v in vertices)]
        for tree_edges in subsets(edges):
            tree = Graph()
            tree.add_vertices(vertices)
            tree.add_edges(tree_edges)
            if not tree.is_tree():
                continue
            outside = edges - tree_edges
            images = [selected & outside for selected in even_sets]
            assert len(images) == len(set(images))
            assert set(images) == set(subsets(outside))
            checked += 1

print("PASS: %s connected graph and spanning tree pairs" % checked)
