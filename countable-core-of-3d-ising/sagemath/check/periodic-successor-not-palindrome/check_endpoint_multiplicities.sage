import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "_prelude.sage"))

# 対象ラベル: claim_periodic_successor_not_palindrome
# 奇数軌道では Omega_E(0) >= 1、Omega_E(#E) = 0 なので回文でない。
for orbit_length in [ZZ(1), ZZ(3), ZZ(5)]:
    points, successors = cycle_system(orbit_length, direction_count=2)
    edges = edges_of(points, successors)
    counts = multiplicities(points, edges)
    assert counts.get(ZZ(0), ZZ(0)) >= ZZ(1)
    assert counts.get(ZZ(len(edges)), ZZ(0)) == ZZ(0)
    assert counts.get(ZZ(0), ZZ(0)) != counts.get(ZZ(len(edges)), ZZ(0))

print("RESULT: PASS")
