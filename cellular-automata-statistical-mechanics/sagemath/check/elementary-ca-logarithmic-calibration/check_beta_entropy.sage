# 対象ラベル: claim_binary_ca_unit_difference_ratio
# 式ペア・判定: S(u+1)-S(u) = log(Ω(u+1)/1)-log(Ω(u)/1)
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for counts, u, lo, hi in adjacent_calibration_rows():
    expr1 = sub(row_entropy(counts,u+1),row_entropy(counts,u))
    expr2 = sub(logarithm(QQ(hi)/QQ(1)),logarithm(QQ(lo)/QQ(1)))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)

print("RESULT: PASS")
