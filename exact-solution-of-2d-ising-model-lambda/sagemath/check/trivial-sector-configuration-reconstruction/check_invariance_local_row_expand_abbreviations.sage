# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: ((\alpha+\beta)+\gamma) = (b_{\mathrm v}(i,j)+b_{\mathrm h}(i,j))+b_{\mathrm v}(i,j+\bar1)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('local_row', 7, 8, '横辺の一項：局所記号を辺の指示関数へ戻す')
