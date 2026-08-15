import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "_prelude.sage"))

# 対象ラベル: claim_periodic_successor_not_palindrome
# 定数配位 sigma^+ について b(sigma^+) = 0、したがって Omega_E(0) >= 1。
for orbit_length in [ZZ(1), ZZ(3), ZZ(5)]:
    points, successors = cycle_system(orbit_length, direction_count=2)
    edges = edges_of(points, successors)
    constant = {point: ZZ(1) for point in points}
    assert ZZ(len(broken_edges(constant, edges))) == ZZ(0)
    assert multiplicities(points, edges).get(ZZ(0), ZZ(0)) >= ZZ(1)

print("RESULT: PASS")
