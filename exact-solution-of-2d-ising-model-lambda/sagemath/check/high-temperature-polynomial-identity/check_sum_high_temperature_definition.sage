# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 高温展開の整数多項式の定義。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['even_factor_out'] == case['sums']['high_temperature']
print('RESULT: PASS (sum_high_temperature_definition)')
