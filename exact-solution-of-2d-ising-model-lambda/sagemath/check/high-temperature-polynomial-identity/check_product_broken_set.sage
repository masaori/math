# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 破れた辺の定義で条件を書き換える。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    for row in case['products']:
        assert row['by_spin'] == row['by_broken']
print('RESULT: PASS (product_broken_set)')
