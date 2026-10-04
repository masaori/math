# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 差の式変形における substitute_return
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
for row in _difference_rows:
    assert row['stages'][6] == row['stages'][7]
print('substitute_return: PASS', len(_difference_rows))
