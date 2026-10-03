# 対象ラベル: claim_negated_parallel_staircase_turning_zero
import os
import sys

check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
check_files = [
    "check_forward_expand_before.sage",
    "check_forward_reduce_before.sage",
    "check_forward_unit_before.sage",
    "check_forward_expand_boundary.sage",
    "check_forward_reduce_boundary.sage",
    "check_forward_unit_boundary.sage",
    "check_forward_expand_after.sage",
    "check_forward_reduce_after.sage",
    "check_forward_unit_after.sage",
    "check_negated_difference.sage",
    "check_negated_block_first.sage",
    "check_negated_block_last.sage",
    "check_unit_steps.sage",
    "check_coordinate_substitute.sage",
    "check_coordinate_additivity.sage",
    "check_coordinate_negative.sage",
    "check_opposite_substitute.sage",
    "check_opposite_negate.sage",
    "check_opposite_positive.sage",
    "check_endpoints_substitute.sage",
    "check_endpoints_zero.sage",
    "check_endpoints_components.sage",
    "check_projection_closed.sage",
    "check_cyclic_definition.sage",
    "check_cyclic_table.sage",
    "check_one_direction_constant.sage",
    "check_one_direction_zero_terms.sage",
    "check_one_direction_zero_sum.sage",
    "check_two_direction_internal.sage",
    "check_two_direction_closing.sage",
    "check_two_direction_negate.sage",
    "check_two_direction_zero.sage",
    "check_cyclic_zero.sage",
    "check_order_distinction.sage"
]
for check_file in check_files:
    load(os.path.join(check_directory, check_file))
print('RESULT: PASS (all negated-parallel-staircase line checks)')
