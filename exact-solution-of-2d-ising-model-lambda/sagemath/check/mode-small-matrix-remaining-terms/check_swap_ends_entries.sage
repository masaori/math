# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 3120 の本文における entries の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,3]*A[1,1]*A[2,2]*A[3,0] == (-x*z**(-1)*varsigma**(-1))*d1*d2*(-x*z*varpi)
print('RESULT: PASS swap_ends entries')
