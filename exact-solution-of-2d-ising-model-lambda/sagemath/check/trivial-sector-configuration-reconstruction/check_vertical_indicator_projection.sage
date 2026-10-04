# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 縦辺の自然数指示関数を π₂ で写す
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _rc_cases:
    for i, j in vertices(case['L']):
        assert _rc_s2(case['bv'][(i,j)]) == NN(edge_number_vertical(case['L'],i,j) in case['B'])
print("RESULT: PASS (縦辺の指示関数と射影)")
