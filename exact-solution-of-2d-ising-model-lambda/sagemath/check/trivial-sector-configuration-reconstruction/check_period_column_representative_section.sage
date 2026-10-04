# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \sum_{i\in\mathbb Z/L\mathbb Z}b_{\mathrm v}(i,\pi(-1)+(j+\bar1)) = \sum_{i\in\mathbb Z/L\mathbb Z}b_{\mathrm v}(i,\pi(-1)+\pi(s(j+\bar1)))
# 帰属: 座標は Z/LZ、和は Z/2Z、帰納変数と代表は NN。
import os
if '_rc_check_period' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_period('column', 'representative', 4, 5, 'check_period_column_representative_section')
