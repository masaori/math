# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: sum(k in Z/LZ, b_h(i,k)) = 0
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_horizontal_boundary('period', 2, 3, '全行の周期和零を適用')
