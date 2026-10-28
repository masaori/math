# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 3120 の成分積を成分表から厳密に計算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,3]*A[1,1]*A[2,2]*A[3,0] == x**2*varpi*varsigma**(-1)*d1*d2
print('RESULT: PASS swap_ends')
