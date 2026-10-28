# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 1023 の本文における grouping の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert (-x*z*varsigma)*(-x*z**(-1)*varpi)*d2*d3 == x**2*(z*z**(-1))*varpi*varsigma*d2*d3
print('RESULT: PASS swap_first grouping')
