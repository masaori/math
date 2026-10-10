# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: (b_{\mathrm v}(i,0)+H_{i+\bar1}(s(j)))+H_i(s(j)) = b_{\mathrm v}(i,0)+(H_{i+\bar1}(s(j))+H_i(s(j)))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os
if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_interior_detail('difference', 12, 13, '二行の和をまとめる結合')
