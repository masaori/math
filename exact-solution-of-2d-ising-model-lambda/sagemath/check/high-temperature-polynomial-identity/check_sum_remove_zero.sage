# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 零項を除いて偶部分グラフだけに制限。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['spin_evaluated'] == case['sums']['even_only']
print('RESULT: PASS (sum_remove_zero)')

