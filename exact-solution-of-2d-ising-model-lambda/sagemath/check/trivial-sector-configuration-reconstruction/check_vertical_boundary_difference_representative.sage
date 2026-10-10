# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 対象: main-text.ts の縦辺の周期境界、difference の行 2
# 式ペア: (V(s(i+1))+H_{i+1}(s(j)))+(V(s(i))+H_i(s(j)))=(V(0)+H_{i+1}(s(j)))+(V(s(i))+H_i(s(j)))
# 帰属: Z/LZ・Z/2Z・NN・ZZ。sum_c の範囲は 0 <= c < s(j)。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_vertical_boundary_detail('difference', 1, 2, '次の代表を零に置換')
