# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: \sum_{j\in\mathbb Z/L\mathbb Z}b_{\mathrm h}(\pi(-1),j) = 0
# 帰属: 座標は Z/LZ、和は Z/2Z、帰納変数と代表は NN。
import os
if '_rc_check_period' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rc_check_period('row', 'base', 2, 3, 'check_period_row_base_initial')
