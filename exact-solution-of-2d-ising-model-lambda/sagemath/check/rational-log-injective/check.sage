# 対象ラベル: claim_rational_log_injective
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。

from itertools import product


def v(p, n):
    # def_prime_exponent の v_p(n)（n >= 1）
    return ZZ(n).valuation(p)


def log_lambda(q):
    # def_rational_log の log q ∈ Λ（有限台の辞書）
    a, b = ZZ(q.numerator()), ZZ(q.denominator())
    primes = set(prime_factors(a)) | set(prime_factors(b))
    return {p: v(p, a) - v(p, b) for p in primes if v(p, a) - v(p, b) != 0}


count = 0
ints = [1, 2, 3, 4, 6, 8, 9, 12, 25]
reps = [(a, b) for a in ints for b in ints]
for (a, b), (a2, b2) in product(reps, reps):
    q, q2 = QQ(a) / b, QQ(a2) / b2
    lam, lam2 = log_lambda(q), log_lambda(q2)
    ps = set(prime_factors(a * b * a2 * b2))
    for p in ps:
        wq = v(p, a) - v(p, b)
        wq2 = v(p, a2) - v(p, b2)
        # 証明の一続きの計算の各行（仮定 log q = log q' を使う行は仮定が成り立つときだけ）
        assert v(p, a * b2) == v(p, a) + v(p, b2)
        assert v(p, a) + v(p, b2) == (wq + v(p, b)) + v(p, b2)
        if lam == lam2:
            assert wq == wq2
            assert (wq + v(p, b)) + v(p, b2) == (wq2 + v(p, b)) + v(p, b2)
        assert (wq2 + v(p, b)) + v(p, b2) == (v(p, a2) - v(p, b2) + v(p, b)) + v(p, b2)
        assert (v(p, a2) - v(p, b2) + v(p, b)) + v(p, b2) == v(p, a2) + v(p, b)
        assert v(p, a2) + v(p, b) == v(p, a2 * b)
    # 有限積表示
    assert prod([p ** v(p, a * b2) for p in ps]) == a * b2
    if lam == lam2:
        assert a * b2 == a2 * b
        assert QQ(a) / b == QQ(a * b2) / (b * b2) == QQ(a2 * b) / (b * b2) == QQ(a2) / b2
        assert q == q2
    # 単射性そのもの（対偶: q ≠ q' なら log q ≠ log q'）
    assert (lam == lam2) == (q == q2)
    count += 1

print("PASS: rational-log-injective (%d checks)" % count)
