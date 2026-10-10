# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 対象: main-text.ts の縦辺の周期境界、difference の行 12
# 式ペア: b_v(i,0)+(f(s(j))+f(0))=b_v(i,0)+(b_v(i,j)+f(0))
# 帰属: Z/LZ・Z/2Z・NN・ZZ。sum_c の範囲は 0 <= c < s(j)。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_boundary_detail('difference', 11, 12, '終点の代表を射影')
