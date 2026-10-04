# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 二つの有限和の順序を入れ替える。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['associated'] == case['sums']['swapped']
print('RESULT: PASS (sum_order)')

