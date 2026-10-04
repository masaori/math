# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 基準列の縦辺：周期和の各項を定義で展開
# 帰属: NN、Z/2Z。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_opening('vertical', 'cycle', 'project_terms', '基準列の縦辺：周期和の各項を定義で展開')
