# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: D^2 Pbar_G(a) = B_G(a)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for a in algebraic_evaluation_points:
        second_coefficient_sum = sum(
            (
                QQbar(QQ(exponent * (exponent - 1) * data["multiplicities"][exponent]))
                * a ** (exponent - 2)
                for exponent in range(2, data["edge_count"] + 1)
            ),
            QQbar(0),
        )
        assert data["polynomial"].derivative().derivative()(a) == second_coefficient_sum, (data["name"], a)
print("RESULT: PASS — evaluating the second formal derivative gives the defined second coefficient sum")
