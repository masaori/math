# SageMath: 149 進分解型を加えた分解体次数の整数因子消去
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_149_modular_cycle_constraint
# 式ペア: 100 and 8510933340 divide 44*d implies 10638666675 divides d
# 帰属: ZZ と NN だけを用いる

additional_cycle_order = ZZ(100)
prior_cycle_divisor = ZZ(8510933340)
irreducible_degree = ZZ(44)
combined_cycle_divisor = lcm(additional_cycle_order, prior_cycle_divisor)
required_quotient_factor = ZZ(10638666675)

assert combined_cycle_divisor == 42554666700
assert gcd(combined_cycle_divisor, irreducible_degree) == 4
assert combined_cycle_divisor // gcd(combined_cycle_divisor, irreducible_degree) == required_quotient_factor
assert gcd(required_quotient_factor, ZZ(11)) == 1
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 468101333700
assert required_quotient_factor.factor() == factor(ZZ(3^2 * 5^2 * 7 * 13 * 19 * 23 * 29 * 41))

remaining_factor = factorial(43) // required_quotient_factor
assert remaining_factor in NN
assert required_quotient_factor * remaining_factor == factorial(43)
assert ZZ(468101333700) * remaining_factor == irreducible_degree * factorial(43)

print(
    "RESULT: PASS — the order-100 constraint and the prior divisor "
    "8510933340 force the splitting-field degree to have the form 468101333700*i"
)
