# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 基準行の横辺：零の射影は零
# 帰属: NN、Z/2Z。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_opening('horizontal', 'zero_cast', 'zero', '基準行の横辺：零の射影は零')
