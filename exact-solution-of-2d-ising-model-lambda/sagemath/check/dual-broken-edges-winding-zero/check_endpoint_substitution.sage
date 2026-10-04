# 対象ラベル: claim_dual_broken_edges_winding_zero
# 帰属: 有限集合と自然数。全て厳密な等号で比較する。
import os
import sys
winding_entry = sys.argv[0] if sys.argv[0].endswith('.sage') else __file__
winding_directory = os.path.dirname(os.path.abspath(winding_entry))
if 'winding_lattice_rows' not in globals():
    load(os.path.join(winding_directory, 'lattice_construction.sage'))
count = 0
for L, sigma, broken, dual_broken, boundary, inverse, primal_shift, primal, points, next_points in winding_lattice_rows:
    for e, point, next_point in zip(primal, points, next_points):
        assert endpoints(L, e) == (point, next_point)
        count += 1
    assert sum((ZZ(sigma[endpoints(L, e)[0]] == -1) + ZZ(sigma[endpoints(L, e)[1]] == -1)) % 2 for e in primal) % 2 == sum((ZZ(sigma[point] == -1) + ZZ(sigma[next_point] == -1)) % 2 for point, next_point in zip(points, next_points)) % 2
print("PASS check_endpoint_substitution: {}".format(count))
