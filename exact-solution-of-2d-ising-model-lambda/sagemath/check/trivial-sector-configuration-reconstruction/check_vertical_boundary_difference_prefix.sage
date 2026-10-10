# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 対象: main-text.ts の縦辺の周期境界、difference の行 5
# 式ペア: H_{i+1}(s(j))+(V(s(i))+H_i(s(j)))=H_{i+1}(s(j))+(b_v(i,0)+H_i(s(j)))
# 帰属: Z/LZ・Z/2Z・NN・ZZ。sum_c の範囲は 0 <= c < s(j)。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_boundary_detail('difference', 4, 5, '末尾の部分和を一項に置換')
