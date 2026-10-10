# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: b_h(i,pi(s(j))) = b_h(i,j)
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_horizontal_boundary('difference', 8, 9, '代表を射影して元の座標へ')
