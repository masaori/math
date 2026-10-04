# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 全辺の積へ一辺の二値評価を代入。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    for row in case['products']:
        assert row['raw'] == row['by_spin']
print('RESULT: PASS (product_edge_evaluation)')

