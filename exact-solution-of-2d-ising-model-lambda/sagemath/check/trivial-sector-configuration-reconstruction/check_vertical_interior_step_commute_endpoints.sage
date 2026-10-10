# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: f(0)+f(k+1) = f(k+1)+f(0)
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os
if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_interior_detail('step', 8, 9, '望遠鏡和の両端の交換')
