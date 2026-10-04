# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す shift_definition
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['shift'][0] == row['scalar']['shift'][1]
print('shift_definition: PASS', len(rows))
