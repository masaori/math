# 対象ラベル: theorem_reciprocal_fisher_zero_square_sum_coefficient_ratio
# 式ペア: (sum alpha^-1)^2 - 2 sum alpha_i^-1 alpha_j^-1 = (-Omega(1)/Omega(0))^2 - 2 Omega(2)/Omega(0)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-square-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    polynomial = data["polynomial"]
    constant = QQ(polynomial[0])
    linear = QQ(polynomial[1])
    quadratic = QQ(polynomial[2])
    reciprocal_sum = sum((alpha**(-1) for alpha in roots), QQbar(0))
    left = reciprocal_sum**2 - 2 * reciprocal_pair_sum(roots)
    right = (-linear / constant)**2 - 2 * quadratic / constant
    assert left == QQbar(right), data["name"]

print("RESULT: PASS — the first two reciprocal elementary symmetric ratios substitute exactly")
