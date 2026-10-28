# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 1023 の本文における entries の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,1]*A[1,0]*A[2,2]*A[3,3] == (-x*z*varsigma)*(-x*z**(-1)*varpi)*d2*d3
print('RESULT: PASS swap_first entries')
