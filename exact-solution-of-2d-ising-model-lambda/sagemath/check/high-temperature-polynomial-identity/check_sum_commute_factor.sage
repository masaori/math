# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 各項の定数因子を交換。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['even_only'] == case['sums']['commuted']
print('RESULT: PASS (sum_commute_factor)')

