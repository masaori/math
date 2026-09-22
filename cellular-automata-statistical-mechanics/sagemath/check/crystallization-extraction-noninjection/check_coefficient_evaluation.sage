# 対象ラベル: claim_crystallization_extraction_not_injective
# 判定: 1+q が q=0 で正則な単元で、評価が 1 であり、使用する全係数で評価が積を保つことを検査する。
# 帰属: QQ(q) と QQ(q)[z,z^-1]。複素数体、浮動小数点、解析的極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

scale = Qq(1 + q)
inverse_scale = Qq(1) / scale
assert is_regular_at_zero(scale)
assert is_regular_at_zero(inverse_scale)
assert scale * inverse_scale == 1
assert evaluate_coefficient_at_zero(scale) == 1
assert evaluate_coefficient_at_zero(inverse_scale) == 1

checked = ZZ(0)
for entry in R0.list():
    for coefficient in Laurent_qz(entry).dict().values():
        assert is_regular_at_zero(coefficient)
        assert evaluate_coefficient_at_zero(scale * coefficient) == (
            evaluate_coefficient_at_zero(scale) * evaluate_coefficient_at_zero(coefficient)
        )
        checked += 1

assert checked == len(BC)
print('regular coefficients and multiplicative evaluations checked:', checked)
print('RESULT: PASS')
