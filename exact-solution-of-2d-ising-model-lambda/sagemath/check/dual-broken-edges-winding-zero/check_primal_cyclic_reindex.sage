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
    assert len(frozenset(primal_shift)) == L
    assert frozenset(primal_shift) == frozenset(primal)
    assert sum(ZZ(e in broken) for e in primal_shift) == sum(ZZ(e in broken) for e in primal)
    count += 1
print("PASS check_primal_cyclic_reindex: {}".format(count))
