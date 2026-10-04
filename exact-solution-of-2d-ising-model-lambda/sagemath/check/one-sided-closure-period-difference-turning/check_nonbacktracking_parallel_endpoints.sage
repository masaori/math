# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す parallel_endpoints
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['ends'] == (0, 0)
print('parallel_endpoints: PASS', len(rows))
