# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す period_end_maximum
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['period_end'][1] == row['scalar']['period_end'][2]
print('period_end_maximum: PASS', len(rows))
