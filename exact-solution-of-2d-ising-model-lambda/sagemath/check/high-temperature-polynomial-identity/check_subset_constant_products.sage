# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 一定値の有限積を冪へ。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    for row in case['terms'].values():
        assert row['split'] == row['constants']
print('RESULT: PASS (subset_constant_products)')

