# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \gamma+(((\alpha+\beta)+\delta)+((\alpha+\beta)+\delta)) = (\gamma+((\alpha+\beta)+\delta))+((\alpha+\beta)+\delta)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('local_column', 3, 4, '縦辺の一項：外側の和を結合し直す')
