# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_square_sum_coefficient_ratio
# 式ペア: iota(eta(Omega)) iota(eta(m)) iota(eta(m-1)) = iota(eta(Omega) eta(m) eta(m-1))
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-square-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for exponent in range(2, data["edge_count"] + 1):
        multiplicity = data["multiplicities"][exponent]
        left = QQbar(QQ(multiplicity)) * QQbar(QQ(exponent)) * QQbar(QQ(exponent - 1))
        right = QQbar(QQ(multiplicity) * QQ(exponent) * QQ(exponent - 1))
        assert left == right, (data["name"], exponent)
print("RESULT: PASS — the rational-to-algebraic embedding preserves the three-factor product")
