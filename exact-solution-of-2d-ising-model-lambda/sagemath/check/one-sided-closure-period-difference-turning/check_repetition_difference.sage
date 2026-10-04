# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 差の式変形における repetition_difference
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
for row in _difference_rows:
    assert row['stages'][4] == row['stages'][5]
print('repetition_difference: PASS', len(_difference_rows))
