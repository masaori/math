# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 補集合と部分集合の個数の和。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    for row in case['products']:
        assert row['power_sum'] == row['edge_card']
print('RESULT: PASS (product_complement_card)')

