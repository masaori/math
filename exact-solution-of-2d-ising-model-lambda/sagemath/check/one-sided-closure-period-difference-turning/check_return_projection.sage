# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 戻り周期の和を射影回転数へ同定
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
for row in _difference_rows:
    assert row['return_sum'] == row['return_turn']
print('return_projection: PASS', len(_difference_rows))
