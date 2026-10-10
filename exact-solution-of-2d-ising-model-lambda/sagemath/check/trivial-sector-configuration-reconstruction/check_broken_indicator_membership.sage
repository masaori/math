# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: π₂(1_B(e))=1 iff e∈B
# 帰属: Z/2Z、NN、有限集合。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_edges('indicator_one', 'original', '指示関数による所属判定')
