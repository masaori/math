# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 基準行の横辺：自然数と二で割った余りの射影は等しい
# 帰属: NN、Z/2Z。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_opening('horizontal', 'count', 'remainder', '基準行の横辺：自然数と二で割った余りの射影は等しい')
