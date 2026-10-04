# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 既証明のスピン和の二値評価。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    assert case['sums']['spin_definition'] == case['sums']['spin_evaluated']
    for A in case['subsets']:
        assert case['spins'][A] == (ZZ(2)**(case['L']*case['L']) if case['even'][A] else ZZ(0))
print('RESULT: PASS (sum_spin_evaluation)')
