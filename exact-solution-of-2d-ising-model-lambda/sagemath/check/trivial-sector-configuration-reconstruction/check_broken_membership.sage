# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 端点の道和差を使い B への所属へ戻す
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_edges('parity', 'original', '元の辺集合への所属')
