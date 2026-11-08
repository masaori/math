from itertools import combinations


def edges_of_vertices(vertices):
    return list(combinations(vertices, 2))


def all_simple_paths(vertices, selected):
    neighbors = {v: set() for v in vertices}
    for u, v in selected:
        neighbors[u].add(v)
        neighbors[v].add(u)
    paths = []
    for start in vertices:
        stack = [(start,)]
        while stack:
            path = stack.pop()
            if len(path) > 1:
                paths.append(path)
            for next_vertex in neighbors[path[-1]] - set(path):
                stack.append(path + (next_vertex,))
    return paths


checked = 0
for size in range(2, 6):
    vertices = tuple(range(size))
    possible_edges = edges_of_vertices(vertices)
    for tree_edges in combinations(possible_edges, size - 1):
        tree = Graph()
        tree.add_vertices(vertices)
        tree.add_edges(tree_edges)
        if not tree.is_tree():
            continue
        for subset_size in range(1, size):
            for selected_tuple in combinations(tree_edges, subset_size):
                selected = set(selected_tuple)
                paths = all_simple_paths(vertices, selected)
                assert paths
                longest = max(paths, key=len)
                start, next_vertex = longest[:2]
                incident = {edge for edge in selected if start in edge}
                incident_neighbors = {
                    edge[0] if edge[1] == start else edge[1]
                    for edge in incident
                }
                assert incident_neighbors <= set(longest)
                assert incident_neighbors <= {next_vertex}
                assert incident == {tuple(sorted((start, next_vertex)))}
                checked += 1

print("PASS: %s nonempty edge subsets of trees" % checked)
