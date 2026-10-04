# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: スピン単項式の和の定義。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['spin_factor'] == case['sums']['spin_definition']
print('RESULT: PASS (sum_spin_definition)')

