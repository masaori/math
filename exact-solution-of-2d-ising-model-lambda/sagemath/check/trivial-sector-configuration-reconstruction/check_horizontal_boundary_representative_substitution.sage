# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: s(j+bar(1)) = s(0)
# 帰属: Z/LZ、Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_horizontal_boundary('representative', 0, 1, '次の座標を零へ')
