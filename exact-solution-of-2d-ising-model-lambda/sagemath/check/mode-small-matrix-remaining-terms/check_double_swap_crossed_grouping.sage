# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 3210 の本文における grouping の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert (-x*z**(-1)*varsigma**(-1))*(-x*z*varpi**(-1))*(-x*z**(-1)*varsigma)*(-x*z*varpi) == x**4*(z**(-1)*z)**2*(varpi**(-1)*varpi)*(varsigma**(-1)*varsigma)
print('RESULT: PASS double_swap_crossed grouping')
