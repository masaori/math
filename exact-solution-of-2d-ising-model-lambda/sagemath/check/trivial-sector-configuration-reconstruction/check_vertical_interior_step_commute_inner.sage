# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: f(k)+((f(0)+f(k+1))+f(k)) = f(k)+(f(k)+(f(0)+f(k+1)))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os
if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_interior_detail('step', 4, 5, '望遠鏡和の重複項を寄せる交換')
