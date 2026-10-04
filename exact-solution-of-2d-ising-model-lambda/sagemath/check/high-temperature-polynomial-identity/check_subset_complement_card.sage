# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 補集合の個数を差へ。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    for row in case['terms'].values():
        assert row['constants'] == row['complement_card']
print('RESULT: PASS (subset_complement_card)')
