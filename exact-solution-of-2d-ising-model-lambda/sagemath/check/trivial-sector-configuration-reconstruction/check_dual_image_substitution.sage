# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: δ_L(破れた辺集合)=δ_L(B)
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

for case in _rc_cases:
    assert case['dual_broken'] == case['dual_B']
print("RESULT: PASS (破れた辺集合を双対像へ代入: %d 部分グラフ)" % len(_rc_cases))
