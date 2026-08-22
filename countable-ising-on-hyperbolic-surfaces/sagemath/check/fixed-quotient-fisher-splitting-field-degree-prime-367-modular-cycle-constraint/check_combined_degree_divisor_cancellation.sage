# SageMath: 367 進分解型を加えた分解体次数の整数因子消去
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_367_modular_cycle_constraint
# 式ペア: 560 and 4978640675899800 divide 44*d implies 2489320337949900 divides d
# 帰属: ZZ と NN だけを用いる

additional_cycle_order = ZZ(560)
prior_cycle_divisor = ZZ(4978640675899800)
irreducible_degree = ZZ(44)
combined_cycle_divisor = lcm(additional_cycle_order, prior_cycle_divisor)
required_quotient_factor = ZZ(2489320337949900)

assert combined_cycle_divisor == 9957281351799600
assert gcd(combined_cycle_divisor, irreducible_degree) == 4
assert combined_cycle_divisor // gcd(combined_cycle_divisor, irreducible_degree) == required_quotient_factor
assert gcd(required_quotient_factor, ZZ(11)) == 1
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 109530094869795600

remaining_factor = factorial(43) // required_quotient_factor
assert remaining_factor in NN
assert required_quotient_factor * remaining_factor == factorial(43)
assert ZZ(109530094869795600) * remaining_factor == irreducible_degree * factorial(43)

print(
    "RESULT: PASS — the order-560 constraint and the prior divisor "
    "4978640675899800 force the splitting-field degree to have the form 109530094869795600*s"
)
