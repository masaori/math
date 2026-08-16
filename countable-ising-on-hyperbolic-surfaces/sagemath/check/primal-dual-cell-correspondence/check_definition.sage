# SageMath: 主セルと双対セルの対応データを有限集合上で厳密検算
# 対象ラベル: def_primal_dual_cell_correspondence
# 対象: finite-fourier-duality.ts のブロック finite_fourier_definition_primal_dual_cell_correspondence
# 帰属: 有限集合。浮動小数点、実数、複素数を使用しない

primal_vertices = ("v0", "v1", "v2")
primal_edges = ("e0", "e1", "e2")
primal_faces = ("f_front", "f_back")

dual_vertices = tuple(("dual_vertex", face) for face in primal_faces)
dual_edges = tuple(("dual_edge", edge) for edge in primal_edges)
dual_faces = tuple(("dual_face", vertex) for vertex in primal_vertices)


def d0(face):
    return ("dual_vertex", face)


def d1(edge):
    return ("dual_edge", edge)


def d2(vertex):
    return ("dual_face", vertex)


def is_bijection(domain, codomain, mapping):
    images = tuple(mapping(element) for element in domain)
    return len(set(images)) == len(domain) and set(images) == set(codomain)


assert set(dual_vertices).isdisjoint(set(dual_edges))
assert set(dual_edges).isdisjoint(set(dual_faces))
assert set(dual_faces).isdisjoint(set(dual_vertices))

primal_labels = set(primal_vertices) | set(primal_edges) | set(primal_faces)
assert primal_labels.isdisjoint(set(dual_vertices))
assert primal_labels.isdisjoint(set(dual_edges))
assert primal_labels.isdisjoint(set(dual_faces))

assert is_bijection(primal_faces, dual_vertices, d0)
assert is_bijection(primal_edges, dual_edges, d1)
assert is_bijection(primal_vertices, dual_faces, d2)

assert all(d0(face)[1] == face for face in primal_faces)
assert all(d1(edge)[1] == edge for edge in primal_edges)
assert all(d2(vertex)[1] == vertex for vertex in primal_vertices)

print(
    "RESULT: PASS — primal faces, edges, and vertices map bijectively to "
    "separate dual vertex, edge, and face label sets"
)
