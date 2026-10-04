# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 破れた辺への所属と端点スピンの不一致
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_edges('member', 'spins', '破れた辺の定義')
