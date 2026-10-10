# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 0+b_{\mathrm v}(i,j) = b_{\mathrm v}(i,j)
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os
if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_interior_detail('difference', 21, 22, '縦辺差の最後の零の加法')
