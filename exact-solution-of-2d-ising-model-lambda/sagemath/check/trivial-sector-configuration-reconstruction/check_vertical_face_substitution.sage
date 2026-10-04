# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 横辺二項の有限和へ面の等式を各項代入
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_vertical('expanded', 'face', '面の等式の代入', interior=True)
