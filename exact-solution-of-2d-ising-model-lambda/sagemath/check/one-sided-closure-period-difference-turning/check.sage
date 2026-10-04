# 対象ラベル: claim_one_sided_closure_period_difference_turning
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
for filename in ('check_period_turning.sage', 'check_return_projection.sage', 'check_return_zero.sage', 'check_projection_next.sage', 'check_projection_current.sage', 'check_fixed_next.sage', 'check_fixed_current.sage', 'check_repetition_difference.sage', 'check_substitute_period.sage', 'check_substitute_return.sage', 'check_add_zero.sage'):
    load(str(_difference_dir / filename))
nonzero = sum(row['original'] != 0 for row in _difference_rows)
assert nonzero > 0
assert {row['t'] for row in _difference_rows} == {1, 2}
assert {row['c'] for row in _difference_rows} == {1, 2, 3}
assert any(row['k'] < 0 for row in _difference_rows)
print('nonzero turning cases:', nonzero)

for filename in ('check_nonbacktracking_period_end_periodicity.sage', 'check_nonbacktracking_period_end_maximum.sage', 'check_nonbacktracking_lift_last_definition.sage', 'check_nonbacktracking_lift_last_additivity.sage', 'check_nonbacktracking_lift_last_maximum.sage', 'check_nonbacktracking_lift_first_definition.sage', 'check_nonbacktracking_lift_first_additivity.sage', 'check_nonbacktracking_lift_first_maximum.sage', 'check_nonbacktracking_return_first_definition.sage', 'check_nonbacktracking_return_first_additivity.sage', 'check_nonbacktracking_return_first_endpoint.sage', 'check_nonbacktracking_return_last_definition.sage', 'check_nonbacktracking_return_last_additivity.sage', 'check_nonbacktracking_return_last_endpoint.sage', 'check_nonbacktracking_shift_definition.sage', 'check_nonbacktracking_shift_cancel.sage', 'check_nonbacktracking_lift_last_sign.sage', 'check_nonbacktracking_lift_first_sign.sage', 'check_nonbacktracking_return_first_sign.sage', 'check_nonbacktracking_return_last_sign.sage', 'check_nonbacktracking_upper_positive.sage', 'check_nonbacktracking_lower_definition.sage', 'check_nonbacktracking_lower_additivity.sage', 'check_nonbacktracking_lower_negative.sage', 'check_nonbacktracking_parallel_endpoints.sage', 'check_nonbacktracking_lift_upper_sign.sage', 'check_nonbacktracking_upper_return_sign.sage', 'check_nonbacktracking_return_lower_sign.sage', 'check_nonbacktracking_lower_lift_sign.sage', 'check_nonbacktracking_parts_nonbacktracking.sage', 'check_nonbacktracking_projection_nonbacktracking.sage'):
    load(str(_difference_dir / filename))
print('nonbacktracking nonzero turning cases:', sum(row['at_maximum'] and row['original'] != 0 for row in _difference_rows))
print('RESULT: PASS')
