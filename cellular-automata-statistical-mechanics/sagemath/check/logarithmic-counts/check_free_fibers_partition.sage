# 対象ラベル: claim_binary_ca_logarithmic_free_count_fibers
# 式ペア・判定: Z_n を繊維状態数の和へ
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, H, n, fixed, D in (row for row in fiber_rows() if row[4]):
    expr1 = logarithm(QQ(count_fixed(mapping,n))/QQ(1))
    expr2 = logarithm(QQ(sum((omega(mapping,H,n,u) for u in D),ZZ(0)))/QQ(1))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
