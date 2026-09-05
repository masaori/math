# 対象ラベル: claim_binary_ca_unit_difference_ratio
# 式ペア・判定: 両端のエントロピーを対数へ
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for mapping, H, n, u, lo, hi in adjacent_rows():
    expr1 = sub(entropy(mapping,H,n,u+1),entropy(mapping,H,n,u))
    expr2 = sub(logarithm(QQ(hi)/QQ(1)),logarithm(QQ(lo)/QQ(1)))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
