# SageMath: 44 の倍数で 44! を割る次数候補の有限絞り込み
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple
# 式ペア: 44*d divides 44! iff d divides 43!
# 帰属: ZZ と NN だけを用いる

factor_degree = ZZ(44)
factorial_order = factorial(factor_degree)
reduced_factorial = factorial(factor_degree - 1)

assert factorial_order == factor_degree * reduced_factorial

factorial_exponents = dict(factor(factorial_order))
factor_degree_exponents = dict(factor(factor_degree))
reduced_exponents = dict(factor(reduced_factorial))

for prime in factorial_exponents:
    assert factorial_exponents[prime] == (
        factor_degree_exponents.get(prime, ZZ(0))
        + reduced_exponents.get(prime, ZZ(0))
    )

assert all(exponent >= 0 for exponent in reduced_exponents.values())
assert reduced_factorial in NN

print("RESULT: PASS — cancelling the factor 44 changes the factorial divisor condition to a divisor condition on 43!")
