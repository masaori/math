# 対象ラベル: claim_prime_logarithm_ratio
# 式ペア・判定: 整数の減法の符号反転
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for t, u, v, p in rational_probe_rows():
    expr1 = exponent(v,p)-exponent(u,p)
    expr2 = -(exponent(u,p)-exponent(v,p))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
