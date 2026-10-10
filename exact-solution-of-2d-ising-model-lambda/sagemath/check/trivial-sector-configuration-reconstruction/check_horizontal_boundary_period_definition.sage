# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: H_i(L) = sum(c=0..L-1, b_h(i,pi(c)))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_horizontal_boundary('period', 0, 1, '有限和の定義を展開')
