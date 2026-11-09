from itertools import combinations


def connected_by_path(vertices, edges, start, end):
    reached = {start}
    frontier = [start]
    while frontier:
        current = frontier.pop()
        for edge in edges:
            if current in edge:
                neighbor = next(vertex for vertex in edge if vertex != current)
                if neighbor not in reached:
                    reached.add(neighbor)
                    frontier.append(neighbor)
    return end in reached


def is_forest(vertices, edges):
    graph = Graph()
    graph.add_vertices(vertices)
    graph.add_edges(edges)
    return graph.is_forest()


checked = 0
for size in range(1, 5):
    vertices = tuple(range(size))
    possible_edges = tuple(combinations(vertices, 2))
    for graph_mask in range(1 << len(possible_edges)):
        ambient = {possible_edges[index] for index in range(len(possible_edges))
                   if graph_mask & (1 << index)}
        for forest_mask in range(1 << len(possible_edges)):
            forest = {possible_edges[index] for index in range(len(possible_edges))
                      if forest_mask & (1 << index)}
            if not forest <= ambient or not is_forest(vertices, forest):
                continue
            for edge in ambient:
                if connected_by_path(vertices, forest, *edge):
                    continue
                enlarged = forest | {edge}
                assert enlarged <= ambient
                assert is_forest(vertices, enlarged)
                checked += 1

print(f"RESULT: PASS ({checked} cases)")
