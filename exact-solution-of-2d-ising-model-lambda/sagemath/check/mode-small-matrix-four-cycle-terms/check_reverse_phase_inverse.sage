# 対象ラベル: claim_mode_small_matrix_four_cycle_terms
# 本文の第二式鎖: 逆元と冪の交換。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert x**4*z**(-4) == x**4*(z**4)**(-1)
print('RESULT: PASS reverse phase inverse')
