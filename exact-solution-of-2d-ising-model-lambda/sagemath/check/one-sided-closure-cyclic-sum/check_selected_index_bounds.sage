# 対象ラベル: claim_one_sided_closure_cyclic_sum
# 式ペア: 四区間が選ぶ局所添字の範囲
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
if 'closure_sum_rows' not in globals():
    load(os.path.join(check_directory, '_prelude.sage'))
count = 0
for m, n, b, c, u, v, r, x, A, V, R, X, stages, sums, points, independent in closure_sum_rows:
    for j in range(c*m+b+c*n+b):
        if j < c*m:
            assert 0 <= j < c*m
        elif j < c*m+b:
            assert 0 <= j-c*m < b
        elif j < c*m+b+c*n:
            assert 0 <= j-c*m-b < c*n
        else:
            assert 0 <= j-c*m-b-c*n < b
        count += 1
print("PASS selected_index_bounds: {}".format(count))

