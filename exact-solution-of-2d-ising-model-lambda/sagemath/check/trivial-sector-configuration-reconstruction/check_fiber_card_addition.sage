# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 1+1=2
# 帰属: 有限集合、NN、ZZ。全配位を復元配位と独立に列挙する。
import os

if '_rc_fiber_rows' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_fiber('card', 3, 4, '自然数の一と一の和', 'eq')
