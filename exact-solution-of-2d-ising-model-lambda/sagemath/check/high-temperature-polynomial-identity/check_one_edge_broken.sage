# 対象ラベル: claim_high_temperature_polynomial_identity
# 式ペア: 一辺の二値評価の異なるスピンの場合。帰属: ZZ[x]。
import os
if '_high_temperature_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _high_temperature_cases:
    for row in case['local']:
        if not row['same']:
            assert row['weight'] == 2*x
print('RESULT: PASS (one_edge_broken)')

