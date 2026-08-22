# 対象ラベル: theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: (-A/B)^3 - 3(-A/B)(C/B) + 3(-D/B) = -A^3/B^3 + 3AC/B^2 - 3D/B

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    constant, first, second, third = (QQ(polynomial[offset]) for offset in range(4))
    left = (-first / constant)**3 - 3 * (-first / constant) * (second / constant) + 3 * (-third / constant)
    right = -first**3 / constant**3 + 3 * first * second / constant**2 - 3 * third / constant
    assert left == right, data["name"]

print("RESULT: PASS — the signed reciprocal coefficient products simplify exactly")
