# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 配位に依らない因子を有限和の外へ出す。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['product_evaluated'] == case['sums']['constant_out']
print('RESULT: PASS (sum_constant_out)')

