# 対象ラベル: theorem_fisher_zero_square_sum_coefficient_ratio
# 式ペア: (-Omega(d-1)/Omega(d))^2 - 2 Omega(d-2)/Omega(d) = Omega(d-1)^2/Omega(d)^2 - 2 Omega(d-2)/Omega(d)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    leading = QQ(polynomial[degree])
    next_coefficient = QQ(polynomial[degree - 1])
    second_next_coefficient = QQ(polynomial[degree - 2])
    left = (-next_coefficient / leading)**2 - 2 * second_next_coefficient / leading
    right = next_coefficient**2 / leading**2 - 2 * second_next_coefficient / leading
    assert left == right, data["name"]

print("RESULT: PASS — squaring the negative coefficient quotient removes the sign exactly")
