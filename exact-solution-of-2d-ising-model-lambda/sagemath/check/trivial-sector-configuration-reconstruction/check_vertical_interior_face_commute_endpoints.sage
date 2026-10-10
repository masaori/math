# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: b_{\mathrm v}(i,\pi(c))+b_{\mathrm v}(i,\pi(c)+\bar1) = b_{\mathrm v}(i,\pi(c)+\bar1)+b_{\mathrm v}(i,\pi(c))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os
if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_interior_detail('face', 7, 8, '残る縦辺二項の交換')
