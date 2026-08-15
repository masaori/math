# 対象ラベル: claim_rational_of_log_additive / claim_log_order_group_add_monotone
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。

from itertools import product


def add_lambda(lam, nu):
    primes = set(lam) | set(nu)
    return {p: lam.get(p, ZZ(0)) + nu.get(p, ZZ(0))
            for p in primes if lam.get(p, ZZ(0)) + nu.get(p, ZZ(0)) != 0}


def rational_of_log(lam):
    return prod(QQ(p) ** z for p, z in lam.items())


def le_lambda(lam, mu):
    return rational_of_log(lam) <= rational_of_log(mu)


primes = [2, 3, 5]
coefficients = [-2, -1, 0, 1, 2]
vectors = [
    {p: ZZ(z) for p, z in zip(primes, values) if z != 0}
    for values in product(coefficients, repeat=len(primes))
]

add_count = 0
mono_count = 0
for lam in vectors:
    for nu in vectors:
        assert rational_of_log(add_lambda(lam, nu)) == rational_of_log(lam) * rational_of_log(nu)
        add_count += 1
    for mu in vectors:
        if not le_lambda(lam, mu):
            continue
        for nu in vectors:
            assert le_lambda(add_lambda(lam, nu), add_lambda(mu, nu))
            mono_count += 1

print("PASS: log-order-group-add-monotone (%d vectors, %d additive pairs, %d monotone triples)"
      % (len(vectors), add_count, mono_count))
