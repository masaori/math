from itertools import combinations


def subsets(items):
    for size in range(len(items) + 1):
        yield from combinations(items, size)


def even_at(edges, vertex):
    return sum(vertex in edge for edge in edges) % 2 == 0


checked = 0
for n in range(2, 5):
    vertices = set(range(n))
    possible = tuple(combinations(range(n), 2))
    for graph_tuple in subsets(possible):
        graph_edges = set(graph_tuple)
        graph = Graph()
        graph.add_vertices(vertices)
        graph.add_edges(graph_edges)
        if not graph.is_connected():
            continue
        for tree_tuple in combinations(graph_tuple, n - 1):
            tree_edges = set(tree_tuple)
            tree = Graph()
            tree.add_vertices(vertices)
            tree.add_edges(tree_edges)
            if not tree.is_tree():
                continue
            for unprocessed_tuple in subsets(tuple(vertices)):
                unprocessed = set(unprocessed_tuple)
                if len(unprocessed) < 2:
                    continue
                induced = tree.subgraph(vertices=unprocessed)
                if not induced.is_tree():
                    continue
                for root in unprocessed:
                    leaves = [v for v in unprocessed - {root} if induced.degree(v) == 1]
                    assert leaves
                    for chosen_tuple in subsets(graph_tuple):
                        chosen = set(chosen_tuple)
                        if any(edge in tree_edges and set(edge) <= unprocessed for edge in chosen):
                            continue
                        if any(not even_at(chosen, w) for w in vertices - unprocessed):
                            continue
                        leaf = leaves[0]
                        parent = induced.neighbors(leaf)[0]
                        edge = tuple(sorted((leaf, parent)))
                        assert edge in tree_edges and edge in graph_edges
                        assert edge not in chosen
                        next_unprocessed = unprocessed - {leaf}
                        candidates = (chosen, chosen.symmetric_difference({edge}))
                        next_chosen = next((candidate for candidate in candidates
                                            if even_at(candidate, leaf)), None)
                        assert next_chosen is not None
                        assert next_chosen <= graph_edges
                        assert all(even_at(next_chosen, w)
                                   for w in vertices - next_unprocessed)
                        assert all(not set(e) <= next_unprocessed
                                   for e in next_chosen.intersection(tree_edges))
                        assert next_chosen - tree_edges == chosen - tree_edges
                        checked += 1

assert checked > 0
print(f"PASS: {checked} induced-tree leaf steps")
