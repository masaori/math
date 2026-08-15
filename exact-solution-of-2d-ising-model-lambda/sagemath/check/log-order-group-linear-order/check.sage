# 対象ラベル: claim_log_order_group_linear_order（および def_log_order_group_order）
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。

from itertools import product


def v(p, n):
    return ZZ(n).valuation(p)


def log_lambda(q):
    a, b = ZZ(q.numerator()), ZZ(q.denominator())
    primes = set(prime_factors(a)) | set(prime_factors(b))
    return {p: v(p, a) - v(p, b) for p in primes if v(p, a) - v(p, b) != 0}


def rational_of_log(lam):
    return prod(QQ(p) ** z for p, z in lam.items())


def le_lambda(lam, mu):
    # def_log_order_group_order: rat_Λ(λ) ≤ rat_Λ(μ) を QQ の順序で判定する。
    return rational_of_log(lam) <= rational_of_log(mu)


primes = [2, 3, 5]
coefficients = [-2, -1, 0, 1, 2]
vectors = []
for values in product(coefficients, repeat=len(primes)):
    vectors.append({p: ZZ(z) for p, z in zip(primes, values) if z != 0})

def canonical(lam):
    return tuple(sorted(lam.items()))

pair_count = 0
triple_count = 0

# 反射律と全順序性（各対）、反対称律（各対。QQ の等号から log∘rat_Λ で Λ の等号へ戻す）。
for lam in vectors:
    assert le_lambda(lam, lam)
    for mu in vectors:
        a, b = le_lambda(lam, mu), le_lambda(mu, lam)
        assert a or b
        if a and b:
            ql, qm = rational_of_log(lam), rational_of_log(mu)
            assert ql == qm
            assert log_lambda(ql) == lam and log_lambda(qm) == mu
            assert canonical(lam) == canonical(mu)
        pair_count += 1

# 推移律（各三つ組）。
for lam in vectors:
    for mu in vectors:
        if not le_lambda(lam, mu):
            continue
        for nu in vectors:
            if le_lambda(mu, nu):
                assert le_lambda(lam, nu)
                triple_count += 1

print("PASS: log-order-group-linear-order (%d vectors, %d pairs, %d transitive triples)"
      % (len(vectors), pair_count, triple_count))
