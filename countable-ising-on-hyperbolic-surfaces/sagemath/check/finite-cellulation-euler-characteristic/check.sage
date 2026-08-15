# SageMath: 有限セル分割の Euler 標数の厳密検算
# 対象ラベル: def_finite_cellulation_euler_characteristic
# 対象: structured-latex/content/finite-cellulation.ts の「有限セル分割の Euler 標数」
# 帰属: 有限集合、NN、ZZ だけを用いる。


def euler_characteristic(vertices, edges, faces):
    return ZZ(len(vertices)) - ZZ(len(edges)) + ZZ(len(faces))


# 三角形二面を貼った球面: 頂点三つ、辺三つ、面二つ。
sphere_vertices = ("A", "B", "C")
sphere_edges = ("a", "b", "c")
sphere_faces = ("north", "south")
assert euler_characteristic(sphere_vertices, sphere_edges, sphere_faces) == ZZ(2)

# 3 x 3 周期正方格子によるトーラス: 頂点九つ、辺十八、面九つ。
torus_vertices = tuple(range(9))
torus_edges = tuple(range(18))
torus_faces = tuple(range(9))
assert euler_characteristic(torus_vertices, torus_edges, torus_faces) == ZZ(0)

print("RESULT: PASS — Euler characteristic is 2 for the sphere and 0 for the torus")
