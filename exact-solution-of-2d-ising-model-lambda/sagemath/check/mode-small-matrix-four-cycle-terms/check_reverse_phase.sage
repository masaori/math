# 対象ラベル: claim_mode_small_matrix_four_cycle_terms
# 本文の第二式鎖: 回転位相の四乗。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert z**4 == -1
assert x**4*(z**4)**(-1) == -x**4
print('RESULT: PASS reverse phase')
