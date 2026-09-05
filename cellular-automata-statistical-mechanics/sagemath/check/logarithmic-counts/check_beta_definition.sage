# 対象ラベル: claim_binary_ca_unit_difference_ratio
# 式ペア・判定: β=S(u+1)-S(u)
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for mapping, H, n, u, lo, hi in adjacent_rows():
    expr1 = beta(mapping,H,n,u)
    expr2 = sub(entropy(mapping,H,n,u+1),entropy(mapping,H,n,u))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
