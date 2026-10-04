# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \left(\sum_j b_{\mathrm v}(i,j)+\sum_j b_{\mathrm v}(i,j)\right)+\sum_j b_{\mathrm h}(i,j) = 0+\sum_j b_{\mathrm h}(i,j)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('row_sum', 7, 8, '横辺の行和：標数二で同じ和の二項を消去する')
