# 対象ラベル: claim_mode_small_matrix_remaining_terms
# 0123 の成分積を成分表から厳密に計算する。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert A[0,0]*A[1,1]*A[2,2]*A[3,3] == d0*d1*d2*d3
print('RESULT: PASS identity')
