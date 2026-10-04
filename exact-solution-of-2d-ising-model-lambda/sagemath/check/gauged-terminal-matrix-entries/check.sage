# 対象ラベル: claim_gauged_terminal_matrix_entries
import os
_gt_check_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_gt_check_dir, '_prelude.sage'))
components = overlaps = 0
for case in _gt_cases:
    assert case['transformed'] == case['expected']
    assert all(p.degree() <= 1 for p in case['transformed'].list())
    components += case['n'] ** 2
    if case['L'] == 1:
        for i, j in enumerate(case['rev']):
            assert case['long'][i, j] == 1
            assert case['short'][i, j] != 0
            overlaps += 1
assert overlaps == 64
print('PASS independent_matrix_comparison: %s matrices, %s entries, %s overlapping cases'
      % (len(_gt_cases), components, overlaps))
check_files = ['check_left_zero_mapped_entry.sage', 'check_left_zero_diagonal_zero.sage', 'check_left_zero_embedded_zero.sage', 'check_left_zero_absorb_zero.sage', 'check_left_entry_finite_sum.sage', 'check_left_entry_select_row.sage', 'check_left_entry_embedded_diagonal.sage', 'check_left_entry_diagonal_weight.sage', 'check_right_zero_mapped_entry.sage', 'check_right_zero_diagonal_zero.sage', 'check_right_zero_embedded_zero.sage', 'check_right_zero_absorb_zero.sage', 'check_right_entry_finite_sum.sage', 'check_right_entry_select_column.sage', 'check_right_entry_embedded_diagonal.sage', 'check_right_entry_diagonal_weight.sage', 'check_main_definition.sage', 'check_main_right_entry.sage', 'check_main_left_entry.sage', 'check_main_associate_inside.sage', 'check_main_commute_right.sage', 'check_main_associate_middle.sage', 'check_main_associate_outer.sage', 'check_main_embed_pair.sage', 'check_main_embed_scalar.sage', 'check_main_weight_definition.sage', 'check_main_terminal_entry.sage']
for file in check_files:
    load(os.path.join(_gt_check_dir, file))
print('RESULT: PASS (%s row files)' % len(check_files))
