# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: -A^3/B^3 + 3BAC/B^3 - 3B^2D/B^3 = (-A^3 + 3BAC - 3B^2D)/B^3

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial, degree = data["polynomial"], data["degree"]
    leading, first, second, third = (QQ(polynomial[degree - offset]) for offset in range(4))
    left = -first**3 / leading**3 + 3 * leading * first * second / leading**3 - 3 * leading**2 * third / leading**3
    right = (-first**3 + 3 * leading * first * second - 3 * leading**2 * third) / leading**3
    assert left == right, data["name"]

print("RESULT: PASS — combining equal denominators gives the Fisher-zero cube-sum coefficient ratio")
