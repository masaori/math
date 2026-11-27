# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す (ch-1) mod h = ((c-1)h+(h-1)) mod h = (h-1) mod h = h-1
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['junction_index']
print('junction_index: PASS', len(rows))
