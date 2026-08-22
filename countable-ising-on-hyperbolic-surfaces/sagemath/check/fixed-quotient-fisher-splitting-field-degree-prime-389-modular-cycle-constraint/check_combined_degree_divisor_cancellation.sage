# SageMath: 389 進分解型を加えた分解体次数の整数因子消去
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint
# 式ペア: 43 and 9957281351799600 divide 44*d implies 107040774531845700 divides d
# 帰属: ZZ と NN だけを用いる

additional_cycle_order = ZZ(43)
prior_cycle_divisor = ZZ(9957281351799600)
irreducible_degree = ZZ(44)
combined_cycle_divisor = lcm(additional_cycle_order, prior_cycle_divisor)
required_quotient_factor = ZZ(107040774531845700)

assert combined_cycle_divisor == 428163098127382800
assert gcd(combined_cycle_divisor, irreducible_degree) == 4
assert combined_cycle_divisor // gcd(combined_cycle_divisor, irreducible_degree) == required_quotient_factor
assert gcd(required_quotient_factor, ZZ(11)) == 1
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 4709794079401210800

remaining_factor = factorial(43) // required_quotient_factor
assert remaining_factor in NN
assert required_quotient_factor * remaining_factor == factorial(43)
assert ZZ(4709794079401210800) * remaining_factor == irreducible_degree * factorial(43)

print(
    "RESULT: PASS — the order-43 constraint and the prior divisor "
    "9957281351799600 force the splitting-field degree to have the form 4709794079401210800*t"
)
