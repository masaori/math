# 対象ラベル: theorem_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: (-A/B)^3 - 3(-A/B)(C/B) + 3(-D/B) = -A^3/B^3 + 3AC/B^2 - 3D/B

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial, degree = data["polynomial"], data["degree"]
    leading, first, second, third = (QQ(polynomial[degree - offset]) for offset in range(4))
    left = (-first / leading)**3 - 3 * (-first / leading) * (second / leading) + 3 * (-third / leading)
    right = -first**3 / leading**3 + 3 * first * second / leading**2 - 3 * third / leading
    assert left == right, data["name"]

print("RESULT: PASS — signed quotient products simplify exactly")
