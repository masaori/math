# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 各配位の辺積を部分集合にわたる和へ展開。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    for i, row in enumerate(case['products']):
        assert row['raw'] == sum((case['terms'][i,A]['raw'] for A in case['subsets']), R.zero())
    assert case['sums']['common'] == case['sums']['expanded']
print('RESULT: PASS (subset_expansion)')
