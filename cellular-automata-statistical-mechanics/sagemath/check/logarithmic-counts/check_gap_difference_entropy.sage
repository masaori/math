# 対象ラベル: claim_binary_ca_logarithmic_gap_division_obstruction
# 式ペア・判定: 反例の差を状態数の対数へ
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for mapping, H, n in gap_rows():
    expr1 = sub(entropy(mapping,H,n,2),entropy(mapping,H,n,0))
    expr2 = sub(logarithm(QQ(omega(mapping,H,n,2))/QQ(1)),logarithm(QQ(omega(mapping,H,n,0))/QQ(1)))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
