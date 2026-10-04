# 対象ラベル: claim_one_sided_closure_cyclic_sum
# 式ペア: 単位歩を加えて構成した閉点列との全歩・循環和の一致
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'closure_sum_rows' not in globals():
    load(os.path.join(check_directory, '_prelude.sage'))
count = 0
for m, n, b, c, u, v, r, x, A, V, R, X, stages, sums, points, independent in closure_sum_rows:
    assert points == independent
    assert stages[-1] == adjacent_steps(independent)
    assert sums[-1] == cyclic_sum(adjacent_steps(independent))
    count += 1
print("PASS independent_points: {}".format(count))

