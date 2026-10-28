# 対象ラベル: claim_mode_small_matrix_remaining_terms
import os
import sys
_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('identity', 'swap_last', 'swap_middle', 'swap_first', 'double_swap_parallel', 'swap_ends', 'double_swap_crossed'):
    for suffix in ('entries', 'grouping', ''):
        load(os.path.join(_dir, 'check_' + name + ('_' + suffix if suffix else '') + '.sage'))
print('RESULT: PASS remaining terms')
