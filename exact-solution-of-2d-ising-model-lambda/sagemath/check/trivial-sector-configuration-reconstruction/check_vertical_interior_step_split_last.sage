# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \sum_{c=0}^{k}(f(c+1)+f(c)) = \left(\sum_{c=0}^{k-1}(f(c+1)+f(c))\right)+(f(k+1)+f(k))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os
if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_interior_detail('step', 0, 1, '望遠鏡和の帰納段階で末尾分離')
