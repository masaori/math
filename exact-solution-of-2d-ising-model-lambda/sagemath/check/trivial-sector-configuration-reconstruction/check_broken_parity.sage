# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 整数冪の不一致と端点の道和の和が一の同値
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_edges('powers', 'parity', '道和の偶奇との同値')
