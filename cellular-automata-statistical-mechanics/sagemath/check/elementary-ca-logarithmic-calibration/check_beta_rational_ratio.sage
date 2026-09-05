# 対象ラベル: claim_binary_ca_unit_difference_ratio
# 式ペア・判定: log((hi/1)/(lo/1)) = log(hi/lo)
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for counts, u, lo, hi in adjacent_calibration_rows():
    expr1 = logarithm((QQ(hi)/QQ(1))/(QQ(lo)/QQ(1)))
    expr2 = logarithm(QQ(hi)/QQ(lo))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)

print("RESULT: PASS")
