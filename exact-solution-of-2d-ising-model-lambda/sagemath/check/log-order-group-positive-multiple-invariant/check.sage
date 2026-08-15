# 対象ラベル: claim_log_order_group_positive_multiple_invariant
# 帰属: ZZ / QQ と素因数分解だけを使う厳密計算。浮動小数点は使わない。

from itertools import product


def smul_lambda(n, lam):
    return {p: n * z for p, z in lam.items() if n * z != 0}


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
multiples = [ZZ(n) for n in range(0, 5)]

# 補助等式 rat_Λ(Nλ) = rat_Λ(λ)^N（N = 0 も含む）
pow_count = 0
for lam in vectors:
    for n in multiples:
        assert rational_of_log(smul_lambda(n, lam)) == rational_of_log(lam) ** n
        pow_count += 1

# 主張: N ≥ 1 のとき λ ≤ μ ⟺ Nλ ≤ Nμ
iff_count = 0
for lam in vectors:
    for mu in vectors:
        for n in multiples:
            if n == 0:
                continue
            assert le_lambda(lam, mu) == le_lambda(smul_lambda(n, lam), smul_lambda(n, mu))
            iff_count += 1

print("PASS: log-order-group-positive-multiple-invariant (%d vectors, %d power identities, %d equivalences)"
      % (len(vectors), pow_count, iff_count))
