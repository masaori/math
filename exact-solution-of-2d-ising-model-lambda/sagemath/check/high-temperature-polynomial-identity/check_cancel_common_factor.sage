# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 非零の定数因子を消去。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['cancelled_left'] == case['sums']['cancelled_right']
    assert R(2)**(case['L']*case['L']) != 0
    assert R.is_integral_domain()
print('RESULT: PASS (cancel_common_factor)')

