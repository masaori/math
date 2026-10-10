# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: H_i(s(j)+1)+b_h(i,pi(s(j))) = H_i(L)+b_h(i,pi(s(j)))
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_horizontal_boundary('prefix', 4, 5, '末尾の次を辺長へ')
