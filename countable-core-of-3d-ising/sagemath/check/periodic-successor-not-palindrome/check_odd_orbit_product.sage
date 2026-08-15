import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "_prelude.sage"))

# 対象ラベル: claim_periodic_successor_not_palindrome
# 奇数軌道の全辺が破れているなら、辺ごとの積の積は (-1)^L = -1。
# 注意: 奇数軌道ではこの前件を満たす配位は存在しない（本文の主張の帰結）。
# 前件を満たす配位だけで assert すると空虚に通ってしまうので、
# (1) 有限積の恒等式 (-1)^L = -1 を ZZ で直接確かめ、
# (2) 前件を満たす配位が本当に 0 個であることを全配位の列挙で確かめる。
for orbit_length in [ZZ(1), ZZ(3), ZZ(5)]:
    assert (-ZZ(1)) ** orbit_length == -ZZ(1)
    points, successors = cycle_system(orbit_length)
    direction = 0
    all_broken_count = ZZ(0)
    for configuration in configurations(points):
        orbit_products = [
            configuration[point] * configuration[successors[direction][point]]
            for point in points
        ]
        if all(value == -1 for value in orbit_products):
            all_broken_count += ZZ(1)
            assert prod(orbit_products) == -ZZ(1)
    assert all_broken_count == ZZ(0)

print("RESULT: PASS")
