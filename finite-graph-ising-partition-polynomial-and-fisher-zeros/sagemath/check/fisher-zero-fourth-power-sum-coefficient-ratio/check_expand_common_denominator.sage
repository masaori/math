# 対象ラベル: theorem_fisher_zero_fourth_power_sum_coefficient_ratio
# 式ペア: expanded products moved to the common fourth-power denominator

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-fourth-power-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial, degree = data["polynomial"], data["degree"]
    B, A1, A2, A3, A4 = (QQ(polynomial[degree - offset]) for offset in range(5))
    left = ((A1**4 - 3 * B * A1**2 * A2 + 3 * B**2 * A1 * A3) / B**4
            + (-A1**2 * A2 + 2 * B * A2**2) / B**3
            + A1 * A3 / B**2
            - 4 * A4 / B)
    right = ((A1**4 - 3 * B * A1**2 * A2 + 3 * B**2 * A1 * A3) / B**4
             + (-B * A1**2 * A2 + 2 * B**2 * A2**2) / B**4
             + B**2 * A1 * A3 / B**4
             - 4 * B**3 * A4 / B**4)
    assert left == right, data["name"]

print("RESULT: PASS — the nonzero leading coefficient gives a common fourth-power denominator")
