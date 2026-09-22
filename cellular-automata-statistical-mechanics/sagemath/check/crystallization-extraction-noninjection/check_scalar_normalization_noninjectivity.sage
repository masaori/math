# 対象ラベル: claim_crystallization_extraction_not_injective
# 判定: R と (1+q)R が異なる同型でありながら、q=0 の基底全単射と整数指数が一致することを検査する。
# 帰属: QQ(q)[z,z^-1] と QQ[z,z^-1] 上の有限行列。複素数体、浮動小数点、解析的極限は使わない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

assert R0.det().is_unit()
assert R1.det().is_unit()
assert R1 - R0 == q * R0
assert q * R0 != 0
assert R1 != R0

evaluated_R0 = evaluate_matrix_at_zero(R0)
evaluated_R1 = evaluate_matrix_at_zero(R1)
assert evaluated_R1 == evaluated_R0

checked = ZZ(0)
for column, source in enumerate(BC):
    row = CB.index(swapped_basis(source))
    for evaluated in (evaluated_R0, evaluated_R1):
        terms = evaluated[row, column].dict()
        assert terms == {int(H[source]): QQ(1)}
        checked += 1

assert checked == 2 * len(BC)
print('distinct invertible operators checked: 2')
print('matching extracted basis/exponent entries checked:', checked)
print('RESULT: PASS')
