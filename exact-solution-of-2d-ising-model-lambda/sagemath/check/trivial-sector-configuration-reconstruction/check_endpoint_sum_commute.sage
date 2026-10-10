# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: t(∂₀(e))+t(∂₁(e))=t(∂₁(e))+t(∂₀(e))
# 帰属: Z/2Z、NN、有限集合。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_edges('forward_sum', 'backward_sum', '端点道和の順序交換')
