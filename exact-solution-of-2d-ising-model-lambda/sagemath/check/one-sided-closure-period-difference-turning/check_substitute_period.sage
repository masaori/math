# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 差の式変形における substitute_period
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
for row in _difference_rows:
    assert row['stages'][5] == row['stages'][6]
print('substitute_period: PASS', len(_difference_rows))
