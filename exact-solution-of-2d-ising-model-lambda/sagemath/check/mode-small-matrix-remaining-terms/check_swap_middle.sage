# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 0213 の成分積を成分表から厳密に計算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,0]*A[1,2]*A[2,1]*A[3,3] == x**2*varpi**(-1)*varsigma*d0*d3
print('RESULT: PASS swap_middle')
