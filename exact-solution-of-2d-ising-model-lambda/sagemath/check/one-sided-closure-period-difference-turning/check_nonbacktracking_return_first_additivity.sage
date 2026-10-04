# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す return_first_additivity
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['return_first'][1] == row['scalar']['return_first'][2]
print('return_first_additivity: PASS', len(rows))
