# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: τ∈F_A ⇒ τ=σ_A または τ=ν_L(σ_A)
# 帰属: 有限集合、NN、ZZ。全配位を復元配位と独立に列挙する。
import os

if '_rc_fiber_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_fiber('forward', 0, 1, '全原像は復元配位または全反転である', 'eq')
