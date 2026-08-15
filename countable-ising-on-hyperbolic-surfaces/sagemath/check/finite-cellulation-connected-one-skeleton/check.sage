# SageMath: 一次骨格の連結性を判定する有限述語の正例・負例
# 対象ラベル: def_finite_cellulation_connected_one_skeleton
# 対象: structured-latex/content/finite-cellulation.ts の「一次骨格の連結性を判定する有限述語」
# 帰属: 有限集合、NN、真偽値だけを用いる。


def connected_one_skeleton(vertices, edges, endpoints):
    reached = {vertices[0]}
    frontier = [vertices[0]]
    while frontier:
        current = frontier.pop()
        for edge in edges:
            endpoint_zero, endpoint_one = endpoints[edge]
            if endpoint_zero == current and endpoint_one not in reached:
                reached.add(endpoint_one)
                frontier.append(endpoint_one)
            if endpoint_one == current and endpoint_zero not in reached:
                reached.add(endpoint_zero)
                frontier.append(endpoint_zero)
    return reached == set(vertices)


# 三角形二面を貼った球面の一次骨格は三角形であり、連結である。
sphere_vertices = ("A", "B", "C")
sphere_edges = ("a", "b", "c")
sphere_endpoints = {
    "a": ("A", "B"),
    "b": ("B", "C"),
    "c": ("C", "A"),
}
assert connected_one_skeleton(sphere_vertices, sphere_edges, sphere_endpoints)

# 互いに頂点を共有しない二つの三角形の一次骨格は連結でない。
disconnected_vertices = ("A", "B", "C", "D", "E", "F")
disconnected_edges = ("a", "b", "c", "d", "e", "f")
disconnected_endpoints = {
    "a": ("A", "B"),
    "b": ("B", "C"),
    "c": ("C", "A"),
    "d": ("D", "E"),
    "e": ("E", "F"),
    "f": ("F", "D"),
}
assert not connected_one_skeleton(
    disconnected_vertices,
    disconnected_edges,
    disconnected_endpoints,
)

print("RESULT: PASS — accepted a connected sphere skeleton and rejected two disjoint triangle skeletons")
