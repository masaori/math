# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 0213 の本文における grouping の等号を検算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert d0*(-x*z*varpi**(-1))*(-x*z**(-1)*varsigma)*d3 == x**2*(z*z**(-1))*varpi**(-1)*varsigma*d0*d3
print('RESULT: PASS swap_middle grouping')
