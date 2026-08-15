import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "_prelude.sage"))

# 対象ラベル: claim_periodic_successor_not_palindrome
# 奇数軌道の全辺が破れているなら、辺ごとの積の積は (-1)^L = -1。
for orbit_length in [ZZ(1), ZZ(3), ZZ(5)]:
    points, successors = cycle_system(orbit_length)
    direction = 0
    for configuration in configurations(points):
        orbit_products = [
            configuration[point] * configuration[successors[direction][point]]
            for point in points
        ]
        if all(value == -1 for value in orbit_products):
            assert prod(orbit_products) == (-ZZ(1)) ** orbit_length == -ZZ(1)

print("RESULT: PASS")
