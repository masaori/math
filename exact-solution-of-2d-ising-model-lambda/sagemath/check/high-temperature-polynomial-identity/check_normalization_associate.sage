# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 共通因子を左へ結合する。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['nested_factor'] == case['sums']['associated_factor']
print('RESULT: PASS (normalization_associate)')

