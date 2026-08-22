# 対象ラベル: theorem_reciprocal_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: common-denominator terms combine to the stated reciprocal fourth-power-sum coefficient ratio
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    polynomial = data["polynomial"]
    B, A1, A2, A3, A4 = (QQ(polynomial[offset]) for offset in range(5))
    left = ((A1**4 - 3 * B * A1**2 * A2 + 3 * B**2 * A1 * A3) / B**4
            + (-B * A1**2 * A2 + 2 * B**2 * A2**2) / B**4
            + B**2 * A1 * A3 / B**4
            - 4 * B**3 * A4 / B**4)
    right = (A1**4 - 4 * B * A1**2 * A2 + 2 * B**2 * A2**2 + 4 * B**2 * A1 * A3 - 4 * B**3 * A4) / B**4
    assert left == right, data["name"]
print("RESULT: PASS — equal-denominator terms combine to the reciprocal fourth-power-sum coefficient ratio")
