# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: b_{\mathrm v}(i,0)+(f(s(j))+f(0)) = b_{\mathrm v}(i,0)+(b_{\mathrm v}(i,j)+f(0))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os
if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_interior_detail('difference', 16, 17, '縦辺列の末尾の代表を射影')
