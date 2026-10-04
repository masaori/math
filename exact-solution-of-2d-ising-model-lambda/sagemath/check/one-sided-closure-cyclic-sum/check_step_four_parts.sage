# 対象ラベル: claim_one_sided_closure_cyclic_sum
# 式ペア: w_j = J(A_c,V_c,R_c,X_c)_j
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'closure_sum_rows' not in globals():
    load(os.path.join(check_directory, '_prelude.sage'))
count = 0
for m, n, b, c, u, v, r, x, A, V, R, X, stages, sums, points, independent in closure_sum_rows:
    assert stages[0] == stages[1]
    count += len(stages[0])
print("PASS step_four_parts: {}".format(count))

