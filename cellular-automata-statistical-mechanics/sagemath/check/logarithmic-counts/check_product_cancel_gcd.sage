# 対象ラベル: claim_prime_logarithm_product
# 式ペア・判定: 共通因子の指数の消去
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for q, t, r, s, u, v, g, p in rational_pair_rows():
    expr1 = (exponent(r,p)+exponent(u,p)-exponent(g,p))-(exponent(s,p)+exponent(v,p)-exponent(g,p))
    expr2 = (exponent(r,p)-exponent(s,p))+(exponent(u,p)-exponent(v,p))
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
