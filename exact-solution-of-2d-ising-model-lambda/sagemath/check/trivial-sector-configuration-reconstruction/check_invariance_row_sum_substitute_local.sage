# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \sum_j b_{\mathrm h}(i+\bar1,j) = \sum_j \bigl((b_{\mathrm v}(i,j)+b_{\mathrm h}(i,j))+b_{\mathrm v}(i,j+\bar1)\bigr)
# 帰属: Z/2Z。セクターを限定せず全偶部分グラフを使う。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_invariance('row_sum', 0, 1, '横辺の行和：隣の一項の等式を有限和へ代入する')
