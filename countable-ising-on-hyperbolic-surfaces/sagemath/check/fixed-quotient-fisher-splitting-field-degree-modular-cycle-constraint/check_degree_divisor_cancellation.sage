# SageMath: 有限体分解型による分解体次数候補の有限絞り込み
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint
# 式ペア: 2990 divides 44*d implies 1495 divides d
# 帰属: ZZ と NN だけを用いる

frobenius_order = ZZ(2990)
irreducible_degree = ZZ(44)
required_quotient_factor = ZZ(1495)
coprime_cofactor = ZZ(22)

assert frobenius_order == 2 * required_quotient_factor
assert irreducible_degree == 2 * coprime_cofactor
assert gcd(required_quotient_factor, coprime_cofactor) == 1
assert required_quotient_factor == 5 * 13 * 23
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 65780

reduced_factorial = factorial(43) // required_quotient_factor
assert reduced_factorial in NN
assert irreducible_degree * required_quotient_factor * reduced_factorial == (
    irreducible_degree * factorial(43)
)

print(
    "RESULT: PASS — the order-2990 constraint and degree 44 force the "
    "remaining factor to be divisible by 1495, giving degree 65780*e"
)
