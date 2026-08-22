# SageMath: 二つの有限体分解型による分解体次数の整数因子消去
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_two_modular_cycle_constraints
# 式ペア: 1596 and 2990 divide 44*d implies 596505 divides d
# 帰属: ZZ と NN だけを用いる

first_cycle_order = ZZ(1596)
second_cycle_order = ZZ(2990)
irreducible_degree = ZZ(44)
combined_cycle_divisor = lcm(first_cycle_order, second_cycle_order)
required_quotient_factor = ZZ(596505)

assert combined_cycle_divisor == 2386020
assert gcd(combined_cycle_divisor, irreducible_degree) == 4
assert combined_cycle_divisor // gcd(combined_cycle_divisor, irreducible_degree) == required_quotient_factor
assert gcd(required_quotient_factor, ZZ(11)) == 1
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 26246220
assert required_quotient_factor.factor() == factor(ZZ(3 * 5 * 7 * 13 * 19 * 23))

remaining_factor = factorial(43) // required_quotient_factor
assert remaining_factor in NN
assert required_quotient_factor * remaining_factor == factorial(43)
assert ZZ(26246220) * remaining_factor == irreducible_degree * factorial(43)

print(
    "RESULT: PASS — the order-1596 and order-2990 constraints force "
    "the splitting-field degree to have the form 26246220*f"
)
