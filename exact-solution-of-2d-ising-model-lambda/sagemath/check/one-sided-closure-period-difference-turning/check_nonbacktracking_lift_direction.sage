# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す dir(f) ≠ dir(ι(e)) = dir(e)+2（後続辺の始点と反転の方向）
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['lift_direction']
print('lift_direction: PASS', len(rows))
