# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: δ_L(B_L(ν_L(σ_A)))=δ_L(B_L(σ_A))
# 帰属: 有限集合、NN、ZZ。全配位を復元配位と独立に列挙する。
import os

if '_rc_fiber_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_fiber('reversal', 0, 1, '全反転による双対破れ像の保存', 'eq')
