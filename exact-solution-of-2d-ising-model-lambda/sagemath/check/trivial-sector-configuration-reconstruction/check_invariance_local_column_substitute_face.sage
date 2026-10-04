# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: (((\alpha+\beta)+\gamma)+\delta)+((\alpha+\beta)+\delta) = 0+((\alpha+\beta)+\delta)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('local_column', 6, 7, '縦辺の一項：格子面の等式を代入する')
