# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 乗法の結合則。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    for row in case['terms'].values():
        assert row['edge_card'] == row['associated']
print('RESULT: PASS (subset_associate)')
