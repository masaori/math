# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 対象の行: 非後退性を示す u(j) = D_[k0+j] と u((j+1) mod m) = D_ρ1([k0+j])
load('sagemath/check/one-sided-closure-period-difference-turning/_prelude.sage')
rows = [row for row in _difference_rows if row['at_maximum']]
assert rows
for row in rows:
    assert row['scalar']['lift_steps']
print('lift_steps: PASS', len(rows))
