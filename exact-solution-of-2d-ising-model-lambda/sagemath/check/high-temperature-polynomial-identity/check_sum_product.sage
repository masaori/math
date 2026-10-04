# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 全辺積の評価を配位和へ代入。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['common'] == case['sums']['product_evaluated']
print('RESULT: PASS (sum_product)')

