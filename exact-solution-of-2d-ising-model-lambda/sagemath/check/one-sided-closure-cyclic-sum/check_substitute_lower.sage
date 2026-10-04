# 対象ラベル: claim_one_sided_closure_cyclic_sum
# 式ペア: J(U,v,R,X_c)_j = J(U,v,R,x)_j
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'closure_sum_rows' not in globals():
    load(os.path.join(check_directory, '_prelude.sage'))
count = 0
for m, n, b, c, u, v, r, x, A, V, R, X, stages, sums, points, independent in closure_sum_rows:
    assert stages[4] == stages[5]
    count += len(stages[0])
print("PASS substitute_lower: {}".format(count))

