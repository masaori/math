# SageMath: 163 進分解型を加えた分解体次数の整数因子消去
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_163_modular_cycle_constraint
# 式ペア: 222 and 42554666700 divide 44*d implies 393630666975 divides d
# 帰属: ZZ と NN だけを用いる

additional_cycle_order = ZZ(222)
prior_cycle_divisor = ZZ(42554666700)
irreducible_degree = ZZ(44)
combined_cycle_divisor = lcm(additional_cycle_order, prior_cycle_divisor)
required_quotient_factor = ZZ(393630666975)

assert combined_cycle_divisor == 1574522667900
assert gcd(combined_cycle_divisor, irreducible_degree) == 4
assert combined_cycle_divisor // gcd(combined_cycle_divisor, irreducible_degree) == required_quotient_factor
assert gcd(required_quotient_factor, ZZ(11)) == 1
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 17319749346900

remaining_factor = factorial(43) // required_quotient_factor
assert remaining_factor in NN
assert required_quotient_factor * remaining_factor == factorial(43)
assert ZZ(17319749346900) * remaining_factor == irreducible_degree * factorial(43)

print(
    "RESULT: PASS — the order-222 constraint and the prior divisor "
    "42554666700 force the splitting-field degree to have the form 17319749346900*j"
)
