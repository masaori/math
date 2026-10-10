# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: B_L(τ)=δ_L^(-1)(δ_L(B_L(τ)))
# 帰属: 有限集合、NN、ZZ。全配位を復元配位と独立に列挙する。
import os

if '_rc_fiber_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_fiber('inverse', 0, 1, '別の原像の破れ集合を逆写像との往復へ置換', 'eq')
