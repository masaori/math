# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 隣接二項の有限和を π(s(j)) と π(0) の端点和へ
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_vertical('face', 'endpoints', '望遠鏡和の端点', interior=True)
