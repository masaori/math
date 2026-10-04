# 対象ラベル: claim_one_sided_closure_cyclic_sum
# 式ペア: I(w) + vartheta(w_last,w_first) = I(z) + vartheta(w_last,w_first)
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'closure_sum_rows' not in globals():
    load(os.path.join(check_directory, '_prelude.sage'))
count = 0
for m, n, b, c, u, v, r, x, A, V, R, X, stages, sums, points, independent in closure_sum_rows:
    assert sums[1] == sums[2]
    count += 1
print("PASS internal_substitution: {}".format(count))

