# 対象ラベル: claim_prime_vectors_abelian_group
# 式ペア・判定: b+a の係数へ戻す
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for a, b in vector_pairs():
    expr1 = clean({p: coefficient(b,p)+coefficient(a,p) for p in PROBE_PRIMES})
    expr2 = add(b,a)
    assert expr1 == expr2
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
