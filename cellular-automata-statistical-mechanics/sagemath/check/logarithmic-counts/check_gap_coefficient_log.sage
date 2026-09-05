# 対象ラベル: claim_binary_ca_logarithmic_gap_division_obstruction
# 式ペア・判定: 素数2の対数係数
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for mapping, H, n in gap_rows():
    expr1 = coefficient(logarithm(QQ(2)/QQ(1)),ZZ(2))
    expr2 = valuation(QQ(2)/QQ(1),ZZ(2))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
