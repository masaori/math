# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 式ペア: 端点スピンへ自然数指数による配位の定義を代入
# 帰属: Z/2Z、NN、ZZ。浮動小数点を使わない。
import os

if '_rc_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_rc_check_edges('spins', 'powers', '自然数指数の代入')
