# SageMath: 階乗整除性が与える有限な次数候補集合
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial
# 式ペア: {n in NN_{>0} | n divides 44!}
# 帰属: ZZ と NN だけを用いる

factorial_order = factorial(ZZ(44))
prime_exponents = {}

for prime in primes(ZZ(2), ZZ(45)):
    exponent = ZZ(0)
    prime_power = prime
    while prime_power <= 44:
        exponent += ZZ(44) // prime_power
        prime_power *= prime
    prime_exponents[prime] = exponent

reconstructed_factorial = prod(
    prime ** exponent for prime, exponent in prime_exponents.items()
)
divisor_count = prod(exponent + ZZ(1) for exponent in prime_exponents.values())

assert reconstructed_factorial == factorial_order
assert all(exponent > 0 for exponent in prime_exponents.values())
assert divisor_count in NN
assert divisor_count > 0

print("RESULT: PASS — the prime-exponent data of 44! reconstructs it exactly and gives a finite positive-divisor candidate set")
