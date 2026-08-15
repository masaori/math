# 対象ラベル: claim_rational_log_surjective
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。

from itertools import product


def v(p, n):
    return ZZ(n).valuation(p)


def log_lambda(q):
    a, b = ZZ(q.numerator()), ZZ(q.denominator())
    primes = set(prime_factors(a)) | set(prime_factors(b))
    return {p: v(p, a) - v(p, b) for p in primes if v(p, a) - v(p, b) != 0}


def rational_of_log(lam):
    return prod(QQ(p) ** z for p, z in lam.items())


primes = [2, 3, 5, 7]
coefficients = [-3, -1, 0, 1, 2]
count = 0

# 有限台ベクトル 5^4 件について構成と復元を厳密に検査する。
for values in product(coefficients, repeat=len(primes)):
    lam = {p: ZZ(z) for p, z in zip(primes, values) if z != 0}
    q = rational_of_log(lam)
    assert q > 0
    # 定義の有限積と、正・負の指数を分子・分母へ分けた表示は同じ有理数である。
    numerator = prod(ZZ(p) ** z for p, z in lam.items() if z > 0)
    denominator = prod(ZZ(p) ** (-z) for p, z in lam.items() if z < 0)
    assert q == QQ(numerator) / denominator
    # 素数一個の整数冪の各段。
    for p, z in lam.items():
        assert log_lambda(QQ(p)) == {p: ZZ(1)}
        assert log_lambda(QQ(p) ** z) == {p: z}
    # 有限積への加法性の反復と、主張 log(rat_Lambda(lambda)) = lambda。
    running_q = QQ(1)
    running_log = {}
    assert log_lambda(running_q) == running_log
    for p, z in lam.items():
        next_q = running_q * QQ(p) ** z
        next_log = dict(running_log)
        next_log[p] = z
        assert log_lambda(next_q) == next_log
        running_q, running_log = next_q, next_log
    assert running_q == q
    assert log_lambda(q) == lam
    count += 1

print("PASS: rational-log-surjective (%d finite-support vectors)" % count)
