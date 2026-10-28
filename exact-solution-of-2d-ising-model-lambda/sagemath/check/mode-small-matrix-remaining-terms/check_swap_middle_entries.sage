# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 0213 の本文における entries の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,0]*A[1,2]*A[2,1]*A[3,3] == d0*(-x*z*varpi**(-1))*(-x*z**(-1)*varsigma)*d3
print('RESULT: PASS swap_middle entries')
