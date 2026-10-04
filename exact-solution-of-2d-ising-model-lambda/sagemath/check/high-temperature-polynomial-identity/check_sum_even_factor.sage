# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 辺部分集合に依らない因子を和の外へ。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['commuted'] == case['sums']['even_factor_out']
print('RESULT: PASS (sum_even_factor)')
