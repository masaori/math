# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す lower_definition
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert all(values[0] == values[1] for values in row['scalar']['lower'])
print('lower_definition: PASS', len(rows))
