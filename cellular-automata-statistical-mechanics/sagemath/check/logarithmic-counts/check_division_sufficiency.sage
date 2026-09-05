# 対象ラベル: claim_prime_vector_integer_division
# 式ペア・判定: 整除条件から台の内外で解を構成
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for a, d in product(vectors(3), (-3,-2,-1,1,2,3)):
    condition = all(z % d == 0 for z in a.values())
    if condition:
        b = divide(d,a)
        assert set(b) <= set(a)
        assert scale(d,b) == a
        for p in PROBE_PRIMES:
            assert d*coefficient(b,p) == coefficient(a,p)
    else:
        witnesses = [p for p in a if a[p] % d != 0]
        assert witnesses
        try:
            divide(d,a)
        except ValueError:
            pass  # 期待した定義域外の拒否。例外が無ければ下で失敗する。
        else:
            raise AssertionError('nondivisible input accepted')
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
