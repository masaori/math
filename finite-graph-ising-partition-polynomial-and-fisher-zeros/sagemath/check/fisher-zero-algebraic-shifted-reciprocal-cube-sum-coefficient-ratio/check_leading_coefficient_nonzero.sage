# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: the QQ-to-QQbar image of the nonzero leading coefficient is nonzero
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    rational_leading_coefficient = QQ(data["multiplicities"][data["degree"]])
    algebraic_leading_coefficient = QQbar(rational_leading_coefficient)
    assert rational_leading_coefficient != 0, data["name"]
    assert algebraic_leading_coefficient != 0, data["name"]
print("RESULT: PASS — the QQ-to-QQbar image of every leading coefficient is nonzero")
