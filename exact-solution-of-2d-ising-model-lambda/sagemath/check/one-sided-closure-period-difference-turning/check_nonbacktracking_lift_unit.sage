# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す D_i は方向単位ベクトルで、逆ベクトルは方向番号の差 2 と同値。従って u((j+1) mod m) ≠ -u(j)
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['lift_unit']
print('lift_unit: PASS', len(rows))
