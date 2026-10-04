# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す return_lower_sign
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['joins'][2][0] < 0 and 0 <= row['scalar']['joins'][2][1]
print('return_lower_sign: PASS', len(rows))
