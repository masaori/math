# SageMath: 131 進分解型を加えた分解体次数の整数因子消去
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_131_modular_cycle_constraint
# 式ペア: 82 and 207583740 divide 44*d implies 2127733335 divides d
# 帰属: ZZ と NN だけを用いる

additional_cycle_order = ZZ(82)
prior_cycle_divisor = ZZ(207583740)
irreducible_degree = ZZ(44)
combined_cycle_divisor = lcm(additional_cycle_order, prior_cycle_divisor)
required_quotient_factor = ZZ(2127733335)

assert combined_cycle_divisor == 8510933340
assert gcd(combined_cycle_divisor, irreducible_degree) == 4
assert combined_cycle_divisor // gcd(combined_cycle_divisor, irreducible_degree) == required_quotient_factor
assert gcd(required_quotient_factor, ZZ(11)) == 1
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 93620266740
assert required_quotient_factor.factor() == factor(ZZ(3^2 * 5 * 7 * 13 * 19 * 23 * 29 * 41))

remaining_factor = factorial(43) // required_quotient_factor
assert remaining_factor in NN
assert required_quotient_factor * remaining_factor == factorial(43)
assert ZZ(93620266740) * remaining_factor == irreducible_degree * factorial(43)

print(
    "RESULT: PASS — the order-82 constraint and the prior divisor "
    "207583740 force the splitting-field degree to have the form 93620266740*h"
)
