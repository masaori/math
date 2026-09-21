# 対象ラベル: claim_finite_internal_scattering_compatibilities_decidable
# 判定: 基準入力の整数値が指定した基準整数に一致することを検査する。
# 帰属: 有限集合、有限写像表、ZZ。除算・対数・実数体・複素数体は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

base_input = (ZZ(0), ZZ(0))
base_integer = ZZ(0)
assert base_input in product(B, C)
assert H[base_input] == base_integer
print('normalization input checked:', base_input)
print('RESULT: PASS')
