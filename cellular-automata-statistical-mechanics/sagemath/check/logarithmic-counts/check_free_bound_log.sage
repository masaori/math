# 対象ラベル: claim_binary_ca_logarithmic_free_count_bound
# 式ペア・判定: 正有理数の上界を対数順序へ移す
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, n in ca_count_rows():
    if count_fixed(mapping,n) > 0:
        phi = free_count(mapping,n)
        assert logarithm(QQ(1)) == {}
        assert less_equal({},phi)
        assert less_equal(phi,logarithm(QQ(2**size)/QQ(1)))
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
