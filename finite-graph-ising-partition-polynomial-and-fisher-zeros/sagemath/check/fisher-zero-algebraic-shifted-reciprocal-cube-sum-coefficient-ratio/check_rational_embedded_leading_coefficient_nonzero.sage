# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: the NN-to-QQ image of the leading multiplicity is nonzero
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    leading_multiplicity = data["multiplicities"][data["degree"]]
    rational_leading_coefficient = QQ(leading_multiplicity)
    assert leading_multiplicity != 0, data["name"]
    assert rational_leading_coefficient != 0, data["name"]
print("RESULT: PASS — the NN-to-QQ image of every leading multiplicity is nonzero")
