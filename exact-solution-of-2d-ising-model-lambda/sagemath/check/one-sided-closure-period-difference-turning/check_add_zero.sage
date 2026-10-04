# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 差の式変形における add_zero
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
for row in _difference_rows:
    assert row['stages'][7] == row['stages'][8]
print('add_zero: PASS', len(_difference_rows))
