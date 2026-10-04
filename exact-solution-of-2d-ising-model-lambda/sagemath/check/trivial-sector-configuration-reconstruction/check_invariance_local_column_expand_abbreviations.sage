# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: ((\alpha+\beta)+\delta) = (b_{\mathrm v}(i,j)+b_{\mathrm h}(i,j))+b_{\mathrm h}(i+\bar1,j)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('local_column', 8, 9, '縦辺の一項：局所記号を辺の指示関数へ戻す')
