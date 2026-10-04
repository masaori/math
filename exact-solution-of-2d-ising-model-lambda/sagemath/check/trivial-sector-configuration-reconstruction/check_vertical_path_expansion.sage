# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: t(i+1,j)+t(i,j) から定義を展開
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_vertical('difference', 'expanded', '縦辺差の定義展開', interior=True)
