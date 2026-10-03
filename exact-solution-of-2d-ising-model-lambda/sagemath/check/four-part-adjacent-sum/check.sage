# 対象ラベル: claim_four_part_adjacent_sum
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
check_files = [
    'check_interval_split.sage',
    'check_prefix_last_term.sage',
    'check_prefix_substitution.sage',
    'check_prefix_internal.sage',
    'check_boundary_substitution.sage',
    'check_tail_substitution.sage',
    'check_tail_internal.sage',
    'check_binary_expand.sage',
    'check_binary_partition.sage',
    'check_binary_prefix.sage',
    'check_binary_boundary.sage',
    'check_binary_tail.sage',
    'check_uv_last.sage',
    'check_uvw_last.sage',
    'check_z_last.sage',
    'check_z_first.sage',
    'check_uvw_first.sage',
    'check_uv_first.sage',
    'check_four_outer.sage',
    'check_four_middle.sage',
    'check_four_inner.sage',
    'check_four_uv_last.sage',
    'check_four_uvw_last.sage',
    'check_four_associate.sage',
    'check_cyclic_expand.sage',
    'check_cyclic_internal.sage',
    'check_cyclic_last.sage',
    'check_cyclic_first.sage',
]
for check_file in check_files:
    load(os.path.join(check_directory, check_file))
print('RESULT: PASS (all four-part-adjacent-sum line checks)')
