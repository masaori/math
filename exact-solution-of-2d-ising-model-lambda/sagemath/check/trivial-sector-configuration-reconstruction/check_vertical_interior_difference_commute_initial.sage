# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: b_{\mathrm v}(i,0)+(b_{\mathrm v}(i,j)+b_{\mathrm v}(i,0)) = b_{\mathrm v}(i,0)+(b_{\mathrm v}(i,0)+b_{\mathrm v}(i,j))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os
if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_interior_detail('difference', 18, 19, '初項の重複を寄せる交換')
