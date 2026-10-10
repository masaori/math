# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 対象: main-text.ts の縦辺の周期境界、period の行 2
# 式ペア: sum_{r=0}^{L-1} b_v(pi(r),0)=sum_{k in Z/LZ} b_v(k,0)
# 帰属: Z/LZ・Z/2Z・NN・ZZ。sum_c の範囲は 0 <= c < s(j)。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_boundary_detail('period', 1, 2, '代表の全単射で列全体へ再添字付け')
