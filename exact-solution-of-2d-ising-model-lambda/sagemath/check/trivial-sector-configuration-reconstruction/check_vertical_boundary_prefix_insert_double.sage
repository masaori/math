# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 対象: main-text.ts の縦辺の周期境界、prefix の行 2
# 式ペア: V(s(i))+0=V(s(i))+(b_v(pi(s(i)),0)+b_v(pi(s(i)),0))
# 帰属: Z/LZ・Z/2Z・NN・ZZ。sum_c の範囲は 0 <= c < s(j)。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_boundary_detail('prefix', 1, 2, '末尾項の自己和零を代入')
