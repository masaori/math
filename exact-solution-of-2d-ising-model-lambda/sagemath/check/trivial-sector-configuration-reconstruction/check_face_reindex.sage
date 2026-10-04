# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 四項の有限和の位置を再添字付け
# 帰属: NN、Z/2Z。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_opening('face', 'inverse', 'ordered', '四項の有限和の位置を再添字付け')
