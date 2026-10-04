# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 戻り周期の回転数は零
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
for row in _difference_rows:
    assert row['return_turn'] == ZZ(0)
print('return_zero: PASS', len(_difference_rows))
