# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 対象: main-text.ts の縦辺の周期境界、difference の行 10
# 式ペア: b_v(i,0)+sum_c(b_h(i+1,pi(c))+b_h(i,pi(c)))=b_v(i,0)+sum_c(f(c+1)+f(c))
# 帰属: Z/LZ・Z/2Z・NN・ZZ。sum_c の範囲は 0 <= c < s(j)。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_boundary_detail('difference', 9, 10, '格子面の横辺二項の式を代入')
