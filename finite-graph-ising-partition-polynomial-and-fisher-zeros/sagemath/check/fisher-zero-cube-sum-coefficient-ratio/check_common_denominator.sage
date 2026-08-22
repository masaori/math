# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: -A^3/B^3 + 3AC/B^2 - 3D/B = -A^3/B^3 + 3BAC/B^3 - 3B^2D/B^3

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial, degree = data["polynomial"], data["degree"]
    leading, first, second, third = (QQ(polynomial[degree - offset]) for offset in range(4))
    left = -first**3 / leading**3 + 3 * first * second / leading**2 - 3 * third / leading
    right = -first**3 / leading**3 + 3 * leading * first * second / leading**3 - 3 * leading**2 * third / leading**3
    assert left == right, data["name"]

print("RESULT: PASS — the nonzero leading coefficient gives a common cubic denominator")
