# 対象ラベル: claim_reversed_parallel_staircase_turning_zero
import os
import sys

# Sage 10.9 のファイル実行では __file__ が対象を指さないため、CLI の元の引数を使う。
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
check_files = [
    'check_forward_point_agreement.sage',
    'check_forward_expand_before.sage',
    'check_forward_expand_boundary.sage',
    'check_forward_expand_after.sage',
    'check_forward_reduce_before.sage',
    'check_forward_reduce_boundary.sage',
    'check_forward_reduce_after.sage',
    'check_forward_unit_before.sage',
    'check_forward_unit_boundary.sage',
    'check_forward_unit_after.sage',
    'check_reversed_difference_negate.sage',
    'check_reversed_difference_forward_before.sage',
    'check_reversed_difference_forward_after.sage',
    'check_reversed_difference_blocks_first.sage',
    'check_reversed_difference_blocks_last.sage',
    'check_step_positive_first.sage',
    'check_step_positive_second.sage',
    'check_step_nonpositive_first.sage',
    'check_step_nonpositive_second.sage',
    'check_parallel_coordinate_difference.sage',
    'check_parallel_coordinate_negative.sage',
    'check_opposite_coordinate_substitution.sage',
    'check_opposite_coordinate_negation.sage',
    'check_opposite_coordinate_positive.sage',
    'check_turn_case_straight.sage',
    'check_turn_case_positive.sage',
    'check_turn_case_negative.sage',
    'check_turn_table.sage',
    'check_cyclic_decomposition.sage',
    'check_same_direction_expansion.sage',
    'check_same_direction_reduction.sage',
    'check_one_direction_constant.sage',
    'check_one_direction_zero_terms.sage',
    'check_one_direction_zero_sum.sage',
    'check_two_direction_internal.sage',
    'check_two_direction_closing.sage',
    'check_swapped_expansion.sage',
    'check_swapped_commutation.sage',
    'check_swapped_negation.sage',
    'check_swapped_fold.sage',
    'check_two_direction_total_junctions.sage',
    'check_two_direction_total_subtract.sage',
    'check_two_direction_total_zero.sage',
    'check_cyclic_zero.sage',
]
for check_file in check_files:
    load(os.path.join(check_directory, check_file))
print('RESULT: PASS (all reversed-parallel-staircase line checks)')
