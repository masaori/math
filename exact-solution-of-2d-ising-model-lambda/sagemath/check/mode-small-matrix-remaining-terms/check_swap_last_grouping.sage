# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 0132 の本文における grouping の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert d0*d1*(-x*z*varsigma**(-1))*(-x*z**(-1)*varpi**(-1)) == x**2*(z*z**(-1))*varpi**(-1)*varsigma**(-1)*d0*d1
print('RESULT: PASS swap_last grouping')
