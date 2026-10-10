# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: (P_i+P_i)+H_i(s(j)) = 0+H_i(s(j))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_horizontal_boundary('difference', 5, 6, '標数二で基点の自己和を取消')
