# SageMath: 一次骨格の連結性を判定する有限述語の正例・負例
# 対象ラベル: def_finite_cellulation_connected_one_skeleton
# 対象: structured-latex/content/finite-cellulation.ts の「一次骨格の連結性を判定する有限述語」
# 帰属: 端点ラベルの有限集合、頂点・辺の有限集合、真偽値だけを用いる。

SOURCE = "source"
TARGET = "target"
END_LABELS = (SOURCE, TARGET)


def connected_one_skeleton(vertices, edges, endpoints):
    initial_vertex = next(iter(vertices))
    reached = {initial_vertex}
    frontier = [initial_vertex]
    while frontier:
        current = frontier.pop()
        for edge in edges:
            source_vertex = endpoints[edge][SOURCE]
            target_vertex = endpoints[edge][TARGET]
            if source_vertex == current and target_vertex not in reached:
                reached.add(target_vertex)
                frontier.append(target_vertex)
            if target_vertex == current and source_vertex not in reached:
                reached.add(source_vertex)
                frontier.append(source_vertex)
    return reached == set(vertices)


# 三角形二面を貼った球面の一次骨格は三角形であり、連結である。
sphere_vertices = ("A", "B", "C")
sphere_edges = ("a", "b", "c")
sphere_endpoints = {
    "a": {SOURCE: "A", TARGET: "B"},
    "b": {SOURCE: "B", TARGET: "C"},
    "c": {SOURCE: "C", TARGET: "A"},
}
assert connected_one_skeleton(sphere_vertices, sphere_edges, sphere_endpoints)

# 互いに頂点を共有しない二つの三角形の一次骨格は連結でない。
disconnected_vertices = ("A", "B", "C", "D", "E", "F")
disconnected_edges = ("a", "b", "c", "d", "e", "f")
disconnected_endpoints = {
    "a": {SOURCE: "A", TARGET: "B"},
    "b": {SOURCE: "B", TARGET: "C"},
    "c": {SOURCE: "C", TARGET: "A"},
    "d": {SOURCE: "D", TARGET: "E"},
    "e": {SOURCE: "E", TARGET: "F"},
    "f": {SOURCE: "F", TARGET: "D"},
}
assert not connected_one_skeleton(
    disconnected_vertices,
    disconnected_edges,
    disconnected_endpoints,
)

print("RESULT: PASS — accepted a connected sphere skeleton and rejected two disjoint triangle skeletons")
