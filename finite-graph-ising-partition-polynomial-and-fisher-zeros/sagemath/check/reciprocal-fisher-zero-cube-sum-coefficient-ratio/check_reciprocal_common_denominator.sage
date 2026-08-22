# 対象ラベル: theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: -A^3/B^3 + 3AC/B^2 - 3D/B = -A^3/B^3 + 3BAC/B^3 - 3B^2D/B^3

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    constant, first, second, third = (QQ(polynomial[offset]) for offset in range(4))
    left = -first**3 / constant**3 + 3 * first * second / constant**2 - 3 * third / constant
    right = -first**3 / constant**3 + 3 * constant * first * second / constant**3 - 3 * constant**2 * third / constant**3
    assert left == right, data["name"]

print("RESULT: PASS — the nonzero constant coefficient gives a common cubic denominator")
