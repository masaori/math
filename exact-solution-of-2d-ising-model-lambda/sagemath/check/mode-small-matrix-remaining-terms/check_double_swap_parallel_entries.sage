# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 1032 の本文における entries の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,1]*A[1,0]*A[2,3]*A[3,2] == (-x*z*varsigma)*(-x*z**(-1)*varpi)*(-x*z*varsigma**(-1))*(-x*z**(-1)*varpi**(-1))
print('RESULT: PASS double_swap_parallel entries')
