# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \left(\sum_i b_{\mathrm v}(i,j)+\sum_i b_{\mathrm h}(i,j)\right)+\sum_i b_{\mathrm h}(i,j) = \sum_i b_{\mathrm v}(i,j)+\left(\sum_i b_{\mathrm h}(i,j)+\sum_i b_{\mathrm h}(i,j)\right)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('column_sum', 4, 5, '縦辺の列和：同じ有限和の二項をまとめる')
