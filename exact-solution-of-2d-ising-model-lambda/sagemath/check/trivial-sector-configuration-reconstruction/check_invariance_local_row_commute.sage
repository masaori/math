# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: (\delta+((\alpha+\beta)+\gamma))+((\alpha+\beta)+\gamma) = (((\alpha+\beta)+\gamma)+\delta)+((\alpha+\beta)+\gamma)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('local_row', 4, 5, '横辺の一項：格子面の順序へ二項を交換する')
