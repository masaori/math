# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: δ_L(B)=A
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _rc_cases:
    assert case['dual_B'] == case['A']
print("RESULT: PASS (双対辺写像の往復: %d 部分グラフ)" % len(_rc_cases))
