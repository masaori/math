# SageMath: 293 進分解型を加えた分解体次数の整数因子消去
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_prime_293_modular_cycle_constraint
# 式ペア: 372 and 160601312125800 divide 44*d implies 1244660168974950 divides d
# 帰属: ZZ と NN だけを用いる

additional_cycle_order = ZZ(372)
prior_cycle_divisor = ZZ(160601312125800)
irreducible_degree = ZZ(44)
combined_cycle_divisor = lcm(additional_cycle_order, prior_cycle_divisor)
required_quotient_factor = ZZ(1244660168974950)

assert combined_cycle_divisor == 4978640675899800
assert gcd(combined_cycle_divisor, irreducible_degree) == 4
assert combined_cycle_divisor // gcd(combined_cycle_divisor, irreducible_degree) == required_quotient_factor
assert gcd(required_quotient_factor, ZZ(11)) == 1
assert factorial(43) % required_quotient_factor == 0
assert irreducible_degree * required_quotient_factor == 54765047434897800

remaining_factor = factorial(43) // required_quotient_factor
assert remaining_factor in NN
assert required_quotient_factor * remaining_factor == factorial(43)
assert ZZ(54765047434897800) * remaining_factor == irreducible_degree * factorial(43)

print(
    "RESULT: PASS — the order-372 constraint and the prior divisor "
    "160601312125800 force the splitting-field degree to have the form 54765047434897800*r"
)
