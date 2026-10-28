# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 3120 の本文における grouping の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert (-x*z**(-1)*varsigma**(-1))*d1*d2*(-x*z*varpi) == x**2*(z**(-1)*z)*varpi*varsigma**(-1)*d1*d2
print('RESULT: PASS swap_ends grouping')
