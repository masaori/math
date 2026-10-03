# 対象ラベル: claim_repeated_adjacent_sum_difference
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
check_files = [
    'check_period_definition.sage',
    'check_period_remainder.sage',
    'check_period_fold.sage',
    'check_first_definition.sage',
    'check_first_remainder.sage',
    'check_last_index.sage',
    'check_last_period.sage',
    'check_last_remainder.sage',
    'check_join_prefix.sage',
    'check_join_definition.sage',
    'check_join_period.sage',
    'check_join_index.sage',
    'check_base_expand.sage',
    'check_base_substitute.sage',
    'check_base_fold.sage',
    'check_difference_length.sage',
    'check_difference_join.sage',
    'check_difference_split.sage',
    'check_difference_last.sage',
    'check_difference_first.sage',
    'check_difference_base.sage',
    'check_difference_cancel.sage',
    'check_difference_commute.sage',
    'check_difference_cyclic.sage',
]
for check_file in check_files:
    load(os.path.join(check_directory, check_file))
print('RESULT: PASS (all repeated-adjacent-sum line checks)')
