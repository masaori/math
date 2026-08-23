# SageMath: 単一有限体分解型による分解体次数制約の整数因子飽和
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_single_prime_cycle_constraint_saturation
# 帰属: ZZ と NN だけを用いる

existing_degree_divisor = ZZ(856326196254765600)
irreducible_degree = ZZ(44)
existing_quotient_factor = ZZ(214081549063691400)
universal_permutation_order_multiple = lcm([ZZ(length) for length in range(1, 45)])

assert universal_permutation_order_multiple == 9419588158802421600
assert universal_permutation_order_multiple == 11 * existing_degree_divisor
assert ZZ(11).is_prime()

combined_degree_divisors = [
    existing_degree_divisor,
    universal_permutation_order_multiple,
]
quotient_factors = [
    combined_degree_divisor // gcd(combined_degree_divisor, irreducible_degree)
    for combined_degree_divisor in combined_degree_divisors
]

assert gcd(existing_degree_divisor, irreducible_degree) == 4
assert gcd(universal_permutation_order_multiple, irreducible_degree) == 44
assert quotient_factors == [existing_quotient_factor, existing_quotient_factor]
assert existing_degree_divisor // 4 == existing_quotient_factor
assert universal_permutation_order_multiple // 44 == existing_quotient_factor

print(
    "RESULT: PASS — the only combined divisors between D and lcm(1,...,44) "
    "both force exactly 214081549063691400 to divide d"
)
