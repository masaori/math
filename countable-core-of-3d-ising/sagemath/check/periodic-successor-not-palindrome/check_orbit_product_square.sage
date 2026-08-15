import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "_prelude.sage"))

# 対象ラベル: claim_periodic_successor_not_palindrome
# 周期軌道では辺ごとの積の積が頂点値の積の二乗に等しく、値は 1。
for orbit_length in [ZZ(1), ZZ(3), ZZ(5)]:
    points, successors = cycle_system(orbit_length)
    direction = 0
    for configuration in configurations(points):
        edge_product = prod(
            configuration[point] * configuration[successors[direction][point]]
            for point in points
        )
        vertex_product = prod(configuration[point] for point in points)
        assert edge_product == vertex_product * vertex_product
        assert vertex_product * vertex_product == ZZ(1)

print("RESULT: PASS")
