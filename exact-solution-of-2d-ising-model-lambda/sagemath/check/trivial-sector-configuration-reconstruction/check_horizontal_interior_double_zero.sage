# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: ((P_i+H_i(s(j)))+(P_i+H_i(s(j))))+b_h(i,pi(s(j))) = 0+b_h(i,pi(s(j)))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_horizontal_interior('difference', 7, 8, '標数二で重複する道和を取消')
