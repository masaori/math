# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: t(∂₁(e))+t(∂₀(e))=π₂(1_B(e))
# 帰属: Z/2Z、NN、有限集合。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_edges('backward_sum', 'indicator', '横辺差・縦辺差を指示関数へ代入')
