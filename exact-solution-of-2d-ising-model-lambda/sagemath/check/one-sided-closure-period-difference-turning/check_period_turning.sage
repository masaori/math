# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 一周期の和を元の回転数へ同定
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
for row in _difference_rows:
    assert row['period_sum'] == row['original']
print('period_turning: PASS', len(_difference_rows))
