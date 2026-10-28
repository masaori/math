# 対象ラベル: claim_mode_small_matrix_signed_sum_algebra
import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(directory, 'check_expand.sage'))
load(os.path.join(directory, 'check_factor.sage'))
print('RESULT: PASS signed sum algebra')
