# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: C/P = P^2 C/P^3
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        P = data["polynomial"](a)
        if P != 0:
            C = coefficient_sum(data, a, 3)
            assert C / P == P**2 * C / P**3, (data["name"], a)
print("RESULT: PASS — multiplying numerator and denominator by the nonzero square preserves the first quotient")
