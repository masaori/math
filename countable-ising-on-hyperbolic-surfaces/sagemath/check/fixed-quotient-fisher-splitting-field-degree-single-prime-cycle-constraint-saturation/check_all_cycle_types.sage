# SageMath: 四十四根上の全巡回型に対する単一置換位数制約の飽和
# 対象ラベル: theorem_fixed_quotient_fisher_splitting_field_degree_single_prime_cycle_constraint_saturation
# 帰属: NN と ZZ だけを用いる

root_count = ZZ(44)
existing_degree_divisor = ZZ(856326196254765600)
existing_quotient_factor = ZZ(214081549063691400)
universal_permutation_order_multiple = lcm(
    [ZZ(length) for length in range(1, root_count + 1)]
)
checked_cycle_type_count = ZZ(0)
cycle_orders = set()
resulting_quotient_factors = set()

for cycle_type in Partitions(root_count):
    cycle_order = lcm([ZZ(length) for length in cycle_type])
    combined_degree_divisor = lcm(existing_degree_divisor, cycle_order)
    quotient_factor = combined_degree_divisor // gcd(
        combined_degree_divisor,
        root_count,
    )

    assert cycle_order.divides(universal_permutation_order_multiple)
    assert existing_degree_divisor.divides(combined_degree_divisor)
    assert combined_degree_divisor.divides(universal_permutation_order_multiple)

    checked_cycle_type_count += 1
    cycle_orders.add(cycle_order)
    resulting_quotient_factors.add(quotient_factor)

assert checked_cycle_type_count == 75175
assert len(cycle_orders) == 678
assert resulting_quotient_factors == {existing_quotient_factor}

print(
    "RESULT: PASS — all 75175 cycle types on 44 roots, comprising 678 distinct "
    "orders, leave the forced divisor of d equal to 214081549063691400"
)
