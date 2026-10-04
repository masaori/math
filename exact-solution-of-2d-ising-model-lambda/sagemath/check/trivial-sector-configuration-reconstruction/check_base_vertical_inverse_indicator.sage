# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 基準列の縦辺：原像の指示関数を元の指示関数へ
# 帰属: NN、Z/2Z。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_opening('vertical', 'preimage', 'image', '基準列の縦辺：原像の指示関数を元の指示関数へ')
