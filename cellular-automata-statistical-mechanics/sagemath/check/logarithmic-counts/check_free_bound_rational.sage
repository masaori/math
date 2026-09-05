# 対象ラベル: claim_binary_ca_logarithmic_free_count_bound
# 式ペア・判定: 1 ≤ q_F(n) ≤ 2^|V|/1
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, mapping, n in ca_count_rows():
    Z = count_fixed(mapping,n)
    assert 0 <= Z <= 2**size
    if Z > 0:
        assert QQ(1) <= rational_count(mapping,n) <= QQ(2**size)/QQ(1)
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
