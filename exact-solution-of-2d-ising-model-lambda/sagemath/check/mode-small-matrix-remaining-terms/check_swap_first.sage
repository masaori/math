# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 1023 の成分積を成分表から厳密に計算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,1]*A[1,0]*A[2,2]*A[3,3] == x**2*varpi*varsigma*d2*d3
print('RESULT: PASS swap_first')
