# 対象ラベル: claim_one_sided_closure_cyclic_sum
# 式ペア: R_c(s) = r(s mod n)
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'closure_sum_rows' not in globals():
    load(os.path.join(check_directory, '_prelude.sage'))
count = 0
for m, n, b, c, u, v, r, x, A, V, R, X, stages, sums, points, independent in closure_sum_rows:
    for s in range(c*n):
        assert R[s] == r[s % n]
        count += 1
print("PASS return_repetition: {}".format(count))

