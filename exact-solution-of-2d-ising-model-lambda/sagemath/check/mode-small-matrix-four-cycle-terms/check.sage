# 対象ラベル: claim_mode_small_matrix_four_cycle_terms
import os
import sys
_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in (
    'forward_entries', 'forward_grouping', 'forward_inverses', 'forward_phase',
    'reverse_entries', 'reverse_grouping', 'reverse_inverses',
    'reverse_phase_inverse', 'reverse_phase',
):
    load(os.path.join(_dir, 'check_' + name + '.sage'))
print('RESULT: PASS four-cycle term checks')
