# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 3210 の本文における entries の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,3]*A[1,2]*A[2,1]*A[3,0] == (-x*z**(-1)*varsigma**(-1))*(-x*z*varpi**(-1))*(-x*z**(-1)*varsigma)*(-x*z*varpi)
print('RESULT: PASS double_swap_crossed entries')
