# SageMath: 103 進分解型を加えた分解体次数の整数因子消去
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_103_modular_cycle_constraint
# 式ペア: 1044 and 2386020 divide 44*d implies 51895935 divides d
# 帰属: ZZ と NN だけを用いる

additional_cycle_order = ZZ(1044)
prior_cycle_divisor = ZZ(2386020)
irreducible_degree = ZZ(44)
combined_cycle_divisor = lcm(additional_cycle_order, prior_cycle_divisor)
required_quotient_factor = ZZ(51895935)

assert combined_cycle_divisor == 207583740
assert gcd(combined_cycle_divisor, irreducible_degree) == 4
assert combined_cycle_divisor // gcd(combined_cycle_divisor, irreducible_degree) == required_quotient_factor
assert gcd(required_quotient_factor, ZZ(11)) == 1
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 2283421140
assert required_quotient_factor.factor() == factor(ZZ(3^2 * 5 * 7 * 13 * 19 * 23 * 29))

remaining_factor = factorial(43) // required_quotient_factor
assert remaining_factor in NN
assert required_quotient_factor * remaining_factor == factorial(43)
assert ZZ(2283421140) * remaining_factor == irreducible_degree * factorial(43)

print(
    "RESULT: PASS — the order-1044 constraint and the prior divisor "
    "2386020 force the splitting-field degree to have the form 2283421140*g"
)
