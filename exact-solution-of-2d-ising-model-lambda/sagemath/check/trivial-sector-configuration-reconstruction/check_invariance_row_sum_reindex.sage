# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \left(\sum_j b_{\mathrm v}(i,j)+\sum_j b_{\mathrm h}(i,j)\right)+\sum_j b_{\mathrm v}(i,j+\bar1) = \left(\sum_j b_{\mathrm v}(i,j)+\sum_j b_{\mathrm h}(i,j)\right)+\sum_j b_{\mathrm v}(i,j)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('row_sum', 3, 4, '横辺の行和：巡回移動で有限和を再添字付けする')
